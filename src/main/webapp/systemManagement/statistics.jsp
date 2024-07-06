<%@ page import="static com.example.car_rental.tool.Query.*" %>
<%@ page import="com.example.car_rental.display.*" %>
<%@ page import="com.example.car_rental.tool.TraverseDate" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.car_rental.entity.*" %><%--
  Created by IntelliJ IDEA.
  User: 肩上有清风
  Date: 2024/2/22
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 该jsp用于绘制销售额等图--%>

<%
  //预定订单数量
  int bookedOrderNumber = 0;
  //租车订单数量
  int checkInOrderNumber = 0;
  //退车订单数量
  int checkOutOrderNumber = 0;
  //续费订单数量
  int timeExtensionOrderNumber = getAllTimeExtensionOrders().size();
  //订单视图
  ArrayList<OrderView> allOrders = getAllOrderViews("");

  for (OrderView allOrder : allOrders) {
    switch (allOrder.getOrderStatus()) {
      case "已租车":
        checkInOrderNumber++;
        break;
      case "已退车":
        checkOutOrderNumber++;
        break;
      case "已预订":
        bookedOrderNumber++;
        break;
    }
  }


//--------------不同车型数量时间线------------------ //

  ArrayList<String> weekCarType = new ArrayList<String>();


  Connection connection = null;
  PreparedStatement preparedStatement = null;
  ResultSet resultSet = null;
  try {
      connection =  DataBase.getConnection();
    String sql ="SELECT cartype FROM cartypeandprice" ;
    preparedStatement = connection.prepareStatement(sql);
    resultSet = preparedStatement.executeQuery();
    while (resultSet.next()) {
      String carType = resultSet.getString("cartype"); //1.2将车辆的类型加入到weekcartype中去
      weekCarType.add(carType);
    }

  } catch (SQLException e) {
    e.printStackTrace();
  } catch (Exception e) {
    throw new RuntimeException(e);
  }


  //获取所有的订单，view根据视图倒序排列
  ArrayList<OrderView> weekView = getAllOrderViews("");

  String weekBeginDate = weekView.get(weekView.size() - 1).getOrderTime().toString();

  String weekEndDate = weekView.get(0).getOrderTime().toString();

  ArrayList<String> orderDateSequence = (ArrayList<String>) TraverseDate.getEveryday(weekBeginDate, weekEndDate);
  //日期->车辆->预定数量
  TreeMap<String, TreeMap<String, Integer>> weekData =  new TreeMap<String, TreeMap<String, Integer>>();

  for (int i = 0; i < orderDateSequence.size(); i++) {
    String dt = orderDateSequence.get(i);
    weekData.put(dt, new TreeMap<String, Integer>());
    for (int j = 0; j < weekCarType.size(); j++) {
      weekData.get(dt).put(weekCarType.get(j), 0);
    }
  }

  for (int i = 0; i < weekView.size(); i++) {
    String dt = weekView.get(i).getOrderTime().toString();
    String tp = weekView.get(i).getCarType();
    if (weekData.containsKey(dt) && weekData.get(dt).containsKey(tp)) {
      int oldn = weekData.get(dt).get(tp);
      weekData.get(dt).put(tp, oldn + 1);
    }
  }

  //生成画图数据
  ArrayList<String> genWeekDate = new ArrayList<String>();
  for (int i = 0; i < orderDateSequence.size(); i++) {
    genWeekDate.add("'" + orderDateSequence.get(i) + "'");
  }

  ArrayList<ArrayList<Integer>> carTypeLists = new ArrayList<>();
  ArrayList<String> genrp = new ArrayList<String>();

// 初始化汽车类型列表
  for (int i = 0; i < weekCarType.size(); i++) {
    carTypeLists.add(new ArrayList<>());
    genrp.add("'" + weekCarType.get(i) + "'");
  }

// 将数据添加到对应的类型列表中
  for (String key : weekData.keySet()) {
    Map<String, Integer> data = weekData.get(key);
    for (int i = 0; i < weekCarType.size(); i++) {
      carTypeLists.get(i).add(data.get(weekCarType.get(i)));
    }
  }
//
  StringBuilder seriesBuilder = new StringBuilder();
  for (int i = 0; i < carTypeLists.size(); i++) {
    seriesBuilder.append("{\n")
            .append("name: ").append(genrp.get(i)).append(",\n")
            .append("type: 'line',\n")
            .append("stack: '总量',\n")
            .append("areaStyle: {normal: {}},\n")
            .append("data: ").append(carTypeLists.get(i)).append("\n")
            .append("},\n");
  }
  if (seriesBuilder.length() > 0) {
    seriesBuilder.deleteCharAt(seriesBuilder.length() - 1);
  }

  String series = seriesBuilder.toString();





//---------------------------------------------//
  //员工绩效
  HashMap<String, Integer> waiterCommission = new HashMap<String, Integer>();

  ArrayList<Waiter> allWaiters = getAllWaiters();

  for (int i = 0; i < allWaiters.size(); i++) {
    waiterCommission.put(allWaiters.get(i).getWaiterName(), 0);
  }
  //获取所有的订单
  ArrayList<Order> orders = getAllOrders();

  for (int i = 0; i < orders.size(); i++) {
    String wi = orders.get(i).getWaiterID();
    String wn = "";
    if (wi == null || wi.isEmpty()) {
      continue; // 服务员ID为空或无效，跳过此次循环
    }
    Waiter waiter = getWaiter(wi);
    if (waiter != null) {
      wn = waiter.getWaiterName();
      if (waiterCommission.containsKey(wn)) {
        int old = waiterCommission.get(wn);
        //更新value
        waiterCommission.put(wn, old + 1);
      }
      else {
        // 如果服务员名字对应的键不存在，将其添加到waiterCommission并将计数初始化为1
        waiterCommission.put(wn, 1);
      }
    }
  }

  ArrayList<String> waiterNameArray = new ArrayList<String>();

  ArrayList<Integer> waiterCommissionArray = new ArrayList<Integer>();

  for (String key : waiterCommission.keySet()) {
    waiterNameArray.add("'" + key + "'");
    waiterCommissionArray.add(waiterCommission.get(key));
  }
//---------------------------------------------------------------------------//
  //查询各种汽车数量

  ArrayList<CarTypeAndPrice> carsNew =getAllCarsInfo("","", "");


  HashMap<String, CarCountValue> carCounts = new HashMap<String, CarCountValue>();

  for (int i = 0; i < carsNew.size(); i++) {
    if (!carCounts.containsKey(carsNew.get(i).getCarType())) {
      carCounts.put(carsNew.get(i).getCarType(), new CarCountValue(0, 0));
    }
    if (carsNew.get(i).getCarStatus().equals("空")) {
      int oldEmpy = carCounts.get(carsNew.get(i).getCarType()).getEmptyNum();
      int oldFull = carCounts.get(carsNew.get(i).getCarType()).getFullNum();
      carCounts.put(carsNew.get(i).getCarType(), new CarCountValue(oldEmpy + 1, oldFull));
    }
    if (carsNew.get(i).getCarStatus().equals("非空")) {
      int oldEmpy = carCounts.get(carsNew.get(i).getCarType()).getEmptyNum();
      int oldFull = carCounts.get(carsNew.get(i).getCarType()).getFullNum();
      carCounts.put(carsNew.get(i).getCarType(), new CarCountValue(oldEmpy, oldFull + 1));
    }

  }

  ArrayList<String> carType = new ArrayList<String>();

  ArrayList<Integer> carNumEmpty = new ArrayList<Integer>();

  ArrayList<Integer> carNumFull = new ArrayList<Integer>();

  for (String key : carCounts.keySet()) {
    carType.add("'" + key + "'");
    carNumEmpty.add(carCounts.get(key).getEmptyNum());
    carNumFull.add(carCounts.get(key).getFullNum());
  }

  //盈利折线图，每日订单数以及营收
  ArrayList<InComeView> allIncomeViews = getInComeView();
  String beginDate = allIncomeViews.get(0).getDate();
  String endDate = allIncomeViews.get(allIncomeViews.size() - 1).getDate();

  //保存原始数据
  Map<String, InComeView> incomeDatas = new TreeMap<String, InComeView>();

  //得到正确的日期序列，保存日期
  ArrayList<String> xDate = (ArrayList<String>)TraverseDate.getEveryday(beginDate, endDate);

  for (String d : xDate) {
    incomeDatas.put(d, new InComeView(d, 0, 0));
  }
  //日期自动排序
  for (int i = 0; i < allIncomeViews.size(); i++) {
    if (incomeDatas.containsKey(allIncomeViews.get(i).getDate())) {
      incomeDatas.put(allIncomeViews.get(i).getDate(), new InComeView(allIncomeViews.get(i).getDate(),
              allIncomeViews.get(i).getAllPrice(),
              allIncomeViews.get(i).getCheckOutNumber()));
    }
  }

  //map数据提取完毕，传入数组
  ArrayList<String> xincomeDate = new ArrayList<String>();
  ArrayList<Integer> incomeOrders = new ArrayList<Integer>();
  ArrayList<Integer> incomeMoney = new ArrayList<Integer>();

  for (String key : incomeDatas.keySet()) {
    xincomeDate.add("'" + key + "'");
    incomeOrders.add(incomeDatas.get(key).getCheckOutNumber());
    incomeMoney.add(incomeDatas.get(key).getAllPrice());
  }
%>
<%
  int set = Integer.parseInt(request.getParameter("set"));
%>

<html>
<head>
  <meta charset="UTF-8">
  <title>业务数据统计</title>
  <style type="text/css">
    h2 {
      margin: 1em 0em;
    }
    .ui.container {
      padding-top: 5em;
      padding-bottom: 5em;
    }
  </style>

  <script src="../echarts/echarts.js"></script>
  <script>
    function fun(i) {
      window.location.href="statistics.jsp?mop=10&set="+i;
    }
  </script>
</head>
<%@include file="../common/systemAdmin.jsp"%>

<body>
<div class="pusher">
  <div class="ui fluid container">

    <div class="ui column grid" >
      <div class="three wide column"></div>
      <div class="ten wide column" style="display: flex; justify-content: space-between; align-items: center;">
        <a class="label">
          <button value="1" onclick="fun(1)" class="ui button"><i class="calendar icon"></i>订单统计</button>
        </a>
        <a class="label">
          <button value="2" onclick="fun(2)" class="ui button"><i class="pie chart icon"></i>员工业绩统计</button>
        </a>
        <a class="label">
          <button value="3" onclick="fun(3)" class="ui button"><i class="yen icon"></i>营收数据统计</button>
        </a>
        <a class="label">
          <button value="4" onclick="fun(4)" class="ui button"><i class="car icon"></i>汽车数据统计</button>
        </a>
        <a class="label">
          <button value="5" onclick="fun(5)" class="ui button"><i class="line chart icon"></i>订单数据统计</button>
        </a>
      </div>
      <div class="three wide column"></div>
      <div class="three wide column"></div>
      <%if (set==1){%>
      <%--//订单统计--%>
      <div class="nine wide column">
        <div id="ods" style="width:100%;height:400px;"></div>
        <script type="text/javascript">
          var orderChart = echarts.init(document.getElementById('ods'));
          var waiterOption = {
            title: {
              text: '订单统计',
              left: 'center',
              textStyle: {
                fontSize: 18,
                fontWeight: 'bold'
              }
            },
            tooltip: {},
            grid:{
              left: '15%', // 调整左边距
              right: '5%', // 调整右边距
              bottom: '10%', // 调整底部距离
              containLabel: true // 包含坐标轴标签在内
            },
            legend: {
              data:['订单量'],
              right: 20 // 调整右边距
            },
            xAxis: {
              data: ["已预订", "已租车","已退车","续费"],
            },
            yAxis: {},
            series: [{
              name: '订单量',
              type: 'bar',
              data: [<%=bookedOrderNumber%>, <%=checkInOrderNumber%>, <%=checkOutOrderNumber%>, <%=timeExtensionOrderNumber%>]
            }]
          };
          orderChart.setOption(waiterOption);
        </script>
      </div>

      <%} else if (set==2) {%>
      <%--//员工业绩统计--%>
      <div class="nine wide column">
        <div id="waiter" style="width:100%;height:500px;"></div>
        <script>

          var waiterChart = echarts.init(document.getElementById('waiter'));
          var waiterData = genData();

          waiterOption = {
            title : {
              text: '员工业绩统计',
              subtext: '处理订单数量',
              left: 'center', // 将标题水平居中显示
              textStyle: {
                fontSize: 18, // 标题字体大小
                fontWeight: 'bold' // 标题加粗
              }
            },
            tooltip : {
              trigger: 'item',
              formatter: "{a} : {b} <br/> 处理订单量 : {c} ({d}%)"
            },
            legend: {
              type: 'scroll',
              orient: 'vertical',
              right: 20, // 调整右侧距离
              top: 20, // 调整顶部距离
              data: waiterData.legendData
            },
            series : [
              {
                name: '姓名',
                type: 'pie',
                radius : '50%',
                center: ['50%', '55%'],
                data: waiterData.seriesData,
                itemStyle: {
                  emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                  }
                }
              }
            ]
          };

          function genData() {

            var legendData = [];
            var seriesData = [];
            var jname = <%=waiterNameArray%>;
            var jvalue = <%=waiterCommissionArray%>;
            for (var i = 0; i < jname.length; i++) {
              legendData.push(jname[i]);
              seriesData.push({
                name : jname[i],
                value : jvalue[i]});
            }
            console.log('jmap' + jname);
            return {
              legendData: legendData,
              seriesData: seriesData
            };

          }

          waiterChart.setOption(waiterOption);

        </script>
      </div>

      <%} else if (set==3) {%>
      <%--//营收数据统计--%>
      <div class="nine wide column">
        <div id="income" style="width:100%;height:500px;"></div>
        <script>

          var incomeChart = echarts.init(document.getElementById("income"));

          option = {

            // Make gradient line here
            visualMap: [{
              show: false,
              type: 'continuous',
              seriesIndex: 0,
              min: 0,
              max: 400
            }, {
              show: false,
              type: 'continuous',
              seriesIndex: 1,
              dimension: 0,
              min: 0,
              max: <%=xincomeDate.size() - 1%>
            }],
            title: [{
              left: 'center',
              text: '每日退车订单量'
            }, {
              top: '55%',
              left: 'center',
              text: '每日营业额'
            }],
            tooltip: {
              trigger: 'axis'
            },
            xAxis: [{
              data: <%=xincomeDate%>
            }, {
              data: <%=xincomeDate%>,
              gridIndex: 1
            }],
            yAxis: [{
              splitLine: {show: false}
            }, {
              splitLine: {show: false},
              gridIndex: 1
            }],
            grid: [{
              bottom: '60%'
            }, {
              top: '60%'
            }],
            series: [{
              type: 'line',
              showSymbol: false,
              data: <%=incomeOrders%>
            }, {
              type: 'line',
              showSymbol: false,
              data: <%=incomeMoney%>,
              xAxisIndex: 1,
              yAxisIndex: 1
            }]
          };
          incomeChart.setOption(option);

        </script>
      </div>

      <%} else if (set==4) {%>
      <%--//汽车数据统计--%>
      <div class="sixteen wide column">
        <div id="cars" style="width:100%;height:2000px;"></div>
        <script type="text/javascript">
          var roomChart = echarts.init(document.getElementById("cars"));

          carOption = {
            title : {
              text: '汽车统计',
              left: 'center', // 将标题水平居中显示
              textStyle: {
                fontSize: 18, // 标题字体大小
                fontWeight: 'bold' // 标题加粗
              }
            },
            tooltip : {
              trigger: 'axis',
              axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
              }
            },
            legend: {
              right:'3%',
              data: ['空', '非空']
            },
            grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
            },
            xAxis:  {
              type: 'value'
            },
            yAxis: {
              type: 'category',
              data: <%=carType%>
            },
            series: [
              {
                name: '空',
                type: 'bar',
                stack: '总量',
                label: {
                  normal: {
                    show: true,
                    position: 'insideRight'
                  }
                },
                data: <%=carNumEmpty%>
              },
              {
                name: '非空',
                type: 'bar',
                stack: '总量',
                label: {
                  normal: {
                    show: true,
                    position: 'insideRight'
                  }
                },
                data: <%=carNumFull%>
              },
            ]
          };
          roomChart.setOption(carOption);
          console.log(<%=carNumEmpty%>)
        </script>
      </div>

      <%} else if (set==5) {%>
      <%--订单数据统计--%>
      <div class="sixteen wide column">
        <div id="weekTypeNum" style="width: 95%;height:600px;"></div>
        <script>

          var initialSelected = {};
          var genrpArray = <%=genrp%>;
          for (var i = 0; i < genrpArray.length; i++) {
            initialSelected[genrpArray[i]] = false;
          }
          var weekChart = echarts.init(document.getElementById("weekTypeNum"));
          weekChartOption = {
            title: {
              left:'center',
              text: '订单数据'
            },
            tooltip : {
              trigger: 'axis',
              axisPointer: {
                type: 'cross',
                label: {
                  backgroundColor: '#6a7985'
                }
              }
            },
            grid: [
              {   // 主要的图表区域
                left: '5%',
                top: '10%',
                right:'15%',//右边给图例区域
                bottom: '20%'
              },
              {   // 用于放置图例的区域
                left: '70%',
                top:'3%',
                bottom: '10%',
                width: '80%'  // 设置合适的宽度来容纳图例
              }
            ],

            legend: {
              orient: 'vertical',//垂直排列
              left:'right',//放置右侧
              top:'center',//垂直居中
              type: 'scroll', // 如果图例项过多，可以启用滚动
              data: genrpArray,
              selected: initialSelected,//初始状态全不选中，为false
              gridIndex: 1,  // 指定图例所属的 grid 区域
              width: '90%', // 图例区域宽度
              height: '80%' // 图例区域高度
            },

            xAxis : [
              {
                type : 'category',
                boundaryGap : false,
                data : <%=genWeekDate%>
              }
            ],
            yAxis : [
              {
                type : 'value'
              }
            ],
            series : [<%= series %>]
          };

          weekChart.setOption(weekChartOption);

        </script>
      </div>
      <%} %>

    </div>
  </div>
</div>
</body>
</html>
