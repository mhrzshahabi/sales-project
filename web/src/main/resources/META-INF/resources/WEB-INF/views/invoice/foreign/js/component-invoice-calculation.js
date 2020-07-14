isc.defineClass("InvoiceCalculation", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "scroll",
    invoiceBaseAssayComponent: null,
    invoiceBasePriceComponent: null,
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
                name: assayValues[index].materialElement.element.name
            }));
        }

        This.addMember(isc.DynamicForm.create({
            width: "100%",
            fields: fields,
            itemChanged: function (item, newValue) {

                let sum = Object.keys(this.getValues()).map(q => this.getValues()[q].deductionPrice).sum();
                this.parentElement.members[1].value = sum;
                this.parentElement.members[1].setContents(`
                    <span style="margin: 0;padding: 10px 14px 10px 10px;font-size: 14px;font-weight: bold;color: #003168;">` +
                    sum +
                    `</span>`
                );
            }
        }));
        This.addMember(isc.Lable.create({
            value: 0,
            contents: '',
            width: '100%'
        }));
    },
    getValue: function () {
        return this.members[0].getValues();
    },
    getSumValue: function () {
        return this.members[1].value;
    }
});
