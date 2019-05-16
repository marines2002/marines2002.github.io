<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Untitled Page" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>

<script runat="server">

    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        int pages;
        pages = (int) e.Command.Parameters["@pageCount"].Value;
        pn1.Count = pages;
        pn2.Count = pages;
    }

    protected void SqlDataSource2_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        int pages;
        pages = (int) e.Command.Parameters["@pageCount"].Value;
        pn3.Count = pages;
        pn4.Count = pages;
    }

    protected void pn1_SelectedPageChanged(object sender, System.EventArgs e)
    {
        pn2.SelectedPage = pn1.SelectedPage;
    }

    protected void pn2_SelectedPageChanged(object sender, System.EventArgs e)
    {
        pn1.SelectedPage = pn2.SelectedPage;
    }

    protected void pn3_SelectedPageChanged(object sender, System.EventArgs e)
    {
        pn4.SelectedPage = pn3.SelectedPage;
    }

    protected void pn4_SelectedPageChanged(object sender, System.EventArgs e)
    {
        pn3.SelectedPage = pn4.SelectedPage;
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
                <h2>
                    Events</h2>
                <p>
                     <p>
                    If you have an Event you want to be added to our list please contact a site
            admin or email via the <a href="contact.aspx"> <b>Contact</b></a> page</p></p>
            </div>
        </div>
        <!--
        
        Right column
        
        -->
        <div id="columnright">
            <div class="rightblock">
                <asp:Panel ID="panel1" runat="server" CssClass="actionbuttons">
                    <Club:RolloverLink ID="AddBtn" runat="server" Text="Add new event" NavigateURL="Events_Edit.aspx?Action=New" />
                </asp:Panel>
                <a href="Events_calendar.aspx">Month view</a> &nbsp; &nbsp; <a href="Locations_list.aspx">
                    Locations List</a>
            </div>
            <div class="rightblock">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
                    SelectCommand="PagedUpcommingEventList" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                    <SelectParameters>
                        <asp:ControlParameter Name="pageNum" ControlID="pn1" PropertyName="SelectedPage" />
                        <asp:Parameter DefaultValue="5" Name="pageSize" Type="Int32" />
                        <asp:Parameter Name="pageCount" Direction="ReturnValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <h2>
                    Forthcoming events</h2>
                <div class="dashedline">
                </div>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="pn1" runat="server" SelectedPage="1" DisplayedPages="7" OnSelectedPageChanged="pn1_SelectedPageChanged"
                        CssClass="PageNumbers" />
                </div>
                <div class="dashedline">
                </div>
                <!-- begin news item -->
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <div class="listitem">
                            <div class="thumbnail">
                                <a href='<%# "Events_view.aspx?Eventid=" + Convert.ToString(Eval("ID"))%>'>
                                    <Club:ImageThumbnail ID="ImageThumbnail1" runat="server" PhotoID='<%# Eval("photo") %>'
                                        NoPhotoImg="images/calendar.jpg" />
                                </a>
                            </div>
                            <asp:Panel ID="panel2" runat="server" CssClass="editbuttons" Visible='<%#IsAdmin %>'>
                                <Club:RolloverLink ID="EditBtn" runat="server" Text="Edit" NavigateURL='<%# "Events_Edit.aspx?Action=Edit&id=" + Convert.ToString(Eval("id")) %>' />
                                <Club:RolloverLink ID="RemoveBtn" runat="server" Text="Remove" NavigateURL='<%# "Events_Edit.aspx?Action=Remove&id=" + Convert.ToString(Eval("id")) %>' />
                            </asp:Panel>
                            <h3>
                                <asp:Label ID="itemdateLabel" runat="server" Text='<%# Eval("starttime","{0:d}") %>' />
                                &nbsp;&nbsp;&nbsp;&nbsp; <a href='<%# "Events_view.aspx?Eventid=" + Convert.ToString( Eval("ID"))%>'>
                                    <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' />
                                </a>
                            </h3>
                            <p>
                                <asp:Label ID="descriptionLabel" runat="server" Text='<%# SharedRoutines.truncate((string)Eval("description")) %>' />
                                <a href='<%# "Events_view.aspx?Eventid=" + Convert.ToString( Eval("ID"))%>'>read more &raquo;</a></p>
                            <div class="clearlist">
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="dashedline">
                </div>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="pn2" runat="server" SelectedPage="1" DisplayedPages="7" CssClass="PageNumbers"
                        OnSelectedPageChanged="pn2_SelectedPageChanged" />
                </div>
            </div>
            <div class="rightblock">
                <h2>
                    Recent events</h2>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
                    SelectCommand="PagedRecentEventList" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected">
                    <SelectParameters>
                        <asp:ControlParameter Name="pageNum" ControlID="pn3" PropertyName="SelectedPage" />
                        <asp:Parameter DefaultValue="5" Name="pageSize" Type="Int32" />
                        <asp:Parameter Name="pageCount" Direction="ReturnValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div class="dashedline">
                </div>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="pn3" runat="server" SelectedPage="1" DisplayedPages="7" CssClass="PageNumbers"
                        OnSelectedPageChanged="pn3_SelectedPageChanged" />
                </div>
                <div class="dashedline">
                </div>
                <!-- begin news item -->
                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                    <ItemTemplate>
                        <div class="listitem">
                            <div class="thumbnail">
                                <a href='<%# "Events_view.aspx?Eventid=" + Convert.ToString( Eval("ID"))%>'>
                                    <Club:ImageThumbnail ID="ImageThumbnail1" runat="server" PhotoID='<%# Eval("photo")%>'
                                        NoPhotoImg="images/calendar.jpg" />
                                </a>
                            </div>
                            <asp:Panel ID="panel1" runat="server" CssClass="editbuttons" Visible='<%#IsAdmin %>'>
                                <Club:RolloverLink ID="EditBtn" runat="server" Text="Edit" NavigateURL='<%# "Events_Edit.aspx?Action=Edit&id=" + Convert.ToString(Eval("id")) %>' />
                                <Club:RolloverLink ID="RemoveBtn" runat="server" Text="Remove" NavigateURL='<%# "Events_Edit.aspx?Action=Remove&id=" + Convert.ToString(Eval("id")) %>' />
                            </asp:Panel>
                            <h3>
                                <asp:Label ID="itemdateLabel" runat="server" Text='<%# Eval("starttime","{0:d}") %>' />
                                &nbsp;&nbsp;&nbsp;&nbsp; <a href='<%# "Events_view.aspx?Eventid=" + Convert.ToString( Eval("ID"))%>'>
                                    <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' />
                                </a>
                            </h3>
                            <p>
                                <asp:Label ID="descriptionLabel" runat="server" Text='<%# SharedRoutines.truncate((string)Eval("description")) %>' />
                                <a href='<%# "Events_view.aspx?Eventid=" + Convert.ToString( Eval("ID"))%>'>read more &raquo;</a></p>
                            <div class="clearlist">
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="dashedline">
                </div>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="pn4" runat="server" SelectedPage="1" DisplayedPages="7" CssClass="PageNumbers"
                        OnSelectedPageChanged="pn4_SelectedPageChanged" />
                </div>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
    <Club:LoginBanner ID="LoginBanner1" runat="server" />
</asp:Content>
