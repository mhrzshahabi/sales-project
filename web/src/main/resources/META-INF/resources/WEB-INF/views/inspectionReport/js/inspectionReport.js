var inspectionReportTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
var This = this;
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
            name: "inspector",
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
            name: "InventoryId",
            title: "<spring:message code='inspectionReport.InventoryId'/>"
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
            name: "inspectionReportId",
            title: "<spring:message code='weightInspection.inspectionReportId'/>"
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
            name: "itemElementId",
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
        {
            name: "inspectionReportId",
            title: "<spring:message code='assayInspection.inspectionReportId'/>"
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
            name: "materialItemId",
        },
        {
            name: "label",
        }
    ],
    fetchDataURL: "${contextPath}/inventory/spec-list"
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
            name: "contactInspection.id",
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
        required: true,
        keyPressFilter: "[0-9]",
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "inspector",
        title: "<spring:message code='inspectionReport.inspector.nameFA'/>",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "nameFA",
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
        type: "date"
    },
    {
        name: "InventoryId",
        title: "<spring:message code='inspectionReport.InventoryId'/>",
        colSpan: 2,
        // required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "amount",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: RestDataSource_InventoryRest,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "materialItem.material.descp",
                align: "center",
            },
            {
                name: "label",
                align: "center",
                // title: "<spring:message code='global.unit'/>",
            },
        ],
        // validators: [
        //     {
        //         type: "required",
        //         validateOnChange: true
        //     }]
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

inspectionReportTab.dynamicForm.contract = isc.DynamicForm.create({
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
            name: "contractId",
            title: "<spring:message code='contract.contractNo'/>",
            // required: true,
            autoFetchData: false,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "contractNo",
            pickListWidth: "500",
            pickListHeight: "300",
            optionDataSource: RestDataSource_ContractRest,
            // optionCriteria: buyerCriteria,
            pickListProperties:
                {
                    showFilterEditor: true
                },
            pickListFields: [
                {
                    name: "contractNo",
                    align: "center"
                },
                {
                    name: "contractDate",
                    align: "center"
                },
                {
                    name: "material.descp",
                    align: "center"
                },
                {
                    name: "contactInspection.id"
                }
            ],
            // validators: [
            //     {
            //         type: "required",
            //         validateOnChange: true
            //     }],
            changed: function (form) {
                // var contractId = form.getItem("contractId").getValue();
                var material = form.getItem("contractId").getSelectedRecord().material.descp;
                inspectionReportTab.dynamicForm.contract.getItem("material").setValue(material);
                var contactInspection = form.getItem("contractId").getSelectedRecord().contactInspection;
                if (contactInspection != null){
                    inspectionReportTab.dynamicForm.inspecReport.getItem("inspector").setValue(contactInspection.id);
                }
            }
        },
        {
            name: "material",
            title: "<spring:message code='material.title'/>",
            type: "staticText"
        }
    ]
});

//***************************************************** OTHERS *************************************************

// var WeightInspec_SaveButton = isc.IButtonSave.create({
//     title: "<spring:message code='global.form.save'/>",
//     icon: "pieces/16/save.png",
//     click: function () {
//         // var data = This.populateData(This.bodyWidget.getObject());
//     }
// });

// var AssayInspec_SaveButton = isc.IButtonSave.create({
//     title: "<spring:message code='global.form.save'/>",
//     icon: "pieces/16/save.png",
//     click: function () {
//     }
// });

var weightInspectionObj = {
    InspectionNO: "",
    inspectorId: "",
    inspectionPlace: "",
    IssueDate: "",
    InventoryId: "",
    sellerId: "",
    buyerId: "",
    inspectionRateValue: "",
    inspectionRateValueType: "",
    currencyId: "",
    weighingType: "",
    weightGW: "",
    weightND: "",
    inspectionReportId: "",
};

var assayInspectionObj = {
    InspectionNO: "",
    inspectorId: "",
    inspectionPlace: "",
    IssueDate: "",
    InventoryId: "",
    sellerId: "",
    buyerId: "",
    inspectionRateValue: "",
    inspectionRateValueType: "",
    currencyId: "",
    value: "",
    inspectionReportId: "",
    itemElementId: "",
    LabName: "",
    LabPlace: "",
};

var WeightPane = isc.VLayout.create({
    autoDraw: true,
    members: [
        isc.DynamicForm.create({
            height: "100%",
            weight: "100%",
            dataSource: RestDataSource_WeightInspecRest,
            fields: [
                {
                    type: "RowSpacerItem"
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
                },
                {
                    name: "inspectionReportId",
                    required: true
                }
            ]
        }),
        // WeightInspec_SaveButton
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
                    type: "RowSpacerItem"
                },
                {
                    name: "value",
                    required: true
                },
                {
                    name: "LabName"
                },
                {
                    name: "LabPlace"
                },
                {
                    name: "inspectionReportId",
                    required: true
                },
                {
                    name: "itemElementId",
                    required: true
                }
            ],
        }),
        // AssayInspec_SaveButton
    ]
});

inspectionReportTab.window.inspecReport = new nicico.FormUtil();
inspectionReportTab.window.inspecReport.init(null, '<spring:message code="inspectionReport.title"/>', isc.VLayout.create({
    width: "100%",
    height: "500",
    align: "center",
    members: [
        inspectionReportTab.dynamicForm.contract,
        inspectionReportTab.dynamicForm.inspecReport,
        isc.TabSet.create({
            height: "100%",
            width: "100%",
            autoDraw: true,
            tabs: [
                {
                    name: "weight",
                    title: "<spring:message code='inspectionReport.weightInspection'/>",
                    // icon: "pieces/16/icon1.png",
                    pane: WeightPane
                },
                {
                    name: "assay",
                    title: "<spring:message code='inspectionReport.assayInspection'/>",
                    // icon: "pieces/16/icon2.png",
                    pane: assayPane,
                }
            ]
        })
        // inspectionReportTabSets
    ]
}), "800", "60%");

inspectionReportTab.window.inspecReport.populateData = function(bodyWidget) {

    bodyWidget.members.get(1).validate();
    if (bodyWidget.members.get(1).hasErrors())
        return;
    bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).validate();
    if (bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).hasErrors())
        return;
    // bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).validate();
    // if (bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).hasErrors())
    //     return;

    // inspectionReport for Weight
    weightInspectionObj.InspectionNO = bodyWidget.members.get(1).getItem("InspectionNO").getValue();
    weightInspectionObj.inspectorId = bodyWidget.members.get(1).getItem("inspector").getValue();
    weightInspectionObj.inspectionPlace = bodyWidget.members.get(1).getItem("inspectionPlace").getValue();
    weightInspectionObj.IssueDate = bodyWidget.members.get(1).getItem("IssueDate").getValue();
    weightInspectionObj.InventoryId = bodyWidget.members.get(1).getItem("InventoryId").getValue();
    weightInspectionObj.sellerId = bodyWidget.members.get(1).getItem("sellerId").getValue();
    weightInspectionObj.buyerId = bodyWidget.members.get(1).getItem("buyerId").getValue();
    weightInspectionObj.inspectionRateValue = bodyWidget.members.get(1).getItem("inspectionRateValue").getValue();
    weightInspectionObj.inspectionRateValueType = bodyWidget.members.get(1).getItem("inspectionRateValueType").getValue();
    weightInspectionObj.currencyId = bodyWidget.members.get(1).getItem("currencyId").getValue();
    // inspectionReport for Assay
    assayInspectionObj.InspectionNO = bodyWidget.members.get(1).getItem("InspectionNO").getValue();
    assayInspectionObj.inspectorId = bodyWidget.members.get(1).getItem("inspector").getValue();
    assayInspectionObj.inspectionPlace = bodyWidget.members.get(1).getItem("inspectionPlace").getValue();
    assayInspectionObj.IssueDate = bodyWidget.members.get(1).getItem("IssueDate").getValue();
    assayInspectionObj.InventoryId = bodyWidget.members.get(1).getItem("InventoryId").getValue();
    assayInspectionObj.sellerId = bodyWidget.members.get(1).getItem("sellerId").getValue();
    assayInspectionObj.buyerId = bodyWidget.members.get(1).getItem("buyerId").getValue();
    assayInspectionObj.inspectionRateValue = bodyWidget.members.get(1).getItem("inspectionRateValue").getValue();
    assayInspectionObj.inspectionRateValueType = bodyWidget.members.get(1).getItem("inspectionRateValueType").getValue();
    assayInspectionObj.currencyId = bodyWidget.members.get(1).getItem("currencyId").getValue();
    // tabSets (Weight)
    weightInspectionObj.weighingType = Number(bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).getItem("weighingType.id").getValue());
    weightInspectionObj.weightGW = bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).getItem("weightGW").getValue();
    weightInspectionObj.weightND = bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).getItem("weightND").getValue();
    weightInspectionObj.inspectionReportId = bodyWidget.members.get(2).tabs.get(0).pane.members.get(0).getItem("inspectionReportId").getValue();
    // tabSets (Assay)
    assayInspectionObj.value = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("value").getValue();
    assayInspectionObj.inspectionReportId = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("inspectionReportId").getValue();
    assayInspectionObj.itemElementId = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("itemElementId").getValue();
    assayInspectionObj.LabName = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("LabName").getValue();
    assayInspectionObj.LabPlace = bodyWidget.members.get(2).tabs.get(1).pane.members.get(0).getItem("LabPlace").getValue();
};

// inspectionReportTab.window.inspecReport.validate = function(data) {
//
// };

inspectionReportTab.window.inspecReport.okCallBack = function(data) {

    if (weightInspectionObj.weightGW != null){
        alert("weight")
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/weightInspection/weight",
                httpMethod: "POST",
                data: JSON.stringify(weightInspectionObj),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        inspectionReportTab.listGrid.main.refresh();
                        inspectionReportTab.window.inspecReport.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            })
        );
    }
    /*if (data.value != null){
        alert("assay")
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/assayInspection/",
                httpMethod: "POST",
                data: JSON.stringify(data),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        inspectionReportTab.listGrid.main.refresh();
                        inspectionReportTab.window.inspecReport.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            })
        );
    }*/
};


inspectionReportTab.method.newForm = function () {
    inspectionReportTab.window.inspecReport.justShowForm();
};

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
        title: "<spring:message code='inspectionReport.IssueDate'/>",
        type: "date"
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
// inspectionReportTab.dynamicForm.main.windowWidth = 700;
