using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class AddCategory : System.Web.UI.Page
{
    public static String CS = ConfigurationManager.ConnectionStrings["furnlessDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("~/signin.aspx");

        if (!IsPostBack)
        {
            BindCategoryRepeater();
        }
    }

    private void BindCategoryRepeater()
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM tblCategory ORDER BY CatID DESC", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrCategory.DataSource = dt;
                    rptrCategory.DataBind();
                }
            }
        }
    }

    protected void btnAddCategory_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            con.Open();
            string query = "";
            bool isUpdate = !string.IsNullOrEmpty(hfCatID.Value);

            if (isUpdate)
            {
                query = "UPDATE tblCategory SET CatName = @Name WHERE CatID = @ID";
            }
            else
            {
                query = "INSERT INTO tblCategory(CatName) VALUES(@Name)";
            }

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Name", txtCategory.Text.Trim());
                if (isUpdate)
                {
                    cmd.Parameters.AddWithValue("@ID", hfCatID.Value);
                }
                cmd.ExecuteNonQuery();
            }
        }
         string msg = String.IsNullOrEmpty(hfCatID.Value) ? "Category Added Successfully" : "Category Updated Successfully";
        Response.Write("<script>alert('" + msg + "')</script>");
        
        ClearForm();
        BindCategoryRepeater();
    }

    protected void rptrCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string catId = e.CommandArgument.ToString();

        if (e.CommandName == "EditCategory")
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT CatName FROM tblCategory WHERE CatID = @ID", con))
                {
                    cmd.Parameters.AddWithValue("@ID", catId);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        txtCategory.Text = result.ToString();
                        hfCatID.Value = catId;
                        btnAddCategory.Text = "Update Category";
                        btnCancel.Visible = true;
                    }
                }
            }
        }
        else if (e.CommandName == "DeleteCategory")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(CS))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM tblCategory WHERE CatID = @ID", con))
                    {
                        cmd.Parameters.AddWithValue("@ID", catId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindCategoryRepeater();
                Response.Write("<script>alert('Category Deleted Successfully')</script>");
            }
            catch (SqlException ex)
            {
                if (ex.Number == 547)
                {
                    Response.Write("<script>alert('Cannot delete: This Category is currently used by Sub-Categories, Products or Sizes. Please delete them first.')</script>");
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
        txtCategory.Text = String.Empty;
        hfCatID.Value = String.Empty;
        btnAddCategory.Text = "Add Category";
        btnCancel.Visible = false;
        txtCategory.Focus();
    }
}