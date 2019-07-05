<%--
  Created by IntelliJ IDEA.
  User: nooshin
  Date: 01/12/2019
  Time: 9:48 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	var departmentDS = isc.RestDataSource.create({
		fields: [
			{name: "id", primaryKey: true, type: "integer", title: " ID"},
			{name: "departmentName", title: "<spring:message code='department.name'/>"},
			{name: "departmentNameLatin", title: "<spring:message code='department.LatinName'/>"},
			{name: "parentId", foreignKey: "id", type: "integer", title: "parent department"},
			{name: "departmentCode", title: "<spring:message code='department.code'/>"}
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/department/departmentListFetch"
	});

	var departmaneGridDS = isc.RestDataSource.create({
		fields: [
			{name: "id", primaryKey: true, type: "integer", title: " ID"},
			{name: "departmentName", title: "<spring:message code='department.name'/>"},
			{name: "parentId", foreignKey: "id", type: "integer", title: "parent department"},
			{name: "parentDepartment.id"},
			{name: "parentDepartment.departmentName"},
			{name: "parentDepartment.parentDepartment.id"},
			{name: "departmentCode", title: "<spring:message code='department.code'/>"}
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
		fetchDataURL: "rest/department/departmentGridFetch"
	});


	var departmentGridHeaderForm = isc.DynamicForm.create({
		titleWidth: "200",
		width: "100%",
		numCols: 10,
		fields: [
			{name: "id", type: "hidden", title: ""},
			{name: "parentCode", type: "staticText", title: "<spring:message code='department.code.head'/>"},
			{
				name: "parentName",
				type: "staticText",
				title: "<spring:message code='department.name.head'/>",
				colSpan: 3
			},
			{name: "parentNameLatin", type: "staticText", title: "<spring:message code='department.latinName.head'/>"},

		]
	});

	var departmentCode_vm = isc.ValuesManager.create({});

	var departmentCodeMainInfoForm = isc.DynamicForm.create({
		valuesManager: departmentCode_vm,
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
			{
				name: "parentDepartment.departmentCode", type: "StaticText", title: "<spring:message
		code='department.code.head'/>", width: 400
			},
			{
				name: "parentDepartment.departmentName", type: "StaticText", title: "<spring:message
		code='department.name.head'/>", width: 400
			},
			{
				name: "departmentCode", type: "IntegerItem", title: "<spring:message
		code='department.code'/> ", required: true, keyPressFilter: "[0-9]", width: 400
			},
			{
				name: "departmentName", type: "text", title: "<spring:message
		code='department.name'/>", width: "100%", required: true, lenght: "255", width: 400
			},
			{
				name: "departmentNameLatin",
				type: "text",
				title: "<spring:message code='department.LatinName'/>",
				width: 400,
				lenght: "255"
			},
		]
	});

	function saveDepartment() {
		departmentCode_vm.validate();
		if (departmentCodeMainInfoForm.hasErrors())
			isc.say("<spring:message code='department.warning.message'/>");
		else {
			var departmentCodeData = Object.assign(departmentCodeMainInfoForm.getValues());
			isc.RPCManager.sendRequest({
				actionURL: "rest/department/add",
				httpMethod: "POST",
				useSimpleHttp: true,
				contentType: "application/json; charset=utf-8",
				showPrompt: false,
				data: JSON.stringify(departmentCodeData),
				serverOutputAsString: false,
				callback: function (RpcResponse_o) {
					if (RpcResponse_o.data == 'success') {
						departmentListGrid.invalidateCache();
						isc.say("<spring:message code='global.form.request.successful'/>");
						departmentCodeWindow.close();
					} else
						isc.say(RpcResponse_o.data);
				}
			});
		}
	}

	var departmentCodeSaveBtn = isc.Button.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		click: function () {
			saveDepartment();
		}
	});
	var departmentCodeCancelBtn = isc.Button.create({
		top: 260,
		title: "<spring:message code='global.cancel'/>",
		click: function () {
			departmentCodeWindow.close();
		}
	});

	var departmentCodeFormButtonLayout = isc.HLayout.create({
		width: "100%",
		height: "20",
		layoutMargin: 5,
		membersMargin: 5,
		autoDraw: false,
		isModal: true,
		showModalMask: true,
		members: [
			departmentCodeSaveBtn,
			departmentCodeCancelBtn

		]
	});

	var departmentCodeWindow = isc.Window.create({
		title: "<spring:message code='department.compilation.window'/>",
		width: 580,
		hight: 500,
		autoSize: true,
		autoCenter: true,
		isModal: true,
		showModalMask: true,
		autoDraw: false,
		dismissOnEscape: true,
		closeClick: function () {
			this.Super("closeClick", arguments)
		},
		items: [
			departmentCodeMainInfoForm,
			departmentCodeFormButtonLayout
		]
	});


	var departmentListGridContextMenu = isc.Menu.create({
		width: 150,
		data: [

			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
					departmentGridRefreshButton.click();
				}
			},
			{
				title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
				click: function () {
					departmentGridAddButton.click();
				}
			},
			{
				title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
				click: function () {
					departmentGridEditButton.click();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					departmentGridRemoveButton.click();
				}
			},
			{
				title: "<spring:message code='global.form.print'/>", icon: "/static/img/icon/print.png",
				click: function () {
					window.open("/department/print/pdf");
				}
			},
			{isSeparator: true},
			{
				title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
				click: function () {
					window.open("/department/print/pdf");
				}
			},
			{
				title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
				click: function () {
					window.open("/department/print/excel");
				}
			},
			{
				title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
				click: function () {
					window.open("/department/print/html");
				}
			}
		]
	});


	var departmentGridPrintButton = isc.ToolStripButton.create({
		icon: "pieces/16/refresh.png",
		title: "<spring:message code='global.form.print'/>",
		click: function () {
			window.open("/department/print/pdf");
		}
	});

	var departmentGridRefreshButton = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			departmentListGrid.fetchData({"parentId": departmentGridHeaderForm.getValue("id")});
		}
	});

	var departmentGridAddButton = isc.ToolStripButton.create({
		icon: "pieces/16/icon_add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			clearDepartmentCodeForms();
			setParentCodeInfo();
			departmentCodeWindow.show();

		}
	});

	var departmentGridEditButton = isc.ToolStripButton.create({
		icon: "pieces/16/icon_edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			var record = departmentListGrid.getSelectedRecord();
			if (record == null || record.id == null) {
				isc.warn("<spring:message code='global.grid.record.not.selected'/>", null, {title: "<spring:message code='global.message'/>"});

			} else {
				clearDepartmentCodeForms();
				departmentCodeMainInfoForm.editRecord(record);
				setParentCodeInfo();
				departmentCodeWindow.show();
			}
		}
	})

	var departmentGridRemoveButton = isc.ToolStripButton.create({
		icon: "pieces/16/icon_delete.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			var record = departmentListGrid.getSelectedRecord();

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
		code='global.ok'/>"
					}), isc.Button.create({title: "<spring:message code='global.cancel'/>"})],
					buttonClick: function (button, index) {
						this.hide();
						if (index == 0) {
							var departmentId = record.id;
							isc.RPCManager.sendRequest({
								actionURL: "rest/department/remove/" + departmentId,
								httpMethod: "POST",
								useSimpleHttp: true,
								contentType: "application/json; charset=utf-8",
								showPrompt: true,
								serverOutputAsString: false,
								callback: function (RpcResponse_o) {
									if (RpcResponse_o.data == 'success') {
										departmentListGrid.invalidateCache();
										isc.say("<spring:message code='global.grid.record.remove.success'/>");
									} else {
										isc.say("<spring:message code='global.grid.record.remove.failed'/>");
									}
								}
							});
						}
					}
				});
			}
		}
	});


	var departmentGridToolStrip = isc.ToolStrip.create({
		width: "90%",
		members: [
			departmentGridRefreshButton,
			departmentGridAddButton,
			departmentGridEditButton,
			departmentGridRemoveButton,
			departmentGridPrintButton
		]
	});


	var departmentGridButtonHLayout = isc.HLayout.create({
		width: "100%",
		height: 50,
		border: "0px solid yellow",
		layoutMargin: 5,
		members: [
			departmentGridToolStrip
		]
	});

	var departmentTreeGrid = isc.TreeGrid.create({
		dataSource: departmentDS,
		autoFetchData: true,
		width: "98%",
		height: "90%",
		dataPageSize: 50,
		loadDataOnDemand: true,
		border: "0px solid green",
		dataFetchMode: "paged",
		showConnectors: true,
		rowClick: function (record, recordNum, fieldNum) {
			departmentListGrid.fetchData({parentId: record.id});
			setDepartmentListGridHeaderFormData(record);

		},
		fields: [

			{name: "departmentName"}
		]
	});

	function setDepartmentListGridHeaderFormData(record) {
		departmentGridHeaderForm.setValue("id", record.id);
		departmentGridHeaderForm.setValue("parentCode", record.departmentCode);
		departmentGridHeaderForm.setValue("parentName", record.departmentName);
		departmentGridHeaderForm.setValue("parentNameLatin", record.departmentNameLatin);

	}

	var departmentListGrid = isc.ListGrid.create({
		width: "100%",
		height: "90%",
		paddingAsLayoutMargin: 5,
		alternateRecordStyles: true,
		autoFetchData: false,
		dataSource: departmaneGridDS,
		showFilterEditor: true,
		contextMenu: departmentListGridContextMenu,
		fields: [
			{name: "departmentCode", title: "<spring:message code='department.code'/>", width: "20%"},
			{name: "departmentName", width: "50%", title: "<spring:message code='department.name'/>"},
			{name: "departmentNameLatin", width: "30%", title: "<spring:message code='department.LatinName'/>"}
		],
		canReorderFields: true
	});


	var departmentTreePrintButton = isc.ToolStripButton.create({
		icon: "[SKIN]/RichTextEditor/print.png",
		title: "<spring:message code='global.form.print'/>",
		click: function () {
// var paramData = {
// pParentId:(departmentTreeGrid.getSelectedRecord().id).toString()
// }
// isc.RPCManager.sendRequest({
// actionURL: "rest/department/departmentMaxCode", //مقدار max تعریف نشده است هنوز
// httpMethod: "POST",
// useSimpleHttp: true,
// contentType: "application/json; charset=utf-8",
// showPrompt:false,
// data: JSON.stringify(paramData),
// serverOutputAsString: false,
// callback: function (RpcResponse_o) {
// isc.say(RpcResponse_o.data);
//
// }
// });

			window.open("/department/print/pdf");
		}
	});

	var departmentTreeToolStrip = isc.ToolStrip.create({
		width: "90%",
		members: [
			departmentTreePrintButton
		]
	});

	var departmentTreeButtonHLayout = isc.HLayout.create({
		width: "100%",
		height: 50,
		border: "0px solid yellow",
		layoutMargin: 5,
		members: [
			departmentTreeToolStrip
		]
	});


	var departmentTreeVLayout = isc.VLayout.create({
		width: "40%",
		height: "100%",
		border: "1px solid green",
		layoutMargin: 5,
		members: [
			departmentTreeButtonHLayout,
			departmentTreeGrid
		]
	});


	function setParentCodeInfo() {
		departmentCodeMainInfoForm.setValue("parentDepartment.id", departmentGridHeaderForm.getValue("id"));
		departmentCodeMainInfoForm.setValue("parentDepartment.departmentCode", departmentGridHeaderForm.getValue("parentCode"));
		departmentCodeMainInfoForm.setValue("parentDepartment.departmentName", departmentGridHeaderForm.getValue("parentName"));
	}

	function clearDepartmentCodeForms() {
		departmentCodeMainInfoForm.clearValues();

	}

	var departmentGridHeaderHLayout = isc.HLayout.create({
		width: "100%",
		height: 25,
		border: "0px solid yellow",
		layoutMargin: 5,
		members: [
			departmentGridHeaderForm
		]
	});


	var departmentGridVLayout = isc.VLayout.create({
		width: "60%",
		height: "100%",
		border: "0px solid green",
		layoutMargin: 5,
		members: [
			departmentGridHeaderHLayout,
			departmentGridButtonHLayout,
			departmentListGrid

		]
	});

	var departmentBodyHLayout = isc.HLayout.create({
		width: "100%",
		height: "100%",
		border: "1px solid blue",
		layoutMargin: 0,
		members: [
			departmentTreeVLayout,
			departmentGridVLayout
		]
	});


	var departmentVLayout = isc.VLayout.create({
		width: "100%",
		height: "100%",
		border: "1px solid green",
		layoutMargin: 0,
		members: [
			departmentBodyHLayout
		]
	});
