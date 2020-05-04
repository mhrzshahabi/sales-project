var contractDetailTypeTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractDetailTypeTab.variable.url = "${contextPath}" + "/api/contract-detail-type/";
contractDetailTypeTab.variable.unitUrl = "${contextPath}" + "/api/unit/";
contractDetailTypeTab.variable.paramUrl = "${contextPath}" + "/api/contract-detail-type-param/";
contractDetailTypeTab.variable.templateUrl = "${contextPath}" + "/api/contract-detail-type-template/";

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
    editorType: "RichTextItem",
    editorProperties: {height: 200},
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
    // initialCriteria: {},
    sortField: 0,
    dataPageSize: 50,
    fetchDelay: 1000,
    autoFetchData: true,
    showRowNumbers: true,
    showFilterEditor: true,
    filterOnKeypress: false,
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
    ]),
    canEdit: true,
    editEvent: "click",
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

                icon: "pieces/16/icon_edit.png",
                title: "<spring:message code='global.edit'/>",
                click: function () {

                    let record = contractDetailTypeTab.listGrid.param.getSelectedRecord();
                    if (record == null || record.id == null)
                        contractDetailTypeTab.dialog.notSelected();
                    else if (record.editable === false)
                        contractDetailTypeTab.dialog.notEditable();
                    else {

                        let recordIndex = contractDetailTypeTab.listGrid.param.data.indexOf(record);
                        contractDetailTypeTab.listGrid.param.startEditing(recordIndex);
                    }
                }
            })
        ]
    })]
});
contractDetailTypeTab.listGrid.template = isc.ListGrid.create({

    width: "100%",
    height: "100%",
    // initialCriteria: {},
    sortField: 0,
    dataPageSize: 50,
    fetchDelay: 1000,
    autoFetchData: true,
    showRowNumbers: true,
    showFilterEditor: true,
    filterOnKeypress: false,
    canAutoFitFields: false,
    allowAdvancedCriteria: true,
    alternateRecordStyles: true,
    selectionType: "single",
    sortDirection: "ascending",
    fields: BaseFormItems.concat([
        contractDetailTypeTab.dynamicForm.templateFields.content
    ]),
    canEdit: true,
    editEvent: "none",
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
                    contractDetailTypeTab.listGrid.template.startEditingNew();
                }
            }),
            isc.ToolStripButton.create({

                icon: "pieces/16/icon_edit.png",
                title: "<spring:message code='global.edit'/>",
                click: function () {

                    let record = contractDetailTypeTab.listGrid.template.getSelectedRecord();
                    if (record == null || record.id == null)
                        contractDetailTypeTab.dialog.notSelected();
                    else if (record.editable === false)
                        contractDetailTypeTab.dialog.notEditable();
                    else {

                        let recordIndex = contractDetailTypeTab.listGrid.template.data.indexOf(record);
                        contractDetailTypeTab.listGrid.template.startEditing(recordIndex);
                    }
                }
            })
        ]
    })],
    getEditorProperties: function (editField) {

        return {
            editorProperties: {
                height: 200,
                width: "100%",
                height: 200,
                autoDraw:false,
                overflow:"hidden",
                canDragResize:true,
                required: true,
                selectOnClick: true,
                name: "content",
                editorType: "RichTextItem"
            },
            controlGroups: ["fontControls", "formatControls", "styleControls", "colorControls", "listControls", "tableControls"],
            keyPress: function () {

                console.log('key', isc.EventHandler.getKey());
                if (isc.EventHandler.ctrlKeyDown() && isc.EventHandler.getKey() === "enter") {
                    this.rowEditorExit();
                    return false;
                }
                return true
            }
            // changed: function (form, item, value) {
            //
            //     if (value == null) {
            //         value = 0;
            //         item.grid.setEditValue(item.grid.getEditRow(), item.grid.getFieldNum("DDT_DEBIT"), value);
            //     }
            //     if (value == 0) {
            //         item.grid.setEditValue(item.grid.getEditRow(), item.grid.getFieldNum("DDT_CREDIT"), tmpVal);
            //         item.grid.setEditValue(item.grid.getEditRow(), item.grid.getFieldNum("DDT_DEBIT"), value);
            //     } else {
            //         item.grid.setEditValue(item.grid.getEditRow(), item.grid.getFieldNum("DDT_DEBIT"), value);
            //         item.grid.setEditValue(item.grid.getEditRow(), item.grid.getFieldNum("DDT_CREDIT"), '0');
            //         tmpVal = value;
            //     }
            // },
            // formatEditorValue(value, record, form, item) {
            //     if (value == null)
            //         value = 0;
            //     // return NumberUtil.format(parseFloat(value),",0");
            //     return value;
            // },
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
    requiredMessage: '<spring:message code="validator.field.is.required" />',
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
                if (contractDetailTypeTab.dynamicForm.detailType.hasErrors())
                    return;
                var data = contractDetailTypeTab.dynamicForm.detailType.getValues();

                contractDetailTypeTab.listGrid.param.saveAllEdits();
                contractDetailTypeTab.listGrid.template.saveAllEdits();


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
}), "70%");

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

    var record = contractDetailTypeTab.listGrid.detailType.getSelectedRecord();
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
