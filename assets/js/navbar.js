var scrollpos = window.scrollY;
var header = document.getElementById("header");
var navcontent = document.getElementById("nav-content");
var navaction = document.getElementById("navAction");
var brandname = document.getElementById("brandname");
var globe = document.getElementById("globe");
var toToggle = document.querySelectorAll(".toggleColour");
var pathname = window.location.pathname; 
var navMenu = document.getElementById("nav-toggle");

document.addEventListener('scroll', function() {
  /*Apply classes for slide in bar*/
  scrollpos = window.scrollY;
  if(scrollpos < 20 && pathname == "/"){
    header.classList.remove("bg-white");
    for (var i = 0; i < toToggle.length; i++) {
      toToggle[i].classList.add("text-white");
      toToggle[i].classList.remove("text-gray-darker");
    }
    header.classList.remove("shadow");
    navcontent.classList.remove("bg-white");
    navcontent.classList.add("bg-gray-lighter");
  }
  else {
    header.classList.add("bg-white");
    globe.classList.remove("invert")
    for (var i = 0; i < toToggle.length; i++) {
      toToggle[i].classList.add("text-gray-darker");
      toToggle[i].classList.remove("text-white");
    }
    header.classList.add("shadow");
    navcontent.classList.remove("bg-gray-lighter");
    navcontent.classList.add("bg-white");
  }
});
