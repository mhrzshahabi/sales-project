isc.defineClass("InvoiceBaseWeight", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    canAdaptHeight: true,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "visible",
    percent: null,
    shipment: null,
    isClicked: true,
    remainingPercent: false,
    inspectionWeightData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        this.addMember(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightGW",
            fieldValueTitle: "<spring:message code='foreign-invoice.form.total-gross-weight'/>"
        }));
        this.getMembers().last().setValue(this.inspectionWeightData.weightGW);
        this.getMembers().last().setUnitId(this.inspectionWeightData.weightInspections[0].unitId);

        this.addMember(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightND",
            fieldValueTitle: "<spring:message code='foreign-invoice.form.total-net-weight'/>"
        }));
        this.getMembers().last().setValue(this.inspectionWeightData.weightND);
        this.getMembers().last().setUnitId(this.inspectionWeightData.weightInspections[0].unitId);

        let unitArray = [];
        let amountArray = [];
        let inventories = [];
        this.inspectionWeightData.weightInspections.forEach(q => inventories.add(q.inventory));
        let remittanceDetails = inventories.map(q => q.remittanceDetails);
        remittanceDetails.forEach(rds => {
            rds.forEach(r => {
                unitArray.push(r.unitId);
            });
        });
        unitArray = unitArray.distinct();
        unitArray.forEach((u, index) => {
            if (amountArray[index] === undefined) {
                amountArray[index] = 0;
            }
            remittanceDetails.forEach(rds => {
                rds.forEach((r, i) => {
                    if (r.unitId === u && r.amount !== 0) {
                        amountArray[index] = amountArray[index] + r.amount;
                    }
                });
            });
        });
        unitArray.forEach((current, index) => {
            if (amountArray[index] !== 0) {
                let unitMember = isc.Unit.create({
                    disabledUnitField: true,
                    disabledValueField: true,
                    showUnitFieldTitle: false,
                    showValueFieldTitle: true,
                    name: "totalUnits",
                    fieldValueTitle: "<spring:message code='foreign-invoice.form.total-units'/>",
                });
                unitMember.setValue(amountArray[index]);
                unitMember.setUnitId(current);
                This.addMember(unitMember)
            }
        });

        this.addMember(isc.DynamicForm.create({
            width: "100%",
            fields: [{
                name: "percent",
                title: "<spring:message code='foreign-invoice.form.percent'/>",
                type: "float",
                defaultValue: 100,
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    },
                    {
                        type: "floatLimit",
                        max: 100,
                        min: 0,
                        validateOnChange: true
                    }],
                icons: [
                    {
                        src: "pieces/16/accept.png",
                        click: function () {

                            This.isClicked = true;
                            let percent = This.getMembers().last().getValue("percent");
                            let weightGWMember = This.getMembers().filter(q => q.name === "weightGW").first();
                            weightGWMember.setValue(weightGWMember.getValues().value * percent / 100);
                            let weightNDMember = This.getMembers().filter(q => q.name === "weightND").first();
                            weightNDMember.setValue(weightNDMember.getValues().value * percent / 100);

                            if (percent === 100) {
                                This.getMembers().filter(q => q.name === "totalUnits").forEach(member => member.show());
                            } else
                                This.getMembers().filter(q => q.name === "totalUnits").forEach(member => member.hide());
                        }
                    },
                    {
                        src: "pieces/16/refresh.png",
                        click: function () {

                            This.isClicked = true;
                            This.getMembers().last().setValue("percent", 100);
                            let weightGWMember = This.getMembers().filter(q => q.name === "weightGW").first();
                            weightGWMember.setValue(This.inspectionWeightData.weightGW);
                            let weightNDMember = This.getMembers().filter(q => q.name === "weightND").first();
                            weightNDMember.setValue(This.inspectionWeightData.weightND);

                            This.getMembers().filter(q => q.name === "totalUnits").forEach(member => member.show());
                        }
                    }],
                changed: function () {

                    This.isClicked = false;
                }
            }]
        }));

        this.setPercentValue();
    },
    getValues: function () {

        return {
            weightGW: this.getMembers().filter(q => q.name === "weightGW").first(),
            weightND: this.getMembers().filter(q => q.name === "weightND").first(),
            percent: this.getMembers().last().getValue("percent")
        };
    },
    setPercentValue: function () {

        if (this.percent) {
            this.getMembers().last().setValue("percent", this.percent);
            this.getMembers().last().getField("percent").icons[0].click();
        }
    },
    validate: function () {

        let isValid = true;
        this.getMembers().last().validate();
        if (this.getMembers().last().hasErrors())
            isValid = false;

        if (this.getMembers().last().getField("percent").getValue() > this.remainingPercent) {
            isc.warn("<spring:message code='foreign-invoice.form.percent.not.valid'/>");
            isValid = false;
        }

        if (isValid && !this.isClicked)
            this.getMembers().last().getField("percent").icons[0].click();

        return isValid;
    }
});
