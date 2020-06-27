var priceBaseTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
priceBaseTab.dynamicForm.fields = [{
    hidden: true,
    primaryKey: true,
    name: "id",
    type: "number",
    title: "<spring:message code='global.id'/>"
}, {
    width: "10%",
    name: "priceDate",
    type: 'date',
    title: "<spring:message code='vessel.name'/>"
}];
Object.assign(priceBaseTab.listGrid.fields, priceBaseTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(priceBaseTab, "api/price-base/");
priceBaseTab.listGrid.main.contextMenu = null;
priceBaseTab.dynamicForm.main.windowWidth = 500;
