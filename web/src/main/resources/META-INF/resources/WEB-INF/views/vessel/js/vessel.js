var vesselTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
vesselTab.dynamicForm.fields = [{
    hidden: true,
    primaryKey: true,
    name: "id",
    type: "number",
    title: "<spring:message code='global.id'/>"
}, {
    width: "10%",
    name: "name",
    required: true,
    type: 'text',
    title: "<spring:message code='vessel.name'/>"
}, {
    width: "10%",
    name: "type",
    type: 'text',
    title: "<spring:message code='vessel.type'/>"
}, {
    width: "10%",
    name: "imo",
    type: 'text',
    length: 9,
    keyPressFilter : "[0-9]",
    validators:[{
        type: "regexp",
        expression: "^[0-9]+$",
        validateOnChange: true
    }],
    title: "<spring:message code='vessel.imo'/>"
}, {
    width: "10%",
    name: "yearOfBuild",
    type: 'text',
    length: 4,
    keyPressFilter : "[0-9]",
    validators:[{
      type: "regexp",
      expression: "[0-9]{4}",
      validateOnChange: true
    }],
    title: "<spring:message code='vessel.year.of.build'/>"
}, {
    width: "10%",
    name: "length",
    length: 4,
    type: "number",
    keyPressFilter : "[0-9]",
    validators:[{
        type: "regexp",
        expression: "^[0-9]+$",
        validateOnChange: true
    }],
    title: "<spring:message code='vessel.length'/>"
}, {
    width: "10%",
    name: "beam",
    type: "number",
    length: 4,
    keyPressFilter : "[0-9]",
    validators:[{
        type: "regexp",
        expression: "^[0-9]+$",
        validateOnChange: true
    }],
    title: "<spring:message code='vessel.beam'/>"
}];
Object.assign(vesselTab.listGrid.fields, vesselTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(vesselTab, "api/vessel/");
vesselTab.listGrid.main.contextMenu = null;
vesselTab.dynamicForm.main.windowWidth = 500;
