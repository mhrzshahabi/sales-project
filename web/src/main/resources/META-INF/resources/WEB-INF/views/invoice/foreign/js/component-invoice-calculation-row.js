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
            width: "400",
            unitCategory: This.assay.unit.categoryUnit,
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "assay",
            fieldValueTitle: This.assay.name,
        }));
        this.getMembers().last().setValue(this.assay.value);
        this.getMembers().last().setUnitId(this.assay.unitId);

        this.addMember(isc.DynamicForm.create({
            numCols: 6,
            width: "50%",
            fields: [{
                showTitle: false,
                type: "staticText",
                width: This.getMembers().first().titleWidth
            }, {
                wrap: false,
                required: true,
                showTitle: false,
                errorOrientation: "bottom",
                type: 'float',
                name: "deductionValue",
                keyPressFilter: "[0-9.]",
                width: "100",
                validators: [{
                    type: "isFloat",
                    wrap: false,
                    stopOnError: true,
                    validateOnChange: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }],
                changed: function (form, item, value) {

                    form.getItem("deductionType").setValue(null);
                }
            }, {
                showTitle: false,
                name: "deductionType",
                errorOrientation: "bottom",
                width: "150",
                valueMap: JSON.parse('${Enum_DeductionType}'),
                changed: function (form, item, value) {

                    This.getMembers().last().getMembers().filter(q => q.name === "finalAssay").first().setUnitId(This.assay.unitId);
                    let deductionValue = form.getItem("deductionValue").getValue();
                    let discountValue;
                    switch (value) {
                        case "Percent":
                            discountValue = This.assay.value - (This.assay.value * deductionValue / 100);
                            break;
                        case "Unit":
                            discountValue = This.assay.value - deductionValue;
                            break;
                        case "DiscountPercent":
                            discountValue = 0;
                            break;
                    }

                    This.getMembers().last().getMembers().filter(q => q.name === "finalAssay").first().setValue(discountValue);
                    This.calculate();
                }
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
            width: 300,
            unitCategory: This.assay.unit.categoryUnit,
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: false,
            showUnitFieldTitle: false,
            name: 'finalAssay',
        }));
        priceMembers.last().setUnitId(this.assay.unitId);

        priceMembers.add(isc.DynamicForm.create({
            isConversionForm: true,
            fields: [{
                value: " X ",
                showTitle: false,
                width: "100%",
                type: "staticText",
                align: "center"
            }, {
                showTitle: false,
                wrapTitle: false,
                required: true,
                errorOrientation: "bottom",
                width: "100",
                type: "float",
                name: "deductionUnitConversionRate",
                value: 1,
                align: "center",
                validators: [{
                    type: "required",
                    validateOnChange: true,
                }],
                changed: function () {
                    This.calculate();
                }

            }]
        }));

        priceMembers.add(isc.DynamicForm.create({
            numCols: 8,
            width: "50%",
            fields: [{
                value: " X ",
                showTitle: false,
                colSpan: 1,
                type: "staticText",
                align: "center"
            }, {

                showTitle: false,
                type: "staticText",
                name: "basePrice",
                colSpan: 1,
                value: This.price.value,
                align: "center"
            }, {
                value: " = ",
                showTitle: false,
                colSpan: 1,
                type: "staticText",
                align: "center"
            }, {
                showTitle: false,
                type: "staticText",
                colSpan: 1,
                name: "deductionPrice",
                align: "center",
                format: "#.000"
            }]
        }));

        this.addMember(isc.HLayout.create({
            width: "100%",
            members: priceMembers
        }));
    },
    calculate: function () {

        let priceForm = this.getMembers().last().getMembers().last();
        let assayField = this.getMembers().last().getMembers().filter(q => q.name === "finalAssay").first();
        let conversionForm = this.getMembers().last().getMembers().filter(q => q.isConversionForm).first();
        let basePriceValue = priceForm.getValue("basePrice");
        let deductionPriceValue = assayField.getValues().value * basePriceValue * conversionForm.getValue("deductionUnitConversionRate");
        priceForm.setValue("deductionPrice", deductionPriceValue);

        this.sumPriceChanged(deductionPriceValue);
    },
    getFinalAssay: function () {

        return this.getMembers().last().getMembers().filter(q => q.name === "finalAssay").first();
    },
    // setValue: function (value) {
    //     this.setValues(value);
    // }
});
