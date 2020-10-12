var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/"
contractTab.variable.contractDetailUrl = "${contextPath}" + "/api/contract-detail/"
contractTab.variable.contractDetailTypeUrl = "${contextPath}" + "/api/contract-detail-type/"
contractTab.variable.contractDetailTypeTemplateUrl = "${contextPath}" + "/api/contract-detail-type-template/"

var contractPositionDynamicForm = isc.DynamicForm.nicico.getDefault([{
    width: "100%",
    name: "position",
    required: true,
    title: "<spring:message code='global.order'/>"
}])

contractTab.window.formUtil = new nicico.FormUtil();

contractTab.window.position = isc.Window.nicico.getDefault("<spring:message code='global.order'/>", [
    contractPositionDynamicForm
], "400");
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
function contractTabDynamicFormFields() {
    return BaseFormItems.concat([
        {
            useInGrid: true,
            name: "content",
            width: "100%",
            hidden: true
        },
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
            required: true,
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
            optionCriteria: {fieldName: "id", operator: "notEqual", value: 2},
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
}

contractTab.dynamicForm.fields = contractTabDynamicFormFields();
contractTab.listGrid.fields = contractTabDynamicFormFields().filter(field => field.useInGrid || field.isBaseItem);
contractTab.listGrid.fields.forEach(item => {
    if (item.isBaseItem) item.hidden = false;
});

//******************************************************* COMPONENTS ***************************************************

nicico.BasicFormUtil.createDynamicForm = function (creator) {

    contractTab.dynamicForm.main = isc.DynamicForm.create({
        width: "100%",
        height: "15%",
        titleAlign: align(),
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
        width: "40%",
        showResizeBar: true,
        showFilterEditor: false,
        showRecordComponents: true,
        setAutoFitExtraRecords: true,
        showRecordComponentsByCell: true,
        createRecordComponent: function (record, colNum) {

            var fieldName = this.getFieldName(colNum);
            if (fieldName === "addIcon") {
                // <c:if test = "${SecurityUtil.hasAuthority('C_CONTRACT_DETAIL')}">
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
                            // dbg(false,this)
                            if (contractTab.sectionStack.contract.getSectionNames().includes(record.id)
                            || !contractTab.dynamicForm.main.validate()
                            )
                                return;

                            contractPositionDynamicForm.clearValues();
                            contractTab.window.formUtil.showForm(
                                contractTab.window.main,
                                "<spring:message code='global.order'/>",
                                contractPositionDynamicForm, '400');

                            contractTab.window.formUtil.populateData = function (body) {
                                return [body.getValues()];
                            };

                            contractTab.window.formUtil.validate = function (data) {
                                contractPositionDynamicForm.validate();
                                return !contractPositionDynamicForm.hasErrors();
                            };

                            contractTab.window.formUtil.okCallBack = function (data) {
                                record.position = data[0].position;
                                if (record.contractDetailTypeTemplates.length == 1) {
                                    record.content = record.contractDetailTypeTemplates[0].content;
                                    contractTab.method.addSectionByContractDetailType(record);
                                } else {
                                    contractTab.variable.contractDetailTypeTemplate.bodyWidget.getObject().setData(record.contractDetailTypeTemplates);
                                    contractTab.variable.contractDetailTypeTemplate.bodyWidget.getObject().contractDetailTypeRecord = record;
                                    contractTab.variable.contractDetailTypeTemplate.justShowForm();
                                }
                            };
                        }
                    });
                // </c:if>
            }

            return null;
        }
    });
contractTab.sectionStack.contract = isc.SectionStack.create({
    visibilityMode: "multiple",
    canDrag: true,
    margin: 10,
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

                contractTab.sectionStack.contract.expandSection(contractTab.sectionStack.contract.sections);

                data.contractDetails = [];

                data.content = "";
                contractTab.sectionStack.contract.sections.filter(x => x.title.toLowerCase().contains("header")).forEach(section => {
                    data.content = data.content + changeHeaderAndFooterTemplate(section.template);
                });
                contractTab.sectionStack.contract.sections.forEach(section => {
                    let contractDetailObj = {
                        contractDetailTypeId: section.name,
                        position: section.position,
                        contractDetailTemplate: section.template,
                        id: section.contractDetailId,
                        content: generateContentFromSection(section, section.template),
                        contractDetailValues: []
                    };

                    if (data.contractTypeId != 3) {
                        section.items[0].validate();
                        if (section.items[0].hasErrors())
                            throw "dynamicForm validation is failed.";

                    }

                    // dynamicForm
                    section.items[0].fields.filter(x => x.isBaseItem == null).forEach(x => {
                        contractDetailObj.contractDetailValues.push({
                            id: x.contractDetailValueId,
                            name: x.name,
                            key: x.key,
                            title: x.title,
                            reference: x.reference,
                            type: x.paramType,
                            value: section.items[0].values[x.name],
                            unitId: x.unitId,
                            required: (x.required == null) ? false : x.required,
                            contractDetailId: section.contractDetailId,
                            estatus: x.estatus,
                            editable: x.editable
                        });
                    });

                    // listGrids
                    section.items.slice(1, section.items.length).forEach(listGrid => {
                        listGrid.saveAllEdits();
                        let listGridData;
                        if (listGrid.getData() instanceof Array) //create
                            listGridData = listGrid.getData();
                        else { //update
                            listGridData = listGrid.getData().localData
                        }
                        if (listGridData.length == 0) {
                            contractTab.dialog.say(
                                "<spring:message code='contract.window.list-of-reference-empty'/>",
                                "<spring:message code='global.warning'/>");
                            throw "One of List Grids is Empty"
                        }
                        listGridData.forEach(x => {
                            Object.keys(x).forEach(listGridKey => {
                                if (listGridKey.startsWith("_"))
                                    delete x[listGridKey];
                            });
                            contractDetailObj.contractDetailValues.push({
                                id: x.contractDetailValueId,
                                name: listGrid.paramName,
                                title: listGrid.paramName,
                                key: listGrid.paramKey,
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

                    if (!section.title.toLowerCase().contains("header") && !section.title.toLowerCase().contains("footer"))
                        data.content = data.content + "<h2>" + section.title + "</h2>" + contractDetailObj.content;
                });

                contractTab.sectionStack.contract.sections.filter(x => x.title.toLowerCase().contains("footer")).forEach(section => {
                    data.content = data.content + changeHeaderAndFooterTemplate(section.template);
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

contractTab.variable.contractDetailTypeTemplate = new nicico.FormUtil();
contractTab.variable.contractDetailTypeTemplate.getButtonLayout = function () {
};
contractTab.variable.contractDetailTypeTemplate.init(null, "<spring:message code='contract.form.detail-type-template'/>",
    isc.ListGrid.nicico.getDefault(
        [
            {name: "id", primaryKey: true, hidden: true, title: '<spring:message code="global.id"/>'},
            {name: "content"}
        ], null, null,
        {
            styleName: "contractDetailTypeTemplate",
            cellDoubleClick: function (record, rowNum, colNum) {
this.contractDetailTypeRecord.content = record.content;
                contractTab.method.addSectionByContractDetailType(this.contractDetailTypeRecord);
                contractTab.variable.contractDetailTypeTemplate.windowWidget.getObject().close();
            }
        }), "50%", 400);


contractTab.variable.contractDetailPreview = new nicico.FormUtil();
contractTab.variable.contractDetailPreview.getButtonLayout = function () {
};
contractTab.variable.contractDetailPreview.cancelCallBack = function () {
    contractTab.variable.contractDetailPreview.bodyWidget.getObject().setContents("");
};
contractTab.variable.contractDetailPreview.init(null, "<spring:message code='contract.window.detail.preview'/>",
    isc.HTMLFlow.create({
        overflow: "auto",
        width: "100%",
        padding: 20,
        styleName: "contractDetailPreview"
    }), "50%", "400");


contractTab.variable.contractPreview = new nicico.FormUtil();
contractTab.variable.contractPreview.getButtonLayout = function () {
};
contractTab.variable.contractPreview.cancelCallBack = function () {
    contractTab.variable.contractPreview.bodyWidget.getObject().get(0).setContents("");
};
contractTab.variable.contractPreview.init(null, "<spring:message code='contract.window.contract.preview'/>",
    [
        isc.HTMLFlow.create({
            overflow: "auto",
            width: "100%",
            padding: 20,
            styleName: "contractDetailPreview"
        }),
        isc.ToolStripButtonAdd.create({
            icon: "[SKIN]/actions/print.png",
            title: "<spring:message code='global.form.print.pdf'/>",
            width: "100%",
            margin: 3,
            click: function () {
                var printWindow = window.open('', '', 'height=800,width=800');
                printWindow.document.write('<html><head><title></title>');
                printWindow.document.write('</head><body>');
                printWindow.document.write(contractTab.variable.contractPreview.bodyWidget.getObject().get(0).getContents());
                printWindow.document.write('</body></html>');
                printWindow.document.close();
                printWindow.print();
            }
        }),
        isc.ToolStripButtonAdd.create({
            icon: "pieces/512/word.png",
            title: "<spring:message code='global.form.print.contract.word'/>",
            width: "100%",
            margin: 3,
            click: function () {
                var header = "<html xmlns:o='urn:schemas-microsoft-com:office:office' " +
                    "xmlns:w='urn:schemas-microsoft-com:office:word' " +
                    "xmlns='http://www.w3.org/TR/REC-html40'>" +
                    "<head><meta charset='utf-8'><title>CONTRACT</title></head><body>";
                var footer = "</body></html>";
                var sourceHTML = header + contractTab.variable.contractPreview.bodyWidget.getObject().get(0).getContents() + footer;
                var source = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(sourceHTML);
                var fileDownload = document.createElement("a");
                document.body.appendChild(fileDownload);
                fileDownload.href = source;
                fileDownload.download = 'contract.doc';
                fileDownload.click();
                document.body.removeChild(fileDownload);
            }
        })
    ]
    , "50%", 0.7 * innerHeight);

nicico.BasicFormUtil.getDefaultBasicForm(contractTab, "api/g-contract/", (creator) => {
    contractTab.window.main = isc.Window.nicico.getDefault(null, [
        contractTab.dynamicForm.main,
        contractTab.hLayout.contractDetailHlayout,
        contractTab.hLayout.saveOrExitHlayout
    ], "80%", 0.8 * innerHeight);
});
// <c:if test = "${c_entity}">
// @ts-ignore
contractTab.toolStrip.main.addMember(isc.ToolStripButtonAdd.create({
    icon: "[SKIN]/actions/print.png",
    title: "<spring:message code='global.form.print'/>",
    click: function () {
        let record = contractTab.listGrid.main.getSelectedRecord();
        if (record == null || record.id == null)
            contractTab.dialog.notSelected();
        else {
            contractTab.variable.contractPreview.bodyWidget.getObject().get(0).setContents(record.content == undefined ? "" : record.content);
            contractTab.variable.contractPreview.bodyWidget.getObject().get(0).redraw();
            contractTab.variable.contractPreview.justShowForm();
        }
    }
}), 3);
contractTab.menu.main.data.add({
    icon: "[SKIN]/actions/print.png",
    title: '<spring:message code="global.form.print"/>',
    click: function () {
        // @ts-ignore
        let record = contractTab.listGrid.main.getSelectedRecord();
        if (record == null || record.id == null)
            contractTab.dialog.notSelected();
        else {
            contractTab.variable.contractPreview.bodyWidget.getObject().get(0).setContents(record.content == undefined ? "" : record.content);
            contractTab.variable.contractPreview.bodyWidget.getObject().get(0).redraw();
            contractTab.variable.contractPreview.justShowForm();
        }
    }
});
contractTab.menu.main.initWidget();
// </c:if>
nicico.BasicFormUtil.showAllToolStripActions(contractTab);
nicico.BasicFormUtil.removeExtraActions(contractTab, [nicico.ActionType.ACTIVATE, nicico.ActionType.DEACTIVATE]);
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

    let listGridRecord = contractTab.listGrid.main.getSelectedRecord();
    if (listGridRecord == null || listGridRecord.id == null)
        contractTab.dialog.notSelected();
    else if (listGridRecord.editable === false)
        contractTab.dialog.notEditable();
    else if (listGridRecord.estatus.contains(Enums.eStatus2.DeActive))
        contractTab.dialog.inactiveRecord();
    else if (listGridRecord.estatus.contains(Enums.eStatus2.Final))
        contractTab.dialog.finalRecord();
    else {
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: 'api/g-contract/' + listGridRecord.id,
            httpMethod: "GET",
            callback: function (resp) {
                if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                    let record = JSON.parse(resp.data);
                    record.buyerId = listGridRecord.buyerId;
                    record.sellerId = listGridRecord.sellerId;
                    record.agentBuyerId = listGridRecord.agentBuyerId;
                    record.agentSellerId = listGridRecord.agentSellerId;

                    contractTab.variable.method = "PUT";
                    contractTab.dynamicForm.main.editRecord(record);
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
                    contractTab.window.main.setTitle("<spring:message code='contract.window.title.edit'/>" + "\t" + record.material.descEN);
                    contractTab.window.main.show();
                } else
                    contractTab.dialog.error(resp);
            }
        }))
    }
};

contractTab.method.addSectionByContract = function (record) {
    record.contractDetails.forEach(q => {

        let sectionStackSectionObj = {
            position: q.position,
            template: q.contractDetailTemplate,
            expanded: false,
            contractDetailId: q.id,
            name: q.contractDetailTypeId,
            title: q.contractDetailType.titleEn,
            content: q.content,
            controls: [isc.IButton.create({
                size: 32,
                width: 150,
                icon: "[SKIN]/actions/view.png",
                click: function () {
                    let clickedSection = contractTab.sectionStack.contract.sections.filter(q => q.name === sectionStackSectionObj.name).first();
                    contractTab.variable.contractDetailPreview.bodyWidget.getObject().setContents(generateContentFromSection(clickedSection, sectionStackSectionObj.template));
                    contractTab.variable.contractDetailPreview.justShowForm();
                }
            })
                // <c:if test = "${SecurityUtil.hasAuthority('D_CONTRACT_DETAIL')}">
                , isc.IButton.create({
                width: 150,
                icon: "[SKIN]/actions/remove.png",
                size: 32,
                click: function () {
                    contractTab.sectionStack.contract.removeSection(q.contractDetailTypeId + "");
                }
            })
                //</c:if>
            ],
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
            field.value = detailValue.value;
            if (field.value === "false")
                field.value = false;
            if (field.value === "true")
                field.value = true;
            if (field.paramType === 'GeorgianDate')
                field.value = new Date(detailValue.value);
            field.required = detailValue.required;
            field.contractDetailValueId = detailValue.id;
            field.estatus = detailValue.estatus;
            field.editable = detailValue.editable;
            field.unitId = detailValue.unitId;

            if (header.contains(field.key))
                field.hidden = true;

            if (detailValue.unitId !== undefined) {
                getReferenceDataSource("Unit").fetchData(
                    {
                        _constructor: "AdvancedCriteria",
                        operator: "and",
                        criteria: [
                            {fieldName: "id", operator: "equals", value: detailValue.unitId}
                        ]
                    },
                    function (dsResponse, data) {
                        contractDetailDynamicForm.getField(field.name).setHint(data[0].symbolUnit);
                    }
                );
            }

            Object.assign(field, getFieldProperties(field.paramType, field.reference));

            dynamicFormFields.push(field);
        });
        let contractDetailDynamicForm = isc.DynamicForm.create({
            visibility: "hidden",
            width: "100%",
            align: "center",
            wrapItemTitles:false,
            numCols: 8,
            styleName: 'contract-section',
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
                styleName: 'contract-section',
                showRowNumbers: true,
                canAutoFitFields: false,
                allowAdvancedCriteria: true,
                alternateRecordStyles: true,
                selectionType: "single",
                sortDirection: "ascending",
                fields: getReferenceFields(reference),
                canEdit: "${SecurityUtil.hasAuthority('U_CONTRACT_DETAIL_VALUE')}".toString() === "true",
                editEvent: "doubleClick",
                autoSaveEdits: false,
                virtualScrolling: false,
                showRecordComponents: true,
                showRecordComponentsByCell: true,
                recordComponentPoolingMode: "recycle",
                listEndEditAction: "next",
                canRemoveRecords: "${SecurityUtil.hasAuthority('D_CONTRACT_DETAIL_VALUE')}".toString() === "true",
                reference: reference,
                paramName: contractDetailValueGroup[reference][0].name,
                paramTitle: contractDetailValueGroup[reference][0].title,
                paramKey: contractDetailValueGroup[reference][0].key,
                gridComponents: ["header", "body", isc.ToolStrip.create({
                    width: "100%",
                    height: 24,
                    members: [
                        // <c:if test = "${SecurityUtil.hasAuthority('R_CONTRACT_DETAIL_VALUE')}">
                        isc.ToolStripButton.create({
                            icon: "pieces/16/icon_add.png",
                            title: "<spring:message code='global.add'/>",
                            click: function () {
                                contractDetailListGrid.startEditingNew();
                            }
                        }),
                        // </c:if>
                        isc.ToolStrip.create({
                            width: "100%",
                            height: 24,
                            align: 'left',
                            border: 0,
                            members: [
                                // <c:if test = "${SecurityUtil.hasAuthority('R_CONTRACT_DETAIL_VALUE')}">
                                isc.ToolStripButton.create({
                                    icon: "pieces/16/save.png",
                                    title: "<spring:message code='global.form.save'/>",
                                    click: function () {
                                        contractDetailListGrid.saveAllEdits();
                                    }
                                })
                                // </c:if>
                            ]
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
                    })
                }
            );
            sectionStackSectionObj.items.push(contractDetailListGrid);
        });
        contractTab.sectionStack.contract.addSection(sectionStackSectionObj, parseInt(q.position));
    });
};
contractTab.method.addSectionByContractDetailType = function (record) {
    let sectionStackSectionObj = {
        position: record.position,
        template: record.content,
        expanded: false,
        name: record.id,
        title: record.titleEn,
        contractDetailId: null,
        controls: [isc.IButton.create({
            width: 150,
            icon: "[SKIN]/actions/view.png",
            size: 32,
            click: function () {
                let clickedSection = contractTab.sectionStack.contract.sections.filter(q => q.name === sectionStackSectionObj.name).first();
                contractTab.variable.contractDetailPreview.bodyWidget.getObject().setContents(generateContentFromSection(clickedSection, sectionStackSectionObj.template));
                contractTab.variable.contractDetailPreview.justShowForm();
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
        field.value = param.defaultValue;
        field.required = param.required;
        field.unitId = param.unitId;

        if (header.contains(field.key))
            field.hidden = true;

        if (param.reference == "Incoterm") {
            field.changed = function (form, item, value) {
                getReferenceDataSource("IncotermRules").fetchData(
                    {
                        _constructor: "AdvancedCriteria",
                        operator: "and",
                        criteria: value
                    },
                    function (dsResponse, data) {
                        contractDetailDynamicForm.getField(param.name).setHint("RULES: " + data);
                    }
                );
            };
        }

        if (param.unitId !== undefined) {
            getReferenceDataSource("Unit").fetchData(
                {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [
                        {fieldName: "id", operator: "equals", value: param.unitId}
                    ]
                },
                function (dsResponse, data) {
                    contractDetailDynamicForm.getField(param.name).setHint(data[0].symbolUnit);
                }
            );
        }

        Object.assign(field, getFieldProperties(field.paramType, field.reference));
        dynamicFormField.push(field);
    });

    let contractDetailDynamicForm = isc.DynamicForm.create({
        visibility: "hidden",
        wrapItemTitles:false,
        width: "100%",
        align: "center",
        numCols: 8,
        styleName: 'contract-section',
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
            styleName: 'contract-section',
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
            paramName: param.name,
            paramTitle: param.title,
            paramKey: param.key,
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
    contractTab.sectionStack.contract.addSection(sectionStackSectionObj, parseInt(record.position));
    if(record.code && record.code === Enums.contract.Enum_EContractDetailTypeCode.Header){
        const _enum = Enums.contract.Enum_EContractDetailValueKey;
        const BUYER = contractTab.dynamicForm.main.getField('buyerId').getSelectedRecord();
        const SELLER = contractTab.dynamicForm.main.getField('sellerId').getSelectedRecord();
        function setval([_key,formName]) {
            try {
                contractDetailDynamicForm.setValue(_key,formName)
            }
            catch (e) {
                //dbg(false,e)
            }
        }
        setval([_enum.BUYER_NAME,BUYER.nameEN])
        setval([_enum.BUYER_ADDRESS,BUYER.address])
        setval([_enum.BUYER_PHONE,BUYER.phone])
        setval([_enum.BUYER_FAX,BUYER.fax])
        setval([_enum.BUYER_MOBILE,BUYER.mobile])

        setval([_enum.SELLER_NAME,SELLER.nameEN])
        setval([_enum.SELLER_ADDRESS,SELLER.address])
        setval([_enum.SELLER_PHONE,SELLER.phone])
        setval([_enum.SELLER_FAX,SELLER.fax])
        setval([_enum.SELLER_MOBILE,SELLER.mobile])

        try {
            const AGENT_SELLER = contractTab.dynamicForm.main.getField('agentSellerId').getSelectedRecord();

            setval([_enum.AGENT_SELLER_NAME,AGENT_SELLER.nameEN])
            setval([_enum.AGENT_SELLER_ADDRESS,AGENT_SELLER.address])
            setval([_enum.AGENT_SELLER_PHONE,AGENT_SELLER.phone])
            setval([_enum.AGENT_SELLER_FAX,AGENT_SELLER.fax])
            setval([_enum.AGENT_SELLER_MOBILE,AGENT_SELLER.mobile])
        }
        catch (e) {
            //dbg(false,e);
        }

        try {
            const AGENT_BUYER = contractTab.dynamicForm.main.getField('agentBuyerId').getSelectedRecord();

            setval([_enum.AGENT_BUYER_NAME,AGENT_BUYER.nameEN])
            setval([_enum.AGENT_BUYER_ADDRESS,AGENT_BUYER.address])
            setval([_enum.AGENT_BUYER_PHONE,AGENT_BUYER.phone])
            setval([_enum.AGENT_BUYER_FAX,AGENT_BUYER.fax])
            setval([_enum.AGENT_BUYER_MOBILE,AGENT_BUYER.mobile])
        }
        catch (e) {
            //dbg(false,e);
        }




        //dbg(false,'form',contractDetailDynamicForm)

    }
};

function generateContentFromSection(section, template) {

    section.items[0].fields.filter(x => x.isBaseItem == null).forEach(x => {
        if (x.unitId !== undefined)
            template = template.replaceAll('\\${_' + x.unitId + '}', section.items[0].getField(x.name).getHint());
        if (x.paramType == "Reference")
            template = template.replaceAll('\\${' + x.key + '}', section.items[0].getField(x.key).getDisplayValue());
        if (template.contains('\\${' + x.key + '_IN_CHARACTER}'))
            template = template.replaceAll('\\${' + x.key + '_IN_CHARACTER}', numberToEnglish(section.items[0].values[x.name]));
        template = template.replaceAll('\\${' + x.key + '}', section.items[0].values[x.name]);
    });

    section.items.slice(1, section.items.length).forEach(listGrid => {
        listGrid.saveAllEdits();
        let listGridData;
        if (listGrid.getData() instanceof Array) //create
            listGridData = listGrid.getData();
        else { //update
            listGridData = listGrid.getData().localData
        }

        var table = "";
        var tableStartTag = "<table style='border: 1px solid black;'>";
        var tableEndTag = "</table>";
        var tableHeader = "";
        var tableRows = "";

        var correspondingNameTitle = {};
        listGrid.getFields().filter(filed => filed.showTemplate == true).forEach(field => correspondingNameTitle[field.name] = field.title);

        tableHeader = tableHeader + "<tr>";
        Object.values(correspondingNameTitle).forEach(header => {
            tableHeader = tableHeader + "<th style='border: 1px solid black;'>" + header + "</th>";
        });
        tableHeader = tableHeader + "</tr>";

        listGridData.forEach(record => {
            tableRows = tableRows + "<tr>";
            Object.keys(correspondingNameTitle).forEach(name => {
                let templateDataFieldName = listGrid.getField(name).templateDataFieldName;
                if (templateDataFieldName)
                    tableRows = tableRows + "<td style='border: 1px solid black;'>" + templateDataFieldName.split('.').evalPropertyPath(record) + "</td>";
                else
                    tableRows = tableRows + "<td style='border: 1px solid black;'>" + record[name] + "</td>";
            });
            tableRows = tableRows + "</tr>";
        });

        table = table + tableStartTag + tableHeader + tableRows + tableEndTag;

        template = template.replaceAll('\\${' + listGrid.paramKey + '}', table);
    });
    return template;
}

function changeHeaderAndFooterTemplate(template) {
    var buyer = contractTab.dynamicForm.main.getField("buyerId").getSelectedRecord();

    template = template.replaceAll('\\${' + "BUYER_NAME" + '}', (buyer !== undefined) ? buyer.nameEN : '');
    template = template.replaceAll('\\${' + "BUYER_ADDRESS" + '}', (buyer !== undefined) ? buyer.address : '');
    template = template.replaceAll('\\${' + "BUYER_PHONE" + '}', (buyer !== undefined) ? buyer.phone : '');
    template = template.replaceAll('\\${' + "BUYER_FAX" + '}', (buyer !== undefined) ? buyer.fax : '');
    template = template.replaceAll('\\${' + "BUYER_MOBILE" + '}', (buyer !== undefined) ? buyer.mobile : '');
    template = template.replaceAll('\\${' + "BUYER_POSTAL_CODE" + '}', (buyer !== undefined) ? buyer.postalCode : '');

    var seller = contractTab.dynamicForm.main.getField("sellerId").getSelectedRecord();

    template = template.replaceAll('\\${' + "SELLER_NAME" + '}', (seller !== undefined) ? seller.nameEN : '');
    template = template.replaceAll('\\${' + "SELLER_ADDRESS" + '}', (seller !== undefined) ? seller.address : '');
    template = template.replaceAll('\\${' + "SELLER_PHONE" + '}', (seller !== undefined) ? seller.phone : '');
    template = template.replaceAll('\\${' + "SELLER_FAX" + '}', (seller !== undefined) ? seller.fax : '');
    template = template.replaceAll('\\${' + "SELLER_MOBILE" + '}', (seller !== undefined) ? seller.mobile : '');
    template = template.replaceAll('\\${' + "SELLER_POSTAL_CODE" + '}', (seller !== undefined) ? seller.postalCode : '');

    var agentBuyer = contractTab.dynamicForm.main.getField("agentBuyerId").getSelectedRecord();

    template = template.replaceAll('\\${' + "AGENT_BUYER_NAME" + '}', (agentBuyer !== undefined) ? agentBuyer.nameEN : '');
    template = template.replaceAll('\\${' + "AGENT_BUYER_ADDRESS" + '}', (agentBuyer !== undefined) ? agentBuyer.address : '');
    template = template.replaceAll('\\${' + "AGENT_BUYER_PHONE" + '}', (agentBuyer !== undefined) ? agentBuyer.phone : '');
    template = template.replaceAll('\\${' + "AGENT_BUYER_FAX" + '}', (agentBuyer !== undefined) ? agentBuyer.fax : '');
    template = template.replaceAll('\\${' + "AGENT_BUYER_MOBILE" + '}', (agentBuyer !== undefined) ? agentBuyer.mobile : '');
    template = template.replaceAll('\\${' + "AGENT_BUYER_POSTAL_CODE" + '}', (agentBuyer !== undefined) ? agentBuyer.postalCode : '');

    var agentSeller = contractTab.dynamicForm.main.getField("agentSellerId").getSelectedRecord();

    template = template.replaceAll('\\${' + "AGENT_SELLER_NAME" + '}', (agentSeller !== undefined) ? agentSeller.nameEN : '');
    template = template.replaceAll('\\${' + "AGENT_SELLER_ADDRESS" + '}', (agentSeller !== undefined) ? agentSeller.address : '');
    template = template.replaceAll('\\${' + "AGENT_SELLER_PHONE" + '}', (agentSeller !== undefined) ? agentSeller.phone : '');
    template = template.replaceAll('\\${' + "AGENT_SELLER_FAX" + '}', (agentSeller !== undefined) ? agentSeller.fax : '');
    template = template.replaceAll('\\${' + "AGENT_SELLER_MOBILE" + '}', (agentSeller !== undefined) ? agentSeller.mobile : '');
    template = template.replaceAll('\\${' + "AGENT_SELLER_POSTAL_CODE" + '}', (agentSeller !== undefined) ? agentSeller.postalCode : '');

    return template;
}
