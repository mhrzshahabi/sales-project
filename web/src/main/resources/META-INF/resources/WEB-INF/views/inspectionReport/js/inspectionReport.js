//******************************************************* VARIABLES ****************************************************

var inspectionReportTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
inspectionReportTab.variable.materialId = 0;
inspectionReportTab.variable.data = [];

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
            name: "inspector.nameFA",
            title: "<spring:message code='inspectionReport.inspector.nameFA'/>"
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
            name: "seller.nameFA",
            title: "<spring:message code='inspectionReport.seller.nameFA'/>"
        },
        {
            name: "sellerId",
            title: "<spring:message code='inspectionReport.sellerId'/>"
        },
        {
            name: "buyer.nameFA",
            title: "<spring:message code='inspectionReport.buyer.nameFA'/>"
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
            name: "currencyId",
            title: "<spring:message code='inspectionReport.currencyId'/>"
        },
        {
            name: "currency.nameFa",
            title: "<spring:message code='inspectionReport.currencyId'/>"
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
            name: "weighingType.id",
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
        },
        {
            name: "unitId",
            title: "<spring:message code='global.unit'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/assayInspection/spec-list"
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

inspectionReportTab.restDataSource.inventoryRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "materialItem.material.descp",
        },
        {
            name: "materialItem.materialId",
        },
        {
            name: "label",
        }
    ],
    fetchDataURL: "${contextPath}/api/inventory/spec-list"
});

inspectionReportTab.restDataSource.currencyRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "nameFa",
            title: "<spring:message code='currency.nameFa'/>"
        },
        {
            name: "nameEn",
            title: "<spring:message code='currency.nameLatin'/>"
        },
        {
            name: "symbol",
            title: "<spring:message code='currency.symbol'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/currency/spec-list"
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
            name: "contractNo",
            title: "<spring:message code='contract.contractNo'/>"
        },
        {
            name: "contractDate",
            title: "<spring:message code='contract.contractDate'/>"
        },
        {
            name: "contactInspectionId",
            title: "<spring:message code='contact.nameFa'/>"
        },
        {
            name: "material.descp",
            title: "<spring:message code='material.descp'/>"
        },
        {
            name: "materialId",
            title: "<spring:message code='material.descp'/>",
            hidden: true
        },
    ],
    fetchDataURL: "${contextPath}/api/contract/spec-list"
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
            name: "descp",
            title: "<spring:message code='material.descp'/>"
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
            name: "material.descp",
            title: "<spring:message code='material.descp'/>"
        },
        {
            name: "materialId",
            title: "<spring:message code='material.descp'/>"
        },
        {
            name: "element.name",
            title: "<spring:message code='assayInspection.materialElement.name'/>"
        },
        {
            name: "element.payable",
            title: "<spring:message code='assayInspection.materialElement.payable'/>"
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

inspectionReportTab.method.getAssayElementFields = function (materialId) {

    let elementCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "materialId", operator: "equals", value: materialId}]
    };

    inspectionReportTab.restDataSource.materialElementRest.fetchData(elementCriteria, function (dsResponse, data, dsRequest) {

        if (data.length != 0) {

            let fields = [{
                name: "inventoryId",
                title: "<spring:message code='inspectionReport.InventoryId'/>",
                type: "staticText",
                formatCellValue: function (value, record, rowNum, colNum, grid) {

                    let selectedInventories = inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId").getSelectedRecords();
                    if (record == null || value == null || selectedInventories.length === 0)
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
                        title: me.element.name,
                        id: me.id,
                        required: true,
                        validators: [
                            {
                                type: "isFloat",
                                validateOnChange: true
                            },
                            {
                                type: "required",
                                validateOnChange: true
                            }]
                    }
                }
            ));

            inspectionReportTab.listGrid.assayElement.setFields(fields);
        }
    });
};

inspectionReportTab.method.setInventoryCriteria = function (materialId) {
    inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").setOptionCriteria({
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "materialItem.materialId",
            operator: "equals",
            value: materialId
        }]
    });
};

let inspectorCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Inspector"}]
};

let sellerCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Seller"}]
};

let buyerCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Buyer"}]
};

//*************************************************** FORM STRUCTURE ************************************************

inspectionReportTab.dynamicForm.material = isc.DynamicForm.create({
    width: "50%",
    // height: "100%",
    align: "center",
    numCols: 2,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: [
        {
            name: "material",
            title: "<spring:message code='material.descp'/>",
            required: true,
            wrapTitle: false,
            autoFetchData: false,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "descp",
            pickListWidth: "500",
            pickListHeight: "300",
            optionDataSource: inspectionReportTab.restDataSource.materialRest,
            pickListProperties:
                {
                    showFilterEditor: true
                },
            pickListFields: [
                {
                    name: "descp",
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
            changed: function (form) {
                inspectionReportTab.variable.materialId = form.getItem("material").getSelectedRecord().id;
                inspectionReportTab.method.getAssayElementFields(inspectionReportTab.variable.materialId);
                inspectionReportTab.method.setInventoryCriteria(inspectionReportTab.variable.materialId);
            },
            // editorExit: function (form) {
            //
            // }

        },
        {
            type: "RowSpacerItem"
        }
    ]
});

inspectionReportTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "id",
        hidden: true
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
        title: "<spring:message code='inspectionReport.inspector.nameFA'/>",
        required: true,
        wrapTitle: false,
        autoFetchData: true,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create(inspectionReportTab.restDataSource.contactRest),
        optionCriteria: inspectorCriteria,
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
        name: "inspectionPlace",
        title: "<spring:message code='inspectionReport.inspectionPlace'/>",
        type: "text",
        wrapTitle: false
    },
    {
        name: "issueDate",
        title: "<spring:message code='inspectionReport.IssueDate'/>",
        type: "date",
        wrapTitle: false
    },
    {
        name: "inventoryId",
        title: "<spring:message code='inspectionReport.InventoryId'/>",
        colSpan: 2,
        required: true,
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
                name: "materialItem.materialId",
                align: "center",
                hidden: true
            },
            {
                name: "materialItem.material.descp",
                align: "center",
            },
            {
                name: "label",
                align: "center",
            }
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        blur: function (form, item) {

            let selectedInventories = item.getSelectedRecords();
            if (selectedInventories == null) selectedInventories = [];
            inspectionReportTab.method.setWeightElementListRows(selectedInventories);
            inspectionReportTab.method.setAssayElementListRows(selectedInventories);
        },
        click: function () {
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
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create(inspectionReportTab.restDataSource.contactRest1),
        optionCriteria: sellerCriteria,
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
        name: "buyerId",
        title: "<spring:message code='inspectionReport.buyerId'/>",
        required: true,
        wrapTitle: false,
        autoFetchData: true,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create(inspectionReportTab.restDataSource.contactRest2),
        optionCriteria: buyerCriteria,
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
        name: "inspectionRateValue",
        title: "<spring:message code='inspectionReport.inspectionRateValue'/>",
        wrapTitle: false,
    },
    {
        name: "inspectionRateValueType",
        title: "<spring:message code='inspectionReport.inspectionRateValueType'/>",
        required: true,
        wrapTitle: false,
        valueMap: {
            0: "ManPerDay",
            1: "PerTon"
        },
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "currencyId",
        title: "<spring:message code='inspectionReport.currencyId'/>",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFa",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: inspectionReportTab.restDataSource.currencyRest,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "nameFa",
                align: "center"
            },
            {
                name: "nameEn",
                align: "center"
            },
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
]);

inspectionReportTab.dynamicForm.inspecReport = isc.DynamicForm.create({
    width: "50%",
    // height: "100%",
    align: "center",
    numCols: 4,
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: inspectionReportTab.dynamicForm.fields
});

inspectionReportTab.listGrid.weightElement = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    sortField: 1,
    showRowNumbers: true,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    dataSource: inspectionReportTab.restDataSource.weightInspecRest,
    canEdit: true,
    editEvent: "click",
    autoSaveEdits: true,
    saveLocally: true,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    canRemoveRecords: false,
    fields: BaseFormItems.concat([
        {
            name: "inventoryId",
            type: "staticText",
            formatCellValue: function (value, record, rowNum, colNum, grid) {

                let selectedInventories = inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId").getSelectedRecords();
                if (record == null || value == null || selectedInventories.length === 0)
                    return;

                let inventory = selectedInventories.filter(q => q.id === value).first();
                if (inventory == null) return;

                return inventory.label;
            }
        },
        {
            name: "weighingType.id",
            required: true,
            valueMap: {
                0: "DraftSurvey",
                1: "WeighBridge"
            },
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
                }]
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
                }]
        },
        {
            name: "unitId",
            type: "staticText",
            /*formatCellValue: function (value, record, rowNum, colNum, grid) {

                inspectionReportTab.restDataSource.unitRest.fetchData({
                    _constructor:'AdvancedCriteria',
                    operator:"and",
                    criteria:[{fieldName: "id", operator: "equals", value: record.unitId}]}, function (dsResponse, data, dsRequest) {
                    return data.nameEN;
                });
            }*/
        }
    ])
});

inspectionReportTab.dynamicForm.assayLab = isc.DynamicForm.create({
    width: "50%",
    // height: "100%",
    align: "center",
    numCols: 2,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: [
        {
            name: "labName",
            title: "<spring:message code='assayInspection.LabName'/>",
            required: true,
            wrapTitle: false
        },
        {
            name: "labPlace",
            title: "<spring:message code='assayInspection.LabPlace'/>",
            required: true,
            wrapTitle: false
        }
    ]
});

inspectionReportTab.listGrid.assayElement = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    sortField: 1,
    showRowNumbers: true,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    canEdit: true,
    editEvent: "click",
    autoSaveEdits: true,
    saveLocally: true,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    canRemoveRecords: false
});

inspectionReportTab.vLayout.weightPane = isc.VLayout.create({
    autoDraw: true,
    members: [
        inspectionReportTab.listGrid.weightElement
    ]
});

inspectionReportTab.vLayout.assayPane = isc.VLayout.create({
    autoDraw: true,
    members: [
        inspectionReportTab.dynamicForm.assayLab,
        inspectionReportTab.listGrid.assayElement
    ]
});

inspectionReportTab.tab.inspecTabs = isc.TabSet.create({
    height: "100%",
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
            // disabled: true,
        }
    ]
});

//***************************************************** METHODS *************************************************

inspectionReportTab.method.setWeightElementListRows = function (selectedInventories) {

    if (inspectionReportTab.listGrid.weightElement.getData().length) {

        inspectionReportTab.dialog.question(() => {

            inspectionReportTab.listGrid.weightElement.setData([]);
            if (selectedInventories.length === 0)
                return;

            let unitId = inspectionReportTab.method.setWeightunit(inspectionReportTab.variable.materialId);
            selectedInventories.forEach((current, index, array) => inspectionReportTab.listGrid.weightElement.startEditingNew({inventoryId: current.id, unitId: unitId}));
        }, '<spring:message code="global.question.remove.data.weight.continue"/>');
    } else {

        inspectionReportTab.listGrid.weightElement.setData([]);
        if (selectedInventories.length === 0)
            return;

        let unitId = inspectionReportTab.method.setWeightunit(inspectionReportTab.variable.materialId);
        selectedInventories.forEach((current, index, array) => inspectionReportTab.listGrid.weightElement.startEditingNew({inventoryId: current.id, unitId: unitId}));
    }
};

inspectionReportTab.method.setAssayElementListRows = function (selectedInventories) {

    if (inspectionReportTab.listGrid.assayElement.getData().length) {

        inspectionReportTab.dialog.question(() => {

            inspectionReportTab.listGrid.assayElement.setData([]);
            if (selectedInventories.length === 0)
                return;

            selectedInventories.forEach((current, index, array) => inspectionReportTab.listGrid.assayElement.startEditingNew({inventoryId: current.id}));
        }, '<spring:message code="global.question.remove.data.assay.continue"/>');
    } else {

        inspectionReportTab.listGrid.assayElement.setData([]);
        if (selectedInventories.length === 0)
            return;

        selectedInventories.forEach((current, index, array) => inspectionReportTab.listGrid.assayElement.startEditingNew({inventoryId: current.id}));
    }
};

inspectionReportTab.method.setWeightunit = function (materialId) {
    switch (materialId) {
        case 1:
            return 11;
        case 2:
            return -1;
        case 3:
            return 1;
    }
};

inspectionReportTab.method.groupByAssays = function (array, groupFieldName) {

    if (groupFieldName == null || array == null || array.length == 0) return {};
    array.reduce(function (group, current) {
        var groupData = eval("current." + groupFieldName);
        (group[groupData] = group[groupData] || []).push(current);
        return group;
    }, {});
};

inspectionReportTab.method.listAssays = function () {
};

inspectionReportTab.window.inspecReport = new nicico.FormUtil();
inspectionReportTab.window.inspecReport.init(null, '<spring:message code="inspectionReport.title"/>', isc.VLayout.create({
    width: "100%",
    height: "500",
    align: "center",
    members: [
        inspectionReportTab.dynamicForm.material,
        inspectionReportTab.dynamicForm.inspecReport,
        inspectionReportTab.tab.inspecTabs
    ]
}), "800", "60%");

let inspectionReportObj = {
    inspectionNO: "",
    inspectorId: "",
    inspectionPlace: "",
    issueDate: "",
    sellerId: "",
    buyerId: "",
    inspectionRateValue: "",
    inspectionRateValueType: "",
    currencyId: "",
    weightInspections: [],
    assayInspections: []
};

inspectionReportTab.window.inspecReport.populateData = function (bodyWidget) {

    let weightInspections = [];

    let assayInspections = [];

    let assayInspectionRecord = [];


    //------------- Save Inspection Data in Object -----------

    inspectionReportObj = bodyWidget.members.get(1).getValues();

    //---------------- Save Weight Data in Object ------------
    let record;
    bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).getAllEditRows().forEach(function (element) {

        let weightInspectionObj = {
            weighingType: "",
            weightGW: "",
            weightND: "",
            inspectionReportId: "",
            inventoryId: "",
            unitId: ""
        };

        record = bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).getEditedRecord(element);
        weightInspectionObj.weighingType = record.weighingType.id;
        weightInspectionObj.weightND = record.weightND;
        weightInspectionObj.weightGW = record.weightGW;
        weightInspectionObj.inventoryId = record.inventoryId;
        weightInspectionObj.unitId = record.unitId;
        weightInspections.push(weightInspectionObj);
    });
    inspectionReportObj.weightInspections = weightInspections;

    //--------------- Save Assay Data in Object --------------

    let allCols = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).fields.length;
    bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getAllEditRows().forEach(function (element) {
        assayInspectionRecord = [];
        let assayRecord = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getEditedRecord(element);

        for (let i = 2; i < allCols - 1; i++) {
            let assayInspectionObj = {
                value: "",
                inspectionReportId: "",
                materialElementId: "",
                labName: "",
                labPlace: "",
                inventoryId: "",
                unitId: ""
            };

            assayInspectionObj.labName = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("labName").getValue();
            assayInspectionObj.labPlace = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("labPlace").getValue();
            assayInspectionObj.value = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getEditedCell(JSON.parse(JSON.stringify(element)), i);
            assayInspectionObj.materialElementId = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).fields.get(i).id;
            assayInspectionObj.inventoryId = assayRecord.inventoryId;
            assayInspectionRecord.push(assayInspectionObj);
        }
        assayInspections.push(assayInspectionRecord);
    });
    inspectionReportObj.assayInspections = assayInspections;
};

inspectionReportTab.window.inspecReport.validate = function () {

    inspectionReportTab.dynamicForm.material.validate();
    if (inspectionReportTab.dynamicForm.material.hasErrors())
        return false;

    inspectionReportTab.dynamicForm.inspecReport.validate();
    if (inspectionReportTab.dynamicForm.inspecReport.hasErrors())
        return false;

    inspectionReportTab.dynamicForm.assayLab.validate();
    if (inspectionReportTab.dynamicForm.assayLab.hasErrors())
        return false;

    let selectedInventories = inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId").getSelectedRecords();
    if (selectedInventories == null)
        return false;

    for (let i = 0; i < selectedInventories.length; i++) {
        inspectionReportTab.listGrid.weightElement.validateRow(i);
        if (inspectionReportTab.listGrid.weightElement.hasErrors())
            return false;
        inspectionReportTab.listGrid.assayElement.validateRow(i);
        if (inspectionReportTab.listGrid.assayElement.hasErrors())
            return false;
    }

    return true;
};

inspectionReportTab.window.inspecReport.okCallBack = function () {

    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/inspectionReport/inspection",
            httpMethod: inspectionReportTab.variable.method,
            data: JSON.stringify(inspectionReportObj),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    inspectionReportTab.method.refreshData();
                    inspectionReportTab.window.inspecReport.close();
                } else
                    isc.say(RpcResponse_o.data);
            }
        })
    );

};

inspectionReportTab.window.inspecReport.cancelCallBack = function () {
    inspectionReportTab.dynamicForm.material.clearValues();
    inspectionReportTab.dynamicForm.inspecReport.clearValues();
    inspectionReportTab.dynamicForm.assayLab.clearValues();
    inspectionReportTab.listGrid.weightElement.setData([]);
    inspectionReportTab.listGrid.assayElement.setData([]);
};

inspectionReportTab.method.refreshData = function () {
    inspectionReportTab.listGrid.main.invalidateCache();
};

inspectionReportTab.method.newForm = function () {
    inspectionReportTab.variable.method = "POST";
    inspectionReportTab.window.inspecReport.justShowForm();
};

inspectionReportTab.method.editForm = function () {

    let inventories = [];
    let record = inspectionReportTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        inspectionReportTab.dialog.notSelected();
    else if (record.editable === false)
        inspectionReportTab.dialog.notEditable();
    else {
        inspectionReportTab.method.jsonRPCManagerRequest({
            httpMethod: "GET",
            actionURL: "${contextPath}/api/inspectionReport/spec-list",
            params: {
                criteria: {
                    operator: "and",
                    criteria: [
                        {fieldName: "id", operator: "equals", value: record.id}
                    ]
                }
            },
            callback: function (response) {

                inspectionReportTab.window.inspecReport.justShowForm();
                inspectionReportTab.dynamicForm.inspecReport.editRecord(record);

                let weightInspecArray = record.weightInspections;
                let assayInspecArray = record.assayInspections;
                // inspectionReportTab.method.groupByAssays(assayInspecArray, "inventoryId", "materialElementId", "value");

                /*const dataForContentGrid=[];
                assayInspecArray.forEach(aia=>{
                    let id = dataForContentGrid[aia.inventoryId];
                    let idFound = false;
                    if(!id){
                        id = {}
                    }
                    id[aia.materialElement.element.name]=aia.value;
                    id["inventoryId"]=aia.inventoryId;
                    if(!idFound)
                        dataForContentGrid.add(id);

                });
                console.log(Objec)*/

                // alert(JSON.stringify(assayInspecArray);

                // Set Material
                let materialId = weightInspecArray.get(0).inventory.materialItem.materialId;
                inspectionReportTab.dynamicForm.material.setValue("material", materialId);
                inspectionReportTab.method.getAssayElementFields(materialId);
                // inspectionReportTab.method.setInventoryCriteria(materialId);

                // Set Inventories
                weightInspecArray.forEach((current, index, array) => inventories.add(current.inventory.id));
                inspectionReportTab.dynamicForm.inspecReport.setValue("inventoryId", inventories);

                // Set LabInfo
                inspectionReportTab.dynamicForm.assayLab.getField("labName").setValue(assayInspecArray.get(0).labName);
                inspectionReportTab.dynamicForm.assayLab.getField("labPlace").setValue(assayInspecArray.get(0).labPlace);

                // ListGrid and Data
                inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId").showPicker();
                setTimeout(() => {
                    inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId").pickList.hide();
                    // inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").blur(inspectionReportTab.dynamicForm.inspecReport, inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId"));
                    inspectionReportTab.tab.inspecTabs.focus();
                }, 500);
                setTimeout(() => {
                    inspectionReportTab.listGrid.weightElement.setData(weightInspecArray);
                }, 500);
            }
        });

        inspectionReportTab.variable.method = "PUT";
    }
};

//***************************************************** LISTGRID *************************************************

inspectionReportTab.listGrid.fields = [
    {
        name: "id",
        hidden: true
    },
    {
        name: "inspectionNO",
        title: "<spring:message code='inspectionReport.InspectionNO'/>"
    },
    {
        name: "inspector.nameFA",
        title: "<spring:message code='inspectionReport.inspector.nameFA'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.inspector.nameFA;
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
        name: "seller.nameFA",
        title: "<spring:message code='inspectionReport.seller.nameFA'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.seller.nameFA;
        }
    },
    {
        name: "buyer.nameFA",
        title: "<spring:message code='inspectionReport.buyer.nameFA'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.buyer.nameFA;
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
        name: "currency.nameFa",
        title: "<spring:message code='inspectionReport.currencyId'/>"
    }
];

nicico.BasicFormUtil.getDefaultBasicForm(inspectionReportTab, "api/inspectionReport/");