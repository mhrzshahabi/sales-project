var contractDetailTypeTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractDetailTypeTab.variable.url = "${contextPath}" + "/api/contract-detail-type/";
contractDetailTypeTab.variable.unitUrl = "${contextPath}" + "/api/unit/";
contractDetailTypeTab.variable.paramUrl = "${contextPath}" + "/api/contract-detail-type-param/";
contractDetailTypeTab.variable.templateUrl = "${contextPath}" + "/api/contract-detail-type-template/";

contractDetailTypeTab.window.formUtil = new nicico.FormUtil();

//***************************************************** RESTDATASOURCE *************************************************

contractDetailTypeTab.dynamicForm.fields.code = {
    name: "code",
    width: "50%",
    required: true,
    keyPressFilter: "^[A-Za-z0-9]",
    title: "<spring:message code='global.code'/>"
};
contractDetailTypeTab.dynamicForm.fields.titleFa = {
    width: "50%",
    name: "titleFa",
    required: true,
    title: "<spring:message code='global.title-fa'/>",
    keyPressFilter: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|0-9]"
};
contractDetailTypeTab.dynamicForm.fields.titleEn = {
    width: "50%",
    required: true,
    name: "titleEn",
    keyPressFilter: "^[A-Za-z0-9]",
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
            title: "<spring:message code='unit.nameFa'/> "
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
    width: "50%",
    name: "name",
    required: true,
    title: "<spring:message code='global.title'/>"
};
contractDetailTypeTab.dynamicForm.paramFields.key = {
    name: "key",
    width: "50%",
    required: true,
    keyPressFilter: "^[A-Za-z|0-9]",
    title: "<spring:message code='global.key'/>"
};
contractDetailTypeTab.dynamicForm.paramFields.type = {
    width: "50%",
    name: "type",
    required: true,
    valueMap: JSON.parse('${Enum_DataType}'),
    title: "<spring:message code='global.type'/>"
};
contractDetailTypeTab.dynamicForm.paramFields.unitId = {
    width: "50%",
    type: 'long',
    name: "unitId",
    editorType: "SelectItem",
    valueField: "id",
    displayField: "nameFA",
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
contractDetailTypeTab.dynamicForm.paramFields.defaultValue = {
    width: "50%",
    hidden: true,
    canEdit: false,
    showHover: true,
    name: "defaultValue",
    title: "<spring:message code='global.default-value'/>"
};
contractDetailTypeTab.dynamicForm.paramFields.values = {
    width: "50%",
    hidden: true,
    canEdit: false,
    showHover: true,
    name: "values",
    title: "<spring:message code='contract-detail-type.form.valid-values'/>",
    formatCellValue: function (value, record, rowNum, colNum, grid) {

        if (record == null || record.values == null || record.values.length === 0)
            return;

        return record.values.map(q => q.values).join(', ');
    }
};
contractDetailTypeTab.dynamicForm.paramFields.contractDetailTypeId = {
    width: "50%",
    hidden: true,
    required: true,
    name: "contractDetailTypeId",
    title: "<spring:message code='contract-detail-type.form.title-fa'/>"
};

contractDetailTypeTab.dynamicForm.templateFields = {};
contractDetailTypeTab.dynamicForm.templateFields.content = {
    width: "50%",
    name: "content",
    required: true,
    title: "<spring:message code='global.content'/>"
};
contractDetailTypeTab.dynamicForm.templateFields.contractDetailTypeId = {
    width: "50%",
    hidden: true,
    required: true,
    name: "contractDetailTypeId",
    title: "<spring:message code='contract-detail-type.form.title-fa'/>"
};

contractDetailTypeTab.restDataSource.detailType = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
        contractDetailTypeTab.dynamicForm.fields.code,
        contractDetailTypeTab.dynamicForm.fields.titleFa,
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
                contractDetailTypeTab.method.refresh();
            }
        },
        {
            icon: "pieces/16/icon_add.png",
            title: '<spring:message code="global.form.new" />',
            click: function () {
                contractDetailTypeTab.method.add();
            }
        },
        {
            icon: "pieces/16/icon_edit.png",
            title: '<spring:message code="global.form.edit" />',
            click: function () {
                contractDetailTypeTab.method.edit();
            }
        },
        {
            icon: "pieces/16/icon_delete.png",
            title: '<spring:message code="global.form.remove" />',
            click: function () {
                contractDetailTypeTab.method.remove();
            }
        }
    ]
});
contractDetailTypeTab.listGrid.detailType = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    autoFetchData: true,
    showRowNumbers: true,
    showFilterEditor: true,
    contextMenu: contractDetailTypeTab.menu.detailType,
    dataSource: contractDetailTypeTab.restDataSource.detailType
});

contractDetailTypeTab.listGrid.param = isc.ListGrid.create({

    width: "100%",
    height: "100%",
    sortField: 0,
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
        contractDetailTypeTab.dynamicForm.paramFields.unitId,
        contractDetailTypeTab.dynamicForm.paramFields.defaultValue,
        contractDetailTypeTab.dynamicForm.paramFields.values
    ]),
    canEdit: true,
    editEvent: "doubleClick",
    autoSaveEdits: false,
    canRemoveRecords: true,
    virtualScrolling: false,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    recordComponentPoolingMode: "recycle",
    listEndEditAction: "next",
    gridComponents: ["header", "body", isc.ToolStrip.create({

        width: "100%",
        height: 24,
        members: [
            isc.ToolStripButton.create({

                icon: "pieces/16/icon_add.png",
                title: "<spring:message code='global.add'/>",
                click: function () {
                    contractDetailTypeTab.listGrid.param.startEditingNew();
                }
            }),
            isc.ToolStripButton.create({

                // icon: "pieces/16/icon_add.png",
                title: "<spring:message code='contract-detail-type.window.param-valid-value.define'/>",
                click: function () {

                    contractDetailTypeTab.listGrid.param.saveAllEdits();
                    let record = contractDetailTypeTab.listGrid.param.getSelectedRecord();
                    if (record == null)
                        contractDetailTypeTab.dialog.notSelected();
                    else if (record.editable === false)
                        contractDetailTypeTab.dialog.notEditable();
                    else {

                        let defaultValueEditorProperties = contractDetailTypeTab.listGrid.param.getDefaultValueEditorProperties(
                            record[contractDetailTypeTab.dynamicForm.paramFields.type.name]);
                        if (defaultValueEditorProperties == null)
                            return;

                        contractDetailTypeTab.window.formUtil.populateData = function (body) {
                            return body.getData();
                        };
                        contractDetailTypeTab.window.formUtil.validate = function (data) {
                            let grid = contractDetailTypeTab.window.formUtil.bodyWidget.getObject();
                            return grid.validateAllData();
                        };
                        contractDetailTypeTab.window.formUtil.okCallBack = function (data) {
                            let selectedRecord = contractDetailTypeTab.listGrid.param.getSelectedRecord();
                            selectedRecord[contractDetailTypeTab.dynamicForm.paramFields.values.name] = data;
                            if (selectedRecord[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] != null) {
                                contractDetailTypeTab.dialog.say(
                                    "<spring:message code='contract-detail-type.window.param-default-value.reset'/>",
                                    "<spring:message code='global.warning'/>");

                                selectedRecord[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] = null;
                            }
                            contractDetailTypeTab.listGrid.param.refreshRow(contractDetailTypeTab.listGrid.param.getRecordIndex(record));
                        };

                        let listGrid = isc.ListGrid.nicico.createListGrid({

                            width: "100%",
                            height: "400",
                            sortField: 0,
                            showRowNumbers: true,
                            canAutoFitFields: false,
                            allowAdvancedCriteria: true,
                            alternateRecordStyles: true,
                            selectionType: "single",
                            sortDirection: "ascending",
                            canEdit: true,
                            editEvent: "doubleClick",
                            autoSaveEdits: true,
                            canRemoveRecords: true,
                            virtualScrolling: false,
                            showRecordComponents: true,
                            showRecordComponentsByCell: true,
                            recordComponentPoolingMode: "recycle",
                            listEndEditAction: "next",
                            gridComponents: ["header", "body", isc.ToolStrip.create({

                                width: "100%",
                                height: 24,
                                members: [
                                    isc.ToolStripButton.create({

                                        icon: "pieces/16/icon_add.png",
                                        title: "<spring:message code='global.add'/>",
                                        click: function () {

                                            listGrid.startEditingNew();
                                        }
                                    })
                                ]
                            })],

                        }, [Object.assign({
                            canEdit: true,
                            width: "100%",
                            required: true,
                            name: "values",
                            title: "<spring:message code='contract-detail-type.form.valid-values'/>"
                        }, defaultValueEditorProperties)]);
                        listGrid.setData(record[contractDetailTypeTab.dynamicForm.paramFields.values.name]);
                        contractDetailTypeTab.window.formUtil.showForm(
                            contractDetailTypeTab.window.detailType,
                            "<spring:message code='contract-detail-type.window.param-valid-value.define'/>",
                            listGrid, '400', '400');
                    }
                }
            }),
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

                        let defaultValueEditorProperties = contractDetailTypeTab.listGrid.param.getDefaultValueEditorProperties(
                            record[contractDetailTypeTab.dynamicForm.paramFields.type.name]);
                        if (defaultValueEditorProperties == null)
                            return;

                        contractDetailTypeTab.window.formUtil.populateData = function (body) {
                            return [body.getValues()];
                        };
                        contractDetailTypeTab.window.formUtil.validate = function (data) {
                            let form = contractDetailTypeTab.window.formUtil.bodyWidget.getObject();
                            form.validate();
                            return !form.hasErrors();
                        };
                        contractDetailTypeTab.window.formUtil.okCallBack = function (data) {
                            let selectedRecord = contractDetailTypeTab.listGrid.param.getSelectedRecord();
                            selectedRecord[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] = data[0]['defaultValue'];
                            contractDetailTypeTab.listGrid.param.refreshRow(contractDetailTypeTab.listGrid.param.getRecordIndex(record));
                        };

                        let dynamicForm = isc.DynamicForm.nicico.getDefault([Object.assign({
                            width: "100%",
                            name: "defaultValue",
                            title: "<spring:message code='global.default-value'/>"
                        }, defaultValueEditorProperties)]);
                        dynamicForm.setValue("defaultValue", record[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name]);
                        contractDetailTypeTab.window.formUtil.showForm(
                            contractDetailTypeTab.window.detailType,
                            "<spring:message code='contract-detail-type.window.param-default-value.define'/>",
                            dynamicForm, '400');
                    }
                }
            }),
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

                            contractDetailTypeTab.listGrid.param.saveAllEdits();
                        }
                    })]
            })
        ]
    })],
    cellChanged: function (record, newValue, oldValue, rowNum, colNum, grid) {

        if (newValue === oldValue)
            return;
        if (record[contractDetailTypeTab.dynamicForm.paramFields.values.name] == null &&
            record[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] == null)
            return;

        if (grid.fields[colNum].name === contractDetailTypeTab.dynamicForm.paramFields.type.name) {

            contractDetailTypeTab.dialog.say(
                "<spring:message code='contract-detail-type.window.param-data.reset'/>",
                "<spring:message code='global.warning'/>");
            record[contractDetailTypeTab.dynamicForm.paramFields.values.name] = null;
            record[contractDetailTypeTab.dynamicForm.paramFields.defaultValue.name] = null;
            contractDetailTypeTab.listGrid.param.refreshRow(contractDetailTypeTab.listGrid.param.getRecordIndex(record));
        }
    },
    getDefaultValueEditorProperties: function (paramType) {

        switch (paramType) {
            case 'PersianDate':
                return {
                    length: 10,
                    textAlign: "center",
                    type: 'persianDate',
                    icons: [persianDatePicker]
                };
            case 'GeorgianDate':
                return {
                    length: 10,
                    type: "date",
                    textAlign: "center",
                    format: 'DD-MM-YYYY'
                };
            case 'Boolean':
                return {
                    type: "boolean"
                };
            case 'Float':
            case 'Double':
                return {
                    type: "float",
                    keyPressFilter: "[0-9.]"
                };
            case 'Integer':
            case 'Long':
                return {
                    type: "integer",
                    keyPressFilter: "[0-9]"
                };
            case 'String':
                return {
                    type: "text",
                };
            case 'Column':
            default:
                break;
        }

        return null;
    }
});
contractDetailTypeTab.listGrid.template = isc.ListGrid.create({

    width: "100%",
    height: "100%",
    sortField: 0,
    showRowNumbers: true,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    sortDirection: "ascending",
    fields: BaseFormItems.concat([
        contractDetailTypeTab.dynamicForm.templateFields.content
    ]),
    canEdit: true,
    editEvent: "doubleClick",
    autoSaveEdits: false,
    canRemoveRecords: true,
    virtualScrolling: false,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    recordComponentPoolingMode: "recycle",
    listEndEditAction: "next",
    gridComponents: ["header", "body", isc.ToolStrip.create({

        width: "100%",
        height: 24,
        members: [
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

                            contractDetailTypeTab.listGrid.template.saveAllEdits();
                        }
                    })]
            })
        ]
    })],
    getDefaultHTMLValue: function (params) {

        let result = '';
        let rows = params.filter(q => q[contractDetailTypeTab.dynamicForm.paramFields.type.name] != 8);
        let columns = params.filter(q => q[contractDetailTypeTab.dynamicForm.paramFields.type.name] == 8);
        if (columns.length === 0) {

            for (let i = 0; i < params.length; i++) {

                if (params[i][contractDetailTypeTab.dynamicForm.paramFields.key.name] == null)
                    continue;

                result += '$';
                result += '{';
                result += params[i][contractDetailTypeTab.dynamicForm.paramFields.key.name];
                result += '}<br>';
            }

            return result;
        }

        result = '<table style="border: 1px solid black;border-collapse: collapse;">';
        for (let i = 0; i <= rows.length; i++) {

            result += '<tr>';

            for (let j = 0; j <= columns.length; j++) {

                if (i === 0)
                    result += j > 0 ?
                        '<th style="border: 1px solid black;border-collapse: collapse;">' + columns[j - 1][contractDetailTypeTab.dynamicForm.paramFields.key.name] + '</th>' :
                        '<th style="border: 1px solid black;border-collapse: collapse;"></th>';
                else if (j === 0)
                    result += '<td style="border: 1px solid black;border-collapse: collapse;">' + rows[i - 1][contractDetailTypeTab.dynamicForm.paramFields.key.name] + '</td>';
                else {

                    result += '<td style="border: 1px solid black;border-collapse: collapse;">';
                    result += '$';
                    result += '[';
                    result += rows[i - 1][contractDetailTypeTab.dynamicForm.paramFields.key.name];
                    result += ',';
                    result += columns[j - 1][contractDetailTypeTab.dynamicForm.paramFields.key.name];
                    result += ']';
                    result += '</td>';
                }
            }

            result += '</tr>';
        }
        result += '</table>';

        return result;
    },
    getEditorProperties: function (editField, editedRecord, rowNum) {

        return {

            height: 300,
            width: '100%',
            required: true,
            editorType: "RichTextItem",
            defaultValue: this.getDefaultHTMLValue(contractDetailTypeTab.listGrid.param.getAllData()),
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
    titleAlign: "right",
    numCols: 6,
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: BaseFormItems.concat([
        contractDetailTypeTab.dynamicForm.fields.code,
        contractDetailTypeTab.dynamicForm.fields.titleFa,
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
                let allParams = contractDetailTypeTab.listGrid.param.getAllData();
                let allTemplates = contractDetailTypeTab.listGrid.template.getAllData();

                for (let i = 0; i < allParams.length; i++)
                    allParams[i][contractDetailTypeTab.dynamicForm.paramFields.contractDetailTypeId.name] = data.id;
                data.params = allParams;

                for (let i = 0; i < allTemplates.length; i++)
                    allParams[i][contractDetailTypeTab.dynamicForm.templateFields.contractDetailTypeId.name] = data.id;
                data.templates = allTemplates;

                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: contractDetailTypeTab.variable.url,
                    httpMethod: contractDetailTypeTab.variable.method,
                    data: JSON.stringify(data),
                    callback: function (resp) {

                        if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                            contractDetailTypeTab.dialog.ok();
                            contractDetailTypeTab.method.refresh();
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

contractDetailTypeTab.window.detailType = isc.Window.nicico.getDefault(null, isc.VLayout.create({
    width: "100%",
    height: "100%",
    members: [
        contractDetailTypeTab.dynamicForm.detailType,
        contractDetailTypeTab.hLayout.extra,
        contractDetailTypeTab.hLayout.saveOrExitHlayout
    ]
}), "85%");

//*************************************************** Functions ********************************************************

contractDetailTypeTab.method.remove = function () {

    const record = contractDetailTypeTab.listGrid.detailType.getSelectedRecord();
    if (record == null || record.id == null)
        contractDetailTypeTab.dialog.notSelected();
    else if (record.editable === false)
        contractDetailTypeTab.dialog.notEditable();
    else
        contractDetailTypeTab.dialog.question(
            () => {
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: contractDetailTypeTab.variable.url + record.id,
                    httpMethod: "DELETE",
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            contractDetailTypeTab.method.refresh();
                            contractDetailTypeTab.dialog.ok();
                        } else {
                            contractDetailTypeTab.dialog.error(resp);
                        }
                    }
                }));
            });
}
contractDetailTypeTab.method.add = function () {
    contractDetailTypeTab.variable.method = "POST";
    contractDetailTypeTab.dynamicForm.detailType.clearValues();
    contractDetailTypeTab.window.detailType.setTitle("<spring:message code='contract-detail-type.window.title.add'/>");
    contractDetailTypeTab.window.detailType.show();
};
contractDetailTypeTab.method.refresh = function () {
    contractDetailTypeTab.listGrid.detailType.invalidateCache();
}
contractDetailTypeTab.method.edit = function () {

    let record = contractDetailTypeTab.listGrid.detailType.getSelectedRecord();
    if (record == null || record.id == null)
        contractDetailTypeTab.dialog.notSelected();
    else if (record.editable === false)
        contractDetailTypeTab.dialog.notEditable();
    else {
        contractDetailTypeTab.variable.method = "PUT";
        contractDetailTypeTab.dynamicForm.detailType.editRecord(JSON.parse(JSON.stringify(record)))
        contractDetailTypeTab.window.detailType.setTitle("<spring:message code='contract-detail-type.window.title.edit'/>");
        contractDetailTypeTab.window.detailType.show();
    }
};

//*************************************************** layout ***********************************************************

contractDetailTypeTab.toolStrip.add = isc.ToolStripButtonAdd.create({
    title: "<spring:message code='global.form.new'/>",
    click: function () {
        contractDetailTypeTab.method.add();
    }
});
contractDetailTypeTab.toolStrip.refresh = isc.ToolStripButtonRefresh.create({
    title: "<spring:message code='global.form.refresh'/>",
    click: function () {
        contractDetailTypeTab.method.refresh();
    }
});
contractDetailTypeTab.toolStrip.remove = isc.ToolStripButtonRemove.create({
    icon: "[SKIN]/actions/remove.png",
    title: '<spring:message code="global.form.remove" />',
    click: function () {
        contractDetailTypeTab.method.remove();
    }
});
contractDetailTypeTab.toolStrip.edit = isc.ToolStripButtonEdit.create({
    icon: "[SKIN]/actions/edit.png",
    title: "<spring:message code='global.form.edit'/>",
    click: function () {
        contractDetailTypeTab.method.edit();
    }
});
contractDetailTypeTab.toolStrip.actions = isc.ToolStrip.create({
    width: "100%",
    members: [
        contractDetailTypeTab.toolStrip.add,
        contractDetailTypeTab.toolStrip.edit,
        contractDetailTypeTab.toolStrip.remove,
        isc.ToolStrip.create({
            width: "100%",
            align: "left",
            border: '0px',
            members: [
                contractDetailTypeTab.toolStrip.refresh,
            ]
        })
    ]
});
contractDetailTypeTab.vLayout.body = isc.VLayout.create({

    width: "100%",
    height: "100%",
    members: [contractDetailTypeTab.toolStrip.actions, contractDetailTypeTab.listGrid.detailType]
});