﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
// using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
// using System.Xml.Linq;

public partial class FileUpload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
            try
            {
                FileUpload1.SaveAs(Server.MapPath("Uploads\\" + System.DateTime.Now.ToFileTimeUtc() + FileUpload1.FileName));
                Label1.Text = "File name: " +
                     FileUpload1.PostedFile.FileName + "<br>" +
                     FileUpload1.PostedFile.ContentLength + " kb<br>" +
                     "Content type: " +
                     FileUpload1.PostedFile.ContentType;
            }
            catch (Exception ex)
            {
                Label1.Text = "ERROR: " + ex.Message.ToString();
            }
        else
        {
            Label1.Text = "You have not specified a file.";
        }

    }
}
