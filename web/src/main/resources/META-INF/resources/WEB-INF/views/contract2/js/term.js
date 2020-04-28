var termTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
termTab.dynamicForm.fields = BaseFormItems.concat([{
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
Object.assign(termTab.listGrid.fields, termTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(termTab, "api/term/");
termTab.dynamicForm.main.windowWidth = 500;
