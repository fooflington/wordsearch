<%@ page contentType="text/html" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Database dump</title>
    </head>
    <body>
        <table border="1">
            <thead>
                <th>id</th>
                <th>timestamp</th>
                <th>remotehost</th>
                <th>input</th>
                <th>size_x</th>
                <th>size_y</th>
                <th>simple</th>
                <th>result</th>
            </thead>
            <tbody>
                <%
                Connection conn =
                    DriverManager.getConnection("jdbc:sqlite:" + getServletContext().getInitParameter("sqlite_db"));
                Statement stat = conn.createStatement();

                ResultSet rs = stat.executeQuery("select * from grids;");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("id") + "</td>");
                    out.println("<td>" + rs.getString("ts") + "</td>");
                    out.println("<td>" + rs.getString("remotehost") + "</td>");
                    out.println("<td><pre>" + rs.getString("input") + "</pre></td>");
                    out.println("<td>" + rs.getInt("size_x") + "</td>");
                    out.println("<td>" + rs.getInt("size_y") + "</td>");
                    out.println("<td>" + rs.getInt("simple") + "</td>");
                    out.println("<td><pre>" + rs.getString("result") + "</pre></td>");
                    out.println("</tr>");
                }

                rs.close();
                conn.close();
                %>
            </tbody>

        </table>
    </body>
</html>