<%@page import="java.sql.Date"%>
<%@page import="dao.AccountDAO"%>
<%@page import="dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My orders</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <c:set var="name" value="${sessionScope.name}" />
        <c:set var="email" value="${sessionScope.email}" />
        <c:set var="role" value="${sessionScope.role}" />
        <c:set var="login" value="false" />
        <c:choose>
            <c:when test="${empty email}">
                <c:set var="acc" value="${AccountDAO.getAccount(cookie.token.value, AccountDAO.GET_ACCOUNT_BY_TOKEN)}" />
                <c:if test="${not empty acc}">
                    <c:set var="name" value="${acc.fullname}" />
                    <c:set var="email" value="${acc.email}" />
                    <c:set var="role" value="${acc.role}" />
                    <c:set var="name" value="${name}" scope="session" />
                    <c:set var="email" value="${email}" scope="session" />
                    <c:set var="role" value="${role}" scope="session" />
                    <c:set var="login" value="true" />
                </c:if>
            </c:when>
            <c:otherwise>
                <c:set var="login" value="true" />
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${!login}">
                <p style="color: red">You must login to view personal page</p>
            </c:when>
            <c:otherwise>
                <header>
                    <%@include file="header_loginedUser.jsp" %>
                </header>
                <section>
                    <h3>Welcome ${name} come back</h3>
                    <h3><a href="MainController?action=logout">Logout</a></h3>
                </section>
                <section>
                    <!-- Load all orders -->
                    <c:set var="status" value='${["", "processing", "completed", "canceled"]}' />
                    <c:set var="orderStatus" value="${param.order_status}" />
                    <c:if test="${empty orderStatus}">
                        <c:set var="orderStatus" value="0" />
                    </c:if>
                    <c:if test="${not empty param.from}">
                        <c:set var="startDate" value="${Date.valueOf(param.from)}" />
                    </c:if>
                    <c:if test="${not empty param.to}">
                        <c:set var="endDate" value="${Date.valueOf(param.to)}" />
                    </c:if>
                    <c:set var="list" value="${OrderDAO.getOrdersByDate(email, startDate, endDate)}" />
                    <c:choose>
                        <c:when test="${not empty list}">
                            <c:forEach var="order" items="${list}">
                                <c:if test="${orderStatus == 0 || order.status == orderStatus}">
                                    <table class='order'>
                                        <tr>
                                            <td>Order ID</td>
                                            <td>Order Date</td>
                                            <td>Ship Date</td>
                                            <td>Order's status</td>
                                            <td>Action</td>
                                        </tr>
                                        <tr>
                                            <td>${order.orderID}</td>
                                            <td>${order.orderDate}</td>
                                            <td>${order.shipDate}</td>
                                            <td>
                                                ${status[order.status]}<br>
                                                <c:if test="${order.status == 1}">
                                                    <a href="MainController?action=cancel_order&orderid=${order.orderID}">Cancel order</a>
                                                </c:if>
                                                <c:if test="${order.status == 3}">
                                                    <a href="MainController?action=order_again&orderid=${order.orderID}">Order again</a>
                                                </c:if>
                                            </td>
                                            <td><a href="orderDetail.jsp?orderid=${order.orderID}">Detail</a></td>
                                        </tr>
                                    </table>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p>You don't have any order</p>
                        </c:otherwise>
                    </c:choose>
                </section>
                <footer>
                    <%@include file="footer.jsp" %>
                </footer>
            </c:otherwise>
        </c:choose>
    </body>
</html>
