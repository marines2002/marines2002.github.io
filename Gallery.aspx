<%@ Page Language="c#" MasterPageFile="~/Default.master" Title="Restuarants in Cornwall" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link type="text/css" href="pikachoose/styles/bottom.css" rel="stylesheet" />
    <script type="text/javascript" src=" https://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.js"></script>
    <script type="text/javascript" src="pikachoose/lib/jquery.jcarousel.min.js"></script>
    <script type="text/javascript" src="pikachoose/lib/jquery.pikachoose.js"></script>
    <script language="javascript">
    $(document).ready(
				function () {
				    $("#pikame").PikaChoose({ carousel: true });
				});
		</script>
    
    <div id="body">
     <div class="fullwidth">
     <h2>Gallery</h2> 
        <div class="pikachoose">
        Around Duloe
	        <ul id="pikame" class="jcarousel-skin-pika">
		        <li><img src="pikachoose/duloe1.jpg"/><span>Stone Circle Sunset</span></li>
		        <li><img src="pikachoose/duloe2.jpg"/><span>War Memorial Sunset</span></li>
		        <li><img src="pikachoose/duloe3.jpg"/><span>Around Duloe check out <a href="https://www.facebook.com/media/set/?set=a.107277805993457.16911.107272015994036&type=3">facebook gallery</a> for more pictures</span></li>
		        <li><img src="pikachoose/duloe4.jpg"/><span>Snowy Duloe check out <a href="https://www.facebook.com/media/set/?set=a.139554892765748.32722.107272015994036&type=3">facebook gallery</a> for more pictures</span>></li>
		        <li><img src="pikachoose/duloe5.jpg"/><span>Duloe High Street</span></li>
	        </ul>
       </div>
    </div>
</div>
</asp:Content>
