<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <%--<spring:eval var="contextPath" expression="@environment.getProperty('nicico.rest-api.url')"/>--%>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    function ListGrid_CurrencyRate_refresh() {
        ListGrid_CurrencyRate.invalidateCache();
    }

    function ListGrid_CurrencyRate_edit() {
        var record = ListGrid_CurrencyRate.getSelectedRecord();

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
            DynamicForm_CurrencyRate.editRecord(record);
            DynamicForm_CurrencyRate.setValue("curDateDummy", new Date(record.curDate));
            Window_CurrencyRate.show();
        }
    }

    function ListGrid_CurrencyRate_remove() {

        var record = ListGrid_CurrencyRate.getSelectedRecord();

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
                buttons: [isc.Button.create({
                    title: "<spring:message	code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var currencyRateId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "${contextPath}/api/currencyRate/" + currencyRateId,
                            httpMethod: "DELETE",
                            httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                    ListGrid_CurrencyRate_refresh();
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            }
                        });
                    }
                }
            });
        }
    };
    var Menu_ListGrid_CurrencyRate = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_CurrencyRate_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_CurrencyRate.clearValues();
                    Window_CurrencyRate.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_CurrencyRate_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_CurrencyRate_remove();
                }
            }
        ]
    });

    var DynamicForm_CurrencyRate = isc.DynamicForm.create({
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
        fields:
            [
                {name: "id", hidden: true,},
                {type: "RowSpacerItem"},
                {
                    name: "curDateDummy",
                    title: "<spring:message code='currencyRate.curDate'/>",
                    type: "date",
                    width: "400"
                },
                {
                    name: "irrUsd",
                    title: "<spring:message code='currencyRate.irrUsd'/>",
                    type: 'text',
                    width: "400",
                    keyPressFilter: "[0-9.]",
                    length: "15"
                },
                {
                    name: "eurUsd",
                    title: "<spring:message code='currencyRate.eurUsd'/>",
                    type: 'text',
                    width: "400",
                    keyPressFilter: "[0-9.]",
                    length: "15"
                },
                {
                    name: "aedUsd",
                    title: "<spring:message code='currencyRate.aedUsd'/>",
                    type: 'text',
                    width: "400",
                    keyPressFilter: "[0-9.]",
                    length: "15"
                },
                {
                    name: "rmbUsd",
                    title: "<spring:message code='currencyRate.rmbUsd'/>",
                    type: 'text',
                    width: "400",
                    keyPressFilter: "[0-9.]",
                    length: "15"
                },
                {type: "RowSpacerItem"}
            ]
    });

    var ToolStripButton_CurrencyRate_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_CurrencyRate_refresh();
        }
    });

    var ToolStripButton_CurrencyRate_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_CurrencyRate.clearValues();
            Window_CurrencyRate.show();
        }
    });

    var ToolStripButton_CurrencyRate_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_CurrencyRate.clearValues();
            ListGrid_CurrencyRate_edit();
        }
    });

    var ToolStripButton_CurrencyRate_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_CurrencyRate_remove();
        }
    });

    var ToolStrip_Actions_CurrencyRate = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_CurrencyRate_Refresh,
                ToolStripButton_CurrencyRate_Add,
                ToolStripButton_CurrencyRate_Edit,
                ToolStripButton_CurrencyRate_Remove
            ]
    });

    var HLayout_CurrencyRate_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_CurrencyRate
            ]
    });
    var RestDataSource_CurrencyRate = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "curDate",
                    title: "<spring:message code='currencyRate.curDate'/>",
                    width: "50%",
                    align: "center"
                },
                {name: "irrUsd", title: "<spring:message code='currencyRate.irrUsd'/>", width: "50%", align: "center"},
                {name: "eurUsd", title: "<spring:message code='currencyRate.eurUsd'/>", width: "50%", align: "center"},
                {name: "aedUsd", title: "<spring:message code='currencyRate.aedUsd'/>", width: "50%", align: "center"},
                {name: "rmbUsd", title: "<spring:message code='currencyRate.rmbUsd'/>", width: "50%", align: "center"}
            ],
        fetchDataURL: "${contextPath}/api/currencyRate/spec-list"
    });


    var IButton_CurrencyRate_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_CurrencyRate.validate();
            if (DynamicForm_CurrencyRate.hasErrors())
                return;
            var d = DynamicForm_CurrencyRate.getValue("curDateDummy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
            DynamicForm_CurrencyRate.setValue("curDate", datestring)

            var data = DynamicForm_CurrencyRate.getValues();
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest({
                actionURL: "${contextPath}/api/currencyRate/",
                httpMethod: methodXXXX,
                httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_CurrencyRate_refresh();
                        Window_CurrencyRate.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });
    var Window_CurrencyRate = isc.Window.create({
        title: "<spring:message code='exchangeRate.title'/> ",
        width: 580,
        height: 310,
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
                DynamicForm_CurrencyRate,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_CurrencyRate_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                ID: "currencyRateEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_CurrencyRate.close();
                                }
                            })
                        ]
                })

            ]
    });
    var ListGrid_CurrencyRate = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_CurrencyRate,
        contextMenu: Menu_ListGrid_CurrencyRate,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "curDate",
                    title: "<spring:message code='currencyRate.curDate'/>",
                    width: "50%",
                    align: "center"
                },
                {name: "irrUsd", title: "<spring:message code='currencyRate.irrUsd'/>", width: "50%", align: "center"},
                {name: "eurUsd", title: "<spring:message code='currencyRate.eurUsd'/>", width: "50%", align: "center"},
                {name: "aedUsd", title: "<spring:message code='currencyRate.aedUsd'/>", width: "50%", align: "center"},
                {name: "rmbUsd", title: "<spring:message code='currencyRate.rmbUsd'/>", width: "50%", align: "center"}
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            ListGrid_CurrencyRateFeature.fetchData({"currencyRate.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_CurrencyRateFeature.setData(data);
            }, {operationId: "00"});
        },
        dataArrived: function (startRow, endRow) {
        }

    });
    var HLayout_CurrencyRate_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_CurrencyRate
        ]
    });

    var VLayout_CurrencyRate_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_CurrencyRate_Actions, HLayout_CurrencyRate_Grid
        ]
    });

