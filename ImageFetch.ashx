<%@ WebHandler Language="C#" Class="ImageFetch" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.IO;

public class ImageFetch : IHttpHandler
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
        response.ContentType = "image/jpeg";
        response.Cache.SetCacheability(HttpCacheability.Public);
        response.BufferOutput = false;
        writeSingleImage(Convert.ToInt32(request.QueryString["ImageID"]), Convert.ToInt32(request.QueryString["Size"]), response.OutputStream);
        response.End();
    }

    public void writeSingleImage(int ImageID, int size, Stream output)
    {
        string cxnstr = System.Configuration.ConfigurationManager.ConnectionStrings["ClubSiteDB"].ConnectionString;
        SqlConnection connection = new SqlConnection(cxnstr);
        string query;
        if (size == 0)
        {
            query = "select largeimage from images where id=@item_id";
        }
        else if (size == 1)
        {
            query = "select thumbimage from images where id=@item_id";
        }
        else if (size == 2)
        {
            query = "select origimage from images where id=@item_id";
        }
        else
        {
            query = "select largeimage from images where id=@item_id";
        }
        SqlCommand command = new SqlCommand(query, connection);
        SqlParameter param0 = new SqlParameter("@item_id", SqlDbType.Int);
        param0.Value = ImageID;
        command.Parameters.Add(param0);
        connection.Open();

        byte[] d = ((byte[])(command.ExecuteScalar()));
        output.Write(d, 0, d.Length);
        connection.Close();
    }
}