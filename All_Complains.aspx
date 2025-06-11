<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/EmployeeMasterPage.master" CodeFile="All_Complains.aspx.cs" Inherits="All_Complains" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>All Complains</title>
    <link rel="stylesheet" href="All_Complains.css" />
    <link rel="stylesheet" href="gridviewstyle.css" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <center><h1 class="header-text">All Complaints</h1></center>

       
        <table id="complaintsTable" class="gridview" style="width: 100%">
            <thead>
                <tr>
                    <th>Call Id</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Name</th>
                    <th>Contact</th>
                    <th>Address</th>
                    <th>Product</th>
                    <th>Company</th>
                    <th>Warranty</th>
                    <th>Problem</th>
                    <th>Assigned To</th>
                    <th>Regis By</th>
                    <th>Dealer</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div id="noDataDiv" style="display: none; text-align: center; margin-top: 20px;">
            <img src="imgs/nodataimg.png" alt="No Data Found" class="no-data-image" />
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                var table = $("#complaintsTable").DataTable({
                    "serverSide": true,
                    "processing": true,
                    "order": [],
                    "dom": '<"search-container2"l><"search-container"f>rtip',
                    "language": {
                        "paginate": {
                            "previous": "<",
                            "next": ">"
                        }
                    },
                    "ajax": {
                        "url": "All_Complains.aspx/GetData",
                        "type": "POST",
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "data": function (d) {
                            return JSON.stringify({
                                draw: d.draw,
                                start: d.start,
                                length: d.length,
                                orderColumn: d.order.length > 0 ? d.order[0].column : 0,
                                orderDir: d.order.length > 0 ? d.order[0].dir : "asc",
                                searchValue: d.search ? d.search.value : ""
                            });
                        },
                        "dataSrc": function (json) {
                            let parsedData = JSON.parse(json.d);
                            json.recordsTotal = parsedData.recordsTotal;
                            json.recordsFiltered = parsedData.recordsFiltered;
                            return parsedData.data;
                        }
                    },
                    "columns": [
                        { "data": "Call_Id" },
                        { "data": "Date" },
                        { "data": "Time" },
                        { "data": "Name" },
                        { "data": "Contact" },
                        { "data": "Address" },
                        { "data": "Product" },
                        { "data": "Company" },
                        { "data": "Warranty" },
                        { "data": "Problem" },
                        { "data": "Assigned_To" },
                        { "data": "RegisBy" },
                        { "data": "Dealer" },
                        { "data": "Status" }
                    ],
                    "rowCallback": function (row, data, index) {
                        if (data.isRepeated === 1 || data.isRepeated === true) {
                            $(row).css("background-color", "#fff7b3"); // light yellow
                        }
                    },
                    "orderMulti": false,
                    "lengthMenu": [5, 10, 25, 50, 100],
                    "pageLength": 10,
                    "drawCallback": function (settings) {
                        var rowCount = this.api().rows({ filter: "applied" }).count();

                        if (rowCount === 0) {
                            $("#complaintsTable tbody").hide(); 
                            $("#noDataDiv").show();  
                        } else {
                            $("#complaintsTable tbody").show(); 
                            $("#noDataDiv").hide();  
                        }
                    }
                });
            });
        </script>
</asp:Content>
