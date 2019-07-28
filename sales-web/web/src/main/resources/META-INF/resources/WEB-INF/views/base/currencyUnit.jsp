<%--
  Created by IntelliJ IDEA.
  User: nooshin
  Date: 01/09/2019
  Time: 9:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	var Menu_ListGrid_CurrencyUnit = isc.Menu.create({
		width: 150,
		data: [

			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
					ListGrid_CurrencyUnit_refresh();
				}
			},
			{
				title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
				click: function () {
					DynamicForm_CurrencyUnit.clearValues();
					Window_CurrencyUnit.show();
				}
			},
			{
				title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
				click: function () {
					ListGrid_CurrencyUnit_edit();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					ListGrid_CurrencyUnit_remove();
				}
			},
			{isSeparator: true},
			{
				title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
				click: function () {
					window.open("/currencyUnit/print/pdf");
				}
			},
			{
				title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
				click: function () {
					window.open("/currencyUnit/print/excel");
				}
			},
			{
				title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
				click: function () {
					window.open("/currencyUnit/print/html");
				}
			}
		]
	});

	var Menu_ListGrid_CurrencyUnit_Print = isc.Menu.create({
		width: 150,
		data: [
			{isSeparator: true},
			{
				title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
				click: function () {
					window.open("/currencyUnit/print/pdf");
				}
			},
			{
				title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
				click: function () {
					window.open("/currencyUnit/print/excel");
				}
			},
			{
				title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
				click: function () {
					window.open("/currencyUnit/print/html");
				}
			}
		]
	});


	var ValuesManager_CurrencyUnit = isc.ValuesManager.create({});
	var DynamicForm_CurrencyUnit = isc.DynamicForm.create({
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
				name: "code", title: "<spring:message code='currency.code'/>", type: 'long', required: true, width: 400,
				validators: [{
					type: "isInteger", validateOnExit: true, stopOnError: true, errorMessage: "<spring:message
		code='global.form.correctType'/>"
				}]
			},
			{
				name: "nameFA",
				title: "<spring:message code='currency.nameFa'/>",
				required: true,
				readonly: true,
				width: 400
			},
			{name: "nameEN", title: "<spring:message code='currency.nameLatin'/>", type: 'text', width: 400
				, keyPressFilter: "[a-z|A-Z|0-9.]"},
			{name: "symbol", title: "<spring:message code='currency.symbol'/>", type: 'text', width: 400},
			{name: "decimalDigit", title: "<spring:message code='currency.decimalDigit'/>", width: 400},
			{type: "RowSpacerItem"},
		]
	});

	var IButton_CurrencyUnit_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			ValuesManager_CurrencyUnit.validate();
			DynamicForm_CurrencyUnit.validate();
			if (DynamicForm_CurrencyUnit.hasErrors()) {
				return;
			}
			var data = DynamicForm_CurrencyUnit.getValues();
			isc.RPCManager.sendRequest({
				actionURL: "rest/currencyUnit/add",
				httpMethod: "POST",
				useSimpleHttp: true,
				contentType: "application/json; charset=utf-8",
				showPrompt: false,
				data: JSON.stringify(data),
				serverOutputAsString: false,
//params: { data:data1},
				callback: function (RpcResponse_o) {
					if (RpcResponse_o.data == 'success') {
						isc.say("<spring:message code='global.form.request.successful'/>");
						ListGrid_CurrencyUnit_refresh();
						Window_CurrencyUnit.close();
					} else {
						isc.say(RpcResponse_o.data);
					}
				}
			});
		}
	});

	var Window_CurrencyUnit = isc.Window.create({
		title: "<spring:message code='currency.title'/>",
		width: 580,
		height: 310,
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
			DynamicForm_CurrencyUnit,
			isc.HLayout.create({
				width: "100%",
				members:
					[
						IButton_CurrencyUnit_Save,
						isc.Label.create({
							width: 5,
						}),
						isc.IButton.create({
							ID: "courseEditExitIButton",
							title: "<spring:message code='global.cancel'/>",
							width: 100,
							icon: "pieces/16/icon_delete.png",
							orientation: "vertical",
							click: function () {
								Window_CurrencyUnit.close();
							}
						})
					]
			})
		]
	});

	function ListGrid_CurrencyUnit_refresh() {
		ListGrid_CurrencyUnit.invalidateCache();
	};

	function ListGrid_CurrencyUnit_remove() {

		var record = ListGrid_CurrencyUnit.getSelectedRecord();

		if (record == null || record.id == null) {
			isc.Dialog.create({
				message: "<spring:message code='global.grid.record.not.selected'/>",
				icon: "[SKIN]ask.png",
				title: "<spring:message code='global.message'/>.",
				buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
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

						var currencyUnitId = record.id;
						isc.RPCManager.sendRequest({
							actionURL: "rest/currencyUnit/remove/" + currencyUnitId,
							httpMethod: "POST",
							useSimpleHttp: true,
							contentType: "application/json; charset=utf-8",
							showPrompt: true,
// data: currencyUnitId,
							serverOutputAsString: false,
							callback: function (RpcResponse_o) {
								if (RpcResponse_o.data == 'success') {
									ListGrid_CurrencyUnit.invalidateCache();
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

	function ListGrid_CurrencyUnit_edit() {

		var record = ListGrid_CurrencyUnit.getSelectedRecord();

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
			DynamicForm_CurrencyUnit.editRecord(record);
			Window_CurrencyUnit.show();
		}
	};


	var ToolStripButton_CurrencyUnit_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_CurrencyUnit_refresh();
		}
	});

	var ToolStripButton_CurrencyUnit_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			DynamicForm_CurrencyUnit.clearValues();
			Window_CurrencyUnit.show();
		}
	});

	var ToolStripButton_CurrencyUnit_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_CurrencyUnit_edit();
		}
	});


	var ToolStripButton_CurrencyUnit_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_CurrencyUnit_remove();
		}
	});

	var ToolStripButton_CurrencyUnit_Filter = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/search.png",
		title: "<spring:message code='global.form.filter'/>",
		click: function () {
//alert('Test');
//ListGrid_CurrencyUnit.showFilterEditor(true);
//ListGrid_CurrencyUnit.filterOnKeypress(true);
//ListGrid_CurrencyUnit.redraw();
		}
	});

	var ToolStrip_Actions_CurrencyUnit = isc.ToolStrip.create({
		width: "100%",
		members: [
			ToolStripButton_CurrencyUnit_Refresh,
			ToolStripButton_CurrencyUnit_Add,
			ToolStripButton_CurrencyUnit_Edit,
			ToolStripButton_CurrencyUnit_Remove,
			ToolStripButton_CurrencyUnit_Filter,
		]
	});

	var HLayout_Actions_CurrencyUnit = isc.HLayout.create({
		width: "100%",
		members: [
			ToolStrip_Actions_CurrencyUnit
		]
	});

	var RestDataSource_CurrencyUnit = isc.RestDataSource.create({
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "code", title: "<spring:message code='currency.code'/> "},
			{name: "nameFA", title: "<spring:message code='currency.nameFa'/> "},
			{name: "nameEN", title: "<spring:message code='currency.nameLatin'/> "},
			{name: "symbol", title: "<spring:message code='currency.symbol'/>"},
			{name: "decimalDigit", title: "<spring:message code='currency.decimalDigit'/>"}
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/currencyUnit/list"
	});

	var ListGrid_CurrencyUnit = isc.MyListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_CurrencyUnit,
		contextMenu: Menu_ListGrid_CurrencyUnit,
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "code", title: "کد واحد ارز", align: "center"},
			{name: "nameFA", title: "نام واحد ارز ", align: "center"},
			{name: "nameEN", title: "نام لاتین واحد ارز", align: "center"},
			{name: "symbol", title: "علامت اختصاری", align: "center"},
			{name: "decimalDigit", title: "تعداد ارقام اعشار", align: "center"},

		],
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: true,
		showFilterEditor: true,
		filterOnKeypress: true,
		startsWithTitle: "tt"
	});


	var HLayout_Grid_CurrencyUnit = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_CurrencyUnit
		]
	});

	var VLayout_Body_CurrencyUnit = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Actions_CurrencyUnit, HLayout_Grid_CurrencyUnit
		]
	});