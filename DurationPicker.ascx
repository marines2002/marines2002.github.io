<%@ Control Language="C#" ClassName="DurationPicker" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>
<script runat="server">
    
    public System.DateTime startDateTime
    {
        get
        {
            return dp1.SelectedDate.Add(tp1.SelectedTime.TimeOfDay);
        }
        set
        {
            dp1.SelectedDate = value;
            tp1.SelectedTime = value;
        }
    }

    public System.DateTime endDateTime
    {
        get
        {
            return dp2.SelectedDate.Add(tp2.SelectedTime.TimeOfDay);
        }
        set
        {
            dp2.SelectedDate = value;
            tp2.SelectedTime = value;
        }
    } 
</script>
<div class="controlblock">

    <table>
        <tr>
            <td>
                Start Date:
            </td>
            <td>
                <Club:DatePicker ID="dp1" runat="server" />
            </td>
            <td>
                <Club:TimePicker ID="tp1" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                End Date:
            </td>
            <td>
                <Club:DatePicker ID="dp2" runat="server" />
            </td>
            <td>
                <Club:TimePicker ID="tp2" runat="server" />
            </td>
        </tr>
    </table>

</div>
