package com.example.car_rental.entity;

public class Comment {
    private String carNumber;
    private String carname;
    private String belong;
    private String customer;
    private String time;
    private String text;
    public Comment(String carNumber,
                   String carname,
                   String belong,
                   String customer,
                   String time,
                   String text){
        this.carNumber=carNumber;
        this.carname=carname;
        this.belong=belong;
        this.customer=customer;
        this.time=time;
        this.text=text;
    }

    public Comment() {

    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }
    public String getCarname() {
        return carname;
    }

    public void setCarname(String carname) {
        this.carname = carname;
    }

    public String getBelong() {
        return belong;
    }
    public void setBelong(String belong) {
        this.belong = belong;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
