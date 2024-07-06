<%@ page import="com.example.car_rental.config.GCON" %>
<%@ page import="com.example.car_rental.tool.DataBase" %>
<%@ page import="static com.example.car_rental.tool.DataBase.MAP" %><%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/2/22
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String success = (String)request.getSession().getAttribute("success");
    if (success != null) {%>
        <script type="text/javascript">
            alert("<%=success%>");
        </script>
<%
        // 清除错误信息，避免重复显示
        request.getSession().removeAttribute("succes");
    }
    if (session.getAttribute("caradmin") == null) {
        response.sendRedirect("/sysindex.jsp");
    }

//    String sn = request.getSession().getAttribute("systemadmin").toString();
    if(GCON.status==1){ //修改权限
        try {
            DataBase.setConnection(MAP.get(GCON.SYSTEMUSERNAME));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        GCON.status=0 ;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>租车管理系统</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/semantic.min.css">
    <script src="${pageContext.request.contextPath}/static/semantic/dist/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/semantic/dist/semantic.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/reset.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/site.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/container.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/divider.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/grid.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/header.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/segment.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/table.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/icon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/menu.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/components/message.css">

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

    <div class="ui simple dropdown item">
        <i class="tasks icon"></i>
        业务办理
        <i class="dropdown icon"></i>
        <div class="menu">
            <a class="item" href="${pageContext.request.contextPath}/carManagement/carOrder.jsp?op=1"><i class="arrow right icon"></i>订车</a>
            <a class="item" href="${pageContext.request.contextPath}/carManagement/carRenew.jsp?op=1"><i class="spinner icon"></i>续费</a>
            <a class="item" href="${pageContext.request.contextPath}/carManagement/carCheckOut.jsp?op=1"><i class="arrow left icon"></i>退车</a>
        </div>
    </div>

    <div class="ui simple dropdown item">
        <i class="building icon"></i>
        汽车管理
        <i class="dropdown icon"></i>
        <div class="menu">
            <a class="item" href="${pageContext.request.contextPath}/CarManage?op=1"><i class="search icon"></i>查询汽车</a>
            <a class="item" href="${pageContext.request.contextPath}/CarManage?op=2"><i class="write icon"></i>修改汽车</a>
            <a class="item" href="${pageContext.request.contextPath}/CarManage?op=3"><i class="plus icon"></i>增加汽车</a>
            <a class="item" href="${pageContext.request.contextPath}/CarManage?op=4"><i class="zoom out icon"></i>汽车概览</a>
        </div>
    </div>

    <div class="ui simple dropdown item">
        <i class="browser icon"></i>
        订单浏览
        <i class="dropdown icon"></i>
        <div class="menu">
            <a class="item" href="${pageContext.request.contextPath}/OrderManage?op=1"><i class="book icon"></i>预定订单</a>
            <a class="item" href="${pageContext.request.contextPath}/OrderManage?op=2"><i class="file icon"></i>租车订单</a>
            <a class="item" href="${pageContext.request.contextPath}/OrderManage?op=3"><i class="file text outline icon"></i>续费订单</a>
            <a class="item" href="${pageContext.request.contextPath}/OrderManage?op=4"><i class="file archive outline icon"></i>历史订单</a>
            <a class="item" href="${pageContext.request.contextPath}/OrderManage?op=5"><i class="folder open icon"></i>所有订单</a>
        </div>
    </div>

    <div class="right menu">
        <div class="ui simple dropdown item">
            <i class="calendar icon"></i>
            <div id="div"></div>
        </div>
    </div>

    <div class="right menu">
        <div class="ui simple dropdown item">
            <i class="user icon"></i>
            <%="租车管理员: " + session.getAttribute("caradmin")%>  <%-- 后期换成session("name")  --%>
            <i class="dropdown icon"></i>
            <div class="menu">
                <a class="item" href="${pageContext.request.contextPath}/ServiceManage?op=2"><i class="sign out icon"></i>注销</a>
            </div>
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
<%-- 下面这个script是为了让全部的菜单栏显示出来 --%>
<%--<script>--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        document.querySelectorAll('.ui.simple.dropdown.item').forEach(function(item) {--%>
<%--            item.classList.add('active');--%>
<%--            item.querySelector('.menu').classList.add('visible');--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
</body>
</html>
