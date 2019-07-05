<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	var RestDataSource_Material = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, hidden: true},
				{name: "code", title: "<spring:message code='goods.code'/> "},
				{name: "descl"},
				{name: "tblUnit.id"},
				{name: "tblUnit.nameEN"},
			],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/material/list"
	});

	function ListGrid_DailyWarehouse_refresh() {
		ListGrid_DailyWarehouse.invalidateCache();
	}

	var RestDataSource_DailyWarehouse = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouseNo'/>", align: "center"},
				{name: "toDay", title: "<spring:message code='dailyWarehouse.toDay'/>", align: "center"},
				{name: "tblMaterial.descl", title: "<spring:message code='goods.nameLatin'/> "},
				{name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", align: "center"},
				{name: "operation", title: "<spring:message code='dailyWarehouse.operation'/>", align: "center"},
				{name: "amount", title: "<spring:message code='global.amount'/>", align: "center"},
				{name: "packingType", title: "<spring:message code='global.packingType'/>", align: "center"},
				{
					name: "packingQuantity",
					title: "<spring:message code='dailyWarehouse.packingQuantity'/>",
					align: "center"
				},
			],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/dailyWarehouse/list"
	});

	function ListGrid_DailyWarehouse_edit() {

		var record = ListGrid_DailyWarehouse.getSelectedRecord();

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
			DynamicForm_DailyWarehouse.editRecord(record);
			Window_DailyWarehouse.show();
		}
	}

	function ListGrid_DailyWarehouse_remove() {

		var record = ListGrid_DailyWarehouse.getSelectedRecord();

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
						var dailyWarehouseId = record.id;
						isc.RPCManager.sendRequest({
							actionURL: "rest/dailyWarehouse/remove/" + dailyWarehouseId,
							httpMethod: "POST",
							useSimpleHttp: true,
							contentType: "application/json; charset=utf-8",
							showPrompt: true,
							serverOutputAsString: false,
							callback: function (RpcResponse_o) {
								if (RpcResponse_o.data == 'success') {
									ListGrid_DailyWarehouse_refresh();
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
	var Menu_ListGrid_DailyWarehouse = isc.Menu.create({
		width: 150,
		data: [
			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
					DynamicForm_DailyWarehouse.clearValues();
					Window_DailyWarehouse.show();
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
					ListGrid_DailyWarehouse_edit();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					ListGrid_DailyWarehouse_remove();
				}
			},
			{isSeparator: true},
			{
				title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
				click: function () {
					window.open("/dailyWarehouse/print/pdf");
				}
			},
			{
				title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
				click: function () {
					window.open("/dailyWarehouse/print/excel");
				}
			},
			{
				title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
				click: function () {
					window.open("/dailyWarehouse/print/html");
				}
			}
		]
	});

	var DynamicForm_DailyWarehouse = isc.DynamicForm.create({
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

				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{
					name: "warehouseNo",
					title: "<spring:message code='dailyWarehouse.warehouseNo'/>",
					align: "center",
					width: 400,
					valueMap: {
						"BandarAbbas": "<spring:message code='global.BandarAbbas'/>",
						"Sarcheshmeh": "<spring:message code='global.Sarcheshmeh'/>",
						"Sungun": "<spring:message code='global.Sungun'/>"
					}
				},
				{name: "toDay", title: "<spring:message code='dailyWarehouse.toDay'/>", align: "center", width: 400},
				{
					name: "tblMaterial.id",
					title: "<spring:message
		code='goods.nameFa'/>",
					type: 'long',
					width: 400,
					editorType: "SelectItem"
					,
					optionDataSource: RestDataSource_Material,
					displayField: "descl"
					,
					valueField: "id",
					pickListWidth: "400",
					pickListheight: "500",
					pickListProperties: {showFilterEditor: true}
					,
					pickListFields: [
						{name: "id", width: 131, align: "center"}
						, {name: "descl", width: 131, align: "center"}
						, {name: "code", width: 131, align: "center"}
					]
				},
				{
					name: "plant",
					title: "<spring:message code='dailyWarehouse.plant'/>",
					align: "center",
					width: 400,
					valueMap: {
						"BandarAbbas": "<spring:message code='global.BandarAbbas'/>",
						"Sarcheshmeh": "<spring:message code='global.Sarcheshmeh'/>",
						"ShahreBabak": "<spring:message code='global.ShahreBabak'/>",
						"Sungun": "<spring:message code='global.Sungun'/>"
					}
				},
				{
					name: "operation",
					title: "<spring:message code='dailyWarehouse.operation'/>",
					align: "center",
					width: 400,
					valueMap: {
						"Receive": "<spring:message code='global.Receive'/>",
						"Issue": "<spring:message code='global.Issue'/>",
						"Revise": "<spring:message code='global.Revise'/>"
					}
				},
				{
					name: "amount", title: "<spring:message
		code='global.amount'/>", align: "center", type: 'float', required: true, width: 400,
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "packingType",
					title: "<spring:message code='global.packingType'/>",
					align: "center",
					width: 400,
					valueMap: {
						"Bandel": "<spring:message code='global.Bandel'/>",
						"Barrel": "<spring:message code='global.Barrel'/>",
						"Container": "<spring:message code='global.Container'/>"
					}
				},
				{
					name: "packingQuantity", title: "<spring:message
		code='global.packingQuantity'/>", align: "center", type: 'long', required: true, width: 400,
					validators: [{
						type: "isInteger",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},

			]
	});

	var ToolStripButton_DailyWarehouse_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_DailyWarehouse_refresh();
		}
	});

	var ToolStripButton_DailyWarehouse_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			DynamicForm_DailyWarehouse.clearValues();
			Window_DailyWarehouse.show();
		}
	});

	var ToolStripButton_DailyWarehouse_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_DailyWarehouse_edit();
		}
	});

	var ToolStripButton_DailyWarehouse_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_DailyWarehouse_remove();
		}
	});

	var ToolStripButton_DailyWarehouse_Print = isc.ToolStripButton.create({
		icon: "[SKIN]/RichTextEditor/print.png",
		title: "<spring:message code='global.form.print'/>",
		click: function () {
			window.open("/dailyWarehouse/print/pdf");
		}
	});

	var ToolStrip_Actions_DailyWarehouse = isc.ToolStrip.create({
		width: "100%",
		members:
			[
				ToolStripButton_DailyWarehouse_Refresh,
				ToolStripButton_DailyWarehouse_Add,
				ToolStripButton_DailyWarehouse_Edit,
				ToolStripButton_DailyWarehouse_Remove,
				ToolStripButton_DailyWarehouse_Print
			]
	});

	var HLayout_DailyWarehouse_Actions = isc.HLayout.create({
		width: "100%",
		members:
			[
				ToolStrip_Actions_DailyWarehouse
			]
	});

	var IButton_DailyWarehouse_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			/*ValuesManager_GoodsUnit.validate();*/
			DynamicForm_DailyWarehouse.validate();
			if (DynamicForm_DailyWarehouse.hasErrors())
				return;

			var data = DynamicForm_DailyWarehouse.getValues();
			isc.RPCManager.sendRequest({
				actionURL: "rest/dailyWarehouse/add",
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
						ListGrid_DailyWarehouse_refresh();
						Window_DailyWarehouse.close();
					} else
						isc.say(RpcResponse_o.data);
				}
			});
		}
	});
	var IButton_DailyWarehouse_Cancel = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.cancel'/>",
		icon: "pieces/16/icon_delete.png",
		click: function () {
			Window_DailyWarehouse.close();
		}
	});
	var Window_DailyWarehouse = isc.Window.create({
		title: "<spring:message code='warehouses.title'/> ",
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
				DynamicForm_DailyWarehouse,
				isc.HLayout.create({
					width: "100%",
					members:
						[

							IButton_DailyWarehouse_Save,
							isc.Label.create({width: 5,})
							, IButton_DailyWarehouse_Cancel
						]
				})

			]
	});
	var ListGrid_DailyWarehouse = isc.ListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_DailyWarehouse,
		contextMenu: Menu_ListGrid_DailyWarehouse,
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouseNo'/>", align: "center"},
				{name: "toDay", title: "<spring:message code='dailyWarehouse.toDay'/>", align: "center"},
				{name: "tblMaterial.descl", title: "<spring:message code='goods.nameLatin'/> "},
				{name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", align: "center"},
				{name: "operation", title: "<spring:message code='dailyWarehouse.operation'/>", align: "center"},
				{name: "amount", title: "<spring:message code='global.amount'/>", align: "center"},
				{name: "packingType", title: "<spring:message code='global.packingType'/>", align: "center"},
				{
					name: "packingQuantity",
					title: "<spring:message code='dailyWarehouse.packingQuantity'/>",
					align: "center"
				},
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
			ListGrid_DailyWarehouseFeature.fetchData({"tblDailyWarehouse.id": record.id}, function (dsResponse, data, dsRequest) {
				ListGrid_DailyWarehouseFeature.setData(data);
			}, {operationId: "00"});
		},
		dataArrived: function (startRow, endRow) {
		}

	});
	var HLayout_DailyWarehouse_Grid = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_DailyWarehouse
		]
	});

	var VLayout_DailyWarehouse_Body = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_DailyWarehouse_Actions, HLayout_DailyWarehouse_Grid
		]
	});

