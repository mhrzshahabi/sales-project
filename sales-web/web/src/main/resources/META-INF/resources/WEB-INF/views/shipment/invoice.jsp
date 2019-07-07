<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	<% DateUtil dateUtil = new DateUtil();%>

	<spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

	var contractId;

	var dollar={};
	isc.RPCManager.sendRequest({
		actionURL: "${restApiUrl}/api/currency/list",
		httpMethod: "GET",
		httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
		useSimpleHttp: true,
		contentType: "application/json; charset=utf-8",
		showPrompt: false,
		data: "",
		serverOutputAsString: false,
		callback: function (RpcResponse_o) {
			if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
				var data=JSON.parse(RpcResponse_o.data);
				for (x of data)  {
					dollar[x.nameEn]=x.nameEn;
					}
				} //if rpc
			} // callback
	});


	var RestDataSource_Shipment_InvoiceHeader = isc.RestDataSource.create({
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
		],
		dataFormat: "json",
		jsonPrefix: "",
		jsonSuffix: "",
// ######@@@@###&&@@###
		transformRequest: function (dsRequest) {
			dsRequest.httpHeaders = {
				"Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
				"Access-Control-Allow-Origin": "${restApiUrl}"
			};
			return this.Super("transformRequest", arguments);
		},
		fetchDataURL: "${restApiUrl}/api/shipment/spec-list"
	});


	var ListGrid_Shipment_InvoiceHeader = isc.ListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Shipment_InvoiceHeader,
		fields: [
			{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
			{name: "contractShipmentId", hidden: true, type: 'long'},
			{name: "contactId", type: 'long', hidden: true},
			{
				name: "contract.contact.nameFA", title: "<spring:message
		code='contact.name'/>", type: 'text', width: "20%", align: "center", showHover: true
			},
			{name: "contractId", type: 'long', hidden: true},
			{
				name: "contract.contractNo", title: "<spring:message
		code='contract.contractNo'/>", type: 'text', width: "10%", showHover: true
			},
			{
				name: "contract.contractDate", title: "<spring:message
		code='contract.contractDate'/>", type: 'text', width: "10%", showHover: true
			},
			{
				name: "materialId",
				title: "<spring:message code='contact.name'/>",
				type: 'long',
				hidden: true,
				showHover: true
			},
			{
				name: "material.descl", title: "<spring:message
		code='material.descl'/>", type: 'text', width: "10%", align: "center", showHover: true
			},
			{
				name: "material.unit.nameEN", title: "<spring:message
		code='unit.nameEN'/>", type: 'text', width: "10%", align: "center", showHover: true
			},
			{
				name: "amount", title: "<spring:message
		code='global.amount'/>", type: 'float', width: "10%", align: "center", showHover: true
			},
			{
				name: "shipmentType", title: "<spring:message
		code='shipment.shipmentType'/>", type: 'text', width: "10%", showHover: true
			},
			{
				name: "loadingLetter", title: "<spring:message
		code='shipment.loadingLetter'/>", type: 'text', width: "10%", showHover: true
			},
			{
				name: "noContainer", title: "<spring:message
		code='shipment.noContainer'/>", type: 'integer', width: "10%", align: "center", showHover: true
			},
			<%--{name: "laycan", title:"<spring:message code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",showHover:true},--%>
			{
				name: "portByLoading.port", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%", showHover: true
			},
			{
				name: "portByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%", showHover: true
			},
// {name: "dischargeAddress", title:"<spring:message
		code='global.address'/>", type:'text', required: true, width: "10%" ,showHover:true},
			{
				name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
			},
			{
				name: "contractShipment.sendDate", title: "<spring:message
		code='global.sendDate'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
			},
			{
				name: "createDate", title: "<spring:message
		code='global.createDate'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
			},
			{
				name: "month", title: "<spring:message
		code='shipment.month'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
			},
			{
				name: "contactByAgent.nameFA", title: "<spring:message
		code='shipment.agent'/>", type: 'text', width: "20%", align: "center", showHover: true
			},
			{
				name: "vesselName", title: "<spring:message
		code='shipment.vesselName'/>", type: 'text', required: true, width: "10%", showHover: true
			},
			{
				name: "swb",
				title: "<spring:message code='shipment.SWB'/>",
				type: 'text',
				required: true,
				width: "10%",
				showHover: true
			},
			{
				name: "switchPort.port", title: "<spring:message
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
			var criteria1 = {
				_constructor: "AdvancedCriteria",
				operator: "and",
				criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
			};
			ListGrid_Invoice.fetchData(criteria1, function (dsResponse, data, dsRequest) {
				ListGrid_Invoice.setData(data);
			});
		},
		dataArrived: function (startRow, endRow) {
		},
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
		startsWithTitle: "tt"
	});
	var HLayout_Grid_Shipment_InvoiceHeader = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_Shipment_InvoiceHeader
		]
	});

	var VLayout_Body_Shipment_InvoiceHeader = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Grid_Shipment_InvoiceHeader
		]
	});
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


	var RestDataSource_Invoice = isc.MyRestDataSource.create({
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "shipmentId", title: "id", canEdit: false, hidden: true},
			],

		fetchDataURL: "${restApiUrl}/api/invoice/spec-list"
	});

	function ListGrid_Invoice_refresh() {
		ListGrid_Invoice.invalidateCache();
		var record = ListGrid_Shipment_InvoiceHeader.getSelectedRecord();
		if (record == null || record.id == null)
			return;
		var criteria1 = {
			_constructor: "AdvancedCriteria",
			operator: "and",
			criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
		};
		ListGrid_Invoice.fetchData(criteria1, function (dsResponse, data, dsRequest) {
			ListGrid_Invoice.setData(data);
		}, {operationId: "00"});
	}

	function ListGrid_Invoice_edit() {
		var record = ListGrid_Invoice.getSelectedRecord();

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
			DynamicForm_Invoice.setValue("invoiceDateDumy", new Date(record.invoiceDate));
			DynamicForm_Invoice.editRecord(record);
			if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Copper Concentrate') {
				DynamicForm_Invoice.getItem("copperUnitPrice").show();
				DynamicForm_Invoice.getItem("copper").show();
				DynamicForm_Invoice.getItem("goldUnitPrice").show();
				DynamicForm_Invoice.getItem("gold").show();
				DynamicForm_Invoice.getItem("silverUnitPrice").show();
				DynamicForm_Invoice.getItem("silver").show();
				DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
				DynamicForm_Invoice.getItem("molybdenum").hide();
			} else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
				DynamicForm_Invoice.getItem("copperUnitPrice").hide();
				DynamicForm_Invoice.getItem("copper").hide();
				DynamicForm_Invoice.getItem("goldUnitPrice").hide();
				DynamicForm_Invoice.getItem("gold").hide();
				DynamicForm_Invoice.getItem("silverUnitPrice").hide();
				DynamicForm_Invoice.getItem("silver").hide();
				DynamicForm_Invoice.getItem("molybdJenumUnitPrice").show();
				DynamicForm_Invoice.getItem("molybdenum").show();
			} else {
				DynamicForm_Invoice.getItem("copperUnitPrice").show();
				DynamicForm_Invoice.getItem("copper").show();
				DynamicForm_Invoice.getItem("goldUnitPrice").hide();
				DynamicForm_Invoice.getItem("gold").hide();
				DynamicForm_Invoice.getItem("silverUnitPrice").hide();
				DynamicForm_Invoice.getItem("silver").hide();
				DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
				DynamicForm_Invoice.getItem("molybdenum").hide();
			}
			Window_Invoice.show();
		}
	}

	function ListGrid_Invoice_remove() {

		var record = ListGrid_Invoice.getSelectedRecord();

		if (record == null || record.id == null) {
			isc.Dialog.create({
				message: "<spring:message code='global.grid.record.not.selected'/> !",
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
						var InvoiceId = record.id;
						isc.RPCManager.sendRequest({
							actionURL: "${restApiUrl}/api/invoice/" + record.id,
							httpMethod: "DELETE",
							useSimpleHttp: true,
							contentType: "application/json; charset=utf-8",
							httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
							showPrompt: true,
							serverOutputAsString: false,
							callback: function (resp) {
								if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
									ListGrid_Invoice_refresh();
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
	var Menu_ListGrid_Invoice = isc.Menu.create({
		width: 150,
		data: [
			{
				title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
				click: function () {
				}
			},
			{
				title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
				click: function () {
					DynamicForm_Invoice.clearValues();
					if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Copper Concentrate') {
						DynamicForm_Invoice.getItem("copperUnitPrice").show();
						DynamicForm_Invoice.getItem("copper").show();
						DynamicForm_Invoice.getItem("goldUnitPrice").show();
						DynamicForm_Invoice.getItem("gold").show();
						DynamicForm_Invoice.getItem("silverUnitPrice").show();
						DynamicForm_Invoice.getItem("silver").show();
						DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
						DynamicForm_Invoice.getItem("molybdenum").hide();
					} else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
						DynamicForm_Invoice.getItem("copperUnitPrice").hide();
						DynamicForm_Invoice.getItem("copper").hide();
						DynamicForm_Invoice.getItem("goldUnitPrice").hide();
						DynamicForm_Invoice.getItem("gold").hide();
						DynamicForm_Invoice.getItem("silverUnitPrice").hide();
						DynamicForm_Invoice.getItem("silver").hide();
						DynamicForm_Invoice.getItem("molybdJenumUnitPrice").show();
						DynamicForm_Invoice.getItem("molybdenum").show();
					} else {
						DynamicForm_Invoice.getItem("copperUnitPrice").show();
						DynamicForm_Invoice.getItem("copper").show();
						DynamicForm_Invoice.getItem("goldUnitPrice").hide();
						DynamicForm_Invoice.getItem("gold").hide();
						DynamicForm_Invoice.getItem("silverUnitPrice").hide();
						DynamicForm_Invoice.getItem("silver").hide();
						DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
						DynamicForm_Invoice.getItem("molybdenum").hide();
					}
					Window_Invoice.show();
				}
			},
			{
				title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
				click: function () {
					if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Copper Concentrate') {
						DynamicForm_Invoice.getItem("copperUnitPrice").show();
						DynamicForm_Invoice.getItem("copper").show();
						DynamicForm_Invoice.getItem("goldUnitPrice").show();
						DynamicForm_Invoice.getItem("gold").show();
						DynamicForm_Invoice.getItem("silverUnitPrice").show();
						DynamicForm_Invoice.getItem("silver").show();
						DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
						DynamicForm_Invoice.getItem("molybdenum").hide();
					} else if (ListGrid_Shipment_InvoiceHeader.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
						DynamicForm_Invoice.getItem("copperUnitPrice").hide();
						DynamicForm_Invoice.getItem("copper").hide();
						DynamicForm_Invoice.getItem("goldUnitPrice").hide();
						DynamicForm_Invoice.getItem("gold").hide();
						DynamicForm_Invoice.getItem("silverUnitPrice").hide();
						DynamicForm_Invoice.getItem("silver").hide();
						DynamicForm_Invoice.getItem("molybdJenumUnitPrice").show();
						DynamicForm_Invoice.getItem("molybdenum").show();
					} else {
						DynamicForm_Invoice.getItem("copperUnitPrice").show();
						DynamicForm_Invoice.getItem("copper").show();
						DynamicForm_Invoice.getItem("goldUnitPrice").hide();
						DynamicForm_Invoice.getItem("gold").hide();
						DynamicForm_Invoice.getItem("silverUnitPrice").hide();
						DynamicForm_Invoice.getItem("silver").hide();
						DynamicForm_Invoice.getItem("molybdJenumUnitPrice").hide();
						DynamicForm_Invoice.getItem("molybdenum").hide();
					}
					ListGrid_Invoice_edit();
				}
			},
			{
				title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
				click: function () {
					ListGrid_Invoice_remove();
				}
			}
		]
	});

	var DynamicForm_Invoice = isc.DynamicForm.create({
		width: "100%",
		height: "100%",
		setMethod: 'POST',
		align: "center",
		canSubmit: true,
		showInlineErrors: true,
		showErrorText: true,
		showErrorStyle: true,
		errorOrientation: "right",
		titleWidth: "100", margin: '10px',
		titleAlign: "right",
		requiredMessage: "<spring:message code='validator.field.is.required'/>.",
		numCols: 4, backgroundImage: "backgrounds/leaves.jpg",
		fields:
			[
				{name: "id", hidden: true,},
				{name: "shipmentId", hidden: true,},
				{
					type: "Header",
					defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
				},
				{
					name: "invoiceType",
					title: "<spring:message
		code='invoice.invoiceType'/>",
					type: 'text',
					width: "100%",
					required: true,
					valueMap: {"PROVISIONAL": "PROVISIONAL", "FINAL": "FINAL", "PREPAID": "PREPAID"}
				},
				{
					name: "paidStatus",
					title: "<spring:message
		code='invoice.paidStatus'/>",
					type: 'text',
					width: "100%",
					defaultValue: "UNPAID",
					valueMap: {"PAID": "PAID", "UNPAID": "UNPAID"}
				},
				{
					type: "Header",
					defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
				},
				{
					name: "invoiceNo", title: "<spring:message
		code='invoice.invoiceNo'/>", required: true, width: "100%", colSpan: 1, titleColSpan: 1
				},
				{
					name: "invoiceDateDumy",
					title: "<spring:message
		code='invoice.invoiceDate'/>",
					defaultValue: "<%=dateUtil.todayDate()%>",
					type: 'date',
					format: 'DD-MM-YYYY HH:mm:ss',
					required: true,
					width: "100%"
				},
				{
					type: "Header",
					defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
				},
				{
					name: "grass",
					title: "<spring:message code='global.grass'/>",
					type: 'float',
					required: true,
					width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "net",
					title: "<spring:message code='global.net'/>",
					type: 'float',
					required: true,
					width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "unitPrice",
					title: "<spring:message code='global.unitPrice'/>",
					type: 'float',
					required: true,
					width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "unitPriceCurrency",
					title: "<spring:message
		code='invoice.unitPriceCurrency'/>",
					type: 'text',
					width: "100%",
					defaultValue: "DOLLAR",
					valueMap: dollar
				},
				{
					name: "paidPercent", title: "<spring:message
		code='invoice.paidPercent'/>", type: 'float', required: true, width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "Depreciation", title: "<spring:message
		code='invoice.Depreciation'/>", type: 'float', required: false, width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "otherCost",
					title: "<spring:message code='invoice.otherCost'/>",
					type: 'float',
					required: false,
					width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "beforePaid",
					title: "<spring:message code='invoice.beforePaid'/>",
					type: 'float',
					required: false,
					width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "invoiceValue", title: "<spring:message
		code='invoice.invoiceValue'/>", type: 'float', required: true, width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "invoiceValueCur",
					title: "<spring:message
		code='invoice.invoiceValueCur'/>",
					type: 'text',
					width: "100%",
					defaultValue: "DOLLAR",
					valueMap: dollar
				},
				{
					type: "Header",
					defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - محتوی - - - - - - - - - - - - - - - - - - - - - - - -"
				},
				{
					name: "copperUnitPrice", title: "<spring:message
		code='invoice.copperUnitPrice'/>", type: 'float', required: false, width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "copper",
					title: "<spring:message code='invoice.copper'/>",
					type: 'float',
					required: false,
					width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "goldUnitPrice", title: "<spring:message
		code='invoice.goldUnitPrice'/>", type: 'float', required: false, width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "gold",
					title: "<spring:message code='invoice.gold'/>",
					type: 'float',
					required: false,
					width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "silverUnitPrice", title: "<spring:message
		code='invoice.silverUnitPrice'/>", type: 'float', required: false, width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "silver",
					title: "<spring:message code='invoice.silver'/>",
					type: 'float',
					required: false,
					width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "molybdJenumUnitPrice", title: "<spring:message
		code='invoice.molybdJenumUnitPrice'/>", type: 'float', required: false, width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},
				{
					name: "molybdenum",
					title: "<spring:message code='invoice.molybdenum'/>",
					type: 'float',
					required: false,
					width: "100%",
					validators: [{
						type: "isFloat",
						validateOnExit: true,
						stopOnError: true,
						errorMessage: "لطفا مقدار عددی وارد نمائید."
					}]
				},

			]
	});

	var ToolStripButton_Invoice_Refresh = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/refresh.png",
		title: "<spring:message code='global.form.refresh'/>",
		click: function () {
			ListGrid_Invoice_refresh();
		}
	});

	var ToolStripButton_Invoice_Add = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/add.png",
		title: "<spring:message code='global.form.new'/>",
		click: function () {
			var record = ListGrid_Shipment_InvoiceHeader.getSelectedRecord();

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
				DynamicForm_Invoice.clearValues();
				DynamicForm_Invoice.setValue("shipmentId", record.id);
				Window_Invoice.show();
			}
		}
	});

	var ToolStripButton_Invoice_Edit = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/edit.png",
		title: "<spring:message code='global.form.edit'/>",
		click: function () {
			ListGrid_Invoice_edit();
		}
	});

	var ToolStripButton_Invoice_Remove = isc.ToolStripButton.create({
		icon: "[SKIN]/actions/remove.png",
		title: "<spring:message code='global.form.remove'/>",
		click: function () {
			ListGrid_Invoice_remove();
		}
	});

	var ToolStrip_Actions_Invoice = isc.ToolStrip.create({
		width: "100%",
		members:
			[
				ToolStripButton_Invoice_Refresh,
				ToolStripButton_Invoice_Add,
				ToolStripButton_Invoice_Edit,
				ToolStripButton_Invoice_Remove
			]
	});

	var HLayout_Invoice_Actions = isc.HLayout.create({
		width: "100%",
		members:
			[
				ToolStrip_Actions_Invoice
			]
	});

	var IButton_Invoice_Save = isc.IButton.create({
		top: 260,
		title: "<spring:message code='global.form.save'/>",
		icon: "pieces/16/save.png",
		click: function () {
			/*ValuesManager_GoodsUnit.validate();*/
			DynamicForm_Invoice.validate();
			if (DynamicForm_Invoice.hasErrors())
				return;
			var drs = DynamicForm_Invoice.getValue("invoiceDateDumy");
			var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
			DynamicForm_Invoice.setValue("invoiceDate", datestringRs);
			DynamicForm_Invoice.setValue("shipmentId", ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id);

			var data = DynamicForm_Invoice.getValues();
			var method = "PUT";
			if (data.id == null)
				method = "POST";
			isc.RPCManager.sendRequest({
				actionURL: "${restApiUrl}/api/invoice/",
				httpMethod: method,
				useSimpleHttp: true,
				contentType: "application/json; charset=utf-8",
				httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
				showPrompt: true,
				serverOutputAsString: false,
				data: JSON.stringify(data),
//params: { data:data1},
				callback: function (resp) {

					if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
						isc.say("<spring:message code='global.form.request.successful'/>.");
						ListGrid_Invoice_refresh();
						Window_Invoice.close();
					} else
						isc.say(RpcResponse_o.data);
				}
			});
		}
	});
	var Window_Invoice = isc.Window.create({
		title: "<spring:message code='issuedInvoices.title'/> ",
		width: 580,
		hight: 500,
		margin: '10px',
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
				DynamicForm_Invoice,
				isc.HLayout.create({
					width: "100%",
					members:
						[
							IButton_Invoice_Save,
							isc.Label.create({
								width: 5,
							}),
							isc.IButton.create({
								ID: "invoiceEditExitIButton",
								title: "<spring:message code='global.cancel'/>",
								width: 100,
								icon: "pieces/16/icon_delete.png",
								orientation: "vertical",
								click: function () {
									Window_Invoice.close();
								}
							})
						]
				})
			]
	});
	var ListGrid_Invoice = isc.ListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_Invoice,
		contextMenu: Menu_ListGrid_Invoice,
		fields:
			[
				{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
				{name: "invoiceNo", title: "<spring:message code='invoice.invoiceNo'/>", width: "10%"},
				{
					name: "invoiceDate",
					title: "<spring:message code='invoice.invoiceDate'/>",
					type: 'text',
					width: "10%"
				},
				{
					name: "invoiceType",
					title: "<spring:message code='invoice.invoiceType'/>",
					type: 'text',
					width: "10%"
				},
				{name: "net", title: "<spring:message code='global.net'/>", type: 'float', width: "10%"},
				{name: "grass", title: "<spring:message code='global.grass'/>", type: 'float', width: "10%"},
				{name: "unitPrice", title: "<spring:message code='global.unitPrice'/>", type: 'float', width: "10%"},
				{
					name: "unitPriceCurrency",
					title: "<spring:message code='invoice.unitPriceCurrency'/>",
					type: 'text',
					width: "10%"
				},
				{
					name: "invoiceValue",
					title: "<spring:message code='invoice.invoiceValue'/>",
					type: 'float',
					width: "10%"
				},
				{
					name: "invoiceValueCur",
					title: "<spring:message code='invoice.invoiceValueCur'/>",
					type: 'text',
					width: "10%"
				},
				{
					name: "paidPercent",
					title: "<spring:message code='invoice.paidPercent'/>",
					type: 'float',
					width: "10%"
				},
				{name: "paidStatus", title: "<spring:message code='invoice.paidStatus'/>", type: 'text', width: "10%"},
				{
					name: "Depreciation",
					title: "<spring:message code='invoice.Depreciation'/>",
					type: 'float',
					width: "10%"
				},
				{name: "otherCost", title: "<spring:message code='invoice.otherCost'/>", type: 'float', width: "10%"},
				{
					name: "copperUnitPrice",
					title: "<spring:message code='invoice.copperUnitPrice'/>",
					type: 'float',
					width: "10%"
				},
				{name: "copper", title: "<spring:message code='invoice.copper'/>", type: 'float', width: "10%"},
				{
					name: "goldUnitPrice",
					title: "<spring:message code='invoice.goldUnitPrice'/>",
					type: 'float',
					width: "10%"
				},
				{name: "gold", title: "<spring:message code='invoice.gold'/>", type: 'float', width: "10%"},
				{
					name: "silverUnitPrice",
					title: "<spring:message code='invoice.silverUnitPrice'/>",
					type: 'float',
					width: "10%"
				},
				{name: "silver", title: "<spring:message code='invoice.silver'/>", type: 'float', width: "10%"},
				{
					name: "molybdJenumUnitPrice", title: "<spring:message
		code='invoice.molybdJenumUnitPrice'/>", type: 'float', width: "10%"
				},
				{name: "molybdenum", title: "<spring:message code='invoice.molybdenum'/>", type: 'float', width: "10%"},
			],
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: false,
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
		},
		dataArrived: function (startRow, endRow) {
		}

	});
	var HLayout_Invoice_Grid = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			ListGrid_Invoice
		]
	});

	var VLayout_Invoice_Body = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			HLayout_Invoice_Actions, HLayout_Invoice_Grid
		]
	});

	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


	isc.SectionStack.create({
		ID: "Shipment_InvoiceHeader_Section_Stack",
		sections:
			[
				{title: "<spring:message code='Shipment.title'/>", items: VLayout_Body_Shipment_InvoiceHeader, expanded: true}
				, {title: "<spring:message code='issuedInvoices.title'/>", items: VLayout_Invoice_Body, expanded: true}
			],
		visibilityMode: "multiple",
		animateSections: true,
		height: "100%",
		width: "100%",
		overflow: "hidden"
	});
