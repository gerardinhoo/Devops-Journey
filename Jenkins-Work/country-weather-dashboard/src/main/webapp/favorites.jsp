<%@ page contentType="text/html;charset=UTF-8" %> <%@ page import="java.util.*"
%> <% List<String>
  favs = (List<String
    >) session.getAttribute("favorites"); if (favs == null) favs = new
    ArrayList<>(); %>
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="UTF-8" />
        <title>Favorites</title>
        <link rel="stylesheet" href="styles.css" />
      </head>
      <body>
        <a href="index.jsp">← Back</a>
        <h1>Favorites</h1>
        <ul>
          <% for (String name : favs) { %>
          <li>
            <%= name %>
            <form action="search" method="post" style="display: inline">
              <input type="hidden" name="name" value="<%= name %>" />
              <button type="submit" name="action" value="remove">Remove</button>
            </form>
          </li>
          <% } %>
        </ul>
        <p><i><%= favs.isEmpty() ? "No favorites yet." : "" %></i></p>
      </body>
    </html>
  </String></String
>
