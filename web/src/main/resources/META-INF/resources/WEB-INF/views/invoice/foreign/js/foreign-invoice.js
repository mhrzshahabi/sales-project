var foreignInvoiceTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

foreignInvoiceTab.window.invoice = new nicico.FormUtil();
foreignInvoiceTab.window.selectBillLading = new nicico.FindFormUtil();

foreignInvoiceTab.variable.contractUrl = __contract.url;
foreignInvoiceTab.variable.personUrl = "${contextPath}" + "/api/person/";
foreignInvoiceTab.variable.shipmentUrl = "${contextPath}" + "/api/shipment/";
foreignInvoiceTab.variable.currencyUrl = "${contextPath}" + "/api/currency/";
foreignInvoiceTab.variable.invoiceTypeUrl = "${contextPath}" + "/api/invoicetype/";
foreignInvoiceTab.variable.materialItemUrl = "${contextPath}" + "/api/materialItem/";
foreignInvoiceTab.variable.conversionRefUrl = "${contextPath}" + "/api/currencyRate/";
foreignInvoiceTab.variable.foreignInvoiceUrl = "${contextPath}" + "/api/foreign-invoice/";
foreignInvoiceTab.variable.foreignInvoiceItemUrl = "${contextPath}" + "/api/foreign-invoice-item/";
foreignInvoiceTab.variable.foreignInvoicePaymentUrl = "${contextPath}" + "/api/foreign-invoice-payment/";
foreignInvoiceTab.variable.foreignInvoiceItemDetailUrl = "${contextPath}" + "/api/foreign-invoice-item-detail/";

foreignInvoiceTab.variable.billLadingUrl = "${contextPath}" + "/api/bill-lading/";

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
        name: "materialItem.gdsName",
        title: "<spring:message code='foreign-invoice.form.material-item'/>"
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
        name: __contract.nameOfNumberProperty,
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
        title: "<spring:message code='foreign-invoice.form.date'/>"
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
                {name: "title", title: "<spring:message code='global.title'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.invoiceTypeUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.invoice-type'/>"
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
                {name: "no", title: "<spring:message code='foreign-invoice.form.contract'/>"},
                {name: "description", title: "<spring:message code='global.description'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.contractUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.contract'/>",
        changed: function (form, item, value) {

            let materialItemIdField = form.getField("materialItemId");
            let selectedRecord = item.getSelectedRecord();
            materialItemIdField.setOptionCriteria({
                fieldName: "materialId",
                operator: "equals",
                value: selectedRecord.materialId
            });
            materialItemIdField.enable();

            let shipmentIdField = form.getField("shipmentId");
            shipmentIdField.setOptionCriteria({
                fieldName: "contractId",
                operator: "equals",
                value: selectedRecord.id
            });
            shipmentIdField.enable();
        }
    },
    {
        width: "100%",
        type: "integer",
        required: true,
        readonly: true,
        disabled: true,
        name: "materialItemId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "gdsName",
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "gdsName", title: "<spring:message code='global.title'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.materialItemUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.material-item'/>"
    },
    {
        required: true,
        type: "integer",
        name: "currencyId",
        editorType: "SelectItem",
        width: "100%",
        valueField: "id",
        displayField: "nameEn",
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "nameEn", title: "<spring:message code='global.title'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.currencyUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.currency'/>",
        changed: function (form, item, value) {

            form.setValue("toCurrencyId", null);
        }
    },
    {
        type: "integer",
        name: "toCurrencyId",
        editorType: "SelectItem",
        width: "100%",
        valueField: "id",
        displayField: "nameEn",
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "nameEn", title: "<spring:message code='global.title'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.currencyUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.to.currency'/>",
        changed: function (form, item, value) {

            if (!value || !form.getValue("currencyId")) return;
            if (form.getValue("currencyId") === form.getValue("toCurrencyId")) {

                form.setValue("toCurrencyId", null);
                form.setValue("conversionRefId", null);
            }
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
        title: "<spring:message code='foreign-invoice.form.creator'/>"
    },
    {
        readonly: true,
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
            {name: "date", title: "<spring:message code='global.date'/>"},
            {name: "fromCurrency", title: "<spring:message code='global.from'/>"},
            {name: "toCurrency", title: "<spring:message code='global.to'/>"},
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
                {name: "date", title: "<spring:message code='global.date'/>"},
                {name: "fromCurrency", title: "<spring:message code='global.from'/>"},
                {name: "toCurrency", title: "<spring:message code='global.to'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.conversionRefUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"
    },
    {
        disabled: true,
        readonly: true,
        width: "100%",
        type: "integer",
        name: "shipmentId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "month",
        pickListWidth: 370,
        pickListHeight: 300,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "month", title: "<spring:message code='foreign-invoice.form.shipment'/>"},
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "month", title: "<spring:message code='foreign-invoice.form.shipment'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.shipmentUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.shipment'/>",
        changed: function (form, item, value) {

            let selectedRecord = item.getSelectedRecord();
            foreignInvoiceTab.button.selectBillLading.enable();
            foreignInvoiceTab.button.selectBillLading.criteria = {
                operator: "equals",
                fieldName: "shipmentId",
                value: selectedRecord.id
            };
        }
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
    titleAlign: "right",
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
        if (foreignInvoiceTab.dynamicForm.baseData.hasErrors())
            return;

        foreignInvoiceTab.window.main.close();
        foreignInvoiceTab.window.invoice.justShowForm();
    }
});
foreignInvoiceTab.button.cancel = isc.IButtonCancel.create({

    margin: 10,
    height: 50,
    icon: "pieces/16/icon_delete.png",
    title: "<spring:message code='global.cancel'/>",
    click: function () {
        foreignInvoiceTab.window.main.close();
    }
});
foreignInvoiceTab.window.selectBillLading.validate = function (selectedRecords) {
    return !selectedRecords;
};
foreignInvoiceTab.window.selectBillLading.okCallBack = function (selectedRecords) {
    foreignInvoiceTab.dynamicForm.valuesManager.values.billLadings = selectedRecords;
};
foreignInvoiceTab.button.selectBillLading = isc.IButtonSave.create({

    width: 150,
    margin: 10,
    height: 50,
    criteria: null,
    disabled: true,
    icon: "pieces/16/icon_add.png",
    title: "<spring:message code='foreign-invoice.form.button.select.bill-lading'/>",
    click: function () {

        foreignInvoiceTab.window.selectBillLading.showFindFormByRestApiUrl(
            foreignInvoiceTab.window.invoice, "600", "500", "", null,
            foreignInvoiceTab.variable.billLadingUrl + "spec-list",
            [],
            null, this.criteria, 1);
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

foreignInvoiceTab.tab.pane = {};

foreignInvoiceTab.dynamicForm.payment = {};
foreignInvoiceTab.dynamicForm.payment.fields = BaseFormItems.concat([]);
foreignInvoiceTab.dynamicForm.payment = isc.DynamicForm.create({

    width: "100%",
    align: "center",
    titleAlign: "right",
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    fields: this.fields,
    valuesManager: foreignInvoiceTab.dynamicForm.valuesManager,
    requiredMessage: '<spring:message code="validator.field.is.required"/>'
});
foreignInvoiceTab.tab.pane.payment = isc.VLayout.create({

    align: "top",
    width: "100%",
    showEdges: false,
    layoutMargin: 10,
    membersMargin: 5,
    members: [foreignInvoiceTab.dynamicForm.payment]
});

foreignInvoiceTab.dynamicForm.deduction = {};
foreignInvoiceTab.dynamicForm.deduction.fields = BaseFormItems.concat([]);
foreignInvoiceTab.dynamicForm.deduction = isc.DynamicForm.create({

    width: "100%",
    align: "center",
    titleAlign: "right",
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    fields: this.fields,
    valuesManager: foreignInvoiceTab.dynamicForm.valuesManager,
    requiredMessage: '<spring:message code="validator.field.is.required"/>'
});
foreignInvoiceTab.tab.pane.deduction = isc.VLayout.create({

    align: "top",
    width: "100%",
    showEdges: false,
    layoutMargin: 10,
    membersMargin: 5,
    members: [foreignInvoiceTab.dynamicForm.deduction]
});

foreignInvoiceTab.dynamicForm.baseValues = {};
foreignInvoiceTab.dynamicForm.baseValues.fields = BaseFormItems.concat([]);
foreignInvoiceTab.dynamicForm.baseValues = isc.DynamicForm.create({

    width: "100%",
    align: "center",
    titleAlign: "right",
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    fields: this.fields,
    valuesManager: foreignInvoiceTab.dynamicForm.valuesManager,
    requiredMessage: '<spring:message code="validator.field.is.required"/>'
});
foreignInvoiceTab.tab.pane.baseValues = isc.VLayout.create({

    align: "top",
    width: "100%",
    showEdges: false,
    layoutMargin: 10,
    membersMargin: 5,
    members: [foreignInvoiceTab.dynamicForm.baseValues]
});

foreignInvoiceTab.dynamicForm.calculation = {};
foreignInvoiceTab.dynamicForm.calculation.fields = BaseFormItems.concat([]);
foreignInvoiceTab.dynamicForm.calculation = isc.DynamicForm.create({

    width: "100%",
    align: "center",
    titleAlign: "right",
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    fields: this.fields,
    valuesManager: foreignInvoiceTab.dynamicForm.valuesManager,
    requiredMessage: '<spring:message code="validator.field.is.required"/>'
});
foreignInvoiceTab.tab.pane.calculation = isc.VLayout.create({

    align: "top",
    width: "100%",
    showEdges: false,
    layoutMargin: 10,
    membersMargin: 5,
    members: [foreignInvoiceTab.dynamicForm.calculation]
});

foreignInvoiceTab.dynamicForm.contractInfo = {};
foreignInvoiceTab.dynamicForm.contractInfo.fields = BaseFormItems.concat([]);
foreignInvoiceTab.dynamicForm.contractInfo = isc.DynamicForm.create({

    width: "100%",
    align: "center",
    titleAlign: "right",
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    fields: this.fields,
    valuesManager: foreignInvoiceTab.dynamicForm.valuesManager,
    requiredMessage: '<spring:message code="validator.field.is.required"/>'
});
foreignInvoiceTab.tab.pane.contractInfo = isc.VLayout.create({

    align: "top",
    width: "100%",
    showEdges: false,
    layoutMargin: 10,
    membersMargin: 5,
    members: [foreignInvoiceTab.dynamicForm.contractInfo]
});

foreignInvoiceTab.tab.invoice = isc.TabSet.create({

    width: "100%",
    height: "800",
    autoDraw: true,
    showEdges: false,
    edgeMarginSize: 3,
    tabBarThickness: 300,
    tabBarPosition: "right",
    // tabBarControls: [],
    tabs: [
        {
            paneMargin: 5,
            pane: foreignInvoiceTab.tab.pane.contractInfo,
            title: '<spring:message code="foreign-invoice.form.tab.contract-info"/>'
        },
        {
            paneMargin: 5,
            pane: foreignInvoiceTab.tab.pane.baseValues,
            title: '<spring:message code="foreign-invoice.form.tab.base-values"/>'
        },
        {
            paneMargin: 5,
            pane: foreignInvoiceTab.tab.pane.calculation,
            title: '<spring:message code="foreign-invoice.form.tab.calculation"/>'
        },
        {
            paneMargin: 5,
            pane: foreignInvoiceTab.tab.pane.deduction,
            title: '<spring:message code="foreign-invoice.form.tab.deduction"/>'
        },
        {
            paneMargin: 5,
            pane: foreignInvoiceTab.tab.pane.payment,
            title: '<spring:message code="foreign-invoice.form.tab.payment"/>'
        }
    ]
});

foreignInvoiceTab.window.invoice.validate = function (data) {

    foreignInvoiceTab.dynamicForm.valuesManager.validate();
    return !foreignInvoiceTab.dynamicForm.valuesManager.hasErrors();
};
foreignInvoiceTab.window.invoice.okCallBack = function (data) {

    foreignInvoiceTab.method.jsonRPCManagerRequest({
        data: data
    });
};
foreignInvoiceTab.window.invoice.populateData = function (bodyWidget) {

    foreignInvoiceTab.dynamicForm.valuesManager.getValues();
};
foreignInvoiceTab.window.invoice.init(null, '<spring:message code="entity.foreign-invoice"/>', foreignInvoiceTab.tab.invoice, "80%");

nicico.BasicFormUtil.getDefaultBasicForm(foreignInvoiceTab, "api/foreign-invoice/");
foreignInvoiceTab.dynamicForm.main = null;

//*************************************************** Functions ********************************************************

foreignInvoiceTab.method.newForm = function () {

    foreignInvoiceTab.variable.method = "POST";
    foreignInvoiceTab.dynamicForm.valuesManager.clearValues();
    foreignInvoiceTab.window.main.show();
};
foreignInvoiceTab.method.editForm = function () {

    let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        foreignInvoiceTab.dialog.notSelected();
    else if (record.editable === false)
        foreignInvoiceTab.dialog.notEditable();
    else {

        foreignInvoiceTab.variable.method = "PUT";
        foreignInvoiceTab.dynamicForm.valuesManager.clearValues();
        foreignInvoiceTab.dynamicForm.valuesManager.editRecord(record);
        foreignInvoiceTab.window.main.show();
    }
};
