var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/"
contractTab.variable.contractDetailUrl = "${contextPath}" + "/api/contract-detail/"
contractTab.variable.contractDetailTypeUrl = "${contextPath}" + "/api/contract-detail-type/"
contractTab.variable.contractDetailTypeTemplateUrl = "${contextPath}" + "/api/contract-detail-type-template/"

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
contractTab.restDataSource.contractDetailTypeTemplate = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey: true, hidden: true},
        {name: "content"}
    ],
    fetchDataURL: contractTab.variable.contractDetailTypeTemplateUrl + "spec-list"
});

//******************************************************* FORMITEMS ****************************************************

contractTab.dynamicForm.fields = BaseFormItems.concat([
    {
        useInGrid: true,
        name: "no",
        width: "100%",
        required: true, //false
        // editorType: "StaticText",
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
            contractTab.sectionStack.contract.getSectionNames().forEach(q => contractTab.sectionStack.contract.removeSection(q + ""));
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
        type: "TextArea",
        name: "description",
        title: "<spring:message code='global.description'/>"
    }
]);
Object.assign(contractTab.listGrid.fields, contractTab.dynamicForm.fields.filter(field => field.useInGrid));

//******************************************************* COMPONENTS ***************************************************

nicico.BasicFormUtil.createDynamicForm = function (creator) {

    contractTab.dynamicForm.main = isc.DynamicForm.create({
        width: "100%",
        height: "15%",
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

contractTab.listGrid.contractDetailType = isc.ListGrid.nicico.getDefault(
    [
        {name: "id", primaryKey: true, hidden: true, title: '<spring:message code="global.id"/>'},
        {name: "titleFa", title: '<spring:message code="global.title-fa"/>'},
        {name: "titleEn", title: '<spring:message code="global.title-en"/>'},
        {
            type: 'long',
            editorType: "SelectItem",
            name: "contractDetailTypeTemplateId",
            title: '<spring:message code="contract.form.detail-type-template"/>',
            canEdit: true,
            required: true,
            valueField: "id",
            displayField: "code",
            pickListProperties: {showFilterEditor: true},
            pickListFields: [
                {name: "id", align: "center", hidden: true},
                {name: "code", align: "center"},
            ],
            optionDataSource: contractTab.restDataSource.contractDetailTypeTemplate,
            optionCriteria: {fieldName: "contractDetailTypeId", operator: "equals", value: null},
            recordClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                this.optionCriteria.value = record.id;
                return false;
            }
        },
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
        showResizeBar: true,
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
                        prompt: '<spring:message code="global.add"/>',
                        click: function () {

                            if (contractTab.sectionStack.contract.getSectionNames().includes(record.id))
                                return;

                            contractTab.method.addSectionByContractDetailType(record);
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
                contractTab.sectionStack.contract.sections.forEach(section => {
                    let contractDetailObj = {
                        contractDetailTypeId: section.name,
                        id: section.contractDetailId,
                        contractDetailValues: []
                    };

                    // dynamicForm
                    section.getSectionStack().getMembers().get(1).fields.filter(x => x.isBaseItem == null).forEach(x => {
                        contractDetailObj.contractDetailValues.push({
                            id: x.contractDetailValueId,
                            name: x.name,
                            key: x.key,
                            title: x.title,
                            reference: x.reference,
                            type: x.paramType,
                            value: section.getSectionStack().getMembers().get(1).values[x.name],
                            unitId: x.unitId,
                            required: (x.required == null) ? false : x.required,
                            contractDetailId: section.contractDetailId,
                            estatus: x.estatus,
                            editable: x.editable
                        });
                    });

                    // listGrids
                    section.getSectionStack().getMembers().slice(2, section.getSectionStack().getMembers().length).forEach(listGrid => {
                        listGrid.saveAllEdits();
                        let listGridData;
                        if (listGrid.getData() instanceof Array) //create
                            listGridData = listGrid.getData();
                        else { //update
                            listGridData = listGrid.getData().localData
                        }
                        listGridData.forEach(x => {
                            Object.keys(x).forEach(listGridKey => {
                                if (listGridKey.startsWith("_"))
                                    delete x[listGridKey];
                            });
                            contractDetailObj.contractDetailValues.push({
                                id: x.contractDetailValueId,
                                name: "Not Important",
                                title: "Not Important",
                                key: "NotImportant",
                                reference: listGrid.reference,
                                type: "ListOfReference",
                                value: x.id,
                                referenceJsonValue: JSON.stringify(x),
                                unitId: null,
                                required: false,
                                contractDetailId: section.contractDetailId,
                                estatus: x.estatus,
                                editable: x.editable
                            });
                        });
                    });

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

//*************************************************** Functions ********************************************************

contractTab.method.newForm = function () {

    contractTab.variable.method = "POST";
    contractTab.dynamicForm.main.clearValues();
    contractTab.sectionStack.contract.getSectionNames().forEach(q => contractTab.sectionStack.contract.removeSection(q + ""));
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

        contractTab.listGrid.contractDetailType.setCriteria({
            operator: 'and',
            criteria: [{
                fieldName: 'materialId',
                operator: 'equals',
                value: contractTab.dynamicForm.main.getValue('materialId')
            }]
        });
        contractTab.sectionStack.contract.getSectionNames().forEach(q => contractTab.sectionStack.contract.removeSection(q + ""));
        contractTab.method.addSectionByContract(record);

        contractTab.window.main.setTitle("<spring:message code='contract.window.title.edit'/>" + "\t" + record.material.descl);
        contractTab.window.main.show();
    }
};
contractTab.method.provideDetailContent = function (data) {
};
contractTab.method.addSectionByContract = function (record) {

    record.contractDetails.forEach(q => {

        let sectionStackSectionObj = {
            expanded: true,
            contractDetailId: q.id,
            name: q.contractDetailTypeId,
            title: q.contractDetailType.titleEn,
            controls: [isc.IButton.create({
                size: 32,
                width: 150,
                icon: "[SKIN]/actions/view.png",
                click: function () {

                }
            }), isc.IButton.create({
                width: 150,
                icon: "[SKIN]/actions/remove.png",
                size: 32,
                click: function () {
                    contractTab.sectionStack.contract.removeSection(q.contractDetailTypeId + "");
                }
            })],
            items: []
        };

        // DynamicForm
        let dynamicFormFields = [];
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
            fields: BaseFormItems.concat(dynamicFormFields, true)
        });
        sectionStackSectionObj.items.push(contractDetailDynamicForm);

        let contractDetailValueGroup = q.contractDetailValues.filter(x => x.type === 'ListOfReference').groupBy('reference');
        Object.keys(contractDetailValueGroup).forEach(reference => {

            let contractDetailListGrid = isc.ListGrid.create({
                width: "100%",
                height: 300,
                showRowNumbers: true,
                canAutoFitFields: false,
                allowAdvancedCriteria: true,
                alternateRecordStyles: true,
                selectionType: "single",
                sortDirection: "ascending",
                fields: getReferenceFields(reference),
                canEdit: true,
                editEvent: "doubleClick",
                autoSaveEdits: false,
                virtualScrolling: false,
                showRecordComponents: true,
                showRecordComponentsByCell: true,
                recordComponentPoolingMode: "recycle",
                listEndEditAction: "next",
                canRemoveRecords: true,
                reference: reference,
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
            });

            getReferenceDataSource(reference).fetchData(
                getReferenceCriteria(contractDetailValueGroup[reference].map(p => p.value)),
                function (dsResponse, data) {
                    contractDetailListGrid.setData(data);
                    q.contractDetailValues.filter(x => x.type == 'ListOfReference').forEach((detailValue, index) => {
                        data[index].contractDetailValueId = detailValue.id;
                        data[index].estatus = detailValue.estatus;
                        data[index].editable = detailValue.editable;
                        data[index].version = detailValue.version;
                    })
                }
            );
            sectionStackSectionObj.items.push(contractDetailListGrid);
        });
        contractTab.sectionStack.contract.addSection(sectionStackSectionObj);
    });
};
contractTab.method.addSectionByContractDetailType = function (record) {

    let sectionStackSectionObj = {
        expanded: true,
        name: record.id,
        title: record.titleEn,
        contractDetailId: null,
        controls: [isc.IButton.create({
            width: 150,
            icon: "[SKIN]/actions/view.png",
            size: 32,
            click: function () {

            }
        }), isc.IButton.create({
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
    });
    sectionStackSectionObj.items.push(contractDetailDynamicForm);

    record.contractDetailTypeParams.filter(param => param.type === "ListOfReference").forEach(param => {
        let contractDetailListGrid = isc.ListGrid.create({
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
            reference: param.reference,
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
};
