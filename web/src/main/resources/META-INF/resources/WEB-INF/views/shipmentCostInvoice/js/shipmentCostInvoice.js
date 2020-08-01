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
shipmentCostInvoiceTab.variable.tVatPercent = 0;
shipmentCostInvoiceTab.variable.cVatPercent = 0;

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
        // alert("data " + JSON.stringify(data[0]))
        shipmentCostInvoiceTab.variable.cVatPercent = data[0].cvat;
        shipmentCostInvoiceTab.variable.tVatPercent = data[0].tvat;
        // console.log("tVatPer " + shipmentCostInvoiceTab.variable.tVatPercent);

    });

};

shipmentCostInvoiceTab.method.updatePriceValues = function () {

    let row = shipmentCostInvoiceTab.listGrid.shipmentCostDetail.getEditRow();
    let record = shipmentCostInvoiceTab.listGrid.shipmentCostDetail.getEditRecord(row);
    let quantity = shipmentCostInvoiceTab.listGrid.shipmentCostDetail.getCellValue(record, row, 3);
    let unitPrice = shipmentCostInvoiceTab.listGrid.shipmentCostDetail.getCellValue(record, row, 4);
    let sumPrice = quantity * unitPrice;
    shipmentCostInvoiceTab.listGrid.shipmentCostDetail.setEditValue(row, 5, sumPrice);

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
        displayField: "title",
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
            }],
        changed: function (form, item, value) {

            switch (value) {
                case 1:
                    form.getItem("referenceId").setOptionDataSource(shipmentCostInvoiceTab.restDataSource.unitRest);
                    break;
                case 2:
                    form.getItem("referenceId").setOptionDataSource(shipmentCostInvoiceTab.restDataSource.contactRest);
                    break;
            }
        }
    },
    {
        name: "referenceId",
        title: "<spring:message code='shipmentCostInvoice.referenceId'/>",
        wrapTitle: false,
        editorType: "SelectItem",
        valueField: "id",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: null
    },
    {
        name: "invoiceDate",
        title: "<spring:message code='shipmentCostInvoice.invoiceDate'/>",
        type: "date",
        wrapTitle: false,
        colSpan: 4,
        changed: function (form, item) {

            shipmentCostInvoiceTab.variable.today = item.getValue();
            shipmentCostInvoiceTab.variable.year = shipmentCostInvoiceTab.variable.today.getFullYear();
            console.log("year / " + JSON.stringify(shipmentCostInvoiceTab.variable.year));
            shipmentCostInvoiceTab.method.setVATs(shipmentCostInvoiceTab.variable.year);
            form.getItem("tVat").setValue(shipmentCostInvoiceTab.variable.tVatPercent);
            form.getItem("cVat").setValue(shipmentCostInvoiceTab.variable.cVatPercent);
            alert("set")

        },
    },
    {
        name: "invoiceNoPaper",
        title: "<spring:message code='shipmentCostInvoice.invoiceNoPaper'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "invoiceNo",
        title: "<spring:message code='shipmentCostInvoice.invoiceNo'/>",
        required: true,
        wrapTitle: false,
        // canEdit: false
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
        required: true,
        wrapTitle: false,
        editorType: "staticText",
        // defaultValue: shipmentCostInvoiceTab.variable.tVatPercent

    },
    {
        name: "cVat",
        title: "<spring:message code='shipmentCostInvoice.cVat'/>",
        required: true,
        wrapTitle: false,
        editorType: "staticText",
        // defaultValue: shipmentCostInvoiceTab.variable.cVatPercent
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
        // required: true,
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
        /*validators: [
            {
                type: "required",
                validateOnChange: true
            }],*/
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
        colSpan: 4,
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
        title: "<spring:message code='shipmentCostInvoice.conversionDate'/>",
        type: "date",
        hidden: true
    },
    {
        name: "conversionRate",
        title: "<spring:message code='shipmentCostInvoice.conversionRate'/>",
        required: true,
        hidden: true,
        defaultValue: 1
    },
    {
        name: "sumPrice",
        title: "<spring:message code='shipmentCostInvoice.sumPrice'/>",
        required: true,
        hidden: true,
    },
    {
        name: "sumPriceWithDiscount",
        title: "<spring:message code='shipmentCostInvoice.sumPriceWithDiscount'/>",
        required: true,
        hidden: true,
    },
    {
        name: "sumPriceWithVat",
        title: "<spring:message code='shipmentCostInvoice.sumPriceWithVat'/>",
        required: true,
        hidden: true,
    },
    {
        name: "rialPrice",
        title: "<spring:message code='shipmentCostInvoice.rialPrice'/>",
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
    width: "100%",
    sortField: 1,
    showRowNumbers: true,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    canEdit: true,
    editEvent: "doubleClick",
    autoSaveEdits: false,
    // saveLocally: true,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    canRemoveRecords: true,
    showGridSummary: true,
    fields: BaseFormItems.concat([
        {
            name: "id",
            hidden: true
        },
        {
            name: "serviceCode",
            title: "<spring:message code='shipmentCostInvoiceDetail.serviceCode'/>",
            type: "text",
            width: "10%"
        },
        {
            name: "serviceName",
            title: "<spring:message code='shipmentCostInvoiceDetail.serviceName'/>",
            required: true,
            type: "text",
            width: "10%"
        },
        {
            name: "quantity",
            title: "<spring:message code='shipmentCostInvoiceDetail.quantity'/>",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "unitPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.unitPrice'/>",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "sumPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPrice'/>",
            type: "float",
            editorType: "staticText",
            width: "10%",
            value: 0
        },
        {
            name: "discountPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.discountPrice'/>",
            type: "float",
            required: true,
            width: "10%"
        },
        {
            name: "sumPriceWithDiscount",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPriceWithDiscount'/>",
            type: "float",
            editorType: "staticText",
            width: "10%",
            value: 0
        },
        {
            name: "tVatPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.tVatPrice'/>",
            type: "float",
            editorType: "staticText",
            width: "10%",
            value: 0
        },
        {
            name: "cVatPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.cVatPrice'/>",
            type: "float",
            editorType: "staticText",
            width: "10%",
            value: 0
        },
        {
            name: "sumPriceWithVat",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPriceWithVat'/>",
            type: "float",
            editorType: "staticText",
            width: "10%",
            value: 0
        },
    ]),
    rowEditorExit: function(editCompletionEvent, record, newValues, rowNum)  {

        if(editCompletionEvent === "enter") {

            let sumPriceIndex = this.fields.indexOf(this.fields.filter(q => q.name === "sumPrice").first());
            let sumPriceWithDiscountIndex = this.fields.indexOf(this.fields.filter(q => q.name === "sumPriceWithDiscount").first());
            let tVatPriceIndex = this.fields.indexOf(this.fields.filter(q => q.name === "tVatPrice").first());
            let cVatPriceIndex = this.fields.indexOf(this.fields.filter(q => q.name === "cVatPrice").first());
            let sumPriceWithVatIndex = this.fields.indexOf(this.fields.filter(q => q.name === "sumPriceWithVat").first());

            let sumPriceValue = newValues.unitPrice * newValues.quantity;
            let sumPriceWithDiscountValue = sumPriceValue - newValues.discountPrice;
            let tVatPriceValue = shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("tVat").getValue() * sumPriceWithDiscountValue /100;
            let cVatPriceValue = shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("cVat").getValue() * sumPriceWithDiscountValue /100;
            let sumPriceWithVatValue = sumPriceWithDiscountValue + tVatPriceValue + cVatPriceValue;

            this.setEditValue(rowNum, sumPriceIndex, sumPriceValue);
            this.setEditValue(rowNum, sumPriceWithDiscountIndex, sumPriceWithDiscountValue);
            this.setEditValue(rowNum, tVatPriceIndex, tVatPriceValue);
            this.setEditValue(rowNum, cVatPriceIndex, cVatPriceValue);
            this.setEditValue(rowNum, sumPriceWithVatIndex, sumPriceWithVatValue);

        }

    },
    gridComponents: ["header", "body", "summaryRow", isc.ToolStrip.create({

        width: "100%",
        height: 24,
        members: [
            isc.ToolStripButton.create({

                icon: "pieces/16/icon_add.png",
                title: "<spring:message code='global.add'/>",
                click: function () {
                    shipmentCostInvoiceTab.listGrid.shipmentCostDetail.startEditingNew();
                }
            }),

            // save Button
            /*isc.ToolStrip.create({

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
            })*/
        ]
    })],
});

shipmentCostInvoiceTab.window.shipmentCost = new nicico.FormUtil();
shipmentCostInvoiceTab.window.shipmentCost.init(null, '<spring:message code="shipmentCostInvoice.title"/>', isc.VLayout.create({
    width: "100%",
    height: "600",
    margin: 20,
    align: "center",
    members: [
        shipmentCostInvoiceTab.dynamicForm.shipmentCost,
        shipmentCostInvoiceTab.listGrid.shipmentCostDetail
    ]
}), "1200", "60%");

shipmentCostInvoiceTab.window.shipmentCost.populateData = function (bodyWidget) {

    //////////////// DynamicForm ///////////////
    var shipmentCostObj = bodyWidget.members.get(0).getValues();

    //////////////// ListGrid //////////////////
    let shipmentCostInvoiceDetails = [];
    let summaryRowData = bodyWidget.members.get(1).members.get(2).getData()[0];

    // bodyWidget.members.get(1).selectAllRecords();
    bodyWidget.members.get(1).getAllEditRows().forEach(function (current) {

        let record = bodyWidget.members.get(1).getEditedRecord(current);
        console.log("record : " + JSON.stringify(record));
        // let shipmentCostDetailObj = record.getValues();
        let shipmentCostDetailObj = {};
        shipmentCostDetailObj.id = record.id;
        shipmentCostDetailObj.serviceCode = record.serviceCode;
        shipmentCostDetailObj.serviceName = record.serviceName;
        shipmentCostDetailObj.quantity = record.quantity;
        shipmentCostDetailObj.unitPrice = record.unitPrice;
        shipmentCostDetailObj.sumPrice = record.sumPrice;
        shipmentCostDetailObj.discountPrice = record.discountPrice;
        shipmentCostDetailObj.sumPriceWithDiscount = record.sumPriceWithDiscount;
        shipmentCostDetailObj.tVatPrice = record.tVatPrice;
        shipmentCostDetailObj.cVatPrice = record.cVatPrice;
        shipmentCostDetailObj.sumVatPrice = record.sumVatPrice;
        shipmentCostDetailObj.sumPriceWithVat = record.sumPriceWithVat;
        shipmentCostDetailObj.shipmentCostInvoiceId = record.shipmentCostInvoiceId;

        console.log("shipmentCostDetailObj" + JSON.stringify(shipmentCostDetailObj));
        shipmentCostInvoiceDetails.push(shipmentCostDetailObj);

    });

    shipmentCostObj.sumPrice = summaryRowData.sumPrice;
    shipmentCostObj.sumPriceWithDiscount = summaryRowData.sumPriceWithDiscount;
    shipmentCostObj.sumPriceWithVat = summaryRowData.sumPriceWithVat;
    shipmentCostObj.shipmentCostInvoiceDetails = shipmentCostInvoiceDetails;
    console.log("shipmentCostObj" + JSON.stringify(shipmentCostObj));
    return shipmentCostObj;
};

shipmentCostInvoiceTab.window.shipmentCost.validate = function (data) {

    shipmentCostInvoiceTab.dynamicForm.shipmentCost.validate();
    if (shipmentCostInvoiceTab.dynamicForm.shipmentCost.hasErrors())
        return false;

    return true;
};

shipmentCostInvoiceTab.window.shipmentCost.okCallBack = function (shipmentCostObj) {

    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/shipmentCostInvoice",
            httpMethod: shipmentCostInvoiceTab.variable.method,
            data: JSON.stringify(shipmentCostObj),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    shipmentCostInvoiceTab.method.refreshData();
                    shipmentCostInvoiceTab.window.shipmentCost.close();
                } else
                    isc.say(RpcResponse_o.data);
            }
        })
    );

};

shipmentCostInvoiceTab.method.newForm = function () {
    shipmentCostInvoiceTab.variable.method = "POST";
    shipmentCostInvoiceTab.window.shipmentCost.justShowForm();
};

//***************************************************** MAINLISTGRID *************************************************

/*shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain = isc.ListGrid.create(
        {
            showFilterEditor: true,
            canAutoFitFields: true,
            width: "100%",
            styleName: "listgrid-child",
            height: 180,
            dataSource: shipmentCostInvoiceTab.restDataSource.shipmentCostInvoiceDetail,
            autoFetchData: false,
            setAutoFitExtraRecords: true,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            fields: [
                {
                    name: "id",
                    hidden: true,
                    primaryKey: true
                },
                {
                    name: "serviceCode",
                    width: "10%",
                },
                {
                    name: "serviceName",
                    width: "10%"
                },
                {
                    name: "quantity",
                    width: "10%"
                },
                {
                    name: "unitPrice",
                    width: "10%"
                },
                {
                    name: "sumPrice",
                    width: "10%"
                },
                {
                    name: "sumPriceWithVat",
                    width: "10%"
                },
                {
                    name: "shipmentCostInvoiceId",
                    type: "long",
                    hidden: true,
                },
                {
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
                }
            ],
            recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                loadWindowFeatureList(record.shipmentCostInvoiceId)
            },
            /!*createRecordComponent: function (record, colNum) {
                var fieldName = this.getFieldName(colNum);
                var recordCanvas = isc.HLayout.create(
                    {
                        height: 22,
                        width: "100%",
                        align: "center"
                    });
                if (fieldName == "editIcon") {
                    var editImg = isc.ImgButton.create(
                        {
                            showDown: false,
                            showRollOver: false,
                            layoutAlign: "center",
                            src: "pieces/16/icon_edit.png",
                            prompt: "ویرایش",
                            height: 16,
                            width: 16,
                            grid: this,
                            click: function () {
                                ListGrid_InvoiceSalesItem.selectSingleRecord(record);
                                ListGrid_InvoiceSalesItem_edit();
                            }
                        });
                    return editImg;
                }
                else if (fieldName == "removeIcon") {
                    var removeImg = isc.ImgButton.create(
                        {
                            showDown: false,
                            showRollOver: false,
                            layoutAlign: "center",
                            src: "pieces/16/icon_delete.png",
                            prompt: "حذف",
                            height: 16,
                            width: 16,
                            grid: this,
                            click: function () {
                                ListGrid_InvoiceSalesItem.selectSingleRecord(record);
                                ListGrid_InvoiceSalesItem_remove();
                            }
                        });
                    return removeImg;
                }
                else {
                    return null;
                }
            }*!/

        });

shipmentCostInvoiceTab.vLayout.shipmentCostDetailMainBody = isc.VLayout.create({
    width: "100%",
    height: "100%",
    members: [
        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain
    ]
});*/

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

nicico.BasicFormUtil.createListGrid = function () {

    shipmentCostInvoiceTab.listGrid.main = isc.ListGrid.nicico.getDefault(shipmentCostInvoiceTab.listGrid.fields,
        shipmentCostInvoiceTab.restDataSource.shipmentCostInvoice, null, {
            width: "100%",
            // autoFetchData: true,
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
            /*getExpansionComponent: function (record) {

                let expansionCriteria = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "shipmentCostInvoiceId", operator: "equals", value: record.id}]
                };

                shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.fetchData(expansionCriteria, function (dsResponse, data, dsRequest) {
                    if (data.length == 0) {
                        recordNotFound.show();
                        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.hide()
                    } else {
                        recordNotFound.hide();
                        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.setData(data);
                        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.setAutoFitMaxRecords(1);
                        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.show();
                    }
                }, {operationId: "00"});

            }*/
        }
    );
};

/*isc.SectionStack.create(
        {
            sections: [
                {
                    title: "<spring:message code='shipmentCostInvoice.title'/>",
                    items: shipmentCostInvoiceTab.vLayout.main,
                    showHeader: false,
                    expanded: true
                },
                {
                    title: "<spring:message code='shipmentCostInvoiceDetail.title'/>",
                    hidden: true,
                    items: shipmentCostInvoiceTab.vLayout.shipmentCostDetailMainBody,
                    expanded: false
                }],
            visibilityMode: "multiple",
            animateSections: true,
            height: "100%",
            width: "100%",
            overflow: "hidden"
        });*/

nicico.BasicFormUtil.getDefaultBasicForm(shipmentCostInvoiceTab, "api/shipmentCostInvoice/");
