<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.car_rental.entity.Business" %>
<%@ page import="static com.example.car_rental.tool.Query.searchonebusiness" %>
<%@ page import="static com.example.car_rental.tool.Query.renewbusinessinfo" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %><%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/3/13
  Time: 21:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  int op = Integer.parseInt(request.getParameter("op"));
  ArrayList<Business> list = searchonebusiness(session.getAttribute("caradmin").toString());
%>
<html>
<head>
    <title>我的信息</title>
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/semantic.min.css">
</head>
<%@include file="merchantadmin.jsp"%>
<body>

<div class="pusher">
  <div class="ui container">
    <div class="ui column grid">

      <div class="two wide column">
        <h1>用户信息</h1>
        <div class="ui secondary vertical menu" style="width: 150px;">
          <a class="item account-link" data-target="account-info" href="myinfo.jsp?op=1">账号基本信息</a>

          <div class="ui dropdown item">
            <i class="dropdown icon" ></i>修改账户信息
            <div class="menu">
              <div class="header">修改类型</div>
              <a class="item" href="myinfo.jsp?op=2"><i class="setting icon"></i>修改基本信息</a>
              <a class="item" href="myinfo.jsp?op=5"><i class="settings icon"></i>修改账户密码</a>
            </div>
          </div>

        </div>
      </div>

      <div class="two wide column">
      </div>
      <% if (op == 1){%>
      <div class="eleven wide column">
        <div style="margin-top: 40px;"></div>
        <h2>账户信息</h2>
        <form class="ui form">
          <div class="eleven fields" style="display: flex;flex-direction: column;margin-top: 20px;">

            <% for (Business rp : list){%>
            <div class="field">
              <label>手机号</label>
              <input type="tel" value="<%=rp.getBusinessid()%>" readonly>
            </div>

            <div class="field">
              <label>身份证号</label>
              <input type="text" value="<%=rp.getBusinessidcard()%>" readonly>
            </div>

            <div class="field">
              <label>生日</label>
              <input type="date" value="<%=rp.getBirthday()%>" readonly>
            </div>

            <div class="field">
              <label>姓名</label>
              <input type="text" value="<%=rp.getBusinessname()%>" readonly>
            </div>

            <div class="field">
              <label>性别</label>
              <input type="text" value="<%=rp.getGender()%>" readonly>
            </div>


            <%}%>
          </div>
        </form>
      </div>
      <%} else if (op==2) {%>
      <div class="eleven wide column">
        <div style="margin-top: 40px;"></div>
        <h2>修改基本信息</h2>
        <form class="ui form" onsubmit="return submitcustomerinf(this)">
          <div class="eleven fields" style="display: flex;flex-direction: column;margin-top: 20px;">
            <%
              for (Business rp : list){%>
            <div class="field">
              <label>手机号</label>
              <input type="tel" id="id" name="id" value="<%=rp.getBusinessid()%>" >
            </div>

            <div class="field">
              <label>身份证号</label>
              <input type="text" id="idcard" name="idcard" value="<%=rp.getBusinessidcard()%>" readonly>
            </div>
            <div class="field">
              <label>生日</label>
              <input type="date" id="birthday" name="birthday" value="<%=rp.getBirthday()%>" >
            </div>
            <div class="field">
              <label>姓名</label>
              <input type="text" id="name" name="name" value="<%=rp.getBusinessname()%>" >
            </div>
            <div class="field">
              <label>性别</label>
              <select class="ui fluid dropdown" id="gender" name="gender">
                <%if (rp.getGender().equals("男")){%>
                <option value="男">男</option>
                <option value="女">女</option>
                <%}else{%>
                <option value="女">女</option>
                <option value="男">男</option>
                <%}%>
              </select>
            </div>

            <%}%>

          </div>
          <div class="ui button" onclick="returnPage()">返回</div>
          <button class="ui submit button">提交</button>

        </form>

      </div>
      <%} else if (op==3) {%>
      <div class="eleven wide column">
        <div style="margin-top: 40px;"></div>
        <h2>确定信息</h2>
        <form class="ui form">
          <div class="eleven fields" style="display: flex;flex-direction: column;margin-top: 20px;">

            <div class="field">
              <label>手机号</label>
              <input type="tel" value="<%=request.getParameter("id")%>" readonly>
            </div>
            <div class="field">
              <label>身份证号</label>
              <input type="text" value="<%=request.getParameter("idcard")%>" readonly>
            </div>
            <div class="field">
              <label>生日</label>
              <input type="date" value="<%=request.getParameter("birthday")%>" readonly>
            </div>
            <div class="field">
              <label>姓名</label>
              <input type="text" value="<%=request.getParameter("name")%>" readonly>
            </div>
            <div class="field">
              <label>性别</label>
              <input type="text" value="<%=request.getParameter("gender")%>" readonly>
            </div>
          </div>

          <div class="eleven fields" style="margin-top: 20px;">
            <div class="field">
              <div class="ui button" onclick="returnPage()">返回</div>
            </div>
            <div class="field">
              <div class="ui button" onclick="ensureinfo()">确认</div>
            </div>
          </div>
        </form>

      </div>
      <%} else if (op==4) {
        String id = request.getParameter("id");
        String idcard = request.getParameter("idcard");
        String bir = request.getParameter("birthday");
        String name = request.getParameter("name");
        String gen = request.getParameter("gender");

        session.setAttribute( "caradmin",id);

        renewbusinessinfo(id,idcard,bir,name,gen);
      %>
      <div class="eleven wide column">
        <div style="margin-top: 40px;"></div>
        <h2>修改基本信息</h2>

        <h2 class="ui dividing header" style="display: flex;flex-direction: column;margin-top: 20px;"></h2>
        <script>
          alert("信息修改成功了哦(●'◡'●)");
        </script>
        <botton class="ui right button" onclick="returnPage()">返回</botton>

      </div>
      <%} else if (op==5) {%>
      <div class="eleven wide column">
        <div style="margin-top: 40px;"></div>
        <h2>修改账户密码信息</h2>
        <form class="ui form">
          <div class="eleven fields" style="display: flex;flex-direction: column;margin-top: 20px;">
            <div class="field">
              <label>身份证号</label>
              <input type="text" id = "idcard1" name="idcard1" value="" placeholder="身份证号">
            </div>
            <div class="field">
              <label>旧密码</label>
              <input type="text" id="oldpassword" name="oldpassword" value="" placeholder="旧密码">
            </div>
            <div class="field">
              <label>新密码</label>
              <input type="text" id="newpassword" name="newpassword" value="" placeholder="新密码">
            </div>
          </div>
          <div class="eleven fields" style="margin-top: 20px;">
            <div class="field">
              <div class="ui button" onclick="returnPage()">返回</div>
            </div>
            <div class="field">
              <button class="ui button" onclick="return ensurepassinfo(this)">确认</button>
            </div>
          </div>
        </form>


      </div>
      <%} else if (op==6){
        String id = request.getParameter("idcard1");
        String oldpassword = request.getParameter("oldpassword");
        String newpassword = request.getParameter("newpassword");

        if(renewbusinesspassword(id, oldpassword, newpassword)){ %>
      <script>
        alert("恭喜嘞，密码修改好了，别又忘记你的密码了哦( •̀ ω •́ )✧");
        window.location.href="../userindex.jsp";
      </script>
      <%} else {%>
      <script>
        alert("真的可怜，密码没修改好，太遗憾了＞︿＜");
        window.location.href="myinfo.jsp?op=5";
      </script>
      <%}%>
      <%}%>

    </div>
  </div>
</div>

<script>
  $('.ui.dropdown').dropdown();

  function submitcustomerinf(){
    var id = document.getElementById("id").value;
    var idcard = document.getElementById("idcard").value;
    var birthday = document.getElementById("birthday").value;
    var name = document.getElementById("name").value;
    var gender = document.getElementById("gender").value;

    var url = "&id="+id+ "&idcard="+idcard+ "&birthday="+birthday+
            "&name="+ name+"&gender="+gender;
    window.location.href="myinfo.jsp?op=3"+url;
    return false;
  }

  function returnPage() {
    window.location.href="myinfo.jsp?op=1"
  }

  function ensureinfo() {
    var urlNew = window.location.href.split("&")[1] + "&" + window.location.href.split("&")[2]
            + "&" + window.location.href.split("&")[3]+ "&" + window.location.href.split("&")[4]
            + "&" + window.location.href.split("&")[5];
    window.location.href = "myinfo.jsp?op=4&"+urlNew
  }

  function ensurepassinfo() {
    var idcard1 = document.getElementById("idcard1").value;
    var oldpassword = document.getElementById("oldpassword").value;
    var newpassword = document.getElementById("newpassword").value;
    var url = "&idcard1="+idcard1+"&oldpassword="+oldpassword+"&newpassword="+newpassword;
    window.location.href = "myinfo.jsp?op=6"+url;
    return false;
  }


</script>

</body>
</html>
