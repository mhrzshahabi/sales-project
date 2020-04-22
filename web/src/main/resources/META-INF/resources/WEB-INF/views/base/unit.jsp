<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var Menu_ListGrid_Unit = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Unit_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_UNIT')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Unit.clearValues();
                    Window_Unit.show();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_UNIT')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Unit_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_UNIT')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Unit_remove();
                }
            }
            </sec:authorize>
            ]
    });

    var ValuesManager_Unit = isc.ValuesManager.create({});

    var DynamicForm_Unit = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        align: "center",
        titleWidth: "100",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 2,

        fields: [{
            name: "id",
            hidden: true, showIf: "false",
        }, {
            name: "nameFA",
            title: "<spring:message code='unit.nameFa'/>",
            required: true,
            width: 400,
            validators: [
            {
                type:"required",
                validateOnChange: true
            }]
        }, {
            name: "nameEN",
            title: "<spring:message code='unit.nameEN'/>",
            type: 'text',
            required: true,
            width: 400,
            validators: [
            {
                type:"required",
                validateOnChange: true
            }]
        }, {
            name: "symbol",
            title: "<spring:message code='unit.symbol'/>",
            type: 'text',
            required: true,
            width: 400
        }, {
            name: "decimalDigit",
            title: "<spring:message code='rate.decimalDigit'/>",
            width: 400,
            keyPressFilter: "[0-4]",
            length: "1"
        }]
    });

    var IButton_Unit_Save = isc.IButtonSave.create({
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
                    actionURL: "${contextPath}/api/unit/",
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
                margin: '10px',
                padding: 10,
               layoutMargin: 10,
               membersMargin: 5,
               align: "center",
               width: "100%",
                members:
                    [
                        IButton_Unit_Save,
                        isc.Label.create({
                            width: 5,
                        }),
                        isc.IButtonCancel.create({
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
    }

    function ListGrid_Unit_remove() {

        var record = ListGrid_Unit.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>.",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/>"
                        })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
        }
        else {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.remove.ask'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                    buttons: [isc.IButtonSave.create(
                        {
                            title: "<spring:message code='global.yes'/>"
                        }), isc.IButtonCancel.create(
                        {
                            title: "<spring:message code='global.no'/>"

                        })],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var unitId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/unit/" + unitId,
                                    httpMethod: "DELETE",
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                            ListGrid_Unit.invalidateCache();
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                        }
                                        else {
                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                        }
                                    }
                                }));
                        }
                    }
                });
        }
    }

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
    }

    var ToolStripButton_Unit_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Unit_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_UNIT')">
    var ToolStripButton_Unit_Add = isc.ToolStripButtonAdd.create({
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Unit.clearValues();
            Window_Unit.show();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_UNIT')">
    var ToolStripButton_Unit_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Unit.clearValues();
            ListGrid_Unit_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_UNIT')">
    var ToolStripButton_Unit_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Unit_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_Unit = isc.ToolStrip.create({
        width: "100%",
        members: [
            <sec:authorize access="hasAuthority('C_UNIT')">
            ToolStripButton_Unit_Add,
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_UNIT')">
            ToolStripButton_Unit_Edit,
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_UNIT')">
            ToolStripButton_Unit_Remove,
            </sec:authorize>

            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Unit_Refresh,
                ]
            })

        ]
    });

    var HLayout_Actions_Unit = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Unit
        ]
    });

    var RestDataSource_Unit = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='unit.nameFa'/> "
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='unit.nameEN'/> "
                },
                {
                    name: "symbol",
                    title: "<spring:message code='unit.symbol'/>"
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>"
                }],
            fetchDataURL: "${contextPath}/api/unit/spec-list"
        });

    var ListGrid_Unit = isc.ListGrid.create({
        showFilterEditor: true,
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Unit,
        contextMenu: Menu_ListGrid_Unit,
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "nameFA",
            title: "<spring:message code='unit.nameFa'/> ",
            align: "center"
        }, {
            name: "nameEN",
            title: "<spring:message code='unit.nameEN'/> ",
            align: "center"
        }, {
            name: "symbol",
            title: "<spring:message code='unit.symbol'/>",
            align: "center"
        }, {
            name: "decimalDigit",
            title: "<spring:message code='rate.decimalDigit'/>",
            align: "center"
        }],
        autoFetchData: true
    });

    var HLayout_Grid_Unit = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Unit
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Actions_Unit, HLayout_Grid_Unit
        ]
    });