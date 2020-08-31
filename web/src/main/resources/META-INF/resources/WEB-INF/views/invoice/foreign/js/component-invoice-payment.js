isc.defineClass("InvoicePayment", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    currency: null,
    shipment: null,
    conversionRef: null,
    invoiceDeductionComponent: null,
    invoiceBaseWeightComponent: null,
    invoiceCalculationComponent: null,
    paymentForm: new nicico.FindFormUtil(),
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            params: {
                currencyId: This.currency.id,
                shipmentId: This.shipment.id,
                invoiceTypeId: ImportantIDs.invoiceType.PROVISIONAL
            },
            actionURL: "${contextPath}/api/foreign-invoice/get-by-shipment",
            callback: function (resp) {

                let unitPrice = This.invoiceCalculationComponent.getCalculationSubTotal() - This.invoiceDeductionComponent.getDeductionSubTotal();
                let sumFIPrice = unitPrice * This.invoiceBaseWeightComponent.getValues().weightND.getValues().value;

                This.addMember(isc.Unit.create({
                    isResult: false,
                    unitCategory: This.currency.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: false,
                    name: "unitPrice",
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.unit-price"/>',
                }));
                This.getMembers().last().setValue(unitPrice);
                This.getMembers().last().setUnitId(This.currency.id);

                This.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }));

                This.addMember(isc.Unit.create({
                    isResult: true,
                    unitCategory: This.currency.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: true,
                    name: "sumFIPrice",
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-fi-price"/>',
                }));
                This.getMembers().last().setValue(sumFIPrice);
                This.getMembers().last().setUnitId(This.currency.id);

                let sumPIPrice = 0;
                let piValues = JSON.parse(resp.data);
                for (let index = 0; index < piValues.length; index++) {

                    This.addMember(isc.Unit.create({
                        isResult: true,
                        unitCategory: piValues[index].unit.categoryUnit,
                        disabledUnitField: true,
                        disabledValueField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        showUnitField: true,
                        piData: piValues[index],
                        name: "sumPIPrice_" + piValues[index].no,
                        fieldValueTitle: '<spring:message code="foreign-invoice.form.pi-price"/>',
                        itemHoverWidth: 400,
                        itemHoverHTML: function (item) {

                            if (!this.piData)
                                return;

                            return `<div style="font-weight: bolder;">Provisional invoice NO. ` + this.piData.no + `</div>
                            <div>` + this.piData.description + `</div>`;
                        }
                    }));
                    if (piValues[index].unit.id === This.currency.id) {

                        sumPIPrice += piValues[index].sumPrice;
                        This.getMembers().last().setValue(piValues[index].sumPrice * -1);
                    } else if (piValues[index].conversionRef.unitTo.id === This.currency.id) {

                        sumPIPrice += piValues[index].conversionSumPrice;
                        This.getMembers().last().setValue(piValues[index].conversionSumPrice * -1);
                    }
                    This.getMembers().last().setUnitId(piValues[index].unit.id);
                }

                This.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }));

                This.addMember(isc.Unit.create({
                    unitCategory: This.currency.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: true,
                    name: "sumPrice",
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-price"/>',
                }));
                let sumPrice = sumFIPrice - sumPIPrice;
                This.getMembers().last().setUnitId(This.currency.id);
                This.getMembers().last().setValue(sumPrice);

                let conversionDate;
                let rateReference;
                let conversionRefId;
                let conversionRate;
                let conversionSumPrice;
                if (This.conversionRef) {

                    conversionDate = This.conversionRef.currencyDate;
                    rateReference = This.conversionRef.reference;
                    conversionRefId = This.conversionRef.id;
                    conversionRate = This.conversionRef.currencyRateValue;
                    conversionSumPrice = sumPrice * conversionRate;

                    This.addMember(isc.HTMLFlow.create({
                        width: "100%",
                        contents: "<span style='width: 100%; display: block; margin: 30px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>" +
                            "<span style='width: 100%; text-align: left; margin-bottom: 10px; display: block'>" + "FINAL BALANCE IN " + This.currency.nameEN +
                            " BASED ON " + rateReference + " RATE OF " + conversionDate + " - " + conversionRate + ": " + "</span>"
                    }));
                } else {

                    conversionRate = 1;
                    conversionSumPrice = sumPrice * conversionRate;
                }

                This.addMember(isc.Unit.create({
                    required: false,
                    visibility: This.conversionRef ? "visible" : "hidden",
                    unitCategory: This.currency.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: true,
                    name: "conversionSumPrice",
                    fieldValueTitle: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>",
                }));
                This.getMembers().last().setUnitId(This.currency.id);
                This.getMembers().last().setValue(conversionSumPrice);

                This.addMember(isc.DynamicForm.create({
                    width: "100%",
                    wrapItemTitles: false,
                    role: "conversionSumPriceText",
                    fields: [{
                        wrap: true,
                        width: "95%",
                        name: "conversionSumPriceText",
                        title: (This.conversionRef ?
                            "<spring:message code='foreign-invoice.form.conversion-sum-price-text'/>" :
                            "<spring:message code='foreign-invoice.form.sum-price-text'/>"),
                        type: "staticText",
                        value: numberToEnglish(NumberUtil.format(conversionSumPrice, "#"))
                    }]
                }));

                This.addMember(isc.IButton.create({
                    width: "100",
                    right: "10",
                    position: "absolute",
                    icon: "pieces/512/sanad.png",
                    click: function () {

                        This.paymentForm.showFindFormByRestApiUrl(null, "50%", "500",
                            "<spring:message code='foreign-invoice.form.tab.payment'/>", null,
                            "${contextPath}/api/shipmentCostInvoice/spec-list", BaseFormItems.concat([
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
                            ]), null, {
                                operator: "and",
                                criteria: [{
                                    fieldName: "shipmentId",
                                    operator: "equals",
                                    value: This.shipment.id
                                }]
                            }, 0);
                    }
                }));

                This.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }));

                This.addMember(isc.ToolStrip.create({
                    width: "100%",
                    align: "right",
                    border: '0px',
                    members: [
                        isc.ToolStripButton.create({
                            width: "100",
                            height: "25",
                            autoFit: false,
                            title: "<spring:message code='global.cancel'/>",
                            click: function () {

                                let tab = This.parentElement.parentElement;
                                let selectedTab = tab.selectedTab;
                                tab.getTab(tab.selectedTab - 1).pane.members.forEach(q => q.enable());
                                tab.selectTab(selectedTab - 1);
                                tab.removeTab(selectedTab);
                            }
                        })
                    ]
                }));

                This.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }));
            }
        }));
    },
    calculate: function () {

        let conversionRateValue = this.getMembers().last().getMembers().first().getValue("conversionRate");
        let sumFIPriceValue = this.getMembers().first().getMembers().filter(q => q.name === "sumFIPrice").first().getValues().value;
        this.getMembers().last().getMembers()[1].setValue(conversionRateValue * sumFIPriceValue);
    },
    getValues: function () {

        return {

            shipmentCostInvoices: null,
            unitCost: this.invoiceDeductionComponent.getDeductionSubTotal(),
            unitPrice: this.invoiceCalculationComponent.getCalculationSubTotal(),
            sumFIPrice: this.getMembers().filter(q => q.name === "sumFIPrice").first(),
            sumPrice: this.getMembers().filter(q => q.name === "sumPrice").first(),
            conversionSumPrice: this.getMembers().filter(q => q.name === "conversionSumPrice").first(),
            conversionSumPriceText: this.getMembers().filter(q => q.role === "conversionSumPriceText").first().getValue("conversionSumPriceText")
        };
    },
    validate: function () {

        let isValid = true;
        this.getMembers().filter(q => q.validate).forEach(q => isValid &= q.validate());
        return isValid;
    }
});
