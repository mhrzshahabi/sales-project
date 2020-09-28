<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

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
                {name: "documentId"}
            ],
        fetchDataURL: "${contextPath}/api/invoiceInternal/list-accounting"
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
                {name: "documentId"}
            ],
        fetchDataURL: "${contextPath}/api/invoiceInternal/list-accounting"
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
                {name: "documentId"}
            ],
        fetchDataURL: "${contextPath}/api/invoiceInternal/list-accounting"
    });
    <%-- accounting window --%>
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
    var documentMainInfoForm = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        titleWidth: 30,
        align: "right",
        autoDraw: false,
        canEdit: true,
        autoFetchData: false,
        // colWidths: [100, "*"],
        numCols: 4,
        margin: 5,
        fields: [
            {name: "remittanceId", title: "<spring:message code='invoice.havalehId'/>", width: "150", canEdit: false},
            {
                name: "customerName",
                title: "<spring:message code='invoice.customerName'/>",
                width: "150",
                canEdit: false
            },
            {
                name: "invoiceSerial",
                title: "<spring:message code='invoice.shomarehSoratHesab'/>",
                width: "150",
                canEdit: false
            },
            {name: "productName", title: "<spring:message code='invoice.gdsName'/>", width: "150", canEdit: false},
            {name: "unitPrice", title: "<spring:message code='invoice.ghematUnit'/>", width: "150", canEdit: false},
            {name: "totalAmount", title: "<spring:message code='invoice.mablaghKol'/>", width: "150", canEdit: false},
            {
                name: "totalDeductions",
                title: "<spring:message code='invoice.totalKosorat'/>",
                width: "150",
                canEdit: false
            },
            {
                name: "invoiceDate",
                title: "<spring:message code='document.header.date'/>",
                width: "150",
                icons: [persianDatePicker],
                wrapTitle: false,
                type: "persianDate",
                length: 10,
                keyPressFilter: "[0-9/]",
            },
            {
                type: 'integer',
                name: "salesType",
                valueMap: {"2": "اعتباری", "1": "نقدی"},
                title: "<spring:message code='invoice.typeForosh'/>", width: "150"
            },
            {type: 'float', name: "realWeight", title: "<spring:message code='invoice.weightReal'/>", width: "150"},
            {name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>", width: "150"},

            {type: "SpacerItem", width: "100%", height: "50", colSpan: 4},
            {
                name: "documentDate",
                title: "<spring:message code='document.header.date'/>",
                width: "150",
                icons: [persianDatePicker],
                wrapTitle: false,
                type: "persianDate",
                length: 10,
                keyPressFilter: "[0-9/]",
            },
            {
                name: "department.id", title: "<spring:message code='department.name'/>", required: true,
                editorType: "select",
                wrapTitle: false,
                optionDataSource: departmentDS,
                valueField: "id",
                displayField: "departmentName",
                width: "150",
                pickListWidth: "150",
                allowAdvancedCriteria: false,
                autoFetchData: false,
                pickListFields: [
                    {name: "departmentCode", width: "20%"},
                    {name: "departmentName", width: "80%"}
                ],

            },
            {
                name: "documentTitle",
                title: "<spring:message code='document.header.desc'/>",
                type: "textArea",
                colSpan: "4",
                width: "485",
                wrapTitle: false,
            }
        ]
    });
    var IButton_Document_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        click: function () {
            let record = ListGrid_InvoiceInternal.getSelectedRecord();
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
            let data = isc.clone(documentMainInfoForm.getValues());
            data.department = data.department.id;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/accounting/documents/internal/" + record.id,
                httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(data),
                willHandleError: true,
                serverOutputAsString: false,
                callback: function (RpcResponse_o) {

                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                        let data = JSON.stringify(RpcResponse_o.data).split("@");
                        record.documentId = data[1].replace("\"", "");
                        isc.say(data[0]);
                        newDocumentWindow.close();
                        ListGrid_InvoiceInternal.getCellCSSText(record);
                        ListGrid_InvoiceInternal.refreshRow(ListGrid_InvoiceInternal.getRowNum(record));
                    } else {
                        newDocumentWindow.close();
                        record.documentId = -1;
                        ListGrid_InvoiceInternal.getCellCSSText(record);
                        ListGrid_InvoiceInternal.refreshRow(ListGrid_InvoiceInternal.getRowNum(record));
                    }

                }

            }));

        }
    });
    var IButton_Windows_Close = isc.IButtonCancel.create({
        top: 260,
        title: "<spring:message code='global.close'/>",
        click: function () {
            newDocumentWindow.close();
        }
    });
    var windows_button_Layout = isc.HLayout.create({
        width: "100%",
        height: "100%",
        align: "center",
        membersMargin: 10,
        members: [
            IButton_Document_Save,
            IButton_Windows_Close
        ]
    });
    var newDocumentWindow = isc.Window.create({
        title: "<spring:message code='accounting.document.create'/>",
        width: 700,
        height: 500,
        // autoSize:true,
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
            documentMainInfoForm, windows_button_Layout
        ]
    });

    function createAccountingDoc() {

        if (invoiceInternalTabs.selectedTab === 1) {
            isc.say("<spring:message code='global.grid.tab.selected.sentDocument'/>")
            return;
        }
        documentMainInfoForm.clearValues();
        let grid = invoiceInternalTabs.getTab(invoiceInternalTabs.selectedTab).pane.members.get(1);
        var record = grid.getSelectedRecord();
        if (record == null) {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else if (record.documentId == null) {
            documentMainInfoForm.setValue("remittanceId", record.remittanceId);
            documentMainInfoForm.setValue("customerName", record.customerName);
            documentMainInfoForm.setValue("customerName", record.customerName);
            documentMainInfoForm.setValue("invoiceSerial", record.invoiceSerial);
            documentMainInfoForm.setValue("productName", record.productName);
            documentMainInfoForm.setValue("unitPrice", record.unitPrice);
            documentMainInfoForm.setValue("totalAmount", record.totalAmount);
            documentMainInfoForm.setValue("totalDeductions", record.totalDeductions);
            documentMainInfoForm.setValue("salesType", record.salesType);
            documentMainInfoForm.setValue("realWeight", record.realWeight);
            documentMainInfoForm.setValue("bankGroupDesc", record.bankGroupDesc);
            documentMainInfoForm.setValue("invoiceDate", record.invoiceDate);

            newDocumentWindow.show();
        } else isc.say("<spring:message code='accounting.create.document.sent'/>");
    }

    function changeStatusAccountingDoc() {

         isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/documents/status/" + "sales internal invoice",
                httpMethod: "PUT",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(data),
                willHandleError: true,
                serverOutputAsString: false,
                callback: function (RpcResponse_o) {

                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {

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
        icon: "icon/accountingDoc.png",
        click: function () {

            createAccountingDoc();
        }
    });
    </sec:authorize>
    <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_html = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.html'/>",
        icon: "icon/html.jpg",
        click: function () {
            ToolStripButton_InvoiceInternal_Html_F();
        }
    });
    </sec:authorize>
    <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.pdf'/>",
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
    var InvoiceInternal_RadioGroup = isc.FormLayout.create({
        autoDraw: false,
        items: [{
            name: "filterType", type: "radioGroup", showTitle: false, width: "300", vertical: false,
            valueMap: {
                "daily": "<spring:message code='global.daily'/>",
                "weekly": "<spring:message code='global.weekly'/>",
                "monthly": "<spring:message code='global.monthly'/>",
                "yearly": "<spring:message code='global.yearly'/>",
                "all": "<spring:message code='global.all'/>"
            },
            value: "weekly",
            changed: function () {

                let now = new persianDate();
                let data = InvoiceInternal_RadioGroup.getValues();
                let filterEditorCriteriaList = [];
                let filterEditorCriteria = ListGrid_InvoiceInternal.getFilterEditorCriteria();
                if (filterEditorCriteria && filterEditorCriteria.criteria)
                    filterEditorCriteriaList = filterEditorCriteria.criteria.filter(q => !["documentId", "invoiceDate"].contains(q.fieldName));
                switch (data.filterType) {
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

                }
            }
        }]
    });
    var InvoiceInternal_RadioGroup_Sent = isc.FormLayout.create({
        autoDraw: false,
        items: [{
            name: "filterType", type: "radioGroup", showTitle: false, width: "300", vertical: false,
            valueMap: {
                "daily": "<spring:message code='global.daily'/>",
                "weekly": "<spring:message code='global.weekly'/>",
                "monthly": "<spring:message code='global.monthly'/>",
                "yearly": "<spring:message code='global.yearly'/>",
                "all": "<spring:message code='global.all'/>"
            },
            value: "weekly",
            changed: function (form, item, value) {

                let now = new persianDate();
                let data = InvoiceInternal_RadioGroup_Sent.getValues();
                let filterEditorCriteriaList = [];
                let filterEditorCriteria = ListGrid_InvoiceInternal_Sent.getFilterEditorCriteria();
                if (filterEditorCriteria && filterEditorCriteria.criteria)
                    filterEditorCriteriaList = filterEditorCriteria.criteria.filter(q => !["invoiceDate"].contains(q.fieldName));
                switch (data.filterType) {

                    case "all": {
                        let criteria = {
                            operator: 'and',
                            _constructor: "AdvancedCriteria",
                            criteria: [
                                {
                                    fieldName: 'invoiceDate',
                                    operator: 'notNull'
                                }
                            ]
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
                }
            }
        }]
    });
    var InvoiceInternal_RadioGroup_Deleted = isc.FormLayout.create({
        autoDraw: false,
        items: [{
            name: "filterType", type: "radioGroup", showTitle: false, width: "300", vertical: false,
            valueMap: {
                "daily": "<spring:message code='global.daily'/>",
                "weekly": "<spring:message code='global.weekly'/>",
                "monthly": "<spring:message code='global.monthly'/>",
                "yearly": "<spring:message code='global.yearly'/>"
            },
            value: "weekly",
            changed: function (form, item, value) {

                let now = new persianDate();
                let data = InvoiceInternal_RadioGroup_Deleted.getValues();
                let filterEditorCriteriaList = [];
                let filterEditorCriteria = ListGrid_InvoiceInternal_Deleted.getFilterEditorCriteria();
                if (filterEditorCriteria && filterEditorCriteria.criteria)
                    filterEditorCriteriaList = filterEditorCriteria.criteria.filter(q => !["documentId", "invoiceDate"].contains(q.fieldName));
                switch (data.filterType) {

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

                }
            }
        }]
    });

    <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_Sent_html = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.html'/>",
        icon: "icon/html.jpg",
        click: function () {
            ToolStripButton_InvoiceInternal_Html_F();
        }
    });
    </sec:authorize>
    <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_Sent_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.pdf'/>",
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
        icon: "icon/accountingDoc.png",
        click: function () {

            createAccountingDoc();
        }
    });
    </sec:authorize>
     var ToolStripButton_Change_Status = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='accounting.document.change.status'/>",
        icon: "icon/accountingDoc.png",
        click: function () {
            changeStatusAccountingDoc();
        }
    });

    <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_Deleted_html = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.html'/>",
        icon: "icon/html.jpg",
        click: function () {
            ToolStripButton_InvoiceInternal_Html_F();
        }
    });
    </sec:authorize>
    <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
    var ToolStripButton_InvoiceInternal_Deleted_Pdf = isc.ToolStripButtonPrint.create({
        title: "<spring:message code='global.form.print.pdf'/>",
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
                title: "<spring:message code='global.form.print.pdf'/>",
                icon: "icon/pdf.png",
                click: function () {
                    ToolStripButton_InvoiceInternal_Pdf_F();
                }

            },
            </sec:authorize>
            <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
            {
                title: "<spring:message code='global.form.print.html'/>",
                icon: "icon/html.jpg",
                click: function () {
                    ToolStripButton_InvoiceInternal_Html_F();
                }
            },
            </sec:authorize>
            <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
            {
                title: "<spring:message code='accounting.document.create'/>",
                icon: "icon/accountingDoc.png",
                click: function () {
                    createAccountingDoc();
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

                <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_Pdf,
                </sec:authorize>
                <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_html,
                </sec:authorize>
                <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
                ToolStripButton_AccountingDoc,
                </sec:authorize>
                InvoiceInternal_RadioGroup,
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
                <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_Sent_html,
                </sec:authorize>
                InvoiceInternal_RadioGroup_Sent,
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

                <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_Deleted_Pdf,
                </sec:authorize>
                <sec:authorize access="hasAuthority('P_INVOICE_INTERNAL')">
                ToolStripButton_InvoiceInternal_Deleted_html,
                </sec:authorize>
                <sec:authorize access="hasAuthority('E_SEND_INVOICE_INTERNAL_TO_ACC')">
                ToolStripButton_AccountingDoc_Deleted,
                </sec:authorize>
                ToolStripButton_Change_Status,
                InvoiceInternal_RadioGroup_Deleted,
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
                {fieldName: 'documentId', operator: 'isNull'}
            ]
        },
        recordDoubleClick(record) {
            createAccountingDoc();
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
                    valueMap: {"2": "اعتباری", "1": "نقدی"},
                    title: "<spring:message code='invoice.typeForosh'/>"
                },
                {type: 'float', name: "unitPrice", title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "realWeight", title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "totalAmount", title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalDeductions", title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>"},
                {name: "documentId", title: "<spring:message code='invoice.documentId'/>", canFilter: false},
            ],
        autoFetchData: false,
        allowFilterOperators: true,
        filterOnKeypress: false
    });

    ListGrid_InvoiceInternal.getCellCSSText = function (record) {
        if (record.documentId && record.documentId !== -1 && record.documentId !== -2)
            return "font-weight:bold; color:green;";
        else if (record.documentId === -1)
            return "font-weight:bold; color:red;";
        else if (record.salesType === 2)
            return "font-weight:bold; color:#287fd6;";
    }

    var ListGrid_InvoiceInternal_Sent = isc.ListGrid.create({
        showFilterEditor: true,
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_InvoiceInternal_Sent,
        contextMenu: Menu_ListGrid_InvoiceInternal,
        implicitCriteria: {
            _constructor: "AdvancedCriteria",
            operator: 'and',
            criteria: [{
                fieldName: 'documentId',
                operator: 'notNull'
            },
                {
                    fieldName: 'documentId',
                    operator: 'notEqual',
                    value: '0'
                }
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
                    valueMap: {"2": "اعتباری", "1": "نقدی"},
                    title: "<spring:message code='invoice.typeForosh'/>"
                },
                {type: 'float', name: "unitPrice", title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "realWeight", title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "totalAmount", title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalDeductions", title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>"},
                {name: "documentId", title: "<spring:message code='invoice.documentId'/>"},
            ],
        autoFetchData: false,
        allowFilterOperators: true
    });

    var ListGrid_InvoiceInternal_Deleted = isc.ListGrid.create({
        showFilterEditor: true,
        width: "100%",
        height: "100%",
        autoFetchData: false,
        dataSource: RestDataSource_InvoiceInternal_Deleted,
        contextMenu: Menu_ListGrid_InvoiceInternal,
        implicitCriteria: {
            _constructor: "AdvancedCriteria",
            operator: 'and',
            criteria: [
                {
                    fieldName: 'documentId',
                    operator: 'equals',
                    value: '-2'
                }
            ]
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
                    valueMap: {"2": "اعتباری", "1": "نقدی"},
                    title: "<spring:message code='invoice.typeForosh'/>"
                },
                {type: 'float', name: "unitPrice", title: "<spring:message code='invoice.ghematUnit'/>"},
                {type: 'float', name: "realWeight", title: "<spring:message code='invoice.weightReal'/>"},
                {type: 'float', name: "totalAmount", title: "<spring:message code='invoice.mablaghKol'/>"},
                {type: 'float', name: "totalDeductions", title: "<spring:message code='invoice.totalKosorat'/>"},
                {name: "bankGroupDesc", title: "<spring:message code='invoice.bankGroupDesc'/>"},
                {name: "documentId", title: "<spring:message code='invoice.documentId'/>", canFilter: false},
            ],
        allowFilterOperators: true
    });

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

    InvoiceInternal_RadioGroup.getItem("filterType").changed();
    InvoiceInternal_RadioGroup_Sent.getItem("filterType").changed();
    InvoiceInternal_RadioGroup_Deleted.getItem("filterType").changed();

    var invoiceInternalTabs = isc.TabSet.create({
        width: "100%",
        height: "100%",
        tabBarPosition: "right",
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
