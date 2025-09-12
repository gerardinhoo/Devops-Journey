// Adding CountryInfo model

package com.ge.dashboard.model;

public class CountryInfo {
    private final String name;
    private final String capital;
    private final double lat;
    private final double lng;
    private final long population;
    private final String flagPngUrl;

    public CountryInfo(String name, String capital, double lat, double lng, long population, String flagPngUrl) {
        this.name = name;
        this.capital = capital;
        this.lat = lat;
        this.lng = lng;
        this.population = population;
        this.flagPngUrl = flagPngUrl;
    }

    public String getName() { return name; }
    public String getCapital() { return capital; }
    public double getLat() { return lat; }
    public double getLng() { return lng; }
    public long getPopulation() { return population; }
    public String getFlagPngUrl() { return flagPngUrl; }
}
