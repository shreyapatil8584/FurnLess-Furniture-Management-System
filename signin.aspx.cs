using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class signin : System.Web.UI.Page
{
    public static String cs = ConfigurationManager.ConnectionStrings["furnlessDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["UNAME"] != null && Request.Cookies["UPWD"] != null)
            {
                txtUsername.Text = Request.Cookies["UNAME"].Value;
                txtPass.Attributes["value"] = Request.Cookies["UPWD"].Value;
                CheckBox1.Checked = true;
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("Select * from tblUsers where Username=@username and Password = @pwd", con);
            cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@pwd", txtPass.Text.Trim());

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count != 0)
            {
                Session["USERID"] = dt.Rows[0]["Uid"].ToString();
                Session["USEREMAIL"] = dt.Rows[0]["Email"].ToString();
                Session["Username"] = dt.Rows[0]["Username"].ToString();

                if (CheckBox1.Checked)
                {
                    Response.Cookies["UNAME"].Value = txtUsername.Text;
                    Response.Cookies["UPWD"].Value = txtPass.Text;
                    Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(10);
                    Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(10);
                }
                else
                {
                    Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(-1);
                }

                string Utype = dt.Rows[0]["Usertype"].ToString().Trim();

                if (Utype == "User")
                {
                    // Cart Migration Logic: Move guest items to user-specific cookie
                    if (Request.Cookies["CartPID"] != null)
                    {
                        string guestCookieData = "";
                        if (Request.Cookies["CartPID"].Value.Contains("="))
                        {
                            guestCookieData = Request.Cookies["CartPID"].Value.Split('=')[1];
                        }
                        else
                        {
                            guestCookieData = Request.Cookies["CartPID"].Value;
                        }

                        if (!string.IsNullOrEmpty(guestCookieData))
                        {
                            string userCartCookieName = "CartPID_" + Session["USERID"].ToString();
                            string userCookieData = "";

                            // If user already has a cart, merge them
                            if (Request.Cookies[userCartCookieName] != null)
                            {
                                if (Request.Cookies[userCartCookieName].Value.Contains("="))
                                {
                                    userCookieData = Request.Cookies[userCartCookieName].Value.Split('=')[1];
                                }
                                else
                                {
                                    userCookieData = Request.Cookies[userCartCookieName].Value;
                                }

                                List<string> combinedItems = guestCookieData.Split(',').ToList();
                                List<string> existingItems = userCookieData.Split(',').ToList();

                                foreach (string item in existingItems)
                                {
                                    if (!combinedItems.Contains(item))
                                    {
                                        combinedItems.Add(item);
                                    }
                                }
                                userCookieData = string.Join(",", combinedItems);
                            }
                            else
                            {
                                userCookieData = guestCookieData;
                            }

                            // Write to user-specific cookie
                            HttpCookie userCartCookie = new HttpCookie(userCartCookieName);
                            userCartCookie.Value = "CartPID=" + userCookieData;
                            userCartCookie.Expires = DateTime.Now.AddDays(30);
                            Response.Cookies.Add(userCartCookie);

                            // Clear guest cookie
                            HttpCookie guestCookie = Request.Cookies["CartPID"];
                            guestCookie.Expires = DateTime.Now.AddDays(-1);
                            Response.Cookies.Add(guestCookie);
                        }
                    }

                    if (Request.QueryString["rurl"] != null)
                    {
                        if (Request.QueryString["rurl"] == "cart")
                        {
                            Response.Redirect("~/Cart.aspx");
                        }
                    }
                    else
                    {
                        Response.Redirect("~/UserHome.aspx");
                    }
                }
                else if (Utype == "Admin")
                {
                    Response.Redirect("~/AdminHome.aspx");
                }
            }
            else
            {
                lblError.Text = "Invalid User Name and Password";
            }
        }
    }

    public void clr()
    {
        txtPass.Text = String.Empty;
        txtUsername.Text = String.Empty;
        txtUsername.Focus();
    }
}
