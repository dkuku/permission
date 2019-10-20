var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the current tab
categoryChanged();

function showTab(n) {
  // This function will display the specified tab of the form ...
  var x = document.getElementsByClassName("tab");
  x[n].style.display = "block";
  // ... and fix the Previous/Next buttons:
  if (n == 0) {
    var button = document.getElementById("prevBtn")
    button.style.display = "none";
    button.parentElement.style.flexDirection = "row-reverse"
  } else {
    var button = document.getElementById("prevBtn")
    button.style.display = "inline";
    button.parentElement.style.flexDirection = "row"
  }
  if (n == (x.length - 1)) {
    document.getElementById("nextBtn").innerHTML = "Submit";
  } else {
    document.getElementById("nextBtn").innerHTML = "Next";
  }
  // ... and run a function that displays the correct step indicator:
  fixStepIndicator(n)
}

function nextPrev(n) {
  // This function will figure out which tab to display
  var x = document.getElementsByClassName("tab");
  // Exit the function if any field in the current tab is invalid:
  if (n == 1 && !validateForm()) return false;
  // Hide the current tab:
  x[currentTab].style.display = "none";
  // Increase or decrease the current tab by 1:
  currentTab = currentTab + n;
  // if you have reached the end of the form... :
  if (currentTab >= x.length) {
    //...the form gets submitted:
    document.getElementById("permitForm").submit();
    return false;
  }
  // Otherwise, display the correct tab:
  showTab(currentTab);
}

  // This function will figure out which tab to display
function validateForm() {
  // This function deals with validation of the form fields
  return true;
  //var x, y, i, valid = true;
  //x = document.getElementsByClassName("tab");
  //y = x[currentTab].getElementsByTagName("input");
  //// A loop that checks every input field in the current tab:
  //for (i = 0; i < y.length; i++) {
  //  // If a field is empty...
  //  if (y[i].value == "") {
  //    // add an "invalid" class to the field:
  //    y[i].className += " invalid";
  //    // and set the current valid status to false:
  //    valid = false;
  //  }
  //}
  //// If the valid status is true, mark the step as finished and valid:
  //if (valid) {
  //  document.getElementsByClassName("step")[currentTab].className += " finish";
  //} else {
  //  document.getElementsByClassName("step")[currentTab].className.replace("finish", "");

  //}
  //return valid; // return the valid status
}

function fixStepIndicator(n) {
  // This function removes the "active" class of all steps...
  var i, x = document.getElementsByClassName("step");
  for (i = 0; i < x.length; i++) {
    x[i].className = x[i].className.replace(" active", "");
  }
  //... and adds the "active" class to the current step:
  x[n].className += " active";
}


function postData(url = '', data = {}, cb) {
  // Default options are marked with *
  fetch(url, {
    method: 'POST', // *GET, POST, PUT, DELETE, etc.
    mode: 'cors', // no-cors, *cors, same-origin
    cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
    credentials: 'same-origin', // include, *same-origin, omit
    headers: {
      'Content-Type': 'application/json',
      // 'Content-Type': 'application/x-www-form-urlencoded',
    },
    redirect: 'follow', // manual, *follow, error
    referrer: 'no-referrer', // no-referrer, *client
    body: JSON.stringify(data) // body data type must match "Content-Type" header
  }).then(r => {
    return r.json()
  }).then(cb)
}

function categoryChanged(a) {
  var current = document.getElementById("permit_category");
  var category = current.options[current.selectedIndex].value;
  var cb = function(data){
    document.getElementById("choosen_category_image").src = data.image;
    document.getElementById("permit_number").value = data.next_number;
    // unhide firewatch
    firewatch_label = document.getElementById("permit_firewatch_name").parentNode.parentNode;
    if (["firewatch"].includes(category)){
    firewatch_label.className = firewatch_label.className.replace(" hidden", "");
    } else {
    firewatch_label.className += " hidden";
    }
  }
  postData('/api/permits/select_category', { category: category }, cb);
}

function nameInputChanged(e, awesomplete) {
  var cb = function(data = []){
    awesomplete.list = data
  }
  var name = e.target.value
  if (name.length > 0) {
    postData('/api/users/find', { name: e.target.value }, cb);
  }  
}

  document.getElementById ("prevBtn").addEventListener ("click", ()=>nextPrev(-1), false);
  document.getElementById ("nextBtn").addEventListener ("click", ()=>nextPrev(1), false);
  document.getElementById("permit_category").addEventListener("change", categoryChanged);

  var permit_issuer_name = document.getElementById("permit_issuer_name");
  permit_issuer_awesomplete = new Awesomplete(permit_issuer_name, {
  autoFirst: true
  });
  permit_issuer_name.addEventListener("keyup", (e) => nameInputChanged(e, permit_issuer_awesomplete));

  var permit_performer_name = document.getElementById("permit_performer_name");
  permit_performer_awesomplete = new Awesomplete(permit_performer_name, {
  autoFirst: true
  });
  permit_performer_name.addEventListener("keyup", (e) => nameInputChanged(e, permit_performer_awesomplete));

  var permit_firewatch_name = document.getElementById("permit_firewatch_name");
  permit_firewatch_awesomplete = new Awesomplete(permit_firewatch_name, {
  autoFirst: true
  });
  permit_firewatch_name.addEventListener("keyup", (e) => nameInputChanged(e, permit_firewatch_awesomplete));

  var permit_controller_name = document.getElementById("permit_controller_name");
  permit_controller_awesomplete = new Awesomplete(permit_controller_name, {
  autoFirst: true
  });
  permit_controller_name.addEventListener("keyup", (e) => nameInputChanged(e, permit_controller_awesomplete));
