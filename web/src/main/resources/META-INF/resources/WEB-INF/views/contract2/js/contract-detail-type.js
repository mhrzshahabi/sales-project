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
contractDetailTypeTab.listGrid.fields = contractDetailTypeTab.dynamicForm.fields.map(q => {
    const item = {...q};
    if (item.isBaseItem) {
        item.hidden = false;
        return item;
    } else if (item.name === 'code' || item.name === 'titleFa' || item.name === 'titleEn') {
        item.width = '30%';
        item.showHover = true;
        return item;
    }
    return item;
});
nicico.BasicFormUtil.getDefaultBasicForm(contractDetailTypeTab, "api/contract-detail-type/");
contractDetailTypeTab.dynamicForm.main.windowWidth = 500;
