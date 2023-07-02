<%-- 
    Document   : favourites
    Created on : 12 Jun 2023, 20:21:10
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
<%@page import="Favourite.*"%>
<%@page session="true" import="java.util.*"%>
<jsp:include page="dashboard.jsp" flush="true" />
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Favourites</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
            </div>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
    <li class="breadcrumb-item active" aria-current="page">Favourites</li>
  </ol>
</nav>
            <% FavouriteDao favouriteDao = new FavouriteDao();
               List<UserFavourites> favourites = favouriteDao.getUsersFavouritesCount();
    if (favourites == null || favourites.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no favourites yet, favourites will appear here once a user creates one</div>
        <% } else { %>
            <table class="table table-striped" id="favourites_table">
             <thead>
               <tr>
                 <th scope="col">User</th>
                 <th scope="col">Count</th>
                 <th scope="col">Operation</th>
               </tr>
             </thead>
             <tbody><% }%>
               <% for (int index=0; index <favourites.size();index++) {
                UserFavourites item = (UserFavourites) favourites.get(index);
                           %><tr>
                    <td><%= item.getFullName() %></td>
                    <td><%= item.getCount() %></td>
                    <td><button class="btn btn-sm btn-primary" onclick="window.location.href='view-favourites.jsp?user=<%=item.getUserId()%>'">View</button></td></tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
    <script>
        $(document).ready( function () {
            let table = new DataTable('#favourites_table');
        } );
        
    </script>
