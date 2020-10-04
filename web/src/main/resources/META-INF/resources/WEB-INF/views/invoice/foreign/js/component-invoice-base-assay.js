isc.defineClass("InvoiceBaseAssay", isc.VLayout).addProperties({
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
    inspectionAssayData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        this.inspectionAssayData.assayInspectionTotalValuesList.forEach(assay => {

            This.addMember(isc.Unit.create({
                disabledUnitField: true,
                disabledValueField: true,
                showValueFieldTitle: true,
                showUnitFieldTitle: false,
                name: assay.materialElement.element.name,
                materialElementId: assay.materialElement.id,
                fieldValueTitle: assay.materialElement.element.name,
                unitCategory: assay.materialElement.unit.categoryUnit,
                unit: assay.materialElement.unit,
                elementId: assay.materialElement.elementId,
            }));
            this.getMembers().last().setValue(assay.value);
            this.getMembers().last().setUnitId(assay.materialElement.unit.id);
        });

        // this.getMembers()[0].setValue("reportMilestone", JSON.parse('${Enum_MileStone}').Source);
        // this.getMembers()[0].getItem(0).changed(this.getMembers()[0], this.getMembers()[0].getItem(0), JSON.parse('${Enum_MileStone}').Source);
        // this.editAssay();
    },
    getDataRowNo: function () {
        return this.getMembers().length;
    },
    // editAssay: function () {
    // if (this.assayMilestone)
    //     this.getMembers()[0].setValue("reportMilestone", this.assayMilestone);
    // },
    getValues: function () {

        let data = [];
        this.getMembers().forEach(current => {

            data.add({
                assayMilestone: this.inspectionAssayData.assayInspections[0].mileStone,
                name: current.name,
                unit: current.unit,
                elementId: current.elementId,
                materialElementId: current.materialElementId,
                value: current.getValues().value,
                unitId: current.getValues().unitId
            });
        });

        return data;
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
