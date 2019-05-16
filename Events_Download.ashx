<%@ WebHandler Language="C#" Class="DownloadEvent" %>

using System;
using System.Web; 
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.IO;

public class DownloadEvent : IHttpHandler 
{ 
 const int BUFFERSIZE = 1024;

    public bool IsReusable
    {
        get
        {
            return true;
        }
    } 

 public void ProcessRequest(HttpContext context) 
 { 
   HttpResponse response = context.Response; 
   HttpRequest request = context.Request; 
   response.BufferOutput = true; 
   response.ContentType = "text/calendar"; 
   response.Cache.SetCacheability(HttpCacheability.NoCache); 
   int EventID = Convert.ToInt32(request.QueryString["EventID"]); 
   Uri viewurl = new Uri(context.Request.Url, "Events_view.aspx?Eventid=" + EventID); 
   writeCalEntry(EventID, response.Output, viewurl.ToString()); 
   response.End(); 
 }

    public void writeCalEntry(int EventID, TextWriter output, string url)
    {
        SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ClubSiteDB"].ConnectionString);

        string qry = "SELECT Events.starttime, Events.endtime, Events.title, Events.description, Events.staticURL, Locations.title AS LocName, Locations.directions, ";
        qry += "Locations.description AS locDesc, Locations.address ";
        qry += "FROM Locations RIGHT OUTER JOIN ";
        qry += "Events ON Locations.id = Events.location ";
        qry += "WHERE (Events.id = @id)";

        SqlCommand command = new SqlCommand(qry, connection);
        SqlParameter param0 = new SqlParameter("@id", SqlDbType.Int);
        param0.Value = EventID;
        command.Parameters.Add(param0);

        connection.Open();
        DataTable dt = new DataTable();
        dt.Load(command.ExecuteReader());
        if (dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];

            System.DateTime starttime, endtime;
            string title, description, location;

            StringBuilder sb = new StringBuilder();
            object o;
            
            starttime = (DateTime)dr["starttime"];
            if (dr["endtime"] != DBNull.Value)
            {
                endtime = (DateTime)dr["endtime"];
            }
            else
            {
                endtime = starttime;
            }
            
            if (dr["title"] != DBNull.Value)
            {
                title = (string)(dr["title"]);
            }
            else
            {
                title = "An untitled clubsite event";
            }
           
            o = dr["description"];
            if (o != DBNull.Value && (string)o != "")
            {
                sb.AppendLine((string)o);
            }
            sb.AppendLine();
            
            sb.Append("Event URL: ");
            o = dr["staticURL"];
            if (o != DBNull.Value && (string)o != "")
            {
                sb.AppendLine((string)o);
            }
            else
            {
                sb.AppendLine(url);
            }
            
            o = dr["locName"];
            if (o != DBNull.Value && (string)o != "")
            {
                location = (string) o;
                sb.AppendLine();
                sb.Append("Event location: ");
                sb.AppendLine(location);
            }
            else
            {
                location = null;
            }
            
            o = dr["locDesc"];
            if (o != DBNull.Value && (string)o != "")
            {
                sb.AppendLine();
                sb.AppendLine("Location description:");
                sb.AppendLine((string)o);
            }
            
            o = dr["Address"];
            if (o != DBNull.Value && (string)o != "")
            {
                sb.AppendLine();
                sb.AppendLine("Location Address:");
                sb.AppendLine((string)o);
            }
            
            o = dr["directions"];
            if (o != DBNull.Value && (string)o != "")
            {
                sb.AppendLine();
                sb.AppendLine("Location Directions:");
                sb.AppendLine((string) o);
            }
            
            UnicodeEncoding uc = new UnicodeEncoding();
            description = sb.ToString();
            output.WriteLine("BEGIN:VCALENDAR");
            output.WriteLine("VERSION:2.0");
            output.WriteLine("PRODID:" + url);
            output.WriteLine("METHOD:PUBLISH");
            output.WriteLine("BEGIN:VEVENT");
            output.WriteLine("UID:" + Guid.NewGuid().ToString());
            output.WriteLine("DTSTAMP:" + DateTime.Now.ToUniversalTime().ToString("yyyyMMddTHHmmss") + "Z");
            output.WriteLine("CATEGORIES:APPOINTMENT;PERSONAL");
            output.WriteLine(EncodeProperty("DESCRIPTION;ENCODING=QUOTED-PRINTABLE:", description));
            output.WriteLine("DTEND:" + endtime.ToUniversalTime().ToString("yyyyMMddTHHmmss") + "Z");
            if (!(location == null))
            {
                output.WriteLine(EncodeProperty("LOCATION;ENCODING=QUOTED-PRINTABLE:", location));
            }
            output.WriteLine("PRIORITY:0");
            output.WriteLine("DTSTART:" + starttime.ToUniversalTime().ToString("yyyyMMddTHHmmss") + "Z");
            output.WriteLine("STATUS:NEEDS ACTION");
            output.WriteLine(EncodeProperty("SUMMARY;ENCODING=QUOTED-PRINTABLE:", title));
            output.WriteLine("URL:" + url);
            output.WriteLine("END:VEVENT");
            output.WriteLine("END:VCALENDAR");
        }
        connection.Close();
    }

 string EncodeProperty(string key, string value) 
 { 
   StringBuilder sb = new StringBuilder(); 
   sb.Append(key); 
   sb.Append(value); 
   sb.Replace(";", "\\;", key.Length, sb.Length - key.Length); 
   sb.Replace("\r\n", "=0D=0A"); 
   int offset = 76; 
   while (offset < sb.Length) { 
     int pos = sb.ToString(offset - 5, 10).IndexOf("=0D=0A"); 
     if (pos == -1) { 
       sb.Insert(offset - 5 + pos, "=" + "\r\n"); 
       offset += 79 - 5 + pos; 
     } else { 
       sb.Insert(offset, "=" + "\r\n"); 
       offset += 79; 
     } 
   } 
   return sb.ToString(); 
 } 

}