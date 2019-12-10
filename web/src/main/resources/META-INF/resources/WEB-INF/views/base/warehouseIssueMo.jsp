<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_WarehouseIssueMo = isc.MyRestDataSource.create({
        fields:
            [
                {name: "shipmentId"},
                {name: "WarehouseLotId"},
                {name: "warehouseLot"},
                {name: "warehouseLot.warehouseCadItemId"},
                {name: "containerNo"},
                {name: "emptyWeight"},
                {name: "amountCustom"},
                {name: "sealedCustom"},
                {name: "sealedInspector"},
                {name: "sealedShip"},
                {name: "id"},
             ],

        fetchDataURL: "${contextPath}/api/warehouseIssueMo/spec-list"
    });

    var RestDataSource_WarehouseIssueMo_WarehouseLot = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouse'/>", align: "center"},
                {name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", align: "center"},
                {name: "material.descl", title: "<spring:message code='goods.nameLatin'/> "},
                {name: "warehouseCadItem.warehouseCad.bijackNo", title: "<spring:message code='warehouseCad.bijackNo'/> "},
                {name: "lotName", title: "<spring:message code='warehouseLot.lotName'/>", align: "center"},
                {name: "weightKg", title: "<spring:message code='warehouseLot.weightKg'/>", align: "center"},
                {name: "grossWeight", title: "<spring:message code='grossWeight.weightKg'/>", align: "center"},
                {name: "contractId", title: "contractId", align: "center"},
                {name: "used", title: "used", align: "center"},
                {name: "warehouseCadItem.issueId", title: "<spring:message code='warehouseCadItem.issueId'/> "},
                {name: "contract.contractNo", title: "<spring:message code='contract.contractNo'/> "},
           ],
        fetchDataURL: "${contextPath}/api/warehouseLot/spec-list"
    });

//*******************************************************************************
    var MyRestDataSource_ShipmentByWarehouseIssueMo  = isc.MyRestDataSource.create({
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

    var ListGrid_ShipmentByWarehouseIssueMo  = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    dataSource: MyRestDataSource_ShipmentByWarehouseIssueMo ,
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
            ListGrid_WarehouseIssueMo.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_WarehouseIssueMo.setData(data);

            });
    },
    dataArrived 			: 	function (startRow, endRow) {
    },
    sortField: 0,
    dataPageSize: 50,
    autoFetchData: false,
    showFilterEditor: true,/*canSelectCells:true,*/
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
    var HLayout_Grid_ShipmentByWarehouseIssueMo  = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
                ListGrid_ShipmentByWarehouseIssueMo 
        ]
    });

    var VLayout_Body_ShipmentByWarehouseIssueMo  = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_ShipmentByWarehouseIssueMo 
        ]
    });
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@titleMoistureHeader titleMoistureItem

    function ListGrid_WarehouseIssueMo_edit() {
        var record = ListGrid_WarehouseIssueMo.getSelectedRecord();

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
            DynamicForm_WarehouseIssueMo.editRecord(record);
            Window_WarehouseIssueMo.animateShow();
        }
    }

    function ListGrid_WarehouseIssueMo_remove() {

        var record = ListGrid_WarehouseIssueMo.getSelectedRecord();

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
                        var WarehouseIssueMoId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/warehouseIssueMo/" + WarehouseIssueMoId,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_WarehouseIssueMo_refresh();
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
    function DynamicForm_WarehouseIssueMo_clearValues (){
        var record = ListGrid_ShipmentByWarehouseIssueMo.getSelectedRecord();
        var RestDataSource_WarehouseIssueMo_optionCriteria = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [
                {fieldName: "contractId", operator: "equals", value: record.contractId},
            ]
        };
        DynamicForm_WarehouseIssueMo.clearValues ();
        DynamicForm_WarehouseIssueMo_RestDataSource_WarehouseIssueMo_WarehouseLot.pickListCriteria=RestDataSource_WarehouseIssueMo_optionCriteria;
        DynamicForm_WarehouseIssueMo_RestDataSource_WarehouseIssueMo_WarehouseLot.pickListCriteria=null;
        DynamicForm_WarehouseIssueMo_RestDataSource_WarehouseIssueMo_WarehouseLot.fetchData(
                    RestDataSource_WarehouseIssueMo_optionCriteria,
                    function (dsResponse, data, dsRequest) { DynamicForm_WarehouseIssueMo_RestDataSource_WarehouseIssueMo_WarehouseLot.setData(data)  ;  } );

    }

    var Menu_ListGrid_WarehouseIssueMo = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_WarehouseIssueMo_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_WarehouseIssueMo_clearValues();
                    Window_WarehouseIssueMo.animateShow();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_WarehouseIssueMo_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_WarehouseIssueMo_remove();
                }
            }, {isSeparator: true},
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png", click: function () {
                    "<spring:url value="/warehouseIssueMo/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png", click: function () {
                    "<spring:url value="/warehouseIssueMo/print/excel" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg", click: function () {
                    "<spring:url value="/warehouseIssueMo/print/html" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }
        ]
    });
    //DynamicForm_WarehouseIssueMo_RestDataSource_WarehouseIssueMo_WarehouseLot

    var DynamicForm_WarehouseIssueMo = isc.DynamicForm.create({
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
        numCols: 2,backgroundImage: "backgrounds/leaves.jpg",
        fields:
            [
                {name: "id", hidden: true,},
                {name: "shipmentId", hidden: true},
                {type: "RowSpacerItem"},
               {
                    name: "warehouseLotId",ID:"DynamicForm_WarehouseIssueMo_RestDataSource_WarehouseIssueMo_WarehouseLot",
                    title: "<spring:message code='warehouseIssueMo.WarehouseLotId'/>",
                    type: 'text',
                    width: 500, required: true,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_WarehouseIssueMo_WarehouseLot,
                    displayField: "lotName",
                    valueField: "id",
                    colSpan: 1,
                    titleColSpan: 1,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "id", width: 50, align: "center", colSpan: 1, titleColSpan: 1},
                        {name: "lotName", title: "<spring:message code='warehouseLot.lotName'/>", align: "center", width: 150},
                        {name: "warehouseCadItem.warehouseCad.bijackNo", title: "<spring:message code='warehouseCad.bijackNo'/> "},
                        {name: "warehouseCadItem.issueId", title: "<spring:message code='warehouseCadItem.issueId'/> "},
                        {name: "contract.contractNo", title: "<spring:message code='contract.contractNo'/> "},
                    ],
                    changed: function (form, item, value) {
                        rcd=item.getSelectedRecord();
                        rcd1=DynamicForm_WarehouseIssueMo.getOldValues().warehouseLotId;
                        if (rcd != undefined && rcd.contractId != undefined
                             && ListGrid_ShipmentByWarehouseIssueMo.getSelectedRecord().contactId != rcd.contractId) {
                                 isc.warn("<spring:message code='warehouseIssueMo.Already_Assigend_2_other_Contract'/>");
                                 DynamicForm_WarehouseIssueMo.setValue("warehouseLotId", "");
                                 return;
                             }
                      /* console.log(rcd.contractId);
                       console.log('issue id='+rcd.warehouseCadItem.issueId);*/

                        if (rcd1 != undefined && rcd1 == rcd.id) {

                        } else  if (rcd.warehouseCadItem !=undefined && rcd.warehouseCadItem.issueId!=undefined) {
                            isc.warn("<spring:message code='warehouseIssueMo.Already_issued'/>");
                           DynamicForm_WarehouseIssueMo.setValue("warehouseLotId", "");
                           return;
                        }
                        if (rcd.id != undefined) {
                        console.log('rcd');
                        console.log(rcd);
                           // DynamicForm_WarehouseIssueMo.setValue("warehouseLotId", rcd.id);
                           DynamicForm_WarehouseIssueMo.setValue("warehouseLot", rcd);
                           DynamicForm_WarehouseIssueMo.setValue("warehouseLot.warehouseCadItemId", rcd.warehouseCadItemId);

                        }
                    }
                },
               {name: "containerNo",title: "<spring:message code='warehouseIssueMo.containerNo'/>",width: 500,required: true, length: "15"},
                {name: "emptyWeight",title: "<spring:message code='warehouseIssueMo.emptyWeight'/>",width: 500,required: true, length: "15",
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountCustom",title: "<spring:message code='warehouseIssueMo.amountCustom'/>",width: 500,required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "sealedInspector",title: "<spring:message code='warehouseIssueMo.sealedInspector'/>",width: 500,required: true, length: "15"},
                {name: "sealedCustom",title: "<spring:message code='warehouseIssueMo.sealedCustom'/>",width: 500,required: true, length: "15"},
                {name: "sealedShip",title: "<spring:message code='warehouseIssueMo.sealedShip'/>",width: 500,required: true, length: "15"},
                {type: "RowSpacerItem"},
                {type: "RowSpacerItem"},
                <%--{name: "bundle",title: "<spring:message code='warehouseIssueMo.bundle'/>",width: 500,required: true,keyPressFilter: "[0-9]", length: "15"},--%>
                <%--{name: "sheet",title: "<spring:message code='warehouseIssueMo.sheet'/>",width: 500,required: true,keyPressFilter: "[0-9]", length: "15"},--%>
                <%--{name: "totalAmount",title: "<spring:message code='warehouseIssueMo.totalAmount'/>",width: 500,required: true,keyPressFilter: "[0-9]", length: "15"},--%>
            ]
    });

    var ToolStripButton_WarehouseIssueMo_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseIssueMo_refresh();
        }
    });

    var ToolStripButton_WarehouseIssueMo_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_ShipmentByWarehouseIssueMo .getSelectedRecord();

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
            DynamicForm_WarehouseIssueMo_clearValues();
            DynamicForm_WarehouseIssueMo.setValue("shipmentId", record.id);
            Window_WarehouseIssueMo.animateShow();
        }
    });

    var ToolStripButton_WarehouseIssueMo_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_WarehouseIssueMo_clearValues();
            ListGrid_WarehouseIssueMo_edit();
        }
    });

    var ToolStripButton_WarehouseIssueMo_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_WarehouseIssueMo_remove();
        }
    });

    var ToolStrip_Actions_WarehouseIssueMo = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_WarehouseIssueMo_Refresh,
                ToolStripButton_WarehouseIssueMo_Add,
                ToolStripButton_WarehouseIssueMo_Edit,
                ToolStripButton_WarehouseIssueMo_Remove
            ]
    });

    var HLayout_WarehouseIssueMo_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseIssueMo
            ]
    });

    var IButton_WarehouseIssueMo_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_WarehouseIssueMo.validate();
            if (DynamicForm_WarehouseIssueMo.hasErrors())
                return;

            var data = DynamicForm_WarehouseIssueMo.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseIssueMo/",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_WarehouseIssueMo_refresh();
                            Window_WarehouseIssueMo.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var Window_WarehouseIssueMo = isc.Window.create({
        title: "<spring:message code='Shipment.titleWarehouseIssueMo'/> ",
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
                DynamicForm_WarehouseIssueMo,
                isc.HLayout.create({
                    width: "100%",align: "center",
                    members:
                        [
                            IButton_WarehouseIssueMo_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_WarehouseIssueMo.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_WarehouseIssueMo = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WarehouseIssueMo,
        contextMenu: Menu_ListGrid_WarehouseIssueMo,
        fields:
            [
                 {name: "id", hidden: true,},
                {name: "shipmentId", hidden: true},
                {type: "RowSpacerItem"},
                {name: "bijak",title: "<spring:message code='warehouseIssueMo.bijak'/>",width: "10%",required: true,keyPressFilter: "[0-9]", length: "15"},
                {name: "containerNo",title: "<spring:message code='warehouseIssueMo.containerNo'/>",width: "10%",required: true, length: "15"},
                {name: "emptyWeight",title: "<spring:message code='warehouseIssueMo.emptyWeight'/>",width: "10%",required: true, length: "15",
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountCustom",title: "<spring:message code='warehouseIssueMo.amountCustom'/>",width: "10%",required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountPms",title: "<spring:message code='warehouseIssueMo.amountPms'/>",width: "10%",required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "sealedCustom",title: "<spring:message code='warehouseIssueMo.sealedCustom'/>",width: "10%",required: true, length: "15"},
                {name: "sealedShip",title: "<spring:message code='warehouseIssueMo.sealedShip'/>",width: "10%",required: true, length: "15"},
                {name: "bundle",title: "<spring:message code='warehouseIssueMo.bundle'/>",width: "10%",required: true,keyPressFilter: "[0-9]", length: "15"},
                {name: "sheet",title: "<spring:message code='warehouseIssueMo.sheet'/>",width: "10%",required: true,keyPressFilter: "[0-9]", length: "15"},
                {name: "totalAmount",title: "<spring:message code='warehouseIssueMo.totalAmount'/>",width: "10%",required: true,keyPressFilter: "[0-9]", length: "15"},
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

    var HLayout_WarehouseIssueMo_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_WarehouseIssueMo
        ]
    });

    var VLayout_WarehouseIssueMo_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_WarehouseIssueMo_Actions, HLayout_WarehouseIssueMo_Grid
        ]
    });
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@titleMoistureHeader titleMoistureItem

isc.SectionStack.create({
    ID:"ShipmentMoistureHeader_Section_Stack",
    sections:
    [
         {title:"<spring:message code='Shipment.title'/>", items:VLayout_Body_ShipmentByWarehouseIssueMo   ,expanded:true}
        ,{title:"<spring:message code='Shipment.titleWarehouseIssueMo'/>", items:VLayout_WarehouseIssueMo_Body ,expanded:true}
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
	criteria: [{fieldName: "material.code", operator: "equals", value: "28257000"}]
};
ListGrid_ShipmentByWarehouseIssueMo .fetchData(criteria1, function (dsResponse, data, dsRequest) {
	ListGrid_ShipmentByWarehouseIssueMo .setData(data);
	});

 function ListGrid_WarehouseIssueMo_refresh() {
       record=ListGrid_ShipmentByWarehouseIssueMo .getSelectedRecord();
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
        };
        ListGrid_WarehouseIssueMo.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_WarehouseIssueMo.setData(data);

        });
}

