isc.defineClass("InvoiceBaseWeight", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: false,
    align: "center",
    width: "100%",
    height: "20%",
    material: null,
    // backgroundColor: "#f0c85a",
    unitComponentGross: null,
    unitComponentNet: null,
    unitComponentBundles: null,
    unitComponentNetWet: null,
    unitComponentMoisture: null,
    unitComponentNetDry: null,
    invoiceWeightObj: "",
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        invoiceWeightObj = {
            weightGW: 0,
            weightND: 0,
            weightBM: 0,
        };

        switch (this.material) {
            case 0:
                unitComponentGross = isc.Unit.create({
                    fieldValueTitle: '<spring:message code="component.invoice.weight.gross"/>',
                    unitCategory: 1,
                    showTitle: false
                });

                unitComponentNet = isc.Unit.create({
                    fieldValueTitle: '<spring:message code="component.invoice.weight.net"/>',
                    unitCategory: 1,
                    showTitle: false
                });

                unitComponentBundles = isc.Unit.create({
                    fieldValueTitle: '<spring:message code="component.invoice.weight.bundles"/>',
                    unitCategory: 1,
                    showTitle: false
                });

                this.addMember(unitComponentGross);
                this.addMember(unitComponentNet);
                this.addMember(unitComponentBundles);
                break;

            case 1:
                unitComponentNetWet = isc.Unit.create({
                    fieldValueTitle: '<spring:message code="component.invoice.weight.netWet"/>',
                    unitCategory: 1,
                    showTitle: false
                });

                unitComponentNetDry = isc.Unit.create({
                    fieldValueTitle: '<spring:message code="component.invoice.weight.netDry"/>',
                    unitCategory: 1,
                    showTitle: false
                });

                unitComponentMoisture = isc.Unit.create({
                    fieldValueTitle: '<spring:message code="component.invoice.weight.moisture"/>',
                    unitCategory: 1,
                    showTitle: false
                });

                this.addMember(unitComponentNetWet);
                this.addMember(unitComponentNetDry);
                this.addMember(unitComponentMoisture);
                break;

            case 4:
                unitComponentNetWet = isc.Unit.create({
                    fieldValueTitle: '<spring:message code="component.invoice.weight.netWet"/>',
                    unitCategory: 1,
                    showTitle: false
                });

                unitComponentNetDry = isc.Unit.create({
                    fieldValueTitle: '<spring:message code="component.invoice.weight.netDry"/>',
                    unitCategory: 1,
                    showTitle: false
                });

                unitComponentMoisture = isc.Unit.create({
                    fieldValueTitle: '<spring:message code="component.invoice.weight.moisture"/>',
                    unitCategory: 1,
                    showTitle: false
                });

                this.addMember(unitComponentNetWet);
                this.addMember(unitComponentNetDry);
                this.addMember(unitComponentMoisture);
                break;
        }

        /*var submit = isc.Button.create({
            title: "submit",
            click: function () {
                console.log(This.getWeightValues());
            }
        });
        this.addMember(submit);*/
    },
    getWeightValues: function () {
        invoiceWeightObj.weightGW = this.members.get(0).getUnitValues();
        invoiceWeightObj.weightND = this.members.get(1).getUnitValues();
        invoiceWeightObj.weightBM = this.members.get(2).getUnitValues();
        return invoiceWeightObj;
    },
    setWeightValues: function (data) {
        this.members.get(0).setUnitValues(data.weightGW);
        this.members.get(1).setUnitValues(data.weightND);
        this.members.get(2).setUnitValues(data.weightBM);
    }
});

isc.InvoiceBaseWeight.create({
    material: materialCode["Copper Cathode"]
});
