<%@ Page Language="C#" MasterPageFile="~/Default.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>
<%@ Register TagPrefix="Club" TagName="XmlAd" Src="xmlad.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="fb-root"></div>
<script>
    window.fbAsyncInit = function () {
        // init the FB JS SDK
        FB.init({
            appId: '536879599656407', // App ID from the App Dashboard
            status: true, // check the login status upon init?
            cookie: true, // set sessions cookies to allow your server to access the session?
            xfbml: true  // parse XFBML tags on this page?
        });

        // Additional initialization code such as adding Event Listeners goes here

    };

    (function (d, debug) {
        var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement('script'); js.id = id; js.async = true;
        js.src = "//connect.facebook.net/en_US/all" + (debug ? "/debug" : "") + ".js";
        ref.parentNode.insertBefore(js, ref);
    } (document, /*debug*/false));

    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=536879599656407";
        fjs.parentNode.insertBefore(js, fjs);
    } (document, 'script', 'facebook-jssdk'));
</script>
    <div id="body">

        <!--Start of left column-->
        <div id="columnleft">
            <a name="content_start" id="content_start"></a>
              <div class="leftblock">
            <Club:XmlAd ID="XmlAd" runat="server" />
            </div>
          <div class="leftblock">
            
           <h3>Duloe Community Shop now open</h3>
           <a href="images\duloeshop10_09_12.jpg" target="_blank">More Details...</a>
                   

            
           </div>
            <div class="leftblock">
            <script charset="utf-8" src="http://widgets.twimg.com/j/2/widget.js"></script>
<script>
    new TWTR.Widget({
        version: 2,
        type: 'profile',
        rpp: 4,
        interval: 30000,
        width: 210,
        height: 300,
        theme: {
            shell: {
                background: '#99c87a',
                color: '#141314'
            },
            tweets: {
                background: '#99c87a',
                color: '#171517',
                links: '#545752'
            }
        },
        features: {
            scrollbar: false,
            loop: false,
            live: false,
            behavior: 'all'
        }
    }).render().setUser('duloeshop').start();
</script>
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
                    between the two Looe rivers.<br /></p></p>
                    
                     <h3 >Links</h3>
            <ul class="list-of-links">
            <li><a href="location.aspx">Location Search</a></li>
            <li><a href="http://www.pol.ac.uk/ntslf/tides/?port=0002" target="_blank"> Tide Times</a></li>
            <li><a href="http://www.piratefm.co.uk/" target="_blank"> Pirate FM</a></li>
            <li><a href="http://www.bbc.co.uk/cornwall/local_radio/" target="_blank"> BBC Radio Cornwall</a></li>
            <li><a href="http://www.cornwall.gov.uk/" target="_blank"> Cornwall County Council</a></li>
            <li><a href="http://www.visitcornwall.com" target="_blank">Visit Cornwall</a></li>
            </ul>
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
              largeResultSet: true,
              title: "More News",
              horizontal: false,
              autoExecuteList: {
                  executeList: ["cornwall uk"]
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

           <div class="rightblock">
               <%-- <h2>Wosson</h2>
                
            <asp:Repeater id="eventRepeater" runat="server">
                                               
                        <ItemTemplate>
                            <div class="innerTitle">
                             <a href="<%# String.Format("https://www.facebook.com/events/{0}", DataBinder.Eval(Container.DataItem, "Id")) %>"><%#DataBinder.Eval(Container.DataItem, "Name")%> </a>
                             <img  class="textWrap" src="<%#DataBinder.Eval(Container.DataItem, "Picture")%>" alt="east cornwall events" height="30" width="30">
                             <br/>
                             </div>
                            <div class="innerContent">
                            
                             on <%#DataBinder.Eval(Container.DataItem, "Start_time", "{0:d/M/yyyy hh:mm tt}" )%> 
                         
                             @ <%#DataBinder.Eval(Container.DataItem, "Location")%> 
                             <br/>
                             <br/>
                             </div>
                        </ItemTemplate>
                        
            </asp:Repeater>--%>
            </div>
            <div class="rightblock">
                <h2>
                    Recent Village News</h2>
                <br/>
                    <div class="fb-like-box" data-href="http://www.facebook.com/duloe" data-width="400" data-show-faces="true" data-stream="true" data-header="true" force-wall="true"></div>
                    <div class="dashedline">
                </div>
                <div class="dashedline">
                </div>
             </div>
          
            <div class="rightblock">
             <h2>Local Weather</h2>
             <br/>
            <iframe src="http://news.bbc.co.uk/weather/forecast/2106/Next3DaysEmbed.xhtml?target=_parent" width="306" height="400" frameborder="0">
             You must have a browser that supports iframes to view the BBC weather forecast</iframe>
            </div>
        </div>
        <div class="clear2column"><a href="http://www.beltferragamo.com/">Belt Ferragamo</a></div>
    </div>
</asp:Content>

