<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage accounts</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <c:import url="header_loginedAdmin.jsp" />
        <form action="MainController" method="post">
            <input type="text" name="txtsearch" value="${param.txtsearch}" placeholder="Fullname">
            <button type="submit" name="action" value="searchAccounts">Search accounts</button>
        </form>
        <table class="order">
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Fullname</th>
                <th>Status</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            <c:forEach var="acc" items="${requestScope.accountList}">
                <tr>
                    <td>${acc.accID}</td>
                    <td>${acc.email}</td>
                    <td>${acc.fullname}</td>
                    <td>${(acc.status == 1) ? "Active" : "Inactive"}</td>
                    <td>${acc.phone}</td>
                    <td>${(acc.role == 1) ? "Admin" : "User"}</td>
                    <td>
                        <c:if test="${acc.role == 0}">
                            <c:url var="blockUrl" value="MainController">
                                <c:param name="action" value="updateAccountStatus" />
                                <c:param name="email" value="${acc.email}" />
                                <c:param name="status" value="${acc.status}" />
                            </c:url>
                            <a href="${blockUrl}">${(acc.status == 1) ? "Block" : "Unblock"}</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
