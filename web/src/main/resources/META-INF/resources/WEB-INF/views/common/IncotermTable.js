var incotermTableTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

//******************************************************* VARIABLES *************************************************-**

incotermTableTab.variable.dataForEdit = null;
incotermTableTab.variable.url = "${contextPath}" + "/api/g-incoterm/";
incotermTableTab.variable.termUrl = "${contextPath}" + "/api/term/";
incotermTableTab.variable.incotermStepUrl = "${contextPath}" + "/api/incoterm-step/";
incotermTableTab.variable.incotermRuleUrl = "${contextPath}" + "/api/incoterm-rule/";
incotermTableTab.variable.incotermPartyUrl = "${contextPath}" + "/api/incoterm-party/";
incotermTableTab.variable.incotermAspectUrl = "${contextPath}" + "/api/incoterm-aspect/";

//***************************************************** RESTDATASOURCE *************************************************

incotermTableTab.restDataSource.term = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            hidden: true,
            primaryKey: true,
            title: "<spring:message code='global.id'/>"
        },
        {
            name: "code",
            title: "<spring:message code='global.code'/>"
        }, {
            name: "titleFa",
            title: "<spring:message code='global.title-fa'/>",
        }, {
            name: "titleEn",
            title: "<spring:message code='global.title-en'/>"
        }
    ],
    fetchDataURL: incotermTableTab.variable.termUrl + "spec-list"
});
incotermTableTab.restDataSource.incotermStep = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            hidden: true,
            primaryKey: true,
            title: "<spring:message code='global.id'/>"
        }, {
            name: "code",
            title: "<spring:message code='global.code'/>"
        }, {
            name: "titleFa",
            title: "<spring:message code='global.title-fa'/>",
        }, {
            name: "titleEn",
            title: "<spring:message code='global.title-en'/>"
        }
    ],
    fetchDataURL: incotermTableTab.variable.incotermStepUrl + "spec-list"
});
incotermTableTab.restDataSource.incotermRule = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            hidden: true,
            primaryKey: true,
            title: "<spring:message code='global.id'/>"
        },
        {
            name: "code",
            title: "<spring:message code='global.code'/>"
        }, {
            name: "titleFa",
            title: "<spring:message code='global.title-fa'/>",
        }, {
            name: "titleEn",
            title: "<spring:message code='global.title-en'/>"
        }
    ],
    fetchDataURL: incotermTableTab.variable.incotermRuleUrl + "spec-list"
});
incotermTableTab.restDataSource.incotermParty = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            hidden: true,
            primaryKey: true,
            title: "<spring:message code='global.id'/>"
        },
        {
            name: "code",
            title: "<spring:message code='global.code'/>"
        }, {
            name: "titleFa",
            title: "<spring:message code='global.title-fa'/>",
        }, {
            name: "titleEn",
            title: "<spring:message code='global.title-en'/>"
        }
    ],
    fetchDataURL: incotermTableTab.variable.incotermPartyUrl + "spec-list"
});
incotermTableTab.restDataSource.incotermAspect = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            hidden: true,
            primaryKey: true,
            title: "<spring:message code='global.id'/>"
        },
        {
            name: "code",
            title: "<spring:message code='global.code'/>"
        }, {
            name: "titleFa",
            title: "<spring:message code='global.title-fa'/>",
        }, {
            name: "titleEn",
            title: "<spring:message code='global.title-en'/>"
        }
    ],
    fetchDataURL: incotermTableTab.variable.incotermAspectUrl + "spec-list"
});

//******************************************************* COMPONENTS ***************************************************

incotermTableTab.dynamicForm.incoterm = isc.DynamicForm.create({

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
    fields: BaseFormItems.concat([
        {
            width: "50%",
            name: "title",
            required: true,
            title: "<spring:message code='global.title'/>"
        },
        {
            width: "50%",
            required: true,
            name: "incotermVersion",
            title: "<spring:message code='global.version'/>"
        },
        {
            width: "50%",
            type: "date",
            name: "publishDate",
            title: "<spring:message code='incoterm.form.publish-date'/>"
        },
        {
            colSpan: 6,
            width: "100%",
            name: "description",
            editorType: "textArea",
            title: "<spring:message code='global.description'/>",
        }
    ], true)
});
incotermTableTab.listGrid.incotermStep = isc.ListGrid.nicico.getDefault(
    BaseFormItems.concat([
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
    incotermTableTab.restDataSource.incotermStep, null, {
        height: 500,
        showFilterEditor: false,
        selectionType: "simple",
        selectionAppearance: "checkbox",
        dataArrived: function (startRow, endRow) {

            if (incotermTableTab.variable.dataForEdit == null || incotermTableTab.variable.dataForEdit.length === 0)
                return;

            let incotermStepIds = incotermTableTab.variable.dataForEdit.map(q => q.incotermStepId).distinct();
            this.data.forEach(q => {
                if (incotermStepIds.contains(q.id))
                    this.selectRecord(q);
            });
        }
    }
);
incotermTableTab.listGrid.incotermRule = isc.ListGrid.nicico.getDefault(
    BaseFormItems.concat([
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
    incotermTableTab.restDataSource.incotermRule, null, {
        height: 370,
        showFilterEditor: false,
        selectionType: "simple",
        selectionAppearance: "checkbox",
        dataArrived: function (startRow, endRow) {

            if (incotermTableTab.variable.dataForEdit == null || incotermTableTab.variable.dataForEdit.length === 0)
                return;

            let incotermRuleIds = incotermTableTab.variable.dataForEdit.map(q => q.incotermRuleId).distinct();
            this.data.forEach(q => {
                if (incotermRuleIds.contains(q.id))
                    this.selectRecord(q);
            });
        }
    }
);
incotermTableTab.listGrid.incotermAspect = isc.ListGrid.nicico.getDefault(
    BaseFormItems.concat([
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
    incotermTableTab.restDataSource.incotermAspect, null, {
        height: 120,
        showFilterEditor: false,
        selectionType: "simple",
        selectionAppearance: "checkbox",
        dataArrived: function (startRow, endRow) {

            if (incotermTableTab.variable.dataForEdit == null || incotermTableTab.variable.dataForEdit.length === 0)
                return;

            let incotermAspectIds = incotermTableTab.variable.dataForEdit.map(q => q.incotermAspectId).distinct();
            this.data.forEach(q => {
                if (incotermAspectIds.contains(q.id))
                    this.selectRecord(q);
            });
        }
    }
);
incotermTableTab.window.incoterm = isc.Window.nicico.getDefault(null, [

    incotermTableTab.dynamicForm.incoterm,
    isc.HLayout.create({
        width: "100%",
        padding: 10,
        membersMargin: 10,
        members: [
            incotermTableTab.listGrid.incotermStep,
            isc.VLayout.create({
                width: "100%",
                membersMargin: 10,
                members: [incotermTableTab.listGrid.incotermAspect, incotermTableTab.listGrid.incotermRule]
            })
        ]
    }),
    isc.IButtonSave.create({

        margin: 10,
        height: 50,
        icon: "pieces/16/save.png",
        title: "<spring:message code='global.ok'/>",
        click: function () {

            incotermTableTab.dynamicForm.incoterm.validate();
            let steps = incotermTableTab.listGrid.incotermStep.getSelectedRecords();
            let rules = incotermTableTab.listGrid.incotermRule.getSelectedRecords();
            let aspects = incotermTableTab.listGrid.incotermAspect.getSelectedRecords();
            if (incotermTableTab.dynamicForm.incoterm.hasErrors() || steps.length === 0 || rules.length === 0 || aspects.length === 0) {

                isc.say('<spring:message code="incoterm.exception.required-info"/>');
                return;
            }

            incotermTableTab.restDataSource.incotermParty.fetchData(null, data => {

                let fields = [{width: 150, type: "IncotermRule"}];
                steps.forEach(q => fields.add({
                    width: 100,
                    ref: q.id,
                    name: q.code,
                    title: q.titleEn
                }));

                let records = [];
                for (let i = 0; i < rules.length; i++) {

                    records.add({incotermDetails: []});
                    for (let j = 0; j < steps.length; j++)
                        for (let k = 0; k < aspects.length; k++)
                            if (incotermTableTab.variable.dataForEdit == null || incotermTableTab.variable.dataForEdit.length === 0)
                                records.incotermDetails.add({
                                    incotermStepId: steps[j].id,
                                    incotermRuleId: rules[i].id,
                                    incotermAspectId: aspects[k].id,
                                });
                            else {

                                let incotermDetail = incotermTableTab.variable.dataForEdit.filter(q =>
                                    q.incotermStepId === steps[j].id &&
                                    q.incotermRuleId === rules[i].id &&
                                    q.incotermAspectId === aspects[k].id
                                ).first();
                                records.incotermDetails.add({
                                    incotermStepId: steps[j].id,
                                    incotermRuleId: rules[i].id,
                                    incotermAspectId: aspects[k].id,
                                    incotermTermId: incotermDetail.termId,
                                    incotermParties: incotermDetail.incotermParties,
                                });
                            }
                }

                let formUtil = new FormUtil();
                formUtil.okCallBack = function (data) {

                    let hasError = false;
                    let grid = this.bodyWidth.getObject();
                    for (let i = 0; i < grid.rules.length; i++)
                        for (let j = 1; j < grid.getFields().length; j++) {

                            let dynamicFormComponents = grid.getRecordComponent(i, j).members[0].members;
                            for (let k = 0; k < dynamicFormComponents.length; k++) {

                                dynamicFormComponents[k].validate();
                                if (dynamicFormComponents[k].hasErrors()) // {

                                    hasError = true;
                                    // continue;
                                // }
                                // data.incotermDetails.add(dynamicFormComponents.getValues());
                            }
                        }

                    if (hasError)
                        return;

                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: incotermTableTab.variable.url,
                        httpMethod: incotermTableTab.variable.method,
                        data: JSON.stringify(data),
                        callback: function (resp) {

                            if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                                incotermTableTab.dialog.ok();
                                incotermTableTab.method.callback();
                            } else
                                incotermTableTab.dialog.error(resp);
                        }
                    }));

                };
                formUtil.populateData = function (body) {

                    return {
                        incoterm: body.incoterm,
                        incotermDetails: body.data
                    };
                };
                formUtil.showForm(incotermTableTab.window.incoterm, null, isc.IncotermTable.create({
                        data: records,
                        fields: fields,
                        rules: rules,
                        aspects: aspects,
                        parties: data,
                        incoterm: incotermTableTab.dynamicForm.incoterm.getValues(),
                        newMode: incotermTableTab.variable.dataForEdit == null
                    })
                );

                incotermTableTab.variable.dataForEdit = null;
            });
        }
    }),
], "75%");

isc.ClassFactory.defineClass("IncotermTable", "ListGrid");
isc.IncotermTable.addProperties({

    rules: [],
    aspects: [],
    parties: [],
    incoterm: {},
    newMode: true,
    width: 600,
    height: 224,
    canResizeFields: false,
    virtualScrolling: false,
    showRecordComponents: true,
    showRecordComponentsByCell: true,
    recordComponentPoolingMode: "data",
    gridComponents: ["header", "body", isc.HStack.create({

        width: "100%",
        layoutMargin: 10,
        members: this.parties.map(q => isc.Lable.create({
            contents: q.titleEn,
            backgroundColor: q.bgColor
        })),
    })],
    createRecordComponent: function (record, colNum) {

        if (record.incotermDetails == null || record.incotermDetails.length === 0)
            return null;

        let This = this;
        let field = This.getField(colNum);
        let incotermRuleId = record.incotermDetails[0].incotermRuleId;
        if (field.type.toLowerCase() === "incotermrule") {

            if (This.rules == null || This.rules.length === 0)
                return null;

            return isc.HLayout.create({
                width: "150",
                members: [
                    isc.Label.create({
                        contents: This.rules.filter(q => q.id === incotermRuleId).first().titleEn
                    }),
                    isc.Label.create({
                        contents: This.aspects.map(q => q.titleEn).join('<hr>')
                    })
                ]
            });
        } else if (field.type.toLowerCase() === "incotermdetail") {

            let incotermDetails = record.incotermDetails.filter(q => q.incotermRuleId === incotermRuleId && q.incotermStepId === field.ref);
            if (incotermDetails == null || incotermDetails.length === 0)
                return null;
            if (This.parties == null || This.parties.length === 0)
                return null;

            let dynamicForms = [];
            for (let i = 0; i < This.aspects; i++) {

                dynamicForms.add(isc.DynamicForm.create({
                    width: "100%",
                    align: "center",
                    titleAlign: "right",
                    margin: 10,
                    canSubmit: true,
                    showErrorText: true,
                    showErrorStyle: true,
                    showInlineErrors: true,
                    dataSource: incotermDetails.filter(q => q.incotermAspectId === This.aspects[i].id).first(),
                    fields: BaseFormItems.concat([
                        {
                            hidden: true,
                            name: "termId",
                        },
                        {
                            index: -1,
                            type: "ButtonItem",
                            name: "incotermParties",
                            required: This.aspects[i].requiredParty,
                            click: function () {

                                this.index = (this.index + 1) % This.parties.length;
                                let party = This.parties[this.index];

                                this.backgroundColor = party.bgColor;
                                this.value = [{portion: 100, incotermPartyId: party.id}];
                            }
                        },
                        {
                            hidden: true,
                            required: true,
                            name: "incotermStepId",
                            defaultValue: field.ref
                        },
                        {
                            hidden: true,
                            required: true,
                            name: "incotermRuleId",
                            defaultValue: incotermRuleId
                        },
                        {
                            hidden: true,
                            required: true,
                            name: "incotermAspectId",
                            defaultValue: This.aspects[i].id
                        },
                    ], true)
                }));
                let incotermParties = dynamicForms[i].getItem("incotermParties");
                let incotermPartiesValues = incotermParties.getValue();
                if (incotermPartiesValues != null && incotermPartiesValues.length === 1) {

                    let party = This.parties.filter(q => q.id === incotermPartiesValues[0].incotermPartyId).first();
                    incotermParties.index = This.parties.indexOf(party);
                    incotermParties.backgroundColor = party.bgColor;
                }
            }
            return isc.HLayout.create({
                width: "100",
                members: [
                    isc.VLayout.create({
                        width: "100%",
                        layoutMargin: 10,
                        members: dynamicForms,
                    }),
                    isc.ImgButton.create({
                        width: 16,
                        height: 16,
                        showDown: false,
                        showRollOver: false,
                        layoutAlign: "center",
                        src: "pieces/16/icon_edit.png",
                        click: function () {

                            // TODO
                        }
                    })
                ]
            });
        }

        return null;
    }
});

incotermTableTab.method.add = function (callback) {

    incotermTableTab.method.callback = callback;
    incotermTableTab.variable.method = "POST";
    incotermTableTab.dynamicForm.incoterm.clearValues();
    incotermTableTab.listGrid.incotermStep.deselectAllRecords();
    incotermTableTab.listGrid.incotermRule.deselectAllRecords();
    incotermTableTab.listGrid.incotermAspect.deselectAllRecords();

    incotermTableTab.window.incoterm.setTitle("<spring:message code='incoterm.window.title.add'/>");
    incotermTableTab.window.incoterm.show();
};
incotermTableTab.method.edit = function (data, callback) {

    incotermTableTab.method.callback = callback;
    incotermTableTab.variable.method = "PUT";
    incotermTableTab.variable.dataForEdit = data.incotermDetails;
    incotermTableTab.dynamicForm.incoterm.editRecord(data.incoterm);

    incotermTableTab.window.incoterm.setTitle("<spring:message code='incoterm.window.title.edit'/>");
    incotermTableTab.window.incoterm.show();
};
