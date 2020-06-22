var foreignInvoiceTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

//***************************************************** RESTDATASOURCE *************************************************

//******************************************************* COMPONENTS ***************************************************

foreignInvoiceTab.dynamicForm.fields = [];
foreignInvoiceTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "no",
        width: "100%",
        required: true,
        title: "<spring:message code='foreign-invoice.form.no'/>"
    },
    {
        name: "date",
        width: "100%",
        required: true,
        title: "<spring:message code='foreign-invoice.form.date'/>"
    },
    {
        name: "sumPrice",
        width: "100%",
        required: true,
        title: "<spring:message code='foreign-invoice.form.sum-price'/>"
    },
    {
        name: "conversionSumPrice",
        width: "100%",
        title: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>"
    },
    {
        name: "accountingId",
        width: "100%",
        title: "<spring:message code='foreign-invoice.form.accounting-id'/>"
    },
    {
        name: "material",
        width: "100%",
        required: true,
        title: "<spring:message code='foreign-invoice.form.material'/>"
    },
    {
        name: "buyer.nameFA",
        width: "100%",
        required: true,
        title: "<spring:message code='foreign-invoice.form.buyer.name'/>"
    },
    {
        name: "buyer.nameEN",
        width: "100%",
        required: true,
        title: "<spring:message code='foreign-invoice.form.buyer.name'/>"
    },
    {
        name: "invoiceType.title",
        width: "100%",
        required: true,
        title: "<spring:message code='foreign-invoice.form.invoice-type.title'/>"
    },
    {
        name: "contract.no",
        width: "100%",
        required: true,
        title: "<spring:message code='foreign-invoice.form.contract.no'/>"
    },
    {
        name: "creator.fullName",
        width: "100%",
        required: true,
        title: "<spring:message code='foreign-invoice.form.creator.full-name'/>"
    },
]);
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
    fields: foreignInvoiceTab.dynamicForm.fields
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
], "60%");

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
