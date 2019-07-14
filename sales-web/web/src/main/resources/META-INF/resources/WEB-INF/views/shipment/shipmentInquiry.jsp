<%@ page import="com.nicico.core.copper.config.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	<% DateUtil dateUtil = new DateUtil();%>
	var contactId;
	var shipmentHeaderIdByTender;


	var ListGrid_PersonByShipmentInquiry_EmailCC;
	var RestDataSource_Shipment_HeaderByTender = isc.RestDataSource.create({
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
	var RestDataSource_PersonByShipInq_EmailCC = isc.RestDataSource.create({
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
	var RestDataSource_Contact = isc.RestDataSource.create({
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
	var RestDataSource_ByTender = isc.RestDataSource.create({
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "tblContractItemShipment.id", hidden: true, type: 'long'},
			{name: "tblShipmentHeader.id", hidden: true, type: 'long'},
			{name: "tblContractItemShipment.tblContractItem.tblContract.id", type: 'long', hidden: true},
			{name: "tblContact.id", type: 'long', hidden: true},
			{
				name: "tblContact.nameFA", title: "<spring:message
		code='contact.name'/>", type: 'text', width: "20%", align: "center", showHover: true
			},
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
				name: "shipmentType", title: "<spring:message
		code='shipment.shipmentType'/>", type: 'text', width: "10%", valueMap: {"b": "bulk", "c": "container"}
			},
			{
				name: "noContainer", title: "<spring:message
		code='shipment.noContainer'/>", type: 'integer', width: "10%", align: "center",
			},
			{
				name: "tblPortByLoading.port", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%"
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
		code='shipment.description'/>", type: 'text', required: true, width: "10%", align: "center",
			},
			{
				name: "month", title: "<spring:message
		code='shipment.month'/>", type: 'text', required: true, width: "10%", align: "center",
			},
			{name: "SWB", title: "<spring:message code='shipment.SWB'/>", type: 'text', required: true, width: "10%"},
			{
				name: "tblSwitchPort.port", title: "<spring:message
		code='port.switchPort'/>", type: 'text', required: true, width: "10%"
			},
			{
				name: "status", title: "<spring:message
		code='shipment.staus'/>", type: 'text', width: "10%", align: "center", valueMap: {
					"Load Ready": "<spring:message
		code='shipment.loadReady'/>", "Resource": "<spring:message code='shipment.resource'/>"
				}
			},
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/shipment/list"
	});

	//---------------------------------------------------------- shipment Header--------------------------------------------------------------------------------------------
	function ListGrid_Shipment_HeaderByTender_refresh() {
		ListGrid_Shipment_HeaderByTender.invalidateCache();
		var record = ListGrid_Shipment_HeaderByTender.getSelectedRecord();
		if (record == null || record.id == null)
			return;
		ListGrid_Shipment_HeaderByTender.fetchData({}, function (dsResponse, data, dsRequest) {
			ListGrid_Shipment_HeaderByTender.setData(data);
		}, {operationId: "00"});
	}

	var ListGrid_Shipment_HeaderByTender = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Shipment_HeaderByTender,

		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, align: "center", hidden: true},
			{name: "shipmentHeaderDate", title: "<spring:message code='shipmentHeader.date'/>", align: "center"},
			{name: "description", title: "<spring:message code='shipmentHeader.description'/>", align: "center"}
		],
		recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
		updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
			var record = this.getSelectedRecord();

			ListGrid_ShipmentByTender.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
				ListGrid_ShipmentByTender.setData(data);
			}, {operationId: "00"});

			ListGrid_ShipmentInquiry.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
				ListGrid_ShipmentInquiry.setData(data);
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
	var HLayout_Grid_Shipment_HeaderByTender = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_Shipment_HeaderByTender
		]
	});

	var VLayout_Body_Shipment_HeaderByTender = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [

			HLayout_Grid_Shipment_HeaderByTender
		]
	});

	//---------------------------------------------------------- Inquiry ---------------------------------------------------------------------------------------------------
	var ListGrid_ShipmentByTender = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_ByTender,
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "tblContractItemShipment.id", hidden: true, type: 'long'},
			{name: "tblContractItemShipment.tblContractItem.tblContract.id", type: 'long', hidden: true},
			{name: "tblShipmentHeader.id", type: 'long', hidden: true},
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
	var HLayout_Grid_ShipmentBytender = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_ShipmentByTender
		]
	});

	var VLayout_Body_ShipmentBytender = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Grid_ShipmentBytender
		]
	});
	//-------------------------------------------Email----------------------------------------------------------------------
	var RestDataSource_ShipmentInquiry = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "tblShipmentHeader.id",
					title: "<spring:message code='contact.name'/>",
					align: "center",
					hidden: true
				},
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
		fetchDataURL: "rest/shipmentInquiry/list"
	});
	var RestDataSource_ShipmentResourceByInquiry = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "tblShipmentHeader.id",
					title: "<spring:message code='shipment.name'/>",
					align: "center",
					hidden: true
				},
				{
					name: "tblContact.nameFA",
					title: "<spring:message code='contact.name'/>",
					align: "center",
					width: "10%"
				},
				{
					name: "description",
					title: "<spring:message code='shipment.description'/>",
					align: "center",
					width: "10%"
				}
			],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/shipmentResource/list"
	});
	var IButton_ShipmentInquiry_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			DynamicForm_ShipmentInquiry.validate();
			if (DynamicForm_ShipmentInquiry.hasErrors())
				return;

			var data = DynamicForm_ShipmentInquiry.getValues();
			DynamicForm_ShipmentInquiry.setValue("tblShipmentHeader.id", shipmentHeaderIdByTender);

			isc.RPCManager.sendRequest({
				actionURL: "rest/shipmentInquiry/add",
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
						ListGrid_ShipmentInquiry_refresh();
						Window_ShipmentInquiry.close();
					} else
						isc.say(RpcResponse_o.data);
				}
			});
		}
	});
	var IButton_ShipmentInquiry_Cancel = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.cancel'/>",
		icon: "pieces/16/icon_delete.png",
		click: function () {
			Window_ShipmentInquiry.close();
		}
	});

	function ListGrid_ShipmentInquiry_refresh() {
		ListGrid_ShipmentInquiry.invalidateCache();
		var record = ListGrid_Shipment_HeaderByTender.getSelectedRecord();
		if (record == null || record.id == null)
			return;
		ListGrid_ShipmentInquiry.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
			ListGrid_ShipmentInquiry.setData(data);
		}, {operationId: "00"});
	}

	function ListGrid_ShipmentInquiry_edit() {
		var record = ListGrid_ShipmentInquiry.getSelectedRecord()
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
			DynamicForm_ShipmentInquiry.editRecord(record);
			Window_ShipmentInquiry.show();
		}
	}

	function ListGrid_ShipmentInquiry_remove() {

		var record = ListGrid_ShipmentInquiry.getSelectedRecord()
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
						var shipmentInquiryId = record.id;
						isc.RPCManager.sendRequest({
							actionURL: "rest/shipmentInquiry/remove/" + shipmentInquiryId,
							httpMethod: "POST",
							useSimpleHttp: true,
							contentType: "application/json; charset=utf-8",
							showPrompt: true,
							serverOutputAsString: false,
							callback: function (RpcResponse_o) {
								if (RpcResponse_o.data == 'success') {
									ListGrid_ShipmentInquiry_refresh();
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
	var Menu_ListGrid_ShipmentInquiry = isc.Menu.create({
		width: 150,
		data:
			[
				{
					title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
					click: function () {
						DynamicForm_ShipmentInquiry.clearValues();
						Window_ShipmentInquiry.show();
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
						ListGrid_ShipmentInquiry_edit();
					}
				},
				{
					title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
					click: function () {
						ListGrid_ShipmentInquiry_remove();
					}
				}
			]
	});
	ListGrid_PersonByShipmentInquiry_EmailCC = isc.MyListGrid.create({
		width: "800",
		height: "400",
		dataSource: RestDataSource_PersonByShipInq_EmailCC,
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
	var Window_ShipmentInquiryEmailCC = isc.Window.create({
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
							ListGrid_PersonByShipmentInquiry_EmailCC
							,
							isc.Button.create({
								title: "<spring:message code='global.ok'/>",
								click: function () {


									var selectedPerson = ListGrid_PersonByShipmentInquiry_EmailCC.getSelection();
									if (selectedPerson.length == 0) {
										Window_ShipmentInquiryEmailCC.close();
										return;
									}
									var persons = "";
									var oldPersons;
									var check = false;
									if (typeof (DynamicForm_ShipmentInquiry.getValue("emailCC")) != 'undefined' && DynamicForm_ShipmentInquiry.getValue("emailCC") != null) {
										persons = DynamicForm_ShipmentInquiry.getValue("emailCC");
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
									DynamicForm_ShipmentInquiry.setValue("emailCC", persons);
									Window_ShipmentInquiryEmailCC.close();
								}
							})
						]
				})

			]
	});

	var DynamicForm_ShipmentInquiry = isc.DynamicForm.create({
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
				{
					name: "tblShipmentHeader.id",
					title: "<spring:message code='contact.name'/>",
					align: "center",
					hidden: true
				},
				{
					name: "closeDate", ID: "closeDate", title: "<spring:message
		code='shipment.inquiry.closeDate'/>", align: "right", width: "200"
					, icons: [{
						src: "pieces/pcal.png", click: function () {
							displayDatePicker('closeDate', this, 'ymd', '/');
						}
					}]
					, defaultValue: "<%=dateUtil.todayDate()%>"
					, blur: function () {
						var value = DynamicForm_ShipmentInquiry.getItem('closeDate').getValue();
						if (value != null && value.length != 10 && value != "") {
							DynamicForm_ShipmentInquiry.setValue('closeDate', CorrectDate(value))
						}
					}
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
					name: "tblShipmentResource.id",
					title: "<spring:message
		code='shipment.shipmentResource'/>",
					type: 'long',
					width: 700,
					editorType: "SelectItem"
					,
					optionDataSource: RestDataSource_ShipmentResourceByInquiry,
					displayField: "tblContact.nameFA"
					,
					valueField: "id",
					pickListWidth: "680",
					pickListheight: "500",
					pickListProperties: {showFilterEditor: true}
					,
					pickListFields:
						[
							{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
							{
								name: "tblContact.nameFA",
								title: "<spring:message code='contact.name'/>",
								align: "center",
								width: "50%"
							},
							{
								name: "description",
								title: "<spring:message code='shipment.description'/>",
								align: "center",
								width: "50%"
							}
						]
					,
					change: function () {
						var record = DynamicForm_ShipmentInquiry.getItem("tblShipmentResource.id").getSelectedRecord();
						DynamicForm_ShipmentInquiry.setValue("emailTo", record.tblContact.email);
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
// JSON.stringify(RpcResponse_o.data);

								DynamicForm_ShipmentInquiry.setValue("emailCC", data[0].emailCC);
								<%--&lt;%&ndash;console.log(RpcResponse_o);&ndash;%&gt;--%>
								<%--var x   = JSON.stringify(RpcResponse_o.data);--%>
								<%--x = JSON.parse(x);--%>
								<%--console.log(x.response.data[0].emailCC);--%>

							}
						});


					}
				},
				{
					name: "emailTo",
					title: "<spring:message code='global.emailTo'/>",
					type: 'text',
					width: 700,
					type: "text"
				},
				{
					name: "emailCC", title: "<spring:message code='global.emailCC'/>", width: 700, type: "text"
					, icons: [{
						src: "icon/search.png",
						click: function (form, item) {
							function obj() {
								obj = new Object();
								this.add = function (key, value) {
									obj["" + key + ""] = value;
								}
								this.obj = obj
							}

							var oldP = DynamicForm_ShipmentInquiry.getValue("emailCC").split(",");
							var ids = ListGrid_PersonByShipmentInquiry_EmailCC.getSelectedState();
							for (j = 0; j < ListGrid_PersonByShipmentInquiry_EmailCC.length; j++) {
								for (i = 0; i < oldP.size(); i++) {
									if (ListGrid_PersonByShipmentInquiry_EmailCC.get(j).emailCC == oldP[i])

										my_obj = new obj();
									my_obj.add('id', ListGrid_PersonByShipmentInquiry_EmailCC.get(j).id);
									ids.push(my_obj);
								}
							}
							ListGrid_PersonByShipmentInquiry_EmailCC.setSelectedState(ids)
							Window_ShipmentInquiryEmailCC.show();

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
						var value = DynamicForm_ShipmentInquiry.getItem('createDate').getValue();
						if (value != null && value.length != 10 && value != "") {
							DynamicForm_ShipmentInquiry.setValue('createDate', CorrectDate(value))
						}
					}
				}

			]
	});
	isc.Window.create({
		ID: "shipmentResourceByInquiry_Window",
		title: "<spring:message code='tenderNotice.title'/> ",
		width: 700,
		hight: 800,
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
							isc.MyListGrid.create({
								ID: "ShipmentResourceByInquiry_ListGrid",
								dataSource: RestDataSource_ShipmentResourceByInquiry,
								selectionAppearance: "checkbox",
								fields:
									[
										{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
										{
											name: "tblShipmentHeader.id",
											title: "<spring:message code='shipment.name'/>",
											align: "center",
											hidden: true
										},
										{
											name: "tblContact.nameFA",
											title: "<spring:message code='contact.name'/>",
											align: "center",
											width: "10%"
										},
										{
											name: "description",
											title: "<spring:message code='shipment.description'/>",
											align: "center",
											width: "10%"
										}
									],
								sortField: 0,
								dataPageSize: 50,
								autoFetchData: true,
								showFilterEditor: true,
								filterOnKeypress: true,
								startsWithTitle: "tt"
							}),
							isc.ToolStripButton.create({
								icon: "pieces/16/icon_copy.png",
								title: "<spring:message code='global.form.copy'/>",
								click: function () {
									var id = ListGrid_ShipmentInquiry.getSelectedRecord().id;
									var selectedRecord = "";
									var selectedRequestItems = "";
									selectedRecord = ShipmentResourceByInquiry_ListGrid.getSelection();
									for (i = 0; i < selectedRecord.length; i++) {
										if (i < selectedRecord.length - 1) {
											selectedRequestItems += selectedRecord[i].id + ",";
										} else {
											selectedRequestItems += selectedRecord[i].id;
										}
									}


									isc.RPCManager.sendRequest({
										willHandleError: true,
										actionURL: "rest/shipmentInquiry/copy/" + id + "/" + selectedRequestItems,

										httpMethod: "POST",
										useSimpleHttp: true,
										contentType: "application/json; charset=utf-8",
										showPrompt: true,
										serverOutputAsString: false,
										dataFormat: "json",
										jsonPrefix: "",
										jsonSuffix: "",
										callback: function (RpcResponse_o) {

										}
									});


								}
							})

						]
				})
			]
	});
	var ToolStripButton_ShipmentInquiry_Copy = isc.ToolStripButton.create({
		icon: "pieces/16/icon_copy.png",
		title: "<spring:message code='global.form.copy'/>",
		click: function () {
			var record = ListGrid_ShipmentInquiry.getSelectedRecord();
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
				shipmentResourceByInquiry_Window.show();
			}
		}
	});
	var ToolStripButton_ShipmentInquiry_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_ShipmentInquiry_refresh();
		}
	});

	var ToolStripButton_ShipmentInquiry_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			var contractNo = "";
			ListGrid_ShipmentByTender.selectAllRecords();


			var record = ListGrid_Shipment_HeaderByTender.getSelectedRecord();
			shipmentHeaderIdByTender = record.id;
			var selectionShipment = ListGrid_ShipmentByTender.getSelection();
			/* var contractNo = record.tblContractItemShipment.tblContractItem.tblContract.contractNo;*/
			var closeDate = DynamicForm_ShipmentInquiry.getValue("closeDate");
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

				var G = "WMT (Wet Metric Tons)";
				var F = "per H/H per weather working day";
				var B = "Friday and Legal/Local/National Holiday Excluded Unless Used Actual Time Used To Count ";
				var C = "4,000 wet metric tons";
				var AA = "PM";
				var AB = "AM";
				var J = " Per Weather Working Day-Sat Noon, Sundays, National & Local Holidays Excluded-Unless Used-If Used, Actual Time Used To Count ";
				var H = selectionShipment[0].switchBl;
				var E = "";
				var P = selectionShipment[0].tblSwitchPort.port;
				var O = closeDate;
				var M = closeDate;
				var AE = " 20' HD Containers ";
				var AF = " 40' HD Containers ";
				var commodity = "";
				var X = "";
				var U = "";
				var Z = "";
				var W = "";
				var L = "";
				var D = "";
				var Y = "";
				var T = "";
				var A = "";
				var main1 = "";
				var main3 = "";
				var main4 = "";
				var main5 = "";
				var main6 = "";
				DynamicForm_ShipmentInquiry.clearValues();

				if (selectionShipment[0].shipmentType != null && selectionShipment[0].shipmentType == 'b') {
					main2 = " If the vessel's crane are not working properly at the time of loading provision of shore crane at "
						+ " owner's cost is obligatory "
						+ " \n \n"
						+ " Laytime Calculation Loading port: At load port time to count 12 hours after tendering NOR, unless "
						+ " \n"
						+ " .sooner commencement, if used actual time used to count "
						+ " \n \n"
						+ " Laytime Calculation at Discharge port: Laytime for discharge shall commence at 01:00 PM the same "
						+ " \n"
						+ " working day if NOR is tendered during Normal Official Hours at or before 12:00 noon and "
						+ " \n"
						+ " . commence at 08:00 AM the next working day if NOR is tendered during Normal Official Hours after"
						+ " \n"
						+ " 12:00 noon unless discharge is sooner commenced in which case actual time used for discharging "
						+ " \n"
						+ " .shall count as laytime (Start and finish of normal office hours shall be considered according to disport "
						+ " \n"
						+ " official regulations) "
						+ " \n \n"
						+ " Important Note: our priority for dealing with the shipping company is that the nominated vessel has "
						+ " \n"
						+ " .the options below for sure "
						+ " \n \n"

					main4 = ".Freight: to be paid once discharging is completed (To be negotiable) "
						+ " \n \n"
						+ " :The nominated shipping line should provide us with following documents along with their offers "
						+ " \n"
						+ " -Registration certificate which was endorsed by the related legal organization -"
						+ " \n"
						+ " -Introducing Authorized signatory -"
						+ " \n"
						+ " -A document shows registered capital -"
						+ " \n"
						+ " -Vessel particular -"
						+ " \n \n"
						+ " We shall include in our charter party contract that OBL shall be released to charterer immediately "
						+ " \n"
						+ " upon its issuance and cargos at discharge port shall be released to final receiver as soon as it is "
						+ " \n"
						+ " .discharged or maximum one day after discharge and after cargo release note from charterer "
						+ " \n"
						+ " ***************************************** "
						+ " \n"
						+ " :Vessel characteristic for bulk shipment "
						+ " \n"
						+ " a) Be a single deck bulk carrier, seaworthy in all respects, with clear holds and hatchways suitable for "
						+ " \n"
						+ ".typical grab discharge "
						+ " \n"
						+ " .b) Supply power for its on board winches, derricks and lights free of expense to Charterer "
						+ " \n"
						+ ".c) Not have shaft tunnel in the holds "
						+ " \n"
						+ " .d) Meet the restrictions, if any, in the Berth Characteristics "
						+ " \n"
						+ " .e) Be classed 100A1 at Lloyds or equivalent "
						+ " \n"
						+ " .f) Be geared "
						+ " \n"
						+ " .g) Be not older than 20 years "
						+ " \n"
						+ " .h) Be accepted by the port authority at the port of unloading "
						+ " \n"

						+ " : To discharge and depart always afloat up to the following maximum dimensions for below ports "
						+ " \n"
						+ D
						+ " \n"


					main6 = " Providing us with your nominated vessels shows that vessel wouldn't have any international sailing "
						+ " \n"
						+ " problems as well as sanction issues "
						+ " \n \n"

						+ " By the way please find attached drafted charter party contract which shall be considered as final "
						+ " \n"
						+ " .contract and its observation "
						+ " \n"
						+ " \n"
						+ " Kindly proceed to send your best offer with full details/specification till "
						+ "." + O + " , till " + M + ""
						+ " \n"
						+ " Best Regards "
						+ " Signature ";
				} else if (selectionShipment[0].shipmentType != null && selectionShipment[0].shipmentType == 'c') {
					main2 = " ,Dear Sir/Sirs "
						+ "\n"
						+ " : Kindly advise freight rate for shipment of " + W + " from " + L + " to " + D + " port with details below \n"
						+ " Quality: -" + W + "\n"
						+ " HS code: -" + AC + "\n"
						+ " Quantity: Minimum -" + Y + " " + Z + "\n"
						+ " Weight of each Bundle : -" + " " + "about " + AC + " kg " + "\n"
						+ " Carrier : By Container - " + " (" + AE + " / " + AF + " ) " + "\n"
						+ " .Your price offer for containers including B/L fee and THC at both end - "
						+ " We request to confirm 21 days free time at both ends which to be included in the price "
						+ " Awaiting for your price offer with full details till" + O + " " + M + " . "
					;

				}
				for (var i = 0; i < selectionShipment.length; i++) {
					X = selectionShipment[i].tblContractItemShipment.tblContractItem.tblContract.contractNo + ",";
					U = selectionShipment[i].month;
					Z = selectionShipment[i].tblMaterial.tblUnit.nameEN;
					W = selectionShipment[i].tblMaterial.descl;
					L = selectionShipment[i].tblPortByLoading.port;
					D = selectionShipment[i].tblPortByDischarge.port;
					Y = selectionShipment[i].amount;
					T = selectionShipment[i].tblContact.nameFA;
					A = selectionShipment[i].laycan;
					var AC = selectionShipment[i].tblPortByDischarge;
					var K = " 1000 WMT ";
					commodity = "Commodity " + parseInt(i + 1) + "\n";

					main1 += "Commodity " + parseInt(i + 1) + "\n"
						+ Y + " " + Z + " , " + W + "\n"
						+ " from " + L + " to " + D + " as per details "
						+ " below: " + "\n"
						+ " Quality: " + W + "\n"
						+ " Quantity: " + Y + Z + " in one shipment (Charterer's Option)." + "\n"
						+ " Port of loading: " + L + "\n"
						+ " Port of discharge: " + Y + " " + Z + " " + D + "\n"
						+ " Laycan " + L + ":" + A + "\n"
						+ " Loading rate: " + K + " " + " " + G + " " + F + " " + "(" + B + ")." + "\n"
						+ " Discharge rate: " + C + " " + G + " " + AA + " /" + AB + " , (" + J + ")" + "\n"
						+ " Switch B/L: " + H + " (" + P + ")" + "\n"

					main3 += "Weighing Method: Commodity " + parseInt(i + 1)
						+ " . Draft Survey at both load port and discharge port " + " \n"
					main5 += "Commodity " + parseInt(i + 1) + "\n"
						+ " .LOA " + AC.loa + " Mts "
						+ " \n"
						+ " .BEAM " + AC.beam + " Mts "
						+ " \n"
						+ " .ARRIVAL DRAFT " + AC.arrival + " Mts "
						+ " \n \n"

				}//for
				DynamicForm_ShipmentInquiry.setValue("emailBody", ",Dear Sir/Sirs \n"
					+ " Please be informed that we intend to ship \n"
					+ main1
					+ main2
					+ main3
					+ main4
					+ main5
					+ main6
				);
				DynamicForm_ShipmentInquiry.setValue("emailType", selectionShipment[0].status);
				DynamicForm_ShipmentInquiry.setValue("emailSubject", "Cnt." + selectionShipment[0].tblContractItemShipment.tblContractItem.tblContract.contractNo + "-" + selectionShipment[0].month + "Quota-" + selectionShipment[0].tblMaterial.descl + "-NICICO/" + selectionShipment[0].tblContact.nameFA + "===" + selectionShipment[0].status);

				Window_ShipmentInquiry.show();
			}
		}//click:function()
	});

	var ToolStripButton_ShipmentInquiry_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_ShipmentInquiry_edit();
		}
	});

	var ToolStripButton_ShipmentInquiry_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_ShipmentInquiry_remove();
		}
	});

	var ToolStrip_Actions_ShipmentInquiry = isc.ToolStrip.create({
		width: "100%",
		members:
			[
				ToolStripButton_ShipmentInquiry_Copy,
				ToolStripButton_ShipmentInquiry_Refresh,
				ToolStripButton_ShipmentInquiry_Add,
				ToolStripButton_ShipmentInquiry_Edit,
				ToolStripButton_ShipmentInquiry_Remove
			]
	});

	var HLayout_ShipmentInquiry_Actions = isc.HLayout.create({
		width: "100%",
		members:
			[
				ToolStrip_Actions_ShipmentInquiry
			]
	});
	var Window_ShipmentInquiry = isc.Window.create({
		title: "<spring:message code='tenderNotice.title'/> ",
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
				DynamicForm_ShipmentInquiry,
				isc.HLayout.create({
					width: "100%",
					members:
						[

							IButton_ShipmentInquiry_Save,
							isc.Label.create({width: 5,})
							, IButton_ShipmentInquiry_Cancel
						]
				})
			]
	});
	var ListGrid_ShipmentInquiry = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_ShipmentInquiry,
		contextMenu: Menu_ListGrid_ShipmentInquiry,
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "tblShipmentHeader.id",
					title: "<spring:message code='contact.name'/>",
					align: "center",
					hidden: true
				},
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
	var HLayout_ShipmentInquiry_Grid = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_ShipmentInquiry
		]
	});

	var VLayout_ShipmentInquiry_Body = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members:
			[
				HLayout_ShipmentInquiry_Actions, HLayout_ShipmentInquiry_Grid
			]
	});

	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	isc.SectionStack.create({
		ID: "Shipment_Section_Stack",
		sections:
			[
				{
					title: "<spring:message code='shipmentHeader.title'/>",
					items: VLayout_Body_Shipment_HeaderByTender,
					expanded: true
				}
				, {
				title: "<spring:message code='Shipment.title'/>",
				items: VLayout_Body_ShipmentBytender,
				expanded: true
			}
				, {
				title: "<spring:message code='tenderNotice.title'/>",
				items: VLayout_ShipmentInquiry_Body,
				expanded: true
			}
			],
		visibilityMode: "multiple",
		animateSections: true,
		height: "100%",
		width: "100%",
		overflow: "hidden"
	});
