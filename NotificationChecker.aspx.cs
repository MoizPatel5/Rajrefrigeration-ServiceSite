using System;
using System.Data.SqlClient;
using System.Web.Services;

public partial class NotificationChecker : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        checklogin();
    }
    protected void checklogin()
    {
        if (Session["Logindone"] == null || (bool)Session["Logindone"] == false)
        {
            Response.Redirect("Default.aspx");
        }
    }
    [WebMethod]
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
