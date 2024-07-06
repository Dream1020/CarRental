<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String)request.getSession().getAttribute("error");
    if (error != null) {
%>
<script type="text/javascript">
    alert("<%=error%>");
</script>
<%
        // 清除错误信息，避免重复显示
        request.getSession().removeAttribute("error");
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>欢迎登录系统</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/semantic/dist/semantic.min.css">
    <script src="${pageContext.request.contextPath}/static/semantic/dist/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/semantic/dist/semantic.js"></script>
</head>
<style type="text/css">
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    body {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        flex-direction: column;
        background: #23242a;
    }

    .box {
        position: relative;
        width: 380px;
        height: 420px;
        background: #1c1c1c;
        border-radius: 8px;
        overflow: hidden;
    }

    .box::before {
        content: '';
        z-index: 1;
        position: absolute;
        top: -50px;
        left: -50px;
        width: 380px;
        height: 420px;
        transform-origin: bottom right;
        background: linear-gradient(0deg, transparent, #45f3ff, #45f3ff);
        animation: animate 6s linear infinite;
    }

    .box::after {
        content: '';
        z-index: 1;
        position: absolute;
        top: -50px;
        left: -50px;
        width: 380px;
        height: 420px;
        transform-origin: bottom right;
        background: linear-gradient(0deg, transparent, #45f3ff, #45f3ff);
        animation: animate 6s linear infinite;
        animation-delay: -3s;
    }

    @keyframes animate {
        0% {
            transform: rotate(0deg);
        }
        100% {
            transform: rotate(360deg);
        }

    }

    form {
        position: absolute;
        inset: 2px;
        background: #28292d;
        padding: 50px 40px;
        border-radius: 8px;
        z-index: 2;
        display: flex;
        flex-direction: column;
    }

    h2 {
        color: #45f3ff;
        font-weight: 500;
        text-align: center;
        letter-spacing: 0.1em;
    }

    h3 {
        color: #45f3ff;
        font-weight: 500;
        font-size: 1em;
        text-align: center;
        letter-spacing: 0.1em;
    }

    .inputBox {
        position: relative;
        width: 300px;
        margin-top: 35px;
    }

    .inputBox input {
        position: relative;
        width: 100%;
        padding: 20px 10px 10px;
        background: transparent;
        outline: none;
        box-shadow: none;
        border: none;
        color: #23242a;
        font-size: 1em;
        letter-spacing: 0.05em;
        transition: 0.5s;
        z-index: 10;
    }

    .inputBox span {
        position: absolute;
        left: 0;
        padding: 20px 0px 10px;
        pointer-events: none;
        font-size: 1em;
        color: #8f8f8f;
        letter-spacing: 0.05em;
        transition: 0.5s;
    }

    .inputBox input:valid ~ span,
    .inputBox input:focus ~ span {
        color: #45f3ff;
        transform: translateX(0px) translateY(-34px);
        font-size: 0.75em;
    }

    .inputBox i {
        position: absolute;
        left: 0;
        bottom: 0;
        width: 100%;
        height: 2px;
        background: #45f3ff;
        border-radius: 4px;
        overflow: hidden;
        transition: 0.5s;
        pointer-events: none;
        z-index: 9;
    }

    .inputBox input:valid ~ i,
    .inputBox input:focus ~ i {
        height: 44px;
    }

    .links {
        display: flex;
        justify-content: space-between;
    }

    .links a {
        margin: 10px 0;
        font-size: 0.75em;
        color: #8f8f8f;
        text-decoration: beige;
    }

    .links a:hover/*鼠标悬停时应用样式。*/
        /* .links a:nth-child(2) 代表着第二个元素*/
    {
        color: #45f3ff;
    }

    input[type='submit'] {
        border: none;
        outline: none;
        padding: 11px 25px;
        background: #45f3ff;
        cursor: pointer;
        border-radius: 4px;
        font-weight: 600;
        width: 100px;
        margin-top: 10px;
        margin-left: 100px;
    }

    input[type="submit"]:active {
        opacity: 0.6;
    }
</style>

<body>
<div class="box">
    <form autocomplete="off" id="form1" method="post" action="/LoginServlet">
        <h2>登录</h2>
        <div class="links">
            <div class="ui radio checkbox">
                <input type="radio" name="admin" value="0" checked="checked">
                <label><h3><i class="user icon"></i>员工登录</h3></label>
            </div>

            <div class="ui radio checkbox">
                <input type="radio" name="admin" value="1">
                <label><h3><i class="users icon"></i>管理员登录</h3></label>
            </div>
        </div>
        <div class="inputBox">
            <input type="text" required="required" id="id" name="userid" autocomplete="username">
            <span>用户名</span>
            <i></i>
        </div>
        <div class="inputBox">
            <input type="password" required="required" id="password" name="userpassword"
                   autocomplete="current-password">
            <span>密码</span>
            <i></i>
        </div>
        <div>
            <input type="submit" value="登录">
        </div>
    </form>
</div>
<script>
    function no() {
        alert("忘记密码了？等等吧，我功能还没弄好呢。你再想一想你的密码吧。");
    }

    var form = document.getElementById("form1");
    var id = document.getElementById("id");
    var password = document.getElementById("password");

    form.addEventListener("submit", function (event) {
        if (!validateId(id.value)) {
            alert("用户名格式不正确！");
            event.preventDefault();
        } else if (!validatePassword(password.value)) {
            alert("密码格式不正确！");
            event.preventDefault();
        }
    });

    function validateId(id) {
        var regex = /^[a-zA-Z0-9]{1,11}$/;
        return regex.test(id);
    }

    function validatePassword(password) {
        var regex = /^[a-zA-Z0-9]{1,10}$/;
        return regex.test(password);
    }

</script>
</body>
</html>