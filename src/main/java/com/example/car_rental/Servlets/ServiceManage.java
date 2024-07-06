package com.example.car_rental.Servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.car_rental.entity.Customer;
import com.example.car_rental.entity.Order;
import com.example.car_rental.entity.TimeExtension;
import com.example.car_rental.tool.Query;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Map;
import java.util.StringTokenizer;

import static com.example.car_rental.tool.Query.*;

@WebServlet(name = "ServiceManage")
public class ServiceManage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        Map<String, String[]> map = request.getParameterMap() ;//接收传来的url
        String queryString ="" ;
        String[] values =map.get("op") ; // op=1 /2 /3
        int op = Integer.parseInt( values[0] ) ;
        // 获取当前日期
        Calendar calendar = Calendar.getInstance();
        java.util.Date currentDate = calendar.getTime();
        //定义日期
        String time,time1;
        Date date = null,date1 = null;
        long days=1, times;
        if (request.getParameter("time") != null && request.getParameter("time1") != null) {
            time = request.getParameter("time");
            time1 = request.getParameter("time1");
            try {
                date = Date.valueOf(time);
                date1 = Date.valueOf(time1);
                times = date1.getTime() - date.getTime();
                days = times / (1000 * 60 * 60 * 24);
                // 执行其他操作，如将计算结果传递给视图等
            } catch (IllegalArgumentException e) {
                // 日期格式不正确的处理逻辑
                e.printStackTrace();
            }
        }
        Date date2=new Date(currentDate.getTime());//现在的日期
        if(op==1) {
            String id = map.get("idcard")[0];
            String password = id.substring(12, 18);

            //用户登记  查询折扣
            //根据身份证查询用户是否存在
            Double discount;

            if (isIDexists(id)) {
                //老客户
                System.out.println(id + "存在,是老客户");
                discount = searchDiscount(id);
                System.out.println("折扣是" + discount);
            } else {
                //新客户
                System.out.println(id + "不存在,是新客户");

                StringTokenizer st = new StringTokenizer(map.get("birthdata")[0], "-");
                //添加客户
                Customer cu = null;
                try {
                    cu = new Customer(
                            id,
                            password,
                            map.get("sex")[0],
                            map.get("name")[0],
                            new Date(new SimpleDateFormat("yyyy-MM-dd").parse(map.get("birthdata")[0]).getTime()),
                            1,
                            map.get("phonenumber")[0],
                            0,
                            "",
                            "");
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                InsertCustomer(cu);
                discount = searchDiscount(id);
                System.out.println("折扣是" + discount);
            }
            String url = "/carManagement/carOrder.jsp?op=3&discount=" + discount+
                    "&price=" + getPrice(map.get("cartype")[0])
                    + "&pay=" + getPrice(map.get("cartype")[0]) * days * discount;
            HashSet<String> set = new HashSet<String>();
            set.add("cartype");
            set.add("name");
            set.add("sex");
            set.add("address");
            for (String key : map.keySet()) {
                if (!key.equals("op")) {
                    if (set.contains(key)) // 如果键在集合中，则输出相应的消息
                        url = url + "&" + key + "=" + URLEncoder.encode(map.get(key)[0], "utf-8");
                    else
                        url = url + "&" + key + "=" + map.get(key)[0];
                }
            }
            response.sendRedirect(url);
        }else if(op==2){
            //注销当前的登录用户  ;
            request.getSession().removeAttribute("caradmin");

            response.sendRedirect("/sysindex.jsp");
        }
        else if(op==3){
            // 添加订单
            // 添加触发器 订单导致用户金额提高 续费订单 导致金额提升
            int num =getOrderNum()+1 ;
            String orderNumber = String.format("%03d", num) ;

            String orderStatus = "";
            if (date != null && date.compareTo(date2) > 0) {//date 的日期晚于 date2 的日期，则条件成立
                orderStatus = "预定中";
            }else {
                orderStatus = "已租车";
            }
            Order order =new Order(orderNumber,orderStatus,map.get("idcard")[0],
                    map.get("carid")[0],date,date1, (int)Double.parseDouble(map.get("pay")[0]) ,
                    request.getSession().getAttribute("caradmin").toString(),
                    map.get("address")[0],date2) ;
            insertOrder(order);
            response.sendRedirect("/carManagement/carOrder.jsp?op=1") ;
        }
        else if(op==4){
            // 续费
            /**
             * 提交续费订单
             * 订单提交后要修改order表的日期 ;
             */
            TimeExtension renew = (TimeExtension) request.getSession().getAttribute("renew");
            //插入续费订单 ;
            Query.addRenew(renew) ;
            //修改相应的order日期 ;
            Date newdate = renew.getNewExpiryDate() ;
            updateNewDate(newdate,renew.getOrderNumber()) ;
            response.sendRedirect("/carManagement/carOrder.jsp?op=1") ;
        }
        else if(op==5){
            //退车
            String orderNumber= map.get("orderNumber")[0] ;
            System.out.println("订单:"+orderNumber);
            checkOutCar(orderNumber); ;
            System.out.println("退车成功");
            request.getSession().setAttribute("success","退车成功了");
            response.sendRedirect("/common/carAdmin.jsp") ;
        } else if (op == 9) {
            //注销当前顾客或者租车商用户
            request.getSession().removeAttribute("caradmin");
            response.sendRedirect("/userindex.jsp");
        }else if (op == 10) {
            //注销当前管理员用户
            request.getSession().removeAttribute("systemadmin");
            response.sendRedirect("/sysindex.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
