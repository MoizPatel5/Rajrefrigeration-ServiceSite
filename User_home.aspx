<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/UserMaster.master" CodeFile="User_home.aspx.cs" EnableEventValidation="false" Inherits="User_home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Raj Refrigeration - User Home</title>
    <link rel="stylesheet" href="User_home.css" />
    <link rel="stylesheet" href="gridviewstyle.css" />
    <style>
        .dataTables_length {
            display: flex;
            align-items: center;
            gap: 5px;
            white-space: nowrap; 
        }

            .dataTables_length label {
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .dataTables_length select {
                width: 60px;
            }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="content" id="contentArea">
            <asp:RadioButtonList
                ID="RadioButtonList1"
                runat="server"
                CssClass="custom-radio-button-list"
                RepeatLayout="Flow"
                RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                <asp:ListItem>Register Complaint</asp:ListItem>
                <asp:ListItem>All Registered Complaints</asp:ListItem>
                <asp:ListItem>All Complaints</asp:ListItem>
                <%-- <asp:ListItem>Pending Complaints</asp:ListItem>--%>
            </asp:RadioButtonList>


            <div id="registerSection" runat="server">
                <h1 class="updatebox-text">Register Complaint</h1>
                <b>
                    <asp:Label ID="Label1" runat="server" Text="Complaint Submitted" ForeColor="Green" Visible="False" Style="float: right;"></asp:Label></b>
                <table>
                    <tr>
                        <th>Call ID :</th>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
                            <asp:Button ID="Button1" runat="server" Text="Random Id" Style="float: right;" CssClass="btn-submit1" OnClick="Button1_Click1" />
                            <br />
                            <asp:Label ID="Label2" runat="server" Text="Same ID Already Registered" ForeColor="Red" Visible="False"></asp:Label>
                            <asp:Label ID="Label3" runat="server" Text="ID Available" Visible="False" ForeColor="Lime"></asp:Label>
                            <asp:Label ID="Label4" runat="server" Text="Enter ID" ForeColor="Red" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th>Date :</th>
                        <td>
                           <asp:TextBox ID="TextBox2" runat="server" TextMode="Date" ReadOnly="true"></asp:TextBox>
                            <asp:Label ID="Label6" runat="server" ForeColor="#FF3300" Text="Select Date" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th>Name :</th>
                        <td>
                            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                            <asp:Label ID="Label7" runat="server" ForeColor="#FF3300" Text="Enter Name" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th>Contact :</th>
                        <td>
                            <asp:TextBox ID="TextBox4" runat="server" TextMode="Number"></asp:TextBox>
                            <asp:TextBox ID="TextBox12" runat="server" placeholder="Alternate Number , If not enter 0" TextMode="Number"></asp:TextBox>
                            <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="Enter valid number" Visible="False"></asp:Label>
                            <asp:Label ID="Label13" runat="server" ForeColor="Red" Text="Enter valid alt number" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th>Address :</th>
                        <td>
                            <asp:TextBox ID="TextBox5" runat="server" TextMode="MultiLine"></asp:TextBox>
                            <asp:Label ID="Label8" runat="server" ForeColor="#FF3300" Text="Enter Address" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th>Product :</th>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="Products" DataValueField="Products"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Products] FROM [Products]"></asp:SqlDataSource>
                            <asp:Label ID="Label9" runat="server" ForeColor="#FF3300" Text="Enter Product" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th>Company :</th>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name] FROM [Company]"></asp:SqlDataSource>
                            <asp:Label ID="Label10" runat="server" ForeColor="#FF3300" Text="Enter Company" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th>Warranty :</th>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server">
                                <asp:ListItem>In Warranty</asp:ListItem>
                                <asp:ListItem>Out Warranty</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <th>Problem :</th>
                        <td>
                            <asp:TextBox ID="TextBox8" runat="server" TextMode="MultiLine"></asp:TextBox>
                            <asp:Label ID="Label11" runat="server" ForeColor="#FF3300" Text="Enter Problem" Visible="False"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:Button ID="Button2" runat="server" Text="Submit" CssClass="btn-submit" OnClick="Button2_Click" />
                <br />
                <br />
            </div>

            <div runat="server" id="div2" visible="false">
                <h1 class="updatebox-text">All Registerd Complaints</h1>
                <table id="complaintsTable" class="gridview" style="width: 100%">
                    <thead>
                        <tr>
                            <th>Call_Id</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Name</th>
                            <th>Contact</th>
                            <th>Address</th>
                            <th>Product</th>
                            <th>Company</th>
                            <th>Warranty</th>
                            <th>Problem</th>
                            <th>RegisBy</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("Call_Id") %></td>
                                    <td><%# Eval("Date") %></td>
                                    <td><%# Eval("Time") %></td>
                                    <td><%# Eval("Name") %></td>
                                    <td><%# Eval("Contact") %></td>
                                    <td><%# Eval("Address") %></td>
                                    <td><%# Eval("Product") %></td>
                                    <td><%# Eval("Company") %></td>
                                    <td><%# Eval("Warranty") %></td>
                                    <td><%# Eval("Problem") %></td>
                                    <td><%# Eval("RegisBy") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                <div id="noDataDiv" style="display: none; text-align: center; margin-top: 20px;">
                    <img src="imgs/nodataimg.png" alt="No Orders Found" />
                </div>
                <div class="update-container" id="updatecontainer">
                    <h3 class="updatebox-text">Update Complaint Details</h3>
                    <asp:Label ID="Label12" runat="server" Text="" Visible="false" Style="float: right"></asp:Label>
                    <label for="TextBox6">Enter Call ID:</label>
                    <asp:TextBox ID="TextBox6" runat="server" CssClass="form-input"></asp:TextBox><br />

                    <label for="DropDownList4">Select Update Term:</label>
                    <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-dropdown" AutoPostBack="True" OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged">
                        <asp:ListItem>Name</asp:ListItem>
                        <asp:ListItem>Contact</asp:ListItem>
                        <asp:ListItem>Address</asp:ListItem>
                        <asp:ListItem>Product</asp:ListItem>
                        <asp:ListItem>Company</asp:ListItem>
                        <asp:ListItem>Warranty</asp:ListItem>
                        <asp:ListItem>Problem</asp:ListItem>
                    </asp:DropDownList><br />

                    <label for="TextBox7">Enter New Value:</label>
                    <div runat="server" id="new1">
                        <asp:TextBox ID="TextBox7" runat="server" CssClass="form-input"></asp:TextBox><br />
                    </div>
                    <div runat="server" id="new2" visible="false">
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlDataSource3" DataTextField="Products" DataValueField="Products"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Products] FROM [Products]"></asp:SqlDataSource>
                    </div>
                    <div runat="server" id="new3" visible="false">
                        <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="SqlDataSource4" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name] FROM [Company]"></asp:SqlDataSource>
                    </div>
                    <div runat="server" id="new4" visible="false">
                        <asp:DropDownList ID="DropDownList7" runat="server">
                            <asp:ListItem>In Warranty</asp:ListItem>
                            <asp:ListItem>Out Warranty</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="button-container">
                        <asp:Button ID="Button3" runat="server" Text="Update" CssClass="btn-submit" OnClick="Button3_Click"/>
                        <%--<asp:Button ID="Button4" runat="server" Text="Delete" CssClass="btn-submit" OnClick="Button4_Click1" Width="49%" />--%>
                    </div>
                </div>
            </div>
            <div runat="server" id="div3" visible="false" style="overflow: auto">
                <h1 class="updatebox-text">All Complaints</h1>

                <table id="complaintsTable2" class="gridview">
                    <thead>
                        <tr>
                            <th>Call_Id</th>
                            <th>Date</th>
                            <th>Name</th>
                            <th>Contact</th>
                            <th>Address</th>
                            <th>Product</th>
                            <th>Company</th>
                            <th>Warranty</th>
                            <th>Problem</th>
                            <th>Assigned_To</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>

                <div id="noDataDiv1" style="display: none; text-align: center; margin-top: 20px;">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/imgs/nodataimg.png" AlternateText="No Orders Found" CssClass="no-data-image" />
                </div><br /><br />
                <button type="button" class="btn-submit" id="togglePendingDiv">Check Pending Complaints</button>
                <div id="pendingComplaintsTable" style="display: none;overflow: auto">
                    <h1 class="updatebox-text">Pending Complaints</h1>
                 <table id="complaintsTable3" class="gridview">
                    <thead>
                        <tr>
                            <th>Call_Id</th>
                            <th>Date</th>
                            <th>Name</th>
                            <th>Contact</th>
                            <th>Address</th>
                            <th>Product</th>
                            <th>Company</th>
                            <th>Warranty</th>
                            <th>Problem</th>
                            <th>Assigned To</th>
                            <th>Reason</th>
                            <th>Part Pending</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="Repeater2" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("Call_id") %></td>
                                    <td><%# Eval("Date") %></td>
                                    <td><%# Eval("Name") %></td>
                                    <td><%# Eval("Contact") %></td>
                                    <td><%# Eval("Address") %></td>
                                    <td><%# Eval("Product") %></td>
                                    <td><%# Eval("Company") %></td>
                                    <td><%# Eval("Warranty") %></td>
                                    <td><%# Eval("Problem") %></td>
                                    <td><%# Eval("Assigned_To") %></td>
                                    <td><%# Eval("Reason") %></td>
                                    <td><%# Eval("PartPending") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                <div id="noDataDiv2" style="display: none; text-align: center; margin-top: 20px;">
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/imgs/nodataimg.png" AlternateText="No Orders Found" CssClass="no-data-image" />
                </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#togglePendingDiv").click(function () {
                var container = $("#pendingComplaintsTable");
                var isVisible = container.is(":visible");

                container.toggle();
                $("#togglePendingDiv").text(isVisible ? "Check Pending Complaints" : "Hide Pending Complaints");
           });
            //JQUERY DATA TABLE FOR REGISTERED COMPLAINTS TABLE

            var table1 = $('#complaintsTable').DataTable({
                "paging": true,
                "searching": true,
                "ordering": true,
                "lengthMenu": [5, 10, 25, 50],
                "pageLength": 10,
                "language": {
                    "paginate": {
                        "previous": "<",
                        "next": ">"
                    }
                },
                "dom": '<"search-container2"l><"search-container"f>rtip',
                "initComplete": function (settings, json) {
                }
            });
            table1.on('draw', function () {
                var rowCount = table1.rows({ filter: 'applied' }).count();

                if (rowCount === 0) {
                    $('#noDataDiv').show();
                    $('#updatecontainer').hide();
                    $('#complaintsTable tbody, .dataTables_info, .dataTables_paginate').hide();
                } else {
                    $('#noDataDiv').hide();
                    $('#updatecontainer').show();
                    $('#complaintsTable tbody').show();
                    $('.dataTables_info, .dataTables_paginate').show();
                }
            });


            //JQUERY DATA TABLE FOR ALL COMPLAINTS TABLE
            var dealerFromSession = '<%= Session["Dealer"] %>';
            var table = $("#complaintsTable2").DataTable({
                "serverSide": true,
                "processing": true,
                "order": [],
                "dom": '<"search-container2"l><"search-container"f>rtip',
                "language": {
                    "paginate": {
                        "previous": "<",
                        "next": ">"
                    },
                },
                "ajax": {
                    "url": "User_home.aspx/GetData",
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
                            searchValue: d.search ? d.search.value : "",
                            dealer: dealerFromSession,
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
                    { "data": "Name" },
                    { "data": "Contact" },
                    { "data": "Address" },
                    { "data": "Product" },
                    { "data": "Company" },
                    { "data": "Warranty" },
                    { "data": "Problem" },
                    { "data": "Assigned_To" },
                    { "data": "Status" }
                ],
                "orderMulti": false,
                "lengthMenu": [5, 10, 25, 50],
                "pageLength": 10,
                "drawCallback": function (settings) {
                    var rowCount = this.api().rows({ filter: "applied" }).count();

                    if (rowCount === 0) {
                        $("#complaintsTable2 tbody, .dataTables_info, .dataTables_paginate").hide();
                        $("#noDataDiv1").show();
                    } else {
                        $("#complaintsTable2 tbody, .dataTables_info, .dataTables_paginate").show();
                        $("#noDataDiv1").hide();
                    }
                }
            });
            var table2 = $('#complaintsTable3').DataTable({
                "paging": true,
                "searching": true,
                "ordering": true,
                "lengthMenu": [5, 10, 25, 50],
                "pageLength": 10,
                "language": {
                    "paginate": {
                        "previous": "<",
                        "next": ">"
                    }
                },
                "dom": '<"search-container2"l><"search-container"f>rtip',
                "initComplete": function (settings, json) {
                    // Manual check immediately after table load
                    var rowCount = table2.rows({ filter: 'applied' }).count();

                    if (rowCount === 0) {
                        $('#noDataDiv2').show();
                        $('#updatecontainer').hide();
                        $('#complaintsTable3 tbody, .dataTables_info, .dataTables_paginate').hide();
                    } else {
                        $('#noDataDiv2').hide();
                        $('#updatecontainer').show();
                        $('#complaintsTable3 tbody').show();
                        $('.dataTables_info, .dataTables_paginate').show();
                    }
                }
            });
            table2.on('draw', function () {
                var rowCount = table2.rows({ filter: 'applied' }).count();

                if (rowCount === 0) {
                    $('#noDataDiv2').show();
                    $('#updatecontainer').hide();
                    $('#complaintsTable3 tbody, .dataTables_info, .dataTables_paginate').hide();
                } else {
                    $('#noDataDiv2').hide();
                    $('#updatecontainer').show();
                    $('#complaintsTable3 tbody').show();
                    $('.dataTables_info, .dataTables_paginate').show();
                }
            });
        });

    </script>
</asp:Content>
