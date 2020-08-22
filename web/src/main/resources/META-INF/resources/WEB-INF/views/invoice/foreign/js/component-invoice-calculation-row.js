isc.defineClass("InvoiceCalculationRow", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    canAdaptHeight: true,
    layoutMargin: 2,
    membersMargin: 2,
    assay: null,
    price: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        this.addMember(isc.Unit.create({
            unitCategory: This.assay.unit.categoryUnit,
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: 'priceBase',
            fieldValueTitle: This.assay.name,
        }));
        this.getMembers().last().setValue(this.assay.value);
        this.getMembers().last().setUnitId(this.assay.unitId);

        this.addMember(isc.DynamicForm.create({
            numCols: 4,
            width: "100%",
            fields: [{
                showTitle: false,
                type: "staticText",
                width: This.getMembers().first().titleWidth
            }, {
                wrap: false,
                required: true,
                showTitle: false,
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

                    This.getMembers().last().getMembers()[1].setUnitId(This.assay.unitId);
                    This.getMembers().last().getMembers()[1].setValue(This.assay.value - value);
                    This.calculate();
                }
            }, {
                showTitle: false,
                name: "deductionType",
                valueMap: JSON.parse('${Enum_DeductionType}')
            }]
        }));

        let priceMembers = [isc.DynamicForm.create({
            fields: [{
                showTitle: false,
                type: "staticText",
                width: This.getMembers().first().titleWidth
            }]
        })];
        priceMembers.add(isc.Unit.create({
            unitCategory: This.assay.unit.categoryUnit,
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: false,
            showUnitFieldTitle: false,
            deductionUnitConversionRate: 1,
            name: 'finalAssay',
        }));
        priceMembers.last().setUnitId(this.assay.unitId);

        if (this.assay.unitId !== ImportantIDs.unit.PERCENT && This.price.weightUnit.id !== This.assay.unit.id)
            priceMembers.add(isc.DynamicForm.create({
                fields: [{
                    value: " X ",
                    showTitle: false,
                    type: "staticText"
                }, {
                    showTitle: false,
                    name: "deductionUnitConversionRate",
                    changed: function (form, item, value) {

                        This.getMembers().last().getMembers()[1].deductionUnitConversionRate = value;
                        This.calculate();
                    }
                }]
            }));

        priceMembers.add(isc.DynamicForm.create({
            fields: [{
                value: " = ",
                showTitle: false,
                type: "staticText"
            }, {
                showTitle: false,
                type: "staticText",
                name: "deductionPrice",
                changed: function (form, item, value) {

                    This.sumPriceChanged(value);
                }
            }]
        }));

        this.addMember(isc.HLayout.create({
            width: "100%",
            members: priceMembers
        }));
    },
    calculate: function () {
        let assayField = this.getMembers().last().getMembers()[1];
        this.getMembers().last().getMembers().last().setValue("deductionPrice", assayField.getValue() * assayField.deductionUnitConversionRate);
    },
    // getValue: function () {
    //     return this.getValues();
    // },
    // setValue: function (value) {
    //     this.setValues(value);
    // }
});
