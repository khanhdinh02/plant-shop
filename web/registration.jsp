<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="mycss.css" type="text/css" />
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <section>
            <form action="MainController" method="POST" class="form">
                <h1>Register</h1>
                <table>
                    <tr>
                        <td>email</td>
                        <td><input type="text" name="txtemail" value="${requestScope.txtemail}" pattern="^(\w)+@[a-zA-Z]+([.](\w)+){1,2}" required></td>
                    </tr>
                    <tr>
                        <td>full name</td>
                        <td><input type="text" name="txtfullname" value="${requestScope.txtfullname}" required></td>
                    </tr>
                    <tr>
                        <td>password</td>
                        <td><input type="password" name="txtpassword" required></td>
                    </tr>
                    <tr>
                        <td>phone</td>
                        <td>
                            <input type="text" name="txtphone" value="${requestScope.txtphone}">
                            ${requestScope.error}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="register" name="action"></td>
                    </tr>
                </table>
            </form>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
