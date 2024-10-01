<%@ WebHandler Language="C#" Class="UploadHandler" %>

using System;
using System.Web;
using System.IO;

public class UploadHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Files.Count > 0)
        {
            HttpFileCollection files = context.Request.Files;
            for (int i = 0; i < files.Count; i++)
            {
                HttpPostedFile file = files[i];
                string[] arr = file.FileName.Split('.');
                string imagename = arr[0] + "."+ arr[1].ToLower();
                var formattedFileName = string.Format("{0}-{1}{2}"
                                        , Path.GetFileNameWithoutExtension(imagename)
                                        , Guid.NewGuid().ToString("N")
                                        , Path.GetExtension(imagename));
                string fname = context.Server.MapPath("~/dp/" + formattedFileName);
                file.SaveAs(fname);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write("File Uploaded Successfully!");
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}