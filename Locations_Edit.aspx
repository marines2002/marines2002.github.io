<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Edit News Article"
    ValidateRequest="false" %>

<%@ Import Namespace="System.Data" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>
<%@ Register TagPrefix="Club" TagName="Photopicker" Src="photos_formpicker.ascx" %>
<%@ Register TagPrefix="Club" TagName="Dateandtimepicker" Src="Dateandtimepicker.ascx" %>
<%@ Register TagPrefix="Club" TagName="PhotoAlbumPicker" Src="photoalbum_picker.ascx" %>

<script runat="server">
    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!IsPostBack)
        {
            object o = Request.QueryString["Action"];
            if (o != null)
            {
                string action = Convert.ToString(o).ToLower();
                if (action == "new")
                {
                    FormView1.ChangeMode(FormViewMode.Insert);
                }
                else if (action == "remove")
                {
                    SqlDataSource1.Delete();
                    Response.Redirect("locations_list.aspx");
                }
            }
        }
    }

    protected void FormView1_ItemUpdated(object sender, System.Web.UI.WebControls.FormViewUpdatedEventArgs e)
    {
        Response.Redirect("locations_view.aspx?locationID=" + e.Keys["id"].ToString());
    }

    protected void FormView1_ItemInserted(object sender, System.Web.UI.WebControls.FormViewInsertedEventArgs e)
    {
        Response.Redirect("locations_list.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <Club:LoginBanner ID="LoginBanner1" runat="server" />
        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="id"
            DefaultMode="Edit" Width="100%" OnItemUpdated="FormView1_ItemUpdated" OnItemInserted="FormView1_ItemInserted">
            <InsertItemTemplate>
                <div class="fullwidth">
                    <h3>
                        New Location</h3>
                    <div class="dashedline">
                    </div>
                    <div class="actionbuttons">
                        <Club:RolloverButton ID="GreenRolloverButton2" CommandName="Insert" Text="Save Location"
                            runat="server" />
                        <Club:RolloverLink ID="GreenRolloverLink1" Text="Cancel" runat="server" NavigateURL="locations_list.aspx" />
                    </div>
                    <div class="dashedline">
                    </div>
                    <table>
                        <tr>
                            <td class="formlabel">
                                Location Name:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="titleTextBox" runat="server" Width="500px" Text='<%# Bind("title") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Link:
                            </td>
                            <td align="left">
                                <asp:TextBox Text='<%# Bind("linkURL") %>' runat="server" ID="URLTextBox" Width="450px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                <asp:Label ID="Label1" runat="server" Text="Description:" />
                            </td>
                            <td align="left">
                                <asp:TextBox Text='<%# Bind("description") %>' runat="server" ID="descriptionTextBox"
                                    Rows="10" TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Address:
                            </td>
                            <td align="left">
                                <asp:TextBox Text='<%# Bind("Address") %>' runat="server" ID="TextBox1" Rows="10"
                                    TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Directions:
                            </td>
                            <td align="left">
                                <asp:TextBox Text='<%# Bind("directions") %>' runat="server" ID="TextBox2" Rows="10"
                                    TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Photo:</td>
                            <td align="left">
                                <Club:Photopicker ID="Photopicker1" runat="server" ImageId='<%# Bind("photo") %>' />
                            </td>
                        </tr>
                    </table>
                    <div class="dashedline">
                    </div>
                    <div class="actionbuttons">
                        <Club:RolloverButton ID="GreenRolloverButton3" CommandName="Insert" Text="Save Location"
                            runat="server" />
                        <Club:RolloverLink ID="GreenRolloverLink2" Text="Cancel" runat="server" NavigateURL="locations_list.aspx" />
                    </div>
                </div>
            </InsertItemTemplate>
            <EditItemTemplate>
                <div class="fullwidth">
                    <h3>
                        Edit Location</h3>
                    <div class="dashedline">
                    </div>
                    <div class="actionbuttons">
                        <Club:RolloverButton ID="GreenRolloverButton1" CommandName="Update" Text="Save Changes"
                            runat="server" />
                        <Club:RolloverLink ID="GreenRolloverLink3" Text="Cancel" runat="server" NavigateURL='<%# "Locations_view.aspx?LocationID=" + Convert.ToString(Eval("ID")) %>' />
                    </div>
                    <div class="dashedline">
                    </div>
                    <table>
                        <tr>
                            <td class="formlabel">
                                Location Name:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="titleTextBox" runat="server" Width="500px" Text='<%# Bind("title") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Link:
                            </td>
                            <td align="left">
                                <asp:TextBox Text='<%# Bind("linkURL") %>' runat="server" ID="linkURLTextBox" Width="450px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                <asp:Label ID="Label1" runat="server" Text="Description:" />
                            </td>
                            <td align="left">
                                <asp:TextBox Text='<%# Bind("description") %>' runat="server" ID="descriptionTextBox"
                                    Rows="10" TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Address:
                            </td>
                            <td align="left">
                                <asp:TextBox Text='<%# Bind("Address") %>' runat="server" ID="TextBox1" Rows="10"
                                    TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Directions:
                            </td>
                            <td align="left">
                                <asp:TextBox Text='<%# Bind("directions") %>' runat="server" ID="TextBox2" Rows="10"
                                    TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Photo:</td>
                            <td align="left">
                                <Club:Photopicker ID="Photopicker1" runat="server" ImageId='<%# Bind("photo") %>' />
                            </td>
                        </tr>
                    </table>
                    <div class="dashedline">
                    </div>
                    <div class="actionbuttons">
                        <Club:RolloverButton ID="apply1" CommandName="Update" Text="Save Changes" runat="server" />
                        <Club:RolloverLink ID="GreenRolloverLink4" Text="Cancel" runat="server" NavigateURL='<%# "Locations_view.aspx?LocationID=" + Convert.ToString(Eval("ID")) %>' />
                    </div>
                </div>
                </div>
            </EditItemTemplate>
        </asp:FormView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
        SelectCommand="SELECT id, title, description, linkURL, directions, photo, address FROM Locations where id=@id"
        InsertCommand="INSERT INTO Locations(title, description, linkURL, directions, photo, address) VALUES (@title, @description, @linkURL, @directions, @photo, @address)"
        UpdateCommand="UPDATE Locations SET title = @title, description = @description, linkURL = @linkurl, address = @address, photo = @photo, directions = @directions WHERE (id = @id)"
        OldValuesParameterFormatString="{0}" DeleteCommand="delete from locations where id=@id">
        <UpdateParameters>
            <asp:Parameter Name="title" />
            <asp:Parameter Name="description" />
            <asp:Parameter Name="linkurl" />
            <asp:Parameter Name="address" />
            <asp:Parameter Name="photo" />
            <asp:Parameter Name="directions" />
            <asp:Parameter Name="id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="title" />
            <asp:Parameter Name="description" />
            <asp:Parameter Name="linkURL" />
            <asp:Parameter Name="directions" />
            <asp:Parameter Name="photo" />
            <asp:Parameter Name="address" />
        </InsertParameters>
        <DeleteParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="LocationID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="LocationID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
