<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var ViewLoader_createTozin = isc.ViewLoader.create({
        width: "100%",
        height: "100%",
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>"
    });

    isc.Window.create({
        title: "<spring:message code='dailyReport.DailyReportBandarAbbas'/> ",
        width: "1560",
        height: "95%",
        autoCenter: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            ViewLoader_createTozin
        ]
    });

    function ListGrid_Tozin_refresh() {
        ListGrid_Tozin.invalidateCache();
    }

    var RestDataSource_Tozin = isc.MyRestDataSource.create({
        fields: [
            {
                name: "id",
                title: "id",
                primaryKey: true,
                canEdit: false,
                hidden: true
            },
            {
                name: "source",
                title: "<spring:message code='Tozin.source'/>",
                align: "center"
            },
            {
                name: "tozinId",
                title: "<spring:message code='Tozin.tozinPlantId'/>",
                align: "center"
            },
            {
                name: "nameKala",
                title: "<spring:message code='Tozin.nameKala'/>",
                align: "center"
            },
            {
                name: "codeKala",
                title: "<spring:message code='Tozin.codeKala'/>",
                align: "center"
            },
            {
                name: "target",
                title: "<spring:message code='Tozin.target'/>",
                align: "center"
            },
            {
                name: "cardId",
                title: "<spring:message code='Tozin.cardId'/>",
                align: "center"
            },
            {
                name: "plak",
                title: "<spring:message code='Tozin.plak'/>",
                align: "center"
            },
            {
                name: "carName",
                title: "<spring:message code='Tozin.carName'/>",
                align: "center"
            },
            {
                name: "containerId",
                title: "<spring:message code='Tozin.containerId'/>",
                align: "center"
            },
            {
                name: "containerNo1",
                title: "<spring:message code='Tozin.containerNo1'/>",
                align: "center"
            },
            {
                name: "containerNo3",
                title: "<spring:message code='Tozin.containerNo3'/>",
                align: "center"
            },
            {
                name: "containerName",
                title: "<spring:message code='Tozin.containerName'/>",
                align: "center"
            },
            {
                name: "vazn1",
                title: "<spring:message code='Tozin.vazn1'/>",
                align: "center"
            },
            {
                name: "vazn2",
                title: "<spring:message code='Tozin.vazn2'/>",
                align: "center"
            },
            {
                name: "condition",
                title: "<spring:message code='Tozin.condition'/>",
                align: "center"
            },
            {
                name: "vazn",
                title: "<spring:message code='Tozin.vazn'/>",
                align: "center"
            },
            {
                name: "tedad",
                title: "<spring:message code='Tozin.tedad'/>",
                align: "center"
            },
            {
                name: "unitKala",
                title: "<spring:message code='Tozin.unitKala'/>",
                align: "center"
            },
            {
                name: "packName",
                title: "<spring:message code='Tozin.packName'/>",
                align: "center"
            },
            {
                name: "haveCode",
                title: "<spring:message code='Tozin.haveCode'/>",
                align: "center"
            },
            {
                name: "date",
                title: "<spring:message code='Tozin.date'/>",
                align: "center"
            },
            {
                name: "tozinDate",
                title: "<spring:message code='Tozin.tozinDate'/>",
                align: "center"
            },
            {
                name: "tozinTime",
                title: "<spring:message code='Tozin.tozinTime'/>",
                align: "center"
            },
            {
                name: "sourceId",
                title: "<spring:message code='Tozin.sourceId'/>",
                align: "center"
            },
            {
                name: "targetId",
                title: "<spring:message code='Tozin.targetId'/>",
                align: "center"
            },
            {
                name: "havalehName",
                title: "<spring:message code='Tozin.havalehName'/>",
                align: "center"
            },
            {
                name: "havalehFrom",
                title: "<spring:message code='Tozin.havalehFrom'/>",
                align: "center"
            },
            {
                name: "havalehTo",
                title: "<spring:message code='Tozin.havalehTo'/>",
                align: "center"
            },
            {
                name: "havalehDate",
                title: "<spring:message code='Tozin.havalehDate'/>",
                align: "center"
            },
            {
                name: "carNo1",
                title: "<spring:message code='Tozin.carNo1'/>",
                align: "center"
            },
            {
                name: "carNo3",
                title: "<spring:message code='Tozin.carNo3'/>",
                align: "center"
            },
            {
                name: "isFinal",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            },
            {
                name: "ctrlDescOut",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            },
            {
                name: "tznSharh2",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            }, {
                name: "strSharh2",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            }, {
                name: "tznSharh1",
                title: "<spring:message code='Tozin.isFinal'/>",
                align: "center"
            }
        ],
        fetchDataURL: "${contextPath}/api/tozin/spec-list"
    });

    var HLayout_Tozin_labels = isc.HLayout.create({
        width: "100%",
        layoutMargin: 5,
        height: 22,
        showEdges: false,
        members: [
            isc.Label.create({
                width: 10
            }),
            isc.Label.create({
                width: "100%"
            }),
            isc.Label.create({
                contents: "<spring:message code='global.record'/>",
                align: "center",
                width: 50,
                height: 22
            }),
            isc.Label.create({
                ID: "Tozin_labels_NavigationAz",
                contents: "0",
                border: "1px blue solid",
                align: "center",
                width: 40,
                height: 22
            }),
            isc.Label.create({
                contents: "از",
                align: "center",
                width: 50,
                height: 22
            }),

            isc.Label.create({
                ID: "Tozin_labels_NavigationTa",
                border: "1px blue solid",
                align: "center",
                contents: "0",
                width: 40,
                height: 22
            })
        ]
    });

    var DynamicForm_DailyReport_Tozin = isc.DynamicForm.create({
        width: "200",
        wrapItemTitles: false,
        height: "100%",
        action: "report/printDailyReportBandarAbbas",
        target: "_Blank",
        titleWidth: "200",
        numCols: 4,
        fields: [{
            name: "toDay",
            ID: "toDayDate",
            title: "<spring:message code='dailyWarehouse.toDay'/>",
            type: 'text',
            align: "center",
            width: 150,
            colSpan: 1,
            titleColSpan: 1,
            icons: [{
                src: "pieces/pcal.png",
                click: function () {
                    displayDatePicker('toDayDate', this, 'ymd', '/');
                }
            }],
            defaultValue: "1398/01/26",
        },]
    });

    var Menu_ListGrid_Tozin = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozin/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozin/print/excel" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozin/print/html" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            }
        ]
    });

    <sec:authorize access="hasAuthority('O_TOZIN')">
    var MenuButton_Tozin = isc.MenuButton.create({
        ID: "MenuButton_Tozin",
        autoDraw: false,
        title: "<spring:message code='tozin.report.betweenComplexes'/>",
        prompt: "<spring:message code='tozin.report.betweenComplexes.date'/>",
        width: 125,
        menu: Menu_ListGrid_Tozin
    });
    </sec:authorize>

    var ToolStripButton_Tozin_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Tozin_refresh();
        }
    });

    var ToolStrip_Actions_Tozin = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 10,
        members:
            [
                <sec:authorize access="hasAuthority('O_TOZIN')">
                MenuButton_Tozin,
                </sec:authorize>
                DynamicForm_DailyReport_Tozin,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_Tozin_Refresh
                    ]
                })
            ]
    });

    var HLayout_Tozin_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Tozin
            ]
    });

    var ListGrid_Tozin = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Tozin,
        fields: [
            {
                name: "id",
                title: "id",
                primaryKey: true,
                canEdit: false,
                hidden: true
            },
            {
                name: "plak",
                title: "<spring:message code='Tozin.plak'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "containerId",
                title: "<spring:message code='Tozin.containerId'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "vazn",
                title: "<spring:message code='Tozin.vazn'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "nameKala",
                title: "<spring:message code='Tozin.nameKala'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "source",
                title: "<spring:message code='Tozin.source'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "target",
                title: "<spring:message code='Tozin.target'/>",
                align: "center",
                width: "10%"
            },
            {
                name: "tozinId",
                title: "<spring:message code='Tozin.tozinPlantId'/>",
                width: "10%",
            },
            {
                name: "tozinDate",
                title: "<spring:message code='Tozin.tozinDate'/>",
                width: "10%",
            }
        ],
        autoFetchData: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            Tozin_labels_NavigationAz.setContents(this.getFocusRow() + 1);
        },
        dataArrived: function (startRow, endRow) {
            Tozin_labels_NavigationTa.setContents(ListGrid_Tozin.getData().getLength());
            if (ListGrid_Tozin.getRecord(0) != null) {
                Tozin_labels_NavigationAz.setContents(startRow + 1);
            } else
                Tozin_labels_NavigationAz.setContents("0");
        }

    });

    var VLayout_conc = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Tozin_labels,
            ListGrid_Tozin
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Tozin_Actions, VLayout_conc
        ]
    });