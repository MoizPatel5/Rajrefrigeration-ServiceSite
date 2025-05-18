<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AAA.aspx.cs" Inherits="Demo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="AAA.css" />
    <link rel="stylesheet" href="gridviewstyle.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">

            <div class="col-md-3 sidebar">
                <h3>Admin Panel</h3>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <!-- New Register Dropdown -->
                <div class="dropdown">
                    New Register
                <div class="dropdown-content">
                    <asp:Button ID="Button1" CssClass="button" runat="server" Text="Add New Worker" OnClick="div1_Click" />
                    <asp:Button ID="Button2" CssClass="button" runat="server" Text="Add New Employee" OnClick="div2_Click" />
                    <asp:Button ID="Button3" CssClass="button" runat="server" Text="Add New User" OnClick="div3_Click" />
                </div>
                </div>

                <!-- Complains Dropdown -->
                <div class="dropdown">
                    Complaints
                <div class="dropdown-content">
                    <asp:Button ID="Button4" CssClass="button" runat="server" Text="Edit All Complaints" OnClick="div4_Click" />
                    <asp:Button ID="Button8" CssClass="button" runat="server" Text="Edit Work Done" OnClick="div8_Click" />
                    <asp:Button ID="Button20" CssClass="button" runat="server" Text="Delete Complaints" OnClick="Button20_Click" />
                </div>
                </div>
                <!-- Product/Company Dropdown -->
                <div class="dropdown">
                    Product/Company
                <div class="dropdown-content">
                    <asp:Button ID="Button9" CssClass="button" runat="server" Text="See All Products" OnClick="div9_Click" />
                    <asp:Button ID="Button10" CssClass="button" runat="server" Text="See All Companies" OnClick="div10_Click" />
                    <asp:Button ID="Button11" CssClass="button" runat="server" Text="Add New Product" OnClick="div11_Click" />
                    <asp:Button ID="Button12" CssClass="button" runat="server" Text="Add New Company" OnClick="div12_Click" />
                </div>
                </div>
                <div class="dropdown">
                    Stock
                <div class="dropdown-content">
                    <asp:Button ID="Button21" CssClass="button" runat="server" Text="Total Stock" OnClick="div14_Click" />
                    <asp:Button ID="Button22" CssClass="button" runat="server" Text="History" OnClick="div15_Click" />
                </div>
                </div>
                <asp:Button ID="Button13" CssClass="dropdown" runat="server" Text="See Login Details" OnClick="div13_Click" />
            </div>

            <div class="col-md-9 main-content">
                <div class="header">
                    <h1 class="cmpnyname company-name">Raj Refrigeration</h1>
                    <asp:Button ID="Button19" runat="server" Text="Log Out" CssClass="logout-button" OnClick="Button19_Click" />
                </div>

                <div class="worker-form-container" id="div1" runat="server">
                    <h1 class="header-text">Add New Worker</h1>

                    <div class="form-group">
                        <label for="TextBox1">Name</label><asp:Label ID="Label3" runat="server" Text="" Visible="false" ForeColor="Green" Style="float: right"></asp:Label>
                        <asp:TextBox ID="TextBox1" runat="server" placeholder="Enter worker's name"></asp:TextBox>
                        <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                    </div>

                    <div class="form-group">
                        <label for="TextBox2">WhatsApp Number</label>
                        <asp:TextBox ID="TextBox2" runat="server" placeholder="Enter WhatsApp number"></asp:TextBox>
                        <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                    </div>
                    <asp:Button ID="Button14" runat="server" class="btn-submit" Text="Add Worker" OnClick="Button14_Click" />
                </div>
                <div class="worker-form-container" id="div2" runat="server">
                    <h1 class="header-text">Add New Employee</h1>

                    <div class="form-group">
                        <label for="TextBox3">Name</label><asp:Label ID="Label6" runat="server" Text="" Visible="false" ForeColor="Green" Style="float: right"></asp:Label>
                        <asp:TextBox ID="TextBox3" runat="server" placeholder="Enter UserName"></asp:TextBox>
                        <asp:Label ID="Label4" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                    </div>

                    <div class="form-group">
                        <label for="TextBox4">Password</label>
                        <asp:TextBox ID="TextBox4" runat="server" placeholder="Enter Password"></asp:TextBox>
                        <asp:Label ID="Label5" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                    </div>

                    <asp:Button ID="Button15" runat="server" class="btn-submit" Text="Add Employee" OnClick="Button15_Click" />
                </div>
                <div class="worker-form-container" id="div3" runat="server">
                    <h1 class="header-text">Add New User</h1>

                    <div class="form-group">
                        <label for="TextBox3">Name</label><asp:Label ID="Label9" runat="server" Text="" Visible="false" ForeColor="Green" Style="float: right"></asp:Label>
                        <asp:TextBox ID="TextBox5" runat="server" placeholder="Enter User Name"></asp:TextBox>
                        <asp:Label ID="Label7" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                    </div>

                    <div class="form-group">
                        <label for="TextBox4">Password</label>
                        <asp:TextBox ID="TextBox6" runat="server" placeholder="Enter Password"></asp:TextBox>
                        <asp:Label ID="Label8" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                    </div>

                    <div class="form-group">
                        <label for="TextBox3">Dealer</label>
                        <asp:DropDownList ID="DropDownList10" runat="server" CssClass="drpdealer" >
                            <asp:ListItem Value="">Select Dealer</asp:ListItem>
                            <asp:ListItem >Motabhai</asp:ListItem>
                            <asp:ListItem >Raj Ref</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="Label21" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                    </div>

                    <asp:Button ID="Button16" runat="server" class="btn-submit" Text="Add User" OnClick="Button16_Click" />
                </div>
                <div id="div4" runat="server" class="worker-form-container1">
                    <center><h1 class="header-text">All Complaints</h1></center>
                    <div class="search-container">
                        Search By -
                        <asp:DropDownList ID="DropDownList8" runat="server" OnSelectedIndexChanged="DropDownList8_SelectedIndexChanged" AutoPostBack="true" CssClass="search-dropdown">
                            <asp:ListItem Value="1">Call_Id</asp:ListItem>
                            <asp:ListItem Value="2">Date</asp:ListItem>
                            <asp:ListItem Value="3">Name</asp:ListItem>
                            <asp:ListItem Value="4">Contact</asp:ListItem>
                            <asp:ListItem Value="5">Address</asp:ListItem>
                            <asp:ListItem Value="6">Product</asp:ListItem>
                            <asp:ListItem Value="7">Company</asp:ListItem>
                            <asp:ListItem Value="8">Warranty</asp:ListItem>
                            <asp:ListItem Value="9">Problem</asp:ListItem>
                            <asp:ListItem Value="0">Assigned_To</asp:ListItem>
                            <asp:ListItem Value="11">Status</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="TextBox15" runat="server" CssClass="search-input" placeholder="Search..."></asp:TextBox>
                    </div>
                    <script type="text/javascript">
                        document.getElementById('<%= TextBox15.ClientID %>').addEventListener('input', function () {
                            // Trigger a partial postback for the UpdatePanel
                            __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                        });
</script>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="gridview" AllowPaging="true" OnPageIndexChanging="gridviewpagechanging">
                                <Columns>
                                    <asp:BoundField DataField="Call_Id" HeaderText="Call_Id" SortExpression="Call_Id" />
                                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="Contact" HeaderText="Contact" SortExpression="Contact" />
                                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                                    <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" />
                                    <asp:BoundField DataField="Company" HeaderText="Company" SortExpression="Company" />
                                    <asp:BoundField DataField="Warranty" HeaderText="Warranty" SortExpression="Warranty" />
                                    <asp:BoundField DataField="Problem" HeaderText="Problem" SortExpression="Problem" />
                                    <asp:BoundField DataField="Assigned_To" HeaderText="Assigned_To" SortExpression="Assigned_To" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                </Columns>
                            </asp:GridView>
                            <div id="noDataDiv" runat="server" visible="false">
                                <br />
                                <br />
                                <br />
                                <br />
                                <asp:Image ID="NoDataImage" runat="server" ImageUrl="~/imgs/nodataimg.png" AlternateText="No Orders Found" CssClass="no-data-image" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="update-container">
                        <h3>
                            <center>Update Complaint</center>
                        </h3>
                        <asp:Label ID="Label15" runat="server" Text="" Visible="false" CssClass="message-label"></asp:Label>
                        <div class="form-group">
                            <label for="TextBox11">Enter Call ID:</label>
                            <asp:TextBox ID="TextBox11" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="DropDownList1">Select Update Term:</label>
                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem>Name</asp:ListItem>
                                <asp:ListItem>Date</asp:ListItem>
                                <asp:ListItem>Contact</asp:ListItem>
                                <asp:ListItem>Address</asp:ListItem>
                                <asp:ListItem>Product</asp:ListItem>
                                <asp:ListItem>Company</asp:ListItem>
                                <asp:ListItem>Warranty</asp:ListItem>
                                <asp:ListItem>Problem</asp:ListItem>
                                <asp:ListItem>Assigned_To</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="TextBox12">Enter New Value:</label>
                            <asp:TextBox ID="TextBox12" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="Products" DataValueField="Products" Visible="false"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Products] FROM [Products]"></asp:SqlDataSource>
                            <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-control" DataSourceID="SqlDataSource12" DataTextField="Name" DataValueField="Name" Visible="false"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource12" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name] FROM [Company]"></asp:SqlDataSource>
                            <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-control" Visible="false">
                                <asp:ListItem>In Warranty</asp:ListItem>
                                <asp:ListItem>Out Warranty</asp:ListItem>
                            </asp:DropDownList>
                            <asp:DropDownList ID="DropDownList5" runat="server" CssClass="form-control" DataSourceID="SqlDataSource13" DataTextField="Username" DataValueField="Username" Visible="false"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource13" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Username] FROM [Worker]"></asp:SqlDataSource>
                            <label for="TextBox12">Password:</label>
                            <asp:TextBox ID="TextBox20" runat="server" CssClass="form-control" placeholder="Enter password only if you need to delete a complaint"></asp:TextBox>
                        </div>
                        <div class="button-group">
                            <asp:Button ID="Button24" runat="server" Text="Update" CssClass="btn-submit" OnClick="Button24_Click" />
                            <asp:Button ID="Button25" runat="server" Text="Delete" CssClass="btn-submit"
                                OnClick="Button25_Click" />
                        </div>
                    </div>
                </div>
                <div class="worker-form-container1" id="div8" runat="server">
                    <center><h1 class="header-text">Work Done</h1></center>
                    <div class="search-container">
                        Search By -
                        <asp:DropDownList ID="DropDownList9" runat="server" OnSelectedIndexChanged="DropDownList9_SelectedIndexChanged" AutoPostBack="true" CssClass="search-dropdown">
                            <asp:ListItem Value="1">Call_Id</asp:ListItem>
                            <asp:ListItem Value="2">Date</asp:ListItem>
                            <asp:ListItem Value="3">Name</asp:ListItem>
                            <asp:ListItem Value="4">Contact</asp:ListItem>
                            <asp:ListItem Value="5">Address</asp:ListItem>
                            <asp:ListItem Value="6">Product</asp:ListItem>
                            <asp:ListItem Value="7">Company</asp:ListItem>
                            <asp:ListItem Value="8">Warranty</asp:ListItem>
                            <asp:ListItem Value="9">Problem</asp:ListItem>
                            <asp:ListItem Value="0">Assigned_To</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="TextBox16" runat="server" CssClass="search-input" placeholder="Search..."></asp:TextBox>
                    </div>
                    <script type="text/javascript">
                        document.getElementById('<%= TextBox16.ClientID %>').addEventListener('input', function () {
                            // Trigger a partial postback for the UpdatePanel
                            __doPostBack('<%= UpdatePanel2.ClientID %>', '');
                        });
            </script>
                    <br />
                    <br />
                    <br />
                    <div class="container2" style="overflow: auto;">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="GridView2" runat="server" CssClass="gridview" AutoGenerateColumns="False" AllowPaging="true" OnPageIndexChanging="gridviewview2pagechanging">
                                    <Columns>
                                        <asp:BoundField DataField="Call_id" HeaderText="Call_id" SortExpression="Call_id" />
                                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                                        <asp:BoundField DataField="CC_Date" HeaderText="CC_Date" SortExpression="CC_Date" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                        <asp:BoundField DataField="Contact" HeaderText="Contact" SortExpression="Contact" />
                                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                                        <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" />
                                        <asp:BoundField DataField="Company" HeaderText="Company" SortExpression="Company" />
                                        <asp:BoundField DataField="Warranty" HeaderText="Warranty" SortExpression="Warranty" />
                                        <asp:BoundField DataField="Problem" HeaderText="Problem" SortExpression="Problem" />
                                        <asp:BoundField DataField="WorkDoneBy" HeaderText="WorkDoneBy" SortExpression="WorkDoneBy" />
                                        <asp:BoundField DataField="Details" HeaderText="Details" SortExpression="Details" />
                                        <asp:BoundField DataField="Charges" HeaderText="Charges" SortExpression="Charges" />
                                        <asp:BoundField DataField="ToPay" HeaderText="ToPay" SortExpression="ToPay" />
                                        <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" SortExpression="ItemCode" />
                                        <asp:BoundField DataField="Def_Return" HeaderText="Def_Return" SortExpression="Def_Return" />
                                    </Columns>
                                </asp:GridView>
                                <div id="Div5" runat="server" visible="false">
                                    <br />
                                    <br />
                                    <br />
                                    <br />
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/imgs/nodataimg.png" AlternateText="No Orders Found" CssClass="no-data-image" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="update-container">
                        <h3>
                            <center>Update Complaint</center>
                        </h3>
                        <asp:Label ID="Label16" runat="server" Text="" Visible="false" CssClass="message-label"></asp:Label>
                        <div class="form-group">
                            <label for="TextBox11">Enter Call ID:</label>
                            <asp:TextBox ID="TextBox13" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="DropDownList1">Select Update Term:</label>
                            <asp:DropDownList ID="DropDownList6" runat="server" CssClass="form-control" OnSelectedIndexChanged="DropDownList6_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem>Charges</asp:ListItem>
                                <asp:ListItem>ToPay</asp:ListItem>
                                <asp:ListItem>ItemCode</asp:ListItem>
                                <asp:ListItem>Def_Return</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="TextBox12">Enter New Value:</label>
                            <asp:TextBox ID="TextBox14" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                            <asp:DropDownList ID="DropDownList7" runat="server" CssClass="form-control" Visible="false">
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="button-group">
                            <asp:Button ID="Button5" runat="server" Text="Update" CssClass="btn-submit" OnClick="Button5_Click" />
                        </div>
                    </div>
                </div>
                <div class="worker-form-container" id="div9" runat="server">
                    <center><h1 class="header-text">All Products</h1></center>
                    <asp:GridView ID="GridView6" runat="server" CssClass="gridview" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource6">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                            <asp:BoundField DataField="Products" HeaderText="Products" SortExpression="Products" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Products] WHERE [Id] = @original_Id AND (([Products] = @original_Products) OR ([Products] IS NULL AND @original_Products IS NULL))" InsertCommand="INSERT INTO [Products] ([Products]) VALUES (@Products)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Products]" UpdateCommand="UPDATE [Products] SET [Products] = @Products WHERE [Id] = @original_Id AND (([Products] = @original_Products) OR ([Products] IS NULL AND @original_Products IS NULL))">
                        <DeleteParameters>
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Products" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Products" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Products" Type="String" />
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Products" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="worker-form-container" id="div10" runat="server">
                    <center><h1 class="header-text">All Companies</h1></center>
                    <asp:GridView ID="GridView7" runat="server" CssClass="gridview" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource7">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Company] WHERE [Id] = @original_Id AND (([Name] = @original_Name) OR ([Name] IS NULL AND @original_Name IS NULL))" InsertCommand="INSERT INTO [Company] ([Name]) VALUES (@Name)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Company]" UpdateCommand="UPDATE [Company] SET [Name] = @Name WHERE [Id] = @original_Id AND (([Name] = @original_Name) OR ([Name] IS NULL AND @original_Name IS NULL))">
                        <DeleteParameters>
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Name" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Name" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Name" Type="String" />
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Name" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="worker-form-container" id="div11" runat="server">
                    <h1 class="header-text">Add New Product</h1>
                    <div class="form-group">
                        <label for="TextBox1">Product Name</label><asp:Label ID="Label11" runat="server" Text="" Visible="false" ForeColor="Green" Style="float: right"></asp:Label>
                        <asp:TextBox ID="TextBox7" runat="server" placeholder="Enter product name"></asp:TextBox>
                        <asp:Label ID="Label10" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label>
                    </div>
                    <asp:Button ID="Button17" runat="server" class="btn-submit" Text="Add Product" OnClick="Button17_Click" />
                </div>
                <div class="worker-form-container" id="div12" runat="server">
                    <h1 class="header-text">Add New Company</h1>
                    <div class="form-group">
                        <label for="TextBox1">Company Name</label><asp:Label ID="Label13" runat="server" Text="" Visible="false" ForeColor="Green" Style="float: right"></asp:Label>
                        <asp:TextBox ID="TextBox8" runat="server" placeholder="Enter company name"></asp:TextBox>
                        <asp:Label ID="Label12" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label>
                    </div>
                    <asp:Button ID="Button18" runat="server" class="btn-submit" Text="Add Company" OnClick="Button18_Click" />
                </div>
                <div class="worker-form-container" id="div13" runat="server">
                    <center><h1 class="header-text">Employee/User</h1></center>
                    <asp:GridView ID="GridView8" runat="server" CssClass="gridview" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource8">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                            <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
                            <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Master_login] WHERE [Id] = @original_Id AND (([Username] = @original_Username) OR ([Username] IS NULL AND @original_Username IS NULL)) AND (([Password] = @original_Password) OR ([Password] IS NULL AND @original_Password IS NULL)) AND (([Role] = @original_Role) OR ([Role] IS NULL AND @original_Role IS NULL))" InsertCommand="INSERT INTO [Master_login] ([Username], [Password], [Role]) VALUES (@Username, @Password, @Role)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Master_login]" UpdateCommand="UPDATE [Master_login] SET [Username] = @Username, [Password] = @Password, [Role] = @Role WHERE [Id] = @original_Id AND (([Username] = @original_Username) OR ([Username] IS NULL AND @original_Username IS NULL)) AND (([Password] = @original_Password) OR ([Password] IS NULL AND @original_Password IS NULL)) AND (([Role] = @original_Role) OR ([Role] IS NULL AND @original_Role IS NULL))">
                        <DeleteParameters>
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Username" Type="String" />
                            <asp:Parameter Name="original_Password" Type="String" />
                            <asp:Parameter Name="original_Role" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Username" Type="String" />
                            <asp:Parameter Name="Password" Type="String" />
                            <asp:Parameter Name="Role" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Username" Type="String" />
                            <asp:Parameter Name="Password" Type="String" />
                            <asp:Parameter Name="Role" Type="String" />
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Username" Type="String" />
                            <asp:Parameter Name="original_Password" Type="String" />
                            <asp:Parameter Name="original_Role" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                    <br />
                    <center><h1 class="header-text">User & Dealer</h1></center>
                    <asp:GridView ID="GridView3" runat="server" CssClass="gridview" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource2">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                            <asp:BoundField DataField="Dealer" HeaderText="Dealer" SortExpression="Dealer" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Users] WHERE [Id] = @original_Id AND (([Username] = @original_Username) OR ([Username] IS NULL AND @original_Username IS NULL)) AND (([Dealer] = @original_Dealer) OR ([Dealer] IS NULL AND @original_Dealer IS NULL))" InsertCommand="INSERT INTO [Users] ([Username], [Dealer]) VALUES (@Username, @Dealer)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Users]" UpdateCommand="UPDATE [Users] SET [Username] = @Username, [Dealer] = @Dealer WHERE [Id] = @original_Id AND (([Username] = @original_Username) OR ([Username] IS NULL AND @original_Username IS NULL)) AND (([Dealer] = @original_Dealer) OR ([Dealer] IS NULL AND @original_Dealer IS NULL))">
                        <DeleteParameters>
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Username" Type="String" />
                            <asp:Parameter Name="original_Dealer" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Username" Type="String" />
                            <asp:Parameter Name="Dealer" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Username" Type="String" />
                            <asp:Parameter Name="Dealer" Type="String" />
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Username" Type="String" />
                            <asp:Parameter Name="original_Dealer" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                    <br />
                    <center><h1 class="header-text">Worker</h1></center>
                    <asp:GridView ID="GridView9" runat="server" CssClass="gridview" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource9">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                            <asp:BoundField DataField="Number" HeaderText="Number" SortExpression="Number" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource9" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Worker] WHERE [Id] = @original_Id AND (([Username] = @original_Username) OR ([Username] IS NULL AND @original_Username IS NULL)) AND (([Number] = @original_Number) OR ([Number] IS NULL AND @original_Number IS NULL))" InsertCommand="INSERT INTO [Worker] ([Username], [Number]) VALUES (@Username, @Number)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Worker]" UpdateCommand="UPDATE [Worker] SET [Username] = @Username, [Number] = @Number WHERE [Id] = @original_Id AND (([Username] = @original_Username) OR ([Username] IS NULL AND @original_Username IS NULL)) AND (([Number] = @original_Number) OR ([Number] IS NULL AND @original_Number IS NULL))">
                        <DeleteParameters>
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Username" Type="String" />
                            <asp:Parameter Name="original_Number" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Username" Type="String" />
                            <asp:Parameter Name="Number" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Username" Type="String" />
                            <asp:Parameter Name="Number" Type="String" />
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_Username" Type="String" />
                            <asp:Parameter Name="original_Number" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="worker-form-container1" id="div14" runat="server">
                    <center><h1 class="header-text">Total Stock</h1></center>
                    <asp:GridView ID="GridView10" runat="server" CssClass="gridview" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource10">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                            <asp:BoundField DataField="BillNo" HeaderText="BillNo" SortExpression="BillNo" />
                            <asp:BoundField DataField="BillDate" HeaderText="BillDate" SortExpression="BillDate" />
                            <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" SortExpression="ItemCode" />
                            <asp:BoundField DataField="ItemDisc" HeaderText="ItemDisc" SortExpression="ItemDisc" />
                            <asp:BoundField DataField="Company" HeaderText="Company" SortExpression="Company" />
                            <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource10" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Stock] WHERE [Id] = @original_Id AND (([BillNo] = @original_BillNo) OR ([BillNo] IS NULL AND @original_BillNo IS NULL)) AND (([BillDate] = @original_BillDate) OR ([BillDate] IS NULL AND @original_BillDate IS NULL)) AND (([ItemCode] = @original_ItemCode) OR ([ItemCode] IS NULL AND @original_ItemCode IS NULL)) AND (([ItemDisc] = @original_ItemDisc) OR ([ItemDisc] IS NULL AND @original_ItemDisc IS NULL)) AND (([Company] = @original_Company) OR ([Company] IS NULL AND @original_Company IS NULL)) AND (([Rate] = @original_Rate) OR ([Rate] IS NULL AND @original_Rate IS NULL))" InsertCommand="INSERT INTO [Stock] ([BillNo], [BillDate], [ItemCode], [ItemDisc], [Company], [Rate]) VALUES (@BillNo, @BillDate, @ItemCode, @ItemDisc, @Company, @Rate)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Stock]" UpdateCommand="UPDATE [Stock] SET [BillNo] = @BillNo, [BillDate] = @BillDate, [ItemCode] = @ItemCode, [ItemDisc] = @ItemDisc, [Company] = @Company, [Rate] = @Rate WHERE [Id] = @original_Id AND (([BillNo] = @original_BillNo) OR ([BillNo] IS NULL AND @original_BillNo IS NULL)) AND (([BillDate] = @original_BillDate) OR ([BillDate] IS NULL AND @original_BillDate IS NULL)) AND (([ItemCode] = @original_ItemCode) OR ([ItemCode] IS NULL AND @original_ItemCode IS NULL)) AND (([ItemDisc] = @original_ItemDisc) OR ([ItemDisc] IS NULL AND @original_ItemDisc IS NULL)) AND (([Company] = @original_Company) OR ([Company] IS NULL AND @original_Company IS NULL)) AND (([Rate] = @original_Rate) OR ([Rate] IS NULL AND @original_Rate IS NULL))">
                        <DeleteParameters>
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_BillNo" Type="String" />
                            <asp:Parameter Name="original_BillDate" Type="String" />
                            <asp:Parameter Name="original_ItemCode" Type="String" />
                            <asp:Parameter Name="original_ItemDisc" Type="String" />
                            <asp:Parameter Name="original_Company" Type="String" />
                            <asp:Parameter Name="original_Rate" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="BillNo" Type="String" />
                            <asp:Parameter Name="BillDate" Type="String" />
                            <asp:Parameter Name="ItemCode" Type="String" />
                            <asp:Parameter Name="ItemDisc" Type="String" />
                            <asp:Parameter Name="Company" Type="String" />
                            <asp:Parameter Name="Rate" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="BillNo" Type="String" />
                            <asp:Parameter Name="BillDate" Type="String" />
                            <asp:Parameter Name="ItemCode" Type="String" />
                            <asp:Parameter Name="ItemDisc" Type="String" />
                            <asp:Parameter Name="Company" Type="String" />
                            <asp:Parameter Name="Rate" Type="String" />
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_BillNo" Type="String" />
                            <asp:Parameter Name="original_BillDate" Type="String" />
                            <asp:Parameter Name="original_ItemCode" Type="String" />
                            <asp:Parameter Name="original_ItemDisc" Type="String" />
                            <asp:Parameter Name="original_Company" Type="String" />
                            <asp:Parameter Name="original_Rate" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="worker-form-container1" id="div15" runat="server">
                    <center><h1 class="header-text">Stock History</h1></center>
                    <div class="container2" style="overflow: auto">
                        <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="GridView11" CssClass="gridview" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource11">
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                                        <asp:BoundField DataField="BillNo" HeaderText="BillNo" SortExpression="BillNo" />
                                        <asp:BoundField DataField="BillDate" HeaderText="BillDate" SortExpression="BillDate" />
                                        <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" SortExpression="ItemCode" />
                                        <asp:BoundField DataField="ItemDisc" HeaderText="ItemDisc" SortExpression="ItemDisc" />
                                        <asp:BoundField DataField="Company" HeaderText="Company" SortExpression="Company" />
                                        <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" />
                                        <asp:BoundField DataField="TransactionType" HeaderText="TransactionType" SortExpression="TransactionType" />
                                        <asp:BoundField DataField="TransactionDate" HeaderText="TransactionDate" SortExpression="TransactionDate" />
                                        <asp:BoundField DataField="Call_Id" HeaderText="Call_Id" SortExpression="Call_Id" />
                                        <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource11" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Stock_History] WHERE [Id] = @original_Id AND (([BillNo] = @original_BillNo) OR ([BillNo] IS NULL AND @original_BillNo IS NULL)) AND (([BillDate] = @original_BillDate) OR ([BillDate] IS NULL AND @original_BillDate IS NULL)) AND (([ItemCode] = @original_ItemCode) OR ([ItemCode] IS NULL AND @original_ItemCode IS NULL)) AND (([ItemDisc] = @original_ItemDisc) OR ([ItemDisc] IS NULL AND @original_ItemDisc IS NULL)) AND (([Company] = @original_Company) OR ([Company] IS NULL AND @original_Company IS NULL)) AND (([Rate] = @original_Rate) OR ([Rate] IS NULL AND @original_Rate IS NULL)) AND (([TransactionType] = @original_TransactionType) OR ([TransactionType] IS NULL AND @original_TransactionType IS NULL)) AND (([TransactionDate] = @original_TransactionDate) OR ([TransactionDate] IS NULL AND @original_TransactionDate IS NULL)) AND (([Call_Id] = @original_Call_Id) OR ([Call_Id] IS NULL AND @original_Call_Id IS NULL)) AND (([Reason] = @original_Reason) OR ([Reason] IS NULL AND @original_Reason IS NULL))" InsertCommand="INSERT INTO [Stock_History] ([BillNo], [BillDate], [ItemCode], [ItemDisc], [Company], [Rate], [TransactionType], [TransactionDate], [Call_Id], [Reason]) VALUES (@BillNo, @BillDate, @ItemCode, @ItemDisc, @Company, @Rate, @TransactionType, @TransactionDate, @Call_Id, @Reason)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Stock_History]" UpdateCommand="UPDATE [Stock_History] SET [BillNo] = @BillNo, [BillDate] = @BillDate, [ItemCode] = @ItemCode, [ItemDisc] = @ItemDisc, [Company] = @Company, [Rate] = @Rate, [TransactionType] = @TransactionType, [TransactionDate] = @TransactionDate, [Call_Id] = @Call_Id, [Reason] = @Reason WHERE [Id] = @original_Id AND (([BillNo] = @original_BillNo) OR ([BillNo] IS NULL AND @original_BillNo IS NULL)) AND (([BillDate] = @original_BillDate) OR ([BillDate] IS NULL AND @original_BillDate IS NULL)) AND (([ItemCode] = @original_ItemCode) OR ([ItemCode] IS NULL AND @original_ItemCode IS NULL)) AND (([ItemDisc] = @original_ItemDisc) OR ([ItemDisc] IS NULL AND @original_ItemDisc IS NULL)) AND (([Company] = @original_Company) OR ([Company] IS NULL AND @original_Company IS NULL)) AND (([Rate] = @original_Rate) OR ([Rate] IS NULL AND @original_Rate IS NULL)) AND (([TransactionType] = @original_TransactionType) OR ([TransactionType] IS NULL AND @original_TransactionType IS NULL)) AND (([TransactionDate] = @original_TransactionDate) OR ([TransactionDate] IS NULL AND @original_TransactionDate IS NULL)) AND (([Call_Id] = @original_Call_Id) OR ([Call_Id] IS NULL AND @original_Call_Id IS NULL)) AND (([Reason] = @original_Reason) OR ([Reason] IS NULL AND @original_Reason IS NULL))">
                        <DeleteParameters>
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_BillNo" Type="String" />
                            <asp:Parameter Name="original_BillDate" Type="String" />
                            <asp:Parameter Name="original_ItemCode" Type="String" />
                            <asp:Parameter Name="original_ItemDisc" Type="String" />
                            <asp:Parameter Name="original_Company" Type="String" />
                            <asp:Parameter Name="original_Rate" Type="String" />
                            <asp:Parameter Name="original_TransactionType" Type="String" />
                            <asp:Parameter Name="original_TransactionDate" Type="String" />
                            <asp:Parameter Name="original_Call_Id" Type="String" />
                            <asp:Parameter Name="original_Reason" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="BillNo" Type="String" />
                            <asp:Parameter Name="BillDate" Type="String" />
                            <asp:Parameter Name="ItemCode" Type="String" />
                            <asp:Parameter Name="ItemDisc" Type="String" />
                            <asp:Parameter Name="Company" Type="String" />
                            <asp:Parameter Name="Rate" Type="String" />
                            <asp:Parameter Name="TransactionType" Type="String" />
                            <asp:Parameter Name="TransactionDate" Type="String" />
                            <asp:Parameter Name="Call_Id" Type="String" />
                            <asp:Parameter Name="Reason" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="BillNo" Type="String" />
                            <asp:Parameter Name="BillDate" Type="String" />
                            <asp:Parameter Name="ItemCode" Type="String" />
                            <asp:Parameter Name="ItemDisc" Type="String" />
                            <asp:Parameter Name="Company" Type="String" />
                            <asp:Parameter Name="Rate" Type="String" />
                            <asp:Parameter Name="TransactionType" Type="String" />
                            <asp:Parameter Name="TransactionDate" Type="String" />
                            <asp:Parameter Name="Call_Id" Type="String" />
                            <asp:Parameter Name="Reason" Type="String" />
                            <asp:Parameter Name="original_Id" Type="Int32" />
                            <asp:Parameter Name="original_BillNo" Type="String" />
                            <asp:Parameter Name="original_BillDate" Type="String" />
                            <asp:Parameter Name="original_ItemCode" Type="String" />
                            <asp:Parameter Name="original_ItemDisc" Type="String" />
                            <asp:Parameter Name="original_Company" Type="String" />
                            <asp:Parameter Name="original_Rate" Type="String" />
                            <asp:Parameter Name="original_TransactionType" Type="String" />
                            <asp:Parameter Name="original_TransactionDate" Type="String" />
                            <asp:Parameter Name="original_Call_Id" Type="String" />
                            <asp:Parameter Name="original_Reason" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="worker-form-container" id="div16" runat="server">
                    <div class="date-submission">
                        <div class="date-container">
                            <h2 class="header-text">Select Dates</h2>
                            <span class="date-label">From:</span>
                            <asp:TextBox ID="TextBox9" runat="server" TextMode="Date" CssClass="date-input"></asp:TextBox>

                            <span class="date-label">To:</span>
                            <asp:TextBox ID="TextBox10" runat="server" TextMode="Date" CssClass="date-input"></asp:TextBox>
                            <span class="date-label">Password:</span>
                            <asp:TextBox ID="TextBox19" runat="server" CssClass="date-input"></asp:TextBox>
                        </div>

                        <asp:Label ID="Label14" runat="server" Visible="false" CssClass="success-message"></asp:Label>
                        <br />
                        <asp:Button ID="Button23" runat="server" Text="Delete" OnClick="Button23_Click" CssClass="btn-submit" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
