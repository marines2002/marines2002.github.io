using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Owner
/// </summary>
public class Owner
{

    private string id;
    private string category;
    private string name;

    public string Id
    {
        get { return id; }
        set { id = value; }
    }
    
    public string Name
    {
        get { return name; }
        set { name = value; }
    }

    public string Category
    {
        get { return category; }
        set { category = value; }
    }
}