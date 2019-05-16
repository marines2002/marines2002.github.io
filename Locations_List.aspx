<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="News Articles" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>

<script runat="server">

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        int pages;
        pages = System.Convert.ToInt32(e.Command.Parameters["@pageCount"].Value);
        pn1.Count = pages;
        pn2.Count = pages;
    }

    protected void pn1_SelectedPageChanged(object sender, EventArgs e)
    {
        pn2.SelectedPage = pn1.SelectedPage;
    }

    protected void Pn2_SelectedPageChanged(object sender, EventArgs e)
    {
        pn1.SelectedPage = pn2.SelectedPage;
    }
    private bool IsAdmin;

    protected void Page_Load(object sender, EventArgs e)
    {
        IsAdmin = User.IsInRole("Administrators");
        panel1.Visible = IsAdmin;
    }
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <Club:LoginBanner ID="LoginBanner1" runat="server" />
        <!--
        
        Left column
        
        -->
        <div id="columnleft">
            <a name="content_start" id="content_start"></a>
            <div class="leftblock">
                <h2>
                    Locations</h2>
                <p>
                    </p>
            </div>
        </div>
        <!--
        
        Right column
        
        -->
        <div id="columnright">
            <div class="rightblock">
                <asp:Panel ID="panel1" runat="server" CssClass="actionbuttons">
                    <Club:RolloverLink ID="AddBtn" runat="server" Text="Add new location" NavigateURL="Locations_Edit.aspx?Action=New" />
                </asp:Panel>
                <a href="Events_calendar.aspx">Events Month view</a> &nbsp; &nbsp; <a href="Events_list.aspx">
                    Events List view</a>
            </div>
            <div class="rightblock">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
                    SelectCommand="PagedLocationsList" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                    <SelectParameters>
                        <asp:ControlParameter Name="pageNum" ControlID="pn1" PropertyName="SelectedPage" />
                        <asp:Parameter DefaultValue="8" Name="pageSize" Type="Int32" />
                        <asp:Parameter Name="pageCount" Direction="ReturnValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="pn1" runat="server" DisplayedPages="7" CssClass="PageNumbers"
                        OnSelectedPageChanged="pn1_SelectedPageChanged" />
                </div>
                <div class="dashedline">
                </div>
                <!-- begin news item -->
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <div>
                            <%--<div class="thumbnail">
                                <a href='<%# "Locations_View.aspx?Locationid=" + Convert.ToString( Eval("ID"))%>'>
                                    <Club:ImageThumbnail ID="ImageThumbnail1" runat="server" PhotoID='<%# Eval("photo") %>'
                                        NoPhotoImg="images/map.jpg" />
                                </a>
                            </div>--%>
                            <asp:Panel ID="panel1" runat="server" CssClass="editbuttons" Visible='<%#IsAdmin %>'>
                                <Club:RolloverLink ID="EditBtn" runat="server" Text="Edit" NavigateURL='<%# "Locations_Edit.aspx?Action=Edit&LocationID=" + Convert.ToString(Eval("ID")) %>' />
                                <Club:RolloverLink ID="RemoveBtn" runat="server" Text="Remove" NavigateURL='<%# "Locations_Edit.aspx?Action=Remove&LocationID=" + Convert.ToString(Eval("ID")) %>' />
                            </asp:Panel>
                            <h3>
                                <a href='<%# "locations_view.aspx?locationid=" + Convert.ToString( Eval("ID"))%>'>
                                    <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' />
                                </a>
                            </h3>
                            <p>
                                <asp:Label ID="descriptionLabel" runat="server" Text='<%# SharedRoutines.truncate(Convert.ToString(Eval("description"))) %>' />
                                <a href='<%# "locations_view.aspx?locationid=" + Convert.ToString( Eval("ID"))%>'>read more &raquo;</a></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="dashedline">
                </div>
                <div class="newscrumbs">
                    Page:
                    <Club:PageNumberer ID="pn2" runat="server" DisplayedPages="7" CssClass="PageNumbers"
                        OnSelectedPageChanged="pn1_SelectedPageChanged" />
                </div>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
</asp:Content>
