<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

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
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "bijackNo"},
                {name: "yard.nameFA"},
            ],
        fetchDataURL: "${contextPath}/api/warehouseCad/spec-list"
    });

//*******************************************************************************
    var MyRestDataSource_ShipmentByWarehouseIssueCathode  = isc.MyRestDataSource.create({
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


    var RestDataSource_WarehouseCadITEMByWarehouseIssueCathode = isc.MyRestDataSource.create({
        fields:
            [
                 {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseCad.warehouseYardId",title:"<spring:message code='warehouseCad.yard'/>"},
                {name: "warehouseCad.bijackNo",title:"<spring:message code='warehouseCad.bijackNo'/>"},
                {name: "bundleSerial",title:"<spring:message code='warehouseCadItem.bundleSerial'/>"},
                {name: "sheetNo",title:"<spring:message code='warehouseCadItem.sheetNo'/>"},
            ],
        fetchDataURL: "${contextPath}/api/warehouseCadItem/spec-list"
    });


    var ListGrid_ShipmentByWarehouseIssueCathode  = isc.ListGrid.create({
    width: "100%",
    height: "100%",
    dataSource: MyRestDataSource_ShipmentByWarehouseIssueCathode ,
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
            ListGrid_WarehouseIssueCathode.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_WarehouseIssueCathode.setData(data);

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
    var HLayout_Grid_ShipmentByWarehouseIssueCathode  = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
                ListGrid_ShipmentByWarehouseIssueCathode 
        ]
    });

    var VLayout_Body_ShipmentByWarehouseIssueCathode  = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_ShipmentByWarehouseIssueCathode 
        ]
    });
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@titleMoistureHeader titleMoistureItem

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
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
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

    var Menu_ListGrid_WarehouseIssueCathode = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_WarehouseIssueCathode_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_WarehouseIssueCathode.clearValues();
                    Window_WarehouseIssueCathode.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_WarehouseIssueCathode_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_WarehouseIssueCathode_remove();
                }
            }, {isSeparator: true},
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png", click: function () {
                    "<spring:url value="/warehouseIssueCathode/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png", click: function () {
                    "<spring:url value="/warehouseIssueCathode/print/excel" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg", click: function () {
                    "<spring:url value="/warehouseIssueCathode/print/html" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }
        ]
    });

    function warehouseIssueCathode_bijak () {

        var ClientData_WarehouseCadITEMByWarehouseIssueCathode = [];
        var ids= DynamicForm_WarehouseIssueCathode.getValue("bijakIds");
        if (typeof(ids) != 'undefined' && ids.length > 0) {
            // console.log('ids');
            // console.log(ids);
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/warehouseCadItem/spec-list-ids/" + ids,
                    httpMethod: "GET",
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            // console.log(JSON.parse(RpcResponse_o));
                            var data = JSON.parse(RpcResponse_o.data);
                            // console.log('data');
                            // console.log(data);
                            // for (x of data) { // console.log(x);
                            //     ClientData_WarehouseCadITEMByWarehouseIssueCathode.push(x);
                            //     // dollar[x.nameEn] = x.nameEn;
                            // }
                            //  // console.log('client');
                            // console.log(ClientData_WarehouseCadITEMByWarehouseIssueCathode);
                            warehouseIssueCathode_bijak_show(data);
                       } //if rpc
                    } // callback
                })
            );
        } else warehouseIssueCathode_bijak_show(ClientData_WarehouseCadITEMByWarehouseIssueCathode);

    function warehouseIssueCathode_bijak_show(ClientData_WarehouseCadITEMByWarehouseIssueCathode){
        var ClientDataSource_WarehouseCadITEMByWarehouseIssueCathode = isc.DataSource.create({
            fields:
            [
                 {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseCad.bijackNo",title:"<spring:message code='warehouseCad.bijackNo'/>"},
                {name: "warehouseCad.warehouseYardId",title:"<spring:message code='warehouseCad.yard'/>"},
                {name: "bundleSerial",title:"<spring:message code='warehouseCadItem.bundleSerial'/>"},
                {name: "sheetNo",title:"<spring:message code='warehouseCadItem.sheetNo'/>"},
            ],
            testData: ClientData_WarehouseCadITEMByWarehouseIssueCathode,
            clientOnly:true
        });
        /* ****************** */
    var ListGrid_WarehouseCadITEMByWarehouseIssueCathode  = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WarehouseCadITEMByWarehouseIssueCathode ,
        sortField: 0,
        canDragRecordsOut: true,
        dragDataAction: "copy",
        canReorderRecords: true,
        dataPageSize: 50,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true
    });
    var ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected  = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: ClientDataSource_WarehouseCadITEMByWarehouseIssueCathode ,
        data: ClientData_WarehouseCadITEMByWarehouseIssueCathode ,
        sortField: 0,
        canReorderRecords: true,
        canRemoveRecords: true,
        canAcceptDroppedRecords: true,
        dataPageSize: 50,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true
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
                    height: "100%",backgroundImage: "backgrounds/leaves.jpg",align: "center",
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
												selectedTotalRows=ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected.getTotalRows();
												if (selectedTotalRows == 0) {
													DynamicForm_WarehouseIssueCathode.setValue("bijakIds","");
													DynamicForm_WarehouseIssueCathode.setValue("bijak","");
													Window_warehouseIssueCathode_bijak.close();
													return;
												}

												bijakIds="";
												bijak=[];bijakIdx=[];
												for (i = 0; i < selectedTotalRows; i++) {
													bijakIds+=(i==0 ? '':',')+ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected.data.get(i).id;
													bjNo=ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected.data.get(i).warehouseCad.bijackNo;
													// console.log(bjNo);
													var d=-1; c = bijak.find( function(b,i) { if (b== bjNo ) {d=i; return true;}   });
													if (d==-1) {
														j=bijak.push(bjNo);
														bijakIdx.push(1);
													} else {
														bijakIdx[d]++;
													}
												 }
												 // console.log(bijak);
												if (bijak.length > 0){
													bj="";
													for (i=0;i<bijak.length;i++) {
														bj+= (i==0 ? '' : '- ')+bijak[i]+'('+bijakIdx[i]+')';
													}
												}
												DynamicForm_WarehouseIssueCathode.setValue("bijakIds",bijakIds);
												DynamicForm_WarehouseIssueCathode.setValue("bijak",bj);
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
    var DynamicForm_WarehouseIssueCathode = isc.DynamicForm.create({
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
                    name: "bijak",
                    title: "<spring:message code='warehouseIssueCathode.bijak'/>",
                    type: 'text',
                    width: 500, required: true,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_WarehouseIssueCathode_WarehouseCad,
                    displayField: "bijackNo",
                    valueField: "id",
                    colSpan: 1,
                    titleColSpan: 1,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "id", width: 50, align: "center", colSpan: 1, titleColSpan: 1},
                        {name: "bijackNo", width: 150, align: "center", colSpan: 1, titleColSpan: 1},
                        {name: "yard.nameFA", width: 150, align: "center", colSpan: 1, titleColSpan: 1},
                    ],
                    changed(form, item, value) {
                    	// console.log(item.getSelectedRecord().warehouseCadItems);
                    	ids="";
                    	for (x of  item.getSelectedRecord().warehouseCadItems) {
                    	    // console.log(x);
                    	    ids+=','+x.id;
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
                {name: "containerNo",title: "<spring:message code='warehouseIssueCathode.containerNo'/>",width: 500,required: true, length: "15"},
                {name: "emptyWeight",title: "<spring:message code='warehouseIssueCathode.emptyWeight'/>",width: 500,required: true, length: "15",
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountCustom",title: "<spring:message code='warehouseIssueCathode.amountCustom'/>",width: 500,required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountPms",title: "<spring:message code='warehouseIssueCathode.amountPms'/>",width: 500,required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "sealedCustom",title: "<spring:message code='warehouseIssueCathode.sealedCustom'/>",width: 500,required: true, length: "15"},
                {name: "sealedShip",title: "<spring:message code='warehouseIssueCathode.sealedShip'/>",width: 500,required: true, length: "15"},
                {type: "RowSpacerItem"},
                {type: "RowSpacerItem"},
                <%--{name: "bundle",title: "<spring:message code='warehouseIssueCathode.bundle'/>",width: 500,required: true,keyPressFilter: "[0-9]", length: "15"},--%>
                <%--{name: "sheet",title: "<spring:message code='warehouseIssueCathode.sheet'/>",width: 500,required: true,keyPressFilter: "[0-9]", length: "15"},--%>
                <%--{name: "totalAmount",title: "<spring:message code='warehouseIssueCathode.totalAmount'/>",width: 500,required: true,keyPressFilter: "[0-9]", length: "15"},--%>
            ]
    });

    var ToolStripButton_WarehouseIssueCathode_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_WarehouseIssueCathode_refresh();
        }
    });

    var ToolStripButton_WarehouseIssueCathode_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_ShipmentByWarehouseIssueCathode .getSelectedRecord();

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

    var ToolStripButton_WarehouseIssueCathode_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_WarehouseIssueCathode.clearValues();
            ListGrid_WarehouseIssueCathode_edit();
        }
    });

    var ToolStripButton_WarehouseIssueCathode_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_WarehouseIssueCathode_remove();
        }
    });

    var ToolStrip_Actions_WarehouseIssueCathode = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_WarehouseIssueCathode_Refresh,
                ToolStripButton_WarehouseIssueCathode_Add,
                ToolStripButton_WarehouseIssueCathode_Edit,
                ToolStripButton_WarehouseIssueCathode_Remove
            ]
    });

    var HLayout_WarehouseIssueCathode_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_WarehouseIssueCathode
            ]
    });

    var IButton_WarehouseIssueCathode_Save = isc.IButton.create({
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
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_WarehouseIssueCathode_refresh();
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
                DynamicForm_WarehouseIssueCathode,
                isc.HLayout.create({
                    width: "100%",align: "center",
                    members:
                        [
                            IButton_WarehouseIssueCathode_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
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
    var ListGrid_WarehouseIssueCathode = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_WarehouseIssueCathode,
        contextMenu: Menu_ListGrid_WarehouseIssueCathode,
        fields:
            [
                 {name: "id"},
                {name: "shipmentId", hidden: true},
                {type: "RowSpacerItem"},
                {name: "bijak",title: "<spring:message code='warehouseIssueCathode.bijak'/>",width: "10%",required: true,keyPressFilter: "[0-9]", length: "15"},
                {name: "containerNo",title: "<spring:message code='warehouseIssueCathode.containerNo'/>",width: "10%",required: true, length: "15"},
                {name: "emptyWeight",title: "<spring:message code='warehouseIssueCathode.emptyWeight'/>",width: "10%",required: true, length: "15",
                   validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountCustom",title: "<spring:message code='warehouseIssueCathode.amountCustom'/>",width: "10%",required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "amountPms",title: "<spring:message code='warehouseIssueCathode.amountPms'/>",width: "10%",required: true, length: "15",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "!"
                    }]
                },
                {name: "sealedCustom",title: "<spring:message code='warehouseIssueCathode.sealedCustom'/>",width: "10%",required: true, length: "15"},
                {name: "sealedShip",title: "<spring:message code='warehouseIssueCathode.sealedShip'/>",width: "10%",required: true, length: "15"},
                {name: "bundle",title: "<spring:message code='warehouseIssueCathode.bundle'/>",width: "10%",required: true,keyPressFilter: "[0-9]", length: "15"},
                {name: "sheet",title: "<spring:message code='warehouseIssueCathode.sheet'/>",width: "10%",required: true,keyPressFilter: "[0-9]", length: "15"},
                {name: "totalAmount",title: "<spring:message code='warehouseIssueCathode.totalAmount'/>",width: "10%",required: true,keyPressFilter: "[0-9]", length: "15"},
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
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@titleMoistureHeader titleMoistureItem

isc.SectionStack.create({
    ID:"ShipmentMoistureHeader_Section_Stack",
    sections:
    [
         {title:"<spring:message code='Shipment.title'/>", items:VLayout_Body_ShipmentByWarehouseIssueCathode   ,expanded:true}
        ,{title:"<spring:message code='Shipment.titleWarehouseIssueCathode'/>", items:VLayout_WarehouseIssueCathode_Body ,expanded:true}
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
	criteria: [{fieldName: "material.code", operator: "equals", value: "74031100"}]
};
ListGrid_ShipmentByWarehouseIssueCathode .fetchData(criteria1, function (dsResponse, data, dsRequest) {
	ListGrid_ShipmentByWarehouseIssueCathode .setData(data);
	});

 function ListGrid_WarehouseIssueCathode_refresh() {
       record=ListGrid_ShipmentByWarehouseIssueCathode .getSelectedRecord();
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
        };
        ListGrid_WarehouseIssueCathode.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_WarehouseIssueCathode.setData(data);

        });
}

