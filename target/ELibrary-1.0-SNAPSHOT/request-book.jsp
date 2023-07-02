<%-- 
    Document   : request-book
    Created on : 26 May 2023, 21:18:39
    Author     : vishwanath
--%>
<% 
   int bookParamId = 1;
   Object loggedInSession = session.getAttribute("isLoggedIn");
    if(loggedInSession != null) {
        boolean isLoggedIn = (boolean)loggedInSession;
        if(!isLoggedIn) 
        {
            response.sendRedirect("login.jsp");
        }
        else {
            BookService bookService = new BookService();
            String bookParameter = request.getParameter("book");
            //int bookParamId = 1;
            if(!bookService.isNumeric(bookParameter)) {
                bookParamId = 0;
                response.sendRedirect("error.jsp");
            }
        }
    }
    else
    {
        response.sendRedirect("login.jsp");
    }
    
%>
<%@page import="Book.*"%>
<%@page import="Rating.*"%>
<%@page import="Favourite.*"%>
<%@page import="Review.*"%>
<%@page import="User.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="admin/css/adminlte.min.css" rel="stylesheet">
<jsp:include page="header.jsp" flush="true" />
<style>
    .datepicker-inline {
        width: 100%;
    }
    .datepicker table {
        width: 100%;
    }
    
    .delete-review {
        color:red;
    }
</style>
     <%
          ArrayList  userDetails = (ArrayList) session.getAttribute("loggedInUser");
          User userDetail = null;
          String fullname = "USER";
          if(userDetails != null) {
            userDetail = (User) userDetails.get(0);
          }
      %>
        <div class="container" style="margin-top: 30px">
                    <%
           FavouriteDao favouriteDao = new FavouriteDao();
           ReviewDao reviewDao = new ReviewDao();
           int num = request.getParameter("book") == null ? 1 : Integer.parseInt(request.getParameter("book"));
           int bookId = bookParamId == 0 ? 1: num;//request.getParameter("book") == null ? 1 : Integer.parseInt(request.getParameter("book"));
           String  error = (String) session.getAttribute("paymentError");
           BookDao bookDao = new BookDao();
           Book book = bookDao.getBookById(bookId);
        %>
            <div class="row">
                <div class="col-8">
                    <div class="row">
                        <div class="col-md-4">
                            <img src="data:image/png;base64,<%= book.getEncodedPhoto() %>" style="margin-right: 100px" width="220" height="350" max-height="350"/>
                            <div style="position:absolute;margin-top: -30px;margin-left: 5px;"><i id="<%= book.getId() %>" class='fa fa-lg fa-heart favourite_heart <%= favouriteDao.favouriteExists(1, book.getId()) ? "checked" : "" %>' data-toggle="tooltip" data-placement="right" title="Add to Favourites"></i></div>
                            <%
                                RatingDao ratingDao = new RatingDao();
                                //Todo: Remember to replace 1 with Logged in userId
                                int score = ratingDao.getUserBookRatingScore(1, book.getId());
                            %>
                            <div align="center" style="margin-top: 10px;">
                                <p><%= book.getTitle() %></p>
                            </div>
                            <div align="center" style="margin-top:-10px; font-size: 22px;">
                                <%
                                  for(int i=1;i<=5;i++) {  
                                %>
                                <span target="<%= i %>" id="span<%= i %>" class='fa fa-star rate <%= i<=score ? "checked" : "" %>'></span>
                                <% } %>
                            </div>
                            <div align="center">
                                <p>Your rating</p>
                            </div>
                            <div align="center" class="dropdown">
                              <span class="btn btn-sm btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                  Share
                              </span>
                              <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="https://www.facebook.com/sharer/sharer.php?u=http://elibrary.com"><i class="fa fa-facebook"></i> Facebook</a>
                                <a class="dropdown-item" href="https://twitter.com/intent/tweet/?text=<?=urlencode($rs['question'])?>&mp;url=<?=$share_url?>&amp;via=pollatecom"><i class="fa fa-twitter"></i> Twitter</a>
                                <a class="dropdown-item" href="mailto:?Subject=E-library books&amp;Body=Kindly checkout this awesome book => http://localhost:8080/ELibrary/request-book.jsp?book=<%=book.getId()%>"><i class="fa fa-envelope"></i> E-mail</a>
                                <a class="dropdown-item" href="whatsapp://send?text=<?=$share_url?>"><i class="fa fa-whatsapp"></i> Whatsapp</a>
                              </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <p><%= book.getDescription() %></p>
                            <div><b>Author:</b> <%= book.getAuthor() %></div>
                            <div><b>ISBN:</b> <%= book.getIsbn() %></div>
                            <div><b>Published:</b> <%= book.getPublishedDate() %></div>
                            <p><b>Av. Rating Score:</b> <%= ratingDao.getAverageBookRatingScore(book.getId()) %> | <small>Total number of ratings: <%= ratingDao.getCountofBookRatings(book.getId()) %></small></p>
                            <p><% if(!book.getTags().isEmpty()) { String[] tagArray = book.getTags().split(",");
                                for (String tag : tagArray) { %>
                            <span class="badge badge-warning"><%= tag %></span>
                                <% } } 
                            %></p>
                    £<%= book.getPrice() %> per day
                        
                        
<div class="card-header" style="margin-top:5px;">
    <h3 class="card-title">Reviews</h3>
</div>

<!--<div class="card-body">-->
<div class="direct-chat-messages" style="min-height:350px; max-height: 750px;">
    
<%
    List<Review> reviews = reviewDao.getBookReviews(book.getId());
    if(reviews != null || reviews.size() > 0) {
        for (int index=0; index < reviews.size();index++) {
        Review item = (Review) reviews.get(index);
%>
<div class="direct-chat-msg">
<div class="direct-chat-infos clearfix">
<span class="direct-chat-name float-left"><%= item.getFullname() %></span>
<% int userid = userDetail == null ? 0 : userDetail.getId(); %>
<span class="direct-chat-timestamp float-right"><%= item.getUserId() == userid ? "<button id='"+ item.getId() +"'class='btn btn-trasnsparent btn-sm delete-review'><i class='fa fa-trash'></i></button>" : "" %> <%= item.getDateCreated() %></span>
</div>

<!--<img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="message user image">-->

<div class="direct-chat-text">
<%= item.getReview() %>
</div>

</div> <% }} %>


<!--<div class="direct-chat-msg right">
<div class="direct-chat-infos clearfix">
<span class="direct-chat-name float-right">Sarah Bullock</span>
<span class="direct-chat-timestamp float-left">23 Jan 2:05 pm</span>
</div>

<!--<img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="message user image">-->

<!--<div class="direct-chat-text">
You better believe it!
</div>

</div>-->

<div class="input-group">
<input type="text" name="review" id="review" placeholder="Type Review ..." class="form-control">
<input type="hidden" id="user_id" value="<%= userDetail == null ? "" : userDetail.getId() %>">
<input type="hidden" id="user_name" value="<%= userDetail == null ? "" : userDetail.getFullName() %>">
<span class="input-group-append">
<button type="button" class="btn btn-primary add-review">Send</button>
</span>
</div>
</div>

<br/>
                        <!--</div>-->
                    
                </div>
                    </div>
                </div>
                              <div class="col-4" id="paymentBox">
                                                          <div class="form-row">
                        <div class="col">
                            <div style="margin-top:10px" class="alert alert-info" role="alert"><small>Kindly pick a return date from the calendar below</small></div>
                            <div data-date-format="dd-mm-yyyy" id="datepicker"></div>
                        </div>
                           </div>
                        <div style="margin-top:10px" class="alert alert-warning" role="alert">
                            <div><small><b>Duration : <span id="duration">Date not selected</b></small></span></div>
                           <div><small><i class="fa fa-question-circle"></i> Failure to return the book on or before expected date of return will result to a penalty charge or interest charge.</small></div>
                        </div><hr/>
                        <div><h5><span>TOTAL</span> <span style="float:right">£<span id="price">0.00</span></span></h5></div><hr/>
                                  <div class="alert alert-warning" role="alert">
                  <small>Kindly input your card details below, your details are secured with us</small>
              </div>
             <% if(error != null) { %> <div class="alert alert-danger" role="alert"><small><%= error %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span></button></div> <% } %>
                  <form action="BookServlet" method="POST">
                      <div class="form-row">
                          <div class="col">
                              <input type="text" name="name" class="form-control" placeholder="Card Name">
                              <small class="text-muted"><i class="fa fa-question-circle"></i> Full name as displayed on card</small>
                          </div>
                      </div><br/>
                      <div class="form-row">
                          <div class="col">
                              <input type="text" name="pan" class="form-control" placeholder="Card Number">
                          </div>
                      </div><br/>
                      <div class="form-row">
                        <div class="col">
                          <input type="text" name="expiry" class="form-control" placeholder="MM/YY">
                        </div>
                        <div class="col">
                          <input type="password" name="cvv" class="form-control" placeholder="CVV">
                          <input type="hidden" name="action" value="ORDER"/>
                          <input type="hidden" name="return_date" id="my_hidden_input">
                          <input type="hidden" name="price_to_pay" id="price_to_pay">
                          <input type="hidden" name="book_id" id="book_id" value="<%= book.getId() %>">
                        </div>
                      </div><br/>
                        <div class="form-row">
                            <div class="col">
                                <button type="submit" name="pay" class="btn btn-primary btn-block">REQUEST NOW</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
           <%
                session.removeAttribute("paymentError");  
            %>
    </body>
</html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.min.js"></script>
    <script>
    var startDate = new Date();
    startDate.setDate(startDate.getDate() + 2);
    $('#datepicker').datepicker({
        weekStart: 1,
        daysOfWeekHighlighted: "6,0",
        autoclose: true,
        //todayHighlight: true,
        startDate: startDate,
        orientation: "bottom"
    });

    $('#datepicker').datepicker().on('changeDate', function (ev) {
        $('#my_hidden_input').val(
            $('#datepicker').datepicker('getFormattedDate')
        );
        var fromDate = moment(new Date(), 'DD-MM-YYYY');
        var toDate = moment($('#my_hidden_input').val(), 'DD-MM-YYYY');
        
        console.log(toDate);
        
        if (fromDate.isValid() && toDate.isValid()) {

          var duration = moment.duration(toDate.diff(fromDate));
          var daysDiff = toDate.diff(fromDate, 'days');
          var price = daysDiff*<%= book.getPrice() %>;
          var fixedNum = price.toFixed(2);
          $('#price').html(fixedNum);
          $('#price_to_pay').val(fixedNum);
          var durationString = "";
          if(duration.years() > 0) {
              durationString += duration.years() + ' Year(s) ';
          }
          if(duration.months() > 0) {
              durationString += duration.months() + ' Month(s) ';
          }
          if(duration.days() > 0) {
              durationString += duration.days() + ' Day(s)';
          }
          $('#duration').html(durationString);

        } else {
            alert('Invalid date(s).');    

        }
    });
    
    var spans = document.getElementsByClassName('rate');
    for(i=0;i<spans.length;i++)
            spans[i].onclick=doRating;

    function doRating() {
        for(i=0;i<spans.length;i++)
            spans[i].classList.remove("checked");
        var score = $(this).attr("target");
        $.ajax({
                    type: 'POST',
                    url: "RatingServlet",
                    data: {
                        score: score,
                        user_id: $('#user_id').val(),
                        book_id:$('#book_id').val(),
                        action: 'RATE',
                    },
                    success: function( res ) {
                        if(res === "success") {

                            alertify.success("Rate submitted");
                        }
                        else {
                            alertify.warning("Failed to submit rate");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
        
        for(i=1;i<=score;i++) {
            var num = 'span'+spans[i-1].getAttribute("target");
            var el = document.getElementById(num).classList.add("checked");
        }
    }
    
    $(document).on('click', '.add-review', function(){
       var review = $('#review').val();
       if(review === null || review === undefined || review === "") {
           return;
       }
       else {
                   $.ajax({
                    type: 'POST',
                    url: "ReviewSerlvet",
                    data: {
                        review:review,
                        user_id: $('#user_id').val(),
                        book_id:$('#book_id').val(),
                        action: 'REVIEW'
                    },
                    success: function( res ) {
                        console.log(res);
                        if(res === "failed") {
                            alertify.warning("Failed to add review");
                        }
                        else {
                            var id = res.split("|")[1];
                            $('.direct-chat-messages').prepend("<div class='direct-chat-msg'><div class='direct-chat-infos clearfix'><span class='direct-chat-name float-left'>"+$('#user_name').val()+"</span><span class='direct-chat-timestamp float-right'><button id='"+id+"'class='btn btn-transparent btn-sm delete-review'><i class='fa fa-trash'></i></button> Just Now</span></div><div class='direct-chat-text'>"+review+"</div></div>");
                            $('#review').val("");
                            alertify.success("Review added");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
       }
    });
    
    $(document).on('click', '.delete-review', function(){
            alertify.defaults.theme.ok = "btn btn-danger";
            alertify.defaults.theme.cancel = "btn btn-default";
            var id = $(this).attr("id");
            var context = $(this);
            alertify.confirm("Delete review ?").set('onok', function () {
                $.ajax({
                    type: 'POST',
                    url: "ReviewSerlvet",
                    data: {
                        review_id: id,
                        action: 'DELETE_REVIEW'
                    },
                    success: function( res ) {
                        if(res === "success") {
                            alertify.success("Review Deleted");
                            $(context).closest('.direct-chat-msg').remove();
                        }
                        else {
                            alertify.warning("Delete Failed");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
            }).set({title: "Delete"}).set({labels: {ok: 'Continue', cancel: 'Cancel'}}); 
    });
    
    $(document).on('keyup', '#review', function(e) {
        if(e.keyCode === 13) {
            $('.add-review').click();
        }
    });
</script>
