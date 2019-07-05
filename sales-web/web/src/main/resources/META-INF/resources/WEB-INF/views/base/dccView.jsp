<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

	<spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

	<%----------------------------------------------------------ATTACH----------------------------------------------------%>

	var RestDataSource_DccView = isc.MyRestDataSource.create({
		fields: [
			{name: "id", hidden: true, primaryKey: true, canEdit: false},
			{
				name: "createDate",
				title: "<spring:message code='global.createDate'/> ",
				type: 'text',
				required: true,
				width: 400
			},
			{
				name: "documentType",
				title: "<spring:message code='dcc.documentType'/>",
				type: 'text',
				required: true,
				width: 400,
				align: "center",
				valueMap: {
					"letter": "<spring:message code='dcc.letter'/>"
				}
			},
			{
				name: "description",
				title: "<spring:message code='global.description'/>",
				type: 'text',
				required: true,
				width: 200,
				align: "center"
			},
			{
				name: "contractNo",
				title: "<spring:message code='dcc.contractNo'/>",
				type: 'text',
				required: true,
				width: 200,
				align: "center"
			},
			{
				name: "contactNameFa",
				title: "<spring:message code='dcc.contactNameFa'/>",
				type: 'text',
				required: true,
				width: 200,
				align: "center"
			},
			{
				name: "fileName",
				title: "<spring:message code='global.fileName'/>",
				type: 'text',
				required: true,
				width: 200,
				align: "center"
			},
			{
				name: "fileNewName",
				title: "<spring:message code='global.fileNewName'/>",
				type: 'text',
				width: 200,
				align: "center"
			}
		],
// ######@@@@###&&@@###
		fetchDataURL: "${restApiUrl}/api/dcc/spec-list"
	});

	var listGrid_DccView = isc.ListGrid.create({
		width: "100%",
		height: "100%",
		dataSource: RestDataSource_DccView,
		sortField: 0,
		dataPageSize: 50,
		autoFetchData: false,
		showFilterEditor: false,
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
		fields:
			[
				{
					name: "fileName",
					title: "<spring:message code='global.fileName'/>",
					type: 'text',
					required: true,
					width: 400,
					align: "center"
				},
				{
					name: "contractNo",
					title: "<spring:message code='dcc.contractNo'/>",
					type: 'text',
					width: 365,
					align: "center"
				},
				{
					name: "contactNameFa",
					title: "<spring:message code='dcc.contactNameFa'/>",
					type: 'text',
					width: 400,
					align: "center"
				},
				{
					name: "description",
					title: "<spring:message code='global.description'/>",
					type: 'text',
					width: 400,
					align: "center"
				},
				{name: "id", hidden: true,},
				{name: "contactId", type: "long", hidden: true}
			],
		cellClick: function (record, rowNum, colNum) {
			if (colNum == 0)
				if (record.contractNo != null)
					window.open("dccView/downloadFile?data=" + "\\" + "contract\\" + record.fileNewName);
				else if (record.contactNameFa != null)
					window.open("dccView/downloadFile?data=" + "\\" + "contact\\" + record.fileNewName);
		}
	});

	listGrid_DccView.fetchData(
		{},
		function (dsResponse, data, dsRequest) {
			listGrid_DccView.setData(data);
		},
		{operationId: "00"}
	);

	var DccViewGridHLayout = isc.HLayout.create({
		width: "100%",
		height: "100%",
		members: [
			listGrid_DccView
		]
	});

	var dccViewBodyVLayout = isc.VLayout.create({
		width: "100%",
		height: "100%",
		members: [
			DccViewGridHLayout
		]
	});

	<%-----------------------------------------------END ATTACH-----------------------------------------------------------%>
