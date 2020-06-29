isc.defineClass("InvoiceBaseValues", isc.VLayout).addProperties({

    width: "100%",
    align: "top",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    contract: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.addMember(isc.InvoiceBasePrice.create({
            contract: This.contract
        }));
        // this.addMember(isc.InvoiceBaseAssay.create({
        //
        // }));
        // this.addMember(isc.InvoiceBaseWeight.create({
        //
        // }));
    }
});
