isc.defineClass("InvoiceBasePrice", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    canAdaptHeight: true,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "visible",
    contract: null,
    shipment: null,
    contractDetailData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        let material = This.contract.material;
        let sendDate = new Date(This.shipment.sendDate);
        let year = sendDate.getFullYear();
        let month = sendDate.getMonth() + 1;
        let moasValue = This.contractDetailData.moasValue;
        let basePriceReference = This.contractDetailData.basePriceReference;

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            params: {
                year: year,
                materialId: material.id,
                month: month + moasValue,
                reference: basePriceReference
            },
            httpMethod: "GET",
            actionURL: "${contextPath}/api/price-base/get-avg-base-price",

            callback: function (resp) {

                let members = [];
                let priceBases = JSON.parse(resp.data);
                priceBases.forEach(priceBase => {

                    if (!priceBase.element.payable)
                        return;

                    members.add(isc.Unit.create({

                        unitCategory: priceBase.financeUnit.categoryUnit,
                        disabledUnitField: true,
                        disabledValueField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        name: priceBase.element.name,
                        fieldValueTitle: priceBase.element.name,
                    }));

                    members.last().setValue(priceBase.price);
                    members.last().setUnitId(priceBase.financeUnitId);
                });

                let fieldsNames = members.map(q => q.name).join(", ");
                This.addMember(isc.Label.create({
                    width: "100%",
                    height: "50",
                    contents: "<b>" + "AVERAGE OF " + (month + moasValue) +
                        "th MONTH OF " + year + " (MOAS" + (moasValue === 0 ? "" : (moasValue > 0 ? "+" : "-") + moasValue) +
                        ") " + " FOR " + fieldsNames + "<b>"
                }));
                This.addMembers(members);
            }
        }));
    },
    // getValues: function () {
    //     return this.members[1].getValues();
    // },
    // setValues: function (data) {
    //     return this.members[1].setValues(data);
    // }
});
