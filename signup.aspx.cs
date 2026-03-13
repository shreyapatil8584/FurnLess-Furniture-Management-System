using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class signup : System.Web.UI.Page
{
    public static String cs = ConfigurationManager.ConnectionStrings["furnlessDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void txtsignup_Click(object sender, EventArgs e)
    {
        if (isformvalid())
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Insert into tblUsers(Username,Password,Email,Name,Usertype) values(@Uname, @Pass, @Email, @Name, 'User')", con);
                cmd.Parameters.AddWithValue("@Uname", txtUname.Text.Trim());
                cmd.Parameters.AddWithValue("@Pass", txtPass.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();

                lblMsg.Text = "Registration Successfully Done";
                lblMsg.ForeColor = System.Drawing.Color.Green;

                // Success message and redirect
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Registration Successful!');window.location ='signin.aspx';", true);
                clr();
            }
        }
        else
        {
            lblMsg.Text = "Registration Failed";
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }

    private bool isformvalid()
    {
        if (txtUname.Text == "")
        {
            lblMsg.Text = "Username is required";
            txtUname.Focus();
            return false;
        }
        else if (txtPass.Text != txtCPass.Text)
        {
            lblMsg.Text = "Passwords do not match";
            txtPass.Focus();
            return false;
        }
        else if (txtEmail.Text == "")
        {
            lblMsg.Text = "Email is required";
            txtEmail.Focus();
            return false;
        }
        else if (txtName.Text == "")
        {
            lblMsg.Text = "Name is required";
            txtName.Focus();
            return false;
        }
        return true;
    }

    private void clr()
    {
        txtName.Text = string.Empty;
        txtPass.Text = string.Empty;
        txtUname.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtCPass.Text = string.Empty;
    }
}