<%@ Control Language="C#" ClassName="Photos_formpicker" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>

<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.Common" %>

<script runat="server">
    
    const string CLIENTSCRIPTPREFIX = "__FormPhotoPicker_";

    public int ImageId
    {
        get
        {
            EnsureChildControls();
            if (viewswitch.ActiveViewIndex == 1)
            {
                return Convert.ToInt32(selectedimage.Value);
            }
            else
            {
                object id = ViewState["ImageID"];
                if (id == null)
                {
                    ViewState["ImageID"] = 0;
                    return 0;
                }
                else
                {
                    return Convert.ToInt32(id);
                }
            }
        }
        set
        {
            ViewState["ImageID"] = value;
        }
    }

    public bool SmallImage
    {
        get
        {
            object o = ViewState["SmallImage"];
            if (o != null)
            {
                return Convert.ToBoolean(o);
            }
            else
            {
                return false;
            }
        }
        set
        {
            ViewState["SmallImage"] = value;
        }
    }

    string imagesize()
    {
        return (SmallImage) ? "1" : "0";
    }

    protected void Page_PreRender(object sender, System.EventArgs e)
    {
        RenderScript();
        if (ImageId != 0)
        {
            imagepreview.ImageUrl = "imagefetch.ashx?ImageID=" + ImageId.ToString() + "&Size=" + imagesize();
        }
        else
        {
            imagepreview.ImageUrl = "images/nophoto.gif";
        }
    }

    protected void ShowPickExistingBtn_Click(object sender, System.EventArgs e)
    {
        viewswitch.SetActiveView(pickexistingview);
    }

    protected void ShowUploadBtn_Click(object sender, System.EventArgs e)
    {
        viewswitch.SetActiveView(uploadimageview);
    }

    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!IsPostBack)
        {
            viewswitch.SetActiveView(main);
        }
    }

    protected void ClearBtn_Click(object sender, System.EventArgs e)
    {
        ImageId = 0;
    }

    void RenderScript()
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("var " + CLIENTSCRIPTPREFIX + "selecteditem = null;");
        sb.AppendLine("function " + CLIENTSCRIPTPREFIX + "SelectItem(element, newimageid)");
        sb.AppendLine("{");
        sb.AppendLine(" if (" + CLIENTSCRIPTPREFIX + "selecteditem != null)");
        sb.AppendLine(" {");
        sb.AppendLine(" " + CLIENTSCRIPTPREFIX + "selecteditem.className='unselected';");
        sb.AppendLine(" }");
        sb.AppendLine(" " + CLIENTSCRIPTPREFIX + "selecteditem = element; ");
        sb.AppendLine(" " + CLIENTSCRIPTPREFIX + "selecteditem.className='selected';");
        sb.AppendLine(" document.getElementById('" + selectedimage.ClientID + "').value = newimageid;");
        sb.AppendLine("}");
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SelectItem", sb.ToString(), true);
    }

    protected void existingChosen_Click(object sender, System.EventArgs e)
    {
        ImageId = Convert.ToInt32(selectedimage.Value);
        viewswitch.SetActiveView(main);
    }

    protected void Cancel_Click(object sender, System.EventArgs e)
    {
        viewswitch.SetActiveView(main);
    }

    protected void UploadBtn_Click(object sender, System.EventArgs e)
    {
        int newimageid;
        newimageid = ImageUtils.uploadImage(Title.Text, Convert.ToInt32(AlbumList2.SelectedValue), FileUpload1.FileContent);
        ImageId = newimageid;
        viewswitch.SetActiveView(main);
    }

    protected void SetOwner(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
    {
        DbParameter param = e.Command.Parameters["@owner"];
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

<div class="controlblock">
    <asp:MultiView ID="viewswitch" runat="server">
        <asp:View ID="main" runat="server">
            <asp:Image runat="server" ID="imagepreview" CssClass="picture" BorderWidth="1" />
            <div class="contextbuttons">
                <Club:RolloverButton ID="ShowUploadBtn" Text="Upload new image" runat="server" OnClick="ShowUploadBtn_Click" />
                <Club:RolloverButton ID="ShowPickExistingBtn" Text="Pick an existing image" runat="server"
                    OnClick="ShowPickExistingBtn_Click" />
                <Club:RolloverButton ID="ClearBtn" Text="Clear selection" runat="server" OnClick="ClearBtn_Click" />
            </div>
        </asp:View>
        <asp:View ID="pickexistingview" runat="server">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SELECT albumid, title FROM Albums WHERE (ownerid = @owner) OR (private = 0)"
                ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>" OnSelecting="SetOwner">
                <SelectParameters>
                    <asp:Parameter Name="owner" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
                SelectCommand="SELECT title, id FROM images WHERE (album = @album)">
                <SelectParameters>
                    <asp:ControlParameter Name="album" ControlID="AlbumList" PropertyName="SelectedValue"
                        DefaultValue="1" />
                </SelectParameters>
            </asp:SqlDataSource>
            Select an image:
            <p>
                <asp:Label ID="Label1" runat="server" />
                Photo album: &nbsp; &nbsp;
                <asp:DropDownList ID="AlbumList" runat="server" DataSourceID="SqlDataSource1" DataTextField="title"
                    DataValueField="albumid" AutoPostBack="true" />
            </p>
            <div class="scrollablelist">
                <asp:HiddenField ID="selectedimage" runat="server" Value="0" />
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource2" DataKeyField="id"
                    RepeatColumns="4" CellSpacing="2" CssClass="scrolledtable">
                    <ItemTemplate>
                        <div onclick="<%# CLIENTSCRIPTPREFIX + "SelectItem(this, '" + Convert.ToString(Eval("ID")) + "')" %>"
                            class="unselected">
                            <asp:Image ImageUrl='<%# "imagefetch.ashx?size=1&imageid=" + Convert.ToString(Eval("id")) %>'
                                runat="server" ID="idImage" CssClass="selectablephoto" /><br />
                            <asp:Label Text='<%# Eval("title") %>' runat="server" ID="titleLabel" />
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <p>
            </p>
            <Club:RolloverButton ID="existingChosen" Text="Use selection" runat="server" OnClick="existingChosen_Click" />
            <Club:RolloverButton ID="Cancel1" Text="Cancel Selection" runat="server" OnClick="Cancel_Click" />
        </asp:View>
        <asp:View ID="uploadimageview" runat="server">
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" SelectCommand="SELECT albumid, title FROM Albums WHERE (ownerid = @owner) OR (private = 0)"
                ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>" OnSelecting="SetOwner">
                <SelectParameters>
                    <asp:Parameter Name="owner" />
                </SelectParameters>
            </asp:SqlDataSource>
            Select a file using the browse button, enter a caption title and click Upload Image.
            <asp:Label ID="ErrorLabel" runat="server" />
            <table>
                <tr>
                    <td>
                        Album to upload to:</td>
                    <td>
                        <asp:DropDownList ID="AlbumList2" runat="server" DataSourceID="SqlDataSource3" DataTextField="title"
                            DataValueField="albumid">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        File:</td>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" /></td>
                </tr>
                <tr>
                    <td>
                        Image title:</td>
                    <td>
                        <asp:TextBox ID="Title" runat="server" />
                    </td>
                </tr>
            </table>
            <p>
            </p>
            <Club:RolloverButton ID="UploadBtn" runat="server" Text="Upload Image" OnClick="UploadBtn_Click" />
            <Club:RolloverButton ID="Cancel2" runat="server" Text="Cancel upload" OnClick="Cancel_Click" />
        </asp:View>
    </asp:MultiView>
</div>
