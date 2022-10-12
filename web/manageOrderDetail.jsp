<%@page import="dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order's detail</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <header>
            <%@include file="header_loginedAdmin.jsp" %>
        </header>
        <section>
            <a href="MainController?action=manageOrders">View all orders</a>
        </section>
        <section>
            <c:set var="list" value="${requestScope.detail}" />
            <c:choose>
                <c:when test="${not empty list}">
                    <c:set var="money" value="0" />
                    <c:forEach var="detail" items="${list}">
                        <c:set var="money" value="${money + detail.price * detail.quantity}" />
                        <table class='order'>
                            <tr>
                                <th>Order ID</th>
                                <th>Plant ID</th>
                                <th>Plant Name</th>
                                <th>Image</th>
                                <th>Quantity</th>
                            </tr>
                            <tr>
                                <td>${detail.orderID}</td>
                                <td>${detail.plantID}</td>
                                <td>${detail.plantName}</td>
                                <td>
                                    <img src="${detail.imgPath}" class="plantimg"><br>
                                    ${detail.price}
                                </td>
                                <td>${detail.quantity}</td>
                            </tr>
                        </table>
                    </c:forEach>
                    <h3>Total money: ${money}</h3>
                </c:when>
                <c:otherwise>
                    <p>Order does not have anything lmao</p>
                </c:otherwise>
            </c:choose>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
