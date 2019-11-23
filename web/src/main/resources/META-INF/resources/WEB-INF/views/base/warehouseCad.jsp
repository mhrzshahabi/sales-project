<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WarehouseCad = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "bijackNo",
                    title: "<spring:message code='warehouseCad.bijackNo'/>",
                    type: 'text'
                },
                {
                    name: "materialItem.gdsName",
                    title: "<spring:message code='contractItem.material'/>",
                    type: 'text'
                },
                {
                    name: "plant",
                    title: "<spring:message code='contractItem.plant'/>",
                    type: 'text'
                },
                {
                    name: "warehouseNo",
                    title: "<spring:message code='warehouseCad.warehouseNo'/>",
                    type: 'text'
                },
                {
                    name: "movementType",
                    title: "<spring:message code='warehouseCad.movementType'/>",
                    type: 'text'
                },
                {
                    name: "sourceTozinPlantId"
                },
                {
                    name: "destinationTozinPlantId",
                },
                {
                    name: "yard",
                    title: "<spring:message code='warehouseCad.yard'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "sourceLoadDate",
                    title: "<spring:message code='warehouseCad.sourceLoadDate'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "destinationUnloadDate",
                    title: "<spring:message code='warehouseCad.destinationUnloadDate'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "rahahanPolompNo",
                    title: "<spring:message code='warehouseCad.rahahanPolompNo'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "herasatPolompNo",
                    title: "<spring:message code='warehouseCad.herasatPolompNo'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "containerNo",
                    title: "<spring:message code='warehouseCad.containerNo'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {name: "sourceBundleSum", title: "<spring:message code='warehouseCad.sourceBundleSum'/>", width: 250,colSpan: 1,titleColSpan: 1},
                {name: "destinationBundleSum", title: "<spring:message code='warehouseCad.destinationBundleSum'/>", width: 250,colSpan: 1,titleColSpan: 1},
                {name: "sourceSheetSum", title: "<spring:message code='warehouseCad.sourceSheetSum'/>", width: 250,colSpan: 1,titleColSpan: 1},
                {name: "destinationSheetSum", title: "<spring:message code='warehouseCad.destinationSheetSum'/>", width: 250,colSpan: 1,titleColSpan: 1}
            ],
        fetchDataURL: "${contextPath}/api/warehouseCad/spec-list"
    });

    var RestDataSource_WarehouseCadITEM = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "bundleSerial",title: "<spring:message code='warehouseCadItem.bundleSerial'/>", width: "25%", summaryFunction:"count"},
                {name: "sheetNo", title: "<spring:message code='warehouseCadItem.sheetNo'/>", width: "25%", summaryFunction:"sum"},
                {name: "weightKg",title: "<spring:message code='warehouseCadItem.weightKg'/>", width: "25%"},
                {name: "description", title: "<spring:message code='warehouseCadItem.description'/>", width: "25%"}
            ],
        fetchDataURL: "${contextPath}/api/warehouseCadItem/spec-list"
    });

    var RestDataSource_WarehouseYard = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "nameFA",title: "<spring:message code='warehouseCad.yard'/>", width: "25%", },
                {name: "nameEN", title: "<spring:message code='warehouseCad.yard'/>", width: "25%"},
                {name: "warehouseNo", title: "<spring:message code='warehouseCadItem.description'/>"}
            ],
        fetchDataURL: "${contextPath}/api/warehouseYard/spec-list"
    });

    var RestDataSource_tozin = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "sourcePlantId"}
            ],
        fetchDataURL: "${contextPath}/api/tozin/search-tozin"
    });

    var RestDataSource_Tozin_Other_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [
            {fieldName: "targetPlantId", operator: "equals", value: 3},
            {fieldName: "tozinId", operator: "notContains", value: '3%'}
        ]
    };

    var RestDataSource_Tozin_BandarAbbas_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [
            {fieldName: "targetPlantId", operator: "equals", value: 3},
            {fieldName: "tozinId", operator: "contains", value: '3%'}
        ]
    };

    isc.ViewLoader.create({
        ID: "BijackViewLoader",
        width: 830,
        height: 660,
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>"
    });

    var Window_Bijack = isc.Window.create({
        title: "<spring:message code='bijack'/> ",
        width: 830,
        height: 660,
        autoSize:true,
        autoCenter: true,
        isModal: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                BijackViewLoader
            ]
    });

    function ListGrid_warehouseCAD_refresh() {
        ListGrid_warehouseCAD.invalidateCache();
    }

    function ListGrid_warehouseCAD_edit() {
        var record = ListGrid_warehouseCAD.getSelectedRecord();

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
            ListGrid_WarehouseCadItem.setData([]);
            ListGrid_WarehouseCadItem.fetchData({"warehouseCadId": ListGrid_warehouseCAD.getSelectedRecord().id}, function (dsResponse, data, dsRequest) {
                ListGrid_WarehouseCadItem.setData(data);
            });

            DynamicForm_warehouseCAD.clearValues();
            DynamicForm_warehouseCAD.editRecord(record);
            DynamicForm_warehouseCAD.setValue("edit","edit");

             if (record.materialItemId === 9 || record.materialItemId === 10 ||  record.materialItemId === 11 ||
                record.materialItemId === 114 || record.materialItemId === 129 || record.materialItemId === 86 ||
                record.materialItemId === 90 || record.materialItemId === 95 ) {

                        BijackViewLoader.setViewURL("warehouseCad/showWarehouseCadForm");
                        Window_Bijack.show();
                    }
                    if (record.materialItemId === 97 || record.materialItemId === 100) {
                        BijackViewLoader.setViewURL("warehouseCad/showWarehouseMoForm");
                        Window_Bijack.show();
                    }
                    if (record.materialItemId === 8 ) {
                        BijackViewLoader.setViewURL("warehouseCad/showWarehouseConcForm");
                        Window_Bijack.show();
                    }
        }
    }

    function ListGrid_warehouseCAD_remove() {

        var record = ListGrid_warehouseCAD.getSelectedRecord();

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
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var warehouseCADId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/warehouseCad/" + warehouseCADId,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_warehouseCAD_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                }
                            })
                        );
                    }
                }
            });
        }
    }

    var Menu_ListGrid_warehouseCAD = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_warehouseCAD_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_warehouseCAD_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_warehouseCAD_remove();
                }
            },
            {
                title: "<spring:message code='global.form.print'/>", icon: "icon/word.png", click: function () {
                    var record = ListGrid_warehouseCAD.getSelectedRecord();
                    "<spring:url value="/warehouseCad/print/" var="printUrl"/>"
                    window.open('${printUrl}'+record.id);
                }
            }
        ]
    });

    var ListGrid_WarehouseCadItem = isc.ListGrid.create({
        width: "100%",
        height: "200",
        modalEditing: true,
        canEdit: true,
        autoFetchData: false,
        canRemoveRecords: true,
        autoSaveEdits: true,
        dataSource: RestDataSource_WarehouseCadITEM,
        showGridSummary: true,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "bundleSerial"},
                {name: "sheetNo"},
                {name: "weightKg"},
                {name: "description"}
            ],
        saveEdits: function () {
                var warehouseCadItem = ListGrid_WarehouseCadItem.getEditedRecord(ListGrid_WarehouseCadItem.getEditRow());
                if(warehouseCadItem.bundleSerial === undefined || warehouseCadItem.sheetNo === undefined || warehouseCadItem.weightKg === undefined){
                    isc.warn("<spring:message code='validator.warehousecaditem.fields.is.required'/>.");
                    return;
                }
                if(DynamicForm_warehouseCAD.getValues().edit === undefined)
                    return;
                warehouseCadItem.warehouseCadId = ListGrid_warehouseCAD.getSelectedRecord().id;

                var method = "PUT";
                if (warehouseCadItem.id == null)
                    method = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: "${contextPath}/api/warehouseCadItem/",
                        httpMethod: method,
                        data: JSON.stringify(warehouseCadItem),
                        callback: function (resp) {
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>.");
                                //fetch data automatically
                                ListGrid_WarehouseCadItem.setData([]);
                                ListGrid_WarehouseCadItem.fetchData({"warehouseCadId": warehouseCadItem.warehouseCadId }, function (dsResponse, data, dsRequest) {
                                    ListGrid_WarehouseCadItem.setData(data);
                                });
                            } else
                                isc.say(RpcResponse_o.data);
                        }
                    })
                );
        },
        removeData: function (data) {
            var warehouseCadItemId = data.id;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseCadItem/" + warehouseCadItemId,
                    httpMethod: "DELETE",
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {

                            ListGrid_WarehouseCadItem.setData([]);
                            ListGrid_WarehouseCadItem.fetchData({"warehouseCadId": ListGrid_warehouseCAD.getSelectedRecord().id}, function (dsResponse, data, dsRequest) {
                                ListGrid_WarehouseCadItem.setData(data);
                            });

                            isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                        } else {
                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                        }
                    }
                })
            );
        }
    });

    var add_bundle_button = isc.IButton.create({
        title: "<spring:message code='warehouseCad.addBundle'/>",
        width: 150,
        click: "ListGrid_WarehouseCadItem.startEditingNew()"
    });

    var DynamicForm_warehouseCAD = isc.DynamicForm.create({
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
        numCols: 4,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "bijackNo",
                    title: "<spring:message code='warehouseCad.bijackNo'/>",
                    type: 'text'
                },
                {
                    name: "material",
                    title: "<spring:message code='contractItem.material'/>",
                    type: 'text'
                },
                {
                    name: "plant",
                    title: "<spring:message code='contractItem.plant'/>",
                    type: 'text'
                },
                {
                    name: "warehouseNo",
                    title: "<spring:message code='warehouseCad.warehouseNo'/>",
                    type: 'text'
                },
                {
                    name: "movementType",
                    title: "<spring:message code='warehouseCad.movementType'/>",
                    type: 'text'
                },
                {
                    name: "sourceTozinPlantId",
                    required: true,
                    colSpan: 3,
                    titleColSpan: 1,
                    showHover: true,
                    autoFetchData: false,
                    title: "<spring:message code='warehouseCad.tozinOther'/>",
                    type: 'string',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_tozin,
                    optionCriteria: RestDataSource_Tozin_Other_optionCriteria,
                    displayField: "tozinPlantId",
                    valueField: "tozinPlantId",
                    pickListWidth: "700",
                    pickListHeight: "700",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "carName"},
                        {name: "tozinDate"},
                        {name: "tozinPlantId"}
                    ],
                    changed(form, item, value) {
                        DynamicForm_warehouseCAD.setValue("plant", item.getSelectedRecord().source);
                        DynamicForm_warehouseCAD.setValue("warehouseNo", "بندرعباس");
                        DynamicForm_warehouseCAD.setValue("movementType", item.getSelectedRecord().carName);
                        DynamicForm_warehouseCAD.setValue("warehouse", item.getSelectedRecord().carName);
                        DynamicForm_warehouseCAD.setValue("material", item.getSelectedRecord().nameKala);
                        DynamicForm_warehouseCAD.setValue("sourceLoadDate", item.getSelectedRecord().tozinDate);
                        DynamicForm_warehouseCAD.setValue("containerNo", item.getSelectedRecord().containerId);
                    }
                },
                {
                    name: "destinationTozinPlantId",
                    required: true,
                    colSpan: 3,
                    titleColSpan: 1,
                    showHover: true,
                    autoFetchData: false,
                    title: "<spring:message code='warehouseCad.tozinBandarAbbas'/>",
                    type: 'string',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_tozin,
                    optionCriteria: RestDataSource_Tozin_BandarAbbas_optionCriteria,
                    displayField: "tozinPlantId",
                    valueField: "tozinPlantId",
                    pickListWidth: "700",
                    pickListHeight: "700",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "carName"},
                        {name: "tozinDate"},
                        {name: "tozinPlantId"}
                    ],
                    changed(form, item, value) {
                        DynamicForm_warehouseCAD.setValue("destinationUnloadDate", item.getSelectedRecord().tozinDate);
                    }
                },
                {
                    name: "yard",
                    required: true,
                    colSpan: 1,
                    titleColSpan: 1,
                    showHover: true,
                    autoFetchData: false,
                    title: "<spring:message code='warehouseCad.yard'/>",
                    type: 'string',
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_WarehouseYard,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "215",
                    pickListHeight: "215",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA"}
                    ]
                },
                {
                    name: "sourceLoadDate",
                    title: "<spring:message code='warehouseCad.sourceLoadDate'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "destinationUnloadDate",
                    title: "<spring:message code='warehouseCad.destinationUnloadDate'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "rahahanPolompNo",
                    title: "<spring:message code='warehouseCad.rahahanPolompNo'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "herasatPolompNo",
                    title: "<spring:message code='warehouseCad.herasatPolompNo'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "containerNo",
                    title: "<spring:message code='warehouseCad.containerNo'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {name: "sourceBundleSum", title: "<spring:message code='warehouseCad.sourceBundleSum'/>", width: 250,colSpan: 1,titleColSpan: 1},
                {name: "destinationBundleSum", title: "<spring:message code='warehouseCad.destinationBundleSum'/>", width: 250,colSpan: 1,titleColSpan: 1},
                {name: "sourceSheetSum", title: "<spring:message code='warehouseCad.sourceSheetSum'/>", width: 250,colSpan: 1,titleColSpan: 1},
                {name: "destinationSheetSum", title: "<spring:message code='warehouseCad.destinationSheetSum'/>", width: 250,colSpan: 1,titleColSpan: 1},
                 {
                    type: "Header",
                    defaultValue: "--------------------------------- &#8595;  قسمت وارد کردن آیتم های بیجک  &#8595;  --------------------------------"
                }
            ]
    });

    var ToolStripButton_warehouseCAD_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_warehouseCAD_refresh();
        }
    });

    var ToolStripButton_warehouseCAD_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_warehouseCAD_edit();
        }
    });

    var ToolStripButton_warehouseCAD_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_warehouseCAD_remove();
        }
    });

    var ToolStrip_Actions_warehouseCAD = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_warehouseCAD_Refresh,
                ToolStripButton_warehouseCAD_Edit,
                ToolStripButton_warehouseCAD_Remove
            ]
    });

    var HLayout_warehouseCAD_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_warehouseCAD
            ]
    });

    var IButton_warehouseCAD_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_warehouseCAD.validate();
            if (DynamicForm_warehouseCAD.hasErrors())
                return;

            var data_WarehouseCad = DynamicForm_warehouseCAD.getValues();
            var warehouseCadItems = [];

            ListGrid_WarehouseCadItem.selectAllRecords();

            ListGrid_WarehouseCadItem.getSelectedRecords().forEach(function(element) {
                warehouseCadItems.add(element);
            });

            ListGrid_WarehouseCadItem.getAllEditRows().forEach(function(element) {
                warehouseCadItems.add(ListGrid_WarehouseCadItem.getEditedRecord(element));
            });

            ListGrid_WarehouseCadItem.deselectAllRecords();

            data_WarehouseCad.warehouseCadItems = warehouseCadItems;
            var method = "PUT";
            if (data_WarehouseCad.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseCad/",
                    httpMethod: method,
                    data: JSON.stringify(data_WarehouseCad),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_warehouseCAD_refresh();
                            Window_warehouseCAD.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var Window_warehouseCAD = isc.Window.create({
        title: "<spring:message code='bijack'/> ",
        width: 810,
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
                DynamicForm_warehouseCAD,
                add_bundle_button,
                ListGrid_WarehouseCadItem,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_warehouseCAD_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                ID: "warehouseCADEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_warehouseCAD.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_warehouseCAD = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WarehouseCad,
        contextMenu: Menu_ListGrid_warehouseCAD,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "bijackNo", width: "16.66%"},
                {name: "warehouseNo" , width: "16.66%"},
                {name: "materialItem.gdsName", width: "16.66%"},
                {name: "movementType", width: "16.66%"},
                {name: "plant", width: "16.66%"},
                {name: "sourceLoadDate", width: "16.66%"},
                {name: "destinationUnloadDate",width: "16.66%"}
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        },
        dataArrived: function (startRow, endRow) {
        }
    });

    var HLayout_warehouseCAD_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_warehouseCAD
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_warehouseCAD_Actions, HLayout_warehouseCAD_Grid
        ]
    });