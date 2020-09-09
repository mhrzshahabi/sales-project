isc.defineClass("InvoiceCalculation2", isc.VLayout).addProperties({ //TestShod
    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "auto",
    contract: null,
    shipment: null,
    currency: null,
    remittanceDetails: null,
    contractDetailData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let sendDate = new Date(This.shipment.sendDate);
        let grid = isc.ListGrid.nicico.getDefault([]);
        let priceArticleElement = isc.HTMLFlow.create({
            width: "100%"
        });
        let priceBaseElement = isc.Label.create({
            width: "100%"
        });

        this.addMember(isc.DynamicForm.create({

            numCols: 4,
            fields: [{

                type: "integer",
                name: "weightMilestone",
                editorType: "SelectItem",
                required: true,
                wrapTitle: false,
                title: "<spring:message code='inspectionReport.weight.mileStone'/>",
                validators: [{
                    type: "required",
                    validateOnChange: true
                }],
                valueMap: JSON.parse('${Enum_MileStone}'),
                changed: function (form, item, value) {

                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        params: {
                            weightMilestone: value,
                            contractId: This.contract.id,
                            shipmentId: This.shipment.id,
                            year: sendDate.getFullYear(),
                            month: sendDate.getMonth() + 1,
                            financeUnitId: This.currency.id,
                            reference: This.contractDetailData.basePriceReference,
                            inventoryIds: This.remittanceDetails.map(q => q.inventory.id),
                            assayMilestone: form.getItem("assayMilestone").getValue()
                        },
                        httpMethod: "GET",
                        actionURL: "${contextPath}" + "/api/foreign-invoice-item/get-calculation2-data",
                        callback: function (resp) {

                            if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

                                let data = JSON.parse(resp.data);

                                grid.setFields(data.fields);
                                grid.setData(data.data);

                                let priceBaseText = 'FINAL PRICE:';
                                for (let i = 0; i < data.priceBase.length; i++)
                                    priceBaseText += "<b>" + "MONTHLY AVERAGE OF " + This.contractDetailData.basePriceReference + "FOR" + (sendDate.getMonth() + 1 + This.contractDetailData.moasValue) +
                                        "th MONTH OF " + sendDate.getFullYear() + " (MOAS" + (This.contractDetailData.moasValue === 0 ? "" : (This.contractDetailData.moasValue > 0 ? "+" : "-") + This.contractDetailData.moasValue) +
                                        ") " + " FOR " + data.priceBase[i].element.name + "<b><br>";
                                priceBaseElement.setContents(priceBaseText);
                                priceArticleElement.setContents(data.priceArticleText);
                            }
                        }
                    }));
                }
            }, {
                type: "integer",
                name: "assayMilestone",
                editorType: "SelectItem",
                required: true,
                wrapTitle: false,
                title: "<spring:message code='inspectionReport.assay.mileStone'/>",
                validators: [{
                    type: "required",
                    validateOnChange: true
                }],
                valueMap: JSON.parse('${Enum_MileStone}'),
                changed: function (form, item, value) {

                }
            }]
        }));

        this.addMember(grid);
        this.addMember(priceArticleElement);
        this.addMember(priceBaseElement);
    }
});