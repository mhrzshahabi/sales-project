<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WarehouseIssueCons = isc.MyRestDataSource.create({
        fields:
            [
                {name: "shipmentId"},
                {name: "amountSarcheshmeh"},
                {name: "amountMiduk"},
                {name: "amountSungon"},
                {name: "totalAmount"},
                {name: "amountDraft"},
                {name: "amountPms"},
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
    var MyRestDataSource_ShipmentByWarehouseIssueCons  = isc.MyRestDataSource.create({
    fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "contactId", type: 'long', hidden: true},
            {name: "contract.contact.nameFA", title: "<spring:message code='contact.name'/>", type: 'text'},
            {name: "contractId", type: 'long', hidden: true},
            {name: "contract.contractNo",title: "<spring:message code='contract.contractNo'/>",type: 'text',width: 180 },
            {name: "contract.contractDate",title: "<spring:message code='contract.contractDate'/>",type: 'text',width: 180},
            {name: "materialId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "material.descl", title: "<spring:message code='material.descl'/>", type: 'text'},
            {name: "material.unit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "noPalete", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "laycan",title: "<spring:message code='shipmentContract.laycanStart'/>",type: 'integer',width: "10%",align: "center"},
            {name: "shipmentType",title: "<spring:message code='shipment.shipmentType'/>",type: 'text',width: 400,valueMap: {"b": "bulk", "c": "container"}},
            {name: "loadingLetter",title: "<spring:message code='shipment.loadingLetter'/>",type: 'text',width: "10%",showHover: true},
            {name: "loading", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "portByLoadingId", title: "<spring:message code='shipment.loading'/>", type: 'text', width: "10%"},
            {name: "portByLoading.port",title: "<spring:message code='shipment.loading'/>",type: 'text',width: "10%"},
            {name: "portByDischargeId",title: "<spring:message code='shipment.discharge'/>",type: 'text',width: "10%"},
            {name: "portByDischarge.port",title: "<spring:message code='shipment.discharge'/>",type: 'text',width: "10%"},
            {name: "dischargeAddress", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "description", title: "<spring:message code='shipment.description'/>", type: 'text', width: "10%"},
            {name: "swb", title: "<spring:message code='shipment.SWB'/>", type: 'text', width: "10%"},
            {name: "switchPort.port", title: "<spring:message code='port.switchPort'/>", type: 'text', width: "10%"},
            {name: "month", title: "<spring:message code='shipment.month'/>", type: 'text', width: "10%"},
            {name: "status",title: "<spring:message code='shipment.staus'/>",type: 'text',width: "10%",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                }
            },
            {name: "contractShipment.sendDate",title: "<spring:message code='global.sendDate'/>",type: 'text',required: true,width: "10%",align: "center",showHover: true},
            {name: "createDate", title: "<spring:message code='shipment.createDate'/>", type: 'text', width: "10%"},
            {name: "contactByAgent.nameFA",align: "center",showHover: true},
            {name: "vesselName",title: "<spring:message	code='shipment.vesselName'/>",type: 'text',required: true,width: "10%",showHover: true}
    ],
 // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });

    var ListGrid_ShipmentByWarehouseIssueCons  = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    dataSource: MyRestDataSource_ShipmentByWarehouseIssueCons ,
    fields:[
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
            <%--{name: "laycan", title:"<spring:message code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",showHover:true},--%>
            {
                name: "portByLoading.port",
                title: "<spring:message	code='shipment.loading'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
// {name: "dischargeAddress", title:"<spring:message code='global.address'/>", type:'text', required: true, width: "10%" ,showHover:true},
            {
                name: "description",
                title: "<spring:message code='shipment.description'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "contractShipment.sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "createDate",
                title: "<spring:message code='global.createDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "month",
                title: "<spring:message code='shipment.month'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
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
                showHover: true
            },
            {
                name: "swb",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "switchPort.port",
                title: "<spring:message code='port.switchPort'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
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
    recordClick 			:	"this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
    updateDetails 			: function (viewer, record1, recordNum, field, fieldNum, value, rawValue)
    {
        var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
            };
            ListGrid_WarehouseIssueCons.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_WarehouseIssueCons.setData(data);

            });
    },
    dataArrived 			: 	function (startRow, endRow) {
    },
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
    var HLayout_Grid_ShipmentByWarehouseIssueCons  = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
                ListGrid_ShipmentByWarehouseIssueCons 
        ]
    });

    var VLayout_Body_ShipmentByWarehouseIssueCons  = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_ShipmentByWarehouseIssueCons 
        ]
    });
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@titleMoistureHeader titleMoistureItem

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
            Window_WarehouseIssueCons.show();
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
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var WarehouseIssueConsId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/warehouseIssueCons/" + WarehouseIssueConsId,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_WarehouseIssueCons_refresh();
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
    }

    var Menu_ListGrid_WarehouseIssueCons = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_WarehouseIssueCons_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_WarehouseIssueCons.clearValues();
                    Window_WarehouseIssueCons.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_WarehouseIssueCons_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_WarehouseIssueCons_remove();
                }
            }, {isSeparator: true},
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png", click: function () {
                    "<spring:url value="/warehouseIssueCons/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png", click: function () {
                    "<spring:url value="/warehouseIssueCons/print/excel" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg", click: function () {
                    "<spring:url value="/warehouseIssueCons/print/html" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }
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
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true,},
                {name: "shipmentId", hidden: true},
                {type: "RowSpacerItem"},
                {name: "amountSarcheshmeh",title: "<spring:message code='warehouseIssueCons.amountSarcheshmeh'/>",width: 500,required: true, length: "15",wrapTitle : false,
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountMiduk",title: "<spring:message code='warehouseIssueCons.amountMiduk'/>",width: 500,required: true, length: "15",wrapTitle : false,
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountSungon",title: "<spring:message code='warehouseIssueCons.amountSungon'/>",width: 500,required: true, length: "15",wrapTitle : false,
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountPms",title: "<spring:message code='warehouseIssueCons.amountPms'/>",width: 500,required: true, length: "15",wrapTitle : false,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountDraft",title: "<spring:message code='warehouseIssueCons.amountDraft'/>",width: 500,required: true, length: "15",wrapTitle : false,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
             ]
    });

    var ToolStripButton_WarehouseIssueCons_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseIssueCons_refresh();
        }
    });

    var ToolStripButton_WarehouseIssueCons_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_ShipmentByWarehouseIssueCons .getSelectedRecord();

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
            Window_WarehouseIssueCons.show();
        }
    });

    var ToolStripButton_WarehouseIssueCons_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_WarehouseIssueCons.clearValues();
            ListGrid_WarehouseIssueCons_edit();
        }
    });

    var ToolStripButton_WarehouseIssueCons_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_WarehouseIssueCons_remove();
        }
    });

    var ToolStrip_Actions_WarehouseIssueCons = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_WarehouseIssueCons_Refresh,
                ToolStripButton_WarehouseIssueCons_Add,
                ToolStripButton_WarehouseIssueCons_Edit,
                ToolStripButton_WarehouseIssueCons_Remove
            ]
    });

    var HLayout_WarehouseIssueCons_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseIssueCons
            ]
    });

    var IButton_WarehouseIssueCons_Save = isc.IButton.create({
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
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_WarehouseIssueCons_refresh();
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
                DynamicForm_WarehouseIssueCons,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_WarehouseIssueCons_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
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
        height: "100%",
        dataSource: RestDataSource_WarehouseIssueCons,
        contextMenu: Menu_ListGrid_WarehouseIssueCons,
        fields:
            [
                 {name: "id", hidden: true,},
                {name: "shipmentId", hidden: true},
                {name: "amountSarcheshmeh",title: "<spring:message code='warehouseIssueCons.amountSarcheshmeh'/>",width: "10%",required: true, length: "15",
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountMiduk",title: "<spring:message code='warehouseIssueCons.amountMiduk'/>",width: "10%",required: true, length: "15",
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountSungon",title: "<spring:message code='warehouseIssueCons.amountSungon'/>",width: "10%",required: true, length: "15",
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountPms",title: "<spring:message code='warehouseIssueCons.amountPms'/>",width: "10%",required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountDraft",title: "<spring:message code='warehouseIssueCons.amountDraft'/>",width: "10%",required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "totalAmount",title: "<spring:message code='warehouseIssueCons.totalAmount'/>",width: "10%",required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
           ],
        sortField: 0,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        },
        dataArrived: function (startRow, endRow) {
        }
    });

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
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@titleMoistureHeader titleMoistureItem

isc.SectionStack.create({
    ID:"ShipmentMoistureHeader_Section_Stack",
    sections:
    [
         {title:"<spring:message code='Shipment.title'/>", items:VLayout_Body_ShipmentByWarehouseIssueCons   ,expanded:true}
        ,{title:"<spring:message code='Shipment.titleWarehouseIssueCons'/>", items:VLayout_WarehouseIssueCons_Body ,expanded:true}
    ],
    visibilityMode:"multiple",
    animateSections:true,
    height:"100%",
    width:"100%",
    overflow:"hidden"
});
var criteria1 = {
	_constructor: "AdvancedCriteria",
	operator: "and",
	criteria: [{fieldName: "material.code", operator: "equals", value: "26030090"}]
};
ListGrid_ShipmentByWarehouseIssueCons .fetchData(criteria1, function (dsResponse, data, dsRequest) {
	ListGrid_ShipmentByWarehouseIssueCons .setData(data);
	});

 function ListGrid_WarehouseIssueCons_refresh() {
       record=ListGrid_ShipmentByWarehouseIssueCons .getSelectedRecord();
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
        };
        ListGrid_WarehouseIssueCons.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_WarehouseIssueCons.setData(data);

        });
}
