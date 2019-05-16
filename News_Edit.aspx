<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Edit News Article"
    ValidateRequest="false" %>
    
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>
<%@ Register TagPrefix="Club" TagName="Photopicker" Src="photos_formpicker.ascx" %>
<%@ Register TagPrefix="Club" TagName="Dateandtimepicker" Src="Dateandtimepicker.ascx" %>
<%@ Register TagPrefix="Club" TagName="PhotoAlbumPicker" Src="photoalbum_picker.ascx" %>
<%@ Register TagPrefix="uc1"  TagName="tinyMCE" Src="tinyMCE.ascx" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.Common" %>

<script runat="server">
    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!IsPostBack)
        {
            object o = Request.QueryString["Action"];
            if (o!= null)
            {
                string action = System.Convert.ToString(o).ToLower();
                if (action == "new")
                {
                    FormView1.ChangeMode(FormViewMode.Insert);
                    ((DateandTimePicker)(FormView1.FindControl("dtpicker"))).selectedDateTime = DateTime.Now;
                    ((AlbumPicker)(FormView1.FindControl("albumpick"))).AlbumID = 0;
                }
                if (action == "remove")
                {
                    SqlDataSource1.Delete();
                    Response.Redirect("news_list.aspx");
                }
            }
        }
    }

    protected void FormView1_DataBound(object sender, System.EventArgs e)
    {
        if (FormView1.CurrentMode == FormViewMode.Insert)
        {
            ((DateandTimePicker)(FormView1.FindControl("dtpicker"))).selectedDateTime = DateTime.Now;
        }
        else
        {
            CheckBox cb = ((CheckBox)(FormView1.FindControl("CheckBox1")));
            TextBox surl = ((TextBox)(FormView1.FindControl("staticURLTextBox")));
            if (surl.Text != "")
            {
                cb.Checked = true;
                surl.Enabled = true;
            }
            else
            {
                surl.Enabled = false;
            }
        }
    }

    protected void FormView1_ItemUpdated(object sender, System.Web.UI.WebControls.FormViewUpdatedEventArgs e)
    {
        Response.Redirect("news_view.aspx?ArticleID=" + e.Keys["id"].ToString());
    }

    protected void FormView1_ItemInserted(object sender, System.Web.UI.WebControls.FormViewInsertedEventArgs e)
    {
        Response.Redirect("news_list.aspx");
    }

    protected void CheckBox1_CheckedChanged(object sender, System.EventArgs e)
    {
        CheckBox cb = ((CheckBox)(FormView1.FindControl("CheckBox1")));
        TextBox surl = ((TextBox)(FormView1.FindControl("StaticURLTextBox")));
        if (cb.Checked)
        {
            surl.Enabled = true;
        }
        else
        {
            surl.Enabled = false;
        }
    }

    protected void AlbumList_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
    {
        DbParameter param = e.Command.Parameters["@userid"];
        param.DbType = DbType.Guid;
        if (Page.User.Identity.IsAuthenticated)
        {
            param.Value = Membership.GetUser().ProviderUserKey;
        }
        else
        {
            param.Value = DBNull.Value;
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <Club:LoginBanner ID="LoginBanner1" runat="server" />
        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="id"
            DefaultMode="Edit" OnDataBound="FormView1_DataBound" OnItemUpdated="FormView1_ItemUpdated"
            OnItemInserted="FormView1_ItemInserted">
            <InsertItemTemplate>
                <div class="fullwidth">
                    <h3>
                        New News Article</h3>
                    <div class="dashedline">
                    </div>
                    <div>
                        <div class="actionbuttons">
                            <Club:RolloverButton ID="GreenRolloverButton2" CommandName="Insert" Text="Save Article"
                                runat="server" />
                            <Club:RolloverLink ID="GreenRolloverLink1" Text="Cancel" runat="server" NavigateURL="news_list.aspx" />
                        </div>
                    </div>
                    <div class="dashedline">
                    </div>
                    <table>
                        <tr>
                            <td class="formlabel">
                                Article Title:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="titleTextBox" runat="server" Width="500px" Text='<%# Bind("title") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Link:
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="CheckBox1" runat="server" Text="Use a link instead of inline content for this article."
                                    OnCheckedChanged="CheckBox1_CheckedChanged" AutoPostBack="true" /><br />
                                URL:
                                <asp:TextBox Text='<%# Bind("staticURL") %>' runat="server" ID="staticURLTextBox"
                                    Width="450px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                <asp:Label ID="Label1" runat="server" Text="Description:" />
                            </td>
                            <td align="left">
                            <uc1:tinyMCE ID="TinyMCE1" Text='<%# Bind("description") %>' runat="server" Width="350px" Height="166px"/>
                            
                             <%--   <asp:TextBox Text='<%# Bind("description") %>' runat="server" ID="descriptionTextBox"
                                    Rows="10" TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Article Date</td>
                            <td align="left">
                                The news article will not be visible to users until after this date.
                                <Club:Dateandtimepicker ID="dtpicker" runat="server" selectedDateTime='<%#Bind("itemdate") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Photo:</td>
                            <td align="left">
                                <Club:Photopicker ID="Photopicker1" runat="server" ImageId='<%# Bind("photo") %>'
                                    SmallImage="true" />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Photo Album</td>
                            <td align="left">
                                Optionally, the news article can be assoiated with a photo album.
                                <br />
                                <Club:PhotoAlbumPicker ID="albumpick" runat="server" AlbumID='<%# bind("Albumid") %>' />
                            </td>
                        </tr>
                    </table>
                    <div class="dashedline">
                    </div>
                    <div class="actionbuttons">
                        <Club:RolloverButton ID="GreenRolloverButton3" CommandName="Insert" Text="Save Article"
                            runat="server" />
                        <Club:RolloverLink ID="GreenRolloverLink2" Text="Cancel" runat="server" NavigateURL="news_list.aspx" />
                    </div>
                </div>
                </div>
            </InsertItemTemplate>
            <EditItemTemplate>
                <div class="fullwidth">
                    <h3>
                        Edit News Article</h3>
                    <div class="dashedline">
                    </div>
                    <div class="actionbuttons">
                        <Club:RolloverButton ID="GreenRolloverButton1" CommandName="Update" Text="Save Changes"
                            runat="server" />
                        <Club:RolloverLink ID="GreenRolloverLink3" Text="Cancel" runat="server" NavigateURL='<%# "news_view.aspx?ArticleID=" + Convert.ToString(Eval("ID")) %>' />
                    </div>
                    <div class="dashedline">
                    </div>
                    <table>
                        <tr>
                            <td class="formlabel">
                                Article Title:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="titleTextBox" runat="server" Width="500px" Text='<%# Bind("title") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Link:
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="CheckBox1" runat="server" Text="Use a link instead of inline content for this article."
                                    OnCheckedChanged="CheckBox1_CheckedChanged" AutoPostBack="true" /><br />
                                URL:
                                <asp:TextBox Text='<%# Bind("staticURL") %>' runat="server" ID="staticURLTextBox"
                                    Width="450px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                <asp:Label ID="Label1" runat="server" Text="Description:" />
                            </td>
                            <td align="left">
                            <uc1:tinyMCE ID="TinyMCE1" Text='<%# Bind("description") %>' runat="server" Width="350px" Height="166px"/>
                            
                            <%--    <asp:TextBox Text='<%# Bind("description") %>' runat="server" ID="descriptionTextBox"
                                    Rows="10" TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Article Date</td>
                            <td align="left">
                                <p>
                                    The news article will not be visible to users until after this date.
                                </p>
                                <Club:Dateandtimepicker ID="dtpicker" runat="server" selectedDateTime='<%#Bind("itemdate") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Photo:</td>
                            <td align="left">
                                <Club:Photopicker ID="Photopicker1" runat="server" ImageId='<%# Bind("photo") %>'
                                    SmallImage="true" />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Photo Album</td>
                            <td align="left">
                                <p>
                                    Optionally, the news article can be assoiated with a photo album.
                                </p>
                                <Club:PhotoAlbumPicker ID="albumpick" runat="server" AlbumID='<%# bind("Albumid") %>' />
                            </td>
                        </tr>
                    </table>
                    <div class="dashedline">
                    </div>
                    <div class="actionbuttons">
                        <Club:RolloverButton ID="apply1" CommandName="Update" Text="Save Changes" runat="server" />
                        <Club:RolloverLink ID="Cancel" Text="Cancel" runat="server" NavigateURL='<%# "news_view.aspx?ArticleID=" + Convert.ToString(Eval("ID")) %>' />
                    </div>
                </div>
                </div>
            </EditItemTemplate>
        </asp:FormView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
        SelectCommand="SELECT id, itemdate, title, description, staticURL, photo, albumid from announcements where Announcements.id=@id"
        InsertCommand="INSERT INTO Announcements(itemdate, title, description, staticURL, photo, albumid) VALUES (@itemdate, @title, @description, @staticURL, @photo, @albumid)"
        UpdateCommand="UPDATE Announcements SET itemdate = @itemdate, title = @title, description = @description, staticURL = @staticURL, photo = @photo, albumid = @albumid WHERE (id = @id)"
        DeleteCommand="Delete from Announcements where id=@id" OldValuesParameterFormatString="{0}">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="ArticleID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="itemdate" Type="DateTime" />
            <asp:Parameter Name="title" />
            <asp:Parameter Name="description" />
            <asp:Parameter Name="staticURL" />
            <asp:Parameter Name="location" />
            <asp:Parameter Name="photo" />
            <asp:Parameter Name="id" />
            <asp:Parameter Name="albumid" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="itemdate" Type="DateTime" />
            <asp:Parameter Name="title" />
            <asp:Parameter Name="description" />
            <asp:Parameter Name="staticURL" />
            <asp:Parameter Name="location" />
            <asp:Parameter Name="photo" />
            <asp:Parameter Name="id" />
            <asp:Parameter Name="albumid" />
        </InsertParameters>
        <DeleteParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="ArticleID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>" ID="AlbumList"
        runat="server" SelectCommand="AlbumList" SelectCommandType="StoredProcedure"
        OnSelecting="AlbumList_Selecting">
        <SelectParameters>
            <asp:Parameter Name="userid" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
