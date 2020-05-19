var incotermTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermTab.variable.termUrl = "${contextPath}" + "/api/term/";
incotermTab.variable.incotermDetailUrl = "${contextPath}" + "/api/incoterm-detail/";
incotermTab.variable.incotermStepUrl = "${contextPath}" + "/api/incoterm-step/";
incotermTab.variable.incotermRuleUrl = "${contextPath}" + "/api/incoterm-rule/";
incotermTab.variable.incotermPartyUrl = "${contextPath}" + "/api/incoterm-party/";
incotermTab.variable.incotermAspectUrl = "${contextPath}" + "/api/incoterm-aspect/";

//***************************************************** RESTDATASOURCE *************************************************

incotermTab.restDataSource.term = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
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
    ]),
    fetchDataURL: incotermTab.variable.termUrl + "spec-list"
});
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
incotermTab.restDataSource.incotermParty = isc.MyRestDataSource.create({
    fields: BaseFormItems.concat([
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
        }, {
            name: "bgColor",
            title: "<spring:message code='global.bg-color'/>"
        }
    ]),
    fetchDataURL: incotermTab.variable.incotermPartyUrl + "spec-list"
});
incotermTab.restDataSource.incotermAspect = isc.MyRestDataSource.create({
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
        },
        {
            showHover: true,
            name: "requiredParty",
            title: "<spring:message code='global.required'/>"
        }
    ]),
    fetchDataURL: incotermTab.variable.incotermAspectUrl + "spec-list"
});

//******************************************************* COMPONENTS ***************************************************

incotermTab.listGrid.incotermStep = isc.ListGrid.nicico.getDefault(
    null,
    incotermTab.restDataSource.incotermStep, null, {
        showFilterEditor: false,
        selectionType: "simple",
        selectionAppearance: "checkbox",
        dataArrived: function (startRow, endRow) {

            if (incotermTab.variable.dataForEdit == null || incotermTab.variable.dataForEdit.length === 0)
                return;

            let incotermStepIds = incotermTab.variable.dataForEdit.map(q => q.incotermStepId).distinct();
            this.data.forEach(q => {
                if (incotermStepIds.contains(q.id))
                    this.selectRecord(q);
            });
        }
    }
);
incotermTab.listGrid.incotermRule = isc.ListGrid.nicico.getDefault(
    null,
    incotermTab.restDataSource.incotermRule, null, {
        showFilterEditor: false,
        selectionType: "simple",
        selectionAppearance: "checkbox",
        dataArrived: function (startRow, endRow) {

            if (incotermTab.variable.dataForEdit == null || incotermTab.variable.dataForEdit.length === 0)
                return;

            let incotermRuleIds = incotermTab.variable.dataForEdit.map(q => q.incotermRuleId).distinct();
            this.data.forEach(q => {
                if (incotermRuleIds.contains(q.id))
                    this.selectRecord(q);
            });
        }
    }
);
incotermTab.listGrid.incotermAspect = isc.ListGrid.nicico.getDefault(
    null,
    incotermTab.restDataSource.incotermAspect, null, {
        height: "140",
        showFilterEditor: false,
        selectionType: "simple",
        selectionAppearance: "checkbox",
        dataArrived: function (startRow, endRow) {

            if (incotermTab.variable.dataForEdit == null || incotermTab.variable.dataForEdit.length === 0)
                return;

            let incotermAspectIds = incotermTab.variable.dataForEdit.map(q => q.incotermAspectId).distinct();
            this.data.forEach(q => {
                if (incotermAspectIds.contains(q.id))
                    this.selectRecord(q);
            });
        }
    }
);
incotermTab.dynamicForm.incoterm = isc.DynamicForm.create({

    width: "100%",
    align: "center",
    titleAlign: "right",
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
            width: "100%",
            name: "description",
            editorType: "textArea",
            title: "<spring:message code='global.description'/>",
        }
    ], true)
});
incotermTab.window.incoterm = isc.Window.nicico.getDefault(null, [

    incotermTab.dynamicForm.incoterm,
    isc.HLayout.create({
        width: "100%",
        align: "center",
        members: [
            isc.IButtonSave.create({

                margin: 10,
                height: 50,
                icon: "pieces/16/save.png",
                title: "<spring:message code='global.ok'/>",
                click: function () {

                    // incotermTab.dynamicForm.incoterm.validate();
                    // let steps = incotermTab.listGrid.incotermStep.getSelectedRecords();
                    // let rules = incotermTab.listGrid.incotermRule.getSelectedRecords();
                    // let aspects = incotermTab.listGrid.incotermAspect.getSelectedRecords();
                    // if (incotermTab.dynamicForm.incoterm.hasErrors() || steps.length === 0 || rules.length === 0 || aspects.length === 0) {
                    //
                    //     isc.say('<spring:message code="incoterm.exception.required-info"/>');
                    //     return;
                    // }
                    //
                    // incotermTab.restDataSource.incotermParty.fetchData(null, data => {
                    //
                    //     let fields = [{width: 150, type: "IncotermRule"}];
                    //     steps.forEach(q => fields.add({
                    //         width: 100,
                    //         ref: q.id,
                    //         name: q.code,
                    //         title: q.titleEn,
                    //         type: "IncotermDetail"
                    //     }));
                    //
                    //     let records = [];
                    //     for (let i = 0; i < rules.length; i++) {
                    //
                    //         records.add({incotermDetails: []});
                    //         for (let j = 0; j < steps.length; j++)
                    //             for (let k = 0; k < aspects.length; k++)
                    //                 if (incotermTab.variable.dataForEdit == null || incotermTab.variable.dataForEdit.length === 0)
                    //                     records[i].incotermDetails.add({
                    //                         incotermStepId: steps[j].id,
                    //                         incotermRuleId: rules[i].id,
                    //                         incotermAspectId: aspects[k].id,
                    //                     });
                    //                 else {
                    //
                    //                     let incotermDetail = incotermTab.variable.dataForEdit.filter(q =>
                    //                         q.incotermStepId === steps[j].id &&
                    //                         q.incotermRuleId === rules[i].id &&
                    //                         q.incotermAspectId === aspects[k].id
                    //                     ).first();
                    //                     records[i].incotermDetails.add({
                    //                         incotermStepId: steps[j].id,
                    //                         incotermRuleId: rules[i].id,
                    //                         incotermAspectId: aspects[k].id,
                    //                         incotermTermId: incotermDetail.termId,
                    //                         incotermParties: incotermDetail.incotermParties,
                    //                     });
                    //                 }
                    //     }
                    //
                    //     let formUtil = new nicico.FormUtil();
                    //     formUtil.okCallBack = function (data) {
                    //
                    //         let hasError = false;
                    //         let grid = this.bodyWidth.getObject();
                    //         for (let i = 0; i < grid.rules.length; i++)
                    //             for (let j = 1; j < grid.getFields().length; j++) {
                    //
                    //                 let dynamicFormComponents = grid.getRecordComponent(i, j).members[0].members;
                    //                 for (let k = 0; k < dynamicFormComponents.length; k++) {
                    //
                    //                     dynamicFormComponents[k].validate();
                    //                     if (dynamicFormComponents[k].hasErrors()) // {
                    //
                    //                         hasError = true;
                    //                     // continue;
                    //                     // }
                    //                     // data.incotermDetails.add(dynamicFormComponents.getValues());
                    //                 }
                    //             }
                    //
                    //         if (hasError)
                    //             return;
                    //
                    //         isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    //             actionURL: incotermTab.variable.url,
                    //             httpMethod: incotermTab.variable.method,
                    //             data: JSON.stringify(data),
                    //             callback: function (resp) {
                    //
                    //                 if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                    //                     incotermTab.dialog.ok();
                    //                     incotermTab.method.callback();
                    //                 } else
                    //                     incotermTab.dialog.error(resp);
                    //             }
                    //         }));
                    //
                    //     };
                    //     formUtil.populateData = function (body) {
                    //
                    //         return {
                    //             incoterm: body.incoterm,
                    //             incotermDetails: body.data
                    //         };
                    //     };
                    //     formUtil.showForm(incotermTab.window.incoterm, null, isc.IncotermTable.create({
                    //         data: records,
                    //         fields: fields,
                    //         rules: rules,
                    //         aspects: aspects,
                    //         parties: data,
                    //         incoterm: incotermTab.dynamicForm.incoterm.getValues(),
                    //         newMode: incotermTab.variable.dataForEdit == null
                    //     }), "85%");
                    //
                    //     incotermTab.variable.dataForEdit = null;
                    // });
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
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    isc.IButton.create({

                        margin: 10,
                        height: 50,
                        icon: "pieces/16/icon_add.png",
                        title: "<spring:message code='incoterm.window.step.define'/>",
                        click: function () {

                        }
                    }),
                    isc.IButton.create({

                        margin: 10,
                        height: 50,
                        icon: "pieces/16/icon_add.png",
                        title: "<spring:message code='incoterm.window.rule.define'/>",
                        click: function () {

                        }
                    }),
                    isc.IButton.create({

                        margin: 10,
                        height: 50,
                        icon: "pieces/16/icon_add.png",
                        title: "<spring:message code='incoterm.window.detail.define'/>",
                        click: function () {

                        }
                    })
                ]
            })
        ]
    })
], "60%");
incotermTab.window.incotermSteps = isc.Window.nicico.getDefault(null, [

    incotermTab.listGrid.incotermStep,
    isc.HLayout.create({
        width: "100%",
        align: "center",
        members: [
            isc.IButtonSave.create({

                margin: 10,
                height: 50,
                icon: "pieces/16/save.png",
                title: "<spring:message code='global.ok'/>",
                click: function () {

                }
            }),
            isc.IButtonCancel.create({

                margin: 10,
                height: 50,
                icon: "pieces/16/icon_delete.png",
                title: "<spring:message code='global.cancel'/>",
                click: function () {
                    incotermTab.window.incotermSteps.close();
                }
            })
        ]
    })
], "40%");
incotermTab.window.incotermRules = isc.Window.nicico.getDefault(null, [

    incotermTab.listGrid.incotermAspect,
    incotermTab.listGrid.incotermRule,
    isc.HLayout.create({
        width: "100%",
        align: "center",
        members: [
            isc.IButtonSave.create({

                margin: 10,
                height: 50,
                icon: "pieces/16/save.png",
                title: "<spring:message code='global.ok'/>",
                click: function () {

                }
            }),
            isc.IButtonCancel.create({

                margin: 10,
                height: 50,
                icon: "pieces/16/icon_delete.png",
                title: "<spring:message code='global.cancel'/>",
                click: function () {
                    incotermTab.window.incotermRules.close();
                }
            })
        ]
    })
], "40%");
// incotermTab.window.incotermDetails = isc.Window.nicico.getDefault(null, [
//
//     isc.HLayout.create({
//         width: "100%",
//         align: "center",
//         members: [
//             isc.IButtonSave.create({
//
//                 margin: 10,
//                 height: 50,
//                 icon: "pieces/16/save.png",
//                 title: "<spring:message code='global.ok'/>",
//                 click: function () {
//
//                 }
//             }),
//             isc.IButtonCancel.create({
//
//                 margin: 10,
//                 height: 50,
//                 icon: "pieces/16/icon_delete.png",
//                 title: "<spring:message code='global.cancel'/>",
//                 click: function () {
//                     incotermTab.window.incotermDetails.close();
//                 }
//             })
//         ]
//     })
// ], "40%");

incotermTab.dynamicForm.fields = BaseFormItems.concat([{
    name: "code",
    width: "100%",
    required: true,
    keyPressFilter: "^[A-Za-z0-9]",
    title: "<spring:message code='global.code'/>"
}, {
    name: "title",
    width: "100%",
    required: true,
    title: "<spring:message code='global.title'/>"
}, {
    width: "100%",
    required: true,
    name: "incotermVersion",
    title: "<spring:message code='global.version'/>"
}, {
    width: "100%",
    required: true,
    name: "publishDate",
    title: "<spring:message code='incoterm.form.publish-date'/>",
    formatCellValue: function (value, record, rowNum, colNum, grid) {

        if (record == null || value == null)
            return;

        return new persianDate(value).format('YYYY/MM/DD');
    }
}, {
    width: "100%",
    name: "description",
    editorType: "textArea",
    title: "<spring:message code='global.description'/>",
}]);
Object.assign(incotermTab.listGrid.fields, incotermTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermTab, "api/g-incoterm/");

//*************************************************** Functions ********************************************************

incotermTab.method.newForm = function () {

    // incotermTab.method.add(() => incotermTab.method.refresh(incotermTab.listGrid.main));
};
incotermTab.method.editForm = function () {

    let record = incotermTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        incotermTab.dialog.notSelected();
    else if (record.editable === false)
        incotermTab.dialog.notEditable();
    else {
        // incotermTab.method.jsonRPCManagerRequest({
        //         method: "GET",
        //         url: incotermTab.variable.incotermDetailUrl + "spec-list",
        //         params: {
        //             criteria: JSON.stringify({
        //                 operator: "and",
        //                 criteria: [
        //                     {fieldName: "incotermSteps.incotermId", operator: "equals", value: record.id}
        //                 ]
        //             })
        //         }
        //     },
        //     response =>
        //         incotermTab.method.edit(JSON.parse(response.httpResponseText).response.data,
        //             () => incotermTab.method.refresh(incotermTab.listGrid.main)));
    }
};
