<%-- 
    Document   : view-books
    Created on : 25 May 2023, 18:59:06
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
<%@page import="Book.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="dashboard.jsp" flush="true" />
<%
    BookDao bookDao = new BookDao();
%>
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Books</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
              <a href="add-book.jsp">
                  <i class="fa fa-plus"></i> Add
              </a>
            </div>
          </div>
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
              <li class="breadcrumb-item active" aria-current="page">Books</li>
            </ol>
          </nav>
              <% List<Book> books = bookDao.getAllBooks();
    if (books == null || books.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no book yet, kindly add a book</div>
        <% } else { %>
            <table class="table table-sm table-striped" id="books_table">
             <thead>
               <tr>
                 <th scope="col">Thumbnail</th>
                 <th scope="col">Author</th>
                 <th scope="col">Isbn</th>
                 <th scope="col">Published</th>
                 <th scope="col">Description</th>
                 <th scope="col">Title</th>
                 <th scope="col">Category</th>
                 <th scope="col">Quantity</th>
                 <th scope="col">Price</th>
                 <th scope="col">Tags</th>
                 <th scope="col">Created</th>
                 <th scope="col">Updated</th>
                 <th scope="col">Operation</th>
               </tr>
             </thead>
             <tbody><% }%>
               <% for (int index=0; index <books.size();index++) {
                Book item = (Book) books.get(index);
                %><tr>
                    <form method="POST" action="../AdminBookServlet">
                    <td><img src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="60" height="80" alt="<%= item.getTitle() %>"/></td>
                    <td><small><%= item.getAuthor() %></small></td>
                    <td><small><%= item.getIsbn() %></small></td>
                    <td><small><%= item.getPublishedDate() %></small></td>
                    <td><small><%= item.getDescription().substring(0,100) %></small>...</td>
                    <td><small><%= item.getTitle() %></small></td>
                   <td><%= CategoryDao.getCategoryNameById(item.getCategoryId()) %></td>
                   <td><input type="text" name="quantity" value="<%= item.getQuantity() %>"class="form-control" style="width:60px;"/></td>
                   <td><input type="text" name="price" value="<%= item.getPrice() %>"class="form-control" style="width:90px;"/></td>
                   <td><input type="text" name="tags" value="<%= item.getTags() %>"class="form-control" style="width:90px;"/></td>
                   <td><small><%=item.getDateCreated()%></small></td>
                   <td><small><%= item.getDateUpdated() == null ? "" : item.getDateUpdated()%></small></td>
                   <td><input type="hidden" name="action" value="UPDATE"/><input type="hidden" name="book_id" value="<%= item.getId() %>"/><button class="btn btn-secondary"><i class="fa fa-edit"></i></button></form> <button class="btn btn-danger" onclick="deleteBook(this, <%=item.getId()%>)"><i class="fa fa-trash"></i></button></td></tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
        <script>
        $(document).ready( function () {
            $('#books_table').DataTable();
            var table = new DataTable('#books_table');
        } );
                
        function deleteBook(context, id) {
            alertify.defaults.theme.ok = "btn btn-danger";
            alertify.defaults.theme.cancel = "btn btn-default";
            alertify.confirm("Sure you want to delete this book?").set('onok', function () {
                $.ajax({
                    type: 'POST',
                    url: "../AdminBookServlet",
                    data: {
                        book_id: id,
                        action: 'DELETE',
                    },
                    success: function( res ) {
                        if(res === "Deleted") {
                            $('#books_table').DataTable().row( $(context).parents('tr') ).remove().draw();                      
                            alertify.success("Book has been deleted");
                        }
                        else {
                            alertify.danger("Failed to delete book");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
            }).set({title: "Delete"}).set({labels: {ok: 'Continue', cancel: 'Cancel'}});
        }
    </script>

