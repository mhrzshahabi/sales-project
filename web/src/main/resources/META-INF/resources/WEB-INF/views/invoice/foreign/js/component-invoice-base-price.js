isc.defineClass("InvoiceBasePrice", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    contract: null,
    shipment: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let year = __contract.getContractYear(This.contract);
        let material = __contract.getMaterial(This.contract);
        let month = __contract.getShipmentMonthNo(This.shipment);
        let moasValue = __contract.getContractMOASValue(This.contract);

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            params: {
                year: year,
                materialId: material.id,
                month: month + moasValue
            },
            httpMethod: "GET",
            actionURL: "${contextPath}/api/price-base/get-base-price",
            callback: function (resp) {

                let fields = [];
                let elements = JSON.parse(resp.data);
                for (let index = 0; index < elements.length; index++) {

                    if (!elements[index].payable)
                        continue;

                    fields.add(isc.Unit.create({

                        unitCategory: 1,
                        disabledUnitField: true,
                        disabledValueField: true,
                        disabledCurrencyField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        showCurrencyFieldTitle: false,
                        fieldValueTitle: elements[index].name,
                        border: "1px solid rgba(0, 0, 0, 0.3)",
                    }));
                    fields.last().setValue(elements[index].price);
                    fields.last().setUnitId(elements[index].unit.id);
                    fields.last().setCurrencyId(elements[index].currency.id);
                }

                This.addMember(isc.Label.create({
                    contents: "<b>" + "AVERAGE OF " + (month + moasValue) + "th MONTH OF " + year + " (MOAS" + (moasValue > 0 ? "+" : "-") + moasValue + ")<b>"
                }));
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
