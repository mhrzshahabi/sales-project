isc.defineClass("invoiceWeight", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: false,
    align: "center",
    width: "100%",
    height: "100%",
    material: null,
    backgroundColor: "#f0c85a",
    form: null,
    unitComponentGross: null,
    unitComponentNet: null,
    unitComponentBundles: null,
    unitComponentNetWet: null,
    unitComponentMoisture: null,
    unitComponentNetDry: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        form = isc.DynamicForm.create({
                margin: 10,
                width: "100%",
                canSubmit: true,
                align: "center",
                titleAlign: "right",
                numCols: 2
                });

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
                    width: "500",
                    height: "500",
                    membersMargin: 2,
                    members:[
                        this.unitComponentGross,
                        this.unitComponentNet,
                        this.unitComponentBundles,
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
                    width: "500",
                    height: "500",
                    membersMargin: 2,
                    members: [
                        this.unitComponentNetWet,
                        this.unitComponentMoisture,
                        this.unitComponentNetDry,
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
                    width: "500",
                    height: "500",
                    membersMargin: 2,
                    members: [
                        this.unitComponentNetWet,
                        this.unitComponentMoisture,
                        this.unitComponentNetDry,
                    ]
                }));
                break;
        }

        var submit = isc.Button.create({
            title: "submit",
            click: function () {
                console.log(This.getValues());
            }
        });
        this.addMember(submit);
    },
    getValues: function () {
        return form.getValues();
    },
    setValues: function (values) {
        return form.setValues(values);
    }
});

isc.invoiceWeight.create({
    material: materialCode["Copper Concentrate"]
});
