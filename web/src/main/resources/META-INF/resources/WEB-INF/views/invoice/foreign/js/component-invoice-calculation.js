isc.defineClass("InvoiceCalculation", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    currency: null,
    invoiceBaseAssayComponent: null,
    invoiceBasePriceComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        let assayValues = this.invoiceBaseAssayComponent.getValues();
        let priceValues = this.invoiceBasePriceComponent.getValues();
        for (let index = 0; index < priceValues.length; index++) {

            this.addMember(isc.InvoiceCalculationRow.create({
                assay: assayValues[index],
                price: priceValues[index],
                name: assayValues[index].name,
                sumPriceChanged: function (sumPrice) {

                    This.getMembers().last().data[this.ID] = sumPrice;
                    This.getMembers().last().setValue(Object.values(This.getMembers().last().data).sum());
                }
            }));
        }

        this.addMember(isc.Unit.create({
            data: {},
            name: "subTotal",
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            unitCategory: This.currency.categoryUnit,
            fieldValueTitle: "<spring:message code='foreign-invoice.form.tab.subtotal'/>"
        }));
        this.getMembers().last().setUnitId(this.currency.id);
    },
    // getValue: function () {
    //     return this.members[0].getValues();
    // },
    // getSumValue: function () {
    //     return this.members[1].getValue();
    // }
});
