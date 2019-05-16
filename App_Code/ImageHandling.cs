using System;
using System.Data;
using System.Data.SqlClient; 
using System.IO;
using System.Drawing;
using System.Configuration;


public class ImageUtils
{
    const int sizeThumb = 69;

    public static int uploadImage(string title, int albumid, Stream data)
    {
        int length = Convert.ToInt32(data.Length);
        byte[] origImageData = new byte[length];
        data.Read(origImageData, 0, length);

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ClubSiteDB"].ConnectionString);
        SqlCommand command = new SqlCommand("INSERT INTO Images (title, origimage, largeimage, thumbimage, album) VALUES ( @title, @origimage, @largeimage, @thumbimage, @albumid); select SCOPE_IDENTITY()", connection);

        SqlParameter param0 = new SqlParameter("@title", SqlDbType.VarChar, 50);
        param0.Value = title;
        command.Parameters.Add(param0);

        SqlParameter param1 = new SqlParameter("@origimage", SqlDbType.Image);
        param1.Value = origImageData;
        command.Parameters.Add(param1);

        SqlParameter param2 = new SqlParameter("@largeimage", SqlDbType.Image);
        param2.Value = MakeThumb(origImageData, 350);
        command.Parameters.Add(param2);

        SqlParameter param3 = new SqlParameter("@thumbimage", SqlDbType.Image);
        param3.Value = MakeThumb(origImageData, 69, 69);
        command.Parameters.Add(param3);

        SqlParameter param4 = new SqlParameter("@albumid", SqlDbType.Int);
        param4.Value = albumid;
        command.Parameters.Add(param4);

        connection.Open();

        object result = command.ExecuteScalar();
        connection.Close();
        if (result != null)
        {
            return System.Convert.ToInt32(result);
        }
        else
        {
            return 0;
        }
    }


    public static byte[] MakeThumb(byte[] fullsize)
    {
        Image iOriginal, iThumb;
        int targetH, targetW;

        iOriginal = Image.FromStream(new MemoryStream(fullsize));
        if (iOriginal.Height > iOriginal.Width)
        {
            targetH = sizeThumb;
            targetW = Convert.ToInt32(iOriginal.Width * (sizeThumb / iOriginal.Height));
        }
        else
        {
            targetW = sizeThumb;
            targetH = Convert.ToInt32(iOriginal.Height * (sizeThumb / iOriginal.Width));
        }
        iThumb = iOriginal.GetThumbnailImage(targetW, targetH, null, System.IntPtr.Zero);
        MemoryStream m = new MemoryStream();
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg);
        return m.GetBuffer();
    }

    public static byte[] MakeThumb(byte[] fullsize, int newwidth, int newheight)
    {
        Image iOriginal, iThumb;
        double scaleH, scaleW;

        Rectangle srcRect=new Rectangle();
        iOriginal = Image.FromStream(new MemoryStream(fullsize));
        scaleH = iOriginal.Height / newheight;
        scaleW = iOriginal.Width / newwidth;
        if (scaleH == scaleW)
        {
            srcRect.Width = iOriginal.Width;
            srcRect.Height = iOriginal.Height;
            srcRect.X = 0;
            srcRect.Y = 0;
        }
        else if ((scaleH) > (scaleW))
        {
            srcRect.Width = iOriginal.Width;
            srcRect.Height = Convert.ToInt32(newheight * scaleW);
            srcRect.X = 0;
            srcRect.Y = Convert.ToInt32((iOriginal.Height - srcRect.Height) / 2);
        }
        else
        {
            srcRect.Width = Convert.ToInt32(newwidth * scaleH);
            srcRect.Height = iOriginal.Height;
            srcRect.X = Convert.ToInt32((iOriginal.Width - srcRect.Width) / 2);
            srcRect.Y = 0;
        }
        iThumb = new Bitmap(newwidth, newheight);
        Graphics g = Graphics.FromImage(iThumb);
        g.DrawImage(iOriginal, new Rectangle(0, 0, newwidth, newheight), srcRect, GraphicsUnit.Pixel);
        MemoryStream m = new MemoryStream();
        iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg);
        return m.GetBuffer();
    }

    public static byte[] MakeThumb(byte[] fullsize, int maxwidth)
    {
        Image iOriginal, iThumb;
        double scale;

        iOriginal = Image.FromStream(new MemoryStream(fullsize));
        if (iOriginal.Width > maxwidth)
        {
            scale = iOriginal.Width / maxwidth;
            int newheight = Convert.ToInt32(iOriginal.Height / scale);
            iThumb = new Bitmap(iOriginal, maxwidth, newheight);
            MemoryStream m = new MemoryStream();
            iThumb.Save(m, System.Drawing.Imaging.ImageFormat.Jpeg);
            return m.GetBuffer();
        }
        else
        {
            return fullsize;
        }
    }
}