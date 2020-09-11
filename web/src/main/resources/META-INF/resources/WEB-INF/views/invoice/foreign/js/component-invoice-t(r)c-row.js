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
    rcData: null,
    currency: null,
    elementFinalAssay: null,
    rcDeductionRowData: null,
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
            fieldValueTitle: "R/C-" + This.rcData.elementName,
            unitHint: "PER " + This.rcData.weightUnit.nameEN,
            unitCategory: This.rcData.financeUnit.categoryUnit,
        }));
        this.getMembers().last().setValue(this.rcData.price);
        this.getMembers().last().setUnitId(this.rcData.financeUnit.id);

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
            isConversionForm: true,
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
                errorOrientation: "bottom",
                name: "rcUnitConversionRate",
                align: "center",
                required: true,
                validators: [{
                    type: "required",
                    validateOnChange: true,
                }],
                changed: function () {

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
                format: "#.000"
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
    getRCPrice: function () {

        return this.getMembers().filter(q => q.isConversionForm).first().getValue("deductionPrice");
    },
    getFinalAssay: function () {

        return this.getMembers().filter(q => q.name === "finalAssay").first();
    },
    getRCBasePrice: function () {

        return this.getMembers().filter(q => q.name === "rcPrice").first();
    },
    getRCUnitConversionRate: function () {

        return this.getMembers().filter(q => q.isConversionForm).first().getValue("rcUnitConversionRate");
    },
    editRowDeduction: function () {

        if (this.rcDeductionRowData) {

            this.getMembers().filter(q => q.isConversionForm).first().setValue("rcUnitConversionRate", this.rcDeductionRowData.rcUnitConversionRate);
            this.getMembers().filter(q => q.isConversionForm).first().getItem("rcUnitConversionRate").changed();
        }
    },
    validate: function () {

        let conversionForm = this.getMembers().filter(q => q.isConversionForm).first();
        conversionForm.validate();
        return !conversionForm.hasErrors();
    }
});