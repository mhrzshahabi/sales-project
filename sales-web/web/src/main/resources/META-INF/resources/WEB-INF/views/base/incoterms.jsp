<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	<spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

	var Menu_ListGrid_Incoterms = isc.Menu.create({
		width: 150,
		data: [
			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
					ListGrid_Incoterms_refresh();
				}
			},
			{
				title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
				click: function () {
					DynamicForm_Incoterms.clearValues();
					Window_Incoterms.show();
				}
			},
			{
				title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
				click: function () {
					ListGrid_Incoterms_edit();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					ListGrid_Incoterms_remove();
				}
			}
		]
	});

	var ValuesManager_Incoterms = isc.ValuesManager.create({});
	var DynamicForm_Incoterms = isc.DynamicForm.create({
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
				{
					name: "code",
					title: "<spring:message code='incoterms.code'/>",
					type: 'text',
					required: true,
					wrapTitle : false ,
					width: 500
				},
				{
					name: "works",
					title: "<spring:message code='incoterms.works'/>",
					type: 'checkbox',
					editorType: 'checkbox',
					required: true,
defaultValue : false ,
					wrapTitle : false ,
					width: 500
				},
				{
					name: "carrier",
					title: "<spring:message code='incoterms.carrier'/>",
					type: 'checkbox',
					editorType: 'checkbox',
					wrapTitle : false ,
defaultValue : false ,
					width: 500
				},
				{
					name: "alongSideShip",
					title: "<spring:message code='incoterms.alongSideShip'/>",
					editorType: 'checkbox',
					type: 'checkbox',
					wrapTitle : false ,
defaultValue : false ,
					width: 500
				},
				{
					name: "arrival",
					title: "<spring:message code='incoterms.arrival'/>",
					type: 'checkbox',
					editorType: 'checkbox',
					wrapTitle : false ,
defaultValue : false ,
					width: 500
				},
				{
					name: "onBoard",
					title: "<spring:message code='incoterms.onBoard'/>",
					type: 'checkbox',
					editorType: 'checkbox',
					wrapTitle : false ,
defaultValue : false ,
					width: 500
				},
				{
					name: "terminal",
					title: "<spring:message code='incoterms.terminal'/>",
					type: 'checkbox',
					editorType: 'checkbox',
					wrapTitle : false ,
defaultValue : false ,
					width: 500
				},
				{
					name: "destination",
					title: "<spring:message code='incoterms.destination'/>",
					type: 'checkbox',
					editorType: 'checkbox',
					wrapTitle : false ,
defaultValue : false ,
					width: 500
				},
				{
					name: "warehouse",
					title: "<spring:message code='incoterms.warehouse'/>",
					type: 'checkbox',
					editorType: 'checkbox',
					wrapTitle : false ,
defaultValue : false ,
					width: 500
				},
				{
					name: "expenses", title: "<spring:message code='incoterms.expenses'/>", width: 500 , wrapTitle : false , valueMap: {
						"1": "<spring:message code='incoterms.works'/>",
						"2": "<spring:message code='incoterms.carrier'/>",
						"3": "<spring:message code='incoterms.alongSideShip'/>",
						"4": "<spring:message code='incoterms.onBoard'/>",
						"5": "<spring:message code='incoterms.arrival'/>",
						"6": "<spring:message code='incoterms.terminal'/>",
						"7": "<spring:message code='incoterms.destination'/>",
						"8": "<spring:message code='incoterms.warehouse'/>"
					}
				},
				{
					name: "namedPlace", title: "<spring:message code='incoterms.namedPlace'/>", width: 500 , wrapTitle : false , valueMap: {
						"1": "<spring:message code='incoterms.works'/>",
						"2": "<spring:message code='incoterms.carrier'/>",
						"3": "<spring:message code='incoterms.alongSideShip'/>",
						"4": "<spring:message code='incoterms.onBoard'/>",
						"5": "<spring:message code='incoterms.arrival'/>",
						"6": "<spring:message code='incoterms.terminal'/>",
						"7": "<spring:message code='incoterms.destination'/>",
						"8": "<spring:message code='incoterms.warehouse'/>"
					}
				},
				{
					name: "namedPort", title: "<spring:message code='incoterms.namedPort'/>", width: 500 , wrapTitle : false , valueMap: {
						"1": "<spring:message code='incoterms.works'/>",
						"2": "<spring:message code='incoterms.carrier'/>",
						"3": "<spring:message code='incoterms.alongSideShip'/>",
						"4": "<spring:message code='incoterms.onBoard'/>",
						"5": "<spring:message code='incoterms.arrival'/>",
						"6": "<spring:message code='incoterms.terminal'/>",
						"7": "<spring:message code='incoterms.destination'/>",
						"8": "<spring:message code='incoterms.warehouse'/>"
					}
				}
			]
	});

	var IButton_Incoterms_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			ValuesManager_Incoterms.validate();
			DynamicForm_Incoterms.validate();
			if (DynamicForm_Incoterms.hasErrors()) {
				return;
			}
			var data = DynamicForm_Incoterms.getValues();
			var methodXXXX = "PUT";
			if (data.id == null) methodXXXX = "POST";
			isc.RPCManager.sendRequest(
				Object.assign(BaseRPCRequest, {
					actionURL: "${restApiUrl}/api/incoterms/",
					httpMethod: methodXXXX,
					data: JSON.stringify(data),
					callback: function (RpcResponse_o) {
						if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
							isc.say("<spring:message code='global.form.request.successful'/>");
							ListGrid_Incoterms_refresh();
							Window_Incoterms.close();
						} else {
							isc.say(RpcResponse_o.data);
						}
					}
				})
			);
		}
	});

	var IncotermsCancelBtn = isc.IButton.create({
		top: 260,
		layoutMargin: 5,
		membersMargin: 5,
		width: 120,
		title: "<spring:message code='global.cancel'/>",
		click: function () {
				Window_Incoterms.close();
		}
	});

	var HLayout_Incoterms_IButton = isc.HLayout.create({
		layoutMargin: 5,
		membersMargin: 5,
		width: "100%",
		members: [
			IButton_Incoterms_Save,
			IncotermsCancelBtn
		]
	});

	var Window_Incoterms = isc.Window.create({
		title: "<spring:message code='incoterms.name'/> ",
		width: 580,
		height: 500,
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
				DynamicForm_Incoterms,
				HLayout_Incoterms_IButton
			]
	});

	function ListGrid_Incoterms_refresh() {
		ListGrid_Incoterms.invalidateCache();
	};

	function ListGrid_Incoterms_remove() {

		var record = ListGrid_Incoterms.getSelectedRecord();

		if (record == null || record.id == null) {
			isc.Dialog.create({
				message: "<spring:message code='global.grid.record.not.selected'/>",
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

						var incotermsId = record.id;
						isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
							{
								actionURL: "${restApiUrl}/api/incoterms/" + incotermsId,
								httpMethod: "DELETE",
								serverOutputAsString: false,
								callback: function (RpcResponse_o) {
									if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
										ListGrid_Incoterms.invalidateCache();
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
	};

	function ListGrid_Incoterms_edit() {
		var record = ListGrid_Incoterms.getSelectedRecord();
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
			DynamicForm_Incoterms.editRecord(record);
			Window_Incoterms.show();
		}
	};
	var ToolStripButton_Incoterms_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_Incoterms_refresh();
		}
	});

	var ToolStripButton_Incoterms_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			DynamicForm_Incoterms.clearValues();
			Window_Incoterms.show();
		}
	});

	var ToolStripButton_Incoterms_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_Incoterms_edit();
		}
	});
	var ToolStripButton_Incoterms_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_Incoterms_remove();
		}
	});

	<%--var ToolStripButton_Incoterms_Filter = isc.ToolStripButton.create({--%>
	<%--icon: "[SKIN]/actions/search.png",--%>
	<%--title: "<spring:message code='global.form.filter'/>",--%>
	<%--click: function(){--%>
	<%--//alert('Test');--%>
	<%--//ListGrid_Incoterms.showFilterEditor(true);--%>
	<%--//ListGrid_Incoterms.filterOnKeypress(true);--%>
	<%--//ListGrid_Incoterms.redraw();--%>
	<%--}--%>
	<%--});--%>
	var ToolStrip_Actions_Incoterms_ = isc.ToolStrip.create({
		width: "100%",
		members:
			[
				ToolStripButton_Incoterms_Refresh,
				ToolStripButton_Incoterms_Add,
				ToolStripButton_Incoterms_Edit,
				ToolStripButton_Incoterms_Remove
			]
	});

	var HLayout_Actions_Incoterms_ = isc.HLayout.create({
		width: "100%",
		members:
			[
				ToolStrip_Actions_Incoterms_
			]
	});

	var RestDataSource_Incoterms = isc.MyRestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "code",
					title: "<spring:message code='incoterms.code'/>",
					type: 'text',
					required: true,
					width: 150
				},
				{
					name: "works",
					title: "<spring:message code='incoterms.works'/>",
					type: 'checkbox',
					required: true,
					width: 150
				},
				{name: "carrier", title: "<spring:message code='incoterms.carrier'/>", type: 'checkbox', width: 150},
				{
					name: "alongSideShip",
					title: "<spring:message code='incoterms.alongSideShip'/>",
					type: 'checkbox',
					width: 150
				},
				{name: "arrival", title: "<spring:message code='incoterms.arrival'/>", type: 'checkbox', width: 150},
				{name: "onBoard", title: "<spring:message code='incoterms.onBoard'/>", type: 'checkbox', width: 150},
				{name: "terminal", title: "<spring:message code='incoterms.terminal'/>", type: 'checkbox', width: 150},
				{
					name: "destination",
					title: "<spring:message code='incoterms.destination'/>",
					type: 'checkbox',
					width: 150
				},
				{
					name: "warehouse",
					title: "<spring:message code='incoterms.warehouse'/>",
					type: 'checkbox',
					width: 150
				},
				{
					name: "expenses", title: "<spring:message code='incoterms.expenses'/>", valueMap: {
						"1": "<spring:message code='incoterms.works'/>",
						"2": "<spring:message code='incoterms.carrier'/>",
						"3": "<spring:message code='incoterms.alongSideShip'/>",
						"4": "<spring:message code='incoterms.onBoard'/>",
						"5": "<spring:message code='incoterms.arrival'/>",
						"6": "<spring:message code='incoterms.terminal'/>",
						"7": "<spring:message code='incoterms.destination'/>",
						"8": "<spring:message code='incoterms.warehouse'/>"
					}
				},
				{
					name: "namedPlace", title: "<spring:message code='incoterms.namedPlace'/>", valueMap: {
						"1": "<spring:message code='incoterms.works'/>",
						"2": "<spring:message code='incoterms.carrier'/>",
						"3": "<spring:message code='incoterms.alongSideShip'/>",
						"4": "<spring:message code='incoterms.onBoard'/>",
						"5": "<spring:message code='incoterms.arrival'/>",
						"6": "<spring:message code='incoterms.terminal'/>",
						"7": "<spring:message code='incoterms.destination'/>",
						"8": "<spring:message code='incoterms.warehouse'/>"
					}
				},
				{
					name: "namedPort", title: "<spring:message code='incoterms.namedPort'/>", valueMap: {
						"1": "<spring:message code='incoterms.works'/>",
						"2": "<spring:message code='incoterms.carrier'/>",
						"3": "<spring:message code='incoterms.alongSideShip'/>",
						"4": "<spring:message code='incoterms.onBoard'/>",
						"5": "<spring:message code='incoterms.arrival'/>",
						"6": "<spring:message code='incoterms.terminal'/>",
						"7": "<spring:message code='incoterms.destination'/>",
						"8": "<spring:message code='incoterms.warehouse'/>"
					}
				},
			],
		fetchDataURL: "${restApiUrl}/api/incoterms/spec-list"
	});

	var ListGrid_Incoterms = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Incoterms,
		contextMenu: Menu_ListGrid_Incoterms,
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "code",
					title: "<spring:message code='incoterms.code'/>",
					type: 'text',
					required: true,
					width: 400
				},
				{
					name: "works",
					title: "<spring:message code='incoterms.works'/>",
					type: 'checkbox',
					editorType: 'checkbox',
					required: true,
					width: 150
				},
				{
					name: "carrier",
					title: "<spring:message code='incoterms.carrier'/>",
					type: 'checkbox',
					editorType: 'checkbox',
					width: 150
				},
				{
					name: "alongSideShip",
					title: "<spring:message code='incoterms.alongSideShip'/>",
					editorType: 'checkbox',
					type: 'checkbox',
					width: 150
				},
				{
					name: "arrival",
					title: "<spring:message code='incoterms.arrival'/>",
					editorType: 'checkbox',
					type: 'checkbox',
					width: 150
				},
				{
					name: "onBoard",
					title: "<spring:message code='incoterms.onBoard'/>",
					editorType: 'checkbox',
					type: 'checkbox',
					width: 150
				},
				{
					name: "terminal",
					title: "<spring:message code='incoterms.terminal'/>",
					editorType: 'checkbox',
					type: 'checkbox',
					width: 150
				},
				{
					name: "destination",
					title: "<spring:message code='incoterms.destination'/>",
					editorType: 'checkbox',
					type: 'checkbox',
					width: 150
				},
				{
					name: "warehouse",
					title: "<spring:message code='incoterms.warehouse'/>",
					editorType: 'checkbox',
					type: 'checkbox',
					width: 150
				},
				{
					name: "expenses", title: "<spring:message code='incoterms.expenses'/>", valueMap: {
						"1": "<spring:message code='incoterms.works'/>",
						"2": "<spring:message code='incoterms.carrier'/>",
						"3": "<spring:message code='incoterms.alongSideShip'/>",
						"4": "<spring:message code='incoterms.onBoard'/>",
						"5": "<spring:message code='incoterms.arrival'/>",
						"6": "<spring:message code='incoterms.terminal'/>",
						"7": "<spring:message code='incoterms.destination'/>",
						"8": "<spring:message code='incoterms.warehouse'/>"
					}
				},
				{
					name: "namedPlace", title: "<spring:message code='incoterms.namedPlace'/>", valueMap: {
						"1": "<spring:message code='incoterms.works'/>",
						"2": "<spring:message code='incoterms.carrier'/>",
						"3": "<spring:message code='incoterms.alongSideShip'/>",
						"4": "<spring:message code='incoterms.onBoard'/>",
						"5": "<spring:message code='incoterms.arrival'/>",
						"6": "<spring:message code='incoterms.terminal'/>",
						"7": "<spring:message code='incoterms.destination'/>",
						"8": "<spring:message code='incoterms.warehouse'/>"
					}
				},
				{
					name: "namedPort", title: "<spring:message code='incoterms.namedPort'/>", valueMap: {
						"1": "<spring:message code='incoterms.works'/>",
						"2": "<spring:message code='incoterms.carrier'/>",
						"3": "<spring:message code='incoterms.alongSideShip'/>",
						"4": "<spring:message code='incoterms.onBoard'/>",
						"5": "<spring:message code='incoterms.arrival'/>",
						"6": "<spring:message code='incoterms.terminal'/>",
						"7": "<spring:message code='incoterms.destination'/>",
						"8": "<spring:message code='incoterms.warehouse'/>"
					}
				},
			],
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: true,
		showFilterEditor: true,
		filterOnKeypress: true,
		startsWithTitle: "tt"
	});
	var HLayout_Grid_Incoterms_ = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members:
			[
				ListGrid_Incoterms
			]
	});

	var VLayout_Body_incoterms = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members:
			[
				HLayout_Actions_Incoterms_, HLayout_Grid_Incoterms_
			]
	});
