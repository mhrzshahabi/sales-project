var incotermRuleTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermRuleTab.dynamicForm.fields = BaseFormItems.concat([{
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
Object.assign(incotermRuleTab.listGrid.fields, incotermRuleTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermRuleTab, "api/incoterm-rule/");
