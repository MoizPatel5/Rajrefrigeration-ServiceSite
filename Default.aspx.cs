using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;

public partial class Default2 : System.Web.UI.Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        connection = obj.connectionString();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        validateuser(TextBox1.Text.Trim(), TextBox2.Text.Trim());
    }
    protected void validateuser(string p1, string p2)
    {
        if (string.IsNullOrEmpty(p1))
        { Label1.Text = "Enter Username"; return; }
        if (string.IsNullOrEmpty(p2))
        { Label1.Text = "Enter Password"; return; }

        using (SqlConnection cn = new SqlConnection(connection))
        {
            cn.Open();
            var sql =
              @"SELECT ml.Role,
                   u.Dealer
            FROM Master_login ml
            LEFT JOIN Users u
              ON u.Username = ml.Username
            WHERE ml.Username = @uname
              AND ml.Password = @pass";

            using (var cmd = new SqlCommand(sql, cn))
            {
                cmd.Parameters.AddWithValue("@uname", p1);
                cmd.Parameters.AddWithValue("@pass", p2);
                using (var dr = cmd.ExecuteReader())
                {
                    if (!dr.Read())
                    {
                        Label1.Text = "Wrong Username or Password";
                        return;
                    }

                    string role = dr.GetString(0);
                    string dealer = dr.IsDBNull(1) ? "" : dr.GetString(1);

                    Session["Username"] = p1;
                    Session["Dealer"] = dealer;
                    Session["LoginUserdone"] = role == "User";
                    Session["Logindone"] = role == "Employee";
                    Session["LoginAdmindone"] = role == "Admin";

                    Label1.Visible = false;
                    switch (role)
                    {
                        case "User": Response.Redirect("User_home.aspx"); break;
                        case "Employee": Response.Redirect("Emp_home.aspx"); break;
                        case "Admin": Response.Redirect("AAA.aspx"); break;
                        default:
                            Label1.Text = "Role not recognized.";
                            Label1.Visible = true;
                            break;
                    }
                }
            }
        }
    }
}