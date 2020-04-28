var contractDetailTypeTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractDetailTypeTab.dynamicForm.fields = BaseFormItems.concat([{
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
}]);
Object.assign(contractDetailTypeTab.listGrid.fields, contractDetailTypeTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(contractDetailTypeTab, "api/contract-detail-type/");
