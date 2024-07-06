<%@ page import="com.example.car_rental.entity.Order" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.car_rental.entity.TimeExtension" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/2/22
  Time: 19:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
    TimeExtension renew=null ;
    if(op==2){
//        /**现在获得的只有 房间号 和 续费天数
//         * 需要通过房间号先获得续费订单的订单号,
//         * 通过订单号获得获得房间编号、房间入住和到期时间
//         * 通过房间编号获得房间价格
//         *
//         */
        //查询原订单号
        ArrayList<Order> order = getOrder(map.get("carid")[0]);
        String orderid =order.get(0).getOrderNumber() ;
        //查询员订单截止时间
        Date olddate = order.get(0).getCheckOutTime();
        Date newdate = order.get(0).getCheckOutTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(newdate);
        System.out.println(Integer.parseInt(map.get("time")[0]) );
        calendar.add(5, Integer.parseInt(map.get("time")[0]));
        //算出新截止时间
        newdate = new Date(calendar.getTime().getTime()) ;
        //算出 价格 =单价*折扣*天数 ;
        double discount = searchDiscount(order.get(0).getCustomerIDCard());

        int price = 1  ;
        renew=new TimeExtension(getRenewNum()+1,orderid,olddate,newdate,(int)(discount*Integer.parseInt(map.get("time")[0])
                *getCarPrice(order.get(0).getCarNumber()))) ;
        request.getSession().setAttribute("renew",renew);

    }

%>
<html>
<head>
    <meta charset="UTF-8">
    <title>租车管理系统</title>
    <style type="text/css">
        h2 {
            margin: 1em 0;
        }
        .ui.container {
            padding-top: 5em;
            padding-bottom: 5em;
        }
    </style>
    <script >

        function fun1() {

            alert("续费成功,返回首页!")
            window.location.href="/ServiceManage?op=4";
        }

        function fun2() {

            var carid = document.getElementById("carid").value
            var time = document.getElementById("time").value
            var pat1 = /^[0-9]{6}$/ ;
            var pat2 =/^[1-9][0-9]?$/ ;

            if(pat1.test(carid) && pat2.test(time)){
                window.location.href="/carRenew.jsp?op=2&carmid="+carid+"&time="+time
            }
            return false
        }

    </script>
</head>
<%@include file="../common/carAdmin.jsp"%>
<body>
<div class="pusher">


    <div class="ui container">
        <h2 class="ui header">车辆续费</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op<=1)?"active step ":"completed step"%>" >
                        <i class="building icon"></i>
                        <div class="content">
                            <div class="title">选择车号</div>
                            <%--<div class="description">Choose your shipping options</div>--%>
                        </div>
                    </div>

                    <div class="<%=(op==2)?"active step ":(op==1)?"step":"completed step"%>">
                        <i class="info icon"></i>
                        <div class="content">
                            <div class="title">订单支付</div>
                            <%--<div class="description">Enter billing information</div>--%>
                        </div>
                    </div>

                </div>
            </div>
            <div class="eleven wide  column" >

                <%  if(op==1){ %>
                <form class="ui form">
                    <h4 class="ui dividing header">车型选择</h4>
                    <div class="four wide column">
                        <label>Car</label>


                        <div class="five wide field">


                            <select class="ui fluid search dropdown" id="carid" name="carid">

                                <%
                                    ArrayList<String> list = searchFullCars();
                                    if(list.size()==0){
                                %>
                                <option value="无车可续">无车可续</option>
                                <%
                                }else {
                                    for(String str : list){
                                %>
                                <option value=<%=str%>> <%=str%> </option>
                                <% }
                                } %>
                            </select>
                            <%--<input type="text" name="carid" placeholder="房间号">--%>
                        </div>
                    </div>
                    <h4 class="ui dividing header">续费时间</h4>
                    <div class="eight wide field">
                        <label>Time</label>
                        <div class=" fields">
                            <div class="eight wide field">

                                <input type="text" maxlength="8"  placeholder="time" id="time" name="time">
                            </div>
                        </div>

                    </div>
                    <br/>
                    <%if(list.size()==0){%>
                    <div class="ui right submit floated button" style="pointer-events: none;opacity: 0.5;cursor: not-allowed;" tabindex="0" >Submit Order</div>
                    <%}else {%>
                    <div class="ui right submit floated button" tabindex="0" >Submit Order</div>
                    <%}%>
                </form>
                <% } else if(op==2){ %>


                <h4 class="ui dividing header">订单确认</h4>
                <table class="ui table">
                    <thead>
                    <tr><th class="six wide">Name</th>
                        <th class="ten wide">Info</th>
                    </tr></thead>
                    <tbody>
                    <tr>
                        <td>续费订单编号</td>
                        <td><%=renew.getOperatingID() %></td>
                    </tr>
                    <tr>
                        <td>原订单编号</td>
                        <td><%=renew.getOrderNumber() %></td>
                    </tr>
                    <tr>
                        <td>原到期时间</td>
                        <td><%=renew.getOldExpiryDate() %></td>
                    </tr>
                    <tr>
                        <td>支付金额</td>
                        <td><%=renew.getAddedMoney() %></td>
                    </tr>
                    <tr>
                        <td>现到期时间</td>
                        <td><%=renew.getNewExpiryDate() %></td>
                    </tr>
                    </tbody>
                </table>


                <h4 class="ui dividing header">完成支付</h4>
                <div class="ui right floated labeled button" tabindex="0">
                    <a class="ui basic right pointing label">
                        <%-- 去数据库查询价格 * 天数 *相应的折扣 --%>
                        ¥<%=renew.getAddedMoney() %>
                    </a>
                    <div class="ui right button" onclick="fun1()">
                        <i class="shopping icon"></i> 支付
                    </div>
                </div>
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
                time: {
                    identifier: 'time',
                    rules: [
                        {
                            type: 'regExp[/^[1-9][0-9]?$/]',
                            prompt: '时间不符合规范'
                        }
                    ]
                }
                ,roomid: {
                    identifier: 'carid',
                    rules: [
                        {
                            type: 'regExp[/^[0-9]{6}$/]',
                            prompt: '车辆号不符合规范'
                        }
                    ]
                }

            }, {

                inline : true,
                on     : 'submit',
                onSuccess: function() {
                    fun2();
                }
            }
        )

        ;
    });
</script>
