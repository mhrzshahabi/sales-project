//****************************************************** VARIABLES *****************************************************

var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

contractTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/";
contractTab.variable.contractDetailTypeUrl = "${contextPath}" + "/api/contract-detail-type/";
contractTab.variable.dataType = JSON.parse('${Enum_DataType}');
contractTab.variable.contractType = "${Contract_Type_Id}";
contractTab.variable.units = [];
contractTab.variable.criteria = {};
contractTab.variable.contractDetails = {};
getReferenceDataSource("Unit").fetchData(null, resp => {

    if (resp && resp.httpResponseCode === 200 || resp.httpResponseCode === 201)
        contractTab.variable.units = JSON.parse(resp.httpResponseText).response.data;
});

//*************************************************** RESTDATASOURCES **************************************************

contractTab.restDataSource.contractDetailType = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey: true, hidden: true},
        {name: "title"},
        {name: "titleFA"},
        {name: "titleEN"}
    ],
    addDataURL: null,
    fetchDataURL: contractTab.variable.contractDetailTypeUrl + "spec-list"
});

//******************************************************* FORMITEMS ****************************************************

contractTab.method.getDynamicFormFields = function () {

    return BaseFormItems.concat([
        // {
        //     useInGrid: true,
        //     name: "content",
        //     width: "100%",
        //     hidden: true
        // },
        {
            useInGrid: true,
            name: "no",
            width: "100%",
            required: true,
            title: "<spring:message code='contract.form.no'/>"
        },
        {
            useInGrid: true,
            name: "date",
            type: "date",
            width: "100%",
            required: true,
            title: "<spring:message code='global.date'/>"
        },
        {
            name: "affectFrom",
            title: "<spring:message code='contract.affect.from'/>",
            type: "date",
            width: "100%",
            required: true,
        },
        {
            name: "affectUpTo",
            title: "<spring:message code='contract.affect.upto'/>",
            type: "date",
            width: "10%",
            // required: true,
        },
        {
            useInGrid: true,
            name: "materialId",
            width: "100%",
            filterOperator: 'equals',
            editorType: "SelectItem",
            optionDataSource: isc.MyRestDataSource.create({
                fields: [
                    {name: "id", title: "id", primaryKey: true, hidden: true},
                    {name: "code", title: "<spring:message code='goods.code'/> "},
                    {name: "descEN"},
                    {name: "unitId"},
                    {name: "unit.nameEN"}
                ],
                fetchDataURL: "${contextPath}/api/material/spec-list"
            }),
            autoFetchData: false,
            displayField: "descEN",
            valueField: "id",
            required: true,
            title: "<spring:message code='material.title'/>",
            changed: function (form, item, value) {

                contractTab.listGrid.contractDetailType.setCriteria({
                    operator: 'and',
                    criteria: [{
                        fieldName: 'materialId',
                        operator: 'equals',
                        value: value
                    }, {
                        fieldName: 'estatus',
                        operator: 'notEqual',
                        value: Enums.eStatus2.DeActive
                    }]
                });
                contractTab.dynamicForm.valuesManager.setValue("material", this.getSelectedRecord());
                contractTab.method.removeArticles();

                return this.Super("changed", arguments);
            }
        },
        {
            useInGrid: true,
            name: "contractTypeId",
            width: "100%",
            filterOperator: 'equals',
            editorType: "SelectItem",
            optionDataSource: isc.MyRestDataSource.create({
                fields: [
                    {name: "id", title: "id", primaryKey: true, hidden: true},
                    {name: "code", title: "<spring:message code='goods.code'/> "},
                    {name: "titleFa"},
                    {name: "titleEn"},
                    {name: "description"}
                ],
                fetchDataURL: "${contextPath}/api/contract-type/spec-list"
            }),
            optionCriteria: {fieldName: "id", operator: "notEqual", value: 2},
            autoFetchData: false,
            displayField: "titleEn",
            valueField: "id",
            required: true,
            hidden: true,
            title: "<spring:message code='entity.contract-type'/>",
            defaultValue: Number(contractTab.variable.contractType)
        },
        Object.assign(getContactFieldByType("buyer"), {
            useInGrid: true,
            changed: function (form, item, value) {

                let buyer = this.getSelectedRecord();
                contractTab.dynamicForm.valuesManager.setValue("buyer", buyer);

                if (buyer) {

                    contractTab.dynamicForm.valuesManager.setValue("BUYER_NAME", buyer.nameEN);
                    contractTab.dynamicForm.valuesManager.setValue("BUYER_MAIL", buyer.email);
                    contractTab.dynamicForm.valuesManager.setValue("BUYER_ADDRESS", buyer.address);
                    contractTab.dynamicForm.valuesManager.setValue("BUYER_PHONE", buyer.phone);
                    contractTab.dynamicForm.valuesManager.setValue("BUYER_FAX", buyer.fax);
                    contractTab.dynamicForm.valuesManager.setValue("BUYER_MOBILE", buyer.mobile);
                    contractTab.dynamicForm.valuesManager.setValue("BUYER_POSTAL_CODE", buyer.postalCode);
                }

                return this.Super("changed", arguments);
            }
        }),
        Object.assign(getContactFieldByType("seller"), {
            useInGrid: true,
            changed: function (form, item, value) {

                let seller = this.getSelectedRecord();
                contractTab.dynamicForm.valuesManager.setValue("seller", seller);

                if (seller) {

                    contractTab.dynamicForm.valuesManager.setValue("SELLER_NAME", seller.nameEN);
                    contractTab.dynamicForm.valuesManager.setValue("SELLER_MAIL", seller.email);
                    contractTab.dynamicForm.valuesManager.setValue("SELLER_ADDRESS", seller.address);
                    contractTab.dynamicForm.valuesManager.setValue("SELLER_PHONE", seller.phone);
                    contractTab.dynamicForm.valuesManager.setValue("SELLER_FAX", seller.fax);
                    contractTab.dynamicForm.valuesManager.setValue("SELLER_MOBILE", seller.mobile);
                    contractTab.dynamicForm.valuesManager.setValue("SELLER_POSTAL_CODE", seller.postalCode);
                }

                return this.Super("changed", arguments);
            }
        }),
        Object.assign(getContactFieldByType("agentBuyer"), {
            useInGrid: true,
            changed: function (form, item, value) {

                let agentBuyer = this.getSelectedRecord();
                contractTab.dynamicForm.valuesManager.setValue("agentBuyer", agentBuyer);

                if (agentBuyer) {

                    contractTab.dynamicForm.valuesManager.setValue("AGENT_BUYER_NAME", agentBuyer.nameEN);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_BUYER_MAIL", agentBuyer.email);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_BUYER_ADDRESS", agentBuyer.address);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_BUYER_PHONE", agentBuyer.phone);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_BUYER_FAX", agentBuyer.fax);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_BUYER_MOBILE", agentBuyer.mobile);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_BUYER_POSTAL_CODE", agentBuyer.postalCode);
                }

                return this.Super("changed", arguments);
            }
        }),
        Object.assign(getContactFieldByType("agentSeller"), {
            useInGrid: true,
            changed: function (form, item, value) {

                let agentSeller = this.getSelectedRecord();
                contractTab.dynamicForm.valuesManager.setValue("agentSeller", agentSeller);

                if (agentSeller) {

                    contractTab.dynamicForm.valuesManager.setValue("AGENT_SELLER_NAME", agentSeller.nameEN);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_SELLER_MAIL", agentSeller.email);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_SELLER_ADDRESS", agentSeller.address);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_SELLER_PHONE", agentSeller.phone);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_SELLER_FAX", agentSeller.fax);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_SELLER_MOBILE", agentSeller.mobile);
                    contractTab.dynamicForm.valuesManager.setValue("AGENT_SELLER_POSTAL_CODE", agentSeller.postalCode);
                }

                return this.Super("changed", arguments);
            }
        }),
        {
            colSpan: 8,
            width: "100%",
            type: "TextArea",
            name: "description",
            title: "<spring:message code='global.description'/>"
        }
    ]);
};

contractTab.dynamicForm.fields = contractTab.method.getDynamicFormFields();
contractTab.listGrid.fields = contractTab.method.getDynamicFormFields().filter(field => field.useInGrid || field.isBaseItem);
contractTab.listGrid.fields.forEach(item => {

    if (contractTab.variable.contractType === "3") return;
    if (item.isBaseItem && item.name === "estatus") item.hidden = false;
});

//******************************************************* COMPONENTS ***************************************************

nicico.BasicFormUtil.createDynamicForm = function (creator) {

    contractTab.dynamicForm.valuesManager = isc.ValuesManager.create({
        autoSynchronize: true,
    });
    contractTab.dynamicForm.main = isc.DynamicForm.create({
        width: "100%",
        height: "15%",
        numCols: 8,
        margin: 10,
        canSubmit: true,
        showErrorText: true,
        showErrorStyle: true,
        showInlineErrors: true,
        errorOrientation: "bottom",
        fields: contractTab.dynamicForm.fields,
        valuesManager: contractTab.dynamicForm.valuesManager,
        titleAlign: nicico.CommonUtil.getAlignByLangReverse(),
        requiredMessage: '<spring:message code="validator.field.is.required"/>'
    });
};
nicico.BasicFormUtil.createListGrid = function (creator) {

    if (contractTab.variable.contractType === "1")
        contractTab.variable.criteria = {
            operator: 'and',
            _constructor: "AdvancedCriteria",
            criteria: [
                {
                    operator: 'or',
                    _constructor: "AdvancedCriteria",
                    criteria: [
                        {
                            fieldName: 'contractTypeId',
                            operator: 'equals',
                            value: 1
                        },
                        {
                            fieldName: 'contractTypeId',
                            operator: 'equals',
                            value: 2
                        },
                    ]
                }
            ]
        };
    else
        contractTab.variable.criteria = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [
                {
                    fieldName: "contractTypeId",
                    operator: "equals",
                    value: contractTab.variable.contractType
                }
            ]
        };

    creator.listGrid.main = isc.ListGrid.nicico.getDefault(creator.listGrid.fields, creator.restDataSource.main, contractTab.variable.criteria, {
        sortField: 'no',
        getCellCSSText: function (record, rowNum, colNum) {
            if (record.parentId) {
                return "font-weight:bold; color:#287fd6;";
            }
            return this.Super('getCellCSSText', arguments)
        }
    });
};

contractTab.listGrid.contractDetailType = isc.ListGrid.nicico.getDefault(BaseFormItems.concat([
    {
        name: "title", title: '<spring:message code="global.title-en"/>',
        sortNormalizer: function (recordObject) {

            let sortOrder = 0;
            if (!recordObject || !recordObject.title)
                return sortOrder;

            if (/.*footer.*/i.test(recordObject.title))
                return Number.MAX_VALUE;

            let pattern = /\D*(\d+)\D*/;
            if (pattern.test(recordObject.title))
                sortOrder = Number(pattern.exec(recordObject.title)[1]);
            else if (!/.*header.*/i.test(recordObject.title))
                return Number.MAX_VALUE - 1;

            return sortOrder;
        }
    },
    {width: 40, name: "addIcon", align: "center", showTitle: false, canFilter: false}
]), contractTab.restDataSource.contractDetailType, {
    operator: 'and',
    criteria: [{
        fieldName: 'materialId',
        operator: 'equals',
        value: null
    }, {
        fieldName: 'estatus',
        operator: 'notEqual',
        value: Enums.eStatus2.DeActive
    }]
}, {
    width: "30%",
    sortField: 1,
    showResizeBar: true,
    showFilterEditor: false,
    showRecordComponents: true,
    setAutoFitExtraRecords: true,
    showRecordComponentsByCell: true,
    createRecordComponent: function (record, colNum) {

        var fieldName = this.getFieldName(colNum);
        if (fieldName === "addIcon") {

            // <sec:authorize access="hasAuthority('C_CONTRACT_DETAIL')">
            return isc.ImgButton.create(
                {
                    width: 16,
                    height: 16,
                    grid: this,
                    showDown: false,
                    showRollOver: false,
                    layoutAlign: "center",
                    src: "pieces/16/icon_add.png",
                    prompt: '<spring:message code="global.add"/>',
                    disabled: contractTab.sectionStack.contract.hasContractDetailType(record.id),
                    click: function (isInLoop) {

                        if (!contractTab.dynamicForm.main.validate())
                            return;

                        if (!nicico.PersianDateUtil.compareDate(contractTab.dynamicForm.main.getValue("affectFrom").toShortDate(), contractTab.dynamicForm.main.getValue("affectUpTo").toShortDate())) {

                            contractTab.dynamicForm.main.errors["affectUpTo"] = '<spring:message code="contract.date.validation"/>';
                            contractTab.dynamicForm.main.redraw();
                            return;
                        }
                        if (contractTab.dynamicForm.main.getValue("buyerId") === contractTab.dynamicForm.main.getValue("sellerId")) {

                            contractTab.dynamicForm.main.errors["sellerId"] = '<spring:message code="contract.buyer-seller.validation"/>';
                            contractTab.dynamicForm.main.redraw();
                            return;
                        }
                        if (contractTab.dynamicForm.main.getValue("agentBuyerId") != null && contractTab.dynamicForm.main.getValue("agentBuyerId") === contractTab.dynamicForm.main.getValue("agentSellerId")) {

                            contractTab.dynamicForm.main.errors["agentSellerId"] = '<spring:message code="contract.agent-buyer-agent-seller.validation"/>';
                            contractTab.dynamicForm.main.redraw();
                            return;
                        }

                        if (contractTab.sectionStack.contract.hasContractDetailType(record.id)) {

                            this.disable();
                            contractTab.dialog.say('<spring:message code="contract.contract-detail-type.exists"/>');
                            return;
                        }
                        if (!contractTab.variable.contractDetails || (contractTab.variable.contractDetails && contractTab.variable.contractDetails.map(q => q.contractDetailTypeId).filter(p => p == record.id).length <= 0))
                            contractTab.method.addArticle({
                                isInLoop: isInLoop == null ? false : isInLoop,
                                isNewMode: true,
                                template: null,
                                contractDetail: null,
                                contractDetailType: record,
                                position: contractTab.listGrid.contractDetailType.getRecordIndex(record)
                            });
                        else {
                            let contractDetails = contractTab.variable.contractDetails.filter(p => p.contractDetailTypeId == record.id).first();
                            contractTab.method.addArticle({
                                isInLoop: isInLoop == null ? false : isInLoop,
                                isNewMode: false,
                                contractDetail: contractDetails,
                                position: contractDetails.position,
                                template: contractDetails.contractDetailTemplate,
                                contractDetailType: contractDetails.contractDetailType
                            });
                        }
                    }
                });
            // </sec:authorize>
        }

        return null;
    }
});
contractTab.sectionStack.contract = isc.SectionStack.create({
    margin: 5,
    width: "100%",
    animateSections: true,
    canReorderSections: true,
    showExpandControls: false,
    visibilityMode: "multiple",
    overflow: ["scroll", "clip-h"],
    sectionHeaderClass: "ContractSectionHeader",
    getContractDetails: function () {

        let result = [];
        for (let i = 0; i < this.sections.length; i++) {

            let section = this.sections[i];
            if (!this.setContractDetailData(section))
                return null;

            section.data.contractDetail.position = i;
            result.add(section.data.contractDetail);
        }

        return result;
    },
    setContractDetailData: function (section) {

        if (section.form) {

            if (!section.form.validate()) {

                contractTab.dialog.say('<spring:message code="contract.validation.exception-detail"/> [' + section.title + ']');
                return false;
            }

            let target = !section.data.isNewMode ?
                section.data.contractDetail.contractDetailValues :
                section.data.contractDetailType.contractDetailTypeParams;
            target.filter(param =>
                param.type !== contractTab.variable.dataType.ListOfReference &&
                param.type !== contractTab.variable.dataType.DynamicTable).forEach(param => {

                let field = section.form.getField(section.data.contractDetailType.code + "." + param.key);
                let detailValue = section.data.contractDetail.contractDetailValues.find(q => field.vId && q.id === field.vId);
                if (detailValue)
                    detailValue.value = section.form.getValue(field.name);
                else {

                    let exist = section.data.contractDetail.contractDetailValues.find(q => q.key === param.key);
                    if (exist)
                        section.data.contractDetail.contractDetailValues.remove(exist);

                    section.data.contractDetail.contractDetailValues.add({
                        key: param.key,
                        name: param.name,
                        type: param.type,
                        required: param.required,
                        reference: param.reference,
                        unitId: param.unitId,
                        contractDetailId: param.contractDetailId,
                        value: section.form.getValue(field.name),
                        dynamicTableValues: []
                    });
                }
            });
        }

        if (section.grids) {

            for (let i = 0; i < section.grids.length; i++) {

                let grid = section.grids[i];
                if (!grid.validateAllData()) {

                    contractTab.dialog.say('<spring:message code="contract.validation.exception-detail"/> [' + section.title + ']');
                    return false;
                }

                grid.saveAllEdits();
                let records = grid.getData();
                if (grid.required && !records.length) {

                    contractTab.dialog.say('<spring:message code="contract.validation.exception-detail"/>' +
                        ' [' + section.title + ']<br>' + '<spring:message code="validator.field.is.required"/>');

                    return false;
                }

                let exists = section.data.contractDetail.contractDetailValues.filter(q => q.key === grid.key && !q.id);
                if (exists && exists.length)
                    section.data.contractDetail.contractDetailValues.removeAll(exists);

                records.forEach(record => {

                    if (record.id) {

                        let detailValueId = grid.values.find(q => q.value == record.id).id;
                        let detailValue = section.data.contractDetail.contractDetailValues.find(q => q.id === detailValueId);
                        detailValue.referenceJsonValue = JSON.stringify(record);
                    } else
                        section.data.contractDetail.contractDetailValues.add({
                            key: grid.key,
                            name: grid.title,
                            type: grid.paramType,
                            required: grid.required,
                            reference: grid.reference,
                            unitId: grid.unitId,
                            contractDetailId: grid.contractDetailId,
                            value: null,
                            referenceJsonValue: JSON.stringify(record),
                            dynamicTableValues: []
                        });
                });

                let recordIds = records.map(record => record.id);
                grid.values.forEach(param => {

                    if (!recordIds.contains(param.value)) {

                        let detailValue = section.data.contractDetail.contractDetailValues.find(q => q.id === param.id);
                        section.data.contractDetail.contractDetailValues.remove(detailValue);
                    }
                });
            }
        }

        if (section.dynamicGrids) {

            for (let i = 0; i < section.dynamicGrids.length; i++) {

                let dynamicGrid = section.dynamicGrids[i];
                if (!dynamicGrid.validateAllData()) {

                    contractTab.dialog.say('<spring:message code="contract.validation.exception-detail"/> [' + section.title + ']');
                    return false;
                }

                dynamicGrid.saveAllEdits();
                let records = dynamicGrid.getData();
                if (dynamicGrid.required && !records.length) {

                    contractTab.dialog.say('<spring:message code="contract.validation.exception-detail"/>' +
                        ' [' + section.title + ']<br>' + '<spring:message code="validator.field.is.required"/>');

                    return false;
                }

                if (dynamicGrid.fields.map(q => q.name).distinct().length < dynamicGrid.fields.length) {

                    contractTab.dialog.say('<spring:message code="contract.validation.exception-detail"/>' +
                        ' [' + section.title + ']<br>' + '<spring:message code="validator.grid.duplicate.column.name"/>');

                    return false;
                }

                let rowIndex = 1;
                let maxRowNum = records.filter(q => q.rowNum).map(q => Number(q.rowNum)).max();
                if (!maxRowNum)
                    maxRowNum = 0;

                let exists = section.data.contractDetail.contractDetailValues.filter(q => q.key === dynamicGrid.key && !q.id);
                if (exists && exists.length)
                    section.data.contractDetail.contractDetailValues.removeAll(exists);

                records.forEach(record => {

                    if (record.rowNum) {

                        let detailValue = section.data.contractDetail.contractDetailValues.find(q => q.id === record.contractDetailValueId);
                        detailValue.dynamicTableValues.forEach(dynamicTableValue => dynamicTableValue.value = record[dynamicTableValue.fieldName]);
                    } else {

                        let rowNum = maxRowNum + rowIndex++;
                        let detailValue = {
                            key: dynamicGrid.key,
                            name: dynamicGrid.title,
                            type: dynamicGrid.paramType,
                            required: dynamicGrid.required,
                            reference: dynamicGrid.reference,
                            unitId: dynamicGrid.unitId,
                            contractDetailId: dynamicGrid.contractDetailId,
                            value: rowNum,
                            dynamicTableValues: []
                        };
                        dynamicGrid.fields.filter(field => field.colNum).forEach(field => detailValue.dynamicTableValues.add({

                            rowNum: rowNum,
                            fieldName: field.name,
                            value: record[field.name],

                            colNum: field.colNum,
                            maxRows: field.maxRows,
                            required: field.required,
                            headerKey: field.headerKey,
                            headerType: field.headerType,
                            headerTitle: field.headerTitle,
                            headerValue: field.headerValue,
                            valueType: field.valueType,
                            description: field.description,
                            displayField: field.displayField,
                            regexValidator: field.regexValidator,
                            initialCriteria: field.initialCriteria
                        }));
                        section.data.contractDetail.contractDetailValues.add(detailValue);
                    }
                });

                let rowNums = records.map(record => record.rowNum);
                dynamicGrid.values.forEach(param => {

                    if (!rowNums.contains(param.value)) {

                        let detailValue = section.data.contractDetail.contractDetailValues.find(q => q.id === param.id);
                        section.data.contractDetail.contractDetailValues.remove(detailValue);
                    }
                });
            }
        }

        return true;
    },
    getContractDetailTypes: function () {

        return this.sections.map(q => q.data.contractDetailType);
    },
    providePrintContent: function () {

        return this.sections.map(q => q.providePrintContent()).join("<br>");
    },
    hasContractDetailType: function (contractDetailTypeId) {

        return this.getSectionNames().includes(contractDetailTypeId);
    },
    sections: []
});
isc.defineClass("ContractSectionHeader", isc.SectionHeader).addProperties({

    padding: 10,
    hidden: false,
    expanded: true,
    baseStyle: null,
    backgroundColor: "#CCCCCC",
    layout: contractTab.sectionStack.contract,
});
contractTab.vLayout.sectionStack = isc.VLayout.create({

    width: "100%",
    height: "100%",
    overflow: "auto",
    members: [contractTab.sectionStack.contract]
});
contractTab.button.saveButton = isc.IButtonSave.create({

    click: function () {

        contractTab.dynamicForm.main.validate();
        if (contractTab.dynamicForm.main.hasErrors())
            return;

        if (!nicico.PersianDateUtil.compareDate(contractTab.dynamicForm.main.getValue("affectFrom").toShortDate(), contractTab.dynamicForm.main.getValue("affectUpTo").toShortDate())) {

            contractTab.dynamicForm.main.errors["affectUpTo"] = '<spring:message code="contract.date.validation"/>';
            contractTab.dynamicForm.main.redraw();
            return;
        }
        if (contractTab.dynamicForm.main.getValue("buyerId") === contractTab.dynamicForm.main.getValue("sellerId")) {

            contractTab.dynamicForm.main.errors["sellerId"] = '<spring:message code="contract.buyer-seller.validation"/>';
            contractTab.dynamicForm.main.redraw();
            return;
        }
        if (contractTab.dynamicForm.main.getValue("agentBuyerId") != null && contractTab.dynamicForm.main.getValue("agentBuyerId") === contractTab.dynamicForm.main.getValue("agentSellerId")) {

            contractTab.dynamicForm.main.errors["agentSellerId"] = '<spring:message code="contract.agent-buyer-agent-seller.validation"/>';
            contractTab.dynamicForm.main.redraw();
            return;
        }

        let data = contractTab.dynamicForm.main.getValues();
        data.content = contractTab.sectionStack.contract.providePrintContent();
        data.contractDetails = contractTab.sectionStack.contract.getContractDetails();
        if (!data.content) {

            contractTab.dialog.say('<spring:message code="contract.validation.empty-content"/>');
            return;
        }
        if (!data.contractDetails)
            return;
        if (!data.contractDetails.length) {

            contractTab.dialog.say('<spring:message code="contract.validation.empty-detail"/>');
            return;
        }
        if (data.contractTypeId === 2)
            contractTab.dialog.question(
                () => {
                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: contractTab.variable.contractUrl,
                        httpMethod: contractTab.variable.method,
                        data: JSON.stringify(data),
                        callback: function (resp) {

                            if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                                contractTab.dialog.ok();
                                contractTab.method.refresh(contractTab.listGrid.main);
                            } else
                                contractTab.dialog.error(resp);
                        }
                    }))
                }, "<spring:message code='contract.create.appendix.ask'/>");
        else
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: contractTab.variable.contractUrl,
                httpMethod: contractTab.variable.method,
                data: JSON.stringify(data),
                callback: function (resp) {

                    if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                        contractTab.dialog.ok();
                        contractTab.method.refresh(contractTab.listGrid.main);
                        // contractTab.window.main.close();
                    } else
                        contractTab.dialog.error(resp);
                }
            }));
    }
});
contractTab.hLayout.saveOrExitHlayout = isc.HLayout.create({
    height: "5%",
    width: "100%",
    showEdges: false,
    alignLayout: "center",
    padding: 10,
    layoutMargin: 5,
    membersMargin: 10,
    members: [
        contractTab.button.saveButton,
        isc.IButtonCancel.create({
            width: 100,
            click: function () {
                contractTab.window.main.close();
                contractTab.method.destroyArticles();
            }
        }),
        isc.ToolStrip.create({
            width: "100%",
            border: '0px',
            align: nicico.CommonUtil.getAlignByLang(),
            members: [
                isc.ToolStripButton.create({
                    icon: "[SKIN]/actions/add.png",
                    click: function () {

                        let contractDetailTypeData = contractTab.listGrid.contractDetailType.getOriginalData();
                        if (contractDetailTypeData && !(contractDetailTypeData instanceof Array))
                            contractDetailTypeData = contractDetailTypeData.localData;
                        if (contractDetailTypeData && contractDetailTypeData.length)
                            contractDetailTypeData.forEach((q, i) => {

                                let addButton = contractTab.listGrid.contractDetailType.getRecordComponent(i);
                                if (!addButton.disabled) addButton.click(true);
                            });
                    }
                }),
                isc.ToolStripButton.create({
                    icon: "[SKIN]/actions/remove.png",
                    click: function () {
                        contractTab.method.removeArticles();
                    }
                }),
                isc.ToolStripButton.create({
                    icon: "[SKIN]/actions/sort.png",
                    click: async function () {
                        await contractTab.method.sortArticles();
                    }
                })
            ]
        })
    ]
});
contractTab.hLayout.contractDetailHlayout = isc.HLayout.create({
    width: "100%",
    showEdges: false,
    padding: 10,
    layoutMargin: 5,
    membersMargin: 10,
    members: [
        contractTab.listGrid.contractDetailType,
        contractTab.vLayout.sectionStack
    ]
});

contractTab.variable.contractDetailTypeTemplateSelectorForm = new nicico.FormUtil();
contractTab.variable.contractDetailTypeTemplateSelectorForm.getButtonLayout = function () {
};
contractTab.variable.contractDetailTypeTemplateSelectorForm.init(null, "<spring:message code='contract.form.detail-type-template'/>", isc.VLayout.create({
    width: "100%",
    members: [

        isc.ListGrid.nicico.getDefault([
            {name: "id", primaryKey: true, hidden: true, title: '<spring:message code="global.id"/>'},
            {name: "content", title: '<spring:message code="global.content"/>', showHover: true, hoverWidth: '25%'}
        ], null, null, {
            height: "100%",
            wrapCells: true,
            showFilterEditor: false,
            fixedRecordHeights: true,
            bodyKeyPress: function () {

                if (arguments[0].keyName === "Enter") {

                    let record = contractTab.variable.contractDetailTypeTemplateSelectorForm.bodyWidget.getObject().getMember(0).getSelectedRecord();
                    if (record) {
                        contractTab.variable.contractDetailTypeTemplateSelectorForm.okCallBack(record.content);
                        contractTab.variable.contractDetailTypeTemplateSelectorForm.windowWidget.getObject().close();
                    }
                }
                this.Super("bodyKeyPress", arguments);
            },
            cellDoubleClick: function (record, rowNum, colNum) {

                contractTab.variable.contractDetailTypeTemplateSelectorForm.okCallBack(record.content);
                contractTab.variable.contractDetailTypeTemplateSelectorForm.windowWidget.getObject().close();
            }
        }),
        isc.IButtonCancel.create({

            click: function () {
                contractTab.variable.contractDetailTypeTemplateSelectorForm.windowWidget.getObject().close();
            }
        }),
    ]
}), "70%", 600);

contractTab.variable.contractDetailPreviewForm = new nicico.FormUtil();
contractTab.variable.contractDetailPreviewForm.getButtonLayout = function () {
};
contractTab.variable.contractDetailPreviewForm.cancelCallBack = function () {
    contractTab.variable.contractDetailPreviewForm.bodyWidget.getObject().setContents("");
};
contractTab.variable.contractDetailPreviewForm.init(null, "<spring:message code='contract.window.detail.preview'/>", isc.HTMLFlow.create({
    padding: 20,
    width: "100%",
    overflow: "auto"
}), "70%", "600");

contractTab.variable.contractPreviewForm = new nicico.FormUtil();
contractTab.variable.contractPreviewForm.getButtonLayout = function () {
};
contractTab.variable.contractPreviewForm.cancelCallBack = function () {
    contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).setContents("");
};
contractTab.variable.contractPreviewForm.init(null, "<spring:message code='contract.window.contract.preview'/>", [
    isc.HTMLFlow.create({
        overflow: "auto",
        width: "100%",
        height: "95%",
        padding: 20,
    }),
    isc.HLayout.create({
        height: "5%",
        width: "100%",
        showEdges: false,
        alignLayout: "center",
        padding: 10,
        layoutMargin: 5,
        membersMargin: 10,
        members: [
            isc.ToolStripButton.create({
                icon: "[SKIN]/actions/print.png",
                title: "<spring:message code='global.form.print.pdf'/>",
                click: () => window.open('${contextPath}/contract/print/pdf/' + contractTab.variable.contractPreviewForm.contractId)
            }),
            isc.ToolStripButton.create({
                icon: "pieces/512/word.png",
                title: "<spring:message code='global.form.print.contract.word'/>",
                click: function () {
                    let header = "<html xmlns:o='urn:schemas-microsoft-com:office:office' " +
                        "xmlns:w='urn:schemas-microsoft-com:office:word' " +
                        "xmlns='http://www.w3.org/TR/REC-html40'>" +
                        "<head><style>@page WordSection1{margin:1.7in 0.5in 1.7in 0.5in;}div.WordSection1{page:WordSection1;}</style>" +
                        "<meta charset='utf-8'><title>CONTRACT</title></head><body><div class='WordSection1'>";
                    let footer = "</div></body></html>";
                    let sourceHTML = header + contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).getContents() + footer;
                    let source = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(sourceHTML);
                    let fileDownload = document.createElement("a");
                    document.body.appendChild(fileDownload);
                    fileDownload.href = source;
                    fileDownload.download = 'contract.doc';
                    fileDownload.click();
                    document.body.removeChild(fileDownload);
                }
            })
        ]
    })
], "50%", 0.7 * innerHeight);

nicico.BasicFormUtil.getDefaultBasicForm(contractTab, "api/g-contract/", (creator) => {
    contractTab.window.main = isc.Window.nicico.getDefault(null, [
        contractTab.dynamicForm.main,
        contractTab.hLayout.contractDetailHlayout,
        contractTab.hLayout.saveOrExitHlayout
    ], "85%", 0.90 * innerHeight);
    contractTab.window.main.closeClick = function () {

        this.Super("closeClick", arguments);
        contractTab.method.destroyArticles();
    };
    //disapprove
    contractTab.toolStrip.main.members.find(q => q.actionType === nicico.ActionType.DISAPPROVE).click = function () {

        if (contractTab.listGrid.main && contractTab.listGrid.main.getSelectedRecord())
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: 'api/g-contract/spec-list',
                httpMethod: "GET",
                params: {
                    criteria: [
                        {
                            fieldName: "parentId",
                            operator: "equals",
                            value: contractTab.listGrid.main.getSelectedRecord().id
                        }
                    ]
                },
                callback: function (resp) {

                    if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {

                        let data = JSON.parse(resp.data);
                        if (data.response.data.length > 0)
                            contractTab.dialog.say("<spring:message code='contract.has.appendix.cant.disapprove'/>");
                        else
                            creator.method.disapprove(creator.listGrid.main);
                    }
                }
            }));
    };
    //refresh
    contractTab.toolStrip.main.members.last().members.first().click = function () {

        contractTab.listGrid.main.setCriteria(contractTab.variable.criteria);
        contractTab.listGrid.main.invalidateCache();
    }
});

if (contractTab.variable.contractType === "1") {

    // <sec:authorize access="hasAuthority('CO_CONTRACT_TEMPLATE')">
    contractTab.toolStrip.main.addMember(isc.ToolStripButton.create({
        icon: "pieces/512/draft.png",
        title: "<spring:message code='contract.copy.contract-template'/>",
        click: function () {

            contractTab.variable.contractTemplateForm = new nicico.FormUtil();
            contractTab.listGrid.contractTemplate = isc.ListGrid.nicico.getDefault([
                {name: "id", primaryKey: true, title: '<spring:message code="global.id"/>', width: "20%"},
                {
                    name: "no",
                    title: '<spring:message code="contact.no"/>',
                    showHover: true,
                    hoverWidth: '25%',
                    width: "20%"
                },
                {
                    name: "date",
                    title: '<spring:message code="global.date"/>',
                    showHover: true,
                    hoverWidth: '25%',
                    width: "20%"
                },
                {
                    name: "description",
                    title: '<spring:message code="global.description"/>',
                    showHover: true,
                    hoverWidth: '25%',
                    width: "40%"
                }
            ], contractTab.restDataSource.main, null, {
                height: "100%",
                wrapCells: true,
                showFilterEditor: false,
                fixedRecordHeights: true,
                autoFetchData: true,
                initialCriteria: {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [
                        {
                            fieldName: "contractTypeId",
                            operator: "equals",
                            value: 3
                        }
                    ]
                },
                cellDoubleClick: function (record, rowNum, colNum) {

                    contractTab.listGrid.contractDetailType.templateMode = true;
                    contractTab.method.editForm();
                    contractTab.variable.contractTemplateForm.windowWidget.getObject().close();
                }
            });
            contractTab.variable.contractTemplateForm.getButtonLayout = function () {

                return isc.IButtonCancel.create({
                    click: function () {

                        contractTab.variable.contractTemplateForm.windowWidget.getObject().close();
                    }
                });
            };
            contractTab.variable.contractTemplateForm.showForm(null, "<spring:message code='entity.contract-template'/>", contractTab.listGrid.contractTemplate, null, "300");
        }
    }), 7);
    // </sec:authorize>
    contractTab.toolStrip.main.addMember(isc.ToolStripButton.create({
        icon: "pieces/16/paperclip.png",
        title: "<spring:message code='contract.appendix'/>",
        click: function () {

            let record = contractTab.listGrid.main.getSelectedRecord();
            if (record == null || record.id == null)
                contractTab.dialog.notSelected();
            else if (record.estatus.contains(Enums.eStatus2.Final) && record.estatus.contains(Enums.eStatus2.Active)) {

                if (!record.parentId) {

                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: 'api/g-contract/spec-list',
                        httpMethod: "GET",
                        params: {
                            criteria: [
                                {
                                    fieldName: "parentId",
                                    operator: "equals",
                                    value: record.id
                                }
                            ]
                        },
                        callback: function (resp) {

                            if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {

                                let data = JSON.parse(resp.data);
                                let disapproves = data.response.data.filter(q => !q.estatus.contains(Enums.eStatus2.Final));
                                if (disapproves.length > 0)
                                    contractTab.dialog.say('<spring:message code="contract.has.disapprove.appendix"/>\n' + disapproves.map(q => q.no));
                                else {

                                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                        actionURL: 'api/g-contract/' + record.id,
                                        httpMethod: "GET",
                                        callback: function (response) {

                                            if (response.httpResponseCode === 201 || response.httpResponseCode === 200)
                                                contractTab.variable.contractDetails = JSON.parse(response.data).contractDetails;
                                        }
                                    }));
                                    contractTab.listGrid.contractDetailType.appendixMode = true;
                                    contractTab.method.editForm();
                                }
                            }
                        }
                    }));
                } else
                    contractTab.dialog.say('<spring:message code="contract.is.appendix"/>');
            } else
                contractTab.dialog.say('<spring:message code="global.grid.record.can.not.disapprove"/>');
        }
    }), 8);
    contractTab.toolStrip.main.addMember(isc.ToolStripButton.create({
        icon: "[SKIN]/actions/filter.png",
        title: "<spring:message code='contract.addendum.title'/>",
        click: function () {

            let contract = contractTab.listGrid.main.getSelectedRecord();
            if (!contract) return contractTab.dialog.notSelected();
            let crt = contract.parentId ? contract.parentId : contract.id;

            let criteria = {
                operator: 'and',
                _constructor: "AdvancedCriteria",
                criteria: [
                    {
                        fieldName: 'contractTypeId',
                        operator: 'notEqual',
                        value: 3
                    },
                    {
                        operator: 'or',
                        _constructor: "AdvancedCriteria",
                        criteria: [
                            {
                                fieldName: 'id',
                                operator: 'equals',
                                value: crt
                            },
                            {
                                fieldName: 'parentId',
                                operator: 'equals',
                                value: crt
                            },
                        ]
                    }
                ]
            };
            contractTab.listGrid.main.setCriteria(criteria);
            contractTab.listGrid.main.invalidateCache();
        }
    }), 9);
    // <sec:authorize access="hasAuthority('P_CONTRACT')">
    contractTab.toolStrip.main.addMember(isc.ToolStripButton.create({
        icon: "[SKIN]/actions/print.png",
        title: "<spring:message code='global.form.print'/>",
        click: () => contractTab.method.showPrintPreview()
    }), 10);
    // </sec:authorize>
} else {

    // <sec:authorize access="hasAuthority('P_CONTRACT')">
    contractTab.toolStrip.main.addMember(isc.ToolStripButton.create({
        icon: "[SKIN]/actions/print.png",
        title: "<spring:message code='global.form.print'/>",
        click: () => contractTab.method.showPrintPreview()
    }), 7);
    // </sec:authorize>
}

contractTab.menu.main.data.add({
    icon: "[SKIN]/actions/print.png",
    title: '<spring:message code="global.form.print"/>',
    click: () => contractTab.method.showPrintPreview()
});
contractTab.menu.main.initWidget();

nicico.BasicFormUtil.showAllToolStripActions(contractTab);
if (contractTab.variable.contractType === "1")
    nicico.BasicFormUtil.removeExtraActions(contractTab, [nicico.ActionType.ACTIVATE, nicico.ActionType.DEACTIVATE]);
else {
    let actionTypeList = [];

    // <sec:authorize access="!hasAuthority('C_CONTRACT_TEMPLATE')">
    actionTypeList.add(nicico.ActionType.NEW);
    // </sec:authorize>
    // <sec:authorize access="!hasAuthority('U_CONTRACT_TEMPLATE')">
    actionTypeList.add(nicico.ActionType.EDIT);
    // </sec:authorize>
    // <sec:authorize access="!hasAuthority('D_CONTRACT_TEMPLATE')">
    actionTypeList.add(nicico.ActionType.DELETE);
    // </sec:authorize>
    actionTypeList.addList([nicico.ActionType.ACTIVATE, nicico.ActionType.DEACTIVATE, nicico.ActionType.FINALIZE, nicico.ActionType.DISAPPROVE]);
    nicico.BasicFormUtil.removeExtraActions(contractTab, actionTypeList);
}

//*************************************************** Functions ********************************************************

contractTab.method.newForm = function () {

    contractTab.variable.method = "POST";
    contractTab.listGrid.contractDetailType.show();
    contractTab.dynamicForm.main.clearValues();
    contractTab.method.removeArticles();
    contractTab.listGrid.contractDetailType.setCriteria({
        operator: 'and',
        criteria: [{
            fieldName: 'materialId',
            operator: 'equals',
            value: null
        }]
    });
    let affectUpTo = new Date();
    affectUpTo.setFullYear(affectUpTo.getFullYear() + 1);
    contractTab.dynamicForm.main.setValue("affectUpTo", affectUpTo);
    contractTab.window.main.setTitle("<spring:message code='contract.window.title.new'/>");

    contractTab.dynamicForm.main.getField("materialId").setDisabled(false);
    contractTab.dynamicForm.main.getField("buyerId").setDisabled(false);
    contractTab.dynamicForm.main.getField("sellerId").setDisabled(false);

    contractTab.variable.contractDetails = null;
    contractTab.button.saveButton.show();
    contractTab.window.main.show();
};
contractTab.method.editForm = function () {

    let listGridRecord = null;
    if (!contractTab.listGrid.contractDetailType.templateMode)
        listGridRecord = clone(contractTab.listGrid.main.getSelectedRecord());
    else
        listGridRecord = clone(contractTab.listGrid.contractTemplate.getSelectedRecord());

    if (listGridRecord == null || listGridRecord.id == null)
        contractTab.dialog.notSelected();
    else if (listGridRecord.editable === false)
        contractTab.dialog.notEditable();
    else if (listGridRecord.estatus.contains(Enums.eStatus2.DeActive))
        contractTab.dialog.inactiveRecord();
    else {

        if (listGridRecord.estatus.contains(Enums.eStatus2.Final) || listGridRecord.parentId)
            contractTab.button.saveButton.hide();
        else
            contractTab.button.saveButton.show();

        contractTab.variable.contractDetails = null;

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: 'api/g-contract/' + listGridRecord.id,
            httpMethod: "GET",
            callback: function (resp) {

                if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {

                    let record = JSON.parse(resp.data);
                    contractTab.variable.method = "PUT";
                    if (contractTab.variable.contractType === "1") {

                        if (contractTab.listGrid.contractDetailType.templateMode) {

                            contractTab.variable.method = "POST";
                            listGridRecord.contractTypeId = 1;
                            contractTab.listGrid.contractDetailType.hide();
                            contractTab.listGrid.contractDetailType.setShowResizeBar(false);
                            contractTab.listGrid.contractDetailType.templateMode = null;

                            contractTab.dynamicForm.main.getField("materialId").setDisabled(false);
                            contractTab.dynamicForm.main.getField("buyerId").setDisabled(false);
                            contractTab.dynamicForm.main.getField("sellerId").setDisabled(false);

                        } else if (contractTab.listGrid.contractDetailType.appendixMode) {

                            contractTab.variable.method = "POST";
                            listGridRecord.contractTypeId = 2;
                            listGridRecord.parentId = listGridRecord.id;
                            contractTab.listGrid.contractDetailType.show();
                            contractTab.listGrid.contractDetailType.setShowResizeBar(true);
                            contractTab.button.saveButton.show();

                            contractTab.dynamicForm.main.getField("materialId").setDisabled(true);
                            contractTab.dynamicForm.main.getField("buyerId").setDisabled(true);
                            contractTab.dynamicForm.main.getField("sellerId").setDisabled(true);

                        } else {

                            contractTab.listGrid.contractDetailType.show();
                            contractTab.listGrid.contractDetailType.setShowResizeBar(true);

                            contractTab.dynamicForm.main.getField("materialId").setDisabled(false);
                            contractTab.dynamicForm.main.getField("buyerId").setDisabled(false);
                            contractTab.dynamicForm.main.getField("sellerId").setDisabled(false);
                        }

                    }

                    contractTab.dynamicForm.main.editRecord(listGridRecord);
                    contractTab.dynamicForm.main.setValue("date", new Date(listGridRecord.date));
                    contractTab.dynamicForm.main.setValue("affectFrom", new Date(listGridRecord.affectFrom));
                    contractTab.dynamicForm.main.setValue("affectUpTo", new Date(listGridRecord.affectUpTo));

                    contractTab.method.removeArticles();

                    contractTab.listGrid.contractDetailType.invalidateRecordComponents();
                    contractTab.listGrid.contractDetailType.setCriteria(null);
                    contractTab.listGrid.contractDetailType.fetchData({
                        operator: 'and',
                        criteria: [{
                            fieldName: 'materialId',
                            operator: 'equals',
                            value: contractTab.dynamicForm.main.getValue('materialId')
                        }, {
                            fieldName: 'estatus',
                            operator: 'notEqual',
                            value: Enums.eStatus2.DeActive
                        }]
                    }, () => {

                        if (!contractTab.listGrid.contractDetailType.appendixMode)
                            record.contractDetails.sortByProperty('position').reverse().forEach(contractDetail => contractTab.method.addArticle({
                                isInLoop: true,
                                isNewMode: false,
                                contractDetail: contractDetail,
                                position: contractDetail.position,
                                template: contractDetail.contractDetailTemplate,
                                contractDetailType: contractDetail.contractDetailType
                            }));

                        contractTab.listGrid.contractDetailType.appendixMode = null;
                    });

                    contractTab.window.main.setTitle("<spring:message code='contract.window.title.edit'/>" + "\t" + listGridRecord.material.descEN);
                    contractTab.window.main.show();
                } else
                    contractTab.dialog.error(resp);
            }
        }));
    }
};

contractTab.method.showPrintPreview = function () {

    let record = contractTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        contractTab.dialog.notSelected();
    else
        contractTab.method.jsonRPCManagerRequest({
            httpMethod: "GET",
            actionURL: contractTab.variable.contractUrl + "content/" + record.id,
        }, (resp) => {

            let content = resp.data;
            contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).setContents(!content ? "" : content);
            contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).redraw();
            contractTab.variable.contractPreviewForm.contractId = record.id;
            contractTab.variable.contractPreviewForm.justShowForm();
        });
};
contractTab.method.destroyArticles = function () {

    contractTab.sectionStack.contract.sections.forEach(section => {

        section.form?.destroy();
        section.grids?.forEach(grid => grid.destroy());
        section.dynamicGrids?.forEach(dynamicGrid => dynamicGrid.destroy());
    });
};
contractTab.method.removeArticles = function (articleNames) {

    let sectionNames = articleNames && articleNames instanceof Array && articleNames.length ?
        articleNames : contractTab.sectionStack.contract.getSectionNames();

    let contractDetailTypeData = contractTab.listGrid.contractDetailType.getOriginalData();
    if (contractDetailTypeData && !(contractDetailTypeData instanceof Array))
        contractDetailTypeData = contractDetailTypeData.localData;

    sectionNames.forEach(sectionName => {

        contractTab.sectionStack.contract.removeSection(sectionName + "")

        if (contractDetailTypeData && contractDetailTypeData.length) {

            let detailTypeRecord = contractDetailTypeData.filter(q => q.id == sectionName).first();
            contractTab.listGrid.contractDetailType.getRecordComponent(contractTab.listGrid.contractDetailType.getRecordIndex(detailTypeRecord)).enable();
        }
    });
};
contractTab.method.setDisplayData = function (grid, isDynamicGrid) {

    let data = clone(grid.getData());
    for (let i = 0; i < grid.fields.length; i++)
        if ((!isDynamicGrid && grid.fields[i].templateFieldName) || (isDynamicGrid && grid.fields[i].displayField))
            for (let j = 0; j < data.length; j++)
                data[j][grid.fields[i].name] = {
                    value: data[j][grid.fields[i].name],
                    display: grid.getDisplayValue(grid.fields[i], data[j][grid.fields[i].name], data[j])
                };

    return data;
};
contractTab.method.disableDetailAddButton = function (sectionStackSectionObj) {

    let contractDetailTypeData = contractTab.listGrid.contractDetailType.getOriginalData();
    if (contractDetailTypeData && !(contractDetailTypeData instanceof Array))
        contractDetailTypeData = contractDetailTypeData.localData;
    if (contractDetailTypeData && contractDetailTypeData.length) {

        let detailTypeRecord = contractDetailTypeData.filter(q => q.id === sectionStackSectionObj.data.contractDetailType.id).first();
        let recordIndex = contractTab.listGrid.contractDetailType.getRecordIndex(detailTypeRecord);
        if (recordIndex >= 0) {

            let addButton = contractTab.listGrid.contractDetailType.getRecordComponent(recordIndex);
            if (addButton)
                addButton.disable();
        }
    }
};
contractTab.method.sortArticles = async function () {

    await Promise.all(contractTab.sectionStack.contract.sections.sortByProperty('position').reverse().map((section, i) => {

        try {
            contractTab.sectionStack.contract.reorderSection(section, i);
        } catch {
            console.log('reorder section failure: ', i, section);
        }
    }));
};
contractTab.method.addArticle = async function (data) {

    if (!data.contractDetail)
        data.contractDetail = {
            id: null,
            content: null,
            contractDetailValues: [],
            contractDetailTemplate: data.template,
            contractDetailTypeId: data.contractDetailType.id,
            position: contractTab.sectionStack.contract.sections.length
        };
    if (data.template == null) {

        if ((data.isInLoop && data.contractDetailType.contractDetailTypeTemplates.length) || data.contractDetailType.contractDetailTypeTemplates.length === 1) {

            data.template = data.contractDetailType.contractDetailTypeTemplates[0].content;
            data.contractDetail.contractDetailTemplate = data.template;
            await contractTab.method.createArticle(data);
        } else if (data.contractDetailType.contractDetailTypeTemplates.length) {

            contractTab.variable.contractDetailTypeTemplateSelectorForm.okCallBack = async function (templateContent) {

                data.template = templateContent;
                data.contractDetail.contractDetailTemplate = data.template;
                await contractTab.method.createArticle(data);
            };
            contractTab.variable.contractDetailTypeTemplateSelectorForm.bodyWidget.getObject().getMember(0).setData(data.contractDetailType.contractDetailTypeTemplates);
            contractTab.variable.contractDetailTypeTemplateSelectorForm.justShowForm();
        } else if (!data.isInLoop)
            contractTab.dialog.say('<spring:message code="incoterm.exception.required-info"/>');
    } else if (!data.isNewMode)
        await contractTab.method.createArticle(data);
    else
        contractTab.dialog.say('<spring:message code="incoterm.exception.required-info"/>');
};
contractTab.method.createArticle = async function (data) {

    let sectionStackSectionObj = {
        form: null,
        grids: [],
        dynamicGrids: [],
        data: data,
        expanded: true,
        canCollapse: false,
        destroyOnRemove: true,
        position: data.position,
        name: data.contractDetailType.id,
        title: data.contractDetailType.titleEN,
        controls: [
            // <sec:authorize access="hasAuthority('R_CONTRACT_DETAIL')">
            isc.ImgButton.create({
                width: 16,
                height: 16,
                header: this,
                showDown: false,
                showRollOver: false,
                layoutAlign: "center",
                src: "[SKIN]/actions/view.png",
                click: function () {

                    contractTab.variable.contractDetailPreviewForm.bodyWidget.getObject().setContents(
                        "<div style='text-align: " + nicico.CommonUtil.getAlignByLangReverse() + "'>" +
                        sectionStackSectionObj.providePrintContent() + "</div>");
                    contractTab.variable.contractDetailPreviewForm.justShowForm();
                }
            }),
            // </sec:authorize>
            // <sec:authorize access="hasAuthority('D_CONTRACT_DETAIL')">
            isc.ImgButton.create({
                width: 16,
                height: 16,
                header: this,
                showDown: false,
                showRollOver: false,
                layoutAlign: "center",
                src: "[SKIN]/actions/remove.png",
                click: function () {

                    contractTab.method.removeArticles([data.contractDetailType.id + ""]);
                }
            })
            // </sec:authorize>
        ],
        items: [],
        provideGlobalPrintContent: function (template) {

            let values = contractTab.dynamicForm.valuesManager.getValues();
            for (let i = 0; i < Object.keys(values).filter(key => !contractTab.dynamicForm.main.getField(key)).length; i++) {

                if (template == null)
                    break;

                let field = Object.keys(values).filter(key => !contractTab.dynamicForm.main.getField(key))[i];
                template = template.replace(
                    new RegExp("\\\${" + field + "_IN_CHARACTER}", "g"),
                    () => numberToEnglish(values[field])
                );
                template = template.replace(
                    new RegExp("\\\${" + field + "}", "g"),
                    values[field]
                );
            }

            return template == null ? '' : template;
        },
        provideFormPrintContent: function (template) {

            if (this.form)
                for (let i = 0; i < this.form.fields.filter(field => !field.isBaseItem).length; i++) {

                    if (template == null)
                        break;

                    let field = this.form.fields.filter(f => !f.isBaseItem)[i];

                    if (field.unitId)
                        template = template.replace(
                            new RegExp("\\\${_" + field.unitId + "}", "g"),
                            () => this.form.getField(field.name).getHint()
                        );

                    template = template.replace(
                        new RegExp("\\\${" + field.key + "_IN_CHARACTER}", "g"),
                        () => numberToEnglish(this.form.getValue(field.name))
                    );

                    if (field.paramType === contractTab.variable.dataType.Reference)
                        template = template.replace(
                            new RegExp("\\\${" + field.key + "}", "g"),
                            () => this.form.getField(field.name).getDisplayValue()
                        );

                    template = template.replace(
                        new RegExp("\\\${" + field.key + "}", "g"),
                        () => this.form.getValue(field.name)
                    );
                }

            return template == null ? '' : template;
        },
        provideGridsPrintContent: function (template) {

            if (this.grids.length)
                for (let i = 0; i < this.grids.length; i++) {

                    if (template == null)
                        break;

                    let grid = this.grids[i];

                    grid.saveAllEdits();

                    var table = "";
                    var tableRows = "";
                    var tableHeader = "";
                    var tableEndTag = "</table>";
                    var tableStartTag = "<table style='color: #000000; border-spacing: 0; border: 1px solid #000000; text-align: " + nicico.CommonUtil.getAlignByLangReverse() + "'>";
                    let data = grid.getData();

                    var correspondingNameTitle = {};
                    grid.getFields().filter(field => !field.isBaseItem && !field.hidden && !field.isRemoveField && field.rowNumberStart === undefined).forEach(field => correspondingNameTitle[field.name] = field.title);

                    tableHeader += "<tr>";
                    Object.values(correspondingNameTitle).forEach(header => tableHeader +=
                        "<th style='padding: 10px; border: 1px solid #000000;'>" +
                        header +
                        "</th>");
                    tableHeader += "</tr>";

                    data.forEach(record => {

                        tableRows += "<tr>";
                        Object.keys(correspondingNameTitle).forEach(name => {

                            let displayField = grid.getField(name).templateFieldName;
                            tableRows +=
                                "<td style='padding: 10px; border: 1px solid #000000;'>" +
                                (displayField ? displayField.split('.').evalPropertyPath(record) : record[name]) +
                                "</td>";
                        });
                        tableRows += "</tr>";
                    });

                    table += tableStartTag + tableHeader + tableRows + tableEndTag;

                    template = template.replace(
                        new RegExp("\\\${" + grid.key + "}", "g"),
                        table
                    );
                }

            return template == null ? '' : template;
        },
        provideDynamicGridsPrintContent: function (template) {

            if (this.dynamicGrids.length)
                for (let i = 0; i < this.dynamicGrids.length; i++) {

                    if (template == null)
                        break;

                    let dynamicGrid = this.dynamicGrids[i];

                    dynamicGrid.saveAllEdits();

                    var table = "";
                    var tableRows = "";
                    var tableHeader = "";
                    var tableEndTag = "</table>";
                    var tableStartTag = "<table style='color: #000000; border-spacing: 0; border: 1px solid #000000; text-align: " + nicico.CommonUtil.getAlignByLangReverse() + "'>";
                    let data = dynamicGrid.getData();

                    var correspondingNameTitle = {};
                    dynamicGrid.getFields().filter(field => !field.isBaseItem && !field.hidden && !field.isRemoveField && field.rowNumberStart === undefined).forEach(field => correspondingNameTitle[field.name] = field.title);

                    tableHeader += "<tr>";
                    Object.values(correspondingNameTitle).forEach(header => tableHeader +=
                        "<th  style='padding: 10px; border: 1px solid #000000;'>" +
                        header +
                        "</th>");
                    tableHeader += "</tr>";

                    data.forEach(record => {

                        tableRows += "<tr>";
                        Object.keys(correspondingNameTitle).forEach(name => {

                            let displayField = dynamicGrid.getField(name).displayField;
                            tableRows +=
                                "<td  style='padding: 10px; border: 1px solid #000000;'>" +
                                (displayField ? displayField.split('.').evalPropertyPath(record) : record[name]) +
                                "</td>";
                        });
                        tableRows += "</tr>";
                    });

                    table += tableStartTag + tableHeader + tableRows + tableEndTag;


                    template = template.replace(
                        new RegExp("\\\${" + dynamicGrid.key + "}", "g"),
                        table
                    );
                }

            return template == null ? '' : template;
        },
        provideScriptsPrintContent: function (template) {

            function evaluate(script) {

                var context = contractTab.dynamicForm.valuesManager.getValues();
                let keys = Object.keys(context).filter(q => !/^-?\d+$/.test(q.replace("_", "")));
                let declarations = keys.map(key => ' var ' + key + " = " + (typeof context[key] === 'object' ? 'clone(context["' + key + '"])' : 'context["' + key + '"]') + " ; ").join("");

                return eval("function _EVALUATE_TEMPLATE_SCRIPT(){" + declarations + script + "} _EVALUATE_TEMPLATE_SCRIPT();");
            }

            try {

                return [template.replace(/\\$={(.+?)}/g,
                    function (capture, group1) {

                        let element = document.createElement('div');
                        element.innerHTML = group1;
                        let result = evaluate(element.innerText);

                        return result == null ? '' : result;
                    }), null];
            } catch (e) {

                console.log(e.message);
                return [null, e];
            }
        },
        providePrintContent: function () {

            let error;
            let template = this.data.template;

            let materialIdField = contractTab.dynamicForm.main.getField("materialId");
            contractTab.dynamicForm.valuesManager.setValue("material", materialIdField.getSelectedRecord());

            let contractTypeIdField = contractTab.dynamicForm.main.getField("contractTypeId");
            contractTab.dynamicForm.valuesManager.setValue("contractType", contractTypeIdField.getSelectedRecord());

            let buyerIdField = contractTab.dynamicForm.main.getField("buyerId");
            let buyerIdValue = contractTab.dynamicForm.main.getValue("buyerId");
            buyerIdField.changed(contractTab.dynamicForm.main, buyerIdField, buyerIdValue);

            let sellerIdField = contractTab.dynamicForm.main.getField("sellerId");
            let sellerIdValue = contractTab.dynamicForm.main.getValue("sellerId");
            sellerIdField.changed(contractTab.dynamicForm.main, sellerIdField, sellerIdValue);

            let agentBuyerIdField = contractTab.dynamicForm.main.getField("agentBuyerId");
            let agentBuyerIdValue = contractTab.dynamicForm.main.getValue("agentBuyerId");
            agentBuyerIdField.changed(contractTab.dynamicForm.main, agentBuyerIdField, agentBuyerIdValue);

            let agentSellerIdField = contractTab.dynamicForm.main.getField("agentSellerId");
            let agentSellerIdValue = contractTab.dynamicForm.main.getValue("agentSellerId");
            agentSellerIdField.changed(contractTab.dynamicForm.main, agentSellerIdField, agentSellerIdValue);

            contractTab.variable.units.forEach(unit => contractTab.dynamicForm.valuesManager.setValue("_" + unit.id, unit.symbolUnit));

            this.grids.forEach(grid => contractTab.dynamicForm.valuesManager.setValue(grid.name, contractTab.method.setDisplayData(grid, false)));
            this.dynamicGrids.forEach(dynamicGrid => contractTab.dynamicForm.valuesManager.setValue(dynamicGrid.name, contractTab.method.setDisplayData(dynamicGrid, true)));

            template = this.provideGlobalPrintContent(template);
            template = this.provideFormPrintContent(template);
            template = this.provideGridsPrintContent(template);
            template = this.provideDynamicGridsPrintContent(template);
            [template, error] = this.provideScriptsPrintContent(template);

            if (error == null) {

                if (this.title !== ReferenceEnums.Enum_EContractDetailTypeCode.Header && this.title !== ReferenceEnums.Enum_EContractDetailTypeCode.Footer)
                    template = "<p style='text-decoration: underline; text-align: left; font-size: 15px; font-family: 'Times New Roman''><b>" + data.contractDetailType.titleEN + "</b></p>" + template;
                this.data.contractDetail.content = template;
                return template;
            } else
                return "<p style='color: red; font-weight: bold; direction: ltr; text-align: left'>There is some problem : </p>" +
                    "<p style='color: red; font-size: 14px; direction: ltr; text-align: left'>" + error.message + "</p>";
        }
    };

    await contractTab.method.createArticleBody(sectionStackSectionObj);
};
contractTab.method.createArticleBody = async function (sectionStackSectionObj) {

    let form = await contractTab.method.createArticleForm(sectionStackSectionObj.data.contractDetailType, sectionStackSectionObj.data.contractDetail, sectionStackSectionObj.data.isNewMode);
    if (form) {

        sectionStackSectionObj.form = form;
        sectionStackSectionObj.items.push(form);
    }

    let grids = await contractTab.method.createArticleBodyGrid(sectionStackSectionObj.data.contractDetailType, sectionStackSectionObj.data.contractDetail, sectionStackSectionObj.data.isNewMode);
    if (grids.length) {

        sectionStackSectionObj.grids = grids;
        sectionStackSectionObj.items.addAll(grids);
    }

    let dynamicGrids = await contractTab.method.createArticleBodyDynamicGrid(sectionStackSectionObj.data.contractDetailType, sectionStackSectionObj.data.contractDetail, sectionStackSectionObj.data.isNewMode);
    if (dynamicGrids.length) {

        sectionStackSectionObj.dynamicGrids = dynamicGrids;
        sectionStackSectionObj.items.addAll(dynamicGrids);
    }

    let position = sectionStackSectionObj.position > contractTab.sectionStack.contract.sections.length ?
        contractTab.sectionStack.contract.sections.length : sectionStackSectionObj.position;
    contractTab.sectionStack.contract.addSection(sectionStackSectionObj, position);
    contractTab.method.disableDetailAddButton(sectionStackSectionObj);
    await contractTab.method.sortArticles();
};
contractTab.method.createArticleForm = async function (contractDetailType, contractDetail, isNewMode) {

    let target;
    let valueKey;
    let fields = [];
    if (!isNewMode) {

        valueKey = "value";
        target = contractDetail.contractDetailValues;
    } else {

        valueKey = "defaultValue";
        target = contractDetailType.contractDetailTypeParams;
    }

    function getValueFromString(type, valueStr) {

        if (valueStr === "false")
            return false;
        if (valueStr === "true")
            return true;
        if (type === 'GeorgianDate')
            return new Date(valueStr);

        return valueStr;
    }

    await Promise.all(target.filter(param =>
        param.type !== contractTab.variable.dataType.ListOfReference &&
        param.type !== contractTab.variable.dataType.DynamicTable).map(param => {

        let field = {

            width: "100%",
            key: param.key,
            title: param.name,
            unitId: param.unitId,
            paramType: param.type,
            required: param.required,
            reference: param.reference,
            name: contractDetailType.code + "." + param.key,
            defaultValue: getValueFromString(param.type, param[valueKey]),
            vId: !isNewMode ? param.id : null,
            version: !isNewMode ? param.version : null,
            estatus: !isNewMode ? param.estatus : null,
            editable: !isNewMode ? param.editable : null,
            contractDetailId: !isNewMode ? param.contractDetailId : null,
            canEdit: contractTab.dynamicForm.main.getField(param.key) == null,
            colSpan: param.type === contractTab.variable.dataType.TextArea ? 5 : 2,
            titleColSpan: 1,
        };

        if (field.required)
            Object.assign(field, {
                validators: [{
                    type: "required",
                    validateOnChange: true
                }]
            });
        Object.assign(field, getFieldProperties(field.paramType, field.reference));
        if (field.type === contractTab.variable.dataType.TextArea) {

            field.width = "100%";
            field.height = "300";
        }

        fields.push(field);
    }));

    let dynamicForm = isc.DynamicForm.create({

        autoDraw: false,
        numCols: 8,
        width: "100%",
        align: "center",
        canSubmit: true,
        showErrorText: true,
        showErrorStyle: true,
        wrapItemTitles: false,
        showInlineErrors: true,
        errorOrientation: "bottom",
        valuesManager: contractTab.dynamicForm.valuesManager,
        fields: BaseFormItems.concat(fields, true),
        requiredMessage: '<spring:message code="validator.field.is.required"/>'
    });

    dynamicForm.getItems().forEach(item => {

        if (item.unitId) {

            let unit = contractTab.variable.units.find(q => q.id === item.unitId);
            if (unit)
                item.setHint(unit.symbolUnit);
        }
    });

    dynamicForm.clearValues();
    return fields.length ? dynamicForm : null;
};
contractTab.method.createArticleBodyGrid = async function (contractDetailType, contractDetail, isNewMode) {

    let target;
    let grids = [];
    if (!isNewMode) {

        let contractDetailValueGroup = contractDetail.contractDetailValues.filter(param => param.type === contractTab.variable.dataType.ListOfReference).groupBy('reference');
        target = Object.keys(contractDetailValueGroup).map(reference => {

            let values = contractDetailValueGroup[reference];
            let firstValue = values.first();
            return {
                values: values,
                key: firstValue.key,
                type: firstValue.type,
                name: firstValue.name,
                unitId: firstValue.unitId,
                required: firstValue.required,
                reference: firstValue.reference,
                contractDetailId: firstValue.contractDetailId
            }
        });
    } else
        target = contractDetailType.contractDetailTypeParams.filter(param => param.type === contractTab.variable.dataType.ListOfReference);

    await Promise.all(target.map(param => {

        let fields = getReferenceFields(param.reference);
        // let listGridFirstField = {name: null};
        // if (fields && fields.length)
        //     listGridFirstField = fields[0];

        let grid = isc.ListGrid.create({

            autoDraw: false,
            width: "100%",
            height: "300",
            sortField: 1,
            selectionType: "single",
            sortDirection: "ascending",
            canHover: true,
            showHover: true,
            // autoFitData: "vertical",
            // autoFitDateFields: "both",
            // autoFitMaxWidth: "15%",
            // autoFitWidthApproach: "both",
            // autoFitFieldsFillViewport: true,
            // autoFitExpandField: listGridFirstField.name,
            showRowNumbers: true,
            canAutoFitFields: false,
            allowAdvancedCriteria: true,
            alternateRecordStyles: true,
            canEdit: true,
            editEvent: "doubleClick",
            autoSaveEdits: false,
            virtualScrolling: false,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            recordComponentPoolingMode: "recycle",
            listEndEditAction: "next",
            canRemoveRecords: true,
            fields: fields,
            key: param.key,
            title: param.name,
            unitId: param.unitId,
            paramType: param.type,
            required: param.required,
            reference: param.reference,
            values: !isNewMode ? param.values : [],
            contractDetailId: !isNewMode ? param.contractDetailId : null,
            name: contractDetailType.code + "." + param.key,
            dataChanged: function (operationType) {

                contractTab.dynamicForm.valuesManager.setValue(this.name, contractTab.method.setDisplayData(this, false));
                this.Super("dataChanged", arguments);
            },
            gridComponents: ["header", "body",
                isc.ToolStrip.create({
                    width: "100%",
                    height: 24,
                    members: [
                        isc.ToolStripButton.create({
                            icon: "pieces/16/icon_add.png",
                            title: "<spring:message code='global.add'/>",
                            click: function () {
                                grid.startEditingNew();
                            }
                        }),
                        isc.ToolStrip.create({
                            width: "100%",
                            height: 24,
                            align: nicico.CommonUtil.getAlignByLang(),
                            border: 0,
                            members: [
                                isc.ToolStripButton.create({
                                    icon: "pieces/16/save.png",
                                    title: "<spring:message code='global.form.save.temporary'/>",
                                    click: function () {

                                        if (!grid.validateAllData()) return;
                                        grid.saveAllEdits();
                                    }
                                })]
                        })
                    ]
                })]
        });

        if (!isNewMode)
            getReferenceDataSource(grid.reference).fetchData({
                operator: "and",
                _constructor: "AdvancedCriteria",
                criteria: [{fieldName: "id", operator: "equals", value: grid.values.map(p => p.value)}]
            }, (dsResponse, data) => grid.setData(data));

        grids.push(grid);
    }));

    return grids;
};
contractTab.method.createArticleBodyDynamicGrid = async function (contractDetailType, contractDetail, isNewMode) {

    let target;
    let valueKey;
    let dynamicGrids = [];
    if (!isNewMode) {

        valueKey = "value";

        // value field contains rowNumber
        // reference field contains contractDetailTypeParamId
        let contractDetailValueGroup = contractDetail.contractDetailValues.filter(param => param.type === contractTab.variable.dataType.DynamicTable).groupBy('reference');
        target = Object.keys(contractDetailValueGroup).map(reference => {

            let values = contractDetailValueGroup[reference];
            let firstValue = values.first();
            return {
                values: values,
                key: firstValue.key,
                type: firstValue.type,
                name: firstValue.name,
                unitId: firstValue.unitId,
                required: firstValue.required,
                reference: firstValue.reference,
                contractDetailId: firstValue.contractDetailId,
                dynamicTables: firstValue.dynamicTableValues
            }
        });
    } else {

        valueKey = "defaultValue";
        target = contractDetailType.contractDetailTypeParams.filter(param => param.type === contractTab.variable.dataType.DynamicTable);
    }

    await Promise.all(target.map(async param => {

        let fields = await contractTab.method.createDynamicGridFields(param.dynamicTables, valueKey);
        // let listGridFirstField = {name: null};
        // if (fields && fields.length)
        //     listGridFirstField = fields[0];

        let dynamicGrid = isc.ListGrid.create({

            autoDraw: false,
            width: "100%",
            height: "300",
            sortField: 1,
            selectionType: "single",
            sortDirection: "ascending",
            canHover: true,
            showHover: true,
            validateOnExit: true,
            // autoFitData: "vertical",
            // autoFitDateFields: "both",
            // autoFitMaxWidth: "15%",
            // autoFitWidthApproach: "both",
            // autoFitFieldsFillViewport: true,
            // autoFitExpandField: listGridFirstField.name,
            showRowNumbers: true,
            canAutoFitFields: false,
            allowAdvancedCriteria: true,
            alternateRecordStyles: true,
            canEdit: true,
            editEvent: "doubleClick",
            autoSaveEdits: false,
            virtualScrolling: false,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            recordComponentPoolingMode: "recycle",
            listEndEditAction: "next",
            canRemoveRecords: true,
            fields: fields.concat({

                hidden: true,
                canEdit: false,
                required: false,
                name: "rowNum",
                title: '<spring:message code="global.col.num"/>'
            }),
            key: param.key,
            title: param.name,
            unitId: param.unitId,
            paramType: param.type,
            required: param.required,
            dynamicTableValues: param.dynamicTables,
            values: !isNewMode ? param.values : [],
            reference: !isNewMode ? param.reference : param.id,
            contractDetailId: !isNewMode ? param.contractDetailId : null,
            name: contractDetailType.code + "." + param.key,
            dataChanged: function (operationType) {

                contractTab.dynamicForm.valuesManager.setValue(this.name, contractTab.method.setDisplayData(this, true));
                this.Super("dataChanged", arguments);
            },
            gridComponents: ["header", "body",
                isc.ToolStrip.create({
                    width: "100%",
                    height: 24,
                    members: [
                        isc.ToolStripButton.create({
                            icon: "pieces/16/icon_add.png",
                            title: "<spring:message code='global.add'/>",
                            click: function () {

                                const maxRows = {
                                    required: false,
                                    maxRows: 0
                                };
                                fields.forEach(column => {

                                    if (column.maxRows > maxRows.maxRows) {

                                        if (column.required && !maxRows.required) {

                                            maxRows.required = true;
                                            maxRows.maxRows = column.maxRows
                                        }
                                        if (!column.required && !maxRows.required) {

                                            maxRows.required = false;
                                            maxRows.maxRows = column.maxRows
                                        }
                                    }
                                    if (column.maxRows > 0 && column.maxRows < maxRows.maxRows && column.required && !maxRows.required) {

                                        maxRows.required = true;
                                        maxRows.maxRows = column.maxRows
                                    }
                                });

                                if (maxRows.maxRows > 0 && dynamicGrid.getTotalRows() >= maxRows.maxRows)
                                    return contractTab.dialog.say("<spring:message code='global.max.rows.exceed'/>");

                                dynamicGrid.startEditingNew();
                            }
                        }),
                        isc.ToolStrip.create({
                            width: "100%",
                            height: 24,
                            align: nicico.CommonUtil.getAlignByLang(),
                            border: 0,
                            members: [
                                isc.ToolStripButton.create({
                                    icon: "pieces/16/save.png",
                                    title: "<spring:message code='global.form.save.temporary'/>",
                                    click: function () {

                                        if (!dynamicGrid.validateAllData()) return;
                                        dynamicGrid.saveAllEdits();
                                    }
                                })]
                        })
                    ]
                })]
        });

        if (!isNewMode)
            dynamicGrid.setData(await contractTab.method.createDynamicGridData(param.values, fields));

        dynamicGrids.push(dynamicGrid);
    }));

    return dynamicGrids;
};
contractTab.method.createDynamicGridData = async function (values, fields) {

    let data = [];
    values.forEach(row => {

        let record = {rowNum: row.value, contractDetailValueId: row.id};
        row.dynamicTableValues.forEach(col => {

            let field = fields.find(q => q.colNum === col.colNum);
            record[field.name] = col.value;
        });

        data.add(record);
    });

    return data;
};
contractTab.method.createDynamicGridFields = async function (dynamicTableValues, valueKey) {

    var dataTypeKeys = Object.keys(contractTab.variable.dataType);

    function getDefaultFieldObject(column) {

        let defaultField = {

            validateOnExit: true,
            validateOnChange: true,
            name: column.headerValue,
            title: column.headerTitle,
            hint: column.description,
            showHintInField: !!column.description,

            required: column.required,

            colNum: column.colNum,
            maxRows: column.maxRows,
            headerKey: column.headerKey,
            headerType: column.headerType,
            headerTitle: column.headerTitle,
            headerValue: column.headerValue,
            valueType: column.valueType,
            description: column.description,
            displayField: column.displayField,
            regexValidator: column.regexValidator,
            initialCriteria: column.initialCriteria,
        };
        if (dataTypeKeys.includes(column.valueType))
            Object.assign(defaultField, getFieldProperties(column.valueType, null));

        return defaultField;
    }

    async function getDynamicHeaders(columns) {

        const dynamicHeaders = columns.filter(column => !dataTypeKeys.includes(column.headerType));
        const dynamicHeaderTitleRes = await Promise.all(dynamicHeaders.map(column => fetch(
            '${contextPath}' + column.headerType + '?criteria=' + JSON.stringify({
                fieldName: 'id',
                operator: "equals",
                value: Number(column.headerValue)
            }),
            {headers: SalesConfigs.httpHeaders})
        ));

        const dynamicHeaderTitles = await Promise.all(dynamicHeaderTitleRes.map(_ => _.json()));
        return dynamicHeaders.map((_obj, _index) => {

            return {

                colNum: _obj.colNum,
                name: dynamicHeaderTitles[_index]['response']['data'][0][_obj.headerKey],
            }
        });
    }

    async function getDynamicValueFields(columns) {

        const dynamicValues = columns.filter(column => !dataTypeKeys.includes(column.valueType));
        const dynamicValuesRes = await Promise.all(dynamicValues.map(column => fetch(
            '${contextPath}' + column.valueType + '?_startRow=0&_endRow=1',
            {headers: SalesConfigs.httpHeaders}
            ))
        );

        const dynamicValuesResponse = await Promise.all(dynamicValuesRes.map(_ => _.json()))
        return dynamicValues.map((_obj, _index) => {

            return {

                colNum: _obj.colNum,
                fields: getAllFields(dynamicValuesResponse[_index]['response']['data'][0]).map(name => {

                    const _f = {name: name};
                    if (name.includes("\.")) _f.hidden = true;
                    return _f;
                })
            };
        });
    }

    const fields = [];
    const [dynamicHeaders, dynamicValueFields] = await Promise.all([getDynamicHeaders(dynamicTableValues), getDynamicValueFields(dynamicTableValues)]);
    dynamicTableValues.forEach(column => {

        const _field = getDefaultFieldObject(column)
        if (column[valueKey])
            _field[valueKey] = column[valueKey];
        if (column.regexValidator)
            _field.validators = [{type: "regexp", expression: column.regexValidator, validateOnChange: true}];

        if (dataTypeKeys.includes(column.headerType) && dataTypeKeys.includes(column.valueType)) {

            fields.add(_field);
            return;
        }

        let extraProperties = {};
        const dynamicHeader = dynamicHeaders.find(f => f.colNum === column.colNum);
        const dynamicValue = dynamicValueFields.find(f => f.colNum === column.colNum);

        if (dynamicHeader)
            extraProperties.name = dynamicHeader.name;

        if (dynamicValue) {

            let firstField = {name: null};
            if (dynamicValue.fields && dynamicValue.fields.length)
                firstField = dynamicValue.fields[0];

            Object.assign(extraProperties, {

                optionCriteria: column.initialCriteria ? JSON.parse(column.initialCriteria) : null,
                optionDataSource: isc.MyRestDataSource.create({
                    fields: dynamicValue.fields,
                    fetchDataURL: '${contextPath}' + column.valueType
                }),
                pickListHeight: 800,
                pickListWidth: .7 * innerWidth,
                pickListFields: dynamicValue.fields.map((_field, _index) => {

                    if (_index > 5) _field.hidden = true;
                    return _field;
                }),
                pickListProperties: {

                    autoFitData: "vertical",
                    autoFitDateFields: "both",
                    autoFitMaxWidth: "15%",
                    autoFitWidthApproach: "both",
                    autoFitFieldsFillViewport: true,
                    autoFitExpandField: firstField.name,

                    showFilterEditor: true,
                    allowAdvancedCriteria: true,
                },
                required: true,
                validateOnExit: true,
                addUnknownValues: false,
                editorType: "comboBox",
                textMatchStyle: "substring",
                valueField: "id",
                displayField: column.displayField
            });
        }

        Object.assign(_field, extraProperties);
        fields.add(_field);
    });

    return fields.sort((_1, _2) => Number(_1.colNum) >= Number(_2.colNum));
};

//****************************************************** Extras ********************************************************