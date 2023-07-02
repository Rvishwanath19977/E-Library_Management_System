<%-- 
    Document   : books
    Created on : 18 May 2023, 16:43:00
    Author     : vishwanath
--%>
<%response.sendRedirect("index.jsp");%>
<%@page import="Book.Book"%>
<%@page import="Book.BookDao"%>
<%@page import="Book.BookService"%>
<%@page import="Category.Category"%>
<%@page import="Category.CategoryDao"%>
<%@page import="Rating.*"%>
<%@page import="Review.*"%>
<%@page import="Favourite.*"%>
<%@page import="java.util.*"%>
<%@page session="true" contentType="text/html" pageEncoding="UTF-8"%>
<%
    String errmsg = "";
    List<Category> categorys = CategoryDao.getList();
    if (categorys == null || categorys.size() == 0) {
        errmsg = "There is no category yet";
    }
%>

<%
    ReviewDao reviewDao = new ReviewDao();
    FavouriteDao favouriteDao = new FavouriteDao();
    RatingDao ratingDao = new RatingDao();
    BookDao bookDao = new BookDao();
    String bkerrmsg = "";
    int categoryId = request.getParameter("category") == null ? 1 : Integer.parseInt(request.getParameter("category"));
    int pageId = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
    double limit = 4;
    int start = 0;
    double total_record = bookDao.getTotalCountForPagination(categoryId);
        
    if(pageId > 0) {
        start = (pageId - 1) * (int)limit;
    }
    int sqllimit = (int)limit;
    List<Book> books = BookDao.getBooks(categoryId, sqllimit, start);
    if (books == null || books.size() == 0) {
        bkerrmsg = "There is no books yet for this category, please come back later";
    }
%>
<div class="container" id="container" style="margin-top: 15px">
    <div class="row">
        <div class="col-md-4">
            <div style="position: fixed; width: 350px;">
                  <h4 class="d-flex justify-content-between align-items-center mb-3">
            <span class="text-muted">Categories</span>
          </h4>
         <%if(!errmsg.isEmpty()) { %>               
    <div class="alert alert-info"><%= errmsg %></div>
<%  } else { %>
          <ul class="list-group mb-3">
              <% for (int index=0; index < categorys.size();index++) {
   Category item = (Category) categorys.get(index);%>
            <li class="list-group-item d-flex justify-content-between lh-condensed">
              <div>
                  <h6 class="my-0"><a href="index.jsp?category=<%=item.getId()%>&page=1"><%= item.getTitle() %></a></h6>
                  <!--<small class="text-muted">40</small>-->
              </div>
                  <span class="text-muted">(<%= CategoryDao.getCountofBooksInACategory(item.getId()) %>)</span>
            </li> <% }}%>
          </ul>
            </div>
        </div>
        <div class="col-md-8">
            <div class="alert alert-info" role="alert"><%= CategoryDao.getCategoryNameById(categoryId) %></div>
            <div class="row">
                                     <%if(!bkerrmsg.isEmpty()) { %>               
    <div style="margin-left: 15px"><%= bkerrmsg %></div>
<%     } else { for (int index=0; index < books.size();index++) {
   Book item =  (Book)books.get(index); %>
     
                <div class="col-md-4">
                    <img src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="150" height="200" max-height="200"/>
                    <div style="position:absolute;margin-top: -30px;margin-left: 5px;"><i id="<%= item.getId() %>" class='fa fa-heart favourite_heart <%= favouriteDao.favouriteExists(1, item.getId()) ? "checked" : "" %>' data-toggle="tooltip" data-placement="right" title="Add to Favourites"></i></div>
                    <div><%= item.getTitle() %></div>						
                </div>
                <div class="col-md-8">
                    <p style="font-family: 'Lato';"><%= item.getDescription() %></p>
                    <div><b>Author:</b> <%= item.getAuthor() %></div>
                    <div><b>ISBN:</b> <%= item.getIsbn() %></div>
                    <div><b>Av.Rating:</b> <%=ratingDao.getAverageBookRatingScore(item.getId()) %> &nbsp;&nbsp;<%                       
                                  for(int i=1;i<=5;i++) {  
                                %>
                                <span target="<%= i %>" id="span<%= i %>" class='fa fa-star rate <%= i<=Math.floor(ratingDao.getAverageBookRatingScore(item.getId())) ? "checked" : "" %>'></span>
                                <% } %> | <small>Total number of ratings: <%= ratingDao.getCountofBookRatings(item.getId()) %></small></div>
                    <p><b>Published:</b> <%= item.getPublishedDate() %><p>
                    <p><% if(!item.getTags().isEmpty()) { String[] tagArray = item.getTags().split(",");
                        for (String tag : tagArray) { %>
                    <span class="badge badge-warning"><%= tag %></span>
                        <% } } 
                    %></p>
                    <!--<p><span class="badge badge-warning">Drama</span> <span class="badge badge-warning">Award winning</span> <span class="badge badge-warning">Epic</span></p>-->
                    <button class="btn btn-sm btn-primary" onclick="window.location.href='request-book.jsp?book=<%=item.getId()%>'">Request</button>  <span style="font-family: 'Lato';">(<%= reviewDao.getCountofBookReviews(item.getId()) %>) Reviews</span> | £<%= item.getPrice() %> per day <hr>
                </div><% }} %>
</div>
<% 
    BookService bookservice = new BookService();
%>
            <%= bookservice.getPagination(categoryId, pageId, limit, start, total_record) %>
        </div>
    </div>
</div>
</body>
</html>
