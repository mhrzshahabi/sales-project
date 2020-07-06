isc.defineClass("InvoiceDeduction", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "scroll",
    currency: null,
    contract: null,
    invoiceCalculationComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let fields = [{
            name: "TC",
            type: "staticText",
            title: "<spring:message code='contract.TC'/>",
            value: {deductionPrice: __contract.getTC(This.contract)}
        }];
        let calculationValues = this.invoiceCalculationComponent.getValues();
        for (let key in Object.keys(calculationValues)) {

            fields.add(isc.InvoiceDeductionRow.create({
                name: 'R/C ' + key,
                border: "1px solid rgba(0, 0, 0, 0.3)",
                elementName: key,
                currency: This.currency,
                contract: This.contract,
                calculationData: calculationValues[key]
            }));
        }

        This.addMember(isc.DynamicForm.create({
            width: "100%",
            fields: fields,
            itemChanged: function (item, newValue) {

                let sum = Object.keys(this.getValues()).map(q => this.getValues()[q].deductionPrice).sum();
                this.parentElement.members[1].value = sum;
                this.parentElement.members[1].setContents(`
                    <span style="margin: 0;padding: 10px 14px 10px 10px;font-size: 14px;font-weight: bold;color: #dc3545;">` +
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
