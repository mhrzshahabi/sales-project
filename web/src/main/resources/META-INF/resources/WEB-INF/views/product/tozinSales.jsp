<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var ViewLoader_createTozinSales = isc.ViewLoader.create({
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
        items:
            [
                ViewLoader_createTozinSales
            ]
    });

    function ListGrid_TozinSales_refresh() {
        ListGrid_TozinSales.invalidateCache();
    }

    var RestDataSource_TozinSales = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "cardId", title: "<spring:message code='Tozin.cardId'/>", align: "center"},
                {name: "carNo1", title: "<spring:message code='Tozin.carNo1'/>", align: "center"},
                {name: "carNo3", title: "<spring:message code='Tozin.carNo3'/>", align: "center"},
                {name: "plak", title: "<spring:message code='Tozin.plak'/>", align: "center"},
                {name: "carName", title: "<spring:message code='Tozin.carName'/>", align: "center"},
                {name: "customer", title: "<spring:message code='Tozin.customer'/>", align: "center"},
                {name: "seller", title: "<spring:message code='Tozin.seller'/>", align: "center"},
                {name: "vazn1", title: "<spring:message code='Tozin.vazn1'/>", align: "center"},
                {name: "vazn2", title: "<spring:message code='Tozin.vazn2'/>", align: "center"},
                {name: "condition", title: "<spring:message code='Tozin.condition'/>", align: "center"},
                {name: "vazn", title: "<spring:message code='Tozin.vazn'/>", align: "center"},
                {name: "tedad", title: "<spring:message code='Tozin.tedad'/>", align: "center"},
                {name: "unitKala", title: "<spring:message code='Tozin.unitKala'/>", align: "center"},
                {name: "packName", title: "<spring:message code='Tozin.packName'/>", align: "center"},
                {name: "haveCode", title: "<spring:message code='Tozin.haveCode'/>", align: "center"},
                {name: "date", title: "<spring:message code='Tozin.date'/>", align: "center"},
                {name: "tozinId", title: "<spring:message code='Tozin.tozinId'/>", align: "center"},
                {name: "tozinDate", title: "<spring:message code='Tozin.tozinDate'/>", align: "center"},
                {name: "tozinTime", title: "<spring:message code='Tozin.tozinTime'/>", align: "center"},
                {name: "codeKala", title: "<spring:message code='Tozin.codeKala'/>", align: "center"},
                {name: "nameKala", title: "<spring:message code='Tozin.nameKala'/>", align: "center"},
                {name: "sourceId", title: "<spring:message code='Tozin.sourceId'/>", align: "center"},
                {name: "source", title: "<spring:message code='Tozin.source'/>", align: "center"},
                {name: "targetId", title: "<spring:message code='Tozin.targetId'/>", align: "center"},
                {name: "target", title: "<spring:message code='Tozin.target'/>", align: "center"},
                {name: "havalehName", title: "<spring:message code='Tozin.havalehName'/>", align: "center"},
                {name: "havalehDate", title: "<spring:message code='Tozin.havalehDate'/>", align: "center"},
                {name: "isFinal", title: "<spring:message code='Tozin.isFinal'/>", align: "center"},
                {name: "targetPlantId",title: "<spring:message code='Tozin.targetPlantId'/>"},
                {name: "sourcePlantId",title: "<spring:message code='Tozin.sourcePlantId'/>"}
            ],
// ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/tozinSales/spec-list"
    });


    var fltTozinSales = isc.FilterBuilder.create({dataSource: RestDataSource_TozinSales});
    var HLayout_TozinSales_labels = isc.HLayout.create({
        width: "100%",
        layoutMargin: 5,
        height: 22,
        showEdges: false,
        members: [
            isc.Label.create({width: 10}),
            isc.IButton.create({
                width: 100,
                height: 22,
                title: "",
                prompt: "<spring:message code='global.search'/>",
                icon: "icon/search.png",
                click: function () {
                    ListGrid_TozinSales.fetchData(fltTozinSales.getCriteria());
                }
            }),
            isc.Label.create({width: "100%"}),
            isc.Label.create({
                contents: "<spring:message code='global.record'/>",
                align: "center",
                width: 50,
                height: 22
            }),
            isc.Label.create({
                ID: "TozinSales_labels_NavigationAz",
                contents: "0",
                border: "1px blue solid",
                align: "center",
                width: 40,
                height: 22
            }),
            isc.Label.create({
                contents: "<spring:message code='global.from'/>",
                align: "center",
                width: 50,
                height: 22
            }),

            isc.Label.create({
                ID: "TozinSales_labels_NavigationTa",
                border: "1px blue solid",
                align: "center",
                contents: "0",
                width: 40,
                height: 22
            })
        ]
    });


    var DynamicForm_DailyReport_TozinSales = isc.DynamicForm.create({
        width: "200",
        wrapItemTitles: false,
        height: "100%",
        setMethod: 'POST',
        align: "center",
        action: "report/printDailyReportBandarAbbas",
        target: "_Blank",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "200",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4,
        fields:
            [
                {
                    name: "toDay",
                    ID: "toDayDate",
                    title: "<spring:message code='dailyWarehouse.toDay'/>",
                    type: 'text',
                    align: "center",
                    width: 150,
                    colSpan: 1,
                    titleColSpan: 1
                    ,
                    icons: [{
                        src: "pieces/pcal.png", click: function () {
                            displayDatePicker('toDayDate', this, 'ymd', '/');
                        }
                    }],
                    defaultValue: "1398/01/26",
                },
            ]
    });

    var Menu_ListGrid_Forosh_Bargiri = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozinSales/print/Forosh_Bargiri/pdf" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                    var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozinSales/print/Forosh_Bargiri/excel" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                    var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozinSales/print/Forosh_Bargiri/html" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            }
        ]
    });

    var Menu_ListGrid_Kharid_Konstantere = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozinSales/print/Kharid_Konstantere/pdf" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                    var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozinSales/print/Kharid_Konstantere/excel" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                    var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozinSales/print/Kharid_Konstantere/html" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            }
        ]
    });

    var Menu_ListGrid_Kharid_Zaieat = isc.Menu.create({
        width: 200,
        data: [
            {
                title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
                click: function () {
                    var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozinSales/print/Kharid_Zaieat/pdf" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
                click: function () {
                    var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozinSales/print/Kharid_Zaieat/excel" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            },
            {
                title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
                click: function () {
                    var toDay = DynamicForm_DailyReport_TozinSales.getValue("toDay").replaceAll("/", "");
                    "<spring:url value="/tozinSales/print/Kharid_Zaieat/html" var="printUrl"/>"
                    window.open('${printUrl}' + '/' + toDay);
                }
            }
        ]
    });

    var MenuButton_Forosh_Bargiri = isc.MenuButton.create({
        ID: "MenuButton_Forosh_Bargiri",
        autoDraw: false,
        title: "<spring:message code='tozin.report.salesUpload'/>",
        prompt: "<spring:message code='tozin.report.salesUpload.byDate'/>",
        width: 150,
        menu: Menu_ListGrid_Forosh_Bargiri
    });

    var MenuButton_Kharid_Konstantere = isc.MenuButton.create({
        ID: "MenuButton_Kharid_Konstantere",
        autoDraw: false,
        title: "<spring:message code='tozin.report.cons.buy'/>",
        prompt: "<spring:message code='tozin.report.cons.buy.byDate'/>",
        width: 150,
        menu: Menu_ListGrid_Kharid_Konstantere
    });

    var MenuButton_Kharid_Zaieat = isc.MenuButton.create({
        ID: "MenuButton_Kharid_Zaieat",
        autoDraw: false,
        title: "<spring:message code='tozin.report.waste'/>",
        prompt: "<spring:message code='tozin.report.waste.byDate'/>",
        width: 200,
        menu: Menu_ListGrid_Kharid_Zaieat
    });

    var DynamicForm_TozinSales = isc.DynamicForm.create({
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
        fields:
            [

                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "cardId", title: "<spring:message code='Tozin.cardId'/>", align: "center"},
                {name: "carNo1", title: "<spring:message code='Tozin.carNo1'/>", align: "center"},
                {name: "carNo3", title: "<spring:message code='Tozin.carNo3'/>", align: "center"},
                {name: "plak", title: "<spring:message code='Tozin.plak'/>", align: "center"},
                {name: "carName", title: "<spring:message code='Tozin.carName'/>", align: "center"},
                {name: "customer", title: "<spring:message code='Tozin.customer'/>", align: "center"},
                {name: "seller", title: "<spring:message code='Tozin.seller'/>", align: "center"},
                {name: "vazn1", title: "<spring:message code='Tozin.vazn1'/>", align: "center"},
                {name: "vazn2", title: "<spring:message code='Tozin.vazn2'/>", align: "center"},
                {name: "condition", title: "<spring:message code='Tozin.condition'/>", align: "center"},
                {name: "vazn", title: "<spring:message code='Tozin.vazn'/>", align: "center"},
                {name: "tedad", title: "<spring:message code='Tozin.tedad'/>", align: "center"},
                {name: "unitKala", title: "<spring:message code='Tozin.unitKala'/>", align: "center"},
                {name: "packName", title: "<spring:message code='Tozin.packName'/>", align: "center"},
                {name: "haveCode", title: "<spring:message code='Tozin.haveCode'/>", align: "center"},
                {name: "date", title: "<spring:message code='Tozin.date'/>", align: "center"},
                {name: "tozinId", title: "<spring:message code='Tozin.tozinId'/>", align: "center"},
                {name: "tozinDate", title: "<spring:message code='Tozin.tozinDate'/>", align: "center"},
                {name: "tozinTime", title: "<spring:message code='Tozin.tozinTime'/>", align: "center"},
                {name: "codeKala", title: "<spring:message code='Tozin.codeKala'/>", align: "center"},
                {name: "nameKala", title: "<spring:message code='Tozin.nameKala'/>", align: "center"},
                {name: "sourceId", title: "<spring:message code='Tozin.sourceId'/>", align: "center"},
                {name: "source", title: "<spring:message code='Tozin.source'/>", align: "center"},
                {name: "targetId", title: "<spring:message code='Tozin.targetId'/>", align: "center"},
                {name: "target", title: "<spring:message code='Tozin.target'/>", align: "center"},
                {name: "havalehName", title: "<spring:message code='Tozin.havalehName'/>", align: "center"},
                {name: "havalehDate", title: "<spring:message code='Tozin.havalehDate'/>", align: "center"},
                {name: "isFinal", title: "<spring:message code='Tozin.isFinal'/>", align: "center"},

            ]
    });

    var ToolStripButton_TozinSales_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_TozinSales_refresh();
        }
    });

    var ToolStripButton_TozinSales_sum = isc.ToolStripButton.create({
        icon: "icon/sigma.png",
        title: "<spring:message code='shipment.total'/>",
        prompt: "<spring:message code='tozin.report.shipment.total'/>",
        click: function () {
            var sum1 = 0;
            var sum2 = 0;
            var selectedAtFirst = ListGrid_TozinSales.getSelection().length;
            if (selectedAtFirst == 0) {
                ListGrid_TozinSales.selectAllRecords();
            }
            var record = ListGrid_TozinSales.getSelection();
            for (var i = 0; i < record.length; i++) {
                var str = record.get(i).condition;
                if (str.startsWith("1")) {
                    sum1 += record.get(i).vazn;
                }
                if (str.startsWith("2")) {
                    sum2 += record.get(i).vazn;
                }
            }
            isc.Dialog.create({
                message: "مجموع برای " + record.length + "  رکورد مقداربارگیری(" + sum1 + ") و تخلیه مقدار (" + sum2 + ") می باشد",
                title: "<spring:message code='shipment.total'/>",
            });
            // isc.ask("جمع تخلیه "+record.length+" رکورد مقدار"+sum+" می باشد");
            if (selectedAtFirst == 0) {
                ListGrid_TozinSales.deselectAllRecords();
            }

        }
    });

    var ToolStrip_Actions_TozinSales = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 10,
        members:
            [
                MenuButton_Forosh_Bargiri,
                MenuButton_Kharid_Konstantere,
                MenuButton_Kharid_Zaieat,
                ToolStripButton_TozinSales_Refresh,
                ToolStripButton_TozinSales_sum,
                DynamicForm_DailyReport_TozinSales
            ]
    });

    var HLayout_TozinSales_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_TozinSales
            ]
    });

    var IButton_TozinSales_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_TozinSales.validate();
            if (DynamicForm_TozinSales.hasErrors())
                return;

            var data = DynamicForm_TozinSales.getValues();
// ######@@@@###&&@@###
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
                    actionURL: "${contextPath}/api/tozinSales/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_TozinSales_refresh();
                            Window_TozinSales.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });
    var IButton_TozinSales_Cancel = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_TozinSales.close();
        }
    });
    var Window_TozinSales = isc.Window.create({
        title: "<spring:message code='warehouses.title'/> ",
        width: 580,
        height: 500,
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
                DynamicForm_TozinSales,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [

                            IButton_TozinSales_Save,
                            isc.Label.create({width: 5,})
                            , IButton_TozinSales_Cancel
                        ]
                })

            ]
    });
    var ListGrid_TozinSales = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_TozinSales,
        // contextMenu: Menu_ListGrid_TozinSales,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                name: "plak",
                title: "<spring:message code='Tozin.plak'/>",
                align: "center",
                showHover: true,
                width: "10%",
                operator: "equals"
            },
            {
                name: "containerId",
                title: "<spring:message code='Tozin.containerId'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "vazn",
                title: "<spring:message code='Tozin.vazn'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "tedad",
                title: "<spring:message code='Tozin.tedad'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "nameKala",
                title: "<spring:message code='Tozin.nameKala'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "source",
                title: "<spring:message code='Tozin.source'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "target",
                title: "<spring:message code='Tozin.target'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "haveCode",
                title: "<spring:message code='Tozin.haveCode'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "packName",
                title: "<spring:message code='Tozin.packName'/>",
                align: "center",
                showHover: true,
                width: "10%"
            },
            {
                name: "tozinPlantId",
                showHover: true,
                width: "10%",
                title: "<spring:message code='Tozin.tozinPlantId'/>"
            },
            {
                name: "tozinDate",
                showHover: true,
                width: "10%",
                title: "<spring:message code='Tozin.tozinDate'/>"
            }
        ],

        allowAdvancedCriteria: true,
        allowFilterExpressions: true,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            TozinSales_labels_NavigationAz.setContents(this.getFocusRow() + 1);
        },
        dataArrived: function (startRow, endRow) {
            TozinSales_labels_NavigationTa.setContents(ListGrid_TozinSales.getData().getLength());
            if (ListGrid_TozinSales.getRecord(0) != null) {
                TozinSales_labels_NavigationAz.setContents(startRow + 1);
            } else
                TozinSales_labels_NavigationAz.setContents("0");
        }

    });

    var VLayout_fltTozinSales = isc.VLayout.create(
        {
            layoutMargin: 10,
            members: [fltTozinSales]
        }
    );


    var VLayout_TozinSales_Grid = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            VLayout_fltTozinSales,
            HLayout_TozinSales_labels,
            ListGrid_TozinSales
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_TozinSales_Actions, VLayout_TozinSales_Grid
        ]
    });