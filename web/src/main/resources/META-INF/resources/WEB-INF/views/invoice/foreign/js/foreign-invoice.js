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
        type: "date",
        title: "<spring:message code='foreign-invoice.form.date'/>"
    },
    {
        colSpan: 6,
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
        colSpan: 6,
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
            materialItemIdField.setOptionCriteria({
                fieldName: "materialId",
                operator: "equals",
                value: item.getSelectedRecord().materialId
            });
            materialItemIdField.optionDataSource.fetchData();
        }
    },
    {
        colSpan: 6,
        required: true,
        type: "integer",
        readonly: true,
        disabled: true,
        autoFetchData: false,
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
        colSpan: 6,
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
        title: "<spring:message code='foreign-invoice.form.currency'/>"
    },
    {
        colSpan: 6,
        required: true,
        type: "integer",
        editorType: "SelectItem",
        name: "creatorId",
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
        readonly: true,
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.no'/>"
    },
    {
        colSpan: 6,
        readonly: true,
        type: "float",
        name: "conversionRate",
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.conversion-rate'/>"
    },
    {
        colSpan: 6,
        readonly: true,
        name: "conversionDate",
        type: "date",
        editorType: "staticText",
        title: "<spring:message code='foreign-invoice.form.conversion-date'/>"
    },
    {
        colSpan: 6,
        type: "integer",
        readonly: true,
        editorType: "staticText",
        name: "conversionRefId",
        title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"
    },
    {
        colSpan: 6,
        required: true,
        type: "integer",
        readonly: true,
        editorType: "staticText",
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
