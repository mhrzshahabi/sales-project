isc.defineClass("InvoiceCalculation2", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "scroll",
    contract: null,
    shipment: null,
    currency: null,
    inventories: [],
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);

        let fields = [];
        let assayValues = this.invoiceBaseAssayComponent.getValues();
        let priceValues = this.invoiceBasePriceComponent.getValues();
        for (let index = 0; index < priceValues.length; index++) {

            fields.add(isc.InvoiceCalculationRow.create({
                assay: assayValues[index],
                price: priceValues[index],
                border: "1px solid rgba(0, 0, 0, 0.3)",
            }));
        }





        This.addMember(isc.DynamicForm.create({
            width: "100%",
            fields: fields
        }));
    },
    getValue: function () {
        this.getValues().sum();
    }
});
