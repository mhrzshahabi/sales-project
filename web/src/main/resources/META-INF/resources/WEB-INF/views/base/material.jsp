<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Material = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='material.code'/> "
                },
                {
                    name: "descl",
                    title: "<spring:message code='material.descl'/> "
                },
                {
                    name: "descp",
                    title: "<spring:message code='material.descp'/> "
                },
                {
                    name: "unitId",
                    title: "<spring:message code='MaterialFeature.unit'/>"
                },
                {
                    name: "unit.nameFA",
                    title: "<spring:message code='MaterialFeature.unit.FA'/>",
                    align: "center"
                },
                {
                    name: "unit.nameEN",
                    title: "<spring:message code='MaterialFeature.unit'/> "
                },
            ],
            fetchDataURL: "${contextPath}/api/material/spec-list"
        });

    var RestDataSource_Unit_IN_MATERIAL = isc.MyRestDataSource.create(
        {
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
                    title: "<spring:message code='MaterialFeature.unit.FA'/> "
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='unit.nameEN'/> "
                },
                {
                    name: "symbol",
                    title: "<spring:message code='unit.symbol'/>"
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>"
                }],
            fetchDataURL: "${contextPath}/api/unit/spec-list"
        });

    var RestDataSource_Rate_IN_MATERIAL = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='rate.code'/> "
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='rate.nameFa'/> "
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='rate.nameEN'/> "
                },
                {
                    name: "symbol",
                    title: "<spring:message code='rate.symbol'/>"
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>"
                }],
            fetchDataURL: "${contextPath}/api/rate/spec-list"
        });

    var RestDataSource_Feature_IN_MATERIAL = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='feature.code'/> "
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='feature.nameFa'/> "
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='feature.nameEN'/> "
                },
                {
                    name: "symbol",
                    title: "<spring:message code='feature.symbol'/>"
                },
                {
                    name: "decimalDigit",
                    title: "<spring:message code='rate.decimalDigit'/>"
                }],
            fetchDataURL: "${contextPath}/api/feature/spec-list"
        });

    var RestDataSource_MaterialItem_IN_MATERIAL = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "gdsCode",
                    title: "<spring:message code='MaterialItem.gdsCode'/> "
                },
                {
                    name: "gdsName",
                    title: "<spring:message code='MaterialItem.gdsName'/> "
                },
                {
                    name: "materialId",
                    hidden: true
                },],
            fetchDataURL: "${contextPath}/api/materialItem/spec-list"
        });

    var RestDataSource_MaterialFeature = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "materialId",
                    hidden: true
                },
                {
                    name: "itemRow",
                    title: "<spring:message code='contractItem.itemRow'/> "
                },
                {
                    name: "featureId",
                    type: 'text',
                    width: 100
                },
                {
                    name: "feature.nameFA",
                    type: 'text',
                    width: 100,
                },
                {
                    name: "feature.nameEN",
                    type: 'text',
                    width: 100,
                },
                {
                    name: "minValue",
                    title: "<spring:message code='MaterialFeature.minValue'/> "
                },
                {
                    name: "maxValue",
                    title: "<spring:message code='MaterialFeature.maxValue'/> "
                },
                {
                    name: "avgValue",
                    title: "<spring:message code='MaterialFeature.avgValue'/>",
                    type: 'float',
                    width: 100
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='MaterialFeature.tolorance'/>",
                    type: 'float',
                    width: 100
                },
                {
                    name: "rate.nameFA",
                    type: 'text',
                    width: 100,
                },
                {
                    name: "rate.nameEN",
                    type: 'text',
                    width: 100,
                },
                {
                    name: "rateId",
                    type: 'text',
                    width: 100
                },
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
                {
                    name: "treatCost",
                    title: "<spring:message code='MaterialFeature.TC'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "refineryCost",
                    title: "<spring:message code='MaterialFeature.RC'/>",
                    type: 'text',
                    width: 400
                },],
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
                            isc.say("<spring:message code='global.form.request.successful'/>");
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
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
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
    }

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
                <sec:authorize access="hasAuthority('C_MATERIAL')">
                {
                    title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                    click: function () {
                        DynamicForm_Material.clearValues();
                        Window_Material.show();
                    }
                },
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_MATERIAL')">
                {
                    title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_Material_edit();
                    }
                },
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_MATERIAL')">
                {
                    title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_Material_remove();
                    }
                }
                </sec:authorize>
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
                {

                    name: "code",
                    title: "<spring:message code='material.code'/>",
                    required: true,
                    width: 400,
                    length: "20",
                    keyPressFilter: "[0-9]",
                    validators: [{
                        type: "number",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    hint: "<spring:message code='global.didit'/>",
                    showHintInField: true,
                },
                {
                    name: "descl",
                    title: "<spring:message code='material.descl'/>",
                    type: 'text',
                    width: 400, required: true,
                    length: 200,
                    requiredTitlePrefix: "<span style='color:#ff0842;font-size:22px; padding-left: 2px;'>*</span>",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    textAlign: "left"
                },
                {
                    name: "descp",
                    title: "<spring:message code='material.descp'/>",
                    type: 'text',
                    width: 400,
                    required: true,
                    length: 200,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
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
                    required: true,
                    pickListWidth: "400",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "id", align: "center", hidden: true},
                        {name: "nameFA", width: 195, align: "center"},
                        {name: "nameEN", width: 195, align: "center"},
                    ],
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    type: "RowSpacerItem"
                }
            ]
    });

    var ToolStripButton_Material_Refresh = isc.ToolStripButtonRefresh.create({
        //icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Material_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_MATERIAL')">
    var ToolStripButton_Material_Add = isc.ToolStripButtonAdd.create({
        //icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Material.clearValues();
            Window_Material.show();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_MATERIAL')">
    var ToolStripButton_Material_Edit = isc.ToolStripButtonEdit.create({
        //icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Material.clearValues();
            ListGrid_Material_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_MATERIAL')">
    var ToolStripButton_Material_Remove = isc.ToolStripButtonRemove.create({
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Material_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_Material = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <sec:authorize access="hasAuthority('C_MATERIAL')">
                ToolStripButton_Material_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_MATERIAL')">
                ToolStripButton_Material_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_MATERIAL')">
                ToolStripButton_Material_Remove,
                </sec:authorize>

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
                    align: "center",
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
        contents: "<spring:message code='global.record.find'/>"
    });

    recordNotFound.hide();

    var ListGrid_Material = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Material,
        contextMenu: Menu_ListGrid_Material,
        styleName: 'expandList',
        autoFetchData: true,
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
        sortField: 2,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='material.code'/>", align: "center", showIf: "false",},
                {name: "descl", title: "<spring:message code='material.descl'/>", align: "center"},
                {name: "descp", title: "<spring:message code='material.descp'/>", align: "center"},
                {
                    name: "unit.nameFA", title: "<spring:message code='MaterialFeature.unit.FA'/>", align: "center",
                    sortNormalizer: function (recordObject) {
                        return recordObject.unit.nameFA;
                    }
                },
                {
                    name: "unit.nameEN", title: "<spring:message code='MaterialFeature.unit.ENG'/>", align: "center",
                    sortNormalizer: function (recordObject) {
                        return recordObject.unit.nameEN;
                    }
                },
            ],
        getExpansionComponent: function (record) {
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "materialId", operator: "equals", value: record.id}]
            };

            ListGrid_MaterialFeature.fetchRelatedData(record, function (dsResponse, data, dsRequest) {
                ListGrid_MaterialFeature.setData(data);
            }, {operationId: "00"});

            ListGrid_MaterialItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                if (data.length == 0) {
                    recordNotFound.show();
                    ListGrid_MaterialItem.hide()
                } else {
                    recordNotFound.hide();
                    ListGrid_MaterialItem.setData(data);
                    ListGrid_MaterialItem.setAutoFitMaxRecords(1);

                    ListGrid_MaterialItem.show();
                }
            }, {operationId: "00"});


            var hLayout = isc.HLayout.create({
                align: "center", padding: 5,
                membersMargin: 20,
                members: [
                    <sec:authorize access="hasAuthority('C_MATERIAL_ITEM')">
                    ToolStripButton_MaterialItem_Add
                    </sec:authorize>
                ]
            });

            var layoutMaterial = isc.VLayout.create({
                styleName: "expand-layout",
                padding: 5,
                membersMargin: 10,
                members: [ListGrid_MaterialItem, recordNotFound, hLayout]
            });

            return layoutMaterial;
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
        height: "99%",
        overflow: "scroll",
        members: [
            HLayout_Material_Actions, HLayout_Material_Grid
        ]
    });


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
    }

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
    }

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
    }


    function ListGrid_MaterialFeature_remove() {

        var record = ListGrid_MaterialFeature.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/>"
                        })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
        }
        else {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.remove.ask'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                    buttons: [isc.IButtonSave.create(
                        {
                            title: "<spring:message code='global.yes'/>"
                        }), isc.IButtonCancel.create(
                        {
                            title: "<spring:message code = 'global.no'/> "

                        })],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var MaterialFeatureId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/materialFeature/" + MaterialFeatureId,
                                    httpMethod: "DELETE",
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                            ListGrid_MaterialFeature_refresh();
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                        }
                                        else {
                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                        }
                                    },

                                }));
                        }
                    }
                });
        }
    }

    var Menu_ListGrid_MaterialFeature = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_MaterialFeature_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_FEATURE')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    ListGrid_MaterialFeature_add();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_FEATURE')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_MaterialFeature_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_FEATURE')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_MaterialFeature_remove();
                }
            }
            </sec:authorize>
        ]
    });

    var DynamicForm_MaterialFeature = isc.DynamicForm.create(
        {
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
            fields: [
                {
                    name: "id",
                    hidden: true,
                },
                {
                    name: "materialId",
                    type: "long",
                    hidden: true,
                    wrapTitle: false
                },
                {
                    name: "itemRow",
                    title: "<spring:message code='contractItem.itemRow'/>",
                    required: true,
                    wrapTitle: false,
                    keyPressFilter: "[0-9]",
                    length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "featureId",
                    title: "<spring:message code='feature.nameFa'/>",
                    type: 'long',
                    wrapTitle: false,
                    width: 300,
                    required: true,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Feature_IN_MATERIAL,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: 295,
                    pickListHeight: "650",
                    pickListProperties:
                        {
                            showFilterEditor: true
                        },
                    pickListFields: [
                        {
                            name: "id",
                            width: 50,
                            align: "center",
                            hidden: true
                        },
                        {
                            name: "nameFA",
                            width: "10%",
                            align: "center"
                        },
                        {
                            name: "nameEN",
                            align: "center",
                            width: "10%"
                        },
                        {
                            name: "code",
                            align: "center",
                            width: "10%",
                            showIf: "true",
                        }],
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "minValue",
                    title: "<spring:message code='MaterialFeature.minValue'/>",
                    type: 'float',
                    wrapTitle: false,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    name: "maxValue",
                    title: "<spring:message code='MaterialFeature.maxValue'/>",
                    type: 'float',
                    wrapTitle: false,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },

                {
                    name: "avgValue",
                    title: "<spring:message code='MaterialFeature.avgValue'/>",
                    type: 'float',
                    wrapTitle: false,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='MaterialFeature.tolorance'/>",
                    type: 'float',
                    wrapTitle: false,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    width: 300,
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    name: "rateId",
                    title: "<spring:message code='rate.nameFa'/>",
                    type: 'long',
                    wrapTitle: false,
                    width: 300,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Rate_IN_MATERIAL,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "295",
                    pickListHeight: "500",
                    pickListProperties:
                        {
                            showFilterEditor: true
                        },
                    pickListFields: [
                        {
                            name: "id",
                            width: 50,
                            align: "center",
                            hidden: true
                        },
                        {
                            name: "nameFA",
                            width: "10%",
                            align: "center"
                        },
                        {
                            name: "nameEN",
                            width: "10%",
                            align: "center"
                        },
                        {
                            name: "code",
                            width: "10%",
                            align: "center", showIf: "false",
                        }]
                },

                {
                    name: "payableIfGraterThan",
                    title: "<spring:message code='MaterialFeature.payableIfGraterThan'/>",
                    type: 'float',
                    wrapTitle: false,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    name: "paymentPercent",
                    title: "<spring:message code='MaterialFeature.paymentPercent'/>",
                    type: 'float',
                    wrapTitle: false,
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    name: "treatCost",
                    title: "<spring:message code='MaterialFeature.TC'/>",
                    type: 'float',
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    wrapTitle: false,
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    name: "refineryCost",
                    title: "<spring:message code='MaterialFeature.RC'/>",
                    type: 'float',
                    keyPressFilter: "[0-9.]",
                    length: "15",
                    width: 300,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true,
                    wrapTitle: false,
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },

            ]
        });

    var ToolStripButton_MaterialFeature_Refresh = isc.ToolStripButtonRefresh.create({

        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_MaterialFeature_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_FEATURE')">
    var ToolStripButton_MaterialFeature_Add = isc.ToolStripButtonAddLarge.create({

        title: "<spring:message code='global.form.new'/>",
        click: function () {
            ListGrid_MaterialFeature_add();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_FEATURE')">
    var ToolStripButton_MaterialFeature_Edit = isc.ToolStripButtonEdit.create({

        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_MaterialFeature.clearValues();
            ListGrid_MaterialFeature_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_FEATURE')">
    var ToolStripButton_MaterialFeature_Remove = isc.ToolStripButtonRemove.create({

        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_MaterialFeature_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_MaterialFeature = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <sec:authorize access="hasAuthority('C_FEATURE')">
                ToolStripButton_MaterialFeature_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_FEATURE')">
                ToolStripButton_MaterialFeature_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_FEATURE')">
                ToolStripButton_MaterialFeature_Remove,
                </sec:authorize>

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

    var IButton_MaterialFeature_Save = isc.IButtonSave.create(
        {
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
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/materialFeature/",
                        httpMethod: methodXXXX,
                        data: JSON.stringify(data),
                        callback: function (RpcResponse_o) {
                            if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_MaterialFeature_refresh();
                                Window_MaterialFeature.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        },

                    }));
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

    var Window_MaterialFeature = isc.Window.create(
        {
            title: "<spring:message code='MaterialFeature.title'/> ",
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
            items: [
                DynamicForm_MaterialFeature,
                HLayout_MaterialFeature_IButton
            ]
        });

    var ListGrid_MaterialFeature = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_MaterialFeature,
            contextMenu: Menu_ListGrid_MaterialFeature,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            numCols: 2,
            fields: [
                {
                    name: "id",
                    hidden: true,
                    primaryKey: true
                },
                {
                    name: "materialId",
                    type: "long",
                    hidden: true
                },
                {
                    name: "itemRow",
                    title: "<spring:message code='contractItem.itemRow'/> ",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "feature.nameFA",
                    title: "<spring:message code='feature.nameFa'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "feature.nameEN",
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
                    name: "rate.nameFA",
                    title: "<spring:message code='rate.nameFa'/>",
                    type: 'text',
                    width: "10%",
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
                {
                    name: "editIcon",
                    width: 40,
                    showTitle: false
                },
                {
                    name: "removeIcon",
                    width: 40,
                    showTitle: false
                },],
            sortField: 0,
            autoFetchData: false,
            showFilterEditor: true,
            filterOnKeypress: true,
            createRecordComponent: function (record, colNum) {
                var fieldName = this.getFieldName(colNum);
                var recordCanvas = isc.HLayout.create(
                    {
                        height: 22,
                        width: "100%",
                        align: "center"
                    });
                if (fieldName == "editIcon") {
                    var editImg = isc.ImgButton.create(
                        {
                            showDown: false,
                            showRollOver: false,
                            layoutAlign: "center",
                            src: "pieces/16/icon_edit.png",
                            prompt: "ویرایش",
                            height: 16,
                            width: 16,
                            grid: this,
                            click: function () {
                                ListGrid_MaterialFeature.selectSingleRecord(record);
                                ListGrid_MaterialFeature_edit();
                            }
                        });
                    return editImg;
                }
                else if (fieldName == "removeIcon") {
                    var removeImg = isc.ImgButton.create(
                        {
                            showDown: false,
                            showRollOver: false,
                            layoutAlign: "center",
                            src: "pieces/16/icon_delete.png",
                            prompt: "حذف",
                            height: 16,
                            width: 16,
                            grid: this,
                            click: function () {
                                ListGrid_MaterialFeature.selectSingleRecord(record);
                                ListGrid_MaterialFeature_remove();
                            }
                        });
                    return removeImg;
                }
                else {
                    return null;
                }
            },

        });

    var hLayoutMaterialFeature = isc.HLayout.create({
        align: "center", padding: 5,
        membersMargin: 10,
        members: [
            <sec:authorize access="hasAuthority('C_FEATURE')">
            ToolStripButton_MaterialFeature_Add
            </sec:authorize>
        ]
    });

    var layoutMaterialFeature = isc.VLayout.create({
        membersMargin: 10,
        members: [ListGrid_MaterialFeature, hLayoutMaterialFeature]
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

    function loadWindowFeatureList(materialId) {
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [
                {
                    fieldName: "materialId",
                    operator: "equals",
                    value: materialId
                }]
        };
        ListGrid_MaterialFeature.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_MaterialFeature.setData(data);
            },
            {
                operationId: "00"
            });
        WindowFeature.show()
    }

    var HLayout_MaterialFeature_Grid = isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                ListGrid_MaterialFeature
            ]
        });
    var VLayout_MaterialFeature_Body = isc.VLayout.create(
        {
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
    }

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
    }

    function ListGrid_MaterialItem_remove() {

        var record = ListGrid_MaterialItem.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/>"
                        })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
        }
        else {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.remove.ask'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                    buttons: [isc.IButtonSave.create(
                        {
                            title: "<spring:message code='global.yes'/>"
                        }), isc.IButtonCancel.create(
                        {
                            title: "<spring:message code = 'global.no' /> "

                        })],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var MaterialItemId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/materialItem/" + MaterialItemId,
                                    httpMethod: "DELETE",
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                            ListGrid_MaterialItem_refresh();
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                        }
                                        else {
                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                        }
                                    },

                                }));
                        }
                    }
                });
        }
    }

    var Menu_ListGrid_MaterialItem = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_MaterialItem_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_MATERIAL_ITEM')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_MaterialItem.clearValues();
                    Window_MaterialItem.show();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_MATERIAL_ITEM')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_MaterialItem_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_MATERIAL_ITEM')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_MaterialItem_remove();
                }
            }
            </sec:authorize>
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
                {
                    name: "gdsCode",
                    width: "300",
                    title: "<spring:message code='MaterialItem.gdsCode'/> ",
                    required: true,
                    keyPressFilter: "[0-9]",
                    length: "15",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    textAlign: "left"
                },
                {
                    name: "gdsName",
                    width: "300",
                    title: "<spring:message code='MaterialItem.gdsName'/> ",
                    required: true,
                    length: "200",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
            ]
    });

    var ToolStripButton_MaterialItem_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_MaterialItem_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_MATERIAL_ITEM')">
    var ToolStripButton_MaterialItem_Add = isc.ToolStripButtonAddLarge.create({
        title: "<spring:message code='global.form.new.sub'/>",
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
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_MATERIAL_ITEM')">
    var ToolStripButton_MaterialItem_Edit = isc.ToolStripButtonEdit.create({
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_MaterialItem.clearValues();
            ListGrid_MaterialItem_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_MATERIAL_ITEM')">
    var ToolStripButton_MaterialItem_Remove = isc.ToolStripButtonRemove.create({
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_MaterialItem_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_MaterialItem = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <sec:authorize access="hasAuthority('C_MATERIAL_ITEM')">
                ToolStripButton_MaterialItem_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_MATERIAL_ITEM')">
                ToolStripButton_MaterialItem_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_MATERIAL_ITEM')">
                ToolStripButton_MaterialItem_Remove,
                </sec:authorize>

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

    function setCriteria_ListGrid(recordId) {
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "materialId", operator: "equals", value: recordId}]
        };

        ListGrid_MaterialItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_MaterialItem.setData(data);
            ListGrid_MaterialItem.show();
        }, {operationId: "00"});
    }

    var IButton_MaterialItem_Save = isc.IButtonSave.create(
        {
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
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/materialItem/",
                        httpMethod: methodXXXX,
                        data: JSON.stringify(data),
                        callback: function (RpcResponse_o) {
                            if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_MaterialItem.invalidateCache();
                                setCriteria_ListGrid(data.materialId)
                                Window_MaterialItem.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        },

                    }));
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
        membersMargin: 15,
        width: "100%",
        height: "100%",
        align: "center",
        members: [
            IButton_MaterialItem_Save,
            MaterialItemCancelBtn
        ]
    });

    var Window_MaterialItem = isc.Window.create({
        title: "<spring:message code='ProductFeature'/> ",
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
                DynamicForm_MaterialItem,
                HLayout_MaterialItem_IButton
            ]
    });

    var ListGrid_MaterialItem = isc.ListGrid.create(
        {
            width: "100%",
            styleName: "listgrid-child",
            height: 180,
            dataSource: RestDataSource_MaterialItem_IN_MATERIAL,
            contextMenu: Menu_ListGrid_MaterialItem,
            setAutoFitExtraRecords: true,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            numCols: 2,
            fields: [
                {
                    name: "id",
                    hidden: true,
                    primaryKey: true
                },
                {
                    name: "materialId",
                    type: "long",
                    hidden: true
                },
                {
                    name: "gdsCode",
                    width: "48%",
                    title: "<spring:message code='MaterialItem.gdsCode'/> ", showIf: "false",
                },
                {
                    name: "gdsName",
                    width: "48%",
                    title: "<spring:message code='MaterialItem.gdsName'/> "
                },
                {
                    name: "editIcon",
                    width: "4%",
                    align: "center",
                    showTitle: false
                },
                {
                    name: "removeIcon",
                    width: "4%",
                    align: "center",
                    showTitle: false
                }
            ],
            sortField: 0,
            autoFetchData: false,
            recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                loadWindowFeatureList(record.materialId)
            },
            createRecordComponent: function (record, colNum) {
                var fieldName = this.getFieldName(colNum);
                var recordCanvas = isc.HLayout.create(
                    {
                        height: 22,
                        width: "100%",
                        align: "center"
                    });
                if (fieldName == "editIcon") {
                    var editImg = isc.ImgButton.create(
                        {
                            showDown: false,
                            showRollOver: false,
                            layoutAlign: "center",
                            src: "pieces/16/icon_edit.png",
                            prompt: "ویرایش",
                            height: 16,
                            width: 16,
                            grid: this,
                            click: function () {
                                ListGrid_MaterialItem.selectSingleRecord(record);
                                ListGrid_MaterialItem_edit();
                            }
                        });
                    return editImg;
                }
                else if (fieldName == "removeIcon") {
                    var removeImg = isc.ImgButton.create(
                        {
                            showDown: false,
                            showRollOver: false,
                            layoutAlign: "center",
                            src: "pieces/16/icon_delete.png",
                            prompt: "حذف",
                            height: 16,
                            width: 16,
                            grid: this,
                            click: function () {
                                ListGrid_MaterialItem.selectSingleRecord(record);
                                ListGrid_MaterialItem_remove();
                            }
                        });
                    return removeImg;
                }
                else {
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

    isc.SectionStack.create(
        {
            ID: "Material_Section_Stack",
            sections: [
                {
                    title: "<spring:message code='ProductGroup'/>",
                    items: VLayout_Material_Body,
                    showHeader: false,
                    expanded: true
                },
                {
                    title: "<spring:message code='Product'/>",
                    hidden: true,
                    items: VLayout_MaterialItem_Body,
                    expanded: false
                },
                {
                    title: "<spring:message code='ProductFeature'/>",
                    hidden: true,
                    items: VLayout_MaterialFeature_Body,
                    expanded: false
                }],
            visibilityMode: "multiple",
            animateSections: true,
            height: "100%",
            width: "100%",
            overflow: "hidden"
        });