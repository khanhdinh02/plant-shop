<%@page import="java.sql.Date"%>
<%@page import="dao.AccountDAO"%>
<%@page import="dto.Account"%>
<%@page import="java.util.Arrays"%>
<%@page import="dto.Order"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <%
            String name = (String) session.getAttribute("name");
            String email = (String) session.getAttribute("email");
            Cookie[] cookies = request.getCookies();
            boolean login = false;
            if (email == null) {
                String token = "";
                if (cookies != null) {
                    for (Cookie c : cookies) {
                        if (c.getName().equals("token")) {
                            token = c.getValue();
                            System.out.println("Stored token: " + token);
                            Account acc = AccountDAO.getAccount(token, AccountDAO.GET_ACCOUNT_BY_TOKEN);
                            if (acc != null) {
                                name = acc.getFullname();
                                email = acc.getEmail();
                                session.setAttribute("name", name);
                                session.setAttribute("email", email);
                                login = true;
                            }
                        }
                    }
                }
            } else {
                login = true;
            }
            if (!login) {
        %>
        <p style="color: red">You must login to view personal page</p>
        <%
        } else {
        %>
        <header>
            <%@include file="header_loginedUser.jsp" %>
        </header>
        <section>
            <h3>Welcome <%= name%> come back</h3>
            <h3><a href="MainController?action=logout">Logout</a></h3>
        </section>
        <section>
            <!-- Load all orders -->
            <%
                String[] status = {"", "processing", "completed", "canceled"};
                String order_status = request.getParameter("order_status");
                int orderStatus = 0;
                String startDateStr = request.getParameter("from");
                String endDateStr = request.getParameter("to");
                Date startDate = null;
                Date endDate = null;

                // Filter by status
                if (order_status != null && Arrays.asList("1", "2", "3").contains(order_status.trim())) {
                    orderStatus = Integer.parseInt(order_status.trim());
                }

                // Filter by date
                try {
                    startDate = Date.valueOf(startDateStr);
                } catch (Exception e) {
                }
                try {
                    endDate = Date.valueOf(endDateStr);
                } catch (Exception e) {
                }
                List<Order> list = OrderDAO.getOrdersByDate(email, startDate, endDate);

                if (list != null && !list.isEmpty()) {
                    for (Order order : list) {
                        // Display all orders, or by order's status
                        if (orderStatus == 0 || order.getStatus() == orderStatus) {
            %>
            <table class='order'>
                <tr>
                    <td>Order ID</td>
                    <td>Order Date</td>
                    <td>Ship Date</td>
                    <td>Order's status</td>
                    <td>Action</td>
                </tr>
                <tr>
                    <td><%= order.getOrderID()%></td>
                    <td><%= order.getOrderDate()%></td>
                    <td><%= order.getShipDate()%></td>
                    <td>
                        <%= status[order.getStatus()]%><br>
                        <% if (order.getStatus() == 1) {%><a href="MainController?action=cancel_order&orderid=<%= order.getOrderID()%>">Cancel order</a>
                        <% } else if (order.getStatus() == 3) {%><a href="MainController?action=order_again&orderid=<%= order.getOrderID()%>">Order again</a><% }%>
                    </td>
                    <td><a href="orderDetail.jsp?orderid=<%= order.getOrderID()%>">Detail</a></td>
                </tr>
            </table>
            <%
                    }
                }
            } else {
            %>
            <p>You don't have any order</p>
            <% } %>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <%
            }
        %>
    </body>
</html>
