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
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        let members = [];
        members.add(isc.DynamicForm.create({
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
                        actionURL: "${contextPath}" + "/api/weightInspection/get-weight-values",
                        callback: function (resp) {

                            if (resp.data && (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)) {

                                let weightValue = JSON.parse(resp.data);
                                if (weightValue == null)
                                    return;

                                This.getMembers().filter(q => q.name === "weightGW").first().setValue(weightValue.weightGW);
                                This.getMembers().filter(q => q.name === "weightGW").first().setUnitId(weightValue.unit.id);
                                This.getMembers().filter(q => q.name === "weightGW").first().unitCategory = weightValue.unit.categoryUnit;

                                This.getMembers().filter(q => q.name === "weightND").first().setValue(weightValue.weightND);
                                This.getMembers().filter(q => q.name === "weightND").first().setUnitId(weightValue.unit.id);
                                This.getMembers().filter(q => q.name === "weightND").first().unitCategory = weightValue.unit.categoryUnit;

                                This.getMembers().filter(q => q.name === "weightDiff").first().setValue(weightValue.weightDiff);
                                This.getMembers().filter(q => q.name === "weightDiff").first().setUnitId(weightValue.unit.id);
                                This.getMembers().filter(q => q.name === "weightDiff").first().unitCategory = weightValue.unit.categoryUnit;
                            } else {

                                isc.RPCManager.handleError(resp, null);

                                This.getMembers().filter(q => q.name === "weightGW").first().setValue(null);
                                This.getMembers().filter(q => q.name === "weightGW").first().setUnitId(null);
                                This.getMembers().filter(q => q.name === "weightGW").first().unitCategory = null;

                                This.getMembers().filter(q => q.name === "weightND").first().setValue(null);
                                This.getMembers().filter(q => q.name === "weightND").first().setUnitId(null);
                                This.getMembers().filter(q => q.name === "weightND").first().unitCategory = null;

                                This.getMembers().filter(q => q.name === "weightDiff").first().setValue(null);
                                This.getMembers().filter(q => q.name === "weightDiff").first().setUnitId(null);
                                This.getMembers().filter(q => q.name === "weightDiff").first().unitCategory = null;
                            }
                        }
                    }));
                }
            }]
        }));

        members.add(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightGW",
            fieldValueTitle: "weightGW",
        }));

        members.add(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightND",
            fieldValueTitle: "weightND",
        }));

        members.add(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightDiff",
            fieldValueTitle: "weightDiff",
        }));

        this.addMembers(members);
        this.getMembers()[0].setValue("reportMilestone", 1);
        this.getMembers()[0].getItem(0).changed(this.getMembers()[0], this.getMembers()[0].getItem(0), 1);
    },
    getValues: function () {

        return {
            weightGW: this.getMembers().filter(q => q.name === "weightGW").first(),
            weightND: this.getMembers().filter(q => q.name === "weightND").first(),
            weightDiff: this.getMembers().filter(q => q.name === "weightDiff").first()
        };
    }
});
