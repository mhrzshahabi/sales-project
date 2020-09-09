//******************************************************* VARIABLES ****************************************************

var inspectionReportTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
inspectionReportTab.variable.materialId = 0;
inspectionReportTab.variable.data = [];
inspectionReportTab.variable.allME = "";
inspectionReportTab.variable.allCols = 0;

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
            name: "description",
            title: "<spring:message code='inspectionReport.inspectionRateValueType'/>"
        },
        {
            name: "unitId",
            title: "<spring:message code='global.unit'/>"
        },
        {
            name: "unit.nameFA",
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
            name: "materialItem.gdsName",
            title: "<spring:message code='MaterialItem.gdsName'/>"
        },
        {
            name: "materialItem.materialId",
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
        },
        {
            name: "unitId",
            title: "<spring:message code='global.unit'/>"
        },
        {
            name: "unit.nameFA",
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
            name: "material.descl",
            title: "<spring:message code ='material.descl'/>",
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
    ],
    fetchDataURL: "${contextPath}/api/shipment/spec-list"
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

inspectionReportTab.method.getAssayElementFields = function (materialId) {

    let elementCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "materialId", operator: "equals", value: materialId}]
    };

    inspectionReportTab.restDataSource.materialElementRest.fetchData(elementCriteria, function (dsResponse, data, dsRequest) {

        if (data.length !== 0) {

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
                        title: me.element.name + " (" + me.unit.nameEN + ")",
                        ids: [],
                        versions: [],
                        meId: me.id,
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

inspectionReportTab.method.setInventoryCriteria = function (shipmentId) {

    let remittanceDetailCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "remittance.shipmentId",
            operator: "equals",
            value: shipmentId
        }, {fieldName: "remittance.shipmentId", operator: "notNull"}]
    };

    inspectionReportTab.restDataSource.remittanceDetailRest.fetchData(remittanceDetailCriteria, function (dsResponse, data, dsRequest) {

        if (data.length !== 0) {

            let final = data.map(item => item.inventory.id).distinct();
            inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").setValue(final);
        }
    });
};

inspectionReportTab.method.setShipmentCriteria = function (materialId) {
    inspectionReportTab.dynamicForm.inspecReport.getItem("shipmentId").setOptionCriteria({
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "materialId",
            operator: "equals",
            value: materialId
        }]
    });
};

// inspectionReportTab.method.getAssayId = function (meId, inId) {
//
//     let assayCriteria = {
//         _constructor: "AdvancedCriteria",
//         operator: "and",
//         criteria: [
//             {
//                 fieldName: "materialElementId",
//                 operator: "equals",
//                 value: meId
//             },
//             {
//                 fieldName: "inventoryId",
//                 operator: "equals",
//                 value: inId
//             }]
//     };
//
//     let dataZero = inspectionReportTab.restDataSource.assayInspecRest.fetchData(assayCriteria, function (dsResponse, data, dsRequest) {
//         return data[0];
//     });
//
//     console.log("DATA: " + JSON.stringify(dataZero));
//
// };

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

let currencyInUnitCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "categoryUnit", operator: "equals", value: 1}]
};

//*************************************************** FORM STRUCTURE ************************************************

inspectionReportTab.dynamicForm.material = isc.DynamicForm.create({
    width: "50%",
    align: "center",
    numCols: 2,
    margin: 10,
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
            changed: function (form, item, value) {

                inspectionReportTab.tab.inspecTabs.tabs.filter(q => q.name === "assay").first().pane.enable();
                inspectionReportTab.variable.materialId = item.getValue();
                inspectionReportTab.method.getAssayElementFields(inspectionReportTab.variable.materialId);
                inspectionReportTab.method.setShipmentCriteria(inspectionReportTab.variable.materialId);

                switch (inspectionReportTab.variable.materialId) {

                    case ImportantIDs.material.COPPER_CATHOD:
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

                let unitName = StorageUtil.get('parameters').unit.filter(q => q.id === inspectionReportTab.listGrid.weightElement.unitId).first().nameFA;
                let weightWGTitle = inspectionReportTab.listGrid.weightElement.getFieldTitle("weightGW").replace(/ *\([^)]*\) */g, "");
                inspectionReportTab.listGrid.weightElement.setFieldTitle("weightGW", weightWGTitle + " (" + unitName + ")");
                let weightNDTitle = inspectionReportTab.listGrid.weightElement.getFieldTitle("weightND").replace(/ *\([^)]*\) */g, "");
                inspectionReportTab.listGrid.weightElement.setFieldTitle("weightND", weightNDTitle + " (" + unitName + ")");

                inspectionReportTab.dynamicForm.inspecReport.getItem("inventoryId").setValue([]);
                inspectionReportTab.dynamicForm.inspecReport.getItem("shipmentId").setValue([]);
                inspectionReportTab.listGrid.weightElement.setData([]);
                inspectionReportTab.listGrid.assayElement.setData([]);
            }

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
        name: "shipmentId",
        title: "<spring:message code='Shipment.title'/>",
        required: true,
        colSpan: 2,
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
                name: "material.descl",
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
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {
            inspectionReportTab.method.setInventoryCriteria(value);
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
        dateFormatter: "yyyy-MM-dd HH:mm:ss",
        // formatValue: function (value) {
        //     return new Date(value);
        // }
    },
    {
        name: "inventoryId",
        title: "<spring:message code='inspectionReport.InventoryId'/>",
        colSpan: 2,
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
                name: "materialItem.materialId",
                align: "center",
                hidden: true
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
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: inspectionReportTab.restDataSource.unitRest,
        optionCriteria: currencyInUnitCriteria,
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
        name: "mileStone",
        title: "<spring:message code='inspectionReport.mileStone'/>",
        required: true,
        wrapTitle: false,
        valueMap: JSON.parse('${Enum_MileStone}'),
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "description",
        title: "<spring:message code='inspectionReport.description'/>",
        colSpan: 4,
        width: "100%",
        wrapTitle: false,
        editorType: "textArea",
        marginRight: 10
    },
]);

inspectionReportTab.dynamicForm.inspecReport = isc.DynamicForm.create({
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
    canRemoveRecords: false,
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
                if (record == null || value == null || selectedInventories.length === 0)
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
            wrapTitle: false,
            validators: [
                {
                    type: "required",
                    validateOnChange: true
                }]
        },
        {
            name: "labPlace",
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
    height: "100%",
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
        }
    ]
});

//***************************************************** FUNCTIONS *************************************************

inspectionReportTab.method.clearForm = function () {
    inspectionReportTab.dynamicForm.material.clearValues();
    inspectionReportTab.dynamicForm.inspecReport.clearValues();
    inspectionReportTab.dynamicForm.assayLab.clearValues();
    inspectionReportTab.listGrid.weightElement.setData([]);
    inspectionReportTab.listGrid.assayElement.setData([]);
    inspectionReportTab.listGrid.assayElement.setFields([]);
};

inspectionReportTab.method.setWeightElementListRows = function (selectedInventories) {

    inspectionReportTab.listGrid.weightElement.setData([]);
    if (selectedInventories.length === 0)
        return;

    selectedInventories.forEach((current, index, array) => inspectionReportTab.listGrid.weightElement.startEditingNew({inventoryId: current.id}));

    if (inspectionReportTab.variable.method !== "PUT") return;

    let record = inspectionReportTab.listGrid.main.getSelectedRecord();
    inspectionReportTab.listGrid.weightElement.setData(record.weightInspections);
    inspectionReportTab.listGrid.weightElement.saveAllEdits();
    inspectionReportTab.listGrid.weightElement.endEditing();
// }
};

inspectionReportTab.method.setAssayElementListRows = function (selectedInventories) {

    inspectionReportTab.listGrid.assayElement.setData([]);
    if (selectedInventories.length === 0)
        return;

    selectedInventories.forEach((current, index, array) => inspectionReportTab.listGrid.assayElement.startEditingNew({inventoryId: current.id}));

    if (inspectionReportTab.variable.method !== "PUT") return;

    let record = inspectionReportTab.listGrid.main.getSelectedRecord();
    let fields = inspectionReportTab.listGrid.assayElement.fields;
    let length = inspectionReportTab.listGrid.assayElement.fields.length;
    let assayData = inspectionReportTab.method.groupByAssays(record.assayInspections, "inventoryId");

    selectedInventories.forEach((current, index, array) => {
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

inspectionReportTab.method.groupByAssays = function (array, groupFieldName) {

    let group = array.groupBy(groupFieldName);
    let result = [];
    Object.keys(group).forEach(q => result.add(group[q]));
    return result;

};


inspectionReportTab.window.inspecReport = new nicico.FormUtil();
inspectionReportTab.window.inspecReport.init(null, '<spring:message code="inspectionReport.title"/>', isc.VLayout.create({
    width: "100%",
    height: "650",
    align: "center",
    members: [
        inspectionReportTab.dynamicForm.material,
        inspectionReportTab.dynamicForm.inspecReport,
        inspectionReportTab.tab.inspecTabs
    ]
}), "800", "60%");

inspectionReportTab.window.inspecReport.populateData = function (bodyWidget) {

    let weightInspections = [];
    let assayInspectionRecord = [];

    //------------- Save Inspection Data in Object -----------
    let inspectionReportObj = bodyWidget.members.get(1).getValues();

    inspectionReportTab.listGrid.weightElement.endEditing();
    inspectionReportTab.listGrid.assayElement.endEditing();
    //---------------- Save Weight Data in Object ------------
    bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).selectAllRecords();
    bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).getSelectedRecords().forEach(function (weightRecord, element) {

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
        weightInspectionObj.weighingType = weightRecord.weighingType;
        weightInspectionObj.weightND = weightRecord.weightND;
        weightInspectionObj.weightGW = weightRecord.weightGW;
        weightInspectionObj.shipmentId = inspectionReportObj.shipmentId;
        weightInspectionObj.inventoryId = weightRecord.inventoryId;
        weightInspectionObj.unitId = bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).unitId;
        weightInspectionObj.mileStone = inspectionReportObj.mileStone;
        weightInspections.push(weightInspectionObj);

    });
    inspectionReportObj.weightInspections = weightInspections;

    //--------------- Save Assay Data in Object --------------
    inspectionReportTab.variable.allCols = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).fields.length;
    inspectionReportTab.variable.allME = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).fields;

    bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).selectAllRecords();
    let records = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getSelectedRecords();
    records.sortByProperty("inventoryId", true);
    records.forEach(function (assayRecord, index) {

        for (let i = 2; i < inspectionReportTab.variable.allCols; i++) {

            let assayInspectionObj = {};

            assayInspectionObj.labName = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("labName").getValue();
            assayInspectionObj.labPlace = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("labPlace").getValue();
            assayInspectionObj.id = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getField(i).ids[index];
            assayInspectionObj.version = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getField(i).versions[index];
            assayInspectionObj.value = NumberUtil.parseInt(bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).getCellValue(assayRecord, index, i));
            assayInspectionObj.materialElementId = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).fields.get(i).meId;
            assayInspectionObj.materialElementId = bodyWidget.members.get(2).tabs.get(1).pane.members.get(1).fields.get(i).meId;
            assayInspectionObj.shipmentId = inspectionReportObj.shipmentId;
            assayInspectionObj.inventoryId = assayRecord.inventoryId;
            assayInspectionObj.mileStone = inspectionReportObj.mileStone;
            assayInspectionRecord.push(assayInspectionObj);
        }
    });
    inspectionReportObj.assayInspections = assayInspectionRecord;
    return inspectionReportObj;
};

inspectionReportTab.window.inspecReport.validate = function (data) {

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

inspectionReportTab.window.inspecReport.okCallBack = function (inspectionReportObj) {

    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/inspectionReport",
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
    inspectionReportTab.method.clearForm();
};

inspectionReportTab.method.refreshData = function () {
    inspectionReportTab.listGrid.main.invalidateCache();
};

inspectionReportTab.method.newForm = function () {
    inspectionReportTab.variable.method = "POST";
    inspectionReportTab.method.clearForm();
    inspectionReportTab.window.inspecReport.justShowForm();
};

inspectionReportTab.method.editForm = function () {

    inspectionReportTab.variable.method = "PUT";
    let inventories = [];
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

        inspectionReportTab.window.inspecReport.justShowForm();
        inspectionReportTab.dynamicForm.inspecReport.editRecord(record);

        let weightInspectionArray = record.weightInspections;
        let assayInspectionArray = record.assayInspections;

        // Set Material
        let materialId = weightInspectionArray.get(0).inventory.materialItem.materialId;
        inspectionReportTab.dynamicForm.material.setValue("material", materialId);
        inspectionReportTab.dynamicForm.material.getField("material").changed(inspectionReportTab.dynamicForm.material, inspectionReportTab.dynamicForm.material.getItem("material"));

        // Set Shipment
        inspectionReportTab.dynamicForm.inspecReport.setValue("shipmentId", weightInspectionArray.get(0).shipmentId);

        // Set Inventories
        weightInspectionArray.forEach((current, index, array) => inventories.add(current.inventory.id));
        inspectionReportTab.dynamicForm.inspecReport.setValue("inventoryId", inventories);

        // Set IssueDate
        inspectionReportTab.dynamicForm.inspecReport.setValue("issueDate", new Date(record.issueDate));

        // Set Milestone
        inspectionReportTab.dynamicForm.inspecReport.setValue("mileStone", weightInspectionArray.get(0).mileStone);

        // Set LabInfo
        inspectionReportTab.dynamicForm.assayLab.getField("labName").setValue(assayInspectionArray.get(0).labName);
        inspectionReportTab.dynamicForm.assayLab.getField("labPlace").setValue(assayInspectionArray.get(0).labPlace);

        // ListGrid and Data (inventoryId: Changed -> listGrids setData)
        inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId").showPicker();
        setTimeout(() => {
            inspectionReportTab.dynamicForm.inspecReport.getField("inventoryId").pickList.hide();
            inspectionReportTab.tab.inspecTabs.focus();
        }, 500);


    }
};

//***************************************************** MAINLISTGRID *************************************************

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
        name: "unit.nameFA",
        title: "<spring:message code='global.unit'/>"
    }
];

nicico.BasicFormUtil.getDefaultBasicForm(inspectionReportTab, "api/inspectionReport/");
