isc.defineClass("invoicePrice", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: false,
    align: "center",
    width: "100%",
    height: "20%",
    backgroundColor: "#f0c85a",
    material: null,
    form: null,
    contractMonth: null,
    contractYear: null,
    MOAS: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        var LME_YEARMONTH_DataSource = isc.MyRestDataSource.create({
            fetchDataURL: "${contextPath}/api/LME/yearMonth/"+This.contractYear+"/"+This.contractMonth
        });

        alert("fdsfd")

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

        // LME_YEARMONTH_DataSource.fetchData([],function (dsResponse, data, dsRequest) {
        //     console.log(data)
        //     console.log(data[0])
        //     form.getItem("copper").setValue(data[0].cuUsdMt);
        //     form.getItem("silver").setValue(data[0].silverUsdOunce);
        //     form.getItem("gold").setValue(data[0].goldUsdOunce);
        //     form.getItem("platinum").setValue(data[0].platinumUsdOunce);
        //     form.getItem("palladium").setValue(data[0].palladiumUsdOunce);
        //     form.getItem("selenium").setValue(data[0].seleniumUsdLb);
        // });

        switch (this.material) {

            case 0:
                form = isc.DynamicForm.create({
                margin: 10,
                width: "100%",
                canSubmit: true,
                align: "center",
                titleAlign: "right",
                numCols: 2,
                dataSource: LME_YEARMONTH_DataSource,
                autoFetchData: true,
                fields: [
                    // {
                    //     name: "MOAS",
                    //     title: "MOAS",
                    //     showTitle: false,
                    //     type: "staticText",
                    //     width: "100%",
                    //     colSpan: 2,
                    //     defaultValue: "AVERAGE OF " + this.contractMonth +"th Month of "+ this.contractYear
                    // },
                    {
                        name: "copper",
                        title: '<spring:message code="component.invoice.price.copper"/>',
                        type: "float",
                        required: true,
                    },
                ],
                });
                this.addMember(isc.VStack.create({
                    members: [
                        isc.Label.create({
                            // width: "100",
                            height: "10%",
                            align: "left",
                            contents: "<b>" + "AVERAGE OF " + this.contractMonth +"th Month of "+ this.contractYear + "<b>",
                        }),
                        form
                    ]
                }));
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
                this.addMember(isc.VStack.create({
                    members: [
                        isc.Label.create({
                            // width: "100",
                            height: "10%",
                            align: "left",
                            contents: "<b>" + "AVERAGE OF " + this.contractMonth +"th Month of "+ this.contractYear + "<b>",
                        }),
                        form
                    ]
                }));
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
                this.addMember(isc.VStack.create({
                    members: [
                        isc.Label.create({
                            // width: "100",
                            height: "10%",
                            align: "left",
                            contents: "<b>" + "AVERAGE OF " + this.contractMonth +"th Month of "+ this.contractYear + "<b>",
                        }),
                        form
                    ]
                }));
                break;
        }

        var submit = isc.Button.create({
            title: "submit",
            click: function () {
                console.log(This.getPriceValues());
            }
        });
        this.addMember(submit);

    },
    getPriceValues: function () {
        return  form.getValues();
    },
    setPriceValues: function (values) {
        return  form.setValues(values);
    },
});

isc.invoicePrice.create({
    material: materialCode["Anode Slime"],
    contractMonth: Number('01'),
    contractYear: Number('2000'),
});
