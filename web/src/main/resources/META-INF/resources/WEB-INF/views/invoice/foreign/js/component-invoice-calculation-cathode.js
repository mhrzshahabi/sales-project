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
    contractDetailData: null,
    inspectionWeightData: null,
    invoiceBaseWeightComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let QPArticleElement = isc.HTMLFlow.create({
            width: "100%",
        });

        let unitPriceArticleElement = isc.HTMLFlow.create({
            width: "100%",
        });

        this.invoiceBaseWeightComponent = isc.InvoiceBaseWeight.create({
            shipment: This.shipment,
            percent: This.percent,
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
                financeUnitId: This.currency.id,
            },
            callback: function (resp) {

                if (resp.data && (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)) {
                    debugger

                    let priceBases = JSON.parse(resp.data);
                    priceBases.forEach(priceBase => {

                        This.addMember(isc.Unit.create({
                            unitHint: "PER " + priceBase.weightUnit.nameEN,
                            unitCategory: priceBase.financeUnit.categoryUnit,
                            fieldValueTitle: priceBase.element.name,
                            disabledUnitField: true,
                            disabledValueField: false,
                            showValueFieldTitle: true,
                            showUnitFieldTitle: false,
                            name: priceBase.element.name,
                            weightUnit: priceBase.weightUnit,
                            financeUnit: priceBase.financeUnit,
                            elementId: priceBase.elementId,
                        }));

                        This.getMembers().last().setValue(priceBase.price);
                        This.getMembers().last().setUnitId(priceBase.financeUnit.id);

                        if (This.basePriceData) {
                            let elementId = This.getMembers().last().elementId;
                            This.getMembers().last().setValue(This.basePriceData.filter(q => q.materialElement.elementId === elementId).first().basePrice);
                        }
                    });

                    // QPArticleElement.setContents("<span style='display: block; text-align: left'>" + This.contractDetailData.QPAtricleText + "</span>");
                    // this.addMember(QPArticleElement);
                    //
                    // this.addMember(isc.HTMLFlow.create({
                    //     width: "100%",
                    //     contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                    // }));

                    unitPriceArticleElement.setContents("<span style='display: block; text-align: left'>" + This.contractDetailData.quotationalPeriodContent + "</span>");
                    This.addMember(unitPriceArticleElement);

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
                                title: "<spring:message code='global.ok'/>",
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
                }
            }
        }));

    },

    validate: function () {

        let isValid = true;
        if (!this.invoiceBaseWeightComponent.validate())
            isValid = false;

        return isValid;
    },
    okButtonClick: function () {

    },
    getDeductionSubTotal: function () {
        return 0;
    },
    getCalculationSubTotal: function () {
        return this.contractDetailData.unitPrice;
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
                weightMilestone:current.mileStone,
                deductionUnitConversionRate: null,
                remittanceDetailId: remittanceDetailId,
                foreignInvoiceItemDetails: null
            });
        });
        return items;
    }
});