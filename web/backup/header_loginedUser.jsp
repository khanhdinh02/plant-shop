<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="profile.jsp">Change profile</a></li>
                <li><a href="personalPage.jsp?order_status=2">Completed orders</a></li>
                <li><a href="personalPage.jsp?order_status=3">Canceled orders</a></li>
                <li><a href="personalPage.jsp?order_status=1">Processing orders</a></li>
                <li>
                    <form action="personalPage.jsp">
                        From <input type="date" name="from" value="<%= request.getParameter("from")%>"> to <input type="date" name="to" value="<%= request.getParameter("to")%>">
                        <input type="submit" value="search">
                    </form>
                </li>
            </ul>
        </nav>
    </body>
</html>
