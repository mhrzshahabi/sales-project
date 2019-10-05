<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_InvoiceInternal = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "invId"},
                {name: "lcId"},
                {name: "havalehId"},
                {name: "invDate"},
                {name: "buyerId"},
                {name: "customerId"},
                {type: 'integer', name: "goodId"},
                {type: 'float', name: "invOtherKosorat"},
                {name: "havFinalDate"},
                {type: 'float', name: "weightReal"},
                {type: 'float', name: "ghematUnit"},
                {type: 'float', name: "totalKosorat"},
                {type: 'float', name: "mablaghKol"},
                {name: "shomarehSoratHesab"},
                {type: 'float', name: "payForAvarezMalyat"},
                {type: 'float', name: "payForAvarezAlayandegi"},
                {name: "invSented"},
                {type: 'integer', name: "typeForosh"},
                {type: 'integer', name: "haveAlayandegi"},
                {name: "codeNosaAlayandegi"},
                {name: "markazHazineAlayandegi"},
                {type: 'integer', name: "haveMalyat"},
                {name: "codeNosaMalyat"},
                {name: "markazHazineMalyat"},
                {name: "codeNosaBank"},
                {name: "codeNosaCustomer"},
                {name: "codeEtebarNosaCustomer"},
                {name: "codeMarkazHazineCustomer"},
                {name: "codeMarkazHazineHlc"},
                {name: "codeNosaMahsol"},
                {name: "codeMarkazHazineMahsol"},
                {name: "bankGroupDesc"},
                {name: "customerName"},
                {name: "gdsName"},
                {name: "groupGoodsNosa"},
                {name: "groupGoodName"},
                {name: "lcDateSarReceid"},
           ],

        fetchDataURL: "${contextPath}/api/invoiceInternal/spec-list"
    });


    function ListGrid_InvoiceInternal_refresh() {
        ListGrid_InvoiceInternal.invalidateCache();
    }

    function ListGrid_InvoiceInternal_edit() {
        var record = ListGrid_InvoiceInternal.getSelectedRecord();

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
            DynamicForm_InvoiceInternal.editRecord(record);
            Window_InvoiceInternal.show();
        }
    }

    function ListGrid_InvoiceInternal_remove() {

        var record = ListGrid_InvoiceInternal.getSelectedRecord();

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
                buttons: [
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var InvoiceInternalId = record.id;
    return;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/invoiceInternal0000/" + InvoiceInternalId,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_InvoiceInternal_refresh();
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
    }

    var Menu_ListGrid_InvoiceInternal = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_InvoiceInternal_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_InvoiceInternal.clearValues();
                    Window_InvoiceInternal.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_InvoiceInternal_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_InvoiceInternal_remove();
                }
            }, {isSeparator: true},
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png", click: function () {
                    "<spring:url value="/bank/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png", click: function () {
                    "<spring:url value="/bank/print/excel" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg", click: function () {
                    "<spring:url value="/bank/print/html" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }
        ]
    });

    var DynamicForm_InvoiceInternal = isc.DynamicForm.create({
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
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "invDate",title: "<spring:message code='invoice.invDate'/>"},
                {name: "havalehId",title: "<spring:message code='invoice.havalehId'/>"},
                {name: "customerName",title: "<spring:message code='invoice.customerName'/>"},
                {name: "shomarehSoratHesab",title: "<spring:message code='invoice.shomarehSoratHesab'/>"},
                {name: "gdsName",title: "<spring:message code='invoice.gdsName'/>"},
                {type: 'integer', name: "typeForosh",valueMap: {"2": "اعتباری", "1": "نقدی"},title: "<spring:message code='invoice.typeForosh'/>"},
                {type: 'float', name: "ghematUnit",title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "weightReal",title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "mablaghKol",title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalKosorat",title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc",title: "<spring:message code='invoice.bankGroupDesc'/>"},
            ]
    });

    var ToolStripButton_InvoiceInternal_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_InvoiceInternal_refresh();
        }
    });

    var ToolStripButton_InvoiceInternal_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_InvoiceInternal.clearValues();
            Window_InvoiceInternal.show();
        }
    });

    var ToolStripButton_InvoiceInternal_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_InvoiceInternal.clearValues();
            ListGrid_InvoiceInternal_edit();
        }
    });

    var ToolStripButton_InvoiceInternal_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_InvoiceInternal_remove();
        }
    });

    var ToolStripButton_InvoiceInternal_Send2Accounting = isc.ToolStripButton.create({
                title: "<spring:message code='invoice.Send2Accounting'/>", icon: "pieces/512/processDefinition.png",
                click: function () {
                    var record = ListGrid_InvoiceInternal.getSelectedRecord();

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
// invoice.invDate= Date
// invoice.havalehId= Invoice
// invoice.customerName= Buyer
// invoice.shomarehSoratHesab= No
// invoice.gdsName= Product
// invoice.typeForosh= LC
// invoice.ghematUnit= Unit Price
// invoice.weightReal= Weight
// invoice.mablaghKol= Price
// invoice.totalKosorat= Tax+Cost
// invoice.bankGroupDesc= LC Bank
//
                            var data2acc={};
                            data2acc["documentId"]= record.id+'"';
                            data2acc["internal"]=  "داخلی";
                            data2acc["documentNo"]=  record.havalehId;
                            data2acc["documentDate"]= record.invDate;
                            data2acc["company"]=  record.customerName+'-'+
                                                         record.shomarehSoratHesab;
                            data2acc["price"]=  (record.typeForosh==2 ?  "اعتباری " : " ")+record.mablaghKol;
 // alert(JSON.stringify(data2acc))
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                    actionURL: "${contextPath}/api/invoiceInternal/sendForm-2accounting/"+record.id,
                                    httpMethod: "PUT",
                                    data: JSON.stringify(data2acc),
                                    callback: function (resp) {
                                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                            isc.say("<spring:message code='global.form.request.successful'/>.");
                                            ListGrid_InvoiceInternal_refresh();
                                        } else
                                            isc.say(RpcResponse_o.data);
                                    }
                                })
                            );
                    }
                }
    });

    var ToolStrip_Actions_InvoiceInternal = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_InvoiceInternal_Refresh,
                ToolStripButton_InvoiceInternal_Add,
                ToolStripButton_InvoiceInternal_Edit,
                ToolStripButton_InvoiceInternal_Remove,
                ToolStripButton_InvoiceInternal_Send2Accounting
            ]
    });

    var HLayout_InvoiceInternal_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_InvoiceInternal
            ]
    });

    var IButton_InvoiceInternal_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_InvoiceInternal.validate();
            if (DynamicForm_InvoiceInternal.hasErrors())
                return;
    return;
            var data = DynamicForm_InvoiceInternal.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/invoiceInternal00000/",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_InvoiceInternal_refresh();
                            Window_InvoiceInternal.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var Window_InvoiceInternal = isc.Window.create({
        title: "<spring:message code='bank.title'/> ",
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
                DynamicForm_InvoiceInternal,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_InvoiceInternal_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_InvoiceInternal.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_InvoiceInternal = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_InvoiceInternal,
        contextMenu: Menu_ListGrid_InvoiceInternal,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "invDate",title: "<spring:message code='invoice.invDate'/>"},
                {name: "havalehId",title: "<spring:message code='invoice.havalehId'/>"},
                {name: "customerName",title: "<spring:message code='invoice.customerName'/>"},
                {name: "shomarehSoratHesab",title: "<spring:message code='invoice.shomarehSoratHesab'/>"},
                {name: "gdsName",title: "<spring:message code='invoice.gdsName'/>"},
                {type: 'integer', name: "typeForosh",valueMap: {"2": "اعتباری", "1": "نقدی"},title: "<spring:message code='invoice.typeForosh'/>"},
                {type: 'float', name: "ghematUnit",title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "weightReal",title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "mablaghKol",title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalKosorat",title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc",title: "<spring:message code='invoice.bankGroupDesc'/>"},
           ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        },
        dataArrived: function (startRow, endRow) {
        }
    });

    var HLayout_InvoiceInternal_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_InvoiceInternal
        ]
    });

    var VLayout_InvoiceInternal_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_InvoiceInternal_Actions, HLayout_InvoiceInternal_Grid
        ]
    });