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

<script type="application/javascript">
    persianDate.localType = 'en';
    isc.SimpleType.create({
        name: "persianDate",
        inheritsFrom: "text",
        validators: [{
            type: "custom",
            errorMessage: "<spring:message code='validator.field.date'/>",
            condition: "moment.from(value, 'fa', 'YYYY/MM/DD').isValid()"
        }]
    });
    var persianDatePicker = isc.FormItem.getPickerIcon("date", {
        disableOnReadOnly: false,
        click: function (form, item, icon) {
            if (!item.getCanEdit())
                return;
            closeCalendarWindow();
            displayDatePicker(null, item, 'ymd', '/');
        },
        blur: function () {
            closeCalendarWindow();
        },
    });

    <%@include file="common/ts/CommonUtil.js"%>
    <%@include file="common/ts/PersianDateUtil.js"%>
    <%@include file="common/ts/FormUtil.js"%>
    <%@include file="common/ts/FindFormUtil.js"%>
    <%@include file="common/ts/GeneralTabUtil.js"%>
    <%@include file="common/ts/StorageUtil.js"%>

    var Enums = {

        eStatus: {
            "Active": "عادی",
            "DeActive": "حذف شده"
        },
        deductionType: {
            1: "Unit",
            2: "Percent",
            3: "Discount"
        }
    };

    var ImportantIDs = {
        material: {
            MOLYBDENUM_OXIDE: 1,
            COPPER_CATHOD: 2,
            COPPER_CONCENTRATES: 3
        },
        invoiceType: {
            PERFORMA: 1,
            PROVISIONAL: 2,
            FINAL: 3
        }
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
            type: "number",
            hidden: true,
            showHover: true,
            canSort: false,
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
    var salesPersianDateUtil = new nicico.PersianDateUtil();

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    isc.DynamicForm.addProperties({
        requiredTitlePrefix: "<span style='color:#ff0842;font-size:15px; padding-left: 5px;'>*</span>",
        setMethod: 'POST',
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>"
    });

    isc.RichTextEditor.addProperties({
        fontControls: ["fontSizeSelector"]
    });

    isc.defineClass("MyRestDataSource", RestDataSource);

    isc.MyRestDataSource.addProperties({
        dataFormat: "json",
        jsonSuffix: "",
        jsonPrefix: "",
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer <%= accessToken %>"
            };
            return this.Super("transformRequest", arguments);
        },

        transformResponse: function (dsResponse, dsRequest, data) {
            return this.Super("transformResponse", arguments);
        }
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
        defaultPrompt: "<spring:message code='global.server.contacting'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        fetchDataPrompt: "<spring:message code='global.server.data.fetch'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        removeDataPrompt: "<spring:message code='global.server.data.remove'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        saveDataPrompt: "<spring:message code='global.server.data.save'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        promptStyle: "dialog",
        allowCrossDomainCalls: true,
        handleError: function (response, request) {
            if (response.error == 'invalid_token')
                isc.warn(response.data);
            console.log("Global RPCManager Error Handler: ", request, response);
            if (response.httpResponseCode == 403) { // Forbidden
                isc.say(JSON.parse(response.httpResponseText).exception);
            } else if (response.httpResponseCode == 500) {
                isc.say(JSON.parse(response.httpResponseText).exception + " HTTP Response Code is 500");
            } else if (response.httpResponseCode == 405) {
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
                    const errorText = httpResponse.errors.map(q => q.message + '<br>').join();
                    isc.warn(errorText, {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
            }
        }
    });

    isc.Dialog.SAY_TITLE = "<spring:message code='global.message'/>";
    Page.setAppImgDir("static/img/");

    function formatCellValueNumber(value) {
        // console.debug("formatCellValueNumber(value) arguments",arguments);
        if (value === undefined || isNaN(value)) return value;
        return isc.NumberUtil.format(value, ',0');
    }

    isc.ListGrid.addProperties({
        dataPageSize: 500,
        showPrompt: true,
        canAutoFitFields: false,
        allowFilterExpressions: true,
        allowAdvancedCriteria: true,
        filterOnKeypress: true,
        formatCellValue: formatCellValueNumber,
        sortFieldAscendingText: '<spring:message code="global.grid.sortFieldAscendingText" />',
        sortFieldDescendingText: '<spring:message code="global.grid.sortFieldDescendingText" />',
        configureSortText: '<spring:message code="global.grid.configureSortText" />',
        autoFitAllText: '<spring:message code="global.grid.autoFitAllText" />',
        autoFitFieldText: '<spring:message code="global.grid.autoFitFieldText" />',
        filterUsingText: '<spring:message code="global.grid.filterUsingText" />',
        groupByText: '<spring:message code="global.grid.groupByText" />',
        freezeFieldText: '<spring:message code="global.grid.freezeFieldText" />',
        getAllData: function () {

            let data = [...this.getData()];
            let allEditRows = this.getAllEditRows();
            for (let i = 0; i < allEditRows.length; i++)
                data.push({...this.getEditedRecord(allEditRows[i])});

            return data;
        },
        validateAllData: function () {

            for (let i = 0; i < this.getAllData().length; i++)
                if (!this.validateRecord(i))
                    return false;

            return true;
        }
    });

    isc.ToolStripButton.addProperties({
        showDownIcon: false,
        showSelectedIcon: false,
        showRollOverIcon: false,
        showMenuOnRollOver: true,
        disabledCursor: "not-allowed",
        border: "1px solid lightblue"
    });

    isc.ToolStripMenuButton.addProperties({
        showDownIcon: false,
        showSelectedIcon: false,
        showRollOverIcon: false,
        showMenuOnRollOver: true,
        disabledCursor: "not-allowed",
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
        width: 120,
        height: 30,
        styleName: "header-change-lng",
        fields: [{
            name: "languageName",
            showTitle: false,
            width: 100,
            height: "100%",
            type: "select",
            wrapHintText: false,
            valueMap: {
                "fa": "پارسی",
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
        contents: "<div class='header-title-right'><div class='header-title-top'><h3><spring:message code='main.salesCompany'/></h3><h4><spring:message code='main.salesName'/></h4></div><div class='header-title-version'><h4><spring:message code='main.salesVersion'/></h4></div><img width='50' height='50' src='static/img/logo-white.svg'/></div>"
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
        title: "&nbsp; <spring:message code='main.baseTab'/>",
        menu: isc.Menu.create({
            placement: "none",
            data: [


                {
                    title: "<spring:message code='main.baseTab.Business'/>",
                    submenu: [

                        {
                            title: "<spring:message code='commercialParty.title'/>",
                            click: function () {
                                createTab("<spring:message code='commercialParty.title'/>", "<spring:url value="/contact/showForm" />")
                            }
                        },
                        {isSeparator: true},


                        {
                            title: "<spring:message code='person.title'/>",
                            click: function () {
                                createTab("<spring:message code='person.title'/>", "<spring:url value="/person/showForm" />")
                            }
                        },
                        {isSeparator: true},


                        {
                            title: "<spring:message code='groups.title'/>",
                            click: function () {
                                createTab("<spring:message code='groups.title'/>", "<spring:url value="/groups/showForm" />")
                            }
                        },
                        {isSeparator: true},

                    ]
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='main.baseTab.test'/>",
                    submenu: [
                        {
                            title: "<spring:message code='port.port'/>",
                            click: function () {
                                createTab("<spring:message code='port.port'/>", "<spring:url value="/port/showForm" />")
                            }
                        }, {
                            title: "<spring:message code='vessel.title'/>",
                            click: function () {
                                createTab("<spring:message code='vessel.title'/>", "<spring:url value="/vessel/showForm" />")
                            }
                        }
                    ]
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='main.baseTab.financial'/>",
                    submenu: [
                        {
                            title: "<spring:message code='unit.title'/>",
                            click: function () {
                                createTab("<spring:message code='unit.title'/>", "<spring:url value="/unit/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        {
                            title: "<spring:message code='currencyRate.title'/>",
                            click: function () {
                                createTab("<spring:message code='currencyRate.title'/>", "<spring:url value="/currencyRate/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        {
                            title: "<spring:message code='currency.title'/>",
                            click: function () {
                                createTab("<spring:message code='currency.title'/>", "<spring:url value="/currency/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        {
                            title: "<spring:message code='bank.title'/>",
                            click: function () {
                                createTab("<spring:message code='bank.title'/>", "<spring:url value="/bank/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        {
                            title: "<spring:message code='priceBase.title'/>",
                            click: function () {
                                createTab("<spring:message code='priceBase.title'/>", "<spring:url value="/price-base/showForm" />")
                            }
                        },
                    ]
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='material.title'/>",
                    click: function () {
                        createTab("<spring:message code='material.title'/>", "<spring:url value="/material/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='country.title'/>",
                    click: function () {
                        createTab("<spring:message code='country.title'/>", "<spring:url value="/country/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='parameters.title'/>",
                    click: function () {
                        createTab("<spring:message code='parameters.title'/>", "<spring:url value="/parameters/showForm" />")
                    }
                }
            ]
        }),
    });

    /* Start ----------------------help General---------------------------------*/
    var fillScreenWindow_Main = isc.Window.create({
        placement: "fillScreen",
        autoDraw: false,
        title: "<spring:message code='global.form.help'/>",
        items: [
            isc.HLayout.create({
                width: "100%",
                layoutMargin: 5,
                membersMargin: 10,
                members: [
                    isc.HTMLPane.create({
                        ID: "myPane2",
                        showEdges: true,
                        contentsURL: "/sales/help/general-sales.html",
                        contentsType: "page"
                    })
                ]
            })
        ]
    });

    /*----------------------settingTab------------------------*/
    settingTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.settingTab'/>",
        click: function () {
            createTab("<spring:message code='main.settingTab'/>", "<spring:url value="web/oauth/landing/show-form" />", false);
        }
    });

    /*----------------------contractsTab------------------------*/
    contractsTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.contractsTab'/>",
        menu: isc.Menu.create({
            placement: "none",
            data: [
                {
                    title: "<spring:message code='salesContract.title'/>",
                    submenu: [
                        {
                            title: "<spring:message code='salesContractAll.title'/>",
                            click: function () {
                                enContract();
                                createTab("<spring:message code='salesContract.title'/>", "<spring:url value="/contract/showForm" />")
                            }
                        }, {
                            title: "<spring:message code='salesContractMoButton.title'/>",
                            click: function () {
                                enContract();
                                createTab("<spring:message code='salesContractMoButton.title'/>", "<spring:url value="/contact/contactMolybdenum"/>")
                            }
                        }, {
                            title: "<spring:message code='salesContractConcButton.title'/>",
                            click: function () {
                                enContract();
                                createTab("<spring:message code='main.contractsConcTab'/>", "<spring:url value="/contact/concMain"/>")
                            }
                        },
                        {isSeparator: true},
                        {
                            title: "<spring:message code='salesContractCADButton.title'/>",
                            click: function () {
                                enContract();
                                createTab("<spring:message code='main.contractsCadTab'/>", "<spring:url value="/contact/cadMain"/>")
                            }
                        }
                    ]
                },
                <sec:authorize access="hasAuthority('R_CONTRACT2')">
                {isSeparator: true},
                {
                    title: "<spring:message code='entity.contract'/>",
                    click: function () {
                        createTab("<spring:message code='entity.contract'/>", "<spring:url value="/contract2/show-form" />")
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
                {isSeparator: true},
                {
                    title: "<spring:message code='charter.title'/>",
                    click: function () {
                        createTab("<spring:message code='charter.title'/>", "<spring:url value="/shipmentContract/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='contractPerson.title'/>",
                    click: function () {
                        createTab("<spring:message code='contractPerson.title'/>", "<spring:url value="/contractPerson/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='inspectionReport.title'/>",
                    click: function () {
                        createTab("<spring:message code='inspectionReport.title'/>", "<spring:url value="/inspectionReport/show-form" />")
                    }
                },
            ]
        })
    });

    /*----------------------shipmentTab------------------------*/
    shipmentTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.shipmentTab'/>",
        menu: isc.Menu.create({
            placement: "none",
            data: [
                {
                    title: "<spring:message code='cargoAssignment.title'/>",
                    click: function () {
                        createTab("<spring:message code='cargoAssignment.title'/>", "<spring:url value="/shipment/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='shipmentCost.title'/>",
                    click: function () {
                        createTab("<spring:message code='shipmentCost.title'/>", "<spring:url value="/cost/showForm" />")
                    }
                }
            ]
        })
    });

    //-----------------------reporttab
    reportTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.reportTab'/>",
        click: function () {
            createTab("<spring:message code='main.reportTab'/>", "<spring:url value="/contract/show-report-form" />")
        }
    })

    /*----------------------productTab------------------------*/
    productTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.productTab'/>",
        menu: isc.Menu.create({
            placement: "none",
            data: [
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
                {
                    title: "<spring:message code='bijack'/>",
                    click: function () {
                        createTab("<spring:message code='bijack'/>", "<spring:url value="/warehouseCad/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='warehouseStock'/>",
                    click: function () {
                        createTab("<spring:message code='warehouseStock'/>", "<spring:url value="/warehouseStock/showForm" />")
                    }
                },
                {isSeparator: true},
                <%--{   visibility:"hidden",--%>
                <%--    title: "بیجک ورودی خروجی",--%>
                <%--    click: function () {--%>
                <%--        createTab("بیجک ورودی خروجی", "<spring:url value="/remittance/showForm" />")--%>
                <%--    }--%>
                <%--},--%>
            ]
        })
    });

    /*----------------------financialTab------------------------*/
    financialTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.financialTab'/>",
        menu: isc.Menu.create({
            placement: "none",
            data: [
                <sec:authorize access="hasAuthority('R_FOREIGN_INVOICE')">
                {
                    title: "<spring:message code='entity.foreign-invoice'/>",
                    click: function () {
                        createTab("<spring:message code='entity.foreign-invoice'/>", "<spring:url value="/foreign-invoice/show-form" />")
                    }
                },
                {isSeparator: true},
                </sec:authorize>
                {
                    title: "<spring:message code='issuedInvoices.title'/>",
                    click: function () {
                        var url_string = window.location.href;
                        var url = new URL(url_string);
                        var lang = url.searchParams.get("lang");

                        createTab("<spring:message code='issuedInvoices.title'/>", "<spring:url value="/invoice/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='issuedInternalInvoices.title'/>",
                    click: function () {
                        createTab("<spring:message code='issuedInternalInvoices.title'/>", "<spring:url value="/invoiceInternal/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='invoiceSales.title'/>",
                    click: function () {
                        createTab("<spring:message code='invoiceSales.title'/>", "<spring:url value="/invoiceSales/showForm" />")
                    }
                }/*,
                {
                    title: "<spring:message code='invoiceSales.title'/>",
                    click: function () {
                        createTab("<spring:message code='invoiceSales.title'/>", "<spring:url value="/invoice-export/showForm" />")
                    }
                }*/
            ]
        })
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
                        buttons: [isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}), isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})],
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
        align: "center",
        membersMargin: 20,

        members: [
            baseTab,
            contractsTab,
            shipmentTab,
            financialTab,
            // inspectionTab,
            productTab,
            reportTab,
            settingTab,
        ]
    });


    var MainDesktopMenuH = isc.HLayout.create({
        width: "100%",
        height: 10,
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


    <sec:authorize access="hasAuthority('R_CURRENCY')">
    {
        var dollar = {};
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/currency/list",
                httpMethod: "GET",
                data: "",
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                        var data = JSON.parse(RpcResponse_o.data);
                        for (x of data) {
                            dollar[x.nameEn] = x.nameEn;
                        }
                    } //if rpc
                } // callback
            })
        );
    }
    </sec:authorize>

    /*Help*/
    isc.HTMLFlow.create({
        contents: "<div id=\"mybutton\">\n" +
            "<button class=\"glow-on-hover\"><spring:message code='global.form.help'/></button>\n" +
            "</div>",
        dynamicContents: true,
        click: function () {
            fillScreenWindow_Main.show();
        }
    });
    /*Help*/
    SalesDocumentUrl = document.URL.split("?")[0].slice(-1) === "/"
        ? document.URL.split("?")[0].slice(0, -1)
        : document.URL.split("?")[0];
    const SalesConfigs = {
        Urls: {
            RootUrl: "${contextPath}",
            InvoiceExportRest: "${contextPath}" + "/rest",
            remittanceRest: "${contextPath}" + "/rest",
        },
        httpHeaders: {"Authorization": "Bearer <%= accessToken %>"},
        userFullName: '<%= SecurityUtil.getFullName()%>',
    }
    isc.FilterBuilder.addProperties({

        getValueFieldProperties: function (type, fieldName, operatorId, itemType) {

            if (this.dataSource == null)
                return {name: fieldName, type: type, filterOperator: operatorId};

            const field = this.dataSource.getField(fieldName);
            if (field == null || (field.editorType !== "SelectItem" && field.editorType !== "ComboBoxItem"))
                return {name: fieldName, type: type, filterOperator: operatorId};

            return {
                required: true,
                autoFetchData: false,
                showFilterEditor: true,
                multiple: field.multiple,
                editorType: field.editorType,
                valueField: field.valueField,
                displayField: field.displayField,
                optionDataSource: field.dataSource,
                pickListFields: [
                    {
                        title: '<spring:message code="global.id"/>',
                        hidden: true,
                        type: "number",
                        name: field.valueField
                    }, {
                        title: '<spring:message code="global.title"/>',
                        align: "left",
                        type: "string",
                        showHover: true,
                        hoverWidth: "30%",
                        name: field.displayField,
                        hoverHTML: record => record[field.displayField],
                    }
                ],
                pickListProperties: {

                    sortField: 1,
                    showFilterEditor: true,
                    sortDirection: "descending"
                }
            };
        }
    });

    function enContract() {
        var url_string = window.location.href;
        var url = new URL(url_string);
        var lang = url.searchParams.get("lang");

        if (lang == "fa" || lang == null) {
            isc.Dialog.create({
                message: "بهتر است از این تب در فرمت انگلیسی استفاده کنید",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
        }
    }


    SalesBaseParameters.deleteAllSavedParametersAndFetchAgain();

</script>
</body>
</html>
