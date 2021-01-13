//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>
///<reference path="BasicFormUtil.ts"/>
///<reference path="FilterFormUtil.ts"/>

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

    //------------------------------------------ Classes -------------------------------------------

    export class ReportPreviewFormUtil {

        private createFields(report, reportCriteria: Array<isc.Criteria>): Array<isc.FormItem> {

            if (!reportCriteria || !reportCriteria.length)
                return [];

            let fields = [];
            for (let i = 0; i < reportCriteria.length; i++) {

                // @ts-ignore
                if (!reportCriteria[i])
                    break;
                // @ts-ignore
                else if (reportCriteria[i]._constructor === "AdvancedCriteria")
                // @ts-ignore
                    fields.addAll(this.createFields(report, reportCriteria[i].criteria));
                // @ts-ignore
                else if (reportCriteria[i].value === "?") {
                    // @ts-ignore
                    reportCriteria[i].value = null;
                    // @ts-ignore
                    let findField = report.reportFields.find(p => p.name === reportCriteria[i].fieldName);
                    if (findField)
                        fields.add({
                            width: "100%",
                            required: true,
                            // @ts-ignore
                            name: findField.name,
                            // @ts-ignore
                            title: findField.title,
                            // @ts-ignore
                            type: findField.type,
                            // @ts-ignore
                            criteria: reportCriteria[i],
                            // @ts-ignore
                            hint: FilterBuilderOperator[reportCriteria[i].operator],
                            changed: function (form, item, value) {

                                this.criteria.value = value;
                            }
                        });
                }
            }

            return fields;
        }

        private showParamForm(creator: JSPTabVariable, report: any, reportCriteria: isc.AdvancedCriteria): void {

            let This = this;
            let fields = this.createFields(report, reportCriteria.criteria);
            if (fields && fields.length) {

                // @ts-ignore
                creator.window.param = new nicico.FormUtil();

                // @ts-ignore
                creator.window.param.getButtonLayout = function () {

                    let This = this;
                    // @ts-ignore
                    let ok = isc.IButtonSave.create({
                        icon: null,
                        title: "<spring:message code='global.ok'/>",
                        // @ts-ignore
                        click: function () {

                            let data = This.populateData(This.bodyWidget.getObject());
                            if (!This.validate(data)) return;

                            This.windowWidget.getObject().close();
                            if (This.owner.getObject() != null)
                                This.owner.getObject().show();
                            This.okCallBack(data);
                        },
                    });
                    return isc.HLayout.create({

                        width: "100%",
                        padding: 10,
                        layoutMargin: 10,
                        membersMargin: 10,
                        edgeImage: "",
                        showEdges: false,
                        members: [ok]
                    });
                };
                // @ts-ignore
                creator.window.param.init(null, '<spring:message code="report.form.parameter"/>',
                    isc.DynamicForm.create({
                        width: "100%",
                        margin: 10,
                        numCols: 4,
                        padding: 10,
                        titleWidth: 130,
                        showErrorText: true,
                        showErrorStyle: true,
                        showInlineErrors: true,
                        errorOrientation: "bottom",
                        autoDraw: false,
                        fields: fields
                    }),
                    "800");
                // @ts-ignore
                creator.window.param.validate = function () {

                    return this.bodyWidget.getObject().validate();
                };
                // @ts-ignore
                creator.window.param.okCallBack = function (data) {

                    // @ts-ignore
                    mainTabSet.getTab(mainTabSet.selectedTab).setPane(This.createVLayout(creator, report, reportCriteria));
                    // @ts-ignore
                    creator.window.param.windowWidget.getObject().destroy();
                };

            } else
                this.createVLayout(creator, report, reportCriteria);
        }

        private createVLayout(creator: JSPTabVariable, report: any, reportCriteria: isc.AdvancedCriteria = null): isc.VLayout {

            // @ts-ignore
            creator.variable.contextPath = creator.variable.url;
            // @ts-ignore
            creator.variable.url += "api/report-execute/";
            creator.listGrid.fields = report.reportFields.map(p => {
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
                    {name: "fields", type: "hidden"},
                    // @ts-ignore
                    {name: "headers", type: "hidden"},
                    // @ts-ignore
                    {name: "criteria", type: "hidden"},
                    // @ts-ignore
                    {name: "reportId", type: "hidden"}]
            });
            // @ts-ignore
            creator.dynamicForm.excel.hide();
            // @ts-ignore
            creator.method.exportExcel = function () {

                // @ts-ignore
                let initialcriteria = creator.listGrid.main.getInitialCriteria();

                // @ts-ignore
                let imlicitcriteria = creator.listGrid.main.getImplicitCriteria();

                let criteria = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: []
                };

                if (initialcriteria && !Object.keys(initialcriteria).length)
                    initialcriteria = null;
                if (initialcriteria)
                    criteria.criteria.add(initialcriteria);

                if (imlicitcriteria && !Object.keys(imlicitcriteria).length)
                    imlicitcriteria = null;
                if (imlicitcriteria)
                    criteria.criteria.add(imlicitcriteria);

                // @ts-ignore
                var fields = creator.listGrid.main.getFields().filter(q =>
                    q.name !== "groupTitle" &&
                    // @ts-ignore
                    q.name !== creator.listGrid.main.getRowNumberField().name &&
                    // @ts-ignore
                    q.name !== creator.listGrid.main.getCheckboxField().name);
                // @ts-ignore
                creator.dynamicForm.excel.setValue("reportId", report.id);
                // @ts-ignore
                creator.dynamicForm.excel.setValue("fields", fields.map(q => q.name));
                // @ts-ignore
                creator.dynamicForm.excel.setValue("headers", fields.map(q => q.title));
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
                    {name: "fileKey", type: "hidden"},
                    // @ts-ignore
                    {name: "type", type: "hidden"},
                    // @ts-ignore
                    {name: "criteria", type: "hidden"},
                    // @ts-ignore
                    {name: "reportId", type: "hidden"}]
            });
            // @ts-ignore
            creator.dynamicForm.print.hide();
            // @ts-ignore
            creator.method.print = function () {

                // @ts-ignore
                let initialCriteria = creator.listGrid.main.getInitialCriteria();
                if (initialCriteria && !Object.keys(initialCriteria).length)
                    initialCriteria = null;

                // @ts-ignore
                let implicitCriteria = creator.listGrid.main.getImplicitCriteria();
                if (implicitCriteria && !Object.keys(implicitCriteria).length)
                    implicitCriteria = null;

                let selectedIds = [];
                if (report.reportType === "OneRecord") {
                    // @ts-ignore
                    let record = creator.listGrid.main.getSelectedRecord();
                    if (!record) {

                        creator.dialog.notSelected();
                        return;
                    }
                    // @ts-ignore
                    selectedIds.add(record.id);
                }
                if (report.reportType === "SelectedRecords") {
                    // @ts-ignore
                    let records = creator.listGrid.main.getSelectedRecords();
                    if (!records || !records.length) {

                        creator.dialog.notSelected();
                        return;
                    }
                    // @ts-ignore
                    selectedIds.addAll(records.map(q => q.id));
                }


                let cr = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: []
                };
                if (initialCriteria)
                    cr.criteria.add(initialCriteria);
                if (implicitCriteria)
                    cr.criteria.add(implicitCriteria);
                // @ts-ignore
                selectedIds.removeEmpty();
                if (selectedIds && selectedIds.length)
                    cr.criteria.add({
                        fieldName: "id",
                        operator: "equals",
                        value: selectedIds
                    });

                let selectReportForm = new FormUtil();
                selectReportForm.getButtonLayout = function (): isc.HLayout {

                    let ThisForm = selectReportForm;
                    // @ts-ignore
                    let cancel = isc.IButtonCancel.create({

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
                    let ok = isc.IButtonSave.create({

                        // @ts-ignore
                        click: function () {

                            // @ts-ignore
                            let data = ThisForm.populateData(ThisForm.bodyWidget.getObject());
                            if (!ThisForm.validate(data)) return;

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
                    let slider = isc.Slider.create({
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
                            align: CommonUtil.getAlignByLang(),
                            members: [slider]
                        })]
                    });
                };
                selectReportForm.populateData = function (bodyWidget: isc.Canvas | Array<isc.Canvas>) {

                    // @ts-ignore
                    let data = bodyWidget.getSelectedValue();
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
                    }),
                    null, "300"
                );
                // @ts-ignore
                selectReportForm.actionWidget.getObject().getMember(0).setTitle("<spring:message code='global.form.print'/>");
                // @ts-ignore
                selectReportForm.actionWidget.getObject().getMember(0).setIcon("[SKIN]/actions/print.png");
                // @ts-ignore
                selectReportForm.bodyWidget.getObject().reloadData();
            };
            // @ts-ignore
            creator.method.showFilterBuilder = function (): void {

                // @ts-ignore
                let fetchDataUrl = creator.variable.contextPath + report.source.replaceAll(new RegExp("^/|/$"), '') + '/';
                // @ts-ignore
                let dataSource = isc.MyRestDataSource.nicico.getDefault(fetchDataUrl, report.reportFields.filter(q => q.canFilter).map(p => {
                    return {name: p.name, title: p.title, type: p.type, hidden: false};
                }));

                FilterFormUtil.okCallBack = function (criteria) {
                    // @ts-ignore
                    creator.listGrid.main.setCriteria(criteria);
                };
                // @ts-ignore
                FilterFormUtil.show(null, '<spring:message code="global.form.filter"/>' + " - " + report.title, dataSource, creator.listGrid.main.getCriteria(),"70%", "300");
            };
            BasicFormUtil.createDynamicForm = function (c) {
                // @ts-ignore
                c.dynamicForm.main = null;
            };
            BasicFormUtil.createListGrid = function (c) {

                let listGridFirstField = {name: null};
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
                    implicitCriteria: reportCriteria,
                    dataArrived: function (startRow: number, endRow: number): void {

                        this.autoFitFields();
                        this.Super("dataArrived", arguments);
                    }
                });
            };
            BasicFormUtil.createListGridMenu = function (c) {
                // @ts-ignore
                c.menu.main = isc.Menu.create({
                    width: 150,
                    items: [
                        {
                            icon: "pieces/16/refresh.png",
                            title: '<spring:message code="global.form.refresh"/>',
                            click: function () {
                                // @ts-ignore
                                c.method.refresh(c.listGrid.main)
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
            BasicFormUtil.createToolStrip = function (c) {
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
                        isc.ToolStrip.create(
                            {
                                width: "100%",
                                border: '0px',
                                align: CommonUtil.getAlignByLang(),
                                members: [
                                    // @ts-ignore
                                    isc.ToolStripButtonRefresh.create({
                                        // @ts-ignore
                                        actionType: ActionType.REFRESH,
                                        title: "<spring:message code='global.form.refresh'/>",
                                        click: function () {
                                            // @ts-ignore
                                            c.method.refresh(c.listGrid.main)
                                        }
                                    })
                                ]
                            })
                    ]
                });
            };

            let layout = BasicFormUtil.getDefaultBasicForm(creator, 'report-data/' + report.id);

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
        }

        public create(): isc.VLayout {
            let creator = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
            let report = JSON.parse('${Data_Report}');
            let reportCriteria;
            if ('${Report_Criteria}') {

                reportCriteria = JSON.parse('${Report_Criteria}');
                this.showParamForm(creator, report, reportCriteria);
                return;
            } else
                return this.createVLayout(creator, report);
        };
    }

//------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
