<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

 //<script>

    <% DateUtil dateUtil = new DateUtil();%>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    isc.SimpleType.create(
            {
             name: "currencyFloat2",
             inheritsFrom: "float",

             normalDisplayFormatter: function(value)
             {
              return isc.isA.Number(value) ? value.toCurrencyString() : value;
             },
             shortDisplayFormatter: function(value)
             {
              return isc.isA.Number(value) ? value.toCurrencyString() : value;
             },
             editFormatter: function(value)
             {
              return isc.isA.Number(value) ? value.toFixed(2) : value;
             },
             parseInput: function(value)
             {
              var fVal = parseFloat(value);
              if (!isNaN(fVal)) return fVal;
              return value;
             },

             validators: [
              {
               type: "floatRange",
               min: 0,
               errorMessage: "<spring:message code='notValid.all'/>"
              },
              {
               type: "floatPrecision",
               precision: 2,
               roundToPrecision: true
              }]

            });


    isc.SimpleType.create(
            {
             name: "currencyFloat2Sign",
             inheritsFrom: "float",

             normalDisplayFormatter: function(value)
             {
              return isc.isA.Number(value) ? value.toCurrencyString() : value;
             },
             shortDisplayFormatter: function(value)
             {
              return isc.isA.Number(value) ? value.toCurrencyString() : value;
             },
             editFormatter: function(value)
             {
              return isc.isA.Number(value) ? value.toFixed(2) : value;
             },
             parseInput: function(value)
             {
              var fVal = parseFloat(value);
              if (!isNaN(fVal)) return fVal;
              return value;
             },

             validators: [
              {
               type: "floatPrecision",
               precision: 2,
               roundToPrecision: true
              }]

            });


    isc.SimpleType.create({
    name:"currencyFloat3",
        inheritsFrom:"float",

        normalDisplayFormatter:function(value) {
            return isc.isA.Number(value) ? value.toCurrencyString() : value;
        },
        shortDisplayFormatter:function(value) {
            return isc.isA.Number(value) ? value.toCurrencyString() : value;
        },
        editFormatter:function (value) {
            return isc.isA.Number(value) ? value.toFixed(3) : value;
        },
        parseInput:function(value) {
            var fVal = parseFloat(value);
            if (!isNaN(fVal)) return fVal;
            return value;
        },

        validators:[
            {type:"floatRange", min:0, errorMessage:"notValid"},
            {type:"floatPrecision", precision:3, roundToPrecision:true}
        ]

    });

    isc.SimpleType.create(
            {
             name: "currencyFloat5",
             inheritsFrom: "float",

             normalDisplayFormatter: function(value)
             {
              return isc.isA.Number(value) ? value.toCurrencyString() : value;
             },
             shortDisplayFormatter: function(value)
             {
              return isc.isA.Number(value) ? value.toCurrencyString() : value;
             },
             editFormatter: function(value)
             {
              return isc.isA.Number(value) ? value.toFixed(5) : value;
             },
             parseInput: function(value)
             {
              var fVal = parseFloat(value);
              if (!isNaN(fVal)) return fVal;
              return value;
             },

             validators: [
              {
               type: "floatRange",
               min: 0,
               errorMessage: "notValid"
              },
              {
               type: "floatPrecision",
               precision: 5,
               roundToPrecision: true
              }]

            });


    var RestDataSource_Shipment_InvoiceHeader = isc.MyRestDataSource.create(
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
               name: "contractShipmentId",
               hidden: true,
               type: 'long'
              },
              {
               name: "contactId",
               type: 'long',
               hidden: true
              },
              {
               name: "contract.contact.nameFA"
              },
              {
               name: "contractId",
               type: 'long',
               hidden: true
              },
              {
               name: "contract.contractNo"
              },
              {
               name: "contract.contractDate"
              },
              {
               name: "materialId"
              },
              {
               name: "material.descl"
              },
              {
               name: "material.unit.nameEN"
              },
              {
               name: "amount"
              },
              {
               name: "shipmentType"
              },
              {
               name: "loadingLetter"
              },
              {
               name: "noContainer"
              },
              {
               name: "portByLoading.port"
              },
              {
               name: "portByDischarge.port"
              },
              {
               name: "description"
              },
              {
               name: "contractShipment.sendDate"
              },
              {
               name: "createDate"
              },
              {
               name: "month"
              },
              {
               name: "contactByAgent.nameFA"
              },
              {
               name: "vesselName"
              },
              {
               name: "swb"
              },
              {
               name: "switchPort.port"
              },
              {
               name: "status"
              }],
             fetchDataURL: "${contextPath}/api/shipment/spec-list"
            });


    var Menu_ListGrid_Shipment_InvoiceHeader = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Shipment_InvoiceHeader.invalidateCache();
                }
            }
        ]
    });
    var ToolStripButton_Shipment_InvoiceHeader_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Shipment_InvoiceHeader.invalidateCache();
            var criteria = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "shipmentId", operator: "equals", value: null}]
            };
            ListGrid_Invoice.fetchData(criteria, function (dsResponse, data, dsRequest) {
                ListGrid_Invoice.setData(data);
            });
        }
    });
    var ToolStrip_Actions_Shipment_InvoiceHeader = isc.ToolStrip.create({
        width: "100%",
        members: [
            isc.ToolStrip.create({
            width: "100%",
            align: "left",
            border: '0px',
            members: [
                ToolStripButton_Shipment_InvoiceHeader_Refresh,
            ]
            })
        ]
    });
var recordNotFound = isc.Label.create({
height: 30,
padding: 10,
align: "center",
valign: "center",
wrap: false,
contents: "رکوردی یافت نشد"
});

recordNotFound.hide();

function setCriteria_ListGrid_InsperctionContract(recordId) {
        var criteria1 = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "shipmentId", operator: "equals", value: recordId}]
        };


    ListGrid_Invoice.fetchData(criteria1, function (dsResponse, data, dsRequest) {
        if (data.length === 0) {
        recordNotFound.show();
        ListGrid_Invoice.hide()
        } else {
        recordNotFound.hide();
        ListGrid_Invoice.setData(data);
        ListGrid_Invoice.show();
        }
        }, {operationId: "00"});
        }

        function getExpandedComponent(record) {
        setCriteria_ListGrid_InsperctionContract(record.id)
        var hLayout = isc.HLayout.create({
        align: "center", padding: 5,
        membersMargin: 20,
        members: [
            HLayout_Invoice_Actions
        ]
        });

        var layout = isc.VLayout.create({
        padding: 5,
        membersMargin: 10,
        members: [ListGrid_Invoice, recordNotFound, hLayout]
        });

        return layout;
        }

    var ListGrid_Shipment_InvoiceHeader = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment_InvoiceHeader,
        contextMenu: Menu_ListGrid_Shipment_InvoiceHeader,
        styleName: 'expandList',
        autoFetchData: true,
        alternateRecordStyles: true,
        canExpandRecords: true,
        canExpandMultipleRecords: false,
        wrapCells: false,
        showRollOver: false,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        autoFitExpandField: true,
        virtualScrolling: true,
        loadOnExpand: true,
        loaded: false,

        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contract.contact.nameFA", title: "<spring:message code='contact.name'/>", type: 'text', width: "20%", align: "center", showHover: true
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.contractNo", title: "<spring:message code='contract.contractNo'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "contract.contractDate", title: "<spring:message	code='contract.contractDate'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descl", title: "<spring:message		code='material.descl'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "material.unit.nameEN", title: "<spring:message		code='unit.nameEN'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "amount", title: "<spring:message		code='global.amount'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "shipmentType", title: "<spring:message		code='shipment.shipmentType'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "loadingLetter", title: "<spring:message		code='shipment.loadingLetter'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "noContainer", title: "<spring:message		code='shipment.noContainer'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "portByLoading.port", title: "<spring:message		code='shipment.loading'/>", type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "portByDischarge.port", title: "<spring:message		code='shipment.discharge'/>", type: 'text', required: true, width: "10%", showHover: true
            },

            {
                name: "month", title: "<spring:message code='shipment.month'/>",
		        type: 'text', required: true, width: "10%", align: "center", showHover: true
            },

            {
                name: "status", title: "<spring:message	code='shipment.staus'/>", type: 'text', width: "10%", align: "center", valueMap: {
                    "Load Ready": "<spring:message	code='shipment.loadReady'/>", "Resource": "<spring:message code='shipment.resource'/>"
                }, showHover: true
            },

        ],
      /*  recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
            };
            ListGrid_Invoice.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_Invoice.setData(data);
            });
        },
        dataArrived: function (startRow, endRow) {
        },*/
        sortField: 0,
        showFilterEditor: true,
        filterOnKeypress: true,
        getExpansionComponent: function (record) {
        return getExpandedComponent(record)
        }
    });



    var HLayout_Grid_Shipment_InvoiceHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment_InvoiceHeader
        ]
    });

    var VLayout_Body_Shipment_InvoiceHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_Shipment_InvoiceHeader, HLayout_Grid_Shipment_InvoiceHeader
        ]
    });

    var ViewLoader_Invoice_Attachment = isc.ViewLoader.create({
        width: "100%",
        height: "100%",
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>",
    });
     var Window_Invoice_Attachment = isc.Window.create({
        title: "<spring:message code='global.Attachment'/> ",
        width: "50%",
        height: "50%",
        margin: '1px',
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
                ViewLoader_Invoice_Attachment
            ]
    });
    var ViewLoader_Molybdenum = isc.ViewLoader.create({
        width: 1600,
        height: "100%",
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>",
    });
     var Window_Molybdenum = isc.Window.create({
        title: "<spring:message code='issuedInvoices.title'/> ",
        width: 1610,
        height: 800,

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
                ViewLoader_Molybdenum
            ]
    });
    var ViewLoader_Concentrate = isc.ViewLoader.create({
        width: 1600,
        height: 800,
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>",
    });
    var Window_Invoice_Concentrate = isc.Window.create({
        title: "<spring:message code='issuedInvoices.title'/> ",
        width: 1600,
        height: 800,
        autoSize:true,
        autoCenter: true,
        isModal: true,


        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [ ViewLoader_Concentrate ]
    });
    var ViewLoader_Cathodes = isc.ViewLoader.create({
        width: "100%",
        height: "100%",
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>",
    });
    var Window_Cathodes = isc.Window.create({
        title: "<spring:message code='issuedInvoices.title'/> ",
        width: "100%",
        height: "100%",
        autoCenter: true,
        isModal: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [ ViewLoader_Cathodes ]
    });


    var RestDataSource_Invoice = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "id", canEdit: false, hidden: true},
                {name: "processId", title: "<spring:message code='invoice.processId'/>", width: "10%"},
                {name: "invoiceNo", title: "<spring:message code='invoice.invoiceNo'/>", width: "10%"},
                {name: "invoiceDate"},
                {name: "invoiceType" },
                {name: "net", },
                {name: "grass"},
                {name: "unitPrice"},
                {name: "unitPriceCurrency"},
                {name: "invoiceValue"},
                {name: "invoiceValueCurrency"},
                { name: "paidPercent"},
                {name: "paidStatus"},
                {name: "Depreciation"}
            ],

        fetchDataURL: "${contextPath}/api/invoice/spec-list"
    });
    function Window_Invoice_Attachment_Open(){
            var record = ListGrid_Invoice.getSelectedRecord();

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
                     var dccTableId = record.id;
                    var dccTableName = "TBL_INVOICE";
                    ViewLoader_Invoice_Attachment.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId);
                    Window_Invoice_Attachment.show();
            }
    }
    function ListGrid_Invoice_refresh() {
        ListGrid_Invoice.invalidateCache();
        var record = ListGrid_Shipment_InvoiceHeader.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
        };
        ListGrid_Invoice.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_Invoice.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_Invoice_edit() {
        var record = ListGrid_Invoice.getSelectedRecord();

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
            if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.code === '26030090') {
                ViewLoader_Concentrate.setViewURL("<spring:url value="/invoice/showForm" />/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id+"/"+record.id+"/con/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contractId);
                Window_Invoice_Concentrate.show();
                return;
            } else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.code === '28257000') {
                        ViewLoader_Molybdenum.setViewURL("<spring:url value="/invoice/showForm" />/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id+"/"+record.id+"/mol/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contractId);
                        Window_Molybdenum.show();
                        return;
            }   else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.code === '74031100') {
                        ViewLoader_Cathodes.setViewURL("<spring:url value="/invoice/showForm" />/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id+"/"+record.id+"/cat/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contractId);
                        Window_Cathodes.show();
                        return;
            } else {
                DynamicForm_Invoice.getItem("copperUnitPrice").show();
                DynamicForm_Invoice.getItem("copper").show();
                DynamicForm_Invoice.getItem("goldUnitPrice").hide();
                DynamicForm_Invoice.getItem("gold").hide();
                DynamicForm_Invoice.getItem("silverUnitPrice").hide();
                DynamicForm_Invoice.getItem("silver").hide();
                DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
                DynamicForm_Invoice.getItem("molybdenum").hide();
            }
            DynamicForm_Invoice.setValue("invoiceDateDumy", new Date(record.invoiceDate));
            DynamicForm_Invoice.editRecord(record);
            Window_Invoice.show();
        }
    }

    function ListGrid_Invoice_remove() {

        var record = ListGrid_Invoice.getSelectedRecord();

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
                    if (index === 0) {
                        var InvoiceId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                            actionURL: "${contextPath}/api/invoice/" + record.id,
                            httpMethod: "DELETE",
                            callback: function (resp) {
                                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                                    ListGrid_Invoice_refresh();
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            }
                        }));
                    }
                }
            });
        }
    };
    var Menu_ListGrid_Invoice = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Invoice.clearValues();
                    if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.code === '26030090') {
                        ViewLoader_Concentrate.setViewURL("<spring:url value="/invoice/showForm" />/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id+"/0/con/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contractId);
                        Window_Invoice_Concentrate.show();
                        return;
                    } else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.code === '28257000') {
                        ViewLoader_Molybdenum.setViewURL("<spring:url value="/invoice/showForm" />/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id+"/0/mol/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contractId);
                        Window_Molybdenum.show();
                        return;
                    } else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.code === '74031100') {
                        ViewLoader_Cathodes.setViewURL("<spring:url value="/invoice/showForm" />/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id+"/"+record.id+"/cat/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contractId);
                        Window_Cathodes.show();
                        return;
                    } else {
                        DynamicForm_Invoice.getItem("copperUnitPrice").show();
                        DynamicForm_Invoice.getItem("copper").show();
                        DynamicForm_Invoice.getItem("goldUnitPrice").hide();
                        DynamicForm_Invoice.getItem("gold").hide();
                        DynamicForm_Invoice.getItem("silverUnitPrice").hide();
                        DynamicForm_Invoice.getItem("silver").hide();
                        DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
                        DynamicForm_Invoice.getItem("molybdenum").hide();
                    }
                    Window_Invoice.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Invoice_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Invoice_remove();
                }
            },
            {
                title: "<spring:message code='global.Attachment'/>", icon: "pieces/512/attachment.png",
                click: function () {
                    Window_Invoice_Attachment_Open();
                }
            },

            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    ToolStripButton_Invoice_Pdf_F();
                }
            },
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                     ToolStripButton_Invoice_Html_F();
                }
            },
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                     ToolStripButton_Invoice_Excel_F();
                }
            }
        ]
    });

    var DynamicForm_Invoice = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100", margin: '10px', wrapTitle: false,
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4,
        //backgroundImage: "backgrounds/leaves.jpg",
        fields:
            [
                {name: "id", hidden: true},
                {name: "shipmentId", hidden: true},
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "invoiceType",
                    title: "<spring:message code='invoice.invoiceType'/>",
                    type: 'text',
                    width: "100%",
                    required: true,
                    valueMap: {"PROVISIONAL": "PROVISIONAL", "FINAL": "FINAL", "PREPAID": "PREPAID"}
                },
                {
                    name: "paidStatus",
                    title: "<spring:message code='invoice.paidStatus'/>",
                    type: 'text',
                    width: "100%",
                    defaultValue: "UNPAID",
                    valueMap: {"PAID": "PAID", "UNPAID": "UNPAID"}
                },
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "invoiceNo", title: "<spring:message code='invoice.invoiceNo'/>",
                    required: true,
                    width: "100%",
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false
                },
                {
                    name: "invoiceDateDumy",
                    title: "<spring:message code='invoice.invoiceDate'/>",
                    defaultValue: "<%=DateUtil.todayDate()%>",
                    type: 'date',
                    format: 'DD-MM-YYYY HH:mm:ss',
                    required: true,
                    width: "100%"
                },
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "grass",
                    title: "<spring:message code='global.grass'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "net",
                    title: "<spring:message code='global.net'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "unitPrice",
                    title: "<spring:message code='global.unitPrice'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "unitPriceCurrency",
                    title: "<spring:message code='invoice.unitPriceCurrency'/>",
                    type: 'text',
                    width: "100%",
                    defaultValue: "USD",
                    valueMap: dollar
                },
                {
                    name: "paidPercent", title: "<spring:message code='invoice.paidPercent'/>",
                    type: 'float', required: true, width: "100%",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        },
                        {
                            type: "integerRange",
                            min: 80,
                            max: 120,
                            errorMessage: "<spring:message code='invoice.form.paidPercent.prompt'/>"
                        }
                    ]
                },
                {
                    name: "Depreciation",
                    title: "<spring:message code='invoice.Depreciation'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    wrapTitle: false,
                    titleColSpan: 1,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "otherCost",
                    title: "<spring:message code='invoice.otherCost'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "beforePaid",
                    title: "<spring:message code='invoice.beforePaid'/>",
                    type: 'float',
                    required: false, titleColSpan: 1, wrapTitle: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "invoiceValue", title: "<spring:message code='invoice.invoiceValue'/>",
                    type: 'float', required: true, width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "invoiceValueCurrency",
                    title: "<spring:message code='invoice.invoiceValueCur'/>",
                    type: 'text',
                    width: "100%",
                    defaultValue: "USD",
                    valueMap: dollar
                },
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - محتوی - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "copperUnitPrice", title: "<spring:message code='invoice.copperUnitPrice'/>",
                    type: 'float', required: false, width: "204px",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "copper",
                    title: "<spring:message code='invoice.copper'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "goldUnitPrice", title: "<spring:message code='invoice.goldUnitPrice'/>",
                    type: 'float', required: false, width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "gold",
                    title: "<spring:message code='invoice.gold'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "silverUnitPrice", title: "<spring:message code='invoice.silverUnitPrice'/>",
                    type: 'float', required: false, width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "silver",
                    title: "<spring:message code='invoice.silver'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "molybdJenumUnitPrice", title: "<spring:message code='invoice.molybdJenumUnitPrice'/>",
                    type: 'float', required: false, width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "molybdenum",
                    title: "<spring:message code='invoice.molybdenum'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                }
            ]
    });

    var ToolStripButton_Invoice_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Invoice_refresh();
        }
    });

    var ToolStripButton_Invoice_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_Shipment_InvoiceHeader.getSelectedRecord();

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
                if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.code === '26030090') {
                       ViewLoader_Concentrate.setViewURL("<spring:url value="/invoice/showForm" />/"+record.id+"/0/con/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contractId);
                       Window_Invoice_Concentrate.show();
                        return;
                } else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.code === '28257000') {
                       ViewLoader_Molybdenum.setViewURL("<spring:url value="/invoice/showForm" />/"+record.id+"/0/mol/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contractId);
                       Window_Molybdenum.show();
                        return;
                } else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.code === '74031100') {
                    ViewLoader_Cathodes.setViewURL("<spring:url value="/invoice/showForm" />/"+record.id+"/0/cat/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contractId);
                    Window_Cathodes.show();
               } else {
                DynamicForm_Invoice.clearValues();
                DynamicForm_Invoice.setValue("shipmentId", record.id);
                Window_Invoice.show();
                }
            }
        }
    });

/*
    var ToolStripButton_Invoice_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Invoice.clearValues();
            ListGrid_Invoice_edit();
        }
    });
*/


/*
    var ToolStripButton_Invoice_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Invoice_remove();
        }
    });
*/

    var ToolStripButton_Invoice_Attachment = isc.ToolStripButton.create({
                title: "<spring:message code='global.Attachment'/>", icon: "pieces/512/attachment.png",
                click: function () {
                    Window_Invoice_Attachment_Open();
                }
    });


    function ToolStripButton_Invoice_Pdf_F () {

            var record = ListGrid_Invoice.getSelectedRecord();
            if (record===null || record===" " ){
                isc.say("<spring:message code='global.grid.record.not.selected'/>");
            }else {
                 var rowId = ListGrid_Invoice.getSelectedRecord().id;
                 window.open("invoice/print/pdf/" + rowId);
                 }
}


    function ToolStripButton_Invoice_Html_F () {

                 var record = ListGrid_Invoice.getSelectedRecord();
            if (record===null || record===" " ){
                isc.say("<spring:message code='global.grid.record.not.selected'/>");
            }else {
                 var rowId = ListGrid_Invoice.getSelectedRecord().id;
                 window.open("invoice/print/html/" + rowId);
                 }
    }




    function ToolStripButton_Invoice_Excel_F () {

                var record = ListGrid_Invoice.getSelectedRecord();
            if (record===null || record===" " ){
                isc.say("<spring:message code='global.grid.record.not.selected'/>");
            }else {
                 var rowId = ListGrid_Invoice.getSelectedRecord().id;
                 window.open("invoice/print/xlsx/" + rowId);
                 }
    }



    var ToolStripButton_Invoice_Pdf = isc.ToolStripButtonPrint.create({
                    title: "<spring:message code='global.form.print.pdf'/>",
                    icon: "icon/pdf.png",
                     click: function () {
                    ToolStripButton_Invoice_Pdf_F();
                   }
    });

    var ToolStripButton_Invoice_excel = isc.ToolStripButtonPrint.create({
                title: "<spring:message code='global.form.print.excel'/>",
                icon: "icon/excel.png",
                 click: function () {
                ToolStripButton_Invoice_Excel_F ();
}
    });

    var ToolStripButton_Invoice_html = isc.ToolStripButtonPrint.create({
                title: "<spring:message code='global.form.print.html'/>",
                icon: "icon/html.jpg",
                click: function () {
                ToolStripButton_Invoice_Html_F ();
        }});

    var ToolStripButton_Invoice_Send2Accounting = isc.ToolStripButton.create({
                title: "<spring:message code='invoice.Send2Accounting'/>", icon: "pieces/512/processDefinition.png",
                click: function () {
                    var record = ListGrid_Invoice.getSelectedRecord();

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
                    } else if (record.processId== null || typeof record.processId == 'undefined' ) {
                            var data2acc={}; var iiid=record.id; var iiinvoice=record.invoiceNo;
                            data2acc["documentId"]= iiid.toString();
                            data2acc["internal"]=  "خارجی";
                            data2acc["documentNo"]=  iiinvoice.toString();
                            data2acc["documentDate"]= record.invoiceDate;
                            data2acc["company"]=  ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contract.contact.nameFA+'-'+
                                                         ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contract.contractNo;
                            data2acc["price"]=  record.invoiceValueCurrency+record.invoiceValue;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                    actionURL: "${contextPath}/api/invoice/sendForm-2accounting/"+record.id,
                                    httpMethod: "PUT",
                                    data: JSON.stringify(data2acc),
                                    callback: function (resp) {
                                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                                            isc.say("<spring:message code='global.form.request.successful'/>");
                                            ListGrid_Invoice_refresh();
                                        } else
                                            isc.say(RpcResponse_o.data);
                                    }
                                })
                            );
                    } else isc.Dialog.create({
                            message: "<spring:message code='invoice.alreadyStarted'/>",
                            icon: "[SKIN]ask.png",
                            title: "<spring:message code='global.message'/>",
                            buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                            buttonClick: function () {
                                this.hide();
                            }
                        });
                }
    });


    var ToolStrip_Actions_Invoice = isc.ToolStrip.create({
        width: "100%",
     membersMargin: 5,
    backgroundColor:"#cdcdcd",
     members:
            [
                ToolStripButton_Invoice_Add,
        /*        ToolStripButton_Invoice_Edit,
                ToolStripButton_Invoice_Remove,*/
                ToolStripButton_Invoice_Attachment,
                ToolStripButton_Invoice_Send2Accounting ,
                ToolStripButton_Invoice_Pdf,
                ToolStripButton_Invoice_excel,
                ToolStripButton_Invoice_html,
             isc.ToolStrip.create({
              width: "100%",
              align: "left",
              border: '0px',
                backgroundColor:"#cdcdcd",
              members: [
               ToolStripButton_Invoice_Refresh,
              ]
             })

            ] //Add Print
    });



    var HLayout_Invoice_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Invoice
            ]
    });


    var IButton_Invoice_Save = isc.IButtonSave.create({
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_Invoice.validate();
            if (DynamicForm_Invoice.hasErrors())
                return;
            var drs = DynamicForm_Invoice.getValue("invoiceDateDumy");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Invoice.setValue("invoiceDate", datestringRs);
            DynamicForm_Invoice.setValue("shipmentId", ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id);

            var data = DynamicForm_Invoice.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                actionURL: "${contextPath}/api/invoice/",
                httpMethod: method,
                data: JSON.stringify(data),
                callback: function (resp) {
                    if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_Invoice_refresh();
                        Window_Invoice.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });



    var Window_Invoice = isc.Window.create({
        title: "<spring:message code='issuedInvoices.title'/> ",
        width: 580,
        height: 500,
        margin: '10px',
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
                DynamicForm_Invoice,
                isc.HLayout.create({
                    width: "100%", align: "center", height: "20",
                    members:
                        [
                            IButton_Invoice_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Invoice.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_Invoice = isc.ListGrid.create({
        width: "100%",
        height: 200,
        dataSource: RestDataSource_Invoice,
        contextMenu: Menu_ListGrid_Invoice,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "processId", title: "<spring:message code='invoice.processId'/>", width: "10%"},
                {name: "invoiceNo", title: "<spring:message code='invoice.invoiceNo'/>", width: "10%"},
                {
                    name: "invoiceDate",
                    title: "<spring:message code='invoice.invoiceDate'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "invoiceType",
                    title: "<spring:message code='invoice.invoiceType'/>",
                    type: 'text',
                    width: "10%"
                },
                {name: "net", title: "<spring:message code='global.net'/>", type: 'float', width: "10%"},
                {name: "grass", title: "<spring:message code='global.grass'/>", type: 'float', width: "10%"},
                {name: "unitPrice", title: "<spring:message code='global.unitPrice'/>", type: 'float', width: "10%"},
                {
                    name: "unitPriceCurrency",
                    title: "<spring:message code='invoice.unitPriceCurrency'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "invoiceValue",
                    title: "<spring:message code='invoice.invoiceValue'/>",
                    type: 'float',
                    width: "10%"
                },
                {
                    name: "invoiceValueCurrency",
                    title: "<spring:message code='invoice.invoiceValueCur'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "paidPercent",
                    title: "<spring:message code='invoice.paidPercent'/>",
                    type: 'float',
                    width: "10%"
                },
                {name: "paidStatus", title: "<spring:message code='invoice.paidStatus'/>", type: 'text', width: "10%"},
                {
                    name: "Depreciation",
                    title: "<spring:message code='invoice.Depreciation'/>",
                    type: 'float',
                    width: "10%"
                },
                {
                name: "editIcon",
                width: 40,
                align: "center",
                showTitle: false
                },
                {
                name: "removeIcon",
                width: 40,
                align: "center",
                showTitle: false
                },
            ],
        sortField: 0,
        autoFetchData: false,
        //showFilterEditor: true,
        filterOnKeypress: true,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        createRecordComponent: function (record, colNum) {
        var fieldName = this.getFieldName(colNum);
        if (fieldName == "editIcon") {
        var editImg = isc.ImgButton.create({
        showDown: false,
        showRollOver: false,
        layoutAlign: "center",
        src: "pieces/16/icon_edit.png",
        prompt: "ویرایش",
        height: 16,
        width: 16,
        grid: this,
        click: function () {
        ListGrid_Invoice.selectSingleRecord(record);
        ListGrid_Invoice_edit();
        }
        });
        return editImg;
        } else if (fieldName == "removeIcon") {
        var removeImg = isc.ImgButton.create({
        showDown: false,
        showRollOver: false,
        layoutAlign: "center",
        src: "pieces/16/icon_delete.png",
        prompt: "حذف",
        height: 16,
        width: 16,
        grid: this,
        click: function () {
            ListGrid_Invoice.selectSingleRecord(record);
            ListGrid_Invoice_remove();
        }
        });
        return removeImg;
        } else {
        return null;
        }
        },

    });
    var HLayout_Invoice_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Invoice
        ]
    });

    var VLayout_Invoice_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Invoice_Actions, HLayout_Invoice_Grid
        ]
    });

    isc.SectionStack.create({
        ID: "Shipment_InvoiceHeader_Section_Stack",
        sections:
            [
                {
                    title: "<spring:message code='Shipment.title'/>",
                    items: VLayout_Body_Shipment_InvoiceHeader,
                    expanded: true,
                    showHeader: false
                }
                , {title: "<spring:message code='issuedInvoices.title'/>", items: VLayout_Invoice_Body, expanded: true, hidden: true}
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });


function validatedate(inputText1)
  {
  if (inputText1==null || typeof (inputText1)=='undefined' || inputText1=="" )
  	return false;
  var inputText=inputText1.substring(0,11);
  // Match the date format through regular expression
  if(inputText.length==8 )
  {
  var yy  = parseInt(inputText.substring(0,4));
  var mm = parseInt(inputText.substring(4,6));
  var dd = parseInt(inputText.substring(6,8));
  // Create list of days of a month [assume there is no leap year by default]
if (yy<1990 || yy>2020) {
	alert('Invalid Year 1990-2020 is ok');
	return false;
}
if (mm<1 || mm>12) {
	alert('Invalid month');
	return false;
}
  var ListofDays = [31,28,31,30,31,30,31,31,30,31,30,31];
  if (mm==1 || mm>2)
  	{
  		if (dd>ListofDays[mm-1])
  			{
  			alert('Invalid date format!');
 			 return false;
  			}
  	}
  if (mm==2)
	{
  		var lyear = false;
  		if ( (!(yy % 4) && yy % 100) || !(yy % 400))
  			{
  			lyear = true;
  			}
	  if ((lyear==false) && (dd>=29))
		{
		alert('Invalid date format!');
		return false;
		}
	  if ((lyear==true) && (dd>29))
		{
		alert('Invalid date format!');
		return false;
		}
	  }
  }
  else
  {
  alert("Invalid date format!");

  return false;
  }
  return true;
  }
