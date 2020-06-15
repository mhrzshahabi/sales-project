isc.defineClass("invoiceTRCRows", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: true,
    align: "center",
    width: "70%",
    height: "15%",
    material: null,
    backgroundColor: "#f0c85a",
    rowTitle: "",
    unitComponentCol1: null,
    unitComponentCol2: null,
    unitComponentColFinal: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

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

        // var submit = isc.Button.create({
        //     title: "submit",
        //     click: function () {
        //         console.log(This.getTRCRowsValues());
        //     }
        // });
        // this.addMember(submit);
    },
    getTRCRowsValues: function () {
        let values = [];
        values.push(this.members.get(0).members.get(1).getUnitValues());
        values.push(this.members.get(0).members.get(3).getUnitValues());
        values.push(this.members.get(0).members.get(5).getUnitValues());
        return values;
    },
    setTRCRowsValues: function (values) {
        this.members.get(0).members.get(1).setUnitValues(values.get(0));
        this.members.get(0).members.get(3).setUnitValues(values.get(1));
        this.members.get(0).members.get(5).setUnitValues(values.get(2));
    }
});

// isc.invoiceTRCRows.create({
//     material: materialCode["Copper Concentrate"]
// });
