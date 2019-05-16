<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Untitled Page" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">

    private int nextEventID;
    private int prevEventID;
    const int INVALIDID = -1;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        SqlDataSource1.SelectParameters["id"].DefaultValue = System.Convert.ToString(EventID);
    }

    protected void NextButton_Click(object sender, System.EventArgs e)
    {
        InitValsFromSql(EventID);
        if (nextEventID != INVALIDID)
        {
            prevEventID = EventID;
            EventID = nextEventID;
            SqlDataSource1.SelectParameters["id"].DefaultValue = System.Convert.ToString(nextEventID);
        }
        ToggleLinks();
    }

    protected void PrevButton_Click(object sender, System.EventArgs e)
    {
        InitValsFromSql(EventID);
        if (prevEventID != INVALIDID)
        {
            nextEventID = EventID;
            EventID = prevEventID;
            SqlDataSource1.SelectParameters["id"].DefaultValue = System.Convert.ToString(prevEventID);
        }
        ToggleLinks();
    }

    void ToggleLinks()
    {
        LinkButton1.Enabled = (nextEventID != INVALIDID);
        LinkButton3.Enabled = (nextEventID != INVALIDID);
        LinkButton2.Enabled = (prevEventID != INVALIDID);
        LinkButton4.Enabled = (prevEventID != INVALIDID);
    }

    int EventID
    {
        get
        {
            int m_EventID;
            object id = ViewState["EventID"];
            if (id != null)
            {
                m_EventID = (int)id;
            }
            else
            {
                id = Request.QueryString["EventID"];
                if (id != null)
                {
                    m_EventID = System.Convert.ToInt32(id);
                }
                else
                {
                    m_EventID = 1;
                }
                ViewState["EventID"] = m_EventID;
            }
            return m_EventID;
        }
        set
        {
            ViewState["EventID"] = value;
        }
    }

    void InitValsFromSql(int EventID)
    {
        try
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ClubSiteDB"].ConnectionString);
            SqlCommand command = new SqlCommand("NextPrevEvent", connection);
            
            SqlParameter param0 = new SqlParameter("@id", EventID);
            SqlParameter param1 = new SqlParameter("@previd", INVALIDID);
            SqlParameter param2 = new SqlParameter("@nextid", INVALIDID);
            
            param1.Direction = ParameterDirection.InputOutput;
            param2.Direction = ParameterDirection.InputOutput;
            
            command.Parameters.Add(param0);
            command.Parameters.Add(param1);
            command.Parameters.Add(param2);
            
            command.CommandType = CommandType.StoredProcedure;
            connection.Open();
            command.ExecuteNonQuery();
            
            if (param1.Value != null && param1.Value != DBNull.Value)
            {
                prevEventID = (int) param1.Value;
            }
            else
            {
                prevEventID = INVALIDID;
            }
            
            if (param2.Value != null && param2.Value != DBNull.Value)
            {
                nextEventID = (int) param2.Value;
            }
            else
            {
                nextEventID = INVALIDID;
            }
            connection.Close();
        }
        catch
        {
            prevEventID = INVALIDID;
            nextEventID = INVALIDID;
        }
    }

    protected void FormView1_DataBound(object sender, System.EventArgs e)
    {
        DataRowView view = (DataRowView)(FormView1.DataItem);
        object o = view["staticURL"];
        if (o != null && o!= DBNull.Value)
        {
            string staticurl = (string)o;
            if (staticurl != "")
            {
                Response.Redirect(staticurl);
            }
        }
    }

    string ShowLocationLink(object locationname, object id)
    {
        if (id != null && id!= DBNull.Value)
        {
            return "At <a href='Locations_view.aspx?LocationID=" + Convert.ToString(id) + "'>" + (string)locationname + "</a><br/>";
        }
        else
        {
            return "";
        }
    }

    string ShowDuration(object starttime, object endtime)
    {
        DateTime starttimeDT = (DateTime)starttime;
        if (endtime != null && endtime!= DBNull.Value)
        {
           DateTime endtimeDT = (DateTime)endtime;
            if (starttimeDT.Date == endtimeDT.Date)
            {
                if (starttimeDT == endtimeDT)
                {
                    return starttimeDT.ToString("h:mm tt");
                }
                else
                {
                    return starttimeDT.ToString("h:mm tt") + " - " + endtimeDT.ToString("h:mm tt");
                }
            }
            else
            {
                return "thru " + endtimeDT.ToString("M/d/yy");
            }
        }
        else
        {
            return starttimeDT.ToString("h:mm tt");
        }
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
                    Events</h2>
                <p>
                    If you have an Event you want to be added to our list please contact a site
            admin or email via the <a href="contact.aspx"> <b>Contact</b></a> page</p>
            </div>
        </div>
        <!--
        
        Right column
        
        -->
        <div id="columnright">
            <div class="rightblock">
                <a href="Events_calendar.aspx">month view</a> <a href="Events_list.aspx">list view</a></div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
                SelectCommand="SELECT Events.id, Events.starttime, events.endtime, Events.title, Events.description, Events.staticURL, Events.photo, Events.Album,  Events.location, Locations.title AS locationname FROM  Events LEFT OUTER JOIN Locations ON Events.location = Locations.id where Events.id=@id">
                <SelectParameters>
                    <asp:Parameter Type="Int32" DefaultValue="1" Name="id"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <div class="rightblock">
                <div class="nextlink">
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="NextButton_Click">next event &raquo;</asp:LinkButton>
                </div>
                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="PrevButton_Click">&laquo; previous event</asp:LinkButton>
                <div class="dashedline">
                </div>
                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="id"
                    AllowPaging="false" Width="100%">
                    <ItemTemplate>
                        <h2>
                            <asp:Label Text='<%# Eval("title") %>' runat="server" ID="titleLabel" />
                        </h2>
                        <div class="itemdetails">
                            <br />
                            location:
                            <h3>
                                <asp:Label ID="locationLabel" runat="server" Text='<%# ShowLocationLink(Eval("locationname"),Eval("location")) %>' />
                            </h3>
                            <p>
                                <asp:Label Text='<%# Eval("starttime","{0:D}") %>' runat="server" ID="itemdateLabel" />
                                <br />
                                <asp:Label Text='<%# ShowDuration(Eval("starttime"),Eval("endtime")) %>' runat="server"
                                    ID="Label1" />
                            </p>
                        </div>
                       <%-- <div class="downloadevent">
                            <a href="#">
                                <img src="images/icon_download_event.gif" alt="Download this event to your personal calendar"
                                    width="15" height="26" /></a><a href='<%# "events_download.ashx?EventID=" + Convert.ToString(Eval("id")) %>'>Add
                                        this event to your personal calendar</a></div>--%>
                        <Club:ImageThumbnail ID="thumb1" runat="server" ImageSize="Large" PhotoID='<%# Eval("photo") %>' />
                        <p>
                            <asp:Label Text='<%# Eval("description") %>' runat="server" ID="descriptionLabel" />
                        </p>
                        <asp:Panel ID="panel1" runat="server" CssClass="actionbuttons" Visible='<%#User.IsInRole("Administrators") %>'>
                            <Club:RolloverLink ID="EditBtn" runat="server" Text="Edit" NavigateURL='<%# "Events_edit.aspx?id=" + Convert.ToString(Eval("id")) %>' />
                        </asp:Panel>
                    </ItemTemplate>
                </asp:FormView>
                <div class="dashedline">
                </div>
                <div class="nextlink">
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="NextButton_Click">next event &raquo;</asp:LinkButton>
                </div>
                <asp:LinkButton ID="LinkButton4" runat="server" OnClick="PrevButton_Click">&laquo; previous event</asp:LinkButton>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
</asp:Content>
