<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Untitled Page" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    private int nextArticleID;
    private int prevArticleID;
    const int INVALIDID = -1;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (!IsPostBack)
        {
            InitDatasources();
        }
    }

    protected void FormView1_DataBound(object sender, System.EventArgs e)
    {
        DataRowView view = (DataRowView)(FormView1.DataItem);
        object o = view["staticURL"];
        if (o != null && o !=DBNull.Value)
        {
            string staticurl = (string)o;
            if (staticurl != "")
            {
                Response.Redirect(staticurl);
            }
        }
    }

    protected void nextButton_Click(object sender, System.EventArgs e)
    {
        InitValsFromSql(ArticleID);
        if (nextArticleID != INVALIDID)
        {
            prevArticleID = ArticleID;
            ArticleID = nextArticleID;
            InitDatasources();
        }
        ToggleLinks();
    }

    protected void prevButton_Click(object sender, System.EventArgs e)
    {
        InitValsFromSql(ArticleID);
        if (prevArticleID != INVALIDID)
        {
            nextArticleID = ArticleID;
            ArticleID = prevArticleID;
            InitDatasources();
        }
        ToggleLinks();
    }

    void InitDatasources()
    {
        PhotoPanel.Visible = true;
        SqlDataSource1.SelectParameters["id"].DefaultValue = System.Convert.ToString(ArticleID);
        SqlDataSource2.SelectParameters["id"].DefaultValue = System.Convert.ToString(ArticleID);
    }

    void ToggleLinks()
    {
        LinkButton1.Enabled = (nextArticleID != INVALIDID);
        LinkButton3.Enabled = (nextArticleID != INVALIDID);
        LinkButton2.Enabled = (prevArticleID != INVALIDID);
        LinkButton4.Enabled = (prevArticleID != INVALIDID);
    }

    int ArticleID
    {
        get
        {
            int m_articleID;
            object id = ViewState["ArticleId"];
            if (id != null)
            {
                m_articleID = System.Convert.ToInt32(id);
            }
            else
            {
                id = Request.QueryString["ArticleId"];
                if (id != null)
                {
                    m_articleID = System.Convert.ToInt32(id);
                }
                else
                {
                    m_articleID = 1;
                }
                ViewState["ArticleId"] = m_articleID;
            }
            return m_articleID;
        }
        set
        {
            ViewState["ArticleId"] = value;
        }
    }

    void InitValsFromSql(int ArticleID)
    {
        try
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ClubSiteDB"].ConnectionString);
            SqlCommand command = new SqlCommand("NextPrevAnnouncement", connection);
        
            SqlParameter param0 = new SqlParameter("@id", ArticleID);
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
            if (param1.Value != null && param1.Value != DBNull.Value)
            {
                prevArticleID = Convert.ToInt32(param1.Value);
            }
            else
            {
                prevArticleID = INVALIDID;
            }
            if (param2.Value != null && param2.Value != DBNull.Value)
            {
                nextArticleID = Convert.ToInt32(param2.Value);
            }
            else
            {
                nextArticleID = INVALIDID;
            }
            connection.Close();
        }
        catch
        {
            prevArticleID = INVALIDID;
            nextArticleID = INVALIDID;
        }
    }

    protected void SqlDataSource2_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        PhotoPanel.Visible = (e.AffectedRows != 0);
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
                    News Articles</h2>
                 <p>
                    If you have an Event you want to be added to our list please contact a site
            admin or email via the <a href="contact.aspx"> <b>Contact</b></a> page</p>
            </div>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ClubsiteDB %>"
                SelectCommand="SELECT images.id, images.album, images.title FROM images, announcements WHERE images.album=announcements.albumid AND announcements.id=@id"
                OnSelected="SqlDataSource2_Selected">
                <SelectParameters>
                    <asp:Parameter Type="Int32" DefaultValue="1" Name="id"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="PhotoPanel" runat="server" CssClass="leftblock">
                <h2>
                    Associated Album photos</h2>
                <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource2" DataKeyField="id"
                    RepeatColumns="2" CellSpacing="2" SelectedIndex="0" ItemStyle-CssClass="unselected">
                    <ItemTemplate>
                        <a href='photoalbum_contents.aspx?Albumid=<%#Eval("album") %>'>
                            <asp:Image ID="Image1" ImageUrl='<%# "imagefetch.ashx?size=1&imageid=" + Convert.ToString(Eval("id")) %>'
                                runat="server" /><br />
                            <asp:Label Text='<%# Eval("title") %>' runat="server" ID="titleLabel" />
                        </a>
                    </ItemTemplate>
                </asp:DataList>
            </asp:Panel>
        </div>
        <!--
        
        Right column
        
        -->
        <div id="columnright">
            <div class="rightblock">
                <a href="news_list.aspx">News Article List</a></div>
            <div class="rightblock">
                <div class="nextlink">
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="nextButton_Click">Next Article &raquo;</asp:LinkButton>
                </div>
                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="prevButton_Click">&laquo; Previous article</asp:LinkButton>
                <div class="dashedline">
                </div>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>"
                    SelectCommand="SELECT id, itemdate, title, description, photo, albumid, staticURL FROM Announcements WHERE (id = @id)">
                    <SelectParameters>
                        <asp:Parameter Type="Int32" DefaultValue="1" Name="id"></asp:Parameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="id"
                    Width="444px" OnDataBound="FormView1_DataBound">
                    <ItemTemplate>
                        <h2>
                            <asp:Label Text='<%# Eval("title") %>' runat="server" ID="titleLabel" />
                        </h2>
                        <div class="itemdetails">
                            <p>
                                <asp:Label Text='<%# Eval("itemdate","{0:D}") %>' runat="server" ID="itemdateLabel" />
                            </p>
                        </div>
                        <Club:ImageThumbnail ID="thumb1" runat="server" ImageSize="large" PhotoID='<%# Eval("photo") %>' />
                        <p>
                            <asp:Label Text='<%# Eval("description") %>' runat="server" ID="descriptionLabel" />
                        </p>
                        <asp:Panel runat="server" ID="panel1" CssClass="actionbuttons" Visible='<%# User.IsInRole("Administrators") %>'>
                            <Club:RolloverLink ID="editbtn" runat="server" Text="Edit Article" NavigateURL='<%# "news_edit.aspx?ArticleID=" + Convert.ToString( ArticleID )%>' />
                        </asp:Panel>
                    </ItemTemplate>
                </asp:FormView>
                <div class="dashedline">
                </div>
                <div class="nextlink">
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="nextButton_Click">Next Article &raquo;</asp:LinkButton>
                </div>
                <asp:LinkButton ID="LinkButton4" runat="server" OnClick="prevButton_Click">&laquo; Previous Article</asp:LinkButton>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
</asp:Content>
