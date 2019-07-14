<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	function ListGrid_Export_refresh() {
		ListGrid_Export.invalidateCache();
	}

	function ListGrid_Export_edit() {

		var record = ListGrid_Export.getSelectedRecord();

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
			DynamicForm_Export.editRecord(record);
			Window_Export.show();
		}
	}

	function ListGrid_Export_remove() {

		var record = ListGrid_Export.getSelectedRecord();

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
						var exportId = record.id;
						isc.RPCManager.sendRequest({
							actionURL: "rest/export/remove/" + exportId,
							httpMethod: "POST",
							useSimpleHttp: true,
							contentType: "application/json; charset=utf-8",
							showPrompt: true,
							serverOutputAsString: false,
							callback: function (RpcResponse_o) {
								if (RpcResponse_o.data == 'success') {
									ListGrid_Export_refresh();
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
	var Menu_ListGrid_Export = isc.Menu.create({
		width: 150,
		data: [
			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
					DynamicForm_Export.clearValues();
					Window_Export.show();
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
					ListGrid_Export_edit();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					ListGrid_Export_remove();
				}
			},
			{isSeparator: true},
			{
				title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
				click: function () {
					if (typeof (DynamicForm_Export_Year.getValue("year")) != 'undefined') {
						var year = DynamicForm_Export_Year.getValue("year");
						window.open("export/print/pdf/" + year);
					} else
						isc.say("<spring:message code='export.form.validate.year'/>.");
				}
			},
			{
				title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
				click: function () {
					if (typeof (DynamicForm_Export_Year.getValue("year")) != 'undefined') {
						var year = DynamicForm_Export_Year.getValue("year");
						window.open("/export/print/excel/" + year);
					} else
						isc.say("<spring:message code='export.form.validate.year'/>.");
				}
			},
			{
				title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
				click: function () {
					if (typeof (DynamicForm_Export_Year.getValue("year")) != 'undefined') {
						var year = DynamicForm_Export_Year.getValue("year");
						window.open("/export/print/html/" + year);
					} else
						isc.say("<spring:message code='export.form.validate.year'/>.");
				}
			}
		]
	});

	var DynamicForm_Export = isc.DynamicForm.create({
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
					name: "loadingLetterNo",
					title: "<spring:message code='export.loadingLetterNo'/>",
					align: "center",
					width: 400
				},
				{
					name: "loadingLetterDate", ID: "loadingLetterDate", title: "<spring:message
		code='export.loadingLetterDate'/>", type: 'text', align: "center", width: 400
					, icons: [{
						src: "pieces/pcal.png", click: function () {
							displayDatePicker('loadingLetterDate', this, 'ymd', '/');
						}
					}]

					, blur: function () {
						var value = DynamicForm_Export.getItem('loadingLetterDate').getValue();
						if (value != null && value.length != 10 && value != "") {
							DynamicForm_Export.setValue('loadingLetterDate', CorrectDate(value))
						}
					}
				},
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
					pickListWidth: "450",
					pickListheight: "500",
					pickListProperties: {showFilterEditor: true}
					,
					pickListFields: [{
						name: "descl",
						title: "<spring:message code='material.descl'/>",
						width: 200,
						align: "center"
					},
						{name: "descp", title: "<spring:message code='material.descp'/>", width: 200, align: "center"},
						{name: "code", title: "<spring:message code='material.code'/>", width: 50, align: "center"}
					]
				},
				{
					name: "containerQuantity", title: "<spring:message
		code='export.containerQuantity'/>", align: "center", type: 'long', width: 400,
					validators: [{
						type: "isInteger",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{name: "cargo", title: "<spring:message code='export.cargo'/>", align: "center", width: 400},
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
					name: "tblCountry.id",
					title: "<spring:message
		code='global.country'/>",
					type: 'long',
					width: 400,
					editorType: "SelectItem"
					,
					optionDataSource: RestDataSource_Country,
					displayField: "nameFa"
					,
					valueField: "id",
					pickListWidth: "300",
					pickListheight: "500",
					pickListProperties: {showFilterEditor: true}
					,
					pickListFields: [{name: "nameFa", width: 150, align: "center"}, {
						name: "code",
						width: 150,
						align: "center"
					}]
				},

				{
					name: "shipDate", ID: "shipDate", title: "<spring:message
		code='export.shipDate'/>", type: 'text', align: "center", width: 400
					, icons: [{
						src: "pieces/pcal.png", click: function () {
							displayDatePicker('shipDate', this, 'ymd', '/');
						}
					}]

					, blur: function () {
						var value = DynamicForm_Export.getItem('shipDate').getValue();
						if (value != null && value.length != 10 && value != "") {
							DynamicForm_Export.setValue('shipDate', CorrectDate(value))
						}
					}
				}
			]
	});

	var ToolStripButton_Export_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_Export_refresh();
		}
	});

	var ToolStripButton_Export_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			DynamicForm_Export.clearValues();
			Window_Export.show();
		}
	});

	var ToolStripButton_Export_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_Export_edit();
		}
	});

	var ToolStripButton_Export_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_Export_remove();
		}
	});
	var DynamicForm_Export_Year = isc.DynamicForm.create({
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
				{
					type: "text", name: "year"
					, title: "<spring:message code='global.year'/>."
					, valueMap:
						{
							"1390": "1390",
							"1391": "1391",
							"1392": "1392",
							"1393": "1393",
							"1394": "1394",
							"1395": "1395",
							"1396": "1396",
							"1397": "1397"
						}
				}
			]
	});
	var ToolStripButton_Export_Export = isc.ToolStripButton.create({
		icon: "icon/search.png",
		title: "<spring:message code='export.Report.SummaryOfExportFiles'/>",
		click: function () {
			var year = DynamicForm_Export_Year.getValue("year");
			window.open("export/print/excel/" + year);
		}
	});
	var ToolStrip_Actions_Export = isc.ToolStrip.create({
		width: "100%",
		members:
			[
				ToolStripButton_Export_Refresh,
				ToolStripButton_Export_Add,
				ToolStripButton_Export_Edit,
				ToolStripButton_Export_Remove,
				isc.Label.create({
					width: 0,
				}),
				DynamicForm_Export_Year,
				ToolStripButton_Export_Export
			]
	});

	var HLayout_Export_Actions = isc.HLayout.create({
		width: "100%",
		members:
			[
				ToolStrip_Actions_Export
			]
	});
	var RestDataSource_Export = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "loadingLetterNo", title: "<spring:message code='export.loadingLetterNo'/>", align: "center"},
				{name: "loadingLetterDate", title: "<spring:message code='export.loadingLetterNo'/>", align: "center"},
				{name: "tblMaterial.descl", title: "<spring:message code='goods.nameLatin'/> "},
				{
					name: "containerQuantity",
					title: "<spring:message code='export.containerQuantity'/>",
					align: "center"
				},
				{name: "cargo", title: "<spring:message code='export.cargo'/>", align: "center"},
				{name: "amount", title: "<spring:message code='export.loadingLetterNo'/>", align: "center"},
				{name: "tblCountry.nameFa", title: "<spring:message code='global.country'/>", align: "center"},
				{name: "shipDate", title: "<spring:message code='export.shipDate'/>", align: "center"},
			],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/export/list"
	});
	var RestDataSource_Country = isc.RestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, hidden: true},
				{name: "code", title: "<spring:message code='goods.code'/> "},
				{name: "nameFa", title: "<spring:message code='global.country'/> "}
			],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/country/list"
	});
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

	var IButton_Export_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			/*ValuesManager_GoodsUnit.validate();*/
			DynamicForm_Export.validate();
			if (DynamicForm_Export.hasErrors())
				return;

			var data = DynamicForm_Export.getValues();
			isc.RPCManager.sendRequest({
				actionURL: "rest/export/add",
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
						ListGrid_Export_refresh();
						Window_Export.close();
					} else
						isc.say(RpcResponse_o.data);
				}
			});
		}
	});
	var IButton_Export_Cancel = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.cancel'/>",
		icon: "pieces/16/icon_delete.png",
		click: function () {
			Window_Export.close();
		}
	});
	var Window_Export = isc.Window.create({
		title: "<spring:message code='export.title'/> ",
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
				DynamicForm_Export,
				isc.HLayout.create({
					width: "100%",
					members:
						[

							IButton_Export_Save,
							isc.Label.create({width: 5,})
							, IButton_Export_Cancel
						]
				})

			]
	});
	var ListGrid_Export = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Export,
		contextMenu: Menu_ListGrid_Export,
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "loadingLetterNo", title: "<spring:message code='export.loadingLetterNo'/>", align: "center"},
				{
					name: "loadingLetterDate",
					title: "<spring:message code='export.loadingLetterDate'/>",
					align: "center"
				},
				{name: "tblMaterial.descl", title: "<spring:message code='goods.nameLatin'/> "},
				{
					name: "containerQuantity",
					title: "<spring:message code='export.containerQuantity'/>",
					align: "center"
				},
				{name: "cargo", title: "<spring:message code='export.cargo'/>", align: "center"},
				{name: "amount", title: "<spring:message code='global.amount'/>", align: "center"},
				{name: "tblCountry.nameFa", title: "<spring:message code='global.country'/>", align: "center"},
				{name: "shipDate", title: "<spring:message code='export.shipDate'/>", align: "center"},
			],
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: true,
		showFilterEditor: true,
		filterOnKeypress: true,
		startsWithTitle: "tt",
		recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
		updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
		},
		dataArrived: function (startRow, endRow) {
		}
	});
	var HLayout_Export_Grid = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members:
			[
				ListGrid_Export
			]
	});
	var VLayout_Export_Body = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members:
			[
				HLayout_Export_Actions, HLayout_Export_Grid
			]
	});