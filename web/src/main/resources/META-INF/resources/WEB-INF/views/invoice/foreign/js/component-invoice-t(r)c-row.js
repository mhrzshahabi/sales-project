isc.defineClass("InvoiceDeductionRow", isc.HLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    canAdaptHeight: true,
    layoutMargin: 2,
    membersMargin: 2,
    wrapItemTitles: false,
    currency: null,
    elementFinalAssay: null,
    contractDetailData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.addMember(isc.Unit.create({
            width: "250",
            name: 'rcPrice',
            fieldValueTitleWidth: "100",
            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            fieldValueTitle: "R/C-" + This.contractDetailData.elementName,
            unitHint: "PER " + This.contractDetailData.weightUnit.nameEN,
            unitCategory: This.contractDetailData.financeUnit.categoryUnit,
        }));
        this.getMembers().last().setValue(this.contractDetailData.price);
        this.getMembers().last().setUnitId(this.contractDetailData.financeUnit.id);

        this.addMember(isc.DynamicForm.create({
            width: "50",
            fields: [{
                value: " X ",
                showTitle: false,
                type: "staticText",
                align: "center"
            }]
        }));

        this.addMember(isc.Unit.create({
            width: "250",
            name: 'finalAssay',
            disabledUnitField: true,
            disabledValueField: true,
            showUnitFieldTitle: false,
            showValueFieldTitle: false,
            unitCategory: This.elementFinalAssay.unitCategory,
        }));
        let finalAssayValue = this.elementFinalAssay.getValues().value;
        this.getMembers().last().setValue(finalAssayValue);
        this.getMembers().last().setUnitId(this.elementFinalAssay.getValues().unitId);

        this.addMember(isc.DynamicForm.create({
            numCols: 8,
            fields: [{
                width: "50",
                value: " X ",
                showTitle: false,
                type: "staticText",
                align: "center"
            }, {
                width: "100",
                value: 1,
                showTitle: false,
                type: "float",
                name: "rcUnitConversionRate",
                align: "center",
                required: true,
                validators: [{
                    type: "required",
                    validateOnChange: true,
                }],
                changed: function (form, item, value) {

                    This.calculate();
                }
            }, {
                width: "50",
                value: " = ",
                showTitle: false,
                type: "staticText",
                align: "center"
            }, {
                width: "100",
                showTitle: false,
                type: "staticText",
                name: "deductionPrice",
                align: "center",
            }]
        }));
    },
    calculate: function () {

        let conversionForm = this.getMembers().last();
        let rcPriceField = this.getMembers().filter(q => q.name === "rcPrice").first();
        let assayField = this.getMembers().filter(q => q.name === "finalAssay").first();
        let deductionPriceValue = assayField.getValues().value * rcPriceField.getValues().value * conversionForm.getValue("rcUnitConversionRate");
        conversionForm.setValue("deductionPrice", deductionPriceValue);
        this.sumDeductionChanged(deductionPriceValue);

    },
    updateDeductionRows: function () {
        this.getMembers().filter(q => q.name === "finalAssay").first().setValue(this.elementFinalAssay.getValues().value);
        this.calculate();
    },
    // calculate: function () {
    //     let rcPriceField = this.getField('rcPrice');
    //     let assayField = this.getField('finalAssay');
    //     this.setValue("deductionPrice", rcPriceField.getValue() * assayField.getValue() * assayField.rcUnitConversionRate);
    // },
    // getValue: function () {
    //     this.getField("deductionPrice").getValue();
    // },
    // setValue: function (value) {
    //     this.setValues(value);
    // }
});

