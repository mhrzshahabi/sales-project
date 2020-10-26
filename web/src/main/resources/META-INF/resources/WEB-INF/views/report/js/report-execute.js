var reportExecuteTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
reportExecuteTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "10%",
    name: "name",
    required: true,
    type: 'text',
    title: "<spring:message code='global.name'/>"
}, {
    width: "10%",
    name: "order",
    type: 'integer',
    title: "<spring:message code='global.order'/>"
}, {
    name: "parentId",
    title: "<spring:message code='report.group.parent-name'/>",
    required: true,
    wrapTitle: false,
    editorType: "SelectItem",
    colSpan: 1,
    displayField: "name",
    valueField: "id",
    optionDataSource: isc.MyRestDataSource.create({

        fields: [
            {
                name: "id", primaryKey: true, canEdit: false, hidden: true
            },
            {
                name: "name", title: "<spring:message code='report.group.name'/>"
            }
        ],
        fetchDataURL: "${contextPath}" + "/api/reportGroup/spec-list"
    }),
    autoFetchData: true,
    pickListProperties: {
        showFilterEditor: true
    },
    pickListFields: [
        {name: "name", title: "<spring:message code='report.group.name'/>"}
    ],
    validators: [{
        type: "required",
        validateOnChange: true
    }]
}]);
Object.assign(reportExecuteTab.listGrid.fields, reportExecuteTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(reportExecuteTab, "");
reportExecuteTab.listGrid.main.contextMenu = null;
reportExecuteTab.dynamicForm.main.windowWidth = 500;/**/
