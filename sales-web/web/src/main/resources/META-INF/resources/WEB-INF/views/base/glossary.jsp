<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	<spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

	function ListGrid_Glossary_refresh() {
		ListGrid_Glossary.invalidateCache();
	}

	function ListGrid_Glossary_edit() {
		var record = ListGrid_Glossary.getSelectedRecord();

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
			DynamicForm_Glossary.editRecord(record);
			Window_Glossary.show();
		}
	}

	function ListGrid_Glossary_remove() {

		var record = ListGrid_Glossary.getSelectedRecord();

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
					title: "<spring:message
		code='global.yes'/>"
				}), isc.Button.create({title: "<spring:message code='global.no'/>"})],
				buttonClick: function (button, index) {
					this.hide();
					if (index == 0) {
						var glossaryId = record.id;
// ######@@@@###&&@@###
						isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
								actionURL: "${restApiUrl}/api/glossary/" + glossaryId,
								httpMethod: "DELETE",
								callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
									if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
										ListGrid_Glossary_refresh();
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
	var Menu_ListGrid_Glossary = isc.Menu.create({
		width: 150,
		data: [
			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
					DynamicForm_Glossary.clearValues();
					Window_Glossary.show();
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
					ListGrid_Glossary_edit();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					ListGrid_Glossary_remove();
				}
			}
		]
	});

	var DynamicForm_Glossary = isc.DynamicForm.create({
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
		requiredMessage: "<spring:message code='validator.field.is.required'/>.",
		numCols: 1,
		fields:
			[
				{name: "id", hidden: true,},
				{type: "RowSpacerItem"},
				{name: "summary", title: "<spring:message code='glossary.summary'/>", type: 'text', width: "480"},
				{name: "meaning", title: "<spring:message code='glossary.meaning'/>", type: 'text', width: "480"},
				{type: "RowSpacerItem"}
			]
	});

	var ToolStripButton_Glossary_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_Glossary_refresh();
		}
	});

	var ToolStripButton_Glossary_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			DynamicForm_Glossary.clearValues();
			Window_Glossary.show();
		}
	});

	var ToolStripButton_Glossary_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_Glossary_edit();
		}
	});

	var ToolStripButton_Glossary_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_Glossary_remove();
		}
	});
	var ToolStrip_Actions_Glossary = isc.ToolStrip.create({
		width: "100%",
		members:
			[
				ToolStripButton_Glossary_Refresh,
				ToolStripButton_Glossary_Add,
				ToolStripButton_Glossary_Edit,
				ToolStripButton_Glossary_Remove
			]
	});

	var HLayout_Glossary_Actions = isc.HLayout.create({
		width: "100%",
		members:
			[
				ToolStrip_Actions_Glossary
			]
	});
	var RestDataSource_Glossary = isc.MyRestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "summary", title: "<spring:message code='glossary.summary'/>", width: 200},
				{name: "meaning", title: "<spring:message code='glossary.meaning'/>", width: 200}
			],
// ######@@@@###&&@@###
		fetchDataURL: "${restApiUrl}/api/glossary/spec-list"
	});
	var IButton_Glossary_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			/*ValuesManager_GoodsUnit.validate();*/
			DynamicForm_Glossary.validate();
			if (DynamicForm_Glossary.hasErrors())
				return;

			var data = DynamicForm_Glossary.getValues();
// ######@@@@###&&@@###
			var methodXXXX = "PUT";
			if (data.id == null) methodXXXX = "POST";
			isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
					actionURL: "${restApiUrl}/api/glossary/",
					httpMethod: methodXXXX,
					data: JSON.stringify(data),
					callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
						if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
							isc.say("<spring:message code='global.form.request.successful'/>.");
							ListGrid_Glossary_refresh();
							Window_Glossary.close();
						} else
							isc.say(RpcResponse_o.data);
					}
				})
			);
		}
	});
	var Window_Glossary = isc.Window.create({
		title: "<spring:message code='glossary.title'/> ",
		width: 580,
		hight: 500,
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
				DynamicForm_Glossary,
				isc.HLayout.create({
					width: "100%",
					members:
						[
							IButton_Glossary_Save,
							isc.Label.create({
								width: 5,
							}),
							isc.IButton.create({
								ID: "glossaryEditExitIButton",
								title: "<spring:message code='global.cancel'/>",
								width: 100,
								icon: "pieces/16/icon_delete.png",
								orientation: "vertical",
								click: function () {
									Window_Glossary.close();
								}
							})
						]
				})
			]
	});
	var ListGrid_Glossary = isc.ListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Glossary,
		contextMenu: Menu_ListGrid_Glossary,
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "summary", title: "<spring:message code='glossary.summary'/>", width: "50%", align: "center"},
				{name: "meaning", title: "<spring:message code='glossary.meaning'/>", width: "50%", align: "center"},
			],
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: true,
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
		startsWithTitle: "tt",
		recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
		updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
			var record = this.getSelectedRecord();
			ListGrid_GlossaryFeature.fetchData({
					"glossary.id": record.id
				}, function (dsResponse, data, dsRequest) {
					ListGrid_GlossaryFeature.setData(data);
				},
				{
					operationId: "00"
				}
			)
			;
		},
		dataArrived: function (startRow, endRow) {
		}

	});
	var HLayout_Glossary_Grid = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_Glossary
		]
	});

	var VLayout_Glossary_Body = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Glossary_Actions, HLayout_Glossary_Grid
		]
	});


