isc.defineClass("InvoiceCalculationCathode", isc.VLayout).addProperties({
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
    molybdenumRowData: null,
    contractDetailData: null,
    inspectionAssayData: null,
    inspectionWeightData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let sendDate = new Date(This.shipment.sendDate);
        let grid = isc.ListGrid.nicico.getDefault([], null, null, {
            showGridSummary: true,
            showFilterEditor: false
        });
        let priceArticleElement = isc.HTMLFlow.create({
            width: "100%"
        });
        let priceBaseElement = isc.Label.create({
            width: "100%"
        });

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            params: {
                contractId: This.contract.id,
                reference: This.contractDetailData.basePriceReference,
                year: sendDate.getFullYear(),
                month: sendDate.getMonth() + 1,
                financeUnitId: This.currency.id,
                inspectionAssayDataId: This.inspectionAssayData.id,
                inspectionWeightDataId: This.inspectionWeightData.id,
            },
            httpMethod: "GET",
            actionURL: "${contextPath}" + "/api/foreign-invoice-item/get-calculation2-data",
            callback: function (resp) {

                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

                    let data = JSON.parse(resp.data);
                    grid.editorExit = function (editCompletionEvent, record, newValues, rowNum) {

                        if (editCompletionEvent !== "escape") {
                            let price = Number(record["price"]);
                            let discount = Number(record["discount"]);
                            let unitConversionRate = Number(newValues ? newValues : record["unitConversionRate"]);
                            let colNum = grid.fields.indexOf(grid.fields.filter(q => q.name === "amount").first());
                            if (!unitConversionRate) unitConversionRate = 1;
                            grid.setEditValue(rowNum, colNum, (price - (price * discount / 100)) * unitConversionRate);
                        }
                    };
                    data.fields.forEach(field => {

                        if (field.type !== "float")
                            return;

                        field.showHover = true;
                        field.hoverHTML = function (record, value, rowNum, colNum, grid) {

                            if (!record)
                                return;

                            let gridField = grid.getField(colNum);
                            if (!gridField)
                                return;

                            return record[gridField.name + "_UNIT"];
                        };
                        field.formatCellValue = function (value, record, rowNum, colNum) {
                            return record[field.name];
                        };
                    });
                    grid.setFields(data.fields);
                    grid.setData(data.data);
                    grid.priceBase = data.priceBase;

                    let priceBaseText = 'FINAL PRICE:<br>';
                    for (let i = 0; i < data.priceBase.length; i++)
                        priceBaseText += "<b>" + "MONTHLY AVERAGE OF " + This.contractDetailData.basePriceReference + " FOR " + (sendDate.getMonth() + 1 + This.contractDetailData.moasValue) +
                            "th MONTH OF " + sendDate.getFullYear() + " (MOAS" + (This.contractDetailData.moasValue === 0 ? "" : (This.contractDetailData.moasValue > 0 ? "+" : "-") + This.contractDetailData.moasValue) +
                            ") " + " FOR " + data.priceBase[i].element.name + ": " + data.priceBase[i].price + "</b><br>";
                    priceBaseElement.setContents(priceBaseText);
                    priceArticleElement.setContents("<b>" + data.priceArticleText + "</b>");

                    if (This.molybdenumRowData) {
                        let grid = This.getMember(0);
                        let colNum = grid.fields.indexOf(grid.fields.filter(q => q.name === "unitConversionRate").first());
                        for (let i = 0; i < grid.getTotalRows(); i++) {
                            let remittanceDetail = grid.getData()[i].inventory.remittanceDetails.filter(q => q.inputRemittance === false).first();
                            let molybdenumData = This.molybdenumRowData.filter(q => q.remittanceDetailId === remittanceDetail.id).first();
                            grid.setEditValue(i, colNum, molybdenumData.deductionUnitConversionRate);
                            grid.saveAllEdits();
                            grid.endEditing();
                        }
                    }
                }
            }
        }));


        this.addMember();
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

        // let isValid = !(this.getMember(0).getTotalRows() === 0);
        // for (let i = 0; i < this.getMember(0).getTotalRows(); i++) {
        //     this.getMember(0).validateRow(i);
        //     isValid &= !this.getMember(0).hasErrors()
        // }
        // return isValid;
    },
    okButtonClick: function () {

    },
    getBaseWeightValues: function () {

        // return {
        //     weightND: {
        //         getValues: function () {
        //
        //             return {
        //                 value: 1
        //             };
        //         }
        //     }
        // };
    },
    getDeductionSubTotal: function () {
        // return 0;
    },
    getCalculationSubTotal: function () {
        // return this.getMember(0).getGridSummaryData().map(q => q.amount).sum();
    },
    getForeignInvoiceItems: function () {

        // let items = [];
        // let This = this;
        // let gridData = this.getMember(0).getData();
        //
        // function getForeignInvoiceItemDetails(gridRecord) {
        //
        //     let itemDetails = [];
        //     let remittanceDetailId = gridRecord.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id;
        //     let assayData = This.inspectionAssayData.assayInspections.filter(q => q.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id === remittanceDetailId);
        //     assayData.forEach(q => {
        //         itemDetails.add({
        //             assay: q.value,
        //             materialElementId: q.materialElementId,
        //             basePrice: This.getMember(0).priceBase.filter(bp => bp.elementId === q.materialElement.elementId).first().price,
        //             deductionType: JSON.parse('${Enum_DeductionType}').DiscountPercent,
        //             deductionValue: gridRecord.discount,
        //             deductionPrice: gridRecord.price * gridRecord.discount / 100,
        //             rcPrice: 0,
        //             rcBasePrice: 0,
        //             rcUnitConversionRate: 1
        //         })
        //     });
        //
        //     return itemDetails;
        // }
        //
        // gridData.forEach(current => {
        //
        //     let remittanceDetailId = current.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id;
        //     let weightData = This.inspectionWeightData.weightInspections.filter(q => q.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id === remittanceDetailId)
        //         .first();
        //
        //     items.add({
        //         treatCost: 0,
        //         weightGW: weightData.weightGW,
        //         weightND: weightData.weightND,
        //         assayMilestone: This.inspectionAssayData.assayInspections[0].mileStone,
        //         weightMilestone: This.inspectionWeightData.weightInspections[0].mileStone,
        //         deductionUnitConversionRate: current.unitConversionRate,
        //         remittanceDetailId: remittanceDetailId,
        //         foreignInvoiceItemDetails: getForeignInvoiceItemDetails(current)
        //     });
        // });
        // return items;
    }
});