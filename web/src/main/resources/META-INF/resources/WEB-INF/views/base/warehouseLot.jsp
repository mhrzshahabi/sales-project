<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var ListGrid_WarehouseLotPaste;
    var RestDataSource_Material = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='material.code'/> "},
                {name: "descl", title: "<spring:message code='material.descl'/> "},
                {name: "descp", title: "<spring:message code='material.descp'/> "},
                {name: "unitId", title: "<spring:message code='MaterialFeature.unit'/>"},//Edit By JZ
                {name: "unit.nameEN", title: "<spring:message code='MaterialFeature.unit'/> "},//Edit By JZ
            ],
        fetchDataURL: "${contextPath}/api/material/spec-list"
    });

    function ListGrid_WarehouseLot_refresh() {
        ListGrid_WarehouseLot.invalidateCache();
    }

    var RestDataSource_WarehouseLot = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouseNo'/>", align: "center"},
                {name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", align: "center"},
                {name: "material.descl", title: "<spring:message code='goods.nameLatin'/> "},
                {name: "lotName", title: "<spring:message code='warehouseLot.lotName'/>", align: "center"},
                {name: "mo", title: "<spring:message code='warehouseLot.mo'/>", align: "center"},
                {name: "cu", title: "<spring:message code='warehouseLot.cu'/>", align: "center"},
                {name: "si", title: "<spring:message code='warehouseLot.si'/>", align: "center"},
                {name: "pb", title: "<spring:message code='warehouseLot.pb'/>", align: "center"},
                {name: "s", title: "<spring:message code='warehouseLot.s'/>", align: "center"},
                {name: "c", title: "<spring:message code='warehouseLot.c'/>", align: "center"},
                {name: "p", title: "<spring:message code='warehouseLot.p'/>", align: "center"},
                {name: "size1", title: "<spring:message code='warehouseLot.size1'/>", align: "center"},
                {name: "size1Value", title: "<spring:message code='warehouseLot.size1Value'/>", align: "center"},
                {name: "size2", title: "<spring:message code='warehouseLot.size2'/>", align: "center"},
                {name: "size2Value", title: "<spring:message code='warehouseLot.size2Value'/>", align: "center"},
                {name: "weightKg", title: "<spring:message code='warehouseLot.weightKg'/>", align: "center"},
                {name: "grossWeight", title: "<spring:message code='grossWeight.weightKg'/>", align: "center"},
                {name: "contractId", title: "contractId", align: "center"},
                {name: "used", title: "used", align: "center"}
            ],
        fetchDataURL: "${contextPath}/api/warehouseLot/spec-list"
    });
    var WarehouseLotData = [];
    for (i = 0; i < 100; i++) {
        WarehouseLotData.add({id: i});
    }

    var ClientDataSource_WarehouseLot = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouseNo'/>", align: "center"},
                {name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", align: "center"},
                {name: "tblMaterial.id", title: "<spring:message code='goods.nameLatin'/> "},
                {name: "lotName", title: "<spring:message code='warehouseLot.lotName'/>", align: "center"},
                {
                    name: "mo",
                    title: "<spring:message
		code='warehouseLot.mo'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "cu",
                    title: "<spring:message
		code='warehouseLot.cu'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "si",
                    title: "<spring:message
		code='warehouseLot.si'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "pb",
                    title: "<spring:message
		code='warehouseLot.pb'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "s",
                    title: "<spring:message
		code='warehouseLot.s'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "c",
                    title: "<spring:message
		code='warehouseLot.c'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "p", title: "<spring:message code='warehouseLot.p'/>", align: "center"},
                {name: "size1", title: "<spring:message code='warehouseLot.size1'/>", align: "center"},
                {
                    name: "size1Value",
                    title: "<spring:message
		code='warehouseLot.size1Value'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "size2", title: "<spring:message code='warehouseLot.size2'/>", align: "center"},
                {
                    name: "size2Value",
                    title: "<spring:message
		code='warehouseLot.size2Value'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "weightKg",
                    title: "<spring:message
		code='warehouseLot.weightKg'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "grossWeight",
                    title: "<spring:message
		code='warehouseLot.grossWeight'/>",
                    align: "center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ],
        testData: WarehouseLotData,
        clientOnly: true
    });

    /* ****************** */

    function pasteText(text) {
        var fieldNames = [];
        ListGrid_WarehouseLotPaste.selectAllRecords();
        for (var col = 0; col < 13; col++) {
            fieldNames.add(ListGrid_WarehouseLotPaste.getFieldName(col));
        }
        var settings = {
            fieldList: fieldNames,
            fieldSeparator: "\t",
            escapingMode: "double"
        };
        var dataSource = ListGrid_WarehouseLotPaste.dataSource;
        var records = dataSource.recordsFromText(text, settings);
        ListGrid_WarehouseLotPaste.applyRecordData(records);
    }


    function createPasteDialog() {
        isc.Window.create({
            ID: "Window_WarehouseLot_Paste",
            title: "<spring:message code='global.form.pasteCells'/>",
            autoSize: false,
            width: "100%",
            height: "70%",
            isModal: true,
            showModalMask: true,
            showMaximizeButton: true,
            canDragResize: true,
            autoCenter: true,
            closeClick: function () {
                this.Super("closeClick", arguments);
            },
            items: [
                isc.HLayout.create({
                    membersMargin: 3,
                    width: "100%",
                    alignLayout: "center",
                    members: [
                        isc.DynamicForm.create({
                            ID: "resultsForm",
                            numCols: 6,
                            width: 600,
                            height: 300,
                            autoFocus: true,
                            fields: [
                                {
                                    name: "warehouseNo",
                                    title: "<spring:message code='dailyWarehouse.warehouseNo'/>",
                                    colSpan: 6
                                },
                                {
                                    name: "tblMaterial.id",
                                    ID: "tblMaterial.id",
                                    title: "<spring:message code='goods.nameFa'/>",
                                    type: 'long',
                                    editorType: "SelectItem",
                                    colSpan: 6,
                                    optionDataSource: RestDataSource_Material,
                                    displayField: "descl",
                                    valueField: "id",
                                    pickListWidth: "500",
                                    pickListHeight: "500",
                                    pickListProperties: {showFilterEditor: true},
                                    pickListFields: [{name: "id", width: 50, align: "center"}, {
                                        name: "descl",
                                        width: 150,
                                        align: "center"
                                    }, {name: "code", width: 150}]
                                },
                                {
                                    name: "plant", title: "<spring:message code='warehouseLot.plant'/>", colSpan: 6
                                },
                                {
                                    type: "text",
                                    name: "guidance",
                                    colSpan: 6,
                                    showTitle: false,
                                    editorType: "StaticTextItem"
                                    ,
                                    value: "<spring:message code='global.form.PressCtrlV'/>"
                                },
                                {
                                    type: "text",
                                    name: "textArea",
                                    canEdit: true,
                                    colSpan: 6,
                                    showTitle: false,
                                    height: "*",
                                    width: "*",
                                    editorType: "TextAreaItem"
                                },
                                {
                                    type: "text",
                                    name: "apply",
                                    editorType: "ButtonItem",
                                    title: "<spring:message code='global.form.apply'/>",
                                    click: function (form) {
                                        pasteText(form.getValue("textArea"));
                                        ListGrid_WarehouseLotPaste.saveAllEdits();
                                    }
                                }
                            ]


                        }) /* dynamic Form */
                        , ListGrid_WarehouseLotPaste = isc.ListGrid.create({
                            dataSource: ClientDataSource_WarehouseLot,
                            sortDirection: "descending",
                            width: "100%",
                            height: 300,
                            canEdit: true,
                            autoFetchData: true,
                            canDragSelect: true,
                            canSelectCells: true,
                            autoSaveData: true,
                            fields: [
                                {
                                    name: "lotName",
                                    title: "<spring:message code='warehouseLot.lotName'/>",
                                    align: "center"
                                },
                                {name: "mo", title: "<spring:message code='warehouseLot.mo'/>", align: "center"},
                                {name: "cu", title: "<spring:message code='warehouseLot.cu'/>", align: "center"},
                                {name: "si", title: "<spring:message code='warehouseLot.si'/>", align: "center"},
                                {name: "pb", title: "<spring:message code='warehouseLot.pb'/>", align: "center"},
                                {name: "s", title: "<spring:message code='warehouseLot.s'/>", align: "center"},
                                {name: "c", title: "<spring:message code='warehouseLot.c'/>", align: "center"},
                                {name: "p", title: "<spring:message code='warehouseLot.p'/>", align: "center"},
                                {name: "size1", title: "<spring:message code='warehouseLot.size1'/>", align: "center"},
                                {
                                    name: "size1Value",
                                    title: "<spring:message code='warehouseLot.size1Value'/>",
                                    align: "center"
                                },
                                {name: "size2", title: "<spring:message code='warehouseLot.size2'/>", align: "center"},
                                {
                                    name: "size2Value",
                                    title: "<spring:message code='warehouseLot.size2Value'/>",
                                    align: "center"
                                },
                                {
                                    name: "weightKg",
                                    title: "<spring:message code='warehouseLot.weightKg'/>",
                                    align: "center"
                                },
                                {
                                    name: "grossWeight",
                                    title: "<spring:message code='warehouseLot.grossWeight'/>",
                                    align: "center"
                                },
                            ]
                        })

                    ]
                }),
                isc.HLayout.create({
                    membersMargin: 3,
                    width: "100%",
                    alignLayout: "center",
                    members: [
                        isc.IButton.create({
                            title: "<spring:message code='global.form.save'/>",
                            icon: "pieces/16/save.png",
                            click: function () {
                                resultsForm.validate();
                                if (resultsForm.hasErrors())
                                    return;
                                var lotName;
                                var rec;
                                var selected = ListGrid_WarehouseLotPaste.getSelection();
                                resultsForm.setValue("selected", selected)
                                resultsForm.setValue("plant", resultsForm.getValue("plant"));
                                resultsForm.setValue("warehouseNo", resultsForm.getValue("warehouseNo"));
                                resultsForm.setValue("tblMaterial", resultsForm.getValue("tblMaterial.id"));
                                var data = resultsForm.getValues();

                                isc.RPCManager.sendRequest({
                                    actionURL: "${contextPath}/api/warehouseLot/",
                                    httpMethod: "POST",
                                    useSimpleHttp: true,
                                    contentType: "application/json; charset=utf-8",
                                    showPrompt: false,
                                    data: JSON.stringify(data),
                                    serverOutputAsString: false,
//params: { data:data1},
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.data == 'success') {
                                            isc.say("<spring:message code='global.form.request.successful'/>.");
                                            ListGrid_WarehouseLot_refresh();
                                            Window_WarehouseLot.close();
                                        } else
                                            isc.say(RpcResponse_o.data);
                                    }
                                });
                            }
                        }),
                        isc.Label.create({width: 5,}),
                        isc.IButton.create({
                            top: 260,
                            title: "<spring:message code='global.cancel'/>",
                            icon: "pieces/16/icon_delete.png",
                            click: function () {
                                Window_WarehouseLot_Paste.close();
                            }
                        })
                    ]
                })

            ]
        });
        /* windows*/


    }

    /* ****************** */

    function ListGrid_WarehouseLot_edit() {

        var record = ListGrid_WarehouseLot.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            DynamicForm_WarehouseLot.editRecord(record);
            Window_WarehouseLot.show();
        }
    }

    function ListGrid_WarehouseLot_remove() {

        var record = ListGrid_WarehouseLot.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [isc.Button.create({
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var warehouseLotId = record.id;
                        alert("warehouseLotId: "+warehouseLotId);
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                            actionURL: "${contextPath}/api/warehouseLot/" + warehouseLotId,
                            httpMethod: "DELETE",
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                    ListGrid_WarehouseLot_refresh();
                                } else {
                                    alert(RpcResponse_o.data);
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    ListGrid_WarehouseLot_refresh();
                                }
                            }
                        })
                    );
                    }
                }
            });
        }
    };
    var Menu_ListGrid_WarehouseLot = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    DynamicForm_WarehouseLot.clearValues();
                    Window_WarehouseLot.show();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_WarehouseLot.clearValues();
                    var record = ListGrid_WarehouseLot.getSelectedRecord();

                    if (!(record == null || record.id == null)) {
                        DynamicForm_WarehouseLot.setValue("warehouseNo", record.warehouseNo);
                        DynamicForm_WarehouseLot.setValue("tblMaterial.id", record.tblMaterial.id);
                        DynamicForm_WarehouseLot.setValue("plant", record.plant);
                    }
                    Window_WarehouseLot.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_WarehouseLot_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_WarehouseLot_remove();
                }
            },
            {isSeparator: true},


        ]
    });

    var DynamicForm_WarehouseLot = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 1,
        fields:
            [

                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "warehouseNo",
                    title: "<spring:message code='dailyWarehouse.warehouseNo'/>",
                    align: "center",
                    width: 400,
                        },
                        {
                                    name: "materialId",
                                    title: "<spring:message code='goods.nameFa'/>",
                                    type: 'long',
                                    editorType: "SelectItem",
                                    colSpan: 6,
                                    optionDataSource: RestDataSource_Material,
                                    displayField: "descl",
                                    valueField: "id",
                                    pickListWidth: "500",
                                    pickListHeight: "500",
                                    pickListProperties: {showFilterEditor: true},
                                    pickListFields: [{name: "id", width: 50, align: "center"}, {
                                        name: "descl",
                                        width: 150,
                                        align: "center"
                                    }, {name: "code", width: 150}]
                                },
                        {
                        name: "plant",
                        title: "<spring:message code='warehouseLot.plant'/>",
                        align: "center",
                        width: 400
                },
                {name: "lotName", title: "<spring:message code='warehouseLot.lotName'/>", width: 400, align: "center"},
                {name: "mo", title: "<spring:message code='warehouseLot.mo'/>", align: "center", width: 400},
                {name: "cu", title: "<spring:message code='warehouseLot.cu'/>", align: "center", width: 400},
                {name: "si", title: "<spring:message code='warehouseLot.si'/>", align: "center", width: 400},
                {name: "pb", title: "<spring:message code='warehouseLot.pb'/>", align: "center", width: 400},
                {name: "s", title: "<spring:message code='warehouseLot.s'/>", align: "center", width: 400},
                {name: "c", title: "<spring:message code='warehouseLot.c'/>", align: "center", width: 400},
                {name: "p", title: "<spring:message code='warehouseLot.p'/>", align: "center", width: 400},
                {name: "size1", title: "<spring:message code='warehouseLot.size1'/>", align: "center", width: 400},
                {
                    name: "size1Value",
                    title: "<spring:message code='warehouseLot.size1Value'/>",
                    align: "center",
                    width: 400
                },
                {name: "size2", title: "<spring:message code='warehouseLot.size2'/>", align: "center", width: 400},
                {
                    name: "size2Value",
                    title: "<spring:message code='warehouseLot.size2Value'/>",
                    align: "center",
                    width: 400
                },
                {
                    name: "weightKg",
                    title: "<spring:message code='warehouseLot.weightKg'/>",
                    align: "center",
                    width: 400
                },
                {
                    name: "grossWeight",
                    title: "<spring:message code='warehouseLot.grossWeight'/>",
                    align: "center",
                    width: 400
                },
                {name: "contractId",title: "contractId", align: "center", hidden: true},
                {name: "used",type:"boolean",title: "used", align: "center", hidden: true}
            ]
    });

    var ToolStripButton_WarehouseLot_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseLot_refresh();
        }
    });

    var ToolStripButton_WarehouseLot_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
                DynamicForm_WarehouseLot.clearValues()
                Window_WarehouseLot.show();
           /* ;
            var record = ListGrid_WarehouseLot.getSelectedRecord();
            if (!(record == null || record.id == null)) {
                DynamicForm_WarehouseLot.setValue("warehouseNo", record.warehouseNo);
                DynamicForm_WarehouseLot.setValue("tblMaterial.id", record.tblMaterial.id);
                DynamicForm_WarehouseLot.setValue("plant", record.plant);
            }*/

        }
    });

    var ToolStripButton_WarehouseLot_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_WarehouseLot_edit();
        }
    });

    var ToolStripButton_WarehouseLot_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_WarehouseLot_remove();
        }
    });


    var ToolStripButton_WarehouseLot_Paste = isc.ToolStripButton.create({
        icon: "[SKIN]/RichTextEditor/paste.png",
        title: "<spring:message code='global.form.pasteCells'/>",
        click: function () {
            createPasteDialog();
        }
    });
    var ToolStrip_Actions_WarehouseLot = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_WarehouseLot_Refresh,
                ToolStripButton_WarehouseLot_Add,
                ToolStripButton_WarehouseLot_Edit,
                ToolStripButton_WarehouseLot_Remove
          //      ToolStripButton_WarehouseLot_Paste
            ]
    });

    var HLayout_WarehouseLot_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseLot
            ]
    });

    var IButton_WarehouseLot_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            <spring:url value="/api/warehouseLot" var="warehouseLotSaveUrl"/>
            DynamicForm_WarehouseLot.validate();
            if (DynamicForm_WarehouseLot.hasErrors())
                return;
            var data = DynamicForm_WarehouseLot.getValues();
            var method = "PUT";
            if (data.id == null)
             method = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${warehouseLotSaveUrl}", ///to do abouzar
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            Window_WarehouseLot.close();
                            ListGrid_WarehouseLot.invalidateCache();
                            //to do save
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });
    var IButton_WarehouseLot_Cancel = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_WarehouseLot.close();
        }
    });
    var Window_WarehouseLot = isc.Window.create({
        title: "<spring:message code='molybdenum.title'/> ",
        width: 580,
        height: 500,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                DynamicForm_WarehouseLot,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_WarehouseLot_Save,
                            isc.Label.create({width: 5,}),
                            IButton_WarehouseLot_Cancel
                        ]
                })
            ]
    });
    var ListGrid_WarehouseLot = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WarehouseLot,
        contextMenu: Menu_ListGrid_WarehouseLot,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouseNo'/>", align: "center"},
                {name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", align: "center"},
                {name: "material.descl", title: "<spring:message code='goods.nameLatin'/> ", canEdit: false},
                {name: "lotName", title: "<spring:message code='warehouseLot.lotName'/>", align: "center"},
                {name: "mo", title: "<spring:message code='warehouseLot.mo'/>", align: "center"},
                {name: "cu", title: "<spring:message code='warehouseLot.cu'/>", align: "center"},
                {name: "si", title: "<spring:message code='warehouseLot.si'/>", align: "center"},
                {name: "pb", title: "<spring:message code='warehouseLot.pb'/>", align: "center"},
                {name: "s", title: "<spring:message code='warehouseLot.s'/>", align: "center"},
                {name: "c", title: "<spring:message code='warehouseLot.c'/>", align: "center"},
                {name: "p", title: "<spring:message code='warehouseLot.p'/>", align: "center"},
                {name: "size1", title: "<spring:message code='warehouseLot.size1'/>", align: "center"},
                {name: "size1Value", title: "<spring:message code='warehouseLot.size1Value'/>", align: "center"},
                {name: "size2", title: "<spring:message code='warehouseLot.size2'/>", align: "center"},
                {name: "size2Value", title: "<spring:message code='warehouseLot.size2Value'/>", align: "center"},
                {name: "weightKg", title: "<spring:message code='warehouseLot.weightKg'/>", align: "center"},
                {name: "grossWeight", title: "<spring:message code='warehouseLot.grossWeight'/>", align: "center"},
                {name: "contractId",title: "contractId", align: "center"},
                {name: "used",type:"boolean",title: "used", align: "center"}
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            /* ListGrid_WarehouseLotFeature.fetchData({"tblWarehouseLot.id":record.id},function (dsResponse, data, dsRequest) {
            ListGrid_WarehouseLotFeature.setData(data);
            },{operationId:"00"});*/
        },
        canEdit: false, autoSaveEdits: false,
        canDragSelect: true,
        canSelectCells: true,
        dataArrived: function (startRow, endRow) {
            ListGrid_WarehouseLot.selection.selectCell(0, 0);
        }
    });


    var HLayout_WarehouseLot_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_WarehouseLot
        ]
    });

    var VLayout_WarehouseLot_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_WarehouseLot_Actions, HLayout_WarehouseLot_Grid
        ]
    });

