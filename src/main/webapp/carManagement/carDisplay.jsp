<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.car_rental.entity.*" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %>
<%@ page import="com.example.car_rental.tool.Query" %>
<%@ page import="com.example.car_rental.display.OrderView" %>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/2/24
  Time: 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String rs1[] = {"空","非空","任意"}  ;
  Map<String, String[]> map =request.getParameterMap() ;


  String size1=""  ;
  if( map.get("size1")!=null ){
    size1 = map.get("size1")[0] ;
  }

  String search ="" ;
  if(map.get("search")!=null){
    search =map.get("search")[0]  ;
  }

  String search1 ="" ;
  if(map.get("search1")!=null){
    search1 =map.get("search1")[0]  ;
  }
  ArrayList<CarTypeAndPrice> allCarsInfo = getAllCarsInfo(size1,search,search1);

%>
<html>
<head>
  <meta charset="UTF-8">
  <title>租车管理系统</title>
  <style type="text/css">
    h2 {
      margin: 1em 0em;
    }
    .ui.container {
      padding-top: 5em;
      padding-bottom: 5em;
    }
  </style>
  <script>
    function fun() {
      var obj = document.getElementsByName("size1");//选择所有name="id"的对象，返回数组
      var v='';//如果这样定义var v;变量v中会默认被赋个null值
      for(var i=0;i<obj.length;i++){
        if(obj[i].checked) {//取到对象数组后，我们来循环检测它是不是被选中
          v+=('size1='+obj[i].value);
        }  //如果选中，将value添加到变量v中
      }
      window.location.href='./carDisplay.jsp?'+v
    }
    function fun1() {
      const carid = document.getElementById('carid').value;
      window.location.href='./carDisplay.jsp?search='+carid;
    }
    function fun2() {
      const cartype = document.getElementById('cartype').value;
      window.location.href='./carDisplay.jsp?search1='+cartype;
    }
  </script>
</head>
<%@include file="../common/carAdmin.jsp"%>
<body>
<div class="pusher">
  <div class="ui container">
    <div class="ui column grid">
      <div class="four wide column">
        <div style="position: fixed;z-index: 100">
          <h2 class="ui header">车辆概览</h2>
            <div class="ui vertical  menu">
              <div class="item">
                <a class="active title">
                  <i class="dropdown icon"></i>
                  状态
                </a>
                <div class="active content">
                  <div class="ui form">
                    <div class="grouped fields">
                      <%for (String s : rs1){%>
                      <div class="field">
                        <div class="ui radio checkbox">
                          <input type="radio" name="size1" value=<%=s%>  <%=s.equals(size1)?"checked":""%> onclick="fun()">
                          <label><%=s%></label>
                        </div>
                      </div>
                      <%}%>
                    </div>
                  </div>
                </div>
              </div>
            </div>
        </div>
      </div>
      <div class="twelve wide column" >
        <div class="ui two searchs" style="position: fixed; z-index: 100; display: flex;">
          <div class="ui search" style="margin-right: 20px;"> <!-- 添加右边距 -->
            <div class="ui icon input">
              <input class="prompt" type="text" id="carid" <% if(!search.equals("")){ %>
                     value=<%=search%>
                       <% }%> placeholder="查找车辆号">
            </div>
            <div class="ui button" onclick="fun1()"><i class="search icon"></i>车辆号检索</div>
          </div>
          <div class="ui search">
            <div class="ui icon input">
              <input class="prompt" type="text" id="cartype" <% if(!search1.equals("")){ %>
                     value=<%=search1%>
                             <% }%> placeholder="查找车辆类型">
            </div>
            <div class="ui button" onclick="fun2()"><i class="search icon"></i>车辆类型检索</div>
          </div>
        </div>
        <%if (allCarsInfo.size() == 0) {%>
        <div class="ui middle aligned center aligned grid" >
            <div class="column">
              <br>
              <br>
              <br>
              <br>
              <br>
              <h1 class="ui red header">
                哦吼，竟然没找到，继续!!!</h1>
            </div>
          </div>
        <%} else {%>
        <div class="ui three cards" style="margin-top: 60px;">
          <% for (CarTypeAndPrice carinfo : allCarsInfo) {
            String type = carinfo.getCarType();
            String carname = carinfo.getCarType();
            String belong = carinfo.getBelong();
          %>

          <div class="card"
               onclick="window.location.href='./commentmanagement.jsp?op=1&carNumber=<%=carinfo.getCarnumber()%>&carname=<%=carname%>&belong=<%=belong%>' ">
            <div class=" fluid image">
              <a class="ui big blue right corner label">
                <%=carinfo.getCarStatus()%>
              </a>

              <img src=/displayPhoto?carNumber=<%=carinfo.getCarnumber()%> width="400"
                   height="300">

            </div>
            <div class="extra">
              carid:<%=carinfo.getCarnumber()%><br>
              车型:<%=carinfo.getCarType()%><br>
              所属者:<%=carinfo.getBelong()%><br>
              <% if (carinfo.getCarStatus().equals("非空")) {
                OrderView view = Query.getFullOrderViews(carinfo.getCarnumber());
              %>
              <%if (view != null) {%>
              租车用户:<%=view.getCustomer()%><br>
              到期时间:<%=view.getCheckOutTime()%><br>
              <%} else {%>
              租车用户:------<br>
              到期时间:------<br>
              <%}%>
              <%}%>
            </div>
          </div>
          <%}%>
          <%}%>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
