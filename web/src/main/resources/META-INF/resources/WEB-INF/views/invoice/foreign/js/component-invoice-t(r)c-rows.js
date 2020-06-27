isc.defineClass("invoiceTRCRows", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: true,
    align: "center",
    width: "70%",
    height: "15%",
    material: null,
    rowTitle: "",
    unitComponentCol1: null,
    unitComponentCol2: null,
    unitComponentColFinal: null,
    invoiceTRCRowsObj: "",
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        invoiceTRCRowsObj = {
            tRCRowsCol1: 0,
            tRCRowsCol2: 0,
            tRCRowsColFinal: 0,
        };

        switch (this.material) {

            case 1:
                unitComponentCol1 = isc.componentUnit.create({
                    titelFieldValue: "Row1",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentCol2 = isc.componentUnit.create({
                    titelFieldValue: "Row2",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                unitComponentColFinal = isc.componentUnit.create({
                    titelFieldValue: "RowFinal",
                    showTitleFieldValue: false,
                    typeUnitCategory: 1,
                    showTitle: false,
                    // disabled: true
                });

                this.addMember(isc.HLayout.create({
                    width: "100%",
                    height: "100%",
                    members: [
                        isc.Label.create({
                            padding: 3,
                            // width: "100",
                            height: "25%",
                            align: "center",
                            contents: This.rowTitle,
                        }),
                        unitComponentCol1,
                        isc.Label.create({
                            padding: 3,
                            // width: "100",
                            height: "25%",
                            align: "center",
                            contents: "<b>" + "    *    " + "<b>",
                        }),
                        unitComponentCol2,
                        isc.Label.create({
                            padding: 3,
                            // width: "100",
                            height: "25%",
                            align: "center",
                            contents: "<b>" + "    =    " + "<b>",
                        }),
                        unitComponentColFinal
                    ]
                }));
                break;

        }

    },
    getTRCRowsValues: function () {
        invoiceTRCRowsObj.tRCRowsCol1 = this.members.get(0).members.get(1).getUnitValues();
        invoiceTRCRowsObj.tRCRowsCol2 = this.members.get(0).members.get(3).getUnitValues();
        invoiceTRCRowsObj.tRCRowsColFinal = this.members.get(0).members.get(5).getUnitValues();
        return invoiceTRCRowsObj;
    },
    setTRCRowsValues: function (data) {
        this.members.get(0).members.get(1).setUnitValues(data.tRCRowsCol1);
        this.members.get(0).members.get(3).setUnitValues(data.tRCRowsCol2);
        this.members.get(0).members.get(5).setUnitValues(data.tRCRowsColFinal);
    }
});

