package com.example.car_rental.display;

import java.sql.Date;

public class OrderView {
    private String orderNumber;
    private String orderStatus;
    private String customer;
    //        <th>预定车辆</th>
    private String  carNumber;
    //        <th>车的类型</th>
    private String carType;
    private String belong;
    //        <th>预定时间</th>
    private Date orderTime;
    private Date checkInTime;

    private Date checkOutTime;

    private String customerPhoneNumber;

    private int price;


    public String getOrderNumder() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumder) {
        this.orderNumber = orderNumder;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getCustomer() {return customer;}

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getCarNumber() {
        return carNumber;
    }
    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getCarType() { return carType;}

    public void setCarType(String carType) {
        this.carType = carType;
    }

    public String getBelong(){
        return belong;
    }

    public void setBelong(String belong) {
        this.belong = belong;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Date getCheckInTime() {
        return checkInTime;
    }

    public void setCheckInTime(Date checkInTime) {
        this.checkInTime = checkInTime;
    }

    public Date getCheckOutTime() {
        return checkOutTime;
    }

    public void setCheckOutTime(Date checkOutTime) {
        this.checkOutTime = checkOutTime;
    }

    public String getCustomerPhoneNumber() {
        return customerPhoneNumber;
    }

    public void setCustomerPhoneNumber(String customerPhoneNumber) {
        this.customerPhoneNumber = customerPhoneNumber;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }




    //租车天数
    private int days;

    public int getDays() {return days;}

    public void setDays(int days) {
        this.days = days;
    }


    public OrderView() {

    }

    @Override
    public String toString() {
        return "ordernumber" + orderNumber + ", " + days;
    }


}
