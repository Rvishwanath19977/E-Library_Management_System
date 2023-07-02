<%-- 
    Document   : dashboard
    Created on : 23 May 2023, 10:25:57
    Author     : vishwanath
--%>
<%response.sendRedirect("index.jsp");%>
<%@page import="Request.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">

    <title>E-Library :: Admin</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.1/examples/dashboard/">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker.min.css" rel="stylesheet"/>
        <link href="css/adminlte.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/themes/bootstrap.min.css" integrity="sha512-6xVTeh6P+fsqDhF7t9sE9F6cljMrK+7eR7Qd+Py7PX5QEVVDLt/yZUgLO22CXUdd4dM+/S6fP0gJdX2aSzpkmg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jvectormap/2.0.5/jquery-jvectormap.css" integrity="sha512-1ZwE8kCr0CknYsK+JYHqxnFqCZ2c17AJ6uTVf6me8UFCZJPE12ujWxnspvRJUb/zciTQ2D58PkJHQk5PLSYJ4Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,900%7CGentium+Basic:400italic&subset=latin,latin">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <!--<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />-->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap4.min.css"/>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap4.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.min.js"></script>
        <script src="js/jquery-jvectormap-2.0.1.min.js"></script>
        <script src="js/jquery-jvectormap-world-mill-en.js"></script>

    <!-- Custom styles for this template -->
    <link href="dashboard.css" rel="stylesheet">
            <style>
            body {
                font-family: 'Jost';
            }
            .checked {
                color: orange;
            }
        </style>
  </head>

  <body>
    <div class="bg-warning py-2"> 
    <div style="margin-left: 25px">Group 18 &nbsp;&nbsp;<span><small>David Chuku | Nivitha Dhamotharan | Onyinyechi Akobundu | Vishwanath Rajasekaran | Kodie Kwasi</small></span></div>
</div>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary" id="navbar_top">
      <a class="navbar-brand" href="dashboard.jsp" style="margin-left: 20px;">E-Library</a>
      <div class="container">
        
      </div>
        <form action="../AdminLoginServlet" method="POST">
            <input type="hidden" name="action" value="LOGOUT">
            <button type="submit" style="margin-right: 20px;" class="btn btn-sm btn-danger">Logout</button>
        </form>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar" style="min-height: 1300px;">
          <div class="sidebar-sticky">
            <ul class="nav flex-column" style="margin-top:10px;">
              <li class="nav-item">
                <a class="nav-link" href="index.jsp">
                  <span data-feather="home"></span>
                  Dashboard
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="view-books.jsp">
                  <span data-feather="book"></span>
                  Books
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="requests.jsp">
                  <span data-feather="bell"></span>
                <% RequestDao requestDao = new RequestDao(); %>
                  Requests <span class="badge badge-pill badge-primary"><%= requestDao.getNumberOfNewRequests() %></span>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="users.jsp">
                  <span data-feather="users"></span>
                  Users
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="categories.jsp">
                  <span data-feather="layers"></span>
                  Category
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="ratings.jsp">
                  <span data-feather="bar-chart"></span>
                  Ratings
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="reviews.jsp">
                  <span data-feather="message-square"></span>
                  Reviews
                </a>
              </li>
                            <li class="nav-item">
                <a class="nav-link" href="favourites.jsp">
                  <span data-feather="heart"></span>
                  Favourites
                </a>
              </li>
            </ul>
          </div>
        </nav>


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="../../assets/js/vendor/popper.min.js"></script>
    <script src="../../dist/js/bootstrap.min.js"></script>-->

    <!-- Icons -->
    <script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
    <script>
      feather.replace();
                  document.addEventListener("DOMContentLoaded", function(){
  window.addEventListener('scroll', function() {
      if (window.scrollY > 50) {
        document.getElementById('navbar_top').classList.add('fixed-top');
        // add padding top to show content behind navbar
        navbar_height = document.querySelector('.navbar').offsetHeight;
        document.body.style.paddingTop = navbar_height + 'px';
      } else {
        document.getElementById('navbar_top').classList.remove('fixed-top');
         // remove padding top from body
        document.body.style.paddingTop = '0';
      } 
  });
});
    </script>
  </body>
</html>
