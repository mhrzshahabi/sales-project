isc.defineClass("InvoicePayment", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "scroll",
    currency: null,
    invoiceDeductionComponent: null,
    invoiceCalculationComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let fields = [];
        fields.add(isc.Unit.create({
            unitCategory: 1,
            disabledUnitField: true,
            disabledValueField: true,
            disabledCurrencyField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            showCurrencyFieldTitle: false,
            showUnitField: false,
            name: "unitPrice",
            fieldValueTitle: '<spring:message code="foreign-invoice.form.unit-price"/>',
            border: "1px solid rgba(0, 0, 0, 0.3)",
        }));
        fields.last().setUnitId(this.currency.symbol);
        fields.last().setValue(this.invoiceCalculationComponent.getSumValue() - this.invoiceDeductionComponent.getSumValue());
        fields.add(isc.Unit.create({
            unitCategory: 1,
            disabledUnitField: true,
            disabledValueField: true,
            disabledCurrencyField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            showCurrencyFieldTitle: false,
            showUnitField: false,
            name: "sumFIPrice",
            fieldValueTitle: '<spring:message code="foreign-invoice.form.unit-price"/>',
            border: "1px solid rgba(0, 0, 0, 0.3)",
        }));
        fields.last().setUnitId(this.currency.symbol);
        fields.last().setValue(this.invoiceCalculationComponent.getSumValue() - this.invoiceDeductionComponent.getSumValue());

        This.addMember(isc.DynamicForm.create({
            width: "100%",
            fields: fields
        }));
    }
});
