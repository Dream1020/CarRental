<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/3/11
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (session.getAttribute("caradmin") == null) {
    response.sendRedirect("/userindex.jsp");
  }

%>

<html>
<head>
  <title>租车商页面</title>

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

    <div>
      <a class="item" href="${pageContext.request.contextPath}/merchant/carretal.jsp"><i class="home icon"></i>主页</a>
    </div>

    <div class="ui simple dropdown item">
      <i class="tasks icon"></i>
      已租出的车
      <i class="dropdown icon"></i>
      <div class="menu">
        <a class="item" href="${pageContext.request.contextPath}/merchant/historyout.jsp?op=1&pageIndex=1"><i class="history icon"></i>历史租出的车</a>
      </div>
    </div>

    <div class="ui simple dropdown item">
      <i class="car icon"></i>
      车辆管理
      <i class="dropdown icon"></i>
      <div class="menu">
        <a class="item" href="${pageContext.request.contextPath}/merchant/updatecar.jsp?op=1"><i class="write icon"></i>修改车辆</a>
        <a class="item" href="${pageContext.request.contextPath}/merchant/lodingcar.jsp?op=1"><i class="upload icon"></i>增加车辆</a>
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
        <%="租车商: " + session.getAttribute("caradmin")+",你好呀❤️"%>
        <i class="dropdown icon"></i>
        <div class="menu">
          <a class="item" href="${pageContext.request.contextPath}/merchant/myinfo.jsp?op=1"><i class="server icon"></i>自己的信息</a>
          <a class="item" href="${pageContext.request.contextPath}/ServiceManage?op=9"><i class="sign out icon"></i>注销</a>
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

