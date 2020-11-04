var reportGeneratorTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

//*************************************************** VARIABLES ********************************************************

reportGeneratorTab.variable.reportSourceUrl = "${contextPath}" + "/api/report/sources";
reportGeneratorTab.variable.reportSourceFieldsUrl = "${contextPath}" + "/api/report/sources-fields";
reportGeneratorTab.variable.reportUrl = "${contextPath}" + "/api/report";
reportGeneratorTab.variable.reportGroupUrl = "${contextPath}" + "/api/report-group";

//***************************************************** DATASOURCE *****************************************************

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

            sourceData = reportGeneratorTab.dynamicForm.report.getField("source").getValue();
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

//***************************************************** COMPONENTS *****************************************************

reportGeneratorTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "title",
        title: "<spring:message code='report.title'/>"
    },
    {
        name: "name",
        title: "<spring:message code='report.source'/>",
    },
    {
        name: "reportGroup.name",
        title: "<spring:message code='report.group.name'/>",
    }
]);
reportGeneratorTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "reportSource",
        title: "<spring:message code='report.source.type'/>",
        required: true,
        wrapTitle: false,
        width: "400",
        colSpan: 1,
        defaultValue: "Rest",
        valueMap: JSON.parse('${Enum_ReportSource}'),
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {
            let sourceDataItem = form.getItem("source");
            sourceDataItem.enable();
            sourceDataItem.clearValue();
        }
    },
    {
        name: "source",
        title: "<spring:message code='report.source'/>",
        required: true,
        width: "400",
        wrapTitle: false,
        editorType: "SelectItem",
        colSpan: 2,
        displayField: "name",
        valueField: "source",
        optionDataSource: reportGeneratorTab.restDataSource.reportSource,
        autoFetchData: true,
        canAdaptHeight: true,
        pickListProperties: {
            showFilterEditor: false,
            canAdaptHeight: true
        },
        pickListFields: [
            {name: "name", title: "<spring:message code='report.name'/>"},
            {name: "restMethod", title: "<spring:message code='report.method'/>", hidden: true}
        ],
        validators: [
            {
                type: "required",
                validateOnChange: true
            }],
        changed: function (form, item, value) {

            reportGeneratorTab.restDataSource.reportSourceFields.fetchData(null, resp => reportGeneratorTab.listGrid.reportFields.setData(resp.data.filter(q => q.type)));
        }
    },
    {
        name: "reportGroupId",
        title: "<spring:message code='report.report-group'/>",
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        colSpan: 1,
        width: "400",
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
        colSpan: 2,
        width: "400",
        wrapTitle: false,
        valueMap: JSON.parse('${Enum_ReportType}'),
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "titleFA",
        title: "<spring:message code='report.titleFA'/>",
        wrapTitle: false,
        required: true,
        keyPressFilter: "[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F ]",
        colSpan: 1,
        width: "400",
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
        title: "<spring:message code='report.titleEN'/>",
        keyPressFilter: "[A-Za-z ]", //dont change it
        wrapTitle: false,
        required: true,
        colSpan: 2,
        width: "400",
        validators: [
            {
                type: "required",
                validateOnChange: true
            },
            {
                type: "regexp",
                expression: "^[A-Za-z *\\[\\+\\-\\_\\]\\(\\)\\}\\{/\\\\]*$",
                validateOnChange: true
            }],
        showIf: function (item, value, form, values) {
            return reportGeneratorTab.variable.method === "POST";
        }
    },
    {type: "SpacerItem", width: "100%", height: "50", colSpan: 4},
]);

reportGeneratorTab.dynamicForm.report = isc.DynamicForm.create({
    align: "center",
    numCols: 6,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: reportGeneratorTab.dynamicForm.fields
});
reportGeneratorTab.listGrid.reportFields = isc.ListGrid.nicico.getDefault(BaseFormItems.concat([
    {name: "name", title: '<spring:message code="global.field"/>'},
    {name: "className", hidden: true, title: '<spring:message code="report.group.parent-name"/>'},
    {
        name: "titleFA",
        canEdit: true,
        required: true,
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
        required: true,
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
    {
        name: "hidden",
        type: "boolean",
        canEdit: true,
        title: '<spring:message code="report.hidden"/>',
        required: true,
        validators: [{
            type: "required",
            validateOnChange: true
        }]
    },
    {
        name: "canFilter",
        type: "boolean",
        canEdit: true,
        title: '<spring:message code="report.canFilter"/>',
        required: true,
        validators: [{
            type: "required",
            validateOnChange: true
        }]
    },
    {name: "type", title: '<spring:message code="global.field.type"/>'},
    {name: "dataIsList", title: '<spring:message code="report.data-is-list"/>', type: "boolean", hidden: true}
]), null, null, {
    autoFetchData: false,
    selectionAppearance: "checkbox",
    showFilterEditor: false,
    groupByField: "className",
    groupStartOpen: "none",
    selectionType: "simple",
    autoSaveEdits: false,
    selectOnEdit: false,
    getGroupTitle: function (groupData) {
        return groupData.groupValue === "-none-" ? "" : groupData.groupValue;
    },
    // rowEditorEnter: function (record, editValues, rowNum) {
    //
    //     this.deselectAllRecords();
    //     return this.Super("rowEditorEnter", arguments);
    // },
    // startEditing: function (rowNum, colNum, suppressFocus) {
    //     this.checkedRecords = this.getSelectedRecords();
    //     return this.Super("startEditing", arguments);
    // },
    // endEditing: function () {
    //     this.getOriginalData().forEach(q => {
    //         if (this.checkedRecords.filter(p => p.name === q.name).length !== 0)
    //             this.selectRecord(q);
    //     });
    //     return this.Super("endEditing", arguments);
    // },
    // recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
    //     this.checkedRecords = this.getSelectedRecords();
    //     return this.Super("recordDoubleClick", arguments);
    // },
    // rowEditorExit: function (editCompletionEvent, record, newValues, rowNum) {
    //
    //     if (editCompletionEvent !== "escape")
    //         this.setEditValues(rowNum, newValues);
    //
    //     this.getOriginalData().forEach(q => {
    //         if (this.checkedRecords.filter(p => p.name === q.name).length !== 0)
    //             this.selectRecord(q);
    //     });
    // }
});

reportGeneratorTab.window.report = new nicico.FormUtil();
reportGeneratorTab.variable.fileUploadForm = isc.FileUploadForm.create({
    height: "200",
    accept: ".jasper",
    entityName: "Report",
    fileStatusValueMap: JSON.parse('${Enum_FileStatus}'),
    accessLevelValueMap: JSON.parse('${Enum_EFileAccessLevel}')
});
reportGeneratorTab.window.report.init(null, '<spring:message code="entity.report"/>', isc.VLayout.create({
    width: "100%",
    height: "750",
    margin: 20,
    align: "center",
    members: [
        reportGeneratorTab.dynamicForm.report,
        reportGeneratorTab.variable.fileUploadForm,
        reportGeneratorTab.listGrid.reportFields
    ]
}), "1200", "60%");
reportGeneratorTab.window.report.populateData = function (bodyWidget) {

    let data = reportGeneratorTab.dynamicForm.report.getValues();
    let sourceField = reportGeneratorTab.dynamicForm.report.getField("source").getSelectedRecord();
    if (sourceField != null) {

        data.nameFA = sourceField.nameFA;
        data.nameEN = sourceField.nameEN;
        data.restMethod = sourceField.restMethod;
        data.dataIsList = sourceField.dataIsList;
    }
    reportGeneratorTab.listGrid.reportFields.saveAllEdits();
    data.fields = reportGeneratorTab.listGrid.reportFields.getSelectedRecords().filter(q => q.type);
    data.fields.forEach(field => {

        field.reportId = data.id;
        let invalidKeys = Object.keys(field).filter(p => p.startsWith("_") || p.startsWith("$"));
        invalidKeys.forEach(invalidKey => delete field[invalidKey]);
    });

    let formData = new FormData();
    let fileData = reportGeneratorTab.variable.fileUploadForm.getValues();
    let files = [];
    let fileMetaData = [];
    for (let i = 0; i < fileData.length; i++) {
        let metaData = fileData[i];
        files.add(metaData.fileData);
        fileMetaData.add({
            "id": metaData.id,
            "fileKey": metaData.fileKey,
            "recordId": metaData.recordId,
            "entityName": metaData.entityName,
            "fileStatus": metaData.fileStatus,
            "accessLevel": metaData.accessLevel
        });
    }
    files.forEach(q => formData.append("files", q));
    formData.append("fileMetaData", JSON.stringify(fileMetaData));
    formData.append("data", JSON.stringify(data));

    return formData;
};
reportGeneratorTab.window.report.validate = function (formDaata) {

    reportGeneratorTab.dynamicForm.report.validate();
    if (reportGeneratorTab.dynamicForm.report.hasErrors())
        return false;

    reportGeneratorTab.listGrid.reportFields.saveAllEdits();
    let selectedFields = reportGeneratorTab.listGrid.reportFields.getSelectedRecords().filter(q => q.type);
    if (!selectedFields || !selectedFields.length) {

        reportGeneratorTab.dialog.notSelected();
        return false;
    }

    for (let i = 0; i < selectedFields.length; i++) {

        let rowNum = reportGeneratorTab.listGrid.reportFields.getRowNum(selectedFields[i]);
        if (!rowNum || rowNum < 0)
            continue;

        reportGeneratorTab.listGrid.reportFields.startEditing(rowNum);
        reportGeneratorTab.listGrid.reportFields.endEditing();
        if (!reportGeneratorTab.listGrid.reportFields.validateRow(rowNum)) {

            reportGeneratorTab.dialog.say('<spring:message code="report.filed-data-is-invalid"/>');
            return false;
        }
    }
    return true;
};
reportGeneratorTab.window.report.okCallBack = function (formData) {

    let request = new XMLHttpRequest();
    request.open(reportGeneratorTab.variable.method, reportGeneratorTab.variable.url);
    request.setRequestHeader("contentType", "application/json; charset=utf-8");
    request.setRequestHeader("Authorization", BaseRPCRequest.httpHeaders.Authorization);
    request.send(formData);
    request.onreadystatechange = function () {

        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 0)
                isc.warn("<spring:message code='dcc.upload.error.capacity'/>");
            else if (request.status === 500)
                isc.warn(JSON.parse(request.responseText).errors.map(q => q.message).join('<br>'), {title: "<spring:message code='dialog_WarnTitle'/>"});
            else if (request.status === 200 || request.status === 201) {

                reportGeneratorTab.dialog.ok();
                reportGeneratorTab.method.refresh(reportGeneratorTab.listGrid.main);
            } else {
                reportGeneratorTab.dialog.say(request);
            }
        } else isc.warn(JSON.parse("<spring:message code='report.form.data-integrity-violation'/>", {title: "<spring:message code='dialog_WarnTitle'/>"}));
    };
};
reportGeneratorTab.window.report.cancelCallBack = function () {

    reportGeneratorTab.dynamicForm.report.clearValues();
    reportGeneratorTab.listGrid.reportFields.setData([]);
    reportGeneratorTab.variable.fileUploadForm.clearData();
};

//******************************************************** FUNCTIONS ***************************************************

reportGeneratorTab.method.newForm = function () {

    reportGeneratorTab.variable.method = "POST";
    reportGeneratorTab.dynamicForm.report.clearValues();
    reportGeneratorTab.listGrid.reportFields.setData([]);
    reportGeneratorTab.variable.fileUploadForm.clearData();
    reportGeneratorTab.variable.fileUploadForm.reloadData(0);
    reportGeneratorTab.window.report.justShowForm();
};
reportGeneratorTab.method.editForm = function () {

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

        reportGeneratorTab.variable.method = "PUT";

        reportGeneratorTab.dynamicForm.report.editRecord(record);
        reportGeneratorTab.variable.fileUploadForm.clearData();
        reportGeneratorTab.variable.fileUploadForm.reloadData(record.id);
        reportGeneratorTab.restDataSource.reportSourceFields.fetchData(null, resp => {

            let data = resp.data.filter(q => q.type);
            reportGeneratorTab.listGrid.reportFields.setData(data);
            setTimeout(() => reportGeneratorTab.listGrid.reportFields.getOriginalData().forEach(q => {

                let first = record.reportFields.filter(p => p.name === q.name).first();
                if (first != null) {

                    reportGeneratorTab.listGrid.reportFields.selectRecord(q);
                    q.id = first.id;
                    q.version = first.version;
                    q.editable = first.editable;
                    q.estatus = first.estatus;
                    q.titleFA = first.titleFA;
                    q.titleEN = first.titleEN;
                    q.hidden = first.hidden;
                    q.canFilter = first.canFilter;
                }
            }), 500);
        });

        reportGeneratorTab.window.report.justShowForm();
    }
};

//********************************************************* BASIC ******************************************************

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