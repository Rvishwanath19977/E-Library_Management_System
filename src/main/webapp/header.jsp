<%-- 
    Document   : header
    Created on : 18 May 2023, 16:34:50
    Author     : vishwanath
--%>

<%@page import="Category.Category"%>
<%@page import="Category.CategoryDao"%>
<%@page import="Book.*"%>
<%@page import="Favourite.*"%>
<%@page import="User.*"%>
<%@page import="java.util.*"%>
<%@page session="true" contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Category> categorys = CategoryDao.getList();
    FavouriteDao favouriteDao = new FavouriteDao();
    String bkerrmsg = "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link href="admin/css/adminlte.min.css" rel="stylesheet">-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Jost:100,200,300,400,500,600,700,900%7CGentium+Basic:400italic&subset=latin,latin">
        <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Lato:100,200,300,400,500,600,700,900%7CGentium+Basic:400italic&subset=latin,latin">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" rel="stylesheet">
                
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/themes/bootstrap.min.css" integrity="sha512-6xVTeh6P+fsqDhF7t9sE9F6cljMrK+7eR7Qd+Py7PX5QEVVDLt/yZUgLO22CXUdd4dM+/S6fP0gJdX2aSzpkmg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js" integrity="sha512-CryKbMe7sjSCDPl18jtJI5DR5jtkUWxPXWaLCst6QjH8wxDexfRJic2WRmRXmstr2Y8SxDDWuBO6CQC6IE4KTA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js" integrity="sha512-42PE0rd+wZ2hNXftlM78BSehIGzezNeQuzihiBCvUEB3CVxHvsShF86wBWwQORNxNINlBPuq7rG4WWhNiTVHFg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
        <title>E-Library</title>
        <style>
            body {
                font-family: 'Jost';
            }
            .checked {
                color: orange;
            }
            .containers {
                display: none;
            }
.switch {
  position: relative;
  display: inline-block;
  width: 40px;
  height: 18px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
margin-bottom: -2px;
  position: absolute;
  content: "";
  height: 14px;
  width: 13px;
  left: 1px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
.modal-dialog {
  max-width: 25%;
}
.modal-dialog-slideout {
  min-height: 100%;
  margin: 0 0 0 auto;
  background: #fff;
}
.modal.fade .modal-dialog.modal-dialog-slideout {
  -webkit-transform: translate(100%, 0)scale(1);
  transform: translate(100%, 0)scale(1);
}
.modal.fade.show .modal-dialog.modal-dialog-slideout {
  -webkit-transform: translate(0, 0);
  transform: translate(0, 0);
  display: flex;
  align-items: stretch;
  -webkit-box-align: stretch;
  height: 100%;
}
.modal.fade.show .modal-dialog.modal-dialog-slideout .modal-body {
  overflow-y: auto;
  overflow-x: hidden;
}
.modal-dialog-slideout .modal-content {
  border: 0;
}
.modal-dialog-slideout .modal-header,
.modal-dialog-slideout .modal-footer {
  height: 4rem;
  display: block;
}
        </style>
    </head>
    <body>
 <header>
     <jsp:include page="book-history.jsp" flush="true" />
<div class="bg-warning py-2"> 
    <div style="margin-left: 15px">Group 18 &nbsp;&nbsp;<span><small>David Chuku | Nivitha Dhamotharan | Onyinyechi Akobundu | Vishwanath Rajasekaran | Kodie Kwasi</small></span></div>
</div>
  <nav id="navbar_top" class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="index.jsp">E-Library</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02" aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button><form action="search.jsp" class="search_header_form form-inline">
  <!--<div class="form-row">-->
    <div class="">
      <input type="text" name="search_phrase" class="form-control" style="width:650px" placeholder="Search by Book title, Author, ISBN">
    </div>
    <div id="field-container" class="containers">
        <select name="field" class="form-control" style="width:120px; margin-left: 5px;">
            <option value="title">Title</option>
            <option value="author">Author</option>
            <option value="isbn">ISBN</option>
            <option value="tags">Tag</option>
        </select>
    </div>
    <div id="field-container" class="containers">
        <select name="section" class="form-control" style="width:120px; margin-left: 5px">
            <option value="">All sections</option>
                                      <% if(categorys != null || categorys.size() > 0) {
                          for (int index=0; index < categorys.size();index++) {
   Category item = (Category) categorys.get(index);%>
   <option value="<%= item.getId() %>"><%= item.getTitle() %></option> <% }} %>
        </select>
    </div>
    <div id="condition-container"class="containers">
        <select name="condition" class="form-control" style="width:120px; margin-left: 5px;">
            <option value="exact">Exact phrase</option>
            <option value="contains">Contains</option>
        </select>
    </div>
    <div class="">
        <button style="margin-left: 5px;"class="btn btn-success"><i class="fa fa-search"></i> Search</button>
    </div>
          <!--<div style="margin-left:10px;" class="custom-control custom-checkbox my-1 mr-sm-2">
    <input name="advance" type="checkbox" class="custom-control-input" id="advanced">
    <label class="custom-control-label" for="advanced" style="color:white">Advanced Search</label>
  </div>-->
        <label style="margin-left:10px;" class="switch">
  <input type="checkbox" name="advance" checked class="custom-control-input" id="advanced">
  <span class="slider round"></span>
        </label><span style="margin-left:10px; color: white;">Advanced Search</span>
  <!--</div>-->
    </form>

    <div class="collapse navbar-collapse" id="navbarColor02">

    </div>
            <%
          ArrayList  userDetails = (ArrayList) session.getAttribute("loggedInUser");
          User userDetail = null;
          String fullname = "USER";
          if(userDetails != null) {
            userDetail = (User) userDetails.get(0);
          }
      %>
    <ul class="navbar-nav mr-auto">
      <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user"></i> <%= userDetail == null ? fullname : userDetail.getFullName() %></a>
    <div class="dropdown-menu">
      <a class="dropdown-item" data-toggle="modal" data-target="#ModalSlide2" href="#">Borrowed books</a>
      <a class="dropdown-item" data-toggle="modal" data-target="#ModalSlide" href="#">Favourites</a>
      <div class="dropdown-divider"></div>
      <a class="dropdown-item logoutbtn" href="#">Logout</a>
    </div>
      </li></ul>
  </nav>
 </header>
 <div class="modal fade" id="ModalSlide" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
  <div class="modal-dialog modal-dialog-slideout" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title align-right" id="exampleModalLabel">Favourites</h5>

      </div>
      <div class="modal-body" style="margin-top:20px;">
                        <%
                            int id = userDetail == null ? 0 : userDetail.getId();
     List<Book> books = favouriteDao.getUserFavourites(id);
    if (books == null || books.size() == 0) {
        bkerrmsg = "There is no books yet for this category, please come back later";
    } else { for (int index=0; index < books.size();index++) {
   Book item =  (Book)books.get(index); %>
   <div class="col-md-12" style="margin-top: -20px;">
                  <div class="card flex-md-row mb-4 shadow-sm h-md-250" style="max-height:100px;">
                  <div class="card-body d-flex flex-column align-items-start">
                    <p style="margin-top: -10px;" class="d-inline-block mb-2 text-primary"><%= CategoryDao.getCategoryNameById(item.getCategoryId()) %></p>
                    <b class="mb-0">
                      <a class="text-dark" href="request-book.jsp?book=<%=item.getId()%>"><%= item.getTitle() %></a>
                    </b>
                      <div class="mb-1 text-muted"><small><%= item.getAuthor() %></small></div>
                    <!--<p class="card-text mb-auto"><small></small></p>-->
                    <!--<a href="request-book.jsp?book=<%=item.getId()%>">Continue reading</a>-->
                  </div>
                  <img class="card-img-right flex-auto d-none d-lg-block" src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="70" height="100" max-height="100" alt="Card image cap">
                </div>
              </div> <% } }%>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
        <script>
          document.addEventListener("DOMContentLoaded", function(){
          window.addEventListener('scroll', function() {
              if (window.scrollY > 50) {
                document.getElementById('navbar_top').classList.add('fixed-top');
                // add padding top to show content behind navbar
                navbar_height = document.querySelector('.navbar').offsetHeight;
                document.body.style.paddingTop = navbar_height + 'px';
                document.getElementById('container').style.marginTop = '-20px';

              } else {
                document.getElementById('navbar_top').classList.remove('fixed-top');
                 // remove padding top from body
                document.body.style.paddingTop = '0';
                document.getElementById('container').style.marginTop = '15px';
              } 
          });
            setTimeout(function() {
                if($('.custom-control-input').prop('checked')) {
                    $('.custom-control-input').attr('checked', false);
                }
            }, 50);
            
            $('[data-toggle="tooltip"]').tooltip();

        }); 

        $(document).on('click', '.custom-control-input', function(){
                $('.containers').toggle('fast');
        });
        
        $(document).on('click', '.favourite_heart', function(){
           var id = $(this).attr("id");
           var context = $(this);
           $.ajax({
                type: 'POST',
                url: "FavouriteServlet",
                data: {
                    book_id: id,
                    action: 'UPDATE_FAVOURITE'
                },
                success: function( res ) {
                    console.log(res);
                    if(res === "created") {
                        $(context).addClass("checked");
                        alertify.success("Favourite added");
                    }
                    if(res === "deleted") {
                        $(context).removeClass("checked");
                        alertify.success("Favourite removed");
                    }
                },
                error:function(error) {
                    console.log(error);
                }
            });
        });
        
        $(document).on('click', '.logoutbtn', function(){
            alertify.defaults.theme.ok = "btn btn-danger";
            alertify.defaults.theme.cancel = "btn btn-default";
            alertify.confirm("Sure you want to logout?").set('onok', function () {
                $.ajax({
                    type: 'POST',
                    url: "LoginServlet",
                    data: {
                        action: 'LOGOUT'
                    },
                    success: function( res ) {
                        if(res === "success") {
                            window.location.replace("login.jsp");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
            }).set({title: "Logout"}).set({labels: {ok: 'Continue', cancel: 'Cancel'}});
        });
        </script>
