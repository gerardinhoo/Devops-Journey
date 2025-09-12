<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Country & Weather Dashboard</title>
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>
    <h1>Country & Weather Dashboard</h1>
    <form action="${pageContext.request.contextPath}/search" method="get">
      <input
        type="text"
        name="q"
        placeholder="Search a country (e.g., Ghana)"
        required
      />
      <button type="submit">Search</button>
    </form>
    <p>
      <a href="favorites.jsp">View Favorites</a>
    </p>
  </body>
</html>
