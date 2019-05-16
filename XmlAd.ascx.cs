using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Serialization;
using System.IO;

public partial class XmlAd : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ServiceCollection list = ReadCustomerList(Server.MapPath("Service.xml"));
               
        int x = RandomNumber(0, list.Count);
        
        lblName.Text = list[x].Name;
        lblDescription.Text = list[x].Description;
        lblTelephone.Text = list[x].Telephone;
        HyperLinkLink.Text = list[x].Link;
        HyperLinkLink.NavigateUrl = list[x].Link;
        HyperLinkLink.Target = "blank";
    }

    public static ServiceCollection ReadCustomerList(string path)
    {
        XmlSerializer s = new XmlSerializer(typeof(ServiceCollection));
        ServiceCollection newList = null;
        TextReader r = new StreamReader(path);
        newList = (ServiceCollection)s.Deserialize(r);
        r.Close();

        return newList;
    }

    public static void WriteCustomerList(string path)
    {
        ServiceCollection newList = new ServiceCollection();
        newList.Add(new Service("", "", "", "", "001"));

        FileStream stream = new FileStream(path, FileMode.Append);

        XmlSerializer s = new XmlSerializer(typeof(ServiceCollection));

        s.Serialize(stream, newList);

        stream.Close();
    }

    private static int RandomNumber(int min, int max)
    {
        Random random = new Random((int)DateTime.Now.Ticks);
        return random.Next(min, max);
    }
}
