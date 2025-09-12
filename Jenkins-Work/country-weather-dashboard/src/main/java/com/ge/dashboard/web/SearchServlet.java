// Servlets (controllers)

package com.ge.dashboard.web;

import com.ge.dashboard.model.CountryInfo;
import com.ge.dashboard.model.Weather;
import com.ge.dashboard.service.CountryService;
import com.ge.dashboard.service.WeatherService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {
    private final CountryService countryService = new CountryService();
    private final WeatherService weatherService = new WeatherService();

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String q = req.getParameter("q");
        if (q == null || q.isBlank()) {
            req.getRequestDispatcher("/index.jsp").forward(req, res);
            return;
        }

        try {
            CountryInfo c = countryService.findByName(q.trim());
            if (c != null && c.getLat() != 0 && c.getLng() != 0) {
    Weather w = weatherService.current(c.getLat(), c.getLng());
    req.setAttribute("country", c);
    req.setAttribute("weather", w);
} else {
    req.setAttribute("country", null);
    req.setAttribute("weather", null);
}

            // favorites in session
            HttpSession session = req.getSession();
            List<String> favs = (List<String>) session.getAttribute("favorites");
            if (favs == null) {
                favs = new ArrayList<>();
                session.setAttribute("favorites", favs);
            }
            req.getRequestDispatcher("/country.jsp").forward(req, res);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new ServletException(e);
        }
    }

    // Add/remove favorites via POST
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String action = req.getParameter("action");
        String name = req.getParameter("name");
        HttpSession session = req.getSession();
        List<String> favs = (List<String>) session.getAttribute("favorites");
        if (favs == null) {
            favs = new ArrayList<>();
            session.setAttribute("favorites", favs);
        }
        if ("add".equals(action) && name != null && !name.isBlank() && !favs.contains(name)) {
            favs.add(name);
        } else if ("remove".equals(action)) {
            favs.remove(name);
        }
        res.sendRedirect(req.getContextPath() + "/favorites.jsp");
    }
}
