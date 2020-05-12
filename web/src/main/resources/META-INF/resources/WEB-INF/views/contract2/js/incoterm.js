var incotermTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
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
nicico.BasicFormUtil.getDefaultBasicForm(incotermTab, "api/incoterm/");

//***************************************************** GENERALTABVARIABLE *********************************************

incotermTab.variable.termUrl = "${contextPath}" + "/api/term/";
incotermTab.variable.incotermStepUrl = "${contextPath}" + "/api/incoterm-step/";
incotermTab.variable.incotermRuleUrl = "${contextPath}" + "/api/incoterm-rule/";
incotermTab.variable.incotermPartyUrl = "${contextPath}" + "/api/incoterm-party/";
incotermTab.variable.incotermAspectUrl = "${contextPath}" + "/api/incoterm-aspect/";

//***************************************************** RESTDATASOURCE *************************************************

incotermTab.restDataSource.term = isc.MyRestDataSource.create({
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
    fetchDataURL: incotermTab.variable.termUrl + "spec-list"
});
incotermTab.restDataSource.incotermStep = isc.MyRestDataSource.create({
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
    fetchDataURL: incotermTab.variable.incotermStepUrl + "spec-list"
});
incotermTab.restDataSource.incotermRule = isc.MyRestDataSource.create({
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
    fetchDataURL: incotermTab.variable.incotermRuleUrl + "spec-list"
});
incotermTab.restDataSource.incotermParty = isc.MyRestDataSource.create({
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
    fetchDataURL: incotermTab.variable.incotermPartyUrl + "spec-list"
});
incotermTab.restDataSource.incotermAspect = isc.MyRestDataSource.create({
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
    fetchDataURL: incotermTab.variable.incotermAspectUrl + "spec-list"
});

//*************************************************** Componnents ******************************************************

// incotermTab.dynamicForm.selectTerm = isc.DynamicForm.nicico.getDefault([{
//
//     type: 'long',
//     name: "termId",
//     valueField: "id",
//     pickListWidth: "300",
//     pickListHeight: "300",
//     displayField: "titleEn",
//     editorType: "SelectItem",
//     pickListProperties: {showFilterEditor: true},
//     pickListFields: [
//         {name: "code", align: "center"},
//         {name: "titleFa", align: "center"},
//         {name: "titleEn", align: "center"},
//     ],
//     title: "<spring:message code='entity.term'/>",
//     optionDataSource: incotermTab.restDataSource.term
// }]);

incotermTab.listGrid.incotermRule = isc.ListGrid.nicico.getDefault([{
    width: "50%",
    name: "ruleTitleEn",
    title: "<spring:message code='entity.incoterm-rule'/>"
}, {
    width: "50%",
    name: "aspectTitleEns",
    title: "<spring:message code='entity.incoterm-aspect'/>",
    formatCellValue(value, record, rowNum, colNum, grid) {

        if (record == null || record[this.name] == null || record[this.name].length === 0)
            return;

        return record[this.name].map(q => q.titleEn).join(', ');
    }
}]);
incotermTab.dynamicForm.incotermStructure = isc.DynamicForm.nicico.getDefault([{

    type: 'long',
    valueField: "id",
    pickListWidth: "300",
    pickListHeight: "300",
    name: "incotermStepId",
    displayField: "titleEn",
    editorType: "SelectItem",
    selectionAppearance: "checkbox",
    pickListProperties: {showFilterEditor: true},
    pickListFields: [
        {name: "code", align: "center"},
        {name: "titleFa", align: "center"},
        {name: "titleEn", align: "center"},
    ],
    title: "<spring:message code='entity.incoterm-step'/>",
    optionDataSource: incotermTab.restDataSource.incotermStep
}, {

    type: 'long',
    valueField: "id",
    pickListWidth: "300",
    pickListHeight: "300",
    name: "incotermRuleId",
    displayField: "titleEn",
    editorType: "SelectItem",
    pickListProperties: {showFilterEditor: true},
    pickListFields: [
        {name: "code", align: "center"},
        {name: "titleFa", align: "center"},
        {name: "titleEn", align: "center"},
    ],
    title: "<spring:message code='entity.incoterm-rule'/>",
    optionDataSource: incotermTab.restDataSource.incotermRule
}, {

    type: 'long',
    name: "incotermAspectId",
    valueField: "id",
    pickListWidth: "300",
    pickListHeight: "300",
    displayField: "titleEn",
    editorType: "SelectItem",
    selectionAppearance: "checkbox",
    pickListProperties: {showFilterEditor: true},
    pickListFields: [
        {name: "code", align: "center"},
        {name: "titleFa", align: "center"},
        {name: "titleEn", align: "center"},
    ],
    title: "<spring:message code='entity.incoterm-aspect'/>",
    optionDataSource: incotermTab.restDataSource.incotermAspect
}, {
    type: 'ButtonItem',
    title: "<spring:message code='global.add'/>",
    click(form, item) {
        alert("clicked...");
    }
}]);
incotermTab.hLayout.saveOrExitHlayout = isc.HLayout.create({

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

                alert("clicked....");
            }
        }),
        isc.IButtonCancel.create({

            width: 100,
            orientation: "vertical",
            icon: "pieces/16/icon_delete.png",
            title: "<spring:message code='global.close'/>",
            click: function () {

                incotermTab.window.incoterm.close();
            }
        })
    ]
});
incotermTab.window.incoterm = isc.Window.nicico.getDefault(null, isc.VLayout.create({
    width: "100%",
    height: "100%",
    members: [
        isc.HLayout.create({

            width: "100%",
            height: "100%",
            members: [
                incotermTab.dynamicForm.incotermStructure,
                incotermTab.listGrid.incotermRule,
            ]
        }),
        incotermTab.hLayout.saveOrExitHlayout
    ]
}), "85%");
incotermTab.vLayout.main.addMember(incotermTab.window.incoterm);

// incotermTab.dynamicForm.selectIncotermParty = isc.DynamicForm.nicico.getDefault([{
//
//     type: 'long',
//     name: "incotermPartyId",
//     valueField: "id",
//     pickListWidth: "300",
//     pickListHeight: "300",
//     displayField: "titleEn",
//     editorType: "ButtonItem",
//     pickListProperties: {showFilterEditor: true},
//     pickListFields: [
//         {name: "code", align: "center"},
//         {name: "titleFa", align: "center"},
//         {name: "titleEn", align: "center"},
//     ],
//     title: "<spring:message code='entity.incoterm-party'/>",
//     optionDataSource: incotermTab.restDataSource.incotermParty
// }]);

//*************************************************** Functions ********************************************************

incotermTab.method.newForm = function () {

};
incotermTab.method.editForm = function () {

};
incotermTab.method.saveForm = function () {

};
