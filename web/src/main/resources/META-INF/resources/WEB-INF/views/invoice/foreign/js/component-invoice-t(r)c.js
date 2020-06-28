isc.defineClass("invoiceTRC", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: true,
    align: "center",
    width: "100%",
    height: "70%",
    material: null,
    invoiceTRCRowsComponentT: null,
    invoiceTRCRowsComponentRCuAg: null,
    invoiceTRCRowsComponentRSilverAu: null,
    invoiceTRCRowsComponentRGoldPt: null,
    invoiceTRCRowsComponentRPD: null,
    invoiceTRCObj: "",
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        invoiceTRCObj = {
            tRCT: 0,
            tRCRCuAg: 0,
            tRCRSilverAu: 0,
            tRCRGoldPt: 0,
            tRCRPd: 0,
        }

        switch (this.material) {

            case 1:
                invoiceTRCRowsComponentT = isc.invoiceTRCRows.create({
                    rowTitle: "T/C:",
                    material: This.material
                });
                invoiceTRCRowsComponentRCuAg = isc.invoiceTRCRows.create({
                    rowTitle: "R/C-CU:",
                    material: This.material
                });
                invoiceTRCRowsComponentRSilverAu = isc.invoiceTRCRows.create({
                    rowTitle: "R/C-SILVER:",
                    material: This.material
                });
                invoiceTRCRowsComponentRGoldPt = isc.invoiceTRCRows.create({
                    rowTitle: "R/C-GOLD:",
                    material: This.material
                });

                this.addMember(invoiceTRCRowsComponentT);
                this.addMember(invoiceTRCRowsComponentRCuAg);
                this.addMember(invoiceTRCRowsComponentRSilverAu);
                this.addMember(invoiceTRCRowsComponentRGoldPt);
                break;

            case 4:
                invoiceTRCRowsComponentT = isc.invoiceTRCRows.create({
                    rowTitle: "T/C:",
                    material: This.material
                });
                invoiceTRCRowsComponentRCuAg = isc.invoiceTRCRows.create({
                    rowTitle: "R/C Ag:",
                    material: This.material
                });
                invoiceTRCRowsComponentRSilverAu = isc.invoiceTRCRows.create({
                    rowTitle: "R/C Au:",
                    material: This.material
                });
                invoiceTRCRowsComponentRGoldPt = isc.invoiceTRCRows.create({
                    rowTitle: "R/C Pt:",
                    material: This.material
                });
                invoiceTRCRowsComponentRPD = isc.invoiceTRCRows.create({
                    rowTitle: "R/C Pd:",
                    material: This.material
                });

                this.addMember(invoiceTRCRowsComponentT);
                this.addMember(invoiceTRCRowsComponentRCuAg);
                this.addMember(invoiceTRCRowsComponentRSilverAu);
                this.addMember(invoiceTRCRowsComponentRGoldPt);
                this.addMember(invoiceTRCRowsComponentRPD);
                break;

        }

    },
    getTRCValues: function () {

        switch (this.material) {

            case 1:
                invoiceTRCObj.tRCT = this.members.get(0).getTRCRowsValues();
                invoiceTRCObj.tRCRCuAg = this.members.get(1).getTRCRowsValues();
                invoiceTRCObj.tRCRSilverAu = this.members.get(2).getTRCRowsValues();
                invoiceTRCObj.tRCRGoldPt = this.members.get(3).getTRCRowsValues();
                break;

            case 4:
                invoiceTRCObj.tRCT = this.members.get(0).getTRCRowsValues();
                invoiceTRCObj.tRCRCuAg = this.members.get(1).getTRCRowsValues();
                invoiceTRCObj.tRCRSilverAu = this.members.get(2).getTRCRowsValues();
                invoiceTRCObj.tRCRGoldPt = this.members.get(3).getTRCRowsValues();
                invoiceTRCObj.tRCRPd = this.members.get(4).getTRCRowsValues();
                break;
        }

        return invoiceTRCObj;
    },
    setTRCValues: function (data) {
        this.members.get(0).setTRCRowsValues(data.tRCT);
        this.members.get(1).setTRCRowsValues(data.tRCRCuAg);
        this.members.get(2).setTRCRowsValues(data.tRCRSilverAu);
        this.members.get(3).setTRCRowsValues(data.tRCRGoldPt);
        this.members.get(4).setTRCRowsValues(data.tRCRPd);
    }
});