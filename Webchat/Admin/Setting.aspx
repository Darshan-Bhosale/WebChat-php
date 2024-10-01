<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Setting.aspx.cs" Inherits="Admin_Setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('[data-toggle="popover"]').popover({
                placement: 'left',
                trigger: 'hover'
            });
        });
    </script>
    <script type="text/javascript">
        var adminid = "";
        $(document).ready(function () {
            getdetails();
            GetAdmins();
            $("#btnupdate").hide();
            $("#btncreateadmin").show();

            $("#btnupdate").click(function (e) {
                e.preventDefault();
                var pass = $("#txtapass").val();
                var user = $("#txtauser").val();
                var name = $("#txtname").val();
                $.ajax({
                    type: "POST",
                    url: "Setting.aspx/UpdatePass",
                    data: "{'pass':'" + pass + "','user':'" + user + "','id':'" + adminid + "','name':'"+name+"'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            alert("Updated Successfully..!!");
                            $("#btnupdate").hide();
                            $("#btncreateadmin").show();
                            $("#exampleModal").modal('hide');
                            GetAdmins();
                            adminid = "";
                        }
                    },
                    error: function () {
                        alert("Error..!!");
                    }
                });
            });
            $("#btncreateadmin").click(function (e) {
                e.preventDefault();
                var pass = $("#txtauser").val();
                var user = $("#txtapass").val();
                var name = $("#txtname").val();
                $.ajax({
                    type: "POST",
                    url: "Setting.aspx/CreateAdmin",
                    data: "{'pass':'" + pass + "','user':'" + user + "','name':'" + name + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "1") {
                            alert("Admin Added Successfully..!!");
                            $("#exampleModal").modal('hide');
                            GetAdmins();
                        }
                        else if (data.d == "0") {
                            alert("Username Already Exist..!!");
                        }
                        else {
                            alert(data.d);
                        }
                    },
                    error: function () {
                        alert("Error..!!");
                    }
                });

            });
            $("#btnaddadmin").click(function (e) {
                e.preventDefault();
                $("#txtname").val('');
                $("#txtauser").val('');
                $("#txtapass").val('');
                $("#btnupdate").hide();
                $("#btncreateadmin").show();
                adminid = "";
            });
        });
    </script>
    <script type="text/javascript">
        function GetAdmins() {
            $("#divAdmin").html('');
            $.ajax({
                type: "POST",
                url: "Setting.aspx/GetAdmins",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#divAdmin").html(data.d);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
        function getdetails() {
            $.ajax({
                type: "POST",
                url: "Setting.aspx/GetDetails",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#txtusername").val(data.d.username);
                        $("#txtpass").val(data.d.password);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
        function viewadmin(anchor) {
            $("#exampleModal").modal('show');
            $("#btnupdate").show();
            $("#btncreateadmin").hide();
            adminid = anchor;
            $.ajax({
                type: "POST",
                url: "Setting.aspx/ShowAdmin",
                data: "{'id':'" + anchor + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#txtauser").val(data.d.username);
                        $("#txtapass").val(data.d.password);
                        $("#txtname").val(data.d.name);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
        function deleteadmin(anchor) {
            $.ajax({
                type: "POST",
                url: "Setting.aspx/DeleteAdmin",
                data: "{'id':'" + anchor + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        alert("Admin Deleted Successfully..!!");
                        GetAdmins();
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
            <h1 class="page-header">Setting</h1>
        </div>
    </div>
    <div class="row">
        <%-- <div class="col-lg-6">
            <form class="form-horizontal" action="/action_page.php">
                <div class="form-group" style="padding-bottom: 10%;">
                    <label class="control-label col-sm-2" for="email">Username:</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="txtusername" placeholder="Enter Username" clientidmode="static" />
                    </div>
                </div>
                <div class="form-group" style="padding-bottom: 10%;">
                    <label class="control-label col-sm-2" for="pwd">Password:</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="txtpass" placeholder="Enter Password" clientidmode="static" />
                    </div>
                </div>

                <div class="form-group" style="padding-bottom: 10%;">
                    <div class="col-sm-offset-2 col-sm-10">
                        
                        
                    </div>
                </div>
            </form>
        </div>--%>
        <div class="col-md-6">
            <button type="button" id="btnaddadmin" class="btn btn-default" data-toggle="modal" data-target="#exampleModal">Add New Admin</button>
            <div class="panel panel-default">
                <div class="panel-body tabs">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab1" data-toggle="tab">Department</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="tab1">
                            <h4>Admins</h4>
                            <div id="divAdmin" clientidmode="static"></div>
                        </div>

                    </div>
                </div>
            </div>
            <!--/.panel-->
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Admin</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group" style="padding-bottom: 10%;">
                        <label class="control-label col-sm-2" for="email">Name:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="txtname" placeholder="Enter Name" clientidmode="static" />
                        </div>
                    </div>
                    <div class="form-group" style="padding-bottom: 10%;">
                        <label class="control-label col-sm-2" for="email">Username:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="txtauser" placeholder="Enter Username" clientidmode="static" />
                        </div>
                    </div>
                    <div class="form-group" style="padding-bottom: 10%;">
                        <label class="control-label col-sm-2" for="email">Password:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="txtapass" placeholder="Enter Password" clientidmode="static" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer  text-left">
                    <button type="button" id="btnupdate" class="btn btn-primary">Update</button>
                    <button type="button" class="btn btn-primary" id="btncreateadmin">Create Admin</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

