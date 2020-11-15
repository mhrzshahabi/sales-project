//<%@ page contentType="text/html;charset=UTF-8" %>
//  <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
// <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
const remittanceTab = {
    Logs: [],
    Vars: {
        Debug: false,
        Prefix: "remittance_detail_tab" + Math.random().toString().substr(-6),
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
        defaultWindowConfig: {
            width: .8 * window.innerWidth,
            height: .8 * window.innerHeight,
            autoSize: true,
            autoCenter: true,
            showMinimizeButton: false,
            isModal: true,
            showModalMask: true,
            align: "center",
            autoDraw: true,
            showTitle: false,
            dismissOnEscape: true,
            closeClick: function () {
                this.Super("closeClick", arguments)
            },
        },
        Authorities: {},
    },
    Methods: {
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
                            result[key] = remittanceTab.Methods.concatObjectsByKey(isBoolOperatorAnd, first[key], second[key]);
                        else console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                    } else
                        result[key] = second[key];
                }

                return result;
            }, {});
        },
        FetchSpecListData: function (usePageStrategy, props, responseCallBack) {

            remittanceTab.method.jsonRPCManagerRequest(props, (response) => {

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

                remittanceTab.method.fetchSpecListData(usePageStrategy, currentProps, (response2) => {

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
            for (let grid in remittanceTab.Grids) {
                try {
                    let iscGrid = window[remittanceTab.Grids[grid].ID];
                    if (typeof (iscGrid) === "object") {
                        iscGrid.invalidateCache();
                        // iscGrid.deselectAllRecords();
                    }
                } catch (e) {
                    console.log(e);
                }

            }
            for (let form in remittanceTab.DynamicForms.Forms) {
                let f = window[remittanceTab.DynamicForms.Forms[form]["ID"]];

                try {
                    f.clearValues();
                } catch (e) {
                    console.log(e);
                }
            }
            for (let windows in remittanceTab.Layouts.Window) {
                let w = window[remittanceTab.Layouts.Window[windows]["ID"]];

                try {
                    w.hide();
                } catch (e) {
                    // console.log(e);
                }
            }
        },
        Required: function () {
            return !remittanceTab.Vars.debug
        },
        CrudDynamicForm: function (props) {
            remittanceTab.Logs.add(['props:', props]);
            if (typeof (props) === "undefined") return;
            let url = remittanceTab.Vars.Url;
            let method = remittanceTab.Vars.Method;
            let httpHeaders = SalesConfigs.httpHeaders;
            let params = "";
            let data = "";
            let callBack = "";
            let defaultResponse = function (response) {
                remittanceTab.Logs.add(["return status:", response]);
                if (response.status === 400 || response.status == 500) {
                    response.json().then(error=>{
                        if (error.error ) {
                            const er = error.error;
                            if (er && er.toString().toLowerCase().includes("Unique".toLowerCase())) {
                                return isc.warn("<spring:message code='exception.unique' />:\n" + JSON.stringify(error));
                            }
                            if (er && er.toString().toLowerCase().includes("_FK".toLowerCase())) {
                                return isc.warn("<spring:message code='exception.DataIntegrityViolation_FK' />:\n" + JSON.stringify(error));
                            }
                        }
                        return isc.warn("مشکلی پیش آمد. مشکل جهت گزارش:\n" + JSON.stringify(error));
                    })

                    // response.text().then(error => {
                    //     remittanceTab.Logs.add(["fetch error:", error]);
                    //     // MyRPCManager.handleError({httpResponseText: error});
                    //     isc.warn("<spring:message code='Tozin.error.message '/>:\n" + JSON.stringify(error));
                    // });
                    return;
                }

                if (response.status === 200 || response.status === 201) response.text().then(resp => {
                    remittanceTab.Dialog.Success();
                    remittanceTab.Grids.Remittance.obj.invalidateCache();
                });
                else {
                    response.text().then(error => {
                        remittanceTab.Logs.add(["fetch error:", error]);
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
            remittanceTab.Logs.add(['data to send rpc', data]);
            fetch(url, {
                method: method,
                headers: httpHeaders,

                body: data,
            }).then(response => {
                defaultResponse(response);
                if (typeof (callBack) === "function") {
                    callBack()
                } else {
                }
            }).finally(() => {
                remittanceTab.Logs.add(["fetch finally: ", remittanceTab.Vars.Method]);

                remittanceTab.Methods.RefreshAll();
            });
        },
        DynamicFormRefresh: (method = "POST", form) => {
            remittanceTab.Vars.Method = method;
            form = window[form.ID];
            form.clearValues();
        },
        NewForm: function (iscWindow, form) {
            const win = window[iscWindow.ID];
            remittanceTab.Methods.DynamicFormRefresh("POST", form);
            win.show();
        },
        Save: function (data, url, callBack) {
            remittanceTab.Methods.CrudDynamicForm({
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
                        buttons: [isc.IButtonSave.create({title: "<spring:message code='global.ok'/>"})],
                        buttonClick: function (button, post) {
                            this.close();
                        }
                    });
                } else {
                    remittanceTab.Vars.Method = "PUT";
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
                        message: '<spring:message code="global.delete.ask"  />' + "<br>" + params.ids.length + " " + '<spring:message code="global.mored"/>',
                        icon: "[SKIN]ask.png",
                        title: '<spring:message code="global.form.remove"/> ' + " " + params.ids.length + " " + '<spring:message code="global.mored"/>',
                        buttons: [
                            isc.Button.create({title: '<spring:message code="global.yes"/>'}),
                            isc.Button.create({title: '<spring:message code="global.no"/>'})
                        ],
                        buttonClick: function (button, index) {
                            if (index === 0) {
                                // let urlD = remittanceTab.Vars.Url + "pattern/list";
                                // if (typeof (deleteUrl) === "string") urlD = deleteUrl;
                                remittanceTab.Methods.CrudDynamicForm({
                                    data: data,
                                    url: deleteUrl,
                                    method: "DELETE",
                                    params: params,
                                });
                            } else {

                            }

                            // remittanceTab.log.add(ids);

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
                    height: "5%",
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
                                    remittanceTab.Methods.RefreshAll();
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
            createMainVlayOut(members) {
                return isc.VLayout.create(
                    {
                        ID: remittanceTab.Vars.Prefix + "vـlayoutـmain",
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
            createMainToolStrip: function () {
                return isc.HLayout.create({
                    width: "100%",
                    members:
                        [isc.ToolStrip.create({
                            ID: remittanceTab.Vars.Prefix + "toolـstripـmain",
                            width: "100%",
                            members:
                                [
                                    //    <sec:authorize access="hasAuthority('C_REMITTANCE_DETAIL')">
                                    isc.ToolStripButtonAdd.create({
                                        ...remittanceTab.Layouts.ToolStripButtons.new,
                                        ID: remittanceTab.Vars.Prefix + "toolـstripـbuttonـadd",
                                    }),
                                    //  </sec:authorize>
                                    //   <sec:authorize access="hasAuthority('U_REMITTANCE_DETAIL')">
                                    isc.ToolStripButtonEdit.create({
                                        ...remittanceTab.Layouts.ToolStripButtons.edit,
                                        ID: remittanceTab.Vars.Prefix + "toolـstripـbuttonـedit",
                                    }),

                                    ,
                                    //   </sec:authorize>
                                    //    <sec:authorize access="hasAuthority('D_REMITTANCE_DETAIL')">
                                    isc.ToolStripButtonRemove.create({
                                        ...remittanceTab.Layouts.ToolStripButtons.remove,
                                        ID: remittanceTab.Vars.Prefix + "tool_stripـbuttonـremove",
                                    }),
                                    //    </sec:authorize>
                                    isc.ToolStrip.create({
                                        width: "100%",
                                        align: "left",
                                        border: '0px',
                                        members: [
                                            isc.ToolStripButtonRefresh.create({
                                                ...remittanceTab.Layouts.ToolStripButtons.refresh,
                                                ID: remittanceTab.Vars.Prefix + "tool_strip_button_refresh",
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

            remittanceTab.log["errorResponse"] = response;
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
////////////////////////////////////////////////////////METHODS/////////////////////////////////////////////////////////
remittanceTab.Methods.RecordDoubleClick = function (url, items, recordString, viewer, record, recordNum, field, fieldNum, value, rawValue) {
    if (!hasPermission(url)) return;
    let form;
    let vLayout;
    const window1 = isc.Window.create({
        width: .2 * window.innerWidth,
        // height: .2 * window.innerHeight,
        // width: "100%",
        autoSize: true,
        autoCenter: true,
        isModal: true,
        align: "center",
        autoDraw: false,
        showTitle: false,
        canDragReposition: false,
        dismissOnEscape: true,

    });
    window1.setMembers(
        [vLayout = isc.VLayout.create({
            height: "100%",
            members: [
                form = isc.DynamicForm.create({
                    height: "100%",
                    items: items,
                }),
                remittanceTab.Methods.HlayoutSaveOrExit(function () {
                    const values = form.getValues();
                    remittanceTab.Methods.Save(values,
                        url,
                        () => {
                            remittanceTab.Grids.Remittance.obj.invalidateCache();
                            window1.close()
                        }
                    )
                }, window1)
            ]
        })]
    );
    if (recordString) {
        if (Object.keys(record).contains('remittanceDetails')) {
            form.setValues(record['remittanceDetails'][0][recordString]);
        }
        form.setValues(record[recordString]);
    } else form.setValues(record);
    window1.show();
    window[window1.getID() + "_body"].setHeight(0);

}
remittanceTab.Methods.RecordDoubleClickRD = function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
    const fields = remittanceTab.Fields.RemittanceDetail().map(t => {
        t.showIf = () => t.name !== 'id' && t.name !== 'remittanceId';

        if (t.name === "destinationTozin.tozinId" || t.name === "sourceTozin.tozinId") {
            const minDate = remittanceTab.Grids.Remittance.obj.getSelectedRecord().remittanceDetails
                .map(
                    function (rd) {
                        // console.log("remittanceTab.Grids.Remittance.obj.getSelectedRecord().remittanceDetails.map", arguments)
                        return rd.sourceTozin.date
                    }
                )
                .reduce(
                    function (i, j) {
                        // console.log("remittanceTab.Grids.Remittance.obj.getSelectedRecord().remittanceDetails.reduce", arguments)
                        return Number(i) < Number(j) ? i : j;
                    }
                );
            t = {
                ...t,
                click() {
                },
                displayField: "tozinId",
                valueField: "tozinId",
                autoFetchData: false,
                pickListWidth: .9 * innerWidth,
                changed(form, item, value) {
                    const field = item.name.split('.').reverse().pop();
                    // console.log(field);
                    form.setValue(field, item.getSelectedRecord());
                },
                disabled: true,
                /*
                pickListProperties: {
                    showFilterEditor: true,
                    allowAdvancedCriteria: true,
                    autoFetchData: false,
                    // autoFitFieldWidths: true,
                },
                optionCriteria: {
                    criteria: [
                        {fieldName: "date", operator: "greaterOrEqual", value: minDate},
                        {
                            fieldName: "codeKala", operator: "equals",
                            value: remittanceTab.Grids.Remittance.obj.getSelectedRecord().remittanceDetails[0].sourceTozin.codeKala
                        },
                    ],
                    operator: "and"
                },
                optionDataSource: isc.MyRestDataSource.create(remittanceTab.RestDataSources.TozinLite),
                 icons: [{
                     showIf: function (_form, _item) {
                         return true;
                     },
                     src: "pieces/16/icon_add.png",
                     click() {


                         console.log("recordDoubleClickRDAmindate", minDate)
                         console.log("recordDoubleClickRDArguments", record)
                     }
                 }]
                 */
            }
        }
        if (t.name === "depot.id") {
            t = {
                ...t,
                click() {
                },
                displayField: "name",
                valueField: "id",
                autoFetchData: false,
                pickListWidth: .3 * innerWidth,
                changed(form, item, value) {
                    const field = item.name.split('.').reverse().pop();
                    // console.log(field);
                    form.setValue(field + "Id", value);
                },
                // pickListProperties: {
                //     showFilterEditor: true,
                //     allowAdvancedCriteria: true,
                //     autoFetchData: false,
                //     // autoFitFieldWidths: true,
                // },
                pickListFields: remittanceTab.Fields.Depot(),
                //   <sec:authorize access="hasAuthority('R_DEPOT')">
                optionDataSource: isc.MyRestDataSource.create(remittanceTab.RestDataSources.Depot),
                //   </sec:authorize>
            }
        }
        return t;
    });
    remittanceTab.Methods.RecordDoubleClick("api/remittance-detail", fields, null, ...arguments)
}
remittanceTab.Methods.FetchAlreadyInsertedTozinList = async function (criteria) {
    const response = await fetch('api/tozin-table/spec-list?operator=and&criteria=' +
        criteria.criteria
            .map(a => {
                return JSON.stringify({
                    fieldName: a.fieldName,
                    operator: a.operator,
                    value: a.value
                })
            }).join('&criteria='),
        {headers: SalesConfigs.httpHeaders});
    if (response.status !== 200 && response.status !== 201) {
        isc.say('"<spring:message code="global.connection.error"/>"');
        throw "<spring:message code='global.connection.error'/> getAlreadyInsertedTozinList"
    }
    const responseJson = await response.json();
    return responseJson.response.data.map(t => t.tozinId);
}
remittanceTab.Methods.setShipmentCriteria = async function () {
    const value = remittanceTab.DynamicForms.Forms.OutRemittance.getField('materialItemId').getValue();
    const response = await fetch('api/materialItem/' + value, {headers: SalesConfigs.httpHeaders});
    //.then(
    if (response.ok) {
        let j = await response.json();//.then(

        remittanceTab.DynamicForms.Forms.OutRemittance.getField('shipmentId')
            .setOptionCriteria({
                    operator: "and",
                    criteria: [{
                        fieldName: "materialId",
                        operator: "equals",
                        value: j.materialId
                    }],
                }
            )
        remittanceTab.DynamicForms.Forms.OutRemittance.getField('shipmentId').enable();
    }
}
remittanceTab.Methods.setRemittanceCode =  function () {
    if(remittanceTab.DynamicForms.Forms.OutRemittance.getValue('code')
        && remittanceTab.DynamicForms.Forms.OutRemittance.getValue('code').length>5)return;
    let code = 'o-'
    code+=remittanceTab.DynamicForms.Forms.OutRemittance.getValue('materialItemId');
    code+='-';
    code+=remittanceTab.DynamicForms.Forms.TozinTable.getValue('tozinId')
    code+='-';
    code+=remittanceTab.DynamicForms.Forms.TozinTable.getValue('date')
    remittanceTab.DynamicForms.Forms.OutRemittance.setValue('code',code.replaceAll("/",""))

}
////////////////////////////////////////////////////////FIELDS//////////////////////////////////////////////////////////
getRemittanceFields(remittanceTab)
////////////////////////////////////////////////////////DS//////////////////////////////////////////////////////////////
remittanceTab.RestDataSources.RemittanceDetail = _=>{return {
    fetchDataURL: "api/remittance-detail/spec-list",
    updateDataURL: "api/remittance-detail/update",
    fields: remittanceTab.Fields.RemittanceDetailFullFields()
}};
remittanceTab.RestDataSources.Remittance = {
    fetchDataURL: "api/remittance/spec-list?distinct=true&",
    fetchDataURL: "api/remittance/spec-list",
    updateDataURL: "api/remittance/",
    fields: remittanceTab.Fields.RemittanceFull()
};
remittanceTab.RestDataSources.TozinLite = {
    fetchDataURL: "api/tozin/lite/spec-list",
    // updateDataURL: "api/remittance/",
    fields: remittanceTab.Fields.TozinFull().map(_ => {
        if (_.defaultValue) delete _.defaultValue;
        return _;
    })
};
remittanceTab.RestDataSources.Depot = {
    fetchDataURL: "api/depot/spec-list",
    fields: remittanceTab.Fields.Depot()
};
////////////////////////////////////////////////////////LISTGRIDS///////////////////////////////////////////////////////
remittanceTab.Grids.Remittance = {
    // ID: remittanceTab.Vars.Prefix + "remittance_detail_tab_list_grid",
    showFilterEditor: true,
    canSort: true,
    expansionFieldImageShowSelected: true,
    canExpandRecords: true,
    canExpandMultipleRecords: false,
    getExpansionComponent: function (record, rowNum, colNum) {
        return isc.VLayout.create({
            height: .3 * innerHeight,
            members: [
                // isc.ToolStrip.create({
                //     members: [isc.ToolStripButtonRemove.create({}),
                //         isc.ToolStrip.create({
                //             width: "100%",
                //             align: "left",
                //             border: '0px',
                //             members: [
                //                 isc.ToolStripButtonRefresh.create({
                //                     click() {
                //                         remittanceTab.Grids.RemittanceDetail.obj.invalidateCache()
                //                     }
                //                 })
                //             ]
                //         })
                //     ]
                // }),
                isc.ListGrid.create({
                    ...remittanceTab.Grids.RemittanceDetail(),
                    data: record['remittanceDetails']
                })
            ]
        })
    },
    // canEdit: true,
    // editEvent: "doubleClick",
    autoSaveEdits: false,
    allowAdvancedCriteria: true,
    // groupByField: "remittance.code",
    dataSource: remittanceTab.RestDataSources.Remittance,
    autoFetchData: true,
    sortField: "id",
    sortDirection: "descending",
    fields: remittanceTab.Fields.RemittanceFull(),
    getCellCSSText(record, rowNum, colNum) {
        if (!record.remittanceDetails || !record.remittanceDetails[0]) {
            return "font-weight:bold; color:red;";
        } else if (!record.remittanceDetails[0].destinationTozin) {
            return "font-weight:bold; color:#287fd6;";
        }

        return this.Super('getCellCSSText', arguments)
    }

}
remittanceTab.Grids.RemittanceDetail = _=>{return{
    fields: remittanceTab.Fields.RemittanceDetailFullFields(),
    showHoverComponents: true,
    getCellHoverComponent: function (record, rowNum, colNum) {
        // console.log('getCellHoverComponent', this, arguments)
        const field = this.getField(colNum);
        if(!field.name.toString().startsWith("sourceTozin.vazn")&&!field.name.toString().startsWith("destinationTozin.vazn")) return;
        this.rowHoverComponent = isc.DetailViewer.create({
            //   <sec:authorize access="hasAuthority('U_REMITTANCE') and hasAuthority('U_REMITTANCE_DETAIL') and hasAuthority('U_INVENTORY') and hasAuthority('R_TOZIN')">
            dataSource: isc.MyRestDataSource.create({
                fields: remittanceTab.Fields.TozinFull(),
                fetchDataURL: 'api/tozin/spec-list'
            }),
            width: 250
            //   </sec:authorize>
        });

        this.rowHoverComponent.fetchData({
            criteria: {
                fieldName: "tozinId",
                operator: "equals",
                value: eval('record.' + field.name.split(".").reverse().pop()+'.tozinId')
            }
        }, null, {showPrompt: false});

        return this.rowHoverComponent;
    },
    showFilterEditor: true,
    autoSaveEdits: false,
    sortField:'id',
    sortDirection: "descending",
    allowAdvancedCriteria: true,
    // groupByField: "remittance.code",
    autoFetchData: false,
}}
////////////////////////////////////////////////////////COMPONENT HOLDERS///////////////////////////////////////////////
remittanceTab.DynamicForms.Forms.PDF = isc.DynamicForm.create({
    method: "POST",
    action: "remittance-detail/report",
    autoDraw: true,
    visibility: "hidden",
    target: "_Blank",
    fields:
        [
            {name: "type", defaultValue: "pdf"},
            {name: "criteria"},
        ]
});
remittanceTab.Layouts.ToolStripButtons.PDF = {
    icon: "[SKIN]/actions/pdf.png",
    title: "<spring:message code='global.form.export.pdf'/>",
    click: function () {
        const criteria = JSON.stringify(remittanceTab.Grids.Remittance.obj.getCriteria());
        remittanceTab.DynamicForms.Forms.PDF.setValue("criteria", criteria);
        remittanceTab.DynamicForms.Forms.PDF.submitForm();
    }
};
remittanceTab.Layouts.ToolStripButtons.Delete = isc.ToolStripButtonRemove.create({
    title: "<spring:message code='remittance.del.all'/> <spring:message code='bijack'/>",
    click() {
        isc.Dialog.create({
            title: "<spring:message code='global.warning'/>",
            message: "<spring:message code='remittance.del.sure'/>",
            buttons: [isc.Dialog.OK, isc.Dialog.CANCEL],
            okClick() {
                remittanceTab.Methods.Delete(remittanceTab.Grids.Remittance.obj,
                    SalesConfigs.Urls.completeUrl + '/api/remittance/prune')
                this.close();
            }
        })

    },
});
remittanceTab.Layouts.ToolStripButtons.New = isc.ToolStripButtonAdd.create({
    // visibility: "hidden",
    ID: "new_bijak" + Math.random().toString().substr(3, 5),
    title: '<spring:message code="global.form.new"/> <spring:message code="bijack"/> <spring:message code="dailyReport.output"/>',
    click() {
        const selectedData = [];
        let materialItemId = remittanceTab.Grids.Remittance.obj
            .getSelectedRecord() ? remittanceTab.Grids.Remittance.obj
            .getSelectedRecord().remittanceDetails[0].inventory.materialItemId : null
        let multipleMaterialItem = false;
        let hasOutRemittance = false;
        remittanceTab.Grids.Remittance.obj
            .getSelectedRecords()
            .forEach(r => {
                if (r.remittanceDetails[0].inventory.materialItemId !== materialItemId) {
                    isc.warn('<spring:message code="remittance.selected.records.diff.product"/>');
                    multipleMaterialItem = true;
                }
                const r_tmp = {...r};
                const rd = [...r_tmp.remittanceDetails.filter(_ => _.inventory.weight > 0)];
                delete r_tmp.remittanceDetails;
                rd.forEach(_ => {
                    if (!_['destinationTozin']) hasOutRemittance = true
                    _['weight'] = _['inventory']['weight']
                    _['amount'] = _['inventory']['amount']
                    _['remittance'] = r_tmp;

                })
                selectedData.addList(rd)
            });
        if (multipleMaterialItem) return;
        if (hasOutRemittance) return isc.warn("<spring:message code='remittance.out.selected'/>")
        // console.log('selectedData', selectedData)
        //  let grid;
        //  let _form;
        //let _addBtn;
        newOutRemittance(remittanceTab,selectedData,materialItemId)
    }
});
isc.VLayout.create({
    members: [
        isc.ToolStrip.create({
            members: [
                remittanceTab.Layouts.ToolStripButtons.Delete,
                remittanceTab.Layouts.ToolStripButtons.New,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        isc.ToolStripButtonRefresh.create({
                            title:"<spring:message code='global.form.refresh'/>",
                            click() {
                                remittanceTab.Grids.Remittance.obj.invalidateCache()
                            }
                        }),
                        isc.ToolStripButtonRefresh.create(remittanceTab.Layouts.ToolStripButtons.PDF)
                    ]
                })
            ]
        }),
        remittanceTab.Grids.Remittance.obj = isc.ListGrid.create({
            ...remittanceTab.Grids.Remittance,
            dataSource: isc.MyRestDataSource.create(remittanceTab.Grids.Remittance.dataSource),
        })
    ]
})
console.debug("remittanceTab = ", remittanceTab);
// <sec:authorize access="!hasAuthority('D_REMITTANCE')">
remittanceTab.Layouts.ToolStripButtons.Delete.hide();
// </sec:authorize>
// <sec:authorize access="!hasAuthority('C_REMITTANCE')">
remittanceTab.Layouts.ToolStripButtons.New.hide();
// </sec:authorize>

function hasPermission(url) {
    switch (url) {
        case "api/remittance":
            if ("${SecurityUtil.hasAuthority('U_REMITTANCE')}".toString() != "true") return false;
            break;
        case "api/remittance-detail":
            if ("${SecurityUtil.hasAuthority('U_REMITTANCE_DETAIL')}".toString() != "true") return false;
            break;
        case "api/inventory":
            if ("${SecurityUtil.hasAuthority('U_INVENTORY')}".toString() != "true") return false;
            break;
    }
    return true;
}