//<script>
    <%@ page contentType="text/html;charset=UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_ContractPerson = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contract.contractNo",title: "<spring:message code='contract.contractNo'/>"},
            {name: "person.title",title: "<spring:message code='person.title'/>"}
        ],
        fetchDataURL: "${contextPath}/api/contractPerson/spec-list"
    });

    var ListGrid_ContractPerson = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ContractPerson,
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
    });

    var HLayout_Grid_ContractPerson = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ContractPerson
        ]
    });

    var ToolStripButton_ContractPerson_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ContractPerson_refresh();
        }
    });

    var ToolStrip_Actions_ContractPerson = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_ContractPerson_Refresh
        ]
    });

    function ListGrid_ContractPerson_refresh() {
        ListGrid_GroupsPerson.invalidateCache();
        ListGrid_GroupsPerson.fetchData(function (dsResponse, data, dsRequest) {
            ListGrid_GroupsPerson.setData(data);
        }, {operationId: "00"});
    }

    var VLayout_Body_ContractPerson = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_ContractPerson, HLayout_Grid_ContractPerson
        ]
    });

    isc.SectionStack.create({
        ID: "ContractPerson_Section_Stack",
        height: "100%",
        width: "100%",
        sections:
            [
                {
                    title: "<spring:message code='contractPerson.title'/>",
                    items: VLayout_Body_ContractPerson,
                    expanded: true
                }
            ]
    });