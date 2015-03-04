var req;
var isIE;

function initRequest() {
	if (window.XMLHttpRequest) {
		if (navigator.userAgent.indexOf("MSIE") != -1) {
			isIE = false;
		}
		return new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		isIE = true;
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
}