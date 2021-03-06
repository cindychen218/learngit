function rq_addEvent(obj, evType, fn){
 if (obj.addEventListener){
    obj.addEventListener(evType, fn, false);
    return true;
 } else if (obj.attachEvent){
    var r = obj.attachEvent("on"+evType, fn);
    return r;
 } else {
    return false;
 }
}

function rq_removeEvent(obj, evType, fn, useCapture){
  if (obj.removeEventListener){
    obj.removeEventListener(evType, fn, useCapture);
    return true;
  } else if (obj.detachEvent){
    var r = obj.detachEvent("on"+evType, fn);
    return r;
  } else {
    alert("Handler could not be removed");
  }
}

function getViewportHeight() {
	if (window.innerHeight!=null) return window.innerHeight;
	if (document.compatMode=='CSS1Compat') return document.documentElement.clientHeight;
	if (document.body) return document.body.clientHeight; 

	return null; 
}

function getViewportWidth() {
	var offset = 17;
	var width = null;
	if (window.innerWidth!=null) return window.innerWidth; 
	if (document.compatMode=='CSS1Compat') return document.documentElement.clientWidth; 
	if (document.body) return document.body.clientWidth; 
}

function getScrollTop() {
	if (self.pageYOffset) // all except Explorer
	{
		return self.pageYOffset;
	}
	else if (document.documentElement && document.documentElement.scrollTop)
		// Explorer 6 Strict
	{
		return document.documentElement.scrollTop;
	}
	else if (document.body) // all other Explorers
	{
		return document.body.scrollTop;
	}
}
function getScrollLeft() {
	if (self.pageXOffset) // all except Explorer
	{
		return self.pageXOffset;
	}
	else if (document.documentElement && document.documentElement.scrollLeft)
		// Explorer 6 Strict
	{
		return document.documentElement.scrollLeft;
	}
	else if (document.body) // all other Explorers
	{
		return document.body.scrollLeft;
	}
}

var rq_gPopupMask = null;
var rq_gPopupContainer = null;
var rq_gPopFrame = null;
var rq_gReturnFunc;
var rq_gPopupIsShown = false;
var rq_gHideSelects = false;
var rq_gReturnVal = null;

var rq_gTabIndexes = new Array();
// Pre-defined list of tags we want to disable/enable tabbing into
var rq_gTabbableTags = new Array("A","BUTTON","TEXTAREA","INPUT","IFRAME");	

// If using Mozilla or Firefox, use Tab-key trap.
if (!document.all) {
	document.onkeypress = keyDownHandler;
}

function initPopUp() {
	if( document.getElementById("popupContainer") != null ) return;
	theBody = document.getElementsByTagName('BODY')[0];
	popmask = document.createElement('div');
	popmask.id = 'popupMask';
	popmask.style.position = "absolute";
	popmask.style.zindex = "900";
	popmask.style.top = "0px";
	popmask.style.left = "0px";
	popmask.style.width = "100%";
	popmask.style.height = "100%";
	popmask.style.opacity = ".4";
	popmask.style.filter = "alpha(opacity=40)";
	popmask.style.backgroundColor = "#333333";
	popmask.style.display = "none";
	popcont = document.createElement('div');
	popcont.id = 'popupContainer';
	popcont.style.position = "absolute";
	popcont.style.zIndex = "901";
	popcont.style.display = "none";
	popcont.innerHTML = '' +
		'<DIV id=popupInner style="border: 2px solid #000000;ackground-color: #ffffff;">' +
			'<DIV style="background-color:#486CAE;color:#ffffff;font-weight:bold;height:17px;padding: 4px;border-bottom: 2px solid #000000;border-top: 1px solid #78A3F2;border-left: 1px solid #78A3F2;border-right: 1px solid #204095;position: relative;z-index: 903;" id=popupTitleBar>' +
				'<DIV id=popupTitle style="float:left;font-size:14px"></DIV>' +
				'<DIV id=popupControls style="float: right;cursor: pointer;cursor: hand;"><SPAN style="text-align:center;font-size:14px;BACKGROUND-COLOR: gray; WIDTH: 16px; HEIGHT: 16px; COLOR: #000000;border-left:1px solid #cccccc;border-top:1px solid #cccccc;border-right:1px solid #555555;border-bottom:1px solid #555555" id=popCloseBox onclick=rq_hidePopWin();>X</SPAN></DIV>' +
			'</DIV>' +
			'<IFRAME style="margin: 0px;position: relative;z-index: 902;BACKGROUND-COLOR: transparent;" id=popupFrame frameBorder=0 allowTransparency name=popupFrame scrolling=auto tabEnabled="true"></IFRAME>' +
		'</DIV>';
	theBody.appendChild(popmask);
	theBody.appendChild(popcont);
	
	rq_gPopupMask = document.getElementById("popupMask");
	rq_gPopupContainer = document.getElementById("popupContainer");
	rq_gPopFrame = document.getElementById("popupFrame");	
	// check to see if this is IE version 6 or lower. hide select boxes if so
	var brsVersion = parseInt(window.navigator.appVersion.charAt(0), 10);
	if (brsVersion <= 6 && window.navigator.userAgent.indexOf("MSIE") > -1) {
		rq_gHideSelects = true;
	}
	rq_addEvent(window, "resize", centerPopWin);
	rq_addEvent(window, "scroll", centerPopWin);
}
rq_addEvent(window, "load", initPopUp);

function rq_showPopWin(url, width, height, returnFunc, showCloseBox) {
	if (showCloseBox == null || showCloseBox == true) {
		document.getElementById("popCloseBox").style.display = "block";
	} else {
		document.getElementById("popCloseBox").style.display = "none";
	}
	rq_gPopupIsShown = true;
	disableTabIndexes();
	rq_gPopupMask.style.display = "block";
	rq_gPopupContainer.style.display = "block";
	_popupResizeTo( width, height );
	setMaskSize();
	rq_gPopFrame.src = url;
	rq_gReturnFunc = returnFunc;
	if (rq_gHideSelects == true) {
		hideSelectBoxes();
	}
	window.setTimeout("setPopTitle();", 50);
}

function _popupResizeTo( width, height ) {
	centerPopWin(width, height);
	var titleBarHeight = parseInt(document.getElementById("popupTitleBar").offsetHeight, 10);
	rq_gPopupContainer.style.width = width + "px";
	rq_gPopupContainer.style.height = (height+titleBarHeight) + "px";
	rq_gPopFrame.style.width = parseInt(document.getElementById("popupTitleBar").offsetWidth, 10) + "px";
	rq_gPopFrame.style.height = (height) + "px";
}

function centerPopWin(width, height) {
	if (rq_gPopupIsShown == true) {
		if (width == null || isNaN(width)) {
			width = rq_gPopupContainer.offsetWidth;
		}
		if (height == null) {
			height = rq_gPopupContainer.offsetHeight;
		}
		var theBody = document.getElementsByTagName("BODY")[0];
		var scTop = parseInt(getScrollTop(),10);
		var scLeft = parseInt(theBody.scrollLeft,10);
		setMaskSize();
		var titleBarHeight = parseInt(document.getElementById("popupTitleBar").offsetHeight, 10);
		var fullHeight = getViewportHeight();
		var fullWidth = getViewportWidth();
		rq_gPopupContainer.style.top = (scTop + ((fullHeight - (height+titleBarHeight)) / 2)) + "px";
		rq_gPopupContainer.style.left =  (scLeft + ((fullWidth - width) / 2)) + "px";
	}
}

function setMaskSize() {
	var theBody = document.getElementsByTagName("BODY")[0];
	var fullHeight = getViewportHeight();
	var fullWidth = getViewportWidth();
	if (fullWidth > theBody.scrollWidth) {
		popWidth = fullWidth;
	} else {
		popWidth = theBody.scrollWidth;
	}
	if( theBody.scrollHeight > fullHeight * 3 ) {
		rq_gPopupMask.style.top = ( theBody.scrollTop - fullHeight / 2 ) + "px";
		rq_gPopupMask.style.height = fullHeight * 2 + "px";
	}
	else rq_gPopupMask.style.height = theBody.scrollHeight + "px";
	rq_gPopupMask.style.width = popWidth + "px";
}

// returnVal - anything - return value 
function rq_hidePopWin(returnVal) {
	rq_gPopupIsShown = false;
	var theBody = document.getElementsByTagName("BODY")[0];
	theBody.style.overflow = "";
	restoreTabIndexes();
	if (rq_gPopupMask == null) {
		return;
	}
	rq_gPopupMask.style.display = "none";
	rq_gPopupContainer.style.display = "none";
	if ( returnVal != null) {
		rq_gReturnVal = returnVal;
		window.setTimeout('rq_gReturnFunc()', 1);
	}
	if (rq_gHideSelects == true) {
		displaySelectBoxes();
	}
}

function setPopTitle() {
	if (window.frames["popupFrame"].document.title == null) {
		window.setTimeout("setPopTitle();", 10);
	} else {
		document.getElementById("popupTitle").innerHTML = window.frames["popupFrame"].document.title;
	}
}

function keyDownHandler(e) {
    if (rq_gPopupIsShown && e.keyCode == 9)  return false;
}

// For IE.  Go through predefined tags and disable tabbing into them.
function disableTabIndexes() {
	if (document.all) {
		var i = 0;
		for (var j = 0; j < rq_gTabbableTags.length; j++) {
			var tagElements = document.getElementsByTagName(rq_gTabbableTags[j]);
			for (var k = 0 ; k < tagElements.length; k++) {
				rq_gTabIndexes[i] = tagElements[k].tabIndex;
				tagElements[k].tabIndex="-1";
				i++;
			}
		}
	}
}

// For IE. Restore tab-indexes.
function restoreTabIndexes() {
	if (document.all) {
		var i = 0;
		for (var j = 0; j < rq_gTabbableTags.length; j++) {
			var tagElements = document.getElementsByTagName(rq_gTabbableTags[j]);
			for (var k = 0 ; k < tagElements.length; k++) {
				tagElements[k].tabIndex = rq_gTabIndexes[i];
				tagElements[k].tabEnabled = true;
				i++;
			}
		}
	}
}

function hideSelectBoxes() {
  var x = document.getElementsByTagName("SELECT");
  for (i=0;x && i < x.length; i++) {
    x[i].style.visibility = "hidden";
  }
}

function displaySelectBoxes() {
  var x = document.getElementsByTagName("SELECT");
  for (i=0;x && i < x.length; i++){
    x[i].style.visibility = "visible";
  }
}