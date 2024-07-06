<%@ page import="com.example.car_rental.entity.Customer" %>
<%@ page import="com.example.car_rental.tool.Query" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/3/1
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String[]> map = request.getParameterMap();
    int choice = Integer.parseInt(map.get("choice")[0]);
    System.out.println("choice:" + choice);
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
    <script>
        function returnIndex() {
            alert("账号是你的手机号，密码是啥呢？密码你自己设置的，我就不晓得咯，哈哈哈哈哈");
            window.location.href = "../userindex.jsp";
        }

        function returnPage() {
            var urlNew = window.location.href.split("&")[1] + "&" + window.location.href.split("&")[2]
                + "&" + window.location.href.split("&")[3] + "&" + window.location.href.split("&")[4]
                + "&" + window.location.href.split("&")[5] + "&" + window.location.href.split("&")[6];
            window.location.href = "InsertOneCustomer.jsp?choice=2&" + urlNew
        }

        function submintNewinfo() {
            var idcard = document.getElementById("idcard").value;
            var password = document.getElementById("password").value;
            var gender = document.getElementById("gender").value;
            var name = document.getElementById("name").value;
            var birthday = document.getElementById("birthday").value;
            var phonenumber = document.getElementById("phonenumber").value;
            var address = document.getElementById("address").value;

            var url = "&idcard=" + encodeURIComponent(idcard) +
                "&gender=" + encodeURIComponent(gender) +
                "&name=" + encodeURIComponent(name) +
                "&birthday=" + encodeURIComponent(birthday) +
                "&phonenumber=" + encodeURIComponent(phonenumber) +
                "&address=" + encodeURIComponent(address) +
                "&password=" + encodeURIComponent(password);

            window.location.href = "./InsertOneCustomer.jsp?choice=3" + url;
            return false;
        }

        function ensureButtonClicked() {
            var urlNew = window.location.href.split("&")[1] + "&" + window.location.href.split("&")[2]
                + "&" + window.location.href.split("&")[3] + "&" + window.location.href.split("&")[4]
                + "&" + window.location.href.split("&")[5] + "&" + window.location.href.split("&")[6]
                + "&" + window.location.href.split("&")[7];
            window.location.href = "InsertOneCustomer.jsp?choice=4&" + urlNew

        }

    </script>
</head>
<%@include file="../common/carAdmincopy.jsp" %>
<body>

<div class="pusher">
    <div class="ui container" style="margin-top: 20px;">
        <h2 class="ui header">顾客注册</h2>
        <div class="ui column grid">

            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(choice == 2) ? "active step ":"completed step"%>">
                        <i class="add circle icon"></i>
                        <div class="content">
                            <div class="title">新增信息</div>
                        </div>
                    </div>

                    <div class="<%=(choice == 3) ? "active step ":(choice== 2)?"step":"completed step"%>">
                        <i class="check circle icon"></i>
                        <div class="content">
                            <div class="title">信息确认</div>
                        </div>
                    </div>

                </div>

            </div>

            <div class="eleven wide column">

                <%
                    //添加新增信息
                    if (choice == 2) {
                %>

                <form class="ui form" onsubmit="return submintNewinfo(this)">
                    <h2 class="ui dividing header">亲爱的顾客，请填写你的信息哦ヾ(•ω•`)o</h2>
                    <div class="eleven fields" style="display: flex;flex-direction: column;margin-top: 20px;">
                        <div class="field">
                            <label>身份证号</label>
                            <%if (request.getParameter("idcard") != null) {%>
                            <input type="text" id="idcard" name="idcard" value="<%=request.getParameter("idcard")%>"
                                   placeholder="身份证信息">
                            <%} else {%>
                            <input type="text" id="idcard" name="idcard" placeholder="身份证信息">
                            <%}%>
                        </div>

                        <div class="field">
                            <label>性别</label>
                            <select class="ui fluid dropdown" id="gender" name="gender">
                                <option value="">请选择性别</option>
                                <option value="男">男</option>
                                <option value="女">女</option>

                            </select>
                        </div>

                        <div class="field">
                            <label>姓名</label>
                            <%if (request.getParameter("name") != null) {%>
                            <input type="text" id="name" name="name" value="<%=request.getParameter("name")%>"
                                   placeholder="姓名">
                            <%} else {%>
                            <input type="text" id="name" name="name" placeholder="姓名">
                            <%}%>
                        </div>

                        <div class="field">
                            <label>生日</label>
                            <%if (request.getParameter("birthday") != null) {%>
                            <input type="date" id="birthday" name="birthday"
                                   value="<%=request.getParameter("birthday")%>" placeholder="生日">
                            <%} else {%>
                            <input type="date" id="birthday" name="birthday" placeholder="生日">
                            <%}%>
                        </div>

                        <div class="field">
                            <label>手机号</label>
                            <%if (request.getParameter("phonenumber") != null) {%>
                            <input type="text" id="phonenumber" name="phonenumber"
                                   value="<%=request.getParameter("phonenumber")%>" placeholder="手机号">
                            <%} else {%>
                            <input type="text" id="phonenumber" name="phonenumber" placeholder="手机号">
                            <%}%>
                        </div>

                        <div class="field">
                            <label>密码</label>
                            <input type="text" id="password" name="password" placeholder="密码">
                        </div>

                        <div class="field">
                            <label>地址</label>
                            <%if (request.getParameter("address") != null) {%>
                            <input type="text" id="address" name="address" value="<%=request.getParameter("address")%>"
                                   placeholder="默认送车上门地址信息">
                            <%} else {%>
                            <input type="text" id="address" name="address" placeholder="默认送车上门地址信息">
                            <%}%>
                        </div>

                    </div>
                    <div class="ui submit button">提交</div>
                </form>

                <%
                } else if (choice == 3) {
                %>

                <h2 class="ui dividing header">待添加信息确认</h2>
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
                            <label>密码</label>
                            <input type="text" value="******" readonly>
                        </div>

                        <div class="field">
                            <label>地址</label>
                            <input type="text" value="<%=request.getParameter("address")%>" readonly>
                        </div>

                    </div>

                    <div class="eleven fields" style="margin-top: 20px;">
                        <div class="field">
                            <div class="ui button" onclick="returnPage()">返回</div>
                        </div>
                        <div class="field">
                            <div class="ui button" onclick="ensureButtonClicked()">确认</div>
                        </div>
                    </div>
                </form>

                <%
                } else if (choice == 4) {
                    //插入顾客信息
                    Customer newCustomer = new Customer();
                    newCustomer.setCustomerIDCard(request.getParameter("idcard"));
                    newCustomer.setCustomerpassword(request.getParameter("password"));
                    newCustomer.setCustomerGender(request.getParameter("gender"));
                    newCustomer.setCustomerName(request.getParameter("name"));
                    newCustomer.setCustomerBirthday(Date.valueOf(request.getParameter("birthday")));
                    newCustomer.setCustomerVIPLevel(0);
                    newCustomer.setCustomerPhoneNumber(request.getParameter("phonenumber"));
                    newCustomer.setTotalAmount(0);
                    newCustomer.setRemarks("");
                    newCustomer.setAddress(request.getParameter("address"));
                    Query.InsertCustomer(newCustomer);


                %>
                <h2 class="ui dividing header" style="display: flex;flex-direction: column;margin-top: 20px;">
                    添加成功</h2>
                <botton class="ui right button" onclick="returnIndex(this)">返回</botton>

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
                idcard: {
                    identifier: 'idcard',
                    rules: [
                        {
                            type: 'regExp',
                            value: /^\d{17}[0-9Xx]$/,
                            prompt: '身份证号不符合规范'
                        }
                    ]
                },
                gender: {
                    identifier: 'gender',
                    rules: [
                        {
                            type: 'regExp',
                            value: /^(男|女)$/,
                            prompt: '请选择性别'
                        }
                    ]
                },
                birthday: {
                    identifier: 'birthday',
                    rules: [
                        {
                            type: 'regExp',
                            value: /^\d{4}-\d{2}-\d{2}$/,
                            prompt: '出生日期格式不正确，应为xxxx-xx-xx'
                        }
                    ]
                },
                phonenumber: {
                    identifier: 'phonenumber',
                    rules: [
                        {
                            type: 'regExp',
                            value: /^1[3-9]\d{9}$/,
                            prompt: '手机号码错误'
                        }
                    ]
                }


            }, {

                inline: true,
                on: 'submit'

            }
        );

        $('.submit.button').on('click', function () {
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