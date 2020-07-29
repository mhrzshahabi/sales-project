var shipmentCostInvoiceTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

shipmentCostInvoiceTab.variable.invoiceTypeUrl = "${contextPath}" + "/api/invoicetype/";
shipmentCostInvoiceTab.variable.contactUrl = "${contextPath}" + "/api/contact/";
shipmentCostInvoiceTab.variable.unitUrl = "${contextPath}" + "/api/unit/";
shipmentCostInvoiceTab.variable.conversionRefUrl = "${contextPath}" + "/api/currencyRate/";
shipmentCostInvoiceTab.variable.shipmentCostInvoice = "${contextPath}" + "/api/shipmentCostInvoice/";
shipmentCostInvoiceTab.variable.shipmentCostInvoiceDetail = "${contextPath}" + "/api/shipmentCostInvoiceDetail/";
shipmentCostInvoiceTab.variable.percentPerYearRest = "${contextPath}" + "/api/percentPerYear/";

shipmentCostInvoiceTab.variable.today = new Date();
shipmentCostInvoiceTab.variable.year = shipmentCostInvoiceTab.variable.today.getFullYear();
shipmentCostInvoiceTab.variable.tVatPercent = 6;
shipmentCostInvoiceTab.variable.cVatPercent = 3;

//***************************************************** RESTDATASOURCE *************************************************

shipmentCostInvoiceTab.restDataSource.contactRest = isc.MyRestDataSource.create({
    fields: [
        {name: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
        {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
        {name: "phone", title: "<spring:message code='contact.phone'/>"},
        {name: "fax", title: "<spring:message code='contact.fax'/>"},
        {name: "address", title: "<spring:message code='contact.address'/>"},
        {name: "nationalCode", title: "<spring:message code='contact.nationalCode'/>"},
        {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
        {name: "commercialRole", title: "<spring:message code='contact.commercialRole'/>"},
    ],
    fetchDataURL: shipmentCostInvoiceTab.variable.contactUrl + "spec-list"

});

shipmentCostInvoiceTab.restDataSource.unitRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id", primaryKey: true, canEdit: false, hidden: true
        },
        {
            name: "nameFA", title: "nameFA"
        },
        {
            name: "nameEN", title: "nameEN"
        },
    ],
    fetchDataURL: shipmentCostInvoiceTab.variable.unitUrl + "spec-list"

});

shipmentCostInvoiceTab.restDataSource.shipmentCostInvoice = isc.MyRestDataSource.create({

    fields: [
        {
            name: "id", primaryKey: true, canEdit: false, hidden: true
        },
        {
            name: "referenceId", title: "<spring:message code='shipmentCostInvoice.referenceId'/>"
        },
        {
            name: "invoiceDate", title: "<spring:message code='shipmentCostInvoice.invoiceDate'/>"
        },
        {
            name: "invoiceNoPaper", title: "<spring:message code='shipmentCostInvoice.invoiceNoPaper'/>"
        },
        {
            name: "invoiceNo", title: "<spring:message code='shipmentCostInvoice.invoiceNo'/>"
        },
        {
            name: "tVat", title: "<spring:message code='shipmentCostInvoice.tVat'/>"
        },
        {
            name: "tVat", title: "<spring:message code='shipmentCostInvoice.tVat'/>"
        },
        {
            name: "sumPrice", title: "<spring:message code='shipmentCostInvoice.sumPrice'/>"
        },
        {
            name: "sumPriceWithDiscount", title: "<spring:message code='shipmentCostInvoice.sumPriceWithDiscount'/>"
        },
        {
            name: "sumPriceWithVat", title: "<spring:message code='shipmentCostInvoice.sumPriceWithVat'/>"
        },
        {
            name: "rialPrice", title: "<spring:message code='shipmentCostInvoice.rialPrice'/>"
        },
        {
            name: "conversionDate", title: "<spring:message code='shipmentCostInvoice.conversionDate'/>"
        },
        {
            name: "conversionRate", title: "<spring:message code='shipmentCostInvoice.conversionRate'/>"
        },
        {
            name: "conversionSumPrice", title: "<spring:message code='shipmentCostInvoice.conversionSumPrice'/>"
        },
        {
            name: "conversionSumPriceText", title: "<spring:message code='shipmentCostInvoice.conversionSumPriceText'/>"
        },
        {
            name: "buyerShare", title: "<spring:message code='shipmentCostInvoice.buyerShare'/>"
        },
        {
            name: "conversionSumPriceBuyerShare",
            title: "<spring:message code='shipmentCostInvoice.conversionSumPriceBuyerShare'/>"
        },
        {
            name: "conversionSumPriceSellerShare",
            title: "<spring:message code='shipmentCostInvoice.conversionSumPriceSellerShare'/>"
        },
        {
            name: "description", title: "<spring:message code='shipmentCostInvoice.description'/>"
        },
        {
            name: "invoiceType", title: "<spring:message code='shipmentCostInvoice.invoiceTypeId'/>"
        },
        {
            name: "conversionRef", title: "<spring:message code='shipmentCostInvoice.conversionRefId'/>"
        },
        {
            name: "sellerContact", title: "<spring:message code='shipmentCostInvoice.sellerContactId'/>"
        },
        {
            name: "buyerContact", title: "<spring:message code='shipmentCostInvoice.buyerContactId'/>"
        },
        {
            name: "financeUnit", title: "<spring:message code='shipmentCostInvoice.financeUnitId'/>"
        },
        {
            name: "contract", title: "<spring:message code='shipmentCostInvoice.contractId'/>"
        }
    ],
    fetchDataURL: shipmentCostInvoiceTab.variable.shipmentCostInvoice + "spec-list"

});

shipmentCostInvoiceTab.restDataSource.shipmentCostInvoiceDetail = isc.MyRestDataSource.create({

    fields: [
        {
            name: "id", primaryKey: true, canEdit: false, hidden: true
        },
        {
            name: "serviceCode", title: "<spring:message code='shipmentCostInvoiceDetail.serviceCode'/>"
        },
        {
            name: "serviceName", title: "<spring:message code='shipmentCostInvoiceDetail.serviceName'/>"
        },
        {
            name: "quantity", title: "<spring:message code='shipmentCostInvoiceDetail.quantity'/>"
        },
        {
            name: "unitPrice", title: "<spring:message code='shipmentCostInvoiceDetail.unitPrice'/>"
        },
        {
            name: "sumPrice", title: "<spring:message code='shipmentCostInvoiceDetail.sumPrice'/>"
        },
        {
            name: "discountPrice", title: "<spring:message code='shipmentCostInvoiceDetail.discountPrice'/>"
        },
        {
            name: "sumPriceWithDiscount",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPriceWithDiscount'/>"
        },
        {
            name: "tVatPrice", title: "<spring:message code='shipmentCostInvoiceDetail.tVatPrice'/>"
        },
        {
            name: "cVatPrice", title: "<spring:message code='shipmentCostInvoiceDetail.cVatPrice'/>"
        },
        {
            name: "sumVatPrice", title: "<spring:message code='shipmentCostInvoiceDetail.sumVatPrice'/>"
        },
        {
            name: "sumPriceWithVat", title: "<spring:message code='shipmentCostInvoiceDetail.sumPriceWithVat'/>"
        },
        {
            name: "shipmentCostInvoiceId", title: "<spring:message code='global.id'/>"
        },
    ],
    fetchDataURL: shipmentCostInvoiceTab.variable.shipmentCostInvoiceDetail + "spec-list"

});

shipmentCostInvoiceTab.restDataSource.percentPerYearRest = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id", primaryKey: true, canEdit: false, hidden: true
        },
        {
            name: "year", title: "year"
        },
        {
            name: "tVat", title: "tVat"
        },
        {
            name: "cVat", title: "cVat"
        }
    ],
    fetchDataURL: shipmentCostInvoiceTab.variable.percentPerYearRest + "spec-list"

});

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

let financeUnitCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "categoryUnit", operator: "equals", value: 0}]
};

shipmentCostInvoiceTab.method.setVATs = function (year) {

    let percentCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "year", operator: "equals", value: year}]
    };

    shipmentCostInvoiceTab.restDataSource.percentPerYearRest.fetchData(percentCriteria, function (dsResponse, data, dsRequest) {
        shipmentCostInvoiceTab.variable.cVatPercent = data[0].cVat;
        shipmentCostInvoiceTab.variable.tVatPercent = data[0].tVat;
    });

};


//***************************************************** MAINWINDOW *************************************************

shipmentCostInvoiceTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "id",
        hidden: true
    },
    {
        type: "RowSpacerItem"
    },
    {
        name: "invoiceTypeId",
        title: "<spring:message code='shipmentCostInvoice.invoiceType'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "title", title: "<spring:message code='global.description'/>"},
            ],
            fetchDataURL: shipmentCostInvoiceTab.variable.invoiceTypeUrl + "spec-list"
        }),
        // optionCriteria: buyerCriteria,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "title",
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
        name: "referenceId",
        title: "<spring:message code='shipmentCostInvoice.referenceId'/>",
        wrapTitle: false,
    },
    {
        name: "invoiceDate",
        title: "<spring:message code='shipmentCostInvoice.invoiceDate'/>",
        type: "date",
        wrapTitle: false,
        colSpan: 4,
        blur: function (form, item) {

            shipmentCostInvoiceTab.variable.today = item.getValue();
            shipmentCostInvoiceTab.variable.year = shipmentCostInvoiceTab.variable.today.getFullYear();
            shipmentCostInvoiceTab.method.setVATs(shipmentCostInvoiceTab.variable.year);
            form.setValue("tVat", shipmentCostInvoiceTab.variable.tVatPercent);
            form.setValue("cVat", shipmentCostInvoiceTab.variable.cVatPercent);

        },
    },
    {
        name: "invoiceNoPaper",
        title: "<spring:message code='shipmentCostInvoice.invoiceNoPaper'/>",
        wrapTitle: false
    },
    {
        name: "invoiceNo",
        title: "<spring:message code='shipmentCostInvoice.invoiceNo'/>",
        wrapTitle: false
    },
    {
        name: "sellerContactId",
        title: "<spring:message code='shipmentCostInvoice.sellerContact'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: shipmentCostInvoiceTab.restDataSource.contactRest,
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
            {
                name: "phone",
                align: "center"
            },
            {
                name: "nationalCode",
                align: "center"
            },
            {
                name: "economicalCode",
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
        name: "buyerContactId",
        title: "<spring:message code='shipmentCostInvoice.buyerContact'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: shipmentCostInvoiceTab.restDataSource.contactRest,
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
            {
                name: "phone",
                align: "center"
            },
            {
                name: "nationalCode",
                align: "center"
            },
            {
                name: "economicalCode",
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
        name: "tVat",
        title: "<spring:message code='shipmentCostInvoice.tVat'/>",
        wrapTitle: false,
        type: "staticText",
        defaultValue: shipmentCostInvoiceTab.variable.tVatPercent

    },
    {
        name: "cVat",
        title: "<spring:message code='shipmentCostInvoice.cVat'/>",
        wrapTitle: false,
        type: "staticText",
        defaultValue: shipmentCostInvoiceTab.variable.cVatPercent
    },
    {
        name: "financeUnitId",
        title: "<spring:message code='shipmentCostInvoice.financeUnit'/>",
        required: true,
        wrapTitle: false,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: shipmentCostInvoiceTab.restDataSource.unitRest,
        optionCriteria: financeUnitCriteria,
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
        name: "toFinanceUnitId",
        title: "<spring:message code='shipmentCostInvoice.toFinanceUnit'/>",
        required: true,
        wrapTitle: false,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "nameFA",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: shipmentCostInvoiceTab.restDataSource.unitRest,
        optionCriteria: financeUnitCriteria,
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
            }],
        changed: function (form, item, value) {

            form.getItem("conversionRefId").canEdit = true;
            if (!value || !form.getValue("financeUnitId")) return;
            if (form.getValue("financeUnitId") === form.getValue("toFinanceUnitId")) {

                form.setValue("conversionDate", form.getValue("invoiceDate"));
                form.setValue("conversionRate", 1);
                form.getItem("conversionRefId").canEdit = false;
            }
        }
    },
    {
        name: "conversionRefId",
        title: "<spring:message code='shipmentCostInvoice.conversionRef'/>",
        // type: "integer",
        wrapTitle: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "reference",
        pickListWidth: 370,
        pickListHeight: 300,
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
                {name: "currencyDate", title: "<spring:message code='global.date'/>"},
                {name: "symbolCF", title: "<spring:message code='global.from'/>"},
                {name: "symbolCT", title: "<spring:message code='global.to'/>"},
            ],
            fetchDataURL: shipmentCostInvoiceTab.variable.conversionRefUrl + "spec-list"
        }),
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
            {name: "currencyDate", title: "<spring:message code='global.date'/>"},
            {name: "symbolCF", title: "<spring:message code='global.from'/>"},
            {name: "symbolCT", title: "<spring:message code='global.to'/>"},
        ]
    },
    {
        name: "conversionDate",
        // title: "<spring:message code='shipmentCostInvoice.cVat'/>",
        type: "date",
        hidden: true
    },
    {
        name: "conversionRate",
        // title: "<spring:message code='shipmentCostInvoice.cVat'/>",
        hidden: true
    },
    {
        type: "RowSpacerItem"
    }
]);

shipmentCostInvoiceTab.dynamicForm.shipmentCost = isc.DynamicForm.create({
    // width: "100%",
    align: "center",
    numCols: 4,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: shipmentCostInvoiceTab.dynamicForm.fields
});

shipmentCostInvoiceTab.listGrid.shipmentCostDetail = isc.ListGrid.create({
    // width: "100%",
    // height: "100%",
    sortField: 1,
    showRowNumbers: true,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    dataSource: shipmentCostInvoiceTab.restDataSource.shipmentCostInvoiceDetail,
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
            name: "serviceCode",
            type: "text",
            width: "10%"
        },
        {
            name: "serviceName",
            required: true,
            type: "text",
            width: "10%"
        },
        {
            name: "quantity",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "unitPrice",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "sumPrice",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "discountPrice",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "sumPriceWithDiscount",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "tVatPrice",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "cVatPrice",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "sumPriceWithVat",
            type: "float",
            required: true,
            width: "10%"
        },
    ]),
    gridComponents: ["header", "body", isc.ToolStrip.create({

        width: "100%",
        height: 24,
        members: [
            // <sec:authorize access="hasAuthority('C_CONTRACT_DETAIL_TYPE_PARAM')">
            isc.ToolStripButton.create({

                icon: "pieces/16/icon_add.png",
                title: "<spring:message code='global.add'/>",
                click: function () {
                    shipmentCostInvoiceTab.listGrid.shipmentCostDetail.startEditingNew();
                }
            }),
            // </sec:authorize>

            // <sec:authorize access="hasAnyAuthority('C_CONTRACT_DETAIL_TYPE_PARAM', 'U_CONTRACT_DETAIL_TYPE_PARAM', 'D_CONTRACT_DETAIL_TYPE_PARAM')">
            isc.ToolStrip.create({

                width: "100%",
                height: 24,
                align: 'left',
                border: 0,
                members: [
                    isc.ToolStripButton.create({

                        icon: "pieces/16/save.png",
                        title: "<spring:message code='global.form.save'/>",
                        click: function () {
                            shipmentCostInvoiceTab.listGrid.shipmentCostDetail.saveAllEdits();
                        }
                    })]
            })
            // </sec:authorize>
        ]
    })],
});

shipmentCostInvoiceTab.window.shipmentCost = new nicico.FormUtil();
shipmentCostInvoiceTab.window.shipmentCost.init(null, '<spring:message code="shipmentCostInvoice.title"/>', isc.VLayout.create({
    width: "100%",
    height: "500",
    align: "center",
    members: [
        shipmentCostInvoiceTab.dynamicForm.shipmentCost,
        shipmentCostInvoiceTab.listGrid.shipmentCostDetail
    ]
}), "1200", "60%");

shipmentCostInvoiceTab.method.newForm = function () {
    shipmentCostInvoiceTab.variable.method = "POST";
    shipmentCostInvoiceTab.window.shipmentCost.justShowForm();
};

//***************************************************** MAINLISTGRID *************************************************

// creator.listGrid.main = isc.ListGrid.nicico.getDefault(creator.listGrid.fields, creator.restDataSource.main, creator.listGrid.criteria);


// shipmentCostInvoiceTab.listGrid.main = isc.ListGrid.create({
//     showFilterEditor: true,
//     canAutoFitFields: true,
//     width: "100%",
//     height: "100%",
//     dataSource: shipmentCostInvoiceTab.restDataSource.shipmentCostInvoice,
//     autoFetchData: true,
//     styleName: 'expandList',
//     alternateRecordStyles: true,
//     canExpandRecords: true,
//     canExpandMultipleRecords: false,
//     wrapCells: false,
//     showRollOver: false,
//     showRecordComponents: true,
//     showRecordComponentsByCell: true,
//     autoFitExpandField: true,
//     virtualScrolling: true,
//     loadOnExpand: true,
//     loaded: false,
//     sortField: 2,
//     fields: shipmentCostInvoiceTab.listGrid.fields,
//     getExpansionComponent: function (record) {
//     }
// });

shipmentCostInvoiceTab.listGrid.fields = [
    {
        name: "id",
        hidden: true
    },
    {
        name: "invoiceDate",
        title: "<spring:message code='shipmentCostInvoice.invoiceDate'/>",

        type: "date",
        width: "10%"
    },
    {
        name: "invoiceNoPaper",
        title: "<spring:message code='shipmentCostInvoice.invoiceNoPaper'/>",
        // sortNormalizer: function (recordObject) {
        //     return recordObject.inspector.nameFA;
        // }
    },
    {
        name: "invoiceType.title",
        title: "<spring:message code='shipmentCostInvoice.invoiceType'/>"
    },
    {
        name: "sellerContact.nameFA",
        title: "<spring:message code='shipmentCostInvoice.sellerContact'/>"
    },
    {
        name: "buyerContact.nameFA",
        title: "<spring:message code='shipmentCostInvoice.buyerContact'/>"
    },
    {
        name: "financeUnit.nameFA",
        title: "<spring:message code='shipmentCostInvoice.financeUnit'/>"
    },
    {
        name: "sumPrice",
        title: "<spring:message code='shipmentCostInvoice.sumPrice'/>"
    },
    {
        name: "sumPriceWithDiscount",
        title: "<spring:message code='shipmentCostInvoice.sumPriceWithDiscount'/>",
    },
    {
        name: "sumPriceWithVat",
        title: "<spring:message code='shipmentCostInvoice.sumPriceWithVat'/>",
    }
];

nicico.BasicFormUtil.createListGrid = function() {

    shipmentCostInvoiceTab.listGrid.main = isc.ListGrid.nicico.getDefault(shipmentCostInvoiceTab.listGrid.fields,
        shipmentCostInvoiceTab.restDataSource.shipmentCostInvoice, null, {
            // showFilterEditor: true,
            // canAutoFitFields: true,
            width: "100%",
            // autoFetchData: true,
            // styleName: 'expandList',
            // alternateRecordStyles: true,
            // canExpandRecords: true,
            // canExpandMultipleRecords: false,
            // wrapCells: false,
            // showRollOver: false,
            // showRecordComponents: true,
            // showRecordComponentsByCell: true,
            // autoFitExpandField: true,
            // virtualScrolling: true,
            // loadOnExpand: true,
            // loaded: false,
            // sortField: 2
        }
    );
};
nicico.BasicFormUtil.getDefaultBasicForm(shipmentCostInvoiceTab, "api/shipmentCostInvoice/");
