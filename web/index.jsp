<%@page import="dao.PlantDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <section>
            <c:set var="keyword" value="${param.txtsearch}" />
            <c:set var="searchBy" value="${param.searchby}" />
            <c:set var="tmp" value='${["out of stock", "available"]}' />
            <c:if test="${keyword == null && searchBy == null}" var="result">
                <c:set var="list" value="${PlantDAO.getPlants('', '')}" />
            </c:if>
            <c:if test="${!result}">
                <c:set var="list" value="${PlantDAO.getPlants(keyword, searchBy)}" />
            </c:if>
            <c:if test="${not empty list}">
                <c:forEach var="plant" items="${list}">
                    <table class="product">
                        <tr>
                            <td><img src="${plant.imgPath}" class="plantimg"></td>
                            <td>Product ID: ${plant.id}</td>
                            <td>Product name: ${plant.name}</td>
                            <td>Price: ${plant.price}</td>
                            <td>Status: ${tmp[plant.status]}</td>
                            <td>Category: ${plant.cateName}</td>
                            <td>
                                <c:if test="${plant.status == 1}">
                                    <a href='MainController?action=addtocart&pid=${plant.id}'>Add to cart</a>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </c:forEach>
            </c:if>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
