using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class UserManagement : System.Web.UI.Page
{
    public static String CS = ConfigurationManager.ConnectionStrings["furnlessDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
        {
            Response.Redirect("~/signin.aspx");
        }
        
        if (!IsPostBack)
        {
            BindUsers();
        }
    }

    private void BindUsers()
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            // Fetch all users who are customers (Usertype = 'User')
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM tblUsers WHERE Usertype = 'User' ORDER BY Uid DESC", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrUsers.DataSource = dt;
                    rptrUsers.DataBind();
                }
            }
        }
    }
}
