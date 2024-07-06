package com.example.car_rental.config;

public class GCON {

    static String name = "root";
    static String word = "123456";
    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    public static final String URL = "jdbc:mysql://localhost:3306/car?autoReconnect=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8";

    //登录时默认使用system用户验证登录名与密码是否正确
    public static  String USERNAME = name;

    public static  String PASSWORD = word;
    public static final String SYSTEMUSERNAME = name;

    public static final String SYSTEMPASSWORD = word;

    public static final String CARUSERNAME = name;

    public static final String CARPASSWORD = word;
    public static int status = 0 ; //1是系统管理员  0 是员工  2是顾客 3 是商家;
    public static final String SQL_ALL_ORDERS = "SELECT * FROM orders";
    //查询管理员
    public static final String SQL_ALL_ADMINS = "SELECT * FROM systemAdministrator";
    public static final String SQL_ALL_CARS ="SELECT * FROM cartypeandprice" ;
    public static final String SQL_ALL_WAITERS ="SELECT * FROM waiter" ;

    //查询所有续费订单
    public static final String SQL_ALL_TIME_EXTENSION_ORDERS = "SELECT * FROM timeextension";


    //车辆管理
    public static final String SEARCH_CAR = "1";
    public static final String EDIT_CAR = "2";
    public static final String ADD_CAR = "3";
    public static final String DISPLAY_CAR = "4";
}
