isc.defineClass("invoiceCalculationRows", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: true,
    align: "center",
    width: "100%",
    height: "20%",
    backgroundColor: "#f0c85a",
    isPercent: null,
    unitComponentAssay: null,
    unitComponentDeduc: null,
    unitComponentNPCol1: null,
    unitComponentNPCol2: null,
    unitComponentFinalCol1: null,
    unitComponentFinalCol2: null,
    unitComponentFinalCol3: null,
    hLayoutFinal: null,
    hLayoutNP: null,
    invoiceCalculationRowsObj: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        invoiceCalculationRowsObj = {
            calculationRowsAssay: 0,
            calculationRowsDeduc: 0,
            calculationRowsFinalCol1: 0,
            calculationRowsFinalCol2: 0,
            calculationRowsFinalCol3: 0,
            calculationRowsNPCol1: 0,
            calculationRowsNPCol2: 0,
        }

        switch (this.isPercent){

            case 0:
                unitComponentAssay = isc.componentUnit.create({
                    titelFieldValue: "Assay",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                });

                unitComponentDeduc = isc.componentUnit.create({
                    titelFieldValue: "Deduc",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentFinalCol1 = isc.componentUnit.create({
                    titelFieldValue: "Final1",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentFinalCol2 = isc.componentUnit.create({
                    titelFieldValue: "Final2",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentFinalCol3 = isc.componentUnit.create({
                    titelFieldValue: "Final3",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                hLayoutFinal = isc.HLayout.create({
                    width: "100%",
                    height: "100%",
                    members: [
                        unitComponentFinalCol1,
                        isc.Label.create({
                            padding: 3,
                            // width: "100",
                            height: "25%",
                            align: "center",
                            contents: "<b>" + "    *    " + "<b>",
                        }),
                        unitComponentFinalCol2,
                        isc.Label.create({
                            padding: 3,
                            // width: "100",
                            height: "25%",
                            align: "center",
                            contents: "<b>" + "    =    " + "<b>",
                        }),
                        unitComponentFinalCol3
                    ]
                });

                this.addMember(unitComponentAssay);
                this.addMember(unitComponentDeduc);
                this.addMember(hLayoutFinal);
                break;

            case 1:
                unitComponentAssay = isc.componentUnit.create({
                    titelFieldValue: "Assay",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                });

                unitComponentDeduc = isc.componentUnit.create({
                    titelFieldValue: "Deduc",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentNPCol1 = isc.componentUnit.create({
                    titelFieldValue: "NP1",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentNPCol2 = isc.componentUnit.create({
                    titelFieldValue: "NP2",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentFinalCol1 = isc.componentUnit.create({
                    titelFieldValue: "Final1",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentFinalCol2 = isc.componentUnit.create({
                    titelFieldValue: "Final2",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentFinalCol3 = isc.componentUnit.create({
                    titelFieldValue: "Final3",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                hLayoutNP = isc.HLayout.create({
                    width: "100%",
                    height: "100%",
                    members: [
                        unitComponentNPCol1,
                        isc.Label.create({
                            // align: "center",
                            contents: "<b>" + "OR" + "<b>",
                        }),
                        unitComponentNPCol2,
                    ]
                });

                hLayoutFinal = isc.HLayout.create({
                    width: "100%",
                    height: "100%",
                    members: [
                        unitComponentFinalCol1,
                        isc.Label.create({
                            align: "center",
                            contents: "<b>" + "*" + "<b>",
                        }),
                        unitComponentFinalCol2,
                        isc.Label.create({
                            align: "center",
                            contents: "<b>" + "=" + "<b>",
                        }),
                        unitComponentFinalCol3
                    ]
                });

                this.addMember(unitComponentAssay);
                this.addMember(unitComponentDeduc);
                this.addMember(hLayoutNP);
                this.addMember(hLayoutFinal);
                break;
        }

    },
    getCalRowsValues: function () {

        invoiceCalculationRowsObj.calculationRowsAssay = this.members.get(0).getUnitValues();
        invoiceCalculationRowsObj.calculationRowsDeduc = this.members.get(1).getUnitValues();

        switch (this.isPercent) {
            case 0:
                invoiceCalculationRowsObj.calculationRowsFinalCol1 = this.members.get(2).members.get(0).getUnitValues();
                invoiceCalculationRowsObj.calculationRowsFinalCol2 = this.members.get(2).members.get(2).getUnitValues();
                invoiceCalculationRowsObj.calculationRowsFinalCol3 = this.members.get(2).members.get(4).getUnitValues();
                break;

            case 1:
                invoiceCalculationRowsObj.calculationRowsNPCol1 = this.members.get(2).members.get(0).getUnitValues();
                invoiceCalculationRowsObj.calculationRowsNPCol2 = this.members.get(2).members.get(2).getUnitValues();
                invoiceCalculationRowsObj.calculationRowsFinalCol1 = this.members.get(3).members.get(0).getUnitValues();
                invoiceCalculationRowsObj.calculationRowsFinalCol2 = this.members.get(3).members.get(2).getUnitValues();
                invoiceCalculationRowsObj.calculationRowsFinalCol3 = this.members.get(3).members.get(4).getUnitValues();
                break;
        }

        return invoiceCalculationRowsObj;
    },
    setCalRowsValues: function (data) {
        this.members.get(0).setUnitValues(data.calculationRowsAssay);
        this.members.get(1).setUnitValues(data.calculationRowsDeduc);

        switch (this.isPercent) {
            case 0:
                this.members.get(2).members.get(0).setUnitValues(data.calculationRowsFinalCol1);
                this.members.get(2).members.get(2).setUnitValues(data.calculationRowsFinalCol2);
                this.members.get(2).members.get(4).setUnitValues(data.calculationRowsFinalCol3);
                break;
            case 1:
                this.members.get(2).members.get(0).setUnitValues(data.calculationRowsNPCol1);
                this.members.get(2).members.get(2).setUnitValues(data.calculationRowsNPCol2);
                this.members.get(3).members.get(0).setUnitValues(data.calculationRowsFinalCol1);
                this.members.get(3).members.get(2).setUnitValues(data.calculationRowsFinalCol2);
                this.members.get(3).members.get(4).setUnitValues(data.calculationRowsFinalCol3);
        }
    }
});