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
public partial class Admin_MasterAdmin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //protected void Logoutlink_Click(object sender, EventArgs e)
    //{
    //    BLLIndex bllindex = new BLLIndex();
    //    HttpCookie User_Ida = HttpContext.Current.Request.Cookies["AUser_Id"];
    //    string User_Ids = User_Ida != null ? User_Ida.Value.Split('=')[1] : "undefined";
        
    //    HttpCookie User_Id = new HttpCookie("AUser_Id");
        
    //    User_Id.Expires = DateTime.Now.AddDays(30);
        

    //    Response.Cookies.Add(User_Id);
        
    //    Response.Redirect("index.aspx");

    //}
}
