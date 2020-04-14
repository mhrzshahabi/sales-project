//------------------------------------------ CommonUtil --------------------------------------------

//------------------------------------------ TS References -----------------------------------------
// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var evaluation;
(function (evaluation) {
    //----------------------------------------- Interfaces -----------------------------------------
    //----------------------------------------- Interfaces ---------------------------------------//
    //------------------------------------------ Classes -------------------------------------------
    var CommonUtil = /** @class */ (function () {
        function CommonUtil() {
            // @ts-ignore
            isc.Canvas.tag = null;
            // @ts-ignore
            isc.Canvas.evaluation = {};
            // @ts-ignore
            isc.Canvas.evaluation.changeProperties = function (canvas, propertyName, propertyValue) {
                canvas[propertyName] = propertyValue;
                return canvas;
            };
            // @ts-ignore
            isc.Menu.evaluation = {};
            // @ts-ignore
            isc.Menu.evaluation.getDefault = function () {
                var crudActions = [];
                for (var _i = 0; _i < arguments.length; _i++) {
                    crudActions[_i] = arguments[_i];
                }
                var menu = isc.Menu.create({
                    width: 150
                });
                if (crudActions.length === 0)
                    return menu;
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
                    for (var i = 4; i < crudActions.length; i++)
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
            isc.ListGrid.evaluation.changeFieldsProperties = function (listGrid, fieldPropertyName, fieldPropertyValue) {
                // @ts-ignore
                listGrid.getItem(fieldPropertyName).setValue(fieldPropertyValue);
                return listGrid;
            };
            // @ts-ignore
            isc.ListGrid.evaluation.getDefault = function (fields, restDataSource) {
                var listGridProperties = {};
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
            isc.ListGrid.evaluation.createListGrid = function (listGridProperties, fields, restDataSource) {
                var listGrid = isc.ListGrid.create(listGridProperties);
                listGrid.fields = fields;
                listGrid.dataSource = restDataSource;
                return listGrid;
            };
            // @ts-ignore
            isc.RestDataSource.evaluation = {};
            // @ts-ignore
            isc.RestDataSource.evaluation.getDefault = function (fetchDataUrl, fields) {
                var restDataSourceProperties = {};
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
            isc.RestDataSource.evaluation.changeFieldsProperties = function (restDataSource, fieldPropertyName, fieldPropertyValue) {
                // @ts-ignore
                restDataSource.fields[fieldPropertyName] = fieldPropertyValue;
                return restDataSource;
            };
            // @ts-ignore
            isc.RestDataSource.evaluation.createRestDataSource = function (restDataSourceProperties, fetchDataUrl, fields) {
                var restDataSource = isc.RestDataSource.create(restDataSourceProperties);
                restDataSource.fields = fields;
                restDataSource.fetchDataURL = fetchDataUrl;
                return restDataSource;
            };
            // @ts-ignore
            isc.FormItem.evaluation = {};
            // @ts-ignore
            isc.FormItem.evaluation.getDefaultProperties = function (name, title, required, readonly, validators, id) {
                if (required === void 0) {
                    required = true;
                }
                var formItemProperties = {};
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
                    formItemProperties.required = required;
                } else
                    formItemProperties.requiredWhen = required;
                if (readonly instanceof Boolean)
                // @ts-ignore
                    formItemProperties.readonly = readonly;
                else
                // @ts-ignore
                    formItemProperties.readonlyWhen = readonly;
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
            isc.FormItem.evaluation.getDefaultPersianDate = function (name, title, required, readonly, validators, id) {
                if (required === void 0) {
                    required = true;
                }
                var formItemProperties = this.getDefaultProperties(name, title, required, readonly, validators, id);
                // @ts-ignore
                formItemProperties.type = 'persianDate';
                formItemProperties.hint = "1398/03/25";
                // @ts-ignore
                formItemProperties.icons = [persianDatePicker];
                return this.createFormItem(formItemProperties);
            };
            // @ts-ignore
            isc.FormItem.evaluation.createFormItem = function (formItemProperties) {
                return isc.FormItem.create(formItemProperties);
            };
            // @ts-ignore
            isc.DynamicForm.evaluation = {};
            // @ts-ignore
            isc.DynamicForm.evaluation.getDefault = function (fields, id) {
                var dynamicFormProperties = {};
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
            isc.DynamicForm.evaluation.changeFieldsProperties = function (dynamicForm, fieldPropertyName, fieldPropertyValue) {
                // @ts-ignore
                dynamicForm.fields[fieldPropertyName] = fieldPropertyValue;
                return dynamicForm;
            };
            // @ts-ignore
            isc.DynamicForm.evaluation.createDynamicForm = function (dynamicFormProperties, fields) {
                var dynamicForm = isc.DynamicForm.create(dynamicFormProperties);
                dynamicForm.fields = fields;
                return dynamicForm;
            };
            // @ts-ignore
            isc.Window.evaluation = {};
            // @ts-ignore
            isc.Window.evaluation.getDefault = function (title, items, id) {
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
                        this.Super("closeClick", arguments);
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
            isc.HTMLFlow.evaluation.getDefault = function (content) {
                return isc.HTMLFlow.create({
                    // @ts-ignore
                    content: content
                });
            };
            // @ts-ignore
            isc.IButton.evaluation = {};
            // @ts-ignore
            isc.IButton.evaluation.getDefault = function (title, icon, action) {
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
            isc.HLayout.evaluation.getDefault = function (items, id) {
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
            isc.HLayout.evaluation.getSaveLayout = function (saveAction, id) {
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
            isc.VLayout.evaluation.getDefault = function (items, id) {
                return isc.VLayout.create({
                    ID: id,
                    width: "100%",
                    members: items
                });
            };
            // @ts-ignore
            isc.Label.evaluation = {};
            // @ts-ignore
            isc.Label.evaluation.getDefault = function (content, id) {
                return isc.Label.create({
                    height: "5%",
                    contents: content
                });
            };
            // @ts-ignore
            isc.ToolStripButton.evaluation = {};
            // @ts-ignore
            isc.ToolStripButton.evaluation.getDefault = function (title, icon, clickAction) {
                return isc.ToolStripButton.create({
                    icon: icon,
                    title: title,
                    click: clickAction
                });
            };
            // @ts-ignore
            isc.ToolStrip.evaluation = {};
            // @ts-ignore
            isc.ToolStrip.evaluation.getDefault = function (id) {
                var toolStrip = isc.ToolStrip.create({
                    ID: id,
                    width: "100%"
                });
                if (crudActions.length === 0)
                    return toolStrip;
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
                    for (var i = 4; i < crudActions.length; i++)
                        // @ts-ignore
                        toolStrip.addMember(isc.ToolStripButton.evaluation.getDefault(crudActions[i].title, crudActions[i].icon, crudActions[i].click));
                return toolStrip;
            };
            // @ts-ignore
            isc.FacetChart.evaluation = {};
            // @ts-ignore
            isc.FacetChart.evaluation.getDefault = function (data, valueProperty, facets, title, defaultChartType, allowedChartTypes, id) {
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
            isc.FacetChart.evaluation.showChart = function (ownerWindow, title, chart) {
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
                        if (this.tag != null)
                            this.tag.show();
                    }
                });
                chart.setHeight(windowWidget.height);
                windowWidget.show();
            };
            // @ts-ignore
            Array.prototype.distinct = function () {
                return this.filter(function (value, index, self) {
                    return self.indexOf(value) === index;
                });
            };
            // @ts-ignore
            Array.prototype.weakDistinct = function () {
                return this.filter(function (value, index, self) {
                    for (var i = 0; i < index; i++)
                        if (self[i] === value)
                            return false;
                    return true;
                });
            };
            // @ts-ignore
            Array.prototype.groupBy = function (key) {
                if (key == null || this == null || this.length === 0)
                    return {};
                return this.reduce(function (group, current) {
                    var groupData = eval("current." + key);
                    (group[groupData] = group[groupData] || []).push(current);
                    return group;
                }, {});
            };
            // @ts-ignore
            Array.prototype.sumByField = function (key) {
                if (key == null || this == null || this.length === 0)
                    return NaN;
                return this.map(function (q) {
                    return q[key];
                }).sum();
            };
        }

        return CommonUtil;
    }());
    evaluation.CommonUtil = CommonUtil;
    var ObjectHider = /** @class */ (function () {
        function ObjectHider(hider) {
            this._hider = hider;
        }

        ObjectHider.prototype.getObject = function () {
            return this._hider;
        };
        return ObjectHider;
    }());
    evaluation.ObjectHider = ObjectHider;
    //------------------------------------------ Classes -----------------------------------------//
})(evaluation || (evaluation = {}));
//------------------------------------------- Namespaces -----------------------------------------//

//------------------------------------------ CommonUtil ------------------------------------------//

//---------------------------------------- GeneralTabUtil ------------------------------------------

//------------------------------------------ TS References -----------------------------------------
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function (t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var evaluation;
(function (evaluation) {
    //----------------------------------------- Interfaces -----------------------------------------
    //----------------------------------------- Interfaces ---------------------------------------//
    //------------------------------------------ Classes -------------------------------------------
    var GeneralTabUtil = /** @class */ (function () {
        function GeneralTabUtil() {
            this._tab = new JSPTabVariableImp();
        }

        // external usage
        GeneralTabUtil.prototype.getDefaultJSPTabVariable = function () {
            // @ts-ignore
            return __assign({}, this._tab);
        };
        // external usage
        GeneralTabUtil.changeProperties = function (jspTabVariable, propertyName, propertyValue) {
            jspTabVariable[propertyName] = propertyValue;
            return jspTabVariable;
        };
        return GeneralTabUtil;
    }());
    evaluation.GeneralTabUtil = GeneralTabUtil;
    var JSPTabVariableImp = /** @class */ (function () {
        function JSPTabVariableImp() {
            var This = this;
            This.variable = {
                url: "",
                method: null,
                contentType: "",
                httpHeaders: {authorization: "", "content-type": ""},
                defaultStylePrefix: ""
            };
            This.variable.method = "POST";
            // @ts-ignore
            This.variable.url = EvaluationConfigs.baseRestUrl;
            // @ts-ignore
            This.variable.httpHeaders = EvaluationConfigs.httpHeaders;
            This.variable.contentType = "application/json; charset=utf-8";
            This.variable.defaultStylePrefix = "evaluation-evaluationResult-tab-";
            This.method = {
                "delete": null,
                refresh: null,
                newForm: null,
                editForm: null,
                saveForm: null,
                fetchData: null,
                transformRequest: null,
                concatObjectsByKey: null,
                jsonRPCManagerRequest: null,
            };
            This.method.transformRequest = function (dsRequest) {
                // @ts-ignore
                dsRequest.httpHeaders = EvaluationConfigs.httpHeaders;
                return this.Super("transformRequest", arguments);
            };
            This.method.concatObjectsByKey = function (isBoolOperatorAnd) {
                var objs = [];
                for (var _i = 1; _i < arguments.length; _i++) {
                    objs[_i - 1] = arguments[_i];
                }
                return objs.reduce(function (first, second) {
                    var result = {};
                    for (var key in second) {
                        if (first.hasOwnProperty(key)) {
                            if (second[key] == null)
                                return;
                            if (first[key] == null) {
                                result[key] = second[key];
                                return;
                            }
                            if (first[key].Class === "String")
                                result[key] = String(first[key] + second[key]);
                            else if (first[key].Class === "Number")
                                result[key] = Number(first[key] + second[key]);
                            else if (first[key].Class === "Boolean" || first[key].toString().toLowerCase() === "true" || first[key].toString().toLowerCase() === "false") {
                                if (isBoolOperatorAnd)
                                    result[key] = Boolean(first[key] && second[key]);
                                else
                                    result[key] = Boolean(first[key] || second[key]);
                            } else if (first[key].Class === "Array") {
                                result[key] = [];
                                result[key].addAll(first[key]);
                                result[key].addAll(second[key]);
                            } else if (first[key].Class === "Object" || first[key].Class == null)
                                result[key] = This.method.concatObjectsByKey(isBoolOperatorAnd, first[key], second[key]);
                            else
                                console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                        } else
                            result[key] = second[key];
                    }
                    return result;
                }, {});
            };
            This.method.fetchData = function (getAllIfExist, rpcRequest) {
                var callBack = rpcRequest.callback;
                rpcRequest.callback = function (response) {
                    if (!getAllIfExist) {
                        callBack(response);
                        return;
                    }
                    var currentProps = __assign({}, rpcRequest);
                    // @ts-ignore
                    var currentRespons = JSON.parse(response.data).response;
                    if (currentProps.params == null ||
                        // @ts-ignore
                        currentProps.params._endRow == null ||
                        // @ts-ignore
                        currentProps.params._startRow == null ||
                        currentRespons == null ||
                        currentRespons.totalRows == null ||
                        // @ts-ignore
                        currentProps.params._endRow >= currentRespons.totalRows) {
                        callBack(response);
                        return;
                    }
                    var data = __assign({}, currentRespons.data);
                    // @ts-ignore
                    var oldStartRow = currentProps.params._startRow;
                    // @ts-ignore
                    currentProps.params._startRow = currentProps.params._endRow;
                    // @ts-ignore
                    currentProps.params._endRow = (currentProps.params._endRow - oldStartRow) + currentProps.params._startRow;
                    currentProps.callback = function (response2) {
                        // @ts-ignore
                        var json = JSON.parse(response2.data);
                        data.addAll(json.response.data);
                        response.data = JSON.stringify({
                            response: {
                                data: data,
                                // @ts-ignore
                                startRow: rpcRequest.params._startRow,
                                endRow: json.response.totalRows,
                                totalRows: json.response.totalRows
                            }
                        });
                        callBack(response);
                    };
                    This.method.fetchData(getAllIfExist, currentProps);
                };
                This.method.jsonRPCManagerRequest(rpcRequest);
            };
            This.method.jsonRPCManagerRequest = function (rpcRequest, okActionHook, errorActionHook) {
                if (rpcRequest == null)
                    return;
                if (rpcRequest.callback == null)
                    rpcRequest.callback = function (response) {
                        if (response.httpResponseCode === 201 || response.httpResponseCode === 200) {
                            This.dialog.ok();
                            if (okActionHook != null)
                                okActionHook(response);
                        } else {
                            This.dialog.error(response);
                            if (errorActionHook != null)
                                errorActionHook(response);
                        }
                    };
                if (rpcRequest.actionURL == null)
                    rpcRequest.actionURL = This.variable.url;
                if (rpcRequest.httpMethod == null)
                    rpcRequest.httpMethod = This.variable.method;
                if (rpcRequest.httpHeaders == null)
                    rpcRequest.httpHeaders = This.variable.httpHeaders;
                if (rpcRequest.contentType == null)
                    rpcRequest.contentType = This.variable.contentType;
                isc.RPCManager.sendRequest(rpcRequest);
            };
            This.method.refresh = function (grid, refreshActionHook) {
                grid.invalidateCache();
                if (refreshActionHook != null)
                    refreshActionHook();
            };
            This.method.newForm = function (form, newActionHook) {
                This.variable.method = "POST";
                form.clearValues();
                var win = form.getParentElements().last();
                win.show();
                if (newActionHook != null)
                    newActionHook();
            };
            This.method.editForm = function (grid, form, editActionHook) {
                var record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                else {
                    This.variable.method = "PUT";
                    form.clearValues();
                    form.editRecord(__assign({}, record));
                    var win = form.getParentElements().last();
                    win.show();
                    if (editActionHook != null)
                        editActionHook(record);
                }
            };
            This.method["delete"] = function (grid, deleteActionHook, errorActionHook) {
                var record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                else {
                    This.variable.method = "DELETE";
                    This.dialog.question(function () {
                        var rpcRequest = {};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + record["id"];
                        rpcRequest.callback = function (response) {
                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {
                                This.dialog.ok();
                                This.method.refresh(grid);
                                if (deleteActionHook != null)
                                    deleteActionHook(record);
                            } else {
                                This.dialog.error(response);
                                if (errorActionHook != null)
                                    errorActionHook(record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    });
                }
            };
            This.method.saveForm = function (grid, form, validationActionHook, getDataActionHook, saveActionHook, errorActionHook) {
                form.validate();
                if (validationActionHook != null)
                    validationActionHook(form);
                if (form.hasErrors())
                    return;
                var data = form.getValues();
                if (getDataActionHook != null)
                    data = getDataActionHook(form, data);
                var url = This.variable.url + (This.variable.method.toUpperCase() == "POST" ? "" : data["id"]);
                var rpcRequest = {};
                rpcRequest.data = data;
                rpcRequest.actionURL = url;
                This.method.jsonRPCManagerRequest(rpcRequest, function (response) {
                    var win = form.getParentElements().last();
                    This.method.refresh(grid);
                    win.close();
                    saveActionHook(response);
                }, errorActionHook);
            };
            This.dialog = {
                ok: null,
                say: null,
                error: null,
                question: null,
                notSelected: null,
                moreSelected: null
            };
            This.dialog.notSelected = function () {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "تائید"})],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.moreSelected = function () {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.moreSelected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "تائید"})],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.ok = function (warn) {
                if (warn === void 0) {
                    warn = "";
                }
                var OkDialog;
                if (warn == null || warn === "") {
                    OkDialog = isc.Dialog.create({
                        message: "<spring:message code='global.form.request.successful'/>",
                        icon: "[SKIN]say.png",
                        title: "<spring:message code='global.ok'/>",
                        buttons: [isc.Button.create({title: "تائید"})],
                        // @ts-ignore
                        buttonClick: function (button, index) {
                            this.close();
                        }
                    });
                    setTimeout(function () {
                        OkDialog.close();
                    }, 3000);
                } else {
                    OkDialog = isc.Dialog.create({
                        message: "<spring:message code='global.form.request.successful'/><br>پیام:&nbsp;" + warn,
                        icon: "[SKIN]warn.png",
                        title: "<spring:message code='global.ok'/>",
                        buttons: [isc.Button.create({title: "تائید"})],
                        // @ts-ignore
                        buttonClick: function (button, index) {
                            this.close();
                        }
                    });
                }
            };
            This.dialog.say = function (message, title) {
                isc.Dialog.create({
                    message: message,
                    icon: "[SKIN]say.png",
                    title: title || "پیغام",
                    buttons: [isc.Button.create({title: "تائید"})],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.error = function (response) {
                This.log["errorResponse"] = response;
                isc.RPCManager.handleError(response, null);
            };
            This.dialog.question = function (clickAction, message) {
                if (message === void 0) {
                    message = "<spring:message code='global.delete.ask'/>";
                }
                isc.Dialog.create({
                    message: message,
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({
                        title: "<spring:message code='global.no'/>"
                    })],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index === 0)
                            clickAction();
                    }
                });
            };
        }

        return JSPTabVariableImp;
    }());
    evaluation.JSPTabVariableImp = JSPTabVariableImp;
    //------------------------------------------ Classes -----------------------------------------//
})(evaluation || (evaluation = {}));
//------------------------------------------- Namespaces -----------------------------------------//

//---------------------------------------- GeneralTabUtil ----------------------------------------//

//---------------------------------------- PersianDateUtil -----------------------------------------

//------------------------------------------ TS References -----------------------------------------
// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var evaluation;
(function (evaluation) {
    //------------------------------------------ Classes -------------------------------------------
    var PersianDateUtil = /** @class */ (function () {
        function PersianDateUtil() {
        }

        // external usage
        PersianDateUtil.minDate = function (dates) {
            var _this = this;
            if (dates == null || dates.length === 0)
                return "";
            return dates.map(function (q) {
                return Number(_this.formatDateToNumberStr(q));
            }).min().toString();
        };
        // external usage
        PersianDateUtil.maxDate = function (dates) {
            var _this = this;
            if (dates == null || dates.length === 0)
                return "";
            return dates.map(function (q) {
                return Number(_this.formatDateToNumberStr(q));
            }).max().toString();
        };
        // external usage
        PersianDateUtil.compareDate = function (first, second) {
            var firstValue = this.formatDateToNumberStr(first);
            var secondValue = this.formatDateToNumberStr(second);
            return Number(firstValue) - Number(secondValue);
        };
        // external usages
        PersianDateUtil.isBetweenDate = function (date, first, second) {
            var dateValue = this.formatDateToNumberStr(date);
            var firstValue = this.formatDateToNumberStr(first);
            var secondValue = this.formatDateToNumberStr(second);
            return dateValue >= firstValue && dateValue <= secondValue;
        };
        // external usage
        PersianDateUtil.formatDate = function (date) {
            if (date == null || date === "")
                return "";
            return date.split('/').map(function (value, index) {
                if (index === 0)
                    return value.padStart(4, "0");
                else
                    return value.padStart(2, "0");
            }).join("/");
        };
        // external usage
        PersianDateUtil.formatDateToNumberStr = function (date) {
            if (date == null || date === "")
                return "";
            return date.split('/').map(function (value, index) {
                if (index === 0)
                    return value.padStart(4, "0");
                else
                    return value.padStart(2, "0");
            }).join("");
        };
        return PersianDateUtil;
    }());
    evaluation.PersianDateUtil = PersianDateUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(evaluation || (evaluation = {}));
//------------------------------------------- Namespaces -----------------------------------------//

//---------------------------------------- PersianDateUtil ---------------------------------------//

//----------------------------------------- FormUtil -----------------------------------------------

//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var evaluation;
(function (evaluation) {
    //------------------------------------------ Classes -------------------------------------------
    var FormUtil = /** @class */ (function () {
        function FormUtil() {
            this.populateData = function (bodyWidget) {
                return [];
            };
            this.cancelCallBack = function () {
                return;
            };
            this.okCallBack = function (data) {
                return data;
            };
        }

        FormUtil.prototype.showForm = function (ownerWindow, title, canvas) {
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.bodyWidget = new evaluation.ObjectHider(canvas);
            this.createWindow(title, this.getButtonLayout());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FormUtil.prototype.getButtonLayout = function () {
            var This = this;
            var cancel = isc.IButtonCancel.create({
                // @ts-ignore
                click: function () {
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.cancelCallBack();
                },
                icon: "pieces/16/icon_delete.png",
                title: '<spring:message code="global.close" />'
            });
            var ok = isc.IButtonSave.create({
                // @ts-ignore
                click: function () {
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.okCallBack(This.populateData(This.bodyWidget.getObject()));
                },
                icon: "pieces/16/approve.png",
                title: '<spring:message code="global.ok" />'
            });
            return isc.HLayout.create({
                width: "100%",
                padding: 10,
                layoutMargin: 10,
                membersMargin: 10,
                edgeImage: "",
                showEdges: false,
                members: [ok, cancel]
            });
        };
        FormUtil.prototype.createWindow = function (title, buttonLayout) {
            var This = this;
            var vLayout = isc.VLayout.create({
                width: "100%",
                members: [
                    This.bodyWidget.getObject(),
                    buttonLayout
                ]
            });
            This.windowWidget = new evaluation.ObjectHider(isc.Window.create({
                title: title,
                width: "50%",
                align: "center",
                items: [vLayout],
                isModal: true,
                autoSize: true,
                autoDraw: false,
                autoCenter: true,
                showModalMask: true,
                dismissOnEscape: false,
                dismissOnOutsideClick: false,
                // @ts-ignore
                closeClick: function () {
                    this.Super("closeClick", arguments);
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                }
            }));
        };
        return FormUtil;
    }());
    evaluation.FormUtil = FormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(evaluation || (evaluation = {}));
//------------------------------------------- Namespaces -----------------------------------------//

//----------------------------------------- FormUtil ---------------------------------------------//

//----------------------------------------- FindFormUtil -------------------------------------------

//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
// @ts-ignore
///<reference path="C:\isomorphic\system\development\smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var evaluation;
(function (evaluation) {
    //------------------------------------------ Classes -------------------------------------------
    var FindFormUtil = /** @class */ (function () {
        function FindFormUtil() {
            this.cancelCallBack = function () {
                return;
            };
            this.validate = function (selectedRecords) {
                return true;
            };
            this.okCallBack = function (selectedRecords) {
                return selectedRecords;
            };
        }
        FindFormUtil.prototype.showFindFormByData = function (ownerWindow, title, data, currentData, fields, selectionMultiplicityValue) {
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(null, null, null);
            var listGrid = this.listGridWidget.getObject();
            listGrid.setData(data);
            listGrid.setFields(fields);
            listGrid.setShowFilterEditor(false);
            if (currentData != null && currentData.length > 0) {
                // @ts-ignore
                var primaryKeyField = listGrid.getFields().find(function (p) { return p.primaryKey; });
                // @ts-ignore
                if (primaryKeyField == null && listGrid.dataSource != null)
                // @ts-ignore
                    primaryKeyField = Object.values(listGrid.dataSource.getFields()).find(function (p) { return p.primaryKey; });
                else
                    primaryKeyField = { name: 'id' };
                var primaryKeyName_1 = primaryKeyField.name;
                var currentdataIds_1 = currentData.map(function (q) { return q[primaryKeyName_1]; });
                if (currentdataIds_1 == null || currentdataIds_1.length === 0)
                    return;
                // @ts-ignore
                listGrid.getOriginalData().forEach(function (q) {
                    if (currentdataIds_1.contains(q[primaryKeyName_1]))
                        listGrid.selectRecord(q);
                });
            }
            this.createWindow(title, this.getButtonLayout(), listGrid);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByListGrid = function (ownerWindow, title, currentData, listGrid, selectionMultiplicityValue) {
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
            this.listGridWidget = new evaluation.ObjectHider(isc.ListGrid.create(listGrid));
            this.createWindow(title, this.getButtonLayout(), listGrid);
            if (currentData != null && currentData.length > 0) {
                // @ts-ignore
                var primaryKeyField = listGrid.getFields().find(function (p) { return p.primaryKey; });
                // @ts-ignore
                if (primaryKeyField == null && listGrid.dataSource != null)
                // @ts-ignore
                    primaryKeyField = Object.values(listGrid.dataSource.getFields()).find(function (p) { return p.primaryKey; });
                else
                    primaryKeyField = { name: 'id' };
                var primaryKeyName_2 = primaryKeyField.name;
                var currentdataIds_2 = currentData.map(function (q) { return q[primaryKeyName_2]; });
                if (currentdataIds_2 == null || currentdataIds_2.length === 0)
                    return;
                // @ts-ignore
                listGrid.getOriginalData().forEach(function (q) {
                    if (currentdataIds_2.contains(q[primaryKeyName_2]))
                        listGrid.selectRecord(q);
                });
            }
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByRestDataSource = function (ownerWindow, title, currentData, restDataSource, dataArrivedCallback, criteria, selectionMultiplicityValue) {
            if (criteria === void 0) { criteria = null; }
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(isc.RestDataSource.create(restDataSource), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByRestApiUrl = function (ownerWindow, title, currentData, restApiUrl, fields, dataArrivedCallback, criteria, selectionMultiplicityValue) {
            if (criteria === void 0) { criteria = null; }
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(this.getRestDataSource(restApiUrl, fields), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject());
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.showFindFormByRestApiUrl2 = function (ownerWindow, width, height, title, currentData, restApiUrl, fields, dataArrivedCallback, criteria, selectionMultiplicityValue) {
            if (criteria === void 0) { criteria = null; }
            if (selectionMultiplicityValue === void 0) { selectionMultiplicityValue = 1; }
            this.owner = new evaluation.ObjectHider(ownerWindow);
            this.selectionMultiplicity = new evaluation.ObjectHider(selectionMultiplicityValue);
            this.createListGrid(this.getRestDataSource(restApiUrl, fields), criteria, currentData, dataArrivedCallback);
            this.createWindow(title, this.getButtonLayout(), this.listGridWidget.getObject(), width, height);
            if (ownerWindow != null)
                ownerWindow.close();
            this.windowWidget.getObject().show();
        };
        FindFormUtil.prototype.getButtonLayout = function () {
            var This = this;
            // @ts-ignore
            var cancel = isc.IButtonCancel.create({
                // @ts-ignore
                click: function () {
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.cancelCallBack();
                },
                icon: "pieces/16/icon_delete.png",
                title: '<spring:message code="global.close" />'
            });
            // @ts-ignore
            var ok = isc.IButtonSave.create({
                // @ts-ignore
                click: function () {
                    var data = [];
                    if (This.selectionMultiplicity.getObject() === 1) {
                        data.add(This.listGridWidget.getObject().getSelectedRecord());
                    }
                    else {
                        var selectedRecords = This.listGridWidget.getObject().getSelectedRecords();
                        data = selectedRecords.slice(0, Math.min(selectedRecords.length, This.selectionMultiplicity.getObject()));
                    }
                    if (!This.validate(data))
                        return;
                    This.windowWidget.getObject().close();
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                    This.okCallBack(data);
                },
                icon: "pieces/16/approve.png",
                title: '<spring:message code="global.ok" />'
            });
            if (This.selectionMultiplicity.getObject() < 1)
                ok.hide();
            return isc.HLayout.create({
                width: "100%",
                padding: 10,
                layoutMargin: 10,
                membersMargin: 10,
                edgeImage: "",
                showEdges: false,
                members: [ok, cancel]
            });
        };
        FindFormUtil.prototype.getRestDataSource = function (restApiUrl, fields) {
            return isc.RestDataSource.create({
                fields: fields,
                jsonPrefix: "",
                jsonSuffix: "",
                dataFormat: "json",
                fetchDataURL: restApiUrl,
                // @ts-ignore
                transformRequest: function (dsRequest) {
                    // @ts-ignore
                    dsRequest.httpHeaders = EvaluationConfigs.httpHeaders;
                    return this.Super("transformRequest", arguments);
                }
            });
        };
        FindFormUtil.prototype.createListGrid = function (restDataSource, criteria, currentData, dataArrivedCallback) {
            var This = this;
            This.listGridWidget = new evaluation.ObjectHider(isc.ListGrid.create({
                width: "100%",
                height: window.innerHeight * .6,
                margin: 10,
                dataPageSize: 50,
                autoFetchData: true,
                // @ts-ignore
                currentData: currentData,
                initialCriteria: criteria,
                dataSource: restDataSource,
                canAutoFitFields: false,
                selectionType: (This.selectionMultiplicity.getObject() < 1 ? "none" : (This.selectionMultiplicity.getObject() === 1 ? "single" : "simple")),
                selectionAppearance: (This.selectionMultiplicity.getObject() > 1 ? "checkbox" : "rowStyle"),
                sortField: This.selectionMultiplicity.getObject() > 1 ? 1 : 0,
                fetchDelay: 1000,
                autoSaveEdits: false,
                showFilterEditor: true,
                validateOnChange: true,
                filterOnKeyPress: false,
                alternateRecordStyles: true,
                allowAdvancedCriteria: true,
                sortFieldAscendingText: '<spring:message code="global.grid.sortFieldAscendingText" />',
                sortFieldDescendingText: '<spring:message code="global.grid.sortFieldDescendingText" />',
                configureSortText: '<spring:message code="global.grid.configureSortText" />',
                autoFitAllText: '<spring:message code="global.grid.autoFitAllText" />',
                autoFitFieldText: '<spring:message code="global.grid.autoFitFieldText" />',
                filterUsingText: '<spring:message code="global.grid.filterUsingText" />',
                groupByText: '<spring:message code="global.grid.groupByText" />',
                freezeFieldText: '<spring:message code="global.grid.freezeFieldText" />',
                dataArrived: function (startRow, endRow) {
                    var _this = this;
                    if (this.currentData != null && this.currentData.length > 0) {
                        // @ts-ignore
                        var primaryKeyField = this.getFields().find(function (p) { return p.primaryKey; });
                        // @ts-ignore
                        if (primaryKeyField == null && this.dataSource != null)
                        // @ts-ignore
                            primaryKeyField = Object.values(this.dataSource.getFields()).find(function (p) { return p.primaryKey; });
                        else
                            primaryKeyField = { name: 'id' };
                        var primaryKeyName_3 = primaryKeyField.name;
                        var currentDataIds_1 = this.currentData.map(function (q) { return q[primaryKeyName_3]; });
                        if (currentDataIds_1 == null || currentDataIds_1.length === 0)
                            return;
                        // @ts-ignore
                        this.getOriginalData().localData.filter(function (q) { return q; }).forEach(function (q) {
                            if (currentDataIds_1.contains(q[primaryKeyName_3]))
                                _this.selectRecord(q);
                        });
                    }
                    if (dataArrivedCallback != null)
                        dataArrivedCallback(startRow, endRow);
                }
            }));
        };
        FindFormUtil.prototype.createWindow = function (title, buttonLayout, listGrid, width, height) {
            if (width === void 0) { width = null; }
            if (height === void 0) { height = null; }
            var This = this;
            var vLayout = this.createVLayout(buttonLayout, listGrid);
            This.windowWidget = new evaluation.ObjectHider(isc.Window.create({
                title: title,
                width: width == null ? "50%" : width,
                height: height,
                align: "center",
                items: [vLayout],
                isModal: true,
                autoSize: true,
                autoDraw: false,
                autoCenter: true,
                showModalMask: true,
                dismissOnEscape: false,
                dismissOnOutsideClick: false,
                // @ts-ignore
                closeClick: function () {
                    this.Super("closeClick", arguments);
                    if (This.owner.getObject() != null)
                        This.owner.getObject().show();
                }
            }));
        };
        FindFormUtil.prototype.createVLayout = function (buttonLayout, listGrid) {
            return isc.VLayout.create({
                width: "100%",
                members: [
                    listGrid,
                    buttonLayout
                ]
            });
        };
        return FindFormUtil;
    }());
    evaluation.FindFormUtil = FindFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(evaluation || (evaluation = {}));
//------------------------------------------- Namespaces -----------------------------------------//

//----------------------------------------- FindFormUtil -----------------------------------------//

//---------------------------------------- BasicFormUtil -------------------------------------------

//------------------------------------------ TS References -----------------------------------------
///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>
// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var evaluation;
(function (evaluation) {
    //------------------------------------------ Classes -------------------------------------------
    var BasicFormUtil = /** @class */ (function () {
        function BasicFormUtil() {
        }

        BasicFormUtil.getDefaultBasicForm = function (creator, gridFields, formFields, fetchDataUrl, criteria) {
            // @ts-ignore
            var dynamicForm = isc.DynamicForm.evaluation.getDefault(formFields);
            // @ts-ignore
            var dataSource = isc.RestDataSource.evaluation.getDefault(fetchDataUrl, gridFields);
            // @ts-ignore
            var grid = isc.ListGrid.evaluation.getDefault(gridFields, dataSource);
            var crudActions = [];
            crudActions.add(creator.method.refresh(grid));
            crudActions.add(creator.method.newForm(dynamicForm));
            crudActions.add(creator.method.editForm(grid, dynamicForm));
            crudActions.add(creator.method["delete"](grid));
            // @ts-ignore
            var menu = isc.Menu.evaluation.getDefault(crudActions);
            // @ts-ignore
            isc.ListGrid.evaluation.changeProperties(grid, "contextMenu", menu);
            // @ts-ignore
            var toolStrip = isc.ToolStrip.evaluation.getDefault(crudActions);
            // @ts-ignore
            return isc.VLayout.evaluation.getDefault([toolStrip, grid]);
        };
        return BasicFormUtil;
    }());
    evaluation.BasicFormUtil = BasicFormUtil;
    //------------------------------------------ Classes -----------------------------------------//
})(evaluation || (evaluation = {}));
//------------------------------------------- Namespaces -----------------------------------------//

//---------------------------------------- BasicFormUtil -----------------------------------------//
