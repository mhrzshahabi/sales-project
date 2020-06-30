isc.defineClass("InvoiceBasePrice", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    height: "20%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    elements: [],
    contract: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let contartYear = __contract.getContractYear(This.contract);
        let contartMonth = __contract.getContractMonth(This.contract);
        let finalPriceBaseText = __contract.getFinalPriceBaseText(This.contract);

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            params: {
                year: contartYear,
                month: contartMonth,
                materialId: __contract.getMaterial(This.contract).id
            },
            httpMethod: "GET",
            actionURL: "${contextPath}/api/price-base/get-base-price",
            callback: function (resp) {

                let response = JSON.parse(resp.data);
                form.getItem("copper").setValue(response[0].cuUsdMt);
                form.getItem("silver").setValue(response[0].silverUsdOunce);
                form.getItem("gold").setValue(response[0].goldUsdOunce);
                form.getItem("platinum").setValue(response[0].platinumUsdOunce);
                form.getItem("palladium").setValue(response[0].palladiumUsdOunce);
                form.getItem("selenium").setValue(response[0].seleniumUsdLb);
            }
        }));


        switch (this.material) {
            case 0:
                form = isc.DynamicForm.create({
                    margin: 10,
                    width: "100%",
                    canSubmit: true,
                    align: "center",
                    titleAlign: "right",
                    numCols: 2,
                    fields: [
                        {
                            name: "copper",
                            title: '<spring:message code="component.invoice.price.copper"/>',
                            type: "float",
                            required: true,
                        },
                    ],
                });

                this.addMember(isc.Label.create({
                    align: "left",
                    contents: "<b>" + "AVERAGE OF " + this.contractMonth + "th Month of " + this.contractYear + "<b>",
                }));
                this.addMember(form);
                break;
            case 1:
                form = isc.DynamicForm.create({
                    margin: 10,
                    width: "100%",
                    canSubmit: true,
                    align: "center",
                    titleAlign: "right",
                    numCols: 2,
                    fields: [
                        {
                            name: "copper",
                            title: '<spring:message code="component.invoice.price.copper"/>',
                            type: "float",
                            required: true,
                        },
                        {
                            name: "silver",
                            title: '<spring:message code="component.invoice.price.silver"/>',
                            type: "float",
                            required: true,
                        },
                        {
                            name: "gold",
                            title: '<spring:message code="component.invoice.price.gold"/>',
                            type: "float",
                            required: true,
                        },
                    ]
                });

                this.addMember(isc.Label.create({
                    align: "left",
                    contents: "<b>" + "AVERAGE OF " + this.contractMonth + "th Month of " + this.contractYear + "<b>",
                }));
                this.addMember(form);
                break;
            case 4:
                form = isc.DynamicForm.create({
                    margin: 10,
                    width: "100%",
                    canSubmit: true,
                    align: "center",
                    titleAlign: "right",
                    numCols: 2,
                    fields: [
                        {
                            name: "copper",
                            title: '<spring:message code="component.invoice.price.copper"/>',
                            type: "float",
                            required: true,
                        },
                        {
                            name: "silver",
                            title: '<spring:message code="component.invoice.price.silver"/>',
                            type: "float",
                            required: true,
                        },
                        {
                            name: "gold",
                            title: '<spring:message code="component.invoice.price.gold"/>',
                            type: "float",
                            required: true,
                        },
                        {
                            name: "platinum",
                            title: '<spring:message code="component.invoice.price.platinum"/>',
                            type: "float",
                            required: true,
                        },
                        {
                            name: "palladium",
                            title: '<spring:message code="component.invoice.price.palladium"/>',
                            type: "float",
                            required: true,
                        },
                        {
                            name: "selenium",
                            title: '<spring:message code="component.invoice.price.selenium"/>',
                            type: "float",
                            required: true,
                        },
                    ]
                });

                this.addMember(isc.Label.create({
                    align: "left",
                    contents: "<b>" + "AVERAGE OF " + this.contractMonth + "th Month of " + this.contractYear + "<b>",
                }));
                this.addMember(form);
                break;
        }

    },
    getPriceValues: function () {
        invoicePriceObj.priceCopper = Number(form.getItem("copper").getValue());
        invoicePriceObj.priceSilver = Number(form.getItem("silver").getValue());
        invoicePriceObj.priceGold = Number(form.getItem("gold").getValue());
        invoicePriceObj.pricePlatinum = Number(form.getItem("platinum").getValue());
        invoicePriceObj.pricePalladium = Number(form.getItem("palladium").getValue());
        invoicePriceObj.priceSelenium = Number(form.getItem("selenium").getValue());
        return invoicePriceObj;
    },
    setPriceValues: function (data) {
        form.getItem("copper").setValue(data.priceCopper);
        form.getItem("silver").setValue(data.priceSilver);
        form.getItem("gold").setValue(data.priceGold);
        form.getItem("platinum").setValue(data.pricePlatinum);
        form.getItem("palladium").setValue(data.pricePalladium);
        form.getItem("selenium").setValue(data.priceSelenium);
    },
});

/*isc.InvoiceBasePrice.create({
    material: materialCode["Copper Concentrate"],
    contractMonth: Number('01'),
    contractYear: Number('2000'),
});*/
