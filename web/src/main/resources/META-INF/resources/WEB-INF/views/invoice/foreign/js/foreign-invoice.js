var foreignInvoiceTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

foreignInvoiceTab.variable.contractDetailData = {};
foreignInvoiceTab.variable.invoiceForm = new nicico.FormUtil();
foreignInvoiceTab.variable.selectBillLadingForm = new nicico.FindFormUtil();

foreignInvoiceTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/";
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
        name: "buyer.nameFA",
        title: "<spring:message code='foreign-invoice.form.buyer'/>"
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
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {
                    name: "no",
                    title: "<spring:message code='foreign-invoice.form.contract'/>"
                },
                {name: "description", title: "<spring:message code='global.description'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.contractUrl + "spec-list" /*nadarim*/
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

            if (!selectedRecord) {

                shipmentIdField.disable();
                return;
            }

            shipmentIdField.setOptionCriteria({
                fieldName: "contractShipment.contractId",
                operator: "equals",
                value: selectedRecord.id
            });
            shipmentIdField.enable();
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
        displayField: "month",
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "contact.nameFA", title: "<spring:message code='foreign-invoice.form.shipment'/>"},
            {name: "material.descl", title: "<spring:message code='material.descl'/>"},
            {name: "amount", title: "<spring:message code='global.amount'/>"},
            {name: "loadingLetter", title: "<spring:message code='shipment.loadingLetter'/>"},
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "contact.nameFA", title: "<spring:message code='foreign-invoice.form.shipment'/>"},
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
        // changed: function (form, item, value) {
        //
        //     let selectedRecord = item.getSelectedRecord();
        //     if (!selectedRecord) {
        //
        //         foreignInvoiceTab.button.selectBillLading.disable();
        //         foreignInvoiceTab.button.selectBillLading.criteria = null;
        //         return;
        //     }
        //
        //     foreignInvoiceTab.button.selectBillLading.enable();
        //     foreignInvoiceTab.button.selectBillLading.criteria = {
        //         operator: "equals",
        //         fieldName: "shipmentId",
        //         value: selectedRecord.id
        //     };
        // }
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
        displayField: "nameFA",
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
                {name: "nameFA", title: "<spring:message code='global.title'/>"},
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

            if (!value) {

                form.setValue("toCurrencyId", null);
                form.getField("toCurrencyId").disable();
                return;
            }

            form.setValue("toCurrencyId", null);
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
        displayField: "nameFA",
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
                {name: "nameFA", title: "<spring:message code='global.title'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.unitUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.to.currency'/>",
        wrapTitle: false,
        changed: function (form, item, value) {

            if (!value || !form.getValue("currencyId")) {

                form.setValue("conversionRefId", null);
                form.getField("conversionRefId").disable();
                return;
            }

            if (form.getValue("currencyId") === form.getValue("toCurrencyId")) {

                form.setValue("toCurrencyId", null);
                form.setValue("conversionRefId", null);
                form.getField("conversionRefId").disable();

            } else {

                form.getField("conversionRefId").enable();
                form.getField("conversionRefId").setOptionCriteria({
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria:
                        [
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
        pickListWidth: 370,
        pickListHeight: 300,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
            {name: "currencyDate", title: "<spring:message code='global.date'/>"},
            {name: "unitFrom.nameFA", title: "<spring:message code='global.from'/>"},
            {name: "unitTo.nameFA", title: "<spring:message code='global.to'/>"},
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
foreignInvoiceTab.button.save = isc.IButtonSave.create({
    margin: 10,
    height: 50,
    icon: "pieces/16/save.png",
    title: "<spring:message code='global.form.save'/>",
    click: function () {
        foreignInvoiceTab.dynamicForm.baseData.validate();
        if (foreignInvoiceTab.dynamicForm.baseData.hasErrors()) {
            return;
        }

        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'currency',
            foreignInvoiceTab.dynamicForm.baseData.getField('currencyId').getSelectedRecord());
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'invoiceType',
            foreignInvoiceTab.dynamicForm.baseData.getField('invoiceTypeId').getSelectedRecord());
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'contract',
            foreignInvoiceTab.dynamicForm.baseData.getField('contractId').getSelectedRecord());
        foreignInvoiceTab.dynamicForm.valuesManager.setValue(
            'shipment',
            foreignInvoiceTab.dynamicForm.baseData.getField('shipmentId').getSelectedRecord());

        foreignInvoiceTab.method.addTab(
            isc.InvoiceBaseInfo.create({
                invoiceNo: foreignInvoiceTab.dynamicForm.valuesManager.getValue('no'),
                invoiceDate: foreignInvoiceTab.dynamicForm.valuesManager.getValue('date'),
                contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract'),
                billLadings: foreignInvoiceTab.dynamicForm.valuesManager.getValue('billLadings'),
                invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue('invoiceType'),
            }), '<spring:message code="foreign-invoice.form.tab.contract-info"/>');

        if (foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract').materialId === ImportantIDs.material.MOLYBDENUM_OXIDE) {

            foreignInvoiceTab.method.addTab(isc.InvoiceCalculation2.create({}), '<spring:message code="foreign-invoice.form.tab.calculation"/>');
            foreignInvoiceTab.method.addTab(
                isc.InvoicePayment.create({
                    currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                    contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
                    shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                    inventories: [{id: 1}, {id: 2}]
                }), '<spring:message code="foreign-invoice.form.tab.payment"/>');
        } else {
            let invoiceBaseValuesComponent = isc.InvoiceBaseValues.create({
                currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
                contractDetailData: foreignInvoiceTab.variable.contractDetailData,
                shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue("invoiceType")
            });
            foreignInvoiceTab.method.addTab(invoiceBaseValuesComponent, '<spring:message code="foreign-invoice.form.tab.base-values"/>');

            // let invoiceDeductionComponent = isc.InvoiceDeduction.create({
            //     invoiceCalculationComponent: invoiceCalculationComponent,
            //     currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue('currency'),
            //     contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract')
            // });
            // foreignInvoiceTab.method.addTab(invoiceDeductionComponent, '<spring:message code="foreign-invoice.form.tab.deduction"/>');

            // let invoiceCalculationComponent = isc.InvoiceCalculation.create({
            //
            //     currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
            //     invoiceBaseAssayComponent: invoiceBaseValuesComponent.invoiceBaseAssayComponent,
            //     invoiceBasePriceComponent: invoiceBaseValuesComponent.invoiceBasePriceComponent
            // });
            //  foreignInvoiceTab.method.addTab(invoiceCalculationComponent, '<spring:message code="foreign-invoice.form.tab.calculation"/>');

            // foreignInvoiceTab.method.addTab(isc.InvoicePayment.create({
            //     currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
            //     contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
            //     invoiceDeductionComponent: invoiceDeductionComponent,
            //     invoiceCalculationComponent: invoiceCalculationComponent,
            //     invoiceBaseWeightComponent: invoiceBaseValuesComponent.invoiceBaseWeightComponent
            // }), '<spring:message code="foreign-invoice.form.tab.payment"/>');
        }

        foreignInvoiceTab.window.main.close();
        foreignInvoiceTab.variable.invoiceForm.justShowForm();
    },
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
    // criteria: null,
    // disabled: true,
    icon: "pieces/16/icon_add.png",
    title: "<spring:message code='foreign-invoice.form.button.select.bill-lading'/>",
    click: function () {

        foreignInvoiceTab.variable.selectBillLadingForm.showFindFormByRestApiUrl(
            foreignInvoiceTab.window.main,
            "600", "500", "billLading", null,
            foreignInvoiceTab.variable.billLadingUrl + "spec-list",
            [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "documentNo", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
                {name: "shipperExporter.nameFA", title: "<spring:message code='global.date'/>"},
                {name: "notifyParty.nameFA", title: "<spring:message code='global.from'/>"},
                {name: "consignee.nameFA", title: "<spring:message code='global.to'/>"},
                {name: "portOfLoading.port", title: "<spring:message code='rate.title'/>"},
                {name: "portOfDischarge.port", title: "<spring:message code='rate.title'/>"},
                {name: "placeOfDelivery", title: "<spring:message code='rate.title'/>"},
                {name: "oceanVessel.name", title: "<spring:message code='rate.title'/>"},
            ],
            null, null /*this.criteria*/, Number.MAX_VALUE);
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
], "500");

foreignInvoiceTab.tab.invoice = isc.TabSet.create({

    width: "100%",
    height: "500",
    autoDraw: true,
    showEdges: false,
    edgeMarginSize: 3,
    tabBarThickness: 300,
    tabBarPosition: "left",
    // tabBarControls: [],
    // tabs: []
});

foreignInvoiceTab.variable.invoiceForm.validate = function (data) {
    foreignInvoiceTab.dynamicForm.valuesManager.validate();
    return !foreignInvoiceTab.dynamicForm.valuesManager.hasErrors();
};

foreignInvoiceTab.variable.invoiceForm.okCallBack = function (data) {
    foreignInvoiceTab.method.jsonRPCManagerRequest({
        data: data
    });
};

foreignInvoiceTab.variable.invoiceForm.populateData = function (bodyWidget) {
    foreignInvoiceTab.dynamicForm.valuesManager.getValues();
};

foreignInvoiceTab.variable.invoiceForm.init(null, '<spring:message code="entity.foreign-invoice"/>', foreignInvoiceTab.tab.invoice, "50%");

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


    foreignInvoiceTab.dynamicForm.baseData.setValues({
        "date": "2020-08-18T07:30:00.000Z",
        "invoiceTypeId": 1,
        "contractId": 218,
        "shipmentId": 76,
        "creatorId": 2,
        "currencyId": -32,
        "toCurrencyId": -33,
        "conversionRefId": 124
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