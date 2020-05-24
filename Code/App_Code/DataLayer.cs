using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;

/// <summary>
/// Summary description for DataLayer
/// </summary>
public class DataLayer
{
    SqlConnection con = new SqlConnection("Data Source=localhost;Initial Catalog=shivDB;Integrated Security=True;");

    public DataLayer()
    {
        con.Open();
    }

    public DataTable GetUserPredictedDataForHome()
    {
        DataTable dt = new DataTable();
        try
        {
            dt = GetDataFromDB("spPREDICTAGetUserPredictedData");
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    DataTable names = dt.DefaultView.ToTable(true, new string[] { "Name" });
                    var arrnames = names.AsEnumerable()
                           .Select(r => r.Field<string>("Name")).ToArray();

                    string commaSeperatedValues = string.Join(",", arrnames);
                    HttpContext.Current.Session["Names"] = commaSeperatedValues +",";
                }

            }
        }
        catch (Exception)
        {

            //throw;
        }
        return dt;
    }

    public DataTable GetDataForDashBoard()
    {
        DataTable dt = new DataTable();
        try
        {
            dt = GetDataFromDB("spPREDICTAGetDataForDashBoard");
        }
        catch (Exception)
        {

            throw;
        }
        return dt;
    }

    public DataTable GetMatchScheduleData()
    {
        DataTable dt = new DataTable();
        try
        {
            dt = GetDataFromDB("spPREDICTAGetMatchSchedule");
        }
        catch (Exception)
        {

            throw;
        }
        return dt;
    }

    public DataTable GetPlayersData()
    {
        DataTable dt = new DataTable();
        try
        {
            dt = GetDataFromDB("spPREDICTAViewTeamOrPlayers");
        }
        catch (Exception)
        {

            throw;
        }
        return dt;
    }

    public string AddUser(string MailId, string UserName, int intGroup)
    {
        string output = String.Empty;
        try
        {
            SqlCommand cmd = new SqlCommand(); // Create a object of SqlCommand class
            cmd.Connection = con; //Pass the connection object to Command
            cmd.CommandType = CommandType.StoredProcedure; // We will use stored procedure. 
            cmd.CommandText = "spPredictaAddUser"; //Stored Procedure Name

            cmd.Parameters.Add(new SqlParameter("@txtMailId", SqlDbType.VarChar));
            cmd.Parameters["@txtMailId"].Value = MailId;

            cmd.Parameters.Add(new SqlParameter("@txtUserName", SqlDbType.VarChar));
            cmd.Parameters["@txtUserName"].Value = UserName;

            cmd.Parameters.Add(new SqlParameter("@intGroup", SqlDbType.Int));
            cmd.Parameters["@intGroup"].Value = intGroup;

            output = Convert.ToString(cmd.ExecuteScalar());
            return output;
        }
        catch (Exception)
        {
            return "-99";
        }
    }

    public DataTable GetDataFromDB(string txtspName)
    {
        DataTable dt = new DataTable();
        SqlDataReader dr;
        try
        {
            SqlCommand cmd = new SqlCommand(); // Create a object of SqlCommand class
            cmd.Connection = con; //Pass the connection object to Command
            cmd.CommandType = CommandType.StoredProcedure; // We will use stored procedure. 
            cmd.CommandText = txtspName; //Stored Procedure Name

            dr = cmd.ExecuteReader();
            dt.Load(dr);
        }
        catch (Exception)
        {

            throw;
        }
        return dt;
    }

    public string UpdateMatchResults(int intMatchNo, int intWinner, string txtMatchResult, string txtPoints)
    {
        string output = String.Empty;
        try
        {
            SqlCommand cmd = new SqlCommand(); // Create a object of SqlCommand class
            cmd.Connection = con; //Pass the connection object to Command
            cmd.CommandType = CommandType.StoredProcedure; // We will use stored procedure. 
            cmd.CommandText = "spPREDICTAUpdatePointsAndResults"; //Stored Procedure Name

            cmd.Parameters.Add(new SqlParameter("@intMatchNumber", SqlDbType.Int));
            cmd.Parameters["@intMatchNumber"].Value = intMatchNo;

            cmd.Parameters.Add(new SqlParameter("@MatchResultCode", SqlDbType.VarChar));
            cmd.Parameters["@MatchResultCode"].Value = txtMatchResult;

            cmd.Parameters.Add(new SqlParameter("@PointsCode", SqlDbType.VarChar));
            cmd.Parameters["@PointsCode"].Value = txtPoints;

            cmd.Parameters.Add(new SqlParameter("@intWinningTeamCode", SqlDbType.Int));
            cmd.Parameters["@intWinningTeamCode"].Value = intWinner;

            output = Convert.ToString(cmd.ExecuteScalar());
            return output;
        }
        catch (Exception)
        {
            return "-99";
        }
    }

    public DataTable GetExcelData()
    {
        DataTable dt = new DataTable();
        try
        {
            dt = GetDataFromDB("spPREDICTAGetDataForExcel");
        }
        catch (Exception)
        {

            throw;
        }
        return dt;
    }
    public DataTable GetUsersTemplateExcel()
    {
        DataTable dt = new DataTable();
        try
        {
            dt = GetDataFromDB("spPREDICTAGetUserTemplate");
        }
        catch (Exception)
        {

            throw;
        }
        return dt;
    }


    public string UploadPredictionsToDB( string txtXMLdata)
    {
        string output = String.Empty;
        try
        {
            SqlCommand cmd = new SqlCommand(); // Create a object of SqlCommand class
            cmd.Connection = con; //Pass the connection object to Command
            cmd.CommandType = CommandType.StoredProcedure; // We will use stored procedure. 
            cmd.CommandText = "spPREDICTAInsertUserPredictions"; //Stored Procedure Name

            cmd.Parameters.Add(new SqlParameter("@txtXMLData", SqlDbType.VarChar));
            cmd.Parameters["@txtXMLData"].Value = txtXMLdata;

            output = Convert.ToString(cmd.ExecuteScalar());
            return output;
        }
        catch (Exception)
        {
            return "-99";
        }
    }
    public DataTable GetGroupTotalScore()
    {
        DataTable dt = new DataTable();
        try
        {
            dt = GetDataFromDB("spPREDICTAGetGroupTotal");
        }
        catch (Exception)
        {

            throw;
        }
        return dt;
    }
    public DataTable GetGroupScoreForAdmin()
    {
        DataTable dt = new DataTable();
        try
        {
            dt = GetDataFromDB("spGetTeamScoreDetails");
        }
        catch (Exception)
        {

            throw;
        }
        return dt;
    }

    public DataTable GetConvertedUserPredictions(string txtXMLdata)
    {
        DataTable dtbl = new DataTable();
        SqlDataReader dr;
        try
        {
            SqlCommand cmd = new SqlCommand(); // Create a object of SqlCommand class
            cmd.Connection = con; //Pass the connection object to Command
            cmd.CommandType = CommandType.StoredProcedure; // We will use stored procedure. 
            cmd.CommandText = "spPREDICTAParseData"; //Stored Procedure Name

            cmd.Parameters.Add(new SqlParameter("@xml", SqlDbType.VarChar));
            cmd.Parameters["@xml"].Value = txtXMLdata;
            dr = cmd.ExecuteReader();
            dtbl.Load(dr);

            return dtbl;
        }
        catch (Exception)
        {
            throw;
        }
    }

    public string UploadJackpotPredToDB(string txtXMLdata)
    {
        string output = String.Empty;
        try
        {
            SqlCommand cmd = new SqlCommand(); // Create a object of SqlCommand class
            cmd.Connection = con; //Pass the connection object to Command
            cmd.CommandType = CommandType.StoredProcedure; // We will use stored procedure. 
            cmd.CommandText = "spPREDICTAInsertJackpotPredictions"; //Stored Procedure Name

            cmd.Parameters.Add(new SqlParameter("@txtXMLData", SqlDbType.VarChar));
            cmd.Parameters["@txtXMLData"].Value = txtXMLdata;

            output = Convert.ToString(cmd.ExecuteScalar());
            return output;
        }
        catch (Exception)
        {
            return "-99";
        }
    }

}