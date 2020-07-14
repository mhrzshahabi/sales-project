<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Parameters = isc.MyRestDataSource.create(
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
                    name: "paramName",
                    title: "<spring:message code='parameters.paramName'/>",
                    width: 200
                },
                {
                    name: "paramValue",
                    title: "<spring:message code='parameters.paramValue.c'/>",
                    width: 200
                },
                {
                    name: "materialId",
                    title: "<spring:message code='parameters.paramValue'/>",
                    width: 200
                },
                {
                    name: "categoryValue",
                    title: "<spring:message code='parameters.paramValue.d'/>",
                    width: 200
                }],

            fetchDataURL: "${contextPath}/api/parameters/spec-list"
        });

    function ListGrid_Parameters_refresh() {
        ListGrid_Parameters.invalidateCache();
    }

    function ListGrid_Parameters_edit() {
        var record = ListGrid_Parameters.getSelectedRecord();

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
            DynamicForm_Parameters.editRecord(record);
            Window_Parameters.show();
        }
    }

    function ListGrid_Parameters_remove() {

        var record = ListGrid_Parameters.getSelectedRecord();

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
        } else {
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
                            var parametersId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/parameters/" + parametersId,
                                    httpMethod: "DELETE",
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {

                                            ListGrid_Parameters.invalidateCache();
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                        } else {
                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                        }
                                    }
                                }));
                        }
                    }
                });
        }
    }

    var Menu_ListGrid_Parameters = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Parameters_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_PARAMETERS')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Parameters.clearValues();
                    Window_Parameters.show();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_PARAMETERS')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Parameters_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_PARAMETERS')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Parameters_remove();
                }
            }
            </sec:authorize>
        ]
    });

    var DynamicForm_Parameters = isc.DynamicForm.create({
        width: 650,
        height: 100,
        titleWidth: "100",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true,},
                {
                    name: "paramName",
                    title: "<spring:message code='parameters.paramName'/>",
                    width: 500,
                    required: true,
                    type: "text",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "materialId",
                    title: "<spring:message	code='parameters.paramValue.c'/>",
                    width: 500,
                    type: "select",
                    required: true,
                    valueMap: {"1": "MOLYBDENUM OXIDE", "2": "COPPER CATHODES", "3": "COPPER CONCENTRATES"},
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "categoryValue",
                    title: "<spring:message	code='parameters.paramValue.d'/>",
                    width: 500,
                    type: "text",
                    required: true,
                    valueMap: {
                        "1": "Unit",
                        "2": "Time",
                        "3": "Financial",
                        "-2": "BANK REFERENCE"
                    },
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "paramValue", title: "<spring:message	code='parameters.paramValue.c'/>",
                    width: 500, type: "textArea", required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                }
            ]
    });

    var ToolStripButton_Parameters_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Parameters_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_PARAMETERS')">
    var ToolStripButton_Parameters_Add = isc.ToolStripButtonAdd.create({
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Parameters.clearValues();
            Window_Parameters.show();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_PARAMETERS')">
    var ToolStripButton_Parameters_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Parameters.clearValues();
            ListGrid_Parameters_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_PARAMETERS')">
    var ToolStripButton_Parameters_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Parameters_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_Parameters = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <sec:authorize access="hasAuthority('C_PARAMETERS')">
                ToolStripButton_Parameters_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_PARAMETERS')">
                ToolStripButton_Parameters_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_PARAMETERS')">
                ToolStripButton_Parameters_Remove,
                </sec:authorize>

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_Parameters_Refresh,
                    ]
                })

            ]
    });

    var HLayout_Parameters_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Parameters
            ]
    });

    var IButton_Parameters_Save = isc.IButtonSave.create(
        {
            top: 260,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {
                /*ValuesManager_GoodsUnit.validate();*/
                DynamicForm_Parameters.validate();
                if (DynamicForm_Parameters.hasErrors())
                    return;

                var data = DynamicForm_Parameters.getValues();
                var method = "PUT";
                if (data.id == null)
                    method = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/parameters",
                        httpMethod: method,
                        data: JSON.stringify(data),
                        callback: function (RpcResponse_o) {
                            if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {

                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_Parameters_refresh();
                                Window_Parameters.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        }
                    }))
            }
        });

    var ParametersCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_Parameters.close();
        }
    });

    var HLayout_Parameters_IButton = isc.HLayout.create({
        width: 650,
        height: "100%",
        layoutMargin: 10,
        membersMargin: 5,
        textAlign: "center",
        align: "center",
        members: [
            IButton_Parameters_Save,
            ParametersCancelBtn
        ]
    });


       var VLayout_saveButton_parameter = isc.VLayout.create({
        width: 650,
        textAlign: "center",
        align: "center",
        members: [
        HLayout_Parameters_IButton
        ]
    });



    var Window_Parameters = isc.Window.create(
        {
            title: "<spring:message code='parameters.title'/> ",
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
            items: [
                DynamicForm_Parameters,
                VLayout_saveButton_parameter
            ]
        });

    var ListGrid_Parameters = isc.ListGrid.create(
        {
            showFilterEditor: true,
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Parameters,
            contextMenu: Menu_ListGrid_Parameters,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "paramName",
                    title: "<spring:message code='parameters.paramName'/>",
                    width: "20%",
                    align: "center"
                },

                {
                    name: "paramValue",
                    title: "<spring:message code='parameters.paramValue.c'/>",
                    width: "50%",
                    align: "center"
                },{
                    name: "categoryValue",
                    title: "<spring:message	code='parameters.paramValue.d'/>",
                    width: "15%",
                    type: "text",
                    required: true,
                    valueMap: {
                        "1": "Unit",
                        "2": "Time",
                        "3": "Financial",
                        "-2": "BANK REFERENCE"
                    }
                },{
                    name: "materialId",
                    title: "<spring:message	code='parameters.paramValue'/>",
                    width: "15%",
                    type: "select",
                    required: true,
                    valueMap: {"1": "MOLYBDENUM OXIDE", "3": "COPPER CONCENTRATES", "2": "COPPER CATHODES"}
                }],
            autoFetchData: true
        });

    var HLayout_Parameters_Grid = isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                ListGrid_Parameters
            ]
        });
    isc.VLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                HLayout_Parameters_Actions, HLayout_Parameters_Grid
            ]
        });