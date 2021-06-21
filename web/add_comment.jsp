 
<%@page import="DBconnection.SQLconnection"%>
<%@page import="java.util.HashMap"%>
<%@page import="SPCT.Sentiment"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%

    String comment = request.getParameter("comment");
    String rating = request.getParameter("rating");
    String pid = request.getParameter("pid");
    String pname =request.getParameter("pname");
    System.out.println("ok");

    String uid = (String) session.getAttribute("uid");
    String uname = (String) session.getAttribute("uname");

    Connection con = SQLconnection.getconnection();

    int poscount = 0, negcount = 0, undefined = 0, neutralcount = 0;

    Sentiment s = new Sentiment();
    float sentiment = s.findSentiment(comment.trim());

    Statement st = con.createStatement();
    int i = st.executeUpdate("insert into comments (uname, uid, pid, pname, sentiment, rating, comment) values ('" + uname + "','" + uid + "','" + pid + "','" + pname + "','" + sentiment + "','" + rating + "','" + comment + "')");
    if (i != 0) {
        out.println("inserted");
        response.sendRedirect("Review.jsp?review_added");
    } else {
        response.sendRedirect("Review.jsp?failed");
        out.println("failed...");
    }

%>