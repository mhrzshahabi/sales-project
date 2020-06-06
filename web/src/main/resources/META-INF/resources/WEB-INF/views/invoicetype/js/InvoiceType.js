var InvoiceTypeTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
InvoiceTypeTab.dynamicForm.fields = [{
    hidden: true,
    primaryKey: true,
    name: "id",
    type: "number",
    title: "<spring:message code='global.id'/>"
}, {
    width: "10%",
    name: "title",
    type: 'text',
    title: "<spring:message code='global.title'/>"
}];
Object.assign(InvoiceTypeTab.listGrid.fields, InvoiceTypeTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(InvoiceTypeTab, "api/invoicetype");
InvoiceTypeTab.dynamicForm.main = null;
InvoiceTypeTab.menu.main = null;
InvoiceTypeTab.listGrid.main.contextMenu = null;
InvoiceTypeTab.listGrid.main.recordDoubleClick = null;
InvoiceTypeTab.toolStrip.main.members.shift();
InvoiceTypeTab.toolStrip.main.members.shift();
InvoiceTypeTab.toolStrip.main.members.shift();
