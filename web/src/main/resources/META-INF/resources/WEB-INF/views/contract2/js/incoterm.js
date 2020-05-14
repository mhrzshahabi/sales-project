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

//***************************************************** RESTDATASOURCE *************************************************

//*************************************************** Componnents ******************************************************

nicico.BasicFormUtil.getDefaultBasicForm(incotermTab, "api/g-incoterm/");

//*************************************************** Functions ********************************************************

incotermTab.method.newForm = function () {

    incotermTab.listGrid.incotermStep.deselectAllRecords();
    incotermTab.listGrid.incotermRule.deselectAllRecords();
    incotermTab.listGrid.incotermAspect.deselectAllRecords();

    incotermTab.window.incoterm.show();
};
incotermTab.method.editForm = function () {

};
incotermTab.method.saveForm = function () {

};
