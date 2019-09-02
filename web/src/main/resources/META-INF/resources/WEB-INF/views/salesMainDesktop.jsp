<%@ page import="com.nicico.copper.common.domain.ConstantVARs" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    final String accessToken = (String) session.getAttribute(ConstantVARs.ACCESS_TOKEN);
%>

<html>
<head>

    <title><spring:message code='main.salesName'/></title>

    <link rel="stylesheet" href="<spring:url value='/static/css/smartStyle.css' />"/>
    <link rel="shortcut icon" href="<spring:url value='/static/img/icon/nicico.ico' />"/>

    <script src="<spring:url value='/static/script/js/calendar.js'/>"></script>
    <script src="<spring:url value='/static/script/js/all.js'/>"></script>
    <script src="<spring:url value='/static/script/js/jquery.min.js' />"></script>
    <link rel="stylesheet" href="<spring:url value='/static/css/calendar.css' />"/>

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
    <script src=isomorphic/locales/frameworkMessages_fa.properties type="application/json"></script>

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

    isc.FileLoader.loadLocale("fa");
    /*---------------currentTime---------------*/
    var informationFlow;

    function calculateclockAndAssign() {
        var currentTime = new Date();
        var secs = currentTime.getSeconds();
        var mins = currentTime.getMinutes();
        var hr = currentTime.getHours();
        informationFlow.setContents("<div align='center'>ساعت : " + secs + " : " + mins + " : " + hr + "</div>");
    }

    function Delay() {
        calculateclockAndAssign();
        setTimeout('Delay()', 20);
    }

    /*-----------------------------------------*/

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
                    isc.warn("<spring:message code='exception.AccessDeniedException'/>", {title: 'هشدار'});
                    break;
                case "DataIntegrityViolation_Unique":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation_Unique'/>", {title: 'هشدار'});
                    break;
                case "DataIntegrityViolation":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation'/>", {title: 'هشدار'});
                    break;
            }
        }
    });

    isc.Dialog.SAY_TITLE = "<spring:message code='global.message'/>";
    Page.setAppImgDir("static/img/");

    isc.ListGrid.addProperties({
        dataPageSize: 500,
        showPrompt: true
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

    function getIconButton(title, props) {
        return isc.IconButton.create(isc.addProperties({
                title: title
            }, props)
        );
    }

    function createTab(title, url) {
        var localViewLoder = isc.ViewLoader.create({
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
                    pane: localViewLoder
                })
            );
    }

    var headerFlow = isc.HTMLFlow.create({
        width: "5%",
        height: "100%",
        styleName: "mainHeaderStyleOnline",
        contents: "<spring:message code='main.salesName'/>"
    });

    var label_Username = isc.Label.create({
        width: "40%",
        height: "100%",
        align: "left",
        styleName: "mainHeaderStyleOnline",
        contents: "کاربر : ${userFullName}",
        dynamicContents: true
    });

    var logoutButton = isc.IButton.create({
        width: "100",
        height: "100%",
        title: "<spring:message code='global.exit'/>",
        icon: "pieces/512/logout.png",
        click: function () {
            document.getElementById("logoutForm").submit();
        }
    });

    var headerExitHLayout = isc.HLayout.create({
        width: "10%",
        height: "30",
        align: "left",
        members: [label_Username, logoutButton]
    });


    isc.HTMLFlow.create({
        width: "20%",
        ID: "informationFlow",
        styleName: "mainHeaderStyleOnline"
    });
    var languageForm = isc.DynamicForm.create({
        width: 120,
        height: 30,
        wrapItemTitles: true,

        fields: [{
            name: "languageName", title: "<span style=\"color:white\"><spring:message code='global.language'/></span>",

            type: "select",
            width: 100,
            height: 30,
            disabled: false,
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
                var selLocale = languageForm.getValue("languageName");

                if (newUrl.indexOf("lang") > 0) {

                    var regex = new RegExp("lang=[a-zA-Z_]+");
                    newUrl = newUrl.replace(regex, "lang=" + selLocale);
                } else {

                    if (newUrl.indexOf("?") > 0) {
                        if (newUrl.indexOf("#") > 0) {
                            newUrl = newUrl.replace("#", "&lang=" + selLocale + "#")
                        } else {
                            newUrl += "&lang=" + selLocale;
                        }
                    } else {
                        //newUrl = newUrl.replace("#", "?lang=" + selLocale )
                        newUrl = newUrl + "?lang=" + selLocale;
                    }
                }

                window.location.href = newUrl;
            }
        }]
    });


    languageForm.setValue("languageName", "<c:out value='${pageContext.response.locale}'/>");
    var headerLayout = isc.HLayout.create({
        width: "100%",
        height: "30",
        //border: "1px solid red",
        backgroundColor: "#153560",
        // styleName:"mainHeaderStyleOnline",
        members: [headerFlow, languageForm, informationFlow, headerExitHLayout]
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

    /*var cartableRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });

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
    var demandReportButton = isc.IconButton.create({
        title: "<spring:message code='byDemandReports.title'/>",
        icon: "report/byDemandReports.png",
        largeIcon: "report/byDemandReports.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='material.title'/>", "/material/showForm")--%>
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
    var reportRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var reportRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='global.reports'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            routineReportButton,
            // demandReportButton,
            // coordinatingOfficeReportButton
        ],
        autoDraw: false
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

    /*--------------------Dashboard--------------------------*/
    /*var dashboardRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var dashboardRibbonGroup = isc.RibbonGroup.create({
        title: "داشبوردها",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [],
        autoDraw: false
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
        icon: "pieces/16/contact.png",
        largeIcon: "pieces/512/material.png",
        orientation: "vertical",

        click: function () {
            createTab("<spring:message code='material.title'/>", "<spring:url value="/material/showForm" />")

        }
    });

    var commercialPartyButton = isc.IconButton.create({
        title: "<spring:message code='commercialParty.title'/>",
        icon: "pieces/16/contact.png",
        largeIcon: "basicTables/commercialParty.png",
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
        icon: "basicTables/exchangeRate.png",
        largeIcon: "basicTables/exchangeRate.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='accAndDet.currency.name'/>", "/currencyUnit/showForm")--%>
            createTab("<spring:message code='exchangeRate.title'/>", "<spring:url value="/currencyRate/showForm" />")
        }
    });
    var currencyButton = isc.IconButton.create({
        title: "<spring:message code='currency.title'/>",
        icon: "basicTables/currency.png",
        largeIcon: "basicTables/currency.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='currency.title'/>", "<spring:url value="/currency/showForm" />")
        }
    });
    var commercialIncotermsButton = isc.IconButton.create({
        title: "<spring:message code='commercialIncoterms.title'/>",
        icon: "basicTables/commercialIncoterms.png",
        largeIcon: "basicTables/commercialIncoterms.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='commercialIncoterms.title'/>", "<spring:url value="/incoterms/showForm" />")
        }
    });
    var glossaryButton = isc.IconButton.create({
        title: "<spring:message code='glossary.title'/>",
        icon: "basicTables/glossary.png",
        largeIcon: "basicTables/glossary.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='glossary.title'/>", "<spring:url value="/glossary/showForm" />")
        }
    });
    var bankButton = isc.IconButton.create({
        title: "<spring:message code='bank.title'/>",
        icon: "basicTables/bank.png",
        largeIcon: "basicTables/bank.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='bank.title'/>", "<spring:url value="/bank/showForm" />")
        }
    });
    var countryButton = isc.IconButton.create({
        title: "<spring:message code='country.title'/>",
        icon: "basicTables/country.png",
        largeIcon: "basicTables/country.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='country.title'/>", "<spring:url value="/country/showForm" />")
        }
    });
    var portButton = isc.IconButton.create({
        title: "<spring:message code='port.port'/>",
        icon: "basicTables/port.png",
        largeIcon: "basicTables/port.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='port.port'/>", "<spring:url value="/port/showForm" />")
        }
    });
    var parametersButton = isc.IconButton.create({
        title: "<spring:message code='parameters.title'/>",
        icon: "basicTables/parameters.png",
        largeIcon: "basicTables/parameters.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='parameters.title'/>", "<spring:url value="/parameters/showForm" />")
        }
    });
    var personButton = isc.IconButton.create({
        title: "<spring:message code='person.title'/>",
        icon: "pieces/user.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='person.title'/>", "<spring:url value="/person/showForm" />")
        }
    });

    var groupsButton = isc.IconButton.create({
        title: "<spring:message code='groups.title'/>",
        icon: "pieces/users.png",
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
        icon: "icon/attach.png",
        largeIcon: "icon/attach.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='dcc.title'/>", "<spring:url value="/dccView/showForm" />")
        }
    });
    var instructionButton = isc.IconButton.create({
        title: "<spring:message code='instruction.title'/>",
        icon: "basicTables/instruction.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='instruction.title'/>", "<spring:url value="/instruction/showForm" />")
        }
    });
    var paymentOpftionButton = isc.IconButton.create({
        title: "<spring:message code='paymentOption.title'/>",
        icon: "basicTables/paymentOption.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='paymentOption.title'/>", "<spring:url value="/paymentOption/showForm" />")
        }
    });
    var baseRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var baseRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='global.menu.base.info'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            materialButton
            , commercialPartyButton
            , featureButton
            , unitButton
            , rateButton
            , currencyButton
            , exchangeRateButton
            , LMEButton
            , commercialIncotermsButton
            , glossaryButton
            , parametersButton
            , countryButton
            , bankButton
            , personButton
            , groupsButton
            , portButton
            , dccButton
            , instructionButton
            , paymentOpftionButton

        ],
        autoDraw: false
    });
    baseRibbonBar.addGroup(baseRibbonGroup, 0);

    var baseRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [baseRibbonBar]
    });
    /*-------------------Setting---------------------------*/
    /*var userButton = isc.IconButton.create({
        title: "کاربران",
        icon: "pieces/user.png",
        orientation: "vertical",
        click: function () {
            createTab("کاربران", "<spring:url value="/user/showForm" />")
        }
    });

    var workgroupButton = isc.IconButton.create({
        title: "<spring:message code='workgroups.title'/>",
        icon: "pieces/users.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='workgroups'/>", "<spring:url value="/group/showForm" />")
        }
    });

    var operatorsAccessButton = isc.IconButton.create({
        title: "<spring:message code='accesses.title'/>",
        icon: "operators/accesses.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='access.plural'/>", "<spring:url value="/authority/showForm" />")
        }
    });
    var organizationButton = isc.IconButton.create({
        title: "<spring:message code='organization.title'/>",
        icon: "operators/organization.png",
        largeIcon: "operators/organization.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='organization.title'/>", "<spring:url value="/department/showForm" />")

        }
    });
    var roleButton = isc.IconButton.create({
        title: "<spring:message code='role.title'/>",
        icon: "operators/roles.png",
        largeIcon: "operators/roles.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });

    var settingRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var settingRibbonGroup = isc.RibbonGroup.create({
        title: "تنظیمات",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            organizationButton
            , userButton
            , operatorsAccessButton
            , workgroupButton
            , roleButton
            /!*    IconButton_User
                ,IconButton_Group
                ,IconButton_Access
                ,departmentButton
             *!/

        ],
        autoDraw: false
    });
    settingRibbonBar.addGroup(settingRibbonGroup, 0);

    var settingRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [settingRibbonBar]
    });
    /!*-------------------license---------------------------*!/
    var boardCertificateButton = isc.IconButton.create({
        title: "<spring:message code='boardCertificate.title'/>",
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
    });
    /!*-------------------Tender---------------------------*!/
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
    var purchaseContractButton = isc.IconButton.create({
        title: "<spring:message code='purchaseContract.title'/>",
        icon: "contract/purchaseContract.png",
        largeIcon: "contract/purchaseContract.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
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
    var inspectionContractButton = isc.IconButton.create({
        title: "<spring:message code='inspectionContract.title'/>",
        icon: "contract/inspectionContract.png",
        largeIcon: "contract/inspectionContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='inspectionContract.title'/>", "<spring:url value="/inspectionContract/showForm" />")
        }
    });
    var insuranceContractButton = isc.IconButton.create({
        title: "<spring:message code='insuranceContract.title'/>",
        icon: "contract/insuranceContract.png",
        largeIcon: "contract/insuranceContract.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });

    var contractRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var contractRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='global.menu.contract.management'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            salesContractButton
            // , purchaseContractButton
            // , shipmentContractButton
            // , inspectionContractButton
            // , insuranceContractButton

        ],
        autoDraw: false
    });
    contractRibbonBar.addGroup(contractRibbonGroup, 0);

    var contractRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [contractRibbonBar]
    });
    /*-------------------Product---------------------------*/

    var warehousesButton = isc.IconButton.create({
        title: "<spring:message code='warehouses.title'/>",
        icon: "product/warehouses.png",
        largeIcon: "product/warehouses.png",
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
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
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
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var productionPlanButton = isc.IconButton.create({
        title: "<spring:message code='productionPlan.title'/>",
        icon: "product/productionPlan.png",
        largeIcon: "product/productionPlan.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var salesPlanButton = isc.IconButton.create({
        title: "<spring:message code='salesPlan.title'/>",
        icon: "product/salesPlan.png",
        largeIcon: "product/salesPlan.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
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
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var productionPlanButton = isc.IconButton.create({
        title: "<spring:message code='productionPlan.title'/>",
        icon: "product/productionPlan.png",
        largeIcon: "product/productionPlan.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });

    var productRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var productRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='global.menu.product.management'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            // warehousesButton
            , tozinButton
            , tozinSalesButton
            // , warehousesLotButton
            // , exportButton
            // , salesPlanButton
            // , purchasePlanButton
            // , deliveryPlanButton
            // , productionPlanButton
        ],
        autoDraw: false
    });
    productRibbonBar.addGroup(productRibbonGroup, 0);

    var productRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
        showResizeBar: false,
        showShadow: false,
        backgroundColor: "#153560",
        members: [productRibbonBar]
    });
    /*-------------------shipment---------------------------*/
    var cargoAssignmentButton = isc.IconButton.create({
        title: "<spring:message code='cargoAssignment.title'/>",
        icon: "shipment/cargoAssignment.png",
        largeIcon: "shipment/cargoAssignment.png",
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
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var vesselAssignmentButton = isc.IconButton.create({
        title: "<spring:message code='vesselAssignment.title'/>",
        icon: "shipment/vesselAssignment.png",
        largeIcon: "shipment/vesselAssignment.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var shipmentCostButton = isc.IconButton.create({
        title: "<spring:message code='shipmentCost.title'/>",
        icon: "shipment/shipmentCost.png",
        largeIcon: "shipment/shipmentCost.png",
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
    var shipmentRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var shipmentRibbonGroup = isc.RibbonGroup.create({
        title: "<spring:message code='global.menu.shipment.management'/>",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            cargoAssignmentButton
            // , shipmentAssignmentButton
            // , customFormalitiesButton
            , shipmentCostButton
            // , shipmentBolButton
        ],
        autoDraw: false
    });
    shipmentRibbonBar.addGroup(shipmentRibbonGroup, 0);

    var shipmentRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
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
    });
    var inspectionMoistureResultButton = isc.IconButton.create({
        title: "<spring:message code='inspectionMoistureResults.title'/>",
        icon: "inspection/inspectionResult.png",
        largeIcon: "inspection/inspectionResult.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='inspectionMoisture.title'/>", "<spring:url value="/shipmentMoisture/showForm" />")
        }
    });
    var inspectionAssayResultButton = isc.IconButton.create({
        title: "<spring:message code='inspectionAssayResults.title'/>",
        icon: "inspection/inspectionResult.png",
        largeIcon: "inspection/inspectionResult.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='inspectionAssay.title'/>", "<spring:url value="/shipmentAssay/showForm" />")
        }
    });
    var inspectionCostButton = isc.IconButton.create({
        title: "<spring:message code='inspectionCost.title'/>",
        icon: "inspection/inspectionCost.png",
        largeIcon: "inspection/inspectionCost.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });

    var inspectionRibbonBar = isc.RibbonBar.create({
        backgroundColor: "#f0f0f0",
        groupTitleAlign: "center",
        groupTitleOrientation: "top"
    });
    var inspectionRibbonGroup = isc.RibbonGroup.create({
        title: "بازرسی",
        numRows: 1,
        colWidths: [20, "*"],
        showTitle: false,
        titleAlign: "left",
        controls: [
            inspectorAppointmentButton
            , inspectionMoistureResultButton
            , inspectionAssayResultButton
            , inspectionCostButton
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
    var insurerNominationButton = isc.IconButton.create({
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
        icon: "financial/issuedInvoices.png",
        largeIcon: "financial/issuedInvoices.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
            createTab("<spring:message code='issuedInvoices.title'/>", "<spring:url value="/invoice/showForm" />")
        }
    });
    var receivedInvoicesButton = isc.IconButton.create({
        title: "<spring:message code='receivedInvoices.title'/>",
        icon: "financial/receivedInvoices.png",
        largeIcon: "financial/receivedInvoices.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });
    var financialBalanceButton = isc.IconButton.create({
        title: "<spring:message code='financialBalance.title'/>",
        icon: "financial/financialBalance.png",
        largeIcon: "financial/financialBalance.png",
        orientation: "vertical",
        click: function () {
            <%--createTab("<spring:message code='organization.title'/>", "/department/showForm")--%>
        }
    });

    var financialRibbonBar = isc.RibbonBar.create({
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
            issuedInvoicesButton
            // , receivedInvoicesButton
            // , financialBalanceButton
        ],
        autoDraw: false
    });
    financialRibbonBar.addGroup(financialRibbonGroup, 0);

    var financialRibbonHLayout = isc.HLayout.create({
        width: "100%",
        height: "60",
        // border: "0px solid green",
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
        height: "130",
        tabs: [
            <%--{title: "<spring:message code='main.cartableTab'/>", icon: "", iconSize: 16, pane: cartableRibbonHLayout},--%>
            {title: "<spring:message code='main.reportTab'/>", icon: "", iconSize: 16, pane: reportRibbonHLayout},
            <%--{title: "<spring:message code='main.dashboardTab'/>", icon: "", iconSize: 16, pane: dashboardRibbonHLayout},--%>
            {title: "<spring:message code='main.baseTab'/>", icon: "", iconSize: 16, pane: baseRibbonHLayout},
            <%--{title: "<spring:message code='main.settingTab'/>", icon: "", iconSize: 16, pane: settingRibbonHLayout},--%>
            <%--{title: "<spring:message code='main.licenseTab'/>", icon: "", iconSize: 16, pane: licenseRibbonHLayout},--%>
            <%--{title: "<spring:message code='main.tenderTab'/>", icon: "", iconSize: 16, pane: tenderRibbonHLayout},--%>
            {title: "<spring:message code='main.contractsTab'/>", icon: "", iconSize: 16, pane: contractRibbonHLayout},
            {title: "<spring:message code='main.productTab'/>", icon: "", iconSize: 16, pane: productRibbonHLayout},
            {title: "<spring:message code='main.shipmentTab'/>", icon: "", iconSize: 16, pane: shipmentRibbonHLayout},
            <%--{title: "<spring:message code='main.inspectionTab'/>",icon: "",iconSize: 16,pane: inspectionRibbonHLayout},--%>
            <%--{title: "<spring:message code='main.insuranceTab'/>", icon: "", iconSize: 16, pane: insuranceRibbonHLayout},--%>
            {title: "<spring:message code='main.financialTab'/>", icon: "", iconSize: 16, pane: financialRibbonHLayout}

        ]
    });
    isc.VLayout.create({
        width: "100%",
        height: "100%",
        // border: "0px solid blue",
        backgroundColor: "",
        members: [headerLayout, menuTabSet, mainTabSet]
    });

    // createTab("<spring:message code='workgroups'/>", "/group/showForm")
    Delay();
</script>
</body>
</html>