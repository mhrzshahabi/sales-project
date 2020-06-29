isc.defineClass("InvoiceBasePrice", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    height: "20%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    contract: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let material = __contract.getMaterial(This.contract);
        let year = __contract.getContractYear(This.contract);
        let month = __contract.getContractMonth(This.contract);

        let fields = [];
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            params: {
                year: year,
                month: month,
                materialId: material.id
            },
            httpMethod: "GET",
            actionURL: "${contextPath}/api/price-base/get-base-price",
            callback: function (resp) {

                let elements = JSON.parse(resp.data);
                for (let index = 0; index < elements.length; index++) {

                    fields.add(isc.Unit.create({

                        unitCategory: 1,
                        disabledUnitField: true,
                        disabledValueField: true,
                        showUnitFieldTitle: false,
                        showValueFieldTitle: true,
                        fieldValueTitle: elements[index].name,
                        border: "1px solid rgba(0, 0, 0, 0.8)",
                    }));
                    fields.last().setValue(elements[index].price);
                }

                This.addMember(isc.Label.create({
                    contents: "<b>" + "AVERAGE OF " + month + "th MONTH OF " + year + "<b>"
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
