var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

contractTab.variable.contractUrl = "${contextPath}" + "/api/g-contract/";
contractTab.variable.contractDetailTypeUrl = "${contextPath}" + "/api/contract-detail-type/";

contractTab.variable.dataType = JSON.parse('${Enum_DataType}');

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
            required: true,
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
                contractTab.sectionStack.contract.getSectionNames().forEach(q => contractTab.sectionStack.contract.removeSection(q + ""));

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
            title: "<spring:message code='entity.contract-type'/>",
            changed: function (form, item, value) {

                contractTab.dynamicForm.valuesManager.setValue("contractType", this.getSelectedRecord());
                return this.Super("changed", arguments);
            }
        },
        Object.assign(getContactFieldByType("buyer"), {
            useInGrid: true,
            changed: function (form, item, value) {

                let buyer = this.getSelectedRecord();
                contractTab.dynamicForm.valuesManager.setValue("buyer", buyer);

                if (buyer) {

                    contractTab.dynamicForm.valuesManager.setValue("BUYER_NAME", buyer.nameEN);
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
}

contractTab.dynamicForm.fields = contractTabDynamicFormFields();
contractTab.listGrid.fields = contractTabDynamicFormFields().filter(field => field.useInGrid || field.isBaseItem);
contractTab.listGrid.fields.forEach(item => {
    if (item.isBaseItem) item.hidden = false;
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

contractTab.listGrid.contractDetailType = isc.ListGrid.nicico.getDefault(BaseFormItems.concat([
    {name: "title", title: '<spring:message code="global.title-en"/>'},
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
                    click: function () {

                        if (!contractTab.dynamicForm.main.validate())
                            return;

                        if (contractTab.sectionStack.contract.hasContractDetailType(record.id)) {

                            this.disable();
                            contractTab.dialog.say('<spring:message code="contract.contract-detail-type.exists"/>');
                            return;
                        }

                        contractTab.method.addArticle({
                            isNewMode: true,
                            template: null,
                            contractDetail: null,
                            contractDetailType: record,
                            position: contractTab.sectionStack.contract.sections.length
                        });
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

            result.add(section.data.contractDetail);
        }

        return result;
    },
    setContractDetailData: function (section) {

        // section.form
        // section.grids
        // section.dynamicTableGrids
        // section.data.contractDetail.contractDetailValues

        // contractTab.sectionStack.contract.sections.filter(x => x.title.toLowerCase().contains("header")).forEach(section => {
//     data.content = data.content + changeHeaderAndFooterTemplate(section.template);
// });
// contractTab.sectionStack.contract.sections.forEach(section => {
//     let contractDetailObj = {
//         contractDetailTypeId: section.name,
//         position: contractTab.sectionStack.contract.sections.indexOf(section),
//         contractDetailTemplate: section.template,
//         id: section.contractDetailId,
//         content: providePrintContent(section, section.template),
//         contractDetailValues: []
//     };
//
//     if (data.contractTypeId !== 3) {
//         section.items[0].validate();
//         if (section.items[0].hasErrors())
//             throw "dynamicForm validation is failed.";
//
//     }
//
//     // dynamicForm
//     section.items[0].fields.filter(x => x.isBaseItem == null).forEach(x => {
//         contractDetailObj.contractDetailValues.push({
//             id: x.contractDetailValueId,
//             name: x.name,
//             key: x.key,
//             title: x.title,
//             reference: x.reference,
//             type: x.paramType,
//             value: section.items[0].values[x.name],
//             unitId: x.unitId,
//             required: (x.required == null) ? false : x.required,
//             contractDetailId: section.contractDetailId,
//             estatus: x.estatus,
//             editable: x.editable
//         });
//     });
//
//     // listGrids
//     section.items.slice(1, section.items.length).forEach(listGrid => {
//         listGrid.saveAllEdits();
//         let listGridData;
//         if (listGrid.getData() instanceof Array) //create
//             listGridData = listGrid.getData();
//         else { //update
//             listGridData = listGrid.getData().localData
//         }
//         listGridData = contractTab.Methods.GetListGridDataFromDynamicTableGrid(listGrid, listGridData);
//         if (listGridData.length === 0) {
//             contractTab.dialog.say(
//                 "<spring:message code='contract.window.list-of-reference-empty'/>",
//                 "<spring:message code='global.warning'/>");
//             throw "One of List Grids is Empty"
//         }
//         listGridData.forEach(x => {
//             Object.keys(x).forEach(listGridKey => {
//                 if (listGridKey.startsWith("_"))
//                     delete x[listGridKey];
//             });
//             dbg(listGrid);
//             contractDetailObj.contractDetailValues.push({
//                 id: x.contractDetailValueId,
//                 name: listGrid.paramName,
//                 title: listGrid.paramName,
//                 key: listGrid.paramKey,
//                 reference: listGrid.reference,
//                 type: listGrid['cDTPDynamicTableValue'] ? contractTab.Vars.DataType.DynamicTable : contractTab.variable.dataType.ListOfReference,
//                 value: x.id,
//                 referenceJsonValue: JSON.stringify(x),
//                 unitId: null,
//                 required: false,
//                 contractDetailId: section.contractDetailId,
//                 estatus: x.estatus,
//                 editable: x.editable
//             });
//         });
//     });
//
//     data.contractDetails.push(contractDetailObj);
//
//     if (!section.title.toLowerCase().contains("header") && !section.title.toLowerCase().contains("footer"))
//         data.content = data.content + "<h2>" + section.title + "</h2>" + contractDetailObj.content;
// });
// contractTab.sectionStack.contract.sections.filter(x => x.title.toLowerCase().contains("footer")).forEach(section => {
//     data.content = data.content + changeHeaderAndFooterTemplate(section.template);
// });

        return true;
    },
    validateContractDetailData(section) {


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
    overflow: "scroll",
    members: [contractTab.sectionStack.contract]
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

                    contractTab.dialog.say('<spring:message code="contract.validation.empty-content">');
                    return;
                }
                if (!data.contractDetails) {

                    contractTab.dialog.say('<spring:message code="contract.validation.empty-detail">');
                    return;
                }

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
        contractTab.vLayout.sectionStack
    ]
});

contractTab.variable.contractDetailTypeTemplateSelectorForm = new nicico.FormUtil();
contractTab.variable.contractDetailTypeTemplateSelectorForm.getButtonLayout = function () {
};
contractTab.variable.contractDetailTypeTemplateSelectorForm.init(null, "<spring:message code='contract.form.detail-type-template'/>", isc.ListGrid.nicico.getDefault([
    {name: "id", primaryKey: true, hidden: true, title: '<spring:message code="global.id"/>'},
    {name: "content", title: '<spring:message code="global.content"/>', showHover: true, hoverWidth: '50%'}
], null, null, {
    cellHeight: "100",
    minimumCellHeight: "20",
    fixedRecordHeights: false,
    cellDoubleClick: function (record, rowNum, colNum) {

        contractTab.variable.contractDetailTypeTemplateSelectorForm.okCallBack(record.content);
        contractTab.variable.contractDetailTypeTemplateSelectorForm.windowWidget.getObject().close();
    }
}), "50%", 400);

contractTab.variable.contractDetailPreviewForm = new nicico.FormUtil();
contractTab.variable.contractDetailPreviewForm.getButtonLayout = function () {
};
contractTab.variable.contractDetailPreviewForm.cancelCallBack = function () {
    contractTab.variable.contractDetailPreviewForm.bodyWidget.getObject().setContents("");
};
contractTab.variable.contractDetailPreviewForm.init(null, "<spring:message code='contract.window.detail.preview'/>", isc.HTMLFlow.create({
    padding: 20,
    width: "100%",
    overflow: "auto",
}), "50%", "400");

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
        padding: 20,
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
            printWindow.document.write(contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).getContents());
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
            var sourceHTML = header + contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).getContents() + footer;
            var source = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(sourceHTML);
            var fileDownload = document.createElement("a");
            document.body.appendChild(fileDownload);
            fileDownload.href = source;
            fileDownload.download = 'contract.doc';
            fileDownload.click();
            document.body.removeChild(fileDownload);
        }
    })
], "50%", 0.7 * innerHeight);

nicico.BasicFormUtil.getDefaultBasicForm(contractTab, "api/g-contract/", (creator) => {
    contractTab.window.main = isc.Window.nicico.getDefault(null, [
        contractTab.dynamicForm.main,
        contractTab.hLayout.contractDetailHlayout,
        contractTab.hLayout.saveOrExitHlayout
    ], "85%", 0.90 * innerHeight);
});

// <sec:authorize access="hasAuthority('P_CONTRACT')">
contractTab.toolStrip.main.addMember(isc.ToolStripButton.create({
    icon: "[SKIN]/actions/print.png",
    title: "<spring:message code='global.form.print'/>",
    click: function () {
        let record = contractTab.listGrid.main.getSelectedRecord();
        if (record == null || record.id == null)
            contractTab.dialog.notSelected();
        else {
            contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).setContents(!record.content ? "" : record.content);
            contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).redraw();
            contractTab.variable.contractPreviewForm.justShowForm();
        }
    }
}), 3);
contractTab.menu.main.data.add({
    icon: "[SKIN]/actions/print.png",
    title: '<spring:message code="global.form.print"/>',
    click: function () {

        let record = contractTab.listGrid.main.getSelectedRecord();
        if (record == null || record.id == null)
            contractTab.dialog.notSelected();
        else {
            contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).setContents(!record.content ? "" : record.content);
            contractTab.variable.contractPreviewForm.bodyWidget.getObject().get(0).redraw();
            contractTab.variable.contractPreviewForm.justShowForm();
        }
    }
});
contractTab.menu.main.initWidget();
// </sec:authorize>
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
    contractTab.window.main.setTitle("<spring:message code='contract.window.title.new'/>");
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

                    contractTab.variable.method = "PUT";
                    contractTab.dynamicForm.main.editRecord(listGridRecord);
                    contractTab.sectionStack.contract.getSectionNames().forEach(q => contractTab.sectionStack.contract.removeSection(q + ""));
                    record.contractDetails.sortByProperty('position').reverse().forEach(contractDetail =>
                        contractTab.method.addArticle({
                            isNewMode: false,
                            contractDetail: contractDetail,
                            position: contractDetail.position,
                            template: contractDetail.contractDetailTemplate,
                            contractDetailType: contractDetail.contractDetailType
                        })
                    );
                    contractTab.listGrid.contractDetailType.invalidateRecordComponents();
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
                    });
                    contractTab.window.main.setTitle("<spring:message code='contract.window.title.edit'/>" + "\t" + listGridRecord.material.descEN);
                    contractTab.window.main.show();
                } else
                    contractTab.dialog.error(resp);
            }
        }));
    }
};

contractTab.method.addArticle = function (data) {

    if (!data.contractDetail)
        data.contractDetail = {
            id: null,
            content: null,
            contractDetailValues: [],
            contractDetailTemplate: data.template,
            contractDetailTypeId: data.contractDetailType.id,
            position: contractTab.sectionStack.contract.sections.length
        }
    if (data.template == null) {

        if (data.contractDetailType.contractDetailTypeTemplates.length === 1) {

            data.template = data.contractDetailType.contractDetailTypeTemplates[0].content;
            contractTab.method.createArticle(data);
        } else {
            contractTab.variable.contractDetailTypeTemplateSelectorForm.okCallBack = function (templateContent) {

                data.template = templateContent;
                contractTab.method.createArticle(data);
            };
            contractTab.variable.contractDetailTypeTemplateSelectorForm.bodyWidget.getObject().setData(data.contractDetailType.contractDetailTypeTemplates);
            contractTab.variable.contractDetailTypeTemplateSelectorForm.justShowForm();
        }
    } else if (data.isNewMode)
        contractTab.method.createArticle(data);
    else
        contractTab.dialog.say('<spring:message code="incoterm.exception.required-info">');
};
contractTab.method.createArticle = function (data) {

    let sectionStackSectionObj = {
        form: null,
        grids: [],
        dynamicTableGrids: [],
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
                        providePrintContent(sectionStackSectionObj, sectionStackSectionObj.data.template));
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
                    contractTab.sectionStack.contract.removeSection(data.contractDetailType.id + "");
                    let detailTypeRecord = contractTab.listGrid.contractDetailType.getOriginalData().localData.filter(q => q.id === data.contractDetailType.id).first();
                    contractTab.listGrid.contractDetailType.getRecordComponent(
                        contractTab.listGrid.contractDetailType.getRecordIndex(detailTypeRecord)).enable();
                }
            })
            // </sec:authorize>
        ],
        items: [],
        providePrintContent: function () {

            let template = this.data.template;

            //
            // this.items[0].fields.filter(x => x.isBaseItem == null).forEach(x => {
            //     if (x.unitId !== undefined)
            //         template = template.replaceAll('\\${_' + x.unitId + '}', this.items[0].getField(x.name).getHint());
            //     if (x.paramType == contractTab.variable.dataType.Reference)
            //         template = template.replaceAll('\\${' + x.key + '}', this.items[0].getField(x.key).getDisplayValue());
            //     if (template.contains('\\${' + x.key + '_IN_CHARACTER}'))
            //         template = template.replaceAll('\\${' + x.key + '_IN_CHARACTER}', numberToEnglish(this.items[0].values[x.name]));
            //     template = template.replaceAll('\\${' + x.key + '}', this.items[0].values[x.name]);
            // });
            //
            // this.items.slice(1, this.items.length).forEach(listGrid => {
            //     listGrid.saveAllEdits();
            //     let listGridData;
            //     if (listGrid.getData() instanceof Array) //create
            //         listGridData = listGrid.getData();
            //     else { //update
            //         listGridData = listGrid.getData().localData
            //     }
            //
            //     var table = "";
            //     var tableStartTag = "<table style='border: 1px solid black;'>";
            //     var tableEndTag = "</table>";
            //     var tableHeader = "";
            //     var tableRows = "";
            //
            //     var correspondingNameTitle = {};
            //     listGrid.getFields().filter(filed => filed.showTemplate == true).forEach(field => correspondingNameTitle[field.name] = field.title);
            //
            //     tableHeader = tableHeader + "<tr>";
            //     Object.values(correspondingNameTitle).forEach(header => {
            //         tableHeader = tableHeader + "<th style='border: 1px solid black;'>" + header + "</th>";
            //     });
            //     tableHeader = tableHeader + "</tr>";
            //
            //     listGridData.forEach(record => {
            //         tableRows = tableRows + "<tr>";
            //         Object.keys(correspondingNameTitle).forEach(name => {
            //             let templateDataFieldName = listGrid.getField(name).templateDataFieldName;
            //             if (templateDataFieldName)
            //                 tableRows = tableRows + "<td style='border: 1px solid black;'>" + templateDataFieldName.split('.').evalPropertyPath(record) + "</td>";
            //             else
            //                 tableRows = tableRows + "<td style='border: 1px solid black;'>" + record[name] + "</td>";
            //         });
            //         tableRows = tableRows + "</tr>";
            //     });
            //
            //     table = table + tableStartTag + tableHeader + tableRows + tableEndTag;
            //
            //     template = template.replaceAll('\\${' + listGrid.paramKey + '}', table);
            // });

            this.data.contractDetail.content = template;
            return template;
        }
    };

    contractTab.method.createArticleBody(sectionStackSectionObj);
    contractTab.sectionStack.contract.addSection(sectionStackSectionObj, sectionStackSectionObj.position);

    let detailTypeRecord = contractTab.listGrid.contractDetailType.getOriginalData().localData.filter(q => q.id === data.contractDetailType.id).first();
    let recordIndex = contractTab.listGrid.contractDetailType.getRecordIndex(detailTypeRecord);
    if (recordIndex >= 0) {

        let addButton = contractTab.listGrid.contractDetailType.getRecordComponent(recordIndex);
        if (addButton)
            addButton.disable();
    }
};
contractTab.method.createArticleBody = function (sectionStackSectionObj) {

    let form = contractTab.method.createArticleForm(sectionStackSectionObj.data.contractDetailType, sectionStackSectionObj.data.contractDetail, sectionStackSectionObj.data.isNewMode);
    if (form) {

        sectionStackSectionObj.form = form;
        sectionStackSectionObj.items.push(form);
    }

    let grids = contractTab.method.createArticleBodyGrid(sectionStackSectionObj.data.contractDetailType, sectionStackSectionObj.data.contractDetail, sectionStackSectionObj.data.isNewMode);
    if (grids.length) {

        sectionStackSectionObj.grids = grids;
        sectionStackSectionObj.items.addAll(grids);
    }

    let dynamicTableGrids = contractTab.method.createArticleBodyDynamicTableGrid(sectionStackSectionObj.data.contractDetailType, sectionStackSectionObj.data.contractDetail, sectionStackSectionObj.data.isNewMode);
    if (dynamicTableGrids.length) {

        sectionStackSectionObj.dynamicTableGrids = dynamicTableGrids;
        sectionStackSectionObj.items.addAll(dynamicTableGrids);
    }
};
contractTab.method.createArticleForm = function (contractDetailType, contractDetail, isNewMode) {

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
    }

    target.filter(param =>
        param.type !== contractTab.variable.dataType.ListOfReference &&
        param.type !== contractTab.Vars.DataType.DynamicTable).forEach(param => {

        let field = {

            width: "100%",
            key: param.key,
            title: param.name,
            unitId: param.unitId,
            paramType: param.type,
            required: param.required,
            reference: param.reference,
            name: contractDetailType.code + "." + param.key,
            value: getValueFromString(param.type, param[valueKey]),
            vId: !isNewMode ? param.id : null,
            version: !isNewMode ? param.version : null,
            estatus: !isNewMode ? param.estatus : null,
            editable: !isNewMode ? param.editable : null,
            contractDetailId: !isNewMode ? param.contractDetailId : null,
            canEdit: contractTab.dynamicForm.main.getField(param.key) == null,
            colSpan: param.type === contractTab.variable.dataType.TextArea ? 4 : 2,
            changed: function (form, item, value) {

                let This = this;
                if (this.unitId)
                    getReferenceDataSource("Unit").fetchData({
                        operator: "and",
                        _constructor: "AdvancedCriteria",
                        criteria: [{fieldName: "id", operator: "equals", value: This.unitId}]
                    }, (dsResponse, data) => {
                        if (data && data.length === 1)
                            This.setHint(data[0].symbolUnit);
                    });

                return this.Super("changed", arguments)
            }
        };

        if (field.required)
            Object.assign(field, {
                validators: [{
                    type: "required",
                    validateOnChange: true
                }]
            });
        Object.assign(field, getFieldProperties(field.paramType, field.reference));
        fields.push(field);
    });

    return fields.length ? isc.DynamicForm.create({

        numCols: 4,
        width: "85%",
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
    }) : null;
};
contractTab.method.createArticleBodyGrid = function (contractDetailType, contractDetail, isNewMode) {

    let target;
    let grids = [];
    if (!isNewMode) {

        let contractDetailValueGroup = contractDetail.contractDetailValues.filter(x => x.type === contractTab.variable.dataType.ListOfReference).groupBy('reference');
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

    target.forEach(param => {

        let fields = getReferenceFields(param.reference);
        let listGridFirstField = {name: null};
        if (fields && fields.length)
            listGridFirstField = fields[0];

        let grid = isc.ListGrid.create({

            width: "100%",
            height: "300",
            sortField: 1,
            selectionType: "single",
            sortDirection: "ascending",
            canHover: true,
            showHover: true,
            autoFitData: "vertical",
            autoFitDateFields: "both",
            autoFitMaxWidth: "15%",
            autoFitWidthApproach: "both",
            autoFitFieldsFillViewport: true,
            autoFitExpandField: listGridFirstField.name,
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

                this.autoFitFields();
                contractTab.dynamicForm.valuesManager.setValue(this.name, this.getData());

                this.Super("dataChanged", arguments);
            },
            gridComponents: [
                isc.Lable.create({
                    contents: "<h3>" + param.name + "</h3><span style='width: 100%; display: block; border-bottom: 1px solid rgba(0,0,0,0.3);margin-bottom: 3px'></span>"
                }), "header", "body",
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
                            align: 'left',
                            border: 0,
                            members: [
                                isc.ToolStripButton.create({
                                    icon: "pieces/16/save.png",
                                    title: "<spring:message code='global.form.save.temporary'/>",
                                    click: function () {
                                        grid.saveAllEdits();
                                    }
                                })]
                        })
                    ]
                })]
        });

        if (!isNewMode)
            getReferenceDataSource(reference).fetchData({
                    operator: "and",
                    _constructor: "AdvancedCriteria",
                    criteria: [{fieldName: "id", operator: "equals", value: grid.values.map(p => p.value)}]
                }, (dsResponse, data) => grid.setData(data)
            );

        grids.push(grid);
    });

    return grids;
};
contractTab.method.createArticleBodyDynamicTableGrid = function (contractDetailType, contractDetail, isNewMode) {

    // contractTab.Methods.DynamicTableGridCreator(record, sectionStackSectionObj);
};

//****************************************************** Extras *********************************************************

contractTab.listGrid.main.addProperties({
    sortField: 'no',
});