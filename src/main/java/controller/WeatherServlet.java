package controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;
import org.json.JSONArray;
import java.text.SimpleDateFormat;
import java.util.Map;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Calendar;
import dao.WeatherDAO;
import model.Weather;

@WebServlet("/WeatherServlet")
public class WeatherServlet extends HttpServlet {

	private String getApiKey() {
		try {
			java.util.Properties props = new java.util.Properties();
			java.io.InputStream is = getClass().getClassLoader().getResourceAsStream("config.properties");
			if (is != null) {
				props.load(is);
				return props.getProperty("weather.api.key");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, java.io.IOException {
		try {
			String location = req.getParameter("location").trim();
			String encodedLocation = URLEncoder.encode(location, "UTF-8");
			String apiKey = getApiKey();
			String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + encodedLocation
					+ "&units=metric&appid=" + apiKey;
			URL url = new URL(apiUrl);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			BufferedReader br;
			if (con.getResponseCode() == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			StringBuilder json = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				json.append(line);
			}
			JSONObject obj = new JSONObject(json.toString());
			if (obj.has("message")) {
				req.setAttribute("error",
						"Location not recognized. Please enter a city, district, taluka, state or country.");
				RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
				rd.forward(req, res);
				return;
			}
			double temp = obj.getJSONObject("main").getDouble("temp");
			double humidity = obj.getJSONObject("main").getDouble("humidity");
			double pressure = obj.getJSONObject("main").getDouble("pressure");
			double feels = obj.getJSONObject("main").getDouble("feels_like");
			double wind = obj.getJSONObject("wind").getDouble("speed");
			String desc = obj.getJSONArray("weather").getJSONObject(0).getString("description");
			String icon = obj.getJSONArray("weather").getJSONObject(0).getString("icon");
			Weather w = new Weather();
			w.setLocation(location);
			w.setTemperature(temp);
			w.setFeelsLike(feels);
			w.setHumidity(humidity);
			w.setPressure(pressure);
			w.setWindSpeed(wind);
			w.setDescription(desc);
			w.setIcon(icon);
			WeatherDAO dao = new WeatherDAO();
			dao.saveWeather(w);
			req.setAttribute("weather", w);
			String forecastUrl = "https://api.openweathermap.org/data/2.5/forecast?q=" + encodedLocation
					+ "&units=metric&appid=" + apiKey;
			URL fUrl = new URL(forecastUrl);
			HttpURLConnection fCon = (HttpURLConnection) fUrl.openConnection();
			fCon.setRequestMethod("GET");
			BufferedReader fbr = new BufferedReader(new InputStreamReader(fCon.getInputStream()));
			StringBuilder fjson = new StringBuilder();
			String fline;
			while ((fline = fbr.readLine()) != null) {
				fjson.append(fline);
			}
			JSONObject forecastObj = new JSONObject(fjson.toString());
			JSONArray forecastArr = forecastObj.getJSONArray("list");
			SimpleDateFormat dayFmt = new SimpleDateFormat("EEEE, dd MMM yyyy");
			String prevDate = "";
			java.util.List<Map<String, Object>> forecastList = new java.util.ArrayList<>();
			for (int i = 0; i < forecastArr.length(); i++) {
				JSONObject f = forecastArr.getJSONObject(i);
				String dtTxt = f.getString("dt_txt");
				String date = dtTxt.substring(0, 10);
				if (!date.equals(prevDate)) {
					Map<String, Object> entry = new HashMap<>();
					entry.put("temp", f.getJSONObject("main").getDouble("temp"));
					entry.put("description", f.getJSONArray("weather").getJSONObject(0).getString("description"));
					entry.put("icon", f.getJSONArray("weather").getJSONObject(0).getString("icon"));
					try {
						java.util.Date parsed = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dtTxt);
						entry.put("dayName", dayFmt.format(parsed));
					} catch (Exception ex) {
						entry.put("dayName", date);
					}
					forecastList.add(entry);
					prevDate = date;
					if (forecastList.size() == 5) break;
				}
			}
			req.setAttribute("forecast", forecastList);
			RequestDispatcher rd = req.getRequestDispatcher("result.jsp");
			rd.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
			res.sendRedirect("index.jsp");
		}
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, java.io.IOException {
		try {
			String action = req.getParameter("action");

			// Proxy for Suggestions and Auto-Detection
			if ("suggest".equals(action)) {
				String q = req.getParameter("q");
				String apiKey = getApiKey();
				String targetUrl = "";

				if ("auto".equals(q)) {
					String lat = req.getParameter("lat");
					String lon = req.getParameter("lon");
					targetUrl = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon
							+ "&units=metric&appid=" + apiKey;
				} else {
					targetUrl = "https://api.openweathermap.org/geo/1.0/direct?q=" + URLEncoder.encode(q, "UTF-8")
							+ "&limit=5&appid=" + apiKey;
				}

				URL fUrl = new URL(targetUrl);
				HttpURLConnection fCon = (HttpURLConnection) fUrl.openConnection();
				fCon.setRequestMethod("GET");
				BufferedReader fbr = new BufferedReader(new InputStreamReader(fCon.getInputStream()));
				StringBuilder fjson = new StringBuilder();
				String fline;
				while ((fline = fbr.readLine()) != null) {
					fjson.append(fline);
				}
				res.setContentType("application/json");
				res.getWriter().write(fjson.toString());
				return;
			}

			String location = req.getParameter("location");
			if (location != null && !location.isEmpty()) {
				req.setAttribute("location", location);
				doPost(req, res);
				return;
			}
			WeatherDAO dao = new WeatherDAO();
			if ("delete".equals(action)) {
				dao.deleteAllHistory();
			}
			List<Weather> list = dao.getWeatherHistory();
			req.setAttribute("historyList", list);
			RequestDispatcher rd = req.getRequestDispatcher("history.jsp");
			rd.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}