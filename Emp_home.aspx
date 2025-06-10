<%@ Page Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="Emp_home.aspx.cs" EnableEventValidation="false" Inherits="Emp_home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Page-specific head content (optional) -->
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="Emp_home.css" />
    <link rel="stylesheet" href="gridviewstyle.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <style>
        .select2 {
            min-width: 200px; /* Minimum width for dropdown */
        }

        .filter-btn {
            color: white;
            border: none;
            padding: 6px 15px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
            display: inline-block; /* Ensures both buttons stay in a line */
        }

        .btn-success {
            background-color: #28a745; /* Green color */
        }

            .btn-success:hover {
                background-color: #218838; /* Darker green on hover */
            }

        .btn-danger {
            background-color: #dc3545; /* Red color */
            margin-left: 0;
        }

            .btn-danger:hover {
                background-color: #c82333; /* Darker red on hover */
            }

        .highlight-repeated {
            background-color: #fff3cd !important; /* light yellow */
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<div class="container">--%>
    <h1 class="header-text">New Complaints</h1>
    <div id="div1" runat="server" visible="false" style="background-color: lightgreen">
        <center><b>Complain Submitted</b></center>
    </div>
    <div id="div2" runat="server" visible="false" class="modern-div">
        <p class="message">Do you want to send a WhatsApp message for this assignment?</p>
        <div class="button-container">
            <asp:Button ID="Button7" runat="server" Text="Yes" OnClick="Button7_Click" CssClass="button yes-button" />
            <asp:Button ID="Button8" runat="server" Text="No" OnClick="Button8_Click" CssClass="button no-button" />
        </div>
    </div>
    <br />
    <br />
    <br />
    <div id="assignAllDiv" class="assignAllDiv">
        <b>Total Selected Complaints: </b>
        <asp:Label ID="lblSelectedCount" runat="server" Text="0"></asp:Label>
        <br />
        <br />
        <label>Select Worker: </label>
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource3"
            DataTextField="Username" DataValueField="Username" CssClass="worker" AppendDataBoundItems="true">
            <asp:ListItem>Select Worker</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:Button ID="Button1" CssClass="assignAll" runat="server" Text="Assign all complaints" OnClick="Button1_Click" />
        <asp:SqlDataSource ID="SqlDataSource3" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [Username] FROM [Worker]"></asp:SqlDataSource>
    </div>
    <asp:Label ID="Label1" runat="server" Text="Select Worker" Style="color: red; font-weight: bolder;" Visible="false"></asp:Label>
    <div style="display: flex; justify-content: flex-end; align-items: center; gap: 10px; min-width: 150px;">
        <asp:ListBox ID="ddlProductFilter" runat="server" CssClass="form-control select2"
            ClientIDMode="Static" SelectionMode="Multiple"></asp:ListBox>
        <asp:HiddenField ID="hfSelectedProducts" runat="server" ClientIDMode="Static" />

        <div class="btn-group">
            <asp:Button ID="btnFilter" runat="server" CssClass="btn-success filter-btn" Text="✔" OnClick="btnFilter_Click" title="Apply Filter" />
            <asp:Button ID="Button4" runat="server" CssClass="btn-danger filter-btn " Text="X" OnClick="btnClearFilter_Click" title="Clear Filter" />
        </div>


    </div>

    <div style="overflow: auto">
        <table id="complaintsTable" class="gridview">
            <thead>
                <tr>
                    <th>Select Complaints</th>
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
                    <th>Dealer</th>
                    <th>Manage Complaints</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand">
                    <ItemTemplate>
                        <tr style='<%# Convert.ToBoolean(Eval("isRepeated")) ? "background-color:#fff7b3;" : "" %>'>
                            <td>
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                                <asp:HiddenField ID="HiddenField_CallId" runat="server" Value='<%# Eval("Call_Id") %>' />
                            </td>
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
                            <td><%# Eval("Dealer") %></td>
                            <td>
                                <div class="btn-group">
                                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="dropdownlist"
                                        DataSourceID="SqlDataSource2" DataTextField="Username" DataValueField="Username" AppendDataBoundItems="true">
                                        <asp:ListItem>Select Worker</asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                        SelectCommand="SELECT [Username] FROM [Worker]"></asp:SqlDataSource>

                                    <!-- Assign Button -->
                                    <asp:Button ID="Button3" runat="server" CssClass="assign-btn"
                                        Text="✔" CommandName="Assign" CommandArgument='<%# Eval("Call_Id") %>'
                                        title="Assign Complaint" />

                                    <!-- Delete Button -->
                                    <a href="javascript:void(0);" class="delete-btn"
                                        onclick='cancelComplaint("<%# Eval("Call_Id") %>")' title="Cancel Complaint">X
                                    </a>
                                    <!-- Update Button -->
                                    <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("Call_Id") %>'
                                        CommandName="Updatecallid" CssClass="link-btn" OnClick="LinkButton1_Click">
                                            <img src="imgs/updatecallid.png" alt="Update" title="Update" width="25px" height="25px">
                                    </asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>

            </tbody>
        </table>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Call_Id], [Date], [Time],[Name], [Contact], [Address], [Product], [Company], [Warranty], [Problem], [RegisBy] FROM [Complain]"></asp:SqlDataSource>
    <asp:Label ID="Label4" runat="server" Text=""></asp:Label>
    <%--</div>--%>
    <div id="noDataDiv" style="display: none; text-align: center; margin-top: 20px;">
        <asp:Image ID="NoDataImage" runat="server" ImageUrl="~/imgs/nodataimg.png"
            AlternateText="No Complaints Found" CssClass="no-data-image" />
    </div>
    <!-- Update Complaint Section -->
    <div id="overlay" class="overlay"></div>
    <div id="popup" class="popup">
        <div class="section">
            <h1>Update Call ID</h1>
            <asp:HiddenField ID="HiddenFieldPopup" runat="server" />
            Old ID:
               <asp:TextBox ID="TextBox2" runat="server" ReadOnly="true"></asp:TextBox>
            <br />
            New ID:
               <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
            <br />
            <asp:Label ID="Label6" runat="server" Text="Complaint update successfully" ForeColor="Green" Visible="false"></asp:Label>
            <br />
            <asp:Button ID="Button2" runat="server" Text="Update" class="btn-submit" OnClick="Button2_Click" Width="49%" />
            <button type="button" class="btn-submit" onclick="closePopup()" style="width: 49%;">Close</button>
        </div>
    </div>
    <%--CANCEL MODAL POPUP--%>
    <div id="cancelModal" class="cancel-container" style="display: none;">
        <div class="cancel-content">
            <h2 class="cancel-title">Cancel Complaint</h2>
            <asp:Label ID="Label18" runat="server" Text="" Visible="false" Style="float: right;"></asp:Label>
            <asp:Label ID="Label19" runat="server" Text="" Visible="false" class="error-message"></asp:Label>
            <br />
            <div class="form-group">
                <label for="TextBox13">Call ID:</label>
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:TextBox ID="TextBox1" runat="server" CssClass="textbox" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="TextBox14">Enter Reason:</label>
                <asp:TextBox ID="TextBox13" runat="server" CssClass="textbox" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="button-group">
                <asp:Button ID="Button5" runat="server" Text="Save" CssClass="btn-submit" OnClick="Cancel_Click" Width="49%" />
                <asp:Button ID="Button6" runat="server" Text="Close" CssClass="btn-submit" OnClientClick="closeCancelModal(); return false;" Width="49%" />
            </div>
        </div>
    </div>
    <div class="div-border" runat="server" visible="false">
        <asp:Label ID="Label8" runat="server" Text="" Visible="false"></asp:Label>

        <asp:Label ID="Label7" runat="server" Text="Complaint details will be shown here" CssClass="label-style"></asp:Label>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script type="text/javascript">
        var repeatedCallIds = [];
    <% 
        var ids = Session["RepeatedCallIds"] as List<string>;
        if (ids != null)
        {
            foreach (var id in ids)
            {
                %> repeatedCallIds.push('<%= id %>'); <%
            }
        }
    %>
        $(document).ready(function () {
            var shouldOpen = $('#<%= HiddenFieldPopup.ClientID %>').val();
            if (shouldOpen === "true") {
                openPopup();
            }
            $('.select2').select2({
                placeholder: "Select Products",
                allowClear: true,
                closeOnSelect: false
            });
        });

        // Function to open the popup
        function openPopup() {
            document.getElementById('popup').style.display = 'flex';
            $('#<%= HiddenFieldPopup.ClientID %>').val("true");
        }

        // Function to close the popup
        function closePopup() {
            document.getElementById('popup').style.display = 'none';
            $('#<%= HiddenFieldPopup.ClientID %>').val("false");
        }
        function confirmDelete() {
            return confirm('Are you sure you want to delete this complaint?');
        }
        $(document).ready(function () {
            // Initialize DataTable
            $('#complaintsTable').DataTable({
                "paging": false,
                "searching": true,
                "ordering": true,
                "searchHighlight": true,
                "dom": '<"search-container"f>rtip',
                "drawCallback": function (settings) {
                    var api = this.api();
                    var rowCount = api.rows({ filter: 'applied' }).count();

                    if (rowCount === 0) {
                        $("#complaintsTable tbody").hide();
                        $("#noDataDiv").css("display", "block");
                    } else {
                        $("#complaintsTable tbody").show();
                        $("#noDataDiv").css("display", "none");
                    }
                    // Highlight repeated complaints
                    $('#complaintsTable tbody tr').each(function () {
                        var callId = $(this).find('td:nth-child(2)').text().trim(); // 2nd column is Call_Id
                        if (repeatedCallIds.includes(callId)) {
                            $(this).addClass('highlight-repeated');
                        }
                    });
                }
            });

            // Function to update the selected count
            function updateSelectedCount() {
                var selectedCount = $('#complaintsTable').find('input[type="checkbox"]:checked').length;
                $('#<%= lblSelectedCount.ClientID %>').text(selectedCount);

                // Show/hide div based on count
                if (selectedCount > 0) {
                    $('#assignAllDiv').show(); // Ensure display is not blocked by CSS
                } else {
                    $('#assignAllDiv').hide();
                }
            }

            // Attach change event for dynamically created checkboxes
            $(document).on('change', '#complaintsTable input[type="checkbox"]', function () {
                updateSelectedCount();
            });

            // Initial count update (in case some are pre-checked)
            updateSelectedCount();
        });
        function cancelComplaint(callId) {
            document.getElementById("<%= TextBox1.ClientID %>").value = callId;
            document.getElementById("<%= HiddenField1.ClientID %>").value = callId;
            document.getElementById("<%= TextBox13.ClientID %>").value = "";
            document.getElementById("cancelModal").style.display = "block";
        }

        function closeCancelModal() {
            document.getElementById("cancelModal").style.display = "none";
        }
        function checkCancelForm() {
            var callId = document.getElementById('<%= TextBox1.ClientID %>').value.trim();
            var reason = document.getElementById('<%= TextBox13.ClientID %>').value.trim();
            var saveBtn = document.getElementById('<%= Button5.ClientID %>');

            if (callId === "" || reason === "") {
                saveBtn.disabled = true;
            } else {
                saveBtn.disabled = false;
            }
        }

        // Attach the checkCancelForm function to keyup and change events
        window.onload = function () {
            document.getElementById('<%= TextBox1.ClientID %>').addEventListener('input', checkCancelForm);
        document.getElementById('<%= TextBox13.ClientID %>').addEventListener('input', checkCancelForm);
            checkCancelForm(); // Run on load in case fields are prefilled
        };

    </script>

</asp:Content>
