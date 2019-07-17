<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<% String [][] aa= (String [][]) request.getAttribute("aa"); %>
<%--<script>--%>

    <spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

    var ViewLoader_createContractIncomeCost = isc.ViewLoader.create({
        width: "100%",
        height: "100%",
        autoDraw: false,
        loadingMessage: " در حال بارگذاری ..."
    });
    var Window_ContractIncomeCost_ViewLoader = isc.Window.create({
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
                ViewLoader_createContractIncomeCost
            ]
    });

    function ListGrid_ContractIncomeCost_refresh() {
        ListGrid_ContractIncomeCost.invalidateCache();
    }

    var RestDataSource_ContractIncomeCost = isc.MyRestDataSource.create({
        fields:
            [
{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
<% for(int i=0;i<aa.length;i++) { %>
  {name: "<%=aa[i][1] %>", title: "<%=aa[i][1] %>", align: "center"},
<% } %>
            ],
// ######@@@@###&&@@###
        fetchDataURL: "${restApiUrl}/api/contractIncomeCost/spec-list"
    });

    var fltContractIncomeCost = isc.FilterBuilder.create({dataSource: RestDataSource_ContractIncomeCost});
    var HLayout_ContractIncomeCost_labels = isc.HLayout.create({
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
                prompt: "جستحو",
                icon: "icon/search.png",
                click: function () {
                    ListGrid_ContractIncomeCost.fetchData(fltContractIncomeCost.getCriteria());
                }
            }),
            isc.Label.create({width: "100%"}),
            isc.Label.create({
                contents: "رکورد",
                align: "center",
                width: 50,
                height: 22
            }),
            isc.Label.create({
                ID: "ContractIncomeCost_labels_NavigationAz",
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
                ID: "ContractIncomeCost_labels_NavigationTa",
                border: "1px blue solid",
                align: "center",
                contents: "0",
                width: 40,
                height: 22
            })
        ]
    });


    var DynamicForm_DailyReport_ContractIncomeCost = isc.DynamicForm.create({
        width: "300",
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

	var Menu_ListGrid_ContractIncomeCost = isc.Menu.create({
		width: 150,
		data: [
			{
				title: "<spring:message code='global.form.print.pdf'/>", icon: "icon/pdf.png",
				click: function () {
					var toDay = DynamicForm_DailyReport_ContractIncomeCost.getValue("toDay").replaceAll("/", "");
					"<spring:url value="/contractIncomeCost/print/pdf" var="printUrl"/>"
					window.open('${printUrl}'+'/'+toDay);
				}
			},
			{
				title: "<spring:message code='global.form.print.excel'/>", icon: "icon/excel.png",
				click: function () {
					var toDay = DynamicForm_DailyReport_ContractIncomeCost.getValue("toDay").replaceAll("/", "");
					"<spring:url value="/contractIncomeCost/print/excel" var="printUrl"/>"
					window.open('${printUrl}'+'/'+toDay);
				}
			},
			{
				title: "<spring:message code='global.form.print.html'/>", icon: "icon/html.jpg",
				click: function () {
					var toDay = DynamicForm_DailyReport_ContractIncomeCost.getValue("toDay").replaceAll("/", "");
					"<spring:url value="/contractIncomeCost/print/html" var="printUrl"/>"
					window.open('${printUrl}'+'/'+toDay);
				}
			}
		]
	});

    var MenuButton_ContractIncomeCost = isc.MenuButton.create({
        ID: "MenuButton_ContractIncomeCost",
        autoDraw: false,
        title: "گزارش بین مجامع",
        prompt: "گزارش بین مجامع براساس تاریخ داده شده",
        width: 100,
        menu: Menu_ListGrid_ContractIncomeCost
    });

    function ListGrid_ContractIncomeCost_edit() {

        var record = ListGrid_ContractIncomeCost.getSelectedRecord();

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
            DynamicForm_ContractIncomeCost.editRecord(record);
            Window_ContractIncomeCost.show();
        }
    }

    function ListGrid_ContractIncomeCost_remove() {

        var record = ListGrid_ContractIncomeCost.getSelectedRecord();

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
                buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({
                    title: "<spring:message
		code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var ContractIncomeCostId = record.id;
// ######@@@@###&&@@###
                        var methodXXXX = "PUT";
                        if (data.id == null) methodXXXX = "POST";
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
                                actionURL: "${restApiUrl}/api/contractIncomeCost/" + ContractIncomeCostId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_ContractIncomeCost_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                }
                            })
                        );
                    }
                }
            });
        }
    }

    var DynamicForm_ContractIncomeCost = isc.DynamicForm.create({
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
<% for(int i=0;i<aa.length;i++) { %>
  {name: "<%=aa[i][1] %>", title: "<%=aa[i][1] %>", align: "center"},
<% } %>

            ]
    });

    var ToolStripButton_ContractIncomeCost_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ContractIncomeCost_refresh();
        }
    });


    var ToolStripButton_ContractIncomeCost_sum = isc.ToolStripButton.create({
        icon: "icon/sigma.png",
        title: "مجموع حمل",
        prompt :"بعد از چستجو یا برای رکوردهای انتخاب شده روی صفجه  مجموع بارگیری و تخلیه را نشان می دهد ",
        click: function () {
            var sum1 = 0;
            var sum2 = 0;
            var selectedAtFirst = ListGrid_ContractIncomeCost.getSelection().length;
            if (selectedAtFirst == 0) {
                ListGrid_ContractIncomeCost.selectAllRecords();
            }
            var record = ListGrid_ContractIncomeCost.getSelection();
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
				message: "مجموع برای "+record.length+"  رکورد مقداربارگیری("+sum1+") و تخلیه مقدار ("+sum2+") می باشد",
                title : "مجموع حمل",
                });
            // isc.ask("جمع تخلیه "+record.length+" رکورد مقدار"+sum+" می باشد");
            if (selectedAtFirst == 0) {
                ListGrid_ContractIncomeCost.deselectAllRecords();
            }

        }
    });

    var ToolStripButton_ContractIncomeCost_Print = isc.ToolStripButton.create({
        icon: "[SKIN]/RichTextEditor/print.png",
        title: "<spring:message code='global.form.print'/>",
         prompt: "گزارش بین مجامع براساس تاریخ داده شده",
       click: function () {
					var toDay = DynamicForm_DailyReport_ContractIncomeCost.getValue("toDay").replaceAll("/", "");
					"<spring:url value="/contractIncomeCost/print/pdf" var="printUrl"/>"
					window.open('${printUrl}'+'/'+toDay);
        }
    });

    var ToolStrip_Actions_ContractIncomeCost = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                DynamicForm_DailyReport_ContractIncomeCost, MenuButton_ContractIncomeCost,
                ToolStripButton_ContractIncomeCost_Refresh,
                // ToolStripButton_ContractIncomeCost_Add,
                // ToolStripButton_ContractIncomeCost_Edit,
                // ToolStripButton_ContractIncomeCost_Remove,
                ToolStripButton_ContractIncomeCost_Print,
                // ToolStripButton_ContractIncomeCost_Sarcheshmeh,
                // ToolStripButton_ContractIncomeCost_Miduk,
                // ToolStripButton_ContractIncomeCost_Bandar,
                // ToolStripButton_ContractIncomeCost_Khaton,
                // ToolStripButton_ContractIncomeCost_sungun,
                ToolStripButton_ContractIncomeCost_sum
            ]
    });

    var HLayout_ContractIncomeCost_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_ContractIncomeCost
            ]
    });

    var IButton_ContractIncomeCost_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_ContractIncomeCost.validate();
            if (DynamicForm_ContractIncomeCost.hasErrors())
                return;

            var data = DynamicForm_ContractIncomeCost.getValues();
// ######@@@@###&&@@###
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
                    actionURL: "${restApiUrl}/api/contractIncomeCost/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_ContractIncomeCost_refresh();
                            Window_ContractIncomeCost.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });
    var IButton_ContractIncomeCost_Cancel = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_ContractIncomeCost.close();
        }
    });
    var Window_ContractIncomeCost = isc.Window.create({
        title: "<spring:message code='warehouses.title'/> ",
        width: 580,
        hight: 500,
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
                DynamicForm_ContractIncomeCost,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [

                            IButton_ContractIncomeCost_Save,
                            isc.Label.create({width: 5,})
                            , IButton_ContractIncomeCost_Cancel
                        ]
                })

            ]
    });
    var ListGrid_ContractIncomeCost = isc.MyListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ContractIncomeCost,
        contextMenu: Menu_ListGrid_ContractIncomeCost,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
<% for(int i=0;i<aa.length;i++) { %>
  {name: "<%=aa[i][1] %>", title: "<%=aa[i][1] %>", align: "center"},
<% } %>
        ],
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        allowFilterExpressions: true,
        allowAdvancedCriteria: true,
// filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            ContractIncomeCost_labels_NavigationAz.setContents(this.getFocusRow() + 1);
        },
        dataArrived: function (startRow, endRow) {
            ContractIncomeCost_labels_NavigationTa.setContents(ListGrid_ContractIncomeCost.getData().getLength());
            if (ListGrid_ContractIncomeCost.getRecord(0) != null) {
                ContractIncomeCost_labels_NavigationAz.setContents(startRow + 1);
            } else
                ContractIncomeCost_labels_NavigationAz.setContents("0");
        }

    });

    var VLayout_fltContractIncomeCost = isc.VLayout.create({members: [fltContractIncomeCost]});


    var VLayout_ContractIncomeCost_Grid = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            VLayout_fltContractIncomeCost,
            HLayout_ContractIncomeCost_labels,
            ListGrid_ContractIncomeCost
        ]
    });
    var VLayout_ContractIncomeCost_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_ContractIncomeCost_Actions ,VLayout_ContractIncomeCost_Grid
        ]
    });

