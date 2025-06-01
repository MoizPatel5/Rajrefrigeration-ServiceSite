<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/EmployeeMasterPage.master" CodeFile="Work_Done.aspx.cs" Inherits="Work_Done" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Work Done</title>
    <link rel="stylesheet" href="Work_Done.css" />
    <link rel="stylesheet" href="gridviewstyle.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

        <!-- Header Section -->

        <center><h1 class="header-text">Work Done</h1></center>

        <asp:linkbutton runat="server" OnClick="Filter_Click"><img src="imgs/filter.png" width="30px" height="30px" title="Filter" style="height: 30px" /></asp:linkbutton>
        
        <div style="overflow: auto">

            <!-- Main Content Section -->
            <table id="complaintsTable" class="gridview" style="width: 100%">
                <thead>
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
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div id="updateCallIdPopup" class="popup-container">
                <div class="popup-box">
                    <h3>Update Call ID</h3>
                    <asp:Label ID="lblOldCallId" runat="server" Text="Old Call ID:" CssClass="label"></asp:Label>
                    <asp:TextBox ID="txtOldCallId" runat="server" CssClass="textbox" ReadOnly="true"></asp:TextBox>
                    <asp:HiddenField ID="HiddenFieldCallId" runat="server" />
                    <asp:Label ID="lblNewCallId" runat="server" Text="New Call ID:" CssClass="label"></asp:Label>
                    <asp:TextBox ID="txtNewCallId" runat="server" CssClass="textbox"></asp:TextBox>
                    <asp:Label ID="Label2" runat="server" Text="" Visible="false" Style="color: red"></asp:Label>
                    <div class="popup-buttons">
                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-submit" OnClick="btnSave_Click" Width="49%" />
                        <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn-submit" OnClientClick="closePopup()" Width="49%" />
                    </div>
                </div>
            </div>
            <div id="noDataDiv" style="display: none; text-align: center; margin-top: 20px;">
                <asp:Image ID="NoDataImage" runat="server" ImageUrl="~/imgs/nodataimg.png"
                    AlternateText="No Orders Found" CssClass="no-data-image" />
            </div>
            <asp:HiddenField ID="HiddenPopupState" runat="server" />
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            var table = $("#complaintsTable").DataTable({
                "serverSide": true,
                "processing": true,
                "dom": '<"search-container2"l><"search-container"f>rtip',
                "order": [],
                "language": {
                    "paginate": {
                        "previous": "<",
                        "next": ">"
                    }
                },
                "ajax": {
                    "url": "Work_Done.aspx/GetData",
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
                    { "data": "Call_id" },
                    { "data": "Date" },
                    { "data": "CC_Date" },
                    { "data": "Name" },
                    { "data": "Contact" },
                    { "data": "Address" },
                    { "data": "Product" },
                    { "data": "Company" },
                    { "data": "Warranty" },
                    { "data": "Problem" },
                    { "data": "WorkDoneBy" },
                    { "data": "Details" },
                    { "data": "Charges" },
                    { "data": "ToPay" },
                    { "data": "Dealer" },
                    { "data": "ItemCode" },
                    { "data": "Def_Return" },
                    {
                        "data": "Call_id",
                        "render": function (data, type, row) {
                            return "<div class='btn-group'>" +
                                   "<button class='link-btn update-btn' data-id='" + data + "'>" +
                                   "<img src='imgs/updatecallid.png' alt='Update' title='Update'>" +
                                   "</button>" +
                                   "</div>";
                        }

                    }
                ],
                "orderMulti": false,
                "lengthMenu": [5, 10, 25, 50, 100],
                "pageLength": 10,
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
                }
            });

            $(document).on("click", ".update-btn", function (event) {
                event.preventDefault();
                console.log('click happens');
                var callId = $(this).data("id");

                $("#<%= txtOldCallId.ClientID %>").val(callId);
                $("#<%= HiddenFieldCallId.ClientID %>").val(callId);
                openPopup();
            });
            
        });
        function updateComplaint(callId) {
            event.preventDefault();
            $("#<%= txtOldCallId.ClientID %>").val(callId);
            $("#<%= HiddenFieldCallId.ClientID %>").val(callId);
            openPopup();
        }
        function openPopup() {
            var popup = document.getElementById('updateCallIdPopup');
            if (popup) {
                popup.classList.add('show');
            }
        }
        function closePopup() {
            var popupState = document.getElementById('<%= HiddenPopupState.ClientID %>').value = "Close";
            var popup = document.getElementById('updateCallIdPopup');
            if (popup) {
                popup.classList.remove('show');
            }
        }
        window.onload = function () {
            var popupState = document.getElementById('<%= HiddenPopupState.ClientID %>').value;
            if (popupState === "Open") {
                openPopup();
            }
        };
        function openFilterSection() {
            var filterContainer = document.getElementById("filtersection");
            if (filterContainer.style.display === "none" || filterContainer.style.display === "") {
                filterContainer.style.display = "block"; 
            } else {
                filterContainer.style.display = "none"; 
            }
        }

    </script>
</asp:Content>
