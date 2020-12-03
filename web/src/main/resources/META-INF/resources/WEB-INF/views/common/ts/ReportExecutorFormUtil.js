//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
///<reference path="FormUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>
///<reference path="FilterFormUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
    //------------------------------------------ Classes -------------------------------------------
    var ReportExecutorFormUtil = /** @class */ (function () {
        function ReportExecutorFormUtil() {
        }
        ReportExecutorFormUtil.showFilterBuilder = function (owner, creator, record, okCallBack) {
            // @ts-ignore
            var fetchDataUrl = creator.variable.contextPath + record.source.replaceAll(new RegExp("^/|/$"), '') + '/';
            // @ts-ignore
            var dataSource = isc.RestDataSource.nicico.getDefault(fetchDataUrl, record.reportFields.filter(function (q) { return q.canFilter; }).map(function (p) {
                return { name: p.name, title: p.title, type: p.type, hidden: false };
            }));
            nicico.FilterFormUtil.okCallBack = okCallBack;
            // @ts-ignore
            nicico.FilterFormUtil.show(owner, '<spring:message code="global.form.filter"/>' + " - " + record.title, dataSource);
        };
        ReportExecutorFormUtil.createRestDataSource = function (creator) {
            // @ts-ignore
            creator.restDataSource.main = isc.RestDataSource.nicico.getDefault(creator.variable.url + "report-with-permission", [], creator.method.transformRequest);
        };
        ReportExecutorFormUtil.createListGrid = function (creator) {
            // @ts-ignore
            creator.listGrid.main = isc.ListGrid.nicico.getDefault([
                {
                    name: "id",
                    title: "<spring:message code='global.id'/>",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                { name: "title", title: "<spring:message code='report.title'/>" },
                { name: "source", title: "<spring:message code='report.source'/>", hidden: true },
                { name: "name", title: "<spring:message code='report.name'/>" },
                { name: "reportGroup.name", title: "<spring:message code='report.group.name'/>" },
                { name: "view", width: "100", align: "center", title: "<spring:message code='report.preview'/>" }
            ], 
            // @ts-ignore
            creator.restDataSource.main, 
            // @ts-ignore
            creator.variable.criteria, {
                width: "100%",
                height: "500",
                margin: 5,
                showRecordComponents: true,
                showRecordComponentsByCell: true,
                gridComponents: ["header", "body", isc.ToolStrip.create({
                        width: "100%",
                        height: 25,
                        members: [
                            isc.ToolStripButton.create({
                                icon: "icon/excel.png",
                                title: '<spring:message code="global.form.print.excel"/>',
                                // @ts-ignore
                                click: function () {
                                    // @ts-ignore
                                    var record = creator.listGrid.main.getSelectedRecord();
                                    if (record == null) {
                                        creator.dialog.notSelected();
                                        return;
                                    }
                                    if (!record.printAccess) {
                                        creator.dialog.say("<spring:message code='exception.access-denied'/>");
                                        return;
                                    }
                                    // @ts-ignore
                                    ReportExecutorFormUtil.showFilterBuilder(creator.window.main, creator, record, function (criteria) {
                                        var fields = record.reportFields.filter(function (q) { return !q.hidden; });
                                        // @ts-ignore
                                        creator.dynamicForm.excel.setValue("reportId", record.id);
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
                                    });
                                }
                            }),
                            isc.ToolStripButton.create({
                                icon: "[SKIN]/actions/print.png",
                                title: "<spring:message code='global.form.print'/>",
                                // @ts-ignore
                                click: function () {
                                    // @ts-ignore
                                    var record = creator.listGrid.main.getSelectedRecord();
                                    if (record == null) {
                                        creator.dialog.notSelected();
                                        return;
                                    }
                                    if (!record.printAccess) {
                                        creator.dialog.say("<spring:message code='exception.access-denied'/>");
                                        return;
                                    }
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
                                        var filter = isc.IButtonSave.create({
                                            // @ts-ignore
                                            click: function () {
                                                // @ts-ignore
                                                ReportExecutorFormUtil.showFilterBuilder(ThisForm.windowWidget.getObject(), creator, record, function (criteria) {
                                                    // @ts-ignore
                                                    ThisForm.bodyWidget.getObject().criteria = criteria;
                                                });
                                            },
                                            icon: "[SKIN]/actions/filter.png",
                                            title: '<spring:message code="global.form.filter" />'
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
                                                }), isc.HLayout.create({
                                                    align: nicico.CommonUtil.getAlignByLang(),
                                                    members: [filter]
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
                                            criteria: bodyWidget.criteria,
                                        } : null;
                                    };
                                    selectReportForm.validate = function (data) {
                                        var isValid = data && data.fileKey;
                                        if (!isValid)
                                            creator.dialog.notSelected();
                                        return isValid;
                                    };
                                    selectReportForm.okCallBack = function (data) {
                                        // @ts-ignore
                                        creator.dynamicForm.print.setValue("reportId", record.id);
                                        // @ts-ignore
                                        creator.dynamicForm.print.setValue("fileKey", data.fileKey);
                                        // @ts-ignore
                                        creator.dynamicForm.print.setValue("type", data.type);
                                        if (data.criteria && Object.keys(data.criteria).length)
                                            // @ts-ignore
                                            creator.dynamicForm.print.setValue("criteria", JSON.stringify(data.criteria));
                                        else
                                            // @ts-ignore
                                            creator.dynamicForm.print.setValue("criteria", JSON.stringify(null));
                                        // @ts-ignore
                                        creator.dynamicForm.print.method = "GET";
                                        // @ts-ignore
                                        creator.dynamicForm.print.action = creator.variable.contextPath + "report-execute/print";
                                        // @ts-ignore
                                        creator.dynamicForm.print.submitForm();
                                        // @ts-ignore
                                        creator.window.main.close();
                                    };
                                    // @ts-ignore
                                    selectReportForm.showForm(creator.window.main, "<spring:message code='global.form.print'/>" + " - " + record.title, 
                                    // @ts-ignore
                                    isc.FileUploadForm.create({
                                        accept: ".jasper",
                                        entityName: "Report",
                                        recordId: record.id,
                                        canAddFile: false,
                                        canRemoveFile: false,
                                        canDownloadFile: false,
                                        height: "300",
                                        margin: 5
                                    }), null, "300");
                                    // @ts-ignore
                                    selectReportForm.bodyWidget.getObject().reloadData();
                                }
                            }),
                            isc.ToolStripButton.create({
                                // @ts-ignore
                                click: function () {
                                    // @ts-ignore
                                    creator.window.main.close();
                                    // @ts-ignore
                                    if (creator.variable.owner != null)
                                        // @ts-ignore
                                        creator.variable.owner.show();
                                    ReportExecutorFormUtil.cancelCallBack();
                                },
                                icon: "pieces/16/icon_delete.png",
                                title: '<spring:message code="global.close" />'
                            })
                        ]
                    })],
                createRecordComponent: function (record, colNum) {
                    if (record == null || colNum != 4 || record.reportType === "None")
                        return null;
                    return isc.ToolStripButton.create({
                        icon: "icon/preview.png",
                        width: "25",
                        // @ts-ignore
                        click: function () {
                            if (record == null) {
                                creator.dialog.notSelected();
                                return;
                            }
                            if (!record.viewAccess) {
                                creator.dialog.say("<spring:message code='exception.access-denied'/>");
                                return;
                            }
                            // @ts-ignore
                            creator.variable.createTab(record.title, creator.variable.contextPath + 'report-execute/show-form/' + record.id);
                            // @ts-ignore
                            creator.window.main.close();
                        }
                    });
                }
            });
        };
        ReportExecutorFormUtil.createWindow = function (creator, title) {
            // @ts-ignore
            creator.window.main = isc.Window.nicico.getDefault(title, [
                // @ts-ignore
                creator.listGrid.main
            ], "60%");
        };
        ReportExecutorFormUtil.createExcelSubmitForm = function (creator) {
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
        };
        ReportExecutorFormUtil.createPrintSubmitForm = function (creator) {
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
        };
        ReportExecutorFormUtil.show = function (owner, title, criteria, createTab) {
            var creator = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
            // @ts-ignore
            creator.variable.createTab = createTab;
            // @ts-ignore
            creator.variable.owner = owner;
            // @ts-ignore
            creator.variable.contextPath = creator.variable.url;
            // @ts-ignore
            creator.variable.url += "api/report-execute/";
            // @ts-ignore
            creator.variable.criteria = criteria;
            this.createExcelSubmitForm(creator);
            this.createPrintSubmitForm(creator);
            this.createRestDataSource(creator);
            this.createListGrid(creator);
            this.createWindow(creator, title);
            if (owner != null)
                owner.close();
            // @ts-ignore
            creator.window.main.show();
            // @ts-ignore
            return creator.window.main;
        };
        ReportExecutorFormUtil.cancelCallBack = function () {
            return;
        };
        return ReportExecutorFormUtil;
    }());
    nicico.ReportExecutorFormUtil = ReportExecutorFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
