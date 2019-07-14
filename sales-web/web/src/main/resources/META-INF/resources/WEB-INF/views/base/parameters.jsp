<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


// <script>

    <spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

    var RestDataSource_Parameters = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "paramName", title: "<spring:message code='parameters.paramName'/>", width: 200},
                {name: "paramType", title: "<spring:message code='parameters.paramType'/>", width: 200},
                {name: "paramValue", title: "<spring:message code='parameters.paramValue'/>", width: 200}
            ],

        fetchDataURL: "${restApiUrl}/api/parameters/spec-list"
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
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [isc.Button.create({
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var parametersId = record.id;

                        isc.RPCManager.sendRequest({
                            actionURL: "${restApiUrl}/api/parameters/" + parametersId,
                            httpMethod: "DELETE",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {

                                    ListGrid_Parameters_refresh();
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
    var Menu_ListGrid_Parameters = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Parameters_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Parameters.clearValues();
                    Window_Parameters.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Parameters_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Parameters_remove();
                }
            }
        ]
    });

    var DynamicForm_Parameters = isc.DynamicForm.create({
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
        requiredMessage: "<spring:message code='validator.field.is.required'/>.",
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true,},
                {type: "RowSpacerItem"},
                {
                    name: "paramName",
                    title: "<spring:message code='parameters.paramName'/>",
                    width: "100%",
                    type: "text"
                },
                {
                    name: "paramType",
                    title: "<spring:message code='parameters.paramType'/>",
                    width: "100%",
                    type: "text"
                },
                {
                    name: "paramValue", title: "<spring:message	code='parameters.paramValue'/>",
                    width: "100%", type: "textArea"
                },
                {type: "RowSpacerItem"}
            ]
    });

    var ToolStripButton_Parameters_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Parameters_refresh();
        }
    });

    var ToolStripButton_Parameters_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Parameters.clearValues();
            Window_Parameters.show();
        }
    });

    var ToolStripButton_Parameters_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Parameters_edit();
        }
    });

    var ToolStripButton_Parameters_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Parameters_remove();
        }
    });

    var ToolStrip_Actions_Parameters = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Parameters_Refresh,
                ToolStripButton_Parameters_Add,
                ToolStripButton_Parameters_Edit,
                ToolStripButton_Parameters_Remove
            ]
    });

    var HLayout_Parameters_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Parameters
            ]
    });
    var IButton_Parameters_Save = isc.IButton.create({
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
            isc.RPCManager.sendRequest({
                actionURL: "${restApiUrl}/api/parameters",
                httpMethod: method,
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {

                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_Parameters_refresh();
                        Window_Parameters.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });

    var ParametersCancelBtn = isc.IButton.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        click: function () {
            Window_Parameters.close();
        }
    });

    var HLayout_Parameters_IButton = isc.HLayout.create({
        layoutMargin: 5,
        membersMargin: 5,
        width: "100%",
        members: [
            IButton_Parameters_Save,
            ParametersCancelBtn
        ]
    });


    var Window_Parameters = isc.Window.create({
        title: "<spring:message code='parameters.title'/> ",
        width: 580,
        hight: 500,
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
                DynamicForm_Parameters,
                HLayout_Parameters_IButton
            ]
    });
    var ListGrid_Parameters = isc.MyListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Parameters,
        contextMenu: Menu_ListGrid_Parameters,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "paramName",
                    title: "<spring:message code='parameters.paramName'/>",
                    width: "25%",
                    align: "center"
                },
                {
                    name: "paramType",
                    title: "<spring:message code='parameters.paramType'/>",
                    width: "25%",
                    align: "center"
                },
                {
                    name: "paramValue",
                    title: "<spring:message code='parameters.paramValue'/>",
                    width: "50%",
                    align: "center"
                }
            ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt",
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            ListGrid_ParametersFeature.fetchData({"tblParameters.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_ParametersFeature.setData(data);
            }, {operationId: "00"});
        },
        dataArrived: function (startRow, endRow) {
        }

    });
    var HLayout_Parameters_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Parameters
        ]
    });
    var VLayout_Parameters_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Parameters_Actions, HLayout_Parameters_Grid
        ]
    });



