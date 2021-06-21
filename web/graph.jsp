<%-- 
    Document   : User_login.jsp
    Created on : 9 Feb, 2021, 4:43:31 PM
    Author     : JAVA-JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DBconnection.SQLconnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.google.gson.Gson"%>
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
                        <li><a href="Admin_Home.jsp">Home</a></li>
                        <li><a href="add_product.jsp">Add Product</a></li>
                        <li><a href="View_product.jsp">View Product</a></li>
                        <li><a href="View_users.jsp">View Users</a></li>
                        <li><a href="User_ratings.jsp">User Ratings</a></li>
                        <li><a class="active" href="graph.jsp">Analysis</a></li>
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
                        <center><h2>Analysis</h2><br><br></center>
                        <div class="col-lg-12">
                                            <%
                                                Gson gsonObj = new Gson();
                                                Map<Object, Object> map = null;
                                                List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();
                                                String dataPoints = null;

                                                try {

                                                    Connection connection = SQLconnection.getconnection();
                                                    Statement statement = connection.createStatement();
                                                    String xVal, yVal;

                                                    ResultSet resultSet = statement.executeQuery("SELECT pname,AVG(rating) FROM comments group by pname");

                                                    while (resultSet.next()) {
                                                        xVal = (resultSet.getString("pname")+" Rating:");
                                                        yVal = resultSet.getString("AVG(rating)");
                                                        map = new HashMap<Object, Object>();
                                                        map.put("label", xVal);
                                                        map.put("y", yVal);
                                                        list.add(map);
                                                        dataPoints = gsonObj.toJson(list);
                                                    }
                                                    System.out.println(dataPoints);
                                                } catch (SQLException e) {
                                                    System.out.println(e);
                                                    out.println("<div  style='width: 50%; margin-left: auto; margin-right: auto; margin-top: 200px;'>Could not connect to the database. Please check if you have mySQL Connector installed on the machine - if not, try installing the same.</div>");
                                                    dataPoints = null;
                                                }
                                            %>
                                            <script type="text/javascript">
                                                window.onload = function () {


                                                    var chart = new CanvasJS.Chart("chartContainer", {
                                                        animationEnabled: true,

                                                        title: {
                                                            text: "Product Rating"
                                                        },
                                                        data: [{
                                                                type: "pie",
                                                                radius: "200%",
                                                                showInLegend: true,
                                                                legendText: "{label}",
                                                                toolTipContent: "{label}: <strong>{y}</strong>",
                                                                indexLabel: "{label} {y}",
                                                                dataPoints: <%out.print(dataPoints);%>
                                                            }]
                                                    });

                                                    chart.render();

                                                }
                                            </script>
                                            <div  id="chartContainer" style="height: 400px; width: 100%; margin-right: 150px"></div>
                               
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
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>


        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                // navigation click actions 
                $('.scroll-link').on('click', function (event) {
                    event.preventDefault();
                    var sectionID = $(this).attr("data-id");
                    scrollToID('#' + sectionID, 750);
                });
                // scroll to top action
                $('.scroll-top').on('click', function (event) {
                    event.preventDefault();
                    $('html, body').animate({scrollTop: 0}, 'slow');
                });
                // mobile nav toggle
                $('#nav-toggle').on('click', function (event) {
                    event.preventDefault();
                    $('#main-nav').toggleClass("open");
                });
            });
            // scroll function
            function scrollToID(id, speed) {
                var offSet = 0;
                var targetOffset = $(id).offset().top - offSet;
                var mainNav = $('#main-nav');
                $('html,body').animate({scrollTop: targetOffset}, speed);
                if (mainNav.hasClass("open")) {
                    mainNav.css("height", "1px").removeClass("in").addClass("collapse");
                    mainNav.removeClass("open");
                }
            }
            if (typeof console === "undefined") {
                console = {
                    log: function () { }
                };
            }
        </script>
        <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

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
