package com.example.car_rental.Servlets;

import com.example.car_rental.config.GCON;
import com.example.car_rental.tool.DataBase;

import java.sql.*;
import java.util.Calendar;

public class Updateordertime {
    public static void Updateorder() {
        String sql1 = "select checkOutTime from orders where orderStatus ='已租车'";
        String sql2 = "select checkInTime from orders where orderStatus ='预定中'";
        // 获取当前日期
        Calendar calendar = Calendar.getInstance();
        java.util.Date currentDate = calendar.getTime();
        Date date3 = new Date(currentDate.getTime());//现在的日期

        try {
            Connection conn = DriverManager.getConnection(GCON.URL, GCON.USERNAME, GCON.PASSWORD);
            PreparedStatement pstmt1 = conn.prepareStatement(sql1);
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            ResultSet rs1 = pstmt1.executeQuery();
            ResultSet rs2 = pstmt2.executeQuery();
            while (rs1.next()) {
                Date date1 = Date.valueOf(rs1.getString("checkOutTime"));
                if (date3.compareTo(date1) >= 0) {//date3 的日期晚于 date1 的日期，则条件成立
                    //将已租车设置为已退车
                    try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE orders SET orderStatus = '已退车' WHERE orderStatus='已租车' AND checkOutTime=?")) {
                        updateStmt.setDate(1, date1);
                        updateStmt.executeUpdate();
                    }
                }
            }
            while (rs2.next()) {
                Date date2 = Date.valueOf(rs2.getString("checkInTime"));
                if (date3.compareTo(date2) >= 0) {//date3 的日期晚于 date2 的日期，则条件成立
                    //预定中设置为已租车
                    try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE orders SET orderStatus = '已租车' WHERE orderStatus='预定中' AND checkInTime=?")) {
                        updateStmt.setDate(1, date2);
                        updateStmt.executeUpdate();
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    }
