<%@page import="java.util.Date"%>
<%@page import="dao.PlantDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="cus" uri="/WEB-INF/tlds/custom"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <section>
            <c:set var="email" value="${sessionScope.email}" />
            <c:if test="${not empty email}">
                <h3>Welcome ${sessionScope.name} come back</h3>
                <h3><a href="MainController?action=logout">Logout</a></h3>
                <h3><a href="personalPage.jsp">Personal Page</a></h3>
            </c:if>
            <p style="color: red">${requestScope.warning}</p>
            <table width='100%' class='shopping'>
                <tr>
                    <td>Product ID</td>
                    <td>Image</td>
                    <td>Price</td>
                    <td>Quantity</td>
                    <td>Action</td>
                </tr>
                <c:set var="canSave" value="true" />
                <c:set var="total" value="0" />
                <c:set var="cart" value="${sessionScope.cart}" />
                <c:choose>
                    <c:when test="${not empty cart}">
                        <c:forEach var="item" items="${cart}">
                            <c:set var="pid" value="${item.key}" />
                            <c:set var="quantity" value="${item.value}" />
                            <c:set var="plant" value="${PlantDAO.getPlant(pid)}" />
                            <c:set var="total" value="${total + plant.price * quantity}" />
                            <form action='MainController' method='post'>
                                <tr>
                                    <td>
                                        <input type="hidden" name='pid' value='${pid}'>
                                        <a href="MainController?action=plantDetail&pid=${pid}">${pid}</a>
                                    </td>
                                    <td><img src="${plant.imgPath}" class="plantimg"></td>
                                    <td>${plant.price}</td>
                                    <td><input type="number" name="quantity" value="${quantity}" min='1' required></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${plant.status == 1}">
                                                <button type="submit" name="action" value="updateCart">Update</button>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="canSave" value="false" />
                                                Out of stock
                                            </c:otherwise>
                                        </c:choose>
                                        <button type="submit" name='action' value="deleteCart">Delete</button>
                                    </td>
                                </tr>
                            </form>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="5">Your cart is empty</td></tr>
                    </c:otherwise>
                </c:choose>
                <tr>
                    <td>Total money:</td>
                    <td>${total}</td>
                </tr>
                <tr>
                    <td>Order date:</td>
                    <td><cus:TimeNow /></td>
                </tr>
                <tr>
                    <td>Ship date:</td>
                    <td>N/A</td>
                </tr>
            </table>
        </section>
        <section>
            <form action="MainController" method="post">
                <button type="submit" name="action" value="saveOrder" class="submitorder" ${!canSave ? "disabled" : ""}>Save order</button>
            </form>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
