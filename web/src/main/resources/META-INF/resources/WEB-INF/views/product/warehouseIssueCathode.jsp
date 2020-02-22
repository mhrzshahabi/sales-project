<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WarehouseIssueCathode = isc.MyRestDataSource.create({
        fields:
            [
                {name: "shipmentId"},
                {name: "bijak"},
                {name: "bijakIds"},
                {name: "containerNo"},
                {name: "amountCustom"},
                {name: "amountPms"},
                {name: "sealedCustom"},
                {name: "sealedShip"},
                {name: "emptyWeight"},
                {name: "bundle"},
                {name: "sheet"},
                {name: "totalAmount"},
                {name: "id"},
            ],

        fetchDataURL: "${contextPath}/api/warehouseIssueCathode/spec-list"
    });

    var RestDataSource_WarehouseIssueCathode_WarehouseCad = isc.MyRestDataSource.create({
        fields:
            [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true,
                    title: "<spring:message code='global.id'/>"
                },
                {name: "bijackNo", title: "<spring:message code='warehouseCad.bijackNo'/>"},
                {
                    name: "warehouseYard.nameFA",
                    title: "<spring:message code='warehouseCad.yard'/>"
                },
            ],
        fetchDataURL: "${contextPath}/api/warehouseCad/spec-list-issue-cad"
    });


    var MyRestDataSource_ShipmentByWarehouseIssueCathode = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "contractShipmentId",
            title: "<spring:message code='contact.name'/>",
            type: 'long',
            hidden: true
        }, {
            name: "contactId",
            type: 'long',
            hidden: true
        }, {
            name: "contract.contact.nameFA",
            title: "<spring:message code='contact.name'/>",
            type: 'text'
        }, {
            name: "contractId",
            type: 'long',
            hidden: true
        }, {
            name: "contract.contractNo",
            title: "<spring:message code='contract.contractNo'/>",
            type: 'text',
            width: 180
        }, {
            name: "contract.contractDate",
            title: "<spring:message code='contract.contractDate'/>",
            type: 'text',
            width: 180
        }, {
            name: "materialId",
            title: "<spring:message code='contact.name'/>",
            type: 'long',
            hidden: true
        }, {
            name: "material.descl",
            title: "<spring:message code='material.descl'/>",
            type: 'text'
        }, {
            name: "material.unit.nameEN",
            title: "<spring:message code='unit.nameEN'/>",
            type: 'text'
        }, {
            name: "amount",
            title: "<spring:message code='global.amount'/>",
            type: 'float'
        }, {
            name: "noContainer",
            title: "<spring:message code='shipment.noContainer'/>",
            type: 'integer'
        }, {
            name: "noPalete",
            title: "<spring:message code='shipment.noContainer'/>",
            type: 'integer'
        }, {
            name: "laycan",
            title: "<spring:message code='shipmentContract.laycanStart'/>",
            type: 'integer',
            width: "10%",
            align: "center"
        }, {
            name: "shipmentType",
            title: "<spring:message code='shipment.shipmentType'/>",
            type: 'text',
            width: 400,
            valueMap: {
                "bulk": "bulk",
                "container": "container"
            }
        }, {
            name: "loadingLetter",
            title: "<spring:message code='shipment.loadingLetter'/>",
            type: 'text',
            width: "10%",
            showHover: true
        }, {
            name: "loading",
            title: "<spring:message code='global.address'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "portByLoadingId",
            title: "<spring:message code='shipment.loading'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "portByLoading.port",
            title: "<spring:message code='shipment.loading'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "portByDischargeId",
            title: "<spring:message code='shipment.discharge'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "portByDischarge.port",
            title: "<spring:message code='shipment.discharge'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "dischargeAddress",
            title: "<spring:message code='global.address'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "description",
            title: "<spring:message code='shipment.description'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "swb",
            title: "<spring:message code='shipment.SWB'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "switchPort.port",
            title: "<spring:message code='port.switchPort'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "month",
            title: "<spring:message code='shipment.month'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "status",
            title: "<spring:message code='shipment.staus'/>",
            type: 'text',
            width: "10%",
            valueMap: {
                "Load Ready": "<spring:message code='shipment.loadReady'/>",
                "Resource": "<spring:message code='shipment.resource'/>"
            }
        }, {
            name: "contractShipment.sendDate",
            title: "<spring:message code='global.sendDate'/>",
            type: 'text',
            required: true,
            width: "10%",
            align: "center",
            showHover: true,
            validators: [{
                type:"required",
                validateOnChange: true
            }]
        }, {
            name: "createDate",
            title: "<spring:message code='shipment.createDate'/>",
            type: 'text',
            width: "10%"
        }, {
            name: "contactByAgent.nameFA",
            align: "center",
            showHover: true
        }, {
            name: "vesselName",
            title: "<spring:message	code='shipment.vesselName'/>",
            type: 'text',
            required: true,
            width: "10%",
            showHover: true,
            validators: [{
                type:"required",
                validateOnChange: true
            }]
        }],
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });


    var RestDataSource_WarehouseCadITEMByWarehouseIssueCathode = isc.MyRestDataSource.create({
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "warehouseCad.warehouseYardId",
            title: "<spring:message code='warehouseCad.yard'/>"
        }, {
            name: "warehouseCad.bijackNo",
            title: "<spring:message code='warehouseCad.bijackNo'/>"
        }, {
            name: "bundleSerial",
            title: "<spring:message code='warehouseCadItem.bundleSerial'/>"
        }, {
            name: "sheetNo",
            title: "<spring:message code='warehouseCadItem.sheetNo'/>"
        },],
        fetchDataURL: "${contextPath}/api/warehouseCadItem/spec-list-issue-cad"
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

    function setCriteria_ListGrid_InsperctionContract(recordId) {

        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: recordId}]
        };

        ListGrid_WarehouseIssueCathode.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            if (data.length == 0) {
                recordNotFound.show();
                ListGrid_WarehouseIssueCathode.hide()
            } else {
                recordNotFound.hide();
                ListGrid_WarehouseIssueCathode.setData(data);
                ListGrid_WarehouseIssueCathode.show();
            }
        }, {operationId: "00"});
    }

    function getExpandedComponent_ShipmentByWarehouseIssueCathode(record) {
        setCriteria_ListGrid_InsperctionContract(record.id)
        var hLayout = isc.HLayout.create({
            align: "center", padding: 5,
            membersMargin: 20,
            members: [
                <sec:authorize access="hasAuthority('C_WAREHOUSE_ISSUE_CATHODE')">
                ToolStripButton_WarehouseIssueCathode_Add
                </sec:authorize>
            ]
        });

        var layoutWarehouseIssoCathode = isc.VLayout.create({
            styleName: "expand-layout",
            padding: 5,
            membersMargin: 10,
            members: [ListGrid_WarehouseIssueCathode, recordNotFound, hLayout]
        });

        return layoutWarehouseIssoCathode;
    }

    var ListGrid_ShipmentByWarehouseIssueCathode = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: MyRestDataSource_ShipmentByWarehouseIssueCathode,
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
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contract.contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "contract.contractDate",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descl",
                title: "<spring:message code='material.descl'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "material.unit.nameEN",
                title: "<spring:message code='unit.nameEN'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "amount",
                title: "<spring:message code='global.amount'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "loadingLetter",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "noContainer",
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "portByLoading.port",
                title: "<spring:message	code='shipment.loading'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "description",
                title: "<spring:message code='shipment.description'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "contractShipment.sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "createDate",
                title: "<spring:message code='global.createDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "month",
                title: "<spring:message code='shipment.month'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "contactByAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {
                name: "vesselName",
                title: "<spring:message	code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "swb",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "switchPort.port",
                title: "<spring:message code='port.switchPort'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "status",
                title: "<spring:message	code='shipment.staus'/>",
                type: 'text',
                width: "10%",
                align: "center",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                },
                showHover: true
            }
        ],
        getExpansionComponent: function (record) {
            return getExpandedComponent_ShipmentByWarehouseIssueCathode(record)
        }
    });

    var HLayout_Grid_ShipmentByWarehouseIssueCathode = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentByWarehouseIssueCathode
        ]
    });

    var ToolStripButton_ListGrid_ShipmentByWarehouseIssueCathode_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentByWarehouseIssueCathode.invalidateCache();
            ListGrid_WarehouseIssueCathode.setData([]);
        }
    });
    var ToolStrip_Actions_ListGrid_ShipmentByWarehouseIssueCathode = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members: [
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_ListGrid_ShipmentByWarehouseIssueCathode_Refresh
                ]
            })
        ]
    });

    var VLayout_Body_ShipmentByWarehouseIssueCathode = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_ListGrid_ShipmentByWarehouseIssueCathode,
            HLayout_Grid_ShipmentByWarehouseIssueCathode
        ]
    });

    function ListGrid_WarehouseIssueCathode_edit() {
        var record = ListGrid_WarehouseIssueCathode.getSelectedRecord();

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
            DynamicForm_WarehouseIssueCathode.editRecord(record);
            Window_WarehouseIssueCathode.show();
        }
    }

    function ListGrid_WarehouseIssueCathode_remove() {

        var record = ListGrid_WarehouseIssueCathode.getSelectedRecord();

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
                    isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}),
                    isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var WarehouseIssueCathodeId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/warehouseIssueCathode/" + WarehouseIssueCathodeId,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_WarehouseIssueCathode_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
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

    var Menu_ListGrid_WarehouseIssueCathode = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_WarehouseIssueCathode_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_WAREHOUSE_ISSUE_CATHODE')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_WarehouseIssueCathode.clearValues();
                    Window_WarehouseIssueCathode.show();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_WAREHOUSE_ISSUE_CATHODE')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_WarehouseIssueCathode_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_WAREHOUSE_ISSUE_CATHODE')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_WarehouseIssueCathode_remove();
                }
            }
            </sec:authorize>
        ]
    });

    /******************************************************************************************************************************************************************************/
    function warehouseIssueCathode_bijak() {
        var ClientData_WarehouseCadITEMByWarehouseIssueCathode = [];
        var ids = DynamicForm_WarehouseIssueCathode.getValue("bijakIds");
        if (typeof (ids) != 'undefined' && ids.length > 0) {
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseCadItem/spec-list-ids/" + ids,
                    httpMethod: "GET",
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            var data = JSON.parse(RpcResponse_o.data);
                            warehouseIssueCathode_bijak_show(data);
                        } //if rpc
                    } // callback
                })
            );
        } else warehouseIssueCathode_bijak_show(ClientData_WarehouseCadITEMByWarehouseIssueCathode);

        function warehouseIssueCathode_bijak_show(ClientData_WarehouseCadITEMByWarehouseIssueCathode) {
            var ClientDataSource_WarehouseCadITEMByWarehouseIssueCathode = isc.DataSource.create({
                fields:
                    [
                        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                        {
                            name: "warehouseCad.bijackNo",
                            title: "<spring:message code='warehouseCad.bijackNo'/>"
                        },
                        {name: "bundleSerial", title: "<spring:message code='warehouseCadItem.bundleSerial'/>"},
                        {name: "sheetNo", title: "<spring:message code='warehouseCadItem.sheetNo'/>"},
                    ],
                testData: ClientData_WarehouseCadITEMByWarehouseIssueCathode,
                clientOnly: true
            });

            var ListGrid_WarehouseCadITEMByWarehouseIssueCathode = isc.ListGrid.create({
                width: "100%",
                height: "100%",
                dataSource: RestDataSource_WarehouseCadITEMByWarehouseIssueCathode,
                canDragRecordsOut: true,
                dragDataAction: "copy",
                canReorderRecords: true,
                autoFetchData: false,
                fields: [
                    {
                        name: "warehouseCad.bijackNo",
                        title: "<spring:message code='warehouseCad.bijackNo'/>"
                    },
                    {name: "bundleSerial", title: "<spring:message code='warehouseCadItem.bundleSerial'/>"},
                    {name: "sheetNo", title: "<spring:message code='warehouseCadItem.sheetNo'/>"},
                    {name: "issueId", title: "<spring:message code='warehouseCadItem.issueId'/>"},
                ]
            });


            var ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected = isc.ListGrid.create({
                width: "100%",
                height: "100%",
                dataSource: ClientDataSource_WarehouseCadITEMByWarehouseIssueCathode,
                data: ClientData_WarehouseCadITEMByWarehouseIssueCathode,
                canReorderRecords: true,
                canRemoveRecords: true,
                canAcceptDroppedRecords: true,
                autoFetchData: false
            });

            var Window_warehouseIssueCathode_bijak = isc.Window.create({
                title: "<spring:message code='Shipment.titleWarehouseIssueCathode'/> ",
                width: "800",
                height: "700",
                autoSize: false,
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
                        isc.VLayout.create({
                            width: "100%",
                            height: "100%",
                            align: "center",
                            members:
                                [
                                    isc.HLayout.create({
                                        ID: "hLayoutLayoutSpacers",
                                        autoDraw: true,
                                        // Specifying the width creates space for the LayoutSpacers to distribute.
                                        width: "100%",
                                        layoutMargin: 6,
                                        membersMargin: 6,
                                        border: "1px dashed blue",
                                        // Note no alignment property! It's all done with LayoutSpacers
                                        members: [
                                            isc.Label.create({
                                                height: 40,
                                                width: "33%",
                                                padding: 10,
                                                backgroundColor: "green",
                                                contents: "<b>INVENTORY انبار</b>"
                                            }),
                                            isc.Label.create({
                                                height: 40,
                                                width: "33%",
                                                padding: 10,
                                                backgroundColor: "white",
                                                contents: "<b>ِDrag </b>from INVENTORY to SELECTED"
                                            }),
                                            isc.Label.create({
                                                height: 40,
                                                width: "33%",
                                                padding: 10,
                                                backgroundColor: "red",
                                                contents: "<b>SELECTED انتخاب شده</b>"
                                            }),
                                        ]
                                    }),


                                    isc.HLayout.create({
                                        width: "100%",
                                        height: "100%",
                                        members:
                                            [
                                                ListGrid_WarehouseCadITEMByWarehouseIssueCathode,
                                                ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected,
                                            ]
                                    }),

                                    isc.HLayout.create({
                                        width: "100%",
                                        align: "center",
                                        members:
                                            [
                                                isc.Button.create({
                                                    title: "<spring:message code='global.ok'/>",
                                                    click: function () {
                                                        selectedTotalRows = ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected.getTotalRows();
                                                        if (selectedTotalRows == 0) {
                                                            DynamicForm_WarehouseIssueCathode.setValue("bijakIds", "");
                                                            DynamicForm_WarehouseIssueCathode.setValue("bijak", "");
                                                            Window_warehouseIssueCathode_bijak.close();
                                                            return;
                                                        }

                                                        bijakIds = "";
                                                        bijak = [];
                                                        bijakIdx = [];
                                                        for (i = 0; i < selectedTotalRows; i++) {
                                                            bijakIds += (i == 0 ? '' : ',') + ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected.data.get(i).id;
                                                            bjNo = ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected.data.get(i).warehouseCad.bijackNo;
                                                            var d = -1;
                                                            c = bijak.find(function (b, i) {
                                                                if (b == bjNo) {
                                                                    d = i;
                                                                    return true;
                                                                }
                                                            });
                                                            if (d == -1) {
                                                                j = bijak.push(bjNo);
                                                                bijakIdx.push(1);
                                                            } else {
                                                                bijakIdx[d]++;
                                                            }
                                                        }
                                                        if (bijak.length > 0) {
                                                            bj = "";
                                                            for (i = 0; i < bijak.length; i++) {
                                                                bj += (i == 0 ? '' : '- ') + bijak[i] + '(' + bijakIdx[i] + ')';
                                                            }
                                                        }
                                                        DynamicForm_WarehouseIssueCathode.setValue("bijakIds", bijakIds);
                                                        DynamicForm_WarehouseIssueCathode.setValue("bijak", bj);
                                                        Window_warehouseIssueCathode_bijak.close();
                                                        return;
                                                    }
                                                })
                                            ]
                                    })
                                ]
                        })

                    ]
            });

            ListGrid_WarehouseCadITEMByWarehouseIssueCathode.fetchData();
            Window_warehouseIssueCathode_bijak.animateShow();
        } //show func
    } // main func


    /************************************************************************************************************************************************************************************************/


    var DynamicForm_WarehouseIssueCathode = isc.DynamicForm.create({
        width: 650,
        height: "100%",
        titleWidth: "150",
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true,},
                {name: "shipmentId", hidden: true},
                {
                    name: "bijak",
                    title: "<spring:message code='warehouseIssueCathode.bijak'/>",
                    type: 'text',
                    width: 500, required: true,
                    validators: [{
                        type:"required",
                        validateOnChange: true
                    }],
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_WarehouseIssueCathode_WarehouseCad,
                    displayField: "bijackNo",
                    valueField: "id",
                    colSpan: 1,
                    titleColSpan: 1,
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "id", width: 50, align: "center", colSpan: 1, titleColSpan: 1},
                        {name: "bijackNo", width: 150, align: "center", colSpan: 1, titleColSpan: 1},
                        {
                            name: "warehouseYard.nameFA",
                            width: 150,
                            align: "center",
                            colSpan: 1,
                            titleColSpan: 1
                        },
                    ],
                    changed(form, item, value) {
                        ids = "";
                        for (x of  item.getSelectedRecord().warehouseCadItems) {
                            ids += ',' + x.id;
                        }
                        DynamicForm_WarehouseIssueCathode.setValue("bijakIds", ids.substring(1));
                    },
                    icons: [{
                        src: "icon/search.png",
                        click: function (form, item) {
                            warehouseIssueCathode_bijak();

                        }
                    }]
                },
                {
                    name: "containerNo",
                    title: "<spring:message code='warehouseIssueCathode.containerNo'/>",
                    width: 500,
                    required: true,
                    length: "15",
                    validators: [{
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "emptyWeight",
                    title: "<spring:message code='warehouseIssueCathode.emptyWeight'/>",
                    width: 500,
                    required: true,
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "!"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "amountCustom",
                    title: "<spring:message code='warehouseIssueCathode.amountCustom'/>",
                    width: 500,
                    required: true,
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "!"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "amountPms",
                    title: "<spring:message code='warehouseIssueCathode.amountPms'/>",
                    width: 500,
                    required: true,
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "!"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "sealedCustom",
                    title: "<spring:message code='warehouseIssueCathode.sealedCustom'/>",
                    width: 500,
                    required: true,
                    length: "15",
                    validators: [{
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "sealedShip",
                    title: "<spring:message code='warehouseIssueCathode.sealedShip'/>",
                    width: 500,
                    required: true,
                    length: "15",
                    validators: [{
                        type:"required",
                        validateOnChange: true
                    }]
                }
            ]
    });

    var ToolStripButton_WarehouseIssueCathode_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseIssueCathode_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_WAREHOUSE_ISSUE_CATHODE')">
    var ToolStripButton_WarehouseIssueCathode_Add = isc.ToolStripButtonAddLarge.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_ShipmentByWarehouseIssueCathode.getSelectedRecord();

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
                return;
            }
            DynamicForm_WarehouseIssueCathode.clearValues();
            DynamicForm_WarehouseIssueCathode.setValue("shipmentId", record.id);
            Window_WarehouseIssueCathode.animateShow();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_WAREHOUSE_ISSUE_CATHODE')">
    var ToolStripButton_WarehouseIssueCathode_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_WarehouseIssueCathode.clearValues();
            ListGrid_WarehouseIssueCathode_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_WAREHOUSE_ISSUE_CATHODE')">
    var ToolStripButton_WarehouseIssueCathode_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_WarehouseIssueCathode_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_WarehouseIssueCathode = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <sec:authorize access="hasAuthority('C_WAREHOUSE_ISSUE_CATHODE')">
                ToolStripButton_WarehouseIssueCathode_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_WAREHOUSE_ISSUE_CATHODE')">
                ToolStripButton_WarehouseIssueCathode_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_WAREHOUSE_ISSUE_CATHODE')">
                ToolStripButton_WarehouseIssueCathode_Remove,
                </sec:authorize>

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_WarehouseIssueCathode_Refresh,
                    ]
                })

            ]
    });

    var HLayout_WarehouseIssueCathode_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseIssueCathode
            ]
    });

    var IButton_WarehouseIssueCathode_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_WarehouseIssueCathode.validate();
            if (DynamicForm_WarehouseIssueCathode.hasErrors())
                return;

            var data = DynamicForm_WarehouseIssueCathode.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseIssueCathode/",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_WarehouseIssueCathode_refresh();
                            setCriteria_ListGrid_InsperctionContract(data.shipmentId)
                            Window_WarehouseIssueCathode.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var Window_WarehouseIssueCathode = isc.Window.create({
        title: "<spring:message code='Shipment.titleWarehouseIssueCathode'/> ",
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
                DynamicForm_WarehouseIssueCathode,
                isc.HLayout.create({
                    width: "100%", align: "center",
                    members:
                        [
                            IButton_WarehouseIssueCathode_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                click: function () {
                                    Window_WarehouseIssueCathode.close();
                                }
                            })
                        ]
                })
            ]
    });

    var warehouseIssueCathodeAttachmentViewLoader = isc.ViewLoader.create({
        autoDraw: false,
        loadingMessage: "لطفا منتظر بمانید"
    });

    // var vLayoutViewLoader = isc.VLayout.create({
    // width:"100%",
    // height: "100%",
    // align: "center",
    // padding: 5,
    // membersMargin: 20,
    // members: [
    //     warehouseIssueCathodeAttachmentViewLoader
    //  ]
    // });

    var ListGrid_WarehouseIssueCathode = isc.ListGrid.create({
        width: "100%",
        height: 200,
        styleName: "listgrid-child",
        dataSource: RestDataSource_WarehouseIssueCathode,
        contextMenu: Menu_ListGrid_WarehouseIssueCathode,
        fields:
            [
                {name: "id"},
                {name: "shipmentId", hidden: true},
                {
                    name: "bijak",
                    title: "<spring:message code='warehouseIssueCathode.bijak'/>",
                    width: "10%",
                    required: true,
                    keyPressFilter: "[0-9]",
                    length: "15",
                    validators: [{
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "containerNo",
                    title: "<spring:message code='warehouseIssueCathode.containerNo'/>",
                    width: "10%",
                    required: true,
                    length: "15",
                    validators: [{
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "emptyWeight",
                    title: "<spring:message code='warehouseIssueCathode.emptyWeight'/>",
                    width: "10%",
                    required: true,
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "!"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "amountCustom",
                    title: "<spring:message code='warehouseIssueCathode.amountCustom'/>",
                    width: "10%",
                    required: true,
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "!"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "amountPms",
                    title: "<spring:message code='warehouseIssueCathode.amountPms'/>",
                    width: "10%",
                    required: true,
                    length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "!"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "sealedCustom",
                    title: "<spring:message code='warehouseIssueCathode.sealedCustom'/>",
                    width: "10%",
                    required: true,
                    length: "15"
                },
                {
                    name: "sealedShip",
                    title: "<spring:message code='warehouseIssueCathode.sealedShip'/>",
                    width: "10%",
                    required: true,
                    length: "15",
                    validators: [{
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "bundle",
                    title: "<spring:message code='warehouseIssueCathode.bundle'/>",
                    width: "10%",
                    required: true,
                    keyPressFilter: "[0-9]",
                    length: "15"
                },
                {
                    name: "sheet",
                    title: "<spring:message code='warehouseIssueCathode.sheet'/>",
                    width: "10%",
                    required: true,
                    keyPressFilter: "[0-9]",
                    length: "15",
                    validators: [{
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "totalAmount",
                    title: "<spring:message code='warehouseIssueCathode.totalAmount'/>",
                    width: "10%",
                    required: true,
                    keyPressFilter: "[0-9]",
                    length: "15",
                    validators: [{
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "editIcon",
                    width: 40,
                    align: "center",
                    showTitle: false
                },
                {
                    name: "removeIcon",
                    width: 40,
                    align: "center",
                    showTitle: false
                },
            ],
        autoFetchData: false,
        filterOnKeypress: true,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        createRecordComponent: function (record, colNum) {
            var fieldName = this.getFieldName(colNum);
            if (fieldName == "editIcon") {
                var editImg = isc.ImgButton.create({
                    showDown: false,
                    showRollOver: false,
                    layoutAlign: "center",
                    src: "pieces/16/icon_edit.png",
                    prompt: "ویرایش",
                    height: 16,
                    width: 16,
                    grid: this,
                    click: function () {
                        ListGrid_WarehouseIssueCathode.selectSingleRecord(record);
                        ListGrid_WarehouseIssueCathode_edit();
                    }
                });
                return editImg;
            } else if (fieldName == "removeIcon") {
                var removeImg = isc.ImgButton.create({
                    showDown: false,
                    showRollOver: false,
                    layoutAlign: "center",
                    src: "pieces/16/icon_delete.png",
                    prompt: "حذف",
                    height: 16,
                    width: 16,
                    grid: this,
                    click: function () {
                        ListGrid_WarehouseIssueCathode.selectSingleRecord(record);
                        ListGrid_WarehouseIssueCathode_remove();
                    }
                });
                return removeImg;
            } else {
                return null;
            }
        },
        recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
            loadWindowFeatureList(record)
        }
    });


    function loadWindowFeatureList(record) {
        var dccTableId = record.id;
        var dccTableName = "TBL_WAREHOUSE_ISSUE_CATHODE";
        // warehouseIssueCathodeAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId)
        // WindowFeature.show()
        var window_view_url = isc.Window.create({
            title: "<spring:message code='warehouseIssueCathodeAttach.title'/>",
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
                    isc.ViewLoader.create({
                        autoDraw: true,
                        viewURL: "dcc/showForm/" + dccTableName + "/" + dccTableId,
                        loadingMessage: "<spring:message code='global.loadingMessage'/>"
                    })
                ]
        });
        window_view_url.show();
    }


    var HLayout_WarehouseIssueCathode_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_WarehouseIssueCathode
        ]
    });

    var VLayout_WarehouseIssueCathode_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_WarehouseIssueCathode_Actions, HLayout_WarehouseIssueCathode_Grid
        ]
    });

    /******************* Start Attachment **********************/

    isc.TabSet.create({
        ID: "warehouseIssueCathodeMainTabSet",
        tabBarPosition: "top",
        width: "100%",
        height: "100%",
        tabs: [
            {
                ID: "warehouseIssueCathodeTab",
                title: "<spring:message code='Shipment.titleWarehouseIssueCathode'/>",
                icon: "",
                iconSize: 16,
                pane: VLayout_WarehouseIssueCathode_Body
            },
            {
                title: "<spring:message code='warehouseIssueCathodeAttach.title'/>",
                icon: "",
                iconSize: 16,
                pane: warehouseIssueCathodeAttachmentViewLoader,
                tabSelected: function (form, item, value) {
                    var record = ListGrid_WarehouseIssueCathode.getSelectedRecord();
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
                        record.id = null;
                    }
                    var dccTableId = record.id;
                    var dccTableName = "TBL_WAREHOUSE_ISSUE_CATHODE";
                    warehouseIssueCathodeAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId)
                }
            }
        ]
    });
    /******************* End Attachment **********************/

    isc.SectionStack.create({
        sections:
            [
                {
                    title: "<spring:message code='Shipment.title'/>",
                    items: VLayout_Body_ShipmentByWarehouseIssueCathode,
                    expanded: true,
                    showHeader: false
                }
                , {
                title: "<spring:message code='Shipment.titleWarehouseIssueCathode'/>",
                items: warehouseIssueCathodeMainTabSet,
                expanded: true,
                hidden: true
            }
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });


    var criteria1 = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "material.code", operator: "equals", value: "74031100"}]
    };
    ListGrid_ShipmentByWarehouseIssueCathode.fetchData(criteria1, function (dsResponse, data, dsRequest) {
        ListGrid_ShipmentByWarehouseIssueCathode.setData(data);
    });

    function ListGrid_WarehouseIssueCathode_refresh() {
        record = ListGrid_ShipmentByWarehouseIssueCathode.getSelectedRecord();
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
        };
        ListGrid_WarehouseIssueCathode.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_WarehouseIssueCathode.setData(data);

        });
    }


