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

                    This.getMembers()[4].data[this.ID] = sumPrice;
                    This.getMembers()[4].setValue(Object.values(This.getMembers()[4].data).sum());
                }
            }));
        }

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

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

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

    },
    getValues: function () {

        let data = [];
        this.getMembers().slice(0, (this.getMembers().length)-1).forEach(current => {

            data.add({
                finalAssay: current.getFinalAssay(),
                priceBase: current.getPriceBase(),
            });
        });

        console.log("data ", data)
        return data;
    },
    // getSumValue: function () {
    //     return this.members[1].getValue();
    // }
});
