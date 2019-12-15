<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WAREHOUSE_STOCK__BANK = isc.MyRestDataSource.create({
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
            name: "warehouseYardnameFA", dataPath:"warehouseYard.nameFA"  ,
            title: "<spring:message code='warehouseCad.yard'/>",
            sortNormalizer: function(recordObject) {
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
            name: "materialItemgdsName", dataPath:"materialItem.gdsName"  ,
            title: "<spring:message code='material.descp'/>"
        }],
        fetchDataURL: "${contextPath}/api/warehouseStock/spec-list"
    });



    function ListGrid_WarehouseStock_refresh() {
        ListGrid_WarehouseStock.invalidateCache();
    }

    function ListGrid_WarehouseStock_edit() {
        var record = ListGrid_WarehouseStock.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            DynamicForm_WarehouseStock.editRecord(record);
            Window_WarehouseStock.show();
        }
    }

var DynamicForm_WarehouseStock_Tozin = isc.DynamicForm.create({
    width: "200",
    wrapItemTitles: false,
    height: "100%",
    setMethod: 'POST',
    align: "center",
    action: "report/printDailyReportBandarAbbas",
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
    }, ]
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
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_WarehouseStock_edit();
                }
            },
             {isSeparator: true},
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    var toDay = "1398/08/30".replaceAll("/", "");
                    "<spring:url value="/warehouseStock/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                    var toDay = "1398/08/30".replaceAll("/", "");
                    "<spring:url value="/warehouseStock/print/excel" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                    var toDay = "1398/08/30".replaceAll("/", "");
                    "<spring:url value="/warehouseStock/print/html" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            }
        ]
    });


var DynamicForm_WarehouseStock = isc.DynamicForm.create({
    width: 650,
    height: "100%",
    setMethod: 'POST',
    align: "center",
    canSubmit: true,
    showInlineErrors: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "right",
    titleWidth: "100",
    titleAlign: "right",
    requiredMessage: "<spring:message code='validator.field.is.required'/>",
    numCols: 2,
    fields: [{
        type: "RowSpacerItem"
    }, {
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
        name: "warehouseYardId",
        hidden: true
    }, {
        name: "warehouseYardnameFA", dataPath:"warehouseYard.nameFA"  ,
        title: "<spring:message code='warehouseCad.yard'/>"
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
        name: "materialItemgdsName", dataPath:"materialItem.gdsName"  ,
        title: "<spring:message code='material.descp'/>"
    }]
});


    var ToolStripButton_WarehouseStock_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseStock_refresh();
        }
    });

<%--/*--%>
    <%--var ToolStripButton_WarehouseStock_Add = isc.ToolStripButton.create({--%>
        <%--icon: "[SKIN]/actions/add.png",--%>
        <%--title: "<spring:message code='global.form.new'/>",--%>
        <%--click: function () {--%>
            <%--DynamicForm_WarehouseStock.clearValues();--%>
            <%--Window_WarehouseStock.show();--%>
        <%--}--%>
    <%--});--%>
<%--*/--%>

    var ToolStripButton_WarehouseStock_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_WarehouseStock.clearValues();
            ListGrid_WarehouseStock_edit();
        }
    });

   var ToolStripButton_WarehouseStock_Print = isc.ToolStripButton.create({
         icon: "[SKIN]/actions/print.png",
         title: "<spring:message code='WarehouseStock.Reportoncommitmentsleadingupto'/>",
        click:function()
        {

            var drs = DynamicForm_WarehouseStock_Tozin.getValue("toDay");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
        console.log(datestringRs);
                     var toDay = datestringRs.replaceAll("/", "");
        console.log(toDay);
                    "<spring:url value="/warehouseStock/print-commitment" var="printUrl"/>"  /*Bug*/
                    window.open('${printUrl}' + '/' + toDay);
        }
    });

   var ToolStripButton_WarehouseStock_export_Print = isc.ToolStripButton.create({
         icon: "[SKIN]/actions/print.png",
         title: "<spring:message code='WarehouseStock.ReportExport'/>",
        click:function()
        {

            var drs = DynamicForm_WarehouseStock_Tozin.getValue("toDay");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
        console.log(datestringRs);
                     var toDay = datestringRs.replaceAll("/", "");
        console.log(toDay);
                    "<spring:url value="/warehouseStock/print-export" var="printUrl"/>" /*Bug*/
                    window.open('${printUrl}' + '/' + toDay);
        }
    });

    var ToolStrip_Actions_WarehouseStock = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_WarehouseStock_Refresh,
                // ToolStripButton_WarehouseStock_Add,
                ToolStripButton_WarehouseStock_Edit,
                ToolStripButton_WarehouseStock_Print,
                DynamicForm_WarehouseStock_Tozin,
                ToolStripButton_WarehouseStock_export_Print
            ]
    });

    var HLayout_WarehouseStock_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseStock
            ]
    });

    var Window_WarehouseStock = isc.Window.create({
        title: "<spring:message code='warehouseStock'/> ",
        width: 580,
        // height: 500,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                DynamicForm_WarehouseStock
            ]
    });


        var ListGrid_WarehouseStock = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WAREHOUSE_STOCK__BANK,
        contextMenu: Menu_ListGrid_WarehouseStock,
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "warehouseNo"
        }, {
            name: "plant"
        }, {
            name: "warehouseYardnameFA" , dataPath:"warehouseYard.nameFA"  ,
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
            name: "materialItemgdsName" , dataPath:"materialItem.gdsName"  ,
        }],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function(viewer, record1, recordNum, field, fieldNum, value, rawValue) {},
        dataArrived: function(startRow, endRow) {}
    });



    var HLayout_WarehouseStock_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_WarehouseStock
        ]
    });

    var VLayout_WarehouseStock_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_WarehouseStock_Actions, HLayout_WarehouseStock_Grid
        ]
    });