isc.defineClass("InvoiceBaseAssay", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "scroll",
    inventories: [],
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            params: {
                doIntegration: true,
                inventoryIds: This.inventories.map(q => q.id)
            },
            actionURL: "${contextPath}" + "/api/assayInspection/get-assay-values",

            callback: function (resp) {

                let fields = [];
                let assayValues = JSON.parse(resp.data);
                for (let index = 0; index < assayValues.length; index++) {

                    if (!assayValues[index].materialElement.element.payable)
                        continue;

                    fields.add(isc.Unit.create({
                        unitCategory: assayValues[index].materialElement.unit.categoryUnit,
                        disabledUnitField: true,
                        disabledValueField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        name: assayValues[index].materialElement.element.name,
                        fieldValueTitle: assayValues[index].materialElement.element.name,
                        border: "1px solid rgba(0, 0, 0, 0.3)",
                    }));
                    fields.last().setValue(assayValues[index].value);
                    fields.last().setUnitId(assayValues[index].materialElement.unit.id);
                }

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
