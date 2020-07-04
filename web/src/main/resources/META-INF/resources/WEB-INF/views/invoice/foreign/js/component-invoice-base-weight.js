isc.defineClass("InvoiceBaseWeight", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    billLadings: [],
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            params: {billLadingIds: This.billLadings.map(q => q.id)},
            actionURL: "${contextPath}/api/bill-of-lading/get-total-weights",
            callback: function (resp) {

                let fields = [];
                let weights = JSON.parse(resp.data);
                fields.add(isc.Unit.create({

                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    disabledCurrencyField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showCurrencyFieldTitle: false,
                    showCurrencyField: false,
                    fieldValueTitle: "weightGW",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(weights.weightGW);
                fields.last().setUnitId(weights.weightGWUnit.id);

                fields.add(isc.Unit.create({

                    unitCategory: 1,
                    disabledUnitField: true,
                    disabledValueField: true,
                    disabledCurrencyField: true,
                    showValueFieldTitle: true,
                    showUnitFieldTitle: false,
                    showCurrencyFieldTitle: false,
                    showCurrencyField: false,
                    fieldValueTitle: "weightND",
                    border: "1px solid rgba(0, 0, 0, 0.3)",
                }));
                fields.last().setValue(weights.weightND);
                fields.last().setUnitId(weights.weightNDUnit.id);

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
