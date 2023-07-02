<%-- 
    Document   : reviews
    Created on : 7 Jun 2023, 22:15:21
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
<%@page import="Category.*"%>
<%@page session="true" import="java.util.*"%>
<jsp:include page="dashboard.jsp" flush="true" />
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Reviews</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
            </div>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
    <li class="breadcrumb-item active" aria-current="page">Reviews</li>
  </ol>
</nav>
            <% ReviewDao reviewDao = new ReviewDao();
               List<ReviewList> reviews = reviewDao.getAllBooksReviewWithCount();
    if (reviews == null || reviews.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no reviews yet, reviews will appear here once a user creates one</div>
        <% } else { %>
            <table class="table table-striped" id="reviews_table">
             <thead>
               <tr>
                 <th scope="col">Thumbnail</th>
                 <th scope="col">Title</th>
                 <th scope="col">Author</th>
                 <th scope="col">ISBN</th>
                 <th scope="col">Category</th>
                 <th scope="col">Count</th>
                 <th scope="col">Operation</th>
               </tr>
             </thead>
             <tbody><% }%>
               <% for (int index=0; index <reviews.size();index++) {
                ReviewList item = (ReviewList) reviews.get(index);
                           %><tr>
                    <td><img src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="60" height="80" alt="<%= item.getTitle() %>"/></td>
                    <td><%= item.getTitle() %></td>
                    <td><%= item.getAuthor() %></td>
                    <td><%= item.getIsbn() %></td>
                    <td><%= CategoryDao.getCategoryNameById(item.getCategoryId()) %></td>
                    <td><%= item.getCount() %></td>
                    <td><button class="btn btn-sm btn-primary" onclick="window.location.href='view-reviews.jsp?book=<%=item.getId()%>'">View</button></td></tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
    <script>
        $(document).ready( function () {
            let table = new DataTable('#reviews_table');
        } );
        
    </script>
