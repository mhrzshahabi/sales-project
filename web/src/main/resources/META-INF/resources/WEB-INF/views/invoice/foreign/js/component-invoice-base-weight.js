isc.defineClass("InvoiceBaseWeight", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "scroll",
    inventory: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            params: {inventoryId: This.inventory.id},
            actionURL: "${contextPath}/api/weightInspection/get-weight-values",
            callback: function (resp) {

                let fields = [];
                let values = JSON.parse(resp.data);
                fields.add(isc.Unit.create({

                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    disabledCurrencyField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showCurrencyFieldTitle: false,
                    showCurrencyField: false,
                    name: "weightGW",
                    fieldValueTitle: "weightGW",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(values.weightGW);
                fields.last().setUnitId(values.unit.id);

                fields.add(isc.Unit.create({

                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    disabledCurrencyField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showCurrencyFieldTitle: false,
                    showCurrencyField: false,
                    name: "weightND",
                    fieldValueTitle: "weightND",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(values.weightND);
                fields.last().setUnitId(values.unit.id);

                fields.add(isc.Unit.create({

                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    disabledCurrencyField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showCurrencyFieldTitle: false,
                    showCurrencyField: false,
                    name: "secondValue",
                    fieldValueTitle: "secondValue",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(values.secondValue);
                fields.last().setUnitId(values.unit.id);

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
