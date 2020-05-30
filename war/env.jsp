<!DOCTYPE html>
<html>
    <head></head>
    <body>
        <h1>Environment</h1>
        <ul>
            <li>You are connecting from: <%= request.getRemoteHost() %> (<%= request.getRemoteAddr() %>)</li>
            <li>If present your X-Forwarded-For header is: <%= request.getHeader("X-Forwarded-For") %></li>
        </ul>

        <h2>Header dump</h2>
        <pre>
<%
for (java.util.Enumeration<String> headers = request.getHeaderNames(); headers.hasMoreElements(); ) {
    String h = headers.nextElement();
%>
    <%= h %>=<%= request.getHeader(h) %>
<%
}
%>
        </pre>
    </body>