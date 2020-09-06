/**
 <%@ page contentType="text/html;charset=UTF-8" %>
 <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
 **/

async function getAccessToken(user = "user", password = "password") {
    const response = await fetch("http://apps.nicico.com/oauth/token", {
        "headers": {
            "authorization": "Basic U2FsZXM6MmxPbGZxdHowMldDQjFOYXBKUEs=",
            "content-type": "application/x-www-form-urlencoded"
        },
        "body": "grant_type=password&username=" + user + "&password=" + password,
        "method": "POST",
    });
    const json = await response.json()
    return json['access_token'];
}


const crTab = {
    Logs: [],
    Vars: {
        Debug: false,
        Prefix: "bill_of_landing_detail_tab" + Math.random().toString().substr(-6),
        Url: SalesConfigs.Urls.remittanceRest,
        Urls: {},
        Method: "PUT",
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
        DefaultWindowConfig: {
            width: .8 * window.innerWidth,
            // height: .8 * window.innerHeight,
            autoSize: true,
            autoCenter: true,
            showMinimizeButton: false,
            isModal: true,
            showModalMask: true,
            align: "center",
            autoDraw: true,
            title: '',
            showTitle: true,
            dismissOnEscape: true,
            closeClick: function () {
                this.Super("closeClick", arguments)
            },
        },
        Authorities: {},
    },
    Methods: {
        CreateWindowForForm: function (formItems, url, numCols = 6, extraOption = {win: {}, form: {}}) {
            const form = isc.DynamicForm.create({
                items: [...formItems],
                numCols: numCols,
                ...extraOption.form,
            })

            function saveMethod() {
                if (!form.validate()) return;
                crTab.Methods.Save(form.getValues(), url)
            }

            const id = crTab.Vars.Prefix + "window_BL" + Math.random().toString().substr(2, 6)
            const win = isc.Window.create({
                ID: id,
                ...crTab.Vars.DefaultWindowConfig,
                visibility: "hidden",
                members: [
                    isc.VLayout.create({
                        members: [
                            isc.HLayout.create({members: [form], height: "100%"}),
                            crTab.Methods.HlayoutSaveOrExit(saveMethod, id,)
                        ]
                    }),
                ],
                ...extraOption.win
            })
            return [win, form]
        },
        JsonRPCManagerRequest: function (props, responseCallBack) {

            if (props == null) return;

            let url = props.url;
            if (url == null) return;

            let method = props.method;
            if (method == null) method = "POST";

            let httpHeaders = props.httpHeaders;
            if (httpHeaders == null) httpHeaders = SalesConfigs.httpHeaders;

            let contentType = props.contentType;
            if (contentType == null) contentType = "application/json; charset=utf-8";

            isc.RPCManager.sendRequest({
                ...{BaseRPCRequest},
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
                            result[key] = crTab.Methods.concatObjectsByKey(isBoolOperatorAnd, first[key], second[key]);
                        else console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                    } else
                        result[key] = second[key];
                }

                return result;
            }, {});
        },
        FetchSpecListData: function (usePageStrategy, props, responseCallBack) {

            crTab.method.jsonRPCManagerRequest(props, (response) => {

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

                crTab.method.fetchSpecListData(usePageStrategy, currentProps, (response2) => {

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
        criteriaBuilder(fieldName, value, operator = "equals", outerOperator = "and") {
            return {
                operator: outerOperator,
                criteria: [
                    {
                        fieldName: fieldName,
                        operator: operator,
                        value: value
                    }
                ]
            }
        },
        RefreshAll: () => {
            for (let grid in crTab.Grids) {
                try {
                    let iscGrid = window[crTab.Grids[grid].ID];
                    if (typeof (iscGrid) === "object") {
                        iscGrid.invalidateCache();
                        // iscGrid.deselectAllRecords();
                    }
                } catch (e) {
                    console.log(e);
                }

            }
            for (let form in crTab.DynamicForms.Forms) {
                let f = window[crTab.DynamicForms.Forms[form]["ID"]];

                try {
                    f.clearValues();
                } catch (e) {
                    console.log(e);
                }
            }
            for (let windows in crTab.Layouts.Window) {
                let w = window[crTab.Layouts.Window[windows]["ID"]];

                try {
                    w.hide();
                } catch (e) {
                    console.log(e);
                }
            }
        },
        Required: function () {
            return !crTab.Vars.debug
        },
        CrudDynamicForm: async function (props) {
            crTab.Logs.add(['props:', props]);
            if (typeof (props) === "undefined") return;
            let url = crTab.Vars.Url;
            let method = crTab.Vars.Method;
            let httpHeaders = SalesConfigs.httpHeaders;
            let params = "";
            let data = "";
            let callBack = "";
            let defaultResponse = async function (response) {
                crTab.Logs.add(["return status:", response]);
                if (response.status === 400 || response.status == 500) {
                    response.text().then(error => {
                        crTab.Logs.add(["fetch error:", error]);
                        // MyRPCManager.handleError({httpResponseText: error});
                        isc.warn("مشکلی پیش آمد. مشکل جهت گزارش:\n" + JSON.stringify(error));
                    });
                    return;
                }

                if (response.status === 200 || response.status === 201) {
                    // await response.text()
                    crTab.Dialog.Success();
                    crTab.Grids.BillOfLanding.obj.invalidateCache();
                } else {
                    const error = await response.text();
                    crTab.Logs.add(["fetch error:", error]);
                    RPCManager.handleError({httpResponseText: error});
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
            crTab.Logs.add(['data to send rpc', data]);
            const response = await fetch(url, {
                method: method,
                headers: httpHeaders,

                body: data,
            })
            defaultResponse(response);
        },
        DynamicFormRefresh: (method = "POST", form) => {
            crTab.Vars.Method = method;
            form = window[form.ID];
            form.clearValues();
        },
        NewForm: function (iscWindow, form) {
            const win = window[iscWindow.ID];
            crTab.Methods.DynamicFormRefresh("POST", form);
            win.show();
        },
        Save: async function (data, url, callBack) {
            await crTab.Methods.CrudDynamicForm({
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
                    crTab.Vars.Method = "PUT";
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
                        message: '<spring:message code="global.delete.ask"  />' + "<br>" + params.ids.length + " " + 'مورد',
                        icon: "[SKIN]ask.png",
                        title: '<spring:message code="global.form.remove"/> ' + " " + params.ids.length + " " + 'مورد',
                        buttons: [
                            isc.Button.create({title: '<spring:message code="global.yes"/>'}),
                            isc.Button.create({title: '<spring:message code="global.no"/>'})
                        ],
                        buttonClick: function (button, index) {
                            if (index === 0) {
                                // let urlD = crTab.Vars.Url + "pattern/list";
                                // if (typeof (deleteUrl) === "string") urlD = deleteUrl;
                                crTab.Methods.CrudDynamicForm({
                                    data: data,
                                    url: deleteUrl,
                                    method: "DELETE",
                                    params: params,
                                });
                            } else {

                            }

                            // crTab.log.add(ids);

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
                    height: "100%",
                    alignLayout: "bottom",
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
                                    crTab.Methods.RefreshAll();
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
        Vlayouts: {
            CreateMainVlayOut(members) {
                return isc.VLayout.create(
                    {
                        ID: crTab.Vars.Prefix + "vـlayoutـmain",
                        width: "100%",
                        height: "100%",
                        members: members
                    });
            }
        },
        Hlayouts: {},
        Window: {},
        PortalLayouts: {},
        Menu: {},
        ToolStrips: {
            CreateMainToolStrip: function () {
                return isc.HLayout.create({
                    width: "100%",
                    members:
                        [isc.ToolStrip.create({
                            ID: crTab.Vars.Prefix + "toolـstripـmain",
                            width: "100%",
                            members:
                                [
                                    //    <sec:authorize access="hasAuthority('C_PARAMETERS')">
                                    isc.ToolStripButtonAdd.create({
                                        // ID: crTab.Vars.Prefix + "toolـstripـbuttonـadd",
                                        ...crTab.Layouts.ToolStripButtons.new,
                                    }),
                                    //  </sec:authorize>
                                    //   <sec:authorize access="hasAuthority('U_PARAMETERS')">
                                    isc.ToolStripButtonEdit.create({
                                        // ID: crTab.Vars.Prefix + "toolـstripـbuttonـadd",
                                        ...crTab.Layouts.ToolStripButtons.edit,
                                    }),

                                    ,
                                    //   </sec:authorize>
                                    //    <sec:authorize access="hasAuthority('D_PARAMETERS')">
                                    isc.ToolStripButtonRemove.create({
                                        ...crTab.Layouts.ToolStripButtons.remove,
                                        // ID: crTab.Vars.Prefix + "tool_stripـbuttonـremove",
                                    }),
                                    //    </sec:authorize>
                                    isc.ToolStrip.create({
                                        width: "100%",
                                        align: "left",
                                        border: '0px',
                                        members: [
                                            isc.ToolStripButtonRefresh.create({
                                                ...crTab.Layouts.ToolStripButtons.refresh,
                                                // ID: crTab.Vars.Prefix + "tool_strip_button_refresh",
                                            }),
                                        ]
                                    })
                                ]
                        })]
                });
            }
        },
        ToolStripButtons: {
            new: {
                title: "<spring:message code='global.form.new'/>",
                click: function () {

                }
            },
            edit: {
                icon: "[SKIN]/actions/edit.png",
                title: "<spring:message code='global.form.edit'/>",
                click: function () {
                }
            },
            remove: {
                icon: "[SKIN]/actions/remove.png",
                title: "<spring:message code='global.form.remove'/>",
                click: function () {
                }
            },
            refresh: {
                title: "<spring:message code='global.form.refresh'/>",
                click: function () {
                }
            }
        },
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
                buttons: [isc.Dialog.OK, isc.Dialog.CANCEL],
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

            crTab.log["errorResponse"] = response;
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
////////////////////////////////////////////////////////VARIABLES///////////////////////////////////////////////////////
////////////////////////////////////////////////////////METHODS/////////////////////////////////////////////////////////
crTab.Methods.getFirstDayOfSeason = () => {
    const today = new persianDate();
    const firstMonthOfThisSeason = Number(((today.month() - 1) / 3).toFixed(1).substr(0, 1)) * 3 + 1
    return today.year().toString() + "/" + firstMonthOfThisSeason.toString().padStart(2, "0") + "/01"
}
crTab.Methods.UpdateInputOutputCharts = function () {
    crTab.Grids.RemittanceDetail.fetchData({
        _constructor: "AdvancedCriteria",
        operator: 'and',
        criteria: [
            {
                fieldName: 'date',
                operator: 'lessOrEqual',
                value: new persianDate().subtract('d', 1).format('YYYYMMDD')
            },
            {
                fieldName: 'inventory.weight',
                operator: 'greaterThan',
                value: 0
            },
        ]
    })
    const fromYear = Number(crTab.DynamicForms.ChartDate.getValue('fromDate').replaceAll("/", "").substr(0, 4));
    const fromMonth = Number(crTab.DynamicForms.ChartDate.getValue('fromDate').replaceAll("/", "").substr(4, 2));
    const toYear = Number(crTab.DynamicForms.ChartDate.getValue('toDate').replaceAll("/", "").substr(0, 4));
    const toMonth = Number(crTab.DynamicForms.ChartDate.getValue('toDate').replaceAll("/", "").substr(0, 2));
    const _facet = fromYear - toYear !== 0 ? {
        id: "year",
        title: "ماه"
    } : (toMonth - fromMonth > 0 ? {
        id: "month",
        title: "سال"
    } : {
        id: "day",
        title: "روز"
    })
    // dbg(true,_facet)
    fetch('api/remittance-detail/spec-list/?criteria=' + JSON.stringify(
        {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria:
                [
                    {
                        fieldName: "date",
                        operator: "lessOrEqual",
                        value: crTab.DynamicForms.ChartDate.getValue('toDate').replaceAll("/", "")
                    },
                    {
                        fieldName: "date",
                        operator: "greaterOrEqual",
                        value: crTab.DynamicForms.ChartDate.getValue('fromDate').replaceAll("/", "")

                    },]
        }), {headers: SalesConfigs.httpHeaders}).then(r => {
        if (r.ok) {
            r.json().then(
                j => {

                    const dataCame = j.response.data.filter(_ => _.destinationTozin).map(_ => {
                        _.material = _.inventory.materialItem.gdsName;
                        _.day = _.date.toString().substr(6, 2);
                        _.month = _.date.toString().substr(4, 2);
                        _.year = _.date.toString().substr(0, 4);
                        return _;

                    })
                    const dataWent = j.response.data.filter(_ => !_.destinationTozin).map(_ => {
                        _.material = _.inventory.materialItem.gdsName;
                        _.day = _.date.toString().substr(6, 2);
                        _.month = _.date.toString().substr(4, 2);
                        _.year = _.date.toString().substr(0, 4);
                        return _;

                    })
                    crTab.Layouts.Vlayouts.Chart.setMembers([]);
                    crTab.Layouts.Vlayouts.Chart.addMember(
                        isc.HLayout.create({
                            members: [
                                isc.FacetChart.create({
                                    facets: [{
                                        id: "material",    // the key used for this facet in the data above
                                        title: "محصول"  // the user-visible title you want in the chart
                                    }, _facet],
                                    data: dataCame,        // a reference to our data above
                                    valueProperty: "amount", // the property in our data that is the numerical value to chart
                                    chartType: "Pie",
                                    title: "آمار ورودی انبار از " +
                                        crTab.DynamicForms.ChartDate.getValue('fromDate') +
                                        'تا ' +
                                        crTab.DynamicForms.ChartDate.getValue('toDate'), // a title for the chart as a whole
                                    showInlineLabels: true,
                                    showDataValues: true,
                                    showDataPoints: true,
                                    showStatisticsOverData: true,

                                }),
                                isc.FacetChart.create({
                                    facets: [{
                                        id: "material",    // the key used for this facet in the data above
                                        title: "محصول"  // the user-visible title you want in the chart
                                    }, _facet],
                                    data: dataWent,        // a reference to our data above
                                    valueProperty: "amount", // the property in our data that is the numerical value to chart
                                    chartType: "Pie",
                                    title: "آمار خروجی انبار از " +
                                        crTab.DynamicForms.ChartDate.getValue('fromDate') +
                                        'تا ' +
                                        crTab.DynamicForms.ChartDate.getValue('toDate'), // a title for the chart as a whole
                                    showInlineLabels: true,
                                    showDataValues: true,
                                    showDataPoints: true,
                                    showStatisticsOverData: true,

                                })


                            ]
                        })
                    )


                }
            )
        }
    })
}

////////////////////////////////////////////////////////FIELDS//////////////////////////////////////////////////////////
crTab.Fields.RemittanceDetail = _ => [
    {
        name: "date", hidden: true, type: "text",
        filterEditorProperties: {
            // defaultValue: new persianDate().toLocale('en').subtract('d', 14).format('YYYY/MM/DD'),
            keyPressFilter: "[0-9/]",
            parseEditorValue: function (value, record, form, item) {
                if (value === undefined || value == null || value === '') return value;
                return value.replace(/\//g, '')
            },
            icons: [{
                src: "pieces/pcal.png",
                click: function (form, item, icon) {
                    // console.log(form)
                    displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '');
                }
            }],
        },
    },
    {
        name: "remittance.code", type: "text",
        title: "شماره بیجک"

    },
    {
        name: "inventory.materialItemId",
        title: "محصول",
        valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName"),
    },
    {
        name: "inventory.weight", type: "number", summaryFunction: "sum",
        title: "وزن",
    },
    {
        name: "inventory.amount", type: "number", summaryFunction: "sum", title: "تعداد",
    },
    {
        name: "depot.name", type: "text", title: "یارد",
    },
    {
        name: "depot.store.warehouseId", title: "انبار",

        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"), hidden: true
    },
    {
        name: "depot.store.name", type: "text", title: "سوله‌/محوطه",
        hidden: true
    },
]
////////////////////////////////////////////////////////DATASOURCE//////////////////////////////////////////////////////
crTab.RestDataSources.RemittanceDetail = isc.MyRestDataSource.create({
    fetchDataURL: 'api/remittance-detail/spec-list',
    fields: crTab.Fields.RemittanceDetail()
});
////////////////////////////////////////////////////////GRIDS///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////DYNAMICFORMS////////////////////////////////////////////////////
////////////////////////////////////////////////////////COMPONENTS//////////////////////////////////////////////////////
////////////////////////////////////////////////////////WINDOWS/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////MainContractRefactor////////////////////////////////////////////
crTab.Layouts.Vlayouts.main = isc.VLayout.create({
    width: "100%",
    height: "100%",
    // membersMargin: 20,
    members: [
        isc.HLayout.create({
            width: "100%",
            height: 10,
            members:
                [
                    isc.ToolStrip.create({
                        width: "100%",
                        membersMargin: 5,
                        members:
                            [
                                isc.MenuButton.create({
                                    autoDraw: false,
                                    title: "<spring:message code='tozin.report.waste'/>",
                                    prompt: "<spring:message code='tozin.report.waste.byDate'/>",
                                    width: 250,
                                    menu: isc.Menu.create({
                                        width: 250,
                                        data: [
                                            {
                                                title: "<spring:message code='global.form.print.pdf'/>",
                                                icon: "icon/pdf.png",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Kharid_Zaieat/pdf" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.excel'/>",
                                                icon: "icon/excel.png",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Kharid_Zaieat/excel" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.html'/>",
                                                icon: "icon/html.jpg",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Kharid_Zaieat/html" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            }
                                        ]
                                    })
                                }),
                                isc.MenuButton.create({
                                    autoDraw: false,
                                    title: "<spring:message code='tozin.report.betweenComplexes'/>",
                                    prompt: "<spring:message code='tozin.report.betweenComplexes.date'/>",
                                    width: 125,
                                    menu: isc.Menu.create({
                                        width: 150,
                                        data: [
                                            {
                                                title: "<spring:message code='global.form.print.pdf'/>",
                                                icon: "icon/pdf.png",
                                                click: function () {
                                                    //   "<spring:url value="/warehouseStock/print/beyn_mojtama/pdf" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", ""));
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.excel'/>",
                                                icon: "icon/excel.png",
                                                click: function () {
                                                    //   "<spring:url value="/warehouseStock/print/beyn_mojtama/excel" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", ""));
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.html'/>",
                                                icon: "icon/html.jpg",
                                                click: function () {
                                                    // "<spring:url value="/warehouseStock/print/beyn_mojtama/html" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", ""));
                                                }
                                            }
                                        ]
                                    })
                                }),
                                isc.MenuButton.create({
                                    autoDraw: false,
                                    title: "<spring:message code='tozin.report.salesUpload'/>",
                                    prompt: "<spring:message code='tozin.report.salesUpload.byDate'/>",
                                    width: 200,
                                    menu: isc.Menu.create({
                                        width: 200,
                                        data: [
                                            {
                                                title: "<spring:message code='global.form.print.pdf'/>",
                                                icon: "icon/pdf.png",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Forosh_Bargiri/pdf" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.excel'/>",
                                                icon: "icon/excel.png",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Forosh_Bargiri/excel" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.html'/>",
                                                icon: "icon/html.jpg",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Forosh_Bargiri/html" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            }
                                        ]
                                    })
                                }),
                                isc.MenuButton.create({
                                    autoDraw: false,
                                    title: "<spring:message code='tozin.report.cons.buy'/>",
                                    prompt: "<spring:message code='tozin.report.cons.buy.byDate'/>",
                                    width: 200,
                                    menu: isc.Menu.create({
                                        width: 200,
                                        data: [
                                            {
                                                title: "<spring:message code='global.form.print.pdf'/>",
                                                icon: "icon/pdf.png",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Kharid_Konstantere/pdf" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.excel'/>",
                                                icon: "icon/excel.png",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Kharid_Konstantere/excel" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.html'/>",
                                                icon: "icon/html.jpg",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Kharid_Konstantere/html" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            }
                                        ]
                                    })
                                }),
                                isc.MenuButton.create({
                                    visibility: "hidden",
                                    autoDraw: false,
                                    title: "<spring:message code='tozin.report.cons.buy'/>",
                                    prompt: "<spring:message code='tozin.report.cons.buy.byDate'/>",
                                    width: 200,
                                    menu: isc.Menu.create({
                                        width: 200,
                                        data: [
                                            {
                                                title: "<spring:message code='global.form.print.pdf'/>",
                                                icon: "icon/pdf.png",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Kharid_Konstantere/pdf" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.excel'/>",
                                                icon: "icon/excel.png",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Kharid_Konstantere/excel" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            },
                                            {
                                                title: "<spring:message code='global.form.print.html'/>",
                                                icon: "icon/html.jpg",
                                                click: function () {
                                                    var toDay = DynamicForm_DailyReport_Tozin.getValue("toDay").replaceAll("/", "");
                                                    // "<spring:url value="/warehouseStock/print/Kharid_Konstantere/html" var="printUrl"/>"
                                                    window.open('${printUrl}' + '/' + toDay);
                                                }
                                            }
                                        ]
                                    })
                                }),
                                isc.DynamicForm.create({
                                    ID: "DynamicForm_DailyReport_Tozin",
                                    width: "200",
                                    wrapItemTitles: false,
                                    // height: "100%",
                                    action: "report/printDailyReportBandarAbbas",
                                    target: "_Blank",
                                    titleWidth: "200",
                                    numCols: 4,
                                    fields: [{
                                        name: "toDay",
                                        ID: "toDayDateTozin",
                                        title: "<spring:message code='dailyWarehouse.toDay'/>",
                                        type: 'text',
                                        align: "center",
                                        width: 150,
                                        colSpan: 1,
                                        titleColSpan: 1,
                                        icons: [{
                                            src: "pieces/pcal.png",
                                            click: function () {
                                                displayDatePicker('toDayDateTozin', this, 'ymd', '/');
                                            }
                                        }],
                                        defaultValue: new persianDate().subtract('d', 0).format('YYYY/MM/DD'),
                                    },]
                                }),
                            ]
                    })
                ]
        }),
        isc.VLayout.create({
            members: [
                crTab.Grids.RemittanceDetail = isc.ListGrid.create({
                    title: "موجودی انبار",
                    fields: crTab.Fields.RemittanceDetail(),
                    dataFetchMode: "basic",
                    showGroupSummary: true,
                    groupStartOpen: "none",
                    showGroupSummaryInHeader: true,
                    groupIndentSize: 50,
                    groupByField: ["inventory.materialItemId", "depot.store.warehouseId", "depot.store.name", "depot.name"],
                    // initialCriteria: ,
                    showFilterEditor: true,
                    filterOnKeypress: false,
                    useAdvancedCriteria: true,
                    filterLocalData: true,
                    dataSource: crTab.RestDataSources.RemittanceDetail,
                    autoFetchData: false,
                    showGroupTitleColumn: true,

                })
            ]
        }),
        isc.VLayout.create({
            height: "60%",
            members: [
                isc.Label.create({
                    contents: '<h2>گزارش ورودی خروجی </h2>',
                    align: "center",
                    height: "5%"
                }),
                isc.HLayout.create({
                    height: "10%",
                    members: [
                        crTab.DynamicForms.ChartDate = isc.DynamicForm.create(
                            {
                                numCols: 4,
                                fields: [
                                    {
                                        name: "fromDate",
                                        title: "<spring:message code='dailyWarehouse.fromDay'/>",
                                        defaultValue: crTab.Methods.getFirstDayOfSeason(),
                                        // editorExit:crTab.Methods.UpdateInputOutputCharts,
                                        keyPressFilter: "[0-9/]",
                                        icons: [{
                                            src: "pieces/pcal.png",
                                            click: function (form, item, icon) {
                                                // // console.log(form)
                                                displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                                            }
                                        }],
                                    },
                                    {
                                        name: "toDate",
                                        title: "<spring:message code='dailyWarehouse.toDay'/>",
                                        // editorExit:crTab.Methods.UpdateInputOutputCharts,
                                        keyPressFilter: "[0-9/]",
                                        icons: [{
                                            src: "pieces/pcal.png",
                                            click: function (form, item, icon) {
                                                // // console.log(form)
                                                displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                                            }
                                        }],
                                        defaultValue: new persianDate().subtract('d', 1).format('YYYY/MM/DD')
                                    },
                                ]
                            }
                        ),
                        isc.SpacerItem.create({height: 1}),
                        isc.ToolStripButtonRefresh.create({
                            title: " فیلتر",
                            click: crTab.Methods.UpdateInputOutputCharts
                        })
                    ]
                }),

                crTab.Layouts.Vlayouts.Chart = isc.VLayout.create()

            ]
        })
    ]
})
crTab.Methods.UpdateInputOutputCharts()
dbg(false, "crtab", crTab)
await fetch('remittance-detail/excel' +
    JSON.stringify({
        operator: "and", criteroa: [{fieldName: "inventory.materialItemId", operator: "equals", value: 3},
            {fieldName: "inventory.weight", operator: "greaterOrEqual", value: 1}]
    }),
    {
        Headers: SalesConfigs.httpHeaders,
        method: "POST", body: JSON.stringify({
            request:{
                header:['id'],
                doesNotNeedFetch:false
            }
        })
    })
//}
//)

