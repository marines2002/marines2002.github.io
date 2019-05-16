using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Route : System.Web.UI.Page
{
    string routeid;
    string url;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        routeid = Request.QueryString["route"];

        switch (routeid)
        {
            case "KAYAK1": url = @"http://js.mapmyfitness.com/embed/blogview.html?r=677ff7be04feca9a51dcd283715993ca&u=e&t=route";
                                        
                break;

            case "WALK1": url = @"http://js.mapmyfitness.com/embed/blogview.html?r=dabf15441ba534cdc7505e0a6c87317f&u=e&t=route";

                break;

            case "WALK2": url = @"http://js.mapmyfitness.com/embed/blogview.html?r=7f0f6a3823f8fa069781ec34b8c1c888&u=e&t=route";  

                break;
            case "CYCLE1": url = @"http://js.mapmyfitness.com/embed/blogview.html?r=316d3a06265254a6a38c75caf03befba&u=e&t=route";
                break;

            case "CYCLE2": url = @"http://js.mapmyfitness.com/embed/blogview.html?r=91732a17f2b0947277328197d45aaf61&u=e&t=route";
                break;
            default: ;
                break;
        }

        Literal1.Text = string.Format(@"<iframe src=""{0}"" height=""700px"" width=""100%"" frameborder=""0""></iframe>", url);
    }
}
