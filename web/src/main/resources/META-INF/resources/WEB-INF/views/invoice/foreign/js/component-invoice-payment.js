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
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: false,
                    name: "unitPrice",
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.unit-price"/>',
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(unitPrice);
                fields.last().setUnitId(This.currency.id);

                fields.add(isc.Unit.create({
                    isResult: true,
                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: false,
                    name: "sumFIPrice",
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-fi-price"/>',
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(sumFIPrice);
                fields.last().setUnitId(This.currency.id);

                let piValues = JSON.parse(resp.data);
                for (let index = 0; index < piValues.length; index++) {

                    fields.add(isc.Unit.create({
                        isResult: true,
                        unitCategory: 1,
                        disabledUnitField: true,
                        disabledValueField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
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
                    fields.last().setUnitId(piValues[index].currency.id);
                }

                let valuesForm = isc.DynamicForm.create({
                    width: "100%",
                    fields: fields
                });
                This.addMember(valuesForm);

                let otherValuesGrid = isc.ListGrid.nicico.getDefault(
                    null,
                    isc.MyRestDataSource.create({
                        fields: BaseFormItems.concat([
                            {
                                showHover: true,
                                name: "docNo",
                                title: "<spring:message code='foreign-invoice.form.no'/>"
                            },
                            {
                                showHover: true,
                                name: "docDate",
                                title: "<spring:message code='foreign-invoice.form.date'/>"
                            },
                            {
                                showHover: true,
                                name: "docSumValue",
                                title: "<spring:message code='foreign-invoice.form.sum-price'/>"
                            },
                            {
                                showHover: true,
                                name: "docConversionDate",
                                title: "<spring:message code='foreign-invoice.form.conversion-date'/>"
                            },
                            {
                                showHover: true,
                                name: "docConversionRate",
                                title: "<spring:message code='foreign-invoice.form.conversion-rate'/>"
                            },
                            {
                                showHover: true,
                                name: "docConversionPrice",
                                title: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>"
                            },
                            {
                                showHover: true,
                                name: "portion",
                                title: "<spring:message code='foreign-invoice.form.payment-buyer-portion'/>"
                            },
                            {
                                showHover: true,
                                name: "description",
                                title: "<spring:message code='global.description'/>"
                            },
                            {
                                hidden: true,
                                showHover: true,
                                name: "conversionRefId",
                                title: "<spring:message code='foreign-invoice.form.conversion-ref.id'/>"
                            }
                        ]),
                        fetchDataURL: "${contextPath}/api/foreign-invoice/get-payment-by-contract/" + This.contract.id
                    }), null, {
                        showFilterEditor: false,
                        selectionType: "simple",
                    }
                );
                This.addMember(otherValuesGrid);

                fields = [];
                let sumOfVOtherValuesGrid = otherValuesGrid.getData().map(q => q.finalValue).sum();
                let sumOfValuesForm = valuesForm.fields.filter(q => q.isResult).map(q => q.getValue()).sum();
                fields.add(isc.Unit.create({
                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: false,
                    name: "sumPrice",
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-price"/>',
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setUnitId(This.currency.id);
                fields.last().setValue(sumOfValuesForm + sumOfVOtherValuesGrid);

                fields.add({
                    type: "date",
                    required: true,
                    name: "conversionDate",
                    title: "<spring:message code='foreign-invoice.form.conversion-date'/>",
                    validators: [{
                        type: "required",
                        validateOnChange: true
                    }],
                    change: function (form, item, value) {
                        form.getField("conversionRefId").setValue(null);
                    }
                });
                fields.add({
                    required: true,
                    name: "rateReference",
                    valueMap: JSON.parse('${Enum_RateReference}'),
                    title: "<spring:message code='foreign-invoice.form.conversion-ref'/>",
                    change: function (form, item, value) {
                        form.getField("conversionRefId").setValue(null);
                    }
                });
                fields.add({
                    type: "button",
                    title: "<spring:message code='global.form.apply'/>",
                    click: function (form, item) {

                        let rateReference = form.getValue("rateReference");
                        let conversionDate = form.getValue("conversionDate");
                        if (rateReference == null || conversionDate == null)
                            return;

                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

                            httpMethod: "GET",
                            actionURL: "${contextPath}/api/currencyRate/get-rate",
                            params: {rateReference: rateReference, conversionDate: conversionDate},
                            callback: function (resp) {

                                if (resp && (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)) {

                                    let data = JSON.parse(resp);
                                    if (data == null) {

                                        form.setValue("conversionRate", null);
                                        form.setValue("conversionRefId", null);
                                        form.setValue("conversionSumPrice", null);
                                        form.setValue("conversionSumPriceText", null);
                                        return;
                                    }

                                    form.setValue("conversionRefId", data.id);
                                    form.setValue("conversionRate", data.value);

                                    let convertedPrice = data.value * form.getValue("sumPrice");
                                    form.setValue("conversionSumPrice", convertedPrice);
                                    form.setValue("conversionSumPriceText", convertedPrice.toPersianLetter());
                                } else
                                    isc.say(resp.data);
                            }
                        }));
                    }
                });
                fields.add({
                    hidden: true,
                    required: true,
                    type: "StaticText",
                    name: "conversionRefId",
                    title: "<spring:message code='foreign-invoice.form.conversion-ref.id'/>",
                });
                fields.add({
                    required: true,
                    type: "StaticText",
                    name: "conversionRate",
                    title: "<spring:message code='foreign-invoice.form.conversion-rate'/>",
                });
                fields.add(isc.Unit.create({
                    required: true,
                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: false,
                    name: "conversionSumPrice",
                    fieldValueTitle: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setUnitId(This.currency.id);

                fields.add(isc.Unit.create({
                    required: true,
                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: false,
                    name: "conversionSumPriceText",
                    fieldValueTitle: "<spring:message code='foreign-invoice.form.conversion-sum-price-text'/>",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setUnitId(This.currency.id);

                This.addMember(isc.DynamicForm.create({
                    width: "100%",
                    fields: fields
                }));
            }
        }));
    }
});
