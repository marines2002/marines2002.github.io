using System;
using System.Data;
using System.Collections.Generic;
using System.Web.Security;


public class MemberDetails
{

    public static List<MemberDetails> GetMembers(string filter)
    {

        List<MemberDetails> mlist = new List<MemberDetails>();
        DataSetMemberTableAdapters.MemberInfoTableAdapter da = new DataSetMemberTableAdapters.MemberInfoTableAdapter();
        DataSetMember.MemberInfoDataTable members = da.GetMemberList();

        foreach (MembershipUser user in Membership.GetAllUsers())
        {
            DataSetMember.MemberInfoRow member;
            member = members.FindBymemberid((Guid)user.ProviderUserKey);
            if (member !=null)
            {
                if (filter == null || filter == String.Empty || member.lastname.StartsWith(filter, StringComparison.CurrentCultureIgnoreCase))
                {
                    mlist.Add(new MemberDetails(user, member));
                }
            }
        }
        return mlist;
    }

    private MemberDetails(MembershipUser user, DataSetMember.MemberInfoRow member)
    {
        m_UserName = user.UserName;
        m_Email = user.Email;

        if (member != null)
        {
            m_firstname = member.firstname;
            m_LastName = member.lastname;
            m_address = member.address;
            m_Phone = member.phone;
            if (!member.IsAvatarSizeNull())
            {
                m_PhotoURL = "AvatarImagefetch.ashx?Memberid=" + user.ProviderUserKey.ToString();
            }
            else
            {
                m_PhotoURL = "images/nophoto.gif";
            }
        }
    }

    private string m_firstname;
    public string FirstName
    {
        get
        {
            return m_firstname;
        }
    }

    private string m_LastName;
    public string LastName
    {
        get
        {
            return m_LastName;
        }
    }

    private string m_address;
    public string Address
    {
        get
        {
            return m_address;
        }
    }

    private string m_UserName;
    public string UserName
    {
        get
        {
            return m_UserName;
        }
    }

    private string m_PhotoURL;
    public string PhotoURL
    {
        get
        {
            return m_PhotoURL;
        }
    }

    private string m_Email;
    public string Email
    {
        get
        {
            return m_Email;
        }
    }

    private string m_Phone;
    public string Phone
    {
        get
        {
            return m_Phone;
        }
    }
}