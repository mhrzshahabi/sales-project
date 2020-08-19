isc.defineClass("InvoiceBasePrice", isc.VLayout).addProperties({
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "visible",
    contract: null,
    shipment: null,
    contractDetailData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        let year = 2020;//This.shipment.sendDate.getFullYear();
        let material = This.contract.material;
        let month = 8; // This.shipment.sendDate.getMonth() + 1;
        let monthName = "AUGUST"; // This.shipment.sendDate.getMonthName();
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
            actionURL: "${contextPath}/api/price-base/get-base-price",

            callback: function (resp) {

                let fields = [];
                let priceBases = JSON.parse(resp.data);
                let groupedPriceBases = priceBases.groupBy("elementId");
                Object.keys(groupedPriceBases).forEach(elementId => {

                    let firstBasePrice = groupedPriceBases[elementId].first();
                    if (!firstBasePrice.element.payable)
                        return;

                    fields.add(isc.Unit.create({

                        unitCategory: firstBasePrice.financeUnit.categoryUnit,
                        disabledUnitField: true,
                        disabledValueField: true,
                        showValueFieldTitle: true,
                        showUnitFieldTitle: false,
                        name: firstBasePrice.element.name,
                        fieldValueTitle: firstBasePrice.element.name,
                    }));


                    fields.last().setUnitId(firstBasePrice.financeUnitId);
                    fields.last().setValue(groupedPriceBases[elementId].map(q => q.price).sum() / groupedPriceBases[elementId].length);
                });
                let fieldsNames = fields.map(q => q.name).join(", ");

                This.addMember(isc.Label.create({
                    width: "100%",
                    height: "50",
                    contents: "<b>" + "AVERAGE OF " + (month + moasValue) + "th MONTH OF " + year + " (MOAS" + (moasValue > 0 ? "+" : "-") + moasValue + ") " + " FOR " + fieldsNames + "<b>"
                }));
                This.addMembers(fields);


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
