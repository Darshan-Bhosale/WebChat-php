<%@ Page Language="C#" AutoEventWireup="true" CodeFile="chat.aspx.cs" Inherits="index" EnableEventValidation="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>WebChat</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0" />
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="img/webchatlogo.png" rel="shortcut icon" />
    <!-- Bootstrap core CSS -->

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css" />
    <link href="css/post.css" rel="stylesheet" />
    <link href="css/simple-sidebar.css" rel="stylesheet">
    <link href="css/modal.css" rel="stylesheet" />
    <script src="vendor/jquery/jquery.min.js"></script>

    <script src="jQueryPackage/jquery-2.1.4.js"></script>
    <link href="jQueryPackage/jquery-ui.css" rel="stylesheet" />
    <script src="jQueryPackage/jquery-ui.js"></script>
    <link href="jQueryPackage/jquery-ui.structure.css" rel="stylesheet" />
    <link href="jQueryPackage/jquery-ui.theme.css" rel="stylesheet" />

    <%--<script src="jquery/notification-examples.js"></script>--%>
    <script src="jquery/service-worker.js"></script>
    <%--<script src="https://swc.cdn.skype.com/sdk/v1/sdk.min.js"></script>--%>
    <style type="text/css">
        .indicator {
            width: 10px;
            height: 10px;
            display: inline-block;
            border-radius: 9999px;
            margin-right: 5px;
        }

        #myImg {
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

            #myImg:hover {
                opacity: 0.7;
            }

        /* The Modal (background) */
        .modalimg {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1041; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
        }

        /* Modal Content (image) */
        .modal-contents {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
        }

        /* Caption of Modal Image */
        #caption {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
            text-align: center;
            color: #ccc;
            padding: 10px 0;
            height: 150px;
        }

        /* Add Animation */
        .modal-contents, #caption {
            -webkit-animation-name: zoom;
            -webkit-animation-duration: 0.6s;
            animation-name: zoom;
            animation-duration: 0.6s;
        }

        @-webkit-keyframes zoom {
            from {
                -webkit-transform: scale(0);
            }

            to {
                -webkit-transform: scale(1);
            }
        }

        @keyframes zoom {
            from {
                transform: scale(0);
            }

            to {
                transform: scale(1);
            }
        }

        /* The Close Button */
        .closes {
            position: absolute;
            top: 15px;
            right: 35px;
            color: #f1f1f1;
            font-size: 40px;
            font-weight: bold;
            transition: 0.3s;
        }

            .closes:hover,
            .closes:focus {
                color: #bbb;
                text-decoration: none;
                cursor: pointer;
            }

        #btnsend {
            color: #0084ff;
            /*background-color: white;*/
            border-color: #0084ff;
        }

            #btnsend:hover {
                color: #0084ff;
                /*background-color: white;*/
                border-color: #0084ff;
            }

        body {
            /*font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol";*/
        }

        @media(max-width:768px) {
            /*#menu-toggle {
                display: block !important;
            }*/

            #txtmessage {
                height: 91px !important;
            }

            #btnsend {
                font-size: 18px !important;
                height: 38px !important;
                width: 100% !important;
                margin-top: 18%;
            }

            #divbtn {
                text-align: center;
            }

            #chat {
                height: 416px !important;
            }

            #divchat {
                height: 420px !important;
                padding-right: 15px !important;
                padding-left: 15px !important;
            }

            h3 {
                margin-top: 4px !important;
            }

            .chat_box_wrapper.chat_box_small.chat_box_active {
                width: 105% !important;
            }

            #btnimg {
                display: block !important;
            }

            #Header {
                text-align: center;
            }

            #fluid {
                padding-right: 0px !important;
            }
        }

        #menu-toggle {
            display: none;
        }

        .pill {
            color: black !important;
            height: 65px;
            border-bottom: 1px solid #dedede;
        }
        /*chat box style*/
        @import url(https://fonts.googleapis.com/css?family=Oswald:400,300);
        @import url(https://fonts.googleapis.com/css?family=Open+Sans);

        body {
            font-family: 'Open Sans', sans-serif;
        }

        .chat_box .chat_message_wrapper ul.chat_message > li + li {
            margin-top: 4px;
        }

        .popup-box-on {
            display: block !important;
        }

        a:focus {
            outline: none;
            outline-offset: 0px;
        }

        .popup-head-left.pull-left h1 {
            color: #f7f;
            float: left;
            font-family: oswald;
            font-size: 18px;
            margin: 2px 0 0 5px;
        }

        .popup-head-left a small {
            display: table;
            font-size: 11px;
            color: #fff;
            line-height: 4px;
            opacity: 0.5;
            padding: 0 0 0 7px;
        }

        .chat-header-button {
            background: transparent none repeat scroll 0 0;
            border: 1px solid #fff;
            border-radius: 7px;
            font-size: 15px;
            height: 26px;
            opacity: 0.9;
            padding: 0;
            text-align: center;
            width: 26px;
        }

        .popup-head-right {
            margin: 9px 0 0;
        }

        .popup-head .btn-group {
            margin: -5px 3px 0 -1px;
        }

        .gurdeepoushan .dropdown-menu {
            padding: 6px;
        }

            .gurdeepoushan .dropdown-menu li a span {
                border: 1px solid;
                border-radius: 50px;
                display: list-item;
                font-size: 19px;
                height: 40px;
                line-height: 36px;
                margin: auto;
                text-align: center;
                width: 40px;
            }

            .gurdeepoushan .dropdown-menu li {
                float: left;
                text-align: center;
                width: 33%;
            }

                .gurdeepoushan .dropdown-menu li a {
                    border-radius: 7px;
                    font-family: oswald;
                    padding: 3px;
                    transition: all 0.3s ease-in-out 0s;
                }

                    .gurdeepoushan .dropdown-menu li a:hover {
                        background: #304445 none repeat scroll 0 0 !important;
                        color: #fff;
                    }

        .popup-head {
            background: #304445 none repeat scroll 0 0 !important;
            border-bottom: 3px solid #ccc;
            color: #fff;
            display: table;
            width: 100%;
            padding: 8px;
        }

            .popup-head .md-user-image {
                border: 2px solid #5a7172;
                border-radius: 12px;
                float: left;
                width: 44px;
            }

        .uk-input-group-addon .glyphicon.glyphicon-send {
            color: #ffffff;
            font-size: 21px;
            line-height: 36px;
            padding: 0 6px;
        }

        .chat_box_wrapper.chat_box_small.chat_box_active {
            height: 280px;
            overflow-y: auto;
            width: 100%;
        }

        aside {
            background-attachment: fixed;
            background-clip: border-box;
            background-color: rgba(0, 0, 0, 0);
            background-image: url("https://scontent.fixc1-1.fna.fbcdn.net/v/t1.0-9/12670232_624826600991767_3547881030871377118_n.jpg?oh=92b8b3e25bdd56df4af5dc466feb46ce&oe=57CC10E7");
            background-origin: padding-box;
            background-position: center top;
            background-repeat: repeat;
            border: 1px solid #304445;
            bottom: 0;
            display: none;
            height: 466px;
            position: fixed;
            right: 70px;
            width: 300px;
            font-family: 'Open Sans', sans-serif;
        }

        .chat_box {
            padding: 16px;
        }

            .chat_box .chat_message_wrapper::after {
                clear: both;
            }

            .chat_box .chat_message_wrapper::after, .chat_box .chat_message_wrapper::before {
                content: " ";
                display: table;
            }

            .chat_box .chat_message_wrapper .chat_user_avatar {
                float: left;
            }

            .chat_box .chat_message_wrapper {
                margin-bottom: 15px;
            }

        .md-user-image {
            border-radius: 50%;
            width: 34px;
        }

        img {
            border: 0 none;
            box-sizing: border-box;
            height: auto;
            max-width: 100%;
            vertical-align: middle;
        }

        .chat_box .chat_message_wrapper ul.chat_message, .chat_box .chat_message_wrapper ul.chat_message > li {
            list-style: outside none none;
            padding: 0;
        }

        .chat_box .chat_message_wrapper ul.chat_message {
            float: left;
            margin: 0 0 0 20px;
            max-width: 77%;
        }

        .chat_box.chat_box_colors_a .chat_message_wrapper ul.chat_message > li:first-child::before {
            border-right-color: #616161;
        }

        .chat_box .chat_message_wrapper ul.chat_message > li:first-child::before {
            border-color: transparent #ededed transparent transparent;
            border-style: solid;
            border-width: 0 16px 16px 0;
            content: "";
            height: 0;
            left: -14px;
            position: absolute;
            top: 0;
            width: 0;
        }

        .chat_box.chat_box_colors_a .chat_message_wrapper ul.chat_message > li {
            background: #e5e4e4 none repeat scroll 0 0;
            color: #000000;
        }

        .open-btn {
            border: 2px solid #189d0e;
            border-radius: 32px;
            color: #189d0e !important;
            display: inline-block;
            margin: 10px 0 0;
            padding: 9px 16px;
            text-decoration: none !important;
            text-transform: uppercase;
        }

        .chat_box .chat_message_wrapper ul.chat_message > li {
            background: #ededed none repeat scroll 0 0;
            border-radius: 4px;
            clear: both;
            color: #212121;
            display: block;
            float: left;
            font-size: 13px;
            padding: 8px 16px;
            position: relative;
            word-break: break-all;
        }

        .chat_box .chat_message_wrapper ul.chat_message, .chat_box .chat_message_wrapper ul.chat_message > li {
            list-style: outside none none;
            padding: 0;
        }

            .chat_box .chat_message_wrapper ul.chat_message > li {
                margin: 0;
            }

                .chat_box .chat_message_wrapper ul.chat_message > li p {
                    margin: 0;
                }

        .chat_box.chat_box_colors_a .chat_message_wrapper ul.chat_message > li .chat_message_time {
            color: rgba(185, 186, 180, 0.9);
        }

        .chat_box .chat_message_wrapper ul.chat_message > li .chat_message_time {
            color: #727272;
            display: block;
            font-size: 11px;
            padding-top: 2px;
            text-transform: uppercase;
        }

        .chat_box .chat_message_wrapper.chat_message_right .chat_user_avatar {
            float: right;
        }

        .chat_box .chat_message_wrapper.chat_message_right ul.chat_message {
            float: right;
            margin-left: 0 !important;
            margin-right: 24px !important;
        }

        .chat_box.chat_box_colors_a .chat_message_wrapper.chat_message_right ul.chat_message > li:first-child::before {
            border-left-color: #0084ff;
        }

        .chat_box.chat_box_colors_a .chat_message_wrapper ul.chat_message > li:first-child::before {
            border-right-color: #e5e4e4;
        }

        .chat_box .chat_message_wrapper.chat_message_right ul.chat_message > li:first-child::before {
            border-color: transparent transparent transparent #ededed;
            border-width: 0 0 29px 29px;
            left: auto;
            right: -14px;
        }

        .chat_box .chat_message_wrapper ul.chat_message > li:first-child::before {
            border-color: transparent #ededed transparent transparent;
            border-style: solid;
            border-width: 0 29px 29px 0;
            content: "";
            height: 0;
            left: -14px;
            position: absolute;
            top: 0;
            width: 0;
        }

        .chat_box.chat_box_colors_a .chat_message_wrapper.chat_message_right ul.chat_message > li {
            background: #0084ff none repeat scroll 0 0;
        }

        .chat_box .chat_message_wrapper ul.chat_message > li {
            background: #ededed none repeat scroll 0 0;
            border-radius: 12px;
            clear: both;
            color: #212121;
            display: block;
            float: left;
            font-size: 13px;
            padding: 8px 16px;
            position: relative;
        }

        .gurdeep-chat-box {
            background: #fff none repeat scroll 0 0;
            border-radius: 5px;
            float: left;
            padding: 3px;
        }

        #submit_message {
            background: transparent none repeat scroll 0 0;
            border: medium none;
            padding: 4px;
        }

        .gurdeep-chat-box i {
            color: #333;
            font-size: 21px;
            line-height: 1px;
        }

        .chat_submit_box {
            bottom: 0;
            box-sizing: border-box;
            left: 0;
            overflow: hidden;
            padding: 10px;
            position: absolute;
            width: 100%;
        }

        .uk-input-group {
            border-collapse: separate;
            display: table;
            position: relative;
        }
    </style>
    <style>
        .img-text {
            cursor: pointer;
            display: none;
            top: 75px;
            position: absolute;
            color: white;
            width: 43%;
            margin-left: 23%;
            background-color: #00000036;
        }

        body {
            font-family: Helvetica Neue, Segoe UI, Helvetica, Arial, sans-serif;
            line-height: 1.28;
            background-image: url("dp/poker-BG.jpg");
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

        .ddldrop {
            left: -29px !important;
            min-width: 80px !important;
            background-color: transparent !important;
            border: white !important;
            -webkit-box-shadow: none !important;
        }

        .bar1, .bar2, .bar3 {
            width: 3px;
            height: 3px;
            background-color: #333;
            margin: 6px 0;
            transition: 0.4s;
        }

        .change .bar1 {
            -webkit-transform: rotate(-45deg) translate(-9px, 6px);
            transform: rotate(-45deg) translate(-9px, 6px);
        }

        .change .bar2 {
            opacity: 0;
        }

        .change .bar3 {
            -webkit-transform: rotate(45deg) translate(-8px, -8px);
            transform: rotate(45deg) translate(-8px, -8px);
        }

        @media(max-width:768px) {
            #head2 {
                margin-top: 12px !important;
            }

            .glyphicon-paperclip {
                padding-top: 16% !important;
                padding-bottom: 53% !important;
            }
        }
        /*scroll start*/
        .scrollbar {
            overflow-y: auto;
            max-height: 448px;
        }

        #ex3::-webkit-scrollbar {
            width: 8px;
        }

        #ex3::-webkit-scrollbar-thumb {
            background-color: #170b161a;
            border-radius: 10px;
        }

            #ex3::-webkit-scrollbar-thumb:hover {
                background-color: #999999;
                border: 1px solid #333333;
            }

            #ex3::-webkit-scrollbar-thumb:active {
                background-color: #666666;
                border: 1px solid #333333;
            }

        #ex3::-webkit-scrollbar-track {
            border: none;
        }
        /**/
        #posts::-webkit-scrollbar {
            width: 8px;
        }

        #posts::-webkit-scrollbar-thumb {
            background-color: #170b161a;
            border-radius: 10px;
        }

            #posts::-webkit-scrollbar-thumb:hover {
                background-color: #999999;
                border: 1px solid #333333;
            }

            #posts::-webkit-scrollbar-thumb:active {
                background-color: #666666;
                border: 1px solid #333333;
            }

        #posts::-webkit-scrollbar-track {
            border: none;
        }
        /**/
        #ex4::-webkit-scrollbar {
            width: 8px;
        }

        #ex4::-webkit-scrollbar-thumb {
            background-color: #170b161a;
            border-radius: 10px;
        }

            #ex4::-webkit-scrollbar-thumb:hover {
                background-color: #999999;
                border: 1px solid #333333;
            }

            #ex4::-webkit-scrollbar-thumb:active {
                background-color: #666666;
                border: 1px solid #333333;
            }

        #ex4::-webkit-scrollbar-track {
            border: none;
        }
        /**/
        #chat::-webkit-scrollbar {
            width: 8px;
        }

        #chat::-webkit-scrollbar-thumb {
            background-color: #170b161a;
            border-radius: 10px;
        }

            #chat::-webkit-scrollbar-thumb:hover {
                background-color: #999999;
                border: 1px solid #333333;
            }

            #chat::-webkit-scrollbar-thumb:active {
                background-color: #666666;
                border: 1px solid #333333;
            }

        #chat::-webkit-scrollbar-track {
            border: none;
        }
        /*scroll end*/
        .modal-backdrop {
            background-color: transparent;
            margin-left: 75.5%;
        }

        .lidiv:hover {
            background-color: rgba(0, 0, 0, .05);
        }

        .pb-cmnt-container {
            font-family: Lato;
            margin-top: 100px;
        }

        .pb-cmnt-textarea {
            resize: none;
            padding: 20px;
            height: 76px;
            width: 100%;
            border: 1px solid #F2F2F2;
        }
    </style>
    <%--<script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>--%>

    <!-- Menu Toggle Script -->
    <script>
        $(document).ready(function () {

            document.addEventListener('DOMContentLoaded', function () {
                if (!Notification) {
                    alert('Desktop notifications not available in your browser. Try Chromium.');
                    return;
                }

                if (Notification.permission !== "granted")
                    Notification.requestPermission();
            });
        });

        function notifyMe() {
            if (Notification.permission !== "granted")
                Notification.requestPermission();
            else {
                var notification = new Notification('Notification title', {
                    icon: 'https://cdn.sstatic.net/stackexchange/img/logos/so/so-icon.png',
                    body: "Hey there! You've been notified!",
                });

                notification.onclick = function () {
                    window.open("https://stackoverflow.com/a/13328397/1269037");
                };

            }

        }
    </script>
    <script type="text/javascript">
        var status = "";
        var _API_JQUERY = 1;
        var _API_PROTOTYPE = 2;
        var _api;
        var _idleTimeout = 30000;
        var _awayTimeout = 600000;
        var _idleNow = false;
        var _idleTimestamp = null;
        var _idleTimer = null;
        var _awayNow = false;
        var _awayTimestamp = null;
        var _awayTimer = null;
        function setIdleTimeout(a) {
            _idleTimeout = a;
            _idleTimestamp = new Date().getTime() + a;
            if (_idleTimer != null) {
                clearTimeout(_idleTimer)
            }
            _idleTimer = setTimeout(_makeIdle, a + 50)
        }
        function setAwayTimeout(a) {
            _awayTimeout = a;
            _awayTimestamp = new Date().getTime() + a;
            if (_awayTimer != null) {
                clearTimeout(_awayTimer)
            }
            _awayTimer = setTimeout(_makeAway, a + 50)
        }
        function _makeIdle() {
            var a = new Date().getTime();
            if (a < _idleTimestamp) {
                _idleTimer = setTimeout(_makeIdle, _idleTimestamp - a + 50);
                return
            }
            _idleNow = true;
            try {
                if (document.onIdle) { document.onIdle() }
            }
            catch (b) {
            }
        }
        function _makeAway() {
            var a = new Date().getTime();
            if (a < _awayTimestamp) {
                _awayTimer = setTimeout(_makeAway, _awayTimestamp - a + 50);
                return
            }
            _awayNow = true;
            try {
                if (document.onAway) {
                    document.onAway()
                }
            }
            catch (b) {

            }
        }
        function _initPrototype() {
            _api = _API_PROTOTYPE
        }
        function _active(c) {
            var a = new Date().getTime();
            _idleTimestamp = a + _idleTimeout;
            _awayTimestamp = a + _awayTimeout;
            if (_idleNow) {
                setIdleTimeout(_idleTimeout)
            }
            if (_awayNow) {
                setAwayTimeout(_awayTimeout)
            }
            try {
                if ((_idleNow || _awayNow) && document.onBack) {
                    document.onBack(_idleNow, _awayNow)
                }
            }
            catch (b) {
            }
            _idleNow = false;
            _awayNow = false
        }
        function _initJQuery() {
            _api = _API_JQUERY;
            var a = $(document);
            a.ready(function () {
                a.mousemove(_active);
                try {
                    a.mouseenter(_active)
                }
                catch (b) {
                }
                try {
                    a.scroll(_active)
                }
                catch (b) {
                }
                try {
                    a.keydown(_active)
                }
                catch (b) {
                }
                try {
                    a.click(_active)
                }
                catch (b) {
                }
                try {
                    a.dblclick(_active)
                }
                catch (b) {
                }
            })
        }
        function _initPrototype() {
            _api = _API_PROTOTYPE;
            var a = $(document);
            Event.observe(window, "load", function (b) {
                Event.observe(window, "click", _active);
                Event.observe(window, "mousemove", _active);
                Event.observe(window, "mouseenter", _active);
                Event.observe(window, "scroll", _active);
                Event.observe(window, "keydown", _active);
                Event.observe(window, "click", _active);
                Event.observe(window, "dblclick", _active)
            })
        }
        try {
            if (Prototype) {
                _initPrototype()
            }
        }
        catch (err) {
        }
        try {
            if (jQuery) {
                _initJQuery()
            }
        }
        catch (err) {
        }
        setIdleTimeout(600000);
        setAwayTimeout(4000);
        document.onIdle = function () {
            //$("#div_idle").css("opacity", "1")
            //console.log("Idle");
            UpdateStatus("Away");

        };
        document.onAway = function () {
            //$("#div_away").css("opacity", "1")
            //console.log("Away");
            //alert("Away");
            var notification = new Notification('Notification title', {
                icon: 'https://cdn.sstatic.net/stackexchange/img/logos/so/so-icon.png',
                body: "Hey there! You've been notified!",
            });
            status = "Away";
        };
        document.onBack = function (a, b) {
            if (a) {
                //$("#div_idle").css("opacity", "0.2")
                //console.log("not idle");
                UpdateStatus("Online");
                status = "Online";
            }
            if (b) {
                //$("#div_away").css("opacity", "0.2")
                //console.log("Not Away");
            }
        };
    </script>
    <script type="text/javascript">
        function UpdateStatus(stat) {
            $.ajax({
                type: "POST",
                url: "chat.aspx/UpdateStatus",
                data: "{'status':'" + stat + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d == "success") {
                    }
                },
                error: function () {

                }
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#searchbox").hide();
            $('[data-toggle="popover"]').popover({
                placement: 'bottom',
                trigger: 'hover'
            });
        });
    </script>
    <script type="text/javascript">
        var i = "0";
        $("#menu-toggle").click(function (e) {
            e.preventDefault();
            $("#wrapper").toggleClass("toggled");
            $("#menu-toggle").toggleClass('glyphicon-menu-left glyphicon-menu-right');
        });
    </script>
    <script type="text/javascript">
        var type = "";
        var uid = "";
        var heading = "";
        var roletype = "";
        var posttype = "";

        $(document).ready(function () {
            $("#btnsend").hide();
            setInterval(function () {
                checkusermessages();
                LoadPost();
                //latestmessage();
            }, 3000);
            setInterval(function () {
                latestmessage();
            }, 3000);

        });
        function checkusermessages() {
            //alert(type);
            if (searchon == "0") {


                if (type == "usr") {

                    if (typeof $(".ulid").html() === "undefined") {
                        //alert("0");
                        Loadusermsg("0", uid);
                    }
                    else {
                        //alert($(".ulid").html());
                        //alert(uid);
                        Loadusermsg($(".ulid").html(), uid);
                    }
                }
                else if (type == "grp") {
                    if (typeof $(".glid").html() === "undefined") {
                        //alert("0");
                        Loadgrpmsg("0", uid);
                    }
                    else {
                        //alert($(".glid").html());
                        Loadgrpmsg($(".glid").html(), uid);
                    }
                }
            }
        }
        function Loadusermsg(lid, recid) {
            $(".headertitle").css('display', 'block');
            $.ajax({
                type: "POST",
                url: "chat.aspx/GetUserMsg",
                data: "{'Last_Id':'" + lid + "','Rec_Id':'" + recid + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.user != "0") {
                        $(".ulid").html('');
                        $(".ulid").html(data.d.lstid);
                        $("#chatmessages").append(data.d.user);
                        if (status == "Away" || status == "Online") {
                            tit = " Chat Message Received";
                            bdy = data.d.user;
                            myFunction();
                        }
                        //tit = " Chat Message Received";
                        //bdy = data.d.user;
                        //myFunction();
                        //$(".headertitle").html(data.d.lastseen);
                        //alert(data.d.lastseen);
                        $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                    }
                    else {
                        //alert(data.d.user);
                    }
                },
                error: function () {

                }
            });
        }
        function Loadgrpmsg(lid, recid) {
            $(".headertitle").css('display', 'block');
            $.ajax({
                type: "POST",
                url: "chat.aspx/GetGrpMsg",
                data: "{'Last_Id':'" + lid + "','Rec_Id':'" + recid + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.user != "0") {
                        $(".glid").html('');
                        $(".glid").html(data.d.lstid);
                        $("#chatmessages").append(data.d.user);
                        $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                    }
                    else {
                        //alert(data.d.user);
                    }
                },
                error: function () {

                }
            });
        }
        function LoadUserDesc(id) {
            $.ajax({
                type: "POST",
                url: "chat.aspx/GetUserDesc",
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#lbldesc").html(data.d.desc);
                        $("#lbltimer").text(data.d.stat);
                    }
                    else {
                        //alert(data.d.user);
                    }
                },
                error: function () {

                }
            });
        }
        function LoadPost() {
            var lid = $(".plid").html();
            //alert(lid);
            $.ajax({
                type: "POST",
                url: "chat.aspx/GetAllPost",
                data: "{'id':'" + lid + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.posts != "") {
                        $(".plid").html('');
                        $(".plid").html(data.d.lid);
                        $("#posts").prepend(data.d.posts);
                    }
                },
                error: function () {

                }
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".headertitle").css('display', 'none');
            getusers();
        });
        function searchnames() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            ul = document.getElementById("myUL");
            li = ul.getElementsByTagName("li");
            for (i = 0; i < li.length; i++) {
                a = li[i].getElementsByTagName("a")[0];
                if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";

                }
            }
        }
        function getusers() {
            $.ajax({
                type: "POST",
                url: "chat.aspx/GetAllData",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#divuser").html(data.d.user);
                        $("#divuser1").html(data.d.grp);
                    }
                    else {
                        alert(data.d.grp);
                    }
                },
                error: function () {

                }
            });
        }

        function chatbox(anc) {
            $("#searchbox").show();
            $("#imgpro,#Header2,#lbltimer,#lbldesc").css("visibility", "visible");
            $("#myInput").val('');
            $("#header1").html("");
            var id = $(anc).attr("id");
            type = id.substring(0, 3);
            uid = id.substring(3, id.length);
            heading = $("#" + id).find(':nth-child(2)').html();
            //alert($("#" + id).find(':nth-child(2)').attr("name"));
            roletype = $("#" + id).children().attr("name");
            //alert(roletype);

            if ($("#" + id).find(':nth-child(2)').attr("name") != undefined) {
                $("#header1").html("(" + $("#" + id).find(':nth-child(2)').attr("name") + ")");
            }
            $("#Header").html(heading);
            $("#Header2").html(heading);
            $("#chatmessages").html('');

            var imgsrc = $(anc).children().find('img').attr('src');
            $("#imgpro").prop("src", imgsrc);
            LoadUserDesc(uid);
            $("#btnsend").show();

            $("#lblcount" + uid + "").text('');
            if (type == "usr") {
                $.ajax({
                    type: "POST",
                    url: "chat.aspx/GetAllMessages",
                    data: "{'recid':'" + uid + "','type':'" + type + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            latestmessage();
                            $("#chatmessages").append(data.d.dat);
                            $(".lbltimeago").html(data.d.lastseen);
                            $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                            $("#txtmessage").focus();
                        }
                        else {
                            $("#chatmessages").append("No Conversations Yet..!!");
                        }
                    },
                    error: function () {

                    }
                });
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "chat.aspx/GetAllMessages",
                    data: "{'recid':'" + uid + "','type':'" + type + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {

                            $("#chatmessages").append(data.d.dat);
                            $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                            $("#txtmessage").focus();
                        }
                        else {
                            $("#chatmessages").append("No Conversations Yet..!!");
                        }
                    },
                    error: function () {

                    }
                });
            }

            //Get All Data Belonging to the grp or user desc.
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
            $("#btnsend").click(function (e) {
                e.preventDefault();
                var recid = uid;
                var message = $("#txtmessage").val();
                if (message == "") {
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "chat.aspx/SendMessage",
                    data: "{'recid':'" + recid + "','msg':'" + message + "','role':'" + roletype + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "success") {
                            $("#txtmessage").val('');
                            var msg = "<div class='chat_message_wrapper chat_message_right'>" +
                                "<div class='chat_user_avatar'>" +
                                    "<a href='#' target='_blank'>" +
                                       "<img src='dp/" + $("#hdimage").val() + "' class='md-user-image' style='height: 40px;width: 40px;' >" +
                                    "</a>" +
                                "</div>" +
                                "<ul class='chat_message'>" +
                                    "<li>" +
                                        "<p style='color:white;'>" + message + "<span class='chat_message_time' style='color:white;'></span>" +
                                        "</p>" +
                                    "</li>" +

                                "</ul>" +
                            "</div>";
                            $("#chatmessages").append(msg);
                            $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                            $("#txtmessage").val('');
                            $("#txtmessage").focus();
                        }
                        else {
                            alert(data.d);
                        }
                    },
                    error: function () {

                    }
                });

            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnshare").click(function (e) {
                e.preventDefault();
                var post = $("#txtshare").val();
                if (post.trim() == "") {
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "chat.aspx/SharePost",
                    data: "{'post':'" + post.replace(/'/g, '\\\'') + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            $("#posts").prepend(data.d);
                            posttype = "";
                            //alert("Posted");
                        }
                        else {
                            alert(data.d);
                        }
                    },
                    error: function () {

                    }
                });
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnUpload').click(function (event) {
                UploadFile();
            });
            $("#btnpostimage,#btnpostvideo").click(function (e) {
                e.preventDefault();
                $("#btnpost").prop("disabled", true);
                $("#myModal-2").modal({ backdrop: "static" });
                posttype = "post";
                $("#btnpost").text('Post');
            });
            $("#btnuploadnote,#btnuploaddoc,#btnuploadmedia").click(function (e) {
                e.preventDefault();
                $('#myModal-2').modal({ backdrop: 'static' });
                posttype = "chat";
                $("#btnpost").text('Send');
            });
        });
    </script>
    <script type="text/javascript">
        var counter;
        function UploadFile() {
            var files = $("#<%=uploader.ClientID%>").get(0).files;
            counter = 0;

            // Loop through files
            for (var i = 0; i < files.length ; i++) {
                var file = files[i];
                var formdata = new FormData();
                formdata.append("uploader", file);
                var ajax = new XMLHttpRequest();

                ajax.upload.addEventListener("progress", progressHandler, false);
                ajax.addEventListener("load", completeHandler, false);
                ajax.addEventListener("error", errorHandler, false);
                ajax.addEventListener("abort", abortHandler, false);
                ajax.open("POST", "Admin/UploadHandler.ashx");
                ajax.send(formdata);
            }
        }

        function progressHandler(event) {
            $("#loaded_n_total").html("Uploaded " + event.loaded + " bytes of " + event.total);
            var percent = (event.loaded / event.total) * 100;
            $("#progressBar").val(Math.round(percent));
            $("#status").html(Math.round(percent) + "% uploaded... please wait");
        }

        function completeHandler(event) {
            counter++
            $("#status").html(counter + " " + event.target.responseText);
            $("#btnpost").prop("disabled", false);
        }

        function errorHandler(event) {
            $("#status").html("Upload Failed");
        }

        function abortHandler(event) {
            $("#status").html("Upload Aborted");
        }
    </script>
    <script type="text/javascript">
        var counter1;
        function UploadFile1() {
            var files = $("#<%=fupuserimg.ClientID%>").get(0).files;
            counter = 0;

            // Loop through files
            for (var i = 0; i < files.length ; i++) {
                var file = files[i];
                var formdata = new FormData();
                formdata.append("fupuserimg", file);
                var ajax = new XMLHttpRequest();

                ajax.upload.addEventListener("progress", progressHandler1, false);
                ajax.addEventListener("load", completeHandler1, false);
                ajax.addEventListener("error", errorHandler1, false);
                ajax.addEventListener("abort", abortHandler1, false);
                ajax.open("POST", "Admin/UploadHandler.ashx");
                ajax.send(formdata);
            }
        }

        function progressHandler1(event) {
            //$("#loaded_n_total").html("Uploaded " + event.loaded + " bytes of " + event.total);
            var percent = (event.loaded / event.total) * 100;
            //$("#progressBar").val(Math.round(percent));
            $("#status1").html(Math.round(percent) + "% uploaded... please wait");
        }

        function completeHandler1(event) {
            counter1++
            $("#status1").html(event.target.responseText);
            alert(event.d);
            //$("#btnpost").prop("disabled", false);
        }

        function errorHandler1(event) {
            $("#status1").html("Upload Failed");
        }

        function abortHandler1(event) {
            $("#status1").html("Upload Aborted");
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnpost").click(function (e) {
                e.preventDefault();
                var text = $("#txtuploadtext").val();
                var filename = $("#uploader").val().replace(/C:\\fakepath\\/i, '');
                if (filename == "") {
                    alert("Upload a File..!!");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "chat.aspx/PostWithFile",
                    data: "{'recid':'" + uid + "','text':'" + text + "','filename':'" + filename + "','image':'" + $("#hdimage").val() + "','name':'" + $("#hdname").val() + "','post':'" + posttype + "','role':'" + roletype + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            if (posttype == "post") {
                                $("#posts").prepend(data.d);
                            }
                            else {
                                $("#chatmessages").append(data.d);
                                $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                            }

                            $("#txtuploadtext").val('');
                            $("#myModal-2").modal('hide');
                            $("#status").html('');
                            $("#progressBar").val('');
                            $("#uploader").val('');
                            $("#btnpost").text('Post');
                            //$("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                            //$("#txtmessage").focus();
                        }
                        else {
                            $("#chatmessages").append("No Conversations Yet..!!");
                        }
                    },
                    error: function () {

                    }
                });
            });
        });
    </script>
    <script type="text/javascript">
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#imguser').attr('src', e.target.result);
                }

                reader.readAsDataURL(input.files[0]);
            }
        }


        function userset(anchor) {
            $("#modaluser").modal('toggle');
            $("#imguser").prop("src", "dp/" + $("#hdimage").val());
            $.ajax({
                type: "POST",
                url: "chat.aspx/GetProfile",
                data: "{'id':'" + anchor + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#txtfnameuser").val(data.d.fname);
                        $("#txtlnameuser").val(data.d.lname);
                        $("#txtemailuser").val(data.d.email);
                        $("#txtdescuser").val(data.d.desc);
                    }
                    else {
                        alert(data.d);
                    }
                },
                error: function () {

                }
            });
        }
        $(document).ready(function () {
            $("#fupuserimg").change(function () {
                readURL(this);
            });
            $("#imguser").click(function (e) {
                e.preventDefault();
            });
            $("#imguser,.img-text").mouseover(function () {
                $(".img-text").css("display", "block");
            });
            $("#imguser,.img-text").mouseout(function () {
                $(".img-text").css("display", "none");
            });
            $(".img-text").click(function (e) {
                e.preventDefault();
                $("#fupuserimg").click();
                //upload the image
                //UploadFile1();
                //Update the image name
                //Set the image
            });
            $("#btnupdateuser").click(function () {
                var fname = $("#txtfnameuser").val();
                var lname = $("#txtlnameuser").val();
                var email = $("#txtemailuser").val();
                var filename = $('#fupuserimg').val().replace(/C:\\fakepath\\/i, '');
                var desc = $("#txtdescuser").val();
                $.ajax({
                    type: "POST",
                    url: "chat.aspx/UpdateProfile",
                    data: "{'fname':'" + fname + "','lname':'" + lname + "','email':'" + email + "','filename':'" + filename + "','desc':'" + desc + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            alert("Updated Sucessfully..!!");
                            if (data.d == "1") {
                                UploadFile1();
                                $("#lblname").html('');

                            }
                            $("#lblname").html(fname + " " + lname);
                        }
                        else {
                            alert(data.d);
                        }
                    },
                    error: function () {

                    }
                });
            });
        });
    </script>
    <script type="text/javascript">
        function openInNewTab() {
            var win = window.open("conference.html", '_blank', "width=400, height=400");
            win.focus();
            //$("#modalvideo").modal({ backdrop: "static" });
        }
        function downloadfile(anch) {
            var href = anch.src;
            alert(href);
            return false;
            window.location.href = href;
        }
    </script>
    <script type="text/javascript">
        function latestmessage() {
            if ($("#myInput").val() == "") {
                $.ajax({
                    type: "POST",
                    url: "chat.aspx/GetLatestMessage",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            $("#myUL").html(data.d);  //ex3
                        }
                    },
                    error: function () {

                    }
                });
            }
        }
    </script>
    <script type="text/javascript">
        function like(anc) {
            var id = $(anc).prop("id");
            var ids = id.substring(7, id.length);
            if ($("#" + id + "").css("color") == "rgb(255, 0, 0)") {
                //alert("Red");
                //increment like
                var hit = $("#likehit" + ids + "").html();
                var incre = (parseInt(hit) - 1);
                $("#likehit" + ids + "").html(incre);
                $("#" + id + "").css("color", "black");
                //return false;
                $.ajax({
                    type: "POST",
                    url: "chat.aspx/RemoveLike",
                    data: "{'postid':'" + ids + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        //alert(data.d);

                    },
                    error: function () {

                    }
                });
            }
            else if ($("#" + id + "").css("color") == "rgb(0, 0, 0)") {
                //alert("blank");
                //decrement like
                var hit = $("#likehit" + ids + "").html();
                var incre = (parseInt(hit) + 1);
                $("#likehit" + ids + "").html(incre);
                $("#likehit" + ids + "").animate("heart-burst .8s steps(28) 1");
                $("#" + id + "").css("color", "red");
                //return false;
                $.ajax({
                    type: "POST",
                    url: "chat.aspx/AddLike",
                    data: "{'postid':'" + ids + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                    },
                    error: function () {

                    }
                });
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#imgpro,#Header2,#lbltimer,#lbldesc").css("visibility", "hidden");
        });
    </script>
    <script type="text/javascript">
        var cmntid = "";
        function comments(anchor) {
            cmntid = anchor;
            GetAllComments(anchor);
            $("#myModal-3").modal({ backdrop: "static" });
        }
        function GetAllComments(anchor) {
            $("#divcomments").html('');
            $.ajax({
                type: "POST",
                url: "chat.aspx/GetComment",
                data: "{'Post_Id':'" + anchor + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#divcomments").html(data.d.cmnt);
                    $("#divthumb").html(data.d.post);
                    $("#comment").animate({ scrollTop: $('#divcomments').height() }, 1000);
                },
                error: function () {

                }
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtcomment').keypress(function (e) {
                if (e.which == 13) {
                    addcomment($("#txtcomment").val(), cmntid);
                    $("#txtcomment").val('');
                    return false;
                }
            });
        });
    </script>
    <script type="text/javascript">
        function addcomment(text, id) {
            $.ajax({
                type: "POST",
                url: "chat.aspx/AddComment",
                data: "{'Post_Id':'" + id + "','comment':'" + text + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#divcomments").append(data.d);
                    $("#comment").animate({ scrollTop: $('#divcomments').height() }, 1000);
                },
                error: function () {

                }
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btncancel").click(function (e) {
                e.preventDefault();
                $("#txtuploadtext").val('');
                $("#progressBar").val('');
                $("#status").html('');
                $("#uploader").val('');
                var filename = $("#uploader").val().replace(/C:\\fakepath\\/i, '');
                if (filename != "") {
                    $.ajax({
                        type: "POST",
                        url: "chat.aspx/RemoveFile",
                        data: "{}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d == "success") {
                                $("#uploader").val('');
                            }

                        },
                        error: function () {

                        }
                    });
                }
            });
        });
    </script>
    <script type="text/javascript">
        function openmodal(anch) {
            $("#myModal").modal({ backdrop: "static" });
            // Get the modal
            var modal = document.getElementById('myModal');

            // Get the image and insert it inside the modal - use its "alt" text as a caption
            var img = document.getElementById('myImg');
            var modalImg = document.getElementById("img01");
            var captionText = document.getElementById("caption");

            modal.style.display = "block";
            modalImg.src = anch.src;
            captionText.innerHTML = anch.alt;
        }
    </script>
    <script>
        function myFunction() {
            $(".js-notification-long-title-body").click();

        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtmessage').keypress(function (e) {
                if (e.keyCode == 13) {
                    var recid = uid;
                    var message = $("#txtmessage").val();
                    if (message == "") {
                        return false;
                    }
                    $.ajax({
                        type: "POST",
                        url: "chat.aspx/SendMessage",
                        data: "{'recid':'" + recid + "','msg':'" + message + "','role':'" + roletype + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d == "success") {
                                $("#txtmessage").val('');
                                var msg = "<div class='chat_message_wrapper chat_message_right'>" +
                                    "<div class='chat_user_avatar'>" +
                                        "<a href='#' target='_blank'>" +
                                           "<img src='dp/" + $("#hdimage").val() + "' class='md-user-image' style='height: 40px;width: 40px;' >" +
                                        "</a>" +
                                    "</div>" +
                                    "<ul class='chat_message'>" +
                                        "<li>" +
                                            "<p style='color:white;'>" + message + "<span class='chat_message_time' style='color:white;'></span>" +
                                            "</p>" +
                                        "</li>" +

                                    "</ul>" +
                                "</div>";
                                $("#chatmessages").append(msg);
                                $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                                $("#txtmessage").val('');
                                $("#txtmessage").focus();
                            }
                            else {
                                alert(data.d);
                            }
                        },
                        error: function () {

                        }
                    });
                }
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#txtsearchtext").keyup(function () {
                if ($("#txtsearchtext").val() != "") {
                    $("#btnsearchchat").children().attr("class", "glyphicon glyphicon-search");
                }
                else {

                    if (typeof $(".ulid").html() == "undefined") {
                        $.ajax({
                            type: "POST",
                            url: "chat.aspx/GetAllMessages",
                            data: "{'recid':'" + uid + "','type':'" + type + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d != "") {
                                    latestmessage();
                                    $("#chatmessages").append(data.d.dat);
                                    $(".lbltimeago").html(data.d.lastseen);
                                    $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                                    $("#txtmessage").focus();
                                    searchon = "0";
                                }
                                else {
                                    $("#chatmessages").append("No Conversations Yet..!!");
                                }
                            },
                            error: function () {

                            }
                        });
                    }
                }
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnsearchchat").click(function (e) {
                e.preventDefault();
                if ($("#btnsearchchat").children().attr("class") == "glyphicon glyphicon-remove") {
                    $("#txtsearchtext").val('');
                    $("#btnsearchchat").children().attr("class", "glyphicon glyphicon-search")
                    //get previous chat.
                    $("#chatmessages").html("");
                    searchon = "0";
                    $.ajax({
                        type: "POST",
                        url: "chat.aspx/GetAllMessages",
                        data: "{'recid':'" + uid + "','type':'" + type + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d != "") {
                                latestmessage();
                                $("#chatmessages").append(data.d.dat);
                                $(".lbltimeago").html(data.d.lastseen);
                                $("#chat").animate({ scrollTop: $('#chatmessages').height() }, 1000);
                                $("#txtmessage").focus();
                            }
                            else {
                                $("#chatmessages").append("No Conversations Yet..!!");
                            }
                        },
                        error: function () {

                        }
                    });
                }
                else {
                    searchon = "1";
                    $("#btnsearchchat").children().attr("class", "glyphicon glyphicon-remove")

                    $.ajax({
                        type: "POST",
                        url: "chat.aspx/GetSearchResults",
                        data: "{'data':'" + $("#txtsearchtext").val() + "','type':'" + type + "','uid':'" + uid + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d != "1") {
                                $("#chatmessages").html("");
                                $("#chatmessages").html(data.d);
                            }
                            else {
                                $("#chatmessages").html("");
                                $("#chatmessages").html("No Such Conversation Found..!!");
                            }
                        },
                        error: function () {

                        }
                    });
                }

            });
        });
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <asp:HiddenField ID="hdimage" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hdname" ClientIDMode="Static" runat="server" />
        <%--<input type="button" class="js-notification-long-title-body" clientidmode="static" />--%>
        <button class="js-notification-long-title-body" type="button" clientidmode="Static"></button>
        <asp:FileUpload ID="fupuserimg" runat="server" ClientIDMode="Static" Style="display: none;" />
        <div class="row">
            <div class="col-md-3">
                <ul class="sidebar-nav" id="divuser" clientidmode="static" style="border-right: 1px solid #dedede;">
                </ul>
            </div>
            <div class="col-md-5" style="border-right: 1px solid #dedede; padding-left: 0;">
                <a href="#menu-toggle" class="glyphicon glyphicon-menu-right" id="menu-toggle" style="font-size: x-large; margin-left: -5%; margin-top: 2%; text-decoration: none;">kjjkdasdka</a>
                <div class="panel panel-info" style="margin-top: 1%;">
                    <div class="panel-body">
                        <textarea placeholder="Write your comment here!" class="pb-cmnt-textarea" id="txtshare" clientidmode="static" style="border-color: #bce8f1;"></textarea>
                        <form class="form-inline">
                            <div class="btn-group" style="border-color: #bce8f1; border: 1px solid #bce8f1; border-radius: 5px;">
                                <button class="btn" id="btnpostimage" type="button" style="background: transparent;"><span class="fa fa-picture-o fa-lg" data-toggle="modal"></span></button>
                                <button class="btn" id="btnpostvideo" type="button" style="border-left: 1px solid #bce8f1; background: transparent;" data-toggle="modal"><span class="fa fa-video-camera fa-lg"></span></button>
                            </div>
                            <input type="button" value="Share" class="btn btn-info pull-right" id="btnshare" clientidmode="static" style="background-color: white; color: #3572a7;" />
                        </form>
                    </div>
                </div>
                <div class="col-md-12" id="posts" runat="server" style="max-height: 466px; overflow-y: auto;" clientidmode="static">
                </div>
            </div>
            <div class="col-md-4" style="border-left: 1px solid #dedede;">
                <div class="col-md-12" style="padding-top: 8%; padding-left: 12%; height: 65px; border-bottom: 1px solid #dedede;">
                    <span style="font-size: 18px;">Profile</span>
                    <button onclick="notifyMe()">Notify me!</button>
                    <%--<img  src="img/video-call.png" style="margin-bottom: 5%; margin-left: 15%;" />--%>
                    <img onclick="openInNewTab();" title="Video Call" src="img/phone.png" style="margin-bottom: 5%; margin-left: 50%;" />
                    <img src="img/group1.png" title="Group" data-toggle="modal" data-target="#myModal2" style="height: 40px; width: 40px; margin-left: 4%; margin-top: -18px; margin-bottom: 2%;" />
                    <asp:LinkButton ID="Logoutlink" class="glyphicon glyphicon-off" runat="server" OnClick="Logoutlink_Click" title="Logout" Style="float: right; margin-right: 1%; color: #b00e3f; font-size: 24px; margin-top: -1%;"></asp:LinkButton>
                    <%--<asp:Button ID="Logoutlink" class="glyphicon glyphicon-off" runat="server" OnClick="Logoutlink_Click" title="Logout" style="float: right;margin-right: 1%;color: #b00e3f;font-size: 24px;margin-top:-1%;" />--%>
                    <!-- <button type="button" class="btn btn-demo" >Right Sidebar Modal</button> -->
                </div>
                <div class="col-md-12" style="padding-top: 8%; padding-left: 0; height: 171px; border-bottom: 1px solid #dedede;">
                    <div class="col-md-3" style="padding-right: 0;">
                        <img id="imgpro" src="#" class="md-user-image" style="width: 60px; height: 60px;">
                    </div>
                    <div class="col-md-9" style="padding-left: 0; padding-top: 2%;">

                        <span id="Header2"></span><span id="header1" style="font-weight: 500;"></span>
                        <br>
                        <span id="lbltimer" style="font-size: 10px;">Active <span class="lbltimeago"></span><span>
                    </div>
                    <div class="col-md-12" style="top: 10px;" id="lbldesc" clientidmode="static">
                    </div>
                </div>
                <div class="col-md-12" clientidmode="static" style="border-bottom: 1px solid #dedede; z-index: 2; height: 65px;">
                    <div class="col-md-8 col-xs-8" style="padding-top: 13px;">
                        <span id="Header" class="headertitle" style="color: green; font-size: 16px;" data-toggle="tooltip" title="">Harvey Spectre</span>
                        <h6 class="headertitle">Last Message at <span class="lbltimeago">10:30 AM</span></h6>
                    </div>
                    <div class="col-md-2"></div>
                    <div class="col-md-1 col-xs-2">
                        <div class="dropdown headertitle">
                            <span data-toggle="dropdown" class="fa fa-paperclip" style="font-size: 26px; padding-top: 19px;" title="Attach">
                                <%--<img src="icons/png/paper-clip.png" style="width: 60%; margin-top: 56%;" />--%></span>
                            <div class="dropdown-menu ddldrop">
                                <div class="Note text-center" id="btnuploadnote" style="" title="Document" clientidmode="static">
                                    <i class="fa fa-file fa-lg" style="-webkit-box-shadow: 2px 2px rgba(106, 106, 106, 0.65); background-color: #e3e3e3db; width: 60%; border: 1.5px solid #e3e3e3; padding: 19%; border-radius: 41px; height: 47px; margin-bottom: 13%; margin-top: 30%; font-size: 19px;"></i>
                                    <%--<img src="icons/png/edit.png" style="-webkit-box-shadow: 2px 2px rgba(106, 106, 106, 0.65); background-color: #e3e3e3db; width: 60%; border: 1.5px solid #e3e3e3; padding: 13%; border-radius: 41px; height: 47px; margin-bottom: 13%; margin-top: 30%;" />--%>
                                </div>
                                <div class="Document text-center" id="btnuploaddoc" style="" title="Image" clientidmode="static">
                                    <i class="fa fa-picture-o fa-lg" style="-webkit-box-shadow: 2px 2px rgba(106, 106, 106, 0.65); background-color: #e3e3e3db; width: 60%; border: 1.5px solid #e3e3e3; padding: 19%; border-radius: 41px; height: 47px; margin-bottom: 13%; font-size: 19px;"></i>
                                    <%--<img src="icons/png/folder.png" style="-webkit-box-shadow: 2px 2px rgba(106, 106, 106, 0.65); background-color: #e3e3e3db; width: 60%; border: 1.5px solid #e3e3e3; padding: 13%; border-radius: 41px; height: 47px; margin-bottom: 13%;" />--%>
                                </div>
                                <div class="Media text-center" id="btnuploadmedia" style="" title="Video" clientidmode="static">
                                    <i class="fa fa-video-camera fa-lg" style="-webkit-box-shadow: 2px 2px rgba(106, 106, 106, 0.65); background-color: #e3e3e3db; width: 60%; border: 1.5px solid #e3e3e3; padding: 19%; border-radius: 41px; height: 47px; margin-bottom: 13%; font-size: 19px;"></i>
                                    <%--<img src="icons/png/musical-note.png" style="-webkit-box-shadow: 2px 2px rgba(106, 106, 106, 0.65); background-color: #e3e3e3db; width: 60%; border: 1.5px solid #e3e3e3; padding: 13%; border-radius: 41px; height: 47px;" />--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-1 col-xs-2">
                    </div>
                </div>
                <div class="col-md-12" id="searchbox" style="padding-left: 0px;">
                    <div class="input-group">

                        <input id="txtsearchtext" type="text" class="form-control" name="email" placeholder="Search in Conversation">
                        <div class="input-group-btn">
                            <button class="btn btn-default" type="button" id="btnsearchchat" clientidmode="static">
                                <i class="glyphicon glyphicon-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-12" id="divchat" style="height: 280px; width: 100%; border-bottom: 1px solid #dedede; padding-left: 0; padding-right: 0;">
                    <div id="chat" class="chat_box_wrapper chat_box_small chat_box_active scrollbar" style="opacity: 1; display: block; transform: translateX(0px);">
                        <div class="chat_box touchscroll chat_box_colors_a" id="chatmessages">
                            <div class="col-md-12 text-center">Click on the user to start Conversation..!!</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-10 col-xs-9">
                    <textarea maxlength="50000" id="txtmessage" clientidmode="static" class="form-control" placeholder="Type Your Message..." cols="5" rows="2" style="border: 0px; padding: 10px 13px 0 8px; box-shadow: none;"></textarea>
                </div>
                <div class="col-md-2 col-xs-3" id="divbtn" style="padding-top: 2%;">
                    <a href="#" id="btnsend" clientidmode="static">
                        <img id="btnimg" src="img/send.png" /></a>
                </div>
            </div>

            <!-- Modal -->
            <div class="modal right fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" style="margin-left: 1046px;">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">

                        <div class="modal-header" style="height: 65px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="glyphicon glyphicon-chevron-right" style="top: 7px;"></span></button>
                            <h4 class="modal-title" id="myModalLabel2">Groups</h4>
                        </div>

                        <div class="modal-body">
                            <ul class="sidebar-nav" id="divuser1" clientidmode="static">
                            </ul>
                        </div>

                    </div>
                    <!-- modal-content -->
                </div>
                <!-- modal-dialog -->
            </div>
            <!-- modal -->

            <div class="modal fade" id="myModal-2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel-2">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalLabel-2">Upload a File</h4>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-6">
                                <asp:FileUpload ID="uploader" runat="server" />
                            </div>
                            <div class="col-md-6">
                                <input type="button" id="btnUpload" value="Upload Now" class="btn btn-info" />

                            </div>
                            <div class="col-md-12" style="margin-top: 1%;">
                                <progress id="progressBar" value="0" max="100" style="width: 500px;"></progress>
                            </div>
                            <div class="col-md-12">
                                <h5 id="status"></h5>
                                <%--<p id="loaded_n_total"></p>--%>
                            </div>
                            <div class="col-md-12">
                                <textarea class="form-control" rows="5" id="txtuploadtext" clientidmode="static" placeholder="Write Something..!!"></textarea>
                            </div>
                            <div class="col-md-12 text-center" style="margin-top: 1%;">
                                <button type="button" class="btn btn-dialog" id="btnpost" clientidmode="static">Post</button>
                                <button type="button" class="btn btn-dialog" id="btncancel" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                        <div class="modal-footer">
                        </div>
                    </div>
                    <!-- modal-content -->
                </div>
                <!-- modal-dialog -->
            </div>
            <!-- modal -->

            <!-- Modal -->
            <div class="modal right fade" id="modaluser" tabindex="-1" role="dialog" aria-labelledby="modaluser" style="margin-left: 1046px;">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">

                        <div class="modal-header" style="height: 65px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="glyphicon glyphicon-chevron-right" style="top: 7px;"></span></button>
                            <h4 class="modal-title" id="modaluser2">My Profile</h4>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12 text-center">
                                <div class='img-text'>Change Picture</div>
                                <img src="dp/Chrysanthemum.jpg" id="imguser" clientidmode="static" style="border-radius: 100px; width: 130px; height: 130px; box-shadow: 0 5px 15px -8px rgba(0, 0, 0, .24), 0 8px 10px -5px rgba(0, 0, 0, .2);" />
                                <h5 id="status1"></h5>
                            </div>
                            <div class="form-group">
                                <label for="fname">First Name</label>
                                <input type="text" class="form-control" id="txtfnameuser" />
                            </div>
                            <div class="form-group">
                                <label for="lname">Last Name</label>
                                <input type="text" class="form-control" id="txtlnameuser" />
                            </div>
                            <div class="form-group">
                                <label for="email">Email Id</label>
                                <input type="email" class="form-control" id="txtemailuser" />
                            </div>
                            <div class="form-group">
                                <label for="desc">Description</label>
                                <textarea class="form-control" id="txtdescuser" rows="5"></textarea>
                            </div>
                            <div class="col-md-12 text-center">
                                <input type="button" value="Update Changes" id="btnupdateuser" class="btn btn-info" clientidmode="static" />
                            </div>

                        </div>

                    </div>
                    <!-- modal-content -->
                </div>
                <!-- modal-dialog -->
            </div>
            <!-- modal -->

            <!-- modal -->
            <div class="modal fade" id="myModal-3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel-2" style="background-color: #0000004a;">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" id="myModalLabel-3">Post</h4>
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="col-md-6" style="border-right: 1px solid #0000002b;">
                                        <div class="col-md-12" id="divthumb">
                                        </div>
                                    </div>
                                    <div class="col-md-6" style="">
                                        <div id="comment" class="chat_box_wrapper chat_box_small chat_box_active scrollbar" style="background-color: #8f59000d; opacity: 1; display: block; transform: translateX(0px); height: 292px;">
                                            <div class="chat_box touchscroll chat_box_colors_a" id="divcomments">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <textarea rows="2" class="form-control" id="txtcomment" placeholder="Enter Comments..!!"></textarea>
                                        </div>
                                        <!-- /col-sm-5 -->
                                        <!-- /col-sm-1 -->

                                    </div>
                                </div>
                            </div>



                        </div>
                        <div class="modal-footer">
                        </div>
                    </div>
                    <!-- modal-content -->
                </div>
                <!-- modal-dialog -->
            </div>
        </div>
        <!-- container -->
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
        <!-- Modal -->
        <div class="modal fade" id="modalvideo" role="dialog" style="background-color: #0000004f;">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Video Calling</h4>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <script type="text/javascript" src="conference.js"></script>
                            <script type="text/javascript" src="https://api.bistri.com/bistri.conference.min.js"></script>
                            <input type="button" id="btnclose" value="End Call" class="btn btn-danger" data-dismiss="modal" />
                            <button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
                        </div>
                        <div class="col-md-12">
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>

            </div>
        </div>

        <!-- The Modal -->
        <div id="myModal" class="modalimg">
            <span class="closes" data-dismiss="modal">&times;</span>
            <img class="modal-contents" id="img01" />
            <div id="caption"></div>
        </div>
    </form>
</body>
</html>
