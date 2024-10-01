using AppCode;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Posts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        disppost();
    }
    private void disppost()
    {
        string element = "";
        try
        {
            BllPost bllpst = new BllPost();
            DataSet ds = bllpst.GetAllPosts();
            if (ds.Tables[0].Rows.Count > 0)
            {

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    element = "No Attachments Found";
                    //if (i == 0)
                    //{
                    //    res += "<div class='plid' style='display:none;'>" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + "</div>";
                    //}
                    string[] arr = ds.Tables[0].Rows[i]["Attachment"].ToString().Split('.');
                    if (arr.Length > 1)
                    {
                        if (arr[1] == "jpg" || arr[1] == "png" || arr[1] == "gif")
                        {
                            element = "<div class='col-md-12 text-center'><img src='../dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' class='img-responsive'></img></div>";
                        }
                        else if (arr[1] == "mp4" || arr[1] == "avi" || arr[1] == "flv" || arr[1] == "wmv" || arr[1] == "mov" || arr[1] == "3gp")
                        {
                            element = "<div class='col-md-12 text-center'><video width='250' controls><source src='../dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "' type='video/" + arr[1] + "'></video></div>";
                        }
                        else
                        {
                            element = "<div class='col-md-12 text-center'><a href='../dp/" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "'>" + ds.Tables[0].Rows[i]["Attachment"].ToString() + "</a></div>";
                        }
                    }

                    divposts.InnerHtml += "<div class='row' id='post" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + "'>" +
                                            "<div class='col-md-12 post'>" +
                                            "<div class='row'>" +
                                            "<div class='col-md-12'>" +
                                            "<div class='col-md-11' style='font-size: 20px;'>" +
                                            "<strong><a href='#' class='post-title'>" + ds.Tables[0].Rows[i]["Name"].ToString() + "</a></strong></div>" +
                                            "<div class='pull-right'><i onclick='deletepost(" + ds.Tables[0].Rows[i]["Post_Id"].ToString() + ")' class='fa fa-window-close' style='color:red;cursor:pointer;' data-toggle='popover' title='Delete' data-content='Do you want to delete the post'></i></div>" +
                                            "</div>" +
                                            "</div>" +
                                            "<div class='row'>" +
                                            "<div class='col-md-12 post-header-line'>" +
                                            "<span class='glyphicon glyphicon-calendar'>" +
                                            "</span>" + Convert.ToDateTime(ds.Tables[0].Rows[i]["Added_Date"].ToString()).ToString("MMM dd, yyyy") + " | <span class='glyphicon glyphicon-comment'></span><a href='#'>" +
                                            "" + ds.Tables[0].Rows[i]["Comments"].ToString() + " Comments</a> | <i class='icon-share'></i><a href='#'>" + ds.Tables[0].Rows[i]["Likes"].ToString() + " Likes</a> | " +
                                            "</div>" +
                                            "</div>" +
                                            "<div class='row post-content'>" +
                                            "<div class='col-md-3'>" +
                                            "<a href='#'>" + element +
                                            "</a>" +
                                            "</div>" +
                                            "<div class='col-md-9'>" +
                                            "<p>" + ds.Tables[0].Rows[i]["Message"].ToString() + "</p>" +
                                            "<p></p>" +
                                            "</div>" +
                                            "</div>" +
                                            "</div>" +
                                            "</div>";
                }
                //divposts.InnerHtml = res;
            }
            else
            {
                divposts.InnerHtml += "No Post's Yet";
            }

        }
        catch (Exception ex)
        {

            throw;
        }
    }

    [WebMethod]
    public static string DeletePost(string id)
    {
        string res = "";
        try
        {
            BllPost bllpst = new BllPost();
            DataSet ds = bllpst.DeletePosts(id);
            res = "success";
        }
        catch (Exception ex)
        {
            res = ex.Message;
        }
        return res;
    }
}