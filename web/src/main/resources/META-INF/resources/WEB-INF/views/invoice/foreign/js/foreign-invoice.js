var foreignInvoiceTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

foreignInvoiceTab.variable.materialId = 1;
foreignInvoiceTab.variable.contractDetailData = {};
foreignInvoiceTab.variable.invoiceForm = new nicico.FormUtil();
foreignInvoiceTab.variable.selectBillLadingForm = new nicico.FindFormUtil();

foreignInvoiceTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/";
foreignInvoiceTab.variable.remittanceDetailUrl = "${contextPath}" + "/api/remittance-detail/";
foreignInvoiceTab.variable.inspectionReportUrl = "${contextPath}" + "/api/inspectionReport/";
foreignInvoiceTab.variable.personUrl = "${contextPath}" + "/api/person/";
foreignInvoiceTab.variable.shipmentUrl = "${contextPath}" + "/api/shipment/";
foreignInvoiceTab.variable.unitUrl = "${contextPath}" + "/api/unit/";
foreignInvoiceTab.variable.invoiceTypeUrl = "${contextPath}" + "/api/invoicetype/";
foreignInvoiceTab.variable.conversionRefUrl = "${contextPath}" + "/api/currencyRate/";
foreignInvoiceTab.variable.foreignInvoiceUrl = "${contextPath}" + "/api/foreign-invoice/";
foreignInvoiceTab.variable.foreignInvoiceItemUrl = "${contextPath}" + "/api/foreign-invoice-item/";
foreignInvoiceTab.variable.foreignInvoicePaymentUrl = "${contextPath}" + "/api/foreign-invoice-payment/";
foreignInvoiceTab.variable.foreignInvoiceItemDetailUrl = "${contextPath}" + "/api/foreign-invoice-item-detail/";
foreignInvoiceTab.variable.foreignInvoiceBillOfLadingUrl = "${contextPath}" + "/api/foreign-invoice-bill-of-lading/";
foreignInvoiceTab.variable.billLadingUrl = "${contextPath}" + "/api/bill-of-landing/";

foreignInvoiceTab.variable.invoiceTypeCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "or",
    criteria: [
        {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.PERFORMA},
        {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.PROVISIONAL},
        {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.FINAL},
        {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.PI_TRUSTY},
        {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.FI_TRUSTY}
    ]
};

foreignInvoiceTab.tab.pane = {};
foreignInvoiceTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "no",
        width: "100%",
        required: true,
        showHover: true,
        title: "<spring:message code='foreign-invoice.form.no'/>"
    },
    {
        name: "date",
        type: "date",
        width: "100%",
        required: true,
        showHover: true,
        title: "<spring:message code='foreign-invoice.form.date'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "sumPrice",
        title: "<spring:message code='foreign-invoice.form.sum-price'/>"
    },
    {
        width: "100%",
        showHover: true,
        name: "conversionSumPrice",
        title: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>"
    },
    {
        width: "100%",
        showHover: true,
        name: "accountingId",
        title: "<spring:message code='foreign-invoice.form.accounting-id'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "buyer.nameEN",
        title: "<spring:message code='foreign-invoice.form.buyer'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "invoiceType.title",
        title: "<spring:message code='foreign-invoice.form.invoice-type'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "shipment.sendDate",
        title: "<spring:message code='global.sendDate'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "shipment.material.descl",
        title: "<spring:message code='material.descl'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "creator.fullName",
        title: "<spring:message code='foreign-invoice.form.creator'/>"
    },
]);
foreignInvoiceTab.listGrid.fields.filter(q => q.name === "estatus").first().hidden = false;
foreignInvoiceTab.dynamicForm.fields = BaseFormItems.concat([
    /* Foreign Invoice */
    {
        required: true,
        name: "date",
        type: "date",
        title: "<spring:message code='foreign-invoice.form.date'/>",
        wrapTitle: false
    },
    {
        required: true,
        type: "integer",
        name: "invoiceTypeId",
        editorType: "SelectItem",
        width: "100%",
        valueField: "id",
        displayField: "title",
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "title", title: "<spring:message code='global.description'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.invoiceTypeUrl + "spec-list"
        }),
        optionCriteria: foreignInvoiceTab.variable.invoiceTypeCriteria,
        title: "<spring:message code='foreign-invoice.form.invoice-type'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        required: true,
        type: "integer",
        editorType: "SelectItem",
        name: "contractId",
        width: "100%",
        valueField: "id",
        displayField: "no",
        optionCriteria: {
            operator: "and",
            criteria: [
                {
                    fieldName: "parentId",
                    operator: "isNull"
                }, {
                    fieldName: "eStatusId",
                    operator: "greaterOrEqual",
                    value: 4
                }
            ]
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {
                    name: "no",
                    title: "<spring:message code='foreign-invoice.form.contract'/>"
                },
                {name: "description", title: "<spring:message code='global.description'/>"},
                {name: "materialId"},
                {name: "estatus", title: "<spring:message code='global.status'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.contractUrl + "spec-list"
        }),
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "no"},
            {name: "materialId", hidden: true},
            {name: "estatus"}
        ],
        title: "<spring:message code='foreign-invoice.form.contract'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {

            let selectedRecord = item.getSelectedRecord();
            let shipmentIdField = form.getField("shipmentId");
            shipmentIdField.setValue(null);

            if (!selectedRecord) {

                shipmentIdField.disable();
                return;
            }
            if (!selectedRecord.estatus.contains(Enums.eStatus2.Final)) {

                foreignInvoiceTab.dialog.say('<spring:message code="foreign-invoice.form.validate.contract.not.final"/>');
                shipmentIdField.disable();
                return;
            }

            foreignInvoiceTab.variable.materialId = selectedRecord.materialId;
            shipmentIdField.setOptionCriteria({
                operator: "or",
                criteria: [{
                    fieldName: "contractShipment.contractId",
                    operator: "equals",
                    value: selectedRecord.id
                }, {
                    fieldName: "contractShipment.contract.parentId",
                    operator: "equals",
                    value: selectedRecord.id
                }]
            });
            shipmentIdField.enable();
            shipmentIdField.changed(form, shipmentIdField, null);
        }
    },
    {
        required: true,
        disabled: true,
        width: "100%",
        type: "integer",
        name: "shipmentId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "sendDate",
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "sendDate", title: "<spring:message code='global.sendDate'/>", type: "date", width: "110"},
            {name: "contact.nameEN", title: "<spring:message code='foreign-invoice.form.shipment'/>"},
            {name: "material.descl", title: "<spring:message code='material.descl'/>"},
            {name: "amount", title: "<spring:message code='global.amount'/>"},
            {name: "loadingLetter", title: "<spring:message code='shipment.loadingLetter'/>"},
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "contact.nameEN", title: "<spring:message code='foreign-invoice.form.shipment'/>"},
                {name: "material.descl", title: "<spring:message code='material.descl'/>"},
                {name: "amount", title: "<spring:message code='global.amount'/>"},
                {name: "loadingLetter", title: "<spring:message code='shipment.loadingLetter'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.shipmentUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.shipment'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        formatValue(value, record, form, item) {

            let selectedRecord = item.getSelectedRecord();
            if (!selectedRecord) return;

            return new Date(selectedRecord.sendDate).getMonthName();
        },
        changed: function (form, item, value) {

            form.setValue("inspectionWeightId", null);
            form.setValue("inspectionAssayId", null);
            form.getItem("inspectionWeightId").disable();
            form.getItem("inspectionAssayId").disable();
            form.getItem("inspectionWeightId").setOptionCriteria(null);
            form.getItem("inspectionAssayId").setOptionCriteria(null);
            foreignInvoiceTab.dynamicForm.valuesManager.setValue("billLadings", null);

            let selectedRecord = item.getSelectedRecord();
            if (!selectedRecord) {

                foreignInvoiceTab.button.selectBillLading.disable();
                foreignInvoiceTab.button.selectBillLading.criteria = null;

                return;
            }

            form.getItem("inspectionWeightId").enable();
            form.getItem("inspectionAssayId").enable();
            form.getItem("inspectionWeightId").setOptionCriteria({
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [
                    {
                        fieldName: 'weightInspections',
                        operator: "notNull",
                    }, {
                        fieldName: "weightInspections.shipmentId",
                        operator: "equals",
                        value: selectedRecord.id
                    }
                ]
            });
            form.getItem("inspectionAssayId").setOptionCriteria({
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [
                    {
                        fieldName: 'assayInspections',
                        operator: "notNull",
                    }, {
                        fieldName: "assayInspections.shipmentId",
                        operator: "equals",
                        value: selectedRecord.id
                    }
                ]
            });

            foreignInvoiceTab.button.selectBillLading.enable();
            foreignInvoiceTab.button.selectBillLading.criteria = {
                operator: "equals",
                fieldName: "shipmentId",
                value: selectedRecord.id
            };
        }
    },
    {
        required: true,
        type: "integer",
        name: "creatorId",
        editorType: "SelectItem",
        width: "100%",
        valueField: "id",
        displayField: "fullName",
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "fullName", title: "<spring:message code='global.name'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.personUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.creator'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        required: true,
        width: "100%",
        type: "integer",
        name: "currencyId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameEN",
        optionCriteria: {
            operator: 'and',
            criteria: [{
                fieldName: 'categoryUnit',
                operator: 'equals',
                value: JSON.parse('${Enum_CategoryUnit}').Finance
            }]
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "nameEN", title: "<spring:message code='global.title'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.unitUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.currency'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {

            form.setValue("toCurrencyId", null);
            form.setValue("conversionRefId", null);
            form.getField("conversionRefId").disable();

            if (!value) {

                form.getField("toCurrencyId").disable();
                return;
            }

            form.getField("toCurrencyId").enable();
        }
    },
    {
        disabled: true,
        type: "integer",
        name: "toCurrencyId",
        editorType: "SelectItem",
        width: "100%",
        valueField: "id",
        displayField: "nameEN",
        optionCriteria: {
            operator: 'and',
            criteria: [{
                fieldName: 'categoryUnit',
                operator: 'equals',
                value: JSON.parse('${Enum_CategoryUnit}').Finance
            }]
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "nameEN", title: "<spring:message code='global.title'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.unitUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.to.currency'/>",
        wrapTitle: false,
        changed: function (form, item, value) {

            form.setValue("conversionRefId", null);

            if (!value || !form.getValue("currencyId")) {

                form.getField("conversionRefId").disable();
                return;
            }

            if (form.getValue("currencyId") === form.getValue("toCurrencyId")) {

                form.setValue("toCurrencyId", null);
                form.getField("conversionRefId").disable();
            } else {

                let toDate = form.getItem("date").getValue().duplicate();
                toDate.setHours(23);
                toDate.setMinutes(59);
                toDate.setSeconds(59);
                let fromDate = form.getItem("date").getValue().duplicate();
                fromDate.setHours(0);
                fromDate.setMinutes(0);
                fromDate.setSeconds(0);

                form.getField("conversionRefId").enable();
                form.getField("conversionRefId").setOptionCriteria({
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria:
                        [
                            {
                                fieldName: "currencyDate",
                                operator: "lessOrEqual",
                                value: toDate.toString()
                            },
                            {
                                fieldName: "currencyDate",
                                operator: "greaterOrEqual",
                                value: fromDate.toString()
                            },
                            {
                                fieldName: "unitFromId",
                                operator: "equals",
                                value: form.getItem("currencyId").getValue()
                            },
                            {
                                fieldName: "unitToId",
                                operator: "equals",
                                value: item.getValue()
                            }
                        ]
                });
            }
        }
    },
    {
        disabled: true,
        width: "100%",
        type: "integer",
        name: "conversionRefId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "reference",
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
            {name: "currencyDate", type: "date", title: "<spring:message code='global.date'/>"},
            {name: "unitFrom.nameEN", title: "<spring:message code='global.from'/>"},
            {name: "unitTo.nameEN", title: "<spring:message code='global.to'/>"},
            {name: "currencyRateValue", title: "<spring:message code='rate.title'/>"}
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
                {name: "currencyDate", title: "<spring:message code='global.date'/>"},
                {name: "unitFrom", title: "<spring:message code='global.from'/>"},
                {name: "unitFromId", title: "<spring:message code='global.from'/>"},
                {name: "unitTo", title: "<spring:message code='global.to'/>"},
                {name: "unitToId", title: "<spring:message code='global.to'/>"},
                {name: "currencyRateValue"}
            ],
            fetchDataURL: foreignInvoiceTab.variable.conversionRefUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.conversion-ref'/>",
        wrapTitle: false
    },
    {
        required: true,
        disabled: true,
        width: "100%",
        type: "integer",
        name: "inspectionWeightId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "inspectionNO",
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", hidden: true},
            {name: "inspectionNO", showHover: true},
            {name: "inspector.nameFA", showHover: true},
            {name: "issueDate", showHover: true},
            {name: "seller.nameFA", showHover: true},
            {name: "buyer.nameFA", showHover: true},
            {name: "weightInspections.mileStone", showHover: true}
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "inspectionNO", title: "<spring:message code='inspectionReport.InspectionNO'/>"},
                {name: "inspector.nameFA", title: "<spring:message code='inspectionReport.inspector.nameFA'/>"},
                {
                    name: "issueDate",
                    title: "<spring:message code='inspectionReport.IssueDate'/>",
                    type: "date",
                    width: 100
                },
                {name: "seller.nameFA", title: "<spring:message code='inspectionReport.seller.nameFA'/>"},
                {name: "buyer.nameFA", title: "<spring:message code='inspectionReport.buyer.nameFA'/>"},
                {name: "weightInspections.mileStone", title: "<spring:message code='inspectionReport.weight.mileStone'/>"}
            ],
            fetchDataURL: foreignInvoiceTab.variable.inspectionReportUrl + "spec-list"
        }),
        title: "<spring:message code='weightInspection.title'/>",
        wrapTitle: false,
    },
    {
        required: true,
        disabled: true,
        width: "100%",
        type: "integer",
        name: "inspectionAssayId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "inspectionNO",
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", hidden: true},
            {name: "inspectionNO", showHover: true},
            {name: "inspector.nameFA", showHover: true},
            {name: "issueDate", showHover: true},
            {name: "seller.nameFA", showHover: true},
            {name: "buyer.nameFA", showHover: true},
            {name: "assayInspections.mileStone", showHover: true}
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "inspectionNO", title: "<spring:message code='inspectionReport.InspectionNO'/>"},
                {name: "inspector.nameFA", title: "<spring:message code='inspectionReport.inspector.nameFA'/>"},
                {
                    name: "issueDate",
                    title: "<spring:message code='inspectionReport.IssueDate'/>",
                    type: "date",
                    width: 100
                },
                {name: "seller.nameFA", title: "<spring:message code='inspectionReport.seller.nameFA'/>"},
                {name: "buyer.nameFA", title: "<spring:message code='inspectionReport.buyer.nameFA'/>"},
                {name: "assayInspections.mileStone", title: "<spring:message code='inspectionReport.assay.mileStone'/>"}
            ],
            fetchDataURL: foreignInvoiceTab.variable.inspectionReportUrl + "spec-list"
        }),
        title: "<spring:message code='assayInspection.title'/>",
        wrapTitle: false,
    },
    {
        width: "100%",
        name: "description",
        editorType: "textArea",
        title: "<spring:message code='global.description'/>",
    }
]);

//***************************************************** RESTDATASOURCE *************************************************

//******************************************************* COMPONENTS ***************************************************

foreignInvoiceTab.dynamicForm.valuesManager = isc.ValuesManager.create({});

foreignInvoiceTab.dynamicForm.baseData = isc.DynamicForm.create({

    margin: 10,
    width: "100%",
    align: "center",
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    fields: foreignInvoiceTab.dynamicForm.fields,
    valuesManager: foreignInvoiceTab.dynamicForm.valuesManager,
    requiredMessage: '<spring:message code="validator.field.is.required"/>'
});

foreignInvoiceTab.dynamicForm.baseData.validate = function () {

    let isValid = this.Super("validate", arguments);
    let billLadings = foreignInvoiceTab.dynamicForm.valuesManager.getValue('billLadings');
    if (billLadings == null || billLadings.length === 0) {

        foreignInvoiceTab.dialog.say("<spring:message code='foreign-invoice.form.validate.bill-of-lading.not.selected'/>");
        return false;
    }

    return isValid;
};

foreignInvoiceTab.button.save = isc.IButtonSave.create({
    margin: 10,
    height: 50,
    icon: "pieces/16/save.png",
    title: "<spring:message code='global.form.save'/>",
    click: function () {

        if (!foreignInvoiceTab.dynamicForm.baseData.validate()) return;

        foreignInvoiceTab.tab.invoice.removeTabs(foreignInvoiceTab.tab.invoice.tabs);
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'currency',
            foreignInvoiceTab.dynamicForm.baseData.getField('currencyId').getSelectedRecord());
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'conversionRef',
            foreignInvoiceTab.dynamicForm.baseData.getField('conversionRefId').getSelectedRecord());
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'invoiceType',
            foreignInvoiceTab.dynamicForm.baseData.getField('invoiceTypeId').getSelectedRecord());
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'contract',
            foreignInvoiceTab.dynamicForm.baseData.getField('contractId').getSelectedRecord());
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'shipment',
            foreignInvoiceTab.dynamicForm.baseData.getField('shipmentId').getSelectedRecord());
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'inspectionWeightData',
            foreignInvoiceTab.dynamicForm.baseData.getField('inspectionWeightId').getSelectedRecord());
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'inspectionAssayData',
            foreignInvoiceTab.dynamicForm.baseData.getField('inspectionAssayId').getSelectedRecord());

        // let selectedShipmentRemittanceDetailsCount = foreignInvoiceTab.dynamicForm.valuesManager.getValue('remittanceDetailId').length;
        // let allShipmentRemittanceDetailsCount = Object.keys(foreignInvoiceTab.dynamicForm.baseData.getField('remittanceDetailId').getAllValueMappings()).length;

        foreignInvoiceTab.method.addTab(
            isc.InvoiceBaseInfo.create({
                invoiceNo: foreignInvoiceTab.dynamicForm.valuesManager.getValue('no'),
                invoiceDate: foreignInvoiceTab.dynamicForm.valuesManager.getValue('date'),
                contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract'),
                billLadings: foreignInvoiceTab.dynamicForm.valuesManager.getValue('billLadings'),
                invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue('invoiceType'),
            }), '<spring:message code="foreign-invoice.form.tab.contract-info"/>');

        ////// MOLYBDENUM_OXIDE //////
        if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.MOLYBDENUM_OXIDE) {

            console.log("inspectionWeightData ", foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionWeightData"));
            console.log("inspectionAssayData ", foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionAssayData"));
            let invoiceCalculation2Component = isc.InvoiceCalculation2.create({
                contractDetailData: foreignInvoiceTab.variable.contractDetailData,
                currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract'),
                shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                // remittanceDetails: foreignInvoiceTab.dynamicForm.valuesManager.getValue("remittanceDetails"),
                inspectionWeightData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionWeightData"),
                inspectionAssayData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionAssayData"),
                weightData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("weightData")
            });
            foreignInvoiceTab.method.addTab(invoiceCalculation2Component, '<spring:message code="foreign-invoice.form.tab.calculation"/>');
            invoiceCalculation2Component.okButtonClick = function addRelatedPaymentTab2() {

                let invoicePaymentComponent = isc.InvoicePayment.create({
                    currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                    shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                    conversionRef: foreignInvoiceTab.dynamicForm.valuesManager.getValue('conversionRef'),
                    // shipmentCostInvoiceRate: selectedShipmentRemittanceDetailsCount / allShipmentRemittanceDetailsCount,
                    invoiceCalculation2Component: invoiceCalculation2Component,
                    invoiceBaseWeightComponent: {getValues: invoiceCalculation2Component.getBaseWeightValues},
                    invoiceDeductionComponent: {getDeductionSubTotal: invoiceCalculation2Component.getDeductionSubTotal},
                    invoiceCalculationComponent: {
                        getCalculationSubTotal: function () {
                            return invoiceCalculation2Component.getCalculationSubTotal();
                        }
                    }
                });
                foreignInvoiceTab.method.addTab(invoicePaymentComponent, '<spring:message code="foreign-invoice.form.tab.payment"/>');
            }
            ////// COPPER_CONCENTRATES //////
        } else {

            let invoiceBaseValuesComponent = isc.InvoiceBaseValues.create({
                currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
                contractDetailData: foreignInvoiceTab.variable.contractDetailData,
                shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue("invoiceType"),
                inspectionWeightData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionWeightData"),
                inspectionAssayData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionAssayData"),
                weightData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("weightData")
            });
            foreignInvoiceTab.method.addTab(invoiceBaseValuesComponent, '<spring:message code="foreign-invoice.form.tab.base-values"/>');

            invoiceBaseValuesComponent.okButtonClick = function () {

                let invoiceCalculationComponent = isc.InvoiceCalculation.create({

                    currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                    invoiceBaseAssayComponent: invoiceBaseValuesComponent.invoiceBaseAssayComponent,
                    invoiceBasePriceComponent: invoiceBaseValuesComponent.invoiceBasePriceComponent,
                    calculationData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("calculationData")
                });
                foreignInvoiceTab.method.addTab(invoiceCalculationComponent, '<spring:message code="foreign-invoice.form.tab.calculation"/>');

                invoiceCalculationComponent.okButtonClick = function addRelatedDeductionTab() {

                    let invoiceDeductionComponent = isc.InvoiceDeduction.create({
                        invoiceCalculationComponent: invoiceCalculationComponent,
                        contractDetailData: foreignInvoiceTab.variable.contractDetailData,
                        currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue('currency'),
                        rcDeductionData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("rcDeductionData")
                    });
                    foreignInvoiceTab.method.addTab(invoiceDeductionComponent, '<spring:message code="foreign-invoice.form.tab.deduction"/>');

                    invoiceDeductionComponent.okButtonClick = function addRelatedPaymentTab() {

                        let invoicePaymentComponent = isc.InvoicePayment.create({
                            // shipmentCostInvoiceRate: selectedShipmentRemittanceDetailsCount / allShipmentRemittanceDetailsCount,
                            currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                            shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                            conversionRef: foreignInvoiceTab.dynamicForm.valuesManager.getValue('conversionRef'),
                            invoiceDeductionComponent: invoiceDeductionComponent,
                            invoiceCalculationComponent: invoiceCalculationComponent,
                            invoiceBaseWeightComponent: invoiceBaseValuesComponent.invoiceBaseWeightComponent
                        });
                        foreignInvoiceTab.method.addTab(invoicePaymentComponent, '<spring:message code="foreign-invoice.form.tab.payment"/>');
                    }
                }
            }
        }

        foreignInvoiceTab.window.main.close();
        foreignInvoiceTab.variable.invoiceForm.justShowForm();
    }
});

foreignInvoiceTab.button.cancel = isc.IButtonCancel.create({
    margin: 10,
    height: 50,
    icon: "pieces/16/icon_delete.png",
    title: "<spring:message code='global.cancel'/>",
    click: function () {
        foreignInvoiceTab.window.main.close();
    },
});

foreignInvoiceTab.variable.selectBillLadingForm.validate = function (selectedRecords) {
    return selectedRecords;
};

foreignInvoiceTab.variable.selectBillLadingForm.okCallBack = function (selectedRecords) {
    foreignInvoiceTab.dynamicForm.valuesManager.setValue("billLadings", selectedRecords);
};

foreignInvoiceTab.button.selectBillLading = isc.IButtonSave.create({
    width: 200,
    margin: 10,
    height: 50,
    criteria: null,
    disabled: true,
    icon: "pieces/16/icon_add.png",
    title: "<spring:message code='foreign-invoice.form.button.select.bill-lading'/>",
    click: function () {

        foreignInvoiceTab.variable.selectBillLadingForm.showFindFormByRestApiUrl(
            foreignInvoiceTab.window.main,
            "70%", null, "<spring:message code='foreign-invoice.form.button.select.bill-lading'/>",
            foreignInvoiceTab.dynamicForm.valuesManager.getValue("billLadings"),
            foreignInvoiceTab.variable.billLadingUrl + "spec-list",
            [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "documentNo", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
                {name: "shipperExporter.nameEN", title: "<spring:message code='global.date'/>"},
                {name: "notifyParty.nameEN", title: "<spring:message code='global.from'/>"},
                {name: "consignee.nameEN", title: "<spring:message code='global.to'/>"},
                {name: "portOfLoading.port", title: "<spring:message code='rate.title'/>"},
                {name: "portOfDischarge.port", title: "<spring:message code='rate.title'/>"},
                {name: "placeOfDelivery", title: "<spring:message code='rate.title'/>"},
                {name: "oceanVessel.name", title: "<spring:message code='rate.title'/>"},
            ],
            null, this.criteria, Number.MAX_VALUE);
    }
});

foreignInvoiceTab.window.main = isc.Window.nicico.getDefault('<spring:message code="entity.foreign-invoice"/>', [

    foreignInvoiceTab.dynamicForm.baseData,
    isc.HLayout.create({
        width: "100%",
        members: [
            foreignInvoiceTab.button.save,
            foreignInvoiceTab.button.cancel,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                margin: 0,
                padding: 0,
                members: [foreignInvoiceTab.button.selectBillLading]
            })
        ]
    })
], "50%");

foreignInvoiceTab.tab.invoice = isc.TabSet.create({

    width: "100%",
    height: "600",
    autoDraw: true,
    showEdges: false,
    edgeMarginSize: 3,
    tabBarThickness: 300,
    tabBarPosition: "left",
    // tabBarControls: [],
    // tabs: []
});

foreignInvoiceTab.variable.invoiceForm.validate = function (data) {

    let invoicePaymentTab = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoicePayment.Class).first();
    if (!invoicePaymentTab) return false;

    let invoicePaymentComponent = invoicePaymentTab.pane;
    return invoicePaymentComponent && invoicePaymentComponent.validate();
};

foreignInvoiceTab.variable.invoiceForm.okCallBack = function (data) {

    foreignInvoiceTab.method.jsonRPCManagerRequest({
        data: JSON.stringify(data)
    }, (resp) => {
        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

            foreignInvoiceTab.window.main.close();
            foreignInvoiceTab.method.refresh(foreignInvoiceTab.listGrid.main);
            foreignInvoiceTab.dialog.ok();
        }
    });

};

foreignInvoiceTab.variable.invoiceForm.populateData = function (bodyWidget) {

    let invoicePaymentComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoicePayment.Class).first();
    if (!invoicePaymentComponent) return null;

    let data = foreignInvoiceTab.dynamicForm.valuesManager.getValues();
    // let remittanceDetails = foreignInvoiceTab.dynamicForm.valuesManager.getValue('remittanceDetails');
    let inspectionWeightData = foreignInvoiceTab.dynamicForm.valuesManager.getValue('inspectionWeightData');
    let inspectionAssayData = foreignInvoiceTab.dynamicForm.valuesManager.getValue('inspectionAssayData');
    let weightMilestone = inspectionWeightData.weightInspections.first().mileStone;
    let assayMilestone = inspectionAssayData.assayInspections.first().mileStone;

    data.billLadingIds = data.billLadings.map(q => q.id);
    data.buyerId = data.contract.contractContacts.filter(q => q.commercialRole === JSON.parse('${Enum_CommercialRole}').Buyer).first().contactId;

    let paymentComponentValues = invoicePaymentComponent.pane.getValues();
    data.unitCost = paymentComponentValues.unitCost;
    data.unitPrice = paymentComponentValues.unitPrice;
    data.sumPrice = paymentComponentValues.sumPrice.getValues().value;
    data.sumFIPrice = paymentComponentValues.sumFIPrice.getValues().value;
    data.conversionDate = paymentComponentValues.conversionDate;
    data.conversionRate = paymentComponentValues.conversionRate;
    data.conversionSumPrice = paymentComponentValues.conversionSumPrice.getValues().value;
    data.conversionSumPriceText = paymentComponentValues.conversionSumPriceText;
    data.sumPIPrice = data.sumFIPrice - data.sumPrice;
    data.inspectionWeightReportId = inspectionWeightData.id;
    data.inspectionAssayReportId = inspectionAssayData.id;
    data.foreignInvoicePayments = paymentComponentValues.shipmentCostInvoices;

    if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.COPPER_CONCENTRATES) {

        let invoiceBaseValuesComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceBaseValues.Class).first().pane;
        let invoiceBasePriceComponent = invoiceBaseValuesComponent.invoiceBasePriceComponent;
        let invoiceBaseAssayComponent = invoiceBaseValuesComponent.invoiceBaseAssayComponent;
        let invoiceBaseWeightComponent = invoiceBaseValuesComponent.invoiceBaseWeightComponent;

        let invoiceCalculationComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceCalculation.Class).first();
        if (!invoiceCalculationComponent) return null;
        let invoiceDeductionComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceDeduction.Class).first();
        if (!invoiceDeductionComponent) return null;

        function getForeignInvoiceItemDetails() {
            let itemDetails = [];
            invoiceBaseAssayComponent.getValues().forEach(q => {
                itemDetails.add({
                    assay: q.value,
                    materialElementId: q.materialElementId,
                    basePrice: invoiceBasePriceComponent.getValues().filter(bp => bp.elementId === q.elementId).first().value,
                    deductionType: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.elementId).first().deductionType,
                    deductionValue: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.elementId).first().deductionValue,
                    deductionPrice: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.elementId).first().deductionPrice,
                    deductionUnitConversionRate: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.elementId).first().deductionUnitConversionRate,
                    rcPrice: invoiceDeductionComponent.pane.getValues().slice(1).filter(trc => trc.materialElementId === q.materialElementId).first().rcPrice,
                    rcBasePrice: invoiceDeductionComponent.pane.getValues().slice(1).filter(trc => trc.materialElementId === q.materialElementId).first().rcBasePrice.getValues().value,
                    rcUnitConversionRate: invoiceDeductionComponent.pane.getValues().slice(1).filter(trc => trc.materialElementId === q.materialElementId).first().rcUnitConversionRate
                })
            });
            return itemDetails;
        }

        data.foreignInvoiceItems = function () {
            let items = [];

            inspectionWeightData.weightInspections.forEach(current => {
                items.add({
                    remittanceDetailId: current.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id,
                    weightMilestone: weightMilestone,
                    weightGW: inspectionWeightData.weightGW,
                    weightND: inspectionWeightData.weightND,
                    assayMilestone: assayMilestone,
                    treatCost: invoiceDeductionComponent.pane.getValues().filter(q => q.name === "TC").first().value,
                    foreignInvoiceItemDetails: getForeignInvoiceItemDetails()
                });
            });
            return items;
        }();
    } else if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.MOLYBDENUM_OXIDE) {

        let invoiceCalculation2Component = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceCalculation2.Class).first().pane;
        data.foreignInvoiceItems = invoiceCalculation2Component.getForeignInvoiceItems();
    } else {
        ///// COPPER CATHODE /////
    }

    delete data.contract;
    delete data.conversionRef;
    delete data.currency;
    delete data.billLadings;
    delete data.invoiceType;
    delete data.shipment;
    delete data.toCurrencyId;
    delete data.remittanceDetails;
    delete data.remittanceDetailId;
    delete data.calculationData;
    delete data.rcDeductionData;
    delete data.payments;

    console.log("populate data ", data);
    return data;
};

foreignInvoiceTab.variable.invoiceForm.init(null, '<spring:message code="entity.foreign-invoice"/>', foreignInvoiceTab.tab.invoice, "70%");

nicico.BasicFormUtil.createListGrid = function () {

    foreignInvoiceTab.listGrid.main = isc.ListGrid.nicico.getDefault(
        foreignInvoiceTab.listGrid.fields,
        foreignInvoiceTab.restDataSource.main,
        foreignInvoiceTab.listGrid.criteria, {
            sortField: 1,
            sortDirection: "descending"
        });
};
nicico.BasicFormUtil.getDefaultBasicForm(foreignInvoiceTab, "api/foreign-invoice/");
nicico.BasicFormUtil.showAllToolStripActions(foreignInvoiceTab);
nicico.BasicFormUtil.removeExtraActions(foreignInvoiceTab, [nicico.ActionType.DELETE]);

foreignInvoiceTab.dynamicForm.main = null;

//*************************************************** Functions ********************************************************

foreignInvoiceTab.method.newForm = function () {

    foreignInvoiceTab.variable.method = "POST";
    foreignInvoiceTab.dynamicForm.valuesManager.clearValues();
    foreignInvoiceTab.dynamicForm.valuesManager.clearErrors();
    foreignInvoiceTab.dynamicForm.baseData.getFields().forEach(field => {

        if (field.name === "date" || field.name === "invoiceTypeId")
            field.enable();

        if (!field.changed) return;
        field.changed(foreignInvoiceTab.dynamicForm.baseData, field, field.getValue());
    });
    // Concentrate
    // foreignInvoiceTab.dynamicForm.valuesManager.setValues({
    //     "date": "2020-09-29T08:30:00.000Z",
    //         "billLadings": [
    //         {
    //             "documentNo": "123123",
    //             "switchDocumentNo": "123123",
    //             "shipperExporterId": 41,
    //             "switchShipperExporterId": 41,
    //             "notifyPartyId": 2,
    //             "switchNotifyPartyId": 2,
    //             "consigneeId": 1,
    //             "switchConsigneeId": 1,
    //             "portOfLoadingId": 2,
    //             "switchPortOfLoadingId": 2,
    //             "portOfDischargeId": 31,
    //             "switchPortOfDischargeId": 31,
    //             "placeOfDelivery": "ABU DHABI",
    //             "oceanVesselId": 37,
    //             "numberOfBlCopies": 2,
    //             "dateOfIssue": 1600587000000,
    //             "placeOfIssue": "tehran",
    //             "description": "asd",
    //             "totalNet": 123,
    //             "totalGross": 3,
    //             "totalBundles": 123,
    //             "shipmentId": 1,
    //             "shipmentTypeId": 1,
    //             "shipmentMethodId": 1,
    //             "id": 1,
    //             "shipperExporter": {
    //                 "nameFA": "سونگ ایک خار",
    //                 "nameEN": "XSUNGILL RESOURCES LTD",
    //                 "phone": "8511101111",
    //                 "fax": "85237020210",
    //                 "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 41,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "China"
    //                 },
    //                 "createdDate": 1579683563975,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1601359142895,
    //                 "lastModifiedBy": "root",
    //                 "version": 3
    //             },
    //             "switchShipperExporter": {
    //                 "nameFA": "سونگ ایک خار",
    //                 "nameEN": "XSUNGILL RESOURCES LTD",
    //                 "phone": "8511101111",
    //                 "fax": "85237020210",
    //                 "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 41,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "China"
    //                 },
    //                 "createdDate": 1579683563975,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1601359142895,
    //                 "lastModifiedBy": "root",
    //                 "version": 3
    //             },
    //             "notifyParty": {
    //                 "nameFA": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "nameEN": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "phone": "+982182138231",
    //                 "fax": "+982188102822",
    //                 "address": "NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Seller",
    //                 "seller": true,
    //                 "buyer": false,
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFa": "ایران",
    //                     "nameEn": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1578197254109,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1586834700749,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 6
    //             },
    //             "switchNotifyParty": {
    //                 "nameFA": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "nameEN": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "phone": "+982182138231",
    //                 "fax": "+982188102822",
    //                 "address": "NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Seller",
    //                 "seller": true,
    //                 "buyer": false,
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFa": "ایران",
    //                     "nameEn": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1578197254109,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1586834700749,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 6
    //             },
    //             "consignee": {
    //                 "nameFA": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "nameEN": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "phone": "+8601068495586",
    //                 "fax": "+8601068495562",
    //                 "address": "NO.5 SANLIHE ROAD, HAIDIAN DISTRICT, BEIJING 100044, P.R. CHINA ",
    //                 "type": false,
    //                 "nationalCode": "0",
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "seller": false,
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 1,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "China"
    //                 },
    //                 "createdDate": 1578197169411,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600688095376,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 47,
    //                 "defaultAccount": {
    //                     "contactId": 1,
    //                     "bankId": 2,
    //                     "bankAccount": "90101",
    //                     "bankShaba": "IR888888800000000008888888",
    //                     "code": "110019",
    //                     "bankSwift": "898888800000088",
    //                     "accountOwner": "88000008",
    //                     "status": true,
    //                     "isDefault": true,
    //                     "id": 10,
    //                     "bank": {
    //                         "bankName": "ای سی ای",
    //                         "countryId": 15,
    //                         "enBankName": "ECA",
    //                         "address": "NY",
    //                         "coreBranch": "core"
    //                     },
    //                     "createdDate": 1600245090704,
    //                     "createdBy": "db_zare",
    //                     "lastModifiedDate": 1600690356857,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 9
    //                 }
    //             },
    //             "switchConsignee": {
    //                 "nameFA": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "nameEN": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "phone": "+8601068495586",
    //                 "fax": "+8601068495562",
    //                 "address": "NO.5 SANLIHE ROAD, HAIDIAN DISTRICT, BEIJING 100044, P.R. CHINA ",
    //                 "type": false,
    //                 "nationalCode": "0",
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "seller": false,
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 1,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "China"
    //                 },
    //                 "createdDate": 1578197169411,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600688095376,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 47,
    //                 "defaultAccount": {
    //                     "contactId": 1,
    //                     "bankId": 2,
    //                     "bankAccount": "90101",
    //                     "bankShaba": "IR888888800000000008888888",
    //                     "code": "110019",
    //                     "bankSwift": "898888800000088",
    //                     "accountOwner": "88000008",
    //                     "status": true,
    //                     "isDefault": true,
    //                     "id": 10,
    //                     "bank": {
    //                         "bankName": "ای سی ای",
    //                         "countryId": 15,
    //                         "enBankName": "ECA",
    //                         "address": "NY",
    //                         "coreBranch": "core"
    //                     },
    //                     "createdDate": 1600245090704,
    //                     "createdBy": "db_zare",
    //                     "lastModifiedDate": 1600690356857,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 9
    //                 }
    //             },
    //             "portOfLoading": {
    //                 "port": "BANDAR ABBAS",
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFa": "ایران",
    //                     "nameEn": "Iran (Islamic Republic of)",
    //                     "id": 1,
    //                     "createdDate": 1599977039976,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1578198852719,
    //                 "createdBy": "dorani_sa",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfLoading": {
    //                 "port": "BANDAR ABBAS",
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFa": "ایران",
    //                     "nameEn": "Iran (Islamic Republic of)",
    //                     "id": 1,
    //                     "createdDate": 1599977039976,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1578198852719,
    //                 "createdBy": "dorani_sa",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "portOfDischarge": {
    //                 "port": "ABU DHABI",
    //                 "countryId": 3,
    //                 "id": 31,
    //                 "country": {
    //                     "nameFa": "افغانستان",
    //                     "nameEn": "Afghanistan",
    //                     "id": 3,
    //                     "createdDate": 1599977039990,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587866317999,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfDischarge": {
    //                 "port": "ABU DHABI",
    //                 "countryId": 3,
    //                 "id": 31,
    //                 "country": {
    //                     "nameFa": "افغانستان",
    //                     "nameEn": "Afghanistan",
    //                     "id": 3,
    //                     "createdDate": 1599977039990,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587866317999,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "oceanVessel": {
    //                 "name": "AGIA ELENI",
    //                 "type": "Bulk Carrier",
    //                 "imo": "9370317",
    //                 "yearOfBuild": 2008,
    //                 "length": 170.7,
    //                 "beam": 27,
    //                 "id": 37,
    //                 "createdDate": 1588382861641,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "containers": [
    //                 {
    //                     "billOfLandingId": 1,
    //                     "containerType": "20foot",
    //                     "containerNo": "123",
    //                     "sealNo": "123",
    //                     "quantity": 123,
    //                     "quantityType": "ورق",
    //                     "weight": 2,
    //                     "unitId": 5,
    //                     "id": 1,
    //                     "unit": {
    //                         "nameFA": "شاخه",
    //                         "nameEN": "شاخه",
    //                         "categoryUnit": "Weight",
    //                         "symbolUnit": "BULK",
    //                         "id": 5,
    //                         "createdDate": 1600057458454,
    //                         "createdBy": "taghavifar",
    //                         "version": 0,
    //                         "editable": false,
    //                         "estatus": [
    //                             "Active"
    //                         ]
    //                     },
    //                     "createdDate": 1600070537703,
    //                     "createdBy": "taghavifar",
    //                     "lastModifiedDate": 1601355368165,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 1,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 }
    //             ],
    //             "shipmentType": {
    //                 "shipmentType": "فله",
    //                 "id": 1,
    //                 "createdDate": 1587278588350,
    //                 "createdBy": "j.azad",
    //                 "lastModifiedDate": 1587278588350,
    //                 "lastModifiedBy": "j.azad",
    //                 "version": 0
    //             },
    //             "shipmentMethod": {
    //                 "shipmentMethod": "حمل زمینی",
    //                 "id": 1,
    //                 "createdDate": 1587278588350,
    //                 "createdBy": "j.azad",
    //                 "lastModifiedDate": 1587278588350,
    //                 "lastModifiedBy": "j.azad",
    //                 "version": 0
    //             },
    //             "createdDate": 1600070495670,
    //             "createdBy": "taghavifar",
    //             "lastModifiedDate": 1600576546950,
    //             "lastModifiedBy": "taghavifar",
    //             "version": 1,
    //             "editable": true,
    //             "shipment": {
    //                 "contractShipmentId": 1,
    //                 "shipmentTypeId": 1,
    //                 "shipmentMethodId": 2,
    //                 "contactId": 41,
    //                 "materialId": 3,
    //                 "contactAgentId": 136,
    //                 "vesselId": 37,
    //                 "unitId": 4,
    //                 "dischargePortId": 31,
    //                 "amount": 70000,
    //                 "automationLetterNo": "1242",
    //                 "automationLetterDate": 1596396600000,
    //                 "sendDate": 1473811200000,
    //                 "noBLs": 2,
    //                 "bookingCat": "1234",
    //                 "arrivalDateFrom": 1581669000000,
    //                 "arrivalDateTo": 1581669000000,
    //                 "lastDeliveryLetterDate": 1600068600000,
    //                 "id": 1,
    //                 "createdDate": 1600068124999,
    //                 "createdBy": "m.shahabi",
    //                 "lastModifiedDate": 1600762686847,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 1,
    //                 "editable": true,
    //                 "unit": {
    //                     "nameFA": "بسته",
    //                     "nameEN": "BUNDLE",
    //                     "categoryUnit": "Weight",
    //                     "symbolUnit": "PERCENT",
    //                     "id": 4,
    //                     "createdDate": 1593755140054,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1594100538548,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 2,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "vessel": {
    //                     "name": "AGIA ELENI",
    //                     "type": "Bulk Carrier",
    //                     "imo": "9370317",
    //                     "yearOfBuild": 2008,
    //                     "length": 170.7,
    //                     "beam": 27,
    //                     "id": 37,
    //                     "createdDate": 1588382861641,
    //                     "createdBy": "db_mazloom",
    //                     "version": 0,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "contact": {
    //                     "nameFA": "سونگ ایک خار",
    //                     "nameEN": "XSUNGILL RESOURCES LTD",
    //                     "phone": "8511101111",
    //                     "fax": "85237020210",
    //                     "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
    //                     "type": false,
    //                     "status": true,
    //                     "commercialRole": "Buyer",
    //                     "buyer": true,
    //                     "countryId": 2,
    //                     "id": 41,
    //                     "country": {
    //                         "nameFa": "چین",
    //                         "nameEn": "China"
    //                     },
    //                     "createdDate": 1579683563975,
    //                     "createdBy": "dorani_sa",
    //                     "lastModifiedDate": 1601359142895,
    //                     "lastModifiedBy": "root",
    //                     "version": 3
    //                 },
    //                 "dischargePort": {
    //                     "port": "ABU DHABI",
    //                     "countryId": 3,
    //                     "id": 31,
    //                     "country": {
    //                         "nameFa": "افغانستان",
    //                         "nameEn": "Afghanistan",
    //                         "id": 3,
    //                         "createdDate": 1599977039990,
    //                         "createdBy": "j.azad",
    //                         "version": 0,
    //                         "editable": false,
    //                         "estatus": [
    //                             "Active"
    //                         ]
    //                     },
    //                     "createdDate": 1587866317999,
    //                     "createdBy": "db_mazloom",
    //                     "version": 0,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "contactAgent": {
    //                     "nameFA": "GRASH DARYA",
    //                     "nameEN": "GRASH DARYA",
    //                     "phone": "21-88727255",
    //                     "fax": "21-88726762",
    //                     "type": false,
    //                     "status": true,
    //                     "tradeMark": "GRASH DARYA",
    //                     "commercialRole": "Transporter",
    //                     "seller": false,
    //                     "transporter": true,
    //                     "agentBuyer": false,
    //                     "countryId": 1,
    //                     "id": 136,
    //                     "country": {
    //                         "nameFa": "ایران",
    //                         "nameEn": "Iran (Islamic Republic of)"
    //                     },
    //                     "createdDate": 1587875271899,
    //                     "createdBy": "db_mazloom",
    //                     "lastModifiedDate": 1588475503870,
    //                     "lastModifiedBy": "db_mazloom",
    //                     "version": 1
    //                 },
    //                 "material": {
    //                     "descl": "Copper Concentrate",
    //                     "descp": "مس کنسانتره",
    //                     "code": "26030090",
    //                     "unitId": -1,
    //                     "abbreviation": "CONC",
    //                     "id": 3,
    //                     "unit": {
    //                         "nameFA": "تن",
    //                         "nameEN": "MT",
    //                         "categoryUnit": "Weight",
    //                         "symbolUnit": "PERCENT"
    //                     },
    //                     "createdDate": 1599977041712,
    //                     "createdBy": "liquibase",
    //                     "version": 6
    //                 },
    //                 "shipmentType": {
    //                     "shipmentType": "فله",
    //                     "id": 1,
    //                     "createdDate": 1587278588350,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1587278588350,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 0
    //                 },
    //                 "shipmentMethod": {
    //                     "shipmentMethod": "حمل هوایی",
    //                     "id": 2,
    //                     "createdDate": 1587278588350,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1587278588350,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 0
    //                 },
    //                 "contractShipment": {
    //                     "loadPortId": 2,
    //                     "quantity": 200000,
    //                     "sendDate": "2016-09-14",
    //                     "tolorance": 5,
    //                     "contractId": 1,
    //                     "id": 1,
    //                     "contract": {
    //                         "no": "100",
    //                         "date": 1600677000000,
    //                         "affectFrom": 1600677000000,
    //                         "affectUpTo": 1600677000000,
    //                         "content": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG<br>NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN<br>+852 2575 7591<br>+982188102822<br>+852 3702 0210<br>+982182138231<br>NATIONAL IRANIAN COPPER INDUSTRIES CO.<br>SUNGILL RESOURCES LTD<br><h2>new deduction</h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Treatment Cost</th><th style='border: 1px solid black;'>Refinery Cost</th><th style='border: 1px solid black;'>Unit</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>31</td><td style='border: 1px solid black;'>321</td><td style='border: 1px solid black;'>Euro</td><td style='border: 1px solid black;'>S</td></tr><tr><td style='border: 1px solid black;'>3245</td><td style='border: 1px solid black;'>543</td><td style='border: 1px solid black;'>MT</td><td style='border: 1px solid black;'>MO</td></tr><tr><td style='border: 1px solid black;'>435</td><td style='border: 1px solid black;'>534</td><td style='border: 1px solid black;'>null</td><td style='border: 1px solid black;'>null</td></tr></table><br><h2>CLAUSE 1  DEFINITIONS </h2><p class=\"MsoNormal\" style=\"margin-bottom:0in;margin-bottom:.0001pt;text-align:\njustify;text-justify:inter-ideograph;line-height:normal\"><b><span style=\"color:black;mso-themecolor:text1\">1 TON = 1 METRIC TON OF 1'000\nKILOGRAMS OR 2204.62 LBS</span></b><b><u><span style=\"mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black\"><o:p></o:p></span></u></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal\"><b><span lang=\"EN-GB\" style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;\ncolor:black;mso-themecolor:text1;mso-ansi-language:EN-GB\">LME = LONDON METAL\nEXCHANGE<o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal;\ntab-stops:0in\"><b><span style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;\ncolor:black;mso-themecolor:text1\">WORKING/BUSINESS DAY FOR BUYER = MONDAY TO\nFRIDAY; SATURDAY, SUNDAY AND LEGAL HOLIDAY EXCLUDED.<o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal;\ntab-stops:0in\"><b><span style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;\ncolor:black;mso-themecolor:text1\">WORKING/BUSINESS DAY FOR SELLER = SATURDAY TO\nWEDNESDAY; THURSDAY AND FRIDAY AND LEGAL HOLIDAY EXCLUDED.<o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal\"><b><span lang=\"DE\" style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;color:black;\nmso-themecolor:text1;mso-ansi-language:DE\">AM/PM = ANTE MERIDIEM / POST MERIDIEM<o:p></o:p></span></b></p>\n\n<p class=\"MsoNormal\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span lang=\"EN-GB\" style=\"color:black;mso-themecolor:text1;\nmso-ansi-language:EN-GB\">INCOTERMS = </span></b><b><span style=\"mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black\">SHALL MEAN THE INTERNATIONAL\nCHAMBER OF COMMERCE’S OFFICIAL RULES FOR THE INTERPRETATION OF TRADE TERMS\nKNOWN AS INCOTERMS</span></b><b><span lang=\"EN-GB\" style=\"color:black;mso-themecolor:\ntext1;mso-ansi-language:EN-GB\"><o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal\"><b><span style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;color:black;\nmso-themecolor:text1\">THE MATERIAL = SHALL MEAN THE MATERIAL AS DEFINED IN\n\"ARTICLE 3 – QUALITY\" <o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">CIF = COST,\nINSURANCE AND FREIGHT (ACCORDING TO INCOTERMS 2010).<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">DAP = DELIVERY\nAT PLACE (ACCORDING TO INCOTERMS 2010).<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">FOB = FREE ON\nBOARD (ACCORDING TO INCOTERMS 2010).<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">ST = STOWED\nAND TRIMMED<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1;mso-ansi-language:\nEN-GB\">USD AND USC = DOLLARS AND CENTS ARE UNITED STATES CURRENCY</span></b><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;mso-ascii-theme-font:\nmajor-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;mso-hansi-theme-font:major-bidi;\nmso-bidi-font-family:&quot;Times New Roman&quot;;mso-bidi-theme-font:major-bidi;\ncolor:black;mso-themecolor:text1;mso-ansi-language:EN-GB;mso-fareast-language:\nZH-CN\"><o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"color:black;mso-themecolor:text1\">EURO =\nEURO IS THE SINGLE CURRENCY OF THE EUROPEAN ECONOMIC AND MONETARY UNION (EMU)\nINTRODUCED IN </span></b><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1;mso-ansi-language:\nEN-GB\">JANUARY 1999.<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi\">AED = UNITED ARAB EMIRATES DIRHAM<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"text-align:justify;text-justify:inter-ideograph\"><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;mso-ascii-theme-font:\nmajor-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;mso-hansi-theme-font:major-bidi;\nmso-bidi-font-family:&quot;Times New Roman&quot;;mso-bidi-theme-font:major-bidi;\ncolor:black;mso-themecolor:text1;mso-ansi-language:EN-GB\">MOAS = MONTH OF\nACUTAL SHIPMENT.</span></b><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi\"><o:p></o:p></span></b></p><h2>CLAUSE 2  QUANTITY </h2>200000&nbsp;&nbsp;&nbsp;PERCENT<br>5<br>SELLER<br>2016<br><h2>CLAUSE 3  QUALITY </h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Minimum</th><th style='border: 1px solid black;'>Maximum</th><th style='border: 1px solid black;'>Unit</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>22</td><td style='border: 1px solid black;'>28</td><td style='border: 1px solid black;'>MT</td><td style='border: 1px solid black;'>CD</td></tr></table><br><h2>CLAUSE 4  SHIPMENT </h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Load Port</th><th style='border: 1px solid black;'>Quantity</th><th style='border: 1px solid black;'>Tolorance</th><th style='border: 1px solid black;'>Send Date</th></tr><tr><td style='border: 1px solid black;'>BANDAR ABBAS</td><td style='border: 1px solid black;'>200000</td><td style='border: 1px solid black;'>5</td><td style='border: 1px solid black;'>Wed Sep 14 2016 12:00:00 GMT+0430 (Iran Daylight Time)</td></tr><tr><td style='border: 1px solid black;'>FANGCHENG</td><td style='border: 1px solid black;'>30000</td><td style='border: 1px solid black;'>5</td><td style='border: 1px solid black;'>Wed Sep 16 2020 12:00:00 GMT+0430 (Iran Daylight Time)</td></tr></table><br><h2>CLAUSE 5  DELIVERY TERMS </h2>Incoterms-2010<br><h2>CLAUSE 10  QUOTATIONAL PERIOD </h2>2<br><h2>CLAUSE 11  PAYMENT</h2>100<br><h2>CLAUSE 12  CURRENCY EXCHANGE  </h2>دلار آمریکا<br><h2>ARTICLE 7 - PRICE</h2><div align=\"right\"><div align=\"left\"><span style=\"font-size:8.0pt;mso-fareast-font-family:\n&quot;Times New Roman&quot;;color:black;mso-bidi-language:HE\">PRICE FOR MOLYBDENUM OXIDE\nWILL BE BASED ON THE PLATT'S METALS WEEK MONTHLY AVERAGE FOR MOLYBDENUM OXIDE,\nAS PUBLISHED IN MONTHLY REPORT OF PLATT'S METALS WEEK UNDER THE HEADING\n\"DEALER OXIDE MIDPOINT/MEAN\" PER POUND OF MOLYBDENUM CONTENT WITH\nDISCOUNTS AS BELOW:</span><br></div><span style=\"font-size:8.0pt;mso-fareast-font-family:\n&quot;Times New Roman&quot;;color:black;mso-bidi-language:HE\"></span><p style=\"text-align:justify\"><span style=\"font-size:8.0pt;mso-fareast-font-family:\n&quot;Times New Roman&quot;;color:black;mso-bidi-language:HE\"><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Minimum</th><th style='border: 1px solid black;'>Maximum</th><th style='border: 1px solid black;'>Discount</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>1</td><td style='border: 1px solid black;'>2</td><td style='border: 1px solid black;'>15</td><td style='border: 1px solid black;'>CU</td></tr></table><br></span></p>\n\n<!--[if gte mso 9]><xml>\n <o:OfficeDocumentSettings>\n  <o:TargetScreenSize>800x600</o:TargetScreenSize>\n </o:OfficeDocumentSettings>\n</xml><![endif]--><!--[if gte mso 9]><xml>\n <w:WordDocument>\n  <w:View>Normal</w:View>\n  <w:Zoom>0</w:Zoom>\n  <w:TrackMoves/>\n  <w:TrackFormatting/>\n  <w:PunctuationKerning/>\n  <w:ValidateAgainstSchemas/>\n  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>\n  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>\n  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>\n  <w:DoNotPromoteQF/>\n  <w:LidThemeOther>EN-US</w:LidThemeOther>\n  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>\n  <w:LidThemeComplexScript>AR-SA</w:LidThemeComplexScript>\n  <w:Compatibility>\n   <w:BreakWrappedTables/>\n   <w:SnapToGridInCell/>\n   <w:WrapTextWithPunct/>\n   <w:UseAsianBreakRules/>\n   <w:DontGrowAutofit/>\n   <w:SplitPgBreakAndParaMark/>\n   <w:EnableOpenTypeKerning/>\n   <w:DontFlipMirrorIndents/>\n   <w:OverrideTableStyleHps/>\n  </w:Compatibility>\n  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>\n  <m:mathPr>\n   <m:mathFont m:val=\"Cambria Math\"/>\n   <m:brkBin m:val=\"before\"/>\n   <m:brkBinSub m:val=\"&#45;-\"/>\n   <m:smallFrac m:val=\"off\"/>\n   <m:dispDef/>\n   <m:lMargin m:val=\"0\"/>\n   <m:rMargin m:val=\"0\"/>\n   <m:defJc m:val=\"centerGroup\"/>\n   <m:wrapIndent m:val=\"1440\"/>\n   <m:intLim m:val=\"subSup\"/>\n   <m:naryLim m:val=\"undOvr\"/>\n  </m:mathPr></w:WordDocument>\n</xml><![endif]--><!--[if gte mso 9]><xml>\n <w:LatentStyles DefLockedState=\"false\" DefUnhideWhenUsed=\"false\"\n  DefSemiHidden=\"false\" DefQFormat=\"false\" DefPriority=\"99\"\n  LatentStyleCount=\"371\">\n  <w:LsdException Locked=\"false\" Priority=\"0\" QFormat=\"true\" Name=\"Normal\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 7\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 8\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 9\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 6\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 7\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 8\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 9\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 7\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 8\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 9\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Normal Indent\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"footnote text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"annotation text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"header\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"footer\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index heading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"35\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"caption\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"table of figures\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"envelope address\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"envelope return\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"footnote reference\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"annotation reference\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"line number\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"page number\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"endnote reference\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"endnote text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"table of authorities\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"macro\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"toa heading\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"10\" QFormat=\"true\" Name=\"Title\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Closing\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Signature\"/>\n  <w:LsdException Locked=\"false\" Priority=\"0\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"Default Paragraph Font\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text Indent\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Message Header\"/>\n  <w:LsdException Locked=\"false\" Priority=\"11\" QFormat=\"true\" Name=\"Subtitle\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Salutation\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Date\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text First Indent\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text First Indent 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Note Heading\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text Indent 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text Indent 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Block Text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Hyperlink\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"FollowedHyperlink\"/>\n  <w:LsdException Locked=\"false\" Priority=\"22\" QFormat=\"true\" Name=\"Strong\"/>\n  <w:LsdException Locked=\"false\" Priority=\"20\" QFormat=\"true\" Name=\"Emphasis\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Document Map\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Plain Text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"E-mail Signature\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Top of Form\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Bottom of Form\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Normal (Web)\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Acronym\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Address\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Cite\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Code\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Definition\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Keyboard\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Preformatted\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Sample\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Typewriter\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Variable\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Normal Table\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"annotation subject\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"No List\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Outline List 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Outline List 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Outline List 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Simple 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Simple 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Simple 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Colorful 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Colorful 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Colorful 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 6\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 7\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 8\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 6\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 7\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 8\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table 3D effects 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table 3D effects 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table 3D effects 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Contemporary\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Elegant\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Professional\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Subtle 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Subtle 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Web 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Web 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Web 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Balloon Text\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"Table Grid\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Theme\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" Name=\"Placeholder Text\"/>\n  <w:LsdException Locked=\"false\" Priority=\"1\" QFormat=\"true\" Name=\"No Spacing\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" Name=\"Revision\"/>\n  <w:LsdException Locked=\"false\" Priority=\"34\" QFormat=\"true\"\n   Name=\"List Paragraph\"/>\n  <w:LsdException Locked=\"false\" Priority=\"29\" QFormat=\"true\" Name=\"Quote\"/>\n  <w:LsdException Locked=\"false\" Priority=\"30\" QFormat=\"true\"\n   Name=\"Intense Quote\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"19\" QFormat=\"true\"\n   Name=\"Subtle Emphasis\"/>\n  <w:LsdException Locked=\"false\" Priority=\"21\" QFormat=\"true\"\n   Name=\"Intense Emphasis\"/>\n  <w:LsdException Locked=\"false\" Priority=\"31\" QFormat=\"true\"\n   Name=\"Subtle Reference\"/>\n  <w:LsdException Locked=\"false\" Priority=\"32\" QFormat=\"true\"\n   Name=\"Intense Reference\"/>\n  <w:LsdException Locked=\"false\" Priority=\"33\" QFormat=\"true\" Name=\"Book Title\"/>\n  <w:LsdException Locked=\"false\" Priority=\"37\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"Bibliography\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"TOC Heading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"41\" Name=\"Plain Table 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"42\" Name=\"Plain Table 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"43\" Name=\"Plain Table 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"44\" Name=\"Plain Table 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"45\" Name=\"Plain Table 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"40\" Name=\"Grid Table Light\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\" Name=\"Grid Table 1 Light\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\" Name=\"Grid Table 6 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\" Name=\"Grid Table 7 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\" Name=\"List Table 1 Light\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\" Name=\"List Table 6 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\" Name=\"List Table 7 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 6\"/>\n </w:LatentStyles>\n</xml><![endif]--><!--[if gte mso 10]>\n<style>\n /* Style Definitions */\n table.MsoNormalTable\n\t{mso-style-name:\"Table Normal\";\n\tmso-tstyle-rowband-size:0;\n\tmso-tstyle-colband-size:0;\n\tmso-style-noshow:yes;\n\tmso-style-priority:99;\n\tmso-style-parent:\"\";\n\tmso-padding-alt:0in 5.4pt 0in 5.4pt;\n\tmso-para-margin:0in;\n\tmso-para-margin-bottom:.0001pt;\n\tmso-pagination:widow-orphan;\n\tfont-size:10.0pt;\n\tfont-family:\"Times New Roman\",serif;}\n</style>\n<![endif]--></div>",
    //                         "materialId": 3,
    //                         "contractTypeId": 1
    //                     },
    //                     "loadPort": {
    //                         "port": "BANDAR ABBAS",
    //                         "countryId": 1
    //                     },
    //                     "createdDate": 1600005922013,
    //                     "createdBy": "r.mazloom",
    //                     "lastModifiedDate": 1600674681760,
    //                     "lastModifiedBy": "r.mazloom",
    //                     "version": 21
    //                 },
    //                 "estatus": [
    //                     "Active"
    //                 ],
    //                 "moisture": 0
    //             },
    //             "estatus": [
    //                 "Active"
    //             ],
    //             "_selection_402": true,
    //             "_embeddedComponents_isc_ListGrid_9": null
    //         }
    //     ],
    //         "invoiceTypeId": 1,
    //         "contractId": 1,
    //         "shipmentId": 1,
    //         "inspectionWeightId": 190,
    //         "inspectionAssayId": 191,
    //         "creatorId": 2,
    //         "currencyId": -32,
    //         "toCurrencyId": null,
    //         "conversionRefId": null
    // });

    // Molybdenum
    foreignInvoiceTab.dynamicForm.valuesManager.setValues({
        "date": "2020-10-03T08:30:00.000Z",
        "billLadings": [
            {
                "documentNo": "662",
                "switchDocumentNo": "662",
                "shipperExporterId": 2,
                "switchShipperExporterId": 2,
                "notifyPartyId": 225,
                "switchNotifyPartyId": 225,
                "consigneeId": 1,
                "switchConsigneeId": 1,
                "portOfLoadingId": 33,
                "switchPortOfLoadingId": 33,
                "portOfDischargeId": 29,
                "switchPortOfDischargeId": 29,
                "placeOfDelivery": "XIAMEN",
                "oceanVesselId": 33,
                "numberOfBlCopies": 4,
                "dateOfIssue": 1601713800000,
                "placeOfIssue": "rty",
                "shipmentId": 41,
                "shipmentTypeId": 2,
                "shipmentMethodId": 2,
                "id": 121,
                "shipperExporter": {
                    "nameFA": "شرکت ملی صنایع مس ایران",
                    "nameEN": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
                    "phone": "+982182138231",
                    "fax": "+982188102822",
                    "address": "NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN",
                    "type": false,
                    "status": true,
                    "commercialRole": "Seller",
                    "seller": true,
                    "buyer": false,
                    "countryId": 1,
                    "id": 2,
                    "country": {
                        "nameFa": "ایران",
                        "nameEn": "Iran (Islamic Republic of)"
                    },
                    "createdDate": 1578197254109,
                    "createdBy": "dorani_sa",
                    "lastModifiedDate": 1601451512407,
                    "lastModifiedBy": "emami",
                    "version": 7
                },
                "switchShipperExporter": {
                    "nameFA": "شرکت ملی صنایع مس ایران",
                    "nameEN": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
                    "phone": "+982182138231",
                    "fax": "+982188102822",
                    "address": "NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN",
                    "type": false,
                    "status": true,
                    "commercialRole": "Seller",
                    "seller": true,
                    "buyer": false,
                    "countryId": 1,
                    "id": 2,
                    "country": {
                        "nameFa": "ایران",
                        "nameEn": "Iran (Islamic Republic of)"
                    },
                    "createdDate": 1578197254109,
                    "createdBy": "dorani_sa",
                    "lastModifiedDate": 1601451512407,
                    "lastModifiedBy": "emami",
                    "version": 7
                },
                "notifyParty": {
                    "nameFA": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
                    "nameEN": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
                    "phone": "+86 021-68818789",
                    "fax": "+86 021-68828789",
                    "type": true,
                    "status": true,
                    "commercialRole": "Buyer",
                    "buyer": true,
                    "countryId": 2,
                    "id": 225,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China"
                    },
                    "createdDate": 1589591572259,
                    "createdBy": "db_mazloom",
                    "version": 0
                },
                "switchNotifyParty": {
                    "nameFA": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
                    "nameEN": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
                    "phone": "+86 021-68818789",
                    "fax": "+86 021-68828789",
                    "type": true,
                    "status": true,
                    "commercialRole": "Buyer",
                    "buyer": true,
                    "countryId": 2,
                    "id": 225,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China"
                    },
                    "createdDate": 1589591572259,
                    "createdBy": "db_mazloom",
                    "version": 0
                },
                "consignee": {
                    "nameFA": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
                    "nameEN": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
                    "phone": "+8601068495586",
                    "fax": "+8601068495562",
                    "address": "NO.5 SANLIHE ROAD, HAIDIAN DISTRICT, BEIJING 100044, P.R. CHINA ",
                    "type": false,
                    "nationalCode": "0",
                    "status": true,
                    "commercialRole": "Buyer",
                    "seller": false,
                    "buyer": true,
                    "countryId": 2,
                    "id": 1,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China"
                    },
                    "createdDate": 1578197169411,
                    "createdBy": "dorani_sa",
                    "lastModifiedDate": 1600688095376,
                    "lastModifiedBy": "db_zare",
                    "version": 47,
                    "defaultAccount": {
                        "contactId": 1,
                        "bankId": 2,
                        "bankAccount": "90101",
                        "bankShaba": "IR888888800000000008888888",
                        "code": "110019",
                        "bankSwift": "898888800000088",
                        "accountOwner": "88000008",
                        "status": true,
                        "isDefault": true,
                        "id": 10,
                        "bank": {
                            "bankName": "ای سی ای",
                            "countryId": 15,
                            "enBankName": "ECA",
                            "address": "NY",
                            "coreBranch": "core"
                        },
                        "createdDate": 1600245090704,
                        "createdBy": "db_zare",
                        "lastModifiedDate": 1600690356857,
                        "lastModifiedBy": "db_zare",
                        "version": 9
                    }
                },
                "switchConsignee": {
                    "nameFA": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
                    "nameEN": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
                    "phone": "+8601068495586",
                    "fax": "+8601068495562",
                    "address": "NO.5 SANLIHE ROAD, HAIDIAN DISTRICT, BEIJING 100044, P.R. CHINA ",
                    "type": false,
                    "nationalCode": "0",
                    "status": true,
                    "commercialRole": "Buyer",
                    "seller": false,
                    "buyer": true,
                    "countryId": 2,
                    "id": 1,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China"
                    },
                    "createdDate": 1578197169411,
                    "createdBy": "dorani_sa",
                    "lastModifiedDate": 1600688095376,
                    "lastModifiedBy": "db_zare",
                    "version": 47,
                    "defaultAccount": {
                        "contactId": 1,
                        "bankId": 2,
                        "bankAccount": "90101",
                        "bankShaba": "IR888888800000000008888888",
                        "code": "110019",
                        "bankSwift": "898888800000088",
                        "accountOwner": "88000008",
                        "status": true,
                        "isDefault": true,
                        "id": 10,
                        "bank": {
                            "bankName": "ای سی ای",
                            "countryId": 15,
                            "enBankName": "ECA",
                            "address": "NY",
                            "coreBranch": "core"
                        },
                        "createdDate": 1600245090704,
                        "createdBy": "db_zare",
                        "lastModifiedDate": 1600690356857,
                        "lastModifiedBy": "db_zare",
                        "version": 9
                    }
                },
                "portOfLoading": {
                    "port": "FANGCHENG",
                    "countryId": 2,
                    "id": 33,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China",
                        "id": 2,
                        "createdDate": 1599977039984,
                        "createdBy": "j.azad",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587866451161,
                    "createdBy": "db_mazloom",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "switchPortOfLoading": {
                    "port": "FANGCHENG",
                    "countryId": 2,
                    "id": 33,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China",
                        "id": 2,
                        "createdDate": 1599977039984,
                        "createdBy": "j.azad",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587866451161,
                    "createdBy": "db_mazloom",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "portOfDischarge": {
                    "port": "XIAMEN",
                    "countryId": 2,
                    "id": 29,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China",
                        "id": 2,
                        "createdDate": 1599977039984,
                        "createdBy": "j.azad",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587866198689,
                    "createdBy": "db_mazloom",
                    "lastModifiedDate": 1587866273960,
                    "lastModifiedBy": "db_mazloom",
                    "version": 1,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "switchPortOfDischarge": {
                    "port": "XIAMEN",
                    "countryId": 2,
                    "id": 29,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China",
                        "id": 2,
                        "createdDate": 1599977039984,
                        "createdBy": "j.azad",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587866198689,
                    "createdBy": "db_mazloom",
                    "lastModifiedDate": 1587866273960,
                    "lastModifiedBy": "db_mazloom",
                    "version": 1,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "oceanVessel": {
                    "name": "KOTA BAHAGIA",
                    "type": "Bulk Carrier",
                    "imo": "9593672",
                    "yearOfBuild": 2011,
                    "length": 161,
                    "beam": 27,
                    "id": 33,
                    "createdDate": 1588382394277,
                    "createdBy": "db_mazloom",
                    "lastModifiedDate": 1588382431179,
                    "lastModifiedBy": "db_mazloom",
                    "version": 1,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "containers": [],
                "shipmentType": {
                    "shipmentType": "کانتینری",
                    "id": 2,
                    "createdDate": 1587278588350,
                    "createdBy": "j.azad",
                    "lastModifiedDate": 1587278588350,
                    "lastModifiedBy": "j.azad",
                    "version": 0
                },
                "shipmentMethod": {
                    "shipmentMethod": "حمل هوایی",
                    "id": 2,
                    "createdDate": 1587278588350,
                    "createdBy": "j.azad",
                    "lastModifiedDate": 1587278588350,
                    "lastModifiedBy": "j.azad",
                    "version": 0
                },
                "createdDate": 1601721789781,
                "createdBy": "m.shahabi",
                "version": 0,
                "editable": true,
                "shipment": {
                    "contractShipmentId": 161,
                    "shipmentTypeId": 2,
                    "shipmentMethodId": 2,
                    "contactId": 225,
                    "materialId": 1,
                    "contactAgentId": 136,
                    "unitId": -32,
                    "dischargePortId": 29,
                    "amount": 678000,
                    "automationLetterNo": "35435",
                    "automationLetterDate": 1569702600000,
                    "sendDate": 1594080000000,
                    "noBLs": 4,
                    "bookingCat": "66644",
                    "arrivalDateFrom": 1601713800000,
                    "arrivalDateTo": 1601713800000,
                    "lastDeliveryLetterDate": 1601713800000,
                    "id": 41,
                    "createdDate": 1601719169394,
                    "createdBy": "m.shahabi",
                    "version": 0,
                    "editable": true,
                    "unit": {
                        "nameFA": "دلار آمریکا",
                        "nameEN": "US Dollar",
                        "categoryUnit": "Finance",
                        "symbolUnit": "$",
                        "id": -32,
                        "createdDate": 1599977041075,
                        "createdBy": "liquibase",
                        "lastModifiedDate": 1600059510446,
                        "lastModifiedBy": "karimi",
                        "version": 1,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "contact": {
                        "nameFA": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
                        "nameEN": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
                        "phone": "+86 021-68818789",
                        "fax": "+86 021-68828789",
                        "type": true,
                        "status": true,
                        "commercialRole": "Buyer",
                        "buyer": true,
                        "countryId": 2,
                        "id": 225,
                        "country": {
                            "nameFa": "چین",
                            "nameEn": "China"
                        },
                        "createdDate": 1589591572259,
                        "createdBy": "db_mazloom",
                        "version": 0
                    },
                    "dischargePort": {
                        "port": "XIAMEN",
                        "countryId": 2,
                        "id": 29,
                        "country": {
                            "nameFa": "چین",
                            "nameEn": "China",
                            "id": 2,
                            "createdDate": 1599977039984,
                            "createdBy": "j.azad",
                            "version": 0,
                            "editable": false,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "createdDate": 1587866198689,
                        "createdBy": "db_mazloom",
                        "lastModifiedDate": 1587866273960,
                        "lastModifiedBy": "db_mazloom",
                        "version": 1,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "contactAgent": {
                        "nameFA": "GRASH DARYA",
                        "nameEN": "GRASH DARYA",
                        "phone": "21-88727255",
                        "fax": "21-88726762",
                        "type": false,
                        "status": true,
                        "tradeMark": "GRASH DARYA",
                        "commercialRole": "Transporter",
                        "seller": false,
                        "transporter": true,
                        "agentBuyer": false,
                        "countryId": 1,
                        "id": 136,
                        "country": {
                            "nameFa": "ایران",
                            "nameEn": "Iran (Islamic Republic of)"
                        },
                        "createdDate": 1587875271899,
                        "createdBy": "db_mazloom",
                        "lastModifiedDate": 1588475503870,
                        "lastModifiedBy": "db_mazloom",
                        "version": 1
                    },
                    "material": {
                        "descl": "Molybdenum Oxide",
                        "descp": "اکسید مولیبدن",
                        "code": "28257000",
                        "unitId": -1,
                        "abbreviation": "MO",
                        "id": 1,
                        "unit": {
                            "nameFA": "تن",
                            "nameEN": "MT",
                            "categoryUnit": "Weight",
                            "symbolUnit": "PERCENT"
                        },
                        "createdDate": 1599977041718,
                        "createdBy": "liquibase",
                        "version": 3
                    },
                    "shipmentType": {
                        "shipmentType": "کانتینری",
                        "id": 2,
                        "createdDate": 1587278588350,
                        "createdBy": "j.azad",
                        "lastModifiedDate": 1587278588350,
                        "lastModifiedBy": "j.azad",
                        "version": 0
                    },
                    "shipmentMethod": {
                        "shipmentMethod": "حمل هوایی",
                        "id": 2,
                        "createdDate": 1587278588350,
                        "createdBy": "j.azad",
                        "lastModifiedDate": 1587278588350,
                        "lastModifiedBy": "j.azad",
                        "version": 0
                    },
                    "contractShipment": {
                        "loadPortId": 33,
                        "quantity": 152,
                        "sendDate": "2020-07-07",
                        "tolorance": 6,
                        "contractId": 166,
                        "id": 161,
                        "contract": {
                            "no": "567",
                            "date": 1601713800000,
                            "affectFrom": 1601713800000,
                            "affectUpTo": 1601713800000,
                            "content": "<br><div align=\"center\"><b>IN THE NAME OF ALLAH</b><br></div><br>THIS CONTRACT IS SIGNED &amp; STAMPED BETWEEN FOLLOWING COMPANIES AND PARTIES ARE OBLIGATED AND BOUND TO FULFILL:<br><br><b>HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.</b><br>,<br>MOBILE NUMBER: ${BUYER_MOBILE}<br>TEL: +86 021-68818789, FAX: +86 021-68828789<br><br>HEREINAFTER CALLED “BUYER”,<br><br><b>AND</b><br><br><b>NATIONAL IRANIAN COPPER INDUSTRIES CO.</b><br>NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN<br><br>TEL: +982182138231, FAX:&nbsp; +982188102822<br>HEREINAFTER CALLED “SELLER”,<br><br><br>THEREFORE, “SELLER” AGREES HEREBY TO SELL AND DELIVER AND “BUYER” AGREES TO PURCHASE, RECEIVE AND PAY FOR THE MOLYBDENUM OXIDE SPECIFIED BELOW AS PER THE FOLLOWING TERMS AND CONDITIONS:<br><b><br>ARTICLE 1 – DEFINITIONS:</b><br>1 TON = 1 METRIC TON OF 1'000 KILOGRAMS OR 2204.62 LBS<br>WORKING/BUSINESS DAY FOR BUYER = MONDAY TO THURSDAY, FRIDAY; SATURDAY AND LEGAL HOLIDAY EXCLUDED<br>WORKING/BUSINESS DAY FOR SELLER = SATURDAY TO WEDNESDAY; THURSDAY AND FRIDAY AND LEGAL HOLIDAY EXCLUDED.<br>AM/PM = ANTE MERIDIEM / POST MERIDIEM<br>THE MATERIAL = SHALL MEAN THE MATERIAL AS DEFINED IN \"ARTICLE 3 – QUALITY\"<br>FOB = FREE ON BOARD (ACCORDING TO INCOTERMS 2010).<br>USD = USD AND USC = DOLLARS AND CENTS ARE UNITED STATES CURRENCY<br>AED = UNITED ARAB EMIRATES DIRHAM<br>EURO = EURO IS THE SINGLE CURRENCY OF THE EUROPEAN ECONOMIC AND MONETARY UNION (EMU) INTRODUCED IN JANUARY 1999.<br><br><br><br><h2>MoArticle3Quantity</h2>\n\n\n\t\n\t\n\t\n\t\n\n<p dir=\"ltr\">\n\n\n\n\t\n\t\n\t\n\t\n\n</p><h1 dir=\"ltr\" class=\"ctl\">\n<font face=\"Palatino, Book Antiqua\"><font style=\"font-size: 12pt\" size=\"3\"><span lang=\"en-US\"><span style=\"font-variant: normal\"><font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><u>ARTICLE\n3 – QUALITY:</u></font></font></font></span></span></font></font></h1>\n<p dir=\"ltr\"><font face=\"Palatino, Book Antiqua\"><font style=\"font-size: 12pt\" size=\"3\"><span lang=\"en-US\"><font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\">MOLYBDENUM\nOXIDE ASSAYS ARE AS FOLLOWS:</font></font></font></span></font></font></p>\n<p dir=\"ltr\"><br>\n\n</p>\n<ul><li><p dir=\"ltr\" style=\"background: #ffffff\" align=\"justify\"><font style=\"font-size: 12pt\" size=\"3\"><span lang=\"en-US\"><font color=\"#000000\"><font style=\"font-size: 8pt\" size=\"1\">90\n\tMT</font></font><font color=\"#000000\"><font style=\"font-size: 8pt\" size=\"1\">\n\t</font></font><font color=\"#000000\"><font style=\"font-size: 8pt\" size=\"1\">±10%</font></font><font color=\"#000000\"><font style=\"font-size: 8pt\" size=\"1\">\n\tAS A WHOLE AFTER CONTRACT SETTLEMENT WITH BELOW ANALYSIS AND SIZE\n\tDETERMINATION:</font></font></span></font></p>\n</li></ul><br>\n<table dir=\"ltr\" width=\"408\" cellspacing=\"0\" cellpadding=\"7\">\n\t<colgroup><col width=\"43\">\n\n\t<col width=\"52\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t</colgroup><tbody><tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" height=\"17\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"left\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Lot\n\t\t\tName</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Mo<br>\n%</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Cu<br>\n%</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Si<br>\n%</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Pb<br>\n%</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>S<br>\n%\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>C<br>\n%\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>P<br>\n%\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" height=\"4\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>E-18\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">62.15</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">1.29</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.92</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.05</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.02</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">&lt;\n\t\t\t0.03 </span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>E-19\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">62.02</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">1.16</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.85</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.06</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.06</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.01</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">&lt;\n\t\t\t0.03 </span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>E-21\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">61.90</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">1.24</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.83</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.01</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">&lt;\n\t\t\t0.03 </span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>E-22\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">61.84</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">1.32</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.83</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.01</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">&lt;\n\t\t\t0.03 </span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n</tbody></table>\n<p dir=\"ltr\" style=\"background: #ffffff\" align=\"left\"><br>\n\n</p>\n\n<style type=\"text/css\">\n\t\tp { direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2; background: transparent }\n\t\tp.western { font-family: \"Times New Roman\", serif; font-size: 10pt; so-language: en-US }\n\t\tp.cjk { font-family: \"Times New Roman\", serif; font-size: 10pt }\n\t\tp.ctl { font-family: \"Times New Roman\", serif; font-size: 10pt; so-language: ar-SA }\n\t\ta:link { color: #0000ff; text-decoration: underline }</style><h2>MoShipment</h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>بندر مبدا</th><th style='border: 1px solid black;'>مقدار</th><th style='border: 1px solid black;'>تلرانس</th><th style='border: 1px solid black;'>تاریخ ارسال</th></tr><tr><td style='border: 1px solid black;'>null</td><td style='border: 1px solid black;'>152</td><td style='border: 1px solid black;'>6</td><td style='border: 1px solid black;'>Tue Jul 07 2020 12:00:00 GMT+0430 (Iran Daylight Time)</td></tr></table><br>",
                            "materialId": 1,
                            "contractTypeId": 1
                        },
                        "loadPort": {
                            "port": "FANGCHENG",
                            "countryId": 2
                        },
                        "createdDate": 1601719102261,
                        "createdBy": "m.shahabi",
                        "version": 0
                    },
                    "estatus": [
                        "Active"
                    ],
                    "moisture": 0
                },
                "estatus": [
                    "Active"
                ],
                "_selection_76": true,
                "_embeddedComponents_isc_ListGrid_1": null
            }
        ],
        "invoiceTypeId": 1,
        "contractId": 166,
        "shipmentId": 41,
        "inspectionWeightId": 223,
        "inspectionAssayId": 223,
        "creatorId": 2,
        "currencyId": -32,
        "toCurrencyId": null,
        "conversionRefId": null
    });

    foreignInvoiceTab.dynamicForm.baseData.redraw();
    foreignInvoiceTab.window.main.show();
};

foreignInvoiceTab.method.editForm = function () {

    foreignInvoiceTab.variable.method = "PUT";

    let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        foreignInvoiceTab.dialog.notSelected();
    else if (record.editable === false)
        foreignInvoiceTab.dialog.notEditable();
    else if (record.estatus.contains(Enums.eStatus2.DeActive))
        foreignInvoiceTab.dialog.inactiveRecord();
    else if (record.estatus.contains(Enums.eStatus2.Final))
        foreignInvoiceTab.dialog.finalRecord();
    else {

        foreignInvoiceTab.window.main.show();
        foreignInvoiceTab.method.jsonRPCManagerRequest({
            httpMethod: "GET",
            actionURL: foreignInvoiceTab.variable.foreignInvoiceBillOfLadingUrl + "spec-list",
            params: {
                criteria: {
                    operator: "and",
                    criteria: [{fieldName: "foreignInvoiceId", operator: "equals", value: record.id}]
                }
            },
            callback: function (billOfLadingResp) {

                foreignInvoiceTab.method.jsonRPCManagerRequest({
                    httpMethod: "GET",
                    actionURL: foreignInvoiceTab.variable.foreignInvoicePaymentUrl + "spec-list",
                    params: {
                        criteria: {
                            operator: "and",
                            criteria: [{fieldName: "foreignInvoiceId", operator: "equals", value: record.id}]
                        }
                    },
                    callback: function (paymentResp) {
                        foreignInvoiceTab.method.jsonRPCManagerRequest({
                            httpMethod: "GET",
                            actionURL: foreignInvoiceTab.variable.foreignInvoiceItemUrl + "spec-list",
                            params: {
                                criteria: {
                                    operator: "and",
                                    criteria: [{fieldName: "foreignInvoiceId", operator: "equals", value: record.id}]
                                }
                            },
                            callback: function (itemResp) {
                                let itemValues = JSON.parse(itemResp.httpResponseText).response.data;
                                foreignInvoiceTab.method.jsonRPCManagerRequest({
                                    httpMethod: "GET",
                                    actionURL: foreignInvoiceTab.variable.foreignInvoiceItemDetailUrl + "spec-list",
                                    params: {
                                        criteria: {
                                            operator: "and",
                                            criteria: [{
                                                fieldName: "foreignInvoiceItemId",
                                                operator: "equals",
                                                value: itemValues.map(q => q.id)
                                            }]
                                        }
                                    },
                                    callback: function (itemDetailResp) {

                                        let paymentValues = JSON.parse(paymentResp.httpResponseText).response.data;
                                        let billOfLadingValues = JSON.parse(billOfLadingResp.httpResponseText).response.data;
                                        let itemDetailValues = JSON.parse(itemDetailResp.httpResponseText).response.data;

                                        foreignInvoiceTab.variable.method = "PUT";
                                        foreignInvoiceTab.dynamicForm.valuesManager.clearValues();
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValues(record);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("date", new Date(record.date));
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("payments", paymentValues);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("billLadings", billOfLadingValues.map(q => q.billOfLanding));
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("toCurrencyId", record.conversionRef ? record.conversionRef.unitToId : null);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("contractId", record.shipment.contractShipment.contractId);

                                        let remittanceDetailIds = [];
                                        itemValues.forEach(q => remittanceDetailIds.add(q.remittanceDetailId));
                                        let itemValue = itemValues[0];
                                        let weightData = {};
                                        weightData.assayMilestone = itemValue.assayMilestone;
                                        weightData.weightMilestone = itemValue.weightMilestone;
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("weightData", weightData);
                                        if (itemValues.length <= 1) {
                                            let rcRowData = [];
                                            let calculationRowData = [];

                                            itemDetailValues.forEach(detail => {
                                                calculationRowData.add({
                                                    foreignInvoiceItemId: detail.foreignInvoiceItemId,
                                                    materialElementId: detail.materialElementId,
                                                    deductionValue: detail.deductionValue,
                                                    deductionType: detail.deductionType,
                                                    deductionUnitConversionRate: detail.deductionUnitConversionRate
                                                });
                                                rcRowData.add({
                                                    foreignInvoiceItemId: detail.foreignInvoiceItemId,
                                                    materialElementId: detail.materialElementId,
                                                    rcUnitConversionRate: detail.rcUnitConversionRate
                                                });
                                            });

                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("calculationData", calculationRowData);
                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("rcDeductionData", rcRowData);
                                        }
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("remittanceDetailId", remittanceDetailIds);
                                        foreignInvoiceTab.button.selectBillLading.enable();
                                        foreignInvoiceTab.dynamicForm.baseData.getFields().forEach(field => {

                                            if (field.name === "date" || field.name === "invoiceTypeId")
                                                field.disable();
                                            else
                                                field.enable();
                                        });

                                        foreignInvoiceTab.window.main.show();
                                    }
                                });
                            }
                        });
                    }
                });
            }
        });
    }
};

foreignInvoiceTab.method.addTab = function (pane, title) {
    foreignInvoiceTab.tab.invoice.addTab({
        pane: pane,
        title: title,
        paneMargin: 5
    });
};

//*************************************************** REST *************************************************************

// isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
//
//     httpMethod: "GET",
//     actionURL: "${contextPath}/api/g-contract/....",
//     callback: function (resp) {
//
//         if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
//
//             foreignInvoiceTab.variable.contractDetailData = JSON.parse(resp.data)
//         } else
//             isc.say(resp.data);
//     }
// }));

// MOCK
foreignInvoiceTab.variable.contractDetailData.moasValue = 0;
foreignInvoiceTab.variable.contractDetailData.basePriceReference = "LME";
foreignInvoiceTab.variable.contractDetailData.tc = 123456;
foreignInvoiceTab.variable.contractDetailData.rc = [{
    elementId: 1,
    elementName: "CU",
    price: 12.3,
    weightUnit: {id: -1, nameEN: "Pound", categoryUnit: "Weight"},
    financeUnit: {id: -32, nameEN: "Dollar", categoryUnit: "Finance"}
}, {
    elementId: 2,
    elementName: "AG",
    price: 11.3,
    weightUnit: {id: -1, nameEN: "Pound", categoryUnit: "Weight"},
    financeUnit: {id: -32, nameEN: "Dollar", categoryUnit: "Finance"}
}, {
    elementId: 3,
    elementName: "AU",
    price: 12.4,
    weightUnit: {id: -1, nameEN: "Pound", categoryUnit: "Weight"},
    financeUnit: {id: -32, nameEN: "Dollar", categoryUnit: "Finance"}
}, {
    elementId: 4,
    elementName: "MO",
    price: 14.4,
    weightUnit: {id: -1, nameEN: "Pound", categoryUnit: "Weight"},
    financeUnit: {id: -32, nameEN: "Dollar", categoryUnit: "Finance"}
}];
