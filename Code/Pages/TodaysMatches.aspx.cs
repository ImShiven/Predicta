using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Pages_TodaysMatches : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        DataLayer dac = new DataLayer();
        dt = dac.GetMatchScheduleData();

        GridView1.DataSource = dt;
        GridView1.DataBind();
    }
}