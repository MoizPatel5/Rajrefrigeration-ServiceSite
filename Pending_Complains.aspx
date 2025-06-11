<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/EmployeeMasterPage.master" CodeFile="Pending_Complains.aspx.cs" Inherits="Pending_Complains" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Pending Complains</title>
    <link rel="stylesheet" href="Pending_Complains.css" />
    <link rel="stylesheet" href="gridviewstyle.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <center><h1 class="header-text">Pending Complaints</h1></center>
        <div class="top-right-filters">
            <asp:DropDownList ID="cmpnyDrp" runat="server" CssClass="filter-dropdown filterDrp" AppendDataBoundItems="True" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Name">
                <asp:ListItem Value="">All Companies</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name] FROM [Company]"></asp:SqlDataSource>
            <asp:DropDownList ID="partPendingDrp" runat="server" CssClass="filter-dropdown filterDrp">
                <asp:ListItem Value="" disabled="true">Filter by Part Pending</asp:ListItem>
                <asp:ListItem Value="">All Options</asp:ListItem>
                <asp:ListItem>Yes</asp:ListItem>
                <asp:ListItem>No</asp:ListItem>
            </asp:DropDownList>
            <asp:HiddenField ID="hdnSelectedCompany" runat="server" />
            <asp:HiddenField ID="hdnPartPendingOption" runat="server" />
        </div>
        <table id="complaintsTable" class="gridview">
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
                    <th>Reason</th>
                    <th>Part Pending</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptComplaints" runat="server">
                    <ItemTemplate>
                        <tr style='<%# Convert.ToBoolean(Eval("isRepeated")) ? "background-color:#fff7b3;" : "" %>'>
                            <td><%# Eval("Call_id") %></td>
                            <td><%# Eval("Date") %></td>
                            <td><%# Eval("Time") %></td>
                            <td><%# Eval("Name") %></td>
                            <td><%# Eval("Contact") %></td>
                            <td><%# Eval("Address") %></td>
                            <td><%# Eval("Product") %></td>
                            <td><%# Eval("Company") %></td>
                            <td><%# Eval("Warranty") %></td>
                            <td><%# Eval("Problem") %></td>
                            <td><%# Eval("Assigned_To") %></td>
                            <td><%# Eval("RegisBy") %></td>
                            <td><%# Eval("Dealer") %></td>
                            <td><%# Eval("Reason") %></td>
                            <td><%# Eval("PartPending") %></td>
                            <td class="btn-group">
                                <a href="javascript:void(0);" class="delete-btn"
                                    onclick='cancelComplaint("<%# Eval("Call_Id") %>")' title="Cancel Complaint">X
                                </a>
                                <a href="javascript:void(0);" class="link-btn"
                                    onclick='openUpdatePopup("<%# Eval("Call_Id") %>")' title="Update Call ID">
                                    <img src="imgs/updatecallid.png" alt="Update" width="25px" height="25px" />
                                </a>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        <div id="noDataDiv" style="display: none; text-align: center; margin-top: 20px;">
            <asp:Image ID="NoDataImage" runat="server" ImageUrl="~/imgs/nodataimg.png"
                AlternateText="No Complaints Found" CssClass="no-data-image" />
        </div>

        <div class="container2">
            <div class="boxes-wrapper">
                <div class="flexdiv pending-box">
                    <asp:Label ID="LabelMessage" runat="server" Text="" Style="float: right" CssClass="message-label"></asp:Label>
                    <h1 class="updatebox-text">Re-Assign Complaint</h1>

                    <asp:Label ID="Label1" runat="server" Text="Enter Call Id:" CssClass="label-text"></asp:Label>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="input-textbox"></asp:TextBox><br />
                    <asp:Label ID="Label2" runat="server" Text="Select Employee :" CssClass="label-text"></asp:Label>
                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSource5" DataTextField="Username" DataValueField="Username" AutoPostBack="True" CssClass="input-textbox" AppendDataBoundItems="true">
                        <asp:ListItem>New Complaint</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Username] FROM [Worker]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Username] FROM [Worker] WHERE ([Number] = @Number)"></asp:SqlDataSource>
                    <asp:Label ID="Label10" runat="server" Text="Label" Visible="false"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="Label9" runat="server" Text="Complains" Visible="false"></asp:Label>
                    <asp:Button ID="btnReAssign" runat="server" Text="Re-Assign" CssClass="btn-submit" OnClick="btnReAssign_Click" />


                </div>
                <div class="flexdiv work-done-box">
                    <asp:Label ID="Label7" runat="server" Text="" Style="float: right;"></asp:Label>
                    <center><h1 class="updatebox-text">Work Done</h1></center>


                    <div class="form-group">
                        <asp:Label ID="Label5" runat="server" Text="Enter Call Id :" CssClass="label-text"></asp:Label>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="input-textbox"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <asp:Label ID="Label6" runat="server" Text="Details :" CssClass="label-text"></asp:Label>
                        <asp:TextBox ID="TextBox6" runat="server" CssClass="input-textbox"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <asp:Label ID="Label8" runat="server" Text="Charges :" CssClass="label-text"></asp:Label>
                        <asp:TextBox ID="TextBox7" runat="server" CssClass="input-textbox" TextMode="Number"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <asp:Label ID="Label14" runat="server" Text="To Pay :" CssClass="label-text"></asp:Label>
                        <asp:TextBox ID="TextBox10" runat="server" CssClass="input-textbox" TextMode="Number"></asp:TextBox>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="form-group checkbox-group">
                                <asp:CheckBox ID="CheckBox2" runat="server" CssClass="label-text" Text="Tick if part added" AutoPostBack="true" OnCheckedChanged="CheckBox2_CheckedChanged" />
                            </div>

                            <div runat="server" id="partdiv" visible="false" class="part-div">
                                <div class="form-group">
                                    <asp:Label ID="Label15" runat="server" Text="Part Code :" CssClass="label-text"></asp:Label>
                                    <asp:TextBox ID="TextBox11" runat="server" CssClass="input-textbox"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label17" runat="server" Text="Charge Taken :" CssClass="label-text"></asp:Label>
                                    <asp:TextBox ID="TextBox12" runat="server" CssClass="input-textbox" TextMode="Number"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label16" runat="server" Text="Defective return :" CssClass="label-text"></asp:Label>
                                    <asp:DropDownList ID="DropDownList5" runat="server" CssClass="input-textbox">
                                        <asp:ListItem>Yes</asp:ListItem>
                                        <asp:ListItem>No</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="form-group">
                        <asp:Button ID="Button3" runat="server" Text="Work Done" CssClass="btn-submit" OnClick="Done_Click" />
                    </div>
                </div>
            </div>
        </div>

        <br />
        <div id="popupContainer" class="popup-container" style="display: none;">
            <div class="popup-content">
                <center> <h3 class="updatebox-text">Update Call Id</h3></center>
                <asp:HiddenField ID="HiddenFieldPopup" runat="server" />
                <asp:Label ID="Label13" runat="server" Text="" Visible="false" Style="float: right;"></asp:Label>
                <asp:Label ID="Label11" runat="server" Text="Enter Call id:" class="popup-label"></asp:Label>
                <asp:TextBox ID="TextBox8" runat="server" CssClass="input-textbox" ReadOnly="true"></asp:TextBox><br />
                <asp:HiddenField ID="HiddenCallId" runat="server" />
                <br />

                <asp:Label ID="Label12" runat="server" Text="Enter New Call id:" class="popup-label"></asp:Label>
                <asp:TextBox ID="TextBox9" runat="server" CssClass="input-textbox"></asp:TextBox><br />

                <asp:Button ID="Button2" runat="server" Text="Update" CssClass="btn-submit" OnClick="Button1_Click" Width="49%" />
                <button type="button" class="btn-submit" onclick="closePopup()" style="width: 49%">Close</button>
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
                    <asp:Button ID="Button4" runat="server" Text="Save" CssClass="btn-submit" OnClick="Cancel_Click" Width="49%" />
                    <asp:Button ID="Button6" runat="server" Text="Close" CssClass="btn-submit" OnClientClick="closeCancelModal(); return false;" Width="49%" />
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            // Check if the popup should be open after postback
            var shouldOpen = $('#<%= HiddenFieldPopup.ClientID %>').val();
        if (shouldOpen === "true") {
            openPopup();
        }

        // Retrieve saved filter values from hidden fields (if they exist)
        var savedCompany = $('#<%= hdnSelectedCompany.ClientID %>').val();
        var savedPartPending = $('#<%= hdnPartPendingOption.ClientID %>').val();

        // Apply saved filter values if they exist
        if (savedCompany || savedPartPending) {
            $('#<%= cmpnyDrp.ClientID %>').val(savedCompany);
            $('#<%= partPendingDrp.ClientID %>').val(savedPartPending);

            // Trigger dropdown change event to apply the filter
            $('.filterDrp').trigger('change');
        }

        // Initialize DataTable (only once)
        var complaintsTable = $('#complaintsTable').DataTable({
            "paging": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "pageLength": 10,
            "language": {
                "paginate": {
                    "previous": "<",
                    "next": ">"
                }
            },
            "dom": '<"search-container2"l><"search-container"f>rtip',
            "lengthMenu": [5, 10, 25, 50, 100],
            "columnDefs": [{
                "targets": [11],
                "orderable": false
            }],
            "drawCallback": function (settings) {
                var api = this.api();
                var filteredRows = api.rows({ filter: 'applied' }).nodes();
                var rowCount = api.rows({ filter: 'applied' }).count();

                if (rowCount === 0) {
                    $("#complaintsTable tbody").hide();
                    $("#noDataDiv").css("display", "block");
                } else {
                    $("#complaintsTable tbody").show();
                    $("#noDataDiv").css("display", "none");

                    $(filteredRows).find('td:nth-child(11)').removeClass('highlight-assigned').css({
                        'color': '',
                        'font-weight': '',
                        'font-size': '',
                        'transition': ''
                    });
                    if (rowCount === 1) {
                        var assignedToCell = $(filteredRows).find('td:nth-child(11)');
                        assignedToCell.css({
                            'color': 'red',
                            'font-weight': '900',        // maximum font weight
                            'font-size': '1.2em',        // slightly larger text
                            'transition': 'all 0.3s ease'  // smooth animation
                        });
                    }
                }
            }
        });

        // Handle filter dropdown change event
        $(".filterDrp").on("change", function () {
            var company = $("#<%= cmpnyDrp.ClientID %>").val();
            var partPending = $("#<%= partPendingDrp.ClientID %>").val();
            
            $.ajax({
                type: "POST",
                url: "Pending_Complains.aspx/drpFilters",
                data: JSON.stringify({ selectedCompany: company, partPendingOption: partPending }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var data = JSON.parse(response.d);

                    // Clear current table data
                    complaintsTable.clear().draw();

                    if (data.length === 0) {
                        $("#complaintsTable tbody").hide();
                        $("#noDataDiv").show();
                    } else {
                        $("#noDataDiv").hide();
                        $("#complaintsTable tbody").show();

                        // Add new rows
                        $.each(data, function (i, item) {
                            var row = "<tr>";
                            row += "<td>" + item.Call_Id + "</td>";
                            row += "<td>" + item.Date + "</td>";
                            row += "<td>" + item.Name + "</td>";
                            row += "<td>" + item.Contact + "</td>";
                            row += "<td>" + item.Address + "</td>";
                            row += "<td>" + item.Product + "</td>";
                            row += "<td>" + item.Company + "</td>";
                            row += "<td>" + item.Warranty + "</td>";
                            row += "<td>" + item.Problem + "</td>";
                            row += "<td>" + item.Assigned_To + "</td>";
                            row += "<td>" + item.Dealer + "</td>";
                            row += "<td>" + item.Reason + "</td>";
                            row += "<td>" + item.PartPending + "</td>";
                            row += "<td class='btn-group'>" +
                                "<a href='javascript:void(0);' class='delete-btn' onclick='cancelComplaint(\"" + item.Call_Id + "\")' title='Cancel Complaint'>X</a> " +
                                "<a href='javascript:void(0);' class='link-btn' onclick='openUpdatePopup(\"" + item.Call_Id + "\")'>" +
                                   "<img src='imgs/updatecallid.png' alt='Update' width='25px' height='25px' />" +
                                   "</a></td>";
                            row += "</tr>";

                            complaintsTable.row.add($(row)).draw();
                        });
                    }
                },
                error: function (err) {
                    console.log("Error:", err);
                }
            });
        });
    });

    // Function to open the popup
    function openPopup() {
        document.getElementById('popupContainer').style.display = 'flex';
        $('#<%= HiddenFieldPopup.ClientID %>').val("true"); // Store state before postback
    }

    // Function to close the popup
    function closePopup() {
        document.getElementById('popupContainer').style.display = 'none';
        $('#<%= HiddenFieldPopup.ClientID %>').val("false"); // Reset state
    }

    function cancelComplaint(callId) {
        document.getElementById("<%= TextBox1.ClientID %>").value = callId;
        document.getElementById("<%= HiddenField1.ClientID %>").value = callId;
        document.getElementById("<%= TextBox13.ClientID %>").value = "";
        document.getElementById("cancelModal").style.display = "block";
    }

    function closeCancelModal() {
        document.getElementById("cancelModal").style.display = "none";
    }

    function openUpdatePopup(callId) {
        document.getElementById('<%= TextBox8.ClientID %>').value = callId;
        document.getElementById('<%= HiddenCallId.ClientID %>').value = callId;

        // Store current filter values in hidden fields before postback
        document.getElementById('<%= hdnSelectedCompany.ClientID %>').value = document.getElementById('<%= cmpnyDrp.ClientID %>').value;
        document.getElementById('<%= hdnPartPendingOption.ClientID %>').value = document.getElementById('<%= partPendingDrp.ClientID %>').value;

        openPopup(); // Your existing function to show popup
    }
    </script>


</asp:Content>
