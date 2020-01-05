<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    var Menu_ListGrid_Feature = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Feature_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Feature.clearValues();
                    Window_Feature.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Feature_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Feature_remove();
                }
            }
        ]
    });

    var ValuesManager_Feature = isc.ValuesManager.create({});
    var DynamicForm_Feature = isc.DynamicForm.create({
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
        numCols: 2,

        fields: [
            {name: "id", hidden: true, showIf:"false",},
            {type: "RowSpacerItem"},
            {
                name: "code", title: "<spring:message code='feature.code'/>", type: 'text', required: true, width: 500, showIf:"false",
                keyPressFilter: "[0-9]", length: "100",
            },
            {
                name: "nameFA",
                title: "<spring:message code='feature.nameFa'/>",
                required: true,
                readonly: true,
                width: 500,
                length: "100"
            },
            {
                name: "nameEN",
                title: "<spring:message code='feature.nameEN'/>",
                type: 'text',
                width: 500,
                required: true,
                length: "100"
            },
            {name: "symbol", title: "<spring:message code='feature.symbol'/>", type: 'text', width: 500},

            {
                name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>", width: 500,
                keyPressFilter: "[0-4]", length: "4",
                /*Add Hint */
                hint: "<spring:message code='deghat.ashar'/>",
                showHintInField: true,
                /*End Hint*/
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"

                }]
            },
            {type: "RowSpacerItem"},
        ]
    });


    var IButton_Feature_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            ValuesManager_Feature.validate();
            DynamicForm_Feature.validate();
            if (DynamicForm_Feature.hasErrors()) {
                return;
            }
            var data = DynamicForm_Feature.getValues();
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/feature/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_Feature_refresh();
                            Window_Feature.close();
                        } else {
                            isc.say(RpcResponse_o.data);
                        }
                    }
                })
            );
        }
    });


    var Window_Feature = isc.Window.create({
        title: "<spring:message code='feature.title'/>",
        width: 700,
        height: 310,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        margin: '15px',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                DynamicForm_Feature,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_Feature_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                ID: "featureEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Feature.close();
                                }
                            })
                        ]
                })
            ]
    });

    function ListGrid_Feature_refresh() {
        ListGrid_Feature.invalidateCache();
    }

    function ListGrid_Feature_remove() {

        var record = ListGrid_Feature.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
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
                buttons: [isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}), isc.IButtonCancel.create({
                    title: "<spring:message  code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index === 0) {

                        var featureId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/feature/" + featureId,
                                httpMethod: "DELETE",
                                serverOutputAsString: false,
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                        ListGrid_Feature.invalidateCache();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
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

    function ListGrid_Feature_edit() {

        var record = ListGrid_Feature.getSelectedRecord();

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
            DynamicForm_Feature.editRecord(record);
            Window_Feature.show();
        }
    }


    var ToolStripButton_Feature_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Feature_refresh();
        }
    });

    var ToolStripButton_Feature_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Feature.clearValues();
            Window_Feature.show();
        }
    });

    var ToolStripButton_Feature_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Feature.clearValues();
            ListGrid_Feature_edit();
        }
    });


    var ToolStripButton_Feature_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Feature_remove();
        }
    });
    var ToolStrip_Actions_Feature = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_Feature_Add,
            ToolStripButton_Feature_Edit,
            ToolStripButton_Feature_Remove,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Feature_Refresh,
                ]
            })

        ]
    });

    var HLayout_Actions_Feature = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Feature
        ]
    });

    var RestDataSource_Feature = isc.MyRestDataSource.create(
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
                    title: "<spring:message code='feature.code'/> "
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='feature.nameFa'/> "
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='feature.nameEN'/> "
                },
                {
                    name: "symbol",
                    title: "<spring:message code='feature.symbol'/>"
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>"
                }],
            fetchDataURL: "${contextPath}/api/feature/spec-list"
        });


    var ListGrid_Feature = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Feature,
            contextMenu: Menu_ListGrid_Feature,
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
                    title: "<spring:message code='feature.code'/> ",
                    align: "center" , showIf:"false",
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='feature.nameFa'/> ",
                    align: "center"
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='feature.nameEN'/> ",
                    align: "center"
                },
                {
                    name: "symbol",
                    title: "<spring:message code='feature.symbol'/>",
                    align: "center"
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>",
                    align: "center"
                }],
            sortField: 0,
            dataPageSize: 50,
            autoFetchData: true,
            showFilterEditor: true,
            filterOnKeypress: true,
            startsWithTitle: "tt"
        });


    var HLayout_Grid_Feature = isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                ListGrid_Feature
            ]
        });

    var VLayout_Body_Feature = isc.VLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                HLayout_Actions_Feature, HLayout_Grid_Feature
            ]
        });