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
using System.IO;
public partial class index : System.Web.UI.Page
{
    public static string imagename = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie User_Id = Request.Cookies["User_Id"];
        string name = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        if (User_Id != null)
        {
            getallpost();
        }
        else
        {
            Response.Redirect("index.aspx");
        }

    }

    private void getallpost()
    {
        string res = "";
        string element = "";
        string like = "";
        string cmnt = "";

        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.GetAllPosts(User_Ids);
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    element = "";
                    if (i == 0)
                    {
                        res += "<div class='plid' style='display:none;'>" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + "</div>";
                    }
                    string[] arr = ds.Tables[0].Rows[i]["Attachment"].ToString().Split('.');
                    if (arr.Length > 1)
                    {
                        if (arr[1].ToLower() == "jpg" || arr[1].ToLower() == "png" || arr[1].ToLower() == "gif")
                        {
                            element = "<div class='col-md-12 text-center'><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='width:300px;height:275px;margin-bottom:3%;'onclick='openmodal(this);'></img></div>";
                        }
                        else if (arr[1].ToLower() == "mp4" || arr[1].ToLower() == "avi" || arr[1].ToLower() == "flv" || arr[1].ToLower() == "wmv" || arr[1].ToLower() == "mov" || arr[1].ToLower() == "3gp")
                        {
                            element = "<div class='col-md-12 text-center'><video width='350' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1].ToLower() + "'></video></div>";
                        }
                        else
                        {
                            element = "<div class='col-md-12 text-center'><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "'>" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "</a></div>";
                        }
                    }
                    if (ds.Tables[0].Rows[i]["Likes"].ToString().Split(',').Contains(Session["User_Id"].ToString()))
                    {

                        like = "color:red;";
                    }
                    else
                    {
                        like = "color:black;";
                    }
                    if (Convert.ToInt32(ds.Tables[0].Rows[i]["Comment_Count"].ToString()) != 0)
                    {

                        cmnt = "color:#37c1f0;";
                    }
                    else
                    {
                        cmnt = "color:black;";
                    }
                    res += "<div class='col-sm-12'>" +
                            "<div class='panel panel-white post panel-shadow'>" +
                            "<div class='post-heading'>" +
                            "<div class='pull-left image'>" +
                            "<img src='dp/" + ((ds.Tables[0].Rows[i]["Image"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["Image"].ToString()) + "' class='img-circle avatar' alt='user profile image'>" +
                            "</div>" +
                            "<div class='pull-left meta'>" +
                            "<div class='title h5'>" +
                            "<a href='#'><b>" + ds.Tables[0].Rows[i]["Name"].ToString() + "</b></a> </div>" +
                            "<h6 class='text-muted time'>" + BLLCommon.TimeAgo(Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString())) + "</h6>" +
                            "</div>" +
                            "</div>" +
                            "<div class='post-description'>" + element +
                            "<div style='top:10;'><p>" + ((ds.Tables[0].Rows[i]["Message"].ToString() == "") ? "&nbsp;&nbsp;&nbsp;" : ds.Tables[0].Rows[i]["Message"].ToString()) + "</p></div>" +
                            "<span  id='lbllike" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + "' onclick='like(this)' class='fa fa-heart' style='font-size: 25px;margin-left: 3%;" + like + "'></span>" +
                            "<span class='fa fa-comments' onclick='comments(" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + ")' style='font-size: 27px;margin-left: 3%;" + cmnt + "'></span>" +
                            "<div style='margin-top:2%;margin-left:5%;font-weight:800;'><span id='likehit" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + "'>" + ds.Tables[0].Rows[i]["Lcount"].ToString() + "</span> Likes</div>" +
                            "</div>" +
                            "</div>" +
                            "</div>";
                }
                posts.InnerHtml = res;
            }
            else
            {
                res += "No Post's Yet";
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                hdimage.Value = (ds.Tables[1].Rows[0][0].ToString() == "") ? "no.png" : ds.Tables[1].Rows[0][0].ToString();
                imagename = (ds.Tables[1].Rows[0][0].ToString() == "") ? "no.png" : ds.Tables[1].Rows[0][0].ToString();
                hdname.Value = ds.Tables[1].Rows[0][1].ToString() + " " + ds.Tables[1].Rows[0][2].ToString();
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    public class users
    {
        public string user;
        public string grp;
    }
    [WebMethod]
    public static users GetAllData()
    {
        string res = "";
        string type = "";
        string uid = "";
        string img = "";
        string stat = "";
        users usr = new users();
        HttpCookie Type = HttpContext.Current.Request.Cookies["Type"];
        string Types = Type != null ? Type.Value.Split('=')[1] : "undefined";

        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";

        HttpCookie Name = HttpContext.Current.Request.Cookies["Name"];
        string Names = Name != null ? Name.Value.Split('=')[1] : "undefined";

        try
        {
            BLLIndex bllindex = new BLLIndex();
            if (Types == "Admin")
            {
                type = "Admin";
                uid = "";
            }
            else
            {
                type = Types;
                uid = User_Ids;
            }
            DataSet ds = bllindex.GetAllData(type, uid);
            usr.user += "<li class='sidebar-brand' style='height: 92px;border-bottom: 1px solid #dedede;'>" +
                        "<div class='col-md-12 pill' style='font-weight: bold;color: black;border-bottom: 0;'>" +
                            "<img src='img/weblogo.png' style='height:86px;'/>" +
                       "</div>";
            usr.user += "<li class='sidebar-brand' style='height: 70px;border-bottom: 1px solid #dedede;'>" +
                        "<div class='col-md-12 pill' style='font-weight: bold;color: black;border-bottom: 0;'>" +
                        "<img src='dp/" + imagename + "' class='md-user-image' style='width: 60px;height: 60px;visibility: visible;margin-left: -64px;'/>" +
                        "<span id='lblname' style='margin-left:15px;'>" + Names + "</span>" +
                        "<span class='fa fa-cogs' onclick='userset(" + User_Ids + ")'></span>" +
                       "</div>" +
                   "</li>" +
                   "<li><input type='text' id='myInput' class='form-control' onkeyup='searchnames()' placeholder='Search for names..' title='Type in a name'></li>";
            if (ds.Tables[0].Rows.Count > 0)
            {
                usr.user += "<div class='scrollbar' id='ex3' clientidmode='static'><ul id='myUL' style='list-style-type:none;padding:0;'>";

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    img = (ds.Tables[0].Rows[i]["Image"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["Image"].ToString();
                    if (ds.Tables[0].Rows[i]["Status"].ToString().Trim() == "Online")
                    {
                        stat = "success";
                    }
                    else if (ds.Tables[0].Rows[i]["Status"].ToString().Trim() == "Offline")
                    {
                        stat = "danger";
                    }
                    else
                    {
                        stat = "warning";
                    }
                    usr.user += "<li id='usr" + ds.Tables[0].Rows[i]["User_Id"].ToString() + "' onclick='chatbox(this);'>" +
                          "<a class='pill' href='#' name='002'>" +
                          "<img src='dp/" + img + "' onerror='this.onerror=null;this.src='dp/no.png'' class='md-user-image' style='height:60px;width: 60px;margin-left:-17%;margin-right:5%; ' />" +
                          "<span id='headname' name='" + ds.Tables[0].Rows[i]["Dept"].ToString() + "'>" + ds.Tables[0].Rows[i]["First_Name"].ToString() + " " + ds.Tables[0].Rows[i]["Last_Name"].ToString() + "</span><span class='indicator label-" + stat + "' style='margin-left: 2%;'></span>" +
                          "</a>" +
                          "</li>";
                }
                usr.user += "</ul><div>";
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                usr.grp += "<div class='scrollbar' id='ex4'>";
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    usr.grp += "<li id='grp" + ds.Tables[1].Rows[i]["Grp_Id"].ToString() + "' onclick='chatbox(this);' data-dismiss='modal'>" +
                          "<a class='pill' href='#' name='001'>" +
                          "<img src='img/group.png' style='width: 11%;margin-left:-17%;margin-right:5%;' /><span id='headname'>" + ds.Tables[1].Rows[i]["Name"].ToString() + "</span>" +
                          "</a>" +
                          "</li>";
                }
            }


        }
        catch (Exception ex)
        {
            usr.grp = ex.Message;
        }
        return usr;
    }

    [WebMethod]
    public static string SendMessage(string recid, string msg, string role)
    {
        string res = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            if (role == "002")
            {
                StructSaveMessage objmsg = new StructSaveMessage();
                objmsg.Attach_Id = "0";
                objmsg.Note_Id = "0";
                objmsg.User_Id = User_Ids;
                objmsg.Receiver_Id = recid;
                objmsg.Message = msg;
                objmsg.Type = "Msg";
                objmsg.Added_By = User_Ids;
                objmsg.Added_Date = DateTime.Now;
                objmsg.Attach = "";
                DataSet ds = bllindex.SaveMessage(objmsg);
                res = "success";
            }
            else
            {
                StructSaveGrpMessage objgrp = new StructSaveGrpMessage();
                objgrp.Attach_Id = "0";
                objgrp.Note_Id = "0";
                objgrp.Grp_Id = recid;
                objgrp.Sender_Id = User_Ids;
                objgrp.Message = msg;
                objgrp.Type = "Msg";
                objgrp.Added_By = User_Ids;
                objgrp.Added_Date = DateTime.Now;
                objgrp.Attach = "";
                DataSet ds = bllindex.SaveGrpMessage(objgrp);
                res = "success";
            }

        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    public class allmsg
    {
        public string dat;
        public string lastseen;
    }
    [WebMethod]
    public static allmsg GetAllMessages(string recid, string type)
    {
        allmsg msg = new allmsg();
        string res = "";
        string img = "";
        string element = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            if (type == "usr")
            {
                DataSet ds = bllindex.GetAllMessages(recid, User_Ids);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        img = "";
                        element = "";
                        string[] arr = ds.Tables[0].Rows[i]["Attachment"].ToString().Split('.');
                        if (arr.Length > 1)
                        {
                            if (arr[1].ToLower() == "jpg" || arr[1].ToLower() == "png" || arr[1].ToLower() == "gif")
                            {
                                element = "<div class='col-md-12 text-center' style='border-radius:6px;margin-bottom:3%; '><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' onclick='openmodal(this);' style='width:150px;height:150px;margin-bottom:1%;color: white;border-radius:18px;'></img><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                            }
                            else if (arr[1].ToLower() == "mp4" || arr[1].ToLower() == "avi" || arr[1].ToLower() == "flv" || arr[1].ToLower() == "wmv" || arr[1].ToLower() == "mov" || arr[1].ToLower() == "3gp")
                            {
                                element = "<div class='col-md-12 text-center'><video width='200' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1].ToLower() + "'></video></video></div>";
                            }
                            else
                            {
                                element = "<div class='col-md-12 text-center'><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='color:white;' target='_blank'>" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "</a><a style='margin-left:4%;' href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                            }
                        }
                        if ((i + 1) == ds.Tables[0].Rows.Count)
                        {
                            res += "<div class='ulid' style='display:none;'>" + ds.Tables[0].Rows[i]["Chat_User_Id"].ToString() + "</div>";
                        }
                        if (ds.Tables[0].Rows[i]["Added_By"].ToString() == User_Ids)
                        {
                            img = "";
                            img = (ds.Tables[0].Rows[i]["User_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["User_Pic"].ToString();
                            res += "<div class='chat_message_wrapper chat_message_right'>" +
                                    "<div class='chat_user_avatar'>" +
                                        "<a href='#' target='_blank'>" +
                                           "<img src='dp/" + img + "' class='md-user-image' style='height: 40px;width: 40px;' >" +
                                        "</a>" +
                                    "</div>" +
                                    "<ul class='chat_message'>" +
                                        "<li>" + element +
                                            "<p style='color:white;'>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:white;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                            "</p>" +
                                        "</li>" +

                                    "</ul>" +
                                "</div>";

                        }
                        else
                        {
                            img = "";
                            img = (ds.Tables[0].Rows[i]["Receiver_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["Receiver_Pic"].ToString();
                            res += "<div class='chat_message_wrapper'>" +
                                        "<div class='chat_user_avatar'>" +
                                            "<a href='#' target='_blank'>" +
                                                "<img  src='dp/" + img + "' class='md-user-image' style='height: 40px;width: 40px;'>" +
                                            "</a>" +
                                        "</div>" +
                                        "<ul class='chat_message'>" +
                                            "<li>" + element +
                                                "<p>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:black;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                                "</p>" +
                                            "</li>" +
                                        "</ul>" +
                                   "</div>";
                            msg.lastseen = Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm tt");
                        }
                    }
                    msg.dat = res;
                }
                else
                {
                    recid = "1";
                }
            }
            else
            {
                DataSet ds = bllindex.GetAllGrpMessages(recid);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        element = "";
                        string[] arr = ds.Tables[0].Rows[i]["Attachment"].ToString().Split('.');
                        if (arr.Length > 1)
                        {
                            if (arr[1].ToLower() == "jpg" || arr[1].ToLower() == "png" || arr[1].ToLower() == "gif")
                            {
                                element = "<div class='col-md-12 text-center' style='border-radius:6px;margin-bottom:3%;'><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='width:150px;height:150px;margin-bottom:1%;border-radius:18px;' onclick='openmodal(this);'></img><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                            }
                            else if (arr[1].ToLower() == "mp4" || arr[1].ToLower() == "avi" || arr[1].ToLower() == "flv" || arr[1].ToLower() == "wmv" || arr[1].ToLower() == "mov" || arr[1].ToLower() == "3gp")
                            {
                                element = "<div class='col-md-12 text-center'><video width='200' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1].ToLower() + "'></video></video></div>";
                            }
                            else
                            {
                                element = "<div class='col-md-12 text-center'><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='color:white;' target='_blank'>" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "</a><a style='margin-left:4%;' href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                            }
                        }
                        if ((i + 1) == ds.Tables[0].Rows.Count)
                        {
                            res += "<div class='glid' style='display:none;'>" + ds.Tables[0].Rows[i]["Chat_Group_Id"].ToString() + "</div>";
                        }
                        if (ds.Tables[0].Rows[i]["Added_By"].ToString() == User_Ids)
                        {
                            img = "";
                            img = (ds.Tables[0].Rows[i]["User_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["User_Pic"].ToString();
                            res += "<div class='chat_message_wrapper chat_message_right'>" +
                                    "<div class='chat_user_avatar'>" +
                                        "<a href='#' target='_blank'>" +
                                           "<img src='dp/" + img + "' class='md-user-image' style='height: 40px;width: 40px;'>" +
                                        "</a>" +
                                    "</div>" +
                                    "<ul class='chat_message'>" +
                                        "<li>" + element +
                                            "<p style='color:white;'>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:white;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                            "</p>" +
                                        "</li>" +

                                    "</ul>" +
                                "</div>";

                        }
                        else
                        {
                            img = "";
                            img = (ds.Tables[0].Rows[i]["User_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["User_Pic"].ToString();
                            res += "<div class='chat_message_wrapper'>" +
                                        "<div class='chat_user_avatar'>" +
                                            "<a href='#' target='_blank'>" +
                                                "<img  src='dp/" + img + "' class='md-user-image' style='height: 40px;width: 40px;'>" +
                                            "</a>" +
                                        "</div>" +
                                        "<ul class='chat_message'>" +
                                            "<li>" +
                                                "<p style='font-weight: bold;'>" + ds.Tables[0].Rows[i]["Name"].ToString() + "</p>" + element +
                                                "<p>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:black;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                                "</p>" +
                                            "</li>" +
                                        "</ul>" +
                                   "</div>";
                            msg.lastseen = Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm tt");
                        }
                    }
                    msg.dat = res;
                    //get all grp messages

                }
            }

        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return msg;
    }

    [WebMethod]
    public static string GetAllGrpMessages(string recid)
    {
        string res = "";
        try
        {

        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }


    public class usermsg
    {
        public string user;
        public string lstid;
        public string lastseen;
    }
    [WebMethod]
    public static usermsg GetUserMsg(string Last_Id, string Rec_Id)
    {
        string res = "";
        string img = "";
        string element = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        usermsg usr = new usermsg();
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.GetUserMsg(Rec_Id, User_Ids, Last_Id);
            if (ds.Tables[0].Rows.Count == 0)
            {
                usr.user = "0";
            }
            else
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if ((i + 1) == ds.Tables[0].Rows.Count)
                    {
                        usr.lstid += ds.Tables[0].Rows[i]["Chat_User_Id"].ToString();
                    }
                    if (ds.Tables[0].Rows[i]["Added_By"].ToString() == User_Ids)
                    {
                        img = "";
                        element = "";
                        img = (ds.Tables[0].Rows[i]["User_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["User_Pic"].ToString();

                        string[] arr = ds.Tables[0].Rows[i]["Attachment"].ToString().Split('.');
                        if (arr.Length > 1)
                        {
                            if (arr[1].ToLower() == "jpg" || arr[1].ToLower() == "png" || arr[1].ToLower() == "gif")
                            {
                                element = "<div class='col-md-12 text-center' style='background-color: white;border-radius:6px;margin-bottom:3%; '><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='width:150px;height:160px;margin-bottom:1%;' onclick='openmodel(this)'></img></div>";
                            }
                            else if (arr[1].ToLower() == "mp4" || arr[1].ToLower() == "avi" || arr[1].ToLower() == "flv" || arr[1].ToLower() == "wmv" || arr[1].ToLower() == "mov" || arr[1].ToLower() == "3gp")
                            {
                                element = "<div class='col-md-12 text-center'><video width='200' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1].ToLower() + "'></video></video></div>";
                            }
                            else
                            {
                                element = "<div class='col-md-12 text-center'><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "'>" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "</a><a style='margin-left:4%;' href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                            }
                        }
                        usr.user += "<div class='chat_message_wrapper chat_message_right'>" +
                                "<div class='chat_user_avatar'>" +
                                    "<a href='#' target='_blank'>" +
                                       "<img  src='dp/" + img + "' class='md-user-image'>" +
                                    "</a>" +
                                "</div>" +
                                "<ul class='chat_message'>" +
                                    "<li>" + element +
                                        "<p style='color:white;'>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:white;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                        "</p>" +
                                    "</li>" +

                                "</ul>" +
                            "</div>";
                        //usr.lastseen = Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm tt");
                    }
                    else
                    {
                        img = "";
                        element = "";
                        img = (ds.Tables[0].Rows[i]["Receiver_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["Receiver_Pic"].ToString();
                        string[] arr = ds.Tables[0].Rows[i]["Attachment"].ToString().Split('.');
                        if (arr.Length > 1)
                        {
                            if (arr[1].ToLower() == "jpg" || arr[1].ToLower() == "png" || arr[1].ToLower() == "gif")
                            {
                                element = "<div class='col-md-12 text-center' style='background-color: white;border-radius:6px;margin-bottom:3%; '><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='width:150px;height:160px;margin-bottom:1%;'  onclick='openmodel(this)'></img></div>";
                            }
                            else if (arr[1].ToLower() == "mp4" || arr[1].ToLower() == "avi" || arr[1].ToLower() == "flv" || arr[1].ToLower() == "wmv" || arr[1].ToLower() == "mov" || arr[1].ToLower() == "3gp")
                            {
                                element = "<div class='col-md-12 text-center'><video width='200' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1].ToLower() + "'></video></video></div>";
                            }
                            else
                            {
                                element = "<div class='col-md-12 text-center'><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "'>" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "</a><a style='margin-left:4%;' href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                            }
                        }
                        usr.user += "<div class='chat_message_wrapper'>" +
                                    "<div class='chat_user_avatar'>" +
                                        "<a href='#' target='_blank'>" +
                                            "<img src='dp/" + img + "' class='md-user-image' style='height:40px;width:40px; '>" +
                                        "</a>" +
                                    "</div>" +
                                    "<ul class='chat_message'>" +
                                        "<li>" + element +
                                            //"<p style='font-weight: bold;'>" + ds.Tables[0].Rows[i]["Name"].ToString() + "</p>" +
                                            "<p>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:black;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                            "</p>" +
                                        "</li>" +
                                    "</ul>" +
                               "</div>";
                    }
                }
            }

        }
        catch (Exception ex)
        {
            usr.user = ex.Message;
        }
        return usr;
    }

    [WebMethod]
    public static string SharePost(string post)
    {
        string res = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.GetPosts(post, User_Ids, DateTime.Now.ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                res += "<div class='col-sm-12'>" +
                            "<div class='panel panel-white post panel-shadow'>" +
                            "<div class='post-heading'>" +
                            "<div class='pull-left image'>" +
                            "<img src='dp/" + ds.Tables[0].Rows[0]["Image"].ToString() + "' class='img-circle avatar' alt='user profile image'>" +
                            "</div>" +
                            "<div class='pull-left meta'>" +
                            "<div class='title h5'>" +
                            "<a href='#'><b>" + ds.Tables[0].Rows[0]["First_Name"].ToString() + " " + ds.Tables[0].Rows[0]["Last_Name"].ToString() + "</b></a> </div>" +
                            "<h6 class='text-muted time'>" + BLLCommon.TimeAgo(Convert.ToDateTime(ds.Tables[0].Rows[0]["Added_Date"].ToString())) + "</h6>" +
                            "</div>" +
                            "</div>" +
                            "<div class='post-description'>" +
                            "<div style='top:10;'><p>" + post + "</p></div>" +
                            "<span  id='lbllike" + ds.Tables[1].Rows[0]["Post_Id"].ToString() + "' onclick='like(this)' class='fa fa-heart' style='font-size: 25px;margin-left: 3%;color:black;'></span>" +
                            "<span class='fa fa-comments' onclick='comments(" + ds.Tables[1].Rows[0]["Post_Id"].ToString() + ")' style='font-size: 27px;margin-left: 3%;'></span>" +
                            "<div style='margin-top:2%;margin-left:5%;font-weight:800;'><span id='likehit" + ds.Tables[1].Rows[0]["Post_Id"].ToString() + "'>0</span> Likes</div>" +
                            "</div>" +
                            "</div>" +
                            "</div>";
            }
            //create a post html.
            //res = "success";

        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static usermsg GetGrpMsg(string Last_Id, string Rec_Id)
    {
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        usermsg usr = new usermsg();
        string res = "";
        string img = "";
        string element = "";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.GetGrpMsg(Rec_Id, Last_Id, User_Ids);
            if (ds.Tables[0].Rows.Count == 0)
            {
                usr.user = "0";
            }
            else
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    element = "";
                    string[] arr = ds.Tables[0].Rows[i]["Attachment"].ToString().Split('.');
                    if (arr.Length > 1)
                    {
                        if (arr[1] == "jpg" || arr[1] == "png" || arr[1] == "gif")
                        {
                            element = "<div class='col-md-12 text-center' style='border-radius:6px;margin-bottom:3%;'><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='width:150px;height:160px;margin-bottom:1%;border-radius:18px;' onclick='openmodal(this);'></img><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                        }
                        else if (arr[1] == "mp4" || arr[1] == "avi" || arr[1] == "flv" || arr[1] == "wmv" || arr[1] == "mov" || arr[1] == "3gp")
                        {
                            element = "<div class='col-md-12 text-center'><video width='200' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1] + "'></video></video></div>";
                        }
                        else
                        {
                            element = "<div class='col-md-12 text-center'><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "'>" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "</a><a style='margin-left:4%;' href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                        }
                    }
                    if ((i + 1) == ds.Tables[0].Rows.Count)
                    {
                        usr.lstid += ds.Tables[0].Rows[i]["Chat_Group_Id"].ToString();
                    }
                    if (ds.Tables[0].Rows[i]["Added_By"].ToString() == User_Ids)
                    {
                        img = "";
                        img = (ds.Tables[0].Rows[i]["User_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["User_Pic"].ToString();
                        usr.user += "<div class='chat_message_wrapper chat_message_right'>" +
                                "<div class='chat_user_avatar'>" +
                                    "<a href='#' target='_blank'>" +
                                       "<img  src='dp/" + img + "' class='md-user-image'>" +
                                    "</a>" +
                                "</div>" +
                                "<ul class='chat_message'>" +
                                    "<li>" + element +
                                        "<p style='color:white;'>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:white;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                        "</p>" +
                                    "</li>" +

                                "</ul>" +
                            "</div>";
                    }
                    else
                    {
                        img = "";
                        img = (ds.Tables[0].Rows[i]["User_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["User_Pic"].ToString();
                        usr.user += "<div class='chat_message_wrapper'>" +
                                        "<div class='chat_user_avatar'>" +
                                            "<a href='#' target='_blank'>" +
                                                "<img  src='dp/" + img + "' class='md-user-image' style='height: 40px;width: 40px;'>" +
                                            "</a>" +
                                        "</div>" +
                                        "<ul class='chat_message'>" +
                                            "<li>" +
                                                "<p style='font-weight: bold;'>" + ds.Tables[0].Rows[i]["Name"].ToString() + "</p>" + element +
                                                "<p>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:black;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                                "</p>" +
                                            "</li>" +
                                        "</ul>" +
                                   "</div>";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return usr;
    }

    public class userinfo
    {
        public string desc;
        public string stat;
    }
    [WebMethod]
    public static userinfo GetUserDesc(string id)
    {
        userinfo ufo = new userinfo();
        try
        {
            BLLIndex index = new BLLIndex();
            DataSet ds = index.GetUserDesc(id);
            ufo.desc = ds.Tables[0].Rows[0]["Description"].ToString();
            ufo.stat = ds.Tables[0].Rows[0]["Status"].ToString();

        }
        catch (Exception ex)
        {

        }
        return ufo;
    }

    public class post
    {
        public string lid;
        public string posts;
    }
    [WebMethod]
    public static post GetAllPost(string id)
    {
        post pst = new post();
        string res = "";
        string element = "";
        string like = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.GetLatestPost(id, User_Ids);
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string[] arr = ds.Tables[0].Rows[i]["Attachment"].ToString().Split('.');
                    if (arr.Length > 1)
                    {
                        if (arr[1] == "jpg" || arr[1] == "png" || arr[1] == "gif")
                        {
                            element = "<div class='col-md-12 text-center'><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='width:300px;height:275px;margin-bottom:3%;'></img></div>";
                        }
                        else if (arr[1] == "mp4" || arr[1] == "avi" || arr[1] == "flv" || arr[1] == "wmv" || arr[1] == "mov" || arr[1] == "3gp")
                        {
                            element = "<div class='col-md-12 text-center'><video width='350' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1] + "'></video></div>";
                        }
                        else
                        {
                            element = "<div class='col-md-12 text-center'><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "'>" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "</a><a style='margin-left:4%;' href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                        }
                    }
                    if (ds.Tables[0].Rows[i]["Likes"].ToString().Split(',').Contains(User_Ids))
                    {

                        like = "color:red;";
                    }
                    else
                    {
                        like = "color:black";
                    }
                    pst.posts += "<div class='col-sm-12'>" +
                                "<div class='panel panel-white post panel-shadow'>" +
                                "<div class='post-heading'>" +
                                "<div class='pull-left image'>" +
                                "<img src='dp/" + ds.Tables[0].Rows[i]["Image"].ToString() + "' class='img-circle avatar' alt='user profile image'>" +
                                "</div>" +
                                "<div class='pull-left meta'>" +
                                "<div class='title h5'>" +
                                "<a href='#'><b>" + ds.Tables[0].Rows[i]["Name"].ToString() + "</b></a> </div>" +
                                "<h6 class='text-muted time'>" + BLLCommon.TimeAgo(Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString())) + "</h6>" +
                                "</div>" +
                                "</div>" +
                                "<div class='post-description'>" +
                                element +
                                "<p>" + ds.Tables[0].Rows[i]["Message"].ToString() + "</p>" +
                                "<span id='lbllike" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + "' onclick='like(this)' class='fa fa-heart' style='font-size: 25px;margin-left: 3%;" + like + "'></span>" +
                                "<span class='fa fa-comments' onclick='comments(" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + ")' style='font-size: 27px;margin-left: 3%;'></span>" +
                                "<div style='margin-top:2%;margin-left:5%;font-weight:800;'><span id='likehit" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + "'>" + ds.Tables[0].Rows[i]["Lcount"].ToString() + "</span> Likes</div>" +
                                "</div>" +
                                "</div>" +
                                "</div>";
                }

            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                pst.lid = ds.Tables[1].Rows[0][0].ToString();
            }

        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return pst;
    }

    [WebMethod]
    public static string PostWithFile(string text, string filename, string image, string name, string post, string role, string recid)
    {
        string res = "";
        string element = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            if (post == "chat")
            {

                string[] arr = GetLatestFileName().Split('.');
                if (arr[1].ToLower() == "jpg" || arr[1].ToLower() == "png" || arr[1].ToLower() == "gif")
                {
                    element = "<div class='col-md-12 text-center' style='background-color: white;border-radius:6px;margin-bottom:3%; '><img src='dp/" + GetLatestFileName() + "' style='width:150px;height:160px;margin-bottom:1%;' onclick='openmodal(this);'></img></div>";
                }
                else if (arr[1].ToLower() == "mp4" || arr[1].ToLower() == "avi" || arr[1].ToLower() == "flv" || arr[1].ToLower() == "wmv" || arr[1].ToLower() == "mov" || arr[1].ToLower() == "3gp")
                {
                    element = "<div class='col-md-12 text-center'><video width='200' controls><source src='dp/" + GetLatestFileName() + "' type='video/" + arr[1].ToLower() + "'></video></video></div>";
                }
                else
                {
                    element = "<div class='col-md-12 text-center'><a href='dp/" + GetLatestFileName() + "' style='color:white;' target='_blank'>" + GetLatestFileName() + "</a><a style='margin-left:4%;' href='dp/" + GetLatestFileName() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                }
                if (role == "002")
                {
                    StructSaveMessage objmsg = new StructSaveMessage();
                    objmsg.Attach_Id = "0";
                    objmsg.Note_Id = "0";
                    objmsg.User_Id = User_Ids;
                    objmsg.Receiver_Id = recid;
                    objmsg.Message = text;
                    objmsg.Type = "Msg";
                    objmsg.Added_By = User_Ids;
                    objmsg.Added_Date = DateTime.Now;
                    objmsg.Attach = GetLatestFileName();
                    DataSet ds = bllindex.SaveMessage(objmsg);
                    res = "<div class='chat_message_wrapper chat_message_right'>" +
                                "<div class='chat_user_avatar'>" +
                                    "<a href='#' target='_blank'>" +
                                       "<img src='dp/" + image + "' class='md-user-image' style='height: 40px;width: 40px;' >" +
                                    "</a>" +
                                "</div>" +
                                "<ul class='chat_message'>" +
                                    "<li>" + element +
                                        "<p style='color:white;'>" + text + "<span class='chat_message_time' style='color:white;'></span>" +
                                        "</p>" +
                                    //"<span  onclick='like(this)' class='fa fa-heart' style='font-size: 25px;margin-left: 3%;color:black'></span>" +
                                    //"<span class='fa fa-comments'  style='font-size: 27px;margin-left: 3%;'></span>" +

                                    "</li>" +

                                "</ul>" +
                            "</div>";
                }
                else
                {
                    StructSaveGrpMessage objgrp = new StructSaveGrpMessage();
                    objgrp.Attach_Id = "0";
                    objgrp.Note_Id = "0";
                    objgrp.Grp_Id = recid;
                    objgrp.Sender_Id = User_Ids;
                    objgrp.Message = text;
                    objgrp.Type = "Msg";
                    objgrp.Added_By = User_Ids;
                    objgrp.Added_Date = DateTime.Now;
                    objgrp.Attach = GetLatestFileName();
                    DataSet ds = bllindex.SaveGrpMessage(objgrp);
                    res = "<div class='chat_message_wrapper chat_message_right'>" +
                                "<div class='chat_user_avatar'>" +
                                    "<a href='#' target='_blank'>" +
                                       "<img src='dp/" + image + "' class='md-user-image' style='height: 40px;width: 40px;' >" +
                                    "</a>" +
                                "</div>" +
                                "<ul class='chat_message'>" +
                                    "<li>" + element +
                                        "<p style='color:white;'>" + text + "<span class='chat_message_time' style='color:white;'></span>" +
                                        "</p>" +
                                    "</li>" +

                                "</ul>" +
                            "</div>";
                }
            }
            else
            {
                DataSet ds = bllindex.GetPostsAttach(text, User_Ids, DateTime.Now.ToString(), GetLatestFileName());
                string[] arr = GetLatestFileName().Split('.');
                if (arr[1].ToLower() == "jpg" || arr[1].ToLower() == "png" || arr[1].ToLower() == "gif")
                {
                    element = "<div class='col-md-12 text-center'><img src='dp/" + GetLatestFileName() + "' style='width:300px;height:275px;margin-bottom:3%;'></img></div>";
                }
                else if (arr[1].ToLower() == "mp4" || arr[1].ToLower() == "avi" || arr[1].ToLower() == "flv" || arr[1].ToLower() == "wmv" || arr[1].ToLower() == "mov" || arr[1].ToLower() == "3gp")
                {
                    element = "<div class='col-md-12 text-center'><video width='350' controls><source src='dp/" + GetLatestFileName() + "' type='video/" + arr[1] + "'></video></video></div>";
                }
                else
                {
                    element = "<div class='col-md-12 text-center'><a href='dp/" + GetLatestFileName() + "' style='color:white;' target='_blank'>" + GetLatestFileName() + "</a><a style='margin-left:4%;' href='dp/" + GetLatestFileName() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                }
                res += "<div class='col-sm-12'>" +
                           "<div class='panel panel-white post panel-shadow'>" +
                               "<div class='post-heading'>" +
                                    "<div class='pull-left image'>" +
                                        "<img src='dp/" + image + "' class='img-circle avatar' alt='user profile image'>" +
                                    "</div>" +
                                "<div class='pull-left meta'>" +
                                    "<div class='title h5'>" +
                                        "<a href='#'><b>" + name + "</b></a> made a post.</div>" +
                                        "<h6 class='text-muted time'>Now</h6>" +
                                    "</div>" +
                                "</div>" +
                                "<div class='post-description'>" + element +
                                    "<div style='top:10;'><p>" + ((text == "") ? "&nbsp;&nbsp;&nbsp;" : text) + "</p></div>" +
                                    "<span  id='lbllike" + ds.Tables[0].Rows[0]["Post_Id"].ToString() + "' onclick='like(this)' class='fa fa-heart' style='font-size: 25px;margin-left: 3%;color:black;'></span>" +
                                    "<span class='fa fa-comments' onclick='comments(" + ds.Tables[0].Rows[0]["Post_Id"].ToString() + ")' style='font-size: 27px;margin-left: 3%;'></span>" +
                                    "<div style='margin-top:2%;margin-left:5%;font-weight:800;'><span id='likehit" + ds.Tables[0].Rows[0]["Post_Id"].ToString() + "'>0</span> Likes</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>";
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    public class user
    {
        public string fname;
        public string lname;
        public string desig;
        public string username;
        public string pass;
        public string deptid;
        public string email;
        public string image;
        public string desc;
    }
    [WebMethod]
    public static user GetProfile(string id)
    {
        string res = "";
        user ur = new user();
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.EditUser(id);
            ur.fname = ds.Tables[0].Rows[0]["First_Name"].ToString();
            ur.lname = ds.Tables[0].Rows[0]["Last_Name"].ToString();
            //ur.desig = ds.Tables[0].Rows[0]["Designation"].ToString();
            //ur.deptid = ds.Tables[0].Rows[0]["Dept_Id"].ToString();
            //ur.username = ds.Tables[0].Rows[0]["Username"].ToString();
            //ur.pass = ds.Tables[0].Rows[0]["Password"].ToString();
            ur.email = ds.Tables[0].Rows[0]["Email"].ToString();
            //ur.image = ds.Tables[0].Rows[0]["Image"].ToString();
            ur.desc = ds.Tables[0].Rows[0]["Description"].ToString();
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return ur;
    }

    [WebMethod]
    public static string UpdateProfile(string desc, string filename, string fname, string lname, string email)
    {
        string res = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            structSaveUser objuser = new structSaveUser();
            objuser.First_Name = fname;
            objuser.Last_Name = lname;

            objuser.Email = email;
            objuser.Modified_By = "Admin";
            objuser.Modified_Date = DateTime.Now;
            objuser.User_Id = User_Ids;
            objuser.Image = (filename == "" ? filename : GetLatestFileName());
            objuser.Description = desc;
            DataSet ds = bllindex.UpdateUserChat(objuser);
            res = ds.Tables[0].Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string GetLatestMessage()
    {
        string res = "";
        string ele = "";
        string img = "";
        string stat = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.GetLatestMessage(User_Ids);
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    img = "";
                    if (ds.Tables[0].Rows[i]["msgcount"].ToString() == "")
                    {
                        ele = "";
                    }
                    else
                    {
                        ele = "<span style='color:#b62929;font-size:15px;font-weight:800;' id='lblcount" + ds.Tables[0].Rows[i]["User_Id"].ToString() + "'>" + ((ds.Tables[0].Rows[i]["msgcount"].ToString() == "") ? "0" : ds.Tables[0].Rows[i]["msgcount"].ToString()) + " msg</span>";
                    }
                    if (ds.Tables[0].Rows[i]["Image"].ToString().Trim() == "")
                    {
                        img = "no.png";
                    }
                    else
                    {
                        img = ds.Tables[0].Rows[i]["Image"].ToString().Trim();
                    }
                    if (ds.Tables[0].Rows[i]["Status"].ToString().Trim() == "Online")
                    {
                        stat = "success";
                    }
                    else if (ds.Tables[0].Rows[i]["Status"].ToString().Trim() == "Offline")
                    {
                        stat = "danger";
                    }
                    else
                    {
                        stat = "warning";
                    }
                    res += "<li id='usr" + ds.Tables[0].Rows[i]["User_Id"].ToString() + "' onclick='chatbox(this);'>" +
                          "<a class='pill' href='#' name='002'>" +
                          "<img src='dp/" + img + "'  class='md-user-image' style='height:60px;width: 60px;margin-left:-17%;margin-right:5%; ' />" +
                          "<span id='headname' name='" + ds.Tables[0].Rows[i]["Dept"].ToString() + "'>" + ds.Tables[0].Rows[i]["Name"].ToString() + "</span><span class='indicator label-"+stat+ "' style='margin-left: 2%;'></span>" +
                          ele +
                          "</a>" +
                          "</li>";

                }

            }

        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string AddLike(string postid)
    {
        string res = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.Likes(User_Ids, postid);
            res = "1";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string RemoveLike(string postid)
    {
        string res = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.UnLike(User_Ids, postid);
            res = "1";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string AddComment(string Post_Id, string comment)
    {
        string res = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.AddComment(comment, User_Ids, DateTime.Now, Post_Id);
            res = "<div class='chat_message_wrapper'>" +
                                    "<div class='chat_user_avatar'>" +
                                    "<a href='#' target='_blank'>" +
                                    "<img src='dp/" + ds.Tables[0].Rows[0]["Image"].ToString() + "' class='md-user-image' style='height: 40px; width: 40px;'>" +
                                    "</a>" +
                                    "</div>" +
                                    "<ul class='chat_message'>" +
                                    "<li>" +
                                    "<p style='font-weight: bold;'>" + ds.Tables[0].Rows[0]["First_Name"].ToString() + " " + ds.Tables[0].Rows[0]["Last_Name"].ToString() + "</p>" +
                                    "<p>" + ds.Tables[0].Rows[0]["Comment"].ToString() + "</p>" +
                                    "</li>" +
                                    "</ul>" +
                                    "</div>";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    public class comm
    {
        public string cmnt;
        public string post;
    }
    [WebMethod]
    public static comm GetComment(string Post_Id)
    {
        comm cm = new comm();
        string res = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.GetAllComments(Post_Id);
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        if (ds.Tables[0].Rows[0]["Attachment"].ToString() != "")
                        {
                            // cm.post = "<div>" + ds.Tables[0].Rows[0]["Message"].ToString() + "</div>";
                            string[] arr = ds.Tables[0].Rows[0]["Attachment"].ToString().Split('.');
                            if (arr.Length > 1)
                            {
                                if (arr[1].ToLower() == "jpg" || arr[1].ToLower() == "png" || arr[1].ToLower() == "gif")
                                {
                                    //cm.post = "<div class='col-md-12 text-center' style='background-color: white;border-radius:6px;margin-bottom:3%; '><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='width:150px;height:160px;margin-bottom:1%;'></img></div>";
                                    cm.post = "<div class='thumbnail'>" +
                                                "<a href='/dp/" + ds.Tables[0].Rows[0]["Attachment"].ToString() + "' target='_blank'>" +
                                                "<img src='/dp/" + ds.Tables[0].Rows[0]["Attachment"].ToString() + "' alt='Lights' style='width: 100%'>" +
                                                "<div class='caption'>" +
                                                "<p>" + ds.Tables[0].Rows[0]["Message"].ToString() + "</p>" +
                                                "</div>" +
                                                "</a>" +
                                                "</div>";
                                }
                                else if (arr[1].ToLower() == "mp4" || arr[1].ToLower() == "avi" || arr[1].ToLower() == "flv" || arr[1].ToLower() == "wmv" || arr[1].ToLower() == "mov" || arr[1].ToLower() == "3gp")
                                {
                                    //cm.post = "<div class='col-md-12 text-center'><video width='200' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1] + "'></video></video></div>";
                                    cm.post = "<div class='thumbnail'>" +
                                                "<a href='/dp/" + ds.Tables[0].Rows[0]["Attachment"].ToString() + "' target='_blank'>" +
                                                "<video width='200' controls><source src='dp/" + ds.Tables[0].Rows[0]["Attachment"].ToString() + "' type='video/" + arr[1].ToLower() + "'></video></video>" +
                                                "<div class='caption'>" +
                                                "<p>" + ds.Tables[0].Rows[0]["Message"].ToString() + "</p>" +
                                                "</div>" +
                                                "</a>" +
                                                "</div>";
                                }
                                else
                                {
                                    cm.post = "<div class='col-md-12 text-center'><a href='dp/" + ds.Tables[0].Rows[0]["Attachment"].ToString() + "' style='color:white;' target='_blank'>" + ds.Tables[0].Rows[0]["Attachment"].ToString() + "</a></div>" +
                                                "<p>" + ds.Tables[0].Rows[0]["Message"].ToString() + "</p>";
                                }
                            }
                        }
                        else
                        {
                            cm.post = "<div class='col-md-12'>" + ds.Tables[0].Rows[0]["Message"].ToString() + "</div>";
                        }
                    }
                    cm.cmnt += "<div class='chat_message_wrapper'>" +
                                    "<div class='chat_user_avatar'>" +
                                    "<a href='#' target='_blank'>" +
                                    "<img src='dp/" + ds.Tables[0].Rows[i]["Image"].ToString() + "' class='md-user-image' style='height: 40px; width: 40px;'>" +
                                    "</a>" +
                                    "</div>" +
                                    "<ul class='chat_message'>" +
                                    "<li>" +
                                    "<p style='font-weight: bold;'>" + ds.Tables[0].Rows[i]["First_Name"].ToString() + " " + ds.Tables[0].Rows[i]["Last_Name"].ToString() + "</p>" +
                                    "<p>" + ds.Tables[0].Rows[i]["Comment"].ToString() + "</p>" +
                                    "</li>" +
                                    "</ul>" +
                                    "</div>";
                }
            }
            else
            {
                cm.cmnt = "No Comment found";
                DataSet ds1 = bllindex.GetPost(Post_Id);
                if (ds1.Tables[0].Rows[0]["Attachment"].ToString() != "")
                {
                    // cm.post = "<div>" + ds.Tables[0].Rows[0]["Message"].ToString() + "</div>";
                    string[] arr = ds1.Tables[0].Rows[0]["Attachment"].ToString().Split('.');
                    if (arr.Length > 1)
                    {
                        if (arr[1] == "jpg" || arr[1] == "png" || arr[1] == "gif")
                        {
                            //cm.post = "<div class='col-md-12 text-center' style='background-color: white;border-radius:6px;margin-bottom:3%; '><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='width:150px;height:160px;margin-bottom:1%;'></img></div>";
                            cm.post = "<div class='thumbnail'>" +
                                        "<a href='/dp/" + ds1.Tables[0].Rows[0]["Attachment"].ToString() + "' target='_blank'>" +
                                        "<img src='/dp/" + ds1.Tables[0].Rows[0]["Attachment"].ToString() + "' alt='Lights' style='width: 100%'>" +
                                        "<div class='caption'>" +
                                        "<p>" + ds1.Tables[0].Rows[0]["Message"].ToString() + "</p>" +
                                        "</div>" +
                                        "</a>" +
                                        "</div>";
                        }
                        else if (arr[1] == "mp4" || arr[1] == "avi" || arr[1] == "flv" || arr[1] == "wmv" || arr[1] == "mov" || arr[1] == "3gp")
                        {
                            //cm.post = "<div class='col-md-12 text-center'><video width='200' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1] + "'></video></video></div>";
                            cm.post = "<div class='thumbnail'>" +
                                        "<a href='/dp/" + ds1.Tables[0].Rows[0]["Attachment"].ToString() + "' target='_blank'>" +
                                        "<video width='200' controls><source src='dp/" + ds1.Tables[0].Rows[0]["Attachment"].ToString() + "' type='video/" + arr[1] + "'></video></video>" +
                                        "<div class='caption'>" +
                                        "<p>" + ds1.Tables[0].Rows[0]["Message"].ToString() + "</p>" +
                                        "</div>" +
                                        "</a>" +
                                        "</div>";
                        }
                        else
                        {
                            cm.post = "<div class='col-md-12 text-center'><a href='dp/" + ds1.Tables[0].Rows[0]["Attachment"].ToString() + "' style='color:white;' target='_blank'>" + ds1.Tables[0].Rows[0]["Attachment"].ToString() + "</a></div>" +
                                        "<p>" + ds1.Tables[0].Rows[0]["Message"].ToString() + "</p>";
                        }
                    }
                }
                else
                {
                    cm.post = "<div class='col-md-12'>" + ds1.Tables[0].Rows[0]["Message"].ToString() + "</div>";
                }
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return cm;
    }


    protected void Logoutlink_Click(object sender, EventArgs e)
    {
        BLLIndex bllindex = new BLLIndex();
        HttpCookie User_Ida = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Ida != null ? User_Ida.Value.Split('=')[1] : "undefined";
        DataSet ds = bllindex.UpdateStatus(User_Ids, "Offline");

        HttpCookie User_Id = new HttpCookie("User_Id");
        HttpCookie Name = new HttpCookie("Name");
        HttpCookie Type = new HttpCookie("Type");



        User_Id.Expires = DateTime.Now.AddDays(30);
        Name.Expires = DateTime.Now.AddDays(30);
        Type.Expires = DateTime.Now.AddDays(30);

        Response.Cookies.Add(User_Id);
        Response.Cookies.Add(Name);
        Response.Cookies.Add(Type);
        Response.Redirect("index.aspx");

    }

    [WebMethod]
    public static string UpdateStatus(string status)
    {
        string res = "";
        HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
        string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.UpdateStatus(User_Ids, status);
            res = "success";

        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string RemoveFile()
    {
        string res = "";
        try
        {
            //return Path.GetDirectoryName(Path.GetFullPath("download.png"));
            //var abc=GetPath("download.png");
            //return abc;
            string folder = @"../dp/";
            var files = new DirectoryInfo(folder).GetFiles("*.*");
            string latestfile = "";

            DateTime lastupdated = DateTime.MinValue;

            foreach (FileInfo file in files)
            {
                if (file.LastWriteTime > lastupdated)
                {
                    lastupdated = file.LastWriteTime;
                    latestfile = file.Name;
                    file.Delete();
                }
            }
            res = "success";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    public static string GetLatestFileName()
    {
        string res = "";
        try
        {
            string folder = @"../dp/";  // @"G:/Code_And _DB_Schema1/Code_And _DB_Schema/chat/chat/dp/;
            var files = new DirectoryInfo(folder).GetFiles("*.*");
            string latestfile = "";

            DateTime lastupdated = DateTime.MinValue;

            foreach (FileInfo file in files)
            {
                if (file.LastWriteTime > lastupdated)
                {
                    lastupdated = file.LastWriteTime;
                    latestfile = file.Name;
                    res = latestfile;
                }
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string GetSearchResults(string data,string type,string uid)
    {
        string res = "";
        string img = "";
        string element = "";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            HttpCookie User_Id = HttpContext.Current.Request.Cookies["User_Id"];
            string User_Ids = User_Id != null ? User_Id.Value.Split('=')[1] : "undefined";

            DataSet ds = bllindex.GetSearchResult(uid, User_Ids, data);
            if(ds.Tables[0].Rows.Count == 0)
            {
                res = "1";
            }
            else
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    img = "";
                    element = "";
                    string[] arr = ds.Tables[0].Rows[i]["Attachment"].ToString().Split('.');
                    if (arr.Length > 1)
                    {
                        if (arr[1].ToLower() == "jpg" || arr[1].ToLower() == "png" || arr[1].ToLower() == "gif")
                        {
                            element = "<div class='col-md-12 text-center' style='border-radius:6px;margin-bottom:3%; '><img src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' onclick='openmodal(this);' style='width:150px;height:150px;margin-bottom:1%;color: white;border-radius:18px;'></img><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                        }
                        else if (arr[1].ToLower() == "mp4" || arr[1].ToLower() == "avi" || arr[1].ToLower() == "flv" || arr[1].ToLower() == "wmv" || arr[1].ToLower() == "mov" || arr[1].ToLower() == "3gp")
                        {
                            element = "<div class='col-md-12 text-center'><video width='200' controls><source src='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1].ToLower() + "'></video></video></div>";
                        }
                        else
                        {
                            element = "<div class='col-md-12 text-center'><a href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' style='color:white;' target='_blank'>" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "</a><a style='margin-left:4%;' href='dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' download><i class='fa fa-download' style='color: white;vertical-align: bottom;font-size: 18px;'></i></a></div>";
                        }
                    }
                    if (ds.Tables[0].Rows[i]["Added_By"].ToString() == User_Ids)
                    {
                        img = "";
                        img = (ds.Tables[0].Rows[i]["User_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["User_Pic"].ToString();
                        res += "<div class='chat_message_wrapper chat_message_right'>" +
                                "<div class='chat_user_avatar'>" +
                                    "<a href='#' target='_blank'>" +
                                       "<img src='dp/" + img + "' class='md-user-image' style='height: 40px;width: 40px;' >" +
                                    "</a>" +
                                "</div>" +
                                "<ul class='chat_message'>" +
                                    "<li>" + element +
                                        "<p style='color:white;'>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:white;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                        "</p>" +
                                    "</li>" +

                                "</ul>" +
                            "</div>";

                    }
                    else
                    {
                        img = "";
                        img = (ds.Tables[0].Rows[i]["Receiver_Pic"].ToString() == "") ? "no.png" : ds.Tables[0].Rows[i]["Receiver_Pic"].ToString();
                        res += "<div class='chat_message_wrapper'>" +
                                    "<div class='chat_user_avatar'>" +
                                        "<a href='#' target='_blank'>" +
                                            "<img  src='dp/" + img + "' class='md-user-image' style='height: 40px;width: 40px;'>" +
                                        "</a>" +
                                    "</div>" +
                                    "<ul class='chat_message'>" +
                                        "<li>" + element +
                                            "<p>" + ds.Tables[0].Rows[i]["Message"].ToString() + "<span class='chat_message_time' style='color:black;'>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm") + "</span>" +
                                            "</p>" +
                                        "</li>" +
                                    "</ul>" +
                               "</div>";
                       // msg.lastseen = Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("hh:mm tt");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }
}
