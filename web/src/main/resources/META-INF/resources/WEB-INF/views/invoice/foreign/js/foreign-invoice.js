var foreignInvoiceTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

foreignInvoiceTab.variable.materialId = null;
foreignInvoiceTab.variable.completionInvoice = false;
foreignInvoiceTab.variable.contractDetailData = {};
foreignInvoiceTab.variable.invoiceForm = new nicico.FormUtil();
foreignInvoiceTab.variable.selectBillLadingForm = new nicico.FindFormUtil();
foreignInvoiceTab.variable.selectBillLadingCompletionForm = new nicico.FindFormUtil();

foreignInvoiceTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/";
foreignInvoiceTab.variable.remittanceDetailUrl = "${contextPath}" + "/api/remittance-detail/";
foreignInvoiceTab.variable.inspectionReportUrl = "${contextPath}" + "/api/inspectionReport/";
foreignInvoiceTab.variable.personUrl = "${contextPath}" + "/api/person/";
foreignInvoiceTab.variable.shipmentUrl = "${contextPath}" + "/api/shipment/";
foreignInvoiceTab.variable.unitUrl = "${contextPath}" + "/api/unit/";
foreignInvoiceTab.variable.invoiceTypeUrl = "${contextPath}" + "/api/invoicetype/";
foreignInvoiceTab.variable.conversionRefUrl = "${contextPath}" + "/api/currencyRate/";
foreignInvoiceTab.variable.foreignInvoiceUrl = "${contextPath}" + "/api/foreign-invoice/";
foreignInvoiceTab.variable.foreignInvoiceItemUrl = "${contextPath}" + "/api/foreign-invoice-item/";
foreignInvoiceTab.variable.foreignInvoicePaymentUrl = "${contextPath}" + "/api/foreign-invoice-payment/";
foreignInvoiceTab.variable.foreignInvoiceItemDetailUrl = "${contextPath}" + "/api/foreign-invoice-item-detail/";
foreignInvoiceTab.variable.foreignInvoiceBillOfLadingUrl = "${contextPath}" + "/api/foreign-invoice-bill-of-lading/";
foreignInvoiceTab.variable.billLadingUrl = "${contextPath}" + "/api/bill-of-landing/";

foreignInvoiceTab.variable.invoiceTypeCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "or",
    criteria: [
        {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.FINAL},
        // {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.PERFORMA},
        // {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.PROVISIONAL},
        // {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.PI_TRUSTY},
        // {fieldName: "id", operator: "equals", value: ImportantIDs.invoiceType.FI_TRUSTY}
    ]
};

foreignInvoiceTab.tab.pane = {};

foreignInvoiceTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "no",
        width: "100%",
        required: true,
        showHover: true,
        title: "<spring:message code='foreign-invoice.form.no'/>"
    },
    {
        name: "date",
        type: "date",
        width: "100%",
        required: true,
        showHover: true,
        title: "<spring:message code='foreign-invoice.form.date'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "invoiceType.title",
        title: "<spring:message code='foreign-invoice.form.invoice-type'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.invoiceType.title;
        }
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "sumPrice",
        canFilter: false,
        title: "<spring:message code='foreign-invoice.form.sum-price'/>",
        formatCellValue: function (value, record, rowNum, colNum) {
            if (!value)
                return value;

            return NumberUtil.format(value, "0.##");
        },
    },
    {
        width: "100%",
        showHover: true,
        name: "conversionSumPrice",
        canFilter: false,
        title: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>",
        formatCellValue: function (value, record, rowNum, colNum) {
            if (!value)
                return value;

            return NumberUtil.format(value, "0.##");
        },
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "buyer.nameEN",
        title: "<spring:message code='foreign-invoice.form.buyer'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.buyer.nameEN;
        }
    },
    {
        width: "100%",
        type: "date",
        required: true,
        showHover: true,
        name: "shipment.sendDate",
        title: "<spring:message code='global.sendDate'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.shipment.sendDate;
        }
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "shipment.material.descEN",
        title: "<spring:message code='material.descEN'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.shipment.material.descEN;
        }
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "creator.fullName",
        title: "<spring:message code='foreign-invoice.form.creator'/>",
        sortNormalizer: function (recordObject) {
            return recordObject.creator.fullName;
        }
    },
    {
        width: "100%",
        showHover: true,
        name: "documentId",
        title: "<spring:message code='foreign-invoice.form.documentId'/>"
    },
    {
        width: "100%",
        showHover: true,
        name: "percent",
        title: "<spring:message code='foreign-invoice.form.percent'/>",
        filterOperator: "equals"
    },
    {
        hidden: true,
        width: "100%",
        showHover: true,
        name: "parentId",
        title: "<spring:message code='foreign-invoice.form.parent-id'/>"
    }
]);
foreignInvoiceTab.listGrid.fields.filter(q => q.name === "estatus").first().hidden = false;
foreignInvoiceTab.dynamicForm.fields = BaseFormItems.concat([
    /* Foreign Invoice */
    {
        required: true,
        name: "date",
        type: "date",
        title: "<spring:message code='foreign-invoice.form.date'/>",
        wrapTitle: false
    },
    {
        required: true,
        type: "integer",
        name: "invoiceTypeId",
        editorType: "SelectItem",
        width: "100%",
        valueField: "id",
        displayField: "title",
        autoFetchData: false,
        defaultValue: ImportantIDs.invoiceType.FINAL,
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "title", title: "<spring:message code='global.description'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.invoiceTypeUrl + "spec-list"
        }),
        optionCriteria: foreignInvoiceTab.variable.invoiceTypeCriteria,
        title: "<spring:message code='foreign-invoice.form.invoice-type'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        required: true,
        type: "integer",
        editorType: "SelectItem",
        name: "contractId",
        width: "100%",
        valueField: "id",
        displayField: "no",
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        optionCriteria: {
            operator: "and",
            criteria: [
                {
                    fieldName: "parentId",
                    operator: "isNull"
                }, {
                    fieldName: "eStatusId",
                    operator: "greaterOrEqual",
                    value: 4
                }
            ]
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {
                    name: "no",
                    title: "<spring:message code='foreign-invoice.form.contract'/>"
                },
                {name: "description", title: "<spring:message code='global.description'/>"},
                {name: "materialId"},
                {name: "material.descFA", title: "<spring:message code='material.descFA'/>"},
                {name: "estatus", title: "<spring:message code='global.status'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.contractUrl + "spec-list"
        }),
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "no"},
            {name: "materialId", hidden: true},
            {name: "material.descFA"},
            {name: "estatus"}
        ],
        title: "<spring:message code='foreign-invoice.form.contract'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {

            let selectedRecord = item.getSelectedRecord();
            let shipmentIdField = form.getField("shipmentId");
            shipmentIdField.setValue(null);

            if (!selectedRecord) {

                shipmentIdField.disable();
                return;
            }
            if (!selectedRecord.estatus.contains(Enums.eStatus2.Final)) {

                foreignInvoiceTab.dialog.say('<spring:message code="foreign-invoice.form.validate.contract.not.final"/>');
                shipmentIdField.disable();
                return;
            }

            foreignInvoiceTab.variable.materialId = selectedRecord.materialId;
            if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.COPPER_CATHOD) {

                form.getField("inspectionAssayId").hide();
                form.getField("inspectionAssayId").setRequired(false);
            } else {
                form.getField("inspectionAssayId").show();
                form.getField("inspectionAssayId").setRequired(true);
            }

            shipmentIdField.setOptionCriteria({
                operator: "or",
                criteria: [{
                    fieldName: "contractShipment.contractId",
                    operator: "equals",
                    value: selectedRecord.id
                }, {
                    fieldName: "contractShipment.contract.parentId",
                    operator: "equals",
                    value: selectedRecord.id
                }]
            });
            shipmentIdField.enable();
            shipmentIdField.changed(form, shipmentIdField, null);
        }
    },
    {
        required: true,
        disabled: true,
        width: "100%",
        type: "integer",
        name: "shipmentId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "sendDate",
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {
                name: "sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: "date",
                width: "110",
                dateFormatter: "toJapanShortDate"
            },
            {name: "material.descEN", title: "<spring:message code='material.descEN'/>"},
            {name: "amount", title: "<spring:message code='global.amount'/>"},
            {name: "automationLetterNo", title: "<spring:message code='shipment.loadingLetter'/>"},
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "material.descEN", title: "<spring:message code='material.descEN'/>"},
                {name: "amount", title: "<spring:message code='global.amount'/>"},
                {name: "automationLetterNo", title: "<spring:message code='shipment.loadingLetter'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.shipmentUrl + "spec-list-foreign-invoice"
        }),
        title: "<spring:message code='foreign-invoice.form.shipment'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        formatValue(value, record, form, item) {

            let selectedRecord = item.getSelectedRecord();
            if (!selectedRecord) return;

            return new Date(selectedRecord.sendDate).getMonthName();
        },
        changed: function (form, item, value) {

            form.setValue("inspectionWeightId", null);
            form.setValue("inspectionAssayId", null);
            form.getItem("inspectionWeightId").disable();
            form.getItem("inspectionAssayId").disable();
            form.getItem("inspectionWeightId").setOptionCriteria(null);
            form.getItem("inspectionAssayId").setOptionCriteria(null);
            foreignInvoiceTab.dynamicForm.valuesManager.setValue("billLadings", null);

            let selectedRecord = item.getSelectedRecord();
            if (!selectedRecord) {

                foreignInvoiceTab.button.selectBillLading.disable();
                foreignInvoiceTab.button.selectBillLading.criteria = null;

                return;
            }

            form.getItem("inspectionWeightId").enable();
            form.getItem("inspectionAssayId").enable();

            foreignInvoiceTab.button.selectBillLading.enable();
            foreignInvoiceTab.button.selectBillLading.criteria = {
                operator: "equals",
                fieldName: "shipmentId",
                value: selectedRecord.id
            };
        }
    },
    {
        required: true,
        type: "integer",
        name: "creatorId",
        editorType: "SelectItem",
        width: "100%",
        valueField: "id",
        displayField: "fullName",
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", hidden: true},
            {name: "fullName"},
            {name: "jobTitle"},
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "fullName", title: "<spring:message code='person.fullName'/>"},
                {name: "jobTitle", title: "<spring:message code='person.jobTitle'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.personUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.creator'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        required: true,
        width: "100%",
        type: "integer",
        name: "currencyId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "name",
        optionCriteria: {
            operator: 'and',
            criteria: [{
                fieldName: 'categoryUnit',
                operator: 'equals',
                value: JSON.parse('${Enum_CategoryUnit}').Finance
            }]
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "name", title: "<spring:message code='global.title'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.unitUrl + "spec-list"
        }),
        pickListFields: [
            {name: "name", align: "center"},
        ],
        title: "<spring:message code='foreign-invoice.form.currency'/>",
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {

            form.setValue("toCurrencyId", null);
            form.setValue("conversionRefId", null);
            form.getField("conversionRefId").disable();

            if (!value) {

                form.getField("toCurrencyId").disable();
                return;
            }

            form.getField("toCurrencyId").enable();
        }
    },
    {
        disabled: true,
        type: "integer",
        name: "toCurrencyId",
        editorType: "SelectItem",
        width: "100%",
        valueField: "id",
        displayField: "name",
        optionCriteria: {
            operator: 'and',
            criteria: [{
                fieldName: 'categoryUnit',
                operator: 'equals',
                value: JSON.parse('${Enum_CategoryUnit}').Finance
            }]
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "name", title: "<spring:message code='global.title'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.unitUrl + "spec-list"
        }),
        pickListFields: [
            {name: "name", align: "center"}
        ],
        title: "<spring:message code='foreign-invoice.form.to.currency'/>",
        wrapTitle: false,
        changed: function (form, item, value) {

            form.setValue("conversionRefId", null);

            if (!value || !form.getValue("currencyId")) {

                form.getField("conversionRefId").disable();
                return;
            }

            if (form.getValue("currencyId") === form.getValue("toCurrencyId")) {

                form.setValue("toCurrencyId", null);
                form.getField("conversionRefId").disable();
            } else {

                let toDate = form.getItem("date").getValue().duplicate();
                toDate.setHours(23);
                toDate.setMinutes(59);
                toDate.setSeconds(59);
                let fromDate = form.getItem("date").getValue().duplicate();
                fromDate.setHours(0);
                fromDate.setMinutes(0);
                fromDate.setSeconds(0);

                form.getField("conversionRefId").enable();
                form.getField("conversionRefId").setOptionCriteria({
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
                                value: form.getItem("currencyId").getValue()
                            },
                            {
                                fieldName: "unitToId",
                                operator: "equals",
                                value: item.getValue()
                            }
                        ]
                });
            }
        }
    },
    {
        disabled: true,
        width: "100%",
        type: "integer",
        name: "conversionRefId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "reference",
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>", width: "10%"},
            {
                name: "currencyDate",
                title: "<spring:message code='global.date'/>",
                dateFormatter: "toJapanShortDate",
                width: "10%"
            },
            {name: "unitFrom.nameEN", title: "<spring:message code='global.from'/>", width: "10%"},
            {name: "unitTo.nameEN", title: "<spring:message code='global.to'/>", width: "10%"},
            {name: "currencyRateValue", title: "<spring:message code='rate.title'/>", width: "10%"}
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "reference", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
                {name: "currencyDate", type: "date", title: "<spring:message code='global.date'/>"},
                {name: "unitFrom", title: "<spring:message code='global.from'/>"},
                {name: "unitFromId", title: "<spring:message code='global.from'/>"},
                {name: "unitTo", title: "<spring:message code='global.to'/>"},
                {name: "unitToId", title: "<spring:message code='global.to'/>"},
                {name: "currencyRateValue"}
            ],
            fetchDataURL: foreignInvoiceTab.variable.conversionRefUrl + "spec-list"
        }),
        title: "<spring:message code='foreign-invoice.form.conversion-ref'/>",
        wrapTitle: false
    },
    {
        required: true,
        disabled: true,
        width: "100%",
        type: "integer",
        name: "inspectionWeightId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "inspectionNO",
        autoFetchData: false,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", hidden: true},
            {name: "inspectionNO", showHover: true},
            {name: "inspector.nameFA", showHover: true},
            {name: "issueDate", showHover: true, dateFormatter: "toJapanShortDate"},
            {name: "seller.nameFA", showHover: true},
            {name: "buyer.nameFA", showHover: true},
            {name: "weightInspections.mileStone", showHover: true}
        ],
        getPickListFilterCriteria: function () {
            let criteria = {
                _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                    {
                        fieldName: 'weightInspections',
                        operator: "notNull",
                    }, {
                        fieldName: "weightInspections.shipmentId",
                        operator: "notNull",
                    }, {
                        fieldName: "weightInspections.shipmentId",
                        operator: "equals",
                        value: foreignInvoiceTab.dynamicForm.baseData.getValue("shipmentId")
                    }]
            };
            return criteria;
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "inspectionNO", title: "<spring:message code='inspectionReport.InspectionNO'/>"},
                {name: "inspector.nameFA", title: "<spring:message code='inspectionReport.inspectorId'/>"},
                {
                    name: "issueDate",
                    title: "<spring:message code='inspectionReport.IssueDate'/>",
                    type: "date",
                    width: 100
                },
                {name: "seller.nameFA", title: "<spring:message code='inspectionReport.sellerId'/>"},
                {name: "buyer.nameFA", title: "<spring:message code='inspectionReport.buyerId'/>"},
                {
                    name: "weightInspections.mileStone",
                    title: "<spring:message code='inspectionReport.weight.mileStone'/>"
                }, {
                    name: "weightInspections",
                    title: "<spring:message code='inspectionReport.weight.mileStone'/>"
                }, {
                    name: "weightInspections.shipmentId",
                    title: "<spring:message code='inspectionReport.weight.mileStone'/>"
                }
            ],
            transformRequest: function (dsRequest) {

                let request = this.Super("transformRequest", arguments);
                request.distinct = true;

                return request;
            },
            fetchDataURL: foreignInvoiceTab.variable.inspectionReportUrl + "spec-list"
        }),
        title: "<spring:message code='weightInspection.title'/>",
        wrapTitle: false,
    },
    {
        disabled: true,
        width: "100%",
        type: "integer",
        name: "inspectionAssayId",
        editorType: "SelectItem",
        valueField: "id",
        displayField: "inspectionNO",
        autoFetchData: false,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", hidden: true},
            {name: "inspectionNO", showHover: true},
            {name: "inspector.nameFA", showHover: true},
            {name: "issueDate", showHover: true, dateFormatter: "toJapanShortDate"},
            {name: "seller.nameFA", showHover: true},
            {name: "buyer.nameFA", showHover: true},
            {name: "assayInspections.mileStone", showHover: true}
        ],
        getPickListFilterCriteria: function () {
            let criteria = {
                _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                    {
                        fieldName: 'assayInspections',
                        operator: "notNull",
                    }, {
                        fieldName: "assayInspections.shipmentId",
                        operator: "notNull",
                    }, {
                        fieldName: "assayInspections.shipmentId",
                        operator: "equals",
                        value: foreignInvoiceTab.dynamicForm.baseData.getValue("shipmentId")
                    }
                ]
            };
            return criteria;
        },
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "inspectionNO", title: "<spring:message code='inspectionReport.InspectionNO'/>"},
                {name: "inspector.nameFA", title: "<spring:message code='inspectionReport.inspectorId'/>"},
                {
                    name: "issueDate",
                    title: "<spring:message code='inspectionReport.IssueDate'/>",
                    type: "date",
                    width: 100
                },
                {name: "seller.nameFA", title: "<spring:message code='inspectionReport.sellerId'/>"},
                {name: "buyer.nameFA", title: "<spring:message code='inspectionReport.buyerId'/>"},
                {
                    name: "assayInspections.mileStone",
                    title: "<spring:message code='inspectionReport.assay.mileStone'/>"
                },
                {
                    name: "assayInspections",
                    title: "<spring:message code='inspectionReport.weight.mileStone'/>"
                }, {
                    name: "assayInspections.shipmentId",
                    title: "<spring:message code='inspectionReport.weight.mileStone'/>"
                }
            ],
            transformRequest: function (dsRequest) {

                let request = this.Super("transformRequest", arguments);
                request.distinct = true;

                return request;
            },
            fetchDataURL: foreignInvoiceTab.variable.inspectionReportUrl + "spec-list"
        }),
        title: "<spring:message code='assayInspection.title'/>",
        wrapTitle: false,
    },
    {
        width: "100%",
        name: "description",
        editorType: "textArea",
        title: "<spring:message code='global.description'/>",
    }
]);

//******************************************************* COMPONENTS ***************************************************

foreignInvoiceTab.dynamicForm.valuesManager = isc.ValuesManager.create({});
foreignInvoiceTab.dynamicForm.baseData = isc.DynamicForm.create({

    margin: 10,
    width: "100%",
    align: "center",
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    fields: foreignInvoiceTab.dynamicForm.fields,
    valuesManager: foreignInvoiceTab.dynamicForm.valuesManager,
    requiredMessage: '<spring:message code="validator.field.is.required"/>'
});
foreignInvoiceTab.dynamicForm.baseData.validate = function () {

    let isValid = this.Super("validate", arguments);
    let billLadings = foreignInvoiceTab.dynamicForm.valuesManager.getValue('billLadings');
    if (billLadings == null || billLadings.length === 0) {

        foreignInvoiceTab.dialog.say("<spring:message code='foreign-invoice.form.validate.bill-of-lading.not.selected'/>");
        isValid = false;
    }

    if (foreignInvoiceTab.variable.materialId !== ImportantIDs.material.COPPER_CATHOD) {

        let weightInspections = foreignInvoiceTab.dynamicForm.baseData.getField('inspectionWeightId').getSelectedRecord().weightInspections;
        let assayInspections = foreignInvoiceTab.dynamicForm.baseData.getField('inspectionAssayId').getSelectedRecord().assayInspections;
        let weightInventories = [];
        let assayInventories = [];
        weightInspections.forEach(q => weightInventories.add(q.inventoryId));
        assayInspections.forEach(q => assayInventories.add(q.inventoryId));
        if (!weightInventories.containsAll(assayInventories.distinct()) || !assayInventories.distinct().containsAll(weightInventories)) {

            foreignInvoiceTab.dialog.say("<spring:message code='foreign-invoice.form.validate.inventories.not.equal'/>");
            isValid = false;
        }
    }

    return isValid;
};

foreignInvoiceTab.button.save = isc.IButtonSave.create({
    margin: 10,
    height: 50,
    width: 150,
    title: "<spring:message code='global.form.add.detail'/>",
    click: function () {

        let contractId;
        if (!foreignInvoiceTab.variable.completionInvoice) {
            if (!foreignInvoiceTab.dynamicForm.baseData.validate()) return;
            contractId = foreignInvoiceTab.dynamicForm.baseData.getValue("contractId");
        }
        else
            contractId = foreignInvoiceTab.listGrid.main.getSelectedRecord().shipment.contractShipment.contract.id;

        foreignInvoiceTab.method.jsonRPCManagerRequest({
            httpMethod: "GET",
            actionURL: "${contextPath}/api/foreign-invoice/get-contract-detail-data",
            params: {
                contractId: contractId
            },
        }, (resp) => {
            if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

                foreignInvoiceTab.variable.contractDetailData = JSON.parse(resp.data);
                if (!foreignInvoiceTab.variable.completionInvoice) {

                    foreignInvoiceTab.tab.invoice.removeTabs(foreignInvoiceTab.tab.invoice.tabs);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue(
                        'currency',
                        foreignInvoiceTab.dynamicForm.baseData.getField('currencyId').getSelectedRecord());
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue(
                        'conversionRef',
                        foreignInvoiceTab.dynamicForm.baseData.getField('conversionRefId').getSelectedRecord());
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue(
                        'invoiceType',
                        foreignInvoiceTab.dynamicForm.baseData.getField('invoiceTypeId').getSelectedRecord());
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue(
                        'contract',
                        foreignInvoiceTab.dynamicForm.baseData.getField('contractId').getSelectedRecord());
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue(
                        'shipment',
                        foreignInvoiceTab.dynamicForm.baseData.getField('shipmentId').getSelectedRecord());
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue(
                        'inspectionWeightData',
                        foreignInvoiceTab.dynamicForm.baseData.getField('inspectionWeightId').getSelectedRecord());
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue(
                        'inspectionAssayData',
                        foreignInvoiceTab.dynamicForm.baseData.getField('inspectionAssayId').getSelectedRecord());
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('parentId', null);

                    foreignInvoiceTab.method.continueTab();
                } else {


                    let recordId = foreignInvoiceTab.listGrid.main.getSelectedRecord().id;
                    foreignInvoiceTab.method.jsonRPCManagerRequest({
                        httpMethod: "GET",
                        actionURL: "${contextPath}/api/foreign-invoice/heavy-info/" + recordId,
                    }, (resp) => {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

                            let data = JSON.parse(resp.data);

                            foreignInvoiceTab.tab.invoice.removeTabs(foreignInvoiceTab.tab.invoice.tabs);
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('parentId', data.id);
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('currency', data.currency);
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('conversionRef', data.conversionRef);
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('invoiceType', data.invoiceType);
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('contract', data.shipment.contractShipment.contract);
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('shipment', data.shipment);
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('inspectionWeightData', data.inspectionWeightReport);
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('inspectionAssayData', data.inspectionAssayReport);
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('date', foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm.getValue("date"));
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('creator', foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm.getField("creatorId").getSelectedRecord());
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('billLadings', foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager.getValue('billLadings'));
                            foreignInvoiceTab.dynamicForm.valuesManager.setValue('remainingPercent', foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager.getValue('remainingPercent'));

                            foreignInvoiceTab.method.continueTab();
                        }
                    });
                }
            }
        });
    }
});
foreignInvoiceTab.button.cancel = isc.IButtonCancel.create({
    margin: 10,
    height: 50,
    click: function () {
        foreignInvoiceTab.window.main.close();
    },
});

foreignInvoiceTab.variable.selectBillLadingForm.validate = function (selectedRecords) {
    return selectedRecords;
};
foreignInvoiceTab.variable.selectBillLadingForm.okCallBack = function (selectedRecords) {

    foreignInvoiceTab.dynamicForm.valuesManager.setValue("billLadings", selectedRecords);
    foreignInvoiceTab.label.selectedBillLading.setContents(selectedRecords.map(q => q.documentNo).join(', '));
    foreignInvoiceTab.label.selectedBillLading.setBorder("1px solid black");

};

foreignInvoiceTab.label.billLadingTitle = isc.Label.create({
    contents: "<spring:message code='foreign-invoice.form.label.bill-lading'/>",
    border: "0px solid black",
    align: "center",
    width: "100%",
});
foreignInvoiceTab.label.selectedBillLading = isc.Label.create({
    contents: '',
    border: "0px solid black",
    align: "center",
    width: "100%",
});
foreignInvoiceTab.button.selectBillLading = isc.IButtonSave.create({
    width: 200,
    margin: 10,
    height: 50,
    criteria: null,
    disabled: true,
    icon: "pieces/16/icon_add.png",
    title: "<spring:message code='foreign-invoice.form.button.select.bill-lading'/>",
    click: function () {

        foreignInvoiceTab.variable.selectBillLadingForm.showFindFormByRestApiUrl(
            foreignInvoiceTab.window.main,
            "70%", null, "<spring:message code='foreign-invoice.form.button.select.bill-lading'/>",
            foreignInvoiceTab.dynamicForm.valuesManager.getValue("billLadings"),
            foreignInvoiceTab.variable.billLadingUrl + "spec-list",
            [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "documentNo", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
                {name: "shipperExporter.nameEN", title: "<spring:message code='billOfLanding.shipper.exporter'/>"},
                {name: "notifyParty.nameEN", title: "<spring:message code='billOfLanding.notify.party'/>"},
                {name: "consignee.nameEN", title: "<spring:message code='billOfLanding.consignee'/>"},
                {name: "portOfLoading.port", title: "<spring:message code='billOfLanding.port.of.loading'/>"},
                {name: "portOfDischarge.port", title: "<spring:message code='billOfLanding.port.of.discharge'/>"},
                {name: "placeOfDelivery", title: "<spring:message code='billOfLanding.place.of.delivery'/>"},
                {name: "oceanVessel.name", title: "<spring:message code='billOfLanding.ocean.vessel'/>"},
            ],
            null, this.criteria, Number.MAX_VALUE);
    }
});

foreignInvoiceTab.window.main = isc.Window.nicico.getDefault('<spring:message code="entity.foreign-invoice"/>', [

    foreignInvoiceTab.dynamicForm.baseData,
    isc.HLayout.create({
        width: "100%",
        members: [
            foreignInvoiceTab.button.save,
            foreignInvoiceTab.button.cancel,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                margin: 0,
                padding: 0,
                members: [foreignInvoiceTab.label.billLadingTitle, foreignInvoiceTab.label.selectedBillLading, foreignInvoiceTab.button.selectBillLading]
            })
        ]
    })
], "50%");

foreignInvoiceTab.tab.invoice = isc.TabSet.create({

    width: "100%",
    height: "600",
    autoDraw: true,
    showEdges: false,
    edgeMarginSize: 3,
    tabBarThickness: 300,
    tabBarPosition: nicico.CommonUtil.getAlignByLangReverse(),
// tabBarControls: [],
    // tabs: []
});

foreignInvoiceTab.variable.invoiceForm.validate = function (data) {

    let invoicePaymentTab = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoicePayment.Class).first();
    if (!invoicePaymentTab) return false;

    let invoicePaymentComponent = invoicePaymentTab.pane;
    return invoicePaymentComponent && invoicePaymentComponent.validate();
};
foreignInvoiceTab.variable.invoiceForm.okCallBack = function (data) {

    foreignInvoiceTab.method.jsonRPCManagerRequest({
        data: JSON.stringify(data)
    }, (resp) => {
        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

            foreignInvoiceTab.window.main.close();
            foreignInvoiceTab.method.refresh(foreignInvoiceTab.listGrid.main);
            foreignInvoiceTab.dialog.ok();
        }
    });

};
foreignInvoiceTab.variable.invoiceForm.populateData = function (bodyWidget) {

    let invoicePaymentComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoicePayment.Class).first();
    if (!invoicePaymentComponent) return null;
    else invoicePaymentComponent.pane.members.filter(q => q.name === "finalPriceButton").first().click();
    let data = foreignInvoiceTab.dynamicForm.valuesManager.getValues();
    let inspectionWeightData = foreignInvoiceTab.dynamicForm.valuesManager.getValue('inspectionWeightData');
    let inspectionAssayData = foreignInvoiceTab.dynamicForm.valuesManager.getValue('inspectionAssayData');
    let weightMilestone = inspectionWeightData.weightInspections.first().mileStone;
    let assayMilestone = inspectionAssayData ? inspectionAssayData.assayInspections.first().mileStone : null;

    data.billLadingIds = data.billLadings.map(q => q.id);
    data.buyerId = data.contract.contractContacts.filter(q => q.commercialRole === JSON.parse('${Enum_CommercialRole}').Buyer).first().contactId;

    let paymentComponentValues = invoicePaymentComponent.pane.getValues();
    data.unitCost = paymentComponentValues.unitCost;
    data.unitPrice = paymentComponentValues.unitPrice;
    data.sumPrice = paymentComponentValues.sumPrice.getValues().value;
    data.sumFIPrice = paymentComponentValues.sumFIPrice.getValues().value;
    data.conversionDate = paymentComponentValues.conversionDate;
    data.conversionRate = paymentComponentValues.conversionRate;
    data.conversionSumPrice = paymentComponentValues.conversionSumPrice.getValues().value;
    data.conversionSumPriceText = paymentComponentValues.conversionSumPriceText;
    data.sumPIPrice = data.sumFIPrice - data.sumPrice;
    data.inspectionWeightReportId = inspectionWeightData.id;
    data.inspectionAssayReportId = inspectionAssayData ? inspectionAssayData.id : null;
    data.foreignInvoicePayments = paymentComponentValues.shipmentCostInvoices;
    data.parentId = paymentComponentValues.parentId;
    data.delayPenalty = paymentComponentValues.delayPenalty.getValues().value;

    if (paymentComponentValues.parentId) {

        data.creatorId = data.creator.id;
        data.contractId = data.contract.id;
        data.shipmentId = data.shipment.id;
        data.currencyId = data.currency.id;
        data.invoiceTypeId = data.invoiceType.id;
    }

    if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.COPPER_CONCENTRATES) {

        let invoiceBaseValuesComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceBaseValues.Class).first().pane;
        let invoiceBasePriceComponent = invoiceBaseValuesComponent.invoiceBasePriceComponent;
        let invoiceBaseAssayComponent = invoiceBaseValuesComponent.invoiceBaseAssayComponent;
        let invoiceBaseWeightComponent = invoiceBaseValuesComponent.invoiceBaseWeightComponent;
        data.percent = invoiceBaseWeightComponent.getValues().percent;
        data.premiumValue = 0;

        let invoiceCalculationComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceCalculation.Class).first();
        if (!invoiceCalculationComponent) return null;
        let invoiceDeductionComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceDeduction.Class).first();
        if (!invoiceDeductionComponent) return null;

        function getForeignInvoiceItemDetails(item) {

            let itemDetails = [];
            let remittanceDetailId = item.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id;
            let assayData = inspectionAssayData.assayInspections.filter(q => q.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id === remittanceDetailId);
            assayData.forEach(q => {
                itemDetails.add({
                    assay: q.value,
                    materialElementId: q.materialElementId,
                    basePrice: invoiceBasePriceComponent.getValues().filter(bp => bp.elementId === q.materialElement.elementId).first().value,
                    basePriceWeightUnitId: invoiceBasePriceComponent.getValues().filter(bp => bp.elementId === q.materialElement.elementId).first().weightUnitId,
                    basePriceFinanceUnitId: invoiceBasePriceComponent.getValues().filter(bp => bp.elementId === q.materialElement.elementId).first().financeUnitId,
                    deductionType: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.materialElement.elementId).first().deductionType,
                    deductionValue: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.materialElement.elementId).first().deductionValue,
                    deductionPrice: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.materialElement.elementId).first().deductionPrice,
                    deductionUnitConversionRate: invoiceCalculationComponent.pane.getValues().filter(ca => ca.elementId === q.materialElement.elementId).first().deductionUnitConversionRate,
                    rcPrice: invoiceDeductionComponent.pane.getValues().slice(1).filter(trc => trc.materialElementId === q.materialElementId).first().rcPrice,
                    rcBasePrice: invoiceDeductionComponent.pane.getValues().slice(1).filter(trc => trc.materialElementId === q.materialElementId).first().rcBasePrice.getValues().value,
                    rcUnitConversionRate: invoiceDeductionComponent.pane.getValues().slice(1).filter(trc => trc.materialElementId === q.materialElementId).first().rcUnitConversionRate
                })
            });
            return itemDetails;
        }

        data.foreignInvoiceItems = function () {
            let items = [];

            inspectionWeightData.weightInspections.forEach(current => {
                let remittanceDetailId = current.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id;
                let weightData = inspectionWeightData.weightInspections.filter(q => q.inventory.remittanceDetails.filter(q => q.inputRemittance === false).first().id === remittanceDetailId)
                    .first();
                items.add({
                    weightGW: weightData.weightGW,
                    weightND: weightData.weightND,
                    assayMilestone: assayMilestone,
                    weightMilestone: weightMilestone,
                    remittanceDetailId: remittanceDetailId,
                    treatCost: invoiceDeductionComponent.pane.getValues().filter(q => q.name === "TC").first().value,
                    foreignInvoiceItemDetails: getForeignInvoiceItemDetails(current)
                });
            });
            return items;
        }();

    } else if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.MOLYBDENUM_OXIDE) {

        let invoiceCalculation2Component = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceCalculation2.Class).first().pane;
        data.percent = invoiceCalculation2Component.getPercent();
        data.foreignInvoiceItems = invoiceCalculation2Component.getForeignInvoiceItems();
        data.premiumValue = 0;

    } else {
        ///// COPPER CATHODE /////
        let invoiceCalculationCathodeComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceCalculationCathode.Class).first().pane;
        data.percent = invoiceCalculationCathodeComponent.invoiceBaseWeightComponent.getValues().percent;
        data.foreignInvoiceItems = invoiceCalculationCathodeComponent.getForeignInvoiceItems();
        data.premiumValue = invoiceCalculationCathodeComponent.getPremiumValue();
    }

    delete data.contract;
    delete data.currency;
    delete data.shipment;
    delete data.billLadings;
    delete data.invoiceType;
    delete data.toCurrencyId;
    delete data.conversionRef;
    delete data.calculationData;
    delete data.rcDeductionData;
    delete data.remittanceDetails;
    delete data.remittanceDetailId;
    delete data.inspectionAssayId;
    delete data.inspectionWeightId;
    delete data.inspectionAssayData;
    delete data.inspectionWeightData;

    console.log("populate data ", data);
    return data;
};
foreignInvoiceTab.variable.invoiceForm.init(null, '<spring:message code="entity.foreign-invoice"/>', foreignInvoiceTab.tab.invoice, "70%");
foreignInvoiceTab.variable.invoiceForm.actionWidget.getObject().getMember(0).setTitle("<spring:message code='global.form.final-save'/>");

foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager = isc.ValuesManager.create({});
foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm = isc.DynamicForm.create({
    margin: 10,
    numCols: 4,
    width: "100%",
    align: "center",
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    valuesManager: foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager,
    fields: [
        {
            name: "date",
            title: "<spring:message code='foreign-invoice.form.date'/>",
            type: "date",
            titleColSpan: 2,
            colSpan: 2,
            required: true,
            wrapTitle: false
        }, {
            name: "creatorId",
            title: "<spring:message code='foreign-invoice.form.creator'/>",
            type: "integer",
            titleColSpan: 2,
            colSpan: 2,
            required: true,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "fullName",
            pickListProperties: {
                showFilterEditor: true
            },
            pickListFields: [
                {name: "id", hidden: true},
                {name: "fullName"},
                {name: "jobTitle"},
            ],
            optionDataSource: isc.MyRestDataSource.create({
                fields: [
                    {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                    {name: "fullName", title: "<spring:message code='person.fullName'/>"},
                    {name: "jobTitle", title: "<spring:message code='person.jobTitle'/>"},
                ],
                fetchDataURL: foreignInvoiceTab.variable.personUrl + "spec-list"
            }),
            wrapTitle: false,
            validators: [
                {
                    type: "required",
                    validateOnChange: true
                }]
        }, {
            name: "remainingPercent",
            title: "<spring:message code='foreign-invoice.form.remaining.percent'/>",
            type: "staticText",
            titleColSpan: 2,
            colSpan: 2
        }]
});

foreignInvoiceTab.variable.selectBillLadingCompletionForm.validate = function (selectedRecords) {
    return selectedRecords;
};
foreignInvoiceTab.variable.selectBillLadingCompletionForm.okCallBack = function (selectedRecords) {

    foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager.setValue("billLadings", selectedRecords);
    foreignInvoiceTab.label.selectBillLadingCompletion.setContents(selectedRecords.map(q => q.documentNo).join(', '));
    foreignInvoiceTab.label.selectBillLadingCompletion.setBorder("1px solid black");
};

foreignInvoiceTab.label.billLadingCompletionTitle = isc.Label.create({
    contents: "<spring:message code='foreign-invoice.form.label.bill-lading'/>",
    border: "0px solid black",
    align: "center",
    width: "100%",
});
foreignInvoiceTab.label.selectBillLadingCompletion = isc.Label.create({
    contents: '',
    border: "0px solid black",
    align: "center",
    width: "100%",
});
foreignInvoiceTab.button.selectBillLadingCompletion = isc.IButtonSave.create({
    width: 200,
    margin: 10,
    height: 50,
    criteria: null,
    disabled: true,
    icon: "pieces/16/icon_add.png",
    title: "<spring:message code='foreign-invoice.form.button.select.bill-lading'/>",
    click: function () {

        foreignInvoiceTab.variable.selectBillLadingCompletionForm.showFindFormByRestApiUrl(
            foreignInvoiceTab.window.invoiceCompletionForm.windowWidget.getObject(),
            "70%", null, "<spring:message code='foreign-invoice.form.button.select.bill-lading'/>",
            foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager.getValue("billLadings"),
            foreignInvoiceTab.variable.billLadingUrl + "spec-list",
            [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "documentNo", title: "<spring:message code='foreign-invoice.form.conversion-ref'/>"},
                {name: "shipperExporter.nameEN", title: "<spring:message code='global.date'/>"},
                {name: "notifyParty.nameEN", title: "<spring:message code='global.from'/>"},
                {name: "consignee.nameEN", title: "<spring:message code='global.to'/>"},
                {name: "portOfLoading.port", title: "<spring:message code='rate.title'/>"},
                {name: "portOfDischarge.port", title: "<spring:message code='rate.title'/>"},
                {name: "placeOfDelivery", title: "<spring:message code='rate.title'/>"},
                {name: "oceanVessel.name", title: "<spring:message code='rate.title'/>"},
            ],
            null, this.criteria, Number.MAX_VALUE);
    }
});

foreignInvoiceTab.window.invoiceCompletionForm = new nicico.FormUtil();
foreignInvoiceTab.window.invoiceCompletionForm.init(null, '<spring:message code="global.completion.foreign.invoice"/>', isc.HLayout.create({
    width: "100%",
    height: "100",
    align: "center",
    members: [
        isc.VLayout.create({
            width: "100%",
            members: [

                foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    margin: 0,
                    padding: 0,
                    members: [foreignInvoiceTab.label.billLadingCompletionTitle, foreignInvoiceTab.label.selectBillLadingCompletion, foreignInvoiceTab.button.selectBillLadingCompletion]
                })
            ]
        })
    ]
}), "600", "10%");
foreignInvoiceTab.window.invoiceCompletionForm.validate = function (data) {

    let isValid = true;
    let billLadings = foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager.getValue('billLadings');
    if (billLadings == null || billLadings.length === 0) {

        foreignInvoiceTab.dialog.say("<spring:message code='foreign-invoice.form.validate.bill-of-lading.not.selected'/>");
        isValid = false;
    }
    foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm.validate();
    if (foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm.hasErrors())
        isValid = false;

    if (foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm.getValue("remainingPercent") <= 0) {
        isValid = false;
        foreignInvoiceTab.dialog.say("<spring:message code='foreign-invoice.form.validate.no-remaining-percent'/>");
    }

    return isValid;
};
foreignInvoiceTab.window.invoiceCompletionForm.okCallBack = function (data) {

    foreignInvoiceTab.button.save.click();
};

// Send To Accounting
foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager = isc.ValuesManager.create({});
foreignInvoiceTab.dynamicForm.sentToAccountingInvoiceForm = isc.DynamicForm.create({
    margin: 10,
    numCols: 4,
    padding: 10,
    width: "100%",
    titleWidth: 130,
    align: "center",
    borderRadius: 5,
    border: "1px solid black",
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    valuesManager: foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager,
    fields: [
        {
            name: "id",
            hidden: true
        },
        {
            name: "invoiceTypeId",
            title: "<spring:message code='foreign-invoice.form.invoice-type'/>",
            width: "100%",
            editorType: "staticText",
        },
        {
            name: "date",
            title: "<spring:message code='foreign-invoice.form.date'/>",
            width: "100%",
            type: "date",
            dateFormatter: "toJapanShortDate",
            editorType: "staticText",
        },
        {
            name: "shipmentId",
            title: "<spring:message code='foreign-invoice.form.shipment'/>",
            width: "100%",
            type: "date",
            dateFormatter: "toJapanShortDate",
            editorType: "staticText",
        },
        {
            name: "creatorId",
            title: "<spring:message code='foreign-invoice.form.creator'/>",
            width: "100%",
            editorType: "staticText",
        },
        {
            name: "currencyId",
            title: "<spring:message code='foreign-invoice.form.currency'/>",
            width: "100%",
            editorType: "staticText",
        },
        {
            name: "sumPrice",
            title: "<spring:message code='shipmentCostInvoice.sumPrice'/>",
            width: "100%",
            format: "0,0.##",
            editorType: "staticText",
        },
        {
            name: "toCurrencyId",
            title: "<spring:message code='foreign-invoice.form.to.currency'/>",
            width: "100%",
            editorType: "staticText",
        },
        {
            name: "conversionRate",
            title: "<spring:message code='foreign-invoice.conversionRate'/>",
            width: "100%",
            editorType: "staticText",
        },
        {
            name: "conversionSumPrice",
            title: "<spring:message code='foreign-invoice.conversionSumPrice'/>",
            width: "100%",
            format: "0,0.##",
            editorType: "staticText",
        },
        {
            name: "conversionSumPriceText",
            title: "<spring:message code='foreign-invoice.conversionSumPriceText'/>",
            width: "100%",
            editorType: "staticText",
        }
    ]
});
foreignInvoiceTab.dynamicForm.sentToAccountingDocumentForm = isc.DynamicForm.create({
    margin: 10,
    numCols: 4,
    width: "100%",
    align: "center",
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    valuesManager: foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager,
    fields: [
        {
            name: "department",
            title: "<spring:message code='department.name'/>",
            required: true,
            editorType: "select",
            wrapTitle: false,
            optionDataSource: isc.MyRestDataSource.create({
                fields: [
                    {name: "id", primaryKey: true, type: "integer", title: " ID"},
                    {name: "departmentName", title: "<spring:message code='department.name'/>"},
                    {name: "departmentCode", title: "<spring:message code='department.code'/>"}
                ],
                dataFormat: "json",
                jsonPrefix: "",
                jsonSuffix: "",
                fetchDataURL: "${contextPath}/api/accounting/departments"
            }),
            valueField: "id",
            displayField: "departmentName",
            width: "100%",
            pickListWidth: "370",
            allowAdvancedCriteria: false,
            autoFetchData: false,
            pickListFields: [
                {name: "departmentCode", width: "30%"},
                {name: "departmentName", width: "70%"}
            ],
            showErrorText: true,
            showErrorStyle: true,
            errorOrientation: "bottom",
            requiredMessage: '<spring:message code="validator.field.is.required"/>',
            validators: [{
                type: "required",
                validateOnChange: true
            }]
        },
        {
            name: "documentDate",
            required: true,
            title: "<spring:message code='document.header.date'/>",
            icons: [persianDatePicker],
            wrapTitle: false,
            type: "persianDate",
            width: "100%",
            length: 10,
            keyPressFilter: "[0-9/]",
            showErrorText: true,
            showErrorStyle: true,
            errorOrientation: "bottom"
        },
        {
            name: "documentTitle",
            title: "<spring:message code='document.header.desc'/>",
            type: "textArea",
            colSpan: "4",
            width: "100%",
            wrapTitle: false
        },
    ]
});

foreignInvoiceTab.window.sentToAccounting = new nicico.FormUtil();
foreignInvoiceTab.window.sentToAccounting.init(null, '<spring:message code="accounting.document.create"/>', isc.HLayout.create({
    width: "100%",
    height: "450",
    align: "center",
    members: [
        isc.VLayout.create({
            width: "100%",
            members: [
                isc.Label.create({
                    margin: 10,
                    height: 5,
                    align: "right",
                    contents: "<h3 style='text-align: right;padding-right:20px'>"
                    + "<spring:message code='invoice.invoiceInfo'/>" +
                    "</h3>"
                }),
                isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }),
                foreignInvoiceTab.dynamicForm.sentToAccountingInvoiceForm,
                isc.Label.create({
                    margin: 10,
                    height: 5,
                    align: "right",
                    contents: "<h3 style='text-align: right;padding-right:20px'>"
                    + "<spring:message code='invoice.documentInfo'/>" +
                    "</h3>"
                }),
                isc.HTMLFlow.create({
                    width: "100%",
                    contents: "<span style='width: 100%; display: block; border-bottom: 1px solid rgba(0,0,0,0.3)'></span>"
                }),
                foreignInvoiceTab.dynamicForm.sentToAccountingDocumentForm
            ]
        })
    ]
}), "1000", "40%");
foreignInvoiceTab.window.sentToAccounting.validate = function (date) {

    foreignInvoiceTab.dynamicForm.sentToAccountingDocumentForm.validate();
    return !foreignInvoiceTab.dynamicForm.sentToAccountingDocumentForm.hasErrors();
};
foreignInvoiceTab.window.sentToAccounting.populateData = function (data) {

    return foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.getValues();
};
foreignInvoiceTab.window.sentToAccounting.okCallBack = function (data) {

    foreignInvoiceTab.method.jsonRPCManagerRequest({
        httpMethod: "POST",
        actionURL: "${contextPath}/api/accounting/documents/foreign/" + data.id,
        data: JSON.stringify(data),
        prompt: "<spring:message code='global.server.sending-to-accounting'/>",
        callback: function (resp) {

            let grid = foreignInvoiceTab.tab.invoiceTabs.getTab(foreignInvoiceTab.tab.invoiceTabs.selectedTab).pane.members.get(1);
            let record = grid.getSelectedRecord();
            let respData = JSON.stringify(resp.httpResponseText).split("@");
            record.documentId = respData[1].replace("\"", "");
            record.estatus.add(Enums.eStatus2.SendToAcc);
            isc.say(respData[0]);
            grid.refreshRow(grid.getRowNum(record));
            grid.invalidateCache();
            foreignInvoiceTab.listGrid.invoiceSent.invalidateCache();
        }
    });
};

//****************************************************** Main **********************************************************

nicico.BasicFormUtil.createListGrid = function () {

    foreignInvoiceTab.listGrid.main = isc.ListGrid.nicico.getDefault(
        foreignInvoiceTab.listGrid.fields,
        foreignInvoiceTab.restDataSource.main, null,
        {
            sortField: 1,
            sortDirection: "descending",
            implicitCriteria: {
                operator: "and",
                _constructor: "AdvancedCriteria",
                criteria: [{fieldName: 'eStatusId', operator: 'lessThan', value: 8}]
            }
        }
    );
};
nicico.BasicFormUtil.createVLayout = function () {

    foreignInvoiceTab.toolStrip.invoiceSent = isc.ToolStrip.create({
        width: "100%",
        border: '0px',
        name: "refresh",
        align: nicico.CommonUtil.getAlignByLang(),
        members: [
            isc.ToolStripButton.create({
                icon: "pieces/16/icon_view.png",
                name: "relatedInvoice",
                title: "<spring:message code='global.form.related.invoice'/>",
                click: function () {

                    foreignInvoiceTab.method.relatedInvoice(foreignInvoiceTab.listGrid.invoiceSent);
                }
            }),
            // <sec:authorize access="hasAuthority('P_FOREIGN_INVOICE')">
            isc.ToolStripButtonPrint.create({
                icon: "icon/pdf.png",
                name: "print",
                title: "<spring:message code='foreign-invoice.invoice-print'/>",
                click: function () {

                    foreignInvoiceTab.method.print(foreignInvoiceTab.listGrid.invoiceSent);
                }
            }),
            // </sec:authorize>
            isc.ToolStrip.create({
                width: "100%",
                border: '0px',
                name: "refresh",
                align: nicico.CommonUtil.getAlignByLang(),
                members: [
                    isc.ToolStripButtonRefresh.create({
                        title: "<spring:message code='global.form.refresh'/>",
                        click: function () {

                            foreignInvoiceTab.method.refresh(foreignInvoiceTab.listGrid.invoiceSent);
                        }
                    })
                ]
            })
        ]
    });
    foreignInvoiceTab.toolStrip.invoiceDeleted = isc.ToolStrip.create({
        width: "100%",
        members: [
            // <sec:authorize access="hasAuthority('E_BACK_TO_UNSENT_FOREIGN_INVOICE')">
            isc.ToolStripButton.create({
                icon: "[SKIN]/actions/notSent.png",
                title: "<spring:message code='foreign-invoice.back-to-not-sent'/>",
                click: function () {

                    foreignInvoiceTab.method.backToUnSent(foreignInvoiceTab.listGrid.invoiceDeleted);
                }
            }),
            // </sec:authorize>
            isc.ToolStripButton.create({
                icon: "pieces/16/icon_view.png",
                name: "relatedInvoice",
                title: "<spring:message code='global.form.related.invoice'/>",
                click: function () {

                    foreignInvoiceTab.method.relatedInvoice(foreignInvoiceTab.listGrid.invoiceDeleted);
                }
            }),
            // <sec:authorize access="hasAuthority('E_SEND_FOREIGN_INVOICE_TO_ACC')">
            isc.ToolStripButton.create({
                title: "<spring:message code='accounting.document.create'/>",
                icon: "pieces/receipt.png",
                click: function () {

                    foreignInvoiceTab.method.sendToAcc(foreignInvoiceTab.listGrid.invoiceDeleted);
                }
            }),
            // </sec:authorize>
            // <sec:authorize access="hasAuthority('P_FOREIGN_INVOICE')">
            isc.ToolStripButtonPrint.create({
                icon: "icon/pdf.png",
                name: "print",
                title: "<spring:message code='foreign-invoice.invoice-print'/>",
                click: function () {

                    foreignInvoiceTab.method.print(foreignInvoiceTab.listGrid.invoiceDeleted);
                }
            }),
            // </sec:authorize>
            // <sec:authorize access="hasAuthority('E_UPDATE_DELETED_FOREIGN_INVOICE')">
            isc.ToolStripButton.create({
                title: "<spring:message code='accounting.document.change.status'/>",
                icon: "pieces/16/refresh.png",
                click: function () {

                    let criteria = {};
                    Object.assign(criteria, foreignInvoiceTab.listGrid.invoiceDeleted.getCriteria());
                    if (criteria.criteria)
                        criteria.criteria = criteria.criteria.concat(foreignInvoiceTab.listGrid.invoiceSent.getImplicitCriteria().criteria);
                    else
                        criteria = foreignInvoiceTab.listGrid.invoiceSent.getImplicitCriteria();
                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: "${contextPath}/api/foreign-invoice/update-deleted-document",
                        httpMethod: "GET",
                        params: {
                            criteria: criteria
                        },
                        useSimpleHttp: true,
                        contentType: "application/json; charset=utf-8",
                        willHandleError: true,
                        serverOutputAsString: false,
                        callback: function (resp) {
                            if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

                                foreignInvoiceTab.method.refresh(foreignInvoiceTab.listGrid.invoiceDeleted);
                                foreignInvoiceTab.method.refresh(foreignInvoiceTab.listGrid.invoiceSent);
                            }
                        }
                    }));
                }
            }),
            // </sec:authorize>
            isc.ToolStrip.create({
                width: "100%",
                border: '0px',
                name: "refresh",
                align: nicico.CommonUtil.getAlignByLang(),
                members: [
                    isc.ToolStripButtonRefresh.create({
                        title: "<spring:message code='global.form.refresh'/>",
                        click: function () {

                            foreignInvoiceTab.method.refresh(foreignInvoiceTab.listGrid.invoiceDeleted);
                        }
                    })
                ]
            })
        ]
    });

    foreignInvoiceTab.listGrid.invoiceSent = isc.ListGrid.nicico.getDefault(
        foreignInvoiceTab.listGrid.fields,
        foreignInvoiceTab.restDataSource.main, null,
        {
            sortField: 1,
            sortDirection: "descending",
            implicitCriteria: {
                operator: "and",
                _constructor: "AdvancedCriteria",
                criteria: [
                    {fieldName: 'eStatusId', operator: 'lessThan', value: 16},
                    {fieldName: 'eStatusId', operator: 'greaterOrEqual', value: 8}
                ]
            }
        }
    );
    foreignInvoiceTab.listGrid.invoiceDeleted = isc.ListGrid.nicico.getDefault(
        foreignInvoiceTab.listGrid.fields,
        foreignInvoiceTab.restDataSource.main, null,
        {
            sortField: 1,
            sortDirection: "descending",
            implicitCriteria: {
                operator: "and",
                _constructor: "AdvancedCriteria",
                criteria: [{fieldName: 'eStatusId', operator: 'greaterOrEqual', value: 16}]
            }
        }
    );

    foreignInvoiceTab.vLayout.invoice = isc.VLayout.create({
        width: "100%",
        members: [
            foreignInvoiceTab.toolStrip.main, foreignInvoiceTab.listGrid.main
        ]
    });
    foreignInvoiceTab.vLayout.invoiceSent = isc.VLayout.create({
        width: "100%",
        members: [
            foreignInvoiceTab.toolStrip.invoiceSent, foreignInvoiceTab.listGrid.invoiceSent
        ]
    });
    foreignInvoiceTab.vLayout.invoiceDeleted = isc.VLayout.create({
        width: "100%",
        members: [
            foreignInvoiceTab.toolStrip.invoiceDeleted, foreignInvoiceTab.listGrid.invoiceDeleted
        ]
    });

    foreignInvoiceTab.tab.invoiceTabs = isc.TabSet.create({
        width: "100%",
        height: "100%",
        tabBarPosition: nicico.CommonUtil.getAlignByLangReverse(),
        wrap: false,
        showTabScroller: true,
        border: "1px solid lightblue",
        edgeMarginSize: 3,
        tabBarThickness: 80,
        tabs: [
            {
                title: "<spring:message code='issuedInternalInvoices.dontSent'/>",
                pane: foreignInvoiceTab.vLayout.invoice
            },
            {
                title: "<spring:message code='issuedInternalInvoices.sent'/>",
                pane: foreignInvoiceTab.vLayout.invoiceSent
            },
            {
                title: "<spring:message code='issuedInternalInvoices.deleted'/>",
                pane: foreignInvoiceTab.vLayout.invoiceDeleted
            },
        ]
    });
    foreignInvoiceTab.vLayout.main = isc.VLayout.create({
        width: "100%",
        members: [
            foreignInvoiceTab.tab.invoiceTabs
        ]
    });
};

nicico.BasicFormUtil.getDefaultBasicForm(foreignInvoiceTab, "api/foreign-invoice/");
nicico.BasicFormUtil.showAllToolStripActions(foreignInvoiceTab);
nicico.BasicFormUtil.removeExtraGridMenuActions(foreignInvoiceTab);

foreignInvoiceTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    icon: "pieces/16/icon_view.png",
    name: "relatedInvoice",
    title: "<spring:message code='global.form.related.invoice'/>",
    click: function () {

        foreignInvoiceTab.method.relatedInvoice(foreignInvoiceTab.listGrid.main);
    }
}), 7);
// <sec:authorize access="hasAuthority('C_FOREIGN_INVOICE_COMPLETION')">
foreignInvoiceTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    icon: "[SKIN]/actions/configure.png",
    name: "invoiceCompletion",
    title: "<spring:message code='global.completion.foreign.invoice'/>",
    click: function () {

        let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();

        if (record == null || record.id == null)
            foreignInvoiceTab.dialog.notSelected();
        else if (record.editable === false)
            foreignInvoiceTab.dialog.notEditable();
        else if (record.estatus.contains(Enums.eStatus2.DeActive))
            foreignInvoiceTab.dialog.inactiveRecord();
        else if (record.estatus.contains(Enums.eStatus2.Final))
            foreignInvoiceTab.dialog.finalRecord();
        else if (record.parentId)
            foreignInvoiceTab.dialog.say('<spring:message code="foreign-invoice.form.invoice.completion.on.parent"/>');
        else {

            foreignInvoiceTab.variable.method = "POST";
            foreignInvoiceTab.variable.completionInvoice = true;
            foreignInvoiceTab.button.selectBillLadingCompletion.criteria = {
                operator: "equals",
                fieldName: "shipmentId",
                value: record.shipmentId
            };
            foreignInvoiceTab.button.selectBillLadingCompletion.enable();

            foreignInvoiceTab.variable.materialId = record.shipment.materialId;
            foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm.clearValues();
            foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager.clearValues();
            foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager.clearErrors();
            foreignInvoiceTab.label.selectBillLadingCompletion.setContents('');
            foreignInvoiceTab.label.selectBillLadingCompletion.setBorder("0px solid black");
            foreignInvoiceTab.method.jsonRPCManagerRequest({
                httpMethod: "GET",
                actionURL: foreignInvoiceTab.variable.foreignInvoiceUrl + "spec-list",
                params: {
                    criteria: {
                        operator: "and",
                        criteria: [{
                            fieldName: "inspectionWeightReportId",
                            operator: "equals",
                            value: record.inspectionWeightReportId
                        }]
                    }
                },
                callback: function (resp) {

                    let data = JSON.parse(resp.httpResponseText).response.data;
                    let remainingPercent = 100 - (data.map(q => q.percent).sum());
                    foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm.setValue("remainingPercent", remainingPercent);
                    if (remainingPercent <= 0)
                        foreignInvoiceTab.dialog.say("<spring:message code='foreign-invoice.invoice.completed'/>");
                    else
                        foreignInvoiceTab.window.invoiceCompletionForm.justShowForm();
                }
            });
        }
    }
}), 8);
// </sec:authorize>
// <sec:authorize access="hasAuthority('E_SEND_FOREIGN_INVOICE_TO_ACC')">
foreignInvoiceTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    icon: "pieces/receipt.png",
    name: "SentToAccounting",
    title: "<spring:message code='accounting.document.create'/>",
    click: function () {

        foreignInvoiceTab.method.sendToAcc(foreignInvoiceTab.listGrid.main);
    }
}), 9);
// </sec:authorize>
// <sec:authorize access="hasAuthority('P_FOREIGN_INVOICE')">
foreignInvoiceTab.toolStrip.main.addMember(isc.ToolStripButtonPrint.create({
    icon: "icon/pdf.png",
    name: "print",
    title: "<spring:message code='foreign-invoice.invoice-print'/>",
    click: function () {

        foreignInvoiceTab.method.print(foreignInvoiceTab.listGrid.main);
    }
}), 10);
// </sec:authorize>
foreignInvoiceTab.dynamicForm.main = null;

//*************************************************** Functions ********************************************************

foreignInvoiceTab.method.newForm = function () {

    foreignInvoiceTab.variable.method = "POST";
    foreignInvoiceTab.variable.completionInvoice = false;
    foreignInvoiceTab.dynamicForm.valuesManager.clearValues();
    foreignInvoiceTab.dynamicForm.valuesManager.clearErrors();
    foreignInvoiceTab.label.selectedBillLading.setContents('');
    foreignInvoiceTab.label.selectedBillLading.setBorder("0px solid black");
    foreignInvoiceTab.dynamicForm.baseData.getField("inspectionAssayId").show();
    foreignInvoiceTab.dynamicForm.baseData.getField("inspectionAssayId").setRequired(true);
    foreignInvoiceTab.dynamicForm.baseData.getFields().forEach(field => {

        if (field.name === "date" || field.name === "invoiceTypeId")
            field.enable();

        if (!field.changed) return;
        field.changed(foreignInvoiceTab.dynamicForm.baseData, field, field.getValue());
    });

    foreignInvoiceTab.dynamicForm.baseData.redraw();
    foreignInvoiceTab.window.main.show();
};
foreignInvoiceTab.method.editForm = function () {

    foreignInvoiceTab.variable.method = "PUT";
    foreignInvoiceTab.variable.completionInvoice = false;
    foreignInvoiceTab.dynamicForm.baseData.getField("inspectionAssayId").show();
    foreignInvoiceTab.dynamicForm.baseData.getField("inspectionAssayId").setRequired(true);
    let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        foreignInvoiceTab.dialog.notSelected();
    else if (record.editable === false)
        foreignInvoiceTab.dialog.notEditable();
    else if (record.estatus.contains(Enums.eStatus2.DeActive))
        foreignInvoiceTab.dialog.inactiveRecord();
    else if (record.estatus.contains(Enums.eStatus2.SendToAcc))
        foreignInvoiceTab.dialog.recordIsSentToAcc();
    else if (record.estatus.contains(Enums.eStatus2.Final))
        foreignInvoiceTab.dialog.finalRecord();
    else if (record.parentId)
        foreignInvoiceTab.dialog.say('<spring:message code="foreign-invoice.form.completion.invoice.not.editable"/>');
    else {

        foreignInvoiceTab.variable.materialId = record.shipment.materialId;
        foreignInvoiceTab.method.jsonRPCManagerRequest({
            httpMethod: "GET",
            promptDelay: 1000,
            actionURL: foreignInvoiceTab.variable.foreignInvoiceBillOfLadingUrl + "spec-list",
            params: {
                criteria: {
                    operator: "and",
                    criteria: [{fieldName: "foreignInvoiceId", operator: "equals", value: record.id}]
                }
            },
            callback: function (billOfLadingResp) {

                foreignInvoiceTab.method.jsonRPCManagerRequest({
                    httpMethod: "GET",
                    showPrompt: false,
                    actionURL: foreignInvoiceTab.variable.foreignInvoicePaymentUrl + "spec-list",
                    params: {
                        criteria: {
                            operator: "and",
                            criteria: [{fieldName: "foreignInvoiceId", operator: "equals", value: record.id}]
                        }
                    },
                    callback: function (paymentResp) {
                        foreignInvoiceTab.method.jsonRPCManagerRequest({
                            httpMethod: "GET",
                            showPrompt: false,
                            actionURL: foreignInvoiceTab.variable.foreignInvoiceItemUrl + "spec-list",
                            params: {
                                criteria: {
                                    operator: "and",
                                    criteria: [{fieldName: "foreignInvoiceId", operator: "equals", value: record.id}]
                                }
                            },
                            callback: function (itemResp) {

                                let itemValues = JSON.parse(itemResp.httpResponseText).response.data;

                                foreignInvoiceTab.method.jsonRPCManagerRequest({
                                    httpMethod: "GET",
                                    showPrompt: false,
                                    actionURL: foreignInvoiceTab.variable.foreignInvoiceItemDetailUrl + "spec-list",
                                    params: {
                                        criteria: {
                                            operator: "and",
                                            criteria: [{
                                                fieldName: "foreignInvoiceItemId",
                                                operator: "equals",
                                                value: itemValues[0].id
                                            }]
                                        }
                                    },
                                    callback: function (itemDetailResp) {

                                        let paymentValues = JSON.parse(paymentResp.httpResponseText).response.data;
                                        let billOfLadingValues = JSON.parse(billOfLadingResp.httpResponseText).response.data;
                                        let itemDetailValues = JSON.parse(itemDetailResp.httpResponseText).response.data;

                                        foreignInvoiceTab.variable.method = "PUT";
                                        foreignInvoiceTab.dynamicForm.valuesManager.clearValues();
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValues(record);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("date", new Date(record.date));
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("billLadings", billOfLadingValues.map(q => q.billOfLanding));
                                        foreignInvoiceTab.label.selectedBillLading.setContents(billOfLadingValues.map(q => q.billOfLanding.documentNo).join(', '));
                                        foreignInvoiceTab.label.selectedBillLading.setBorder("1px solid black");
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("toCurrencyId", record.conversionRef ? record.conversionRef.unitToId : null);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("contractId", record.shipment.contractShipment.contractId);

                                        if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.COPPER_CONCENTRATES) {

                                            let rcRowData = [];
                                            let basePriceData = [];
                                            let calculationRowData = [];

                                            itemDetailValues.forEach(detail => {
                                                rcRowData.add({
                                                    foreignInvoiceItemId: detail.foreignInvoiceItemId,
                                                    materialElementId: detail.materialElementId,
                                                    rcUnitConversionRate: detail.rcUnitConversionRate
                                                });
                                                basePriceData.add({
                                                    materialElement: detail.materialElement,
                                                    basePrice: detail.basePrice,
                                                    basePriceFinanceUnit: detail.basePriceFinanceUnit,
                                                    basePriceWeightUnit: detail.basePriceWeightUnit
                                                });
                                                calculationRowData.add({
                                                    foreignInvoiceItemId: detail.foreignInvoiceItemId,
                                                    materialElementId: detail.materialElementId,
                                                    deductionValue: detail.deductionValue,
                                                    deductionType: detail.deductionType,
                                                    deductionUnitConversionRate: detail.deductionUnitConversionRate
                                                });
                                            });
                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("rcDeductionData", rcRowData);
                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("basePriceData", basePriceData);
                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("calculationData", calculationRowData);
                                        } else if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.MOLYBDENUM_OXIDE) {

                                            function getBasePrice() {

                                                let basePrices = [];
                                                itemDetailValues.forEach(detail => {
                                                    basePrices.add({
                                                        materialElement: detail.materialElement,
                                                        basePrice: detail.basePrice,
                                                        basePriceFinanceUnit: detail.basePriceFinanceUnit,
                                                        basePriceWeightUnit: detail.basePriceWeightUnit
                                                    });
                                                });
                                                return basePrices;
                                            }

                                            let molybdenumRowData = [];
                                            itemValues.forEach(item => {
                                                molybdenumRowData.add({
                                                    remittanceDetailId: item.remittanceDetailId,
                                                    deductionUnitConversionRate: item.deductionUnitConversionRate,
                                                    basePrice: getBasePrice()
                                                })
                                            });
                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("molybdenumRowData", molybdenumRowData);
                                        } else {

                                            //// COPPER CATHODE
                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("cathodeBasePriceData", record.unitPrice);
                                            foreignInvoiceTab.dynamicForm.baseData.getField("inspectionAssayId").hide();
                                            foreignInvoiceTab.dynamicForm.baseData.getField("inspectionAssayId").setRequired(false);
                                        }

                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("percent", record.percent);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("delayData", record.delayPenalty);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("paymentValues", paymentValues);
                                        foreignInvoiceTab.dynamicForm.valuesManager.setValue("premiumValue", record.premiumValue);
                                        foreignInvoiceTab.dynamicForm.baseData.setValue('inspectionWeightId', record.inspectionWeightReportId);
                                        foreignInvoiceTab.dynamicForm.baseData.setValue('inspectionAssayId', record.inspectionAssayReportId);

                                        foreignInvoiceTab.button.selectBillLading.enable();
                                        foreignInvoiceTab.dynamicForm.baseData.getFields().forEach(field => {

                                            if (field.name === "date" || field.name === "invoiceTypeId")
                                                field.disable();
                                            else
                                                field.enable();
                                        });

                                        foreignInvoiceTab.window.main.show();
                                    }
                                });
                            }
                        });
                    }
                });
            }
        });
    }
};
foreignInvoiceTab.method.addTab = function (pane, title) {
    foreignInvoiceTab.tab.invoice.addTab({
        pane: pane,
        title: title,
        paneMargin: 5
    });
};
foreignInvoiceTab.method.continueTab = function () {

    foreignInvoiceTab.method.addTab(
        isc.InvoiceBaseInfo.create({
            invoiceNo: foreignInvoiceTab.dynamicForm.valuesManager.getValue('no'),
            invoiceDate: foreignInvoiceTab.dynamicForm.valuesManager.getValue('date'),
            contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract'),
            shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
            billLadings: foreignInvoiceTab.dynamicForm.valuesManager.getValue('billLadings'),
            invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue('invoiceType'),
        }), '<spring:message code="foreign-invoice.form.tab.contract-info"/>');

    ////// MOLYBDENUM_OXIDE //////
    if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.MOLYBDENUM_OXIDE) {

        let invoiceCalculation2Component = isc.InvoiceCalculation2.create({
            percent: foreignInvoiceTab.dynamicForm.valuesManager.getValue("percent"),
            remainingPercent: foreignInvoiceTab.dynamicForm.valuesManager.getValue("remainingPercent"),
            currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
            contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract'),
            shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
            molybdenumRowData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("molybdenumRowData"),
            contractDetailData: foreignInvoiceTab.variable.contractDetailData,
            inspectionAssayData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionAssayData"),
            inspectionWeightData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionWeightData"),
        });
        foreignInvoiceTab.method.addTab(invoiceCalculation2Component, '<spring:message code="foreign-invoice.form.tab.calculation"/>');
        invoiceCalculation2Component.okButtonClick = function addRelatedPaymentTab2() {

            let invoicePaymentComponent = isc.InvoicePayment.create({
                parentId: foreignInvoiceTab.dynamicForm.valuesManager.getValue("parentId"),
                currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                conversionRef: foreignInvoiceTab.dynamicForm.valuesManager.getValue('conversionRef'),
                delayData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("delayData"),
                paymentValues: foreignInvoiceTab.dynamicForm.valuesManager.getValue("paymentValues"),
                premiumValue: 0,
                invoiceCalculation2Component: invoiceCalculation2Component,
                invoiceBaseWeightComponent: {getValues: invoiceCalculation2Component.getBaseWeightValues},
                invoiceDeductionComponent: {getDeductionSubTotal: invoiceCalculation2Component.getDeductionSubTotal},
                invoiceCalculationComponent: {
                    getCalculationSubTotal: function () {
                        return invoiceCalculation2Component.getCalculationSubTotal();
                    }
                }
            });
            foreignInvoiceTab.method.addTab(invoicePaymentComponent, '<spring:message code="foreign-invoice.form.tab.payment"/>');
        }
        ////// COPPER_CONCENTRATES //////
    } else if (foreignInvoiceTab.variable.materialId === ImportantIDs.material.COPPER_CONCENTRATES) {

        let invoiceBaseValuesComponent = isc.InvoiceBaseValues.create({
            remainingPercent: foreignInvoiceTab.dynamicForm.valuesManager.getValue("remainingPercent"),
            currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
            contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue("contract"),
            shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
            contractDetailDataMOAS: foreignInvoiceTab.variable.contractDetailData.moas,
            invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue("invoiceType"),
            percent: foreignInvoiceTab.dynamicForm.valuesManager.getValue("percent"),
            basePriceData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("basePriceData"),
            inspectionWeightData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionWeightData"),
            inspectionAssayData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionAssayData"),
        });
        foreignInvoiceTab.method.addTab(invoiceBaseValuesComponent, '<spring:message code="foreign-invoice.form.tab.base-values"/>');

        invoiceBaseValuesComponent.okButtonClick = function () {

            let invoiceCalculationComponent = isc.InvoiceCalculation.create({
                currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                invoiceBaseAssayComponent: invoiceBaseValuesComponent.invoiceBaseAssayComponent,
                invoiceBasePriceComponent: invoiceBaseValuesComponent.invoiceBasePriceComponent,
                calculationData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("calculationData")
            });
            foreignInvoiceTab.method.addTab(invoiceCalculationComponent, '<spring:message code="foreign-invoice.form.tab.calculation"/>');

            invoiceCalculationComponent.okButtonClick = function addRelatedDeductionTab() {

                let invoiceDeductionComponent = isc.InvoiceDeduction.create({
                    invoiceCalculationComponent: invoiceCalculationComponent,
                    contractDetailDataTC: foreignInvoiceTab.variable.contractDetailData.tc,
                    contractDetailDataRC: foreignInvoiceTab.variable.contractDetailData.rc,
                    currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue('currency'),
                    rcDeductionData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("rcDeductionData")
                });
                foreignInvoiceTab.method.addTab(invoiceDeductionComponent, '<spring:message code="foreign-invoice.form.tab.deduction"/>');
                invoiceDeductionComponent.okButtonClick = function addRelatedPaymentTab() {

                    let invoicePaymentComponent = isc.InvoicePayment.create({
                        parentId: foreignInvoiceTab.dynamicForm.valuesManager.getValue("parentId"),
                        currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                        shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                        conversionRef: foreignInvoiceTab.dynamicForm.valuesManager.getValue('conversionRef'),
                        delayData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("delayData"),
                        paymentValues: foreignInvoiceTab.dynamicForm.valuesManager.getValue("paymentValues"),
                        premiumValue: 0,
                        invoiceDeductionComponent: invoiceDeductionComponent,
                        invoiceCalculationComponent: invoiceCalculationComponent,
                        invoiceBaseWeightComponent: invoiceBaseValuesComponent.invoiceBaseWeightComponent
                    });
                    foreignInvoiceTab.method.addTab(invoicePaymentComponent, '<spring:message code="foreign-invoice.form.tab.payment"/>');
                }
            }
        }
        ////// COPPER_CATHODE //////
    } else {

        let invoiceCalculationCathodeComponent = isc.InvoiceCalculationCathode.create({
            percent: foreignInvoiceTab.dynamicForm.valuesManager.getValue("percent"),
            remainingPercent: foreignInvoiceTab.dynamicForm.valuesManager.getValue("remainingPercent"),
            currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
            contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract'),
            shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
            basePriceData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("cathodeBasePriceData"),
            premiumValueData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("premiumValue"),
            contractDetailData: foreignInvoiceTab.variable.contractDetailData,
            inspectionWeightData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("inspectionWeightData"),
        });
        foreignInvoiceTab.method.addTab(invoiceCalculationCathodeComponent, '<spring:message code="foreign-invoice.form.tab.calculation"/>');
        invoiceCalculationCathodeComponent.okButtonClick = function addRelatedPaymentTab2() {

            let invoicePaymentComponent = isc.InvoicePayment.create({
                parentId: foreignInvoiceTab.dynamicForm.valuesManager.getValue("parentId"),
                currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                conversionRef: foreignInvoiceTab.dynamicForm.valuesManager.getValue('conversionRef'),
                delayData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("delayData"),
                paymentValues: foreignInvoiceTab.dynamicForm.valuesManager.getValue("paymentValues"),
                premiumValue: invoiceCalculationCathodeComponent.getPremiumValue(),
                invoiceCalculationCathodeComponent: invoiceCalculationCathodeComponent,
                invoiceBaseWeightComponent: invoiceCalculationCathodeComponent.invoiceBaseWeightComponent,
                invoiceDeductionComponent: {getDeductionSubTotal: invoiceCalculationCathodeComponent.getDeductionSubTotal},
                invoiceCalculationComponent: {
                    getCalculationSubTotal: function () {
                        return invoiceCalculationCathodeComponent.getCalculationSubTotal();
                    }
                }
            });
            foreignInvoiceTab.method.addTab(invoicePaymentComponent, '<spring:message code="foreign-invoice.form.tab.payment"/>');
        }
    }

    foreignInvoiceTab.window.main.close();
    foreignInvoiceTab.variable.invoiceForm.justShowForm();
};
foreignInvoiceTab.method.relatedInvoice = function (listgrid) {

    let record = listgrid.getSelectedRecord();
    if (record == null)
        foreignInvoiceTab.dialog.notSelected();
    else {
        let referenceId = record.parentId ? record.parentId : record.id;

        let relatedCriteria = {
            _constructor: "AdvancedCriteria",
            operator: "or",
            criteria: [
                {
                    fieldName: "id",
                    operator: "equals",
                    value: referenceId
                },
                {
                    fieldName: "parentId",
                    operator: "equals",
                    value: referenceId
                }
            ]
        };
        let implicitCriteria = clone(listgrid.getImplicitCriteria());
        implicitCriteria.criteria.add(relatedCriteria);
        listgrid.filterData(implicitCriteria);

    }
};
foreignInvoiceTab.method.sendToAcc = function (listgrid) {

    let record = listgrid.getSelectedRecord();
    if (record == null || record.id == null)
        foreignInvoiceTab.dialog.notSelected();
    else if (!record.estatus.contains(Enums.eStatus2.Final))
        foreignInvoiceTab.dialog.say("<spring:message code='accounting.document.check.status'/>");
    else {

        foreignInvoiceTab.dynamicForm.sentToAccountingInvoiceForm.clearValues();
        foreignInvoiceTab.dynamicForm.sentToAccountingDocumentForm.clearValues();

        foreignInvoiceTab.method.jsonRPCManagerRequest({
            httpMethod: "GET",
            actionURL: "${contextPath}/api/foreign-invoice/acc-info/" + record.id,
        }, (resp) => {
            if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

                let data = JSON.parse(resp.data);

                let toCurrencyName = data.conversionRef !== undefined ? data.conversionRef.unitTo.name : data.currency.name;
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("id", record.id);
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("invoiceTypeId", data.invoiceType.title);
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("date", new Date(data.date));
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("shipmentId", new Date(data.shipment.sendDate));
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("creatorId", data.creator.fullName);
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("sumPrice", data.sumPrice);
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("currencyId", data.currency.name);
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("toCurrencyId", toCurrencyName);
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("conversionSumPrice", data.conversionSumPrice);
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("conversionSumPriceText",
                    nicico.CommonUtil.getLang() === "fa" ? String(data.conversionSumPrice).toPersianLetter() + " " + toCurrencyName :
                        numberToEnglish(NumberUtil.format(data.conversionSumPrice, "#.##")) + " " + toCurrencyName);
                foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("conversionRate", data.conversionRate);

                foreignInvoiceTab.window.sentToAccounting.justShowForm();
            }
        });
    }
};
foreignInvoiceTab.method.print = function (listgrid) {

    let record = listgrid.getSelectedRecord();
    if (!record || !record.id)
        foreignInvoiceTab.dialog.notSelected();
    else if (record.shipment.materialId === ImportantIDs.material.COPPER_CONCENTRATES) {
        window.open('${printUrl}' + record.id);
    }
};
foreignInvoiceTab.method.backToUnSent = function (listgrid) {

    let record = listgrid.getSelectedRecord();
    if (!record || !record.id)
        foreignInvoiceTab.dialog.notSelected();
    else {

        foreignInvoiceTab.method.jsonRPCManagerRequest({
            httpMethod: "POST",
            actionURL: "${contextPath}/api/foreign-invoice/back-to-unSent/" + record.id,
            callback: function (resp) {
                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

                    foreignInvoiceTab.method.refresh(foreignInvoiceTab.listGrid.invoiceDeleted);
                    foreignInvoiceTab.method.refresh(foreignInvoiceTab.listGrid.main);
                }
            }
        });
    }
};

foreignInvoiceTab.listGrid.main.rowClick = function (record, recordNum, fieldNum) {

    foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.EDIT).first().show();
    foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DELETE).first().show();
    foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.ACTIVATE).first().show();
    foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DEACTIVATE).first().show();
    foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.FINALIZE).first().show();
    foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DISAPPROVE).first().show();
    // <sec:authorize access="hasAuthority('C_FOREIGN_INVOICE_COMPLETION')">
    foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "invoiceCompletion").first().show();
    // </sec:authorize>
    foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "relatedInvoice").first().show();

    if (record.parentId) {
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.EDIT).first().hide();
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.ACTIVATE).first().hide();
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DEACTIVATE).first().hide();
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.FINALIZE).first().hide();
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DISAPPROVE).first().hide();
        // <sec:authorize access="hasAuthority('C_FOREIGN_INVOICE_COMPLETION')">
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "invoiceCompletion").first().hide();
        // </sec:authorize>
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "relatedInvoice").first().show();
    }
    else
    // <c:if test="<%= !com.nicico.copper.core.SecurityUtil.isAdmin()%>">
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DELETE).first().hide();
    // </c:if>

    this.Super("rowClick", arguments);
};
foreignInvoiceTab.listGrid.main.getCellCSSText = function (record, rowNum, colNum) {

    if (record.parentId) {
        return "font-weight:bold; color:#2f8be0;";
    }
    return this.Super('getCellCSSText', arguments)
};

