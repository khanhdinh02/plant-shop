<%@page import="dto.Plant"%>
<%@page import="dao.PlantDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <section>
            <%
                String keyword = request.getParameter("txtsearch");
                String searchBy = request.getParameter("searchby");
                List<Plant> list;
                String[] tmp = {"out of stock", "available"};
                if (keyword == null && searchBy == null) {
                    list = PlantDAO.getPlants("", "");
                } else {
                    list = PlantDAO.getPlants(keyword, searchBy);
                }
                if (list != null && !list.isEmpty()) {
                    for (Plant plant : list) {
            %>
            <table class="product">
                <tr>
                    <td><img src="<%= plant.getImgPath()%>" class="plantimg"></td>
                    <td>Product ID: <%= plant.getId()%></td>
                    <td>Product name: <%= plant.getName()%></td>
                    <td>Price: <%= plant.getPrice()%></td>
                    <td>Status: <%= plant.getStatus()%></td>
                    <td>Category: <%= plant.getCateName()%></td>
                    <td><a href='MainController?action=addtocart&pid=<%= plant.getId()%>'>Add to cart</a></td>
                </tr>
            </table>
            <%
                    }
                }
            %>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
