using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using AppCode;
using System.Text;

namespace AppCode
{
    /// <summary>
    /// Summary description for BLLIndex
    /// </summary>

    public struct structSaveDept
    {
        public string Name;
        public string Description;
        public string Added_By;
        public DateTime Added_Date;
        public string Modified_By;
        public DateTime Modified_Date;
        public string Dept_Id;
    }
    public struct structSaveUser
    {
        public string First_Name;
        public string Last_Name;
        public string Designation;
        public string Department;
        public string Username;
        public string Password;
        public string Email;
        public string Added_By;
        public DateTime Added_Date;
        public string User_Id;
        public string Modified_By;
        public DateTime Modified_Date;
        public string Image;
        public string Description;

    }

    public struct StructSaveMessage
    {
        public string User_Id;
        public string Receiver_Id;
        public string Message;
        public string Type;
        public string Added_By;
        public DateTime Added_Date;
        public string Modified_By;
        public DateTime Modified_Date;
        public string Attach_Id;
        public string Note_Id;
        public string Attach;

    }

    public struct StructSaveGrpMessage
    {
        public string Attach_Id;
        public string Note_Id;
        public string Grp_Id;
        public string Sender_Id;
        public string Message;
        public string Type;
        public string Added_By;
        public DateTime Added_Date;
        public string Modified_By;
        public DateTime Modified_Date;
        public string Attach;


    }
    public class BLLIndex
    {
        public string conn = BLLCommon.conn;
        public BLLIndex()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public DataSet SaveDept(structSaveDept objdept)
        {
            SqlParameter[] sparams = new SqlParameter[4];
            sparams[0] = new SqlParameter("@Name", SqlDbType.NVarChar);
            sparams[0].Value = objdept.Name;
            sparams[1] = new SqlParameter("@Description", SqlDbType.NVarChar);
            sparams[1].Value = objdept.Description;
            sparams[2] = new SqlParameter("@Added_By", SqlDbType.NVarChar);
            sparams[2].Value = objdept.Added_By;
            sparams[3] = new SqlParameter("@Added_Date", SqlDbType.DateTime);
            sparams[3].Value = objdept.Added_Date;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_savedept", sparams);
            return ds;
        }

        public DataSet SaveUser(structSaveUser objuser)
        {
            SqlParameter[] sparams = new SqlParameter[11];
            sparams[0] = new SqlParameter("@Dept_Id", SqlDbType.NVarChar);
            sparams[0].Value = objuser.Department;
            sparams[1] = new SqlParameter("@First_Name", SqlDbType.NVarChar);
            sparams[1].Value = objuser.First_Name;
            sparams[2] = new SqlParameter("@Last_Name", SqlDbType.NVarChar);
            sparams[2].Value = objuser.Last_Name;
            sparams[3] = new SqlParameter("@Designation", SqlDbType.NVarChar);
            sparams[3].Value = objuser.Designation;
            sparams[4] = new SqlParameter("@Username", SqlDbType.NVarChar);
            sparams[4].Value = objuser.Username;
            sparams[5] = new SqlParameter("@Password", SqlDbType.NVarChar);
            sparams[5].Value = objuser.Password;
            sparams[6] = new SqlParameter("@Email", SqlDbType.NVarChar);
            sparams[6].Value = objuser.Email;
            sparams[7] = new SqlParameter("@Added_By", SqlDbType.NVarChar);
            sparams[7].Value = objuser.Added_By;
            sparams[8] = new SqlParameter("@Added_Date", SqlDbType.DateTime);
            sparams[8].Value = objuser.Added_Date;
            sparams[9] = new SqlParameter("@Image", SqlDbType.NVarChar);
            sparams[9].Value = objuser.Image;
            sparams[10] = new SqlParameter("@Description", SqlDbType.NVarChar);
            sparams[10].Value = objuser.Description;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_saveuser", sparams);
            return ds;
        }

        public DataSet GetDepartment()
        {

            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select Dept_Id,Name from Department_Master");
            return ds;
        }
        public DataSet GetDept()
        {

            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from Department_Master");
            return ds;
        }
        public DataSet EditDept(string id)
        {

            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from Department_Master where Dept_Id=" + id + "");
            return ds;
        }
        public DataSet GetUser()
        {

            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from User_Master");
            return ds;
        }
        public DataSet EditUser(string id)
        {

            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from User_Master where User_Id=" + id + "");
            return ds;
        }

        public DataSet UpdateDept(structSaveDept objdept)
        {
            SqlParameter[] sparams = new SqlParameter[5];
            sparams[0] = new SqlParameter("@Name", SqlDbType.NVarChar);
            sparams[0].Value = objdept.Name;
            sparams[1] = new SqlParameter("@Description", SqlDbType.NVarChar);
            sparams[1].Value = objdept.Description;
            sparams[2] = new SqlParameter("@Modified_By", SqlDbType.NVarChar);
            sparams[2].Value = objdept.Modified_By;
            sparams[3] = new SqlParameter("@Modified_Date", SqlDbType.DateTime);
            sparams[3].Value = objdept.Modified_Date;
            sparams[4] = new SqlParameter("@Dept_Id", SqlDbType.NVarChar);
            sparams[4].Value = objdept.Dept_Id;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_updatedept", sparams);
            return ds;
        }

        public DataSet UpdateUser(structSaveUser objuser)
        {
            SqlParameter[] sparams = new SqlParameter[12];
            sparams[0] = new SqlParameter("@Dept_Id", SqlDbType.NVarChar);
            sparams[0].Value = objuser.Department;
            sparams[1] = new SqlParameter("@First_Name", SqlDbType.NVarChar);
            sparams[1].Value = objuser.First_Name;
            sparams[2] = new SqlParameter("@Last_Name", SqlDbType.NVarChar);
            sparams[2].Value = objuser.Last_Name;
            sparams[3] = new SqlParameter("@Designation", SqlDbType.NVarChar);
            sparams[3].Value = objuser.Designation;
            sparams[4] = new SqlParameter("@Username", SqlDbType.NVarChar);
            sparams[4].Value = objuser.Username;
            sparams[5] = new SqlParameter("@Password", SqlDbType.NVarChar);
            sparams[5].Value = objuser.Password;
            sparams[6] = new SqlParameter("@Email", SqlDbType.NVarChar);
            sparams[6].Value = objuser.Email;
            sparams[7] = new SqlParameter("@Modified_By", SqlDbType.NVarChar);
            sparams[7].Value = objuser.Modified_By;
            sparams[8] = new SqlParameter("@Modified_Date", SqlDbType.DateTime);
            sparams[8].Value = objuser.Modified_Date;
            sparams[9] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[9].Value = objuser.User_Id;
            sparams[10] = new SqlParameter("@Image", SqlDbType.NVarChar);
            sparams[10].Value = objuser.Image;
            sparams[11] = new SqlParameter("@Description", SqlDbType.NVarChar);
            sparams[11].Value = objuser.Description;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_updateuser", sparams);
            return ds;
        }

        public DataSet UpdateUserChat(structSaveUser objuser)
        {
            SqlParameter[] sparams = new SqlParameter[8];

            sparams[0] = new SqlParameter("@First_Name", SqlDbType.NVarChar);
            sparams[0].Value = objuser.First_Name;
            sparams[1] = new SqlParameter("@Last_Name", SqlDbType.NVarChar);
            sparams[1].Value = objuser.Last_Name;
            sparams[2] = new SqlParameter("@Email", SqlDbType.NVarChar);
            sparams[2].Value = objuser.Email;
            sparams[3] = new SqlParameter("@Modified_By", SqlDbType.NVarChar);
            sparams[3].Value = objuser.Modified_By;
            sparams[4] = new SqlParameter("@Modified_Date", SqlDbType.DateTime);
            sparams[4].Value = objuser.Modified_Date;
            sparams[5] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[5].Value = objuser.User_Id;
            sparams[6] = new SqlParameter("@Image", SqlDbType.NVarChar);
            sparams[6].Value = objuser.Image;
            sparams[7] = new SqlParameter("@Description", SqlDbType.NVarChar);
            sparams[7].Value = objuser.Description;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_UpdateUserChat", sparams);
            return ds;
        }

        public DataSet CheckDeptAssign(string id)
        {

            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select Dept_Id from User_Master where Dept_Id in(" + id + ")");
            return ds;
        }

        public DataSet DeleteAll(string id, string type)
        {
            SqlParameter[] sparams = new SqlParameter[2];
            sparams[0] = new SqlParameter("@Id", SqlDbType.NVarChar);
            sparams[0].Value = id;
            sparams[1] = new SqlParameter("@Type", SqlDbType.NVarChar);
            sparams[1].Value = type;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_DeleteAll", sparams);
            return ds;
        }

        public DataSet GetAllData(string type, string userid)
        {

            SqlParameter[] sparams = new SqlParameter[2];
            sparams[0] = new SqlParameter("@Type", SqlDbType.NVarChar);
            sparams[0].Value = type;
            sparams[1] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[1].Value = userid;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_GetAllData", sparams);
            return ds;
        }
        public DataSet Login(string user, string pass)
        {
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from User_Master where Username='" + user + "' and Password='" + pass + "'");
            return ds;
        }
        public DataSet SaveMessage(StructSaveMessage objmsg)
        {

            SqlParameter[] sparams = new SqlParameter[9];
            sparams[0] = new SqlParameter("@Attach_Id", SqlDbType.NVarChar);
            sparams[0].Value = objmsg.Attach_Id;
            sparams[1] = new SqlParameter("@Note_Id", SqlDbType.NVarChar);
            sparams[1].Value = objmsg.Note_Id;
            sparams[2] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[2].Value = objmsg.User_Id;
            sparams[3] = new SqlParameter("@Receiver_Id", SqlDbType.NVarChar);
            sparams[3].Value = objmsg.Receiver_Id;
            sparams[4] = new SqlParameter("@Message", SqlDbType.NVarChar);
            sparams[4].Value = objmsg.Message;
            sparams[5] = new SqlParameter("@Type", SqlDbType.NVarChar);
            sparams[5].Value = objmsg.Type;
            sparams[6] = new SqlParameter("@Added_By", SqlDbType.NVarChar);
            sparams[6].Value = objmsg.Added_By;
            sparams[7] = new SqlParameter("@Added_Date", SqlDbType.DateTime);
            sparams[7].Value = objmsg.Added_Date;
            sparams[8] = new SqlParameter("@Attach", SqlDbType.NVarChar);
            sparams[8].Value = objmsg.Attach;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_SaveMessage", sparams);
            return ds;
        }
        public DataSet GetAllMessages(string recid, string userid)
        {

            SqlParameter[] sparams = new SqlParameter[2];
            sparams[0] = new SqlParameter("@Receiver_Id", SqlDbType.NVarChar);
            sparams[0].Value = recid;
            sparams[1] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[1].Value = userid;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "Proc_GetAllMessages", sparams);
            return ds;
        }
        public DataSet GetAllGrpMessages(string Grp_Id)
        {

            SqlParameter[] sparams = new SqlParameter[1];
            sparams[0] = new SqlParameter("@Grp_Id", SqlDbType.NVarChar);
            sparams[0].Value = Grp_Id;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "Proc_GetAllGrpMessages", sparams);
            return ds;
        }

        public DataSet SaveGrpMessage(StructSaveGrpMessage objgrp)
        {

            SqlParameter[] sparams = new SqlParameter[9];
            sparams[0] = new SqlParameter("@Attach_Id", SqlDbType.NVarChar);
            sparams[0].Value = objgrp.Attach_Id;
            sparams[1] = new SqlParameter("@Note_Id", SqlDbType.NVarChar);
            sparams[1].Value = objgrp.Note_Id;
            sparams[2] = new SqlParameter("@Grp_Id", SqlDbType.NVarChar);
            sparams[2].Value = objgrp.Grp_Id;
            sparams[3] = new SqlParameter("@Sender_Id", SqlDbType.NVarChar);
            sparams[3].Value = objgrp.Sender_Id;
            sparams[4] = new SqlParameter("@Message", SqlDbType.NVarChar);
            sparams[4].Value = objgrp.Message;
            sparams[5] = new SqlParameter("@Type", SqlDbType.NVarChar);
            sparams[5].Value = objgrp.Type;
            sparams[6] = new SqlParameter("@Added_By", SqlDbType.NVarChar);
            sparams[6].Value = objgrp.Added_By;
            sparams[7] = new SqlParameter("@Added_Date", SqlDbType.DateTime);
            sparams[7].Value = objgrp.Added_Date;
            sparams[8] = new SqlParameter("@Attach", SqlDbType.NVarChar);
            sparams[8].Value = objgrp.Attach;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_SaveGroupMessage", sparams);
            return ds;
        }

        public DataSet GetUserMsg(string recid, string userid, string lid)
        {

            SqlParameter[] sparams = new SqlParameter[3];
            sparams[0] = new SqlParameter("@Receiver_Id", SqlDbType.NVarChar);
            sparams[0].Value = recid;
            sparams[1] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[1].Value = userid;
            sparams[2] = new SqlParameter("@Chat_Id", SqlDbType.NVarChar);
            sparams[2].Value = lid;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_GetUserMsg", sparams);
            return ds;
        }

        public DataSet GetPosts(string post, string Added_By, string Added_Date)
        {
            SqlParameter[] sparams = new SqlParameter[3];
            sparams[0] = new SqlParameter("@Added_By", SqlDbType.NVarChar);
            sparams[0].Value = Added_By;
            sparams[1] = new SqlParameter("@Added_Date", SqlDbType.DateTime);
            sparams[1].Value = Added_Date;
            sparams[2] = new SqlParameter("@Post", SqlDbType.NVarChar);
            sparams[2].Value = post;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_postmessage", sparams);
            return ds;
        }
        public DataSet GetAllPosts(string userid)
        {
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select (select Count(*) from SplitString((select Likes from Post_Master where Post_Id=pm.Post_Id),',')) as Lcount,(select Count(*) from Comments_Master where Post_Id in (pm.Post_Id)) as Comment_Count,um.First_Name+' '+um.Last_Name as Name,um.Image,pm.* from Post_Master pm join User_Master um on pm.Added_By=um.User_Id  order by pm.Added_Date desc;select Image,First_Name,Last_Name From User_Master where User_Id='" + userid + "'");
            return ds;
        }
        public DataSet GetGrpMsg(string grpid, string chatid, string userid)
        {

            SqlParameter[] sparams = new SqlParameter[3];
            sparams[0] = new SqlParameter("@Grp_Id", SqlDbType.NVarChar);
            sparams[0].Value = grpid;
            sparams[1] = new SqlParameter("@Chat_Id", SqlDbType.NVarChar);
            sparams[1].Value = chatid;
            sparams[2] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[2].Value = userid;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_GetGrpMsg", sparams);
            return ds;
        }
        public DataSet GetUserDesc(string userid)
        {
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from User_Master where User_Id=" + userid + "");
            return ds;
        }
        public DataSet GetLatestPost(string lid, string userid)
        {
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "(select Count(*) from SplitString((select Likes from Post_Master where Post_Id=pm.Post_Id),',')) as Lcount,select um.First_Name+' '+um.Last_Name as Name,um.Image,pm.* from Post_Master pm join User_Master um on pm.Added_By=um.User_Id and pm.Post_Id > " + lid + " and pm.Added_By not in (" + userid + ")  order by pm.Added_Date desc;select Max(Post_Id) From Post_Master");
            return ds;
        }
        public DataSet GetPostsAttach(string post, string Added_By, string Added_Date, string Attach)
        {
            SqlParameter[] sparams = new SqlParameter[4];
            sparams[0] = new SqlParameter("@Post", SqlDbType.NVarChar);
            sparams[0].Value = post;
            sparams[1] = new SqlParameter("@Added_By", SqlDbType.NVarChar);
            sparams[1].Value = Added_By;
            sparams[2] = new SqlParameter("@Added_Date", SqlDbType.NVarChar);
            sparams[2].Value = Added_Date;
            sparams[3] = new SqlParameter("@Attach", SqlDbType.NVarChar);
            sparams[3].Value = Attach;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "Proc_GetPostsAttach", sparams);
            return ds;
        }

        public DataSet GetLatestMessage(string userid)
        {
            SqlParameter[] sparams = new SqlParameter[1];
            sparams[0] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[0].Value = userid;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_GetUserMessages", sparams);
            return ds;
        }

        public DataSet Likes(string userid, string postid)
        {
            SqlParameter[] sparams = new SqlParameter[2];
            sparams[0] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[0].Value = userid;
            sparams[1] = new SqlParameter("@Post_Id", SqlDbType.NVarChar);
            sparams[1].Value = postid;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "Proc_Likes", sparams);
            return ds;
        }
        public DataSet UnLike(string userid, string postid)
        {
            SqlParameter[] sparams = new SqlParameter[2];
            sparams[0] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
            sparams[0].Value = userid;
            sparams[1] = new SqlParameter("@Post_Id", SqlDbType.NVarChar);
            sparams[1].Value = postid;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "Proc_UnLike", sparams);
            return ds;
        }

        public DataSet AddComment(string comment, string Added_By, DateTime Added_Date, string post_id)
        {
            SqlParameter[] sparams = new SqlParameter[4];
            sparams[0] = new SqlParameter("@Post_Id", SqlDbType.NVarChar);
            sparams[0].Value = post_id;
            sparams[1] = new SqlParameter("@Comment", SqlDbType.NVarChar);
            sparams[1].Value = comment;
            sparams[2] = new SqlParameter("@Added_By", SqlDbType.NVarChar);
            sparams[2].Value = Added_By;
            sparams[3] = new SqlParameter("@Added_Date", SqlDbType.DateTime);
            sparams[3].Value = Added_Date;
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_AddComment", sparams);
            return ds;
        }

        public DataSet GetAllComments(string postid)
        {
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "Select pm.*,um.First_Name,um.Last_Name,um.Image,cm.* from Comments_Master cm join User_Master um on um.User_Id = cm.Added_By join Post_Master pm on pm.Post_Id=cm.Post_Id where cm.Post_Id in (" + postid + ")");
            return ds;
        }
        public DataSet GetPost(string postid)
        {
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from Post_Master where Post_Id in (" + postid + ")");
            return ds;
        }

        public DataSet UpdateStatus(string Login_Id, string Status)
        {
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "update User_Master set Status='" + Status + "' where User_Id='" + Login_Id + "'");
            return ds;
        }
        public DataSet LoginAdmin(string Username, string Password)
        {
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select Username,Password,User_Id from User_Master where Username='" + Username + "' and Password='" + Password + "'");
            return ds;
        }

        public DataSet GetSearchResult(string Receiver_Id, string User_Id, string Message)
        {
            DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select (select Image from User_Master where User_Id=" + User_Id + " )as User_Pic," +
                                                                    " (select Image from User_Master where User_Id = " + Receiver_Id + " ) as Receiver_Pic," +
                                                                    " (select First_Name + ' ' + Last_Name from User_Master where User_Id = " + User_Id + ") as User_Name," +
                                                                    " (select First_Name + ' ' + Last_Name from User_Master where User_Id = " + Receiver_Id + " )as Receiver_Name," +
                                                                    " * from Chat_Master_User cmu" +
                                                                      " where ((Added_By in (" + User_Id + ")or Added_By in (" + Receiver_Id + ")) and" +
                                                                     " (Receiver_Id in(" + User_Id + ")and User_Id in (" + Receiver_Id + ")) or" +
                                                                    " (Receiver_Id in(" + Receiver_Id + ")and User_Id in (" + User_Id + ")))" +
                                                                    " and cmu.Message like '%" + Message + "%'");
            return ds;
        }
    }


}