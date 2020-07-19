isc.defineClass("InvoiceBaseValues", isc.VLayout).addProperties({
    width: "100%",
    align: "top",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "scroll",
    currency: null,
    contract: null,
    shipment: null,
    invoiceType: null,
    invoiceBasePriceComponent: null,
    invoiceBaseAssayComponent: null,
    invoiceBaseWeightComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        if (this.invoiceType.id === ImportantIDs.invoiceType.FINAL) {

            this.invoiceBasePriceComponent = isc.InvoiceBasePrice.create({

                currency: This.currency,
                contract: This.contract,
                shipment: This.shipment
            });
            this.addMember(this.invoiceBasePriceComponent);

            this.invoiceBaseAssayComponent = isc.InvoiceBaseAssay.create({
                inventories: [{id: 1}, {id: 2}]
            });
            this.addMember(invoiceBaseAssayComponent);  //Error

            this.invoiceBaseWeightComponent = isc.InvoiceBaseWeight.create({
                inventories: [{id: 1}, {id: 2}]
            });
            this.addMember(invoiceBaseWeightComponent);
        } else {

        }
    }
});
