var foreignInvoiceTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

foreignInvoiceTab.variable.personUrl = "${contextPath}" + "/api/person/";
foreignInvoiceTab.variable.currencyUrl = "${contextPath}" + "/api/currency/";
foreignInvoiceTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/";
foreignInvoiceTab.variable.invoiceTypeUrl = "${contextPath}" + "/api/invoice-type/";
foreignInvoiceTab.variable.materialItemUrl = "${contextPath}" + "/api/materialItem/";
foreignInvoiceTab.variable.foreignInvoiceUrl = "${contextPath}" + "/api/foreign-invoice/";
foreignInvoiceTab.variable.foreignInvoiceItemUrl = "${contextPath}" + "/api/foreign-invoice-item/";
foreignInvoiceTab.variable.foreignInvoicePaymentUrl = "${contextPath}" + "/api/foreign-invoice-payment/";
foreignInvoiceTab.variable.foreignInvoiceItemDetailUrl = "${contextPath}" + "/api/foreign-invoice-item-detail/";

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
        colSpan: 6,
        required: true,
        name: "date",
        section: "base-data",
        type: "date",
        title: "<spring:message code='foreign-invoice.form.date'/>"
    },
    {
        required: true,
        name: "invoiceType.title",
        title: "<spring:message code='foreign-invoice.form.invoice-type'/>"
    },
    {
        colSpan: 6,
        required: true,
        type: "integer",
        section: "base-data",
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
        name: "contract.no",
        title: "<spring:message code='foreign-invoice.form.contract'/>"
    },
    {
        colSpan: 6,
        required: true,
        type: "integer",
        editorType: "SelectItem",
        name: "contractId",
        section: "base-data",
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
            materialItemIdField.setOptionCriteria({fieldName: "materialId", operator: "equals", value: item.getSelectedRecord().materialId});
            materialItemIdField.optionDataSource.fetchData();
        }
    },
    {
        required: true,
        readonly: true,
        editorType: "staticText",
        name: "materialItem.gdsName",
        title: "<spring:message code='foreign-invoice.form.material-item'/>"
    },
    {
        colSpan: 6,
        required: true,
        type: "integer",
        readonly: true,
        disabled: true,
        autoFetchData: false,
        section: "base-data",
        name: "materialItemId",
        editorType: "SelectItem",
        width: "100%",
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
        name: "currency.nameEN",
        title: "<spring:message code='foreign-invoice.form.currency'/>"
    },
    {
        colSpan: 6,
        required: true,
        type: "integer",
        section: "base-data",
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
        title: "<spring:message code='foreign-invoice.form.currency'/>"
    },
    {
        required: true,
        name: "creator.fullName",
        title: "<spring:message code='foreign-invoice.form.creator'/>"
    },
    {
        colSpan: 6,
        required: true,
        type: "integer",
        editorType: "SelectItem",
        name: "creatorId",
        section: "base-data",
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
        colSpan: 6,
        name: "no",
        section: "base-data",
        readonly: true,
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.no'/>"
    },
    {
        required: true,
        type: "float",
        name: "unitPrice",
        readonly: true,
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.unit-price'/>"
    },
    {
        required: true,
        type: "float",
        name: "unitCost",
        readonly: true,
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.unit-cost'/>"
    },
    {
        required: true,
        type: "float",
        name: "sumPIPrice",
        readonly: true,
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.sum-pi-price'/>"
    },
    {
        required: true,
        type: "float",
        name: "sumFIPrice",
        readonly: true,
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.sum-fi-price'/>"
    },
    {
        required: true,
        type: "float",
        name: "sumPrice",
        readonly: true,
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.sum-price'/>"
    },
    {
        colSpan: 6,
        readonly: true,
        type: "float",
        section: "base-data",
        name: "conversionRate",
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.conversion-rate'/>"
    },
    {
        colSpan: 6,
        readonly: true,
        section: "base-data",
        name: "conversionDate",
        type: "date",
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.conversion-date'/>"
    },
    {
        type: "float",
        readonly: true,
        editorType: "staticText",
        name: "conversionSumPrice",
        title: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>"
    },
    {
        readonly: true,
        editorType: "staticText",
        name: "conversionSumPriceText",
        title: "<spring:message code='foreign-invoice.form.conversion-sum-price-text'/>"
    },
    {
        type: "integer",
        name: "accountingId",
        readonly: true,
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.accounting.id'/>"
    },
    {
        colSpan: 6,
        type: "integer",
        readonly: true,
        section: "base-data",
        editorType: "staticText",
        name: "conversionRefId",
        title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"
    },
    {
        required: true,
        readonly: true,
        editorType: "staticText",
        name: "buyer.nameEN",
        title: "<spring:message code='foreign-invoice.form.buyer'/>"
    },
    {
        colSpan: 6,
        required: true,
        type: "integer",
        readonly: true,
        editorType: "staticText",
        section: "base-data",
        name: "buyerId",
        title: "<spring:message code='foreign-invoice.form.buyer'/>"
    }
]);

//***************************************************** RESTDATASOURCE *************************************************

foreignInvoiceTab.restDataSource.foreignInvoiceItem = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([]),
    fetchDataURL: foreignInvoiceTab.variable.foreignInvoiceItemUrl + "spec-list"
});
foreignInvoiceTab.restDataSource.foreignInvoicePayment = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([]),
    fetchDataURL: foreignInvoiceTab.variable.foreignInvoicePaymentUrl + "spec-list"
});
foreignInvoiceTab.restDataSource.foreignInvoiceItemDetail = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([]),
    fetchDataURL: foreignInvoiceTab.variable.foreignInvoiceItemDetailUrl + "spec-list"
});

//******************************************************* COMPONENTS ***************************************************

foreignInvoiceTab.dynamicForm.main = isc.DynamicForm.create({
    width: "100%",
    align: "center",
    titleAlign: "right",
    numCols: 6,
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: foreignInvoiceTab.dynamicForm.fields.filter(q => q.section === "base-data")
});
foreignInvoiceTab.button.save = isc.IButtonSave.create({

    margin: 10,
    height: 50,
    icon: "pieces/16/save.png",
    title: "<spring:message code='global.form.save'/>",
    click: function () {
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
foreignInvoiceTab.window.main = isc.Window.nicico.getDefault('<spring:message code="entity.foreign-invoice"/>', [

    foreignInvoiceTab.dynamicForm.main,
    isc.HLayout.create({
        width: "100%",
        members: [
            foreignInvoiceTab.button.save,
            foreignInvoiceTab.button.cancel,
        ]
    })
], "500");

nicico.BasicFormUtil.getDefaultBasicForm(foreignInvoiceTab, "api/foreign-invoice/");

//*************************************************** Functions ********************************************************

foreignInvoiceTab.method.newForm = function () {

    foreignInvoiceTab.variable.method = "POST";
    foreignInvoiceTab.dynamicForm.main.clearValues();
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
        foreignInvoiceTab.dynamicForm.main.clearValues();
        foreignInvoiceTab.dynamicForm.main.editRecord(record);
        foreignInvoiceTab.window.main.show();
    }
};
