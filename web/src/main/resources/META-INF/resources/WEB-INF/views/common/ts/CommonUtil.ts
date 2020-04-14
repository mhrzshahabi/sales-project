//------------------------------------------ TS References -----------------------------------------

// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace evaluation {

    //----------------------------------------- Interfaces -----------------------------------------

    export interface Map<T> {
        [key: string]: T
    }

    export interface Criteria {

        operator: string,
        criteria: Array<CriteriaProperty>;
    }

    export interface CriteriaProperty {

        value: any;
        operator: string,
        fieldName: string;
    }

    //----------------------------------------- Interfaces ---------------------------------------//

    //------------------------------------------ Classes -------------------------------------------

    export class CommonUtil {

        constructor() {

            // @ts-ignore
            isc.Canvas.tag = null;
            // @ts-ignore
            isc.Canvas.evaluation = {};
            // @ts-ignore
            isc.Canvas.evaluation.changeProperties = function (canvas: isc.Canvas, propertyName: string, propertyValue: any): isc.Canvas {

                canvas[propertyName] = propertyValue;
                return canvas;
            };

            // @ts-ignore
            isc.Menu.evaluation = {};
            // @ts-ignore
            isc.Menu.evaluation.getDefault = function (...crudActions: any[]): isc.Menu {

                var menu = isc.Menu.create({

                    width: 150
                });

                if (crudActions.length === 0) return menu;

                menu.addData({

                    click: crudActions[0],
                    icon: "pieces/16/refresh.png",
                    title: '<spring:message code="global.form.refresh"/> ',
                });
                if (crudActions.length > 0)
                    menu.addData({

                        click: crudActions[1],
                        icon: "pieces/16/icon_add.png",
                        title: '<spring:message code="global.form.new"/>'
                    });
                if (crudActions.length > 1)
                    menu.addData({
                        click: crudActions[2],
                        icon: "pieces/16/icon_edit.png",
                        title: "<spring:message code='global.form.edit'/>"
                    });
                if (crudActions.length > 2)
                    menu.addData({
                        click: crudActions[3],
                        icon: "pieces/16/icon_delete.png",
                        title: '<spring:message code="global.form.remove"/>'
                    });

                if (crudActions.length > 3)
                    for (let i = 4; i < crudActions.length; i++)
                        menu.addData({
                            icon: crudActions[i].icon,
                            click: crudActions[i].click,
                            title: crudActions[i].title
                        });

                return menu;
            };

            // @ts-ignore
            isc.ListGrid.evaluation = {};
            // @ts-ignore
            isc.ListGrid.evaluation.changeFieldsProperties = function (listGrid: isc.ListGrid, fieldPropertyName: string, fieldPropertyValue: any): isc.ListGrid {

                // @ts-ignore
                listGrid.getItem(fieldPropertyName).setValue(fieldPropertyValue);
                return listGrid;
            };
            // @ts-ignore
            isc.ListGrid.evaluation.getDefault = function (fields: Array<Partial<isc.ListGridField>>, restDataSource?: isc.RestDataSource): isc.ListGrid {

                let listGridProperties: Partial<isc.ListGrid> = {};

                listGridProperties.width = "100%";
                listGridProperties.height = "100%";

                listGridProperties.sortField = 0;
                listGridProperties.dataPageSize = 50;
                listGridProperties.fetchDelay = 1000;
                listGridProperties.autoFetchData = true;

                listGridProperties.showFilterEditor = true;
                listGridProperties.filterOnKeypress = true;
                listGridProperties.canAutoFitFields = false;

                listGridProperties.selectionType = "single";
                listGridProperties.sortDirection = "descending";

                listGridProperties.groupByText = '<spring=message code="global.grid.groupByText" />';
                listGridProperties.autoFitAllText = '<spring=message code="global.grid.autoFitAllText" />';
                listGridProperties.freezeFieldText = '<spring=message code="global.grid.freezeFieldText" />';
                listGridProperties.filterUsingText = '<spring=message code="global.grid.filterUsingText" />';
                listGridProperties.autoFitFieldText = '<spring=message code="global.grid.autoFitFieldText" />';
                listGridProperties.configureSortText = '<spring=message code="global.grid.configureSortText" />';
                listGridProperties.sortFieldAscendingText = '<spring=message code="global.grid.sortFieldAscendingText" />';
                listGridProperties.sortFieldDescendingText = '<spring=message code="global.grid.sortFieldDescendingText" />';

                return this.createListGrid(listGridProperties, fields, restDataSource);
            };
            // @ts-ignore
            isc.ListGrid.evaluation.createListGrid = function (listGridProperties: Partial<isc.ListGrid>, fields: Array<Partial<isc.ListGridField>>, restDataSource?: isc.RestDataSource): isc.ListGrid {

                let listGrid = isc.ListGrid.create(listGridProperties);
                listGrid.fields = fields;
                listGrid.dataSource = restDataSource;
                return listGrid;
            };

            // @ts-ignore
            isc.RestDataSource.evaluation = {};
            // @ts-ignore
            isc.RestDataSource.evaluation.getDefault = function (fetchDataUrl: string, fields: Array<Partial<isc.DataSourceField>>): isc.RestDataSource {

                let restDataSourceProperties: Partial<isc.RestDataSource> = {};

                restDataSourceProperties.jsonPrefix = "";
                restDataSourceProperties.jsonSuffix = "";
                restDataSourceProperties.dataFormat = "json";
                // @ts-ignore
                restDataSourceProperties.transformRequest = function (dsRequest) {

                    // @ts-ignore
                    dsRequest.httpHeaders = EvaluationConfigs.httpHeaders;
                    return this.Super("transformRequest", arguments);
                };
                return this.createRestDataSource(restDataSourceProperties, fetchDataUrl, fields);
            };
            // @ts-ignore
            isc.RestDataSource.evaluation.changeFieldsProperties = function (restDataSource: isc.RestDataSource, fieldPropertyName: string, fieldPropertyValue: any): isc.RestDataSource {

                // @ts-ignore
                restDataSource.fields[fieldPropertyName] = fieldPropertyValue;
                return restDataSource;
            };
            // @ts-ignore
            isc.RestDataSource.evaluation.createRestDataSource = function (restDataSourceProperties: Partial<isc.RestDataSource>, fetchDataUrl: string, fields: Array<Partial<isc.DataSourceField>>): isc.RestDataSource {

                let restDataSource = isc.RestDataSource.create(restDataSourceProperties);
                restDataSource.fields = fields;
                restDataSource.fetchDataURL = fetchDataUrl;
                return restDataSource;
            };

            // @ts-ignore
            isc.FormItem.evaluation = {};
            // @ts-ignore
            isc.FormItem.evaluation.getDefaultProperties = function (name: string, title: string, required?: boolean | Criteria = true, readonly?: boolean | Criteria, validators?: Array<Partial<Validator>>, id?: string): Partial<isc.FormItem> {

                let formItemProperties: Partial<isc.FormItem> = {};

                formItemProperties.ID = id;
                formItemProperties.name = name;
                formItemProperties.title = title;
                if (!title)
                    formItemProperties.showTitle = false;
                if (name == "id" || name == "version") {

                    formItemProperties.hidden = true;
                    formItemProperties.canEdit = false;
                }
                if (required instanceof Boolean) {
                    formItemProperties.required = <boolean>required;
                } else
                    formItemProperties.requiredWhen = <Criteria>required;
                if (readonly instanceof Boolean)
                // @ts-ignore
                    formItemProperties.readonly = <boolean>readonly;
                else
                // @ts-ignore
                    formItemProperties.readonlyWhen = <Criteria>readonly;
                formItemProperties.validators = validators;

                formItemProperties.width = "100%";

                formItemProperties.rowSpan = 1;

                formItemProperties.colSpan = 2;

                formItemProperties.wrapTitle = false;
                formItemProperties.selectOnFocus = true;
                formItemProperties.shouldSaveValue = true;

                formItemProperties.stopOnError = true;
                formItemProperties.showErrorIcon = true;
                formItemProperties.showErrorText = true;
                formItemProperties.showErrorStyle = true;
                formItemProperties.validateOnExit = true;
                formItemProperties.errorOrientation = "bottom";

                formItemProperties.align = "right";
                formItemProperties.textAlign = "right";
                formItemProperties.titleAlign = "right";
                formItemProperties.requiredMessage = '<spring:message code="validator.field.is.required"/>';

                return formItemProperties;
            };


            // TODO : put your fields template here, like below
            // @ts-ignore
            isc.FormItem.evaluation.getDefaultPersianDate = function (name: string, title: string, required?: boolean | Criteria = true, readonly?: boolean | Criteria, validators?: Array<Partial<Validator>>, id?: string): isc.FormItem {

                let formItemProperties = this.getDefaultProperties(name, title, required, readonly, validators, id);

                // @ts-ignore
                formItemProperties.type = 'persianDate';
                formItemProperties.hint = "1398/03/25";

                // @ts-ignore
                formItemProperties.icons = [persianDatePicker];

                return this.createFormItem(formItemProperties);
            };


            // @ts-ignore
            isc.FormItem.evaluation.createFormItem = function (formItemProperties: Partial<isc.FormItem>): isc.FormItem {

                return isc.FormItem.create(formItemProperties);
            };

            // @ts-ignore
            isc.DynamicForm.evaluation = {};
            // @ts-ignore
            isc.DynamicForm.evaluation.getDefault = function (fields: Array<Partial<isc.FormItem>>, id?: string): isc.DynamicForm {

                let dynamicFormProperties: Partial<isc.DynamicForm> = {};

                dynamicFormProperties.ID = id;
                dynamicFormProperties.numCols = 2;
                dynamicFormProperties.margin = 10;
                dynamicFormProperties.cellPadding = 3;
                dynamicFormProperties.width = "100%";
                dynamicFormProperties.titleWidth = "*";
                dynamicFormProperties.titleAlign = "right";
                dynamicFormProperties.colWidths = ["30%", "70%"];

                dynamicFormProperties.canSubmit = true;
                dynamicFormProperties.wrapItemTitles = false;

                dynamicFormProperties.stopOnError = true;
                dynamicFormProperties.showErrorText = true;
                dynamicFormProperties.showErrorIcons = true;
                dynamicFormProperties.showErrorStyle = true;
                dynamicFormProperties.validateOnExit = true;
                dynamicFormProperties.showInlineErrors = true;
                dynamicFormProperties.errorOrientation = "bottom";
                dynamicFormProperties.requiredMessage = "<spring=message code='validator.field.is.required'/>";

                return this.createDynamicForm(dynamicFormProperties, fields);
            };
            // @ts-ignore
            isc.DynamicForm.evaluation.changeFieldsProperties = function (dynamicForm: isc.DynamicForm, fieldPropertyName: string, fieldPropertyValue: any): isc.DynamicForm {

                // @ts-ignore
                dynamicForm.fields[fieldPropertyName] = fieldPropertyValue;
                return dynamicForm;
            };
            // @ts-ignore
            isc.DynamicForm.evaluation.createDynamicForm = function (dynamicFormProperties: Partial<isc.DynamicForm>, fields: Array<Partial<isc.FormItem>>): isc.DynamicForm {

                let dynamicForm = isc.DynamicForm.create(dynamicFormProperties);
                dynamicForm.fields = fields;
                return dynamicForm;
            };

            // @ts-ignore
            isc.Window.evaluation = {};
            // @ts-ignore
            isc.Window.evaluation.getDefault = function (title: string, items: Array<isc.Canvas>, id?: string): isc.Window {

                return isc.Window.create({

                    ID: id,
                    width: "50%",
                    align: "center",
                    isModal: true,
                    autoSize: true,
                    autoDraw: false,
                    autoCenter: true,
                    showModalMask: true,
                    dismissOnEscape: true,
                    title: title,
                    // @ts-ignore
                    closeClick: function () {

                        this.Super("closeClick", arguments)
                    },
                    items: [
                        isc.VLayout.create({

                            width: "100%",
                            height: "100%",
                            members: items
                        })
                    ]
                });
            };

            // @ts-ignore
            isc.HTMLFlow.evaluation = {};
            // @ts-ignore
            isc.HTMLFlow.evaluation.getDefault = function (content: string): isc.HTMLFlow {

                return isc.HTMLFlow.create({
                    // @ts-ignore
                    content: content
                });
            };

            // @ts-ignore
            isc.IButton.evaluation = {};
            // @ts-ignore
            isc.IButton.evaluation.getDefault = function (title: string, icon: string, action: any): isc.IButton {

                return isc.IButton.create({

                    icon: icon,
                    title: title,
                    // @ts-ignore
                    click: function () {
                        action();
                    }
                });
            };

            // @ts-ignore
            isc.HLayout.evaluation = {};
            // @ts-ignore
            isc.HLayout.evaluation.getDefault = function (items: Array<isc.Canvas>, id?: string): isc.HLayout {

                return isc.HLayout.create({

                    ID: id,
                    width: "100%",
                    padding: 10,
                    layoutMargin: 5,
                    membersMargin: 10,
                    showEdges: false,
                    members: items
                });
            };
            // @ts-ignore
            isc.HLayout.evaluation.getSaveLayout = function (saveAction: any, id?: string): isc.HLayout {

                // @ts-ignore
                var saveLayout = isc.HLayout.getDefault(id);
                // @ts-ignore
                saveLayout.addMember(isc.IButtonSave.getDefault('<spring:message code="global.form.save"/> ', "pieces/16/save.png", saveAction));
                // @ts-ignore
                saveLayout.addMember(isc.IButtonCancel.getDefault('<spring:message code="global.close"/> ', "pieces/16/icon_delete.png", function () {

                    var win = this.getParentElements().last();
                    win.close();
                }));
                return saveLayout;
            };

            // @ts-ignore
            isc.VLayout.evaluation = {};
            // @ts-ignore
            isc.VLayout.evaluation.getDefault = function (items: Array<isc.Canvas>, id?: string): isc.VLayout {

                return isc.VLayout.create({

                    ID: id,
                    width: "100%",
                    members: items
                });
            };

            // @ts-ignore
            isc.Label.evaluation = {};
            // @ts-ignore
            isc.Label.evaluation.getDefault = function (content: string, id?: string): isc.Label {

                return isc.Label.create({

                    height: "5%",
                    contents: content
                });
            };

            // @ts-ignore
            isc.ToolStripButton.evaluation = {};
            // @ts-ignore
            isc.ToolStripButton.evaluation.getDefault = function (title: string, icon: string, clickAction: any): isc.ToolStripButton {

                return isc.ToolStripButton.create({

                    icon: icon,
                    title: title,
                    click: clickAction
                });
            };

            // @ts-ignore
            isc.ToolStrip.evaluation = {};
            // @ts-ignore
            isc.ToolStrip.evaluation.getDefault = function (...crudActions: any[], id?: string): isc.ToolStrip {

                var toolStrip = isc.ToolStrip.create({

                    ID: id,
                    width: "100%"
                });

                if (crudActions.length === 0) return toolStrip;

                // @ts-ignore
                toolStrip.addMember(isc.ToolStripButton.evaluation.getDefault('<spring:message code="global.form.refresh" />', "[SKIN]/actions/refresh.png", crudActions[0]));
                if (crudActions.length > 0)
                // @ts-ignore
                    toolStrip.addMember(isc.ToolStripButton.evaluation.getDefault('<spring:message code="global.form.new"/>', "[SKIN]/actions/add.png", crudActions[1]));
                if (crudActions.length > 1)
                // @ts-ignore
                    toolStrip.addMember(isc.ToolStripButton.evaluation.getDefault('<spring:message code="global.form.edit"/>', "[SKIN]/actions/edit.png", crudActions[2]));
                if (crudActions.length > 2)
                // @ts-ignore
                    toolStrip.addMember(isc.ToolStripButton.evaluation.getDefault('<spring:message code="global.form.remove"/>', "[SKIN]/actions/remove.png", crudActions[3]));

                if (crudActions.length > 3)
                    for (let i = 4; i < crudActions.length; i++)
                        // @ts-ignore
                        toolStrip.addMember(isc.ToolStripButton.evaluation.getDefault(crudActions[i].title, crudActions[i].icon, crudActions[i].click));

                return toolStrip;
            };

            // @ts-ignore
            isc.FacetChart.evaluation = {};
            // @ts-ignore
            isc.FacetChart.evaluation.getDefault = function (data: any, valueProperty: string, facets: Array<Partial<isc.Facet>>, title?: string, defaultChartType?: isc.ChartType, allowedChartTypes?: Array<isc.ChartType>, id?: string) {

                return isc.FacetChart.create({

                    ID: id,
                    width: "100%",
                    data: data,
                    title: title,
                    facets: facets,
                    valueProperty: valueProperty,
                    showTitle: title ? true : false,
                    // @ts-ignore
                    titleAlign: "right",
                    stacked: true,
                    centerTitle: true,
                    centerLegend: true,
                    titlePadding: true,
                    showDataPoints: true,
                    showDataValues: false,
                    showValueOnHover: true,
                    drawTitleBoundary: false,
                    drawTitleBackground: true,
                    hoverLabelPadding: -10,
                    chartType: defaultChartType || "Radar",
                    allowedChartTypes: allowedChartTypes || ["Area", "Line", "Column", "Bar", "Pie", "Doughnut", "Radar"]
                });
            };
            // @ts-ignore
            isc.FacetChart.evaluation.showChart = function (ownerWindow: isc.Window, title: string, chart: isc.FacetChart) {

                var windowWidget = isc.Window.create({

                    title: title,
                    width: "50%",
                    // @ts-ignore
                    height: window.innerHeight * .6,
                    align: "center",
                    items: [chart],
                    isModal: true,
                    autoSize: true,
                    autoDraw: false,
                    autoCenter: true,
                    showModalMask: true,
                    dismissOnEscape: false,
                    dismissOnOutsideClick: false,
                    tag: ownerWindow,
                    // @ts-ignore
                    closeClick: function () {
                        this.Super("closeClick", arguments);
                        if (this.tag != null) this.tag.show();
                    }
                });
                chart.setHeight(windowWidget.height);
                windowWidget.show();
            };

            // @ts-ignore
            Array.prototype.distinct = function <T>(): Array<T> {

                return this.filter((value: T, index: number, self: Array<T>) => self.indexOf(value) === index);
            };
            // @ts-ignore
            Array.prototype.weakDistinct = function <T>(): Array<T> {

                return this.filter((value: T, index: number, self: Array<T>) => {

                    for (let i: number = 0; i < index; i++)
                        if (self[i] === value)
                            return false;
                    return true;
                });
            };
            // @ts-ignore
            Array.prototype.groupBy = function <T>(key: string): Map<any, Array<T>> {

                if (key == null || this == null || this.length === 0) return {};
                return this.reduce(function (group, current) {

                    let groupData = eval("current." + key);
                    (group[groupData] = group[groupData] || []).push(current);
                    return group;
                }, {});
            };
            // @ts-ignore
            Array.prototype.sumByField = function (key: string): Number {

                if (key == null || this == null || this.length === 0) return NaN;
                return this.map(q => q[key]).sum();
            };
        }
    }

    export class ObjectHider<T> {

        private _hider: T;

        constructor(hider: T) {

            this._hider = hider;
        }

        getObject(): T {

            return this._hider;
        }
    }

//------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
