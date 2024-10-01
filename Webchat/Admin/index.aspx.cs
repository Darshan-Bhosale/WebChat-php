using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Script.Serialization;
using AppCode;

public partial class Admin_ALogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string Login(string email, string pass)
    {
        string res = "";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.LoginAdmin(email, pass);
            if(ds.Tables[0].Rows.Count > 0)
            {
                res = "success";
                HttpCookie AUser_Id = new HttpCookie("AUser_Id");

                HttpContext.Current.Session["AUser_Id"] = ds.Tables[0].Rows[0]["User_Id"].ToString();

                AUser_Id.Values["AUser_Id"] = ds.Tables[0].Rows[0]["User_Id"].ToString();

                HttpContext.Current.Response.Cookies.Add(AUser_Id);
            }
            else
            {
                res = "fail";
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }
}