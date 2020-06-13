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
                    material: This.material
                });
                invoiceTRCRowsComponentRCU = isc.invoiceTRCRows.create({
                    material: This.material
                });
                invoiceTRCRowsComponentRSILVER = isc.invoiceTRCRows.create({
                    material: This.material
                });
                invoiceTRCRowsComponentRGOLD = isc.invoiceTRCRows.create({
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

        var submit = isc.Button.create({
            title: "submit",
            click: function () {
                console.log(This.getTRCValues());
            }
        });
        this.addMember(submit);
    },
    getTRCValues: function () {
        let result = [];
        result.push(this.members.get(0).members.get(0).getRowsValues());
        result.push(this.members.get(0).members.get(1).getRowsValues());
        result.push(this.members.get(0).members.get(2).getRowsValues());
        result.push(this.members.get(0).members.get(3).getRowsValues());
        return result;
    },
    setTRCValues: function (values) {
        this.members.get(0).members.get(0).setRowsValues(values.get(0));
        this.members.get(0).members.get(1).setRowsValues(values.get(1));
        this.members.get(0).members.get(2).setRowsValues(values.get(2));
        this.members.get(0).members.get(3).setRowsValues(values.get(3));
    }
});

isc.invoiceTRC.create({
    material: materialCode["Copper Concentrate"]
});
