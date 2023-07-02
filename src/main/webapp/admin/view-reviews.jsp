<%-- 
    Document   : view-reviews
    Created on : 7 Jun 2023, 22:33:32
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Review.*"%>
<%@page session="true" import="java.util.*"%>
<jsp:include page="dashboard.jsp" flush="true" />
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Book Reviews</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
            </div>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
    <li class="breadcrumb-item"><a href="reviews.jsp">Reviews</a></li>
    <li class="breadcrumb-item active" aria-current="page">Book reviews</li>
  </ol>
</nav>
            <% ReviewDao reviewDao = new ReviewDao();
            int id = request.getParameter("book") == null ? 0 : Integer.parseInt(request.getParameter("book"));
               List<Review> reviews = reviewDao.getBookReviews(id);
    if (reviews == null || reviews.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no reviews for this book</div>
        <% } else { %>
            <table class="table table-striped" id="reviews_table">
             <thead>
               <tr>
                 <th scope="col">User</th>
                 <th scope="col">Review</th>
                 <th scope="col">Created</th>
               </tr>
             </thead>
             <tbody><% }%>
               <% for (int index=0; index <reviews.size();index++) {
                Review item = (Review) reviews.get(index);
                           %><tr>
                    <td><%= item.getFullname() %></td>
                    <td><%= item.getReview() %></td>
                    <td><%= item.getDateCreated() %></td>
                    </tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
    <script>
        $(document).ready( function () {
            let table = new DataTable('#reviews_table');
        } );
        
    </script>

