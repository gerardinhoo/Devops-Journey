// Service class to call external APIs

package com.ge.dashboard.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ge.dashboard.model.CountryInfo;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class CountryService {
    private static final ObjectMapper MAPPER = new ObjectMapper();
    private static final HttpClient CLIENT = HttpClient.newHttpClient();

    public CountryInfo findByName(String q) throws IOException, InterruptedException {
        String url = "https://restcountries.com/v3.1/name/" + q +
                "?fields=name,capital,latlng,population,flags";
        HttpRequest req = HttpRequest.newBuilder(URI.create(url)).GET().build();
        HttpResponse<String> resp = CLIENT.send(req, HttpResponse.BodyHandlers.ofString());
        if (resp.statusCode() != 200) return null;

        JsonNode arr = MAPPER.readTree(resp.body());
        if (!arr.isArray() || arr.size() == 0) return null;

        JsonNode n = arr.get(0);
        String name = n.path("name").path("common").asText("");
        String capital = n.path("capital").isArray() && n.path("capital").size() > 0
                ? n.path("capital").get(0).asText("") : "";
        double lat = n.path("latlng").isArray() && n.path("latlng").size() > 0 ? n.path("latlng").get(0).asDouble() : 0;
        double lng = n.path("latlng").isArray() && n.path("latlng").size() > 1 ? n.path("latlng").get(1).asDouble() : 0;
        long population = n.path("population").asLong(0);
        String flag = n.path("flags").path("png").asText("");

        return new CountryInfo(name, capital, lat, lng, population, flag);
    }
}
