<%@page import="dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <c:set var="email" value="${sessionScope.email}" />
        <c:choose>
            <c:when test="${empty email}">
                <p style="color: red">You must login to view your profile</p>
            </c:when>
            <c:otherwise>
                <header>
                    <%@include file="header_loginedUser.jsp" %>
                </header>
                <section>
                    <h3>Welcome ${sessionScope.name} come back</h3>
                    <h3><a href="MainController?action=logout">Logout</a></h3>
                    <a href="personalPage.jsp">View all orders</a>
                </section>
                <section>
                    <!-- Load user's profile -->
                    <c:set var="acc" value="${AccountDAO.getAccount(sessionScope.email, AccountDAO.GET_ACCOUNT_BY_EMAIL)}" />
                    <form action="MainController" method="post" class="form">
                        <table>
                            <tr>
                                <td>Email</td>
                                <td><input type="email" value="${acc.email}" disabled></td>
                            </tr>
                            <tr>
                                <td>Fullname</td>
                                <td><input type="text" name="fullname" value="${acc.fullname}"</td>
                            </tr>
                            <tr>
                                <td>Phone</td>
                                <td><input type="tel" name="phone" value="${acc.phone}"</td>
                            </tr>
                            <tr>
                                <td>Role</td>
                                <td><input type="text" value="${(acc.role == 1) ? "Admin" : "Customer"}" disabled></td>
                            </tr>
                            <tr><td colspan="2"><button type="submit" name="action" value="changeProfile">Change Profile</button></td></tr>
                        </table>
                    </form>
                    <p style="color: ${pageContext.response.getStatus() >= 400 ? "red" : "green"}">${requestScope.message}</p>
                </section>
                <footer>
                    <%@include file="footer.jsp" %>
                </footer>
            </c:otherwise>
        </c:choose>
    </body>
</html>
