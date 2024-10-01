using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ChatHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GetAllUsr();
    }

    private void GetAllUsr()
    {
        string res = "";
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.GetAllUsers();
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    divusers.InnerHtml += "<li class='pill' id='usr" + ds.Tables[0].Rows[i]["User_Id"].ToString() + "' onclick='chatbox(this)'>" +
                                           "<i class='anchor'  href='#' name='002'>" +
                                           "<img src='../dp/" + ((ds.Tables[0].Rows[i]["Image"].ToString() == "" ? "no.png" : ds.Tables[0].Rows[i]["Image"].ToString())) + "'  class='md-user-image' style='height:60px;width:60px;margin-right:5%;' />" +
                                           "<i id='headname'>" + ds.Tables[0].Rows[i]["First_Name"].ToString() + " " + ds.Tables[0].Rows[i]["Last_Name"].ToString() + "</i>" +
                                           "</i>" +
                                           "</li>";
                }
            }
            else
            {
                divusers.InnerHtml = "No Users Found";
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
    }
    [WebMethod]
    public static string GetDetails(string id, string head)
    {
        string res = "";
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.GetDetails(id);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                res += "<div class='col-md-12' style='margin-bottom: 1%;'><div class='col-md-6'>" + head + " - " + ds.Tables[0].Rows[i]["First_Name"].ToString() + " " + ds.Tables[0].Rows[i]["Last_Name"].ToString() + "</div>" +
                       "<div class='col-md-3'><input type='button' value='Download Chat' onclick='downloadchat(" + id + "," + ds.Tables[0].Rows[i]["User_Id"].ToString() + ")' class='btn btn-success'/></div>" +
                       "<div class='col-md-3'><input type='button' value='Delete Chat' onclick='deletechat(" + id + "," + ds.Tables[0].Rows[i]["User_Id"].ToString() + ")' class='btn btn-danger'/></div></div>";
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string DeleteChat(string AddedBy, string Received)
    {
        string res = "";
        try
        {
            BllChatHistory bllchat = new BllChatHistory();
            DataSet ds = bllchat.DeleteChat(AddedBy, Received);
            res = "success";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }
}