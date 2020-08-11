isc.defineClass("InvoiceBaseWeight", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "scroll",
    inventories: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            params: {
                doIntegration: true,
                inventoryIds: This.inventories.map(q => q.id)
            },
            actionURL: "${contextPath}" + "/api/weightInspection/get-weight-values",
            callback: function (resp) {

                let fields = [];
                let weightValues = JSON.parse(resp.data).get(0);
                fields.add(isc.Unit.create({

                    unitCategory: weightValues.unit.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    name: "weightGW",
                    fieldValueTitle: "weightGW",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(weightValues.weightGW);
                fields.last().setUnitId(weightValues.unit.id);

                fields.add(isc.Unit.create({

                    unitCategory: weightValues.unit.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    name: "weightND",
                    fieldValueTitle: "weightND",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(weightValues.weightND);
                fields.last().setUnitId(weightValues.unit.id);

                fields.add(isc.Unit.create({

                    unitCategory: weightValues.unit.categoryUnit,
                    disabledUnitField: true,
                    disabledValueField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    name: "weightDiff",
                    fieldValueTitle: "weightDiff",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(weightValues.weightDiff);
                fields.last().setUnitId(weightValues.unit.id);

                This.addMember(isc.DynamicForm.create({
                    width: "100%",
                    fields: fields
                }));
            }
        }));
    },
    getValues: function () {
        return this.members[0].getValues();
    },
    setValues: function (data) {
        return this.members[0].setValues(data);
    }
});
