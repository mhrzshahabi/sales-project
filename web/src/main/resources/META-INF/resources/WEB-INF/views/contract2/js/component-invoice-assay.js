isc.defineClass("invoiceAssay", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: true,
    align: "center",
    width: "100%",
    height: "20%",
    material: null,
    form: null,
    backgroundColor: "#f0c85a",
    unitComponentCopper: null,
    unitComponentSilver: null,
    unitComponentGold: null,
    unitComponentPlatinum: null,
    unitComponentPalladium: null,
    unitComponentSelenium: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        switch (this.material) {

            case 0:
                unitComponentCopper = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.copper"/>:' + "       (Cu)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    disabled: true
                });

                this.addMember(isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    membersMargin: 2,
                    members:[
                        unitComponentCopper,
                    ]
                }));
                break;

            case 1:
                unitComponentCopper = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.copper"/>:' + "       (Cu)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentSilver = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.silver"/>:' + "       (Ag)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentGold = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.gold"/>:' + "     (Au)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                this.addMember(isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    membersMargin: 2,
                    members:[
                        unitComponentCopper,
                        unitComponentSilver,
                        unitComponentGold
                    ]
                }));
                break;

            case 4:
                unitComponentCopper = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.copper"/>:' + "       (Cu)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    disabled: true
                });

                unitComponentSilver = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.silver"/>:' + "       (Ag)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    disabled: true
                });

                unitComponentGold = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.gold"/>:' + "     (Au)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    disabled: true
                });

                unitComponentPlatinum = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.platinum"/>:' + "       (Pt)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    disabled: true
                });

                unitComponentPalladium = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.palladium"/>:' + "       (Pd)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    disabled: true
                });

                unitComponentSelenium = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.selenium"/>:' + "     (Se)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    disabled: true
                });

                this.addMember(isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    membersMargin: 2,
                    members:[
                        unitComponentCopper,
                        unitComponentSilver,
                        unitComponentGold,
                        unitComponentPlatinum,
                        unitComponentPalladium,
                        unitComponentSelenium
                    ]
                }));
                break;
        }

        // var submit = isc.Button.create({
        //     title: "submit",
        //     click: function () {
        //         console.log(This.getAssayValues());
        //     }
        // });
        // this.addMember(submit);
    },
    getAssayValues: function () {
        let values = [];
        for (var index=0; index<this.members.get(0).members.length; index++){
            values.push(this.members.get(0).members.get(index).getUnitValues())
        }
        return values;
    },
    setAssayValues: function (values) {
        for (var index=0; index<this.members.get(0).members.length; index++){
            values.push(this.members.get(0).members.get(index).setUnitValues(values.get(index)))
        }
    }
});

isc.invoiceAssay.create({
    material: materialCode["Anode Slime"]
});
