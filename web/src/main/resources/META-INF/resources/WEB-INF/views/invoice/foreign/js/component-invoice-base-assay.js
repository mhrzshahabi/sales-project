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
    remittanceDetail: null,
    assayData: null,
    weightData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        this.addMember(isc.DynamicForm.create({
            fields: [{

                type: "integer",
                name: "reportMilestone",
                editorType: "SelectItem",
                required: true,
                wrapTitle: false,
                title: "<spring:message code='inspectionReport.mileStone'/>",
                validators: [{
                    type: "required",
                    validateOnChange: true
                }],
                valueMap: JSON.parse('${Enum_MileStone}'),
                changed: function (form, item, value) {

                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

                        httpMethod: "GET",
                        willHandleError: true,
                        params: {
                            reportMilestone: value,
                            shipmentId: This.shipment.id,
                            inventoryIds: [This.remittanceDetail.inventory.id]
                        },
                        actionURL: "${contextPath}" + "/api/assayInspection/get-assay-values",
                        callback: function (resp) {

                            if (resp.data && (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)) {

                                let assayValues = JSON.parse(resp.data);
                                if (!assayValues || !assayValues.length)
                                    return;

                                let members = [];
                                for (let index = 0; index < assayValues.length; index++) {

                                    if (!assayValues[index].materialElement.element.payable)
                                        continue;

                                    let elementWidget = This.getMembers().filter(q => q.elementId === assayValues[index].materialElement.element.id).first();
                                    if (elementWidget) {

                                        elementWidget.setValue(assayValues[index].value);
                                        elementWidget.setUnitId(assayValues[index].materialElement.unit.id);
                                        elementWidget.materialElementId = assayValues[index].materialElement.id;
                                        elementWidget.unitCategory = assayValues[index].materialElement.unit.categoryUnit;
                                    } else {

                                        members.add(isc.Unit.create({

                                            disabledUnitField: true,
                                            disabledValueField: true,
                                            showValueFieldTitle: true,
                                            showUnitFieldTitle: false,
                                            name: assayValues[index].materialElement.element.name,
                                            materialElementId: assayValues[index].materialElement.id,
                                            fieldValueTitle: assayValues[index].materialElement.element.name,
                                            unitCategory: assayValues[index].materialElement.unit.categoryUnit,
                                            unit: assayValues[index].materialElement.unit,
                                            elementId: assayValues[index].materialElement.elementId,
                                        }));
                                        members.last().setValue(assayValues[index].value);
                                        members.last().setUnitId(assayValues[index].materialElement.unit.id);
                                    }
                                }

                                if (members.length)
                                    This.addMembers(members);
                            } else {

                                isc.RPCManager.handleError(resp, null);
                                This.getMembers().slice(1).filter(q => q instanceof isc.Unit.constructor).forEach(q => {

                                    q.setValue(null)
                                    q.setUnitId(null);
                                    q.unitCategory = null;
                                    q.materialElementId = null;
                                });
                            }
                        }
                    }));
                }
            }]
        }));
    },
    getValues: function () {

        let data = [];
        this.getMembers().slice(1).forEach(current => {

            data.add({
                assayMilestone: this.getMembers()[0].getField("reportMilestone").getValue(),
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
    editAssay: function () {

        if (this.weightData) {
            this.getMembers()[0].getField("reportMilestone").setValue(this.weightData[0].assayMilestone);
        }
        if (this.assayData) {

        }
    },
    validate: function () {

        let isValid = true;
        if (this.getMembers().length < 2)
            isValid = false;
        else {
            this.getMembers().slice(1).forEach(current => {
                if (current.getValues().value === null)
                    isValid = false;
            });
        }
        return isValid;
    }
});
