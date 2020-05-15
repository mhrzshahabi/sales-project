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
nicico.BasicFormUtil.getDefaultBasicForm(incotermTab, "api/g-incoterm/");

//*************************************************** Functions ********************************************************

incotermTab.method.newForm = function () {

    incotermTableTab.method.add();
    incotermTab.method.refresh(incotermTab.listGrid.main);
};
incotermTab.method.editForm = function () {

    let record = incotermTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        incotermTab.dialog.notSelected();
    else if (record.editable === false)
        incotermTab.dialog.notEditable();
    else {
        incotermTab.method.jsonRPCManagerRequest({

            method: "GET",
            url: incotermTab.variable.url + "/pack/" + record.id
        }, (response) => {
            incotermTableTab.method.edit(JSON.parse(response.httpResponseText));
            incotermTab.method.refresh(incotermTab.listGrid.main);
        });
    }
};