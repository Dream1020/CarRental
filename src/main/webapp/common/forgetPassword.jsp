<%@ page import="java.util.Map" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %><%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/3/26
  Time: 19:55
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
    <title>修改密码</title>
    <script>
        function subpass1(){

            var idcard = document.getElementById("idcard").value;
            var phonenumber = document.getElementById("phonenumber").value;
            var password = document.getElementById("password").value;
            var url = "&idcard="+idcard+"&phonenumber="+phonenumber+"&password="+password;
            window.location.href="forgetPassword.jsp?choice=4"+url;
        }
    </script>
</head>
<%@include file="carAdmincopy.jsp" %>
<body>
<div class="pusher">
    <div class="ui container" style="margin-top: 20px;">
        <h2 class="ui header">太难了，怎么就忘记了密码呢</h2>
        <div class="ui column grid">
            <div class="five wide column">
                <div class="ui vertical steps">

                    <div class="<%=(choice == 1) ? "active step ":"completed step"%>" >
                        <i class="exchange circle icon"></i>
                        <div class="content">
                            <div class="title">选择你的身份类型</div>
                        </div>
                    </div>
                    <div class="<%=(choice == 2||choice == 3) ? "active step ":(choice== 1)?"step":"completed step"%>">
                        <i class="check circle icon"></i>
                        <div class="content">
                            <div class="title">填写密码</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="eight wide column">
                <%
                    if (choice==1){
                %>
                <div class="ui divided items">
                    <div class="item">
                        <div class="content">
                            <a class="header">顾客</a>
                            <div class="description">
                                <p>太糟糕了，我的忘记了我顾客身份的密码</p>
                            </div>
                            <div class="extra">
                                <div class="ui right floated  button">
                                    <a href="forgetPassword.jsp?choice=2">去修改</a>
                                    <i class="right chevron icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="content">
                            <a class="header">租车商户</a>

                            <div class="description">
                                <p>太糟糕了，我想修改我租车商身份的密码</p>
                            </div>

                            <div class="extra">
                                <div class="ui right floated  button">
                                    <a href="forgetPassword.jsp?choice=3">去修改</a>
                                    <i class="right chevron icon"></i>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <%}else if(choice == 2||choice == 3 ) {
                        session.setAttribute("op",choice);
                %>     <%-- 顾客密码   --%>
                <form class="ui form">
                    <h2 class="ui dividing header">亲爱的<%= choice == 2 ? "顾客" : "租车商" %>，填写完整信息修改密码哦</h2>
                    <div class="eight field" style="display: flex;flex-direction: column;margin-top: 20px;">
                        <div class="field">
                            <label for="idcard">身份证号</label>
                            <input type="text" id="idcard" name="idcard" placeholder="请输入你的身份证信息">
                        </div>
                        <div class="field">
                            <label for="phonenumber">手机号</label>
                            <input type="text" id="phonenumber" name="phonenumber" placeholder="请输入你的手机号">
                        </div>
                        <div class="field">
                            <label for="password">密码</label>
                            <input type="text" id="password" name="password" placeholder="请输入你要修改的密码">
                        </div>
                    </div>
                    <div class="ui button" onclick="subpass1()">提交</div>
                </form>

                <%} else if (choice == 4) {
                    String id = request.getParameter("idcard");
                    String ph = request.getParameter("phonenumber");
                    String ps = request.getParameter("password");
                    String op = session.getAttribute("op").toString();
                    boolean sure = false;
                    if (op.equals("2")){//顾客
                        sure = forgetcustomerpassword(id,ph,ps);
                    } else if (op.equals("3")) {//租车商
                        sure = forgetmerchantpassword(id,ph,ps);
                    }
                    if(sure){%>
                        <script>
                            alert("恭喜嘞，密码修改好了，别又忘记你的密码了哦( •̀ ω •́ )✧");
                            window.location.href="../userindex.jsp";
                        </script>
                        <%} else {%>
                        <script>
                            alert("真的可怜，密码没修改好，太遗憾了＞︿＜");
                            window.location.href="forgetPassword.jsp";
                        </script>
                        <%}%>
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
                phonenumber: {
                    identifier: 'phonenumber',
                    rules: [
                        {
                            type: 'regExp',
                            value: /^1[3-9]\d{9}$/,
                            prompt: '手机号码错误'
                        }
                    ]
                },password: {
                identifier: 'password',
                rules: [
                    {
                        type: 'regExp',
                        value: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$/,
                        prompt: '密码必须包含至少一个大写字母、一个小写字母和一个数字，且长度至少为6位'
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