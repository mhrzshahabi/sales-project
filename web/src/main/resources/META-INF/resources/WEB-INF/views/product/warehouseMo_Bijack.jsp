<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WarehouseCadITEM = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "lotName",
            title: "<spring:message code='warehouseCadItem.lotName'/>",
            width: "20%",
            summaryFunction: "count"
        }, {
            name: "barrelNo",
            title: "<spring:message code='warehouseCadItem.barrelNo'/>",
            width: "20%",
            summaryFunction: "sum"
        }, {
            name: "weightKg",
            title: "<spring:message code='warehouseCadItem.weightKg'/>",
            width: "20%"
        }, {
            name: "issueId",
            disabled: true,
            title: "<spring:message code='warehouseCadItem.issueId'/>",
            width: "20%"
        }, {
            name: "description",
            title: "<spring:message code='warehouseCadItem.description'/>",
            width: "20%"
        }],
        fetchDataURL: "${contextPath}/api/warehouseCadItem/spec-list"
    });

    var RestDataSource_WarehouseYard_IN_WAREHOUSEMO_BIJACK = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "nameFA",
            title: "<spring:message code='warehouseCad.yard'/>",
            width: "25%",
        }, {
            name: "nameEN",
            title: "<spring:message code='warehouseCad.yard'/>",
            width: "25%"
        }, {
            name: "warehouseNo",
            title: "<spring:message code='warehouseCadItem.description'/>"
        }],
        fetchDataURL: "${contextPath}/api/warehouseYard/spec-list"
    });

    var RestDataSource_tozin_IN_WAREHOUSEMO_BIJACK = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "cardId",
            title: "<spring:message code='Tozin.cardId'/>",
            align: "center"
        }, {
            name: "carNo1",
            title: "<spring:message code='Tozin.carNo1'/>",
            align: "center"
        }, {
            name: "carNo3",
            title: "<spring:message code='Tozin.carNo3'/>",
            align: "center"
        }, {
            name: "plak",
            title: "<spring:message code='Tozin.plak'/>",
            align: "center"
        }, {
            name: "carName",
            title: "<spring:message code='Tozin.carName'/>",
            align: "center"
        }, {
            name: "containerId",
            title: "<spring:message code='Tozin.containerId'/>",
            align: "center"
        }, {
            name: "containerNo1",
            title: "<spring:message code='Tozin.containerNo1'/>",
            align: "center"
        }, {
            name: "containerNo3",
            title: "<spring:message code='Tozin.containerNo3'/>",
            align: "center"
        }, {
            name: "containerName",
            title: "<spring:message code='Tozin.containerName'/>",
            align: "center"
        }, {
            name: "vazn1",
            title: "<spring:message code='Tozin.vazn1'/>",
            align: "center"
        }, {
            name: "vazn2",
            title: "<spring:message code='Tozin.vazn2'/>",
            align: "center"
        }, {
            name: "condition",
            title: "<spring:message code='Tozin.condition'/>",
            align: "center"
        }, {
            name: "vazn",
            title: "<spring:message code='Tozin.vazn'/>",
            align: "center"
        }, {
            name: "tedad",
            title: "<spring:message code='Tozin.tedad'/>",
            align: "center"
        }, {
            name: "unitKala",
            title: "<spring:message code='Tozin.unitKala'/>",
            align: "center"
        }, {
            name: "packName",
            title: "<spring:message code='Tozin.packName'/>",
            align: "center"
        }, {
            name: "haveCode",
            title: "<spring:message code='Tozin.haveCode'/>",
            align: "center"
        }, {
            name: "date",
            title: "<spring:message code='Tozin.date'/>",
            align: "center"
        }, {
            name: "tozinId",
            title: "<spring:message code='Tozin.tozinId'/>",
            align: "center"
        }, {
            name: "tozinDate",
            title: "<spring:message code='Tozin.tozinDate'/>",
            align: "center"
        }, {
            name: "tozinTime",
            title: "<spring:message code='Tozin.tozinTime'/>",
            align: "center"
        }, {
            name: "codeKala",
            title: "<spring:message code='Tozin.codeKala'/>",
            align: "center"
        }, {
            name: "nameKala",
            title: "<spring:message code='Tozin.nameKala'/>",
            align: "center"
        }, {
            name: "sourceId",
            title: "<spring:message code='Tozin.sourceId'/>",
            align: "center"
        }, {
            name: "source",
            title: "<spring:message code='Tozin.source'/>",
            align: "center"
        }, {
            name: "targetId",
            title: "<spring:message code='Tozin.targetId'/>",
            align: "center"
        }, {
            name: "target",
            title: "<spring:message code='Tozin.target'/>",
            align: "center"
        }, {
            name: "havalehName",
            title: "<spring:message code='Tozin.havalehName'/>",
            align: "center"
        }, {
            name: "havalehFrom",
            title: "<spring:message code='Tozin.havalehFrom'/>",
            align: "center"
        }, {
            name: "havalehTo",
            title: "<spring:message code='Tozin.havalehTo'/>",
            align: "center"
        }, {
            name: "havalehDate",
            title: "<spring:message code='Tozin.havalehDate'/>",
            align: "center"
        }, {
            name: "isFinal",
            title: "<spring:message code='Tozin.isFinal'/>",
            align: "center"
        }, {
            name: "targetPlantId",
            title: "<spring:message code='Tozin.targetPlantId'/>"
        }, {
            name: "sourcePlantId",
            title: "<spring:message code='Tozin.sourcePlantId'/>"
        }, {
            name: "tozinPlantId",
            title: "<spring:message code='Tozin.tozinPlantId'/>"
        }],
        fetchDataURL: "${contextPath}/api/tozin/search-tozin"
    });

    var RestDataSource_Tozin_Other_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "target",
            operator: "iContains",
            value: "رجا"
        }, {
            fieldName: "tozinId",
            operator: "notContains",
            value: '3%'
        }]
    };


    var RestDataSource_Tozin_BandarAbbas_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [
            {fieldName: "target", operator: "iContains", value: "رجا"},
            {fieldName: "tozinId", operator: "contains", value: '3%'}
        ]
    };


    var ListGrid_WarehouseCadItem = isc.ListGrid.create({
        width: "100%",
        height: "200",
        modalEditing: true,
        canEdit: true,
        autoFetchData: false,
        canRemoveRecords: false, //temporary
        autoSaveEdits: false, //temporary
        dataSource: RestDataSource_WarehouseCadITEM,
        showGridSummary: true,
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "lotName"
        }, {
            name: "barrelNo"
        }, {
            name: "weightKg"
        }, {
            name: "issueId"
        }, {
            name: "description"
        }],
        saveEdits: function () {
            var warehouseCadItem = ListGrid_WarehouseCadItem.getEditedRecord(ListGrid_WarehouseCadItem.getEditRow());
            if (warehouseCadItem.issueId !== undefined) {
                isc.warn("can't edit. item is not in inventory.");
                return;
            }
            if (warehouseCadItem.lotName === undefined || warehouseCadItem.barrelNo === undefined || warehouseCadItem.weightKg === undefined) {
                isc.warn("<spring:message code='validator.warehousecaditem.fields.is.required'/>.");
                return;
            }
            warehouseCadItem.warehouseCadId = ListGrid_warehouseCAD.getSelectedRecord().id;

            var method = "PUT";
            if (warehouseCadItem.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/warehouseCadItem/",
                httpMethod: method,
                data: JSON.stringify(warehouseCadItem),
                callback: function (resp) {
                    if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        //fetch data automatically
                        ListGrid_WarehouseCadItem.setData([]);
                        ListGrid_WarehouseCadItem.fetchData({
                            "warehouseCadId": warehouseCadItem.warehouseCadId
                        }, function (dsResponse, data, dsRequest) {
                            ListGrid_WarehouseCadItem.setData(data);
                        });
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        },
        removeData: function (data) {
            var warehouseCadItemId = data.id;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/warehouseCadItem/" + warehouseCadItemId,
                httpMethod: "DELETE",
                callback: function (resp) {
                    if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                        ListGrid_WarehouseCadItem.setData([]);
                        ListGrid_WarehouseCadItem.fetchData({
                            "warehouseCadId": ListGrid_warehouseCAD.getSelectedRecord().id
                        }, function (dsResponse, data, dsRequest) {
                            ListGrid_WarehouseCadItem.setData(data);
                        });

                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
                    } else {
                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                    }
                }
            }));
        }
    });


    var add_bundle_button = isc.IButton.create({
        showIf: "false",
        title: "<spring:message code='warehouseCad.addBundle'/>",
        width: 150,
        click: function () {
            ListGrid_WarehouseCadItem.selectAllRecords();
            if (ListGrid_WarehouseCadItem.getSelectedRecords().length >= 1) {
                isc.warn("<spring:message code='warehouseMo.alert'/>");
                ListGrid_WarehouseCadItem.deselectAllRecords();
                return;
            }
            ListGrid_WarehouseCadItem.deselectAllRecords();

            ListGrid_WarehouseCadItem.startEditingNew();
        }
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
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "bijackNo",
            title: "<spring:message code='warehouseCad.bijackNo'/>",
            type: 'text'
        }, {
            name: "materialItemId",
            title: "<spring:message code='contractItem.material'/>",
            type: 'text',
            canEdit: false
        }, {
            name: "plant",
            title: "<spring:message code='contractItem.plant'/>",
            type: 'text',
            canEdit: false
        }, {
            name: "warehouseNo",
            title: "<spring:message code='warehouseCad.warehouseNo'/>",
            type: 'text',
            canEdit: false
        }, {
            name: "movementType",
            title: "<spring:message code='warehouseCad.movementType'/>",
            type: 'text',
            canEdit: false
        }, {
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
            optionDataSource: RestDataSource_tozin_IN_WAREHOUSEMO_BIJACK,
            optionCriteria: RestDataSource_Tozin_Other_optionCriteria,
            displayField: "tozinPlantId",
            valueField: "tozinPlantId",
            pickListWidth: "700",
            pickListHeight: "700",
            pickListProperties: {
                showFilterEditor: true,
                filterOnKeypress: false
            },
            pickListFields: [{
                name: "containerId"
            }, {
                name: "plak"
            }, {
                name: "carName"
            }, {
                name: "tozinDate"
            }, {
                name: "tozinPlantId"
            }],
            changed(form, item, value) {
                DynamicForm_warehouseCAD.setValue("plant", item.getSelectedRecord().plant);
                DynamicForm_warehouseCAD.setValue("warehouseNo", "BandarAbbas");
                DynamicForm_warehouseCAD.setValue("movementType", item.getSelectedRecord().movementType);
                DynamicForm_warehouseCAD.setValue("warehouse", item.getSelectedRecord().warehouse);
                DynamicForm_warehouseCAD.setValue("materialItemId", item.getSelectedRecord().materialItemId);
                DynamicForm_warehouseCAD.setValue("sourceLoadDate", item.getSelectedRecord().sourceLoadDate);
                DynamicForm_warehouseCAD.setValue("containerNo", item.getSelectedRecord().containerNo);
            }
        }, {
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
            optionDataSource: RestDataSource_tozin_IN_WAREHOUSEMO_BIJACK,
            optionCriteria: RestDataSource_Tozin_BandarAbbas_optionCriteria,
            displayField: "tozinPlantId",
            valueField: "tozinPlantId",
            pickListWidth: "700",
            pickListHeight: "700",
            pickListProperties: {
                showFilterEditor: true,
                filterOnKeypress: false
            },
            pickListFields: [{
                name: "containerId"
            }, {
                name: "plak"
            }, {
                name: "carName"
            }, {
                name: "tozinDate"
            }, {
                name: "tozinPlantId"
            }],
            changed(form, item, value) {
                DynamicForm_warehouseCAD.setValue("destinationUnloadDate", item.getSelectedRecord().tozinDate);
            }
        }, {
            name: "warehouseYardId",
            required: true,
            colSpan: 1,
            titleColSpan: 1,
            showHover: true,
            autoFetchData: false,
            title: "<spring:message code='warehouseCad.yard'/>",
            type: 'string',
            editorType: "SelectItem",
            optionDataSource: RestDataSource_WarehouseYard_IN_WAREHOUSEMO_BIJACK,
            displayField: "nameFA",
            valueField: "id",
            pickListWidth: "215",
            pickListHeight: "215",
            pickListProperties: {
                showFilterEditor: true
            },
            pickListFields: [{
                name: "nameFA"
            }],
            changed: function (form, item, value) {
                if (!item.getDisplayValue(value).includes("مول")) {
                    isc.warn("<spring:message code='warehouseYard.alert'/>");
                    form.getItem("warehouseYardId").setValue("");
                }
            }
        }, {
            name: "sourceLoadDate",
            title: "<spring:message code='warehouseCad.sourceLoadDate'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1,
            disabled: true
        }, {
            name: "destinationUnloadDate",
            title: "<spring:message code='warehouseCad.destinationUnloadDate'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1,
            disabled: true
        }, {
            name: "lotName",
            title: "<spring:message code='warehouseCadItem.lotName'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "sourceWeight",
            title: "<spring:message code='warehouseCad.sourceWeight'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            name: "destinationWeight",
            title: "<spring:message code='warehouseCad.destinationWeight'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        }, {
            type: "Header",
            defaultValue: "<spring:message code='warehouseCad.addBijackItem'/>"
        }]
    });


    var IButton_warehouseCAD_Save = isc.IButtonSave.create({
        showIf: "false",
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_warehouseCAD.validate();
            if (DynamicForm_warehouseCAD.hasErrors())
                return;

            DynamicForm_warehouseCAD.setValue("materialItemId", ListGrid_warehouseCAD.getSelectedRecord().materialItemId);
            var data_WarehouseCad = DynamicForm_warehouseCAD.getValues();
            var warehouseCadItems = [];

            ListGrid_WarehouseCadItem.selectAllRecords();
            if (ListGrid_WarehouseCadItem.data.length === 0) {
                isc.warn("<spring:message code='bijack.noitems'/>");
                return;
            }

            ListGrid_WarehouseCadItem.getSelectedRecords().forEach(function (element) {
                warehouseCadItems.add(element);
            });

            ListGrid_WarehouseCadItem.getAllEditRows().forEach(function (element) {
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
                    if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        Window_Bijack.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });

    ListGrid_WarehouseCadItem.setData([]);
    ListGrid_WarehouseCadItem.fetchData({
            "warehouseCadId": ListGrid_warehouseCAD.getSelectedRecord().id
        },
        function (dsResponse, data, dsRequest) {
            ListGrid_WarehouseCadItem.setData(data);
        });

    DynamicForm_warehouseCAD.clearValues();
    DynamicForm_warehouseCAD.editRecord(ListGrid_warehouseCAD.getSelectedRecord());

    DynamicForm_warehouseCAD.setValue("materialItemId", ListGrid_warehouseCAD.getSelectedRecord().materialItem.gdsName);
    DynamicForm_warehouseCAD.setValue("plant", ListGrid_warehouseCAD.getSelectedRecord().plant);
    DynamicForm_warehouseCAD.setValue("warehouseNo", "BandarAbbas");
    DynamicForm_warehouseCAD.setValue("movementType", ListGrid_warehouseCAD.getSelectedRecord().movementType);
    DynamicForm_warehouseCAD.setValue("sourceTozinPlantId", ListGrid_warehouseCAD.getSelectedRecord().sourceTozinPlantId);
    DynamicForm_warehouseCAD.setValue("sourceLoadDate", ListGrid_warehouseCAD.getSelectedRecord().sourceLoadDate);
    DynamicForm_warehouseCAD.setValue("containerNo", ListGrid_warehouseCAD.getSelectedRecord().containerNo);


    isc.VLayout.create({
        width: 810,
        height: 800,
        members: [
            DynamicForm_warehouseCAD,
            add_bundle_button,
            ListGrid_WarehouseCadItem,
            isc.HLayout.create({
                width: "100%",
                members: [
                    IButton_warehouseCAD_Save,
                    isc.Label.create({
                        width: 5,
                    }),
                    /*isc.IButtonCancel.create({
                        ID: "warehouseCADEditExitIButton",
                        title: "<spring:message code='global.cancel'/>",
                        width: 100,
                        icon: "pieces/16/icon_delete.png",
                        orientation: "vertical",
                        click: function() {
                            Window_Bijack.close();
                        }
                    })*/
                ]
            })
        ]
    });