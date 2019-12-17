
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />
    var contactId;


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


    var IButton_ShipmentContract_Save = isc.IButton.create({
    	top: 260,
    	title: "<spring:message code='global.form.save'/>",
    	icon: "pieces/16/save.png",
    	click: function() {
    		DynamicForm_ShipmentContract.validate();
    		// console.log(DynamicForm_ShipmentContract);
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


   var IButton_ShipmentContract_Cancel = isc.IButton.create({
   	top: 260,
   	title: "<spring:message code='global.cancel'/>",
   	icon: "pieces/16/icon_delete.png",
   	click: function() {
   		Window_ShipmentContract.close();
   	}
   });


    function ListGrid_ShipmentContract_refresh() {
    	ListGrid_ShipmentContract.invalidateCache();
    }


    function ListGrid_ShipmentContract_edit() {
    	var record = ListGrid_ShipmentContract.getSelectedRecord()
    	if (record == null || record.id == null) {
    		isc.Dialog.create({
    			message: "<spring:message code='global.grid.record.not.selected'/>",
    			icon: "[SKIN]ask.png",
    			title: "<spring:message code='global.message'/>",
    			buttons: [isc.Button.create({
    				title: "<spring:message code='global.ok'/>"
    			})],
    			buttonClick: function() {
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
    			buttons: [isc.Button.create({
    				title: "<spring:message code='global.ok'/>"
    			})],
    			buttonClick: function() {
    				this.hide();
    			}
    		});
    	} else {
    		isc.Dialog.create({
    			message: "<spring:message code='global.grid.record.remove.ask'/>",
    			icon: "[SKIN]ask.png",
    			title: "<spring:message code='global.grid.record.remove.ask.title'/>",
    			buttons: [
    				isc.Button.create({
    					title: "<spring:message code='global.yes'/>"
    				}),
    				isc.Button.create({
    					title: "<spring:message code='global.no'/>"
    				})
    			],
    			buttonClick: function(button, index) {
    				this.hide();
    				if (index == 0) {
    					var shipmentContractId = record.id;
    					isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
    						actionURL: "${contextPath}/api/shipmentContract/" + shipmentContractId,
    						httpMethod: "DELETE",
    						callback: function(resp) {
    							if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
    								ListGrid_ShipmentContract_refresh();
    								isc.say("<spring:message code='global.grid.record.remove.success'/>.");
    							} else {
    								isc.say("<spring:message code='global.grid.record.remove.failed'/>");
    							}
    						}
    					}));
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
				// DynamicForm_ShipmentContract.clearValues();
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



var dash = "\n";
 var DynamicForm_ShipmentContract = isc.DynamicForm.create({
	styleName: 'Shipment_style',
	width: "1000",
	height: "100%",
	wrapItemTitles: false,
	autoDraw: false,
	autoFocus: "true",
	dataPageSize: 50,
	setMethod: 'POST',
	align: "center",
	canSubmit: true,
	showInlineErrors: true,
	showErrorText: true,
	showErrorStyle: true,
	errorOrientation: "right",
	titleWidth: "100",
	titleAlign: "right",
	numCols: 7,
	membersMargin: '5px',
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
			width: "200",
			required: true,
		},

		{
			colSpan: 2,
			name: "capacity",
			title: "<spring:message code='shipmentContract.capacity'/>", //ظرفیت
			align: "center",
			width: "200",
			required: true,
		},

		{
			colSpan: 2,
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

		},


		{
			colSpan: 2,
			name: "loadingRate",
			title: "<spring:message code='shipmentContract.loadingRate'/>", //نرخ بارگیری
			align: "center",
			width: "200",

		},
		{
			name: "dischargeRate",
			title: "<spring:message code='shipmentContract.dischargeRate'/>", //میزان تخلیه
			align: "center",
			colSpan: 2,
			width: "200",

		},
		{
			colSpan: 2,
			name: "demurrage",
			title: "<spring:message code='shipmentContract.demurrage'/>", //جریمه
			align: "center",
			width: "200"
		},

		{
			colSpan: 2,
			name: "freight",
			title: "<spring:message code='shipmentContract.freight'/>", //کرایه
			align: "center",
			width: "200"
		},
		{
			colSpan: 2,
			name: "bale",
			title: "<spring:message code='shipmentContract.bale'/>", //فضای موجود برای محموله های اندازه گیری شده
			align: "center",
			width: "200"

		},
		{
			colSpan: 2,
			name: "grain",
			title: "<spring:message code='shipmentContract.grain'/>", //حداکثر فضای موجود برای محمول
			align: "center",
			width: "200"
		},
		{
			colSpan: 2,
			name: "grossWeight",
			title: "<spring:message code='shipmentContract.grossWeight'/>", //وزن ناخالص/مرطوب
			align: "center",
			width: "200"
		},
		{
			colSpan: 2,
			name: "vesselName",
			title: "<spring:message code='shipmentContract.vesselName'/>", //نام کشتی
			align: "center",
			width: "200"
		},
		{
			colSpan: 2,
			name: "yearOfBuilt",
			title: "<spring:message code='shipmentContract.yearOfBuilt'/>", //سال ساخت
			align: "center",

			width: "200"
		},
		{
			colSpan: 2,
			name: "imoNo",
			title: "<spring:message code='shipmentContract.imoNo'/>", //(IMO)سازمان بین المللی دریایی
			align: "center",

			width: "200"
		},
		{
			colSpan: 2,
			name: "officialNo",
			title: "<spring:message code='shipmentContract.officialNo'/>", //شماره رسمس
			align: "center",

			width: "200"
		},
		{
			colSpan: 2,
			name: "loa",
			title: "<spring:message code='shipmentContract.loa'/>", //(LOA)طول ماكزيمم كشتي
			align: "center",

			width: "200"
		},
		{
			colSpan: 2,
			name: "beam",
			title: "<spring:message code='shipmentContract.beam'/>", //(BEAM)عرض ماكزيمم عرش كشتي
			align: "center",

			width: "200"
		},
		{
			colSpan: 2,
			name: "cranes",
			title: "<spring:message code='shipmentContract.cranes'/>", //جرثقیل
			align: "center",

			width: "200"
		},
		{
			colSpan: 2,
			name: "holds",
			title: "<spring:message code='shipmentContract.holds'/>", //نگه دارنده
			align: "center",
			width: "200"
		},
		{
			colSpan: 2,
			name: "hatch",
			title: "<spring:message code='shipmentContract.hatch'/>", //انبار كشتي
			align: "center",
			width: "200"
		},
		{
			colSpan: 2,
			name: "classType",
			title: "<spring:message code='shipmentContract.classType'/>", //نوع کلاس
			align: "center",
			width: "200"
		},

		{
			colSpan: 2,
			align: "center",
			name: "weighingMethodes",
			title: "<spring:message code='shipmentContract.weighingMethodes'/>", //روش توزين
			type: 'text',
			width: "200",
			valueMap: {
				"draft survey": "<spring:message code='shipmentContract.draftSurvey'/>" //بازرسي درافت كشتي
					,
				"weighbridge": "<spring:message code='shipmentContract.weighbridge'/>" //باسكول
			}
		},
		{
			colSpan: 2,
			name: "laycanStart",
			ID: "laycanStart",
			title: "<spring:message code='shipmentContract.laycanStart'/>", //شروع لغو تاریخ
			align: "center",
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

		},
		{
			required: true,
			colSpan: 2,
			name: "createDate",
			ID: "createDate",
			title: "<spring:message code='shipmentContract.shipmentContractDate'/>", //تاریخ ایجاد
			align: "center",
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

		},
		{
			required: true,
			colSpan: 2,
			name: "shipFlag",
			title: "<spring:message code='shipmentContract.countryFlag'/>",
			type: 'text',
			width: "200",

			valueMap: {
				"IRAN": "<spring:message code='shipment.flag.iran'/>" //بازرسي درافت كشتي
			}
		},
		{
			type: "Header", defaultValue: dash
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
        width: 900,
        height: "400",
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
            DynamicForm_ShipmentContract,
            isc.HLayout.create({
                align:"center",
                width: "100%",
                members:
                    [
                    IButton_ShipmentContract_Save,
                    isc.Label.create({   width: 5,    }),
                    IButton_ShipmentContract_Cancel
                    ]
            })
        ]
    });



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
	members: [
		HLayout_ShipmentContract_Actions, HLayout_ShipmentContract_Grid
	]
});



isc.SectionStack.create({
	ID: "Shipment_Section_Stack",
	sections: [{
		title: "<spring:message code='shipmentContract.title'/>",
		items: VLayout_ShipmentContract_Body,
		expanded: true
	}],
	visibilityMode: "multiple",
	animateSections: true,
	height: "100%",
	width: "100%",
	overflow: "hidden"
});