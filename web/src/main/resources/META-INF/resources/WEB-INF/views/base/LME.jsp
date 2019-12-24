<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    function ListGrid_LME_refresh() {
        ListGrid_LME.invalidateCache();
    }

    function ListGrid_LME_edit() {
        var record = ListGrid_LME.getSelectedRecord();

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
            DynamicForm_LME.editRecord(record);
            DynamicForm_LME.setValue("lmeDate", new Date(record.lmeDate));
            Window_LME.show();
        }
    }

    function ListGrid_LME_remove() {

        var record = ListGrid_LME.getSelectedRecord();

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
                buttons: [isc.IButtonSave.create({
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var LMEId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/LME/" + LMEId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_LME_refresh();
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
    var Menu_ListGrid_LME = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_LME_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_LME.clearValues();
                    Window_LME.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_LME_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_LME_remove();
                }
            },
            {isSeparator: true}

        ]
    });

    var DynamicForm_LME = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: 100,
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 1,
        fields:
            [
                {name: "id", hidden: true , },
                {type: "RowSpacerItem"},
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "cuUsdMt",
                    title: "<spring:message code='LME.cuUsdMt'/>",
                    width: 480,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "goldUsdOunce",
                    title: "<spring:message code='LME.goldUsdOunce'/>",
                    width: 480,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true, required:true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "silverUsdOunce",
                    title: "<spring:message code='LME.silverUsdOunce'/>",
                    width: 480,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    validators: [{
                        type: "isFloat", required:true,
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "seleniumUsdLb",
                    title: "<spring:message code='LME.seleniumUsdLb'/>",
                    width: 480,
                    keyPressFilter: "[0-9.]",
                    length: "15", required:true,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "platinumUsdOunce",
                    title: "<spring:message code='LME.platinumUsdOunce'/>",
                    width: 480,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "palladiumUsdOunce",
                    title: "<spring:message code='LME.palladiumUsdOunce'/>",
                    width: 480,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "molybdenumUsdLb",
                    title: "<spring:message code='LME.molybdenumUsdLb'/>",
                    width: 480,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "lmeDate", title: "<spring:message code='LME.LMEDate'/>", width: 480, type: "date" , required: true,},
                {type: "RowSpacerItem"}
            ]
    });


    var ToolStripButton_LME_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_LME_refresh();
        }
    });

    var ToolStripButton_LME_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_LME.clearValues();
            Window_LME.show();
        }
    });

    var ToolStripButton_LME_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_LME.clearValues();
            ListGrid_LME_edit();
        }
    });

    var ToolStripButton_LME_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_LME_remove();
        }
    });

    <%--var ToolStripButton_LME_Print = isc.ToolStripButton.create({--%>
    <%--icon: "[SKIN]/RichTextEditor/print.png",--%>
    <%--title: "<spring:message code='global.form.print'/>",--%>
    <%--click: function()--%>
    <%--{--%>
    <%--window.open( "/LME/print/pdf");--%>
    <%--}--%>
    <%--});--%>

    var ToolStrip_Actions_LME = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_LME_Add,
                ToolStripButton_LME_Edit,
                ToolStripButton_LME_Remove,
                isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_LME_Refresh,
                ]
                })

                <%--ToolStripButton_LME_Print--%>
            ]
    });

    var HLayout_LME_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_LME
            ]
    });
    var RestDataSource_LME = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "cuUsdMt", title: "<spring:message code='LME.cuUsdMt'/>", width: 200},
                {name: "lmeDate", title: "<spring:message code='LME.LMEDate'/>", width: 200},
                {name: "goldUsdOunce", title: "<spring:message code='LME.goldUsdOunce'/>", width: 200},
                {name: "silverUsdOunce", title: "<spring:message code='LME.silverUsdOunce'/>", width: 200},
                {name: "seleniumUsdLb", title: "<spring:message code='LME.seleniumUsdLb'/>", width: 200},
                {name: "platinumUsdOunce", title: "<spring:message code='LME.platinumUsdOunce'/>", width: 200},
                {name: "palladiumUsdOunce", title: "<spring:message code='LME.palladiumUsdOunce'/>", width: 200},
                {name: "molybdenumUsdLb", title: "<spring:message code='LME.molybdenumUsdLb'/>", width: 200}
            ],
        fetchDataURL: "${contextPath}/api/LME/spec-list"
    });
    var IButton_LME_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_LME.validate();
            if (DynamicForm_LME.hasErrors())
                return;
            var d = DynamicForm_LME.getValue("lmeDate");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
            DynamicForm_LME.setValue("lmeDate", datestring)

            var data = DynamicForm_LME.getValues();
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/LME/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_LME_refresh();
                            Window_LME.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });
    var Window_LME = isc.Window.create({
        title: "<spring:message code='LME.title'/> ",
        width: 580,
        // height: 450,
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
                DynamicForm_LME,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_LME_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                ID: "LMEEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_LME.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_LME = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_LME,
        contextMenu: Menu_ListGrid_LME,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "lmeDate", title: "<spring:message code='LME.LMEDate'/>", width: "10%", align: "center"},
                {name: "cuUsdMt", title: "<spring:message code='LME.cuUsdMt'/>", width: "10%", align: "center"},
                {
                    name: "goldUsdOunce",
                    title: "<spring:message code='LME.goldUsdOunce'/>",
                    width: "10%",
                    align: "center"
                },
                {
                    name: "silverUsdOunce",
                    title: "<spring:message code='LME.silverUsdOunce'/>",
                    width: "10%",
                    align: "center"
                },
                {
                    name: "seleniumUsdLb",
                    title: "<spring:message code='LME.seleniumUsdLb'/>",
                    width: "15%",
                    align: "center"
                },
                {
                    name: "platinumUsdOunce",
                    title: "<spring:message code='LME.platinumUsdOunce'/>",
                    width: "20%",
                    align: "center"
                },
                {
                    name: "palladiumUsdOunce",
                    title: "<spring:message code='LME.palladiumUsdOunce'/>",
                    width: "20%",
                    align: "center"
                },
                {
                    name: "molybdenumUsdLb",
                    title: "<spring:message code='LME.molybdenumUsdLb'/>",
                    width: "15%",
                    align: "center"
                }
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            ListGrid_LMEFeature.fetchData({"lME.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_LMEFeature.setData(data);
            }, {operationId: "00"});
        },
        dataArrived: function (startRow, endRow) {
        }

    });
    var HLayout_LME_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_LME
        ]
    });

    var VLayout_LME_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_LME_Actions, HLayout_LME_Grid
        ]
    });


