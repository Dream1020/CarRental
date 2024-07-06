package com.example.car_rental;

import com.example.car_rental.Servlets.*;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
@ComponentScan(basePackages = "com.example.car_rental.Servlets")

public class CarRentalApplication {

    public static void main(String[] args) {
        SpringApplication.run(CarRentalApplication.class, args);
    }


    @Bean
    public ServletRegistrationBean<LoginServlet> loginServletRegistration() {
        ServletRegistrationBean<LoginServlet> registration = new ServletRegistrationBean<>(new LoginServlet());
        registration.addUrlMappings("/LoginServlet");
        return registration;
    }

    @Bean
    public ServletRegistrationBean<ServiceManage> serviceManageRegistration() {
        ServletRegistrationBean<ServiceManage> registration = new ServletRegistrationBean<>(new ServiceManage());
        registration.addUrlMappings("/ServiceManage");
        return registration;
    }

    @Bean
    public ServletRegistrationBean<CustomerManage> customerManageRegistration() {
        ServletRegistrationBean<CustomerManage> registration = new ServletRegistrationBean<>(new CustomerManage());
        registration.addUrlMappings("/CustomerManage");
        return registration;
    }

    @Bean
    public ServletRegistrationBean<OrderManage> orderManageRegistration() {
        ServletRegistrationBean<OrderManage> registration = new ServletRegistrationBean<>(new OrderManage());
        registration.addUrlMappings("/OrderManage");
        return registration;
    }

    @Bean
    public ServletRegistrationBean<CustomerOrder> customerOrderRegistration() {
        ServletRegistrationBean<CustomerOrder> registration = new ServletRegistrationBean<>(new CustomerOrder());
        registration.addUrlMappings("/CustomerOrder");
        return registration;
    }

    @Bean
    public ServletRegistrationBean<CarManage> carManageRegistration() {
        ServletRegistrationBean<CarManage> registration = new ServletRegistrationBean<>(new CarManage());
        registration.addUrlMappings("/CarManage");
        return registration;
    }

    @Bean
    public ServletRegistrationBean<AdministrationManage> administrationManageRegistration() {
        ServletRegistrationBean<AdministrationManage> registration = new ServletRegistrationBean<>(new AdministrationManage());
        registration.addUrlMappings("/AdministrationManage");
        return registration;
    }
    @Bean
    public ServletRegistrationBean<PhotoUploadServlet> photoUploadServletRegistration(){
        ServletRegistrationBean<PhotoUploadServlet> registration = new ServletRegistrationBean<>(new PhotoUploadServlet());
        registration.addUrlMappings("/photoUpload");
        return registration;
    }
    @Bean
    public ServletRegistrationBean<DisplayPhotoServlet> displayPhotoServletRegistration(){
        ServletRegistrationBean<DisplayPhotoServlet> registration = new ServletRegistrationBean<>(new DisplayPhotoServlet());
        registration.addUrlMappings("/displayPhoto");
        return registration;
    }

}
