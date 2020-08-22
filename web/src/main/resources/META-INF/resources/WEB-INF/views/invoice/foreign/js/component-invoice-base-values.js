isc.defineClass("InvoiceBaseValues", isc.VLayout).addProperties({
    width: "100%",
    align: "top",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
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
            this.addMember(isc.HTMLFlow.create({
                width: "100%",
                contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
            }));

            if (This.contract.materialId !== ImportantIDs.material.COPPER_CATHOD) {

                this.invoiceBaseAssayComponent = isc.InvoiceBaseAssay.create({
                    shipment: This.shipment,
                });
                this.addMember(this.invoiceBaseAssayComponent);
                this.addMember(isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }));
            }

            this.invoiceBaseWeightComponent = isc.InvoiceBaseWeight.create({
                shipment: This.shipment,
            });
            this.addMember(this.invoiceBaseWeightComponent);
            this.addMember(isc.HTMLFlow.create({
                width: "100%",
                contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
            }));
        } else {

        }
    }
});
