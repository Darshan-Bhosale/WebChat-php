<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true" CodeFile="AddGroup.aspx.cs" Inherits="Admin_AddGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnupdategrp").hide();
            GetGroups();
            createusers();
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnadddgrp").click(function (e) {
                e.preventDefault();
                var name = $("#txtgrpname").val();
                var desc = $("#txtdesc").val();
                var selchbox = [];
                var inpfields = this.form.getElementsByTagName('input');
                var nr_inpfields = inpfields.length;
                for (var i = 0; i < nr_inpfields; i++) {
                    if (inpfields[i].type == 'checkbox' && inpfields[i].checked == true) selchbox.push(inpfields[i].value);
                }
                if (selchbox == "") {
                    alert("Please select One Member for Group");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "AddGroup.aspx/SaveGroup",
                    data: "{'name':'" + name + "','user':'" + selchbox + "','desc':'" + desc + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            //uncheck all checkbox
                            alert("Group Created");
                            $("#txtgrpname").val('');
                            $("#txtdesc").val('');
                            $("input:checkbox").removeAttr('checked');
                            GetGroups();
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
        var delid = "";
        var grpid = "";
        var type = "";
        function GetGroups() {
            $("#divgrp").html('');
            $.ajax({
                type: "POST",
                url: "AddGroup.aspx/GetGroup",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#divgrp").html(data.d);
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
        function deletegrp(anchor) {
            delid = anchor;
            type = "grp";
            alert(anchor);
            $("#myModal").modal('show');

        }
        function editgrp(anchor) {

            grpid = anchor;
            $("input:checkbox").prop('checked', false);

            $("#btnupdategrp").show();
            $("#btnadddgrp").hide();
            $.ajax({
                type: "POST",
                url: "AddGroup.aspx/EditGroup",
                data: "{'id':'" + grpid + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {

                        $("#txtgrpname").val(data.d.name);
                        $("#txtdesc").val(data.d.desc);
                        var user = data.d.userid.split(',');
                        for (var i = 0; i < user.length; i++) {

                            $('input:checkbox[value="' + user[i] + '"]').prop('checked', true);
                        }

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
        function createusers() {
            $.ajax({
                type: "POST",
                url: "AddGroup.aspx/GetUsers",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#divusers").html(data.d);
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
                            GetGroups();
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
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnupdategrp").click(function (e) {
                e.preventDefault();
                $("#btnupdategrp").hide();
                $("#btnadddgrp").show();

                var name = $("#txtgrpname").val();
                var desc = $("#txtdesc").val();
                var selchbox = [];
                var inpfields = this.form.getElementsByTagName('input');
                var nr_inpfields = inpfields.length;
                for (var i = 0; i < nr_inpfields; i++) {
                    if (inpfields[i].type == 'checkbox' && inpfields[i].checked == true) selchbox.push(inpfields[i].value);
                }
                if (selchbox == "") {
                    alert("Please select One Member for Group");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "AddGroup.aspx/UpdateGroup",
                    data: "{'name':'" + name + "','user':'" + selchbox + "','desc':'" + desc + "','id':'" + grpid + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            //uncheck all checkbox
                            alert("Group Updated");
                            $("#txtgrpname").val('');
                            $("#txtdesc").val('');
                            $("input:checkbox").prop('checked',false);
                            GetGroups();
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
            <h1 class="page-header">Create Group</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">Create Group</div>
                <div class="panel-body">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Group Name</label>
                            <input type="text" id="txtgrpname" clientidmode="static" class="form-control" placeholder="Group Name">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Add Users</label>
                            <div style="border: 1px solid #00000014; overflow-y: auto; max-height: 180px; padding: 5%;">
                                <div id="divusers" clientidmode="static"></div>

                                <%--<asp:checkboxlist runat="server" id="chkusers" clientidmode="static">
                                </asp:checkboxlist>--%>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Desription</label>
                            <textarea cols="5" rows="5" class="form-control" clientidmode="static" id="txtdesc" placeholder="Description"></textarea>
                        </div>
                    </div>

                    <div class="col-md-12 text-center">
                        <input type="button" value="Create Group" class="btn btn-success" clientidmode="static" id="btnadddgrp" />
                        <input type="button" value="Update Group" class="btn btn-success" clientidmode="static" id="btnupdategrp" />
                    </div>
                </div>
            </div>
            <!-- /.panel-->
        </div>
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">Groups</div>
                <div class="panel-body">
                    <div class="col-md-12" id="divgrp" clientidmode="static">
                    </div>
                </div>
            </div>
        </div>
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

