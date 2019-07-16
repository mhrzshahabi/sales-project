<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

    <spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

    var RestDataSource_Bank = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "bankCode", title: "<spring:message code='bank.bankCode'/>", width: 200},
                {name: "bankName", title: "<spring:message code='bank.namefa'/>", width: 200},
                {name: "enBankName", title: "<spring:message code='bank.nameEn'/>", width: 200},
                {name: "address", title: "<spring:message code='bank.address'/>", width: 200},
                {name: "coreBranch", title: "<spring:message code='bank.coreBranch'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],

        fetchDataURL: "${restApiUrl}/api/bank/spec-list"
    });
    var RestDataSource_Country = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "nameFa", title: "<spring:message code='country.nameFa'/>", width: 200},
                {name: "nameEn", title: "<spring:message code='country.nameEn'/>", width: 200},
                {name: "isActive", title: "<spring:message code='country.isActive'/>", width: 200}
            ],
        fetchDataURL: "${restApiUrl}/api/country/spec-list"
    });

    function ListGrid_Bank_refresh() {
        ListGrid_Bank.invalidateCache();
    }

    function ListGrid_Bank_edit() {
        var record = ListGrid_Bank.getSelectedRecord();

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
            DynamicForm_Bank.editRecord(record);
            Window_Bank.show();
        }
    }

    function ListGrid_Bank_remove() {

        var record = ListGrid_Bank.getSelectedRecord();

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
                        var BankId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "${restApiUrl}/api/bank/" + record.id,
                            httpMethod: "DELETE",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (resp) {
                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                    ListGrid_Bank_refresh();
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
    var Menu_ListGrid_Bank = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Bank_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Bank.clearValues();
                    Window_Bank.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Bank_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Bank_remove();
                }
            }, {isSeparator: true},
            {
                title: "ارسال به Pdf", icon: "icon/pdf.png", click: function () {
                    "<spring:url value="/bank/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "ارسال به Excel", icon: "icon/excel.png", click: function () {
                    "<spring:url value="/bank/print/excel" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "ارسال به Html", icon: "icon/html.jpg", click: function () {
                    "<spring:url value="/bank/print/html" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }

        ]
    });

    var DynamicForm_Bank = isc.DynamicForm.create({
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
                    name: "bankCode",
                    title: "<spring:message code='bank.bankCode'/>",
                    width: "100%",
                    colSpan: 1, required: true,
                    titleColSpan: 1
                },
                {
                    name: "bankName",
                    title: "<spring:message code='bank.namefa'/>",
                    width: "100%",
                    colSpan: 1, required: true,
                    titleColSpan: 1
                },
                {
                    name: "enBankName",
                    title: "<spring:message code='bank.nameEn'/>",
                    width: "100%",
                    colSpan: 1, required: true,
                    titleColSpan: 1
                },
                {
                    name: "address",
                    title: "<spring:message code='bank.address'/>",
                    width: "100%",
                    colSpan: 1, required: true,
                    titleColSpan: 1
                },
                {
                    name: "coreBranch",
                    title: "<spring:message code='bank.coreBranch'/>",
                    width: 200,
                    colSpan: 1, required: true,
                    titleColSpan: 1
                    ,
                    valueMap: {
                        "core": "دفتر مرکزی",
                        "branch": "شعبه"
                    }
                },
                {
                    name: "countryId",
                    title: "<spring:message code='country.nameFa'/>",
                    type: 'long',
                    width: 200, required: true,
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Country,
                    displayField: "nameFa",
                    colSpan: 1,
                    titleColSpan: 1
                    ,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [
                        {name: "id", width: 50, align: "center", colSpan: 1, titleColSpan: 1},
                        {name: "nameFa", width: 150, align: "center", colSpan: 1, titleColSpan: 1},
                        {name: "nameEn", width: 150, align: "center", colSpan: 1, titleColSpan: 1},
                        {name: "isActive", width: 150, align: "center", colSpan: 1, titleColSpan: 1}

                    ]
                }
            ]
    });

    var ToolStripButton_Bank_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Bank_refresh();
        }
    });

    var ToolStripButton_Bank_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Bank.clearValues();
            Window_Bank.show();
        }
    });

    var ToolStripButton_Bank_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Bank_edit();
        }
    });

    var ToolStripButton_Bank_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Bank_remove();
        }
    });

    var ToolStrip_Actions_Bank = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Bank_Refresh,
                ToolStripButton_Bank_Add,
                ToolStripButton_Bank_Edit,
                ToolStripButton_Bank_Remove
            ]
    });

    var HLayout_Bank_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Bank
            ]
    });

    var IButton_Bank_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Bank.validate();
            if (DynamicForm_Bank.hasErrors())
                return;

            var data = DynamicForm_Bank.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest({
                actionURL: "${restApiUrl}/api/bank/",
                httpMethod: method,
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                showPrompt: true,
                serverOutputAsString: false,
                data: JSON.stringify(data),
                //params: { data:data1},
                callback: function (resp) {

                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_Bank_refresh();
                        Window_Bank.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });
    var Window_Bank = isc.Window.create({
        title: "<spring:message code='bank.title'/> ",
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
                DynamicForm_Bank,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_Bank_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                ID: "bankEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Bank.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_Bank = isc.MyListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Bank,
        contextMenu: Menu_ListGrid_Bank,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "bankCode", title: "<spring:message code='bank.bankCode'/>", width: "10%", align: "center"},
                {name: "bankName", title: "<spring:message code='bank.namefa'/>", width: "10%", align: "center"},
                {name: "enBankName", title: "<spring:message code='bank.nameEn'/>", width: "10%", align: "center"},
                {name: "coreBranch", title: "<spring:message code='bank.coreBranch'/>", width: "10%", align: "center"},
                {
                    name: "country.nameFa",
                    title: "<spring:message code='country.nameFa'/>",
                    width: "10%",
                    align: "center"
                },
                {name: "address", title: "<spring:message code='bank.address'/>", width: "20%", align: "center"}
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
            // ListGrid_BankFeature.fetchData({"tblBank.id":record.id},function (dsResponse, data, dsRequest) {
            // ListGrid_BankFeature.setData(data);
            // },{operationId:"00"});
        },
        dataArrived: function (startRow, endRow) {
        }

    });
    var HLayout_Bank_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Bank
        ]
    });

    var VLayout_Bank_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Bank_Actions, HLayout_Bank_Grid
        ]
    });


