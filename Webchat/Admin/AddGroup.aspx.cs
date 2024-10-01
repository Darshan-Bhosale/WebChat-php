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

public partial class Admin_AddGroup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //getusers();
    }

    private void getusers()
    {
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.GetUser();
            //chkusers.DataSource = ds;
            //chkusers.DataTextField = "First_Name";
            //chkusers.DataValueField = "User_Id";
            //chkusers.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    [WebMethod]
    public static string SaveGroup(string name, string user, string desc)
    {
        string res = "";
        try
        {
            BLLGroup bllgrp = new BLLGroup();
            StructSaveGroup objgrp = new StructSaveGroup();
            objgrp.Name = name;
            objgrp.User_Id = user;
            objgrp.Description = desc;
            objgrp.Added_By = "Admin";
            objgrp.Added_Date = DateTime.Now;
            DataSet ds = bllgrp.SaveGroup(objgrp);
            res = "success";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }
    [WebMethod]
    public static string GetGroup()
    {
        string res = "";
        try
        {
            BLLGroup bllgrp = new BLLGroup();
            DataSet ds = bllgrp.GetGroup();
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        res += "<table class='table'><thead><tr><th>Sr.No</th><th>Group Name</th><th>Action</th></tr></thead><tbody>";
                    }
                    res += "<tr><td>" + (i + 1) + "</td><td>" + ds.Tables[0].Rows[i]["Name"].ToString() + "</td><td><div class='fa fa-pencil' onclick='editgrp(" + ds.Tables[0].Rows[i]["Grp_Id"].ToString() + ")' style='color: #8ad919;'></div><div class='fa fa-trash' onclick='deletegrp(" + ds.Tables[0].Rows[i]["Grp_Id"].ToString() + ")' style='margin-left:12%;color: #f9243f;'></div></td></tr>";
                }
                res += "</tbody></html>";
            }
            else
            {
                res += "No Groups Found";
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    public class group
    {
        public string name;
        public string desc;
        public string userid;
    }
    [WebMethod]
    public static group EditGroup(string id)
    {
        group gp = new group();
        try
        {
            BLLGroup bllgrp = new BLLGroup();
            DataSet ds = bllgrp.GetGroupById(id);
            gp.name = ds.Tables[0].Rows[0]["Name"].ToString();
            gp.desc = ds.Tables[0].Rows[0]["Description"].ToString();
            gp.userid = ds.Tables[0].Rows[0]["User_Id"].ToString();
        }
        catch (Exception ex)
        {

        }
        return gp;
    }
    [WebMethod]
    public static string GetUsers()
    {
        string res = "";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.GetUser();
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    res += "<div class='checkbox'><label><input type = 'checkbox' value ='" + ds.Tables[0].Rows[i]["User_Id"].ToString() + "' clientidmode='static'/>" + ds.Tables[0].Rows[i]["First_Name"].ToString() + " " + ds.Tables[0].Rows[i]["Last_Name"].ToString() + "</label></div>";
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
    public static string UpdateGroup(string name, string user, string desc,string id)
    {
        string res = "";
        try
        {
            BLLGroup bllgrp = new BLLGroup();
            StructSaveGroup objgrp = new StructSaveGroup();
            objgrp.Name = name;
            objgrp.User_Id = user;
            objgrp.Description = desc;
            objgrp.Modified_By = "Admin";
            objgrp.Modified_Date = DateTime.Now;
            objgrp.Grp_Id = id;
            DataSet ds = bllgrp.UpdateGroup(objgrp);
            res = "success";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }
}