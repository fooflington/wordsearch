<%@ page contentType="text/html" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Database dump</title>
    </head>
    <body>
        <h1>Database stats</h1>
        <%
        Connection conn =
        DriverManager.getConnection("jdbc:sqlite:" + getServletContext().getRealPath("/WEB-INF/files/database.sqlite"));
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from sqlite_master where type='table' and name='grids';");
        if(rs.next()) {
            // we have a row and are probably ok
        } else {
            // Initialise the schema
            PreparedStatement pstmt = conn.prepareStatement("CREATE TABLE grids (id integer primary key, ts timestamp default current_timestamp, remotehost varchar, input, size_x int, size_y int, simple tinyint, result varchar);");
            pstmt.execute();
        }

        rs.close();

        PreparedStatement ps_count = conn.prepareStatement("SELECT COUNT(*) FROM grids");
        PreparedStatement ps_last = conn.prepareStatement("SELECT max(ts) FROM grids;");

        ResultSet rs_count = ps_count.executeQuery();
        ResultSet rs_last = ps_last.executeQuery();
        int count = -1;
        String last = "unknown";
        if(rs_count.next()) {
            count = rs_count.getInt(1);
        }
        if(rs_last.next()) {
            last = rs_last.getString(1);
        }
        rs_count.close();
        rs_last.close();
        %>

        <ul>
            <li>Number of grids generated: <%= count %></li>
            <li>Last grid generated at: <%= last %></li>
            <li>Path to db: <pre><%= getServletContext().getRealPath("/WEB-INF/files/database.sqlite") %></pre></li>
        </ul>
    </body>
    <%
        conn.close();
    %>
</html>