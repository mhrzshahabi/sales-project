<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WAREHOUSE_STOCK__BANK = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='warehouseStock.warehouseStockCode'/>", width: 200},
                {name: "plant", title: "<spring:message code='warehouseStock.nameFa'/>", width: 200},
                {name: "yard", title: "<spring:message code='warehouseStock.nameEn'/>", width: 200},
                {name: "sheetNo", title: "<spring:message code='warehouseStock.address'/>", width: 200},
                {name: "bundleNo", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "gross", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "net", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "barrelNo", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "lotNo", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "materialItem.nameFa", title: "<spring:message code='materialItem.nameFa'/>", width: 200}
            ],

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

    function ListGrid_WarehouseStock_remove() {

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
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var WarehouseStockId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/warehouseStock/" + WarehouseStockId,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_WarehouseStock_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                }
                            })
                        );
                    }
                }
            });
        }
    }

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
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png", click: function () {
                    "<spring:url value="/warehouseStock/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png", click: function () {
                    "<spring:url value="/warehouseStock/print/excel" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg", click: function () {
                    "<spring:url value="/warehouseStock/print/html" var="printUrl"/>"
                    window.open('${printUrl}');
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
        fields:
            [
                {name: "id", hidden: true,},
                {type: "RowSpacerItem"},
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='warehouseStock.warehouseStockCode'/>", width: 200},
                {name: "plant", title: "<spring:message code='warehouseStock.nameFa'/>", width: 200},
                {name: "yard", title: "<spring:message code='warehouseStock.nameEn'/>", width: 200},
                {name: "sheetNo", title: "<spring:message code='warehouseStock.address'/>", width: 200},
                {name: "bundleNo", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "gross", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "net", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "barrelNo", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "lotNo", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "materialItem.nameFa", title: "<spring:message code='materialItem.nameFa'/>", width: 200}
            ]
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

    <%--var ToolStripButton_WarehouseStock_Remove = isc.ToolStripButton.create({--%>
        <%--icon: "[SKIN]/actions/remove.png",--%>
        <%--title: "<spring:message code='global.form.remove'/>",--%>
        <%--click: function () {--%>
            <%--ListGrid_WarehouseStock_remove();--%>
        <%--}--%>
    <%--});--%>

    var ToolStrip_Actions_WarehouseStock = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_WarehouseStock_Refresh,
                // ToolStripButton_WarehouseStock_Add,
                ToolStripButton_WarehouseStock_Edit,
                // ToolStripButton_WarehouseStock_Remove
            ]
    });

    var HLayout_WarehouseStock_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseStock
            ]
    });

    var IButton_WarehouseStock_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_WarehouseStock.validate();
            if (DynamicForm_WarehouseStock.hasErrors())
                return;

            var data = DynamicForm_WarehouseStock.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseStock/",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_WarehouseStock_refresh();
                            Window_WarehouseStock.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var Window_WarehouseStock = isc.Window.create({
        title: "<spring:message code='warehouseStock.title'/> ",
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
                DynamicForm_WarehouseStock,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_WarehouseStock_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            /*isc.IButton.create({
                                ID: "warehouseStockEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_WarehouseStock.close();
                                }
                            })*/
                        ]
                })
            ]
    });
    var ListGrid_WarehouseStock = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WAREHOUSE_STOCK__BANK,
        contextMenu: Menu_ListGrid_WarehouseStock,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='warehouseStock.warehouseStockCode'/>", width: 200},
                {name: "plant", title: "<spring:message code='warehouseStock.nameFa'/>", width: 200},
                {name: "yard", title: "<spring:message code='warehouseStock.nameEn'/>", width: 200},
                {name: "sheetNo", title: "<spring:message code='warehouseStock.address'/>", width: 200},
                {name: "bundleNo", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "gross", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "net", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "barrelNo", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "lotNo", title: "<spring:message code='warehouseStock.coreBranch'/>", width: 200},
                {name: "materialItem.nameFa", title: "<spring:message code='materialItem.nameFa'/>", width: 200}
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        },
        dataArrived: function (startRow, endRow) {
        }
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