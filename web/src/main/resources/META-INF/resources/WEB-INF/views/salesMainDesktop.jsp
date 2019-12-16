<%@ page import="com.nicico.copper.common.domain.ConstantVARs" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% final String accessToken = (String) session.getAttribute(ConstantVARs.ACCESS_TOKEN); %>

<html>
<head>

    <title><spring:message code='main.salesName'/></title>

    <link rel="sales icon" href="<spring:url value='/static/img/icon/nicico.png' />"/>
    <link rel="stylesheet" href="<spring:url value='/static/css/smartStyle.css' />"/>
    <link rel="stylesheet" href="<spring:url value='/static/css/smartStylebutton.css' />"/>
    <link rel="stylesheet" href="<spring:url value='/static/css/calendar.css' />"/>

    <script src="<spring:url value='/static/script/js/calendar.js'/>"></script>
    <script src="<spring:url value='/static/script/js/all.js'/>"></script>
    <script src="<spring:url value='/static/script/js/convertDigitToEnglish.js'/>"></script>
    <script src="<spring:url value='/static/script/js/jquery.min.js' />"></script>

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
    <script src=isomorphic/skins/Tahoe/load_skin.js></script>
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

<script type="application/javascript">


    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

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

    BaseRPCRequest = {
        httpHeaders: {"Authorization": "Bearer <%= accessToken %>"},
        useSimpleHttp: true,
        contentType: "application/json; charset=utf-8",
        showPrompt: true,
        serverOutputAsString: false,
        willHandleError: false //centralized error handling
    };

    isc.RPCManager.addClassProperties({
        defaultPrompt: "<spring:message code='global.server.contacting'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        fetchDataPrompt: "<spring:message code='global.server.data.fetch'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        removeDataPrompt: "<spring:message code='global.server.data.remove'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        saveDataPrompt: "<spring:message code='global.server.data.save'/>&nbsp;" + "<span>" + isc.Canvas.imgHTML("[skin]/images/loadingSmall.gif", 20, 20) + "</span>",
        promptStyle: "dialog",
        allowCrossDomainCalls: true,
        handleError: function (response, request) {
            const httpResponse = JSON.parse(response.httpResponseText);
            switch (String(httpResponse.error)) {
                case "Unauthorized":
                    isc.warn("<spring:message code='exception.AccessDeniedException'/>", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    break;
                case "DataIntegrityViolation_Unique":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation_Unique'/>", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    break;
                case "DataIntegrityViolation_FK":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation_FK'/>", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    break;
                case "DataIntegrityViolation":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation_FK'/>", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
            }
        }
    });

    isc.Dialog.SAY_TITLE = "<spring:message code='global.message'/>";
    Page.setAppImgDir("static/img/");

    isc.ListGrid.addProperties({
        dataPageSize: 5,
        showPrompt: true,
        allowFilterExpressions: true,
        allowAdvancedCriteria: true
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
        border: "1px solid lightgray"
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

                if (title == mainTabSet.getTab(i).title) {
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
        height: "100%",
        width: 250,
        styleName: "mainHeaderStyleOnline",
        contents: "<spring:message code='global.user'/>" + ":" + '${userFullName}',
        dynamicContents: true
    });

    var logoutButton = isc.IButton.create({
        width: "5%",
        height: "100%",
        title: "<spring:message code='global.exit'/>",
        icon: "pieces/512/logout.png",
        click: function () {
            document.getElementById("logoutForm").submit();
        }
    });

    isc.HTMLFlow.create({
        width: "20%",
        ID: "informationFlow",
        styleName: "mainHeaderStyleOnline"
    });

    var languageForm = isc.DynamicForm.create({
        wrapItemTitles: true,
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

    if(languageForm.getValue("languageName") === 'fa') {
        isc.FileLoader.loadLocale("fa")
    } else {
        isc.FileLoader.loadLocale("en");
    }

    var emptyLabel_Before = isc.Label.create({
        width: "25%",
        height: "100%"
    });

    var emptyLabel_After = isc.Label.create({
        width: "20%",
        height: "100%"
    });

    var salesIcon = isc.Label.create({
        width: "20%",
        height: "100%",
        icon: "icon/nicico.png",
        styleName: "mainHeaderStyleOnline",
        contents: "<spring:message code='main.salesName'/>"
    });

    var headerLayout = isc.HLayout.create({
        width: "100%",
        height: 35,
        backgroundColor: "#153560",
        members: [salesIcon, emptyLabel_Before, emptyLabel_After, label_Username, languageForm, logoutButton]
    });

    /*-------------------Cartable---------------------------*/
    var cartableHomeButton = isc.IconButton.create({
        title: "<spring:message code='mainCartable.title'/>",
        icon: "cartable/cartableHome.png",
        largeIcon: "cartable/cartableHome.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='material.title'/>", "/material/showForm")--%>
        }
    });
    var cartableReplaceButton = isc.IconButton.create({
        title: "<spring:message code='secondCartable.title'/>",
        icon: "cartable/cartableReplace.png",
        largeIcon: "cartable/cartableReplace.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='material.title'/>", "/material/showForm")--%>
        }
    });
    var cartableInboxButton = isc.IconButton.create({
        title: "<spring:message code='inbox.title'/>",
        icon: "cartable/inbox.png",
        largeIcon: "cartable/inbox.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='material.title'/>", "/material/showForm")--%>
        }
    });
    var cartableOutboxButton = isc.IconButton.create({
        title: "<spring:message code='outbox.title'/>",
        icon: "cartable/outbox.png",
        largeIcon: "cartable/outbox.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='material.title'/>", "/material/showForm")--%>
        }
    });
    var processButton = isc.IconButton.create({
        title: "<spring:message code='process.title'/>",
        icon: "cartable/process.png",
        largeIcon: "cartable/process.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='global.process.file'/>", "<spring:url value="/web/workflow/processDefinition/showForm" />")
        }
    });

    /*------------------- Cartable ---------------------------
    var cartableRibbonGroup = isc.RibbonGroup.create({
        title: "مدیریت کارتابل",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            cartableHomeButton
            , cartableReplaceButton
            , cartableInboxButton
            , cartableOutboxButton
            , processButton
        ],
        autoDraw: false
    });
    var cartableRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    cartableRibbonBar.addGroup(cartableRibbonGroup, 0);

    var cartableRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [cartableRibbonBar]
    });*/

    /*-------------------Report---------------------------*/
    var routineReportButton = isc.IconButton.create({
        title: "<spring:message code='reportGenerator.title'/>",
        icon: "report/routineReports.png",
        largeIcon: "report/routineReports.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='global.report.generator.contract'/>", "<spring:url value="/contractIncomeCost/showForm" />")
        }
    });
    var coordinatingOfficeReportButton = isc.IconButton.create({
        title: "<spring:message code='coordinatingOfficeReportButton.title'/>",
        icon: "report/routineReports.png",
        largeIcon: "report/routineReports.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='dailyReport.DailyReportBandarAbbas'/>", "<spring:url value="/dailyReportBandarAbbas/showForm" />")
        }
    });
    var demandReportButton = isc.IconButton.create({
        title: "<spring:message code='byDemandReports.title'/>",
        icon: "report/byDemandReports.png",
        largeIcon: "report/byDemandReports.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='material.title'/>", "/material/showForm")--%>
        }
    });

    var reportRibbonGroup = isc.RibbonGroup.create({
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        controls: [
            routineReportButton//,
            // coordinatingOfficeReportButton
            // demandReportButton
        ],
        autoDraw: false
    });

    var reportRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    reportRibbonBar.addGroup(reportRibbonGroup, 0);

    var reportRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [reportRibbonBar]
    });

    /*--------------------Dashboard--------------------------
    var dashboardRibbonGroup = isc.RibbonGroup.create({
        title: "داشبوردها",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [],
        autoDraw: false
    });
    var dashboardRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    dashboardRibbonBar.addGroup(dashboardRibbonGroup, 0);

    var dashboardRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [dashboardRibbonBar]
    });*/

    /*----------------------Base------------------------*/

    var materialButton = isc.IconButton.create({
        title: "<spring:message code='material.title'/>",
        icon: "basicTables/package.png",
        largeIcon: "basicTables/package.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='material.title'/>", "<spring:url value="/material/showForm" />")

        }
    });

    var commercialPartyButton = isc.IconButton.create({
        title: "<spring:message code='commercialParty.title'/>",
        icon: "basicTables/promote.png",
        largeIcon: "basicTables/promote.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='commercialParty.title'/>", "<spring:url value="/contact/showForm" />")

        }
    });
    var unitButton = isc.IconButton.create({
        title: "<spring:message code='unit.title'/>",
        icon: "basicTables/unit.png",
        largeIcon: "basicTables/unit.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='unit.title'/>", "<spring:url value="/unit/showForm" />")
        }
    });
    var rateButton = isc.IconButton.create({
        title: "<spring:message code='rate.title'/>",
        icon: "basicTables/rate.png",
        largeIcon: "basicTables/rate.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='rate.title'/>", "<spring:url value="/rate/showForm" />")
        }
    });
    var featureButton = isc.IconButton.create({
        title: "<spring:message code='feature.title'/>",
        icon: "basicTables/feature.png",
        largeIcon: "basicTables/feature.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='feature.title'/>", "<spring:url value="/feature/showForm" />")
        }
    });
    var exchangeRateButton = isc.IconButton.create({
        title: "<spring:message code='exchangeRate.title'/>",
        icon: "basicTables/exchange-rate_new.png",
        largeIcon: "basicTables/exchange-rate_new.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='exchangeRate.title'/>", "<spring:url value="/currencyRate/showForm" />")
        }
    });
    var currencyButton = isc.IconButton.create({
        title: "<spring:message code='currency.title'/>",
        icon: "basicTables/money.png",
        largeIcon: "basicTables/money.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='currency.title'/>", "<spring:url value="/currency/showForm" />")
        }
    });
    var commercialIncotermsButton = isc.IconButton.create({
        title: "<spring:message code='commercialIncoterms.title'/>",
        icon: "basicTables/oceanic.png",
        largeIcon: "basicTables/oceanic.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='commercialIncoterms.title'/>", "<spring:url value="/incoterms/showForm" />")
        }
    });
    var glossaryButton = isc.IconButton.create({
        title: "<spring:message code='glossary.title'/>",
        icon: "basicTables/Glossary_new.png",
        largeIcon: "basicTables/Glossary_new.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='glossary.title'/>", "<spring:url value="/glossary/showForm" />")
        }
    });
    var bankButton = isc.IconButton.create({
        title: "<spring:message code='bank.title'/>",
        icon: "basicTables/bank_new.png",
        largeIcon: "basicTables/bank_new.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='bank.title'/>", "<spring:url value="/bank/showForm" />")
        }
    });

    var warehouseYardButton = isc.IconButton.create({
        title: "<spring:message code='warehouseCad.yard'/>",
        icon: "basicTables/warehouse.png",
        largeIcon: "basicTables/warehouse.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='warehouseCad.yard'/>", "<spring:url value="/warehouseYard/showForm" />")
        }
    });

    var countryButton = isc.IconButton.create({
        title: "<spring:message code='country.title'/>",
        icon: "basicTables/globe.png",
        largeIcon: "basicTables/globe.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='country.title'/>", "<spring:url value="/country/showForm" />")
        }
    });
    var portButton = isc.IconButton.create({
        title: "<spring:message code='port.port'/>",
        icon: "basicTables/port_ne.png",
        largeIcon: "basicTables/port_ne.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='port.port'/>", "<spring:url value="/port/showForm" />")
        }
    });
    var parametersButton = isc.IconButton.create({
        title: "<spring:message code='parameters.title'/>",
        icon: "basicTables/contract_new.png",
        largeIcon: "basicTables/contract_new.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='parameters.title'/>", "<spring:url value="/parameters/showForm" />")
        }
    });
    var personButton = isc.IconButton.create({
        title: "<spring:message code='person.title'/>",
        icon: "basicTables/man.png",
        largeIcon: "basicTables/man.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='person.title'/>", "<spring:url value="/person/showForm" />")
        }
    });

    var groupsButton = isc.IconButton.create({
        title: "<spring:message code='groups.title'/>",
        icon: "basicTables/group-email-person.png",
        largeIcon: "basicTables/group-email-person.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='groups.title'/>", "<spring:url value="/groups/showForm" />")
        }
    });
    var LMEButton = isc.IconButton.create({
        title: "<spring:message code='LME.title'/>",
        icon: "basicTables/LME.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='LME.title'/>", "<spring:url value="/LME/showForm" />")
        }
    });
    var dccButton = isc.IconButton.create({
        title: "<spring:message code='dcc.title'/>",
        icon: "basicTables/attach.png",
        largeIcon: "basicTables/attach.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='dcc.title'/>", "<spring:url value="/dccView/showForm" />")
        }
    });
    var instructionButton = isc.IconButton.create({
        title: "<spring:message code='instruction.title'/>",
        icon: "basicTables/instructions.png",
        largeIcon: "basicTables/instructions.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='instruction.title'/>", "<spring:url value="/instruction/showForm" />")
        }
    });
    var paymentOpftionButton = isc.IconButton.create({
        title: "<spring:message code='paymentOption.title'/>",
        icon: "basicTables/payment.png",
        largeIcon: "basicTables/payment.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='paymentOption.title'/>", "<spring:url value="/paymentOption/showForm" />")
        }
    });
    var baseRibbonGroup = isc.RibbonGroup.create({
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        controls: [
            materialButton,
            commercialPartyButton,
            featureButton,
            unitButton,
            rateButton,
            currencyButton,
            exchangeRateButton,
            LMEButton,
            commercialIncotermsButton,
            glossaryButton,
            parametersButton,
            countryButton,
            bankButton,
            personButton,
            groupsButton,
            portButton,
            dccButton,
            instructionButton,
            paymentOpftionButton,
            warehouseYardButton
        ],
        autoDraw: false
    });
    var baseRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    baseRibbonBar.addGroup(baseRibbonGroup, 0);

    var baseRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [baseRibbonBar]
    });
    /*-------------------Setting---------------------------*/
    var userRoleButton = isc.IconButton.create({
        orientation: "vertical",
        icon: "pieces/512/unauthorized-person.png",
        largeIcon: "pieces/512/unauthorized-person.png",
        title: "<spring:message code='setting.appRoles'/>",
        click: function () {
            createTab("<spring:message code='setting.appRoles'/>", "<spring:url value="web/oauth/app-roles/show-form" />", false);
        }
    });
    var userGroupPermissionButton = isc.IconButton.create({
        orientation: "vertical",
        icon: "pieces/512/profile.png",
        largeIcon: "pieces/512/profile.png",
        title: "<spring:message code='setting.groupPermission'/>",
        click: function () {
            createTab("<spring:message code='setting.groupPermission'/>", "<spring:url value="web/oauth/groups/show-form" />", false);
        }

    });



    var userAssignUserButton = isc.IconButton.create({
        orientation: "vertical",
        icon: "pieces/512/user.png",
        largeIcon: "pieces/512/user.png",
        title: "<spring:message code='setting.roleUser'/>",
        click: function () {
            createTab("<spring:message code='setting.roleUser'/>", "<spring:url value="web/oauth/users/show-form" />", false);
        }
    });


    var settingRibbonGroup = isc.RibbonGroup.create({
        title: "تنظیمات",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            userGroupPermissionButton,
            userRoleButton,
            userAssignUserButton
        ],
        autoDraw: false
    });
    var settingRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    settingRibbonBar.addGroup(settingRibbonGroup, 0);

    var settingRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [settingRibbonBar]
    });

    /*-------------------license---------------------------
    var boardCertificateButton = isc.IconButton.create({
        <%--title: "<spring:message code='boardCertificate.title'/>",--%>
        icon: "license/boardCertificate.png",
        largeIcon: "license/boardCertificate.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var exportLicenseButton = isc.IconButton.create({
        title: "<spring:message code='exportLicense.title'/>",
        icon: "license/exportLicense.png",
        largeIcon: "license/exportLicense.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var importLicenseButton = isc.IconButton.create({
        title: "<spring:message code='importLicense.title'/>",
        icon: "license/importLicense.png",
        largeIcon: "license/importLicense.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var licenseRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var licenseRibbonGroup = isc.RibbonGroup.create({
        title: "مديريت مجوز",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            boardCertificateButton
            , exportLicenseButton
            , importLicenseButton
        ],
        autoDraw: false
    });
    licenseRibbonBar.addGroup(licenseRibbonGroup, 0);

    var licenseRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [licenseRibbonBar]
    });*/

    /*-------------------Tender---------------------------
    var tenderButton = isc.IconButton.create({
        title: "<spring:message code='tenderNotice.title'/>",
        icon: "tender/tenderNotice.png",
        largeIcon: "tender/tenderNotice.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='tenderNotice.title'/>", "<spring:url value="/shipmentInquiry/showForm" />")
        }
    });
    var evaluationResultButton = isc.IconButton.create({
        title: "<spring:message code='evaluationResult.title'/>",
        icon: "tender/evaluationResult.png",
        largeIcon: "tender/evaluationResult.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='evaluationResult.title'/>", "<spring:url value="/shipmentPrice/showForm" />")
        }
    });

    var tenderRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var tenderRibbonGroup = isc.RibbonGroup.create({
        title: "مديريت مناقصه/مزايده",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            tenderButton, evaluationResultButton

        ],
        autoDraw: false
    });
    tenderRibbonBar.addGroup(tenderRibbonGroup, 0);

    var tenderRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [tenderRibbonBar]
    });*/

    /*-------------------Contracts---------------------------*/
    var salesContractButton = isc.IconButton.create({
        title: "<spring:message code='salesContract.title'/>",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='salesContract.title'/>", "<spring:url value="/contract/showForm" />")
        }
    });


    var salesContractMoButton = isc.IconButton.create({
        title: "<spring:message code='salesContractMoButton.title'/>",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='salesContractMoButton.title'/>", "<spring:url value="/contact/contactMolybdenum"/>")
        }
    });
    var salesContractCADButton = isc.IconButton.create({
        title: "<spring:message code='salesContractCADButton.title'/>",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='main.contractsCadTab'/>", "<spring:url value="/contact/cadMain"/>")
        }
    });
    var salesContractConcButton = isc.IconButton.create({
        title: "<spring:message code='salesContractConcButton.title'/>",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='main.contractsConcTab'/>", "<spring:url value="/contact/concMain"/>")
        }
    });
    var purchaseContractButton = isc.IconButton.create({
        title: "<spring:message code='purchaseContract.title'/>",
        icon: "contract/purchaseContract.png",
        largeIcon: "contract/purchaseContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "/department/showForm")
        }
    });
    var shipmentContractButton = isc.IconButton.create({
        title: "<spring:message code='shipmentContract.title'/>",
        icon: "contract/shipmentContract.png",
        largeIcon: "contract/shipmentContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='shipmentContract.title'/>", "<spring:url value="/shipmentContract/showForm" />")
        }
    });

    /*Add Jz*/
    var inspectionContractButton = isc.IconButton.create({
        title: "<spring:message code='inspectionContract.title'/>",
        icon: "contract/inspectionContract.png",
        largeIcon: "contract/inspectionContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='inspectionContract.title'/>", "<spring:url value="/inspectionContract/showForm" />")
        }
    });


    /*Add Jz*/
    var CharterButton = isc.IconButton.create({
        title: "<spring:message code='charter.title'/>",
        icon: "contract/sea.png",
        largeIcon: "contract/sea.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='charter.title'/>", "<spring:url value="/shipmentContract/showForm" />")
        }
    });



    var insuranceContractButton = isc.IconButton.create({
        title: "<spring:message code='insuranceContract.title'/>",
        icon: "contract/insuranceContract.png",
        largeIcon: "contract/insuranceContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "/department/showForm")
        }
    });

    var contractRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='global.menu.contract.management'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            isc.HLayout.create({align: "left", members: [salesContractButton , inspectionContractButton /*, CharterButton*/ ]})
            // , purchaseContractButton
            // , shipmentContractButton
            // , inspectionContractButton
            // , insuranceContractButton

        ],
        autoDraw: false
    });

    var contractRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });

    contractRibbonBar.addGroup(contractRibbonGroup, 0);

    var contractRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [contractRibbonBar]
    });

    /*-------------------Product---------------------------*/
    var warehousesButton = isc.IconButton.create({
        title: "<spring:message code='warehouses.title'/>",
        icon: "product/warehouse.png",
        largeIcon: "product/warehouse.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='warehouses.title'/>", "<spring:url value="/dailyWarehouse/showForm" />")
        }
    });
    var tozinButton = isc.IconButton.create({
        title: "<spring:message code='tozin.title'/>",
        icon: "product/forklift.png",
        largeIcon: "product/forklift.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='tozin.title'/>", "<spring:url value="/tozin/showForm" />")
        }
    });
    var OnWayProductButton = isc.IconButton.create({
        title: "<spring:message code='tozin.onWay'/>",
        icon: "product/deliveryPlan.png",
        largeIcon: "product/deliveryPlan.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='tozin.onWay'/>", "<spring:url value="/tozin/showOnWayProductForm" />")
        }
    });
    var tozinSalesButton = isc.IconButton.create({
        title: "<spring:message code='tozinSales.title'/>",
        icon: "product/tozin.png",
        largeIcon: "product/tozin.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='tozinSales.title'/>", "<spring:url value="/tozinSales/showForm" />")
        }
    });
    var warehousesLotButton = isc.IconButton.create({
        title: "<spring:message code='molybdenum.title'/>",
        icon: "product/molybdenum.png",
        largeIcon: "product/molybdenum.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='molybdenum.title'/>", "<spring:url value="/warehouseLot/showForm" />")
        }
    });
    var BijackButton = isc.IconButton.create({
        title: "<spring:message code='bijack'/>",
        icon: "product/havale.png",
        largeIcon: "product/havale.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='bijack'/>", "<spring:url value="/warehouseCad/showForm" />")
        }
    });
    var WarehouseStockButton = isc.IconButton.create({
        title: "<spring:message code='warehouseStock'/>",
        icon: "product/havale.png",
        largeIcon: "product/havale.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='warehouseStock'/>", "<spring:url value="/warehouseStock/showForm" />")
        }
    });
    var WarehouseIssueCathodeButton = isc.IconButton.create({
        title: "<spring:message code='Shipment.titleWarehouseIssueCathode'/>",
        icon: "product/havale.png",
        largeIcon: "product/havale.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='Shipment.titleWarehouseIssueCathode'/>", "<spring:url value="/warehouseIssueCathode/showForm" />")
        }
    });
    var WarehouseIssueConsButton = isc.IconButton.create({
        title: "<spring:message code='Shipment.titleWarehouseIssueCons'/>",
        icon: "product/havale.png",
        largeIcon: "product/havale.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='Shipment.titleWarehouseIssueCons'/>", "<spring:url value="/warehouseIssueCons/showForm" />")
        }
    });
    var WarehouseIssueMoButton = isc.IconButton.create({
        title: "<spring:message code='Shipment.titleWarehouseIssueMo'/>",
        icon: "product/inbox.png",
        largeIcon: "product/inbox.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='Shipment.titleWarehouseIssueMo'/>", "<spring:url value="/warehouseIssueMo/showForm" />")
        }
    });
    var exportButton = isc.IconButton.create({
        title: "<spring:message code='export.title'/>",
        icon: "license/exportLicense.png",
        largeIcon: "license/exportLicense.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='export.title'/>", "<spring:url value="/export/showForm" />")
        }
    });
    var salesPlanButton = isc.IconButton.create({
        title: "<spring:message code='salesPlan.title'/>",
        icon: "product/salesPlan.png",
        largeIcon: "product/salesPlan.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "/department/showForm")
        }
    });
    var purchasePlanButton = isc.IconButton.create({
        title: "<spring:message code='purchasePlan.title'/>",
        icon: "product/purchasePlan.png",
        largeIcon: "product/purchasePlan.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var deliveryPlanButton = isc.IconButton.create({
        title: "<spring:message code='deliveryPlan.title'/>",
        icon: "product/deliveryPlan.png",
        largeIcon: "product/deliveryPlan.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "/department/showForm")
        }
    });
    var productionPlanButton = isc.IconButton.create({
        title: "<spring:message code='productionPlan.title'/>",
        icon: "product/productionPlan.png",
        largeIcon: "product/productionPlan.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "/department/showForm")
        }
    });

    var productRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='global.menu.product.management'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            // warehousesButton,
            tozinButton,
            OnWayProductButton,
            tozinSalesButton,
            warehousesLotButton,
            BijackButton,
            WarehouseStockButton,
            WarehouseIssueCathodeButton,
            WarehouseIssueConsButton,
            WarehouseIssueMoButton
            // exportButton,
            // salesPlanButton,
            // purchasePlanButton,
            // deliveryPlanButton,
            // productionPlanButton
        ],
        autoDraw: false
    });
    var productRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    productRibbonBar.addGroup(productRibbonGroup, 0);

    var productRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [productRibbonBar]
    });
    /*-------------------shipment---------------------------*/
    var cargoAssignmentButton = isc.IconButton.create({
        title: "<spring:message code='cargoAssignment.title'/>",
        icon: "basicTables/port_new.png",
        largeIcon: "basicTables/port_new.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='cargoAssignment.title'/>", "<spring:url value="/shipment/showForm" />")

        }
    });
    var shipmentAssignmentButton = isc.IconButton.create({
        title: "<spring:message code='shipmentAssignment.title'/>",
        icon: "shipment/shipmentAssignment.png",
        largeIcon: "shipment/shipmentAssignment.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='shipmentAssignment.title'/>", "<spring:url value="/shipmentResource/showForm" />")
        }
    });
    var customFormalitiesButton = isc.IconButton.create({
        title: "<spring:message code='customsFormalities.title'/>",
        icon: "shipment/customFormalities.png",
        largeIcon: "shipment/customFormalities.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "/department/showForm")
        }
    });
    var vesselAssignmentButton = isc.IconButton.create({
        title: "<spring:message code='vesselAssignment.title'/>",
        icon: "shipment/vesselAssignment.png",
        largeIcon: "shipment/vesselAssignment.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "/department/showForm")
        }
    });
    var shipmentCostButton = isc.IconButton.create({
        title: "<spring:message code='shipmentCost.title'/>",
        icon: "shipment/shipping.png",
        largeIcon: "shipment/shipping.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='shipmentCost.title'/>", "<spring:url value="/cost/showForm" />")
        }
    });
    var shipmentBolButton = isc.IconButton.create({
        title: "<spring:message code='bol.title'/>",
        icon: "shipment/bol.jpg",
        largeIcon: "shipment/bol.jpg",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='bol.title'/>", "<spring:url value="/bol/showForm" />")

        }
    });
    var shipmentRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='global.menu.shipment.management'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            cargoAssignmentButton,
            // shipmentAssignmentButton,
            // customFormalitiesButton,
            shipmentCostButton
            // shipmentBolButton
        ],
        autoDraw: false
    });
    var shipmentRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    shipmentRibbonBar.addGroup(shipmentRibbonGroup, 0);

    var shipmentRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [shipmentRibbonBar]
    });
    /*-------------------inspection---------------------------*/
    /*var inspectorAppointmentButton = isc.IconButton.create({
        title: "<spring:message code='inspectorAppointment.title'/>",
        icon: "inspection/inspectorAppointment.png",
        largeIcon: "inspection/inspectorAppointment.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });*/



    /*InspectionContract*/
    var inspectionMoistureResultButton = isc.IconButton.create({
        title: "<spring:message code='inspectionMoistureResults.title'/>",
        icon: "inspection/",
        largeIcon: "inspection/detective.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='inspectionMoisture.title'/>", "<spring:url value="/shipmentMoisture/showForm" />")
        }
    });

/*JZ*/
    var inspectionContractResultButton = isc.IconButton.create({
        title: "<spring:message code='inspection.contract.form'/>",
        icon: "inspection/inspectionContract.png",
        largeIcon: "inspection/inspectionContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='inspection.contract.form'/>", "<spring:url value="/inspectionContract/showForm" />")
        }
    });





    <%--var inspectionAssayResultButton = isc.IconButton.create({--%>
    <%--    title: "<spring:message code='inspectionAssayResults.title'/>",--%>
    <%--    icon: "inspection/inspectionResult.png",--%>
    <%--    largeIcon: "inspection/inspectionResult.png",--%>
    <%--    orientation: "vertical",--%>
    <%--    click: function () {--%>
    <%--        createTab("<spring:message code='inspectionAssay.title'/>", "<spring:url value="/shipmentAssay/showForm" />" )--%>
    <%--    }--%>
    <%--});--%>


    var inspectionAssayResultButton = isc.IconButton.create({
        title: "<spring:message code='inspectionAssayResults.title'/>",
        icon: "inspection/detective.png",
        largeIcon: "inspection/detective.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='inspectionAssay.title'/>", "<spring:url value="/shipmentAssay/showForm" />" )
        }
    });
    <%--/*--%>
    <%--var inspectionCostButton = isc.IconButton.create({--%>
    <%--    title: "<spring:message code='inspectionCost.title'/>",--%>
    <%--    icon: "inspection/inspectionCost.png",--%>
    <%--    largeIcon: "inspection/inspectionCost.png",--%>
    <%--    orientation: "vertical",--%>
    <%--    click: function () {--%>
    <%--        &lt;%&ndash;createTab("<spring:message code='organization.title'/>", "/department/showForm")&ndash;%&gt;--%>
    <%--    }--%>
    <%--});*/--%>

    var inspectionRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var inspectionRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='inspection.title'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            // inspectorAppointmentButton
            inspectionMoistureResultButton
            , inspectionAssayResultButton ,


            // , inspectionCostButton
        ],
        autoDraw: false
    });
    inspectionRibbonBar.addGroup(inspectionRibbonGroup, 0);

    var inspectionRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [inspectionRibbonBar]
    });
    /!*-------------------insurance---------------------------*!/
    /*   var insurerNominationButton = isc.IconButton.create({
           title: "<spring:message code='insurerNomination.title'/>",
        icon: "insurance/insurerNomination.png",
        largeIcon: "insurance/insurerNomination.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var insuranceInstructionButton = isc.IconButton.create({
        title: "<spring:message code='insuranceInstruction.title'/>",
        icon: "insurance/insuranceInstruction.png",
        largeIcon: "insurance/insuranceInstruction.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var insuranceCertificateButton = isc.IconButton.create({
        title: "<spring:message code='insuranceCertificate.title'/>",
        icon: "insurance/insuranceCertificate.png",
        largeIcon: "insurance/insuranceCertificate.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var certificateDeliveryButton = isc.IconButton.create({
        title: "<spring:message code='certificateDelivery.title'/>",
        icon: "insurance/certificateDelivery.png",
        largeIcon: "insurance/certificateDelivery.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var paymentProcedureButton = isc.IconButton.create({
        title: "<spring:message code='paymentProcedure.title'/>",
        icon: "insurance/paymentProcedure.png",
        largeIcon: "insurance/paymentProcedure.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });

    var insuranceRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var insuranceRibbonGroup = isc.RibbonGroup.create({
        title: "بیمه",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            insurerNominationButton
            , insuranceInstructionButton
            , insuranceCertificateButton
            , certificateDeliveryButton
            , paymentProcedureButton
        ],
        autoDraw: false
    });
    insuranceRibbonBar.addGroup(insuranceRibbonGroup, 0);

    var insuranceRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [insuranceRibbonBar]
    });*/
    /*-------------------financial---------------------------*/
    var issuedInvoicesButton = isc.IconButton.create({
        title: "<spring:message code='issuedInvoices.title'/>",
        icon: "financial/F-out.png",
        largeIcon: "financial/F-out.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='issuedInvoices.title'/>", "<spring:url value="/invoice/showForm" />")
        }
    });
    var issuedInvoiceInternalButton = isc.IconButton.create({
        title: "<spring:message code='issuedInternalInvoices.title'/>",
        icon: "financial/F-IR.png",
        largeIcon: "financial/F-IR.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='issuedInternalInvoices.title'/>", "<spring:url value="/invoiceInternal/showForm" />")
        }
    });
    var receivedInvoicesButton = isc.IconButton.create({
        title: "<spring:message code='receivedInvoices.title'/>",
        icon: "financial/receivedInvoices.png",
        largeIcon: "financial/receivedInvoices.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "/department/showForm")
        }
    });
    var financialBalanceButton = isc.IconButton.create({
        title: "<spring:message code='financialBalance.title'/>",
        icon: "financial/financialBalance.png",
        largeIcon: "financial/financialBalance.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "/department/showForm")
        }
    });

   /* var issuedInvoicesButtonContract = isc.IconButton.create({
        title: "<spring:message code='main.contractsTab'/>",
        icon: "financial/issuedInvoices.png",
        largeIcon: "financial/issuedInvoices.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='main.contractsTab'/>", "<spring:url value="/contact/showFormContractNew"/>")
        }
    });*/

    var financialRibbonBarContract = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });

    var financialRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='global.menu.financial'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            issuedInvoicesButton,
            issuedInvoiceInternalButton
            // receivedInvoicesButton,
            // financialBalanceButton
        ],
        autoDraw: false
    });
    var financialRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    financialRibbonBar.addGroup(financialRibbonGroup, 0);

    /*var financialRibbonGroupContract = isc.RibbonGroup.create({
        title: "<spring:message code='global.menu.test'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            issuedInvoicesButtonContract
        ],
        autoDraw: false
    });*/


   /* var financialRibbonHLayoutContract = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [financialRibbonBarContract]
    });*/

  /*  financialRibbonBarContract.addGroup(financialRibbonGroupContract, 0);*/


    var financialRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [financialRibbonBar]
    });

    //---------------------------------------
    var mainTabSet = isc.TabSet.create({
        tabBarPosition: "top",
        width: "100%",
        height: "100%",
        tabs: [],
        tabBarControls: [
            isc.IButton.create({
                title: "<spring:message code='global.close.tabs'/>",
                icon: "icon/closeAllTabs.png",
                width: 100, height: 20,
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

    isc.TabSet.create({
        ID: "menuTabSet",
        tabBarPosition: "top",
        width: "100%",
        height: "18%",
        tabs: [
            <%--{title: "<spring:message code='main.cartableTab'/>", pane: cartableRibbonHLayout},--%>
            {title: "<spring:message code='main.reportTab'/>", pane: reportRibbonHLayout},
            <%--{title: "<spring:message code='main.dashboardTab'/>",  pane: dashboardRibbonHLayout},--%>
            {title: "<spring:message code='main.baseTab'/>", pane: baseRibbonHLayout},
            {title: "<spring:message code='main.settingTab'/>", pane: settingRibbonHLayout},
            <%--{title: "<spring:message code='main.licenseTab'/>", pane: licenseRibbonHLayout},--%>
            <%--{title: "<spring:message code='main.tenderTab'/>", pane: tenderRibbonHLayout},--%>
            {title: "<spring:message code='main.contractsTab'/>", pane: contractRibbonHLayout},
            {title: "<spring:message code='main.productTab'/>", pane: productRibbonHLayout},
            {title: "<spring:message code='main.shipmentTab'/>", pane: shipmentRibbonHLayout},
            {title: "<spring:message code='main.inspectionTab'/>", pane: inspectionRibbonHLayout},
            <%--{title: "<spring:message code='main.insuranceTab'/>", pane: insuranceRibbonHLayout},--%>
            {title: "<spring:message code='main.financialTab'/>", pane: financialRibbonHLayout}
           /* {title: "<spring:message code='main.contractsTabNew'/>", pane: financialRibbonHLayoutContract}*/
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        backgroundColor: "",
        members: [headerLayout, menuTabSet, mainTabSet]
    });

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


</script>
</body>
</html>