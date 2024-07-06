package com.example.car_rental.display;

public class CarCountValue {

    private int emptyNum;

    private int fullNum;

    public CarCountValue(int emptyNum, int fullNum) {
        this.emptyNum = emptyNum;
        this.fullNum = fullNum;
    }

    public int getEmptyNum() {
        return emptyNum;
    }

    public void setEmptyNum(int emptyNum) {
        this.emptyNum = emptyNum;
    }

    public int getFullNum() {
        return fullNum;
    }

    public void setFullNum(int fullNum) {
        this.fullNum = fullNum;
    }
}
