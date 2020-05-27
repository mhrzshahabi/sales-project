var shipTypeTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
shipTypeTab.dynamicForm.fields = [{
    hidden: true,
    primaryKey: true,
    name: "id",
    type: "number",
    title: "<spring:message code='global.id'/>"
}, {
    width: "10%",
    name: "shiptype",
    type: 'text',
    title: "<spring:message code='global.title'/>"
}];
Object.assign(shipTypeTab.listGrid.fields, shipTypeTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(shipTypeTab, "api/shipmenttype");
shipTypeTab.dynamicForm.main = null;
shipTypeTab.menu.main = null;
shipTypeTab.listGrid.main.contextMenu = null;
shipTypeTab.listGrid.main.recordDoubleClick = null;
shipTypeTab.toolStrip.main.members.shift();
shipTypeTab.toolStrip.main.members.shift();
shipTypeTab.toolStrip.main.members.shift();
