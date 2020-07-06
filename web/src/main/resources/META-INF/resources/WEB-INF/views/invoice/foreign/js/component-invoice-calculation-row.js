isc.defineClass("InvoiceCalculationRow", isc.DynamicForm).addProperties({
    numCols: 4,
    width: "100%",
    wrapItemTitles: false,
    assay: null,
    price: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.addField(isc.Unit.create({
            colSpan: 4,
            unitCategory: 1,
            disabledUnitField: true,
            disabledValueField: true,
            disabledCurrencyField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            showCurrencyFieldTitle: false,
            showCurrencyField: false,
            name: 'priceBase',
            fieldValueTitle: This.assay.materialElement.element.name,
            border: "1px solid rgba(0, 0, 0, 0.3)",
        }));
        this.fields.last().setValue(this.assay.value);
        this.fields.last().setUnitId(this.assay.materialElement.unit.id);
        this.addField({
            colSpan: 2,
            wrap: false,
            required: true,
            showTitle: false,
            width: '100%',
            type: 'float',
            name: "deductionValue",
            keyPressFilter: "[0-9.]",
            validators: [{
                type: "isFloat",
                wrap: false,
                stopOnError: true,
                validateOnChange: true,
                errorMessage: "<spring:message code='global.form.correctType'/>"
            }],
            changed: function (form, item, value) {

                form.setValue('finalAssay', {
                    value: This.assay.value - value,
                    unitId: This.assay.materialElement.unit.id,
                });
                This.calculate();
            }
        });
        this.addField({
            value: 1,
            colSpan: 2,
            showTitle: false,
            width: "100%",
            name: "deductionType",
            valueMap: Enums.deductionType
        });
        this.addField(isc.Unit.create({
            colSpan: 4,
            unitCategory: 1,
            disabledUnitField: true,
            disabledValueField: true,
            disabledCurrencyField: true,
            showValueFieldTitle: false,
            showUnitFieldTitle: false,
            showCurrencyFieldTitle: false,
            showCurrencyField: false,
            deductionUnitConversionRate: 1,
            name: 'finalAssay',
            border: "1px solid rgba(0, 0, 0, 0.3)",
        }));
        if (This.assay.materialElement.unit.id !== This.price.unit.id &&
            This.assay.materialElement.unit.id !== ImportantIDs.unit.PERCENT)
            this.addField(isc.Unit.create({
                colSpan: 4,
                unitCategory: 1,
                disabledUnitField: true,
                disabledValueField: true,
                disabledCurrencyField: true,
                showValueFieldTitle: false,
                showUnitFieldTitle: false,
                showCurrencyFieldTitle: false,
                showUnitField: false,
                showCurrencyField: false,
                name: "deductionUnitConversionRate",
                border: "1px solid rgba(0, 0, 0, 0.3)",
                changed: function (form, item, value) {

                    form.getField('finalAssay').deductionUnitConversionRate = value;
                    This.calculate();
                }
            }));
        this.addField({
            colSpan: 4,
            title: " = ",
            type: "staticText",
            name: "deductionPrice",
        });
    },
    calculate: function () {
        let assayField = this.getField('finalAssay');
        this.setValue("deductionPrice", assayField.getValue() * assayField.deductionUnitConversionRate);
    },
    getValue: function () {
        return this.getValues();
    },
    setValue: function (value) {
        this.setValues(value);
    }
});
