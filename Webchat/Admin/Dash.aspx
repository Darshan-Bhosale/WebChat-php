<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Dash.aspx.cs" Inherits="Admin_index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript">
        $(document).ready(function () {
            getdetails();
           
        });
    </script>
    <script type="text/javascript">
        function getdetails() {
            $.ajax({
                type: "POST",
                url: "Dash.aspx/GetDetails",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#divchats").html(data.d.chat);
                        $("#divcomment").html(data.d.comment);
                        $("#divuser").html(data.d.user);
                        $("#divgrp").html(data.d.grp);
                    }
                },
                error: function () {
                    alert("Error..!!");
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
			<ol class="breadcrumb">
				<li><a href="#">
					<em class="fa fa-home"></em>
				</a></li>
				<li class="active">Dashboard</li>
			</ol>
		</div><!--/.row-->
		
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Dashboard</h1>
			</div>
		</div><!--/.row-->
		
		<div class="panel panel-container">
			<div class="row">
				<div class="col-xs-6 col-md-3 col-lg-3 no-padding">
					<div class="panel panel-teal panel-widget border-right">
						<div class="row no-padding"><em class="fa fa-xl fa-file-text-o color-blue"></em>
							<div class="large" id="divchats">120</div>
							<div class="text-muted">Chats</div>
						</div>
					</div>
				</div>
				<div class="col-xs-6 col-md-3 col-lg-3 no-padding">
					<div class="panel panel-blue panel-widget border-right">
						<div class="row no-padding"><em class="fa fa-xl fa-comments color-orange"></em>
							<div class="large" id="divcomment">52</div>
							<div class="text-muted">Comments</div>
						</div>
					</div>
				</div>
				<div class="col-xs-6 col-md-3 col-lg-3 no-padding">
					<div class="panel panel-orange panel-widget border-right">
						<div class="row no-padding"><em class="fa fa-xl fa-user color-teal"></em>
							<div class="large" id="divuser">24</div>
							<div class="text-muted">New Users</div>
						</div>
					</div>
				</div>
				<div class="col-xs-6 col-md-3 col-lg-3 no-padding">
					<div class="panel panel-red panel-widget ">
						<div class="row no-padding"><em class="fa fa-xl fa-users color-red"></em>
							<div class="large" id="divgrp">25.2k</div>
							<div class="text-muted">Groups</div>
						</div>
					</div>
				</div>
			</div><!--/.row-->
		</div>
		<div class="row">
			
			<div class="col-sm-12">
				<p class="back-link">Desinged By AccutransKPO Technology Ltd</p>
			</div>
		</div><!--/.row-->
</asp:Content>

