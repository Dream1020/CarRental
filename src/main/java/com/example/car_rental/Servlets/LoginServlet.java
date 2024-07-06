package com.example.car_rental.Servlets;

import com.example.car_rental.config.GCON;
import com.example.car_rental.tool.DataBase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("进来了");
        Updateordertime.Updateorder(); // 直接调用更新订单
        String userid =request.getParameter("userid");
        String userpassword =request.getParameter("userpassword") ;
        String admin = request.getParameter("admin") ;
        System.out.println(userid+" "+userpassword+" "+admin);
        String sql = getSqlQueryByAdminType(admin);
        if (sql.isEmpty()) {
            redirectToErrorPage(admin,request, response, "Invalid user type.");
            return;
        }
        System.out.println("验证的账号为："+userid);
        System.out.println("验证的密码为："+userpassword);

        try (Connection conn = DriverManager.getConnection(GCON.URL, GCON.USERNAME, GCON.PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);
            pstmt.setString(2, userpassword);

            try ( ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("caradmin", userid);
                    session.setAttribute("carpassword", userpassword);
                    session.setAttribute("admin",admin);

                    redirectUserByAdminType(admin, userid, response);
                } else {
                    redirectToErrorPage(admin,request, response, "账号和密码不匹配!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectToErrorPage(admin,request, response, "Database error occurred.");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    private String getSqlQueryByAdminType(String admin) {
        switch (admin) {
            case "0":
                return "SELECT * FROM waiter WHERE waiterID=? AND waiterPassword=?";
            case "1":
                return "SELECT * FROM systemadministrator WHERE userID=? AND userPassword=?";
            case "2":
                return "SELECT * FROM customers WHERE customerPhoneNumber=? AND customerpassword=?";
            case "3":
                return "SELECT * FROM business WHERE businessid=? AND businesspassword=?";
            default:
                return "";
        }
    }

    private void redirectUserByAdminType(String admin, String userid, HttpServletResponse response) throws IOException {
        switch (admin) {
            case "0":
                response.sendRedirect("/carManagement/carOrder.jsp?op=1");
                break;
            case "1":
                response.sendRedirect("./systemManagement/waiterShow.jsp?mop=7");
                break;
            case "2":
                response.sendRedirect("./customerorder/carorder.jsp?op=1");
                break;
            case "3":
                response.sendRedirect("./merchant/carretal.jsp");
                break;
        }
    }

    private void redirectToErrorPage(String admin,HttpServletRequest request, HttpServletResponse response, String errorMessage) throws IOException {
        request.getSession().setAttribute("error", errorMessage);
        if (admin.equals("0")||admin.equals("1")) {
            response.sendRedirect("sysindex.jsp");
        } else if (admin.equals("2")||admin.equals("3")) {
            response.sendRedirect("userindex.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
        System.out.println("到这里来了，doGet这里");
    }

}
