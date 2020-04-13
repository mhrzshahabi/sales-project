/***
 <%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
 <%@ page contentType="text/html;charset=UTF-8" %>
 <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
 **/
function invoiceExport() {
    const ieTab={
        Logs: [],
        Vars: {
            Debug: false,
            Prefix: "invoice-export-tab",
            Url: AccountingConfigs.Urls.CallerSystemRest,
            Urls: {
                systemsUrl : '<spring:eval expression="@environment.getProperty(\'nicico.apps.systems\')"/>',
            },
            Method: "POST",
            ContentType: "application/json; charset=utf-8",
            DefaultFormConfig: {
                showErrorText: true,
                // showErrorStyle: true,
                // showInlineErrors: true,
                errorOrientation: "bottom",
                requiredMessage: "<spring:message code='validator.field.is.required'/>",
                numCols: 2,
                colWidths: ["30%", "*"],
                titleAlign: "right",
            },
            Authorities: {},
            callerSystem : {...window['callerSystemClicked']}
        },
        Methods: {
            JsonRPCManagerRequest: function (props, responseCallBack) {

                if (props == null) return;

                let url = props.url;
                if (url == null) return;

                let method = props.method;
                if (method == null) method = "POST";

                let httpHeaders = props.httpHeaders;
                if (httpHeaders == null) httpHeaders = trainingConfigs.httpHeaders;

                let contentType = props.contentType;
                if (contentType == null) contentType = "application/json; charset=utf-8";

                isc.MyRPCManager.sendRequest({

                    actionURL: url,
                    httpMethod: method,
                    httpHeaders: httpHeaders,
                    contentType: contentType,
                    data: props.data,
                    params: props.params,
                    showPrompt: true,
                    useSimpleHttp: true,
                    serverOutputAsString: false,
                    callback: (response) => responseCallBack(response)
                });
            },
            ConcatObjectsByKey: function (isBoolOperatorAnd, ...objs) {

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
                                result[key] = osiTab.Methods.concatObjectsByKey(isBoolOperatorAnd, first[key], second[key]);
                            else console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                        } else
                            result[key] = second[key];
                    }

                    return result;
                }, {});
            },
            FetchSpecListData: function (usePageStrategy, props, responseCallBack) {

                osiTab.method.jsonRPCManagerRequest(props, (response) => {

                    if (!usePageStrategy || props.params._endRow >= 700) {

                        responseCallBack(response);
                        return;
                    }

                    let currentProps = JSON.parse(JSON.stringify(props));
                    let currentRespons = JSON.parse(response.data).response;

                    if (currentProps.params._endRow >= currentRespons.totalRows) {

                        responseCallBack(response);
                        return;
                    }

                    let data = JSON.parse(JSON.stringify(currentRespons.data));

                    let oldStartRow = currentProps.params._startRow;
                    currentProps.params._startRow = currentProps.params._endRow;
                    currentProps.params._endRow = (currentProps.params._endRow - oldStartRow) + currentProps.params._startRow;

                    evaluationResultTab.method.fetchSpecListData(usePageStrategy, currentProps, (response2) => {

                        let json = JSON.parse(response2.data);
                        data.addAll(json.response.data);
                        response.data = JSON.stringify({
                            response: {
                                data: data,
                                startRow: props.params._startRow,
                                endRow: json.response.totalRows,
                                totalRows: json.response.totalRows
                            }
                        });
                        responseCallBack(response);
                    });
                });
            },
            CreateContextMenu: (refreshFunc, addFunc, editFunc, deleteFunc, excellFunc) => {
                if (typeof (refreshFunc) !== "function") {
                    throw "refresh function is not defined";
                }
                let menuData = [
                    {
                        title: '<spring:message code="global.form.refresh"/> ',
                        icon: "pieces/16/refresh.png",
                        click: refreshFunc,
                    },
                ];
                if (typeof (addFunc) === "function") {
                    menuData.push(
                        {
                            title: '<spring:message code="global.form.new"/>',
                            icon: "pieces/16/icon_add.png",
                            click: addFunc
                        })
                }

                if (typeof (editFunc) === "function") {
                    menuData.push(
                        {
                            title: '<spring:message code="global.form.edit"/>',
                            icon: "pieces/16/icon_edit.png",
                            click: editFunc
                        })
                }
                if (typeof (deleteFunc) === "function") {
                    menuData.push(
                        {
                            title: '<spring:message code="global.form.remove"/>',
                            icon: "pieces/16/icon_delete.png",
                            click: deleteFunc
                        })
                }

                if (typeof (excellFunc) === "function") {
                    menuData.push(
                        {
                            title: '<spring:message code="global.form.print.excel"/>',
                            icon: "icon/excel.gif",
                            click: excellFunc
                        },)
                }
                return isc.Menu.create(
                    {width: "100", data: menuData}
                )
            },
            criteriaBuilder(fieldName,value,operator ="equals",outerOperator="and"){
                return {
                    operator:outerOperator,
                    criteria:[
                        {
                            fieldName:fieldName,
                            operator:operator,
                            value:value
                        }
                    ]
                }
            },
            RefreshAll: () => {
                for (let grid in osiTab.Grids) {
                    try {
                        let iscGrid = window[osiTab.Grids[grid].ID];
                        if (typeof (iscGrid) === "object") {
                            iscGrid.invalidateCache();
                            // iscGrid.deselectAllRecords();
                        }
                    } catch (e) {
                        console.log(e);
                    }

                }
                for (let form in osiTab.DynamicForms.Forms) {
                    let f = window[osiTab.DynamicForms.Forms[form]["ID"]];

                    try {
                        f.clearValues();
                    } catch (e) {
                        console.log(e);
                    }
                }
                for (let windows in osiTab.Layouts.Window) {
                    let w = window[osiTab.Layouts.Window[windows]["ID"]];

                    try {
                        w.hide();
                    } catch (e) {
                        console.log(e);
                    }
                }
            },
            Required: function () {
                return !osiTab.Vars.debug
            },
            CrudDynamicForm: function (props) {
                osiTab.Logs.add(['props:', props]);
                if (typeof (props) === "undefined") return;
                let url = osiTab.Vars.Url;
                let method = osiTab.Vars.Method;
                let httpHeaders = trainingConfigs.httpHeaders;
                let params = "";
                let data = "";
                let callBack = "";
                let defaultResponse = function (response) {
                    osiTab.Logs.add(["return status:", response]);
                    if (response.status === 400 || response.status == 500) {
                        response.text().then(error => {
                            osiTab.Logs.add(["fetch error:", error]);
                            MyRPCManager.handleError({httpResponseText: error});
                        });
                        return;
                    }

                    if (response.status === 200 || response.status === 201) response.text().then(resp => {
                        osiTab.Dialog.Success()
                    });
                    else {
                        response.text().then(error => {
                            osiTab.Logs.add(["fetch error:", error]);
                            MyRPCManager.handleError({httpResponseText: error});
                        });
                    }
                };
                if (typeof (props) === "string") data = props;
                if (typeof (props) === "object") {
                    if (Object.keys(props).contains("data")) {
                        if (typeof (props.data) === "string") {
                            data = props.data;
                        } else if ((typeof (props.data) === "object")) {
                            data = JSON.stringify(props.data)
                        }
                    }
                    if (Object.keys(props).contains("url")) {
                        url = props.url;
                    }
                    if (Object.keys(props).contains("method")) {
                        method = props.method;
                    }
                    if (Object.keys(props).contains("httpHeaders")) {
                        httpHeaders = props.httpHeaders;
                    }
                    if (Object.keys(props).contains("params")) {
                        url = new URL(url);
                        params = (props.params);
                        url.searchParams = new URLSearchParams(params);
                    }
                    if (Object.keys(props).contains("response")) {
                        defaultResponse = props.response;
                    }
                    if (Object.keys(props).contains("callBack")) {
                        callBack = props.callBack;
                    }

                }
                osiTab.Logs.add(['data to send rpc', data]);
                fetch(url, {
                    method: method,
                    headers: httpHeaders,
                    body: data,
                }).then(response => {
                    defaultResponse(response);
                }).finally(() => {
                    osiTab.Logs.add(["fetch finally: ", osiTab.Vars.Method]);
                    if (typeof (callBack) === "function") {
                        callBack()
                    } else {
                    }
                    osiTab.Methods.RefreshAll();
                });
            },
            DynamicFormRefresh: (method = "POST", form) => {
                osiTab.Vars.Method = method;
                form = window[form.ID];
                form.clearValues();
            },
            NewForm: function (iscWindow, form) {
                const win = window[iscWindow.ID];
                osiTab.Methods.DynamicFormRefresh("POST", form);
                win.show();
            },
            Save: function (data, url, callBack) {
                osiTab.Methods.CrudDynamicForm({
                    data: data,
                    url: url,
                    callBack: callBack,
                })
            },
            Edit: function (grid, windowOfForm, form, inputFunc) {
                try {
                    grid = window[grid.ID];
                    windowOfForm = window[windowOfForm.ID];
                    form = window[form.ID];
                    const record = grid.getSelectedRecord();
                    if (record == null || record.id == null) {
                        isc.Dialog.create({
                            message: '<spring:message code="global.grid.record.not.selected"/> ',
                            icon: "[SKIN]warn.png",
                            title: '<spring:message code="global.message"/> ',
                            buttons: [isc.IButtonSave.create({title: "تائید"})],
                            buttonClick: function (button, post) {
                                this.close();
                            }
                        });
                    } else {
                        osiTab.Vars.Method = "PUT";
                        form.clearValues();
                        form.editRecord(record);
                        windowOfForm.show();
                    }
                } catch (e) {
                    console.log("edit error", e);
                } finally {
                    if (typeof (inputFunc) === "function") {
                        inputFunc()
                    }
                }
            },
            Delete: function (grid, deleteUrl, func) {
                try {
                    grid = window[grid.ID];
                    const params = {ids: grid.getSelectedRecords().map(record => record.id)};
                    const data = {ids: grid.getSelectedRecords().map(record => record.id)};
                    if (params.ids.length > 0) {
                        isc.Dialog.create({
                            message: '<spring:message code="global.delete.ask"  />' + "<br>" + params.ids.length + " ",
                            icon: "[SKIN]ask.png",
                            title: '<spring:message code="global.form.remove"/> ' + " " + params.ids.length + " " + '<spring:message code="evluation.item"  />',
                            buttons: [
                                isc.Button.create({title: '<spring:message code="global.yes"/>'}),
                                isc.Button.create({title: '<spring:message code="global.no"/>'})
                            ],
                            buttonClick: function (button, index) {
                                if (index === 0) {
                                    // let urlD = osiTab.Vars.Url + "pattern/list";
                                    // if (typeof (deleteUrl) === "string") urlD = deleteUrl;
                                    osiTab.Methods.CrudDynamicForm({
                                        data: data,
                                        url: deleteUrl,
                                        method: "DELETE",
                                        params: params,
                                    });
                                } else {

                                }

                                // osiTab.log.add(ids);

                                this.hide();

                            }

                        })
                    } else {
                        isc.Dialog.create({
                            message: '<spring:message code="global.grid.record.not.selected"/> ',
                            icon: "[SKIN]warn.png",
                            title: '<spring:message code="global.message"/> ',
                            buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                            buttonClick: function (button, post) {
                                this.close();
                            }
                        });
                    }
                } finally {
                    if (typeof (func) === "function") func();
                }
            },
            HlayoutSaveOrExit: function (saveClickFunc, windowToClose, id = null) {
                windowToCloseIs = () => {
                    const ev = eval(windowToClose);
                    //console.log("ev is",ev);
                    return ev;
                };
                let property = (
                    {
                        layoutMargin: 5,
                        showEdges: false,
                        edgeImage: "",
                        width: "100%",
                        alignLayout: "center",
                        padding: 10,
                        membersMargin: 10,
                        members: [
                            isc.IButtonSave.create({
                                top: 260,
                                title: '<spring:message code="global.form.save"/> ',
                                icon: "pieces/16/save.png",
                                click: () => {
                                    saveClickFunc();
                                }
                            }),
                            isc.IButtonCancel.create({
                                title: '<spring:message code="global.close"/> ',
                                prompt: "",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    try {
                                        let wind = windowToCloseIs();
                                        //console.log("windowToClose:",wind);
                                        wind.closeClick();
                                        osiTab.Methods.RefreshAll();
                                    } catch (e) {
                                        let wind = windowToCloseIs();
                                        //console.log("windowToClose:",wind);
                                        wind.close();
                                    }

                                }
                            })
                        ]
                    }
                );
                if (id !== null && typeof (id) === "string") property["ID"] = id;
                return isc.HLayout.create(property);
            },
            CreateToolStrip: function (refreshFunction, addFunction, editFunction, RemoveFunction) {

                let toolStripMembers = [];
                if ((typeof (addFunction)).toLowerCase() === 'function') {
                    toolStripMembers.add(
                        isc.ToolStripButtonAdd.create({
                            click: addFunction
                        })
                    );
                }
                if ((typeof (editFunction)).toLowerCase() === 'function') {
                    toolStripMembers.add(
                        isc.ToolStripButtonEdit.create({
                            click: editFunction
                        })
                    );
                }
                if ((typeof (RemoveFunction)).toLowerCase() === 'function') {
                    toolStripMembers.add(
                        isc.ToolStripButtonRemove.create({
                            click: RemoveFunction
                        })
                    );
                }
                if (arguments.length > 4) {
                    const ts = arguments.map((currentTs, index) => {
                        if (index > 3) {
                            return isc.ToolStripButton.create({
                                icon: currentTs['icon'],
                                title: currentTs['title'],
                                click: currentTs['click']
                            })
                        }
                    });
                    toolStripMembers = toolStripMembers.concat(ts);
                }
                if ((typeof (refreshFunction)).toLowerCase() === 'function') {
                    toolStripMembers.add(
                        isc.ToolStrip.create({
                            align: "left",
                            members: [isc.ToolStripButtonRefresh.create({click: refreshFunction})]
                        }))
                }
                return toolStripMembers;

            },
            JalaliEpochConvertor(dateTime) {
                if (isNaN(dateTime)) {
                    let syear = Number(dateTime.substr(0, 4));
                    let smonth = Number(dateTime.substr(5, 2));
                    let sday = Number(dateTime.substr(8));
                    return Number(new persianDate([syear, smonth, sday]).format('X')) * 1000;
                }
                return new persianDate(dateTime).toLocale('en').format('YYYY/MM/DD');
            },
        },
        RestDataSources: {},
        DynamicForms: {
            Forms: {},
            FormItems: {},
        },
        Grids: {},
        Layouts: {
            Vlayouts: {},
            Hlayouts: {},
            Window: {},
            PortalLayouts: {},
            Menu: {},
            ToolStrips: {},
            ToolStripButtons: {},
            Ibuttons: {
                Buttons: {},
            },
            Labels: {},
        },
        Fields: {},
        Dialog: {
            NotSelected: function () {

                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Dialog.OK]
                });
            },
            Confirmed: function () {

                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.finalized'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function (button, index) {
                        this.close();
                    }
                });
            },
            Delete: function (clickCallBack) {

                const dialod = isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.remove.ask'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Dialog.OK,isc.Dialog.CANCEL],
                    okClick() {
                        clickCallBack();
                        return this.Super("okClick", arguments);

                    }
                });
            },
            Ok: function () {

                var OkDialog = isc.Dialog.create({
                    message: "<spring:message code='global.form.request.successful'/>",
                    icon: "[SKIN]say.png",
                    title: "<spring:message code='global.ok'/>"
                });
                setTimeout(function () {
                    OkDialog.close();
                }, 3000);
            },
            Error: function (response) {

                osiTab.log["errorResponse"] = response;
                isc.Dialog.create({
                    message: '<spring:message code="global.form.response.error" />',
                    icon: "[SKIN]warn.png",
                    title: '<spring:message code="global.message"/> ',
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function (button, post) {
                        this.close();
                    }
                });
            },
            Success: function () {
                isc.Dialog.create({
                    message: '<spring:message code="global.form.request.successful"/>',
                    icon: "[SKIN]say.png",
                    title: '<spring:message code="global.message"/> ',
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function (button, post) {
                        this.close();
                    }
                });
            }
        },
        Log: {},
    };
}
invoiceExport();
