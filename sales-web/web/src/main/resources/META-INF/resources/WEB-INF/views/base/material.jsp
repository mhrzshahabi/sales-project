<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

    <spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

    var RestDataSource_Material = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='material.code'/> "},
                {name: "descl", title: "<spring:message code='material.descl'/> "},
                {name: "descp", title: "<spring:message code='material.descp'/> "},
                {name: "unitId", title: "<spring:message code='MaterialFeature.unit'/> "},
                {name: "unit.nameEN", title: "<spring:message code='MaterialFeature.unit'/> "},
            ],
        fetchDataURL: "${restApiUrl}/api/material/spec-list"
    });

    var RestDataSource_Unit = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='unit.code'/> "},
                {name: "nameFA", title: "<spring:message code='unit.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='unit.nameEN'/> "},
                {name: "symbol", title: "<spring:message code='unit.symbol'/>"},
                {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
            ],
        fetchDataURL: "${restApiUrl}/api/unit/spec-list"
    });

    var RestDataSource_Rate = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='rate.code'/> "},
                {name: "nameFA", title: "<spring:message code='rate.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='rate.nameEN'/> "},
                {name: "symbol", title: "<spring:message code='rate.symbol'/>"},
                {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
            ],
        fetchDataURL: "${restApiUrl}/api/rate/spec-list"
    });

    var RestDataSource_Feature = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='feature.code'/> "},
                {name: "nameFA", title: "<spring:message code='feature.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='feature.nameEN'/> "},
                {name: "symbol", title: "<spring:message code='feature.symbol'/>"},
                {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
            ],
        fetchDataURL: "${restApiUrl}/api/feature/spec-list"
    });

    var RestDataSource_MaterialFeature = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "materialId", hidden: true},
            {name: "itemRow", title: "<spring:message code='contractItem.itemRow'/> "},
            {name: "featureId", type: 'text', width: 100},
            {name: "feature.nameFA", type: 'text', width: 100},
            {name: "feature.nameEN", type: 'text', width: 100},
            {name: "minValue", title: "<spring:message code='MaterialFeature.minValue'/> "},
            {name: "maxValue", title: "<spring:message code='MaterialFeature.maxValue'/> "},
            {name: "avgValue", title: "<spring:message code='MaterialFeature.avgValue'/>", type: 'float', width: 100},
            {name: "tolorance", title: "<spring:message code='MaterialFeature.tolorance'/>", type: 'float', width: 100},
            {name: "rate.nameFA", type: 'text', width: 100},
            {name: "rate.nameEN", type: 'text', width: 100},
            {name: "rateId", type: 'text', width: 100},
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
        fetchDataURL: "${restApiUrl}/api/materialFeature/spec-list"
    });

    var IButton_Material_Save = isc.IButton.create({
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
                    actionURL: "${restApiUrl}/api/material/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_Material_refresh();
                            Window_Material.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    function ListGrid_Material_refresh() {
        ListGrid_Material.invalidateCache();
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
                buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({
					title: "<spring:message
		code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var materialId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${restApiUrl}/api/material/" + materialId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_Material_refresh();
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
	};

    var Menu_ListGrid_Material = isc.Menu.create({
        width: 150,
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
        requiredMessage: "<spring:message code='validator.field.is.required'/>.",
        numCols: 1,
        fields:
            [
                {name: "id", hidden: true},
                {type: "RowSpacerItem"},
                {
                    name: "code",
                    title: "<spring:message code='material.code'/>",
                    type: 'long',
                    required: true,
                    width: 400,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "descl",
                    title: "<spring:message code='material.descl'/>",
                    type: 'text',
                    width: 400,
                    textAlign: "left"
                },
                {name: "descp", title: "<spring:message code='material.descp'/>", type: 'text', width: 400},
                {
                    name: "unitId",
                    title: "<spring:message code='unit.nameFa'/>",
                    type: 'long',
                    width: 400,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Unit,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [{name: "id", width: 50, align: "center"}, {
                        name: "nameFA",
                        width: 150,
                        align: "center"
                    }, {name: "nameEN", width: 150, align: "center"}, {name: "code", width: 150, align: "center"}]
                },
                {type: "RowSpacerItem"}
            ]
    });

    var ToolStripButton_Material_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Material_refresh();
        }
    });

    var ToolStripButton_Material_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Material.clearValues();
            Window_Material.show();
        }
    });

    var ToolStripButton_Material_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Material_edit();
        }
    });

    var ToolStripButton_Material_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Material_remove();
        }
    });

    var ToolStrip_Actions_Material = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Material_Refresh,
                ToolStripButton_Material_Add,
                ToolStripButton_Material_Edit,
                ToolStripButton_Material_Remove
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
        title: "<spring:message code='material.title'/> ",
        width: 580,
        hight: 500,
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
                            isc.IButton.create({
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

    var ListGrid_Material = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Material,
        contextMenu: Menu_ListGrid_Material,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='material.code'/>", align: "center"},
                {name: "descl", title: "<spring:message code='material.descl'/>", align: "center"},
                {name: "descp", title: "<spring:message code='material.descp'/>", align: "center"},
                {name: "unit.nameFA", title: "<spring:message code='MaterialFeature.unit'/>", align: "center"},
                {name: "unit.nameEN", title: "<spring:message code='MaterialFeature.unit'/>", align: "center"},
            ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        sortFieldAscendingText: "مرتب سازی صعودی",
        sortFieldDescendingText: "مرتب سازی نزولی",
        configureSortText: "تنظیم مرتب سازی",
        autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
        autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
        filterUsingText: "فیلتر کردن",
        groupByText: "گروه بندی",
        freezeFieldText: "ثابت نگه داشتن",
        startsWithTitle: "tt",
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "materialId", operator: "equals", value: record.id}]
            };
            ListGrid_MaterialFeature.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_MaterialFeature.setData(data);
            }, {operationId: "00"});
        },
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
                buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({
                    title: "<spring:message
		code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var MaterialFeatureId = record.id;
// ######@@@@###&&@@###
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
                                actionURL: "${restApiUrl}/api/materialFeature/" + MaterialFeatureId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_MaterialFeature_refresh();
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
                    DynamicForm_MaterialFeature.clearValues();
                    Window_MaterialFeature.show();
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
        requiredMessage: "<spring:message code='validator.field.is.required'/>.",
        numCols: 1,
        fields:
            [
                {name: "id", hidden: true,},
                {name: "materialId", type: "long", hidden: true, wrapTitle: false},
                {type: "RowSpacerItem"},
                {
                    name: "itemRow",
                    title: "<spring:message code='contractItem.itemRow'/>",
                    type: 'integer',
                    required: true, wrapTitle: false,
                    width: 400,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "featureId",
                    title: "<spring:message code='feature.nameFa'/>",
                    type: 'long', wrapTitle: false,
                    width: 400,
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Feature,
                    displayField: "nameFA"
                    ,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListheight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "id", width: 50, align: "center"}, {
                        name: "nameFA",
                        width: 150,
                        align: "center"
                    }, {name: "nameEN", width: 150, align: "center"}, {name: "code", width: 150, align: "center"}]
                },
                {
                    name: "minValue",
                    title: "<spring:message code='MaterialFeature.minValue'/>",
                    type: 'float', wrapTitle: false,
                    width: 400,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "maxValue",
                    title: "<spring:message code='MaterialFeature.maxValue'/>",
                    type: 'float', wrapTitle: false,
                    width: 400,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },

                {
                    name: "avgValue",
                    title: "<spring:message code='MaterialFeature.avgValue'/>",
                    type: 'float', wrapTitle: false,
                    width: 400,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='MaterialFeature.tolorance'/>",
                    type: 'float', wrapTitle: false,
                    width: 400,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "rateId",
                    title: "<spring:message code='rate.nameFa'/>",
                    type: 'long', wrapTitle: false,
                    width: 400,
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Rate,
                    displayField: "nameFA"
                    ,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListheight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "id", width: 50, align: "center"}, {
                        name: "nameFA",
                        width: 150,
                        align: "center"
                    }, {name: "nameEN", width: 150, align: "center"}, {name: "code", width: 150, align: "center"}]
                },

                {
                    name: "payableIfGraterThan",
                    title: "<spring:message code='MaterialFeature.payableIfGraterThan'/>",
                    type: 'float', wrapTitle: false,
                    width: 400,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "paymentPercent",
                    title: "<spring:message code='MaterialFeature.paymentPercent'/>",
                    type: 'float', wrapTitle: false,
                    width: 400,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "treatCost",
                    title: "<spring:message code='MaterialFeature.TC'/>",
                    type: 'float',
                    width: 400,
                    wrapTitle: false,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "refineryCost",
                    title: "<spring:message code='MaterialFeature.RC'/>",
                    type: 'float',
                    width: 400,
                    wrapTitle: false,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },

            ]
    });

    var ToolStripButton_MaterialFeature_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_MaterialFeature_refresh();
        }
    });

    var ToolStripButton_MaterialFeature_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
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
                DynamicForm_MaterialFeature.clearValues();
                DynamicForm_MaterialFeature.setValue("materialId", record.id);
                Window_MaterialFeature.show();
            }
        }
    });

    var ToolStripButton_MaterialFeature_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_MaterialFeature_edit();
        }
    });

    var ToolStripButton_MaterialFeature_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_MaterialFeature_remove();
        }
    });

    var ToolStrip_Actions_MaterialFeature = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_MaterialFeature_Refresh,
                ToolStripButton_MaterialFeature_Add,
                ToolStripButton_MaterialFeature_Edit,
                ToolStripButton_MaterialFeature_Remove
            ]
    });

    var HLayout_MaterialFeature_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_MaterialFeature
            ]
    });

    var IButton_MaterialFeature_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_MaterialFeature.validate();
            if (DynamicForm_MaterialFeature.hasErrors())
                return;
            var data = DynamicForm_MaterialFeature.getValues();
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${restApiUrl}/api/materialFeature/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_MaterialFeature_refresh();
                            Window_MaterialFeature.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var MaterialFeatureCancelBtn = isc.IButton.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
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
        hight: 500,
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
        fields:
            [
                {name: "id", hidden: true, primaryKey: true}, {name: "materialId", type: "long", hidden: true},
                {
                    name: "itemRow",
                    title: "<spring:message code='contractItem.itemRow'/> ",
                    type: 'text',
                    width: "3%",
                    align: "center"
                },
                {
                    name: "feature.nameFA",
                    title: "<spring:message code='feature.nameFa'/>",
                    type: 'text',
                    width: "12%",
                    align: "center"
                },
                {
                    name: "feature.nameEN",
                    title: "<spring:message code='feature.nameEN'/>",
                    type: 'text',
                    width: "12%",
                    align: "center"
                },
                {
                    name: "minValue",
                    title: "<spring:message code='MaterialFeature.minValue'/>",
                    type: 'float',
                    width: "5%",
                    align: "center"
                },
                {
                    name: "maxValue",
                    title: "<spring:message code='MaterialFeature.maxValue'/>",
                    type: 'float',
                    width: "5%",
                    align: "center"
                },
                {
                    name: "avgValue",
                    title: "<spring:message code='MaterialFeature.avgValue'/>",
                    type: 'float',
                    width: "5%",
                    align: "center"
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='MaterialFeature.tolorance'/>",
                    type: 'float',
                    width: "5%",
                    align: "center"
                },
                {
                    name: "rate.nameFA",
                    title: "<spring:message code='rate.nameFa'/>",
                    type: 'text',
                    width: "8%",
                    align: "center"
                },
                {
                    name: "rate.nameEN",
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
                    width: "12%",
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
            ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true,
        sortFieldAscendingText: "مرتب سازی صعودی",
        sortFieldDescendingText: "مرتب سازی نزولی",
        configureSortText: "تنظیم مرتب سازی",
        autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
        autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
        filterUsingText: "فیلتر کردن",
        groupByText: "گروه بندی",
        freezeFieldText: "ثابت نگه داشتن",
        startsWithTitle: "tt"
    });
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
    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    isc.SectionStack.create({
        ID: "Material_Section_Stack",
        sections:
            [
                {title: "<spring:message code='Product'/>", items: VLayout_Material_Body, expanded: true}
                , {
                title: "<spring:message code='ProductFeature'/>",
                items: VLayout_MaterialFeature_Body,
                expanded: true
            }
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });