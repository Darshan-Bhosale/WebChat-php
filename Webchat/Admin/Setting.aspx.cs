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
public partial class Admin_Setting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string UpdatePass(string pass, string user, string id, string name)
    {
        string res = "";
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.UpdateAdmin(pass, user, id, name);
            res = "success";

        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }


    public class details
    {
        public string username;
        public string password;
    }
    [WebMethod]
    public static details GetDetails()
    {
        details dt = new details();
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.GetDetails();
            dt.username = ds.Tables[0].Rows[0]["Username"].ToString();
            dt.password = ds.Tables[0].Rows[0]["Password"].ToString();

        }
        catch (Exception ex)
        {

        }
        return dt;
    }

    [WebMethod]
    public static string CreateAdmin(string pass, string user, string name)
    {
        string res = "";
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.AddAdmin(user, pass, name, DateTime.Now);
            res = ds.Tables[0].Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string GetAdmins()
    {
        string res = "";
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.GetAllAdmins();
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        res += "<table class='table'><thead><tr><td>Sr.No</td><td>Name</td><td>Actions</td></tr><tbody>";
                    }
                    res += "<tr><td>" + (i + 1) + "</td><td>" + ds.Tables[0].Rows[i]["First_Name"].ToString() + "</td><td><i onclick='viewadmin(" + ds.Tables[0].Rows[i]["User_Id"].ToString() + ")' class='fa fa-eye'  data-toggle='popover' title='Delete' data-content='Do you want to delete the post'></i><i class='fa fa-trash' aria-hidden='true' style='margin-left:10%;' onclick='deleteadmin(" + ds.Tables[0].Rows[i]["User_Id"].ToString() + ")'></i></td></tr>";
                }
                res += "</tbody></html>";
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string DeleteAdmin(string id)
    {
        string res = "";
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.DeleteAdmin(id);
            res = "success";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    public class admin
    {
        public string username;
        public string password;
        public string name;
    }
    [WebMethod]
    public static admin ShowAdmin(string id)
    {
        admin adm = new admin();
        string res = "";
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.GetAdminById(id);
            adm.username = ds.Tables[0].Rows[0]["Username"].ToString();
            adm.password = ds.Tables[0].Rows[0]["Password"].ToString();
            adm.name = ds.Tables[0].Rows[0]["First_Name"].ToString();
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return adm;
    }
}