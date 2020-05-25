var incotermTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermTab.variable.incotermDetails = [];
incotermTab.variable.incotermPartyData = [];
incotermTab.variable.incotermAspectData = [];
incotermTab.variable.incotermPartyFetched = false;
incotermTab.variable.incotermAspectFetched = false;
incotermTab.variable.incotermFormUrl = "${contextPath}" + "/api/incoterm-form/";
incotermTab.variable.incotermStepUrl = "${contextPath}" + "/api/incoterm-step/";
incotermTab.variable.incotermRuleUrl = "${contextPath}" + "/api/incoterm-rule/";
incotermTab.variable.incotermStepsUrl = "${contextPath}" + "/api/incoterm-steps/";
incotermTab.variable.incotermRulesUrl = "${contextPath}" + "/api/incoterm-rules/";
incotermTab.variable.incotermPartyUrl = "${contextPath}" + "/api/incoterm-party/";
incotermTab.variable.incotermAspectUrl = "${contextPath}" + "/api/incoterm-aspect/";
incotermTab.variable.incotermDetailUrl = "${contextPath}" + "/api/incoterm-detail/";

//***************************************************** RESTDATASOURCE *************************************************

incotermTab.restDataSource.incotermStep = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
        {
            name: "code",
            showHover: true,
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "titleFa",
            showHover: true,
            title: "<spring:message code='global.title-fa'/>"
        },
        {
            name: "titleEn",
            showHover: true,
            title: "<spring:message code='global.title-en'/>"
        }
    ]),
    fetchDataURL: incotermTab.variable.incotermStepUrl + "spec-list"
});
incotermTab.restDataSource.incotermRule = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
        {
            name: "code",
            showHover: true,
            title: "<spring:message code='global.code'/>"
        },
        {
            name: "titleFa",
            showHover: true,
            title: "<spring:message code='global.title-fa'/>"
        },
        {
            name: "titleEn",
            showHover: true,
            title: "<spring:message code='global.title-en'/>"
        }
    ]),
    fetchDataURL: incotermTab.variable.incotermRuleUrl + "spec-list"
});

//******************************************************* COMPONENTS ***************************************************

incotermTab.listGrid.incotermStep = isc.ListGrid.nicico.getDefault(
    null,
    incotermTab.restDataSource.incotermStep, null, {
        canReorderRecords: true,
        showFilterEditor: false,
        selectionType: "simple",
        selectionAppearance: "checkbox"
    }
);
incotermTab.listGrid.incotermRule = isc.ListGrid.nicico.getDefault(
    null,
    incotermTab.restDataSource.incotermRule, null, {
        canReorderRecords: true,
        showFilterEditor: false,
        selectionType: "simple",
        selectionAppearance: "checkbox",
        findForm: new nicico.FindFormUtil(),
        recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {

            let selectionCount = this.selectionAppearance.toLowerCase() === "checkbox" ? Number.MAX_VALUE : 0;

            this.findForm.okCallBack = function (selectedRecords) {

                record.incotermForms = selectedRecords;
            };
            this.findForm.showFindFormByRestApiUrl(
                incotermTab.window.incoterm, "60%", "500", "<spring:message code='incoterm.window.incoterm-forms.select'/>",
                record.incotermForms, incotermTab.variable.incotermFormUrl + "spec-list",
                BaseFormItems.concat([{
                    name: "code",
                    title: "<spring:message code='global.code'/>"
                }, {
                    name: "title",
                    title: "<spring:message code='global.title'/>",
                }, {
                    name: "order",
                    type: "integer",
                    canEdit: true,
                    validators: [
                        {type: "integerRange", min: 0, max: 255}
                    ],
                    title: "<spring:message code='global.order'/>",
                }]), null, null, selectionCount);
        }
    }
);
incotermTab.dynamicForm.fields = BaseFormItems.concat([{
    name: "title",
    width: "100%",
    required: true,
    title: "<spring:message code='global.title'/>"
}, {
    width: "100%",
    required: true,
    name: "incotermVersion",
    keyPressFilter: "^[0-9]",
    title: "<spring:message code='global.version'/>"
}, {
    type: "date",
    width: "100%",
    required: true,
    name: "publishDate",
    title: "<spring:message code='incoterm.form.publish-date'/>",
    formatCellValue: function (value, record, rowNum, colNum, grid) {

        return new Date(value);
    }
}, {
    colSpan: 6,
    width: "100%",
    name: "description",
    editorType: "textArea",
    title: "<spring:message code='global.description'/>",
}]);
incotermTab.dynamicForm.incoterm = isc.DynamicForm.create({

    width: "100%",
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
    fields: incotermTab.dynamicForm.fields
});
incotermTab.button.continue = isc.IButtonSave.create({

    margin: 10,
    height: 50,
    icon: "pieces/16/return.png",
    title: "<spring:message code='global.continue'/>",
    click: function () {

        let incotermId = incotermTab.dynamicForm.incoterm.getValue("id");
        if (incotermId != null) {

            incotermTab.window.incoterm.close();
            incotermTab.method.showDetailWindow(incotermId);
        }
    }
});
incotermTab.button.save = isc.IButtonSave.create({

    margin: 10,
    height: 50,
    icon: "pieces/16/save.png",
    title: "<spring:message code='global.form.save'/>",
    click: function () {

        incotermTab.dynamicForm.incoterm.validate();
        let steps = incotermTab.listGrid.incotermStep.getData().localData.filter(q => q[incotermTab.listGrid.incotermStep.selection.selectionProperty]);
        let rules = incotermTab.listGrid.incotermRule.getData().localData.filter(q => q[incotermTab.listGrid.incotermRule.selection.selectionProperty]);
        if (incotermTab.dynamicForm.incoterm.hasErrors() || steps.length === 0 || rules.length === 0) {

            isc.say('<spring:message code="incoterm.exception.required-info"/>');
            return;
        }

        let data = incotermTab.dynamicForm.incoterm.getValues();
        let order = 0;
        data.incotermSteps = steps.map(q => {
            return {incotermStepId: q.id, order: ++order}
        });
        order = 0;
        data.incotermRules = rules.map(q => {
            return {
                order: ++order,
                incotermRuleId: q.id,
                incotermForms: q.incotermForms ? q.incotermForms.map(p => {
                    return {
                        order: p.order,
                        incotermFormId: p.id
                    };
                }) : []
            };
        });
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            data: JSON.stringify(data),
            actionURL: incotermTab.variable.url,
            httpMethod: incotermTab.variable.method,
            callback: function (response) {
                if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {

                    incotermTab.window.incoterm.close();
                    incotermTab.method.refresh(incotermTab.listGrid.main);

                    let incotermId = JSON.parse(response.httpResponseText).id;
                    incotermTab.method.showDetailWindow(incotermId);
                } else
                    incotermTab.dialog.error(response);
            }
        }));
    }
});
incotermTab.button.cancel = isc.IButtonCancel.create({

    margin: 10,
    height: 50,
    icon: "pieces/16/icon_delete.png",
    title: "<spring:message code='global.cancel'/>",
    click: function () {
        incotermTab.window.incoterm.close();
    }
});
incotermTab.window.incoterm = isc.Window.nicico.getDefault(null, [

    incotermTab.dynamicForm.incoterm,
    isc.HLayout.create({
        width: "100%",
        height: "450",
        align: "center",
        members: [
            incotermTab.listGrid.incotermStep,
            incotermTab.listGrid.incotermRule
        ]
    }),
    isc.HLayout.create({
        width: "100%",
        members: [
            incotermTab.button.save,
            incotermTab.button.cancel,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [incotermTab.button.continue]
            })
        ]
    })
], "60%");

Object.assign(incotermTab.listGrid.fields, incotermTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermTab, "api/g-incoterm/");

//*************************************************** Functions ********************************************************

incotermTab.method.newForm = function () {

    if (!incotermTab.variable.incotermPartyFetched || !incotermTab.variable.incotermAspectFetched) {

        incotermTab.dialog.say("<spring:message code='global.wait.for.loading'/>");
        return;
    }

    incotermTab.variable.incotermDetails = [];

    incotermTab.dynamicForm.incoterm.clearValues();
    incotermTab.listGrid.incotermStep.deselectAllRecords();
    incotermTab.listGrid.incotermRule.deselectAllRecords();
    incotermTab.listGrid.incotermStep.setSelectionAppearance("checkbox");
    incotermTab.listGrid.incotermRule.setSelectionAppearance("checkbox");
    incotermTab.listGrid.incotermStep.data.localData.forEach(q => q.enabled = true);
    incotermTab.listGrid.incotermRule.data.localData.forEach(q => {

        q.enabled = true;
        delete q.incotermForms
    });

    incotermTab.variable.method = "POST";
    incotermTab.button.continue.hide();
    incotermTab.window.incoterm.show();
};
incotermTab.method.editForm = function () {

    if (!incotermTab.variable.incotermPartyFetched || !incotermTab.variable.incotermAspectFetched) {

        incotermTab.dialog.say("<spring:message code='global.wait.for.loading'/>");
        return;
    }

    let record = incotermTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        incotermTab.dialog.notSelected();
    else if (record.editable === false)
        incotermTab.dialog.notEditable();
    else {

        incotermTab.method.jsonRPCManagerRequest({
            httpMethod: "GET",
            actionURL: incotermTab.variable.incotermDetailUrl + "spec-list",
            params: {
                criteria: {
                    operator: "and",
                    criteria: [
                        {fieldName: "incotermSteps.incotermId", operator: "equals", value: record.id}
                    ]
                }
            },
            callback: function (response) {

                incotermTab.variable.incotermDetails = JSON.parse(response.httpResponseText).response.data;

                incotermTab.dynamicForm.incoterm.editRecord(record);

                if (incotermTab.variable.incotermDetails.length !== 0) {

                    incotermTab.listGrid.incotermStep.deselectAllRecords();
                    incotermTab.listGrid.incotermRule.deselectAllRecords();
                    incotermTab.listGrid.incotermStep.setSelectionAppearance("rowStyle");
                    incotermTab.listGrid.incotermRule.setSelectionAppearance("rowStyle");

                    let ids = record.incotermSteps.map(q => q.incotermStepId);
                    incotermTab.listGrid.incotermStep.data.localData.forEach(q => {
                        q.enabled = ids.contains(q.id);
                    });

                    incotermTab.listGrid.incotermRule.data.localData.forEach(q => {
                        let rule = record.incotermRules.filter(p => p.incotermRuleId === q.id).first();
                        if (rule != null) {
                            q.enabled = true;
                            q.incotermForms = rule.incotermForms;
                        } else q.enabled = false;
                    });
                } else {

                    incotermTab.listGrid.incotermStep.deselectAllRecords();
                    incotermTab.listGrid.incotermRule.deselectAllRecords();
                    incotermTab.listGrid.incotermStep.setSelectionAppearance("checkbox");
                    incotermTab.listGrid.incotermRule.setSelectionAppearance("checkbox");

                    let ids = record.incotermSteps.map(q => q.incotermStepId);
                    incotermTab.listGrid.incotermStep.data.localData.forEach(q => {
                        if (ids.contains(q.id))
                            incotermTab.listGrid.incotermStep.selectRecord(q);
                    });
                    incotermTab.listGrid.incotermRule.data.localData.forEach(q => {
                        let rule = record.incotermRules.filter(p => p.incotermRuleId === q.id).first();
                        if (rule != null) {
                            incotermTab.listGrid.incotermRule.selectRecord(q);
                            q.incotermForms = rule.incotermForms;
                        }
                    });
                }

                incotermTab.variable.method = "PUT";
                incotermTab.button.continue.show();
                incotermTab.window.incoterm.show();
            }
        });
    }
};
incotermTab.method.showDetailWindow = function (incotermId) {

    incotermTab.method.jsonRPCManagerRequest({
        httpMethod: "GET",
        actionURL: incotermTab.variable.incotermStepsUrl + "spec-list",
        params: {
            criteria: {
                _sortBy: "order",
                operator: "and",
                criteria: [{
                    fieldName: "incotermId",
                    operator: "equals",
                    value: incotermId
                }]
            }
        },
        callback: function (stepsResponse) {
            let incotermStepsData = JSON.parse(stepsResponse.httpResponseText).response.data;
            incotermTab.method.jsonRPCManagerRequest({
                httpMethod: "GET",
                actionURL: incotermTab.variable.incotermRulesUrl + "spec-list",
                params: {
                    criteria: {
                        _sortBy: "order",
                        operator: "and",
                        criteria: [{
                            fieldName: "incotermId",
                            operator: "equals",
                            value: incotermId
                        }]
                    }
                },
                callback: function (rulesResponse) {
                    let incotermRulesData = JSON.parse(rulesResponse.httpResponseText).response.data;
                    isc.Window.nicico.getDefault2(null, isc.IncotermTable.create({
                        rulesDataSource: incotermRulesData,
                        stepsDataSource: incotermStepsData,
                        dataSource: incotermTab.variable.incotermDetails,
                        partyDataSource: incotermTab.variable.incotermPartyData,
                        aspectDataSource: incotermTab.variable.incotermAspectData
                    }), "80%", null, "IncotermTab_IncotermTable").show();
                }
            });
        }
    });
};

//************************************************* Rest Requests ******************************************************

incotermTab.method.jsonRPCManagerRequest({
    httpMethod: "GET",
    actionURL: incotermTab.variable.incotermPartyUrl + "spec-list",
    callback: function (response) {

        incotermTab.variable.incotermPartyData = JSON.parse(response.httpResponseText).response.data;
        incotermTab.variable.incotermPartyFetched = true;
    }
});
incotermTab.method.jsonRPCManagerRequest({
    httpMethod: "GET",
    actionURL: incotermTab.variable.incotermAspectUrl + "spec-list",
    callback: function (response) {

        incotermTab.variable.incotermAspectData = JSON.parse(response.httpResponseText).response.data;
        incotermTab.variable.incotermAspectFetched = true;
    }
});
