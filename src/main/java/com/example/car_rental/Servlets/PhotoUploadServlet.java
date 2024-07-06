package com.example.car_rental.Servlets;

import com.example.car_rental.config.GCON;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Objects;

@WebServlet(urlPatterns = {"/photoUpload"})
@MultipartConfig(maxFileSize = 52428800)  // 50 MB
public class PhotoUploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("进来了photoUpload");

        String carBrand = (String) request.getSession().getAttribute("carBrand");
        String carType = (String) request.getSession().getAttribute("carType");
        String carNumber = (String) request.getSession().getAttribute("carNumber");
        String photoname = carBrand+"_"+carType;
        String choice = (String) request.getSession().getAttribute("choice");
        String love = (String) request.getSession().getAttribute("love");
        System.out.println("love:"+love);
        System.out.println("photoname:"+photoname);
        System.out.println("carNumber:"+carNumber);
        System.out.println("choice:"+choice);

        try {
            Connection connection = DriverManager.getConnection(GCON.URL, GCON.USERNAME, GCON.PASSWORD);

            // 创建 DiskFileItemFactory 对象
            DiskFileItemFactory factory = new DiskFileItemFactory();

            // 创建 ServletFileUpload 对象
            ServletFileUpload upload = new ServletFileUpload(factory);

            // 解析请求的文件内容
            List<FileItem> items = upload.parseRequest(request);

            if (choice.equals("3")) {
            for (FileItem item : items) {
                if (!item.isFormField() && "file".equals(item.getFieldName())) {
                    // 处理文件上传操作
                    InputStream fileContent = item.getInputStream();

                    // 插入数据库的逻辑
                    PreparedStatement statement = connection.prepareStatement("INSERT INTO photos (carNumber,photoname, photo_data) VALUES (?,?, ?)");
                    statement.setString(1, carNumber);
                    statement.setString(2, photoname);
                    statement.setBlob(3, fileContent);
                    statement.executeUpdate();

                }
            }

                String carPrice = (String) request.getSession().getAttribute("carPrice");
                String carstate = (String) request.getSession().getAttribute("carstate");
                String carDesc = (String) request.getSession().getAttribute("carDesc");
                String belong = (String) request.getSession().getAttribute("belong");

                PreparedStatement preparedStatement= connection.prepareStatement("INSERT INTO cartypeandprice VALUES (?, ?, ?, ?, ?, ?, ?,?)");
                preparedStatement.setString(1, carNumber);
                preparedStatement.setString(2, carType);
                preparedStatement.setString(3, carBrand);
                preparedStatement.setInt(4, Integer.parseInt(carPrice));
                preparedStatement.setString(5, carDesc);
                preparedStatement.setString(6, "空");
                preparedStatement.setString(7,belong);
                preparedStatement.setString(8,carstate);
                preparedStatement.executeUpdate();
                if (love == null){
                    response.sendRedirect("/merchant/lodingcar.jsp?op=3");
                }else if(love.equals("you")){
                    response.sendRedirect("/carManagement/carAdd.jsp?op=4");

                }
            } else if (choice.equals("4")) {
                for (FileItem item : items) {
                    if (!item.isFormField() && "file".equals(item.getFieldName())) {
                        // 处理文件上传操作
                        InputStream fileContent = item.getInputStream();
                        PreparedStatement statement = connection.prepareStatement("UPDATE photos SET photo_data = ?, photoname = ? WHERE carNumber = ?");
                        statement.setBlob(1, fileContent);
                        statement.setString(2, photoname);
                        statement.setString(3, carNumber);
                        statement.executeUpdate();
                    }
                }
                if (love == null) {
                    response.sendRedirect("/merchant/updatecar.jsp?op=6");
                }else if(love.equals("you")) {
                    response.sendRedirect("/carManagement/UpdateCar.jsp?op=6");
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}

