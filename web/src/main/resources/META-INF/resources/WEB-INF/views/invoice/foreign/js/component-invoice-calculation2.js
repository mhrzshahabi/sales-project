isc.defineClass("InvoiceCalculation2", isc.VLayout).addProperties({
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
                    value: data[i].lotNo,
                    title: "<spring:message code='global.number'/>"
                }, {
                    align: "center",
                    name: "weightGW",
                    value: data[i].weightGW,
                    title: "<spring:message code='foreign-invoice.form.weight-gw'/>"
                }, {
                    align: "center",
                    name: "weightND",
                    value: data[i].weightND,
                    title: "<spring:message code='foreign-invoice.form.weight-nd'/>"
                }];

                for (let index = 0; index < data[i].elements.length; index++) {

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

                for (let index = 0; index < priceValues.length; index++) {

                    fields.add(isc.InvoiceCalculationRow.create({
                        assay: assayValues[index],
                        price: priceValues[index],
                        border: "1px solid rgba(0, 0, 0, 0.3)",
                    }));
                }

                fields.addAll([{
                    align: "center",
                    name: "deductionValue",
                    title: "<spring:message code='foreign-invoice.form.discount'/>"
                }, {
                    align: "center",
                    name: "deductionUnitConversionRate",
                    changed: function (form, item, value) {

                        let unitPriceField = this.getField('unitPrice');
                        this.setValue("subTotal", unitPriceField.getValue() * unitPriceField.deductionUnitConversionRate);
                    }
                }, {
                    align: "center",
                    name: "unitPrice",
                    title: "<spring:message code='foreign-invoice.form.unit-price'/>"
                }, {
                    align: "center",
                    name: "subTotal",
                    title: "<spring:message code='foreign-invoice.form.tab.subtotal'/>"
                }]);

                let dataSource = isc.MyRestDataSource.create({});
                let criteria = {
                    operator: "and",
                    criteria: [{fieldName: "", operator: "", value: ""}]
                };
                let grid = isc.ListGrid.nicico.getDefault(fields, dataSource, criteria);
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
