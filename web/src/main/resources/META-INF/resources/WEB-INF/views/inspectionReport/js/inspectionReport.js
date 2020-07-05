
//******************************************************* VARIABLES ****************************************************

var inspectionReportTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
inspectionReportTab.variable.materialId = 0;
inspectionReportTab.variable.data = [];
inspectionReportTab.variable.selectedInventoriesCounter = 0;
inspectionReportTab.variable.selectedInventoriesId = [];
inspectionReportTab.variable.selectedInventoriesLabel = [];

//***************************************************** RESTDATASOURCE *************************************************

var RestDataSource_InspecReportRest = isc.MyRestDataSource.create({
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

var RestDataSource_WeightInspecRest = isc.MyRestDataSource.create({
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
    ],
    fetchDataURL: "${contextPath}/api/weightInspection/spec-list"
});

var RestDataSource_AssayInspecRest = isc.MyRestDataSource.create({
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

var RestDataSource_ContactRest = isc.MyRestDataSource.create({
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
});

var RestDataSource_InventoryRest = isc.MyRestDataSource.create({
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

var RestDataSource_CurrencyRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "nameFa",
        },
        {
            name: "nameEn",
        },
        {
            name: "symbol",
        }
    ],
    fetchDataURL: "${contextPath}/api/currency/spec-list"
});

var RestDataSource_ContractRest = isc.MyRestDataSource.create({
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

var RestDataSource_MaterialRest = isc.MyRestDataSource.create({
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

var RestDataSource_MaterialElementRest = isc.MyRestDataSource.create({
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

inspectionReportTab.method.getAssayElementFields = function () {

    var elementCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "materialId", operator: "equals", value: inspectionReportTab.variable.materialId}]
    };

    RestDataSource_MaterialElementRest.fetchData(elementCriteria, function (dsResponse, data, dsRequest) {

        if (data.length != 0) {
            const fields = data.map(
                me => {
                    return {
                        name: me.element.name,
                        title: me.element.name,
                        id: me.id
                    }
                }
            );
            fields.add({
                name: "inventoryId",
                title: "<spring:message code='inspectionReport.InventoryId'/>",
                type: "staticText"
            });
            inspectionReportTab.listGrid.assayElement.setFields(fields);
        }
    });
};

var inspectorCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Inspector"}]
};

var sellerCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Seller"}]
};

var buyerCriteria = {
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
            autoFetchData: false,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "descp",
            pickListWidth: "500",
            pickListHeight: "300",
            optionDataSource: RestDataSource_MaterialRest,
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
                inspectionReportTab.method.getAssayElementFields();
                // inspectionReportTab.method.getWeightElementFields();
                var material = form.getItem("material").getSelectedRecord().id;
                inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").setOptionCriteria({
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "materialItem.materialId", operator: "equals", value: material}]
                });
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
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: RestDataSource_ContactRest,
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
        type: "text"
    },
    {
        name: "issueDate",
        title: "<spring:message code='inspectionReport.IssueDate'/>",
        type: "date"
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
        optionDataSource: RestDataSource_InventoryRest,
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
        changed: function (form) {
            inspectionReportTab.variable.selectedInventoriesCounter = form.getItem("inventoryId").getSelectedRecords().length;
            inspectionReportTab.variable.selectedInventoriesId = form.getItem("inventoryId").getValue();
            inspectionReportTab.variable.selectedInventoriesLabel = form.getItem("inventoryId").getSelectedRecord().label;
            inspectionReportTab.method.setListRows();
        },
        click: function () {
        }
    },
    {
        name: "sellerId",
        title: "<spring:message code='inspectionReport.sellerId'/>",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: RestDataSource_ContactRest,
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
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: RestDataSource_ContactRest,
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
    },
    {
        name: "inspectionRateValueType",
        title: "<spring:message code='inspectionReport.inspectionRateValueType'/>",
        required: true,
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
        optionDataSource: RestDataSource_CurrencyRest,
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
    // sortDirection: "ascending",
    dataSource: RestDataSource_WeightInspecRest,
    canEdit: true,
    editEvent: "doubleClick",
    autoSaveEdits: false,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    canRemoveRecords: true,
    fields: BaseFormItems.concat([
        {
            name: "inventoryId",
            type: "staticText"
        },
        {
            name: "weighingType.id",
            required: true,
            valueMap: {
                0: "DraftSurvey",
                1: "WeighBridge"
            }
        },
        {
            name: "weightGW",
            required: true
        },
        {
            name: "weightND",
            required: true
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
            type: "RowSpacerItem"
        },
        {
            name: "labName",
            title: "<spring:message code='assayInspection.LabName'/>"
        },
        {
            name: "labPlace",
            title: "<spring:message code='assayInspection.LabPlace'/>"
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
    // sortDirection: "ascending",
    canEdit: true,
    editEvent: "doubleClick",
    autoSaveEdits: false,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    canRemoveRecords: true
});

var WeightPane = isc.VLayout.create({
    autoDraw: true,
    members: [
        inspectionReportTab.listGrid.weightElement
    ]
});

var assayPane = isc.VLayout.create({
    autoDraw: true,
    members: [
        inspectionReportTab.dynamicForm.assayLab,
        inspectionReportTab.listGrid.assayElement
    ]
});

var inspecTabs = isc.TabSet.create({
    height: "100%",
    width: "100%",
    autoDraw: true,
    tabs: [
        {
            name: "weight",
            title: "<spring:message code='inspectionReport.weightInspection'/>",
            pane: WeightPane
        },
        {
            name: "assay",
            title: "<spring:message code='inspectionReport.assayInspection'/>",
            pane: assayPane,
            // disabled: true,
        }
    ]
});

//***************************************************** METHODS *************************************************

var inspectionReportObj = {
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

var weightInspections = [];

var weightInspectionObj = {
    weighingType: "",
    weightGW: "",
    weightND: "",
    inspectionReportId: "",
    inventoryId: ""
};

var assayInspections = [];

var assayInspectionRecord = [];

var assayInspectionObj = {
    value: "",
    inspectionReportId: "",
    materialElementId: "",
    labName: "",
    labPlace: "",
    inventoryId: "",
};

inspectionReportTab.method.setListRows = function () {

    inspectionReportTab.variable.selectedInventoriesId.forEach(function () {
        inspectionReportTab.listGrid.assayElement.startEditingNew();
        inspectionReportTab.listGrid.weightElement.startEditingNew();
    });

    inspectionReportTab.listGrid.assayElement.getAllEditRows().forEach(function (element) {
        var record = inspectionReportTab.listGrid.assayElement.getEditedRecord(JSON.parse(JSON.stringify(element)));
        // alert(inspectionReportTab.variable.selectedInventoriesLabel.get(element))
        inspectionReportTab.listGrid.assayElement.setEditValue(element, 3, inspectionReportTab.variable.selectedInventoriesId.get(element));
    });

    inspectionReportTab.listGrid.weightElement.getAllEditRows().forEach(function (element) {
        var record = inspectionReportTab.listGrid.weightElement.getEditedRecord(JSON.parse(JSON.stringify(element)));
        // alert(inspectionReportTab.variable.selectedInventoriesLabel.get(element))
        inspectionReportTab.listGrid.weightElement.setEditValue(element, 1, inspectionReportTab.variable.selectedInventoriesId.get(element));
    });

};

inspectionReportTab.window.inspecReport = new nicico.FormUtil();
inspectionReportTab.window.inspecReport.init(null, '<spring:message code="inspectionReport.title"/>', isc.VLayout.create({
    width: "100%",
    height: "500",
    align: "center",
    members: [
        inspectionReportTab.dynamicForm.material,
        inspectionReportTab.dynamicForm.inspecReport,
        inspecTabs
    ]
}), "800", "60%");

inspectionReportTab.window.inspecReport.populateData = function (bodyWidget) {
    weightInspections = [];
    assayInspections = [];
    //----------------------- Validation ---------------------

    // inspectionReportTab.window.inspecReport.validate();

    //------------- Save Inspection Data in Object -----------

    inspectionReportObj = bodyWidget.members.get(1).getValues();

    //---------------- Save Weight Data in Object ------------

    bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).getAllEditRows().forEach(function (element) {
        var record = bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).getEditedRecord(JSON.parse(JSON.stringify(element)));
        weightInspectionObj.weighingType = record.weighingType.id;
        weightInspectionObj.weightND = record.weightND;
        weightInspectionObj.weightGW = record.weightGW;
        weightInspectionObj.inventoryId = record.inventoryId;
        weightInspections.push(weightInspectionObj);
        // alert(JSON.stringify(weightInspections));
    });
    inspectionReportObj.weightInspections = weightInspections;

    //--------------- Save Assay Data in Object --------------

    assayInspectionObj.labName = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("labName").getValue();
    assayInspectionObj.labPlace = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("labPlace").getValue();
    var allCols = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).fields.length;
    var fieldCols = allCols-3;
    bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getAllEditRows().forEach(function (element) {
        assayInspectionRecord =[];
        var assayRecord = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getEditedRecord(JSON.parse(JSON.stringify(element)));
        assayInspectionObj.inventoryId = assayRecord.inventoryId;
        for (let i = 1; i <= fieldCols ; i++) {
            assayInspectionObj. value = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getEditedCell(JSON.parse(JSON.stringify(element)), i);
            assayInspectionObj. materialElementId = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).fields.get(i).id;
            assayInspectionRecord.push(assayInspectionObj);
        }
    assayInspections.push(assayInspectionRecord);
    });
    inspectionReportObj.assayInspections = assayInspections;

};

/*inspectionReportTab.window.inspecReport.validate = function () {
    inspectionReportTab.dynamicForm.material.validate();
    if (inspectionReportTab.dynamicForm.material.hasErrors())
        return;

    inspectionReportTab.dynamicForm.inspecReport.validate();
    if (inspectionReportTab.dynamicForm.inspecReport.hasErrors())
        return;
};*/

inspectionReportTab.window.inspecReport.okCallBack = function () {

    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/inspectionReport/inspection",
            httpMethod: "POST",
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
};

inspectionReportTab.method.refreshData = function () {
    inspectionReportTab.listGrid.main.invalidateCache();
};

inspectionReportTab.method.newForm = function () {
    inspectionReportTab.window.inspecReport.justShowForm();
};

inspectionReportTab.method.editForm = function () {

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

                var data = JSON.parse(response.httpResponseText).response.data;
                // alert(JSON.stringify(data));
                inspectionReportTab.window.inspecReport.justShowForm();
                inspectionReportTab.dynamicForm.inspecReport.editRecord(record);
                // inspectionReportTab.dynamicForm.material.getField("material").setValue(response.materialId);
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