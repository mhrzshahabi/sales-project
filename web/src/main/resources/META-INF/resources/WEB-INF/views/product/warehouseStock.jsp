<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WAREHOUSE_STOCK = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "warehouseNo",
            title: "<spring:message code='warehouseCad.warehouseNo'/>"
        }, {
            name: "plant",
            title: "<spring:message code='warehouseCad.plant'/>"
        }, {
            name: "warehouseYardId"
        }, {
            name: "warehouseYard.nameFA",
            type: "text",
            title: "<spring:message code='warehouseCad.yard'/>",
            sortNormalizer: function (recordObject) {
                return recordObject.warehouseYard.nameFA
            }
        }, {
            name: "sheet",
            title: "<spring:message code='warehouseCadItem.sheetNo'/>"
        }, {
            name: "bundle",
            title: "<spring:message code='warehouseStock.bundle'/>"
        }, {
            name: "amount",
            title: "<spring:message code='warehouseCadItem.weightKg'/>"
        }, {
            name: "barrel",
            title: "<spring:message code='warehouseCadItem.barrelNo'/>"
        }, {
            name: "lot",
            title: "<spring:message code='warehouseStock.lot'/>"
        }, {
            name: "materialItem.gdsName",
            title: "<spring:message code='material.descp'/>",
            sortNormalizer: function (recordObject) {
                return recordObject.materialItem.gdsName;
            }
        }],
        fetchDataURL: "${contextPath}/api/warehouseStock/spec-list"
    });


    function ListGrid_WarehouseStock_refresh() {
        ListGrid_WarehouseStock.invalidateCache();
    }

    var DynamicForm_WarehouseStock_Tozin = isc.DynamicForm.create({
        width: "200",
        wrapItemTitles: false,
        height: "100%",
        action: "report/printDailyReportBandarAbbas",
        target: "_Blank",
        titleWidth: "200",
        numCols: 4,
        fields: [{
            name: "toDay",
            ID: "toDayDate",
            title: "",
            type: 'date',
            align: "center",
            width: 150,
            colSpan: 1,
            titleColSpan: 1,
            format: 'YYYY/MM/DD',
            defaultValue: "2019/12/01",
        },]
    });

    var Menu_ListGrid_WarehouseStock = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_WarehouseStock_refresh();
                }
            },
            {isSeparator: true},
            <sec:authorize access="hasAuthority('O_WAREHOUSE_STOCK')">
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    var toDay = "1398/08/30".replaceAll("/", "");
                    "<spring:url value="/warehouseStock/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('O_WAREHOUSE_STOCK')">
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                    var toDay = "1398/08/30".replaceAll("/", "");
                    "<spring:url value="/warehouseStock/print/excel" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('O_WAREHOUSE_STOCK')">
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                    var toDay = "1398/08/30".replaceAll("/", "");
                    "<spring:url value="/warehouseStock/print/html" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            }
            </sec:authorize>
        ]
    });

    var ToolStripButton_WarehouseStock_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseStock_refresh();
        }
    });

    <sec:authorize access="hasAuthority('O_WAREHOUSE_STOCK')">
    var ToolStripButton_WarehouseStock_Print = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='WarehouseStock.Reportoncommitmentsleadingupto'/>",
        click: function () {
            var drs = DynamicForm_WarehouseStock_Tozin.getValue("toDay");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            var toDay = datestringRs.replaceAll("/", "");
            "<spring:url value="/warehouseStock/print-commitment" var="printUrl"/>";
            window.open('${printUrl}' + '/' + toDay);
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('O_WAREHOUSE_STOCK')">
    var ToolStripButton_WarehouseStock_export_Print = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='WarehouseStock.ReportExport'/>",
        click: function () {
            var drs = DynamicForm_WarehouseStock_Tozin.getValue("toDay");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            var toDay = datestringRs.replaceAll("/", "");
            "<spring:url value="/warehouseStock/print-export" var="printUrl"/>";
            window.open('${printUrl}' + '/' + toDay);
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_WarehouseStock = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members:
            [
                <sec:authorize access="hasAuthority('O_WAREHOUSE_STOCK')">
                ToolStripButton_WarehouseStock_Print,
                </sec:authorize>

                DynamicForm_WarehouseStock_Tozin,

                <sec:authorize access="hasAuthority('O_WAREHOUSE_STOCK')">
                ToolStripButton_WarehouseStock_export_Print,
                </sec:authorize>

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_WarehouseStock_Refresh,
                    ]
                })

            ]
    });

    var HLayout_WarehouseStock_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseStock
            ]
    });

    var ListGrid_WarehouseStock = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WAREHOUSE_STOCK,
        contextMenu: Menu_ListGrid_WarehouseStock,
        fields: [
            {
                name: "id",
                title: "id",
                primaryKey: true,
                canEdit: false,
                hidden: true
            }, {name: "warehouseNo"},
            {name: "plant"}, {
                name: "warehouseYard.nameFA",
            }, {
                name: "sheet"
            }, {
                name: "bundle"
            }, {
                name: "amount"
            }, {
                name: "barrel"
            }, {
                name: "lot"
            }, {
                name: "materialItem.gdsName",
            }],
        autoFetchData: true
    });

    var HLayout_WarehouseStock_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_WarehouseStock
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_WarehouseStock_Actions, HLayout_WarehouseStock_Grid
        ]
    });