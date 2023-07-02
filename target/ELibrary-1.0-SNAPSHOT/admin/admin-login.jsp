<%-- 
    Document   : admin-login
    Created on : 4 Jun 2023, 11:15:36
    Author     : vishwanath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <title>Clothes4Men :: Admin Login page </title>
    </head>
    <body><% 
           String  error = (String) session.getAttribute("loginError");
        %>
        <div class="container" style="margin-top: 150px">
            <div class="row">
                <div class="col-4 offset-4">
                    <div align="center"><h3>E-Library Admin Login</h3></div>
                        <% if(error != null) { %> <div class="alert alert-danger" role="alert"><small><%= error %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span></button></div> <% } %>
                    <form method="POST" action="../AdminLoginServlet">
                      <div class="form-group">
                          <label for="exampleInputEmail1">Email</label>
                          <div class="input-group">  
                            <div class="input-group-prepend">
                              <span class="input-group-text" id="basic-addon1"><i class="fa fa-user"></i></span>
                            </div>
                            <input type="email" class="form-control" name="email" placeholder="Enter email"/>
                          </div>
                      </div>
                      <div class="form-group">
                          <label for="exampleInputPassword">Password</label>
                          <div class="input-group">  
                            <div class="input-group-prepend">
                              <span class="input-group-text" id="basic-addon1"><i class="fa fa-key"></i></span>
                            </div>
                            <input type="password" class="form-control" name="password" placeholder="Password"/>
                          </div>
                      </div>
                      <button type="submit" class="btn btn-primary btn-block">Login</button>
                      <input type="hidden" name="action" value="LOGIN">
                    </form>
                </div> 
            </div>
                
        </div>
        <% session.removeAttribute("loginError");
        %>
    </body>
</html>
