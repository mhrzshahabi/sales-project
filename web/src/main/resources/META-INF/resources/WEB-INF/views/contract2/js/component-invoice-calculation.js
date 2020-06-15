isc.defineClass("invoiceCalculation", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: true,
    align: "center",
    width: "100%",
    height: "100%",
    backgroundColor: "#f0c85a",
    overflow: "scroll",
    material: null,
    calRowsComponentCopper: null,
    calRowsComponentSilver: null,
    calRowsComponentGold: null,
    calRowsComponentPlatinum: null,
    calRowsComponentPalladium: null,
    calRowsComponentSelenium: null,
    invoiceCalculationObj: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        invoiceCalculationObj = {
            calculationCopper: "",
            calculationSilver: "",
            calculationGold: "",
            calculationPlatinum: "",
            calculationPalladium: "",
            calculationSelenium: "",
        };

        switch (this.material){

            case 1:

                calRowsComponentCopper = isc.invoiceCalculationRows.create({
                    isPercent: 0
                });

                calRowsComponentSilver = isc.invoiceCalculationRows.create({
                    isPercent: 1
                });

                calRowsComponentGold = isc.invoiceCalculationRows.create({
                    isPercent: 1
                });

                this.addMember(calRowsComponentCopper);
                this.addMember(calRowsComponentSilver);
                this.addMember(calRowsComponentGold);
                break;

            case 4:

                calRowsComponentCopper = isc.invoiceCalculationRows.create({
                    isPercent: 0
                });

                calRowsComponentSilver = isc.invoiceCalculationRows.create({
                    isPercent: 1
                });

                calRowsComponentGold = isc.invoiceCalculationRows.create({
                    isPercent: 1
                });

                calRowsComponentPlatinum = isc.invoiceCalculationRows.create({
                    isPercent: 1
                });

                calRowsComponentPalladium = isc.invoiceCalculationRows.create({
                    isPercent: 1
                });

                calRowsComponentSelenium = isc.invoiceCalculationRows.create({
                    isPercent: 0
                });

                this.addMember(calRowsComponentCopper);
                this.addMember(calRowsComponentSilver);
                this.addMember(calRowsComponentGold);
                this.addMember(calRowsComponentPlatinum);
                this.addMember(calRowsComponentPalladium);
                this.addMember(calRowsComponentSelenium);
                break;
        }

        // var submit = isc.Button.create({
        //     title: "submit",
        //     click: function () {
        //         console.log(This.getCalValues());
        //     }
        // });
        // this.addMember(submit);
    },
    getCalValues: function () {

        switch (this.material){
            case 1:
                invoiceCalculationObj.calculationCopper = this.members.get(0).getCalRowsValues();
                invoiceCalculationObj.calculationSilver = this.members.get(1).getCalRowsValues();
                invoiceCalculationObj.calculationGold = this.members.get(2).getCalRowsValues();
                break;

            case 4:
                invoiceCalculationObj.calculationCopper = this.members.get(0).getCalRowsValues();
                invoiceCalculationObj.calculationSilver = this.members.get(1).getCalRowsValues();
                invoiceCalculationObj.calculationGold = this.members.get(2).getCalRowsValues();
                invoiceCalculationObj.calculationPlatinum = this.members.get(3).getCalRowsValues();
                invoiceCalculationObj.calculationPalladium = this.members.get(4).getCalRowsValues();
                invoiceCalculationObj.calculationSelenium = this.members.get(5).getCalRowsValues();
                break;
        }
        return invoiceCalculationObj;
    },
    setCalValues: function (values) {
    }
});

// isc.invoiceCalculation.create({
//     material: 1,
// });
