<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <link href="img/webchatlogo.png" rel="shortcut icon" />
    <style>
        body {
            padding-top: 60px;
        }
    </style>
    <link href="bootstrap3/css/bootstrap.css" rel="stylesheet" />
    <link href="login-register.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">

    <script src="jquery/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="bootstrap3/js/bootstrap.js" type="text/javascript"></script>
    <%--<script src="login-register.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
        $(document).ready(function () {
            //openLoginModal();
            $('#loginModal').modal({ backdrop: 'static' });
            $("#btnreset").click(function (e) {
                e.preventDefault();
                $('#modalreset').modal({ backdrop: 'static' });
            });
            $("#btnresetpass").click(function (e) {
                e.preventDefault();
                var email = $("#txtemail").val();
                $.ajax({
                    type: "POST",
                    url: "index.aspx/ResetPassword",
                    data: "{'email':'"+email+"'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            $('#modalreset').modal('hide');
                        }
                        else if (data.d == "not") {
                            alert("Email Not Found..!!");
                            $("#txtemail").focus();
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
        function loginAjax() {
            $("input[type=button]").attr("disabled", "disabled");
            var user = $("#txtusername").val();
            var pass = $("#txtpass").val();
            $.ajax({
                type: "POST",
                url: "index.aspx/Logind",
                data: "{'user':'" + user + "','pass':'" + pass + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d == "success") {
                        window.location = "chat.aspx";
                    }
                    else {
                        shakeModal();
                        $("#txtpass").val('');
                        $("input[type=button]").removeAttr("disabled");
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
        function shakeModal() {
            $('#loginModal .modal-dialog').addClass('shake');
            $('.error').addClass('alert alert-danger').html("Invalid email/password combination");
            $('input[type="password"]').val('');
            setTimeout(function () {
                $('#loginModal .modal-dialog').removeClass('shake');
            }, 1000);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-sm-4"></div>
                <div class="col-sm-4">
                    <div class="col-sm-4"></div>
                </div>
                <div class="modal fade login" id="loginModal">
                    <div class="modal-dialog login animated">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title text-center">Login with</h4>
                            </div>
                            <div class="modal-body">
                                <div class="box">
                                    <div class="content">
                                        <div class="error"></div>
                                        <div class="form loginBox">
                                            <form method="post" action="/login" accept-charset="UTF-8">
                                                <input id="txtusername" class="form-control" type="text" placeholder="Username" name="email" clientidmode="static" />
                                                <input id="txtpass" class="form-control" type="password" placeholder="Password" name="password" clientidmode="static" />
                                                <input class="btn btn-default btn-login" type="button" value="Login" onclick="loginAjax()" />
                                                <div class="text-right">
                                                    <button type="button" class="btn btn-link" id="btnreset">Forget Password?</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="forgot register-footer" style="display: none">
                                    <span>Already have an account?</span>
                                    <a href="javascript: showLoginForm();">Login</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- Modal -->
            <div class="modal fade" id="modalreset" role="dialog">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Reset Password</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="email">Email address:</label>
                                <input type="email" class="form-control" id="txtemail" />
                            </div>
                            <div class="text-center">
                                <button type="button" class="btn btn-success" id="btnresetpass">Get Password !!</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </form>

</body>
</html>
