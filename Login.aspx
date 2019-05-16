<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Login" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>

<script runat="server">
 
    protected void LoginButton_Click(object sender, EventArgs e)
    {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <!--Start of left column-->
        <div id="columnleft">
            <a name="content_start" id="content_start"></a>
            <div class="leftblock">
                <h2>
                    Login</h2>
                <p>
                    To see all content on this site you don&#39;t have to login but if you would like to 
                    be a contributer please register and I&#39;ll enable to be able to add Events, News 
                    and Photo&#39;s to the site or if you want to receive email to let you know about 
                    updates to the site.</p>
            </div>
        </div>
        <!--end columnleft-->
        <!--Start of right column-->
        <div id="columnright">
            <div class="rightblock">
                <h2>
                    Login</h2>
                <div class="dashedline">
                </div>
                <h3 class="none">
                    Log into Duloe Online</h3>
                <asp:Login ID="Login1" runat="server">
                    <LayoutTemplate>
                        <fieldset>
                            <legend class="none">Log into My Club Site</legend>
                            <asp:Literal runat="server" ID="FailureText" EnableViewState="False"></asp:Literal>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label runat="server" AssociatedControlID="UserName" ID="UserNameLabel">User name:</asp:Label></td>
                                    <td>
                                        <asp:TextBox runat="server" ID="UserName"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName" ValidationGroup="Login1"
                                            ErrorMessage="User Name is required." ToolTip="User Name is required." ID="UserNameRequired">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server" AssociatedControlID="Password" ID="PasswordLabel">Password:</asp:Label></td>
                                    <td>
                                        <asp:TextBox runat="server" TextMode="Password" ID="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" ValidationGroup="Login1"
                                            ErrorMessage="Password is required." ToolTip="Password is required." ID="PasswordRequired">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="RememberMe" Text="Remember me next time." /></td>
                                </tr>
                            </table>
                            <Club:RolloverButton ID="LoginButton" runat="server" Text="Login" CommandName="Login" />
                        </fieldset>
                    </LayoutTemplate>
                </asp:Login>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
</asp:Content>
