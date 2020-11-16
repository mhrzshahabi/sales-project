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

    },
    getDataRowNo: function () {
        return this.getMembers().length;
    },
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
        this.getMembers().forEach(current => {
            if (current.getValues().value === null)
                isValid = false;
        });
        return isValid;
    }
});
