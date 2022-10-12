<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant's detail</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <section>
            <table>
                <jsp:useBean id="plant" class="dto.Plant" scope="request" />
                <tr>
                    <td rowspan="8"><img src="<jsp:getProperty name="plant" property="imgPath" />"></td>
                </tr>
                <tr>
                    <td>Id: <jsp:getProperty name="plant" property="id" /></td>
                </tr>
                <tr>
                    <td>Name: <jsp:getProperty name="plant" property="name" /></td>
                </tr>
                <tr>
                    <td>Price: <jsp:getProperty name="plant" property="price" /></td>
                </tr>
                <tr>
                    <td>Description: <jsp:getProperty name="plant" property="description" /></td>
                </tr>
                <tr>
                    <td>Status: <jsp:getProperty name="plant" property="status" /></td>
                </tr>
                <tr>
                    <td>Cate Id: <jsp:getProperty name="plant" property="cateId" /></td>
                </tr>
                <tr>
                    <td>Category: <jsp:getProperty name="plant" property="cateName" /></td>
                </tr>
            </table>

            <table>
                <tr>
                    <td rowspan="8"><img src="${requestScope.plant.imgPath}"></td>
                </tr>
                <tr>
                    <td>Id: ${requestScope.plant.id}</td>
                </tr>
                <tr>
                    <td>Name: ${requestScope.plant.name}</td>
                </tr>
                <tr>
                    <td>Price: ${requestScope.plant.price}</td>
                </tr>
                <tr>
                    <td>Description: ${requestScope.plant.description}</td>
                </tr>
                <tr>
                    <td>Status: ${requestScope.plant.status}</td>
                </tr>
                <tr>
                    <td>Cate Id: ${requestScope.plant.cateId}</td>
                </tr>
                <tr>
                    <td>Category: ${requestScope.plant.cateName}</td>
                </tr>
            </table>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
