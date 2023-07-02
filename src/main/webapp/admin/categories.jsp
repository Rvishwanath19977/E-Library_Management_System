<%-- 
    Document   : categories
    Created on : 23 May 2023, 10:59:25
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
<%@page session="true" import="java.util.*"%>
<jsp:include page="dashboard.jsp" flush="true" />
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Categories</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
              <a href="add-category.jsp">
                  <i class="fa fa-plus"></i> Add
              </a>
            </div>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
    <li class="breadcrumb-item active" aria-current="page">Categories</li>
  </ol>
</nav>
              <% List<Category> categories = CategoryDao.getList();
    if (categories == null || categories.size() == 0) { %>
        <div class="alert alert-info" role="alert">There is no category, please add a category</div>
        <% } else { %>
            <table class="table table-striped" id="category_table">
             <thead>
               <tr>
                 <th scope="col">Title</th>
                 <th scope="col">Books</th>
                 <th scope="col">Date Created</th>
                 <th scope="col">Date Updated</th>
                 <th scope="col">Operation</th>
               </tr>
             </thead>
             <tbody><% }%>
               <% for (int index=0; index <categories.size();index++) {
                Category item = (Category) categories.get(index);
                           %><tr>
                    <td><%= item.getTitle() %></td>
                    <td><%= CategoryDao.getCountofBooksInACategory(item.getId()) %></td>
                   <td><%=item.getDateCreated()%></td>
                   <td><%= item.getDateUpdated() == null ? "" : item.getDateUpdated()%></td>
                               <td><button class="btn btn-sm btn-danger" onclick="deleteCategory(this, <%= item.getId() %>)">Delete</button></td></tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
    <script>
        $(document).ready( function () {
            //$('#category_table').DataTable();
            let table = new DataTable('#category_table');
        } );
        
        function deleteCategory(context, id) {
            alertify.defaults.theme.ok = "btn btn-danger";
            alertify.defaults.theme.cancel = "btn btn-default";
            alertify.confirm("Sure you want to delete this category?").set('onok', function () {
                $.ajax({
                    type: 'POST',
                    url: "../AdminCategoryServlet",
                    data: {
                        category_id: id,
                        action: 'DELETE',
                    },
                    success: function( res ) {
                        if(res === "Deleted") {
                            $('#category_table').DataTable().row( $(context).parents('tr') ).remove().draw();                      
                            alertify.success("Category has been deleted");
                        }
                        else {
                            alertify.danger("Failed to delete category");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
            }).set({title: "Delete"}).set({labels: {ok: 'Continue', cancel: 'Cancel'}});
        }
    </script>
