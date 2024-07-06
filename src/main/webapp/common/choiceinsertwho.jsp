<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/3/14
  Time: 18:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>选择注册的身份类型</title>
</head>
<%@include file="carAdmincopy.jsp" %>
<body>
<div class="pusher">
  <div class="ui container" style="margin-top: 20px;">
    <h2 class="ui header">(｡･∀･)ﾉﾞ欢迎你的注册哦</h2>
    <div class="ui column grid">
      <div class="five wide column">
        <div class="ui vertical steps">
          <div class="active step " >
            <i class="add circle icon"></i>
            <div class="content">
              <div class="title">选择你的注册类型</div>
            </div>
          </div>
        </div>
      </div>
      <div class="eight wide column">
        <div class="ui divided items">
          <div class="item">

            <div class="content">
              <a class="header">顾客</a>

              <div class="description">
                <p>可以进行租车操作</p>
              </div>

              <div class="extra">
                <div class="ui right floated  button">
                  <a href="../customerorder/InsertOneCustomer.jsp?choice=2">以顾客身份注册</a>
                  <i class="right chevron icon"></i>
                </div>

              </div>
            </div>
          </div>
          <div class="item">
            <div class="content">
              <a class="header">租车商户</a>

              <div class="description">
                <p>可以将自己的空闲车辆租出来哦</p>
              </div>

              <div class="extra">
                <div class="ui right floated  button">
                  <a href="../merchant/InsertOneBusiness.jsp?choice=2">以租车商身份注册</a>
                  <i class="right chevron icon"></i>
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>
