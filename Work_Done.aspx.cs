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
using System.IO;
using OfficeOpenXml;
using System.Globalization;
using System.Web.Services;
using Newtonsoft.Json;

public partial class Work_Done : System.Web.UI.Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        checklogin();
        connection = obj.connectionString();
        if (!IsPostBack)
        {
            HiddenPopupState.Value = "Close";
        }
    }
    protected void checklogin()
    {
        if (Session["Logindone"] == null || (bool)Session["Logindone"] == false)
        {
            Response.Redirect("Default.aspx");
        }
    }
   
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string callId = HiddenFieldCallId.Value;
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT * FROM All_Complaints WHERE Status = 'Done' AND Call_id = @id", cn);
        cm.Parameters.AddWithValue("@id", txtNewCallId.Text.Trim());
        //SqlCommand cm2 = new SqlCommand("SELECT * FROM All_Complains WHERE Call_Id = @id", cn);
        //cm2.Parameters.AddWithValue("@id", txtNewCallId.Text.Trim());

        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);

        //SqlDataAdapter da2 = new SqlDataAdapter(cm2);
        //DataSet ds2 = new DataSet();
        //da2.Fill(ds2);

        if (string.IsNullOrEmpty(txtNewCallId.Text))
        {
            Label2.Text = "Enter New Call Id";
            Label2.Visible = true;
            txtOldCallId.Text = callId;
            HiddenPopupState.Value = "Open";
        }
        else if (ds.Tables[0].Rows.Count > 0 /*|| ds2.Tables[0].Rows.Count > 0*/)
        {
            Label2.Text = "Call Id already exists";
            Label2.Visible = true;
            txtOldCallId.Text = callId;
            HiddenPopupState.Value = "Open";
        }
        else if (callId == "")
        {
            Label2.Text = "Old ID not found";
            Label2.Visible = true;
            txtOldCallId.Text = callId;
            HiddenPopupState.Value = "Open";
        }
        else
        {
            SqlCommand cm3 = new SqlCommand("UPDATE All_Complaints SET Call_Id = @nid WHERE Call_Id = @oid", cn);
            cm3.Parameters.AddWithValue("@nid", txtNewCallId.Text.Trim());
            cm3.Parameters.AddWithValue("@oid", callId);
            //SqlCommand cm4 = new SqlCommand("UPDATE Work_Done SET Call_id = @nid WHERE Call_id = @oid", cn);
            //cm4.Parameters.AddWithValue("@nid", txtNewCallId.Text.Trim());
            //cm4.Parameters.AddWithValue("@oid", callId);
            cn.Open();
            cm3.ExecuteNonQuery();
            //cm4.ExecuteNonQuery();
            cn.Close();
            Label2.Visible = false;
            HiddenPopupState.Value = "Close";
        }

    }

    [WebMethod]
    public static string GetData(int draw, int start, int length, int orderColumn, string orderDir, string searchValue)
    {
        Class1 obj = new Class1();
        string connection = obj.connectionString();
        string query = "SELECT Call_id, Date, CC_Date, Name, Contact, Address, Product, Company, Warranty, Problem, Assigned_To, Details, Charges, ToPay, ItemCode, Def_Return, Dealer FROM All_Complaints WHERE Status = 'Done' AND 1=1";

        if (!string.IsNullOrEmpty(searchValue))
        {
            query += " AND (Call_id LIKE @Search OR CC_Date LIKE @Search OR Name LIKE @Search OR Contact LIKE @Search OR Date LIKE @Search OR Product LIKE @Search OR Company LIKE @Search OR Warranty LIKE @Search OR Problem LIKE @Search OR Assigned_To LIKE @Search OR Details LIKE @Search OR Address LIKE @Search OR Charges LIKE @Search OR ToPay LIKE @Search OR ItemCode LIKE @Search OR Def_Return LIKE @Search)";
        }

        // Default sorting column
        string orderByColumn = "Call_id";
        if (orderColumn == 1) orderByColumn = "Date";
        else if (orderColumn == 2) orderByColumn = "Name";
        else if (orderColumn == 3) orderByColumn = "Contact";

        query += " ORDER BY " + orderByColumn + " " + orderDir + " OFFSET @Start ROWS FETCH NEXT @Length ROWS ONLY";

        List<object> data = new List<object>();
        int recordsTotal = 0;
        int recordsFiltered = 0;

        using (SqlConnection conn = new SqlConnection(connection))
        {
            conn.Open();

            // Get total number of records
            SqlCommand totalCmd = new SqlCommand("SELECT COUNT(*) FROM All_Complaints WHERE Status = 'Done' ", conn);
            recordsTotal = (int)totalCmd.ExecuteScalar();

            // Get total filtered records
            string countQuery = "SELECT COUNT(*) FROM All_Complaints WHERE Status = 'Done' AND 1=1";
            if (!string.IsNullOrEmpty(searchValue))
            {
                countQuery += " AND (Call_id LIKE @Search OR CC_Date LIKE @Search OR Name LIKE @Search OR Contact LIKE @Search OR Date LIKE @Search OR Product LIKE @Search OR Company LIKE @Search OR Warranty LIKE @Search OR Problem LIKE @Search OR Assigned_To LIKE @Search OR Details LIKE @Search OR Address LIKE @Search OR Charges LIKE @Search OR ToPay LIKE @Search OR ItemCode LIKE @Search OR Def_Return LIKE @Search OR Dealer LIKE @Search)";
            }

            SqlCommand filteredCmd = new SqlCommand(countQuery, conn);
            filteredCmd.Parameters.AddWithValue("@Search", "%" + searchValue + "%");
            recordsFiltered = (int)filteredCmd.ExecuteScalar();

            // Prepare and execute data retrieval query
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Start", start);
            cmd.Parameters.AddWithValue("@Length", length);
            cmd.Parameters.AddWithValue("@Search", "%" + searchValue + "%");

            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    data.Add(new
                    {
                        Call_id = reader["Call_id"].ToString(),
                        Date = reader["Date"].ToString(),
                        CC_Date = reader["CC_Date"].ToString(),
                        Name = reader["Name"].ToString(),
                        Contact = reader["Contact"].ToString(),
                        Address = reader["Address"].ToString(),
                        Product = reader["Product"].ToString(),
                        Company = reader["Company"].ToString(),
                        Warranty = reader["Warranty"].ToString(),
                        Problem = reader["Problem"].ToString(),
                        Assigned_To = reader["Assigned_To"].ToString(),
                        Details = reader["Details"].ToString(),
                        Charges = reader["Charges"].ToString(),
                        ToPay = reader["ToPay"].ToString(),
                        Dealer = reader["Dealer"].ToString(),
                        ItemCode = reader["ItemCode"].ToString(),
                        Def_Return = reader["Def_Return"].ToString()
                    });
                }
            }
        }

        return JsonConvert.SerializeObject(new { draw, recordsTotal, recordsFiltered, data });
    }

    protected void Filter_Click(object sender, EventArgs e)
    {
        Response.Redirect("WorkDoneFilter.aspx");
    }
}

