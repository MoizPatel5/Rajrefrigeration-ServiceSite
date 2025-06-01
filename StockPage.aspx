<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="StockPage.aspx.cs" Inherits="Default2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="StockPage.css" />
    <link rel="stylesheet" href="gridviewstyle.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">
        <div class="row">
    <div runat="server" class="col-md-3 sidebar">
    <div class="list-group">
        <asp:Button ID="Button1" runat="server" Text="Add Stock" CssClass="list-group-item list-group-item-action" OnClick="Button1_Click" />
        <asp:Button ID="Button2" runat="server" Text="Purchase Return" CssClass="list-group-item list-group-item-action" OnClick="Button2_Click" />
        <asp:Button ID="Button3" runat="server" Text="Sales Return" CssClass="list-group-item list-group-item-action" OnClick="Button3_Click" />
        <asp:Button ID="Button4" runat="server" Text="Total Stock" CssClass="list-group-item list-group-item-action" OnClick="Button4_Click" />
        <asp:Button ID="Button5" runat="server" Text="History" CssClass="list-group-item list-group-item-action" OnClick="Button5_Click" />
    </div>
</div>
    <div class="col-md-9 maincontent">
        <div runat="server" id="div1" class="form-container card mb-3">
            <asp:Label ID="Label1" runat="server" Text="" Visible="false" style="float:right"></asp:Label>
            <center><h1 class="header-text">Enter Purchase</h1></center>
            <div class="form-group">
                <label class="form-label">Bill no:</label>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-input"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Bill Date:</label>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-input" TextMode="Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Item Code:</label>
                <asp:TextBox ID="TextBox3" runat="server" CssClass="form-input"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Item Description:</label>
                <asp:TextBox ID="TextBox4" runat="server" CssClass="form-input"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Company :</label>
                <div class="dropdown-container">
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="dropdown" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name] FROM [Company]"></asp:SqlDataSource>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Rate:</label>
                <asp:TextBox ID="TextBox5" runat="server" CssClass="form-input" TextMode="Number"></asp:TextBox>
            </div>
            <asp:Button ID="Button6" runat="server" Text="Submit" CssClass="btn-submit" OnClick="Button6_Click" />
        </div>

        <div runat="server" id="div2" class="form-container">
             <asp:Label ID="Label2" runat="server" Text="" Visible="false" style="float:right"></asp:Label>
          <center><h1 class="header-text">Enter Purchase Return</h1></center>
            <div class="form-group">
                <label class="form-label">Item Code :</label>
                <asp:TextBox ID="TextBox6" runat="server" CssClass="form-input"></asp:TextBox>
                <label class="form-label">Reason :</label>
                <asp:TextBox ID="TextBox8" runat="server" CssClass="form-input"></asp:TextBox>
            </div>
            <asp:Button ID="Button7" runat="server" Text="Submit" CssClass="btn-submit" OnClick="Button7_Click" />
        </div>

        <div runat="server" id="div3" class="form-container">
             <asp:Label ID="Label3" runat="server" Text="" Visible="false" style="float:right"></asp:Label>
           <center><h1 class="header-text">Enter Sales Return</h1></center>
           <div class="form-group">
                <label class="form-label">Bill no:</label>
                <asp:TextBox ID="TextBox12" runat="server" CssClass="form-input"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Bill Date:</label>
                <asp:TextBox ID="TextBox13" runat="server" CssClass="form-input" TextMode="Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Item Code:</label>
                <asp:TextBox ID="TextBox14" runat="server" CssClass="form-input"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Item Description:</label>
                <asp:TextBox ID="TextBox15" runat="server" CssClass="form-input"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Company :</label>
                <div class="dropdown-container">
                    <asp:DropDownList ID="DropDownList3" runat="server" CssClass="dropdown" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name] FROM [Company]"></asp:SqlDataSource>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Rate:</label>
                <asp:TextBox ID="TextBox16" runat="server" CssClass="form-input" TextMode="Number"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Reason :</label>
                <asp:TextBox ID="TextBox17" runat="server" CssClass="form-input"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Call Id :</label>
                <asp:TextBox ID="TextBox18" runat="server" CssClass="form-input"></asp:TextBox>
            </div>
            <asp:Button ID="Button8" runat="server" Text="Submit" CssClass="btn-submit" OnClick="Button8_Click" />
        </div>

        <div runat="server" id="div4" class="form-container">
           <center><h1 class="header-text">Total Stock</h1></center>
           <div class="search-container">
    <div class="search-header">
      <h2 class="search-title">Search By :</h2>
    </div>
    <div class="search-controls">
      
          <asp:DropDownList ID="searchType" CssClass="dropdown1" runat="server" OnSelectedIndexChanged="searchType_SelectedIndexChanged" AutoPostBack="true">
        <asp:ListItem>Bill no.</asp:ListItem>
        <asp:ListItem>Bill Date</asp:ListItem>
        <asp:ListItem>Item Code</asp:ListItem>
        <asp:ListItem>Item Disc</asp:ListItem>
        <asp:ListItem>Company</asp:ListItem>
        <asp:ListItem>Rate</asp:ListItem>
          </asp:DropDownList>
        <div id="cmpnydiv" runat="server" visible="false">
          <asp:DropDownList ID="company" runat="server" CssClass="dropdown2" DataSourceID="SqlDataSource3" DataTextField="Name" DataValueField="Name"></asp:DropDownList>     
          <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name] FROM [Company]"></asp:SqlDataSource>
        </div>
        <div id="txtbxdiv" runat="server">
        <asp:TextBox ID="TextBox7" class="search-input" runat="server" placeholder="Enter search term..."></asp:TextBox>
        </div>
        <asp:Button ID="Button9" runat="server" Text="Search" class="btn-submit" Width="20%" OnClick="Button9_Click" />
    </div>
  </div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="gridview" DataSourceID="SqlDataSource1" AllowPaging="true" OnPageIndexChanging="gridviewpagechanging">
                <Columns>
                    <asp:BoundField DataField="BillNo" HeaderText="Bill No" SortExpression="BillNo" />
                    <asp:BoundField DataField="BillDate" HeaderText="Bill Date" SortExpression="BillDate" />
                    <asp:BoundField DataField="ItemCode" HeaderText="Item Code" SortExpression="ItemCode" />
                    <asp:BoundField DataField="ItemDisc" HeaderText="Item Disc" SortExpression="ItemDisc" />
                    <asp:BoundField DataField="Company" HeaderText="Company" SortExpression="Company" />
                    <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [BillNo], [BillDate], [ItemCode], [ItemDisc], [Company] , [Rate] FROM [Stock]"></asp:SqlDataSource>
        </div>

        <div runat="server" id="div5" class="form-container">
           <center><h1 class="header-text">History</h1></center>
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"><img src="imgs/filter.png" height="25px" width="25px" title="Filter" /></asp:LinkButton>
            <div class="filtercontainer" id="filtercontainer" runat="server" visible="false">
    <div class="filter">
        <div class="filter-item">
            <asp:CheckBox ID="CheckBox1" runat="server" Text="Bill Date" AutoPostBack="true" CssClass="filter-checkbox" OnCheckedChanged="CheckBox1_CheckedChanged" />
            <div id="divbilldate" runat="server" visible="false" class="date-range">
                <span class="date-label">From</span>
                <asp:TextBox ID="TextBox10" runat="server" TextMode="Date" CssClass="date-input"></asp:TextBox>
                <span class="date-label">To</span>
                <asp:TextBox ID="TextBox11" runat="server" TextMode="Date" CssClass="date-input"></asp:TextBox>
            </div>
        </div>

        <div class="filter-item">
            <asp:CheckBox ID="CheckBox2" runat="server" Text="Transaction Date" AutoPostBack="true" CssClass="filter-checkbox" OnCheckedChanged="CheckBox2_CheckedChanged" />
            <div id="divtdate" runat="server" visible="false" class="date-range">
                <span class="date-label">From</span>
                <asp:TextBox ID="TextBox19" runat="server" TextMode="Date" CssClass="date-input"></asp:TextBox>
                <span class="date-label">To</span>
                <asp:TextBox ID="TextBox20" runat="server" TextMode="Date" CssClass="date-input"></asp:TextBox>
            </div>
        </div>

        <asp:Button ID="Button11" runat="server" Text="Apply Filter" CssClass="btn-submit" OnClick="Button11_Click" />
    </div>
</div>

            <div class="search-container">
    <div class="search-header">
      <h2 class="search-title">Search By :</h2>
    </div>
    <div class="search-controls">
      
          <asp:DropDownList ID="searchType2" CssClass="dropdown1" runat="server" OnSelectedIndexChanged="searchType2_SelectedIndexChanged" AutoPostBack="true">
        <asp:ListItem>Bill no.</asp:ListItem>
        <asp:ListItem>Bill Date</asp:ListItem>
        <asp:ListItem>Item Code</asp:ListItem>
        <asp:ListItem>Item Disc</asp:ListItem>
        <asp:ListItem>Company</asp:ListItem>
        <asp:ListItem>Rate</asp:ListItem>
        <asp:ListItem>Transaction Date</asp:ListItem>
        <asp:ListItem>Call Id</asp:ListItem>
        <asp:ListItem>Reason</asp:ListItem>
        <asp:ListItem>Transaction Type</asp:ListItem>
          </asp:DropDownList>
        <div id="Div6" runat="server" visible="false">
          <asp:DropDownList ID="DropDownList4" CssClass="dropdown2" runat="server" DataSourceID="SqlDataSource3" DataTextField="Name" DataValueField="Name"></asp:DropDownList>     
          <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Name] FROM [Company]"></asp:SqlDataSource>
        </div>
        <div id="Div7" runat="server">
        <asp:TextBox ID="TextBox9" class="search-input" runat="server" placeholder="Enter search term..."></asp:TextBox>
        </div>
        <asp:Button ID="Button10" runat="server" Text="Search" class="search-button" OnClick="Button10_Click" />
    </div>
  </div>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5" CssClass="gridview" OnRowDataBound="GridView2_RowDataBound" AllowPaging="true" OnPageIndexChanging="gridviewpagechanging1">
                <Columns>
                    <asp:BoundField DataField="BillNo" HeaderText="Bill No" SortExpression="BillNo" />
                    <asp:BoundField DataField="BillDate" HeaderText="Bill Date" SortExpression="BillDate" />
                    <asp:BoundField DataField="ItemCode" HeaderText="Item Code" SortExpression="ItemCode" />
                    <asp:BoundField DataField="ItemDisc" HeaderText="Item Disc" SortExpression="ItemDisc" />
                    <asp:BoundField DataField="Company" HeaderText="Company" SortExpression="Company" />
                    <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" />
                    <asp:BoundField DataField="Chargetkn" HeaderText="Charge Taken" SortExpression="Chargetkn" />
                    <asp:BoundField DataField="TransactionDate" HeaderText="Transaction Date" SortExpression="TransactionDate" />
                    <asp:BoundField DataField="Call_Id" HeaderText="Call Id" SortExpression="Call_Id" />
                    <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />
                    <asp:BoundField DataField="TransactionType" HeaderText="Transaction Type" SortExpression="TransactionType" />

                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [BillNo], [BillDate], [ItemCode], [ItemDisc], [Company], [Rate], [Chargetkn] ,[TransactionType], [TransactionDate], [Call_Id], [Reason] FROM [Stock_History]"></asp:SqlDataSource>
        </div>
        <br /><br /><br /><br />
    </div>
            </div>
</div>
</asp:Content>