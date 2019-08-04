<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

    var RestDataSource_Country = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='country.code'/>", width: 200},
                {name: "nameFa", title: "<spring:message code='country.nameFa'/>", width: 200},
                {name: "nameEn", title: "<spring:message code='country.nameEn'/>", width: 200},
            ],

        fetchDataURL: "${restApiUrl}/api/country/spec-list"
    });

    function ListGrid_Country_refresh() {
        ListGrid_Country.invalidateCache();
    }

    function ListGrid_Country_edit() {
        var record = ListGrid_Country.getSelectedRecord();

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
            DynamicForm_Country.editRecord(record);
            Window_Country.show();
        }
    }

    function ListGrid_Country_remove() {

        var record = ListGrid_Country.getSelectedRecord();

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
                        var CountryId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "${restApiUrl}/api/country/" + record.id,
                            httpMethod: "DELETE",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (resp) {
                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                    ListGrid_Country_refresh();
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
    var Menu_ListGrid_Country = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Country_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Country.clearValues();
                    Window_Country.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Country_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Country_remove();
                }
            }
        ]
    });

    var DynamicForm_Country = isc.DynamicForm.create({
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
                {type: "RowSpacerItem"},
                {
                    name: "code",
                    title: "<spring:message code='country.code'/>",
                    width: "100%",
                    colSpan: 1, required: true,
                    keyPressFilter: "[0-9]", length: "15",
                    titleColSpan: 1
                },
                {
                    name: "nameFa",
                    title: "<spring:message code='country.nameFa'/>",
                    width: "100%",
                    colSpan: 1, required: true,
                    titleColSpan: 1
                },
                {
                    name: "nameEn",
                    title: "<spring:message code='country.nameEn'/>",
                    width: "100%",
                    colSpan: 1, required: true, keyPressFilter: "[a-z|A-Z|0-9.]",
                    titleColSpan: 1
                },
            ]
    });

    var ToolStripButton_Country_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Country_refresh();
        }
    });

    var ToolStripButton_Country_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Country.clearValues();
            Window_Country.show();
        }
    });

    var ToolStripButton_Country_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Country.clearValues();
            ListGrid_Country_edit();
        }
    });

    var ToolStripButton_Country_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Country_remove();
        }
    });

    var ToolStrip_Actions_Country = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Country_Refresh,
                ToolStripButton_Country_Add,
                ToolStripButton_Country_Edit,
                ToolStripButton_Country_Remove
            ]
    });

    var HLayout_Country_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Country
            ]
    });

    var IButton_Country_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_Country.validate();
            if (DynamicForm_Country.hasErrors())
                return;
            var data = DynamicForm_Country.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest({
                actionURL: "${restApiUrl}/api/country/",
                httpMethod: method,
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                showPrompt: true,
                serverOutputAsString: false,
                data: JSON.stringify(data),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_Country_refresh();
                        Window_Country.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });

    var CountryCancelBtn = isc.IButton.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_Country.close();
        }
    });

    var HLayout_Country_IButton = isc.HLayout.create({
        layoutMargin: 5,
        membersMargin: 5,
        width: "100%",
        members: [
            IButton_Country_Save,
            CountryCancelBtn
        ]
    });


    var Window_Country = isc.Window.create({
        title: "<spring:message code='country.title'/> ",
        width: 580,
        // height: 500,
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
                DynamicForm_Country,
                HLayout_Country_IButton
            ]
    });
    var ListGrid_Country = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Country,
        contextMenu: Menu_ListGrid_Country,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='country.code'/>", width: "10%", align: "center"},
                {name: "nameFa", title: "<spring:message code='country.nameFa'/>", width: "10%", align: "center"},
                {name: "nameEn", title: "<spring:message code='country.nameEn'/>", width: "10%", align: "center"},
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
// ListGrid_CountryFeature.fetchData({"tblCountry.id":record.id},function (dsResponse, data, dsRequest) {
// ListGrid_CountryFeature.setData(data);
// },{operationId:"00"});
        },
        dataArrived: function (startRow, endRow) {
        }

    });
    var HLayout_Country_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Country
        ]
    });

    var VLayout_Country_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Country_Actions, HLayout_Country_Grid
        ]
    });


