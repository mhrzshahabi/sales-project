var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/"
contractTab.variable.contractDetailUrl = "${contextPath}" + "/api/contract-detail/"
contractTab.variable.contractDetailTypeUrl = "${contextPath}" + "/api/contract-detail-type/"

//*************************************************** RESTDATASOURCES **************************************************

contractTab.restDataSource.contractDetail = isc.MyRestDataSource.create({
    fields: [
        {name: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
        {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
    ],
    fetchDataURL: contractTab.variable.contractDetailUrl + "spec-list"
});
contractTab.restDataSource.contractDetailType = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey: true, hidden: true},
        {name: "titleEn"}
    ],
    fetchDataURL: contractTab.variable.contractDetailTypeUrl + "spec-list"
});

//******************************************************* FORMITEMS ****************************************************

contractTab.dynamicForm.fields = BaseFormItems.concat([
    {
        useInGrid: true,
        name: "no",
        width: "100%",
        required: false,
        editorType: "StaticText",
        title: "<spring:message code='contract.form.no'/>"
    },
    {
        useInGrid: true,
        name: "date",
        type: "date",
        formatCellValue: function (value, record, rowNum, colNum, grid) {
            return new Date(value);
        },
        width: "100%",
        required: true,
        title: "<spring:message code='global.date'/>"
    },
    {
        name: "affectFrom",
        type: "date",
        width: "100%",
        required: true,
        title: "affectFrom"
    },
    {
        name: "affectUpTo",
        type: "date",
        width: "10%",
        required: true,
        title: "affectUpTo"
    },
    {
        useInGrid: true,
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
        title: "<spring:message code='material.title'/>",
        changed: function (form, item, value) {

            contractTab.listGrid.contractDetailType.setCriteria({
                operator: 'and',
                criteria: [{
                    fieldName: 'materialId',
                    operator: 'equals',
                    value: value
                }]
            });
        }
    },
    {
        useInGrid: true,
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
    },
    Object.assign(getContactByType("buyer"), {useInGrid: true}),
    Object.assign(getContactByType("seller"), {useInGrid: true}),
    Object.assign(getContactByType("agentBuyer"), {useInGrid: true}),
    Object.assign(getContactByType("agentSeller"), {useInGrid: true}),
    {
        colSpan: 8,
        width: "100%",
        required: true,
        type: "TextArea",
        name: "description",
        title: "<spring:message code='global.description'/>"
    }
]);
Object.assign(contractTab.listGrid.fields, contractTab.dynamicForm.fields.filter(field => field.useInGrid));

//******************************************************* COMPONENTS ***************************************************

nicico.BasicFormUtil.createListGrid = function () {

    contractTab.listGrid.main = isc.ListGrid.nicico.getDefault(
        contractTab.listGrid.fields,
        contractTab.restDataSource.main,
        contractTab.listGrid.criteria,
        {
            showFilterEditor: true,
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
            getExpansionComponent: function (record) {

                let criteria = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "contractId", operator: "equals", value: record.id}]
                };
                contractTab.listGrid.contractDetail.fetchData(criteria, function (dsResponse, data, dsRequest) {
                    if (data == null || data.length === 0)
                        contractTab.listGrid.contractDetail.hide();
                    else {
                        contractTab.listGrid.contractDetail.setData(data);
                        contractTab.listGrid.contractDetail.setAutoFitMaxRecords(1);
                        contractTab.listGrid.contractDetail.show();
                    }
                }, {operationId: "00"});
                return contractTab.listGrid.contractDetail;
            }
        });
};
nicico.BasicFormUtil.createDynamicForm = function (creator) {

    contractTab.dynamicForm.main = isc.DynamicForm.create({
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
        fields: contractTab.dynamicForm.fields,
        requiredMessage: '<spring:message code="validator.field.is.required"/>'
    });
};
contractTab.listGrid.contractDetail = isc.ListGrid.nicico.getDefault(
    null,
    contractTab.restDataSource.contractDetail, null,
    {
        height: 180,
        width: "100%",
        styleName: "listgrid-child",
        autoFetchData: false,
        showFilterEditor: true,
    });

contractTab.listGrid.contractDetailType = isc.ListGrid.nicico.getDefault(
    [
        {name: "id", primaryKey: true, hidden: true, title: '<spring:message code="global.id"/>'},
        {name: "code", title: '<spring:message code="global.code"/>'},
        {name: "titleFa", title: '<spring:message code="global.title-fa"/>'},
        {name: "titleEn", title: '<spring:message code="global.title-en"/>'},
        {width: 40, name: "addIcon", align: "center", showTitle: false, canFilter: false}
    ],
    contractTab.restDataSource.contractDetailType,
    {
        operator: 'and',
        criteria: [{
            fieldName: 'materialId',
            operator: 'equals',
            value: null
        }]
    }, {
        width: "30%",
        showFilterEditor: true,
        showRecordComponents: true,
        setAutoFitExtraRecords: true,
        showRecordComponentsByCell: true,
        createRecordComponent: function (record, colNum) {

            var fieldName = this.getFieldName(colNum);
            if (fieldName === "addIcon") {

                let recordCanvas = isc.HLayout.create(
                    {
                        width: "100%",
                        align: "center"
                    });
                return isc.ImgButton.create(
                    {
                        width: 16,
                        height: 16,
                        grid: this,
                        showDown: false,
                        showRollOver: false,
                        layoutAlign: "center",
                        src: "pieces/16/icon_add.png",
                        prompt: '<spring:message code="global.form.add"/>',
                        click: function () {

                            if (contractTab.sectionStack.contract.getSectionNames().includes(record.id))
                                return;

                            let sectionStackSectionObj = {
                                name: record.id,
                                title: record.titleEn,
                                expanded: false,
                                contractDetailId: null,
                                controls: [isc.IButton.create({
                                    width: 150,
                                    icon: "[SKIN]/actions/remove.png",
                                    size: 32,
                                    click: function () {
                                        contractTab.sectionStack.contract.removeSection(record.id + "");
                                    }
                                })],
                                items: []
                            };

                            let dynamicFormField = [];
                            record.contractDetailTypeParams.filter(param => param.type !== "ListOfReference").forEach(param => {
                                let field = {
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

                            let contractDetailDynamicForm = isc.DynamicForm.create({
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

                            record.contractDetailTypeParams.filter(param => param.type === "ListOfReference").forEach(param => {
                                let listOfReferenceListGridId = 'listOfReferenceListGridId_' + Math.random().toString().substring(2, 8);
                                let contractDetailListGrid = isc.ListGrid.create({
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
                            contractTab.sectionStack.contract.addSection(sectionStackSectionObj);
                        }
                    });
            }

            return null;
        }
    });
contractTab.sectionStack.contract = isc.SectionStack.create({
    visibilityMode: "multiple",
    margin: 15,
    width: "100%",
    overflow: "auto",
    sections: []
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
                contractTab.dynamicForm.main.validate();
                if (contractTab.dynamicForm.main.hasErrors())
                    return;
                let data = contractTab.dynamicForm.main.getValues();

                data.contractDetails = [];
                contractTab.sectionStack.contract.sections.forEach(q => {
                    let contractDetailObj = {
                        contractDetailTypeId: q.name,
                        id: q.contractDetailId,
                        contractDetailValues: []
                    };

                    // dynamicForm
                    q.items[0].fields.filter(x => x.isBaseItem == null).forEach(x => {
                        contractDetailObj.contractDetailValues.push({
                            id: x.contractDetailValueId,
                            name: x.name,
                            key: x.key,
                            title: x.title,
                            reference: x.reference,
                            type: x.paramType,
                            value: q.items[0].values[x.name],
                            unitId: x.unitId,
                            required: (x.required == null) ? false : x.required,
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
                            contractTab.method.refresh(contractTab.listGrid.main);
                            contractTab.window.main.close();
                        } else
                            contractTab.dialog.error(resp);
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
                contractTab.window.main.close();
            }
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
        contractTab.sectionStack.contract
    ]
});
nicico.BasicFormUtil.getDefaultBasicForm(contractTab, "api/g-contract/", (creator) => {
    contractTab.window.main = isc.Window.nicico.getDefault(null, [
        contractTab.dynamicForm.main,
        contractTab.hLayout.contractDetailHlayout,
        contractTab.hLayout.saveOrExitHlayout
    ], "100%", 0.95 * innerHeight);
});
contractTab.sectionStack.mainSection = isc.SectionStack.create({
    width: "100%",
    height: "100%",
    overflow: "hidden",
    visibilityMode: "multiple",
    animateSections: true,
    sections: [{
        expanded: true,
        showHeader: false,
        items: contractTab.vLayout.main
    }, {
        hidden: true,
        expanded: false,
        items: contractTab.listGrid.contractDetail
    }]
});

//*************************************************** Functions ********************************************************

contractTab.method.newForm = function () {

    contractTab.variable.method = "POST";
    contractTab.dynamicForm.main.clearValues();
    contractTab.sectionStack.contract.clear();
    contractTab.listGrid.contractDetailType.setCriteria({
        operator: 'and',
        criteria: [{
            fieldName: 'materialId',
            operator: 'equals',
            value: null
        }]
    });
    contractTab.window.main.show();
};
contractTab.method.editForm = function () {

    let record = contractTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        contractTab.dialog.notSelected();
    else if (record.editable === false)
        contractTab.dialog.notEditable();
    else {
        contractTab.variable.method = "PUT";
        contractTab.dynamicForm.main.editRecord(JSON.parse(JSON.stringify(record)));

        contractTab.sectionStack.contract.getSectionNames().forEach(q => contractTab.sectionStack.contract.removeSection(q + ""));

        contractTab.listGrid.contractDetailType.setCriteria({
            operator: 'and',
            criteria: [{
                fieldName: 'materialId',
                operator: 'equals',
                value: contractTab.dynamicForm.main.getValue('materialId')
            }]
        });
        record.contractDetails.forEach(q => {
            let dynamicFormFields = [];

            // DynamicForm
            q.contractDetailValues.filter(x => x.type !== 'ListOfReference').forEach(detailValue => {
                let field = {
                    width: "100%",
                };
                field.name = detailValue.key;
                field.key = detailValue.key;
                field.title = detailValue.title;
                field.paramType = detailValue.type;
                field.reference = detailValue.reference;
                field.defaultValue = detailValue.value;
                if (field.defaultValue === "false")
                    field.defaultValue = false;
                if (field.defaultValue === "true")
                    field.defaultValue = true;
                field.required = detailValue.required;
                field.contractDetailValueId = detailValue.id;
                field.estatus = detailValue.estatus;
                field.editable = detailValue.editable;

                Object.assign(field, getFieldProperties(field.paramType, field.reference));

                dynamicFormFields.push(field);
            })

            // let listOfReferenceListGridId = 'listOfReferenceEditDataListGridId_' + Math.random().toString().substring(2, 8);
            contractTab.sectionStack.contract.addSection({
                contractDetailId: q.id,
                name: q.contractDetailTypeId,
                title: q.contractDetailType.titleEn,
                expanded: false,

                controls: [isc.IButton.create({
                    width: 150,
                    icon: "[SKIN]/actions/remove.png",
                    size: 32,
                    click: function () {
                        contractTab.sectionStack.contract.removeSection(q.contractDetailTypeId + "");
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

        contractTab.window.main.setTitle("<spring:message code='contract.window.title.edit'/>" + "\t" + record.material.descl);
        contractTab.window.main.show();
    }
};
