<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Port = isc.MyRestDataSource.create(
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
                    name: "port",
                    title: "<spring:message code='port.port'/>",
                    width: 200
                },
                {
                    name: "beam",
                    title: "<spring:message code='port.port'/>",
                    width: 200
                },
                {
                    name: "loa",
                    title: "<spring:message code='port.port'/>",
                    width: 200
                },
                {
                    name: "arrival",
                    title: "<spring:message code='port.port'/>",
                    width: 200
                },
                {
                    name: "country.nameFa",
                    title: "<spring:message code='country.nameFa'/>",
                    width: 200
                }],

            fetchDataURL: "${contextPath}/api/port/spec-list"
        });

    var RestDataSource_CountryPort = isc.MyRestDataSource.create(
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
                    name: "nameFa",
                    title: "<spring:message code='country.nameFa'/>",
                    width: 200
                },
                {
                    name: "nameEn",
                    title: "<spring:message code='country.nameEn'/>",
                    width: 200
                },
                {
                    name: "isActive",
                    title: "<spring:message code='country.isActive'/>",
                    width: 200
                }],

            fetchDataURL: "${contextPath}/api/country/spec-list"
        });

    function ListGrid_Port_refresh() {
        ListGrid_Port.invalidateCache();
    }

    function ListGrid_Port_edit() {
        var record = ListGrid_Port.getSelectedRecord();

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
            DynamicForm_Port.editRecord(record);
            Window_Port.show();
        }
    }

    function ListGrid_Port_remove() {
        var record = ListGrid_Port.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
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
                            var PortId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/port/" + PortId,
                                    httpMethod: "DELETE",
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                            ListGrid_Port_refresh();
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

    var Menu_ListGrid_Port = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Port_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_PORT')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Port.clearValues();
                    Window_Port.show();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_PORT')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Port_edit();
                }
            },
            </sec:authorize>
            <sec:authorize access="hasAuthority('D_PORT')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Port_remove();
                }
            }
            </sec:authorize>
        ]
    });

    var DynamicForm_Port = isc.DynamicForm.create({
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
                {
                    name: "port",
                    title: "<spring:message code='port.port'/>",
                    width: 450, required: true, length: "4000",
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "loa",
                    title: "<spring:message code='port.loa'/>",
                    width: 450,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false,
                    keyPressFilter: "[0-9.]", length: "100",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    textAlign: "left"
                },
                {
                    name: "beam",
                    title: "<spring:message code='port.beam'/>",
                    width: 450,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false,
                    length: "100",
                    textAlign: "left"
                },
                {
                    name: "arrival",
                    title: "<spring:message code='port.arrival'/>",
                    width: 450,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false,
                    keyPressFilter: "[0-9.]", length: "100",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    textAlign: "left"
                },
                {
                    name: "countryId",
                    title: "<spring:message code='country'/>",
                    type: 'long',
                    width: 450,
                    editorType: "SelectItem",
                    colSpan: 1, required: true,
                    titleColSpan: 1,
                    optionDataSource: RestDataSource_CountryPort,
                    displayField: "nameFa",
                    wrapTitle: false,
                    valueField: "id",
                    pickListWidth: 450,
                    pickListheight: 450,
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [
                        {name: "id", width: 50, align: "center", hidden: true},
                        {name: "nameFa", align: "center", width: "10%"},
                        {name: "nameEn", align: "center", width: "10%"},


                    ],
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                }
            ]
    });

    var ToolStripButton_Port_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Port_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_PORT')">
    var ToolStripButton_Port_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Port.clearValues();
            Window_Port.show();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_PORT')">
    var ToolStripButton_Port_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Port.clearValues();
            ListGrid_Port_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_PORT')">
    var ToolStripButton_Port_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Port_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_Bank = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <sec:authorize access="hasAuthority('C_PORT')">
                ToolStripButton_Port_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_PORT')">
                ToolStripButton_Port_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_PORT')">
                ToolStripButton_Port_Remove,
                </sec:authorize>

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_Port_Refresh,
                    ]
                })

            ]
    });

    var HLayout_Port_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Bank
            ]
    });

    var IButton_Port_Save = isc.IButtonSave.create(
        {
            top: 260,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {
                DynamicForm_Port.validate();
                if (DynamicForm_Port.hasErrors())
                    return;
                var data = DynamicForm_Port.getValues();
                var methodXXXX = "PUT";
                if (data.id == null) methodXXXX = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/port/",
                        httpMethod: methodXXXX,
                        data: JSON.stringify(data),
                        callback: function (RpcResponse_o) {
                            if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_Port_refresh();
                                Window_Port.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        }
                    }));
            }
        });

    var InstructionCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_Port.close();
        }
    });

    var HLayout_Port_IButton = isc.HLayout.create({
        layoutMargin: 5,
        membersMargin: 5,
        width: "100%",
        members: [
            IButton_Port_Save,
            InstructionCancelBtn
        ]
    });

    var Window_Port = isc.Window.create({
        title: "<spring:message code='port.port'/> ",
        width: 580,
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
                DynamicForm_Port,
                HLayout_Port_IButton
            ]
    });

    var ListGrid_Port = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Port,
            contextMenu: Menu_ListGrid_Port,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "port",
                    title: "<spring:message code='port.port'/>",
                    width: "50%",
                    align: "center"
                },
                {
                    name: "loa",
                    title: "<spring:message code='port.loa'/>",
                    width: "50%",
                    align: "center"
                },
                {
                    name: "beam",
                    title: "<spring:message code='port.beam'/>",
                    width: "50%",
                    align: "center"
                },
                {
                    name: "arrival",
                    title: "<spring:message code='port.arrival'/>",
                    width: "50%",
                    align: "center"
                },
                {
                    name: "country.nameFa",
                    title: "<spring:message code='country'/>",
                    width: "50%",
                    align: "center"
                }],
            sortField: 0,
            autoFetchData: true,
            showFilterEditor: true,
            filterOnKeypress: true
        });

    var HLayout_Port_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Port
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Port_Actions, HLayout_Port_Grid
        ]
    });