using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Configuration;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System.Text; 
public partial class Pages_AdminPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //StringBuilder sb = new StringBuilder();
        //string jp1Perc;
        //try
        //{
        //    DataTable result = new DataTable();
        //    DataLayer dac = new DataLayer();

        //    result = dac.GetJackpotPredData();
        //    sb.Append("<table style='color:darkslategrey;margin-top:0px !important;' class='grid'>");
        //    sb.Append("<tr class='gradmc' style='letter-spacing:1px;'><td colspan=8 style='padding:6px;'><span style='margin-left:2%;color:darkslategrey;'>PlayOffs:  <span style='color:purple;'>CSK/SRH/KKR/KXIP</span></span><span style='margin-left:20%;color:darkslategrey;'>Predicta Winner : <span style='color:purple;'>*****</span></span><span style='float:right;color:darkslategrey;margin-right:30px;'>Winning Team : <span style='color:purple;'>Team - ****</span></span></td></tr>");
        //    sb.Append("<tr class='grad' style='letter-spacing:1px;line-height:0.5;'><td style='padding:6px;'>Participant</td><td>JP1 - Top 4 Teams</td><td>JP1 -Points</td><td>JP2 - Winner</td><td>JP2 - Points</td><td>JP3 -Winning Team</td><td>JP3 - Points</td><td>Total</td></tr>");


        //    foreach (DataRow row in result.Rows)
        //    {
        //        jp1Perc = Convert.ToString((Convert.ToInt32(row[2].ToString()) * 100) / 200);

        //        //sb.Append("<tr style='background:white;color:darkslategray;font-family: Comic Sans MS, cursive, sans-serif;letter-spacing:2px;font-size:14px;'><td style='width:150px;'>" + row[0].ToString() + "</td><td style='width:200px;color:white;background:linear-gradient(to right, limegreen " + jp1Perc + "%, tomato 1%);'>" + row[1].ToString() + "</td><td style='text-align:center;width:150px;'>" + row[2].ToString() + " ("+ jp1Perc +"%)" + "</td><td style='width:130px;background-color:lightYellow;'>" + row[3].ToString() + "</td><td style='text-align:center;width:150px;background-color:lightYellow;'>" + row[4].ToString() + "</td><td style='text-align:center;width:180px;background-color:lightPink;'>" + row[5].ToString() + "</td><td style='text-align:center;width:120px;background-color:lightPink'>" + row[6].ToString() + "</td><td style='text-align:center;width:120px;background-color:limegreen;color:white;'>" + row[7].ToString() + "</td></tr>");
        //        sb.Append("<tr style='background:white;color:darkslategray;font-family: Comic Sans MS, cursive, sans-serif;letter-spacing:2px;font-size:14px;'><td style='width:150px;'>" + row[0].ToString() + "</td><td style='width:200px;color:white;background:linear-gradient(to right, limegreen " + jp1Perc + "%, tomato 1%);'>" + row[1].ToString() + "</td><td style='text-align:center;width:150px;'>" + row[2].ToString() + " (" + jp1Perc + "%)" + "</td><td style='width:130px;background-color:lightYellow;'>" + "*****" + "</td><td style='text-align:center;width:150px;background-color:lightYellow;'>" + row[4].ToString() + "</td><td style='text-align:center;width:180px;background-color:lightPink;'>" + "*****" + "</td><td style='text-align:center;width:120px;background-color:lightPink'>" + row[6].ToString() + "</td><td style='text-align:center;width:120px;background-color:limegreen;color:white;'>" + row[7].ToString() + "</td></tr>");
        //    }
        //    sb.Append("</table>");
        //    hdnTable.Value = sb.ToString();
        //    //value = sb.ToString();
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "BindTeamTotalData()", true);
        //    //ExportToExcel(result, "Predicta_GroupScores.xls");
        //}
        //catch (Exception)
        //{

        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);
        //}
    }

    public void ExportToExcel(DataTable dt,string filename)
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

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string result = String.Empty;
            DataLayer dac = new DataLayer();
            string MailId = txtMailId.Text;
            string UserName = txtName.Text;
            int intGroup = Convert.ToInt32(txtGroup.Text);
            txtGroup.Text = "";
            txtMailId.Text = "";
            txtName.Text = "";
            if (MailId.Trim() != "" && UserName.Trim() != "")
            {
                result = dac.AddUser(MailId, UserName, intGroup);
            }

            if (result == "1")
            {
                //show success
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('User Added Successfully!!');", true);
            }
            else if (result == "0")
            {
                //show already exist
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('User already exists!!');", true);
            }
            else
            {
                //show error
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('some error occured!!');", true);
            }
        }
        catch (Exception)
        {

            //show error
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);
        }

    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            string result = String.Empty;
            DataLayer dac = new DataLayer();
            int matchNo = Convert.ToInt32(txtMNumber.Text);
            int WinningTeam = Convert.ToInt32(txtWinningTeamCode.Text);
            string Results = txtResultCode.Text;
            string Points = txtPoints.Text;
            txtMNumber.Text = "";
            txtWinningTeamCode.Text = "";
            txtResultCode.Text = "";
            txtPoints.Text = "";

            if (matchNo > 0 && WinningTeam > 0 && WinningTeam < 9 && Results.Trim() != "" && Points.Trim() != "")
            {
                result = dac.UpdateMatchResults(matchNo, WinningTeam, Results, Points);
            }

            if (result == "1")
            {
                //show success
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Result Updated Successfully!!');", true);
            }
            else if (result == "0")
            {
                //show already exist
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Upload Predictions first!!');", true);
            }
            else
            {
                //show error
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!!');", true);
            }
        }
        catch (Exception)
        {

            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);
        }
    }
    protected void lbDownload_Click(object sender, EventArgs e)
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
    protected void btnUploadFile_Click(object sender, EventArgs e)
    {
        try
        {
            if (flUploadUsersData.HasFile)
            {
                string xmlData = "";
                string FileName = Path.GetFileNameWithoutExtension(flUploadUsersData.PostedFile.FileName) + "_" + Convert.ToString(DateTime.Now.Ticks);           
                string Extension = Path.GetExtension(flUploadUsersData.PostedFile.FileName);
                string FolderPath = ConfigurationManager.AppSettings["PredictionsFolderPath"];

                string FilePath = Server.MapPath(FolderPath + FileName + Extension);
                flUploadUsersData.SaveAs(FilePath);

                //Open the Excel file in Read Mode using OpenXml.
                using (SpreadsheetDocument doc = SpreadsheetDocument.Open(FilePath, false))
                {
                    //Read the first Sheet from Excel file.
                    Sheet sheet = doc.WorkbookPart.Workbook.Sheets.GetFirstChild<Sheet>();

                    //Get the Worksheet instance.
                    Worksheet worksheet = (doc.WorkbookPart.GetPartById(sheet.Id.Value) as WorksheetPart).Worksheet;

                    //Fetch all the rows present in the Worksheet.
                    IEnumerable<Row> rows = worksheet.GetFirstChild<SheetData>().Descendants<Row>();

                    //Create a new DataTable.
                    DataTable dt = new DataTable();

                    //Loop through the Worksheet rows.
                    foreach (Row row in rows)
                    {
                        //Use the first row to add columns to DataTable.
                        if (row.RowIndex.Value == 1)
                        {
                            foreach (Cell cell in row.Descendants<Cell>())
                            {
                                dt.Columns.Add(GetValue(doc, cell));
                            }
                        }
                        else
                        {
                            //Add rows to DataTable.
                            dt.TableName = "dtPredictions";
                            dt.Rows.Add();
                            int i = 0;
                            foreach (Cell cell in row.Descendants<Cell>())
                            {
                                dt.Rows[dt.Rows.Count - 1][i] = GetValue(doc, cell);
                                i++;
                            }
                        }
                    }
                    if (dt.Rows.Count > 0)
                    {
                        xmlData = ConvertDatatableToXML(dt);
                    }
                    else {
                        xmlData = "none";
                    }
                    if (UploadPredictionsToDB(xmlData) == "1") 
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Data Uploaded successfully !!');", true);
                    }
                    else if (UploadPredictionsToDB(xmlData) == "0")
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Data Already Uploaded !!');", true);
                    }
                    else {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured !!');", true);
                    }
                    
                }
            }
        }
        catch (Exception)
        {

            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);
        }
    }
    private string GetValue(SpreadsheetDocument doc, Cell cell)
    {
        string value = cell.CellValue.InnerText;
        if (cell.DataType != null && cell.DataType.Value == CellValues.SharedString)
        {
            return doc.WorkbookPart.SharedStringTablePart.SharedStringTable.ChildElements.GetItem(int.Parse(value)).InnerText;
        }
        return value;
    }

    // By using this method we can convert datatable to xml
    public string ConvertDatatableToXML(DataTable dt)
    {
        MemoryStream str = new MemoryStream();
        dt.WriteXml(str, true);
        str.Seek(0, SeekOrigin.Begin);
        StreamReader sr = new StreamReader(str);
        string xmlstr;
        xmlstr = sr.ReadToEnd();
        return (xmlstr);
    }

    public string UploadPredictionsToDB(string xmldata)
    {
        try
        {
            string output = String.Empty;
            DataLayer dac = new DataLayer();

            output = dac.UploadPredictionsToDB(xmldata);
            return output;
        }
        catch (Exception)
        {

            return "-99";
        }
    
    }
    protected void lbDownloadUsers_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable result = new DataTable();
            DataLayer dac = new DataLayer();

            result = dac.GetUsersTemplateExcel();
            ExportToExcel(result,"Participants_Predictions_Template.xls");
        }
        catch (Exception)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);

        }

    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        DataLayer dc = new DataLayer();
        DataTable dt = new DataTable();
        try
        {
            string path = flText.PostedFile.FileName;
            string todayDate = DateTime.Today.Date.ToString("dd/MM/yy");
            string readText = File.ReadAllText(path);

            int i1 = 0, i2 = 0;
            string key, value;
            Dictionary<string, string> dict = new Dictionary<string, string>();
            StringBuilder sb = new StringBuilder();

            int index = readText.IndexOf("26/04/18"); //todayDate
            string lines = readText.Substring(index).Replace(todayDate, Environment.NewLine + todayDate).Replace("'", "").Replace("\"", "").Replace("<", "").Replace(">", "");


            if (File.Exists(@"D:\RawPred\Pred.txt"))
            {
                File.Delete(@"D:\RawPred\Pred.txt");
            }
            File.WriteAllText(@"D:\RawPred\Pred.txt", lines);
            string[] data = File.ReadAllLines(@"D:\RawPred\Pred.txt").ToArray();
            foreach (var s in data)
            {
                if ((s.ToUpper().Contains("MI")) || (s.ToUpper().Contains("CSK")) || (s.ToUpper().Contains("RR")) || (s.ToUpper().Contains("RCB")) || (s.ToUpper().Contains("KKR")) || (s.ToUpper().Contains("DD")) || (s.ToUpper().Contains("SRH")) || (s.ToUpper().Contains("KXIP")) || (s.ToUpper().Contains("PUNJAB")))
                {
                    i1 = s.IndexOf("M - ");
                    if (i1 != -1)
                    { i2 = s.IndexOf(":", i1); }

                    if ((!(i1 == -1 || i2 == -1)) && (i2 > i1))
                    {
                        key = s.Substring(i1 + 4, i2 - i1 - 4);
                        value = s.Substring(i2 + 2);
                        if (!(dict.ContainsKey(key.Replace(" ", ""))))
                        {
                            dict.Add(key.Replace(" ", ""), value);
                        }
                        else
                        {
                            dict[key.Replace(" ", "")] = value;
                        }
                    }
                }
            }
            sb.Append("<root>");
            foreach (var item in dict)
            {
                sb.Append("<parent>");
                sb.Append("<Name>" + item.Key + "</Name>");
                sb.Append("<Predictions>" + item.Value + "</Predictions>");
                sb.Append("</parent>");
            }
            sb.Append("</root>");

            dt = dc.GetConvertedUserPredictions(sb.ToString());
            ExportToExcel(dt, "RawPredictions.xls");
            //XElement el = new XElement("root",
            //    dict.Select(kv => new XElement(kv.Key, kv.Value)));
        }
        catch (Exception)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured while parsing data.');", true);

        }



    }
    protected void lbTeam_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        string value = "";
        try
        {
            DataTable result = new DataTable();
            DataLayer dac = new DataLayer();
            result = dac.GetGroupScoreForAdmin();


            //foreach (DataRow row in result.Rows)
            //{
            //    sb.Append(row[0].ToString() + " : " + row[1].ToString() + "/" + row[2].ToString() + "/" + row[3].ToString() + "||");//Convert.ToString(sb)
            //}
            //value = sb.ToString();
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('" + value + "');", true);
            ExportToExcel(result, "Predicta_GroupScores.xls");
        }
        catch (Exception)
        {

            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);
        }

    }
    protected void SaveJackpotPredFromExcel(object sender, EventArgs e)
    {
        DataLayer dac = new DataLayer();
        try
        {
            if (flUploadUsersData.HasFile)
            {
                string xmlData = "";
                string FileName = Path.GetFileNameWithoutExtension(flUploadUsersData.PostedFile.FileName);
                string Extension = Path.GetExtension(flUploadUsersData.PostedFile.FileName);
                string FolderPath = "../TempFiles/"; //ConfigurationManager.AppSettings["PredictionsFolderPath"];

                string FilePath = Server.MapPath(FolderPath + FileName + Extension);
                if (File.Exists(FilePath)) { File.Delete(FilePath); }
                flUploadUsersData.SaveAs(FilePath);

                //Open the Excel file in Read Mode using OpenXml.
                using (SpreadsheetDocument doc = SpreadsheetDocument.Open(FilePath, false))
                {
                    //Read the first Sheet from Excel file.
                    Sheet sheet = doc.WorkbookPart.Workbook.Sheets.GetFirstChild<Sheet>();

                    //Get the Worksheet instance.
                    Worksheet worksheet = (doc.WorkbookPart.GetPartById(sheet.Id.Value) as WorksheetPart).Worksheet;

                    //Fetch all the rows present in the Worksheet.
                    IEnumerable<Row> rows = worksheet.GetFirstChild<SheetData>().Descendants<Row>();

                    //Create a new DataTable.
                    DataTable dt = new DataTable();

                    //Loop through the Worksheet rows.
                    foreach (Row row in rows)
                    {
                        //Use the first row to add columns to DataTable.
                        if (row.RowIndex.Value == 1)
                        {
                            foreach (Cell cell in row.Descendants<Cell>())
                            {
                                dt.Columns.Add(GetValue(doc, cell));
                            }
                        }
                        else
                        {
                            //Add rows to DataTable.
                            dt.TableName = "dtPredictions";
                            dt.Rows.Add();
                            int i = 0;
                            foreach (Cell cell in row.Descendants<Cell>())
                            {
                                dt.Rows[dt.Rows.Count - 1][i] = GetValue(doc, cell);
                                i++;
                            }
                        }
                    }
                    if (dt.Rows.Count > 0)
                    {
                        xmlData = ConvertDatatableToXML(dt);
                    }
                    else
                    {
                        xmlData = "none";
                    }
                    if (dac.UploadJackpotPredToDB(xmlData) == "1")
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Data Uploaded successfully !!');", true);
                    }
                    else if (dac.UploadJackpotPredToDB(xmlData) == "0")
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Data Already Uploaded !!');", true);
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured !!');", true);
                    }

                }
            }
        }
        catch (Exception)
        {

            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Some Error Occured!! Try Again');", true);
        }
    }

}