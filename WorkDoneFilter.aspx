<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkDoneFilter.aspx.cs" Inherits="WorkDoneFilter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="gridviewstyle.css" />
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- jQuery & Select2 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>

    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" />
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

    <!-- DataTables Buttons -->
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css" />
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #F8F1E7; /* Light background color */
            margin: 0;
            padding: 20px;
        }

        .filter-container {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .form-control, .select2-container--default .select2-selection--single {
            border-radius: 8px;
        }

        .table-container {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            overflow: auto;
        }

        .btn-apply {
            background: #007bff;
            color: #fff;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: bold;
        }

            .btn-apply:hover {
                background: #0056b3;
            }

        .dataTables_length select {
            width: 80px !important; /* Adjust the width as needed */
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">

            <!-- Filter Section -->
            <div class="filter-container container-fluid">
                <h4 class="text-center mb-4 header-text">Filter Work Done</h4>

                <div class="row row-cols-1 row-cols-md-3 g-4">
                    <!-- Date Range -->
                    <div class="col">
                        <label class="form-label">Date (From - To)</label>
                        <div class="input-group">
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                    </div>

                    <!-- CC Date -->
                    <div class="col">
                        <label class="form-label">CC Date (From - To)</label>
                        <div class="input-group">
                            <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Select Worker -->
                    <div class="col">
                        <label class="form-label">Select Worker</label>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1"
                            DataTextField="Username" DataValueField="Username" CssClass="form-select select2" Multiple="true">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                            SelectCommand="SELECT [Username] FROM [Worker]"></asp:SqlDataSource>
                    </div>

                    <!-- Select Company -->
                    <div class="col">
                        <label class="form-label">Select Company</label>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2"
                            DataTextField="Name" DataValueField="Name" CssClass="form-select select2" Multiple="true">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                            SelectCommand="SELECT [Name] FROM [Company]"></asp:SqlDataSource>
                    </div>

                    <!-- Select Warranty -->
                    <div class="col">
                        <label class="form-label">Select Warranty</label>
                        <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-select">
                            <asp:ListItem Value="">---Select Warranty---</asp:ListItem>
                            <asp:ListItem>In Warranty</asp:ListItem>
                            <asp:ListItem>Out Warranty</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Select Product -->
                    <div class="col">
                        <label class="form-label">Select Product</label>
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSource3"
                            DataTextField="Products" DataValueField="Products" CssClass="form-select select2" Multiple="true">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                            SelectCommand="SELECT [Products] FROM [Products]"></asp:SqlDataSource>
                    </div>
                </div>

                <!-- Error Message -->
                <div class="text-center mt-2">
                    <asp:Label ID="Label1" runat="server" Text="Please select a field" Visible="false" CssClass="text-danger"></asp:Label>
                </div>

                <!-- Buttons -->
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mt-4">
                    <asp:Button ID="Button2" runat="server" Text="← Back" CssClass="btn btn-outline-secondary btn-lg px-4 mb-2 mb-md-0" OnClick="Button2_Click" />
                    <asp:Button ID="Button1" runat="server" Text="Apply Filter" CssClass="btn-submit" Style="width: 20%" OnClick="Button1_Click" />
                </div>
            </div>

            <!-- Data Table -->
            <div class="table-container">
                <table id="complaintsTable" class="gridview">
                    <thead class="table-dark">
                        <tr>
                            <th>Call_Id</th>
                            <th>Date</th>
                            <th>CC_Date</th>
                            <th>Name</th>
                            <th>Contact</th>
                            <th>Address</th>
                            <th>Product</th>
                            <th>Company</th>
                            <th>Warranty</th>
                            <th>Problem</th>
                            <th>Work Done By</th>
                            <th>Details</th>
                            <th>Charges</th>
                            <th>To Pay</th>
                            <th>Dealer</th>
                            <th>Item Code</th>
                            <th>Def Return</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptComplaints" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("Call_id") %></td>
                                    <td><%# Eval("Date") %></td>
                                    <td><%# Eval("CC_Date") %></td>
                                    <td><%# Eval("Name") %></td>
                                    <td><%# Eval("Contact") %></td>
                                    <td><%# Eval("Address") %></td>
                                    <td><%# Eval("Product") %></td>
                                    <td><%# Eval("Company") %></td>
                                    <td><%# Eval("Warranty") %></td>
                                    <td><%# Eval("Problem") %></td>
                                    <td><%# Eval("WorkDoneBy") %></td>
                                    <td><%# Eval("Details") %></td>
                                    <td><%# Eval("Charges") %></td>
                                    <td><%# Eval("ToPay") %></td>
                                    <td><%# Eval("Dealer") %></td>
                                    <td><%# Eval("ItemCode") %></td>
                                    <td><%# Eval("Def_Return") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
            <div class="totals-container d-flex justify-content-center gap-4 mt-3">
                <div class="card shadow border-0" style="width: 18rem;">
                    <div class="card-body text-center">
                        <h5 class="card-title text-success fw-bold">
                            <i class="fas fa-wallet"></i>Total Charges:
                        </h5>
                        <h4 id="totalCharges" class="text-success fw-bold">₹0.00</h4>
                    </div>
                </div>
                <div class="card shadow border-0" style="width: 18rem;">
                    <div class="card-body text-center">
                        <h5 class="card-title text-danger fw-bold">
                            <i class="fas fa-money-bill-wave"></i>Total To Pay:
                        </h5>
                        <h4 id="totalToPay" class="text-danger fw-bold">₹0.00</h4>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $(document).ready(function () {
                    $(".select2").select2({
                        placeholder: "Select an option",
                        allowClear: true,
                        closeOnSelect: false
                    });
                    var selectedProducts = '<%= Request.Form[DropDownList4.UniqueID] %>'.split(',');
                    $('#<%= DropDownList4.ClientID %>').val(selectedProducts).trigger('change');

                    var selectedWorkers = '<%= Request.Form[DropDownList1.UniqueID] %>'.split(',');
                    $('#<%= DropDownList1.ClientID %>').val(selectedWorkers).trigger('change');

                    var selectedCompanies = '<%= Request.Form[DropDownList2.UniqueID] %>'.split(',');
                    $('#<%= DropDownList2.ClientID %>').val(selectedCompanies).trigger('change');
                });

                $("#complaintsTable").DataTable({
                    responsive: true,
                    lengthMenu: [5, 10, 25, 50, 100],
                    pageLength: 10,
                    dom: '<"top d-flex justify-content-between"lBf>rt<"bottom"ip>',
                    buttons: [
                        'copy', 'excel', 'csv', {
                            extend: 'pdfHtml5',
                            text: 'PDF',
                            orientation: 'landscape',
                            pageSize: 'A3',
                            exportOptions: {
                                columns: ':visible'
                            }
                        }, 'print'
                    ]
                });

                // Function to update the sum dynamically for both columns
                function updateSums() {
                    var chargesSum = 0, toPaySum = 0;

                    // Check if DataTable is initialized
                    if ($.fn.DataTable.isDataTable("#complaintsTable")) {
                        var table = $("#complaintsTable").DataTable();

                        // Loop through all visible rows and sum the "Charges" and "To Pay" columns
                        table.rows({ search: "applied" }).every(function () {
                            var rowData = this.data();
                            var charges = parseFloat(rowData[12]) || 0; // Charges column (index 12)
                            var toPay = parseFloat(rowData[13]) || 0;   // To Pay column (index 13)
                            chargesSum += charges;
                            toPaySum += toPay;
                        });

                        // Update total values in the UI
                        $("#totalCharges").text("₹" + chargesSum.toFixed(2));
                        $("#totalToPay").text("₹" + toPaySum.toFixed(2));
                    }
                }

                // Trigger updateSums whenever the table is reloaded
                $(document).on("draw.dt", "#complaintsTable", function () {
                    updateSums();
                });

                // Call updateSums manually when filters change
                $(".filter-container select, .filter-container input").on("change", function () {
                    updateSums();
                });

            });
        </script>
    </form>
</body>
</html>
