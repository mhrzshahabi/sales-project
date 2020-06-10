isc.defineClass("invoiceAssay", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: true,
    align: "center",
    width: "500",
    height: "500",
    material: null,
    form: null,
    unitComponent: null,
    unitComponentCopper: null,
    unitComponentSilver: null,
    unitComponentGold: null,
    unitComponentPlatinum: null,
    unitComponentPalladium: null,
    unitComponentSelenium: null,
    vstack: null,
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
                unitComponentCopper = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.copper"/>:' + "       (Cu)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    disabled: true
                });

                // form.setFields(this.unitComponentCopper);
                vstack = isc.VStack.create({
                    width: "100%",
                    height: "100%",
                });
                vstack.addMember(this.unitComponentCopper);
                this.addMember(vstack);
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

                // form.setFields(this.unitComponentCopper, this.unitComponentSilver, this.unitComponentGold);
                vstack = isc.VStack.create({
                    align: "center",
                    width: "100%",
                    height: "100%",
                    // layoutTopMargin: "50"
                });
                vstack.addMember(this.unitComponentCopper, 0);
                vstack.addMember(this.unitComponentSilver, 2);
                vstack.addMember(this.unitComponentGold, 4);
                this.addMember(vstack);
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

                // form.setFields(this.unitComponentCopper, this.unitComponentSilver, this.unitComponentGold, this.unitComponentPlatinum,
                //     this.unitComponentPalladium, this.unitComponentSelenium);
                this.addMember(isc.VLayout.create({
                    align: "center",
                    width: "500",
                    height: "500",
                    members: [
                        this.unitComponentCopper,
                        this.unitComponentSilver,
                        this.unitComponentGold,
                        this.unitComponentPlatinum,
                        this.unitComponentPalladium,
                        this.unitComponentSelenium,
                    ]
                }));
                break;
        }

        /*var submit = isc.Button.create({
            title: "submit",
            click: function () {
                console.log(This.getValues());
            }
        });
        this.addMember(submit);*/
    },
    getValues: function () {
        return form.getValues();
    },
    setValues: function (values) {
        return form.setValues(values);
    }
});

isc.invoiceAssay.create({
    material: materialCode["Copper Concentrate"]
});
