<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html>

        <head>

            <title>Weather Result</title>

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

            <style>
                body {
                    min-height: 100vh;
                    background-color: #333;
                    background-size: cover;
                    background-position: center;
                    background-attachment: fixed;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin: 0;
                    padding: 0;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }

                /* Weather specific body backgrounds */
                body.clear-bg {
                    background-image: url('https://images.unsplash.com/photo-1601297183305-6df142704ea2?auto=format&fit=crop&w=1920&q=80');
                }

                body.cloud-bg {
                    background-image: url('https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?auto=format&fit=crop&w=1920&q=80');
                }

                body.rain-bg {
                    background-image: url('https://images.unsplash.com/photo-1515694346937-94d85e41e6f0?auto=format&fit=crop&w=1920&q=80');
                }

                body.storm-bg {
                    background-image: url('https://images.unsplash.com/photo-1605727216801-e27ce1d0ce28?auto=format&fit=crop&w=1920&q=80');
                }

                body.snow-bg {
                    background-image: url('https://images.unsplash.com/photo-1491002052546-bf38f186af56?auto=format&fit=crop&q=80&w=1920');
                }

                body.mist-bg {
                    background-image: url('https://images.unsplash.com/photo-1485433592409-9018e83a1f0d?auto=format&fit=crop&w=1920&q=80');
                }

                body.default-bg {
                    background-image: url('https://images.unsplash.com/photo-1502082553048-f009c37129b9?auto=format&fit=crop&w=1920&q=80');
                }

                .result-card {
                    border-radius: 24px;
                    padding: 30px;
                    color: white;
                    backdrop-filter: blur(15px);
                    border: 2px solid rgba(255, 255, 255, 0.3);
                    box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
                    min-width: 450px;
                    max-width: 900px;
                    width: auto;
                    margin: 0 auto;
                }

                /* Weather specific card colors */
                body.clear-bg .result-card {
                    background-color: rgba(255, 183, 77, 0.45);
                }

                body.cloud-bg .result-card {
                    background-color: rgba(120, 144, 156, 0.55);
                }

                body.rain-bg .result-card {
                    background-color: rgba(41, 121, 255, 0.45);
                }

                body.storm-bg .result-card {
                    background-color: rgba(49, 27, 146, 0.6);
                }

                body.snow-bg .result-card {
                    background-color: rgba(178, 235, 242, 0.55);
                }

                body.mist-bg .result-card {
                    background-color: rgba(207, 216, 220, 0.6);
                }

                body.default-bg .result-card {
                    background-color: rgba(0, 0, 0, 0.5);
                }

                .result-card h3 {
                    font-size: 2.2rem;
                    font-weight: 800;
                    text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.6);
                    margin-bottom: 15px;
                }

                .result-card h4 {
                    font-size: 1.8rem;
                    font-weight: bold;
                    margin-top: 10px;
                }

                .result-card p {
                    font-size: 1.3rem;
                    margin-bottom: 8px;
                    font-weight: bold;
                    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
                }

                .temp-val {
                    color: #ffca28;
                }

                /* Golden Yellow */
                .desc-val {
                    color: #81d4fa;
                }

                /* Sky Blue */
                .humid-val {
                    color: #4db6ac;
                }

                /* Teal/Water */
                .wind-val {
                    color: #ce93d8;
                }

                /* Lavender/Wind */

                .forecastRow {
                    display: flex;
                    justify-content: space-between;
                    gap: 10px;
                    margin-top: 20px;
                }

                .forecastCard {
                    background: rgba(255, 255, 255, 0.2);
                    border-radius: 12px;
                    padding: 15px;
                    flex: 1;
                    text-align: center;
                }

                .forecast-temp {
                    color: #ffca28;
                    font-weight: bold;
                }

                .forecast-desc {
                    color: #81d4fa;
                    font-weight: bold;
                }
            </style>

        </head>

        <body>

            <div class="col-md-8">

                <div class="result-card text-center" id="weatherDisplayCard">

                    <h3 class="mb-3">Weather Result</h3>

                    <img src="https://openweathermap.org/img/wn/${weather.icon}@2x.png">

                    <h4>${weather.location}</h4>

                    <p><span style="color: #ffca28;">🌡</span> <span class="temp-val">${weather.temperature} °C</span>
                    </p>
                    <p><span style="color: #81d4fa;">☁</span> <span class="desc-val">${weather.description}</span></p>
                    <p><span style="color: #4db6ac;">💧</span> <span class="humid-val">${weather.humidity}%</span></p>
                    <p><span style="color: #ce93d8;">💨</span> <span class="wind-val">${weather.windSpeed} m/s</span>
                    </p>

                    <h5 class="mt-4">Forecast</h5>

                    <div class="forecastRow">

                        <c:forEach var="f" items="${forecast}">
                            <div class="forecastCard">
                                <div>${f.dayName}</div>
                                <div><span class="forecast-temp">🌡 ${f.temp}°C</span></div>
                                <div><span class="forecast-desc">☁ ${f.description}</span></div>
                                <img src="https://openweathermap.org/img/wn/${f.icon}@2x.png" />
                            </div>
                        </c:forEach>

                    </div>

                    <div class="mt-4">

                        <a href="index.jsp" class="btn btn-light">Search Again</a>

                        <a href="WeatherServlet" class="btn btn-dark">View History</a>

                    </div>

                </div>

            </div>

            <script>
                (function () {
                    var wIcon = "${weather.icon}";
                    var b = document.body;

                    var cls = "default-bg";
                    if (wIcon.indexOf("01") != -1) cls = "clear-bg";
                    else if (wIcon.indexOf("02") != -1 || wIcon.indexOf("03") != -1 || wIcon.indexOf("04") != -1) cls = "cloud-bg";
                    else if (wIcon.indexOf("09") != -1 || wIcon.indexOf("10") != -1) cls = "rain-bg";
                    else if (wIcon.indexOf("11") != -1) cls = "storm-bg";
                    else if (wIcon.indexOf("13") != -1) cls = "snow-bg";
                    else if (wIcon.indexOf("50") != -1) cls = "mist-bg";

                    b.className = cls;
                })();
            </script>

        </body>

        </html>