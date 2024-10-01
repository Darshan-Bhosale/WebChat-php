<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PassReset.aspx.cs" Inherits="PassReset" EnableEventValidation="false"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Password Reset-The Spartan Poker</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" />
    <script src="jquery/jquery-1.10.2.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnreset").click(function (e) {
                e.preventDefault();

                var email = $("#txtemail").val();
                var pass = $("#txtcnfrmpass").val();
                $.ajax({
                    type: "POST",
                    url: "PassReset.aspx/ResetPassword",
                    data: "{'email':'" + email + "','pass':'" + pass + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            window.location.href = "index.aspx";
                        }
                        else {
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
<body style="background-color: grey;">
    <form id="form1" runat="server">
        <div class="container">
            <div id="passwordreset" style="margin-top: 50px" class="col-md-8 col-sm-8 col-sm-offset-2">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <div class="panel-title text-center">Reset Password</div>
                    </div>
                    <div class="panel-body">
                        <form id="signupform" class="form-horizontal" role="form">
                            <div class="form-group" style="padding-bottom: 5%;">
                                <label for="email" class=" control-label col-sm-3">Registered email</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="email" id="txtemail" runat="server" />
                                </div>
                            </div>

                            <div class="form-group" style="padding-bottom: 5%;">
                                <label for="email" class=" control-label col-sm-3">New password</label>
                                <div class="col-sm-7">
                                    <input type="password" class="form-control" name="password" placeholder="Create your new password" id="txtpass" runat="server" />
                                </div>
                            </div>

                            <div class="form-group" style="padding-bottom: 5%;">
                                <label for="email" class=" control-label col-sm-3">Confirm password</label>
                                <div class="col-sm-7">
                                    <input type="password" class="form-control" placeholder="Confirm Password" id="txtcnfrmpass" runat="server" />
                                </div>
                            </div>

                            <div class="form-group" style="padding-bottom: 5%;">
                                <!-- Button -->
                                <div class="col-sm-12 text-center">
                                    <asp:Button ID="btnreset" runat="server" Text="Reset" class="btn btn-success" ClientIDMode="Static"/>
                                    <%--<button id="btnsignup" type="button" >Submit</button>--%>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
