<%@ page contentType="text/html;charset=UTF-8" %>
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
                {name: "processId"} //Bug-Fix ->Not Work Search
            ],

        fetchDataURL: "${contextPath}/api/invoiceInternal/list-accounting"
    });

    function ListGrid_InvoiceInternal_refresh() {
        ListGrid_InvoiceInternal.invalidateCache();
    }

    function ToolStripButton_InvoiceInternal_Pdf_F() {

        var record = ListGrid_InvoiceInternal.getSelectedRecord();
        if (record === null || record === " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal.getSelectedRecord().id;
            window.open("invoiceInternal/print/pdf/" + rowId);
        }
    }


    function ToolStripButton_InvoiceInternal_Html_F() {

        var record = ListGrid_InvoiceInternal.getSelectedRecord();
        if (record === null || record === " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal.getSelectedRecord().id;
            window.open("invoiceInternal/print/html/" + rowId);
        }
    }


    var ToolStripButton_InvoiceInternal_html = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.html'/>",
        icon: "icon/html.jpg",
        click: function () {
            ToolStripButton_InvoiceInternal_Html_F();
        }
    });

    var ToolStripButton_InvoiceInternal_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.pdf'/>",
        icon: "icon/pdf.png",
        click: function () {
            ToolStripButton_InvoiceInternal_Pdf_F();

        }
    });

    var ToolStripButton_InvoiceInternal_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_InvoiceInternal_refresh();
        }
    });

    function Menu_ListGrid_InvoiceInternal_Pdf_F() {

        var record = ListGrid_InvoiceInternal.getSelectedRecord();
        if (record === null || record === " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal.getSelectedRecord().id;
            window.open("invoiceInternal/print/pdf/" + rowId);
        }
    }

    function Menu_ListGrid_InvoiceInternal_Html_F() {

        var record = ListGrid_InvoiceInternal.getSelectedRecord();
        if (record === null || record === " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_InvoiceInternal.getSelectedRecord().id;
            window.open("invoiceInternal/print/html/" + rowId);
        }
    }

    var Menu_ListGrid_InvoiceInternal = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_InvoiceInternal_refresh();
                }
            },

            {
                title: "<spring:message code='global.form.print.pdf'/>",
                icon: "icon/pdf.png",
                click: function () {
                    Menu_ListGrid_InvoiceInternal_Pdf_F();
                }

            }

            , {
                title: "<spring:message code='global.form.print.html'/>",
                icon: "icon/html.jpg",
                click: function () {
                    Menu_ListGrid_InvoiceInternal_Html_F();
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
                {name: "invDate", title: "<spring:message code='invoice.invDate'/>"},
                {name: "havalehId", title: "<spring:message code='invoice.havalehId'/>"},
                {name: "customerName", title: "<spring:message code='invoice.customerName'/>"},
                {name: "shomarehSoratHesab", title: "<spring:message code='invoice.shomarehSoratHesab'/>"},
                {name: "gdsName", title: "<spring:message code='invoice.gdsName'/>"},
                {
                    type: 'integer',
                    name: "typeForosh",
                    valueMap: {"2": "اعتباری", "1": "نقدی"},
                    title: "<spring:message code='invoice.typeForosh'/>"
                },
                {type: 'float', name: "ghematUnit", title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "weightReal", title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "mablaghKol", title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalKosorat", title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>"},
            ]
    });

    var ToolStrip_Actions_InvoiceInternal = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members:
            [
                ToolStripButton_InvoiceInternal_Pdf,
                ToolStripButton_InvoiceInternal_html,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_InvoiceInternal_Refresh,
                    ]
                })

            ]
    });

    var HLayout_InvoiceInternal_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_InvoiceInternal
            ]
    });

    var IButton_InvoiceInternal_Save = isc.IButtonSave.create({
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
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
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
                            isc.IButtonCancel.create({
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
                {name: "processId", title: "<spring:message code='invoice.processId'/>"},
                {name: "invDate", title: "<spring:message code='invoice.invDate'/>"},
                {name: "havalehId", title: "<spring:message code='invoice.havalehId'/>"},
                {name: "customerName", title: "<spring:message code='invoice.customerName'/>"},
                {name: "shomarehSoratHesab", title: "<spring:message code='invoice.shomarehSoratHesab'/>"},
                {name: "gdsName", title: "<spring:message code='invoice.gdsName'/>"},
                {
                    type: 'integer',
                    name: "typeForosh",
                    valueMap: {"2": "اعتباری", "1": "نقدی"},
                    title: "<spring:message code='invoice.typeForosh'/>"
                },
                {type: 'float', name: "ghematUnit", title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "weightReal", title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "mablaghKol", title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalKosorat", title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>"},
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        allowFilterOperators: true
    });

    var HLayout_InvoiceInternal_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_InvoiceInternal
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_InvoiceInternal_Actions, HLayout_InvoiceInternal_Grid
        ]
    });