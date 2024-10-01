<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="Admin_ALogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
     <link href="../img/webchatlogo.png" rel="shortcut icon" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="css/util.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <!--===============================================================================================-->
    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnlogin").click(function (e) {
                e.preventDefault();
                var email = $("#txtemail").val();
                var pass = $("#txtpass").val();
                $.ajax({
                    type: "POST",
                    url: "index.aspx/Login",
                    data: "{'email':'" + email + "','pass':'" + pass + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            window.location.href = "Dash.aspx";
                        }
                        else
                        {
                           alert("Invalid Credentials");
                        }
                    },
                    error: function () {
                        alert("Error..!!");
                    }
                });
            });
        });
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <form class="login100-form validate-form">
                        <span class="login100-form-title p-b-26">Welcome
                        </span>
                        <span class="login100-form-title p-b-48">
                            <i class="zmdi zmdi-font"></i>
                        </span>

                        <div class="wrap-input100 validate-input" data-validate="Valid email is: a@b.c">
                            <input class="input100" type="text" name="email" id="txtemail">
                            <span class="focus-input100" data-placeholder="Email"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Enter password">
                            <span class="btn-show-pass">
                                <i class="zmdi zmdi-eye"></i>
                            </span>
                            <input class="input100" type="password" name="pass" id="txtpass">
                            <span class="focus-input100" data-placeholder="Password"></span>
                        </div>

                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn" id="btnlogin">
                                    Login
                                </button>
                            </div>
                        </div>

                        <%--<div class="text-center p-t-115">
                            <span class="txt1">Don’t have an account?
                            </span>

                            <a class="txt2" href="#">Sign Up
                            </a>
                        </div>--%>
                    </form>
                </div>
            </div>
        </div>


        <div id="dropDownSelect1"></div>
        <!--===============================================================================================-->

        <!--===============================================================================================-->
        <script src="vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <script src="js/main.js"></script>
    </form>
</body>
</html>
