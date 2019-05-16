using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Owner
/// </summary>
public class Venue
{
    private string id;
    private string category;
    private string name;
    private string street;
    private string city;
    private string state;
    private string zip;
    private string country;
    private string latitude;
    private string longitude;

    public string Street
    {
        get { return street; }
        set { street = value; }
    }

    public string City
    {
        get { return city; }
        set { city = value; }
    }

    public string State
    {
        get { return state; }
        set { state = value; }
    }
    
    public string Zip
    {
        get { return zip; }
        set { zip = value; }
    }

    public string Country
    {
        get { return country; }
        set { country = value; }
    }

    public string Latitude
    {
        get { return latitude; }
        set { latitude = value; }
    }

    public string Longitude
    {
        get { return longitude; }
        set { longitude = value; }
    }

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