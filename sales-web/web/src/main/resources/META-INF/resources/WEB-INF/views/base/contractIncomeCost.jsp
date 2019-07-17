<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

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
                {name: "cardId", title: "<spring:message code='ContractIncomeCost.cardId'/>", align: "center"},
                {name: "carNo1", title: "<spring:message code='ContractIncomeCost.carNo1'/>", align: "center"},
                {name: "carNo3", title: "<spring:message code='ContractIncomeCost.carNo3'/>", align: "center"},
                {name: "plak", title: "<spring:message code='ContractIncomeCost.plak'/>", align: "center"},
                {name: "carName", title: "<spring:message code='ContractIncomeCost.carName'/>", align: "center"},
                {name: "containerId", title: "<spring:message code='ContractIncomeCost.containerId'/>", align: "center"},
                {name: "containerNo1", title: "<spring:message code='ContractIncomeCost.containerNo1'/>", align: "center"},
                {name: "containerNo3", title: "<spring:message code='ContractIncomeCost.containerNo3'/>", align: "center"},
                {name: "containerName", title: "<spring:message code='ContractIncomeCost.containerName'/>", align: "center"},
                {name: "vazn1", title: "<spring:message code='ContractIncomeCost.vazn1'/>", align: "center"},
                {name: "vazn2", title: "<spring:message code='ContractIncomeCost.vazn2'/>", align: "center"},
                {name: "condition", title: "<spring:message code='ContractIncomeCost.condition'/>", align: "center"},
                {name: "vazn", title: "<spring:message code='ContractIncomeCost.vazn'/>", align: "center"},
                {name: "tedad", title: "<spring:message code='ContractIncomeCost.tedad'/>", align: "center"},
                {name: "unitKala", title: "<spring:message code='ContractIncomeCost.unitKala'/>", align: "center"},
                {name: "packName", title: "<spring:message code='ContractIncomeCost.packName'/>", align: "center"},
                {name: "haveCode", title: "<spring:message code='ContractIncomeCost.haveCode'/>", align: "center"},
                {name: "date", title: "<spring:message code='ContractIncomeCost.date'/>", align: "center"},
                {name: "contractIncomeCostId", title: "<spring:message code='ContractIncomeCost.contractIncomeCostId'/>", align: "center"},
                {name: "contractIncomeCostDate", title: "<spring:message code='ContractIncomeCost.contractIncomeCostDate'/>", align: "center"},
                {name: "contractIncomeCostTime", title: "<spring:message code='ContractIncomeCost.contractIncomeCostTime'/>", align: "center"},
                {name: "codeKala", title: "<spring:message code='ContractIncomeCost.codeKala'/>", align: "center"},
                {name: "nameKala", title: "<spring:message code='ContractIncomeCost.nameKala'/>", align: "center"},
                {name: "sourceId", title: "<spring:message code='ContractIncomeCost.sourceId'/>", align: "center"},
                {name: "source", title: "<spring:message code='ContractIncomeCost.source'/>", align: "center"},
                {name: "targetId", title: "<spring:message code='ContractIncomeCost.targetId'/>", align: "center"},
                {name: "target", title: "<spring:message code='ContractIncomeCost.target'/>", align: "center"},
                {name: "havalehName", title: "<spring:message code='ContractIncomeCost.havalehName'/>", align: "center"},
                {name: "havalehFrom", title: "<spring:message code='ContractIncomeCost.havalehFrom'/>", align: "center"},
                {name: "havalehTo", title: "<spring:message code='ContractIncomeCost.havalehTo'/>", align: "center"},
                {name: "havalehDate", title: "<spring:message code='ContractIncomeCost.havalehDate'/>", align: "center"},
                {name: "isFinal", title: "<spring:message code='ContractIncomeCost.isFinal'/>", align: "center"},
                {name: "targetPlantId"},
                {name: "sourcePlantId"},
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
			// {
			// 	title: "مبدا/مقصد سرجشمه", icon: "pieces/16/search.png",
			// 	click: function () {
			// 		var criteria = {
			// 			_constructor: "AdvancedCriteria",
			// 			operator: "and",
			// 			criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "1"}]
			// 		};
			// 		ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
			// 			ListGrid_ContractIncomeCostSales.setData(data);
			// 		});
			// 	}
			// },
			// {
			// 	title: "مبدا/مقصد ميدوک", icon: "pieces/16/search.png",
			// 	click: function () {
			// 		var criteria = {
			// 			_constructor: "AdvancedCriteria",
			// 			operator: "and",
			// 			criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "2"}]
			// 		};
			// 		ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
			// 			ListGrid_ContractIncomeCostSales.setData(data);
			// 		});
			// 	}
			// },
			// {
			// 	title: "مبدا/مقصد بندرعباس", icon: "pieces/16/search.png",
			// 	click: function () {
			// 		var criteria = {
			// 			_constructor: "AdvancedCriteria",
			// 			operator: "and",
			// 			criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "3"}]
			// 		};
			// 		ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
			// 			ListGrid_ContractIncomeCostSales.setData(data);
			// 		});
			// 	}
			// },
			// {
			// 	title: "مبدا/مقصد خاتون آباد", icon: "pieces/16/search.png",
			// 	click: function () {
			// 		var criteria = {
			// 			_constructor: "AdvancedCriteria",
			// 			operator: "and",
			// 			criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "4"}]
			// 		};
			// 		ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
			// 			ListGrid_ContractIncomeCostSales.setData(data);
			// 		});
			// 	}
			// },
			// {
			// 	title: "مبدا/مقصد سونگون", icon: "pieces/16/search.png",
			// 	click: function () {
			// 		var criteria = {
			// 			_constructor: "AdvancedCriteria",
			// 			operator: "and",
			// 			criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "5"}]
			// 		};
			// 		ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
			// 			ListGrid_ContractIncomeCostSales.setData(data);
			// 		});
			// 	}
			// },
			// {
            <%--title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",--%>
            // click: function () {
            // }
            // },
            // {
            <%--title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",--%>
            // click: function () {
            //     ListGrid_ContractIncomeCost_edit();
            // }
            // },
            // {
            <%--title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",--%>
            // click: function () {
            //     ListGrid_ContractIncomeCost_remove();
            // }
            // },
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
                {name: "cardId", title: "<spring:message code='ContractIncomeCost.cardId'/>", align: "center"},
                {name: "carNo1", title: "<spring:message code='ContractIncomeCost.carNo1'/>", align: "center"},
                {name: "carNo3", title: "<spring:message code='ContractIncomeCost.carNo3'/>", align: "center"},
                {name: "plak", title: "<spring:message code='ContractIncomeCost.plak'/>", align: "center"},
                {name: "carName", title: "<spring:message code='ContractIncomeCost.carName'/>", align: "center"},
                {name: "containerId", title: "<spring:message code='ContractIncomeCost.containerId'/>", align: "center"},
                {name: "containerNo1", title: "<spring:message code='ContractIncomeCost.containerNo1'/>", align: "center"},
                {name: "containerNo3", title: "<spring:message code='ContractIncomeCost.containerNo3'/>", align: "center"},
                {name: "containerName", title: "<spring:message code='ContractIncomeCost.containerName'/>", align: "center"},
                {name: "vazn1", title: "<spring:message code='ContractIncomeCost.vazn1'/>", align: "center"},
                {name: "vazn2", title: "<spring:message code='ContractIncomeCost.vazn2'/>", align: "center"},
                {name: "condition", title: "<spring:message code='ContractIncomeCost.condition'/>", align: "center"},
                {name: "vazn", title: "<spring:message code='ContractIncomeCost.vazn'/>", align: "center"},
                {name: "tedad", title: "<spring:message code='ContractIncomeCost.tedad'/>", align: "center"},
                {name: "unitKala", title: "<spring:message code='ContractIncomeCost.unitKala'/>", align: "center"},
                {name: "packName", title: "<spring:message code='ContractIncomeCost.packName'/>", align: "center"},
                {name: "haveCode", title: "<spring:message code='ContractIncomeCost.haveCode'/>", align: "center"},
                {name: "date", title: "<spring:message code='ContractIncomeCost.date'/>", align: "center"},
                {name: "contractIncomeCostId", title: "<spring:message code='ContractIncomeCost.contractIncomeCostId'/>", align: "center"},
                {name: "contractIncomeCostDate", title: "<spring:message code='ContractIncomeCost.contractIncomeCostDate'/>", align: "center"},
                {name: "contractIncomeCostTime", title: "<spring:message code='ContractIncomeCost.contractIncomeCostTime'/>", align: "center"},
                {name: "codeKala", title: "<spring:message code='ContractIncomeCost.codeKala'/>", align: "center"},
                {name: "nameKala", title: "<spring:message code='ContractIncomeCost.nameKala'/>", align: "center"},
                {name: "sourceId", title: "<spring:message code='ContractIncomeCost.sourceId'/>", align: "center"},
                {name: "source", title: "<spring:message code='ContractIncomeCost.source'/>", align: "center"},
                {name: "targetId", title: "<spring:message code='ContractIncomeCost.targetId'/>", align: "center"},
                {name: "target", title: "<spring:message code='ContractIncomeCost.target'/>", align: "center"},
                {name: "havalehName", title: "<spring:message code='ContractIncomeCost.havalehName'/>", align: "center"},
                {name: "havalehFrom", title: "<spring:message code='ContractIncomeCost.havalehFrom'/>", align: "center"},
                {name: "havalehTo", title: "<spring:message code='ContractIncomeCost.havalehTo'/>", align: "center"},
                {name: "havalehDate", title: "<spring:message code='ContractIncomeCost.havalehDate'/>", align: "center"},
                {name: "isFinal", title: "<spring:message code='ContractIncomeCost.isFinal'/>", align: "center"},

            ]
    });

    var ToolStripButton_ContractIncomeCost_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ContractIncomeCost_refresh();
        }
    });

    // var ToolStripButton_ContractIncomeCost_Add = isc.ToolStripButton.create({
    //     icon: "[SKIN]/actions/add.png",
    <%--title: "<spring:message code='global.form.new'/>",--%>
    // click: function () {
    //     DynamicForm_ContractIncomeCost.clearValues();
    //     Window_ContractIncomeCost.show();
    // }
    // });
    //
    // var ToolStripButton_ContractIncomeCost_Edit = isc.ToolStripButton.create({
    //     icon: "[SKIN]/actions/edit.png",
    <%--title: "<spring:message code='global.form.edit'/>",--%>
    // click: function () {
    //     ListGrid_ContractIncomeCost_edit();
    // }
    // });
    //
    // var ToolStripButton_ContractIncomeCost_Remove = isc.ToolStripButton.create({
    //     icon: "[SKIN]/actions/remove.png",
    <%--title: "<spring:message code='global.form.remove'/>",--%>
    // click: function () {
    //     ListGrid_ContractIncomeCost_remove();
    // }
    // });
    //
    // var ToolStripButton_ContractIncomeCost_Sarcheshmeh = isc.ToolStripButton.create({
    //     icon: "pieces/16/search.png",
    //     title: "مبدا/مقصد سرجشمه",
    //     click: function () {
    //         var criteria = {
    //             _constructor: "AdvancedCriteria",
    //             operator: "and",
    //             criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "1"}]
    //         };
    //         ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
    //             ListGrid_ContractIncomeCostSales.setData(data);
    //         });
    //     }
    // });
    //
    // var ToolStripButton_ContractIncomeCost_Miduk = isc.ToolStripButton.create({
    //     icon: "pieces/16/search.png",
    //     title: "مبدا/مقصد ميدوک",
    //     click: function () {
    //         var criteria = {
    //             _constructor: "AdvancedCriteria",
    //             operator: "and",
    //             criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "2"}]
    //         };
    //         ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
    //             ListGrid_ContractIncomeCostSales.setData(data);
    //         });
    //     }
    // });
    //
    // var ToolStripButton_ContractIncomeCost_Bandar = isc.ToolStripButton.create({
    //     icon: "pieces/16/search.png",
    //     title: "مبدا/مقصد بندرعباس",
    //     click: function () {
    //         var criteria = {
    //             _constructor: "AdvancedCriteria",
    //             operator: "and",
    //             criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "3"}]
    //         };
    //         ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
    //             ListGrid_ContractIncomeCostSales.setData(data);
    //         });
    //     }
    // });
    //
    // var ToolStripButton_ContractIncomeCost_Khaton = isc.ToolStripButton.create({
    //     icon: "pieces/16/search.png",
    //     title: "مبدا/مقصد خاتون آباد",
    //     click: function () {
    //         var criteria = {
    //             _constructor: "AdvancedCriteria",
    //             operator: "and",
    //             criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "4"}]
    //         };
    //         ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
    //             ListGrid_ContractIncomeCostSales.setData(data);
    //         });
    //     }
    // });
    //
    // var ToolStripButton_ContractIncomeCost_sungun = isc.ToolStripButton.create({
    //     icon: "pieces/16/search.png",
    //     title: "مبدا/مقصد سونگون",
    //     click: function () {
    //         var criteria = {
    //             _constructor: "AdvancedCriteria",
    //             operator: "and",
    //             criteria: [{fieldName: "sourcePlantId", operator: "contains", value: "5"}]
    //         };
    //         ListGrid_ContractIncomeCost.fetchData(criteria, function (dsResponse, data, dsRequest) {
    //             ListGrid_ContractIncomeCostSales.setData(data);
    //         });
    //     }
    // });

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
// {name:"carNo1", title:"<spring:message code='ContractIncomeCost.carNo1'/>",align:"center",showHover:true,width:"1%"},
// {name:"carNo3", title:"<spring:message code='ContractIncomeCost.carNo3'/>",align:"center",showHover:true,width:"1%"},
            {
                name: "plak",
                title: "<spring:message code='ContractIncomeCost.plak'/>",
                align: "center",
                showHover: true,
                canEdit: true,
                width: "15%"
            },
            {
                name: "carName",
                title: "<spring:message code='ContractIncomeCost.carName'/>",
                align: "center",
                showHover: true,
                width: "25%",
                operator: "equals"
            },
            {
                name: "containerNo1",
                title: "<spring:message code='ContractIncomeCost.containerNo1'/>",
                align: "center",
                showHover: true,
                width: "15%"
            },
// {name:"vazn1", title:"<spring:message code='ContractIncomeCost.vazn1'/>",align:"center",showHover:true,width:"1%"},
// {name:"vazn2", title:"<spring:message code='ContractIncomeCost.vazn2'/>",align:"center",showHover:true,width:"1%"},
            {
                name: "condition",
                title: "<spring:message code='ContractIncomeCost.condition'/>",
                align: "center",
                showHover: true,
                width: "15%"
            },
            {
                name: "vazn",
                title: "<spring:message code='ContractIncomeCost.vazn'/>",
                align: "center",
                showHover: true,
                width: "15%"
            },
            {
                name: "tedad",
                title: "<spring:message code='ContractIncomeCost.tedad'/>",
                align: "center",
                showHover: true,
                width: "15%"
            },
// {name:"unitKala", title:"<spring:message code='ContractIncomeCost.unitKala'/>",align:"center",showHover:true,width:"1%"},
// {name:"date", title:"<spring:message code='ContractIncomeCost.date'/>",align:"center",showHover:true,width:"1%"},
            {
                name: "contractIncomeCostId",
                title: "<spring:message code='ContractIncomeCost.contractIncomeCostId'/>",
                align: "center",
                showHover: true,
                width: "15%"
            },
            {
                name: "contractIncomeCostDate",
                title: "<spring:message code='ContractIncomeCost.contractIncomeCostDate'/>",
                align: "center",
                showHover: true,
                width: "15%"
            },
// {name:"codeKala", title:"<spring:message code='ContractIncomeCost.codeKala'/>",align:"center",showHover:true,width:"15%"},
            {
                name: "nameKala",
                title: "<spring:message code='ContractIncomeCost.nameKala'/>",
                align: "center",
                showHover: true,
                width: "25%"
            },
// {name:"sourceId", title:"<spring:message code='ContractIncomeCost.sourceId'/>",align:"center",showHover:true,width:"1%"},
            {
                name: "source",
                title: "<spring:message code='ContractIncomeCost.source'/>",
                align: "center",
                showHover: true,
                width: "15%"
            },
// {name:"targetId", title:"<spring:message code='ContractIncomeCost.targetId'/>",align:"center",showHover:true,width:"1%"},
            {
                name: "target",
                title: "<spring:message code='ContractIncomeCost.target'/>",
                align: "center",
                showHover: true,
                width: "15%"
            },
            {
                name: "haveCode",
                title: "<spring:message code='ContractIncomeCost.haveCode'/>",
                align: "center",
                showHover: true,
                canEdit: true,
                width: "15%"
            },
            {
                name: "havalehName",
                title: "<spring:message code='ContractIncomeCost.havalehName'/>",
                align: "center",
                showHover: true,
                width: "25%"
            },
            {
                name: "contractIncomeCostPlantId",
                title: "<spring:message code='ContractIncomeCost.contractIncomeCostPlantId'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
// {name:"isFinal", title:"<spring:message code='ContractIncomeCost.isFinal'/>",align:"center",showHover:true,width:"1%"},
            {
                name: "cardId",
                title: "<spring:message code='ContractIncomeCost.cardId'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
            {
                name: "containerId",
                title: "<spring:message code='ContractIncomeCost.containerId'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
            {
                name: "containerNo3",
                title: "<spring:message code='ContractIncomeCost.containerNo3'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
            {
                name: "containerName",
                title: "<spring:message code='ContractIncomeCost.containerName'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
            {
                name: "packName",
                title: "<spring:message code='ContractIncomeCost.packName'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
            {
                name: "contractIncomeCostTime",
                title: "<spring:message code='ContractIncomeCost.contractIncomeCostTime'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
            {
                name: "havalehFrom",
                title: "<spring:message code='ContractIncomeCost.havalehFrom'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
            {
                name: "havalehTo",
                title: "<spring:message code='ContractIncomeCost.havalehTo'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
            {
                name: "havalehDate",
                title: "<spring:message code='ContractIncomeCost.havalehDate'/>",
                align: "center",
                showHover: true,
                width: "1%"
            },
            {name: "targetPlantId", showHover: true, width: "1%"},
            {name: "sourcePlantId", showHover: true, width: "1%"},
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
            HLayout_ContractIncomeCost_Actions, VLayout_ContractIncomeCost_Grid
        ]
    });

