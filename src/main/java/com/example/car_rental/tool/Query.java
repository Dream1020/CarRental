package com.example.car_rental.tool;

import com.example.car_rental.config.GCON;
import com.example.car_rental.display.ExtensionOrderView;
import com.example.car_rental.display.OrderView;
import com.example.car_rental.display.InComeView;
import com.example.car_rental.entity.*;

import java.sql.*;
import java.sql.Date;
import java.util.*;

public class Query {
    //新增客户信息
    public static void InsertCustomer(Customer customer){
        Connection connection = null;
        Statement statement = null;
        try {
            connection =  DataBase.getConnection();
            statement = connection.createStatement();
            statement.execute("INSERT INTO customers VALUES('" +
                    customer.getCustomerIDCard() + "', '" +
                    customer.getCustomerpassword() + "', '" +
                    customer.getCustomerGender()+ "', '" +
                    customer.getCustomerName()+ "', '" +
                    customer.getCustomerBirthday()+ "', '" +
                    customer.getCustomerVIPLevel()+"','"+
                    customer.getCustomerPhoneNumber()+"','"+
                    customer.getTotalAmount()+"','"+
                    customer.getRemarks()+"','"+
                    customer.getAddress() + "');");
        } catch(Exception exception) {
            exception.printStackTrace();
        }
    }

    //查询某个客户信息
    public static ArrayList<Customer> searchonecustomer(String cu){
        ArrayList<Customer> onecustomer= new ArrayList<Customer>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = DataBase.getConnection();
            preparedStatement = connection.prepareStatement("select * from customers where customerPhoneNumber='"+cu +"'");
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                Customer customer = new Customer();
                customer.setCustomerIDCard(resultSet.getString("customerIDCard"));
                customer.setCustomerGender(resultSet.getString("customerGender"));
                customer.setCustomerName(resultSet.getString("customerName"));
                customer.setCustomerBirthday(Date.valueOf(resultSet.getString("customerBirthday")));
                customer.setCustomerVIPLevel(Integer.parseInt(resultSet.getString("customerVIPLevel")));
                customer.setCustomerPhoneNumber(resultSet.getString("customerPhoneNumber"));
                customer.setTotalAmount(Integer.parseInt(resultSet.getString("totalAmount")));
                customer.setRemarks(resultSet.getString("remarks"));
                customer.setAddress(resultSet.getString("address"));
                onecustomer.add(customer);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return onecustomer;
    }

    //更新顾客基本信息
    public static void renewcustomerinfo(String id, String gen, String name, String bir,
                                         String ph, String ad, String other){
        Connection connection = null;
        Statement st;
        try {
            connection = DataBase.getConnection();
            st = connection.createStatement();
            st.execute("update customers set customerGender='"+gen+"'where customerIDCard ='"+id+"'");
            st.execute("update customers set customerName='"+name+"'where customerIDCard ='"+id+"'");
            st.execute("update customers set customerBirthday='"+bir+"'where customerIDCard ='"+id+"'");
            st.execute("update customers set customerPhoneNumber='"+ph+"'where customerIDCard ='"+id+"'");
            st.execute("update customers set address='"+ad+"'where customerIDCard ='"+id+"'");
            st.execute("update customers set remarks='"+other+"'where customerIDCard ='"+id+"'");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    //修改顾客密码
    public static boolean renewcustomerpassword(String id, String oldpassword, String newpassword) {
        ResultSet resultSet = null;
        Statement st;
        try {
            Connection connection = DataBase.getConnection();

            // 使用 PreparedStatement 来防止 SQL 注入攻击
            String query = "SELECT * FROM customers WHERE customerIDCard=? AND customerpassword=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, id);  // 设置第一个参数（身份证号）
            preparedStatement.setString(2, oldpassword);  // 设置第二个参数（旧密码）
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                String updateQuery = "UPDATE customers SET customerpassword=? WHERE customerIDCard=?";
                PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                updateStatement.setString(1, newpassword);
                updateStatement.setString(2, id);
                int rowsAffected = updateStatement.executeUpdate();  // 执行更新操作

                if (rowsAffected > 0) {
                    return true;  // 更新成功
                } else {
                    return false;  // 更新失败
                }
            } else {
                return false;  // 身份证号和旧密码不匹配
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    //顾客忘记密码
    public static boolean forgetcustomerpassword(String idcard, String phonenumber, String password){

        ResultSet resultSet = null;
        Statement st;
        try {
            Connection connection = DataBase.getConnection();

            // 使用 PreparedStatement 来防止 SQL 注入攻击
            String query = "SELECT * FROM customers WHERE customerIDCard=? AND customerPhoneNumber=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, idcard);  // 设置第一个参数（身份证号）
            preparedStatement.setString(2, phonenumber);  // 设置第二个参数
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                String updateQuery = "UPDATE customers SET customerpassword=? WHERE customerIDCard=?";
                PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                updateStatement.setString(1, password);
                updateStatement.setString(2, idcard);
                int rowsAffected = updateStatement.executeUpdate();  // 执行更新操作

                return rowsAffected > 0;  // 更新成功或失败
            } else {
                return false;  // 失败
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    //车辆的空与非空数量
    public static ArrayList<Integer> getNumofCar(String carType) throws Exception {

        ArrayList<Integer>list =new ArrayList<Integer>() ;
        Connection connection = DataBase.getConnection();
        PreparedStatement preparedStatement1 = connection.prepareStatement(
                "SELECT COUNT(*) FROM cartypeandprice WHERE carType = ? AND carStatus = '空'");
        PreparedStatement preparedStatement2 = connection.prepareStatement(
                "SELECT COUNT(*) FROM cartypeandprice WHERE carType = ? AND carStatus = '非空'");
        try{
            preparedStatement1.setString(1, carType);
            preparedStatement2.setString(1, carType);
            ResultSet resultSet1 = preparedStatement1.executeQuery();
            ResultSet resultSet2 = preparedStatement2.executeQuery();
            try  {
                if (resultSet1.next()) {
                    list.add(resultSet1.getInt(1));//list[0]  未租出
                }

                if (resultSet2.next()) {
                    list.add(resultSet2.getInt(1));//list[1]  已租出
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }

        return list;
    }

    //获取已退车的orderview
    public static OrderView getFullOrderViews(String carid) {
        ArrayList<OrderView> fullOrderViews = new ArrayList<OrderView>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection =  DataBase.getConnection();

            preparedStatement = connection.prepareStatement("select * from orderviews where carNumber='"+carid+"' and orderStatus='已退车'");
            //获取结果数据集
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderView orderView = new OrderView();
                orderView.setOrderNumber(resultSet.getString("orderNumber"));
                orderView.setCustomer(resultSet.getString("customerName"));
                orderView.setCarNumber(resultSet.getString("carNumber"));
                orderView.setCarType(resultSet.getString("carType"));
                orderView.setBelong(resultSet.getString("belong"));
                orderView.setOrderTime(resultSet.getDate("orderTime"));
                orderView.setCheckInTime(resultSet.getDate("checkInTime"));
                orderView.setCheckOutTime(resultSet.getDate("checkOutTime"));
                int days = (int)((orderView.getCheckOutTime().getTime() - orderView.getCheckInTime().getTime()) / 1000 / 1L / 24);
                orderView.setDays(days);
                orderView.setCustomerPhoneNumber(resultSet.getString("customerPhoneNumber"));
                orderView.setPrice(resultSet.getInt("totalMoney"));
                orderView.setOrderStatus(resultSet.getString("orderStatus"));
                return orderView;

            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return null;
    }

    //删除waiter
    public static void deleteWaiter(Waiter waiter){
        Connection connection = null;
        Statement statement = null;
        try {
            connection =  DataBase.getConnection();
            statement = connection.createStatement();
            statement.execute("DELETE  FROM waiter where waiterID='" + waiter.getWaiterID() + "'");

        } catch(Exception exception) {
            exception.printStackTrace();
        }
    }

    //更新waiter
    public static void editWaiter(Waiter waiter) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection =  DataBase.getConnection();
            statement = connection.createStatement();
            statement.execute("UPDATE waiter SET waiterIDCard='" + waiter.getWaiterIDCard() + "' where waiterID ='"+waiter.getWaiterID() +"'");
            statement.execute("UPDATE waiter SET waiterName='" + waiter.getWaiterName() + "' where waiterID ='"+waiter .getWaiterID() +"'");
            statement.execute("UPDATE waiter SET waiterBirthday='" + waiter.getWaiterBirthday() + "' where waiterID ='"+waiter.getWaiterID() +"'");
            statement.execute("UPDATE waiter SET waiterPassword='" + waiter.getWaiterPassword() + "' where waiterID ='"+waiter.getWaiterID() +"'");
            statement.execute("UPDATE waiter SET waiterJoinDate='" + waiter.getWaiterJoinDate() + "' where waiterID ='"+waiter.getWaiterID() +"'");
            statement.execute("UPDATE waiter SET waiterPhoneNumber='" + waiter.getWaiterPhoneNumber() + "'where waiterID ='"+waiter.getWaiterID() +"'");
            statement.execute("UPDATE waiter SET remarks='" + waiter.getRemarks() + "'where waiterID ='"+waiter.getWaiterID() +"'");

        } catch(Exception exception) {
            exception.printStackTrace();
        }
    }

    //使用incomeView
    public static ArrayList<InComeView> getInComeView(){

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        Waiter waiter =null;
        ArrayList<InComeView>inComeViews =new ArrayList<InComeView>();
        try {
            connection =  DataBase.getConnection();
            String sql = "select * from incomeView";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                inComeViews.add(
                        new InComeView(resultSet.getDate("co").toString() ,resultSet.getInt("tot"),
                                resultSet.getInt("num"))
                );
            }
        } catch(Exception exception) {
            exception.printStackTrace();
        }

        return inComeViews;
    }

    //根据waiterid 来返回waiter
    public  static Waiter getWaiter(String waiterID){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        Waiter waiter =null ;

        try {
            connection =  DataBase.getConnection();
            String sql ="select * from waiter where waiterID='"+waiterID+"'" ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                waiter =new Waiter(resultSet.getString("waiterID")
                        ,resultSet.getString("waiterName")
                        ,resultSet.getDate("waiterBirthday")
                        ,resultSet.getString("waiterIDCard")
                        ,resultSet.getString("waiterPassword")
                        ,resultSet.getDate("waiterJoinDate")
                        ,resultSet.getString("waiterPhoneNumber")
                        ,resultSet.getString("remarks")) ;
                return waiter ;
            }
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return null ;
    }

    //查询所有车的信息
    public static  ArrayList<CarTypeAndPrice> getAllCarsInfo(String s ,String search ,String search1) {

        ArrayList<CarTypeAndPrice>Cars = new ArrayList<CarTypeAndPrice>() ;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql  ;
            if(!search.equals("")){//车辆号不为空
                sql ="select * from cartypeandprice where carNumber like '%"+search+"%'" ;
            } else if (!search1.equals("")) {//车辆名称不为空
                sql ="select * from cartypeandprice where carType like '%"+search1+"%'" ;
            } else if(s.equals("")||s.equals("任意")) {//车状态任意
                sql="select * from cartypeandprice " ;
            }
            else{//查找状态为s的车
                sql="select * from cartypeandprice where carStatus='"+s+"'";
            }
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Cars.add(new CarTypeAndPrice(
                        resultSet.getString("carNumber"),
                        resultSet.getString("carType"),
                        resultSet.getString("carbrand"),
                        resultSet.getInt("price"),
                        resultSet.getString("desc"),
                        resultSet.getString("carStatus"),
                        resultSet.getString("belong"),
                        resultSet.getString("state")));
            }
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return Cars ;
    }

    //寻找非空的车辆
    public static  ArrayList<String> searchFullCars() {

        ArrayList<String>fullCars =new ArrayList<String>() ;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select carNumber from cartypeandprice where carStatus='非空' " ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                fullCars.add(resultSet.getString("carNumber"));
            }
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return fullCars ;
    }
    //寻找某个客户需要退订的车
    public static ArrayList<String> SearchOneCustomerCar( String customer){
        ArrayList<String>Car =new ArrayList<String>() ;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select carNumber from orderviews where customerPhoneNumber ='" + customer + "' and orderStatus = '已租车'";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Car.add(resultSet.getString("carNumber"));
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return Car;
    }

    //查询空的车辆
    public static  ArrayList<String> searchEmptyCars(String cartype) {
        ArrayList<String>emptyCars =new ArrayList<String>() ;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select carNumber from cartypeandprice where carStatus='空' and carType='"+cartype+"'" ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                emptyCars.add(resultSet.getString("carNumber"));
            }
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return emptyCars ;
    }

    //查询所有车辆类型价格信息
    public static ArrayList<CarTypeAndPrice> getAllCars() {
        ArrayList<CarTypeAndPrice> allCars = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        try {
            connection = DataBase.getConnection();
            preparedStatement = connection.prepareStatement("SELECT * FROM cartypeandprice where state='可用'");
            rs = preparedStatement.executeQuery();

            Set<String> typeSet = new HashSet<>();//确保只有一个cartype类型
            while (rs.next()) {
                String type = rs.getString("carType");
                if (!typeSet.contains(type)) {
                    CarTypeAndPrice carTypeAndPrice = new CarTypeAndPrice(
                            rs.getString("carNumber"),
                            rs.getString("carType"),
                            rs.getString("carbrand"),
                            rs.getInt("price"),
                            rs.getString("desc"),
                            rs.getString("carStatus"),
                            rs.getString("belong"),
                            rs.getString("state")
                    );
                    allCars.add(carTypeAndPrice);
                    typeSet.add(type);//加入品牌，同时用if来判断set中是否已有了cartype类型
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving car information", e);
        }

        return allCars;
    }

    //查询所有订单信息
    public static ArrayList<Order> getAllOrders() {
        ArrayList<Order> allOrders = new ArrayList<Order>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection =  DataBase.getConnection();
            preparedStatement = connection.prepareStatement(GCON.SQL_ALL_ORDERS);
            //获取结果数据集
            resultSet = preparedStatement.executeQuery();
            //获取数据库中订单信息
            while (resultSet.next()) {
                Order orderItem = new Order(resultSet.getString("orderNumber"),
                        resultSet.getString("orderStatus"),
                        resultSet.getString("customerIDCard"),
                        resultSet.getString("carNumber"),
                        resultSet.getDate("checkInTime"),
                        resultSet.getDate("checkOutTime"),
                        resultSet.getInt("totalMoney"),
                        resultSet.getString("waiterID"),
                        resultSet.getString("address"),
                        resultSet.getDate("orderTime"));
                allOrders.add(orderItem);
            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return allOrders;
    }

    //查询系统管理员信息
    public static ArrayList<SystemAdministrator> getAllSystemAdmin() {
        ArrayList<SystemAdministrator> allSystemAdmins = new ArrayList<SystemAdministrator>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection =  DataBase.getConnection();
            if (connection != null) {
                System.out.println("查询---数据库连接成功");
                preparedStatement = connection.prepareStatement(GCON.SQL_ALL_ADMINS);
            }

            //获取结果数据集
            resultSet = preparedStatement.executeQuery();
            //获取数据库中订单信息
            int i = 0;
            while (resultSet.next()) {
                SystemAdministrator systemAdministrator = new SystemAdministrator(resultSet.getString("userID"),
                        resultSet.getString("userName"), resultSet.getString("userPassword"));
                allSystemAdmins.add(systemAdministrator);
                System.out.println("userID" + resultSet.getString("userID") + "\n" +
                        resultSet.getString("userName") + "\n" +
                        "userPassword" + resultSet.getString("userPassword"));
                i++;
            }
            System.out.println("i = " + i);

        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return allSystemAdmins;
    }

    //建立管理员
    public static void insertSystemAdministrator(SystemAdministrator systemAdministrator) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection =  DataBase.getConnection();
            if (connection != null) {
                System.out.println("插入---数据库连接成功");
            }
            statement = connection.createStatement();

            statement.execute("INSERT INTO systemAdministrator VALUES('" +
                    systemAdministrator.getUserID() + "', '" +
                    systemAdministrator.getUserName() + "', '" +
                    systemAdministrator.getUserPassword() + "');");
        } catch(Exception exception) {
            exception.printStackTrace();
        }
    }

    //查询服务员
    public static ArrayList<Waiter> getAllWaiters() {
        ArrayList<Waiter> allWaiters = new ArrayList<Waiter>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection =  DataBase.getConnection();
            if (connection != null) {
                System.out.println("查询---数据库连接成功");
                preparedStatement = connection.prepareStatement(GCON.SQL_ALL_WAITERS);
            }
            //获取结果数据集
            resultSet = preparedStatement.executeQuery();
            //获取数据库中订单信息
            while (resultSet.next()) {
                Waiter waiter = new Waiter(resultSet.getString("waiterID"),
                        resultSet.getString("waiterName"),
                        resultSet.getDate("waiterBirthday"),
                        resultSet.getString("waiterIDCard"),
                        resultSet.getString("waiterPassword"),
                        resultSet.getDate("waiterJoinDate"),
                        resultSet.getString("waiterPhoneNumber"),
                        resultSet.getString("remarks"));
                allWaiters.add(waiter);
            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return allWaiters;
    }

    //所有顾客的预定订单
    public static ArrayList<OrderView> getAllOrderViews(String orderStatus) {
        ArrayList<OrderView> allOrderViews = new ArrayList<OrderView>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection =  DataBase.getConnection();
            if (orderStatus.equals("")) {
                preparedStatement = connection.prepareStatement("select * from orderviews");
            } else {
                preparedStatement = connection.prepareStatement("select * from orderviews where orderStatus = '" + orderStatus + "'");
            }

            //获取结果数据集
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderView orderView = new OrderView();
                orderView.setOrderNumber(resultSet.getString("orderNumber"));
                orderView.setCustomer(resultSet.getString("customerName"));
                orderView.setCarNumber(resultSet.getString("carNumber"));
                orderView.setCarType(resultSet.getString("carType"));
                orderView.setBelong(resultSet.getString("belong"));
                orderView.setOrderTime(resultSet.getDate("orderTime"));
                orderView.setCheckInTime(resultSet.getDate("checkInTime"));
                orderView.setCheckOutTime(resultSet.getDate("checkOutTime"));
                int days = (int)((orderView.getCheckOutTime().getTime() - orderView.getCheckInTime().getTime())/1000/60/60/24);
                orderView.setDays(days);
                orderView.setCustomerPhoneNumber(resultSet.getString("customerPhoneNumber"));
                orderView.setPrice(resultSet.getInt("totalMoney"));
                orderView.setOrderStatus(resultSet.getString("orderStatus"));
                allOrderViews.add(orderView);
            }
            return allOrderViews;
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return allOrderViews;
    }


    //一个顾客的订单
    public static ArrayList<OrderView> getoneOrderViews( String ph) {
        ArrayList<OrderView> oneOrderViews = new ArrayList<OrderView>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection =  DataBase.getConnection();
            preparedStatement = connection.prepareStatement("select * from orderviews where customerPhoneNumber='"+ph+"'");
            //获取结果数据集
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderView orderView = new OrderView();
                orderView.setOrderNumber(resultSet.getString("orderNumber"));
                orderView.setCustomer(resultSet.getString("customerName"));
                orderView.setCarNumber(resultSet.getString("carNumber"));
                orderView.setCarType(resultSet.getString("carType"));
                orderView.setBelong(resultSet.getString("belong"));
                orderView.setOrderTime(resultSet.getDate("orderTime"));
                orderView.setCheckInTime(resultSet.getDate("checkInTime"));
                orderView.setCheckOutTime(resultSet.getDate("checkOutTime"));
                int days = (int)((orderView.getCheckOutTime().getTime() - orderView.getCheckInTime().getTime())/1000/60/60/24);
                orderView.setDays(days);
                orderView.setCustomerPhoneNumber(resultSet.getString("customerPhoneNumber"));
                orderView.setPrice(resultSet.getInt("totalMoney"));
                orderView.setOrderStatus(resultSet.getString("orderStatus"));
                oneOrderViews.add(orderView);
            }
            return oneOrderViews;
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return oneOrderViews;
    }
    //查找汽车
    public static ArrayList<CarTypeAndPrice> searchCar(String s1 ,String s2,String s3){
        //{"单人","双人","任意"}  ;//品牌
        // {"0-5","5-9","任意"}  ;//座位类型
        //{"0-200","200-300","300-400","400-600","任意"}  ;//价格
        ArrayList<CarTypeAndPrice> allCars =new ArrayList<CarTypeAndPrice>() ;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        if(s1.equals("任意")|| s1.equals(""))
            s1="" ;
        if(s2.equals("任意")|| s2.equals("")) {
            s2="0-100";
        }
        if(s3.equals("任意")|| s3.equals("")) {
            s3="0-1000";
        }
        String[] arr2 = s2.split("-") ; // 几座切片
        String[] arr3 = s3.split("-") ; // 价格切片

        try {
            connection =  DataBase.getConnection();
            preparedStatement = connection.prepareStatement(
                    "select * from cartypeandprice where carbrand like '%"+s1+"%' and state='可用' and CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(`desc`, '座', 1), '|', -1) AS UNSIGNED) BETWEEN "+arr2[0]+" and " +arr2[1]+
                            " and price BETWEEN "+arr3[0]+" and "+arr3[1]);
            //获取结果数据集
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                CarTypeAndPrice cartypeandprice= new CarTypeAndPrice(
                        resultSet.getString("carNumber"),
                        resultSet.getString("carType"),
                        resultSet.getString("carbrand"),
                        resultSet.getInt("price"),
                        resultSet.getString("desc"),
                        resultSet.getString("carStatus"),
                        resultSet.getString("belong"),
                        resultSet.getString("state")
                ) ;
                allCars.add(cartypeandprice);
            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }

        return allCars ;
    }

    //查询所有汽车的品牌
    public static ArrayList <String> searchCarbrand() {

// 获取所有的车品牌，不重复的品牌
        Set<String> brandSet = new HashSet<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;


        try {
            connection =  DataBase.getConnection();
            preparedStatement = connection.prepareStatement("SELECT carbrand FROM cartypeandprice");
            rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String brand = rs.getString("carbrand");
                brandSet.add(brand);
            }

        } catch (Exception e) { // 处理异常
            throw new RuntimeException(e);
        }

        ArrayList<String> brandList = new ArrayList<>(brandSet);

        return brandList;
    }
    //查询某品牌的汽车
    public static ArrayList<String> getOneBrandCars(String brand) {
        ArrayList<String> onebrandcars = new ArrayList<>();

        try {Connection connection = DataBase.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT carType FROM cartypeandprice WHERE carbrand = ?");
            preparedStatement.setString(1, brand);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                String carType = resultSet.getString("carType");
                onebrandcars.add(carType);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return onebrandcars;
    }
    //更新续费订单
    public static int getRenewNum(){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select count(*) from timeextension " ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return resultSet.getInt("count(*)");

            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }

        return 1 ;
    }

    //更新退车时间数据
    public static void  updateNewDate(Date newdate ,String orderNumber){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection =  DataBase.getConnection();
            preparedStatement = connection.prepareStatement(
                    "update orders set checkOutTime='"+newdate+"' where orderNumber='"+orderNumber+"'");
            preparedStatement.execute();
        } catch(Exception exception) {
            exception.printStackTrace();
        }
    }

    //增加订单
    public static void  addRenew(TimeExtension renew){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection =  DataBase.getConnection();
            preparedStatement = connection.prepareStatement("insert into timeextension values("
                    +renew.getOperatingID()+",'"+renew.getOrderNumber()+"','"+renew.getOldExpiryDate()+"','"
                    +renew.getNewExpiryDate()+"',"+renew.getAddedMoney()+")");
            preparedStatement.execute();
            System.out.println("---++++++++++续费订单插入");
        } catch(Exception exception) {
            exception.printStackTrace();
        }
    }

    //获取某类型车的价格
    public static double getPrice(String type ){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection =  DataBase.getConnection();
            String sql ="select price from cartypeandprice where carType='"+type+"'" ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return resultSet.getDouble("price");
            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return 1.00 ;
    }

    //获取车价格
    public static double getCarPrice(String carid){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select carType from cartypeandprice where carNumber='"+carid+"'";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            if(resultSet.next()){
                return getPrice(resultSet.getString("carType")) ;
            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }

        return 0;
    }

    //将订单号为orderNumber的车设置为已退车
    public static void checkOutCar(String orderNumber){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="update orders set orderStatus='已退车' where orderNumber='"+orderNumber+"'" ;
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.execute();
        } catch(Exception exception) {
            exception.printStackTrace();
        }

    }

    //获取已租的车
    public static ArrayList<Order> getOrder(String carid){
        ArrayList<Order> orders = new ArrayList<Order>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select * from orders where carNumber='"+carid+"' and orderStatus='已租车'" ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while(resultSet.next()){
                Order order=new Order();
                order.setOrderNumber(resultSet.getString("orderNumber"));
                order.setOrderStatus(resultSet.getString("orderStatus"));
                order.setCustomerIDCard(resultSet.getString("customerIDCard"));
                order.setCarNumber(resultSet.getString("carNumber"));
                order.setCheckInTime(resultSet.getDate("checkInTime"));
                order.setCheckOutTime(resultSet.getDate("checkOutTime"));
                order.setTotalMoney(resultSet.getInt("totalMoney"));
                order.setWaiterID(resultSet.getString("waiterID"));
                order.setAddress(resultSet.getString("address"));
                order.setOrderTime( resultSet.getDate("orderTime")) ;
                orders.add(order);
            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return orders ;
    }

    //获取订购数量
    public static int getOrderNum(){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select count(*) from orders " ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return resultSet.getInt("count(*)");

            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }

        return 1 ;
    }


    //查找vip等级
    public static int searchVIPlevel(String id){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select customerVIPLevel from customers where customerIDCard=' "+id+"'" ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return resultSet.getInt("customerVIPLevel");
            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }

        return 1 ;
    }


    //查找折扣
    public static double searchDiscount(String id ){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int level =searchVIPlevel(id) ; //该用户的会员等级
        try {
            connection =  DataBase.getConnection();
            String sql ="select discount from viplevel where level="+level ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return resultSet.getDouble("discount") ;
            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }

        return 1.00 ;
    }


    //判断该用户是否存在
    public static  boolean isIDexists(String id ) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select * from Customers where customerIDCard='"+id+"'" ;
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return true ;
            }
            return false ;
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return false ;
    }

    //插入一条订单信息
    public static void insertOrder(Order order) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection =  DataBase.getConnection();
            statement = connection.createStatement();
            statement.execute("INSERT INTO orders VALUES('" +
                    order.getOrderNumber() + "','" +
                    order.getOrderStatus() + "','" +
                    order.getCustomerIDCard() + "','" +
                    order.getCarNumber() + "','" +
                    order.getCheckInTime() + "','" +
                    order.getCheckOutTime() + "'," +
                    order.getTotalMoney() + ",'" +
                    order.getWaiterID()+"','"+
                    order.getAddress() + "','"+
                    order.getOrderTime()+
                    "');");

        } catch(Exception exception) {
            exception.printStackTrace();
        }

    }

    //查询续费订单(timeextension tt, orders od, customers ct)
    public static ArrayList<ExtensionOrderView> getAllTimeExtensionOrders() {
        ArrayList<ExtensionOrderView> allTimeExtensionOrders = new ArrayList<ExtensionOrderView>() ;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            preparedStatement = connection.prepareStatement("SELECT * FROM timeExtensionOrdersView");
            //获取结果数据集
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ExtensionOrderView extensionOrderView = new ExtensionOrderView();
                extensionOrderView.setOrderNumber(resultSet.getString("orderNumber"));
                extensionOrderView.setCustomer(resultSet.getString("customerName"));
                extensionOrderView.setCarNumber(resultSet.getString("carNumber"));
                extensionOrderView.setOldDate(resultSet.getDate("oldExpiryDate"));
                extensionOrderView.setNewDate(resultSet.getDate("newExpiryDate"));
                extensionOrderView.setAddedMoney(resultSet.getInt("addedMoney"));
                extensionOrderView.setCustomerPhoneNumber(resultSet.getString("customerPhoneNumber"));
                extensionOrderView.setCheckInTime(resultSet.getDate("checkInTime"));
                allTimeExtensionOrders.add(extensionOrderView);
            }
        } catch(Exception exception) {
            exception.printStackTrace();
        }

        return allTimeExtensionOrders;
    }

    //插入员工
    public static void insertWaiter(Waiter waiter) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection =  DataBase.getConnection();
            statement = connection.createStatement();
            statement.execute("INSERT INTO waiter VALUES('" +
                    waiter.getWaiterID() + "', '" +
                    waiter.getWaiterName() + "', '" +
                    waiter.getWaiterBirthday() + "', '" +
                    waiter.getWaiterIDCard() + "', '" +
                    waiter.getWaiterPassword() + "', '" +
                    waiter.getWaiterJoinDate() + "', '" +
                    waiter.getWaiterPhoneNumber() + "', '" +
                    waiter.getRemarks() + "');");

        } catch(Exception exception) {
            exception.printStackTrace();
        }
    }

    //租车商操作
    //添加新的车型和品牌
    public static void insertCarType(CarTypeAndPrice carTypeAndPrice) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = DataBase.getConnection();
            String insertSql = "INSERT INTO cartypeandprice VALUES (?, ?, ?, ?, ?, ?, ?,?)";
            preparedStatement = connection.prepareStatement(insertSql);
            preparedStatement.setString(1, carTypeAndPrice.getCarnumber());
            preparedStatement.setString(2, carTypeAndPrice.getCarType());
            preparedStatement.setString(3, carTypeAndPrice.getCarbrand());
            preparedStatement.setInt(4, carTypeAndPrice.getPrice());
            preparedStatement.setString(5, carTypeAndPrice.getDesc());
            preparedStatement.setString(6, carTypeAndPrice.getCarStatus());
            preparedStatement.setString(7,carTypeAndPrice.getBelong());
            preparedStatement.setString(8,carTypeAndPrice.getState());
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    //更新自己的车
    public static void renewbusinesscar(String carNumber, String carBrand, String carType,String carPrice,String carDesc,String carstate){
        Connection connection = null;
        Statement st;
        try {
            connection = DataBase.getConnection();
            st = connection.createStatement();
            st.execute("update cartypeandprice set carBrand='"+carBrand+"'where carNumber ='"+carNumber+"'");
            st.execute("update cartypeandprice set carType='"+carType+"'where carNumber ='"+carNumber+"'");
            st.execute("update cartypeandprice set price='"+carPrice+"'where carNumber ='"+carNumber+"'");
            st.execute("update cartypeandprice set `desc`='"+carDesc+"'where carNumber ='"+carNumber+"'");
            st.execute("update cartypeandprice set state='"+carstate+"'where carNumber ='"+carNumber+"'");
            st.execute("update photos set photoname='"+carBrand+"_"+carType+"'where carNumber ='"+carNumber+"'");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    //租车商自己订单查询
    public static ArrayList<OrderView> getViews( String idname) {
        ArrayList<OrderView> oneOrderViews = new ArrayList<OrderView>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection =  DataBase.getConnection();
            preparedStatement = connection.prepareStatement("select * from orderviews where belong='"+idname+"'");
            //获取结果数据集
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderView orderView = new OrderView();
                orderView.setOrderNumber(resultSet.getString("orderNumber"));
                orderView.setCustomer(resultSet.getString("customerName"));
                orderView.setCarNumber(resultSet.getString("carNumber"));
                orderView.setCarType(resultSet.getString("carType"));
                orderView.setOrderTime(resultSet.getDate("orderTime"));
                orderView.setCheckInTime(resultSet.getDate("checkInTime"));
                orderView.setCheckOutTime(resultSet.getDate("checkOutTime"));
                int days = (int)((orderView.getCheckOutTime().getTime() - orderView.getCheckInTime().getTime())/1000/60/60/24);
                orderView.setDays(days);
                orderView.setCustomerPhoneNumber(resultSet.getString("customerPhoneNumber"));
                orderView.setPrice(resultSet.getInt("totalMoney"));
                orderView.setOrderStatus(resultSet.getString("orderStatus"));
                oneOrderViews.add(orderView);
            }
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        System.out.println("oneOrderViews大小:"+oneOrderViews.size());
        return oneOrderViews;
    }
    //租车商自己信息
    public static ArrayList<Business> searchonebusiness(String bs){
        ArrayList<Business> onebusiness= new ArrayList<Business>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = DataBase.getConnection();
            preparedStatement = connection.prepareStatement("select * from business where businessid='"+bs +"'");
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                Business business = new Business();
                    business.setBusinessid(resultSet.getString("businessid"));
                    business.setBusinessidcard(resultSet.getString("businessidcard"));
                    business.setBirthday(Date.valueOf(resultSet.getString("birthday")));
                    business.setBusinessname(resultSet.getString("businessname"));
                    business.setGender(resultSet.getString("gender"));
                onebusiness.add(business);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return onebusiness;
    }
    //更新租车商基本信息
    public static void renewbusinessinfo(String id, String idcard, String bir,String name,String gen){
        Connection connection = null;
        Statement st;
        try {
            connection = DataBase.getConnection();
            st = connection.createStatement();
            st.execute("update business set businessid='"+id+"'where businessidcard ='"+idcard+"'");
            st.execute("update business set birthday='"+bir+"'where businessidcard ='"+idcard+"'");
            st.execute("update business set businessname='"+name+"'where businessidcard ='"+idcard+"'");
            st.execute("update business set gender='"+gen+"'where businessidcard ='"+idcard+"'");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    //更新租车商密码
    public static boolean renewbusinesspassword(String id, String oldpassword, String newpassword) {
        ResultSet resultSet = null;
        Statement st;
        try {
            Connection connection = DataBase.getConnection();

            // 使用 PreparedStatement 来防止 SQL 注入攻击
            String query = "SELECT * FROM business WHERE businessidcard=? AND businesspassword=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, id);  // 设置第一个参数（身份证号）
            preparedStatement.setString(2, oldpassword);  // 设置第二个参数（旧密码）
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                String updateQuery = "UPDATE business SET businesspassword=? WHERE businessidcard=?";
                PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                updateStatement.setString(1, newpassword);
                updateStatement.setString(2, id);
                int rowsAffected = updateStatement.executeUpdate();  // 执行更新操作

                if (rowsAffected > 0) {
                    return true;  // 更新成功
                } else {
                    return false;  // 更新失败
                }
            } else {
                return false;  // 身份证号和旧密码不匹配
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    //租车商忘记密码
    public static boolean forgetmerchantpassword(String idcard, String phonenumber, String password){

        ResultSet resultSet = null;
        Statement st;
        try {
            Connection connection = DataBase.getConnection();

            // 使用 PreparedStatement 来防止 SQL 注入攻击
            String query = "SELECT * FROM business WHERE businessidcard=? AND businessid=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, idcard);  // 设置第一个参数（身份证号）
            preparedStatement.setString(2, phonenumber);  // 设置第二个参数
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                String updateQuery = "UPDATE business SET businesspassword=? WHERE businessidcard=?";
                PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                updateStatement.setString(1, password);
                updateStatement.setString(2, idcard);
                int rowsAffected = updateStatement.executeUpdate();  // 执行更新操作

                return rowsAffected > 0;  // 更新成功或失败
            } else {
                return false;  // 失败
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    //查找自己的车
    public static  ArrayList<CarTypeAndPrice> getCarsInfo(String belong) {

        ArrayList<CarTypeAndPrice>Cars = new ArrayList<CarTypeAndPrice>() ;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection =  DataBase.getConnection();
            String sql ="select * from cartypeandprice where belong ='"+belong +"'";

            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Cars.add(new CarTypeAndPrice(
                        resultSet.getString("carNumber"),
                        resultSet.getString("carType"),
                        resultSet.getString("carbrand"),
                        resultSet.getInt("price"),
                        resultSet.getString("desc"),
                        resultSet.getString("carStatus"),
                        resultSet.getString("belong"),
                        resultSet.getString("state")));
            }
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return Cars ;
    }





    //商户注册
    public static void insertBusiness(Business newbusiness) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection =  DataBase.getConnection();
            statement = connection.createStatement();
            statement.execute("INSERT INTO business VALUES('" +
                    newbusiness.getBusinessid() + "', '" +
                    newbusiness.getBusinesspassword() + "', '" +
                    newbusiness.getBusinessidcard()+ "', '" +
                    newbusiness.getBirthday()+ "', '" +
                    newbusiness.getBusinessname()+ "', '" +
                    newbusiness.getGender() + "');");
        } catch(Exception exception) {
            exception.printStackTrace();
        }
    }
    //查找评论
    public static ArrayList<Comment> searchComment(String carNumber){
        ArrayList<Comment> onecomment= new ArrayList<Comment>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = DataBase.getConnection();
            preparedStatement = connection.prepareStatement("select * from comment where carNumber='"+carNumber +"'");
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                Comment comment = new Comment();
                comment.setCarNumber(resultSet.getString("carNumber"));
                comment.setCarname(resultSet.getString("carname"));
                comment.setBelong(resultSet.getString("belong"));
                comment.setCustomer(resultSet.getString("customer"));
                comment.setTime(resultSet.getString("time"));
                comment.setText(resultSet.getString("text"));
                onecomment.add(comment);
            }
        } catch(Exception exception) {
            exception.printStackTrace();
        }
        return onecomment;
    }
    //添加评论
    public static void insertComment(Comment newcomment){
        Connection connection = null;
        Statement statement = null;
        try {
            connection =  DataBase.getConnection();
            statement = connection.createStatement();
            statement.execute("INSERT INTO comment VALUES('" +
                    newcomment.getCarNumber() + "', '" +
                    newcomment.getCarname() + "', '" +
                    newcomment.getBelong() + "', '" +
                    newcomment.getCustomer()+ "', '" +
                    newcomment.getTime()+ "', '" +
                    newcomment.getText() + "');");
        } catch(Exception exception) {
            exception.printStackTrace();
        }
    }
    //数据库测试
    public static void main(String[] args) {
        ArrayList<Waiter> allWaiters = Query.getAllWaiters();

        StringBuilder jsonWaiterValues = new StringBuilder("");

        StringBuilder jsonData = new StringBuilder("");

        for (int i = 0; i < allWaiters.size(); i++) {
            Waiter w = allWaiters.get(i);

            jsonWaiterValues.append("{\"name\": \"" + w.getWaiterName() + "\", \"value\" :\"姓名\"},\n");
            jsonWaiterValues.append("{\"name\": \"" + w.getWaiterID() + "\", \"value\" :\"WaiterID\"},\n");
            jsonWaiterValues.append("{\"name\": \"" + w.getWaiterPassword() + "\", \"value\" :\"系统密码\"},\n");
            jsonWaiterValues.append("{\"name\": \"" + w.getWaiterPhoneNumber() + "\", \"value\" :\"手机号码\"},\n");
            jsonWaiterValues.append("{\"name\": \"" + w.getWaiterIDCard() + "\", \"value\" :\"身份证号码\"},\n");
            jsonWaiterValues.append("{\"name\": \"" + w.getWaiterBirthday().toString() + "\", \"value\" :\"生日\"},\n");

            jsonData.append("{\n\"name\" : \"" + w.getWaiterName() + "\",\n" + "\"children\" : [\n" + jsonWaiterValues.toString() + "]\n}");

            if (i != allWaiters.size() - 1) {
                jsonData.append(",\n");
            }
            jsonWaiterValues = new StringBuilder("");
        }
        jsonData.insert(0, "{\n" +
                " \"name\": \"员工\",\n" +
                " \"children\": [\n").append("\n]\n}");
        System.out.println(jsonData.toString());
    }


}
