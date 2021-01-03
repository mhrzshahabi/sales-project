//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>
///<reference path="BasicFormUtil.ts"/>
///<reference path="FilterFormUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    var ReportPreviewFormUtil = /** @class */ (function () {
        function ReportPreviewFormUtil() {
        }
        ReportPreviewFormUtil.prototype.create = function () {
            var report = JSON.parse('${Data_Report}');
            var creator = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
            // @ts-ignore
            creator.variable.contextPath = creator.variable.url;
            // @ts-ignore
            creator.variable.url += "api/report-execute/";
            creator.listGrid.fields = report.reportFields.map(function (p) {
                return {
                    width: "100%",
                    name: p.name,
                    title: p.title,
                    type: p.type,
                    hidden: p.hidden,
                    canFilter: p.canFilter
                };
            });
            // @ts-ignore
            creator.dynamicForm.excel = isc.DynamicForm.create({
                method: "POST",
                action: "",
                target: "_Blank",
                autoDraw: true,
                visibility: "hidden",
                fields: [
                    // @ts-ignore
                    { name: "fields", type: "hidden" },
                    // @ts-ignore
                    { name: "headers", type: "hidden" },
                    // @ts-ignore
                    { name: "criteria", type: "hidden" },
                    // @ts-ignore
                    { name: "reportId", type: "hidden" }
                ]
            });
            // @ts-ignore
            creator.dynamicForm.excel.hide();
            // @ts-ignore
            creator.method.exportExcel = function () {
                // @ts-ignore
                var criteria = creator.listGrid.main.getInitialCriteria();
                if (!Object.keys(criteria).length)
                    criteria = null;
                // @ts-ignore
                var fields = creator.listGrid.main.getFields().filter(function (q) {
                    return q.name !== "groupTitle" &&
                        // @ts-ignore
                        q.name !== creator.listGrid.main.getRowNumberField().name &&
                        // @ts-ignore
                        q.name !== creator.listGrid.main.getCheckboxField().name;
                });
                // @ts-ignore
                creator.dynamicForm.excel.setValue("reportId", report.id);
                // @ts-ignore
                creator.dynamicForm.excel.setValue("fields", fields.map(function (q) { return q.name; }));
                // @ts-ignore
                creator.dynamicForm.excel.setValue("headers", fields.map(function (q) { return q.title; }));
                // @ts-ignore
                creator.dynamicForm.excel.setValue("criteria", JSON.stringify(criteria));
                // @ts-ignore
                creator.dynamicForm.excel.method = "GET";
                // @ts-ignore
                creator.dynamicForm.excel.action = creator.variable.contextPath + "report-execute/excel";
                // @ts-ignore
                creator.dynamicForm.excel.submitForm();
            };
            // @ts-ignore
            creator.dynamicForm.print = isc.DynamicForm.create({
                method: "POST",
                action: "",
                target: "_Blank",
                autoDraw: true,
                visibility: "hidden",
                fields: [
                    // @ts-ignore
                    { name: "fileKey", type: "hidden" },
                    // @ts-ignore
                    { name: "type", type: "hidden" },
                    // @ts-ignore
                    { name: "criteria", type: "hidden" },
                    // @ts-ignore
                    { name: "reportId", type: "hidden" }
                ]
            });
            // @ts-ignore
            creator.dynamicForm.print.hide();
            // @ts-ignore
            creator.method.print = function () {
                // @ts-ignore
                var criteria = creator.listGrid.main.getInitialCriteria();
                if (!Object.keys(criteria).length)
                    criteria = null;
                var selectedIds = [];
                if (report.reportType === "OneRecord") {
                    // @ts-ignore
                    var record = creator.listGrid.main.getSelectedRecord();
                    if (!record) {
                        creator.dialog.notSelected();
                        return;
                    }
                    // @ts-ignore
                    selectedIds.add(record.id);
                }
                if (report.reportType === "SelectedRecords") {
                    // @ts-ignore
                    var records = creator.listGrid.main.getSelectedRecords();
                    if (!records || !records.length) {
                        creator.dialog.notSelected();
                        return;
                    }
                    // @ts-ignore
                    selectedIds.addAll(records.map(function (q) { return q.id; }));
                }
                var cr = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: []
                };
                if (criteria)
                    cr.criteria.add(criteria);
                if (selectedIds && selectedIds.length)
                    cr.criteria.add({
                        fieldName: "id",
                        operator: "equals",
                        value: selectedIds
                    });
                var selectReportForm = new nicico.FormUtil();
                selectReportForm.getButtonLayout = function () {
                    var ThisForm = selectReportForm;
                    // @ts-ignore
                    var cancel = isc.IButtonCancel.create({
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            ThisForm.windowWidget.getObject().close();
                            // @ts-ignore
                            if (ThisForm.owner.getObject() != null)
                                // @ts-ignore
                                ThisForm.owner.getObject().show();
                            ThisForm.cancelCallBack();
                        },
                    });
                    // @ts-ignore
                    var ok = isc.IButtonSave.create({
                        // @ts-ignore
                        click: function () {
                            // @ts-ignore
                            var data = ThisForm.populateData(ThisForm.bodyWidget.getObject());
                            if (!ThisForm.validate(data))
                                return;
                            // @ts-ignore
                            ThisForm.windowWidget.getObject().close();
                            // @ts-ignore
                            if (ThisForm.owner.getObject() != null)
                                // @ts-ignore
                                ThisForm.owner.getObject().show();
                            ThisForm.okCallBack(data);
                        },
                    });
                    // @ts-ignore
                    var slider = isc.Slider.create({
                        title: "PDF",
                        width: 100,
                        height: 20,
                        labelHeight: 0,
                        minValue: 1,
                        maxValue: 2,
                        numValues: 2,
                        vertical: false,
                        minValueLabel: " ",
                        maxValueLabel: " ",
                        showValue: false,
                        valueChanged: function (value) {
                            this.Super('valueChanged', arguments);
                            // @ts-ignore
                            ThisForm.bodyWidget.getObject().slider = value;
                            this.setTitle(value === 1 ? "PDF" : "EXCEL");
                        }
                    });
                    return isc.HLayout.create({
                        width: "100%",
                        padding: 10,
                        layoutMargin: 10,
                        membersMargin: 10,
                        edgeImage: "",
                        showEdges: false,
                        members: [ok, cancel, isc.HLayout.create({
                                height: 20,
                                width: "100%",
                                align: nicico.CommonUtil.getAlignByLang(),
                                members: [slider]
                            })]
                    });
                };
                selectReportForm.populateData = function (bodyWidget) {
                    // @ts-ignore
                    var data = bodyWidget.getSelectedValue();
                    return data ? {
                        fileId: data.id,
                        fileKey: data.fileKey,
                        // @ts-ignore
                        type: bodyWidget.slider === 2 ? "EXCEL" : "PDF",
                        // @ts-ignore
                        criteria: cr,
                    } : null;
                };
                selectReportForm.validate = function (data) {
                    return data && data.fileKey;
                };
                selectReportForm.okCallBack = function (data) {
                    // @ts-ignore
                    creator.dynamicForm.print.setValue("reportId", report.id);
                    // @ts-ignore
                    creator.dynamicForm.print.setValue("fileKey", data.fileKey);
                    // @ts-ignore
                    creator.dynamicForm.print.setValue("type", data.type);
                    // @ts-ignore
                    creator.dynamicForm.print.setValue("criteria", JSON.stringify(data.criteria));
                    // @ts-ignore
                    creator.dynamicForm.print.method = "GET";
                    // @ts-ignore
                    creator.dynamicForm.print.action = creator.variable.contextPath + "report-execute/print";
                    // @ts-ignore
                    creator.dynamicForm.print.submitForm();
                };
                // @ts-ignore
                selectReportForm.showForm(creator.window.main, "<spring:message code='global.form.print'/>" + " - " + report.title, 
                // @ts-ignore
                isc.FileUploadForm.create({
                    accept: ".jasper",
                    entityName: "Report",
                    recordId: report.id,
                    canAddFile: false,
                    canRemoveFile: false,
                    canDownloadFile: false,
                    height: "300",
                    margin: 5
                }), null, "300");
                // @ts-ignore
                selectReportForm.actionWidget.getObject().getMember(0).setTitle("<spring:message code='global.form.print'/>");
                // @ts-ignore
                selectReportForm.actionWidget.getObject().getMember(0).setIcon("[SKIN]/actions/print.png");
                // @ts-ignore
                selectReportForm.bodyWidget.getObject().reloadData();
            };
            // @ts-ignore
            creator.method.showFilterBuilder = function () {
                // @ts-ignore
                var fetchDataUrl = creator.variable.contextPath + report.source.replaceAll(new RegExp("^/|/$"), '') + '/';
                // @ts-ignore
                var dataSource = isc.MyRestDataSource.nicico.getDefault(fetchDataUrl, report.reportFields.filter(function (q) { return q.canFilter; }).map(function (p) {
                    return { name: p.name, title: p.title, type: p.type, hidden: false };
                }));
                nicico.FilterFormUtil.okCallBack = function (criteria) {
                    // @ts-ignore
                    creator.listGrid.main.setCriteria(criteria);
                };
                // @ts-ignore
                nicico.FilterFormUtil.show(null, '<spring:message code="global.form.filter"/>' + " - " + report.title, dataSource, creator.listGrid.main.getCriteria());
            };
            nicico.BasicFormUtil.createDynamicForm = function (c) {
                // @ts-ignore
                c.dynamicForm.main = null;
            };
            nicico.BasicFormUtil.createListGrid = function (c) {
                var listGridFirstField = { name: null };
                if (creator.listGrid.fields && creator.listGrid.fields.length)
                    listGridFirstField = creator.listGrid.fields[0];
                // @ts-ignore
                creator.listGrid.main = isc.ListGrid.nicico.getDefault(creator.listGrid.fields, creator.restDataSource.main, creator.listGrid.criteria, {
                    canHover: true,
                    showHover: true,
                    autoFitMaxWidth: "15%",
                    autoFitWidthApproach: "both",
                    autoFitFieldsFillViewport: true,
                    autoFitExpandField: listGridFirstField.name,
                    dataArrived: function (startRow, endRow) {
                        this.autoFitFields();
                        this.Super("dataArrived", arguments);
                    }
                });
            };
            nicico.BasicFormUtil.createListGridMenu = function (c) {
                // @ts-ignore
                c.menu.main = isc.Menu.create({
                    width: 150,
                    items: [
                        {
                            icon: "pieces/16/refresh.png",
                            title: '<spring:message code="global.form.refresh"/>',
                            click: function () {
                                // @ts-ignore
                                c.method.refresh(c.listGrid.main);
                            }
                        },
                        // <c:if test = "${Excel_Access}">
                        {
                            icon: "icon/excel.png",
                            title: '<spring:message code="global.form.print.excel"/>',
                            click: function () {
                                // @ts-ignore
                                c.method.exportExcel();
                            }
                        },
                        // </c:if>
                        // <c:if test = "${Print_Access}">
                        {
                            icon: "[SKIN]/actions/print.png",
                            title: "<spring:message code='global.form.print'/>",
                            click: function () {
                                // @ts-ignore
                                c.method.print();
                            }
                        },
                        // </c:if>
                        {
                            icon: "[SKIN]/actions/filter.png",
                            title: '<spring:message code="global.form.filter" />',
                            click: function () {
                                // @ts-ignore
                                c.method.showFilterBuilder();
                            }
                        }
                    ]
                });
                // @ts-ignore
                isc.Canvas.nicico.changeProperties(c.listGrid.main, "contextMenu", c.menu.main);
            };
            nicico.BasicFormUtil.createToolStrip = function (c) {
                // @ts-ignore
                c.toolStrip.main = isc.ToolStrip.create({
                    width: "100%",
                    members: [
                        // <c:if test = "${Excel_Access}">
                        isc.ToolStripButton.create({
                            icon: "icon/excel.png",
                            title: '<spring:message code="global.form.print.excel"/>',
                            // @ts-ignore
                            click: function () {
                                // @ts-ignore
                                c.method.exportExcel();
                            }
                        }),
                        // </c:if>
                        // <c:if test = "${Print_Access}">
                        isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/print.png",
                            title: "<spring:message code='global.form.print'/>",
                            // @ts-ignore
                            click: function () {
                                // @ts-ignore
                                c.method.print();
                            }
                        }),
                        // </c:if>
                        isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/filter.png",
                            title: '<spring:message code="global.form.filter" />',
                            // @ts-ignore
                            click: function () {
                                // @ts-ignore
                                c.method.showFilterBuilder();
                            }
                        }),
                        isc.ToolStrip.create({
                            width: "100%",
                            border: '0px',
                            align: nicico.CommonUtil.getAlignByLang(),
                            members: [
                                // @ts-ignore
                                isc.ToolStripButtonRefresh.create({
                                    // @ts-ignore
                                    actionType: nicico.ActionType.REFRESH,
                                    title: "<spring:message code='global.form.refresh'/>",
                                    click: function () {
                                        // @ts-ignore
                                        c.method.refresh(c.listGrid.main);
                                    }
                                })
                            ]
                        })
                    ]
                });
            };
            var layout = nicico.BasicFormUtil.getDefaultBasicForm(creator, 'report-data/' + report.id);
            if (report.reportType === "OneRecord")
                // @ts-ignore
                creator.listGrid.main.setSelectionType("single");
            if (report.reportType === "SelectedRecords")
                // @ts-ignore
                creator.listGrid.main.setSelectionType("simple");
            if (report.reportType === "All")
                // @ts-ignore
                creator.listGrid.main.setSelectionType("none");
            return layout;
        };
        ;
        return ReportPreviewFormUtil;
    }());
    nicico.ReportPreviewFormUtil = ReportPreviewFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
