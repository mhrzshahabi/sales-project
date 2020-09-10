var foreignInvoiceTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

foreignInvoiceTab.variable.contractDetailData = {};
foreignInvoiceTab.variable.invoiceForm = new nicico.FormUtil();
foreignInvoiceTab.variable.selectBillLadingForm = new nicico.FindFormUtil();

foreignInvoiceTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/";
foreignInvoiceTab.variable.remittanceDetailUrl = "${contextPath}" + "/api/remittance-detail/";
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
        name: "contract.no",
        title: "<spring:message code='foreign-invoice.form.contract'/>"
    },
    {
        width: "100%",
        showHover: true,
        name: "accountingId",
        title: "<spring:message code='foreign-invoice.form.accountingId'/>"
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
            fieldName: "parentId",
            operator: "isNull"
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {
                    name: "no",
                    title: "<spring:message code='foreign-invoice.form.contract'/>"
                },
                {name: "description", title: "<spring:message code='global.description'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.contractUrl + "spec-list"
        }),
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

            form.setValue("remittanceDetailId", null);
            foreignInvoiceTab.dynamicForm.valuesManager.setValue("billLadings", null);

            let selectedRecord = item.getSelectedRecord();
            if (!selectedRecord) {

                form.getItem("remittanceDetailId").disable();
                form.getItem("remittanceDetailId").setOptionCriteria(null);

                foreignInvoiceTab.button.selectBillLading.disable();
                foreignInvoiceTab.button.selectBillLading.criteria = null;

                return;
            }

            form.getItem("remittanceDetailId").enable();
            form.getItem("remittanceDetailId").setOptionCriteria({
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{
                    fieldName: "remittance.shipmentId",
                    operator: "equals",
                    value: selectedRecord.id
                }]
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
                            // {
                            //     fieldName: "currencyDate",
                            //     operator: "lessOrEqual",
                            //     value: toDate.toString()
                            // },
                            // {
                            //     fieldName: "currencyDate",
                            //     operator: "greaterOrEqual",
                            //     value: fromDate.toString()
                            // },
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
        multiple: true,
        width: "100%",
        type: "integer",
        name: "remittanceDetailId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "inventoryLabel",
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "inventory.label", title: "<spring:message code='inspectionReport.InventoryLabel'/>"},
            {name: "weight", title: "<spring:message code='Tozin.vazn'/>"},
            {name: "amount", title: "<spring:message code='global.amount'/>"},
            {name: "unit.nameEN", title: "<spring:message code='global.unit'/>"},
            {name: "description", title: "<spring:message code='global.description'/>"}
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "inventory.label", title: "<spring:message code='inspectionReport.InventoryLabel'/>"},
                {name: "weight", title: "<spring:message code='Tozin.vazn'/>"},
                {name: "amount", title: "<spring:message code='global.amount'/>"},
                {name: "unit.nameEN", title: "<spring:message code='global.unit'/>"},
                {name: "description", title: "<spring:message code='global.description'/>"}
            ],
            fetchDataURL: foreignInvoiceTab.variable.remittanceDetailUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.remittance-detail'/>",
        wrapTitle: false
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
    titleAlign: "left",
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
            'remittanceDetails',
            foreignInvoiceTab.dynamicForm.baseData.getField('remittanceDetailId').getSelectedRecords());

        foreignInvoiceTab.method.addTab(
            isc.InvoiceBaseInfo.create({
                invoiceNo: foreignInvoiceTab.dynamicForm.valuesManager.getValue('no'),
                invoiceDate: foreignInvoiceTab.dynamicForm.valuesManager.getValue('date'),
                contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract'),
                billLadings: foreignInvoiceTab.dynamicForm.valuesManager.getValue('billLadings'),
                invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue('invoiceType'),
            }), '<spring:message code="foreign-invoice.form.tab.contract-info"/>');

        // debugger;
        if (foreignInvoiceTab.dynamicForm.valuesManager.getValue('remittanceDetailId').length > 1) {
            foreignInvoiceTab.method.addTab(isc.InvoiceCalculation2.create({
                inventories: [foreignInvoiceTab.dynamicForm.valuesManager.getValue('remittanceDetailId')],
                shipment : foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract'),
                assayMilestone: foreignInvoiceTab.dynamicForm.valuesManager.getValue("assayMilestone"),
                weightMilestone: foreignInvoiceTab.dynamicForm.valuesManager.getValue("weightMilestone"),
                currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                contractDetailData: foreignInvoiceTab.variable.contractDetailData,
            }), '<spring:message code="foreign-invoice.form.tab.calculation"/>');

            // foreignInvoiceTab.method.addTab(
            //     isc.InvoicePayment.create({
            //         currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
            //         contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
            //         inventories: [{id: 1}, {id: 2}]
            //     }), '<spring:message code="foreign-invoice.form.tab.payment"/>');
        } else {
            let invoiceBaseValuesComponent = isc.InvoiceBaseValues.create({
                currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
                contractDetailData: foreignInvoiceTab.variable.contractDetailData,
                shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue("invoiceType"),
                remittanceDetails: foreignInvoiceTab.dynamicForm.valuesManager.getValue("remittanceDetails"),
                assayMilestone: foreignInvoiceTab.dynamicForm.valuesManager.getValue("assayMilestone"),
                weightMilestone: foreignInvoiceTab.dynamicForm.valuesManager.getValue("weightMilestone")
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
                            currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                            shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                            contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
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

    // isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
    //         actionURL: "${contextPath}/api/foreign-invoice",
    //         httpMethod: foreignInvoiceTab.variable.method,
    //         data: JSON.stringify(data),
    //         params: null,
    //         callback: function (resp) {
    //             if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
    //                 foreignInvoiceTab.window.main.close();i
    //                 foreignInvoiceTab.method.refreshData();
    //                 isc.say("<spring:message code='global.form.request.successful'/>");
    //             } else
    //                 isc.say(resp.data);
    //         }
    //     })
    // );

};

foreignInvoiceTab.variable.invoiceForm.populateData = function (bodyWidget) {

    let invoiceBaseValuesComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceBaseValues.Class).first().pane;
    let invoiceBasePriceComponent = invoiceBaseValuesComponent.invoiceBasePriceComponent;
    let invoiceBaseAssayComponent = invoiceBaseValuesComponent.invoiceBaseAssayComponent;
    let invoiceBaseWeightComponent = invoiceBaseValuesComponent.invoiceBaseWeightComponent;

    let invoiceCalculationComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceCalculation.Class).first();
    if (!invoiceCalculationComponent) return null;
    let invoiceDeductionComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceDeduction.Class).first();
    if (!invoiceDeductionComponent) return null;
    let invoicePaymentComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoicePayment.Class).first();
    if (!invoicePaymentComponent) return null;

    let data = foreignInvoiceTab.dynamicForm.valuesManager.getValues();
    let remittanceDetails = foreignInvoiceTab.dynamicForm.valuesManager.getValue('remittanceDetails');

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
    data.foreignInvoicePayments = paymentComponentValues.shipmentCostInvoices;

    foreignInvoiceTab.method.getForeignInvoiceItemDetails = function () {
        let itemDetails = [];
        invoiceBaseAssayComponent.getValues().forEach(q => {
            itemDetails.add({
                materialElementId: q.materialElementId,
                assay: q.value,
                basePrice: invoiceBasePriceComponent.getValues().filter(bp => bp.elementId === q.elementId).first().value,
                rcPrice: invoiceDeductionComponent.pane.getValues().slice(1).filter(trc => trc.materialElementId === q.materialElementId).first().rcPrice,
                rcBasePrice: invoiceDeductionComponent.pane.getValues().slice(1).filter(trc => trc.materialElementId === q.materialElementId).first().rcBasePrice.getValues().value,
                rcUnitConversionRate: invoiceDeductionComponent.pane.getValues().slice(1).filter(trc => trc.materialElementId === q.materialElementId).first().rcUnitConversionRate,
                deductionType: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.elementId).first().deductionType,
                deductionValue: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.elementId).first().deductionValue,
                deductionUnitConversionRate: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.elementId).first().deductionUnitConversionRate,
                deductionPrice: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.elementId).first().deductionPrice
            })
        });
        return itemDetails;
    };

    foreignInvoiceTab.method.getForeignInvoiceItems = function () {
        let items = [];

        remittanceDetails.forEach(current => {
            items.add({
                weightGW: invoiceBaseWeightComponent.getValues().weightGW.getValues().value,
                weightND: invoiceBaseWeightComponent.getValues().weightND.getValues().value,
                treatCost: invoiceDeductionComponent.pane.getValues().filter(q => q.name === "TC").first().value,
                remittanceDetailId: current.id,
                assayMilestone: invoiceBaseAssayComponent.getValues()[0].assayMilestone,
                weightMilestone: invoiceBaseWeightComponent.getValues().weightMilestone,
                foreignInvoiceItemDetails: foreignInvoiceTab.method.getForeignInvoiceItemDetails()
            });
        });
        return items;
    };

    data.foreignInvoiceItems = foreignInvoiceTab.method.getForeignInvoiceItems();

    delete data.contract;
    delete data.conversionRef;
    delete data.currency;
    delete data.billLadings;
    delete data.invoiceType;
    delete data.shipment;
    delete data.toCurrencyId;
    delete data.remittanceDetails;
    delete data.remittanceDetailId;

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

    // foreignInvoiceTab.dynamicForm.valuesManager.setValues({
    //     "date": "2020-09-07T07:30:00.000Z",
    //     "billLadings": [
    //         {
    //             "documentNo": "9999999999999",
    //             "switchDocumentNo": "234234234",
    //             "shipperExporterId": 24,
    //             "switchShipperExporterId": 24,
    //             "notifyPartyId": 1,
    //             "switchNotifyPartyId": 1,
    //             "consigneeId": 5,
    //             "switchConsigneeId": 5,
    //             "portOfLoadingId": 3,
    //             "switchPortOfLoadingId": 3,
    //             "portOfDischargeId": 31,
    //             "switchPortOfDischargeId": 31,
    //             "placeOfDelivery": "24234234",
    //             "oceanVesselId": 86,
    //             "numberOfBlCopies": 1,
    //             "dateOfIssue": 1599463800000,
    //             "placeOfIssue": "234234234234",
    //             "description": "234234234234",
    //             "totalNet": 1,
    //             "totalGross": 1,
    //             "totalBundles": 1,
    //             "id": 2,
    //             "shipperExporter": {
    //                 "nameFA": "ژیائوفنگ",
    //                 "nameEN": "zhyaofeng",
    //                 "phone": "8690111111111",
    //                 "type": false,
    //                 "bankAccount": "686868",
    //                 "bankShaba": "IR567575775777556675677777",
    //                 "bankSwift": "567567567",
    //                 "status": true,
    //                 "tradeMark": "ZH-COPPER",
    //                 "commercialRole": "Agent Seller,Agent Buyer",
    //                 "seller": false,
    //                 "buyer": false,
    //                 "transporter": false,
    //                 "shipper": false,
    //                 "inspector": false,
    //                 "insurancer": false,
    //                 "agentBuyer": true,
    //                 "agentSeller": true,
    //                 "ceo": "linchan",
    //                 "countryId": 2,
    //                 "id": 24,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina"
    //                 },
    //                 "createdDate": 1596256929444,
    //                 "createdBy": "devadmin",
    //                 "lastModifiedDate": 1598334787441,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 22
    //             },
    //             "switchShipperExporter": {
    //                 "nameFA": "ژیائوفنگ",
    //                 "nameEN": "zhyaofeng",
    //                 "phone": "8690111111111",
    //                 "type": false,
    //                 "bankAccount": "686868",
    //                 "bankShaba": "IR567575775777556675677777",
    //                 "bankSwift": "567567567",
    //                 "status": true,
    //                 "tradeMark": "ZH-COPPER",
    //                 "commercialRole": "Agent Seller,Agent Buyer",
    //                 "seller": false,
    //                 "buyer": false,
    //                 "transporter": false,
    //                 "shipper": false,
    //                 "inspector": false,
    //                 "insurancer": false,
    //                 "agentBuyer": true,
    //                 "agentSeller": true,
    //                 "ceo": "linchan",
    //                 "countryId": 2,
    //                 "id": 24,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina"
    //                 },
    //                 "createdDate": 1596256929444,
    //                 "createdBy": "devadmin",
    //                 "lastModifiedDate": 1598334787441,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 22
    //             },
    //             "notifyParty": {
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
    //                     "nameEn": "FkChina"
    //                 },
    //                 "createdDate": 1578197169411,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1595828067629,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 6
    //             },
    //             "switchNotifyParty": {
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
    //                     "nameEn": "FkChina"
    //                 },
    //                 "createdDate": 1578197169411,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1595828067629,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 6
    //             },
    //             "consignee": {
    //                 "nameFA": "بیمه ما",
    //                 "nameEN": "MA INSURANCE",
    //                 "phone": "8690",
    //                 "address": "تهران میدان ونک ابتدای خیابان ونک پلاک 9",
    //                 "webSite": "WWW.BIMEHMA.COM",
    //                 "type": true,
    //                 "status": true,
    //                 "commercialRole": "Insurancer",
    //                 "insurancer": true,
    //                 "countryId": 1,
    //                 "postalCode": "+234324",
    //                 "id": 5,
    //                 "country": {
    //                     "nameFa": "ایران",
    //                     "nameEn": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1579059013188,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1595919615596,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 2
    //             },
    //             "switchConsignee": {
    //                 "nameFA": "بیمه ما",
    //                 "nameEN": "MA INSURANCE",
    //                 "phone": "8690",
    //                 "address": "تهران میدان ونک ابتدای خیابان ونک پلاک 9",
    //                 "webSite": "WWW.BIMEHMA.COM",
    //                 "type": true,
    //                 "status": true,
    //                 "commercialRole": "Insurancer",
    //                 "insurancer": true,
    //                 "countryId": 1,
    //                 "postalCode": "+234324",
    //                 "id": 5,
    //                 "country": {
    //                     "nameFa": "ایران",
    //                     "nameEn": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1579059013188,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1595919615596,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 2
    //             },
    //             "portOfLoading": {
    //                 "port": "SHANGHAI",
    //                 "countryId": 2,
    //                 "id": 3,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina",
    //                     "id": 2,
    //                     "createdDate": 1595302644624,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1598846835554,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 1,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587732958179,
    //                 "createdBy": "db_mazloom",
    //                 "lastModifiedDate": 1587865761876,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 3,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfLoading": {
    //                 "port": "SHANGHAI",
    //                 "countryId": 2,
    //                 "id": 3,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina",
    //                     "id": 2,
    //                     "createdDate": 1595302644624,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1598846835554,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 1,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587732958179,
    //                 "createdBy": "db_mazloom",
    //                 "lastModifiedDate": 1587865761876,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 3,
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
    //                     "createdDate": 1595302644625,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": true,
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
    //                     "createdDate": 1595302644625,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": true,
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
    //                 "name": "ADMIRAL GLOBE",
    //                 "type": "Bulk Carrier",
    //                 "imo": "9290945",
    //                 "yearOfBuild": 2004,
    //                 "length": 276,
    //                 "beam": 40,
    //                 "id": 86,
    //                 "createdDate": 1588389673493,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "containers": [
    //                 {
    //                     "billOfLandingId": 2,
    //                     "containerType": "a",
    //                     "containerNo": "s",
    //                     "sealNo": "d",
    //                     "quantity": 123,
    //                     "quantityType": "123",
    //                     "weight": 123,
    //                     "unitId": -11,
    //                     "id": 2,
    //                     "unit": {
    //                         "nameFA": "کیلوگرم",
    //                         "nameEN": "kilogramme",
    //                         "categoryUnit": "Weight",
    //                         "id": -11,
    //                         "createdDate": 1593755140056,
    //                         "createdBy": "j.azad",
    //                         "lastModifiedDate": 1594440292826,
    //                         "lastModifiedBy": "j.azad",
    //                         "version": 2,
    //                         "editable": false,
    //                         "estatus": [
    //                             "Active"
    //                         ]
    //                     },
    //                     "createdDate": 1596366825909,
    //                     "createdBy": "db_saeb",
    //                     "lastModifiedDate": 1596367028720,
    //                     "lastModifiedBy": "db_saeb",
    //                     "version": 1,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 }
    //             ],
    //             "createdDate": 1596272394781,
    //             "createdBy": "db_saeb",
    //             "lastModifiedDate": 1599451551217,
    //             "lastModifiedBy": "devadmin",
    //             "version": 7,
    //             "editable": true,
    //             "estatus": [
    //                 "Active"
    //             ],
    //             "_selection_66": true,
    //             "_embeddedComponents_isc_ListGrid_1": null
    //         },
    //         {
    //             "documentNo": "asdvbcvbcxvbcvbx",
    //             "switchDocumentNo": "asdvbcvbcxvbcvbx",
    //             "shipperExporterId": 41,
    //             "switchShipperExporterId": 41,
    //             "notifyPartyId": 2058,
    //             "switchNotifyPartyId": 2058,
    //             "consigneeId": 24,
    //             "switchConsigneeId": 24,
    //             "portOfLoadingId": 21,
    //             "switchPortOfLoadingId": 21,
    //             "portOfDischargeId": 1,
    //             "switchPortOfDischargeId": 1,
    //             "placeOfDelivery": "HUANGPU",
    //             "oceanVesselId": 34,
    //             "numberOfBlCopies": 34,
    //             "dateOfIssue": 1599377400000,
    //             "placeOfIssue": "345",
    //             "description": "345345dffdgdf",
    //             "totalNet": 345,
    //             "totalGross": 345,
    //             "totalBundles": 345,
    //             "id": 101,
    //             "shipperExporter": {
    //                 "nameFA": "SUNGILL RESOURCES LTD",
    //                 "nameEN": "SUNGILL RESOURCES LTD",
    //                 "phone": "+852 2575 7591",
    //                 "fax": "+852 3702 0210",
    //                 "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 41,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina"
    //                 },
    //                 "createdDate": 1579683563975,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1579935876622,
    //                 "lastModifiedBy": "dorani_sa",
    //                 "version": 1
    //             },
    //             "switchShipperExporter": {
    //                 "nameFA": "SUNGILL RESOURCES LTD",
    //                 "nameEN": "SUNGILL RESOURCES LTD",
    //                 "phone": "+852 2575 7591",
    //                 "fax": "+852 3702 0210",
    //                 "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 41,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina"
    //                 },
    //                 "createdDate": 1579683563975,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1579935876622,
    //                 "lastModifiedBy": "dorani_sa",
    //                 "version": 1
    //             },
    //             "notifyParty": {
    //                 "nameFA": "لاکی هرایزن لیمیتد",
    //                 "nameEN": "LUCKY HORIZEN LIMITED",
    //                 "phone": "869011111111134",
    //                 "address": "RM 19C LOCKHART CTR 301-307",
    //                 "type": true,
    //                 "bankAccount": "234",
    //                 "bankShaba": "IR343434343434343444433333",
    //                 "bankSwift": "234",
    //                 "status": true,
    //                 "commercialRole": "Seller",
    //                 "seller": true,
    //                 "buyer": false,
    //                 "countryId": 1,
    //                 "id": 2058,
    //                 "country": {
    //                     "nameFa": "ایران",
    //                     "nameEn": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1597293065534,
    //                 "createdBy": "r.mazloom",
    //                 "lastModifiedDate": 1599367644514,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 6
    //             },
    //             "switchNotifyParty": {
    //                 "nameFA": "لاکی هرایزن لیمیتد",
    //                 "nameEN": "LUCKY HORIZEN LIMITED",
    //                 "phone": "869011111111134",
    //                 "address": "RM 19C LOCKHART CTR 301-307",
    //                 "type": true,
    //                 "bankAccount": "234",
    //                 "bankShaba": "IR343434343434343444433333",
    //                 "bankSwift": "234",
    //                 "status": true,
    //                 "commercialRole": "Seller",
    //                 "seller": true,
    //                 "buyer": false,
    //                 "countryId": 1,
    //                 "id": 2058,
    //                 "country": {
    //                     "nameFa": "ایران",
    //                     "nameEn": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1597293065534,
    //                 "createdBy": "r.mazloom",
    //                 "lastModifiedDate": 1599367644514,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 6
    //             },
    //             "consignee": {
    //                 "nameFA": "ژیائوفنگ",
    //                 "nameEN": "zhyaofeng",
    //                 "phone": "8690111111111",
    //                 "type": false,
    //                 "bankAccount": "686868",
    //                 "bankShaba": "IR567575775777556675677777",
    //                 "bankSwift": "567567567",
    //                 "status": true,
    //                 "tradeMark": "ZH-COPPER",
    //                 "commercialRole": "Agent Seller,Agent Buyer",
    //                 "seller": false,
    //                 "buyer": false,
    //                 "transporter": false,
    //                 "shipper": false,
    //                 "inspector": false,
    //                 "insurancer": false,
    //                 "agentBuyer": true,
    //                 "agentSeller": true,
    //                 "ceo": "linchan",
    //                 "countryId": 2,
    //                 "id": 24,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina"
    //                 },
    //                 "createdDate": 1596256929444,
    //                 "createdBy": "devadmin",
    //                 "lastModifiedDate": 1598334787441,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 22
    //             },
    //             "switchConsignee": {
    //                 "nameFA": "ژیائوفنگ",
    //                 "nameEN": "zhyaofeng",
    //                 "phone": "8690111111111",
    //                 "type": false,
    //                 "bankAccount": "686868",
    //                 "bankShaba": "IR567575775777556675677777",
    //                 "bankSwift": "567567567",
    //                 "status": true,
    //                 "tradeMark": "ZH-COPPER",
    //                 "commercialRole": "Agent Seller,Agent Buyer",
    //                 "seller": false,
    //                 "buyer": false,
    //                 "transporter": false,
    //                 "shipper": false,
    //                 "inspector": false,
    //                 "insurancer": false,
    //                 "agentBuyer": true,
    //                 "agentSeller": true,
    //                 "ceo": "linchan",
    //                 "countryId": 2,
    //                 "id": 24,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina"
    //                 },
    //                 "createdDate": 1596256929444,
    //                 "createdBy": "devadmin",
    //                 "lastModifiedDate": 1598334787441,
    //                 "lastModifiedBy": "devadmin",
    //                 "version": 22
    //             },
    //             "portOfLoading": {
    //                 "port": "JEBEL ALI",
    //                 "countryId": 3,
    //                 "id": 21,
    //                 "country": {
    //                     "nameFa": "افغانستان",
    //                     "nameEn": "Afghanistan",
    //                     "id": 3,
    //                     "createdDate": 1595302644625,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1578800749910,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1587865683350,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 2,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfLoading": {
    //                 "port": "JEBEL ALI",
    //                 "countryId": 3,
    //                 "id": 21,
    //                 "country": {
    //                     "nameFa": "افغانستان",
    //                     "nameEn": "Afghanistan",
    //                     "id": 3,
    //                     "createdDate": 1595302644625,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1578800749910,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1587865683350,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 2,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "portOfDischarge": {
    //                 "port": "HUANGPU",
    //                 "countryId": 2,
    //                 "id": 1,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina",
    //                     "id": 2,
    //                     "createdDate": 1595302644624,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1598846835554,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 1,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1578198734058,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1587865832220,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 2,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfDischarge": {
    //                 "port": "HUANGPU",
    //                 "countryId": 2,
    //                 "id": 1,
    //                 "country": {
    //                     "nameFa": "چین",
    //                     "nameEn": "FkChina",
    //                     "id": 2,
    //                     "createdDate": 1595302644624,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1598846835554,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 1,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1578198734058,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1587865832220,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 2,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "oceanVessel": {
    //                 "name": "HHL RIO DE JANEIRO",
    //                 "type": "Bulk Carrier",
    //                 "imo": "9424546",
    //                 "yearOfBuild": 2009,
    //                 "length": 168,
    //                 "beam": 25,
    //                 "id": 34,
    //                 "createdDate": 1588382634370,
    //                 "createdBy": "db_mazloom",
    //                 "lastModifiedDate": 1588382647517,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 1,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "containers": [],
    //             "createdDate": 1599395173365,
    //             "createdBy": "db_saeb",
    //             "version": 0,
    //             "editable": true,
    //             "estatus": [
    //                 "Active"
    //             ],
    //             "_selection_66": true,
    //             "_embeddedComponents_isc_ListGrid_1": null
    //         }
    //     ],
    //     "invoiceTypeId": 1,
    //     "contractId": 294,
    //     "shipmentId": 73,
    //     "remittanceDetailId": [
    //         42
    //     ],
    //     "creatorId": 4,
    //     "currencyId": -32,
    //     "toCurrencyId": -33,
    //     "conversionRefId": 124,
    //     "description": "deded"
    // });

    foreignInvoiceTab.dynamicForm.baseData.redraw();
    foreignInvoiceTab.window.main.show();
};

foreignInvoiceTab.method.editForm = function () {

    foreignInvoiceTab.dynamicForm.valuesManager.setValues({
        "no": "996/CONC-5675643/031000",
        "date": "2020-09-01T07:30:00.000Z",
        "unitPrice": 29530.68,
        "unitCost": 1162.46,
        "sumFIPrice": 226945.75,
        "sumPIPrice": 6776,
        "sumPrice": 220169.75,
        "conversionDate": 1598745600000,
        "conversionRate": 12,
        "conversionSumPrice": 2642037,
        "conversionSumPriceText": "two million six hundred and forty two thousand thirty seven",
        "description": "desc",
        "conversionRefId": 124,
        "currencyId": -32,
        "buyerId": 41,
        "invoiceTypeId": 1,
        "shipmentId": 73,
        "creatorId": 3,
        "id": 52,
        "conversionRef": {
            "currencyDate": "2020-08-30",
            "unitFromId": -32,
            "unitToId": -33,
            "reference": "ECB",
            "currencyRateValue": 12,
            "currencyTypeFrom": "AZAD",
            "id": 124,
            "createdDate": 1597555991765,
            "unitFrom": {
                "nameFA": "دلار",
                "nameEN": "Dollar",
                "categoryUnit": "Finance"
            },
            "unitTo": {
                "nameFA": "یورو",
                "nameEN": "Euro",
                "categoryUnit": "Finance"
            },
            "createdBy": "m.shahabi",
            "version": 0,
            "editable": true,
            "estatus": [
                "Active"
            ]
        },
        "currency": {
            "nameFA": "دلار",
            "nameEN": "Dollar",
            "categoryUnit": "Finance",
            "id": -32,
            "createdDate": 1595738609668,
            "createdBy": "liquibase",
            "version": 0,
            "editable": false,
            "estatus": [
                "Active"
            ]
        },
        "buyer": {
            "nameFA": "SUNGILL RESOURCES LTD",
            "nameEN": "SUNGILL RESOURCES LTD",
            "phone": "+852 2575 7591",
            "fax": "+852 3702 0210",
            "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
            "type": false,
            "status": true,
            "commercialRole": "Buyer",
            "buyer": true,
            "countryId": 2,
            "id": 41,
            "country": {
                "nameFa": "چین",
                "nameEn": "FkChina"
            },
            "createdDate": 1579683563975,
            "createdBy": "dorani_sa",
            "lastModifiedDate": 1579935876622,
            "lastModifiedBy": "dorani_sa",
            "version": 1
        },
        "invoiceType": {
            "title": "FINAL",
            "id": 1,
            "createdDate": 1597536539050,
            "createdBy": "liquibase",
            "version": 0
        },
        "shipment": {
            "contractShipmentId": 21,
            "shipmentTypeId": 1,
            "shipmentMethodId": 2,
            "contactId": 41,
            "materialId": 3,
            "contactAgentId": 221,
            "vesselId": 33,
            "unitId": -11,
            "dischargePortId": 1,
            "amount": 44455,
            "automationLetterNo": "222",
            "automationLetterDate": 1598988600000,
            "sendDate": 1596758400000,
            "noBLs": 4,
            "bookingCat": "222333",
            "vgm": 0,
            "arrivalDateFrom": 936084600000,
            "arrivalDateTo": 1819697400000,
            "id": 73,
            "createdDate": 1597812976018,
            "createdBy": "devadmin",
            "lastModifiedDate": 1599278424279,
            "lastModifiedBy": "devadmin",
            "version": 9,
            "editable": true,
            "unit": {
                "nameFA": "کیلوگرم",
                "nameEN": "kilogramme",
                "categoryUnit": "Weight",
                "id": -11,
                "createdDate": 1593755140056,
                "createdBy": "j.azad",
                "lastModifiedDate": 1594440292826,
                "lastModifiedBy": "j.azad",
                "version": 2,
                "editable": false,
                "estatus": [
                    "Active"
                ]
            },
            "vessel": {
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
            "contact": {
                "nameFA": "SUNGILL RESOURCES LTD",
                "nameEN": "SUNGILL RESOURCES LTD",
                "phone": "+852 2575 7591",
                "fax": "+852 3702 0210",
                "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                "type": false,
                "status": true,
                "commercialRole": "Buyer",
                "buyer": true,
                "countryId": 2,
                "id": 41,
                "country": {
                    "nameFa": "چین",
                    "nameEn": "FkChina"
                },
                "createdDate": 1579683563975,
                "createdBy": "dorani_sa",
                "lastModifiedDate": 1579935876622,
                "lastModifiedBy": "dorani_sa",
                "version": 1
            },
            "dischargePort": {
                "port": "HUANGPU",
                "countryId": 2,
                "id": 1,
                "country": {
                    "nameFa": "چین",
                    "nameEn": "FkChina",
                    "id": 2,
                    "createdDate": 1595302644624,
                    "createdBy": "j.azad",
                    "lastModifiedDate": 1598846835554,
                    "lastModifiedBy": "db_zare",
                    "version": 1,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "createdDate": 1578198734058,
                "createdBy": "dorani_sa",
                "lastModifiedDate": 1587865832220,
                "lastModifiedBy": "db_mazloom",
                "version": 2,
                "editable": true,
                "estatus": [
                    "Active"
                ]
            },
            "contactAgent": {
                "nameFA": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                "nameEN": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                "phone": "+86-21-54981420",
                "fax": "+86-358-5489141",
                "type": false,
                "status": true,
                "tradeMark": "SHANGHAI HONGTE ",
                "commercialRole": "Buyer",
                "seller": false,
                "buyer": true,
                "countryId": 2,
                "id": 221,
                "country": {
                    "nameFa": "چین",
                    "nameEn": "FkChina"
                },
                "createdDate": 1589587421596,
                "createdBy": "db_mazloom",
                "version": 0
            },
            "material": {
                "descl": "Copper Concentrate",
                "descp": "مس کنسانتره",
                "code": "26030090",
                "abbreviation": "CONC",
                "id": 3,
                "createdDate": 1595302642815,
                "createdBy": "liquibase",
                "version": 6
            },
            "shipmentType": {
                "shipmentType": "فله",
                "id": 1,
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
                "loadPortId": 21,
                "quantity": 6000,
                "sendDate": "2020-08-02",
                "tolorance": 790,
                "contractId": 294,
                "id": 21,
                "contract": {
                    "no": "5675643",
                    "date": 1598081400000,
                    "affectFrom": 1598081400000,
                    "affectUpTo": 1598081400000,
                    "content": "<h1>article1</h1>SAMPLE SAMPLE 10 SAMPLE<br><font size=\"7\"><u><i><b>SAMPLE<br></b></i></u></font><div><font size=\"7\"><u><i><b>SAMPLE</b></i></u></font></div><div><font size=\"7\"><u><i><b><br></b></i></u></font></div>",
                    "materialId": 3,
                    "contractTypeId": 1
                },
                "loadPort": {
                    "port": "JEBEL ALI",
                    "countryId": 3
                },
                "createdDate": 1595402676281,
                "createdBy": "m.shahabi",
                "version": 0
            },
            "estatus": [
                "Active"
            ],
            "moisture": 0
        },
        "creator": {
            "fullName": "tertert",
            "jobTitle": "ertertert",
            "id": 3,
            "createdDate": 1595330408784,
            "createdBy": "devadmin",
            "version": 0
        },
        "createdDate": 1598971887027,
        "createdBy": "m.shahabi",
        "lastModifiedDate": 1599543162651,
        "lastModifiedBy": "m.shahabi",
        "version": 2,
        "editable": true,
        "estatus": [
            "Active"
        ],
        "_selection_198": true,
        "_embeddedComponents_isc_ListGrid_0": null,
        "rcDeductionData": [
            {
                "foreignInvoiceItemId": 2,
                "materialElementId": 1,
                "rcUnitConversionRate": 1
            },
            {
                "foreignInvoiceItemId": 2,
                "materialElementId": 2,
                "rcUnitConversionRate": 2
            },
            {
                "foreignInvoiceItemId": 2,
                "materialElementId": 3,
                "rcUnitConversionRate": 3
            }
        ],
        "calculationData": [
            {
                "foreignInvoiceItemId": 2,
                "materialElementId": 1,
                "deductionValue": 3,
                "deductionType": "Unit",
                "deductionUnitConversionRate": 1
            },
            {
                "foreignInvoiceItemId": 2,
                "materialElementId": 2,
                "deductionValue": 4,
                "deductionType": "Unit",
                "deductionUnitConversionRate": 1
            },
            {
                "foreignInvoiceItemId": 2,
                "materialElementId": 3,
                "deductionValue": 5,
                "deductionType": "Unit",
                "deductionUnitConversionRate": 1
            }
        ],
        "payments": [
            {
                "docNo": "20208/CONC-564/081103",
                "docDate": 1596585600000,
                "docSumValue": 79024,
                "docConversionDate": 1597104000000,
                "docConversionRate": 44,
                "docConversionPrice": 3753205.72,
                "portion": 20,
                "conversionRefId": 75,
                "foreignInvoiceId": 52,
                "id": 12,
                "conversionRef": {
                    "currencyDate": "2020-08-02",
                    "unitFromId": -32,
                    "unitToId": 999,
                    "reference": "ECB",
                    "currencyRateValue": 44,
                    "currencyTypeFrom": "AZAD",
                    "currencyTypeTo": "AZAD",
                    "id": 75,
                    "createdDate": 1596951921630,
                    "unitFrom": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance"
                    },
                    "unitTo": {
                        "nameFA": "نا مشخص",
                        "nameEN": "نا مشخص",
                        "categoryUnit": "Weight"
                    },
                    "createdBy": "devadmin",
                    "lastModifiedDate": 1596952705594,
                    "lastModifiedBy": "devadmin",
                    "version": 2,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "foreignInvoice": {
                    "no": "996/CONC-5675643/031000",
                    "date": 1598945400000,
                    "unitPrice": 29530.68,
                    "unitCost": 1162.46,
                    "sumFIPrice": 226945.75,
                    "sumPIPrice": 6776,
                    "sumPrice": 220169.75,
                    "conversionDate": 1598745600000,
                    "conversionRate": 12,
                    "conversionSumPrice": 2642037,
                    "conversionSumPriceText": "two million six hundred and forty two thousand thirty seven",
                    "description": "desc",
                    "conversionRefId": 124,
                    "currencyId": -32,
                    "buyerId": 41,
                    "invoiceTypeId": 1,
                    "shipmentId": 73,
                    "creatorId": 3,
                    "id": 52,
                    "conversionRef": {
                        "currencyDate": "2020-08-30",
                        "unitFromId": -32,
                        "unitToId": -33,
                        "reference": "ECB",
                        "currencyRateValue": 12,
                        "currencyTypeFrom": "AZAD",
                        "id": 124,
                        "createdDate": 1597555991765,
                        "unitFrom": {
                            "nameFA": "دلار",
                            "nameEN": "Dollar",
                            "categoryUnit": "Finance"
                        },
                        "unitTo": {
                            "nameFA": "یورو",
                            "nameEN": "Euro",
                            "categoryUnit": "Finance"
                        },
                        "createdBy": "m.shahabi",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "currency": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance",
                        "id": -32,
                        "createdDate": 1595738609668,
                        "createdBy": "liquibase",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "buyer": {
                        "nameFA": "SUNGILL RESOURCES LTD",
                        "nameEN": "SUNGILL RESOURCES LTD",
                        "phone": "+852 2575 7591",
                        "fax": "+852 3702 0210",
                        "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                        "type": false,
                        "status": true,
                        "commercialRole": "Buyer",
                        "buyer": true,
                        "countryId": 2,
                        "id": 41,
                        "country": {
                            "nameFa": "چین",
                            "nameEn": "FkChina"
                        },
                        "createdDate": 1579683563975,
                        "createdBy": "dorani_sa",
                        "lastModifiedDate": 1579935876622,
                        "lastModifiedBy": "dorani_sa",
                        "version": 1
                    },
                    "invoiceType": {
                        "title": "FINAL",
                        "id": 1,
                        "createdDate": 1597536539050,
                        "createdBy": "liquibase",
                        "version": 0
                    },
                    "shipment": {
                        "contractShipmentId": 21,
                        "shipmentTypeId": 1,
                        "shipmentMethodId": 2,
                        "contactId": 41,
                        "materialId": 3,
                        "contactAgentId": 221,
                        "vesselId": 33,
                        "unitId": -11,
                        "dischargePortId": 1,
                        "amount": 44455,
                        "automationLetterNo": "222",
                        "automationLetterDate": 1598988600000,
                        "sendDate": 1596758400000,
                        "noBLs": 4,
                        "bookingCat": "222333",
                        "vgm": 0,
                        "arrivalDateFrom": 936084600000,
                        "arrivalDateTo": 1819697400000,
                        "id": 73,
                        "createdDate": 1597812976018,
                        "createdBy": "devadmin",
                        "lastModifiedDate": 1599278424279,
                        "lastModifiedBy": "devadmin",
                        "version": 9,
                        "editable": true,
                        "unit": {
                            "nameFA": "کیلوگرم",
                            "nameEN": "kilogramme",
                            "categoryUnit": "Weight",
                            "id": -11,
                            "createdDate": 1593755140056,
                            "createdBy": "j.azad",
                            "lastModifiedDate": 1594440292826,
                            "lastModifiedBy": "j.azad",
                            "version": 2,
                            "editable": false,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "vessel": {
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
                        "contact": {
                            "nameFA": "SUNGILL RESOURCES LTD",
                            "nameEN": "SUNGILL RESOURCES LTD",
                            "phone": "+852 2575 7591",
                            "fax": "+852 3702 0210",
                            "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                            "type": false,
                            "status": true,
                            "commercialRole": "Buyer",
                            "buyer": true,
                            "countryId": 2,
                            "id": 41,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1579683563975,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1579935876622,
                            "lastModifiedBy": "dorani_sa",
                            "version": 1
                        },
                        "dischargePort": {
                            "port": "HUANGPU",
                            "countryId": 2,
                            "id": 1,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina",
                                "id": 2,
                                "createdDate": 1595302644624,
                                "createdBy": "j.azad",
                                "lastModifiedDate": 1598846835554,
                                "lastModifiedBy": "db_zare",
                                "version": 1,
                                "editable": true,
                                "estatus": [
                                    "Active"
                                ]
                            },
                            "createdDate": 1578198734058,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1587865832220,
                            "lastModifiedBy": "db_mazloom",
                            "version": 2,
                            "editable": true,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "contactAgent": {
                            "nameFA": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "nameEN": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "phone": "+86-21-54981420",
                            "fax": "+86-358-5489141",
                            "type": false,
                            "status": true,
                            "tradeMark": "SHANGHAI HONGTE ",
                            "commercialRole": "Buyer",
                            "seller": false,
                            "buyer": true,
                            "countryId": 2,
                            "id": 221,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1589587421596,
                            "createdBy": "db_mazloom",
                            "version": 0
                        },
                        "material": {
                            "descl": "Copper Concentrate",
                            "descp": "مس کنسانتره",
                            "code": "26030090",
                            "abbreviation": "CONC",
                            "id": 3,
                            "createdDate": 1595302642815,
                            "createdBy": "liquibase",
                            "version": 6
                        },
                        "shipmentType": {
                            "shipmentType": "فله",
                            "id": 1,
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
                            "loadPortId": 21,
                            "quantity": 6000,
                            "sendDate": "2020-08-02",
                            "tolorance": 790,
                            "contractId": 294,
                            "id": 21,
                            "contract": {
                                "no": "5675643",
                                "date": 1598081400000,
                                "affectFrom": 1598081400000,
                                "affectUpTo": 1598081400000,
                                "content": "<h1>article1</h1>SAMPLE SAMPLE 10 SAMPLE<br><font size=\"7\"><u><i><b>SAMPLE<br></b></i></u></font><div><font size=\"7\"><u><i><b>SAMPLE</b></i></u></font></div><div><font size=\"7\"><u><i><b><br></b></i></u></font></div>",
                                "materialId": 3,
                                "contractTypeId": 1
                            },
                            "loadPort": {
                                "port": "JEBEL ALI",
                                "countryId": 3
                            },
                            "createdDate": 1595402676281,
                            "createdBy": "m.shahabi",
                            "version": 0
                        },
                        "estatus": [
                            "Active"
                        ],
                        "moisture": 0
                    },
                    "creator": {
                        "fullName": "tertert",
                        "jobTitle": "ertertert",
                        "id": 3,
                        "createdDate": 1595330408784,
                        "createdBy": "devadmin",
                        "version": 0
                    },
                    "createdDate": 1598971887027,
                    "createdBy": "m.shahabi",
                    "lastModifiedDate": 1599543162651,
                    "lastModifiedBy": "m.shahabi",
                    "version": 2,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "createdDate": 1598971887447,
                "createdBy": "m.shahabi",
                "version": 0,
                "editable": true,
                "estatus": [
                    "Active"
                ]
            },
            {
                "docNo": "20208/CONC-564/061083",
                "docDate": 1597017600000,
                "docSumValue": 16000,
                "docConversionDate": 1597017600000,
                "docConversionRate": 44,
                "docConversionPrice": 719400,
                "portion": 40,
                "conversionRefId": 75,
                "foreignInvoiceId": 52,
                "id": 13,
                "conversionRef": {
                    "currencyDate": "2020-08-02",
                    "unitFromId": -32,
                    "unitToId": 999,
                    "reference": "ECB",
                    "currencyRateValue": 44,
                    "currencyTypeFrom": "AZAD",
                    "currencyTypeTo": "AZAD",
                    "id": 75,
                    "createdDate": 1596951921630,
                    "unitFrom": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance"
                    },
                    "unitTo": {
                        "nameFA": "نا مشخص",
                        "nameEN": "نا مشخص",
                        "categoryUnit": "Weight"
                    },
                    "createdBy": "devadmin",
                    "lastModifiedDate": 1596952705594,
                    "lastModifiedBy": "devadmin",
                    "version": 2,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "foreignInvoice": {
                    "no": "996/CONC-5675643/031000",
                    "date": 1598945400000,
                    "unitPrice": 29530.68,
                    "unitCost": 1162.46,
                    "sumFIPrice": 226945.75,
                    "sumPIPrice": 6776,
                    "sumPrice": 220169.75,
                    "conversionDate": 1598745600000,
                    "conversionRate": 12,
                    "conversionSumPrice": 2642037,
                    "conversionSumPriceText": "two million six hundred and forty two thousand thirty seven",
                    "description": "desc",
                    "conversionRefId": 124,
                    "currencyId": -32,
                    "buyerId": 41,
                    "invoiceTypeId": 1,
                    "shipmentId": 73,
                    "creatorId": 3,
                    "id": 52,
                    "conversionRef": {
                        "currencyDate": "2020-08-30",
                        "unitFromId": -32,
                        "unitToId": -33,
                        "reference": "ECB",
                        "currencyRateValue": 12,
                        "currencyTypeFrom": "AZAD",
                        "id": 124,
                        "createdDate": 1597555991765,
                        "unitFrom": {
                            "nameFA": "دلار",
                            "nameEN": "Dollar",
                            "categoryUnit": "Finance"
                        },
                        "unitTo": {
                            "nameFA": "یورو",
                            "nameEN": "Euro",
                            "categoryUnit": "Finance"
                        },
                        "createdBy": "m.shahabi",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "currency": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance",
                        "id": -32,
                        "createdDate": 1595738609668,
                        "createdBy": "liquibase",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "buyer": {
                        "nameFA": "SUNGILL RESOURCES LTD",
                        "nameEN": "SUNGILL RESOURCES LTD",
                        "phone": "+852 2575 7591",
                        "fax": "+852 3702 0210",
                        "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                        "type": false,
                        "status": true,
                        "commercialRole": "Buyer",
                        "buyer": true,
                        "countryId": 2,
                        "id": 41,
                        "country": {
                            "nameFa": "چین",
                            "nameEn": "FkChina"
                        },
                        "createdDate": 1579683563975,
                        "createdBy": "dorani_sa",
                        "lastModifiedDate": 1579935876622,
                        "lastModifiedBy": "dorani_sa",
                        "version": 1
                    },
                    "invoiceType": {
                        "title": "FINAL",
                        "id": 1,
                        "createdDate": 1597536539050,
                        "createdBy": "liquibase",
                        "version": 0
                    },
                    "shipment": {
                        "contractShipmentId": 21,
                        "shipmentTypeId": 1,
                        "shipmentMethodId": 2,
                        "contactId": 41,
                        "materialId": 3,
                        "contactAgentId": 221,
                        "vesselId": 33,
                        "unitId": -11,
                        "dischargePortId": 1,
                        "amount": 44455,
                        "automationLetterNo": "222",
                        "automationLetterDate": 1598988600000,
                        "sendDate": 1596758400000,
                        "noBLs": 4,
                        "bookingCat": "222333",
                        "vgm": 0,
                        "arrivalDateFrom": 936084600000,
                        "arrivalDateTo": 1819697400000,
                        "id": 73,
                        "createdDate": 1597812976018,
                        "createdBy": "devadmin",
                        "lastModifiedDate": 1599278424279,
                        "lastModifiedBy": "devadmin",
                        "version": 9,
                        "editable": true,
                        "unit": {
                            "nameFA": "کیلوگرم",
                            "nameEN": "kilogramme",
                            "categoryUnit": "Weight",
                            "id": -11,
                            "createdDate": 1593755140056,
                            "createdBy": "j.azad",
                            "lastModifiedDate": 1594440292826,
                            "lastModifiedBy": "j.azad",
                            "version": 2,
                            "editable": false,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "vessel": {
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
                        "contact": {
                            "nameFA": "SUNGILL RESOURCES LTD",
                            "nameEN": "SUNGILL RESOURCES LTD",
                            "phone": "+852 2575 7591",
                            "fax": "+852 3702 0210",
                            "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                            "type": false,
                            "status": true,
                            "commercialRole": "Buyer",
                            "buyer": true,
                            "countryId": 2,
                            "id": 41,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1579683563975,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1579935876622,
                            "lastModifiedBy": "dorani_sa",
                            "version": 1
                        },
                        "dischargePort": {
                            "port": "HUANGPU",
                            "countryId": 2,
                            "id": 1,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina",
                                "id": 2,
                                "createdDate": 1595302644624,
                                "createdBy": "j.azad",
                                "lastModifiedDate": 1598846835554,
                                "lastModifiedBy": "db_zare",
                                "version": 1,
                                "editable": true,
                                "estatus": [
                                    "Active"
                                ]
                            },
                            "createdDate": 1578198734058,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1587865832220,
                            "lastModifiedBy": "db_mazloom",
                            "version": 2,
                            "editable": true,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "contactAgent": {
                            "nameFA": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "nameEN": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "phone": "+86-21-54981420",
                            "fax": "+86-358-5489141",
                            "type": false,
                            "status": true,
                            "tradeMark": "SHANGHAI HONGTE ",
                            "commercialRole": "Buyer",
                            "seller": false,
                            "buyer": true,
                            "countryId": 2,
                            "id": 221,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1589587421596,
                            "createdBy": "db_mazloom",
                            "version": 0
                        },
                        "material": {
                            "descl": "Copper Concentrate",
                            "descp": "مس کنسانتره",
                            "code": "26030090",
                            "abbreviation": "CONC",
                            "id": 3,
                            "createdDate": 1595302642815,
                            "createdBy": "liquibase",
                            "version": 6
                        },
                        "shipmentType": {
                            "shipmentType": "فله",
                            "id": 1,
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
                            "loadPortId": 21,
                            "quantity": 6000,
                            "sendDate": "2020-08-02",
                            "tolorance": 790,
                            "contractId": 294,
                            "id": 21,
                            "contract": {
                                "no": "5675643",
                                "date": 1598081400000,
                                "affectFrom": 1598081400000,
                                "affectUpTo": 1598081400000,
                                "content": "<h1>article1</h1>SAMPLE SAMPLE 10 SAMPLE<br><font size=\"7\"><u><i><b>SAMPLE<br></b></i></u></font><div><font size=\"7\"><u><i><b>SAMPLE</b></i></u></font></div><div><font size=\"7\"><u><i><b><br></b></i></u></font></div>",
                                "materialId": 3,
                                "contractTypeId": 1
                            },
                            "loadPort": {
                                "port": "JEBEL ALI",
                                "countryId": 3
                            },
                            "createdDate": 1595402676281,
                            "createdBy": "m.shahabi",
                            "version": 0
                        },
                        "estatus": [
                            "Active"
                        ],
                        "moisture": 0
                    },
                    "creator": {
                        "fullName": "tertert",
                        "jobTitle": "ertertert",
                        "id": 3,
                        "createdDate": 1595330408784,
                        "createdBy": "devadmin",
                        "version": 0
                    },
                    "createdDate": 1598971887027,
                    "createdBy": "m.shahabi",
                    "lastModifiedDate": 1599543162651,
                    "lastModifiedBy": "m.shahabi",
                    "version": 2,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "createdDate": 1598971887453,
                "createdBy": "m.shahabi",
                "version": 0,
                "editable": true,
                "estatus": [
                    "Active"
                ]
            },
            {
                "docNo": "20208/CAD-144/051067",
                "docDate": 1597449600000,
                "docSumValue": 5580,
                "docConversionDate": 1597449600000,
                "docConversionRate": 35345,
                "docConversionPrice": 193246666.8,
                "portion": 50,
                "conversionRefId": 78,
                "foreignInvoiceId": 52,
                "id": 14,
                "conversionRef": {
                    "currencyDate": "2020-02-09",
                    "unitFromId": 999,
                    "unitToId": -32,
                    "reference": "ECB",
                    "currencyRateValue": 35345,
                    "currencyTypeTo": "AZAD",
                    "id": 78,
                    "createdDate": 1596952745060,
                    "unitFrom": {
                        "nameFA": "نا مشخص",
                        "nameEN": "نا مشخص",
                        "categoryUnit": "Weight"
                    },
                    "unitTo": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance"
                    },
                    "createdBy": "devadmin",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "foreignInvoice": {
                    "no": "996/CONC-5675643/031000",
                    "date": 1598945400000,
                    "unitPrice": 29530.68,
                    "unitCost": 1162.46,
                    "sumFIPrice": 226945.75,
                    "sumPIPrice": 6776,
                    "sumPrice": 220169.75,
                    "conversionDate": 1598745600000,
                    "conversionRate": 12,
                    "conversionSumPrice": 2642037,
                    "conversionSumPriceText": "two million six hundred and forty two thousand thirty seven",
                    "description": "desc",
                    "conversionRefId": 124,
                    "currencyId": -32,
                    "buyerId": 41,
                    "invoiceTypeId": 1,
                    "shipmentId": 73,
                    "creatorId": 3,
                    "id": 52,
                    "conversionRef": {
                        "currencyDate": "2020-08-30",
                        "unitFromId": -32,
                        "unitToId": -33,
                        "reference": "ECB",
                        "currencyRateValue": 12,
                        "currencyTypeFrom": "AZAD",
                        "id": 124,
                        "createdDate": 1597555991765,
                        "unitFrom": {
                            "nameFA": "دلار",
                            "nameEN": "Dollar",
                            "categoryUnit": "Finance"
                        },
                        "unitTo": {
                            "nameFA": "یورو",
                            "nameEN": "Euro",
                            "categoryUnit": "Finance"
                        },
                        "createdBy": "m.shahabi",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "currency": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance",
                        "id": -32,
                        "createdDate": 1595738609668,
                        "createdBy": "liquibase",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "buyer": {
                        "nameFA": "SUNGILL RESOURCES LTD",
                        "nameEN": "SUNGILL RESOURCES LTD",
                        "phone": "+852 2575 7591",
                        "fax": "+852 3702 0210",
                        "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                        "type": false,
                        "status": true,
                        "commercialRole": "Buyer",
                        "buyer": true,
                        "countryId": 2,
                        "id": 41,
                        "country": {
                            "nameFa": "چین",
                            "nameEn": "FkChina"
                        },
                        "createdDate": 1579683563975,
                        "createdBy": "dorani_sa",
                        "lastModifiedDate": 1579935876622,
                        "lastModifiedBy": "dorani_sa",
                        "version": 1
                    },
                    "invoiceType": {
                        "title": "FINAL",
                        "id": 1,
                        "createdDate": 1597536539050,
                        "createdBy": "liquibase",
                        "version": 0
                    },
                    "shipment": {
                        "contractShipmentId": 21,
                        "shipmentTypeId": 1,
                        "shipmentMethodId": 2,
                        "contactId": 41,
                        "materialId": 3,
                        "contactAgentId": 221,
                        "vesselId": 33,
                        "unitId": -11,
                        "dischargePortId": 1,
                        "amount": 44455,
                        "automationLetterNo": "222",
                        "automationLetterDate": 1598988600000,
                        "sendDate": 1596758400000,
                        "noBLs": 4,
                        "bookingCat": "222333",
                        "vgm": 0,
                        "arrivalDateFrom": 936084600000,
                        "arrivalDateTo": 1819697400000,
                        "id": 73,
                        "createdDate": 1597812976018,
                        "createdBy": "devadmin",
                        "lastModifiedDate": 1599278424279,
                        "lastModifiedBy": "devadmin",
                        "version": 9,
                        "editable": true,
                        "unit": {
                            "nameFA": "کیلوگرم",
                            "nameEN": "kilogramme",
                            "categoryUnit": "Weight",
                            "id": -11,
                            "createdDate": 1593755140056,
                            "createdBy": "j.azad",
                            "lastModifiedDate": 1594440292826,
                            "lastModifiedBy": "j.azad",
                            "version": 2,
                            "editable": false,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "vessel": {
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
                        "contact": {
                            "nameFA": "SUNGILL RESOURCES LTD",
                            "nameEN": "SUNGILL RESOURCES LTD",
                            "phone": "+852 2575 7591",
                            "fax": "+852 3702 0210",
                            "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                            "type": false,
                            "status": true,
                            "commercialRole": "Buyer",
                            "buyer": true,
                            "countryId": 2,
                            "id": 41,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1579683563975,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1579935876622,
                            "lastModifiedBy": "dorani_sa",
                            "version": 1
                        },
                        "dischargePort": {
                            "port": "HUANGPU",
                            "countryId": 2,
                            "id": 1,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina",
                                "id": 2,
                                "createdDate": 1595302644624,
                                "createdBy": "j.azad",
                                "lastModifiedDate": 1598846835554,
                                "lastModifiedBy": "db_zare",
                                "version": 1,
                                "editable": true,
                                "estatus": [
                                    "Active"
                                ]
                            },
                            "createdDate": 1578198734058,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1587865832220,
                            "lastModifiedBy": "db_mazloom",
                            "version": 2,
                            "editable": true,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "contactAgent": {
                            "nameFA": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "nameEN": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "phone": "+86-21-54981420",
                            "fax": "+86-358-5489141",
                            "type": false,
                            "status": true,
                            "tradeMark": "SHANGHAI HONGTE ",
                            "commercialRole": "Buyer",
                            "seller": false,
                            "buyer": true,
                            "countryId": 2,
                            "id": 221,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1589587421596,
                            "createdBy": "db_mazloom",
                            "version": 0
                        },
                        "material": {
                            "descl": "Copper Concentrate",
                            "descp": "مس کنسانتره",
                            "code": "26030090",
                            "abbreviation": "CONC",
                            "id": 3,
                            "createdDate": 1595302642815,
                            "createdBy": "liquibase",
                            "version": 6
                        },
                        "shipmentType": {
                            "shipmentType": "فله",
                            "id": 1,
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
                            "loadPortId": 21,
                            "quantity": 6000,
                            "sendDate": "2020-08-02",
                            "tolorance": 790,
                            "contractId": 294,
                            "id": 21,
                            "contract": {
                                "no": "5675643",
                                "date": 1598081400000,
                                "affectFrom": 1598081400000,
                                "affectUpTo": 1598081400000,
                                "content": "<h1>article1</h1>SAMPLE SAMPLE 10 SAMPLE<br><font size=\"7\"><u><i><b>SAMPLE<br></b></i></u></font><div><font size=\"7\"><u><i><b>SAMPLE</b></i></u></font></div><div><font size=\"7\"><u><i><b><br></b></i></u></font></div>",
                                "materialId": 3,
                                "contractTypeId": 1
                            },
                            "loadPort": {
                                "port": "JEBEL ALI",
                                "countryId": 3
                            },
                            "createdDate": 1595402676281,
                            "createdBy": "m.shahabi",
                            "version": 0
                        },
                        "estatus": [
                            "Active"
                        ],
                        "moisture": 0
                    },
                    "creator": {
                        "fullName": "tertert",
                        "jobTitle": "ertertert",
                        "id": 3,
                        "createdDate": 1595330408784,
                        "createdBy": "devadmin",
                        "version": 0
                    },
                    "createdDate": 1598971887027,
                    "createdBy": "m.shahabi",
                    "lastModifiedDate": 1599543162651,
                    "lastModifiedBy": "m.shahabi",
                    "version": 2,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "createdDate": 1598971887459,
                "createdBy": "m.shahabi",
                "version": 0,
                "editable": true,
                "estatus": [
                    "Active"
                ]
            },
            {
                "docNo": "4444",
                "docDate": 1597708800000,
                "docSumValue": 534339,
                "docConversionDate": 1597708800000,
                "docConversionRate": 1,
                "docConversionPrice": 580843.56,
                "portion": 65,
                "description": "Descrip...",
                "foreignInvoiceId": 52,
                "id": 15,
                "foreignInvoice": {
                    "no": "996/CONC-5675643/031000",
                    "date": 1598945400000,
                    "unitPrice": 29530.68,
                    "unitCost": 1162.46,
                    "sumFIPrice": 226945.75,
                    "sumPIPrice": 6776,
                    "sumPrice": 220169.75,
                    "conversionDate": 1598745600000,
                    "conversionRate": 12,
                    "conversionSumPrice": 2642037,
                    "conversionSumPriceText": "two million six hundred and forty two thousand thirty seven",
                    "description": "desc",
                    "conversionRefId": 124,
                    "currencyId": -32,
                    "buyerId": 41,
                    "invoiceTypeId": 1,
                    "shipmentId": 73,
                    "creatorId": 3,
                    "id": 52,
                    "conversionRef": {
                        "currencyDate": "2020-08-30",
                        "unitFromId": -32,
                        "unitToId": -33,
                        "reference": "ECB",
                        "currencyRateValue": 12,
                        "currencyTypeFrom": "AZAD",
                        "id": 124,
                        "createdDate": 1597555991765,
                        "unitFrom": {
                            "nameFA": "دلار",
                            "nameEN": "Dollar",
                            "categoryUnit": "Finance"
                        },
                        "unitTo": {
                            "nameFA": "یورو",
                            "nameEN": "Euro",
                            "categoryUnit": "Finance"
                        },
                        "createdBy": "m.shahabi",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "currency": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance",
                        "id": -32,
                        "createdDate": 1595738609668,
                        "createdBy": "liquibase",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "buyer": {
                        "nameFA": "SUNGILL RESOURCES LTD",
                        "nameEN": "SUNGILL RESOURCES LTD",
                        "phone": "+852 2575 7591",
                        "fax": "+852 3702 0210",
                        "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                        "type": false,
                        "status": true,
                        "commercialRole": "Buyer",
                        "buyer": true,
                        "countryId": 2,
                        "id": 41,
                        "country": {
                            "nameFa": "چین",
                            "nameEn": "FkChina"
                        },
                        "createdDate": 1579683563975,
                        "createdBy": "dorani_sa",
                        "lastModifiedDate": 1579935876622,
                        "lastModifiedBy": "dorani_sa",
                        "version": 1
                    },
                    "invoiceType": {
                        "title": "FINAL",
                        "id": 1,
                        "createdDate": 1597536539050,
                        "createdBy": "liquibase",
                        "version": 0
                    },
                    "shipment": {
                        "contractShipmentId": 21,
                        "shipmentTypeId": 1,
                        "shipmentMethodId": 2,
                        "contactId": 41,
                        "materialId": 3,
                        "contactAgentId": 221,
                        "vesselId": 33,
                        "unitId": -11,
                        "dischargePortId": 1,
                        "amount": 44455,
                        "automationLetterNo": "222",
                        "automationLetterDate": 1598988600000,
                        "sendDate": 1596758400000,
                        "noBLs": 4,
                        "bookingCat": "222333",
                        "vgm": 0,
                        "arrivalDateFrom": 936084600000,
                        "arrivalDateTo": 1819697400000,
                        "id": 73,
                        "createdDate": 1597812976018,
                        "createdBy": "devadmin",
                        "lastModifiedDate": 1599278424279,
                        "lastModifiedBy": "devadmin",
                        "version": 9,
                        "editable": true,
                        "unit": {
                            "nameFA": "کیلوگرم",
                            "nameEN": "kilogramme",
                            "categoryUnit": "Weight",
                            "id": -11,
                            "createdDate": 1593755140056,
                            "createdBy": "j.azad",
                            "lastModifiedDate": 1594440292826,
                            "lastModifiedBy": "j.azad",
                            "version": 2,
                            "editable": false,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "vessel": {
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
                        "contact": {
                            "nameFA": "SUNGILL RESOURCES LTD",
                            "nameEN": "SUNGILL RESOURCES LTD",
                            "phone": "+852 2575 7591",
                            "fax": "+852 3702 0210",
                            "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                            "type": false,
                            "status": true,
                            "commercialRole": "Buyer",
                            "buyer": true,
                            "countryId": 2,
                            "id": 41,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1579683563975,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1579935876622,
                            "lastModifiedBy": "dorani_sa",
                            "version": 1
                        },
                        "dischargePort": {
                            "port": "HUANGPU",
                            "countryId": 2,
                            "id": 1,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina",
                                "id": 2,
                                "createdDate": 1595302644624,
                                "createdBy": "j.azad",
                                "lastModifiedDate": 1598846835554,
                                "lastModifiedBy": "db_zare",
                                "version": 1,
                                "editable": true,
                                "estatus": [
                                    "Active"
                                ]
                            },
                            "createdDate": 1578198734058,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1587865832220,
                            "lastModifiedBy": "db_mazloom",
                            "version": 2,
                            "editable": true,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "contactAgent": {
                            "nameFA": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "nameEN": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "phone": "+86-21-54981420",
                            "fax": "+86-358-5489141",
                            "type": false,
                            "status": true,
                            "tradeMark": "SHANGHAI HONGTE ",
                            "commercialRole": "Buyer",
                            "seller": false,
                            "buyer": true,
                            "countryId": 2,
                            "id": 221,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1589587421596,
                            "createdBy": "db_mazloom",
                            "version": 0
                        },
                        "material": {
                            "descl": "Copper Concentrate",
                            "descp": "مس کنسانتره",
                            "code": "26030090",
                            "abbreviation": "CONC",
                            "id": 3,
                            "createdDate": 1595302642815,
                            "createdBy": "liquibase",
                            "version": 6
                        },
                        "shipmentType": {
                            "shipmentType": "فله",
                            "id": 1,
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
                            "loadPortId": 21,
                            "quantity": 6000,
                            "sendDate": "2020-08-02",
                            "tolorance": 790,
                            "contractId": 294,
                            "id": 21,
                            "contract": {
                                "no": "5675643",
                                "date": 1598081400000,
                                "affectFrom": 1598081400000,
                                "affectUpTo": 1598081400000,
                                "content": "<h1>article1</h1>SAMPLE SAMPLE 10 SAMPLE<br><font size=\"7\"><u><i><b>SAMPLE<br></b></i></u></font><div><font size=\"7\"><u><i><b>SAMPLE</b></i></u></font></div><div><font size=\"7\"><u><i><b><br></b></i></u></font></div>",
                                "materialId": 3,
                                "contractTypeId": 1
                            },
                            "loadPort": {
                                "port": "JEBEL ALI",
                                "countryId": 3
                            },
                            "createdDate": 1595402676281,
                            "createdBy": "m.shahabi",
                            "version": 0
                        },
                        "estatus": [
                            "Active"
                        ],
                        "moisture": 0
                    },
                    "creator": {
                        "fullName": "tertert",
                        "jobTitle": "ertertert",
                        "id": 3,
                        "createdDate": 1595330408784,
                        "createdBy": "devadmin",
                        "version": 0
                    },
                    "createdDate": 1598971887027,
                    "createdBy": "m.shahabi",
                    "lastModifiedDate": 1599543162651,
                    "lastModifiedBy": "m.shahabi",
                    "version": 2,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "createdDate": 1598971887464,
                "createdBy": "m.shahabi",
                "version": 0,
                "editable": true,
                "estatus": [
                    "Active"
                ]
            },
            {
                "docNo": "20208/MO-9898/061163",
                "docDate": 1598832000000,
                "docSumValue": 2220,
                "docConversionDate": 1598832000000,
                "docConversionRate": 12,
                "docConversionPrice": 18874.44,
                "portion": 60,
                "description": "dd",
                "conversionRefId": 124,
                "foreignInvoiceId": 52,
                "id": 16,
                "conversionRef": {
                    "currencyDate": "2020-08-30",
                    "unitFromId": -32,
                    "unitToId": -33,
                    "reference": "ECB",
                    "currencyRateValue": 12,
                    "currencyTypeFrom": "AZAD",
                    "id": 124,
                    "createdDate": 1597555991765,
                    "unitFrom": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance"
                    },
                    "unitTo": {
                        "nameFA": "یورو",
                        "nameEN": "Euro",
                        "categoryUnit": "Finance"
                    },
                    "createdBy": "m.shahabi",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "foreignInvoice": {
                    "no": "996/CONC-5675643/031000",
                    "date": 1598945400000,
                    "unitPrice": 29530.68,
                    "unitCost": 1162.46,
                    "sumFIPrice": 226945.75,
                    "sumPIPrice": 6776,
                    "sumPrice": 220169.75,
                    "conversionDate": 1598745600000,
                    "conversionRate": 12,
                    "conversionSumPrice": 2642037,
                    "conversionSumPriceText": "two million six hundred and forty two thousand thirty seven",
                    "description": "desc",
                    "conversionRefId": 124,
                    "currencyId": -32,
                    "buyerId": 41,
                    "invoiceTypeId": 1,
                    "shipmentId": 73,
                    "creatorId": 3,
                    "id": 52,
                    "conversionRef": {
                        "currencyDate": "2020-08-30",
                        "unitFromId": -32,
                        "unitToId": -33,
                        "reference": "ECB",
                        "currencyRateValue": 12,
                        "currencyTypeFrom": "AZAD",
                        "id": 124,
                        "createdDate": 1597555991765,
                        "unitFrom": {
                            "nameFA": "دلار",
                            "nameEN": "Dollar",
                            "categoryUnit": "Finance"
                        },
                        "unitTo": {
                            "nameFA": "یورو",
                            "nameEN": "Euro",
                            "categoryUnit": "Finance"
                        },
                        "createdBy": "m.shahabi",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "currency": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance",
                        "id": -32,
                        "createdDate": 1595738609668,
                        "createdBy": "liquibase",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "buyer": {
                        "nameFA": "SUNGILL RESOURCES LTD",
                        "nameEN": "SUNGILL RESOURCES LTD",
                        "phone": "+852 2575 7591",
                        "fax": "+852 3702 0210",
                        "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                        "type": false,
                        "status": true,
                        "commercialRole": "Buyer",
                        "buyer": true,
                        "countryId": 2,
                        "id": 41,
                        "country": {
                            "nameFa": "چین",
                            "nameEn": "FkChina"
                        },
                        "createdDate": 1579683563975,
                        "createdBy": "dorani_sa",
                        "lastModifiedDate": 1579935876622,
                        "lastModifiedBy": "dorani_sa",
                        "version": 1
                    },
                    "invoiceType": {
                        "title": "FINAL",
                        "id": 1,
                        "createdDate": 1597536539050,
                        "createdBy": "liquibase",
                        "version": 0
                    },
                    "shipment": {
                        "contractShipmentId": 21,
                        "shipmentTypeId": 1,
                        "shipmentMethodId": 2,
                        "contactId": 41,
                        "materialId": 3,
                        "contactAgentId": 221,
                        "vesselId": 33,
                        "unitId": -11,
                        "dischargePortId": 1,
                        "amount": 44455,
                        "automationLetterNo": "222",
                        "automationLetterDate": 1598988600000,
                        "sendDate": 1596758400000,
                        "noBLs": 4,
                        "bookingCat": "222333",
                        "vgm": 0,
                        "arrivalDateFrom": 936084600000,
                        "arrivalDateTo": 1819697400000,
                        "id": 73,
                        "createdDate": 1597812976018,
                        "createdBy": "devadmin",
                        "lastModifiedDate": 1599278424279,
                        "lastModifiedBy": "devadmin",
                        "version": 9,
                        "editable": true,
                        "unit": {
                            "nameFA": "کیلوگرم",
                            "nameEN": "kilogramme",
                            "categoryUnit": "Weight",
                            "id": -11,
                            "createdDate": 1593755140056,
                            "createdBy": "j.azad",
                            "lastModifiedDate": 1594440292826,
                            "lastModifiedBy": "j.azad",
                            "version": 2,
                            "editable": false,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "vessel": {
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
                        "contact": {
                            "nameFA": "SUNGILL RESOURCES LTD",
                            "nameEN": "SUNGILL RESOURCES LTD",
                            "phone": "+852 2575 7591",
                            "fax": "+852 3702 0210",
                            "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                            "type": false,
                            "status": true,
                            "commercialRole": "Buyer",
                            "buyer": true,
                            "countryId": 2,
                            "id": 41,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1579683563975,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1579935876622,
                            "lastModifiedBy": "dorani_sa",
                            "version": 1
                        },
                        "dischargePort": {
                            "port": "HUANGPU",
                            "countryId": 2,
                            "id": 1,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina",
                                "id": 2,
                                "createdDate": 1595302644624,
                                "createdBy": "j.azad",
                                "lastModifiedDate": 1598846835554,
                                "lastModifiedBy": "db_zare",
                                "version": 1,
                                "editable": true,
                                "estatus": [
                                    "Active"
                                ]
                            },
                            "createdDate": 1578198734058,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1587865832220,
                            "lastModifiedBy": "db_mazloom",
                            "version": 2,
                            "editable": true,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "contactAgent": {
                            "nameFA": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "nameEN": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "phone": "+86-21-54981420",
                            "fax": "+86-358-5489141",
                            "type": false,
                            "status": true,
                            "tradeMark": "SHANGHAI HONGTE ",
                            "commercialRole": "Buyer",
                            "seller": false,
                            "buyer": true,
                            "countryId": 2,
                            "id": 221,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1589587421596,
                            "createdBy": "db_mazloom",
                            "version": 0
                        },
                        "material": {
                            "descl": "Copper Concentrate",
                            "descp": "مس کنسانتره",
                            "code": "26030090",
                            "abbreviation": "CONC",
                            "id": 3,
                            "createdDate": 1595302642815,
                            "createdBy": "liquibase",
                            "version": 6
                        },
                        "shipmentType": {
                            "shipmentType": "فله",
                            "id": 1,
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
                            "loadPortId": 21,
                            "quantity": 6000,
                            "sendDate": "2020-08-02",
                            "tolorance": 790,
                            "contractId": 294,
                            "id": 21,
                            "contract": {
                                "no": "5675643",
                                "date": 1598081400000,
                                "affectFrom": 1598081400000,
                                "affectUpTo": 1598081400000,
                                "content": "<h1>article1</h1>SAMPLE SAMPLE 10 SAMPLE<br><font size=\"7\"><u><i><b>SAMPLE<br></b></i></u></font><div><font size=\"7\"><u><i><b>SAMPLE</b></i></u></font></div><div><font size=\"7\"><u><i><b><br></b></i></u></font></div>",
                                "materialId": 3,
                                "contractTypeId": 1
                            },
                            "loadPort": {
                                "port": "JEBEL ALI",
                                "countryId": 3
                            },
                            "createdDate": 1595402676281,
                            "createdBy": "m.shahabi",
                            "version": 0
                        },
                        "estatus": [
                            "Active"
                        ],
                        "moisture": 0
                    },
                    "creator": {
                        "fullName": "tertert",
                        "jobTitle": "ertertert",
                        "id": 3,
                        "createdDate": 1595330408784,
                        "createdBy": "devadmin",
                        "version": 0
                    },
                    "createdDate": 1598971887027,
                    "createdBy": "m.shahabi",
                    "lastModifiedDate": 1599543162651,
                    "lastModifiedBy": "m.shahabi",
                    "version": 2,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "createdDate": 1598971887472,
                "createdBy": "m.shahabi",
                "version": 0,
                "editable": true,
                "estatus": [
                    "Active"
                ]
            },
            {
                "docNo": "20209/CAD-144/061183",
                "docDate": 1598918400000,
                "docSumValue": 6000,
                "docConversionDate": 1598918400000,
                "docConversionRate": 1,
                "docConversionPrice": 5450,
                "portion": 20,
                "foreignInvoiceId": 52,
                "id": 17,
                "foreignInvoice": {
                    "no": "996/CONC-5675643/031000",
                    "date": 1598945400000,
                    "unitPrice": 29530.68,
                    "unitCost": 1162.46,
                    "sumFIPrice": 226945.75,
                    "sumPIPrice": 6776,
                    "sumPrice": 220169.75,
                    "conversionDate": 1598745600000,
                    "conversionRate": 12,
                    "conversionSumPrice": 2642037,
                    "conversionSumPriceText": "two million six hundred and forty two thousand thirty seven",
                    "description": "desc",
                    "conversionRefId": 124,
                    "currencyId": -32,
                    "buyerId": 41,
                    "invoiceTypeId": 1,
                    "shipmentId": 73,
                    "creatorId": 3,
                    "id": 52,
                    "conversionRef": {
                        "currencyDate": "2020-08-30",
                        "unitFromId": -32,
                        "unitToId": -33,
                        "reference": "ECB",
                        "currencyRateValue": 12,
                        "currencyTypeFrom": "AZAD",
                        "id": 124,
                        "createdDate": 1597555991765,
                        "unitFrom": {
                            "nameFA": "دلار",
                            "nameEN": "Dollar",
                            "categoryUnit": "Finance"
                        },
                        "unitTo": {
                            "nameFA": "یورو",
                            "nameEN": "Euro",
                            "categoryUnit": "Finance"
                        },
                        "createdBy": "m.shahabi",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "currency": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance",
                        "id": -32,
                        "createdDate": 1595738609668,
                        "createdBy": "liquibase",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "buyer": {
                        "nameFA": "SUNGILL RESOURCES LTD",
                        "nameEN": "SUNGILL RESOURCES LTD",
                        "phone": "+852 2575 7591",
                        "fax": "+852 3702 0210",
                        "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                        "type": false,
                        "status": true,
                        "commercialRole": "Buyer",
                        "buyer": true,
                        "countryId": 2,
                        "id": 41,
                        "country": {
                            "nameFa": "چین",
                            "nameEn": "FkChina"
                        },
                        "createdDate": 1579683563975,
                        "createdBy": "dorani_sa",
                        "lastModifiedDate": 1579935876622,
                        "lastModifiedBy": "dorani_sa",
                        "version": 1
                    },
                    "invoiceType": {
                        "title": "FINAL",
                        "id": 1,
                        "createdDate": 1597536539050,
                        "createdBy": "liquibase",
                        "version": 0
                    },
                    "shipment": {
                        "contractShipmentId": 21,
                        "shipmentTypeId": 1,
                        "shipmentMethodId": 2,
                        "contactId": 41,
                        "materialId": 3,
                        "contactAgentId": 221,
                        "vesselId": 33,
                        "unitId": -11,
                        "dischargePortId": 1,
                        "amount": 44455,
                        "automationLetterNo": "222",
                        "automationLetterDate": 1598988600000,
                        "sendDate": 1596758400000,
                        "noBLs": 4,
                        "bookingCat": "222333",
                        "vgm": 0,
                        "arrivalDateFrom": 936084600000,
                        "arrivalDateTo": 1819697400000,
                        "id": 73,
                        "createdDate": 1597812976018,
                        "createdBy": "devadmin",
                        "lastModifiedDate": 1599278424279,
                        "lastModifiedBy": "devadmin",
                        "version": 9,
                        "editable": true,
                        "unit": {
                            "nameFA": "کیلوگرم",
                            "nameEN": "kilogramme",
                            "categoryUnit": "Weight",
                            "id": -11,
                            "createdDate": 1593755140056,
                            "createdBy": "j.azad",
                            "lastModifiedDate": 1594440292826,
                            "lastModifiedBy": "j.azad",
                            "version": 2,
                            "editable": false,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "vessel": {
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
                        "contact": {
                            "nameFA": "SUNGILL RESOURCES LTD",
                            "nameEN": "SUNGILL RESOURCES LTD",
                            "phone": "+852 2575 7591",
                            "fax": "+852 3702 0210",
                            "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                            "type": false,
                            "status": true,
                            "commercialRole": "Buyer",
                            "buyer": true,
                            "countryId": 2,
                            "id": 41,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1579683563975,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1579935876622,
                            "lastModifiedBy": "dorani_sa",
                            "version": 1
                        },
                        "dischargePort": {
                            "port": "HUANGPU",
                            "countryId": 2,
                            "id": 1,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina",
                                "id": 2,
                                "createdDate": 1595302644624,
                                "createdBy": "j.azad",
                                "lastModifiedDate": 1598846835554,
                                "lastModifiedBy": "db_zare",
                                "version": 1,
                                "editable": true,
                                "estatus": [
                                    "Active"
                                ]
                            },
                            "createdDate": 1578198734058,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1587865832220,
                            "lastModifiedBy": "db_mazloom",
                            "version": 2,
                            "editable": true,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "contactAgent": {
                            "nameFA": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "nameEN": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "phone": "+86-21-54981420",
                            "fax": "+86-358-5489141",
                            "type": false,
                            "status": true,
                            "tradeMark": "SHANGHAI HONGTE ",
                            "commercialRole": "Buyer",
                            "seller": false,
                            "buyer": true,
                            "countryId": 2,
                            "id": 221,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1589587421596,
                            "createdBy": "db_mazloom",
                            "version": 0
                        },
                        "material": {
                            "descl": "Copper Concentrate",
                            "descp": "مس کنسانتره",
                            "code": "26030090",
                            "abbreviation": "CONC",
                            "id": 3,
                            "createdDate": 1595302642815,
                            "createdBy": "liquibase",
                            "version": 6
                        },
                        "shipmentType": {
                            "shipmentType": "فله",
                            "id": 1,
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
                            "loadPortId": 21,
                            "quantity": 6000,
                            "sendDate": "2020-08-02",
                            "tolorance": 790,
                            "contractId": 294,
                            "id": 21,
                            "contract": {
                                "no": "5675643",
                                "date": 1598081400000,
                                "affectFrom": 1598081400000,
                                "affectUpTo": 1598081400000,
                                "content": "<h1>article1</h1>SAMPLE SAMPLE 10 SAMPLE<br><font size=\"7\"><u><i><b>SAMPLE<br></b></i></u></font><div><font size=\"7\"><u><i><b>SAMPLE</b></i></u></font></div><div><font size=\"7\"><u><i><b><br></b></i></u></font></div>",
                                "materialId": 3,
                                "contractTypeId": 1
                            },
                            "loadPort": {
                                "port": "JEBEL ALI",
                                "countryId": 3
                            },
                            "createdDate": 1595402676281,
                            "createdBy": "m.shahabi",
                            "version": 0
                        },
                        "estatus": [
                            "Active"
                        ],
                        "moisture": 0
                    },
                    "creator": {
                        "fullName": "tertert",
                        "jobTitle": "ertertert",
                        "id": 3,
                        "createdDate": 1595330408784,
                        "createdBy": "devadmin",
                        "version": 0
                    },
                    "createdDate": 1598971887027,
                    "createdBy": "m.shahabi",
                    "lastModifiedDate": 1599543162651,
                    "lastModifiedBy": "m.shahabi",
                    "version": 2,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "createdDate": 1598971887478,
                "createdBy": "m.shahabi",
                "version": 0,
                "editable": true,
                "estatus": [
                    "Active"
                ]
            },
            {
                "docNo": "20218/CONC-564/051123",
                "docDate": 1629331200000,
                "docSumValue": 386873,
                "docConversionDate": 1597449600000,
                "docConversionRate": 1,
                "docConversionPrice": 413128.53,
                "portion": 80,
                "foreignInvoiceId": 52,
                "id": 18,
                "foreignInvoice": {
                    "no": "996/CONC-5675643/031000",
                    "date": 1598945400000,
                    "unitPrice": 29530.68,
                    "unitCost": 1162.46,
                    "sumFIPrice": 226945.75,
                    "sumPIPrice": 6776,
                    "sumPrice": 220169.75,
                    "conversionDate": 1598745600000,
                    "conversionRate": 12,
                    "conversionSumPrice": 2642037,
                    "conversionSumPriceText": "two million six hundred and forty two thousand thirty seven",
                    "description": "desc",
                    "conversionRefId": 124,
                    "currencyId": -32,
                    "buyerId": 41,
                    "invoiceTypeId": 1,
                    "shipmentId": 73,
                    "creatorId": 3,
                    "id": 52,
                    "conversionRef": {
                        "currencyDate": "2020-08-30",
                        "unitFromId": -32,
                        "unitToId": -33,
                        "reference": "ECB",
                        "currencyRateValue": 12,
                        "currencyTypeFrom": "AZAD",
                        "id": 124,
                        "createdDate": 1597555991765,
                        "unitFrom": {
                            "nameFA": "دلار",
                            "nameEN": "Dollar",
                            "categoryUnit": "Finance"
                        },
                        "unitTo": {
                            "nameFA": "یورو",
                            "nameEN": "Euro",
                            "categoryUnit": "Finance"
                        },
                        "createdBy": "m.shahabi",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "currency": {
                        "nameFA": "دلار",
                        "nameEN": "Dollar",
                        "categoryUnit": "Finance",
                        "id": -32,
                        "createdDate": 1595738609668,
                        "createdBy": "liquibase",
                        "version": 0,
                        "editable": false,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "buyer": {
                        "nameFA": "SUNGILL RESOURCES LTD",
                        "nameEN": "SUNGILL RESOURCES LTD",
                        "phone": "+852 2575 7591",
                        "fax": "+852 3702 0210",
                        "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                        "type": false,
                        "status": true,
                        "commercialRole": "Buyer",
                        "buyer": true,
                        "countryId": 2,
                        "id": 41,
                        "country": {
                            "nameFa": "چین",
                            "nameEn": "FkChina"
                        },
                        "createdDate": 1579683563975,
                        "createdBy": "dorani_sa",
                        "lastModifiedDate": 1579935876622,
                        "lastModifiedBy": "dorani_sa",
                        "version": 1
                    },
                    "invoiceType": {
                        "title": "FINAL",
                        "id": 1,
                        "createdDate": 1597536539050,
                        "createdBy": "liquibase",
                        "version": 0
                    },
                    "shipment": {
                        "contractShipmentId": 21,
                        "shipmentTypeId": 1,
                        "shipmentMethodId": 2,
                        "contactId": 41,
                        "materialId": 3,
                        "contactAgentId": 221,
                        "vesselId": 33,
                        "unitId": -11,
                        "dischargePortId": 1,
                        "amount": 44455,
                        "automationLetterNo": "222",
                        "automationLetterDate": 1598988600000,
                        "sendDate": 1596758400000,
                        "noBLs": 4,
                        "bookingCat": "222333",
                        "vgm": 0,
                        "arrivalDateFrom": 936084600000,
                        "arrivalDateTo": 1819697400000,
                        "id": 73,
                        "createdDate": 1597812976018,
                        "createdBy": "devadmin",
                        "lastModifiedDate": 1599278424279,
                        "lastModifiedBy": "devadmin",
                        "version": 9,
                        "editable": true,
                        "unit": {
                            "nameFA": "کیلوگرم",
                            "nameEN": "kilogramme",
                            "categoryUnit": "Weight",
                            "id": -11,
                            "createdDate": 1593755140056,
                            "createdBy": "j.azad",
                            "lastModifiedDate": 1594440292826,
                            "lastModifiedBy": "j.azad",
                            "version": 2,
                            "editable": false,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "vessel": {
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
                        "contact": {
                            "nameFA": "SUNGILL RESOURCES LTD",
                            "nameEN": "SUNGILL RESOURCES LTD",
                            "phone": "+852 2575 7591",
                            "fax": "+852 3702 0210",
                            "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
                            "type": false,
                            "status": true,
                            "commercialRole": "Buyer",
                            "buyer": true,
                            "countryId": 2,
                            "id": 41,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1579683563975,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1579935876622,
                            "lastModifiedBy": "dorani_sa",
                            "version": 1
                        },
                        "dischargePort": {
                            "port": "HUANGPU",
                            "countryId": 2,
                            "id": 1,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina",
                                "id": 2,
                                "createdDate": 1595302644624,
                                "createdBy": "j.azad",
                                "lastModifiedDate": 1598846835554,
                                "lastModifiedBy": "db_zare",
                                "version": 1,
                                "editable": true,
                                "estatus": [
                                    "Active"
                                ]
                            },
                            "createdDate": 1578198734058,
                            "createdBy": "dorani_sa",
                            "lastModifiedDate": 1587865832220,
                            "lastModifiedBy": "db_mazloom",
                            "version": 2,
                            "editable": true,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "contactAgent": {
                            "nameFA": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "nameEN": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
                            "phone": "+86-21-54981420",
                            "fax": "+86-358-5489141",
                            "type": false,
                            "status": true,
                            "tradeMark": "SHANGHAI HONGTE ",
                            "commercialRole": "Buyer",
                            "seller": false,
                            "buyer": true,
                            "countryId": 2,
                            "id": 221,
                            "country": {
                                "nameFa": "چین",
                                "nameEn": "FkChina"
                            },
                            "createdDate": 1589587421596,
                            "createdBy": "db_mazloom",
                            "version": 0
                        },
                        "material": {
                            "descl": "Copper Concentrate",
                            "descp": "مس کنسانتره",
                            "code": "26030090",
                            "abbreviation": "CONC",
                            "id": 3,
                            "createdDate": 1595302642815,
                            "createdBy": "liquibase",
                            "version": 6
                        },
                        "shipmentType": {
                            "shipmentType": "فله",
                            "id": 1,
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
                            "loadPortId": 21,
                            "quantity": 6000,
                            "sendDate": "2020-08-02",
                            "tolorance": 790,
                            "contractId": 294,
                            "id": 21,
                            "contract": {
                                "no": "5675643",
                                "date": 1598081400000,
                                "affectFrom": 1598081400000,
                                "affectUpTo": 1598081400000,
                                "content": "<h1>article1</h1>SAMPLE SAMPLE 10 SAMPLE<br><font size=\"7\"><u><i><b>SAMPLE<br></b></i></u></font><div><font size=\"7\"><u><i><b>SAMPLE</b></i></u></font></div><div><font size=\"7\"><u><i><b><br></b></i></u></font></div>",
                                "materialId": 3,
                                "contractTypeId": 1
                            },
                            "loadPort": {
                                "port": "JEBEL ALI",
                                "countryId": 3
                            },
                            "createdDate": 1595402676281,
                            "createdBy": "m.shahabi",
                            "version": 0
                        },
                        "estatus": [
                            "Active"
                        ],
                        "moisture": 0
                    },
                    "creator": {
                        "fullName": "tertert",
                        "jobTitle": "ertertert",
                        "id": 3,
                        "createdDate": 1595330408784,
                        "createdBy": "devadmin",
                        "version": 0
                    },
                    "createdDate": 1598971887027,
                    "createdBy": "m.shahabi",
                    "lastModifiedDate": 1599543162651,
                    "lastModifiedBy": "m.shahabi",
                    "version": 2,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "createdDate": 1598971887483,
                "createdBy": "m.shahabi",
                "version": 0,
                "editable": true,
                "estatus": [
                    "Active"
                ]
            }
        ],
        "billLadings": [
            {
                "documentNo": "9999999999999",
                "switchDocumentNo": "234234234",
                "shipperExporterId": 24,
                "switchShipperExporterId": 24,
                "notifyPartyId": 1,
                "switchNotifyPartyId": 1,
                "consigneeId": 5,
                "switchConsigneeId": 5,
                "portOfLoadingId": 3,
                "switchPortOfLoadingId": 3,
                "portOfDischargeId": 31,
                "switchPortOfDischargeId": 31,
                "placeOfDelivery": "24234234",
                "oceanVesselId": 86,
                "numberOfBlCopies": 1,
                "dateOfIssue": 1599463800000,
                "placeOfIssue": "234234234234",
                "description": "234234234234",
                "totalNet": 1,
                "totalGross": 1,
                "totalBundles": 1,
                "id": 2,
                "shipperExporter": {
                    "nameFA": "ژیائوفنگ",
                    "nameEN": "zhyaofeng",
                    "phone": "8690111111111",
                    "type": false,
                    "bankAccount": "686868",
                    "bankShaba": "IR567575775777556675677777",
                    "bankSwift": "567567567",
                    "status": true,
                    "tradeMark": "ZH-COPPER",
                    "commercialRole": "Agent Seller,Agent Buyer",
                    "seller": false,
                    "buyer": false,
                    "transporter": false,
                    "shipper": false,
                    "inspector": false,
                    "insurancer": false,
                    "agentBuyer": true,
                    "agentSeller": true,
                    "ceo": "linchan",
                    "countryId": 2,
                    "id": 24,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "FkChina"
                    },
                    "createdDate": 1596256929444,
                    "createdBy": "devadmin",
                    "lastModifiedDate": 1598334787441,
                    "lastModifiedBy": "devadmin",
                    "version": 22
                },
                "switchShipperExporter": {
                    "nameFA": "ژیائوفنگ",
                    "nameEN": "zhyaofeng",
                    "phone": "8690111111111",
                    "type": false,
                    "bankAccount": "686868",
                    "bankShaba": "IR567575775777556675677777",
                    "bankSwift": "567567567",
                    "status": true,
                    "tradeMark": "ZH-COPPER",
                    "commercialRole": "Agent Seller,Agent Buyer",
                    "seller": false,
                    "buyer": false,
                    "transporter": false,
                    "shipper": false,
                    "inspector": false,
                    "insurancer": false,
                    "agentBuyer": true,
                    "agentSeller": true,
                    "ceo": "linchan",
                    "countryId": 2,
                    "id": 24,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "FkChina"
                    },
                    "createdDate": 1596256929444,
                    "createdBy": "devadmin",
                    "lastModifiedDate": 1598334787441,
                    "lastModifiedBy": "devadmin",
                    "version": 22
                },
                "notifyParty": {
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
                        "nameEn": "FkChina"
                    },
                    "createdDate": 1578197169411,
                    "createdBy": "dorani_sa",
                    "lastModifiedDate": 1595828067629,
                    "lastModifiedBy": "devadmin",
                    "version": 6
                },
                "switchNotifyParty": {
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
                        "nameEn": "FkChina"
                    },
                    "createdDate": 1578197169411,
                    "createdBy": "dorani_sa",
                    "lastModifiedDate": 1595828067629,
                    "lastModifiedBy": "devadmin",
                    "version": 6
                },
                "consignee": {
                    "nameFA": "بیمه ما",
                    "nameEN": "MA INSURANCE",
                    "phone": "8690",
                    "address": "تهران میدان ونک ابتدای خیابان ونک پلاک 9",
                    "webSite": "WWW.BIMEHMA.COM",
                    "type": true,
                    "status": true,
                    "commercialRole": "Insurancer",
                    "insurancer": true,
                    "countryId": 1,
                    "postalCode": "+234324",
                    "id": 5,
                    "country": {
                        "nameFa": "ایران",
                        "nameEn": "Iran (Islamic Republic of)"
                    },
                    "createdDate": 1579059013188,
                    "createdBy": "dorani_sa",
                    "lastModifiedDate": 1595919615596,
                    "lastModifiedBy": "devadmin",
                    "version": 2
                },
                "switchConsignee": {
                    "nameFA": "بیمه ما",
                    "nameEN": "MA INSURANCE",
                    "phone": "8690",
                    "address": "تهران میدان ونک ابتدای خیابان ونک پلاک 9",
                    "webSite": "WWW.BIMEHMA.COM",
                    "type": true,
                    "status": true,
                    "commercialRole": "Insurancer",
                    "insurancer": true,
                    "countryId": 1,
                    "postalCode": "+234324",
                    "id": 5,
                    "country": {
                        "nameFa": "ایران",
                        "nameEn": "Iran (Islamic Republic of)"
                    },
                    "createdDate": 1579059013188,
                    "createdBy": "dorani_sa",
                    "lastModifiedDate": 1595919615596,
                    "lastModifiedBy": "devadmin",
                    "version": 2
                },
                "portOfLoading": {
                    "port": "SHANGHAI",
                    "countryId": 2,
                    "id": 3,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "FkChina",
                        "id": 2,
                        "createdDate": 1595302644624,
                        "createdBy": "j.azad",
                        "lastModifiedDate": 1598846835554,
                        "lastModifiedBy": "db_zare",
                        "version": 1,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587732958179,
                    "createdBy": "db_mazloom",
                    "lastModifiedDate": 1587865761876,
                    "lastModifiedBy": "db_mazloom",
                    "version": 3,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "switchPortOfLoading": {
                    "port": "SHANGHAI",
                    "countryId": 2,
                    "id": 3,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "FkChina",
                        "id": 2,
                        "createdDate": 1595302644624,
                        "createdBy": "j.azad",
                        "lastModifiedDate": 1598846835554,
                        "lastModifiedBy": "db_zare",
                        "version": 1,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587732958179,
                    "createdBy": "db_mazloom",
                    "lastModifiedDate": 1587865761876,
                    "lastModifiedBy": "db_mazloom",
                    "version": 3,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "portOfDischarge": {
                    "port": "ABU DHABI",
                    "countryId": 3,
                    "id": 31,
                    "country": {
                        "nameFa": "افغانستان",
                        "nameEn": "Afghanistan",
                        "id": 3,
                        "createdDate": 1595302644625,
                        "createdBy": "j.azad",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587866317999,
                    "createdBy": "db_mazloom",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "switchPortOfDischarge": {
                    "port": "ABU DHABI",
                    "countryId": 3,
                    "id": 31,
                    "country": {
                        "nameFa": "افغانستان",
                        "nameEn": "Afghanistan",
                        "id": 3,
                        "createdDate": 1595302644625,
                        "createdBy": "j.azad",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587866317999,
                    "createdBy": "db_mazloom",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "oceanVessel": {
                    "name": "ADMIRAL GLOBE",
                    "type": "Bulk Carrier",
                    "imo": "9290945",
                    "yearOfBuild": 2004,
                    "length": 276,
                    "beam": 40,
                    "id": 86,
                    "createdDate": 1588389673493,
                    "createdBy": "db_mazloom",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "containers": [
                    {
                        "billOfLandingId": 2,
                        "containerType": "a",
                        "containerNo": "s",
                        "sealNo": "d",
                        "quantity": 123,
                        "quantityType": "123",
                        "weight": 123,
                        "unitId": -11,
                        "id": 2,
                        "unit": {
                            "nameFA": "کیلوگرم",
                            "nameEN": "kilogramme",
                            "categoryUnit": "Weight",
                            "id": -11,
                            "createdDate": 1593755140056,
                            "createdBy": "j.azad",
                            "lastModifiedDate": 1594440292826,
                            "lastModifiedBy": "j.azad",
                            "version": 2,
                            "editable": false,
                            "estatus": [
                                "Active"
                            ]
                        },
                        "createdDate": 1596366825909,
                        "createdBy": "db_saeb",
                        "lastModifiedDate": 1596367028720,
                        "lastModifiedBy": "db_saeb",
                        "version": 1,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    }
                ],
                "createdDate": 1596272394781,
                "createdBy": "db_saeb",
                "lastModifiedDate": 1599451551217,
                "lastModifiedBy": "devadmin",
                "version": 7,
                "editable": true,
                "estatus": [
                    "Active"
                ],
                "_selection_205": true,
                "_embeddedComponents_isc_ListGrid_11": null
            }
        ],
        "toCurrencyId": -33,
        "contractId": 294,
        "remittanceDetailId": [
            42,
            43,
            152
        ]
    });
    foreignInvoiceTab.variable.method = "PUT";
    foreignInvoiceTab.window.main.show();
    return;

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

                                let itemValue = JSON.parse(itemResp.httpResponseText).response.data[0];
                                foreignInvoiceTab.method.jsonRPCManagerRequest({
                                    httpMethod: "GET",
                                    actionURL: foreignInvoiceTab.variable.foreignInvoiceItemDetailUrl + "spec-list",
                                    params: {
                                        criteria: {
                                            operator: "and",
                                            criteria: [{
                                                fieldName: "foreignInvoiceItemId",
                                                operator: "equals",
                                                value: itemValue.id
                                            }]
                                        }
                                    },
                                    callback: function (itemDetailResp) {

                                        let itemDetailValues = JSON.parse(itemDetailResp.httpResponseText).response.data;

                                        let rcRowData = [];
                                        let calculationRowData = [];
                                        itemDetailValues.forEach(detail => {

                                            calculationRowData.add({
                                                foreignInvoiceItemId: itemValue.id,
                                                materialElementId: detail.materialElementId,
                                                deductionValue: detail.deductionValue,
                                                deductionType: detail.deductionType,
                                                deductionUnitConversionRate: detail.deductionUnitConversionRate
                                            });
                                            rcRowData.add({
                                                foreignInvoiceItemId: itemValue.id,
                                                materialElementId: detail.materialElementId,
                                                rcUnitConversionRate: detail.rcUnitConversionRate
                                            });
                                        });

                                        foreignInvoiceTab.variable.method = "PUT";
                                        let paymentValues = JSON.parse(paymentResp.httpResponseText).response.data;
                                        let billOfLadingValues = JSON.parse(billOfLadingResp.httpResponseText).response.data;

                                        foreignInvoiceTab.dynamicForm.valuesManager.clearValues();
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValues(record);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("rcDeductionData", rcRowData);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("calculationData", calculationRowData);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("payments", paymentValues);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue('assayMilestone', itemValue.assayMilestone);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue('weightMilestone', itemValue.weightMilestone);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("billLadings", billOfLadingValues.map(q => q.billOfLanding));
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("date", new Date(record.date));
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("toCurrencyId", record.conversionRef.unitToId);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("contractId", record.shipment.contractShipment.contractId);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("remittanceDetailId", itemValue.remittanceDetailId);

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
}];
