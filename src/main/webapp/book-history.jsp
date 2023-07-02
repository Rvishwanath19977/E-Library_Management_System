<%-- 
    Document   : book-history
    Created on : 13 Jun 2023, 03:13:56
    Author     : vishwanath
--%>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap4.min.css"/>
<%@page import="Request.*"%>
<%@page import="java.util.*"%>
<%@page session="true" contentType="text/html" pageEncoding="UTF-8"%>
<%
    RequestDao requestDao = new RequestDao();
%>
 <div class="modal fade" id="ModalSlide2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
  <div class="modal-dialog modal-dialog-slideout" style="max-width: 80%;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title align-right" id="exampleModalLabel">Borrowed Books</h5>
      </div>
      <div class="modal-body">
          <!--<div class="container" id="container" style="margin-top: 20px">
    <div class="row">-->
          <div class="col-md-12" style="margin-top:20px;">
                          <% List<Request> requests = requestDao.getAllUserRequests(1);
    if (requests == null || requests.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no book requests at the moment</div>
    <% } else { %>
    <!--<h3>Requested Books</h3><br/>-->
            <table class="table table-sm table-striped" id="borrowed_books_table">
             <thead>
               <tr>
                 <th>Thumbnail</th>
                 <th>Book</th>
                 <th>Amount</th>
                 <th>Return Date</th>
                 <th>Disbursed</th>
                 <th>Disbursed Date</th>
                 <th>Returned</th>
                 <th>Returned Date</th>
                 <th>Decision</th>
                 <th>Created</th>
               </tr>
             </thead>
             <tbody>
               <% for (int index=0; index < requests.size();index++) {
                Request item = (Request) requests.get(index);
                           %><tr class="row- <%=item.getId()%>">
                   <td><img src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="60" height="80" alt="<%= item.getBook() %>"/></td>
                   <td><%= item.getBook() %></td>
                   <td><%= item.getAmount() %></td>
                   <td><%= item.getDateToBeReturned() %></td>
                   <td class="disbursed"><%= item.isDisbursed() ? "<span class='badge badge-success'>Yes</span>" : "<span class='badge badge-danger'>No</span>"%></td>
                   <td class="disburse_date"><%= item.getDisbursedDate() == null ? "" : item.getDisbursedDate()%></td>
                   <td class="returned"><%= item.isReturned() ? "<span class='badge badge-success'>Yes</span>" : "<span class='badge badge-danger'>No</span>"%></td>
                   <td class="return_date"><%= item.getReturnedDate() == null ? "" : item.getReturnedDate()%></td>
                   <td class="decision"><%= item.getDecision() == null ? "" : item.getDecision()%></td>
                   <td><%=item.getDateCreated()%></td>
                   </tr> <% } %></tbody></table><% } %>
        </div>
    <!--</div>
</div>-->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap4.min.js"></script>
<script>
        $(document).ready( function () {
            $('#borrowed_books_table').DataTable();
            var table = new DataTable('#borrowed_books_table');            
        } );
</script>