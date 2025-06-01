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
using System.Web.Configuration;
public partial class Emp_home : System.Web.UI.Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        checklogin();
        connection = obj.connectionString();
        if (!IsPostBack)
        {
            BindProductDropdown();
            BindRepeater();
            checkRepeatedComplaints();
        }
        else
        {
            RestoreSelectedProducts(); // Restore selected values on postback
            // Restore call ID from hidden field if it's there
            if (!string.IsNullOrEmpty(HiddenField1.Value))
            {
                TextBox1.Text = HiddenField1.Value;
            }
        }
    }
    protected void checklogin()
    {
        if (Session["Logindone"] == null || (bool)Session["Logindone"] == false)
        {
            Response.Redirect("Default.aspx");
        }
    }
    private void BindProductDropdown()
    {
        using (SqlConnection cn = new SqlConnection(connection))
        {
            string query = "SELECT DISTINCT Product FROM Complain";
            using (SqlCommand cmd = new SqlCommand(query, cn))
            {
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                ddlProductFilter.Items.Clear();
                while (dr.Read())
                {
                    ddlProductFilter.Items.Add(new ListItem(dr["Product"].ToString(), dr["Product"].ToString()));
                }
                dr.Close();
            }
        }
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        // Store selected products in HiddenField
        hfSelectedProducts.Value = string.Join(",", ddlProductFilter.Items.Cast<ListItem>()
                                        .Where(i => i.Selected)
                                        .Select(i => i.Value));
        BindRepeater(); // Rebind filtered data
    }
    private void RestoreSelectedProducts()
    {
        string selectedProducts = hfSelectedProducts.Value;
        if (!string.IsNullOrEmpty(selectedProducts))
        {
            string[] selectedValues = selectedProducts.Split(',');
            foreach (ListItem item in ddlProductFilter.Items)
            {
                item.Selected = selectedValues.Contains(item.Value);
            }
        }
    }


    private void BindRepeater()
    {
        if (!string.IsNullOrEmpty(ddlProductFilter.SelectedValue))
        {
            using (SqlConnection cn = new SqlConnection(connection))
            {
                string query = "SELECT * FROM Complain WHERE 1=1";

                // Get all selected values
                string selectedProducts = Request.Form[ddlProductFilter.UniqueID];
                if (!string.IsNullOrEmpty(selectedProducts))
                {
                    // Split the selected values and create dynamic query
                    string[] products = selectedProducts.Split(',');
                    string productFilter = string.Join("','", products);
                    query += string.Format(" AND Product IN ('{0}')", productFilter);
                }

                using (SqlCommand cmd = new SqlCommand(query, cn))
                {
                    cn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    Repeater1.DataSourceID = null;
                    Repeater1.DataSource = dr;
                    Repeater1.DataBind();
                    dr.Close();
                }
            }
        }
        else
        {
            RepeaterView();
        }

    }
    protected void RepeaterView()
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT * FROM Complain", cn);
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);

        Repeater1.DataSourceID = null;
        Repeater1.DataSource = ds.Tables[0];
        Repeater1.DataBind();
    }

    protected void Button99_Click(object sender, EventArgs e)
    {
        // Fetching the text from Label7 (complaint details)
        string labelText = Label7.Text;

        // Fetching the worker's phone number from Label8
        string workerPhone = Label8.Text;

        // Encode the label text for URL-safe transmission
        string message = HttpUtility.UrlEncode(labelText);

        // Validate the labelText
        if (labelText == "Complaint details will be shown here" || labelText == "Assign Work First")
        {
            labelText = "Assign Work First";
            Label7.Text = labelText;
        }
        else
        {
            // Construct WhatsApp API URL
            string whatsappUrl = "https://wa.me/91" + workerPhone + "?text=" + message;

            // Open WhatsApp URL using JavaScript from the server side
            string script = "window.open('" + whatsappUrl + "', '_blank');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "OpenWhatsApp", script, true);
        }

    }
    protected void BtnWorkDone_Click(object sender, EventArgs e)
    {
        Response.Redirect("Work_Done.aspx");
    }
    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Assign")
        {
            string callId = e.CommandArgument.ToString();
            DropDownList ddl = (DropDownList)e.Item.FindControl("DropDownList1");
            string selectedWorkerUsername = ddl.SelectedValue;

            AssignComplaint(callId, selectedWorkerUsername);
        }
    }

    protected void AssignComplaint(string callId, string selectedWorkerUsername)
    {
        if (selectedWorkerUsername == "Select Worker")
        {
            Label1.Visible = true;
        }
        else
        {
            Label1.Visible = false;
            SqlConnection cn = new SqlConnection(connection);
            SqlCommand getComplainDetailsCmd = new SqlCommand("SELECT Call_Id , Date , Name , Contact , Address , Product , Company , Warranty , Problem FROM Complain WHERE Call_Id = @id", cn);
            SqlCommand cm = new SqlCommand("insert into Proc_Complain(Call_Id , Date , Name , Contact , Address , Product , Company , Warranty , Problem , RegisBy , Time , Dealer ) select Call_Id , Date , Name , Contact , Address , Product , Company , Warranty , Problem , RegisBy , Time , Dealer FROM Complain WHERE Call_Id = @id", cn);
            SqlCommand cm0 = new SqlCommand("insert into All_Complains(Call_Id , Date , Name , Contact , Address , Product , Company , Warranty , Problem , Dealer ) select Call_Id , Date , Name , Contact , Address , Product , Company , Warranty , Problem , Dealer FROM Complain WHERE Call_Id = @id", cn);
            SqlCommand cm2 = new SqlCommand("update Proc_Complain set Assigned_To = @worker WHERE Call_Id = @id", cn);
            SqlCommand cm00 = new SqlCommand("update All_Complains set Assigned_To = @worker WHERE Call_Id = @id", cn);
            SqlCommand cm5 = new SqlCommand("update All_Complains set Status = @ip where Call_Id = @id", cn);
            SqlCommand cm3 = new SqlCommand("delete from Complain WHERE Call_Id = @id", cn);
            SqlCommand getNum = new SqlCommand("select Number FROM Worker WHERE Username = @worker", cn);
            cm.Parameters.AddWithValue("@id", callId);
            cm0.Parameters.AddWithValue("@id", callId);
            cm00.Parameters.AddWithValue("@worker", selectedWorkerUsername);
            cm2.Parameters.AddWithValue("@worker", selectedWorkerUsername);
            cm00.Parameters.AddWithValue("@id", callId);
            cm2.Parameters.AddWithValue("@id", callId);
            cm5.Parameters.AddWithValue("@id", callId);
            cm5.Parameters.AddWithValue("@ip", "In Process");
            cm3.Parameters.AddWithValue("@id", callId);
            getComplainDetailsCmd.Parameters.AddWithValue("@id", callId);
            getNum.Parameters.AddWithValue("@worker", selectedWorkerUsername);
            cn.Open();
            SqlDataReader reader = getComplainDetailsCmd.ExecuteReader();

            if (reader.Read())
            {
                // Construct complaint details to display in Label7
                string complainDetails = "Call ID: " + reader["Call_Id"].ToString() + "\n " +
                                         "Date: " + reader["Date"].ToString() + "\n " +
                                         "Name: " + reader["Name"].ToString() + "\n " +
                                         "Contact: " + reader["Contact"].ToString() + "\n " +
                                         "Address: " + reader["Address"].ToString() + "\n " +
                                         "Product: " + reader["Product"].ToString() + "\n " +
                                         "Company: " + reader["Company"].ToString() + "\n " +
                                         "Warranty: " + reader["Warranty"].ToString() + "\n " +
                                         "Problem: " + reader["Problem"].ToString();

                Label7.Text = complainDetails;
            }
            reader.Close();
            cm0.ExecuteNonQuery();
            cm00.ExecuteNonQuery();
            cm5.ExecuteNonQuery();
            cm.ExecuteNonQuery();
            cm2.ExecuteNonQuery();
            cm3.ExecuteNonQuery();
            string phnum = (string)getNum.ExecuteScalar();
            Label8.Text = phnum;
            div1.Visible = true;
            cn.Close();
            div2.Visible = true;
            BindRepeater();
        }
    }
    protected void Button7_Click(object sender, EventArgs e)
    {
        div2.Visible = false;
        // Fetching the text from Label7 (complaint details)
        string labelText = Label7.Text;

        // Fetching the worker's phone number from Label8
        string workerPhone = Label8.Text;

        // Encode the label text for URL-safe transmission
        string message = HttpUtility.UrlEncode(labelText);

        // Validate the labelText
        if (labelText == "Complaint details will be shown here" || labelText == "Assign Work First")
        {
            labelText = "Assign Work First";
            Label7.Text = labelText;
        }
        else
        {
            // Construct WhatsApp API URL
            string whatsappUrl = "https://wa.me/91" + workerPhone + "?text=" + message;

            // Open WhatsApp URL using JavaScript from the server side
            string script = "window.open('" + whatsappUrl + "', '_blank');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "OpenWhatsApp", script, true);
        }
    }
    protected void Button8_Click(object sender, EventArgs e)
    {
        div2.Visible = false;
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        string oldCallId = TextBox2.Text;
        ViewState["OldCallId"] = oldCallId;
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("UPDATE Complain SET Call_Id = @newid WHERE Call_Id = @oldid", cn);
        cm.Parameters.AddWithValue("@newid", TextBox3.Text);
        cm.Parameters.AddWithValue("@oldid", oldCallId);
        SqlCommand cm2 = new SqlCommand("SELECT * FROM Complain WHERE Call_Id = @oldid", cn);
        cm2.Parameters.AddWithValue("@oldid", oldCallId);
        SqlCommand cm3 = new SqlCommand("SELECT * FROM Complain WHERE Call_Id = @newid", cn);
        cm3.Parameters.AddWithValue("@newid", TextBox3.Text);
        SqlCommand cm4 = new SqlCommand("SELECT * FROM All_Complains WHERE Call_Id = @newid", cn);
        cm4.Parameters.AddWithValue("@newid", TextBox3.Text);

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);

        SqlDataAdapter da2 = new SqlDataAdapter(cm3);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2);

        SqlDataAdapter da3 = new SqlDataAdapter(cm4);
        DataSet ds3 = new DataSet();
        da3.Fill(ds3);

        cn.Open();
        if (TextBox2.Text == "")
        {
            Label5.Text = "Enter Old Call Id";
            Label5.Visible = true;
            Label6.Visible = false;
            TextBox2.Text = oldCallId;
        }
        else if (TextBox3.Text == "")
        {
            Label5.Text = "Enter New Call Id";
            Label5.Visible = true;
            Label6.Visible = false;
            TextBox2.Text = oldCallId;
        }
        else if (ds2.Tables[0].Rows.Count > 0 || ds3.Tables[0].Rows.Count > 0)
        {
            Label5.Text = "New Call Id already exists";
            Label5.Visible = true;
            Label6.Visible = false;
            TextBox2.Text = oldCallId;
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            cm.ExecuteNonQuery();
            RepeaterView();
            Label6.Visible = true;
            Label5.Visible = false;
            TextBox2.Text = oldCallId;
        }
        else
        {
            Label5.Text = "Old Call Id not found";
            Label5.Visible = true;
            Label6.Visible = false;
            TextBox2.Text = oldCallId;
        }
        cn.Close();
    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        // Get the Call_Id from the CommandArgument (passed from the button inside the GridView)
        Button button = (Button)sender;
        string callId = button.CommandArgument.ToString();

        // Perform the delete operation
        DeleteCallById(callId);
    }

    private void DeleteCallById(string callId)
    {
        string query = "DELETE FROM Complain WHERE Call_Id = @CallId";
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand(query, cn);
        cm.Parameters.AddWithValue("@CallId", callId);
        cn.Open();
        cm.ExecuteNonQuery();
        RepeaterView();
        cn.Close();
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        // Get the LinkButton that was clicked
        LinkButton btn = (LinkButton)sender;

        // Retrieve the CommandArgument (Call_Id) from the clicked LinkButton
        string callId = btn.CommandArgument;

        // Set the value of TextBox8 with the retrieved Call_Id
        TextBox2.Text = callId;
        Label6.Visible = false;
        TextBox3.Text = null;
        // Make the popup visible
        ClientScript.RegisterStartupScript(this.GetType(), "PopupState", "openPopup();", true);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string selectedWorker = DropDownList2.SelectedValue;

        if (selectedWorker == "Select Worker")
        {
            Label1.Text = "Please select a valid worker.";
            Label1.Visible = true;
            return;
        }

        SqlConnection cn = new SqlConnection(connection);
        cn.Open();

        List<string> complaintDetailsList = new List<string>();
        List<string> phoneNumbers = new List<string>();

        foreach (RepeaterItem item in Repeater1.Items)
        {
            CheckBox chk = (CheckBox)item.FindControl("CheckBox1");
            if (chk != null && chk.Checked)
            {
                string callId = ((HiddenField)item.FindControl("HiddenField_CallId")).Value;

                SqlCommand getComplainDetailsCmd = new SqlCommand("SELECT Call_Id, Date, Name, Contact, Address, Product, Company, Warranty, Problem FROM Complain WHERE Call_Id = @id", cn);
                getComplainDetailsCmd.Parameters.AddWithValue("@id", callId);

                SqlCommand cm = new SqlCommand("INSERT INTO Proc_Complain(Call_Id, Date, Name, Contact, Address, Product, Company, Warranty, Problem, RegisBy, Time, Dealer) " +
                                               "SELECT Call_Id, Date, Name, Contact, Address, Product, Company, Warranty, Problem, RegisBy , Time , Dealer FROM Complain WHERE Call_Id = @id", cn);
                cm.Parameters.AddWithValue("@id", callId);

                SqlCommand cm0 = new SqlCommand("INSERT INTO All_Complains(Call_Id, Date, Name, Contact, Address, Product, Company, Warranty, Problem , Dealer) " +
                                                "SELECT Call_Id, Date, Name, Contact, Address, Product, Company, Warranty, Problem, Dealer FROM Complain WHERE Call_Id = @id", cn);
                cm0.Parameters.AddWithValue("@id", callId);

                SqlCommand cm2 = new SqlCommand("UPDATE Proc_Complain SET Assigned_To = @worker WHERE Call_Id = @id", cn);
                cm2.Parameters.AddWithValue("@worker", selectedWorker);
                cm2.Parameters.AddWithValue("@id", callId);

                SqlCommand cm00 = new SqlCommand("UPDATE All_Complains SET Assigned_To = @worker WHERE Call_Id = @id", cn);
                cm00.Parameters.AddWithValue("@worker", selectedWorker);
                cm00.Parameters.AddWithValue("@id", callId);

                SqlCommand cm5 = new SqlCommand("UPDATE All_Complains SET Status = @status WHERE Call_Id = @id", cn);
                cm5.Parameters.AddWithValue("@status", "In Process");
                cm5.Parameters.AddWithValue("@id", callId);

                SqlCommand cm3 = new SqlCommand("DELETE FROM Complain WHERE Call_Id = @id", cn);
                cm3.Parameters.AddWithValue("@id", callId);

                SqlCommand getNum = new SqlCommand("SELECT Number FROM Worker WHERE Username = @worker", cn);
                getNum.Parameters.AddWithValue("@worker", selectedWorker);

                // Get Complaint Details
                SqlDataReader reader = getComplainDetailsCmd.ExecuteReader();
                if (reader.Read())
                {
                    string complaintDetails = "Call ID: " + reader["Call_Id"].ToString() + "\n" +
                                              "Date: " + reader["Date"].ToString() + "\n" +
                                              "Name: " + reader["Name"].ToString() + "\n" +
                                              "Contact: " + reader["Contact"].ToString() + "\n" +
                                              "Address: " + reader["Address"].ToString() + "\n" +
                                              "Product: " + reader["Product"].ToString() + "\n" +
                                              "Company: " + reader["Company"].ToString() + "\n" +
                                              "Warranty: " + reader["Warranty"].ToString() + "\n" +
                                              "Problem: " + reader["Problem"].ToString();

                    complaintDetailsList.Add(complaintDetails);
                }
                reader.Close();

                cm.ExecuteNonQuery();
                cm0.ExecuteNonQuery();
                cm2.ExecuteNonQuery();
                cm00.ExecuteNonQuery();
                cm5.ExecuteNonQuery();
                cm3.ExecuteNonQuery();

                string phoneNumber = (string)getNum.ExecuteScalar();
                if (!string.IsNullOrEmpty(phoneNumber))
                {
                    phoneNumbers.Add(phoneNumber);
                }
            }
        }

        cn.Close();

        // Send WhatsApp messages one by one using JavaScript delay
        if (complaintDetailsList.Count > 0 && phoneNumbers.Count > 0)
        {
            string script = "<script type='text/javascript'>\n";
            script += "var complaints = [" + string.Join(",", complaintDetailsList.Select(d => "'" + HttpUtility.JavaScriptStringEncode(d) + "'")) + "];\n";
            script += "var phones = [" + string.Join(",", phoneNumbers.Select(p => "'" + p + "'")) + "];\n";
            script += @"
            function sendMessage(index) {
                if (index < complaints.length) {
                    var message = encodeURIComponent(complaints[index]);
                    var phone = phones[index];
                    var whatsappUrl = 'https://wa.me/91' + phone + '?text=' + message;
                    window.open(whatsappUrl, '_blank');
                    setTimeout(function() {
                        sendMessage(index + 1);
                    }, 5000); // 3-second delay between messages
                }
            }
            sendMessage(0);
        ";
            script += "</script>";

            ClientScript.RegisterStartupScript(this.GetType(), "SendWhatsAppMessages", script);
        }

        RepeaterView();
    }

    protected void btnClearFilter_Click(object sender, EventArgs e)
    {
        hfSelectedProducts.Value = null;
        ddlProductFilter.SelectedValue = null;
        RepeaterView();
    }
    protected void checkRepeatedComplaints()
    {
        List<string> repeatedCallIds = new List<string>();

        using (SqlConnection cn = new SqlConnection(connection))
        {
            cn.Open();

            // Step 1: Get all contacts, products, companies, warranties, and dates from All_Complains
            SqlCommand cmAll = new SqlCommand("SELECT Contact, Product, Company, Warranty, Date FROM All_Complains", cn);
            Dictionary<string, List<Tuple<string, string, string, DateTime>>> allComplainsDict = new Dictionary<string, List<Tuple<string, string, string, DateTime>>>();

            using (SqlDataReader drAll = cmAll.ExecuteReader())
            {
                while (drAll.Read())
                {
                    string contactRaw = drAll["Contact"].ToString();
                    string product = drAll["Product"].ToString();
                    string company = drAll["Company"].ToString();
                    string warranty = drAll["Warranty"].ToString();
                    string dateStr = drAll["Date"].ToString();
                    DateTime complaintDate;

                    if (DateTime.TryParse(dateStr, out complaintDate))
                    {
                        string[] contactNumbers = contactRaw.Split(',', ' ', ';');

                        foreach (string contact in contactNumbers)
                        {
                            string cleanContact = contact.Trim();
                            if (cleanContact != "")
                            {
                                if (!allComplainsDict.ContainsKey(cleanContact))
                                    allComplainsDict[cleanContact] = new List<Tuple<string, string, string, DateTime>>();

                                allComplainsDict[cleanContact].Add(new Tuple<string, string, string, DateTime>(product, company, warranty, complaintDate));
                            }
                        }
                    }
                }
            }

            // Step 2: Get contacts, products, companies, warranties, dates, and call ids from Complain table
            SqlCommand cm = new SqlCommand("SELECT Contact, Product, Company, Warranty, Date, Call_Id FROM Complain", cn);
            using (SqlDataReader dr = cm.ExecuteReader())
            {
                while (dr.Read())
                {
                    string contactRaw = dr["Contact"].ToString();
                    string product = dr["Product"].ToString();
                    string company = dr["Company"].ToString();
                    string warranty = dr["Warranty"].ToString();
                    string dateStr = dr["Date"].ToString();
                    string callId = dr["Call_Id"].ToString();
                    DateTime complaintDate;

                    if (DateTime.TryParse(dateStr, out complaintDate))
                    {
                        string[] contactNumbers = contactRaw.Split(',', ' ', ';');

                        foreach (string contact in contactNumbers)
                        {
                            string cleanContact = contact.Trim();
                            if (cleanContact != "")
                            {
                                if (allComplainsDict.ContainsKey(cleanContact))
                                {
                                    foreach (Tuple<string, string, string, DateTime> prev in allComplainsDict[cleanContact])
                                    {
                                        if (prev.Item1 == product && prev.Item2 == company && prev.Item3.ToLower() == "in warranty")
                                        {
                                            if ((complaintDate - prev.Item4).TotalDays <= 90)
                                            {
                                                repeatedCallIds.Add(callId);
                                                goto SkipRemaining; // break outer loop
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                SkipRemaining: ;
                }
            }
        }

        // Store in session
        Session["RepeatedCallIds"] = repeatedCallIds;
    }
    protected void Cancel_Click(object sender, EventArgs e)
    {
        DateTime datee = DateTime.Now.Date;
        string cudate = datee.ToString("yyyy-MM-dd");
        string callId = TextBox1.Text.Trim();
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm0 = new SqlCommand("SELECT * FROM All_Complains WHERE Call_Id = @id", cn);
        cm0.Parameters.AddWithValue("@id", callId);
        SqlDataAdapter da2 = new SqlDataAdapter(cm0);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2);
        SqlCommand cm = new SqlCommand("SELECT * FROM Complain WHERE Call_Id = @id", cn);
        cm.Parameters.AddWithValue("@id", callId);

        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if(ds2.Tables[0].Rows.Count>0)
        {
            SqlCommand cmdelete = new SqlCommand("DELETE FROM Complain WHERE Call_Id = @id", cn);
            cmdelete.Parameters.AddWithValue("@id", callId);
            cn.Open();
            cmdelete.ExecuteNonQuery();
            cn.Close();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "document.getElementById('cancelModal').style.display='block';", true);
            Label19.Visible = false;
            Label18.Visible = true;
            Label18.Style.Add("color", "green");
            Label18.Text = "Call Cancelled Successfully";
            BindRepeater();
        }
        else
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (string.IsNullOrEmpty(TextBox13.Text.Trim()))
                {
                    Label19.Visible = true;
                    Label19.Text = "Enter Reason";

                    // Tell the client to reopen the modal
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "document.getElementById('cancelModal').style.display='block';", true);
                    TextBox1.Text = callId;
                    return;
                }

                SqlCommand cm2 = new SqlCommand(@"INSERT INTO Work_Done(Call_id, Date, CC_Date, Name, Contact, Address, Product, Company, Warranty, Problem, WorkDoneBy, Details, Charges, ToPay, ItemCode, Def_Return) 
                SELECT Call_Id, Date, @CC_Date, Name, Contact, Address, Product, Company, Warranty, Problem, @WorkDoneBy, @Details, @Charges, @ToPay, @ItemCode, @Def_Return 
                FROM Complain WHERE Call_Id = @id", cn);

                cm2.Parameters.AddWithValue("@id", callId);
                cm2.Parameters.AddWithValue("@CC_Date", cudate);
                cm2.Parameters.AddWithValue("@WorkDoneBy", "Cancel");
                cm2.Parameters.AddWithValue("@Details", TextBox13.Text.Trim());
                cm2.Parameters.AddWithValue("@Charges", "-");
                cm2.Parameters.AddWithValue("@ToPay", "-");
                cm2.Parameters.AddWithValue("@ItemCode", "-");
                cm2.Parameters.AddWithValue("@Def_Return", "-");

                SqlCommand cm3 = new SqlCommand(@"INSERT INTO All_Complains(Call_Id, Date, Name, Contact, Address, Product, Company, Warranty, Problem, Assigned_To, Status) 
                SELECT Call_Id, Date, Name, Contact, Address, Product, Company, Warranty, Problem, @upv, @reason FROM Complain WHERE Call_Id = @id", cn);
                cm3.Parameters.AddWithValue("@reason", TextBox13.Text.Trim());
                cm3.Parameters.AddWithValue("@upv", "Cancel");
                cm3.Parameters.AddWithValue("@id", callId);

                SqlCommand cm4 = new SqlCommand("DELETE FROM Complain WHERE Call_id = @id", cn);
                cm4.Parameters.AddWithValue("@id", callId);

                cn.Open();
                cm2.ExecuteNonQuery();
                cm3.ExecuteNonQuery();
                cm4.ExecuteNonQuery();
                cn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "document.getElementById('cancelModal').style.display='block';", true);
                Label19.Visible = false;
                Label18.Visible = true;
                Label18.Style.Add("color", "green");
                Label18.Text = "Call Cancelled Successfully";
                BindRepeater();
            }
            else
            {
                Label19.Visible = true;
                Label19.Text = "Call ID not found";
                TextBox1.Text = callId;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "document.getElementById('cancelModal').style.display='block';", true);
            }
        }
    }
}


