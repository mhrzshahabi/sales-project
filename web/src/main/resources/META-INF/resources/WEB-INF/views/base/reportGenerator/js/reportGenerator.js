
//******************************************************* VARIABLES ****************************************************

var reportGeneratorTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
reportGeneratorTab.variable.restUrl = "${contextPath}" + "/api/report";

//***************************************************** RESTDATASOURCE *************************************************

reportGeneratorTab.restDataSource.allRests = isc.MyRestDataSource.create({
    fields: [
        {name: "name"},
        {name: "url"},
        {name: "method"}
    ],
    fetchDataURL: reportGeneratorTab.variable.restUrl
});
//***************************************************** MAINWINDOW *************************************************

reportGeneratorTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "restId",
        title: "<spring:message code='global.name'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        colSpan: 4,
        valueField: "url",
        displayField: "name",
        pickListWidth: 500,
        pickListHeight: 300,
        optionDataSource: reportGeneratorTab.restDataSource.allRests,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "name", title: "<spring:message code='global.name'/>", width: 100}
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    }
]);
reportGeneratorTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "name",
        title: "<spring:message code='global.name'/>",
    }
]);
nicico.BasicFormUtil.getDefaultBasicForm(reportGeneratorTab, "api/report/");
reportGeneratorTab.dynamicForm.main.windowWidth = 500;