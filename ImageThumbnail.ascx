<%@ Control Language="C#" ClassName="ImageThumbnail" %>

<script runat="server">
    public object PhotoID
    {
        get
        {
            object o = ViewState["PhotoID"];
            return (o != null) ? (int)o : 0;
        }
        set
        {
            ViewState["PhotoID"] = (value != null && value !=DBNull.Value) ? Convert.ToInt32(value) : 0;     
        }
    }

    public ImageSizes ImageSize
    {
        get
        {
            object o = ViewState["ImageSize"];
            return (o != null) ? (ImageSizes)o : ImageSizes.Thumb;
        }
        set
        {
            ViewState["ImageSize"] = value;
        }
    }
    
    public enum ImageSizes
    {
        Large = 0,
        Thumb = 1,
        FullSize = 2
    }

    public string NoPhotoImg
    {
        get
        {
            object o = ViewState["NoPhotoImg"];
            return (o != null) ? (string)o : null;
        }
        set
        {
            ViewState["NoPhotoImg"] = value;
        }
    }

    protected void Page_PreRender(object sender, System.EventArgs e)
    {
        if (Convert.ToInt32(PhotoID) == 0)
        {
            if (NoPhotoImg != null)
            {
                Image1.ImageUrl = NoPhotoImg;
            }
            else
            {
                Image1.Visible = false;
            }
        }
        else
        {
            Image1.ImageUrl = "ImageFetch.ashx?Size=" + Convert.ToInt32(ImageSize) + "&ImageID=" + Convert.ToString(PhotoID);
        }
    }
</script>

<asp:Image ID="Image1" runat="server" CssClass="photo" BorderWidth="1" />