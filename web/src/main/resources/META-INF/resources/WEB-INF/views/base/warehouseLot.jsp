<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Material_IN_WAREHOUSELOT = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "code",
            title: "<spring:message code='material.code'/> "
        }, {
            name: "descl",
            title: "<spring:message code='material.descl'/> "
        }, {
            name: "descp",
            title: "<spring:message code='material.descp'/> "
        }, {
            name: "unitId",
            title: "<spring:message code='MaterialFeature.unit'/>"
        }, {
            name: "unitnameEN", dataPath: "unit.nameEN",
            title: "<spring:message code='MaterialFeature.unit'/> "
        },],
        fetchDataURL: "${contextPath}/api/material/spec-list"
    });

    function ListGrid_WarehouseLot_refresh() {
        ListGrid_WarehouseLot.invalidateCache();
    }

    var RestDataSource_WarehouseLot = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "warehouseNo",
            title: "<spring:message code='dailyWarehouse.warehouse'/>",
            align: "center"
        }, {
            name: "plant",
            title: "<spring:message code='dailyWarehouse.plant'/>",
            align: "center"
        }, {
            name: "materialdescl", dataPath: "material.descl",
            title: "<spring:message code='goods.nameLatin'/> "
        }, {
            name: "lotName",
            title: "<spring:message code='warehouseLot.lotName'/>",
            align: "center"
        }, {
            name: "mo",
            title: "<spring:message code='warehouseLot.mo'/>",
            align: "center"
        }, {
            name: "cu",
            title: "<spring:message code='warehouseLot.cu'/>",
            align: "center"
        }, {
            name: "si",
            title: "<spring:message code='warehouseLot.si'/>",
            align: "center"
        }, {
            name: "pb",
            title: "<spring:message code='warehouseLot.pb'/>",
            align: "center"
        }, {
            name: "s",
            title: "<spring:message code='warehouseLot.s'/>",
            align: "center"
        }, {
            name: "c",
            title: "<spring:message code='warehouseLot.c'/>",
            align: "center"
        }, {
            name: "p",
            title: "<spring:message code='warehouseLot.p'/>",
            align: "center"
        }, {
            name: "size1",
            title: "<spring:message code='warehouseLot.size1'/>",
            align: "center"
        }, {
            name: "size1Value",
            title: "<spring:message code='warehouseLot.size1Value'/>",
            align: "center"
        }, {
            name: "size2",
            title: "<spring:message code='warehouseLot.size2'/>",
            align: "center"
        }, {
            name: "size2Value",
            title: "<spring:message code='warehouseLot.size2Value'/>",
            align: "center"
        }, {
            name: "weightKg",
            title: "<spring:message code='warehouseLot.weightKg'/>",
            align: "center"
        }, {
            name: "grossWeight",
            title: "<spring:message code='grossWeight.weightKg'/>",
            align: "center"
        }, {
            name: "contractId",
            title: "<spring:message code='contract.id'/>",
            align: "center"
        }, {
            name: "used",
            title: "<spring:message code='contract.used'/>",
            align: "center"
        }, {
            name: "bookingNo",
            title: "bookingNo",
            align: "center"
        }

        ],
        fetchDataURL: "${contextPath}/api/warehouseLot/spec-list"
    });

    var WarehouseLotData = [];
    for (i = 0; i < 100; i++) {
        WarehouseLotData.add({id: i});
    }

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

    var Menu_ListGrid_WarehouseLot = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_WarehouseLot_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_WarehouseLot_edit();
                }
            }
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
        fields: [
            {
                name: "id",
                title: "id",
                primaryKey: true,
                canEdit: false,
                hidden: true
            }, {
                name: "warehouseNo",
                title: "<spring:message code='dailyWarehouse.warehouse'/>",
                align: "center",
                width: 400,
                canEdit: false,
                disabled: true
            }, {
                name: "materialId",
                title: "<spring:message code='goods.nameFa'/>",
                type: 'long',
                canEdit: false,
                disabled: true,
                editorType: "SelectItem",
                colSpan: 6,
                optionDataSource: RestDataSource_Material_IN_WAREHOUSELOT,
                displayField: "descl",
                valueField: "id",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {
                    showFilterEditor: true
                },
                pickListFields: [{
                    name: "id",
                    width: 50,
                    align: "center"
                }, {
                    name: "descl",
                    width: 150,
                    align: "center"
                }, {
                    name: "code",
                    width: 150
                }]
            }, {
                name: "plant",
                title: "<spring:message code='warehouseLot.plant'/>",
                align: "center",
                width: 400,
                canEdit: false,
                disabled: true
            }, {
                name: "lotName",
                title: "<spring:message code='warehouseLot.lotName'/>",
                width: 400,
                align: "center"
            }, {
                name: "mo",
                title: "<spring:message code='warehouseLot.mo'/>",
                align: "center",
                width: 400
            }, {
                name: "cu",
                title: "<spring:message code='warehouseLot.cu'/>",
                align: "center",
                width: 400
            }, {
                name: "si",
                title: "<spring:message code='warehouseLot.si'/>",
                align: "center",
                width: 400
            }, {
                name: "pb",
                title: "<spring:message code='warehouseLot.pb'/>",
                align: "center",
                width: 400
            }, {
                name: "s",
                title: "<spring:message code='warehouseLot.s'/>",
                align: "center",
                width: 400
            }, {
                name: "c",
                title: "<spring:message code='warehouseLot.c'/>",
                align: "center",
                width: 400
            }, {
                name: "p",
                title: "<spring:message code='warehouseLot.p'/>",
                align: "center",
                width: 400
            }, {
                name: "size1",
                title: "<spring:message code='warehouseLot.size1'/>",
                align: "center",
                width: 400
            }, {
                name: "size1Value",
                title: "<spring:message code='warehouseLot.size1Value'/>",
                align: "center",
                width: 400
            }, {
                name: "size2",
                title: "<spring:message code='warehouseLot.size2'/>",
                align: "center",
                width: 400
            }, {
                name: "size2Value",
                title: "<spring:message code='warehouseLot.size2Value'/>",
                align: "center",
                width: 400
            }, {
                name: "weightKg",
                title: "<spring:message code='warehouseLot.weightKg'/>",
                align: "center",
                width: 400
            }, {
                name: "grossWeight",
                title: "<spring:message code='warehouseLot.grossWeight'/>",
                align: "center",
                width: 400
            },


            {
                name: "bookingNo",
                title: "<spring:message code='warehouseLot.bookingNo'/>",
                align: "center",
                width: 400
            },

            {
                name: "contractId",
                title: "<spring:message code='contract.id'/>",
                align: "center",
                hidden: true
            }, {
                name: "used",
                type: "boolean",
                title: "<spring:message code='contract.used'/>",
                align: "center",
                hidden: true
            }
        ]
    });

    var ToolStripButton_WarehouseLot_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseLot_refresh();
        }
    });

    var ToolStripButton_WarehouseLot_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_WarehouseLot_edit();
        }
    });

    var ToolStrip_Actions_WarehouseLot = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_WarehouseLot_Edit,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_WarehouseLot_Refresh,
                    ]
                })

            ]
    });

    var HLayout_WarehouseLot_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseLot
            ]
    });

    var IButton_WarehouseLot_Save = isc.IButtonSave.create({
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
                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
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

    var IButton_WarehouseLot_Cancel = isc.IButtonCancel.create({
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
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "warehouseNo",
            title: "<spring:message code='dailyWarehouse.warehouse'/>",
            align: "center"
        }, {
            name: "plant",
            title: "<spring:message code='dailyWarehouse.plant'/>",
            align: "center"
        }, {
            name: "materialdescl", dataPath: "material.descl",
            title: "<spring:message code='goods.nameLatin'/> ",
            canEdit: false
        }, {
            name: "lotName",
            title: "<spring:message code='warehouseLot.lotName'/>",
            align: "center"
        }, {
            name: "mo",
            title: "<spring:message code='warehouseLot.mo'/>",
            align: "center"
        }, {
            name: "cu",
            title: "<spring:message code='warehouseLot.cu'/>",
            align: "center"
        }, {
            name: "si",
            title: "<spring:message code='warehouseLot.si'/>",
            align: "center"
        }, {
            name: "pb",
            title: "<spring:message code='warehouseLot.pb'/>",
            align: "center"
        }, {
            name: "s",
            title: "<spring:message code='warehouseLot.s'/>",
            align: "center"
        }, {
            name: "c",
            title: "<spring:message code='warehouseLot.c'/>",
            align: "center"
        }, {
            name: "p",
            title: "<spring:message code='warehouseLot.p'/>",
            align: "center"
        }, {
            name: "size1",
            title: "<spring:message code='warehouseLot.size1'/>",
            align: "center"
        }, {
            name: "size1Value",
            title: "<spring:message code='warehouseLot.size1Value'/>",
            align: "center"
        }, {
            name: "size2",
            title: "<spring:message code='warehouseLot.size2'/>",
            align: "center"
        }, {
            name: "size2Value",
            title: "<spring:message code='warehouseLot.size2Value'/>",
            align: "center"
        }, {
            name: "weightKg",
            title: "<spring:message code='warehouseLot.weightKg'/>",
            align: "center"
        }, {
            name: "grossWeight",
            title: "<spring:message code='warehouseLot.grossWeight'/>",
            align: "center"
        }, {
            name: "contractId",
            title: "<spring:message code='contract.id'/>",
            align: "center"
        }, {
            name: "bookingNo",
            type: "text",
            title: "<spring:message code='warehouseLot.bookingNo'/>",
            align: "center"
        }, {
            name: "warehouseCadItemissueId", dataPath: "warehouseCadItem.issueId",
            type: "text",
            title: "<spring:message code='warehouseCadItem.issueId'/>",
            align: "center"
        }, {
            name: "warehouseCadItemwarehouseCadbijackNo", dataPath: "warehouseCadItem.warehouseCad.bijackNo",
            type: "text",
            title: "<spring:message code='warehouseCad.bijackNo'/>",
            align: "center"
        }, {
            name: "used",
            type: "boolean",
            title: "<spring:message code='contract.used'/>",
            align: "center"
        },
        ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        canEdit: false,
        autoSaveEdits: false
    });

    var HLayout_WarehouseLot_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_WarehouseLot
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_WarehouseLot_Actions, HLayout_WarehouseLot_Grid
        ]
    });