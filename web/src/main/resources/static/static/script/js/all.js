function tickAllCheckboxCartable(e) {
	var form = document.forms[0];
	var items = form["selectedItems"];
	if (!items.length) {
		if (e.checked) {
			var r = items.parentNode.parentNode;
			r.className = "selectedRow";
		} else {
			items.checked = false;
			var r = items.parentNode.parentNode;
			if (r.id == "readedMessage") {
				r.className = "readedMessage";
			} else {
				r.className = "unReadedMessage";
			}
		}
	}
	if (e.checked) {

		for (i = 0; i < items.length; i++) {
			items[i].checked = true;
			var r = items[i].parentNode.parentNode;
			r.className = "selectedRow";
		}
	} else {
		for (i = 0; i < items.length; i++) {
			items[i].checked = false;
			var r = items[i].parentNode.parentNode;
			if (r.id == "readedMessage") {
				r.className = "readedMessage";
			} else {
				r.className = "unReadedMessage";
			}
		}
	}
}

function tickAllCheckbox(e) {
	var form = document.forms[0];
	var items = form["selectedItems"];
	if (!items.length) {
		if (e.checked) {
			items.checked = true;
			var r = items.parentNode.parentNode;
			r.className = "rowFirst";
		} else {
			r.className = "rowSecond";
		}
	}
	if (e.checked) {
		for (i = 0; i < items.length; i++) {
			if (items[i].disabled == false)
				items[i].checked = true;
			var r = items[i].parentNode.parentNode;
			r.className = "selectedRow";
		}
	} else {
		for (i = 0; i < items.length; i++) {
			items[i].checked = false;
			var r = items[i].parentNode.parentNode;
			if (i % 2 == 0) {
				r.className = "rowFirst";
			} else {
				r.className = "rowSecond";
			}
		}
	}
}

function changeRowStyle(e, rowNumber) {
	var checkboxParent = e.parentNode.parentNode;
	if (e.checked) {
		checkboxParent.className = "selectedRow";
	} else {
		if (rowNumber % 2 == 0) {
			checkboxParent.className = "WBodY";
		} else {
			checkboxParent.className = "WBodY_";
		}
	}
}

function changeRowStyleCartable(e, rowNumber) {
	var checkboxParent = e.parentNode.parentNode;
	var form = document.forms[0];
	var items = form["selectedItems"];
	if (e.checked) {
		checkboxParent.className = "selectedRow";
	} else {
		if (checkboxParent.id == "readedMessage") {
			checkboxParent.className = "readedMessage";
		} else {
			checkboxParent.className = "unreadedMessage";
		}
	}
}

function changeRowStyle(e, rowNumber) {
	var checkboxParent = e.parentNode.parentNode;
	var form = document.forms[0];
	var items = form["selectedItems"];

	if (e.checked) {
		checkboxParent.className = "selectedRow";
	} else {
		document.forms[0].checkbox.checked = false;
		if (rowNumber % 2 == 0) {
			checkboxParent.className = "rowFirst";
		} else {
			checkboxParent.className = "rowSecond";
		}
	}
}

function deleteAction(action) {
	var form = document.forms[0];
	var items = form["selectedItems"];
	document.forms[0].action.value = action;
	if (!items.length) {
		if (items.checked) {
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½)ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
		alert("ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ !");
		return false;
	}
	for (i = 0; i < items.length; i++) {
		if (items[i].checked) {
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½)ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
	}
	alert("ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ !");
	return false;
}

function assignAction(action) {
	var form = document.forms[0];
	var items = form["selectedItems"];
	document.forms[0].action.value = action;
	if (!items.length) {
		if (items.checked) {
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½)ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
		alert("ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ !");
		return false;
	}
	for (i = 0; i < items.length; i++) {
		if (items[i].checked) {
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½)ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
	}
	alert("ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ !");
	return false;
}

function backAction(action) {
	var form = document.forms[0];
	var items = form["selectedItems"];
	document.forms[0].action.value = action;
	if (!items.length) {
		if (items.checked) {
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½)ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½Ñï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
		alert("ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ñï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ !");
		return false;
	}
	for (i = 0; i < items.length; i++) {
		if (items[i].checked) {
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½)ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½Ñï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
	}
	alert("ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ñï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ !");
	return false;
}

function historyAction(action) {
	var form = document.forms[0];
	var items = form["selectedItems"];
	document.forms[0].action.value = action;
	if (!items.length) {
		if (items.checked) {
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½)ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
		alert("ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ !");
		return false;
	}
	for (i = 0; i < items.length; i++) {
		if (items[i].checked) {
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½)ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
	}
	alert("ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ !");
	return false;
}

function last() {
	document.forms[0].start.value = document.forms[0].rowNumber.value - (document.forms[0].rowNumber.value % parseInt(document.forms[0].limit.value)) + 1;
	if ((document.forms[0].rowNumber.value % parseInt(document.forms[0].limit.value)) == 0)
		document.forms[0].start.value = document.forms[0].start.value - parseInt(document.forms[0].limit.value)
	document.forms[0].action.value = "navigation";
	document.forms[0].submit();
}

function first() {
	document.forms[0].start.value = 1;
	document.forms[0].action.value = "navigation";
	document.forms[0].submit();
}

function next() {
	document.forms[0].start.value = parseInt(document.forms[0].start.value) + parseInt(document.forms[0].limit.value);
	document.forms[0].action.value = "navigation";
	document.forms[0].submit();
}

function previous() {
	document.forms[0].start.value = parseInt(document.forms[0].start.value) - parseInt(document.forms[0].limit.value);
	document.forms[0].action.value = "navigation";
	document.forms[0].submit();
}

function changeStyleOnMouseOver(e) {
	var color = new Array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
	var parent = e.parentNode;
	var bg = parent.bgColor;
	var firstThreeCharacter = bg.substring(0, 3);
	var fourthCharacter = bg.substring(3, 4);
	for (i = 0; i < color.length; i++) {
		if (color[i] == fourthCharacter && i > 1) {
			fourthCharacter = color[i - 2];
			break;
		}
	}
	var fifthCharacter = bg.substring(4, 5);
	var sixthCharacter = bg.substring(5, 6);
	for (j = 0; j < color.length; j++) {
		if (color[j] == sixthCharacter && j > 1) {
			sixthCharacter = color[j - 2];
			break;
		}
	}
	var seventhCharacter = bg.substring(6, 7);
	parent.bgColor = firstThreeCharacter + fourthCharacter + fifthCharacter + sixthCharacter + seventhCharacter;

}

function changeStyleOnMouseDown(e) {
	var parent = e.parentNode;
	parent.bgColor = parent.id;
	e.className = "subMenu";

}

function pageNavigation(start, rowNumbers, navigationBgColor, navigationFont, navigationFontSize, limit) {
	var startFirst = start + 1;
	if (rowNumbers == 0)
		startFirst = 0;
	var startLast = start + parseInt(limit);
	if (startLast > rowNumbers)
		startLast = rowNumbers;
	var t1 = "<tr align='center'><td class='navigation' bgColor='"
		+ navigationBgColor + "' style='font-family:" + navigationFont
		+ ";font-size:" + navigationFontSize + "' colspan='16' nowrap>";
	var t2 = "</td></tr>";
	var p = " " + startFirst + "-" + startLast + " from " + rowNumbers + " ";
	if (start >= limit) {
		if ((rowNumbers - start) > limit)
			p = t1 + "<input title=' ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ' name=' << ' value=' << ' type='submit' onClick='return first()'>" +
				"<input title=' ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ' name=' < ' value=' < ' type='submit' onClick='return previous()'>" + p +
				"<input title=' ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ' name= '> ' value=' > ' type='submit' onClick='return next()'>" +
				"<input title=' ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ' name=' >> ' value=' >> ' type='submit' onClick='return last()'> " + t2;
		else
			p = t1 + "<input title=' ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ' name=' << ' value=' << ' type='submit' onClick='return first()'>" +
				"<input title=' ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ' name=' < ' value=' < ' type='submit' onClick='return previous()'>" + p +
				"<input  name= '> ' value=' > ' type='submit' onClick='return next()' disabled>" +
				"<input  name=' >> ' value=' >> ' type='submit' onClick='return last()' disabled> " + t2;
	} else {
		if ((rowNumbers - start) > limit)
			p = t1 + "<input  name=' << ' value=' << ' type='submit' onClick='return first()' disabled>" +
				"<input  name=' < ' value=' < ' type='submit' onClick='return previous()' disabled> " + p +
				"<input title=' ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ' name=' > ' value=' > ' type='button' onClick='return next()'>" +
				"<input title=' ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ' name=' >> ' value='>> ' type='submit' onClick='return last()'> " + t2;
		else
			p = t1 + p + t2;
	}
	return p;
}

function goToDestination(destination) {
	document.location.href = destination;
}

function goToDestinationWithStage(destination, action, stageId) {
	document.forms[0].stageId.value = stageId;
	document.forms[0].action.value = action;
	document.forms[0].submit();
}

function goToDestinationWithDomain(destination, action, domain) {
	document.forms[0].domain.value = domain;
	document.forms[0].action.value = action;
	document.forms[0].submit();
}

function archiveAction() {
	var items = document.forms[0].selectedItems;
	if (!items.length) {
		if (items.checked) {
			document.forms[0].action.value = "archive";
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½) ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
		alert("! ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½");
		return false;
	}
	for (i = 0; i < items.length; i++) {
		if (items[i].checked) {
			document.forms[0].action.value = "archive";
			if (confirm("ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½) ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
	}
	alert("! ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½");
	return false;
}

function validation() {
	var closedForXmasStartDate = parseInt(document.forms[0].monthClosedForXmasStartDate.value + document.forms[0].dayClosedForXmasStartDate.value);
	var closedForXmasEndDate = parseInt(document.forms[0].monthClosedForXmasEndDate.value + document.forms[0].dayClosedForXmasEndDate.value);

	if (document.forms[0].supplierName == null || document.forms[0].supplierName.value == '') {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		return false;
	} else if (document.forms[0].orderContact == null || document.forms[0].orderContact.value == '') {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		return false;
	} else if (document.forms[0].orderJobTitle == null || document.forms[0].orderJobTitle.value == '') {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		return false;
	} else if (document.forms[0].email.value.indexOf("@") == -1 || document.forms[0].email.value.indexOf(".") == -1 || document.forms[0].email.value.lastIndexOf(".") < document.forms[0].email.value.indexOf("@")) {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½!');
		return false;
	} else if (document.forms[0].countryCode.value == null || document.forms[0].countryCode.value == '') {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½!');
		return false;
	} else if (document.forms[0].orderAddress1 == null || document.forms[0].orderAddress1.value == '') {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		return false;
	} else if (document.forms[0].paymentName == null || document.forms[0].paymentName.value == '') {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		return false;
	}
	if (((document.forms[0].dayClosedForXmasStartDate == null || document.forms[0].dayClosedForXmasStartDate.value == '') && document.forms[0].closeXmas.value == "Y") || ((document.forms[0].monthClosedForXmasStartDate == null || document.forms[0].monthClosedForXmasStartDate.value == '') && document.forms[0].closeXmas.value == "Y")) {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		return false;
	}
	if (((document.forms[0].dayClosedForXmasEndDate == null || document.forms[0].dayClosedForXmasEndDate.value == '') && document.forms[0].closeXmas.value == "Y") || ((document.forms[0].monthClosedForXmasEndDate == null || document.forms[0].monthClosedForXmasEndDate.value == '') && document.forms[0].closeXmas.value == "Y")) {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		return false;
	}
	if ((closedForXmasStartDate > closedForXmasEndDate) && document.forms[0].closeXmas.value == "Y") {
		alert('ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½');
		return false;
	} else if (document.forms[0].maxOrderItems == null || document.forms[0].maxOrderItems.value == 0) {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		return false;
	} else if (parseInt(document.forms[0].maxOrderItems.value) != document.forms[0].maxOrderItems.value) {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		document.forms[0].maxOrderItems.value = "";
	} else if (document.forms[0].numberOfDaysPay == null || document.forms[0].numberOfDaysPay.value == 0) {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ !');
		return false;
	} else if (document.forms[0].registrationNumber.value != "" && parseInt(document.forms[0].registrationNumber.value) != document.forms[0].registrationNumber.value) {
		alert('ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½!');
		document.forms[0].registrationNumber.value = "";
	} else if (document.forms[0].stoke.value != "" && parseInt(document.forms[0].stoke.value) != document.forms[0].stoke.value) {
		alert('ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½!');
		document.forms[0].stoke.value = "";
	} else if (document.forms[0].action.value == "edit" && (document.forms[0].passWord.value != document.forms[0].confirmPassWord.value)) {
		alert('ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½');
		return false;
	} else if (document.forms[0].supplierKind1.value == "" && document.forms[0].supplierId1.value != "") {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½');
		return false;
	} else if (document.forms[0].supplierKind2.value == "" && document.forms[0].supplierId2.value != "") {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½');
		return false;
	} else if (document.forms[0].supplierKind3.value == "" && document.forms[0].supplierId3.value != "") {
		alert('ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½');
		return false;
	} else {
		return true;
	}


}

function validationEn() {
	var closedForXmasStartDate = parseInt(document.forms[0].monthClosedForXmasStartDate.value + document.forms[0].dayClosedForXmasStartDate.value);
	var closedForXmasEndDate = parseInt(document.forms[0].monthClosedForXmasEndDate.value + document.forms[0].dayClosedForXmasEndDate.value);

	var closedForXmasStartDate = parseInt(document.forms[0].monthClosedForXmasStartDate.value + document.forms[0].dayClosedForXmasStartDate.value);
	var closedForXmasEndDate = parseInt(document.forms[0].monthClosedForXmasEndDate.value + document.forms[0].dayClosedForXmasEndDate.value);

	if (document.forms[0].supplierName == null || document.forms[0].supplierName.value == '') {
		alert('Please Insert Supplier Name !');
		return false;
	} else if (document.forms[0].orderContact == null || document.forms[0].orderContact.value == '') {
		alert('Please Insert Order Contact Name !');
		return false;
	} else if (document.forms[0].orderJobTitle == null || document.forms[0].orderJobTitle.value == '') {
		alert('Please Insert Order job title !');
		return false;
	} else if (document.forms[0].email.value.indexOf("@") == -1 || document.forms[0].email.value.indexOf(".") == -1 || document.forms[0].email.value.lastIndexOf(".") < document.forms[0].email.value.indexOf("@")) {
		alert('Please Insert your EMail Correctly !');
		return false;
	} else if (document.forms[0].countryCode.value == null || document.forms[0].countryCode.value == '') {
		alert('Please select your country name');
		return false;
	} else if (document.forms[0].orderAddress1 == null || document.forms[0].orderAddress1.value == '') {
		alert('Please Insert Address1 !');
		return false;
	} else if (document.forms[0].paymentName == null || document.forms[0].paymentName.value == '') {
		alert('Please Insert payment name !');
		return false;
	}
	if (((document.forms[0].dayClosedForXmasStartDate == null || document.forms[0].dayClosedForXmasStartDate.value == '') && document.forms[0].closeXmas.value == "Y") || ((document.forms[0].monthClosedForXmasStartDate == null || document.forms[0].monthClosedForXmasStartDate.value == '') && document.forms[0].closeXmas.value == "Y")) {
		alert('Please Insert XMas Start Date !');
		return false;
	}
	if (((document.forms[0].dayClosedForXmasEndDate == null || document.forms[0].dayClosedForXmasEndDate.value == '') && document.forms[0].closeXmas.value == "Y") || ((document.forms[0].monthClosedForXmasEndDate == null || document.forms[0].monthClosedForXmasEndDate.value == '') && document.forms[0].closeXmas.value == "Y")) {
		alert('Please Insert XMas End Date !');
		return false;
	}
	if ((closedForXmasStartDate > closedForXmasEndDate) && document.forms[0].closeXmas.value == "Y") {
		alert('Xmas end date must be greater than xmas start date !');
		return false;
	} else if (document.forms[0].maxOrderItems == null || document.forms[0].maxOrderItems.value == 0) {
		alert('Please Insert Max Order Items !');
		return false;
	} else if (document.forms[0].numberOfDaysPay == null || document.forms[0].numberOfDaysPay.value == 0) {
		alert('Please Insert your number of day pay ability !');
		return false;
	} else if (parseInt(document.forms[0].registrationNumber.value) == -1) {
		alert('Registartion number must be number!');
		return false;
	} else if (parseInt(document.forms[0].stoke.value) == -1) {
		alert('Supplier stock must be number!');
		return false;
	} else if (document.forms[0].action.value == "login" && (document.forms[0].passWord.value != document.forms[0].confirmPassWord.value)) {
		alert("Don't match Passwords!");
		return false;
	} else if (document.forms[0].supplierKind1.value == "" && document.forms[0].supplierId1.value != "") {
		alert('For create BaseAssist must select supplier kind');
		return false;
	} else if (document.forms[0].supplierKind2.value == "" && document.forms[0].supplierId2.value != "") {
		alert('For create BaseAssist must select supplier kind');
		return false;
	} else if (document.forms[0].supplierKind3.value == "" && document.forms[0].supplierId3.value != "") {
		alert('For create BaseAssist must select supplier kind');
		return false;
	} else {
		return true;
	}
}

function deleteActionEn(action) {
	var form = document.forms[0];
	var items = form["selectedItems"];
	document.forms[0].action.value = action;
	if (!items.length) {
		if (items.checked) {
			if (confirm("Are you sure to delete ?")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
		alert("please choose one record for delete !");
		return false;
	}
	for (i = 0; i < items.length; i++) {
		if (items[i].checked) {
			if (confirm("Are you sure to delete ?")) {
				document.forms[0].submit();
				return true;
			} else {
				return null;
			}
		}
	}
	alert("please choose one record for delete !");
	return false;
}

function convertKhorshidi2miladi(obj) {
	var khMonth = new Array(0, 31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29)
	var mMonth = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
	var f = obj.value;
	var separator = f.split("/")
	var year1 = separator[0]
	if (((((((year1 - ((year1 > 0) ? 474 : 473)) % 2820) + 474) + 38) * 682) % 2816) < 682) {
		khMonth[12] = 30
	}
	var year = parseInt(separator[0], 10).toString()
	var month = parseInt(separator[1], 10).toString()
	var day = parseInt(separator[2], 10).toString()
	if (month > 12) {
		alert("The month number is out of range .")
		document.forms["form1"].t2.value = " "
		a.close()
	}
	if (day > khMonth[parseInt(month)]) {
		alert("The day number is out of range .")
		document.forms["form1"].t2.value = " "
		a.close()
	}
	var addmonth = 0
	for (var x = 1; x < parseInt(month); x++) {
		addmonth += khMonth[x]
	}

	var year2 = 0
	for (var z = 1; z < parseInt(year); z++) {
		if (((((((z - ((z > 0) ? 474 : 473)) % 2820) + 474) + 38) * 682) % 2816) < 682) {
			year2 += 366
			continue
		} else {
			year2 += 365
			continue
		}
	}

	var r = parseInt(year2) + parseInt(addmonth) + parseInt(day) + 226895
	for (var h = 1; r >= 366; h++) {
		if (((h % 4) == 0) && (!(((h % 100) == 0) && ((h % 400) != 0)))) {
			r = r - 366

		} else {
			r = r - 365
		}
	}
	var newYear = h
	var day1 = parseInt(r)
	if (day1 == 0) {
		day1 = 365
		newYear = newYear - 1
	}
	var newMonth = " "
	var newDay = " "
	var allMonth = 0
	var allMonth1 = 0
	for (var l = 0; l < mMonth.length; l++) {
		if (((newYear % 4) == 0) && (!(((newYear % 100) == 0) && ((newYear % 400) != 0)))) {
			mMonth[2] = 29
		}
		allMonth += mMonth[l]
		allMonth1 += mMonth[l + 1]
		if (parseInt(day1) > parseInt(allMonth) && parseInt(day1) <= parseInt(allMonth1)) {
			newMonth = parseInt(l + 1)
			newDay = parseInt(parseInt(day1) - allMonth)
			break
		} else {
			continue
		}
	}
	if (parseInt(newMonth) < 10)
		newMonth = "0" + newMonth;
	if (parseInt(newDay) < 10)
		newDay = "0" + newDay;
	var e = newYear + "/" + newMonth + "/" + newDay;
	obj.value = e;
}

function convertMiladi2khorshidi(obj) {
	var f = obj;
	var separator = f.split("/");
	var year = parseInt(separator[0], 10).toString();
	var month = parseInt(separator[1], 10).toString();
	var day = parseInt(separator[2], 10).toString();
	if (month > 12) {
		alert("The month number is out of range .");
	}
	if (day > 31) {
		alert("The day number is out of range .");
	}


	g_y = year;//parseInt(g_y);
	g_m = month;//parseInt(g_m);
	g_d = day;//parseInt(g_d);
	var gy = g_y - 1600;
	var gm = g_m - 1;
	var gd = g_d - 1;
	var g_day_no = 365 * gy + parseInt((gy + 3) / 4) - parseInt((gy + 99) / 100) + parseInt((gy + 399) / 400);
	for (var i = 0; i < gm; ++i)
		g_day_no += g_days[i];
	if (gm > 1 && ((gy % 4 == 0 && gy % 100 != 0) || (gy % 400 == 0)))
		++g_day_no;
	g_day_no += gd;
	var j_day_no = g_day_no - 79;
	var j_np = parseInt(j_day_no / 12053);
	j_day_no %= 12053;
	var jy = 979 + 33 * j_np + 4 * parseInt(j_day_no / 1461);
	j_day_no %= 1461;
	if (j_day_no >= 366) {
		jy += parseInt((j_day_no - 1) / 365);
		j_day_no = (j_day_no - 1) % 365;
	}
	for (var i = 0; i < 11 && j_day_no >= j_days[i]; ++i)
		j_day_no -= j_days[i];
	var jm = i + 1;
	var jd = j_day_no + 1;

	if (parseInt(jm) < 10)
		jm = "0" + jm;
	if (parseInt(jd) < 10)
		jd = "0" + jd;
	var e = jy + "/" + jm + "/" + jd;
	obj = e;
	return e;
}

function checkReuestNumber() {
	/*if(document.forms[0].requestNumber.value != "")
	{
		if(document.forms[0].requesterId.value != "" && document.forms[0].checkRequestNumber.value == "n")
			alert("ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½");
		else
			if(document.forms[0].requesterId.value != "" && document.forms[0].checkRequestNumber.value == "p")
				alert("ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½");
	}*/
}

function CorrectDateNew(obj) {
	var errorChars = "qwertyuiop[]\asdfghjkl;'.,mnbvcxzZXCVBNMLKJHGFDSAQWERTYUIOP=-+_|}{:?><)(*&^%$#@!";
	var oldDate = obj;
	var checked = 0;
	var newYear = "";
	var newMonth = "";
	var newDay = "";
	var newdate = "";
	var result = "";
	var result1 = "";
	var i = 0;
	var todayDate = new Date();
	var tMonth = parseInt(todayDate.getMonth()) + 1;
	var f = todayDate.getFullYear() + "/" + tMonth + "/" + todayDate.getDate();
	var khMonth = new Array(0, 31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29);
	var mMonth = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var separator = f.split("/");
	var year1 = separator[0];
	if (((year1 % 4) == 0) && (!(((year1 % 100) == 0) && ((year1 % 400) != 0)))) {
		mMonth[2] = 29;
	}
	var year = parseInt(separator[0], 10).toString();
	var month = parseInt(separator[1], 10).toString();
	var day = parseInt(separator[2], 10).toString();
	var addmonth = 0;
	for (var x = 1; x < parseInt(month); x++) {
		addmonth += mMonth[x];
	}

	var year2 = 0;
	for (var z = 1; z < parseInt(year); z++) {
		if (((z % 4) == 0) && (!(((z % 100) == 0) && ((z % 400) != 0)))) {
			year2 += 366;
			continue;
		} else {
			year2 += 365;
			continue;
		}
	}
	var r = parseInt(year2) + parseInt(addmonth) + parseInt(day) - 226895;
	for (var h = 1; r >= 366; h++) {
		if (((((((h - ((h > 0) ? 474 : 473)) % 2820) + 474) + 38) * 682) % 2816) < 682) {
			r = r - 366;

		} else {
			r = r - 365;
		}
	}
	var newYear = h;
	var day1 = parseInt(r);
	if (day1 == 0) {
		day1 = 365;
		newYear = newYear - 1;
	}
	var khorshidiyear = newYear;
	var cyear = khorshidiyear.toString();
	for (i = 0; i < oldDate.length; i++) {
		if (errorChars.indexOf(oldDate.charAt(i)) != -1) {
			checked = 1
		}
	}

	var flag = false;
	if ((oldDate.length < 3 || oldDate.indexOf('/') == -1 || checked == 1) && (oldDate.length != 0)) {
		alert('تاریخ را اشتباه وارد نموده اید !');
		obj = ""
		flag = true;
	} else {
		if (oldDate.length < 10 && oldDate.length != 0) {
			i = oldDate.indexOf('/');
			result = oldDate.substring(0, i);
			result1 = oldDate.substring(i + 1, oldDate.length);
			i = result1.indexOf('/')
			if (i == -1) {
				if (result.length == 1) {
					newDay = "0" + result
				} else {
					newDay = result
				}
				i = oldDate.indexOf('/');
				result = oldDate.substring(i + 1, oldDate.length);
				if (result.length == 1) {
					newMonth = "0" + result
				} else {
					newMonth = result
				}
				if (newMonth > 12 || newMonth < 1 || newDay > 31 || newDay < 1) {
					alert('تاریخ را اشتباه وارد نموده اید !');
					newDate = "";
					flag = true;
				} else {
					newDate = cyear + "/" + newMonth + "/" + newDay
				}
				;
			} else {
				if (result.length == 1) {
					newDay = "0" + result
				} else {
					newDay = result
				}
				oldDate = result1
				result = oldDate.substring(0, i);
				result1 = oldDate.substring(i + 1, oldDate.length);
				i = result1.indexOf('/')
				if (i == -1) {
					i = result.indexOf('/')
					if (result.length == 1) {
						newMonth = "0" + result
					} else {
						newMonth = result
					}
					newYear = result1;
					if (newYear.length == 1) {
						newYear = cyear.substring(0, 3) + newYear
						newDate = newYear + "/" + newMonth + "/" + newDay
					} else if (newYear.length == 2) {
						newYear = cyear.substring(0, 2) + newYear
						newDate = newYear + "/" + newMonth + "/" + newDay
					} else if (newYear.length == 3) {
						newYear = cyear.substring(0, 1) + newYear
						newDate = newYear + "/" + newMonth + "/" + newDay
					} else if (newYear.length == 4) {
						newDate = newYear + "/" + newMonth + "/" + newDay
					} else {
						alert('تاریخ را اشتباه وارد نموده اید !');
						newDate = "";
						flag = true;
					}
					if (newMonth > 12 || newMonth < 1 || newDay > 31 || newDay < 1) {
						alert('تاریخ را اشتباه وارد نموده اید !');
						newDate = "";
						flag = true;
					}
				} else {
					alert('تاریخ را اشتباه وارد نموده اید !');
					newDate = "";
					flag = true;
				}
			}
			if (newDate != null && newDate != "")
				obj = newDate;
			if (newYear > cyear)
				alert('تاریخ را اشتباه وارد نموده اید !');
		}
	}
	return obj;
}
