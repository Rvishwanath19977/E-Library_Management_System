<%-- 
    Document   : ratings
    Created on : 7 Jun 2023, 03:19:40
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
<%@page import="Category.*"%>
<%@page import="Rating.*"%>
<%@page session="true" import="java.util.*"%>
<jsp:include page="dashboard.jsp" flush="true" />
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Ratings</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
              <a href="add-category.jsp">
                  <i class="fa fa-plus"></i> Add
              </a>
            </div>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
    <li class="breadcrumb-item active" aria-current="page">Ratings</li>
  </ol>
</nav>
              <% List<Rating> ratings = RatingDao.getAllRatings();
    if (ratings == null || ratings.size() == 0) { %>
        <div class="alert alert-info" role="alert">There is no rating at the moment, please check again</div>
        <% } else { %>
            <table class="table table-striped" id="ratings_table">
             <thead>
               <tr>
                 <th scope="col">Thumbnail</th>
                 <th scope="col">Title</th>
                 <th scope="col">Author</th>
                 <th scope="col">Category</th>
                 <th scope="col">Number of Ratings</th>
                 <th scope="col">Rating</th>
                 
               </tr>
             </thead>
             <tbody><% }%>
               <% for (int index=0; index <ratings.size();index++) {
                Rating item = (Rating) ratings.get(index);
                           %><tr>
                    <td><img src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="60" height="80" alt="<%= item.getTitle() %>"/></td>
                    <td><%= item.getTitle() %></td>
                    <td><%= item.getAuthor() %></td>
                    <td><%= CategoryDao.getCategoryNameById(item.getCategoryId()) %></td>
                    <td><%= item.getCount() %></td>
                   <td><%=item.getScore() %> &nbsp;&nbsp;<%                       
                                  for(int i=1;i<=5;i++) {  
                                %>
                                <span target="<%= i %>" id="span<%= i %>" class='fa fa-star rate <%= i<=Math.floor(item.getScore()) ? "checked" : "" %>'></span>
                                <% } %></td>
                    </tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
    <script>
        $(document).ready( function () {
            //$('#category_table').DataTable();
            let table = new DataTable('#ratings_table');
        } );
    </script>
