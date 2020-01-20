<%@ page import="com.nicico.copper.common.domain.ConstantVARs" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% final String accessToken = (String) session.getAttribute(ConstantVARs.ACCESS_TOKEN); %>

<html>
<head>

    <title><spring:message code='main.Tab.Name'/></title>

    <link rel="sales icon" href="<spring:url value='/static/img/icon/nicico.png' />"/>
    <link rel="stylesheet" href="<spring:url value='/static/css/smartStyle.css' />"/>
    <link rel="stylesheet" href="<spring:url value='/static/css/smartStylebutton.css' />"/>
    <link rel="stylesheet" href="<spring:url value='/static/css/calendar.css' />"/>

    <link rel="stylesheet" href='<spring:url value="/static/css/commonStyle.css"/>'/>

    <script src="<spring:url value='/static/script/js/calendar.js'/>"></script>
    <script src="<spring:url value='/static/script/js/all.js'/>"></script>
    <script src="<spring:url value='/static/script/js/convertDigitToEnglish.js'/>"></script>
    <script src="<spring:url value='/static/script/js/moment.js'/>"></script>
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

<script type="application/javascript">


    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    isc.DynamicForm.addProperties({requiredTitlePrefix: "<span style='color:#ff0842;font-size:15px; padding-left: 5px;'>*</span>",});

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

    isc.SelectItem.addProperties ({
            click:function(){
                this.pickList.invalidateCache();
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
             if(response.error=='invalid_token')
		        isc.warn(response.data);
                console.log("Global RPCManager Error Handler: ", request, response);
                if (response.httpResponseCode === 401) { // Unauthorized
                    redirectLogin();
                } else if (response.httpResponseCode === 403) { // Forbidden
                    nicico.error("Access Denied"); //TODO: I18N message key
                }else if (response.httpResponseCode === 500){
                    isc.say(JSON.parse(response.httpResponseText).exception);
                }else if (response.httpResponseCode ===405){
                    isc.say(JSON.parse(response.httpResponseText).exception);
                }
            const httpResponse = JSON.parse(response.httpResponseText);
            switch (String(httpResponse.error)) {
                case "Unauthorized":
                    isc.warn("<spring:message code='exception.AccessDeniedException'/>", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
                case "DataIntegrityViolation_Unique":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation_Unique'/>", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    break;
                case "DataIntegrityViolation_FK":
                    isc.warn("<spring:message code='exception.DataIntegrityViolation_FK'/>", {title: "<spring:message code='dialog_WarnTitle'/>"});
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
        allowAdvancedCriteria: true,
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

    isc.ViewLoader.addMethods({
		handleError: function (rq, rs) {
			console.log("Global ViewLoader Error: ", rq, rs);
			if (rs.httpResponseCode === 403) { // Forbidden
				nicico.error("Access Denied");  //TODO: I18N message key
			} else {
				redirectLogin();
			}
			return false;
		}
	});

        var flagTabExist = false;

        if (mainTabSet.tabs != null) {
            for (i = 0; i < mainTabSet.tabs.length; i++) {

                if (title === mainTabSet.getTab(i).title) {
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

        width: 100,
        dynamicContents: true,
        styleName: "header-label-username",
        contents: "<spring:message code='global.user'/>" + ":" + '${userFullName}',
    });

    logoutButton = isc.IButton.create({

        width: "100",
        baseStyle: "header-logout",
        title: "<spring:message code='global.exit'/>",
        icon: "pieces/512/logout.png",
        click: function () {
            document.getElementById("logoutForm").submit();
        }
    });

    var languageForm = isc.DynamicForm.create({
        wrapItemTitles: true,
        width: 120,
        //height: "100%",
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

    if (languageForm.getValue("languageName") === 'fa') {
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

    var userNameHLayout = isc.HLayout.create({
        width: "10%",
        align: "center",
        members: [label_Username]
    });

    var logoutVLayout = isc.VLayout.create({
        width: "5%",
        align: "center",
        defaultLayoutAlign: "left",
        members: [logoutButton]
    });

    var headerExitHLayout = isc.HLayout.create({
        width: "60%",
        height: "100%",
        align: "center",
        styleName: "header-exit",
        members: [isc.LayoutSpacer.create({width: "80%"}), userNameHLayout, languageVLayout, logoutVLayout]
    });

    var headerLogo = isc.HTMLFlow.create({
        width: "50",
        height: "100%",
        styleName: "header-logo",
        contents: "<img width='50' height='50' src='static/img/logo03.png'/>"
    });

    var headerFlow = isc.HTMLFlow.create({
        width: "10%",
        height: "100%",
        styleName: "mainHeaderStyleOnline header-logo-title",
        contents: "<span><spring:message code='main.salesName'/></span>"
    });

    var headerLayout = isc.HLayout.create({

        width: "100%",
        height: "52",
        styleName: "header",
        members: [headerLogo, headerFlow, headerExitHLayout],
    });

    /*----------------------baseTab------------------------*/
    baseTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.baseTab'/>",
        menu: isc.Menu.create({
            data: [
                {
                    title: "<spring:message code='material.title'/>",
                    click: function () {
                        createTab("<spring:message code='material.title'/>", "<spring:url value="/material/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='commercialParty.title'/>",
                    click: function () {
                        createTab("<spring:message code='commercialParty.title'/>", "<spring:url value="/contact/showForm" />")
                    }
                },
                {isSeparator: true},

                {
                    title: "<spring:message code='feature.title'/>",
                    click: function () {
                        createTab("<spring:message code='feature.title'/>", "<spring:url value="/feature/showForm" />")
                    }
                },
                {isSeparator: true},

                {
                    title: "<spring:message code='commercialIncoterms.title'/>",
                    click: function () {
                        createTab("<spring:message code='commercialIncoterms.title'/>", "<spring:url value="/incoterms/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='glossary.title'/>",
                    click: function () {
                        createTab("<spring:message code='glossary.title'/>", "<spring:url value="/glossary/showForm" />")
                    }
                },
                {isSeparator: true},

                {
                    title: "<spring:message code='warehouseCad.yard'/>",
                    click: function () {
                        createTab("<spring:message code='warehouseCad.yard'/>", "<spring:url value="/warehouseYard/showForm" />")
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
                    title: "<spring:message code='port.port'/>",
                    click: function () {
                        createTab("<spring:message code='port.port'/>", "<spring:url value="/port/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='parameters.title'/>",
                    click: function () {
                        createTab("<spring:message code='parameters.title'/>", "<spring:url value="/parameters/showForm" />")
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
                {
                    title: "<spring:message code='dcc.title'/>",
                    click: function () {
                        createTab("<spring:message code='dcc.title'/>", "<spring:url value="/dccView/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='instruction.title'/>",
                    click: function () {
                        createTab("<spring:message code='instruction.title'/>", "<spring:url value="/instruction/showForm" />")
                    }
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
                            title: "<spring:message code='rate.title'/>",
                            click: function () {
                                createTab("<spring:message code='rate.title'/>", "<spring:url value="/rate/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        {
                            title: "<spring:message code='exchangeRate.title'/>",
                            click: function () {
                                createTab("<spring:message code='exchangeRate.title'/>", "<spring:url value="/currencyRate/showForm" />")
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
                            title: "<spring:message code='paymentOption.title'/>",
                            click: function () {
                                createTab("<spring:message code='paymentOption.title'/>", "<spring:url value="/paymentOption/showForm" />")
                            }
                        },
                        {isSeparator: true},
                        {
                            title: "<spring:message code='LME.title'/>",
                            click: function () {
                                createTab("<spring:message code='LME.title'/>", "<spring:url value="/LME/showForm" />")
                            }
                        },
                    ]
                },
            ]
        }),
    });

    /*----------------------settingTab------------------------*/
    settingTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.settingTab'/>",
        menu: isc.Menu.create({
            data: [
                {
                    title: "<spring:message code='setting.appRoles'/>",
                    click: function () {
                        createTab("<spring:message code='setting.appRoles'/>", "<spring:url value="web/oauth/app-roles/show-form" />", false);
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='setting.groupPermission'/>",
                    click: function () {
                        createTab("<spring:message code='setting.groupPermission'/>", "<spring:url value="web/oauth/groups/show-form" />", false);
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='setting.roleUser'/>",
                    click: function () {
                        createTab("<spring:message code='setting.roleUser'/>", "<spring:url value="web/oauth/users/show-form" />", false);
                    }
                },
                {isSeparator: true},
            ]
        })
    });

    /*----------------------contractsTab------------------------*/
    contractsTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.contractsTab'/>",
        menu: isc.Menu.create({
            data: [
                {
                    title: "<spring:message code='salesContract.title'/>",
                    click: function () {
                        var url_string = window.location.href;
                        var url = new URL(url_string);
                        var lang = url.searchParams.get("lang");

                        if(lang=="fa" || lang==null){
                            isc.Dialog.create({
                                message: "بهتر است از این تب در فرمت انگلیسی استفاده کنید",
                                icon: "[SKIN]ask.png",
                                title: "<spring:message code='global.message'/>",
                                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                buttonClick: function () {
                                    this.hide();
                                }
                            });
                            createTab("<spring:message code='salesContract.title'/>", "<spring:url value="/contract/showForm" />")
                        }
                        else{
                            createTab("<spring:message code='salesContract.title'/>", "<spring:url value="/contract/showForm" />")
                        }
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='inspectionContract.title'/>",
                    click: function () {
                        createTab("<spring:message code='inspectionContract.title'/>", "<spring:url value="/inspectionContract/showForm" />")
                    }
                },
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

            ]
        })
    });
    /*----------------------productTab------------------------*/
    productTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.productTab'/>",
        menu: isc.Menu.create({
            data: [
                {
                    title: "<spring:message code='tozin.title'/>",
                    click: function () {
                        createTab("<spring:message code='tozin.title'/>", "<spring:url value="/tozin/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='tozin.onWay'/>",
                    click: function () {
                        createTab("<spring:message code='tozin.onWay'/>", "<spring:url value="/tozin/showOnWayProductForm" />")
                    }

                },
                {isSeparator: true},
                {
                    title: "<spring:message code='tozinSales.title'/>",
                    click: function () {
                        createTab("<spring:message code='tozinSales.title'/>", "<spring:url value="/tozinSales/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='molybdenum.title'/>",
                    click: function () {
                        createTab("<spring:message code='molybdenum.title'/>", "<spring:url value="/warehouseLot/showForm" />")
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
                {
                    title: "<spring:message code='Shipment.titleWarehouseIssueCathode'/>",
                    click: function () {
                        createTab("<spring:message code='Shipment.titleWarehouseIssueCathode'/>", "<spring:url value="/warehouseIssueCathode/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='Shipment.titleWarehouseIssueCons'/>",
                    click: function () {
                        createTab("<spring:message code='Shipment.titleWarehouseIssueCons'/>", "<spring:url value="/warehouseIssueCons/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='Shipment.titleWarehouseIssueMo'/>",
                    click: function () {
                        createTab("<spring:message code='Shipment.titleWarehouseIssueMo'/>", "<spring:url value="/warehouseIssueMo/showForm" />")
                    }
                },
                {isSeparator: true},
            ]
        })
    });

    /*----------------------shipmentTab------------------------*/
    shipmentTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.shipmentTab'/>",
        menu: isc.Menu.create({
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
                },
                {isSeparator: true},

            ]
        })
    });

    /*----------------------inspectionTab------------------------*/
    inspectionTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.inspectionTab'/>",
        menu: isc.Menu.create({
            data: [
                {
                    title: "<spring:message code='inspectionMoistureResults.title'/>",
                    click: function () {
                        createTab("<spring:message code='inspectionMoisture.title'/>", "<spring:url value="/shipmentMoisture/showForm" />")
                    }
                },
                {isSeparator: true},
                {
                    title: "<spring:message code='inspectionAssayResults.title'/>",
                    click: function () {
                        createTab("<spring:message code='inspectionAssay.title'/>", "<spring:url value="/shipmentAssay/showForm" />")
                    }
                },
                {isSeparator: true},
            ]
        })
    });

    /*----------------------financialTab------------------------*/
    financialTab = isc.ToolStripMenuButton.create({
        title: "&nbsp; <spring:message code='main.financialTab'/>",
        menu: isc.Menu.create({
            data: [
                {
                    title: "<spring:message code='issuedInvoices.title'/>",
                    click: function () {
                        var url_string = window.location.href;
                        var url = new URL(url_string);
                        var lang = url.searchParams.get("lang");

                        if(lang=="fa" || lang==null){
                            isc.Dialog.create({
                                message: "بهتر است از این تب در فرمت انگلیسی استفاده کنید",
                                icon: "[SKIN]ask.png",
                                title: "<spring:message code='global.message'/>",
                                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                buttonClick: function () {
                                    this.hide();
                                }
                            });
                            createTab("<spring:message code='issuedInvoices.title'/>", "<spring:url value="/invoice/showForm" />")
                        }
                        else{
                            createTab("<spring:message code='issuedInvoices.title'/>", "<spring:url value="/invoice/showForm" />")
                        }
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
            ]
        })
    });

    //---------------------------------------
    var mainTabSet = isc.TabSet.create({
        tabBarPosition: "top",
        width: "100%",
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
                            if (index === 0) {
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
        layoutMargin: 5,
        showShadow: true,
        shadowDepth: 3,
        shadowColor: "#153560",

        members: [
            baseTab,
            productTab,
            contractsTab,
            shipmentTab,
            financialTab,
            inspectionTab,
            settingTab,

        ]
    });


    var MainDesktopMenuH = isc.HLayout.create({
        width: "100%",
        height: "4%",
        styleName: "main-menu",
        align: "center",
        members: [
            saleToolStrip
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        backgroundColor: "",
        members: [headerLayout, MainDesktopMenuH, mainTabSet]
    });

    var dollar = {};
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/currency/list",
            httpMethod: "GET",
            data: "",
            callback: function (RpcResponse_o) {
                if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
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