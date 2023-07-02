<%-- 
    Document   : add-book
    Created on : 23 May 2023, 10:49:38
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
<%@page import="Order.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="dashboard.jsp" flush="true" />
<%
    String errmsg = "";
    List<Category> categorys = CategoryDao.getList();
    if (categorys == null || categorys.size() == 0) {
        errmsg = "There is no category yet";
    }
    
%>
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Add book</h1>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
    <li class="breadcrumb-item"><a href="view-books.jsp">Books</a></li>
    <li class="breadcrumb-item active" aria-current="page">Add book</li>
  </ol>
</nav>
        <%
           String  error = (String) session.getAttribute("addBookError");
           String  success = (String) session.getAttribute("addBookSuccess");
        %>
                    <% if(error != null) { %> <div style="max-width: 600px;"><div class="alert alert-danger" role="alert"><small><%= error %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button></div></div> <% } %>
                    <% if(success != null) { %> <div style="max-width: 600px;"><div class="alert alert-success" role="alert"><small><%= success %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button></div></div> <% } %>
            <form method="POST" action="../AdminBookServlet" enctype="multipart/form-data">
                <label>Title</label>
                <input type="text" name="title" class="form-control" placeholder="Name" style="max-width: 600px;"/>
                <label>Author</label>
                <input type="text" name="author" class="form-control" placeholder="Name" style="max-width: 600px;"/>
                <label>ISBN</label>
                <input type="text" name="isbn" class="form-control" placeholder="Name" style="max-width: 600px;"/>
                <label>Description</label>
                <textarea name="description" class="form-control" placeholder="Name" height="300" style="max-width: 600px"> </textarea>
                <label>Thumbnail</label>
                <!--<input type="file" name="fname" class="form-control" placeholder="Select Image" style="max-width: 600px;"/>-->
                <div class="custom-file">
                  <input type="file" name="fname" class="custom-file-input form-control" id="customFile" style="max-width: 600px">
                  <label class="custom-file-label" for="customFile" style="max-width: 600px">Choose file</label>
                </div>
                <label>Published date</label>
                <input type="text" name="published_date" class="form-control" data-date-format="dd/mm/yyyy" id="datepicker" style="max-width: 600px;"/>
                <label>Quantity</label>
                <input type="text" name="quantity" class="form-control" placeholder="Quantity" style="max-width: 600px;"/>
                <label>Price</label>
                <input type="text" name="price" class="form-control" placeholder="price" style="max-width: 600px;"/>
                <label>Select Category</label>
                <select name="category" class="form-control" style="max-width: 600px;">
                <% for (int index=0; index <categorys.size();index++) {
                    Category item = (Category) categorys.get(index);
                    %>
                        <option value="<%=item.getId()%>"><%=item.getTitle()%></option><% } %>
                </select>
                <div class="form-row">
                    <div class="col">
                        <label>Tags</label>
                        <input type="text" name="tags" class="form-control" placeholder="Tags" style="max-width: 600px;"/>
                        <small class="text-muted"><i class="fa fa-question-circle"></i> Kindly seperate the available tags by a comma ","</small>
                    </div>
                </div><br/>  
                <input type="hidden" name="action" value="CREATE"/>
                <button class="btn btn-primary">CREATE</button>
            </form>
        </main>
        <% session.removeAttribute("addBookError");
           session.removeAttribute("addBookSuccess");
        %>
      </div>
    </div>
    <script>
    $('#datepicker').datepicker({
        weekStart: 1,
        daysOfWeekHighlighted: "6,0",
        autoclose: true,
        todayHighlight: true,
        endDate: new Date()
    });
    $('#datepicker').datepicker("setDate", new Date());
</script>
    </script>
