<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>

<title>Weather Information System</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
min-height:100vh;
background:url("https://images.unsplash.com/photo-1601134467661-3d775b999c8b");
background-size:cover;
background-position:center;
background-attachment:fixed;

display:flex;
align-items:center;
justify-content:center;
}

h2{
color:white;
text-shadow:0 0 8px rgba(0,0,0,0.7);
font-size: 3.5rem;
}

.glass{
background:rgba(255,255,255,0.25);
backdrop-filter:blur(12px);
border-radius:20px;
padding:40px;
min-height:320px;
box-shadow:0 10px 25px rgba(0,0,0,0.2);
}

.glass h5 {
font-size: 1.8rem;
}

.card-hover:hover{
transform:scale(1.05);
transition:0.3s;
}

#suggestions{
position:absolute;
width:100%;
z-index:1000;
}

</style>

</head>

<body>

<div class="container text-center">

<h2 class="mb-5">Weather Information System</h2>

<div class="row justify-content-center">

<div class="col-md-5">

<div class="glass card-hover">

<h5 class="mb-3">Auto Detected Weather</h5>

<div id="autoWeather" style="font-size:24px; line-height: 1.8;"></div>

</div>

</div>

<div class="col-md-5">

<div class="glass card-hover">

<h5 class="text-center mb-3">Search Weather</h5>

<c:if test="${not empty error}">
    <div class="alert alert-warning mt-2 mb-3" style="font-size: 15px; border-radius: 10px; font-weight: bold;">
        ⚠️ ${error}
    </div>
</c:if>

<form action="WeatherServlet" method="post">

<div style="position:relative">

<input id="location"
type="text"
name="location"
class="form-control form-control-lg"
style="font-size: 1.5rem; padding: 15px;"
placeholder="Enter city"
onkeyup="suggestCities()"
required>

<ul id="suggestions" class="list-group"></ul>

</div>

<button class="btn btn-primary w-100 mt-3 btn-lg" style="font-size: 1.4rem; padding: 12px;">Get Weather</button>

</form>

</div>

</div>

</div>

<div class="text-center mt-4">

<a href="WeatherServlet" class="btn btn-light btn-lg" style="font-size: 1.3rem; padding: 12px 30px;">View History</a>

</div>

</div>

<script>

// API Key removed for security (Moved to backend config.properties)

document.addEventListener("DOMContentLoaded", function(){

if(navigator.geolocation){

navigator.geolocation.getCurrentPosition(function(pos){

let lat=pos.coords.latitude;
let lon=pos.coords.longitude;

// Fetch local weather via backend to keep API Key private
fetch("WeatherServlet?action=suggest&q=auto&lat="+lat+"&lon="+lon)

.then(res=>res.json())

.then(data=>{

var html="";

html+="📍 <span style='font-weight:bold;'>"+data.name+"</span><br>";
html+="<span style='color: #ff5722;'>🌡</span> <span style='color: #ff5722;'>"+data.main.temp+" °C</span><br>";
html+="<span style='color: #81d4fa;'>☁</span> <span style='color: #81d4fa;'>"+data.weather[0].description+"</span><br>";
html+="<span style='color: #4db6ac;'>💧</span> <span style='color: #4db6ac;'>Humidity "+data.main.humidity+"%</span>";

document.getElementById("autoWeather").innerHTML=html;

var icon = data.weather[0].icon;
var card = document.getElementById("autoWeather").parentElement;

if (icon.includes("01")) {
    card.style.background = "rgba(246, 211, 101, 0.6)"; 
} else if (icon.includes("02") || icon.includes("03") || icon.includes("04")) {
    card.style.background = "rgba(142, 158, 171, 0.6)"; 
} else if (icon.includes("09") || icon.includes("10") || icon.includes("11")) {
    card.style.background = "rgba(79, 172, 254, 0.6)"; 
} else if (icon.includes("13")) {
    card.style.background = "rgba(224, 195, 252, 0.6)"; 
} else {
    card.style.background = "rgba(207, 217, 223, 0.6)"; 
}

});

});

}

});

async function suggestCities(){

let q=document.getElementById("location").value;

if(q.length<2) return;

let res=await fetch("WeatherServlet?action=suggest&q=" + q);

let data=await res.json();

let list=document.getElementById("suggestions");

list.innerHTML="";

data.forEach(c=>{

let li=document.createElement("li");

li.className="list-group-item";

li.innerHTML=c.name+", "+c.country;

li.onclick=function(){
    document.getElementById("location").value=c.name;
    list.innerHTML="";
    list.style.display = "none";
};
list.appendChild(li);
});
list.style.display = "block";
}

// Close suggestions dropdown when clicking outside search bar or dropdown
document.addEventListener('click', function(event) {
    var searchBar = document.getElementById('location');
    var dropdown = document.getElementById('suggestions');
    if (!searchBar.contains(event.target) && !dropdown.contains(event.target)) {
        dropdown.style.display = 'none';
    }
});

// Keep dropdown open when clicking inside search bar
document.getElementById('location').addEventListener('click', function() {
    var dropdown = document.getElementById('suggestions');
    if(dropdown.innerHTML!="") dropdown.style.display = 'block';
});

</script>

</body>
</html>