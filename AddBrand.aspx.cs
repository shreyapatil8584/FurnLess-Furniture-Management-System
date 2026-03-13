using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class AddBrand : System.Web.UI.Page
{
    public static String CS = ConfigurationManager.ConnectionStrings["furnlessDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("~/signin.aspx");

        if (!IsPostBack)
        {
            BindBrandRepeater();
        }
    }

    private void BindBrandRepeater()
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM tblBrands ORDER BY BrandID DESC", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrBrands.DataSource = dt;
                    rptrBrands.DataBind();
                }
            }
        }
    }

    protected void btnAddBrand_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            con.Open();
            string query = "";
            bool isUpdate = !string.IsNullOrEmpty(hfBrandID.Value);

            if (isUpdate)
            {
                query = "UPDATE tblBrands SET Name = @Name WHERE BrandID = @ID";
            }
            else
            {
                query = "INSERT INTO tblBrands(Name) VALUES(@Name)";
            }

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Name", txtBrand.Text.Trim());
                if (isUpdate)
                {
                    cmd.Parameters.AddWithValue("@ID", hfBrandID.Value);
                }
                cmd.ExecuteNonQuery();
            }
        }
        
        string msg = String.IsNullOrEmpty(hfBrandID.Value) ? "Brand Added Successfully" : "Brand Updated Successfully";
        Response.Write("<script>alert('" + msg + "')</script>");
        
        ClearForm();
        BindBrandRepeater();
    }

    protected void rptrBrands_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string brandId = e.CommandArgument.ToString();

        if (e.CommandName == "EditBrand")
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Name FROM tblBrands WHERE BrandID = @ID", con))
                {
                    cmd.Parameters.AddWithValue("@ID", brandId);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        txtBrand.Text = result.ToString();
                        hfBrandID.Value = brandId;
                        btnAddBrand.Text = "Update Brand";
                        btnCancel.Visible = true;
                    }
                }
            }
        }
        else if (e.CommandName == "DeleteBrand")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(CS))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM tblBrands WHERE BrandID = @ID", con))
                    {
                        cmd.Parameters.AddWithValue("@ID", brandId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindBrandRepeater();
                Response.Write("<script>alert('Brand Deleted Successfully')</script>");
            }
            catch (SqlException ex)
            {
                if (ex.Number == 547)
                {
                    Response.Write("<script>alert('Cannot delete: This Brand is currently used by Products or Sizes. Please delete them first.')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "')</script>");
                }
            }
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearForm();
    }

    private void ClearForm()
    {
        txtBrand.Text = String.Empty;
        hfBrandID.Value = String.Empty;
        btnAddBrand.Text = "Add Brand";
        btnCancel.Visible = false;
        txtBrand.Focus();
    }
}