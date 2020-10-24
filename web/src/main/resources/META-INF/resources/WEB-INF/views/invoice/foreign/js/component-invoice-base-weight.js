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
    shipment: null,
    percent: null,
    inspectionWeightData: null,
    isClicked: true,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        this.addMember(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightGW",
            fieldValueTitle: "TOTAL GROSS WEIGHT"
        }));
        this.getMembers().last().setValue(this.inspectionWeightData.weightGW);
        this.getMembers().last().setUnitId(this.inspectionWeightData.weightInspections[0].unitId);

        this.addMember(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightND",
            fieldValueTitle: "TOTAL NET WEIGHT"
        }));
        this.getMembers().last().setValue(this.inspectionWeightData.weightND);
        this.getMembers().last().setUnitId(this.inspectionWeightData.weightInspections[0].unitId);

        this.addMember(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "totalUnits",
            fieldValueTitle: "TOTAL UNITS"
        }));
        // this.getMembers().last().setValue(this.inspectionWeightData.weightND);
        // this.getMembers().last().setUnitId(this.inspectionWeightData.weightInspections[0].unitId);

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
            totalUnits: this.getMembers().filter(q => q.name === "totalUnits").first(),
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

        if (isValid && !this.isClicked)
            this.getMembers().last().getField("percent").icons[0].click();

        return isValid;
    }
});
