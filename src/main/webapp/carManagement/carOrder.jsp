<%@ page import="com.example.car_rental.entity.*" %>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/2/1
  Time: 8:43
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
    String carid ="" ;
    if(map.get("carid")!=null){
        carid=map.get("carid")[0] ;
    }
%>
<%--
这是员工管理的jsp页面
--%>
<html>
<head>
    <meta charset="UTF-8">
    <title>租车管理系统</title>
    <link rel="stylesheet" type="text/css" href="../static/semantic/dist/semantic.min.css">
    <script src="../static/semantic/dist/jquery.min.js"></script>

    <style type="text/css">
        h2 {
            margin: 1em 0em;
        }
        .ui.container {
            padding-top: 5em;
            padding-bottom: 5em;
        }
    </style>
    <style>
        /* 图片样式 */

        /* 模态框样式 */
        #modal {
            display: none; /* 默认隐藏 */
            position: fixed;
            z-index: 9999;

            top: 20%;
            width: auto;
            height: auto;
            overflow: auto;
            background-color: rgba(0,0,0,0.8);
        }
        #modal-content {
            margin: 10% auto;
            display: block;
            width: 80%;
            max-width: 800px;
        }
        #modal-img {
            width: auto;
            height: auto;
        }
        /* 关闭按钮样式 */
        .close {
            color: #fff;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            padding: 10px;
        }
        .close:hover,
        .close:focus {
            color: #ccc;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script >
        function returnMainPage() {
            window.location.href="carOrder.jsp?op=1" ;
        }

        function fun4() {
            var car = document.getElementById("carid").value
            var name = document.getElementById("name").value
            var idcard =document.getElementById("idcard").value.toString()
            var year=idcard.substring(6,10)//取6-10位，包含第6位不包含第10位
            var month = idcard.substring(10,12)
            var day =idcard.substring(12,14)
            var birthdata = year+'-'+month+'-'+day
            var sex = document.getElementById("sex").value
            var phonenumber = document.getElementById("phonenumber").value
            var time = document.getElementById("time").value
            var address = document.getElementById("address").value;
                var url = "&carid=" + car +
                    "&name=" + name +
                    "&idcard=" + idcard +
                    "&birthdata=" + birthdata +
                    "&sex=" + sex +
                    "&phonenumber=" + phonenumber +
                    "&time=" + time+"&address="+address;

                var url1 = window.location.search.split("&")[1];

                window.location.href = "/ServiceManage?op=1&" + url1 + url;//传到后台的servicemanagement
            return false ;

        }

    </script>
</head>
<%@include file="/common/carAdmin.jsp"%>
<body>
<div class="pusher">
    <div class="ui container">

        <div class="ui column grid">
            <div class="four wide column">
                <div style="position: fixed;z-index: 100">
                    <h2 class="ui header">订车</h2>
                <div class="ui vertical steps">

                    <div class="<%=(op<=1)?"active step ":"completed step"%>" >
                        <i class="building icon"></i>
                        <div class="content">
                            <div class="title">选定车型</div>
                            <%--<div class="description">Choose your shipping options</div>--%>
                        </div>
                    </div>

                    <div class="<%=(op==2)?"active step ":(op==1)?"step":"completed step"%>">
                        <i class="user icon"></i>
                        <div class="content">
                            <div class="title">用户登记</div>
                            <%--<div class="description">Enter billing information</div>--%>
                        </div>
                    </div>

                    <div class="<%=(op==3|| op==4)?"active step ":"step"%>">
                        <i class="info icon"></i>
                        <div class="content">
                            <div class="title">订单支付</div>
                            <%--<div class="description">Verify order details</div>--%>
                        </div>
                    </div>
                </div>
                </div>

            </div>

            <div class="twelve wide  column" >

                <% if(op==1){ %>
                <div class="ui three column grid">
                    <%

                        ArrayList<CarTypeAndPrice> allCars = getAllCars();
                        for(CarTypeAndPrice rtp : allCars){
                            ArrayList<Integer> list = null;//   list[1]非空  list[0]空
                            try {
                                list = getNumofCar(rtp.getCarType());
                            } catch (Exception e) {
                                throw new RuntimeException(e);
                            }
                    %>
                    <div class="column" >
                        <div class="ui card">
                            <div class="image" onclick="showModal('${pageContext.request.contextPath}/displayPhoto?carNumber=<%=rtp.getCarnumber()%>')">
                                <img src=${pageContext.request.contextPath}/displayPhoto?carNumber=<%=rtp.getCarnumber()%> >
                            </div>
                            <%-- 图片模态框 --%>
                            <div id="modal">
                                <span class="close" onclick="hideModal()">&times;</span>
                                <img id="modal-img" src="" alt="放大图片">
                            </div>
                            <div class="content">
                                <a class="header"><%=rtp.getCarType()%></a>
                                <div class="description">
                                    <%=rtp.getDesc()%>
                                </div>
                                <div class="ui right floated statistic">

                                        <div class="value">
                                            <%=list.get(1)%>/<%=list.get(0)%>
                                        </div>

                                    <div class="label">
                                        已租出/未租出
                                    </div>
                                </div>
                            </div>
<%--                            <a class="ui orange right ribbon label" href="<% if (list.size() > 1 && list.get(0) != 0) { %>/common/carOrder.jsp?op=2&cartype=<%=rtp.getCarType()%><%}%>">--%>
<%--                                ¥<%=rtp.getPrice()%>/天--%>
<%--                            </a>--%>
                            <% if (list.size() > 1 && list.get(0) != 0) { %>
                            <a class="ui red right ribbon label" style="margin-left: -12px; margin-right: 20px" href="${pageContext.request.contextPath}/carManagement/carOrder.jsp?op=2&cartype=<%=rtp.getCarType()%>">
                                ¥<%=rtp.getPrice()%>/天  →→ 点击租用 ←←
                            </a>
                            <% } else { %>
                            <span class="ui grey right ribbon label" style="margin-left: -12px; margin-right: 20px">该车型暂无空闲车辆</span>
                            <% } %>
                        </div>
                    </div>
                    <% }  %>
                    <%}
                    else if(op==2){
                    %>
                    <form class="ui form">
                        <div class="fields">
                            <div class="seven wide field">
                                <h4 class="ui dividing header">车型选择</h4>
                                <div class="fields">
                                    <div class="six wide field">
                                        <label>车辆号</label>
                                        <select class="ui fluid search dropdown" id="carid" name="carid">
                                            <%
                                                String cartype = request.getParameter("cartype");
                                                ArrayList<String> list = searchEmptyCars(cartype);

                                                for (String str : list) {%>
                                            <option value="<%=str%>" <% if(str.equals(carid)) { %> selected="selected" <% } %>>
                                                <%=str%>
                                            </option>
                                            <%}
                                                if (list.isEmpty()) {%>
                                            <script>
                                                alert("好可惜没有车辆可租用了，要不我们换一辆车吧");
                                                window.location.href="searchCar.jsp";
                                            </script>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="two wide field"></div>
                                    <div class="eight wide field">
                                        <label>车辆名</label>
                                        <input type="text" value="<%=cartype%>" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="seven wide field">
                                <h4 class="ui dividing header">预定天数</h4>
                                <div class="fields">
                                    <div class="three field">
                                        <label>请填写用车开始时间</label>
                                        <input type="date" id="time" name="time" placeholder="天数">
                                    </div>
                                    <div class=" field"></div>
                                    <div class="three field">
                                        <label>请填写退车时间</label>
                                        <input type="date" id="time1" name="time" placeholder="天数">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <h4 class="ui dividing header">地址</h4>
                        <div class="field">
                            <label>如需送车上门，请填写地址信息，无需则不填</label>
                            <div class="fourteen wide field">
                                <input type="text" id="address" name="address" placeholder="如需送车上门，请填写地址信息，无需则不填">
                            </div>
                        </div>

                        <h4 class="ui dividing header">个人信息</h4>
                        <div class="fields">
                            <div class="seven wide field">
                                <label>姓名</label>
                                <input type="text" id="name" name="name" placeholder="姓名">
                            </div>
                            <div class="two wide field">
                                <label>性别</label>
                                <select class="ui fluid search dropdown" id="sex">
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
                            </div>
                        </div>

                        <div class="fields">
                            <div class="seven wide field">
                                <label>身份证号</label>
                                <input type="text" id="idcard" name="idcard" maxlength="18" placeholder="身份证号">
                            </div>
                            <div class="seven wide field">
                                <label>手机号</label>
                                <input type="tel" id="phonenumber" name="phonenumber" maxlength="16" placeholder="手机号">
                            </div>
                        </div>
                        <div class="fourteen wide field" style="text-align: center; top: 20px;">
                            <div class="ui button submit-button">提交订单信息</div>
                        </div>

                    </form>
                    <%}
                    else if(op==3){

                    %>

                    <h4 class="ui dividing header">订单确认</h4>
                    <table class="ui table">
                        <thead>
                        <tr><th class="six wide">名称</th>
                            <th class="ten wide">信息</th>
                        </tr></thead>
                        <tbody>
                        <%
                            Map<String, String[]> map1 = request.getParameterMap();
                            for(String key :  map1.keySet()) {  //通过遍历请求参数中的键值对，将键值对的键作为名称显示在表格的第一列，将对应值显示在表格的第二列
                                if(!key.equals("op") ){   //在遍历时排除了键为 "op" 的情况。
                        %>
                        <tr>

                            <td><%=key%></td>
                            <td><%=map1.get(key)[0].toString()%></td>

                        </tr>
                        <%
                                }
                            } %>
                        </tbody>
                    </table>


                    <h4 class="ui dividing header">完成支付</h4>
                    <div class="ui right floated labeled button" tabindex="0">
                        <a class="ui basic right pointing label">
                            <%-- 去数据库查询价格 * 天数 *相应的折扣 --%>
                            ¥<%=map.get("pay")[0]%>
                        </a>
                        <div class="ui right button">
                            <i class="shopping icon"></i> <a href="${pageContext.request.contextPath}/ServiceManage?<%=request.getQueryString()%>">支付</a>
                            <% System.out.println("request.getQueryString():" + request.getQueryString());%>
                        </div>
                    </div>
                    <%} else if (op == 4) {%>
                    <h4 class="ui dividing header">支付成功</h4>
                    <div class="ui right button" onclick="returnMainPage()">返回</div>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
            fields: {
                time: {
                    identifier: 'time',
                    rules: [
                        {
                            type: 'empty',
                            prompt: '请选择用车开始时间'
                        },
                        {
                            type: 'regExp',
                            value: /^\d{4}-\d{2}-\d{2}$/,
                            prompt: '日期格式不符合规范，正确格式为YYYY-MM-DD'
                        },
                        {
                            type: 'nowGreaterThanTime',
                            prompt: '用车开始时间必须大于现在的时间'
                        }
                    ]
                },
                time1: {
                    identifier: 'time1',
                    rules: [
                        {
                            type: 'empty',
                            prompt: '请选择退车开始时间'
                        },
                        {
                            type: 'regExp',
                            value: /^\d{4}-\d{2}-\d{2}$/,
                            prompt: '日期格式不符合规范，正确格式为YYYY-MM-DD'
                        },
                        {
                            type: 'time1GreaterThanTime',
                            prompt: '退车开始时间必须大于用车开始时间'
                        }
                    ]
                },
                carid: {
                    identifier: 'carid',
                    rules: [
                        {
                            type: 'regExp',
                            value:/^[0-9]{6}$/,
                            prompt: '车辆号不符合规范'
                        }
                    ]
                },
                idcard: {
                    identifier: 'idcard',
                    rules: [
                        {
                            type: 'regExp',
                            value:/^\d{17}[0-9Xx]$/,
                            prompt: '身份证号不符合规范'
                        }
                    ]
                },
                phonenumber: {
                    identifier: 'phonenumber',
                    rules: [
                        {
                            type: 'regExp',
                            value:/^1[3|4|5|8][0-9]\d{4,8}$/,
                            prompt: '手机号不符合规范'
                        }
                    ]
                }
            },
            rules: {
                time1GreaterThanTime: function(value) {
                    var timeValue = $('[name="time"]').val();
                    // 检查用车开始时间是否有效
                    if (!timeValue) {
                        return false; // 用车开始时间为空，无法进行比较
                    }
                    // 解析日期字符串并转换为日期对象
                    var timeDate = new Date(timeValue);
                    var time1Date = new Date(value);
                    console.log("timeDate为"+timeDate);
                    console.log("time1Date为"+time1Date);
                    // 比较时间
                    return time1Date > timeDate;
                },
                nowGreaterThanTime:function (value) {
                    var now = new Date();
                    var year=now.getFullYear();
                    var month=(now.getMonth()+1).toString().padStart(2, '0');
                    var day=(now.getDate()).toString().padStart(2, '0');
                    var nowtime=year+'-'+month+'-'+day;
                    console.log("nowtime:"+nowtime)
                    console.log("value:"+value);
                    return value >= nowtime; // 返回比较结果
                }
            },
            inline : true,
            on     : 'submit',
            onSuccess: function() {
                // 验证通过，可以进入下一步
                // 进入下一步的逻辑代码
                fun4();
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
<script>
    // 点击图片显示模态框
    function showModal(imageUrl) {
        var modal = document.getElementById('modal');
        var modalImg = document.getElementById('modal-img');
        modalImg.src = imageUrl;
        modal.style.display = 'block';
    }

    // 点击关闭按钮或模态框外部隐藏模态框
    function hideModal() {
        var modal = document.getElementById('modal');
        modal.style.display = 'none';
    }

    // 当用户点击模态框外部区域时，隐藏模态框
    window.onclick = function(event) {
        var modal = document.getElementById('modal');
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    };
</script>