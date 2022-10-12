<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage categories</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <c:import url="header_loginedAdmin.jsp" />
        <form action="MainController" method="post">
            <input type="text" name="txtsearch" value="${param.txtsearch}">
            <button type="submit" name="action" value="searchCate">Search categories</button>
        </form>
        <table class="order">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Action</th>
            </tr>
            <c:forEach var="cate" items="${requestScope.categoryList}">
                <form action="MainController" method="post">
                    <tr>
                        <td>
                            <input type="hidden" name="cateId" value="${cate.cateId}">
                            ${cate.cateId}
                        </td>
                        <td><input type="text" name="cateName" value="${cate.cateName}"></td>
                        <td><button type="submit" name="action" value="updateCateName">Update</button></td>
                    </tr>
                </form>
            </c:forEach>
            <form action="MainController" method="post">
                <tr>
                    <td></td>
                    <td><input type="text" name="cateName"></td>
                    <td><button type="submit" name="action" value="addCate">Add</button></td>
                </tr>
            </form>
        </table>
    </body>
</html>
