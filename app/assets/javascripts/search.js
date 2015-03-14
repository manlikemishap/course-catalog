// The results of the last search...
var lastSearchResults;

// How far we got in the thing
var displayNextIndex = 0;

/* Take current displayNextIndex, and display n next courses */
function displayNextSearchResults(n) {
	for (var i = 0; i < n; i++) {
		var id = lastSearchResults[displayNextIndex][0];
		createSearchResultBlockForId(id);
		searchResultInfoForId(id);
		displayNextIndex++;		
	}
}


/* Create a row in the search result table for the course according
	to the template */
function createSearchResultBlockForId(id) {
	var template = document.getElementById("search-result-template");
	var clone = template.cloneNode(true);
	clone.id = "search-result-" + id;
	template.parentNode.appendChild(clone);
}


/* Send request for the base course info that is used in 
	displaying search results */
function searchResultInfoForId(id) {
	$.ajax ({
		type: "POST",
		url: "/search/info_for_result",
		data: $.param({id: id, authenticity_token: AUTH_TOKEN}),
		success: displaySearchResult
	});
}


/* Callback function for searchResultInfoForId */
function displaySearchResult(json) {
	var loc = document.getElementById("search-result-" + json["id"]);
	var children = loc.children;
	for (var i = 0; i < children.length; i++) {
		switch (children[i].className) {
			case "dept-num": 
				children[i].innerHTML = json["dept"] + json["number"];
				break;
			case "title":
				children[i].innerHTML = json["title"];
				break;
			case "division":
				children[i].innerHTML = json["div"];
				break;
			case "attributes":
				break;
		}
	}
}


function courseInfoForId(id) {
	req = initRequest();
	//req.onreadystatechange = function() { displayCourseInfo(); };
	//var url = "/search/lookup.json?id=" + id
	var url = "/search/lookup.json?id=" + id
	req.open("GET", url, true)
	req.send();
}

function displayCourseInfo(id) {
	if (req.readyState == 4 && req.status == 200) {
		var div = document.getElementById("display-course");
	}
}