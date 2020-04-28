var incotermAspectTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermAspectTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "100%",
    required: true,
    name: "title",
    title: "<spring:message code='global.title'/>"
}, {
    width: "100%",
    type: "textArea",
    name: "description",
    title: "<spring:message code='global.description'/>",
}]);
Object.assign(incotermAspectTab.listGrid.fields, incotermAspectTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermAspectTab, "api/incoterm-aspect/");
