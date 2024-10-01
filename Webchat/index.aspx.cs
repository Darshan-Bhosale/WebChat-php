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

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //int i=FileUpload1.PostedFiles.Count();
    }
    [WebMethod]
    public static string Logind(string user, string pass)
    {
        string res = "";
        try
        {
            BLLIndex bllindex = new BLLIndex();
            DataSet ds = bllindex.Login(user, pass);
            if (ds.Tables[0].Rows.Count > 0)
            {
                HttpCookie User_Id = new HttpCookie("User_Id");
                HttpCookie Name = new HttpCookie("Name");
                HttpCookie Type = new HttpCookie("Type");

                HttpContext.Current.Session["User_Id"] = ds.Tables[0].Rows[0]["User_Id"].ToString();
                HttpContext.Current.Session["Type"] = ds.Tables[0].Rows[0]["Type"].ToString();
                HttpContext.Current.Session["Name"] = ds.Tables[0].Rows[0]["First_Name"].ToString() + " " + ds.Tables[0].Rows[0]["Last_Name"].ToString();

                User_Id.Values["User_Id"] = ds.Tables[0].Rows[0]["User_Id"].ToString();
                Name.Values["Name"] = ((ds.Tables[0].Rows[0]["First_Name"].ToString() + " " + ds.Tables[0].Rows[0]["Last_Name"].ToString()).Length > 13) ? ds.Tables[0].Rows[0]["First_Name"].ToString() : ds.Tables[0].Rows[0]["First_Name"].ToString() + " " + ds.Tables[0].Rows[0]["Last_Name"].ToString();
                Type.Values["Type"] = ds.Tables[0].Rows[0]["Type"].ToString();

                HttpContext.Current.Response.Cookies.Add(User_Id);
                HttpContext.Current.Response.Cookies.Add(Name);
                HttpContext.Current.Response.Cookies.Add(Type);

                DataSet ds1 = bllindex.UpdateStatus(ds.Tables[0].Rows[0]["User_Id"].ToString(), "Online");

                res = "success";
            }
            else
            {
                res = "failure";
            }
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }

    [WebMethod]
    public static string ResetPassword(string email)
    {
        string res = "";
        try
        {
            BLLGroup bllgrp = new BLLGroup();
            DataSet ds = bllgrp.GetUserMail(email);
            if(ds.Tables[0].Rows.Count == 0)
            {
                res = "not";
                return res;
            }
            string body = "<html xmlns='http://www.w3.org/1999/xhtml'>" +
"<head>" +
"	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />" +
"	<meta name='viewport' content='width=device-width, initial-scale=1.0'/>" +
"	<title>Passord Reset</title>" +
"	<style type='text/css'>" +
"@media screen and (max-width: 600px) {" +
"    table[class='container'] {" +
"        width: 95% !important;" +
"    }" +
"}" +
"	#outlook a {padding:0;}" +
"		body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}" +
"		.ExternalClass {width:100%;}" +
"		.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}" +
"		#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}" +
"		img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}" +
"		a img {border:none;}" +
"		.image_fix {display:block;}" +
"		p {margin: 1em 0;}" +
"		h1, h2, h3, h4, h5, h6 {color: black !important;}" +
"		h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}" +
"		h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {" +
"			color: red !important; " +
"		 }" +
"		h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {" +
"			color: purple !important; " +
"		}" +
"		table td {border-collapse: collapse;}" +
"		table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }" +
"		a {color: #000;}" +
"		@media only screen and (max-device-width: 480px) {" +
"			a[href^='tel'], a[href^='sms'] {" +
"						text-decoration: none;" +
"						color: black; /* or whatever your want */" +
"						pointer-events: none;" +
"						cursor: default;" +
"					}" +
"			.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {" +
"						text-decoration: default;" +
"						color: orange !important; /* or whatever your want */" +
"						pointer-events: auto;" +
"						cursor: default;" +
"					}" +
"		}" +
"		@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {" +
"			a[href^='tel'], a[href^='sms'] {" +
"						text-decoration: none;" +
"						color: blue; /* or whatever your want */" +
"						pointer-events: none;" +
"						cursor: default;" +
"					}" +
"			.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {" +
"						text-decoration: default;" +
"						color: orange !important;" +
"						pointer-events: auto;" +
"						cursor: default;" +
"					}" +
"		}" +
"		@media only screen and (-webkit-min-device-pixel-ratio: 2) {" +
"			/* Put your iPhone 4g styles in here */" +
"		}" +
"		@media only screen and (-webkit-device-pixel-ratio:.75){" +
"			/* Put CSS for low density (ldpi) Android layouts in here */" +
"		}" +
"		@media only screen and (-webkit-device-pixel-ratio:1){" +
"			/* Put CSS for medium density (mdpi) Android layouts in here */" +
"		}" +
"		@media only screen and (-webkit-device-pixel-ratio:1.5){" +
"			/* Put CSS for high density (hdpi) Android layouts in here */" +
"		}" +
"		/* end Android targeting */" +
"		h2{" +
"			color:#181818;" +
"			font-family:Helvetica, Arial, sans-serif;" +
"			font-size:22px;" +
"			line-height: 22px;" +
"			font-weight: normal;" +
"		}" +
"		a.link1{" +
"		}" +
"		a.link2{" +
"			color:#fff;" +
"			text-decoration:none;" +
"			font-family:Helvetica, Arial, sans-serif;" +
"			font-size:16px;" +
"			color:#fff;border-radius:4px;" +
"		}" +
"		p{" +
"			color:#555;" +
"			font-family:Helvetica, Arial, sans-serif;" +
"			font-size:16px;" +
"			line-height:160%;" +
"		}" +
"	</style>" +
"<script type='colorScheme' class='swatch active'>" +
"  {" +
"    'name':'Default'," +
"    'bgBody':'ffffff'," +
"    'link':'fff'," +
"    'color':'555555'," +
"    'bgItem':'ffffff'," +
"    'title':'181818'" +
"  }" +
"</script>" +
"</head>" +
"<body>" +
"	<table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'>" +
"	<tr>" +
"		<td>" +
"	<table cellpadding='0' width='620' class='container' align='center' cellspacing='0' border='0'>" +
"	<tr>" +
"		<td>" +
"		<table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='container'>" +
"			<tr>" +
"				<td class='movableContentContainer bgItem'>" +
"					<div class='movableContent'>" +
"						<table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='container'>" +
"							<tr height='40'>" +
"								<td width='200'>&nbsp;</td>" +
"								<td width='200'>&nbsp;</td>" +
"								<td width='200'>&nbsp;</td>" +
"							</tr>" +
"							<tr>" +
"								<td width='200' valign='top'>&nbsp;</td>" +
"								<td width='200' valign='top' align='center'>" +
"									<div class='contentEditableContainer contentImageEditable'>" +
"					                	<div class='contentEditable' align='center' >" +
"					                  		<img src='https://www.thespartanpoker.com/c/i/logo.png' alt='Logo'  data-default='placeholder' />" +
"					                	</div>" +
"					              	</div>" +
"								</td>" +
"								<td width='200' valign='top'>&nbsp;</td>" +
"							</tr>" +
"							<tr height='25'>" +
"								<td width='200'>&nbsp;</td>" +
"								<td width='200'>&nbsp;</td>" +
"								<td width='200'>&nbsp;</td>" +
"							</tr>" +
"						</table>" +
"					</div>" +
"					<div class='movableContent'>" +
"						<table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='container'>" +
"							<tr>" +
"								<td width='100'>&nbsp;</td>" +
"								<td width='400' align='center'>" +
"									<div class='contentEditableContainer contentTextEditable'>" +
"					                	<div class='contentEditable' align='left' >" +
"					                  		<p style='color:#555;font-family:Helvetica,Arial,sans-serif;font-size:16px;line-height:160%;' >Hi There," +
"					                  			<br/>" +
"												Click on the link below to Reset your credentails.</p>" +
"					                	</div>" +
"					              	</div>" +
"								</td>" +
"								<td width='100'>&nbsp;</td>" +
"							</tr>" +
"						</table>" +
"						<table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='container'>" +
"							<tr>" +
"								<td width='200'>&nbsp;</td>" +
"								<td width='200' align='center' style='padding-top:25px;'>" +
"									<table cellpadding='0' cellspacing='0' border='0' align='center' width='200' height='50'>" +
"										<tr>" +
"											<td bgcolor='#dd1a00' align='center' style='border-radius:4px;' width='200' height='50'>" +
"												<div class='contentEditableContainer contentTextEditable'>" +
"								                	<div class='contentEditable' align='center' >" +
"								                  		<a target='_blank' href='http://localhost:50974/PassReset.aspx?email=" + BLLCommon.EncodeTo64(email) + "' class='link2' style='text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Click here to reset it</a>" +
"								                	</div>" +
"								              	</div>" +
"											</td>" +
"										</tr>" +
"									</table>" +
"								</td>" +
"								<td width='200'>&nbsp;</td>" +
"							</tr>" +
"						</table>" +
"					</div>" +
"					<div class='movableContent'>" +
"						<table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='container'>" +
"							<tr>" +
"								<td width='100%' colspan='2' style='padding-top:65px;'>" +
"									<hr style='height:1px;border:none;color:#333;background-color:#ddd;' />" +
"								</td>" +
"							</tr>" +
"							<tr>" +
"								<td width='60%' height='70' valign='middle' style='padding-bottom:20px;'>" +
"									<div class='contentEditableContainer contentTextEditable'>" +
"					                	<div class='contentEditable' align='left' >" +
"					                  		<span style='font-size:13px;color:#181818;font-family:Helvetica, Arial, sans-serif;line-height:200%;'>© 2016 Copyright thespartanpoker.com. All Rights Reserved.</span>" +
"											<br/>" +
"					                	</div>" +
"					              	</div>" +
"								</td>" +
"							</tr>" +
"						</table>" +
"					</div>" +
"				</td>" +
"			</tr>" +
"		</table>" +
"	</td></tr></table>" +
"		</td>" +
"	</tr>" +
"	</table>" +
"</body>" +
"</html>";

            BLLCommon.SendEmail(email, "Spartan poker - Password Reset", body);
            res = "success";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }
}