<%@ Page Language="c#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<script runat="server">
    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (Page.User.Identity.IsAuthenticated)
        {
            Response.Redirect("member_details.aspx");
        }
        else
        {
            Response.Redirect("member_register.aspx");
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        Page should redirect shortly...
    </form>
</body>
</html>
