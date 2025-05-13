<%-- 
    Document   : db
    Created on : 23 Apr 2025, 11.35.25
    Author     : Pongo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
        <%
Connection connection = null;
String status = "";
try {
    String connectionURL = "jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false";
    String username = "root";
    String password = "";
    Class.forName("com.mysql.cj.jdbc.Driver");
    connection = DriverManager.getConnection(connectionURL, username, password);
    status = "Mantap Udah Masuk Mas!";
} catch (ClassNotFoundException ex) {
    status = "Drivernya Kacau Mas!";
} catch (SQLException ex) {
    status = "MySQL-nya Kacau Mas! Pesan: " + ex.getMessage();
} finally {
    if (connection != null) {
        try {
            connection.close();
        } catch (SQLException ex) {
            status += " Gagal nutup koneksi!";
        }
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%=status%>
    </body>
</html>
