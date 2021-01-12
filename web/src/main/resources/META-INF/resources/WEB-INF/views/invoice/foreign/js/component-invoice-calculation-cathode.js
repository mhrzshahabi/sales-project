isc.defineClass("InvoiceCalculationCathode", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    contract: null,
    shipment: null,
    currency: null,
    percent: null,
    basePriceData: false,
    premiumValueData: false,
    remainingPercent: false,
    contractDetailData: null,
    inspectionWeightData: null,
    invoiceBaseWeightComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let sendDate = new Date(This.shipment.sendDate);

        let premiumValue = This.contractDetailData.premium.filter(q => q.incotermRules.id === This.shipment.incotermRulesId).first().premiumValue;

        let QPArticleElement = isc.HTMLFlow.create({
            width: "100%",
        });

        let priceArticleElement = isc.HTMLFlow.create({
            width: "100%",
        });

        this.invoiceBaseWeightComponent = isc.InvoiceBaseWeight.create({
            percent: This.percent,
            remainingPercent: This.remainingPercent,
            inspectionWeightData: This.inspectionWeightData,
        });
        this.addMember(this.invoiceBaseWeightComponent);

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "POST",
            willHandleError: true,
            data: JSON.stringify(This.contractDetailData.moas),
            actionURL: "${contextPath}/api/price-base/get-avg-base-price-by-moas",
            params: {
                contractId: This.contract.id,
                sendDate: sendDate.toLocaleDateString(),
                financeUnitId: This.currency.id,
            },
            callback: function (resp) {

                if (resp.data && (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)) {

                    let priceBases = JSON.parse(resp.data);
                    priceBases.forEach(priceBase => {

                        This.addMember(isc.Unit.create({
                            name: "unitPrice",
                            unitHint: "PER " + priceBase.weightUnit.nameEN,
                            unitCategory: priceBase.financeUnit.categoryUnit,
                            fieldValueTitle: priceBase.element.name,
                            disabledUnitField: true,
                            disabledValueField: false,
                            showValueFieldTitle: true,
                            showUnitFieldTitle: false,
                            weightUnit: priceBase.weightUnit,
                            financeUnit: priceBase.financeUnit,
                            elementId: priceBase.elementId,
                        }));

                        This.getMembers().last().setValue(priceBase.price);
                        This.getMembers().last().setUnitId(priceBase.financeUnit.id);

                        if (This.basePriceData) {
                            This.getMembers().last().setValue(This.basePriceData);
                        }
                    });

                    This.addMember(isc.Unit.create({
                        name: "premiumValue",
                        unitCategory: This.currency.categoryUnit,
                        disabledUnitField: true,
                        disabledValueField: false,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        showUnitField: true,
                        fieldValueTitle: '<spring:message code="foreign-invoice.form.premium-value"/>',
                    }));

                    This.getMembers().last().setValue(premiumValue);
                    This.getMembers().last().setUnitId(This.currency.id);

                    if (This.premiumValueData) {
                        This.getMembers().last().setValue(This.premiumValueData);
                    }

                    QPArticleElement.setContents("<span style='display: block; text-align: left'>" + This.contractDetailData.quotationalPeriodContent + "</span>");
                    This.addMember(QPArticleElement);

                    This.addMember(isc.HTMLFlow.create({
                        width: "100%",
                        contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                    }));

                    priceArticleElement.setContents("<span style='display: block; text-align: left'>" + This.contractDetailData.priceContent + "</span>");
                    This.addMember(priceArticleElement);

                    This.addMember(isc.HTMLFlow.create({
                        width: "100%",
                        contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                    }));

                    This.addMember(isc.ToolStrip.create({
                        width: "100%",
                        border: '0px',
                        members: [
                            isc.ToolStripButton.create({
                                width: "100",
                                height: "25",
                                autoFit: false,
                                title: "<spring:message code='global.form.next.step'/>",
                                click: function () {

                                    if (!This.validate())
                                        return;

                                    This.okButtonClick();

                                    let tab = This.parentElement.parentElement;
                                    tab.getTab(tab.selectedTab).pane.members.forEach(q => q.disable());
                                    tab.selectTab(tab.selectedTab + 1 % tab.tabs.length);
                                }
                            })
                        ]
                    }));
                    This.addMember(isc.HTMLFlow.create({
                        width: "100%",
                        contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                    }));
                } else if (resp.httpResponseCode === 403) {
                    isc.say("<spring:message code='foreign-invoice.access.to.hrm'/>");
                } else
                    isc.say("<spring:message code='foreign-invoice.price.base.not.found'/>");
            }
        }));

    },

    validate: function () {

        let isValid = true;
        if (!this.invoiceBaseWeightComponent.validate())
            isValid = false;

        this.getMembers().filter(q => q.name === "unitPrice").forEach(member => {
            member.validate();
            if (member.hasErrors())
                isValid = false;
        });

        let premiumMember = this.getMembers().filter(q => q.name === "premiumValue").first();
        premiumMember.validate();
        if (premiumMember.hasErrors())
            isValid = false;

        if (!isValid)
            isc.warn("<spring:message code='global.message.data.not.complete'/>");

        return isValid;
    },
    okButtonClick: function () {

    },
    getDeductionSubTotal: function () {
        return 0;
    },
    getCalculationSubTotal: function () {

        return this.getMembers().filter(q => q.name === "unitPrice").first().getValues().value;
    },
    getPremiumValue: function () {

        return this.getMembers().filter(q => q.name === "premiumValue").first().getValues().value;
    },
    getForeignInvoiceItems: function () {

        let items = [];

        this.inspectionWeightData.weightInspections.forEach(current => {

            let remittanceDetailId = current.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id;
            items.add({
                treatCost: 0,
                weightGW: current.weightGW,
                weightND: current.weightND,
                assayMilestone: null,
                weightMilestone: current.mileStone,
                deductionUnitConversionRate: null,
                remittanceDetailId: remittanceDetailId,
                foreignInvoiceItemDetails: null
            });
        });
        return items;
    }
});