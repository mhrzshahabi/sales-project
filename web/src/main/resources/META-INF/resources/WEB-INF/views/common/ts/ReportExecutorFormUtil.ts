//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>
///<reference path="FormUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>
///<reference path="FilterFormUtil.ts"/>

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

    //------------------------------------------ Classes -------------------------------------------

    export class ReportExecutorFormUtil {

        private static createFields(recordCriteria, report): Array<isc.FormItem> {

            // @ts-ignore
            if (!recordCriteria || !recordCriteria.length)
                return [];

            let fields = [];
            // @ts-ignore
            for (let i = 0; i < recordCriteria.length; i++) {

                // @ts-ignore
                if (!recordCriteria[i])
                    break;
                // @ts-ignore
                else if (recordCriteria[i]._constructor === "AdvancedCriteria")
                // @ts-ignore
                    fields.addAll(this.createFields(recordCriteria[i].criteria, report));
                // @ts-ignore
                else if (recordCriteria[i].value === "?") {
                    // @ts-ignore
                    recordCriteria[i].value = null;

                    // @ts-ignore
                    let findField = report.reportFields.find(p => p.name === recordCriteria[i].fieldName);
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
                            hint: FilterBuilderOperator[recordCriteria[i].operator],
                            // @ts-ignore
                            criteria: recordCriteria[i],
                            changed: function (form, item, value) {

                                this.criteria.value = value;
                            }
                        });
                }
            }

            return fields;
        }

        private static showFilterBuilder(allowCreateForm: boolean, owner: isc.Window, creator: JSPTabVariable, record: Object, okCallBack: any): void {

            // @ts-ignore
            let fetchDataUrl = creator.variable.contextPath + record.source.replaceAll(new RegExp("^/|/$"), '') + '/';
            // @ts-ignore
            let dataSource = isc.MyRestDataSource.nicico.getDefault(fetchDataUrl, record.reportFields.filter(q => q.canFilter).map(p => {
                return {name: p.name, title: p.title, type: p.type, hidden: false};
            }));

            FilterFormUtil.okCallBack = okCallBack;
            FilterFormUtil.validate = function (criteria: isc.AdvancedCriteria) {

                // @ts-ignore
                return !creator.dynamicForm.param || creator.dynamicForm.param.validate();
            };
            FilterFormUtil.createWindow = function (creatorFilterForm: JSPTabVariable, title: string): void {

                // @ts-ignore
                if (ReportExecutorFormUtil.createDynamicForm(allowCreateForm, creator, record)) {

                    // @ts-ignore
                    creatorFilterForm.window.main = isc.Window.nicico.getDefault(title, [
                        // @ts-ignore
                        creatorFilterForm.filterBuilder.main, creator.dynamicForm.param, creatorFilterForm.hLayout.main
                    ], "70%", "600");
                } else
                // @ts-ignore
                    creatorFilterForm.window.main = isc.Window.nicico.getDefault(title, [
                        // @ts-ignore
                        creatorFilterForm.filterBuilder.main, creatorFilterForm.hLayout.main
                    ], null, "300");
            };
            // @ts-ignore
            FilterFormUtil.show(owner, '<spring:message code="global.form.filter"/>' + " - " + record.title, dataSource);
        }

        private static createDynamicForm(allowCreateForm: boolean, creator: JSPTabVariable, record: Object): void {

            // @ts-ignore
            creator.dynamicForm.param = null;
            // @ts-ignore
            creator.variable.recordCriteria = record.criteria != null ? JSON.parse(record.criteria) : null;
            // @ts-ignore
            let fields = ReportExecutorFormUtil.createFields(creator.variable.recordCriteria ? creator.variable.recordCriteria.criteria : [], record);
            if (allowCreateForm && fields && fields.length) {
                // @ts-ignore
                creator.dynamicForm.param = isc.DynamicForm.create({
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
                });
            }
            // @ts-ignore
            return creator.dynamicForm.param;
        }

        static cancelCallBack: any = function () {

            return;
        };

        static createRestDataSource(creator: JSPTabVariable): void {
            // @ts-ignore
            creator.restDataSource.main = isc.MyRestDataSource.nicico.getDefault(creator.variable.url + "report-with-permission", [], creator.method.transformRequest);
        }

        static createListGrid(creator: JSPTabVariable): void {

            // @ts-ignore
            creator.listGrid.main = isc.ListGrid.nicico.getDefault([
                    {
                        name: "id",
                        title: "<spring:message code='global.id'/>",
                        primaryKey: true,
                        canEdit: false,
                        hidden: true
                    },
                    {name: "title", title: "<spring:message code='report.title'/>"},
                    {name: "source", title: "<spring:message code='report.source'/>", hidden: true},
                    {name: "name", title: "<spring:message code='report.name'/>"},
                    {name: "reportGroup.name", title: "<spring:message code='report.group.name'/>"},
                    {name: "view", width: "100", align: "center", title: "<spring:message code='report.preview'/>"}
                ],
                // @ts-ignore
                creator.restDataSource.main,
                // @ts-ignore
                creator.variable.criteria,
                {
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
                                    let record = creator.listGrid.main.getSelectedRecord();
                                    if (record == null) {

                                        creator.dialog.notSelected();
                                        return;
                                    }
                                    if (!record.printAccess) {

                                        creator.dialog.say("<spring:message code='exception.access-denied'/>");
                                        return;
                                    }

                                    // @ts-ignore
                                    ReportExecutorFormUtil.showFilterBuilder(true, creator.window.main, creator, record, (criteria) => {

                                        let crt = {
                                            _constructor: "AdvancedCriteria",
                                            operator: "and",
                                            criteria: []
                                        };

                                        if (criteria && !Object.keys(criteria).length)
                                            criteria = null;
                                        if (criteria)
                                            crt.criteria.add(criteria);

                                        // @ts-ignore
                                        if (creator.variable.recordCriteria && !Object.keys(creator.variable.recordCriteria).length)
                                        // @ts-ignore
                                            creator.variable.recordCriteria = null;
                                        // @ts-ignore
                                        if (creator.variable.recordCriteria)
                                        // @ts-ignore
                                            crt.criteria.add(creator.variable.recordCriteria);

                                        let fields = record.reportFields.filter(q => !q.hidden);
                                        // @ts-ignore
                                        creator.dynamicForm.excel.setValue("reportId", record.id);
                                        // @ts-ignore
                                        creator.dynamicForm.excel.setValue("fields", fields.map(q => q.name));
                                        // @ts-ignore
                                        creator.dynamicForm.excel.setValue("headers", fields.map(q => q.title));
                                        // @ts-ignore
                                        creator.dynamicForm.excel.setValue("criteria", JSON.stringify(crt));
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
                                    let record = creator.listGrid.main.getSelectedRecord();
                                    if (record == null) {

                                        creator.dialog.notSelected();
                                        return;
                                    }
                                    if (!record.printAccess) {

                                        creator.dialog.say("<spring:message code='exception.access-denied'/>");
                                        return;
                                    }

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
                                        let filter = isc.IButtonSave.create({

                                            // @ts-ignore
                                            click: function () {

                                                // @ts-ignore
                                                ReportExecutorFormUtil.showFilterBuilder(false, ThisForm.windowWidget.getObject(), creator, record, (criteria) => {
                                                    // @ts-ignore
                                                    ThisForm.bodyWidget.getObject()[0].criteria = criteria;
                                                });
                                            },
                                            icon: "[SKIN]/actions/filter.png",
                                            title: '<spring:message code="global.form.filter" />'
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
                                                ThisForm.bodyWidget.getObject()[0].slider = value;
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
                                            }), isc.HLayout.create({
                                                align: CommonUtil.getAlignByLang(),
                                                members: [filter]
                                            })]
                                        });
                                    };
                                    selectReportForm.populateData = function (bodyWidget: isc.Canvas | Array<isc.Canvas>) {

                                        // @ts-ignore
                                        let data = bodyWidget[0].getSelectedValue();
                                        return data ? {
                                            fileId: data.id,
                                            fileKey: data.fileKey,
                                            // @ts-ignore
                                            type: bodyWidget[0].slider === 2 ? "EXCEL" : "PDF",
                                            // @ts-ignore
                                            criteria: bodyWidget[0].criteria,
                                        } : null;
                                    };
                                    selectReportForm.validate = function (data) {

                                        let isValid = data && data.fileKey;
                                        if (!isValid)
                                            creator.dialog.notSelected();
                                        // @ts-ignore
                                        isValid = !!isValid && (!creator.dynamicForm.param || creator.dynamicForm.param.validate());

                                        return isValid;
                                    };
                                    selectReportForm.okCallBack = function (data) {

                                        let crt = {
                                            _constructor: "AdvancedCriteria",
                                            operator: "and",
                                            criteria: []
                                        };

                                        if (data.criteria && !Object.keys(data.criteria).length)
                                            data.criteria = null;
                                        if (data.criteria)
                                            crt.criteria.add(data.criteria);

                                        // @ts-ignore
                                        if (creator.variable.recordCriteria && !Object.keys(creator.variable.recordCriteria).length)
                                        // @ts-ignore
                                            creator.variable.recordCriteria = null;
                                        // @ts-ignore
                                        if (creator.variable.recordCriteria)
                                        // @ts-ignore
                                            crt.criteria.add(creator.variable.recordCriteria);
                                        // @ts-ignore
                                        creator.dynamicForm.print.setValue("reportId", record.id);
                                        // @ts-ignore
                                        creator.dynamicForm.print.setValue("fileKey", data.fileKey);
                                        // @ts-ignore
                                        creator.dynamicForm.print.setValue("type", data.type);
                                        // @ts-ignore
                                        creator.dynamicForm.print.setValue("criteria", JSON.stringify(crt));
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
                                    if (ReportExecutorFormUtil.createDynamicForm(true, creator, record))
                                    // @ts-ignore
                                        selectReportForm.showForm(creator.window.main, "<spring:message code='global.form.print'/>" + " - " + record.title, [
                                                // @ts-ignore
                                                isc.FileUploadForm.create({
                                                    accept: ".jasper",
                                                    entityName: "Report",
                                                    recordId: record.id,
                                                    canAddFile: false,
                                                    canRemoveFile: false,
                                                    canDownloadFile: false,
                                                    height: "100%",
                                                    margin: 5
                                                }),
                                                // @ts-ignore
                                                creator.dynamicForm.param
                                            ],
                                            "70%", "500"
                                        );
                                    else
                                    // @ts-ignore
                                        selectReportForm.showForm(creator.window.main, "<spring:message code='global.form.print'/>" + " - " + record.title, [
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
                                                })
                                            ],
                                            null, "300"
                                        );
                                    // @ts-ignore
                                    selectReportForm.actionWidget.getObject().getMember(0).setTitle("<spring:message code='global.form.print'/>");
                                    // @ts-ignore
                                    selectReportForm.actionWidget.getObject().getMember(0).setIcon("[SKIN]/actions/print.png");
                                    // @ts-ignore
                                    selectReportForm.bodyWidget.getObject()[0].reloadData();
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
        }

        static createWindow(creator: nicico.JSPTabVariable, title: string): void {
            // @ts-ignore
            creator.window.main = isc.Window.nicico.getDefault(title, [
                // @ts-ignore
                creator.listGrid.main
            ], "60%");
        }

        static createExcelSubmitForm(creator: nicico.JSPTabVariable) {

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
        }

        static createPrintSubmitForm(creator: nicico.JSPTabVariable) {

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
        }

        static show(owner: isc.Window, title: string, criteria: string, createTab: any) {

            let creator = new GeneralTabUtil().getDefaultJSPTabVariable();
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
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
