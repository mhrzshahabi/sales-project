isc.defineClass("InvoiceBaseAssay", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    height: "20%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    inventories: [],
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        let fields = [];
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            params: {inventoryIds: This.inventories.map(q => q.id)},
            actionURL: "${contextPath}/api/assayInspection/get-assay-values",
            callback: function (resp) {

                let assayValues = JSON.parse(resp.data);
                for (let index = 0; index < assayValues.length; index++) {

                    if (!assayValues[index].materialElement.element.payable)
                        continue;

                    fields.add(isc.Unit.create({

                        unitCategory: 1,
                        disabledUnitField: true,
                        disabledValueField: true,
                        disabledCurrencyField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        showCurrencyFieldTitle: false,
                        showCurrencyField: false,
                        fieldValueTitle: assayValues[index].materialElement.element.name,
                        border: "1px solid rgba(0, 0, 0, 0.3)",
                    }));
                    fields.last().setValue(assayValues[index].value);
                    fields.last().setUnitId(assayValues[index].unit.id);
                }

                This.addMember(isc.DynamicForm.create({
                    width: "100%",
                    fields: fields
                }));
            }
        }));
    },
    getValues: function () {
        return this.members[1].getValues();
    },
    setValues: function (data) {
        return this.members[1].setValues(data);
    }
});
