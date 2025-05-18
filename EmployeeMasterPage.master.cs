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

public partial class EmployeeMasterPage : System.Web.UI.MasterPage
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        string year = DateTime.Now.Year.ToString();
        Label1.Text = year;
        connection = obj.connectionString();
        if(!IsPostBack)
        {
            mgs();
        }
        checklogin();
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
        Session.Abandon();
        Response.Redirect("Default.aspx");
    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(connection);
        cn.Open();
        SqlCommand cm = new SqlCommand("INSERT INTO Notification VALUES(@callid , @message , @ir)", cn);
        cm.Parameters.AddWithValue("@callid", TextBox17.Text);
        cm.Parameters.AddWithValue("@message", TextBox18.Text);
        cm.Parameters.AddWithValue("@ir", "0");

        if (TextBox17.Text == "")
        {
            Label18.Text = "Enter Call ID";
            Label19.Visible = false;
            Label17.Visible = false;
            Label18.Visible = true;
        }
        else if (TextBox18.Text == "")
        {
            Label19.Text = "Enter Message";
            Label19.Visible = true;
            Label18.Visible = false;
            Label17.Visible = false;
        }
        else
        {
            cm.ExecuteNonQuery();
            mgs();
            Label17.Text = "Message Sent Successfully";
            Label18.Visible = false;
            Label19.Visible = false;
            Label17.Visible = true;
        }
        cn.Close();
    }
    protected void mgs()
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("SELECT * FROM Notification ORDER BY Isread ASC, Id DESC", cn);
        SqlDataAdapter da = new SqlDataAdapter(cm);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GridView2.DataSourceID = null;
        GridView2.DataSource = ds.Tables[0];
        GridView2.DataBind();
    }
    protected void Gridview2_Rowcommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "CustomDelete")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            deletenotification(id);
        }
        else if (e.CommandName == "Seenmgs")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            seennotification(id);
        }
    }
    protected void deletenotification(int id)
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("DELETE FROM Notification WHERE Id = @id", cn);
        cm.Parameters.AddWithValue("@id", id);
        cn.Open();
        cm.ExecuteNonQuery();
        cn.Close();
        mgs();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#" + modaldiv.ClientID + "').fadeIn();", true);
    }
    protected void seennotification(int id)
    {
        SqlConnection cn = new SqlConnection(connection);
        SqlCommand cm = new SqlCommand("UPDATE Notification SET Isread = 1 WHERE Id = @id", cn);
        cm.Parameters.AddWithValue("@id", id);
        cn.Open();
        cm.ExecuteNonQuery();
        cn.Close();
        mgs();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#" + modaldiv.ClientID + "').fadeIn();", true);
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // Check if the current row is a data row
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Retrieve the "Isread" value for the current row as a string
            string isRead = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Isread"));

            // Apply styles based on the "Isread" value
            if (isRead == "0")
            {
                // Unread messages (dark shade)
                e.Row.BackColor = System.Drawing.Color.LightGray;
                e.Row.Font.Bold = true; // Optional: Make the font bold
            }
            else if (isRead == "1")
            {
                // Read messages (light shade)
                e.Row.BackColor = System.Drawing.Color.WhiteSmoke;
                e.Row.Font.Bold = false;
            }
        }
    }
    [System.Web.Services.WebMethod]
    public static bool HasUnreadMessages()
    {
        Class1 obj = new Class1();
        string connection = obj.connectionString();

        using (SqlConnection cn = new SqlConnection(connection))
        {
            SqlCommand cm = new SqlCommand("SELECT COUNT(*) FROM Notification WHERE IsRead = 0", cn);
            cn.Open();
            int unreadCount = (int)cm.ExecuteScalar();
            return unreadCount > 0;
        }
    }



}
