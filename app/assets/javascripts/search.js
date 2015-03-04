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