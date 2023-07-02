<%-- 
    Document   : search
    Created on : 6 Jun 2023, 20:03:29
    Author     : vishwanath
--%>
<%
            String searchPhrase = request.getParameter("search_phrase");
            String condition = request.getParameter("condition");
            String field = request.getParameter("field");
            String section = request.getParameter("section");
            String advance = request.getParameter("advance");
            String query = "";
            boolean repeat = false;
            boolean contains = false;
            
            if (section.endsWith(",")) {
                section = section.substring(0, section.length() - 1) + "";
            }
            
            if(advance == null || advance.isEmpty()){
                query = "SELECT * from books where title =? or author = ?";
                repeat = true;
            }
            else {
                query = "SELECT * from books where ";

                if(!field.isEmpty()) {
                    query+=field;
                }
                if(condition.equalsIgnoreCase("exact")) {
                    query+=" =?";
                }
                if(condition.equalsIgnoreCase("contains")) {
                    contains = true;
                    query+=" LIKE ? ESCAPE '!'";
                }
                if(!section.isEmpty()){
                    query+=" and category_id in ("+section+")";
                }
            }
            
            //System.out.println(query);
        %>
<%@page import="Book.Book"%>
<%@page import="Book.BookDao"%>
<%@page import="Book.BookService"%>
<%@page import="Category.Category"%>
<%@page import="Category.CategoryDao"%>
<%@page import="Rating.*"%>
<%@page import="Favourite.*"%>
<%@page import="java.util.*"%>
<%@page session="true" contentType="text/html" pageEncoding="UTF-8"%>
<link href="admin/css/adminlte.min.css" rel="stylesheet">
<jsp:include page="header.jsp" flush="true" />
<%
    FavouriteDao favouriteDao = new FavouriteDao();
    String errmsg = "";
    List<Category> categorys = CategoryDao.getList();
    if (categorys == null || categorys.size() == 0) {
        errmsg = "There is no category yet";
    }
    
    RatingDao ratingDao = new RatingDao();
    String bkerrmsg = "";
    List<Book> books = BookDao.searchBooks(query, searchPhrase, contains, repeat);
    if (books == null || books.size() == 0) {
        bkerrmsg = "There is no books that matches your search query";
    }
%>

<div class="container" id="container" style="margin-top: 15px">
    <div class="row">
        <div class="col-md-4">
                                            <div style="position: fixed; width: 350px;">
                  <h4 class="d-flex justify-content-between align-items-center mb-3">
            <span class="text-muted">Advanced Search</span>
          </h4>
          <form action="search.jsp">
          <input type="text" name="search_phrase" class="form-control" value="<%= searchPhrase %>" placeholder="Search by Book title, Author, ISBN"/>
                    <div Style="margin-left:12px; margin-top: 5px;" class="custom-control custom-switch">
                        <input name="advance" type="checkbox" class="custom-control-input advance_toggle"  id="advance">
                        <label class="custom-control-label" for="advance">Enable Advanced search</label>
                      </div>
                    <div class="containers" style="display: none;">
          <label>Fields</label>
        <select name="field" class="form-control">
            <option value="title">Title</option>
            <option value="author">Author</option>
            <option value="isbn">ISBN</option>
            <option value="tags">Tag</option>
        </select>
          <label>Condition</label>
                <select name="condition" class="form-control">
            <option value="exact">Exact phrase</option>
            <option value="contains">Contains</option>
        </select>
          <label>Sections</label>
         <%if(!errmsg.isEmpty()) { %>               
    <div class="alert alert-info"><%= errmsg %></div>
<%  } else { %>
          <ul class="list-group mb-3">
              <% for (int index=0; index < categorys.size();index++) {
   Category item = (Category) categorys.get(index);%>
            <li class="list-group-item d-flex justify-content-between lh-condensed">
              <div>
                  <h6 class="my-0"><input type="checkbox" value="<%= item.getId() %>" class="section_checkbox"/> &nbsp;<%= item.getTitle() %></h6>
                  <!--<small class="text-muted">40</small>-->
              </div>
                  <!--<span class="text-muted">(<%= CategoryDao.getCountofBooksInACategory(item.getId()) %>)</span>-->
            </li> <% }}%>
          </ul>
          <input type="hidden" name="section" id="section_input_field"/>
                    </div>
            <button style="margin-top: 5px;" type="submit" class="btn btn-primary btn-lg btn-block">Search</button>
            </form>
            </div>
        </div>
        <div class="col-md-8">
                        <div class="alert alert-info" role="alert">Search Result: <%= books.size() %> matches found</div>
            <div class="row">
                                     <%if(!bkerrmsg.isEmpty()) { %>               
    <div style="margin-left: 15px"><%= bkerrmsg %></div>
<%     } else { for (int index=0; index < books.size();index++) {
   Book item =  (Book)books.get(index); %>
     
                <div class="col-md-4">
                    <img src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="150" height="200" max-height="200"/>
                    <div style="position:absolute;margin-top: -30px;margin-left: 5px;"><i id="<%= item.getId() %>" class='fa fa-heart favourite_heart <%= favouriteDao.favouriteExists(1, item.getId()) ? "checked" : "" %>' data-toggle="tooltip" data-placement="right" title="Add to Favourites"></i></div>
                    <div><%= item.getTitle() %></div>
                    <div style="font-family: 'Lato'" class="badge badge-info badge-pill"><%= CategoryDao.getCategoryNameById(item.getCategoryId()) %></div>
                </div>
                <div class="col-md-8">
                    <p style="font-family:'Lato';"><%= item.getDescription() %></p>
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
                    <button class="btn btn-sm btn-primary" onclick="window.location.href='request-book.jsp?book=<%=item.getId()%>'">Request</button> | £<%= item.getPrice() %> per day <hr>
                </div><% }} %>
</div>

        </div>
    </div>
</div>
</body>
</html>
<script>
    $(function(){
        $('.search_header_form').hide('fast');
            setTimeout(function() {
                if($('.advance_toggle').prop('checked')) {
                    //$('.advance_toggle').attr('checked', false);
                    $('.containers').slideDown('fast');
                }
            }, 50);
    });
    
    $(document).on('click', '.section_checkbox', function(){
        var value = $('#section_input_field').val();
        if(value === "" || value === undefined) {
            value=$(this).val()+",";
            $('#section_input_field').val(value);
        }
        else{
            value+=$(this).val()+",";
            $('#section_input_field').val(value);
        }
    })
</script>