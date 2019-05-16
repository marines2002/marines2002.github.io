<%@ Page Language="C#" MasterPageFile="~/Default.master" AutoEventWireup="true"
    CodeFile="visitors.aspx.cs" Inherits="Items" Title="Fabrikam Inc: Items" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body">
    <div class="fullwidth">
     You will find this page useful if you are on holiday or new to local area please mention duloeonline if you use any of the places advertised on this site.
        </div>
        <!--Start of left column-->
        <div id="columnleft">
            <a name="content_start" id="content_start"></a>
            <div class="leftblock">
                <h2><a href="visitors.aspx">Local Attractions</h2>
                <asp:TreeView ID="TreeViewCategories" runat="server" ShowLines="True" ExpandDepth="0"
                LineImagesFolder="~/TreeLineImages" NodeIndent="0" LeafNodeStyle-CssClass="LeafNodesStyle"
                CssClass="TreeView" NodeStyle-CssClass="NodeStyle" ParentNodeStyle-CssClass="ParentNodeStyle"
                RootNodeStyle-CssClass="RootNodeStyle" SelectedNodeStyle-CssClass="SelectedNodeStyle"
                LeafNodeStyle-Width="100%" NodeStyle-Width="100%" ParentNodeStyle-Width="100%"
                RootNodeStyle-Width="100%" SelectedNodeStyle-Width="100%">
                <Nodes>
                    <asp:TreeNode Text="All Items" SelectAction="Expand" PopulateOnDemand="True" Value="All Items" />
                </Nodes>
                <%--<HoverNodeStyle ForeColor="RoyalBlue" />--%>
                <SelectedNodeStyle BackColor="Transparent" CssClass="SelectedNodeStyle" Width="100%" />
                <RootNodeStyle Font-Bold="True" Font-Size="Larger" HorizontalPadding="5px" CssClass="RootNodeStyle"
                    Width="100%" />
                <ParentNodeStyle CssClass="ParentNodeStyle" Width="100%" />
                <LeafNodeStyle CssClass="LeafNodesStyle" Width="100%" />
                <NodeStyle CssClass="NodeStyle" Width="100%" />
            </asp:TreeView>
            </div>
            
        </div>
        <!--end columnleft-->
        <!--Start of right column-->
        <div id="columnright">
           <h2> <asp:Label ID="LabelCurrentCategory" runat="server" Visible="true" Text=""></asp:Label></h2>
            <asp:Panel ID="PanelCategories" runat="server" Visible="true">
                &nbsp;<asp:ObjectDataSource ID="ObjectDataSourceCategories" runat="server" SelectMethod="GetChildCategories"
                    TypeName="Catalog">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="parentCategoryId" QueryStringField="catId" Type="string"
                            DefaultValue="" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:GridView ID="GridViewCategories" runat="server" AutoGenerateColumns="False"
                    AllowPaging="true" PageSize="10" DataSourceID="ObjectDataSourceCategories" BorderWidth="0"
                    BorderColor="white">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="Image1" CssClass="photo-border photo-float-left" runat="server" Width="90px"
                                    Height="60px" ImageUrl='<%# "images/" + (string)Eval("ImageUrl") %>' AlternateText='<%#(string)Eval("ImageAltText")%>' />
                                <b>
                                    <%# Eval("Title").ToString()%>
                                </b>
                                <br />
                                <%#Eval("Description").ToString()%>
                                <br />
                                <br />
                                <asp:HyperLink ID="HyperLink5" runat="server" ImageUrl="images/arrow.gif" NavigateUrl='<%# "visitors.aspx?catId=" + (string)Eval("id") %>' />
                                <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl='<%# "visitors.aspx?catId=" + (string)Eval("id") %>'> 
                                    Read More
                                </asp:HyperLink>
                                <hr />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                </asp:GridView>
            </asp:Panel>
            <!-- Child Items -->
            <asp:Panel ID="PanelItems" runat="server" Visible="false">
                <hr />
                <asp:ObjectDataSource ID="ObjectDataSourceItems" runat="server" SelectMethod="GetChildItems"
                    TypeName="Catalog">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="categoryId" QueryStringField="catId" Type="string"
                            DefaultValue="" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:GridView ID="GridViewItems" runat="server" AutoGenerateColumns="False" AllowPaging="true"
                    PageSize="10" DataSourceID="ObjectDataSourceItems" OnRowCreated="GridViewItems_RowCreated"
                    BorderWidth="0" BorderColor="white">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="Image1" CssClass="photo-border photo-float-left" runat="server" Width="150px"
                                    Height="100px" ImageUrl='<%# "images/" + (string)Eval("ImageUrl") %>' AlternateText='<%# (string)Eval("ImageAltText")%>' />
                                
                                <br />
                                <%# Eval("Description")%>
                                <br />
                                <br />
                                Link:
                                <asp:HyperLink ID="HyperLink5" Target='<%# Eval("Target")%>' runat="server" NavigateUrl='<%# Eval("Link")%>'> 
                                     <%# Eval("Title").ToString()%>
                                </asp:HyperLink>
                                <br />
                                <br />
                                Contact:
                                <%# Eval("contact")%>
                                <br />
                                <br />
                                <hr />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                </asp:GridView>
            </asp:Panel> 
        </div>
        <div class="clear2column"></div>
    </div>
 </asp:Content>
