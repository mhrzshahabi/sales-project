isc.defineClass("InvoiceCalculation2", isc.VLayout).addProperties({ //TestShod
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
    currency: null,
    inventories: [],
    initWidget: function () {

        let This = this;
        this.Super("initWidget", arguments);

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
                reference: basePriceReference,

                doIntegration: false,
                inventoryIds: This.inventories.map(q => q.id)
            },
            httpMethod: "GET",
            actionURL: "${contextPath}/api/foreign-invoice/get-calc-data",
            callback: function (resp) {

                let data = JSON.parse(resp.data);

                let fields = [{
                    name: "lotNo",
                    align: "center",
                    title: "<spring:message code='global.number'/>"
                }, {
                    align: "center",
                    name: "weightGW (" + data.weightUnit.symbolUnit + ")",
                    title: "<spring:message code='foreign-invoice.form.weight-gw'/>"
                }, {
                    align: "center",
                    name: "weightND (" + data.weightUnit.symbolUnit + ")",
                    title: "<spring:message code='foreign-invoice.form.weight-nd'/>"
                }];

                for (let index = 0; index < data.materialElements.length; index++) {

                    if (!data.materialElements[index].element.payable)
                        continue;

                    fields.add({
                        name: data.materialElements[index].element.name,
                        border: "1px solid rgba(0, 0, 0, 0.3)",
                        title: data.materialElements[index].element.name + ' (' + data.materialElements[index].unit.symbolUnit + ')',
                    });
                }

                fields.addAll([{
                    align: "center",
                    name: "deductionValue",
                    title: "<spring:message code='foreign-invoice.form.discount'/>"
                }, {
                    canEdit: true,
                    required: true,
                    type: "Float",
                    align: "center",
                    name: "deductionUnitConversionRate",
                    changed: function (form, item, value) {

                        let deductionPriceField = this.getField('deductionPrice');
                        this.setValue("subTotal", deductionPriceField.getValue() * value);
                    }
                }, {
                    align: "center",
                    name: "deductionPrice",
                    title: "<spring:message code='foreign-invoice.form.unit-price'/>"
                }, {
                    align: "center",
                    name: "subTotal",
                    title: "<spring:message code='foreign-invoice.form.tab.subtotal'/>"
                }]);

                let grid = isc.ListGrid.nicico.getDefault(fields, null, criteria);
                grid.setData(data);
                this.addMember(grid);
                this.addMember(isc.Label.create({
                    contents: __contract.getPriceArticleTemplate(This.contract)
                }));
            }
        }));
    },
    getValue: function () {
        this.getValues().sum();
    }
});
