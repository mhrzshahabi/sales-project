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
    contract: null,
    invoiceDeductionComponent: null,
    invoiceBaseWeightComponent: null,
    invoiceCalculationComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            actionURL: "${contextPath}/api/provisional-invoice/get-by-contract/" + This.contract.id,
            callback: function (resp) {

                let fields = [];
                let unitPrice = This.invoiceCalculationComponent.getSumValue() - This.invoiceDeductionComponent.getSumValue();
                let sumFIPrice = unitPrice * This.invoiceBaseWeightComponent.getValues().weightND;
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
                fields.last().setValue(unitPrice);
                fields.last().setUnitId(This.currency.symbol);
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
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-fi-price"/>',
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(sumFIPrice);
                fields.last().setUnitId(This.currency.symbol);
                fields.add(isc.Unit.create({
                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    disabledCurrencyField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showCurrencyFieldTitle: false,
                    showUnitField: false,
                    name: "sumPIPrice",
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-pi-price"/>',
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(sumPIPrice * -1);
                fields.last().setUnitId(This.currency.symbol);

                This.addMember(isc.DynamicForm.create({
                    width: "100%",
                    fields: fields
                }));
            }
        }));
    }
});
