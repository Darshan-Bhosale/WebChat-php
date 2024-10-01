using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using AppCode;
using System.Text;

/// <summary>
/// Summary description for BllPost
/// </summary>
public class BllPost
{
    public string conn = BLLCommon.conn;
    public BllPost()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataSet GetAllPosts()
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select (select Count(*) from SplitString((select Likes from Post_Master where Post_Id=pm.Post_Id),',')) as Likes,(select Count(*) from Comments_Master where Post_Id in (pm.Post_Id)) as Comments,um.First_Name+' '+um.Last_Name as Name,um.Image,pm.* from Post_Master pm join User_Master um on pm.Added_By=um.User_Id  order by pm.Added_Date desc");
        return ds;
    }
    public DataSet DeletePosts(string id)
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "Delete from Post_Master where Post_Id=" + id + "");
        return ds;
    }
}