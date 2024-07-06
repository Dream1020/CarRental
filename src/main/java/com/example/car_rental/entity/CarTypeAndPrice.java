package com.example.car_rental.entity;

public class CarTypeAndPrice {
    private String carnumber;
    private String carType;
    private String carbrand;
    private int price;

    private String desc;

    private String carStatus;
    private String belong;
    private String state;


    public CarTypeAndPrice(String carnumber,
                           String carType,
                           String carbrand,
                           int price,
                           String desc,
                           String carStatus,
                           String belong,
                           String state) {
        this.carnumber = carnumber;
        this.carType = carType;
        this.carbrand = carbrand;
        this.price = price;
        this.desc = desc;
        this.carStatus=carStatus;
        this.belong = belong;
        this.state=state;
    }

    public CarTypeAndPrice() {

    }


    public String getCarnumber() {
        return carnumber;
    }

    public void setCarnumber(String carnumber) {
        this.carnumber = carnumber;
    }

    public String getCarType() {return carType;}

    public void setCarType(String carType) {
        this.carType = carType;
    }

    public String getCarbrand() {return carbrand;}

    public void setCarbrand(String carbrand) {
        this.carbrand = carbrand;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getCarStatus() {
        return carStatus;
    }

    public void setCarStatus(String carStatus) {
        this.carStatus = carStatus;
    }

    public String getBelong(){return belong;}

    public void setBelong(String belong) {
        this.belong = belong;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}


