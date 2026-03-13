using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class AddGender : System.Web.UI.Page
{
    public static String CS = ConfigurationManager.ConnectionStrings["furnlessDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("~/signin.aspx");
            
        if (!IsPostBack)
        {
            BindGenderRptr();
        }
    }

    private void BindGenderRptr()
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            using (SqlCommand cmd = new SqlCommand("select * from tblGender ORDER BY GenderID DESC", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrGender.DataSource = dt;
                    rptrGender.DataBind();
                }
            }
        }
    }

    protected void btnAddGender_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            con.Open();
            string query = "";
            bool isUpdate = !string.IsNullOrEmpty(hfGenderID.Value);

             if (isUpdate)
            {
                query = "UPDATE tblGender SET GenderName = @Name WHERE GenderID = @ID";
            }
            else
            {
                query = "INSERT INTO tblGender(GenderName) VALUES(@Name)";
            }

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Name", txtGender.Text.Trim());
                if (isUpdate)
                {
                   cmd.Parameters.AddWithValue("@ID", hfGenderID.Value);
                }
                cmd.ExecuteNonQuery();
            }
        }
        
        string msg = String.IsNullOrEmpty(hfGenderID.Value) ? "Gender Added Successfully" : "Gender Updated Successfully";
        Response.Write("<script>alert('" + msg + "')</script>");
        
        ClearForm();
        BindGenderRptr();
    }
    
    protected void rptrGender_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string id = e.CommandArgument.ToString();

        if (e.CommandName == "EditGender")
        {
            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM tblGender WHERE GenderID = @ID", con))
                {
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();
                    object result = cmd.ExecuteScalar(); // Wait, scalar returns first column first row. Need name.
                     // Or just generic execute reader
                     
                     using(SqlDataReader reader = cmd.ExecuteReader())
                     {
                         if(reader.Read())
                         {
                             txtGender.Text = reader["GenderName"].ToString();
                             hfGenderID.Value = id;
                             btnAddGender.Text = "Update Gender";
                             btnCancel.Visible = true;
                         }
                     }
                }
            }
        }
        else if (e.CommandName == "DeleteGender")
        {
             try
             {
                 using (SqlConnection con = new SqlConnection(CS))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM tblGender WHERE GenderID = @ID", con))
                    {
                        cmd.Parameters.AddWithValue("@ID", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindGenderRptr();
                Response.Write("<script>alert('Gender Deleted Successfully')</script>");
             }
             catch (SqlException ex)
            {
                if (ex.Number == 547)
                {
                    Response.Write("<script>alert('Cannot delete: This Gender/Target is currently used by Sizes. Please delete them first.')</script>");
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
        txtGender.Text = String.Empty;
        hfGenderID.Value = String.Empty;
        btnAddGender.Text = "Add Gender";
        btnCancel.Visible = false;
        txtGender.Focus();
    }
}