using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Web.Services;
using Newtonsoft.Json;

public partial class All_Complains : System.Web.UI.Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {

        checklogin();
        connection = obj.connectionString();
    }
    [WebMethod]
    public static string GetData(int draw, int start, int length, int orderColumn, string orderDir, string searchValue)
    {
        Class1 obj = new Class1();
        string connection = obj.connectionString();
        using (SqlConnection con = new SqlConnection(connection))
        {
            con.Open();
            string whereClause = "";
            if (!string.IsNullOrEmpty(searchValue))
            {
                whereClause = "WHERE Call_Id LIKE @Search OR Date LIKE @Search OR Time LIKE @Search OR Name LIKE @Search OR Contact LIKE @Search OR Address LIKE @Search OR Product LIKE @Search OR Company LIKE @Search OR Warranty LIKE @Search OR Problem LIKE @Search OR Assigned_To LIKE @Search OR Status LIKE @Search OR RegisBy LIKE @Search OR Dealer LIKE @Search";
            }

            // Sorting columns (adjust column names based on DataTable)
            string[] columnNames = { "Call_Id", "Date", "Name", "Contact", "Address", "Product", "Company", "Warranty", "Problem", "Assigned_To", "Dealer", "Status" };
            string orderByClause = "ORDER BY " + columnNames[orderColumn] + " " + orderDir;

            // Get total count of records
            string totalCountQuery = "SELECT COUNT(*) FROM All_Complaints";
            SqlCommand cmdTotal = new SqlCommand(totalCountQuery, con);
            int totalRecords = Convert.ToInt32(cmdTotal.ExecuteScalar());

            // Get count of filtered records
            string filteredCountQuery = "SELECT COUNT(*) FROM All_Complaints " + whereClause;
            SqlCommand cmdFiltered = new SqlCommand(filteredCountQuery, con);
            if (!string.IsNullOrEmpty(searchValue))
            {
                cmdFiltered.Parameters.AddWithValue("@Search", "%" + searchValue + "%");
            }
            int filteredRecords = Convert.ToInt32(cmdFiltered.ExecuteScalar());

            // Fetch data with sorting
            string dataQuery = "SELECT * FROM All_Complaints " + whereClause + " " + orderByClause + " OFFSET @Start ROWS FETCH NEXT @Length ROWS ONLY";
            SqlCommand cmdData = new SqlCommand(dataQuery, con);
            cmdData.Parameters.AddWithValue("@Start", start);
            cmdData.Parameters.AddWithValue("@Length", length);
            if (!string.IsNullOrEmpty(searchValue))
            {
                cmdData.Parameters.AddWithValue("@Search", "%" + searchValue + "%");
            }

            SqlDataAdapter da = new SqlDataAdapter(cmdData);
            DataTable dt = new DataTable();
            da.Fill(dt);

            List<object> data = new List<object>();
            foreach (DataRow row in dt.Rows)
            {
                data.Add(new
                {
                    Call_Id = row["Call_Id"],
                    Date = row["Date"],
                    Time = row["Time"],
                    Name = row["Name"],
                    Contact = row["Contact"],
                    Address = row["Address"],
                    Product = row["Product"],
                    Company = row["Company"],
                    Warranty = row["Warranty"],
                    Problem = row["Problem"],
                    Assigned_To = row["Assigned_To"],
                    RegisBy = row["RegisBy"],
                    Dealer = row["Dealer"],
                    Status = row["Status"],
                    isRepeated = row["isRepeated"]
                });
            }

            return JsonConvert.SerializeObject(new
            {
                draw = draw,
                recordsTotal = totalRecords,
                recordsFiltered = filteredRecords,
                data = data
            });
        }
    }
    protected void checklogin()
    {
        if (Session["Logindone"] == null || (bool)Session["Logindone"] == false)
        {
            Response.Redirect("Default.aspx");
        }
    }
  
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
   
}