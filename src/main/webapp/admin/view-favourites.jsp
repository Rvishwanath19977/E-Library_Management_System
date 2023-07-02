<%-- 
    Document   : view-favourites
    Created on : 12 Jun 2023, 20:42:57
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
<%@page import="Book.*"%>
<%@page import="Category.*"%>
<%@page import="Favourite.*"%>
<%@page session="true" import="java.util.*"%>
<jsp:include page="dashboard.jsp" flush="true" />
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">User Favourites</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
            </div>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
    <li class="breadcrumb-item"><a href="favourites.jsp">Favourites</a></li>
    <li class="breadcrumb-item active" aria-current="page">User favourites</li>
  </ol>
</nav>
            <% FavouriteDao favouriteDao = new FavouriteDao();
            int id = request.getParameter("user") == null ? 0 : Integer.parseInt(request.getParameter("user"));
               List<Book> favourites = favouriteDao.getUserFavourites(id);
    if (favourites == null || favourites.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no favourites for this user, favourites will appear here once a user creates one</div>
        <% } else { %>
            <table class="table table-striped" id="favourites_table">
             <thead>
               <tr>
                 <th scope="col">Thumbnail</th>
                 <th scope="col">Title</th>
                 <th scope="col">Author</th>
                 <th scope="col">Published Date</th>
                 <th scope="col">ISBN</th>
                 <th scope="col">Category</th>
               </tr>
             </thead>
             <tbody><% }%>
               <% for (int index=0; index <favourites.size();index++) {
                Book item = (Book) favourites.get(index);
                           %><tr>
                    <td><img src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="60" height="80" alt="<%= item.getTitle() %>"/></td>
                    <td><%= item.getTitle() %></td>
                    <td><%= item.getAuthor() %></td>
                    <td><%= item.getPublishedDate() %></td>
                    <td><%= item.getIsbn() %></td>
                    <td><%= CategoryDao.getCategoryNameById(item.getCategoryId()) %></td>
                    </tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
    <script>
        $(document).ready( function () {
            let table = new DataTable('#favourites_table');
        } );
        
    </script>

