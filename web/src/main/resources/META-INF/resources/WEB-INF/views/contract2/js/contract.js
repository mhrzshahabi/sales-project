var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/"
contractTab.variable.contractDetailTypeUrl = "${contextPath}" + "/api/contract-detail-type/"
contractTab.dynamicForm.fields.no = {
    name: "no",
    width: "100%",
    required: true,
    keyPressFilter: "^[A-Za-z0-9]",
    title: "<spring:message code='contract.form.no'/>"
};
contractTab.dynamicForm.fields.date = {
    name: "date",
    type: "date",
    formatCellValue: function (value, record, rowNum, colNum, grid) {
        return new Date(value);
    },
    width: "100%",
    required: true,
    title: "<spring:message code='global.date'/>"
};
contractTab.dynamicForm.fields.affectFrom = {
    name: "affectFrom",
    type: "date",
    width: "100%",
    required: true,
    title: "affectFrom"
};
contractTab.dynamicForm.fields.affectUpTo = {
    name: "affectUpTo",
    type: "date",
    width: "10%",
    required: true,
    title: "affectUpTo"
};
contractTab.dynamicForm.fields.content = {
    name: "content",
    width: "100%",
    required: true,
    title: "<spring:message code='global.content'/>"
};
contractTab.dynamicForm.fields.description = {
    name: "description",
    width: "100%",
    required: true,
    title: "<spring:message code='global.description'/>"
};
contractTab.dynamicForm.fields.material = {
    name: "materialId",
    width: "100%",
    editorType: "SelectItem",
    optionDataSource: isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "code", title: "<spring:message code='goods.code'/> "},
            {name: "descl"},
            {name: "unitId"},
            {name: "unit.nameEN"}
        ],
        fetchDataURL: "${contextPath}/api/material/spec-list"
    }),
    autoFetchData: false,
    displayField: "descl",
    valueField: "id",
    required: true,
    title: "<spring:message code='material.title'/>"
};
contractTab.dynamicForm.fields.contractType = {
    name: "contractTypeId",
    width: "100%",
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
    autoFetchData: false,
    displayField: "titleEn",
    valueField: "id",
    required: true,
    title: "<spring:message code='entity.contract-type'/>"
};

contractTab.dynamicForm.fields.buyer = getContactByType("buyer");
contractTab.dynamicForm.fields.seller = getContactByType("seller");
contractTab.dynamicForm.fields.agentBuyer = getContactByType("agentBuyer");
contractTab.dynamicForm.fields.agentSeller = getContactByType("agentSeller");

contractTab.dynamicForm.fields.contractDetailType = {
    name: "contractDetailTypeId",
    width: "100%",
    editorType: "SelectItem",
    optionCriteria: {
        operator: 'and',
        criteria: [{
            fieldName: 'materialId',
            operator: 'equals'
        }]
    },
    optionDataSource: isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "titleEn"}
        ],
        fetchDataURL: contractTab.variable.contractDetailTypeUrl + "spec-list"
    }),
    autoFetchData: false,
    displayField: "titleEn",
    valueField: "id",
    required: false,
    title: "<spring:message code='entity.contract-detail-type'/>",
    changed: function (form, item, value) {
        if (contractTab.contractDetailsSectionStack.getSectionNames().includes(value))
            return;

        var record = item.getSelectedRecord();

        var sectionStackSectionObj = {
            contractDetailId: null,
            name: value,
            title: record.titleEn,
            expanded: false,
            controls: [isc.IButton.create({
                width: 150,
                icon: "[SKIN]/actions/remove.png",
                size: 32,
                click: function () {
                    contractTab.contractDetailsSectionStack.removeSection(record.id + "");
                }
            })],
            items: []
        };

        var dynamicFormField = [];
        record.contractDetailTypeParams.filter(param => param.type !== "ListOfReference").forEach(param => {
            var field = {
                width: "100%",
            };
            field.name = param.key;
            field.key = param.key;
            field.title = param.name;
            field.paramType = param.type;
            field.reference = param.reference;
            field.defaultValue = param.defaultValue;
            field.required = param.required;

            Object.assign(field, getFieldProperties(field.paramType, field.reference));

            dynamicFormField.push(field);
        });

        var contractDetailDynamicForm = isc.DynamicForm.create({
            visibility: "hidden",
            width: "100%",
            align: "center",
            titleAlign: "right",
            numCols: 8,
            margin: 10,
            canSubmit: true,
            showErrorText: true,
            showErrorStyle: true,
            showInlineErrors: true,
            errorOrientation: "bottom",
            requiredMessage: '<spring:message code="validator.field.is.required"/>',
            fields: BaseFormItems.concat(dynamicFormField, true)
        })

        sectionStackSectionObj.items.push(contractDetailDynamicForm);

        record.contractDetailTypeParams.filter(param => param.type == "ListOfReference").forEach(param => {
            var listOfReferenceListGridId = 'listOfReferenceListGridId_' + Math.random().toString().substring(2, 8);
            var contractDetailListGrid = isc.ListGrid.create({
                ID: listOfReferenceListGridId,
                width: "100%",
                height: 300,
                sortField: 1,
                showRowNumbers: true,
                canAutoFitFields: false,
                allowAdvancedCriteria: true,
                alternateRecordStyles: true,
                selectionType: "single",
                sortDirection: "ascending",
                fields: getReferenceFields(param.reference),
                canEdit: true,
                editEvent: "doubleClick",
                autoSaveEdits: false,
                virtualScrolling: false,
                showRecordComponents: true,
                showRecordComponentsByCell: true,
                recordComponentPoolingMode: "recycle",
                listEndEditAction: "next",
                canRemoveRecords: true,
                gridComponents: ["header", "body", isc.ToolStrip.create({
                    width: "100%",
                    height: 24,
                    members: [
                        isc.ToolStripButton.create({
                            icon: "pieces/16/icon_add.png",
                            title: "<spring:message code='global.add'/>",
                            click: function () {
                                contractDetailListGrid.startEditingNew();
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
                                        contractDetailListGrid.saveAllEdits();
                                    }
                                })]
                        })
                    ]
                })]
            })
            sectionStackSectionObj.items.push(contractDetailListGrid);
        });
        contractTab.contractDetailsSectionStack.addSection(sectionStackSectionObj);
    }
}

contractTab.dynamicForm.materialDynamicForm = isc.DynamicForm.create({
    width: "100%",
    height: "100%",
    align: "center",
    titleAlign: "right",
    numCols: 2,
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: BaseFormItems.concat([
        contractTab.dynamicForm.fields.material
    ], true)
});

contractTab.dynamicForm.contract = isc.DynamicForm.create({
    width: "100%",
    height: "10%",
    align: "center",
    titleAlign: "right",
    numCols: 8,
    margin: 10,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: BaseFormItems.concat([
        contractTab.dynamicForm.fields.no,
        contractTab.dynamicForm.fields.date,
        contractTab.dynamicForm.fields.affectFrom,
        contractTab.dynamicForm.fields.affectUpTo,
        contractTab.dynamicForm.fields.content,
        contractTab.dynamicForm.fields.description,
        contractTab.dynamicForm.fields.contractType,
        contractTab.dynamicForm.fields.buyer,
        contractTab.dynamicForm.fields.seller,
        contractTab.dynamicForm.fields.agentBuyer,
        contractTab.dynamicForm.fields.agentSeller,
        contractTab.dynamicForm.fields.contractDetailType
    ], true)
});

contractTab.restDataSource = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
        contractTab.dynamicForm.fields.no,
        contractTab.dynamicForm.fields.date,
        contractTab.dynamicForm.fields.material,
        contractTab.dynamicForm.fields.contractType,
        contractTab.dynamicForm.fields.buyer,
        contractTab.dynamicForm.fields.seller,
        contractTab.dynamicForm.fields.agentBuyer,
        contractTab.dynamicForm.fields.agentSeller
    ], true),
    fetchDataURL: contractTab.variable.contractUrl + "spec-list"
});

contractTab.listGrid.contract = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    autoFetchData: true,
    showRowNumbers: true,
    showFilterEditor: true,
    dataSource: contractTab.restDataSource
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
        isc.IButtonSave.create({
            top: 260,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {
                contractTab.dynamicForm.contract.validate();
                if (contractTab.dynamicForm.contract.hasErrors())
                    return;
                let data = contractTab.dynamicForm.contract.getValues();

                data.contractDetails = [];
                contractTab.contractDetailsSectionStack.sections.forEach(q => {
                    var contractDetailObj = {
                        contractDetailTypeId: q.name,
                        id: q.contractDetailId,
                        contractDetailValues: []
                    };

                    // dynamicForm
                    q.items[0].fields.filter(x => x.isBaseItem == undefined).forEach(x => {
                        contractDetailObj.contractDetailValues.push({
                            id: x.contractDetailValueId,
                            name: x.name,
                            key: x.key,
                            title: x.title,
                            reference: x.reference,
                            type: x.paramType,
                            value: q.items[0].values[x.name],
                            unitId: x.unitId,
                            required: (x.required == undefined) ? false : x.required,
                            contractDetailId: q.contractDetailId,
                            estatus: x.estatus,
                            editable: x.editable
                        });
                    });

                    /*//listGrid
                    q.items[1].getAllData().filter(x => x.isBaseItem == undefined).forEach(x => {
                        contractDetailObj.contractDetailValues.push({
                            id: x.contractDetailValueId,
                            name: "Contract Shipment",
                            key: "ContractShipment",
                            reference: "ContractShipment",
                            type: "ListOfReference",
                            value: x.id,
                            referenceJsonValue: JSON.stringify(x),
                            unitId: null,
                            required: false,
                            contractDetailId: q.contractDetailId
                            // estatus: x.estatus,
                            // editable: x.editable
                        });
                    });*/

                    data.contractDetails.push(contractDetailObj);
                });

                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: contractTab.variable.contractUrl,
                    httpMethod: contractTab.variable.method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                            contractTab.dialog.ok();
                            contractTab.method.refreshData();
                            contractTab.window.close();
                        } else
                            contractTab.window.dialog.error(resp);
                    }
                }))
            }
        }),
        isc.IButtonCancel.create({

            width: 100,
            orientation: "vertical",
            icon: "pieces/16/icon_delete.png",
            title: "<spring:message code='global.close'/>",
            click: function () {
                contractTab.window.close();
            }
        })
    ]
});

contractTab.contractDetailsSectionStack = isc.SectionStack.create({
    visibilityMode: "multiple",
    width: "100%",
    height: "85%",
    sections: []
});

contractTab.window = isc.Window.nicico.getDefault(null, [
    contractTab.dynamicForm.contract,
    contractTab.contractDetailsSectionStack,
    contractTab.hLayout.saveOrExitHlayout
], "100%", 0.95 * innerHeight);

contractTab.window.materialWindow = isc.Window.nicico.getDefault("<spring:message code='material.title'/>", [
        contractTab.dynamicForm.materialDynamicForm,
        isc.HLayout.create({
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
                        contractTab.dynamicForm.materialDynamicForm.validate();
                        if (contractTab.dynamicForm.materialDynamicForm.hasErrors())
                            return;
                        contractTab.variable.method = "POST";
                        contractTab.dynamicForm.contract.clearValues();
                        contractTab.dynamicForm.contract.editRecord(contractTab.dynamicForm.materialDynamicForm.getValues());
                        contractTab.contractDetailsSectionStack.getSectionNames().forEach(q => contractTab.contractDetailsSectionStack.removeSection(q + ""));
                        contractTab.window.setTitle("<spring:message code='contract.window.title.add'/>" + "\t" +
                            contractTab.dynamicForm.materialDynamicForm.getFields()[1].getSelectedRecord().descl
                        );
                        contractTab.dynamicForm.fields.contractDetailType.optionCriteria.criteria[0].value = contractTab.dynamicForm.contract.getValues().materialId;
                        contractTab.window.materialWindow.close();
                        contractTab.window.show();
                    }
                }),
                isc.IButtonCancel.create({
                    width: 100,
                    orientation: "vertical",
                    icon: "pieces/16/icon_delete.png",
                    title: "<spring:message code='global.close'/>",
                    click: function () {
                        contractTab.window.materialWindow.close();
                    }
                })
            ]
        })
    ],
    300, null
);

//*************************************************** Functions ********************************************************

contractTab.method.editData = function () {

    let record = contractTab.listGrid.contract.getSelectedRecord();
    if (record == null || record.id == null)
        contractTab.dialog.notSelected();
    else if (record.editable === false)
        contractTab.dialog.notEditable();
    else {
        contractTab.variable.method = "PUT";
        contractTab.dynamicForm.contract.editRecord(JSON.parse(JSON.stringify(record)));

        contractTab.contractDetailsSectionStack.getSectionNames().forEach(q => contractTab.contractDetailsSectionStack.removeSection(q + ""));

        record.contractDetails.forEach(q => {
            var dynamicFormFields = [];

            // DynamicForm
            q.contractDetailValues.filter(x => x.type !== 'ListOfReference').forEach(detailValue => {
                var field = {
                    width: "100%",
                };
                field.name = detailValue.key;
                field.key = detailValue.key;
                field.title = detailValue.title;
                field.paramType = detailValue.type;
                field.reference = detailValue.reference;
                field.defaultValue = detailValue.value;
                if (field.defaultValue == "false")
                    field.defaultValue = false;
                if (field.defaultValue == "true")
                    field.defaultValue = true;
                field.required = detailValue.required;
                field.contractDetailValueId = detailValue.id;
                field.estatus = detailValue.estatus;
                field.editable = detailValue.editable;

                Object.assign(field, getFieldProperties(field.paramType, field.reference));

                dynamicFormFields.push(field);
            })

            // var listOfReferenceListGridId = 'listOfReferenceEditDataListGridId_' + Math.random().toString().substring(2, 8);
            contractTab.contractDetailsSectionStack.addSection({
                contractDetailId: q.id,
                name: q.contractDetailTypeId,
                title: q.contractDetailType.titleEn,
                expanded: false,

                controls: [isc.IButton.create({
                    width: 150,
                    icon: "[SKIN]/actions/remove.png",
                    size: 32,
                    click: function () {
                        contractTab.contractDetailsSectionStack.removeSection(q.contractDetailTypeId + "");
                    }
                })],

                items: [
                    isc.DynamicForm.create({
                        visibility: "hidden",
                        width: "100%",
                        height: "100%",
                        align: "center",
                        titleAlign: "right",
                        numCols: 8,
                        margin: 10,
                        canSubmit: true,
                        showErrorText: true,
                        showErrorStyle: true,
                        showInlineErrors: true,
                        errorOrientation: "bottom",
                        requiredMessage: '<spring:message code="validator.field.is.required"/>',
                        fields: BaseFormItems.concat(dynamicFormFields, true)
                    })/*,
                    isc.ListGrid.create({
                        ID: listOfReferenceListGridId,
                        width: "100%",
                        height: 150,
                        sortField: 1,
                        showRowNumbers: true,
                        canAutoFitFields: false,
                        allowAdvancedCriteria: true,
                        alternateRecordStyles: true,
                        selectionType: "single",
                        sortDirection: "ascending",
                        fields: getReferenceFields('ContractShipment'),
                        canEdit: true,
                        editEvent: "doubleClick",
                        autoSaveEdits: false,
                        virtualScrolling: false,
                        showRecordComponents: true,
                        showRecordComponentsByCell: true,
                        recordComponentPoolingMode: "recycle",
                        listEndEditAction: "next",
                        canRemoveRecords: true,
                        gridComponents: ["header", "body", isc.ToolStrip.create({
                            width: "100%",
                            height: 24,
                            members: [
                                isc.ToolStripButton.create({
                                    icon: "pieces/16/icon_add.png",
                                    title: "<spring:message code='global.add'/>",
                                    click: function () {
                                        window[listOfReferenceListGridId].startEditingNew();
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
                                                window[listOfReferenceListGridId].saveAllEdits();
                                            }
                                        })]
                                })
                            ]
                        })]
                    })*/
                ]
            });
            /*isc.MyRestDataSource.create({
                fields: getReferenceFields("ContractShipment"),
                fetchDataURL: "${contextPath}/api/contractShipment/spec-list"
            }).fetchData({
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [
                        {fieldName: "contractId", operator: "equals", value: 1},
                    ]
                }, function (dsResponse, data) {
                    window[listOfReferenceListGridId].setData(data);

                    q.contractDetailValues.filter(x => x.type == 'ListOfReference').forEach((detailValue, index) => {
                        data[index].contractDetailValueId = detailValue.id;
                    })
                }
            )*/
        });

        contractTab.window.setTitle("<spring:message code='contract.window.title.edit'/>" + "\t" + record.material.descl);
        contractTab.window.show();
    }
};

contractTab.method.refreshData = function () {
    contractTab.listGrid.contract.invalidateCache();
};
contractTab.method.deleteRecord = function () {

    const record = contractTab.listGrid.contract.getSelectedRecord();
    if (record == null || record.id == null)
        contractTab.dialog.notSelected();
    else if (record.editable === false)
        contractTab.dialog.notEditable();
    else
        contractTab.dialog.question(
            () => {
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: contractTab.variable.contractUrl + record.id,
                    httpMethod: "DELETE",
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            contractTab.method.refreshData();
                            contractTab.dialog.ok();
                        } else {
                            contractTab.dialog.error(resp);
                        }
                    }
                }));
            });
};

//*************************************************** layout ***********************************************************

contractTab.toolStrip.actions = isc.ToolStrip.create({
    width: "100%",
    members: []
});
// <sec:authorize access="hasAuthority('C_CONTRACT2')">
contractTab.toolStrip.add = isc.ToolStripButtonAdd.create({
    title: "<spring:message code='global.form.new'/>",
    click: function () {
        contractTab.dynamicForm.materialDynamicForm.clearValues();
        contractTab.window.materialWindow.show();
    }
});
contractTab.toolStrip.actions.addMember(contractTab.toolStrip.add);
// </sec:authorize>
// <sec:authorize access="hasAuthority('U_CONTRACT2')">
contractTab.toolStrip.edit = isc.ToolStripButtonEdit.create({
    icon: "[SKIN]/actions/edit.png",
    title: "<spring:message code='global.form.edit'/>",
    click: function () {
        contractTab.method.editData();
    }
});
contractTab.toolStrip.actions.addMember(contractTab.toolStrip.edit);
// </sec:authorize>
// <sec:authorize access="hasAuthority('D_CONTRACT2')">
contractTab.toolStrip.remove = isc.ToolStripButtonRemove.create({
    icon: "[SKIN]/actions/remove.png",
    title: '<spring:message code="global.form.remove" />',
    click: function () {
        contractTab.method.deleteRecord();
    }
});
contractTab.toolStrip.actions.addMember(contractTab.toolStrip.remove);
// </sec:authorize>
contractTab.toolStrip.refresh = isc.ToolStripButtonRefresh.create({
    title: "<spring:message code='global.form.refresh'/>",
    click: function () {
        contractTab.method.refreshData();
    }
});
contractTab.toolStrip.actions.addMember(isc.ToolStrip.create({
    width: "100%",
    align: "left",
    border: '0px',
    members: [contractTab.toolStrip.refresh]
}));

contractTab.vLayout.body = isc.VLayout.create({
    width: "100%",
    height: "100%",
    members: [contractTab.toolStrip.actions, contractTab.listGrid.contract]
});
