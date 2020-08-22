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
                            shipmentId: This.shipment.id
                        },
                        actionURL: "${contextPath}" + "/api/assayInspection/get-assay-values",
                        callback: function (resp) {

                            if (resp.data && (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)) {

                                let assayValues = JSON.parse(resp.data);
                                if (assayValues == null)
                                    return;

                                let members = [];
                                for (let index = 0; index < assayValues.length; index++) {

                                    if (!assayValues[index].materialElement.element.payable)
                                        continue;

                                    let elementWidget = This.getMembers().filter(q => q.name === assayValues[index].materialElement.element.name).first();
                                    if (elementWidget) {

                                        elementWidget.setValue(assayValues[index].value);
                                        elementWidget.setUnitId(assayValues[index].materialElement.unit.id);
                                        elementWidget.unitCategory = assayValues[index].materialElement.unit.categoryUnit;
                                    } else {

                                        members.add(isc.Unit.create({

                                            disabledUnitField: true,
                                            disabledValueField: true,
                                            showValueFieldTitle: true,
                                            showUnitFieldTitle: false,
                                            name: assayValues[index].materialElement.element.name,
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
                                });
                            }
                        }
                    }));
                }
            }]
        }));

        this.getMembers()[0].setValue("reportMilestone", 1);
        this.getMembers()[0].getItem(0).changed(this.getMembers()[0], this.getMembers()[0].getItem(0), 1);
    },
    getValues: function () {

        let data = [];
        this.getMembers().slice(1).forEach(current => {

            data.add({
                elementId: current.elementId,
                name: current.name,
                value: current.getValues().value,
                unit: current.unit,
                unitId: current.getValues().unitId
            });
        });

        return data;
    },
    // setValues: function (data) {
    //     return this.members[0].setValues(data);
    // }
});
