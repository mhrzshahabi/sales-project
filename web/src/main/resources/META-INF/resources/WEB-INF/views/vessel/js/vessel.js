var vesselTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
vesselTab.dynamicForm.fields = [{
    hidden: true,
    primaryKey: true,
    name: "id",
    type: "number",
    title: "<spring:message code='global.id'/>"
},{
    width: "10%",
    name: "type",
    title: "<spring:message code='vessel.type'/>"
}, {
    width: "10%",
    name: "imo",
    title: "<spring:message code='vessel.imo'/>"
}, {
    width: "10%",
    name: "yearOfBuild",
    title: "<spring:message code='vessel.year.of.build'/>"
}, {
    width: "10%",
    name: "length",
    title: "<spring:message code='vessel.length'/>"
},{
    width: "10%",
    name: "beam",
    title: "<spring:message code='vessel.beam'/>"
}];
Object.assign(vesselTab.listGrid.fields, vesselTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(vesselTab, "api/vessel/");
vesselTab.listGrid.main.contextMenu=null;
vesselTab.dynamicForm.main.windowWidth = 500;
