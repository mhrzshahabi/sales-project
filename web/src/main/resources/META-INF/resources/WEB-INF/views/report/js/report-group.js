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
    name: "parent.name",
    type: 'text',
    title: "<spring:message code='report.group.parent-name'/>"
}]);
nicico.BasicFormUtil.getDefaultBasicForm(reportGroupTab, "api/report-group/");
nicico.BasicFormUtil.removeExtraGridMenuActions(reportGroupTab);
reportGroupTab.dynamicForm.main.windowWidth = 500;
reportGroupTab.method.beforeShowNewActionHook = function () {

    reportGroupTab.dynamicForm.main.getField("parentId").setOptionCriteria(null);
};
reportGroupTab.method.beforeShowEditActionHook = function (record) {


    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
        actionURL: "${contextPath}/api/report-group/childs",
        httpMethod: "GET",
        params: {
            rootId: record.id
        },
        useSimpleHttp: true,
        contentType: "application/json; charset=utf-8",
        serverOutputAsString: false,
        callback: function (RpcResponse_o) {

            reportGroupTab.dynamicForm.main.getField("parentId").setOptionCriteria({
                fieldName: "id",
                operator: "notEqual",
                value: JSON.parse(RpcResponse_o.data)
            });
        }
    }));

};