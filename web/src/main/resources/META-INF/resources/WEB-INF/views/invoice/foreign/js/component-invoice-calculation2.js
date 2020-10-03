isc.defineClass("InvoiceCalculation2", isc.VLayout).addProperties({
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
    // remittanceDetails: null,
    inspectionWeightData: null,
    inspectionAssayData: null,
    contractDetailData: null,
    weightData: null,
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
        // let dynamicForm = isc.DynamicForm.create({
        //     width: "80%",
        //     numCols: 6,
        //     fields: [{
        //
        //         name: "weightMilestone",
        //         editorType: "SelectItem",
        //         // required: true,
        //         wrapTitle: false,
        //         title: "<spring:message code='inspectionReport.weight.mileStone'/>",
        //         valueMap: JSON.parse('${Enum_MileStone}'),
        //     }, {
        //         name: "assayMilestone",
        //         editorType: "SelectItem",
        //         // required: true,
        //         wrapTitle: false,
        //         title: "<spring:message code='inspectionReport.assay.mileStone'/>",
        //         valueMap: JSON.parse('${Enum_MileStone}'),
        //     }]
        // });

        // this.addMember(isc.HLayout.create({
        //     width: "100%",
        //     showEdges: false,
        //     alignLayout: "center",
        //     padding: 10,
        //     layoutMargin: 10,
        //     membersMargin: 10,
        //     members: [dynamicForm, isc.IButton.create({
        //         autoFit: true,
        //         icon: "[SKIN]/actions/view.png",
        //         title: "<spring:message code='global.search'/>",
        //         click: function () {

                    debugger
                    // let validate = dynamicForm.validate();
                    // if (!validate) return false;
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
                            }
                        }
                    }));

            //     }
            // })]
        // }));

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

        this.editRowCalculation2();
    },
    editRowCalculation2: function () {
        if (this.weightData) {
            this.getMember(0).getMember(0).getField("weightMilestone").setValue(this.weightData.weightMilestone);
            this.getMember(0).getMember(0).getField("assayMilestone").setValue(this.weightData.assayMilestone);
            this.getMember(0).getMember(1).click();
        }
    },
    validate: function () {

        let isValid = this.getMember(0).getMember(0).validate();
        if (this.getMember(1).getTotalRows() === 0) {
            isValid = false;
        }
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
    },
    getForeignInvoiceItems: function () {

        let data = [];
        let This = this;
        let gridData = this.getMember(1).getData();
        let formData = this.getMember(0).getMember(0).getValues();

        function getForeignInvoiceItemDetails(item) {

            let itemDetails = [];
            item.assayInspections.forEach(q => {
                itemDetails.add({
                    assay: q.value,
                    materialElementId: q.materialElementId,
                    basePrice: This.getMember(1).priceBase.filter(bp => bp.elementId === q.materialElement.elementId).first().price,
                    deductionType: JSON.parse('${Enum_DeductionType}').DiscountPercent,
                    deductionValue: item.discount,
                    deductionPrice: item.price * item.discount / 100,
                    deductionUnitConversionRate: item.unitConversionRate,
                    rcPrice: 0,
                    rcBasePrice: 0,
                    rcUnitConversionRate: 1
                })
            });

            return itemDetails;
        }
        gridData.forEach(current => {
            let remittanceDetails = This.remittanceDetails.filter(q => q.inventory.id === current.inventory.id);
            if (remittanceDetails.length !== 1)
                return;

            let remittanceDetail = remittanceDetails.first();
            data.add({
                treatCost: 0,
                weightGW: current.weightGW,
                weightND: current.weightND,
                assayMilestone: formData.assayMilestone,
                weightMilestone: formData.weightMilestone,
                remittanceDetailId: remittanceDetail.id,
                foreignInvoiceItemDetails: getForeignInvoiceItemDetails(current)
            });
        });

        return data;
    }
});