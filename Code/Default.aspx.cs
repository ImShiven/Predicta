using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Pages/HomePage.aspx");
        }
        catch (Exception ex)
        {

            throw;
        }
        //Response.Redirect(Server.MapPath("~/Pages/HomePage.aspx"));
    }
}