var incotermStepTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermStepTab.dynamicForm.fields = BaseFormItems.concat([{
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
Object.assign(incotermStepTab.listGrid.fields, incotermStepTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermStepTab, "api/incoterm-step/");
