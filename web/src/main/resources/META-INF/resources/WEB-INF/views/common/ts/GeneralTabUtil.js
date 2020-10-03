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
            This.sectionStack = {};
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
                beforeRefreshActionHook: null,
                afterRefreshActionHook: null,
                beforeShowNewActionHook: null,
                afterShowNewActionHook: null,
                beforeShowEditActionHook: null,
                afterShowEditActionHook: null,
                beforeDeleteActionHook: null,
                afterDeleteActionHook: null,
                afterDeleteErrorActionHook: null,
                beforeActivateActionHook: null,
                afterActivateActionHook: null,
                afterActivateErrorActionHook: null,
                beforeDeactivateActionHook: null,
                afterDeactivateActionHook: null,
                afterDeactivateErrorActionHook: null,
                beforeFinalizeActionHook: null,
                afterFinalizeActionHook: null,
                afterFinalizeErrorActionHook: null,
                beforeDisapproveActionHook: null,
                afterDisapproveActionHook: null,
                afterDisapproveErrorActionHook: null,
                saveValidationActionHook: null,
                saveGetDataActionHook: null,
                saveActionHook: null,
                saveErrorActionHook: null,
                delete: null,
                activate: null,
                deactivate: null,
                finalize: null,
                disapprove: null,
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
                if (rpcRequest.callback == null) {
                    rpcRequest.willHandleError = true;
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
                }
                if (rpcRequest.actionURL == null)
                    rpcRequest.actionURL = This.variable.url;
                if (rpcRequest.httpMethod == null)
                    rpcRequest.httpMethod = This.variable.method;
                if (rpcRequest.httpHeaders == null)
                    rpcRequest.httpHeaders = This.variable.httpHeaders;
                if (rpcRequest.contentType == null)
                    rpcRequest.contentType = This.variable.contentType;
                if (rpcRequest.useSimpleHttp == null)
                    rpcRequest.useSimpleHttp = true;
                if (rpcRequest.showPrompt == null)
                    rpcRequest.showPrompt = true;
                if (rpcRequest.serverOutputAsString == null)
                    rpcRequest.serverOutputAsString = false;
                if (rpcRequest.willHandleError == null)
                    rpcRequest.willHandleError = false;
                isc.RPCManager.sendRequest(rpcRequest);
            };
            This.method.beforeRefreshActionHook = function () { };
            This.method.afterRefreshActionHook = function () { };
            This.method.beforeShowNewActionHook = function () { };
            This.method.afterShowNewActionHook = function (window) { };
            This.method.beforeShowEditActionHook = function (record) { };
            This.method.afterShowEditActionHook = function (window, record) { };
            This.method.beforeDeleteActionHook = function (record) { };
            This.method.afterDeleteActionHook = function (response, record) { };
            This.method.afterDeleteErrorActionHook = function (response, record) { };
            This.method.beforeActivateActionHook = function (record) { };
            This.method.afterActivateActionHook = function (response, record) { };
            This.method.afterActivateErrorActionHook = function (response, record) { };
            This.method.beforeDeactivateActionHook = function (record) { };
            This.method.afterDeactivateActionHook = function (response, record) { };
            This.method.afterDeactivateErrorActionHook = function (response, record) { };
            This.method.beforeFinalizeActionHook = function (record) { };
            This.method.afterFinalizeActionHook = function (response, record) { };
            This.method.afterFinalizeErrorActionHook = function (response, record) { };
            This.method.beforeDisapproveActionHook = function (record) { };
            This.method.afterDisapproveActionHook = function (response, record) { };
            This.method.afterDisapproveErrorActionHook = function (response, record) { };
            This.method.saveValidationActionHook = function (form) { };
            This.method.saveGetDataActionHook = function (form, data) {
                return data;
            };
            This.method.saveActionHook = function (response) { };
            This.method.saveErrorActionHook = function (response) { };
            This.method.refresh = function (grid) {
                This.method.beforeRefreshActionHook();
                grid.invalidateCache();
                This.method.afterRefreshActionHook();
            };
            This.method.newForm = function (title, grid, form) {
                This.method.beforeShowNewActionHook();
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
                // @ts-ignore
                var width = form.windowWidth == null ? "50%" : form.windowWidth;
                // @ts-ignore
                var height = form.windowHeight;
                formUtil.showForm(null, title, form, width, height);
                form.show();
                This.method.afterShowNewActionHook(formUtil);
            };
            This.method.editForm = function (title, grid, form) {
                var record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                // @ts-ignore
                else if (record.editable == false)
                    This.dialog.notEditable();
                // @ts-ignore
                else if (record.estatus.contains(Enums.eStatus2.DeActive))
                    This.dialog.recordIsInactive();
                // @ts-ignore
                else if (record.estatus.contains(Enums.eStatus2.Final))
                    This.dialog.finalRecord();
                else {
                    This.method.beforeShowEditActionHook(record);
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
                    // @ts-ignore
                    var width = form.windowWidth == null ? "50%" : form.windowWidth;
                    // @ts-ignore
                    var height = form.windowHeight;
                    formUtil.showForm(null, title, form, width, height);
                    form.show();
                    This.method.afterShowEditActionHook(formUtil, record);
                }
            };
            This.method.delete = function (grid) {
                var record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                // @ts-ignore
                else if (record.editable == false)
                    This.dialog.notEditable();
                // @ts-ignore
                else if (record.estatus.contains(Enums.eStatus2.DeActive))
                    This.dialog.recordIsInactive();
                // @ts-ignore
                else if (record.estatus.contains(Enums.eStatus2.Final))
                    This.dialog.finalRecord();
                else {
                    This.variable.method = "DELETE";
                    This.dialog.question(function () {
                        This.method.beforeDeleteActionHook(record);
                        var rpcRequest = {};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + record["id"];
                        rpcRequest.callback = function (response) {
                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {
                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterDeleteActionHook(response, record);
                            }
                            else {
                                This.dialog.error(response);
                                This.method.afterDeleteErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    });
                }
            };
            This.method.activate = function (grid) {
                var record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                // @ts-ignore
                else if (record.editable == false)
                    This.dialog.notEditable();
                // @ts-ignore
                else if (record.estatus.contains(Enums.eStatus2.Active))
                    This.dialog.activeRecord();
                else {
                    This.variable.method = "POST";
                    This.dialog.question(function () {
                        This.method.beforeActivateActionHook(record);
                        var rpcRequest = {};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + "activate/" + record["id"];
                        rpcRequest.callback = function (response) {
                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {
                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterActivateActionHook(response, record);
                            }
                            else {
                                This.dialog.error(response);
                                This.method.afterActivateErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    }, "<spring:message code='global.activate.ask'/>");
                }
            };
            This.method.deactivate = function (grid) {
                var record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                // @ts-ignore
                else if (record.editable == false)
                    This.dialog.notEditable();
                // @ts-ignore
                else if (record.estatus.contains(Enums.eStatus2.DeActive))
                    This.dialog.inactiveRecord();
                else {
                    This.variable.method = "POST";
                    This.dialog.question(function () {
                        This.method.beforeDeactivateActionHook(record);
                        var rpcRequest = {};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + "deactivate/" + record["id"];
                        rpcRequest.callback = function (response) {
                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {
                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterDeactivateActionHook(response, record);
                            }
                            else {
                                This.dialog.error(response);
                                This.method.afterDeactivateErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    }, "<spring:message code='global.deactivate.ask'/>");
                }
            };
            This.method.finalize = function (grid) {
                var record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                // @ts-ignore
                else if (record.editable == false)
                    This.dialog.notEditable();
                // @ts-ignore
                else if (record.estatus.contains(Enums.eStatus2.DeActive))
                    This.dialog.recordIsInactive();
                // @ts-ignore
                else if (record.estatus.contains(Enums.eStatus2.Final))
                    This.dialog.finalRecord();
                else {
                    This.variable.method = "POST";
                    This.dialog.question(function () {
                        This.method.beforeFinalizeActionHook(record);
                        var rpcRequest = {};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + "finalize/" + record["id"];
                        rpcRequest.callback = function (response) {
                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {
                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterFinalizeActionHook(response, record);
                            }
                            else {
                                This.dialog.error(response);
                                This.method.afterFinalizeErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    }, "<spring:message code='global.finalize.ask'/>");
                }
            };
            This.method.disapprove = function (grid) {
                var record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                // @ts-ignore
                else if (record.editable == false)
                    This.dialog.notEditable();
                // @ts-ignore
                else if (record.estatus.contains(Enums.eStatus2.DeActive))
                    This.dialog.recordIsInactive();
                // @ts-ignore
                else if (!record.estatus.contains(Enums.eStatus2.Final))
                    This.dialog.disapproveRecord();
                else {
                    This.variable.method = "POST";
                    This.dialog.question(function () {
                        This.method.beforeDisapproveActionHook(record);
                        var rpcRequest = {};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + "disapprove/" + record["id"];
                        rpcRequest.callback = function (response) {
                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {
                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterDisapproveActionHook(response, record);
                            }
                            else {
                                This.dialog.error(response);
                                This.method.afterDisapproveErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    }, "<spring:message code='global.disapprove.ask'/>");
                }
            };
            This.method.saveForm = function (grid, form) {
                form.validate();
                This.method.saveValidationActionHook(form);
                if (form.hasErrors())
                    return;
                var data = form.getValues();
                data = This.method.saveGetDataActionHook(form, data);
                var rpcRequest = {};
                rpcRequest.actionURL = This.variable.url;
                rpcRequest.data = JSON.stringify(data);
                This.method.jsonRPCManagerRequest(rpcRequest, function (response) {
                    var win = form.getParentElements().last();
                    This.method.refresh(grid);
                    win.close();
                    This.method.saveActionHook(response);
                }, This.method.saveErrorActionHook);
            };
            This.dialog = {
                ok: null,
                say: null,
                error: null,
                question: null,
                notEditable: null,
                activeRecord: null,
                inactiveRecord: null,
                recordIsInactive: null,
                finalRecord: null,
                disapproveRecord: null,
                notSelected: null,
                moreSelected: null
            };
            This.dialog.notEditable = function () {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.editable'/>",
                    icon: "[SKIN]say.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.activeRecord = function () {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.can.not.activate'/>",
                    icon: "[SKIN]say.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.inactiveRecord = function () {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.can.not.deactivate'/>",
                    icon: "[SKIN]say.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.recordIsInactive = function () {
                isc.Dialog.create({
                    message: "<spring:message code='exception.inactive.not-editable'/>",
                    icon: "[SKIN]say.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.finalRecord = function () {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.final.record.not.editable'/>",
                    icon: "[SKIN]say.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.disapproveRecord = function () {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.can.not.disapprove'/>",
                    icon: "[SKIN]say.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({ title: "<spring:message code='global.ok'/>" })],
                    // @ts-ignore
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            };
            This.dialog.notSelected = function () {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]say.png",
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
                    icon: "[SKIN]say.png",
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
