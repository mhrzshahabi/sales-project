<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Material = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='material.code'/> "},
                {name: "descl", title: "<spring:message code='material.descl'/> "},
                {name: "descp", title: "<spring:message code='material.descp'/> "},
                {name: "unitId", title: "<spring:message code='MaterialFeature.unit'/>"},//Edit By JZ
                {name: "unitnameFA",  dataPath:"unit.nameFA"  ,   title: "<spring:message code='MaterialFeature.unit.FA'/>", align: "center"},
                {name: "unitnameEN",   dataPath:"unit.nameEN"  ,  title: "<spring:message code='MaterialFeature.unit'/> "},
            ],
        fetchDataURL: "${contextPath}/api/material/spec-list"
    });

    var RestDataSource_Unit_IN_MATERIAL = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "nameFA", title: "<spring:message code='MaterialFeature.unit.FA'/> "},
                {name: "nameEN", title: "<spring:message code='unit.nameEN'/> "},
                {name: "symbol", title: "<spring:message code='unit.symbol'/>"},
                {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
            ],
        fetchDataURL: "${contextPath}/api/unit/spec-list"
    });

    var RestDataSource_Rate_IN_MATERIAL = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='rate.code'/> "},
                {name: "nameFA", title: "<spring:message code='rate.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='rate.nameEN'/> "},
                {name: "symbol", title: "<spring:message code='rate.symbol'/>"},
                {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
            ],
        fetchDataURL: "${contextPath}/api/rate/spec-list"
    });

    var RestDataSource_Feature_IN_MATERIAL = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='feature.code'/> "},
                {name: "nameFA", title: "<spring:message code='feature.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='feature.nameEN'/> "},
                {name: "symbol", title: "<spring:message code='feature.symbol'/>"},
                {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
            ],
        fetchDataURL: "${contextPath}/api/feature/spec-list"
    });

    var RestDataSource_MaterialItem_IN_MATERIAL = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "gdsCode", title: "<spring:message code='MaterialItem.gdsCode'/> "},
                {name: "gdsName", title: "<spring:message code='MaterialItem.gdsName'/> "},
                {name: "materialId", hidden: true},
            ],
        fetchDataURL: "${contextPath}/api/materialItem/spec-list"
    });

    var RestDataSource_MaterialFeature = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "materialId", hidden: true},
            {name: "itemRow", title: "<spring:message code='contractItem.itemRow'/> "},
            {name: "featureId", type: 'text', width: 100},
            {name: "featurenameFA", type: 'text', width: 100 ,dataPath:"feature.nameFA"  , },
            {name: "featurenameEN", type: 'text', width: 100 , dataPath:"feature.nameEN"  ,},
            {name: "minValue", title: "<spring:message code='MaterialFeature.minValue'/> "},
            {name: "maxValue", title: "<spring:message code='MaterialFeature.maxValue'/> "},
            {name: "avgValue", title: "<spring:message code='MaterialFeature.avgValue'/>", type: 'float', width: 100},
            {name: "tolorance", title: "<spring:message code='MaterialFeature.tolorance'/>", type: 'float', width: 100},
            {name: "ratenameFA", type: 'text', width: 100 , dataPath:"rate.nameFA"  ,},
            {name: "ratenameEN", type: 'text', width: 100 , dataPath:"rate.nameEN"  ,},
            {name: "rateId", type: 'text', width: 100 },
            {
                name: "payableIfGraterThan",
                title: "<spring:message code='MaterialFeature.payableIfGraterThan'/>",
                type: 'text',
                width: 400
            },
            {
                name: "paymentPercent",
                title: "<spring:message code='MaterialFeature.paymentPercent'/>",
                type: 'text',
                width: 400
            },
            {name: "treatCost", title: "<spring:message code='MaterialFeature.TC'/>", type: 'text', width: 400},
            {name: "refineryCost", title: "<spring:message code='MaterialFeature.RC'/>", type: 'text', width: 400},
        ],
        fetchDataURL: "${contextPath}/api/materialFeature/spec-list"
    });

    var IButton_Material_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Material.validate();
            if (DynamicForm_Material.hasErrors())
                return;

            var data = DynamicForm_Material.getValues();
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/material/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_Material_refresh();
                            Window_Material.close();
                        } else
                            isc.say(RpcResponse_o.data);

                    },


                }),

            )
        }
    });

    function ListGrid_Material_refresh() {
        ListGrid_Material.invalidateCache();
        ListGrid_MaterialFeature.setData([]);
    }

    function ListGrid_Material_edit() {

        var record = ListGrid_Material.getSelectedRecord();

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
            DynamicForm_Material.editRecord(record);
            Window_Material.show();
        }
    }

    function ListGrid_Material_remove() {

        var record = ListGrid_Material.getSelectedRecord();

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
                buttons: [isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}), isc.IButtonCancel.create({
                    title: "<spring:message
		code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var materialId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/material/" + materialId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_Material_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                },

                            })


                        );
                    }
                }
            });
        }
    };

    var Menu_ListGrid_Material = isc.Menu.create({
        width: 100,
        data:
            [
                {
                    title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_Material_refresh();
                    }
                },
                {
                    title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                    click: function () {
                        DynamicForm_Material.clearValues();
                        Window_Material.show();
                    }
                },
                {
                    title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_Material_edit();
                    }
                },
                {
                    title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_Material_remove();
                    }
                }
            ]
    });

    var DynamicForm_Material = isc.DynamicForm.create({
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
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true},
                {type: "RowSpacerItem"},
                {
                    name: "code",
                    title: "<spring:message code='material.code'/>",
                    required: true,
                    width: 400,
                    length: "20",
                    keyPressFilter: "[0-9]",
                    validators: [{
                        type: "number", //Fix
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],

                    hint: "<spring:message code='global.didit'/>",
                    showHintInField: true,
                },
                {
                    name: "descl",
                    title: "<spring:message code='material.descl'/>",
                    type: 'text',
                    width: 400, required: true, keyPressFilter: "[a-z|A-Z|0-9 ]",
                    textAlign: "left",
                    length:200
                },
                {
                    name: "descp",
                    title: "<spring:message code='material.descp'/>",
                    type: 'text',
                    width: 400,
                    required: true,
                keyPressFilter: "[a-z|A-Z|0-9 ]" ,  length:200
                },
                {
                    name: "unitId",
                    title: "<spring:message code='unit.nameFa'/>",
                    type: 'long',
                    width: 400,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Unit_IN_MATERIAL,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "400",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [{name: "id", width: 50, align: "center" , hidden:true}, {
                        name: "nameFA",
                            width: 174,
                        align: "center"
                        }, {name: "nameEN", width: 174, align: "center"},
                    ]
                },
                {type: "RowSpacerItem"}
            ]
    });

    var ToolStripButton_Material_Refresh = isc.ToolStripButtonRefresh.create({
        //icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Material_refresh();
        }
    });

    var ToolStripButton_Material_Add = isc.ToolStripButtonAdd.create({
        //icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Material.clearValues();
            Window_Material.show();
        }
    });

    var ToolStripButton_Material_Edit = isc.ToolStripButtonEdit.create({
        //icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Material.clearValues();
            ListGrid_Material_edit();
        }
    });

    var ToolStripButton_Material_Remove = isc.ToolStripButtonRemove.create({
        //icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Material_remove();
        }
    });

    var ToolStrip_Actions_Material = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Material_Add,
                ToolStripButton_Material_Edit,
                ToolStripButton_Material_Remove,
                isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Material_Refresh,
                ]
                })

            ]
    });

    var HLayout_Material_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Material
            ]
    });

    var Window_Material = isc.Window.create({
        title: "<spring:message code='ProductGroup'/> ",
        width: 580,
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
                DynamicForm_Material,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_Material_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                ID: "materialExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Material.close();
                                }
                            })
                        ]
                })

            ]
    });
     var recordNotFound = isc.Label.create({
        height: 30,
        padding: 10,
        align: "center",
        valign: "center",
        wrap: false,
        contents: "رکوردی یافت نشد"
        })

    recordNotFound.hide();
    var ListGrid_Material = isc.ListGrid.create({
        width: "100%",
        height: 600,
        dataSource: RestDataSource_Material,
        contextMenu: Menu_ListGrid_Material,
        styleName:'expandList',
        autoFetchData: true,
        autoFitData: "vertical",
        //height: 150,
        alternateRecordStyles: true,
        canExpandRecords: true,
        canExpandMultipleRecords: false,
        wrapCells: false,
        showRollOver: false,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        autoFitExpandField: true,
        virtualScrolling: true,
        loadOnExpand: true,
        loaded: false,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='material.code'/>", align: "center"},
                {name: "descl", title: "<spring:message code='material.descl'/>", align: "center"},
                {name: "descp", title: "<spring:message code='material.descp'/>", align: "center"},
                {name: "unitnameFA", dataPath:"unit.nameFA"  , title: "<spring:message code='MaterialFeature.unit.FA'/>", align: "center"},
                {name: "unitnameEN", dataPath:"unit.nameEN"  , title: "<spring:message code='MaterialFeature.unit.ENG'/>", align: "center"},
            ],
        getExpansionComponent : function (record) {
            console.log(record)
            var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "materialId", operator: "equals", value: record.id}]
            };

            ListGrid_MaterialFeature.fetchRelatedData(record, function (dsResponse, data, dsRequest) {
                ListGrid_MaterialFeature.setData(data);
            }, {operationId: "00"});

            ListGrid_MaterialItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                console.log(data)
                if(data.length == 0){
                        recordNotFound.show();
                        ListGrid_MaterialItem.hide()
                        }else{
                            recordNotFound.hide();
                            ListGrid_MaterialItem.setData(data);
                            ListGrid_MaterialItem.setAutoFitMaxRecords(1);

                            ListGrid_MaterialItem.show();
}
            }, {operationId: "00"});


            var hLayout = isc.HLayout.create({
                align: "center",padding: 5,
                membersMargin: 20,
                members: [
                    ToolStripButton_MaterialItem_Add
                ]
                });

                var layout = isc.VLayout.create({
                    padding: 5,
                    membersMargin: 10,
                    members: [ ListGrid_MaterialItem, recordNotFound, hLayout ]
                });

        return layout;

           /*return   isc.ListGrid.create({
                        width: "100%",
                        height: "100%",
                        align: "right",
                        textAlign: "right",
                        dataSource: RestDataSource_MaterialItem_IN_MATERIAL,
                        contextMenu: Menu_ListGrid_MaterialItem,
                        initialCriteria: { _constructor: "AdvancedCriteria", operator: "and",
                        criteria: [
                            { fieldName: "materialId", operator: "equals", value: record.id },
                            ]
                        },
                        numCols: 2,
                        fields:
                        [
                            {name: "id", hidden: true, primaryKey: true},
                            {name: "materialId", type: "long", hidden: true},
                            {name: "gdsCode", width: "10%", title: "<spring:message code='MaterialItem.gdsCode'/> "},
                            {name: "gdsName", width: "10%", title: "<spring:message code='MaterialItem.gdsName'/> "},
                        ],
                        sortField: 0,
                        autoFetchData: true,
                        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
                        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
                            var record = this.getSelectedRecord();
                            loadWindowFeatureList(record.id)
                        }

                        });*/
        },
        /*recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",*/

        // updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        // var record = this.getSelectedRecord();
        // var criteria1 = {
        // _constructor: "AdvancedCriteria",
        // operator: "and",
        // criteria: [{fieldName: "materialId", operator: "equals", value: record.id}]
        // };
        // // ListGrid_MaterialFeature.fetchRelatedData(record, function (dsResponse, data, dsRequest) {
        // // ListGrid_MaterialFeature.setData(data);
        // // }, {operationId: "00"});
        //
        // ListGrid_MaterialItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
        //     console.log(data)
        // ListGrid_MaterialItem.setData(data);
        // }, {operationId: "00"});
        // },
        dataArrived: function (startRow, endRow) {
        }
    });


    var HLayout_Material_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Material
        ]
    });

    var VLayout_Material_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Material_Actions, HLayout_Material_Grid
        ]
    });

    // ----------------------------------------------------------------------------------------------------------------------
    function ListGrid_MaterialFeature_refresh() {
        ListGrid_MaterialFeature.invalidateCache();
        var record = ListGrid_Material.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "materialId", operator: "equals", value: record.id}]
        };
        ListGrid_MaterialFeature.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_MaterialFeature.setData(data);
        }, {operationId: "00"});
    };

    function ListGrid_MaterialFeature_add() {
        var record = ListGrid_Material.getSelectedRecord();

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
            DynamicForm_MaterialFeature.clearValues();
            DynamicForm_MaterialFeature.setValue("materialId", record.id);
            Window_MaterialFeature.show();
        }
    };

    function ListGrid_MaterialFeature_edit() {
        var record = ListGrid_MaterialFeature.getSelectedRecord();

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
            DynamicForm_MaterialFeature.editRecord(record);
            Window_MaterialFeature.show();
        }
    };

    function ListGrid_MaterialFeature_remove() {

        var record = ListGrid_MaterialFeature.getSelectedRecord();

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
                buttons: [isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}), isc.IButtonCancel.create({
                    title: "<spring:message
		code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var MaterialFeatureId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/materialFeature/" + MaterialFeatureId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_MaterialFeature_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                },

                            })
                        );
                    }
                }
            });
        }
    };
    var Menu_ListGrid_MaterialFeature = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_MaterialFeature_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    ListGrid_MaterialFeature_add();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_MaterialFeature_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_MaterialFeature_remove();
                }
            }
        ]
    });
    var DynamicForm_MaterialFeature = isc.DynamicForm.create({
        width: 750,
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
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true,},
                {name: "materialId", type: "long", hidden: true, wrapTitle: false},
                {type: "RowSpacerItem"},
                {
                    name: "itemRow",
                    title: "<spring:message code='contractItem.itemRow'/>",
                    required: true, wrapTitle: false, keyPressFilter: "[0-9]", length: "15",
                    width: 300,
                   hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,

},
                {
                    name: "featureId",
                    title: "<spring:message code='feature.nameFa'/>",
                    type: 'long', wrapTitle: false,
                    width: 300, required: true,
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Feature_IN_MATERIAL,
                    displayField: "nameFA"
                    ,
                    valueField: "id",
                    pickListWidth: 295,
                    pickListHeight: "650",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "id", width: 50, align: "center" , hidden: true}, {
                        name: "nameFA",
                        width: "10%",
                        align: "center"
                    }, {name: "nameEN", width: 150, align: "center" , width: "10%"  }, {name: "code", align: "center" ,  width: "10%"}]
                },
                {
                    name: "minValue",
                    title: "<spring:message code='MaterialFeature.minValue'/>",
                    type: 'float', wrapTitle: false, keyPressFilter: "[0-9.]", length: "15",
                    width: 300,
                 hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "maxValue",
                    title: "<spring:message code='MaterialFeature.maxValue'/>",
                    type: 'float', wrapTitle: false, keyPressFilter: "[0-9.]", length: "15",
                    width: 300,
                  hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },

                {
                    name: "avgValue",
                    title: "<spring:message code='MaterialFeature.avgValue'/>",
                    type: 'float', wrapTitle: false, keyPressFilter: "[0-9.]", length: "15",
                    width: 300,
                   hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='MaterialFeature.tolorance'/>",
                    type: 'float', wrapTitle: false, keyPressFilter: "[0-9.]", length: "15",
                    width: 300,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "rateId",
                    title: "<spring:message code='rate.nameFa'/>",
                    type: 'long', wrapTitle: false,
                    width: 300,
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Rate_IN_MATERIAL,
                    displayField: "nameFA"
                    ,
                    valueField: "id",
                    pickListWidth: "295",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "id", width: 50, align: "center" , hidden: true}, {
                        name: "nameFA",
                        width: "10%",
                        align: "center"
                    }, {name: "nameEN",  width: "10%" , align: "center"}, {name: "code",  width: "10%", align: "center"}]
                },

                {
                    name: "payableIfGraterThan",
                    title: "<spring:message code='MaterialFeature.payableIfGraterThan'/>",
                    type: 'float', wrapTitle: false, keyPressFilter: "[0-9.]", length: "15",
                    width: 300,

                    hint: "<spring:message code='Material.digit'/>", //TODO
                    showHintInField: true,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "paymentPercent",
                    title: "<spring:message code='MaterialFeature.paymentPercent'/>",
                    type: 'float', wrapTitle: false, keyPressFilter: "[0-9.]", length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "treatCost",
                    title: "<spring:message code='MaterialFeature.TC'/>",
                    type: 'float', keyPressFilter: "[0-9.]", length: "15",
                    width: 300,
                     hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    wrapTitle: false,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "refineryCost",
                    title: "<spring:message code='MaterialFeature.RC'/>",
                    type: 'float', keyPressFilter: "[0-9.]", length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    wrapTitle: false,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },

            ]
    });

    var ToolStripButton_MaterialFeature_Refresh = isc.ToolStripButtonRefresh.create({
        //icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_MaterialFeature_refresh();
        }
    });

    var ToolStripButton_MaterialFeature_Add = isc.ToolStripButtonAddLarge.create({
        //icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            ListGrid_MaterialFeature_add();
        }
    });

    var ToolStripButton_MaterialFeature_Edit = isc.ToolStripButtonEdit.create({
        //icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_MaterialFeature.clearValues();
            ListGrid_MaterialFeature_edit();
        }
    });

    var ToolStripButton_MaterialFeature_Remove = isc.ToolStripButtonRemove.create({
        //icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_MaterialFeature_remove();
        }
    });

    var ToolStrip_Actions_MaterialFeature = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_MaterialFeature_Add,
                ToolStripButton_MaterialFeature_Edit,
                ToolStripButton_MaterialFeature_Remove,
                isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_MaterialFeature_Refresh,
                ]
                })

            ]
    });

    var HLayout_MaterialFeature_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_MaterialFeature
            ]
    });

    var IButton_MaterialFeature_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_MaterialFeature.validate();
            if (DynamicForm_MaterialFeature.hasErrors())
                return;
            var data = DynamicForm_MaterialFeature.getValues();
            var minValue = DynamicForm_MaterialFeature.getValue("minValue");
            var maxValue = DynamicForm_MaterialFeature.getValue("maxValue");
            if (minValue > maxValue) {
                isc.say("<spring:message code='MaterialFeature.minValue.Error'/>.");
                return;
            }
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/materialFeature/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_MaterialFeature_refresh();
                            Window_MaterialFeature.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    },

                })
            );
        }
    });

    var MaterialFeatureCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_MaterialFeature.close();
        }
    });

    var HLayout_MaterialFeature_IButton = isc.HLayout.create({
        layoutMargin: 5,
        membersMargin: 5,
        width: "100%",
        members: [
            IButton_MaterialFeature_Save,
            MaterialFeatureCancelBtn
        ]
    });

    var Window_MaterialFeature = isc.Window.create({
        title: "<spring:message code='MaterialFeature.title'/> ",
        width: 580,
        // height: 500,
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
                DynamicForm_MaterialFeature,
                HLayout_MaterialFeature_IButton
            ]
    });













    var ListGrid_MaterialFeature = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_MaterialFeature,
        contextMenu: Menu_ListGrid_MaterialFeature,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true, primaryKey: true}, {name: "materialId", type: "long", hidden: true},
                {
                    name: "itemRow",
                    title: "<spring:message code='contractItem.itemRow'/> ",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "featurenameFA",   dataPath:"feature.nameFA"  ,
                    title: "<spring:message code='feature.nameFa'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "featurenameEN",  dataPath:"feature.nameEN"  ,
                    title: "<spring:message code='feature.nameEN'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "minValue",
                    title: "<spring:message code='MaterialFeature.minValue'/>",
                    type: 'float',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "maxValue",
                    title: "<spring:message code='MaterialFeature.maxValue'/>",
                    type: 'float',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "avgValue",
                    title: "<spring:message code='MaterialFeature.avgValue'/>",
                    type: 'float',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='MaterialFeature.tolorance'/>",
                    type: 'float',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "ratenameFA",  dataPath:"rate.nameFA"  ,
                    title: "<spring:message code='rate.nameFa'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "ratenameEN", dataPath:"rate.nameEN"  ,
                    title: "<spring:message code='rate.nameEN'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "payableIfGraterThan",
                    title: "<spring:message code='MaterialFeature.payableIfGraterThan'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "paymentPercent",
                    title: "<spring:message code='MaterialFeature.paymentPercent'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "treatCost",
                    title: "<spring:message code='MaterialFeature.TC'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "refineryCost",
                    title: "<spring:message code='MaterialFeature.RC'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {name: "editIcon", width: 40 , showTitle:false},
                {name: "removeIcon", width: 40 , showTitle:false},
            ],
        sortField: 0,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true,
    createRecordComponent : function (record, colNum) {
        var fieldName = this.getFieldName(colNum);
        var recordCanvas = isc.HLayout.create({
        height: 22,
        width: "100%",
        align: "center"
      });
    if(fieldName == "editIcon"){
    var editImg = isc.ImgButton.create({
        showDown: false,
        showRollOver: false,
        layoutAlign: "center",
        src: "pieces/16/icon_edit.png",
        prompt: "ویرایش",
        height: 16,
        width: 16,
        grid: this,
    click : function () {
        ListGrid_MaterialFeature.selectSingleRecord(record);
        ListGrid_MaterialFeature_edit();
    }
    });
     return editImg;
    } else  if (fieldName == "removeIcon") {
    var removeImg = isc.ImgButton.create({
        showDown: false,
        showRollOver: false,
        layoutAlign: "center",
        src: "pieces/16/icon_delete.png",
        prompt: "حذف",
        height: 16,
        width: 16,
        grid: this,
    click : function () {
        ListGrid_MaterialFeature.selectSingleRecord(record);
        ListGrid_MaterialFeature_remove();
    }
    });
        return removeImg;
        } else {
        return null;
        }
    },

    });



        var hLayoutMaterialFeature = isc.HLayout.create({
        align: "center",padding: 5,
        membersMargin: 10,
        members: [
              ToolStripButton_MaterialFeature_Add
        ]
        });

        var layoutMaterialFeature = isc.VLayout.create({
            membersMargin: 10,
            members: [ ListGrid_MaterialFeature, hLayoutMaterialFeature ]
        });

    var WindowFeature = isc.Window.create({
        title: "<spring:message code='MaterialFeature.title'/> ",
        width: "80%",
        height: "40%",
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
                ListGrid_MaterialFeature,
                layoutMaterialFeature
            ]
        });

    function loadWindowFeatureList(materialId){
            var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "materialId", operator: "equals", value: materialId}]
            };
            ListGrid_MaterialFeature.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                console.log(data)
            ListGrid_MaterialFeature.setData(data);
            }, {operationId: "00"});
            WindowFeature.show()
        }
var HLayout_MaterialFeature_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_MaterialFeature
        ]
    });
var VLayout_MaterialFeature_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_MaterialFeature_Actions, HLayout_MaterialFeature_Grid
        ]
    });

    function ListGrid_MaterialItem_refresh() {
        ListGrid_MaterialItem.invalidateCache();
        var record = ListGrid_Material.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "materialId", operator: "equals", value: record.id}]
        };
        ListGrid_MaterialItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_MaterialItem.setData(data);
        }, {operationId: "00"});
    };

    function ListGrid_MaterialItem_edit() {
        var record = ListGrid_MaterialItem.getSelectedRecord();

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
            DynamicForm_MaterialItem.editRecord(record);
            Window_MaterialItem.show();
        }
    };

    function ListGrid_MaterialItem_remove() {

        var record = ListGrid_MaterialItem.getSelectedRecord();

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
                buttons: [isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}), isc.IButtonCancel.create({
                    title: "<spring:message
		code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var MaterialItemId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/materialItem/" + MaterialItemId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_MaterialItem_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                },

                            })
                        );
                    }
                }
            });
        }
    };
    var Menu_ListGrid_MaterialItem = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_MaterialItem_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_MaterialItem.clearValues();
                    Window_MaterialItem.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_MaterialItem_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_MaterialItem_remove();
                }
            }
        ]
    });
    var DynamicForm_MaterialItem = isc.DynamicForm.create({
        width: 500,
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
        numCols: 2,
        fields:
            [
                 {name: "id", hidden: true,},
                 {name: "materialId", type: "long", hidden: true, wrapTitle: false},
                 {type: "RowSpacerItem"},
                 {name: "gdsCode", width: "300", title: "<spring:message code='MaterialItem.gdsCode'/> " , required:true   , keyPressFilter: "[0-9]" , length:"15"},
                 {name: "gdsName", width: "300", title: "<spring:message code='MaterialItem.gdsName'/> " , required:true , keyPressFilter: "[a-z|A-Z|0-9]" , lenght:"200"},
            ]
    });

    var ToolStripButton_MaterialItem_Refresh = isc.ToolStripButtonRefresh.create({
        //icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_MaterialItem_refresh();
        }
    });

    var ToolStripButton_MaterialItem_Add = isc.ToolStripButtonAddLarge.create({
        //icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_Material.getSelectedRecord();

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
                DynamicForm_MaterialItem.clearValues();
                DynamicForm_MaterialItem.setValue("materialId", record.id);
                Window_MaterialItem.show();
            }
        }
    });

    var ToolStripButton_MaterialItem_Edit = isc.ToolStripButtonEdit.create({
        //icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_MaterialItem.clearValues();
            ListGrid_MaterialItem_edit();
        }
    });

    var ToolStripButton_MaterialItem_Remove = isc.ToolStripButtonRemove.create({
        //icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_MaterialItem_remove();
        }
    });

    var ToolStrip_Actions_MaterialItem = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_MaterialItem_Add,
                ToolStripButton_MaterialItem_Edit,
                ToolStripButton_MaterialItem_Remove,
                isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_MaterialItem_Refresh,
                ]
                })

            ]
    });

    var HLayout_MaterialItem_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_MaterialItem
            ]
    });

    var IButton_MaterialItem_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_MaterialItem.validate();
            if (DynamicForm_MaterialItem.hasErrors())
                return;
            var data = DynamicForm_MaterialItem.getValues();
            var minValue = DynamicForm_MaterialItem.getValue("minValue");
            var maxValue = DynamicForm_MaterialItem.getValue("maxValue");
            if (minValue > maxValue) {
                isc.say("<spring:message code='MaterialItem.minValue.Error'/>.");
                return;
            }
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/materialItem/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_MaterialItem_refresh();
                            Window_MaterialItem.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    },

                })
            );
        }
    });

    var MaterialItemCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_MaterialItem.close();
        }
    });

    var HLayout_MaterialItem_IButton = isc.HLayout.create({
        layoutMargin: 5,
        membersMargin: 5,
        width: "100%",
        members: [
            IButton_MaterialItem_Save,
            MaterialItemCancelBtn
        ]
    });

    var Window_MaterialItem = isc.Window.create({
        title: "<spring:message code='ProductGroup'/> ",
        width: 580,
        // height: 500,
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
                DynamicForm_MaterialItem,
                HLayout_MaterialItem_IButton
            ]
    });

    var ListGrid_MaterialItem = isc.ListGrid.create({
        width: "100%",
        height: 180,
        dataSource: RestDataSource_MaterialItem_IN_MATERIAL,
        contextMenu: Menu_ListGrid_MaterialItem,
        setAutoFitExtraRecords: true,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true, primaryKey: true},
                {name: "materialId", type: "long", hidden: true},
                {name: "gdsCode", width: "48%", title: "<spring:message code='MaterialItem.gdsCode'/> "},
                {name: "gdsName", width: "48%", title: "<spring:message code='MaterialItem.gdsName'/> "},
                {name: "editIcon", width: "4%" , align:"center", showTitle:false},
                {name: "removeIcon", width: "4%" , align:"center", showTitle:false},
            ],
        sortField: 0,
        autoFetchData: false,
        recordDoubleClick: function(viewer, record, recordNum, field, fieldNum, value, rawValue){
            console.log(record)
           loadWindowFeatureList(record.materialId)
        },
        createRecordComponent : function (record, colNum) {
            var fieldName = this.getFieldName(colNum);
            var recordCanvas = isc.HLayout.create({
            height: 22,
            width: "100%",
            align: "center"
            });
            if(fieldName == "editIcon"){
                var editImg = isc.ImgButton.create({
                showDown: false,
                showRollOver: false,
                layoutAlign: "center",
                src: "pieces/16/icon_edit.png",
                prompt: "ویرایش",
                height: 16,
                width: 16,
                grid: this,
                    click : function () {
                        ListGrid_MaterialItem.selectSingleRecord(record);
                        ListGrid_MaterialItem_edit();
                    }
            });
                return editImg;
            } else  if (fieldName == "removeIcon") {
            var removeImg = isc.ImgButton.create({
                showDown: false,
                showRollOver: false,
                layoutAlign: "center",
                src: "pieces/16/icon_delete.png",
                prompt: "حذف",
                height: 16,
                width: 16,
                grid: this,
            click : function () {
                    ListGrid_MaterialItem.selectSingleRecord(record);
                    ListGrid_MaterialItem_remove();
            }
            });
            return removeImg;
            } else {
                return null;
                }
            }

    });
var HLayout_MaterialItem_Grid = isc.HLayout.create({
        width: "100%",
        members: [
            ListGrid_MaterialItem
        ]
    });
    var VLayout_MaterialItem_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_MaterialItem_Actions, HLayout_MaterialItem_Grid
        ]
    });

   isc.SectionStack.create({
        ID: "Material_Section_Stack",
        sections:
            [
                {title: "<spring:message code='ProductGroup'/>", items: VLayout_Material_Body, expanded: true}
                , {title: "<spring:message code='Product'/>", hidden: true, items: VLayout_MaterialItem_Body,expanded: false}
                , {title: "<spring:message code='ProductFeature'/>",hidden: true,items: VLayout_MaterialFeature_Body,expanded: false}
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });