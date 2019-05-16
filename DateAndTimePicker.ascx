<%@ Control Language="c#" ClassName="DateandTimePicker" %>
<%@ Register TagPrefix="Club" Namespace="ClubSite" %>

<script runat="server">
   
    public System.DateTime selectedDateTime
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
    
</script>
<div class="controlblock">

    <table>
        <tr>
            <td>
                Date:
            </td>
            <td>
                <club:datepicker id="dp1" runat="server" />
            </td>
            <td>
                Time:
            </td>
            <td>
                <club:timepicker id="tp1" runat="server" />
            </td>
        </tr>
    </table>

</div>
