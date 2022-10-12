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
        <c:set var="email" value="${sessionScope.email}" />
        <c:choose>
            <c:when test="${empty email}">
                <p style="color: red">You must login to view personal page</p>
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
                    <!-- Load all orders -->
                    <c:if test="${not empty param.orderid}">
                        <c:set var="list" value="${OrderDAO.getOrderDetail(Integer.parseInt(param.orderid.trim()))}" />
                        <c:choose>
                            <c:when test="${not empty list}">
                                <c:set var="money" value="0" />
                                <c:forEach var="detail" items="${list}">
                                    <c:set var="money" value="${money + detail.price * detail.quantity}" />
                                    <table class='order'>
                                        <tr>
                                            <td>Order ID</td>
                                            <td>Plant ID</td>
                                            <td>Plant Name</td>
                                            <td>Image</td>
                                            <td>Quantity</td>
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
                                <p>You don't have any order</p>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </section>
                <footer>
                    <%@include file="footer.jsp" %>
                </footer>
            </c:otherwise>
        </c:choose>
    </body>
</html>
