using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using AppCode;
using System.Text;
using System.Threading;
using System.Globalization;
using System.Net;
using System.Net.Mail;

namespace AppCode
{
    /// <summary>
    /// Summary description for BLLCommon
    /// </summary>

    public class BLLCommon
    {
        public static string conn = ConfigurationManager.ConnectionStrings["dbcon"].ToString();
        public static string dbcon = conn;
        //public string login = "~/Login.aspx";
        public BLLCommon()
        {
            // constructor 
            
        }

        public static string SendEmail(string email, string subject, string body)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");
                mail.IsBodyHtml = true;
                mail.From = new MailAddress("amitsable11@gmail.com");
                mail.To.Add(email);
                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = true;

                SmtpServer.Port = 587;
                SmtpServer.Credentials = new System.Net.NetworkCredential("amitsable11@gmail.com", "Apple@123");
                SmtpServer.EnableSsl = true;
                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {

                return ex.Message;
            }
            return "success";
        }
        
        public static string EncodeTo64(string toEncode)
        {
            var toEncodeAsBytes = Encoding.ASCII.GetBytes(toEncode);
            var returnValue = System.Convert.ToBase64String(toEncodeAsBytes);
            return returnValue;
        }

        public static string DecodeFrom64(string encodeData)
        {
            var encodeDataAsBytes = System.Convert.FromBase64String(encodeData);
            var returnValue = Encoding.ASCII.GetString(encodeDataAsBytes);
            return returnValue;

        }

        public static string TimeAgo(DateTime dateTime)
        {
            string result = string.Empty;
            var timeSpan = DateTime.Now.Subtract(dateTime);

            if (timeSpan <= TimeSpan.FromSeconds(60))
            {
                result = string.Format("{0} seconds ago", timeSpan.Seconds);
            }
            else if (timeSpan <= TimeSpan.FromMinutes(60))
            {
                result = timeSpan.Minutes > 1 ?
                    String.Format("about {0} minutes ago", timeSpan.Minutes) :
                    "about a minute ago";
            }
            else if (timeSpan <= TimeSpan.FromHours(24))
            {
                result = timeSpan.Hours > 1 ?
                    String.Format("about {0} hours ago", timeSpan.Hours) :
                    "about an hour ago";
            }
            else if (timeSpan <= TimeSpan.FromDays(30))
            {
                result = timeSpan.Days > 1 ?
                    String.Format("about {0} days ago", timeSpan.Days) :
                    "yesterday";
            }
            else if (timeSpan <= TimeSpan.FromDays(365))
            {
                result = timeSpan.Days > 30 ?
                    String.Format("about {0} months ago", timeSpan.Days / 30) :
                    "about a month ago";
            }
            else
            {
                result = timeSpan.Days > 365 ?
                    String.Format("about {0} years ago", timeSpan.Days / 365) :
                    "about a year ago";
            }

            return result;
        }
    }
}