<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

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
        items:
            [
                ViewLoader_createTozin
            ]
    });

    function ListGrid_Tozin_refresh() {
        ListGrid_Tozin.invalidateCache();
    }

    var RestDataSource_Tozin = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "cardId", title: "<spring:message code='Tozin.cardId'/>", align: "center"},
                {name: "carNo1", title: "<spring:message code='Tozin.carNo1'/>", align: "center"},
                {name: "carNo3", title: "<spring:message code='Tozin.carNo3'/>", align: "center"},
                {name: "plak", title: "<spring:message code='Tozin.plak'/>", align: "center"},
                {name: "carName", title: "<spring:message code='Tozin.carName'/>", align: "center"},
                {name: "containerId", title: "<spring:message code='Tozin.containerId'/>", align: "center"},
                {name: "containerNo1", title: "<spring:message code='Tozin.containerNo1'/>", align: "center"},
                {name: "containerNo3", title: "<spring:message code='Tozin.containerNo3'/>", align: "center"},
                {name: "containerName", title: "<spring:message code='Tozin.containerName'/>", align: "center"},
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
                {name: "havalehFrom", title: "<spring:message code='Tozin.havalehFrom'/>", align: "center"},
                {name: "havalehTo", title: "<spring:message code='Tozin.havalehTo'/>", align: "center"},
                {name: "havalehDate", title: "<spring:message code='Tozin.havalehDate'/>", align: "center"},
                {name: "isFinal", title: "<spring:message code='Tozin.isFinal'/>", align: "center"},
                {name: "targetPlantId",title: "<spring:message code='Tozin.targetPlantId'/>"},
                {name: "sourcePlantId",title: "<spring:message code='Tozin.sourcePlantId'/>"},
            ],
// ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/tozin/spec-list"
    });

    var RestDataSource_MaterialItem = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "gdsCode", title: "<spring:message code='goods.code'/> "},
                {name: "gdsName"},
                {name: "materialId"}
            ],
        // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/materialItem/spec-list"
    });

    // var fltTozin = isc.FilterBuilder.create({dataSource: RestDataSource_Tozin});
    var HLayout_Tozin_labels = isc.HLayout.create({
        width: "100%",
        layoutMargin: 5,
        height: 22,
        showEdges: false,
        members: [
            isc.Label.create({width: 10}),
            isc.Label.create({width: "100%"}),
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
        setMethod: 'POST',
        align: "center",
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
                    name: "fromDay",
                    ID: "fromDayDate",
                    title: "<spring:message code='dailyWarehouse.fromDay'/>",
                    type: 'text',
                    align: "center",
                    width: 150,
                    colSpan: 1,
                    titleColSpan: 1,
                    icons: [{
                        src: "pieces/pcal.png", click: function () {
                            displayDatePicker('fromDayDate', this, 'ymd', '/');
                        }
                    }],
                    defaultValue: "1398/01/6",
                }
            ]
    });

    var DynamicForm_DailyReport_Tozin1 = isc.DynamicForm.create({
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
                    titleColSpan: 1,
                    icons: [{
                        src: "pieces/pcal.png", click: function () {
                            displayDatePicker('toDayDate', this, 'ymd', '/');
                        }
                    }],
                    defaultValue: "1398/03/26",
                }
            ]
    });

    var DynamicForm_DailyReport_Tozin2 = isc.DynamicForm.create({
        width: "200",
        wrapItemTitles: false,
        height: "100%",
        setMethod: 'POST',
        align: "center",
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
                    name: "materialId",
                    colSpan: 3,
                    titleColSpan: 1,
                    tabIndex: 7,
                    showHover: true,
                    autoFetchData: false,
                    required: true,
                    title: "<spring:message code='contractItem.material'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_MaterialItem,
                    displayField: "gdsName",
                    valueField: "gdsCode",
                    pickListWidth: "200",
                    pickListHeight: "200",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "gdsName", width: 218, align: "center"}
                    ],defaultValue: 11
                }
            ]
    });

    var DynamicForm_DailyReport_Tozin3 = isc.DynamicForm.create({
        width: "200",
        wrapItemTitles: false,
        height: "100%",
        setMethod: 'POST',
        align: "center",
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
                    name: "type",
                    title: "<spring:message code='dailyWarehouse.plant'/>",
                    valueMap: {
                        "1-": "<spring:message code='global.Sarcheshmeh'/>",
                        "2-": "<spring:message code='global.Miduk'/>",
                        "4-": "<spring:message code='global.KhatonAbad'/>",
                        "5-": "<spring:message code='global.Sungun'/>"
                    },
                    defaultValue: "1-"
                }
            ]
    });

    var DynamicForm_DailyReport_Tozin4 = isc.DynamicForm.create({
        width: "200",
        wrapItemTitles: false,
        height: "100%",
        setMethod: 'POST',
        align: "center",
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
                    name: "type",
                    title: "نوع حمل",
                    valueMap: {
                        "جاده ای": "جاده ای",
                        "ریلی": "ریلی"
                    },
                    defaultValue: "ریلی"
                },
            ]
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
            },
{
                title: "<spring:message code='bijack'/>", icon: "product/warehouses.png",
                click: function () {
                     if (ListGrid_Tozin.getSelectedRecord().codeKala === 11) {
                        BijackViewLoader.setViewURL("tozin/showWarehouseCadForm");
                        Window_Bijack.show();
                    }
                }
            }
        ]
    });

    isc.ViewLoader.create({
        ID: "BijackViewLoader",
        width: 830,
        height: 600,
        autoDraw: false,
        loadingMessage: " <spring:message code='global.loadingMessage'/>"
    });

    var Window_Bijack = isc.Window.create({
        title: "<spring:message code='bijack'/> ",
        width: 830,
        height: 600,
        autoSize:true,
        autoCenter: true,
        isModal: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                BijackViewLoader
            ]
    });

    var MenuButton_Tozin = isc.MenuButton.create({
        ID: "MenuButton_Tozin",
        autoDraw: false,
        title: "<spring:message code='tozin.report.betweenComplexes'/>",
        prompt: "<spring:message code='tozin.report.betweenComplexes.date'/>",
        width: 100,
        menu: Menu_ListGrid_Tozin
    });

    function ListGrid_Tozin_edit() {

        var record = ListGrid_Tozin.getSelectedRecord();

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
            DynamicForm_Tozin.editRecord(record);
            Window_Tozin.show();
        }
    }

    function ListGrid_Tozin_remove() {

        var record = ListGrid_Tozin.getSelectedRecord();

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
                        var TozinId = record.id;
// ######@@@@###&&@@###
                        var methodXXXX = "PUT";
                        if (data.id == null) methodXXXX = "POST";
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
                                actionURL: "${contextPath}/api/tozin/" + TozinId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_Tozin_refresh();
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

    var DynamicForm_Tozin = isc.DynamicForm.create({
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
        backgroundImage: "backgrounds/leaves.jpg",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4,
        fields:
            [

                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "cardId", title: "<spring:message code='Tozin.cardId'/>", align: "center"},
                {name: "carNo1", title: "<spring:message code='Tozin.carNo1'/>", align: "center"},
                {name: "carNo3", title: "<spring:message code='Tozin.carNo3'/>", align: "center"},
                {name: "plak", title: "<spring:message code='Tozin.plak'/>", align: "center"},
                {name: "carName", title: "<spring:message code='Tozin.carName'/>", align: "center"},
                {name: "containerId", title: "<spring:message code='Tozin.containerId'/>", align: "center"},
                {name: "containerNo1", title: "<spring:message code='Tozin.containerNo1'/>", align: "center"},
                {name: "containerNo3", title: "<spring:message code='Tozin.containerNo3'/>", align: "center"},
                {name: "containerName", title: "<spring:message code='Tozin.containerName'/>", align: "center"},
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
                {name: "havalehFrom", title: "<spring:message code='Tozin.havalehFrom'/>", align: "center"},
                {name: "havalehTo", title: "<spring:message code='Tozin.havalehTo'/>", align: "center"},
                {name: "havalehDate", title: "<spring:message code='Tozin.havalehDate'/>", align: "center"},
                {name: "isFinal", title: "<spring:message code='Tozin.isFinal'/>", align: "center"},

            ]
    });

    var ToolStripButton_Tozin_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Tozin_refresh();
        }
    });

    var ToolStripButton_Tozin_sum = isc.ToolStripButton.create({
        icon: "icon/sigma.png",
        title: "<spring:message code='shipment.total'/>",
        prompt: " <spring:message code='shipment.tozinSum.prompt'/>",
        click: function () {
            var sum1 = 0;
            var sum2 = 0;
            var selectedAtFirst = ListGrid_Tozin.getSelection().length;
            if (selectedAtFirst == 0) {
                ListGrid_Tozin.selectAllRecords();
            }
            var record = ListGrid_Tozin.getSelection();
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
                title: "مجموع حمل",
            });
            // isc.ask("جمع تخلیه "+record.length+" رکورد مقدار"+sum+" می باشد");
            if (selectedAtFirst == 0) {
                ListGrid_Tozin.deselectAllRecords();
            }

        }
    });

    var ToolStrip_Actions_Tozin = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 10,
        members:
            [
                MenuButton_Tozin,
                ToolStripButton_Tozin_Refresh,
                ToolStripButton_Tozin_sum,
                DynamicForm_DailyReport_Tozin,
                DynamicForm_DailyReport_Tozin1,
                DynamicForm_DailyReport_Tozin2,
                DynamicForm_DailyReport_Tozin3,
                DynamicForm_DailyReport_Tozin4,
                isc.IButton.create({
                    width: 150,
                    height: 22,
                    title: "<spring:message code='global.search'/>",
                    icon: "icon/search.png",
                    click: function () {
                        var criteria;
                        if(DynamicForm_DailyReport_Tozin4.getValues().type === 'جاده ای'){
                            criteria = {
                                _constructor: "AdvancedCriteria",
                                operator: "and",
                                criteria: [
                                    {fieldName: "mazloom", operator: "contains", value: ''},
                                    {fieldName: "tozinDate", operator: "greaterOrEqual", value: DynamicForm_DailyReport_Tozin.getValues().fromDay},
                                    {fieldName: "tozinDate", operator: "lessOrEqual", value: DynamicForm_DailyReport_Tozin1.getValues().toDay},
                                    {fieldName: "codeKala", operator: "equals", value: DynamicForm_DailyReport_Tozin2.getValues().materialId},
                                    {fieldName: "tozinPlantId", operator: "contains", value: DynamicForm_DailyReport_Tozin3.getValues().type},
                                    {fieldName: "targetPlantId", operator: "equals", value: 3},
                                    {fieldName: "carName", operator: "notContains", value: 'انتينر'}
                                    ]
                            };
                        }

                        if(DynamicForm_DailyReport_Tozin4.getValues().type === 'ریلی'){
                            criteria = {
                                _constructor: "AdvancedCriteria",
                                operator: "and",
                                criteria: [
                                    {fieldName: "mazloom", operator: "contains", value: ''},
                                    {fieldName: "tozinDate", operator: "greaterOrEqual", value: DynamicForm_DailyReport_Tozin.getValues().fromDay},
                                    {fieldName: "tozinDate", operator: "lessOrEqual", value: DynamicForm_DailyReport_Tozin1.getValues().toDay},
                                    {fieldName: "codeKala", operator: "equals", value: DynamicForm_DailyReport_Tozin2.getValues().materialId},
                                    {fieldName: "tozinPlantId", operator: "contains", value: DynamicForm_DailyReport_Tozin3.getValues().type},
                                    {fieldName: "targetPlantId", operator: "equals", value: 3},
                                    {fieldName: "carName", operator: "contains", value: 'انتينر'}
                                    ]
                            };
                        }

                        ListGrid_Tozin.fetchData(criteria, function (dsResponse, data, dsRequest) {
                            ListGrid_Tozin.setData(data);
                        });
                    }})
            ]
    });

    var HLayout_Tozin_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Tozin
            ]
    });

    var IButton_Tozin_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Tozin.validate();
            if (DynamicForm_Tozin.hasErrors())
                return;

            var data = DynamicForm_Tozin.getValues();
// ######@@@@###&&@@###
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
// ######@@@@###&&@@### pls correct callback
                    actionURL: "${contextPath}/api/tozin/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
// ######@@@@###&&@@###
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            ListGrid_Tozin_refresh();
                            Window_Tozin.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });
    var IButton_Tozin_Cancel = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_Tozin.close();
        }
    });
    var Window_Tozin = isc.Window.create({
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
                DynamicForm_Tozin,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_Tozin_Save,
                            isc.Label.create({width: 5,})
                            , IButton_Tozin_Cancel
                        ]
                })

            ]
    });
    var ListGrid_Tozin = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Tozin,
        contextMenu: Menu_ListGrid_Tozin,
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
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        allowFilterExpressions: true,
        allowAdvancedCriteria: true,
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

    // var VLayout_fltTozin = isc.VLayout.create(
    //     {
    //         layoutMargin: 10,
    //         members: [fltTozin]
    //     }
    // );


    var VLayout_Tozin_Grid = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            // VLayout_fltTozin,
            HLayout_Tozin_labels,
            ListGrid_Tozin
        ]
    });
    var VLayout_Tozin_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Tozin_Actions, VLayout_Tozin_Grid
        ]
    });