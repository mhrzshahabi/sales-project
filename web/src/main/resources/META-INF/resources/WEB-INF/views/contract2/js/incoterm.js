var incotermTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "100%",
    required: true,
    name: "code",
    title: "<spring:message code='global.code'/>"
}, {
    width: "100%",
    required: true,
    name: "title",
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
    type: "textArea",
    name: "description",
    title: "<spring:message code='global.description'/>",
}]);
Object.assign(incotermTab.listGrid.fields, incotermTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermTab, "api/incoterm/");
