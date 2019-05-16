<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Untitled Page" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">

    private int nextLocationID;
    private int prevLocationID;
    const int INVALIDID = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["id"].DefaultValue = Convert.ToString(LocationID);
    }

    protected void nextButton_Click(object sender, EventArgs e)
    {
        InitValsFromSql(LocationID);
        if (nextLocationID != INVALIDID)
        {
            prevLocationID = LocationID;
            LocationID = nextLocationID;
            SqlDataSource1.SelectParameters["id"].DefaultValue = Convert.ToString(nextLocationID);
        }
        ToggleLinks();
    }

    protected void prevButton_Click(object sender, System.EventArgs e)
    {
        InitValsFromSql(LocationID);
        if (prevLocationID != INVALIDID)
        {
            nextLocationID = LocationID;
            LocationID = prevLocationID;
            SqlDataSource1.SelectParameters["id"].DefaultValue = Convert.ToString(prevLocationID);
        }
        ToggleLinks();
    }

    void ToggleLinks()
    {
        LinkButton1.Enabled = (nextLocationID != INVALIDID);
        LinkButton3.Enabled = (nextLocationID != INVALIDID);
        LinkButton2.Enabled = (prevLocationID != INVALIDID);
        LinkButton4.Enabled = (prevLocationID != INVALIDID);
    }

    int LocationID
    {
        get
        {
            int m_LocationID;
            object id = ViewState["LocationID"];
            if (id != null)
            {
                m_LocationID = (int)id;
            }
            else
            {
                id = Request.QueryString["LocationID"];
                if (id != null)
                {
                    m_LocationID = Convert.ToInt32(id);
                }
                else
                {
                    m_LocationID = 1;
                }
                ViewState["LocationID"] = m_LocationID;
            }
            return m_LocationID;
        }
        set
        {
            ViewState["LocationID"] = value;
        }
    }

    void InitValsFromSql(int LocationID)
    {
        try
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ClubSiteDB"].ConnectionString);
            SqlCommand command = new SqlCommand("NextPrevLocation", connection);
            
            SqlParameter param0 = new SqlParameter("@id", LocationID);
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
            
            if (param1.Value != null && param1.Value !=DBNull.Value)
            {
                prevLocationID = Convert.ToInt32(param1.Value);
            }
            else
            {
                prevLocationID = INVALIDID;
            }
            if (param2.Value != null && param2.Value !=DBNull.Value)
            {
                nextLocationID = Convert.ToInt32(param2.Value);
            }
            else
            {
                nextLocationID = INVALIDID;
            }
            connection.Close();
        }
        catch
        {
            prevLocationID = INVALIDID;
            nextLocationID = INVALIDID;
        }
    }    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
        SelectCommand="SELECT id, title, description, photo, linkurl, directions, address FROM locations WHERE (id = @id)">
        <SelectParameters>
            <asp:Parameter Type="Int32" DefaultValue="1" Name="id"></asp:Parameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <div id="body">
        <Club:LoginBanner ID="LoginBanner1" runat="server" />
        <!--
        
        Left column
        
        -->
        <div id="columnleft">
            <a name="content_start" id="content_start"></a>
            <div class="leftblock">
                <h2>
                    Locations</h2>
                <p>
                    </p>
            </div>
        </div>
        <!--
        
        Right column
        
        -->
        <div id="columnright">
            <div class="rightblock">
                <a href="Locations_list.aspx">Locations List</a></div>
            <div class="rightblock">
                <div class="nextlink">
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="nextButton_Click">Next Location &raquo;</asp:LinkButton>
                </div>
                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="prevButton_Click">&laquo; Previous Location</asp:LinkButton>
                <div class="dashedline">
                </div>
                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="id"
                    Width="444px">
                    <ItemTemplate>
                        <h2>
                            <asp:Label Text='<%# Eval("title") %>' runat="server" ID="titleLabel" />
                        </h2>
                        <div class="itemdetails">
                            <p>
                                <asp:HyperLink Text='<%# Eval("linkurl") %>' NavigateUrl='<%# Eval("linkurl") %>'
                                    runat="server" ID="Label1" />
                            </p>
                            <p>
                                <asp:Label Text='<%# Eval("address") %>' runat="server" ID="addressLabel" />
                            </p>
                        </div>
                        <Club:ImageThumbnail ID="thumb1" runat="server" ImageSize="Large" PhotoID='<%# Eval("photo") %>' />
                        <p>
                            <asp:Label Text='<%# Eval("description") %>' runat="server" ID="descriptionLabel" />
                        </p>
                        <p>
                            <asp:Label Text='<%# Eval("directions") %>' runat="server" ID="Label2" />
                        </p>
                        <asp:Panel runat="server" ID="panel1" CssClass="actionbuttons" Visible='<%# User.IsInRole("Administrators") %>'>
                            <Club:RolloverLink ID="editbtn" runat="server" Text="Edit Location" NavigateURL='<%# "Locations_edit.aspx?LocationID=" + Convert.ToString(LocationID)%>' />
                        </asp:Panel>
                    </ItemTemplate>
                </asp:FormView>
                <div class="dashedline">
                </div>
                <div class="nextlink">
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="nextButton_Click">Next Location &raquo;</asp:LinkButton>
                </div>
                <asp:LinkButton ID="LinkButton4" runat="server" OnClick="prevButton_Click">&laquo; Previous Location</asp:LinkButton>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
</asp:Content>
