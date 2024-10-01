using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.Services;
using AppCode;
public partial class Admin_index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie User_Id = Request.Cookies["AUser_Id"];
        string name = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        if (User_Id != null)
        {
            
        }
        else
        {
            Response.Redirect("index.aspx");
        }
    }
    public class details
    {
        public string user;
        public string grp;
        public string chat;
        public string comment;
    }
    [WebMethod]
    public static details GetDetails()
    {
        details dt = new details();
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.GetStats();
            dt.user = ds.Tables[2].Rows[0][0].ToString();
            dt.grp = ds.Tables[3].Rows[0][0].ToString();
            dt.chat = (Convert.ToInt32(ds.Tables[0].Rows[0][0].ToString())+Convert.ToInt32(ds.Tables[1].Rows[0][0].ToString())).ToString();
            dt.comment = ds.Tables[4].Rows[0][0].ToString();
        }
        catch (Exception ex)
        {

        }
        return dt;
    }
}