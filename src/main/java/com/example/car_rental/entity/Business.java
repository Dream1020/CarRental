package com.example.car_rental.entity;

import java.sql.Date;

public class Business {
    private String businessid;
    private String businesspassword;
    private String businessidcard;
    private Date birthday;
    private String businessname;
    private String gender;
    public Business(){

    }
    public Business( String businessid,
                     String businesspassword,
                     String businessidcard,
                     Date birthday,
                     String businessname,
                     String gender){
        this.businessid=businessid;
        this.businesspassword=businesspassword;
        this.businessidcard=businessidcard;
        this.birthday = birthday;
        this.businessname=businessname;
        this.gender=gender;
    }

    public String getBusinessid() {
        return businessid;
    }

    public void setBusinessid(String businessid) {
        this.businessid = businessid;
    }

    public String getBusinesspassword() {
        return businesspassword;
    }

    public void setBusinesspassword(String businesspassword) {
        this.businesspassword = businesspassword;
    }

    public String getBusinessidcard() {
        return businessidcard;
    }

    public void setBusinessidcard(String businessidcard) {
        this.businessidcard = businessidcard;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getBusinessname() {
        return businessname;
    }

    public void setBusinessname(String businessname) {
        this.businessname = businessname;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
}
