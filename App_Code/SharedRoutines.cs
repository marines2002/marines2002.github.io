using System;
using System.Data;
using System.Text;
using System.Web;

public static class SharedRoutines
{
    const int TRUNCATE_COUNT = 50;

    public static string truncate(string originalInput)
    {
        return truncate(originalInput, TRUNCATE_COUNT);
    }

    public static string truncate(string originalInput, int wordsLimit)
    {
        if (originalInput != null && originalInput != "")
        {
            StringBuilder output = new StringBuilder(originalInput.Length);
            StringBuilder input = new StringBuilder(originalInput);

            int words = 0;
            bool lastwasWS = true;
            int count = 0;

            do
            {
                if (char.IsWhiteSpace(input[count]))
                {
                    lastwasWS = true;
                }
                else
                {
                    if (lastwasWS) words++;
                    lastwasWS = false;
                }
                output.Append(input[count]);
                count++;
            } while ((words < wordsLimit || lastwasWS == false) && count < originalInput.Length);

            return output.ToString();
        }
        else
        {
            return string.Empty;
        }
    }

    public static string Encode(object contents)
    {
        return HttpUtility.HtmlEncode(Convert.ToString(contents));
    }

    public static string encodeAndTruncate(object contents)
    {
        return truncate(Encode(contents));
    }

    public static string GetFriendlyDate(System.DateTime src)
    {
        System.DateTime currdate = DateTime.Now;
        int datediff = (src - currdate).Days;
        if (datediff == -1)
        {
            return "Yesterday";
        }
        else if (-7 <= datediff && datediff <= -2)
        {
            return "Last " + src.DayOfWeek.ToString();
        }
        else if (datediff == 0)
        {
            return "Today";
        }
        else if (1 <= datediff && datediff <= 7)
        {
            return "This " + src.DayOfWeek.ToString();
        }
        else
        {
            return src.ToString();
        }
    }
}