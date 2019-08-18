<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    var departmentDS = isc.MyRestDataSource.create({
        fields: [
            {name: "id", primaryKey: true, type: "integer", title: " ID"},
            {name: "departmentName", title: "<spring:message code='department.name'/>"},
            {name: "departmentNameLatin", title: "<spring:message code='department.LatinName'/>"},
            {name: "parentId", foreignKey: "id", type: "integer", title: "parent department"},
            {name: "departmentCode", title: "<spring:message code='department.code'/>"}
        ],
        fetchDataURL: "rest/department/departmentListFetch"
    });

    var departmentTreeGrid = isc.TreeGrid.create({
        dataSource: departmentDS,
        autoFetchData: true,
        width: "98%",
        height: "90%",
        loadDataOnDemand: true,
        border: "0px solid green",
        dataFetchMode: "paged",
        showConnectors: true,
        fields: [

            {name: "departmentName"}
        ]
    });


    isc.VLayout.create({
        width: "100%",
        height: "100%",
        border: "1px solid green",
        layoutMargin: 5,
        members: [
            departmentTreeGrid
        ]
    });

