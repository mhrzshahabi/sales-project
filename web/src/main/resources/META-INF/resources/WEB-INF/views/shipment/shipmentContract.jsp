
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />
    var contactId;



    //---------------------------------------------------------- shipment Header--------------------------------------------------------------------------------------------
    // function ListGrid_Shipment_HeaderByShipContract_refresh() {
    //     alert("reza jooon");
    //     ListGrid_Shipment_HeaderByShipContract.invalidateCache();
    //     var record = ListGrid_Shipment_HeaderByShipContract.getSelectedRecord();
    //     if (record == null || record.id == null)
    //         return;
    //     ListGrid_ShipmentByContract.fetchData({}, function (dsResponse, data, dsRequest) {
    //         ListGrid_ShipmentByContract.setData(data);
    //     }, {operationId: "00"});
    // }


    var RestDataSource_ShipmentContract = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},

                {
                        name: "no",
                        title: "<spring:message code='shipmentContract.no'/>",
                        align: "center",
                        width: "10%"
                },


                {
                    name: "capacity",
                    title: "<spring:message code='shipmentContract.capacity'/>",
                    align: "center",
                    width: "10%"
                },

                {
                    name: "laycanStart",
                    title: "<spring:message code='shipmentContract.laycanStart'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "laycanEnd",
                    title: "<spring:message code='shipmentContract.laycanEnd'/>",
                    align: "center",
                    width: "10%"
                },



                {
                    name: "dischargeRate",
                    title: "<spring:message code='shipmentContract.dischargeRate'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "demurrage",
                    title: "<spring:message code='shipmentContract.demurrage'/>",
                    align: "center",
                    width: "10%"
                },

                {
                    name: "freight",
                    title: "<spring:message code='shipmentContract.freight'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "bale",
                    title: "<spring:message code='shipmentContract.bale'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "grain",
                    title: "<spring:message code='shipmentContract.grain'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "grossWeight",
                    title: "<spring:message code='shipmentContract.grossWeight'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "vesselName",
                    title: "<spring:message code='shipmentContract.vesselName'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "yearOfBuilt",
                    title: "<spring:message code='shipmentContract.yearOfBuilt'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "imoNo",
                    title: "<spring:message code='shipmentContract.imoNo'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "officialNo",
                    title: "<spring:message code='shipmentContract.officialNo'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "loa",
                    title: "<spring:message code='shipmentContract.loa'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "beam",
                    title: "<spring:message code='shipmentContract.beam'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "cranes",
                    title: "<spring:message code='shipmentContract.cranes'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "holds",
                    title: "<spring:message code='shipmentContract.holds'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "hatch",
                    title: "<spring:message code='shipmentContract.hatch'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "classType",
                    title: "<spring:message code='shipmentContract.classType'/>",
                    align: "center",
                    width: "10%"
                },

                {
                    name: "createDate",
                    title: "<spring:message code='shipmentContract.shipmentContractDate'/>",
                    align: "center",
                    width: "10%"
                },

                {
                    name: "shipFlag",
                    title: "<spring:message code='shipment.flag'/>",
                    align: "center",
                    width: "10%"
                },


                  {
                    name: "weighingMethodes",
                    title: "<spring:message code='shipmentContract.weighingMethodes'/>",
                    align: "center",
                    width: "10%"
                },

                {
                name: "dispatch",
                title: "<spring:message code='shipmentContract.dispatch'/>",
                align: "center",
                width: "10%"
                },

            ],
            fetchDataURL: "${contextPath}/api/shipmentContract/spec-list"
    });



/*Save*/
    var IButton_ShipmentContract_Save = isc.IButton.create({
    	top: 260,
    	title: "<spring:message code='global.form.save'/>",
    	icon: "pieces/16/save.png",
    	click: function() {
    		DynamicForm_ShipmentContract.validate();
    		if (DynamicForm_ShipmentContract.hasErrors())
    			return;
    		var data = DynamicForm_ShipmentContract.getValues();
    		console.table(data);

    		var method = "PUT";
    		if (data.id == null)
    			method = "POST";
    		isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
    			actionURL: "${contextPath}/api/shipmentContract", //TODO
    			httpMethod: method,
    			data: JSON.stringify(data),
    			callback: function(resp) {
    				if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
    					isc.say("<spring:message code='global.form.request.successful'/>.");
    					ListGrid_ShipmentContract_refresh();
    					Window_ShipmentContract.hide();
    				} else
    					isc.say(RpcResponse_o.data);
    			}
    		}));
    	}
    });
/*Save*/


    var IButton_ShipmentContract_Cancel = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_ShipmentContract.close();
        }
    });

    function ListGrid_ShipmentContract_refresh() {
        ListGrid_ShipmentContract.invalidateCache();
        // var record = ListGrid_Shipment_HeaderByShipContract.getSelectedRecord();
        // if (record == null || record.id == null)
        //     return;
        // ListGrid_ShipmentContract.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
        //     ListGrid_ShipmentContract.setData(data);
        // }, {operationId: "00"});
    }

    function ListGrid_ShipmentContract_edit() {
        var record = ListGrid_ShipmentContract.getSelectedRecord()
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
            DynamicForm_ShipmentContract.editRecord(record);
            Window_ShipmentContract.show();
        }
    }

    function ListGrid_ShipmentContract_remove() {

        var record = ListGrid_ShipmentContract.getSelectedRecord();
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
                    buttons: [isc.Button.create({
                    title: "<spring:message code='global.yes'/>"

                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                            var shipmentContractId = record.id;
                            isc.RPCManager.sendRequest({
                            actionURL: "rest/shipmentContract/remove/" + shipmentContractId,
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    ListGrid_ShipmentContract_refresh();
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            }
                        });
                    }
                }
            });
        }
    }

    var Menu_ListGrid_ShipmentContract = isc.Menu.create({
    	width: 150,
    	data: [{
    			title: "<spring:message code='global.form.refresh'/>",
    			icon: "pieces/16/refresh.png",
    			click: function() {
    				DynamicForm_ShipmentContract.clearValues();
    				Window_ShipmentContract.show();
    			}
    		},
    		{
    			title: "<spring:message code='global.form.new'/>",
    			icon: "pieces/16/icon_add.png",
    			click: function() {}
    		},
    		{
    			title: "<spring:message code='global.form.edit'/>",
    			icon: "pieces/16/icon_edit.png",
    			click: function() {
    				ListGrid_ShipmentContract_edit();
    			}
    		},
    		{
    			title: "<spring:message code='global.form.remove'/>",
    			icon: "pieces/16/icon_delete.png",
    			click: function() {
    				ListGrid_ShipmentContract_remove();
    			}
    		}
    	]
    });



        /*Change Date Source Select from shipment*/
        var RestDataSource_shipment = isc.MyRestDataSource.create({
        	fields: [{
        			name: "id",
        			title: "id",
        			primaryKey: true,
        			canEdit: false,
        			hidden: true
        		},
        		{
        			name: "warehouseCad.warehouseYardId",
        			title: "<spring:message code='warehouseCad.yard'/>"
        		},
        		{
        			name: "warehouseCad.bijackNo",
        			title: "<spring:message code='warehouseCad.bijackNo'/>"
        		},
        		{
        			name: "bundleSerial",
        			title: "<spring:message code='warehouseCadItem.bundleSerial'/>"
        		},
        		{
        			name: "sheetNo",
        			title: "<spring:message code='warehouseCadItem.sheetNo'/>"
        		},
        	],
        	fetchDataURL: "${contextPath}/api/shipment/spec-list"
        });





  function warehouseIssueCathode_bijak () {

        // var ClientData_WarehouseCadITEMByWarehouseIssueCathode = [];
        // var ids= DynamicForm_WarehouseIssueCathode.getValue("bijakIds");
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
                            console.log('data');
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
        } else warehouseIssueCathode_bijak_show();


    function warehouseIssueCathode_bijak_show(){

              var ClientDataSource_WarehouseCadITEMByWarehouseIssueCathode = isc.DataSource.create({
      	fields: [{
      			name: "id",
      			title: "id",
      			primaryKey: true,
      			canEdit: false,
      			hidden: true
      		},
      		{
      			name: "warehouseCad.bijackNo",
      			title: "<spring:message code='warehouseCad.bijackNo'/>"
      		},
      		{
      			name: "bundleSerial",
      			title: "<spring:message code='warehouseCadItem.bundleSerial'/>"
      		},
      		{
      			name: "sheetNo",
      			title: "<spring:message code='warehouseCadItem.sheetNo'/>"
      		},
      	],
      	// testData: ClientData_WarehouseCadITEMByWarehouseIssueCathode,
      	clientOnly: true
      });


        /* ****************** */

    var ListGrid_WarehouseCadITEMByWarehouseIssueCathode = isc.ListGrid.create({
    	width: "100%",
    	height: "100%",
    	// dataSource: RestDataSource_WarehouseCadITEMByWarehouseIssueCathode ,
    	sortField: 0,
    	canDragRecordsOut: true,
    	dragDataAction: "copy",
    	canReorderRecords: true,
    	dataPageSize: 50,
    	autoFetchData: false,
    	showFilterEditor: true,
    	filterOnKeypress: true,
    	fields: [{
    			name: "month",
    			title: "<spring:message code='shipment.month'/>",
    			type: 'text',
    			width: "10%"
    		},
    		{
    			name: "createDate",
    			title: "<spring:message code='shipment.createDate'/>",
    			type: 'text',
    			width: "10%"
    		},
    		{
    			name: "materialId",
    			title: "<spring:message code='contact.name'/>",
    			type: 'long',
    			hidden: true
    		},
    		{
    			name: "material.descl",
    			title: "<spring:message code='material.descl'/>",
    			type: 'text'
    		},

    	]
    });

    var ListGrid_WarehouseCadITEMByWarehouseIssueCathode_selected = isc.ListGrid.create({
    	width: "100%",
    	height: "100%",
    	// dataSource: ClientDataSource_WarehouseCadITEMByWarehouseIssueCathode ,
    	// data: ClientData_WarehouseCadITEMByWarehouseIssueCathode ,
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



    /*فیلد های ویندو*/
 var DynamicForm_ShipmentContract = isc.DynamicForm.create({
 	width: "900",
 	height: "100%",
 	wrapItemTitles: false,
 	autoDraw: false,
 	autoFocus: "true",
 	setMethod: 'POST',
 	align: "center",
 	canSubmit: true,
 	showInlineErrors: true,
 	showErrorText: true,
 	showErrorStyle: true,
 	errorOrientation: "left",
 	titleWidth: "100",
 	titleAlign: "right",
 	numCols: 8,
 	requiredMessage: "<spring:message code='validator.field.is.required'/>", //فیلد اجباری است.
 	fields: [{
 			name: "id",
 			title: "id",
 			primaryKey: true,
 			canEdit: false,
 			hidden: true
 		},

 		{
 			name: "no",
 			title: "<spring:message code='shipmentContract.no'/>", //شماره
 			align: "center",
 			colSpan: 2,
 			width: "200"
 		},

 		{
 			name: "select haml",
 			title: "<spring:message code='shipmentContract.selected'/>",
 			align: "center",
 			colSpan: 2,
 			width: "200",
 			icons: [{
 				src: "pieces/add-selection.png",
 				click: function() {
 					warehouseIssueCathode_bijak();

 				}
 			}]
 		},

 		{
 			name: "capacity",
 			title: "<spring:message code='shipmentContract.capacity'/>", //ظرفیت
 			align: "center",
 			colSpan: 2,
 			width: "200"
 		},
 		{
 			name: "laycanStart",
 			ID: "laycanStart",
 			title: "<spring:message code='shipmentContract.laycanStart'/>", //شروع لغو تاریخ
 			align: "right",
 			width: "200",
 			icons: [{
 				src: "pieces/pcal.png",
 				click: function() {
 					displayDatePicker('laycanStart', this, 'ymd', '/');
 				}
 			}],
 			blur: function() {
 				var value = DynamicForm_ShipmentContract.getItem('laycanStart').getValue();
 				if (value != null && value.length != 10 && value != "") {
 					DynamicForm_ShipmentContract.setValue('laycanStart', CorrectDate(value))
 				}
 			},
 			colSpan: 2
 		},
 		{
 			name: "laycanEnd",
 			ID: "laycanEnd",
 			title: "<spring:message code='shipmentContract.laycanEnd'/>", //پایان لغو تاریخ
 			align: "right",
 			width: "200",
 			icons: [{
 				src: "pieces/pcal.png",
 				click: function() {
 					displayDatePicker('laycanEnd', this, 'ymd', '/');
 				}

 			}],
 			blur: function() {
 				var value = DynamicForm_ShipmentContract.getItem('laycanEnd').getValue();
 				if (value != null && value.length != 10 && value != "") {
 					DynamicForm_ShipmentContract.setValue('laycanEnd', CorrectDate(value))
 				}
 			},
 			colSpan: 2
 		},
 		{
 			name: "loadingRate",
 			title: "<spring:message code='shipmentContract.loadingRate'/>", //نرخ بارگیری
 			align: "center",
 			width: "200",
 			colSpan: 2
 		},
 		{
 			name: "dischargeRate",
 			title: "<spring:message code='shipmentContract.dischargeRate'/>", //میزان تخلیه
 			align: "center",
 			colSpan: 2,
 			width: "200",
 			required: true
 		},
 		{
 			name: "demurrage",
 			title: "<spring:message code='shipmentContract.demurrage'/>", //جریمه
 			align: "center",
 			colSpan: 2,
 			width: "200"
 		},

 		{
 			name: "freight",
 			title: "<spring:message code='shipmentContract.freight'/>", //کرایه
 			align: "center",
 			colSpan: 2,
 			width: "200"
 		},
 		{
 			name: "bale",
 			title: "<spring:message code='shipmentContract.bale'/>", //فضای موجود برای محموله های اندازه گیری شده
 			align: "center",
 			colSpan: 2,
 			width: "200"

 		},
 		{
 			name: "grain",
 			title: "<spring:message code='shipmentContract.grain'/>", //حداکثر فضای موجود برای محمول
 			align: "center",
 			colSpan: 2,
 			width: "200"
 		},
 		{
 			name: "grossWeight",
 			title: "<spring:message code='shipmentContract.grossWeight'/>", //وزن ناخالص/مرطوب
 			align: "center",
 			colSpan: 2,
 			width: "200"
 		},
 		{
 			name: "vesselName",
 			title: "<spring:message code='shipmentContract.vesselName'/>", //نام کشتی
 			align: "center",
 			colSpan: 2,
 			required: true,
 			width: "200"
 		},
 		{
 			name: "yearOfBuilt",
 			title: "<spring:message code='shipmentContract.yearOfBuilt'/>", //سال ساخت
 			align: "center",
 			colSpan: 2,
 			required: true,
 			width: "200"
 		},
 		{
 			name: "imoNo",
 			title: "<spring:message code='shipmentContract.imoNo'/>", //(IMO)سازمان بین المللی دریایی
 			align: "center",
 			colSpan: 2,
 			required: true,
 			width: "200"
 		},
 		{
 			name: "officialNo",
 			title: "<spring:message code='shipmentContract.officialNo'/>", //شماره رسمس
 			align: "center",
 			colSpan: 2,
 			required: true,
 			width: "200"
 		},
 		{
 			name: "loa",
 			title: "<spring:message code='shipmentContract.loa'/>", //(LOA)طول ماكزيمم كشتي
 			align: "center",
 			colSpan: 2,
 			required: true,
 			width: "200"
 		},
 		{
 			name: "beam",
 			title: "<spring:message code='shipmentContract.beam'/>", //(BEAM)عرض ماكزيمم عرش كشتي
 			align: "center",
 			colSpan: 2,
 			required: true,
 			width: "200"
 		},
 		{
 			name: "cranes",
 			title: "<spring:message code='shipmentContract.cranes'/>", //جرثقیل
 			align: "center",
 			colSpan: 2,
 			required: true,
 			width: "200"
 		},
 		{
 			name: "holds",
 			title: "<spring:message code='shipmentContract.holds'/>", //نگه دارنده
 			align: "center",
 			colSpan: 2,
 			width: "200"
 		},
 		{
 			name: "hatch",
 			title: "<spring:message code='shipmentContract.hatch'/>", //انبار كشتي
 			align: "center",
 			colSpan: 2,
 			width: "200"
 		},
 		{
 			name: "classType",
 			title: "<spring:message code='shipmentContract.classType'/>", //نوع کلاس
 			align: "center",
 			colSpan: 2,
 			width: "200"
 		},
 		{
 			name: "createDate",
 			ID: "createDate",
 			title: "<spring:message code='shipmentContract.shipmentContractDate'/>", //تاریخ ایجاد
 			align: "right",
 			width: "200",
 			icons: [{
 				src: "pieces/pcal.png",
 				click: function() {
 					displayDatePicker('createDate', this, 'ymd', '/');
 				}
 			}],

 			blur: function() {
 				var value = DynamicForm_ShipmentContract.getItem('createDate').getValue();
 				if (value != null && value.length != 10 && value != "") {
 					DynamicForm_ShipmentContract.setValue('createDate', CorrectDate(value))
 				}
 			},
 			colSpan: 2
 		},

 		{
 			name: "weighingMethodes",
 			title: "<spring:message code='shipmentContract.weighingMethodes'/>", //روش توزين
 			type: 'text',
 			width: "200",
 			required: true,
 			colSpan: 2,
 			valueMap: {
 				"draft survey": "<spring:message code='shipmentContract.draftSurvey'/>" //بازرسي درافت كشتي
 					,
 				"weighbridge": "<spring:message code='shipmentContract.weighbridge'/>" //باسكول
 			}
 		},

 		{
 			name: "shipFlag",
 			title: "<spring:message code='shipmentContract.countryFlag'/>",
 			type: 'text',
 			width: "200",
 			colSpan: 2,
 			valueMap: {
 				"IRAN": "<spring:message code='shipment.flag.iran'/>" //بازرسي درافت كشتي
 			}
 		},
 	]
 });




    var ToolStripButton_ShipmentContract_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentContract_refresh();
        }
    });


    var ToolStripButton_ShipmentContract_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
                Window_ShipmentContract.show();
            }
    });


    var ToolStripButton_ShipmentContract_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ShipmentContract_edit();
        }
    });

    var ToolStripButton_ShipmentContract_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ShipmentContract_remove();
        }
    });


    var ToolStrip_Actions_ShipmentContract = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_ShipmentContract_Refresh,
                ToolStripButton_ShipmentContract_Add,
                ToolStripButton_ShipmentContract_Edit,
                ToolStripButton_ShipmentContract_Remove,
            ]
    });


    var HLayout_ShipmentContract_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_ShipmentContract
            ]
    });



    var Window_ShipmentContract = isc.Window.create({
        title: "<spring:message code='shipmentContract.title'/>",
        width: "28%",
        height: "30%",
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        margin: '10px',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            DynamicForm_ShipmentContract,
            isc.HLayout.create({
                width: "100%",
                members:
                    [
                IButton_ShipmentContract_Save,
                IButton_ShipmentContract_Cancel
                    ]
            })
        ]
    });




/*قرارداد حمل*/
    var ListGrid_ShipmentContract = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentContract,
        contextMenu: Menu_ListGrid_ShipmentContract,
        fields:
            [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true ,
                    width:"10%"
                },


                {
                    name: "createDate",
                    title: "<spring:message code='shipmentContract.shipmentContractDate'/>",
                    align: "center" ,width:"10%"
                },


                {
                    name: "shipFlag",
                    title: "<spring:message code='shipmentContract.countryFlag'/>",
                    align: "center",
                    width: "10%"

                },
                {
                    name: "no",
                    title: "<spring:message code='shipmentContract.no'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "capacity",
                    title: "<spring:message code='shipmentContract.capacity'/>",
                    align: "center",
                    width: "10%"
                },

                {
                    name: "tblPortByDischargePort.port",
                    title: "<spring:message    code='shipmentContract.dischargePort'/>",
                    align: "center",
                    width: "10%"

                },
                {
                    name: "laycanStart",
                    title: "<spring:message code='shipmentContract.laycanStart'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "laycanEnd",
                    title: "<spring:message code='shipmentContract.laycanEnd'/>",
                    align: "center",
                    width: "10%"
                },

            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
        },
        dataArrived: function (startRow, endRow) {
        }
    });




    var HLayout_ShipmentContract_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentContract
        ]
    });

    var VLayout_ShipmentContract_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_ShipmentContract_Actions, HLayout_ShipmentContract_Grid
            ]
    });

    //-----------------------------------------SectionStack-----------------------------------------------------------------

    isc.SectionStack.create({
        ID: "Shipment_Section_Stack",
        sections:
            [
                 {
                title: "<spring:message code='shipmentContract.title'/>",
                items: VLayout_ShipmentContract_Body,
                expanded: true
                 }
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });

