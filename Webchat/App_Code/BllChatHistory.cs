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
/// Summary description for BllChatHistory
/// </summary>
public class BllChatHistory
{
    public string conn = BLLCommon.conn;
    public BllChatHistory()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataSet GetAllUsers()
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from User_Master");
        return ds;
    }
    public DataSet GetDetails(string id)
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from User_Master where User_Id not in (" + id + ")");
        return ds;
    }
    public DataSet DeleteChat(string Added, string Received)
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "delete from Chat_Master_User where Added_By=" + Added + " and Receiver_Id in (" + Received + ")");
        return ds;
    }

    public DataSet DownloadChat(string Added, string Received)
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select (select First_Name+' '+Last_Name from User_Master where User_Id=" + Added + " )as User_Pic," +
                                                                  "(select First_Name + ' ' + Last_Name from User_Master where User_Id = " + Received + " ) as Receiver_Pic," +
                                                                  "* from Chat_Master_User cmu" +
                                                                  "where (Added_By in (" + Added + ") or Added_By in (" + Received + ")) and" +
                                                                  "(Receiver_Id in(" + Added + ") and User_Id in (" + Received + ")) or" +
                                                                  "(Receiver_Id in(" + Received + ") and User_Id in (" + Added + "))" +
                                                                  "order by Added_Date asc");
        return ds;
    }

    public DataSet UpdateAdmin(string Password, string username, string id, string name)
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "update User_Master set Password='" + Password + "',Username='" + username + "',First_Name='" + name + "' where Type='Admin' and User_Id ='" + id + "'");
        return ds;
    }
    public DataSet GetDetails()
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from User_Master where Type='Admin'");
        return ds;
    }
    public DataSet GetStats()
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select Count(*) from Chat_Master_Group;select Count(*) from Chat_Master_User;select Count(*) from User_Master;select Count(*) from Group_Master;select Count(*) from Comments_Master;");
        return ds;
    }

    public DataSet AddAdmin(string user, string pass, string name, DateTime date)
    {
        SqlParameter[] sparams = new SqlParameter[4];
        sparams[0] = new SqlParameter("@Username", SqlDbType.NVarChar);
        sparams[0].Value = user;
        sparams[1] = new SqlParameter("@Password", SqlDbType.NVarChar);
        sparams[1].Value = pass;
        sparams[2] = new SqlParameter("@Name", SqlDbType.NVarChar);
        sparams[2].Value = name;
        sparams[3] = new SqlParameter("@Added_Date", SqlDbType.DateTime);
        sparams[3].Value = date;
        DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "Proc_AddAdmin", sparams);
        return ds;
    }

    public DataSet DeleteAdmin(string id)
    {
        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "delete from User_Master where User_Id in (" + id + ")");
        return ds;
    }

    public DataSet GetAllAdmins()
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from User_Master where Type='Admin'");
        return ds;
    }

    public DataSet GetAdminById(string id)
    {
        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from User_Master where User_Id='" + id + "'");
        return ds;
    }
}