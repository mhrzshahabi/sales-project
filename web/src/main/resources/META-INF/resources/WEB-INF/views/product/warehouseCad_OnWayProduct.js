//<%@ page contentType="text/html;charset=UTF-8" %>
//<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

// <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

var RestDataSource_CathodList = isc.MyRestDataSource.create({
    fields: [
        {name: "storeId"},
        {name: "tozinId"},
        {name: "productId"},
        {name: "productLabel"},
        {name: "wazn"},
        {name: "sheetNumber"},
        {name: "packingTypeId"},
        {name: "gdsCode"}
    ],
    fetchDataURL: "${contextPath}/api/cathodList/spec-list"
});

var RestDataSource_WarehouseYard_IN_WAREHOUSECAD_ONWAYPRODUCT = isc.MyRestDataSource.create({
    fields: [
        {
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
        {
            name: "nameFA",
            title: "<spring:message code='warehouseCad.yard'/>",
            width: "25%",
        },
        {
            name: "nameEN",
            title: "<spring:message code='warehouseCad.yard'/>",
            width: "25%"
        },
        {
            name: "warehouseNo",
            title: "<spring:message code='warehouseCadItem.description'/>"
        }
    ],
    fetchDataURL: "${contextPath}/api/warehouseYard/spec-list"
});

var RestDataSource_tozin_IN_WAREHOUSECAD_ONWAYPRODUCT = isc.MyRestDataSource.create({
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
        value: ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().codeKala
    }]
};
var add_bundle_button = isc.IButton.create({
    title: "<spring:message code='warehouseCad.addBundle'/>",
    // width: 150,
    click: "ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.startEditingNew()"
});
var ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT = isc.ListGrid.create({
    showFilterEditor: true,
    width: 800,
    height: 500,
    modalEditing: true,
    canEdit: true,
    editEvent: "click",
    editByCell: true,
    canRemoveRecords: true,
    autoSaveEdits: false,
    deferRemoval: false,
    saveLocally: true,
    showGridSummary: true,
    // visibility: 'hidden',
    // gridComponents: ["header", "body",  ],
    fields: [{
        name: "productLabel",
        title: "<spring:message code='warehouseCadItem.bundleSerial'/>",
        width: "20%",
        summaryFunction: "count"
    }, {
        name: "sheetNumber",
        title: "<spring:message code='warehouseCadItem.sheetNo'/>",
        width: "20%",
        validators: [{
            type: "regexp",
            expression: "^[0-9]*$",
            validateOnChange: true
        }],
        summaryFunction: "sum"
    }, {
        name: "wazn",
        title: "<spring:message code='warehouseCadItem.weightKg'/>",
        width: "20%",
        validators: [{
            type: "regexp",
            expression: "^[0-9]*$",
            validateOnChange: true
        }],
        summaryFunction: "sum"
    }, {
        name: "description",
        title: "<spring:message code='warehouseCadItem.description'/>",
        width: "25%"
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
                    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.data.remove(record);
                }

            }
        });
    }
});



var DynamicForm_warehouseCAD = isc.DynamicForm.create({
    titleWidth: "150",
    numCols: 4,
    itemKeyPress(item, keyName, characterValue) {
        if (keyName == "Enter" && DynamicForm_warehouseCAD.getValue("destinationTozinPlantStaticId") !== undefined) {
            var RestDataSource_TozinStatic_BandarAbbas_optionCriteria = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{
                    fieldName: "target",
                    operator: "iContains",
                    value: "رجا"
                }, {
                    fieldName: "codeKala",
                    operator: "equals",
                    value: ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().codeKala
                }, {
                    fieldName: "tozinId",
                    operator: "equals",
                    value: DynamicForm_warehouseCAD.getValue("destinationTozinPlantStaticId")
                }]
            };
            RestDataSource_tozin_IN_WAREHOUSECAD_ONWAYPRODUCT.fetchData(RestDataSource_TozinStatic_BandarAbbas_optionCriteria, function (dsResponse, data, dsRequest) {
                if (data.length == 0) {
                    isc.warn("<spring:message code='warehouseCad.addBijackPlanIdIsNotValid'/>");
                    DynamicForm_warehouseCAD.clearValue("destinationTozinPlantStaticId");
                    DynamicForm_warehouseCAD.getField('destinationTozinPlantId').setDisabled(false);
                } else {
                    DynamicForm_warehouseCAD.setValue("destinationUnloadDate", data[0].tozinDate);
                    DynamicForm_warehouseCAD.setValue("destinationBundleSum", data[0].tedad);
                    DynamicForm_warehouseCAD.setValue("destinationWeight", data[0].vazn);
                    isc.say("<spring:message code='warehouseCad.addBijackPlanIdIsValid'/>")
                }
            })
        }
    },
    fields: [
        {
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
                type: "required",
                validateOnChange: true
            }]
        }, {
            name: "materialItemId",
            title: "<spring:message code='contractItem.material'/>",
            type: 'staticText',
        }, {
            name: "plant",
            title: "<spring:message code='contractItem.plant'/>",
            type: 'staticText',
        }, {
            name: "warehouseNo",
            title: "<spring:message code='warehouseCad.warehouseNo'/>",
            type: 'staticText',
        }, {
            name: "movementType",
            title: "<spring:message code='warehouseCad.movementType'/>",
            type: 'staticText',
        }, {
            name: "sourceTozinPlantId",
            type: 'staticText',
            colSpan: 3,
            titleColSpan: 1,
            title: "<spring:message code='warehouseCad.tozinOther'/>",
            width: "100%"
        }, {
            align: "center",
            layoutAlign: "center",
            type: "Header",
            defaultValue: "<spring:message code='warehouseCad.addBijackPlanIdExact'/>"
        }, {
            name: "destinationTozinPlantStaticId",
            disabled: false,
            colSpan: 3,
            titleColSpan: 1,
            showHover: true,
            autoFetchData: false,
            title: "<spring:message code='warehouseCad.tozinBandarAbbas'/>",
            width: "100%",
            changed(form, item, value) {
                if (value == undefined) {
                    DynamicForm_warehouseCAD.getField('destinationTozinPlantId').setDisabled(false);
                } else {
                    DynamicForm_warehouseCAD.getField('destinationTozinPlantId').setDisabled(true);
                }
            }
        }, {
            align: "center",
            layoutAlign: "center",
            type: "Header",
            defaultValue: "<spring:message code='warehouseCad.addBijackPlanId'/>"
        }, {
            name: "destinationTozinPlantId",
            colSpan: 3,
            titleColSpan: 1,
            width: "100%",
            autoFetchData: false,
            title: "<spring:message code='warehouseCad.tozinBandarAbbas'/>",
            editorType: "ComboBoxItem",
            optionDataSource: RestDataSource_tozin_IN_WAREHOUSECAD_ONWAYPRODUCT,
            optionCriteria: RestDataSource_Tozin_BandarAbbas_optionCriteria,
            addUnknownValues: false,
            useClientFiltering: false,
            generateExactMatchCriteria: true,
            displayField: "tozinId",
            valueField: "tozinId",
            pickListProperties: {
                showFilterEditor: true,
                filterOnKeypress: true
            },
            pickListFields: [
                {name: "containerId"},
                {name: "plak"},
                {name: "carName"},
                {name: "tozinDate"},
                {name: "tozinId"}
            ],
            changed(form, item, value) {
                if (value == undefined) {
                    DynamicForm_warehouseCAD.getField('destinationTozinPlantStaticId').setDisabled(false);
                } else {
                    DynamicForm_warehouseCAD.getField('destinationTozinPlantStaticId').setDisabled(true);
                }
                DynamicForm_warehouseCAD.setValue("destinationUnloadDate", item.getSelectedRecord().tozinDate);
                DynamicForm_warehouseCAD.setValue("destinationBundleSum", item.getSelectedRecord().tedad);
                DynamicForm_warehouseCAD.setValue("destinationWeight", item.getSelectedRecord().vazn);
            }
        }, {
            name: "warehouseYardId",
            required: true,
            validators: [{
                type: "required",
                validateOnChange: true
            }],
            colSpan: 1,
            titleColSpan: 1,
            showHover: true,
            autoFetchData: false,
            title: "<spring:message code='warehouseCad.yard'/>",
            type: 'string',
            editorType: "SelectItem",
            optionDataSource: RestDataSource_WarehouseYard_IN_WAREHOUSECAD_ONWAYPRODUCT,
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
            type: 'staticText',
        },
        {
            name: "rahahanPolompNo",
            title: "<spring:message code='warehouseCad.rahahanPolompNo'/>",
            colSpan: 1,
            titleColSpan: 1
        },
        {
            name: "herasatPolompNo",
            title: "<spring:message code='warehouseCad.herasatPolompNo'/>", //شماره پلمپ حراست
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
            type: "staticText",
        },
        {
            name: "destinationUnloadDate",
            title: "<spring:message code='warehouseCad.destinationUnloadDate'/>", //تاریخ تخلیه در مقصد
            colSpan: 1,
            titleColSpan: 1,
            type: "staticText",
        },
        {
            name: "sourceBundleSum",
            title: "<spring:message code='warehouseCad.sourceBundleSum'/>",
            colSpan: 1,
            titleColSpan: 1,
            type: "staticText",
        },
        {
            name: "destinationBundleSum",
            title: "<spring:message code='warehouseCad.destinationBundleSum'/>",
            colSpan: 1,
            titleColSpan: 1,
// type: "staticText",
        },
        {
            name: "sourceSheetSum",
            title: "<spring:message code='warehouseCad.sourceSheetSum'/>",
            colSpan: 1,
            titleColSpan: 1,
            type: "staticText",
        },
        {
            name: "destinationSheetSum",
            title: "<spring:message code='warehouseCad.destinationSheetSum'/>",
            colSpan: 1,
            titleColSpan: 1,
            type: "staticText",
        },
        {
            name: "sourceWeight",
            title: "<spring:message code='warehouseCad.sourceWeight'/>",
            colSpan: 1,
            titleColSpan: 1,
            keyPressFilter: "[0-9]",
            type: "staticText",
        },
        {
            name: "destinationWeight",
            title: "<spring:message code='warehouseCad.destinationWeight'/>",
            colSpan: 1,
            titleColSpan: 1,
            keyPressFilter: "[0-9]",
            type: "staticText",
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

var DynamicForm_warehouseCAD_Desc = isc.DynamicForm.create({
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
            height: 40,
            canEdit: false
        },
        {
            name: "bijakSecondDescription",
            title: "<spring:message code='warehouseCad.bijakSecondDescription'/>",
            type: "textarea",
            orientation: "right",
            length: 255,
            width: 650,
            rowSpan: 2,
            height: 40,
            canEdit: false
        }
    ]
});

var IButton_warehouseCAD_Save = isc.IButtonSave.create({
    top: 260,
    title: "<spring:message code='global.form.save'/>",
    icon: "pieces/16/save.png",
    click: function () {
        isc.Dialog.create({
            title: "<spring:message code='global.warning'/>",
            message: "<spring:message code='warehouseCad.warning.save'/>",
            buttons: [isc.Dialog.OK, isc.Dialog.CANCEL],
            okClick() {
                this.close();
                if (DynamicForm_warehouseCAD.getValue("destinationTozinPlantId") == undefined && DynamicForm_warehouseCAD.getValue("destinationTozinPlantStaticId") == undefined) {
                    isc.warn("<spring:message code='warehouseCad.tozinBandarAbbasErrors'/>");
                    DynamicForm_warehouseCAD.validate();
                    return;
                }
                if (ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.hasErrors()) {
                    isc.warn("<spring:message code='warehouseCadItem.tedadCADErrors'/>");
                    return;
                }
                DynamicForm_warehouseCAD.validate();
                if (DynamicForm_warehouseCAD.hasErrors())
                    return;
                DynamicForm_warehouseCAD.setValue("materialItemId", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().codeKala);
                var data_WarehouseCad = DynamicForm_warehouseCAD.getValues();
                if (DynamicForm_warehouseCAD.getValue("destinationTozinPlantId") != undefined)
                    data_WarehouseCad.destinationTozinPlantId = DynamicForm_warehouseCAD.getValue("destinationTozinPlantId")
                else if (DynamicForm_warehouseCAD.getValue("destinationTozinPlantStaticId") != undefined) {
                    data_WarehouseCad.destinationTozinPlantId = DynamicForm_warehouseCAD.getValue("destinationTozinPlantStaticId")
                }
                var warehouseCadItems = [];

                ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.selectAllRecords();
                var notComplete = 0;
                ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.getAllEditRows().forEach(function (element) {
                    var record = ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.getEditedRecord(JSON.parse(JSON.stringify(element)));
                    if (record.productLabel != undefined && record.sheetNumber != undefined && record.wazn != undefined &&
                        record.productLabel != null && record.sheetNumber != null && record.wazn != null) {
                        warehouseCadItems.add(record);
                    } else {
                        notComplete++;
                    }
                    ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.deselectRecord(ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.getRecord(element));
                });

                ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.getSelectedRecords().forEach(function (element) {
                    warehouseCadItems.add(JSON.parse(JSON.stringify(element)));
                });

                if (notComplete != 0) {
                    isc.warn("<spring:message code='validator.warehousecaditem.fields.is.required'/>");
                    return;
                }

                ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.deselectAllRecords();

                warehouseCadItems.forEach(function (item) {
                    item.bundleSerial = item.productLabel;
                    delete item.productLabel;
                    item.sheetNo = item.sheetNumber;
                    delete item.sheetNumber;
                    item.weightKg = item.wazn;
                    delete item.wazn;
                });

                data_WarehouseCad.warehouseCadItems = warehouseCadItems;
                data_WarehouseCad.bijakFirstDescription = DynamicForm_warehouseCAD_Desc.getValue("bijakFirstDescription");
                data_WarehouseCad.bijakSecondDescription = DynamicForm_warehouseCAD_Desc.getValue("bijakSecondDescription");

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
                                ListGrid_Tozin_IN_ONWAYPRODUCT_refresh();
                                Window_BijackOnWayProduct.close();
                            } else
                                isc.say(RpcResponse_o.data);
                        }
                    })
                );
            }
        })

    }
});

ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.setData([]);
var criteria_cathod = {
    _constructor: "AdvancedCriteria", operator: "and",
    criteria: [{
        fieldName: "tozinId",
        operator: "equals",
        value: ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().tozinId
    }]
};

RestDataSource_CathodList.fetchData(criteria_cathod,
    function (dsResponse, data, dsRequest) {
        data.forEach(function (item) {
            delete item.storeId;
            delete item.tozinId;
            delete item.productId;
            delete item.packingTypeId;
            delete item.gdsCode;
        });
        ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT.setData(data);
    });

DynamicForm_warehouseCAD.clearValues();

DynamicForm_warehouseCAD.setValue("materialItemId", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().nameKala);
SalesBaseParameters.getWarehouseParameter().then(
    p => {
        const source = p.find(pp => {
            return pp.id === ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord()['sourceId']
        })
        console.log(source, 'source')
        DynamicForm_warehouseCAD.setValue("plant", source['name']);

    }
);
DynamicForm_warehouseCAD.setValue("warehouseNo", "BandarAbbas");
DynamicForm_warehouseCAD.setValue("movementType", isNaN(ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord()['containerNo3']) ? 'جاده‌ای' : 'ریلی');
DynamicForm_warehouseCAD.setValue("sourceTozinPlantId", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().tozinId);
DynamicForm_warehouseCAD.setValue("sourceLoadDate", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().tozinDate);
DynamicForm_warehouseCAD.setValue("containerNo", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().containerId);
DynamicForm_warehouseCAD.setValue("sourceBundleSum", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().tedad);
DynamicForm_warehouseCAD.setValue("sourceWeight", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().vazn);

DynamicForm_warehouseCAD_Desc.setValue("bijakFirstDescription", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().strSharh2);
DynamicForm_warehouseCAD_Desc.setValue("bijakSecondDescription", ListGrid_Tozin_IN_ONWAYPRODUCT.getSelectedRecord().ctrlDescOut);
var bundle_window = isc.Window.create({
    title: "<spring:message code='contact.title'/>",
    width: 700,
    // height: 580,
    autoSize: true,
    autoCenter: true,
    isModal: true,
    showModalMask: true,
    align: "center",
    autoDraw: false,
    dismissOnEscape: true,
    visibility: 'hidden',
    closeClick: function () {
        this.Super("closeClick", arguments)
    },
    items: [isc.HLayout.create({
        members: [add_bundle_button],
        height: 10
    }), ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT]
})
isc.VLayout.create({
    width: 830,
    // height: 700,
    padding: 10,
    margin: 10,
    members: [
        DynamicForm_warehouseCAD,
        // ListGrid_WarehouseCadItem_IN_WAREHOUSECAD_ONWAYPRODUCT,
        DynamicForm_warehouseCAD_Desc,
        isc.HLayout.create({
            width: "100%",
            // height:100,
            align: "center",
            margin: 10,
            padding: 20,
            members:
                [
                    isc.IButtonSave.create({
                        title: "<spring:message code='warehouseStock.bundle'/>",
                        width: 100,
                        icon: "pieces/16/packages.png",
                        orientation: "vertical",
                        click: function () {
                            bundle_window.show();
                        }
                    }),
                    isc.Label.create({
                        width: 5,
                    }),
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
                            isc.Dialog.create({
                                title: "<spring:message code='global.warning'/>",
                                message: "<spring:message code='warehouseCad.warning.close'/>",
                                buttons: [isc.Dialog.OK, isc.Dialog.CANCEL],
                                okClick() {
                                    Window_BijackOnWayProduct.close();
                                    this.close();
                                }
                            })
                        }
                    }),
                ]
        })
    ]
});


//<script>