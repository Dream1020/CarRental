<%@ page import="com.example.car_rental.entity.Comment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/3/27
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  int op = Integer.parseInt(request.getParameter("op"));
  String carname=request.getParameter("carname");
  String belong = request.getParameter("belong");
  String carNumber ="";
  if(!request.getParameter("carNumber").isEmpty()){
    carNumber = request.getParameter("carNumber");
  }
  ArrayList<Comment> list = searchComment(carNumber);//url例如sys大众
  System.out.println("carNumber:"+carNumber);
%>

<html>
<head>
    <meta charset="UTF-8">
    <title><%=carname%>评论详情</title>
  <link rel="stylesheet" type="text/css" href="../static/semantic/dist/semantic.min.css">
  <script src="../static/semantic/dist/jquery.min.js"></script>
  <script src="../static/semantic/dist/semantic.js"></script>
</head>
<%@include file="/common/carAdmin.jsp"%>
<body>
<div class="pusher">
  <div class="ui container">
    <%--内容--%>
    <div class="ui list">
      <div class="item">
        <div class="item" style="display: flex; align-items: center;">
          <img class="ui top aligned avatar image" style="width: 120px;height: 90px;"  src=${pageContext.request.contextPath}/displayPhoto?carNumber=<%=carNumber%> >
          <div class="content" style="margin-left: 10px;"> <!-- 添加 margin 控制头像和文本之间的间距 -->
            <div class="header">车辆名：<%=carname%></div>
            <%--      所属者--%>所属者：<%=belong%>
          </div>
        </div>
        <%if (list.isEmpty()){%>
        <div class="ui middle aligned center aligned grid" >
          <div class="column">
            <br>
            <br>
            <br>
            <br>
            <br>
            <h1 class="ui red header">
              哦吼，还没有评论，要不等会再来!!!</h1>
          </div>
        </div>
        <%}else {%>
        <%-- 评论列表--%>
        <div class="content" style="margin-left: 100px;">
          <div class="list">
            <% for (Comment rp : list){%>
            <div class="item">
              <i class="right triangle icon"></i>
              <div class="content">
                <a class="header">
                  <%="用户："+rp.getCustomer()%></a>
                <div class="description">
                  <i class="ui label"><%=rp.getTime()%></i>
                  <%=rp.getText()%></div>
              </div>
            </div>
            <%}%>
          </div>
        </div>
        <%}%>
      </div>
    </div>

  </div>
</div>


</body>
</html>






<%--如果你想在图像无法加载时显示默认的图像，你可以在 <img> 标签中使用 onerror 事件来指定默认图像。例如：--%>
<%--<img src="image.jpg" alt="Description of the image" onerror="this.onerror=null; this.src='default-image.jpg'">--%>