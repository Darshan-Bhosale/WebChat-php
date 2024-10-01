using AppCode;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Downld : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["rec"] != null)
        {
            string[] req = Request.QueryString["rec"].ToString().Split('|');
           // Response.Write(req[0] + "-" + req[1]);
            createfile(req[0],req[1]);
        }

    }

    private void createfile(string added, string receive)
    {
        MemoryStream ms = new MemoryStream();
        TextWriter tw = new StreamWriter(ms);
        //Write to a file
        //BllChatHistory bllchat = new BllChatHistory();
        BLLIndex bllindex = new BLLIndex();
        DataSet ds = bllindex.GetAllMessages(receive, added);
        //DataSet ds = bllchat.DownloadChat(added, receive);
        if (ds.Tables[0].Rows.Count > 0)
        {

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string add = ds.Tables[0].Rows[i]["Added_By"].ToString();

                if (add == added)
                {
                    tw.WriteLine("-------------------------------------------------------------------------------------");
                    tw.WriteLine(ds.Tables[0].Rows[i]["User_Name"].ToString()+" : "+ ds.Tables[0].Rows[i]["Message"].ToString()+"........("+ Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("dd/MM/yyyy hh:mm:ss tt") + ")");  
                }
                else
                {
                    tw.WriteLine(ds.Tables[0].Rows[i]["Receiver_Name"].ToString()+" : "+ ds.Tables[0].Rows[i]["Message"].ToString()+"........("+ Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("dd / MM / yyyy hh: mm:ss tt") + ")");
                }
            }
            //End
            tw.Flush();
            byte[] bytes = ms.ToArray();
            ms.Close();

            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment;filename=file.txt");
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}