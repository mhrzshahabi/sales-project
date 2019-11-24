<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

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
                    name: "materialItemId",
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
                        {name: "containerId"},
                        {name: "plak"},
                        {name: "carName"},
                        {name: "tozinDate"},
                        {name: "tozinPlantId"}
                    ],
                    changed(form, item, value) {
                        DynamicForm_warehouseCAD.setValue("plant", item.getSelectedRecord().source);
                        DynamicForm_warehouseCAD.setValue("warehouseNo", "BandarAbbas");
                        DynamicForm_warehouseCAD.setValue("movementType", item.getSelectedRecord().carName);
                        DynamicForm_warehouseCAD.setValue("warehouse", item.getSelectedRecord().carName);
                        DynamicForm_warehouseCAD.setValue("materialItemId", item.getSelectedRecord().codeKala);
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
                        {name: "containerId"},
                        {name: "plak"},
                        {name: "carName"},
                        {name: "tozinDate"},
                        {name: "tozinPlantId"}
                    ],
                    changed(form, item, value) {
                        DynamicForm_warehouseCAD.setValue("destinationUnloadDate", item.getSelectedRecord().tozinDate);
                    }
                },
                {
                    name: "warehouseYardId",
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
                    titleColSpan: 1,
                    disabled: true
                },
                {
                    name: "destinationUnloadDate",
                    title: "<spring:message code='warehouseCad.destinationUnloadDate'/>",
                    width: 250,
                    colSpan: 1,
                    titleColSpan: 1,
                    disabled: true
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

    var IButton_warehouseCAD_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_warehouseCAD.validate();
            if (DynamicForm_warehouseCAD.hasErrors())
                return;

            DynamicForm_warehouseCAD.setValue("materialItemId", ListGrid_Tozin.getSelectedRecord().codeKala);
            var data_WarehouseCad = DynamicForm_warehouseCAD.getValues();
            var warehouseCadItems = [];

            ListGrid_WarehouseCadItem.selectAllRecords();
            if (ListGrid_WarehouseCadItem.data.length == 0 ) {
               isc.warn("no items");
               return;
            }

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
                            Window_Bijack.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    DynamicForm_warehouseCAD.setValue("materialItemId", ListGrid_Tozin.getSelectedRecord().nameKala);
    DynamicForm_warehouseCAD.setValue("plant",ListGrid_Tozin.getSelectedRecord().source);
    DynamicForm_warehouseCAD.setValue("warehouseNo", "BandarAbbas");
    DynamicForm_warehouseCAD.setValue("movementType",DynamicForm_DailyReport_Tozin4.getValues().type);
    DynamicForm_warehouseCAD.setValue("sourceTozinPlantId",ListGrid_Tozin.getSelectedRecord().tozinPlantId);
    DynamicForm_warehouseCAD.setValue("sourceLoadDate",ListGrid_Tozin.getSelectedRecord().tozinDate);
    DynamicForm_warehouseCAD.setValue("containerNo",ListGrid_Tozin.getSelectedRecord().containerId);

    isc.VLayout.create({
        width: 810,
        height: 800,
        members: [
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
                                    Window_Bijack.close();
                                }
                            })
                        ]
                })
       ]
    });