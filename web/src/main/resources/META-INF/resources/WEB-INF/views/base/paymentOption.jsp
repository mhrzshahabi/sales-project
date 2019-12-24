<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    function ListGrid_PaymentOption_refresh() {
        ListGrid_PaymentOption.invalidateCache();
    }

    function ListGrid_PaymentOption_edit() {
        var record = ListGrid_PaymentOption.getSelectedRecord();

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
            DynamicForm_PaymentOption.editRecord(record);
            Window_PaymentOption.show();
        }
    }

    function ListGrid_PaymentOption_remove() {

        var record = ListGrid_PaymentOption.getSelectedRecord();
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
                    isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}),
                    isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var paymentOptionId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/paymentOption/" + paymentOptionId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_PaymentOption_refresh();
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

    var Menu_ListGrid_PaymentOption = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_PaymentOption_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_PaymentOption.clearValues();
                    Window_PaymentOption.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_PaymentOption_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_PaymentOption_remove();
                }
            }
        ]
    });

    var DynamicForm_PaymentOption = isc.DynamicForm.create({
        width: 700,
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
                {
                    name: "namePay",
                    title: "<spring:message code='paymentOption.payName'/>",
                    type: 'text',
                    width: 500,
                    required: true,
                    length: "255"
                },
                {type: "RowSpacerItem"}
            ]
    });

    var ToolStripButton_PaymentOption_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_PaymentOption_refresh();
        }
    });


    var ToolStripButton_PaymentOption_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_PaymentOption.clearValues();
            Window_PaymentOption.show();
        }
    });


    var ToolStripButton_PaymentOption_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_PaymentOption.clearValues();
            ListGrid_PaymentOption_edit();
        }
    });

    var ToolStripButton_PaymentOption_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_PaymentOption_remove();
        }
    });
    var ToolStrip_Actions_PaymentOption = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_PaymentOption_Add,
                ToolStripButton_PaymentOption_Edit,
                ToolStripButton_PaymentOption_Remove,
                isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                ToolStripButton_PaymentOption_Refresh
                    ]
                })

            ]
    });

    var HLayout_PaymentOption_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_PaymentOption
            ]
    });
    var RestDataSource_PaymentOption = isc.MyRestDataSource.create({
        fields:
            [
                {name:  "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "namePay", title: "<spring:message code='paymentOption.payName'/>", width: 200}
            ],

        fetchDataURL: "${contextPath}/api/paymentOption/spec-list"

    });
    var IButton_PaymentOption_Save = isc.IButtonSave.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_PaymentOption.validate();
            if (DynamicForm_PaymentOption.hasErrors())
                return;
            var data = DynamicForm_PaymentOption.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/paymentOption",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_PaymentOption_refresh();
                            Window_PaymentOption.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var PaymentOptionCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        icon: "pieces/16/icon_delete.png",
        title: "<spring:message code='global.cancel'/>",
        click: function () {
            Window_PaymentOption.close();
        }
    });

    var HLayout_PaymentOption_IButton = isc.HLayout.create({
        layoutMargin: 5,
        membersMargin: 5,
        members: [
            IButton_PaymentOption_Save,
            PaymentOptionCancelBtn
        ]
    });

    var Window_PaymentOption = isc.Window.create({
        title: "<spring:message code='paymentOption.title'/> ",
        width: 500,
        height: 50,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        layoutMargin: 5,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                DynamicForm_PaymentOption,
                HLayout_PaymentOption_IButton
            ]
    });
    var ListGrid_PaymentOption = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_PaymentOption,
        contextMenu: Menu_ListGrid_PaymentOption,
        doubleClick: function () {
            ListGrid_PaymentOption_edit();
        },
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "namePay",
                    title: "<spring:message code='paymentOption.payName'/>",
                    width: "50%",
                    align: "center"
                }
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
    var HLayout_PaymentOption_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_PaymentOption
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_PaymentOption_Actions, HLayout_PaymentOption_Grid
        ]
    });