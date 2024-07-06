<%@ page import="com.example.car_rental.config.GCON" %>
<%@ page import="com.example.car_rental.tool.DataBase" %><%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/2/22
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <meta charset="UTF-8">
    <title>租车管理系统</title>
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/semantic.min.css">
    <script src="../static/semantic/dist/jquery.min.js"></script>
    <script src="../static/semantic/dist/semantic.js"></script>
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/reset.css">
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/site.css">

    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/container.css">
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/divider.css">
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/grid.css">

    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/header.css">
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/segment.css">
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/table.css">
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/icon.css">
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/menu.css">
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/components/message.css">

    <style type="text/css">
        h2 {
            margin: 1em 0;
        }
        .ui.container {
            padding-top: 5em;
            padding-bottom: 5em;
        }
    </style>

    <script>
        var i=0;
        function myDate(){
            var now=new Date();
            var year=now.getFullYear();
            var month=now.getMonth()+1;
            var day=now.getDate();
            var hours=now.getHours();
            var minutes=now.getMinutes();
            var seconds=now.getSeconds();
            document.getElementById("div").innerHTML=year+"年"+fix(month, 2)+"月"+fix(day, 2)+"日"+fix(hours, 2)+" : "+fix(minutes, 2)+" : "+fix(seconds, 2);
        }

        function fix(num, length) {
            return ('' + num).length < length ? ((new Array(length + 1)).join('0') + num).slice(-length) : '' + num;
        }
        setInterval(myDate,1000);
    </script>
</head>
<body>
<style>
    .fixed-header {
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1000;
    }
</style>
<div class="fixed-header">
<div class="ui inverted menu">

    <div style="text-align: center; /* 水平居中 */ margin: 0 auto; /* 左右居中 */">
        <div class="ui simple dropdown item">
            <i class="calendar icon"></i>
            <div id="div"></div>
        </div>
    </div>

</div>
</div>

<div class="pusher">
    <%--返回上一页--%>
    <a href="javascript:history.back()" class="ui button" style=";top:50%;position: fixed;z-index:100;">
        <i class="reply icon"></i>
        <i>返回上一页</i>
    </a>
</div>

</body>
</html>
