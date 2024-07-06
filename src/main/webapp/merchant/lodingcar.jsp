<%@ page import="com.example.car_rental.entity.CarTypeAndPrice" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.car_rental.tool.Query" %>
<%@ page import="com.example.car_rental.entity.Carinfo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static com.example.car_rental.tool.Query.getAllCarsInfo" %>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/3/11
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过mop选项来控制页面显示的内容
    ArrayList<CarTypeAndPrice> carnumber = getAllCarsInfo("", "","");//获取所有车辆数据
    String carNumber = String.format("%06d", carnumber.size() + 1);//将需要新增的车辆号设置为6位

%>
<html>
<head>
    <title>上传车辆信息</title>
</head>
<%@include file="merchantadmin.jsp"%>
<body>
<div class="pusher">
   <div class="ui container">
       <h2 class="ui header">添加车辆</h2>
       <div class="ui column grid">
           <div class="four wide column">
               <div class="ui vertical steps">
                   <div class="<%=(op == 1) ? "active step ":"completed step"%>" >
                       <i class="add circle icon"></i>
                       <div class="content">
                           <div class="title">车辆信息</div>
                       </div>
                   </div>

                   <div class="<%=(op == 2) ? "active step ":(op== 1)?"step":"completed step"%>">
                       <i class="check circle icon"></i>
                       <div class="content">
                           <div class="title">信息确认</div>
                       </div>
                   </div>

               </div>
           </div>
           <div class="eleven wide column">
            <%
                if (op==1){
            %>
               <form class="ui form">
                   <h2 class="ui dividing header">填写新增车辆信息</h2>
                   <input type="hidden" id="op" name="op" value="2">
                   <div class="fields">
                       <div class="three wide field">
                           <label for="carNumber">车辆号</label>
                           <input type="text" id="carNumber" name="carNumber" value="<%= carNumber %>" readonly>
                       </div>

                       <div class="three wide field">
                           <label for="carType">车辆类型</label>
                           <input type="text" id="carType" name="carType" placeholder="输入车的名称">
                       </div>
                       <div class="three wide field">
                           <label for="carBrand">车辆品牌</label>
                           <input type="text" id="carBrand" name="carBrand" placeholder="请输入车辆的品牌">
                       </div>

                       <div class="three wide field">
                           <label for="carPrice">车辆价格</label>
                           <input type="text" id="carPrice" name="carPrice" placeholder="请输入车辆每日的价格">
                       </div>
                       <div class="three wide field">
                           <label for="carstate">车辆是否可用</label>
                           <select class="ui fluid search dropdown" id="carstate" name="carstate">
                               <option value="可用">可用</option>
                               <option value="不可用">不可用</option>
                           </select>
                       </div>
                   </div>
                   <div class="field">
                           <label for="carDesc">车辆细节</label>
                           <textarea id="carDesc" name="carDesc"  rows="3" placeholder="请输入车辆的一些基本信息，如几座等信息"></textarea>
                       </div>
                   <div class="two fields">
                       <div class="field">
                           <label for="phoneid">手机号</label>
                           <input type="text" id="phoneid" value="<%=session.getAttribute("caradmin")%>" readonly>
                       </div>
                   </div>
                   <div class="field" style="display: flex; justify-content: center;">
                    <button class="ui submit button">提交</button>
                   </div>
               </form>
               <%} else if (op == 2) {//信息确认
               %>
               <h2 class="ui dividing header">待添加车辆信息确认</h2>

               <form class="ui form" id="carForm" action="${pageContext.request.contextPath}/photoUpload" method="post" enctype="multipart/form-data">

                       <%
                           String carBrand = request.getParameter("carBrand");
                           String carType= request.getParameter("carType");
                           String carPrice= request.getParameter("carPrice");
                           String carDesc= request.getParameter("carDesc");
                           String carstate= request.getParameter("carstate");
                           String belong= session.getAttribute("caradmin").toString();

                           session.setAttribute("choice","3");
                           session.setAttribute("carNumber",carNumber);
                           session.setAttribute("carType",carType);
                           session.setAttribute("carBrand",carBrand);
                           session.setAttribute("carPrice",carPrice);
                           session.setAttribute("carDesc",carDesc);
                           session.setAttribute("carstate",carstate);
                           session.setAttribute("belong",belong);

                       %>
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
                       <label for="carDesc">车辆细节
                           <textarea name="carDesc" rows="3" ><%=carDesc%></textarea>
                       </label>
                   </div>
                   <div class="field">
                       <label for="phoneid">手机号
                           <input type="text" name="phoneid" value=" <%=belong%>" readonly>
                       </label>
                   </div>

                   <div class="ui segment">
                       <div class="ui grid">
                           <div class="sixteen wide column">
                               <strong>照片：</strong>
                               <div id="photoPreview" style="max-width: 200px; max-height: 200px;"></div>
                               <br>
                               <!-- 文件输入框 -->
                               <input type="file" name="file" id="fileInput" onchange="previewImage()" accept="image/*" required style="width: 200px;">
                           </div>
                       </div>
                   </div>
                   <div class="field" style="display: flex; justify-content: center;">

                        <input class="ui button submit-button" type="submit"  value="提交">

                   </div>
               </form>
            <%} else if (op==3) { //开始增加车型信息
          %>
           <h4 class="ui dividing header">添加成功</h4>
           <botton class="ui right button" onclick="returnpage(this)">返回</botton>
       <%}%>
           </div>
       </div>
   </div>
</div>
<script>
    function returnpage() {
        window.location.href="/merchant/carretal.jsp";
    }

    function previewImage() {
        var fileInput = document.getElementById('fileInput');
        var file = fileInput.files[0];

        if (file) {
            var photoPreview = document.getElementById('photoPreview');
            var img = document.createElement('img');
            img.src = URL.createObjectURL(file);
            img.style.maxWidth = "200px"; // 控制图片显示的最大宽度
            img.style.maxHeight = "200px"; // 控制图片显示的最大高度
            photoPreview.innerHTML = ''; // 清空之前的预览
            photoPreview.appendChild(img);
        } else {
            alert('请先选择要上传的照片！');
        }
    }

    $(document).ready(function (){
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
        $('#carForm').form({
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

</script>

</body>
</html>
