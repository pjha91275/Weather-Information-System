# Weather Information System

A professional-grade web application for real-time weather data and 5-day forecasts, built using Java, JSP, Servlets, MySQL, and Bootstrap.

## Features
- **Secure API Management:** API credentials are hidden in backend config files.
- **Dynamic UI:** Geolocation-based auto-detection, adaptive backgrounds, and color-coded typography.
- **Search Suggestion Engine:** Real-time suggestions for city searches.
- **Persistent History:** Search history stored in MySQL database.
- **MVC Architecture:** Clean separation of Model, View, and Controller.
- **Backend Proxy:** API keys are never exposed to the frontend.

## Technologies Used

**Frontend:**
- HTML5 & CSS3
- Bootstrap 5
- JSP (Java Server Pages)
- JSTL (JSP Standard Tag Library)
- JavaScript (Geolocation & Proxy Fetching)

**Backend:**
- Java (JDK 8+)
- Servlets
- JDBC (Java Database Connectivity)
- Java Properties API

**Database:**
- MySQL

**APIs:**
- OpenWeatherMap API (Live Weather & Forecast Data)

**Libraries:**
- org.json (JSON Processing)
- MySQL Connector/J

**Tools:**
- Eclipse IDE
- Apache Tomcat Server
- Git & GitHub

## Use Case
- User visits the site; system auto-detects location and fetches weather securely.
- User searches for a city; suggestions and results are fetched via backend proxy.
- Invalid input triggers a warning message.
- Valid search displays weather and logs it in the database.

## Screenshots
- **Index Page:** Auto-detected weather card with color-coded temperatures.
- **Search Validation Warning:** Error message for invalid city input.
- **Result Page:** Compact card with colorful accents and weather backgrounds.
- **History Module:** Table of previous searches with timestamps.

## Test Cases
| Test Case | Scenario | Input | Expected Result | Actual Result |
|----------|----------|-------|----------------|--------------|
| TC01 | Secure Proxy Check | "View Source" | API Key not visible | Passed |
| TC02 | Invalid City Search | "XYZ123" | Warning message | Passed |
| TC03 | Visual Theme Sync | Sunny City | Yellow tint, clear background | Passed |
| TC04 | Data Persistence | Valid Search | Entry in history table | Passed |
| TC05 | History Cleanup | Delete All | Records cleared | Passed |

## GitHub Repository
[Weather Information System](https://github.com/your-username/Weather-Information-System)

## Future Enhancements
- Save favorite cities
- Severe weather alerts (Email/SMS)
- Interactive maps for weather tracking
- 15-day extended forecasts
- AI-based clothing suggestions

## Conclusion
This project demonstrates secure, dynamic, and responsive Java web development. It simplifies weather tracking with automated location detection and persistent search history, and is a comprehensive learning tool for MVC, API integration, and MySQL management.
