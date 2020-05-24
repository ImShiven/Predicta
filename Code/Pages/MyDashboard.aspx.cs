using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Data;

public partial class Pages_MyDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        DataLayer dac = new DataLayer();
        dt = dac.GetDataForDashBoard();
        if (dt.Rows.Count > 0)
        {
            string jsonstring = JsonConvert.SerializeObject(DatatableToDictionary(dt, "Name"), Newtonsoft.Json.Formatting.Indented);
            string a = jsonstring.Replace(System.Environment.NewLine, "");
            string b = a.Replace(" ", "");
            string jsonstring1 = b.Replace("{\"Key\":", "");
            string jsonstring2 = jsonstring1.Replace(",\"Value\"", "");
            string jsonstring3 = jsonstring2.Replace("},", ",");
            string jsonstring4 = jsonstring3.Replace("\"Name", "{\"Name");
            string jsonstring5 = jsonstring4.Replace("}", "}}");
            string jsonstring6 = jsonstring5.Replace("}}}}", "}}");

            //Response.Write(jsonstring5);
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "loadwithData", "loadData();", true);
            hdnData.Value = jsonstring6;
        }
    }



    public List<KeyValuePair<string, object>> DatatableToDictionary(DataTable dt, string id)
    {
        Dictionary<string, Dictionary<string, object>> dict1 = new Dictionary<string, Dictionary<string, object>>();
        var items = new List<KeyValuePair<string, object>>();
        var cols = dt.Columns.Cast<DataColumn>().Where(c => c.ColumnName != id);
        dict1 = dt.Rows.Cast<DataRow>()
                 .ToDictionary(r => r[id].ToString(),
                               r => cols.ToDictionary(c => c.ColumnName, c => r[c.ColumnName]));
        foreach (KeyValuePair<string, Dictionary<string, object>> entry in dict1)
        {
            // do something with entry.Value or entry.Key
            items.Add(new KeyValuePair<string, object>("Name", entry.Key));
            items.Add(new KeyValuePair<string, object>("freq", entry.Value));

        }
        return items;
    }
}
