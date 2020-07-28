var contractTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTab.variable.url = "${contextPath}" + "/api/g-contract/"
contractTab.dynamicForm.fields.no = {
    name: "no",
    width: "10%",
    required: true,
    keyPressFilter: "^[A-Za-z0-9]",
    title: "<spring:message code='contract.form.no'/>"
};
contractTab.dynamicForm.fields.date = {
    name: "date",
    type: "date",
    width: "10%",
    required: true,
    title: "<spring:message code='global.date'/>"
};
contractTab.dynamicForm.fields.affectFrom = {
    name: "affectFrom",
    type: "date",
    width: "10%",
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
    width: "10%",
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
contractTab.dynamicForm.fields.buyer = {
    name: "buyerId",
    width: "100%",
    editorType: "SelectItem",
    optionCriteria: {
        operator: 'and',
        criteria: [{
            fieldName: 'buyer',
            operator: 'equals',
            value: true
        }]
    },
    optionDataSource: isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "nameFA"},
            {name: "nameEN"}
        ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    }),
    autoFetchData: false,
    displayField: "nameEN",
    valueField: "id",
    required: true,
    title: "<spring:message code='contact.commercialRole.buyer'/>"
};
contractTab.dynamicForm.fields.seller = {
    name: "sellerId",
    width: "100%",
    editorType: "SelectItem",
    optionCriteria: {
        operator: 'and',
        criteria: [{
            fieldName: 'seller',
            operator: 'equals',
            value: true
        }]
    },
    optionDataSource: isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "nameFA"},
            {name: "nameEN"}
        ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    }),
    autoFetchData: false,
    displayField: "nameEN",
    valueField: "id",
    required: true,
    title: "<spring:message code='contact.commercialRole.seller'/>"
};
contractTab.dynamicForm.fields.agentBuyer = {
    name: "agentBuyerId",
    width: "100%",
    editorType: "SelectItem",
    optionCriteria: {
        operator: 'and',
        criteria: [{
            fieldName: 'agentBuyer',
            operator: 'equals',
            value: true
        }]
    },
    optionDataSource: isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "nameFA"},
            {name: "nameEN"}
        ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    }),
    autoFetchData: false,
    displayField: "nameEN",
    valueField: "id",
    title: "<spring:message code='contact.commercialRole.agentBuyer'/>"
};
contractTab.dynamicForm.fields.agentSeller = {
    name: "agentSellerId",
    width: "100%",
    editorType: "SelectItem",
    optionCriteria: {
        operator: 'and',
        criteria: [{
            fieldName: 'agentSeller',
            operator: 'equals',
            value: true
        }]
    },
    optionDataSource: isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "nameFA"},
            {name: "nameEN"}
        ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    }),
    autoFetchData: false,
    displayField: "nameEN",
    valueField: "id",
    title: "<spring:message code='contact.commercialRole.agentSeller'/>"
};

contractTab.dynamicForm.fields.contractDetailType = {
    name: "contractDetailTypeId",
    width: "100%",
    editorType: "SelectItem",
    optionCriteria: {
        operator: 'and',
        criteria: [{
            fieldName: 'materialId',
            operator: 'equals',
            value: 3
        }]
    },
    optionDataSource: isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "titleEn"}
        ],
        fetchDataURL: "${contextPath}/api/contract-detail-type/spec-list"
    }),
    autoFetchData: false,
    displayField: "titleEn",
    valueField: "id",
    required: false,
    title: "<spring:message code='entity.contract-detail-type'/>",
    changed: function (form, item, value) {
        var record = item.getSelectedRecord();
        var fields = [];
        record.contractDetailTypeParams.forEach(param => {
            var field = {
                width: param.width,
            };
            field.name = param.key;
            field.key = param.key;
            field.title = param.name;
            field.paramType = param.type;
            field.reference = param.reference;
            field.defaultValue = param.defaultValue;
            field.required = param.required;

            Object.assign(field, getParamEditorProperties(field.paramType, field.reference));

            fields.push(field);
        })

        if (contractTab.contractDetailsSectionStack.getSectionNames().includes(value))
            return;
        contractTab.contractDetailsSectionStack.addSection({
            contractDetailId: null,
            name: value,
            title: record.titleEn,
            expanded: true,

            controls: [isc.IButton.create({
                width: 150,
                icon: "[SKIN]/actions/remove.png",
                size: 32,
                click: function () {
                    contractTab.contractDetailsSectionStack.removeSection(record.id + "");
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
                    fields: BaseFormItems.concat(fields, true)
                })
            ]
        });
    }
}

contractTab.dynamicForm.contract = isc.DynamicForm.create({
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
    fields: BaseFormItems.concat([
        contractTab.dynamicForm.fields.no,
        contractTab.dynamicForm.fields.date,
        contractTab.dynamicForm.fields.affectFrom,
        contractTab.dynamicForm.fields.affectUpTo,
        contractTab.dynamicForm.fields.content,
        contractTab.dynamicForm.fields.description,
        contractTab.dynamicForm.fields.material,
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
        contractTab.dynamicForm.fields.affectFrom,
        contractTab.dynamicForm.fields.affectUpTo,
        contractTab.dynamicForm.fields.content,
        contractTab.dynamicForm.fields.description,
        contractTab.dynamicForm.fields.material,
        contractTab.dynamicForm.fields.contractType,
        contractTab.dynamicForm.fields.buyer,
        contractTab.dynamicForm.fields.seller,
        contractTab.dynamicForm.fields.agentBuyer,
        contractTab.dynamicForm.fields.agentSeller
    ], false),
    fetchDataURL: contractTab.variable.url + "spec-list"
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

                    q.items[0].fields.filter(x => x.isBaseItem == undefined).forEach((x, index) => {
                        contractDetailObj.contractDetailValues.push({
                            id: x.contractDetailValueId,
                            name: x.name,
                            key: x.name,
                            type: x.paramType,
                            value: q.items[0].values[x.name],
                            contractDetailId: q.contractDetailId,
                            estatus: x.estatus,
                            editable: x.editable
                            // column: ""
                        });
                    });
                    data.contractDetails.push(contractDetailObj);
                });

                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: contractTab.variable.url,
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
    height: 200,
    sections: []
});

contractTab.window = isc.Window.nicico.getDefault(null, [
    contractTab.dynamicForm.contract,
    contractTab.contractDetailsSectionStack,
    contractTab.hLayout.saveOrExitHlayout
], "85%", null);

//*************************************************** Functions ********************************************************

contractTab.method.addData = function () {
    contractTab.variable.method = "POST";
    contractTab.dynamicForm.contract.clearValues();
    contractTab.contractDetailsSectionStack.getSectionNames().forEach(q => contractTab.contractDetailsSectionStack.removeSection(q + ""));
    contractTab.window.setTitle("<spring:message code='contract.window.title.add'/>");
    contractTab.window.show();
};
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
            var fields = [];
            q.contractDetailType.contractDetailValues.forEach(detailValue => {
                var field = {
                    width: detailValue.width,
                };
                field.name = detailValue.key;
                field.key = detailValue.key;
                field.title = detailValue.name;
                field.paramType = detailValue.type;
                field.reference = detailValue.reference;
                field.defaultValue = detailValue.value;
                field.required = detailValue.required;
                field.contractDetailValueId = detailValue.id;
                field.estatus = detailValue.estatus;
                field.editable = detailValue.editable;

                Object.assign(field, getParamEditorProperties(field.paramType, field.reference));

                fields.push(field);
            })

            contractTab.contractDetailsSectionStack.addSection({
                contractDetailId: q.id,
                name: q.contractDetailTypeId,
                title: q.contractDetailType.titleEn,
                expanded: true,

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
                        fields: BaseFormItems.concat(fields, true)
                    })
                ]
            });
        });

        contractTab.window.setTitle("<spring:message code='contract.window.title.edit'/>");
        contractTab.window.show();
    }
};

function getParamEditorProperties(paramType, reference) {
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
        case 'Reference':
            return {
                width: "100%",
                type: "integer",
                editorType: "SelectItem",
                valueField: "id",
                autoFetchData: false,
                optionDataSource: isc.MyRestDataSource.create({
                    fields: [
                        {name: "id", title: "id", primaryKey: true, hidden: true},
                        {name: "port"}
                    ],
                    fetchDataURL: "${contextPath}/api/" + reference.toLowerCase() + "/spec-list"
                }),
                displayField: getDisplayField(reference)
            };
        case 'Column':
        default:
            break;
    }

    return null;
}

function getDisplayField(referenceType) {
    switch (referenceType) {
        case 'Bank':
            return 'bankName';
        case 'Contact':
            return 'nameFA';
        case 'Country':
            return 'nameFa';
        case 'Currency':
            return 'nameFa';
        case 'Material':
            return 'descp';
        case 'Port':
            return 'port';
        case 'Unit':
            return 'nameFA';
        case 'RateReference':
            return '';
        case 'PriceBaseReference':
            return '';
        default:
            break;
    }

    return null;
}

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
                    actionURL: contractTab.variable.url + record.id,
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
        contractTab.method.addData();
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
