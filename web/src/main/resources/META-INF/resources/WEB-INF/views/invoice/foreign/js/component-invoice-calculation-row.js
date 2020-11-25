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
    calculationRowData: null,
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
            role: "deduction",
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
                required: true,
                name: "deductionType",
                errorOrientation: "bottom",
                width: "150",
                valueMap: JSON.parse('${Enum_DeductionType}'),
                changed: function (form, item, value) {

                    This.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.name === "finalAssay").first().setUnitId(This.assay.unitId);
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

                    This.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.name === "finalAssay").first().setValue(discountValue);
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
            isBasePriceForm: true,
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
            }]
        }));

        priceMembers.add(isc.DynamicForm.create({
            numCols: 4,
            isConversionForm: true,
            fields: [{
                colSpan: 1,
                value: " X ",
                showTitle: false,
                type: "staticText",
                align: "center"
            }, {
                colSpan: 1,
                showTitle: false,
                wrapTitle: false,
                required: true,
                errorOrientation: "bottom",
                type: "float",
                width: 100,
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
            role: "priceMembers",
            members: priceMembers
        }));

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

    },
    calculate: function () {

        let priceForm = this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.isBasePriceForm).first();
        let assayForm = this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.name === "finalAssay").first();
        let conversionForm = this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.isConversionForm).first();
        let deductionPriceValue = assayForm.getValues().value * priceForm.getValue("basePrice") * conversionForm.getValue("deductionUnitConversionRate");
        conversionForm.setValue("deductionPrice", deductionPriceValue);

        this.sumPriceChanged(deductionPriceValue);
    },
    getFinalAssay: function () {

        return this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.name === "finalAssay").first();
    },
    getDeductionType: function () {

        return this.getMembers().filter(q => q.role === "deduction").first().getValue("deductionType");
    },
    getDeductionValue: function () {

        return this.getMembers().filter(q => q.role === "deduction").first().getValue("deductionValue");
    },
    getDeductionPrice: function () {

        return this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.isConversionForm).first().getValue("deductionPrice");
    },
    getDeductionUnitConversionRate: function () {

        return this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.isConversionForm).first().getValue("deductionUnitConversionRate");
    },
    getBasePrice: function () {

        return this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.isBasePriceForm).first().getValue("basePrice");
    },
    editRowCalculation: function () {

        if (this.calculationRowData) {
            this.getMembers().filter(q => q.role === "deduction").first().setValue("deductionValue", this.calculationRowData.deductionValue);
            this.getMembers().filter(q => q.role === "deduction").first().setValue("deductionType", this.calculationRowData.deductionType);
            this.getMembers().filter(q => q.role === "deduction").first().getItem("deductionType").changed(this.getMembers().filter(q => q.role === "deduction").first(),
                this.getMembers().filter(q => q.role === "deduction").first().getItem("deductionType"), this.getMembers().filter(q => q.role === "deduction").first().getItem("deductionType").getValue());
            this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.isConversionForm).first().setValue("deductionUnitConversionRate", this.calculationRowData.deductionUnitConversionRate);
            this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.isConversionForm).first().getItem("deductionUnitConversionRate").changed();
        }
    },
    validate: function () {

        this.getMembers()[1].validate();
        if (this.getMembers()[1].hasErrors())
            return false;
        else {
            let conversionForm = this.getMembers().filter(q => q.role === "priceMembers").first().getMembers().filter(q => q.isConversionForm).first();
            conversionForm.validate();
            if (conversionForm.hasErrors())
                return false;
        }
        return true;
    }
});
