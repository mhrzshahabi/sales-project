<%--
  Created by IntelliJ IDEA.
  User: nooshin
  Date: 01/09/2019
  Time: 9:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

// <script>

	<spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

	var RestDataSource_Country = isc.MyRestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, hidden: true},
				{name: "code", title: "<spring:message code='goods.code'/> "},
				{name: "nameFa", title: "<spring:message code='global.country'/> "}
			],
		fetchDataURL: "${restApiUrl}/api/country/spec-list"
	});

	var RestDataSource_Contact = isc.MyRestDataSource.create({
		fields: [
			{name: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "code", title: "<spring:message code='contact.code'/>"},
			{name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
			{name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
			{name: "tblCountry.id", title: "<spring:message code='country.nameFa'/>", type: 'long'},
			{name: "tblCountry.nameFa", title: "<spring:message code='country.nameFa'/>"},
			{name: "tradeMark"},
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
			{name: "nationalcode", title: "<spring:message code='contact.nationalCode'/>"},
			{name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
			{name: "bankAccount", title: "<spring:message code='contact.bankAccount'/>"},
			{name: "bankShaba", title: "<spring:message code='contact.bankShaba'/>"},
			{name: "bankSwift", title: "<spring:message code='contact.bankShaba'/>"},
			{name: "bankName", title: "<spring:message code='contact.bankName'/>"},
			{
				name: "status",
				title: "<spring:message code='contact.status'/>",
				valueMap: {"true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"}
			},
			{name: "contactAccounts"}
		],
		fetchDataURL: "${restApiUrl}/api/contact/spec-list"
	});

	var Menu_ListGrid_Person = isc.Menu.create({
		width: 150,
		data: [
			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
					ListGrid_Person_refresh();
				}
			},
			{
				title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
				click: function () {
					DynamicForm_Person.clearValues();
					Window_Person.show();
				}
			},
			{
				title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
				click: function () {
					ListGrid_Person_edit();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					ListGrid_Person_remove();
				}
			}
		]
	});

	var ValuesManager_Person = isc.ValuesManager.create({});
	var DynamicForm_Person = isc.DynamicForm.create({
		valuesManager: ValuesManager_Person,
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
		numCols: 2,

		fields: [
			{name: "id", hidden: true,},
			{type: "RowSpacerItem"},
			{
				name: "contactId",
				title: "<spring:message code='contact.name'/>"
				,
                width: "100%",  wrapTitle : false, required: true,
				editorType: "SelectItem",
				type: 'long'
				,
				optionDataSource: RestDataSource_Contact,
				displayField: "nameFA"
				,
				valueField: "id",
				pickListWidth: 500,
				pickListheight: 500,
				pickListProperties: {showFilterEditor: true}

				,
				pickListFields: [{name: "id", width: 50, align: "center"}, {
					name: "nameFA",
					width: 150,
					align: "center"
				}, {name: "nameEN", width: 150, align: "center"}, {name: "code", width: 150, align: "center"}]
			},
			{
				name: "fullName",
				title: "<spring:message code='person.fullName'/>",
				type: 'text',  wrapTitle : false ,
				required: true,
                width: "100%",
			},
			{name: "jobTitle", title: "<spring:message code='person.jobTitle'/>", type: 'text',  width: "100%", wrapTitle : false},
			{
				name: "title",
				title: "<spring:message code='person.title'/>",
				type: 'text', wrapTitle : false ,
                width: "100%",
				valueMap: {
					"MR": "<spring:message code='global.MR'/>",
					"MIS": "<spring:message code='global.MIS'/>",
					"MRS": "<spring:message code='global.MRS'/>",
				}
			},
			{name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true, width: "100%", wrapTitle : false},
			{name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: "100%", wrapTitle : false},
			{name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: "100%", wrapTitle : false},
			{name: "webAddress", title: "<spring:message code='person.webAddress'/>", type: 'text', width: "100%", wrapTitle : false},
			{name: "phoneNo", title: "<spring:message code='person.phoneNo'/>", type: 'text', width: "100%", wrapTitle : false},
			{name: "faxNo", title: "<spring:message code='person.faxNo'/>", type: 'text', width: "100%", wrapTitle : false},
			{name: "mobileNo", title: "<spring:message code='person.mobileNo'/>", type: 'text',width: "100%", wrapTitle : false},
			{name: "mobileNo1", title: "<spring:message code='person.mobileNo1'/>", type: 'text', width: "100%", wrapTitle : false},
			{name: "mobileNo2", title: "<spring:message code='person.mobileNo2'/>", type: 'text', width: "100%", wrapTitle : false},
			{name: "whatsApp", title: "<spring:message code='person.whatsApp'/>", type: 'text', width: "100%", wrapTitle : false},
			{name: "weChat", title: "<spring:message code='person.weChat'/>", type: 'text', width: "100%", wrapTitle : false},
			{name: "address", title: "<spring:message code='person.address'/>", type: 'text', width: "100%", wrapTitle : false},
		]
	});

	var IButton_Person_Save = isc.IButton.create({
		top: 260,
		layoutMargin: 5,
		membersMargin: 5,
		width: 120,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			ValuesManager_Person.validate();
			DynamicForm_Person.validate();
			if (DynamicForm_Person.hasErrors()) {
				return;
			}
			var data = DynamicForm_Person.getValues();
			var method = "PUT";
			if (data.id == null)
				method = "POST";
			isc.RPCManager.sendRequest({
				actionURL: "${restApiUrl}/api/person",
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
						ListGrid_Person_refresh();
						Window_Person.close();
					} else {
						isc.say(RpcResponse_o.data);
					}
				}
			});
		}
	});

	var PersonCancelBtn = isc.IButton.create({
		top: 260,
		layoutMargin: 10,
		membersMargin: 10,
		width: 120,
		title: "<spring:message code='global.cancel'/>",
		icon: "pieces/16/icon_delete.png",
		click: function () {
				Window_Person.close();
		}
	});

	var HLayout_Person_IButton = isc.HLayout.create({
		layoutMargin: 10,
		membersMargin: 10,
		width: "100%",
		members: [
			IButton_Person_Save,
			PersonCancelBtn
		]
	});

	var Window_Person = isc.Window.create({
		title: "<spring:message code='person.title'/>. ",
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
			DynamicForm_Person,
			HLayout_Person_IButton
		]
	});

	function ListGrid_Person_refresh() {
		ListGrid_Person.invalidateCache();
	};

	function ListGrid_Person_remove() {

		var record = ListGrid_Person.getSelectedRecord();

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
				buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({
					title: "<spring:message
		code='global.no'/>"
				})],
				buttonClick: function (button, index) {
					this.hide();
					if (index == 0) {

						var personId = record.id;
						isc.RPCManager.sendRequest({
							actionURL: "${restApiUrl}/api/person/" + personId,
							httpMethod: "DELETE",
							httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
							useSimpleHttp: true,
							contentType: "application/json; charset=utf-8",
							showPrompt: true,
// data: personId,
							serverOutputAsString: false,
							callback: function (RpcResponse_o) {
								if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
									ListGrid_Person.invalidateCache();
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

	function ListGrid_Person_edit() {

		var record = ListGrid_Person.getSelectedRecord();

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
			DynamicForm_Person.editRecord(record);
			Window_Person.show();
		}
	};


	var ToolStripButton_Person_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_Person_refresh();
		}
	});

	var ToolStripButton_Person_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			DynamicForm_Person.clearValues();
			Window_Person.show();
		}
	});

	var ToolStripButton_Person_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_Person_edit();
		}
	});


	var ToolStripButton_Person_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_Person_remove();
		}
	});

	var ToolStrip_Actions_Person = isc.ToolStrip.create({
		width: "100%",
		members: [
			ToolStripButton_Person_Refresh,
			ToolStripButton_Person_Add,
			ToolStripButton_Person_Edit,
			ToolStripButton_Person_Remove
		]
	});

	var HLayout_Actions_Person = isc.HLayout.create({
		width: "100%",
		members: [
			ToolStrip_Actions_Person
		]
	});

	var RestDataSource_Person = isc.MyRestDataSource.create({
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

	var ListGrid_Person = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Person,
		contextMenu: Menu_ListGrid_Person,
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
			ListGrid_Person
		]
	});

	var VLayout_Body_Person = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Actions_Person, HLayout_Grid_Person
		]
	});