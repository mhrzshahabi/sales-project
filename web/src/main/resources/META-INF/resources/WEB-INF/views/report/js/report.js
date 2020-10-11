//******************************************************* VARIABLES ****************************************************

var reportGeneratorTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
reportGeneratorTab.variable.reportSourceUrl = "${contextPath}" + "/api/report/sources";
reportGeneratorTab.variable.reportSourceFieldsUrl = "${contextPath}" + "/api/report/sources-fields";
reportGeneratorTab.variable.reportUrl = "${contextPath}" + "/api/report";
reportGeneratorTab.variable.reportGroupUrl = "${contextPath}" + "/api/report-group";
//***************************************************** RESTDATASOURCE *************************************************

reportGeneratorTab.restDataSource.reportSource = isc.MyRestDataSource.create({

    fields: [
        {
            name: "source", title: "<spring:message code='report.source'/>"
        },
        {
            name: "nameFA", title: "<spring:message code='report.nameFA'/>"
        },
        {
            name: "nameEN", title: "<spring:message code='report.nameEN'/>"
        },
        {
            name: "restMethod", title: "<spring:message code='report.method'/>"
        },
        {
            name: "fields"
        },
    ],
    fetchDataURL: reportGeneratorTab.variable.reportSourceUrl,
    transformRequest: function (dsRequest) {

        let reportSource;
        if (reportGeneratorTab.dynamicForm.report)
            reportSource = reportGeneratorTab.dynamicForm.report.getField("reportSource").getValue();
        if (!reportSource) reportSource = "Rest";

        dsRequest.params = {
            reportSource: reportSource
        };

        this.Super("transformRequest", arguments);
    },
});
reportGeneratorTab.restDataSource.reportSourceFields = isc.MyRestDataSource.create({

    fields: [
        {name: "name", primaryKey: true},
        {name: "titleFA", canEdit: true},
        {name: "titleEN", canEdit: true},
        {name: "className", foreignKey: "name"},
        {name: "hidden", canEdit: true},
        {name: "dataIsList"},
        {name: "type"},
        {name: "canFilter", canEdit: true},
    ],
    fetchDataURL: reportGeneratorTab.variable.reportSourceFieldsUrl,
    transformRequest: function (dsRequest) {

        let sourceData;
        let reportSource;
        if (reportGeneratorTab.dynamicForm.report) {

            sourceData = reportGeneratorTab.dynamicForm.report.getField("sourceData").getValue();
            reportSource = reportGeneratorTab.dynamicForm.report.getField("reportSource").getValue();
        }
        if (!sourceData) sourceData = "";
        if (!reportSource) reportSource = "Rest";

        dsRequest.params = {
            reportSource: reportSource,
            source: sourceData,
        };

        this.Super("transformRequest", arguments);
    }
});
reportGeneratorTab.restDataSource.report = isc.MyRestDataSource.create({

    fields: [
        {
            name: "id", primaryKey: true, canEdit: false, hidden: true
        },
        {
            name: "title", title: "<spring:message code='report.title'/>"
        },
        {
            name: "reportType", title: "<spring:message code='report.reportType'/>"
        }
    ],
    fetchDataURL: reportGeneratorTab.variable.reportUrl + "/spec-list"
});
reportGeneratorTab.restDataSource.reportGroup = isc.MyRestDataSource.create({

    fields: [
        {
            name: "id", primaryKey: true, canEdit: false, hidden: true
        },
        {
            name: "name", title: "<spring:message code='report.group.name'/>"
        }
    ],
    fetchDataURL: reportGeneratorTab.variable.reportGroupUrl + "/spec-list"
});

//***************************************************** MAINWINDOW *************************************************

reportGeneratorTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "reportSource",
        title: "<spring:message code='report.source.type'/>",
        required: true,
        wrapTitle: false,
        colSpan: 1,
        value: JSON.parse('${Enum_ReportSource}').Rest,
        valueMap: JSON.parse('${Enum_ReportSource}'),
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {
            let sourceDataItem = form.getItem("sourceData");
            sourceDataItem.enable();
            sourceDataItem.clearValue();
        }
    },
    {
        name: "sourceData",
        title: "<spring:message code='report.source'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        colSpan: 1,
        displayField: "nameFA",
        valueField: "source",
        optionDataSource: reportGeneratorTab.restDataSource.reportSource,
        autoFetchData: true,
        canAdaptHeight: true,
        pickListProperties: {
            showFilterEditor: true,
            canAdaptHeight: true,
        },
        pickListFields: [
            {name: "nameFA", title: "<spring:message code='report.name'/>"}
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {
            let record = this.getSelectedRecord();
            reportGeneratorTab.treeGrid.report.fetchData();
        }
    },
    {
        name: "reportGroup",
        title: "<spring:message code='report.report-group'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        colSpan: 1,
        displayField: "name",
        valueField: "id",
        optionDataSource: reportGeneratorTab.restDataSource.reportGroup,
        autoFetchData: true,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "name", title: "<spring:message code='report.group.name'/>"}
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "reportType",
        title: "<spring:message code='report.reportType'/>",
        required: true,
        colSpan: 1,
        wrapTitle: false,
        valueMap: JSON.parse('${Enum_ReportType}'),
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "titleFa",
        title: "<spring:message code='report.titleFA'/>",
        wrapTitle: false,
        required: true,
        colSpan: 1,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "titleEN",
        title: "<spring:message code='report.titleEN'/>",
        wrapTitle: false,
        required: true,
        colSpan: 1,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "reportFile",
        title: "<spring:message code='report.file'/> ",
        type: "file",
        wrapTitle: false,
        accept: "jrxml/*",
        colSpan: 4,
        multiple: ""
    },
    {type: "SpacerItem", width: "100%", height: "50", colSpan: 4},
]);
reportGeneratorTab.dynamicForm.report = isc.DynamicForm.create({
    align: "center",
    numCols: 4,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: reportGeneratorTab.dynamicForm.fields
});
reportGeneratorTab.dynamicForm.report.getField("sourceData").disable();
reportGeneratorTab.treeGrid.report = isc.TreeGrid.create({
    autoFetchData: false,
    width: "100%",
    height: "100%",
    loadDataOnDemand: false,
    border: "0px solid green",
    showConnectors: true,
    closedIconSuffix: "",
    openIconSuffix: "",
    selectedIconSuffix: "",
    dropIconSuffix: "",
    showOpenIcons: false,
    showDropIcons: false,
    selectionAppearance: "checkbox",
    nodeIcon: "",
    folderIcon: "",
    dataSource: reportGeneratorTab.restDataSource.reportSourceFields,
    fields: [
        {name: "name", primaryKey: true, title: '<spring:message code="global.field"/>'},
        {name: "className", foreignKey: "name", title: '<spring:message code="report.group.parent-name"/>'},
        {
            name: "titleFA",
            canEdit: true,
            title: '<spring:message code="global.title-fa"/>',
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
        },
        {
            name: "titleEN",
            canEdit: true,
            title: '<spring:message code="global.title-en"/>',
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
        },
        {name: "hidden", type: "boolean", canEdit: true, title: '<spring:message code="report.hidden"/>'},
        {name: "canFilter", type: "boolean", canEdit: true, title: '<spring:message code="report.canFilter"/>'},
        {name: "type", title: '<spring:message code="global.field.type"/>'},
        {name: "dataIsList", type: "boolean", hidden: true},
    ]
});
reportGeneratorTab.window.report = new nicico.FormUtil();
reportGeneratorTab.window.report.init(null, '<spring:message code="entity.report"/>', isc.VLayout.create({
    width: "100%",
    height: "750",
    margin: 20,
    align: "center",
    members: [
        reportGeneratorTab.dynamicForm.report,
        reportGeneratorTab.treeGrid.report
    ]
}), "1200", "60%");
reportGeneratorTab.window.report.populateData = function (bodyWidget) {

    let data = reportGeneratorTab.dynamicForm.report.getValues();
    data.fields = reportGeneratorTab.treeGrid.report.getSelectedRecords();

    let formData = new FormData();
    let fileBrowserId = document.getElementById(reportGeneratorTab.dynamicForm.report.getItem("reportFile").uploadItem.getElement().id);
    formData.append("file", fileBrowserId.files[0]);
    formData.append("data", data);

    return formData;
};
reportGeneratorTab.window.report.validate = function (data) {

    reportGeneratorTab.dynamicForm.report.validate();
    if (reportGeneratorTab.dynamicForm.report.hasErrors())
        return false;

    for (let i = 0; i < reportGeneratorTab.treeGrid.report.getTotalRows(); i++) {
        reportGeneratorTab.treeGrid.report.validateRow(i);
        if (reportGeneratorTab.treeGrid.report.hasErrors())
            return false;
    }

    return true;
};
reportGeneratorTab.window.report.okCallBack = function (formData) {

    let request = new XMLHttpRequest();
    request.open("POST", "${contextPath}/api/report");
    request.setRequestHeader("contentType", "application/json; charset=utf-8");
    request.setRequestHeader("Authorization", BaseRPCRequest.httpHeaders.Authorization);
    request.send(formData);
    request.onreadystatechange = function () {

        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 0)
                isc.warn("<spring:message code='dcc.upload.error.capacity'/>");
            else if (request.status === 500)
                isc.warn("<spring:message code='dcc.upload.error.message'/>");
            else if (request.status === 200 || request.status === 201) {

                reportGeneratorTab.dialog.ok();
                reportGeneratorTab.method.refresh(reportGeneratorTab.listGrid.main);
            } else {

                // reportGeneratorTab.dialog.error();
            }
        }
    };
};
reportGeneratorTab.window.report.cancelCallBack = function () {

    reportGeneratorTab.dynamicForm.report.clearValues();

};
reportGeneratorTab.method.refreshData = function () {
    reportGeneratorTab.listGrid.main.invalidateCache();
};
reportGeneratorTab.method.newForm = function () {

    reportGeneratorTab.variable.method = "POST";
    reportGeneratorTab.dynamicForm.report.clearValues();
    reportGeneratorTab.window.report.justShowForm();
};
reportGeneratorTab.method.editForm = function () {

    reportGeneratorTab.variable.method = "PUT";

    let record = reportGeneratorTab.listGrid.main.getSelectedRecord();
    if (record == null || record.id == null)
        reportGeneratorTab.dialog.notSelected();
    else if (record.editable === false)
        reportGeneratorTab.dialog.notEditable();
    else if (record.estatus.contains(Enums.eStatus2.DeActive))
        reportGeneratorTab.dialog.inactiveRecord();
    else if (record.estatus.contains(Enums.eStatus2.Final))
        reportGeneratorTab.dialog.finalRecord();
    else {

        reportGeneratorTab.window.report.justShowForm();
    }
};
//***************************************************** MAINLISTGRID *************************************************
reportGeneratorTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "title",
        title: "<spring:message code='report.title'/>",
        type: 'date',
        width: "10%"
    },
    {
        name: "source",
        title: "<spring:message code='report.source'/>",
        type: 'text'
    },
    {
        name: "reportGroup.name",
        title: "<spring:message code='report.group.name'/>",
    }
]);
nicico.BasicFormUtil.createListGrid = function () {

    reportGeneratorTab.listGrid.main = isc.ListGrid.nicico.getDefault(reportGeneratorTab.listGrid.fields,
        reportGeneratorTab.restDataSource.report, null, {
            showFilterEditor: true,
            canAutoFitFields: true,
            autoFetchData: false,
            width: "100%",
            height: "100%",
            autoFetchData: true,
            alternateRecordStyles: true,
            wrapCells: false,
        }
    );
};
nicico.BasicFormUtil.getDefaultBasicForm(reportGeneratorTab, "api/report/");
nicico.BasicFormUtil.removeExtraGridMenuActions(reportGeneratorTab);