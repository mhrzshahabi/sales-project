<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var Menu_ListGrid_Rate = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Rate_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_RATE')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Rate.clearValues();
                    Window_Rate.show();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_RATE')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Rate_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_RATE')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Rate_remove();
                }
            }
            </sec:authorize>
        ]
    });

    var ValuesManager_Rate = isc.ValuesManager.create({});


    var DynamicForm_Rate = isc.DynamicForm.create(
        {
            width: "100%",
            height: "100%",
            align: "center",
            titleWidth: "100",
            requiredMessage: "<spring:message code='validator.field.is.required'/>",
            numCols: 2,

            fields: [
                {
                    name: "id",
                    hidden: true, showIf: "false",
                },
                {
                    type: "RowSpacerItem"
                },
                {
                    name: "code",
                    title: "<spring:message code='rate.code'/>",
                    type: 'text',
                    required: true,
                    width: 300,
                    keyPressFilter: "[0-9]",
                    length: "15", showIf: "false",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='rate.nameFa'/>",
                    required: true,
                    readonly: true,
                    width: 300,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='rate.nameEN'/>",
                    type: 'text',
                    width: 300,
                    required: true,
                    keyPressFilter: "[a-z|A-Z|0-9.]",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "symbol",
                    title: "<spring:message code='feature.symbol'/>",
                    type: 'text',
                    width: 300
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>",
                    width: 300,
                    keyPressFilter: "[0-4]",
                    length: "1",
                    hint: "<spring:message code='deghat.ashar.cu'/>",
                    showHintInField: true,
                    validators: [
                        {
                            type: "isInteger",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    type: "RowSpacerItem"
                },
            ]
        });


    var IButton_Rate_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            ValuesManager_Rate.validate();
            DynamicForm_Rate.validate();
            if (DynamicForm_Rate.hasErrors()) {
                return;
            }
            var data = DynamicForm_Rate.getValues();
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/rate/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_Rate_refresh();
                            Window_Rate.close();
                        } else {
                            isc.say(RpcResponse_o.data);
                        }
                    }
                })
            );
        }
    });


    var Window_Rate = isc.Window.create({
        title: "<spring:message code='rate.title'/> ",
        width: 580,
        height: 300,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        margin: "30px",
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            DynamicForm_Rate,

            isc.HLayout.create({
               margin: '10px',
                padding: 10,
               layoutMargin: 10,
               membersMargin: 5,
               align: "center",
               width: "100%",
                members:
                    [
                        IButton_Rate_Save,
                        isc.Label.create({
                            width: 5,
                        }),
                        isc.IButtonCancel.create({
                            title: "<spring:message code='global.cancel'/>",
                            width: 100,
                            icon: "pieces/16/icon_delete.png",
                            orientation: "vertical",
                            click: function () {
                                Window_Rate.close();
                            }
                        })
                    ]
            })
        ]
    });

    function ListGrid_Rate_refresh() {
        ListGrid_Rate.invalidateCache();
    }

    function ListGrid_Rate_remove() {

        var record = ListGrid_Rate.getSelectedRecord();

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

                            var rateId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/rate/" + rateId,
                                    httpMethod: "DELETE",
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                            ListGrid_Rate.invalidateCache();
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

    function ListGrid_Rate_edit() {
        var record = ListGrid_Rate.getSelectedRecord();

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
            DynamicForm_Rate.editRecord(record);
            Window_Rate.show();
        }
    }


    var ToolStripButton_Rate_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Rate_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_RATE')">
    var ToolStripButton_Rate_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Rate.clearValues();
            Window_Rate.show();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_RATE')">
    var ToolStripButton_Rate_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Rate.clearValues();
            ListGrid_Rate_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_RATE')">
    var ToolStripButton_Rate_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Rate_remove();
        }
    });
    </sec:authorize>


    var ToolStrip_Actions_Rate = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <sec:authorize access="hasAuthority('C_RATE')">
                ToolStripButton_Rate_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_RATE')">
                ToolStripButton_Rate_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_RATE')">
                ToolStripButton_Rate_Remove,
                </sec:authorize>

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_Rate_Refresh,
                    ]
                })
            ]
    });

    var HLayout_Actions_Rate = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Rate
        ]
    });

    var RestDataSource_Rate = isc.MyRestDataSource.create(
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
                    name: "code",
                    title: "<spring:message code='rate.code'/> "
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='rate.nameFa'/> "
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='rate.nameEN'/> "
                },
                {
                    name: "symbol",
                    title: "<spring:message code='rate.symbol'/>"
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>"
                }],
            fetchDataURL: "${contextPath}/api/rate/spec-list"
        });

    var ListGrid_Rate = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Rate,
            contextMenu: Menu_ListGrid_Rate,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='rate.code'/> ",
                    align: "center", showIf: "false",
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='rate.nameFa'/> ",
                    align: "center"
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='rate.nameEN'/> ",
                    align: "center"
                },
                {
                    name: "symbol",
                    title: "<spring:message code='rate.symbol'/>",
                    align: "center"
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>",
                    align: "center"
                }

            ],
            autoFetchData: true
        });


    var HLayout_Grid_Rate = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Rate
        ]
    });

    var VLayout_Body_Rate = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Actions_Rate, HLayout_Grid_Rate
        ]
    });
