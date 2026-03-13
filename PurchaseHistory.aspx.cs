using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class PurchaseHistory : System.Web.UI.Page
{
    public static String CS = ConfigurationManager.ConnectionStrings["furnlessDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] != null)
        {
            if (!IsPostBack)
            {
                BindPurchaseHistory();
            }
        }
        else
        {
            Response.Redirect("signin.aspx");
        }
    }

    private void BindPurchaseHistory()
    {
        if (Session["USERID"] != null)
        {
            string userId = Session["USERID"].ToString();
            
            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM tblPurchase WHERE UserID = @UserID ORDER BY DateOfPurchase DESC", con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        
                        if (dt.Rows.Count > 0)
                        {
                            rptrOrders.DataSource = dt;
                            rptrOrders.DataBind();

                            rptrExportOrders.DataSource = dt;
                            rptrExportOrders.DataBind();

                            pnlNoOrders.Visible = false;
                        }
                        else
                        {
                            rptrOrders.DataSource = null;
                            rptrOrders.DataBind();

                            rptrExportOrders.DataSource = null;
                            rptrExportOrders.DataBind();

                            pnlNoOrders.Visible = true;
                        }
                    }
                }
            }
        }
    }

    protected string GetStatusClass(string status)
    {
        switch (status.ToLower())
        {
            case "paid":
            case "delivered":
                return "status-delivered";
            case "notpaid":
            case "pending":
                return "status-pending";
            case "processing":
                return "status-processing";
            case "shipped":
                return "status-shipped";
            case "cancelled":
                return "status-cancelled";
            default:
                return "status-pending";
        }
    }

    protected string GetStatusText(string status)
    {
        switch (status.ToLower())
        {
            case "paid":
                return "✓ Paid";
            case "notpaid":
                return "⏳ Payment Pending";
            case "delivered":
                return "✓ Delivered";
            case "processing":
                return "⚙ Processing";
            case "shipped":
                return "🚚 Shipped";
            case "cancelled":
                return "✗ Cancelled";
            default:
                return "⏳ Pending";
        }
    }

    protected void btnViewDetails_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string purchaseId = btn.CommandArgument;
        Response.Redirect("OrderDetails.aspx?id=" + purchaseId);
    }

    protected void btnCancelOrder_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string purchaseId = btn.CommandArgument;
        
        using (SqlConnection con = new SqlConnection(CS))
        {
            using (SqlCommand cmd = new SqlCommand("UPDATE tblPurchase SET PaymentStatus = 'Cancelled' WHERE PurchaseID = @PurchaseID AND UserID = @UserID", con))
            {
                cmd.Parameters.AddWithValue("@PurchaseID", purchaseId);
                cmd.Parameters.AddWithValue("@UserID", Session["USERID"].ToString());
                
                con.Open();
                int result = cmd.ExecuteNonQuery();
                
                if (result > 0)
                {
                    lblMessage.Text = "Order cancelled successfully!";
                    lblMessage.CssClass = "alert alert-success";
                    BindPurchaseHistory(); // Refresh the list
                }
                else
                {
                    lblMessage.Text = "Failed to cancel order. Please try again.";
                    lblMessage.CssClass = "alert alert-danger";
                }
            }
        }
    }
    protected void btnDeleteOrder_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string purchaseId = btn.CommandArgument;
        
        using (SqlConnection con = new SqlConnection(CS))
        {
            using (SqlCommand cmd = new SqlCommand("DELETE FROM tblPurchase WHERE PurchaseID = @PurchaseID AND UserID = @UserID", con))
            {
                cmd.Parameters.AddWithValue("@PurchaseID", purchaseId);
                cmd.Parameters.AddWithValue("@UserID", Session["USERID"].ToString());
                
                con.Open();
                int result = cmd.ExecuteNonQuery();
                
                if (result > 0)
                {
                    lblMessage.Text = "Order deleted successfully!";
                    lblMessage.CssClass = "alert alert-success";
                    BindPurchaseHistory(); // Refresh the list
                }
                else
                {
                    lblMessage.Text = "Failed to delete order. Please try again.";
                    lblMessage.CssClass = "alert alert-danger";
                }
            }
        }
    }
}
