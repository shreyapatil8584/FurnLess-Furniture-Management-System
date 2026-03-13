using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] != null)
        {
            //   lblSuccess.Text = "Login Success, Welcome " + Session["Username"].ToString();
            btnlogout.Visible = true;
            btnLogin.Visible = false;
        }
        else
        {
            // If no session, show login but don't redirect (allow guest access)
            btnlogout.Visible = false;
            btnLogin.Visible = true;
        }
        BindCartNumber();
    }
    protected void btnlogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Session["Username"] = null;
        Session["USERID"] = null;
        Response.Redirect("~/index.aspx");
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/signin.aspx");
    }

    public void BindCartNumber()
    {
        string cartCookieName = Session["USERID"] != null ? "CartPID_" + Session["USERID"].ToString() : "CartPID";
        if (Request.Cookies[cartCookieName] != null)
        {
            string CookiePID = "";
            if (Request.Cookies[cartCookieName].Value.Contains("="))
            {
                CookiePID = Request.Cookies[cartCookieName].Value.Split('=')[1];
            }
            else
            {
                CookiePID = Request.Cookies[cartCookieName].Value;
            }

            if (!string.IsNullOrEmpty(CookiePID))
            {
                string[] ProductArray = CookiePID.Split(',');
                pCount.InnerText = ProductArray.Length.ToString();
            }
            else
            {
                pCount.InnerText = "0";
            }
        }
        else
        {
            pCount.InnerText = "0";
        }
    }
}
