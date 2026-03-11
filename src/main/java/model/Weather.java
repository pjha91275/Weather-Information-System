package model;

public class Weather {

    private String location;
    private double temperature;
    private double feelsLike;
    private double humidity;
    private double pressure;
    private double windSpeed;
    private String description;
    private String icon;
    private String searchTime;

    public Weather(){}

    public String getLocation(){
        return location;
    }

    public void setLocation(String location){
        this.location = location;
    }

    public double getTemperature(){
        return temperature;
    }

    public void setTemperature(double temperature){
        this.temperature = temperature;
    }

    public double getFeelsLike(){
        return feelsLike;
    }

    public void setFeelsLike(double feelsLike){
        this.feelsLike = feelsLike;
    }

    public double getHumidity(){
        return humidity;
    }

    public void setHumidity(double humidity){
        this.humidity = humidity;
    }

    public double getPressure(){
        return pressure;
    }

    public void setPressure(double pressure){
        this.pressure = pressure;
    }

    public double getWindSpeed(){
        return windSpeed;
    }

    public void setWindSpeed(double windSpeed){
        this.windSpeed = windSpeed;
    }

    public String getDescription(){
        return description;
    }

    public void setDescription(String description){
        this.description = description;
    }

    public String getIcon(){
        return icon;
    }

    public void setIcon(String icon){
        this.icon = icon;
    }

    public String getSearchTime(){
        return searchTime;
    }

    public void setSearchTime(String searchTime){
        this.searchTime = searchTime;
    }
}