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
incotermTab.listGrid.incotermRule.margin = 15;
incotermTab.dynamicForm.incotermStructure = isc.DynamicForm.nicico.getDefault([{

    width: "100%",
    type: 'long',
    valueField: "id",
    pickListWidth: "430",
    pickListHeight: "300",
    name: "incotermStepId",
    displayField: "titleEn",
    editorType: "SelectItem",
    pickListProperties: {showFilterEditor: true, selectionAppearance: "checkbox"},
    pickListFields: [
        {name: "code", align: "center"},
        {name: "titleFa", align: "center"},
        {name: "titleEn", align: "center"},
    ],
    title: "<spring:message code='entity.incoterm-step'/>",
    optionDataSource: incotermTab.restDataSource.incotermStep
}, {

    width: "100%",
    type: 'long',
    valueField: "id",
    pickListWidth: "430",
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

    width: "100%",
    type: 'long',
    name: "incotermAspectId",
    valueField: "id",
    pickListWidth: "430",
    pickListHeight: "300",
    displayField: "titleEn",
    editorType: "SelectItem",
    pickListProperties: {showFilterEditor: true, selectionAppearance: "checkbox"},
    pickListFields: [
        {name: "code", align: "center"},
        {name: "titleFa", align: "center"},
        {name: "titleEn", align: "center"},
    ],
    title: "<spring:message code='entity.incoterm-aspect'/>",
    optionDataSource: incotermTab.restDataSource.incotermAspect
}, {
    type: 'ButtonItem',
    icon: "pieces/16/icon_add.png",
    title: "<spring:message code='global.add'/>",
    click(form, item) {



    }
}]);
incotermTab.dynamicForm.incotermStructure.margin = 15;
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
incotermTab.window.incoterm = isc.Window.nicico.getDefault(null, [
    isc.HLayout.create({

        width: "100%",
        height: "100%",
        members: [
            incotermTab.dynamicForm.incotermStructure,
            incotermTab.listGrid.incotermRule,
        ]
    }),
    incotermTab.hLayout.saveOrExitHlayout
], "65%");

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


/*
isc.defineClass("CustomCheckboxItem", "CheckboxItem").addProperties({
    textBoxStyle: "customCheckboxTitle",

    booleanBaseStyle: "customCheckbox",
    checkedImage: "blank",
    uncheckedImage: "blank",

    // Don't use spriting when printing because browsers typically default to not printing background
    // images.
    printBooleanBaseStyle: "printCustomCheckbox",
    printCheckedImage: "../inlineExamples/forms/details/checkboxImages/checked.png",
    printUncheckedImage: "../inlineExamples/forms/details/checkboxImages/unchecked.png",

    // The sprite tiles are 20px x 20px each.
    valueIconWidth: 20,
    valueIconHeight: 20,

    valueIconLeftPadding: 5,
    valueIconRightPadding: 5,

    // We don't have an "unset" appearance, but there are "Disabled", "Over", and "Down" tiles.
    showUnsetImage: false,
    showValueIconDisabled: true,
    showValueIconOver: true,
    showValueIconDown: true,
    showValueIconFocused: true
});

var form = isc.DynamicForm.create({
    autoDraw: false,
    width: 300,
    items: [{
        name: "shipmentVerified",
        editorType: "CustomCheckboxItem",
        title: "Was the shipment verified?",
        valueMap: {
            "verified": true,
            "unverified": false
        }
    }]
});

var button = isc.IButton.create({
    title: form.isDisabled() ? "Enable Form" : "Disable Form",
    click : function () {
        if (form.isDisabled()) {
            form.enable();
            this.setTitle("Disable Form");
        } else {
            form.disable();
            this.setTitle("Enable Form");
        }
    }
});

isc.HStack.create({
    width: "100%",
    members: [form, button],
    membersMargin: 20
});

*/


nicico.BasicFormUtil.getDefaultBasicForm(incotermTab, "api/incoterm/");

//*************************************************** Functions ********************************************************

incotermTab.method.newForm = function () {

    incotermTab.listGrid.incotermRule.setData([]);
    incotermTab.dynamicForm.incotermStructure.clearValues();

    incotermTab.window.incoterm.show();
};
incotermTab.method.editForm = function () {

};
incotermTab.method.saveForm = function () {

};
