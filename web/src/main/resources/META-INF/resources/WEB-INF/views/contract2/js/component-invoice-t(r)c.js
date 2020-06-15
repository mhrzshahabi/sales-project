isc.defineClass("invoiceTRC", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: true,
    align: "center",
    width: "100%",
    height: "50%",
    material: null,
    invoiceTRCRowsComponentT: null,
    invoiceTRCRowsComponentRCU: null,
    invoiceTRCRowsComponentRSILVER: null,
    invoiceTRCRowsComponentRGOLD: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        switch (this.material) {

            case 1:
                invoiceTRCRowsComponentT = isc.invoiceTRCRows.create({
                    rowTitle: "T/C:",
                    material: This.material
                });
                invoiceTRCRowsComponentRCU = isc.invoiceTRCRows.create({
                    rowTitle: "R/C-CU:",
                    material: This.material
                });
                invoiceTRCRowsComponentRSILVER = isc.invoiceTRCRows.create({
                    rowTitle: "R/C-SILVER:",
                    material: This.material
                });
                invoiceTRCRowsComponentRGOLD = isc.invoiceTRCRows.create({
                    rowTitle: "R/C-GOLD:",
                    material: This.material
                });

                this.addMember(isc.VLayout.create({
                    members: [
                        invoiceTRCRowsComponentT,
                        invoiceTRCRowsComponentRCU,
                        invoiceTRCRowsComponentRSILVER,
                        invoiceTRCRowsComponentRGOLD
                    ]
                }));


        }

        // var submit = isc.Button.create({
        //     title: "submit",
        //     click: function () {
        //         console.log(This.getTRCValues());
        //     }
        // });
        // this.addMember(submit);
    },
    getTRCValues: function () {
        let values = [];
        for (var index=0; index<this.members.get(0).members.length; index++){
            values.push(this.members.get(0).members.get(index).getTRCRowsValues())
        }
        return values;
    },
    setTRCValues: function (values) {
        for (var index=0; index<this.members.get(0).members.length; index++){
            values.push(this.members.get(0).members.get(index).setTRCRowsValues(values.get(index)))
        }
    }
});

isc.invoiceTRC.create({
    material: materialCode["Copper Concentrate"]
});
