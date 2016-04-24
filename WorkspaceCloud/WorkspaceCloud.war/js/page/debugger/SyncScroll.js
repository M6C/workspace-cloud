/*
The following is a standard way to synchronize scrolling of two 
textareas ta1 and ta2 in IE.
*/

function syncTextareas (ta1, ta2) {
	ta1.onscroll = function (evt) {
		ta2.scrollTop = this.scrollTop;
	}
	ta2.onscroll = function (evt) {
		ta1.scrollTop = this.scrollTop;
	}
}

/*
However, there is apparently a bubbling bug with textarea onscroll 
events in past and current versions of Mozilla 1.7x and Firefox 1.0x, 
https://bugzilla.mozilla.org/show_bug.cgi?id=229089 , which prevents 
easy coding to synchronously scroll two textareas.

This script works around the bubbling bug by overlapping each textareas 
vertical scroll bar with the vertical scroll bar of a nested pair of 
<div>'s.

Onscroll events of each pairs parent <div> control the scrolling of 
three elements: the other pairs parent <div> and the two textareas.

The height of a parent <div> is fixed by the height of its textarea but 
the child <div> of each pair adjusts its height according to changes in 
its textarea scrollHeight which in turn scales its parent <div>'s 
scrolling range.

Each textarea is given a Mozilla oninput event handler. Mozilla oninput 
events are sent with text display changes and so they also fire with 
text manipulations like cutting and pasting.
*/

var scrollbarWidth = 16;

function getPagePosition (el) {
	var pos = {left: 0, top: 0};
	var par = el.offsetParent;
	while (par)
	{
		pos.left += par.offsetLeft;
		pos.top += par.offsetTop;
		par = par.offsetParent;
	}
	return pos;
}

function positionScrollBar (sb, ta, adjLeft, adjTop) {
	var pos = getPagePosition (ta);
	if (ta.scrollHeight > ta.clientHeight)
	{
		sb.style.left = pos.left + ta.clientWidth + adjLeft;
	}
	else
	{
		sb.style.left = pos.left + ta.clientWidth + adjLeft - 
scrollbarWidth;
	}
	sb.style.top  = pos.top + adjTop;
	document.body.appendChild(sb);
}

function scaleScrolling (sb, ta) {
	sb.firstChild.style.height = (ta.scrollHeight - 2) + 'px';
	sb.scrollTop = ta.scrollTop;
}

function syncTextareasMoz (sb1, sb2, ta1, ta2) {
	sb1.onscroll = function()
	{
		ta1.scrollTop = this.scrollTop;
		ta2.scrollTop = this.scrollTop;
		sb2.scrollTop = this.scrollTop;
	}
	sb2.onscroll = function ()
	{
		ta1.scrollTop = this.scrollTop;
		ta2.scrollTop = this.scrollTop;
		sb1.scrollTop = this.scrollTop;
	}
}

function createScrollBar (id, height, scrollHeight) {
	var sb = document.createElement('div');
	sb.id = id;
	sb.style.position = 'absolute';
	sb.style.width = '16px';
	sb.style.height = height;
	sb.style.border = 'none';
	sb.style.margin = '0px';
	sb.style.padding = '0px';
	sb.style.overflow = 'auto';
	sb.style.overflowX = 'hidden';

	var range = document.createElement('div');
	range.id = 'range';
	range.style.width = '0px';
	range.style.height = scrollHeight;
	range.style.border = '1px transparent solid';
	range.style.margin = '0px';
	range.style.padding = '0px';

	sb.appendChild(range);
	return sb;
}

function setupScrollBars (ta1, ta2) {
	if (document.all)
	{
		syncTextareas (ta1, ta2);
	}
	else if (ta1.addEventListener)
	{
		var sb1 = createScrollBar('sb1', ta1.clientHeight 
+ 'px', (ta1.scrollHeight - 2) + 'px');
		var sb2 = createScrollBar('sb2', ta2.clientHeight 
+ 'px', (ta2.scrollHeight - 2) + 'px');
		positionScrollBar (sb1, ta1, (ta1.offsetLeft + 3), 
(ta1.offsetTop + 2));
		positionScrollBar (sb2, ta2, (ta2.offsetLeft + 3), 
(ta2.offsetTop + 2));

		ta1.addEventListener("input",
				     function () { scaleScrolling(sb1, 
ta1) },
				     false);
		ta2.addEventListener("input",
				     function () { scaleScrolling(sb2, 
ta2) },
				     false);

		syncTextareasMoz (sb1, sb2, ta1, ta2);
	}
}
