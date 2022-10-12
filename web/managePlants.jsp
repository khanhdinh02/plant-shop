<%@page import="dao.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage plants</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <c:import url="header_loginedAdmin.jsp" />
        <c:set var="cateList" value='${CategoryDAO.getCategories("")}' />
        <form action="MainController" method="post">
            <input type="text" name="txtsearch" value="${param.txtsearch}" placeholder="Name">
            <button type="submit" name="action" value="searchPlants">Search plants</button>
        </form>
        <table class="order">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Image</th>
                <th>Description</th>
                <th>Status</th>
                <th>Category</th>
                <th>Action</th>
            </tr>
            <c:forEach var="plant" items="${requestScope.plantList}">
                <form action="MainController" method="post" enctype="multipart/form-data">
                    <tr>
                        <td><input type="hidden" name="id" value="${plant.id}">
                            ${plant.id}
                        </td>
                        <td><input type="text" name="name" value="${plant.name}"></td>
                        <td><input type="number" name="price" min="0" value="${plant.price}"></td>
                        <td>
                            <img src="${plant.imgPath}" class="plantimg">
                            <input type="file" accept="image/*" name="img">
                        </td>
                        <td><input type="text" name="description" value="${plant.description}"></td>
                        <td>${(plant.status == 1) ? "Available" : "Out of stock"}</td>
                        <td>
                            <select name="cateId">
                                <c:forEach var="cate" items="${cateList}">
                                    <option value="${cate.cateId}" ${(cate.cateId == plant.cateId) ? "selected" : ""}>${cate.cateId} | ${cate.cateName}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>
                            <p><a href="MainController?action=updatePlantStatus&id=${plant.id}&status=${plant.status}">
                                    ${plant.status == 1 ? "Stop" : "Continue"}
                                </a></p>
                            <button type="submit" name="action" value="updatePlant">Update</button>
                        </td>
                    </tr>
                </form>
            </c:forEach>
            <form action="MainController" method="post" enctype="multipart/form-data">
                <tr>
                    <td></td>
                    <td><input type="text" name="name"></td>
                    <td><input type="number" name="price" min="0"></td>
                    <td><input type="file" accept="image/*" name="img"></td>
                    <td><input type="text" name="description"></td>
                    <td></td>
                    <td>
                        <select name="cateId">
                            <c:forEach var="cate" items="${cateList}">
                                <option value="${cate.cateId}">${cate.cateId} | ${cate.cateName}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <button type="submit" name="action" value="addPlant">Add</button>
                    </td>
                </tr>
            </form>
        </table>
    </body>
</html>
