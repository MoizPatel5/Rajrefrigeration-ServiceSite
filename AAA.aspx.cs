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

public partial class Demo : System.Web.UI.Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        checklogin();
        connection = obj.connectionString();
        if (!IsPostBack)
        {
            hidediv();
        }
        else
        {
            PerformSearch();
            PerformSearch2();
        }

    }
    protected void checklogin()
    {
        if (Session["LoginAdmindone"] == null || (bool)Session["LoginAdmindone"] == false)
        {
            Response.Redirect("Default.aspx");
        }
    }
    protected void hidediv()
    {
        div1.Visible = false;
        div2.Visible = false;
        div3.Visible = false;
        div4.Visible = false;
        div8.Visible = false;
        div9.Visible = false;
        div10.Visible = false;
        div11.Visible = false;
        div12.Visible = false;
        div13.Visible = false;
        div14.Visible = false;
        div15.Visible = false;
        div16.Visible = false;
    }

    protected void div1_Click(object sender, EventArgs e)
    {
        hidediv();
        div1.Visible = true;
    }
    protected void div2_Click(object sender, EventArgs e)
    {
        hidediv();
        div2.Visible = true;
    }
    protected void div3_Click(object sender, EventArgs e)
    {
        hidediv();
        div3.Visible = true;
    }
    protected void div4_Click(object sender, EventArgs e)
    {
        hidediv();
        allcomplaintsgridview();
        div4.Visible = true;
    }
    protected void div8_Click(object sender, EventArgs e)
    {
        hidediv();
        workdonegridview();
        div8.Visible = true;
    }
    protected void div9_Click(object sender, EventArgs e)
    {
        hidediv();
        div9.Visible = true;
    }
    protected void div10_Click(object sender, EventArgs e)
    {
        hidediv();
        div10.Visible = true;
    }
    protected void div11_Click(object sender, EventArgs e)
    {
        hidediv();
        div11.Visible = true;
    }
    protected void div12_Click(object sender, EventArgs e)
    {
        hidediv();
        div12.Visible = true;
    }
    protected void div13_Click(object sender, EventArgs e)
    {
        hidediv();
        div13.Visible = true;
    }
    protected void div14_Click(object sender, EventArgs e)
    {
        hidediv();
        div14.Visible = true;
    }
    protected void div15_Click(object sender, EventArgs e)
    {
        hidediv();
        div15.Visible = true;
    }
    protected void Button20_Click(object sender, EventArgs e)
    {
        hidediv();
        div16.Visible = true;
    }
    protected void Button14_Click(object sender, EventArgs e)
    {
        long phoneNumber;
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("INSERT INTO Worker VALUES(@uname,@number)", cn);
        cm.Parameters.AddWithValue("@uname", TextBox1.Text);
        cm.Parameters.AddWithValue("@number", TextBox2.Text);
        SqlCommand cm2 = new SqlCommand("SELECT * FROM Worker WHERE Username = @uname", cn);
        cm2.Parameters.AddWithValue("@uname", TextBox1.Text);
        SqlCommand cm3 = new SqlCommand("SELECT * FROM Worker WHERE Number = @num", cn);
        cm3.Parameters.AddWithValue("@num", TextBox2.Text);

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);

        SqlDataAdapter da2 = new SqlDataAdapter(cm3);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2);
        cn.Open();
        if (TextBox1.Text == "")
        {
            Label1.Visible = true;
            Label2.Visible = false;
            Label3.Visible = false;
            Label1.Text = "Enter Worker Name";
        }
        else if (TextBox2.Text == "")
        {
            Label2.Visible = true;
            Label1.Visible = false;
            Label3.Visible = false;
            Label2.Text = "Enter Number";
        }
        else if (!long.TryParse(TextBox2.Text, out phoneNumber) || phoneNumber > 9999999999 || phoneNumber < 6000000000)
        {
            Label2.Visible = true;
            Label1.Visible = false;
            Label3.Visible = false;
            Label2.Text = "Enter a valid 10-digit number";
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            Label1.Visible = true;
            Label2.Visible = false;
            Label3.Visible = false;
            Label1.Text = "Worker Name Already Exists";
        }
        else if (ds2.Tables[0].Rows.Count > 0)
        {
            Label2.Visible = true;
            Label1.Visible = false;
            Label3.Visible = false;
            Label2.Text = "Number Already Exists";
        }
        else
        {
            cm.ExecuteNonQuery();
            Label2.Visible = false;
            Label1.Visible = false;
            Label3.Visible = true;
            Label3.Text = "Worker Added";
        }
        cn.Close();
    }
    protected void Button15_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("INSERT INTO Master_login VALUES(@uname,@pass,@role)", cn);
        cm.Parameters.AddWithValue("@uname", TextBox3.Text);
        cm.Parameters.AddWithValue("@pass", TextBox4.Text);
        cm.Parameters.AddWithValue("@role", "Employee");
        SqlCommand cm2 = new SqlCommand("SELECT * FROM Master_login WHERE Username = @uname", cn);
        cm2.Parameters.AddWithValue("@uname", TextBox3.Text);

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cn.Open();
        if (TextBox3.Text == "")
        {
            Label4.Visible = true;
            Label5.Visible = false;
            Label6.Visible = false;
            Label4.Text = "Enter UserName";
        }
        else if (TextBox4.Text == "")
        {
            Label4.Visible = false;
            Label5.Visible = true;
            Label6.Visible = false;
            Label5.Text = "Enter Password";
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            Label4.Visible = true;
            Label5.Visible = false;
            Label6.Visible = false;
            Label4.Text = "UserName Already Exists";
        }
        else
        {
            cm.ExecuteNonQuery();
            Label4.Visible = false;
            Label5.Visible = false;
            Label6.Visible = true;
            Label6.Text = "Employee Added";
        }
        cn.Close();
    }
    protected void Button16_Click(object sender, EventArgs e)
    {
        string dealer = DropDownList10.SelectedValue;
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("INSERT INTO Master_login VALUES(@uname,@pass,@role)", cn);
        cm.Parameters.AddWithValue("@uname", TextBox5.Text);
        cm.Parameters.AddWithValue("@pass", TextBox6.Text);
        cm.Parameters.AddWithValue("@role", "User");
        SqlCommand cm2 = new SqlCommand("SELECT * FROM Master_login WHERE Username = @uname", cn);
        cm2.Parameters.AddWithValue("@uname", TextBox5.Text);
        SqlCommand cm3 = new SqlCommand("INSERT INTO Users VALUES(@uname,@dealer)", cn);
        cm3.Parameters.AddWithValue("@uname", TextBox5.Text);
        cm3.Parameters.AddWithValue("@dealer", dealer);

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cn.Open();
        if (TextBox5.Text == "")
        {
            Label7.Visible = true;
            Label8.Visible = false;
            Label9.Visible = false;
            Label21.Visible = false;
            Label7.Text = "Enter UserName";
        }
        else if (TextBox6.Text == "")
        {
            Label7.Visible = false;
            Label8.Visible = true;
            Label9.Visible = false;
            Label21.Visible = false;
            Label8.Text = "Enter Password";
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            Label7.Visible = true;
            Label8.Visible = false;
            Label9.Visible = false;
            Label21.Visible = false;
            Label7.Text = "Username Already Exists";
        }
        else if(string.IsNullOrEmpty(dealer))
        {
            Label7.Visible = true;
            Label8.Visible = false;
            Label9.Visible = false;
            Label21.Visible = true;
            Label21.Text = "Select Dealer";
        }
        else
        {
            cm.ExecuteNonQuery();
            cm3.ExecuteNonQuery();
            Label7.Visible = false;
            Label8.Visible = false;
            Label9.Visible = true;
            Label9.Text = "User Added";
        }
        cn.Close();
    }
    protected void Button17_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("INSERT INTO Products VALUES(@name)", cn);
        cm.Parameters.AddWithValue("@name", TextBox7.Text);
        SqlCommand cm2 = new SqlCommand("SELECT * FROM Products WHERE Products = @name", cn);
        cm2.Parameters.AddWithValue("@name", TextBox7.Text);

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);

        cn.Open();
        if (TextBox7.Text == "")
        {
            Label11.Visible = false;
            Label10.Visible = true;
            Label10.Text = "Enter Product Name";
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            Label11.Visible = false;
            Label10.Visible = true;
            Label10.Text = "Product Name Already Exists";
        }
        else
        {
            Label10.Visible = false;
            Label11.Visible = true;
            Label11.Text = "Product Added";
            cm.ExecuteNonQuery();
        }
        cn.Close();
    }
    protected void Button18_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("INSERT INTO Company VALUES(@name)", cn);
        cm.Parameters.AddWithValue("@name", TextBox8.Text);
        SqlCommand cm2 = new SqlCommand("SELECT * FROM Company WHERE Name = @name", cn);
        cm2.Parameters.AddWithValue("@name", TextBox8.Text);

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);

        cn.Open();
        if (TextBox8.Text == "")
        {
            Label13.Visible = false;
            Label12.Visible = true;
            Label12.Text = "Enter Company Name";
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            Label13.Visible = false;
            Label12.Visible = true;
            Label12.Text = "Company Name Already Exists";
        }
        else
        {
            cm.ExecuteNonQuery();
            Label13.Visible = true;
            Label12.Visible = false;
            Label13.Text = "Company Added";
        }
        cn.Close();
    }
    protected void Button19_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("Default.aspx");
    }
    protected void Button23_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(connection);

        try
        {
            cn.Open();

            // First DELETE statement for AllOrders
            SqlCommand cm1 = new SqlCommand("DELETE FROM All_Complains WHERE Date BETWEEN @startdate AND @olddate", cn);
            cm1.Parameters.AddWithValue("@startdate", TextBox9.Text);
            cm1.Parameters.AddWithValue("@olddate", TextBox10.Text);

            // Second DELETE statement for WorkDone
            SqlCommand cm2 = new SqlCommand("DELETE FROM Work_Done WHERE Date BETWEEN @startdate AND @olddate", cn);
            cm2.Parameters.AddWithValue("@startdate", TextBox9.Text);
            cm2.Parameters.AddWithValue("@olddate", TextBox10.Text);
            if (TextBox9.Text == "" || TextBox10.Text == "")
            {
                Label14.Visible = true;
                Label14.Text = "Select Date";
                Label14.Style.Add("color", "red");
            }
            else if (TextBox19.Text == "3cS4f5X5se4e5")
            {
                cm1.ExecuteNonQuery();
                cm2.ExecuteNonQuery();
                Label14.Visible = true;
                Label14.CssClass = "success-message";
                Label14.Style.Add("color", "green");
                Label14.Text = "Complaints Deleted Successfully";
            }
            else
            {
                Label14.Visible = true;
                Label14.Text = "Wrong Password";
                Label14.Style.Add("color", "red");
            }

        }
        catch (Exception ex)
        {
            Label14.Visible = true;
            Label14.Text = "An error occurred: " + ex.Message;
        }
        finally
        {
            cn.Close();
        }

    }
    protected void allcomplaintsgridview()
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT * FROM All_Complains", cn);
        cn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GridView1.DataSourceID = null;
        GridView1.DataSource = ds.Tables[0];
        GridView1.DataBind();
        cn.Close();
        if (ds.Tables[0].Rows.Count == 0)
        {
            noDataDiv.Visible = true;
        }
        else
        {
            noDataDiv.Visible = false;
        }
    }
    protected void gridviewpagechanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        allcomplaintsgridview();
    }

    protected void Button24_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(connection);
        cn.Open();
        SqlCommand cm = new SqlCommand("SELECT * FROM All_Complains WHERE Call_Id = @id", cn);
        cm.Parameters.AddWithValue("@id", TextBox11.Text);
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);
        SqlDataReader dr = cm.ExecuteReader();
        string status = "";
        if (dr.Read())
        {
            status = dr["Status"].ToString();
        }
        dr.Close();
        string updateterm = DropDownList1.SelectedValue;
        string newvalue = "";
        if (updateterm == "Product")
        {
            newvalue = DropDownList2.SelectedValue;
        }
        else if (updateterm == "Company")
        {
            newvalue = DropDownList3.SelectedValue;
        }
        else if (updateterm == "Warranty")
        {
            newvalue = DropDownList4.SelectedValue;
        }
        else if (updateterm == "Assigned_To")
        {
            newvalue = DropDownList5.SelectedValue;
        }
        else
        {
            newvalue = TextBox12.Text;
        }
        SqlCommand cm2 = new SqlCommand("UPDATE All_Complains SET " + updateterm + " = @newvalue WHERE Call_Id = @id", cn);
        cm2.Parameters.AddWithValue("@newvalue", newvalue);
        cm2.Parameters.AddWithValue("@id", TextBox11.Text);

        if (TextBox11.Text == "")
        {
            Label15.Text = "Enter Call Id";
            Label15.Style.Add("color", "red");
            Label15.Visible = true;
        }
        else if (DropDownList1.SelectedValue != "Product" && DropDownList1.SelectedValue != "Company" && DropDownList1.SelectedValue != "Assigned_To" && DropDownList1.SelectedValue != "Warranty" && TextBox12.Text == "")
        {
            Label15.Text = "Enter New Value";
            Label15.Style.Add("color", "red");
            Label15.Visible = true;
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            if (status == "In Process")
            {
                SqlCommand cm3 = new SqlCommand("UPDATE Proc_Complain SET " + updateterm + " = @newvalue WHERE Call_Id = @id", cn);
                cm3.Parameters.AddWithValue("@newvalue", newvalue);
                cm3.Parameters.AddWithValue("@id", TextBox11.Text);

                cm3.ExecuteNonQuery();
                cm2.ExecuteNonQuery();
                allcomplaintsgridview();
                Label15.Text = "Complaint updated successfully";
                Label15.Style.Add("color", "green");
                Label15.Visible = true;
            }
            else if (status == "Pending")
            {
                if (updateterm == "Call_Id")
                {
                    updateterm = "Call_id";
                }
                SqlCommand cm4 = new SqlCommand("UPDATE Pending_Complain SET " + updateterm + " = @newvalue WHERE Call_id = @id", cn);
                cm4.Parameters.AddWithValue("@newvalue", newvalue);
                cm4.Parameters.AddWithValue("@id", TextBox11.Text);

                cm4.ExecuteNonQuery();
                cm2.ExecuteNonQuery();
                allcomplaintsgridview();
                Label15.Text = "Complaint updated successfully";
                Label15.Style.Add("color", "green");
                Label15.Visible = true;
            }
            else
            {
                if (updateterm == "Call_Id")
                {
                    updateterm = "Call_id";
                }
                else if (updateterm == "Assigned_To")
                {
                    updateterm = "WorkDoneBy";
                }
                SqlCommand cm5 = new SqlCommand("UPDATE Work_Done SET " + updateterm + " = @newvalue WHERE Call_id = @id", cn);
                cm5.Parameters.AddWithValue("@newvalue", newvalue);
                cm5.Parameters.AddWithValue("@id", TextBox11.Text);

                cm5.ExecuteNonQuery();
                cm2.ExecuteNonQuery();
                allcomplaintsgridview();
                Label15.Text = "Complaint updated successfully";
                Label15.Style.Add("color", "green");
                Label15.Visible = true;
            }

        }
        else
        {
            Label15.Text = "Call Id not found";
            Label15.Style.Add("color", "red");
            Label15.Visible = true;
        }
        cn.Close();
    }
    protected void Button25_Click(object sender, EventArgs e)
    {
        Label15.Text = "";
        Label15.Visible = false;

        if (string.IsNullOrWhiteSpace(TextBox11.Text))
        {
            Label15.Text = "Enter Call ID";
            Label15.Style.Add("color", "red");
            Label15.Visible = true;
            return;
        }

        if (TextBox20.Text != "7d8FF5F85gFX")
        {
            Label15.Text = "Wrong Password";
            Label15.Style.Add("color", "red");
            Label15.Visible = true;
            return;
        }

        SqlConnection cn = new SqlConnection(connection);
        cn.Open();

        // Get the status of the complaint
        SqlCommand cmStatus = new SqlCommand("SELECT Status FROM All_Complains WHERE Call_Id = @id", cn);
        cmStatus.Parameters.AddWithValue("@id", TextBox11.Text);
        string status = Convert.ToString(cmStatus.ExecuteScalar());

        if (!string.IsNullOrEmpty(status))
        {
            SqlCommand cmDeleteMain = new SqlCommand("DELETE FROM All_Complains WHERE Call_Id = @id", cn);
            cmDeleteMain.Parameters.AddWithValue("@id", TextBox11.Text);
            cmDeleteMain.ExecuteNonQuery();

            SqlCommand cmDeleteOther = null;

            if (status == "In Process")
            {
                cmDeleteOther = new SqlCommand("DELETE FROM Proc_Complain WHERE Call_Id = @id", cn);
            }
            else if (status == "Pending")
            {
                cmDeleteOther = new SqlCommand("DELETE FROM Pending_Complain WHERE Call_Id = @id", cn);
            }
            else
            {
                cmDeleteOther = new SqlCommand("DELETE FROM Work_Done WHERE Call_Id = @id", cn);
            }

            cmDeleteOther.Parameters.AddWithValue("@id", TextBox11.Text);
            cmDeleteOther.ExecuteNonQuery();

            Label15.Text = "Complaint deleted successfully";
            Label15.Style.Add("color", "green");
        }
        else
        {
            Label15.Text = "Call ID not found";
            Label15.Style.Add("color", "red");
        }

        Label15.Visible = true;
        allcomplaintsgridview();
        cn.Close();
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedValue == "Product")
        {
            TextBox12.Visible = false;
            DropDownList2.Visible = true;
            DropDownList3.Visible = false;
            DropDownList4.Visible = false;
            DropDownList5.Visible = false;
        }
        else if (DropDownList1.SelectedValue == "Company")
        {
            TextBox12.Visible = false;
            DropDownList2.Visible = false;
            DropDownList3.Visible = true;
            DropDownList4.Visible = false;
            DropDownList5.Visible = false;
        }
        else if (DropDownList1.SelectedValue == "Warranty")
        {
            TextBox12.Visible = false;
            DropDownList2.Visible = false;
            DropDownList3.Visible = false;
            DropDownList4.Visible = true;
            DropDownList5.Visible = false;
        }
        else if (DropDownList1.SelectedValue == "Assigned_To")
        {
            TextBox12.Visible = false;
            DropDownList2.Visible = false;
            DropDownList3.Visible = false;
            DropDownList4.Visible = false;
            DropDownList5.Visible = true;
        }
        else if (DropDownList1.SelectedValue == "Date")
        {
            TextBox12.TextMode = TextBoxMode.Date;
            TextBox12.Visible = true;
            DropDownList2.Visible = false;
            DropDownList3.Visible = false;
            DropDownList4.Visible = false;
            DropDownList5.Visible = false;
        }
        else if (DropDownList1.SelectedValue == "Contact")
        {
            TextBox12.TextMode = TextBoxMode.Number;
            TextBox12.Visible = true;
            DropDownList2.Visible = false;
            DropDownList3.Visible = false;
            DropDownList4.Visible = false;
            DropDownList5.Visible = false;
        }
        else
        {
            TextBox12.TextMode = TextBoxMode.SingleLine;
            TextBox12.Visible = true;
            DropDownList2.Visible = false;
            DropDownList3.Visible = false;
            DropDownList4.Visible = false;
            DropDownList5.Visible = false;
        }
    }
    protected void workdonegridview()
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT * FROM Work_Done", cn);
        cn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GridView2.DataSourceID = null;
        GridView2.DataSource = ds.Tables[0];
        GridView2.DataBind();
        cn.Close();
    }
    protected void DropDownList6_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList6.SelectedValue == "ItemCode")
        {
            TextBox14.TextMode = TextBoxMode.SingleLine;
            TextBox14.Visible = true;
            DropDownList7.Visible = false;
        }
        else if (DropDownList6.SelectedValue == "Def_Return")
        {
            DropDownList7.Visible = true;
            TextBox14.Visible = false;
        }
        else
        {
            TextBox14.TextMode = TextBoxMode.Number;
            TextBox14.Visible = true;
            DropDownList7.Visible = false;
        }
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(connection);
        cn.Open();
        SqlCommand cm = new SqlCommand("SELECT * FROM Work_Done WHERE Call_id = @id", cn);
        cm.Parameters.AddWithValue("@id", TextBox13.Text);
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);
        string updateterm = DropDownList6.SelectedValue;
        string newvalue = "";
        if (updateterm == "Def_Return")
        {
            newvalue = DropDownList7.SelectedValue;
        }
        else
        {
            newvalue = TextBox14.Text;
        }
        SqlCommand cm2 = new SqlCommand("UPDATE Work_Done SET " + updateterm + " = @newvalue WHERE Call_id = @id ", cn);
        cm2.Parameters.AddWithValue("@newvalue", newvalue);
        cm2.Parameters.AddWithValue("@id", TextBox13.Text);

        if (TextBox13.Text == "")
        {
            Label16.Text = "Enter Call ID";
            Label16.Style.Add("color", "red");
            Label16.Visible = true;
        }
        else if (DropDownList6.SelectedValue != "Def_Return" && TextBox14.Text == "")
        {
            Label16.Text = "Enter New Value";
            Label16.Style.Add("color", "red");
            Label16.Visible = true;
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            cm2.ExecuteNonQuery();
            workdonegridview();
            Label16.Text = "Complaint Updated Successfully";
            Label16.Style.Add("color", "green");
            Label16.Visible = true;
        }
        else
        {
            Label16.Text = "Call ID not found";
            Label16.Style.Add("color", "red");
            Label16.Visible = true;
        }
        cn.Close();
    }
    private void PerformSearch()
    {
        SqlConnection cn = new SqlConnection(connection);
        string query = "SELECT * FROM All_Complains WHERE " + DropDownList8.SelectedItem + " LIKE @search";
        SqlCommand cm = new SqlCommand(query, cn);
        cm.Parameters.AddWithValue("@search", "%" + TextBox15.Text + "%");
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        cn.Open();
        da.Fill(ds);
        cn.Close();
        GridView1.DataSourceID = null;
        GridView1.DataSource = ds.Tables[0];
        GridView1.DataBind();
        if (ds.Tables[0].Rows.Count == 0)
        {
            noDataDiv.Visible = true;
        }
        else
        {
            noDataDiv.Visible = false;
        }
    }
    protected void DropDownList8_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList8.SelectedValue == "2")
        {
            TextBox15.TextMode = TextBoxMode.Date;
        }
        else
        {
            TextBox15.TextMode = TextBoxMode.SingleLine;
        }
    }
    private void PerformSearch2()
    {
        SqlConnection cn = new SqlConnection(connection);
        string query = "SELECT * FROM Work_Done WHERE " + DropDownList9.SelectedItem + " LIKE @search";
        SqlCommand cm = new SqlCommand(query, cn);
        cm.Parameters.AddWithValue("@search", "%" + TextBox16.Text + "%");
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        cn.Open();
        da.Fill(ds);
        cn.Close();
        GridView2.DataSourceID = null;
        GridView2.DataSource = ds.Tables[0];
        GridView2.DataBind();
        if (ds.Tables[0].Rows.Count == 0)
        {
            Div5.Visible = true;
        }
        else
        {
            Div5.Visible = false;
        }
    }
    protected void DropDownList9_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList9.SelectedValue == "2")
        {
            TextBox16.TextMode = TextBoxMode.Date;
        }
        else
        {
            TextBox16.TextMode = TextBoxMode.SingleLine;
        }
    }
    protected void gridviewview2pagechanging(object sender, GridViewPageEventArgs e)
    {
        GridView2.PageIndex = e.NewPageIndex;
        workdonegridview();
    }
   
}