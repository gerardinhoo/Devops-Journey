//Service class to call external APIs

package com.ge.dashboard.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ge.dashboard.model.Weather;

import java.io.IOException;
import java.net.URI;
import java.net.http.*;
public class WeatherService {
    private static final ObjectMapper MAPPER = new ObjectMapper();
    private static final HttpClient CLIENT = HttpClient.newHttpClient();

    public Weather current(double lat, double lng) throws IOException, InterruptedException {
        String url = String.format(
            "https://api.open-meteo.com/v1/forecast?latitude=%f&longitude=%f&current_weather=true",
            lat, lng);
        HttpRequest req = HttpRequest.newBuilder(URI.create(url)).GET().build();
        HttpResponse<String> resp = CLIENT.send(req, HttpResponse.BodyHandlers.ofString());
        if (resp.statusCode() != 200) return null;

        JsonNode n = MAPPER.readTree(resp.body()).path("current_weather");
        if (n.isMissingNode()) return null;

        double temp = n.path("temperature").asDouble();
        double wind = n.path("windspeed").asDouble();
        String time = n.path("time").asText();

        return new Weather(temp, wind, time);
    }
}
