isc.defineClass("invoiceAssay", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: true,
    align: "center",
    width: "100%",
    height: "20%",
    material: null,
    unitComponentCopper: null,
    unitComponentSilver: null,
    unitComponentGold: null,
    unitComponentPlatinum: null,
    unitComponentPalladium: null,
    unitComponentSelenium: null,
    invoiceAssayObj: "",
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        invoiceAssayObj = {
            assayCopper: 0,
            assaySilver: 0,
            assayGold: 0,
            assayPlatinum: 0,
            assayPalladium: 0,
            assaySelenium: 0,
        };

        switch (this.material) {

            case 0:
                unitComponentCopper = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.copper"/>:' + "       (Cu)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                this.addMember(unitComponentCopper);
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

                this.addMember(unitComponentCopper);
                this.addMember(unitComponentSilver);
                this.addMember(unitComponentGold);
                break;

            case 4:
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

                unitComponentPlatinum = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.platinum"/>:' + "       (Pt)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentPalladium = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.palladium"/>:' + "       (Pd)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentSelenium = isc.componentUnit.create({
                    titelFieldValue: '<spring:message code="component.invoice.price.selenium"/>:' + "     (Se)",
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                this.addMember(unitComponentCopper);
                this.addMember(unitComponentSilver);
                this.addMember(unitComponentGold);
                this.addMember(unitComponentPlatinum);
                this.addMember(unitComponentPalladium);
                this.addMember(unitComponentSelenium);
                break;
        }

    },
    getAssayValues: function () {

        switch (this.material){
            case 0:
                invoiceAssayObj.assayCopper = this.members.get(0).getUnitValues();
                break;
            case 1:
                invoiceAssayObj.assayCopper = this.members.get(0).getUnitValues();
                invoiceAssayObj.assaySilver = this.members.get(1).getUnitValues();
                invoiceAssayObj.assayGold = this.members.get(2).getUnitValues();
                break;
            case 4:
                invoiceAssayObj.assayCopper = this.members.get(0).getUnitValues();
                invoiceAssayObj.assaySilver = this.members.get(1).getUnitValues();
                invoiceAssayObj.assayGold = this.members.get(2).getUnitValues();
                invoiceAssayObj.assayPlatinum = this.members.get(3).getUnitValues();
                invoiceAssayObj.assayPalladium = this.members.get(4).getUnitValues();
                invoiceAssayObj.assaySelenium = this.members.get(5).getUnitValues();
                break;
        }
        return  invoiceAssayObj;
    },
    setAssayValues: function (data) {
        this.members.get(0).setUnitValues(data.assayCopper);
        this.members.get(1).setUnitValues(data.assaySilver);
        this.members.get(2).setUnitValues(data.assayGold);
        this.members.get(3).setUnitValues(data.assayPlatinum);
        this.members.get(4).setUnitValues(data.assayPalladium);
        this.members.get(5).setUnitValues(data.assaySelenium);

    }
});

