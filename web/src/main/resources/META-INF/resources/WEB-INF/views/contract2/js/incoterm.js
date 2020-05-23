var incotermTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermTab.variable.incotermStepUrl = "${contextPath}" + "/api/incoterm-step/";
incotermTab.variable.incotermRuleUrl = "${contextPath}" + "/api/incoterm-rule/";
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

            this.findForm.okCallBack = function (selectedRecords) {

                record.incotermForms = selectedRecords;
            };
            this.findForm.showFindFormByRestApiUrl(
                null, "<spring:message code='incoterm.window.forms.select'/>",
                record.incotermForms, '<spring:url value="/incoterm-form/spec-list"/>',
                BaseFormItems.concat([{
                    name: "code",
                    title: "<spring:message code='global.code'/>"
                }, {
                    name: "title",
                    title: "<spring:message code='global.title-fa'/>",
                }, {
                    name: "order",
                    type: "integer",
                    canEdit: true,
                    validators: [
                        {type: "integerRange", min: 0, max: 255}
                    ],
                    title: "<spring:message code='global.order'/>",
                }]), null, null, Number.MAX_VALUE);
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
            isc.IButtonSave.create({

                margin: 10,
                height: 50,
                icon: "pieces/16/save.png",
                title: "<spring:message code='global.form.save'/>",
                click: function () {

                    incotermTab.dynamicForm.incoterm.validate();
                    let steps = incotermTab.listGrid.incotermStep.getSelectedRecords();
                    let rules = incotermTab.listGrid.incotermRule.getSelectedRecords();
                    if (incotermTab.dynamicForm.incoterm.hasErrors() || steps.length === 0 || rules.length === 0) {

                        isc.say('<spring:message code="incoterm.exception.required-info"/>');
                        return;
                    }

                    let data = incotermTab.dynamicForm.incoterm.getValues();
                    data.incotermStepIds = steps.map(q => q.id);
                    data.incotermRules = rules.map(q => {
                        return {
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
                                incotermTab.dialog.ok();
                                incotermTab.window.incoterm.close();
                                incotermTab.method.refresh(incotermTab.listGrid.main);

                                // TODO => open incoterm detail window
                            } else
                                incotermTab.dialog.error(response);
                        }
                    }));
                }
            }),
            isc.IButtonCancel.create({

                margin: 10,
                height: 50,
                icon: "pieces/16/icon_delete.png",
                title: "<spring:message code='global.cancel'/>",
                click: function () {
                    incotermTab.window.incoterm.close();
                }
            }),
        ]
    })
], "60%");

Object.assign(incotermTab.listGrid.fields, incotermTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermTab, "api/g-incoterm/");

//*************************************************** Functions ********************************************************

incotermTab.method.newForm = function () {

    incotermTab.variable.incotermDetails = null;

    incotermTab.dynamicForm.incoterm.clearValues();
    incotermTab.listGrid.incotermStep.deselectAllRecords();
    incotermTab.listGrid.incotermRule.deselectAllRecords();
    incotermTab.listGrid.incotermRule.data.localData.forEach(q => delete q.incotermForms);

    incotermTab.listGrid.incotermStep.enable();
    incotermTab.listGrid.incotermRule.enable();

    incotermTab.variable.method = "POST";
    incotermTab.window.incoterm.show();
};
incotermTab.method.editForm = function () {

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
                }
            },
            response => {

                incotermTab.variable.incotermDetails = JSON.parse(response.httpResponseText).response.data;

                incotermTab.dynamicForm.incoterm.editRecord(record);
                incotermTab.listGrid.incotermStep.deselectAllRecords();
                let ids = record.incotermSteps.map(q => q.incotermStepId);
                incotermTab.listGrid.incotermStep.data.localData.forEach(q => {
                    if (ids.contains(q.id))
                        incotermTab.listGrid.incotermStep.selectRecord(q);
                });
                incotermTab.listGrid.incotermRule.deselectAllRecords();
                incotermTab.listGrid.incotermRule.data.localData.forEach(q => {
                    let rule = record.incotermRules.filter(p => p.incotermRuleId === q.id).first();
                    if (rule != null) {
                        incotermTab.listGrid.incotermRule.selectRecord(q);
                        q.incotermForms = rule.incotermForms;
                    }
                });

                if (incotermTab.variable.incotermDetails.length !== 0) {

                    incotermTab.listGrid.incotermStep.disable();
                    incotermTab.listGrid.incotermRule.disable();
                }

                incotermTab.variable.method = "PUT";
                incotermTab.window.incoterm.show();
            }
        );
    }
};
