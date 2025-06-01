<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMasterPage.master" AutoEventWireup="true" CodeFile="WorkGraph.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="WorkGraph.css" />
    <link rel="stylesheet" href="gridviewstyle.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center><h2 class="header-text">Worker Report</h2></center>
    
    <!-- Filters -->
    <div class="filter-field">
        <asp:TextBox ID="txtStartDate" runat="server" Placeholder="Start Date" TextMode="Date" CssClass="date-picker" />
        <asp:TextBox ID="txtEndDate" runat="server" Placeholder="End Date" TextMode="Date" CssClass="date-picker" />
        
        <asp:DropDownList ID="ddlWarrantyStatus" runat="server" CssClass="warranty-dropdown">
            <asp:ListItem Value="" Text="All Complaints" />
            <asp:ListItem Value="In Warranty" Text="In Warranty" />
            <asp:ListItem Value="Out Warranty" Text="Out Warranty" />
        </asp:DropDownList>
        
        <asp:Button ID="btnFilter" runat="server" Text="Generate" CssClass="filter-button" OnClick="btnFilter_Click" />
    </div>

    <!-- Chart -->
    <div class="chart-container">
        <asp:Chart ID="Chart1" runat="server" Width="1300px" Height="600px">
            <Series>
                <asp:Series Name="Series1" XValueMember="WorkDoneBy" YValueMembers="TotalComplains" ChartType="Bar" YValuesPerPoint="4"></asp:Series>
            </Series>
            
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisX Title="Workers" Interval="1" LabelStyle-Angle="0" IsLabelAutoFit="False" IsReversed="True">
					<MajorGrid Enabled="False" />
        			</AxisX>
                    <AxisY Title="Number of Complaints" >
						<MajorGrid Enabled="False" />
					</AxisY>
                </asp:ChartArea>
            </ChartAreas>

            <Legends>
                <asp:Legend Name="Legend1"></asp:Legend>
            </Legends>
        </asp:Chart>
    </div>

    <asp:Label ID="Label1" runat="server" Text="" CssClass="error-label"></asp:Label>
</asp:Content>
