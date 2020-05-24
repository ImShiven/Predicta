using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


public partial class Pages_MakePredictions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {

            DataTable dt = new DataTable();
            DataLayer dac = new DataLayer();
            dt = dac.GetPlayersData();

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        catch (Exception)
        {

            throw;
        }


    }
}