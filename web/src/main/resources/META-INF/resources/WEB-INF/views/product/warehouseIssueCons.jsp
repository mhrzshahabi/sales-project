<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    isc.SimpleType.create({
        name: "currencyFloat3",
        inheritsFrom: "float",
        editFormatter: function (value) {
            return isc.isA.Number(value) ? value.toFixed(3) : value;
        },
        parseInput: function (value) {
            var fVal = parseFloat(value);
            if (!isNaN(fVal)) return fVal;
            return value;
        },

        validators: [
            {type: "floatRange", min: 0, errorMessage: "notValid"},
            {type: "floatPrecision", precision: 3, roundToPrecision: true}
        ]

    });

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />
    var stocks = {};

    function fetch_stock() {
        stocks = {};
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/warehouseStock/cons-stock",
                httpMethod: "GET",
                data: "",
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                        var data = JSON.parse(RpcResponse_o.data);
                        for (x of data.data) {
                            stocks[x.plant] = x.amount;
                        }
                        t = DynamicForm_WarehouseIssueCons.getValue("amountSungon");
                        t = typeof(t) != 'undefined' ? parseFloat(t) : parseFloat(0);
                        stocks_sungun = stocks["sungun"] != undefined ? parseFloat(stocks["sungun"]) : parseFloat(0);
                        DynamicForm_WarehouseIssueCons.setValue("StockSungon", t + stocks_sungun);

                        t = DynamicForm_WarehouseIssueCons.getValue("amountMiduk");
                        t = typeof(t) != 'undefined' ? parseFloat(t) : parseFloat(0);
                        stocks_Miduk = stocks["Miduk"] != undefined ? parseFloat(stocks["Miduk"]) : parseFloat(0);
                        DynamicForm_WarehouseIssueCons.setValue("StockMiduk", t + stocks_Miduk);

                        t = DynamicForm_WarehouseIssueCons.getValue("amountSarcheshmeh");
                        t = typeof(t) != 'undefined' ? parseFloat(t) : parseFloat(0);
                        stocks_Sarcheshmeh = stocks["Sarcheshmeh"] != undefined ? parseFloat(stocks["Sarcheshmeh"]) : parseFloat(0);
                        DynamicForm_WarehouseIssueCons.setValue("StockSarcheshmeh", t + stocks_Sarcheshmeh);

                    } //if rpc
                } // callback
            })
        );
    }

    var RestDataSource_WarehouseIssueCons = isc.MyRestDataSource.create({
        fields:
            [
                {name: "shipmentId"},
                {
                    name: "amountSarcheshmeh",
                    type: 'currencyFloat3',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "amountMiduk",
                    type: 'currencyFloat3',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "amountSungon",
                    type: 'currencyFloat3',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "totalAmount",
                    type: 'currencyFloat3',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "amountDraft",
                    type: 'currencyFloat3',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "amountPms",
                    type: 'currencyFloat3',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnChange: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    },
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {name: "id"},
            ],

        fetchDataURL: "${contextPath}/api/warehouseIssueCons/spec-list"
    });

    var RestDataSource_WarehouseIssueCons_WarehouseCad = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "bijackNo"},
                {name: "yard.nameFA"},
            ],
        fetchDataURL: "${contextPath}/api/warehouseCad/spec-list"
    });

    //*******************************************************************************

    var MyRestDataSource_ShipmentByWarehouseIssueCons = isc.MyRestDataSource.create({
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
            showHover: true,
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

        ListGrid_WarehouseIssueCons.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            if (data.length === 0) {
                recordNotFound.show();
                ListGrid_WarehouseIssueCons.hide()
            } else {
                recordNotFound.hide();
                ListGrid_WarehouseIssueCons.setData(data);
                ListGrid_WarehouseIssueCons.show();
            }
        }, {operationId: "00"});
    }

    function getExpandedComponent_ShipmentByWarehouseIssueCons(record) {
        setCriteria_ListGrid_InsperctionContract(record.id)
        var hLayout = isc.HLayout.create({
            align: "center", padding: 5,
            membersMargin: 20,
            members: [
                <sec:authorize access="hasAuthority('C_WAREHOUSE_ISSUE_CONS')">
                ToolStripButton_WarehouseIssueCons_Add
                </sec:authorize>
            ]
        });

        var layoutWarehouseIssoCons = isc.VLayout.create({
            styleName: "expand-layout",
            padding: 5,
            membersMargin: 10,
            members: [ListGrid_WarehouseIssueCons, recordNotFound, hLayout]
        });

        return layoutWarehouseIssoCons;
    }


    var ListGrid_ShipmentByWarehouseIssueCons = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: MyRestDataSource_ShipmentByWarehouseIssueCons,
        styleName: 'expandList',
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
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        }, {
            name: "contractShipmentId",
            hidden: true,
            type: 'long'
        }, {
            name: "contactId",
            type: 'long',
            hidden: true
        }, {
            name: "contract.contact.nameFA",
            title: "<spring:message code='contact.name'/>",
            type: 'text',
            width: "20%",
            align: "center",
            showHover: true
        }, {
            name: "contractId",
            type: 'long',
            hidden: true
        }, {
            name: "contract.contractNo",
            title: "<spring:message code='contract.contractNo'/>",
            type: 'text',
            width: "10%",
            showHover: true
        }, {
            name: "contract.contractDate",
            title: "<spring:message code='contract.contractDate'/>",
            type: 'text',
            width: "10%",
            showHover: true
        }, {
            name: "materialId",
            title: "<spring:message code='contact.name'/>",
            type: 'long',
            hidden: true,
            showHover: true
        }, {
            name: "material.descl",
            title: "<spring:message code='material.descl'/>",
            type: 'text',
            width: "10%",
            align: "center",
            showHover: true
        }, {
            name: "material.unit.nameEN",
            title: "<spring:message code='unit.nameEN'/>",
            type: 'text',
            width: "10%",
            align: "center",
            showHover: true
        }, {
            name: "amount",
            title: "<spring:message code='global.amount'/>",
            type: 'text',
            width: "10%",
            align: "center",
            showHover: true
        }, {
            name: "shipmentType",
            title: "<spring:message code='shipment.shipmentType'/>",
            type: 'text',
            width: "10%",
            showHover: true
        }, {
            name: "loadingLetter",
            title: "<spring:message code='shipment.loadingLetter'/>",
            type: 'text',
            width: "10%",
            showHover: true
        }, {
            name: "noContainer",
            title: "<spring:message code='shipment.noContainer'/>",
            type: 'text',
            width: "10%",
            align: "center",
            showHover: true
        }, {
            name: "laycan",
            title: "<spring:message code='shipmentContract.laycanStart'/>",
            type: 'integer',
            width: "10%",
            align: "center",
            showHover: true
        }, {
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
        }, {
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
            }, {
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
            }, {
                name: "contactByAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "20%",
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
            }, {
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
            }, {
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
            }, {
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
        sortField: 0,
        dataPageSize: 50,
        showFilterEditor: true,
        filterOnKeypress: true,
        getExpansionComponent: function (record) {
            return getExpandedComponent_ShipmentByWarehouseIssueCons(record)
        }
    });

    var HLayout_Grid_ShipmentByWarehouseIssueCons = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentByWarehouseIssueCons
        ]
    });

    var ToolStripButton_ListGrid_ShipmentByWarehouseIssueCons_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentByWarehouseIssueCons.invalidateCache();
            ListGrid_WarehouseIssueCons.setData([]);
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
                    ToolStripButton_ListGrid_ShipmentByWarehouseIssueCons_Refresh
                ]
            })
        ]
    });

    var VLayout_Body_ShipmentByWarehouseIssueCons = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_ListGrid_ShipmentByWarehouseIssueCathode,
            HLayout_Grid_ShipmentByWarehouseIssueCons
        ]
    });

    function ListGrid_WarehouseIssueCons_edit() {
        var record = ListGrid_WarehouseIssueCons.getSelectedRecord();

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
            DynamicForm_WarehouseIssueCons.editRecord(record);
            fetch_stock();
            Window_WarehouseIssueCons.animateShow();
        }
    }

    function ListGrid_WarehouseIssueCons_remove() {

        var record = ListGrid_WarehouseIssueCons.getSelectedRecord();

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
                    if (index === 0) {
                        var WarehouseIssueConsId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/warehouseIssueCons/" + WarehouseIssueConsId,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                                        ListGrid_WarehouseIssueCons_refresh();
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


    var Menu_ListGrid_WarehouseIssueCons = isc.Menu.create({
        width: 150,
        data: [{
            title: "<spring:message code='global.form.refresh'/>",
            icon: "pieces/16/refresh.png",
            click: function () {
                ListGrid_WarehouseIssueCons_refresh();
            }
        },
        <sec:authorize access="hasAuthority('C_WAREHOUSE_ISSUE_CONS')">
        {
            title: "<spring:message code='global.form.new'/>",
            icon: "pieces/16/icon_add.png",
            click: function () {
                DynamicForm_WarehouseIssueCons.clearValues();
                fetch_stock();
                Window_WarehouseIssueCons.animateShow();
            }
        },
        </sec:authorize>

        <sec:authorize access="hasAuthority('U_WAREHOUSE_ISSUE_CONS')">
            {
            title: "<spring:message code='global.form.edit'/>",
            icon: "pieces/16/icon_edit.png",
            click: function () {
                ListGrid_WarehouseIssueCons_edit();
            }
        },
        </sec:authorize>

        <sec:authorize access="hasAuthority('D_WAREHOUSE_ISSUE_CONS')">
            {
            title: "<spring:message code='global.form.remove'/>",
            icon: "pieces/16/icon_delete.png",
            click: function () {
                ListGrid_WarehouseIssueCons_remove();
            }
        }
        </sec:authorize>
        ]
    });


    var DynamicForm_WarehouseIssueCons = isc.DynamicForm.create({
        width: 650,
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "150",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4,
        fields: [{
            name: "id",
            hidden: true,
        }, {
            name: "shipmentId",
            hidden: true
        }, {
            name: "amountSarcheshmeh",
            title: "<spring:message code='warehouseIssueCons.amountSarcheshmeh'/>",
            width: "100%",
            required: true,
            length: "15",
            wrapTitle: false,
            validators: [{
                type: "isFloat",
                validateOnChange: true,
                stopOnError: true,
                errorMessage: "!"
            },
            {
                type:"required",
                validateOnChange: true
            }],
            changed: function (form, item, value) {
                if (value != null && typeof(value) != 'undefined') {
                    if (parseFloat(DynamicForm_WarehouseIssueCons.getValue("amountSarcheshmeh")) > parseFloat(DynamicForm_WarehouseIssueCons.getValue("StockSarcheshmeh"))) {
                        DynamicForm_WarehouseIssueCons.setValue("amountSarcheshmeh", 0);
                    }
                }
            }

        }, {
            name: "StockSarcheshmeh",
            title: "<spring:message code='warehouseIssueCons.StockSarcheshmeh'/>",
            canEdit: false,
            width: "100%",
            wrapTitle: false,
            defaultValue: stocks["Sarcheshmeh"]
        }, {
            name: "amountMiduk",
            title: "<spring:message code='warehouseIssueCons.amountMiduk'/>",
            width: "100%",
            required: true,
            length: "15",
            wrapTitle: false,
            validators: [{
                type: "isFloat",
                validateOnChange: true,
                stopOnError: true,
                errorMessage: "!"
            },
            {
                type:"required",
                validateOnChange: true
            }],
            changed: function (form, item, value) {
                if (value != null && typeof(value) != 'undefined') {
                    if (parseFloat(DynamicForm_WarehouseIssueCons.getValue("amountMiduk")) > parseFloat(DynamicForm_WarehouseIssueCons.getValue("StockMiduk"))) {
                        DynamicForm_WarehouseIssueCons.setValue("amountMiduk", 0);
                    }
                }
            }

        }, {
            name: "StockMiduk",
            title: "<spring:message code='warehouseIssueCons.StockMiduk'/>",
            canEdit: false,
            width: "100%",
            wrapTitle: false,
            defaultValue: stocks["Miduk"]
        }, {
            name: "amountSungon",
            title: "<spring:message code='warehouseIssueCons.amountSungon'/>",
            width: "100%",
            required: true,
            length: "15",
            wrapTitle: false,
            validators: [{
                type: "isFloat",
                validateOnChange: true,
                stopOnError: true,
                errorMessage: "!"
            },
            {
                type:"required",
                validateOnChange: true
            }],
            changed: function (form, item, value) {
                if (value != null && typeof(value) != 'undefined') {
                    if (parseFloat(DynamicForm_WarehouseIssueCons.getValue("amountSungon")) > parseFloat(DynamicForm_WarehouseIssueCons.getValue("StockSungon"))) {
                        DynamicForm_WarehouseIssueCons.setValue("amountSungon", 0);
                    }
                }
            }

        }, {
            name: "StockSungon",
            title: "<spring:message code='warehouseIssueCons.StockSungon'/>",
            canEdit: false,
            width: "100%",
            wrapTitle: false,
            defaultValue: stocks["sungun"]
        }, {
            name: "amountPms",
            title: "<spring:message code='warehouseIssueCons.amountPms'/>",
            width: "100%",
            required: true,
            length: "15",
            wrapTitle: false,
            validators: [{
                type: "isFloat",
                validateOnChange: true,
                stopOnError: true,
                errorMessage: "!"
            },
            {
                type:"required",
                validateOnChange: true
            }],
            colSpan: 3,
            titleColSpan: 1
        }, {
            name: "amountDraft",
            title: "<spring:message code='warehouseIssueCons.amountDraft'/>",
            width: "100%",
            required: true,
            length: "15",
            wrapTitle: false,
            validators: [{
                type: "isFloat",
                validateOnChange: true,
                stopOnError: true,
                errorMessage: "!"
            },
            {
                type:"required",
                validateOnChange: true
            }],
            colSpan: 3,
            titleColSpan: 1
        }]
    });

    var ToolStripButton_WarehouseIssueCons_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseIssueCons_refresh();
        }
    });


    <sec:authorize access="hasAuthority('C_WAREHOUSE_ISSUE_CONS')">
    var ToolStripButton_WarehouseIssueCons_Add = isc.ToolStripButtonAddLarge.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_ShipmentByWarehouseIssueCons.getSelectedRecord();

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
            DynamicForm_WarehouseIssueCons.clearValues();
            DynamicForm_WarehouseIssueCons.setValue("shipmentId", record.id);
            fetch_stock();
            Window_WarehouseIssueCons.animateShow();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_WAREHOUSE_ISSUE_CONS')">
    var ToolStripButton_WarehouseIssueCons_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_WarehouseIssueCons.clearValues();
            ListGrid_WarehouseIssueCons_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_WAREHOUSE_ISSUE_CONS')">
    var ToolStripButton_WarehouseIssueCons_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_WarehouseIssueCons_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_WarehouseIssueCons = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <sec:authorize access="hasAuthority('C_WAREHOUSE_ISSUE_CONS')">
                ToolStripButton_WarehouseIssueCons_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_WAREHOUSE_ISSUE_CONS')">
                ToolStripButton_WarehouseIssueCons_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_WAREHOUSE_ISSUE_CONS')">
                ToolStripButton_WarehouseIssueCons_Remove,
                </sec:authorize>

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_WarehouseIssueCons_Refresh,
                    ]
                })

            ]
    });

    var HLayout_WarehouseIssueCons_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseIssueCons
            ]
    });

    var IButton_WarehouseIssueCons_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_WarehouseIssueCons.validate();
            if (DynamicForm_WarehouseIssueCons.hasErrors())
                return;

            var data = DynamicForm_WarehouseIssueCons.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseIssueCons/",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_WarehouseIssueCons_refresh();
                            setCriteria_ListGrid_InsperctionContract(data.shipmentId)
                            Window_WarehouseIssueCons.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var Window_WarehouseIssueCons = isc.Window.create({
        title: "<spring:message code='Shipment.titleWarehouseIssueCons'/> ",
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
                DynamicForm_WarehouseIssueCons,
                isc.HLayout.create({
                    width: "100%", align: "center",
                    members:
                        [
                            IButton_WarehouseIssueCons_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_WarehouseIssueCons.close();
                                }
                            })
                        ]
                })
            ]
    });


    var ListGrid_WarehouseIssueCons = isc.ListGrid.create({
        width: "100%",
        height: 200,
        styleName: "listgrid-child",
        dataSource: RestDataSource_WarehouseIssueCons,
        contextMenu: Menu_ListGrid_WarehouseIssueCons,
        fields: [{
            name: "id",
            hidden: true,
        }, {
            name: "shipmentId",
            hidden: true
        }, {
            name: "amountSarcheshmeh",
            title: "<spring:message code='warehouseIssueCons.amountSarcheshmeh'/>",
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
        }, {
            name: "amountMiduk",
            title: "<spring:message code='warehouseIssueCons.amountMiduk'/>",
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
        }, {
            name: "amountSungon",
            title: "<spring:message code='warehouseIssueCons.amountSungon'/>",
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
        }, {
            name: "amountPms",
            title: "<spring:message code='warehouseIssueCons.amountPms'/>",
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
        }, {
            name: "amountDraft",
            title: "<spring:message code='warehouseIssueCons.amountDraft'/>",
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
        }, {
            name: "totalAmount",
            title: "<spring:message code='warehouseIssueCons.totalAmount'/>",
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
        sortField: 0,
        autoFetchData: false,
        //showFilterEditor: true,
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
                        ListGrid_WarehouseIssueCons.selectSingleRecord(record);
                        ListGrid_WarehouseIssueCons_edit();
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
                        ListGrid_WarehouseIssueCons.selectSingleRecord(record);
                        ListGrid_WarehouseIssueCons_remove();
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
        var dccTableName = "TBL_WAREHOUSE_ISSUE_CONS";

        var window_view_url = isc.Window.create({
            title: "<spring:message code='warehouseIssueConsAttach.title'/>",
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

    var HLayout_WarehouseIssueCons_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_WarehouseIssueCons
        ]
    });

    var VLayout_WarehouseIssueCons_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_WarehouseIssueCons_Actions, HLayout_WarehouseIssueCons_Grid
        ]
    });

    /******************* Start Attachment **********************/
    isc.ViewLoader.create({
        ID: "warehouseIssueConsAttachmentViewLoader",
        autoDraw: false,
        loadingMessage: ""
    });

    isc.TabSet.create({
        ID: "warehouseIssueConsMainTabSet",
        tabBarPosition: "top",
        width: "100%",
        height: "100%",
        tabs: [
            {
                ID: "warehouseIssueConsTab",
                title: "<spring:message code='Shipment.titleWarehouseIssueCons'/>",
                icon: "",
                iconSize: 16,
                pane: VLayout_WarehouseIssueCons_Body
            },
            {
                title: "<spring:message code='warehouseIssueConsAttach.title'/>",
                icon: "",
                iconSize: 16,
                pane: warehouseIssueConsAttachmentViewLoader,
                tabSelected: function (form, item, value) {
                    var record = ListGrid_WarehouseIssueCons.getSelectedRecord();
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
                    var dccTableName = "TBL_WAREHOUSE_ISSUE_CONS";
                    warehouseIssueConsAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId)
                }
            }
        ]
    });
    /******************* End Attachment **********************/


    isc.SectionStack.create({
        sections: [{
            title: "<spring:message code='Shipment.title'/>",
            items: VLayout_Body_ShipmentByWarehouseIssueCons,
            expanded: true,
            showHeader: false
        }, {
            title: "<spring:message code='Shipment.titleWarehouseIssueCons'/>",
            items: warehouseIssueConsMainTabSet,
            expanded: true,
            hidden: true
        }],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });
    var criteria1 = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{
            fieldName: "material.code",
            operator: "equals",
            value: "26030090"
        }]
    };
    ListGrid_ShipmentByWarehouseIssueCons.fetchData(criteria1, function (dsResponse, data, dsRequest) {
        ListGrid_ShipmentByWarehouseIssueCons.setData(data);
    });

    function ListGrid_WarehouseIssueCons_refresh() {
        record = ListGrid_ShipmentByWarehouseIssueCons.getSelectedRecord();
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{
                fieldName: "shipmentId",
                operator: "equals",
                value: record.id
            }]
        };
        ListGrid_WarehouseIssueCons.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_WarehouseIssueCons.setData(data);

        });
    }