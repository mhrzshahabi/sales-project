//******************************************************* VARIABLES ****************************************************

var packingListTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

packingListTab.variable.packingListUrl = "${contextPath}" + "/api/packing-list/";
packingListTab.variable.packingContainerUrl = "${contextPath}" + "/api/packing-container/";
packingListTab.variable.billOfLandingUrl = "${contextPath}" + "/api/bill-of-landing/";
packingListTab.variable.shipmentUrl = "${contextPath}" + "/api/shipment/";
// shipmentCostInvoiceTab.variable.contactUrl = "${contextPath}" + "/api/contact/";
// shipmentCostInvoiceTab.variable.billOfLandingUrl = "${contextPath}" + "/api/bill-of-landing/";

//***************************************************** RESTDATASOURCE *************************************************

packingListTab.restDataSource.packingListRest = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "billOfLanding", type: "date", showHover: true, title: "<spring:message code ='packing-list.billOfLanding'/>"},
        {name: "billOfLanding.documentNo", type: "date", showHover: true, title: "<spring:message code ='packing-list.billOfLanding.documentNo'/>"},
        {name: "billOfLanding.shipperExporter.name", showHover: true, title: "<spring:message code ='packing-list.billOfLanding.shipperExporter'/>"},
        {name: "shipment", showHover: true, title: "<spring:message code ='packing-list.shipment'/>"},
        {name: "shipment.sendDate", type: "date", showHover: true, title: "<spring:message code ='packing-list.shipment.sendDate'/>"},
        {name: "bookingNo", type: 'text', showHover: true, title: "<spring:message code='packing-list.bookingNo'/>"},
        {name: "description", type: 'text', showHover: true, title: "<spring:message code='packing-list.description'/>"},
    ],
    fetchDataURL: packingListTab.variable.packingListUrl + "spec-list"
});
packingListTab.restDataSource.packingContainer = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "containerNo", showHover: true, title: "<spring:message code ='packing-container.containerNo'/>"},
        {name: "sealNo", showHover: true, title: "<spring:message code ='packing-container.sealNo'/>"},
        {name: "ladingDate", showHover: true, title: "<spring:message code ='packing-container.ladingDate'/>"},
        {name: "packageCount", showHover: true, title: "<spring:message code ='packing-container.packageCount'/>"},
        {name: "subpackageCount", type: "date", showHover: true, title: "<spring:message code ='packing-container.subpackageCount'/>"},
        {name: "strapWeight", showHover: true, title: "<spring:message code='packing-container.strapWeight'/>"},
        {name: "palletCount", showHover: true, title: "<spring:message code='packing-container.palletCount'/>"},
        {name: "palletWeight", showHover: true, title: "<spring:message code='packing-container.palletWeight'/>"},
        {name: "woodWeight", showHover: true, title: "<spring:message code='packing-container.woodWeight'/>"},
        {name: "barrelWeight", showHover: true, title: "<spring:message code='packing-container.barrelWeight'/>"},
        {name: "containerWeight", showHover: true, title: "<spring:message code='packing-container.containerWeight'/>"},
        {name: "contentWeight", showHover: true, title: "<spring:message code='packing-container.contentWeight'/>"},
        {name: "vgmWeight", showHover: true, title: "<spring:message code='packing-container.vgmWeight'/>"},
        {name: "netWeight", showHover: true, title: "<spring:message code='packing-container.netWeight'/>"},
        {name: "description", showHover: true, title: "<spring:message code='packing-container.description'/>"},
    ],
    fetchDataURL: packingListTab.variable.packingContainerUrl + "spec-list"
});
packingListTab.restDataSource.shipmentRest = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "sendDate", type: "date", showHover: true, title: "<spring:message code ='global.sendDate'/>"},
        {name: "bookingCat", title: "<spring:message code ='shipment.bookingCat'/>", showHover: true},
        {
            name: "contractShipment.contract.no",
            type: 'text',
            showHover: true,
            title: "<spring:message code='contract.contractNo'/>"
        },
        {name: "material.descEN", type: 'text', showHover: true, title: "<spring:message code='material.descEN'/>"}
    ],
    fetchDataURL: packingListTab.variable.shipmentUrl + "spec-list"
});
// shipmentCostInvoiceTab.restDataSource.shipmentCostDutyRest = isc.MyRestDataSource.create({
//     fields: [
//         {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
//         {
//             name: "name",
//             title: "<spring:message code='shipmentCostInvoiceDetail.serviceName'/>",
//             type: 'text'
//         },
//         {name: "code", title: "<spring:message code='shipmentCostInvoiceDetail.serviceCode'/>", type: 'text'}
//     ],
//     fetchDataURL: shipmentCostInvoiceTab.variable.shipmentCostDuty + "spec-list"
// });

//***************************************************** MAINWINDOW *************************************************

packingListTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "id",
        hidden: true
    },
    {
        name: "billOfLandingId",
        title: "<spring:message code='packing-list.billOfLanding'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "documentNo",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "documentNo", title: "<spring:message code='global.description'/>"},
                {name: "notifyParty", title: "<spring:message code='global.description'/>"},
                {name: "notifyPartyId", title: "<spring:message code='global.description'/>"},
                {name: "consignee", title: "<spring:message code='global.description'/>"},
                {name: "consigneeId", title: "<spring:message code='global.description'/>"},
            ],
            fetchDataURL: packingListTab.variable.billOfLandingUrl + "spec-list"
        }),
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "documentNo",
                align: "center"
            },
            {
                name: "notifyParty.name",
                align: "center"
            },
            {
                name: "consignee.name",
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
        name: "shipmentId",
        title: "<spring:message code='packing-list.shipment'/>",
        type: 'long',
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "sendDate",
        pickListWidth: 500,
        pickListHeight: 300,
        optionDataSource: packingListTab.restDataSource.shipmentRest,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true},
            {name: "sendDate", width: 100, type: "date"},
            {name: "bookingCat"},
            {name: "contractShipment.contract.no"},
            {name: "material.descEN"}
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        mapValueToDisplay: function (value) {
            let selectedRecord = this.getSelectedRecord();
            if (!selectedRecord) return '';
            return DateUtil.format(new Date(selectedRecord.sendDate), "YYYY/MM/dd");
        }
    },
    {
        name: "bookingNo",
        title: "<spring:message code='packing-list.bookingNo'/>",
        required: true,
        type: 'text',
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "description",
        title: "<spring:message code='packing-list.description'/>",
        width: "100%",
        colSpan: 4,
        type: "textArea",
        wrapTitle: false
    }

]);
packingListTab.dynamicForm.packingList = isc.DynamicForm.create({
    align: "center",
    numCols: 4,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: packingListTab.dynamicForm.fields
});

packingListTab.dynamicForm.packingContainerFields = BaseFormItems.concat([
    {
        name: "id",
        hidden: true
    },
    {
        name: "packingListId",
        required: true,
        hidden: true
    },
    {
        name: "containerNo",
        title: "<spring:message code='packing-container.containerNo'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "sealNo",
        title: "<spring:message code='packing-container.sealNo'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "ladingDate",
        title: "<spring:message code='packing-container.ladingDate'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "packageCount",
        title: "<spring:message code='packing-container.packageCount'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "subpackageCount",
        title: "<spring:message code='packing-container.subpackageCount'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "strapWeight",
        title: "<spring:message code='packing-container.strapWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "palletCount",
        title: "<spring:message code='packing-container.palletCount'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "palletWeight",
        title: "<spring:message code='packing-container.palletWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "woodWeight",
        title: "<spring:message code='packing-container.woodWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "barrelWeight",
        title: "<spring:message code='packing-container.barrelWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "containerWeight",
        title: "<spring:message code='packing-container.containerWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "contentWeight",
        title: "<spring:message code='packing-container.contentWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "vgmWeight",
        title: "<spring:message code='packing-container.vgmWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "netWeight",
        title: "<spring:message code='packing-container.netWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "description",
        title: "<spring:message code='packing-container.description'/>",
        width: "100%",
        colSpan: 4,
        type: "textArea",
        wrapTitle: false
    }
]);
packingListTab.dynamicForm.packingContainer = isc.DynamicForm.create({
    align: "center",
    numCols: 4,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: packingListTab.dynamicForm.packingContainerFields
});

packingListTab.toolStrip.packingContainer = isc.ToolStripButton.create({
    visibility: "visible",
    icon: "[SKIN]/actions/configure.png",
    title: "<spring:message code='packing-container.add'/>",
    click: function () {

        packingListTab.window.packingContainer.justShowForm();
    }
});
packingListTab.hLayout.packingContainer = isc.HLayout.create({
    width: "100%",
    align: nicico.CommonUtil.getAlignByLang(),
    members: [
        packingListTab.listGrid.packingContainerListGrid,
        packingListTab.toolStrip.packingContainer
    ]
});

packingListTab.window.packingList = new nicico.FormUtil();
packingListTab.window.packingList.init(null, '<spring:message code="packing-list.title"/>', isc.VLayout.create({
    width: "100%",
    height: "250",
    margin: 20,
    align: "center",
    members: [
        packingListTab.dynamicForm.packingList,
    ]
}), "650", "30%");

packingListTab.window.packingContainer = new nicico.FormUtil();
packingListTab.window.packingContainer.init(null, '<spring:message code="packing-container.title"/>', isc.VLayout.create({
    width: "100%",
    height: "250",
    margin: 20,
    align: "center",
    members: [
        packingListTab.dynamicForm.packingContainer,
    ]
}), "650", "30%");

packingListTab.window.packingList.populateData = function (bodyWidget) {

    return packingListTab.dynamicForm.packingList.getValues();
};
// packingListTab.window.packingList.validate = function (data) {
// };
packingListTab.window.packingList.okCallBack = function (data) {

    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

            actionURL: "${contextPath}/api/packing-list",
            httpMethod: packingListTab.variable.method,
            data: JSON.stringify(data),
            callback: function (resp) {

                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    packingListTab.method.refreshData();
                } else
                    isc.say(resp.data);
            }
        })
    );
};
packingListTab.window.packingList.cancelCallBack = function () {
    packingListTab.dynamicForm.packingList.clearValues();
};


packingListTab.window.packingContainer.populateData = function (bodyWidget) {
debugger
    let record = packingListTab.listGrid.main.getSelectedRecord();
    let data = packingListTab.dynamicForm.packingContainer.getValues();
    data.packingListId = record.id;
    return data;
};
// packingListTab.window.packingContainer.validate = function (data) {
// };
packingListTab.window.packingContainer.okCallBack = function (data) {

    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

            actionURL: "${contextPath}/api/packing-container",
            httpMethod: packingListTab.variable.method,
            data: JSON.stringify(data),
            callback: function (resp) {

                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    packingListTab.method.refreshData();
                } else
                    isc.say(resp.data);
            }
        })
    );
};
packingListTab.window.packingContainer.cancelCallBack = function () {
    packingListTab.dynamicForm.packingContainer.clearValues();
};

packingListTab.method.refreshData = function () {
    packingListTab.listGrid.main.invalidateCache();
    packingListTab.listGrid.packingContainerListGrid.invalidateCache();
};

packingListTab.method.newForm = function () {

    packingListTab.variable.method = "POST";
    packingListTab.dynamicForm.packingList.clearValues();
    packingListTab.window.packingList.justShowForm();
};


//***************************************************** MAINLISTGRID *************************************************

packingListTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "billOfLanding.documentNo",
        width: "10%"
    },
    {
        name: "billOfLanding.shipperExporter.name",
        width: "10%"
    },
    {
        name: "shipment.sendDate",
        width: "10%",
        type: "date"
    },
    {
        name: "bookingNo",
        width: "10%"
    },
]);

// ShipmentCost Section
nicico.BasicFormUtil.createListGrid = function () {

    packingListTab.listGrid.main = isc.ListGrid.nicico.getDefault(packingListTab.listGrid.fields,
        packingListTab.restDataSource.packingListRest, null, {
            showFilterEditor: true,
            canAutoFitFields: true,
            width: "100%",
            height: "100%",
            autoFetchData: true,
            styleName: 'expandList',
            alternateRecordStyles: true,
            canExpandRecords: true,
            canExpandMultipleRecords: false,
            wrapCells: false,
            showRollOver: false,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            autoFitExpandField: true,
            virtualScrolling: true,
            loadOnExpand: true,
            loaded: false,
            sortField: 3,
            getExpansionComponent: function (record) {

                let criteria1 = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "packingListId", operator: "equals", value: record.id}]
                };

                packingListTab.listGrid.packingContainerListGrid.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                    if (data.length === 0) {
                        packingListTab.hLayout.packingContainer.show();
                    } else {

                        packingListTab.listGrid.packingContainerListGrid.setData(data);
                        packingListTab.listGrid.packingContainerListGrid.setAutoFitMaxRecords(1);
                        packingListTab.hLayout.packingContainer.show();
                    }
                }, {operationId: "00"});

                packingListTab.vLayout.packingListMain = isc.VLayout.create({
                    styleName: "expand-layout",
                    padding: 5,
                    membersMargin: 10,
                    members: [
                        packingListTab.listGrid.packingContainerListGrid,
                        packingListTab.hLayout.packingContainer
                    ]
                });
                return packingListTab.vLayout.packingListMain;
            }
        }
    );
};

// ShipmentCostDetail Section
packingListTab.listGrid.packingContainerListGrid = isc.ListGrid.create(
    {
        showFilterEditor: true,
        canAutoFitFields: true,
        width: "100%",
        styleName: "listgrid-child",
        height: 180,
        dataSource: packingListTab.restDataSource.packingContainer,
        autoFetchData: false,
        setAutoFitExtraRecords: true,
        fields: [
            {
                name: "id",
                hidden: true,
                primaryKey: true
            },
            {
                name: "containerNo",
                // title: "<spring:message code ='packing-container.containerNo'/>",
                width: "10%",
            },
            {
                name: "sealNo",
                // title: "<spring:message code ='packing-container.sealNo'/>",
                width: "10%"
            },
            {
                name: "packageCount",
                // title: "<spring:message code ='packing-container.packageCount'/>",
                width: "10%",
            },
            {
                name: "palletCount",
                // title: "<spring:message code ='packing-container.palletCount'/>",
                width: "10%",
            },
            /*{
                name: "editIcon",
                width: "4%",
                align: "center",
                showTitle: false
            },
            {
                name: "removeIcon",
                width: "4%",
                align: "center",
                showTitle: false
            }*/
        ]
    });

nicico.BasicFormUtil.getDefaultBasicForm(packingListTab, "api/packing-list/");
// nicico.BasicFormUtil.showAllToolStripActions(packingListTab);
nicico.BasicFormUtil.removeExtraGridMenuActions(packingListTab);

packingListTab.sectionStack.mainSection = isc.SectionStack.create(
    {
        sections: [
            {
                title: "<spring:message code='packing-list.title'/>",
                items: packingListTab.vLayout.main,
                showHeader: false,
                expanded: true
            },
            {
                title: "<spring:message code='packing-container.title'/>",
                hidden: true,
                items: packingListTab.listGrid.packingContainerListGrid,
                expanded: false
            }],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });