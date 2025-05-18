<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Raj Refrigeration</title>
    <link rel="stylesheet" href="Default.css" />
    <link rel="icon" type="image/svg" href="imgs/RRLogo.svg" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="gridviewstyle.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" rel="stylesheet" integrity="sha512-MVHK8wbqYTME367INWA/pJfQ2KPwRufhPGYqbm1nqAJxWUSXWhWHNqEvQYKlh5zvBvLC9GbRZhnqCrEuOn9IWQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script type="text/javascript">
        // JavaScript function to toggle password visibility
        function togglePassword() {
            var passwordField = document.getElementById('TextBox2');  // Password input field
            var checkBox = document.getElementById('CheckBox1');      // Show password checkbox
            if (checkBox.checked) {
                passwordField.type = 'text';  // Change type to 'text' to show password
            } else {
                passwordField.type = 'password';  // Change type back to 'password' to hide it
            }
        }
    </script>
</head>
<body>
    <!-- Single unified Login Container -->
    <div class="login-container">
        <form id="form1" runat="server">
            <!-- Combined logo and heading -->
            <div class="logo-container">
                <img src="imgs/RRLogo.svg" />
                <h1 class="company-name">Raj Refrigeration</h1>
            </div>

            <!-- Username -->
            <div class="form-group">
                <span class="fas fa-user" style="position: absolute; left: 10px; top: 12px; color: #333;"></span>
                <asp:TextBox ID="TextBox1" runat="server" placeholder="Username" CssClass="transparent-input" Style="padding-left: 30px;" />
            </div>

            <!-- Password -->
            <div class="form-group">
                <span class="fas fa-lock" style="position: absolute; left: 10px; top: 12px; color: #333;"></span>
                <asp:TextBox ID="TextBox2" runat="server" placeholder="Password" TextMode="Password" CssClass="transparent-input" Style="padding-left: 30px;" />
            </div>

            <!-- Show Password + Error Message -->
            <div class="form-group show-password">
                <asp:CheckBox ID="CheckBox1" runat="server" Text="Show Password" onchange="togglePassword()" />
                <br />
                <center><b><asp:Label ID="Label1" runat="server" Text="" Visible="false" ForeColor="red" /></b></center>
            </div>

            <!-- Login Button -->
            <div class="form-group">
                <asp:Button ID="Button1" runat="server" Text="Log In" CssClass="login-button" OnClick="Button1_Click" />
            </div>
        </form>
    </div>
</body>

</html>
