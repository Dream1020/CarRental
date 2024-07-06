<%@ page import="java.util.Map" %>
<%@ page import="com.example.car_rental.entity.*" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/2/22
  Time: 19:08
  To change this template use File | Settings | File Templates.
--%>

<%
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
%>
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
            margin: 1em 0em;
        }
        .ui.container {
            padding-top: 5em;
            padding-bottom: 5em;
        }
    </style>
    <script >
        function returnMainPage() {
            window.location.href="/carManagement/carCheckOut.jsp?op=1";
        }
        function fun() {
            var carid =  document.getElementById("carid").value ;
            var pat1 = /^[0-9]{6}$/ ;

            if( pat1.test(carid) ){
                window.location.href="/carManagement/carCheckOut.jsp?op=2&carid="+carid
            }
            return false ;
        }
    </script>
</head>
<%@include file="../common/carAdmin.jsp"%>
<body>
<div class="pusher">
    <div class="ui container">
        <h2 class="ui header">退车</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op<=1)?"active step ":"completed step"%>" >
                        <i class="building icon"></i>
                        <div class="content">
                            <div class="title">选择车号</div>

                        </div>
                    </div>

                    <div class="<%=(op==2)?"active step ":(op==1)?"step":"completed step"%>">
                        <i class="info icon"></i>
                        <div class="content">
                            <div class="title">订单信息</div>
                            <%--<div class="description">Enter billing information</div>--%>
                        </div>
                    </div>

                </div>
            </div>
            <div class="eleven wide  column" >

                <%  if(op==1){ %>
                <form class="ui form" onsubmit="return fun(this)">
                    <h4 class="ui dividing header">车型选择</h4>
                    <div class="four wide column">
                        <label>Car</label>

                        <div class="five wide field">

                            <select class="ui fluid search dropdown" id="carid">

                                <%
                                    ArrayList<String> list = searchFullCars();
                                    if(list.size()==0){
                                %>
                                <option value="无车可退">无车可退</option>
                                <%
                                    }
                                    for(String str : list){
                                %>
                                <option value=<%=str%>> <%=str%> </option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <br/>
                    <%if(list.size()==0){%>
                    <div class="ui button" tabindex="0" style="pointer-events: none;opacity: 0.5;cursor: not-allowed;">Submit</div>
                    <%}else {%>
                    <div class="ui button submit-button" tabindex="0" >Submit</div>
                    <%}%>
                </form>
                <% }
                else if(op==2){
                    String carid = map.get("carid")[0];
                    System.out.println("carid为："+carid);
                    ArrayList<Order> order = getOrder(carid);
                    System.out.println("order大小为"+order.size());
                %>

                <%--  车辆号 时间  --%>

                <h4 class="ui dividing header">订单信息</h4>
                <table class="ui table">
                    <thead>
                    <tr><th class="six wide">Name</th>
                        <th class="ten wide">Info</th>
                    </tr></thead>
                    <tbody>

                    <tr>

                        <td>订单编号</td>
                        <td><%=order.get(0).getOrderNumber()%></td>

                    </tr>
                    <tr>

                        <td>客户身份证</td>
                        <td><%=order.get(0).getCustomerIDCard()%></td>

                    </tr>
                    <tr>

                        <td>车号</td>
                        <td><%=order.get(0).getCarNumber()%></td>

                    </tr>
                    <tr>

                        <td>订单生成时间</td>
                        <td><%=order.get(0).getOrderTime()%></td>

                    </tr>
                    <tr>

                        <td>租车时间</td>
                        <td><%=order.get(0).getCheckInTime()%></td>

                    </tr>
                    <tr>

                        <td>退车时间</td>
                        <td><%=order.get(0).getCheckOutTime()%></td>

                    </tr>
                    <tr>

                        <td>服务人员编号</td>
                        <td><%=order.get(0).getWaiterID()%></td>

                    </tr>
                    <tr>

                        <td>订单总金额(含续费)</td>
                        <td><%=order.get(0).getTotalMoney()%></td>

                    </tr>
                    <tr>

                        <td>备注</td>
                        <td><%=order.get(0).getAddress()%></td>

                    </tr>
                    </tbody>
                </table>


                <h4 class="ui dividing header">完成退车</h4>

                <div class="ui right button" >
                    <%--<% if(op==2)System.out.println("打印订单编号:"+order.getOrderNumber() );%>--%>

                    <a href="${pageContext.request.contextPath}/ServiceManage?op=5&orderNumber=<%=order.get(0).getOrderNumber()%>">确认退车</a>
                </div>
                <%}else if (op == 3) {
                    String orderNumber= map.get("orderNumber")[0] ;
                    System.out.println("订单:"+orderNumber);
                    checkOutCar(orderNumber); ;
                %>
                <h4 class="ui dividing header">退车成功</h4>
                <div class="ui right button" onclick="returnMainPage()">返回</div>
                <%}%>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $(document).ready(function () {
        $('.ui.form').form({

            inline : true,
            on     : 'submit',
            onSuccess: function() {
                // 验证通过，可以进入下一步
                // 进入下一步的逻辑代码
                fun();
            }
        });
        $('.submit-button').on('click', function () {
            $('.ui.form').form('validate form');
            if ($('.ui.form').form('is valid')) {
                // 验证通过，可以进入下一步
                // 进入下一步的逻辑代码
            } else {
                // 验证不通过，阻止进入下一步
                // alert('表单验证未通过，请检查输入信息');
                return false;
            }
        });
    });
</script>