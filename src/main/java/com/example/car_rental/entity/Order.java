package com.example.car_rental.entity;

import java.sql.Date;

public class Order {

    private String orderNumber;

    private String orderStatus;

    private String customerIDCard;

    private String carNumber;

    private Date checkInTime;

    private Date checkOutTime;

    private Date orderTime;

    private String waiterID;

    private int totalMoney;

    private String address;

    public Order() {

    }

    public Order(String orderNumber,
                 String orderStatus,
                 String customerIDCard,
                 String carNumber,
                 Date checkInTime,
                 Date checkOutTime,
                 int totalMoney,String waiterID
            ,String address,Date orderTime) {
        this.orderNumber = orderNumber;
        this.orderStatus = orderStatus;
        this.customerIDCard = customerIDCard;
        this.carNumber = carNumber;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
        this.totalMoney = totalMoney;
        this.waiterID =waiterID ;
        this.address = address;
        this.orderTime =orderTime ;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public void setWaiterID(String waiterID) {
        this.waiterID = waiterID;
    }

    public String getWaiterID() {
        return waiterID;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getCustomerIDCard() {
        return customerIDCard;
    }

    public void setCustomerIDCard(String customerIDCard) {
        this.customerIDCard = customerIDCard;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
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

    public int getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(int totalMoney) {
        this.totalMoney = totalMoney;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

}