<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Untitled Page" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>

<script runat="server">
    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        int pages;
        pages = Convert.ToInt32(e.Command.Parameters["@pageCount"].Value);
        pn1.Count = pages;
        pn2.Count = pages;
    }

    protected void pn1_SelectedPageChanged(object sender, System.EventArgs e)
    {
        pn2.SelectedPage = pn1.SelectedPage;
    }

    protected void Pn2_SelectedPageChanged(object sender, System.EventArgs e)
    {
        pn1.SelectedPage = pn2.SelectedPage;
    }

    protected void SqlDataSource1_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            e.Command.Parameters["@ownerid"].Value = Membership.GetUser().ProviderUserKey;
        }
        else
        {
            e.Command.Parameters["@ownerid"].Value = DBNull.Value;
        }
    }

    protected void Page_Load(object sender, System.EventArgs e)
    {
        panel1.Visible = User.IsInRole("Administrators");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <!--
        
        Left column
        
        -->
        <div id="columnleft">
            <a name="content_start" id="content_start"></a>
            <div class="leftblock">
                <h2>Photo Albums</h2>
                 <p>
                    If you have any Photo's you want to be added to our list please contact a site
            admin or email via the <a href="contact.aspx"> <b>Contact</b></a> page</p>
            </div>
        </div>
        <!--
        
        Right column
        
        -->
        <div id="columnright">
            <div class="rightblock">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubsiteDB %>"
                    SelectCommand="PagedAlbumList" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected"
                    OnSelecting="SqlDataSource1_Selecting">
                    <SelectParameters>
                        <asp:ControlParameter Name="pageNum" ControlID="pn1" PropertyName="SelectedPage" />
                        <asp:Parameter DefaultValue="16" Name="pageSize" Type="Int32" />
                        <asp:Parameter Name="pageCount" Direction="ReturnValue" Type="Int32" />
                        <asp:Parameter Name="ownerid" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="pn1" runat="server" DisplayedPages="7" CssClass="PageNumbers"
                        OnSelectedPageChanged="pn1_SelectedPageChanged" />
                </div>
                <div class="dashedline">
                </div>
                <asp:Panel runat="server" ID="panel1">
                    <div class="actionbuttons">
                        <Club:RolloverLink ID="AddBtn" runat="server" Text="Add new Album" NavigateURL="photoalbum_New.aspx" />
                    </div>
                    <div class="dashedline">
                    </div>
                </asp:Panel>
                <asp:DataList ID="albumlist" runat="server" DataSourceID="SqlDataSource1" RepeatColumns="2">
                    <ItemTemplate>
                        <div class="membercard">
                            <div style="float: left; padding: 0 5px 0 0;">
                                <a href='<%# "Photoalbum_contents.aspx?Albumid=" + Convert.ToString( Eval("AlbumID"))%>'>
                                    <Club:ImageThumbnail ID="ImageThumbnail1" runat="server" PhotoID='<%# Eval("DisplayImage") %>' />
                                </a>
                            </div>
                            <h3>
                                <a href='<%# "Photoalbum_contents.aspx?Albumid=" + Convert.ToString(Eval("albumID"))%>'>
                                    <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' />
                                </a>
                            </h3>
                            <asp:Label ID="privateLabel" runat="server" Text='<p>Private to UserName<p>' Visible='<%# (bool)Eval("Private") %>' />
                            <p>
                                Album contains
                                <asp:Label ID="imagecount" runat="server" Text='<%# Eval("ImageCount") %>' />
                                images.</p>
                            <div class="clearcard">
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
                <!-- begin news item -->
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:DataList>
                <div class="dashedline">
                </div>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="pn2" runat="server" DisplayedPages="7" CssClass="PageNumbers"
                        OnSelectedPageChanged="Pn2_SelectedPageChanged" />
                </div>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
     <Club:LoginBanner ID="LoginBanner1" runat="server" />
</asp:Content>
