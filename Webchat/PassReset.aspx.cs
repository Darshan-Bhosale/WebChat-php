using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AppCode;
using System.Web.Services;
using System.Data;

public partial class PassReset : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["email"] != null)
        {
            //Response.Write(BLLCommon.DecodeFrom64(Request.QueryString["email"].ToString()));
            txtemail.Value = BLLCommon.DecodeFrom64(Request.QueryString["email"].ToString());
        }
    }

    [WebMethod]
    public static string ResetPassword(string email,string pass)
    {
        string res = "";
        try
        {
            BLLGroup bllgrp = new BLLGroup();
            DataSet ds = bllgrp.ResetPassword(email, pass);
            res = "success";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }
}