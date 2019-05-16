using System;

///<summary>
/// Class Item
/// Represents an item the small business sells
/// Typically, an Item could be a product or a service
///</summary>
public class Item
{
    private string  _id;            
    private string _title;          
    private bool    _visible;       
    private string  _description;   
    private string  _link;
    private string _target;     
    private string  _contact;       
    private string  _imageUrl;      
    private string  _imageAltText;

 
    public Item(string id,
                bool visible,
                string title)
    {
        if (String.IsNullOrEmpty(id)) throw new ArgumentException(Messages.ItemIdUndefined);
        if (String.IsNullOrEmpty(title)) throw new ArgumentException(Messages.ItemTitleUndefined);
        _id = id;
        _visible = visible;
        _title = title;

    }

    public string Id
    {
        get { return String.IsNullOrEmpty(_id) ? String.Empty : _id; }
    }

    public bool Visible
    {
        get { return _visible; }
        set { _visible = value; }
    }

    public string Title
    {
        get { return String.IsNullOrEmpty(_title) ? String.Empty : _title; }
        set 
        {    if (String.IsNullOrEmpty(value))
            throw new InvalidOperationException(Messages.ItemTitleIsNull);
            _title = value; 
        }
    }

    public string Description
    {
        get { return _description; }
        set { _description = value; }
    }

    public string Link
    {
        get { return  _link; }
        set { _link = value; }
    }

    public string Target
    {
        get { return _target; }
        set { _target = value; }
    }

    public string Contact
    {
        get { return _contact; }
        set { _contact = value; }
    }

    public string ImageUrl
    {
        get { return String.IsNullOrEmpty(_imageUrl) ? String.Empty : _imageUrl; }
        set { _imageUrl = value; }
    }

    public string ImageAltText
    {
        get { return String.IsNullOrEmpty(_imageAltText) ? String.Empty : _imageAltText; }
        set { _imageAltText = value; }
    }
}
