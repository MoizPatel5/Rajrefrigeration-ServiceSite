using System;
using System.Web.UI;
using System.Data.SqlClient;

public partial class Default2 : Page
{
    Class1 obj = new Class1();
    string connection;
    protected void Page_Load(object sender, EventArgs e)
    {
        checklogin();
        connection = obj.connectionString();
    }
    protected void checklogin()
    {
        if (Session["Logindone"] == null || (bool)Session["Logindone"] == false)
        {
            Response.Redirect("Default.aspx");
        }
    }
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        DateTime startDate;
        DateTime endDate;

        bool isStartDateValid = DateTime.TryParse(txtStartDate.Text, out startDate);
        bool isEndDateValid = DateTime.TryParse(txtEndDate.Text, out endDate);

        if (isStartDateValid && isEndDateValid)
        {
            // Format the dates to avoid SQL conversion issues
            string formattedStartDate = startDate.ToString("yyyy-MM-dd");
            string formattedEndDate = endDate.ToString("yyyy-MM-dd");

            string filterQuery = "SELECT WorkDoneBy, COUNT(*) AS TotalComplains FROM Work_Done WHERE [Date] >= @StartDate AND [Date] <= @EndDate";

            string warrantyStatus = ddlWarrantyStatus.SelectedValue;
            if (!string.IsNullOrEmpty(warrantyStatus))
            {
                filterQuery += " AND Warranty = @WarrantyStatus";
            }

            filterQuery += " GROUP BY WorkDoneBy ORDER BY TotalComplains DESC";

            SqlConnection conn = new SqlConnection(connection);
            SqlCommand cmd = new SqlCommand(filterQuery, conn);

            // Use the correctly formatted dates
            cmd.Parameters.AddWithValue("@StartDate", formattedStartDate);
            cmd.Parameters.AddWithValue("@EndDate", formattedEndDate);
            if (!string.IsNullOrEmpty(warrantyStatus))
            {
                cmd.Parameters.AddWithValue("@WarrantyStatus", warrantyStatus);
            }

            try
            {
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                Chart1.Series["Series1"].Points.Clear();

                int totalComplaints = 0;
                while (reader.Read())
                {
                    string worker = reader["WorkDoneBy"].ToString();
                    int totalComplains = Convert.ToInt32(reader["TotalComplains"]);

                    // Add data points to the chart
                    int pointIndex = Chart1.Series["Series1"].Points.AddXY(worker, totalComplains);

                    // Calculate the percentage
                    totalComplaints += totalComplains;

                    // Set the label for the data point
                    var dataPoint = Chart1.Series["Series1"].Points[pointIndex];
                    double percentage = (totalComplains * 100.0) / totalComplaints;

                    dataPoint.Label = string.Format("{0} ({1:0.0}%)", totalComplains, percentage);

                    // Set the legend text for the worker
                    dataPoint.LegendText = worker;
                }

                reader.Close();
                conn.Close();

                Label1.Text = "Total Complaints: " + totalComplaints;
                if (totalComplaints == 0)
                {
                    Label1.Text = "No data available for the selected dates.";
                }
            }
            catch (Exception ex)
            {
                Label1.Text = "Error: " + ex.Message;
            }
        }
        else
        {
            Label1.Text = "Please enter valid dates.";
        }
    }
}
