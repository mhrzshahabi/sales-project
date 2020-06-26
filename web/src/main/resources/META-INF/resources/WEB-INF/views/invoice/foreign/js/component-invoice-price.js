isc.defineClass("invoicePrice", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: false,
    align: "center",
    width: "100%",
    height: "20%",
    material: null,
    form: null,
    contractMonth: null,
    contractYear: null,
    invoicePriceObj: "",
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        invoicePriceObj = {
            priceCopper: 0,
            priceSilver: 0,
            priceGold: 0,
            pricePlatinum: 0,
            pricePalladium: 0,
            priceSelenium: 0,
        };

        var LME_YEARMONTH_DataSource = isc.MyRestDataSource.create({
            fetchDataURL: "${contextPath}/api/LME/yearMonth/"+This.contractYear+"/"+This.contractMonth
        });

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                                                                actionURL: "${contextPath}/api/LME/yearMonth/"+This.contractYear+"/"+This.contractMonth,
                                                                httpMethod: "GET",
                                                                data: "",
                                                                callback: function (RpcResponse_o) {
                                                                    var response = JSON.parse(RpcResponse_o.data);
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
                                contents: "<b>" + "AVERAGE OF " + this.contractMonth +"th Month of "+ this.contractYear + "<b>",
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
                                contents: "<b>" + "AVERAGE OF " + this.contractMonth +"th Month of "+ this.contractYear + "<b>",
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
                                contents: "<b>" + "AVERAGE OF " + this.contractMonth +"th Month of "+ this.contractYear + "<b>",
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
        return  invoicePriceObj;
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

/*isc.invoicePrice.create({
    material: materialCode["Copper Concentrate"],
    contractMonth: Number('01'),
    contractYear: Number('2000'),
});*/
