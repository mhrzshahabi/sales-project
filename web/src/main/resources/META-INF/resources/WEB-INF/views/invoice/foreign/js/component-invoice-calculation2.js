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
        let grid = isc.ListGrid.nicico.getDefault([], null, null, {
            showGridSummary: true
        });
        let priceArticleElement = isc.HTMLFlow.create({
            width: "100%"
        });
        let priceBaseElement = isc.Label.create({
            width: "100%"
        });
        this.addMember(isc.DynamicForm.create({

            numCols: 6,
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
            }, {
                editorType: "button",
                wrapTitle: false,
                title: "<spring:message code='global.search'/>",
                click: function (form, item, value) {

                    let validate = form.validate();
                    if (!validate) return false;
                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        params: {
                            weightMilestone: form.getItem("weightMilestone").getValue(),
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
                                grid.editorExit = function (editCompletionEvent, record, newValues, rowNum) {

                                    if (editCompletionEvent === "enter" && newValues) {

                                        let price = Number(record["price"]);
                                        let discount = Number(record["discount"]);
                                        let unitConversionRate = Number(newValues);
                                        let colNum = grid.fields.indexOf(grid.fields.filter(q => q.name === "amount").first());
                                        if (!unitConversionRate) unitConversionRate = 1;
                                        grid.setEditValue(rowNum, colNum, (price - (price * discount / 100)) * unitConversionRate);
                                    }
                                };
                                data.fields.forEach(field => {

                                    if (field.type !== "float")
                                        return;

                                    field.formatCellValue = function (value, record, rowNum, colNum) {
                                        return record[field.name];
                                    }
                                });
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
            }
            ]
        }));

        this.addMember(grid);
        this.addMember(priceArticleElement);
        this.addMember(priceBaseElement);

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));

        This.addMember(isc.ToolStrip.create({
            width: "100%",
            border: '0px',
            members: [
                isc.ToolStripButton.create({
                    width: "100",
                    height: "25",
                    autoFit: false,
                    title: "<spring:message code='global.ok'/>",
                    click: function () {

                        if (!This.validate())
                            return;

                        This.okButtonClick();

                        let tab = This.parentElement.parentElement;
                        tab.getTab(tab.selectedTab).pane.members.forEach(q => q.disable());
                        tab.selectTab(tab.selectedTab + 1 % tab.tabs.length);
                    }
                })
            ]
        }));

        this.addMember(isc.HTMLFlow.create({
            width: "100%",
            contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
        }));
    },
    validate: function () {

        let isValid = this.getMember(0).validate();
        for (let i = 0; i < this.getMember(1).getTotalRows(); i++) {

            this.getMember(1).validateRow(i);
            isValid &= !this.getMember(1).hasErrors()
        }

        return isValid;
    },
    okButtonClick: function () {

    },
    getBaseWeightValues: function () {

        return {
            weightND: {
                getValues: function () {

                    return {
                        value: 1
                    };
                }
            }
        };
    },
    getDeductionSubTotal: function () {
        return 0;
    },
    getCalculationSubTotal: function () {
        return this.getMember(1).getGridSummaryData().map(q => q.amount).sum();
    }
});