﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Default.master" AutoEventWireup="true" CodeFile="GoogleConnect.aspx.cs" Inherits="GoogleConnect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<!-- Include the Google Friend Connect javascript library. -->
<script type="text/javascript" src="http://www.google.com/friendconnect/script/friendconnect.js"></script>
<!-- Define the div tag where the gadget will be inserted. -->
<div id="div-460174467284012689" style="width:276px;border:1px solid #cccccc;"></div>
<!-- Render the gadget into a div. -->
<script type="text/javascript">
var skin = {};
skin['BORDER_COLOR'] = '#cccccc';
skin['ENDCAP_BG_COLOR'] = '#e0ecff';
skin['ENDCAP_TEXT_COLOR'] = '#333333';
skin['ENDCAP_LINK_COLOR'] = '#0000cc';
skin['ALTERNATE_BG_COLOR'] = '#ffffff';
skin['CONTENT_BG_COLOR'] = '#ffffff';
skin['CONTENT_LINK_COLOR'] = '#0000cc';
skin['CONTENT_TEXT_COLOR'] = '#333333';
skin['CONTENT_SECONDARY_LINK_COLOR'] = '#7777cc';
skin['CONTENT_SECONDARY_TEXT_COLOR'] = '#666666';
skin['CONTENT_HEADLINE_COLOR'] = '#333333';
skin['NUMBER_ROWS'] = '4';
google.friendconnect.container.setParentUrl('/' /* location of rpc_relay.html and canvas.html */);
google.friendconnect.container.renderMembersGadget(
 { id: 'div-460174467284012689',
   site: '04912042841315730535' },
  skin);
</script>
<!-- Include the Google Friend Connect javascript library. -->
<script type="text/javascript" src="http://www.google.com/friendconnect/script/friendconnect.js"></script>
<!-- Define the div tag where the gadget will be inserted. -->
<div id="div1"></div>
<!-- Render the gadget into a div. -->
<script type="text/javascript">
    var skin = {};
    skin['BORDER_COLOR'] = '#cccccc';
    skin['ENDCAP_BG_COLOR'] = '#e0ecff';
    skin['ENDCAP_TEXT_COLOR'] = '#333333';
    skin['ENDCAP_LINK_COLOR'] = '#0000cc';
    skin['ALTERNATE_BG_COLOR'] = '#ffffff';
    skin['CONTENT_BG_COLOR'] = '#ffffff';
    skin['CONTENT_LINK_COLOR'] = '#0000cc';
    skin['CONTENT_TEXT_COLOR'] = '#333333';
    skin['CONTENT_SECONDARY_LINK_COLOR'] = '#7777cc';
    skin['CONTENT_SECONDARY_TEXT_COLOR'] = '#666666';
    skin['CONTENT_HEADLINE_COLOR'] = '#333333';
    skin['POSITION'] = 'top';
    skin['DEFAULT_COMMENT_TEXT'] = '- add your comment here -';
    skin['HEADER_TEXT'] = 'Comments';
    google.friendconnect.container.setParentUrl('/' /* location of rpc_relay.html and canvas.html */);
    google.friendconnect.container.renderSocialBar(
 { id: 'div-5929775763297486525',
     site: '04912042841315730535',
     'view-params': { "scope": "SITE", "allowAnonymousPost": "true", "features": "video,comment", "showWall": "true" }
 },
  skin);
</script>


</asp:Content>

