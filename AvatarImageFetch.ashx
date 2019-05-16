<%@ WebHandler Language="c#" Class="AvatarImageFetch" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public class AvatarImageFetch : IHttpHandler
{
    const int BUFFERSIZE = 1024;

    public bool IsReusable
    {
        get
        {
            return true;
        }
    }

    //The idea behind this is to simply fetch the image out of the database and stream it down the network.
    public void ProcessRequest(HttpContext context)
    {
        HttpResponse response = context.Response;
        HttpRequest request = context.Request;
        response.ContentType = "image/jpeg";
        response.Cache.SetCacheability(HttpCacheability.Public);
        response.BufferOutput = false;
        writeSingleImage(new Guid((string)request.QueryString["MemberID"]), response.OutputStream);
        response.End();
    }

    public void writeSingleImage(Guid MemberID, Stream output)
    {
        SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ClubSiteDB"].ConnectionString);
        string qry = "select avatar from memberinfo where memberid=@memberid";
        SqlCommand command = new SqlCommand(qry, connection);

        SqlParameter param0 = new SqlParameter("@memberid", SqlDbType.UniqueIdentifier);
        param0.Value = MemberID;
        command.Parameters.Add(param0);

        connection.Open();

        byte[] d = ((byte[])(command.ExecuteScalar()));
        output.Write(d, 0, d.Length);

        connection.Close();
    }
}