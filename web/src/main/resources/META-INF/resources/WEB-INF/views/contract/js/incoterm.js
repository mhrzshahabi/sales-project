var incotermTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermTab.variable.incotermDetails = [];
incotermTab.variable.incotermFormData = [];
incotermTab.variable.incotermPartyData = [];
incotermTab.variable.incotermAspectData = [];
incotermTab.variable.incotermFormFetched = false;
incotermTab.variable.incotermPartyFetched = false;
incotermTab.variable.incotermAspectFetched = false;
incotermTab.variable.incotermFormUrl = "${contextPath}" + "/api/incoterm-form/";
incotermTab.variable.incotermStepUrl = "${contextPath}" + "/api/incoterm-step/";
incotermTab.variable.incotermRuleUrl = "${contextPath}" + "/api/incoterm-rule/";
incotermTab.variable.incotermStepsUrl = "${contextPath}" + "/api/incoterm-steps/";
incotermTab.variable.incotermRulesUrl = "${contextPath}" + "/api/incoterm-rules/";
incotermTab.variable.incotermPartyUrl = "${contextPath}" + "/api/incoterm-party/";
incotermTab.variable.incotermAspectUrl = "${contextPath}" + "/api/incoterm-aspect/";
incotermTab.variable.incotermVersionUrl = "${contextPath}" + "/api/incoterm-version/";
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
        // recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
        //
        //     if (this.selectionAppearance.toLowerCase() !== "checkbox")
        //         return;
        //     if (!incotermTab.variable.incotermFormFetched ||
        //         incotermTab.variable.incotermFormData == null ||
        //         incotermTab.variable.incotermFormData.length === 0) {
        //
        //         incotermTab.dialog.say("<spring:message code='global.wait.for.loading'/>");
        //         return;
        //     }
        //     if (record.incotermForms == null)
        //         record.incotermForms = [];
        //     let data = [];
        //     incotermTab.variable.incotermFormData.forEach(item => {
        //
        //         data.add({...item, order: 0});
        //         let forms = record.incotermForms.filter(q => q.incotermFormId === item.id).first();
        //         if (forms) {
        //             data.order = forms.order;
        //             data["_checkBoxField"] = true;
        //         }
        //     });
        //     let This = this;
        //     this.findForm.okCallBack = function (selectedRecords) {
        //
        //         let grid = This.findForm.listGridWidget.getObject();
        //         grid.saveAllEdits();
        //         record.incotermForms = grid.getSelectedRecords().map(q => {
        //             return {order: q.order, incotermFormId: q.id, incotermRulesId: record.id};
        //         });
        //     };
        //     this.findForm.showFindFormByData(
        //         null, "500", "400", "<spring:message code='incoterm.window.incoterm-forms.select'/>",
        //         data, null,
        //         BaseFormItems.concat([{
        //             name: "code",
        //             title: "<spring:message code='global.code'/>"
        //         }, {
        //             name: "title",
        //             title: "<spring:message code='global.title'/>",
        //         }, {
        //             name: "order",
        //             type: "integer",
        //             canEdit: true,
        //             validators: [
        //                 {type: "integerRange", min: 0, max: 255}
        //             ],
        //             title: "<spring:message code='global.order'/>"
        //         }]), Number.MAX_VALUE);
        // }
    }
);
incotermTab.dynamicForm.fields = BaseFormItems.concat([{
    name: "title",
    width: "100%",
    required: true,
    title: "<spring:message code='global.title'/>"
},
    {
        type: 'number',
        name: "incotermVersionId",
        title: "<spring:message code='global.version'/>",
        width: "100%",
        required: true,
        autoFetchData: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "incotermVersion",
        pickListHeight: "300",
        optionDataSource: isc.MyRestDataSource.create({
            fields: BaseFormItems.concat([
                {name: "id"},
                {name: "incotermVersion"}
            ]),
            fetchDataURL: incotermTab.variable.incotermVersionUrl + "spec-list"
        }),
        pickListFields: [
            {name: "id", title: '<spring:message code="global.code"/>'},
            {name: "incotermVersion", title: '<spring:message code="global.version"/>'}
        ]
    },
    {
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
            incotermTab.method.showDetailWindow(incotermId, incotermTab.dynamicForm.incoterm.getValue("title"));
        }
    }
});
incotermTab.button.save = isc.IButtonSave.create({
    margin: 10,
    height: 50,
    click: function () {
        incotermTab.dynamicForm.incoterm.validate();
        let steps = incotermTab.listGrid.incotermStep.getData().localData.filter(q => q[incotermTab.listGrid.incotermStep.selection.selectionProperty]);
        let rules = incotermTab.listGrid.incotermRule.getData().localData.filter(q => q[incotermTab.listGrid.incotermRule.selection.selectionProperty]);

        console.log(incotermTab.listGrid.incotermStep.getData().localData)
        console.log(incotermTab.listGrid.incotermRule.getData().localData)

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

                    let incotermData = JSON.parse(response.httpResponseText);
                    incotermTab.method.showDetailWindow(incotermData.id, incotermData.title);
                } else
                    incotermTab.dialog.error(response);
            }
        }));
    }
});
incotermTab.button.cancel = isc.IButtonCancel.create({

    margin: 10,
    height: 50,
    click: function () {
        incotermTab.window.incoterm.close();
    }
});
incotermTab.window.incoterm = isc.Window.nicico.getDefault('<spring:message code="entity.incoterm"/>', [

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
nicico.BasicFormUtil.removeExtraGridMenuActions(incotermTab);

//*************************************************** Functions ********************************************************

incotermTab.method.newForm = function () {

    if (!incotermTab.variable.incotermPartyFetched || !incotermTab.variable.incotermAspectFetched) {

        incotermTab.dialog.say("<spring:message code='global.wait.for.loading'/>");
        return;
    }

    incotermTab.variable.incotermDetails = [];

    incotermTab.button.save.show();
    incotermTab.dynamicForm.incoterm.clearValues();
    incotermTab.listGrid.incotermStep.deselectAllRecords();
    incotermTab.listGrid.incotermRule.deselectAllRecords();
    incotermTab.listGrid.incotermStep.setSelectionType("simple");
    incotermTab.listGrid.incotermRule.setSelectionType("simple");
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
    else if (record.estatus.contains(Enums.eStatus2.DeActive))
        incotermTab.dialog.inactiveRecord();
    else if (record.estatus.contains(Enums.eStatus2.Final))
        incotermTab.dialog.finalRecord();
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

                    incotermTab.button.save.hide();
                    incotermTab.listGrid.incotermStep.deselectAllRecords();
                    incotermTab.listGrid.incotermRule.deselectAllRecords();
                    incotermTab.listGrid.incotermStep.setSelectionType("single");
                    incotermTab.listGrid.incotermRule.setSelectionType("single");
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

                    incotermTab.button.save.show();
                    incotermTab.listGrid.incotermStep.deselectAllRecords();
                    incotermTab.listGrid.incotermRule.deselectAllRecords();
                    incotermTab.listGrid.incotermStep.setSelectionType("simple");
                    incotermTab.listGrid.incotermRule.setSelectionType("simple");
                    incotermTab.listGrid.incotermStep.setSelectionAppearance("checkbox");
                    incotermTab.listGrid.incotermRule.setSelectionAppearance("checkbox");

                    let ids = record.incotermSteps.map(q => q.incotermStepId);
                    incotermTab.listGrid.incotermStep.data.localData.forEach(q => {
                        q.enabled = true;
                        if (ids.contains(q.id))
                            incotermTab.listGrid.incotermStep.selectRecord(q);
                    });
                    incotermTab.listGrid.incotermRule.data.localData.forEach(q => {
                        q.enabled = true;
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
incotermTab.method.showDetailWindow = function (incotermId, title) {

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
                    isc.Window.nicico.getDefault2("<spring:message code='entity.incoterm-detail'/>", isc.IncotermTable.create({
                        title: title,
                        rulesDataSource: incotermRulesData,
                        stepsDataSource: incotermStepsData,
                        dataSource: incotermTab.variable.incotermDetails,
                        partyDataSource: incotermTab.variable.incotermPartyData,
                        aspectDataSource: incotermTab.variable.incotermAspectData
                    }), "10%", null, "IncotermTab_IncotermTable").show();
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
incotermTab.method.jsonRPCManagerRequest({
    httpMethod: "GET",
    actionURL: incotermTab.variable.incotermFormUrl + "spec-list",
    callback: function (response) {

        incotermTab.variable.incotermFormData = JSON.parse(response.httpResponseText).response.data;
        incotermTab.variable.incotermFormFetched = true;
    }
});
