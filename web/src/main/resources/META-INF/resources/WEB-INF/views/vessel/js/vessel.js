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
    title: "type"
}, {
    width: "10%",
    name: "imo",
    title: "imo"
}, {
    width: "10%",
    name: "yearOfBuild",
    title: "yearOfBuild"
}, {
    width: "10%",
    name: "length",
    title: "length",
},{
    width: "10%",
    name: "beam",
    title: "beam",
}];
Object.assign(vesselTab.listGrid.fields, vesselTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(vesselTab, "api/vessel/");
vesselTab.listGrid.main.contextMenu=null;
vesselTab.dynamicForm.main.windowWidth = 500;
