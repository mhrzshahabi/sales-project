<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_DailyReport = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", primaryKey: true, type: "integer", title: "ID"},
                {name: "warehouse", title: "<spring:message code='dailyWarehouse.warehouse'/>"},
                {name: "toDay", title: "<spring:message code='dailyWarehouse.toDay'/>"},
                {name: "material.descp", title: "<spring:message code='material.descp'/>"},
                {name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>"},
                {name: "packingType", title: "<spring:message code='global.packingType'/>"},
                {name: "amountDay", title: "<spring:message code='dailyReport.amountDay'/>"},
                {name: "amountImportDay", title: "<spring:message code='dailyReport.amountImportDay'/>"},
                {name: "amountFirstDay", title: "<spring:message code='dailyReport.amountFirstDay'/>"},
                {name: "amountExportDay", title: "<spring:message code='dailyReport.amountExportDay'/>"},
                {name: "amountReviseDay", title: "<spring:message code='dailyReport.amountReviseDay'/>"},
                {name: "amountFirstMon", title: "<spring:message code='dailyReport.amountFirstMon'/>"},
                {name: "amountImportMon", title: "<spring:message code='dailyReport.amountImportMon'/>"},
                {name: "amountExportMon", title: "<spring:message code='dailyReport.amountExportMon'/>"},
                {name: "amountReviseMon", title: "<spring:message code='dailyReport.amountReviseMon'/>"},
                {name: "amountFirstSal", title: "<spring:message code='dailyReport.amountFirstSal'/>"},
                {name: "amountImportSal", title: "<spring:message code='dailyReport.amountImportSal'/>"},
                {name: "amountExportSal", title: "<spring:message code='dailyReport.amountExportSal'/>"},
                {name: "amountReviseSal", title: "<spring:message code='dailyReport.amountReviseSal'/>"},
                {name: "reviseSal", title: "<spring:message code='dailyReport.reviseSalPct'/>"}
            ],
        fetchDataURL: "${contextPath}/api/dailyReportBandarAbbas/spec-list",
        allowAdvancedCriteria: true
    });

    var DynamicForm_DailyReport = isc.DynamicForm.create({
        width: "300",
        wrapItemTitles: false,
        height: "100%",
        setMethod: 'POST',
        align: "center",
        action: "${contextPath}/api/report/printDailyReportBandarAbbas",
        target: "_Blank",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "200",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4,
        fields:
            [
                {
                    name: "toDay", ID: "toDayDate", title: "<spring:message
		code='dailyWarehouse.toDay'/>", type: 'text', align: "center", width: 150, colSpan: 1, titleColSpan: 1
                    , icons: [{
                        src: "pieces/pcal.png", click: function () {
                            displayDatePicker('toDayDate', this, 'ymd', '/');
                        }
                    }], defaultValue: "1398/01/26"
                },
                {
                    name: "warehouse", title: "<spring:message code='dailyWarehouse.warehouse'/>", align: "center", colSpan: 1, titleColSpan: 1, defaultValue: "BandarAbbas",
                    valueMap:
                        {
                            "BandarAbbas": "<spring:message code='global.BandarAbbas'/>",
                            "Sarcheshmeh": "<spring:message code='global.Sarcheshmeh'/>",
                            "Sungun": "<spring:message code='global.Sungun'/>"
                        }
                }
            ]
    });

    var ListGrid_DailyReport = isc.ListGrid.create({
        width: "100%",
        height: "98%",
        autoFetchData: true,
        autoDraw: false,
        alternateRecordStyles: true,
        dataSource: RestDataSource_DailyReport,
        showFilterEditor: true,
        allowAdvancedCriteria: true,
        allowFilterExpressions: true,
        showRowNumbers: true,
        fields:
            [
                {name: "warehouse", title: "<spring:message code='dailyWarehouse.warehouse'/>", width: 150},
                {name: "toDay", title: "<spring:message code='dailyWarehouse.toDay'/>", width: 150},
                {name: "material.descp", title: "<spring:message code='material.descp'/>", width: 150},
                {name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", width: 150},
                {name: "packingType", title: "<spring:message code='global.packingType'/>", width: 150},
                {name: "amountDay", title: "<spring:message code='dailyReport.amountDay'/>", width: 150},
                {name: "amountImportDay", title: "<spring:message code='dailyReport.amountImportDay'/>", width: 150},
                {name: "amountExportDay", title: "<spring:message code='dailyReport.amountExportDay'/>", width: 150},
                {name: "amountReviseDay", title: "<spring:message code='dailyReport.amountReviseDay'/>", width: 150},
                {name: "amountFirstMon", title: "<spring:message code='dailyReport.amountFirstMon'/>", width: 150},
                {name: "amountImportMon", title: "<spring:message code='dailyReport.amountImportMon'/>", width: 150},
                {name: "amountExportMon", title: "<spring:message code='dailyReport.amountExportMon'/>", width: 150},
                {name: "amountReviseMon", title: "<spring:message code='dailyReport.amountReviseMon'/>", width: 150},
                {name: "amountFirstSal", title: "<spring:message code='dailyReport.amountFirstSal'/>", width: 150},
                {name: "amountImportSal", title: "<spring:message code='dailyReport.amountImportSal'/>", width: 150},
                {name: "amountExportSal", title: "<spring:message code='dailyReport.amountExportSal'/>", width: 150},
                {name: "amountReviseSal", title: "<spring:message code='dailyReport.amountReviseSal'/>", width: 150},
                {name: "reviseSal", title: "<spring:message code='dailyReport.reviseSalPct'/>", width: 150}
            ]
    });
    var createDailyReportBanViewLoader = isc.ViewLoader.create({
        width: "100%",
        height: "100%",
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>"
    });
    var Window_createDailyReportBandar = isc.Window.create({
        title: "<spring:message code='dailyReport.DailyReportBandarAbbas'/> ",
        width: "1560",
        height: "95%",
        autoCenter: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                createDailyReportBanViewLoader
            ]
    });
    var ToolStripButton_DailyReport = isc.ToolStripButton.create({
        icon: "icon/search.png",
        title: "<spring:message code='global.form.export'/>",
        click: function () {
            var toDay = DynamicForm_DailyReport.getValue("toDay");
            var warehouse = DynamicForm_DailyReport.getValue("warehouse");
            "<spring:url value="/dailyReportBandarAbbas/print/excel" var="printUrl"/>"
            window.open('${printUrl}' + "?toDay=" + toDay + "&warehouse=" + warehouse);
        }


    });
    var ToolStripButton_DailyReport_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var toDay = DynamicForm_DailyReport.getValue("toDay").replaceAll("/", "");
            var warehouse = DynamicForm_DailyReport.getValue("warehouse");
            createDailyReportBanViewLoader.setViewURL("<spring:url
		value="report/dailyReportBandarAbbas/createForm"/>" + "/" + toDay + "/" + warehouse);
            Window_createDailyReportBandar.show();
        }
    });
    var ToolStrip_Actions_DailyReport = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_DailyReport_Add,
                DynamicForm_DailyReport,
                ToolStripButton_DailyReport,
                isc.Label.create({
                    width: 800
                })
            ]
    });

    var HLayout_ToolStrip = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_DailyReport
            ]
    });
    var HLayout_DailyReport_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                ListGrid_DailyReport
            ]
    });
    isc.VLayout.create({
        width: "100%",
        members:
            [
                HLayout_ToolStrip,
                HLayout_DailyReport_Grid
            ]
    });