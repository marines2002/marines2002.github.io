<%@ Page Language="c#" MasterPageFile="~/Default.master" Title="Restuarants in Cornwall" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="XmlAd" Src="xmlad.ascx" %>
<script runat="server">

    string ShowDuration(object starttime, object endtime)
    {
        System.DateTime starttimeDT = (DateTime)starttime;
        if (endtime != null && endtime != DBNull.Value)
        {
            System.DateTime endtimeDT = (DateTime)endtime;
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
                return "thru " + endtimeDT.ToString("d");
            }
        }
        else
        {
            return starttimeDT.ToString("h:mm tt");
        }
    }

    void logout_click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        
    } 
    
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <!--Start of left column-->
        <div id="columnleft">
            <a name="content_start" id="content_start"></a>
              <div class="leftblock">
            <Club:XmlAd ID="XmlAd" runat="server" />
            </div>
            <%--<div class="leftblock">
            
            <a href="beerfestival.aspx" target="_blank"><h3>Duloe Ale and Cider Festival</h3></a>
            
                        </div>--%>
                         <div class="leftblock">
            
           <h3>Duloe Community Shop now open</h3>
                   <br />
                   8 - 1 Mon to Sat and 3 - 5 Mon to Fri.<br />
                   newspapers fresh bread, milk, vegetables local produce etc...

            
           </div>
                        <div class="leftblock">
            
            <a and fri.target="_blank" href="http://www.facebook.com/#!/pages/Duloe-Cornwall/107272015994036"
                mon="" mon="" sat="" to="" to=""><img src="images\facebook.png" alt="duloe on facebook"/></a><h3>Follow us on Facebook</h3> 
            
                        </div>
            <div class="leftblock">
                <h2>Welcome to Duloe</h2>
                <p>
                    This site is intended to keep villagers and visitors up to date
                    with whats going on in and around Duloe. If you have anything you would like
                    to add or see on the site then please don't hesitate to contact us via the
                    <a href="contact.aspx"> <b>Contact</b></a> page<br /></p>
                    
                      <p>
                    Duloe (Cornish: Dewlogh) a village twixt Liskeard and Looe, in Cornwall, supposedly so named because it lies 
                    between the two Looe rivers. For more info on the history of Duloe <a href="backalongduloe.aspx"> <b> click here</b></a><br /></p></p>
                    
                     <h3 >Links</h3>
            <ul class="list-of-links">
            <li><a href="location.aspx">Location Search</a></li>
            <li><a href="http://www.pol.ac.uk/ntslf/tides/?port=0002" target="_blank"> Tide Times</a></li>
            <li><a href="http://www.piratefm.co.uk/" target="_blank"> Pirate FM</a></li>
            <li><a href="http://www.atlantic.fm/" target="_blank"> Atlantic FM</a></li>
            <li><a href="http://www.bbc.co.uk/cornwall/local_radio/" target="_blank"> BBC Radio Cornwall</a></li>
            <li><a href="http://www.cornwall.gov.uk/" target="_blank"> Cornwall County Council</a></li>
            <li><a href="http://www.visitcornwall.com" target="_blank">Visit Cornwall</a></li>
            </ul>
            <br />
            <br />
            <h3 >Stone Circle News</h3>
            <a href="stonecirclenews/2009April.pdf">April 2009 Edition</a>
            <br />
            <br />
            (if you haven't got a pdf reader you can download one here 
            <a href="http://get.adobe.com/uk/reader/"> Adobe pdf reader</a>)
             </div>
             
             <div class="leftblock">
             
  <div id="newsBar-bar">
    <span style="color:#676767;font-size:11px;margin:10px;padding:4px;">Loading...</span>
  </div>
  <script src="http://www.google.com/uds/api?file=uds.js&v=1.0&source=uds-nbw"
    type="text/javascript"></script>
  <style type="text/css">
    @import url("http://www.google.com/uds/css/gsearch.css");
  </style>
 
  <!-- News Bar Code and Stylesheet -->
  <script type="text/javascript">
    window._uds_nbw_donotrepair = true;
  </script>
  <script src="http://www.google.com/uds/solutions/newsbar/gsnewsbar.js?mode=new"
    type="text/javascript"></script>
  <style type="text/css">
    @import url("http://www.google.com/uds/solutions/newsbar/gsnewsbar.css");
  </style>
 
  <script type="text/javascript">
    function LoadNewsBar() {
      var newsBar;
      var options = {
        largeResultSet : true,
        title : "More News",
        horizontal : false,
        autoExecuteList : {
          executeList : ["cornwall uk"]
        }
      }
      newsBar = new GSnewsBar(document.getElementById("newsBar-bar"), options);
    }
    GSearch.setOnLoadCallback(LoadNewsBar);
  </script>
             </div>
            
        </div>
        <!--end columnleft-->
        <!--Start of right column-->
        <div id="columnright">
            <!-- Start of news list functionality -->
            <div class="rightblock">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
                    SelectCommand="SELECT top 5 Events.id, Events.starttime, events.endtime, Events.title, Locations.title AS locationname FROM Events LEFT OUTER JOIN Locations ON Events.location = Locations.id WHERE     (Events.starttime > GETDATE()) ORDER BY Events.starttime, events.id ">
                </asp:SqlDataSource>
                <h2>Forthcoming Events</h2>
                <div class="dashedline">
                </div>
                <asp:GridView AutoGenerateColumns="False" DataSourceID="SqlDataSource2" ID="GridView1"
                    runat="server" ShowHeader="False" Width="410px" CssClass="eventlist" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="starttime" DataFormatString="{0:d}" HeaderText="starttime"
                            SortExpression="starttime"></asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%--<asp:HyperLink ImageUrl="images/icon_event.gif" runat="server" NavigateUrl='<%# Eval("id","Events_download.ashx?Eventid={0}") %>' />
                           --%> </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="id" InsertVisible="False" SortExpression="id">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# ShowDuration(Eval("starttime"),Eval("endtime")) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:HyperLinkField DataNavigateUrlFields="id" DataNavigateUrlFormatString="events_view.aspx?eventid={0}"
                            DataTextField="title"></asp:HyperLinkField>
                        <asp:BoundField DataField="locationname" HeaderText="locationname" SortExpression="locationname"
                            NullDisplayText=""></asp:BoundField>
                    </Columns>
                </asp:GridView>
                <div class="dashedline">
                </div>
                <a href="Events_list.aspx">View all events &raquo;</a>
            </div>
            <div class="rightblock">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ProviderName="System.Data.SqlClient"
                    ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>" SelectCommand="SELECT top 5 [id], [itemdate], [title], [description], [photo] FROM [Announcements] order by itemdate desc">
                </asp:SqlDataSource>
                <h2>
                    Recent Village News</h2>
                <div class="dashedline">
                </div>
                <asp:Repeater ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <div class="listitem">
                            <div class="thumbnail">
                                <a href='<%# "News_View.aspx?Articleid=" + Convert.ToString(Eval("ID"))%>'>
                                    <Club:ImageThumbnail ID="ImageThumbnail2" runat="server" PhotoID='<%# Eval("photo") %>'
                                        NoPhotoImg="images/news.jpg" />
                                </a>
                            </div>
                            <h3>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("itemdate","{0:d}") %>' />
                                &nbsp;&nbsp;&nbsp;&nbsp; <a href='<%# "News_View.aspx?Articleid=" + Convert.ToString(Eval("ID"))%>'>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("title") %>' />
                                </a>
                            </h3>
                            <p>
                                <asp:Label ID="Label2" runat="server" Text='<%# SharedRoutines.truncate((string)Eval("description")) %>' />
                                <a href='<%# "News_View.aspx?Articleid=" + Convert.ToString(Eval("ID")) %>'>read more &raquo;</a>
                            </p>
                            <div class="clearlist"></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="dashedline">
                </div>
                <a href="news_list.aspx">Read all news articles &raquo;</a>
            </div>
          
            <div class="rightblock">
             <h2>Local Weather</h2>
             <br/>
            <iframe src="http://news.bbc.co.uk/weather/forecast/2106/Next3DaysEmbed.xhtml?target=_parent" width="306" height="400" frameborder="0">
            You must have a browser that supports iframes to view the BBC weather forecast</iframe>
            </div>
        </div>
        <div class="clear2column"></div>
    </div>
</asp:Content>
