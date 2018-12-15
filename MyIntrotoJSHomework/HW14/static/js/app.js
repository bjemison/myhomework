// from data.js
var tableData = data;

// Get references to the tbody element, input field and button
var $tbody = document.querySelector("tbody");
// var $datetimeInput = document.querySelector("#datetime");
var $cityInput = document.querySelector("#city");
var $stateInput = document.querySelector("#state");
var $countryInput = document.querySelector("#country");
var $shapeInput = document.querySelector("#shape");
var $searchBtn = document.querySelector("#search");
// var x = document.getElementById("table").rows[0].innerHTML;
// var $table = document.getElementById("table");
// var $rowCount = $table.rows.length;
// var $firstRow = table.rows[0].firstelementChild.tagName, $hasHead = ($firstRow === "TH");

// Add an event listener to the searchButton, call handleSearchButtonClick when clicked
$searchBtn.addEventListener("click", handleSearchButtonClick);
// $pageBtn.addEventListener("click", handlePageClick);

// Set filteredAddresses to ufoData initially
var filteredData = dataSet;

// renderTable renders the filteredData to the tbody
function renderTable() {
  $tbody.innerHTML = "";
  for (var i = 0; i < filteredData.length; i++) {
    // Get get the current address object and its fields
    var  ufoObject = filteredData[i];
    var fields = Object.keys(ufoObject);
    // Create a new row in the tbody, set the index to be i + startingIndex
    var $row = $tbody.insertRow(i);
    for (var j = 0; j < fields.length; j++) {
      // For every field in the dataSet object, create a new cell at set its inner text to be the current value at the current address field
      var field = fields[j]; //datetime-city-state-country-shape-duration-comments
      var $cell = $row.insertCell(j);
      $cell.innerText = ufoObject[field]; //ufoObject["key"] = value
    }
  }
};
renderTable();