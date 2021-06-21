/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SPCT;

import DBconnection.SQLconnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JAVA-JP
 */
public class User_register extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("username");
            String mail = request.getParameter("email");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String pass = request.getParameter("pass");
           
            
            System.out.println("name" + name + "password" + pass + "address"+ address +  "mail" + mail + "dob" + dob + "cell" + phone);

            Connection conn = SQLconnection.getconnection();
            String message = null;

            try {
                Statement st = conn.createStatement();

                ResultSet rs = st.executeQuery("Select * from user_reg where email ='" + mail + "'");
                if (rs.next()) {

                    response.sendRedirect("User_login.jsp?msg=Mail_Id_Exists");
                } else {

                    String sql = "insert into user_reg(name, email, dob, gender, phone, address, password) values (?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement statement = conn.prepareStatement(sql);
                    statement.setString(1, name);
                    statement.setString(2, mail);
                    statement.setString(3, dob);
                    statement.setString(4, gender);
                    statement.setString(5, phone);
                    statement.setString(6, address);
                    statement.setString(7, pass);
                    
                    int row = statement.executeUpdate();
                    if (row > 0) {

                        response.sendRedirect("User_login.jsp?Register_Success");
                    } else {
                        response.sendRedirect("User_login.jsp?Register_Failed");
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

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
