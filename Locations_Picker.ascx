<%@ Control Language="C#" ClassName="LocationsPicker" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>

<script runat="server">

    protected void locationselect_SelectedIndexChanged(object sender, System.EventArgs e)
    {
        int value = Convert.ToInt32(locationselect.SelectedValue);
        if (value == 0)
        {
            FormView1.Visible = false;
        }
        else
        {
            FormView1.ChangeMode(FormViewMode.ReadOnly);
            FormView1.PageIndex = locationselect.SelectedIndex - 1;
            FormView1.Visible = true;
        }
    }

    public object LocationID
    {
        get
        {
            object o = locationselect.SelectedValue;
            if (o != null && (string)o != "")
            {
                int val = System.Convert.ToInt32(o);
                if (val > 0)
                {
                    return val;
                }
            }
            return DBNull.Value;
        }
        set
        {
            if (value == null || value == DBNull.Value)
            {
                FormView1.Visible = false;
                locationselect.SelectedIndex = 0;
            }
            else
            {
                locationselect.DataBind();
                locationselect.SelectedValue = Convert.ToString(value);
                FormView1.PageIndex = locationselect.SelectedIndex - 1;
                FormView1.Visible = true;
            }
        }
    }

    protected void locationselect_DataBinding(object sender, System.EventArgs e)
    {
        locationselect.Items.Clear();
        locationselect.Items.Add(new ListItem("No location Selected", "0"));
    }

</script>

<asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>" ID="LocationList"
    runat="server" SelectCommand="SELECT [title], [id], [description], [linkURL], [directions], [address], [photo] FROM [Locations]">
</asp:SqlDataSource>
<table>
    <tr valign="top">
        <td style="height: 47px">
            <asp:ListBox ID="locationselect" DataSourceID="LocationList" DataTextField="title"
                DataValueField="id" AutoPostBack="true" runat="server" AppendDataBoundItems="true"
                Rows="5" OnSelectedIndexChanged="locationselect_SelectedIndexChanged" OnDataBinding="locationselect_DataBinding">
            </asp:ListBox>
        </td>
        <td>
            <asp:FormView DataSourceID="LocationList" ID="FormView1" runat="server">
                <ItemTemplate>
                    <div>
                        <p>
                            <asp:Label ID="descriptionLabel" runat="server" Text='<%# SharedRoutines.truncate(Convert.ToString(Eval("description"))) %>' />
                            <a href='<%# "Locations_view.aspx?Locationid=" + Convert.ToString( Eval("ID"))%>'>more details &raquo;</a></p>
                        </p>
                        <p>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("address") %>' />
                        </p>
                    </div>
                </ItemTemplate>
            </asp:FormView>
        </td>
    </tr>
</table>
<Club:RolloverLink ID="addlocation" runat="server" NavigateURL="locations_edit.aspx?Action=new"
    Text="Add new location" target="_new" />
