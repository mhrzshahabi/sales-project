//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>
///<reference path="FormUtil.ts"/>

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

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
            beforeRefreshActionHook(): void,
            afterRefreshActionHook(): void,
            beforeShowNewActionHook(): void,
            afterShowNewActionHook(window: FormUtil): void,
            beforeShowEditActionHook(record: any): void,
            afterShowEditActionHook(window: FormUtil, record: any): void,
            beforeDeleteActionHook(record: any): void,
            afterDeleteActionHook(response: isc.RPCResponse, record: any): void,
            afterDeleteErrorActionHook(response: isc.RPCResponse, record: any): void,
            beforeActivateActionHook(record: any): void,
            afterActivateActionHook(response: isc.RPCResponse, record: any): void,
            afterActivateErrorActionHook(response: isc.RPCResponse, record: any): void,
            beforeDeactivateActionHook(record: any): void,
            afterDeactivateActionHook(response: isc.RPCResponse, record: any): void,
            afterDeactivateErrorActionHook(response: isc.RPCResponse, record: any): void,
            beforeFinalizeActionHook(record: any): void,
            afterFinalizeActionHook(response: isc.RPCResponse, record: any): void,
            afterFinalizeErrorActionHook(response: isc.RPCResponse, record: any): void,
            beforeDisapproveActionHook(record: any): void,
            afterDisapproveActionHook(response: isc.RPCResponse, record: any): void,
            afterDisapproveErrorActionHook(response: isc.RPCResponse, record: any): void,
            saveValidationActionHook(form: isc.DynamicForm): void,
            saveGetDataActionHook(form: isc.DynamicForm, data: any): any,
            saveActionHook(response: isc.RPCResponse): void,
            saveErrorActionHook(response: isc.RPCResponse): void,
            refresh(grid: isc.ListGrid): void,
            newForm(title: string, grid: isc.ListGrid, form: isc.DynamicForm): void,
            editForm(title: string, grid: isc.ListGrid, form: isc.DynamicForm): void,
            delete(grid: isc.ListGrid): void,
            activate(grid: isc.ListGrid): void,
            deactivate(grid: isc.ListGrid): void,
            finalize(grid: isc.ListGrid): void,
            disapprove(grid: isc.ListGrid): void,
            saveForm(grid: isc.ListGrid, form: isc.DynamicForm): void
        };
        tab: {};
        chart: {};
        label: {};
        button: {};
        menu: {};
        listGrid: {
            criteria: Criteria,
            fields: Array<isc.ListGridField>
        };
        toolStrip: {};
        dynamicForm: { fields: Array<isc.FormItem> };
        hStack: {};
        vStack: {};
        hLayout: {};
        vLayout: {};
        restDataSource: {};
        window: {};
        sectionStack: {};
        filterBuilder: {};
        dialog: {

            notEditable(): void,
            activeRecord(): void,
            inactiveRecord(): void,
            recordIsInactive(): void,
            finalRecord(): void,
            disapproveRecord(): void,
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
            beforeRefreshActionHook(): void,
            afterRefreshActionHook(): void,
            beforeShowNewActionHook(): void,
            afterShowNewActionHook(window: FormUtil): void,
            beforeShowEditActionHook(record: any): void,
            afterShowEditActionHook(window: FormUtil, record: any): void,
            beforeDeleteActionHook(record: any): void,
            afterDeleteActionHook(response: isc.RPCResponse, record: any): void,
            afterDeleteErrorActionHook(response: isc.RPCResponse, record: any): void,
            beforeActivateActionHook(record: any): void,
            afterActivateActionHook(response: isc.RPCResponse, record: any): void,
            afterActivateErrorActionHook(response: isc.RPCResponse, record: any): void,
            beforeDeactivateActionHook(record: any): void,
            afterDeactivateActionHook(response: isc.RPCResponse, record: any): void,
            afterDeactivateErrorActionHook(response: isc.RPCResponse, record: any): void,
            beforeFinalizeActionHook(record: any): void,
            afterFinalizeActionHook(response: isc.RPCResponse, record: any): void,
            afterFinalizeErrorActionHook(response: isc.RPCResponse, record: any): void,
            beforeDisapproveActionHook(record: any): void,
            afterDisapproveActionHook(response: isc.RPCResponse, record: any): void,
            afterDisapproveErrorActionHook(response: isc.RPCResponse, record: any): void,
            saveValidationActionHook(form: isc.DynamicForm): void,
            saveGetDataActionHook(form: isc.DynamicForm, data: any): any,
            saveActionHook(response: isc.RPCResponse): void,
            saveErrorActionHook(response: isc.RPCResponse): void,
            refresh(grid: isc.ListGrid): void,
            newForm(title: string, grid: isc.ListGrid, form: isc.DynamicForm): void,
            editForm(title: string, grid: isc.ListGrid, form: isc.DynamicForm): void
            delete(grid: isc.ListGrid): void,
            activate(grid: isc.ListGrid): void,
            deactivate(grid: isc.ListGrid): void,
            finalize(grid: isc.ListGrid): void,
            disapprove(grid: isc.ListGrid): void,
            saveForm(grid: isc.ListGrid, form: isc.DynamicForm): void
        };
        tab: {};
        chart: {};
        label: {};
        button: {};
        menu: {};
        listGrid: {
            criteria: Criteria,
            fields: Array<isc.ListGridField>
        };
        toolStrip: {};
        dynamicForm: {
            fields: Array<isc.FormItem>
        };
        hStack: {};
        vStack: {};
        hLayout: {};
        vLayout: {};
        restDataSource: {};
        window: {};
        sectionStack: {};
        filterBuilder: {};
        dialog: {

            notEditable(): void,
            activeRecord(): void,
            inactiveRecord(): void,
            recordIsInactive(): void,
            finalRecord(): void,
            disapproveRecord(): void,
            notSelected(): void,
            moreSelected(): void,
            ok(warn ?: string): void,
            error(response: isc.RPCResponse): void,
            say(message: string, title?: string): void
            question(clickAction: any, message?: string): void
        };

        constructor() {

            let This = this;

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
            This.filterBuilder = {};
            This.window = {};
            This.sectionStack = {};
            This.variable = {

                url: "",
                method: null,
                contentType: "",
                httpHeaders: {authorization: "", "content-type": ""},
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

                if (rpcRequest.callback == null) {
                    
                    rpcRequest.willHandleError = true;
                    rpcRequest.callback = function (response) {

                        if (response.httpResponseCode === 201 || response.httpResponseCode === 200) {

                            This.dialog.ok();

                            if (okActionHook != null) okActionHook(response);
                        } else {

                            This.dialog.error(response);

                            if (errorActionHook != null) errorActionHook(response);
                        }
                    };
                }

                if (rpcRequest.actionURL == null) rpcRequest.actionURL = This.variable.url;
                if (rpcRequest.httpMethod == null) rpcRequest.httpMethod = This.variable.method;
                if (rpcRequest.httpHeaders == null) rpcRequest.httpHeaders = This.variable.httpHeaders;
                if (rpcRequest.contentType == null) rpcRequest.contentType = This.variable.contentType;
                if (rpcRequest.useSimpleHttp == null) rpcRequest.useSimpleHttp = true;
                if (rpcRequest.showPrompt == null) rpcRequest.showPrompt = true;
                if (rpcRequest.serverOutputAsString == null) rpcRequest.serverOutputAsString = false;
                if (rpcRequest.willHandleError == null) rpcRequest.willHandleError = false;

                isc.RPCManager.sendRequest(rpcRequest);
            };

            This.method.beforeRefreshActionHook = function () {};
            This.method.afterRefreshActionHook = function () {};
            This.method.beforeShowNewActionHook = function () {};
            This.method.afterShowNewActionHook = function (window: FormUtil) {};
            This.method.beforeShowEditActionHook = function (record: any) {};
            This.method.afterShowEditActionHook = function (window: FormUtil, record: any) {};
            This.method.beforeDeleteActionHook = function (record: any) {};
            This.method.afterDeleteActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.afterDeleteErrorActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.beforeActivateActionHook = function (record: any) {};
            This.method.afterActivateActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.afterActivateErrorActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.beforeDeactivateActionHook = function (record: any) {};
            This.method.afterDeactivateActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.afterDeactivateErrorActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.beforeFinalizeActionHook = function (record: any) {};
            This.method.afterFinalizeActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.afterFinalizeErrorActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.beforeDisapproveActionHook = function (record: any) {};
            This.method.afterDisapproveActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.afterDisapproveErrorActionHook = function (response: isc.RPCResponse, record: any) {};
            This.method.saveValidationActionHook = function (form: isc.DynamicForm) {};
            This.method.saveGetDataActionHook = function (form: isc.DynamicForm, data: any): any {
                return data;
            };
            This.method.saveActionHook = function (response: isc.RPCResponse) {};
            This.method.saveErrorActionHook = function (response: isc.RPCResponse) {};
            This.method.refresh = function (grid: isc.ListGrid) {

                This.method.beforeRefreshActionHook();
                grid.invalidateCache();
                This.method.afterRefreshActionHook();
            };
            This.method.newForm = function (title: string, grid: isc.ListGrid, form: isc.DynamicForm): void {

                This.method.beforeShowNewActionHook();
                
                This.variable.method = "POST";
                form.clearValues();

                let formUtil = new FormUtil();
                formUtil.validate = function (data) {
                    form.validate();
                    return !form.hasErrors();
                };
                formUtil.okCallBack = function (data) {
                    This.method.saveForm(grid, form);
                };
                // @ts-ignore
                let width = form.windowWidth == null ? "50%" : form.windowWidth;
                // @ts-ignore
                let height = form.windowHeight;
                formUtil.showForm(null, title, form, width, height);
                form.show();

                This.method.afterShowNewActionHook(formUtil);
            };
            This.method.editForm = function (title: string, grid: isc.ListGrid, form: isc.DynamicForm): void {

                let record = grid.getSelectedRecord();
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
                    form.editRecord({...record});

                    let formUtil = new FormUtil();
                    formUtil.validate = function (data) {
                        form.validate();
                        return !form.hasErrors();
                    };
                    formUtil.okCallBack = function (data) {
                        This.method.saveForm(grid, form);
                    };
                    // @ts-ignore
                    let width = form.windowWidth == null ? "50%" : form.windowWidth;
                    // @ts-ignore
                    let height = form.windowHeight;
                    formUtil.showForm(null, title, form, width, height);
                    form.show();

                    This.method.afterShowEditActionHook(formUtil, record);
                }
            };
            This.method.delete = function (grid: isc.ListGrid) {

                let record = grid.getSelectedRecord();
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
                    This.dialog.question(() => {

                        This.method.beforeDeleteActionHook(record);

                        let rpcRequest = <isc.RPCRequest>{};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + record["id"];
                        rpcRequest.callback = function (response) {

                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {

                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterDeleteActionHook(response, record);
                            } else {

                                This.dialog.error(response);

                                This.method.afterDeleteErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    });
                }
            };
            This.method.activate = function (grid: isc.ListGrid) {

                let record = grid.getSelectedRecord();
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
                    This.dialog.question(() => {

                        This.method.beforeActivateActionHook(record);

                        let rpcRequest = <isc.RPCRequest>{};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + "activate/" + record["id"];
                        rpcRequest.callback = function (response) {

                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {

                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterActivateActionHook(response, record);
                            } else {

                                This.dialog.error(response);

                                This.method.afterActivateErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    }, "<spring:message code='global.activate.ask'/>");
                }
            };
            This.method.deactivate = function (grid: isc.ListGrid) {

                let record = grid.getSelectedRecord();
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
                    This.dialog.question(() => {

                        This.method.beforeDeactivateActionHook(record);

                        let rpcRequest = <isc.RPCRequest>{};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + "deactivate/" + record["id"];
                        rpcRequest.callback = function (response) {

                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {

                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterDeactivateActionHook(response, record);
                            } else {

                                This.dialog.error(response);

                                This.method.afterDeactivateErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    }, "<spring:message code='global.deactivate.ask'/>");
                }
            };
            This.method.finalize = function (grid: isc.ListGrid) {

                let record = grid.getSelectedRecord();
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
                    This.dialog.question(() => {

                        This.method.beforeFinalizeActionHook(record);

                        let rpcRequest = <isc.RPCRequest>{};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + "finalize/" + record["id"];
                        rpcRequest.callback = function (response) {

                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {

                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterFinalizeActionHook(response, record);
                            } else {

                                This.dialog.error(response);

                                This.method.afterFinalizeErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    }, "<spring:message code='global.finalize.ask'/>");
                }
            };
            This.method.disapprove = function (grid: isc.ListGrid) {

                let record = grid.getSelectedRecord();
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
                    This.dialog.question(() => {

                        This.method.beforeDisapproveActionHook(record);

                        let rpcRequest = <isc.RPCRequest>{};
                        rpcRequest.httpMethod = This.variable.method;
                        rpcRequest.actionURL = This.variable.url + "disapprove/" + record["id"];
                        rpcRequest.callback = function (response) {

                            if (response.httpResponseCode === 200 || response.httpResponseCode === 201) {

                                This.dialog.ok();
                                This.method.refresh(grid);
                                This.method.afterDisapproveActionHook(response, record);
                            } else {

                                This.dialog.error(response);

                                This.method.afterDisapproveErrorActionHook(response, record);
                            }
                        };
                        This.method.jsonRPCManagerRequest(rpcRequest);
                    }, "<spring:message code='global.disapprove.ask'/>");
                }
            };
            This.method.saveForm = function (grid: isc.ListGrid, form: isc.DynamicForm): void {

                form.validate();
                This.method.saveValidationActionHook(form);
                if (form.hasErrors())
                    return;

                let data = form.getValues();
                data = This.method.saveGetDataActionHook(form, data);

                let rpcRequest = <isc.RPCRequest>{};
                rpcRequest.actionURL = This.variable.url;
                rpcRequest.data = JSON.stringify(data);
                This.method.jsonRPCManagerRequest(rpcRequest, (response) => {
                    let win = form.getParentElements().last();
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
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                        buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                        buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                    title: title || "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
