<%@ page import="com.example.car_rental.entity.CarTypeAndPrice" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %><%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/4/2
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int op = Integer.parseInt(request.getParameter("op"));
    ArrayList<CarTypeAndPrice> carinfos = getAllCarsInfo("","","");
    String carNumber = "";
    String parameterValue = request.getParameter("carNumber");
    if (parameterValue != null && !parameterValue.isEmpty()) {
        carNumber = parameterValue;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改车辆信息</title>
</head>
<%@include file="../common/carAdmin.jsp"%>
<body>
<div class="pusher">
    <div class="ui container">
        <h2 class="ui header">修改车辆信息</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps"><%-- op= 3  完成修改基本信息，op<3,修改基本信息  op==6  完成修改照片  ，op>6,修改照片--%>
                    <div class="<%=(op <3) ? "active step ":(op==3)?"completed step":"step"%>" onclick="window.location.href='/carManagement/UpdateCar.jsp?op=1'">
                        <i class="check circle icon"></i>
                        <div class="content">
                            <div class="title">修改基本信息</div>
                        </div>
                    </div>
                    <div class="step">
                        <div class="content">
                            <div class="title">点击修改信息</div>
                        </div>
                        <i class="Resize Vertical icon"></i>
                    </div>
                    <div class="<%=(op >6) ? "active step ":(op==6)?"completed step":"step"%>" onclick="window.location.href='/carManagement/UpdateCar.jsp?op=7'">
                        <i class="check circle icon"></i>
                        <div class="content">
                            <div class="title">修改车辆照片</div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="eleven wide column">
                <%if (op==1){%>
                <form class="ui form">
                    <h2 class="ui dividing header">填写修改的信息</h2>
                    <input type="hidden" id="op" name="op" value="2">  <%--  直接提交， 然后便会有  op=2&......   --%>
                    <%--  根据carNumber  修改 cartype、 carbrand 、price、 desc、或者photo --%>
                    <% ArrayList<CarTypeAndPrice> list=getAllCarsInfo("",carNumber,"");%>
                    <div class="fields">
                        <div class="four wide field">
                            <label for="carNumber">车辆号</label>
                            <select class="ui fluid search dropdown" id="carNumber" name="carNumber" onchange="getCarInfo()">
                                <%if (!carNumber.isEmpty()){%>
                                <option value="<%=carNumber%>" selected><%=carNumber%></option>
                                <%}%>
                                <% for (CarTypeAndPrice carinfo :carinfos){ %>
                                <option value="<%=carinfo.getCarnumber()%>"><%=carinfo.getCarnumber()%></option>
                                <%}%>
                            </select>
                        </div>
                        <div class="four wide field"></div>
                        <div class="four wide field">
                            <label>所属者
                                <input value="<%=list.get(0).getBelong()%>" readonly>
                            </label>
                        </div>
                    </div>

                    <h2 class="ui dividing header">基本信息</h2>
                    <div class="fields">

                        <div class="four wide field">
                            <label for="carType">车辆类型</label>
                            <input type="text" id="carType" name="carType" value="<%=list.get(0).getCarType()%>" placeholder="暂无">
                        </div>
                        <div class="four wide field">
                            <label for="carBrand">车辆品牌</label>
                            <input type="text" id="carBrand" name="carBrand" value="<%=list.get(0).getCarbrand()%>" placeholder="暂无">
                        </div>
                        <div class="four wide field">
                            <label for="carPrice">车辆每日价格</label>
                            <input type="text" id="carPrice" name="carPrice" value="<%=list.get(0).getPrice()%>" placeholder="暂无">
                        </div>
                        <div class="four wide field">
                            <label for="carstate">车辆是否可用</label>
                            <select class="ui fluid search dropdown" id="carstate" name="carstate">
                                <option value="<%=list.get(0).getState()%>" selected><%=list.get(0).getState()%></option>
                                <%if (list.get(0).getState().equals("可用")){%>
                                <option value="不可用" >不可用</option>
                                <%}else {%>
                                <option value="可用" >可用</option>
                                <%}%>

                            </select>
                        </div>
                    </div>
                    <div class="field">
                        <label for="carDesc">车辆细节</label>
                        <textarea id="carDesc" name="carDesc" rows="3" placeholder="暂无"><%=list.get(0).getDesc()%></textarea>
                    </div>

                    <div class="field" style="display: flex; justify-content: center;">
                        <button class="ui submit button">提交</button>
                    </div>
                </form>

                <%} else if (op==2) {%>
                <h2 class="ui dividing header">基础信息确认</h2>
                <form class="ui form" id="form2">

                    <%
                        String carBrand = request.getParameter("carBrand");
                        String carType= request.getParameter("carType");
                        String carPrice= request.getParameter("carPrice");
                        String carDesc= request.getParameter("carDesc");
                        String carstate= request.getParameter("carstate");
                    %>
                    <input type="hidden" id="op" name="op" value="3">
                    <div class="fields">
                        <div class="three wide field">
                            <label for="carNumber">车辆号</label>
                            <input type="text" name="carNumber" value="<%=carNumber%>" readonly>
                        </div>
                        <div class="four wide field">
                            <label for="carType">车辆类型</label>
                            <input type="text" name="carType" value="<%=carType%>" readonly>
                        </div>
                        <div class="three wide field">
                            <label for="carBrand">车辆品牌</label>
                            <input type="text"  name="carBrand" value="<%=carBrand%>" readonly>
                        </div>
                        <div class="three wide field">
                            <label for="carPrice">车辆每日价格</label>
                            <input type="text" name="carPrice" value="<%=carPrice%>" readonly>
                        </div>
                        <div class="three wide field">
                            <label for="carstate">车辆是否可用</label>
                            <input type="text" name="carstate" value="<%=carstate%>" readonly>
                        </div>
                    </div>
                    <div class="field">
                        <label for="carDesc">车辆细节</label>
                        <textarea name="carDesc" rows="3" ><%=carDesc%></textarea>
                    </div>

                    <a href="javascript:history.back()" class="ui button">返回</a>

                    <input class="ui submit button" type="submit" value="提交">
                </form>


                <%} else if (op==3) {
                    String carBrand = request.getParameter("carBrand");
                    String carType= request.getParameter("carType");
                    String carPrice= request.getParameter("carPrice");
                    String carDesc= request.getParameter("carDesc");
                    String carstate= request.getParameter("carstate");

                    renewbusinesscar(carNumber,carBrand,carType,carPrice,carDesc,carstate);
                %>
                <h2 class="ui dividing header">基本信息修改完成</h2>
                <a class="ui button" href="${pageContext.request.contextPath}/carManagement/carOrder.jsp?op=1">确定</a>

                <%} else if (op==7) {%>
                <form class="ui form" id="carForm" action="${pageContext.request.contextPath}/photoUpload" method="post" enctype="multipart/form-data">
                    <%
                        ArrayList<CarTypeAndPrice> list=getAllCarsInfo("",carNumber,"");
                        String carBrand = list.get(0).getCarbrand();
                        String carType = list.get(0).getCarType();

                        session.setAttribute("choice","4");
                        session.setAttribute("love","you");
                        session.setAttribute("carNumber",carNumber);
                        session.setAttribute("carType",carType);
                        session.setAttribute("carBrand",carBrand);
                    %>
                    <div class="ui segment">
                        <div class="ui grid">
                            <div class="two column row">
                                <div class="column">
                                    <strong>车辆号</strong>
                                    <select class="ui fluid search dropdown" id="carNumber1" name="carNumber1" onchange="getCarInfo1()">
                                        <% if (!carNumber.isEmpty()) { %>
                                        <option value="<%=carNumber%>" ><%=carNumber%></option>
                                        <% } %>
                                        <% for (CarTypeAndPrice carinfo : carinfos) { %>
                                        <option value="<%=carinfo.getCarnumber()%>"><%=carinfo.getCarnumber()%></option>
                                        <% }%>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="ui segment">
                        <div class="ui grid">
                            <div class="sixteen wide column">
                                <div class="ui two column grid">
                                    <div class="column">
                                        <strong>修改前照片：</strong>
                                        <!-- 图片预览区域 -->
                                        <div>
                                            <!-- 初始显示的照片 -->
                                            <img src="${pageContext.request.contextPath}/displayPhoto?carNumber=<%=carNumber%>"
                                                 style="max-width: 200px; max-height: 200px;" alt="初始照片">
                                        </div>
                                    </div>
                                    <div class="column">
                                        <strong>修改后照片：</strong>
                                        <!-- 图片预览区域 -->
                                        <div id="photoPreview">
                                            <!-- 初始显示的照片 -->
                                            <img id="initialPhoto" src="" style="max-width: 200px; max-height: 200px;" alt="初始照片">
                                        </div>
                                        <br>
                                        <!-- 文件输入框 -->
                                        <input type="file" name="file" id="fileInput" onchange="previewImage()" accept="image/*" required style="width: 200px;">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <a href="javascript:history.back()" class="ui button">返回</a>

                    <input class="ui button submit-button" type="submit" value="提交">
                </form>

                <%} else if (op==6) {%>
                <h2 class="ui dividing header">照片修改完成</h2>
                <a class="ui button" href="${pageContext.request.contextPath}/carManagement/carOrder.jsp?op=1">确定</a>
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
            fields: {
                carBrand: {
                    identifier: 'carBrand',
                    rules: [
                        {
                            type: 'empty',
                            prompt: '车品牌不能为空，请填写车品牌信息'
                        }
                    ]
                },
                carType: {
                    identifier: 'carType',
                    rules: [
                        {
                            type: 'empty',
                            prompt: '车型不能为空，请填写车型信息'
                        }
                    ]
                },
                carPrice: {
                    identifier: 'carPrice',
                    rules: [
                        {
                            type: 'empty',
                            prompt: '车价格不能为空，请填写车价格信息'
                        }
                    ]
                },
                carDesc: {
                    identifier: 'carDesc',
                    rules: [
                        {
                            type: 'empty',
                            prompt: '车辆细节不能为空，请填写车辆细节'
                        }
                    ]
                }
            }
        });
        $('#carform').form({
            fields: {
                fileInput: {
                    identifier: 'file',
                    rules: [
                        {
                            type: 'empty',
                            prompt: '请上传照片'
                        }
                    ]
                }
            }
        });
    });

    function getCarInfo() {
        var selectedCarNumber = document.getElementById("carNumber").value;
        window.location.href = "/carManagement/UpdateCar.jsp?op=1&carNumber=" + selectedCarNumber;
    }
    function getCarInfo1() {
        var selectedCarNumber = document.getElementById("carNumber1").value;
        window.location.href = "/carManagement/UpdateCar.jsp?op=7&carNumber=" + selectedCarNumber;
    }

    function previewImage() {
        var fileInput = document.getElementById('fileInput');
        var file = fileInput.files[0];
        if (file) {
            var photoPreview = document.getElementById('photoPreview');
            var initialPhoto = document.getElementById('initialPhoto');

            // 创建新的图片元素
            var img = document.createElement('img');
            img.onload = function() {
                URL.revokeObjectURL(this.src); // 释放URL
            };
            img.src = URL.createObjectURL(file);
            img.style.maxWidth = "200px"; // 控制图片显示的最大宽度
            img.style.maxHeight = "200px"; // 控制图片显示的最大高度

            // 替换初始照片为新上传的照片
            photoPreview.removeChild(initialPhoto);
            photoPreview.appendChild(img);
        }else {
            alert('请先选择要上传的照片！');
        }
    }

    function getParameterByName(name) {
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(window.location.href);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    window.onload = function() {
        var fileInput = document.getElementById('fileInput');
        if (fileInput && fileInput.files.length > 0) {
            previewImage();
        }
    };
</script>