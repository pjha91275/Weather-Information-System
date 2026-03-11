<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>

        <html>

        <head>

            <title>Weather History</title>

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

            <style>
                body {
                    background: url("https://images.unsplash.com/photo-1472145246862-b24cf25c4a36");
                    background-size: cover;
                    background-position: center;
                    min-height: 100vh;
                }

                .glass {
                    background: rgba(255, 255, 255, 0.85);
                    border-radius: 15px;
                    padding: 25px;
                }
            </style>

        </head>

        <body>

            <div class="container mt-5">

                <div class="glass">

                    <h3 class="text-center mb-4">Search History</h3>

                    <div class="d-flex justify-content-between mb-3">

                        <a href="index.jsp" class="btn btn-secondary">Back</a>

                        <a href="WeatherServlet?action=delete" class="btn btn-danger"
                            onclick="return confirm('Delete all history?');">

                            Delete History

                        </a>

                    </div>

                    <table class="table table-striped table-hover">

                        <thead class="table-dark">

                            <tr>

                                <th>Location</th>
                                <th>Temperature</th>
                                <th>Description</th>
                                <th>Search Time</th>
                                <th>Action</th>

                            </tr>

                        </thead>

                        <tbody>

                            <c:if test="${empty historyList}">

                                <tr>

                                    <td colspan="5" class="text-center">No history found</td>

                                </tr>

                            </c:if>

                            <c:forEach var="w" items="${historyList}">

                                <tr>

                                    <td>${w.location}</td>

                                    <td>${w.temperature} °C</td>

                                    <td>${w.description}</td>

                                    <td>${w.searchTime}</td>

                                    <td>

                                        <a href="WeatherServlet?location=${w.location}" class="btn btn-sm btn-primary">
                                            View Latest
                                        </a>

                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>

        </body>

        </html>