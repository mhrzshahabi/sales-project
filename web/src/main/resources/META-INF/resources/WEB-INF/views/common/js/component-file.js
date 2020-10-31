isc.defineClass("FileUploadForm", isc.VLayout).addProperties({

    align: "top",
    width: "100%",
    autoFit: false,
    autoDraw: false,
    showEdges: false,
    canAdaptHeight: true,
    layoutMargin: 2,
    membersMargin: 2,
    overflow: "visible",
    form: null,
    grid: null,
    button: null,
    accept: null,
    recordId: null,
    entityName: null,
    fileStatusValueMap: null,
    accessLevelValueMap: null,
    showDeletedFiles: false,
    canAddFile: true,
    canRemoveFile: true,
    canDownloadFile: true,
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.form = isc.DynamicForm.create({
            width: "90%",
            align: "center",
            numCols: 4,
            canSubmit: true,
            showErrorText: true,
            showErrorStyle: true,
            errorOrientation: "bottom",
            requiredMessage: '<spring:message code="validator.field.is.required"/>',
            fields: [{
                name: "file",
                type: "file",
                multiple: "",
                wrapTitle: false,
                accept: This.accept,
                title: "<spring:message code='global.file'/> "
            }, {
                colSpan: 1,
                wrapTitle: false,
                name: "accessLevel",
                title: "<spring:message code='file.access-level'/>",
                valueMap: This.accessLevelValueMap
            }]
        });
        if (!this.canAddFile)
            this.form.hide();
        this.button = isc.IButtonSave.create({
            title: "<spring:message code='global.add'/>",
            padding: "5",
            autoFit: true,
            align: "center",
            iconAlign: "center",
            icon: "pieces/16/icon_add.png",
            click: () => {

                if (!This.form.validate()) return;
                if (!This.form.getValue("file")) {

                    This.form.errors["file"] = '<spring:message code="validator.field.is.required"/>';
                    This.form.redraw();
                    return;
                }
                if (!This.form.getValue("accessLevel")) {

                    This.form.errors["accessLevel"] = '<spring:message code="validator.field.is.required"/>';
                    This.form.redraw();
                    return;
                }
                let fileItem = document.getElementById(This.form.getItem("file").uploadItem.getElement().id);
                This.grid.addData({
                    recordId: This.recordId,
                    entityName: This.entityName,
                    accessLevel: This.form.getValue("accessLevel"),
                    fileData: fileItem.files[0]
                });
                This.form.clearValue("file");
            }
        });
        if (!this.canAddFile)
            this.button.hide();
        this.addMember(isc.HLayout.create({
            width: "100%",
            align: "center",
            visibility: !this.canAddFile ? "hidden" : "visible",
            members: [
                This.form,
                This.button
            ]
        }));

        let fields = [
            {name: "id", type: "integer", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "fileKey", title: "<spring:message code='global.key'/>"},
            {name: "recordId", type: "integer", title: "<spring:message code='dcc.dccViewer.Id'/>"},
            {name: "entityName", title: "<spring:message code='group.name'/>"},
            {
                name: "accessLevel",
                editorType: "SelectItem",
                title: "<spring:message code='file.access-level'/>",
                valueMap: This.accessLevelValueMap
            },
            {
                name: "fileStatus",
                editorType: "SelectItem",
                valueMap: This.fileStatusValueMap,
                title: "<spring:message code='global.status'/>"
            }
        ];
        if (this.canDownloadFile)
            fields.add({
                name: "fileData",
                canSort: false,
                canFilter: false,
                title: "<spring:message code='global.file'/>",
                formatCellValue: function (value, record, rowNum, colNum, grid) {

                    if (record && record.fileKey && record.fileStatus && record.fileStatus !== "DELETED")
                        return '<img alt="download icon" src="static/img/pieces/download.png" style="vertical-align:middle;width:20px" />';

                    return "";
                }
            });
        this.grid = isc.ListGrid.nicico.getDefault(fields, null, null, {

            canRemoveRecords: This.canRemoveFile,
            border: "0px",
            showFilterEditor: false,
            removeRecordClick: function (rowNum) {

                let record = this.getRecord(rowNum);
                if (!record || record.fileStatus === "DELETED")
                    return false;

                return this.Super("removeRecordClick", arguments);
            },
            cellClick: function (record, rowNum, colNum) {

                if (!record || !record.fileKey || colNum !== this.getFieldNum("fileData") || !record.fileStatus || record.fileStatus === "DELETED")
                    return;

                fetch("${contextPath}/api/files/" + record.fileKey, {headers: SalesConfigs.httpHeaders}).then(
                    response => {

                        if (response.ok)
                            response.blob().then(file => {

                                const url = URL.createObjectURL(file);
                                const linkElement = document.createElement('a');
                                const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                                const fileName = filenameRegex.exec(response.headers.get("content-disposition"))[1].replace(/['"]/g, '');

                                linkElement.setAttribute('download', fileName);
                                linkElement.href = url;
                                linkElement.click();
                            });
                        else response.json().then(r => isc.warn(r.errors.map(q => q.message).join('<br>'), {title: "<spring:message code='dialog_WarnTitle'/>"}));
                    }
                );
            },
        });
        this.addMember(this.grid);
    },
    getValues: function () {

        this.grid.saveAllEdits();
        let values = [...this.grid.getData()];
        values.forEach(q => q.fileData = q.fileData ? q.fileData : new File([], "emptyFile"));
        return values;
    },
    getSelectedValue: function () {

        this.grid.saveAllEdits();
        let selected = this.grid.getSelectedRecord();
        if (!selected) return null;

        let value = {...selected};
        value.fileData = value.fileData ? value.fileData : new File([], "emptyFile");
        return value;
    },
    getSelectedValues: function () {

        this.grid.saveAllEdits();
        let values = [...this.grid.getSelectedRecords()];
        values.forEach(q => q.fileData = q.fileData ? q.fileData : new File([], "emptyFile"));
        return values;
    },
    clearData: function () {
        this.form.clearValues();
        this.grid.setData([]);
    },
    reloadData: function (recordId, entityName) {

        let This = this;
        if (entityName) this.entityName = entityName;
        if (recordId || recordId === 0) this.recordId = recordId;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            actionURL: "${contextPath}/api/files",
            params: {
                recordId: This.recordId,
                entityName: This.entityName
            },
            callback: function (resp) {

                let data = JSON.parse(resp.httpResponseText);
                if (!This.showDeletedFiles)
                    data = data.filter(q => q.fileStatus !== "DELETED");
                This.grid.setData(data);
            }
        }));
    }
});
