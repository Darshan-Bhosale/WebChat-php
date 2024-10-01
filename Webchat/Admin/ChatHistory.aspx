<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true" CodeFile="ChatHistory.aspx.cs" Inherits="Admin_ChatHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .md-user-image {
            border-radius: 50%;
            width: 34px;
        }

        .pill {
            color: black !important;
            height: 65px;
            border-bottom: 1px solid #dedede;
        }

            .pill:hover {
                background-color: #8080801f;
            }

        .anchor:hover {
            text-decoration: none;
            text-decoration-color: white;
            color: black;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        function chatbox(anc) {
            var id = $(anc).attr("id");
            type = id.substring(0, 3);
            uid = id.substring(3, id.length);
            heading = $("#" + id).find(':nth-child(2)').html();
            //alert(uid);
            $.ajax({
                type: "POST",
                url: "ChatHistory.aspx/GetDetails",
                data: "{'id':'" + uid + "','head':'" + heading + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#divchatwith").html('');
                        $("#divchatwith").html(data.d);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
        function deletechat(Added, anchor) {

            $.ajax({
                type: "POST",
                url: "ChatHistory.aspx/DeleteChat",
                data: "{'AddedBy':'" + Added + "','Received':'" + anchor + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d == "success") {
                        alert("Chat Deleted Sucessfully..!!");
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
        function downloadchat(added, anc) {
            window.location.href = "Downld.aspx?rec=" + added + "|" + anc + "";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Chat History</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">Users</div>
                <div class="panel-body" style="padding: 0px;">
                    <ul class="list-unstyled" id="divusers" runat="server">
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="panel panel-default">
                <div class="panel-heading">Chat History With</div>
                <div class="panel-body">
                    <div class="col-md-12" id="divchatwith" runat="server" clientidmode="static">
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

