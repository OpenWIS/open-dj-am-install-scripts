<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%--
spGetTokenId.jsp
Patch for get the token.
- receives the get token request.
- returns the token which is stored in the cookie named "iPlanetDirectoryPro".
--%>

<%
String token = "";
if (request.getCookies() != null) {
for (Cookie cookie : request.getCookies()) {
if ("iPlanetDirectoryPro".equals(cookie.getName())) {
token = cookie.getValue(
}
}
}
response.sendRedirect(request.getParameter("spTokenAddress") + token);