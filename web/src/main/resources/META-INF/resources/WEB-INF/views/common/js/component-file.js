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
    initWidget: function () {

        this.Super("initWidget", arguments);

        let This = this;
        this.form = isc.DynamicForm.create({
            width: "85%",
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
                required: true,
                wrapTitle: false,
                accept: This.accept,
                title: "<spring:message code='global.file'/> ",
                validators: [{
                    type: "required",
                    validateOnChange: true
                }]
            }, {
                required: true,
                wrapTitle: false,
                name: "accessLevel",
                title: "<spring:message code='file.access-level'/>",
                valueMap: JSON.parse('${Enum_EFileAccessLevel}'),
                validators: [{
                    type: "required",
                    validateOnChange: true
                }]
            }]
        });
        this.button = isc.IButtonSave.create({
            width: "15%",
            icon: "pieces/16/save.png",
            title: '<spring:message code="global.form.save"/> ',
            click: () => {

                if (!This.form.validate()) return;

                let fileItem = document.getElementById(This.form.getItem("file").uploadItem.getElement().id);
                This.grid.addData({
                    recordId: This.recordId,
                    entityName: This.entityName,
                    accessLevel: This.form.getValue("accessLevel"),
                    fileData: fileItem.files[0]
                });
            }
        });
        this.addMember(isc.HLayout.create({
            width: "100%",
            align: "center",
            members: [
                This.form,
                This.button
            ]
        }));

        this.grid = isc.ListGrid.nicico.getDefault([

            {name: "id", type: "integer", primaryKey: true, hidden: true, title: "<spring:message code='global.id'/>"},
            {name: "fileKey", title: "<spring:message code='global.key'/>"},
            {name: "recordId", type: "integer", title: "<spring:message code='dcc.dccViewer.Id'/>"},
            {name: "entityName", title: "<spring:message code='group.name'/>"},
            {
                name: "accessLevel",
                editorType: "SelectItem",
                title: "<spring:message code='file.access-level'/>",
                valueMap: JSON.parse('${Enum_EFileAccessLevel}')
            },
            {
                name: "fileStatus",
                editorType: "SelectItem",
                valueMap: JSON.parse('${Enum_FileStatus}'),
                title: "<spring:message code='global.status'/>"
            },
            {
                hidden: true,
                name: "fileData",
                canSort: false,
                canFilter: false,
                title: "<spring:message code='global.file'/>",
                cellClick: function (record, rowNum, colNum) {

                    if (!record || !record.fileKey)
                        return;

                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        httpMethod: "GET",
                        actionURL: "${contextPath}/api/files/" + record.fileKey,
                    }));
                },
                formatCellValue: function (value, record, rowNum, colNum, grid) {

                    if (record && record.fileKey)
                        return '<img alt="download icon" src="static/img/pieces/16/drilldown.png" style="vertical-align:middle;width:20px" />';

                    return "";
                }
            }
        ], null, null, {

            height: 200,
            canRemoveRecords: true,
        });
        this.addMember(this.grid);

        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            httpMethod: "GET",
            actionURL: "${contextPath}/api/files",
            params: {
                recordId: This.recordId,
                entityName: This.entityName
            },
            callback: function (resp) {
                This.grid.setData(resp.data);
            }
        }));
    },
    getValues: function () {

        this.grid.saveAllEdits();
        return this.grid.getData();
    }
});
