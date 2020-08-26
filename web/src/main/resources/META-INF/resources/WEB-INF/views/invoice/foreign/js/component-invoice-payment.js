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
    contract: null,
    conversionRate: null,
    invoiceDeductionComponent: null,
    invoiceBaseWeightComponent: null,
    invoiceCalculationComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            actionURL: "${contextPath}/api/foreign-invoice/get-by-contract/" + This.contract.id + "/" + ImportantIDs.invoiceType.PROVISIONAL,
            callback: function (resp) {

                let unitPrice = This.invoiceCalculationComponent.getCalculationSubTotal() - This.invoiceDeductionComponent.getDeductionSubTotal();
                let sumFIPrice = unitPrice * This.invoiceBaseWeightComponent.getValues().filter(q => q.name === "weightND").first().value;

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

                let piValues = JSON.parse(resp.data);
                let sumPIPrice = piValues.map(q => q.sumPIPrice).sum();
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
                        hoverHTML: function (item, form) {
                            return `<div style="font-weight: bolder;">Provisional invoice NO. ` + item.piData.no + `</div>
                            <div>` + item.piData.description + `</div>`;
                        }
                    }));
                    This.getMembers().last().setValue(piValues[index].sumPIPrice * -1);
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
                    showUnitField: false,
                    name: "sumPrice",
                    fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-price"/>',
                }));
                let sumPrice = sumFIPrice - sumPIPrice;
                This.getMembers().last().setUnitId(This.currency.id);
                This.getMembers().last().setValue(sumPrice);

                // let otherValuesGrid = isc.ListGrid.nicico.getDefault(
                //     null,
                //     isc.MyRestDataSource.create({
                //         fields: BaseFormItems.concat([
                //             {
                //                 showHover: true,
                //                 name: "docNo",
                //                 title: "<spring:message code='foreign-invoice.form.no'/>"
                //             },
                //             {
                //                 showHover: true,
                //                 name: "docDate",
                //                 title: "<spring:message code='foreign-invoice.form.date'/>"
                //             },
                //             {
                //                 showHover: true,
                //                 name: "docSumValue",
                //                 title: "<spring:message code='foreign-invoice.form.sum-price'/>"
                //             },
                //             {
                //                 showHover: true,
                //                 name: "docConversionDate",
                //                 title: "<spring:message code='foreign-invoice.form.conversion-date'/>"
                //             },
                //             {
                //                 showHover: true,
                //                 name: "docConversionRate",
                //                 title: "<spring:message code='foreign-invoice.form.conversion-rate'/>"
                //             },
                //             {
                //                 showHover: true,
                //                 name: "docConversionPrice",
                //                 title: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>"
                //             },
                //             {
                //                 showHover: true,
                //                 name: "portion",
                //                 title: "<spring:message code='foreign-invoice.form.payment-buyer-portion'/>"
                //             },
                //             {
                //                 showHover: true,
                //                 name: "description",
                //                 title: "<spring:message code='global.description'/>"
                //             },
                //             {
                //                 hidden: true,
                //                 showHover: true,
                //                 name: "conversionRefId",
                //                 title: "<spring:message code='foreign-invoice.form.conversion-ref.id'/>"
                //             }
                //         ]),
                //         fetchDataURL: "${contextPath}/api/foreign-invoice/get-payment-by-contract/" + This.contract.id
                //     }), null, {
                //         showFilterEditor: false,
                //         selectionType: "simple",
                //     }
                // );
                // This.addMember(otherValuesGrid);

                // let sumOfVOtherValuesGrid = otherValuesGrid.getData().map(q => q.finalValue).sum();
                // let sumOfValuesForm = valuesForm.fields.filter(q => q.isResult).map(q => q.getValue()).sum();
                // fields.add(isc.Unit.create({
                //     unitCategory: This.currency.categoryUnit,
                //     disabledUnitField: true,
                //     disabledValueField: true,
                //     showValueFieldTitle: true,
                //     showUnitFieldTitle: false,
                //     showUnitField: false,
                //     name: "sumPrice",
                //     fieldValueTitle: '<spring:message code="foreign-invoice.form.sum-price"/>',
                //     border: "1px solid rgba(0, 0, 0, 0.3)",
                // }));
                // fields.last().setUnitId(This.currency.id);
                // fields.last().setValue(sumOfValuesForm + sumOfVOtherValuesGrid);


                // fields.add({
                //     type: "button",
                //     title: "<spring:message code='global.form.apply'/>",
                //     click: function (form, item) {
                //
                //         let rateReference = form.getValue("rateReference");
                //         let conversionDate = form.getValue("conversionDate");
                //         if (rateReference == null || conversionDate == null)
                //             return;
                //
                //         isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                //
                //             httpMethod: "GET",
                //             actionURL: "${contextPath}/api/currencyRate/get-rate",
                //             params: {rateReference: rateReference, conversionDate: conversionDate},
                //             callback: function (resp) {
                //
                //                 if (resp && (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)) {
                //
                //                     let data = JSON.parse(resp);
                //                     if (data == null) {
                //
                //                         form.setValue("conversionRate", null);
                //                         form.setValue("conversionRefId", null);
                //                         form.setValue("conversionSumPrice", null);
                //                         form.setValue("conversionSumPriceText", null);
                //                         return;
                //                     }
                //
                //                     form.setValue("conversionRefId", data.id);
                //                     form.setValue("conversionRate", data.value);
                //
                //                     let convertedPrice = data.value * form.getValue("sumPrice");
                //                     form.setValue("conversionSumPrice", convertedPrice);
                //                     form.setValue("conversionSumPriceText", convertedPrice.toPersianLetter());
                //                 } else
                //                     isc.say(resp.data);
                //             }
                //         }));
                //     }
                // });

                This.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 30px auto; border-bottom: 0px solid rgba(0,0,0,0.3)'></span>"
                }));

                let conversionDate = This.conversionRate.currencyDate;
                let rateReference = This.conversionRate.reference;
                let conversionRefId = This.conversionRate.id;
                let conversionRate = This.conversionRate.currencyRateValue;
                let conversionSumPrice = sumPrice * conversionRate;

                This.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; text-align: left; margin-bottom: 10px; display: block'>"+ "FINAL BALANCE IN " + This.currency.nameEN +
                    " BASED ON " + rateReference + " RATE OF " + conversionDate + " - " + conversionRate + ": " + "<span>"
                }));

                This.addMember(isc.Unit.create({
                    required: true,
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
                    titleWidth: "120",
                    titleAlign: "left",
                    fields: [{
                        name: "conversionSumPriceText",
                        title: "<spring:message code='foreign-invoice.form.conversion-sum-price-text'/>",
                        type: "staticText",
                        value: numberToEnglish(conversionSumPrice)
                    }]
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
                            title: "<spring:message code='global.ok'/>",
                            click: function () {

                                This.validate();
                            }
                        }),
                        isc.ToolStrip.create({
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
        console.log("conversionRateValue", conversionRateValue, "sumFIPriceValue", sumFIPriceValue);
        this.getMembers().last().getMembers()[1].setValue(conversionRateValue * sumFIPriceValue);
    },
    getValue: function () {
        // console.log("paymentComp ", this.getMembers())
    },
    validate: function () {

    }
    // setValue: function (value) {
    //     this.setValues(value);
    // }
});
