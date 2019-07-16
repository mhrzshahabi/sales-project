<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

    function ThousandSeparate1(item)
    {
        var V = item;
        V = V.replace(/,/g,'');
        var R = new RegExp('(-?[0-9]+)([0-9]{3})');
        while(R.test(V))
        {
            V = V.replace(R, '$1,$2');
        }
        return V;
    }


    <spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

    var RestDataSource_Port = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "beam", title: "<spring:message code='port.port'/>", width: 200},
                {name: "loa", title: "<spring:message code='port.port'/>", width: 200},
                {name: "arrival", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],

        fetchDataURL: "${restApiUrl}/api/port/spec-list"
    });
    var RestDataSource_CountryPort = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "nameFa", title: "<spring:message code='country.nameFa'/>", width: 200},
                {name: "nameEn", title: "<spring:message code='country.nameEn'/>", width: 200},
                {name: "isActive", title: "<spring:message code='country.isActive'/>", width: 200}
            ],

        fetchDataURL: "${restApiUrl}/api/country/spec-list"
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
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var PortId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "${restApiUrl}/api/port/" + PortId,
                            httpMethod: "DELETE",
                            httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                    ListGrid_Port_refresh();
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
    var Menu_ListGrid_Port = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Port_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Port.clearValues();
                    Window_Port.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Port_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Port_remove();
                }
            }
        ]
    });

    var DynamicForm_Port = isc.DynamicForm.create({
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
        fields:
            [
                {name: "id", hidden: true,},
                {
                    name: "port",
                    title: "<spring:message code='port.port'/>",
                    width: "100%",  required: true ,
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "loa",
                    title: "<spring:message code='port.loa'/>",
                    width: "100%",
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false,
                    change :function (form, item, value, oldValue){item.setValue(ThousandSeparate1(value));},
                    keyPressFilter :  "[0-9.]",
format : "[0-9]+(\.[0-9][0-9][0-9])"
                },
                {
                    name: "beam",
                    title: "<spring:message code='port.beam'/>",
                    width: "100%",
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false,
                    change :function (form, item, value, oldValue){item.setValue(ThousandSeparate1(value));},
                    keyPressFilter :  "[0-9.]"
                },
                {
                    name: "arrival",
                    title: "<spring:message code='port.arrival'/>",
                    width: "100%",
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false,
                    change :function (form, item, value, oldValue){item.setValue(ThousandSeparate1(value));},
                    keyPressFilter : "[0-9]+(\.[0-9][0-9][0-9])"
                },
                {
                    name: "countryId",
                    title: "<spring:message code='country.nameFa'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    colSpan: 1,
                    titleColSpan: 1
                    ,
                    optionDataSource: RestDataSource_CountryPort,
                    displayField: "nameFa",
                    wrapTitle: false,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListheight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [
                        {name: "id", width: 50, align: "center"},
                        {name: "nameFa", width: 150, align: "center"},
                        {name: "nameEn", width: 150, align: "center"},
                        {name: "isActive", width: 150, align: "center"}

                    ]
                }
            ]
    });

    var ToolStripButton_Port_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Port_refresh();
        }
    });

    var ToolStripButton_Port_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Port.clearValues();
            Window_Port.show();
        }
    });

    var ToolStripButton_Port_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Port_edit();
        }
    });

    var ToolStripButton_Port_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Port_remove();
        }
    });

    var ToolStrip_Actions_Bank = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Port_Refresh,
                ToolStripButton_Port_Add,
                ToolStripButton_Port_Edit,
                ToolStripButton_Port_Remove
            ]
    });

    var HLayout_Port_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Bank
            ]
    });

    var IButton_Port_Save = isc.IButton.create({
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
            isc.RPCManager.sendRequest({
                actionURL: "${restApiUrl}/api/port/",
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
                        ListGrid_Port_refresh();
                        Window_Port.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });

    var InstructionCancelBtn = isc.IButton.create({
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
        height: 500,
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
    var ListGrid_Port = isc.MyListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Port,
        contextMenu: Menu_ListGrid_Port,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: "50%", align: "center"},
                {name: "loa", title: "<spring:message code='port.loa'/>", width: "50%", align: "center"},
                {name: "beam", title: "<spring:message code='port.beam'/>", width: "50%", align: "center"},
                {name: "arrival", title: "<spring:message code='port.arrival'/>", width: "50%", align: "center"},
                {
                    name: "country.nameFa",
                    title: "<spring:message code='country.nameFa'/>",
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
        },
        dataArrived: function (startRow, endRow) {
        }

    });
    var HLayout_Port_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Port
        ]
    });

    var VLayout_Port_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Port_Actions, HLayout_Port_Grid
        ]
    });


