<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

    var Menu_ListGrid_Unit = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Unit_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Unit.clearValues();
                    Window_Unit.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Unit_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Unit_remove();
                }
            }
        ]
    });

    var ValuesManager_Unit = isc.ValuesManager.create({});
    var DynamicForm_Unit = isc.DynamicForm.create({
        width: "100%",
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
        numCols: 1,

        fields: [
            {name: "id", hidden: true,},
            {type: "RowSpacerItem"},
            {
                name: "code", title: "<spring:message code='unit.code'/>", type: 'text', required: true,
                width: 400, keyPressFilter: "[0-9]", length: "15"
            },
            {name: "nameFA", title: "<spring:message code='unit.nameFa'/>", required: true, readonly: true, width: 400},
            {
                name: "nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text', required: true,
                width: 400, keyPressFilter: "[a-z|A-Z|0-9.]"
            },
            {name: "symbol", title: "<spring:message code='unit.symbol'/>", type: 'text', width: 400},
            {
                name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>", width: 400
                , keyPressFilter: "[0-9]", length: "15"
            },
            {type: "RowSpacerItem"},
        ]
    });

    var IButton_Unit_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            ValuesManager_Unit.validate();
            DynamicForm_Unit.validate();
            if (DynamicForm_Unit.hasErrors()) {
                return;
            }
            var data = DynamicForm_Unit.getValues();
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${restApiUrl}/api/unit/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_Unit_refresh();
                            Window_Unit.close();
                        } else {
                            isc.say(RpcResponse_o.data);
                        }
                    }
                })
            );
        }
    });

    var Window_Unit = isc.Window.create({
        title: "<spring:message code='unit.title'/>",
        width: 580,
        height: 310,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        margin: '10px',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            DynamicForm_Unit,
            isc.HLayout.create({
                width: "100%",
                members:
                    [
                        IButton_Unit_Save,
                        isc.Label.create({
                            width: 5,
                        }),
                        isc.IButton.create({
                            ID: "unitEditExitIButton",
                            title: "<spring:message code='global.cancel'/>",
                            width: 100,
                            icon: "pieces/16/icon_delete.png",
                            orientation: "vertical",
                            click: function () {
                                Window_Unit.close();
                            }
                        })
                    ]
            })
        ]
    });

    function ListGrid_Unit_refresh() {
        ListGrid_Unit.invalidateCache();
    };

    function ListGrid_Unit_remove() {

        var record = ListGrid_Unit.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({
                    title: "<spring:message
		code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {

                        var unitId = record.id;

                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
                                actionURL: "${restApiUrl}/api/unit/" + unitId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_Unit.invalidateCache();
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
    };

    function ListGrid_Unit_edit() {

        var record = ListGrid_Unit.getSelectedRecord();

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
            DynamicForm_Unit.editRecord(record);
            Window_Unit.show();
        }
    };


    var ToolStripButton_Unit_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Unit_refresh();
        }
    });

    var ToolStripButton_Unit_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Unit.clearValues();
            Window_Unit.show();
        }
    });

    var ToolStripButton_Unit_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Unit_edit();
        }
    });


    var ToolStripButton_Unit_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Unit_remove();
        }
    });


    var ToolStrip_Actions_Unit = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_Unit_Refresh,
            ToolStripButton_Unit_Add,
            ToolStripButton_Unit_Edit,
            ToolStripButton_Unit_Remove
        ]
    });

    var HLayout_Actions_Unit = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Unit
        ]
    });

    var RestDataSource_Unit = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='unit.code'/> "},
            {name: "nameFA", title: "<spring:message code='unit.nameFa'/> "},
            {name: "nameEN", title: "<spring:message code='unit.nameEN'/> "},
            {name: "symbol", title: "<spring:message code='unit.symbol'/>"},
            {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
        ],
// ######@@@@###&&@@###
        fetchDataURL: "${restApiUrl}/api/unit/spec-list"
    });

    var ListGrid_Unit = isc.MyListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Unit,
        contextMenu: Menu_ListGrid_Unit,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='unit.code'/> ", align: "center"},
            {name: "nameFA", title: "<spring:message code='unit.nameFa'/> ", align: "center"},
            {name: "nameEN", title: "<spring:message code='unit.nameEN'/> ", align: "center"},
            {name: "symbol", title: "<spring:message code='unit.symbol'/>", align: "center"},
            {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>", align: "center"}
        ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt"
    });


    var HLayout_Grid_Unit = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Unit
        ]
    });

    var VLayout_Body_Unit = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Actions_Unit, HLayout_Grid_Unit
        ]
    });
