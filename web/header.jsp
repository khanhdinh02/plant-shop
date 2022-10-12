<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>
    </head>
    <body>
        <header>
            <nav>
                <ul>
                    <li><a href="./"><img src="images/logo.jpg" id="logo"></a></li>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="registration.jsp">Register</a></li>
                    <li><a href="login.jsp" >Login</a></li>
                    <li><a href="viewCart.jsp">View cart</a></li>
                    <li>
                        <form action="MainController" method="post" class="form">
                            <input type="text" name="txtsearch"
                                   value='${param.txtsearch}'>
                            <select name="searchby">
                                <option value="byname" ${param.searchby.equals("byname") ? "selected" : ""}>by name</option>
                                <option value="bycate" ${param.searchby.equals("bycate") ? "selected" : ""}>by category</option>
                            </select>
                            <input type="submit" value="search" name="action" >
                        </form>
                    </li>
                </ul>
            </nav>
        </header>
    </body>
</html>
