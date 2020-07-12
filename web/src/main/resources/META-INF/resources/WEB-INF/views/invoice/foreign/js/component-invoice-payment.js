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
                    isResult: false,
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
                    isResult: true,
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

                let piValues = JSON.parse(resp.data);
                for (let index = 0; index < piValues.length; index++) {

                    fields.add(isc.Unit.create({
                        isResult: true,
                        unitCategory: 1,
                        disabledUnitField: true,
                        disabledValueField: true,
                        disabledCurrencyField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        showCurrencyFieldTitle: false,
                        showUnitField: false,
                        piData: piValues[index],
                        name: "sumPIPrice_" + piValues[index].no,
                        fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-pi-price"/>',
                        border: "1px solid rgba(0, 0, 0, 0.3)",
                        hoverHTML: function (item, form) {
                            return `<div style="font-weight: bolder;">Provisional invoice NO. ` + item.piData.no + `</div>
                                    <div>` + item.piData.description + `</div>`;
                        }
                    }));
                    fields.last().setValue(piValues[index].sumPrice * -1);
                    fields.last().setUnitId(piValues[index].currency.symbol);
                }

                let valuesForm = isc.DynamicForm.create({
                    width: "100%",
                    fields: fields
                });
                This.addMember(valuesForm);

                let otherValuesGrid = isc.ListGrid.create({
                });
                This.addMember(otherValuesGrid);

                fields = [];
                let sumOfVOtherValuesGrid = otherValuesGrid.getData().map(q => q.finalValue).sum();
                let sumOfValuesForm = valuesForm.fields.filter(q => q.isResult).map(q => q.getValue()).sum();
                fields.add(isc.Unit.create({
                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    disabledCurrencyField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showCurrencyFieldTitle: false,
                    showUnitField: false,
                    name: "sumPrice",
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-price"/>',
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setUnitId(This.currency.symbol);
                fields.last().setValue(sumOfValuesForm + sumOfVOtherValuesGrid);

                fields.add({
                    name: "curDate",
                    title: "<spring:message code='currencyRate.curDate'/>",
                    type: "date",
                    width: "400",
                    required: true,
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                });
                fields.add({
                    width: "20%",
                    name: "conversionDate",
                    required: true,
                    valueMap: JSON.parse('${Enum_DataType}'),
                    title: "<spring:message code='global.type'/>"
                });

                This.addMember(isc.DynamicForm.create({
                    width: "100%",
                    fields: fields
                }));
            }
        }));
    }
});
