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
    contractDetailData: null,
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
                shipment: This.shipment,
                contractDetailData: This.contractDetailData
            });
            this.addMember(this.invoiceBasePriceComponent);

            // if (This.contract.materialId !== ImportantIDs.material.COPPER_CATHOD) {
            //
            //     this.invoiceBaseAssayComponent = isc.InvoiceBaseAssay.create({
            //         shipment: This.shipment,
            //     });
            //     this.addMember(this.invoiceBaseAssayComponent);
            // }

            this.invoiceBaseWeightComponent = isc.InvoiceBaseWeight.create({
                shipment: This.shipment,
            });

            this.addMember(this.invoiceBaseWeightComponent);

        } else {

        }
    }
});
