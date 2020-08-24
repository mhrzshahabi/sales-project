isc.defineClass("InvoiceDeduction", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    currency: null,
    contractDetailData: null,
    invoiceCalculationComponent: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.addMember(isc.DynamicForm.create({
            width: "50%",
            fields: [{
                width: "100%",
                height: "50",
                name: "TC",
                titleWidth: "10%",
                top: 5,
                align: "left",
                titleAlign: "left",
                type: "staticText",
                value: This.contractDetailData.tc,
                title: "<spring:message code='contract.TC'/>"
            }]
        }));

        let calculationValues = this.invoiceCalculationComponent.getValues();
        for (let index = 0; index < calculationValues.length; index++) {

            this.addMember(isc.InvoiceDeductionRow.create({
                currency: This.currency,
                elementFinalAssay: calculationValues[index].finalAssay,
                contractDetailData: This.contractDetailData.rc.filter(q => q.elementName.toUpperCase() === calculationValues[index].name.toUpperCase()).first(),
                sumDeductionChanged: function (sumDeduction) {

                    let subtotalForm = This.getMembers().filter(q => q.name === "subTotal").first();
                    subtotalForm.data[this.ID] = sumDeduction;
                    subtotalForm.setValue(Object.values(subtotalForm.data).sum());
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
            fieldValueTitle: "<spring:message code='foreign-invoice.form.tab.deductions.subtotal'/>",
        }));
        this.getMembers().last().setUnitId(this.currency.id);

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

        this.invoiceCalculationComponent.updateDeductionData = function (calculationToDeductionData) {

            This.getMembers().slice(1, 1 + calculationToDeductionData.length).forEach(current => {

                let elementCalculationData = calculationToDeductionData.filter(q => q.name.toUpperCase() === current.contractDetailData.elementName.toUpperCase()).first();
                current.elementFinalAssay = elementCalculationData.finalAssay;
                current.updateDeductionRows();
            });
        };
    },
    // getValue: function () {
    //     return this.members[0].getValues();
    // },
});
