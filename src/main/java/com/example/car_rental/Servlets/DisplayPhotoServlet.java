package com.example.car_rental.Servlets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.car_rental.tool.DataBase;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "displayPhoto")
public class DisplayPhotoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String carNumber = request.getParameter("carNumber");
        // 从数据库中获取照片
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DataBase.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT photo_data FROM photos WHERE carNumber = ?");
            statement.setString(1, carNumber);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Blob photoBlob = resultSet.getBlob("photo_data");
                InputStream inputStream = photoBlob.getBinaryStream();
                // 设置响应头信息，告诉浏览器响应的内容类型为图片
                response.setContentType("image/jpeg");

                // 将照片数据写入响应输出流
                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    response.getOutputStream().write(buffer, 0, bytesRead);
                }

                inputStream.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}