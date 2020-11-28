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
    parentId: false,
    delayData: null,
    paymentSumPrice: 0,
    conversionRef: null,
    paymentValues: null,
    conversionDate: null,
    conversionRate: null,
    conversionSumPrice: 0,
    shipmentCostInvoices: null,
    shipmentCostInvoiceRate: 1,
    invoiceDeductionComponent: null,
    invoiceBaseWeightComponent: null,
    invoiceCalculationComponent: null,
    paymentForm: new nicico.FindFormUtil(),
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        if (This.conversionRef) {

            This.conversionDate = This.conversionRef.currencyDate;
            This.conversionRate = This.conversionRef.currencyRateValue;
        } else
            This.conversionRate = 1;

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
                        unitCategory: piValues[index].currency.categoryUnit,
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
                    if (piValues[index].currencyId === This.currency.id) {

                        sumPIPrice += piValues[index].sumPrice;
                        This.getMembers().last().setValue(piValues[index].sumPrice * -1);
                    } else if (piValues[index].conversionRef.unitTo.id === This.currency.id) {

                        sumPIPrice += piValues[index].conversionSumPrice;
                        This.getMembers().last().setValue(piValues[index].conversionSumPrice * -1);
                    }
                    This.getMembers().last().setUnitId(piValues[index].currencyId);
                }

                This.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }));

                let shipmentCostButton = isc.IButton.create({
                    width: "200",
                    right: "10",
                    position: "absolute",
                    name: "shipmentCostButton",
                    title: "<spring:message code='foreign-invoice.form.tab.payment.shipment.cost'/>",
                    click: function () {

                        This.paymentForm.showFindFormByRestApiUrl(
                            null,
                            "60%", null, "<spring:message code='foreign-invoice.form.tab.payment.shipment.cost'/>",
                            This.shipmentCostInvoices,
                            "${contextPath}/api/shipmentCostInvoice/spec-list",
                            [
                                {
                                    name: "id",
                                    primaryKey: true,
                                    hidden: true,
                                    title: "<spring:message code='global.id'/>"
                                },
                                {
                                    showHover: true,
                                    name: "invoiceDate",
                                    title: "<spring:message code='shipmentCostInvoice.invoiceDate'/>"
                                },
                                {
                                    showHover: true,
                                    name: "invoiceNo",
                                    title: "<spring:message code='shipmentCostInvoice.invoiceNo'/>"
                                },
                                {
                                    showHover: true,
                                    name: "conversionSumPrice",
                                    title: "<spring:message code='shipmentCostInvoice.conversionSumPrice'/>",
                                },
                                {
                                    showHover: true,
                                    name: "conversionDate",
                                    title: "<spring:message code='shipmentCostInvoice.conversionDate'/>"
                                },
                                {
                                    showHover: true,
                                    name: "conversionRate",
                                    title: "<spring:message code='shipmentCostInvoice.conversionRate'/>"
                                },
                                {
                                    showHover: true,
                                    name: "buyerShare",
                                    title: "<spring:message code='shipmentCostInvoice.buyerShare'/>"
                                },
                                {
                                    showHover: true,
                                    name: "conversionSumPriceBuyerShare",
                                    title: "<spring:message code='shipmentCostInvoice.conversionSumPriceBuyerShare'/>"
                                },
                                {
                                    hidden: true,
                                    showHover: true,
                                    name: "conversionRefId",
                                    title: "<spring:message code='shipmentCostInvoice.conversionRefId'/>"
                                },
                                {
                                    hidden: true,
                                    showHover: true,
                                    name: "contractId",
                                    title: "<spring:message code='shipmentCostInvoice.contract'/>"
                                },
                                {
                                    name: "estatus",
                                    title: "<spring:message code='global.e-status'/>",
                                    hidden: false
                                }
                            ],
                            null, {
                                operator: "and", criteria: [
                                    {fieldName: "eStatusId", operator: "greaterOrEqual", value: 4},
                                    {fieldName: "shipmentId", operator: "equals", value: This.shipment.id}
                                ]
                            }, Number.MAX_VALUE);
                    }
                });

                This.paymentForm.validate = function (selectedRecords) {

                    let isValid = true;
                    selectedRecords.forEach(q => {
                        if (q.conversionRefId && q.conversionRef.unitToId !== This.currency.id) {
                            isValid = false;
                        } else if (!q.conversionRefId && q.financeUnitId !== This.currency.id) {
                            isValid = false
                        }
                    });

                    if (!isValid)
                        isc.say("<spring:message code='foreign-invoice.form.validate.not.match.currency'/>");
                    return isValid;
                };
                This.paymentForm.okCallBack = function (selectedRecords) {

                    This.paymentSumPrice = 0;
                    This.shipmentCostInvoices = selectedRecords;
                    selectedRecords.forEach(q => This.paymentSumPrice += q.conversionSumPriceBuyerShare);
                    This.getMembers().filter(q => q.name === "paymentSumPrice").first().setValue(This.paymentSumPrice);
                    This.getMembers().filter(q => q.name === "paymentSumPrice").first().setUnitId(This.currency.id);
                    This.getMembers().filter(q => q.name === "finalPriceButton").first().click();
                };

                shipmentCostButton.show();
                This.addMember(shipmentCostButton);

                This.addMember(isc.Unit.create({
                    required: false,
                    unitCategory: This.currency.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: true,
                    name: "paymentSumPrice",
                    fieldValueTitle: "<spring:message code='foreign-invoice.form.conversion-shipment-cost-sum-price'/>",
                }));
                This.getMembers().last().setValue(0);
                This.getMembers().last().setUnitId(This.currency.id);

                This.addMember(isc.Unit.create({
                    required: true,
                    unitCategory: This.currency.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: false,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: true,
                    name: "delayPenalty",
                    fieldValueTitle: "<spring:message code='foreign-invoice.form.delay-penalty'/>",
                }));
                This.getMembers().last().setValue(0);
                This.getMembers().last().setUnitId(This.currency.id);

                This.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }));

                let finalPriceButton = isc.IButton.create({
                    width: "200",
                    right: "10",
                    position: "absolute",
                    name: "finalPriceButton",
                    title: "<spring:message code='foreign-invoice.form.button.final.price.calculation'/>",
                    click: function () {

                        let delayValue = This.getMembers().filter(q => q.name === "delayPenalty").first().getValues().value;
                        let sumPrice = sumFIPrice - sumPIPrice - This.paymentSumPrice - (delayValue !== undefined ? delayValue : 0);

                        This.getMembers().filter(q => q.name === "sumPrice").first().setValue(sumPrice);
                        This.getMembers().filter(q => q.name === "sumPrice").first().setUnitId(This.currency.id);
                        This.conversionSumPrice = sumPrice * (This.conversionRate);

                        This.getMembers().filter(q => q.name === "conversionSumPrice").first().setValue(This.conversionSumPrice);
                        This.getMembers().filter(q => q.name === "conversionSumPrice").first().setUnitId(This.conversionRef ? This.conversionRef.unitToId : This.currency.id);
                        This.getMembers().filter(q => q.role === "conversionSumPriceText").first().setValue("conversionSumPriceText", numberToEnglish(NumberUtil.format(This.conversionSumPrice, "#")));
                    }
                });
                finalPriceButton.show();
                This.addMember(finalPriceButton);

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

                if (This.conversionRef) {

                    This.addMember(isc.HTMLFlow.create({
                        width: "100%",
                        name: "conversionContent",
                        contents: "<span style='width: 100%; text-align: " + nicico.CommonUtil.getAlignByLangReverse() + "; margin-bottom: 10px; display: block'>" +
                        "<spring:message code='foreign-invoice.conversionText.final.balance'/> " +
                        This.conversionRef.unitTo.name + " <spring:message code='foreign-invoice.conversionText.based.on'/> " +
                        This.conversionRef.reference + " <spring:message code='foreign-invoice.conversionText.date'/>  " +
                        This.conversionDate + " <spring:message code='foreign-invoice.conversionText.rate'/> " +
                        This.conversionRate + "</span>"
                    }));
                }

                This.addMember(isc.Unit.create({
                    required: false,
                    unitCategory: This.currency.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showUnitField: true,
                    name: "conversionSumPrice",
                    fieldValueTitle: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>",
                }));


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
                    }]
                }));

                This.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 20px auto'></span>"
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

                if (This.paymentValues) {

                    let selectedRecords = [];
                    This.paymentValues.forEach(current => {
                        selectedRecords.add({
                            invoiceNo: current.docNo,
                            invoiceDate: current.docDate,
                            sumPrice: current.docSumValue,
                            conversionDate: current.docConversionDate,
                            conversionRate: current.docConversionRate,
                            conversionSumPrice: current.docConversionPrice,
                            buyerShare: current.portion,
                            description: current.description,
                            conversionRefId: current.conversionRefId,
                            id: current.shipmentCostInvoiceId
                        });
                    });
                    This.shipmentCostInvoices = selectedRecords;
                    This.getMembers().filter(q => q.name === "shipmentCostButton").first().click();
                }

                if (This.delayData)
                    This.getMembers().filter(q => q.name === "delayPenalty").first().setValue(This.delayData);

            }
        }));
    },
    validate: function () {

        let isValid = true;
        this.getMembers().filter(q => q.validate).forEach(q => isValid &= q.validate());
        return isValid;
    },
    calculate: function () {

        let conversionRateValue = this.getMembers().last().getMembers().first().getValue("conversionRate");
        let sumFIPriceValue = this.getMembers().first().getMembers().filter(q => q.name === "sumFIPrice").first().getValues().value;
        this.getMembers().last().getMembers()[1].setValue(conversionRateValue * sumFIPriceValue);
    },
    getValues: function () {

        return {
            shipmentCostInvoices: this.getForeignInvoicePayment(),
            unitCost: this.invoiceDeductionComponent.getDeductionSubTotal(),
            unitPrice: this.invoiceCalculationComponent.getCalculationSubTotal(),
            sumFIPrice: this.getMembers().filter(q => q.name === "sumFIPrice").first(),
            sumPrice: this.getMembers().filter(q => q.name === "sumPrice").first(),
            conversionDate: this.conversionDate,
            conversionRate: this.conversionRate,
            conversionSumPrice: this.getMembers().filter(q => q.name === "conversionSumPrice").first(),
            conversionSumPriceText: this.getMembers().filter(q => q.role === "conversionSumPriceText").first().getValue("conversionSumPriceText"),
            delayPenalty: this.getMembers().filter(q => q.name === "delayPenalty").first(),
            parentId: this.parentId
        };
    },
    getForeignInvoicePayment: function () {

        let data = [];
        if (this.shipmentCostInvoices) {

            this.shipmentCostInvoices.forEach(current => {

                data.add({
                    docNo: current.invoiceNo,
                    docDate: current.invoiceDate,
                    docSumValue: current.sumPrice,
                    docConversionDate: current.conversionDate,
                    docConversionRate: current.conversionRate,
                    docConversionPrice: current.conversionSumPrice,
                    portion: current.buyerShare,
                    description: current.description,
                    conversionRefId: current.conversionRefId,
                    shipmentCostInvoiceId: current.id
                });
            });
        }
        return data;
    }
});
