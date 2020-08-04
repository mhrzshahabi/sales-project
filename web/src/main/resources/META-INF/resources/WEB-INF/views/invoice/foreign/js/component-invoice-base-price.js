isc.defineClass("InvoiceBasePrice", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "scroll",
    contract: null,
    shipment: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let year = __contract.getContractYear(This.contract);
        let material = __contract.getMaterial(This.contract);
        let month = __contract.getShipmentMonthNo(This.shipment);
        let moasValue = __contract.getContractMOASValue(This.contract);
        let basePriceReference = __contract.getBasePriceReference(This.contract);

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            params: {
                year: year,
                materialId: material.id,
                month: month + moasValue,
                reference: basePriceReference
            },
            httpMethod: "GET",
            actionURL: "${contextPath}/api/price-base/get-base-price",

            callback: function (resp) {

                let fields = [];
                let elements = JSON.parse(resp.data);
                for (let index = 0; index < elements.length; index++) {

                    if (!elements[index].element.payable)
                        continue;

                    fields.add(isc.Unit.create({

                        unitCategory: elements[index].unit.categoryUnit,
                        disabledUnitField: true,
                        disabledValueField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        name: elements[index].element.name,
                        fieldValueTitle: elements[index].element.name,
                        border: "1px solid rgba(0, 0, 0, 0.3)",
                    }));
                    fields.last().setValue(elements[index].price);
                    fields.last().setUnitId(elements[index].unit.id);
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
