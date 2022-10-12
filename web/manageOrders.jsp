<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage orders</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <c:import url="header_loginedAdmin.jsp" />
        <c:set var="status" value='${["", "processing", "completed", "canceled"]}' />
        <form action="MainController">
            From <input type="date" name="from" value="${param.from}"> to <input type="date" name="to" value="${param.to}">
            <button type="submit" name="action" value="manageOrders">Search</button>
        </form>
        <table class="order">
            <tr>
                <th>ID</th>
                <th>Order Date</th>
                <th>Ship Date</th>
                <th>Status</th>
                <th>Account ID</th>
                <th>Action</th>
            </tr>
            <c:forEach var="order" items="${requestScope.orderList}">
                <tr>
                    <td><a href="MainController?action=manageOrderDetail&id=${order.orderID}">${order.orderID}</a></td>
                    <td>${order.orderDate}</td>
                    <td>${order.shipDate}</td>
                    <td>${status[order.status]}</td>
                    <td><a href="MainController?action=manageOrders&accId=${order.accID}">${order.accID}</a></td>
                    <td>
                        <c:url var="changeStatus" value="MainController">
                            <c:param name="action" value="updateOrderStatus" />
                            <c:param name="orderID" value="${order.orderID}" />
                            <c:param name="status" value="${order.status}" />
                        </c:url>
                        <c:choose>
                            <c:when test="${order.status == 1}">
                                <a href="${changeStatus}">Complete order</a>
                            </c:when>
                            <c:when test="${order.status == 2}">
                                <a href="${changeStatus}">Return processing</a>
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
