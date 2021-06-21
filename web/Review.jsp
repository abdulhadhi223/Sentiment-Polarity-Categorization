<%-- 
    Document   : User_login.jsp
    Created on : 9 Feb, 2021, 4:43:31 PM
    Author     : JAVA-JP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DBconnection.SQLconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    </ul>
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
                        <div class="col-lg-6">
                            <img src="images/search2.jpg" width="400" height="300">
                        </div>
                        <div class="col-lg-6">
                            <form action="Review1.jsp" method="post" role="form">
                                <div class="col-md-6">
                                    <br>
                                    <label>Select Product Name :</label>
                                    <select class="form-control-lg" required="required" name="keyword"><option value="">Select Product</option>
                                        <%                                                    Statement st = SQLconnection.getconnection().createStatement();
                                            ResultSet rt = st.executeQuery("SELECT distinct(pname) FROM `spct`.`product`;");
                                            while (rt.next()) {
                                        %>
                                        <option value="<%=rt.getString("pname")%>"><%=rt.getString("pname")%></option>
                                        <%
                                            }
                                        %>
                                    </select><br><br>
                                </div>
                                <div class="col-md-6">
                                    <button type="submit" class="btn-primary btn-lg">Search</button>
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
