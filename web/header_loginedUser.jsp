<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header User</title>
    </head>
    <body>
        <nav>
            <ul>
                <li><a href="./">Home</a></li>
                <li><a href="profile.jsp">Change profile</a></li>
                <li><a href="personalPage.jsp?order_status=2">Completed orders</a></li>
                <li><a href="personalPage.jsp?order_status=3">Canceled orders</a></li>
                <li><a href="personalPage.jsp?order_status=1">Processing orders</a></li>
                    <c:if test="${sessionScope.role == 1}">
                    <li><a href="MainController?action=manageAccounts" target="_blank">Admin Page</a></li>
                    </c:if>
                <li>
                    <form action="personalPage.jsp">
                        From <input type="date" name="from" value="${param.from}"> to <input type="date" name="to" value="${param.to}">
                        <input type="submit" value="search">
                    </form>
                </li>
            </ul>
        </nav>
    </body>
</html>
