<%-- 
    Document   : add-category
    Created on : 23 May 2023, 10:50:11
    Author     : vishwanath
--%>
<%
    Object loggedInSession = session.getAttribute("isAdminLoggedIn");
    if(loggedInSession == null) {
        response.sendRedirect("/ELibrary/admin/admin-login.jsp");
    }
    else {
        boolean isLoggedIn = (boolean)loggedInSession;
        if(!isLoggedIn) 
        {
            response.sendRedirect("/ELibrary/admin/admin-login.jsp");
        }
    }
%>
<%@page import="Category.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="dashboard.jsp" flush="true" />

        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Add Category</h1>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
    <li class="breadcrumb-item"><a href="categories.jsp">Categories</a></li>
    <li class="breadcrumb-item active" aria-current="page">Add category</li>
  </ol>
</nav>
        <%
           String  error = (String) session.getAttribute("addCategoryError");
           String  success = (String) session.getAttribute("addCategorySuccess");
        %>
                    <% if(error != null) { %> <div style="max-width: 600px;"><div class="alert alert-danger" role="alert"><small><%= error %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button></div></div> <% } %>
                    <% if(success != null) { %> <div style="max-width: 600px;"><div class="alert alert-success" role="alert"><small><%= success %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button></div></div> <% } %>
            <form method="POST" action="../AdminCategoryServlet">
                <label>Name</label>
                <input type="text" name="name" class="form-control" placeholder="Title" style="max-width: 600px;"/><br/>
                <input type="hidden" name="action" value="CREATE"/>
                <button class="btn btn-primary">CREATE</button>
            </form>
        </main>
            <% session.removeAttribute("addCategoryError");
               session.removeAttribute("addCategorySuccess");
            %>
      </div>
    </div>
