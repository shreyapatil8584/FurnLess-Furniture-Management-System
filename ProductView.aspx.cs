using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ProductView : System.Web.UI.Page
{
    public static String cs = ConfigurationManager.ConnectionStrings["furnlessDB"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["PID"] != null)
        {
            if (!IsPostBack)
            {
                BindProductImage();
                BindProductDetails();
            }
        }
        else
        {
            Response.Redirect("~/Product.aspx");
        }
    }

    private void BindProductImage()
    {
        Int64 PID = Convert.ToInt64(Request.QueryString["PID"]);
        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("select * from tblProductImages where PID =@PID", con))
            {
                cmd.Parameters.AddWithValue("@PID", PID);
                cmd.CommandType = CommandType.Text;
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrImage.DataSource = dt;
                    rptrImage.DataBind();
                }
            }
        }
    }

    private void BindProductDetails()
    {
        Int64 PID = Convert.ToInt64(Request.QueryString["PID"]);
        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("select * from tblProduct where PID =@PID", con))
            {
                cmd.Parameters.AddWithValue("@PID", PID);
                cmd.CommandType = CommandType.Text;
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrProductDetails.DataSource = dt;
                    rptrProductDetails.DataBind();
                }
            }
        }
    }

    protected string GetActiveImgClass(int ItemIndex)
    {
        return ItemIndex == 0 ? "active" : "";
    }

    protected void rptrProductDetails_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            HiddenField hfBrandID = (HiddenField)e.Item.FindControl("hfBrandID");
            HiddenField hfCatID = (HiddenField)e.Item.FindControl("hfCatID");
            HiddenField hfSubCatID = (HiddenField)e.Item.FindControl("hfSubCatID");
            HiddenField hfGenderID = (HiddenField)e.Item.FindControl("hfGenderID");
            RadioButtonList rblSize = (RadioButtonList)e.Item.FindControl("rblSize");

            if (hfBrandID != null && hfCatID != null && hfSubCatID != null && hfGenderID != null && rblSize != null)
            {
                string BrandID = hfBrandID.Value;
                string CatID = hfCatID.Value;
                string SubCatID = hfSubCatID.Value;
                string GenderID = hfGenderID.Value;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    using (SqlCommand cmd = new SqlCommand("select * from tblSizes where BrandID =@BrandID and CategoryID=@CatID and SubCategoryID=@SubCatID and GenderID=@GenderID", con))
                    {
                        cmd.Parameters.AddWithValue("@BrandID", BrandID);
                        cmd.Parameters.AddWithValue("@CatID", CatID);
                        cmd.Parameters.AddWithValue("@SubCatID", SubCatID);
                        cmd.Parameters.AddWithValue("@GenderID", GenderID);
                        cmd.CommandType = CommandType.Text;
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            rblSize.DataSource = dt;
                            rblSize.DataTextField = "SizeName";
                            rblSize.DataValueField = "SizeID";
                            rblSize.DataBind();
                        }
                    }
                }
            }
        }
    }

    protected void btnAddtoCart_Click(object sender, EventArgs e)
    {
        String SelectedSize = string.Empty;
        foreach (RepeaterItem item in rptrProductDetails.Items)
        {
            if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
            {
                var rbList = item.FindControl("rblSize") as RadioButtonList;
                SelectedSize = rbList.SelectedValue;
                var lblError = item.FindControl("lblError") as Label;
                lblError.Text = " ";
            }
        }

        if (SelectedSize != "")
        {
            Int64 PID = Convert.ToInt64(Request.QueryString["PID"]);
            string cartCookieName = Session["USERID"] != null ? "CartPID_" + Session["USERID"].ToString() : "CartPID";
            HttpCookie CartProducts = Request.Cookies[cartCookieName] ?? new HttpCookie(cartCookieName);
            string CookiePID = "";

            if (Request.Cookies[cartCookieName] != null)
            {
                if (Request.Cookies[cartCookieName].Value.Contains("="))
                {
                    CookiePID = Request.Cookies[cartCookieName].Value.Split('=')[1];
                }
                else
                {
                    CookiePID = Request.Cookies[cartCookieName].Value;
                }
            }

            if (string.IsNullOrEmpty(CookiePID))
            {
                CookiePID = PID.ToString() + "-" + SelectedSize;
            }
            else
            {
                CookiePID = CookiePID + "," + PID + "-" + SelectedSize;
            }

            CartProducts.Value = "CartPID=" + CookiePID;
            CartProducts.Expires = DateTime.Now.AddDays(30);
            Response.Cookies.Add(CartProducts);
            Response.Redirect("~/ProductView.aspx?PID=" + PID);
        }
        else
        {
            foreach (RepeaterItem item in rptrProductDetails.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    var lblError = item.FindControl("lblError") as Label;
                    lblError.Text = "Please Select a Size";
                }
            }
        }
    }
}
