<%-- 
    Document   : register
    Created on : 29 May 2023, 15:43:02
    Author     : vishwanath
--%>
<%@page import="utils.CountriesUtil" %>
<%@page import="Countries.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <title>E-Library :: Register user</title>
            <style>
body {
  background-image: url('images/bg.jpg');
  background-size: cover;
}
</style>
    </head>
    <body>
        <% String  error = (String) session.getAttribute("createError"); %>
        <div class="container" style="margin-top: 140px">
            <div class="row">
                <div class="col-4 offset-4" style="background: rgba(0,0,0, 0.6); padding: 20px; color:white;">
                    <% if(error != null) { %> <div class="alert alert-danger" role="alert"><small><%= error %></small> <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span></button></div> <% } %>
                    <form method="POST" action="CreateServlet">
                      <div align="center"><h3>E-Library Register</h3></div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Full Name</label>
                        <input type="text" name="name" class="form-control" placeholder="Full Name">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Email</label>
                        <input type="email" name="email" class="form-control" aria-describedby="emailHelp" placeholder="Enter email">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Phone Number</label>
                        <input type="text" name="phone" class="form-control" placeholder="Phone">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Address</label>
                        <input type="text" name="address" class="form-control" placeholder="Address">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Country</label>
                      <%
                            CountriesUtil util = new CountriesUtil();

                            List<Country> countries = util.getAllCountries();
                      %>
                            <select name="country" class="form-control">
                                <option value="">Select country</option>
                                <% for(int i = 0; i < countries.size(); i++) { 
                                Country item = (Country) countries.get(i);%>
                                <option value="<%= item.getCode()%>"><%= item.getName() %></option>
                                <%}%>
                            </select>
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <input type="password" name="password" class="form-control" placeholder="Password">
                      </div>
                      <button type="submit" class="btn btn-primary btn-block">Create account</button>
                      <input type="hidden" name="action" value="CREATE">
                    </form>
                    <div align="center">Already have an account? <a href="login.jsp">login</a></div>
                </div> 
            </div>
                
        </div>
        <% session.removeAttribute("createError"); %>
    </body>
</html>
