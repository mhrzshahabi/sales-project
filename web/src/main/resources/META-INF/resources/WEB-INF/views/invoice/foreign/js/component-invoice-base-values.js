isc.defineClass("InvoiceBaseValues", isc.VLayout).addProperties({

    width: "100%",
    align: "top",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    initWidget: function () {

        this.Super("initWidget", arguments);
        this.addMember(isc.InvoiceBasePrice.create({}));
        this.addMember(isc.InvoiceBaseAssay.create({}));
        this.addMember(isc.InvoiceBaseWeight.create({}));
    }
});
