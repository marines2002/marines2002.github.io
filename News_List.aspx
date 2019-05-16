<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="News Articles" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>

<script runat="server">

    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        int pages;
        pages = (int)e.Command.Parameters["@pageCount"].Value;
        pn1.Count = pages;
        Pn2.Count = pages;
    }

    protected void pn1_SelectedPageChanged(object sender, System.EventArgs e)
    {
        Pn2.SelectedPage = pn1.SelectedPage;
    }

    protected void Pn2_SelectedPageChanged(object sender, System.EventArgs e)
    {
        pn1.SelectedPage = Pn2.SelectedPage;
    }
    private bool IsAdmin;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        IsAdmin = User.IsInRole("Administrators");
        panel1.Visible = IsAdmin;
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
                <h2>News Articles</h2>
                <p> <p>
                    If you have any News articles you want to be added to our list please contact a site
            admin or email via the <a href="contact.aspx"> <b>Contact</b></a> page</p></p>
            </div>
        </div>
        <!--
        
        Right column
        
        -->
        <div id="columnright">
            <div class="rightblock">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
                    SelectCommand="PagedAnnouncementList" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                    <SelectParameters>
                        <asp:ControlParameter Name="pageNum" ControlID="pn1" PropertyName="SelectedPage" />
                        <asp:Parameter DefaultValue="10" Name="pageSize" Type="Int32" />
                        <asp:Parameter Name="pageCount" Direction="ReturnValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Panel ID="panel1" runat="server" CssClass="actionbuttons">
                    <Club:RolloverLink ID="RemoveBtn" runat="server" Text="Add new Article" NavigateURL="News_Edit.aspx?Action=New" />
                </asp:Panel>
                <div class="dashedline">
                </div>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="pn1" runat="server" CssClass="PageNumbers" DisplayedPages="7"
                        OnSelectedPageChanged="pn1_SelectedPageChanged" />
                </div>
                <div class="dashedline">
                </div>
                <!-- begin news item -->
                <asp:Repeater ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <div class="listitem">
                            <div class="thumbnail">
                                <a href='<%# "News_View.aspx?Articleid=" + Convert.ToString( Eval("ID"))%>'>
                                    <Club:ImageThumbnail ID="ImageThumbnail1" runat="server" PhotoID='<%# Eval("photo") %>'
                                        NoPhotoImg="images/news.jpg" />
                                </a>
                            </div>
                            <asp:Panel ID="panel2" runat="server" Visible='<%#IsAdmin %>'>
                                <Club:RolloverLink ID="EditBtn" runat="server" Text="Edit" NavigateURL='<%# "News_Edit.aspx?Action=Edit&ArticleID=" + Convert.ToString( Eval("ID")) %>' />
                                <Club:RolloverLink ID="RemoveBtn" runat="server" Text="Remove" NavigateURL='<%# "News_Edit.aspx?Action=Remove&ArticleID=" + Convert.ToString( Eval("ID")) %>' />
                            </asp:Panel>
                            <h3>
                                <asp:Label ID="itemdateLabel" runat="server" Text='<%# Eval("itemdate","{0:d}") %>' />
                                &nbsp;&nbsp;&nbsp;&nbsp; <a href='<%# "news_view.aspx?articleid=" + Convert.ToString( Eval("ID"))%>'>
                                    <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' />
                                </a>
                            </h3>
                            <p>
                                <asp:Label ID="descriptionLabel" runat="server" Text='<%# SharedRoutines.truncate((string)Eval("description")) %>' />
                                <a href='<%# "news_view.aspx?articleid=" + Convert.ToString( Eval("ID"))%>'>read more &raquo;</a></p>
                            <div class="clearlist">
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="dashedline">
                </div>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="Pn2" runat="server" DisplayedPages="7" CssClass="PageNumbers"
                        OnSelectedPageChanged="Pn2_SelectedPageChanged" />
                </div>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
     <Club:LoginBanner ID="LoginBanner1" runat="server" />
</asp:Content>
