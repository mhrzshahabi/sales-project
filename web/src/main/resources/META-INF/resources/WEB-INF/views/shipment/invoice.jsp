<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <% DateUtil dateUtil = new DateUtil();%>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var dollar = {};
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/currency/list",
            httpMethod: "GET",
            data: "",
            callback: function (RpcResponse_o) {
                if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                    var data = JSON.parse(RpcResponse_o.data);
                    for (x of data) {
                        dollar[x.nameEn] = x.nameEn;
                    }
                } //if rpc
            } // callback
        })
    );


    var RestDataSource_Shipment_InvoiceHeader = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {name: "contactId", type: 'long', hidden: true},
            {name: "contract.contact.nameFA"},
            {name: "contractId", type: 'long', hidden: true},
            {name: "contract.contractNo"},
            {name: "contract.contractDate"},
            {name: "materialId"},
            {name: "material.descl"},
            {name: "material.unit.nameEN"},
            {name: "amount"},
            {name: "shipmentType"},
            {name: "loadingLetter"},
            {name: "noContainer"},
            {name: "portByLoading.port"},
            {name: "portByDischarge.port"},
            {name: "description"},
            {name: "contractShipment.sendDate"},
            {name: "createDate"},
            {name: "month"},
            {name: "contactByAgent.nameFA"},
            {name: "vesselName"},
            {name: "swb"},
            {name: "switchPort.port"},
            {name: "status"}
        ],
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });

    //---------------------------------------
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
    var ToolStripButton_Shipment_InvoiceHeader_Refresh = isc.ToolStripButton.create({
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
            ToolStripButton_Shipment_InvoiceHeader_Refresh,
        ]
    });
    //-------------------

    var ListGrid_Shipment_InvoiceHeader = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment_InvoiceHeader,
        contextMenu: Menu_ListGrid_Shipment_InvoiceHeader,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contract.contact.nameFA", title: "<spring:message
		code='contact.name'/>", type: 'text', width: "20%", align: "center", showHover: true
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.contractNo", title: "<spring:message
		code='contract.contractNo'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "contract.contractDate", title: "<spring:message
		code='contract.contractDate'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descl", title: "<spring:message
		code='material.descl'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "material.unit.nameEN", title: "<spring:message
		code='unit.nameEN'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "amount", title: "<spring:message
		code='global.amount'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "shipmentType", title: "<spring:message
		code='shipment.shipmentType'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "loadingLetter", title: "<spring:message
		code='shipment.loadingLetter'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "noContainer", title: "<spring:message
		code='shipment.noContainer'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            <%--{name: "laycan", title:"<spring:message code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",showHover:true},--%>
            {
                name: "portByLoading.port", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "portByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%", showHover: true
            },
// {name: "dischargeAddress", title:"<spring:message
		code='global.address'/>", type:'text', required: true, width: "10%" ,showHover:true},
            {
                name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "contractShipment.sendDate", title: "<spring:message
		code='global.sendDate'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "createDate", title: "<spring:message
		code='global.createDate'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "month", title: "<spring:message
		code='shipment.month'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "contactByAgent.nameFA", title: "<spring:message
		code='shipment.agent'/>", type: 'text', width: "20%", align: "center", showHover: true
            },
            {
                name: "vesselName", title: "<spring:message
		code='shipment.vesselName'/>", type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "swb",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "switchPort.port", title: "<spring:message
		code='port.switchPort'/>", type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "status", title: "<spring:message
		code='shipment.staus'/>", type: 'text', width: "10%", align: "center", valueMap: {
                    "Load Ready": "<spring:message
		code='shipment.loadReady'/>", "Resource": "<spring:message code='shipment.resource'/>"
                }, showHover: true
            },

        ],
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
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
        },
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true
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
    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    var ViewLoader_Molybdenum = isc.ViewLoader.create({
        width: "100%",
        height: "100%",
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>",
    });
     var Window_Molybdenum = isc.Window.create({
        title: "<spring:message code='issuedInvoices.title'/> ",
        width: 1500,
        height: "90%",
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
                ViewLoader_Molybdenum
            ]
    });


    var RestDataSource_Invoice = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "id", canEdit: false, hidden: true},
            ],

        fetchDataURL: "${contextPath}/api/invoice/spec-list"
    });

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
            if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Copper Concentrate') {
                DynamicForm_Invoice_Concentrate.setValue("invoiceDateDumy", new Date(record.invoiceDate));
                DynamicForm_Invoice_Concentrate.setValue("RCCUCal",2204.62);
                DynamicForm_Invoice_Concentrate.editRecord(record);
                Window_Invoice_Concentrate.show();
                return;
            } else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
                        ViewLoader_Molybdenum.setViewURL("<spring:url value="/invoice/showForm" />/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id+"/"+record.id);
                        Window_Molybdenum.show();
                        return;
                DynamicForm_Invoice.getItem("copperUnitPrice").hide();
                DynamicForm_Invoice.getItem("copper").hide();
                DynamicForm_Invoice.getItem("goldUnitPrice").hide();
                DynamicForm_Invoice.getItem("gold").hide();
                DynamicForm_Invoice.getItem("silverUnitPrice").hide();
                DynamicForm_Invoice.getItem("silver").hide();
                DynamicForm_Invoice.getItem("molybdJenumUnitPrice").show();
                DynamicForm_Invoice.getItem("molybdenum").show();
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
                buttons: [isc.Button.create({
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var InvoiceId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                            actionURL: "${contextPath}/api/invoice/" + record.id,
                            httpMethod: "DELETE",
                            callback: function (resp) {
                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
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
                    if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Copper Concentrate') {
	                    DynamicForm_Invoice_Concentrate_AddNew(ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id);
                        return;
                    } else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
                        ViewLoader_Molybdenum.setViewURL("<spring:url value="/invoice/showForm" />/"+ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id+"/0");
                        Window_Molybdenum.show();
                        return;
                        DynamicForm_Invoice.getItem("copperUnitPrice").hide();
                        DynamicForm_Invoice.getItem("copper").hide();
                        DynamicForm_Invoice.getItem("goldUnitPrice").hide();
                        DynamicForm_Invoice.getItem("gold").hide();
                        DynamicForm_Invoice.getItem("silverUnitPrice").hide();
                        DynamicForm_Invoice.getItem("silver").hide();
                        DynamicForm_Invoice.getItem("molybdJenumUnitPrice").show();
                        DynamicForm_Invoice.getItem("molybdenum").show();
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
        numCols: 4, backgroundImage: "backgrounds/leaves.jpg",
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
                    defaultValue: "<%=dateUtil.todayDate()%>",
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
                    defaultValue: "DOLLAR",
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
                    defaultValue: "DOLLAR",
                    valueMap: dollar
                },
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - محتوی - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "copperUnitPrice", title: "<spring:message code='invoice.copperUnitPrice'/>",
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
                },

            ]
    });

     var DynamicForm_Invoice_Concentrate ;
	function hasValue(fld){
	 valueTmp=DynamicForm_Invoice_Concentrate.getValue(fld);
	 return !(valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" );
	}
    function multiply (fld1,value) {
		if (value==null || typeof (value)=='undefined' || fld1==null || typeof (fld1) =='undefined')
		   return 0;
		return fld1 * value;
	}
	function multiplyAndSet (name1,name2,setName0) {
	  val1=DynamicForm_Invoice_Concentrate.getValue(name1);
	  val2=DynamicForm_Invoice_Concentrate.getValue(name2);
	  m=multiply(val1,val2)/((name1=="paidPercent" || name2=="paidPercent") ? 100 : 1);
	  // console.log('name1= '+name1+' name2= '+name2+ ' setname= '+setName0+' mult='+m);
	  DynamicForm_Invoice_Concentrate_setValue(setName0,m);
	}
	function multiplyAndSet3 (name1,name2,setName0,number1) {
	  val1=DynamicForm_Invoice_Concentrate.getValue(name1);
	  val2=DynamicForm_Invoice_Concentrate.getValue(name2);
	  m=multiply(val1,val2)*number1;
	  // console.log('name1= '+name1+' name2= '+name2+ ' setname= '+setName0+' mult='+m);
	  DynamicForm_Invoice_Concentrate_setValue(setName0,m);
	}
	function DynamicForm_Invoice_Concentrate_getValue(fld){
	 valueTmp=DynamicForm_Invoice_Concentrate.getValue(fld);
	 return (valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" ) ? 0 : valueTmp;
	}
	function DynamicForm_Invoice_Concentrate_setValue(fld,value){
		DynamicForm_Invoice_Concentrate.setValue(fld,value);
		if ( fld=="copperCal" || fld=='goldCal' || fld=='silverCal' )
		   DynamicForm_Invoice_Concentrate_setValue("subTotal", DynamicForm_Invoice_Concentrate_getValue("copperCal") +
		                                                        DynamicForm_Invoice_Concentrate_getValue('goldCal') +
		                                                        DynamicForm_Invoice_Concentrate_getValue('silverCal'));
        if (fld=="copper")
        	DynamicForm_Invoice_Concentrate_setValue("RCCUPer",DynamicForm_Invoice_Concentrate.getValue(fld));
        if (fld=="silverOun")
        	DynamicForm_Invoice_Concentrate_setValue("RCAGPer",DynamicForm_Invoice_Concentrate.getValue(fld));
        if (fld=="goldOun")
        	DynamicForm_Invoice_Concentrate_setValue("RCAUPer",DynamicForm_Invoice_Concentrate.getValue(fld));
        if (fld=="RCCUPer")
        	multiplyAndSet3("RCCUPer","RCCU","RCCUTot",DynamicForm_Invoice_Concentrate.getValue("RCCUCal"));
        if (fld=="RCAGPer")
        	multiplyAndSet("RCAGPer","RCAG","RCAGTot");
        if (fld=="RCAUPer")
        	multiplyAndSet("RCAUPer","RCAU","RCAUTot");
		if (fld=="treatCost" || fld=="RCCUTot" || fld=='RCAGTot' || fld=='RCAUTot' )
		   DynamicForm_Invoice_Concentrate_setValue("subTotalDeduction", DynamicForm_Invoice_Concentrate_getValue("RCCUTot") +
		                                                        DynamicForm_Invoice_Concentrate_getValue('treatCost') +
		                                                        DynamicForm_Invoice_Concentrate_getValue('RCAGTot') +
		                                                        DynamicForm_Invoice_Concentrate_getValue('RCAUTot'));
		if ((fld=="subTotal" || fld=='subTotalDeduction' ) )
		   DynamicForm_Invoice_Concentrate_setValue("unitPrice", DynamicForm_Invoice_Concentrate_getValue("subTotal") -
		                                                        DynamicForm_Invoice_Concentrate_getValue('subTotalDeduction')) ;

// commercialInvoceValue=net*unitPrice
		if ((fld=="net" || fld=='unitPrice' ) && (hasValue("net") && hasValue('unitPrice') ))
			multiplyAndSet("net",'unitPrice',"commercialInvoceValue");
// commercialInvoceValueNet=paidPercent*commercialInvoceValue
		if ((fld=="paidPercent" || fld=='commercialInvoceValue' ) && (hasValue("paidPercent") && hasValue('commercialInvoceValue') ))
			multiplyAndSet("paidPercent",'commercialInvoceValue',"commercialInvoceValueNet");
// invoiceValueD=commercialInvoceValueNet- (beforePaid+otherCost+Depreciation)
		if ((fld=="commercialInvoceValueNet" || fld=='beforePaid'|| fld=='otherCost'|| fld=='Depreciation' ) )
		   DynamicForm_Invoice_Concentrate_setValue("invoiceValueD", DynamicForm_Invoice_Concentrate_getValue("commercialInvoceValueNet") -
		                                                        (DynamicForm_Invoice_Concentrate_getValue('beforePaid') +
		                                                        DynamicForm_Invoice_Concentrate_getValue('otherCost') +
		                                                        DynamicForm_Invoice_Concentrate_getValue('Depreciation')));
// invoiceValue=rate2dollar*invoiceValueD
		if ((fld=="rate2dollar" || fld=='invoiceValueD' ) && (hasValue("rate2dollar") && hasValue('invoiceValueD') ))
			multiplyAndSet("rate2dollar",'invoiceValueD',"invoiceValue");
	}
    var DynamicForm_Invoice_Concentrate = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100", margin: '0px', wrapTitle: true,
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 12, backgroundImage: "backgrounds/leaves.jpg",
        fields:
            [
                {name: "id", hidden: true},
                {name: "shipmentId", hidden: true},
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
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
                    name: "invoiceType",
                    title: "<spring:message code='invoice.invoiceType'/>",
                    type: 'text',
                    width: "100%",
                    required: true,
                    valueMap: {"PROVISIONAL": "PROVISIONAL", "FINAL": "FINAL", "PREPAID": "PREPAID"}
                },
                {
                    name: "invoiceNo", title: "<spring:message code='invoice.invoiceNo'/>",
                    required: true,
                    width: "100%",
                    wrapTitle: true,colSpan:2,titleColSpan:2
                },
                {
                    name: "invoiceDateDumy",
                    title: "<spring:message code='invoice.invoiceDate'/>",
                    defaultValue: "<%=dateUtil.todayDate()%>",
                    type: 'date',
                    format: 'DD-MM-YYYY',
                    required: true,
                    width: "100%",colSpan:3,titleColSpan:1
                },
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Assay calculation in one DMT- - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "copperIns",
                    title: "<spring:message code='invoice.copperIns'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
					  if (value!=null && typeof (value)!='undefined'){
                    	var tmp=DynamicForm_Invoice_Concentrate.getValue("copperDed");
                    	if (tmp!=null && typeof (tmp)!='undefined')
                    	    if (value<0)
		   						DynamicForm_Invoice_Concentrate_setValue("copper",(tmp * value)/100);
		   					else
		   						DynamicForm_Invoice_Concentrate_setValue("copper", (value - tmp)/100);
		   			  }
		   			    else DynamicForm_Invoice_Concentrate_setValue("copper","0");
		   			  multiplyAndSet("copper","copperUnitPrice","copperCal");
		   			}
                },
                {
                    name: "copperDed",
                    title: "<spring:message code='invoice.copperDed'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
					  if (value!=null && typeof (value)!='undefined'){
                    	var tmp=DynamicForm_Invoice_Concentrate.getValue("copperIns");
                    	if (tmp!=null && typeof (tmp)!='undefined')
                    	    if (value<0)
		   						DynamicForm_Invoice_Concentrate_setValue("copper",(tmp * value)/100);
		   					else
		   						DynamicForm_Invoice_Concentrate_setValue("copper",(tmp - value)/100);
		   			  }
		   			    else DynamicForm_Invoice_Concentrate_setValue("copper","0")
					  multiplyAndSet("copper","copperUnitPrice","copperCal");

		   			}

                },
                {
                    name: "copper",
                    title: "<spring:message code='invoice.copper'/>",
                    type: 'float',
                    required: false,canEdit:false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                },
                {
                    name: "copperUnitPrice", title: "<spring:message code='invoice.copperUnitPrice'/>",
                    type: 'float', required: false, width: "100%",colSpan:2,titleColSpan:1,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("copper","copperUnitPrice","copperCal");

		   			}
                },
                 {
                    name: "copperCal",
                    title: "<spring:message code='invoice.copperCal'/>",
                    type: 'float',
                    required: false,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:1,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "silverIns",
                    title: "<spring:message code='invoice.silverIns'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("silverIns","silverDed","silver");
		   			  	DynamicForm_Invoice_Concentrate_setValue("silverOun",DynamicForm_Invoice_Concentrate.getValue("silver")/31.1034);
		   			  	multiplyAndSet("silverOun","silverUnitPrice","silverCal");
		   			}

                },
                {
                    name: "silverDed",
                    title: "<spring:message code='invoice.silverDed'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("silverIns","silverDed","silver");
		   			  	DynamicForm_Invoice_Concentrate_setValue("silverOun",DynamicForm_Invoice_Concentrate.getValue("silver")/31.1034);
		   			  	multiplyAndSet("silverOun","silverUnitPrice","silverCal");
		   			}

                },
                {
                    name: "silver",
                    title: "<spring:message code='invoice.silver'/>",
                    type: 'float',
                    required: false,canEdit:false,
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
                    name: "silverOun",
                    title: "<spring:message code='invoice.silverOun'/>",
                    type: 'float',
                    required: false,canEdit:false,
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
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("silverIns","silverDed","silver");
		   			  	DynamicForm_Invoice_Concentrate_setValue("silverOun",DynamicForm_Invoice_Concentrate_getValue("silver")/31.1034);
		   			  	multiplyAndSet("silverOun","silverUnitPrice","silverCal");
		   			}

                },
                 {
                    name: "silverCal",
                    title: "<spring:message code='invoice.silverCal'/>",
                    type: 'float',
                    required: false,canEdit:false,
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
                    name: "goldIns",
                    title: "<spring:message code='invoice.goldIns'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("goldIns","goldDed","gold");
		   			  	DynamicForm_Invoice_Concentrate_setValue("goldOun",DynamicForm_Invoice_Concentrate_getValue("gold")/31.1034);
		   			  	multiplyAndSet("goldOun","goldUnitPrice","goldCal");
		   			}

                },
                {
                    name: "goldDed",
                    title: "<spring:message code='invoice.goldDed'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("goldIns","goldDed","gold");
		   			  	DynamicForm_Invoice_Concentrate_setValue("goldOun",DynamicForm_Invoice_Concentrate_getValue("gold")/31.1034);
		   			  	multiplyAndSet("goldOun","goldUnitPrice","goldCal");
		   			}
                },
                {
                    name: "gold",
                    title: "<spring:message code='invoice.gold'/>",
                    type: 'float',
                    required: false,canEdit:false,
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
                    name: "goldOun",
                    title: "<spring:message code='invoice.goldOun'/>",
                    type: 'float',
                    required: false,canEdit:false,
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
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("goldIns","goldDed","gold");
		   			  	DynamicForm_Invoice_Concentrate_setValue("goldOun",DynamicForm_Invoice_Concentrate_getValue("gold")/31.1034);
		   			  	multiplyAndSet("goldOun","goldUnitPrice","goldCal");
		   			}

                },
                 {
                    name: "goldCal",
                    title: "<spring:message code='invoice.goldCal'/>",
                    type: 'float',
                    required: false,canEdit:false,
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
                    name: "priceBase",
                    title: "<spring:message code='invoice.priceBase'/>",
                    type: 'text',
                    required: true,
                    width: "100%",colSpan:9,titleColSpan:1,
                },
                {
                    name: "subTotal",
                    title: "<spring:message code='invoice.subTotal'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:1,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - DEDUCTION  per one DMT- - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "treatCost",
                    title: "<spring:message code='invoice.TC'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:10,titleAlign:"left",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCCU",
                    title: "<spring:message code='invoice.RCCU'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"left",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCCUPer",
                    title: "<spring:message code='invoice.RCCUPerc'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"center",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCCUCal",
                    title: "<spring:message code='invoice.RCCUCal'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"center",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCCUTot",
                    title: "<spring:message code='invoice.RCCUTot'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:1,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCAG",
                    title: "<spring:message code='invoice.RCAG'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"left",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCAGPer",
                    title: "<spring:message code='invoice.RCCUPerc'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"center",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCAGTot",
                    title: "<spring:message code='invoice.RCCUTot'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:4,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCAU",
                    title: "<spring:message code='invoice.RCAU'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"left",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCAUPer",
                    title: "<spring:message code='invoice.RCCUPerc'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"center",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "RCAUTot",
                    title: "<spring:message code='invoice.RCCUTot'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:4,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                 {
                    name: "subTotalDeduction",
                    title: "<spring:message code='invoice.subTotalDed'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:10,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
               {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - INVOICE - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "unitPrice",
                    title: "<spring:message code='invoice.unitPrice'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:10,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                 {
                    name: "grass",
                    title: "<spring:message code='global.grass'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",colSpan:1,titleColSpan:2,titleAlign:"left",
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
                    keyPressFilter: "[0-9.]",colSpan:1,titleColSpan:2,titleAlign:"center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("net","unitPrice","commercialInvoceValue");
		   			}

                },
                {
                    name: "commercialInvoceValue",
                    title: "<spring:message code='invoice.commercialInvoceValue'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:4,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "paidPercent", title: "<spring:message code='invoice.paidPercent'/>",
                    type: 'float', required: true, width: "100%",colSpan:1,titleColSpan:5,titleAlign:"right",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        },
                        {
                            type: "integerRange",
                            min: 10,
                            max: 120,
                            errorMessage: "<spring:message code='invoice.form.paidPercent.prompt'/>"
                        }
                    ],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("paidPercent","commercialInvoceValue","commercialInvoceValueNet");
		   			}

                },
                {
                    name: "commercialInvoceValueNet",
                    title: "<spring:message code='invoice.commercialInvoceValueNet'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:4,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "Depreciation",
                    title: "<spring:message code='invoice.Depreciation'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    wrapTitle: true,
                    titleColSpan: 1,colSpan: 1,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Concentrate_setValue("Depreciation",value);
		   			}
               },
                {
                    name: "otherCost",
                    title: "<spring:message code='invoice.otherCost'/>",
                    type: 'float',
                    required: false,
                    width: "100%",colSpan:2,titleColSpan: 1,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Concentrate_setValue("otherCost",value);
		   			}

                },
                {
                    name: "beforePaid",
                    title: "<spring:message code='invoice.beforePaid'/>",
                    type: 'float',
                    required: false,colSpan:2, titleColSpan: 1, wrapTitle: true,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Concentrate_setValue("beforePaid",value);
		   			}
                },
                {
                    name: "invoiceValueD", title: "<spring:message code='invoice.invoiceValueD'/>",
                    type: 'float', required: true, width: "100%",colSpan:2,titleColSpan:2,titleAlign:"right",canEdit:false,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
               {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - Currency - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
               {
                    name: "rateBase",
                    title: "<spring:message code='invoice.rateBase'/>",
                    type: 'text',
                    required: true,
                    width: "100%",colSpan:4,titleColSpan:1,
                },
                 {
                    name: "rate2dollar", title: "<spring:message code='invoice.rate2dollar'/>",keyPressFilter: "[0-9.]",
                    type: 'float', required: true, width: "100%",colSpan:1,titleColSpan:1,titleAlign:"right",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        },
                    ],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("rate2dollar","invoiceValueD","invoiceValue");
		   			}

                },
                {
                    name: "invoiceValueCurrency",
                    title: "<spring:message code='invoice.invoiceValueCur'/>",
                    type: 'text',
                    width: "100%",colSpan:1,titleColSpan:1,titleAlign:"center",
                    defaultValue: "DOLLAR",
                    valueMap: dollar
                },
                {
                    name: "invoiceValue",
                    title: "<spring:message code='invoice.invoiceValue'/>",
                    type: 'float',canEdit:false,
                    required: true,
                    width: "100%",colSpan:2,titleColSpan:1,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ],
    });

    var ToolStripButton_Invoice_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Invoice_refresh();
        }
    });

    var ToolStripButton_Invoice_Add = isc.ToolStripButton.create({
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
                if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Copper Concentrate') {
                    DynamicForm_Invoice_Concentrate_AddNew(record.id);
                    return;
                } else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
                       ViewLoader_Molybdenum.setViewURL("<spring:url value="/invoice/showForm" />/"+record.id+"/0");
                       Window_Molybdenum.show();
                        return;
                }
                DynamicForm_Invoice.clearValues();
                DynamicForm_Invoice.setValue("shipmentId", record.id);
                Window_Invoice.show();
            }
        }
    });
    function DynamicForm_Invoice_Concentrate_AddNew(iidd) {
		DynamicForm_Invoice_Concentrate.clearValues();
		DynamicForm_Invoice_Concentrate.setValue("shipmentId", iidd);
		DynamicForm_Invoice_Concentrate.setValue("treatCost",109.0);
		DynamicForm_Invoice_Concentrate.setValue("RCCU",0.109);
		DynamicForm_Invoice_Concentrate.setValue("RCCUCal",2204.62);
		DynamicForm_Invoice_Concentrate.setValue("RCAG",0.35);
		DynamicForm_Invoice_Concentrate.setValue("RCAU",5);
		Window_Invoice_Concentrate.show();
    }
    var ToolStripButton_Invoice_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Invoice.clearValues();
            ListGrid_Invoice_edit();
        }
    });

    var ToolStripButton_Invoice_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Invoice_remove();
        }
    });

    var ToolStrip_Actions_Invoice = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Invoice_Refresh,
                ToolStripButton_Invoice_Add,
                ToolStripButton_Invoice_Edit,
                ToolStripButton_Invoice_Remove
            ]
    });

    var HLayout_Invoice_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Invoice
            ]
    });

    var IButton_Invoice_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
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
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
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
                            isc.IButton.create({
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
    var IButton_Invoice_Concentrate_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Invoice_Concentrate.validate();
            if (DynamicForm_Invoice_Concentrate.hasErrors())
                return;
            var drs = DynamicForm_Invoice_Concentrate.getValue("invoiceDateDumy");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Invoice_Concentrate.setValue("invoiceDate", datestringRs);
            DynamicForm_Invoice_Concentrate.setValue("shipmentId", ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id);

            var data = DynamicForm_Invoice_Concentrate.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                actionURL: "${contextPath}/api/invoice/",
                httpMethod: method,
                data: JSON.stringify(data),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_Invoice_refresh();
                        Window_Invoice_Concentrate.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });
    var Window_Invoice_Concentrate = isc.Window.create({
        title: "<spring:message code='issuedInvoices.title'/> ",
        width: 1100,
        height: 700,
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
                DynamicForm_Invoice_Concentrate,
                isc.HLayout.create({
                    width: "100%", align: "center", height: "20",
                    members:
                        [
                            IButton_Invoice_Concentrate_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Invoice_Concentrate.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_Invoice = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Invoice,
        contextMenu: Menu_ListGrid_Invoice,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
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
                {name: "otherCost", title: "<spring:message code='invoice.otherCost'/>", type: 'float', width: "10%"},
                {
                    name: "copperUnitPrice",
                    title: "<spring:message code='invoice.copperUnitPrice'/>",
                    type: 'float',
                    width: "10%"
                },
                {name: "copper", title: "<spring:message code='invoice.copper'/>", type: 'float', width: "10%"},
                {
                    name: "goldUnitPrice",
                    title: "<spring:message code='invoice.goldUnitPrice'/>",
                    type: 'float',
                    width: "10%"
                },
                {name: "gold", title: "<spring:message code='invoice.gold'/>", type: 'float', width: "10%"},
                {
                    name: "silverUnitPrice",
                    title: "<spring:message code='invoice.silverUnitPrice'/>",
                    type: 'float',
                    width: "10%"
                },
                {name: "silver", title: "<spring:message code='invoice.silver'/>", type: 'float', width: "10%"},
                {
                    name: "molybdJenumUnitPrice", title: "<spring:message code='invoice.molybdJenumUnitPrice'/>", type: 'float', width: "10%"
                },
                {name: "molybdenum", title: "<spring:message code='invoice.molybdenum'/>", type: 'float', width: "10%"},
            ],
        sortField: 0,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        },
        dataArrived: function (startRow, endRow) {
        }

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

    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


    isc.SectionStack.create({
        ID: "Shipment_InvoiceHeader_Section_Stack",
        sections:
            [
                {
                    title: "<spring:message code='Shipment.title'/>",
                    items: VLayout_Body_Shipment_InvoiceHeader,
                    expanded: true
                }
                , {title: "<spring:message code='issuedInvoices.title'/>", items: VLayout_Invoice_Body, expanded: true}
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });
