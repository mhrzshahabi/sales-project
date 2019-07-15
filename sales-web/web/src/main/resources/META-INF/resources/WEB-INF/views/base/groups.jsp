<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	<spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

	var RestDataSource_Person_GroupEmail = isc.MyRestDataSource.create({
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "contactId"},
			{name: "contact.nameFA"},
			{
				name: "fullName",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',
				required: true,
				width: 400
			},
			{name: "jobTitle", title: "<spring:message code='person.jobTitle'/>", type: 'text', width: 400},
			{
				name: "title",
				title: "<spring:message code='person.title'/>",
				type: 'text',
				width: 400,
				valueMap: {
					"MR": "<spring:message code='global.MR'/>",
					"MIS": "<spring:message code='global.MIS'/>",
					"MRS": "<spring:message code='global.MRS'/>",
				}
			},
			{name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true, width: 400},
			{name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 400},
			{name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 400},
			{name: "webAddress", title: "<spring:message code='person.webAddress'/>", type: 'text', width: 400},
			{name: "phoneNo", title: "<spring:message code='person.phoneNo'/>", type: 'text', width: 400},
			{name: "faxNo", title: "<spring:message code='person.faxNo'/>", type: 'text', width: 400},
			{name: "mobileNo", title: "<spring:message code='person.mobileNo'/>", type: 'text', width: 400},
			{name: "mobileNo1", title: "<spring:message code='person.mobileNo1'/>", type: 'text', width: 400},
			{name: "mobileNo2", title: "<spring:message code='person.mobileNo2'/>", type: 'text', width: 400},
			{name: "whatsApp", title: "<spring:message code='person.whatsApp'/>", type: 'text', width: 400},
			{name: "weChat", title: "<spring:message code='person.weChat'/>", type: 'text', width: 400},
			{name: "address", title: "<spring:message code='person.address'/>", type: 'text', width: 400},
		],

		fetchDataURL: "${restApiUrl}/api/person/spec-list"
	});

	var Menu_ListGrid_Groups = isc.Menu.create({
		width: 150,
		data: [

			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
					ListGrid_Groups_refresh();
				}
			},
			{
				title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
				click: function () {
					DynamicForm_Groups.clearValues();
					Window_Groups.show();
				}
			},
			{
				title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
				click: function () {
					ListGrid_Groups_edit();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					ListGrid_Groups_remove();
				}
			}
		]
	});

	var ValuesManager_Groups = isc.ValuesManager.create({});
	var DynamicForm_Groups = isc.DynamicForm.create({
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

		fields: [
			{name: "id", hidden: true,},
			{type: "RowSpacerItem"},
			{
				name: "groupsName",
				title: "<spring:message code='groups.groupsName'/>",
				type: 'text',
				required: true,
				width: 400
			},
		]
	});

	var IButton_Groups_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			ValuesManager_Groups.validate();
			DynamicForm_Groups.validate();
			if (DynamicForm_Groups.hasErrors()) {
				return;
			}
			var data = DynamicForm_Groups.getValues();
			var method = "PUT";
			if (data.id == null)
				method = "POST";
			isc.RPCManager.sendRequest({
				actionURL: "${restApiUrl}/api/groups",
				httpMethod: method,
				useSimpleHttp: true,
				contentType: "application/json; charset=utf-8",
				httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
				showPrompt: false,
				data: JSON.stringify(data),
				serverOutputAsString: false,
				callback: function (RpcResponse_o) {
					if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
						isc.say("<spring:message code='global.form.request.successful'/>");
						ListGrid_Groups_refresh();
						Window_Groups.close();
					} else {
						isc.say(RpcResponse_o.data);
					}
				}
			});
		}
	});

	var GroupsCancelBtn = isc.IButton.create({
		top: 260,
		layoutMargin: 5,
		membersMargin: 5,
		width: 120,
		title: "<spring:message code='global.cancel'/>",
		icon: "pieces/16/icon_delete.png",
		click: function () {
				Window_Groups.close();
		}
		});

		var HLayout_Groups_IButton = isc.HLayout.create({
		layoutMargin: 5,
		membersMargin: 5,
		width: "100%",
		members: [
			IButton_Groups_Save,
			GroupsCancelBtn
		]
	});

	var Window_Groups = isc.Window.create({
		title: "<spring:message code='groups.title'/>. ",
		width: 580,
		hight: 500,
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
			DynamicForm_Groups,
			HLayout_Groups_IButton
		]
	});

	function ListGrid_Groups_refresh() {
		ListGrid_Groups.invalidateCache();
	};

	function ListGrid_Groups_remove() {

		var record = ListGrid_Groups.getSelectedRecord();

		if (record == null || record.id == null) {
			isc.Dialog.create({
				message: "<spring:message code='global.grid.record.not.selected'/>. !",
				icon: "[SKIN]ask.png",
				title: "<spring:message code='global.message'/>.",
				buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
				buttonClick: function () {
					this.hide();
				}
			});
		} else {
			isc.Dialog.create({
				message: "<spring:message code='global.grid.record.remove.ask'/>",
				icon: "[SKIN]ask.png",
				title: "<spring:message code='global.grid.record.remove.ask.title'/>",
				buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({
					title: "<spring:message	code='global.no'/>"
				})],
				buttonClick: function (button, index) {
					this.hide();
					if (index == 0) {

						var groupsId = record.id;
						isc.RPCManager.sendRequest({
							actionURL: "${restApiUrl}/api/groups/" + groupsId,
							httpMethod: "DELETE",
							useSimpleHttp: true,
							contentType: "application/json; charset=utf-8",
							httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
							showPrompt: true,
							serverOutputAsString: false,
							callback: function (RpcResponse_o) {
								if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
									ListGrid_Groups.invalidateCache();
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

	function ListGrid_Groups_edit() {

		var record = ListGrid_Groups.getSelectedRecord();

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
			DynamicForm_Groups.editRecord(record);
			Window_Groups.show();
		}
	};


	var ToolStripButton_Groups_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_Groups_refresh();
		}
	});

	var ToolStripButton_Groups_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			DynamicForm_Groups.clearValues();
			Window_Groups.show();
		}
	});

	var ToolStripButton_Groups_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_Groups_edit();
		}
	});


	var ToolStripButton_Groups_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_Groups_remove();
		}
	});

	var ToolStrip_Actions_Groups = isc.ToolStrip.create({
		width: "100%",
		members: [
			ToolStripButton_Groups_Refresh,
			ToolStripButton_Groups_Add,
			ToolStripButton_Groups_Edit,
			ToolStripButton_Groups_Remove
		]
	});

	var HLayout_Actions_Groups = isc.HLayout.create({
		width: "100%",
		members: [
			ToolStrip_Actions_Groups
		]
	});

	var RestDataSource_Groups = isc.MyRestDataSource.create({
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{
				name: "groupsName",
				title: "<spring:message code='groups.groupsName'/>",
				type: 'text',
				required: true,
				width: 400
			},
		],

		fetchDataURL: "${restApiUrl}/api/groups/spec-list"
	});

	var ListGrid_Groups = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Groups,
		contextMenu: Menu_ListGrid_Groups,
		canDragRecordsOut: true,
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{
				name: "groupsName",
				title: "<spring:message code='groups.groupsName'/>",
				type: 'text',
				required: true,
				width: 400
			},
		],

		sortField: 0,
		dataPageSize: 50,
		autoFetchData: true,
		showFilterEditor: true,
		filterOnKeypress: true,
		startsWithTitle: "tt",

		recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
		updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
			var record = this.getSelectedRecord();
			var criteria1 = {
				_constructor: "AdvancedCriteria",
				operator: "and",
				criteria: [{fieldName: "groupsId", operator: "equals", value: record.id}]
			};
			ListGrid_GroupsPerson.fetchData(criteria1, function (dsResponse, data, dsRequest) {
				ListGrid_GroupsPerson.setData(data);
			}, {operationId: "00"});
		},
		dataArrived: function (startRow, endRow) {
		},


	});


	var HLayout_Grid_Groups = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_Groups
		]
	});

	var VLayout_Body_Groups = isc.VLayout.create({
		width: "25%",
		height: "100%",
		members: [
			HLayout_Actions_Groups, HLayout_Grid_Groups
		]
	});
	//************************************************************************ person ************

	var RestDataSource_Contact_GroupEmail = isc.MyRestDataSource.create({
		fields: [
			{name: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "code", title: "<spring:message code='contact.code'/>"},
			{name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
			{name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
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
			{name: "ceoPassportNo"},
			{name: "ceo"},
			{name: "commercialRole"},
			{
				name: "status",
				title: "<spring:message code='contact.status'/>",
				valueMap: {"true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"}
			},
			{name: "tradeMark"},
			{name: "commercialRegistration"},
			{name: "branchName"},
			{name: "countryId", title: "<spring:message code='country.nameFa'/>", type: 'long'},
			{name: "country.nameFa", title: "<spring:message code='country.nameFa'/>"},
			{name: "contactAccounts"}
		],
		fetchDataURL: "${restApiUrl}/api/contact/spec-list"
	});

	var Menu_ListGrid_Person_GroupEmail = isc.Menu.create({
		width: 150,
		data:
			[
				{
					title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
					click: function () {
							ListGrid_Person_GroupEmail_refresh();
					}
				}
			]
	});

	function ListGrid_Person_GroupEmail_refresh() {
			ListGrid_Person_GroupEmail.invalidateCache();
	};

	var ToolStripButton_Person_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
				ListGrid_Person_GroupEmail_refresh();
		}
	});

	var ToolStrip_Actions_Person = isc.ToolStrip.create({
		width: "100%",
		members: [
			ToolStripButton_Person_Refresh

		]
	});

	var HLayout_Actions_Person = isc.HLayout.create({
		width: "100%",
		members: [
			ToolStrip_Actions_Person
		]
	});

	var ListGrid_Person_GroupEmail = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Person_GroupEmail,
		contextMenu: Menu_ListGrid_Person_GroupEmail,
		canDragRecordsOut: true,
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{
				name: "contact.nameFA",
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
			{name: "jobTitle", title: "<spring:message code='person.jobTitle'/>", type: 'text', width: 150},
			{
				name: "title",
				title: "<spring:message code='person.title'/>",
				type: 'text',
				width: 150,
				valueMap: {
					"MR": "<spring:message code='global.MR'/>",
					"MIS": "<spring:message code='global.MIS'/>",
					"MRS": "<spring:message code='global.MRS'/>",
				}
			},
			{name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true, width: 150},
			{name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 150},
			{name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 150},
			{name: "webAddress", title: "<spring:message code='person.webAddress'/>", type: 'text', width: 150},
			{name: "phoneNo", title: "<spring:message code='person.phoneNo'/>", type: 'text', width: 150},
			{name: "faxNo", title: "<spring:message code='person.faxNo'/>", type: 'text', width: 150},
			{name: "mobileNo", title: "<spring:message code='person.mobileNo'/>", type: 'text', width: 150},
			{name: "mobileNo1", title: "<spring:message code='person.mobileNo1'/>", type: 'text', width: 150},
			{name: "mobileNo2", title: "<spring:message code='person.mobileNo2'/>", type: 'text', width: 150},
			{name: "whatsApp", title: "<spring:message code='person.whatsApp'/>", type: 'text', width: 150},
			{name: "weChat", title: "<spring:message code='person.weChat'/>", type: 'text', width: 150},
			{name: "address", title: "<spring:message code='person.address'/>", type: 'text', width: 150},

		],
		recordDoubleClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
		updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
			var record = this.getSelectedRecord();
			ListGrid_GroupsPerson.fetchData({"personId": record.id}, function (dsResponse, data, dsRequest) {
				ListGrid_GroupsPerson.setData(data);
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
	var HLayout_Grid_Person = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_Person_GroupEmail
		]
	});

	var VLayout_Body_Person = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Actions_Person, HLayout_Grid_Person
		]
	});
	//*************************************************************************end person ********
	var HLayout_2Vlayout_GroupsPerson = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			VLayout_Body_Groups, VLayout_Body_Person
		]
	});
	//*******************************************************************************
	var Menu_ListGrid_GroupsPerson = isc.Menu.create({
		width: 150,
		data:
			[
				{
					title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
					click: function () {
						ListGrid_GroupsPerson_refresh();
					}
				},
				{
					title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
					click: function () {
						DynamicForm_GroupsPerson.clearValues();
						Window_GroupsPerson.show();
					}
				},
				{
					title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
					click: function () {
						ListGrid_GroupsPerson_edit();
					}
				},
				{
					title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
					click: function () {
						ListGrid_GroupsPerson_remove();
					}
				}
			]
	});
	var ValuesManager_GroupsPerson = isc.ValuesManager.create({});
	var DynamicForm_GroupsPerson = isc.DynamicForm.create({
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
				{name: "id", hidden: true,},
				{type: "RowSpacerItem"},
				{name: "groupsId", type: "long", hidden: true},
				{type: "RowSpacerItem"},
				{
					name: "personId",
					title: "<spring:message code='person.fullName'/>",
					type: 'long',
					width: 400,
					editorType: "SelectItem"
					,
					optionDataSource: RestDataSource_Person_GroupEmail,
					displayField: "fullName"
					,
					valueField: "id",
					pickListWidth: "500",
					pickListheight: "500",
					pickListProperties: {showFilterEditor: true}
					,
					pickListFields: [{name: "id", width: 50, align: "center"}, {
						name: "fullName",
						width: 150,
						align: "center"
					}, {name: "contact.nameFA", width: 150, align: "center"}, {
						name: "email",
						width: 150,
						align: "center"
					}]
				},
			]
	});

	var IButton_GroupsPerson_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			ValuesManager_GroupsPerson.validate();
			DynamicForm_GroupsPerson.validate();
			if (DynamicForm_GroupsPerson.hasErrors()) {
				return;
			}
			var data = DynamicForm_GroupsPerson.getValues();
			var method = "PUT";
			if (data.id == null)
				method = "POST";
			isc.RPCManager.sendRequest({
				actionURL: "${restApiUrl}/api/groupsPerson",
				httpMethod: method,
				httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
				useSimpleHttp: true,
				contentType: "application/json; charset=utf-8",
				showPrompt: true,
				data: JSON.stringify(data),
				serverOutputAsString: false,
				callback: function (RpcResponse_o) {
					if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
						isc.say("<spring:message code='global.form.request.successful'/>");
						ListGrid_GroupsPerson_refresh();
						Window_GroupsPerson.close();
					} else {
						isc.say(RpcResponse_o.data);
					}
				}
			});
		}
	});

	var GroupsPersonCancelBtn = isc.IButton.create({
		top: 260,
		layoutMargin: 5,
		membersMargin: 5,
		width: 120,
		title: "<spring:message code='global.cancel'/>",
		icon: "pieces/16/icon_delete.png",
		click: function () {
				Window_GroupsPerson.close();
		}
	});

	var HLayout_GroupsPerson_IButton = isc.HLayout.create({
		layoutMargin: 5,
		membersMargin: 5,
		width: "100%",
		members: [
			IButton_GroupsPerson_Save,
			GroupsPersonCancelBtn
		]
	});

	var Window_GroupsPerson = isc.Window.create({
		title: "<spring:message code='groupsPerson.title'/>. ",
		width: 580,
		hight: 500,
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
		items:
			[
				DynamicForm_GroupsPerson,
				HLayout_GroupsPerson_IButton
			]
	});

	function ListGrid_GroupsPerson_refresh() {
		ListGrid_GroupsPerson.invalidateCache();
		var record = ListGrid_Groups.getSelectedRecord();
		if (record == null || record.id == null)
			ListGrid_GroupsPerson.invalidateCache();
		ListGrid_GroupsPerson.fetchData({"tblGroups.id": record.id}, function (dsResponse, data, dsRequest) {
			ListGrid_GroupsPerson.setData(data);
		}, {operationId: "00"});
	};

	function ListGrid_GroupsPerson_remove() {
		var record = ListGrid_GroupsPerson.getSelectedRecord();
		if (record == null || record.id == null) {
			isc.Dialog.create({
				message: "<spring:message code='global.grid.record.not.selected'/>. !",
				icon: "[SKIN]ask.png",
				title: "<spring:message code='global.message'/>.",
				buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
				buttonClick: function () {
					this.hide();
				}
			});
		} else {
			isc.Dialog.create({
				message: "<spring:message code='global.grid.record.remove.ask'/>",
				icon: "[SKIN]ask.png",
				title: "<spring:message code='global.grid.record.remove.ask.title'/>",
				buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({
					title: "<spring:message	code='global.no'/>"
				})],
				buttonClick: function (button, index) {
					this.hide();
					if (index == 0) {
						var groupsPersonId = record.id;
						isc.RPCManager.sendRequest({
							actionURL: "${restApiUrl}/api/groupsPerson/" + groupsPersonId,
							httpMethod: "DELETE",
							httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
							useSimpleHttp: true,
							contentType: "application/json; charset=utf-8",
							showPrompt: true,
							serverOutputAsString: false,
							callback: function (RpcResponse_o) {
								if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
									ListGrid_GroupsPerson.invalidateCache();
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

	function ListGrid_GroupsPerson_edit() {

		var record = ListGrid_GroupsPerson.getSelectedRecord();
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
			DynamicForm_GroupsPerson.editRecord(record);
			Window_GroupsPerson.show();
		}
	};
	var ToolStripButton_GroupsPerson_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_GroupsPerson_refresh();
		}
	});

	var ToolStripButton_GroupsPerson_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			var record = ListGrid_Groups.getSelectedRecord();

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
				DynamicForm_GroupsPerson.clearValues();
				DynamicForm_GroupsPerson.setValue("groupsId", record.id);
				Window_GroupsPerson.show();
			}
		}
	});

	var ToolStripButton_GroupsPerson_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_GroupsPerson_edit();
		}
	});
	var ToolStripButton_GroupsPerson_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_GroupsPerson_remove();
		}
	});

	var ToolStrip_Actions_GroupsPerson = isc.ToolStrip.create({
		width: "100%",
		members: [
			ToolStripButton_GroupsPerson_Refresh,
			ToolStripButton_GroupsPerson_Add,
			ToolStripButton_GroupsPerson_Edit,
			ToolStripButton_GroupsPerson_Remove
		]
	});
	var HLayout_Actions_GroupsPerson = isc.HLayout.create({
		width: "100%",
		members: [
			ToolStrip_Actions_GroupsPerson
		]
	});
	var RestDataSource_GroupsPerson = isc.MyRestDataSource.create({
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{
				name: "groupsId",
				title: "<spring:message code='groups.groupsName'/>",
				type: 'text',
				required: true,
				width: 400,
				hidden: true
			},
			{
				name: "groups.groupsName",
				title: "<spring:message code='groups.groupsName'/>",
				type: 'text',
				required: true,
				width: 400
			},
			{
				name: "person.id",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',
				required: true,
				width: 400,
				hidden: true
			},
			{
				name: "person.fullName",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',
				required: true,
				width: 400
			},
			{
				name: "person.contact.nameFA",
				title: "<spring:message code='contact.name'/>",
				type: 'long',
				width: 120,
				align: "center"
			},
			{
				name: "person.fullName",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',
				required: true,
				width: 150
			},
			{name: "person.jobTitle", title: "<spring:message code='person.jobTitle'/>", type: 'text', width: 150},
			{
				name: "person.title",
				title: "<spring:message code='person.title'/>",
				type: 'text',
				width: 150,
				valueMap: {
					"MR": "<spring:message code='global.MR'/>",
					"MIS": "<spring:message code='global.MIS'/>",
					"MRS": "<spring:message code='global.MRS'/>",
				}
			},
			{
				name: "person.email",
				title: "<spring:message code='person.email'/>",
				type: 'text',
				required: true,
				width: 150
			},
			{name: "person.email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 150},
			{name: "person.email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 150},
			{
				name: "person.webAddress",
				title: "<spring:message code='person.webAddress'/>",
				type: 'text',
				width: 150
			},
			{name: "person.phoneNo", title: "<spring:message code='person.phoneNo'/>", type: 'text', width: 150},
			{name: "person.faxNo", title: "<spring:message code='person.faxNo'/>", type: 'text', width: 150},
			{name: "person.mobileNo", title: "<spring:message code='person.mobileNo'/>", type: 'text', width: 150},
			{name: "person.mobileNo1", title: "<spring:message code='person.mobileNo1'/>", type: 'text', width: 150},
			{name: "person.mobileNo2", title: "<spring:message code='person.mobileNo2'/>", type: 'text', width: 150},
			{name: "person.whatsApp", title: "<spring:message code='person.whatsApp'/>", type: 'text', width: 150},
			{name: "person.weChat", title: "<spring:message code='person.weChat'/>", type: 'text', width: 150},
			{name: "person.address", title: "<spring:message code='person.address'/>", type: 'text', width: 150},
		],

		fetchDataURL: "${restApiUrl}/api/groupsPerson/spec-list"
	});
	var ListGrid_GroupsPerson = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_GroupsPerson,
		contextMenu: Menu_ListGrid_GroupsPerson,
		canAcceptDroppedRecords: true,
		addDropValues: true,
		recordDrop: function (dropRecords, targetRecord, index, sourceWidget) {

			if (this === sourceWidget)
				return;

			if (dropRecords.length > 1)
				return;
			if (ListGrid_Groups.getSelectedRecord() == null || ListGrid_Groups.getSelectedRecord().id == null
				|| ListGrid_Person_GroupEmail.getSelectedRecord() == null || ListGrid_Person.getSelectedRecord().id == null) {
				isc.say("<spring:message code='global.grid.record.not.selected'/>");
				return;
			}
			DynamicForm_GroupsPerson.clearValues();
			DynamicForm_GroupsPerson.setValue("groupsId", ListGrid_Groups_GroupEmail.getSelectedRecord().id);
			DynamicForm_GroupsPerson.setValue("personId", ListGrid_Person_GroupEmail.getSelectedRecord().id);
			var data = DynamicForm_GroupsPerson.getValues();
			var method = "PUT";
			if (data.id == null)
				method = "POST";
			isc.RPCManager.sendRequest({
				actionURL: "${restApiUrl}/api/groupsPerson",
				httpMethod: method,
				httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
				useSimpleHttp: true,
				contentType: "application/json; charset=utf-8",
				showPrompt: true,
				data: JSON.stringify(data),
				serverOutputAsString: false,
				callback: function (RpcResponse_o) {
					if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
								isc.say("<spring:message code='global.form.request.successful'/>");
						ListGrid_GroupsPerson_refresh();
					} else
						isc.say(RpcResponse_o.data);
				}
			});

		},
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{
				name: "groups.id",
				title: "<spring:message code='groups.groupsName'/>",
				type: 'text',
				required: true,
				width: 400,
				hidden: true
			},
			{
				name: "groups.groupsName",
				title: "<spring:message code='groups.groupsName'/>",
				type: 'text',
				required: true,
				width: 400
			},
			{
				name: "person.id",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',
				required: true,
				width: 400,
				hidden: true
			},
			{
				name: "person.fullName",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',
				required: true,
				width: 400
			},
			{
				name: "person.contact.nameFA",
				title: "<spring:message code='contact.name'/>",
				type: 'long',
				width: 120,
				align: "center"
			},
			{
				name: "person.fullName",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',
				required: true,
				width: 150
			},
			{name: "person.jobTitle", title: "<spring:message code='person.jobTitle'/>", type: 'text', width: 150},
			{
				name: "person.title",
				title: "<spring:message code='person.title'/>",
				type: 'text',
				width: 150,
				valueMap: {
					"MR": "<spring:message code='global.MR'/>",
					"MIS": "<spring:message code='global.MIS'/>",
					"MRS": "<spring:message code='global.MRS'/>",
				}
			},
			{
				name: "person.email",
				title: "<spring:message code='person.email'/>",
				type: 'text',
				required: true,
				width: 150
			},
			{name: "person.email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 150},
			{name: "person.email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 150},
			{
				name: "person.webAddress",
				title: "<spring:message code='person.webAddress'/>",
				type: 'text',
				width: 150
			},
			{name: "person.phoneNo", title: "<spring:message code='person.phoneNo'/>", type: 'text', width: 150},
			{name: "person.faxNo", title: "<spring:message code='person.faxNo'/>", type: 'text', width: 150},
			{name: "person.mobileNo", title: "<spring:message code='person.mobileNo'/>", type: 'text', width: 150},
			{name: "person.mobileNo1", title: "<spring:message code='person.mobileNo1'/>", type: 'text', width: 150},
			{name: "person.mobileNo2", title: "<spring:message code='person.mobileNo2'/>", type: 'text', width: 150},
			{name: "person.whatsApp", title: "<spring:message code='person.whatsApp'/>", type: 'text', width: 150},
			{name: "person.weChat", title: "<spring:message code='person.weChat'/>", type: 'text', width: 150},
			{name: "person.address", title: "<spring:message code='person.address'/>", type: 'text', width: 150},

		],
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: false,
		showFilterEditor: true,
		filterOnKeypress: true,
		startsWithTitle: "tt"
	});
	var HLayout_Grid_GroupsPerson = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_GroupsPerson
		]
	});

	var VLayout_Body_GroupsPerson = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Actions_GroupsPerson, HLayout_Grid_GroupsPerson
		]
	});


	isc.SectionStack.create({
		ID: "Groups_Section_Stack",
		sections:
			[
				{title: "<spring:message code='groups.title'/>", items: HLayout_2Vlayout_GroupsPerson, expanded: true}
				, {
				title: "<spring:message code='groupsPerson.title'/>",
				items: VLayout_Body_GroupsPerson,
				expanded: true
			}
			],
		visibilityMode: "multiple",
		animateSections: true,
		height: "100%",
		width: "100%",
		overflow: "hidden"
	});
