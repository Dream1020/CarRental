<%@ page import="com.example.car_rental.entity.Comment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
  Date currentDate = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  System.out.println("carNumber:"+carNumber);
%>

<html>
<head>
  <meta charset="UTF-8">
  <title>评论详情</title>
</head>
<%@include file="customerAdmin.jsp"%>
<body>

<div class="pusher">
  <%--返回上一页--%>
  <a href="javascript:history.back()" class="ui button" style=";top:50%;position: fixed;z-index:100;">
    <i class="reply icon"></i>
    <i>返回上一页</i>
  </a>
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
              哦吼，还没有评论，来做第一个评论者吧!!!</h1>
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

<%--   写评论--%>
<div class="pusher">
  <div class="ui container">
    <form class="ui form" style="position: fixed;bottom: 20px; width:70%;margin: 0 auto;z-index: 1000;">
      <div class="field">
        <textarea id="comment-text" name="comment-text" placeholder="在此输入您的评论" rows="4"></textarea>
      </div>
      <div class="field" style="text-align: center;">
        <div class="ui button" onclick="subto()">提交评论</div>
      </div>
    </form>
  </div>
</div>
<%
  if (op==3){

    String customer=session.getAttribute("caradmin").toString();
    String time = sdf.format(currentDate);
    String text = request.getParameter("text");

    Comment comment = new Comment();
    comment.setCarNumber(carNumber);
    comment.setCarname(carname);
    comment.setBelong(belong);
    comment.setCustomer(customer);
    comment.setTime(time);
    comment.setText(text);
    insertComment(comment);
%>
<script>
  alert("评论添加成功");
  var url = window.location.href.split("&")[1]+"&"+
          window.location.href.split("&")[2]+"&"+
          window.location.href.split("&")[3];
  window.location.href="./tocomment.jsp?op=1&"+url;
</script>
<%}%>

</body>
</html>
<script>
  function subto() {
    var commentText = document.getElementById("comment-text").value;
    var url = window.location.href.split("&")[1]+"&"+
            window.location.href.split("&")[2]+"&"+
            window.location.href.split("&")[3]+"&text="+commentText;
    window.location.href="./tocomment.jsp?op=3&"+url;
  }

  function submitForm() {
    document.querySelector("form").submit();
  }

</script>


<%--如果你想在图像无法加载时显示默认的图像，你可以在 <img> 标签中使用 onerror 事件来指定默认图像。例如：--%>
<%--<img src="image.jpg" alt="Description of the image" onerror="this.onerror=null; this.src='default-image.jpg'">--%>