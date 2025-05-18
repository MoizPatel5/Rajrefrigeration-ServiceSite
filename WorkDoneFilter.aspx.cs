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

public partial class WorkDoneFilter : System.Web.UI.Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        connection = obj.connectionString();
        checklogin();
    }
    protected void checklogin()
    {
        if (Session["Logindone"] == null || (bool)Session["Logindone"] == false)
        {
            Response.Redirect("Default.aspx");
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("Work_Done.aspx");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        using (SqlConnection cn = new SqlConnection(connection))
        {
            string startDate = TextBox1.Text;
            string endDate = TextBox2.Text;
            string ccStartDate = TextBox3.Text;
            string ccEndDate = TextBox4.Text;
            string worker = Request.Form[DropDownList1.UniqueID];  
            string company = Request.Form[DropDownList2.UniqueID]; 
            string warranty = DropDownList3.SelectedValue;
            string product = Request.Form[DropDownList4.UniqueID];

            string query = "SELECT * FROM Work_Done WHERE 1=1";

            List<SqlParameter> parameters = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate))
            {
                query += " AND Date BETWEEN @startDate AND @endDate";
                parameters.Add(new SqlParameter("@startDate", startDate));
                parameters.Add(new SqlParameter("@endDate", endDate));
            }
            if (!string.IsNullOrEmpty(ccStartDate) && !string.IsNullOrEmpty(ccEndDate))
            {
                query += " AND CC_Date BETWEEN @ccStartDate AND @ccEndDate";
                parameters.Add(new SqlParameter("@ccStartDate", ccStartDate));
                parameters.Add(new SqlParameter("@ccEndDate", ccEndDate));
            }
            if (!string.IsNullOrEmpty(worker))
            {
                query += " AND WorkDoneBy IN (" + string.Join(",", worker.Split(',').Select((s, i) => "@worker" + i)) + ")";
                int x = 0;
                foreach (var w in worker.Split(','))
                {
                    parameters.Add(new SqlParameter("@worker" + x, w));
                    x++;
                }
            }
            if (!string.IsNullOrEmpty(company))
            {
                query += " AND Company IN (" + string.Join(",", company.Split(',').Select((s, i) => "@company" + i)) + ")";
                int j = 0;
                foreach (var c in company.Split(','))
                {
                    parameters.Add(new SqlParameter("@company" + j, c));
                    j++;
                }
            }
            if (!string.IsNullOrEmpty(warranty))
            {
                query += " AND Warranty = @warranty";
                parameters.Add(new SqlParameter("@warranty", warranty));
            }
            if (!string.IsNullOrEmpty(product))
            {
                query += " AND Product IN (" + string.Join(",", product.Split(',').Select((s, i) => "@product" + i)) + ")";
                int k = 0;
                foreach (var p in product.Split(','))
                {
                    parameters.Add(new SqlParameter("@product" + k, p));
                    k++;
                }
            }
            if ((!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate)) || (!string.IsNullOrEmpty(ccStartDate) && !string.IsNullOrEmpty(ccEndDate)) || !string.IsNullOrEmpty(worker) || !string.IsNullOrEmpty(company) || !string.IsNullOrEmpty(warranty) || !string.IsNullOrEmpty(product))
            {
                SqlCommand cm = new SqlCommand(query, cn);
                cm.Parameters.AddRange(parameters.ToArray());

                SqlDataAdapter da = new SqlDataAdapter(cm);
                DataSet ds = new DataSet();

                da.Fill(ds);
                Label1.Visible = false;
                rptComplaints.DataSourceID = null;
                rptComplaints.DataSource = ds.Tables[0];
                rptComplaints.DataBind();
            }
            else
            {
                Label1.Visible = true;
                rptComplaints.DataSourceID = null;
                rptComplaints.DataBind();
            }
        }
    }

}