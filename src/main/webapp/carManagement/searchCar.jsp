<%@ page import="java.util.Map" %>
<%@ page import="com.example.car_rental.entity.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static com.example.car_rental.tool.Query.*" %>
<%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/2/24
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>车辆查询</title>
  <%
    Map<String, String[]> map =request.getParameterMap() ;
    String size1 = "任意",size2 = "任意",size3 = "任意";
    if( map.get("size1")!=null ){
      size1 = map.get("size1")[0] ;
    }
    if( map.get("size2")!=null ){
      size2 = map.get("size2")[0] ;
    }
    if( map.get("size3")!=null ){
      size3 = map.get("size3")[0] ;
    }
    System.out.println(size1+" "+size2+" "+size3);

    ArrayList <CarTypeAndPrice> list =searchCar(size1,size2,size3) ;//查找车辆条件
    ArrayList<String> brandList = searchCarbrand();//车品牌
    brandList.add("任意");

    String[] rs2 = {"0-5","5-9","9-20","任意"}  ;//座位类型
    String[] rs3 = {"0-100","100-200","200-300","300-400","任意"}  ;//价格
    // 筛选出类型 放在一个集合里  然后遍历  ;
  %>
  <link rel="stylesheet" type="text/css" href="../static/semantic/dist/semantic.min.css">
  <script src="../static/semantic/dist/jquery.min.js"></script>
  <script src="../static/semantic/dist/semantic.js"></script>
<script>
    function fun() {
      var obj = document.getElementsByName("size1");//选择所有name="id"的对象，返回数组
      var v='';//如果这样定义var v;变量v中会默认被赋个null值
      for(var i=0;i<obj.length;i++){
        if(obj[i].checked) {//取到对象数组后，我们来循环检测它是不是被选中
          v+=('size1='+obj[i].value);
        }  //如果选中，将value添加到变量v中
      }
      obj = document.getElementsByName("size2");//选择所有name="id"的对象，返回数组
      //如果这样定义var v;变量v中会默认被赋个null值
      for(var i=0;i<obj.length;i++){
        if(obj[i].checked) {//取到对象数组后，我们来循环检测它是不是被选中
          v+=('&size2='+obj[i].value);
        }  //如果选中，将value添加到变量v中
      }
      obj = document.getElementsByName("size3");//选择所有name="id"的对象，返回数组
      //如果这样定义var v;变量v中会默认被赋个null值
      for(var i=0;i<obj.length;i++){
        if(obj[i].checked) {//取到对象数组后，我们来循环检测它是不是被选中
          v+=('&size3='+obj[i].value);
        }  //如果选中，将value添加到变量v中
      }

      // alert('/searchCar.jsp?'+v);
      window.location.href='./searchCar.jsp?'+v
    }
    function nocar(){
          alert("来迟了一步，车辆被抢走了，看看其他车辆吧")
    }

    $(document).ready(function(){
      $('.ui.accordion')
              .accordion()
      ;
    });
  </script>
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
</head>
<%@include file="../common/carAdmin.jsp"%>
<body>

<div class="pusher">

  <div class="ui container">

    <div class="ui column grid">
      <div class="four wide column">
        <div style="position: fixed;z-index: 100">
          <h2 class="ui header">车辆查询</h2>
        <div class="ui vertical  menu">
          <div class="item">
            <a class="active title collapsible">
              <i class="icon angle right"></i><%--初始下是向右而不是向下--%>
              品牌
            </a>
            <div class="active content" style="display: none"><%--初始下是折叠而不是展开--%>
              <div class="ui form">
                <div class="grouped fields" style="max-height: 200px; overflow: auto;">
                  <%for (String s : brandList){%>
                  <div class="field">
                    <div class="ui radio checkbox">
                      <input type="radio" name="size1" value=<%=s%>  <%=s.equals(size1)?"checked":""%> onclick="fun()">
                      <label><%=s%></label>
                    </div>
                  </div>
                  <%}%>
                </div>
              </div>
            </div>
          </div>
          <div class="item">
            <a class="active title collapsible">
              <i class="icon angle right"></i>
              座位
            </a>
            <div class="active content" style="display: none"><%--初始下是折叠而不是展开--%>
              <div class="ui form">
                <div class="grouped fields">
                  <%for (String s : rs2){%>
                  <div class="field">
                    <div class="ui radio checkbox">
                      <input type="radio" name="size2" value=<%=s%>  <%=s.equals(size2)?"checked":""%> onclick="fun()">
                      <label><%=s%>座</label>
                    </div>
                  </div>
                  <%}%>
                </div>
              </div>
            </div>
          </div>
          <div class="item">
            <a class="active title collapsible">
              <i class="icon angle right"></i>
              价格
            </a>
            <div class="active content" style="display: none"><%--初始下是折叠而不是展开--%>
              <div class="ui form">
                <div class="grouped fields">
                  <%for (String s : rs3){%>
                  <div class="field">
                    <div class="ui radio checkbox">
                      <input type="radio" name="size3" value=<%=s%>  <%=s.equals(size3)?"checked":""%> onclick="fun()">
                      <label><%=s%></label>
                    </div>
                  </div>
                  <%}%>
                </div>
              </div>
            </div>
          </div>
        </div>
        </div>
      </div>

      <div class="eleven wide  column" >
        <div class="ui divided items">

          <div class="item">
            <div class="content" style="position: fixed;  z-index: 100;">
              <div class="ui button" style="margin-left: 160px;">品牌名:<%=size1%></div>
              <div class="ui button" style="margin-left: 60px;">座位数:<%=size2%></div>
              <div class="ui button" style="margin-left: 60px;">价格:<%=size3%></div>
            </div>
          </div>

          <div style="height: 40px;"></div>


          <%for( CarTypeAndPrice rtp : list){%>
          <div class="item">
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
              <div class="meta">
                <a class="ui teal tag label ">¥<%=rtp.getPrice()%></a>
              </div>
              <div class="description">
                <p><%=rtp.getDesc()%></p>
              </div>
              <div class="extra">
                <%
                  ArrayList<String> ls = searchEmptyCars(rtp.getCarType());//座位数，车号，类型
                  if(ls.size()!=0){//车可预定
                %>
                <button class="ui right floated button" onclick="window.location.href='carOrder.jsp?op=2&cartype=<%=rtp.getCarType()%>'">
                  <%}else {%><%--车不可预定--%>
                    <button class="ui right floated button" onclick="nocar()">
                  <%}%>
                  <a>预定<i class="right chevron icon"></i></a>
                </button>
              </div>
            </div>
          </div>
          <%}%>
        </div>

      </div>
    </div>
  </div>
</div>


<script>
  $('.item .collapsible').click(function() {
    $(this).find('.icon').toggleClass('angle right angle down');
    $(this).siblings('.content').toggle();
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
</body>
</html>
