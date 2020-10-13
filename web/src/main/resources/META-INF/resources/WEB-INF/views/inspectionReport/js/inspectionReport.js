//******************************************************* VARIABLES ****************************************************

var inspectionReportTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

inspectionReportTab.variable.data = [];
inspectionReportTab.variable.allCols = 0;
inspectionReportTab.variable.materialId = 0;
inspectionReportTab.variable.isWeightExist = true;
inspectionReportTab.variable.isAssayExist = true;
inspectionReportTab.variable.removeAllAssay = false;
inspectionReportTab.variable.removeAllWeight = false;
inspectionReportTab.variable.selectedInventories = [];

inspectionReportTab.variable.inspectionReportUrl = "${contextPath}" + "/api/inspectionReport/";

//***************************************************** RESTDATASOURCE *************************************************

inspectionReportTab.restDataSource.inspecReportRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            hidden: true,
            primaryKey: true,
            title: "<spring:message code='global.id'/>"
        },
        {
            name: "inspectionNO",
            title: "<spring:message code='inspectionReport.InspectionNO'/>"
        },
        {
            name: "inspector.name",
            title: "<spring:message code='inspectionReport.inspector.name'/>"
        },
        {
            name: "inspectorId",
            title: "<spring:message code='inspectionReport.inspectorId'/>"
        },
        {
            name: "inspectionPlace",
            title: "<spring:message code='inspectionReport.inspectionPlace'/>"
        },
        {
            name: "issueDate",
            title: "<spring:message code='inspectionReport.IssueDate'/>"
        },
        {
            name: "seller.name",
            title: "<spring:message code='inspectionReport.seller.name'/>"
        },
        {
            name: "sellerId",
            title: "<spring:message code='inspectionReport.sellerId'/>"
        },
        {
            name: "buyer.name",
            title: "<spring:message code='inspectionReport.buyer.name'/>"
        },
        {
            name: "buyerId",
            title: "<spring:message code='inspectionReport.buyerId'/>"
        },
        {
            name: "inspectionRateValue",
            title: "<spring:message code='inspectionReport.inspectionRateValue'/>"
        },
        {
            name: "inspectionRateValueType",
            title: "<spring:message code='inspectionReport.inspectionRateValueType'/>"
        },
        {
            name: "description",
            title: "<spring:message code='inspectionReport.inspectionRateValueType'/>"
        },
        {
            name: "unitId",
            title: "<spring:message code='global.unit'/>"
        },
        {
            name: "unit.name",
            title: "<spring:message code='global.unit'/>"
        },
    ],
    fetchDataURL: "${contextPath}/api/inspectionReport/spec-list"
});

inspectionReportTab.restDataSource.weightInspecRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "weighingType",
            title: "<spring:message code='weightInspection.weighingType'/>"
        },
        {
            name: "weightGW",
            title: "<spring:message code='weightInspection.weightGW'/>"
        },
        {
            name: "weightND",
            title: "<spring:message code='weightInspection.weightND'/>"
        },
        {
            name: "inspectionReport",
        },
        {
            name: "inventoryId",
            title: "<spring:message code='inspectionReport.InventoryId'/>"
        },
        {
            name: "unitId",
            title: "<spring:message code='global.unit'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/weightInspection/spec-list"
});

inspectionReportTab.restDataSource.assayInspecRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "value",
            title: "<spring:message code='assayInspection.value'/>"
        },
        {
            name: "materialElementId",
            title: "<spring:message code='assayInspection.materialElement'/>"
        },
        {
            name: "labName",
            title: "<spring:message code='assayInspection.LabName'/>"
        },
        {
            name: "labPlace",
            title: "<spring:message code='assayInspection.LabPlace'/>"
        },
        {
            name: "inspectionReportId",
            title: "<spring:message code='assayInspection.inspectionReportId'/>"
        },
        {
            name: "inventoryId",
            title: "<spring:message code='inspectionReport.InventoryId'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/assayInspection/spec-list"
});

inspectionReportTab.restDataSource.assayInspecTotalValuesRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "value",
            title: "<spring:message code='assayInspection.value'/>"
        },
        {
            name: "materialElementId",
            title: "<spring:message code='assayInspection.materialElement'/>"
        },
        {
            name: "inspectionReportId",
            title: "<spring:message code='assayInspection.inspectionReportId'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/assayInspectionTotalValues/spec-list"
});

inspectionReportTab.restDataSource.contactRest = {
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "code",
            title: "<spring:message code='contact.code'/>"
        },
        {
            name: "nameFA",
            title: "<spring:message code='contact.nameFa'/>"
        },
        {
            name: "nameEN",
            title: "<spring:message code='contact.nameEn'/>"
        },
        {
            name: "commercialRole",
        },
    ],
    fetchDataURL: "${contextPath}/api/contact/spec-list"
};

inspectionReportTab.restDataSource.contactRest1 = {
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "code",
            title: "<spring:message code='contact.code'/>"
        },
        {
            name: "nameFA",
            title: "<spring:message code='contact.nameFa'/>"
        },
        {
            name: "nameEN",
            title: "<spring:message code='contact.nameEn'/>"
        },
        {
            name: "commercialRole",
        },
    ],
    fetchDataURL: "${contextPath}/api/contact/spec-list1"
};

inspectionReportTab.restDataSource.contactRest2 = {
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "code",
            title: "<spring:message code='contact.code'/>"
        },
        {
            name: "nameFA",
            title: "<spring:message code='contact.nameFa'/>"
        },
        {
            name: "nameEN",
            title: "<spring:message code='contact.nameEn'/>"
        },
        {
            name: "commercialRole",
        },
    ],
    fetchDataURL: "${contextPath}/api/contact/spec-list2"
};

inspectionReportTab.restDataSource.contractContactRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "contract",
            // title: "<spring:message code='contact.code'/>"
        },
        {
            name: "contact",
            // title: "<spring:message code='contact.nameFa'/>"
        },
        {
            name: "commercialRole",
            // title: "<spring:message code='contact.nameEn'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/contract-contact/spec-list"
});

inspectionReportTab.restDataSource.inventoryRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "materialItem.gdsName",
            title: "<spring:message code='MaterialItem.gdsName'/>"
        },
        {
            name: "materialItem.material.descFA",
            title: "<spring:message code='material.title'/>"
        },
        {
            name: "label",
            title: "<spring:message code='inspectionReport.InventoryLabel'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/inventory/spec-list"
});

inspectionReportTab.restDataSource.materialRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "descFA",
            title: "<spring:message code='material.descFA'/>"
        },
        {
            name: "code",
            title: "<spring:message code='material.code'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/material/spec-list"
});

inspectionReportTab.restDataSource.materialElementRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "material.descFA",
            title: "<spring:message code='material.descFA'/>"
        },
        {
            name: "materialId",
            title: "<spring:message code='material.descFA'/>"
        },
        {
            name: "element.name",
            title: "<spring:message code='assayInspection.materialElement.name'/>"
        },
        {
            name: "payable",
            title: "<spring:message code='assayInspection.materialElement.payable'/>"
        },
        {
            name: "unitId",
            title: "<spring:message code='global.unit'/>"
        },
        {
            name: "unit.name",
            title: "<spring:message code='global.unit'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/materialElement/spec-list"
});

inspectionReportTab.restDataSource.unitRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "nameFA",
            title: "nameFA"
        },
        {
            name: "nameEN",
            title: "nameEN"
        },
    ],
    fetchDataURL: "${contextPath}/api/unit/spec-list"
});

inspectionReportTab.restDataSource.shipmentRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "bookingCat",
            title: "<spring:message code ='shipment.bookingCat'/>",
            showHover: true
        },
        {
            name: "material.descEN",
            title: "<spring:message code ='material.descEN'/>",
            showHover: true
        },
        {
            name: "contact.nameFA",
            title: "<spring:message code ='contact.nameFa'/>",
            showHover: true
        },
        {
            name: "sendDate",
            title: "<spring:message code ='global.sendDate'/>",
            showHover: true,
            type: "date"
        },
        {
            name: "shipmentType.shipmentType",
            title: "<spring:message code ='shipment.shipmentType'/>",
            showHover: true
        },
        {
            name: "shipmentMethod.shipmentMethod",
            title: "<spring:message code ='shipment.shipmentMethod'/>",
            showHover: true
        },
        {
            name: "vessel.name",
            title: "<spring:message code ='shipment.vesselName'/>",
            showHover: true
        },
        {
            name: "contractShipment",
            title: "<spring:message code ='shipment.contractShipment'/>",
            showHover: true
        },
    ],
    fetchDataURL: "${contextPath}/api/shipment/spec-list"
});

inspectionReportTab.restDataSource.contractRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "no",
            title: "<spring:message code ='shipment.bookingCat'/>",
            showHover: true
        },
        {
            name: "date",
            title: "<spring:message code ='material.descEN'/>",
            showHover: true
        },
        {
            name: "material",
            title: "<spring:message code ='contact.nameFa'/>",
            showHover: true
        },
        {
            name: "contractContacts",
            title: "<spring:message code ='global.sendDate'/>",
            showHover: true,
            type: "date"
        }
    ],
    fetchDataURL: "${contextPath}/api/g-contract/spec-list"
});

inspectionReportTab.restDataSource.remittanceDetailRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "amount"
        },
        {
            name: "remittance"
        },
        {
            name: "remittanceId"
        }
    ],
    fetchDataURL: "${contextPath}/api/remittance-detail/spec-list"
});

//***************************************************** RESTDATASOURCE *************************************************

inspectionReportTab.method.setShipmentAndInventoryCriteria = function (materialId) {

    inspectionReportTab.dynamicForm.inspecReport.getItem("shipmentId").setOptionCriteria({
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "materialId",
            operator: "equals",
            value: materialId
        }]
    });

    inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").setOptionCriteria({
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            // fieldName: "remittanceDetails.remittance.shipment.materialId",
            fieldName: "materialItem.materialId",
            operator: "equals",
            value: materialId
        }]
    });
};

inspectionReportTab.method.getAssayElementFields = function (materialId, setDataCallback) {

    let elementCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [
            {fieldName: "materialId", operator: "equals", value: materialId},
            {
                _constructor: "AdvancedCriteria",
                operator: "or",
                criteria: [
                    {fieldName: "payable", operator: "equals", value: true},
                    {fieldName: "penalty", operator: "equals", value: true}
                ]
            },
        ]
    };

    inspectionReportTab.restDataSource.materialElementRest.fetchData(elementCriteria, function (dsResponse, data, dsRequest) {

        if (data.length !== 0) {

            let fields = [{
                name: "inventoryId",
                title: "<spring:message code='inspectionReport.InventoryId'/>",
                type: "staticText",
                formatCellValue: function (value, record, rowNum, colNum, grid) {

                    let selectedInventories = inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId").getSelectedRecords();
                    if (record == null || value == null || !selectedInventories || !selectedInventories.length)
                        return;

                    let inventory = selectedInventories.filter(q => q.id === value).first();
                    if (inventory == null) return;

                    return inventory.label;
                }
            }];

            fields.addAll(data.map(
                me => {
                    return {
                        name: me.element.name,
                        title: me.element.name + " (" + me.unit.nameEN + ")",
                        ids: [],
                        versions: [],
                        meId: me.id,
                        required: true,
                        validators: [{
                            type: "isFloat",
                            validateOnChange: true
                        }, {
                            type: "required",
                            validateOnChange: true
                        }],
                        format: "0.###",
                        formatCellValue: function (value, record, rowNum, colNum) {

                            if (!value)
                                return value;

                            return value + "";
                        }
                    }
                }
            ));

            inspectionReportTab.listGrid.assayElement.setFields(fields);

            let sumFields = [{
                name: "title",
                canEdit: false,
                width: "30%",
                align: "center",
            }];

            sumFields.addAll(data.map(
                me => {
                    return {
                        name: me.element.name,
                        canEdit: false,
                        width: "30%",
                        align: "center",
                        format: "0.###",
                        formatCellValue: function (value, record, rowNum, colNum) {

                            if (!value)
                                return value;

                            return value + "";
                        },
                        // editorExit(editCompletionEvent, record, newValue, rowNum, colNum) {
                        //
                        //     let savedRecordCount = inspectionReportTab.listGrid.assayElement.getData().length;
                        //     let editRecordCount = inspectionReportTab.listGrid.assayElement.getAllEditRows().length;
                        //     let recordCount = Math.max(editRecordCount, savedRecordCount);
                        //     if (editCompletionEvent === "escape" || recordCount === 0) return true;
                        //
                        //     for (let i = 0; i < recordCount; i++) {
                        //
                        //         let avr = (parseFloat(newValue) / recordCount);
                        //         inspectionReportTab.listGrid.assayElement.startEditing(i);
                        //         inspectionReportTab.listGrid.assayElement.getAllEditRows().forEach(rn => inspectionReportTab.listGrid.assayElement.setEditValue(rn, colNum + 1, avr));
                        //         inspectionReportTab.listGrid.assayElement.endEditing();
                        //     }
                        //
                        //     return true;
                        // }
                    }
                }
            ));
            inspectionReportTab.listGrid.assayElementSum.setFields(sumFields);

            if (setDataCallback) setDataCallback();
        }
    });
};

inspectionReportTab.method.groupByAssays = function (array, groupFieldName) {

    let group = array.groupBy(groupFieldName);
    let result = [];
    Object.keys(group).forEach(q => result.add(group[q]));
    return result;

};

inspectionReportTab.method.setWeightElementListRows = function (selectedInventories) {

    if (!selectedInventories || !selectedInventories.length)
        return;

    selectedInventories.forEach((current, index, array) => inspectionReportTab.listGrid.weightElement.startEditingNew({inventoryId: current}));
};

inspectionReportTab.method.setAssayElementListRows = function (selectedInventories) {

    if (!selectedInventories || !selectedInventories.length)
        return;
    if (inspectionReportTab.variable.materialId === ImportantIDs.material.COPPER_CATHOD)
        return;

    selectedInventories.forEach((current, index, array) => inspectionReportTab.listGrid.assayElement.startEditingNew({inventoryId: current}));
};

inspectionReportTab.method.setSavedWeightData = function (weightInspectionArrayData) {

    inspectionReportTab.listGrid.weightElement.setData(weightInspectionArrayData);
    inspectionReportTab.listGrid.weightElement.saveAllEdits();
    inspectionReportTab.listGrid.weightElement.endEditing();
};

inspectionReportTab.method.setSavedAssayData = function (assayInspectionArrayData, selectedAssayInventoryIds) {
    let fields = inspectionReportTab.listGrid.assayElement.fields;
    let length = inspectionReportTab.listGrid.assayElement.fields.length;
    let assayData = inspectionReportTab.method.groupByAssays(assayInspectionArrayData, "inventoryId");

    selectedAssayInventoryIds.forEach((current, index, array) => {
        let assayRecord = assayData[index];
        assayRecord.forEach((c, i, arr) => {
            for (let n = 2; n < length; n++) {

                if (c.materialElementId === fields[n].meId) {

                    if (inspectionReportTab.listGrid.assayElement.getField(n).ids.length > index)
                        inspectionReportTab.listGrid.assayElement.getField(n).ids = [];

                    if (inspectionReportTab.listGrid.assayElement.getField(n).versions.length > index)
                        inspectionReportTab.listGrid.assayElement.getField(n).versions = [];

                    inspectionReportTab.listGrid.assayElement.setEditValue(index, n, c.value);
                    inspectionReportTab.listGrid.assayElement.getField(n).ids.add(c.id);
                    inspectionReportTab.listGrid.assayElement.getField(n).versions.add(c.version);
                }
            }
        });
    });
    inspectionReportTab.listGrid.assayElement.saveAllEdits();
    inspectionReportTab.listGrid.assayElement.endEditing();
};

inspectionReportTab.method.setWeightElementSum = function () {

    inspectionReportTab.listGrid.weightElementSum.setData([{
        "title": "<spring:message code='foreign-invoice.form.tab.subtotal'/>",
        "weightND": inspectionReportTab.listGrid.weightElement.getData().map(a => a.weightND).sum(),
        "weightGW": inspectionReportTab.listGrid.weightElement.getData().map(a => a.weightGW).sum()
    }]);
};

inspectionReportTab.method.setAssayElementSum = function () {

    let sumData = {"title": "<spring:message code='foreign-invoice.form.tab.subtotal'/>"};
    inspectionReportTab.listGrid.assayElement.getFields().filter(f => f.title.contains(f.name)).forEach(f => {
        sumData[f.name] = inspectionReportTab.listGrid.assayElement.getData().map(a => a[f.name]).sum();
    });
    inspectionReportTab.listGrid.assayElementSum.setData([sumData]);
};

inspectionReportTab.method.createWeightListGrid = function () {

    let selectedInventories = inspectionReportTab.dynamicForm.inspecReport.getValue("inventoryId");
    inspectionReportTab.variable.isWeightExist = true;
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

        httpMethod: "GET",
        actionURL: "${contextPath}" + "/api/weightInspection/get-weight-inventory-data",
        params: {
            reportMilestone: inspectionReportTab.dynamicForm.inspecReport.getValue("mileStone"),
            inventoryIds: selectedInventories
        },
        callback: function (resp) {

            inspectionReportTab.listGrid.weightElement.setData([]);
            inspectionReportTab.hStack.weightUnitSum.setMembers([]);

            let inventoryIds = JSON.parse(resp.httpResponseText);
            if (!inventoryIds || !inventoryIds.length) {
                inspectionReportTab.variable.isWeightExist = false;
                return;
            }

            let inventories = inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").getSelectedRecords().filter(q => inventoryIds.contains(q.id));

            if (inspectionReportTab.variable.method === "PUT") {

                let preInventories = selectedInventories.filter(q => !inventoryIds.includes(q));
                let weightInspectionArray = inspectionReportTab.listGrid.main.getSelectedRecord().weightInspections;
                inspectionReportTab.method.setWeightElementListRows(preInventories);
                inspectionReportTab.method.setSavedWeightData(weightInspectionArray);
            }

            inspectionReportTab.method.setWeightElementListRows(inventoryIds);
            inspectionReportTab.method.setWeightElementSum();

            let unitArray = [];
            let amountArray = [];
            let remittanceDetails = inventories.map(q => q.remittanceDetails);
            remittanceDetails.forEach(rds => {
                rds.forEach(r => {
                    unitArray.push(r.unitId);
                });
            });
            unitArray = unitArray.distinct();
            unitArray.forEach((u, index) => {
                if (amountArray[index] === undefined) {
                    amountArray[index] = 0;
                }
                remittanceDetails.forEach(rds => {
                    rds.forEach((r, i) => {
                        if (r.unitId === u && r.amount !== 0) {
                            amountArray[index] = amountArray[index] + r.amount;
                        }
                    });
                });
            });
            unitArray.forEach((current, index) => {
                if (amountArray[index] !== 0) {
                    let unitMember = isc.Unit.create({
                        disabledUnitField: true,
                        disabledValueField: true,
                        showUnitFieldTitle: false,
                        showValueFieldTitle: false,
                        align: "left",
                        width: "25%"
                    });
                    unitMember.setValue(amountArray[index]);
                    unitMember.setUnitId(current);
                    inspectionReportTab.hStack.weightUnitSum.addMember(unitMember);
                }
            });
        }
    }));
};

inspectionReportTab.method.createAssayListGrid = function () {

    let selectedInventories = inspectionReportTab.dynamicForm.inspecReport.getValue("inventoryId");
    inspectionReportTab.variable.isAssayExist = true;
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

        httpMethod: "GET",
        actionURL: "${contextPath}" + "/api/assayInspection/get-assay-inventory-data",
        params: {
            reportMilestone: inspectionReportTab.dynamicForm.inspecReport.getValue("mileStone"),
            inventoryIds: selectedInventories
        },
        callback: function (resp) {

            inspectionReportTab.listGrid.assayElement.setData([]);
            inspectionReportTab.hStack.assayUnitSum.setMembers([]);

            let inventoryIds = JSON.parse(resp.httpResponseText);
            if (!inventoryIds || !inventoryIds.length) {
                inspectionReportTab.variable.isAssayExist = false;
                if (!inspectionReportTab.variable.isWeightExist && !inspectionReportTab.variable.isAssayExist)
                    inspectionReportTab.dialog.say("<spring:message code='global.message.selected.inventories.have.inspection'/>");
                return;
            }

            let inventories = inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").getSelectedRecords().filter(q => inventoryIds.contains(q.id));

            if (inspectionReportTab.variable.method === "PUT") {

                let preInventories = selectedInventories.filter(q => !inventoryIds.includes(q));
                let assayInspectionArray = inspectionReportTab.listGrid.main.getSelectedRecord().assayInspections;
                inspectionReportTab.method.setAssayElementListRows(preInventories);
                inspectionReportTab.method.setSavedAssayData(assayInspectionArray, preInventories);
            }

            inspectionReportTab.method.setAssayElementListRows(inventoryIds);
            inspectionReportTab.method.setAssayElementSum();

            let unitArray = [];
            let amountArray = [];
            let remittanceDetails = inventories.map(q => q.remittanceDetails);
            remittanceDetails.forEach(rds => {
                rds.forEach(r => {
                    unitArray.push(r.unitId);
                });
            });
            unitArray = unitArray.distinct();
            unitArray.forEach((u, index) => {
                if (amountArray[index] === undefined) {
                    amountArray[index] = 0;
                }
                remittanceDetails.forEach(rds => {
                    rds.forEach((r, i) => {
                        if (r.unitId === u && r.amount !== 0) {
                            amountArray[index] = amountArray[index] + r.amount;
                        }
                    });
                });
            });
            unitArray.forEach((current, index) => {
                if (amountArray[index] !== 0) {
                    let unitMember = isc.Unit.create({
                        disabledUnitField: true,
                        disabledValueField: true,
                        showUnitFieldTitle: false,
                        showValueFieldTitle: false,
                        align: "left",
                        width: "25%"
                    });
                    unitMember.setValue(amountArray[index]);
                    unitMember.setUnitId(current);
                    inspectionReportTab.hStack.assayUnitSum.addMember(unitMember);
                }
            });
        }
    }));
};

inspectionReportTab.method.materialChange = function () {

    inspectionReportTab.dynamicForm.assayLab.getField("labName").setRequired(true);
    inspectionReportTab.dynamicForm.assayLab.getField("labPlace").setRequired(true);
    inspectionReportTab.tab.inspecTabs.tabs.filter(q => q.name === "assay").first().pane.enable();
    inspectionReportTab.variable.materialId = inspectionReportTab.dynamicForm.material.getValue("material");
    inspectionReportTab.method.setShipmentAndInventoryCriteria(inspectionReportTab.variable.materialId);

    switch (inspectionReportTab.variable.materialId) {

        case ImportantIDs.material.COPPER_CATHOD:
            inspectionReportTab.dynamicForm.assayLab.getField("labName").setRequired(false);
            inspectionReportTab.dynamicForm.assayLab.getField("labPlace").setRequired(false);
            inspectionReportTab.tab.inspecTabs.tabs.filter(q => q.name === "assay").first().pane.disable();
            inspectionReportTab.listGrid.weightElement.unitId = 1;
            break;
        case ImportantIDs.material.MOLYBDENUM_OXIDE:
            inspectionReportTab.listGrid.weightElement.unitId = 2;

            break;
        case ImportantIDs.material.COPPER_CONCENTRATES:
            inspectionReportTab.listGrid.weightElement.unitId = 3;
            break;

        default:
            return;
    }

    let unitName = StorageUtil.get('parameters').unit.filter(q => q.id === inspectionReportTab.listGrid.weightElement.unitId).first().name;
    let weightWGTitle = inspectionReportTab.listGrid.weightElement.getFieldTitle("weightGW").replace(/ *\([^)]*\) */g, "");
    inspectionReportTab.listGrid.weightElement.setFieldTitle("weightGW", weightWGTitle + " (" + unitName + ")");
    let weightNDTitle = inspectionReportTab.listGrid.weightElement.getFieldTitle("weightND").replace(/ *\([^)]*\) */g, "");
    inspectionReportTab.listGrid.weightElement.setFieldTitle("weightND", weightNDTitle + " (" + unitName + ")");
};

inspectionReportTab.variable.inspectorCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Inspector"}]
};

inspectionReportTab.variable.sellerCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Seller"}]
};

inspectionReportTab.variable.buyerCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Buyer"}]
};

inspectionReportTab.variable.currencyInUnitCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "categoryUnit", operator: "equals", value: 1}]
};

inspectionReportTab.dynamicForm.material = isc.DynamicForm.create({
    height: "10%",
    numCols: 2,
    margin: 10,
    align: "center",
    titleWidth: 150,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: [
        {
            name: "material",
            title: "<spring:message code='material.title'/>",
            required: true,
            wrapTitle: false,
            autoFetchData: false,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "descFA",
            pickListWidth: "500",
            pickListHeight: "300",
            optionDataSource: inspectionReportTab.restDataSource.materialRest,
            pickListProperties:
                {
                    showFilterEditor: true
                },
            pickListFields: [
                {
                    name: "descFA",
                },
                {
                    name: "code",
                }
            ],
            validators: [
                {
                    type: "required",
                    validateOnChange: true
                }],
            changed: function (form, item, value) {

                inspectionReportTab.method.materialChange();

                inspectionReportTab.dynamicForm.inspecReport.getItem("shipmentId").setValue([]);
                inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").setValue([]);
                inspectionReportTab.dynamicForm.inspecReport.getItem("mileStone").setValue(null);
                inspectionReportTab.listGrid.weightElement.setData([]);
                inspectionReportTab.listGrid.assayElement.setData([]);
            }
        }
    ]
});

inspectionReportTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "id",
        hidden: true
    },
    {
        name: "shipmentId",
        title: "<spring:message code='Shipment.title'/>",
        autoFetchData: false,
        editorType: "ComboBoxItem",
        addUnknownValues: false,
        valueField: "id",
        displayField: "bookingCat",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: inspectionReportTab.restDataSource.shipmentRest,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "bookingCat"
            },
            {
                name: "material.descEN",
            },
            {
                name: "contact.name",
            },
            {
                name: "sendDate",
                type: "date"
            },
            {
                name: "shipmentType.shipmentType",
            },
            {
                name: "shipmentMethod.shipmentMethod",
            },
        ],
        changed: function (form, item, value) {

            inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").setValue([]);

            if (value) {

                inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").setOptionCriteria({
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{
                        fieldName: "remittanceDetails.remittance.shipmentId",
                        operator: "equals",
                        value: value
                    }]
                });

                if (inspectionReportTab.variable.method === "POST") {

                    let aCriteria = {
                        _constructor: "AdvancedCriteria",
                        operator: "and",
                        criteria: [{
                            fieldName: "id",
                            operator: "equals",
                            value: value
                        }]
                    };
                    inspectionReportTab.restDataSource.shipmentRest.fetchData(aCriteria, function (dsResponse, data, dsRequest) {

                        if (data.length) {
                            let contractId = data[0].contractShipment.contractId;
                            let bCriteria = {
                                _constructor: "AdvancedCriteria",
                                operator: "and",
                                criteria: [{
                                    fieldName: "id",
                                    operator: "equals",
                                    value: contractId
                                }]
                            };
                            inspectionReportTab.restDataSource.contractRest.fetchData(bCriteria, function (conDsResponse, conData, conDsRequest) {
                                if (conData.length) {
                                    inspectionReportTab.dynamicForm.inspecReport.getItem("sellerId").setValue([]);
                                    inspectionReportTab.dynamicForm.inspecReport.getItem("buyerId").setValue([]);
                                    let buyerId = conData[0].contractContacts.filter(q => q.commercialRole === "Buyer").first().contactId;
                                    let sellerId = conData[0].contractContacts.filter(q => q.commercialRole === "Seller").first().contactId;
                                    inspectionReportTab.dynamicForm.inspecReport.setValue("buyerId", buyerId);
                                    inspectionReportTab.dynamicForm.inspecReport.setValue("sellerId", sellerId);
                                }
                            });
                        }
                    });
                }

            } else
                inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").setOptionCriteria({
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{
                        fieldName: "materialItem.materialId",
                        operator: "equals",
                        value: inspectionReportTab.dynamicForm.material.getValue("material")
                    }]
                });

        }
    },
    {
        name: "inspectionNO",
        title: "<spring:message code='inspectionReport.InspectionNO'/>",
        required: true,
        wrapTitle: false,
        keyPressFilter: "[0-9]",
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "inspectorId",
        title: "<spring:message code='inspectionReport.inspector.name'/>",
        required: true,
        wrapTitle: false,
        autoFetchData: true,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "name",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create(inspectionReportTab.restDataSource.contactRest),
        optionCriteria: inspectionReportTab.variable.inspectorCriteria,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "nameFA",
                align: "center"
            },
            {
                name: "nameEN",
                align: "center"
            }
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "inspectionPlace",
        title: "<spring:message code='inspectionReport.inspectionPlace'/>",
        type: "text",
        required: true,
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "issueDate",
        title: "<spring:message code='inspectionReport.IssueDate'/>",
        type: "dateTime",
        editorType: "date",
        wrapTitle: false,
        dateFormatter: "yyyy-MM-dd HH:mm:ss"
    },
    {
        name: "inventoryId",
        title: "<spring:message code='inspectionReport.InventoryId'/>",
        required: true,
        wrapTitle: false,
        autoFetchData: false,
        type: "SelectItem",
        multiple: true,
        valueField: "id",
        displayField: "label",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: inspectionReportTab.restDataSource.inventoryRest,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "materialItem.material.descFA",
                align: "center",
            },
            {
                name: "materialItem.gdsName",
                align: "center",
            },
            {
                name: "label",
                align: "center",
            }
        ],
        validators: [{
            type: "required",
            validateOnChange: true
        }],
        getSelectedRecords: function () {

            if (inspectionReportTab.variable.selectedInventories && inspectionReportTab.variable.selectedInventories.length)
                return inspectionReportTab.variable.selectedInventories;

            return this.Super("getSelectedRecords", arguments);
        },
        changed: function (form, item, value) {

            inspectionReportTab.variable.selectedInventories = [];
            inspectionReportTab.listGrid.weightElement.setData([]);
            inspectionReportTab.listGrid.assayElement.setData([]);
        }
    },
    {
        name: "mileStone",
        title: "<spring:message code='inspectionReport.mileStone'/>",
        required: true,
        wrapTitle: false,
        valueMap: JSON.parse('${Enum_MileStone}'),
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
    },
    {
        colSpan: 2,
        width: "150",
        name: "select",
        title: "Select",
        type: "ButtonItem",
        icon: "pieces/16/icon_add.png",
        click: function (form, item) {

            if (!inspectionReportTab.dynamicForm.material.getValue("material") ||
                !form.getItem("inventoryId").getValue() ||
                !form.getItem("mileStone").getValue() ||
                !form.getItem("inventoryId").getValue().length)
                inspectionReportTab.dialog.say("<spring:message code='global.message.inspection.required.fields'/>");
            else {
                inspectionReportTab.method.getAssayElementFields(inspectionReportTab.variable.materialId, () => {
                    inspectionReportTab.method.createWeightListGrid();
                    inspectionReportTab.method.createAssayListGrid();
                });
                inspectionReportTab.dynamicForm.material.getItem("material").disable();
                inspectionReportTab.dynamicForm.inspecReport.getItem("refresh").enable();
                inspectionReportTab.dynamicForm.inspecReport.getItem("mileStone").disable();
                inspectionReportTab.dynamicForm.inspecReport.getItem("shipmentId").disable();
                inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").disable();
                item.disable();
            }
        }
    },
    {
        colSpan: 2,
        width: "150",
        name: "refresh",
        title: "Refresh",
        type: "ButtonItem",
        icon: "pieces/16/refresh.png",
        click: function (form, item) {

            inspectionReportTab.dynamicForm.inspecReport.getItem("select").enable();
            inspectionReportTab.dynamicForm.inspecReport.getItem("mileStone").enable();
            inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").enable();
            item.disable();

            inspectionReportTab.variable.removeAllWeight = false;
            inspectionReportTab.variable.removeAllAssay = false;
        }
    },
    {
        name: "sellerId",
        title: "<spring:message code='inspectionReport.sellerId'/>",
        required: true,
        wrapTitle: false,
        autoFetchData: true,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "name",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create(inspectionReportTab.restDataSource.contactRest1),
        optionCriteria: inspectionReportTab.variable.sellerCriteria,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "nameFA",
                align: "center"
            },
            {
                name: "nameEN",
                align: "center"
            }
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "buyerId",
        title: "<spring:message code='inspectionReport.buyerId'/>",
        required: true,
        wrapTitle: false,
        autoFetchData: true,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "name",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create(inspectionReportTab.restDataSource.contactRest2),
        optionCriteria: inspectionReportTab.variable.buyerCriteria,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "nameFA",
                align: "center"
            },
            {
                name: "nameEN",
                align: "center"
            }
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "inspectionRateValue",
        title: "<spring:message code='inspectionReport.inspectionRateValue'/>",
        type: "float",
        length: 11,
        required: true,
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            },
            /*{
                type: "regexp",
                expression: "^(\d{1,10}(\.\d{1,5})?)$",
                validateOnChange: true,
            }*/
        ]
    },
    {
        name: "inspectionRateValueType",
        title: "<spring:message code='inspectionReport.inspectionRateValueType'/>",
        required: true,
        wrapTitle: false,
        valueMap: JSON.parse('${Enum_InspectionRateValueType}'),
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "unitId",
        title: "<spring:message code='global.unit'/>",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "name",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: inspectionReportTab.restDataSource.unitRest,
        optionCriteria: inspectionReportTab.variable.currencyInUnitCriteria,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "nameFA",
                align: "center"
            },
            {
                name: "nameEN",
                align: "center"
            },
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        type: "RowSpacerItem"
    },
    {
        name: "description",
        title: "<spring:message code='inspectionReport.description'/>",
        wrapTitle: false,
        editorType: "textArea",
        height: 150
    },
]);

inspectionReportTab.dynamicForm.inspecReport = isc.DynamicForm.create({
    height: "90%",
    numCols: 2,
    margin: 10,
    align: "center",
    titleWidth: 150,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: inspectionReportTab.dynamicForm.fields
});

inspectionReportTab.listGrid.weightElement = isc.ListGrid.create({
    width: "100%",
    height: "75%",
    sortField: 1,
    unitId: null,
    showRowNumbers: true,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    dataSource: inspectionReportTab.restDataSource.weightInspecRest,
    canEdit: true,
    editEvent: "doubleClick",
    autoSaveEdits: true,
    saveLocally: true,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    canRemoveRecords: true,
    fields: BaseFormItems.concat([
        {
            name: "id",
            hidden: true
        },
        {
            name: "inventoryId",
            type: "staticText",
            formatCellValue: function (value, record, rowNum, colNum, grid) {

                let selectedInventories = inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId").getSelectedRecords();
                if (record == null || value == null || !selectedInventories || !selectedInventories.length)
                    return;

                let inventory = selectedInventories.filter(q => q.id === value).first();
                if (inventory == null) return;

                return inventory.label;
            }
        },
        {
            name: "weighingType",
            required: true,
            valueMap: JSON.parse('${Enum_WeighingType}'),
            validators: [{
                type: "required",
                validateOnChange: true
            }]
        },
        {
            name: "weightGW",
            required: true,
            validators: [
                {
                    type: "isFloat",
                    validateOnChange: true
                },
                {
                    type: "required",
                    validateOnChange: true
                }],
            format: "0.###",
            formatCellValue: function (value, record, rowNum, colNum) {

                if (!value)
                    return value;

                return value + "";
            }
        },
        {
            name: "weightND",
            required: true,
            validators: [
                {
                    type: "isFloat",
                    validateOnChange: true
                },
                {
                    type: "required",
                    validateOnChange: true
                }],
            format: "0.###",
            formatCellValue: function (value, record, rowNum, colNum) {

                if (!value)
                    return value;

                return value + "";
            }
        }
    ]),
    dataChanged: function (operationType) {

        inspectionReportTab.method.setWeightElementSum();
        this.Super("dataChanged", arguments);
    }
});

inspectionReportTab.listGrid.weightElementSum = isc.ListGrid.create({
    width: "100%",
    height: "10%",
    showHeader: false,
    showEmptyMessage: false,
    fields: [{
        name: "title",
        canEdit: false,
        width: "25%",
        align: "center",
    }, {
        canEdit: false,
        name: "weighingType",
        width: "25%",
        align: "center",
        required: true,
        valueMap: JSON.parse('${Enum_WeighingType}'),
        validators: [{
            type: "required",
            validateOnChange: true
        }]

    }, {
        canEdit: false,
        name: "weightGW",
        width: "25%",
        align: "center",
        format: "0.###",
        formatCellValue: function (value, record, rowNum, colNum) {

            if (!value)
                return value;

            return value + "";
        }
    }, {
        canEdit: false,
        name: "weightND",
        width: "25%",
        align: "center",
        layoutMargin: 10,
        format: "0.###",
        formatCellValue: function (value, record, rowNum, colNum) {

            if (!value)
                return value;

            return value + "";
        }
    }],
    // editorExit(editCompletionEvent, record, newValue, rowNum, colNum) {
    //
    //     let savedRecordCount = inspectionReportTab.listGrid.weightElement.getData().length;
    //     let editRecordCount = inspectionReportTab.listGrid.weightElement.getAllEditRows().length;
    //     let recordCount = Math.max(editRecordCount, savedRecordCount);
    //     if (editCompletionEvent === "escape" || recordCount === 0) return true;
    //
    //     for (let i = 0; i < recordCount; i++)
    //         if (colNum === 1) {
    //
    //             inspectionReportTab.listGrid.weightElement.startEditing(i);
    //             inspectionReportTab.listGrid.weightElement.getAllEditRows().forEach(rn => inspectionReportTab.listGrid.weightElement.setEditValue(rn, colNum + 1, newValue));
    //             inspectionReportTab.listGrid.weightElement.endEditing();
    //         } else {
    //
    //             let avr = (parseFloat(newValue) / recordCount);
    //             inspectionReportTab.listGrid.weightElement.startEditing(i);
    //             inspectionReportTab.listGrid.weightElement.getAllEditRows().forEach(rn => inspectionReportTab.listGrid.weightElement.setEditValue(rn, colNum + 1, avr));
    //             inspectionReportTab.listGrid.weightElement.endEditing();
    //         }
    //
    //     return true;
    // }
});

inspectionReportTab.toolStrip.weightRemoveAll = isc.ToolStrip.create({
    width: "100%",
    border: '0px',
    members: [
        isc.ToolStripButton.create({
            // width: "100",
            height: "25",
            autoFit: false,
            title: "<spring:message code='global.remove.all'/>",
            click: function () {

                inspectionReportTab.variable.removeAllWeight = true;
                inspectionReportTab.listGrid.weightElement.setData([]);
                inspectionReportTab.listGrid.weightElementSum.setData([]);
            }
        }),
        isc.ToolStrip.create({
            border: '0px',
            width: "100%",
            members: [
                isc.DynamicForm.create({
                    width: "50%",
                    fields: [
                        {
                            name: "excelFile",
                            type: "file",
                            title: "<spring:message code='global.select.file'/>",
                        }
                    ]
                }),
                isc.ToolStripButton.create({
                    align: "right",
                    title: "<spring:message code='global.ok'/>",
                    click: function () {

                        let recordLimit = inspectionReportTab.listGrid.weightElement.getTotalRows();
                        let fileBrowserId = document.getElementById(inspectionReportTab.toolStrip.weightRemoveAll.members[1].members[0].getItem("excelFile").uploadItem.getElement().id);
                        let fieldNames = inspectionReportTab.listGrid.weightElement.getFields().slice(2, 5).map(q => q.name);

                        let formData = new FormData();
                        formData.append("file", fileBrowserId.files[0]);
                        formData.append("recordLimit", recordLimit);
                        formData.append("fieldNames", fieldNames);

                        let request = new XMLHttpRequest();
                        request.open("POST", "${contextPath}/inspectionReport/import-data");
                        request.setRequestHeader("contentType", "application/json; charset=utf-8");
                        request.setRequestHeader("Authorization", BaseRPCRequest.httpHeaders.Authorization);
                        request.send(formData);
                        request.onreadystatechange = function () {

                            if (request.readyState === XMLHttpRequest.DONE) {
                                if (request.status === 0)
                                    isc.warn("<spring:message code='dcc.upload.error.capacity'/>");
                                else if (request.status === 500)
                                    isc.warn("<spring:message code='dcc.upload.error.message'/>");
                                else if (request.status === 200 || request.status === 201) {
                                    isc.say("<spring:message code='dcc.upload.success.message'/>");
                                    let gridData = JSON.parse(request.response);
                                    for (let i = 0; i < gridData.length; i++) {

                                        inspectionReportTab.listGrid.weightElement.startEditing(i);
                                        gridData[i].inventoryId = inspectionReportTab.listGrid.weightElement.getEditValue(i, 1);
                                        inspectionReportTab.listGrid.weightElement.setEditValues(i, gridData[i]);
                                        inspectionReportTab.listGrid.weightElement.endEditing();
                                    }
                                }
                            }
                        };
                    }
                })]
        })
    ]
});

inspectionReportTab.hStack.weightUnitSum = isc.HStack.create({
    height: "10%",
    width: "100%",
    align: "right",
    overflow: "visible",
    canAdaptWidth: true,
    members: []
});

inspectionReportTab.vLayout.weightPane = isc.VLayout.create({
    autoDraw: true,
    members: [
        inspectionReportTab.listGrid.weightElement,
        inspectionReportTab.listGrid.weightElementSum,
        inspectionReportTab.toolStrip.weightRemoveAll,
        inspectionReportTab.hStack.weightUnitSum
    ]
});

inspectionReportTab.dynamicForm.assayLab = isc.DynamicForm.create({
    align: "center",
    numCols: 4,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: [
        {
            name: "labName",
            colSpan: 1,
            title: "<spring:message code='assayInspection.LabName'/>",
            required: true,
            wrapTitle: false,
            validators: [
                {
                    type: "required",
                    validateOnChange: true
                }]
        },
        {
            name: "labPlace",
            colSpan: 1,
            title: "<spring:message code='assayInspection.LabPlace'/>",
            required: true,
            wrapTitle: false,
            validators: [
                {
                    type: "required",
                    validateOnChange: true
                }]
        }
    ]
});

inspectionReportTab.listGrid.assayElement = isc.ListGrid.create({
    width: "100%",
    height: "90%",
    sortField: 1,
    showRowNumbers: true,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    canEdit: true,
    editEvent: "doubleClick",
    autoSaveEdits: true,
    saveLocally: true,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    canRemoveRecords: true,
    dataChanged: function (operationType) {

        inspectionReportTab.method.setAssayElementSum();
        this.Super("dataChanged", arguments);
    }
});

inspectionReportTab.listGrid.assayElementSum = isc.ListGrid.create({
    width: "100%",
    height: "10%",
    showHeader: false,
    dataSource: inspectionReportTab.restDataSource.assayInspecTotalValuesRest,
    showEmptyMessage: false,
    fields: [
        {
            name: "id",
            hidden: true
        },
        {
            "title": "<spring:message code='foreign-invoice.form.tab.subtotal'/>"
        }
    ]
});

inspectionReportTab.toolStrip.assayRemoveAll = isc.ToolStrip.create({
    width: "100%",
    border: '0px',
    members: [
        isc.ToolStripButton.create({
            // width: "100",
            height: "25",
            autoFit: false,
            title: "<spring:message code='global.remove.all'/>",
            click: function () {

                inspectionReportTab.variable.removeAllAssay = true;
                inspectionReportTab.listGrid.assayElement.setData([]);
                inspectionReportTab.listGrid.assayElementSum.setData([]);
            }
        }),
        isc.ToolStrip.create({
            border: '0px',
            width: "100%",
            members: [
                isc.DynamicForm.create({
                    width: "50%",
                    fields: [
                        {
                            name: "excelFile",
                            type: "file",
                            title: "<spring:message code='global.select.file'/>",
                        }
                    ]
                }),
                isc.ToolStripButton.create({
                    align: "right",
                    title: "<spring:message code='global.ok'/>",
                    click: function () {

                        let recordLimit = inspectionReportTab.listGrid.assayElement.getTotalRows();
                        let fileBrowserId = document.getElementById(inspectionReportTab.toolStrip.assayRemoveAll.members[1].members[0].getItem("excelFile").uploadItem.getElement().id);
                        let fieldNames = inspectionReportTab.listGrid.assayElement.getFields().slice(2, inspectionReportTab.listGrid.assayElement.getFields().length - 1).map(q => q.name);

                        let formData = new FormData();
                        formData.append("file", fileBrowserId.files[0]);
                        formData.append("recordLimit", recordLimit);
                        formData.append("fieldNames", fieldNames);

                        let request = new XMLHttpRequest();
                        request.open("POST", "${contextPath}/inspectionReport/import-data");
                        request.setRequestHeader("contentType", "application/json; charset=utf-8");
                        request.setRequestHeader("Authorization", BaseRPCRequest.httpHeaders.Authorization);
                        request.send(formData);
                        request.onreadystatechange = function () {

                            if (request.readyState === XMLHttpRequest.DONE) {
                                if (request.status === 0)
                                    isc.warn("<spring:message code='dcc.upload.error.capacity'/>");
                                else if (request.status === 500)
                                    isc.warn("<spring:message code='dcc.upload.error.message'/>");
                                else if (request.status === 200 || request.status === 201) {
                                    isc.say("<spring:message code='dcc.upload.success.message'/>");
                                    let gridData = JSON.parse(request.response);
                                    for (let i = 0; i < gridData.length; i++) {

                                        inspectionReportTab.listGrid.assayElement.startEditing(i);
                                        gridData[i].inventoryId = inspectionReportTab.listGrid.assayElement.getEditValue(i, 1);
                                        inspectionReportTab.listGrid.assayElement.setEditValues(i, gridData[i]);
                                        inspectionReportTab.listGrid.assayElement.endEditing();
                                    }
                                }
                            }
                        };
                    }
                })]
        })
    ]
});

inspectionReportTab.hStack.assayUnitSum = isc.HStack.create({
    height: "10%",
    width: "100%",
    align: "right",
    overflow: "visible",
    canAdaptWidth: true,
    members: []
});

inspectionReportTab.vLayout.assayPane = isc.VLayout.create({
    autoDraw: true,
    members: [
        inspectionReportTab.dynamicForm.assayLab,
        inspectionReportTab.listGrid.assayElement,
        inspectionReportTab.listGrid.assayElementSum,
        inspectionReportTab.toolStrip.assayRemoveAll,
        inspectionReportTab.hStack.assayUnitSum
    ]
});

inspectionReportTab.tab.inspecTabs = isc.TabSet.create({
    height: "90%",
    width: "100%",
    autoDraw: true,
    tabs: [
        {
            name: "weight",
            title: "<spring:message code='inspectionReport.weightInspection'/>",
            pane: inspectionReportTab.vLayout.weightPane
        },
        {
            name: "assay",
            title: "<spring:message code='inspectionReport.assayInspection'/>",
            pane: inspectionReportTab.vLayout.assayPane,
        }
    ]
});

//***************************************************** FUNCTIONS *************************************************

inspectionReportTab.method.clearForm = function () {

    inspectionReportTab.listGrid.assayElement.setData([]);
    inspectionReportTab.dynamicForm.material.clearValues();
    inspectionReportTab.dynamicForm.assayLab.clearValues();
    inspectionReportTab.listGrid.weightElement.setData([]);
    inspectionReportTab.listGrid.assayElement.setFields([]);
    inspectionReportTab.listGrid.assayElementSum.setData([]);
    inspectionReportTab.listGrid.weightElementSum.setData([]);
    inspectionReportTab.dynamicForm.inspecReport.clearValues();
    inspectionReportTab.listGrid.assayElementSum.setFields([]);
    inspectionReportTab.toolStrip.weightRemoveAll.members[1].members[0].getItem("excelFile").clearValue();
    inspectionReportTab.toolStrip.assayRemoveAll.members[1].members[0].getItem("excelFile").clearValue();
    inspectionReportTab.hStack.weightUnitSum.members.forEach(q => q.clearValues());
    inspectionReportTab.hStack.assayUnitSum.members.forEach(q => q.clearValues());
};

inspectionReportTab.window.inspecReport = new nicico.FormUtil();
inspectionReportTab.window.inspecReport.init(null, '<spring:message code="inspectionReport.title"/>', isc.HLayout.create({
    width: "100%",
    height: "650",
    align: "center",
    members: [
        isc.VLayout.create({
            width: "35%",
            members: [
                inspectionReportTab.dynamicForm.material,
                inspectionReportTab.dynamicForm.inspecReport,
            ]
        }),
        isc.VLayout.create({
            width: "65%",
            members: [
                inspectionReportTab.tab.inspecTabs,
            ]
        }),
    ]
}), "1300", "60%");

inspectionReportTab.window.inspecReport.populateData = function (bodyWidget) {

    let weightInspections = [];
    let assayInspectionRecord = [];
    let assayInspectionTotalValuesList = [];
    inspectionReportTab.listGrid.assayElement.endEditing();
    inspectionReportTab.listGrid.weightElement.endEditing();

    //------------- Save Inspection Data in Object -----------
    let inspectionReportObj = bodyWidget.members[0].members[1].getValues();

    //---------------- Save Weight Data in Object ------------
    bodyWidget.members[1].members[0].tabs[0].pane.members[0].selectAllRecords();
    bodyWidget.members[1].members[0].tabs[0].pane.members[0].getSelectedRecords().forEach(function (weightRecord, element) {

        let weightInspectionObj = {
            id: "",
            weighingType: "",
            weightGW: "",
            weightND: "",
            unitId: "",
            shipmentId: "",
            inventoryId: "",
            inspectionReportId: "",
            mileStone: ""
        };
        weightInspectionObj.id = weightRecord.id;
        weightInspectionObj.version = weightRecord.version;
        weightInspectionObj.weighingType = weightRecord.weighingType;
        weightInspectionObj.weightND = weightRecord.weightND;
        weightInspectionObj.weightGW = weightRecord.weightGW;
        weightInspectionObj.shipmentId = (inspectionReportObj.shipmentId !== undefined && inspectionReportObj.shipmentId.length) ? inspectionReportObj.shipmentId : null;
        weightInspectionObj.inventoryId = weightRecord.inventoryId;
        weightInspectionObj.unitId = bodyWidget.members[1].members[0].tabs[0].pane.members[0].unitId;
        weightInspectionObj.mileStone = inspectionReportObj.mileStone;
        weightInspections.push(weightInspectionObj);

    });
    inspectionReportObj.weightInspections = weightInspections;

    //---------------- Save Weight Sum in Object ------------
    bodyWidget.members[1].members[0].tabs[0].pane.members[1].members[0].selectAllRecords();
    let weightSum = bodyWidget.members[1].members[0].tabs[0].pane.members[1].members[0].getSelectedRecord(0);
    inspectionReportObj.weightGW = weightSum ? weightSum.weightGW : null;
    inspectionReportObj.weightND = weightSum ? weightSum.weightND : null;

    //--------------- Save Assay Data in Object --------------
    inspectionReportTab.variable.allCols = bodyWidget.members[1].members[0].tabs[1].pane.members[1].fields.length - 1;

    bodyWidget.members[1].members[0].tabs[1].pane.members[1].selectAllRecords();
    let records = bodyWidget.members[1].members[0].tabs[1].pane.members[1].getSelectedRecords();

    records.sortByProperty("inventoryId", true);
    records.forEach(function (assayRecord, index) {

        for (let i = 2; i < inspectionReportTab.variable.allCols; i++) {

            let assayInspectionObj = {};
            assayInspectionObj.labName = bodyWidget.members[1].members[0].tabs[1].pane.members[0].getItem("labName").getValue();
            assayInspectionObj.labPlace = bodyWidget.members[1].members[0].tabs[1].pane.members[0].getItem("labPlace").getValue();
            assayInspectionObj.id = bodyWidget.members[1].members[0].tabs[1].pane.members[1].getField(i).ids[index];
            assayInspectionObj.version = bodyWidget.members[1].members[0].tabs[1].pane.members[1].getField(i).versions[index];
            assayInspectionObj.value = NumberUtil.parseInt(bodyWidget.members[1].members[0].tabs[1].pane.members[1].getCellValue(assayRecord, index, i));
            assayInspectionObj.materialElementId = bodyWidget.members[1].members[0].tabs[1].pane.members[1].fields.get(i).meId;
            assayInspectionObj.shipmentId = (inspectionReportObj.shipmentId !== undefined && inspectionReportObj.shipmentId.length) ? inspectionReportObj.shipmentId : null;
            assayInspectionObj.inventoryId = assayRecord.inventoryId;
            assayInspectionObj.mileStone = inspectionReportObj.mileStone;

            assayInspectionRecord.push(assayInspectionObj);
        }
    });
    inspectionReportObj.assayInspections = assayInspectionRecord;

    //--------------- Save Assay Sum in Object --------------
    bodyWidget.members[1].members[0].tabs[1].pane.members[2].members[0].selectAllRecords();
    let assaySum = bodyWidget.members[1].members[0].tabs[1].pane.members[2].members[0].getSelectedRecords(0);

    if (assaySum[0]) {

        for (let i = 1; i < inspectionReportTab.variable.allCols - 1; i++) {

            let assayInspectionTotalValuesObj = {};
            assayInspectionTotalValuesObj.id = assaySum[0].id;
            assayInspectionTotalValuesObj.version = assaySum[0].version;
            assayInspectionTotalValuesObj.value = NumberUtil.parseInt(bodyWidget.members[1].members[0].tabs[1].pane.members[2].members[0].getCellValue(assaySum[0], 0, i));
            assayInspectionTotalValuesObj.materialElementId = bodyWidget.members[1].members[0].tabs[1].pane.members[1].fields.get(i + 1).meId;

            assayInspectionTotalValuesList.push(assayInspectionTotalValuesObj);
        }
        inspectionReportObj.assayInspectionTotalValuesList = assayInspectionTotalValuesList;
    }

    console.log("inspectionReportObj ", inspectionReportObj);
    return inspectionReportObj;
};

inspectionReportTab.method.refreshData = function () {
    inspectionReportTab.listGrid.main.invalidateCache();
};

inspectionReportTab.window.inspecReport.validate = function (data) {

    inspectionReportTab.dynamicForm.material.validate();
    if (inspectionReportTab.dynamicForm.material.hasErrors())
        return false;

    inspectionReportTab.dynamicForm.inspecReport.validate();
    if (inspectionReportTab.dynamicForm.inspecReport.hasErrors())
        return false;

    if (inspectionReportTab.variable.materialId !== ImportantIDs.material.COPPER_CATHOD) {

        if (inspectionReportTab.listGrid.assayElement.getData().length !== 0) {

            inspectionReportTab.dynamicForm.assayLab.validate();
            if (inspectionReportTab.dynamicForm.assayLab.hasErrors()) {

                inspectionReportTab.tab.inspecTabs.selectTab(inspectionReportTab.tab.inspecTabs.tabs.filter(q => q.name === "assay").first());
                return false;
            }
        }
    }

    if (inspectionReportTab.variable.removeAllWeight && inspectionReportTab.variable.removeAllAssay) {
        inspectionReportTab.dialog.say("<spring:message code='global.message.inspection.report.not.exist'/>");
        return false;
    }

    if (inspectionReportTab.listGrid.assayElement.getFields().length <= 2) {
        inspectionReportTab.dialog.say("<spring:message code='global.message.inspection.report.not.exist'/>");
        return false;
    }


    let isValid = inspectionReportTab.listGrid.weightElement.getData().length !== 0 || inspectionReportTab.listGrid.assayElement.getData().length !== 0;
    if (!isValid)
        inspectionReportTab.dialog.say("<spring:message code='global.message.inspection.report.not.exist'/>");

    return isValid;
};

inspectionReportTab.window.inspecReport.okCallBack = function (inspectionReportObj) {

    inspectionReportTab.method.jsonRPCManagerRequest({
        httpMethod: inspectionReportTab.variable.method,
        data: JSON.stringify(inspectionReportObj)
    }, (resp) => {
        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
            inspectionReportTab.method.refreshData();
            inspectionReportTab.dialog.ok();
        }
    });
};

inspectionReportTab.window.inspecReport.cancelCallBack = function () {
    inspectionReportTab.method.clearForm();
};

inspectionReportTab.method.newForm = function () {

    inspectionReportTab.variable.method = "POST";
    inspectionReportTab.method.clearForm();
    inspectionReportTab.dynamicForm.material.getItem("material").enable();
    inspectionReportTab.dynamicForm.inspecReport.getItem("select").enable();
    inspectionReportTab.dynamicForm.inspecReport.getItem("refresh").enable();
    inspectionReportTab.dynamicForm.inspecReport.getItem("mileStone").enable();
    inspectionReportTab.dynamicForm.inspecReport.getItem("shipmentId").enable();
    inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").enable();
    inspectionReportTab.window.inspecReport.justShowForm();
};

inspectionReportTab.method.editForm = function () {

    inspectionReportTab.variable.method = "PUT";
    let record = inspectionReportTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        inspectionReportTab.dialog.notSelected();
    else if (record.editable === false)
        inspectionReportTab.dialog.notEditable();
    else if (record.estatus.contains(Enums.eStatus2.DeActive))
        inspectionReportTab.dialog.inactiveRecord();
    else if (record.estatus.contains(Enums.eStatus2.Final))
        inspectionReportTab.dialog.finalRecord();
    else {

        inspectionReportTab.method.clearForm();
        inspectionReportTab.window.inspecReport.justShowForm();
        inspectionReportTab.dynamicForm.inspecReport.editRecord(record);

        let weightInspectionArray = record.weightInspections;
        let assayInspectionArray = record.assayInspections;

        let inventories = weightInspectionArray.map(q => q.inventory);
        inventories.addAll(assayInspectionArray.map(q => q.inventory));
        inventories = inventories.uniqueObject("id");
        inspectionReportTab.variable.selectedInventories = inventories;

        let materialId;
        let shipmentId;
        let mileStone;
        let labName = null;
        let labPlace = null;
        let inventoryIds = inventories.map(q => q.id);
        if (weightInspectionArray && weightInspectionArray.length) {

            // Set Material
            materialId = weightInspectionArray.get(0).inventory.materialItem.materialId;
            // Set Shipment
            shipmentId = weightInspectionArray.get(0).shipmentId;
            // Set Milestone
            mileStone = weightInspectionArray.get(0).mileStone;
        }
        if (assayInspectionArray && assayInspectionArray.length) {

            // Set Material
            materialId = assayInspectionArray.get(0).inventory.materialItem.materialId;
            // Set Shipment
            shipmentId = assayInspectionArray.get(0).shipmentId;
            // Set Milestone
            mileStone = assayInspectionArray.get(0).mileStone;
            // Set LabInfo
            labName = assayInspectionArray.get(0).labName;
            labPlace = assayInspectionArray.get(0).labPlace;
        }

        // Set Material
        inspectionReportTab.dynamicForm.material.setValue("material", materialId);
        // Set Shipment
        inspectionReportTab.dynamicForm.inspecReport.setValue("shipmentId", shipmentId);
        // Set Inventories
        inspectionReportTab.dynamicForm.inspecReport.setValue("inventoryId", inventoryIds);
        // Set IssueDate
        inspectionReportTab.dynamicForm.inspecReport.setValue("issueDate", new Date(record.issueDate));
        // Set Milestone
        inspectionReportTab.dynamicForm.inspecReport.setValue("mileStone", mileStone);
        // Set LabInfo
        inspectionReportTab.dynamicForm.assayLab.getField("labName").setValue(labName);
        inspectionReportTab.dynamicForm.assayLab.getField("labPlace").setValue(labPlace);

        inspectionReportTab.dynamicForm.material.getItem("material").disable();
        inspectionReportTab.dynamicForm.inspecReport.getItem("select").enable();
        inspectionReportTab.dynamicForm.inspecReport.getItem("select").disable();
        inspectionReportTab.dynamicForm.inspecReport.getItem("refresh").enable();
        inspectionReportTab.dynamicForm.inspecReport.getItem("mileStone").disable();
        inspectionReportTab.dynamicForm.inspecReport.getItem("shipmentId").disable();
        inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").disable();

        inspectionReportTab.method.materialChange();
        inspectionReportTab.method.getAssayElementFields(materialId, () => {

            let selectedWeightInventories = weightInspectionArray.map(q => q.inventoryId);
            inspectionReportTab.method.setWeightElementListRows(selectedWeightInventories);
            inspectionReportTab.method.setSavedWeightData(weightInspectionArray);
            inspectionReportTab.method.setWeightElementSum();

            let selectedAssayInventories = assayInspectionArray.map(q => q.inventoryId).distinct();
            inspectionReportTab.method.setAssayElementListRows(selectedAssayInventories);
            inspectionReportTab.method.setSavedAssayData(assayInspectionArray, selectedAssayInventories);
            inspectionReportTab.method.setAssayElementSum();
        });
    }
};

inspectionReportTab.dynamicForm.addShipmentDynamicForm = isc.DynamicForm.nicico.getDefault([{
    width: "100%",
    name: "shipmentId",
    required: true,
    title: "<spring:message code='Shipment.title'/>",
    autoFetchData: false,
    editorType: "SelectItem",
    valueField: "id",
    displayField: "bookingCat",
    pickListWidth: "500",
    pickListHeight: "300",
    optionDataSource: inspectionReportTab.restDataSource.shipmentRest,
    pickListProperties:
        {
            showFilterEditor: true
        },
    pickListFields: [
        {
            name: "bookingCat"
        },
        {
            name: "material.descEN",
        },
        {
            name: "contact.nameFA",
        },
        {
            name: "sendDate",
            type: "date"
        },
        {
            name: "shipmentType.shipmentType",
        },
        {
            name: "shipmentMethod.shipmentMethod",
        },
    ],
}]);

inspectionReportTab.window.formUtil = new nicico.FormUtil();
inspectionReportTab.window.formUtil.init(null, '<spring:message code="Shipment.title"/>', isc.HLayout.create({
    width: "100%",
    height: "110",
    align: "center",
    members: [
        inspectionReportTab.dynamicForm.addShipmentDynamicForm
    ]
}), "500", "20%");

inspectionReportTab.window.formUtil.populateData = function (bodyWidget) {

    inspectionReportTab.variable.addShipmentShipmentId = bodyWidget.members[0].getValue("shipmentId");
};

inspectionReportTab.window.formUtil.validate = function (data) {

    inspectionReportTab.dynamicForm.addShipmentDynamicForm.validate();
    return !inspectionReportTab.dynamicForm.addShipmentDynamicForm.hasErrors();
};

inspectionReportTab.window.formUtil.okCallBack = function (data) {

    let inventoryCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "remittanceDetails.remittance.shipmentId",
            operator: "equals",
            value: inspectionReportTab.variable.addShipmentShipmentId
        }]
    };

    inspectionReportTab.restDataSource.inventoryRest.fetchData(inventoryCriteria, function (invDsResponse, invData, invDsRequest) {

        if (invData.length) {

            let inventoryIds = [];
            let isValid = true;
            invData.forEach((current, index) => inventoryIds.add(current.remittanceDetails.filter(q => q.inputRemittance === false).first().inventory.id));

            inspectionReportTab.variable.addShipmentInventoryIds.forEach(q => {
                if (!inventoryIds.contains(q) && isValid) {
                    inspectionReportTab.dialog.say("All this inspection inventories not for this shipment");
                    isValid = false;
                }
            });

            if (isValid) {
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    httpMethod: "GET",
                    willHandleError: true,
                    actionURL: inspectionReportTab.variable.inspectionReportUrl + "set-shipment",
                    params: {
                        inspectionId: inspectionReportTab.variable.addShipmentRecordId,
                        shipmentId: inspectionReportTab.variable.addShipmentShipmentId
                    },
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            inspectionReportTab.method.refreshData();
                            inspectionReportTab.dialog.ok();
                        }
                    }
                }));
            }
        } else
            inspectionReportTab.dialog.say("not Out Inv for this Shipment");

    });
};

//***************************************************** MAINLISTGRID *************************************************

inspectionReportTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "inspectionNO",
        title: "<spring:message code='inspectionReport.InspectionNO'/>"
    },
    {
        name: "inspector.name",
        title: "<spring:message code='inspectionReport.inspector.name'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.inspector.name;
        }
    },
    {
        name: "inspectionPlace",
        title: "<spring:message code='inspectionReport.inspectionPlace'/>"
    },
    {
        name: "issueDate",
        title: "<spring:message code='inspectionReport.IssueDate'/>",
        type: "date",
        width: "10%"
    },
    {
        name: "seller.name",
        title: "<spring:message code='inspectionReport.seller.name'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.seller.name;
        }
    },
    {
        name: "buyer.name",
        title: "<spring:message code='inspectionReport.buyer.name'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.buyer.name;
        }
    },
    {
        name: "inspectionRateValue",
        title: "<spring:message code='inspectionReport.inspectionRateValue'/>"
    },
    {
        name: "inspectionRateValueType",
        title: "<spring:message code='inspectionReport.inspectionRateValueType'/>"
    },
    {
        name: "unit.name",
        title: "<spring:message code='global.unit'/>"
    }
]);
inspectionReportTab.listGrid.fields.filter(q => q.name === "estatus").first().hidden = false;


nicico.BasicFormUtil.getDefaultBasicForm(inspectionReportTab, "api/inspectionReport/");
nicico.BasicFormUtil.showAllToolStripActions(inspectionReportTab);
nicico.BasicFormUtil.removeExtraActions(inspectionReportTab, [nicico.ActionType.DELETE]);

inspectionReportTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    visibility: "visible",
    icon: "[SKIN]/actions/configure.png",
    title: "<spring:message code='global.add.shipment'/>",
    click: function () {

        inspectionReportTab.variable.method = "PUT";
        let record = inspectionReportTab.listGrid.main.getSelectedRecord();
        if (record == null || record.id == null)
            inspectionReportTab.dialog.notSelected();
        else if (record.editable === false)
            inspectionReportTab.dialog.notEditable();
        else if (record.estatus.contains(Enums.eStatus2.DeActive))
            inspectionReportTab.dialog.inactiveRecord();
        else if (record.estatus.contains(Enums.eStatus2.Final))
            inspectionReportTab.dialog.finalRecord();
        else {

            inspectionReportTab.dynamicForm.addShipmentDynamicForm.clearValues();
            inspectionReportTab.window.formUtil.justShowForm();

            let weightInspectionArray = record.weightInspections;
            let assayInspectionArray = record.assayInspections;

            let inventories = weightInspectionArray.map(q => q.inventory);
            inventories.addAll(assayInspectionArray.map(q => q.inventory));
            inventories = inventories.uniqueObject("id");

            let materialId;
            inspectionReportTab.variable.addShipmentRecordId = record.id;
            inspectionReportTab.variable.addShipmentInventoryIds = inventories.map(q => q.id);
            if (weightInspectionArray && weightInspectionArray.length) {

                // Set Material
                materialId = weightInspectionArray.get(0).inventory.materialItem.materialId;
            }
            if (assayInspectionArray && assayInspectionArray.length) {

                // Set Material
                materialId = assayInspectionArray.get(0).inventory.materialItem.materialId;
            }

            inspectionReportTab.dynamicForm.addShipmentDynamicForm.getItem("shipmentId").setOptionCriteria({
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{
                    fieldName: "materialId",
                    operator: "equals",
                    value: materialId
                }]
            });

        }
    }
}), 7);
