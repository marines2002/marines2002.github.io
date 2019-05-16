<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Page</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    <table class="style1">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Button" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="LinkButton1" runat="server" 
                    PostBackUrl="~/testharness/FileUpload.aspx">LinkButton</asp:LinkButton>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem>Duloe</asp:ListItem>
                    <asp:ListItem>Looe</asp:ListItem>
                    <asp:ListItem>Lanreath</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:CheckBox ID="CheckBox1" runat="server" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                </asp:RadioButtonList>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="LinkButton2" runat="server" 
                    PostBackUrl="~/testharness/ShoppingCart.aspx">ShoppingCart</asp:LinkButton>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    </form>
</body>
</html>
