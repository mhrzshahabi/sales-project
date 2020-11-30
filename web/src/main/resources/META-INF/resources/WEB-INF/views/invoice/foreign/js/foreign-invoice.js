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
        title: "<spring:message code='foreign-invoice.form.invoice-type'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "sumPrice",
        title: "<spring:message code='foreign-invoice.form.sum-price'/>"
    },
    {
        width: "100%",
        showHover: true,
        name: "conversionSumPrice",
        title: "<spring:message code='foreign-invoice.form.conversion-sum-price'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "buyer.nameEN",
        title: "<spring:message code='foreign-invoice.form.buyer'/>"
    },
    {
        width: "100%",
        type: "date",
        required: true,
        showHover: true,
        name: "shipment.sendDate",
        title: "<spring:message code='global.sendDate'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "shipment.material.descEN",
        title: "<spring:message code='material.descEN'/>"
    },
    {
        width: "100%",
        required: true,
        showHover: true,
        name: "creator.fullName",
        title: "<spring:message code='foreign-invoice.form.creator'/>"
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
        title: "<spring:message code='foreign-invoice.form.percent'/>"
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
            {name: "contact.nameEN", title: "<spring:message code='foreign-invoice.form.shipment'/>"},
            {name: "material.descEN", title: "<spring:message code='material.descEN'/>"},
            {name: "amount", title: "<spring:message code='global.amount'/>"},
            {name: "automationLetterNo", title: "<spring:message code='shipment.loadingLetter'/>"},
        ],
        optionDataSource: isc.MyRestDataSource.create({
            fields: [
                {name: "id", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
                {name: "contact.nameEN", title: "<spring:message code='foreign-invoice.form.shipment'/>"},
                {name: "material.descEN", title: "<spring:message code='material.descEN'/>"},
                {name: "amount", title: "<spring:message code='global.amount'/>"},
                {name: "automationLetterNo", title: "<spring:message code='shipment.loadingLetter'/>"},
            ],
            fetchDataURL: foreignInvoiceTab.variable.shipmentUrl + "spec-list"
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

//***************************************************** RESTDATASOURCE *************************************************

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
    icon: "pieces/16/save.png",
    title: "<spring:message code='global.form.add.detail'/>",
    click: function () {

        let contractId;
        if (!foreignInvoiceTab.variable.completionInvoice)
            contractId = foreignInvoiceTab.dynamicForm.baseData.getValue("contractId");
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

                    if (!foreignInvoiceTab.dynamicForm.baseData.validate()) return;

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
                    // let selectedShipmentRemittanceDetailsCount = foreignInvoiceTab.dynamicForm.valuesManager.getValue('remittanceDetailId').length;
                    // let allShipmentRemittanceDetailsCount = Object.keys(foreignInvoiceTab.dynamicForm.baseData.getField('remittanceDetailId').getAllValueMappings()).length;
                } else {

                    let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
                    console.log("record ", record);
                    foreignInvoiceTab.tab.invoice.removeTabs(foreignInvoiceTab.tab.invoice.tabs);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('parentId', record.id);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('currency', record.currency);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('conversionRef', record.conversionRef);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('invoiceType', record.invoiceType);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('contract', record.shipment.contractShipment.contract);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('shipment', record.shipment);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('inspectionWeightData', record.inspectionWeightReport);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('inspectionAssayData', record.inspectionAssayReport);
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('date', foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm.getValue("date"));
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('creator', foreignInvoiceTab.dynamicForm.invoiceCompletionDynamicForm.getField("creatorId").getSelectedRecord());
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('billLadings', foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager.getValue('billLadings'));
                    foreignInvoiceTab.dynamicForm.valuesManager.setValue('remainingPercent', foreignInvoiceTab.dynamicForm.invoiceCompletionValuesManager.getValue('remainingPercent'));
                }

                foreignInvoiceTab.method.addTab(
                    isc.InvoiceBaseInfo.create({
                        invoiceNo: foreignInvoiceTab.dynamicForm.valuesManager.getValue('no'),
                        invoiceDate: foreignInvoiceTab.dynamicForm.valuesManager.getValue('date'),
                        contract: foreignInvoiceTab.dynamicForm.valuesManager.getValue('contract'),
                        billLadings: foreignInvoiceTab.dynamicForm.valuesManager.getValue('billLadings'),
                        invoiceType: foreignInvoiceTab.dynamicForm.valuesManager.getValue('invoiceType'),
                        contractDetailDataIncoterm: foreignInvoiceTab.variable.contractDetailData.incoterm,
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
                            // shipmentCostInvoiceRate: selectedShipmentRemittanceDetailsCount / allShipmentRemittanceDetailsCount,
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
                                    // shipmentCostInvoiceRate: selectedShipmentRemittanceDetailsCount / allShipmentRemittanceDetailsCount,
                                    parentId: foreignInvoiceTab.dynamicForm.valuesManager.getValue("parentId"),
                                    currency: foreignInvoiceTab.dynamicForm.valuesManager.getValue("currency"),
                                    shipment: foreignInvoiceTab.dynamicForm.valuesManager.getValue("shipment"),
                                    conversionRef: foreignInvoiceTab.dynamicForm.valuesManager.getValue('conversionRef'),
                                    delayData: foreignInvoiceTab.dynamicForm.valuesManager.getValue("delayData"),
                                    paymentValues: foreignInvoiceTab.dynamicForm.valuesManager.getValue("paymentValues"),
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
            }
        });

    }
});

foreignInvoiceTab.button.cancel = isc.IButtonCancel.create({
    margin: 10,
    height: 50,
    icon: "pieces/16/icon_delete.png",
    title: "<spring:message code='global.cancel'/>",
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
                {name: "portOfLoading.port", title: "<spring:message code='billOfLanding.port.of.landing'/>"},
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

    } else {
        ///// COPPER CATHODE /////
        let invoiceCalculationCathodeComponent = foreignInvoiceTab.tab.invoice.tabs.filter(t => t.pane.Class === isc.InvoiceCalculationCathode.Class).first().pane;
        data.percent = invoiceCalculationCathodeComponent.invoiceBaseWeightComponent.getValues().percent;
        data.foreignInvoiceItems = invoiceCalculationCathodeComponent.getForeignInvoiceItems();
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
    debugger
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
    width: "100%",
    align: "center",
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
            canEdit: false,
            title: "<spring:message code='foreign-invoice.form.invoice-type'/>",
            width: "100%"
        },
        {
            name: "date",
            canEdit: false,
            title: "<spring:message code='foreign-invoice.form.date'/>",
            width: "100%",
        },
        {
            name: "shipmentId",
            canEdit: false,
            title: "<spring:message code='foreign-invoice.form.shipment'/>",
            width: "100%"
        },
        {
            name: "creatorId",
            canEdit: false,
            title: "<spring:message code='foreign-invoice.form.creator'/>",
            width: "100%",
        },
        {
            name: "currencyId",
            canEdit: false,
            title: "<spring:message code='foreign-invoice.form.currency'/>",
            width: "100%"
        },
        {
            name: "sumPrice",
            canEdit: false,
            title: "<spring:message code='shipmentCostInvoice.sumPrice'/>",
            width: "100%"
        },
        {
            name: "conversionRate",
            canEdit: false,
            title: "<spring:message code='foreign-invoice.conversionRate'/>",
            width: "100%"
        },
        {
            name: "conversionSumPrice",
            canEdit: false,
            title: "<spring:message code='foreign-invoice.conversionSumPrice'/>",
            width: "100%"
        },
        {
            name: "conversionSumPriceText",
            canEdit: false,
            title: "<spring:message code='foreign-invoice.conversionSumPriceText'/>",
            width: "100%"
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
            pickListWidth: "250",
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
}), "700", "40%");
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

            let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
            let respData = JSON.stringify(resp.httpResponseText).split("@");
            record.documentId = respData[1].replace("\"", "");
            isc.say(respData[0]);
        }
    });
};

//****************************************************** Main **********************************************************

nicico.BasicFormUtil.createListGrid = function () {

    foreignInvoiceTab.listGrid.main = isc.ListGrid.nicico.getDefault(
        foreignInvoiceTab.listGrid.fields,
        foreignInvoiceTab.restDataSource.main,
        {operator: "and", criteria: [{fieldName: 'eStatusId', operator: 'lessThan', value: 8}]},
        {sortField: 1, sortDirection: "descending"});
};
nicico.BasicFormUtil.createTabSet = function () {

    foreignInvoiceTab.tab.main = isc.TabSet.create({
        width: "100%",
        height: "100%",
        tabBarPosition: nicico.CommonUtil.getAlignByLangReverse(),
        // wrap: false,
        showTabScroller: true,
        border: "1px solid lightblue",
        edgeMarginSize: 3,
        tabBarThickness: 80,
        tabs: [
            {
                title: "<spring:message code='issuedInternalInvoices.dontSent'/>",
                pane: foreignInvoiceTab.listGrid.main,
                name: "notSent"
            },
            {
                title: "<spring:message code='issuedInternalInvoices.sent'/>",
                pane: foreignInvoiceTab.listGrid.main,
                name: "sent"
            },
            {
                title: "<spring:message code='issuedInternalInvoices.deleted'/>",
                pane: foreignInvoiceTab.listGrid.main,
                name: "deleted"
            }
        ],
        tabSelected: function (tabNum, tabPane, ID, tab, name) {
            if (name === "notSent") {

                foreignInvoiceTab.listGrid.main.setCriteria(null);
                foreignInvoiceTab.listGrid.main.setImplicitCriteria({
                    operator: "and",
                    criteria: [{fieldName: 'eStatusId', operator: 'lessThan', value: 8}]
                });
                foreignInvoiceTab.toolStrip.main.getMembers().forEach(q => q.show());
                if (foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "updateStatus").first() !== undefined)
                    foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "updateStatus").first().hide();

                foreignInvoiceTab.menu.main.getMembers().forEach(q => q.show());

            } else if (name === "sent") {

                foreignInvoiceTab.listGrid.main.setCriteria(null);
                foreignInvoiceTab.listGrid.main.setImplicitCriteria({
                    operator: "and",
                    criteria: [{fieldName: 'eStatusId', operator: 'greaterOrEqual', value: 8},
                        {fieldName: 'eStatusId', operator: 'lessThan', value: 16}]
                });
                foreignInvoiceTab.toolStrip.main.getMembers().forEach(q => q.hide());
                // <c:if test = "${P_FOREIGN_INVOICE}">
                foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "print").first().show();
                // </c:if>
                foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "refresh").first().show();
                foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "relatedInvoice").first().show();

                foreignInvoiceTab.menu.main.getMembers().forEach(q => q.hide());

            } else if (name === "deleted") {

                foreignInvoiceTab.listGrid.main.setCriteria(null);
                foreignInvoiceTab.listGrid.main.setImplicitCriteria({
                    operator: "and",
                    criteria: [{fieldName: 'eStatusId', operator: 'greaterOrEqual', value: 16}]
                });
                foreignInvoiceTab.toolStrip.main.getMembers().forEach(q => q.hide());
                // <c:if test = "${P_FOREIGN_INVOICE}">
                foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "print").first().show();
                // </c:if>
                foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "refresh").first().show();
                // <c:if test = "${E_UPDATE_FOREIGN_INVOICE_DOC_ID}">
                foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "updateStatus").first().show();
                // </c:if>
                foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "relatedInvoice").first().show();
                // <c:if test = "${E_SEND_FOREIGN_INVOICE_TO_ACC}">
                foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "SentToAccounting").first().show();
                // </c:if>

                foreignInvoiceTab.menu.main.getMembers().forEach(q => q.hide());
            }
        }
    });
};

// nicico.BasicFormUtil.getDefaultBasicForm(foreignInvoiceTab, "api/foreign-invoice/");
nicico.BasicFormUtil.getDefaultBasicFormWithTabSet(foreignInvoiceTab, "api/foreign-invoice/");
nicico.BasicFormUtil.showAllToolStripActions(foreignInvoiceTab);
nicico.BasicFormUtil.removeExtraGridMenuActions(foreignInvoiceTab);

foreignInvoiceTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    visibility: "visible",
    icon: "pieces/16/icon_view.png",
    name: "relatedInvoice",
    title: "<spring:message code='global.form.related.invoice'/>",
    click: function () {

        let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
        if (record == null)
            foreignInvoiceTab.dialog.notSelected();
        else {
            let referenceId = record.parentId ? record.parentId : record.id;
            // let criteria = {
            //     operator: 'and',
            //     _constructor: "AdvancedCriteria",
            //     criteria: []
            // };
            // let implicit = foreignInvoiceTab.listGrid.main.getImplicitCriteria().criteria[0];
            // foreignInvoiceTab.listGrid.main.setImplicitCriteria(null);
            // criteria.criteria.add(implicit);
            // criteria.criteria.add({
            //         _constructor: "AdvancedCriteria",
            //         operator: "or",
            //         criteria:
            //             [
            //                 {
            //                     fieldName: "id",
            //                     operator: "equals",
            //                     value: referenceId
            //                 },
            //                 {
            //                     fieldName: "parentId",
            //                     operator: "equals",
            //                     value: referenceId
            //                 }
            //             ]
            //     });
            // foreignInvoiceTab.listGrid.main.setImplicitCriteria(criteria);

            foreignInvoiceTab.listGrid.main.setCriteria({
                _constructor: "AdvancedCriteria",
                operator: "or",
                criteria:
                    [
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
            });
        }
    }
}), 7);
// <c:if test = "${C_FOREIGN_INVOICE_COMPLETION}">
foreignInvoiceTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    visibility: "visible",
    icon: "[SKIN]/actions/configure.png",
    name: "invoiceCompletion",
    title: "<spring:message code='global.completion.foreign.invoice'/>",
    click: function () {

        foreignInvoiceTab.variable.method = "POST";
        foreignInvoiceTab.variable.completionInvoice = true;
        let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
        foreignInvoiceTab.button.selectBillLadingCompletion.criteria = {
            operator: "equals",
            fieldName: "shipmentId",
            value: record.shipmentId
        };
        foreignInvoiceTab.button.selectBillLadingCompletion.enable();
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
                    foreignInvoiceTab.window.invoiceCompletionForm.justShowForm();
                }
            });
        }
    }
}), 8);
// </c:if>
// <c:if test = "${E_SEND_FOREIGN_INVOICE_TO_ACC}">
foreignInvoiceTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    visibility: "visible",
    icon: "pieces/receipt.png",
    name: "SentToAccounting",
    title: "<spring:message code='accounting.document.create'/>",
    click: function () {

        let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
        if (record == null || record.id == null)
            foreignInvoiceTab.dialog.notSelected();
        else if (!record.estatus.contains(Enums.eStatus2.Final))
            foreignInvoiceTab.dialog.say("<spring:message code='accounting.document.check.status'/>");
        else {

            foreignInvoiceTab.dynamicForm.sentToAccountingInvoiceForm.clearValues();
            foreignInvoiceTab.dynamicForm.sentToAccountingDocumentForm.clearValues();

            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("id", record.id);
            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("invoiceTypeId", record.invoiceType.title);
            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("date", new Date(record.date));
            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("shipmentId", new Date(record.shipment.sendDate));
            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("creatorId", record.creator.fullName);
            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("sumPrice", record.sumPrice);
            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("currencyId", record.currency.name);
            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("conversionSumPrice", record.conversionSumPrice);
            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("conversionSumPriceText", record.conversionSumPriceText);
            foreignInvoiceTab.dynamicForm.sentToAccountingValuesManager.setValue("conversionRate", record.conversionRate);

            foreignInvoiceTab.window.sentToAccounting.justShowForm();
        }
    }
}), 9);
// </c:if>
// <c:if test = "${E_UPDATE_FOREIGN_INVOICE_DOC_ID}">
foreignInvoiceTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    icon: "pieces/16/refresh.png",
    name: "updateStatus",
    visibility: "hidden",
    title: "<spring:message code='accounting.document.change.status'/>",
    click: function () {

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/foreign-invoice/update-deleted-document",
            httpMethod: "GET",
            params: {
                criteria: {
                    operator: "and",
                    criteria: [{fieldName: 'eStatusId', operator: 'greaterOrEqual', value: 16}]
                }
            },
            useSimpleHttp: true,
            contentType: "application/json; charset=utf-8",
            willHandleError: true,
            serverOutputAsString: false,
            callback: function (resp) {
                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {

                    foreignInvoiceTab.method.refresh(foreignInvoiceTab.listGrid.main);
                }
            }
        }));
    }
}), 10);
// </c:if>
// <c:if test = "${P_FOREIGN_INVOICE}">
foreignInvoiceTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    icon: "[SKIN]/actions/print.png",
    name: "print",
    title: "<spring:message code='global.form.print'/>",
    click: function () {

        let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
        if (!record || !record.id)
            foreignInvoiceTab.dialog.notSelected();
        else if (record.shipment.materialId === ImportantIDs.material.COPPER_CONCENTRATES) {

            let record = foreignInvoiceTab.listGrid.main.getSelectedRecord();
            window.open('${printUrl}' + record.id);
        }
    }
}), 11);
// </c:if>

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
    // Concentrate
    // foreignInvoiceTab.dynamicForm.valuesManager.setValues({
    //     "date": "2020-10-07T08:30:00.000Z",
    //     "invoiceTypeId": 1,
    //     "contractId": 1,
    //     "billLadings": [
    //         {
    //             "documentNo": "123123",
    //             "switchDocumentNo": "123123",
    //             "shipperExporterId": 41,
    //             "switchShipperExporterId": 41,
    //             "notifyPartyId": 2,
    //             "switchNotifyPartyId": 2,
    //             "consigneeId": 1,
    //             "switchConsigneeId": 1,
    //             "portOfLoadingId": 2,
    //             "switchPortOfLoadingId": 2,
    //             "portOfDischargeId": 31,
    //             "switchPortOfDischargeId": 31,
    //             "placeOfDelivery": "ABU DHABI",
    //             "oceanVesselId": 37,
    //             "numberOfBlCopies": 2,
    //             "dateOfIssue": 1600587000000,
    //             "placeOfIssue": "tehran",
    //             "description": "asd",
    //             "totalNet": 123,
    //             "totalGross": 3,
    //             "totalBundles": 123,
    //             "shipmentId": 1,
    //             "shipmentTypeId": 1,
    //             "shipmentMethodId": 1,
    //             "id": 1,
    //             "shipperExporter": {
    //                 "nameFA": "سونگ ایک خار",
    //                 "nameEN": "XSUNGILL RESOURCES LTD",
    //                 "name": "XSUNGILL RESOURCES LTD",
    //                 "phone": "8511101111",
    //                 "fax": "85237020210",
    //                 "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 41,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1579683563975,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1601359142895,
    //                 "lastModifiedBy": "root",
    //                 "version": 3
    //             },
    //             "switchShipperExporter": {
    //                 "nameFA": "سونگ ایک خار",
    //                 "nameEN": "XSUNGILL RESOURCES LTD",
    //                 "name": "XSUNGILL RESOURCES LTD",
    //                 "phone": "8511101111",
    //                 "fax": "85237020210",
    //                 "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 41,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1579683563975,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1601359142895,
    //                 "lastModifiedBy": "root",
    //                 "version": 3
    //             },
    //             "notifyParty": {
    //                 "nameFA": "شرکت ملی صنایع مس ایران",
    //                 "nameEN": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "name": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "phone": "+982182138231",
    //                 "fax": "+982188102822",
    //                 "address": "NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Seller",
    //                 "seller": true,
    //                 "buyer": false,
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFA": "ایران",
    //                     "nameEN": "Iran (Islamic Republic of)",
    //                     "name": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1578197254109,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1601451512407,
    //                 "lastModifiedBy": "emami",
    //                 "version": 7
    //             },
    //             "switchNotifyParty": {
    //                 "nameFA": "شرکت ملی صنایع مس ایران",
    //                 "nameEN": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "name": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "phone": "+982182138231",
    //                 "fax": "+982188102822",
    //                 "address": "NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Seller",
    //                 "seller": true,
    //                 "buyer": false,
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFA": "ایران",
    //                     "nameEN": "Iran (Islamic Republic of)",
    //                     "name": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1578197254109,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1601451512407,
    //                 "lastModifiedBy": "emami",
    //                 "version": 7
    //             },
    //             "consignee": {
    //                 "nameFA": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "nameEN": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "name": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "phone": "+8601068495586",
    //                 "fax": "+8601068495562",
    //                 "address": "NO.5 SANLIHE ROAD, HAIDIAN DISTRICT, BEIJING 100044, P.R. CHINA ",
    //                 "type": false,
    //                 "nationalCode": "0",
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "seller": false,
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 1,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1578197169411,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600688095376,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 47,
    //                 "defaultAccount": {
    //                     "contactId": 1,
    //                     "bankId": 2,
    //                     "bankAccount": "90101",
    //                     "bankShaba": "IR888888800000000008888888",
    //                     "code": "110019",
    //                     "bankSwift": "898888800000088",
    //                     "accountOwner": "88000008",
    //                     "status": true,
    //                     "isDefault": true,
    //                     "id": 10,
    //                     "bank": {
    //                         "nameFA": "ای سی ای",
    //                         "countryId": 15,
    //                         "nameEN": "ECA",
    //                         "address": "NY",
    //                         "coreBranch": "core"
    //                     },
    //                     "createdDate": 1600245090704,
    //                     "createdBy": "db_zare",
    //                     "lastModifiedDate": 1600690356857,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 9
    //                 }
    //             },
    //             "switchConsignee": {
    //                 "nameFA": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "nameEN": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "name": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "phone": "+8601068495586",
    //                 "fax": "+8601068495562",
    //                 "address": "NO.5 SANLIHE ROAD, HAIDIAN DISTRICT, BEIJING 100044, P.R. CHINA ",
    //                 "type": false,
    //                 "nationalCode": "0",
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "seller": false,
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 1,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1578197169411,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600688095376,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 47,
    //                 "defaultAccount": {
    //                     "contactId": 1,
    //                     "bankId": 2,
    //                     "bankAccount": "90101",
    //                     "bankShaba": "IR888888800000000008888888",
    //                     "code": "110019",
    //                     "bankSwift": "898888800000088",
    //                     "accountOwner": "88000008",
    //                     "status": true,
    //                     "isDefault": true,
    //                     "id": 10,
    //                     "bank": {
    //                         "nameFA": "ای سی ای",
    //                         "countryId": 15,
    //                         "nameEN": "ECA",
    //                         "address": "NY",
    //                         "coreBranch": "core"
    //                     },
    //                     "createdDate": 1600245090704,
    //                     "createdBy": "db_zare",
    //                     "lastModifiedDate": 1600690356857,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 9
    //                 }
    //             },
    //             "portOfLoading": {
    //                 "port": "BANDAR ABBAS",
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFA": "ایران",
    //                     "nameEN": "Iran (Islamic Republic of)",
    //                     "name": "Iran (Islamic Republic of)",
    //                     "id": 1,
    //                     "createdDate": 1599977039976,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1578198852719,
    //                 "createdBy": "dorani_sa",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfLoading": {
    //                 "port": "BANDAR ABBAS",
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFA": "ایران",
    //                     "nameEN": "Iran (Islamic Republic of)",
    //                     "name": "Iran (Islamic Republic of)",
    //                     "id": 1,
    //                     "createdDate": 1599977039976,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1578198852719,
    //                 "createdBy": "dorani_sa",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "portOfDischarge": {
    //                 "port": "ABU DHABI",
    //                 "countryId": 3,
    //                 "id": 31,
    //                 "country": {
    //                     "nameFA": "افغانستان",
    //                     "nameEN": "Afghanistan",
    //                     "name": "Afghanistan",
    //                     "id": 3,
    //                     "createdDate": 1599977039990,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587866317999,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfDischarge": {
    //                 "port": "ABU DHABI",
    //                 "countryId": 3,
    //                 "id": 31,
    //                 "country": {
    //                     "nameFA": "افغانستان",
    //                     "nameEN": "Afghanistan",
    //                     "name": "Afghanistan",
    //                     "id": 3,
    //                     "createdDate": 1599977039990,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587866317999,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "oceanVessel": {
    //                 "name": "AGIA ELENI",
    //                 "type": "Bulk Carrier",
    //                 "imo": "9370317",
    //                 "yearOfBuild": 2008,
    //                 "length": 170.7,
    //                 "beam": 27,
    //                 "id": 37,
    //                 "createdDate": 1588382861641,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "containers": [
    //                 {
    //                     "billOfLandingId": 1,
    //                     "containerType": "20foot",
    //                     "containerNo": "123",
    //                     "sealNo": "123",
    //                     "quantity": 123,
    //                     "quantityType": "ورق",
    //                     "weight": 2,
    //                     "unitId": 5,
    //                     "id": 1,
    //                     "unit": {
    //                         "nameFA": "شاخه",
    //                         "nameEN": "شاخه",
    //                         "name": "شاخه",
    //                         "categoryUnit": "Weight",
    //                         "symbolUnit": "BULK",
    //                         "id": 5,
    //                         "createdDate": 1600057458454,
    //                         "createdBy": "taghavifar",
    //                         "version": 0,
    //                         "editable": false,
    //                         "estatus": [
    //                             "Active"
    //                         ]
    //                     },
    //                     "createdDate": 1600070537703,
    //                     "createdBy": "taghavifar",
    //                     "lastModifiedDate": 1601355368165,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 1,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 }
    //             ],
    //             "shipmentType": {
    //                 "shipmentType": "فله",
    //                 "id": 1,
    //                 "createdDate": 1587278588350,
    //                 "createdBy": "j.azad",
    //                 "lastModifiedDate": 1587278588350,
    //                 "lastModifiedBy": "j.azad",
    //                 "version": 0
    //             },
    //             "shipmentMethod": {
    //                 "shipmentMethod": "حمل زمینی",
    //                 "id": 1,
    //                 "createdDate": 1587278588350,
    //                 "createdBy": "j.azad",
    //                 "lastModifiedDate": 1587278588350,
    //                 "lastModifiedBy": "j.azad",
    //                 "version": 0
    //             },
    //             "createdDate": 1600070495670,
    //             "createdBy": "taghavifar",
    //             "lastModifiedDate": 1600576546950,
    //             "lastModifiedBy": "taghavifar",
    //             "version": 1,
    //             "editable": true,
    //             "shipment": {
    //                 "contractShipmentId": 1,
    //                 "shipmentTypeId": 1,
    //                 "shipmentMethodId": 2,
    //                 "contactId": 41,
    //                 "materialId": 3,
    //                 "contactAgentId": 136,
    //                 "vesselId": 37,
    //                 "unitId": 4,
    //                 "dischargePortId": 31,
    //                 "amount": 70000,
    //                 "automationLetterNo": "1242",
    //                 "automationLetterDate": 1596396600000,
    //                 "sendDate": 1473811200000,
    //                 "noBLs": 2,
    //                 "bookingCat": "1234",
    //                 "arrivalDateFrom": 1581669000000,
    //                 "arrivalDateTo": 1581669000000,
    //                 "lastDeliveryLetterDate": 1600068600000,
    //                 "id": 1,
    //                 "createdDate": 1600068124999,
    //                 "createdBy": "m.shahabi",
    //                 "lastModifiedDate": 1600762686847,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 1,
    //                 "editable": true,
    //                 "unit": {
    //                     "nameFA": "بسته",
    //                     "nameEN": "BUNDLE",
    //                     "name": "BUNDLE",
    //                     "categoryUnit": "Weight",
    //                     "symbolUnit": "PERCENT",
    //                     "id": 4,
    //                     "createdDate": 1593755140054,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1594100538548,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 2,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "vessel": {
    //                     "name": "AGIA ELENI",
    //                     "type": "Bulk Carrier",
    //                     "imo": "9370317",
    //                     "yearOfBuild": 2008,
    //                     "length": 170.7,
    //                     "beam": 27,
    //                     "id": 37,
    //                     "createdDate": 1588382861641,
    //                     "createdBy": "db_mazloom",
    //                     "version": 0,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "contact": {
    //                     "nameFA": "سونگ ایک خار",
    //                     "nameEN": "XSUNGILL RESOURCES LTD",
    //                     "name": "XSUNGILL RESOURCES LTD",
    //                     "phone": "8511101111",
    //                     "fax": "85237020210",
    //                     "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
    //                     "type": false,
    //                     "status": true,
    //                     "commercialRole": "Buyer",
    //                     "buyer": true,
    //                     "countryId": 2,
    //                     "id": 41,
    //                     "country": {
    //                         "nameFA": "چین",
    //                         "nameEN": "China",
    //                         "name": "China"
    //                     },
    //                     "createdDate": 1579683563975,
    //                     "createdBy": "dorani_sa",
    //                     "lastModifiedDate": 1601359142895,
    //                     "lastModifiedBy": "root",
    //                     "version": 3
    //                 },
    //                 "dischargePort": {
    //                     "port": "ABU DHABI",
    //                     "countryId": 3,
    //                     "id": 31,
    //                     "country": {
    //                         "nameFA": "افغانستان",
    //                         "nameEN": "Afghanistan",
    //                         "name": "Afghanistan",
    //                         "id": 3,
    //                         "createdDate": 1599977039990,
    //                         "createdBy": "j.azad",
    //                         "version": 0,
    //                         "editable": false,
    //                         "estatus": [
    //                             "Active"
    //                         ]
    //                     },
    //                     "createdDate": 1587866317999,
    //                     "createdBy": "db_mazloom",
    //                     "version": 0,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "contactAgent": {
    //                     "nameFA": "GRASH DARYA",
    //                     "nameEN": "GRASH DARYA",
    //                     "name": "GRASH DARYA",
    //                     "phone": "21-88727255",
    //                     "fax": "21-88726762",
    //                     "type": false,
    //                     "status": true,
    //                     "tradeMark": "GRASH DARYA",
    //                     "commercialRole": "Transporter",
    //                     "seller": false,
    //                     "transporter": true,
    //                     "agentBuyer": false,
    //                     "countryId": 1,
    //                     "id": 136,
    //                     "country": {
    //                         "nameFA": "ایران",
    //                         "nameEN": "Iran (Islamic Republic of)",
    //                         "name": "Iran (Islamic Republic of)"
    //                     },
    //                     "createdDate": 1587875271899,
    //                     "createdBy": "db_mazloom",
    //                     "lastModifiedDate": 1588475503870,
    //                     "lastModifiedBy": "db_mazloom",
    //                     "version": 1
    //                 },
    //                 "material": {
    //                     "descl": "Copper Concentrate",
    //                     "descp": "مس کنسانتره",
    //                     "code": "26030090",
    //                     "unitId": -1,
    //                     "abbreviation": "CONC",
    //                     "id": 3,
    //                     "unit": {
    //                         "nameFA": "تن",
    //                         "nameEN": "MT",
    //                         "name": "MT",
    //                         "categoryUnit": "Weight",
    //                         "symbolUnit": "PERCENT"
    //                     },
    //                     "createdDate": 1599977041712,
    //                     "createdBy": "liquibase",
    //                     "version": 6
    //                 },
    //                 "shipmentType": {
    //                     "shipmentType": "فله",
    //                     "id": 1,
    //                     "createdDate": 1587278588350,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1587278588350,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 0
    //                 },
    //                 "shipmentMethod": {
    //                     "shipmentMethod": "حمل هوایی",
    //                     "id": 2,
    //                     "createdDate": 1587278588350,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1587278588350,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 0
    //                 },
    //                 "contractShipment": {
    //                     "loadPortId": 2,
    //                     "quantity": 200000,
    //                     "sendDate": "2016-09-14",
    //                     "tolorance": 5,
    //                     "contractId": 1,
    //                     "id": 1,
    //                     "contract": {
    //                         "no": "100",
    //                         "date": 1600677000000,
    //                         "affectFrom": 1600677000000,
    //                         "affectUpTo": 1600677000000,
    //                         "content": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG<br>NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN<br>+852 2575 7591<br>+982188102822<br>+852 3702 0210<br>+982182138231<br>NATIONAL IRANIAN COPPER INDUSTRIES CO.<br>SUNGILL RESOURCES LTD<br><h2>new deduction</h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Treatment Cost</th><th style='border: 1px solid black;'>Refinery Cost</th><th style='border: 1px solid black;'>Unit</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>31</td><td style='border: 1px solid black;'>321</td><td style='border: 1px solid black;'>Euro</td><td style='border: 1px solid black;'>S</td></tr><tr><td style='border: 1px solid black;'>3245</td><td style='border: 1px solid black;'>543</td><td style='border: 1px solid black;'>MT</td><td style='border: 1px solid black;'>MO</td></tr><tr><td style='border: 1px solid black;'>435</td><td style='border: 1px solid black;'>534</td><td style='border: 1px solid black;'>null</td><td style='border: 1px solid black;'>null</td></tr></table><br><h2>CLAUSE 1  DEFINITIONS </h2><p class=\"MsoNormal\" style=\"margin-bottom:0in;margin-bottom:.0001pt;text-align:\njustify;text-justify:inter-ideograph;line-height:normal\"><b><span style=\"color:black;mso-themecolor:text1\">1 TON = 1 METRIC TON OF 1'000\nKILOGRAMS OR 2204.62 LBS</span></b><b><u><span style=\"mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black\"><o:p></o:p></span></u></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal\"><b><span lang=\"EN-GB\" style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;\ncolor:black;mso-themecolor:text1;mso-ansi-language:EN-GB\">LME = LONDON METAL\nEXCHANGE<o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal;\ntab-stops:0in\"><b><span style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;\ncolor:black;mso-themecolor:text1\">WORKING/BUSINESS DAY FOR BUYER = MONDAY TO\nFRIDAY; SATURDAY, SUNDAY AND LEGAL HOLIDAY EXCLUDED.<o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal;\ntab-stops:0in\"><b><span style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;\ncolor:black;mso-themecolor:text1\">WORKING/BUSINESS DAY FOR SELLER = SATURDAY TO\nWEDNESDAY; THURSDAY AND FRIDAY AND LEGAL HOLIDAY EXCLUDED.<o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal\"><b><span lang=\"DE\" style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;color:black;\nmso-themecolor:text1;mso-ansi-language:DE\">AM/PM = ANTE MERIDIEM / POST MERIDIEM<o:p></o:p></span></b></p>\n\n<p class=\"MsoNormal\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span lang=\"EN-GB\" style=\"color:black;mso-themecolor:text1;\nmso-ansi-language:EN-GB\">INCOTERMS = </span></b><b><span style=\"mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black\">SHALL MEAN THE INTERNATIONAL\nCHAMBER OF COMMERCE’S OFFICIAL RULES FOR THE INTERPRETATION OF TRADE TERMS\nKNOWN AS INCOTERMS</span></b><b><span lang=\"EN-GB\" style=\"color:black;mso-themecolor:\ntext1;mso-ansi-language:EN-GB\"><o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal\"><b><span style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;color:black;\nmso-themecolor:text1\">THE MATERIAL = SHALL MEAN THE MATERIAL AS DEFINED IN\n\"ARTICLE 3 – QUALITY\" <o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">CIF = COST,\nINSURANCE AND FREIGHT (ACCORDING TO INCOTERMS 2010).<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">DAP = DELIVERY\nAT PLACE (ACCORDING TO INCOTERMS 2010).<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">FOB = FREE ON\nBOARD (ACCORDING TO INCOTERMS 2010).<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">ST = STOWED\nAND TRIMMED<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1;mso-ansi-language:\nEN-GB\">USD AND USC = DOLLARS AND CENTS ARE UNITED STATES CURRENCY</span></b><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;mso-ascii-theme-font:\nmajor-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;mso-hansi-theme-font:major-bidi;\nmso-bidi-font-family:&quot;Times New Roman&quot;;mso-bidi-theme-font:major-bidi;\ncolor:black;mso-themecolor:text1;mso-ansi-language:EN-GB;mso-fareast-language:\nZH-CN\"><o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"color:black;mso-themecolor:text1\">EURO =\nEURO IS THE SINGLE CURRENCY OF THE EUROPEAN ECONOMIC AND MONETARY UNION (EMU)\nINTRODUCED IN </span></b><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1;mso-ansi-language:\nEN-GB\">JANUARY 1999.<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi\">AED = UNITED ARAB EMIRATES DIRHAM<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"text-align:justify;text-justify:inter-ideograph\"><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;mso-ascii-theme-font:\nmajor-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;mso-hansi-theme-font:major-bidi;\nmso-bidi-font-family:&quot;Times New Roman&quot;;mso-bidi-theme-font:major-bidi;\ncolor:black;mso-themecolor:text1;mso-ansi-language:EN-GB\">MOAS = MONTH OF\nACUTAL SHIPMENT.</span></b><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi\"><o:p></o:p></span></b></p><h2>CLAUSE 2  QUANTITY </h2>200000&nbsp;&nbsp;&nbsp;PERCENT<br>5<br>SELLER<br>2016<br><h2>CLAUSE 3  QUALITY </h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Minimum</th><th style='border: 1px solid black;'>Maximum</th><th style='border: 1px solid black;'>Unit</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>22</td><td style='border: 1px solid black;'>28</td><td style='border: 1px solid black;'>MT</td><td style='border: 1px solid black;'>CD</td></tr></table><br><h2>CLAUSE 4  SHIPMENT </h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Load Port</th><th style='border: 1px solid black;'>Quantity</th><th style='border: 1px solid black;'>Tolorance</th><th style='border: 1px solid black;'>Send Date</th></tr><tr><td style='border: 1px solid black;'>BANDAR ABBAS</td><td style='border: 1px solid black;'>200000</td><td style='border: 1px solid black;'>5</td><td style='border: 1px solid black;'>Wed Sep 14 2016 12:00:00 GMT+0430 (Iran Daylight Time)</td></tr><tr><td style='border: 1px solid black;'>FANGCHENG</td><td style='border: 1px solid black;'>30000</td><td style='border: 1px solid black;'>5</td><td style='border: 1px solid black;'>Wed Sep 16 2020 12:00:00 GMT+0430 (Iran Daylight Time)</td></tr></table><br><h2>CLAUSE 5  DELIVERY TERMS </h2>Incoterms-2010<br><h2>CLAUSE 10  QUOTATIONAL PERIOD </h2>2<br><h2>CLAUSE 11  PAYMENT</h2>100<br><h2>CLAUSE 12  CURRENCY EXCHANGE  </h2>دلار آمریکا<br><h2>ARTICLE 7 - PRICE</h2><div align=\"right\"><div align=\"left\"><span style=\"font-size:8.0pt;mso-fareast-font-family:\n&quot;Times New Roman&quot;;color:black;mso-bidi-language:HE\">PRICE FOR MOLYBDENUM OXIDE\nWILL BE BASED ON THE PLATT'S METALS WEEK MONTHLY AVERAGE FOR MOLYBDENUM OXIDE,\nAS PUBLISHED IN MONTHLY REPORT OF PLATT'S METALS WEEK UNDER THE HEADING\n\"DEALER OXIDE MIDPOINT/MEAN\" PER POUND OF MOLYBDENUM CONTENT WITH\nDISCOUNTS AS BELOW:</span><br></div><span style=\"font-size:8.0pt;mso-fareast-font-family:\n&quot;Times New Roman&quot;;color:black;mso-bidi-language:HE\"></span><p style=\"text-align:justify\"><span style=\"font-size:8.0pt;mso-fareast-font-family:\n&quot;Times New Roman&quot;;color:black;mso-bidi-language:HE\"><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Minimum</th><th style='border: 1px solid black;'>Maximum</th><th style='border: 1px solid black;'>Discount</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>1</td><td style='border: 1px solid black;'>2</td><td style='border: 1px solid black;'>15</td><td style='border: 1px solid black;'>CU</td></tr></table><br></span></p>\n\n<!--[if gte mso 9]><xml>\n <o:OfficeDocumentSettings>\n  <o:TargetScreenSize>800x600</o:TargetScreenSize>\n </o:OfficeDocumentSettings>\n</xml><![endif]--><!--[if gte mso 9]><xml>\n <w:WordDocument>\n  <w:View>Normal</w:View>\n  <w:Zoom>0</w:Zoom>\n  <w:TrackMoves/>\n  <w:TrackFormatting/>\n  <w:PunctuationKerning/>\n  <w:ValidateAgainstSchemas/>\n  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>\n  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>\n  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>\n  <w:DoNotPromoteQF/>\n  <w:LidThemeOther>EN-US</w:LidThemeOther>\n  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>\n  <w:LidThemeComplexScript>AR-SA</w:LidThemeComplexScript>\n  <w:Compatibility>\n   <w:BreakWrappedTables/>\n   <w:SnapToGridInCell/>\n   <w:WrapTextWithPunct/>\n   <w:UseAsianBreakRules/>\n   <w:DontGrowAutofit/>\n   <w:SplitPgBreakAndParaMark/>\n   <w:EnableOpenTypeKerning/>\n   <w:DontFlipMirrorIndents/>\n   <w:OverrideTableStyleHps/>\n  </w:Compatibility>\n  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>\n  <m:mathPr>\n   <m:mathFont m:val=\"Cambria Math\"/>\n   <m:brkBin m:val=\"before\"/>\n   <m:brkBinSub m:val=\"&#45;-\"/>\n   <m:smallFrac m:val=\"off\"/>\n   <m:dispDef/>\n   <m:lMargin m:val=\"0\"/>\n   <m:rMargin m:val=\"0\"/>\n   <m:defJc m:val=\"centerGroup\"/>\n   <m:wrapIndent m:val=\"1440\"/>\n   <m:intLim m:val=\"subSup\"/>\n   <m:naryLim m:val=\"undOvr\"/>\n  </m:mathPr></w:WordDocument>\n</xml><![endif]--><!--[if gte mso 9]><xml>\n <w:LatentStyles DefLockedState=\"false\" DefUnhideWhenUsed=\"false\"\n  DefSemiHidden=\"false\" DefQFormat=\"false\" DefPriority=\"99\"\n  LatentStyleCount=\"371\">\n  <w:LsdException Locked=\"false\" Priority=\"0\" QFormat=\"true\" Name=\"Normal\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 7\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 8\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 9\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 6\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 7\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 8\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 9\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 7\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 8\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 9\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Normal Indent\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"footnote text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"annotation text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"header\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"footer\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index heading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"35\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"caption\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"table of figures\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"envelope address\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"envelope return\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"footnote reference\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"annotation reference\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"line number\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"page number\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"endnote reference\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"endnote text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"table of authorities\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"macro\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"toa heading\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"10\" QFormat=\"true\" Name=\"Title\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Closing\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Signature\"/>\n  <w:LsdException Locked=\"false\" Priority=\"0\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"Default Paragraph Font\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text Indent\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Message Header\"/>\n  <w:LsdException Locked=\"false\" Priority=\"11\" QFormat=\"true\" Name=\"Subtitle\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Salutation\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Date\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text First Indent\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text First Indent 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Note Heading\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text Indent 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text Indent 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Block Text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Hyperlink\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"FollowedHyperlink\"/>\n  <w:LsdException Locked=\"false\" Priority=\"22\" QFormat=\"true\" Name=\"Strong\"/>\n  <w:LsdException Locked=\"false\" Priority=\"20\" QFormat=\"true\" Name=\"Emphasis\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Document Map\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Plain Text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"E-mail Signature\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Top of Form\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Bottom of Form\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Normal (Web)\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Acronym\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Address\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Cite\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Code\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Definition\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Keyboard\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Preformatted\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Sample\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Typewriter\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Variable\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Normal Table\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"annotation subject\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"No List\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Outline List 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Outline List 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Outline List 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Simple 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Simple 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Simple 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Colorful 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Colorful 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Colorful 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 6\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 7\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 8\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 6\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 7\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 8\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table 3D effects 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table 3D effects 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table 3D effects 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Contemporary\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Elegant\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Professional\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Subtle 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Subtle 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Web 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Web 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Web 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Balloon Text\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"Table Grid\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Theme\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" Name=\"Placeholder Text\"/>\n  <w:LsdException Locked=\"false\" Priority=\"1\" QFormat=\"true\" Name=\"No Spacing\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" Name=\"Revision\"/>\n  <w:LsdException Locked=\"false\" Priority=\"34\" QFormat=\"true\"\n   Name=\"List Paragraph\"/>\n  <w:LsdException Locked=\"false\" Priority=\"29\" QFormat=\"true\" Name=\"Quote\"/>\n  <w:LsdException Locked=\"false\" Priority=\"30\" QFormat=\"true\"\n   Name=\"Intense Quote\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"19\" QFormat=\"true\"\n   Name=\"Subtle Emphasis\"/>\n  <w:LsdException Locked=\"false\" Priority=\"21\" QFormat=\"true\"\n   Name=\"Intense Emphasis\"/>\n  <w:LsdException Locked=\"false\" Priority=\"31\" QFormat=\"true\"\n   Name=\"Subtle Reference\"/>\n  <w:LsdException Locked=\"false\" Priority=\"32\" QFormat=\"true\"\n   Name=\"Intense Reference\"/>\n  <w:LsdException Locked=\"false\" Priority=\"33\" QFormat=\"true\" Name=\"Book Title\"/>\n  <w:LsdException Locked=\"false\" Priority=\"37\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"Bibliography\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"TOC Heading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"41\" Name=\"Plain Table 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"42\" Name=\"Plain Table 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"43\" Name=\"Plain Table 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"44\" Name=\"Plain Table 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"45\" Name=\"Plain Table 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"40\" Name=\"Grid Table Light\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\" Name=\"Grid Table 1 Light\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\" Name=\"Grid Table 6 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\" Name=\"Grid Table 7 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\" Name=\"List Table 1 Light\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\" Name=\"List Table 6 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\" Name=\"List Table 7 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 6\"/>\n </w:LatentStyles>\n</xml><![endif]--><!--[if gte mso 10]>\n<style>\n /* Style Definitions */\n table.MsoNormalTable\n\t{mso-style-name:\"Table Normal\";\n\tmso-tstyle-rowband-size:0;\n\tmso-tstyle-colband-size:0;\n\tmso-style-noshow:yes;\n\tmso-style-priority:99;\n\tmso-style-parent:\"\";\n\tmso-padding-alt:0in 5.4pt 0in 5.4pt;\n\tmso-para-margin:0in;\n\tmso-para-margin-bottom:.0001pt;\n\tmso-pagination:widow-orphan;\n\tfont-size:10.0pt;\n\tfont-family:\"Times New Roman\",serif;}\n</style>\n<![endif]--></div>",
    //                         "materialId": 3,
    //                         "contractTypeId": 1
    //                     },
    //                     "loadPort": {
    //                         "port": "BANDAR ABBAS",
    //                         "countryId": 1
    //                     },
    //                     "createdDate": 1600005922013,
    //                     "createdBy": "r.mazloom",
    //                     "lastModifiedDate": 1600674681760,
    //                     "lastModifiedBy": "r.mazloom",
    //                     "version": 21
    //                 },
    //                 "estatus": [
    //                     "Active"
    //                 ],
    //                 "moisture": 0
    //             },
    //             "estatus": [
    //                 "Active"
    //             ],
    //             "_selection_79": true,
    //             "_embeddedComponents_isc_ListGrid_1": null
    //         },
    //         {
    //             "documentNo": "4",
    //             "switchDocumentNo": "44",
    //             "shipperExporterId": 101,
    //             "switchShipperExporterId": 6,
    //             "notifyPartyId": 221,
    //             "switchNotifyPartyId": 5,
    //             "consigneeId": 5,
    //             "switchConsigneeId": 6,
    //             "portOfLoadingId": 3,
    //             "switchPortOfLoadingId": 3,
    //             "portOfDischargeId": 33,
    //             "switchPortOfDischargeId": 268,
    //             "placeOfDelivery": "ABU DHABI",
    //             "oceanVesselId": 37,
    //             "numberOfBlCopies": 44,
    //             "dateOfIssue": 1601368200000,
    //             "placeOfIssue": "444",
    //             "totalNet": 44,
    //             "totalGross": 44,
    //             "totalBundles": 44,
    //             "shipmentId": 1,
    //             "shipmentTypeId": 2,
    //             "shipmentMethodId": 3,
    //             "id": 81,
    //             "shipperExporter": {
    //                 "nameFA": "HC",
    //                 "nameEN": "HC",
    //                 "name": "HC",
    //                 "phone": "999999999999",
    //                 "type": false,
    //                 "status": true,
    //                 "tradeMark": "HC",
    //                 "commercialRole": "Transporter",
    //                 "transporter": true,
    //                 "inspector": false,
    //                 "countryId": 1,
    //                 "id": 101,
    //                 "country": {
    //                     "nameFA": "ایران",
    //                     "nameEN": "Iran (Islamic Republic of)",
    //                     "name": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1587868072023,
    //                 "createdBy": "db_mazloom",
    //                 "lastModifiedDate": 1588475574345,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 1
    //             },
    //             "switchShipperExporter": {
    //                 "nameFA": "ALUMINCO HOLDINGS LIMITED",
    //                 "nameEN": "ALUMINCO HOLDINGS LIMITED",
    //                 "name": "ALUMINCO HOLDINGS LIMITED",
    //                 "phone": "+86 10 68495098",
    //                 "address": "OFFSHORE INCORPORATION (CAYMAN) LIMITED FLOOR 4 WILLOW",
    //                 "type": true,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "inspector": false,
    //                 "countryId": 2,
    //                 "id": 6,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1579059486082,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600688110829,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 3
    //             },
    //             "notifyParty": {
    //                 "nameFA": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
    //                 "nameEN": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
    //                 "name": "SHANGHAI HONGTE COAL CHEMICAL INDUSTRY CO.LTD",
    //                 "phone": "+86-21-54981420",
    //                 "fax": "+86-358-5489141",
    //                 "type": false,
    //                 "status": true,
    //                 "tradeMark": "SHANGHAI HONGTE ",
    //                 "commercialRole": "Buyer",
    //                 "seller": false,
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 221,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1589587421596,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0
    //             },
    //             "switchNotifyParty": {
    //                 "nameFA": "بیمه ما",
    //                 "nameEN": "MA INSURANCE",
    //                 "name": "MA INSURANCE",
    //                 "phone": "8690",
    //                 "address": "تهران میدان ونک ابتدای خیابان ونک پلاک 9",
    //                 "webSite": "WWW.BIMEHMA.COM",
    //                 "type": true,
    //                 "status": true,
    //                 "commercialRole": "Insurancer",
    //                 "insurancer": true,
    //                 "countryId": 1,
    //                 "id": 5,
    //                 "country": {
    //                     "nameFA": "ایران",
    //                     "nameEN": "Iran (Islamic Republic of)",
    //                     "name": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1579059013188,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600678348354,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 9,
    //                 "defaultAccount": {
    //                     "contactId": 5,
    //                     "bankId": 1,
    //                     "bankAccount": "34234",
    //                     "bankShaba": "IR232000666666666003399999",
    //                     "code": "123123",
    //                     "bankSwift": "123213",
    //                     "accountOwner": "3434",
    //                     "status": true,
    //                     "isDefault": true,
    //                     "id": 9,
    //                     "bank": {
    //                         "nameFA": "بانک گذشته",
    //                         "countryId": 1,
    //                         "nameEN": "GOZASHTE",
    //                         "address": "ونک",
    //                         "coreBranch": "branch"
    //                     },
    //                     "createdDate": 1600242766823,
    //                     "createdBy": "db_zare",
    //                     "lastModifiedDate": 1600690369365,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 8
    //                 }
    //             },
    //             "consignee": {
    //                 "nameFA": "بیمه ما",
    //                 "nameEN": "MA INSURANCE",
    //                 "name": "MA INSURANCE",
    //                 "phone": "8690",
    //                 "address": "تهران میدان ونک ابتدای خیابان ونک پلاک 9",
    //                 "webSite": "WWW.BIMEHMA.COM",
    //                 "type": true,
    //                 "status": true,
    //                 "commercialRole": "Insurancer",
    //                 "insurancer": true,
    //                 "countryId": 1,
    //                 "id": 5,
    //                 "country": {
    //                     "nameFA": "ایران",
    //                     "nameEN": "Iran (Islamic Republic of)",
    //                     "name": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1579059013188,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600678348354,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 9,
    //                 "defaultAccount": {
    //                     "contactId": 5,
    //                     "bankId": 1,
    //                     "bankAccount": "34234",
    //                     "bankShaba": "IR232000666666666003399999",
    //                     "code": "123123",
    //                     "bankSwift": "123213",
    //                     "accountOwner": "3434",
    //                     "status": true,
    //                     "isDefault": true,
    //                     "id": 9,
    //                     "bank": {
    //                         "nameFA": "بانک گذشته",
    //                         "countryId": 1,
    //                         "nameEN": "GOZASHTE",
    //                         "address": "ونک",
    //                         "coreBranch": "branch"
    //                     },
    //                     "createdDate": 1600242766823,
    //                     "createdBy": "db_zare",
    //                     "lastModifiedDate": 1600690369365,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 8
    //                 }
    //             },
    //             "switchConsignee": {
    //                 "nameFA": "ALUMINCO HOLDINGS LIMITED",
    //                 "nameEN": "ALUMINCO HOLDINGS LIMITED",
    //                 "name": "ALUMINCO HOLDINGS LIMITED",
    //                 "phone": "+86 10 68495098",
    //                 "address": "OFFSHORE INCORPORATION (CAYMAN) LIMITED FLOOR 4 WILLOW",
    //                 "type": true,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "inspector": false,
    //                 "countryId": 2,
    //                 "id": 6,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1579059486082,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600688110829,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 3
    //             },
    //             "portOfLoading": {
    //                 "port": "SHANGHAI",
    //                 "countryId": 2,
    //                 "id": 3,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China",
    //                     "id": 2,
    //                     "createdDate": 1599977039984,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587732958179,
    //                 "createdBy": "db_mazloom",
    //                 "lastModifiedDate": 1587865761876,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 3,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfLoading": {
    //                 "port": "SHANGHAI",
    //                 "countryId": 2,
    //                 "id": 3,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China",
    //                     "id": 2,
    //                     "createdDate": 1599977039984,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587732958179,
    //                 "createdBy": "db_mazloom",
    //                 "lastModifiedDate": 1587865761876,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 3,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "portOfDischarge": {
    //                 "port": "FANGCHENG",
    //                 "countryId": 2,
    //                 "id": 33,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China",
    //                     "id": 2,
    //                     "createdDate": 1599977039984,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587866451161,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfDischarge": {
    //                 "port": "gffgdf",
    //                 "countryId": 2,
    //                 "loa": "4",
    //                 "beam": "54",
    //                 "arrival": "54",
    //                 "id": 268,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China",
    //                     "id": 2,
    //                     "createdDate": 1599977039984,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1600576550177,
    //                 "createdBy": "r.mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "oceanVessel": {
    //                 "name": "AGIA ELENI",
    //                 "type": "Bulk Carrier",
    //                 "imo": "9370317",
    //                 "yearOfBuild": 2008,
    //                 "length": 170.7,
    //                 "beam": 27,
    //                 "id": 37,
    //                 "createdDate": 1588382861641,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "containers": [],
    //             "shipmentType": {
    //                 "shipmentType": "کانتینری",
    //                 "id": 2,
    //                 "createdDate": 1587278588350,
    //                 "createdBy": "j.azad",
    //                 "lastModifiedDate": 1587278588350,
    //                 "lastModifiedBy": "j.azad",
    //                 "version": 0
    //             },
    //             "shipmentMethod": {
    //                 "shipmentMethod": "حمل دریایی",
    //                 "id": 3,
    //                 "createdDate": 1587278588350,
    //                 "createdBy": "j.azad",
    //                 "lastModifiedDate": 1587278588350,
    //                 "lastModifiedBy": "j.azad",
    //                 "version": 0
    //             },
    //             "createdDate": 1601357341262,
    //             "createdBy": "db_zare",
    //             "version": 0,
    //             "editable": true,
    //             "shipment": {
    //                 "contractShipmentId": 1,
    //                 "shipmentTypeId": 1,
    //                 "shipmentMethodId": 2,
    //                 "contactId": 41,
    //                 "materialId": 3,
    //                 "contactAgentId": 136,
    //                 "vesselId": 37,
    //                 "unitId": 4,
    //                 "dischargePortId": 31,
    //                 "amount": 70000,
    //                 "automationLetterNo": "1242",
    //                 "automationLetterDate": 1596396600000,
    //                 "sendDate": 1473811200000,
    //                 "noBLs": 2,
    //                 "bookingCat": "1234",
    //                 "arrivalDateFrom": 1581669000000,
    //                 "arrivalDateTo": 1581669000000,
    //                 "lastDeliveryLetterDate": 1600068600000,
    //                 "id": 1,
    //                 "createdDate": 1600068124999,
    //                 "createdBy": "m.shahabi",
    //                 "lastModifiedDate": 1600762686847,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 1,
    //                 "editable": true,
    //                 "unit": {
    //                     "nameFA": "بسته",
    //                     "nameEN": "BUNDLE",
    //                     "name": "BUNDLE",
    //                     "categoryUnit": "Weight",
    //                     "symbolUnit": "PERCENT",
    //                     "id": 4,
    //                     "createdDate": 1593755140054,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1594100538548,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 2,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "vessel": {
    //                     "name": "AGIA ELENI",
    //                     "type": "Bulk Carrier",
    //                     "imo": "9370317",
    //                     "yearOfBuild": 2008,
    //                     "length": 170.7,
    //                     "beam": 27,
    //                     "id": 37,
    //                     "createdDate": 1588382861641,
    //                     "createdBy": "db_mazloom",
    //                     "version": 0,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "contact": {
    //                     "nameFA": "سونگ ایک خار",
    //                     "nameEN": "XSUNGILL RESOURCES LTD",
    //                     "name": "XSUNGILL RESOURCES LTD",
    //                     "phone": "8511101111",
    //                     "fax": "85237020210",
    //                     "address": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG",
    //                     "type": false,
    //                     "status": true,
    //                     "commercialRole": "Buyer",
    //                     "buyer": true,
    //                     "countryId": 2,
    //                     "id": 41,
    //                     "country": {
    //                         "nameFA": "چین",
    //                         "nameEN": "China",
    //                         "name": "China"
    //                     },
    //                     "createdDate": 1579683563975,
    //                     "createdBy": "dorani_sa",
    //                     "lastModifiedDate": 1601359142895,
    //                     "lastModifiedBy": "root",
    //                     "version": 3
    //                 },
    //                 "dischargePort": {
    //                     "port": "ABU DHABI",
    //                     "countryId": 3,
    //                     "id": 31,
    //                     "country": {
    //                         "nameFA": "افغانستان",
    //                         "nameEN": "Afghanistan",
    //                         "name": "Afghanistan",
    //                         "id": 3,
    //                         "createdDate": 1599977039990,
    //                         "createdBy": "j.azad",
    //                         "version": 0,
    //                         "editable": false,
    //                         "estatus": [
    //                             "Active"
    //                         ]
    //                     },
    //                     "createdDate": 1587866317999,
    //                     "createdBy": "db_mazloom",
    //                     "version": 0,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "contactAgent": {
    //                     "nameFA": "GRASH DARYA",
    //                     "nameEN": "GRASH DARYA",
    //                     "name": "GRASH DARYA",
    //                     "phone": "21-88727255",
    //                     "fax": "21-88726762",
    //                     "type": false,
    //                     "status": true,
    //                     "tradeMark": "GRASH DARYA",
    //                     "commercialRole": "Transporter",
    //                     "seller": false,
    //                     "transporter": true,
    //                     "agentBuyer": false,
    //                     "countryId": 1,
    //                     "id": 136,
    //                     "country": {
    //                         "nameFA": "ایران",
    //                         "nameEN": "Iran (Islamic Republic of)",
    //                         "name": "Iran (Islamic Republic of)"
    //                     },
    //                     "createdDate": 1587875271899,
    //                     "createdBy": "db_mazloom",
    //                     "lastModifiedDate": 1588475503870,
    //                     "lastModifiedBy": "db_mazloom",
    //                     "version": 1
    //                 },
    //                 "material": {
    //                     "descl": "Copper Concentrate",
    //                     "descp": "مس کنسانتره",
    //                     "code": "26030090",
    //                     "unitId": -1,
    //                     "abbreviation": "CONC",
    //                     "id": 3,
    //                     "unit": {
    //                         "nameFA": "تن",
    //                         "nameEN": "MT",
    //                         "name": "MT",
    //                         "categoryUnit": "Weight",
    //                         "symbolUnit": "PERCENT"
    //                     },
    //                     "createdDate": 1599977041712,
    //                     "createdBy": "liquibase",
    //                     "version": 6
    //                 },
    //                 "shipmentType": {
    //                     "shipmentType": "فله",
    //                     "id": 1,
    //                     "createdDate": 1587278588350,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1587278588350,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 0
    //                 },
    //                 "shipmentMethod": {
    //                     "shipmentMethod": "حمل هوایی",
    //                     "id": 2,
    //                     "createdDate": 1587278588350,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1587278588350,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 0
    //                 },
    //                 "contractShipment": {
    //                     "loadPortId": 2,
    //                     "quantity": 200000,
    //                     "sendDate": "2016-09-14",
    //                     "tolorance": 5,
    //                     "contractId": 1,
    //                     "id": 1,
    //                     "contract": {
    //                         "no": "100",
    //                         "date": 1600677000000,
    //                         "affectFrom": 1600677000000,
    //                         "affectUpTo": 1600677000000,
    //                         "content": "FLAT/RM 8,12 /F,WAYSON COMMERCIAL BUILDING 28 CONNAUGHT, ROAD WEST SHEUNG WAN, HONK KONG<br>NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN<br>+852 2575 7591<br>+982188102822<br>+852 3702 0210<br>+982182138231<br>NATIONAL IRANIAN COPPER INDUSTRIES CO.<br>SUNGILL RESOURCES LTD<br><h2>new deduction</h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Treatment Cost</th><th style='border: 1px solid black;'>Refinery Cost</th><th style='border: 1px solid black;'>Unit</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>31</td><td style='border: 1px solid black;'>321</td><td style='border: 1px solid black;'>Euro</td><td style='border: 1px solid black;'>S</td></tr><tr><td style='border: 1px solid black;'>3245</td><td style='border: 1px solid black;'>543</td><td style='border: 1px solid black;'>MT</td><td style='border: 1px solid black;'>MO</td></tr><tr><td style='border: 1px solid black;'>435</td><td style='border: 1px solid black;'>534</td><td style='border: 1px solid black;'>null</td><td style='border: 1px solid black;'>null</td></tr></table><br><h2>CLAUSE 1  DEFINITIONS </h2><p class=\"MsoNormal\" style=\"margin-bottom:0in;margin-bottom:.0001pt;text-align:\njustify;text-justify:inter-ideograph;line-height:normal\"><b><span style=\"color:black;mso-themecolor:text1\">1 TON = 1 METRIC TON OF 1'000\nKILOGRAMS OR 2204.62 LBS</span></b><b><u><span style=\"mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black\"><o:p></o:p></span></u></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal\"><b><span lang=\"EN-GB\" style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;\ncolor:black;mso-themecolor:text1;mso-ansi-language:EN-GB\">LME = LONDON METAL\nEXCHANGE<o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal;\ntab-stops:0in\"><b><span style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;\ncolor:black;mso-themecolor:text1\">WORKING/BUSINESS DAY FOR BUYER = MONDAY TO\nFRIDAY; SATURDAY, SUNDAY AND LEGAL HOLIDAY EXCLUDED.<o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal;\ntab-stops:0in\"><b><span style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;\ncolor:black;mso-themecolor:text1\">WORKING/BUSINESS DAY FOR SELLER = SATURDAY TO\nWEDNESDAY; THURSDAY AND FRIDAY AND LEGAL HOLIDAY EXCLUDED.<o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal\"><b><span lang=\"DE\" style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;color:black;\nmso-themecolor:text1;mso-ansi-language:DE\">AM/PM = ANTE MERIDIEM / POST MERIDIEM<o:p></o:p></span></b></p>\n\n<p class=\"MsoNormal\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span lang=\"EN-GB\" style=\"color:black;mso-themecolor:text1;\nmso-ansi-language:EN-GB\">INCOTERMS = </span></b><b><span style=\"mso-ascii-font-family:\n&quot;Times New Roman&quot;;mso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black\">SHALL MEAN THE INTERNATIONAL\nCHAMBER OF COMMERCE’S OFFICIAL RULES FOR THE INTERPRETATION OF TRADE TERMS\nKNOWN AS INCOTERMS</span></b><b><span lang=\"EN-GB\" style=\"color:black;mso-themecolor:\ntext1;mso-ansi-language:EN-GB\"><o:p></o:p></span></b></p>\n\n<p class=\"DefinitionText\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-indent:0in;line-height:normal\"><b><span style=\"font-size:10.0pt;font-family:&quot;Times New Roman&quot;,serif;color:black;\nmso-themecolor:text1\">THE MATERIAL = SHALL MEAN THE MATERIAL AS DEFINED IN\n\"ARTICLE 3 – QUALITY\" <o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">CIF = COST,\nINSURANCE AND FREIGHT (ACCORDING TO INCOTERMS 2010).<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">DAP = DELIVERY\nAT PLACE (ACCORDING TO INCOTERMS 2010).<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">FOB = FREE ON\nBOARD (ACCORDING TO INCOTERMS 2010).<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1\">ST = STOWED\nAND TRIMMED<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1;mso-ansi-language:\nEN-GB\">USD AND USC = DOLLARS AND CENTS ARE UNITED STATES CURRENCY</span></b><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;mso-ascii-theme-font:\nmajor-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;mso-hansi-theme-font:major-bidi;\nmso-bidi-font-family:&quot;Times New Roman&quot;;mso-bidi-theme-font:major-bidi;\ncolor:black;mso-themecolor:text1;mso-ansi-language:EN-GB;mso-fareast-language:\nZH-CN\"><o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"color:black;mso-themecolor:text1\">EURO =\nEURO IS THE SINGLE CURRENCY OF THE EUROPEAN ECONOMIC AND MONETARY UNION (EMU)\nINTRODUCED IN </span></b><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi;color:black;mso-themecolor:text1;mso-ansi-language:\nEN-GB\">JANUARY 1999.<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"margin-top:0in;margin-right:-9.0pt;margin-bottom:\n0in;margin-left:0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;\nline-height:normal\"><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi\">AED = UNITED ARAB EMIRATES DIRHAM<o:p></o:p></span></b></p>\n\n<p class=\"NormalJustified\" style=\"text-align:justify;text-justify:inter-ideograph\"><b><span lang=\"EN-GB\" style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;mso-ascii-theme-font:\nmajor-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;mso-hansi-theme-font:major-bidi;\nmso-bidi-font-family:&quot;Times New Roman&quot;;mso-bidi-theme-font:major-bidi;\ncolor:black;mso-themecolor:text1;mso-ansi-language:EN-GB\">MOAS = MONTH OF\nACUTAL SHIPMENT.</span></b><b><span style=\"mso-ascii-font-family:&quot;Times New Roman&quot;;\nmso-ascii-theme-font:major-bidi;mso-hansi-font-family:&quot;Times New Roman&quot;;\nmso-hansi-theme-font:major-bidi;mso-bidi-font-family:&quot;Times New Roman&quot;;\nmso-bidi-theme-font:major-bidi\"><o:p></o:p></span></b></p><h2>CLAUSE 2  QUANTITY </h2>200000&nbsp;&nbsp;&nbsp;PERCENT<br>5<br>SELLER<br>2016<br><h2>CLAUSE 3  QUALITY </h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Minimum</th><th style='border: 1px solid black;'>Maximum</th><th style='border: 1px solid black;'>Unit</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>22</td><td style='border: 1px solid black;'>28</td><td style='border: 1px solid black;'>MT</td><td style='border: 1px solid black;'>CD</td></tr></table><br><h2>CLAUSE 4  SHIPMENT </h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Load Port</th><th style='border: 1px solid black;'>Quantity</th><th style='border: 1px solid black;'>Tolorance</th><th style='border: 1px solid black;'>Send Date</th></tr><tr><td style='border: 1px solid black;'>BANDAR ABBAS</td><td style='border: 1px solid black;'>200000</td><td style='border: 1px solid black;'>5</td><td style='border: 1px solid black;'>Wed Sep 14 2016 12:00:00 GMT+0430 (Iran Daylight Time)</td></tr><tr><td style='border: 1px solid black;'>FANGCHENG</td><td style='border: 1px solid black;'>30000</td><td style='border: 1px solid black;'>5</td><td style='border: 1px solid black;'>Wed Sep 16 2020 12:00:00 GMT+0430 (Iran Daylight Time)</td></tr></table><br><h2>CLAUSE 5  DELIVERY TERMS </h2>Incoterms-2010<br><h2>CLAUSE 10  QUOTATIONAL PERIOD </h2>2<br><h2>CLAUSE 11  PAYMENT</h2>100<br><h2>CLAUSE 12  CURRENCY EXCHANGE  </h2>دلار آمریکا<br><h2>ARTICLE 7 - PRICE</h2><div align=\"right\"><div align=\"left\"><span style=\"font-size:8.0pt;mso-fareast-font-family:\n&quot;Times New Roman&quot;;color:black;mso-bidi-language:HE\">PRICE FOR MOLYBDENUM OXIDE\nWILL BE BASED ON THE PLATT'S METALS WEEK MONTHLY AVERAGE FOR MOLYBDENUM OXIDE,\nAS PUBLISHED IN MONTHLY REPORT OF PLATT'S METALS WEEK UNDER THE HEADING\n\"DEALER OXIDE MIDPOINT/MEAN\" PER POUND OF MOLYBDENUM CONTENT WITH\nDISCOUNTS AS BELOW:</span><br></div><span style=\"font-size:8.0pt;mso-fareast-font-family:\n&quot;Times New Roman&quot;;color:black;mso-bidi-language:HE\"></span><p style=\"text-align:justify\"><span style=\"font-size:8.0pt;mso-fareast-font-family:\n&quot;Times New Roman&quot;;color:black;mso-bidi-language:HE\"><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Minimum</th><th style='border: 1px solid black;'>Maximum</th><th style='border: 1px solid black;'>Discount</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>1</td><td style='border: 1px solid black;'>2</td><td style='border: 1px solid black;'>15</td><td style='border: 1px solid black;'>CU</td></tr></table><br></span></p>\n\n<!--[if gte mso 9]><xml>\n <o:OfficeDocumentSettings>\n  <o:TargetScreenSize>800x600</o:TargetScreenSize>\n </o:OfficeDocumentSettings>\n</xml><![endif]--><!--[if gte mso 9]><xml>\n <w:WordDocument>\n  <w:View>Normal</w:View>\n  <w:Zoom>0</w:Zoom>\n  <w:TrackMoves/>\n  <w:TrackFormatting/>\n  <w:PunctuationKerning/>\n  <w:ValidateAgainstSchemas/>\n  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>\n  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>\n  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>\n  <w:DoNotPromoteQF/>\n  <w:LidThemeOther>EN-US</w:LidThemeOther>\n  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>\n  <w:LidThemeComplexScript>AR-SA</w:LidThemeComplexScript>\n  <w:Compatibility>\n   <w:BreakWrappedTables/>\n   <w:SnapToGridInCell/>\n   <w:WrapTextWithPunct/>\n   <w:UseAsianBreakRules/>\n   <w:DontGrowAutofit/>\n   <w:SplitPgBreakAndParaMark/>\n   <w:EnableOpenTypeKerning/>\n   <w:DontFlipMirrorIndents/>\n   <w:OverrideTableStyleHps/>\n  </w:Compatibility>\n  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>\n  <m:mathPr>\n   <m:mathFont m:val=\"Cambria Math\"/>\n   <m:brkBin m:val=\"before\"/>\n   <m:brkBinSub m:val=\"&#45;-\"/>\n   <m:smallFrac m:val=\"off\"/>\n   <m:dispDef/>\n   <m:lMargin m:val=\"0\"/>\n   <m:rMargin m:val=\"0\"/>\n   <m:defJc m:val=\"centerGroup\"/>\n   <m:wrapIndent m:val=\"1440\"/>\n   <m:intLim m:val=\"subSup\"/>\n   <m:naryLim m:val=\"undOvr\"/>\n  </m:mathPr></w:WordDocument>\n</xml><![endif]--><!--[if gte mso 9]><xml>\n <w:LatentStyles DefLockedState=\"false\" DefUnhideWhenUsed=\"false\"\n  DefSemiHidden=\"false\" DefQFormat=\"false\" DefPriority=\"99\"\n  LatentStyleCount=\"371\">\n  <w:LsdException Locked=\"false\" Priority=\"0\" QFormat=\"true\" Name=\"Normal\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" QFormat=\"true\" Name=\"heading 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 7\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 8\"/>\n  <w:LsdException Locked=\"false\" Priority=\"9\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"heading 9\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 6\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 7\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 8\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index 9\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 7\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 8\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"toc 9\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Normal Indent\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"footnote text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"annotation text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"header\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"footer\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"index heading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"35\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"caption\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"table of figures\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"envelope address\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"envelope return\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"footnote reference\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"annotation reference\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"line number\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"page number\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"endnote reference\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"endnote text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"table of authorities\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"macro\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"toa heading\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Bullet 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Number 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"10\" QFormat=\"true\" Name=\"Title\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Closing\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Signature\"/>\n  <w:LsdException Locked=\"false\" Priority=\"0\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"Default Paragraph Font\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text Indent\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"List Continue 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Message Header\"/>\n  <w:LsdException Locked=\"false\" Priority=\"11\" QFormat=\"true\" Name=\"Subtitle\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Salutation\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Date\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text First Indent\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text First Indent 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Note Heading\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text Indent 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Body Text Indent 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Block Text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Hyperlink\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"FollowedHyperlink\"/>\n  <w:LsdException Locked=\"false\" Priority=\"22\" QFormat=\"true\" Name=\"Strong\"/>\n  <w:LsdException Locked=\"false\" Priority=\"20\" QFormat=\"true\" Name=\"Emphasis\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Document Map\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Plain Text\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"E-mail Signature\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Top of Form\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Bottom of Form\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Normal (Web)\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Acronym\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Address\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Cite\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Code\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Definition\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Keyboard\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Preformatted\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Sample\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Typewriter\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"HTML Variable\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Normal Table\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"annotation subject\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"No List\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Outline List 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Outline List 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Outline List 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Simple 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Simple 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Simple 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Classic 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Colorful 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Colorful 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Colorful 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Columns 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 6\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 7\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Grid 8\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 4\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 5\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 6\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 7\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table List 8\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table 3D effects 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table 3D effects 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table 3D effects 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Contemporary\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Elegant\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Professional\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Subtle 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Subtle 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Web 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Web 2\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Web 3\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Balloon Text\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" Name=\"Table Grid\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" UnhideWhenUsed=\"true\"\n   Name=\"Table Theme\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" Name=\"Placeholder Text\"/>\n  <w:LsdException Locked=\"false\" Priority=\"1\" QFormat=\"true\" Name=\"No Spacing\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 1\"/>\n  <w:LsdException Locked=\"false\" SemiHidden=\"true\" Name=\"Revision\"/>\n  <w:LsdException Locked=\"false\" Priority=\"34\" QFormat=\"true\"\n   Name=\"List Paragraph\"/>\n  <w:LsdException Locked=\"false\" Priority=\"29\" QFormat=\"true\" Name=\"Quote\"/>\n  <w:LsdException Locked=\"false\" Priority=\"30\" QFormat=\"true\"\n   Name=\"Intense Quote\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"60\" Name=\"Light Shading Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"61\" Name=\"Light List Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"62\" Name=\"Light Grid Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"63\" Name=\"Medium Shading 1 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"64\" Name=\"Medium Shading 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"65\" Name=\"Medium List 1 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"66\" Name=\"Medium List 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"67\" Name=\"Medium Grid 1 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"68\" Name=\"Medium Grid 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"69\" Name=\"Medium Grid 3 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"70\" Name=\"Dark List Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"71\" Name=\"Colorful Shading Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"72\" Name=\"Colorful List Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"73\" Name=\"Colorful Grid Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"19\" QFormat=\"true\"\n   Name=\"Subtle Emphasis\"/>\n  <w:LsdException Locked=\"false\" Priority=\"21\" QFormat=\"true\"\n   Name=\"Intense Emphasis\"/>\n  <w:LsdException Locked=\"false\" Priority=\"31\" QFormat=\"true\"\n   Name=\"Subtle Reference\"/>\n  <w:LsdException Locked=\"false\" Priority=\"32\" QFormat=\"true\"\n   Name=\"Intense Reference\"/>\n  <w:LsdException Locked=\"false\" Priority=\"33\" QFormat=\"true\" Name=\"Book Title\"/>\n  <w:LsdException Locked=\"false\" Priority=\"37\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" Name=\"Bibliography\"/>\n  <w:LsdException Locked=\"false\" Priority=\"39\" SemiHidden=\"true\"\n   UnhideWhenUsed=\"true\" QFormat=\"true\" Name=\"TOC Heading\"/>\n  <w:LsdException Locked=\"false\" Priority=\"41\" Name=\"Plain Table 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"42\" Name=\"Plain Table 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"43\" Name=\"Plain Table 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"44\" Name=\"Plain Table 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"45\" Name=\"Plain Table 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"40\" Name=\"Grid Table Light\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\" Name=\"Grid Table 1 Light\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\" Name=\"Grid Table 6 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\" Name=\"Grid Table 7 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"Grid Table 1 Light Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"Grid Table 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"Grid Table 3 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"Grid Table 4 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"Grid Table 5 Dark Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"Grid Table 6 Colorful Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"Grid Table 7 Colorful Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\" Name=\"List Table 1 Light\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\" Name=\"List Table 6 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\" Name=\"List Table 7 Colorful\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 1\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 2\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 3\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 4\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 5\"/>\n  <w:LsdException Locked=\"false\" Priority=\"46\"\n   Name=\"List Table 1 Light Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"47\" Name=\"List Table 2 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"48\" Name=\"List Table 3 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"49\" Name=\"List Table 4 Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"50\" Name=\"List Table 5 Dark Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"51\"\n   Name=\"List Table 6 Colorful Accent 6\"/>\n  <w:LsdException Locked=\"false\" Priority=\"52\"\n   Name=\"List Table 7 Colorful Accent 6\"/>\n </w:LatentStyles>\n</xml><![endif]--><!--[if gte mso 10]>\n<style>\n /* Style Definitions */\n table.MsoNormalTable\n\t{mso-style-name:\"Table Normal\";\n\tmso-tstyle-rowband-size:0;\n\tmso-tstyle-colband-size:0;\n\tmso-style-noshow:yes;\n\tmso-style-priority:99;\n\tmso-style-parent:\"\";\n\tmso-padding-alt:0in 5.4pt 0in 5.4pt;\n\tmso-para-margin:0in;\n\tmso-para-margin-bottom:.0001pt;\n\tmso-pagination:widow-orphan;\n\tfont-size:10.0pt;\n\tfont-family:\"Times New Roman\",serif;}\n</style>\n<![endif]--></div>",
    //                         "materialId": 3,
    //                         "contractTypeId": 1
    //                     },
    //                     "loadPort": {
    //                         "port": "BANDAR ABBAS",
    //                         "countryId": 1
    //                     },
    //                     "createdDate": 1600005922013,
    //                     "createdBy": "r.mazloom",
    //                     "lastModifiedDate": 1600674681760,
    //                     "lastModifiedBy": "r.mazloom",
    //                     "version": 21
    //                 },
    //                 "estatus": [
    //                     "Active"
    //                 ],
    //                 "moisture": 0
    //             },
    //             "estatus": [
    //                 "Active"
    //             ],
    //             "_selection_79": true,
    //             "_embeddedComponents_isc_ListGrid_1": null
    //         }
    //     ],
    //     "shipmentId": 1,
    //     "inspectionWeightId": 263,
    //     "inspectionAssayId": 263,
    //     "creatorId": 2,
    //     "currencyId": -32,
    //     "toCurrencyId": null,
    //     "conversionRefId": null
    // });

    // Molybdenum
    // foreignInvoiceTab.dynamicForm.valuesManager.setValues({
    //     "date": "2020-11-01T08:30:00.000Z",
    //     "billLadings": [
    //         {
    //             "documentNo": "662",
    //             "switchDocumentNo": "662",
    //             "shipperExporterId": 2,
    //             "switchShipperExporterId": 2,
    //             "notifyPartyId": 225,
    //             "switchNotifyPartyId": 225,
    //             "consigneeId": 1,
    //             "switchConsigneeId": 1,
    //             "portOfLoadingId": 33,
    //             "switchPortOfLoadingId": 33,
    //             "portOfDischargeId": 29,
    //             "switchPortOfDischargeId": 29,
    //             "placeOfDelivery": "XIAMEN",
    //             "oceanVesselId": 33,
    //             "numberOfBlCopies": 4,
    //             "dateOfIssue": 1601713800000,
    //             "placeOfIssue": "rty",
    //             "shipmentId": 41,
    //             "shipmentTypeId": 2,
    //             "shipmentMethodId": 2,
    //             "id": 121,
    //             "shipperExporter": {
    //                 "nameFA": "شرکت ملی صنایع مس ایران",
    //                 "nameEN": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "name": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "phone": "+982182138231",
    //                 "fax": "+982188102822",
    //                 "address": "NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Seller",
    //                 "seller": true,
    //                 "buyer": false,
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFA": "ایران",
    //                     "nameEN": "Iran (Islamic Republic of)",
    //                     "name": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1578197254109,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1601451512407,
    //                 "lastModifiedBy": "emami",
    //                 "version": 7
    //             },
    //             "switchShipperExporter": {
    //                 "nameFA": "شرکت ملی صنایع مس ایران",
    //                 "nameEN": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "name": "NATIONAL IRANIAN COPPER INDUSTRIES CO.",
    //                 "phone": "+982182138231",
    //                 "fax": "+982188102822",
    //                 "address": "NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN",
    //                 "type": false,
    //                 "status": true,
    //                 "commercialRole": "Seller",
    //                 "seller": true,
    //                 "buyer": false,
    //                 "countryId": 1,
    //                 "id": 2,
    //                 "country": {
    //                     "nameFA": "ایران",
    //                     "nameEN": "Iran (Islamic Republic of)",
    //                     "name": "Iran (Islamic Republic of)"
    //                 },
    //                 "createdDate": 1578197254109,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1601451512407,
    //                 "lastModifiedBy": "emami",
    //                 "version": 7
    //             },
    //             "notifyParty": {
    //                 "nameFA": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
    //                 "nameEN": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
    //                 "name": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
    //                 "phone": "+86 021-68818789",
    //                 "fax": "+86 021-68828789",
    //                 "type": true,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 225,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1589591572259,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0
    //             },
    //             "switchNotifyParty": {
    //                 "nameFA": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
    //                 "nameEN": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
    //                 "name": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
    //                 "phone": "+86 021-68818789",
    //                 "fax": "+86 021-68828789",
    //                 "type": true,
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 225,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1589591572259,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0
    //             },
    //             "consignee": {
    //                 "nameFA": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "nameEN": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "name": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "phone": "+8601068495586",
    //                 "fax": "+8601068495562",
    //                 "address": "NO.5 SANLIHE ROAD, HAIDIAN DISTRICT, BEIJING 100044, P.R. CHINA ",
    //                 "type": false,
    //                 "nationalCode": "0",
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "seller": false,
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 1,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1578197169411,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600688095376,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 47,
    //                 "defaultAccount": {
    //                     "contactId": 1,
    //                     "bankId": 2,
    //                     "bankAccount": "90101",
    //                     "bankShaba": "IR888888800000000008888888",
    //                     "code": "110019",
    //                     "bankSwift": "898888800000088",
    //                     "accountOwner": "88000008",
    //                     "status": true,
    //                     "isDefault": true,
    //                     "id": 10,
    //                     "bank": {
    //                         "nameFA": "ای سی ای",
    //                         "countryId": 15,
    //                         "nameEN": "ECA",
    //                         "address": "NY",
    //                         "coreBranch": "core"
    //                     },
    //                     "createdDate": 1600245090704,
    //                     "createdBy": "db_zare",
    //                     "lastModifiedDate": 1600690356857,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 9
    //                 }
    //             },
    //             "switchConsignee": {
    //                 "nameFA": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "nameEN": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "name": "CHINA MINMETALS NON-FERROUS METALS CO., LTD",
    //                 "phone": "+8601068495586",
    //                 "fax": "+8601068495562",
    //                 "address": "NO.5 SANLIHE ROAD, HAIDIAN DISTRICT, BEIJING 100044, P.R. CHINA ",
    //                 "type": false,
    //                 "nationalCode": "0",
    //                 "status": true,
    //                 "commercialRole": "Buyer",
    //                 "seller": false,
    //                 "buyer": true,
    //                 "countryId": 2,
    //                 "id": 1,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China"
    //                 },
    //                 "createdDate": 1578197169411,
    //                 "createdBy": "dorani_sa",
    //                 "lastModifiedDate": 1600688095376,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 47,
    //                 "defaultAccount": {
    //                     "contactId": 1,
    //                     "bankId": 2,
    //                     "bankAccount": "90101",
    //                     "bankShaba": "IR888888800000000008888888",
    //                     "code": "110019",
    //                     "bankSwift": "898888800000088",
    //                     "accountOwner": "88000008",
    //                     "status": true,
    //                     "isDefault": true,
    //                     "id": 10,
    //                     "bank": {
    //                         "nameFA": "ای سی ای",
    //                         "countryId": 15,
    //                         "nameEN": "ECA",
    //                         "address": "NY",
    //                         "coreBranch": "core"
    //                     },
    //                     "createdDate": 1600245090704,
    //                     "createdBy": "db_zare",
    //                     "lastModifiedDate": 1600690356857,
    //                     "lastModifiedBy": "db_zare",
    //                     "version": 9
    //                 }
    //             },
    //             "portOfLoading": {
    //                 "port": "FANGCHENG",
    //                 "countryId": 2,
    //                 "id": 33,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China",
    //                     "id": 2,
    //                     "createdDate": 1599977039984,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587866451161,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfLoading": {
    //                 "port": "FANGCHENG",
    //                 "countryId": 2,
    //                 "id": 33,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China",
    //                     "id": 2,
    //                     "createdDate": 1599977039984,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587866451161,
    //                 "createdBy": "db_mazloom",
    //                 "version": 0,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "portOfDischarge": {
    //                 "port": "XIAMEN",
    //                 "countryId": 2,
    //                 "id": 29,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China",
    //                     "id": 2,
    //                     "createdDate": 1599977039984,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587866198689,
    //                 "createdBy": "db_mazloom",
    //                 "lastModifiedDate": 1587866273960,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 1,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "switchPortOfDischarge": {
    //                 "port": "XIAMEN",
    //                 "countryId": 2,
    //                 "id": 29,
    //                 "country": {
    //                     "nameFA": "چین",
    //                     "nameEN": "China",
    //                     "name": "China",
    //                     "id": 2,
    //                     "createdDate": 1599977039984,
    //                     "createdBy": "j.azad",
    //                     "version": 0,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "createdDate": 1587866198689,
    //                 "createdBy": "db_mazloom",
    //                 "lastModifiedDate": 1587866273960,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 1,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "oceanVessel": {
    //                 "name": "KOTA BAHAGIA",
    //                 "type": "Bulk Carrier",
    //                 "imo": "9593672",
    //                 "yearOfBuild": 2011,
    //                 "length": 161,
    //                 "beam": 27,
    //                 "id": 33,
    //                 "createdDate": 1588382394277,
    //                 "createdBy": "db_mazloom",
    //                 "lastModifiedDate": 1588382431179,
    //                 "lastModifiedBy": "db_mazloom",
    //                 "version": 1,
    //                 "editable": true,
    //                 "estatus": [
    //                     "Active"
    //                 ]
    //             },
    //             "containers": [],
    //             "shipmentType": {
    //                 "shipmentType": "CONTAINER",
    //                 "id": 2,
    //                 "createdDate": 1587278588350,
    //                 "createdBy": "j.azad",
    //                 "lastModifiedDate": 1587278588350,
    //                 "lastModifiedBy": "j.azad",
    //                 "version": 0
    //             },
    //             "shipmentMethod": {
    //                 "shipmentMethod": "AIR TRANSPORT",
    //                 "id": 2,
    //                 "createdDate": 1587278588350,
    //                 "createdBy": "j.azad",
    //                 "lastModifiedDate": 1587278588350,
    //                 "lastModifiedBy": "j.azad",
    //                 "version": 0
    //             },
    //             "createdDate": 1601721789781,
    //             "createdBy": "m.shahabi",
    //             "version": 0,
    //             "editable": true,
    //             "shipment": {
    //                 "contractShipmentId": 161,
    //                 "shipmentTypeId": 2,
    //                 "shipmentMethodId": 2,
    //                 "contactId": 225,
    //                 "materialId": 1,
    //                 "contactAgentId": 136,
    //                 "unitId": -32,
    //                 "dischargePortId": 30,
    //                 "amount": 678000,
    //                 "automationLetterNo": "35435",
    //                 "automationLetterDate": 1569702600000,
    //                 "sendDate": 1594080000000,
    //                 "noBLs": 4,
    //                 "bookingCat": "66644",
    //                 "arrivalDateFrom": 1601713800000,
    //                 "arrivalDateTo": 1601713800000,
    //                 "lastDeliveryLetterDate": 1601713800000,
    //                 "id": 41,
    //                 "createdDate": 1601719169394,
    //                 "createdBy": "m.shahabi",
    //                 "lastModifiedDate": 1603091149068,
    //                 "lastModifiedBy": "db_zare",
    //                 "version": 1,
    //                 "editable": true,
    //                 "unit": {
    //                     "nameFA": "دلار آمریکا",
    //                     "nameEN": "US Dollar",
    //                     "name": "US Dollar",
    //                     "categoryUnit": "Finance",
    //                     "symbolUnit": "$",
    //                     "id": -32,
    //                     "createdDate": 1599977041075,
    //                     "createdBy": "liquibase",
    //                     "lastModifiedDate": 1600059510446,
    //                     "lastModifiedBy": "karimi",
    //                     "version": 1,
    //                     "editable": false,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "contact": {
    //                     "nameFA": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
    //                     "nameEN": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
    //                     "name": "HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.",
    //                     "phone": "+86 021-68818789",
    //                     "fax": "+86 021-68828789",
    //                     "type": true,
    //                     "status": true,
    //                     "commercialRole": "Buyer",
    //                     "buyer": true,
    //                     "countryId": 2,
    //                     "id": 225,
    //                     "country": {
    //                         "nameFA": "چین",
    //                         "nameEN": "China",
    //                         "name": "China"
    //                     },
    //                     "createdDate": 1589591572259,
    //                     "createdBy": "db_mazloom",
    //                     "version": 0
    //                 },
    //                 "dischargePort": {
    //                     "port": "ZHOUSHAN",
    //                     "countryId": 2,
    //                     "id": 30,
    //                     "country": {
    //                         "nameFA": "چین",
    //                         "nameEN": "China",
    //                         "name": "China",
    //                         "id": 2,
    //                         "createdDate": 1599977039984,
    //                         "createdBy": "j.azad",
    //                         "version": 0,
    //                         "editable": false,
    //                         "estatus": [
    //                             "Active"
    //                         ]
    //                     },
    //                     "createdDate": 1587866229644,
    //                     "createdBy": "db_mazloom",
    //                     "version": 0,
    //                     "editable": true,
    //                     "estatus": [
    //                         "Active"
    //                     ]
    //                 },
    //                 "contactAgent": {
    //                     "nameFA": "GRASH DARYA",
    //                     "nameEN": "GRASH DARYA",
    //                     "name": "GRASH DARYA",
    //                     "phone": "21-88727255",
    //                     "fax": "21-88726762",
    //                     "type": false,
    //                     "status": true,
    //                     "tradeMark": "GRASH DARYA",
    //                     "commercialRole": "Transporter",
    //                     "seller": false,
    //                     "transporter": true,
    //                     "agentBuyer": false,
    //                     "countryId": 1,
    //                     "id": 136,
    //                     "country": {
    //                         "nameFA": "ایران",
    //                         "nameEN": "Iran (Islamic Republic of)",
    //                         "name": "Iran (Islamic Republic of)"
    //                     },
    //                     "createdDate": 1587875271899,
    //                     "createdBy": "db_mazloom",
    //                     "lastModifiedDate": 1588475503870,
    //                     "lastModifiedBy": "db_mazloom",
    //                     "version": 1
    //                 },
    //                 "material": {
    //                     "descEN": "Molybdenum Oxide",
    //                     "descFA": "اکسید مولیبدن",
    //                     "code": "28257000",
    //                     "unitId": -1,
    //                     "abbreviation": "MO",
    //                     "id": 1,
    //                     "unit": {
    //                         "nameFA": "تن",
    //                         "nameEN": "MT",
    //                         "name": "MT",
    //                         "categoryUnit": "Weight",
    //                         "symbolUnit": "PERCENT"
    //                     },
    //                     "createdDate": 1599977041718,
    //                     "createdBy": "liquibase",
    //                     "version": 3
    //                 },
    //                 "shipmentType": {
    //                     "shipmentType": "CONTAINER",
    //                     "id": 2,
    //                     "createdDate": 1587278588350,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1587278588350,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 0
    //                 },
    //                 "shipmentMethod": {
    //                     "shipmentMethod": "AIR TRANSPORT",
    //                     "id": 2,
    //                     "createdDate": 1587278588350,
    //                     "createdBy": "j.azad",
    //                     "lastModifiedDate": 1587278588350,
    //                     "lastModifiedBy": "j.azad",
    //                     "version": 0
    //                 },
    //                 "contractShipment": {
    //                     "loadPortId": 33,
    //                     "quantity": 152,
    //                     "sendDate": "2020-07-07",
    //                     "tolorance": 6,
    //                     "contractId": 166,
    //                     "id": 161,
    //                     "contract": {
    //                         "no": "567",
    //                         "date": 1603528200000,
    //                         "affectFrom": 1603528200000,
    //                         "affectUpTo": 1603528200000,
    //                         "content": "<br><div align=\"center\"><b>IN THE NAME OF ALLAH</b><br></div><br>THIS CONTRACT IS SIGNED &amp; STAMPED BETWEEN FOLLOWING COMPANIES AND PARTIES ARE OBLIGATED AND BOUND TO FULFILL:<br><br><b>HUARUO(SHANGHAI) INDUSTRIAL CO.,LTD.</b><br>,<br>MOBILE NUMBER: ,<br>TEL: +86 021-68818789, FAX: +86 021-68828789<br><br>HEREINAFTER CALLED “BUYER”,<br><br><b>AND</b><br><br><b>NATIONAL IRANIAN COPPER INDUSTRIES CO.</b><br>NO. 2161 VALI-E-ASR AVE., NEXT TO SAEI PARK, TEHRAN, IRAN<br><br>TEL: +982182138231, FAX:&nbsp; +982188102822<br>HEREINAFTER CALLED “SELLER”,<br><br><br>THEREFORE, “SELLER” AGREES HEREBY TO SELL AND DELIVER AND “BUYER” AGREES TO PURCHASE, RECEIVE AND PAY FOR THE MOLYBDENUM OXIDE SPECIFIED BELOW AS PER THE FOLLOWING TERMS AND CONDITIONS:<br><b><br>ARTICLE 1 – DEFINITIONS:</b><br>1 TON = 1 METRIC TON OF 1'000 KILOGRAMS OR 2204.62 LBS<br>WORKING/BUSINESS DAY FOR BUYER = MONDAY TO THURSDAY, FRIDAY; SATURDAY AND LEGAL HOLIDAY EXCLUDED<br>WORKING/BUSINESS DAY FOR SELLER = SATURDAY TO WEDNESDAY; THURSDAY AND FRIDAY AND LEGAL HOLIDAY EXCLUDED.<br>AM/PM = ANTE MERIDIEM / POST MERIDIEM<br>THE MATERIAL = SHALL MEAN THE MATERIAL AS DEFINED IN \"ARTICLE 3 – QUALITY\"<br>FOB = FREE ON BOARD (ACCORDING TO INCOTERMS 2010).<br>USD = USD AND USC = DOLLARS AND CENTS ARE UNITED STATES CURRENCY<br>AED = UNITED ARAB EMIRATES DIRHAM<br>EURO = EURO IS THE SINGLE CURRENCY OF THE EUROPEAN ECONOMIC AND MONETARY UNION (EMU) INTRODUCED IN JANUARY 1999.<br><br><br><br><h2>MoArticle3Quantity</h2>\n\n\n\t\n\t\n\t\n\t\n\n<p dir=\"ltr\">\n\n\n\n\t\n\t\n\t\n\t\n\n</p><h1 dir=\"ltr\" class=\"ctl\">\n<font face=\"Palatino, Book Antiqua\"><font style=\"font-size: 12pt\" size=\"3\"><span lang=\"en-US\"><span style=\"font-variant: normal\"><font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><u>ARTICLE\n3 – QUALITY:</u></font></font></font></span></span></font></font></h1>\n<p dir=\"ltr\"><font face=\"Palatino, Book Antiqua\"><font style=\"font-size: 12pt\" size=\"3\"><span lang=\"en-US\"><font color=\"#000000\"><font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\">MOLYBDENUM\nOXIDE ASSAYS ARE AS FOLLOWS:</font></font></font></span></font></font></p>\n<p dir=\"ltr\"><br>\n\n</p>\n<ul><li><p dir=\"ltr\" style=\"background: #ffffff\" align=\"justify\"><font style=\"font-size: 12pt\" size=\"3\"><span lang=\"en-US\"><font color=\"#000000\"><font style=\"font-size: 8pt\" size=\"1\">90\n\tMT</font></font><font color=\"#000000\"><font style=\"font-size: 8pt\" size=\"1\">\n\t</font></font><font color=\"#000000\"><font style=\"font-size: 8pt\" size=\"1\">±10%</font></font><font color=\"#000000\"><font style=\"font-size: 8pt\" size=\"1\">\n\tAS A WHOLE AFTER CONTRACT SETTLEMENT WITH BELOW ANALYSIS AND SIZE\n\tDETERMINATION:</font></font></span></font></p>\n</li></ul><br>\n<table dir=\"ltr\" width=\"408\" cellspacing=\"0\" cellpadding=\"7\">\n\t<colgroup><col width=\"43\">\n\n\t<col width=\"52\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t<col width=\"33\">\n\n\t</colgroup><tbody><tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" height=\"17\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"left\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Lot\n\t\t\tName</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Mo<br>\n%</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Cu<br>\n%</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Si<br>\n%</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>Pb<br>\n%</b></span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>S<br>\n%\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>C<br>\n%\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>P<br>\n%\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" height=\"4\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>E-18\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">62.15</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">1.29</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.92</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.05</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.02</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">&lt;\n\t\t\t0.03 </span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>E-19\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">62.02</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">1.16</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.85</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.06</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.06</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.01</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">&lt;\n\t\t\t0.03 </span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>E-21\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">61.90</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">1.24</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.83</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.01</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">&lt;\n\t\t\t0.03 </span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n\t<tr>\n\t\t<td style=\"background: #ffffff\" width=\"43\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\"><b>E-22\n\t\t\t</b></span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"52\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">61.84</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">1.32</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.83</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.07</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">0.01</span></font></font></p>\n\t\t</td>\n\t\t<td style=\"background: #ffffff\" width=\"33\" bgcolor=\"#ffffff\"><p class=\"ctl\" align=\"center\">\n\t\t\t<font face=\"Times New Roman, serif\"><font style=\"font-size: 8pt\" size=\"1\"><span lang=\"en-US\">&lt;\n\t\t\t0.03 </span></font></font>\n\t\t\t</p>\n\t\t</td>\n\t</tr>\n</tbody></table>\n<p dir=\"ltr\" style=\"background: #ffffff\" align=\"left\"><br>\n\n</p>\n\n<style type=\"text/css\">\n\t\tp { direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2; background: transparent }\n\t\tp.western { font-family: \"Times New Roman\", serif; font-size: 10pt; so-language: en-US }\n\t\tp.cjk { font-family: \"Times New Roman\", serif; font-size: 10pt }\n\t\tp.ctl { font-family: \"Times New Roman\", serif; font-size: 10pt; so-language: ar-SA }\n\t\ta:link { color: #0000ff; text-decoration: underline }</style><h2>MoShipment</h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Load Port</th><th style='border: 1px solid black;'>Quantity</th><th style='border: 1px solid black;'>Tolorance</th><th style='border: 1px solid black;'>Send Date</th></tr><tr><td style='border: 1px solid black;'>FANGCHENG</td><td style='border: 1px solid black;'>152</td><td style='border: 1px solid black;'>6</td><td style='border: 1px solid black;'>Tue Jul 07 2020 12:00:00 GMT+0430 (Iran Daylight Time)</td></tr></table><br><h2>ARTICLE - PRICE</h2><table style='border: 1px solid black;'><tr><th style='border: 1px solid black;'>Minimum</th><th style='border: 1px solid black;'>Maximum</th><th style='border: 1px solid black;'>Discount</th><th style='border: 1px solid black;'>Material Element</th></tr><tr><td style='border: 1px solid black;'>1</td><td style='border: 1px solid black;'>67</td><td style='border: 1px solid black;'>6</td><td style='border: 1px solid black;'>MO</td></tr></table><br><h2>QoutationalPriod</h2><table style='border: 1px solid black;'><tr></tr><tr></tr><tr></tr></table><br><h2>DELIEVERY TERMS</h2>Incoterms-2020<br>",
    //                         "materialId": 1,
    //                         "contractTypeId": 1
    //                     },
    //                     "loadPort": {
    //                         "port": "FANGCHENG",
    //                         "countryId": 2
    //                     },
    //                     "createdDate": 1601719102261,
    //                     "createdBy": "m.shahabi",
    //                     "lastModifiedDate": 1603522607266,
    //                     "lastModifiedBy": "m.shahabi",
    //                     "version": 17
    //                 },
    //                 "moisture": 0
    //             },
    //             "estatus": [
    //                 "Active"
    //             ],
    //             "_selection_87": true,
    //             "_embeddedComponents_isc_ListGrid_1": null
    //         }
    //     ],
    //     "invoiceTypeId": 1,
    //     "contractId": 166,
    //     "shipmentId": 41,
    //     "inspectionWeightId": 223,
    //     "inspectionAssayId": 223,
    //     "creatorId": 2,
    //     "currencyId": -32,
    //     "toCurrencyId": null,
    //     "conversionRefId": null
    // });

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
                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("calculationData", calculationRowData);
                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("rcDeductionData", rcRowData);
                                            foreignInvoiceTab.dynamicForm.valuesManager.setValue("basePriceData", basePriceData);
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

foreignInvoiceTab.method.validateDeleteActionHook = function (record) {

    if (!record.parentId)
        foreignInvoiceTab.dialog.say('<spring:message code="global.grid.record.not.removable"/>');
    return record.parentId;
};

foreignInvoiceTab.listGrid.main.rowClick = function (record, recordNum, fieldNum) {

    let tabName = foreignInvoiceTab.tab.main.getTab(foreignInvoiceTab.tab.main.selectedTab).name;
    if (tabName === "notSent") {

        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.EDIT).first().show();
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DELETE).first().show();
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.ACTIVATE).first().show();
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DEACTIVATE).first().show();
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.FINALIZE).first().show();
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DISAPPROVE).first().show();
        // <c:if test = "${C_FOREIGN_INVOICE_COMPLETION}">
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "invoiceCompletion").first().show();
        // </c:if>
        foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "relatedInvoice").first().show();

        if (record.parentId) {
            foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.EDIT).first().hide();
            foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.ACTIVATE).first().hide();
            foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DEACTIVATE).first().hide();
            foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.FINALIZE).first().hide();
            foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DISAPPROVE).first().hide();
            // <c:if test = "${C_FOREIGN_INVOICE_COMPLETION}">
            foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "invoiceCompletion").first().hide();
            // </c:if>
            foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.name === "relatedInvoice").first().show();
        } else
            foreignInvoiceTab.toolStrip.main.getMembers().filter(q => q.actionType === nicico.ActionType.DELETE).first().hide();
    }

    this.Super("rowClick", arguments);
};

foreignInvoiceTab.listGrid.main.getCellCSSText = function (record, rowNum, colNum) {

    if (record.parentId) {
        return "font-weight:bold; color:#2f8be0;";
    }
    return this.Super('getCellCSSText', arguments)
};

foreignInvoiceTab.method.addTab = function (pane, title) {
    foreignInvoiceTab.tab.invoice.addTab({
        pane: pane,
        title: title,
        paneMargin: 5
    });
};

//*************************************************** REST *************************************************************

// MOCK
// foreignInvoiceTab.variable.contractDetailData.MOASValue = 0;
// foreignInvoiceTab.variable.contractDetailData.workingDayAfterMOAS = 5;
// foreignInvoiceTab.variable.contractDetailData.workingDayBeforeMOAS = -5;
// foreignInvoiceTab.variable.contractDetailData.basePriceReference = "LME";
// foreignInvoiceTab.variable.contractDetailData.tc = 123456;
// foreignInvoiceTab.variable.contractDetailData.rc = [{
//     elementId: 1,
//     elementName: "CU",
//     price: 12.3,
//     weightUnit: {id: -1, nameEN: "Pound", categoryUnit: "Weight"},
//     financeUnit: {id: -32, nameEN: "Dollar", categoryUnit: "Finance"}
// }, {
//     elementId: 2,
//     elementName: "AG",
//     price: 11.3,
//     weightUnit: {id: -1, nameEN: "Pound", categoryUnit: "Weight"},
//     financeUnit: {id: -32, nameEN: "Dollar", categoryUnit: "Finance"}
// }, {
//     elementId: 3,
//     elementName: "AU",
//     price: 12.4,
//     weightUnit: {id: -1, nameEN: "Pound", categoryUnit: "Weight"},
//     financeUnit: {id: -32, nameEN: "Dollar", categoryUnit: "Finance"}
// }, {
//     elementId: 4,
//     elementName: "MO",
//     price: 14.4,
//     weightUnit: {id: -1, nameEN: "Pound", categoryUnit: "Weight"},
//     financeUnit: {id: -32, nameEN: "Dollar", categoryUnit: "Finance"}
// }];
// foreignInvoiceTab.variable.contractDetailData.QPAtricleText = "QUOTATIONAL PERIOD FOR MOLYBDENUM OXIDE SHALL BE THE AVERAGE OF THE MONTH FOLLOWING MONTH OF ACTUAL SHIPMENT (MOAS+(\n" +
//     "${MOAS})) FROM THE PORT OF LOADING AS EVIDENCED BY THE B/L DATE.";
// foreignInvoiceTab.variable.contractDetailData.unitPriceAtricleText = "USD 6.24 PER NET METRIC TON PLUS A PREMIUM OF USD 0.05 PER METRIC TON";
// foreignInvoiceTab.variable.contractDetailData.unitPrice = 6.29;
