<%-- 
    Document   : main
    Created on : 23 Apr 2025, 11.34.55
    Author     : Pongo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <center>
            <ul>
                <li> <h1>NIM : </h1>
                    <%= request.getParameter("NIM") %>
                </li>
                <li> <h1>Nama : </h1>
                    <%= request.getParameter("Nama") %>
                </li>
                <li> <h1>Jenis Kelamin : </h1>
                    <%= request.getParameter("Jenis Kelamin") %>
                </li>
                <li> <h1>Tanggal Lahir : </h1>
                    <%= request.getParameter("Tanggal Lahir") %>
                </li>
                <li> <h1>Tempat Lahir : </h1>
                    <%= request.getParameter("Tempat Lahir") %>
                </li>
                <li> <h1>Jurusan : </h1>
                    <%= request.getParameter("Jurusan") %>
                </li>
                <li> <h1>Tahun Masuk : </h1>
                    <%= request.getParameter("Tahun Masuk") %>
                </li>
            </ul>

        </center>
        <style>
            ul{
                list-style: none;
            }    
        </style>
    </body>
</html>
