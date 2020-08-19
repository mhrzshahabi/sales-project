isc.defineClass("InvoiceBaseWeight", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "visible",
    canAdaptHeight: true,
    shipment: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        let fields = [];
        fields.add(isc.DynamicForm.create({
            fields: [{

                width: "100%",
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
                valueMap: Object.assign(JSON.parse('${Enum_MileStone}'), {4: "Average"}),
                changed: function (form, item, value) {

                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

                        httpMethod: "GET",
                        params: {
                            reportMilestone: value,
                            shipmentId: This.shipment.id
                        },
                        actionURL: "${contextPath}" + "/api/weightInspection/get-weight-values",
                        callback: function (resp) {

                            if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

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
                            }
                        }
                    }));
                }
            }]
        }));

        fields.add(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightGW",
            fieldValueTitle: "weightGW",
        }));

        fields.add(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightND",
            fieldValueTitle: "weightND",
        }));

        fields.add(isc.Unit.create({

            disabledUnitField: true,
            disabledValueField: true,
            showValueFieldTitle: true,
            showUnitFieldTitle: false,
            name: "weightDiff",
            fieldValueTitle: "weightDiff",
        }));

        this.addMembers(fields);
        this.getMembers()[0].setValue("reportMilestone", 4);
        this.getMembers()[0].getItem(0).changed(this.getMembers()[0], this.getMembers()[0].getItem(0), 4);
    },
    // getValues: function () {
    //     return this.members[0].getValues();
    // },
    // setValues: function (data) {
    //     return this.members[0].setValues(data);
    // }
});
