<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header Admin</title>
    </head>
    <body>
        <header>
            <ul>
                <li><a href="./" target="_blank"><img src="images/logo.jpg" id="logo"></a></li>
                <li><a href="MainController?action=manageAccounts">Manage Accounts</a></li>
                <li><a href="MainController?action=manageOrders">Manage Orders</a></li>
                <li><a href="MainController?action=managePlants">Manage Plants</a></li>
                <li><a href="MainController?action=manageCategories">Manage Categories</a></li>
                <li>Welcome ${sessionScope.name} | <a href="MainController?action=logout">Logout</a></li>
            </ul>
        </header>
    </body>
</html>
