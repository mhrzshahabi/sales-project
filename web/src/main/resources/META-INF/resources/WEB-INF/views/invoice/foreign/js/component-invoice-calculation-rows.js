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

                form.setValue(This.assay.materialElement.element.name, {
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
            name: This.assay.materialElement.element.name,
            border: "1px solid rgba(0, 0, 0, 0.3)",
        }));
        if (This.assay.materialElement.unit.id !== 1 && This.assay.materialElement.unit.id !== This.price.unit.id)
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
                name: "deductionUnitConversionRate",
                border: "1px solid rgba(0, 0, 0, 0.3)",
                changed: function (form, item, value) {

                    form.getField(This.assay.materialElement.element.name).deductionUnitConversionRate = value;
                    This.calculate();
                }
            }));
        this.addField({
            colSpan: 4,
            title: "=",
            type: "staticText",
            name: "deductionPrice",
        });

        this.setValues(this.data);
    },
    calculate: function () {
        let assayField = this.getField(this.assay.materialElement.element.name);
        this.setValue("deductionPrice", assayField.getValue() * assayField.deductionUnitConversionRate);
    },
    getValue: function () {
        this.getValue("deductionPrice");
    },
    setValue: function (value) {
        this.setValues(value);
    }
});
