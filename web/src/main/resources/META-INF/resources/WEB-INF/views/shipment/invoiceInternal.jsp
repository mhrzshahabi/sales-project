<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    var RestDataSource_InvoiceInternal = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id"},
                {name: "lcId"},
                {name: "remittanceId"},
                {name: "invoiceDate"},
                {name: "buyerId"},
                {name: "customerId"},
                {type: 'integer', name: "productId"},
                {type: 'float', name: "invoiceOtherDeductions"},
                {name: "remittanceFinalDate"},
                {type: 'float', name: "realWeight"},
                {type: 'float', name: "unitPrice"},
                {type: 'float', name: "totalDeductions"},
                {type: 'float', name: "totalAmount"},
                {name: "invoiceSerial"},
                {type: 'float', name: "taxChargeAmount"},
                {type: 'float', name: "pollutionChargeAmount"},
                {name: "invoiceSent"},
                {type: 'integer', name: "salesType"},
                {type: 'integer', name: "hasPollution"},
                {name: "nosaPollutionCode"},
                {name: "pollutionCostCenterCode"},
                {type: 'integer', name: "hasTax"},
                {name: "nosaTaxCode"},
                {name: "taxCostCenterCode"},
                {name: "nosaBankCode"},
                {name: "nosaCustomerCode"},
                {name: "nosaCustomerCreditCode"},
                {name: "customerCostCenterCode"},
                {name: "lcCostCenterCode"},
                {name: "nosaProductCode"},
                {name: "productCostCenterCode"},
                {name: "bankGroupDesc"},
                {name: "customerName"},
                {name: "productName"},
                {name: "nosaProductGroupCode"},
                {name: "productGroupName"},
                {name: "lcDueDate"},
                {name: "estatus"},
                {name: "documentId"}
            ],
        fetchDataURL: "${contextPath}/api/invoiceInternal/spec-list"
    });
    var RestDataSource_InvoiceInternal_Sent = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id"},
                {name: "lcId"},
                {name: "remittanceId"},
                {name: "invoiceDate"},
                {name: "buyerId"},
                {name: "customerId"},
                {type: 'integer', name: "productId"},
                {type: 'float', name: "invoiceOtherDeductions"},
                {name: "remittanceFinalDate"},
                {type: 'float', name: "realWeight"},
                {type: 'float', name: "unitPrice"},
                {type: 'float', name: "totalDeductions"},
                {type: 'float', name: "totalAmount"},
                {name: "invoiceSerial"},
                {type: 'float', name: "taxChargeAmount"},
                {type: 'float', name: "pollutionChargeAmount"},
                {name: "invoiceSent"},
                {type: 'integer', name: "salesType"},
                {type: 'integer', name: "hasPollution"},
                {name: "nosaPollutionCode"},
                {name: "pollutionCostCenterCode"},
                {type: 'integer', name: "hasTax"},
                {name: "nosaTaxCode"},
                {name: "taxCostCenterCode"},
                {name: "nosaBankCode"},
                {name: "nosaCustomerCode"},
                {name: "nosaCustomerCreditCode"},
                {name: "customerCostCenterCode"},
                {name: "lcCostCenterCode"},
                {name: "nosaProductCode"},
                {name: "productCostCenterCode"},
                {name: "bankGroupDesc"},
                {name: "customerName"},
                {name: "productName"},
                {name: "nosaProductGroupCode"},
                {name: "productGroupName"},
                {name: "lcDueDate"},
                {name: "estatus"},
                {name: "documentId"}
            ],
        fetchDataURL: "${contextPath}/api/invoiceInternal/spec-list"
    });
    var RestDataSource_InvoiceInternal_Deleted = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id"},
                {name: "lcId"},
                {name: "remittanceId"},
                {name: "invoiceDate"},
                {name: "buyerId"},
                {name: "customerId"},
                {type: 'integer', name: "productId"},
                {type: 'float', name: "invoiceOtherDeductions"},
                {name: "remittanceFinalDate"},
                {type: 'float', name: "realWeight"},
                {type: 'float', name: "unitPrice"},
                {type: 'float', name: "totalDeductions"},
                {type: 'float', name: "totalAmount"},
                {name: "invoiceSerial"},
                {type: 'float', name: "taxChargeAmount"},
                {type: 'float', name: "pollutionChargeAmount"},
                {name: "invoiceSent"},
                {type: 'integer', name: "salesType"},
                {type: 'integer', name: "hasPollution"},
                {name: "nosaPollutionCode"},
                {name: "pollutionCostCenterCode"},
                {type: 'integer', name: "hasTax"},
                {name: "nosaTaxCode"},
                {name: "taxCostCenterCode"},
                {name: "nosaBankCode"},
                {name: "nosaCustomerCode"},
                {name: "nosaCustomerCreditCode"},
                {name: "customerCostCenterCode"},
                {name: "lcCostCenterCode"},
                {name: "nosaProductCode"},
                {name: "productCostCenterCode"},
                {name: "bankGroupDesc"},
                {name: "customerName"},
                {name: "productName"},
                {name: "nosaProductGroupCode"},
                {name: "productGroupName"},
                {name: "lcDueDate"},
                {name: "estatus"},
                {name: "documentId"}
            ],
        fetchDataURL: "${contextPath}/api/invoiceInternal/spec-list"
    });
    var departmentDS = isc.MyRestDataSource.create({
        fields: [
            {name: "id", primaryKey: true, type: "integer", title: " ID"},
            {name: "departmentName", title: "<spring:message code='department.name'/>"},
            {name: "departmentCode", title: "<spring:message code='department.code'/>"}
        ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "${contextPath}/api/accounting/departments"
    });

    var mainValuesManager = isc.ValuesManager.create({});
    var mainInvoiceInfoForm = isc.DynamicForm.create({
        width: "90%",
        autoDraw: false,
        canEdit: true,
        autoFetchData: false,
        numCols: 4,
        margin: 15,
        wrapItemTitles: false,
        valuesManager: mainValuesManager,
        fields: [
            {

                name: "remittanceId",
                canEdit: false,
                title: "<spring:message code='invoice.havalehId'/>",
                width: "100%"
            },
            {
                name: "customerName",
                title: "<spring:message code='invoice.customerName'/>",
                width: "100%",
                canEdit: false,
            },
            {
                name: "invoiceSerial",
                canEdit: false,
                title: "<spring:message code='invoice.shomarehSoratHesab'/>",
                width: "100%"
            },
            {
                name: "productName", title: "<spring:message code='invoice.gdsName'/>",
                width: "100%",
                canEdit: false,
            },
            {
                name: "unitPrice", title: "<spring:message code='invoice.ghematUnit'/>",
                width: "100%",
                canEdit: false,
            },
            {
                name: "totalAmount",
                title: "<spring:message code='invoice.mablaghKol'/>",
                width: "100%",
                canEdit: false,
            },
            {
                name: "totalDeductions",
                title: "<spring:message code='invoice.totalKosorat'/>",
                width: "100%",
                canEdit: false,
            },
            {
                name: "invoiceDate",
                title: "<spring:message code='provisionalInvoice.refDate'/>",
                width: "100%",
                wrapTitle: false,
                length: 10,
                canEdit: false,
            },
            {
                name: "salesType",
                canEdit: false,
                valueMap: {"2": "??????????????", "1": "????????"},
                title: "<spring:message code='invoice.typeForosh'/>",
                width: "100%",
            },
            {
                name: "realWeight",
                title: "<spring:message code='invoice.weightReal'/>",
                canEdit: false,
                width: "100%",
            },
            {
                name: "bankGroupDesc",
                title: "<spring:message code='invoice.bankGroupDesc'/>",
                canEdit: false,
                width: "100%",
            }
        ]
    });
    var mainDocumentInfoForm = isc.DynamicForm.create({
        width: "90%",
        height: "100%",
        autoDraw: false,
        canEdit: true,
        autoFetchData: false,
        numCols: 4,
        margin: 15,
        valuesManager: mainValuesManager,
        fields: [
            {
                name: "department.id", title: "<spring:message code='department.name'/>",
                required: true,
                editorType: "select",
                wrapTitle: false,
                optionDataSource: departmentDS,
                valueField: "id",
                displayField: "departmentName",
                width: "100%",
                pickListWidth: "250",
                allowAdvancedCriteria: false,
                autoFetchData: false,
                pickListFields: [
                    {name: "departmentCode", width: "30%"},
                    {name: "departmentName", width: "70%"}
                ],
                showErrorText: true,
                showErrorStyle: true,
                errorOrientation: "bottom",
                requiredMessage: '<spring:message code="validator.field.is.required"/>',
                validators: [{
                    type: "required",
                    validateOnChange: true
                }]
            },
            {
                name: "documentDate",
                required: true,
                title: "<spring:message code='document.header.date'/>",
                icons: [persianDatePicker],
                wrapTitle: false,
                type: "persianDate",
                width: "100%",
                length: 10,
                keyPressFilter: "[0-9/]",
                showErrorText: true,
                showErrorStyle: true,
                errorOrientation: "bottom"
            },
            {
                name: "documentTitle",
                title: "<spring:message code='document.header.desc'/>",
                type: "textArea",
                colSpan: "4",
                width: "100%",
                wrapTitle: false
            },
        ]
    });

    var IButton_Document_Save = isc.IButtonSave.create({
        title: "<spring:message code='accounting.document.create'/>",
        click: function () {

            mainValuesManager.validate();
            if (mainValuesManager.hasErrors()) {
                return;
            }
            let grid = invoiceInternalTabs.getTab(invoiceInternalTabs.selectedTab).pane.members.get(1);
            let record = grid.getSelectedRecord();
            if (!record || !record.id) {
                let ERROR = isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function () {
                        this.hide();
                    }
                });
                setTimeout(function () {
                    ERROR.hide();
                }, 3000);
                return;
            }
            let data = isc.clone(mainValuesManager.getValues());
            data.department = data.department.id;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/accounting/documents/internal/" + record.id,
                httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(data),
                willHandleError: true,
                serverOutputAsString: false,
                prompt: "<spring:message code='global.server.sending-to-accounting'/>",
                callback: function (RpcResponse_o) {

                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                        let data = JSON.stringify(RpcResponse_o.data).split("@");
                        record.documentId = data[1].replace("\"", "");
                        record.estatus.add(Enums.eStatus2.SendToAcc);
                        isc.say(data[0]);
                        newDocumentWindow.close();
                        grid.getCellCSSText(record);
                        grid.refreshRow(grid.getRowNum(record));
                    } else {

                        newDocumentWindow.close();
                        record.documentId = -1;
                        grid.getCellCSSText(record);
                        grid.refreshRow(grid.getRowNum(record));
                        isc.RPCManager.handleError(RpcResponse_o, null);
                    }

                }

            }));
        }
    });
    var IButton_Windows_Close = isc.IButtonCancel.create({
        click: function () {
            newDocumentWindow.close();
        }
    });
    var windows_button_Layout = isc.HLayout.create({
        width: "100%",
        height: "10",
        margin: 10,
        membersMargin: 10,
        members: [
            IButton_Document_Save,
            IButton_Windows_Close
        ]
    });
    var newDocumentWindow = isc.Window.create({
        title: "<spring:message code='accounting.document.create'/>",
        width: 800,
        height: 600,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        showMinimizeButton: false,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            isc.Label.create({
                margin: 10,
                height: 5,
                align: "right",
                contents: "<h3 style='text-align: right;padding-right:20px'>"
                    + "<spring:message code='invoice.invoiceInfo'/>" +
                    "</h3>"
            }),
            isc.HTMLFlow.create({
                width: "100%",
                contents: "<span style='width: 100%; display: block; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
            }),
            mainInvoiceInfoForm,
            isc.Label.create({
                margin: 10,
                height: 5,
                align: "right",
                contents: "<h3 style='text-align: right;padding-right:20px'>"
                    + "<spring:message code='invoice.documentInfo'/>" +
                    "</h3>"
            }),
            isc.HTMLFlow.create({
                width: "100%",
                contents: "<span style='width: 100%; display: block; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
            }),
            mainDocumentInfoForm,
            windows_button_Layout
        ]
    });

    function createAccountingDoc() {

        mainInvoiceInfoForm.clearValues();
        mainDocumentInfoForm.clearValues();
        mainValuesManager.clearValues();
        let grid = invoiceInternalTabs.getTab(invoiceInternalTabs.selectedTab).pane.members.get(1);
        var record = grid.getSelectedRecord();
        if (record == null) {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else if ((record.estatus.contains(Enums.eStatus2.Final) || record.estatus.contains(Enums.eStatus2.RemoveFromAcc)) && !record.estatus.contains(Enums.eStatus2.SendToAcc)) {
            mainValuesManager.setValue("remittanceId", record.remittanceId);
            mainValuesManager.setValue("customerName", record.customerName);
            mainValuesManager.setValue("invoiceSerial", record.invoiceSerial);
            mainValuesManager.setValue("productName", record.productName);
            mainValuesManager.setValue("unitPrice", record.unitPrice);
            mainValuesManager.setValue("totalAmount", record.totalAmount);
            mainValuesManager.setValue("totalDeductions", record.totalDeductions);
            mainValuesManager.setValue("salesType", record.salesType);
            mainValuesManager.setValue("realWeight", record.realWeight);
            mainValuesManager.setValue("bankGroupDesc", record.bankGroupDesc);
            mainValuesManager.setValue("invoiceDate", record.invoiceDate);

            newDocumentWindow.show();
        } else isc.say("<spring:message code='accounting.create.document.sent'/>");
    }
    function changeStatusAccountingDoc() {
        let criteria = {};
        Object.assign(criteria, ListGrid_InvoiceInternal_Deleted.defaultCriteria);
        criteria.criteria = criteria.criteria.concat(ListGrid_InvoiceInternal_Sent.implicitCriteria.criteria);

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/invoiceInternal/update-deleted-document",
            httpMethod: "GET",
            params: {
                criteria: criteria
            },
            useSimpleHttp: true,
            contentType: "application/json; charset=utf-8",
            willHandleError: true,
            serverOutputAsString: false,
            callback: function (RpcResponse_o) {
                if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                    InvoiceInternal_FilterForm_Deleted.getItem("filterType").changed();
                    ListGrid_InvoiceInternal_refresh();
                }
            }
        }));
    }
    function ToolStripButton_InvoiceInternal_Pdf_F() {

        let grid = invoiceInternalTabs.getTab(invoiceInternalTabs.selectedTab).pane.members.get(1);
        var record = grid.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            window.open("invoiceInternal/print/pdf/" + record.id);
        }
    }
    function ToolStripButton_InvoiceInternal_Html_F() {

        let grid = invoiceInternalTabs.getTab(invoiceInternalTabs.selectedTab).pane.members.get(1);
        var record = grid.getSelectedRecord();
        if (record == null || record == " ") {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            window.open("invoiceInternal/print/html/" + record.id);
        }
    }
    function ListGrid_InvoiceInternal_refresh() {
        let grid = invoiceInternalTabs.getTab(invoiceInternalTabs.selectedTab).pane.members.get(1);
        grid.invalidateCache();
    }

    <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
    var ToolStripButton_AccountingDoc = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='accounting.document.create'/>",
        icon: "pieces/receipt.png",
        click: function () {

            createAccountingDoc();
        }
    });
    </sec:authorize>
    <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='InternalInvoices.invoice-print'/>",
        icon: "icon/pdf.png",
        click: function () {
            ToolStripButton_InvoiceInternal_Pdf_F();
        }
    });
    </sec:authorize>
    var ToolStripButton_InvoiceInternal_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_InvoiceInternal_refresh();
        }
    });

    var InvoiceInternal_FilterForm = isc.DynamicForm.create({
        numCols: 8,
        height: "100%",
        canSubmit: true,
        wrapItemTitles: false,
        fields: [
            {
                name: "filterType",
                type: "SelectItem",
                valueMap: {
                    "daily": "<spring:message code='global.daily'/>",
                    "weekly": "<spring:message code='global.weekly'/>",
                    "monthly": "<spring:message code='global.monthly'/>",
                    "yearly": "<spring:message code='global.yearly'/>",
                    "all": "<spring:message code='global.all'/>",
                    "custom": "<spring:message code='global.custom'/>"
                },
                value: "weekly",
                title: "<spring:message code='global.form.choose.filter'/>",
                changed: function () {

                    let now = new persianDate();
                    let filterEditorCriteriaList = [];
                    let filterEditorCriteria = ListGrid_InvoiceInternal.getFilterEditorCriteria();
                    if (filterEditorCriteria && filterEditorCriteria.criteria)
                        filterEditorCriteriaList = filterEditorCriteria.criteria.filter(q => !["documentId", "invoiceDate"].contains(q.fieldName));

                    switch (this.getValue()) {
                        case "all": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [{
                                    fieldName: 'invoiceDate',
                                    operator: 'notNull'
                                }]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal.filterData(criteria);
                            break;
                        }
                        case "daily": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'equals',
                                        value: now.format('YYYY/MM/DD').toString()
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal.filterData(criteria);
                            break;
                        }
                        case "weekly": {

                            let firstDay = now.date() - now.day() + 1;
                            let lastDay = firstDay + 6;
                            let firstDate = now.format("YYYY/MM/") + firstDay.toString().padStart(2, "0");
                            let lastDate = now.format("YYYY/MM/") + lastDay.toString().padStart(2, "0");
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'iBetweenInclusive',
                                        start: firstDate,
                                        end: lastDate
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal.filterData(criteria);
                            break;
                        }
                        case "monthly": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'startsWith',
                                        value: now.format('YYYY/MM/DD').toString().substring(0, 7)
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal.filterData(criteria);
                            break;
                        }
                        case "yearly": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'startsWith',
                                        value: now.format('YYYY/MM/DD').toString().substring(0, 4)
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal.filterData(criteria);
                            break;
                        }
                        case "custom": {
                            this.form.getItem("toDate").clearValue();
                            this.form.getItem("fromDate").clearValue();
                        }

                    }

                    this.form.redraw();
                }
            },
            {
                name: "fromDate",
                type: "persianDate",
                icons: [persianDatePicker],
                wrapTitle: false,
                title: "<spring:message code='InternalInvoices.from-date'/>",
                titleWidth: "30",
                width: "120",
                showIf: function (item, value, form, values) {

                    if (!values || !values.filterType)
                        return false;

                    return values.filterType === "custom";
                }
            },
            {
                name: "toDate",
                type: "persianDate",
                icons: [persianDatePicker],
                wrapTitle: false,
                title: "<spring:message code='InternalInvoices.to-date'/>",
                titleWidth: "30",
                width: "120",
                showIf: function (item, value, form, values) {

                    if (!values || !values.filterType)
                        return false;

                    return values.filterType === "custom";
                }
            },
            {
                name: "filter",
                type: "button",
                endRow: false, startRow: false,
                title: "<spring:message code='global.apply.filter'/>",
                showIf: function (item, value, form, values) {

                    if (!values || !values.filterType)
                        return false;

                    return values.filterType === "custom";
                },
                click: function () {

                    let firstDate = this.form.getValue("fromDate");
                    let lastDate = this.form.getValue("toDate");

                     if(firstDate > lastDate){
                        isc.say("<spring:message code='validator.field.date'/>");
                        return false;
                    }

                    let criteria = {
                        operator: 'and',
                        _constructor: "AdvancedCriteria",
                        criteria: []
                    };
                    if (firstDate && !lastDate)
                        criteria.criteria.add({
                            fieldName: 'invoiceDate',
                            operator: 'greaterOrEqual',
                            value: firstDate
                        });
                    if (lastDate && !firstDate)
                        criteria.criteria.add({
                            fieldName: 'invoiceDate',
                            operator: 'lessOrEqual',
                            value: lastDate
                        });
                    if (firstDate && lastDate)
                        criteria.criteria.add({
                            fieldName: 'invoiceDate',
                            operator: 'iBetweenInclusive',
                            start: firstDate,
                            end: lastDate
                        });

                    let filterEditorCriteriaList = [];
                    let filterEditorCriteria = ListGrid_InvoiceInternal.getFilterEditorCriteria();
                    if (filterEditorCriteria && filterEditorCriteria.criteria)
                        filterEditorCriteriaList = filterEditorCriteria.criteria.filter(q => !["documentId", "invoiceDate"].contains(q.fieldName));
                    criteria.criteria.addAll(filterEditorCriteriaList);
                    ListGrid_InvoiceInternal.defaultCriteria = criteria;
                    ListGrid_InvoiceInternal.filterData(criteria);
                }
            }
        ]
    });
    var InvoiceInternal_FilterForm_Sent = isc.DynamicForm.create({
        numCols: 8,
        height: "100%",
        canSubmit: true,
        wrapItemTitles: false,
        fields: [
            {
                name: "filterType",
                type: "SelectItem",
                valueMap: {
                    "daily": "<spring:message code='global.daily'/>",
                    "weekly": "<spring:message code='global.weekly'/>",
                    "monthly": "<spring:message code='global.monthly'/>",
                    "yearly": "<spring:message code='global.yearly'/>",
                    "all": "<spring:message code='global.all'/>",
                    "custom": "<spring:message code='global.custom'/>"
                },
                value: "weekly",
                title: "<spring:message code='global.form.choose.filter'/>",
                changed: function () {

                    let now = new persianDate();
                    let filterEditorCriteriaList = [];
                    let filterEditorCriteria = ListGrid_InvoiceInternal_Sent.getFilterEditorCriteria();
                    if (filterEditorCriteria && filterEditorCriteria.criteria)
                        filterEditorCriteriaList = filterEditorCriteria.criteria.filter(q => !["invoiceDate"].contains(q.fieldName));

                    switch (this.getValue()) {
                        case "all": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [{
                                    fieldName: 'invoiceDate',
                                    operator: 'notNull'
                                }]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Sent.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Sent.filterData(criteria);
                            break;
                        }
                        case "daily": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'equals',
                                        value: now.format('YYYY/MM/DD').toString()
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Sent.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Sent.filterData(criteria);
                            break;
                        }
                        case "weekly": {

                            let firstDay = now.date() - now.day() + 1;
                            let lastDay = firstDay + 6;
                            let firstDate = now.format("YYYY/MM/") + firstDay.toString().padStart(2, "0");
                            let lastDate = now.format("YYYY/MM/") + lastDay.toString().padStart(2, "0");
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'iBetweenInclusive',
                                        start: firstDate,
                                        end: lastDate
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Sent.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Sent.filterData(criteria);
                            break;
                        }
                        case "monthly": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'startsWith',
                                        value: now.format('YYYY/MM/DD').toString().substring(0, 7)
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Sent.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Sent.filterData(criteria);
                            break;
                        }
                        case "yearly": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'startsWith',
                                        value: now.format('YYYY/MM/DD').toString().substring(0, 4)
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Sent.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Sent.filterData(criteria);
                            break;
                        }
                        case "custom": {
                            this.form.getItem("toDate").clearValue();
                            this.form.getItem("fromDate").clearValue();
                        }

                    }

                    this.form.redraw();
                }
            },
            {
                name: "fromDate",
                type: "persianDate",
                icons: [persianDatePicker],
                wrapTitle: false,
                title: "<spring:message code='InternalInvoices.from-date'/>",
                titleWidth: "30",
                width: "120",
                showIf: function (item, value, form, values) {

                    if (!values || !values.filterType)
                        return false;

                    return values.filterType === "custom";
                }
            },
            {
                name: "toDate",
                type: "persianDate",
                icons: [persianDatePicker],
                wrapTitle: false,
                title: "<spring:message code='InternalInvoices.to-date'/>",
                titleWidth: "30",
                width: "120",
                showIf: function (item, value, form, values) {

                    if (!values || !values.filterType)
                        return false;

                    return values.filterType === "custom";
                }
            },
            {
                name: "filter",
                type: "button",
                endRow: false, startRow: false,
                title: "<spring:message code='global.apply.filter'/>",
                showIf: function (item, value, form, values) {

                    if (!values || !values.filterType)
                        return false;

                    return values.filterType === "custom";
                },
                click: function () {

                    let firstDate = this.form.getValue("fromDate");
                    let lastDate = this.form.getValue("toDate");
                    if(firstDate > lastDate){
                        isc.say("<spring:message code='validator.field.date'/>");
                        return false;
                    }
                    let criteria = {
                        operator: 'and',
                        _constructor: "AdvancedCriteria",
                        criteria: []
                    };
                    if (firstDate && !lastDate)
                        criteria.criteria.add({
                            fieldName: 'invoiceDate',
                            operator: 'greaterOrEqual',
                            value: firstDate
                        });
                    if (lastDate && !firstDate)
                        criteria.criteria.add({
                            fieldName: 'invoiceDate',
                            operator: 'lessOrEqual',
                            value: lastDate
                        });
                    if (firstDate && lastDate)
                        criteria.criteria.add({
                            fieldName: 'invoiceDate',
                            operator: 'iBetweenInclusive',
                            start: firstDate,
                            end: lastDate
                        });

                    let filterEditorCriteriaList = [];
                    let filterEditorCriteria = ListGrid_InvoiceInternal_Sent.getFilterEditorCriteria();
                    if (filterEditorCriteria && filterEditorCriteria.criteria)
                        filterEditorCriteriaList = filterEditorCriteria.criteria.filter(q => !["invoiceDate"].contains(q.fieldName));
                    criteria.criteria.addAll(filterEditorCriteriaList);
                    ListGrid_InvoiceInternal_Sent.defaultCriteria = criteria;
                    ListGrid_InvoiceInternal_Sent.filterData(criteria);
                }
            }
        ]
    });
    var InvoiceInternal_FilterForm_Deleted = isc.DynamicForm.create({
        numCols: 8,
        height: "100%",
        canSubmit: true,
        wrapItemTitles: false,
        fields: [
            {
                name: "filterType",
                type: "SelectItem",
                valueMap: {
                    "daily": "<spring:message code='global.daily'/>",
                    "weekly": "<spring:message code='global.weekly'/>",
                    "monthly": "<spring:message code='global.monthly'/>",
                    "yearly": "<spring:message code='global.yearly'/>",
                    "all": "<spring:message code='global.all'/>",
                    "custom": "<spring:message code='global.custom'/>"
                },
                value: "weekly",
                title: "<spring:message code='global.form.choose.filter'/>",
                changed: function () {

                    let now = new persianDate();
                    let filterEditorCriteriaList = [];
                    let filterEditorCriteria = ListGrid_InvoiceInternal_Deleted.getFilterEditorCriteria();
                    if (filterEditorCriteria && filterEditorCriteria.criteria)
                        filterEditorCriteriaList = filterEditorCriteria.criteria.filter(q => !["documentId", "invoiceDate"].contains(q.fieldName));

                    switch (this.getValue()) {
                        case "all": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [{
                                    fieldName: 'invoiceDate',
                                    operator: 'notNull'
                                }]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Deleted.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Deleted.filterData(criteria);
                            break;
                        }
                        case "daily": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'equals',
                                        value: now.format('YYYY/MM/DD').toString()
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Deleted.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Deleted.filterData(criteria);
                            break;
                        }
                        case "weekly": {

                            let firstDay = now.date() - now.day() + 1;
                            let lastDay = firstDay + 6;
                            let firstDate = now.format("YYYY/MM/") + firstDay.toString().padStart(2, "0");
                            let lastDate = now.format("YYYY/MM/") + lastDay.toString().padStart(2, "0");
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'iBetweenInclusive',
                                        start: firstDate,
                                        end: lastDate
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Deleted.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Deleted.filterData(criteria);
                            break;
                        }
                        case "monthly": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'startsWith',
                                        value: now.format('YYYY/MM/DD').toString().substring(0, 7)
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Deleted.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Deleted.filterData(criteria);
                            break;
                        }
                        case "yearly": {
                            let criteria = {
                                operator: 'and',
                                _constructor: "AdvancedCriteria",
                                criteria: [
                                    {
                                        fieldName: 'invoiceDate',
                                        operator: 'startsWith',
                                        value: now.format('YYYY/MM/DD').toString().substring(0, 4)
                                    }
                                ]
                            };
                            criteria.criteria.addAll(filterEditorCriteriaList);
                            ListGrid_InvoiceInternal_Deleted.defaultCriteria = criteria;
                            ListGrid_InvoiceInternal_Deleted.filterData(criteria);
                            break;
                        }
                        case "custom": {
                            this.form.getItem("toDate").clearValue();
                            this.form.getItem("fromDate").clearValue();
                        }

                    }

                    this.form.redraw();
                }
            },
            {
                name: "fromDate",
                type: "persianDate",
                icons: [persianDatePicker],
                wrapTitle: false,
                title: "<spring:message code='InternalInvoices.from-date'/>",
                titleWidth: "30",
                width: "120",
                showIf: function (item, value, form, values) {

                    if (!values || !values.filterType)
                        return false;

                    return values.filterType === "custom";
                }
            },
            {
                name: "toDate",
                type: "persianDate",
                icons: [persianDatePicker],
                wrapTitle: false,
                title: "<spring:message code='InternalInvoices.to-date'/>",
                titleWidth: "30",
                width: "120",
                showIf: function (item, value, form, values) {

                    if (!values || !values.filterType)
                        return false;

                    return values.filterType === "custom";
                }
            },
            {
                name: "filter",
                type: "button",
                endRow: false, startRow: false,
                title: "<spring:message code='global.apply.filter'/>",
                showIf: function (item, value, form, values) {

                    if (!values || !values.filterType)
                        return false;

                    return values.filterType === "custom";
                },
                click: function () {

                    let firstDate = this.form.getValue("fromDate");
                    let lastDate = this.form.getValue("toDate");
                    if(firstDate > lastDate){
                        isc.say("<spring:message code='validator.field.date'/>");
                        return false;
                    }
                    let criteria = {
                        operator: 'and',
                        _constructor: "AdvancedCriteria",
                        criteria: []
                    };
                    if (firstDate && !lastDate)
                        criteria.criteria.add({
                            fieldName: 'invoiceDate',
                            operator: 'greaterOrEqual',
                            value: firstDate
                        });
                    if (lastDate && !firstDate)
                        criteria.criteria.add({
                            fieldName: 'invoiceDate',
                            operator: 'lessOrEqual',
                            value: lastDate
                        });
                    if (firstDate && lastDate)
                        criteria.criteria.add({
                            fieldName: 'invoiceDate',
                            operator: 'iBetweenInclusive',
                            start: firstDate,
                            end: lastDate
                        });

                    let filterEditorCriteriaList = [];
                    let filterEditorCriteria = ListGrid_InvoiceInternal_Deleted.getFilterEditorCriteria();
                    if (filterEditorCriteria && filterEditorCriteria.criteria)
                        filterEditorCriteriaList = filterEditorCriteria.criteria.filter(q => !["documentId", "invoiceDate"].contains(q.fieldName));
                    criteria.criteria.addAll(filterEditorCriteriaList);
                    ListGrid_InvoiceInternal_Deleted.defaultCriteria = criteria;
                    ListGrid_InvoiceInternal_Deleted.filterData(criteria);
                }
            }
        ]
    });

    <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_Sent_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='InternalInvoices.invoice-print'/>",
        icon: "icon/pdf.png",
        click: function () {
            ToolStripButton_InvoiceInternal_Pdf_F();
        }
    });
    </sec:authorize>
    var ToolStripButton_InvoiceInternal_Sent_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_InvoiceInternal_refresh();
        }
    });
    <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
    var ToolStripButton_AccountingDoc_Deleted = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='accounting.document.create'/>",
        icon: "pieces/receipt.png",
        click: function () {

            createAccountingDoc();
        }
    });
    </sec:authorize>
    <sec:authorize access="hasAuthority('E_UPDATE_DELETED_INVOICE_INTERNAL')">
    var ToolStripButton_Change_Status = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='accounting.document.change.status'/>",
        icon: "pieces/16/refresh.png",
        click: function () {
            changeStatusAccountingDoc();
        }
    });
    </sec:authorize>
    <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_Deleted_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='InternalInvoices.invoice-print'/>",
        icon: "icon/pdf.png",
        click: function () {
            ToolStripButton_InvoiceInternal_Pdf_F();
        }
    });
    </sec:authorize>
    var ToolStripButton_InvoiceInternal_Deleted_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_InvoiceInternal_refresh();
        }
    });

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
            <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='InternalInvoices.invoice-print'/>",
                icon: "icon/pdf.png",
                click: function () {
                    ToolStripButton_InvoiceInternal_Pdf_F();
                }

            },
            </sec:authorize>
            <%--<sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">--%>
            <%--{--%>
            <%--title: "<spring:message code='global.form.print.html'/>",--%>
            <%--icon: "icon/html.jpg",--%>
            <%--click: function () {--%>
            <%--ToolStripButton_InvoiceInternal_Html_F();--%>
            <%--}--%>
            <%--},--%>
            <%--</sec:authorize>--%>
            <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
            {
                title: "<spring:message code='accounting.document.create'/>",
                icon: "pieces/receipt.png",
                click: function () {
                    createAccountingDoc();
                }
            }
            </sec:authorize>
        ]
    });
    var Menu_ListGrid_InvoiceInternal_Sent = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_InvoiceInternal_refresh();
                }
            },
            <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='InternalInvoices.invoice-print'/>",
                icon: "icon/pdf.png",
                click: function () {
                    ToolStripButton_InvoiceInternal_Pdf_F();
                }

            },
            </sec:authorize>
            <%--<sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">--%>
            <%--{--%>
            <%--title: "<spring:message code='global.form.print.html'/>",--%>
            <%--icon: "icon/html.jpg",--%>
            <%--click: function () {--%>
            <%--ToolStripButton_InvoiceInternal_Html_F();--%>
            <%--}--%>
            <%--},--%>
            <%--</sec:authorize>--%>
        ]
    });
    var Menu_ListGrid_InvoiceInternal_Deleted = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_InvoiceInternal_refresh();
                }
            },
            <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='InternalInvoices.invoice-print'/>",
                icon: "icon/pdf.png",
                click: function () {
                    ToolStripButton_InvoiceInternal_Pdf_F();
                }

            },
            </sec:authorize>
            <%--<sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">--%>
            <%--{--%>
            <%--title: "<spring:message code='global.form.print.html'/>",--%>
            <%--icon: "icon/html.jpg",--%>
            <%--click: function () {--%>
            <%--ToolStripButton_InvoiceInternal_Html_F();--%>
            <%--}--%>
            <%--},--%>
            <%--</sec:authorize>--%>
            <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
            {
                title: "<spring:message code='accounting.document.create'/>",
                icon: "pieces/receipt.png",
                click: function () {
                    createAccountingDoc();
                }
            },
            </sec:authorize>
            <sec:authorize access="hasAuthority('E_UPDATE_DELETED_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='accounting.document.change.status'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    changeStatusAccountingDoc();
                }
            }
            </sec:authorize>
        ]
    });

    var ToolStrip_Actions_InvoiceInternal = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members:
            [

                <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
                ToolStripButton_AccountingDoc,
                </sec:authorize>
                <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_Pdf,
                </sec:authorize>
                <%--<sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">--%>
                <%--ToolStripButton_InvoiceInternal_html,--%>
                <%--</sec:authorize>--%>
                InvoiceInternal_FilterForm,
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
    var ToolStrip_Actions_InvoiceInternal_Sent = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members:
            [

                <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_Sent_Pdf,
                </sec:authorize>
                <%--<sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">--%>
                <%--ToolStripButton_InvoiceInternal_Sent_html,--%>
                <%--</sec:authorize>--%>
                InvoiceInternal_FilterForm_Sent,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_InvoiceInternal_Sent_Refresh
                    ]
                })

            ]
    });
    var ToolStrip_Actions_InvoiceInternal_Deleted = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members:
            [

                <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
                ToolStripButton_AccountingDoc_Deleted,
                </sec:authorize>
                <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_Deleted_Pdf,
                </sec:authorize>
                <%--<sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">--%>
                <%--ToolStripButton_InvoiceInternal_Deleted_html,--%>
                <%--</sec:authorize>--%>
                <sec:authorize access="hasAuthority('E_UPDATE_DELETED_INVOICE_INTERNAL')">
                ToolStripButton_Change_Status,
                </sec:authorize>
                InvoiceInternal_FilterForm_Deleted,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_InvoiceInternal_Deleted_Refresh,
                    ]
                })

            ]
    });

    var ListGrid_InvoiceInternal = isc.ListGrid.create({
        showFilterEditor: true,
        showRowNumbers: true,
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_InvoiceInternal,
        contextMenu: Menu_ListGrid_InvoiceInternal,
        canMultiSort: true,
        initialSort: [
            {property: "invoiceDate", direction: "descending"},
            {property: "remittanceId", direction: "descending"},
            {property: "salesType", direction: "descending"},
        ],
        implicitCriteria: {
            operator: 'and',
            _constructor: "AdvancedCriteria",
            criteria: [
                 {fieldName: 'estatus', operator: 'equals' , value: Enums.eStatus2.Final},
            ]
        },
        recordDoubleClick(record) {
            <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
            createAccountingDoc();
            </sec:authorize>
        },
        filterData: function (criteria, callback, requestProperties) {
            if (!criteria)
                return false;
            else if (!criteria.criteria || !criteria.criteria.length)
                return false;
            else {

                for (let i = 0; i < this.defaultCriteria.criteria.length; i++) {

                    let currentDefaultCriteria = this.defaultCriteria.criteria[i];
                    let existCriteria = criteria.criteria.filter(q => q.fieldName === currentDefaultCriteria.fieldName);
                    if (existCriteria) {
                        if (["documentId", "invoiceDate"].contains(currentDefaultCriteria.fieldName)) {
                            criteria.criteria.removeAll(existCriteria);
                            criteria.criteria.add(currentDefaultCriteria);
                        }
                    } else
                        criteria.criteria.add({...currentDefaultCriteria});

                }
            }

            return this.Super("filterData", arguments);
        },
        getCellCSSText: {},
        fields:
            [
                {name: "id", title: "<spring:message code='global.id'/>"},
                {name: "invoiceDate", title: "<spring:message code='invoice.invDate'/>"},
                {name: "remittanceId", title: "<spring:message code='invoice.havalehId'/>"},
                {name: "customerName", title: "<spring:message code='invoice.customerName'/>"},
                {name: "invoiceSerial", title: "<spring:message code='invoice.shomarehSoratHesab'/>"},
                {name: "productName", title: "<spring:message code='invoice.gdsName'/>"},
                {
                    type: 'integer',
                    name: "salesType",
                    valueMap: {"2": "??????????????", "1": "????????"},
                    title: "<spring:message code='invoice.typeForosh'/>"
                },
                {type: 'float', name: "unitPrice", title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "realWeight", title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "totalAmount", title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalDeductions", title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>"},
                {name: "documentId", title: "<spring:message code='invoice.documentId'/>", canFilter: false},
                {
                    name: "estatus",
                    width: 100,
                    canEdit: false,
                    showHover: true,
                    canSort: false,
                    multiple: true,
                    filterOperator: "equals",
                    editorType: "SelectItem",
                    valueMap: Enums.eStatus2,
                    title: "<spring:message code='global.e-status'/>",
                    hoverHTML(record, value, rowNum, colNum, grid) {

                        if (record == null || record.estatus == null || record.estatus.length === 0)
                            return;

                        return record.estatus.map(q => '<div>' + Enums.eStatus[q] + '</div>').join();
                    },
                    formatCellValue: function (value, record, rowNum, colNum, grid) {

                        if (record == null || record.estatus == null || record.estatus.length === 0)
                            return;

                        return record.estatus.join(', ');
                    }
                }
            ],
        autoFetchData: false,
        allowFilterOperators: true,
        filterOnKeypress: false
    });
    ListGrid_InvoiceInternal.getCellCSSText = function (record) {
        if (record.documentId > 0)
            return "font-weight:bold; color:green;";
        else if (record.documentId == -1)
            return "font-weight:bold; color:red;";
        else if (record.salesType === 2)
            return "font-weight:bold; color:#287fd6;";
    }
    var ListGrid_InvoiceInternal_Sent = isc.ListGrid.create({
        showFilterEditor: true,
        showRowNumbers: true,
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_InvoiceInternal_Sent,
        contextMenu: Menu_ListGrid_InvoiceInternal_Sent,
        implicitCriteria: {
            _constructor: "AdvancedCriteria",
            operator: 'and',
            criteria: [
                 {fieldName: 'estatus', operator: 'equals' , value: Enums.eStatus2.SendToAcc},
            ]
        },
        filterData: function (criteria, callback, requestProperties) {

            if (!criteria)
                return false;
            else if (!criteria.criteria || !criteria.criteria.length)
                return false;
            else {

                for (let i = 0; i < this.defaultCriteria.criteria.length; i++) {

                    let currentDefaultCriteria = this.defaultCriteria.criteria[i];
                    let existCriteria = criteria.criteria.filter(q => q.fieldName === currentDefaultCriteria.fieldName);
                    if (existCriteria) {
                        if (["invoiceDate"].contains(currentDefaultCriteria.fieldName)) {
                            criteria.criteria.removeAll(existCriteria);
                            criteria.criteria.add(currentDefaultCriteria);
                        }
                    } else
                        criteria.criteria.add({...currentDefaultCriteria});
                }
            }
            return this.Super("filterData", arguments);
        },
        canMultiSort: true,
        initialSort: [
            {property: "invoiceDate", direction: "descending"},
            {property: "remittanceId", direction: "descending"},
            {property: "salesType", direction: "descending"},
        ],
        getCellCSSText: function (record) {
            if (record.salesType === 2)
                return "font-weight:bold; color:#287fd6;";
        },
        fields:
            [
                {name: "id", title: "<spring:message code='global.id'/>"},
                {name: "invoiceDate", title: "<spring:message code='invoice.invDate'/>"},
                {name: "remittanceId", title: "<spring:message code='invoice.havalehId'/>"},
                {name: "customerName", title: "<spring:message code='invoice.customerName'/>"},
                {name: "invoiceSerial", title: "<spring:message code='invoice.shomarehSoratHesab'/>"},
                {name: "productName", title: "<spring:message code='invoice.gdsName'/>"},
                {
                    type: 'integer',
                    name: "salesType",
                    valueMap: {"2": "??????????????", "1": "????????"},
                    title: "<spring:message code='invoice.typeForosh'/>"
                },
                {type: 'float', name: "unitPrice", title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "realWeight", title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "totalAmount", title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalDeductions", title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>"},
                {name: "documentId", title: "<spring:message code='invoice.documentId'/>"},
                 {
                    name: "estatus",
                    width: 100,
                    canEdit: false,
                    showHover: true,
                    canSort: false,
                    multiple: true,
                    filterOperator: "equals",
                    editorType: "SelectItem",
                    valueMap: Enums.eStatus2,
                    title: "<spring:message code='global.e-status'/>",
                    hoverHTML(record, value, rowNum, colNum, grid) {

                        if (record == null || record.estatus == null || record.estatus.length === 0)
                            return;

                        return record.estatus.map(q => '<div>' + Enums.eStatus[q] + '</div>').join();
                    },
                    formatCellValue: function (value, record, rowNum, colNum, grid) {

                        if (record == null || record.estatus == null || record.estatus.length === 0)
                            return;

                        return record.estatus.join(', ');
                    }
                }
            ],
        autoFetchData: false,
        allowFilterOperators: true
    });
    var ListGrid_InvoiceInternal_Deleted = isc.ListGrid.create({
        showFilterEditor: true,
        showRowNumbers: true,
        width: "100%",
        height: "100%",
        autoFetchData: false,
        dataSource: RestDataSource_InvoiceInternal_Deleted,
        contextMenu: Menu_ListGrid_InvoiceInternal_Deleted,
        implicitCriteria: {
            _constructor: "AdvancedCriteria",
            operator: 'and',
            criteria: [
                 {fieldName: 'estatus', operator: 'equals' , value: Enums.eStatus2.RemoveFromAcc},
            ]
        },
        canMultiSort: true,
        initialSort: [
            {property: "invoiceDate", direction: "descending"},
            {property: "remittanceId", direction: "descending"},
            {property: "salesType", direction: "descending"},
        ],
        recordDoubleClick(record) {
            <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
            createAccountingDoc();
            </sec:authorize>
        },
        getCellCSSText: {},
        filterData: function (criteria, callback, requestProperties) {

            if (!criteria)
                return false;
            else if (!criteria.criteria || !criteria.criteria.length)
                return false;
            else {

                for (let i = 0; i < this.defaultCriteria.criteria.length; i++) {

                    let currentDefaultCriteria = this.defaultCriteria.criteria[i];
                    let existCriteria = criteria.criteria.filter(q => q.fieldName === currentDefaultCriteria.fieldName);
                    if (existCriteria) {
                        if (["documentId", "invoiceDate"].contains(currentDefaultCriteria.fieldName)) {
                            criteria.criteria.removeAll(existCriteria);
                            criteria.criteria.add(currentDefaultCriteria);
                        }
                    } else
                        criteria.criteria.add({...currentDefaultCriteria});
                }
            }
            return this.Super("filterData", arguments);
        },
        fields:
            [
                {name: "id", title: "<spring:message code='global.id'/>"},
                {name: "invoiceDate", title: "<spring:message code='invoice.invDate'/>"},
                {name: "remittanceId", title: "<spring:message code='invoice.havalehId'/>"},
                {name: "customerName", title: "<spring:message code='invoice.customerName'/>"},
                {name: "invoiceSerial", title: "<spring:message code='invoice.shomarehSoratHesab'/>"},
                {name: "productName", title: "<spring:message code='invoice.gdsName'/>"},
                {
                    type: 'integer',
                    name: "salesType",
                    valueMap: {"2": "??????????????", "1": "????????"},
                    title: "<spring:message code='invoice.typeForosh'/>"
                },
                {type: 'float', name: "unitPrice", title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "realWeight", title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "totalAmount", title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalDeductions", title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>"},
                {name: "documentId", title: "<spring:message code='invoice.documentId'/>", canFilter: false},
                 {
                    name: "estatus",
                    width: 100,
                    canEdit: false,
                    showHover: true,
                    canSort: false,
                    multiple: true,
                    filterOperator: "equals",
                    editorType: "SelectItem",
                    valueMap: Enums.eStatus2,
                    title: "<spring:message code='global.e-status'/>",
                    hoverHTML(record, value, rowNum, colNum, grid) {

                        if (record == null || record.estatus == null || record.estatus.length === 0)
                            return;

                        return record.estatus.map(q => '<div>' + Enums.eStatus[q] + '</div>').join();
                    },
                    formatCellValue: function (value, record, rowNum, colNum, grid) {

                        if (record == null || record.estatus == null || record.estatus.length === 0)
                            return;

                        return record.estatus.join(', ');
                    }
                }
            ],
        allowFilterOperators: true
    });
    ListGrid_InvoiceInternal_Deleted.getCellCSSText = function (record) {
        if (record.documentId > 0)
            return "font-weight:bold; color:green;";
        else if (record.documentId == -1)
            return "font-weight:bold; color:red;";
        else if (record.salesType === 2)
            return "font-weight:bold; color:#287fd6;";
    }

    var VLayout_ListGrid_InvoiceInternal = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_InvoiceInternal, ListGrid_InvoiceInternal
        ]
    });
    var VLayout_ListGrid_InvoiceInternal_Sent = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_InvoiceInternal_Sent, ListGrid_InvoiceInternal_Sent
        ]
    });
    var VLayout_ListGrid_InvoiceInternal_Deleted = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_InvoiceInternal_Deleted, ListGrid_InvoiceInternal_Deleted
        ]
    });

    InvoiceInternal_FilterForm.getItem("filterType").changed();
    InvoiceInternal_FilterForm_Sent.getItem("filterType").changed();
    InvoiceInternal_FilterForm_Deleted.getItem("filterType").changed();

    var invoiceInternalTabs = isc.TabSet.create({
        width: "100%",
        height: "100%",
        tabBarPosition: nicico.CommonUtil.getAlignByLangReverse(),
        wrap: false,
        showTabScroller: true,
        border: "1px solid lightblue",
        edgeMarginSize: 3,
        tabBarThickness: 80,
        tabs: [
            {
                title: "<spring:message code='issuedInternalInvoices.dontSent'/>",
                pane: VLayout_ListGrid_InvoiceInternal
            },
            {
                title: "<spring:message code='issuedInternalInvoices.sent'/>",
                pane: VLayout_ListGrid_InvoiceInternal_Sent
            },
            {
                title: "<spring:message code='issuedInternalInvoices.deleted'/>",
                pane: VLayout_ListGrid_InvoiceInternal_Deleted
            },
        ]
    });

    var VLayout_InvoiceInternal_Grid = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            invoiceInternalTabs
        ]
    });