<%@ page import="com.example.car_rental.entity.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static com.example.car_rental.tool.Query.searchonecustomer" %>
<%@ page import="static com.example.car_rental.tool.Query.renewcustomerinfo"%>
<%@ page import="static com.example.car_rental.tool.Query.renewcustomerpassword"%>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/3/5
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int op = Integer.parseInt(request.getParameter("op"));
    ArrayList<Customer> list = searchonecustomer(session.getAttribute("caradmin").toString());
%>
<html>
<head>
    <title>我的信息</title>
</head>
<%@include file="customerAdmin.jsp"%>
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

                    <div class="ui dropdown item">
                        <i class="dropdown icon" ></i>我的订单
                        <div class="menu">
                            <div class="header">订单类型</div>
                            <a class="item" href="allorder.jsp?op=1&pageIndex=1">
                                <i class="history icon"></i>
                                历史订单</a>
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

                        <% for (Customer rp : list){%>
                        <div class="field">
                            <label>身份证号</label>
                            <input type="text" value="<%=rp.getCustomerIDCard()%>" readonly>
                        </div>
                        <div class="field">
                            <label>性别</label>
                            <input type="text" value="<%=rp.getCustomerGender()%>" readonly>
                        </div>

                        <div class="field">
                            <label>姓名</label>
                            <input type="text" value="<%=rp.getCustomerName()%>" readonly>
                        </div>

                        <div class="field">
                            <label>生日</label>
                            <input type="text" value="<%=rp.getCustomerBirthday()%>" readonly>
                        </div>

                        <div class="field">
                            <label>手机号</label>
                            <input type="text" value="<%=rp.getCustomerPhoneNumber()%>" readonly>
                        </div>

                        <div class="field">
                            <label>总花费</label>
                            <input type="text" value="<%=rp.getTotalAmount()%>" readonly>
                        </div>

                        <div class="field">
                            <label>地址</label>
                            <input type="text" value="<%=rp.getAddress()%>" readonly>
                        </div>

                        <div class="field">
                            <label>备注</label>
                            <%if (rp.getRemarks()==null){%>
                            <input type="text" value="无备注信息" readonly>
                            <%}else{%>
                            <input type="text" value="<%=rp.getRemarks()%>" readonly>
                            <%}%>
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
                            for (Customer rp : list){%>
                        <div class="field">
                            <label>身份证号</label>
                            <input type="text" id="idcard" name="idcard" value="<%=rp.getCustomerIDCard()%>" readonly>
                        </div>
                        <div class="field">
                            <label>性别</label>
                            <select class="ui fluid dropdown" id="gender" name="gender">
                                <%if (rp.getCustomerGender().equals("男")){%>
                                <option value="男">男</option>
                                <option value="女">女</option>
                                <%}else{%>
                                <option value="女">女</option>
                                <option value="男">男</option>
                                <%}%>
                            </select>
                        </div>

                        <div class="field">
                            <label>姓名</label>
                            <input type="text" id="name" name="name" value="<%=rp.getCustomerName()%>" >
                        </div>

                        <div class="field">
                            <label>生日</label>
                            <input type="text" id="birthday" name="birthday" value="<%=rp.getCustomerBirthday()%>" >
                        </div>

                        <div class="field">
                            <label>手机号</label>
                            <input type="text" id="phonenumber" name="phonenumber" value="<%=rp.getCustomerPhoneNumber()%>" >
                        </div>

                        <div class="field">
                            <label>地址</label>
                            <input type="text" id="address" name="address" value="<%=rp.getAddress()%>" >
                        </div>

                        <div class="field">
                            <label>备注</label>
                            <input type="text" id="other" name="other" value="<%=rp.getRemarks()%>" >
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
                            <label>身份证号</label>
                            <input type="text" value="<%=request.getParameter("idcard")%>" readonly>
                        </div>

                        <div class="field">
                            <label>性别</label>
                            <input type="text" value="<%=request.getParameter("gender")%>" readonly>
                        </div>

                        <div class="field">
                            <label>姓名</label>
                            <input type="text" value="<%=request.getParameter("name")%>" readonly>
                        </div>

                        <div class="field">
                            <label>生日</label>
                            <input type="text" value="<%=request.getParameter("birthday")%>" readonly>
                        </div>

                        <div class="field">
                            <label>手机号</label>
                            <input type="text" value="<%=request.getParameter("phonenumber")%>" readonly>
                        </div>

                        <div class="field">
                            <label>地址</label>
                            <input type="text" value="<%=request.getParameter("address")%>" readonly>
                        </div>

                        <div class="field">
                            <label>备注</label>
                            <input type="text" value="<%=request.getParameter("other")%>" readonly>
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
                String id = request.getParameter("idcard");
                String gen = request.getParameter("gender");
                String name = request.getParameter("name");
                String bir = request.getParameter("birthday");
                String ph = request.getParameter("phonenumber");
                String ad = request.getParameter("address");
                String other = request.getParameter("other");
                renewcustomerinfo(id,gen,name,bir,ph,ad,other);
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

                if(renewcustomerpassword(id, oldpassword, newpassword)){ %>
                    <script>
                        alert("恭喜嘞，密码修改好了，别又忘记你的密码了哦( •̀ ω •́ )✧");
                        window.location.href="myinfo.jsp?op=1";
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
        var idcard = document.getElementById("idcard").value;
        var gender = document.getElementById("gender").value;
        var name = document.getElementById("name").value;
        var birthday = document.getElementById("birthday").value;
        var phonenumber = document.getElementById("phonenumber").value;
        var address = document.getElementById("address").value;
        var other = document.getElementById("other").value;
        var url = "&idcard="+idcard+ "&gender="+gender+
            "&name="+name+ "&birthday="+birthday+
            "&phonenumber="+phonenumber+ "&address="+address+
            "&other="+other;
        window.location.href="myinfo.jsp?op=3"+url;
        return false;
    }

    function returnPage() {
        window.location.href="myinfo.jsp?op=1"
    }

    function ensureinfo() {
        var urlNew = window.location.href.split("&")[1] + "&" + window.location.href.split("&")[2]
            + "&" + window.location.href.split("&")[3]+ "&" + window.location.href.split("&")[4]
            + "&" + window.location.href.split("&")[5]+ "&" + window.location.href.split("&")[6]
            + "&" + window.location.href.split("&")[7];
        window.location.href = "myinfo.jsp?op=4&"+urlNew
    }

    function ensurepassinfo() {
        var idcard1 = document.getElementById("idcard1").value;
        var oldpassword = document.getElementById("oldpassword").value;
        var newpassword = document.getElementById("newpassword").value;
        var url = "&idcard1="+idcard1+"&oldpassword="+oldpassword+"&newpassword="+newpassword;
        window.location.href = "myinfo.jsp?"+"op=6"+url;
        return false;
    }


</script>

</body>
</html>
