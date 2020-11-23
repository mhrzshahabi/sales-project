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
    basePriceData: null,
    contractDetailDataMOAS: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "POST",
            willHandleError: true,
            data: JSON.stringify(This.contractDetailDataMOAS),
            actionURL: "${contextPath}/api/price-base/get-avg-base-price-by-moas",
            params: {
                contractId: This.contract.id,
                financeUnitId: This.currency.id,
            },
            callback: function (resp) {

                let members = [];
                if (resp.data && (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)) {

                    let priceBases = JSON.parse(resp.data);
                    priceBases.forEach(priceBase => {

                        // if (!priceBase.element.payable)
                        //     return;
                        members.add(isc.Unit.create({
                            unitHint: "PER " + priceBase.weightUnit.nameEN,
                            unitCategory: priceBase.financeUnit.categoryUnit,
                            fieldValueTitle: priceBase.element.name,
                            disabledUnitField: true,
                            disabledValueField: false,
                            showValueFieldTitle: true,
                            showUnitFieldTitle: false,
                            name: priceBase.element.name,
                            weightUnit: priceBase.weightUnit,
                            financeUnit: priceBase.financeUnit,
                            elementId: priceBase.elementId,
                        }));

                        members.last().setValue(priceBase.price);
                        members.last().setUnitId(priceBase.financeUnit.id);

                        if (This.basePriceData) {

                            members.forEach(m => {

                                let elementId = m.elementId;
                                m.setValue(This.basePriceData.filter(q => q.materialElement.elementId === elementId).first().basePrice);
                                m.setUnitId(This.basePriceData.filter(q => q.materialElement.elementId === elementId).first().basePriceFinanceUnit.id);
                                m.unitHint = "PER " + This.basePriceData.filter(q => q.materialElement.elementId === elementId).first().basePriceWeightUnit.nameEN;
                                m.weightUnit = This.basePriceData.filter(q => q.materialElement.elementId === elementId).first().basePriceWeightUnit;
                                m.financeUnit = This.basePriceData.filter(q => q.materialElement.elementId === elementId).first().basePriceFinanceUnit;
                            });
                        }
                    });
                } else {

                    isc.RPCManager.handleError(resp);
                }

                // let fieldsNames = members.map(q => q.name).join(", ");
                // This.addMember(isc.Label.create({
                //     width: "100%",
                //     height: "50",
                //     contents: "<b>" + "AVERAGE OF " + (month + MOASValue) +
                //         "th MONTH OF " + year + " (MOAS" + (MOASValue === 0 ? "" : (MOASValue > 0 ? "+" : "-") + MOASValue) +
                //         ") " + " FOR " + fieldsNames + "</b>"
                // }));

                if (members.length)
                    This.addMembers(members);
            }
        }));
    },
    getDataRowNo: function () {
        return this.getMembers().length;
    },
    getValues: function () {

        let data = [];
        this.getMembers().forEach(current => {

            let values = current.getValues();
            data.add({
                name: current.name,
                value: values.value,
                weightUnitId: current.weightUnit.id,
                financeUnitId: values.unitId,
                elementId: current.elementId,
                weightUnit: current.weightUnit,
                financeUnit: current.financeUnit
            });
        });

        return data;
    },
    validate: function () {

        let isValid = true;
        this.getMembers().forEach(current => {
            if (current.getValues().value === null)
                isValid = false;
        });
        return isValid;
    }
});
