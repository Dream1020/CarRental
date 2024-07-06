package com.example.car_rental.Servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.car_rental.entity.Waiter;
import com.example.car_rental.tool.Query;

import java.io.IOException;
import java.util.Map;

@WebServlet(name = "AdministrationManage")
public class AdministrationManage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, String[]> map = request.getParameterMap() ;
        String queryString ="" ;
        String[] values =map.get("mop") ; // mop=4/5/6
        int mop = Integer.parseInt( values[0] ) ;
        if(mop==4){
            response.sendRedirect("/systemManagement/waiterAdd.jsp?mop=4");
        }else if(mop==5) {
            response.sendRedirect("/systemManagement/waiterEdit.jsp?mop=5");
        }else if(mop==6){
            response.sendRedirect("/systemManagement/waiterUpdate.jsp?mop=6");
        }else if(mop==7){
            response.sendRedirect("/systemManagement/waiterShow.jsp?mop=7");
        } else if (mop == 10) {//业务数据统计
            response.sendRedirect("/systemManagement/statistics.jsp?mop=10&set=1");
        }
    }
}
