<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Clubsite Contact Information" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Net" %>

<script runat="server">

    private static string message;
    
    protected void Button1_Click(object sender, EventArgs e)
    {
        message = string.Format("Name = {0}\nEmail = {1}\n Telephone = {2}\nMessage = {3}\n", txtName.Text, txtEmail.Text, txtTelephone.Text, txtMessage.Text);
 
        SendMail(message);

        lblMessage.Text = "Thank-you for your message someone will contact you shortly";
    }

    private void SendMail(string body)
    {
        string mailServerName = "localhost";
        MailMessage message = new MailMessage("info@duloeonline.com", "info@duloeonline.com", "Enquiry From DuloeOnline", body);
        SmtpClient mailClient = new SmtpClient();
        mailClient.Host = mailServerName;
        mailClient.Credentials = CredentialCache.DefaultNetworkCredentials;
        mailClient.Send(message);
        message.Dispose();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <div class="fullwidth">
            <h2>Contact Information</h2>
            <table style="width: 100%">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Name:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Email:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Telephone:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTelephone" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Message:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMessage" runat="server" Height="92px" TextMode="MultiLine" 
                            Width="358px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        
                        <asp:Button ID="Button1" runat="server" Text="Submit" Width="90px" 
                            onclick="Button1_Click" />
                        
                    </td>
                    <td>
                        
                        <asp:Label ID="lblMessage" runat="server" Enabled="False"></asp:Label>
                        
                    </td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            
        </div>
     </div>
</asp:Content>
