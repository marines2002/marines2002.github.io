<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Untitled Page" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>

<script runat="server">
    string privatelabel(bool isprivate)
    {
        return (isprivate) ? "Album is private" : "Album is not private";
    }

    protected void SqlDataSource1_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            e.Command.Parameters["@ownerid"].Value = Membership.GetUser().ProviderUserKey;
        }
        else
        {
            throw new Exception("User must be authenticated to create an album");
        }
    }

    protected void SqlDataSource1_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        Response.Redirect("photoalbum_list.aspx");
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
                    Photo Albums</h2>
                <p>
                    Add New Albums Here.</p>
            </div>
        </div>
        <!--
        
        Right column
        
        -->
        <div id="columnright">
            <div class="rightblock">
                <h2>
                    Add new Album</h2>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubsiteDB %>"
                    SelectCommand="SELECT title, ownerid, private FROM albums WHERE (albumid = @albumid)"
                    InsertCommand="INSERT INTO Albums(title, parentid, ownerid, private) VALUES (@title, @parentid, @ownerid, @private)"
                    OldValuesParameterFormatString="{0}" OnInserting="SqlDataSource1_Inserting" OnInserted="SqlDataSource1_Inserted">
                    <SelectParameters>
                        <asp:Parameter Name="albumid" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="title" />
                        <asp:Parameter Name="parentid" DefaultValue="0" />
                        <asp:Parameter Name="ownerid" />
                        <asp:Parameter Name="private" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:FormView ID="FormView1" runat="server" DataSourceID="Sqldatasource1" Width="445px"
                    DefaultMode="Insert">
                    <InsertItemTemplate>
                        <table>
                            <tr>
                                <td>
                                    Album Name</td>
                                <td>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("title") %>' /></td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Text="Album is private and non visible to other users"
                                        Checked='<%#Bind("Private") %>' /></td>
                            </tr>
                        </table>
                        <div style="text-align: right">
                            <Club:RolloverButton ID="GreenRolloverButton2" CommandName="Insert" Text="Add Album"
                                runat="server" />
                            <Club:RolloverButton ID="GreenRolloverButton3" CommandName="Cancel" Text="Cancel"
                                runat="server" />
                        </div>
                    </InsertItemTemplate>
                </asp:FormView>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
</asp:Content>
