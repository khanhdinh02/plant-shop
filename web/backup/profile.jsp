<%@page import="dao.AccountDAO"%>
<%@page import="dto.Account"%>
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
            if (name == null) {
        %>
        <p style="color: red">You must login to view your profile</p>
        <%
        } else {
        %>
        <header>
            <%@include file="header_loginedUser.jsp" %>
        </header>
        <section>
            <h3>Welcome <%= name%> come back</h3>
            <h3><a href="MainController?action=logout">Logout</a></h3>
            <a href="personalPage.jsp">View all orders</a>
        </section>
        <section>
            <!-- Load user's profile -->
            <%
                String email = (String) session.getAttribute("email");
                Account acc = AccountDAO.getAccount(email, AccountDAO.GET_ACCOUNT_BY_EMAIL);
            %>
            <form action="MainController" method="post" class="form">
                <table>
                    <tr>
                        <td>Email</td>
                        <td><input type="email" value="<%= acc.getEmail()%>" disabled></td>
                    </tr>
                    <tr>
                        <td>Fullname</td>
                        <td><input type="text" name="fullname" value="<%= acc.getFullname()%>"</td>
                    </tr>
                    <tr>
                        <td>Phone</td>
                        <td><input type="tel" name="phone" value="<%= acc.getPhone()%>"</td>
                    </tr>
                    <tr>
                        <td>Role</td>
                        <td><input type="text" value="<%= (acc.getRole() == 1) ? "Admin" : "Customer"%>" disabled></td>
                    </tr>
                    <tr><td colspan="2"><button type="submit" name="action" value="changeProfile">Change Profile</button></td></tr>
                </table>
            </form>
            <%
                String message = (String) request.getAttribute("message");
            %>
            <p style="color: <%= response.getStatus() >= 400 ? "red" : "green"%>"><%= message != null ? message : ""%></p>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <%
            }
        %>
    </body>
</html>
