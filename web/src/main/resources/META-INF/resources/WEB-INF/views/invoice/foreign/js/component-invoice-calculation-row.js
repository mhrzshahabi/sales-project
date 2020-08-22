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


        console.log(this.getMembers())

        this.addMember(isc.DynamicForm.create({
            fields: [{
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
                        unitId: This.assay.unitId,
                    });
                    // This.calculate();
                }
            }, {
                colSpan: 2,
                showTitle: false,
                width: "100%",
                name: "deductionType",
                valueMap: JSON.parse('${Enum_DeductionType}')
            }]
        }));

        this.addField();
        // this.addField(isc.Unit.create({
        //     colSpan: 4,
        //     unitCategory: This.assay.unit.categoryUnit,
        //     disabledUnitField: true,
        //     disabledValueField: true,
        //     showValueFieldTitle: false,
        //     showUnitFieldTitle: false,
        //     deductionUnitConversionRate: 1,
        //     name: 'finalAssay',
        //     border: "1px solid rgba(0, 0, 0, 0.3)",
        // }));
        // this.getFields().last().setUnitId(this.assay.unitId);
        //
        //
        // if (This.assay.unitId !== ImportantIDs.unit.PERCENT &&
        //     !Enums.unit.hasFlag(This.price.unit.symbolUnit, This.assay.unit.symbolUnit))
        //     this.addField({
        //         colSpan: 4,
        //         title: " X ",
        //         name: "deductionUnitConversionRate",
        //         border: "1px solid rgba(0, 0, 0, 0.3)",
        //         changed: function (form, item, value) {
        //
        //             form.getField('finalAssay').deductionUnitConversionRate = value;
        //             This.calculate();
        //         }
        //     });
        // console.log("@before");
        // this.addField({
        //     colSpan: 4,
        //     title: " = ",
        //     type: "staticText",
        //     name: "deductionPrice",
        // });

    },
    // calculate: function () {
    //     let assayField = this.getField('finalAssay');
    //     this.setValue("deductionPrice", assayField.getValue() * assayField.deductionUnitConversionRate);
    // },
    // getValue: function () {
    //     return this.getValues();
    // },
    // setValue: function (value) {
    //     this.setValues(value);
    // }
});
