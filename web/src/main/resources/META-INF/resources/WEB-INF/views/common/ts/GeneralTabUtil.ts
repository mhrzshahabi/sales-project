//------------------------------------------ TS References -----------------------------------------

// @ts-ignore
///<reference path="C:/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/karimi/Java/isomorphic/system/development/smartclient.d.ts" />
///<reference path="/home/saeb/Java/isomorphic/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

    //----------------------------------------- Interfaces -----------------------------------------

    export interface JSPTabVariable {

        log: {};
        variable: { method: string; url: isc.URL; httpHeaders: { authorization: string, "content-type": string }; contentType: string; defaultStylePrefix: string };
        method: {

            transformRequest(request: isc.DSRequest): any,
            concatObjectsByKey(isBoolOperatorAnd: boolean, ...objs: any[]): void,
            fetchData(getAllIfExist: boolean, rpcRequest: Partial<isc.RPCRequest>): void,
            jsonRPCManagerRequest(rpcRequest: Partial<isc.RPCRequest>, okActionHook?: any, errorActionHook?: any): void,
            refresh(grid: isc.ListGrid, refreshActionHook?: any),
            newForm(form: isc.DynamicForm, newActionHook?: any): void,
            editForm(grid: isc.ListGrid, form: isc.DynamicForm, editActionHook?: any),
            delete(grid: isc.ListGrid, deleteActionHook?: any, errorActionHook?: any),
            saveForm(grid: isc.ListGrid, form: isc.DynamicForm, validationActionHook?: any, getDataActionHook?: any, saveActionHook?: any, errorActionHook?: any)
        };
        tab: {};
        chart: {};
        label: {};
        button: {};
        menu: {};
        listGrid: {};
        toolStrip: {};
        dynamicForm: { FormItem: {} };
        hStack: {};
        vStack: {};
        hLayout: {};
        vLayout: {};
        restDataSource: {};
        window: {};
        dialog: {

            notSelected(): void,
            moreSelected(): void,
            ok(warn?: string): void,
            error(response: isc.RPCResponse): void,
            say(message: string, title?: string): void
            question(clickAction: any, message?: string): void
        };
    }

    //----------------------------------------- Interfaces ---------------------------------------//

    //------------------------------------------ Classes -------------------------------------------

    export class GeneralTabUtil {

        private readonly _tab: JSPTabVariableImp;

        constructor() {

            this._tab = new JSPTabVariableImp();
        }

        // external usage
        getDefaultJSPTabVariable(): JSPTabVariable {

            // @ts-ignore
            return {...this._tab};
        }

        // external usage
        static changeProperties(jspTabVariable: JSPTabVariable, propertyName: string, propertyValue: any): JSPTabVariable {

            jspTabVariable[propertyName] = propertyValue;
            return jspTabVariable;
        }
    }

    export class JSPTabVariableImp implements JSPTabVariable {

        log: {};
        variable: { method: string; url: isc.URL; httpHeaders: { authorization: string, "content-type": string }; contentType: string; defaultStylePrefix: string };
        method: {

            transformRequest(request: isc.DSRequest): any,
            concatObjectsByKey(isBoolOperatorAnd: boolean, ...objs: any[]): void,
            fetchData(getAllIfExist: boolean, rpcRequest: isc.RPCRequest): void,
            jsonRPCManagerRequest(rpcRequest: isc.RPCRequest, okActionHook?: any, errorActionHook?: any): void,
            refresh(grid: isc.ListGrid, refreshActionHook?: any): void,
            newForm(form: isc.DynamicForm, newActionHook?: any): void,
            editForm(grid: isc.ListGrid, form: isc.DynamicForm, editActionHook?: any): void
            delete(grid: isc.ListGrid, deleteActionHook?: any, errorActionHook?: any): void,
            saveForm(grid: isc.ListGrid, form: isc.DynamicForm, validationActionHook?: any, getDataActionHook?: any, saveActionHook?: any, errorActionHook?: any)
        };
        tab: {};
        chart: {};
        label: {};
        button: {};
        menu: {};
        listGrid: {};
        toolStrip: {};
        dynamicForm: {
            FormItem: {}
        };
        hStack: {};
        vStack: {};
        hLayout: {};
        vLayout: {};
        restDataSource: {};
        window: {};
        dialog: {

            notSelected(): void,
            moreSelected(): void,
            ok(warn ?: string): void,
            error(response: isc.RPCResponse): void,
            say(message: string, title?: string): void
            question(clickAction: any, message?: string): void
        };

        constructor() {

            let This = this;
            This.variable = {

                url: "",
                method: null,
                contentType: "",
                httpHeaders: {authorization: "", "content-type": ""},
                defaultStylePrefix: ""
            };
            This.variable.method = "POST";
            // @ts-ignore
            This.variable.url = "${contextPath}";
            // @ts-ignore
            This.variable.httpHeaders = BaseRPCRequest.httpHeaders;
            This.variable.contentType = "application/json; charset=utf-8";
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
            This.method.transformRequest = function (dsRequest: isc.DSRequest) {

                // @ts-ignore
                dsRequest.httpHeaders = BaseRPCRequest.httpHeaders;
                return this.Super("transformRequest", arguments);
            };
            This.method.concatObjectsByKey = function (isBoolOperatorAnd, ...objs) {

                return objs.reduce((first, second) => {

                    let result = {};
                    for (let key in second) {

                        if (first.hasOwnProperty(key)) {

                            if (second[key] == null) return;
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
                            else console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                        } else
                            result[key] = second[key];
                    }

                    return result;
                }, {});
            };
            This.method.fetchData = function (getAllIfExist: boolean, rpcRequest: isc.RPCRequest) {

                let callBack = rpcRequest.callback;
                rpcRequest.callback = function (response: isc.RPCResponse) {

                    if (!getAllIfExist) {

                        callBack(response);
                        return;
                    }

                    let currentProps = {...rpcRequest};
                    // @ts-ignore
                    let currentRespons = JSON.parse(response.data).response;

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

                    let data = {...currentRespons.data};

                    // @ts-ignore
                    let oldStartRow = currentProps.params._startRow;
                    // @ts-ignore
                    currentProps.params._startRow = currentProps.params._endRow;
                    // @ts-ignore
                    currentProps.params._endRow = (currentProps.params._endRow - oldStartRow) + currentProps.params._startRow;

                    currentProps.callback = function (response2: isc.RPCResponse) {

                        // @ts-ignore
                        let json = JSON.parse(response2.data);
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
            This.method.jsonRPCManagerRequest = function (rpcRequest: isc.RPCRequest, okActionHook?: any, errorActionHook?: any) {

                if (rpcRequest == null) return;

                if (rpcRequest.callback == null)
                    rpcRequest.callback = function (response) {

                        if (response.httpResponseCode === 201 || response.httpResponseCode === 200) {

                            This.dialog.ok();

                            if (okActionHook != null) okActionHook(response);
                        } else {

                            This.dialog.error(response);

                            if (errorActionHook != null) errorActionHook(response);
                        }
                    };

                if (rpcRequest.actionURL == null) rpcRequest.actionURL = This.variable.url;
                if (rpcRequest.httpMethod == null) rpcRequest.httpMethod = This.variable.method;
                if (rpcRequest.httpHeaders == null) rpcRequest.httpHeaders = This.variable.httpHeaders;
                if (rpcRequest.contentType == null) rpcRequest.contentType = This.variable.contentType;

                isc.RPCManager.sendRequest(rpcRequest);
            };
            This.method.refresh = function (grid: isc.ListGrid, refreshActionHook?: any) {

                grid.invalidateCache();
                if (refreshActionHook != null) refreshActionHook();
            };
            This.method.newForm = function (form: isc.DynamicForm, newActionHook?: any): void {

                This.variable.method = "POST";
                form.clearValues();

                var win = form.getParentElements().last();
                win.show();

                if (newActionHook != null) newActionHook();
            };
            This.method.editForm = function (grid: isc.ListGrid, form: isc.DynamicForm, editActionHook?: any): void {

                let record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                else {

                    This.variable.method = "PUT";

                    form.clearValues();
                    form.editRecord({...record});

                    var win = form.getParentElements().last();
                    win.show();

                    if (editActionHook != null) editActionHook(record);
                }
            };
            This.method.delete = function (grid: isc.ListGrid, deleteActionHook?: any, errorActionHook?: any) {

                let record = grid.getSelectedRecord();
                if (record == null || record["id"] == null)
                    This.dialog.notSelected();
                else {

                    This.variable.method = "DELETE";
                    This.dialog.question(() => {

                        let rpcRequest = <isc.RPCRequest>{};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + record["id"];
                        rpcRequest.callback = function (response) {

                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {

                                This.dialog.ok();
                                This.method.refresh(grid);
                                if (deleteActionHook != null) deleteActionHook(record);
                            } else {

                                This.dialog.error(response);

                                if (errorActionHook != null) errorActionHook(record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    });
                }
            };
            This.method.saveForm = function (grid: isc.ListGrid, form: isc.DynamicForm, validationActionHook?: any, getDataActionHook?: any, saveActionHook?: any, errorActionHook?: any): void {

                form.validate();
                if (validationActionHook != null)
                    validationActionHook(form);
                if (form.hasErrors())
                    return;

                let data = form.getValues();
                if (getDataActionHook != null) data = getDataActionHook(form, data);

                let url = This.variable.url + (This.variable.method.toUpperCase() == "POST" ? "" : data["id"]);

                let rpcRequest = <isc.RPCRequest>{};
                rpcRequest.data = data;
                rpcRequest.actionURL = url;
                This.method.jsonRPCManagerRequest(rpcRequest, (response) => {
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
            This.dialog.ok = function (warn: string = "") {

                let OkDialog;
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
            This.dialog.say = function (message: string, title?: string) {

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
            This.dialog.error = function (response: isc.RPCResponse) {

                This.log["errorResponse"] = response;
                isc.RPCManager.handleError(response, null);
            };
            This.dialog.question = function (clickAction: any, message: string = "<spring:message code='global.delete.ask'/>") {

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
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
