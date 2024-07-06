package com.example.car_rental.entity;

public class Carinfo {
    private String carNumber;
    private String carBrand;
    private String carType;
    private String carStatus;
    private String belong;

    public Carinfo(String carNumber,
                   String carType,
                   String carBrand,
                   String carStatus,
                   String belong) {
        this.carNumber = carNumber;
        this.carType = carType;
        this.carBrand = carBrand;
        this.carStatus = carStatus;
        this.belong = belong;
    }

    public Carinfo() {
        this.carStatus = "空";
    }

    public String getCarNumber() {return carNumber;}
    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }
    public String getCarType() {return carType;}
    public void setCarType(String carType) {
        this.carType = carType;
    }
    public String getCarBrand(){return carBrand;}
    public void setCarBrand(String carBrand) {this.carBrand = carBrand;}
    public String getCarStatus() {return carStatus;}

    public void setCarStatus(String carStatus) {
        this.carStatus = carStatus;
    }

    public String getBelong() {
        return belong;
    }

    public void setBelong(String belong) {
        this.belong = belong;
    }
}

