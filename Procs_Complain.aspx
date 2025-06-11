<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/EmployeeMasterPage.master" CodeFile="Procs_Complain.aspx.cs" Inherits="Procs_Complain" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Complains in Process</title>
    <link rel="stylesheet" href="Procs_Complain.css" />
    <link rel="stylesheet" href="gridviewstyle.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <asp:HiddenField ID="hfSearchState" runat="server" ClientIDMode="Static" />
        <div style="float: right; cursor: pointer" title="Notifications">
            <asp:LinkButton ID="LinkButton5" runat="server" OnClick="LinkButton3_Click" Visible="true"><img src="imgs/bellicon.PNG" height="35px" width="35px" /></asp:LinkButton>
            <asp:LinkButton ID="LinkButton6" runat="server" OnClick="LinkButton3_Click" Visible="false"><img src="imgs/belliconwith1.PNG" height="35px" width="35px" /></asp:LinkButton>
        </div>
        <center><h1 class="header-text">Complaints in Process</h1></center>
        <br />
        <button id="toggleSearch" style="float: right; display: flex; align-items: center; gap: 5px; padding: 5px 10px; border: 2px solid #4A3F35">
            <img src="imgs/filtercolumn.png" alt="Filter Icon" style="height: 20px; width: 20px;">
            Show Filters
        </button>
        <br />
        <br />
        <div style="overflow: auto">
            <table id="dataTable" class="gridview" style="width: 100%;">
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
                        <th>Actions</th>
                    </tr>
                    <tr id="searchRow" style="display: none;">
                        <th>
                            <input type="text" class="column-search" placeholder="Search Call_Id" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Date" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Time" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Name" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Contact" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Address" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Product" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Company" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Warranty" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Problem" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Assigned_To" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search RegisBy" /></th>
                        <th>
                            <input type="text" class="column-search" placeholder="Search Dealer" /></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <tr style='<%# Convert.ToBoolean(Eval("isRepeated")) ? "background-color:#fff7b3;" : "" %>'>
                                <td><%# Eval("Call_Id") %></td>
                                <td><%# Eval("Date", "{0:yyyy-MM-dd}") %></td>
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
                                <td class="btn-group">
                                    <a href="javascript:void(0);" class="delete-btn"
                                        onclick='cancelComplaint("<%# Eval("Call_Id") %>")' title="Cancel Complaint">X
                                    </a>
                                    <a href="javascript:void(0);" class="link-btn"
                                        onclick='updateComplaint("<%# Eval("Call_Id") %>")'>
                                        <img src='imgs/updatecallid.png' alt='Update' title='Update'>
                                    </a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
        <%-- <asp:Button ID="Button4" runat="server" Text="X" CssClass="delete-btn" title="Delete"
                                        CommandName="Delete" CommandArgument='<%# Eval("Call_Id") %>'
                                        OnCommand="DeleteComplaint"
                                        OnClientClick="return confirm('Are you sure you want to delete this complaint?');" />--%>
        <div id="noDataDiv" style="display: none; text-align: center; margin-top: 20px;">
            <asp:Image ID="NoDataImage" runat="server" ImageUrl="~/imgs/nodataimg.png"
                AlternateText="No Complaints Found" CssClass="no-data-image" />
        </div>

        <div class="container2">
            <div class="flexdiv">
                <asp:Label ID="LabelMessage" runat="server" Text="" Style="float: right" CssClass="message-label"></asp:Label>
                <h1 class="updatebox-text">Re-Assign Complaint</h1>

                <asp:Label ID="Label1" runat="server" Text="Enter Call Id:" CssClass="label-text"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="input-textbox"></asp:TextBox><br />
                <asp:Label ID="Label11" runat="server" Text="Select Employee :" CssClass="label-text"></asp:Label>
                <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSource5" DataTextField="Username" DataValueField="Username" CssClass="input-textbox"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Username] FROM [Worker]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Username] FROM [Worker] WHERE ([Number] = @Number)"></asp:SqlDataSource>
                <asp:Label ID="Label10" runat="server" Text="Label" Visible="false"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label9" runat="server" Text="Complains" Visible="false"></asp:Label>
                <asp:Button ID="btnReAssign" runat="server" Text="Re-Assign" CssClass="btn-submit" OnClick="btnReAssign_Click" />


            </div>
            <%--</div>
         <div class="container2">--%>
            <div class="flexdiv">
                <asp:Label ID="Label3" runat="server" Text="" CssClass="message-label"></asp:Label>
                <h1 class="updatebox-text">Complaints in Pending</h1>

                <asp:Label ID="Label2" runat="server" Text="Enter Call Id:" CssClass="label-text"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" CssClass="input-textbox"></asp:TextBox><br />
                <asp:Label ID="Label20" runat="server" Text="Part Pending :" CssClass="label-text"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="input-textbox">
                    <asp:ListItem>Select Option</asp:ListItem>
                    <asp:ListItem>Yes</asp:ListItem>
                    <asp:ListItem>No</asp:ListItem>
                </asp:DropDownList><br />
                <asp:Label ID="Label4" runat="server" Text="Reason :" CssClass="label-text"></asp:Label>
                <asp:TextBox ID="TextBox4" runat="server" TextMode="MultiLine" CssClass="input-textbox"></asp:TextBox><br />
                <br />
                <asp:Button ID="Button2" runat="server" Text="Pending" CssClass="btn-submit" OnClick="Pending_Click" />
            </div>
            <div class="flexdiv">
                <%-- </div>
         <div class="container2">--%>
                <asp:Label ID="Label7" runat="server" Text="" CssClass="message-label"></asp:Label>
                <h1 class="updatebox-text">Work Done</h1>
                <asp:Label ID="Label5" runat="server" Text="Enter Call Id :" CssClass="label-text"></asp:Label>
                <asp:TextBox ID="TextBox5" runat="server" CssClass="input-textbox"></asp:TextBox><br />
                <asp:Label ID="Label6" runat="server" Text="Details :" CssClass="label-text"></asp:Label>
                <asp:TextBox ID="TextBox6" runat="server" CssClass="input-textbox"></asp:TextBox><br />
                <asp:Label ID="Label8" runat="server" Text="Charges :" CssClass="label-text"></asp:Label>
                <asp:TextBox ID="TextBox7" runat="server" CssClass="input-textbox" TextMode="Number"></asp:TextBox><br />
                <asp:Label ID="Label14" runat="server" Text="To Pay :" CssClass="label-text"></asp:Label>
                <asp:TextBox ID="TextBox10" runat="server" CssClass="input-textbox" TextMode="Number"></asp:TextBox><br />
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:CheckBox ID="CheckBox2" runat="server" CssClass="label-text" Text="Tick if part added " AutoPostBack="true" OnCheckedChanged="CheckBox2_CheckedChanged" /><br />
                        <br />
                        <div runat="server" id="partdiv" visible="false">
                            <asp:Label ID="Label15" runat="server" Text="Part Code :" CssClass="label-text"></asp:Label>
                            <asp:TextBox ID="TextBox11" runat="server" CssClass="input-textbox"></asp:TextBox><br />
                            <asp:Label ID="Label17" runat="server" Text="Charge Taken :" CssClass="label-text"></asp:Label>
                            <asp:TextBox ID="TextBox12" runat="server" CssClass="input-textbox" TextMode="Number"></asp:TextBox><br />
                            <asp:Label ID="Label16" runat="server" Text="Defective return :" CssClass="label-text"></asp:Label>
                            <asp:DropDownList ID="DropDownList5" runat="server" CssClass="input-textbox">
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Button ID="Button5" runat="server" Text="Work Done" CssClass="btn-submit" OnClick="Done_Click" />
            </div>
        </div>
        <div id="overlay" class="overlay" style="display: none;"></div>
        <div id="updatePopup" class="update-container" style="display: none;">
            <asp:Label ID="Label13" runat="server" Text="" Visible="false" Style="float: right;"></asp:Label>
            <asp:Label ID="Label12" runat="server" Text="" Visible="false" class="error-message"></asp:Label>
            <div class="update-content">
                <h2 class="update-title">Update Call ID</h2>
                <div class="form-group">
                    <label for="TextBox13">Enter Old Call ID:</label>
                    <asp:HiddenField ID="HiddenFieldCallId" runat="server" />
                    <asp:TextBox ID="TextBox8" runat="server" CssClass="textbox" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="TextBox14">Enter New Call ID:</label>
                    <asp:TextBox ID="TextBox9" runat="server" CssClass="textbox"></asp:TextBox>
                </div>
                <div class="button-group">
                    <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btn-submit" OnClick="Button1_Click" Width="49%" />
                    <asp:Button ID="Button3" runat="server" Text="Close" CssClass="btn-submit" OnClientClick="hidePopup(); return false;" Width="49%" />
                </div>
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
        <br />
        <!-- UPDATE CALL ID Modal Popup -->
        <div class="popupcontainer" runat="server" id="popupdiv">
            <div id="complaintPopup" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Old Complaints (Pending for 3+ Days)</h4>
                            <asp:Button ID="Button7" runat="server" Text="&#10006;" class="closebtn" OnClick="Button4_Click" />
                        </div>

                        <div class="modal-body">
                            <asp:GridView ID="GridViewPopup" runat="server" CssClass="gridview" AutoGenerateColumns="False" AllowPaging="true" OnPageIndexChanging="gridviewpagechanging2">
                                <Columns>
                                    <asp:BoundField DataField="Call_Id" HeaderText="Call ID" />
                                    <asp:BoundField DataField="Date" HeaderText="Date" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="Problem" HeaderText="Problem" />
                                    <asp:BoundField DataField="Assigned_To" HeaderText="Assigned To" />
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div class="modal-footer">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function openPopup() {
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('updatePopup').style.display = 'block';
        }

        function closePopup() {
            document.getElementById('overlay').style.display = 'none';
            document.getElementById('updatePopup').style.display = 'none';
        }
        $(document).ready(function () {
            var searchRow = $("#searchRow");
            var toggleButton = $("#toggleSearch");

            // Restore filter visibility based on ViewState
            if ($("#hfSearchState").val() === "visible") {
                searchRow.show();
                toggleButton.html('<img src="imgs/filtercolumn.png" height="20px" width="20px">Hide Filters');
            } else {
                searchRow.hide();
                toggleButton.html('<img src="imgs/filtercolumn.png" height="20px" width="20px">Show Filters');
            }

            toggleButton.on("click", function () {
                var isVisible = searchRow.is(":visible");
                searchRow.toggle();

                // Update button text and keep image
                $(this).html(isVisible ?
                    '<img src="imgs/filtercolumn.png" height="20px" width="20px">Show Filters' :
                    '<img src="imgs/filtercolumn.png" height="20px" width="20px">Hide Filters');

                // Store the state in hidden field
                $("#hfSearchState").val(isVisible ? "hidden" : "visible");
            });
            $('#dataTable').DataTable({
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
                "initComplete": function () {
                    // Add individual column search
                    this.api().columns().every(function () {
                        var that = this;
                        $('input', this.header()).on('keyup change', function () {
                            if (that.search() !== this.value) {
                                that.search(this.value).draw();
                            }
                        });
                    });
                },
                "drawCallback": function (settings) {
                    var api = this.api();
                    var filteredRows = api.rows({ filter: 'applied' }).nodes();
                    var rowCount = api.rows({ filter: 'applied' }).count();

                    if (rowCount === 0) {
                        $("#dataTable tbody").hide();
                        $("#noDataDiv").css("display", "block");
                    } else {
                        $("#dataTable tbody").show();
                        $("#noDataDiv").css("display", "none");

                        // Reset previously styled Assigned_To columns
                        $(filteredRows).find('td:nth-child(11)').css({
                            'color': '',
                            'font-weight': '',
                            'font-size': '',          // reset font size to default
                            'transition': ''    
                        });

                        // If only one row is found, style its Assigned_To column
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
        });
        function updateComplaint(callId) {
            event.preventDefault(); // Prevent page refresh
            $("#<%= TextBox8.ClientID %>").val(callId); // Set value in textbox
            $("#<%= HiddenFieldCallId.ClientID %>").val(callId); // Store value for postback
            openPopup();
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
    </script>

</asp:Content>
