<%@ page import="com.nicico.core.copper.config.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	<% DateUtil dateUtil = new DateUtil();%>
	var main = "";
	var emailCCByBady = "";
	var RestDataSource_ContactByInspection = isc.RestDataSource.create({
		fields: [
			{name: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "code", title: "<spring:message code='contact.code'/>"},
			{name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
			{name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
			{name: "ceoPassportNo"},
			{name: "ceo"},
			{name: "commercialRegistration"},
			{name: "branchName"},
			{name: "commertialRole"},
			{name: "phone", title: "<spring:message code='contact.phone'/>"},
			{name: "mobile", title: "<spring:message code='contact.mobile'/>"},
			{name: "fax", title: "<spring:message code='contact.fax'/>"},
			{name: "address", title: "<spring:message code='contact.address'/>"},
			{name: "webSite", title: "<spring:message code='contact.webSite'/>"},
			{name: "email", title: "<spring:message code='contact.email'/>"},
			{
				name: "type",
				title: "<spring:message code='contact.type'/>",
				valueMap: {
					"true": "<spring:message code='contact.type.real'/>",
					"false": "<spring:message code='contact.type.legal'/>"
				}
			},
			{name: "nationalCode", title: "<spring:message code='contact.nationalCode'/>"},
			{name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
			{name: "bankAccount", title: "<spring:message code='contact.bankAccount'/>"},
			{name: "bankShaba", title: "<spring:message code='contact.bankShaba'/>"},
			{name: "bankSwift", title: "<spring:message code='contact.bankShaba'/>"},
			{name: "bankName", title: "<spring:message code='contact.bankName'/>"},
			{name: "contactAccounts"}
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/contact/list"
	});

	var RestDataSource_ShipmentContractByInsContract = isc.RestDataSource.create({
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
//{name:"tblPortByLoadPort.port" , title:"<spring:message
		code='shipmentContract.loadPort'/>",align:"center" , width :"10%"},
//{name:"tblPortByDischargePort.port" , title:"<spring:message
		code='shipmentContract.dischargePort'/>",align:"center" , width :"10%"},
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
			{name: "grain", title: "<spring:message code='shipmentContract.grain'/>", align: "center", width: "10%"},
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
			{name: "imoNo", title: "<spring:message code='shipmentContract.imoNo'/>", align: "center", width: "10%"},
			{
				name: "officialNo",
				title: "<spring:message code='shipmentContract.officialNo'/>",
				align: "center",
				width: "10%"
			},
			{name: "loa", title: "<spring:message code='shipmentContract.loa'/>", align: "center", width: "10%"},
			{name: "beam", title: "<spring:message code='shipmentContract.beam'/>", align: "center", width: "10%"},
			{name: "cranes", title: "<spring:message code='shipmentContract.cranes'/>", align: "center", width: "10%"},
			{name: "holds", title: "<spring:message code='shipmentContract.holds'/>", align: "center", width: "10%"},
			{name: "hatch", title: "<spring:message code='shipmentContract.hatch'/>", align: "center", width: "10%"},
			{
				name: "classType",
				title: "<spring:message code='shipmentContract.classType'/>",
				align: "center",
				width: "10%"
			},
			{name: "createUser", title: "<spring:message code='global.createUser'/>", align: "center", width: "10%"},
			{name: "createDate", title: "<spring:message code='global.createDate'/>", align: "center", width: "10%"},
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/shipmentContract/list"
	});

	var RestDataSource_PersonByInspectionContract_EmailCC = isc.RestDataSource.create({
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "tblContact.id"},
			{name: "tblContact.nameFA"},
			{
				name: "fullName",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',
				required: true,
				width: 400
			},
			{name: "jobTitle", title: "<spring:message code='person.jobTitle'/>", type: 'text', width: 400},
			{
				name: "title", title: "<spring:message code='person.title'/>", type: 'text', width: 400, valueMap: {
					"MR": "<spring:message
		code='global.MR'/>", "MIS": "<spring:message code='global.MIS'/>", "MRS": "<spring:message code='global.MRS'/>",
				}
			},
			{name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true, width: 400},
			{name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 400},
			{name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 400}
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/person/list"
	});
	var RestDataSource_ShipmentByInspectionContract = isc.RestDataSource.create({
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
			{name: "tblContract.id", type: 'long', hidden: true},
			{
				name: "tblContract.contractNo",
				title: "<spring:message code='contract.contractNo'/>",
				type: 'text',
				width: 180
			},
			{
				name: "tblContract.contractDate",
				title: "<spring:message code='contract.contractDate'/>",
				type: 'text',
				width: 180
			},
			{name: "tblMaterial.id", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
			{name: "tblMaterial.descl", title: "<spring:message code='material.descl'/>", type: 'text'},
			{name: "tblMaterial.tblUnit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},
			{name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
			{name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
			{
				name: "laycan", title: "<spring:message
		code='shipmentContract.laycanStart'/>", type: 'integer', width: "10%", align: "center",
			},
			{
				name: "shipmentType", title: "<spring:message
		code='shipment.shipmentType'/>", type: 'text', width: 400, valueMap: {"b": "bulk", "c": "container"}
			},
			{name: "loading", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
			{
				name: "tblPortByLoading.id", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%"
			},
			{
				name: "tblPortByLoading.port", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%"
			},
			{
				name: "tblPortByDischarge.id", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%"
			},
			{
				name: "tblPortByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%"
			},
			{
				name: "dischargeAddress",
				title: "<spring:message code='global.address'/>",
				type: 'text',
				required: true,
				width: "10%"
			},
			{
				name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%"
			},
			{name: "SWB", title: "<spring:message code='shipment.SWB'/>", type: 'text', required: true, width: "10%"},
			{
				name: "tblSwitchPort.port", title: "<spring:message
		code='port.switchPort'/>", type: 'text', required: true, width: "10%"
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
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/shipment/list"
	});

	var ListGrid_ShipmentByInspectionContract = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_ShipmentByInspectionContract,
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "tblContractItemShipment.id", hidden: true, type: 'long'},
			{name: "tblContractItemShipment.tblContractItem.tblContract.id", type: 'long', hidden: true},
			{name: "tblContact.id", type: 'long', hidden: true},
			{
				name: "tblContact.nameFA", title: "<spring:message
		code='contact.name'/>", type: 'text', width: "20%", align: "center", showHover: true
			},
			{name: "tblContract.id", type: 'long', hidden: true},
			{
				name: "tblContract.contractNo", title: "<spring:message
		code='contract.contractNo'/>", type: 'text', width: "10%", showHover: true
			},
			{
				name: "tblContract.contractDate", title: "<spring:message
		code='contract.contractDate'/>", type: 'text', width: "10%", showHover: true
			},
			{
				name: "tblMaterial.id",
				title: "<spring:message code='contact.name'/>",
				type: 'long',
				hidden: true,
				showHover: true
			},
			{
				name: "tblMaterial.descl", title: "<spring:message
		code='material.descl'/>", type: 'text', width: "10%", align: "center", showHover: true
			},
			{
				name: "tblMaterial.tblUnit.nameEN", title: "<spring:message
		code='unit.nameEN'/>", type: 'text', width: "10%", align: "center", showHover: true
			},
			{
				name: "amount", title: "<spring:message
		code='global.amount'/>", type: 'float', width: "10%", align: "center", showHover: true
			},
			{
				name: "shipmentType",
				title: "<spring:message
		code='shipment.shipmentType'/>",
				type: 'text',
				width: "10%",
				valueMap: {"b": "bulk", "c": "container"},
				showHover: true
			},
			{
				name: "noContainer", title: "<spring:message
		code='shipment.noContainer'/>", type: 'integer', width: "10%", align: "center", showHover: true
			},
			{
				name: "laycan", title: "<spring:message
		code='shipmentContract.laycanStart'/>", type: 'integer', width: "10%", align: "center", showHover: true
			},
			{
				name: "tblPortByLoading.port", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%", showHover: true
			},
			{
				name: "tblPortByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%", showHover: true
			},
			{
				name: "dischargeAddress", title: "<spring:message
		code='global.address'/>", type: 'text', required: true, width: "10%", showHover: true
			},
			{
				name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
			},
			{
				name: "month", title: "<spring:message
		code='shipment.month'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
			},
			{
				name: "SWB",
				title: "<spring:message code='shipment.SWB'/>",
				type: 'text',
				required: true,
				width: "10%",
				showHover: true
			},
			{
				name: "tblSwitchPort.port", title: "<spring:message
		code='port.switchPort'/>", type: 'text', required: true, width: "10%", showHover: true
			},
			{
				name: "status", title: "<spring:message
		code='shipment.staus'/>", type: 'text', width: "10%", align: "center", valueMap: {
					"Load Ready": "<spring:message
		code='shipment.loadReady'/>", "Resource": "<spring:message code='shipment.resource'/>"
				}, showHover: true
			},

		],
		recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
		updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
			var record = this.getSelectedRecord();
			contactId = record.tblContact.id;
			ListGrid_InspectionContract.fetchData({"tblShipment.id": record.id}, function (dsResponse, data, dsRequest) {
				ListGrid_InspectionContract.setData(data);
			});

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
	var HLayout_Grid_ShipmentByInspectionContract = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_ShipmentByInspectionContract
		]
	});

	var VLayout_Body_ShipmentByInspectionContract = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Grid_ShipmentByInspectionContract
		]
	});

	//-------------------------------------------Email----------------------------------------------------------------------
	var RestDataSource_InspectionContract = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "tblShipment.id", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
				{
					name: "tblShipment.tblContact.nameEN",
					title: "<spring:message code='contact.name'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "emailType",
					title: "<spring:message code='shipment.emailType'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "emailSubject",
					title: "<spring:message code='global.emailSubject'/>",
					align: "center",
					width: "10%"
				},
				{name: "emailTo", title: "<spring:message code='global.emailTo'/>", align: "center", width: "10%"},
				{name: "emailCC", title: "<spring:message code='global.emailCC'/>", align: "center", width: "10%"},
				{name: "emailBody", title: "<spring:message code='global.emailBody'/>", align: "center", width: "10%"},
				{
					name: "emailRespond",
					title: "<spring:message code='global.emailRespond'/>",
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
		fetchDataURL: "rest/inspectionContract/list"
	});
	var IButton_InspectionContract_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			DynamicForm_InspectionContract.validate();
			if (DynamicForm_InspectionContract.hasErrors())
				return;

			var data = DynamicForm_InspectionContract.getValues();
			isc.RPCManager.sendRequest({
				actionURL: "rest/inspectionContract/add",
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
						ListGrid_InspectionContract_refresh();
						Window_InspectionContract.close();
					} else
						isc.say(RpcResponse_o.data);
				}
			});
		}
	});
	var IButton_InspectionContract_Cancel = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.cancel'/>",
		icon: "pieces/16/icon_delete.png",
		click: function () {
			Window_InspectionContract.close();
		}
	});

	function ListGrid_InspectionContract_refresh() {
		ListGrid_InspectionContract.invalidateCache();
		var record = ListGrid_ShipmentByInspectionContract.getSelectedRecord();
		if (record == null || record.id == null)
			return;
		ListGrid_InspectionContract.fetchData({"tblShipment.id": record.id}, function (dsResponse, data, dsRequest) {
			ListGrid_InspectionContract.setData(data);
		}, {operationId: "00"});
	}

	function ListGrid_InspectionContract_edit() {
		var record = ListGrid_InspectionContract.getSelectedRecord()
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
			DynamicForm_InspectionContract.editRecord(record);
			Window_InspectionContract.show();
		}
	}

	function ListGrid_InspectionContract_remove() {

		var record = ListGrid_InspectionContract.getSelectedRecord()
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
						var inspectionContractId = record.id;
						isc.RPCManager.sendRequest({
							actionURL: "rest/inspectionContract/remove/" + inspectionContractId,
							httpMethod: "POST",
							useSimpleHttp: true,
							contentType: "application/json; charset=utf-8",
							showPrompt: true,
							serverOutputAsString: false,
							callback: function (RpcResponse_o) {
								if (RpcResponse_o.data == 'success') {
									ListGrid_InspectionContract_refresh();
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
	var Menu_ListGrid_InspectionContract = isc.Menu.create({
		width: 150,
		data:
			[
				{
					title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
					click: function () {
						DynamicForm_InspectionContract.clearValues();
						Window_InspectionContract.show();
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
						ListGrid_InspectionContract_edit();
					}
				},
				{
					title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
					click: function () {
						ListGrid_InspectionContract_remove();
					}
				}
			]
	});
	var ListGrid_PersonByInspectionContract_EmailCC = isc.MyListGrid.create({
		width: "800",
		height: "400",
		dataSource: RestDataSource_PersonByInspectionContract_EmailCC,
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{
				name: "tblContact.nameFA",
				title: "<spring:message code='contact.name'/>",
				type: 'long',
				width: 120,
				align: "center"
			},
			{
				name: "fullName",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',
				required: true,
				width: 150
			},
			{
				name: "title", title: "<spring:message code='person.title'/>", type: 'text', width: 150, valueMap: {
					"MR": "<spring:message
		code='global.MR'/>", "MIS": "<spring:message code='global.MIS'/>", "MRS": "<spring:message code='global.MRS'/>",
				}
			},
			{name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true, width: 150},
			{name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 150},
			{name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 150}
		],
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: true,
		showFilterEditor: true,
		filterOnKeypress: true,
		startsWithTitle: "tt",
		selectionAppearance: "checkbox"
	});
	var Window_InspectionContractEmailCC = isc.Window.create({
		title: "<spring:message code='person.title'/> ",
		width: "800",
		hight: "700",
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
				isc.VLayout.create({
					width: "100%",
					height: "100%",
					members:
						[
							ListGrid_PersonByInspectionContract_EmailCC
							,
							isc.Button.create({
								title: "<spring:message code='global.ok'/>",
								click: function () {
									var selectedPerson = ListGrid_PersonByInspectionContract_EmailCC.getSelection();
									if (selectedPerson.length == 0) {
										Window_InspectionContractEmailCC.close();
										return;
									}
									var persons = "";
									var oldPersons;
									var check = false;
									if (typeof (DynamicForm_InspectionContract.getValue("emailCC")) != 'undefined' && DynamicForm_InspectionContract.getValue("emailCC") != null) {
										persons = DynamicForm_InspectionContract.getValue("emailCC");
										oldPersons = persons.split(",");
										check = true;
									}
									for (i = 0; i < selectedPerson.length; i++) {
										notIn = true;
										if (check)
											for (j = 0; j < oldPersons.size(); j++)
												if (oldPersons[j] == selectedPerson[i].email)
													notIn = false;
										if (notIn)
											persons = (persons == "" ? persons : persons + ",") + selectedPerson[i].email;
									}
									DynamicForm_InspectionContract.setValue("emailCC", persons);
									Window_InspectionContractEmailCC.close();
								}
							})
						]
				})

			]
	});


	var DynamicForm_InspectionContract = isc.DynamicForm.create({
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
		fields:
			[
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "tblShipment.id", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
			{
				name: "superviseWeighing", title: "<spring:message
		code='inspectionContract.superviseWeighing'/>", type: 'checkbox', width: 50
			},
			{
				name: "sampling",
				title: "<spring:message code='inspectionContract.sampling'/>",
				type: 'checkbox',
				width: 50
			},
			{
				name: "moistureDetermination", title: "<spring:message
		code='inspectionContract.moistureDetermination'/>", type: 'checkbox', width: 50
			},
			{
				name: "emailType",
				title: "<spring:message code='shipment.emailType'/>",
				align: "center",
				width: "700"
			},
			{
				name: "emailSubject",
				title: "<spring:message code='global.emailSubject'/>",
				align: "center",
				width: "700"
			},
			{
				name: "tblShipmentContract.id",
				title: "<spring:message
		code='shipmentContract.title'/>",
				type: 'long',
				width: 700,
				editorType: "SelectItem"
				,
				optionDataSource: RestDataSource_ShipmentContractByInsContract,
				displayField: "tblContactByOwners.nameFA"
				,
				valueField: "id",
				pickListWidth: "680",
				pickListheight: "500",
				pickListProperties: {showFilterEditor: true}
				,
				pickListFields:
					[
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
						name: "tblCountryFlag.id", title: "<spring:message
		code='shipmentContract.countryFlag'/>", align: "center", width: "10%"
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
// {name:"loadPort" , title:"<spring:message code='shipmentContract.loadPort'/>",align:"center" , width :"10%"},
// {name:"tblPortByDischargePort.port" , title:"<spring:message
		code='shipmentContract.dischargePort'/>",align:"center" , width :"10%"},
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
				]
				,
				change: function () {
					var record = DynamicForm_InspectionContract.getItem("tblShipmentContract.id").getSelectedRecord();


//DynamicForm_InspectionContract.setValue("tblPortByLoadPort.port",record.tblPortByLoadPort.port);
//DynamicForm_InspectionContract.setValue("tblPortByLoadPort.id",record.tblPortByLoadPort.id);

//DynamicForm_InspectionContract.setValue("tblPortByDischargePort.port",record.tblPortByDischargePort.port);
//DynamicForm_InspectionContract.setValue("tblPortByDischargePort.id",record.tblPortByDischargePort.id);
					DynamicForm_InspectionContract.setValue("vesselName", record.vesselName);


					var id = -27;
					isc.RPCManager.sendRequest({
						willHandleError: true,
						actionURL: "rest/person/pickList?id=" + id,
						httpMethod: "POST",
						useSimpleHttp: true,
						contentType: "application/json; charset=utf-8",
						showPrompt: true,
						serverOutputAsString: false,
						dataFormat: "json",
						jsonPrefix: "",
						jsonSuffix: "",
						callback: function (RpcResponse_o) {
							var data = JSON.parse(RpcResponse_o.data);

							DynamicForm_InspectionContract.setValue("emailCC", data[0].emailCC);
							emailCCByBady = data[0].emailCC;

						}
					});

				}
			},
			{
				name: "tblContactByInspection.id",
				title: "<spring:message
		code='contract.title'/>",
				type: 'long',
				width: 700,
				editorType: "SelectItem"
				,
				optionDataSource: RestDataSource_ContactByInspection,
				displayField: "nameFA"


				,
				valueField: "id",
				pickListWidth: "680",
				pickListheight: "500",
				pickListProperties: {showFilterEditor: true}
				,
				pickListFields:
					[
						{name: "id", primaryKey: true, canEdit: false, hidden: true},
						{name: "code", title: "<spring:message code='contact.code'/>", align: "center", width: 200},
						{
							name: "nameFA",
							title: "<spring:message code='contact.nameFa'/>",
							align: "center",
							width: 280
						},
						{
							name: "bankName",
							title: "<spring:message code='contact.bankName'/>",
							align: "center",
							width: 200
						},
					]
				,
				getPickListFilterCriteria: function () {
					return {"inspector": 1};
				}

				,
				change: function () {
					var record = DynamicForm_InspectionContract.getItem("tblContactByInspection.id").getSelectedRecord();

					if (DynamicForm_InspectionContract.getValue("superviseWeighing") != null)
						superviseWeighing = "superviseWeighing";
					if (DynamicForm_InspectionContract.getValue("moistureDetermination") != null)
						moistureDetermination = "moistureDetermination";
					if (DynamicForm_InspectionContract.getValue("sampling") != null)
						sampling = "sampling";

					DynamicForm_InspectionContract.setValue("tblContactByInspection.id", record.id);
					DynamicForm_InspectionContract.setValue("emailTo", record.email);
					var superviseWeighing = "";
					var sampling = "";
					var moistureDetermination = "";
					var material = ListGrid_ShipmentByInspectionContract.getSelectedRecord().tblMaterial.descl;
					var qty = ListGrid_ShipmentByInspectionContract.getSelectedRecord().amount;
					var unit = ListGrid_ShipmentByInspectionContract.getSelectedRecord().tblMaterial.tblUnit.nameEN;
					var vesselName = DynamicForm_InspectionContract.getItem("tblShipmentContract.id").getSelectedRecord().vesselName;
					var dischargePort = DynamicForm_InspectionContract.getItem("tblShipmentContract.id").getSelectedRecord().tblPortByDischargePort.port
					var loadPort = DynamicForm_InspectionContract.getItem("tblShipmentContract.id").getSelectedRecord().tblPortByLoadPort.port
					var buyer = ListGrid_ShipmentByInspectionContract.getSelectedRecord().tblContact.nameFA;
					main = " Dear " + record.nameFA
						+ " We hereby appoint you conjointly with our buyer to " + superviseWeighing + "," + sampling + "," + moistureDetermination
						+ " at \n Qinhuangdao port as specified below: "
						+ "\n \n "
						+ " 1. Material: " + " " + material + "\n"
						+ " 2. Quantity:" + " " + qty + " " + unit + "\n"
						+ " 3. Name of carrying vessel:" + " " + vesselName + "\n"
						+ " 4. Load Port:" + " " + loadPort + "\n"
						+ " 5. ETA Discharge Port:" + " " + "" + "\n"
						+ " 6. Discharge Port:" + " " + dischargePort + "\n"
						+ " 7. Buyer::" + " " + buyer + "\n"
						+ " 8. Supervision Items:" + "\n"
						+ " - Discharging operations at Qinhuangdao Port-China." + "\n"
						+ " - Weighing, sampling and moisture determination to be carried out at disport." + "\n"
						+ " - Weighbridge requested: Yes." + "\n"
						+ " - Lot size : approx. 500 WMT" + "\n"
						+ " - Each sample must have minimum weight of 250 Grs." + "\n"
						+ " The cost of such supervision shall be shared 50 / 50 (fifty / fifty) by Buyer and Seller." + "\n"
						+ " The Final weight shall be determined by weighbridge which shall be final for settlement." + "\n"
						+ " Sampling shall be made at the discharge port in lots of about 500 wmt and each sample must have a minimum weight of 250 grams." + "\n"
						+ " Sample Distribution:" + "\n"
						+ " a) 3 complete sealed sets for Seller" + "\n"
						+ " b) 2 complete sealed sets for Buyer" + "\n"
						+ " c) 3 complete sealed sets of samples to be kept with SGS for any needful instruction from Seller" + "\n"
						+ " Samples must be forwarded by courier express to the seller in Iran and buyer in China." + "\n"
						+ "9. Following information must be immediately e-mailed when known: " + "\n"
						+ " a) Date of arrival of vessel " + "\n"
						+ " b) Date of berthing of vessel " + "\n"
						+ " c) Commencement of Discharging " + "\n"
						+ " d) Estimated date of completion of Discharging " + "\n"
						+ " e) Wet and dry weight, moisture in percent " + "\n"
						+ "10. Weighing and moisture determination report must show following: " + "\n"
						+ " a) Discharge port operation, commencement, completion, equipment used etc. " + "\n"
						+ " b) Weighing, kind and condition of weighing facilities " + "\n"
						+ " c) Sampling, preparation " + "\n"
						+ " d) Moisture determination " + "\n"
						+ " e) Statement of facts " + "\n"
						+ " f) Notice of Readiness " + "\n"
						+ "11. Weight certificate must report following: " + "\n"
						+ " a) Net Wet weight per lot in kg " + "\n"
						+ " b) Moisture per lot in kg and percent " + "\n"
						+ " c) Net dry weight per lot in kg " + "\n"

						+ "All certificates must be distributed in triplicate. " + "\n"
						+ "Furthermore, representative will have to make sure that weighing, sampling and moisture determination is carried out in the usual international technical manner. " + "\n"
						+ "12.Invoicing :" + "\n"
						+ " 100% for the account of NICICO "
						+ "Please send your reports to the following email addresses: " + "\n"
						+ "Buyer:" + "\n"
						+ ListGrid_ShipmentByInspectionContract.getSelectedRecord().tblContract.tblContact.email.replaceAll(',', '\n') + "\n"
						+ "Seller:" + "\n"
						+ emailCCByBady.replaceAll(',', '\n') + "\n"
						+ "Please consider the points below:" + "\n"
						+ "- As per our mutual contract with our buyer CIQ result has no effect on our final calculation." + "\n"
						+ "- Please check the holds’ seals once the vessel arrives at discharge ports." + "\n"
						+ "For your information weighing operation as per seller charter party contract at disport with vessel head owner is as follows:" + "\n"
						+ "Discharge ports: Weighbridge" + "\n"
						+ "It is kindly requested to acknowledge receipt of above mentioned instructions by e-mail." + "\n"
						+ "Many Thanks & Best Regards," + "\n"
						+ "Sales & Marketing Manager" + "\n"
					;
					DynamicForm_InspectionContract.setValue("emailBody", main);

				}
			},

			{name: "vesselName", title: "<spring:message code='shipmentContract.vesselName'/>"},
//{name:"tblPortByLoadPort.id" , title:"<spring:message code='shipmentContract.loadPort'/>" , hidden: true},
//{name:"tblPortByLoadPort.port" , title:"<spring:message code='shipmentContract.loadPort'/>" ,canEdit:false},

			<%--{name:"dischargePort"               , title:"<spring:message code='shipmentContract.dischargePort'/>"   },--%>
//{name:"tblPortByDischargePort.id" , title:"<spring:message code='shipmentContract.loadPort'/>" , hidden: true},
//{name:"tblPortByDischargePort.port" , title:"<spring:message
		code='shipmentContract.dischargePort'/>" ,canEdit:false, wrapTitle: false},


			{name: "emailTo", title: "<spring:message code='global.emailTo'/>", type: 'text', width: 700, type: "text"},

			{
				name: "emailCC", title: "<spring:message code='global.emailCC'/>", width: 700, type: "text"
				, icons: [{
					src: "icon/search.png",
					click: function (form, item) {
						Window_InspectionContractEmailCC.show();
					}
				}]
			},
			{
				name: "emailBody", title: "<spring:message
		code='global.emailBody'/>", align: "center", textAlign: "left", width: "700", type: "textArea", height: 200
			},
			{
				name: "emailRespond",
				title: "<spring:message code='global.emailRespond'/>",
				align: "center",
				width: "700"
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
					var value = DynamicForm_InspectionContract.getItem('createDate').getValue();
					if (value != null && value.length != 10 && value != "") {
						DynamicForm_InspectionContract.setValue('createDate', CorrectDate(value))
					}
				}
			}

		]
	});

	var ToolStripButton_InspectionContract_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_InspectionContract_refresh();
		}
	});

	var ToolStripButton_InspectionContract_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			var record = ListGrid_ShipmentByInspectionContract.getSelectedRecord();
			var recordContact = DynamicForm_InspectionContract.getItem("tblContactByInspection.id").getSelectedRecord();
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
				DynamicForm_InspectionContract.clearValues();
				DynamicForm_InspectionContract.setValue("tblShipment.id", record.id);
				DynamicForm_InspectionContract.setValue("emailType", "Inspection Contract");
				DynamicForm_InspectionContract.setValue("emailSubject", "ORDER FOR REPRESENTATION ");

				Window_InspectionContract.show();
			}
		}
	});

	var ToolStripButton_InspectionContract_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_InspectionContract_edit();
		}
	});

	var ToolStripButton_InspectionContract_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_InspectionContract_remove();
		}
	});

	var ToolStripButton_InspectionContract_Print = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/print.png",
		title: "<spring:message code='print'/>",
		click: function () {
			var record = ListGrid_InspectionContract.getSelectedRecord();
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
				window.open("inspectionContract/printDocx?data=" + record.id);
			}
		}
	});

	var ToolStrip_Actions_InspectionContract = isc.ToolStrip.create({
		width: "100%",
		members:
			[
				ToolStripButton_InspectionContract_Refresh,
				ToolStripButton_InspectionContract_Add,
				ToolStripButton_InspectionContract_Edit,
				ToolStripButton_InspectionContract_Remove,
				ToolStripButton_InspectionContract_Print
			]
	});

	var HLayout_InspectionContract_Actions = isc.HLayout.create({
		width: "100%",
		members:
			[
				ToolStrip_Actions_InspectionContract
			]
	});
	var Window_InspectionContract = isc.Window.create({
		title: "<spring:message code='inspectionContract.title'/> ",
		width: "800",
		hight: "700",
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
				DynamicForm_InspectionContract,
				isc.HLayout.create({
					width: "100%",
					members:
						[

							IButton_InspectionContract_Save,
							isc.Label.create({width: 5,}),
							IButton_InspectionContract_Cancel
						]
				})

			]
	});
	var ListGrid_InspectionContract = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_InspectionContract,
		contextMenu: Menu_ListGrid_InspectionContract,
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "tblShipment.id", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
				{
					name: "tblShipment.tblContact.nameEN",
					title: "<spring:message code='contact.name'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "emailType",
					title: "<spring:message code='shipment.emailType'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "emailSubject",
					title: "<spring:message code='global.emailSubject'/>",
					align: "center",
					width: "10%"
				},
				{name: "emailTo", title: "<spring:message code='global.emailTo'/>", align: "center", width: "10%"},
				{name: "emailCC", title: "<spring:message code='global.emailCC'/>", align: "center", width: "10%"},
				{name: "emailBody", title: "<spring:message code='global.emailBody'/>", align: "center", width: "10%"},
				{
					name: "emailRespond",
					title: "<spring:message code='global.emailRespond'/>",
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
	var HLayout_InspectionContract_Grid = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_InspectionContract
		]
	});

	var VLayout_InspectionContract_Body = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members:
			[
				HLayout_InspectionContract_Actions, HLayout_InspectionContract_Grid
			]
	});
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	isc.SectionStack.create({
		ID: "Shipment_Section_Stack",
		sections:
			[
				{
					title: "<spring:message code='Shipment.title'/>",
					items: VLayout_Body_ShipmentByInspectionContract,
					expanded: true
				}
				, {
				title: "<spring:message code='inspectionContract.title'/>",
				items: VLayout_InspectionContract_Body,
				expanded: true
			}
			],
		visibilityMode: "multiple",
		animateSections: true,
		height: "100%",
		width: "100%",
		overflow: "hidden"
	});
