<%-- 
    Document   : User_login.jsp
    Created on : 9 Feb, 2021, 4:43:31 PM
    Author     : JAVA-JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DBconnection.SQLconnection"%>
<%@page import="java.sql.Statement"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>A Sentiment Polarity Categorization Technique</title>
        <meta content="" name="description">
        <meta content="" name="keywords">
        <!-- Favicons -->
        <link href="assets/img/favicon.png" rel="icon">
        <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
        <!-- Vendor CSS Files -->
        <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <!-- Template Main CSS File -->
        <link href="assets/css/style.css" rel="stylesheet">
        <!-- =======================================================
              * Template Name: Sailor - v4.0.0
              * Template URL: https://bootstrapmade.com/sailor-free-bootstrap-theme/
              * Author: BootstrapMade.com
              * License: https://bootstrapmade.com/license/
              ======================================================== -->
    </head>
    <style>
        #customers {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            font-size: 20px;
            border-collapse: collapse;
            width: 100%;
        }

        #customers td, #customers th {
            border: 1px solid white;
            padding: 15px;
        }


        #customers th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: green;
            color: white;
        }
    </style>
    <body>
        <!-- ======= Header ======= -->
        <header id="header" class="fixed-top d-flex align-items-center">
            <div class="container d-flex align-items-center">
                <!-- Uncomment below if you prefer to use an image logo -->
                <!-- <a href="index.html" class="logo me-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->
                <nav id="navbar" class="navbar">
                    <ul>
                        <li><a href="User_Home.jsp">Home</a></li>
                        <li><a href="Search_product.jsp">Search Product</a></li>
                        <li><a class="active" href="Review.jsp">Review</a></li>
                        <li><a href="index.html">Logout</a></li>
                        <i class="bi bi-list mobile-nav-toggle"></i>
                </nav><!-- .navbar -->
            </div>
        </header><!-- End Header -->
        <!-- ======= Hero Section ======= -->
        <section id="hero">
            <div id="heroCarousel" data-bs-interval="5000" class="carousel slide carousel-fade" data-bs-ride="carousel">
                <ol class="carousel-indicators" id="hero-carousel-indicators"></ol>
                <div class="carousel-inner" role="listbox">
                    <!-- Slide 1 -->
                    <div class="carousel-item active" style="background-image: url(assets/img/slide/slide-1.jpg)">
                        <div class="carousel-container">
                            <div class="container">
                                <h2 class="animate__animated animate__fadeInDown">A Sentiment Polarity Categorization Technique
                                    for Online Product Reviews</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section><!-- End Hero -->
        <main id="main">
            <!-- ======= About Section ======= -->
            <section id="about" class="about">
                <div class="container">
                    <div class="row content">
                        <center><h2>Review Product</h2><br><br></center>
                            <%

                                String pid = request.getParameter("pid");
                                String pname = request.getParameter("pname");

                                Connection con = SQLconnection.getconnection();
                                Statement st = con.createStatement();
                                try {
                                    ResultSet rs = st.executeQuery("SELECT * FROM product WHERE id = '" + pid + "'");

                                    while (rs.next()) {
                            %>
                        <div class="col-lg-6">
                            <br><br><br><br>
                            <div style="float: left"><img src="Getimage?id=<%=pid%>" width="300" height="300"><br><%=pname%></div>
                        </div>
                        <div class="col-lg-6">
                            <form action="add_comment.jsp" method="post" role="form">
                                <input type="text" name="pid" hidden="" value="<%=rs.getString("id")%>"><br><br>
                                <input type="text" name="pname" hidden="" value="<%=rs.getString("pname")%>"><br><br>
                                <div class="col-md-6">
                                    <br>
                                    <label>Comments :</label>
                                    <textarea class="form-control-lg" name="comment" id="subject" placeholder="Enter Comments Here!" required="required"></textarea><br><br>
                                </div>
                                <div class="col-md-6">
                                    <br>
                                    <label>Rating :</label>
                                    <input type="number" class="form-control-lg" name="rating" id="subject" placeholder="Enter Number 1 To 5" min="1" max="5" required="required"><br><br>
                                </div>
                                <div class="col-md-6">
                                    <button type="submit" class="btn-primary btn-lg">Submit</button>
                                </div>
                            </form><br><br><br><br><br><br><br><br>
                        </div>
                        <%                                        }
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }

                        %>
                        <div class="col-lg-12">
                            <h2>User Reviews</h2>
                            <form action="" name="showreviews" method="post" style="padding: 20px;">
                                <table id="customers" style="margin-right: 300px">
                                    <th>User Name</th>
                                    <th>Rating</th>
                                    <th>Comments</th>
                                    <th>Sentiment Analysis</th>
                                    <%                                                            double verypos=0, veryneg = 0, poscount = 0, negcount = 0, undefined = 0, neutralcount = 0;
                                        Statement st1 = SQLconnection.getconnection().createStatement();
                                        ResultSet rt1 = st1.executeQuery("select * from comments where pid='" + pid + "' ");
                                        String temp = "";
                                        int i = 1;
                                        while (rt1.next()) {
                                            float sen = Float.parseFloat(rt1.getString("sentiment"));
                                           if (sen > 1) {
                                                    verypos++;
                                                    temp = "Very Positive";
                                                }
                                                if (sen > 0 && sen < 1) {
                                                    poscount++;
                                                    temp = "Positive";
                                                }
                                                if (sen < -1) {
                                                    veryneg++;
                                                    temp = "Very Negative";
                                                }

                                                if (sen >= -1 && sen < 0) {
                                                    negcount++;
                                                    temp = "Negative";
                                                }
                                                if (sen == 0) {
                                                    neutralcount++;
                                                    temp = "Neutral";
                                                }
                                            if (i <= 5) {
                                    %>
                                    <tr>
                                        <td><%=rt1.getString("uname")%></td>
                                        <td><%=rt1.getString("rating")%></td>
                                        <td><%=rt1.getString("comment")%></td>
                                        <td><b><%=temp%></b></td>
                                    </tr>
                                    <%
                                            }
                                            i++;
                                        }

                                    %>
                                </table>
                                <br><br><br><br>
                                <h2>Review Analysis :</h2>
                                <div style="font-size: 20px;height: 400px;width: 1200px;border-style: groove;padding: 10px;">
                                    <span style="color: #ff1a1a">Very Positive Reviews:<%=verypos%></span>&nbsp;&nbsp;&nbsp;
                                    <span style="color: #ff1a1a">Positive Reviews:<%=poscount%></span>&nbsp;&nbsp;&nbsp;
                                    <span style="color: #ff1a1a">Neutral Reviews:<%=neutralcount%></span>&nbsp;&nbsp;&nbsp;
                                    <span style="color: #ff1a1a">Negative Reviews:<%=negcount%></span>&nbsp;&nbsp;&nbsp;
                                    <span style="color: #ff1a1a">Very Negative Reviews:<%=veryneg%></span>
                                        <%
                                            System.out.println("Total count :" + i);
                                            System.out.println("post count :" + poscount);
                                            System.out.println("negative count :" + negcount);

                                            double pos_precision = poscount / i;
                                            double verypos_precision = verypos / i;
                                            double veryneg_precision = veryneg / i;
                                            double neg_precision = negcount / i;
                                            double neu_precision = neutralcount / i;

                                            double rate = (pos_precision + neu_precision + verypos_precision) * 10;

                                        %>
                                        <br><br>
                                    <p>Very Positive Precision :<%=verypos_precision%></p>
                                    <p>Positive Precision :<%=pos_precision%></p>
                                    <p>Neutral Precision :<%=neu_precision%></p>
                                    <p>Negative Precision :<%=neg_precision%></p>
                                    <p>Very Negative Precision :<%=veryneg_precision%></p><br>
                                    <div style="float: left;">
                                        <h4>Rating :<%=rate%></h4>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </section><!-- End About Section -->
        </main><!-- End #main -->
        <!-- ======= Footer ======= -->
        <footer id="footer">
            <div class="container">
                <div class="copyright">
                    &copy; Copyright <strong><span>2021</span></strong>. All Rights Reserved
                </div>
            </div>
        </footer><!-- End Footer -->
        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
        <!-- Vendor JS Files -->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>
        <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
        <script src="assets/vendor/waypoints/noframework.waypoints.js"></script>
        <!-- Template Main JS File -->
        <script src="assets/js/main.js"></script>
    </body>
</html>
