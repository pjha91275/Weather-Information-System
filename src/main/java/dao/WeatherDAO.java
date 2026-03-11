package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Weather;
import util.DBConnection;

public class WeatherDAO {
	public void saveWeather(Weather w) {
		try {
			Connection con = DBConnection.getConnection();
			String sql = "INSERT INTO weather_history(location, temperature, feels_like, humidity, pressure, wind_speed, description, icon) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, w.getLocation());
			ps.setDouble(2, w.getTemperature());
			ps.setDouble(3, w.getFeelsLike());
			ps.setDouble(4, w.getHumidity());
			ps.setDouble(5, w.getPressure());
			ps.setDouble(6, w.getWindSpeed());
			ps.setString(7, w.getDescription());
			ps.setString(8, w.getIcon());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Weather> getWeatherHistory() {
		List<Weather> list = new ArrayList<>();
		try {
			Connection con = DBConnection.getConnection();
			String sql = "SELECT location, temperature, description, searched_at FROM weather_history ORDER BY id DESC";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Weather w = new Weather();
				w.setLocation(rs.getString("location"));
				w.setTemperature(rs.getDouble("temperature"));
				w.setDescription(rs.getString("description"));
				w.setSearchTime(rs.getString("searched_at"));
				list.add(w);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public void deleteAllHistory() {
		try {
			Connection con = DBConnection.getConnection();
			String sql = "DELETE FROM weather_history";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}