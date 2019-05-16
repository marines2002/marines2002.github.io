<%@ Control Language="C#" ClassName="AlbumPicker" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>

<script runat="server">
    protected void albumselect_SelectedIndexChanged(object sender, System.EventArgs e)
    {
        if (albumselect.SelectedIndex != 0)
        {
            FormView1.PageIndex = albumselect.SelectedIndex - 1;
            FormView1.Visible = true;
        }
        else
        {
            FormView1.Visible = false;
        }
    }

    public object AlbumID
    {
        get
        {
            object o = albumselect.SelectedValue;
            if (o != null && (string)o != "")
            {
                int val = Convert.ToInt32(o);
                if (val > 0)
                {
                    return val;
                }
            }
            return DBNull.Value;
        }
        set
        {
            if (value == null || value == DBNull.Value)
            {
                FormView1.Visible = false;
                albumselect.SelectedIndex = 0;
            }
            else
            {
                albumselect.SelectedValue = Convert.ToString(value);
                albumselect.DataBind();
                FormView1.PageIndex = albumselect.SelectedIndex - 1;
                FormView1.Visible = true;
            }
        }
    }

    protected void albumselect_DataBinding(object sender, System.EventArgs e)
    {
        albumselect.Items.Clear();
        albumselect.Items.Add(new ListItem("No Album Selected", "0"));
    }

    protected void AlbumList_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
    {
        if (Page.User.Identity.IsAuthenticated)
        {
            e.Command.Parameters["@userid"].Value = Membership.GetUser().ProviderUserKey;
        }
        else
        {
            e.Command.Parameters["@userid"].Value = DBNull.Value;
        }
    }
</script>

<div class="controlblock">
    <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>" ID="AlbumList"
        runat="server" SelectCommand="AlbumList" SelectCommandType="StoredProcedure"
        OnSelecting="AlbumList_Selecting">
        <SelectParameters>
            <asp:Parameter Name="userid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table>
        <tr valign="top">
            <td style="height: 47px">
                <asp:ListBox DataSourceID="AlbumList" DataTextField="title" DataValueField="albumid"
                    AutoPostBack="true" ID="albumselect" runat="server" AppendDataBoundItems="true"
                    Rows="5" OnSelectedIndexChanged="albumselect_SelectedIndexChanged" OnDataBinding="albumselect_DataBinding">
                </asp:ListBox></td>
            <td>
                <asp:FormView DataSourceID="AlbumList" ID="FormView1" runat="server">
                    <ItemTemplate>
                        <div style="float: left;">
                            <Club:ImageThumbnail ID="ImageThumbnail1" runat="server" PhotoID='<%# Eval("DisplayImage") %>' />
                        </div>
                        <div>
                            <h4>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("title") %>' /></h4>
                            <p>
                                <asp:Label ID="desclabel" runat="server" Text='<%# Eval("description") %>' />
                            </p>
                            <p>
                                Album contains
                                <asp:Label ID="imagecount" runat="server" Text='<%# Eval("ImageCount") %>' />
                                images.
                                <asp:Label ID="privateLabel" runat="server" Text=" Album is Private. " Visible='<%# (bool)Eval("Private") %>' />
                                <asp:HyperLink ID="viewlink" runat="server" NavigateUrl='<%# "photoalbum_contents.aspx?Albumid=" + Convert.ToString(Eval("AlbumID")) %>'
                                    Target="_blank" Text="View Album"></asp:HyperLink>
                            </p>
                        </div>
                    </ItemTemplate>
                </asp:FormView>
            </td>
        </tr>
    </table>
    <Club:RolloverLink ID="addlocation" runat="server" NavigateURL="photoalbum_new.aspx?Action=new"
        Text="Add new location" target="_blank" />
</div>
