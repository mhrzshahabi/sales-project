var reportGroupTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
reportGroupTab.dynamicForm.fields = BaseFormItems.concat([{
    width: "100%",
    name: "nameFA",
    required: true,
    title: "<spring:message code='global.title-fa'/>",
    keyPressFilter: "[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]",
    validators: [
        {
            type: "required",
            validateOnChange: true
        },
        {
            type: "regexp",
            expression: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]*$",
            validateOnChange: true
        }
    ]
}, {
    width: "100%",
    name: "nameEN",
    required: true,
    title: "<spring:message code='global.title-en'/>",
    keyPressFilter: "[A-Za-z *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]",
    validators: [
        {
            type: "required",
            validateOnChange: true
        },
        {
            type: "regexp",
            expression: "^[A-Za-z *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]*$",
            validateOnChange: true
        }]
}, {
    width: "100%",
    name: "order",
    required: true,
    type: 'integer',
    keyPressFilter: "[0-9]",
    title: "<spring:message code='global.order'/>"
}, {
    width: "100%",
    name: "parentId",
    title: "<spring:message code='report.group.parent-name'/>",
    wrapTitle: false,
    editorType: "SelectItem",
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
        fetchDataURL: "${contextPath}" + "/api/report-group/spec-list"
    }),
    autoFetchData: true,
    pickListProperties: {
        showFilterEditor: true
    },
    pickListFields: [
        {name: "name", title: "<spring:message code='report.group.name'/>"}
    ]
}]);
reportGroupTab.listGrid.fields = BaseFormItems.concat([{
    name: "name",
    type: 'text',
    title: "<spring:message code='global.name'/>"
}, {
    name: "order",
    type: 'integer',
    title: "<spring:message code='global.order'/>"
}, {
    name: "parentId",
    type: 'integer',
    title: "<spring:message code='report.group.parent-name'/>",
    formatCellValue: function (value, record, rowNum, colNum) {

        if (!record) return "";
        if (!record.parent) return "";

        return record.parent.name;
    }
}]);
nicico.BasicFormUtil.getDefaultBasicForm(reportGroupTab, "api/report-group/");
nicico.BasicFormUtil.removeExtraGridMenuActions(reportGroupTab);
reportGroupTab.dynamicForm.main.windowWidth = 500;
reportGroupTab.method.beforeShowNewActionHook = function () {

    reportGroupTab.dynamicForm.main.getField("parentId").setOptionCriteria(null);
};
reportGroupTab.method.beforeShowEditActionHook = function (record) {

    reportGroupTab.dynamicForm.main.getField("parentId").setOptionCriteria({
        fieldName: "id",
        operator: "notEqual",
        value: record.id
    });
};