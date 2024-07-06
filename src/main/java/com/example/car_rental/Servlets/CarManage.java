package com.example.car_rental.Servlets;

import javax.servlet.http.HttpServlet;
import com.example.car_rental.config.GCON;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet(name= "CarManage")
public class CarManage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, String[]> map = request.getParameterMap();
        String[] values = map.get("op");
        switch (values[0]) {
            case GCON.SEARCH_CAR:
                response.sendRedirect("/carManagement/searchCar.jsp");
                break;
            case GCON.EDIT_CAR:
                response.sendRedirect("/carManagement/UpdateCar.jsp?op=1");
                break;
            case GCON.ADD_CAR:
                response.sendRedirect("/carManagement/carAdd.jsp?op=2");
                break;
            case GCON.DISPLAY_CAR:
                response.sendRedirect("/carManagement/carDisplay.jsp?op=1");
                break;
        }
    }
}
