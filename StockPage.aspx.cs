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
using System.Drawing;
public partial class Default2 : System.Web.UI.Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        connection = obj.connectionString();
        if(!IsPostBack)
        {
            hidediv();
            checklogin();
            totalstock();
        }
    }
    protected void checklogin()
    {
        if (Session["Logindone"] == null || (bool)Session["Logindone"] == false)
        {
            Response.Redirect("Default.aspx");
        }
    }
    protected void ResetButtonStyles()
    {
        // Remove the 'active-btn' class from all buttons
        Button1.CssClass = Button1.CssClass.Replace(" active-btn", "").Trim();
        Button2.CssClass = Button2.CssClass.Replace(" active-btn", "").Trim();
        Button3.CssClass = Button3.CssClass.Replace(" active-btn", "").Trim();
        Button4.CssClass = Button4.CssClass.Replace(" active-btn", "").Trim();
        Button5.CssClass = Button5.CssClass.Replace(" active-btn", "").Trim();
    }
    protected void hidediv()
    {
        div1.Visible = false;
        div2.Visible = false;
        div3.Visible = false;
        div4.Visible = false;
        div5.Visible = false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        hidediv();
        ResetButtonStyles();
        Button1.CssClass += " active-btn"; 
        div1.Visible = true;
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        hidediv();
        ResetButtonStyles();
        Button2.CssClass += " active-btn"; 
        div2.Visible = true;
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        hidediv();
        ResetButtonStyles();
        Button3.CssClass += " active-btn"; 
        div3.Visible = true;
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        totalstock();
    }
    protected void totalstock()
    {
        hidediv();
        ResetButtonStyles();
        Button4.CssClass += " active-btn";
        div4.Visible = true;
        gridview();
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        hidediv();
        ResetButtonStyles();
        Button5.CssClass += " active-btn"; 
        div5.Visible = true;
    }
    protected void gridview()
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT BillNo, BillDate, ItemCode, ItemDisc, Company, Rate FROM Stock", cn);
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GridView1.DataSourceID = null;
        GridView1.DataSource = ds.Tables[0];
        GridView1.DataBind();
    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        DateTime datee = DateTime.Now.Date;
        string cudate = datee.ToString("yyyy-MM-dd");
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("INSERT INTO Stock Values(@billno , @billdate , @itmcode , @itmdisc , @cmpny , @rate)", cn);
        cm.Parameters.AddWithValue("@billno", TextBox1.Text);
        cm.Parameters.AddWithValue("@billdate", TextBox2.Text);
        cm.Parameters.AddWithValue("@itmcode", TextBox3.Text);
        cm.Parameters.AddWithValue("@itmdisc", TextBox4.Text);
        cm.Parameters.AddWithValue("@cmpny", DropDownList1.SelectedValue);
        cm.Parameters.AddWithValue("@rate", TextBox5.Text);
        //cm.Parameters.AddWithValue("@type", "Purchased");
        SqlCommand cm2 = new SqlCommand("SELECT * FROM Stock WHERE ItemCode = @itmcode", cn);
        cm2.Parameters.AddWithValue("@itmcode", TextBox3.Text);
        SqlCommand cm3 = new SqlCommand("INSERT INTO Stock_History (BillNo, BillDate, ItemCode, ItemDisc, Company, Rate , Chargetkn , TransactionType , TransactionDate , Call_Id , Reason) SELECT BillNo, BillDate, ItemCode, ItemDisc, Company, Rate , @chrgtkn , @TransactionType , @TransactionDate , @Call_Id , @Reason FROM Stock WHERE ItemCode = @code", cn);
        cm3.Parameters.AddWithValue("@code", TextBox3.Text);
        cm3.Parameters.AddWithValue("@TransactionType", "Purchase");
        cm3.Parameters.AddWithValue("@TransactionDate", cudate);
        cm3.Parameters.AddWithValue("@Call_Id", "-");
        cm3.Parameters.AddWithValue("@Reason", "-");
        cm3.Parameters.Add("@chrgtkn", "-");
        cn.Open();

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);

        if(TextBox1.Text == "")
        {
            Label1.Visible = true;
            Label1.Text = "Enter Bill no";
            Label1.Style.Add("Color", "Red");
        }
        else if (TextBox2.Text == "")
        {
            Label1.Visible = true;
            Label1.Text = "Enter Bill Date";
            Label1.Style.Add("Color", "Red");
        }
        else if (TextBox3.Text == "")
        {
            Label1.Visible = true;
            Label1.Text = "Enter Item Code";
            Label1.Style.Add("Color", "Red");
        }
        else if (TextBox4.Text == "")
        {
            Label1.Visible = true;
            Label1.Text = "Enter Item Description";
            Label1.Style.Add("Color", "Red");
        }
        else if (TextBox5.Text == "")
        {
            Label1.Visible = true;
            Label1.Text = "Enter Rate";
            Label1.Style.Add("Color", "Red");
        }
        else if (ds.Tables[0].Rows.Count>0)
        {
            Label1.Visible = true;
            Label1.Text = "Item code already exists";
            Label1.Style.Add("Color", "Red");
        }
        else
        {
            cm.ExecuteNonQuery();
            cm3.ExecuteNonQuery();
            Label1.Visible = true;
            Label1.Text = "Product Added";
            Label1.Style.Add("Color", "Green");
        }
        cn.Close();
    }
    protected void searchType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(searchType.SelectedValue=="Company")
        {
            cmpnydiv.Visible = true;
            txtbxdiv.Visible = false;
        }
       else
        {
            txtbxdiv.Visible = true;
            cmpnydiv.Visible = false;
        }
    }
    protected void Button9_Click(object sender, EventArgs e)
    {
        string query = "SELECT * FROM Stock WHERE ";
        string selectedvalue = searchType.SelectedValue;
        switch(selectedvalue)
        {
            case "Bill no.": query += "BillNo LIKE @srch";
                break;
            case "Bill Date": query += "BillDate LIKE @srch";
                break;
            case "Item Code": query += "ItemCode LIKE @srch";
                break;
            case "Item Disc": query += "ItemDisc LIKE @srch";
                break;
            case "Company": query += "Company = @cmpny";
                break;
            case "Rate": query += "Rate LIKE @srch";
                break;
            default : gridview();
                break;
        }
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand(query,cn);
        if (selectedvalue == "Company")
        {
            cm.Parameters.AddWithValue("@cmpny", company.SelectedValue);
        }
        else
        {
            cm.Parameters.AddWithValue("@srch", "%" + TextBox7.Text + "%");
        }

        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);

        GridView1.DataSourceID = null;
        GridView1.DataSource = ds.Tables[0];
        GridView1.DataBind();
    }

    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string transactionType = e.Row.Cells[10].Text; // Assuming TransactionType is the 7th column (index 6)

            switch (transactionType)
            {
                case "Sale":
                    e.Row.Cells[10].ForeColor = Color.Red; // Color change for specific cell
                   // e.Row.Cells[10].BackColor = Color.Red;  // Color change for specific cell
                    break;
                case "Purchase":
                    e.Row.Cells[10].ForeColor = Color.Green; // Color change for specific cell
                   // e.Row.Cells[10].BackColor = Color.LightGreen; // Color change for specific cell
                    break;
                default:
                    e.Row.Cells[10].ForeColor = Color.Orange; // Color change for specific cell
                  //  e.Row.Cells[10].BackColor = Color.Orange; // Color change for specific cell
                    break;
            }
        }
    }

    protected void Button7_Click(object sender, EventArgs e)
    {
        DateTime datee = DateTime.Now.Date;
        string cudate = datee.ToString("yyyy-MM-dd");
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT * FROM Stock WHERE ItemCode = @itmcode", cn);
        cm.Parameters.AddWithValue("@itmcode", TextBox6.Text);
        SqlCommand cm2 = new SqlCommand("DELETE FROM Stock WHERE ItemCode = @itmcode", cn);
        cm2.Parameters.AddWithValue("@itmcode", TextBox6.Text);
        SqlCommand cm3 = new SqlCommand("INSERT INTO Stock_History (BillNo, BillDate, ItemCode, ItemDisc, Company, Rate , Chargetkn , TransactionType , TransactionDate , Call_Id , Reason) SELECT BillNo, BillDate, ItemCode, ItemDisc, Company, Rate,@chtkn , @tt , @TransactionDate , @cid , @Reason FROM Stock WHERE ItemCode = @code", cn);
        cm3.Parameters.AddWithValue("@code", TextBox6.Text);
        cm3.Parameters.AddWithValue("@tt", "Purchase return");
        cm3.Parameters.AddWithValue("@TransactionDate", cudate);
        cm3.Parameters.AddWithValue("@cid", "-");
        cm3.Parameters.AddWithValue("@Reason", TextBox8.Text);
        cm3.Parameters.AddWithValue("@chtkn", "-");
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);

        cn.Open();
        if(TextBox6.Text=="")
        {
            Label2.Visible = true;
            Label2.Style.Add("color", "red");
            Label2.Text = "Enter Item Code";
        }
        else if (TextBox8.Text == "")
        {
            Label2.Visible = true;
            Label2.Style.Add("color", "red");
            Label2.Text = "Enter Reason";
        }
        else if(ds.Tables[0].Rows.Count>0)
        {
            cm3.ExecuteNonQuery();
            cm2.ExecuteNonQuery();
            Label2.Visible = true;
            Label2.Style.Add("color", "green");
            Label2.Text = "Purchase return successfull";
        }
        else
        {
            Label2.Visible = true;
            Label2.Style.Add("color", "red");
            Label2.Text = "Item Code not found";
        }
        cn.Close();
    }
    protected void Button8_Click(object sender, EventArgs e)
    {
        DateTime datee = DateTime.Now.Date;
        string cudate = datee.ToString("yyyy-MM-dd");
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("INSERT INTO Stock Values(@billno , @billdate , @itmcode , @itmdisc , @cmpny , @rate)", cn);
        cm.Parameters.AddWithValue("@billno", TextBox12.Text);
        cm.Parameters.AddWithValue("@billdate", TextBox13.Text);
        cm.Parameters.AddWithValue("@itmcode", TextBox14.Text);
        cm.Parameters.AddWithValue("@itmdisc", TextBox15.Text);
        cm.Parameters.AddWithValue("@cmpny", DropDownList3.SelectedValue);
        cm.Parameters.AddWithValue("@rate", TextBox16.Text);
        SqlCommand cm2 = new SqlCommand("SELECT * FROM Stock WHERE ItemCode = @itmcode", cn);
        cm2.Parameters.AddWithValue("@itmcode", TextBox14.Text);
        SqlCommand cm3 = new SqlCommand("INSERT INTO Stock_History (BillNo, BillDate, ItemCode, ItemDisc, Company, Rate , Chargetkn , TransactionType , TransactionDate , Call_Id , Reason) SELECT BillNo, BillDate, ItemCode, ItemDisc, Company, Rate , @chtkn ,@tt , @td , @cid , @rsn FROM Stock WHERE ItemCode = @code", cn);
        cm3.Parameters.AddWithValue("@code", TextBox14.Text);
        cm3.Parameters.AddWithValue("@tt", "Sale return");
        cm3.Parameters.AddWithValue("@td", cudate);
        cm3.Parameters.AddWithValue("@cid", TextBox18.Text);
        cm3.Parameters.AddWithValue("@rsn", TextBox17.Text);
        cm3.Parameters.AddWithValue("@chtkn", "-");
       
        SqlCommand cm8 = new SqlCommand("SELECT * FROM All_Complains WHERE Call_Id = @id", cn);
        cm8.Parameters.AddWithValue("@id", TextBox18.Text);
        SqlDataAdapter da2 = new SqlDataAdapter(cm8);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2);
        cn.Open();

        SqlDataAdapter da = new SqlDataAdapter(cm2);
        DataSet ds = new DataSet();
        da.Fill(ds);

        if (TextBox12.Text == "")
        {
            Label3.Visible = true;
            Label3.Text = "Enter Bill no";
            Label3.Style.Add("Color", "Red");
        }
        else if (TextBox13.Text == "")
        {
            Label3.Visible = true;
            Label3.Text = "Enter Bill Date";
            Label3.Style.Add("Color", "Red");
        }
        else if (TextBox14.Text == "")
        {
            Label3.Visible = true;
            Label3.Text = "Enter Item Code";
            Label3.Style.Add("Color", "Red");
        }
        else if (TextBox15.Text == "")
        {
            Label3.Visible = true;
            Label3.Text = "Enter Item Description";
            Label3.Style.Add("Color", "Red");
        }
        else if (TextBox16.Text == "")
        {
            Label3.Visible = true;
            Label3.Text = "Enter Rate";
            Label3.Style.Add("Color", "Red");
        }
        else if (TextBox17.Text == "")
        {
            Label3.Visible = true;
            Label3.Text = "Enter Reason";
            Label3.Style.Add("Color", "Red");
        }
        else if (TextBox18.Text == "")
        {
            Label3.Visible = true;
            Label3.Text = "Enter Call Id";
            Label3.Style.Add("Color", "Red");
        }
        else if (ds.Tables[0].Rows.Count > 0)
        {
            Label3.Visible = true;
            Label3.Text = "Item code already exists";
            Label3.Style.Add("Color", "Red");
        }
        else if(ds2.Tables[0].Rows.Count>0)
        {
            cm.ExecuteNonQuery();
            cm3.ExecuteNonQuery();
            Label1.Visible = true;
            Label3.Text = "Product Added";
            Label3.Style.Add("Color", "Green");
        }
        else
        {
            Label3.Visible = true;
            Label3.Text = "Call Id not found";
            Label3.Style.Add("Color", "Red");
        }
        cn.Close();
    }
    protected void searchType2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (searchType2.SelectedValue == "Company")
        {
            Div6.Visible = true;
            Div7.Visible = false;
        }
        else
        {
            Div7.Visible = true;
            Div6.Visible = false;
        }
    }
    protected void Button10_Click(object sender, EventArgs e)
    {
        string query = "SELECT * FROM Stock_History WHERE ";
        string selectedvalue = searchType2.SelectedValue;
        switch (selectedvalue)
        {
            case "Bill no.": query += "BillNo LIKE @srch";
                break;
            case "Bill Date": query += "BillDate LIKE @srch";
                break;
            case "Item Code": query += "ItemCode LIKE @srch";
                break;
            case "Item Disc": query += "ItemDisc LIKE @srch";
                break;
            case "Company": query += "Company = @cmpny";
                break;
            case "Rate": query += "Rate LIKE @srch";
                break;
            case "Transaction Date": query += "TransactionDate LIKE @srch";
                break;
            case "Call Id": query += "Call_Id LIKE @srch";
                break;
            case "Reason": query += "Reason LIKE @srch";
                break;
            case "Transaction Type": query += "TransactionType LIKE @srch";
                break;
          }
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand(query, cn);
        if (selectedvalue == "Company")
        {
            cm.Parameters.AddWithValue("@cmpny", DropDownList4.SelectedValue);
        }
        else
        {
            cm.Parameters.AddWithValue("@srch", "%" + TextBox9.Text + "%");
        }

        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);

        GridView2.DataSourceID = null;
        GridView2.DataSource = ds.Tables[0];
        GridView2.DataBind();
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        divbilldate.Visible = CheckBox1.Checked;
    }

    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {
        divtdate.Visible = CheckBox2.Checked;
    }

    protected void Button11_Click(object sender, EventArgs e)
    {
        string query = "SELECT BillNo, BillDate, ItemCode, ItemDisc, Company, Rate, Chargetkn ,TransactionType, TransactionDate, Call_Id, Reason FROM Stock_History WHERE 1=1";

        // Date filters
        if (CheckBox1.Checked && !string.IsNullOrEmpty(TextBox10.Text) && !string.IsNullOrEmpty(TextBox11.Text))
        {
            query += " AND BillDate BETWEEN @BillDateFrom AND @BillDateTo";
        }
        if (CheckBox2.Checked && !string.IsNullOrEmpty(TextBox19.Text) && !string.IsNullOrEmpty(TextBox20.Text))
        {
            query += " AND TransactionDate BETWEEN @TransDateFrom AND @TransDateTo";
        }

        // SQL connection and command setup
        using (SqlConnection cn = new SqlConnection(connection))
        using (SqlCommand cmd = new SqlCommand(query, cn))
        {
            // Adding date parameters if filters are checked
            if (CheckBox1.Checked && !string.IsNullOrEmpty(TextBox10.Text) && !string.IsNullOrEmpty(TextBox11.Text))
            {
                cmd.Parameters.AddWithValue("@BillDateFrom", TextBox10.Text);
                cmd.Parameters.AddWithValue("@BillDateTo", TextBox11.Text);
            }
            if (CheckBox2.Checked && !string.IsNullOrEmpty(TextBox19.Text) && !string.IsNullOrEmpty(TextBox20.Text))
            {
                cmd.Parameters.AddWithValue("@TransDateFrom", TextBox19.Text);
                cmd.Parameters.AddWithValue("@TransDateTo", TextBox20.Text);
            }

            // Binding the data to GridView2
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            GridView2.DataSourceID = null;
            GridView2.DataSource = ds;
            GridView2.DataBind();
        }
    }
    protected void gridviewpagechanging(object sender , GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        gridview();
    }
    protected void gridviewpagechanging1(object sender, GridViewPageEventArgs e)
    {
        GridView2.PageIndex = e.NewPageIndex;
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        filtercontainer.Visible = !filtercontainer.Visible;
    }
}