<%@ page contentType="text/html; charset=UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>${not empty country ? country.name : 'Country not found'}</title>
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>
    <a href="index.jsp">← Back</a>
    <h1>${not empty country ? country.name : 'Country not found'}</h1>

    <c:choose>
      <c:when test="${not empty country}">
        <img src="${country.flagPngUrl}" alt="flag" style="height: 60px" />

        <ul>
          <li><b>Capital:</b> ${country.capital}</li>
          <li>
            <b>Population:</b>
            <fmt:formatNumber
              value="${country.population}"
              type="number"
              groupingUsed="true"
            />
          </li>
          <li>
            <b>Location:</b>
            <fmt:formatNumber value="${country.lat}" maxFractionDigits="4" />,
            <fmt:formatNumber value="${country.lng}" maxFractionDigits="4" />
          </li>
        </ul>

        <c:if test="${not empty weather}">
          <h3>Current Weather</h3>
          <ul>
            <li>
              <b>Temp (°C):</b>
              <fmt:formatNumber
                value="${weather.temperatureC}"
                maxFractionDigits="1"
              />
            </li>
            <li>
              <b>Wind (km/h):</b>
              <fmt:formatNumber
                value="${weather.windSpeed}"
                maxFractionDigits="1"
              />
            </li>
            <li><b>As of:</b> ${weather.time}</li>
          </ul>
        </c:if>

        <form
          action="${pageContext.request.contextPath}/search"
          method="post"
          style="margin-top: 16px"
        >
          <input type="hidden" name="name" value="${country.name}" />
          <button type="submit" name="action" value="add">
            Add to Favorites
          </button>
        </form>
      </c:when>

      <c:otherwise>
        <p>Try another search from the <a href="index.jsp">home page</a>.</p>
      </c:otherwise>
    </c:choose>
  </body>
</html>
