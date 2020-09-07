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
    currency: null,
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
            willHandleError: true,
            params: {
                year: year,
                materialId: material.id,
                month: month + moasValue,
                reference: basePriceReference,
                financeUnitId: This.currency.id
            },
            httpMethod: "GET",
            actionURL: "${contextPath}/api/price-base/get-avg-base-price",

            callback: function (resp) {

                let members = [];
                if (resp.data && (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)) {

                    let priceBases = JSON.parse(resp.data);
                    priceBases.forEach(priceBase => {

                        if (!priceBase.element.payable)
                            return;

                        members.add(isc.Unit.create({
                            unitHint: "PER " + priceBase.weightUnit.nameEN,
                            unitCategory: priceBase.financeUnit.categoryUnit,
                            fieldValueTitle: priceBase.element.name,
                            disabledUnitField: true,
                            disabledValueField: true,
                            showValueFieldTitle: true,
                            showUnitFieldTitle: false,
                            name: priceBase.element.name,
                            weightUnit: priceBase.weightUnit,
                            financeUnit: priceBase.financeUnit,
                            elementId: priceBase.elementId,
                        }));

                        members.last().setValue(priceBase.price);
                        members.last().setUnitId(priceBase.financeUnit.id);
                    });
                } else {

                    isc.RPCManager.handleError(resp);
                }

                let fieldsNames = members.map(q => q.name).join(", ");
                This.addMember(isc.Label.create({
                    width: "100%",
                    height: "50",
                    contents: "<b>" + "AVERAGE OF " + (month + moasValue) +
                    "th MONTH OF " + year + " (MOAS" + (moasValue === 0 ? "" : (moasValue > 0 ? "+" : "-") + moasValue) +
                    ") " + " FOR " + fieldsNames + "<b>"
                }));

                if (members.length)
                    This.addMembers(members);
            }
        }));
    },
    getValues: function () {

        let data = [];
        this.getMembers().slice(1).forEach(current => {

            let values = current.getValues();
            data.add({
                name: current.name,
                value: values.value,
                financeUnitId: values.unitId,
                elementId: current.elementId,
                weightUnit: current.weightUnit,
                financeUnit: current.financeUnit
            });
        });

        return data;
    },
    validate: function () {

        console.log("price ", this.getMembers())
        let isValid = true;
        this.getMembers().slice(1).forEach(current => {
            if (current.getValues().value === null)
                isValid = false;
        });
        return isValid;
    }
});
