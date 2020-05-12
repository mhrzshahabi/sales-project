<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

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

    var ToolStripButton_Shipment_InvoiceHeader_Refresh = isc.ToolStripButtonRefresh.create({
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
        contents: "<spring:message code='global.record.find'/>"
    });

    recordNotFound.hide();

    function setCriteria_ListGrid_Invoice(recordId) {
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: recordId}]
        };


        ListGrid_Invoice.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            if (data.length == 0) {
                recordNotFound.show();
                ListGrid_Invoice.hide()
            } else {
                recordNotFound.hide();
                ListGrid_Invoice.setData(data);
                ListGrid_Invoice.show();
            }
        }, {operationId: "00"});
    }

    function getExpandedComponent_Invoice(record) {
        setCriteria_ListGrid_Invoice(record.id)
        var hLayout_Invoice = isc.HLayout.create({
            align: "center", padding: 5,
            membersMargin: 20,
            members: [
                HLayout_Invoice_Actions
            ]
        });

        var layout_ListGrid_Invoice = isc.VLayout.create({
            styleName: "expand-layout",
            padding: 5,
            membersMargin: 10,
            members: [ListGrid_Invoice, recordNotFound, hLayout_Invoice]
        });

        return layout_ListGrid_Invoice;
    }


    var ListGrid_Shipment_InvoiceHeader = isc.ListGrid.create({
        showFilterEditor: true,
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment_InvoiceHeader,
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
                name: "contract.contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "contract.contractDate",
                title: "<spring:message	code='contract.contractDate'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descl",
                title: "<spring:message		code='material.descl'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "material.unit.nameEN",
                title: "<spring:message		code='unit.nameEN'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "amount",
                title: "<spring:message		code='global.amount'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "shipmentType",
                title: "<spring:message		code='shipment.shipmentType'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "loadingLetter",
                title: "<spring:message		code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "noContainer",
                title: "<spring:message		code='shipment.noContainer'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "portByLoading.port",
                title: "<spring:message		code='shipment.loading'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [{
                    type: "required",
                    validateOnChange: true
                }]
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message		code='shipment.discharge'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [{
                    type: "required",
                    validateOnChange: true
                }]
            },

            {
                name: "month", title: "<spring:message code='shipment.month'/>",
                type: 'text', required: true, width: "10%", align: "center", showHover: true,
                validators: [{type: "required", validateOnChange: true}]
            },

            {
                name: "status",
                title: "<spring:message	code='shipment.staus'/>",
                type: 'text',
                width: "10%",
                align: "center",
                valueMap: {
                    "Load Ready": "<spring:message	code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                },
                showHover: true
            },

        ],
        getExpansionComponent: function (record) {
            return getExpandedComponent_Invoice(record)
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

    var RestDataSource_Invoice = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "id", canEdit: false, hidden: true},
                {name: "processId", title: "<spring:message code='invoice.processId'/>", width: "10%"},
                {name: "invoiceNo", title: "<spring:message code='invoice.invoiceNo'/>", width: "10%"},
                {name: "invoiceDate"},
                {name: "invoiceType"},
                {name: "net",},
                {name: "gross"},
                {name: "unitPrice"},
                {name: "unitPriceCurrency"},
                {name: "invoiceValue"},
                {name: "invoiceValueCurrency"},
                {name: "paidPercent"},
                {name: "paidStatus"}
            ],
        fetchDataURL: "${contextPath}/api/invoice/spec-list"
    });

    function Window_Invoice_Attachment_Open() {
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
            ListGrid_Invoice.show();
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
                    title: "<spring:message code='global.yes'/>"
                }), isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var InvoiceId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
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
    }

    var DynamicForm_Invoice = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        titleWidth: "100",
        margin: '10px',
        wrapTitle: false,
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4,
        fields:
            [
                {name: "id", hidden: true},
                {name: "shipmentId", hidden: true},
                {
                    name: "invoiceType",
                    title: "<spring:message code='invoice.invoiceType'/>",
                    type: 'text',
                    width: "100%",
                    required: true,
                    valueMap: {"PROVISIONAL": "PROVISIONAL", "FINAL": "FINAL", "PREPAID": "PREPAID"},
                    validators: [{
                        type: "required",
                        validateOnChange: true
                    }]
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
                    wrapTitle: false,
                    validators: [{
                        type: "required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "invoiceDate",
                    title: "<spring:message code='invoice.invoiceDate'/>",
                    defaultValue: "<%=DateUtil.todayDate()%>",
                    type: 'date',
                    format: 'DD-MM-YYYY HH:mm:ss',
                    required: true,
                    width: "100%",
                    validators: [{
                        type: "required",
                        validateOnChange: true
                    }]
                },
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "gross",
                    title: "<spring:message code='global.grass'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },
                {
                    name: "net",
                    title: "<spring:message code='global.net'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },
                {
                    name: "unitPrice",
                    title: "<spring:message code='global.unitPrice'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                        {
                            type: "required",
                            validateOnChange: true
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
                        },
                        {
                            type: "required",
                            validateOnChange: true
                        }
                    ]
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
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                        {
                            type: "required",
                            validateOnChange: true
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
                    name: "copper",
                    title: "<spring:message code='invoice.copper'/>",
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
                    name: "copperUnitPrice", title: "<spring:message code='invoice.copperUnitPrice'/>",
                    type: 'float', required: false, width: "100%",
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
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                }
            ]
    });

    <sec:authorize access="hasAuthority('C_INVOICE')">
    var ToolStripButton_Invoice_Add = isc.ToolStripButtonAdd.create({
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
                DynamicForm_Invoice.clearValues();
                DynamicForm_Invoice.setValue("shipmentId", record.id);
                Window_Invoice.show();
            }
        }
    });
    </sec:authorize>

    var ToolStripButton_Invoice_Attachment = isc.ToolStripButton.create({
        title: "<spring:message code='global.Attachment'/>", icon: "pieces/512/attachment.png",
        click: function () {
            Window_Invoice_Attachment_Open();
        }
    });

    function ToolStripButton_Invoice_Pdf_F() {

        var record = ListGrid_Invoice.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_Invoice.getSelectedRecord().id;
            window.open("invoice/print/pdf/" + rowId);
        }
    }

    function ToolStripButton_Invoice_Html_F() {

        var record = ListGrid_Invoice.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_Invoice.getSelectedRecord().id;
            window.open("invoice/print/html/" + rowId);
        }
    }

    function ToolStripButton_Invoice_Excel_F() {

        var record = ListGrid_Invoice.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            var rowId = ListGrid_Invoice.getSelectedRecord().id;
            window.open("invoice/print/xlsx/" + rowId);
        }
    }

    <%--<sec:authorize access="hasAuthority('O_INVOICE')">
    var ToolStripButton_Invoice_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.pdf'/>",
        icon: "icon/pdf.png",
        click: function () {
            ToolStripButton_Invoice_Pdf_F();
        }
    });
    </sec:authorize>--%>

    <%--<sec:authorize access="hasAuthority('O_INVOICE')">
    var ToolStripButton_Invoice_excel = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.excel'/>",
        icon: "icon/excel.png",
        click: function () {
            ToolStripButton_Invoice_Excel_F();
        }
    });

    </sec:authorize>--%>

    <%--<sec:authorize access="hasAuthority('O_INVOICE')">
    var ToolStripButton_Invoice_html = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.html'/>",
        icon: "icon/html.jpg",
        click: function () {
            ToolStripButton_Invoice_Html_F();
        }
    });
    </sec:authorize>--%>

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
            } else if (record.processId == null || typeof record.processId == 'undefined') {
                var data2acc = {};
                var iiid = record.id;
                var iiinvoice = record.invoiceNo;
                data2acc["documentId"] = iiid.toString();
                data2acc["internal"] = "خارجی";
                data2acc["documentNo"] = iiinvoice.toString();
                data2acc["documentDate"] = record.invoiceDate;
                data2acc["company"] = ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contract.contact.nameFA + '-' +
                    ListGrid_Shipment_InvoiceHeader.getSelectedRecord().contract.contractNo;
                data2acc["price"] = record.invoiceValueCurrency + record.invoiceValue;
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: "${contextPath}/api/invoice/sendForm-2accounting/" + record.id,
                        httpMethod: "PUT",
                        data: JSON.stringify(data2acc),
                        callback: function (resp) {
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
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
        backgroundColor: 'transparent',
        border: 'transparent',
        members:
            [
                <sec:authorize access="hasAuthority('C_INVOICE')">
                ToolStripButton_Invoice_Add,
                </sec:authorize>
                /*        ToolStripButton_Invoice_Edit,
                        ToolStripButton_Invoice_Remove,*/
                ToolStripButton_Invoice_Attachment,
                ToolStripButton_Invoice_Send2Accounting,
                <%--<sec:authorize access="hasAuthority('O_INVOICE')">--%>
                <%--ToolStripButton_Invoice_Pdf,--%>
                <%--</sec:authorize>--%>

                <%--<sec:authorize access="hasAuthority('O_INVOICE')">--%>
                <%--ToolStripButton_Invoice_excel,--%>
                <%--</sec:authorize>--%>

                <%--<sec:authorize access="hasAuthority('O_INVOICE')">--%>
                <%--ToolStripButton_Invoice_html,--%>
                <%--</sec:authorize>--%>

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
            var drs = DynamicForm_Invoice.getValue("invoiceDate");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Invoice.setValue("invoiceDate", datestringRs);
            DynamicForm_Invoice.setValue("shipmentId", ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id);
            var data = DynamicForm_Invoice.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/invoice/",
                httpMethod: method,
                data: JSON.stringify(data),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
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
        width: 650,
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
        showFilterEditor: true,
        width: "100%",
        height: 200,
        styleName: "listgrid-child",
        dataSource: RestDataSource_Invoice,
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
                {name: "gross", title: "<spring:message code='global.grass'/>", type: 'float', width: "10%"},
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
        autoFetchData: false,
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
        sections:
            [
                {
                    title: "<spring:message code='Shipment.title'/>",
                    items: VLayout_Body_Shipment_InvoiceHeader,
                    expanded: true,
                    showHeader: false
                },
                {
                    title: "<spring:message code='issuedInvoices.title'/>",
                    items: VLayout_Invoice_Body,
                    expanded: true,
                    hidden: true
                }
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });