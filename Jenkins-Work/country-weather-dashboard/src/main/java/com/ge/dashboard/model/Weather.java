// Adding Weather model

package com.ge.dashboard.model;

public class Weather {
    private final double temperatureC;
    private final double windSpeed;
    private final String time;

    public Weather(double temperatureC, double windSpeed, String time) {
        this.temperatureC = temperatureC;
        this.windSpeed = windSpeed;
        this.time = time;
    }

    public double getTemperatureC() { return temperatureC; }
    public double getWindSpeed() { return windSpeed; }
    public String getTime() { return time; }
}
