<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Edit Events" ValidateRequest="false" %>

<%@ Import Namespace="System.Data" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>
<%@ Register TagPrefix="Club" TagName="Photopicker" Src="photos_formpicker.ascx" %>
<%@ Register TagPrefix="Club" TagName="Durationpicker" Src="Durationpicker.ascx" %>
<%@ Register TagPrefix="Club" TagName="Locationpicker" Src="Locations_picker.ascx" %>
<%@ Register TagPrefix="uc1"  TagName="tinyMCE" Src="tinyMCE.ascx" %>

<script runat="server">

    const int INVALIDID = -1;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!IsPostBack)
        {
            object o = Request.QueryString["Action"];
            if (o != null)
            {
                string action = System.Convert.ToString(o).ToLower();
                if (action == "new")
                {
                    FormView1.ChangeMode(FormViewMode.Insert);
                    LocationsPicker lp = (LocationsPicker)(FormView1.FindControl("LocationPicker1"));
                    lp.LocationID = null;
                    DurationPicker dp = (DurationPicker)(FormView1.FindControl("dtpicker"));
                    dp.startDateTime = DateTime.Now;
                    dp.endDateTime = DateTime.Now.AddHours(3);
                    TextBox slp = (TextBox)(FormView1.FindControl("staticURLTextBox"));
                    slp.Enabled = false;
                }
                else if (action == "delete")
                {
                    SqlDataSource1.Delete();
                    Response.Redirect("Events_list.aspx");
                }
                else
                {
                    CheckBox cb = (CheckBox)(FormView1.FindControl("CheckBox1"));
                    TextBox surl = (TextBox)(FormView1.FindControl("staticURLTextBox"));
                    if (surl.Text != null && surl.Text != "")
                    {
                        cb.Checked = true;
                        surl.Enabled = true;
                    }
                    else
                    {
                        surl.Enabled = false;
                    }
                }
            }
        }
    }

    protected void FormView1_ItemUpdated(object sender, System.Web.UI.WebControls.FormViewUpdatedEventArgs e)
    {
        Response.Redirect("events_view.aspx?eventID=" + e.Keys["id"].ToString());
    }

    protected void FormView1_ItemInserted(object sender, System.Web.UI.WebControls.FormViewInsertedEventArgs e)
    {
        Response.Redirect("events_list.aspx");
    }

    protected void CheckBox1_CheckedChanged(object sender, System.EventArgs e)
    {
        CheckBox cb = (CheckBox)(FormView1.FindControl("CheckBox1"));
        TextBox surl = (TextBox)(FormView1.FindControl("StaticURLTextBox"));
        if (cb.Checked)
        {
            surl.Enabled = true;
        }
        else
        {
            surl.Enabled = false;
        }
    }  
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
        <div class="actionbuttons">
            <Club:RolloverLink ID="Logoutbtn" runat="server" Text="Add New Event" OnClientClick="foo"
                NavigateURL="Event_edit.aspx?Action=New" />
        </div>
        <div class="fullwidth">
            <h3>
                Event Details</h3>
            <div class="dashedline">
            </div>
            <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="id"
                DefaultMode="Edit" OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated"
                Width="100%">
                <InsertItemTemplate>
                    <div class="actionbuttons">
                        <Club:RolloverButton ID="GreenRolloverButton2" CommandName="Insert" Text="Add Event"
                            runat="server" />
                        <Club:RolloverLink ID="GreenRolloverLink1" Text="Cancel" runat="server" NavigateURL='<%# "Events_view.aspx?EventID=" + Convert.ToString(Eval("ID")) %>' />
                    </div>
                    <div class="dashedline">
                    </div>
                    <table>
                        <tr>
                            <td class="formlabel">
                                Event Heading:
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
                                <asp:CheckBox ID="CheckBox1" runat="server" Text="Use a link instead of inline content for this anouncement:" /><br />
                                Link:
                                <asp:TextBox Text='<%# Bind("staticURL") %>' runat="server" ID="staticURLTextBox"
                                    Width="450px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Location:
                            </td>
                            <td align="left">
                                <Club:Locationpicker ID="LocationPicker1" runat="server" LocationID='<%# Bind("location")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                <asp:Label ID="Label1" runat="server" Text="Description:" />
                            </td>
                            <td align="left">
                             <uc1:tinyMCE ID="TinyMCE1" Text='<%# Bind("description") %>' runat="server" Width="350px" Height="166px"/>
                            
                               <%-- <asp:TextBox Text='<%# Bind("description") %>' runat="server" ID="descriptionTextBox"
                                    Rows="10" TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Event Date:</td>
                            <td align="left">
                                <Club:Durationpicker ID="dtpicker" runat="server" startDateTime='<%#Bind("Starttime") %>'
                                    enddatetime='<%#Bind("endtime") %>' />
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
                        <Club:RolloverButton ID="apply1" CommandName="Insert" Text="Add Event" runat="server" />
                        <Club:RolloverLink ID="Cancel" Text="Cancel" runat="server" NavigateURL='<%# "Events_view.aspx?EventID=" + Convert.ToString(Eval("ID")) %>' />
                    </div>
                </InsertItemTemplate>
                <EditItemTemplate>
                    <div class="actionbuttons">
                        <Club:RolloverButton ID="GreenRolloverButton1" CommandName="Update" Text="Apply Changes"
                            runat="server" />
                        <Club:RolloverLink ID="GreenRolloverLink1" Text="Cancel" runat="server" NavigateURL='<%# "Events_view.aspx?EventID=" + Convert.ToString(Eval("ID")) %>' />
                    </div>
                    <div class="dashedline">
                    </div>
                    <table>
                        <tr>
                            <td class="formlabel">
                                Event Heading:
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
                                <asp:CheckBox ID="CheckBox1" runat="server" Text="Use a link instead of inline content for this anouncement:" /><br />
                                Link:
                                <asp:TextBox Text='<%# Bind("staticURL") %>' runat="server" ID="staticURLTextBox"
                                    Width="450px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Location:
                            </td>
                            <td align="left">
                                <Club:Locationpicker ID="LocationPicker1" runat="server" LocationID='<%# Bind("location")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                <asp:Label ID="Label1" runat="server" Text="Description:" />
                            </td>
                            <td align="left">
                             <uc1:tinyMCE ID="TinyMCE1" Text='<%# Bind("description") %>' runat="server" Width="350px" Height="166px"/>
                            <%--
                                <asp:TextBox Text='<%# Bind("description") %>' runat="server" ID="descriptionTextBox"
                                    Rows="10" TextMode="MultiLine" Width="500px" Height="166px"></asp:TextBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                Event Date:</td>
                            <td align="left">
                                <Club:Durationpicker ID="dtpicker" runat="server" startDateTime='<%#Bind("Starttime") %>'
                                    endDateTime='<%#Bind("endtime") %>' />
                            </td>
                        </tr>
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
                        <Club:RolloverButton ID="apply1" CommandName="Update" Text="Apply Changes" runat="server" />
                        <Club:RolloverLink ID="Cancel" Text="Cancel" runat="server" NavigateURL='<%# "Events_view.aspx?EventID=" + Convert.ToString(Eval("ID")) %>' />
                    </div>
                </EditItemTemplate>
            </asp:FormView>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
        SelectCommand="SELECT Events.id, Events.starttime, events.endtime, Events.title, Events.description, Events.staticURL, Events.photo,  Events.location, Locations.title AS locationname FROM  Events LEFT OUTER JOIN Locations ON Events.location = Locations.id where Events.id=@id"
        InsertCommand="INSERT INTO Events(starttime, endtime, title, description, staticURL, location, photo) VALUES (@starttime, @endtime,  @title, @description, @staticURL, @location, @photo)"
        UpdateCommand="UPDATE Events SET starttime = @starttime, endtime=@endtime, title = @title, description = @description, staticURL = @staticURL, location = @location, photo = @photo WHERE (id = @id)"
        DeleteCommand="DELETE Events WHERE id=@id" OldValuesParameterFormatString="{0}">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="starttime" Type="DateTime" />
            <asp:Parameter Name="endtime" Type="DateTime" />
            <asp:Parameter Name="title" />
            <asp:Parameter Name="description" />
            <asp:Parameter Name="staticURL" />
            <asp:Parameter Name="location" />
            <asp:Parameter Name="photo" />
            <asp:Parameter Name="id" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="starttime" Type="DateTime" />
            <asp:Parameter Name="endtime" Type="DateTime" />
            <asp:Parameter Name="title" />
            <asp:Parameter Name="description" />
            <asp:Parameter Name="staticURL" />
            <asp:Parameter Name="location" />
            <asp:Parameter Name="photo" />
            <asp:Parameter Name="id" />
        </InsertParameters>
        <DeleteParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="ID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    
</asp:Content>
