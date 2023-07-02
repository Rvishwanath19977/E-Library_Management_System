<%-- 
    Document   : users
    Created on : 26 May 2023, 08:06:44
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
<%@page import="User.*"%>
<%@page import="utils.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="dashboard.jsp" flush="true" />
<%
    UserDao userDao = new UserDao();
    CountriesUtil countriesutil = new CountriesUtil();
%>
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Users</h1>
            <div class="btn-toolbar mb-2 mb-md-0">

            </div>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
    <li class="breadcrumb-item active" aria-current="page">Users</li>
  </ol>
</nav>
              <% List<User> users = userDao.getAllUsers();
    if (users == null || users.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no registered user yet</div>
    <% } else { %>
            <table class="table table-striped" id="user_table">
             <thead>
               <tr>
                 <th scope="col">Name</th>
                 <th scope="col">Email</th>
                 <th scope="col">Phone</th>
                 <th scope="col">Address</th>
                 <th scope="col">Country</th>
                 <th scope="col">Status</th>
                 <th scope="col">Date Created</th>
                 <th scope="col">Date Updated</th>
                 <th scope="col">Set Status</th>
               </tr>
             </thead>
             <tbody> <% }%>
               <% for (int index=0; index < users.size();index++) {
                User item = (User) users.get(index);
                           %><tr>
                    <td><%= item.getFullName() %></td>
                    <td><%= item.getEmail() %></td>
                   <td><%= item.getPhoneNumber() %></td>
                   <td><small><%= item.getAddress() %></small></td>
                   <td><small><%= countriesutil.getCountryByCountryCode(item.getCountry()) %></small></td>
                   <% if(item.isActive()) { %> <td class="status"><span class="badge badge-success">Active</span></td>
                   <% } else { %> <td class="status"><span class="badge badge-danger">Not Active</span></td> <% } %>
                   <td><%=item.getDateCreated()%></td>
                   <td><%= item.getDateUpdated() == null ? "" : item.getDateUpdated()%></td>
                   <td><div class="custom-control custom-switch">
                        <input type="checkbox" <%= item.isActive() ? "checked" : "" %> class="custom-control-input" id="<%= item.getId() %>">
                        <label class="custom-control-label" for="<%= item.getId() %>"></label>
                      </div></td>
                   <!--<% if(item.isActive()) { %> <td class="status_btn"><button id="<%= item.getId() %>" class="btn btn-danger btn-sm deactivate" >Deactivate</button></td><% } else { %><td class="status_btn"><button class="btn btn-default btn-sm activate" id="<%= item.getId() %>">Activate</button></td><%}%>-->
                   </tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
    <script>
        $(document).ready( function () {
            $('#user_table').DataTable();
            var table = new DataTable('#user_table');
        } );
        
        $(document).on('click', '.custom-control-input', function(){
                        var id = $(this).attr('id');
            var context = $(this);
            var action = "";
            if($(context).prop('checked')) {
                action = 'ACTIVATE';
            } else {
                action = 'DEACTIVATE';
            }
            alertify.defaults.theme.ok = "btn btn-danger";
            alertify.defaults.theme.cancel = "btn btn-default";
            alertify.confirm("Sure you want to "+action+" this user?").set('onok', function () {
                $.ajax({
                    type: 'POST',
                    url: "../AdminUserServlet",
                    data: {
                        user_id: id,
                        action: action,
                    },
                    success: function( res ) {
                        if(res === "Deactivated") {
                            $(context).closest("tr").find('.status').html("<span class='badge badge-danger'>Not Active</span>");
                            alertify.success("User has been deactivated");
                        }
                        else if(res === "Activated") {
                            $(context).closest("tr").find('.status').html("<span class='badge badge-success'>Active</span>");
                            alertify.success("User has been activated");
                        }
                        else {
                            alertify.danger("Failed to deactivate user");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
            }).set('oncancel', function () {
                if(action === 'ACTIVATE') {
                    $(context).attr('checked', false);
                }
                else {
                   $(context).prop('checked', 'checked'); 
                }
            }).set({title: "Set Status"}).set({labels: {ok: 'Continue', cancel: 'Cancel'}});
        });
       
    </script>
