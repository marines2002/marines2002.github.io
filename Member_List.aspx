<%@ Page Language="C#" MasterPageFile="~/Default.master" Title="Members" %>

<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<%@ Register TagPrefix="Club" TagName="LoginBanner" Src="LoginBanner.ascx" %>
<%@ Register TagPrefix="Club" TagName="ImageThumbnail" Src="ImageThumbnail.ascx" %>

<script runat="server">

    protected void hp1_Click(object sender, System.EventArgs e)
    {
        Filter = ((LinkButton)sender).Text;
        ObjectDataSource1.SelectParameters[0].DefaultValue = Filter;
    }

    string Filter
    {
        get
        {
            object o = ViewState["Filter"];
            return (o != null) ? (string)o : string.Empty;
        }
        set
        {
            ViewState["Filter"] = value;
        }
    }

    string linkClass(string letter)
    {
        if (letter == Filter)
        {
            return "selectedLetter";
        }
        else
        {
            return "";
        }
    }

    protected void showall_Click(object sender, System.EventArgs e)
    {
        Filter = "";
        ObjectDataSource1.SelectParameters[0].DefaultValue = Filter;
    }

    public string PreFormat(string content)
    {
        if (content != null)
        {
            return content.Replace("\r\n", "<br/>");
        }
        else
        {
            return null;
        }
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
                    Members</h2>
                <p>
                    Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
                    euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad
                    minim veniam, quis nostrud exercitation ulliam corper suscipit lobortis nisl ut
                    aliquip ex ea commodo consequat. Duis autem veleum iriure dolor in hendrerit in
                    vulputate velit esse molestie consequat, vel willum lunombro dolore eu feugiat nulla
                    facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent
                    luptatum zzril delenit augue duis dolore te feugait nulla facilisi.</p>
            </div>
        </div>
        <!--
        
        Right column
        
        -->
        <div id="columnright">
            <div class="rightblock">
                <div class="newscrumbs">
                    <asp:LinkButton ID="showall" runat="server" Text="Show All" OnClick="showall_Click" />
                    <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:ClubSiteDB %>" ID="SqlDataSource1"
                        runat="server" SelectCommand="MemberCountByLetter" SelectCommandType="StoredProcedure" />
                    <asp:Repeater DataSourceID="SqlDataSource1" ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <asp:LinkButton ID="hp1" runat="server" Text='<%#Eval("letter")%>' Visible='<%# Convert.ToInt32(Eval("num"))>0 %>'
                                OnClick="hp1_Click" CssClass='<%# linkClass((string)Eval("letter"))%>' />
                            <asp:Label ID="LinkButton1" runat="server" Text='<%#Eval("letter")%>' Visible='<%# Convert.ToInt32(Eval("num"))==0 %>' />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="dashedline">
                    &nbsp;</div>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetMembers"
                    TypeName="MemberDetails">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="" Name="filter" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:DataList ID="DataList1" runat="server" DataSourceID="ObjectDataSource1" RepeatColumns="2"
                    RepeatDirection="Horizontal">
                    <ItemTemplate>
                        <div class="membercard">
                            <div style="float: left; padding: 0 5px 0 0;">
                                <asp:Image ID="ImageThumbnail1" runat="server" ImageUrl='<%# Eval("PhotoURL") %>' />
                            </div>
                            <h3>
                                <asp:Label ID="titleLabel" runat="server" Text='<%# (string)Eval("FirstName") + " " +  (string)Eval("LastName")  %>' />
                            </h3>
                            <p>
                                <asp:HyperLink ID="emailLink" runat="server" NavigateUrl='<%# "mailto:" + (string)Eval("Email")%>'
                                    Text='<%# Eval("Email") %>' />
                            </p>
                            <p>
                                <asp:Label ID="addressLabel" runat="server" Text='<%# PreFormat((string)Eval("Address")) %>' />
                            </p>
                            <p>
                                Phone:
                                <asp:Label ID="phonelabel" runat="server" Text='<%# Eval("Phone")%>' />
                            </p>
                            <div class="clearcard">
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
        <div class="clear2column">
        </div>
    </div>
</asp:Content>
