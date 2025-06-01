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

public partial class User_home : System.Web.UI.Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        checklogin();
        connection = obj.connectionString();
        if(!IsPostBack)
        {
            RadioButtonList1.SelectedValue = "Register Complaint";
            TextBox2.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    protected void checklogin()
    {
        if (Session["LoginUserdone"] == null || (bool)Session["LoginUserdone"] == false)
        {
            Response.Redirect("Default.aspx");
        }
    }

   
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string username = Session["Username"].ToString();
        string dealer = Session["Dealer"].ToString();
        DateTime serverTime = DateTime.UtcNow; 
        TimeZoneInfo timeZone = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
        DateTime localTime = TimeZoneInfo.ConvertTimeFromUtc(serverTime, timeZone);
        string time = localTime.ToString("hh:mm tt");
        ValidateAndProcessUser(
            TextBox1.Text.Trim(),
            TextBox2.Text.Trim(),
            TextBox3.Text.Trim(),
            TextBox4.Text.Trim(),
            TextBox5.Text.Trim(),
            TextBox8.Text.Trim(),
            username.Trim(),
            time,
            dealer.Trim()
        );
    }

    protected void ValidateAndProcessUser(string p1, string p2, string p3, string p4, string p5, string p8 , string username , string time , string dealer)
    {
        long number;
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT * FROM Complain WHERE Call_Id = @id", cn);
        cm.Parameters.AddWithValue("@id", p1);
        SqlCommand allcmplns = new SqlCommand("SELECT * FROM All_Complains WHERE Call_Id = @id", cn);
        allcmplns.Parameters.AddWithValue("@id", p1);
        cn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);

        SqlDataAdapter da2 = new SqlDataAdapter(allcmplns);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2);

        if (string.IsNullOrEmpty(p1))
        {
            ShowOnlyLabel();
            Label4.Visible = true;
        }
        else if (string.IsNullOrEmpty(p2))
        {
            ShowOnlyLabel();
            Label6.Visible = true;
        }
        else if (string.IsNullOrEmpty(p3))
        {
            ShowOnlyLabel();
            Label7.Visible = true;
        }
        else if (string.IsNullOrEmpty(p4))
        {
            ShowOnlyLabel();
            Label5.Visible = true;
        }
        else if (!long.TryParse(TextBox4.Text.Trim(), out number) || number < 6000000000 || number > 9999999999)
        {
            ShowOnlyLabel();
            Label5.Visible = true;
        }
        else if (string.IsNullOrEmpty(p5))
        {
            ShowOnlyLabel();
            Label8.Visible = true;
        }
        else if (string.IsNullOrEmpty(p8))
        {
            ShowOnlyLabel();
            Label11.Visible = true;
        }
        else if (ds.Tables[0].Rows.Count > 0 || ds2.Tables[0].Rows.Count > 0)
        {
            ShowOnlyLabel();
            Label2.Visible = true;
        }
        else if(TextBox12.Text == "0")
        {
            string phnumber2 = TextBox12.Text.Trim();
            string phnumber = "";
            if (phnumber2 == "0")
            {
                phnumber = p4;
            }
            else
            {
                phnumber = p4 + " , " + phnumber2;
            }
            SqlCommand cm2 = new SqlCommand("INSERT INTO Complain VALUES(@id, @date, @name, @cntc, @adrr, @prod, @cmp, @wrnty, @prb , @uname , @time , @dealer)", cn);
            cm2.Parameters.AddWithValue("@id", p1);
            cm2.Parameters.AddWithValue("@date", p2);
            cm2.Parameters.AddWithValue("@name", p3);
            cm2.Parameters.AddWithValue("@cntc", phnumber);
            cm2.Parameters.AddWithValue("@adrr", p5);
            cm2.Parameters.AddWithValue("@prod", DropDownList2.SelectedValue);
            cm2.Parameters.AddWithValue("@cmp", DropDownList3.SelectedValue);
            cm2.Parameters.AddWithValue("@wrnty", DropDownList1.SelectedValue);
            cm2.Parameters.AddWithValue("@prb", p8);
            cm2.Parameters.AddWithValue("@uname", username);
            cm2.Parameters.AddWithValue("@time", time);
            cm2.Parameters.AddWithValue("@dealer", dealer);

            ShowOnlyLabel();
            Label1.Visible = true;
            cm2.ExecuteNonQuery();
            ClearFields();
            //gridbind();
            //gridbind2();
        }
        else if (TextBox12.Text != "0")  // Check if the TextBox12 is not "0"
        {
            long phoneNumber;

            // Check if the phone number is valid
            if (long.TryParse(TextBox12.Text, out phoneNumber))
            {
                // If the number is within the valid range (6000000000 <= phoneNumber <= 9999999999)
                if (phoneNumber >= 6000000000 && phoneNumber <= 9999999999)
                {
                    string phnumber2 = TextBox12.Text.Trim();
                    string phnumber = "";

                    // If the phone number is "0", we only use p4 (previous phone number)
                    if (phnumber2 == "0" || phnumber2 == p4)
                    {
                        phnumber = p4;
                    }
                    else
                    {
                        // Else concatenate p4 and the new phone number
                        phnumber = p4 + " , " + phnumber2;
                    }

                    // Insert the complaint data
                    SqlCommand cm2 = new SqlCommand("INSERT INTO Complain VALUES(@id, @date, @name, @cntc, @adrr, @prod, @cmp, @wrnty, @prb , @uname , @time , @dealer)", cn);
                    cm2.Parameters.AddWithValue("@id", p1);
                    cm2.Parameters.AddWithValue("@date", p2);
                    cm2.Parameters.AddWithValue("@name", p3);
                    cm2.Parameters.AddWithValue("@cntc", phnumber);
                    cm2.Parameters.AddWithValue("@adrr", p5);
                    cm2.Parameters.AddWithValue("@prod", DropDownList2.SelectedValue);
                    cm2.Parameters.AddWithValue("@cmp", DropDownList3.SelectedValue);
                    cm2.Parameters.AddWithValue("@wrnty", DropDownList1.SelectedValue);
                    cm2.Parameters.AddWithValue("@prb", p8);
                    cm2.Parameters.AddWithValue("@uname", username);
                    cm2.Parameters.AddWithValue("@time", time);
                    cm2.Parameters.AddWithValue("@dealer", dealer);

                    // Show success label and execute the query
                    ShowOnlyLabel();
                    Label1.Visible = true;
                    cm2.ExecuteNonQuery();
                    ClearFields();
                }
                else
                {
                    // If the phone number is out of the valid range, show error message
                    ShowOnlyLabel();
                    Label13.Visible = true;  // Show error message for invalid range
                }
            }
            else
            {
                // If the phone number is not a valid number, show error message
                ShowOnlyLabel();
                Label13.Visible = true;  // Show error message for invalid number
            }
        }

        cn.Close();
    }


    // Method to show only a specific label
    private void ShowOnlyLabel()
    {
        Label6.Visible = false;
        Label7.Visible = false;
        Label8.Visible = false;
        Label9.Visible = false;
        Label10.Visible = false;
        Label11.Visible = false;
        Label11.Visible = false;
        Label2.Visible = false;
        Label1.Visible = false;
        Label3.Visible = false;
        Label4.Visible = false;
        Label5.Visible = false;
        Label13.Visible = false;
    }

    // Method to clear input fields
    private void ClearFields()
    {
        TextBox1.Text = string.Empty;
        TextBox3.Text = string.Empty;
        TextBox4.Text = string.Empty;
        TextBox5.Text = string.Empty;
        TextBox8.Text = string.Empty;
        TextBox12.Text = string.Empty;
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        randomCallid();
    }
    public void randomCallid()
    {
        SqlConnection cn = new SqlConnection(connection);

        // Open the connection
        cn.Open();

        // Define the character set and the random number generator
        const string chars = "0123456789";
        Random random = new Random();

        string generatedCallId = string.Empty;
        bool isUnique = false;

        while (!isUnique)
        {
            // Generate the current date in ddMMyyyy format
            string currentDate = DateTime.Now.ToString("ddMMyyyy");

            // Generate a random 4-digit number
            char[] result = new char[4];
            for (int i = 0; i < result.Length; i++)
            {
                result[i] = chars[random.Next(chars.Length)];
            }

            // Concatenate to form the Call_Id in "RRSddMMyyyyXXXX" format
            generatedCallId = "RRS" + currentDate + new string(result);

            // Check if the generated Call_Id already exists in either table
            SqlCommand cm = new SqlCommand("SELECT COUNT(*) FROM (SELECT Call_Id FROM All_Complains UNION SELECT Call_Id FROM Complain) AS CombinedOrders WHERE Call_Id = @CallId", cn);
            cm.Parameters.AddWithValue("@CallId", generatedCallId);
            int count = (int)cm.ExecuteScalar();

            // If no existing Call_Id matches the generated one, we have a unique ID
            if (count == 0)
            {
                isUnique = true;
            }
        }

        // Close the connection
        cn.Close();

        // Set the generated unique Call_Id to TextBox1
        TextBox1.Text = generatedCallId;
    }
    protected void AllRegisterdComplaints()
    {
        string dealer = Session["Dealer"].ToString();
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT Call_Id , Date , Name , Contact , Address , Product , Company , Warranty , Problem , RegisBy , Time FROM Complain WHERE Dealer = @dealer", cn);
        cm.Parameters.AddWithValue("@dealer",dealer);
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataTable dt = new DataTable();
        cn.Open();
        da.Fill(dt);
        cn.Close();
        Repeater1.DataSourceID = null;
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }
    protected void PendingComplaints()
    {
        string dealer = Session["Dealer"].ToString();
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT Call_id , Date , Name , Contact , Address , Product , Company , Warranty , Problem , Assigned_To , Reason , PartPending FROM Pending_Complain WHERE Dealer = @dealer", cn);
        cm.Parameters.AddWithValue("@dealer", dealer);
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataTable dt = new DataTable();
        cn.Open();
        da.Fill(dt);
        cn.Close();
        Repeater2.DataSourceID = null;
        Repeater2.DataSource = dt;
        Repeater2.DataBind();
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(RadioButtonList1.SelectedValue == "Register Complaint")
        {
            registerSection.Visible = true;
            div2.Visible = false;
            div3.Visible = false;
            //div4.Visible = false;
        }
        else if(RadioButtonList1.SelectedValue == "All Registered Complaints")
        {
            registerSection.Visible = false;
            AllRegisterdComplaints();
            div2.Visible = true;
            div3.Visible = false;
            //div4.Visible = false;
        }
        else 
        {
            registerSection.Visible = false;
            div2.Visible = false;
            div3.Visible = true;
            PendingComplaints();
            //div4.Visible = false;
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(connection);
        cn.Open();
        SqlCommand cm = new SqlCommand("SELECT * FROM Complain WHERE Call_Id = @id", cn);
        cm.Parameters.AddWithValue("@id", TextBox6.Text);
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);
        string updateterm = DropDownList4.SelectedValue;
        string newvalue = "";
        if(updateterm == "Product")
        {
            newvalue = DropDownList5.SelectedValue;
        }
        else if(updateterm == "Company")
        {
            newvalue = DropDownList6.SelectedValue;
        }
        else if (updateterm == "Warranty")
        {
            newvalue = DropDownList7.SelectedValue;
        }
        else
        {
            newvalue = TextBox7.Text;
        }

        SqlCommand cm2 = new SqlCommand("UPDATE Complain SET " + updateterm + " = @newvalue WHERE Call_Id = @id ", cn);
        cm2.Parameters.AddWithValue("@newvalue", newvalue);
        cm2.Parameters.AddWithValue("@id", TextBox6.Text);

        if(TextBox6.Text == "")
        {
            Label12.Text = "Enter Call Id";
            Label12.Style.Add("color", "red");
            Label12.Visible = true;
        }
        else if ((updateterm != "Product" && updateterm != "Company" && updateterm != "Warranty") && TextBox7.Text == "")
        {
            Label12.Text = "Enter new value";
            Label12.Style.Add("color", "red");
            Label12.Visible = true;
        }
        else if(ds.Tables[0].Rows.Count>0)
        {
            long contactNumber;
            if (updateterm == "Contact")
            {
                if (long.TryParse(TextBox7.Text, out contactNumber) && (contactNumber < 6000000000 || contactNumber > 9999999999))
                {
                    Label12.Text = "Enter a valid number";
                    Label12.Style.Add("color", "red");
                    Label12.Visible = true;
                }
                else
                {
                    cm2.ExecuteNonQuery();
                    AllRegisterdComplaints();
                    Label12.Text = "Complaint updated successfully";
                    Label12.Style.Add("color", "green");
                    Label12.Visible = true;
                }
            }
            else
            {
                cm2.ExecuteNonQuery();
                AllRegisterdComplaints();
                Label12.Text = "Complaint updated successfully";
                Label12.Style.Add("color", "green");
                Label12.Visible = true;
            }  
        }
        else
        {
            Label12.Text = "Call Id not found";
            Label12.Style.Add("color", "red");
            Label12.Visible = true;
        }

        cn.Close();
    }
    protected void DropDownList4_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(DropDownList4.SelectedValue == "Product")
        {
            new1.Visible = false;
            new2.Visible = true;
            new3.Visible = false;
            new4.Visible = false;
        }
        else if(DropDownList4.SelectedValue == "Company")
        {
            new1.Visible = false;
            new2.Visible = false;
            new3.Visible = true;
            new4.Visible = false;
        }
        else if (DropDownList4.SelectedValue == "Warranty")
        {
            new1.Visible = false;
            new2.Visible = false;
            new3.Visible = false;
            new4.Visible = true;
        }
        else if (DropDownList4.SelectedValue == "Date")
        {
            TextBox7.TextMode = TextBoxMode.Date;
            new1.Visible = true;
            new2.Visible = false;
            new3.Visible = false;
            new4.Visible = false;
        }
        else if (DropDownList4.SelectedValue == "Contact")
        {
            TextBox7.TextMode = TextBoxMode.Number;
            new1.Visible = true;
            new2.Visible = false;
            new3.Visible = false;
            new4.Visible = false;
        }
        else
        {
            TextBox7.TextMode = TextBoxMode.SingleLine;
            new1.Visible = true;
            new2.Visible = false;
            new3.Visible = false;
            new4.Visible = false;
        }
    }
    //protected void Button4_Click1(object sender, EventArgs e)
    //{
    //    SqlConnection cn = new SqlConnection(connection);
    //    cn.Open();
    //    SqlCommand cm = new SqlCommand("SELECT * FROM Complain WHERE Call_Id = @id", cn);
    //    cm.Parameters.AddWithValue("@id", TextBox6.Text);
    //    SqlDataAdapter da = new SqlDataAdapter(cm);
    //    DataSet ds = new DataSet();
    //    da.Fill(ds);

    //    SqlCommand cm2 = new SqlCommand("DELETE FROM Complain WHERE Call_Id = @id", cn);
    //    cm2.Parameters.AddWithValue("@id", TextBox6.Text);

    //    if(TextBox6.Text=="")
    //    {
    //        Label12.Text = "Enter Call Id";
    //        Label12.Style.Add("color", "red");
    //        Label12.Visible = true;
    //    }
    //    else if(ds.Tables[0].Rows.Count>0)
    //    {
    //        cm2.ExecuteNonQuery();
    //        AllRegisterdComplaints();
    //        Label12.Text = "Complaint deleted successfully";
    //        Label12.Style.Add("color", "green");
    //        Label12.Visible = true;
    //    }
    //    else
    //    {
    //        Label12.Text = "Call Id not found";
    //        Label12.Style.Add("color", "red");
    //        Label12.Visible = true;
    //    }

    //    cn.Close();
    //}
    [WebMethod]
    public static string GetData(int draw, int start, int length, int orderColumn, string orderDir, string searchValue, string dealer)
    {
        Class1 obj = new Class1();
        string connection = obj.connectionString();
        using (SqlConnection con = new SqlConnection(connection))
        {
            con.Open();
            string whereClause = "WHERE Dealer = @dealer";
            if (!string.IsNullOrEmpty(searchValue))
            {
                whereClause += " AND (Call_Id LIKE @Search OR Date LIKE @Search OR Name LIKE @Search OR Contact LIKE @Search OR Address LIKE @Search OR Product LIKE @Search OR Company LIKE @Search OR Warranty LIKE @Search OR Problem LIKE @Search OR Assigned_To LIKE @Search OR Status LIKE @Search)";
            }

            // Sorting columns (adjust column names based on DataTable)
            string[] columnNames = { "Call_Id", "Date", "Name", "Contact", "Address", "Product", "Company", "Warranty", "Problem", "Assigned_To", "Status" };
            string orderByClause = "ORDER BY " + columnNames[orderColumn] + " " + orderDir;

            // Get total count of records
            string totalCountQuery = "SELECT COUNT(*) FROM All_Complains WHERE Dealer = @dealer";
            SqlCommand cmdTotal = new SqlCommand(totalCountQuery, con);
            cmdTotal.Parameters.AddWithValue("@dealer", dealer);
            int totalRecords = Convert.ToInt32(cmdTotal.ExecuteScalar());

            // Get count of filtered records
            string filteredCountQuery = "SELECT COUNT(*) FROM All_Complains " + whereClause;
            SqlCommand cmdFiltered = new SqlCommand(filteredCountQuery, con);
            cmdFiltered.Parameters.AddWithValue("@dealer", dealer);
            if (!string.IsNullOrEmpty(searchValue))
            {
                cmdFiltered.Parameters.AddWithValue("@Search", "%" + searchValue + "%");
            }
            int filteredRecords = Convert.ToInt32(cmdFiltered.ExecuteScalar());

            // Fetch data with sorting
            string dataQuery = "SELECT * FROM All_Complains " + whereClause + " " + orderByClause + " OFFSET @Start ROWS FETCH NEXT @Length ROWS ONLY";
            SqlCommand cmdData = new SqlCommand(dataQuery, con);
            cmdData.Parameters.AddWithValue("@Start", start);
            cmdData.Parameters.AddWithValue("@Length", length);
            cmdData.Parameters.AddWithValue("@dealer", dealer);
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
                    Name = row["Name"],
                    Contact = row["Contact"],
                    Address = row["Address"],
                    Product = row["Product"],
                    Company = row["Company"],
                    Warranty = row["Warranty"],
                    Problem = row["Problem"],
                    Assigned_To = row["Assigned_To"],
                    Status = row["Status"]
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
}