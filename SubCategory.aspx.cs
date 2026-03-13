using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class SubCategory : System.Web.UI.Page
{
    public static String CS = ConfigurationManager.ConnectionStrings["furnlessDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("~/signin.aspx");

        if (!IsPostBack)
        {
            BindMainCat();
            BindSubCategoryRptr();
        }

    }

    private void BindSubCategoryRptr()
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            using (SqlCommand cmd = new SqlCommand("select A.*,B.CatName from tblSubCategory A inner join tblCategory B on B.CatID= A.MainCatID ORDER BY SubCatID DESC", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrSubCat.DataSource = dt;
                    rptrSubCat.DataBind();
                }
            }
        }
    }
    
    protected void btnAddSubCategory_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            con.Open();
            string query = "";
            bool isUpdate = !string.IsNullOrEmpty(hfSubCatID.Value);

             if (isUpdate)
            {
                query = "UPDATE tblSubCategory SET SubCatName = @Name, MainCatID = @MainID WHERE SubCatID = @ID";
            }
            else
            {
                query = "INSERT INTO tblSubCategory(SubCatName,MainCatID) VALUES(@Name, @MainID)";
            }

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Name", txtSubCategory.Text.Trim());
                cmd.Parameters.AddWithValue("@MainID", ddlMainCatID.SelectedValue);
                
                if (isUpdate)
                {
                   cmd.Parameters.AddWithValue("@ID", hfSubCatID.Value);
                }
                cmd.ExecuteNonQuery();
            }
        }
        
        string msg = String.IsNullOrEmpty(hfSubCatID.Value) ? "Sub-Category Added Successfully" : "Sub-Category Updated Successfully";
        Response.Write("<script>alert('" + msg + "')</script>");
        
        ClearForm();
        BindSubCategoryRptr();
    }
    
    protected void rptrSubCat_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string subCatId = e.CommandArgument.ToString();

        if (e.CommandName == "EditSubCategory")
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM tblSubCategory WHERE SubCatID = @ID", con))
                {
                    cmd.Parameters.AddWithValue("@ID", subCatId);
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    
                    if (dt.Rows.Count > 0)
                    {
                        txtSubCategory.Text = dt.Rows[0]["SubCatName"].ToString();
                        ddlMainCatID.SelectedValue = dt.Rows[0]["MainCatID"].ToString();
                        
                        hfSubCatID.Value = subCatId;
                        btnAddSubCategory.Text = "Update Sub-Category";
                        btnCancel.Visible = true;
                    }
                }
            }
        }
        else if (e.CommandName == "DeleteSubCategory")
        {
             try
             {
                 using (SqlConnection con = new SqlConnection(CS))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM tblSubCategory WHERE SubCatID = @ID", con))
                    {
                        cmd.Parameters.AddWithValue("@ID", subCatId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindSubCategoryRptr();
                Response.Write("<script>alert('Sub-Category Deleted Successfully')</script>");
             }
             catch (SqlException ex)
            {
                if (ex.Number == 547)
                {
                    Response.Write("<script>alert('Cannot delete: This Sub-Category is currently used by Products or Sizes. Please delete them first.')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "')</script>");
                }
            }
        }
    }
    
    private void  BindMainCat()
    {
         using (SqlConnection con = new SqlConnection(CS))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblCategory", con);
             SqlDataAdapter sda = new  SqlDataAdapter(cmd);
             DataTable dt = new DataTable();
             sda.Fill(dt);
             if(dt.Rows.Count !=0)
             {
                 ddlMainCatID.DataSource = dt;
                 ddlMainCatID.DataTextField="CatName";
                 ddlMainCatID.DataValueField="CatID";
                ddlMainCatID.DataBind();
                 ddlMainCatID.Items .Insert(0 ,new ListItem("-Select-","0"));
             }
        }
    }
    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearForm();
    }

    private void ClearForm()
    {
        txtSubCategory.Text = String.Empty;
        ddlMainCatID.SelectedIndex = 0;
        hfSubCatID.Value = String.Empty;
        btnAddSubCategory.Text = "Add Sub-Category";
        btnCancel.Visible = false;
    }
}