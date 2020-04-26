var termTab = salesGeneralTabUtil.getDefaultJSPTabVariable();
termTab.dynamicForm.fields = [{
    hidden: true,
    primaryKey: true,
    name: "id",
    type: "number",
    title: "<spring:message code='global.id'/>"
}, {
    hidden: true,
    name: "version",
    type: "number",
    title: "<spring:message code='global.version'/>"
}, {
    hidden: true,
    name: "editable",
    type: "boolean",
    title: "<spring:message code='global.editable'/>"
}, {
    hidden: true,
    name: "eStatus",
    type: "number",
    title: "<spring:message code='global.e-status'/>"
}, {
    width: "100%",
    required: true,
    name: "title",
    title: "<spring:message code='global.title'/>"
}, {
    width: "100%",
    type: "textArea",
    name: "description",
    title: "<spring:message code='global.description'/>"
}];
termTab.listGrid.fields = [...termTab.dynamicForm.fields];
nicico.BasicFormUtil.getDefaultBasicForm(termTab, "api/term/");
termTab.dynamicForm.main.windowWidth = 500;