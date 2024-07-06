package com.example.car_rental.entity;

import java.sql.Date;

public class Customer {
    private String customerIDCard;
    private String customerpassword;

    private String customerGender;

    private String customerName;

    private Date customerBirthday;

    private int customerVIPLevel;

    private String customerPhoneNumber;

    private int totalAmount;

    private String remarks;
    private String address;
    public Customer() {

    }

    public Customer(String customerIDCard,
                    String customerpassword,
                    String customerGender,
                    String customerName,
                    Date customerBirthday,
                    int customerVIPLevel,
                    String customerPhoneNumber,
                    int totalAmount,
                    String remarks,
                    String address) {
        this.customerIDCard = customerIDCard;
        this.customerpassword = customerpassword;
        this.customerGender = customerGender;
        this.customerName = customerName;
        this.customerBirthday = customerBirthday;
        this.customerVIPLevel = customerVIPLevel;
        this.customerPhoneNumber = customerPhoneNumber;
        this.totalAmount = totalAmount;
        this.remarks = remarks;
        this.address = address;

    }

    public String getCustomerIDCard() {return customerIDCard;}

    public void setCustomerIDCard(String customerIDCard) {
        this.customerIDCard = customerIDCard;
    }

    public  String getCustomerpassword(){return customerpassword;}

    public void setCustomerpassword(String customerpassword) {this.customerpassword = customerpassword;}

    public String getCustomerGender() {
        return customerGender;
    }

    public void setCustomerGender(String customerGender) {
        this.customerGender = customerGender;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Date getCustomerBirthday() {
        return customerBirthday;
    }

    public void setCustomerBirthday(Date customerBirthday) {
        this.customerBirthday = customerBirthday;
    }

    public int getCustomerVIPLevel() {
        return customerVIPLevel;
    }

    public void setCustomerVIPLevel(int customerVIPLevel) {
        this.customerVIPLevel = customerVIPLevel;
    }

    public String getCustomerPhoneNumber() {
        return customerPhoneNumber;
    }

    public void setCustomerPhoneNumber(String customerPhoneNumber) {
        this.customerPhoneNumber = customerPhoneNumber;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

}

