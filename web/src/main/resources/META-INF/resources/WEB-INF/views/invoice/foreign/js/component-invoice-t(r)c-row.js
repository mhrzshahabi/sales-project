isc.defineClass("InvoiceDeductionRow", isc.DynamicForm).addProperties({
    numCols: 7,
    width: "100%",
    wrapItemTitles: false,
    currency: null,
    contract: null,
    elementName: null,
    calculationData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.addField(isc.Unit.create({
            colSpan: 1,
            unitCategory: 1,
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: false,
            showUnitFieldTitle: false,
            showUnitField: false,
            name: 'rcPrice',
            border: "1px solid rgba(0, 0, 0, 0.3)"
        }));
        this.fields.last().setCurrencyId(this.currency.id);
        let rcPrice = __contract.getRc(this.contract, this.elementName);
        this.fields.last().setValue(rcPrice);
        this.addField(isc.Unit.create({
            colSpan: 2,
            unitCategory: 1,
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: 'finalAssay',
            fieldValueTitle: ' x ',
            deductionUnitConversionRate: 1,
            border: "1px solid rgba(0, 0, 0, 0.3)"
        }));
        let finalAssayValue = this.calculationData.finalAssay.getValue();
        this.fields.last().setValue(finalAssayValue);
        this.fields.last().setUnitId(this.calculationData.finalAssay.getUnitId());
        this.addField(isc.Unit.create({
            colSpan: 2,
            unitCategory: 1,
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: false,
            showUnitFieldTitle: false,
            showUnitField: false,
            name: "deductionUnitConversionRate",
            border: "1px solid rgba(0, 0, 0, 0.3)",
            changed: function (form, item, value) {

                form.getField('finalAssay').deductionUnitConversionRate = value;
                This.calculate();
            }
        }));
        this.addField({
            colSpan: 2,
            title: " = ",
            type: "staticText",
            name: "deductionPrice",
            value: finalAssayValue * rcPrice
        });
    },
    calculate: function () {
        let rcPriceField = this.getField('rcPrice');
        let assayField = this.getField('finalAssay');
        this.setValue("deductionPrice", rcPriceField.getValue() * assayField.getValue() * assayField.deductionUnitConversionRate);
    },
    getValue: function () {
        this.getField("deductionPrice").getValue();
    },
    setValue: function (value) {
        this.setValues(value);
    }
});

