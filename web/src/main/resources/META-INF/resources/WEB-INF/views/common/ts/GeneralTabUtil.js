//------------------------------------------ TS References -----------------------------------------
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
///<reference path="CommonUtil.ts"/>
///<reference path="FormUtil.ts"/>
// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />
//------------------------------------------ TS References ---------------------------------------//
//------------------------------------------- Namespaces -------------------------------------------
var nicico;
(function (nicico) {
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
    nicico.GeneralTabUtil = GeneralTabUtil;
    var JSPTabVariableImp = /** @class */ (function () {
        function JSPTabVariableImp() {
            var This = this;
            This.dynamicForm = {
                fields: []
            };
            This.listGrid = {
                fields: [],
                criteria: null
            };
            This.log = {};
            This.tab = {};
            This.chart = {};
            This.label = {};
            This.button = {};
            This.menu = {};
            This.toolStrip = {};
            This.hStack = {};
            This.vStack = {};
            This.hLayout = {};
            This.vLayout = {};
            This.restDataSource = {};
            This.window = {};
            This.variable = {
                url: "",
                method: null,
                contentType: "",
                httpHeaders: { authorization: "", "content-type": "" },
                defaultStylePrefix: ""
            };
            This.variable.method = "POST";
            // @ts-ignore
            This.variable.url = "${contextPath}/";
            // @ts-ignore
            This.variable.httpHeaders = BaseRPCRequest.httpHeaders;
            // @ts-ignore
            This.variable.contentType = BaseRPCRequest.contentType;
            This.variable.defaultStylePrefix = "";
            This.method = {
                delete: null,
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
                dsRequest.httpHeaders = BaseRPCRequest.httpHeaders;
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
                            }
                            else if (first[key].Class === "Array") {
                                result[key] = [];
                                result[key].addAll(first[key]);
                                result[key].addAll(second[key]);
                            }
                            else if (first[key].Class === "Object" || first[key].Class == null)
                                result[key] = This.method.concatObjectsByKey(isBoolOperatorAnd, first[key], second[key]);
                            else
                                console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                        }
                        else
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
                        }
                        else {
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
            This.method.newForm = function (title, grid, form, newActionHook) {
                This.variable.method = "POST";
                form.clearValues();
                var formUtil = new nicico.FormUtil();
                formUtil.validate = function (data) {
                    form.validate();
                    return !form.hasErrors();
                };
                formUtil.okCallBack = function (data) {
                    This.method.saveForm(grid, form);
                };
                formUtil.showForm(null, title, form);
                form.show();
                if (newActionHook != null)
                    newActionHook();
            };
            This.method.editForm = function (title, grid, form, editActionHook) {
                var record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                else {
                    This.variable.method = "PUT";
                    form.clearValues();
                    form.editRecord(__assign({}, record));
                    var formUtil = new nicico.FormUtil();
                    formUtil.validate = function (data) {
                        form.validate();
                        return !form.hasErrors();
                    };
                    formUtil.okCallBack = function (data) {
                        This.method.saveForm(grid, form);
                    };
                    formUtil.showForm(null, title, form);
                    form.show();
                    if (editActionHook != null)
                        editActionHook(record);
                }
            };
            This.method.delete = function (grid, deleteActionHook, errorActionHook) {
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
                            }
                            else {
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
                    buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
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
                    buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.ok = function (warn) {
                if (warn === void 0) { warn = ""; }
                var OkDialog;
                if (warn == null || warn === "") {
                    OkDialog = isc.Dialog.create({
                        message: "<spring:message code='global.form.request.successful'/>",
                        icon: "[SKIN]say.png",
                        title: "<spring:message code='global.ok'/>",
                        buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
                        // @ts-ignore
                        buttonClick: function (button, index) {
                            this.close();
                        }
                    });
                    setTimeout(function () {
                        OkDialog.close();
                    }, 3000);
                }
                else {
                    OkDialog = isc.Dialog.create({
                        message: "<spring:message code='global.form.request.successful'/><br>پیام:&nbsp;" + warn,
                        icon: "[SKIN]warn.png",
                        title: "<spring:message code='global.ok'/>",
                        buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
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
                    title: title || "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
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
                if (message === void 0) { message = "<spring:message code='global.delete.ask'/>"; }
                isc.Dialog.create({
                    message: message,
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({ title: "<spring:message code='global.yes'/>" }), isc.Button.create({
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
    nicico.JSPTabVariableImp = JSPTabVariableImp;
    //------------------------------------------ Classes -----------------------------------------//
})(nicico || (nicico = {}));
//------------------------------------------- Namespaces -----------------------------------------//
