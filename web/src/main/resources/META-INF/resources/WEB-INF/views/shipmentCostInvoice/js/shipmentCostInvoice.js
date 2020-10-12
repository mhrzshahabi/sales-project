//******************************************************* VARIABLES ****************************************************

var shipmentCostInvoiceTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

shipmentCostInvoiceTab.variable.invoiceTypeUrl = "${contextPath}" + "/api/invoicetype/";
shipmentCostInvoiceTab.variable.contactUrl = "${contextPath}" + "/api/contact/";
shipmentCostInvoiceTab.variable.unitUrl = "${contextPath}" + "/api/unit/";
shipmentCostInvoiceTab.variable.conversionRefUrl = "${contextPath}" + "/api/currencyRate/";
shipmentCostInvoiceTab.variable.shipmentCostInvoice = "${contextPath}" + "/api/shipmentCostInvoice/";
shipmentCostInvoiceTab.variable.shipmentCostInvoiceDetail = "${contextPath}" + "/api/shipmentCostInvoiceDetail/";
shipmentCostInvoiceTab.variable.percentPerYearRest = "${contextPath}" + "/api/percentPerYear/";
shipmentCostInvoiceTab.variable.inspectionReportUrl = "${contextPath}" + "/api/inspectionReport/";
shipmentCostInvoiceTab.variable.contractUrl = "${contextPath}" + "/api/contract/";
shipmentCostInvoiceTab.variable.shipmentUrl = "${contextPath}" + "/api/shipment/";
shipmentCostInvoiceTab.variable.shipmentCostDuty = "${contextPath}" + "/api/costDuty/";
shipmentCostInvoiceTab.variable.billOfLandingUrl = "${contextPath}" + "/api/bill-of-landing/";

shipmentCostInvoiceTab.variable.today = new Date();
shipmentCostInvoiceTab.variable.year = shipmentCostInvoiceTab.variable.today.getFullYear();
shipmentCostInvoiceTab.variable.tVatPercent = 0;
shipmentCostInvoiceTab.variable.cVatPercent = 0;
shipmentCostInvoiceTab.variable.financeUnitName = "";
shipmentCostInvoiceTab.variable.summaryRowData = {};

//***************************************************** RESTDATASOURCE *************************************************

shipmentCostInvoiceTab.restDataSource.shipmentRest = isc.MyRestDataSource.create({
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
    fetchDataURL: shipmentCostInvoiceTab.variable.shipmentUrl + "spec-list"
});

shipmentCostInvoiceTab.restDataSource.shipmentCostDutyRest = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {
            name: "name",
            title: "<spring:message code='shipmentCostInvoiceDetail.serviceName'/>",
            type: 'text'
        },
        {name: "code", title: "<spring:message code='shipmentCostInvoiceDetail.serviceCode'/>", type: 'text'}
    ],
    fetchDataURL: shipmentCostInvoiceTab.variable.shipmentCostDuty + "spec-list"
});

shipmentCostInvoiceTab.restDataSource.contactRest = isc.MyRestDataSource.create({
    fields: [
        {name: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
        {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
        {name: "name"},
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
        {name: "name"},
    ],
    fetchDataURL: shipmentCostInvoiceTab.variable.unitUrl + "spec-list"

});

shipmentCostInvoiceTab.restDataSource.conversionRefRest = isc.MyRestDataSource.create({
    fields: [
        {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
        {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
        {name: "currencyDate", title: "<spring:message code='global.date'/>"},
        {name: "unitFrom", title: "<spring:message code='global.from'/>"},
        {name: "unitFromId", title: "<spring:message code='global.from'/>"},
        {name: "unitTo", title: "<spring:message code='global.to'/>"},
        {name: "unitToId", title: "<spring:message code='global.to'/>"},
        {name: "currencyRateValue"}
    ],
    fetchDataURL: shipmentCostInvoiceTab.variable.conversionRefUrl + "spec-list"
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
            name: "sumPrice",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoice.sumPrice'/>"
        },
        {
            name: "sumPriceWithDiscount",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoice.sumPriceWithDiscount'/>"
        },
        {
            name: "sumPriceWithVat",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoice.sumPriceWithVat'/>"
        },
        {
            name: "rialPrice",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoice.rialPrice'/>"
        },
        {
            name: "conversionDate", title: "<spring:message code='shipmentCostInvoice.conversionDate'/>"
        },
        {
            name: "conversionRate", title: "<spring:message code='shipmentCostInvoice.conversionRate'/>"
        },
        {
            name: "conversionSumPrice",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoice.conversionSumPrice'/>"
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
            name: "shipment", title: "<spring:message code='shipmentCostInvoice.shipment'/>"
        },
        {
            name: "invoiceType.title", title: "<spring:message code='shipmentCostInvoice.shipment'/>"
        },
        {
            name: "sellerContact.name", title: "<spring:message code='shipmentCostInvoice.shipment'/>"
        },
        {
            name: "buyerContact.name", title: "<spring:message code='shipmentCostInvoice.shipment'/>"
        },
        {
            name: "financeUnit.name", title: "<spring:message code='shipmentCostInvoice.shipment'/>"
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
            name: "quantity", title: "<spring:message code='shipmentCostInvoiceDetail.quantity'/>"
        },
        {
            name: "unitPrice",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoiceDetail.unitPrice'/>",
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
        },
        {
            name: "sumPrice",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPrice'/>",
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            }
        },
        {
            name: "discountPrice",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoiceDetail.discountPrice'/>",
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            }
        },
        {
            name: "sumPriceWithDiscount",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPriceWithDiscount'/>",
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            }
        },
        {
            name: "tVatPrice",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoiceDetail.tVatPrice'/>",
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
        },
        {
            name: "cVatPrice",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoiceDetail.cVatPrice'/>",
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            }
        },
        {
            name: "sumVatPrice",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumVatPrice'/>",
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            }
        },
        {
            name: "sumPriceWithVat",
            type: "float",
            format: "#.##",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPriceWithVat'/>",
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
        },
        {
            name: "shipmentCostInvoiceId", title: "<spring:message code='global.id'/>"
        },
        {
            name: "shipmentCostDutyId", title: "<spring:message code='global.id'/>"
        },
        {
            name: "shipmentCostDuty.name", title: "<spring:message code='shipmentCostInvoiceDetail.serviceName'/>"
        },
        {
            name: "shipmentCostDuty.code", title: "<spring:message code='shipmentCostInvoiceDetail.serviceCode'/>"
        },
        {
            name: "unit.name", title: "<spring:message code=''/>"
        },
        {
            name: "unitId", title: "<spring:message code='global.id'/>"
        }
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

shipmentCostInvoiceTab.variable.sellerCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Seller"}]
};
shipmentCostInvoiceTab.variable.buyerCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "commercialRole", operator: "iContains", value: "Buyer"}]
};
shipmentCostInvoiceTab.variable.financeUnitCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "categoryUnit", operator: "equals", value: 1}]
};
shipmentCostInvoiceTab.variable.notFinanceUnitCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "categoryUnit", operator: "notEqual", value: 1}]
};
shipmentCostInvoiceTab.variable.costTypeCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [
        {fieldName: "id", operator: "notEqual", value: ImportantIDs.invoiceType.PERFORMA},
        {fieldName: "id", operator: "notEqual", value: ImportantIDs.invoiceType.PROVISIONAL},
        {fieldName: "id", operator: "notEqual", value: ImportantIDs.invoiceType.FINAL},
        {fieldName: "id", operator: "notEqual", value: ImportantIDs.invoiceType.PI_TRUSTY},
        {fieldName: "id", operator: "notEqual", value: ImportantIDs.invoiceType.FI_TRUSTY}
    ]
};


//***************************************************** FUNCTIONS *************************************************

shipmentCostInvoiceTab.method.setVATs = function (year) {

    let percentCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "year", operator: "equals", value: year}]
    };

    shipmentCostInvoiceTab.restDataSource.percentPerYearRest.fetchData(percentCriteria, function (dsResponse, data, dsRequest) {

        shipmentCostInvoiceTab.variable.cVatPercent = data[0].cvat;
        shipmentCostInvoiceTab.variable.tVatPercent = data[0].tvat;

        shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("tvat").setValue(shipmentCostInvoiceTab.variable.tVatPercent);
        shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("cvat").setValue(shipmentCostInvoiceTab.variable.cVatPercent);

    });

};

shipmentCostInvoiceTab.method.toLocalLetters = function(nbmr){
    return (languageForm.getValue("languageName") == 'en') ? numberToEnglish(nbmr) : String(nbmr).toPersianLetter();
};

// shipmentCostInvoiceTab.method.updateFinanceUnit = function () {
//
//     shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionRefId").canEdit = true;
//     if (!shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getValue("financeUnitId")) return;
//
//     console.log("here1 ", shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getValue("financeUnitId"));
//     console.log("here2 ", shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getValue("toFinanceUnitId"));
//     if (shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getValue("financeUnitId") === shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getValue("toFinanceUnitId")) {
//         shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionRate", 1);
//         shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionRefId").canEdit = false;
//         shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(2).members.get(0).click();
//     }
// };

shipmentCostInvoiceTab.method.clearListGrid = function () {

    shipmentCostInvoiceTab.listGrid.shipmentCostDetail.setData([]);
    shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(1).setContents("");
    shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionSumPrice").setValue(null);
    shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionSumPriceText").setValue(null);
    shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionSumPriceBuyerShare").setValue(null);
    shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionSumPriceSellerShare").setValue(null);

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
        optionCriteria: shipmentCostInvoiceTab.variable.costTypeCriteria,
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
            form.getItem("referenceId").setValue(null);
            let referenceIdFetchDataURL = "";
            let referenceIdPickListFields = [];
            switch (value) {
                case ImportantIDs.invoiceType.INSPECTION:
                    form.getItem("referenceId").show();
                    form.getItem("referenceId").displayField = "inspectionNO";
                    referenceIdPickListFields = [
                        {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                        {name: "inspectionNO", title: "<spring:message code='inspectionReport.InspectionNO'/>"},
                        {name: "inspector.name", title: "<spring:message code='inspectionReport.inspectorId'/>"},
                    ];
                    referenceIdFetchDataURL = shipmentCostInvoiceTab.variable.inspectionReportUrl + "spec-list";
                    break;
                case ImportantIDs.invoiceType.INSURANCE:
                    form.getItem("referenceId").setOptionDataSource(null);
                    form.getItem("referenceId").hide();
                    break;
                case ImportantIDs.invoiceType.THC:
                    form.getItem("referenceId").show();
                    form.getItem("referenceId").displayField = "documentNo";
                    referenceIdPickListFields = [
                        {
                            name: "documentNo", title: "<spring:message code='billOfLanding.document.no'/>"
                        },
                        {
                            name: "shipperExporter.name",
                            title: "<spring:message code='billOfLanding.shipper.exporter'/>"
                        },
                        {
                            name: "consignee.name", title: "<spring:message code='billOfLanding.consignee'/>"
                        }
                    ];
                    referenceIdFetchDataURL = shipmentCostInvoiceTab.variable.billOfLandingUrl + "spec-list";
                    break;
                case ImportantIDs.invoiceType.BLFEE:
                    form.getItem("referenceId").show();
                    form.getItem("referenceId").displayField = "documentNo";
                    referenceIdPickListFields = [
                        {
                            name: "documentNo", title: "<spring:message code='billOfLanding.document.no'/>"
                        },
                        {
                            name: "shipperExporter.name",
                            title: "<spring:message code='billOfLanding.shipper.exporter'/>"
                        },
                        {
                            name: "consignee.name", title: "<spring:message code='billOfLanding.consignee'/>"
                        }
                    ];
                    referenceIdFetchDataURL = shipmentCostInvoiceTab.variable.billOfLandingUrl + "spec-list";
                    break;
                case ImportantIDs.invoiceType.UMPIRELAB:
                    form.getItem("referenceId").setOptionDataSource(null);
                    form.getItem("referenceId").hide();
                    break;
                case ImportantIDs.invoiceType.DEMAND:
                    form.getItem("referenceId").setOptionDataSource(null);
                    form.getItem("referenceId").hide();
                    break;
                case ImportantIDs.invoiceType.FREIGHT:
                    form.getItem("referenceId").setOptionDataSource(null);
                    form.getItem("referenceId").hide();
                    break;
                case ImportantIDs.invoiceType.DISPATCH:
                    form.getItem("referenceId").setOptionDataSource(null);
                    form.getItem("referenceId").hide();
                    break;
                case ImportantIDs.invoiceType.DEMURRAGE:
                    form.getItem("referenceId").setOptionDataSource(null);
                    form.getItem("referenceId").hide();
                    break;
                default:
                    break;
            }

            let referenceIdField = form.getItem("referenceId");
            referenceIdField.setOptionDataSource(isc.MyRestDataSource.create({
                fields: referenceIdPickListFields,
                fetchDataURL: referenceIdFetchDataURL
            }));
            referenceIdField.pickListFields = referenceIdPickListFields;
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
        name: "shipmentId",
        title: "<spring:message code='Shipment.title'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        colSpan: 4,
        valueField: "id",
        displayField: "bookingCat",
        pickListWidth: 500,
        pickListHeight: 300,
        optionDataSource: shipmentCostInvoiceTab.restDataSource.shipmentRest,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true},
            {name: "sendDate", width: 100},
            {name: "bookingCat"},
            {name: "contractShipment.contract.no"},
            {name: "material.descEN"}
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "invoiceDate",
        title: "<spring:message code='shipmentCostInvoice.invoiceDate'/>",
        required: true,
        type: "date",
        wrapTitle: false,
        colSpan: 4,
        changed: function (form, item) {

            shipmentCostInvoiceTab.variable.today = item.getValue();
            shipmentCostInvoiceTab.variable.year = shipmentCostInvoiceTab.variable.today.getFullYear();
            shipmentCostInvoiceTab.method.setVATs(shipmentCostInvoiceTab.variable.year);
            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getField("conversionRefId").clearValue();
            shipmentCostInvoiceTab.method.clearListGrid();
        },
    },
    {
        name: "invoiceNo",
        title: "<spring:message code='shipmentCostInvoice.invoiceNo'/>",
        required: true,
        wrapTitle: false,
        editorType: "staticText",
        hidden: true,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        value: 1
    },
    {
        name: "invoiceNoPaper",
        title: "<spring:message code='shipmentCostInvoice.invoiceNoPaper'/>",
        required: true,
        type: 'text',
        wrapTitle: false,
        colSpan: 4,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "sellerContactId",
        title: "<spring:message code='shipmentCostInvoice.sellerContact'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "name",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: shipmentCostInvoiceTab.restDataSource.contactRest,
        optionCriteria: shipmentCostInvoiceTab.variable.sellerCriteria,
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
        displayField: "name",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: shipmentCostInvoiceTab.restDataSource.contactRest,
        optionCriteria: shipmentCostInvoiceTab.variable.buyerCriteria,
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
        name: "tvat",
        title: "<spring:message code='shipmentCostInvoice.tVat'/>",
        required: true,
        wrapTitle: false,
        type: "float",
        editorType: "staticText",
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "cvat",
        title: "<spring:message code='shipmentCostInvoice.cVat'/>",
        required: true,
        wrapTitle: false,
        type: "float",
        editorType: "staticText",
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "financeUnitId",
        title: "<spring:message code='shipmentCostInvoice.financeUnit'/>",
        required: true,
        wrapTitle: false,
        type: 'long',
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "name",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: shipmentCostInvoiceTab.restDataSource.unitRest,
        optionCriteria: shipmentCostInvoiceTab.variable.financeUnitCriteria,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "nameFA",
                title: "<spring:message code='unit.nameFa'/>",
                align: "center"
            },
            {
                name: "nameEN",
                title: "<spring:message code='unit.nameEN'/>",
                align: "center"
            },
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item) {

            shipmentCostInvoiceTab.variable.financeUnitName = item.getSelectedRecord().name;
            shipmentCostInvoiceTab.dynamicForm.shipmentCost.setValue("toFinanceUnitId", null);
            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionRefId", null);
            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionRate", 1);
            shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(2).members.get(0).click();
        }
    },
    {
        name: "toFinanceUnitId",
        title: "<spring:message code='shipmentCostInvoice.toFinanceUnit'/>",
        wrapTitle: false,
        type: 'long',
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "name",
        pickListWidth: "500",
        pickListHeight: "300",
        optionDataSource: shipmentCostInvoiceTab.restDataSource.unitRest,
        optionCriteria: shipmentCostInvoiceTab.variable.financeUnitCriteria,
        pickListProperties:
            {
                showFilterEditor: true
            },
        pickListFields: [
            {
                name: "nameFA",
                title: "<spring:message code='unit.nameFa'/>",
                align: "center"
            },
            {
                name: "nameEN",
                title: "<spring:message code='unit.nameEN'/>",
                align: "center"
            },
        ],
        changed: function (form, item, value) {

            let toDate = form.getItem("invoiceDate").getValue().duplicate();
            toDate.setHours(23);
            toDate.setMinutes(59);
            toDate.setSeconds(59);
            let fromDate = form.getItem("invoiceDate").getValue().duplicate();
            fromDate.setHours(0);
            fromDate.setMinutes(0);
            fromDate.setSeconds(0);
            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getField("conversionRefId").setOptionCriteria({
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria:
                    [
                        {
                            fieldName: "currencyDate",
                            operator: "lessOrEqual",
                            value: toDate.toString()
                        },
                        {
                            fieldName: "currencyDate",
                            operator: "greaterOrEqual",
                            value: fromDate.toString()
                        },
                        {
                            fieldName: "unitFromId",
                            operator: "equals",
                            value: form.getItem("financeUnitId").getValue()
                        },
                        {
                            fieldName: "unitToId",
                            operator: "equals",
                            value: item.getValue()
                        }
                    ]
            });
            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionRefId", null);
            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionRefId").enable();
            if (value === form.getItem("financeUnitId").getValue()) {
                item.setValue(null);
                shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionRate", 1);
                shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionRefId").disable();
                shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(2).members.get(0).click();
            }
        }
    },
    {
        type: "RowSpacerItem"
    }

]);
shipmentCostInvoiceTab.dynamicForm.shipmentCost = isc.DynamicForm.create({
    align: "center",
    numCols: 4,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: shipmentCostInvoiceTab.dynamicForm.fields
});
shipmentCostInvoiceTab.dynamicForm.shipmentPriceFields = BaseFormItems.concat([
    {
        name: "conversionRefId",
        title: "<spring:message code='shipmentCostInvoice.conversionRef'/>",
        wrapTitle: false,
        type: 'long',
        colSpan: 4,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "currencyRateValue",
        pickListWidth: 370,
        pickListHeight: 300,
        optionDataSource: shipmentCostInvoiceTab.restDataSource.conversionRefRest,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
            {name: "currencyDate", type: "date", title: "<spring:message code='global.date'/>"},
            {name: "unitFrom.name", title: "<spring:message code='global.from'/>"},
            {name: "unitTo.name", title: "<spring:message code='global.to'/>"},
            {name: "currencyRateValue", title: "<spring:message code='rate.title'/>"}
        ],
        changed: function (form, item, value) {
            let currencyRateValue = item.getSelectedRecord().currencyRateValue;
            let currencyDateValue = item.getSelectedRecord().currencyDate;
            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionRate", currencyRateValue);
            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionDate", currencyDateValue);
            shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(2).members.get(0).click();
        }
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
        type: 'float',
        hidden: true,
        defaultValue: 1
    },
    {
        name: "sumPrice",
        title: "<spring:message code='shipmentCostInvoice.sumPrice'/>",
        required: true,
        type: 'float',
        format: "#.##",
        hidden: true,
        formatValue: function (value, record, form, item) {

            if (value)
                return value;

            return "";
        }
    },
    {
        name: "sumPriceWithDiscount",
        title: "<spring:message code='shipmentCostInvoice.sumPriceWithDiscount'/>",
        required: true,
        type: 'float',
        format: "#.##",
        hidden: true,
        formatValue: function (value, record, form, item) {

            if (value)
                return value;

            return "";
        }
    },
    {
        name: "sumPriceWithVat",
        title: "<spring:message code='shipmentCostInvoice.sumPriceWithVat'/>",
        required: true,
        type: 'float',
        format: "#.##",
        hidden: true,
        formatValue: function (value, record, form, item) {

            if (value)
                return value;

            return "";
        }
    },
    {
        name: "rialPrice",
        title: "<spring:message code='shipmentCostInvoice.rialPrice'/>",
        type: 'float',
        format: "#.##",
        wrapTitle: false,
        colSpan: 4,
        formatValue: function (value, record, form, item) {

            if (value)
                return value;

            return "";
        }
    },
    {
        name: "conversionSumPrice",
        title: "<spring:message code='shipmentCostInvoice.conversionSumPrice'/>",
        required: true,
        type: 'float',
        format: "#.##",
        wrapTitle: false,
        editorType: "staticText",
        validators: [
            {
                type: "isFloat",
                validateOnChange: true
            }],
        formatValue: function (value, record, form, item) {

            if (value)
                return value;

            return "";
        }
    },
    {
        name: "conversionSumPriceText",
        title: "<spring:message code='shipmentCostInvoice.conversionSumPriceText'/>",
        required: true,
        wrapTitle: false,
        editorType: "staticText",
        formatValue: function (value, record, form, item) {

            if (value)
                return value;

            return "";
        }
    },
    {
        name: "buyerShare",
        title: "<spring:message code='shipmentCostInvoice.buyerShare'/>",
        type: "float",
        required: true,
        wrapTitle: false,
        hint: "for 20% Just Enter 20",
        showHintInField: true,
        colSpan: 4,
        validators: [
            {
                type: "required",
                validateOnChange: true
            },
            {
                type: "isFloat",
                validateOnChange: true
            }],
        formatValue: function (value, record, form, item) {

            if (value)
                return value;

            return "";
        },
        changed: function () {
            shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(2).members.get(0).click();
        }
    },
    {
        name: "conversionSumPriceBuyerShare",
        title: "<spring:message code='shipmentCostInvoice.conversionSumPriceBuyerShare'/>",
        required: true,
        type: 'float',
        format: "#.##",
        wrapTitle: false,
        editorType: "staticText",
        validators: [
            {
                type: "isFloat",
                validateOnChange: true
            }],
        formatValue: function (value, record, form, item) {

            if (value)
                return value;

            return "";
        }
    },
    {
        name: "conversionSumPriceSellerShare",
        title: "<spring:message code='shipmentCostInvoice.conversionSumPriceSellerShare'/>",
        required: true,
        type: 'float',
        format: "#.##",
        wrapTitle: false,
        editorType: "staticText",
        validators: [{
            type: "isFloat",
            validateOnChange: true
        }],
        formatValue: function (value, record, form, item) {

            if (value)
                return value;

            return "";
        }
    },
    {
        name: "description",
        title: "<spring:message code='shipmentCostInvoice.description'/>",
        width: "100%",
        colSpan: 4,
        type: "textArea",
        wrapTitle: false
    }

]);
shipmentCostInvoiceTab.dynamicForm.shipmentPrice = isc.DynamicForm.create({
    align: "center",
    numCols: 4,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: shipmentCostInvoiceTab.dynamicForm.shipmentPriceFields,
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
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    canRemoveRecords: true,
    showGridSummary: true,
    fields: BaseFormItems.concat([
        {
            name: "shipmentCostDutyId",
            title: "<spring:message code='shipmentCostInvoiceDetail.service'/>",
            required: true,
            wrapTitle: false,
            editorType: "SelectItem",
            valueField: "id",
            pickListWidth: "500",
            pickListHeight: "300",
            displayField: "name",
            optionDataSource: shipmentCostInvoiceTab.restDataSource.shipmentCostDutyRest,
            pickListProperties:
                {
                    showFilterEditor: true
                },
            pickListFields: [
                {name: "name", align: "center"},
                {name: "code", align: "center"},
            ]
        },
        {
            name: "quantity",
            title: "<spring:message code='shipmentCostInvoiceDetail.quantity'/>",
            type: "float",
            required: true,
            width: "10%",
            showHover: true,
             editorProperties: {
                keyPressFilter: "[0-9]",
            },
        },
        {
            name: "unitId",
            title: "<spring:message code='MaterialFeature.unit'/>",
            required: true,
            wrapTitle: false,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "name",
            pickListWidth: "500",
            pickListHeight: "300",
            optionDataSource: shipmentCostInvoiceTab.restDataSource.unitRest,
            optionCriteria: shipmentCostInvoiceTab.variable.notFinanceUnitCriteria,
            pickListProperties:
                {
                    showFilterEditor: true
                },
            pickListFields: [
                {
                    name: "nameFA",
                    title: "<spring:message code='unit.nameFa'/>",
                    align: "center"
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='unit.nameEN'/>",
                    align: "center"
                }
            ],
             editorProperties: {
                keyPressFilter: "[0-9.]",
            }
        },
        {
            name: "unitPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.unitPrice'/>",
            type: "float",
            format: "#.##",
            required: true,
            width: "10%",
            showHover: true,
            editorProperties: {
                keyPressFilter: "[0-9.]",
            },
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
        },
        {
            name: "sumPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPrice'/>",
            type: "float",
            format: "#.##",
            editorType: "staticText",
            width: "10%",
            showHover: true,
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
            // value: 0
        },
        {
            name: "discountPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.discountPrice'/>",
            type: "float",
            format: "#.##",
            required: true,
            showHover: true,
             editorProperties: {
                keyPressFilter: "[0-9.]",
            },
            width: "10%",
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
        },
        {
            name: "sumPriceWithDiscount",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPriceWithDiscount'/>",
            type: "float",
            editorType: "staticText",
            width: "10%",
            showHover: true,
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
            // value: 0
        },
        {
            name: "tvatPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.tVatPrice'/>",
            type: "float",
            format: "#.##",
            editorType: "staticText",
            width: "10%",
            showHover: true,
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
            // value: 0
        },
        {
            name: "cvatPrice",
            title: "<spring:message code='shipmentCostInvoiceDetail.cVatPrice'/>",
            type: "float",
            editorType: "staticText",
            width: "10%",
            showHover: true,
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
            // value: 0
        },
        {
            name: "sumVatPrice",
            type: "float",
            format: "#.##",
            hidden: true,
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
        },
        {
            name: "sumPriceWithVat",
            title: "<spring:message code='shipmentCostInvoiceDetail.sumPriceWithVat'/>",
            type: "float",
            format: "#.##",
            editorType: "staticText",
            width: "10%",
            showHover: true,
            formatCellValue: function (value, record, rowNum, colNum) {
                if (!value)
                    return value;

                return value + "";
            },
            // value: 0
        },
    ]),
    rowEditorExit: function (editCompletionEvent, record, newValues, rowNum) {

        if (editCompletionEvent !== "escape") {

            let sumPriceIndex = this.fields.indexOf(this.fields.filter(q => q.name === "sumPrice").first());
            let sumPriceWithDiscountIndex = this.fields.indexOf(this.fields.filter(q => q.name === "sumPriceWithDiscount").first());
            let tVatPriceIndex = this.fields.indexOf(this.fields.filter(q => q.name === "tvatPrice").first());
            let cVatPriceIndex = this.fields.indexOf(this.fields.filter(q => q.name === "cvatPrice").first());
            let sumPriceWithVatIndex = this.fields.indexOf(this.fields.filter(q => q.name === "sumPriceWithVat").first());

            var recordData = newValues;
            if (record != null) {
                recordData = Object.assign(record, newValues);
            }
            let sumPriceValue = recordData.unitPrice * recordData.quantity;
            let sumPriceWithDiscountValue = sumPriceValue - recordData.discountPrice;
            let tVatPriceValue = shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("tvat").getValue() * sumPriceWithDiscountValue / 100;
            let cVatPriceValue = shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("cvat").getValue() * sumPriceWithDiscountValue / 100;
            let sumPriceWithVatValue = sumPriceWithDiscountValue + tVatPriceValue + cVatPriceValue;

            this.setEditValue(rowNum, sumPriceIndex, sumPriceValue);
            this.setEditValue(rowNum, sumPriceWithDiscountIndex, sumPriceWithDiscountValue);
            this.setEditValue(rowNum, tVatPriceIndex, tVatPriceValue);
            this.setEditValue(rowNum, cVatPriceIndex, cVatPriceValue);
            this.setEditValue(rowNum, sumPriceWithVatIndex, sumPriceWithVatValue);

            shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(2).members.get(0).click();
        }

    },
    gridComponents: ["header", "body", "summaryRow", isc.ToolStrip.create({

        width: "100%",
        height: 24,
        members: [
            // add Button
            isc.ToolStripButton.create({

                icon: "pieces/16/icon_add.png",
                title: "<spring:message code='global.add'/>",
                click: function () {
                    shipmentCostInvoiceTab.listGrid.shipmentCostDetail.startEditingNew({financeUnitId: shipmentCostInvoiceTab.variable.financeUnitName});
                }
            }),
            // price Label
            isc.Label.create({
                width: 600,
                marginRight: 40,
                marginLeft: 40,
                align: "center",
                contents: ""
            }),
            // save Button
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

                            shipmentCostInvoiceTab.variable.summaryRowData = shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(2).getData()[0];
                            var rate = shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionRate").getValue();
                            var share = shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("buyerShare").getValue();
                            if (rate == null)
                                rate = 1;
                            var conversionSumPrice = shipmentCostInvoiceTab.variable.summaryRowData.sumPriceWithVat * rate;
                            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionSumPrice", conversionSumPrice);
                            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionSumPriceText", shipmentCostInvoiceTab.method.toLocalLetters(conversionSumPrice));
                            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionSumPriceBuyerShare", conversionSumPrice * share / 100);
                            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.setValue("conversionSumPriceSellerShare", conversionSumPrice * (100 - share) / 100);
                            shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(1).setContents(shipmentCostInvoiceTab.method.toLocalLetters(shipmentCostInvoiceTab.variable.summaryRowData.sumPriceWithVat));
                        }
                    })]
            })
        ]
    })],
});

shipmentCostInvoiceTab.window.shipmentCost = new nicico.FormUtil();

shipmentCostInvoiceTab.window.shipmentCost.init(null, '<spring:message code="shipmentCostInvoice.title"/>', isc.VLayout.create({
    width: "100%",
    height: "750",
    margin: 20,
    align: "center",
    members: [
        shipmentCostInvoiceTab.dynamicForm.shipmentCost,
        shipmentCostInvoiceTab.listGrid.shipmentCostDetail,
        shipmentCostInvoiceTab.dynamicForm.shipmentPrice
    ]
}), "1200", "60%");

shipmentCostInvoiceTab.window.shipmentCost.populateData = function (bodyWidget) {
    //////////////// DynamicForm ///////////////
    var shipmentCostObj = Object.assign(bodyWidget.members.get(0).getValues(), bodyWidget.members.get(2).getValues());
    //////////////// ListGrid //////////////////
    let shipmentCostInvoiceDetails = [];
    bodyWidget.members.get(1).selectAllRecords();
    bodyWidget.members.get(1).getSelectedRecords().forEach(function (current, index) {

        let shipmentCostDetailObj = {};
        shipmentCostDetailObj.id = current.id;
        shipmentCostDetailObj.version = current.version;
        shipmentCostDetailObj.shipmentCostDutyId = current.shipmentCostDutyId;
        shipmentCostDetailObj.quantity = current.quantity;
        shipmentCostDetailObj.unitId = current.unitId;
        shipmentCostDetailObj.unitPrice = current.unitPrice;
        shipmentCostDetailObj.sumPrice = current.sumPrice;
        shipmentCostDetailObj.discountPrice = current.discountPrice;
        shipmentCostDetailObj.sumPriceWithDiscount = current.sumPriceWithDiscount;
        shipmentCostDetailObj.tvatPrice = current.tvatPrice;
        shipmentCostDetailObj.cvatPrice = current.cvatPrice;
        shipmentCostDetailObj.sumVatPrice = shipmentCostDetailObj.tvatPrice + shipmentCostDetailObj.cvatPrice;
        shipmentCostDetailObj.sumPriceWithVat = current.sumPriceWithVat;
        shipmentCostDetailObj.shipmentCostInvoiceId = current.shipmentCostInvoiceId;
        shipmentCostInvoiceDetails.push(shipmentCostDetailObj);

    });
    shipmentCostObj.sumPrice = shipmentCostInvoiceTab.variable.summaryRowData.sumPrice;
    shipmentCostObj.sumPriceWithDiscount = shipmentCostInvoiceTab.variable.summaryRowData.sumPriceWithDiscount;
    shipmentCostObj.sumPriceWithVat = shipmentCostInvoiceTab.variable.summaryRowData.sumPriceWithVat;
    shipmentCostObj.shipmentCostInvoiceDetails = shipmentCostInvoiceDetails;

    return shipmentCostObj;
};

shipmentCostInvoiceTab.window.shipmentCost.validate = function (data) {

    shipmentCostInvoiceTab.dynamicForm.shipmentCost.validate();
    if (shipmentCostInvoiceTab.dynamicForm.shipmentCost.hasErrors())
        return false;

    if (shipmentCostInvoiceTab.listGrid.shipmentCostDetail.getTotalRows() === 0) {
        isc.say("<spring:message code='shipmentCostInvoiceDetail.service.list'/>");
        return false;
    }
    for (let i = 0; i < shipmentCostInvoiceTab.listGrid.shipmentCostDetail.getTotalRows(); i++) {
        shipmentCostInvoiceTab.listGrid.shipmentCostDetail.validateRow(i);
        if (shipmentCostInvoiceTab.listGrid.shipmentCostDetail.hasErrors())
            return false;
    }
    shipmentCostInvoiceTab.dynamicForm.shipmentPrice.validate();
    if (shipmentCostInvoiceTab.dynamicForm.shipmentPrice.hasErrors())
        return false;

    return true;
};

shipmentCostInvoiceTab.window.shipmentCost.okCallBack = function (shipmentCostObj) {
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/shipmentCostInvoice",
            httpMethod: shipmentCostInvoiceTab.variable.method,
            data: JSON.stringify(shipmentCostObj),
            callback: function (resp) {
                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    shipmentCostInvoiceTab.method.refreshData();
                    // shipmentCostInvoiceTab.window.shipmentCost.close();
                } else
                    isc.say(RpcResponse_o.data);
            }
        })
    );

};

shipmentCostInvoiceTab.window.shipmentCost.cancelCallBack = function () {

    shipmentCostInvoiceTab.dynamicForm.shipmentCost.clearValues();
    shipmentCostInvoiceTab.method.clearListGrid();

};

shipmentCostInvoiceTab.method.refreshData = function () {
    shipmentCostInvoiceTab.listGrid.main.invalidateCache();
};

shipmentCostInvoiceTab.method.newForm = function () {

    shipmentCostInvoiceTab.variable.financeUnitName = 0;
    shipmentCostInvoiceTab.variable.method = "POST";
    shipmentCostInvoiceTab.dynamicForm.shipmentCost.clearValues();
    shipmentCostInvoiceTab.dynamicForm.shipmentPrice.clearValues();
    shipmentCostInvoiceTab.method.clearListGrid();
    shipmentCostInvoiceTab.window.shipmentCost.justShowForm();
    shipmentCostInvoiceTab.method.setVATs(shipmentCostInvoiceTab.variable.year)
    shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(2).members.get(0).hide();

};

shipmentCostInvoiceTab.method.editForm = function () {

    shipmentCostInvoiceTab.variable.method = "PUT";
    shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(2).members.get(0).hide();

    let record = shipmentCostInvoiceTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        shipmentCostInvoiceTab.dialog.notSelected();
    else if (record.editable === false)
        shipmentCostInvoiceTab.dialog.notEditable();
    else if (record.estatus.contains(Enums.eStatus2.DeActive))
        shipmentCostInvoiceTab.dialog.inactiveRecord();
    else if (record.estatus.contains(Enums.eStatus2.Final))
        shipmentCostInvoiceTab.dialog.finalRecord();
    else {

        shipmentCostInvoiceTab.window.shipmentCost.justShowForm();

        shipmentCostInvoiceTab.dynamicForm.shipmentCost.fields.forEach(field => shipmentCostInvoiceTab.dynamicForm.shipmentCost.setValue(field.name, record[field.name]));

        shipmentCostInvoiceTab.dynamicForm.shipmentCost.setValue("invoiceDate", new Date(record.invoiceDate));
        shipmentCostInvoiceTab.dynamicForm.shipmentCost.getField("invoiceTypeId").changed(
            shipmentCostInvoiceTab.dynamicForm.shipmentCost,
            shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("invoiceTypeId"),
            shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("invoiceTypeId").getValue());
        shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("referenceId").setValue(record.referenceId);

        // Set toFinanceUnitId
        if (record.conversionRef != null)
            shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("toFinanceUnitId").setValue(record.conversionRef.unitToId);

        shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("rialPrice").setValue(record.rialPrice);
        shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("buyerShare").setValue(record.buyerShare);
        shipmentCostInvoiceTab.listGrid.shipmentCostDetail.setData(record.shipmentCostInvoiceDetails);

        shipmentCostInvoiceTab.dynamicForm.shipmentCost.getField("toFinanceUnitId").changed(
            shipmentCostInvoiceTab.dynamicForm.shipmentCost,
            shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("toFinanceUnitId"),
            shipmentCostInvoiceTab.dynamicForm.shipmentCost.getItem("toFinanceUnitId").getValue());

        if (record.conversionRef != null)
            shipmentCostInvoiceTab.dynamicForm.shipmentPrice.getItem("conversionRefId").setValue(record.conversionRefId);

        // Set Unit for ListGrid
        /*        let totalRows = shipmentCostInvoiceTab.listGrid.shipmentCostDetail.getTotalRows();
                let financeUnitIdIndex = shipmentCostInvoiceTab.listGrid.shipmentCostDetail.fields.indexOf(shipmentCostInvoiceTab.listGrid.shipmentCostDetail.fields.filter(q => q.name === "financeUnitId").first());
                for (let i = 0; i < totalRows; i++) {
                    shipmentCostInvoiceTab.listGrid.shipmentCostDetail.setEditValue(i, financeUnitIdIndex, record.financeUnit.nameFA);
                }
                shipmentCostInvoiceTab.listGrid.shipmentCostDetail.invalidateCache();*/

        shipmentCostInvoiceTab.listGrid.shipmentCostDetail.members.get(3).members.get(2).members.get(0).click();
    }
};

//***************************************************** MAINLISTGRID *************************************************

shipmentCostInvoiceTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "invoiceDate",
        title: "<spring:message code='shipmentCostInvoice.invoiceDate'/>",
        type: 'date',
        width: "10%"
    },
    {
        name: "invoiceNoPaper",
        title: "<spring:message code='shipmentCostInvoice.invoiceNoPaper'/>",
        type: 'text'
    },
    {
        name: "invoiceType.title",
        title: "<spring:message code='shipmentCostInvoice.invoiceType'/>",
    },
    {
        name: "sellerContact.name",
        title: "<spring:message code='shipmentCostInvoice.sellerContact'/>",
    },
    {
        name: "buyerContact.name",
        title: "<spring:message code='shipmentCostInvoice.buyerContact'/>",
    },
    {
        name: "financeUnit.name",
        title: "<spring:message code='shipmentCostInvoice.financeUnit'/>",
    },
    {
        name: "sumPrice",
        title: "<spring:message code='shipmentCostInvoice.sumPrice'/>",
        filterOperator: "equals",
        formatCellValue: function (value, record, rowNum, colNum) {
            if (!value)
                return value;

            return value + "";
        },
        // type: 'float'
    },
    {
        name: "sumPriceWithDiscount",
        title: "<spring:message code='shipmentCostInvoice.sumPriceWithDiscount'/>",
        filterOperator: "equals",
        formatCellValue: function (value, record, rowNum, colNum) {
            if (!value)
                return value;

            return value + "";
        },
        // type: 'float'
    },
    {
        name: "sumPriceWithVat",
        title: "<spring:message code='shipmentCostInvoice.sumPriceWithVat'/>",
        filterOperator: "equals",
        formatCellValue: function (value, record, rowNum, colNum) {
            if (!value)
                return value;

            return value + "";
        },
        // type: 'float'
    }
]);
shipmentCostInvoiceTab.listGrid.fields.filter(q => q.name === "estatus").first().hidden = false;

// ShipmentCost Section
nicico.BasicFormUtil.createListGrid = function () {

    shipmentCostInvoiceTab.listGrid.main = isc.ListGrid.nicico.getDefault(shipmentCostInvoiceTab.listGrid.fields,
        shipmentCostInvoiceTab.restDataSource.shipmentCostInvoice, null, {
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
            filterData: function () {
                let criteria = this.getFilterEditorCriteria();
                this.collapseRecords(this.getExpandedRecords());
                this.fetchData(criteria);
                this.Super("filterData", arguments);
            },
            getExpansionComponent: function (record) {

                let criteria1 = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "shipmentCostInvoiceId", operator: "equals", value: record.id}]
                };

                shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                    if (data.length == 0) {
                        // shipmentCostInvoiceTab.label.recordNotFound.show();
                        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.hide()
                    } else {
                        // shipmentCostInvoiceTab.label.recordNotFound.hide();
                        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.setData(data);
                        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.setAutoFitMaxRecords(1);
                        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain.show();
                    }
                }, {operationId: "00"});

                shipmentCostInvoiceTab.vLayout.shipmentCostMain = isc.VLayout.create({
                    styleName: "expand-layout",
                    padding: 5,
                    membersMargin: 10,
                    members: [
                        shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain,
                        // shipmentCostInvoiceTab.label.recordNotFound,
                    ]
                });

                return shipmentCostInvoiceTab.vLayout.shipmentCostMain;
            }
        }
    );
};

// ShipmentCostDetail Section
shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain = isc.ListGrid.create(
    {
        showFilterEditor: true,
        canAutoFitFields: true,
        width: "100%",
        styleName: "listgrid-child",
        height: 180,
        dataSource: shipmentCostInvoiceTab.restDataSource.shipmentCostInvoiceDetail,
        autoFetchData: false,
        setAutoFitExtraRecords: true,
        fields: [
            {
                name: "id",
                hidden: true,
                primaryKey: true
            },
            {
                name: "shipmentCostDuty.code",
                width: "10%",
            },
            {
                name: "shipmentCostDuty.name",
                width: "10%"
            },
            {
                name: "quantity",
                width: "10%",
                formatCellValue: function (value, record, rowNum, colNum) {
                    if (!value)
                        return value;

                    return value + "";
                }
            },
            {
                name: "unitPrice",
                width: "10%",
                formatCellValue: function (value, record, rowNum, colNum) {
                    if (!value)
                        return value;

                    return value + "";
                },
            },
            {
                name: "sumPrice",
                width: "10%",
                formatCellValue: function (value, record, rowNum, colNum) {
                    if (!value)
                        return value;

                    return value + "";
                },
            },
            {
                name: "sumPriceWithVat",
                width: "10%",
                formatCellValue: function (value, record, rowNum, colNum) {
                    if (!value)
                        return value;

                    return value + "";
                }
            },
            {
                name: "shipmentCostInvoiceId",
                type: "long",
                hidden: true,
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

nicico.BasicFormUtil.getDefaultBasicForm(shipmentCostInvoiceTab, "api/shipmentCostInvoice/");
nicico.BasicFormUtil.showAllToolStripActions(shipmentCostInvoiceTab);

shipmentCostInvoiceTab.sectionStack.mainSection = isc.SectionStack.create(
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
                items: shipmentCostInvoiceTab.listGrid.shipmentCostDetailMain,
                expanded: false
            }],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });
