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
                var criteria = creator.listGrid.main.getCriteria();
                // @ts-ignore
                var fields = report.reportFields.filter(function (q) { return !q.hidden; });
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
            creator.method.print = function () {
                // @ts-ignore
                var criteria = creator.listGrid.main.getCriteria();
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
                cr.criteria.add(criteria);
                cr.criteria.add({
                    fieldName: "id",
                    operator: "equals",
                    value: selectedIds
                });
                var selectReportForm = new nicico.FormUtil();
                selectReportForm.populateData = function (bodyWidget) {
                    // @ts-ignore
                    var data = bodyWidget.getSelectedValue();
                    return {
                        fileId: data.id,
                        fileKey: data.fileKey,
                        // @ts-ignore
                        criteria: cr,
                    };
                };
                selectReportForm.validate = function (data) {
                    return data && data.fileKey;
                };
                selectReportForm.okCallBack = function (data) {
                    creator.method.jsonRPCManagerRequest({
                        // @ts-ignore
                        actionURL: creator.variable.contextPath + "report-execute/print",
                        httpMethod: "GET",
                        params: {
                            type: "PDF",
                            reportId: report.id,
                            fileKey: data.fileKey,
                            criteria: data.criteria
                        }
                    }, 
                    // @ts-ignore
                    function (response) { return creator.window.main.close(); });
                };
                // @ts-ignore
                selectReportForm.showForm(creator.window.main, "<spring:message code='global.form.print'/>" + " - " + report.title, 
                // @ts-ignore
                isc.FileUploadForm.create({
                    accept: ".jrxml",
                    entityName: "Report",
                    recordId: report.id,
                    canAddFile: false,
                    canRemoveFile: false,
                    height: "300",
                    margin: 5
                }), null, "300");
                // @ts-ignore
                selectReportForm.bodyWidget.getObject().reloadData();
            };
            // @ts-ignore
            creator.method.showFilterBuilder = function () {
                // @ts-ignore
                var fetchDataUrl = creator.variable.contextPath + report.source.replaceAll(new RegExp("^/|/$"), '') + '/';
                // @ts-ignore
                var dataSource = isc.RestDataSource.nicico.getDefault(fetchDataUrl, report.reportFields.filter(function (q) { return q.canFilter; }).map(function (p) {
                    var field = { name: p.name, title: p.title, type: p.type, hidden: p.hidden };
                    // @ts-ignore
                    if (p.type === "date")
                        field.filterOperator = ["greaterThan", "lessThan",
                        ];
                    // @ts-ignore
                    if (p.type === "boolean")
                        field.filterOperator = ["isNull", "notNull", "equals", "notEqual", "iEquals", "iNotEqual", "equalsField", "notEqualField", "iEqualsField", "iNotEqualField"];
                    return field;
                }));
                nicico.FilterFormUtil.okCallBack = function (criteria) {
                    // @ts-ignore
                    creator.listGrid.main.setCriteria(criteria);
                };
                // @ts-ignore
                nicico.FilterFormUtil.show(null, '<spring:message code="global.form.filter"/>' + " - " + report.title, dataSource);
            };
            nicico.BasicFormUtil.createDynamicForm = function (c) {
                // @ts-ignore
                c.dynamicForm.main = null;
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
