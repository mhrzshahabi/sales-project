//******************************************************* VARIABLES ****************************************************

var reportGeneratorTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
reportGeneratorTab.variable.reportSourceUrl = "${contextPath}" + "/api/report/sources";
reportGeneratorTab.variable.reportUrl = "${contextPath}" + "/api/report";
reportGeneratorTab.variable.reportGroupUrl = "${contextPath}" + "/api/reportGroup";
var REPORT_RESOURCE = "";
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

        dsRequest.params = {
            reportSource: REPORT_RESOURCE,
        };
        this.Super("transformRequest", arguments);
    },
    transformResponse: function (dsResponse, dsRequest, data) {

        return this.Super("transformResponse", arguments);
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
    fetchDataURL: reportGeneratorTab.variable.reporrtUrl + "/spec-list"
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
    fetchDataURL: reportGeneratorTab.variable.reporrtGroupUrl + "/spec-list"
});

//***************************************************** MAINWINDOW *************************************************

reportGeneratorTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "reportSource",
        title: "<spring:message code='report.source.type'/>",
        required: true,
        wrapTitle: false,
        colSpan: 1,
        valueMap: JSON.parse('${Enum_ReportSource}'),
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {
            form.getItem("sourceData").enable();
            REPORT_RESOURCE = value;
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
        pickListWidth: 200,
        optionDataSource: reportGeneratorTab.restDataSource.reportSource,
        autoFetchData: true,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "nameFA", title: "<spring:message code='report.name'/>", width: 200}
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {
            debugger;
            let record = this.getSelectedRecord();
            reportGeneratorTab.treeGrid.report.setData(record.fields);
        }
        /*   getValue:function () {
               return this.getSelectedRecord();
           }*/
    },
    {
        name: "reportGroup",
        title: "<spring:message code='report.reportGroup'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        colSpan: 1,
        displayField: "name",
        valueField: "id",
        pickListWidth: 200,
        optionDataSource: reportGeneratorTab.restDataSource.reportGroup,
        autoFetchData: true,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "name", title: "<spring:message code='report.group.name'/>", width: 200}
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "titleFa",
        title: "<spring:message code='report.titleFA'/>",
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
        required: true,
        colSpan: 1,
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
        name: "reportFile",
        title: "<spring:message code='report.file'/> ",
        type: "file",
        required: true,
        accept: "jrxml/*",
        colSpan: 4,
        multiple: "",
        width: 200,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
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
    dataPageSize: 50,
    loadDataOnDemand: true,
    border: "0px solid green",
    dataFetchMode: "paged",
    showConnectors: true,
    closedIconSuffix: "",
    openIconSuffix: "",
    selectedIconSuffix: "",
    dropIconSuffix: "",
    showOpenIcons: false,
    showDropIcons: false,
    nodeIcon: "",
    folderIcon: "",
    fields: [
        {name: "name",primaryKey:true},
        {name: "titleFA",canEdit:true},
        {name: "titleEN",canEdit:true},
        {name: "className" ,foreignKey:"name"},
        {name: "hidden",canEdit:true},
        {name: "dataIsList"},
        {name: "type"},
        {name: "canFilter",canEdit:true},
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

    return reportGeneratorTab.dynamicForm.report;
};
reportGeneratorTab.window.report.validate = function (data) {

    reportGeneratorTab.dynamicForm.report.validate();
    if (reportGeneratorTab.dynamicForm.report.hasErrors())
        return false;

    return true;
};
reportGeneratorTab.window.report.okCallBack = function (reportCostObj) {
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/report",
            httpMethod: reportGeneratorTab.variable.method,
            data: JSON.stringify(reportCostObj),
            callback: function (resp) {
                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    reportGeneratorTab.method.refreshData();
                } else
                    isc.say(RpcResponse_o.data);
            }
        })
    );

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
nicico.BasicFormUtil.showAllToolStripActions(reportGeneratorTab);