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
            fieldValueTitle: "weightGW",
        }));
        this.getMembers().last().setValue(this.inspectionWeightData.weightGW);
        this.getMembers().last().setUnitId(this.inspectionWeightData.weightInspections[0].unitId);

        this.addMember(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightND",
            fieldValueTitle: "weightND",
        }));
        this.getMembers().last().setValue(this.inspectionWeightData.weightND);
        this.getMembers().last().setUnitId(this.inspectionWeightData.weightInspections[0].unitId);

        // this.getMembers()[0].setValue("reportMilestone", JSON.parse('${Enum_MileStone}').Source);
        // this.getMembers()[0].getItem(0).changed(this.getMembers()[0], this.getMembers()[0].getItem(0), JSON.parse('${Enum_MileStone}').Source);
        // this.editWeight();
    },
    // editWeight: function () {
    //     if (this.weightMilestone)
    //         this.getMembers()[0].setValue("reportMilestone", this.weightMilestone);
    // },
    getValues: function () {

        return {
            weightGW: this.getMembers().filter(q => q.name === "weightGW").first(),
            weightND: this.getMembers().filter(q => q.name === "weightND").first(),
            // weightDiff: this.getMembers().filter(q => q.name === "weightDiff").first(),
            weightMilestone: this.inspectionWeightData.weightInspections[0].mileStone
        };
    },
    validate: function () {

        let isValid = true;
        if (this.getMembers().length < 1)
            isValid = false;
        else {
            this.getMembers().forEach(current => {
                if (current.getValues().value === null)
                    isValid = false;
            });
        }
        return isValid;
    }
});
