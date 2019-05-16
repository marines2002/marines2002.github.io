<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Untitled Page" Trace="false" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="ec" Namespace="ControlSample" Assembly="EventCalendar" %>

<script runat="server"> 
    protected void Page_Load(object sender, System.EventArgs e)
    {
        bool isAdmin = User.IsInRole("Administrators");
        panel1.Visible = isAdmin;
        panel2.Visible = isAdmin;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <div class="fullwidth">
            <h2>
                Events</h2>
            <br />
            If you have an Event you want to be added to our list please contact a site
            admin or email via the contacts page.
            <div class="dashedline">
            </div>
            <a href="Events_list.aspx">List view</a> &nbsp; &nbsp; <a href="Locations_list.aspx">
                Locations List</a>
        </div>
        <asp:Panel ID="panel1" runat="server" CssClass="fullwidth">
            <div class="actionbuttons">
                <Club:RolloverLink ID="Addbtn" runat="server" Text="Add New Event" NavigateURL="Events_edit.aspx?Action=New" />
            </div>
        </asp:Panel>
        <div class="eventmonth">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
                SelectCommand="SELECT [id], [starttime], [title], [description] FROM [Events]"></asp:SqlDataSource>
            <ec:EventCalendar runat="server" ID="eventscalendar" DataSourceID="sqldatasource1"
                BorderWidth="0" DayField="starttime" ShowTitle="true" CssClass="eventmonthtable">
                <DayHeaderStyle CssClass="caldays" />
                <DayStyle CssClass="calcurrentmonth" />
                <TodayDayStyle CssClass="calcurrentday" />
                <WeekendDayStyle CssClass="calweekend" />
                <OtherMonthDayStyle CssClass="calothermonth" />
                <DayNumberStyle CssClass="dayNumber" />
                <HeaderTemplate>
                    <table width="100%">
                        <tr align="center">
                            <td>
                                <asp:LinkButton ID="PrevMonth" runat="server" Text='<%# "&laquo; " + Container.PrevMonth.ToString("MMMM yyyy") %>'
                                    CommandName="PrevMonth" />
                            </td>
                            <td>
                                <h3>
                                    <asp:Label ID="label2" runat="server" Text='<%# Container.CurrentMonth.ToString("MMMM yyyy") %>' /></h3>
                            </td>
                            <td>
                                <asp:LinkButton ID="NextMonth" runat="server" Text='<%# Container.NextMonth.ToString("MMMM yyyy") + " &raquo;" %>'
                                    CommandName="NextMonth" />
                            </td>
                        </tr>
                    </table>
                    <div class="dashedline">
                    </div>
                </HeaderTemplate>
                <DayEventTemplate>
                    <div style="padding: 3px;">
                        <asp:HyperLink ID="HyperLink1" runat="server" Text='<%#Eval("title") %>' NavigateUrl='<%# "Events_view.aspx?Eventid=" + Convert.ToString(Eval("ID"))%>'
                            ToolTip='<%# SharedRoutines.truncate((string)Eval("description")) %>' /></div>
                </DayEventTemplate>
            </ec:EventCalendar>
        </div>
        <asp:Panel ID="panel2" runat="server" CssClass="fullwidth">
            <div class="actionbuttons">
                <Club:RolloverLink ID="GreenRolloverLink1" runat="server" Text="Add New Event"
                    NavigateURL="Events_edit.aspx?Action=New" />
            </div>
        </asp:Panel>
    </div>
    <Club:LoginBanner ID="LoginBanner1" runat="server" />
</asp:Content>
