<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WarehouseYard__BANK = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='warehouseCad.warehouseNo'/>", width: 200},
                {name: "nameFA", title: "<spring:message code='warehouseCad.yard'/>", width: 200},
                {name: "nameEN", title: "<spring:message code='warehouseCad.yard'/>", width: 200},
           ],

        fetchDataURL: "${contextPath}/api/warehouseYard/spec-list"
    });


    function ListGrid_WarehouseYard_refresh() {
        ListGrid_WarehouseYard.invalidateCache();
    }

    function ListGrid_WarehouseYard_edit() {
        var record = ListGrid_WarehouseYard.getSelectedRecord();

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
            DynamicForm_WarehouseYard.editRecord(record);
            Window_WarehouseYard.show();
        }
    }

    function ListGrid_WarehouseYard_remove() {

        var record = ListGrid_WarehouseYard.getSelectedRecord();

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
                        var WarehouseYardId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/warehouseYard/" + WarehouseYardId,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_WarehouseYard_refresh();
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

    var Menu_ListGrid_WarehouseYard = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_WarehouseYard_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_WarehouseYard.clearValues();
                    Window_WarehouseYard.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_WarehouseYard_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_WarehouseYard_remove();
                }
            }
        ]
    });

    var DynamicForm_WarehouseYard = isc.DynamicForm.create({
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
                 {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "warehouseNo",
                    title: "<spring:message code='warehouseCad.warehouseNo'/>",
                    width: 500,
                    colSpan: 1, required: true,
                    titleColSpan: 1, keyPressFilter: "[0-9]", length: "15",defaultValue:"BandarAbbas",
                    valueMap:
                        {
                            "BandarAbbas": "<spring:message code='global.BandarAbbas'/>",
                            "Sarcheshmeh": "<spring:message code='global.Sarcheshmeh'/>",
                            "Sungun": "<spring:message code='global.Sungun'/>"
                        }
               },
                {
                    name: "nameFA",
                    title: "<spring:message code='warehouseCad.yard'/>",
                    width: 500,
                    colSpan: 1, required: true,
                    titleColSpan: 1
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='warehouseCad.yard'/>",
                    width: 500,
                    colSpan: 1, required: true,
                    titleColSpan: 1
                },
              ]
    });

    var ToolStripButton_WarehouseYard_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseYard_refresh();
        }
    });

    var ToolStripButton_WarehouseYard_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_WarehouseYard.clearValues();
            Window_WarehouseYard.show();
        }
    });

    var ToolStripButton_WarehouseYard_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_WarehouseYard.clearValues();
            ListGrid_WarehouseYard_edit();
        }
    });

    var ToolStripButton_WarehouseYard_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_WarehouseYard_remove();
        }
    });

    var ToolStrip_Actions_WarehouseYard = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_WarehouseYard_Refresh,
                ToolStripButton_WarehouseYard_Add,
                ToolStripButton_WarehouseYard_Edit,
                ToolStripButton_WarehouseYard_Remove
            ]
    });

    var HLayout_WarehouseYard_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseYard
            ]
    });

    var IButton_WarehouseYard_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_WarehouseYard.validate();
            if (DynamicForm_WarehouseYard.hasErrors())
                return;

            var data = DynamicForm_WarehouseYard.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseYard/",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_WarehouseYard_refresh();
                            Window_WarehouseYard.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var Window_WarehouseYard = isc.Window.create({
        title: "<spring:message code='warehouseCad.warehouseNo'/> ",
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
                DynamicForm_WarehouseYard,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_WarehouseYard_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                ID: "warehouseYardEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_WarehouseYard.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_WarehouseYard = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WarehouseYard__BANK,
        contextMenu: Menu_ListGrid_WarehouseYard,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                 {
                    name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouse'/>", align: "center", colSpan: 1, titleColSpan: 1, defaultValue: "BandarAbbas",
                    valueMap:
                        {
                            "BandarAbbas": "<spring:message code='global.BandarAbbas'/>",
                            "Sarcheshmeh": "<spring:message code='global.Sarcheshmeh'/>",
                            "Sungun": "<spring:message code='global.Sungun'/>"
                        }
                },
                {name: "nameFA", title: "<spring:message code='warehouseCad.yard'/>", width: "10%", align: "center"},
                {name: "nameEN", title: "<spring:message code='warehouseCad.yard'/>", width: "10%", align: "center"},
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

    var HLayout_WarehouseYard_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_WarehouseYard
        ]
    });

    var VLayout_WarehouseYard_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_WarehouseYard_Actions, HLayout_WarehouseYard_Grid
        ]
    });