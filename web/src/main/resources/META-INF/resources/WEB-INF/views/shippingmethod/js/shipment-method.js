var shipMethodTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
shipMethodTab.dynamicForm.fields = [{
    hidden: true,
    primaryKey: true,
    name: "id",
    type: "number",
    title: "<spring:message code='global.id'/>"
}, {
    width: "10%",
    name: "shipmentMethod",
    type: 'text',
    title: "<spring:message code='global.title'/>"
}];
Object.assign(shipMethodTab.listGrid.fields, shipMethodTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(shipMethodTab, "api/shipmentmethod");
shipMethodTab.dynamicForm.main = null;
shipMethodTab.menu.main = null;
shipMethodTab.listGrid.main.contextMenu = null;
shipMethodTab.listGrid.main.recordDoubleClick = null;
shipMethodTab.toolStrip.main.members.shift();
shipMethodTab.toolStrip.main.members.shift();
shipMethodTab.toolStrip.main.members.shift();
