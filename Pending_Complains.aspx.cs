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
using Newtonsoft.Json;
public partial class Pending_Complains : System.Web.UI.Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        checklogin();
        connection = obj.connectionString();
        if(!IsPostBack)
        {
            BindRepeater();
        }
        else
        {
            // Restore call ID from hidden field if it's there
            if (!string.IsNullOrEmpty(HiddenField1.Value))
            {
                TextBox1.Text = HiddenField1.Value;
            }
            if (string.IsNullOrEmpty(TextBox8.Text))
            {
                // Restore from hidden field in case it's empty
                TextBox8.Text = HiddenCallId.Value;
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
    private void BindRepeater()
    {
        using (SqlConnection conn = new SqlConnection(connection))
        {
            string query = "SELECT * FROM All_Complaints WHERE Status = 'Pending'";
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            conn.Open();
            da.Fill(dt);
            conn.Close();

            rptComplaints.DataSource = dt;
            rptComplaints.DataBind();
        }
    }
    protected void Done_Click(object sender, EventArgs e)
    {
        validateuser5(TextBox5.Text.Trim(), TextBox6.Text.Trim(), TextBox7.Text.Trim(), TextBox10.Text.Trim());
    }

    protected void validateuser5(string p1, string p2, string p3, string p4)
    {
        DateTime datee = DateTime.Now.Date;
        string cudate = datee.ToString("yyyy-MM-dd");
        SqlConnection cn = new SqlConnection(connection);

        // Initial SQL Commands (to be executed after validation)
        SqlCommand cm0 = new SqlCommand("UPDATE All_Complaints SET Status = 'Done', Details = @details, Charges = @charge, ToPay = @topay, CC_Date = @ccdate, ItemCode = @itmcode, Def_return = @defrtn WHERE Call_id = @id", cn);
        //SqlCommand cm = new SqlCommand("delete from Pending_Complain where Call_id = @id", cn);
        SqlCommand cm2 = new SqlCommand("SELECT * FROM All_Complaints WHERE Call_id = @id", cn);
        //SqlCommand cm3 = new SqlCommand("update All_Complains set status = @done where Call_id = @id", cn);
        //SqlCommand cm4 = new SqlCommand("update Work_Done set Details = @details Where Call_id = @id", cn);
        //SqlCommand cm5 = new SqlCommand("update Work_Done set Charges = @charge WHERE Call_id = @id", cn);
        //SqlCommand cm6 = new SqlCommand("update Work_Done set ToPay = @topay WHERE Call_id = @id", cn);
        //SqlCommand cm06 = new SqlCommand("update Work_Done set CC_Date = @ccdate WHERE Call_id = @id", cn);
        //SqlCommand cm9 = new SqlCommand("update Work_Done set ItemCode = @itmcode WHERE Call_id = @id", cn);
        //SqlCommand cm8 = new SqlCommand("update Work_Done set Def_Return = @defrtn WHERE Call_id = @id", cn);

        cn.Open();
        cm0.Parameters.AddWithValue("@id", p1);
        //cm.Parameters.AddWithValue("@id", p1);
        cm2.Parameters.AddWithValue("@id", p1);
        //cm3.Parameters.AddWithValue("@id", p1);
        cm0.Parameters.AddWithValue("@done", p2);
        cm0.Parameters.AddWithValue("@details", p2);
        //cm4.Parameters.AddWithValue("@id", p1);
        cm0.Parameters.AddWithValue("@charge", p3);
        //cm5.Parameters.AddWithValue("@id", p1);
        cm0.Parameters.AddWithValue("@topay", p4);
        //cm6.Parameters.AddWithValue("@id", p1);
        cm0.Parameters.AddWithValue("@ccdate", cudate);
        //cm06.Parameters.AddWithValue("@id", p1);
        cm0.Parameters.AddWithValue("@itmcode", TextBox11.Text);  // Part code from TextBox11
        //cm9.Parameters.AddWithValue("@id", p1);
        cm0.Parameters.AddWithValue("@defrtn", DropDownList5.SelectedValue);  // Default return from DropDownList5
        //cm8.Parameters.AddWithValue("@id", p1);

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);

        if (p1 == "")
        {
            Label7.Text = "<b>Enter ID</b>";
            Label7.Style.Add("color", "red");
        }
        else if (p2 == "")
        {
            Label7.Text = "<b>Enter Details</b>";
            Label7.Style.Add("color", "red");
        }
        else if (p3 == "")
        {
            Label7.Text = "<b>Enter Charges</b>";
            Label7.Style.Add("color", "red");
        }
        else if (p4 == "")
        {
            Label7.Text = "<b>Enter pay charges</b>";
            Label7.Style.Add("color", "red");
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            if (CheckBox2.Checked == true)
            {
                if (string.IsNullOrEmpty(TextBox11.Text))
                {
                    Label7.Text = "<b>Enter part code</b>";
                    Label7.Style.Add("color", "red");
                }
                else if (string.IsNullOrEmpty(TextBox12.Text))
                {
                    Label7.Text = "<b>Enter part code charge</b>";
                    Label7.Style.Add("color", "red");
                }
                else
                {
                    // Split part codes and trim whitespace
                    string[] partCodes = TextBox11.Text.Split(',').Select(code => code.Trim()).ToArray();

                    // Dynamically create the parameterized query for the part codes
                    string query = "SELECT ItemCode FROM Stock WHERE ItemCode IN (";
                    for (int i = 0; i < partCodes.Length; i++)
                    {
                        query += "@code" + i + (i < partCodes.Length - 1 ? ", " : ")");
                    }

                    // Prepare the command with dynamic query
                    SqlCommand cm7 = new SqlCommand(query, cn);
                    for (int i = 0; i < partCodes.Length; i++)
                    {
                        cm7.Parameters.AddWithValue("@code" + i, partCodes[i]);
                    }

                    SqlDataReader reader = cm7.ExecuteReader();
                    HashSet<string> availableCodes = new HashSet<string>();
                    while (reader.Read())
                    {
                        availableCodes.Add(reader["ItemCode"].ToString());
                    }
                    reader.Close();

                    // Find missing codes
                    var missingCodes = partCodes.Except(availableCodes).ToArray();
                    if (missingCodes.Length > 0)
                    {
                        Label7.Text = "<b>Part codes not found: " + string.Join(", ", missingCodes) + "</b>";
                        Label7.Style.Add("color", "red");
                        cn.Close();
                        return;
                    }

                    // If all part codes are available, execute the stock-related queries first
                    foreach (string code in partCodes)
                    {
                        SqlCommand cm12 = new SqlCommand("INSERT INTO Stock_History (BillNo, BillDate, ItemCode, ItemDisc, Company, Rate , Chargetkn , TransactionType , TransactionDate , Call_Id , Reason) SELECT BillNo, BillDate, ItemCode, ItemDisc, Company, Rate , @chtkn , @TransactionType , @TransactionDate , @Call_Id , @Reason FROM Stock WHERE ItemCode = @code", cn);
                        cm12.Parameters.AddWithValue("@code", code);
                        cm12.Parameters.AddWithValue("@TransactionType", "Sale");
                        cm12.Parameters.AddWithValue("@TransactionDate", cudate);
                        cm12.Parameters.AddWithValue("@Call_Id", TextBox5.Text);
                        cm12.Parameters.AddWithValue("@Reason", "-");
                        cm12.Parameters.AddWithValue("@chtkn", TextBox12.Text);

                        SqlCommand cm00 = new SqlCommand("DELETE FROM Stock WHERE ItemCode = @code", cn);
                        cm00.Parameters.AddWithValue("@code", code);

                        cm12.ExecuteNonQuery();
                        cm00.ExecuteNonQuery();
                    }

                    // Now execute the remaining queries for Work_Done updates
                    cm0.ExecuteNonQuery();
                    //cm.ExecuteNonQuery();
                    //cm06.ExecuteNonQuery();
                    //cm6.ExecuteNonQuery();
                    //cm4.ExecuteNonQuery();
                    //cm5.ExecuteNonQuery();
                    //cm3.ExecuteNonQuery();
                    //cm9.ExecuteNonQuery();  // Update ItemCode
                    //cm8.ExecuteNonQuery();  // Update Def_Return

                    // Final success message
                    Label7.CssClass = "Success";
                    Label7.Text = "<b>Work Done</b>";
                    Label7.Style.Add("color", "green");
                    // Clear textboxes
                    TextBox5.Text = string.Empty;
                    TextBox6.Text = string.Empty;
                    TextBox7.Text = string.Empty;

                    // Refresh the grid view
                    BindRepeater();
                }
            }
            else
            {
                // Handle case when checkbox is unchecked
                SqlCommand cm10 = new SqlCommand("update All_Complaints set ItemCode = @code WHERE Call_id = @id", cn);
                cm10.Parameters.AddWithValue("@code", "-");
                cm10.Parameters.AddWithValue("@id", p1);

                SqlCommand cm11 = new SqlCommand("update All_Complaints set Def_Return = @def WHERE Call_id = @id", cn);
                cm11.Parameters.AddWithValue("@def", "-");
                cm11.Parameters.AddWithValue("@id", p1);

                cm0.ExecuteNonQuery();
                //cm.ExecuteNonQuery();
                //cm06.ExecuteNonQuery();
                //cm6.ExecuteNonQuery();
                //cm4.ExecuteNonQuery();
                //cm5.ExecuteNonQuery();
                //cm3.ExecuteNonQuery();
                cm10.ExecuteNonQuery();
                cm11.ExecuteNonQuery();

                Label7.Style.Add("color", "green");
                Label7.Text = "<b>Work Done</b>";
                TextBox5.Text = string.Empty;
                TextBox6.Text = string.Empty;
                TextBox7.Text = string.Empty;
                BindRepeater();
            }
        }
        else
        {
            // Error if ID is not found
            Label7.Style.Add("color", "red");
            Label7.Text = "<b>ID not found</b>";
        }

        cn.Close();
    }
    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {
        if (CheckBox2.Checked == true)
        {
            partdiv.Visible = true;
        }
        else
        {
            partdiv.Visible = false;
        }
    }
    protected void BtnPendingComplains_Click(object sender, EventArgs e)
    {
        Response.Redirect("Work_Done.aspx");
    }
   protected void Button1_Click(object sender, EventArgs e)
{
    bool keepPopupOpen = true; // Assume the popup should stay open by default.
    string callId = TextBox8.Text.Trim();
    using (SqlConnection cn = new SqlConnection(connection))
    {
        SqlCommand cmCheckNewId = new SqlCommand("SELECT 1 FROM All_Complaints WHERE Call_Id = @nid", cn);
        cmCheckNewId.Parameters.AddWithValue("@nid", TextBox9.Text);

        SqlCommand cmCheckOldId = new SqlCommand("SELECT 1 FROM All_Complaints WHERE Call_id = @oid", cn);
        cmCheckOldId.Parameters.AddWithValue("@oid", TextBox8.Text);

        try
        {
            cn.Open();

            if (string.IsNullOrEmpty(TextBox8.Text))
            {
                Label13.Visible = true;
                Label13.Text = "Enter Old Call Id";
                Label13.Style.Add("Color", "red");
                return;
            }
            else if (string.IsNullOrEmpty(TextBox9.Text))
            {
                Label13.Visible = true;
                Label13.Text = "Enter New Call Id";
                Label13.Style.Add("Color", "red");
                return;
            }

            bool newIdExists = cmCheckNewId.ExecuteScalar() != null;
            if (newIdExists)
            {
                Label13.Visible = true;
                Label13.Text = "New Call Id already exists";
                Label13.Style.Add("Color", "red");
                return;
            }

            bool oldIdExists = cmCheckOldId.ExecuteScalar() != null;
            if (!oldIdExists)
            {
                Label13.Visible = true;
                Label13.Text = "Old Call Id not found";
                Label13.Style.Add("Color", "red");
                return;
            }

            SqlCommand cmUpdateAllComplains = new SqlCommand("UPDATE All_Complaints SET Call_Id = @nid WHERE Call_Id = @oid", cn);
            cmUpdateAllComplains.Parameters.AddWithValue("@nid", TextBox9.Text);
            cmUpdateAllComplains.Parameters.AddWithValue("@oid", TextBox8.Text);

            //SqlCommand cmUpdatePendingComplain = new SqlCommand("UPDATE Pending_Complain SET Call_id = @nid WHERE Call_id = @oid", cn);
            //cmUpdatePendingComplain.Parameters.AddWithValue("@nid", TextBox9.Text);
            //cmUpdatePendingComplain.Parameters.AddWithValue("@oid", TextBox8.Text);

            cmUpdateAllComplains.ExecuteNonQuery();
            //cmUpdatePendingComplain.ExecuteNonQuery();

            Label13.Visible = true;
            Label13.Text = "Call Id Updated Successfully";
            Label13.Style.Add("Color", "green");
            BindRepeater();
            keepPopupOpen = false; // Close the popup after success.
        }
        catch (Exception ex)
        {
            Label13.Visible = true;
            Label13.Text = "An error occurred: " + ex.Message;
            Label13.Style.Add("Color", "red");
        }
        finally
        {
            // Pass the popup state to the client-side.
            ClientScript.RegisterStartupScript(this.GetType(), "PopupState", "keepPopupOpen(" + keepPopupOpen.ToString().ToLower() + ");", true);
        }
    }
}

    //protected void Button6_OnCommand(object sender, CommandEventArgs e)
    //{
    //    if (e.CommandName == "DeleteRow")
    //    {
    //        string callId = e.CommandArgument.ToString();  // Get the Call_Id of the row
    //        DeleteComplaintById(callId); // Delete the complaint by Call_Id
    //    }
    //}
    //private void DeleteComplaintById(string callId)
    //{
    //    // Your connection string, and SQL query for deletion
    //    string query = "DELETE FROM Pending_Complain WHERE Call_Id = @Call_Id";
    //    string query2 = "DELETE FROM All_Complains WHERE Call_Id = @Call_Id AND Status = @stus";
    //    using (SqlConnection conn = new SqlConnection(connection))
    //    {
    //        SqlCommand cmd = new SqlCommand(query, conn);
    //        cmd.Parameters.AddWithValue("@Call_Id", callId);
    //        SqlCommand cmd2 = new SqlCommand(query2, conn);
    //        cmd2.Parameters.AddWithValue("@Call_Id", callId);
    //        cmd2.Parameters.AddWithValue("@stus", "Pending");
    //        conn.Open();
    //        cmd.ExecuteNonQuery();
    //        cmd2.ExecuteNonQuery();
    //        conn.Close();
    //        BindRepeater();
    //    }
    //}
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        // Get the LinkButton that was clicked
        LinkButton btn = (LinkButton)sender;

        // Retrieve the CommandArgument (Call_Id) from the clicked LinkButton
        string callId = btn.CommandArgument;

        // Set the value of TextBox8 with the retrieved Call_Id
        TextBox8.Text = callId;

        // Make the popup visible
        ClientScript.RegisterStartupScript(this.GetType(), "PopupState", "openPopup();", true);
    }

    protected void btnReAssign_Click(object sender, EventArgs e)
    {
        validateuser(TextBox2.Text.Trim(), DropDownList4.SelectedValue);
    }
    protected void validateuser(string p1, string p2)
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm1 = new SqlCommand("UPDATE All_Complaints SET Assigned_To = @assign WHERE Call_Id = @id", cn);
        //SqlCommand cm0 = new SqlCommand("UPDATE All_Complains SET Assigned_To = @worker WHERE Call_id = @id", cn);
        SqlCommand cm2 = new SqlCommand("SELECT * FROM All_Complaints WHERE Call_Id = @id", cn);
        SqlCommand cmread = new SqlCommand("SELECT Call_Id, Date, Name, Contact, Address, Product, Company, Warranty, Problem FROM All_Complaints WHERE Call_Id = @id", cn);
        SqlCommand phnum = new SqlCommand("SELECT Number FROM Worker WHERE Username = @name", cn);

        cn.Open();

        cm1.Parameters.AddWithValue("@assign", p2);
        cm1.Parameters.AddWithValue("@id", p1);
        //cm0.Parameters.AddWithValue("@worker", p2);
        //cm0.Parameters.AddWithValue("@id", p1);
        cm2.Parameters.AddWithValue("@id", p1);
        cmread.Parameters.AddWithValue("@id", p1);
        phnum.Parameters.AddWithValue("@name", p2);

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);

        if (p1 == "")
        {
            LabelMessage.Style.Add("color", "red");
            LabelMessage.Text = "<b>Enter ID</b>";
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            if (DropDownList4.SelectedValue == "New Complaint")
            {
                SqlCommand transfer = new SqlCommand("UPDATE All_Complaints SET Status = 'New',Assigned_To = '' WHERE Call_Id = @id", cn);
                transfer.Parameters.AddWithValue("@id", p1);
                //SqlCommand deleteinproc = new SqlCommand("DELETE FROM Pending_Complain WHERE Call_Id = @id", cn);
                //deleteinproc.Parameters.AddWithValue("@id", p1);
                //SqlCommand deleteallcomp = new SqlCommand("DELETE FROM All_Complains WHERE Call_Id = @id", cn);
                //deleteallcomp.Parameters.AddWithValue("@id", p1);

                transfer.ExecuteNonQuery();
                //deleteinproc.ExecuteNonQuery();
                //deleteallcomp.ExecuteNonQuery();
                LabelMessage.Text = "<b><br>Complaint transfered successfully</b>";
                LabelMessage.Style.Add("color", "green");
                TextBox2.Text = string.Empty;
                BindRepeater();

            }
            else if (DropDownList4.SelectedValue == "Select Worker")
            {
                LabelMessage.Text = "Select Worker";
                LabelMessage.Visible = true;
            }
            else
            {
                // Reading complaint details
                SqlDataReader reader = cmread.ExecuteReader();
                if (reader.Read())
                {
                    string complainDetails = "Call ID: " + reader["Call_Id"].ToString() + "\n" +
                                             "Date: " + reader["Date"].ToString() + "\n" +
                                             "Name: " + reader["Name"].ToString() + "\n" +
                                             "Contact: " + reader["Contact"].ToString() + "\n" +
                                             "Address: " + reader["Address"].ToString() + "\n" +
                                             "Product: " + reader["Product"].ToString() + "\n" +
                                             "Company: " + reader["Company"].ToString() + "\n" +
                                             "Warranty: " + reader["Warranty"].ToString() + "\n" +
                                             "Problem: " + reader["Problem"].ToString();
                    Label9.Text = complainDetails;
                }
                reader.Close(); // Close the first reader

                // Reading worker phone number
                SqlDataReader phnumber = phnum.ExecuteReader();
                if (phnumber.Read())
                {
                    string workerPhone2 = phnumber["Number"].ToString();
                    Label10.Text = workerPhone2;
                }
                phnumber.Close(); // Close the second reader

                // Update the database with assignment
                cm1.ExecuteNonQuery();
                //cm0.ExecuteNonQuery();
                BindRepeater();
                // Success message
                LabelMessage.Text = "<b><br>Complain Re-Assigned Successfully</b>";
                LabelMessage.Style.Add("color", "green");
                TextBox2.Text = string.Empty;
                // Send WhatsApp message
                string labelText = Label9.Text;
                string message = HttpUtility.UrlEncode(labelText);
                string workerPhone = Label10.Text;
                string whatsappUrl = "https://wa.me/91" + workerPhone + "?text=" + message;

                // Open WhatsApp URL using JavaScript from server side
                string script = "window.open('" + whatsappUrl + "', '_blank');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "OpenWhatsApp", script, true);
            }
        }
        else
        {
            LabelMessage.Style.Add("color", "red");
            LabelMessage.Text = "<b>ID not found</b>";
        }

        cn.Close();
    }
    protected void Cancel_Click(object sender, EventArgs e)
    {
        DateTime datee = DateTime.Now.Date;
        string cudate = datee.ToString("yyyy-MM-dd");
        string callId = TextBox1.Text.Trim();
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT * FROM All_Complaints WHERE Call_Id = @id AND Status = 'Pending' ", cn);
        cm.Parameters.AddWithValue("@id", callId);

        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);

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

            //SqlCommand cm2 = new SqlCommand(@"INSERT INTO Work_Done(Call_id, Date, CC_Date, Name, Contact, Address, Product, Company, Warranty, Problem, WorkDoneBy, Details, Charges, ToPay, ItemCode, Def_Return) 
            //    SELECT Call_id, Date, @CC_Date, Name, Contact, Address, Product, Company, Warranty, Problem, @WorkDoneBy, @Details, @Charges, @ToPay, @ItemCode, @Def_Return 
            //    FROM Pending_Complain WHERE Call_id = @id", cn);
            SqlCommand cm2 = new SqlCommand(@"UPDATE All_Complaints SET Status = 'Done', CC_Date = @CC_Date, Assigned_To = @WorkDoneBy, Details = @Details, Charges = @Charges, ToPay = @ToPay, ItemCode = @ItemCode, Def_Return = @Def_Return WHERE Call_Id = @id", cn);

            cm2.Parameters.AddWithValue("@id", callId);
            cm2.Parameters.AddWithValue("@CC_Date", cudate);
            cm2.Parameters.AddWithValue("@WorkDoneBy", "Cancel");
            cm2.Parameters.AddWithValue("@Details", TextBox13.Text.Trim());
            cm2.Parameters.AddWithValue("@Charges", "-");
            cm2.Parameters.AddWithValue("@ToPay", "-");
            cm2.Parameters.AddWithValue("@ItemCode", "-");
            cm2.Parameters.AddWithValue("@Def_Return", "-");

            //SqlCommand cm3 = new SqlCommand("DELETE FROM Pending_Complain WHERE Call_id = @id", cn);
            //cm3.Parameters.AddWithValue("@id", callId);

            //SqlCommand cm4 = new SqlCommand("UPDATE All_Complains SET Status = @reason, Assigned_To = @cancel WHERE Call_ID = @id", cn);
            //cm4.Parameters.AddWithValue("@cancel", "Cancel");
            //cm4.Parameters.AddWithValue("@reason", TextBox13.Text.Trim());
            //cm4.Parameters.AddWithValue("@id", callId);

            cn.Open();
            cm2.ExecuteNonQuery();
            //cm3.ExecuteNonQuery();
            //cm4.ExecuteNonQuery();
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
    [System.Web.Services.WebMethod]
    public static string drpFilters(string selectedCompany, string partPendingOption)
    {
        Class1 obj = new Class1();
        string connection = obj.connectionString();
        string query = "";
        DataTable dt = new DataTable();

        using (SqlConnection cn = new SqlConnection(connection))
        {
            using (SqlCommand cm = new SqlCommand())
            {
                cm.Connection = cn;

                if (!string.IsNullOrEmpty(selectedCompany) && !string.IsNullOrEmpty(partPendingOption))
                {
                    query = "SELECT * FROM All_Complaints WHERE Status = 'Pending' AND Company = @company AND PartPending = @pp";
                    cm.Parameters.AddWithValue("@company", selectedCompany);
                    cm.Parameters.AddWithValue("@pp", partPendingOption);
                }
                else if (!string.IsNullOrEmpty(selectedCompany))
                {
                    query = "SELECT * FROM All_Complaints WHERE Status = 'Pending' AND Company = @company";
                    cm.Parameters.AddWithValue("@company", selectedCompany);
                }
                else if (!string.IsNullOrEmpty(partPendingOption))
                {
                    query = "SELECT * FROM All_Complaints WHERE Status = 'Pending' AND PartPending = @pp";
                    cm.Parameters.AddWithValue("@pp", partPendingOption);
                }
                else
                {
                    query = "SELECT * FROM All_Complaints WHERE Status = 'Pending' ";
                }

                cm.CommandText = query;
                using (SqlDataAdapter da = new SqlDataAdapter(cm))
                {
                    da.Fill(dt);
                }
            }
        }

        return JsonConvert.SerializeObject(dt);
    }
}