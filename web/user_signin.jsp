<%-- 
    Document   : do_login
    Created on : Sep 29, 2020, 6:00:37 PM
    Author     : Lenovo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DBconnection.SQLconnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String mail = request.getParameter("email");
    String pass = request.getParameter("pass");

    System.out.println("Check User name And Password : " + mail + pass);
    Connection con = SQLconnection.getconnection();
    Statement st = con.createStatement();
    Statement sto = con.createStatement();
    try {
        ResultSet rs = st.executeQuery("SELECT * FROM user_reg where email='" + mail + "' AND password='" + pass + "'");
        if (rs.next()) {
            session.setAttribute("uid", rs.getString("id"));
            session.setAttribute("uname", rs.getString("name"));
            session.setAttribute("umail", rs.getString("email"));
            //session.setAttribute("attribute", rs.getString("attribute"));

            response.sendRedirect("User_Home.jsp?Success");
        } else {
            response.sendRedirect("User_login.jsp?Failed");
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>