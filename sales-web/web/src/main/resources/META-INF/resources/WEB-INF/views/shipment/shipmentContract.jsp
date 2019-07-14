<%@ page import="com.nicico.core.copper.config.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	<% DateUtil dateUtil = new DateUtil();%>
	var contactId;
	var RestDataSource_Shipment_HeaderByShipContract = isc.RestDataSource.create({
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, align: "center", hidden: true},
			{name: "shipmentHeaderDate", title: "<spring:message code='shipmentHeader.date'/>", align: "center"},
			{name: "description", title: "<spring:message code='shipmentHeader.description'/>", align: "center"}

		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/shipmentHeader/list"
	});
	var RestDataSource_CountryByShipmentContract = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, hidden: true},
				{name: "code", title: "<spring:message code='goods.code'/> "},
				{name: "nameEn", title: "<spring:message code='global.country'/> "}
			],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/country/list"
	});
	var RestDataSource_Shipment_PriceByContract = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "capacity",
					title: "<spring:message code='shipment.Price.capacity'/>",
					type: 'long',
					hidden: true
				},
				{name: "tblCountryByflag.id", type: 'long', hidden: true},
				{name: "tblShipmentInquiry.id", title: "<spring:message code='shipment.inquiry.id'/>", type: 'text'},
				{
					name: "tblContactByCompany.nameEn",
					title: "<spring:message code='shipment.Price.shipingCompany'/>",
					type: 'text'
				},
				{
					name: "laycanStart",
					title: "<spring:message code='shipment.Price.laycanStart'/>",
					type: 'long',
					hidden: true
				},
				{name: "laycanEnd", title: "<spring:message code='shipment.Price.laycanEnd'/>", type: 'text'},
				{name: "loadingRate", title: "<spring:message code='shipment.Price.loadingRate'/>", type: 'text'},
				{name: "dischargeRate", title: "<spring:message code='shipment.Price.dischargeRate'/>", type: 'float'},
				{name: "demurrage", title: "<spring:message code='shipment.Price.demurrage'/>", type: 'integer'},
				{
					name: "dispatch",
					title: "<spring:message code='shipment.Price.dispatch'/>",
					type: 'text',
					width: "10%"
				},
				{
					name: "freight",
					title: "<spring:message code='shipment.Price.freight'/>",
					type: 'text',
					required: true,
					width: "10%"
				},
				{
					name: "vesselName", title: "<spring:message
		code='shipment.Price.vessel'/>", type: 'text', required: true, width: "10%"
				},
				{
					name: "yearOfBuilt", title: "<spring:message
		code='shipment.Price.yearOfBuilt'/>", type: 'text', required: true, width: "10%"
				},
				{name: "imo", title: "<spring:message code='shipment.Price.imo'/>", type: 'text', width: "10%"},
				{
					name: "holds",
					title: "<spring:message code='shipment.Price.holds'/>",
					type: 'text',
					required: true,
					width: "10%"
				},
			],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/shipmentPrice/list"
	});

	var RestDataSource_ContactByShipmentContract = isc.RestDataSource.create({
		fields:
			[
				{name: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "code", title: "<spring:message code='contact.code'/>"},
				{name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
				{name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
				{name: "commertialRole"},
				{name: "phone", title: "<spring:message code='contact.phone'/>"},
				{name: "mobile", title: "<spring:message code='contact.mobile'/>"},
				{name: "email", title: "<spring:message code='contact.email'/>"},
				{
					name: "type", title: "<spring:message code='contact.type'/>", valueMap: {
						"true": "<spring:message
		code='contact.type.real'/>", "false": "<spring:message code='contact.type.legal'/>"
					}
				},
				{name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
				{
					name: "status", title: "<spring:message code='contact.status'/>", valueMap: {
						"true": "<spring:message
		code='enabled'/>", "false": "<spring:message code='disabled'/>"
					}
				},
				{name: "contactAccounts"}
			],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/contact/list"
	});
	var RestDataSource_ShipmentByContract = isc.RestDataSource.create({
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{
				name: "tblContractItemShipment.id",
				title: "<spring:message code='contact.name'/>",
				type: 'long',
				hidden: true
			},
			{name: "tblContact.id", type: 'long', hidden: true},
			{name: "tblContact.nameFA", title: "<spring:message code='contact.name'/>", type: 'text'},
			{name: "tblMaterial.id", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
			{name: "tblMaterial.descl", title: "<spring:message code='material.descl'/>", type: 'text'},
			{name: "tblMaterial.tblUnit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},
			{name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
			{name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
			{
				name: "tblPortByLoading.port",
				title: "<spring:message code='shipment.loading'/>",
				type: 'text',
				width: "10%"
			},
			{
				name: "tblPortByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%"
			},
			{
				name: "tblPortByLoading.id",
				title: "<spring:message code='shipment.loading'/>",
				type: 'text',
				width: "10%"
			},
			{
				name: "tblPortByDischarge.id", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%"
			},
			{
				name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%"
			},
			{
				name: "month",
				title: "<spring:message code='shipment.month'/>",
				type: 'text',
				required: true,
				width: "10%"
			},
			{
				name: "status", title: "<spring:message
		code='shipment.staus'/>", type: 'text', width: "10%", valueMap: {
					"Load Ready": "<spring:message
		code='shipment.loadReady'/>", "Resource": "<spring:message code='shipment.resource'/>"
				}
			},
			{
				name: "createDate",
				title: "<spring:message code='shipment.createDate'/>",
				type: 'text',
				required: true,
				width: "10%"
			},
			{
				name: "shipmentType", title: "<spring:message
		code='shipment.inquiry.type'/>", type: 'text', width: "10%", align: "center"
				, valueMap: {
					"b": "<spring:message code='shipment.inquiry.bulk'/>"
					, "c": "<spring:message code='shipment.inquiry.container'/>"
				}
			}
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/shipment/list"
	});

	//---------------------------------------------------------- shipment Header--------------------------------------------------------------------------------------------
	function ListGrid_Shipment_HeaderByShipContract_refresh() {
		ListGrid_Shipment_HeaderByShipContract.invalidateCache();
		var record = ListGrid_Shipment_HeaderByShipContract.getSelectedRecord();
		if (record == null || record.id == null)
			return;
		ListGrid_ShipmentByContract.fetchData({}, function (dsResponse, data, dsRequest) {
			ListGrid_ShipmentByContract.setData(data);
		}, {operationId: "00"});
	}

	var ListGrid_Shipment_HeaderByShipContract = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Shipment_HeaderByShipContract,

		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, align: "center", hidden: true},
			{name: "shipmentHeaderDate", title: "<spring:message code='shipmentHeader.date'/>", align: "center"},
			{name: "description", title: "<spring:message code='shipmentHeader.description'/>", align: "center"}
		],
		recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
		updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
			var record = this.getSelectedRecord();

			ListGrid_ShipmentByContract.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
				ListGrid_ShipmentByContract.setData(data);
			}, {operationId: "00"});

			ListGrid_ShipmentContract.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
				ListGrid_ShipmentContract.setData(data);
			}, {operationId: "00"});
		},
		dataArrived: function (startRow, endRow) {
		},
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: true,
		showFilterEditor: true,
		filterOnKeypress: true,
		startsWithTitle: "tt"
	});
	var HLayout_Grid_Shipment_HeaderByShipContract = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_Shipment_HeaderByShipContract
		]
	});

	var VLayout_Body_Shipment_HeaderByShipContract = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [

			HLayout_Grid_Shipment_HeaderByShipContract
		]
	});
	//---------------------------------------------------------- Shipment By Contract--------------------------------------------------------------------------------------------
	var ListGrid_ShipmentByContract = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_ShipmentByContract,
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "tblContractItemShipment.id", hidden: true, type: 'long'},
			{name: "tblContact.id", type: 'long', hidden: true},
			{name: "tblContractItemShipment.tblContractItem.tblContract.id", type: 'long', hidden: true},
			{
				name: "tblContact.nameFA", title: "<spring:message
		code='contact.name'/>", type: 'text', width: "10%", align: "center",
			},
			{name: "tblMaterial.id", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
			{
				name: "tblMaterial.descl", title: "<spring:message
		code='material.descl'/>", type: 'text', width: "10%", align: "center",
			},
			{
				name: "tblMaterial.tblUnit.nameEN", title: "<spring:message
		code='unit.nameEN'/>", type: 'text', width: "10%", align: "center",
			},
			{
				name: "amount",
				title: "<spring:message code='global.amount'/>",
				type: 'float',
				width: "10%",
				align: "center",
			},
			{
				name: "noContainer", title: "<spring:message
		code='shipment.noContainer'/>", type: 'integer', width: "10%", align: "center",
			},
			{
				name: "tblPortByLoading.port", title: "<spring:message
		code='shipment.loading'/>", type: 'text', width: "10%", align: "center",
			},
			{
				name: "tblPortByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%", align: "center",
			},
			{
				name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%", align: "center",
			},
			{
				name: "month", title: "<spring:message
		code='shipment.month'/>", type: 'text', required: true, width: "10%", align: "center",
			},
			{
				name: "status",
				title: "<spring:message code='shipment.staus'/>",
				type: 'text',
				width: "10%",
				align: "center"
				,
				valueMap: {
					"Load Ready": "<spring:message code='shipment.loadReady'/>"
					, "Resource": "<spring:message code='shipment.resource'/>"
				}
			},
			{
				name: "shipmentType", title: "<spring:message
		code='shipment.inquiry.type'/>", type: 'text', width: "10%", align: "center"
				, valueMap: {
					"b": "<spring:message code='shipment.inquiry.bulk'/>"
					, "c": "<spring:message code='shipment.inquiry.container'/>"
				}
			}

		],
		recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
		updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
			/*var record = this.getSelectedRecord();
			contactId = record.tblContact.id;
			ListGrid_ShipmentContract.fetchData({"tblShipment.id":record.id},function (dsResponse, data, dsRequest) {ListGrid_ShipmentContract.setData(data);});*/
		},
		dataArrived: function (startRow, endRow) {
		},
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: false,
		showFilterEditor: true,
		filterOnKeypress: true,
		startsWithTitle: "tt"
	});
	var HLayout_Grid_ShipmentByContract = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_ShipmentByContract
		]
	});

	var VLayout_Body_ShipmentByContract = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Grid_ShipmentByContract
		]
	});
	//-------------------------------------------Email----------------------------------------------------------------------
	var RestDataSource_ShipmentContract = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "tblShipmentPrice.id",
					title: "<spring:message code='tblShipmentPrice.name'/>",
					align: "center",
					hidden: true
				},
				{
					name: "shipmentContractDate", title: "<spring:message
		code='shipmentContract.shipmentContractDate'/>", align: "center", hidden: true
				},
				{
					name: "tblContactByOwners.id",
					title: "<spring:message code='shipmentContract.owners'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "tblContactByCharterer.id", title: "<spring:message
		code='shipmentContract.charterer'/>", align: "center", width: "10%"
				},
				{
					name: "tblContactByChainOfOwners.id", title: "<spring:message
		code='shipmentContract.chainOfOwners'/>", align: "center", width: "10%"
				},
				{
					name: "tblCountryFlag.id", title: "<spring:message
		code='shipmentContract.countryFlag'/>", align: "center", width: "10%"
				},
				{name: "no", title: "<spring:message code='shipmentContract.no'/>", align: "center", width: "10%"},
				{
					name: "capacity",
					title: "<spring:message code='shipmentContract.capacity'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "tblPortByLoadPort.port", title: "<spring:message
		code='shipmentContract.loadPort'/>", align: "center", width: "10%"
				},
				{
					name: "tblPortByDischargePort.port", title: "<spring:message
		code='shipmentContract.dischargePort'/>", align: "center", width: "10%"
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
					name: "loadingRate",
					title: "<spring:message code='shipmentContract.loadingRate'/>",
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
					name: "dispatch",
					title: "<spring:message code='shipmentContract.dispatch'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "freight",
					title: "<spring:message code='shipmentContract.freight'/>",
					align: "center",
					width: "10%"
				},
				{name: "bale", title: "<spring:message code='shipmentContract.bale'/>", align: "center", width: "10%"},
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
				{name: "loa", title: "<spring:message code='shipmentContract.loa'/>", align: "center", width: "10%"},
				{name: "beam", title: "<spring:message code='shipmentContract.beam'/>", align: "center", width: "10%"},
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
					name: "createUser",
					title: "<spring:message code='global.createUser'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "createDate",
					title: "<spring:message code='global.createDate'/>",
					align: "center",
					width: "10%"
				},
			],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/shipmentContract/list"
	});

	var IButton_ShipmentContract_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			DynamicForm_ShipmentContract.validate();
			if (DynamicForm_ShipmentContract.hasErrors())
				return;

			var data = DynamicForm_ShipmentContract.getValues();
			isc.RPCManager.sendRequest({
				actionURL: "rest/shipmentContract/add",
				httpMethod: "POST",
				useSimpleHttp: true,
				contentType: "application/json; charset=utf-8",
				showPrompt: false,
				data: JSON.stringify(data),
				serverOutputAsString: false,
//params: { data:data1},
				callback: function (RpcResponse_o) {
					if (RpcResponse_o.data == 'success') {
						isc.say("<spring:message code='global.form.request.successful'/>.");
						ListGrid_ShipmentContract_refresh();
						Window_ShipmentContract.close();
					} else
						isc.say(RpcResponse_o.data);
				}
			});
		}
	});
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
		var record = ListGrid_Shipment_HeaderByShipContract.getSelectedRecord();
		if (record == null || record.id == null)
			return;
		ListGrid_ShipmentContract.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
			ListGrid_ShipmentContract.setData(data);
		}, {operationId: "00"});
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

		var record = ListGrid_ShipmentContract.getSelectedRecord()
		if (record == null || record.id == null) {
			isc.Dialog.create({
				message: "<spring:message code='global.grid.record.not.selected'/>",
				icon: "[SKIN]ask.png",
				title: "<spring:message code='global.message'/>",
				buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
				buttonClick: function () {
					hide();
				}
			});
		} else {
			isc.Dialog.create({
				message: "<spring:message code='global.grid.record.remove.ask'/>",
				icon: "[SKIN]ask.png",
				title: "<spring:message code='global.grid.record.remove.ask.title'/>",
				buttons: [isc.Button.create({
					title: "<spring:message
		code='global.yes'/>"
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
	};
	var Menu_ListGrid_ShipmentContract = isc.Menu.create({
		width: 150,
		data:
			[
				{
					title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
					click: function () {
						DynamicForm_ShipmentContract.clearValues();
						Window_ShipmentContract.show();
					}
				},
				{
					title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
					click: function () {
					}
				},
				{
					title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
					click: function () {
						ListGrid_ShipmentContract_edit();
					}
				},
				{
					title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
					click: function () {
						ListGrid_ShipmentContract_remove();
					}
				}
			]
	});
	var DynamicForm_ShipmentContract = isc.DynamicForm.create({
		width: "100%",
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
		errorOrientation: "right",
		titleWidth: "100",
		titleAlign: "right",
		numCols: 8,
		requiredMessage: "<spring:message code='validator.field.is.required'/>",
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "tblShipmentPrice.id",
					title: "<spring:message
		code='shipment.Price'/>",
					type: 'long',
					editorType: "SelectItem",
					colSpan: 2
					,
					optionDataSource: RestDataSource_Shipment_PriceByContract,
					displayField: "tblContact.nameFA"
					,
					valueField: "id",
					pickListWidth: "500",
					pickListheight: "500",
					pickListProperties: {showFilterEditor: true}
					,
					pickListFields:
						[
							{
								name: "capacity",
								title: "<spring:message code='shipment.Price.capacity'/>",
								type: 'long',
								align: "center"
							},
							{
								name: "tblShipmentInquiry.tblShipmentResource.tblContact.id", title: "<spring:message
		code='shipment.inquiry.id'/>", type: 'text', align: "center"
							},
							{
								name: "tblShipmentInquiry.tblShipmentResource.tblContact.nameFA", title: "<spring:message
		code='shipment.inquiry.id'/>", type: 'text', align: "center"
							},
						]
					,
					change: function () {
						var record = DynamicForm_ShipmentContract.getItem("tblShipmentPrice.id").getSelectedRecord();
						DynamicForm_ShipmentContract.setValue("tblContactByOwners.nameFA", record.tblShipmentInquiry.tblShipmentResource.tblContact.nameFA);
						DynamicForm_ShipmentContract.setValue("tblContactByOwners.id", record.tblShipmentInquiry.tblShipmentResource.tblContact.id);

//DynamicForm_ShipmentContract.setValue("tblPortByLoadPort.port",ShipmentSelection[0].tblPortByLoading.port);
//DynamicForm_ShipmentContract.setValue("tblPortByLoadPort.id",ShipmentSelection[0].tblPortByLoading.id);

//DynamicForm_ShipmentContract.setValue("tblPortByDischargePort.port",ShipmentSelection[0].tblPortByDischarge.port);
//DynamicForm_ShipmentContract.setValue("tblPortByDischargePort.id",ShipmentSelection[0].tblPortByDischarge.id);

						DynamicForm_ShipmentContract.setValue("demurrage", record.demurrage);
						DynamicForm_ShipmentContract.setValue("dispatch", record.dispatch);
						DynamicForm_ShipmentContract.setValue("freight", record.freight);
						DynamicForm_ShipmentContract.setValue("vesselName", record.vesselName);
						DynamicForm_ShipmentContract.setValue("yearOfBuilt", record.yearOfBuilt);
						DynamicForm_ShipmentContract.setValue("holds", record.holds);
						DynamicForm_ShipmentContract.setValue("hatch", record.hatch);
						DynamicForm_ShipmentContract.setValue("classType", record.classType);
						DynamicForm_ShipmentContract.setValue("laycanStart", record.laycanStart);
						DynamicForm_ShipmentContract.setValue("laycanEnd", record.laycanEnd);

					}
				},
				{
					name: "shipmentContractDate", ID: "shipmentContractDate", title: "<spring:message
		code='shipmentContract.shipmentContractDate'/>", align: "right", width: "200"
					, icons: [{
						src: "pieces/pcal.png", click: function () {
							displayDatePicker('createDate', this, 'ymd', '/');
						}
					}]
					, defaultValue: "<%=dateUtil.todayDate()%>"
					, blur: function () {
						var value = DynamicForm_ShipmentContract.getItem('createDate').getValue();
						if (value != null && value.length != 10 && value != "") {
							DynamicForm_ShipmentContract.setValue('createDate', CorrectDate(value))
						}
					}, colSpan: 2
				},
				{name: "tblContactByOwners.id", type: 'long', colSpan: 2, hidden: true},
				{
					name: "tblContactByOwners.nameFA",
					title: "<spring:message code='shipmentContract.agant'/>",
					colSpan: 2,
					canEdit: false
				},
				{
					name: "tblContactByCharterer.id",
					title: "<spring:message
		code='shipmentContract.charterer'/>",
					type: 'long',
					editorType: "SelectItem",
					colSpan: 2
					,
					optionDataSource: RestDataSource_ContactByShipmentContract,
					displayField: "tblContact.nameFA"
					,
					valueField: "id",
					pickListWidth: "500",
					pickListheight: "500",
					pickListProperties: {showFilterEditor: true}
					,
					pickListFields:
						[
							{name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
							{name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
						]
					,
					change: function () {
					}
				},
				{
					name: "tblContactByChainOfOwners.id",
					title: "<spring:message
		code='shipmentContract.owners'/>",
					type: 'long',
					editorType: "SelectItem",
					colSpan: 2
					,
					optionDataSource: RestDataSource_ContactByShipmentContract,
					displayField: "tblContact.nameFA"
					,
					valueField: "id",
					pickListWidth: "500",
					pickListheight: "500",
					pickListProperties: {showFilterEditor: true}
					,
					pickListFields:
						[
							{name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
							{name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
						]
					,
					change: function () {
					}
				},
				{
					name: "tblCountryFlag.id", title: "<spring:message
		code='shipmentContract.countryFlag'/>", type: 'long', editorType: "SelectItem"
					, optionDataSource: RestDataSource_CountryByShipmentContract, displayField: "nameEn"
					, valueField: "id", pickListProperties: {showFilterEditor: true}
					, pickListFields: [
						{name: "nameEn", width: 150, align: "center"}
					]
					, colSpan: 2
				},
				{name: "no", title: "<spring:message code='shipmentContract.no'/>", align: "center", colSpan: 2},
				{
					name: "capacity",
					title: "<spring:message code='shipmentContract.capacity'/>",
					align: "center",
					colSpan: 2
				},

				{
					name: "laycanStart", ID: "laycanStart", title: "<spring:message
		code='shipmentContract.laycanStart'/>", align: "right", width: "200"
					, icons: [{
						src: "pieces/pcal.png", click: function () {
							displayDatePicker('laycanStart', this, 'ymd', '/');
						}
					}]
					, blur: function () {
						var value = DynamicForm_ShipmentContract.getItem('laycanStart').getValue();
						if (value != null && value.length != 10 && value != "") {
							DynamicForm_ShipmentContract.setValue('laycanStart', CorrectDate(value))
						}
					}, colSpan: 2
				},
				{
					name: "laycanEnd", ID: "laycanEnd", title: "<spring:message
		code='shipmentContract.laycanEnd'/>", align: "right", width: "200"
					, icons: [{
						src: "pieces/pcal.png", click: function () {
							displayDatePicker('laycanEnd', this, 'ymd', '/');
						}
					}]
					, blur: function () {
						var value = DynamicForm_ShipmentContract.getItem('laycanEnd').getValue();
						if (value != null && value.length != 10 && value != "") {
							DynamicForm_ShipmentContract.setValue('laycanEnd', CorrectDate(value))
						}
					}, colSpan: 2
				},
				{
					name: "loadingRate",
					title: "<spring:message code='shipmentContract.loadingRate'/>",
					align: "center",
					colSpan: 2
				},
				{
					name: "dischargeRate",
					title: "<spring:message code='shipmentContract.dischargeRate'/>",
					align: "center",
					colSpan: 2
				},
				{
					name: "demurrage",
					title: "<spring:message code='shipmentContract.demurrage'/>",
					align: "center",
					colSpan: 2
				},
				{
					name: "dispatch",
					title: "<spring:message code='shipmentContract.dispatch'/>",
					align: "center",
					colSpan: 2
				},
				{
					name: "freight",
					title: "<spring:message code='shipmentContract.freight'/>",
					align: "center",
					colSpan: 2
				},
				{name: "bale", title: "<spring:message code='shipmentContract.bale'/>", align: "center", colSpan: 2},
				{name: "grain", title: "<spring:message code='shipmentContract.grain'/>", align: "center", colSpan: 2},
				{
					name: "grossWeight",
					title: "<spring:message code='shipmentContract.grossWeight'/>",
					align: "center",
					colSpan: 2
				},
				{
					name: "vesselName",
					title: "<spring:message code='shipmentContract.vesselName'/>",
					align: "center",
					colSpan: 2
				},
				{
					name: "yearOfBuilt",
					title: "<spring:message code='shipmentContract.yearOfBuilt'/>",
					align: "center",
					colSpan: 2
				},
				{name: "imoNo", title: "<spring:message code='shipmentContract.imoNo'/>", align: "center", colSpan: 2},
				{
					name: "officialNo",
					title: "<spring:message code='shipmentContract.officialNo'/>",
					align: "center",
					colSpan: 2
				},
				{name: "loa", title: "<spring:message code='shipmentContract.loa'/>", align: "center", colSpan: 2},
				{name: "beam", title: "<spring:message code='shipmentContract.beam'/>", align: "center", colSpan: 2},
				{
					name: "cranes",
					title: "<spring:message code='shipmentContract.cranes'/>",
					align: "center",
					colSpan: 2
				},
				{name: "holds", title: "<spring:message code='shipmentContract.holds'/>", align: "center", colSpan: 2},
				{name: "hatch", title: "<spring:message code='shipmentContract.hatch'/>", align: "center", colSpan: 2},
				{
					name: "classType",
					title: "<spring:message code='shipmentContract.classType'/>",
					align: "center",
					colSpan: 2
				},
				{
					name: "createDate",
					ID: "createDate",
					title: "<spring:message code='global.createDate'/>",
					align: "right",
					width: "200"
					,
					icons: [{
						src: "pieces/pcal.png", click: function () {
							displayDatePicker('createDate', this, 'ymd', '/');
						}
					}]
					,
					defaultValue: "<%=dateUtil.todayDate()%>"
					,
					blur: function () {
						var value = DynamicForm_ShipmentContract.getItem('createDate').getValue();
						if (value != null && value.length != 10 && value != "") {
							DynamicForm_ShipmentContract.setValue('createDate', CorrectDate(value))
						}
					},
					colSpan: 2
				},
				{
					name: "weighingMethodes",
					title: "<spring:message code='shipmentContract.weighingMethodes'/>",
					type: 'text',
					width: "200"
					,
					colSpan: 2
					,
					valueMap: {
						"draft survey": "<spring:message code='shipmentContract.draftSurvey'/>"
						, "weighbridge": "<spring:message code='shipmentContract.weighbridge'/>"
					}
				}

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
			var record = ListGrid_Shipment_HeaderByShipContract.getSelectedRecord();

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
				DynamicForm_ShipmentContract.clearValues();
				DynamicForm_ShipmentContract.setValue("tblShipmentHeader.id", record.id);
				DynamicForm_ShipmentContract.setValue("emailType", record.status);
				Window_ShipmentContract.show();
			}
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
	var ToolStripButton_ShipmentContract_print = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/print.png",
		title: "<spring:message code='shipmentContract.print'/>",
		click: function () {
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
				window.open("shipmentContract/printDocx?data=" + record.id);
			}
		}
	});
	var ToolStripButton_ShipmentContract_print1 = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/print.png",
		title: "<spring:message code='shipmentContract.print.letter'/>",
		click: function () {
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
				window.open("shipmentContract/printShipmentContractDocx?data=" + record.id);
			}
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
				ToolStripButton_ShipmentContract_print,
				ToolStripButton_ShipmentContract_print1

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
		title: "<spring:message code='shipmentContract.title'/>. ",
		width: "28%",
		hight: "30%",
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
						isc.Label.create({width: 5,}),
						IButton_ShipmentContract_Cancel
					]
			})
		]
	});
	var ListGrid_ShipmentContract = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_ShipmentContract,
		contextMenu: Menu_ListGrid_ShipmentContract,
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "tblShipmentPrice.nameFA", title: "<spring:message code='shipment.Price'/>", align: "center"},
				{
					name: "shipmentContractDate",
					title: "<spring:message code='shipmentContract.shipmentContractDate'/>",
					align: "center"
				},
				{
					name: "tblContactByOwners.nameFA", title: "<spring:message
		code='shipmentContract.owners'/>", align: "center", width: "10%"
				},
				{
					name: "tblContactByCharterer.nameFA", title: "<spring:message
		code='shipmentContract.charterer'/>", align: "center", width: "10%"
				},
				{
					name: "tblContactByChainOfOwners.nameFA", title: "<spring:message
		code='shipmentContract.chainOfOwners'/>", align: "center", width: "10%"
				},
				{
					name: "tblCountryFlag.nameFa", title: "<spring:message
		code='shipmentContract.countryFlag'/>", align: "center", width: "10%"
				},
				{name: "no", title: "<spring:message code='shipmentContract.no'/>", align: "center", width: "10%"},
				{
					name: "capacity",
					title: "<spring:message code='shipmentContract.capacity'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "tblPortByLoadPort.port", title: "<spring:message
		code='shipmentContract.loadPort'/>", align: "center", width: "10%"
				},
				{
					name: "tblPortByDischargePort.port", title: "<spring:message
		code='shipmentContract.dischargePort'/>", align: "center", width: "10%"
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
		dataPageSize: 50,
		autoFetchData: false,
		showFilterEditor: true,
		filterOnKeypress: true,
		startsWithTitle: "tt",
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
					title: "<spring:message
		code='shipmentHeader.title'/>", items: VLayout_Body_Shipment_HeaderByShipContract, expanded: true
				}
				, {
				title: "<spring:message code='Shipment.title'/>",
				items: VLayout_Body_ShipmentByContract,
				expanded: true
			}
				, {
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
