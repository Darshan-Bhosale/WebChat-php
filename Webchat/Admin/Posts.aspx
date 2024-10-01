<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Posts.aspx.cs" Inherits="Admin_Posts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        body {
            margin-top: 50px;
        }

        a:hover {
            text-decoration: none;
        }

        .btn {
            transition: all .2s linear;
            -webkit-transition: all .2s linear;
            -moz-transition: all .2s linear;
            -o-transition: all .2s linear;
        }

        .btn-read-more {
            padding: 5px;
            text-align: center;
            border-radius: 0px;
            display: inline-block;
            border: 2px solid #662D91;
            text-decoration: none;
            text-transform: uppercase;
            font-weight: bold;
            font-size: 12px;
            color: #662D91;
        }

            .btn-read-more:hover {
                color: #FFF;
                background: #662D91;
            }

        .post {
            border-bottom: 1px solid #DDD;
        }

        .post-title {
            color: #662D91;
        }

        .post .glyphicon {
            margin-right: 5px;
        }

        .post-header-line {
            border-top: 1px solid #DDD;
            border-bottom: 1px solid #DDD;
            padding: 5px 0px 5px 15px;
            font-size: 12px;
        }

        .post-content {
            padding-bottom: 15px;
            padding-top: 15px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('[data-toggle="popover"]').popover({
                placement: 'left',
                trigger: 'hover'
            });
        });
    </script>
    <script type="text/javascript">
        function deletepost(anchor) {
            //alert(anchor);
            $.ajax({
                type: "POST",
                url: "Posts.aspx/DeletePost",
                data: "{'id':'" + anchor + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if(data.d == "success")
                    {
                        $("#post" + anchor + "").slideUp("normal", function ()
                        {
                            $(this).remove();
                        });
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
            
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Posts</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">Posts</div>
                <div class="panel-body">
                    <div class="col-md-12" id="divposts" runat="server">
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

