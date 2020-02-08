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
            width: "25%",
            summaryFunction: "count"
        }, {
            name: "barrelNo",
            title: "<spring:message code='warehouseCadItem.barrelNo'/>",
            width: "25%",
            summaryFunction: "sum"
        }, {
            name: "weightKg",
            title: "<spring:message code='warehouseCadItem.weightKg'/>",
            width: "25%"
        }, {
            name: "description",
            title: "<spring:message code='warehouseCadItem.description'/>",
            width: "25%"
        }],
        fetchDataURL: "${contextPath}/api/warehouseCadItem/spec-list"
    });

    var RestDataSource_WarehouseYard = isc.MyRestDataSource.create({
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
            "operator": "iContains",
            "value": "رجا"
        }, {
            fieldName: "tozinId",
            operator: "notContains",
            value: '3%'
        }, {
            fieldName: "codeKala",
            operator: "equals",
            value: ListGrid_Tozin.getSelectedRecord().codeKala
        }]
    };

    var RestDataSource_Tozin_BandarAbbas_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "target",
            "operator": "iContains",
            "value": "رجا"
        }, {
            fieldName: "tozinId",
            operator: "contains",
            value: '3%'
        }, {
            fieldName: "codeKala",
            operator: "equals",
            value: ListGrid_Tozin.getSelectedRecord().codeKala
        }]
    };


    var ListGrid_WarehouseCadItem = isc.ListGrid.create({
        width: "100%",
        height: "80%",
        canEdit: true,
        // autoFetchData: true,
        editEvent: "click",
        editByCell: true,
        modalEditing: true,
        canRemoveRecords: true,
        autoSaveEdits: false,
        deferRemoval: false,
        saveLocally: true,
        showGridSummary: true,
        fields: [{
            name: "lotName",
            title: "<spring:message code='warehouseCadItem.lotName'/>"
        }, {
            name: "barrelNo",
            title: "<spring:message code='warehouseCadItem.barrelNo'/>"
        }, {
            name: "weightKg",
            title: "<spring:message code='warehouseCadItem.weightKg'/>"
        }, {
            name: "description",
            title: "<spring:message code='warehouseCadItem.description'/>"
        }],
        removeData: function (record) {

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

                if (index === 0){
                ListGrid_WarehouseCadItem.data.remove(record);
                alert(JSON.stringify(ListGrid_WarehouseCadItem.data));
                }

                }
            });
        }
    });


    var add_bundle_button = isc.IButton.create({
        title: "<spring:message code='warehouseCad.addBundle'/>",
        width: 150,
        click: function () {
            ListGrid_WarehouseCadItem.deselectAllRecords();
            ListGrid_WarehouseCadItem.startEditingNew();
        }
    });

    var DynamicForm_warehouseCAD = isc.DynamicForm.create({
        placement: "fillScreen",
        setMethod: 'POST',
        align: "center",
        layoutAlign: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "110",
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
            type: 'text',
            required: true
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
            canEdit: false,
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
                DynamicForm_warehouseCAD.setValue("plant", item.getSelectedRecord().source);
                DynamicForm_warehouseCAD.setValue("warehouseNo", "BandarAbbas");
                DynamicForm_warehouseCAD.setValue("movementType", item.getSelectedRecord().carName);
                DynamicForm_warehouseCAD.setValue("warehouse", item.getSelectedRecord().carName);
                DynamicForm_warehouseCAD.setValue("materialItemId", item.getSelectedRecord().nameKala);
                DynamicForm_warehouseCAD.setValue("sourceLoadDate", item.getSelectedRecord().tozinDate);
                DynamicForm_warehouseCAD.setValue("containerNo", item.getSelectedRecord().containerId);
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
            addUnknownValues: false,
            useClientFiltering: false,
            pickListWidth: 650,
            pickListHeight: 350,
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
            optionDataSource: RestDataSource_WarehouseYard,
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
        },


 {
            name: "rahahanPolompNo",
            title: "<spring:message code='warehouseCad.rahahanPolompNo'/>",
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        },

        {
            name: "containerNo",
            title: "<spring:message code='warehouseCad.containerNo'/>", //شماره کانتینر
            width: 250,
            colSpan: 1,
            titleColSpan: 1,
            canEdit: false
        },

        {
            name: "herasatPolompNo",
            title: "<spring:message code='warehouseCad.herasatPolompNo'/>", //شماره پلمپ حراست
            width: 250,
            colSpan: 1,
            titleColSpan: 1
        },


        {
          align: "center",
          layoutAlign: "center",
          type: "Header",
          defaultValue: "<spring:message code='bijack.title.destination.center'/>"
        },

        {
        type: "staticText",
        title: "<b><spring:message code='bijack.title.destination.right'/></b>",
        wrapTitle: true,
        width: 90 ,
        },

        {

        type: "staticText",
        title: "<b><spring:message code='bijack.title.destination.left'/></b>",
        wrapTitle: false,
        width: 90 ,
        },

       {
            name: "sourceLoadDate",
            title: "<spring:message code='warehouseCad.sourceLoadDate'/>", //=تاریخ بارگیری در مبدا
            width: 250,
            colSpan: 1,
            titleColSpan: 1,
            canEdit: false
        },

        {
            name: "destinationUnloadDate",
            title: "<spring:message code='warehouseCad.destinationUnloadDate'/>", //تاریخ تخلیه در مقصد
            width: 250,
            colSpan: 1,
            titleColSpan: 1,
            canEdit: false
        },
        {
            name: "sourceWeight",
            title: "<spring:message code='warehouseCad.sourceWeight'/>", //وزن مبدا
            width: 250,
            colSpan: 1,
            titleColSpan: 1,
            canEdit: false
        }, {
            name: "destinationWeight",
            title: "<spring:message code='warehouseCad.destinationWeight'/>", //وزن مقصد
            width: 250,
            colSpan: 1,
            titleColSpan: 1,
            canEdit: false
        },
            {
                align: "center",
                layoutAlign: "center",
                type: "Header",
                defaultValue: "<spring:message code='warehouseCad.addBijackItem'/>"
            }

        ]
    });


    var IButton_warehouseCAD_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
             if(DynamicForm_warehouseCAD.getValue("destinationTozinPlantId")==undefined){
                    isc.warn("<spring:message code='warehouseCad.tozinBandarAbbasErrors'/>");
                    DynamicForm_warehouseCAD.validate()
                    return;
                }
            DynamicForm_warehouseCAD.validate();
            if (DynamicForm_warehouseCAD.hasErrors())
                return;

            DynamicForm_warehouseCAD.setValue("materialItemId", ListGrid_Tozin.getSelectedRecord().codeKala);
            var data_WarehouseCad = DynamicForm_warehouseCAD.getValues();
            var warehouseCadItems = [];

            ListGrid_WarehouseCadItem.selectAllRecords();

            var notComplete = 0;
            ListGrid_WarehouseCadItem.getAllEditRows().forEach(function (element) {
                var record = ListGrid_WarehouseCadItem.getEditedRecord(JSON.parse(JSON.stringify(element)));
                if (record.lotName !== undefined && record.barrelNo !== undefined && record.weightKg !== undefined &&
                    record.lotName !== null && record.barrelNo !== null && record.weightKg !== null) {
                warehouseCadItems.add(record);
                }
                else {
                    notComplete++;
                }
                ListGrid_WarehouseCadItem.deselectRecord(ListGrid_WarehouseCadItem.getRecord(element));
            });

            ListGrid_WarehouseCadItem.getSelectedRecords().forEach(function (element) {
                warehouseCadItems.add(JSON.parse(JSON.stringify(element)));
            });

            if (notComplete != 0) {
                isc.warn("<spring:message code='validator.warehousecaditem.fields.is.required'/>");
                return;
            }

            if (warehouseCadItems.length == 0) {
                isc.warn("<spring:message code='bijack.noitems'/>");
                return;
            }
            if (warehouseCadItems.length > 1){
                isc.warn("<spring:message code='bijack.moreThanOne'/>");
                return;
            }

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
                        ListGrid_Tozin_refresh();
                        Window_Bijack.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });

    <%--function requiredFields(record){--%>
        <%--if(record.lotName !== undefined && record.barrelNo !== undefined && record.weightKg !== undefined){--%>
            <%--return record;--%>
        <%--}else {--%>
            <%--isc.warn("<spring:message code='validator.warehousecaditem.fields.is.required'/>");--%>
        <%--}--%>
    <%--}--%>


    ListGrid_WarehouseCadItem.setData([]);
    DynamicForm_warehouseCAD.clearValues();
    DynamicForm_warehouseCAD.setValue("materialItemId", ListGrid_Tozin.getSelectedRecord().nameKala);
    DynamicForm_warehouseCAD.setValue("plant", ListGrid_Tozin.getSelectedRecord().source);
    DynamicForm_warehouseCAD.setValue("warehouseNo", "BandarAbbas");
    DynamicForm_warehouseCAD.setValue("movementType", DynamicForm_DailyReport_Tozin4.getValues().type);
    DynamicForm_warehouseCAD.setValue("sourceTozinPlantId", ListGrid_Tozin.getSelectedRecord().tozinPlantId);
    DynamicForm_warehouseCAD.setValue("sourceLoadDate", ListGrid_Tozin.getSelectedRecord().tozinDate);
    DynamicForm_warehouseCAD.setValue("containerNo", ListGrid_Tozin.getSelectedRecord().containerId);
    DynamicForm_warehouseCAD.setValue("sourceWeight", ListGrid_Tozin.getSelectedRecord().vazn);


    isc.VLayout.create({
        width: 810,
        height: "100%",
        padding: 10,
        margin: 10,
        members: [
            DynamicForm_warehouseCAD,
            add_bundle_button,
            ListGrid_WarehouseCadItem,
            isc.HLayout.create({
                     width: "100%",
                align: "center",
                margin: 10,
                padding: 20,
                members: [
                    IButton_warehouseCAD_Save,
                    isc.Label.create({
                        width: 5,
                    }),
                    isc.IButtonCancel.create({
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

