using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class About : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] != null)
        {
            btnsignup.Visible = false;
            btnsignin.Visible = false;
            btnlogout.Visible = true;
            btnlogout.Text = "👤 " + Session["Username"].ToString() + " →";
            btnlogout.CssClass = "btn btn-logout navbar-btn";
        }
        else
        {
            btnsignup.Visible = true;
            btnsignin.Visible = true;
            btnlogout.Visible = false;
        }
        BindCartNumber();
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

    protected void btnlogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Session["Username"] = null;
        Session["USERID"] = null;
        Response.Redirect("~/index.aspx");
    }
}
