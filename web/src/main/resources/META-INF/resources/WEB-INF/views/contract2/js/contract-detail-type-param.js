var contractDetailTypeParamTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
contractDetailTypeParamTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "100%",
    required: true,
    name: "name",
    title: "<spring:message code='global.name'/>"
}, {
    width: "100%",
    required: true,
    name: "key",
    title: "<spring:message code='global.key'/>"
}, {
    width: "100%",
    required: true,
    name: "type",
    title: "<spring:message code='global.type'/>"
}, {
    width: "100%",
    required: true,
    name: "unit.nameFA",
    title: "<spring:message code='invoiceSalesItem.unitName'/>"
}, {
    width: "100%",
    required: true,
    name: "contractDetailType.titleFa",
    title: "<spring:message code='contract-detail-type.form.title-fa'/>"
}]);
Object.assign(contractDetailTypeParamTab.listGrid.fields, contractDetailTypeParamTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(contractDetailTypeParamTab, "api/contract-detail-type/");
