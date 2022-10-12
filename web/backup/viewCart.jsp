<%@page import="dao.PlantDAO"%>
<%@page import="dto.Plant"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
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
            <%                String email = (String) session.getAttribute("email");
                String warning = (String) request.getAttribute("warning");
                if (email != null) {
            %>
            <h3>Welcome <%= session.getAttribute("name")%> come back</h3>
            <h3><a href="MainController?action=logout">Logout</a></h3>
            <h3><a href="personalPage.jsp">Personal Page</a></h3>
            <%
                }
            %>
            <p style="color: red"><%= warning == null ? "" : warning%></p>
            <table width='100%' class='shopping'>
                <tr>
                    <td>Product ID</td>
                    <td>Image</td>
                    <td>Price</td>
                    <td>Quantity</td>
                    <td>Action</td>
                </tr>
                <%                    int total = 0;
                    HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cart");
                    if (cart != null) {
                        Set<String> pids = cart.keySet();
                        for (String pid : pids) {
                            int quantity = cart.get(pid);
                            Plant plant = PlantDAO.getPlant(Integer.parseInt(pid.trim()));
                            total += plant.getPrice() * quantity;
                %>
                <form action='MainController' method='post'>
                    <tr>
                        <td>
                            <input type="hidden" name='pid' value='<%= pid%>'>
                            <a href="GetPlantServlet?pid=<%= pid%>"><%= pid%></a>
                        </td>
                        <td><img src="<%= plant.getImgPath()%>" class="plantimg"></td>
                        <td><%= plant.getPrice()%></td>
                        <td><input type="number" name="quantity" value="<%= quantity%>" min='1' required></td>
                        <td>
                            <button type="submit" name="action" value="updateCart">Update</button>
                            <button type="submit" name='action' value="deleteCart">Delete</button>
                        </td>
                    </tr>
                </form>
                <%
                    }
                } else {
                %>
                <tr><td colspan="5">Your cart is empty</td></tr>
                <%
                    }
                %>
                <tr>
                    <td>Total money:</td>
                    <td><%= total%></td>
                </tr>
                <tr>
                    <td>Order date:</td>
                    <td><%= (new Date()).toString()%></td>
                </tr>
                <tr>
                    <td>Ship date:</td>
                    <td>N/A</td>
                </tr>
            </table>
        </section>
        <section>
            <form action="MainController" method="post">
                <button type="submit" name="action" value="saveOrder" class="submitorder">Save order</button>
            </form>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
