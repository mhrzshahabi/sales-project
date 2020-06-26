isc.defineClass("BaseInvoiceInfo", isc.VLayout).addProperties({

    width: "100%",
    align: "top",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    buyer: null,
    contract: null,
    billLadings: null,
    materialItem: null,
    invoiceNo: null,
    invoiceDate: null,
    invoiceType: null,

    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let result = '';
        this.addMember(isc.Label.create({
            contents: `
                <style>
                    .i-contract-info-tab td{
                        vertical-align: top;
                        padding: 7px 0 !important;
                        border-bottom: 1px solid rgba(0,0,0,0.3) !important;
                    }
                    .i-contract-info-tab {
                        font-size: 13px;
                        overflow-y: scroll;
                        padding: 20px;
                        color: #000000;
                    }
                    .i-contract-info-tab tr {
                        width: 100%;
                        border-bottom: 1px solid rgba(0,0,0,0.3);
                        margin-bottom: 15px;
                        line-height: 1.5;
                    }
                    .table-td{
                        font-size: 12px;
                        font-weight: 500;
                        color: rgba(0  ,0 ,0 , 0.8); 
                    }
                    .table-td-value{
                        font-size: 14px;
                        color: #000000;
                    }
                    .i-contract-info-tab .i-invoice-type {
                        text-align: center;
                        text-decoration: underline;
                    }
                    .i-invoice-type{
                        margin-top: 40px;
                    }
                </style>
                <table class="i-contract-info-tab">
                  <caption class="i-invoice-type">` + This.invoiceType.title + `</caption>
                  <tr> 
                    <td class="table-td">REF NO:&nbsp;</td>
                    <td class="table-td-value">` + This.invoiceNo + `</td>
                  </tr>
                  <tr>
                    <td class="table-td">DATE:&nbsp;</td>
                    <td class="table-td-value">` + This.invoiceDate + `</td>
                  </tr>
                  <tr>
                    <td class="table-td">CONTRACT NO:&nbsp;</td>
                    <td class="table-td-value">` + This.contract[__contract.nameOfNumberProperty] + `</td>
                  </tr>
                  <tr class="i-buyer-info">
                    <td class="table-td">BUYER:&nbsp;</td>
                    <td class="table-td-value">
                        <div>` + This.buyer.nameEN + `</div>
                        <div>` + This.buyer.address + `</div>
                        <div>` + This.buyer.phone + `</div>
                        <div>` + This.buyer.fax + `</div>
                    </td>
                  </tr>
                  <tr>
                    <td class="table-td">MATERIAL:&nbsp;</td>
                    <td class="table-td-value">
                        <div>` + This.materialItem.material.descl + `</div>
                        <div>` + This.materialItem.gdsName + `</div>
                    </td>
                  </tr>
                  <tr>
                    <td class="table-td">SHIPPED:&nbsp;</td>
                    <td class="table-td-value">` + This.billLadings.map(bl => {

                        result = "<div>" + bl.vesselName + "</div>";
                        if (bl.switchBillLading)
                            result += "<div>SWITCH B/L NO: " + bl.switchBillLading.no + " DATED " + bl.switchBillLading.date + "</div>";
                        result += "<div>NICICO B/L NO: " + bl.no + " DATED " + bl.date + "</div>";
                        result += "<div>FROM: " + bl.from + "</div>";
                        result += "<div>TO: " + bl.to + "</div>";
                        result += "<div>G/W WEIGHT: " + bl.weightGW + "</div>";

                        return result;
                    }).join('<hr>') + `</td>
                  </tr>
                  <tr>
                    <td class="table-td">DELIVERY TERMS:&nbsp;</td>
                    <td class="table-td-value">
                        <div>` + null + `</div>
                        <div>` + null + `</div>
                    </td>
                  </tr>
                </table>`
        }));
    }
});
/*

 foreignInvoiceTab.dynamicForm.contractInfo = isc.DynamicForm.create({

    width: "100%",
    align: "center",
    titleAlign: "left",
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    fields: BaseFormItems.concat([
        // Foreign Invoice
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
        disabled: true,
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
}
]),
valuesManager: foreignInvoiceTab.dynamicForm.valuesManager,
    requiredMessage: '<spring:message code="validator.field.is.required"/>'
});

*/
