<%-- 
    Document   : index
    Created on : 23 May 2023, 10:28:28
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
<%@page import="Category.*"%>
<%@page import="Book.*"%>
<%@page import="Request.*"%>
<%@page import="utils.CountriesUtil" %>
<%@page import="Countries.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="dashboard.jsp" flush="true" />

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Dashboard</h1>
          </div>
          <nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
  </ol>
</nav>
       <section class="content">
<div class="container-fluid">

<div class="row">
<div class="col-lg-3 col-6">

<div class="small-box bg-info">
<div class="inner">
<% RequestDao requestDao = new RequestDao(); %>
<h3><%= requestDao.getNumberOfNewRequests() %></h3>
<p>New Requests</p>
</div>
<div class="icon" style="display:block;">
<i class="fa fa-bell"></i>
</div>
<a href="requests.jsp" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
</div>
</div>

<div class="col-lg-3 col-6">

<div class="small-box bg-success">
<div class="inner">
<% BookDao bookDao = new BookDao(); %>
<h3><%= bookDao.getCountofBooks() %></h3>
<p>Books</p>
</div>
<div class="icon">
<i class="fa fa-book"></i>
</div>
<a href="view-books.jsp" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
</div>
</div>

<div class="col-lg-3 col-6">

<div class="small-box bg-warning">
<div class="inner">
<% UserDao userDao = new UserDao(); %>
<h3><%= userDao.getCountofUsers() %></h3>
<p>Users</p>
</div>
<div class="icon">
<i class="fa fa-users"></i>
</div>
<a href="users.jsp" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
</div>
</div>

<div class="col-lg-3 col-6">

<div class="small-box bg-danger">
<div class="inner">
<% CategoryDao categoryDao = new CategoryDao(); %>
<h3><%= categoryDao.getCountofCategories() %></h3>
<p>Categories</p>
</div>
<div class="icon">
<i class="fa fa-bars"></i>
</div>
<a href="categories.jsp" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
</div>
</div>

</div>
    <h3 style="margin-top:50px">Statistics</h3>
<div class="row">
        <div class="col-md-6">
                <div>
  <canvas id="myChart"></canvas>
</div>
        </div>
        <div class="col-md-6">
            <canvas style="max-height: 330px"id="doughChart"></canvas>
        </div>
</div>
<div style="margin-top:50px" class="row">
    <div class="col-md-8">
        <div class="world" id="world-map" style="width: 800px; height: 400px"></div>
    </div>
    <div class="col-md-4">
        <canvas style="min-height: 250px" id="hbar"></canvas>
    </div>
</div>
        </main>
      </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%
    String categoryList = "[";
    String value = "[";
    List<Category> cat = CategoryDao.getList();
    for (int index=0; index < cat.size();index++) {
        Category item = (Category) cat.get(index);
        if(index == cat.size() - 1) {
            categoryList += "'"+ item.getTitle()+"'";
            value += CategoryDao.getCountofBooksRequestByCategory(item.getId());
        }
        else {
            categoryList += "'"+item.getTitle() + "',";
            value += CategoryDao.getCountofBooksRequestByCategory(item.getId()) + ",";
        }   
    }
    categoryList += "]";
    value += "]";
    
    String reqCountList = "[";
    List<MonthlyRequestCount> monthlyRequestCount = BookDao.getNumRequestPerMonth();
    for (int i=0; i < monthlyRequestCount.size();i++) {
        MonthlyRequestCount reqcount = (MonthlyRequestCount) monthlyRequestCount.get(i);
        if(i == monthlyRequestCount.size() - 1) {
            reqCountList += reqcount.getTotal();
        }
        else {
            reqCountList += reqcount.getTotal() + ",";
        }   
    }
    reqCountList += "]";
    
    
    String countryData = "{";
    CountriesUtil util = new CountriesUtil();
    List<Country> countries = util.getAllCountries();
    for(int j = 0; j < countries.size(); j++) { 
        Country country = (Country) countries.get(j);
        if(j == countries.size() - 1) {
            countryData += "'"+ country.getCode()+"':"+RequestDao.getNumberOfRequestByCountry(country.getCode());
        }
        else {
            countryData += "'"+country.getCode()+"':"+RequestDao.getNumberOfRequestByCountry(country.getCode())+",";
        } 
    }
    countryData += "}";
    
    
    String horizontalbarData = "[";
    horizontalbarData += RequestDao.getCountOfRequestsByDecision("Accepted")+",";
    horizontalbarData += RequestDao.getCountOfRequestsByDecision("Declined");
    horizontalbarData += "]";
%>
<script>
  const ctx = document.getElementById('myChart');

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
      datasets: [{
        label: 'Number of book requests per month',
        data: <%= reqCountList %>,
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
  
    const doughChart = document.getElementById('doughChart');
    
     var data1 = {
     labels: <%= categoryList %>,
    datasets: [
      {
        label: "Book Request by Category",
        data: <%= value %>,
        borderWidth: [1, 1, 1, 1, 1]
      }
    ]
  };

  new Chart(doughChart, {
    type: 'doughnut',
    data: data1
  });
  
  $(function(){
  var requestData = <%= countryData%>;
        $('#world-map').vectorMap(
            {  
                map: 'world_mill_en',
                normalizeFunction: 'polynomial',
                regionStyle: regionStyling,
                backgroundColor: "transparent",
		zoomOnScroll: false,
                series: {
                    regions:[{
                       values: requestData,
                       scale: ['#fd8082', '#0071A4'],
                       attribute: 'fill'
                    }]
                },
                onRegionTipShow: function(e, el, code) {
                    el.html( requestData[code] + ' Book Requests from ' + el.html());
                }
            }
        );
   var regionStyling = { initial: { fill: '#5c6366' }, hover: { fill: '#B0013A' }, selected: { fill: '#B0013A' } };
   
   const hbar = document.getElementById('hbar').getContext("2d");
    var hbarData = {
         labels: [
             "Accepted",
             "Declined"
         ],
         datasets: [{
             label: "Comparing accepted and declined book requests",
             data: <%= horizontalbarData %>,
             backgroundColor: ["#669911", "#119966"],
             hoverBackgroundColor: ["#66A2EB", "#FCCE56"]
         }]
    };

    var MeSeChart = new Chart(hbar, {
        type: 'bar',
        data: hbarData,
        options: {
            indexAxis: 'y',
            scales: {
                xAxes: [{
                    ticks: {
                        min: 0
                    }
                }],
                yAxes: [{
                    stacked: true
                }]
            }

        }
    });
  });
</script>
