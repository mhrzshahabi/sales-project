var contractTypeTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractTypeTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "100%",
    required: true,
    name: "code",
    title: "<spring:message code='global.code'/>"
}, {
    width: "100%",
    required: true,
    name: "titleFa",
    title: "<spring:message code='global.title-fa'/>"
}, {
    width: "100%",
    required: true,
    name: "titleEn",
    title: "<spring:message code='global.title-en'/>"
}, {
    width: "100%",
    type: "textArea",
    name: "description",
    title: "<spring:message code='global.description'/>",
}]);
Object.assign(contractTypeTab.listGrid.fields, contractTypeTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(contractTypeTab, "api/contract-type/");
