using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EventItem
/// </summary>
public class EventItem
{

    private string id;

    private Owner owner;
    private string name;
    private string description;
    private DateTime start_time;
    private string end_time;
    private string location;
    private Venue venue;
    private string privacy;
    private string updated_time;
    private string picture;
    private string ticket_uri;

    public string Id
    {
        get { return id; }
        set { id = value; }
    }

    public DateTime Start_time
    {
        get { return start_time; }
        set { start_time = value; }
    }
   
    public string End_time
    {
        get { return end_time; }
        set { end_time = value; }
    }
    
    public string Location
    {
        get { return location; }
        set { location = value; }
    }

    public string Privacy
    {
        get { return privacy; }
        set { privacy = value; }
    }

    public string Updated_time
    {
        get { return updated_time; }
        set { updated_time = value; }
    }

    public string Picture
    {
        get { return picture; }
        set { picture = value; }
    }

    public string Ticket_uri
    {
        get { return ticket_uri; }
        set { ticket_uri = value; }
    }
    
    public EventItem()
	{
	}

    public string Description
    {
        get { return description; }
        set { description = value; }
    }

    public Venue Venue
    {
        get { return venue; }
        set { venue = value; }
    }

    public string Name
    {
        get { return name; }
        set { name = value; }
    }

    public Owner Owner
    {
        get { return owner; }
        set { owner = value; }
    }
}