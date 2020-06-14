isc.defineClass("invoiceWeight", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: false,
    align: "center",
    width: "100%",
    height: "20%",
    material: null,
    backgroundColor: "#f0c85a",
    // form: null,
    unitComponentGross: null,
    unitComponentNet: null,
    unitComponentBundles: null,
    unitComponentNetWet: null,
    unitComponentMoisture: null,
    unitComponentNetDry: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        switch (this.material) {
            case 0:
                unitComponentGross = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.weight.gross"/>',
                    typeUnitCategory: 1,
                    showTitle: false
                });

                unitComponentNet = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.weight.net"/>',
                    typeUnitCategory: 1,
                    showTitle: false
                });

                unitComponentBundles = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.weight.bundles"/>',
                    typeUnitCategory: 1,
                    showTitle: false
                });
                // form.setFields(this.unitComponentGross, this.unitComponentNet, this.unitComponentBundles);
                this.addMember(isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    membersMargin: 2,
                    members:[
                        unitComponentGross,
                        unitComponentNet,
                        unitComponentBundles,
                    ]
                }));
                break;

            case 1:
                unitComponentNetWet = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.weight.netWet"/>',
                    typeUnitCategory: 1,
                    showTitle: false
                });

                unitComponentMoisture = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.weight.moisture"/>',
                    typeUnitCategory: 1,
                    showTitle: false
                });

                unitComponentNetDry = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.weight.netDry"/>',
                    typeUnitCategory: 1,
                    showTitle: false
                });
                // form.setFields(this.unitComponentNetWet, this.unitComponentMoisture, this.unitComponentNetDry);
                this.addMember(isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    membersMargin: 2,
                    members: [
                        unitComponentNetWet,
                        unitComponentMoisture,
                        unitComponentNetDry,
                    ]
                }));
                break;

            case 4:
                unitComponentNetWet = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.weight.netWet"/>',
                    typeUnitCategory: 1,
                    showTitle: false
                });

                unitComponentMoisture = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.weight.moisture"/>',
                    typeUnitCategory: 1,
                    showTitle: false
                });

                unitComponentNetDry = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.weight.netDry"/>',
                    typeUnitCategory: 1,
                    showTitle: false
                });
                // form.setFields(this.unitComponentNetWet, this.unitComponentMoisture, this.unitComponentNetDry);
                this.addMember(isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    membersMargin: 2,
                    members: [
                        unitComponentNetWet,
                        unitComponentMoisture,
                        unitComponentNetDry,
                    ]
                }));
                break;
        }

        var submit = isc.Button.create({
            title: "submit",
            click: function () {
                console.log(This.getWeightValues());
            }
        });
        this.addMember(submit);
    },
    getWeightValues: function () {
        let values = [];
            values.push(this.members.get(0).members.get(0).getUnitValues());
            values.push(this.members.get(0).members.get(1).getUnitValues());
            values.push(this.members.get(0).members.get(2).getUnitValues());
        return values;
    },
    setWeightValues: function (values) {
        this.members.get(0).members.get(0).setUnitValues(values.get(0));
        this.members.get(0).members.get(1).setUnitValues(values.get(1));
        this.members.get(0).members.get(2).setUnitValues(values.get(2));
    }
});

isc.invoiceWeight.create({
    material: materialCode["Anode Slime"]
});
