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
    }, ,
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
            fieldName: "contractTypeId",
            operator: "equals",
            value: ImportantIDs.contractType.Primary
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
                fieldName: "contractShipment.contractId",
                operator: "equals",
                value: selectedRecord.id
            });
            shipmentIdField.enable();
            shipmentIdField.changed(form, shipmentIdField, null);
        }
    },
    {
        required: true,
        disabled: true,
        multiple: true,
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
        name: "remittanceDetailId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "inventory.label",
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

// foreignInvoiceTab.restDataSource.foreignInvoiceItem = isc.MyRestDataSource.create({
//     fields: BaseFormItems.concat([]),
//     fetchDataURL: foreignInvoiceTab.variable.foreignInvoiceItemUrl + "spec-list"
// });
// foreignInvoiceTab.restDataSource.foreignInvoicePayment = isc.MyRestDataSource.create({
//     fields: BaseFormItems.concat([]),
//     fetchDataURL: foreignInvoiceTab.variable.foreignInvoicePaymentUrl + "spec-list"
// });
// foreignInvoiceTab.restDataSource.foreignInvoiceItemDetail = isc.MyRestDataSource.create({
//     fields: BaseFormItems.concat([]),
//     fetchDataURL: foreignInvoiceTab.variable.foreignInvoiceItemDetailUrl + "spec-list"
// });

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
}
foreignInvoiceTab.button.save = isc.IButtonSave.create({
    margin: 10,
    height: 50,
    icon: "pieces/16/save.png",
    title: "<spring:message code='global.form.save'/>",
    click: function () {

        foreignInvoiceTab.dynamicForm.valuesManager.validate();
        if (foreignInvoiceTab.dynamicForm.valuesManager.hasErrors()) return;

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

        if (foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract').materialId === ImportantIDs.material.MOLYBDENUM_OXIDE) {

            // foreignInvoiceTab.method.addTab(isc.InvoiceCalculation2.create({}), '<spring:message code="foreign-invoice.form.tab.calculation"/>');
            // foreignInvoiceTab.method.addTab(
            //     isc.InvoicePayment.create({
            //         currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
            //         contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
            //         shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
            //         inventories: [{id: 1}, {id: 2}]
            //     }), '<spring:message code="foreign-invoice.form.tab.payment"/>');
        } else {
            let invoiceBaseValuesComponent = isc.InvoiceBaseValues.create({
                currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
                contractDetailData: foreignInvoiceTab.variable.contractDetailData,
                shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue("invoiceType"),
                remittanceDetails: foreignInvoiceTab.dynamicForm.valuesManager.getValue("remittanceDetails")
            });
            foreignInvoiceTab.method.addTab(invoiceBaseValuesComponent, '<spring:message code="foreign-invoice.form.tab.base-values"/>');

            invoiceBaseValuesComponent.okButtonClick = function () {

                let invoiceCalculationComponent = isc.InvoiceCalculation.create({

                    currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                    invoiceBaseAssayComponent: invoiceBaseValuesComponent.invoiceBaseAssayComponent,
                    invoiceBasePriceComponent: invoiceBaseValuesComponent.invoiceBasePriceComponent
                });
                foreignInvoiceTab.method.addTab(invoiceCalculationComponent, '<spring:message code="foreign-invoice.form.tab.calculation"/>');

                invoiceCalculationComponent.okButtonClick = function addRelatedDeductionTab() {

                    let invoiceDeductionComponent = isc.InvoiceDeduction.create({
                        invoiceCalculationComponent: invoiceCalculationComponent,
                        contractDetailData: foreignInvoiceTab.variable.contractDetailData,
                        currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue('currency')
                    });
                    foreignInvoiceTab.method.addTab(invoiceDeductionComponent, '<spring:message code="foreign-invoice.form.tab.deduction"/>');

                    invoiceDeductionComponent.okButtonClick = function addRelatedPaymentTab() {

                        let invoicePaymentComponent = isc.InvoicePayment.create({
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
            }        }

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
    }, (resp) => foreignInvoiceTab.listGrid.main.invalidateCache());
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

    data.billLadingIds = data.billLadings.map(q => q.id);
    data.buyerId = data.contract.contractContacts.filter(q => q.commercialRole === JSON.parse('${Enum_CommercialRole}').Buyer).first().contactId;

    let paymentComponentValues = invoicePaymentComponent.pane.getValues();
    data.unitCost = paymentComponentValues.unitCost.getValues().value;
    data.unitPrice = paymentComponentValues.unitPrice.getValues().value;
    data.sumPrice = paymentComponentValues.sumPrice.getValues().value;
    data.sumFIPrice = paymentComponentValues.sumFIPrice.getValues().value;
    data.conversionSumPrice = paymentComponentValues.conversionSumPrice.getValues().value;
    data.conversionSumPriceText = paymentComponentValues.conversionSumPriceText.getValues().value;
    data.sumPIPrice = data.sumFIPrice - data.sumPrice;
    data.foreignInvoicePayment = paymentComponentValues.shipmentCostInvoices;

    data.foreignInvoiceItems = [];

    delete data.contract;
    delete data.conversionRef;
    delete data.currency;
    delete data.billLadings;
    delete data.invoiceType;
    delete data.shipment;

    console.log(data);

    // private ForeignInvoicePaymentDTO.Create foreignInvoicePayment;
    // private List<ForeignInvoiceItemDTO.Create> foreignInvoiceItems;

    // data.basePrice = invoiceBasePriceComponent.getValues();
    // foreignInvoiceTab.dynamicForm.valuesManager.setValue("baseWeight", invoiceBaseWeightComponent.getValues());
    // foreignInvoiceTab.dynamicForm.valuesManager.setValue("baseAssay", invoiceBaseAssayComponent.getValues());
    // foreignInvoiceTab.dynamicForm.valuesManager.setValue("calculation", invoiceCalculationComponent.pane.getValues());
    // foreignInvoiceTab.dynamicForm.valuesManager.setValue("deduction", invoiceDeductionComponent.pane.getValues());

    return data;
};

foreignInvoiceTab.variable.invoiceForm.init(null, '<spring:message code="entity.foreign-invoice"/>', foreignInvoiceTab.tab.invoice, "70%");

nicico.BasicFormUtil.getDefaultBasicForm(foreignInvoiceTab, "api/foreign-invoice/");
foreignInvoiceTab.dynamicForm.main = null;

//*************************************************** Functions ********************************************************

foreignInvoiceTab.method.newForm = function () {

    foreignInvoiceTab.variable.method = "POST";
    foreignInvoiceTab.dynamicForm.valuesManager.clearValues();
    foreignInvoiceTab.dynamicForm.valuesManager.clearErrors();
    foreignInvoiceTab.tab.invoice.removeTabs(foreignInvoiceTab.tab.invoice.tabs);
    foreignInvoiceTab.dynamicForm.baseData.getFields().forEach(field => {
        if (!field.changed) return;
        field.changed(foreignInvoiceTab.dynamicForm.baseData, field, field.getValue());
    });

    foreignInvoiceTab.dynamicForm.valuesManager.setValues({
        "date": "2020-08-22T07:30:00.000Z",
        "billLadings": [
            {
                "documentNo": "حالا۱۲۳حالا بیخیال غصه",
                "switchDocumentNo": "حالا۱۲۳حالا بیخیال غصه",
                "shipperExporterId": 2058,
                "switchShipperExporterId": 2058,
                "notifyPartyId": 24,
                "switchNotifyPartyId": 24,
                "consigneeId": 2058,
                "switchConsigneeId": 2058,
                "portOfLoadingId": 30,
                "switchPortOfLoadingId": 30,
                "portOfDischargeId": 3,
                "switchPortOfDischargeId": 3,
                "placeOfDelivery": "12",
                "oceanVesselId": 32,
                "numberOfBlCopies": 12,
                "dateOfIssue": 1597735800000,
                "placeOfIssue": "12",
                "description": "12",
                "totalNet": 12,
                "totalGross": 12,
                "totalBundles": 12,
                "id": 62,
                "shipperExporter": {
                    "nameFA": "لاکی هرایزن لیمیتد",
                    "nameEN": "LUCKY HORIZEN LIMITED",
                    "phone": "+862156237847",
                    "address": "RM 19C LOCKHART CTR 301-307",
                    "type": true,
                    "status": true,
                    "commercialRole": "Seller",
                    "seller": true,
                    "buyer": false,
                    "countryId": 1,
                    "id": 2058,
                    "country": {
                        "nameFa": "ایران",
                        "nameEn": "Iran (Islamic Republic of)"
                    },
                    "createdDate": 1597293065534,
                    "createdBy": "r.mazloom",
                    "lastModifiedDate": 1597293674270,
                    "lastModifiedBy": "r.mazloom",
                    "version": 3
                },
                "switchShipperExporter": {
                    "nameFA": "لاکی هرایزن لیمیتد",
                    "nameEN": "LUCKY HORIZEN LIMITED",
                    "phone": "+862156237847",
                    "address": "RM 19C LOCKHART CTR 301-307",
                    "type": true,
                    "status": true,
                    "commercialRole": "Seller",
                    "seller": true,
                    "buyer": false,
                    "countryId": 1,
                    "id": 2058,
                    "country": {
                        "nameFa": "ایران",
                        "nameEn": "Iran (Islamic Republic of)"
                    },
                    "createdDate": 1597293065534,
                    "createdBy": "r.mazloom",
                    "lastModifiedDate": 1597293674270,
                    "lastModifiedBy": "r.mazloom",
                    "version": 3
                },
                "notifyParty": {
                    "nameFA": "ژیائوفنگ",
                    "nameEN": "zhyaofeng",
                    "phone": "8690",
                    "type": false,
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
                        "nameEn": "China"
                    },
                    "createdDate": 1596256929444,
                    "createdBy": "devadmin",
                    "lastModifiedDate": 1597640650586,
                    "lastModifiedBy": "devadmin",
                    "version": 9
                },
                "switchNotifyParty": {
                    "nameFA": "ژیائوفنگ",
                    "nameEN": "zhyaofeng",
                    "phone": "8690",
                    "type": false,
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
                        "nameEn": "China"
                    },
                    "createdDate": 1596256929444,
                    "createdBy": "devadmin",
                    "lastModifiedDate": 1597640650586,
                    "lastModifiedBy": "devadmin",
                    "version": 9
                },
                "consignee": {
                    "nameFA": "لاکی هرایزن لیمیتد",
                    "nameEN": "LUCKY HORIZEN LIMITED",
                    "phone": "+862156237847",
                    "address": "RM 19C LOCKHART CTR 301-307",
                    "type": true,
                    "status": true,
                    "commercialRole": "Seller",
                    "seller": true,
                    "buyer": false,
                    "countryId": 1,
                    "id": 2058,
                    "country": {
                        "nameFa": "ایران",
                        "nameEn": "Iran (Islamic Republic of)"
                    },
                    "createdDate": 1597293065534,
                    "createdBy": "r.mazloom",
                    "lastModifiedDate": 1597293674270,
                    "lastModifiedBy": "r.mazloom",
                    "version": 3
                },
                "switchConsignee": {
                    "nameFA": "لاکی هرایزن لیمیتد",
                    "nameEN": "LUCKY HORIZEN LIMITED",
                    "phone": "+862156237847",
                    "address": "RM 19C LOCKHART CTR 301-307",
                    "type": true,
                    "status": true,
                    "commercialRole": "Seller",
                    "seller": true,
                    "buyer": false,
                    "countryId": 1,
                    "id": 2058,
                    "country": {
                        "nameFa": "ایران",
                        "nameEn": "Iran (Islamic Republic of)"
                    },
                    "createdDate": 1597293065534,
                    "createdBy": "r.mazloom",
                    "lastModifiedDate": 1597293674270,
                    "lastModifiedBy": "r.mazloom",
                    "version": 3
                },
                "portOfLoading": {
                    "port": "ZHOUSHAN",
                    "countryId": 2,
                    "id": 30,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China",
                        "id": 2,
                        "createdDate": 1595302644624,
                        "createdBy": "j.azad",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587866229644,
                    "createdBy": "db_mazloom",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "switchPortOfLoading": {
                    "port": "ZHOUSHAN",
                    "countryId": 2,
                    "id": 30,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China",
                        "id": 2,
                        "createdDate": 1595302644624,
                        "createdBy": "j.azad",
                        "version": 0,
                        "editable": true,
                        "estatus": [
                            "Active"
                        ]
                    },
                    "createdDate": 1587866229644,
                    "createdBy": "db_mazloom",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "portOfDischarge": {
                    "port": "SHANGHAI",
                    "countryId": 2,
                    "id": 3,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China",
                        "id": 2,
                        "createdDate": 1595302644624,
                        "createdBy": "j.azad",
                        "version": 0,
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
                "switchPortOfDischarge": {
                    "port": "SHANGHAI",
                    "countryId": 2,
                    "id": 3,
                    "country": {
                        "nameFa": "چین",
                        "nameEn": "China",
                        "id": 2,
                        "createdDate": 1595302644624,
                        "createdBy": "j.azad",
                        "version": 0,
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
                "oceanVessel": {
                    "name": "SEA TOPAZ",
                    "type": "Bulk Carrier",
                    "imo": "9557240",
                    "yearOfBuild": 2010,
                    "length": 177.4,
                    "beam": 28.2,
                    "id": 32,
                    "createdDate": 1588382222492,
                    "createdBy": "db_mazloom",
                    "version": 0,
                    "editable": true,
                    "estatus": [
                        "Active"
                    ]
                },
                "containers": [],
                "createdDate": 1597726005093,
                "createdBy": "db_saeb",
                "version": 0,
                "editable": true,
                "estatus": [
                    "Active"
                ],
                "_selection_108": true
            }
        ],
        "toCurrencyId": -33,
        "conversionRefId": 124,
        "invoiceTypeId": 1,
        "contractId": 294,
        "shipmentId": 73,
        "creatorId": 2,
        "currencyId": -32,
        "description": "This is test"
    });

    foreignInvoiceTab.dynamicForm.baseData.redraw();
    foreignInvoiceTab.window.main.show();
};

foreignInvoiceTab.method.editForm = function () {

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

        foreignInvoiceTab.variable.method = "PUT";
        foreignInvoiceTab.dynamicForm.valuesManager.clearValues();
        foreignInvoiceTab.dynamicForm.valuesManager.editRecord(record);
        foreignInvoiceTab.dynamicForm.baseData.getFields().forEach(field => {
            if (!field.changed) return;
            field.changed(foreignInvoiceTab.dynamicForm.baseData, field, field.getValue());
        });

        foreignInvoiceTab.window.main.show();
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
