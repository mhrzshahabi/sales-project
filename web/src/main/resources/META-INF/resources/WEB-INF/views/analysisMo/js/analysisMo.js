var AnalysisMoMethodTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
AnalysisMoMethodTab.dynamicForm.fields = [
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
Object.assign(AnalysisMoMethodTab.listGrid.fields, AnalysisMoMethodTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(AnalysisMoMethodTab, "api/analysisMo");
AnalysisMoMethodTab.dynamicForm.main = null;
AnalysisMoMethodTab.menu.main = null;
AnalysisMoMethodTab.listGrid.main.contextMenu = null;
AnalysisMoMethodTab.listGrid.main.recordDoubleClick = null;
AnalysisMoMethodTab.toolStrip.main.members.shift();
AnalysisMoMethodTab.toolStrip.main.members.shift();
AnalysisMoMethodTab.toolStrip.main.members.shift();



