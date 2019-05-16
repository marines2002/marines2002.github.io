using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facebook;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Collections;

public partial class Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // LoadFaceBookEvents();
    }

    protected void LoadFaceBookEvents()
    {
        List<EventItem> eventItemObjectList = new List<EventItem>();

        string auth = "https://graph.facebook.com/oauth/access_token?grant_type=client_credentials&client_id=536879599656407&client_secret=e6f00c1be786af147bf9e2f4e84eeede";

        String token = GetToken();
        token = token.Replace("access_token=", "");

        FacebookClient client = new FacebookClient(token);
        dynamic eventData = client.Get("duloe/events");

        JObject eventList = JObject.Parse(eventData.ToString());

        foreach (var eventItem in eventList["data"].Children())
        {
            EventItem eventItemObject = new EventItem();
            FBPicture fbPicture = new FBPicture();

            dynamic eventDataItem = client.Get(eventItem["id"].ToString());

            JObject eventJson = JObject.Parse(eventDataItem.ToString());

            eventItemObject = JsonConvert.DeserializeObject<EventItem>(eventJson.ToString());

            dynamic pictureData = client.Get("fql", new { q = string.Format("SELECT pic_square FROM event WHERE eid={0}", eventItemObject.Id) });
            dynamic obj = JsonUtils.JsonObject.GetDynamicJsonObject(pictureData.ToString());

            eventItemObject.Picture = obj.data[0].pic_square;

            eventItemObjectList.Add(eventItemObject);
        }

        eventItemObjectList.Reverse();

        // eventRepeater.DataSource = eventItemObjectList;

        // eventRepeater.DataBind();
    }

    public String GetToken()
    {
        // Create a request using a URL that can receive a post. 
        WebRequest request = WebRequest.Create("https://graph.facebook.com/oauth/access_token?grant_type=client_credentials&client_id=536879599656407&client_secret=e6f00c1be786af147bf9e2f4e84eeede");

        // Set the Method property of the request to POST.
        request.Method = "GET";
        request.ContentType = "application/x-www-form-urlencoded";

        // Get the response.
        WebResponse response = request.GetResponse();

        // Display the status.
        Console.WriteLine(((HttpWebResponse)response).StatusDescription);

        // Get the stream containing content returned by the server.
        Stream dataStream = response.GetResponseStream();

        // Open the stream using a StreamReader for easy access.
        StreamReader reader = new StreamReader(dataStream);

        // Read the content.
        string responseFromServer = reader.ReadToEnd();

        // Display the content.
        Console.WriteLine(responseFromServer);

        // Clean up the streams.
        reader.Close();
        dataStream.Close();

        response.Close();

        return responseFromServer;
    }
}