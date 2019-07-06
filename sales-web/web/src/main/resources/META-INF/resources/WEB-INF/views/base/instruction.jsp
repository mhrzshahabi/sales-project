<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	<spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

	function ListGrid_Instruction_refresh() {
		ListGrid_Instruction.invalidateCache();
	}

	function ListGrid_Instruction_edit() {
		var record = ListGrid_Instruction.getSelectedRecord();

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
			DynamicForm_Instruction.editRecord(record);
			DynamicForm_Instruction.setValue("disableDateDummy", new Date(record.disableDate));
			DynamicForm_Instruction.setValue("runDate", new Date(record.runDate));
			Window_Instruction.show();
		}
	}

	function ListGrid_Instruction_remove() {

		var record = ListGrid_Instruction.getSelectedRecord();

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
						var InstructionId = record.id;
						isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
							actionURL: "${restApiUrl}/api/instruction/" + InstructionId,
							httpMethod: "DELETE",
							callback: function (RpcResponse_o) {
								if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
									ListGrid_Instruction_refresh();
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
	};
	var Menu_ListGrid_Instruction = isc.Menu.create({
		width: 150,
		data: [
			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
					DynamicForm_Instruction.clearValues();
					Window_Instruction.show();
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
					ListGrid_Instruction_edit();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					ListGrid_Instruction_remove();
				}
			}
		]
	});

	var DynamicForm_Instruction = isc.DynamicForm.create({
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
				{name: "id", hidden: true},
				{type: "RowSpacerItem"},
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "titleInstruction",
					title: "<spring:message code='instruction.titleInstruction'/>",
					width: 400,
					align: "center"
				},
				{
					name: "disableDateDummy",
					title: "<spring:message code='instruction.disableDate'/>",
					width: 400,
					align: "center",
					type: "date"
				},
				{
					name: "runDateDummy",
					title: "<spring:message code='instruction.runDate'/>",
					width: 400,
					align: "center",
					type: "date"
				},
				{type: "RowSpacerItem"}
			]
	});

	isc.ViewLoader.create({
		ID: "InstructionAttachmentViewLoader",
		autoDraw: false,
		loadingMessage: ""
	});
	var ToolStripButton_Instruction_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_Instruction_refresh();
		}
	});

	var ToolStripButton_Instruction_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			DynamicForm_Instruction.clearValues();
			Window_Instruction.show();
		}
	});

	var ToolStripButton_Instruction_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_Instruction_edit();
		}
	});
	var ToolStripButton_Instruction_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_Instruction_remove();
		}
	});

	var ToolStrip_Actions_Instruction = isc.ToolStrip.create({
		width: "100%",
		members:
			[
				ToolStripButton_Instruction_Refresh,
				ToolStripButton_Instruction_Add,
				ToolStripButton_Instruction_Edit,
				ToolStripButton_Instruction_Remove
			]
	});

	var HLayout_Instruction_Actions = isc.HLayout.create({
		width: "100%",
		members:
			[
				ToolStrip_Actions_Instruction
			]
	});

	var RestDataSource_Instruction = isc.MyRestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "titleInstruction", title: "<spring:message code='instruction.titleInstruction'/>", width: 400},
				{name: "disableDate", title: "<spring:message code='instruction.disableDate'/>", width: 400},
				{name: "runDate", title: "<spring:message code='instruction.runDate'/>", width: 400}
			],
		fetchDataURL: "${restApiUrl}/api/instruction/spec-list"
	});

	var IButton_Instruction_Save = isc.IButton.create({
		top: 260,
		layoutMargin: 5,
		membersMargin: 5,
		width: 120,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			DynamicForm_Instruction.validate();
			if (DynamicForm_Instruction.hasErrors())
				return;
			var d = DynamicForm_Instruction.getValue("disableDateDummy");
			var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
			DynamicForm_Instruction.setValue("disableDate", datestring);
			var dRun = DynamicForm_Instruction.getValue("runDateDummy");
			var datestringRun = (dRun.getFullYear() + "/" + ("0" + (dRun.getMonth() + 1)).slice(-2) + "/" + ("0" + dRun.getDate()).slice(-2))
			DynamicForm_Instruction.setValue("runDate", datestringRun);
			var data = DynamicForm_Instruction.getValues();
			var methodXXXX = "PUT";
			if (data.id == null) methodXXXX = "POST";
			isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
					actionURL: "${restApiUrl}/api/instruction/",
					httpMethod: methodXXXX,
					data: JSON.stringify(data),
					callback: function (RpcResponse_o) {
						if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
							isc.say("<spring:message code='global.form.request.successful'/>");
							ListGrid_Instruction_refresh();
							Window_Instruction.close();
						} else
							isc.say(RpcResponse_o.data);
					}
				})
			);
		}
	});

	var InstructionCancelBtn = isc.IButton.create({
		top: 260,
		layoutMargin: 5,
		membersMargin: 5,
		width: 120,
		title: "<spring:message code='global.cancel'/>",
		click: function () {
			Window_Instruction.close();
		}
		});

		var HLayout_Instruction_IButton = isc.HLayout.create({
		layoutMargin: 5,
		membersMargin: 5,
		width: "100%",
		members: [
			IButton_Instruction_Save,
			InstructionCancelBtn
		]
	});

	var Window_Instruction = isc.Window.create({
		title: "<spring:message code='instruction.title'/> ",
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
				DynamicForm_Instruction,
				HLayout_Instruction_IButton
			]
	});

	var ListGrid_Instruction = isc.ListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Instruction,
		contextMenu: Menu_ListGrid_Instruction,
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "titleInstruction",
					title: "<spring:message code='instruction.titleInstruction'/>",
					width: "50%",
					align: "center"
				},
				{
					name: "disableDate",
					title: "<spring:message code='instruction.disableDate'/>",
					width: "20%",
					align: "center"
				},
				{name: "runDate", title: "<spring:message code='instruction.runDate'/>", width: "20%", align: "center"}
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

		},
		dataArrived: function (startRow, endRow) {
		}

	});
	var HLayout_Instruction_Grid = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_Instruction
		]
	});

	var VLayout_Instruction_Body = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Instruction_Actions, HLayout_Instruction_Grid
		]
	});
	isc.HLayout.create({
		width: "100%",
		height: "100%",
		border: "1px solid black",
		layoutTopMargin: 5,
		members: [
			isc.TabSet.create({
				tabBarPosition: "top",
				width: "100%",
				tabs:
					[
						{title: "<spring:message code='instruction.title'/>", pane: VLayout_Instruction_Body}
						, {
						title: "<spring:message code='global.Attachment'/>", pane: InstructionAttachmentViewLoader
						, tabSelected: function (form, item, value) {
							var record = ListGrid_Instruction.getSelectedRecord();
							var dccTableId = record.id;
							var dccTableName = "TBL_INSTRUCTION";
							InstructionAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId)
						}
					}

					]
			})
		]
	});

