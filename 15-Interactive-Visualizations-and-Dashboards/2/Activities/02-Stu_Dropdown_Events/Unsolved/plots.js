let pageData = []

function init() {
  var data = [{
    values: [19, 26, 55, 88],
    labels: ["Spotify", "Soundcloud", "Pandora", "Itunes"],
    type: "pie"
  }];

  var layout = {
    height: 600,
    width: 800
  };
  pageData = data[0]["values"]
  Plotly.plot("pie", data, layout);
}

function updatePlotly(newdata) {
  // YOUR CODE HERE
  // Use `Plotly.restyle` to update the pie chart with the newdata array
  var PIE = document.getElementById("pie")
  Plotly.restyle(PIE, "values", [newdata]);
}

function getData(dataset) {
  // YOUR CODE HERE
  // create a select statement to select different data arrays (YOUR CHOICE)
  // whenever the dataset parameter changes. This function will get called
  // from the dropdown event handler.

  switch(dataset) {
    case "ds1":
      pageData = ["12", "19","39","30"];
      break;
    case "ds2":
      pageData = ["22", "2","29","47"];
      break;
    default:
      break;
  }

  updatePlotly(pageData);
}

init();
