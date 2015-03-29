// The results of the last search...
var lastSearchResults;

// How far we got in the thing
var displayNextIndex = 0;

/* Take current displayNextIndex, and display n next courses */
function displayNextSearchResults(n) {	
	var lim = lastSearchResults.length;	
	for (var i = 0; i < n && displayNextIndex < lim; i++) {
		var id = lastSearchResults[displayNextIndex][0];
		createSearchResultBlockForId(id);
		searchResultInfoForId(id);
		displayNextIndex++;		
	}

	if (displayNextIndex < lim) {
		document.getElementById("show-more-results").style.display = "block";
	} else {
		document.getElementById("show-more-results").style.display = "none";
	}

	if (lastSearchResults.length > 0) {
		document.getElementById("results-count").innerHTML = "Showing 1 - " + (displayNextIndex) + " of " + lastSearchResults.length + " results";
	} else {
		document.getElementById("results-count").innerHTML = "No results found";
	}
}

/* Create a row in the the display table for this course, and collapse
   the other display ones if they exist */
function displayBlockForId(id) {
	var template = document.getElementById("display-course-template");
	var clone = template.cloneNode(true);
	clone.id = "display-course-" + id;
	clone.style.display = "block";
	template.parentNode.insertBefore(clone, template.parentNode.firstChild);
	

	// Iterate over other display-course-id blocks
	var children = template.parentNode.children;
	for (var i = 0; i < children.length; i++) {
		if (children[i].id != "display-course-" + id && children[i].id != "display-course-template") {
			collapseDisplayBlock(children[i]);
		}
	}

	return clone;
}


/* Accepts a display-course-(id) div, and compacts it so that just
	its title is visible */
function collapseDisplayBlock(div) {

	// The first childof this div is the title.
	// it gets replaced with an h5 of the same text
	var bigTitle = div.children[0];
	var smallTitle = document.createElement("h4");
	smallTitle.innerHTML = bigTitle.innerHTML;
	bigTitle.parentNode.insertBefore(smallTitle, bigTitle);
	bigTitle.parentNode.removeChild(bigTitle);

	// now hide everything else
	div.children[1].style.display = "none";
}


/* Create a row in the search result table for the course according
	to the template */
function createSearchResultBlockForId(id) {
	var template = document.getElementById("search-result-template");
	var clone = template.cloneNode(true);
	clone.id = "search-result-" + id;
	clone.style.display = "block";
	template.parentNode.appendChild(clone);
	clone.onclick = function() { 
		$.ajax ({
			type: "POST",
			url: "search/lookup",
			data: $.param({id: id, authenticity_token: AUTH_TOKEN}),
			async: false
		});
	};
}


/* Send request for the base course info that is used in 
	displaying search results */
function searchResultInfoForId(id) {
	$.ajax ({
		type: "POST",
		url: "search/info_for_result",
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
				var write = "";
				attrs = ["q", "w", "d"];
				for (var i = 0, attr = attrs[0]; i < 3; attr = attrs[++i]) {
					if (json[attr]) {
						write += attr.toUpperCase();
					}
				}
				children[i].innerHTML = write;
				break;
		}
	}
}


function setupCompare() {
	var mainChart = document.getElementById("main-chart");
	var children = mainChart.children;
	for (var i = 0; i < children.length; i++) {
		if (children[i].id != "compare-block-1") {
			children[i].style.display = "none";
		} else {
			children[i].style.display = "inline";
		}
	}
}












