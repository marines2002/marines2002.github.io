<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Modify Membership Details" %>

<%@ Register Src="Photos_formpicker.ascx" TagName="Photos_formpicker" TagPrefix="Club" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>

<%@ Import Namespace="System.Drawing" %>

<script runat="server">
    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!Page.User.Identity.IsAuthenticated)
        {
            Response.Write("To use the member details functionality, you need to be authenticated. Please use the <a href='login.aspx'>Login</a> page to authenticate yourself.");
            Response.End();
        }
        else if (!IsPostBack)
        {
            InitPageData();
        }
    }

    protected void update_Click(object sender, System.EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        DataSetMemberTableAdapters.MemberInfoTableAdapter da = new DataSetMemberTableAdapters.MemberInfoTableAdapter();
        if (Email.Text != user.Email)
        {
            user.Email = Email.Text;
        }
        try
        {
            da.Update((Guid)user.ProviderUserKey, Addr.Text, Phone.Text, fname.Text, lname.Text, (Guid)user.ProviderUserKey);
            ContactStatus.Text = "Details have been updated sucessfully.";
            ContactStatus.ControlStyle.ForeColor = Color.Black;
        }
        catch (Exception ex)
        {
            ContactStatus.Text = "Error updating contact details: " + ex.Message;
            ContactStatus.ControlStyle.ForeColor = Color.Red;
        }
    }

    void InitPageData()
    {
        MembershipUser user = Membership.GetUser();
        DataSetMemberTableAdapters.MemberInfoTableAdapter da = new DataSetMemberTableAdapters.MemberInfoTableAdapter();
        DataSetMember.MemberInfoDataTable dt = da.GetMember((Guid)user.ProviderUserKey);
        if (dt.Rows.Count == 1)
        {
            DataSetMember.MemberInfoRow mr = dt[0];
            UserName.Text = user.UserName;
            fname.Text = mr.firstname;
            lname.Text = mr.lastname;
            Email.Text = user.Email;
            Addr.Text = mr.address;
            Phone.Text = mr.phone;
            if (!mr.IsAvatarSizeNull())
            {
                avatarimage.ImageUrl = "AvatarImagefetch.ashx?Memberid=" + user.ProviderUserKey.ToString();
            }
            else
            {
                avatarimage.ImageUrl = "images/nophoto.gif";
            }
        }
    }

    protected void uploadimage_Click(object sender, System.EventArgs e)
    {
        byte[] thumbimage = ImageUtils.MakeThumb(newavatar.FileBytes, 69, 69);
        DataSetMemberTableAdapters.MemberInfo1TableAdapter m = new DataSetMemberTableAdapters.MemberInfo1TableAdapter();
        Guid memberid = (Guid)(Membership.GetUser().ProviderUserKey);
        Guid origid = memberid;
        m.Update(memberid, thumbimage, origid);
        avatarimage.ImageUrl = "AvatarImagefetch.ashx?Memberid=" + memberid.ToString();
    }

    protected void clearimage_Click(object sender, System.EventArgs e)
    {
        DataSetMemberTableAdapters.MemberInfo1TableAdapter m = new DataSetMemberTableAdapters.MemberInfo1TableAdapter();
        Guid memberid = ((Guid)(Membership.GetUser().ProviderUserKey));
        Guid origid = memberid;
        m.Update(memberid, null, origid);
        avatarimage.ImageUrl = "images/nophoto.gif";
    }
</script>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <!--Start of left column-->
        <div id="columnleft">
            <a name="content_start" id="content_start"></a>
            <div class="leftblock">
                <h2>
                    Membership Details for
                    <asp:Label ID="UserName" runat="server" /></h2>
                <p>
                    Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
                    euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad
                    minim veniam, quis nostrud exercitation ulliam corper suscipit lobortis nisl ut
                    aliquip ex ea commodo consequat. Duis autem veleum iriure dolor in hendrerit in
                    vulputate velit esse molestie consequat, vel willum lunombro dolore eu feugiat nulla
                    facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent
                    luptatum zzril delenit augue duis dolore te feugait nulla facilisi.</p>
            </div>
        </div>
        <!--end columnleft-->
        <!--Start of right column-->
        <div id="columnright">
            <div class="rightblock">
                <h2>
                    Modify Contact Details
                </h2>
                <div class="dashedline">
                </div>
                <p>
                    Use the form below to change your contact details. These values are used in the
                    members list, and for club leadership to contact you.
                </p>
                <asp:Label EnableViewState="False" ID="ContactStatus" runat="server" />
                <table border="0">
                    <tr>
                        <td class="formlabel">
                            <label for="Email">
                                E-mail:</label></td>
                        <td>
                            <asp:TextBox ID="Email" runat="server" CssClass="txtfield" />
                            <asp:RequiredFieldValidator ControlToValidate="Email" ErrorMessage="E-mail is required."
                                ID="EmailRequired" runat="server" ToolTip="E-mail is required." ValidationGroup="CreateUserForm">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            <label for="fname">
                                First Name:</label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="fname" CssClass="txtfield" />
                            <asp:RequiredFieldValidator ControlToValidate="fname" ErrorMessage="First Name is required."
                                ID="RequiredFieldValidator1" runat="server" ToolTip="First Name is required."
                                ValidationGroup="CreateUserForm">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            <label for="lname">
                                Last Name:</label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="lname" CssClass="txtfield" />
                            <asp:RequiredFieldValidator ControlToValidate="lname" ErrorMessage="Last Name is required."
                                ID="RequiredFieldValidator2" runat="server" ToolTip="Last Name is required."
                                ValidationGroup="CreateUserForm">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            <label for="Addr">
                                Address:</label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="Addr" Rows="3" TextMode="MultiLine" CssClass="txtblock" />
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            <label for="Phone">
                                Phone:</label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="Phone" CssClass="txtfield" />
                        </td>
                    </tr>
                </table>
                <p>
                    <Club:RolloverButton ID="update" runat="server" Text="Update Registration" OnClick="update_Click" />
                </p>
            </div>
            <div class="rightblock">
                <h2>
                    Avatar Image
                </h2>
                <div class="dashedline">
                </div>
                <p>
                    You can upload an avatar image that will be shown in the members list. Your current
                    image is:
                </p>
                <asp:Image runat="server" ID="avatarimage" CssClass="photo" />
                <p>
                    To upload a new image, select a file and click on the upload button.</p>
                Filename:
                <asp:FileUpload ID="newavatar" runat="server" />
                <p>
                    <Club:RolloverButton ID="uploadimage" runat="server" Text="Upload Image" OnClick="uploadimage_Click" />
                    <Club:RolloverButton ID="clearimage" runat="server" Text="Clear Image" OnClick="clearimage_Click" /></p>
            </div>
            <div class="rightblock">
                <h2>
                    Change Password
                </h2>
                <div class="dashedline">
                </div>
                <asp:ChangePassword ID="ChangePassword1" runat="server">
                    <ChangePasswordTemplate>
                        <table border="0" cellpadding="1">
                            <tr>
                                <td>
                                    <table border="0" cellpadding="0">
                                        <tr>
                                            <td align="center" colspan="2">
                                                Change Your Password</td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Password:</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                                    ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                                    ErrorMessage="New Password is required." ToolTip="New Password is required."
                                                    ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                                    ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required."
                                                    ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                                                    ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry."
                                                    ValidationGroup="ChangePassword1"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color: red">
                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                                                    Text="Change Password" ValidationGroup="ChangePassword1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                    Text="Cancel" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ChangePasswordTemplate>
                </asp:ChangePassword>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
</asp:Content>
