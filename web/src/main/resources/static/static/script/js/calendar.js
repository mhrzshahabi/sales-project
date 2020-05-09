//////////////////////////////////////////////////////////////
///// Jalali (Shamsi) Calendar Date Picker (JavaScript) /////
////////////////////////////////////////////////////////////

var datePickerDivID = "datepicker";
var iFrameDivID = "datepickeriframe";

var dayArrayShort = new Array('&#1588;', '&#1740;', '&#1583;', '&#1587;', '&#1670;', '&#1662;', '&#1580;');
var dayArrayMed = new Array('&#1588;&#1606;&#1576;&#1607;', '&#1740;&#1705;&#1588;&#1606;&#1576;&#1607;', '&#1583;&#1608;&#1588;&#1606;&#1576;&#1607;', '&#1587;&#1607;&#32;&#1588;&#1606;&#1576;&#1607;', '&#1670;&#1607;&#1575;&#1585;&#1588;&#1606;&#1576;&#1607;', '&#1662;&#1606;&#1580;&#1588;&#1606;&#1576;&#1607;', '&#1580;&#1605;&#1593;&#1607;');
var dayArrayLong = dayArrayMed;
var monthArrayShort = new Array('&#1601;&#1585;&#1608;&#1585;&#1583;&#1740;&#1606;', '&#1575;&#1585;&#1583;&#1740;&#1576;&#1607;&#1588;&#1578;', '&#1582;&#1585;&#1583;&#1575;&#1583;', '&#1578;&#1740;&#1585;', '&#1605;&#1585;&#1583;&#1575;&#1583;', '&#1588;&#1607;&#1585;&#1740;&#1608;&#1585;', '&#1605;&#1607;&#1585;', '&#1570;&#1576;&#1575;&#1606;', '&#1570;&#1584;&#1585;', '&#1583;&#1740;', '&#1576;&#1607;&#1605;&#1606;', '&#1575;&#1587;&#1601;&#1606;&#1583;');
var monthArrayMed = monthArrayShort;
var monthArrayLong = monthArrayShort;

// these variables define the date formatting we're expecting and outputting.
// If you want to use a different format by default, change the defaultDateSeparator
// and defaultDateFormat variables either here or on your HTML page.
var defaultDateSeparator = "/";        // common values would be "/" or "."
var defaultDateFormat = "ymd"    // valid values are "mdy", "dmy", and "ymd"
var dateSeparator = defaultDateSeparator;
var dateFormat = defaultDateFormat;

function getOffset(el) {
    var _x = 0;
    var _y = 0;
    while (el && !isNaN(el.offsetLeft) && !isNaN(el.offsetTop)) {
        _x += el.offsetLeft - el.scrollLeft;
        _y += el.offsetTop - el.scrollTop;
        el = el.offsetParent;
    }
    return {top: _y, left: _x};
}


function displayDatePicker(aVar, displayBelowThisObject, dtFormat, dtSep) {
    var win = document.defaultView || document.parentWindow;
    var id = win[displayBelowThisObject.getID()].getElement().id;
    var targetDateField = document.getElementById(id);

    // if we weren't told what node to display the datepicker beneath, just display it
    // beneath the date field we're updating
    if (!displayBelowThisObject)
        displayBelowThisObject = targetDateField;

    // if a date separator character was given, update the dateSeparator variable
    if (dtSep)
        dateSeparator = dtSep;
    else
        dateSeparator = defaultDateSeparator;

    // if a date format was given, update the dateFormat variable
    if (dtFormat)
        dateFormat = dtFormat;
    else
        dateFormat = defaultDateFormat;

    // var x = getOffset(targetDateField).left;
    // var y = getOffset(targetDateField).top;
    var x = displayBelowThisObject.getPageLeft();
    var y = displayBelowThisObject.getPageTop() + displayBelowThisObject.getHeight();

    // x -= 200;
    // y -= 50;
    drawDatePicker(targetDateField, x, y);

}

/**
 Draw the datepicker object (which is just a table with calendar elements) at the
 specified x and y coordinates, using the targetDateField object as the input tag
 that will ultimately be populated with a date.

 This function will normally be called by the displayDatePicker function.
 */
function drawDatePicker(targetDateField, x, y) {
    var dt = getFieldDate(targetDateField.value);

    // the datepicker table will be drawn inside of a <div> with an ID defined by the
    // global datePickerDivID variable. If such a div doesn't yet exist on the HTML
    // document we're working with, add one.
    if (!document.getElementById(datePickerDivID)) {
        // don't use innerHTML to update the body, because it can cause global variables
        // that are currently pointing to objects on the page to have bad references
        //document.body.innerHTML += "<div id='" + datePickerDivID + "' class='dpDiv'></div>";
        var newNode = document.createElement("div");
        newNode.setAttribute("id", datePickerDivID);
        newNode.setAttribute("class", "dpDiv");
        newNode.setAttribute("style", "visibility: hidden;");
        document.body.appendChild(newNode);
    }

    // move the datepicker div to the proper x,y coordinate and toggle the visiblity
    var pickerDiv = document.getElementById(datePickerDivID);
    pickerDiv.style.position = "absolute";
    pickerDiv.style.left = x + "px";
    pickerDiv.style.top = y + "px";
    pickerDiv.style.visibility = (pickerDiv.style.visibility == "visible" ? "hidden" : "visible");
    pickerDiv.style.display = (pickerDiv.style.display == "block" ? "none" : "block");
    pickerDiv.style.zIndex = 10000000;

    // draw the datepicker table
    // refreshDatePicker(targetDateField.name, dt[0], dt[1], dt[2]);
    refreshDatePicker(targetDateField.id, dt[0], dt[1], dt[2]);
}


/**
 This is the function that actually draws the datepicker calendar.
 */
function refreshDatePicker(dateFieldID, year, month, day) {
    // if no arguments are passed, use today's date; otherwise, month and year
    // are required (if a day is passed, it will be highlighted later)
    var thisDay = getTodayPersian();
    var weekday = (thisDay[3] - thisDay[2] + 1) % 7;
    if (!day)
        day = 1;
    if ((month >= 1) && (year > 0)) {
        thisDay = calcPersian(year, month, 1);
        weekday = thisDay[3];
        thisDay = new Array(year, month, day, weekday);
        thisDay[2] = 1;
    } else {
        day = thisDay[2];
        thisDay[2] = 1;
    }

    // the calendar will be drawn as a table
    // you can customize the table elements with a global CSS style sheet,
    // or by hardcoding style and formatting elements below
    var crlf = "\r\n";
    var TABLE = "<table cols='7' class='dpTable'  cellspacing='2px' cellpadding='2px'>" + crlf;
    var xTABLE = "</table>" + crlf;
    var TR = "<tr class='dpTR'>";
    var TR_title = "<tr>";
    var TR_days = "<tr class='dpDayTR'>";
    var TR_todaybutton = "<tr class='dpTodayButtonTR'>";
    var xTR = "</tr>" + crlf;
    var TD = "<td class='dpTD' onMouseOut='this.className=\"dpTD\";' onMouseOver=' this.className=\"dpTDHover\";' ";    // leave this tag open, because we'll be adding an onClick event
    var TD_title = "<td colspan=5 class='dpTitleTD'>";
    var TD_buttons = "<td class='dpButtonTD' width='10%'>";
    var TD_todaybutton = "<td colspan=7 class='dpTodayButtonTD'><hr/>";
    var TD_days = "<td class='dpDayTD'>";
    var TD_selected = "<td class='dpDayHighlightTD' onMouseOut='this.className=\"dpDayHighlightTD\";' onMouseOver='this.className=\"dpTDHover\";' ";    // leave this tag open, because we'll be adding an onClick event
    var xTD = "</td>" + crlf;
    var DIV_title = "<div class='dpTitleText'>";
    var DIV_selected = "<div class='dpDayHighlight'>";
    var xDIV = "</div>";

    // start generating the code for the calendar table
    var html = TABLE;

    // this is the title bar, which displays the month and the buttons to
    // go back to a previous month or forward to the next month
    html += "<tr class='dpTitleTR'><td colspan='7' valign='top'><table width='100%' cellspacing='0px' cellpadding='0px'>"
    html += TR_title;
    html += TD_buttons + getButtonCodeYear(dateFieldID, thisDay, -1, "&lt;&lt;") + xTD;// << //
    html += TD_buttons + getButtonCode(dateFieldID, thisDay, -1, "&lt;") + xTD;// < //
    html += TD_title + DIV_title + monthArrayLong[thisDay[1] - 1] + thisDay[0] + xDIV + xTD;
    html += TD_buttons + getButtonCode(dateFieldID, thisDay, 1, "&gt;") + xTD;// > //
    html += TD_buttons + getButtonCodeYear(dateFieldID, thisDay, 1, "&gt;&gt;") + xTD;// >> //
    html += xTR;
    html += "</table></td></tr>"

    // this is the row that indicates which day of the week we're on
    html += TR_days;
    var i;
    for (i = 0; i < dayArrayShort.length; i++)
        html += TD_days + dayArrayShort[i] + xTD;
    html += xTR;

    // now we'll start populating the table with days of the month
    html += TR;

    // first, the leading blanks
    if (weekday != 6)
        for (i = 0; i <= weekday; i++)
            html += TD + "&nbsp;" + xTD;

    // now, the days of the month
    var len = 31;
    if (thisDay[1] > 6)
        len = 30;
    if (thisDay[1] == 12 && !leap_persian(thisDay[0]))
        len = 29;

    for (var dayNum = thisDay[2]; dayNum <= len; dayNum++) {
        TD_onclick = " onclick=\"updateDateField('" + dateFieldID + "', '" + getDateString(thisDay) + "');\">";

        if (dayNum == day)
            html += TD_selected + TD_onclick + DIV_selected + dayNum + xDIV + xTD;
        else
            html += TD + TD_onclick + dayNum + xTD;

        // if this is a Friday, start a new row
        if (weekday == 5)
            html += xTR + TR;
        weekday++;
        weekday = weekday % 7;

        // increment the day
        thisDay[2]++;
    }

    // fill in any trailing blanks
    if (weekday > 0) {
        for (i = 6; i > weekday; i--)
            html += TD + "&nbsp;" + xTD;
    }
    html += xTR;

    // add a button to allow the user to easily return to today, or close the calendar
    html += TR_todaybutton + TD_todaybutton;
    var today = getTodayPersian();
    html += "<button class='dpTodayButton' onClick='refreshDatePicker(\"" + dateFieldID + "\", "
        + today[0] + ", " + today[1] + ", " + today[2] + ");'>&#1575;&#1605;&#1585;&#1608;&#1586;</button> ";
//  html += "<button class='dpTodayButton' onClick='refreshDatePicker(\"" + dateFieldID + "\");'>&#1575;&#1605;&#1585;&#1608;&#1586;</button> ";
    html += "<button class='dpTodayButton' onClick='updateDateField(\"" + dateFieldID + "\");'>&#1576;&#1587;&#1578;&#1606;</button>";
    html += xTD + xTR;

    // and finally, close the table
    html += xTABLE;

    document.getElementById(datePickerDivID).innerHTML = html;
    // add an "iFrame shim" to allow the datepicker to display above selection lists
    adjustiFrame();
}


/**
 Convenience function for writing the code for the buttons that bring us back or forward
 a month.
 */
function getButtonCode(dateFieldID, dateVal, adjust, label) {
    var newMonth = (dateVal[1] + adjust) % 12;
    var newYear = dateVal[0] + parseInt((dateVal[1] + adjust) / 12);
    if (newMonth < 1) {
        newMonth += 12;
        newYear += -1;
    }

    return "<button class='dpButton' onClick='refreshDatePicker(\"" + dateFieldID + "\", "
        + newYear + ", " + newMonth + ");'>" + label + "</button>";
}

function getButtonCodeYear(dateFieldID, dateVal, adjust, label) {
    var newMonth = dateVal[1];
    var newYear = (dateVal[0] + adjust);

    return "<button class='dpButton' onClick='refreshDatePicker(\"" + dateFieldID + "\", "
        + newYear + ", " + newMonth + ");'>" + label + "</button>";
}

/**
 Convert a JavaScript Date object to a string, based on the dateFormat and dateSeparator
 variables at the beginning of this script library.
 */
function getDateString(dateVal) {
    var dayString = "00" + dateVal[2];
    var monthString = "00" + (dateVal[1]);
    dayString = dayString.substring(dayString.length - 2);
    monthString = monthString.substring(monthString.length - 2);

    switch (dateFormat) {
        case "dmy" :
            return dayString + dateSeparator + monthString + dateSeparator + dateVal[0];
        case "ymd" :
            return dateVal[0] + dateSeparator + monthString + dateSeparator + dayString;
        case "mdy" :
        default :
            return monthString + dateSeparator + dayString + dateSeparator + dateVal[0];
    }
}


/**
 Convert a string to a JavaScript Date object.
 */
function getFieldDate(dateString) {
    var dateVal;
    var dArray;
    var d, m, y;

    try {
        dArray = splitDateString(dateString);
        if (dArray) {
            switch (dateFormat) {
                case "dmy" :
                    d = parseInt(dArray[0], 10);
                    m = parseInt(dArray[1], 10);
                    y = parseInt(dArray[2], 10);
                    break;
                case "ymd" :
                    d = parseInt(dArray[2], 10);
                    m = parseInt(dArray[1], 10);
                    y = parseInt(dArray[0], 10);
                    break;
                case "mdy" :
                default :
                    d = parseInt(dArray[1], 10);
                    m = parseInt(dArray[0], 10);
                    y = parseInt(dArray[2], 10);
                    break;
            }
            dateVal = new Array(y, m, d);
        } else if (dateString) {
            dateVal = getTodayPersian();
        } else {
            dateVal = getTodayPersian();
        }
    } catch (e) {
        dateVal = getTodayPersian();
    }

    return dateVal;
}


/**
 Try to split a date string into an array of elements, using common date separators.
 If the date is split, an array is returned; otherwise, we just return false.
 */
function splitDateString(dateString) {
    var dArray;
    if (dateString.indexOf("/") >= 0)
        dArray = dateString.split("/");
    else if (dateString.indexOf(".") >= 0)
        dArray = dateString.split(".");
    else if (dateString.indexOf("-") >= 0)
        dArray = dateString.split("-");
    else if (dateString.indexOf("\\") >= 0)
        dArray = dateString.split("\\");
    else
        dArray = false;

    return dArray;
}

/**
 Update the field with the given dateFieldName with the dateString that has been passed,
 and hide the datepicker. If no dateString is passed, just close the datepicker without
 changing the field value.

 Also, if the page developer has defined a function called datePickerClosed anywhere on
 the page or in an imported library, we will attempt to run that function with the updated
 field as a parameter. This can be used for such things as date validation, setting default
 values for related fields, etc. For example, you might have a function like this to validate
 a start date field:
 */
function datePickerClosed(dateField) {
    var dateObj = getFieldDate(dateField.value);
    var today = new Date();
    today = new Date(today.getFullYear(), today.getMonth(), today.getDate());

    if (dateField.name == "StartDate") {
        if (dateObj < today) {
            // if the date is before today, alert the user and display the datepicker again
            alert("Please enter a date that is today or later");
            dateField.value = "";
            document.getElementById(datePickerDivID).style.visibility = "visible";
            adjustiFrame();
        } else {
            // if the date is okay, set the EndDate field to 7 days after the StartDate
            dateObj.setTime(dateObj.getTime() + (7 * 24 * 60 * 60 * 1000));
            var endDateField = document.getElementsByName("EndDate").item(0);
            endDateField.value = getDateString(dateObj);
        }
    }
}


function updateDateField(dateFieldID, dateString) {

    var targetDateField = document.getElementById(dateFieldID);

    if (dateString) {
        targetDateField.value = dateString;
    }

    var pickerDiv = document.getElementById(datePickerDivID);
    pickerDiv.style.visibility = "hidden";
    pickerDiv.style.display = "none";

    adjustiFrame();
    targetDateField.focus();

    // after the datepicker has closed, optionally run a user-defined function called
    // datePickerClosed, passing the field that was just updated as a parameter
    // (note that this will only run if the user actually selected a date from the datepicker)
    if ((dateString) && (typeof (datePickerClosed) == "function"))
        datePickerClosed(targetDateField);
}

function closeCalendarWindow() {
    if (document.getElementById(datePickerDivID) !== null) {
        var pickerDiv = document.getElementById(datePickerDivID);
        pickerDiv.style.visibility = "hidden";
        pickerDiv.style.display = "none";
        adjustiFrame();
    }
}

window.onclick = function (event) {

    if (event.target.className != null && (event.target.className == 'dpButton' || event.target.className == 'dpTodayButton'))
        return;
    else if (event.target.id == null || event.target.id == '')
        return;
    else if (document.getElementById(event.target.id) != null) {

        var windowClickVar = document.getElementById(event.target.id);
        if (typeof windowClickVar.src == 'undefined' || ((typeof windowClickVar.src !== 'undefined' && windowClickVar.src.substr(windowClickVar.src.length - 8, 8) != "pcal.png")
            && (typeof windowClickVar.src !== 'undefined' && windowClickVar.src.substr(windowClickVar.src.length - 15, 15) != "date_picker.png"))) {
            closeCalendarWindow();
        }
    } else
        closeCalendarWindow();
}


/**
 Use an "iFrame shim" to deal with problems where the datepicker shows up behind
 selection list elements, if they're below the datepicker. The problem and solution are
 described at:

 http://dotnetjunkies.com/WebLog/jking/archive/2003/07/21/488.aspx
 http://dotnetjunkies.com/WebLog/jking/archive/2003/10/30/2975.aspx
 */
function adjustiFrame(pickerDiv, iFrameDiv) {
    // we know that Opera doesn't like something about this, so if we
    // think we're using Opera, don't even try
    var is_opera = (navigator.userAgent.toLowerCase().indexOf("opera") != -1);
    if (is_opera)
        return;

    // put a try/catch block around the whole thing, just in case
    try {
        if (!document.getElementById(iFrameDivID)) {
            // don't use innerHTML to update the body, because it can cause global variables
            // that are currently pointing to objects on the page to have bad references
            //document.body.innerHTML += "<iframe id='" + iFrameDivID + "' src='javascript:false;' scrolling='no' frameborder='0'>";
            var newNode = document.createElement("iFrame");
            newNode.setAttribute("id", iFrameDivID);
            newNode.setAttribute("src", "javascript:false;");
            newNode.setAttribute("scrolling", "no");
            newNode.setAttribute("frameborder", "0");
            document.body.appendChild(newNode);
        }

        if (!pickerDiv)
            pickerDiv = document.getElementById(datePickerDivID);
        if (!iFrameDiv)
            iFrameDiv = document.getElementById(iFrameDivID);

        try {
            iFrameDiv.style.position = "absolute";
            iFrameDiv.style.width = pickerDiv.offsetWidth;
            iFrameDiv.style.height = pickerDiv.offsetHeight;
            iFrameDiv.style.top = pickerDiv.style.top;
            iFrameDiv.style.left = pickerDiv.style.left;
            iFrameDiv.style.zIndex = pickerDiv.style.zIndex - 1;
            iFrameDiv.style.visibility = pickerDiv.style.visibility;
            iFrameDiv.style.display = pickerDiv.style.display;
        } catch (e) {
        }

    } catch (ee) {
    }

}

/*
  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                Modulus function which works for non-integers. --> <<<<< Calculate Persian Date >>>>>
  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

*/

function mod(a, b) {
    return a - (b * Math.floor(a / b));
}

function jwday(j) {
    return mod(Math.floor((j + 1.5)), 7);
}

var Weekdays = new Array("Sunday", "Monday", "Tuesday", "Wednesday",
    "Thursday", "Friday", "Saturday");

//  LEAP_GREGORIAN  --  Is a given year in the Gregorian calendar a leap year ?

function leap_gregorian(year) {
    return ((year % 4) == 0) &&
        (!(((year % 100) == 0) && ((year % 400) != 0)));
}

//  GREGORIAN_TO_JD  --  Determine Julian day number from Gregorian calendar date

var GREGORIAN_EPOCH = 1721425.5;

function gregorian_to_jd(year, month, day) {
    return (GREGORIAN_EPOCH - 1) +
        (365 * (year - 1)) +
        Math.floor((year - 1) / 4) +
        (-Math.floor((year - 1) / 100)) +
        Math.floor((year - 1) / 400) +
        Math.floor((((367 * month) - 362) / 12) +
            ((month <= 2) ? 0 :
                    (leap_gregorian(year) ? -1 : -2)
            ) +
            day);
}

//  JD_TO_GREGORIAN  --  Calculate Gregorian calendar date from Julian day

function jd_to_gregorian(jd) {
    var wjd, depoch, quadricent, dqc, cent, dcent, quad, dquad,
        yindex, dyindex, year, yearday, leapadj;

    wjd = Math.floor(jd - 0.5) + 0.5;
    depoch = wjd - GREGORIAN_EPOCH;
    quadricent = Math.floor(depoch / 146097);
    dqc = mod(depoch, 146097);
    cent = Math.floor(dqc / 36524);
    dcent = mod(dqc, 36524);
    quad = Math.floor(dcent / 1461);
    dquad = mod(dcent, 1461);
    yindex = Math.floor(dquad / 365);
    year = (quadricent * 400) + (cent * 100) + (quad * 4) + yindex;
    if (!((cent == 4) || (yindex == 4))) {
        year++;
    }
    yearday = wjd - gregorian_to_jd(year, 1, 1);
    leapadj = ((wjd < gregorian_to_jd(year, 3, 1)) ? 0
            :
            (leap_gregorian(year) ? 1 : 2)
    );
    month = Math.floor((((yearday + leapadj) * 12) + 373) / 367);
    day = (wjd - gregorian_to_jd(year, month, 1)) + 1;

    return new Array(year, month, day);
}

//  LEAP_PERSIAN  --  Is a given year a leap year in the Persian calendar ?

function leap_persian(year) {
    return ((((((year - ((year > 0) ? 474 : 473)) % 2820) + 474) + 38) * 682) % 2816) < 682;
}

//  PERSIAN_TO_JD  --  Determine Julian day from Persian date

var PERSIAN_EPOCH = 1948320.5;
var PERSIAN_WEEKDAYS = new Array("�����", "������",
    "�� ����", "��������",
    "��� ����", "����", "����");

function persian_to_jd(year, month, day) {
    var epbase, epyear;

    epbase = year - ((year >= 0) ? 474 : 473);
    epyear = 474 + mod(epbase, 2820);

    return day +
        ((month <= 7) ?
                ((month - 1) * 31) :
                (((month - 1) * 30) + 6)
        ) +
        Math.floor(((epyear * 682) - 110) / 2816) +
        (epyear - 1) * 365 +
        Math.floor(epbase / 2820) * 1029983 +
        (PERSIAN_EPOCH - 1);
}

//  JD_TO_PERSIAN  --  Calculate Persian date from Julian day

function jd_to_persian(jd) {
    var year, month, day, depoch, cycle, cyear, ycycle,
        aux1, aux2, yday;


    jd = Math.floor(jd) + 0.5;

    depoch = jd - persian_to_jd(475, 1, 1);
    cycle = Math.floor(depoch / 1029983);
    cyear = mod(depoch, 1029983);
    if (cyear == 1029982) {
        ycycle = 2820;
    } else {
        aux1 = Math.floor(cyear / 366);
        aux2 = mod(cyear, 366);
        ycycle = Math.floor(((2134 * aux1) + (2816 * aux2) + 2815) / 1028522) +
            aux1 + 1;
    }
    year = ycycle + (2820 * cycle) + 474;
    if (year <= 0) {
        year--;
    }
    yday = (jd - persian_to_jd(year, 1, 1)) + 1;
    month = (yday <= 186) ? Math.ceil(yday / 31) : Math.ceil((yday - 6) / 30);
    day = (jd - persian_to_jd(year, month, 1)) + 1;
    return new Array(year, month, day);
}

function calcPersian(year, month, day) {
    var date, j;

    j = persian_to_jd(year, month, day);
    date = jd_to_gregorian(j);
    weekday = jwday(j);
    return new Array(date[0], date[1], date[2], weekday);
}

//  calcGregorian  --  Perform calculation starting with a Gregorian date
function calcGregorian(year, month, day) {
    month--;

    var j, weekday;

    //  Update Julian day

    j = gregorian_to_jd(year, month + 1, day) +
        (Math.floor(0 + 60 * (0 + 60 * 0) + 0.5) / 86400.0);

    //  Update Persian Calendar
    perscal = jd_to_persian(j);
    weekday = jwday(j);
    return new Array(perscal[0], perscal[1], perscal[2], weekday);
}

function getTodayGregorian() {
    var t = new Date();
    var today = new Date();

    var y = today.getYear();
    if (y < 1000) {
        y += 1900;
    }

    return new Array(y, today.getMonth() + 1, today.getDate(), t.getDay());
}

function getTodayPersian() {
    var t = new Date();
    var today = getTodayGregorian();

    var persian = calcGregorian(today[0], today[1], today[2]);
    return new Array(persian[0], persian[1], persian[2], t.getDay());
}

function CorrectDateEn(obj) {
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


    var cyear = year.toString();
    for (i = 0; i < oldDate.length; i++) {
        if (errorChars.indexOf(oldDate.charAt(i)) != -1) {
            checked = 1
        }
    }

    if ((oldDate.length < 3 || oldDate.indexOf('/') == -1 || checked == 1) && (oldDate.length != 0)) {
        alert('����� �� ������ ���� ����� ��� !');
        obj = ""
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
                    alert('����� �� ������ ���� ����� ��� !');
                    newDate = ""
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
                        alert('����� �� ������ ���� ����� ��� !');
                        newDate = ""
                    }
                    if (newMonth > 12 || newMonth < 1 || newDay > 31 || newDay < 1) {
                        alert('����� �� ������ ���� ����� ��� !');
                        newDate = ""
                    }
                } else {
                    alert('����� �� ������ ���� ����� ��� !');
                    newDate = ""
                }
            }
            obj = newDate;
            if (newYear > cyear)
                alert("��� ���� ��� �� ��� ���� ��ѐ�� ���");
            return newDate;
        }
    }
}

function CorrectDate(oldDate) {
    if (oldDate == null)
        oldDate = "";
    var errorChars = "qwertyuiop[]\asdfghjkl;'.,mnbvcxzZXCVBNMLKJHGFDSAQWERTYUIOP=-+_|}{:?><)(*&^%$#@!";
    //var oldDate=obj.value;
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
        alert('تاريخ را اشتباه وارد نموده ايد !');
        oldDate = ""
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
                    alert('تاريخ را اشتباه وارد نموده ايد !');
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
                        alert('تاريخ را اشتباه وارد نموده ايد !');
                        newDate = "";
                        flag = true;
                    }
                    if (newMonth > 12 || newMonth < 1 || newDay > 31 || newDay < 1) {
                        alert('تاريخ را اشتباه وارد نموده ايد !');
                        newDate = "";
                        flag = true;
                    }
                } else {
                    alert('تاريخ را اشتباه وارد نموده ايد !');
                    newDate = "";
                    flag = true;
                }
            }
            return newDate;

        }
    }
}



