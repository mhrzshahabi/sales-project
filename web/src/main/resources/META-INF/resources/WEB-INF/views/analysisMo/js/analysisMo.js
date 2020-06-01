var analyseMethodTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
analyseMethodTab.dynamicForm.fields = [
    {
        hidden: true,
        primaryKey: true,
        name: "id",
        type: "number",
        title: "<spring:message code='global.id'/>",
    },


    {
        width: "10%",
        name: "p", type: 'text', format: ",##0.#",
        title: "<spring:message code='analysis.p'/>",
    },


    {
        width: "10%", showHover: true,
        name: "c", type: 'text', format: ",##0.#",
        title: "<spring:message code='analysis.c'/>",
    },


    {
        width: "10%",
        name: "s", type: 'text', format: ",##0.#",
        title: "<spring:message code='analysis.s'/>",
    },


    {
        width: "10%",
        name: "pb", type: 'text', format: ",##0.#",
        title: "<spring:message code='analysis.pb'/>",
    },


    {
        width: "10%",
        name: "si", type: 'text', format: ",##0.#",
        title: "<spring:message code='analysis.si'/>",
    },


    {
        width: "10%",
        name: "cu", type: 'text', format: ",##0.#",
        title: "<spring:message code='analysis.cu'/>",
    },


    {
        width: "10%",
        name: "mo", type: 'text', format: ",##0.#",
        title: "<spring:message code='analysis.mo'/>",
    },


    {
        width: "10%",
        name: "lotName",
        type: "text",
        title: "<spring:message code='analysis.lotname'/>",
    },
];
Object.assign(analyseMethodTab.listGrid.fields, analyseMethodTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(analyseMethodTab, "api/analyseMo");
analyseMethodTab.dynamicForm.main = null;
analyseMethodTab.menu.main = null;
analyseMethodTab.listGrid.main.contextMenu = null;
analyseMethodTab.listGrid.main.recordDoubleClick = null;
analyseMethodTab.toolStrip.main.members.shift();
analyseMethodTab.toolStrip.main.members.shift();
analyseMethodTab.toolStrip.main.members.shift();



