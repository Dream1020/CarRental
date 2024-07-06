<%@ page import="com.example.car_rental.entity.CarTypeAndPrice" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static com.example.car_rental.tool.Query.getCarsInfo" %>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/3/11
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String belong =session.getAttribute("caradmin").toString();
    ArrayList < CarTypeAndPrice> carinfos = getCarsInfo(belong);
%>
<html>
<head>
    <title>我的车</title>
</head>
<%@include file="merchantadmin.jsp"%>
<body>
<div class="pusher">
    <div class="ui container">
        <div class="ui column grid">
            <div class="sixteen wide column" >
                <div class="ui four cards" style="margin-top: 60px;">
                    <%if (carinfos.size()>0){
                        for (CarTypeAndPrice carinfo :carinfos){ %>
                            <div class="card" >
                                <div class=" fluid image" >
                                    <a class="ui big blue right corner label" >
                                    <%=carinfo.getCarStatus()%>
                                    </a>

                                    <img src=${pageContext.request.contextPath}/displayPhoto?carNumber=<%=carinfo.getCarnumber()%> width="400" height="300">
                                </div>
                                <div class="extra">
                                    carid:<%=carinfo.getCarnumber()%><br>
                                    车型:<%=carinfo.getCarType()%><br>
                                </div>
                            </div>
                        <%}%>
                    <%}else {%>
                    <div class="ui middle aligned center aligned grid">
                        <div class="column">
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <h1 class="ui red header"><i class="folder open icon"></i>我们可以试着将空闲车辆租出来哦!!!</h1>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
