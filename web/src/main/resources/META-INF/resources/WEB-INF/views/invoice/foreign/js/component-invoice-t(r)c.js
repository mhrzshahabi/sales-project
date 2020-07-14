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

        this.addMember(isc.DynamicForm.create({
            width: "100%",
            fields: fields,
            itemChanged: function (item, newValue) {

                let sum = Object.keys(this.getValues()).map(q => this.getValues()[q].deductionPrice).sum();
                this.parentElement.members[1].setValue(sum);
            }
        }));
        this.addMember(isc.Unit.create({
            border: "1px solid rgba(0, 0, 0, 0.3)",
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            unitCategory: JSON.parse('${Enum_CategoryUnit}').Currency,
            fieldValueTitle: "<spring:message code='foreign-invoice.form.tab.deductions.subtotal'/>",
        }));
        this.members.last().setUnitId(this.currency.id);
    },
    getValue: function () {
        return this.members[0].getValues();
    },
    getSumValue: function () {
        return this.members[1].value;
    }
});
