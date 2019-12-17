//<script>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_ContractPerson = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contract.contractNo"},
            {name: "person.fullName"},
            {name: "status"}
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
            ListGrid_GroupsPerson
        ]
    });