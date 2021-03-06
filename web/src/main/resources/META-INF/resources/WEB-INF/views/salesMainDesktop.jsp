<%@ page import="com.nicico.copper.common.domain.ConstantVARs" %>
<%@ page import="com.nicico.copper.core.SecurityUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% final String accessToken = (String) session.getAttribute(ConstantVARs.ACCESS_TOKEN); %>

<html>
<head>

    <title><spring:message code='main.Tab.Name'/></title>

    <link rel="sales icon" href="<spring:url value='/static/img/icon/nicico.png' />"/>
    <link rel="stylesheet" href="<spring:url value='/static/css/smartStyle.css' />"/>
    <link rel="stylesheet" href="<spring:url value='/static/css/calendar.css' />"/>
    <link rel="stylesheet" href='<spring:url value="/static/css/commonStyle.css"/>'/>
    <link rel="stylesheet" href='<spring:url value="/static/css/OAManagementUsers.css"/>'/>

    <script src="<spring:url value='/static/script/js/calendar.js'/>"></script>
    <script src="<spring:url value='/static/script/js/jalali-moment.browser.js'/>"></script>
    <script src="<spring:url value='/static/script/js/all.js'/>"></script>
    <script src="<spring:url value='/static/script/js/convertDigitToEnglish.js'/>"></script>
    <script src="<spring:url value='/static/script/js/moment.js'/>"></script>
    <script src="<spring:url value='/static/script/js/jquery.min.js' />"></script>
    <script src="<spring:url value='/static/script/js/persian-date.min.js' />"></script>
    <script src="<spring:url value='/static/script/enumJson/unitEnum.js' />"></script>
    <script src="<spring:url value='/static/script/enumJson/materialEnum.js' />"></script>
    <script src="<spring:url value='/static/script/js/persian-rex.js' />"></script>
    <script src="<spring:url value='/static/script/js/num2persian-min.js' />"></script>
    <script src="<spring:url value='/static/script/js/convertunit.js' />"></script>

    <script>var isomorphicDir = "isomorphic/";</script>
    <script src=isomorphic/system/modules/ISC_Core.js></script>
    <script src=isomorphic/system/modules/ISC_Foundation.js></script>
    <script src=isomorphic/system/modules/ISC_Containers.js></script>
    <script src=isomorphic/system/modules/ISC_Grids.js></script>
    <script src=isomorphic/system/modules/ISC_Forms.js></script>
    <script src=isomorphic/system/modules/ISC_DataBinding.js></script>
    <script src=isomorphic/system/modules/ISC_Drawing.js></script>
    <script src=isomorphic/system/modules/ISC_Charts.js></script>
    <script src=isomorphic/system/modules/ISC_Analytics.js></script>
    <script src=isomorphic/system/modules/ISC_FileLoader.js></script>
    <script SRC=isomorphic/system/modules/ISC_RichTextEditor.js></script>
    <script SRC=isomorphic/skins/Nicico/load_skin.js></script>
    <script src="<spring:url value='/static/script/js/changeSkin.js'/>"></script>

</head>

<c:choose>
<c:when test="${pageContext.response.locale == 'fa'}">
<body class="rtl" dir="rtl">
</c:when>
<c:otherwise>
<body class="ltr" dir="ltr">
</c:otherwise>
</c:choose>

<form action="logout" method="get" id="logoutForm">
</form>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
<spring:eval var="version" expression="@environment.getProperty('spring.application.version')"/>

<script type="application/javascript">
    const mylocale = '${pageContext.response.locale}';

    isc.Class.create.prototype.create = function () {
        const argzz = this.Super('create', arguments)
        this.argzz = arguments
        console.log('argzz', argzz)
        return argzz;
    }
    persianDate.localType = 'en';
    isc.SimpleType.create({
        name: "persianDate",
        inheritsFrom: "text",
        validators: [{
            type: "custom",
            errorMessage: "<spring:message code='validator.field.date'/>",
            condition: "moment().from(value, 'fa', 'YYYY/MM/DD') !== 'Invalid date'"
        }]
    });
    var persianDatePicker = isc.FormItem.getPickerIcon("date", {
        disableOnReadOnly: false,
        src: "pieces/pcal.png",
        click: function (form, item, icon) {
            if (!item.getCanEdit())
                return;
            displayDatePicker(item['ID'], item, 'ymd', '/');
        }
    });

    isc.defineClass("MyRestDataSource", RestDataSource);

    isc.MyRestDataSource.addProperties({
        dataFormat: "json",
        jsonSuffix: "",
        jsonPrefix: "",
        filterLocalData: false,
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer <%= accessToken %>"
            };

            if(Number.isNaN(dsRequest.endRow))
                dsRequest.endRow = 500;

            if(Number.isNaN(dsRequest.startRow))
                dsRequest.startRow = 0;

            return this.Super("transformRequest", arguments);
        },

        transformResponse: function (dsResponse, dsRequest, data) {
            return this.Super("transformResponse", arguments);
        },
        applyFilter: function (data, criteria, requestProperties, startPos, endPos) {

            if (requestProperties && requestProperties.componentId) {

                let grid = window[requestProperties.componentId];
                grid.refreshData();
            }

            return data;
        }
    });

    <%@include file="common/ts/CommonUtil.js"%>
    <%@include file="common/ts/PersianDateUtil.js"%>
    <%@include file="common/ts/FormUtil.js"%>
    <%@include file="common/ts/FindFormUtil.js"%>
    <%@include file="common/ts/GeneralTabUtil.js"%>
    <%@include file="common/ts/StorageUtil.js"%>
    <%@include file="common/ts/FilterFormUtil.js"%>
    <%@include file="common/ts/ReportExecutorFormUtil.js"%>
    <%@include file="common/js/component-file.js"%>

    var Enums = {

        eStatus: {
            "Active": "????????",
            "DeActive": "?????? ??????",
            "Final": "?????????? ??????",
            "SendToAcc": "?????????? ?????? ???? ?????????? ????????",
            "RemoveFromAcc": "?????? ?????? ???? ?????????? ????????"
        },
        eStatus2: JSON.parse('${Enum_EStatus}'),
        eStatus3: JSON.parse('${Enum_EStatus_WithId}'),
        fileAccessLevel: JSON.parse('${Enum_EFileAccessLevel}'),
        fileStatus: JSON.parse('${Enum_FileStatus}'),
        unit: {}
    };
    if (mylocale === "fa")
        var FilterBuilderOperator = {

            equals: '?????????? (????????)',
            iEquals: '??????????',
            notEqual: '?????????????? (????????)',
            iNotEqual: '??????????????',
            greaterThan: '???????????? ????',
            lessThan: '???????????? ????',
            greaterOrEqual: '???????????? ???? ??????????',
            lessOrEqual: '???????????? ???? ??????????',
            between: '?????? (????????)',
            betweenInclusive: '?????? (????????, ????????)',
            iBetween: '??????',
            iBetweenInclusive: '?????? (????????)',
            contains: '???????? (????????)',
            iContains: '????????',
            startsWith: '???????? ???? ?????? ???? (????????)',
            iStartsWith: '???????? ???? ?????? ????',
            endsWith: '???? ?????????? ???? ?????? ???? (????????)',
            iEndsWith: '???? ?????????? ???? ?????? ????',
            notContains: '???????? ???????? (????????)',
            iNotContains: '???????? ????????',
            notStartsWith: '???????? ?????? ?????? ???? (????????)',
            iNotStartsWith: '???????? ?????? ?????? ????',
            notEndsWith: '???? ?????????? ?????? ?????? ???? (????????)',
            iNotEndsWith: '???? ?????????? ?????? ?????? ????',
            isBlank: '???????? ??????',
            notBlank: '???????? ????????',
            isNull: '???????? ?????????? ??????',
            notNull: '???????? ?????????? ????????',
            regexp: '?????????????? ??????????( ????????)',
            iregexp: '?????????????? ??????????',
            matchesPattern: '?????????? ????????(????????)',
            iMatchesPattern: ' ?????????? ????????',
            inSet: '?????? ?????? ????',
            notInSet: '???????? ?????? ????',
            equalsField: '?????????? ???????? (????????)',
            iEqualsField: '?????????? ????????',
            notEqualField: '?????????????? ???? ???????? (????????)',
            iNotEqualField: '???????????? ???? ????????',
            greaterThanField: '???????????? ???? ????????',
            lessThanField: '???????? ???? ????????',
            greaterOrEqualField: '???????????? ???? ?????????? ????????',
            lessOrEqualField: '???????? ???? ?????????? ????????',
            containsField: '???????? ?????????? ???????? (????????)',
            iContainsField: '???????? ?????????? ???????? ',
            startsWithField: '???????? ???? ?????????? ???????? (????????)',
            iStartsWithField: '???????? ???? ?????????? ????????',
            endsWithField: '?????????? ???? ?????????? ????????(????????)',
            iEndsWithField: '?????????? ???? ?????????? ????????',
            notContainsField: '???????? ?????????? ???????? ?????? ??????(????????)',
            iNotContainsField: '???????? ?????????? ???????? ?????? ??????',
            notStartsWithField: '???? ?????????? ???????? ???????? ?????? ??????(????????)',
            iNotStartsWithField: '???? ?????????? ???????? ???????? ?????? ??????',
            notEndsWithField: '???? ?????????? ???????? ???? ?????????? ?????? ??????(????????)',
            iNotEndsWithField: '???? ?????????? ???????? ???? ?????????? ?????? ??????',
            and: '???????????? ???? ??????',
            not: '?????? ????????????',
            or: '?????????? ???? ????????????',
            containsPattern: '???????? ????????(????????)',
            iContainsPattern: '???????? ????????',
            startsWithPattern: '???????? ?????? ???? ????????(????????)',
            iStartsWithPattern: '???????? ?????? ???? ????????',
            endsWithPattern: '?????????? ???? ???????? (????????)',
            iEndsWithPattern: '?????????? ???? ????????',
        };
    else
        var FilterBuilderOperator = {
            equals: 'equals (match case)',
            iEquals: 'equals',
            notEqual: 'not equal (match case)',
            iNotEqual: 'not equal',
            greaterThan: 'greater than',
            lessThan: 'less than',
            greaterOrEqual: 'greater than or equal to',
            lessOrEqual: 'less than or equal to',
            between: 'between (match case)',
            betweenInclusive: 'between (inclusive, match case)',
            iBetween: 'between',
            iBetweenInclusive: 'between (inclusive)',
            contains: 'contains (match case)',
            iContains: 'contains',
            startsWith: 'starts with (match case)',
            iStartsWith: 'starts with',
            endsWith: 'ends with (match case)',
            iEndsWith: 'ends with',
            notContains: 'does not contain (match case)',
            iNotContains: 'does not contain',
            notStartsWith: 'does not start with (match case)',
            iNotStartsWith: 'does not start with',
            notEndsWith: 'does not end with (match case)',
            iNotEndsWith: 'does not end with',
            isBlank: 'is blank',
            notBlank: 'is not blank',
            isNull: 'is null',
            notNull: 'is not null',
            regexp: 'matches expression (match case)',
            iregexp: 'matches expression',
            matchesPattern: 'matches pattern (match case)',
            iMatchesPattern: 'matches pattern',
            inSet: 'is one of',
            notInSet: 'is not one of',
            equalsField: 'matches other field (match case)',
            iEqualsField: 'matches other field',
            notEqualField: 'differs from field (match case)',
            iNotEqualField: 'differs from field',
            greaterThanField: 'greater than field',
            lessThanField: 'less than field',
            greaterOrEqualField: 'greater than or equal to field',
            lessOrEqualField: 'less than or equal to field',
            containsField: 'contains another field value (match case)',
            iContainsField: 'contains another field value',
            startsWithField: 'starts with another field value (match case)',
            iStartsWithField: 'starts with another field value',
            endsWithField: 'ends with another field value (match case)',
            iEndsWithField: 'ends with another field value',
            notContainsField: 'does not contain another field value (match case)',
            iNotContainsField: 'does not contain another field value',
            notStartsWithField: 'does not start with another field value (match case)',
            iNotStartsWithField: 'does not start with another field value',
            notEndsWithField: 'does not end with another field value (match case)',
            iNotEndsWithField: 'does not end with another field value',
            and: 'Match All',
            not: 'Match None',
            or: 'Match Any',
            containsPattern: 'contains pattern (match case)',
            iContainsPattern: 'contains pattern',
            startsWithPattern: 'starts with pattern (match case)',
            iStartsWithPattern: 'starts with pattern',
            endsWithPattern: 'ends with pattern (match case)',
            iEndsWithPattern: 'ends with pattern',
        };

    var ImportantIDs = {
        contractType: {
            Primary: 1,
            Appendix: 2,
            Template: 3
        },
        material: {
            MOLYBDENUM_OXIDE: 1,
            COPPER_CATHOD: 2,
            COPPER_CONCENTRATES: 3
        },
        materialValueMap: {
            1: "MOLYBDENUM OXIDE",
            2: "COPPER CATHOD",
            3: "COPPER CONCENTRATES"
        },
        invoiceType: {
            FINAL: 1,
            PROVISIONAL: 2,
            PERFORMA: 3,
            PI_TRUSTY: 4,
            FI_TRUSTY: 5,
            INSURANCE: 6,
            THC: 7,
            BLFEE: 8,
            UMPIRELAB: 9,
            DEMAND: 10,
            FREIGHT: 11,
            DISPATCH: 12,
            DEMURRAGE: 13,
            INSPECTION: 14
        },
    }

    var BaseRPCRequest = {
        httpHeaders: {"Authorization": "Bearer <%= accessToken %>"},
        useSimpleHttp: true,
        contentType: "application/json; charset=utf-8",
        showPrompt: true,
        serverOutputAsString: false,
        willHandleError: false //centralized error handling
    };

    const BaseFormItems = {

        concat: function (fields, setBaseItemsHidden = true) {

            let items = [];
            if (fields.constructor !== Array)
                return items;

            items.push({...this.formItems[0]});
            items[0].hidden = setBaseItemsHidden;

            for (let i = 0; i < fields.length; i++)
                items.push({...fields[i]});

            for (let i = 1; i < this.formItems.length; i++) {

                items.push({...this.formItems[i]});
                items[items.length - 1].hidden = setBaseItemsHidden;
            }

            return items;
        },
        formItems: [{
            isBaseItem: true,
            hidden: true,
            primaryKey: true,
            canEdit: false,
            name: "id",
            type: "number",
            width: 75,
            title: "<spring:message code='global.id'/>"
        }, {
            isBaseItem: true,
            hidden: true,
            canEdit: false,
            name: "version",
            type: "number",
            width: 70,
            title: "<spring:message code='global.version'/>"
        }, {
            isBaseItem: true,
            hidden: true,
            canEdit: false,
            name: "editable",
            type: "boolean",
            width: 60,
            title: "<spring:message code='global.editable'/>"
        }, {
            isBaseItem: true,
            width: 100,
            canEdit: false,
            name: "estatus",
            hidden: true,
            showHover: true,
            canSort: false,
            multiple: true,
            filterOperator: "equals",
            editorType: "SelectItem",
            valueMap: Enums.eStatus2,
            title: "<spring:message code='global.e-status'/>",
            hoverHTML(record, value, rowNum, colNum, grid) {

                if (record == null || record.estatus == null || record.estatus.length === 0)
                    return;

                return record.estatus.map(q => '<div>' + Enums.eStatus[q] + '</div>').join();
            },
            formatCellValue: function (value, record, rowNum, colNum, grid) {

                if (record == null || record.estatus == null || record.estatus.length === 0)
                    return;

                return record.estatus.join(', ');
            }
        }]
    };

    var salesCommonUtil = new nicico.CommonUtil();
    nicico.CommonUtil.getAlignByLang = function () {

        let locale = languageForm.getValue("languageName");
        return locale === "fa" ? "left" : "right";
    };

    function userAgent() {

        let userAgent = window.navigator.userAgent;
        if (!userAgent.includes("Firefox"))
            return false;
        else
            return true;
    }

    nicico.CommonUtil.getAlignByLangReverse = function () {

        let locale = languageForm.getValue("languageName");
        return locale === "fa" ? "right" : "left";
    };

    nicico.CommonUtil.getLang = function () {

        let locale = languageForm.getValue("languageName");
        return locale === "fa" ? "fa" : "en";
    };

    var salesPersianDateUtil = new nicico.PersianDateUtil();

    isc.DynamicForm.addProperties({
        requiredTitleSuffix: "<span style='color:#ff0842;font-size:15px; padding-left: 5px;'>*</span>" + ":",
        setMethod: 'POST',
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>"
    });

    isc.RichTextEditor.addProperties({
        fontControls: ["fontSizeSelector"]
    });

    isc.SelectItem.addProperties({
        click: function () {
            this.pickList.invalidateCache();
        }
    });

    /*isc.TextItem.addProperties({
        format: ",##0",
        selectOnClick: true,
        hintStyle: "noneStyleFormItem",
        formatEditorValue(value, record, form, item) {
            if (value === undefined || isNaN(value)) return value;
            return NumberUtil.format(value, ",0");
        },
        keyUp(item, form, keyName) {
            if (item.getValue() === undefined || isNaN(item.getValue())) return;

            item.setHint(NumberUtil.format(item.getValue(), ",0"));
        }
    });*/

    function redirectLogin() {
        location.href = "<spring:url value='/' />";
    }

    isc.RPCManager.addClassProperties({
        prompt: "<spring:message code='global.server.contacting'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        fetchDataPrompt: "<spring:message code='global.server.data.fetch'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        removeDataPrompt: "<spring:message code='global.server.data.remove'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        saveDataPrompt: "<spring:message code='global.server.data.save'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        promptStyle: "dialog",
        allowCrossDomainCalls: true,
        handleError: function (response, request) {
            if (!response || response.error === 'invalid_token')
                isc.warn(response.data);
            console.log("Global RPCManager Error Handler: ", request, response);
            if (response.httpResponseCode === 403) { // Forbidden
                isc.say(JSON.parse(response.httpResponseText).exception);
            } else if (response.httpResponseCode === 500) {
                isc.say(JSON.parse(response.httpResponseText).exception + " HTTP Response Code is 500");
            } else if (response.httpResponseCode === 405) {
                isc.say(JSON.parse(response.httpResponseText).exception + " HTTP Response Code is 450");
            }
            const httpResponse = JSON.parse(response.httpResponseText);
            switch (String(httpResponse.error).toUpperCase()) {
                case "UNAUTHORIZED":
                    isc.warn("<spring:message code='exception.AccessDeniedException'/>", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
                case "DATAINTEGRITYVIOLATION_UNIQUE":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation_Unique'/>", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
                case "DATAINTEGRITYVIOLATION_FK":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation_FK'/>", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
                case "DATAINTEGRITYVIOLATION":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation_FK'/>", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
                case "FORBIDDEN":
                    isc.warn("<spring:message code='exception.ACCESS_DENIED'/>", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
                default:
                    if (!httpResponse.errors) return;
                    const errorText = httpResponse.errors.map(q => q.message).join('<br>');
                    isc.warn(errorText, {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
            }
        }
    });

    isc.Dialog.SAY_TITLE = "<spring:message code='global.message'/>";
    Page.setAppImgDir("static/img/");

    function formatCellValueNumber(value, record, rowNum, colNum) {
        // dbg('formatCellValueNumber', this)
        const field = this.getField(colNum)
        // dbg('field', field)
        if (field.type && field.type.toLowerCase() === 'date') {
            // dbg('date field', field, this.Super('formatCellValue', arguments))
            if (value === undefined || isNaN(value)) return value;
            return new Date(value)
        }
        // console.debug("formatCellValueNumber(value) arguments",arguments);
        if (value === undefined || isNaN(value)) return value;
        try {
            return isc.NumberUtil.format(value, ',0');
        } catch (e) {
            console.warn('function formatCellValueNumber(value, record, rowNum, colNum)', e)
            return value;
        }
    }

    /*isc.FormItem.addProperties({
       dateFormatter: this.type && this.type.toLowerCase() === "date" ? "toJapanShortDate" : this.dateFormatter,
    });
    */
    isc.ListGrid.addProperties({
        dataPageSize: 500,
        showPrompt: true,
        canAutoFitFields: false,
        allowFilterExpressions: true,
        allowAdvancedCriteria: true,
        filterOnKeypress: true,
        filterLocalData: false,
        dateFormatter: "toJapanShortDate",
        formatCellValue: formatCellValueNumber,
        sortFieldAscendingText: '<spring:message code="global.grid.sortFieldAscendingText" />',
        sortFieldDescendingText: '<spring:message code="global.grid.sortFieldDescendingText" />',
        configureSortText: '<spring:message code="global.grid.configureSortText" />',
        autoFitAllText: '<spring:message code="global.grid.autoFitAllText" />',
        autoFitFieldText: '<spring:message code="global.grid.autoFitFieldText" />',
        filterUsingText: '<spring:message code="global.grid.filterUsingText" />',
        groupByText: '<spring:message code="global.grid.groupByText" />',
        freezeFieldText: '<spring:message code="global.grid.freezeFieldText" />',
        sortField: "id",
        sortDirection: "descending",
        validateAllData: function () {

            for (let i = 0; i < this.getData().length; i++)
                if (!this.validateRecord(i))
                    return false;

            let allEditRows = this.getAllEditRows();
            for (let i = 0; i < allEditRows.length; i++) {

                if (this.rowHasErrors(allEditRows[i]))
                    return false;
            }

            return true;
        }
    });

    isc.ToolStripButton.addProperties({
        showDownIcon: false,
        showSelectedIcon: false,
        showRollOverIcon: false,
        border: "1px solid lightblue",
        disabledIconCursor: "not-allowed"
    });

    isc.ToolStripMenuButton.addProperties({
        showDownIcon: false,
        showSelectedIcon: false,
        showRollOverIcon: false,
        showMenuOnRollOver: true,
        rollOverMenuHideDelay: 400,
        menuAnimationEffect: "slide",
        disabledCursor: "not-allowed",
        click: function () {
            return false;
        }
    });

    isc.Menu.addProperties({
        canHover: true,
        rowHover: function (record, rowNum, colNum) {

            this.hideSubmenu();
            if (record && record.submenu)
                this.showSubmenu(record);

            return false;
        },
    });

    function createTab(title, url) {
        var localViewLoader = isc.ViewLoader.create({
            width: "100%",
            height: "100%",
            autoDraw: false,
            viewURL: url,
            loadingMessage: " <spring:message code='global.loadingMessage'/>"
        });

        var flagTabExist = false;

        if (mainTabSet.tabs != null) {
            for (i = 0; i < mainTabSet.tabs.length; i++) {

                if (title == mainTabSet.getTab(i).title || (url.includes("oauth") && mainTabSet.getTab(i).pane.viewURL.includes("oauth"))) {
                    mainTabSet.selectTab(i);
                    flagTabExist = true;
                    break;
                }
            }
        }
        if (!flagTabExist)
            mainTabSet.selectTab(mainTabSet.addTab({
                    title: title,
                    canClose: true,
                    pane: localViewLoader
                })
            );
    }


    var label_Username = isc.Label.create({
        width: 200,
        dynamicContents: true,
        contents: "<span class='header-label-username'><spring:message code='global.user'/></span>" + ":" + "<span class='header-label-username-span'>${userFullName}</span>",
    });

    logoutButton = isc.IButton.create({
        width: "80",
        baseStyle: "header-logout",
        title: "<span><spring:message code='global.exit'/><span>",
        icon: "pieces/512/logout.png",
        click: function () {
            document.getElementById("logoutForm").submit();
        }
    });

    var languageForm = isc.DynamicForm.create({
        wrapItemTitles: true,
        height: 30,
        styleName: "header-change-lng",
        fields: [{
            name: "languageName",
            showTitle: false,
            width: 120,
            height: "100%",
            type: "select",
            wrapHintText: false,
            valueMap: {
                "fa": "??????????",
                "en": "English"
            },
            imageURLPrefix: "flags/16/",
            imageURLSuffix: ".png",
            valueIcons: {
                "fa": "fa",
                "en": "en"
            },
            changed: function () {
                var newUrl = window.location.href;
                var locale = languageForm.getValue("languageName");

                if (newUrl.indexOf("lang") > 0) {
                    var regex = new RegExp("lang=[a-zA-Z_]+");
                    newUrl = newUrl.replace(regex, "lang=" + locale);
                } else {
                    if (newUrl.indexOf("?") > 0) {
                        if (newUrl.indexOf("#") > 0) {
                            newUrl = newUrl.replace("#", "&lang=" + locale + "#")
                        } else {
                            newUrl += "&lang=" + locale;
                        }
                    } else {
                        newUrl = newUrl + "?lang=" + locale;
                    }
                }
                window.location.href = newUrl;
            }
        }]
    });
    languageForm.setValue("languageName", "<c:out value='${pageContext.response.locale}'/>");

    if (languageForm.getValue("languageName") == 'fa') {
        isc.FileLoader.loadLocale("fa")
    } else {
        isc.FileLoader.loadLocale("en");
    }


    var languageVLayout = isc.VLayout.create({
        width: "5%",
        align: "center",
        defaultLayoutAlign: "left",
        members: [languageForm]
    });


    var toggleSwitch = isc.HTMLFlow.create({
        width: 32,
        height: "100%",
        align: "center",
        styleName: "toggle-switch",
        contents: "<div id='switch-btn'><img src='static/img/pinSvg.svg'> </div>"
    });

    var languageAndToggleHLayout = isc.HLayout.create({
        width: "5%",
        align: "center",
        defaultLayoutAlign: "left",
        members: [toggleSwitch, languageVLayout]
    });

    var userNameHLayout = isc.HLayout.create({
        width: "10%",
        align: "center",
        members: [label_Username]
    });

    var logoutVLayout = isc.VLayout.create({
        width: "5%",
        align: "center",
        styleName: "header-logout-Vlayout",
        defaultLayoutAlign: "left",
        members: [logoutButton]
    });

    var headerExitHLayout = isc.HLayout.create({
        width: "80%",
        height: "100%",
        align: "center",
        styleName: "header-exit",
        members: [isc.LayoutSpacer.create({width: "80%"}), userNameHLayout, languageAndToggleHLayout, logoutVLayout]
    });


    var headerLogo = isc.HTMLFlow.create({
        width: 350,
        height: "100%",
        styleName: "header-logo",
        contents: "<div class='header-title-right'><div class='header-title-top'><h3><spring:message code='main.salesCompany'/></h3><h4><spring:message code='main.salesName'/></h4></div><div class='header-title-version'><h4><spring:message code='main.salesVersion'/>&nbsp;${version}</h4></div><img width='50' height='50' src='static/img/logo-white.svg'/></div>"
    });

    var headerLayout = isc.HLayout.create({

        width: "100%",
        height: 55,
        styleName: "header-top",
        members: [headerLogo,
            //  headerFlow,
            headerExitHLayout
        ],
    });

    /*----------------------baseTab------------------------*/
    baseTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.baseInfo'/>",
        menu: isc.Menu.create({
            cellPadding: 11,
            placement: "none",
            data: [
                <sec:authorize access="hasAuthority('R_CONTACT') or hasAuthority('R_PERSON')">
                {
                    title: "<spring:message code='main.baseTab.Business'/>",
                    submenu: [
                        <sec:authorize access="hasAuthority('R_CONTACT')">
                        {
                            title: "<spring:message code='commercialParty.title'/>",
                            click: function () {
                                createTab("<spring:message code='commercialParty.title'/>", "<spring:url value="/contact/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_PERSON')">
                        {
                            title: "<spring:message code='person.title'/>",
                            click: function () {
                                createTab("<spring:message code='person.title'/>", "<spring:url value="/person/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        </sec:authorize>
                    ]
                },
                {isSeparator: true},
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_PORT') or hasAuthority('R_VESSEL')">
                {
                    title: "<spring:message code='main.baseTab.test'/>",
                    submenu: [
                        <sec:authorize access="hasAuthority('R_PORT')">
                        {
                            title: "<spring:message code='port.port'/>",
                            click: function () {
                                createTab("<spring:message code='port.port'/>", "<spring:url value="/base-port/show-form" />")
                            }
                        },
                        {isSeparator: true},
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_VESSEL')">
                        {
                            title: "<spring:message code='vessel.title'/>",
                            click: function () {
                                createTab("<spring:message code='vessel.title'/>", "<spring:url value="/vessel/showForm" />")
                            }
                        }
                        </sec:authorize>
                    ]
                },
                {isSeparator: true},
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_CURRENCY_RATE') or hasAuthority('R_BANK') or hasAuthority('R_PRICE_BASE')">
                {
                    title: "<spring:message code='main.baseTab.financial'/>",
                    submenu: [
                        <sec:authorize access="hasAuthority('R_CURRENCY_RATE')">
                        {
                            title: "<spring:message code='currencyRate.title'/>",
                            click: function () {
                                createTab("<spring:message code='currencyRate.title'/>", "<spring:url value="/base-currencyRate/show-form" />")
                            }
                        },
                        {isSeparator: true},
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_BANK')">
                        {
                            title: "<spring:message code='bank.title'/>",
                            click: function () {
                                createTab("<spring:message code='bank.title'/>", "<spring:url value="/bank/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_PRICE_BASE')">
                        {
                            title: "<spring:message code='priceBase.title'/>",
                            click: function () {
                                createTab("<spring:message code='priceBase.title'/>", "<spring:url value="/price-base/showForm" />")
                            }
                        },
                        </sec:authorize>
                    ]
                },
                {isSeparator: true},
                </sec:authorize>

                <sec:authorize access="hasAuthority('R_MATERIAL')">
                {
                    title: "<spring:message code='material.title'/>",
                    click: function () {
                        createTab("<spring:message code='material.title'/>", "<spring:url value="/material/showForm" />")
                    }
                },
                {isSeparator: true},
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_UNIT')">
                {
                    title: "<spring:message code='unit.title'/>",
                    click: function () {
                        createTab("<spring:message code='unit.title'/>", "<spring:url value="base-unit/show-form" />")
                    }
                },
                {isSeparator: true},
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_COUNTRY')">
                {
                    title: "<spring:message code='country.title'/>",
                    click: function () {
                        createTab("<spring:message code='country.title'/>", "<spring:url value="/base-country/show-form" />")
                    }
                },
                {isSeparator: true},
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_SHIPMENT_COST_DUTY')">
                {
                    title: "<spring:message code='shipmentCostInvoiceDetail.service'/>",
                    click: function () {
                        createTab("<spring:message code='shipmentCostInvoiceDetail.service'/>", "<spring:url value="/costDuty/showForm" />")
                    }
                },
                </sec:authorize>
            ]
        }),
    });

    /* Start ----------------------help General---------------------------------*/
    <%--var fillScreenWindow_Main = isc.Window.create({--%>
    <%--    placement: "fillScreen",--%>
    <%--    autoDraw: false,--%>
    <%--    title: "<spring:message code='global.form.help'/>",--%>
    <%--    items: [--%>
    <%--        isc.HLayout.create({--%>
    <%--            width: "100%",--%>
    <%--            layoutMargin: 5,--%>
    <%--            membersMargin: 10,--%>
    <%--            members: [--%>
    <%--                isc.HTMLPane.create({--%>
    <%--                    ID: "myPane2",--%>
    <%--                    showEdges: true,--%>
    <%--                    contentsURL: "/sales/help/general-sales.html",--%>
    <%--                    contentsType: "page"--%>
    <%--                })--%>
    <%--            ]--%>
    <%--        })--%>
    <%--    ]--%>
    <%--});--%>

    /*----------------------foreignSalesTab------------------------*/
    foreignSalesTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.foreign.sales'/>",
        menu: isc.Menu.create({
            cellPadding: 11,
            placement: "none",
            data: [
                <sec:authorize access="hasAuthority('R_CONTRACT') or hasAuthority('R_CONTRACT_TYPE')
                                    or hasAuthority('R_CONTRACT_DETAIL_TYPE') or hasAuthority('R_INCOTERM')">
                {
                    title: "&nbsp; <spring:message code='main.tab.contracts'/>",
                    submenu: [
                        <sec:authorize access="hasAuthority('R_CONTRACT')">
                        {isSeparator: true},
                        {
                            title: "<spring:message code='entity.contract'/>",
                            click: function () {

                                mainTabSet.removeTabs(mainTabSet.tabs.filter(q => q.title === "<spring:message code='entity.contract-template'/>"))
                                createTab("<spring:message code='entity.contract'/>", "<spring:url value="/contract/show-form/" />" + "CONTRACT")
                            }
                        },
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_CONTRACT_TEMPLATE')">
                        {isSeparator: true},
                        {
                            title: "<spring:message code='entity.contract-template'/>",
                            click: function () {

                                mainTabSet.removeTabs(mainTabSet.tabs.filter(q => q.title === "<spring:message code='entity.contract'/>"))
                                createTab("<spring:message code='entity.contract-template'/>", "<spring:url value="/contract/show-form/" />" + "TEMPLATE")
                            }
                        },
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_CONTRACT_TYPE')">
                        {isSeparator: true},
                        {
                            title: "<spring:message code='entity.contract-type'/>",
                            click: function () {
                                createTab("<spring:message code='entity.contract-type'/>", "<spring:url value="/contract-type/show-form" />")
                            }
                        },
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_CONTRACT_DETAIL_TYPE')">
                        {isSeparator: true},
                        {
                            title: "<spring:message code='entity.contract-detail-type'/>",
                            click: function () {
                                createTab("<spring:message code='entity.contract-detail-type'/>", "<spring:url value="/contract-detail-type/show-form" />")
                            }
                        },
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_INCOTERM')">
                        {isSeparator: true},
                        {
                            title: "<spring:message code='entity.incoterm'/>",
                            click: function () {
                                createTab("<spring:message code='entity.incoterm'/>", "<spring:url value="/incoterm/show-form" />")
                            }
                        },
                        </sec:authorize>
                    ]
                },
                {isSeparator: true},
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_SHIPMENT') or hasAuthority('R_BILL_OF_LANDING')
                                    or hasAuthority('R_INSPECTION_REPORT') or hasAuthority('R_SHIPMENT_COST_INVOICE')">
                {
                    title: "&nbsp; <spring:message code='main.shipment'/>",
                    submenu: [
                        <sec:authorize access="hasAuthority('R_SHIPMENT')">
                        {
                            title: "<spring:message code='cargoAssignment.title'/>",
                            click: function () {
                                createTab("<spring:message code='cargoAssignment.title'/>", "<spring:url value="/shipment/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_BILL_OF_LANDING')">
                        {
                            title: "&nbsp; <spring:message code='bol.title'/>",
                            click: function () {
                                createTab("<spring:message code='bol.title'/>", "<spring:url value="/bill-of-landing/show-form" />")
                            }
                        },
                        {isSeparator: true},
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_INSPECTION_REPORT')">
                        {
                            title: "<spring:message code='inspectionReport.title'/>",
                            click: function () {
                                createTab("<spring:message code='inspectionReport.title'/>", "<spring:url value="/inspectionReport/show-form" />")
                            }
                        },
                        {isSeparator: true},
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_SHIPMENT_COST_INVOICE')">
                        {
                            title: "<spring:message code='shipmentCostInvoice.title'/>",
                            click: function () {
                                createTab("<spring:message code='shipmentCostInvoice.title'/>", "<spring:url value="/shipmentCostInvoice/show-form" />")
                            }
                        }
                        </sec:authorize>
                    ]
                },
                {isSeparator: true},
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_FOREIGN_INVOICE')">
                {
                    title: "<spring:message code='entity.foreign-invoice'/>",
                    click: function () {
                        createTab("<spring:message code='entity.foreign-invoice'/>", "<spring:url value="/foreign-invoice/show-form" />")
                    }
                },
                {isSeparator: true},
                </sec:authorize>
                <%--<sec:authorize access="hasAuthority('R_INCOTERM_ASPECT')">
                {isSeparator: true},
                {
                    title: "<spring:message code='entity.incoterm-aspect'/>",
                    click: function () {
                        createTab("<spring:message code='entity.incoterm-aspect'/>", "<spring:url value="/incoterm-aspect/show-form" />")
                    }
                },
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_INCOTERM_STEP')">
                {isSeparator: true},
                {
                    title: "<spring:message code='entity.incoterm-step'/>",
                    click: function () {
                        createTab("<spring:message code='entity.incoterm-step'/>", "<spring:url value="/incoterm-step/show-form" />")
                    }
                },
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_INCOTERM_RULE')">
                {isSeparator: true},
                {
                    title: "<spring:message code='entity.incoterm-rule'/>",
                    click: function () {
                        createTab("<spring:message code='entity.incoterm-rule'/>", "<spring:url value="/incoterm-rule/show-form" />")
                    }
                },
                </sec:authorize>--%>
                <%--<sec:authorize access="hasAuthority('R_INCOTERM_FORM')">
                    {isSeparator: true},
                    {
                        title: "<spring:message code='entity.incoterm-form'/>",
                        click: function () {
                            createTab("<spring:message code='entity.incoterm-form'/>", "<spring:url value="/incoterm-form/show-form" />")
                        }
                    },
                    </sec:authorize>--%>
                <%--<sec:authorize access="hasAuthority('R_INCOTERM_PARTY')">
                    {isSeparator: true},
                    {
                        title: "<spring:message code='entity.incoterm-party'/>",
                        click: function () {
                            createTab("<spring:message code='entity.incoterm-party'/>", "<spring:url value="/incoterm-party/show-form" />")
                        }
                    },
                    </sec:authorize>
                    <sec:authorize access="hasAuthority('R_TERM')">
                    {isSeparator: true},
                    {
                        title: "<spring:message code='entity.term'/>",
                        click: function () {
                            createTab("<spring:message code='entity.term'/>", "<spring:url value="/term/show-form" />")
                        }
                    },
                    </sec:authorize>--%>
            ]
        })
    });

    internalSalesTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.internal.sales'/>",
        menu: isc.Menu.create({
            placement: "none",
            data: [
                <sec:authorize access="hasAuthority('R_VIEW_INTERNAL_INVOICE_DOCUMENT')">
                {
                    title: "<spring:message code='issuedInternalInvoices.title'/>",
                    click: function () {
                        createTab("<spring:message code='issuedInternalInvoices.title'/>", "<spring:url value="/invoiceInternal/showForm" />")
                    }
                },
                {isSeparator: true},
                </sec:authorize>
                <sec:authorize access="hasAuthority('R_INVOICE_SALES')">
                {
                    title: "<spring:message code='invoiceSales.title'/>",
                    click: function () {
                        createTab("<spring:message code='invoiceSales.title'/>", "<spring:url value="/invoiceSales/showForm" />")
                    }
                }
                </sec:authorize>
            ]
        })
    });

    /*----------------------warehousesTab------------------------*/
    warehousesTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.warehouses'/>",
        menu: isc.Menu.create({
            cellPadding: 11,
            placement: "none",
            data: [
                <sec:authorize access="hasAuthority('R_TOZIN_LITE') or hasAuthority('R_TOZIN') or hasAuthority('R_REMITTANCE')">
                {
                    title: "<spring:message code='main.bandar-abbas.warehouse'/>",
                    submenu: [
                        <sec:authorize access="hasAuthority('R_TOZIN_LITE')">
                        {
                            title: "<spring:message code='tozin.onWay'/>",
                            click: function () {

                                try {
                                    createTab("<spring:message code='tozin.onWay'/>", "<spring:url value="/tozin/showOnWayProductForm" />")
                                } catch (e) {
                                    console.error('open /tozin/showOnWayProductFormerror accured ', e);
                                    SalesBaseParameters.deleteAllSavedParametersAndFetchAgain().then(r => {
                                            createTab("<spring:message code='tozin.onWay'/>", "<spring:url value="/tozin/showOnWayProductForm" />")
                                        }
                                    )
                                }
                            }

                        },
                        {isSeparator: true},
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_TOZIN')">
                        {
                            title: "<spring:message code='tozin.between.complex'/>",
                            click: function () {
                                try {
                                    createTab("<spring:message code='tozin.between.complex'/>",
                                        "<spring:url value="/tozin/between-complex-transfer" />")
                                } catch (e) {
                                    console.error('open /tozin/between-complex-transfer error accured ', e);
                                    SalesBaseParameters.deleteAllSavedParametersAndFetchAgain().then(r => {
                                            createTab("<spring:message code='tozin.between.complex'/>",
                                                "<spring:url value="/tozin/between-complex-transfer" />")
                                        }
                                    )
                                }

                            }

                        },
                        {isSeparator: true},
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('R_REMITTANCE')">
                        {
                            title: "<spring:message code='warehouseCadItem.packing.list'/>",
                            click: function () {
                                createTab("<spring:message code='warehouseCadItem.packing.list'/>",
                                    "<spring:url value="/packing-list/show-form" />")
                            }
                        },
                        {
                            title: "<spring:message code='bijack'/>",
                            click: function () {
                                createTab("<spring:message code='bijack'/>", "<spring:url value="/remittance-detail/showForm" />")
                            }
                        },

                        {
                            title: "<spring:message code='entity.remittance-detail'/>",
                            click: function () {
                                createTab("<spring:message code='entity.remittance-detail'/>", "<spring:url value="/remittance-detail/show-pkg-form" />")
                            }
                        },
                        {isSeparator: true},
                        </sec:authorize>
                    ]
                },
                {isSeparator: true},
                </sec:authorize>
                <sec:authorize access="true">
                {
                    title: "<spring:message code='main.shanghai.warehouse'/>",
                    //submenu:[f** chinese]
                },
                </sec:authorize>
            ]
        })
    });

    /*----------------------reportTab------------------------*/
    reportTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.reportTab'/>",
        menu: isc.Menu.create({
            cellPadding: 11,
            placement: "none",
            data: [
                <c:if test="<%= SecurityUtil.isAdmin()%>">
                {
                    title: "<spring:message code='report.menu.report-group'/>",
                    click: function () {
                        createTab("<spring:message code='report.menu.report-group'/>", "<spring:url value="/report-group/show-form" />")
                    }
                },
                {isSeparator: true},
                </c:if>
                <c:if test="<%= SecurityUtil.isAdmin()%>">
                {
                    title: "<spring:message code='report.menu.pattern'/>",
                    click: function () {
                        createTab("<spring:message code='report.menu.pattern'/>", "<spring:url value="/report/show-form" />")
                    }
                },
                {isSeparator: true},
                </c:if>
                <sec:authorize access="hasAuthority('RG_EXECUTE')">
                {
                    title: "<spring:message code='report.menu.execute'/>",
                    click: function () {

                        nicico.ReportExecutorFormUtil.show(null, '<spring:message code="report.menu.execute"/>', null, createTab);
                    }
                },
                {isSeparator: true},
                </sec:authorize>
                {
                    title: "<spring:message code='report.menu.warehouse'/>",
                    click: function () {

                        createTab("<spring:message code='report.menu.warehouse'/>", "<spring:url value="/warehouse-report/show-report-form" />")
                    }
                },
            ]
        })
    });

    /*----------------------securityTab------------------------*/
    securityTab = isc.ToolStripButton.create({
        border: "0",
        title: "<spring:message code='main.securityTab'/>",
        click: function () {
            createTab("<spring:message code='main.securityTab'/>", "web/oauth/landing/show-form", false);
        }
    });
    //---------------------------------------
    var mainTabSet = isc.TabSet.create({
        tabBarPosition: "top",
        width: "100%",
        height: "100%",
        autoDraw: false,
        tabs: [],
        tabBarControls: [
            isc.IButtonClose.create({
                title: "<spring:message code='global.close.tabs'/>",
                width: 100,
                height: 30,
                click: function () {
                    isc.Dialog.create({
                        message: "<spring:message code='global.close.tabs.propmt'/>",
                        icon: "[SKIN]ask.png",
                        title: "<spring:message code='global.ok'/>",
                        buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                        buttonClick: function (button, index) {
                            this.hide();
                            if (index == 0) {
                                mainTabSet.removeTabs(mainTabSet.tabs);
                            }
                        }
                    });
                }
            }),
            "tabScroller", "tabPicker"
        ]
    });

    saleToolStrip = isc.ToolStrip.create({
        align: nicico.CommonUtil.getAlignByLang() === "right" ? "left" : "right",
        membersMargin: 50,
        members: []
    });
    <sec:authorize
    access="hasAuthority('R_CONTACT') or hasAuthority('R_PERSON') or hasAuthority('R_PORT') or hasAuthority('R_VESSEL') or hasAuthority('R_CURRENCY_RATE') or hasAuthority('R_SHIPMENT_COST_DUTY')
                        or hasAuthority('R_BANK') or hasAuthority('R_PRICE_BASE') or hasAuthority('R_MATERIAL') or hasAuthority('R_UNIT') or hasAuthority('R_COUNTRY') or hasAuthority('R_PARAMETERS')">
    saleToolStrip.addMember(baseTab);
    </sec:authorize>
    <sec:authorize
    access="hasAuthority('R_CONTRACT') or hasAuthority('R_CONTRACT_TYPE') or hasAuthority('R_CONTRACT_DETAIL_TYPE') or hasAuthority('R_INCOTERM')
         or hasAuthority('R_SHIPMENT') or hasAuthority('R_BILL_OF_LANDING') or hasAuthority('R_INSPECTION_REPORT') or hasAuthority('R_SHIPMENT_COST_INVOICE')">
    saleToolStrip.addMember(foreignSalesTab);
    </sec:authorize>
    <sec:authorize access="hasAuthority('R_VIEW_INTERNAL_INVOICE_DOCUMENT') or hasAuthority('R_INVOICE_SALES')">
    saleToolStrip.addMember(internalSalesTab);
    </sec:authorize>
    <sec:authorize access="hasAuthority('R_TOZIN_LITE') or hasAuthority('R_TOZIN') or hasAuthority('R_REMITTANCE')">
    saleToolStrip.addMember(warehousesTab);
    </sec:authorize>
    <sec:authorize access="hasAuthority('R_REMITTANCE')">
    saleToolStrip.addMember(reportTab);
    </sec:authorize>
    <sec:authorize access="hasAuthority('UI_USER_MANAGEMENT_SHOW_BUTTON')">
    saleToolStrip.addMember(securityTab);
    </sec:authorize>

    if (!userAgent()) {
        var userAgentLayout = isc.Label.create({
            width: "100%",
            contents: "<span style='width: 100%; color:white; margin:0px; padding:3px; height:100%; font-weight: bold; font-size:18px; background-color:red; text-align: " + nicico.CommonUtil.getAlignByLang() + ";'>" + '<spring:message code='global.browser.user-agent'/>' + "</span>"
        });
        saleToolStrip.addMember(userAgentLayout);
    }

    var MainDesktopMenuH = isc.HLayout.create({
        width: "100%",
        styleName: "main-menu",
        animateStateChanges: true,
        align: "center",
        members: [
            saleToolStrip
        ]
    });

    var headerAndMenu = isc.VLayout.create({
        styleName: "header-and-menu",
        members: [headerLayout, MainDesktopMenuH]
    })

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        backgroundColor: "",
        members: [headerAndMenu, mainTabSet]
    });

    var toggle = true;
    headerAndMenu.setStyleName('header-and-menu toggle-show');
    var switchBtn = document.getElementById('switch-btn');
    switchBtn.addEventListener('click', function onToggleClick(e) {
        setTimeout(function () {
            //switchBtn.classList.remove("fade-in");
            //switchBtn.classList.remove("fade-out");
            if (toggle) {
                switchBtn.firstChild.src = "static/img/unpinSvg.svg";
                headerAndMenu.setStyleName('header-and-menu toggle-hide')
                setTimeout(function () {
                    headerLayout.setVisibility(false);
                    MainDesktopMenuH.setVisibility(false);
                }, 300)

            } else {
                switchBtn.firstChild.src = "static/img/pinSvg.svg";
                headerAndMenu.setStyleName('header-and-menu toggle-show')
                setTimeout(function () {
                    headerLayout.setVisibility(true);
                    MainDesktopMenuH.setVisibility(true);
                }, 300)

            }
            toggle = !toggle;
        }, 100)


        // checked = e.target.checked;
        // if(checked)
        // {
        //
        // 	headerLayout.setStyleName('header-top toggle-hide')
        // 	ribbonHLayout.setStyleName('main-menu toggle-hide')
        // 	headerLayout.setVisibility(false);
        // 	ribbonHLayout.setVisibility(false);
        //
        //
        // }else {
        // 	headerLayout.setStyleName('header-top toggle-show')
        // 	ribbonHLayout.setStyleName('main-menu toggle-show')
        // 	headerLayout.setVisibility(true);
        // 	ribbonHLayout.setVisibility(true);
        // }
    })

    document.addEventListener("mouseout", function (event) {
        if (event.clientY <= 10 || event.pageY <= 10) {
            headerAndMenu.setStyleName('header-and-menu toggle-show')
            //headerLayout.setStyleName('header-top')
            //ribbonHLayout.setStyleName('main-menu')
            setTimeout(function () {
                headerLayout.setVisibility(true);
                MainDesktopMenuH.setVisibility(true);
            }, 100)

        } else if (event.clientY > 100) {
            if (!toggle) {
                headerAndMenu.setStyleName('header-and-menu toggle-hide')
                //headerLayout.setStyleName('header-top')
                //ribbonHLayout.setStyleName('main-menu')
                setTimeout(function () {
                    headerLayout.setVisibility(false);
                    MainDesktopMenuH.setVisibility(false);
                }, 300)

            } else {
                headerAndMenu.setStyleName('header-and-menu toggle-show')
                //	headerLayout.setStyleName('header-top')
                //	ribbonHLayout.setStyleName('main-menu')
                setTimeout(function () {
                    headerLayout.setVisibility(true);
                    MainDesktopMenuH.setVisibility(true);
                }, 100)
            }
        }
    })

    /*Help*/
    <%--isc.HTMLFlow.create({--%>
    <%--    contents: "<div id=\"mybutton\">\n" +--%>
    <%--        "<button class=\"glow-on-hover\"><spring:message code='global.form.help'/></button>\n" +--%>
    <%--        "</div>",--%>
    <%--    dynamicContents: true,--%>
    <%--    click: function () {--%>
    <%--        fillScreenWindow_Main.show();--%>
    <%--    }--%>
    <%--});--%>
    /*Help*/
    SalesDocumentUrl = document.URL.split("?")[0].slice(-1) === "/"
        ? document.URL.split("?")[0].slice(0, -1)
        : document.URL.split("?")[0];
    const SalesConfigs = {
        Urls: {
            completeUrl: SalesDocumentUrl,
            RootUrl: "${contextPath}",
            remittanceRest: "${contextPath}" + "/rest",
        },
        httpHeaders: {"Authorization": "Bearer <%= accessToken %>", "Content-Type": "application/json;charset=UTF-8"},
        userFullName: '<%= SecurityUtil.getFullName()%>',
        valuemanager: {}
    }
    SalesConfigs.debugger = SalesConfigs.Urls.completeUrl.toLowerCase().includes('localhost:8080')

    SalesBaseParameters.deleteAllSavedParametersAndFetchAgain();
    const EnumCategoryUnit = {string: {}, index: {}}

    fetch('api/unit/category-unit', {headers: SalesConfigs.httpHeaders}).then(r => r.json().then(j => {
        j.forEach((e, i) => {
            EnumCategoryUnit.index[e] = i + 1;
            EnumCategoryUnit.string[e] = e
        });
        Object.freeze(EnumCategoryUnit);
    }))

    function dbg(...args) {
        console.debug(...args)
        if (SalesConfigs.debugger && SalesConfigs.Urls.completeUrl.toLowerCase().includes('localhost:8080')) debugger;
    }

    const itemChangedManage = {
        valuemanager: {},
        superMethodEditRecordsDynamicForm: isc.DynamicForm.getInstanceProperty('editRecord'),
        superMethodSetValuesDynamicForm: isc.DynamicForm.getInstanceProperty('setValues'),
        superMethodClearValuesDynamicForm: isc.DynamicForm.getInstanceProperty('clearValues'),
        superMethodClearValuesValuesManager: isc.ValuesManager.getInstanceProperty('clearValues'),
        superMethodEditRecordsValuesManager: isc.ValuesManager.getInstanceProperty('editRecord'),
        superMethodSetValuesValuesManager: isc.ValuesManager.getInstanceProperty('setValues'),
        editRecord: function (_record) {
            if (_record && Object.keys(_record).length > 0) {
                // dbg()
                if (!itemChangedManage.valuemanager[this.getID()])
                    itemChangedManage.valuemanager[this.getID()] = []
                itemChangedManage.valuemanager[this.getID()].add({
                    time: new Date().getTime(),
                    record: _record,
                    type: "setValues"
                })
            }
        },
        itemChanged: function (_item, _newValue) {
            const log = itemChangedManage.valuemanager[this.getID()];
            if (log && log.length > 0
                && log[log.length - 1]['record']
                && log[log.length - 1]['record'][_item.name]
                && _newValue !== log[log.length - 1]['record'][_item.name]
            ) {
                if (_item.getIcon("itemValueChanged")) return;
                let itemToShow = log[log.length - 1]['record'][_item.name];
                if (_item.type && _item.type.toString().includes("date")) itemToShow = new Date(itemToShow);
                if (
                    _item.displayField
                    && _item.optionDataSource
                    && _item.optionDataSource.fetchDataURL
                ) {
                    fetch(_item.optionDataSource.fetchDataURL + "?operator=and&criteria=" + JSON.stringify({
                        fieldName: _item.valueField ? _item.valueField : "id",
                        operator: "equals",
                        value: log[log.length - 1]['record'][_item.name]
                    }), {headers: SalesConfigs.httpHeaders}).then(function (res) {
                        res.json().then(
                            function (response) {
                                if (res.ok && response.response.data.length > 0) {
                                    itemToShow = response.response.data[0][_item.displayField]
                                    if (_item.getIcon("itemValueChanged")) {
                                        _item.removeIcon("itemValueChanged");
                                        _item.addIcon({
                                            name: "itemValueChanged",
                                            inline: true,
                                            // inlineIconAlign: nicico.CommonUtil.getAlignByLangReverse(),
                                            showRTL: nicico.CommonUtil.getAlignByLangReverse() === "right",
                                            src: 'pieces/history.svg',
                                            prompt: itemToShow,
                                            click: _ => isc.say(itemToShow)
                                        })
                                    }
                                }
                            }
                        )
                    })
                }
                _item.addIcon({
                    name: "itemValueChanged",
                    inline: true,
                    // inlineIconAlign: nicico.CommonUtil.getAlignByLangReverse(),
                    showRTL: nicico.CommonUtil.getAlignByLangReverse() === "right",
                    src: 'pieces/history.svg',
                    prompt: itemToShow,
                    click: _ => isc.say(itemToShow)
                })
            }

        },
        clearValues: function () {
            itemChangedManage.valuemanager[this.getID()] = []
            this.getItems().forEach(function (_item) {
                if (_item.getIcon("itemValueChanged")) _item.removeIcon("itemValueChanged");
            })
        }
    }
    isc.DynamicForm.addMethods({
        editRecord: function (_record) {
            itemChangedManage.editRecord.apply(this, arguments)
            return itemChangedManage.superMethodSetValuesDynamicForm.apply(this, arguments)
        },
        setValues: function (_record) {
            itemChangedManage.editRecord.apply(this, arguments)
            return itemChangedManage.superMethodSetValuesDynamicForm.apply(this, arguments)
        },
        itemChanged: function (_item, _newValue) {
            itemChangedManage.itemChanged.apply(this, arguments)
        },
        clearValues: function () {
            itemChangedManage.clearValues.apply(this, arguments)
            return itemChangedManage.superMethodClearValuesDynamicForm.apply(this, arguments)

        }
    })
    isc.ValuesManager.addMethods({
        editRecord: function (_record) {
            itemChangedManage.editRecord.apply(this, arguments)
            return itemChangedManage.superMethodSetValuesValuesManager.apply(this, arguments)
        },
        setValues: function (_record) {
            itemChangedManage.editRecord.apply(this, arguments)
            return itemChangedManage.superMethodSetValuesValuesManager.apply(this, arguments)
        },
        itemChanged: function (_item, _newValue) {
            itemChangedManage.itemChanged.apply(this, arguments)
        },
        clearValues: function () {
            itemChangedManage.clearValues.apply(this, arguments)
            return itemChangedManage.superMethodClearValuesValuesManager.apply(this, arguments)

        }
    })
    isc.DynamicForm.addProperties({
        titleAlign: nicico.CommonUtil.getAlignByLang() === "right" ? "left" : "right"
    });
    isc.IButtonSave.addProperties({
        title: "<spring:message code='global.form.save'/>"
    });
    isc.IButtonCancel.addProperties({
        title: "<spring:message code='global.form.close'/>"
    });

    function clone(item) {

        if (!item)
            return item;

        let result;
        let types = [Number, String, Boolean];
        types.forEach(function (type) {
            if (item instanceof type)
                result = type(item);
        });

        if (typeof result == "undefined") {
            if (Object.prototype.toString.call(item) === "[object Array]") {
                result = [];
                item.forEach(function (child, index, array) {
                    result[index] = clone(child);
                });
            } else if (typeof item == "object") {
                if (item.nodeType && typeof item.cloneNode == "function") {
                    result = item.cloneNode(true);
                } else if (!item.prototype) {
                    if (item instanceof Date) {
                        result = new Date(item);
                    } else {
                        result = {};
                        for (var i in item)
                            result[i] = clone(item[i]);
                    }
                } else {
                    if (false && item.constructor) {
                        result = new item.constructor();
                    } else {
                        result = item;
                    }
                }
            } else {
                result = item;
            }
        }

        return result;
    }

    // function keepItAlive(){setTimeout(_=>{fetch("http://127.0.0.1:8080/sales/api/materialItem/1", {"headers": SalesConfigs.httpHeaders,},).then(_=>{keepItAlive()})},20000)}
    // keepItAlive()

</script>
</body>
</html>
