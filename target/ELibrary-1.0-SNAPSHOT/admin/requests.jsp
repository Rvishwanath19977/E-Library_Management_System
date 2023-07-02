<%-- 
    Document   : request
    Created on : 21 May 2023, 22:46:21
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
<%@page import="Request.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="dashboard.jsp" flush="true" />
<%
    RequestDao requestDao = new RequestDao();
%>
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Requests</h1>
            <div class="btn-toolbar mb-2 mb-md-0">

            </div>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
    <li class="breadcrumb-item active" aria-current="page">Requests</li>
  </ol>
</nav>
              <% List<Request> requests = requestDao.getAllRequests();
    if (requests == null || requests.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no book requests at the moment</div>
    <% } else { %>
            <table class="table table-sm table-striped" id="request_table">
             <thead>
               <tr>
                 <th>User</th>
                 <th>Book</th>
                 <th>Amount</th>
                 <th>Return Date</th>
                 <th>Disbursed</th>
                 <th>Disbursed Date</th>
                 <th>Returned</th>
                 <th>Returned Date</th>
                 <th>Decision</th>
                 <th>Created</th>
                 <th>Updated</th>
                 <th>Operation</th>
               </tr>
             </thead>
             <tbody>
               <% for (int index=0; index < requests.size();index++) {
                Request item = (Request) requests.get(index);
                           %><tr class="row- <%=item.getId()%>">
                   <td><small><%= item.getName() %></small></td>
                   <td><small><%= item.getBook() %></small></td>
                   <td><small><%= item.getAmount() %></small></td>
                   <td><small><%= item.getDateToBeReturned() %></small></td>
                   <td class="disbursed"><%= item.isDisbursed() ? "<span class='badge badge-success'>Yes</span>" : "<span class='badge badge-danger'>No</span>"%></td>
                   <td class="disburse_date"><small><%= item.getDisbursedDate() == null ? "" : item.getDisbursedDate()%></small></td>
                   <td class="returned"><%= item.isReturned() ? "<span class='badge badge-success'>Yes</span>" : "<span class='badge badge-danger'>No</span>"%></td>
                   <td class="return_date"><small><%= item.getReturnedDate() == null ? "" : item.getReturnedDate()%></small></td>
                   <td class="decision"><%= item.getDecision() == null ? "" : item.getDecision()%></td>
                   <td><small><%=item.getDateCreated()%></small></td>
                   <td><small><%= item.getDateUpdated() == null ? "" : item.getDateUpdated()%></small></td>
                   <td class="decision_btn">
                       <% if(!item.isStatus()) { %>
                       <button id="<%= item.getId() %>" class="btn btn-sm btn-success accept">Accept</button> <button id="<%= item.getId() %>" class="btn btn-sm btn-danger decline">Decline</button>
                       <% } else if(item.isStatus() && item.getDecision().equalsIgnoreCase("Accepted") && !item.isDisbursed()){ %>
                            <button action="disburse" id="<%= item.getId() %>" class="btn btn-sm btn-default update">Disburse</button><button style="display:none;" id="<%= item.getId() %>" class="btn btn-sm btn-default updatedisburse">Hidden</button>
                       <% } else if (item.isStatus() && item.getDecision().equalsIgnoreCase("Accepted") && item.isDisbursed() && !item.isReturned()) { %>
                            <button action="return" id="<%= item.getId() %>" class="btn btn-sm btn-primary update">Return</button><button style="display:none;" id="<%= item.getId() %>" class="btn btn-sm btn-default updatereturn">Hidden</button>
                            <% } else { %> <p class="alert alert-primary alert-sm" role="alert"><small>Transaction closed</small></p> <% } %>
                       </td>
                   </tr> <% } %></tbody></table><% } %>
        </main>
      </div>
    </div>
    <div class="modal fade" tabindex="-1" role="dialog" id="request_modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Update Record</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class='alert alert-info' role='alert'><small>Select the day this book was disbursed / returned</small></div>
        <input type='text' data-date-format='dd-mm-yyyy' id='datepicker' placeholder='DD-MM-YYYY'/>
        <input type="hidden" id="action"/>
        <input type="hidden" id="action_id"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary save">Save changes</button>
      </div>
    </div>
  </div>
</div>
    <script>
        $(document).ready( function () {
            $('#request_table').DataTable();
            var table = new DataTable('#request_table');            
        } );
        
         $(document).on('click', '.accept', function(){
            var id = $(this).attr('id');
            var context = $(this);
            alertify.defaults.theme.ok = "btn btn-danger";
            alertify.defaults.theme.cancel = "btn btn-default";
            alertify.confirm("Sure you want to accept this request?").set('onok', function () {
                $.ajax({
                    type: 'POST',
                    url: "../AdminRequestServlet",
                    data: {
                        request_id: id,
                        action: 'ACCEPT',
                    },
                    success: function( res ) {
                        if(res === "Accepted") {
                            $(context).closest("tr").find('.decision').html("Accepted");
                            $(context).closest("tr").find('.decision_btn').html("<button action='disburse' id='"+id+"' class='btn btn-sm btn-default update'>Disburse</button><button style='display:none;' id='"+id+"' class='btn btn-sm btn-default updatedisburse'>Hidden</button>");
                            alertify.success("Request has been accepted");
                        }
                        else {
                            alertify.danger("Failed to accept request");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
            }).set({title: "Accept"}).set({labels: {ok: 'Continue', cancel: 'Cancel'}});
        });
        
        $(document).on('click', '.decline', function(){
            var id = $(this).attr('id');
            var context = $(this);
            alertify.defaults.theme.ok = "btn btn-danger";
            alertify.defaults.theme.cancel = "btn btn-default";
            alertify.confirm("Sure you want to decline this request?").set('onok', function () {
                $.ajax({
                    type: 'POST',
                    url: "../AdminRequestServlet",
                    data: {
                        request_id: id,
                        action: 'DECLINE',
                    },
                    success: function( res ) {
                        if(res === "Declined") {
                            $(context).closest("tr").find('.decision').html("Declined");
                            $(context).closest("tr").find('.decision_btn').html("<p class='alert alert-primary alert-sm' role='alert'><small>Transaction closed</small></p>");
                            alertify.success("Request has been declined");
                        }
                        else {
                            alertify.danger("Failed to decline request");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
            }).set({title: "Decline"}).set({labels: {ok: 'Continue', cancel: 'Cancel'}});
        });
        
        $(document).on('click', '.update', function(){
            var id = $(this).attr('id');
            var action = $(this).attr('action');
            $('#action').val(action);
            $('#action_id').val(id);
            $('#request_modal').modal('show');
            //alertify.defaults.theme.ok = "btn btn-primary";
            //alertify.defaults.theme.cancel = "btn btn-default";
            //alertify.confirm("<div class='alert alert-info' role='alert'><small>Select the day this book was disbursed</small></div> \n <input type='text' data-date-format='dd/mm/yyyy' id='datepicker' placeholder='DD-MM-YYYY'/>").set('onok', function () {
                //alert($('#datepicker').val());
                /*$.ajax({
                    type: 'POST',
                    url: "../AdminRequestServlet",
                    data: {
                        request_id: id,
                        action: 'DECLINE',
                    },
                    success: function( res ) {
                        if(res === "Declined") {
                            $(context).closest("tr").find('.decision').html("Declined");
                            $(context).closest("tr").find('.decision_btn').html("<p class='alert alert-primary alert-sm' role='alert'><small>This transaction is closed</small></p>");
                            alertify.success("Request has been declined");
                        }
                        else {
                            alertify.danger("Failed to decline request");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });*/
            //}).set({title: "Disburse"}).set({labels: {ok: 'Continue', cancel: 'Cancel'}});
                $('#datepicker').datepicker({
        weekStart: 1,
        daysOfWeekHighlighted: "6,0",
        autoclose: true,
        todayHighlight: true,
        endDate: new Date(),
    });
    $('#datepicker').datepicker("setDate", new Date());
        });
        
       $(document).on('click', '.save', function(){
           $('#request_modal').modal('hide');
           var action = $('#action').val();
           var id = $('#action_id').val();
           if($('#datepicker').val() === "" || $('#datepicker').val() === undefined){
               alertify.warning("Date field is missing");
               return;
           }
           else {
                if(action === 'disburse') {
                     $('#request_table').find('.'+id).find('.decision_btn').find('.updatedisburse').click();
                }
                if(action === 'return') {
                    $('#request_table').find('.'+id).find('.decision_btn').find('.updatereturn').click();
                }
           }
       });
       
       $(document).on('click', '.updatedisburse', function(){
           var id = $(this).attr('id');
           var context = $(this);
                $.ajax({
                    type: 'POST',
                    url: "../AdminRequestServlet",
                    data: {
                        request_id: id,
                        action: 'DISBURSE',
                        date: $('#datepicker').val()
                    },
                    success: function( res ) {
                        if(res === "Disbursed") {
                            $(context).closest("tr").find('.disbursed').html("<span class='badge badge-success'>Yes</span>");
                            $(context).closest("tr").find('.disburse_date').html("<small>"+$('#datepicker').val()+"</small>");
                            $(context).closest("tr").find('.decision_btn').html("<button action='return' id='"+id+"' class='btn btn-sm btn-primary update'>Return</button><button style='display:none;' id='"+id+"' class='btn btn-sm btn-default updatereturn'>Hidden</button>");
                            alertify.success("Record updated");
                      
                        }               
                        else {
                            alertify.danger("Failed to update record");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
       });
       
        $(document).on('click', '.updatereturn', function(){
           var id = $(this).attr('id');
           var context = $(this);
                $.ajax({
                    type: 'POST',
                    url: "../AdminRequestServlet",
                    data: {
                        request_id: id,
                        action: 'RETURN',
                        date: $('#datepicker').val()
                    },
                    success: function( res ) {
                        if(res === "Returned") {
                            $(context).closest("tr").find('.returned').html("<span class='badge badge-success'>Yes</span>");
                            $(context).closest("tr").find('.return_date').html("<small>"+$('#datepicker').val()+"</small>");
                            $(context).closest("tr").find('.decision_btn').html("<p class='alert alert-primary alert-sm' role='alert'><small>Transaction closed</small></p>");
                            alertify.success("Record updated");
                        }
                        else {
                            alertify.danger("Failed to update record");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
       });
    </script>
        
