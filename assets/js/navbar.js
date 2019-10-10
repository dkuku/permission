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
    //globe.classList.add("invert")
    //navaction.classList.remove("gradient");
    //navaction.classList.add("bg-white");
    //navaction.classList.remove("text-white");
    //navaction.classList.add("text-gray-darker");
    //Use to switch toggleColour colours
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
    //navaction.classList.remove("bg-white");
    //navaction.classList.add("gradient");
    //navaction.classList.remove("text-gray-darker");
    //navaction.classList.add("text-white");
    //Use to switch toggleColour colours
    for (var i = 0; i < toToggle.length; i++) {
      toToggle[i].classList.add("text-gray-darker");
      toToggle[i].classList.remove("text-white");
    }
    header.classList.add("shadow");
    navcontent.classList.remove("bg-gray-lighter");
    navcontent.classList.add("bg-white");
  }
});
/*Toggle dropdown list*/
/*https://gist.github.com/slavapas/593e8e50cf4cc16ac972afcbad4f70c8*/
document.onclick = check;
function check(e){
  var target = (e && e.target) || (event && event.srcElement);
  //Nav Menu
  if (!checkParent(target, navcontent)) {
    // click NOT on the menu
    if (checkParent(target, navMenu)) {
      // click on the link
      if (navcontent.classList.contains("hidden")) {
        navcontent.classList.remove("hidden");
        navcontent.classList.add("text-gray-darker");
      } else {
        navcontent.classList.add("hidden");
        navcontent.classList.remove("text-gray-darker");
        }
    } else {
      // click both outside link and outside menu, hide menu
      navcontent.classList.add("hidden");
        navcontent.classList.remove("text-gray-darker");
    }
  }
}
function checkParent(t, elm) {
  while(t.parentNode) {
    if( t == elm ) {return true;}
    t = t.parentNode;
  }
  return false;
}
