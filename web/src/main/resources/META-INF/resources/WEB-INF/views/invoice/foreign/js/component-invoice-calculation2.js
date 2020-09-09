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

        let sendDate = new Date(This.shipment.sendDate);

        let fields = [{
            name: "lotNo",
            align: "center",
            title: "<spring:message code='global.number'/>"
        }, {
            align: "center",
            name: "weightGW ",
            title: "<spring:message code='foreign-invoice.form.weight-gw'/>"
        }, {
            align: "center",
            name: "weightND ",
            title: "<spring:message code='foreign-invoice.form.weight-nd'/>"
        }];

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            params: {
                 contractId : This.contract.id,
                 shipmentId : This.shipment.id,
                 reportMilestone: 1,//This.milestone
                 inventoryIds: [This.inventories],
                 reference :  This.contractDetailData.basePriceReference,
                 year : sendDate.getFullYear(),
                 month : sendDate.getMonth() + 1,
                 financeUnitId: This.currency.id
            },
            httpMethod: "GET",
            actionURL: "${contextPath}" + "/api/foreign-invoice-item/get-calculation2-data",
            callback: function (resp) {

                let data = JSON.parse(resp.data);

                // for (let index = 0; index < data.materialElements.length; index++) {
                //
                //     if (!data.materialElements[index].element.payable)
                //         continue;
                //
                //     fields.add({
                //         name: data.materialElements[index].element.name,
                //         border: "1px solid rgba(0, 0, 0, 0.3)",
                //         title: data.materialElements[index].element.name + ' (' + data.materialElements[index].unit.symbolUnit + ')',
                //     });
                // }

                //criteria
                // grid.setData(data);
                // this.addMember(grid);
                // this.addMember(isc.Label.create({
                //     contents: __contract.getPriceArticleTemplate(This.contract)
                // }));
            }
        }));
        // fields.addAll([{
        //     align: "center",
        //     name: "deductionValue",
        //     title: "<spring:message code='foreign-invoice.form.discount'/>"
        // }, {
        //     canEdit: true,
        //     required: true,
        //     type: "Float",
        //     align: "center",
        //     name: "deductionUnitConversionRate",
        //     changed: function (form, item, value) {
        //
        //         let deductionPriceField = this.getField('deductionPrice');
        //         this.setValue("subTotal", deductionPriceField.getValue() * value);
        //     }
        // }, {
        //     align: "center",
        //     name: "deductionPrice",
        //     title: "<spring:message code='foreign-invoice.form.unit-price'/>"
        // }, {
        //     align: "center",
        //     name: "subTotal",
        //     title: "<spring:message code='foreign-invoice.form.tab.subtotal'/>"
        // }]);
        let grid = isc.ListGrid.nicico.getDefault(fields, null, null);
        this.addMember(grid);
    },
    getValue: function () {
        this.getValues().sum();
    }
});
