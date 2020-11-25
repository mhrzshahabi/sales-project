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
    weightND: [],
    percent: null,
    remainingPercent: false,
    molybdenumRowData: null,
    contractDetailData: null,
    inspectionAssayData: null,
    inspectionWeightData: null,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        let sendDate = new Date(This.shipment.sendDate);

        let priceBaseLayout = isc.VLayout.create({
            width: "100%",
            canAdaptHeight: true,
            members: []
        });

        let percentElement = isc.DynamicForm.create({
            width: "100%",
            fields: [{
                name: "percent",
                title: "<spring:message code='foreign-invoice.form.percent'/>",
                type: "float",
                defaultValue: 100,
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    },
                    {
                        type: "floatLimit",
                        max: 100,
                        min: 0,
                        validateOnChange: true
                    }],
                icons: [
                    {
                        src: "pieces/16/accept.png",
                        click: function () {

                            // debugger
                            let percent = This.getMember(2).getValue("percent");
                            let grid = This.getMember(0);
                            for (let i = 0; i < grid.getTotalRows(); i++) {
                                grid.setEditValue(i, 1, percent);
                            }
                            grid.saveAllEdits();
                            grid.endEditing();
                        }
                    }
                ],
            }]
        });

        let priceArticleElement = isc.HTMLFlow.create({
            width: "100%"
        });
        let priceBaseArticleElement = isc.HTMLFlow.create({
            width: "100%"
        });

        let gridFirstFields = [{
            name: "lotNo",
            type: "text",
            title: "Label"
        }, {
            name: "inventory",
            title: "inventory",
            hidden: true
        }, {
            name: "percent",
            title: "Percent",
            type: "float",
            canEdit: "false",
            required: "false",
            validators: [
                {
                    type: "required",
                    validateOnChange: true
                },
                {
                    type: "floatLimit",
                    max: 100,
                    min: 0,
                    validateOnChange: true
                }],
            cellChanged: function (record, newValue, oldValue, rowNum, colNum, grid) {

                // debugger;
                if (newValue === 100) {
                    let weightND = This.weightND.filter(q => q.lotNo === record.lotNo).first().weightND;
                    grid.setEditValue(rowNum, 2, weightND);
                } else
                    grid.setEditValue(rowNum, 2, (newValue * record.weightND) / 100);

                grid.saveAllEdits();
                grid.endEditing();
            }
        }, {
            name: "weightND",
            type: "float",
            title: "Net Weight",
            format: "0.###",
            canEdit: "false",
            required: "false",
            cellChanged: function (record, newValue, oldValue, rowNum, colNum, grid) {

                This.updateGridData(record, newValue, oldValue, rowNum, colNum, grid);
            }
        }, {
            name: "weightGW",
            type: "float",
            title: "Gross Weight",
            format: "0.###",
            canEdit: "false",
            required: "false"
        }];

        let gridLastFields = [{
            name: "price",
            type: "float",
            title: "Price",
            format: "0.##",
            canEdit: "false",
            required: "false"
        }, {
            name: "discount",
            type: "float",
            title: "Discount",
            format: "0.##",
            canEdit: "false",
            required: "false"
        }, {
            name: "unitConversionRate",
            type: "float",
            title: "Conversion Rate",
            format: "0.###",
            canEdit: "true",
            required: "true",
            cellChanged: function (record, newValue, oldValue, rowNum, colNum, grid) {

                This.updateGridData(record, newValue, oldValue, rowNum, colNum, grid);
            }
        }, {
            name: "amount",
            type: "float",
            title: "Value Amount",
            format: "0.###",
            canEdit: "false",
            required: "false"
        }];


        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "POST",
            actionURL: "${contextPath}" + "/api/foreign-invoice-item/get-calculation-molybdenum-data",
            data: JSON.stringify(This.contractDetailData),
            params: {
                contractId: This.contract.id,
                sendDate: sendDate.toLocaleDateString(),
                financeUnitId: This.currency.id,
                inspectionAssayDataId: This.inspectionAssayData.id,
                inspectionWeightDataId: This.inspectionWeightData.id,
            },
            callback: function (resp) {

                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

                    let data = JSON.parse(resp.data);

                    let gridFields = data.fields;
                    let gridData = data.data;
                    gridData.forEach(record => {
                        This.weightND.add({
                            weightND: record.weightND,
                            lotNo: record.lotNo
                        });
                    });

                    gridFields.forEach(field => gridFirstFields.add(field));
                    gridLastFields.forEach(field => gridFirstFields.add(field));
                    let grid = isc.ListGrid.create({
                        showGridSummary: true,
                        showFilterEditor: false,
                        fields: []
                    });
                    grid.setFields(gridFirstFields);
                    grid.setData(gridData);

                    priceArticleElement.setContents("<b>" + data.priceContent + "</b>");
                    priceBaseArticleElement.setContents("<b>" + data.quotationalPeriodContent + "</b>");

                    for (let i = 0; i < data.priceBase.length; i++) {

                        let priceBase = data.priceBase[i];
                        priceBaseLayout.addMember(isc.Unit.create({
                            width: "100%",
                            disabledUnitField: true,
                            disabledValueField: false,
                            showValueFieldTitle: true,
                            showUnitFieldTitle: false,
                            fieldValueTitleWidth: "100",
                            unitHint: "PER " + priceBase.weightUnit.nameEN,
                            unitCategory: priceBase.financeUnit.categoryUnit,
                            fieldValueTitle: priceBase.element.name,
                            name: priceBase.element.name,
                            weightUnit: priceBase.weightUnit,
                            financeUnit: priceBase.financeUnit,
                            elementId: priceBase.elementId,
                            valueFieldIcons: [{

                                src: "pieces/16/accept.png",
                                click: function () {

                                    let savedRecordCount = grid.getData().length;
                                    let editRecordCount = grid.getAllEditRows().length;
                                    let recordCount = Math.max(editRecordCount, savedRecordCount);
                                    if (recordCount === 0) return true;

                                    for (let i = 0; i < recordCount; i++) {

                                        let price = 0;
                                        let record = grid.getRecord(i);
                                        data.priceBase.forEach(q => {

                                            if (q.elementId === priceBaseComponent.elementId)
                                                q.price = priceBaseComponent.getValues().value;

                                            let content = record[q.element.name + "Content"];
                                            if (!content) content = 0;
                                            price += q.price * content;
                                        });
                                        let discount = Number(record["discount"]);
                                        let unitConversionRate = record["unitConversionRate"];
                                        if (!unitConversionRate) unitConversionRate = 1;
                                        let newAmount = (price - (price * discount / 100)) * unitConversionRate;

                                        grid.startEditing(i);
                                        grid.setEditValues(i, {"price": price, "amount": newAmount});
                                        grid.saveAllEdits();
                                        grid.endEditing();
                                    }
                                }
                            }]
                        }));
                        let priceBaseComponent = priceBaseLayout.getMembers().last();
                        priceBaseComponent.setValue(priceBase.price);
                        priceBaseComponent.setUnitId(priceBase.financeUnitId);
                    }

                    This.addMember(grid);
                    This.addMember(priceBaseLayout);
                    This.addMember(percentElement);
                    This.addMember(priceArticleElement);
                    This.addMember(priceBaseArticleElement);
                    This.getMember(1).getMembers().forEach(member => member.valueFieldIcons[0].click());

                    This.addMember(isc.HTMLFlow.create({
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
                                title: "<spring:message code='global.form.next.step'/>",
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
                    This.addMember(isc.HTMLFlow.create({
                        width: "100%",
                        contents: "<span style='width: 100%; display: block; margin: 10px auto; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                    }));

                    This.setEditData();
                }
            }
        }));

    },
    updateGridData: function (record, newValue, oldValue, rowNum, colNum, grid) {

        let weightND = Number(record["weightND"]);
        grid.getFields().forEach(field => {
            if (field.title.contains("Content")) {

                let fieldName = field.name;
                let fieldColNum = grid.fields.indexOf(grid.fields.filter(q => q.name === fieldName).first());
                let exFieldVal = grid.getCellValue(record, rowNum, fieldColNum - 1);
                grid.setEditValue(rowNum, fieldColNum, weightND * (exFieldVal) / 100);
                grid.saveAllEdits();
                grid.endEditing();
            }
        });

        this.getMembers()[1].getMembers().forEach(member => member.valueFieldIcons[0].click());
    },
    setEditData: function () {

        if (this.molybdenumRowData) {

            let grid = this.getMember(0);
            let bPElement = this.getMember(1);
            let pElement = this.getMember(2);

            let rate = this.molybdenumRowData[0].deductionUnitConversionRate;
            let rateColNum = grid.fields.indexOf(grid.fields.filter(q => q.name === "unitConversionRate").first());
            for (let i = 0; i < grid.getTotalRows(); i++) {
                grid.setEditValue(i, rateColNum, rate);
            }
            grid.saveAllEdits();
            grid.endEditing();

            pElement.setValue("percent", this.percent);
            pElement.getItem("percent").icons[0].click();

            this.molybdenumRowData[0].basePrice.forEach(basePrice => {

                bPElement.getMembers().forEach(element => {
                    if (basePrice.materialElement.elementId === element.elementId) {
                        element.setValue(basePrice.basePrice);
                        element.valueFieldIcons[0].click();
                    }
                });
            });
        }
    },
    validate: function () {

        let isValid = !(this.getMember(0).getTotalRows() === 0);
        for (let i = 0; i < this.getMember(0).getTotalRows(); i++) {
            this.getMember(0).validateRow(i);
            isValid &= !this.getMember(0).hasErrors()
        }

        this.getMember(1).getMembers().forEach(unitComp => {
            unitComp.validate();
            if (unitComp.hasErrors())
                isValid = false;
        });

        this.getMember(2).validate();
        if (this.getMember(2).hasErrors())
            isValid = false;

        if (this.getMember(2).getValue("percent") > this.remainingPercent) {
            isc.warn("<spring:message code='foreign-invoice.form.percent.not.valid'/>");
            isValid = false;
        }

        if (isValid) {
            this.getMember(1).getMembers().forEach(member => member.valueFieldIcons[0].click());
            this.getMember(2).getItem("percent").icons[0].click();
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
        return this.getMember(0).getGridSummaryData().map(q => q.amount).sum();
    },
    getPercent: function () {
        return this.getMember(2).getValue("percent");
    },
    getForeignInvoiceItems: function () {

        let items = [];
        let This = this;
        let gridData = this.getMember(0).getData();

        function getForeignInvoiceItemDetails(gridRecord) {

            let itemDetails = [];
            let remittanceDetailId = gridRecord.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id;
            let assayData = This.inspectionAssayData.assayInspections.filter(q => q.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id === remittanceDetailId);
            assayData.forEach(q => {
                itemDetails.add({
                    assay: q.value,
                    materialElementId: q.materialElementId,
                    basePrice: This.getMember(1).getMembers().filter(pb => pb.elementId === q.materialElement.elementId).first().getValues().value,
                    deductionType: JSON.parse('${Enum_DeductionType}').DiscountPercent,
                    deductionValue: gridRecord.discount,
                    deductionPrice: gridRecord.price * gridRecord.discount / 100,
                    rcPrice: 0,
                    rcBasePrice: 0,
                    rcUnitConversionRate: 1
                })
            });

            return itemDetails;
        }

        gridData.forEach(current => {

            let remittanceDetailId = current.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id;
            let weightData = This.inspectionWeightData.weightInspections.filter(q => q.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id === remittanceDetailId)
                .first();

            items.add({
                treatCost: 0,
                weightGW: weightData.weightGW,
                weightND: current.weightND,
                assayMilestone: This.inspectionAssayData.assayInspections[0].mileStone,
                weightMilestone: This.inspectionWeightData.weightInspections[0].mileStone,
                deductionUnitConversionRate: current.unitConversionRate,
                remittanceDetailId: remittanceDetailId,
                foreignInvoiceItemDetails: getForeignInvoiceItemDetails(current)
            });
        });
        return items;
    }
});