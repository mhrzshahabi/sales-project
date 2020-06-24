var inspectionReportTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

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
            name: "InspectionNO",
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
            name: "IssueDate",
            title: "<spring:message code='inspectionReport.IssueDate'/>"
        },
        {
            name: "remittanceDetailId",
            title: "<spring:message code='inspectionReport.remittanceDetailId'/>"
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
            name: "materialElement",
            title: "<spring:message code='assayInspection.materialElement'/>"
        },
        {
            name: "LabName",
            title: "<spring:message code='assayInspection.LabName'/>"
        },
        {
            name: "LabPlace",
            title: "<spring:message code='assayInspection.LabPlace'/>"
        },
        {
            name: "inspectionReport",
        },
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

var RestDataSource_RemittanceDetailRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "amount",
        },
        {
            // Packaging
            name: "unit.nameFA",
        }
    ],
    fetchDataURL: "${contextPath}/remittanceDetail/spec-list"
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
            name: "contactInspection.nameFA",
            title: "<spring:message code='contact.nameFa'/>"
        },
        {
            name: "material.descp",
            title: "<spring:message code='material.descp'/>"
        },
    ],
    fetchDataURL: "${contextPath}/api/contract/spec-list"
});

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

//***************************************************** DYNAMICFORM *************************************************

inspectionReportTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "id",
        hidden: true
    },
    {
        name: "InspectionNO",
        title: "<spring:message code='inspectionReport.InspectionNO'/>",
        colSpan: 1,
        required: true,
        titleColSpan: 1,
        keyPressFilter: "[0-9]",
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "inspectorId",
        title: "<spring:message code='inspectionReport.inspectorId'/>",
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
        name: "IssueDate",
        title: "<spring:message code='inspectionReport.IssueDate'/>",
    },
    {
        name: "remittanceDetailId",
        title: "<spring:message code='inspectionReport.remittanceDetailId'/>",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "amount",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: RestDataSource_RemittanceDetailRest,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "nameFA",
                align: "center",
                title: "<spring:message code='global.title-fa'/>",
            },
            {
                name: "unit.nameFA",
                align: "center",
                title: "<spring:message code='global.unit'/>",
            },
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
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
    },
    {
        name: "currencyId",
        title: "<spring:message code='inspectionReport.currencyId'/>",
    },
    ]);

// inspectionReportTab.dynamicForm.weightInspec = isc.DynamicForm.nicico.createDynamicForm();

/*inspectionReportTab.dynamicForm.inspecReport = isc.DynamicForm.create({
    width: "100%",
    numCols: 4,
    canSubmit: true,
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: inspectionReportTab.dynamicForm.fields
});*/

//***************************************************** OTHERS *************************************************

var WeightPane = isc.VLayout.create({
    autoDraw: true,
    members: [
        isc.DynamicForm.create({
            height: "100%",
            weight: "100%",
            dataSource: RestDataSource_WeightInspecRest,
            fields: [
                {
                    name: "weightGW"
                },
                {
                    name: "weightND"
                }
            ]
        })
        // ContactAccount_CreateDynamicForm,
        // HLayout_CreateFormButton
    ]
});

var assayPane = isc.VLayout.create({
    autoDraw: true,
    members: [
        isc.DynamicForm.create({
            height: "100%",
            weight: "100%",
            dataSource: RestDataSource_AssayInspecRest,
            fields: [
                {
                    name: "value"
                },
                {
                    name: "LabName"
                },
                {
                    name: "LabPlace"
                }
            ]
        })
        // ContactAccount_CreateDynamicForm,
        // HLayout_CreateFormButton
    ]
});

var inspectionReportTabs = isc.TabSet.create({
    height: "100%",
    width: "100%",
    autoDraw: true,
    tabs: [
        {
            name: "weight",
            title: "<spring:message code='inspectionReport.weightInspection'/>",
            // icon: "pieces/16/icon_add.png",
            pane: WeightPane
        },
        {
            name: "assay",
            title: "<spring:message code='inspectionReport.assayInspection'/>",
            // icon: "pieces/16/icon_edit.png",
            pane: assayPane,
        }
    ]
});

var bodyVLayout = isc.VLayout.create({
    width: "100%",
    height: "100%",
    border: "0px solid blue",
    autoDraw: false,
    layoutMargin: 5,
    members: [
        inspectionReportTab.dynamicForm.main,
        inspectionReportTabs
    ]
});

inspectionReportTab.window.main = isc.Window.nicico.getDefault('<spring:message code="inspectionReport.title"/>', [
    bodyVLayout
    ], "100%");

// incotermAspectTab.

//***************************************************** LISTGRID *************************************************

inspectionReportTab.listGrid.fields = [
    {
        name: "id",
        hidden: true
    },
    {
        name: "InspectionNO",
        title: "<spring:message code='inspectionReport.InspectionNO'/>"
    },
    {
        name: "inspector.nameFA",
        title: "<spring:message code='inspectionReport.inspector.nameFA'/>"
    },
    {
        name: "inspectionPlace",
        title: "<spring:message code='inspectionReport.inspectionPlace'/>"
    },
    {
        name: "IssueDate",
        title: "<spring:message code='inspectionReport.IssueDate'/>"
    },
    {
        name: "seller.nameFA",
        title: "<spring:message code='inspectionReport.seller.nameFA'/>"
    },
    {
        name: "buyer.nameFA",
        title: "<spring:message code='inspectionReport.buyer.nameFA'/>"
    },
    {
        name: "inspectionRateValue",
        title: "<spring:message code='inspectionReport.inspectionRateValue'/>"
    },
    {
        name: "inspectionRateValueType",
        title: "<spring:message code='inspectionReport.inspectionRateValueType'/>"
    }
];


var defaultBasicForm = nicico.BasicFormUtil.getDefaultBasicForm(inspectionReportTab, "api/inspectionReport/");
// inspectionReportTab.dynamicForm.main = DynamicForm_InspectionReport;
inspectionReportTab.dynamicForm.main.windowWidth = 700;
