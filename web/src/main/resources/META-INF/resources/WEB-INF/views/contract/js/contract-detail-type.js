var contractDetailTypeTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractDetailTypeTab.variable.url = "${contextPath}" + "/api/contract-detail-type/";
contractDetailTypeTab.variable.unitUrl = "${contextPath}" + "/api/unit/";
contractDetailTypeTab.variable.paramUrl = "${contextPath}" + "/api/contract-detail-type-param/";
contractDetailTypeTab.variable.templateUrl = "${contextPath}" + "/api/contract-detail-type-template/";

contractDetailTypeTab.window.formUtil = new nicico.FormUtil();

//***************************************************** RESTDATASOURCE *************************************************

contractDetailTypeTab.dynamicForm.fields.code = {
    name: "code",
    width: "100%",
    required: true,
    keyPressFilter: "^[A-Za-z0-9]",
    title: "<spring:message code='global.code'/>",
    valueMap: JSON.parse('${Enum_EContractDetailTypeCode}'),
};
contractDetailTypeTab.dynamicForm.fields.material = {
    name: "materialId",
    width: "100%",
    editorType: "SelectItem",
    filterOperator: "equals",
    optionDataSource: isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
                {name: "descEN"},
                {name: "unitId"},
                {name: "unit.nameEN"},
            ],
        fetchDataURL: "${contextPath}/api/material/spec-list"
    }),
    displayField: "descEN",
    valueField: "id",
    required: true,
    title: "<spring:message code='material.title'/>"
};
contractDetailTypeTab.dynamicForm.fields.titleEn = {
    name: "titleEN",
    width: "100%",
    required: true,
    keyPressFilter: "^[A-Za-z0-9-\\s\\/]",
    title: "<spring:message code='global.title-en'/>"
};

contractDetailTypeTab.restDataSource.unit = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            title: '<spring:message code="global.id"/>',
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "nameFA",
            title: "<spring:message code='unit.nameFA'/> "
        },
        {
            name: "nameEN",
            title: "<spring:message code='unit.nameEN'/> "
        },
        {
            name: "symbol",
            title: "<spring:message code='unit.symbol'/>"
        },
        {
            name: "decimalDigit",
            title: "<spring:message code='rate.decimalDigit'/>"
        }
    ],
    fetchDataURL: contractDetailTypeTab.variable.unitUrl + "spec-list"
});

contractDetailTypeTab.dynamicForm.paramFields = {};
contractDetailTypeTab.dynamicForm.paramFields.name = {
    name: "name",
    width: "20%",
    required: true,
    title: "<spring:message code='global.title'/>"
};
contractDetailTypeTab.dynamicForm.paramFields.key = {
    name: "key",
    width: "15%",
    required: true,
    keyPressFilter: "^[A-Za-z|0-9]",
    title: "<spring:message code='global.key'/>",
    valueMap: JSON.parse('${Enum_EContractDetailValueKey}')
};
contractDetailTypeTab.dynamicForm.paramFields.type = {
    name: "type",
    width: "20%",
    required: true,
    valueMap: JSON.parse('${Enum_DataType}'),
    title: "<spring:message code='global.type'/>"
};
contractDetailTypeTab.dynamicForm.paramFields.reference = {
    name: "reference",
    width: "20%",
    required: true,
    canEdit: false,
    title: "<spring:message code='global.reference'/>"
};
contractDetailTypeTab.dynamicForm.paramFields.unitId = {
    name: "unitId",
    type: 'long',
    width: "20%",
    editorType: "SelectItem",
    valueField: "id",
    displayField: "name",
    pickListWidth: "300",
    pickListHeight: "300",
    pickListProperties: {showFilterEditor: true},
    pickListFields: [
        {name: "id", align: "center", hidden: true},
        {name: "nameFA", align: "center"},
        {name: "nameEN", align: "center"},
    ],
    title: "<spring:message code='global.unit'/>",
    optionDataSource: contractDetailTypeTab.restDataSource.unit
};
contractDetailTypeTab.dynamicForm.paramFields.required = {
    name: "required",
    type: "boolean",
    width: "10%",
    required: false,
    title: "<spring:message code='global.required'/>"
};
contractDetailTypeTab.dynamicForm.paramFields.defaultValue = {
    name: "defaultValue",
    width: "20%",
    canEdit: false,
    showHover: true,
    title: "<spring:message code='global.default-value'/>"
};
contractDetailTypeTab.dynamicForm.paramFields.contractDetailTypeId = {
    width: "20%",
    hidden: true,
    required: true,
    name: "contractDetailTypeId",
    title: "<spring:message code='contract-detail-type.form.title-fa'/>"
};

contractDetailTypeTab.dynamicForm.templateFields = {};
contractDetailTypeTab.dynamicForm.templateFields.code = {
    name: "code",
    width: "20%",
    required: true,
    keyPressFilter: "^[A-Za-z|0-9]",
    title: "<spring:message code='global.code'/>"
};
contractDetailTypeTab.dynamicForm.templateFields.content = {
    name: "content",
    width: "80%",
    required: true,
    title: "<spring:message code='global.content'/>"
};
contractDetailTypeTab.dynamicForm.templateFields.contractDetailTypeId = {
    name: "contractDetailTypeId",
    width: "50%",
    hidden: true,
    required: true,
    title: "<spring:message code='contract-detail-type.form.title-fa'/>"
};

contractDetailTypeTab.restDataSource.detailType = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
        contractDetailTypeTab.dynamicForm.fields.code,
        contractDetailTypeTab.dynamicForm.fields.material,
        contractDetailTypeTab.dynamicForm.fields.titleEn,
    ], false),
    fetchDataURL: contractDetailTypeTab.variable.url + "spec-list"
});

//*************************************************** Componnents ******************************************************

contractDetailTypeTab.menu.detailType = isc.Menu.create({
    width: 150,
    data: [
        {
            icon: "pieces/16/refresh.png",
            title: '<spring:message code="global.form.refresh" />',
            click: function () {
                contractDetailTypeTab.method.refreshData();
            }
        },
        // <sec:authorize access="hasAuthority('C_CONTRACT_DETAIL_TYPE')">
        {
            icon: "pieces/16/icon_add.png",
            title: '<spring:message code="global.form.new" />',
            click: function () {
                contractDetailTypeTab.method.addData();
            }
        },
        // </sec:authorize>
        // <sec:authorize access="hasAuthority('U_CONTRACT_DETAIL_TYPE')">
        {
            icon: "pieces/16/icon_edit.png",
            title: '<spring:message code="global.form.edit" />',
            click: function () {
                contractDetailTypeTab.method.editData();
            }
        },
        // </sec:authorize>
        // <sec:authorize access="hasAuthority('D_CONTRACT_DETAIL_TYPE')">
        {
            icon: "pieces/16/icon_delete.png",
            title: '<spring:message code="global.form.remove" />',
            click: function () {
                contractDetailTypeTab.method.deleteRecord();
            }
        }
        // </sec:authorize>
    ]
});
contractDetailTypeTab.listGrid.detailType = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    autoFetchData: true,
    showRowNumbers: true,
    showFilterEditor: true,
    contextMenu: contractDetailTypeTab.menu.detailType,
    dataSource: contractDetailTypeTab.restDataSource.detailType,
    // <sec:authorize access="hasAuthority('U_CONTRACT_DETAIL_TYPE')">
    recordDoubleClick() {
        contractDetailTypeTab.method.editData();
    }
    // </sec:authorize>
});

contractDetailTypeTab.listGrid.param = isc.ListGrid.create({

    width: "100%",
    height: "100%",
    sortField: "id",
    showRowNumbers: true,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    sortDirection: "ascending",
    fields: BaseFormItems.concat([
        contractDetailTypeTab.dynamicForm.paramFields.name,
        contractDetailTypeTab.dynamicForm.paramFields.key,
        contractDetailTypeTab.dynamicForm.paramFields.type,
        contractDetailTypeTab.dynamicForm.paramFields.reference,
        contractDetailTypeTab.dynamicForm.paramFields.unitId,
        contractDetailTypeTab.dynamicForm.paramFields.required,
        contractDetailTypeTab.dynamicForm.paramFields.defaultValue
    ]),
    // <sec:authorize access="hasAuthority('U_CONTRACT_DETAIL_TYPE_PARAM')">
    canEdit: true,
    editEvent: "doubleClick",
    autoSaveEdits: false,
    virtualScrolling: false,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    recordComponentPoolingMode: "recycle",
    listEndEditAction: "next",
    // </sec:authorize>
    // <sec:authorize access="hasAuthority('D_CONTRACT_DETAIL_TYPE_PARAM')">
    canRemoveRecords: true,
    // </sec:authorize>
    gridComponents: ["header", "body", isc.ToolStrip.create({

        width: "100%",
        height: 24,
        members: [
            // <sec:authorize access="hasAuthority('C_CONTRACT_DETAIL_TYPE_PARAM')">
            isc.ToolStripButton.create({

                icon: "pieces/16/icon_add.png",
                title: "<spring:message code='global.add'/>",
                click: function () {
                    contractDetailTypeTab.listGrid.param.startEditingNew();
                }
            }),
            // </sec:authorize>
            // <sec:authorize access="hasAnyAuthority('C_CONTRACT_DETAIL_TYPE_PARAM') || hasAnyAuthority('U_CONTRACT_DETAIL_TYPE_PARAM')">
            isc.ToolStripButton.create({

                // icon: "pieces/16/icon_add.png",
                title: "<spring:message code='contract-detail-type.window.param-valid-reference.define'/>",
                click: function () {

                    contractDetailTypeTab.listGrid.param.saveAllEdits();
                    let record = contractDetailTypeTab.listGrid.param.getSelectedRecord();
                    if (record == null)
                        contractDetailTypeTab.dialog.notSelected();
                    else if (record.editable === false)
                        contractDetailTypeTab.dialog.notEditable();
                    else if (!record.type.includes('Reference'))
                        isc.Dialog.create({
                            message: "<spring:message code='contract-detail-type.window.type-must-reference'/>",
                            icon: "[SKIN]ask.png",
                            title: "<spring:message code='global.message'/>",
                            buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                            buttonClick: function (button, index) {
                                this.close();
                            }
                        });
                    else {

                        contractDetailTypeTab.listGrid.param.saveAllEdits();
                        let record = contractDetailTypeTab.listGrid.param.getSelectedRecord();
                        if (record == null)
                            contractDetailTypeTab.dialog.notSelected();
                        else if (record.editable === false)
                            contractDetailTypeTab.dialog.notEditable();
                        else {

                            contractDetailTypeTab.window.formUtil.populateData = function (body) {
                                return [body.getValues()];
                            };
                            contractDetailTypeTab.window.formUtil.validate = function () {
                                let form = contractDetailTypeTab.window.formUtil.bodyWidget.getObject();
                                form.validate();
                                return !form.hasErrors();
                            };
                            contractDetailTypeTab.window.formUtil.okCallBack = function (data) {

                                let colNumber = contractDetailTypeTab.listGrid.param.getColNum("reference");
                                let rowNumber = contractDetailTypeTab.listGrid.param.getRecordIndex(record);
                                let oldValue = record[contractDetailTypeTab.dynamicForm.paramFields.reference.name];

                                record[contractDetailTypeTab.dynamicForm.paramFields.reference.name] = data[0]['reference'];
                                contractDetailTypeTab.listGrid.param.refreshRow(contractDetailTypeTab.listGrid.param.getRecordIndex(record));
                                contractDetailTypeTab.listGrid.param.cellChanged(record, data[0]['reference'], oldValue, rowNumber, colNumber, contractDetailTypeTab.listGrid.param);
                            };

                            let dynamicForm = isc.DynamicForm.nicico.getDefault([{
                                width: "100%",
                                name: "reference",
                                editorType: "SelectItem",
                                title: "<spring:message code='global.reference'/>",
                                valueMap: contractDetailTypeReferences
                            }]);
                            dynamicForm.setValue("reference", record[contractDetailTypeTab.dynamicForm.paramFields.reference.name]);
                            contractDetailTypeTab.window.formUtil.showForm(
                                contractDetailTypeTab.window.detailType,
                                "<spring:message code='contract-detail-type.window.param-valid-reference.define'/>",
                                dynamicForm, '500');
                        }
                    }
                }
            }),
            // </sec:authorize>
            // <sec:authorize access="hasAnyAuthority('C_CONTRACT_DETAIL_TYPE_PARAM') || hasAnyAuthority('U_CONTRACT_DETAIL_TYPE_PARAM')">
            isc.ToolStripButton.create({

                // icon: "pieces/16/icon_add.png",
                title: "<spring:message code='contract-detail-type.window.param-default-value.define'/>",
                click: function () {

                    contractDetailTypeTab.listGrid.param.saveAllEdits();
                    let record = contractDetailTypeTab.listGrid.param.getSelectedRecord();
                    if (record == null)
                        contractDetailTypeTab.dialog.notSelected();
                    else if (record.editable === false)
                        contractDetailTypeTab.dialog.notEditable();
                    else {

                        let recordType = record[contractDetailTypeTab.dynamicForm.paramFields.type.name];
                        if (recordType === 'Reference') {
                            let referenceType = record[contractDetailTypeTab.dynamicForm.paramFields.reference.name];
                            if (referenceType === undefined) {
                                isc.Dialog.create({
                                    message: "<spring:message code='contract-detail-type.window.reference-required'/>",
                                    icon: "[SKIN]ask.png",
                                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                    buttonClick: function (button, index) {
                                        this.close();
                                    }
                                });
                                return;
                            }
                        }
                        let defaultValueEditorProperties = getFieldProperties(recordType, null);
                        if (defaultValueEditorProperties == null)
                            return;

                        contractDetailTypeTab.window.formUtil.populateData = function (body) {
                            return [body.getValues()];
                        };
                        contractDetailTypeTab.window.formUtil.validate = function () {
                            let form = contractDetailTypeTab.window.formUtil.bodyWidget.getObject();
                            form.validate();
                            return !form.hasErrors();
                        };
                        contractDetailTypeTab.window.formUtil.okCallBack = function (data) {
                            let selectedRecord = contractDetailTypeTab.listGrid.param.getSelectedRecord();
                            selectedRecord[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] = data[0]['defaultValue'];
                            contractDetailTypeTab.listGrid.param.refreshRow(contractDetailTypeTab.listGrid.param.getRecordIndex(selectedRecord));
                        };

                        let defaultValueExtraEditorProperties = {};
                        if (recordType === 'Reference') {
                            let referenceType = record[contractDetailTypeTab.dynamicForm.paramFields.reference.name];
                            let displayField = getReferenceFields(referenceType)[1].name;
                            if (referenceType.includes('Enum')) {
                                defaultValueExtraEditorProperties = {
                                    editorType: "SelectItem",
                                    valueMap: contractDetailTypeReferencesValues[referenceType],
                                };
                            } else {
                                defaultValueExtraEditorProperties = {
                                    autoFetchData: false,
                                    editorType: "SelectItem",
                                    valueField: "id",
                                    displayField: displayField,
                                    pickListHeight: "300",
                                    optionDataSource: getReferenceDataSource(referenceType),
                                    pickListFields: [
                                        {name: displayField}
                                    ]
                                };
                            }
                        }
                        if (defaultValueEditorProperties.type.toLowerCase() === 'date') {
                            defaultValueExtraEditorProperties.getValue = function () {

                                if (this.value != null)
                                    return new Date(this.value);

                                return this.value;
                            };
                        }

                        let dynamicForm = isc.DynamicForm.nicico.getDefault([Object.assign({
                            width: "100%",
                            name: "defaultValue",
                            title: "<spring:message code='global.default-value'/>"
                        }, defaultValueEditorProperties, defaultValueExtraEditorProperties)]);
                        dynamicForm.setValue("defaultValue", record[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name]);
                        contractDetailTypeTab.window.formUtil.showForm(
                            contractDetailTypeTab.window.detailType,
                            "<spring:message code='contract-detail-type.window.param-default-value.define'/>",
                            dynamicForm, '400');
                    }
                }
            }),
            // </sec:authorize>
            // <sec:authorize access="hasAnyAuthority('C_CONTRACT_DETAIL_TYPE_PARAM') || hasAnyAuthority('U_CONTRACT_DETAIL_TYPE_PARAM') || hasAnyAuthority('D_CONTRACT_DETAIL_TYPE_PARAM')">
            isc.ToolStrip.create({

                width: "100%",
                height: 24,
                align: 'left',
                border: 0,
                members: [
                    isc.ToolStripButton.create({

                        icon: "pieces/16/save.png",
                        title: "<spring:message code='contract.detail.param.form.save'/>",
                        click: function () {
                            contractDetailTypeTab.listGrid.param.saveAllEdits();
                        }
                    })]
            })
            // </sec:authorize>
        ]
    })],
    cellChanged: function (record, newValue, oldValue, rowNum, colNum, grid) {
        if (newValue === oldValue)
            return;

        if (grid.fields[colNum].name === contractDetailTypeTab.dynamicForm.paramFields.type.name) {
            if (record[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] == null &&
                record[contractDetailTypeTab.dynamicForm.paramFields.reference.name] == null)
                return;

            contractDetailTypeTab.dialog.say(
                "<spring:message code='contract-detail-type.window.param-type.reset'/>",
                "<spring:message code='global.warning'/>");

            record[contractDetailTypeTab.dynamicForm.paramFields.reference.name] = null;
            record[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] = null;
            contractDetailTypeTab.listGrid.param.refreshRow(contractDetailTypeTab.listGrid.param.getRecordIndex(record));
        }
        if (grid.fields[colNum].name === contractDetailTypeTab.dynamicForm.paramFields.reference.name) {
            if (record[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] == null)
                return;

            contractDetailTypeTab.dialog.say(
                "<spring:message code='contract-detail-type.window.param-reference.reset'/>",
                "<spring:message code='global.warning'/>");

            record[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] = null;
            contractDetailTypeTab.listGrid.param.refreshRow(contractDetailTypeTab.listGrid.param.getRecordIndex(record));
        }
    },
    getParamEditorProperties: function (paramType) {
        switch (paramType) {
            case 'PersianDate':
                return {
                    length: 10,
                    textAlign: "center",
                    type: 'text',
                    icons: [persianDatePicker]
                };
            case 'GeorgianDate':
                return {
                    type: "date",
                    textAlign: "center",
                    format: 'dd/MM/YYYY'
                };
            case 'Boolean':
                return {
                    type: "boolean"
                };
            case 'BigDecimal':
            case 'Float':
            case 'Double':
                return {
                    type: "float",
                    keyPressFilter: "[0-9.+-]"
                };
            case 'Integer':
            case 'Long':
                return {
                    type: "integer",
                    keyPressFilter: "[0-9+-]"
                };
            case 'String':
                return {
                    type: "text",
                };
            case 'Reference':
                return {
                    type: "integer"
                };
            default:
                break;
        }

        return null;
    }
});
contractDetailTypeTab.listGrid.template = isc.ListGrid.create({

    width: "100%",
    height: "100%",
    sortField: 1,
    showRowNumbers: true,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    sortDirection: "ascending",
    fields: BaseFormItems.concat([
        contractDetailTypeTab.dynamicForm.templateFields.code,
        contractDetailTypeTab.dynamicForm.templateFields.content
    ]),
    // <sec:authorize access="hasAuthority('U_CONTRACT_DETAIL_TYPE_TEMPLATE')">
    canEdit: true,
    editEvent: "doubleClick",
    autoSaveEdits: false,
    listEndEditAction: "next",
    virtualScrolling: false,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    recordComponentPoolingMode: "recycle",
    // </sec:authorize>
    // <sec:authorize access="hasAuthority('D_CONTRACT_DETAIL_TYPE_TEMPLATE')">
    canRemoveRecords: true,
    // </sec:authorize>
    gridComponents: ["header", "body", isc.ToolStrip.create({

        width: "100%",
        height: 24,
        members: [
            // <sec:authorize access="hasAuthority('C_CONTRACT_DETAIL_TYPE_TEMPLATE')">
            isc.ToolStripButton.create({

                icon: "pieces/16/icon_add.png",
                title: "<spring:message code='global.add'/>",
                click: function () {

                    contractDetailTypeTab.listGrid.param.saveAllEdits();
                    if (!contractDetailTypeTab.listGrid.param.validateAllData()) {

                        contractDetailTypeTab.dialog.say(
                            "<spring:message code='contract-detail-type.window.validation.param'/>",
                            "<spring:message code='global.error'/>");

                        return;
                    }

                    contractDetailTypeTab.listGrid.template.startEditingNew();
                }
            }),
            // </sec:authorize>
            // <sec:authorize access="hasAnyAuthority('C_CONTRACT_DETAIL_TYPE_TEMPLATE') || hasAnyAuthority('U_CONTRACT_DETAIL_TYPE_TEMPLATE') || hasAnyAuthority('D_CONTRACT_DETAIL_TYPE_TEMPLATE')">
            isc.ToolStrip.create({

                width: "100%",
                height: 24,
                align: 'left',
                border: 0,
                members: [
                    isc.ToolStripButton.create({

                        icon: "pieces/16/save.png",
                        title: "<spring:message code='contract.detail.template.form.save'/>",
                        click: function () {

                            contractDetailTypeTab.listGrid.template.saveAllEdits();
                        }
                    })]
            })
            // </sec:authorize>
        ]
    })],
    getDefaultHTMLValue: function (params) {

        let result = '';
        for (let i = 0; i < params.length; i++) {

            let paramKey = params[i][contractDetailTypeTab.dynamicForm.paramFields.key.name];
            if (paramKey == null)
                continue;

            result += '$';
            result += '{';
            result += paramKey;
            result += '}';

            let paramUnitId = params[i][contractDetailTypeTab.dynamicForm.paramFields.unitId.name];
            if (paramUnitId == null) {

                result += '<br>';
                continue;
            }

            result += '&nbsp;&nbsp;&nbsp;$';
            result += '{_';
            result += paramUnitId;
            result += '}<br>';
        }

        return result;
    },
    getEditorProperties: function (editField, editedRecord, rowNum) {
        if (editField.name === contractDetailTypeTab.dynamicForm.templateFields.content.name)
            return {

                height: 300,
                width: '100%',
                required: true,
                editorType: "RichTextItem",
                defaultValue: this.getDefaultHTMLValue(contractDetailTypeTab.listGrid.param.getData()),
                keyPress: function () {

                    if (isc.EventHandler.getKey().toLowerCase() === "enter" && !isc.EventHandler.shiftKeyDown()) {

                        contractDetailTypeTab.listGrid.template.endEditing();
                        return false;
                    }

                    if (this.getValue().replaceAll('<br>', '').replaceAll(' ', '').length === 0)
                        this.setValue('');

                    return true;
                }
            };

        return editField;
    }
});
contractDetailTypeTab.hLayout.extra = isc.HLayout.create({
    width: "100%",
    height: "500",
    members: [
        contractDetailTypeTab.listGrid.param,
        contractDetailTypeTab.listGrid.template
    ]
});

contractDetailTypeTab.dynamicForm.detailType = isc.DynamicForm.create({
    width: "100%",
    height: "100%",
    align: "center",
    numCols: 8,
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: BaseFormItems.concat([
        contractDetailTypeTab.dynamicForm.fields.code,
        contractDetailTypeTab.dynamicForm.fields.material,
        contractDetailTypeTab.dynamicForm.fields.titleEn,
    ], true)
});
contractDetailTypeTab.hLayout.saveOrExitHlayout = isc.HLayout.create({

    height: "5%",
    width: "100%",
    showEdges: false,
    alignLayout: "center",
    padding: 10,
    layoutMargin: 5,
    membersMargin: 10,
    members: [
        isc.IButtonSave.create({

            top: 260,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {

                contractDetailTypeTab.dynamicForm.detailType.validate();
                if (contractDetailTypeTab.dynamicForm.detailType.hasErrors() ||
                    !contractDetailTypeTab.listGrid.param.validateAllData() ||
                    !contractDetailTypeTab.listGrid.template.validateAllData())
                    return;

                contractDetailTypeTab.listGrid.param.saveAllEdits();
                contractDetailTypeTab.listGrid.template.saveAllEdits();

                let data = contractDetailTypeTab.dynamicForm.detailType.getValues();
                let allParams = contractDetailTypeTab.listGrid.param.getData();
                let allTemplates = contractDetailTypeTab.listGrid.template.getData();

                for (let i = 0; i < allParams.length; i++) {
                    allParams[i][contractDetailTypeTab.dynamicForm.paramFields.contractDetailTypeId.name] = data.id;
                    if (allParams[i].type == "Reference" && allParams[i].reference == null) {
                        contractDetailTypeTab.dialog.say(
                            "<spring:message code='contract-detail-type.window.param-reference-empty'/>",
                            "<spring:message code='global.warning'/>");
                        return;
                    }
                }

                data.contractDetailTypeParams = allParams;

                for (let i = 0; i < allTemplates.length; i++)
                    allTemplates[i][contractDetailTypeTab.dynamicForm.templateFields.contractDetailTypeId.name] = data.id;
                data.contractDetailTypeTemplates = allTemplates;

                if (data.contractDetailTypeTemplates == 0) {
                    contractDetailTypeTab.dialog.say("<spring:message code='contract-detail-type.window.validation.template.empty.check'/>",
                        "<spring:message code='global.warning'/>");
                    return;
                }

                data.titleFA = data.titleEN;
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: contractDetailTypeTab.variable.url,
                    httpMethod: contractDetailTypeTab.variable.method,
                    data: JSON.stringify(data),
                    callback: function (resp) {

                        if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                            contractDetailTypeTab.dialog.ok();
                            contractDetailTypeTab.method.refreshData();
                            contractDetailTypeTab.window.detailType.close();
                        } else
                            contractDetailTypeTab.dialog.error(resp);
                    }
                }));
            }
        }),
        isc.IButtonCancel.create({

            width: 100,
            orientation: "vertical",
            icon: "pieces/16/icon_delete.png",
            title: "<spring:message code='global.close'/>",
            click: function () {

                contractDetailTypeTab.window.detailType.close();
            }
        })
    ]
});

contractDetailTypeTab.window.detailType = isc.Window.nicico.getDefault(null, [
    contractDetailTypeTab.dynamicForm.detailType,
    contractDetailTypeTab.hLayout.extra,
    contractDetailTypeTab.hLayout.saveOrExitHlayout
], "85%", null);

//*************************************************** Functions ********************************************************

contractDetailTypeTab.method.addData = function () {
    contractDetailTypeTab.variable.method = "POST";
    contractDetailTypeTab.listGrid.param.setData([]);
    contractDetailTypeTab.listGrid.template.setData([]);
    contractDetailTypeTab.dynamicForm.detailType.clearValues();
    contractDetailTypeTab.window.detailType.setTitle("<spring:message code='contract-detail-type.window.title.add'/>");
    contractDetailTypeTab.window.detailType.show();
};
contractDetailTypeTab.method.editData = function () {

    let record = contractDetailTypeTab.listGrid.detailType.getSelectedRecord();
    if (record == null || record.id == null)
        contractDetailTypeTab.dialog.notSelected();
    else if (record.editable === false)
        contractDetailTypeTab.dialog.notEditable();
    else if (record.estatus.contains(Enums.eStatus2.DeActive))
        contractDetailTypeTab.dialog.inactiveRecord();
    else if (record.estatus.contains(Enums.eStatus2.Final))
        contractDetailTypeTab.dialog.finalRecord();
    else {
        contractDetailTypeTab.variable.method = "PUT";
        contractDetailTypeTab.listGrid.param.setData(record.contractDetailTypeParams);
        contractDetailTypeTab.listGrid.template.setData(record.contractDetailTypeTemplates);
        contractDetailTypeTab.dynamicForm.detailType.editRecord(JSON.parse(JSON.stringify(record)))
        contractDetailTypeTab.window.detailType.setTitle("<spring:message code='contract-detail-type.window.title.edit'/>");
        contractDetailTypeTab.window.detailType.show();
    }
};
contractDetailTypeTab.method.refreshData = function () {
    contractDetailTypeTab.listGrid.detailType.invalidateCache();
};
contractDetailTypeTab.method.deleteRecord = function () {

    const record = contractDetailTypeTab.listGrid.detailType.getSelectedRecord();
    if (record == null || record.id == null)
        contractDetailTypeTab.dialog.notSelected();
    else if (record.editable === false)
        contractDetailTypeTab.dialog.notEditable();
    else if (record.estatus.contains(Enums.eStatus2.DeActive))
        contractDetailTypeTab.dialog.inactiveRecord();
    else if (record.estatus.contains(Enums.eStatus2.Final))
        contractDetailTypeTab.dialog.finalRecord();
    else
        contractDetailTypeTab.dialog.question(
            () => {
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: contractDetailTypeTab.variable.url + record.id,
                    httpMethod: "DELETE",
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            contractDetailTypeTab.method.refreshData();
                            contractDetailTypeTab.dialog.ok();
                        } else {
                            contractDetailTypeTab.dialog.error(resp);
                        }
                    }
                }));
            });
};
contractDetailTypeTab.method.activate_deactivate = function (activate) {
    contractDetailTypeTab.variable.method = "POST";
    let record = contractDetailTypeTab.listGrid.detailType.getSelectedRecord();
    if (record == null || record.id == null)
        contractDetailTypeTab.dialog.notSelected();
    if (!activate && record.estatus.contains(Enums.eStatus2.DeActive))
        contractDetailTypeTab.dialog.inactiveRecord();
    if (activate && record.estatus.contains(Enums.eStatus2.Active))
        contractDetailTypeTab.dialog.activeRecord();

    else {
        contractDetailTypeTab.method.jsonRPCManagerRequest({
            httpMethod: "POST",
            actionURL: contractDetailTypeTab.variable.url + (activate === true ? "" : "de") + "activate/" + record.id,
            callback: function (resp) {
                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                    contractDetailTypeTab.method.refreshData();
                    contractDetailTypeTab.dialog.ok();
                } else {
                    contractDetailTypeTab.dialog.error(resp);
                }
            }
        });
    }
};
//*************************************************** layout ***********************************************************

contractDetailTypeTab.toolStrip.actions = isc.ToolStrip.create({
    width: "100%",
    members: []
});
// <sec:authorize access="hasAuthority('C_CONTRACT_DETAIL_TYPE')">
contractDetailTypeTab.toolStrip.add = isc.ToolStripButtonAdd.create({
    title: "<spring:message code='global.form.new'/>",
    click: function () {
        contractDetailTypeTab.method.addData();
    }
});
contractDetailTypeTab.toolStrip.actions.addMember(contractDetailTypeTab.toolStrip.add);
// </sec:authorize>
// <sec:authorize access="hasAuthority('U_CONTRACT_DETAIL_TYPE')">
contractDetailTypeTab.toolStrip.edit = isc.ToolStripButtonEdit.create({
    icon: "[SKIN]/actions/edit.png",
    title: "<spring:message code='global.form.edit'/>",
    click: function () {
        contractDetailTypeTab.method.editData();
    }
});
contractDetailTypeTab.toolStrip.actions.addMember(contractDetailTypeTab.toolStrip.edit);
// </sec:authorize>
// <sec:authorize access="hasAuthority('D_CONTRACT_DETAIL_TYPE')">
contractDetailTypeTab.toolStrip.remove = isc.ToolStripButtonRemove.create({
    icon: "[SKIN]/actions/remove.png",
    title: '<spring:message code="global.form.remove" />',
    click: function () {
        contractDetailTypeTab.method.deleteRecord();
    }
});
contractDetailTypeTab.toolStrip.actions.addMember(contractDetailTypeTab.toolStrip.remove);
// </sec:authorize>
// <sec:authorize access="hasAuthority('A_CONTRACT_DETAIL_TYPE')">
contractDetailTypeTab.toolStrip.activate = isc.ToolStripButton.create({
    icon: "[SKIN]/actions/configure.png",
    title: "<spring:message code='global.active'/>",
    click: function () {
        contractDetailTypeTab.method.activate_deactivate(true);
    }
}),
    contractDetailTypeTab.toolStrip.actions.addMember(contractDetailTypeTab.toolStrip.activate);
// </sec:authorize>
// <sec:authorize access="hasAuthority('I_CONTRACT_DETAIL_TYPE')">
contractDetailTypeTab.toolStrip.deactivate = isc.ToolStripButton.create({
    icon: "[SKIN]/actions/exclamation.png",
    title: "<spring:message code='global.inactive'/>",
    click: function () {
        contractDetailTypeTab.method.activate_deactivate(false);
    }
}),
    contractDetailTypeTab.toolStrip.actions.addMember(contractDetailTypeTab.toolStrip.deactivate);
// </sec:authorize>
contractDetailTypeTab.toolStrip.refresh = isc.ToolStripButtonRefresh.create({
    title: "<spring:message code='global.form.refresh'/>",
    click: function () {
        contractDetailTypeTab.method.refreshData();
    }
});
contractDetailTypeTab.toolStrip.actions.addMember(isc.ToolStrip.create({
    width: "100%",
    align: "left",
    border: '0px',
    members: [contractDetailTypeTab.toolStrip.refresh]
}));
contractDetailTypeTab.vLayout.body = isc.VLayout.create({

    width: "100%",
    height: "100%",
    members: [contractDetailTypeTab.toolStrip.actions, contractDetailTypeTab.listGrid.detailType]
});
