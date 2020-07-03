isc.defineClass("InvoiceBaseValues", isc.VLayout).addProperties({

    width: "100%",
    align: "top",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    contract: null,
    shipment: null,
    invoiceType: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        if (this.invoiceType.id === ImportantIDs.invoiceType.FINAL) {

            this.addMember(isc.InvoiceBasePrice.create({

                contract: This.contract,
                shipment: This.shipment
            }));
            this.addMember(isc.InvoiceBaseAssay.create({
                inventories: [{id: 1}, {id: 2}]
            }));
            // this.addMember(isc.InvoiceBaseWeight.create({
            //
            // }));
        } else {

        }
    }
});
