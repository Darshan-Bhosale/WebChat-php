<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true" CodeFile="AddUser.aspx.cs" Inherits="Admin_AddUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnadddept").click(function (e) {
                e.preventDefault();
                var name = $("#txtdeptname").val();
                var desc = $("#txtdesc").val();
                $.ajax({
                    type: "POST",
                    url: "AddUser.aspx/SaveDept",
                    data: "{'name':'" + name + "','desc':'" + desc + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            alert("Done");
                            getdepartment();
                            $("#txtdeptname").val('');
                            $("#txtdesc").val('');
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
            $("#btnadduser").click(function (e) {
                e.preventDefault();
                var fname = $("#txtfname").val();
                var lname = $("#txtlname").val();
                var desig = $("#txtdesignation").val();
                var depart = $("#dlldepartment").val();
                var user = $("#txtusername").val();
                var pass = $("#txtpassword").val();
                var email = $("#txtemail").val();
                var filename = $('input[type=file]').val().replace(/C:\\fakepath\\/i, '');
                var desc = $("#txtdescuser").val();
                $.ajax({
                    type: "POST",
                    url: "AddUser.aspx/SaveUser",
                    data: "{'desc':'" + desc + "','image':'" + filename + "','fname':'" + fname + "','lname':'" + lname + "','desig':'" + desig + "','depart':'" + depart + "','user':'" + user + "','pass':'" + pass + "','email':'" + email + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            alert("Done");
                            uploadfiles();
                            getusers();
                            $("#txtfname").val('');
                            $("#txtlname").val('');
                            $("#txtdesignation").val('');
                            $("#txtusername").val('');
                            $("#txtpassword").val('');
                            $("#txtemail").val('');
                            $("#txtdescuser").val('');
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
        });
    </script>
    <script type="text/javascript">
        function uploadfiles() {
            var fileUpload = $("#fupdp").get(0);
            var files = fileUpload.files;
            var test = new FormData();
            for (var i = 0; i < files.length; i++) {
                test.append(files[i].name, files[i]);
            }
            $.ajax({
                url: "UploadHandler.ashx",
                type: "POST",
                contentType: false,
                processData: false,
                data: test,
                // dataType: "json",
                success: function (result) {
                    alert(result);
                },
                error: function (err) {
                    alert(err.statusText);
                }
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            getdepartment();
            getusers();
            $("#btnupdatedept").hide();
            $("#btnupdateuser").hide();
        });
    </script>
    <script type="text/javascript">
        var deptid = "";
        var userid = "";
        var type = "";
        var delid = "";
        function getdepartment() {
            $("#divdepart").html('');
            $.ajax({
                type: "POST",
                url: "AddUser.aspx/GetDept",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "1") {
                        $("#divdepart").html(data.d);
                    }
                    else {
                        //alert(data.d);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
        function getusers() {
            $("#divusers").html('');
            $.ajax({
                type: "POST",
                url: "AddUser.aspx/GetUsers",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "1") {
                        $("#divusers").html(data.d);
                    }
                    else {
                        //alert(data.d);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
        function editdept(anchor) {
            deptid = anchor;
            $("#btnadddept").hide();
            $("#btnupdatedept").show();
            $.ajax({
                type: "POST",
                url: "AddUser.aspx/EditDept",
                data: "{'id':'" + anchor + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#txtdeptname").val(data.d.name);
                        $("#txtdesc").val(data.d.desc);
                    }
                    else {
                        alert(data.d);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
        function editusers(anchor) {
            $("#txtfname").focus();
            userid = anchor;
            $("#btnadduser").hide();
            $("#btnupdateuser").show();
            $.ajax({
                type: "POST",
                url: "AddUser.aspx/EditUsers",
                data: "{'id':'" + anchor + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#txtfname").val(data.d.fname);
                        $("#txtlname").val(data.d.lname);
                        $("#txtdesignation").val(data.d.desig);
                        $("#txtusername").val(data.d.username);
                        $("#txtpassword").val(data.d.pass);
                        $("#txtemail").val(data.d.email);
                        $("#dlldepartment").val(data.d.deptid);
                        $("#fupname").html(data.d.image);
                        $("#txtdescuser").val(data.d.desc);

                    }
                    else {
                        alert(data.d);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });

        }
        function deletedept(anchor) {
            delid = anchor;
            type = "dept";
            $.ajax({
                type: "POST",
                url: "AddUser.aspx/CheckDeptAssign",
                data: "{'id':'" + anchor + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d == "1") {
                        alert("Cannot Delete..As Department is assigned with Users.");
                        type = "";
                        delid = "";
                    }
                    else if (data.d == "0") {
                        $("#myModal").modal('show');
                    }
                    else {
                        //alert(data.d);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });

        }
        function deleteusers(anchor) {
            delid = anchor;
            type = "user";
            $("#myModal").modal('show');
            //to check if user exist in the group
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnupdatedept").click(function (e) {
                e.preventDefault();
                var name = $("#txtdeptname").val();
                var desc = $("#txtdesc").val();
                $.ajax({
                    type: "POST",
                    url: "AddUser.aspx/UpdateDept",
                    data: "{'name':'" + name + "','desc':'" + desc + "','id':'" + deptid + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            deptid = "";
                            getdepartment();
                            $("#btnadddept").show();
                            $("#btnupdatedept").hide();
                            alert("Updated");
                            $("#txtdeptname").val('');
                            $("#txtdesc").val('');
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
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnupdateuser").click(function (e) {
                e.preventDefault();
                var fname = $("#txtfname").val();
                var lname = $("#txtlname").val();
                var desig = $("#txtdesignation").val();
                var depart = $("#dlldepartment").val();
                var user = $("#txtusername").val();
                var pass = $("#txtpassword").val();
                var email = $("#txtemail").val();
                var filename = "";
                if ($('input[type=file]').val().replace(/C:\\fakepath\\/i, '') != "") {
                    filename = $('input[type=file]').val().replace(/C:\\fakepath\\/i, '');
                }
                else {
                    filename = $("#fupname").html();
                }
                var desc = $("#txtdescuser").val();
                $.ajax({
                    type: "POST",
                    url: "AddUser.aspx/UpdateUser",
                    data: "{'desc':'" + desc + "','image':'" + filename + "','fname':'" + fname + "','lname':'" + lname + "','desig':'" + desig + "','depart':'" + depart + "','user':'" + user + "','pass':'" + pass + "','email':'" + email + "','id':'" + userid + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        alert("Updated");
                        $("#btnadduser").show();
                        $("#btnupdateuser").hide();
                        getusers();
                        if (data.d == "1") {
                            uploadfiles();
                        }
                        $("#txtfname").val('');
                        $("#txtlname").val('');
                        $("#txtdesignation").val('');
                        $("#txtusername").val('');
                        $("#txtpassword").val('');
                        $("#txtemail").val('');
                        $("#fupname").html('');
                        $("#txtdescuser").val('');
                    },
                    error: function () {
                        alert("Error..!!");
                    }
                });
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btndelete").click(function (e) {
                e.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "AddUser.aspx/DeleteAll",
                    data: "{'id':'" + delid + "','type':'" + type + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            if (type == "user") {
                                getusers();
                            }
                            else if (type == "dept") {
                                getdepartment();
                            }
                            type = "";
                            delid = "";
                            alert("Deleted Successfully");
                            $("#myModal").modal('hide');

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
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Users</h1>
        </div>
    </div>
    <!--/.row-->
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">Add User</div>
                <div class="panel-body">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" id="txtfname" clientidmode="static" class="form-control" placeholder="First Name" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" id="txtlname" clientidmode="static" class="form-control" placeholder="Last Name" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Designation</label>
                            <input type="text" id="txtdesignation" clientidmode="static" class="form-control" placeholder="Designation" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Department</label>
                            <asp:DropDownList ID="dlldepartment" ClientIDMode="static" class="form-control" runat="server"></asp:DropDownList>

                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" id="txtusername" clientidmode="static" class="form-control" placeholder="Username" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Password</label>
                            <input type="text" id="txtpassword" clientidmode="static" class="form-control" placeholder="Password" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Email Id</label>
                            <input type="text" id="txtemail" clientidmode="static" class="form-control" placeholder="Email Id" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Description</label>
                            <textarea cols="5" rows="5" id="txtdescuser" class="form-control" placeholder="Description" clientidmode="static"></textarea>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Upload Picture</label>
                            <asp:FileUpload ID="fupdp" runat="server" ClientIDMode="Static" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div id="fupname" clientidmode="static">
                        </div>
                    </div>
                    <div class="col-md-12 text-center">
                        <input type="button" value="Add User" class="btn btn-success" clientidmode="static" id="btnadduser" />
                        <input type="button" value="Update User" class="btn btn-success" clientidmode="static" id="btnupdateuser" />
                    </div>
                </div>
            </div>
            <!-- /.panel-->
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">Add Department</div>
                <div class="panel-body">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Department Name</label>
                            <input type="text" id="txtdeptname" clientidmode="static" class="form-control" placeholder="First Name">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Desription</label>
                            <textarea cols="5" rows="5" class="form-control" clientidmode="static" id="txtdesc" placeholder="Description"></textarea>
                        </div>
                    </div>
                    <div class="col-md-12 text-center">
                        <input type="button" value="Add Department" class="btn btn-success" clientidmode="static" id="btnadddept" />
                        <input type="button" value="Update Department" class="btn btn-success" clientidmode="static" id="btnupdatedept" />
                    </div>
                </div>
                <!-- /.panel-->
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-body tabs">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab1" data-toggle="tab">Department</a></li>
                        <li><a href="#tab2" data-toggle="tab">Users</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="tab1">
                            <h4>Department</h4>
                            <div id="divdepart" clientidmode="static"></div>
                        </div>
                        <div class="tab-pane fade" id="tab2">
                            <h4>Users</h4>
                            <div id="divusers" clientidmode="static" style="overflow-y: auto; max-height: 226px;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/.panel-->
        </div>
        <!--/.col-->
    </div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header" style="background-color: #f9243f;">
                    <h4 class="modal-title" style="color: white;">Delete Data</h4>
                </div>
                <div class="modal-body">
                    <p>Do you want to delete the Data..!!</p>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-danger" id="btndelete" clientidmode="static" value="Delete" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>



