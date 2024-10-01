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
/// Summary description for BLLGroup
/// </summary>
/// 
public struct StructSaveGroup
{
    public string Name;
    public string User_Id;
    public string Description;
    public string Added_By;
    public DateTime Added_Date;
    public string Modified_By;
    public DateTime Modified_Date;
    public string Grp_Id;
}
public class BLLGroup
{
    public string conn = BLLCommon.conn;
    public BLLGroup()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataSet SaveGroup(StructSaveGroup objgrp)
    {
        SqlParameter[] sparams = new SqlParameter[5];
        sparams[0] = new SqlParameter("@Name", SqlDbType.NVarChar);
        sparams[0].Value = objgrp.Name;
        sparams[1] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
        sparams[1].Value = objgrp.User_Id;
        sparams[2] = new SqlParameter("@Description", SqlDbType.NVarChar);
        sparams[2].Value = objgrp.Description;
        sparams[3] = new SqlParameter("@Added_By", SqlDbType.NVarChar);
        sparams[3].Value = objgrp.Added_By;
        sparams[4] = new SqlParameter("@Added_Date", SqlDbType.DateTime);
        sparams[4].Value = objgrp.Added_Date;
        DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_SaveGroup", sparams);
        return ds;
    }

    public DataSet GetGroup()
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from Group_Master");
        return ds;
    }
    public DataSet GetGroupById(string Id)
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "select * from Group_Master where Grp_Id = " + Id + "");
        return ds;
    }
    public DataSet UpdateGroup(StructSaveGroup objgrp)
    {
        SqlParameter[] sparams = new SqlParameter[6];
        sparams[0] = new SqlParameter("@Name", SqlDbType.NVarChar);
        sparams[0].Value = objgrp.Name;
        sparams[1] = new SqlParameter("@User_Id", SqlDbType.NVarChar);
        sparams[1].Value = objgrp.User_Id;
        sparams[2] = new SqlParameter("@Description", SqlDbType.NVarChar);
        sparams[2].Value = objgrp.Description;
        sparams[3] = new SqlParameter("@Modified_By", SqlDbType.NVarChar);
        sparams[3].Value = objgrp.Modified_By;
        sparams[4] = new SqlParameter("@Modified_Date", SqlDbType.DateTime);
        sparams[4].Value = objgrp.Modified_Date;
        sparams[5] = new SqlParameter("@Grp_Id", SqlDbType.NVarChar);
        sparams[5].Value = objgrp.Grp_Id;
        DataSet ds = Dal.ExecuteDataset(conn, CommandType.StoredProcedure, "proc_UpdateGroup", sparams);
        return ds;
    }
    public DataSet ResetPassword(string email, string pass)
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "update User_Master set Password='" + pass + "' where Email='" + email + "'");
        return ds;
    }

    public DataSet GetUserMail(string email)
    {

        DataSet ds = Dal.ExecuteDataset(conn, CommandType.Text, "Select * from User_Master where Email='" + email + "'");
        return ds;
    }
}