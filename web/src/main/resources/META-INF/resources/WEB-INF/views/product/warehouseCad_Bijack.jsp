<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WarehouseYard_IN_WAREHOUSECAD_BIJACK = isc.MyRestDataSource.create({
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

    var RestDataSource_WarehouseCadITEM_IN_WAREHOUSECAD_BIJACK = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "bundleSerial",
            title: "<spring:message code='warehouseCadItem.bundleSerial'/>",
            width: "20%",
            summaryFunction: "count"
        }, {
            name: "sheetNo",
            title: "<spring:message code='warehouseCadItem.sheetNo'/>",
            width: "20%",
            summaryFunction: "sum"
        }, {
            name: "weightKg",
            title: "<spring:message code='warehouseCadItem.weightKg'/>",
            width: "20%",
            summaryFunction: "sum"
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

    var RestDataSource_tozin_IN_WAREHOUSECAD_BIJACK = isc.MyRestDataSource.create({
        fields: [
            {
                name: "source",
                title: "<spring:message code='Tozin.source'/>",
                align: "center"
            },
            {
                name: "tozinId",
                title: "<spring:message code='Tozin.tozinPlantId'/>",
                align: "center"
            },
            {
                name: "nameKala",
                title: "<spring:message code='Tozin.nameKala'/>",
                align: "center"
            },
            {
                name: "codeKala",
                title: "<spring:message code='Tozin.codeKala'/>",
                align: "center"
            },
            {
                name: "target",
                title: "<spring:message code='Tozin.target'/>",
                align: "center"
            },
            {
                name: "cardId",
                title: "<spring:message code='Tozin.cardId'/>",
                align: "center"
            },
            {
                name: "plak",
                title: "<spring:message code='Tozin.plak'/>",
                align: "center"
            },
            {
                name: "carName",
                title: "<spring:message code='Tozin.carName'/>",
                align: "center"
            },
            {
                name: "containerId",
                title: "<spring:message code='Tozin.containerId'/>",
                align: "center"
            },
            {
                name: "containerNo1",
                title: "<spring:message code='Tozin.containerNo1'/>",
                align: "center"
            },
            {
                name: "containerNo3",
                title: "<spring:message code='Tozin.containerNo3'/>",
                align: "center"
            },
            {
                name: "containerName",
                title: "<spring:message code='Tozin.containerName'/>",
                align: "center"
            },
            {
                name: "vazn1",
                title: "<spring:message code='Tozin.vazn1'/>",
                align: "center"
            },
            {
                name: "vazn2",
                title: "<spring:message code='Tozin.vazn2'/>",
                align: "center"
            },
            {
                name: "condition",
                title: "<spring:message code='Tozin.condition'/>",
                align: "center"
            },
            {
                name: "vazn",
                title: "<spring:message code='Tozin.vazn'/>",
                align: "center"
            },
            {
                name: "tedad",
                title: "<spring:message code='Tozin.tedad'/>",
                align: "center"
            },
            {
                name: "unitKala",
                title: "<spring:message code='Tozin.unitKala'/>",
                align: "center"
            },
            {
                name: "packName",
                title: "<spring:message code='Tozin.packName'/>",
                align: "center"
            },
            {
                name: "haveCode",
                title: "<spring:message code='Tozin.haveCode'/>",
                align: "center"
            },
            {
                name: "date",
                title: "<spring:message code='Tozin.date'/>",
                align: "center"
            },
            {
                name: "tozinDate",
                title: "<spring:message code='Tozin.tozinDate'/>",
                align: "center"
            },
            {
                name: "tozinTime",
                title: "<spring:message code='Tozin.tozinTime'/>",
                align: "center"
            },
            {
                name: "sourceId",
                title: "<spring:message code='Tozin.sourceId'/>",
                align: "center"
            },
            {
                name: "targetId",
                title: "<spring:message code='Tozin.targetId'/>",
                align: "center"
            },
            {
                name: "havalehName",
                title: "<spring:message code='Tozin.havalehName'/>",
                align: "center"
            },
            {
                name: "havalehFrom",
                title: "<spring:message code='Tozin.havalehFrom'/>",
                align: "center"
            },
            {
                name: "havalehTo",
                title: "<spring:message code='Tozin.havalehTo'/>",
                align: "center"
            },
            {
                name: "havalehDate",
                title: "<spring:message code='Tozin.havalehDate'/>",
                align: "center"
            },
            {
                name: "carNo1",
                title: "<spring:message code='Tozin.carNo1'/>",
                align: "center"
            },
            {
                name: "carNo3",
                title: "<spring:message code='Tozin.carNo3'/>",
                align: "center"
            },
            {
                name: "isFinal",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            },
            {
                name: "ctrlDescOut",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            },
            {
                name: "tznSharh2",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            }, {
                name: "strSharh2",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            }, {
                name: "tznSharh1",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            }
        ],
        fetchDataURL: "${contextPath}/api/tozin/search-tozin"
    });

    var RestDataSource_Tozin_BandarAbbas_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "target",
            operator: "iContains",
            value: "رجا"
        }, {
            fieldName: "tozinId",
            operator: "contains",
            value: '3-'
        }, {
            fieldName: "codeKala",
            operator: "equals",
            value: ListGrid_warehouseCAD.getSelectedRecord().materialItem.gdsCode
        }]
    };

    var ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK = isc.ListGrid.create({
        showFilterEditor: true,
        width: "100%",
        height: "80%",
        modalEditing: true,
        canEdit: true,
        editEvent: "click",
        canRemoveRecords: true,
        autoSaveEdits: true,
        deferRemoval: false,
        showGridSummary: true,
        dataSource: RestDataSource_WarehouseCadITEM_IN_WAREHOUSECAD_BIJACK,
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "bundleSerial"
        }, {
            name: "sheetNo"
        }, {
            name: "weightKg"
        }, {
            name: "issueId"
        }, {
            name: "description"
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
                    if (index == 0) {
                        if (record.issueId != undefined) {
                            isc.warn("can't remove. item is not in inventory.");
                            return;
                        }
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                            actionURL: "${contextPath}/api/warehouseCadItem/" + record.id,
                            httpMethod: "DELETE",
                            callback: function (resp) {
                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                    isc.say("<spring:message code='global.form.request.successful'/>.");
                                    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.invalidateCache();
                                    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.fetchData({"warehouseCadId": ListGrid_warehouseCAD.getSelectedRecord().id},
                                        function (dsResponse, data, dsRequest) {
                                            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.setData(data);
                                        });
                                } else
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                            }
                        }))
                    }
                }
            });
        },
        saveEdits: function () {
            var warehouseCadItemRecord = ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.getEditedRecord(ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.getEditRow());
            if (warehouseCadItemRecord.issueId != undefined) {
                isc.warn("<spring:message code='bijack.item.inventory'/>");
                return;
            }

            if (warehouseCadItemRecord.bundleSerial != undefined && warehouseCadItemRecord.sheetNo != undefined && warehouseCadItemRecord.weightKg != undefined &&
                warehouseCadItemRecord.bundleSerial != null && warehouseCadItemRecord.sheetNo != null && warehouseCadItemRecord.weightKg != null) {

                warehouseCadItemRecord.warehouseCadId = ListGrid_warehouseCAD.getSelectedRecord().id;
                var method = "PUT";
                if (warehouseCadItemRecord.id == null)
                    method = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseCadItem/",
                    httpMethod: method,
                    data: JSON.stringify(warehouseCadItemRecord),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.setData([]);
                            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.fetchData({"warehouseCadId": ListGrid_warehouseCAD.getSelectedRecord().id},
                                function (dsResponse, data, dsRequest) {
                                    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.setData(data);
                                });
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                }))

            }
            else {
                isc.warn("<spring:message code='validator.warehousecaditem.fields.is.required'/>");
                return;
            }
        }
    });

    var add_bundle_button = isc.IButton.create({
        title: "<spring:message code='warehouseCad.addBundle'/>",
        width: 150,
        click: "ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.startEditingNew()"
    });

    var DynamicForm_warehouseCAD_Bij = isc.DynamicForm.create({
        titleWidth: "150",
        itemKeyPress (item, keyName, characterValue){
               if(keyName=="Enter" && DynamicForm_warehouseCAD_Bij.getValue("destinationTozinPlantStaticId") !== undefined){

                    var RestDataSource_TozinStatic_BandarAbbas_optionCriteria = {
                            _constructor: "AdvancedCriteria",
                            operator: "and",
                            criteria: [{
                                fieldName: "target",
                                operator: "iContains",
                                value: "رجا"
                            },{
                                fieldName: "codeKala",
                                operator: "equals",
                                value: ListGrid_warehouseCAD.getSelectedRecord().materialItem.gdsCode
                            },{
                                fieldName: "tozinId",
                                operator: "equals",
                                value: DynamicForm_warehouseCAD_Bij.getValue("destinationTozinPlantStaticId")
                            }]
                        };
                    RestDataSource_tozin_IN_WAREHOUSECAD_ONWAYPRODUCT.fetchData(RestDataSource_TozinStatic_BandarAbbas_optionCriteria,function(dsResponse, data, dsRequest) {
                            if (data.length==0){
                                isc.warn("<spring:message code='warehouseCad.addBijackPlanIdIsNotValid'/>")
                                DynamicForm_warehouseCAD_Bij.clearValue("destinationTozinPlantStaticId")
                                DynamicForm_warehouseCAD_Bij.getField('destinationTozinPlantId').setDisabled(false);
                            }else{
                                DynamicForm_warehouseCAD_Bij.setValue("destinationTozinPlantId",DynamicForm_warehouseCAD_Bij.getValue("destinationTozinPlantStaticId"));
                                DynamicForm_warehouseCAD_Bij.setValue("destinationUnloadDate", data[0].tozinDate);
                                DynamicForm_warehouseCAD_Bij.setValue("destinationBundleSum", data[0].tedad);
                                DynamicForm_warehouseCAD_Bij.setValue("destinationWeight", data[0].vazn);
                                isc.say("<spring:message code='warehouseCad.addBijackPlanIdIsValid'/>")
                            }
                    })
                }
            },
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
            required: true,
            validators: [{
                type:"required",
                validateOnChange: true
            }]
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
            canEdit: false,
            colSpan: 3,
            titleColSpan: 1,
            title: "<spring:message code='warehouseCad.tozinOther'/>",
            width: "100%"
        },{
                align: "center",
                layoutAlign: "center",
                type: "Header",
                defaultValue: "<spring:message code='warehouseCad.addBijackPlanIdExact'/>"
            },{
            name: "destinationTozinPlantStaticId",
            disabled: false,
            colSpan: 3,
            titleColSpan: 1,
            showHover: true,
            autoFetchData: false,
            title: "<spring:message code='warehouseCad.tozinBandarAbbas'/>",
            width: "100%",
            changed(form, item, value) {
                if(value==undefined){
                    DynamicForm_warehouseCAD_Bij.getField('destinationTozinPlantId').setDisabled(false);
                }
                else{
                    DynamicForm_warehouseCAD_Bij.getField('destinationTozinPlantId').setDisabled(true);
                }
            }
            },{
                align: "center",
                layoutAlign: "center",
                type: "Header",
                defaultValue: "<spring:message code='warehouseCad.addBijackPlanId'/>"
            },{
            name: "destinationTozinPlantId",
            required: true,
            validators: [{
                type:"required",
                validateOnChange: true
            }],
            colSpan: 3,
            titleColSpan: 1,
            showHover: true,
            autoFetchData: false,
            title: "<spring:message code='warehouseCad.tozinBandarAbbas'/>",
            width: "100%",
            editorType: "ComboBoxItem",
            optionDataSource: RestDataSource_tozin_IN_WAREHOUSECAD_BIJACK,
            optionCriteria: RestDataSource_Tozin_BandarAbbas_optionCriteria,
            addUnknownValues: false,
            useClientFiltering: false,
            generateExactMatchCriteria: true,
            displayField: "tozinId",
            valueField: "tozinId",
            pickListProperties: {
                showFilterEditor: true,
                filterOnKeypress: false
            },
            pickListFields: [
                {name: "containerId"},
                {name: "plak"},
                {name: "carName"},
                {name: "tozinDate"},
                {name: "tozinId"}
            ],
            changed(form, item, value) {
                if(value==undefined){
                    DynamicForm_warehouseCAD_Bij.getField('destinationTozinPlantStaticId').setDisabled(false);
                }
                else{
                    DynamicForm_warehouseCAD_Bij.getField('destinationTozinPlantStaticId').setDisabled(true);
                }
                DynamicForm_warehouseCAD_Bij.setValue("destinationUnloadDate", item.getSelectedRecord().tozinDate);
                DynamicForm_warehouseCAD_Bij.setValue("destinationBundleSum", item.getSelectedRecord().tedad);
                DynamicForm_warehouseCAD_Bij.setValue("destinationWeight", item.getSelectedRecord().vazn);
            }
        }, {
            name: "warehouseYardId",
            required: true,
            validators: [{
                type:"required",
                validateOnChange: true
            }],
            colSpan: 1,
            titleColSpan: 1,
            showHover: true,
            autoFetchData: false,
            title: "<spring:message code='warehouseCad.yard'/>",
            type: 'string',
            editorType: "SelectItem",
            optionDataSource: RestDataSource_WarehouseYard_IN_WAREHOUSECAD_BIJACK,
            displayField: "nameFA",
            valueField: "id",
            pickListWidth: "215",
            pickListHeight: "215",
            pickListProperties: {
                showFilterEditor: true,
                filterOnKeypress: false
            },
            pickListFields: [{
                name: "nameFA"
            }],
            changed: function (form, item, value) {
                if (!item.getDisplayValue(value).includes("کاتد")) {
                    isc.warn("<spring:message code='warehouseYard.alert'/>");
                    form.getItem("warehouseYardId").setValue("");
                }
            }
        },
            {
                name: "containerNo",
                title: "<spring:message code='warehouseCad.containerNo'/>",
                colSpan: 1,
                titleColSpan: 1,
                canEdit: false
            },
            {
                name: "rahahanPolompNo",
                title: "<spring:message code='warehouseCad.rahahanPolompNo'/>",
                colSpan: 1,
                titleColSpan: 1
            }, {
                name: "herasatPolompNo",
                title: "<spring:message code='warehouseCad.herasatPolompNo'/>",
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
                width: 90,
            },
            {

                type: "staticText",
                title: "<b><spring:message code='bijack.title.destination.left'/></b>",
                wrapTitle: false,
                width: 90,
            },

            {
                name: "sourceLoadDate",
                title: "<spring:message code='warehouseCad.sourceLoadDate'/>", //=تاریخ بارگیری در مبدا
                colSpan: 1,
                titleColSpan: 1,
                canEdit: false
            },

            {
                name: "destinationUnloadDate",
                title: "<spring:message code='warehouseCad.destinationUnloadDate'/>", //تاریخ تخلیه در مقصد
                colSpan: 1,
                titleColSpan: 1,
                canEdit: false
            },
            {
                name: "sourceBundleSum",
                title: "<spring:message code='warehouseCad.sourceBundleSum'/>",
                colSpan: 1,
                titleColSpan: 1,
                canEdit: false
            },
            {
                name: "destinationBundleSum",
                title: "<spring:message code='warehouseCad.destinationBundleSum'/>",
                colSpan: 1,
                titleColSpan: 1,
                canEdit: false
            },
            {
                name: "sourceSheetSum",
                title: "<spring:message code='warehouseCad.sourceSheetSum'/>",
                colSpan: 1,
                titleColSpan: 1,
                canEdit: false
            },
            {
                name: "destinationSheetSum",
                title: "<spring:message code='warehouseCad.destinationSheetSum'/>",
                colSpan: 1,
                titleColSpan: 1,
                canEdit: false
            },
            {
                name: "sourceWeight",
                title: "<spring:message code='warehouseCad.sourceWeight'/>",
                colSpan: 1,
                titleColSpan: 1,
                keyPressFilter: "[0-9]",
                canEdit: false
            },
            {
                name: "destinationWeight",
                title: "<spring:message code='warehouseCad.destinationWeight'/>",
                colSpan: 1,
                titleColSpan: 1,
                keyPressFilter: "[0-9]",
                canEdit: false
            },
            {
                name: "sourceSheetSumDelivery",
                title: "<spring:message code='warehouseCad.SheetNumber.Source'/>",
                colSpan: 1,
                titleColSpan: 1
            },
            {
                name: "destinationSheetSumDelivery",
                title: "<spring:message code='warehouseCad.SheetNumber.Destination'/>",
                colSpan: 1,
                titleColSpan: 1
            },
            {
                align: "center",
                layoutAlign: "center",
                type: "Header",
                defaultValue: "<spring:message code='warehouseCad.addBijackItem'/>"
            }
        ]
    });

    var DynamicForm_warehouseCAD_Bij_Desc = isc.DynamicForm.create({
        titleWidth: "200",
        fields: [
            {
                name: "bijakFirstDescription",
                title: "<spring:message code='warehouseCad.bijakFirstDescription'/>",
                type: "textarea",
                orientation: "right",
                length: 255,
                width: 650,
                rowSpan: 2,
                height: 40
            },
            {
                name: "bijakSecondDescription",
                title: "<spring:message code='warehouseCad.bijakSecondDescription'/>",
                type: "textarea",
                orientation: "right",
                length: 255,
                width: 650,
                rowSpan: 2,
                height: 40
            }
        ]
    });

    var IButton_warehouseCAD_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            if (DynamicForm_warehouseCAD_Bij.getValue("destinationTozinPlantId") == undefined && DynamicForm_warehouseCAD_Bij.getValue("destinationTozinPlantStaticId") == undefined) {
                isc.warn("<spring:message code='warehouseCad.tozinBandarAbbasErrors'/>");
                DynamicForm_warehouseCAD_Bij.validate()
                return;
            }

            DynamicForm_warehouseCAD_Bij.validate();
            if (DynamicForm_warehouseCAD_Bij.hasErrors())
                return;

            DynamicForm_warehouseCAD_Bij.setValue("materialItemId", ListGrid_warehouseCAD.getSelectedRecord().materialItemId);
            var data_WarehouseCad = DynamicForm_warehouseCAD_Bij.getValues();
               if(DynamicForm_warehouseCAD_Bij.getValue("destinationTozinPlantId") != undefined)
                        data_WarehouseCad.destinationTozinPlantId = DynamicForm_warehouseCAD_Bij.getValue("destinationTozinPlantId")
                else if(DynamicForm_warehouseCAD_Bij.getValue("destinationTozinPlantStaticId")!= undefined){
                        data_WarehouseCad.destinationTozinPlantId = DynamicForm_warehouseCAD_Bij.getValue("destinationTozinPlantStaticId")
                }
            var warehouseCadItems = [];

            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.selectAllRecords();

            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.getSelectedRecords().forEach(function (element) {
                if (element.bundleSerial != undefined && element.sheetNo != undefined && element.weightKg != undefined &&
                    element.bundleSerial != null && element.sheetNo != null && element.weightKg != null)
                    warehouseCadItems.add(JSON.parse(JSON.stringify(element)));
            });

            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.deselectAllRecords();

            data_WarehouseCad.warehouseCadItems = warehouseCadItems;
            data_WarehouseCad.bijakFirstDescription = DynamicForm_warehouseCAD_Bij_Desc.getValue("bijakFirstDescription");
            data_WarehouseCad.bijakSecondDescription = DynamicForm_warehouseCAD_Bij_Desc.getValue("bijakSecondDescription");

            var method = "PUT";
            if (data_WarehouseCad.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseCad/",
                    httpMethod: method,
                    data: JSON.stringify(data_WarehouseCad),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_warehouseCAD_refresh();
                            Window_Bijack.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.setData([]);
    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.fetchData({"warehouseCadId": ListGrid_warehouseCAD.getSelectedRecord().id},
        function (dsResponse, data, dsRequest) {
            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK.setData(data);
        });

    DynamicForm_warehouseCAD_Bij.clearValues();
    DynamicForm_warehouseCAD_Bij.editRecord(ListGrid_warehouseCAD.getSelectedRecord());

    DynamicForm_warehouseCAD_Bij.setValue("materialItemId", ListGrid_warehouseCAD.getSelectedRecord().materialItem.gdsName);
    DynamicForm_warehouseCAD_Bij.setValue("plant", ListGrid_warehouseCAD.getSelectedRecord().plant);
    DynamicForm_warehouseCAD_Bij.setValue("warehouseNo", "BandarAbbas");
    DynamicForm_warehouseCAD_Bij.setValue("movementType", ListGrid_warehouseCAD.getSelectedRecord().movementType);
    DynamicForm_warehouseCAD_Bij.setValue("sourceTozinPlantId", ListGrid_warehouseCAD.getSelectedRecord().sourceTozinPlantId);
    DynamicForm_warehouseCAD_Bij.setValue("sourceLoadDate", ListGrid_warehouseCAD.getSelectedRecord().sourceLoadDate);
    DynamicForm_warehouseCAD_Bij.setValue("destinationTozinPlantStaticId", ListGrid_warehouseCAD.getSelectedRecord().destinationTozinPlantId);
    DynamicForm_warehouseCAD_Bij.setValue("containerNo", ListGrid_warehouseCAD.getSelectedRecord().containerNo);
    DynamicForm_warehouseCAD_Bij_Desc.setValue("bijakFirstDescription", ListGrid_warehouseCAD.getSelectedRecord().bijakFirstDescription);
    DynamicForm_warehouseCAD_Bij_Desc.setValue("bijakSecondDescription", ListGrid_warehouseCAD.getSelectedRecord().bijakSecondDescription);

    isc.VLayout.create({
        width: 830,
        height: 830,
        padding: 10,
        margin: 10,
        members: [
            DynamicForm_warehouseCAD_Bij,
            add_bundle_button,
            ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_BIJACK,
            DynamicForm_warehouseCAD_Bij_Desc,
            isc.HLayout.create({
                width: "100%",
                align: "center",
                margin: 10,
                padding: 20,
                members:
                    [
                        IButton_warehouseCAD_Save,
                        isc.Label.create({
                            width: 5,
                        }),
                        isc.IButtonCancel.create({
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