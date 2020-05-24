using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;

public partial class Pages_HomePage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GetUserPredictedData();
        BindData();
    }
    protected void GetUserPredictedData()
    {
        try
        {
            //string jsondata = DataTableToJSONWithStringBuilder();
            DataLayer dl = new DataLayer();
            gvDashboard.DataSource = dl.GetUserPredictedDataForHome();
            gvDashboard.DataBind();
            hdnNames.Value = HttpContext.Current.Session["Names"].ToString();
        }
        catch (Exception)
        {

            throw;
        }

    }

    protected void lbdownload_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable result = new DataTable();
            DataLayer dac = new DataLayer();

            result = dac.GetExcelData();
            ExportToExcel(result, "Predicta_UserPredictions.xls");
        }
        catch (Exception)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);

        }

    }
    public void ExportToExcel(DataTable dt, string filename)
    {
        if (dt.Rows.Count > 0)
        {
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            DataGrid dgGrid = new DataGrid();
            dgGrid.DataSource = dt;
            dgGrid.DataBind();

            //Get the HTML for the control.
            dgGrid.RenderControl(hw);
            //Write the HTML back to the browser.
            Response.ContentType = "application/vnd.ms-excel";
            //Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
        }
    }
    protected void lbGroupData_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        string value = "";
        try
        {
            DataTable result = new DataTable();
            DataLayer dac = new DataLayer();
            result = dac.GetGroupTotalScore();


            foreach (DataRow row in result.Rows)
            {
                sb.Append(row[0].ToString() + " : " + row[1].ToString());//Convert.ToString(sb)
            }
            value = sb.ToString();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('" + value + "');", true);
            //ExportToExcel(result, "Predicta_GroupScores.xls");
        }
        catch (Exception)
        {

            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);
        }

    }
    public void BindData() {
        StringBuilder sb = new StringBuilder();
        try
        {
            DataTable result = new DataTable();
            DataLayer dac = new DataLayer();
            string strcolor = "";
            result = dac.GetGroupScoreForAdmin();

            sb.Append("<table class='clstableteam' style='color:white;'><tr style='background-color:gray;'><td style='padding:6px;'>Team</td><td>Yday's Score</td><td>Today's Score</td><td>Team Participation</td></tr>");

            foreach (DataRow row in result.Rows)
            {

                if (row[0].ToString() == "TEAM - RED")
                {
                    strcolor = "DarkRed";
                }
                else if (row[0].ToString() == "TEAM - BLUE")
                {
                    strcolor = "darkBlue";
                }
                else if (row[0].ToString() == "TEAM - GREEN")
                {
                    strcolor = "Green";
                }
                else if (row[0].ToString() == "TEAM - ORANGE")
                {
                    strcolor = "Orange";
                }
                else if (row[0].ToString() == "TEAM - BLACK")
                {
                    strcolor = "black";
                }
                else
                {
                    strcolor = "gray";
                }
                sb.Append("<tr style='background-color:" + strcolor + "'><td style='width:150px;padding:6px;'>" + row[0].ToString() + "</td><td style='width:120px;'>" + row[1].ToString() + "</td><td style='width:120px;'>" + row[2].ToString() + "</td><td  style='width:150px;text-align:center;'>" + row[3].ToString() + "</td></tr>");
            }
            sb.Append("</table>");
            hdnTable.Value = sb.ToString();
            //value = sb.ToString();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "BindTeamTotalData()", true);
            //ExportToExcel(result, "Predicta_GroupScores.xls");
        }
        catch (Exception)
        {

            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);
        }
    
    }
}