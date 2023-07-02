<%-- 
    Document   : index
    Created on : 18 May 2023, 16:33:34
    Author     : vishwanath
--%>

<%@page session="true" import="java.util.*"%>
    <% Object loggedInSession = session.getAttribute("isLoggedIn");
    if(loggedInSession != null) {
        boolean isLoggedIn = (boolean)loggedInSession;
        if(!isLoggedIn) 
        {
            response.sendRedirect("login.jsp");
        }
    }
    else
    {
        response.sendRedirect("login.jsp");
    }%>
    <jsp:include page="header.jsp" flush="true" />
    <jsp:include page="books.jsp" flush="true" />
    </body>
</html>
