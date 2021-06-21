/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SPCT;

import DBconnection.SQLconnection;
import com.oreilly.servlet.MultipartRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author nadanapathy
 */
@WebServlet("/add_product")
@MultipartConfig(maxFileSize = 16177215)
public class add_products extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String pname = request.getParameter("pname");
        String des = request.getParameter("description");
        String price = request.getParameter("price");
        String tag = request.getParameter("tag");
        String ptype = request.getParameter("ptype");
        InputStream inputStream = null;
        Part filePart = request.getPart("photo");
        if (filePart != null) {
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
            inputStream = filePart.getInputStream();
        }

        Connection conn = SQLconnection.getconnection();

        try {
            Statement st = conn.createStatement();
            Statement st1 = conn.createStatement();
            String sql = "INSERT INTO product (pname, des, price, tag, ptype, photo) values (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, pname);
            statement.setString(2, des);
            statement.setString(3, price);
            statement.setString(4, tag);
            statement.setString(5, ptype);

            if (inputStream != null) {
                statement.setBlob(6, inputStream);
            }
            int row = statement.executeUpdate();
            if (row > 0) {
                response.sendRedirect("add_product.jsp?success");
            } else {
                response.sendRedirect("add_product.jsp?Upload_failed");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (Exception e) {
            out.println(e);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
