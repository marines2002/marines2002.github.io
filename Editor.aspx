<%@ Page Title="" Language="C#" MasterPageFile="~/Default.master" AutoEventWireup="true" CodeFile="Editor.aspx.cs" Inherits="Location" ValidateRequest="false"%>
<%@ Register Src="tinyMCE.ascx" TagName="tinyMCE" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="body">
     <div class="fullwidth">
        <uc1:tinyMCE ID="TinyMCE1" runat="server" />
       <%-- <textarea id="elm1" name="elm1" rows="15" cols="80" style="width: 80%" runat="server"></textarea>--%>
    </div>
    <div class="fullwidth">
        <asp:Button ID="Button1" runat="server" Text="Button" onclick="Button1_Click" />
    </div>
    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    </div>
</asp:Content>

