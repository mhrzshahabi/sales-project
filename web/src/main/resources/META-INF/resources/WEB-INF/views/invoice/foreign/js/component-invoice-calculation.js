isc.defineClass("InvoiceCalculation", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    // canAdaptHeight: true,
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
                name: assayValues[index].name
            }));
        }

        /*this.addFields(isc.DynamicForm.create({
            width: "100%",
            fields: members,
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

        this.addField(isc.Unit.create({
            border: "1px solid rgba(0, 0, 0, 0.3)",
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            unitCategory: This.currency.categoryUnit,
            fieldValueTitle: "<spring:message code='foreign-invoice.form.tab.subtotal'/>"
        }));
        this.members.last().setUnitId(this.currency.id);*/
    },
    // getValue: function () {
    //     return this.members[0].getValues();
    // },
    // getSumValue: function () {
    //     return this.members[1].getValue();
    // }
});
