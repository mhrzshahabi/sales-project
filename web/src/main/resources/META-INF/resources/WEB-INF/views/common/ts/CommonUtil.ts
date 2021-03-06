//------------------------------------------ TS References -----------------------------------------

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

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

        static sleep: any;
        static getAlignByLang: any;
        static getAlignByLangReverse: any;

        static getLang: any;

        constructor() {

            CommonUtil.sleep = function (milis: number) {

                let start = Date.now();
                while (true) {

                    let clock = (Date.now() - start);
                    if (clock >= milis)
                        break;
                }
            };

            CommonUtil.getAlignByLang = function () {
                return "left";
            };

            CommonUtil.getAlignByLangReverse = function () {
                return "right";
            };

            CommonUtil.getLang = function () {
                return "fa";
            };

            // @ts-ignore
            isc.Canvas.tag = null;
            // @ts-ignore
            isc.Canvas.nicico = {};
            // @ts-ignore
            isc.Canvas.nicico.changeProperties = function (canvas: isc.Canvas, propertyName: string, propertyValue: any): isc.Canvas {

                canvas[propertyName] = propertyValue;
                return canvas;
            };

            // @ts-ignore
            isc.ListGrid.nicico = {};
            // @ts-ignore
            isc.ListGrid.nicico.getDefault = function (fields: Array<Partial<isc.ListGridField>>, restDataSource?: isc.MyRestDataSource, criteria?: Criteria, extraProperties: Partial<isc.ListGrid>): isc.ListGrid {

                let listGridProperties: Partial<isc.ListGrid> = {};

                listGridProperties.width = "100%";
                listGridProperties.height = "100%";

                listGridProperties.initialCriteria = criteria;

                listGridProperties.dataPageSize = 50;
                listGridProperties.fetchDelay = 1000;
                listGridProperties.autoFetchData = true;

                listGridProperties.showRowNumbers = true;
                listGridProperties.showFilterEditor = true;
                listGridProperties.filterOnKeypress = false;
                listGridProperties.canAutoFitFields = false;
                // @ts-ignore
                listGridProperties.allowAdvancedCriteria = true;
                listGridProperties.alternateRecordStyles = true;

                listGridProperties.selectionType = "single";
                listGridProperties.sortDirection = "descending";
                listGridProperties.sortField = "id";
                listGridProperties.groupByText = '<spring:message code="global.grid.groupByText" />';
                listGridProperties.autoFitAllText = '<spring:message code="global.grid.autoFitAllText" />';
                listGridProperties.freezeFieldText = '<spring:message code="global.grid.freezeFieldText" />';
                listGridProperties.filterUsingText = '<spring:message code="global.grid.filterUsingText" />';
                listGridProperties.autoFitFieldText = '<spring:message code="global.grid.autoFitFieldText" />';
                listGridProperties.configureSortText = '<spring:message code="global.grid.configureSortText" />';
                listGridProperties.sortFieldAscendingText = '<spring:message code="global.grid.sortFieldAscendingText" />';
                listGridProperties.sortFieldDescendingText = '<spring:message code="global.grid.sortFieldDescendingText" />';

                // @ts-ignore
                return this.createListGrid(Object.assign(listGridProperties, extraProperties), fields, restDataSource);
            };
            // @ts-ignore
            isc.ListGrid.nicico.createListGrid = function (listGridProperties: Partial<isc.ListGrid>, fields: Array<Partial<isc.ListGridField>>, restDataSource?: isc.MyRestDataSource): isc.ListGrid {

                return fields ?
                    // @ts-ignore
                    isc.ListGrid.create(Object.assign(listGridProperties, {
                        fields: fields,
                        dataSource: restDataSource
                    })) :
                    // @ts-ignore
                    isc.ListGrid.create(Object.assign(listGridProperties, {
                        dataSource: restDataSource
                    }));
            };

            // @ts-ignore
            isc.MyRestDataSource.nicico = {};
            // @ts-ignore
            isc.MyRestDataSource.nicico.getDefault = function (fetchDataUrl: string, fields: Array<Partial<isc.DataSourceField>>, transformRequest: any = null): isc.MyRestDataSource {
                // @ts-ignore
                let restDataSourceProperties: Partial<isc.MyRestDataSource> = {};

                restDataSourceProperties.jsonPrefix = "";
                restDataSourceProperties.jsonSuffix = "";
                restDataSourceProperties.dataFormat = "json";
                if (transformRequest != null)
                    restDataSourceProperties.transformRequest = transformRequest;
                else
                    // @ts-ignore
                    restDataSourceProperties.transformRequest = function (dsRequest) {

                        // @ts-ignore
                        dsRequest.httpHeaders = BaseRPCRequest.httpHeaders;
                        return this.Super("transformRequest", arguments);
                    };
                return this.createRestDataSource(restDataSourceProperties, fetchDataUrl, fields);
            };
            // @ts-ignore
            isc.MyRestDataSource.nicico.createRestDataSource = function (restDataSourceProperties: Partial<isc.MyRestDataSource>, fetchDataUrl: string, fields: Array<Partial<isc.DataSourceField>>): isc.MyRestDataSource {

                // @ts-ignore
                return isc.MyRestDataSource.create(Object.assign(restDataSourceProperties, {
                    fields: fields,
                    fetchDataURL: fetchDataUrl
                }));
            };

            // @ts-ignore
            isc.FormItem.nicico = {};
            // @ts-ignore
            isc.FormItem.nicico.getDefaultProperties = function (name: string, title: string, type: FormItemType, editorType: string, required?: boolean | Criteria = true, readonly?: boolean | Criteria, validators?: Array<Partial<Validator>>, id?: string): Partial<isc.FormItem> {

                let formItemProperties: Partial<isc.FormItem> = {};

                formItemProperties.ID = id;
                formItemProperties.name = name;
                formItemProperties.type = type;
                formItemProperties.title = title;
                formItemProperties.editorType = editorType;
                if (!title)
                    formItemProperties.showTitle = false;
                if (name == "id" || name == "version" || name == "editable") {

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

                // @ts-ignore
                formItemProperties.showInlineErrors = true;
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
            // @ts-ignore
            isc.FormItem.nicico.createFormItem = function (formItemProperties: Partial<isc.FormItem>): isc.FormItem {

                return isc.FormItem.create(formItemProperties);
            };

            // @ts-ignore
            isc.DynamicForm.nicico = {};
            // @ts-ignore
            isc.DynamicForm.nicico.getDefault = function (fields: Array<Partial<isc.FormItem>>, id?: string): isc.DynamicForm {

                let dynamicFormProperties: Partial<isc.DynamicForm> = {};

                dynamicFormProperties.ID = id;
                dynamicFormProperties.numCols = 2;
                dynamicFormProperties.margin = 10;
                dynamicFormProperties.cellPadding = 3;
                dynamicFormProperties.width = "100%";
                dynamicFormProperties.titleWidth = "*";
                dynamicFormProperties.colWidths = ["30%", "70%"];

                dynamicFormProperties.canSubmit = true;
                dynamicFormProperties.wrapItemTitles = false;

                // @ts-ignore
                dynamicFormProperties.showInlineErrors = true;
                dynamicFormProperties.stopOnError = true;
                dynamicFormProperties.showErrorText = true;
                dynamicFormProperties.showErrorIcons = true;
                dynamicFormProperties.showErrorStyle = true;
                dynamicFormProperties.validateOnExit = true;
                dynamicFormProperties.showInlineErrors = true;
                dynamicFormProperties.errorOrientation = "bottom";
                dynamicFormProperties.requiredMessage = '<spring:message code="validator.field.is.required"/>';

                return this.createDynamicForm(dynamicFormProperties, fields);
            };
            // @ts-ignore
            isc.DynamicForm.nicico.createDynamicForm = function (dynamicFormProperties: Partial<isc.DynamicForm>, fields: Array<Partial<isc.FormItem>>): isc.DynamicForm {

                // @ts-ignore
                return isc.DynamicForm.create(Object.assign(dynamicFormProperties, {
                    fields: fields
                }));
            };

            // @ts-ignore
            isc.Window.nicico = {};
            // @ts-ignore
            isc.Window.nicico.getDefault = function (title: string, items: Array<isc.Canvas>, width: string = null, height: string = null, id?: string): isc.Window {

                return isc.Window.create({

                    ID: id,
                    width: width == null ? "70%" : width,
                    height: height,
                    align: "center",
                    isModal: true,
                    autoSize: true,
                    autoDraw: false,
                    autoCenter: true,
                    showModalMask: true,
                    dismissOnEscape: true,
                    dismissOnOutsideClick: false,
                    title: title,
                    canDragResize: true,
                    // @ts-ignore
                    closeClick: function () {

                        this.Super("closeClick", arguments);
                    },
                    items: [
                        isc.VLayout.create({

                            width: "100%",
                            height: height,
                            layoutMargin: 5,
                            membersMargin: 5,
                            members: items
                        })
                    ]
                });
            };
            // @ts-ignore
            isc.Window.nicico.getDefault2 = function (title: string, layout: isc.Canvas, width: string = null, height: string = null, id?: string): isc.Window {

                return isc.Window.create({

                    ID: id,
                    width: width == null ? "70%" : width,
                    height: height,
                    title: title,
                    items: [layout],
                    align: "center",
                    isModal: true,
                    autoSize: true,
                    autoDraw: false,
                    autoCenter: true,
                    showModalMask: true,
                    dismissOnEscape: true,
                    dismissOnOutsideClick: true,
                    // @ts-ignore
                    closeClick: function () {

                        this.Super("closeClick", arguments);
                    }
                });
            };

            // @ts-ignore
            isc.FacetChart.nicico = {};
            // @ts-ignore
            isc.FacetChart.nicico.getDefault = function (data: any, valueProperty: string, facets: Array<Partial<isc.Facet>>, title?: string, defaultChartType?: isc.ChartType, allowedChartTypes?: Array<isc.ChartType>, id?: string) {

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
            isc.FacetChart.nicico.showChart = function (ownerWindow: isc.Window, title: string, chart: isc.FacetChart) {

                let windowWidget = isc.Window.create({

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
                    // @ts-ignore
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
            isc.FilterBuilder.nicico = {};
            // @ts-ignore
            isc.FilterBuilder.nicico.getDefault = function (restDataSource?: isc.MyRestDataSource) {
                return isc.FilterBuilder.create({
                    // @ts-ignore
                    dataSource: restDataSource,
                    fieldPickerWidth: "200", valueItemWidth: "400",
                    width: "100%"
                });
            };

            // @ts-ignore
            Array.prototype.distinct = function <T>(): Array<T> {

                return this.filter((value: T, index: number, self: Array<T>) => self.indexOf(value) === index);
            };
            // @ts-ignore
            Array.prototype.uniqueObject = function <T>(key: string): Array<T> {

                return this.filter((value: T, index: number, self: Array<T>) => {

                    for (let i: number = 0; i < index; i++)
                        if (self[i][key] == value[key])
                            return false;
                    return true;
                });
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
            Array.prototype.weakUniqueObject = function <T>(key: string): Array<T> {

                return this.filter((value: T, index: number, self: Array<T>) => {

                    for (let i: number = 0; i < index; i++)
                        if (self[i][key] === value[key])
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
            // @ts-ignore
            Array.prototype.evalPropertyPath = function (obj) {
                return this.reduce(function (prev, curr) {
                    return prev ? prev[curr] : null
                }, obj || self)
            };

            // @ts-ignore
            String.prototype.propertyNameToCamelCaseWithSpace = function () {

                let res = '';
                this
                    .replace(/\.(.)/g, function ($1) {
                        return $1.toUpperCase();
                    })
                    .replace(/\./g, ' ')
                    .replace(/^(.)/, function ($1) {
                        return $1.toUpperCase();
                    })
                    .split('').forEach(l => {
                    if (l == l.toUpperCase()) res += ' ';
                    res += l;
                });

                return res.replace(/  /g, ' ');
            }
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
