<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_DccView = isc.MyRestDataSource.create({
        fields: [
            {name: "id", hidden: true, primaryKey: true, canEdit: false},
            {
                name: "documentType",
                title: "<spring:message code='dcc.documentType'/>"
            },
            {
                name: "description",
                title: "<spring:message code='global.description'/>"
            },
            {
                name: "tblId1",
                title: "<spring:message code='dcc.dccViewer.Id'/>"
            },
            {
                name: "tblName1",
                title: "<spring:message code='dcc.dccViewer.TableName'/>"
            },
            {
                name: "fileName",
                title: "<spring:message code='global.fileName'/>"
            }
        ],
        fetchDataURL: "${contextPath}/api/dcc/spec-list"
    });

    var listGrid_DccView = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_DccView,
        autoFetchData: true,
        showFilterEditor: false,
        filterOnKeypress: true,
        fields:
            [
                {name: "id", hidden: true},
                {
                    name: "documentType",
                    title: "<spring:message code='dcc.documentType'/>",
                    type: 'text',
                    required: true,
                    width: "20%",
                    align: "center",
                },
                {
                    name: "description",
                    title: "<spring:message code='global.description'/>",
                    type: 'text',
                    required: true,
                    width: "20%",
                    align: "center"
                },
                {
                    name: "tblId1",
                    title: "<spring:message code='dcc.dccViewer.Id'/>",
                    type: 'long',
                    required: true,
                    width: 200,
                    align: "center"
                },
                {
                    name: "tblName1",
                    title: "<spring:message code='dcc.dccViewer.TableName'/>",
                    type: 'text',
                    required: true,
                    width: "20%",
                    align: "center"
                },
                {
                    name: "fileName",
                    title: "<spring:message code='global.fileName'/>",
                    type: 'text',
                    required: true,
                    width: "20%",
                    align: "center"
                }
            ]
    });

    function ListGrid_DccView_refresh() {
        listGrid_DccView.invalidateCache();
    }

    var ToolStripButton_DccView_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_DccView_refresh();
        }
    });

    var ToolStrip_Actions_DccView = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_DccView_Refresh
                    ]
                })

            ]
    });

    var HLayout_DccView_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_DccView
            ]
    });

    var HLayout_DccView_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            listGrid_DccView
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_DccView_Actions,
            HLayout_DccView_Grid
        ]
    });