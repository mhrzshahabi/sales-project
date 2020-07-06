//<%@ page contentType="text/html;charset=UTF-8" %>
//  <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
// <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

const rdTab = {
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
                            result[key] = rdTab.Methods.concatObjectsByKey(isBoolOperatorAnd, first[key], second[key]);
                        else console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                    } else
                        result[key] = second[key];
                }

                return result;
            }, {});
        },
        FetchSpecListData: function (usePageStrategy, props, responseCallBack) {

            rdTab.method.jsonRPCManagerRequest(props, (response) => {

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

                rdTab.method.fetchSpecListData(usePageStrategy, currentProps, (response2) => {

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
            for (let grid in rdTab.Grids) {
                try {
                    let iscGrid = window[rdTab.Grids[grid].ID];
                    if (typeof (iscGrid) === "object") {
                        iscGrid.invalidateCache();
                        // iscGrid.deselectAllRecords();
                    }
                } catch (e) {
                    console.log(e);
                }

            }
            for (let form in rdTab.DynamicForms.Forms) {
                let f = window[rdTab.DynamicForms.Forms[form]["ID"]];

                try {
                    f.clearValues();
                } catch (e) {
                    console.log(e);
                }
            }
            for (let windows in rdTab.Layouts.Window) {
                let w = window[rdTab.Layouts.Window[windows]["ID"]];

                try {
                    w.hide();
                } catch (e) {
                    console.log(e);
                }
            }
        },
        Required: function () {
            return !rdTab.Vars.debug
        },
        CrudDynamicForm: function (props) {
            rdTab.Logs.add(['props:', props]);
            if (typeof (props) === "undefined") return;
            let url = rdTab.Vars.Url;
            let method = rdTab.Vars.Method;
            let httpHeaders = SalesConfigs.httpHeaders;
            let params = "";
            let data = "";
            let callBack = "";
            let defaultResponse = function (response) {
                rdTab.Logs.add(["return status:", response]);
                if (response.status === 400 || response.status == 500) {
                    response.text().then(error => {
                        rdTab.Logs.add(["fetch error:", error]);
                        MyRPCManager.handleError({httpResponseText: error});
                    });
                    return;
                }

                if (response.status === 200 || response.status === 201) response.text().then(resp => {
                    rdTab.Dialog.Success()
                });
                else {
                    response.text().then(error => {
                        rdTab.Logs.add(["fetch error:", error]);
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
            rdTab.Logs.add(['data to send rpc', data]);
            fetch(url, {
                method: method,
                headers: httpHeaders,

                body: data,
            }).then(response => {
                defaultResponse(response);
            }).finally(() => {
                rdTab.Logs.add(["fetch finally: ", rdTab.Vars.Method]);
                if (typeof (callBack) === "function") {
                    callBack()
                } else {
                }
                rdTab.Methods.RefreshAll();
            });
        },
        DynamicFormRefresh: (method = "POST", form) => {
            rdTab.Vars.Method = method;
            form = window[form.ID];
            form.clearValues();
        },
        NewForm: function (iscWindow, form) {
            const win = window[iscWindow.ID];
            rdTab.Methods.DynamicFormRefresh("POST", form);
            win.show();
        },
        Save: function (data, url, callBack) {
            rdTab.Methods.CrudDynamicForm({
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
                    rdTab.Vars.Method = "PUT";
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
                                // let urlD = rdTab.Vars.Url + "pattern/list";
                                // if (typeof (deleteUrl) === "string") urlD = deleteUrl;
                                rdTab.Methods.CrudDynamicForm({
                                    data: data,
                                    url: deleteUrl,
                                    method: "DELETE",
                                    params: params,
                                });
                            } else {

                            }

                            // rdTab.log.add(ids);

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
                                    rdTab.Methods.RefreshAll();
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
                        ID: rdTab.Vars.Prefix + "vـlayoutـmain",
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
                            ID: rdTab.Vars.Prefix + "toolـstripـmain",
                            width: "100%",
                            members:
                                [
                                    //    <sec:authorize access="hasAuthority('C_PARAMETERS')">
                                    isc.ToolStripButtonAdd.create({
                                        ...rdTab.Layouts.ToolStripButtons.new,
                                        ID: rdTab.Vars.Prefix + "toolـstripـbuttonـadd",
                                    }),
                                    //  </sec:authorize>
                                    //   <sec:authorize access="hasAuthority('U_PARAMETERS')">
                                    isc.ToolStripButtonEdit.create({
                                        ...rdTab.Layouts.ToolStripButtons.edit,
                                        ID: rdTab.Vars.Prefix + "toolـstripـbuttonـedit",
                                    }),

                                    ,
                                    //   </sec:authorize>
                                    //    <sec:authorize access="hasAuthority('D_PARAMETERS')">
                                    isc.ToolStripButtonRemove.create({
                                        ...rdTab.Layouts.ToolStripButtons.remove,
                                        ID: rdTab.Vars.Prefix + "tool_stripـbuttonـremove",
                                    }),
                                    //    </sec:authorize>
                                    isc.ToolStrip.create({
                                        width: "100%",
                                        align: "left",
                                        border: '0px',
                                        members: [
                                            isc.ToolStripButtonRefresh.create({
                                                ...rdTab.Layouts.ToolStripButtons.refresh,
                                                ID: rdTab.Vars.Prefix + "tool_strip_button_refresh",
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

            rdTab.log["errorResponse"] = response;
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
rdTab.Methods.RecordDoubleClick = function (url, items, recordString, viewer, record, recordNum, field, fieldNum, value, rawValue) {
    let form;
    const window1 = isc.Window.create({
        width: .2 * window.innerWidth,
        height: .2 * window.innerHeight,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        align: "center",
        autoDraw: false,
        canDragReposition: false,
        dismissOnEscape: true,

    });
    window1.setMembers(
        [isc.VLayout.create({
            members: [
                form = isc.DynamicForm.create({
                    items: items,
                }),
                rdTab.Methods.HlayoutSaveOrExit(function () {
                    const values = form.getValues();
                    rdTab.Methods.Save(values,
                        url,
                        () => {
                            rdTab.Grids.RemittanceDetailLG.obj.invalidateCache();
                            window1.close()
                        }
                    )
                }, window1)
            ]
        })]
    );
    if (recordString) {
        if (Object.keys(record).contains('remittanceDetails'))
            form.setValues(record['remittanceDetails'][0][recordString]);
        form.setValues(record[recordString]);
    } else form.setValues(record);
    window1.show();
}
rdTab.Methods.RecordDoubleClickRD = function () {
    rdTab.Methods.RecordDoubleClick("api/remittance-detail", rdTab.Fields.RemittanceDetailFields.map(t => {
        if (t.name !== 'id') t.hidden = false;
        return t;
    }), null, ...arguments)
}
////////////////////////////////////////////////////////FIELDS//////////////////////////////////////////////////////////
rdTab.Fields.RemittanceDetailFields = [
    {name: "id", hidden: true, type: "number"},
    {
        name: "remittanceId", hidden: true,
        optionDataSource: isc.MyRestDataSource.create({
            fetchDataURL: 'api/remittance/spec-list',
            fields: rdTab.Fields.Remittance
        }),
        pickListProperties: {
            fields: rdTab.Fields.Remittance
        },
        displayField: "code",
        valueField: "id",
    },
    {name: "depotId", hidden: true},
    {
        name: "unitId",
        valueMap: SalesBaseParameters.getSavedUnitParameter().getValueMap('id', 'nameFA'),
        type: "number",
        title: "واحد",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,


    },
    {
        name: "amount",
        title: "تعداد محصول",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,


    },
    {
        name: "weight",
        title: "وزن",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,


    },
    {
        name: "securityPolompNo",
        title: "پلمپ حراست",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,


    },
    {
        name: "railPolompNo",
        title: "پلمپ راه‌آهن",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,


    },
    {
        name: "description",
        title: "توضیحات",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,


    },
];
rdTab.Fields.RemittanceDetailFullFields = [
    // {
    //     name: "remittance.code", title: "شماره بیجک"
    //     , recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
    //         rdTab.Methods.RecordDoubleClick('api/remittance', rdTab.Fields.Remittance, "remittance",
    //             viewer, record, recordNum, field, fieldNum, value, rawValue)
    //     }
    // },
    ...rdTab.Fields.RemittanceDetailFields,
    // {
    //     name: "remittance.description",
    //     title: "توضیحات بیجک",
    //     recordDoubleClick() {
    //         rdTab.Methods.RecordDoubleClick("api/remittance", rdTab.Fields.Remittance, 'remittance', ...arguments)
    //     }
    //
    // },
    {
        name: "sourceTozin.tozinId",
        title: "توزین مبدا",
        recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
            rdTab.Methods.RecordDoubleClick('tozintable', rdTab.Fields.TozinTable, 'sourceTozin',
                viewer, record, recordNum, field, fieldNum, value, rawValue)
        },

    },
    {
        name: "destinationTozin.tozinId",
        title: "توزین مقصد",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,

    },
    {
        name: "inventory.label",
        title: "سریال محصول",
        recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
            rdTab.Methods.RecordDoubleClick('api/inventory', rdTab.Fields.Inventory, "inventory",
                viewer, record, recordNum, field, fieldNum, value, rawValue)
        }
    },
    {
        name: "inventory.materialItem.id",
        valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName"),
        type: "number",
        title: "محصول",
        recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
            rdTab.Methods.RecordDoubleClick('api/inventory', rdTab.Fields.Inventory, "inventory",
                viewer, record, recordNum, field, fieldNum, value, rawValue)
        }


    },
    {
        name: "destinationTozin.sourceId",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        title: "مبدا",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,


    },
    {
        name: "destinationTozin.date",
        title: "تاریخ توزین مقصد",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,


    },
    {
        name: "destinationTozin.targetId",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        title: "مقصد",
        recordDoubleClick: rdTab.Methods.RecordDoubleClickRD,


    },
];
rdTab.Fields.Remittance = [
    {
        name: 'code', title: "شماره بیجک",
        recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
            rdTab.Methods.RecordDoubleClick('api/remittance', rdTab.Fields.Remittance, false,
                viewer, record, recordNum, field, fieldNum, value, rawValue)
        }
    },
    {
        name: 'description', title: "شرح",
        recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
            rdTab.Methods.RecordDoubleClick('api/remittance', rdTab.Fields.Remittance, false,
                viewer, record, recordNum, field, fieldNum, value, rawValue)
        }
    },
    {name: 'id', title: "شناسه", hidden: true},


];
rdTab.Fields.RemittanceFull = [
    ...rdTab.Fields.Remittance,
    {
        name: "remittanceDetails.sourceTozin.tozinId",
        title: "توزین مبدا",
    },
    {
        name: "remittanceDetails.inventory.materialItem.id",
        valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName"),
        type: "number",
        title: "محصول",
    },
    {
        name: "remittanceDetails.destinationTozin.sourceId",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        title: "مبدا",
    },
    {
        name: "remittanceDetails.destinationTozin.date",
        title: "تاریخ توزین مقصد",
    },
    {
        name: "remittanceDetails.destinationTozin.targetId",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        title: "مقصد",
    },
];
rdTab.Fields.Inventory = [
    {
        name: 'materialItemId',
        valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName")
        , title: 'محصول'
    },
    {name: 'label', title: 'سریال محصول'},
    {name: 'id', title: 'شناسه', hidden: true,},
];
rdTab.Fields.TozinLite = [
    {
        name: "date",
        type: "text",
        filterEditorProperties: {
            // defaultValue: new persianDate().subtract('d', 14).format('YYYYMMDD'),
            keyPressFilter: "[0-9/]",
            parseEditorValue: function (value, record, form, item) {
                if (value === undefined || value == null || value === '') return value;
                return value.replace(/\//g, '').padEnd(8, "01");
            },
            icons: [{
                src: "pieces/pcal.png",
                click: function (form, item, icon) {
                    // console.log(form)
                    displayDatePicker(item['ID'], form.getItems()[0], 'ymd', '/');
                }
            }],
        },
        filterOperator: "greaterOrEqual",
        title: "<spring:message code='Tozin.date'/>",
        align: "center",
        formatCellValue(value, record, rowNum, colNum, grid) {
            try {
                return (value.substr(0, 4) + "/" + value.substr(4, 2) + "/" + value.substr(-2))
            } catch (e) {
                return value
            }
        }
    },
    {
        name: "tozinId",
        showHover: true,
        width: "10%",
        title: "<spring:message code='Tozin.tozinPlantId'/>"
    },
    {
        name: "driverName",
        showHover: true,
        width: "10%",
        title: "<spring:message code='Tozin.driver'/>"
    },
    {
        name: "codeKala",
        type: "number",
        // filterEditorProperties: {editorType: "comboBox"},
        valueMap: {11: 'كاتد صادراتي', 8: 'كنسانتره مس ', 97: 'اكسيد موليبدن'},
        title: "محصول",
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.save('on_way_product_defaultCodeKala', value)
            return value;
        },
        align: "center"
    },
    {
        name: "plak",
        title: "<spring:message code='Tozin.plak.container'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "containerNo1",
        title: "<spring:message code='Tozin.containerNo1'/>",
        align: "center"
    },
    {
        name: "containerNo3",
        title: "<spring:message code='Tozin.containerNo3'/> - نوع حمل",
        align: "center",
        formatCellValue(value, record, rowNum, colNum, grid) {
            return (value ? "ریلی  " + value : "جاده‌ای"
            )
        },
        validOperators: ["equals", "isNull", "notNull"],
        filterEditorProperties: {
            showPickerIcon: true,
            // showPickerIconOnFocus:true,
            picker: isc.FormLayout.create({
                visibility: "hidden",
                backgroundColor: "white",
                items: [{
                    showTitle: false, type: "radioGroup",
                    valueMap: {notNull: "ریلی", isNull: "جاده‌ای"},
                    change: function (f, i, value) {
                        const criteria = ListGrid_Tozin_IN_ONWAYPRODUCT.getFilterEditorCriteria();
                        criteria.criteria = criteria.criteria.filter(c => c.fieldName !== 'containerNo3');
                        criteria.criteria.add({
                            fieldName: "containerNo3",
                            operator: value
                        })
                        console.log(criteria)
                        ListGrid_Tozin_IN_ONWAYPRODUCT.setFilterEditorCriteria(criteria);
                        return this.Super("change", arguments)
                    },
                }]
            })
        }
        // alwaysShowOperatorIcon:true,
    },
    {
        name: "vazn",
        title: "<spring:message code='Tozin.vazn'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "sourceId",
        type: "number",
        // filterEditorProperties: {editorType: "comboBox"},
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.save('on_way_product_defaultSourceId', value)
            return value;
        },
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
        valueMap: {
            2421: 'ايستگاه قطار تبريز',
            1540: 'مجتمع مس شهربابك -ميدوك ',
            1541: 'مجتمع مس سونگون ',
            1000: 'مجتمع مس سرچشمه',
            1021: 'مجتمع مس شهربابك - خاتون آباد ',
            2509: 'شركت هاي خصوصي وتابع ',
            2555: 'اسكله شهيد رجائي ',
        },
        title: "<spring:message code='Tozin.sourceId'/>",
        align: "center"
    },
    {
        name: "targetId",
        type: "number",
        // filterEditorProperties: {
        //     editorType: "comboBox",
        //     type: "number",
        //     // defaultValue: StorageUtil.get('on_way_product_defaultTargetId')
        // },
        parseEditorValue: function (value, record, form, item) {
            StorageUtil.save('on_way_product_defaultTargetId', value)
            return value;
        },
        filterOperator: "equals",
        valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),

        valueMap: {
            2320: 'بندر شهيد رجايي، روبروي اسكله شانزده ،محوطه فلزات آلياژي شركت تايد واتر',
            1000: 'مجتمع مس سرچشمه',
            2340: 'بندر شهيد رجايي ، انبار كالا شماره 20',
            2555: 'اسكله شهيد رجائي ',
        },
        title: "<spring:message code='Tozin.targetId'/>",
        align: "center",
    },
    {
        name: "havalehCode",
        title: "<spring:message code='Tozin.haveCode'/>",
        align: "center"
    },
];
rdTab.Fields.TozinTable = [
    {
        name: 'isInView',
        valueMap: {true: "بله", false: "خیر"}
    },
    {name: 'date',},
    {name: 'tozinId',},
    {name: 'driverName',},
    {name: 'codeKala',},
    {name: 'plak',},
    {name: 'vazn',},
    {
        name: 'sourceId',
        valueMap: rdTab.Fields.TozinLite.find(a => a.name === "sourceId")['valueMap']
    },
    {
        name: 'targetId',
        valueMap: rdTab.Fields.TozinLite.find(a => a.name === "sourceId")['valueMap']
    },
    {name: 'haveCode',},
    {name: 'cardId',},
    {name: 'ctrlDescOut',},
    {name: 'version', hidden: true},
];
rdTab.Fields.TozinFull = [
    ...rdTab.Fields.TozinLite,
    {
        name: "source",
        title: "<spring:message code='Tozin.source'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "nameKala",
        title: "<spring:message code='Tozin.nameKala'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "target",
        title: "<spring:message code='Tozin.target'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "cardId",
        title: "<spring:message code='Tozin.cardId'/>",
        align: "center"
    },
    {
        name: "carName",
        title: "<spring:message code='Tozin.carName'/>",
        align: "center"
    },
    {
        name: "containerId",
        title: "<spring:message code='Tozin.containerId'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "containerName",
        title: "<spring:message code='Tozin.containerName'/>",
        align: "center"
    },
    {
        name: "vazn1",
        title: "<spring:message code='Tozin.vazn1'/>",
        align: "center"
    },
    {
        name: "vazn2",
        title: "<spring:message code='Tozin.vazn2'/>",
        align: "center"
    },
    {
        name: "condition",
        title: "<spring:message code='Tozin.condition'/>",
        align: "center"
    },
    {
        name: "tedad",
        title: "<spring:message code='Tozin.tedad'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "unitKala",
        title: "<spring:message code='Tozin.unitKala'/>",
        align: "center"
    },
    {
        name: "packName",
        title: "<spring:message code='Tozin.packName'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "haveCode",
        title: "<spring:message code='Tozin.haveCode'/>",
        align: "center",
        showHover: true,
        width: "10%"
    },
    {
        name: "tozinDate",
        showHover: true,
        width: "10%",
        title: "<spring:message code='Tozin.tozinDate'/>"
    },
    {
        name: "tozinTime",
        title: "<spring:message code='Tozin.tozinTime'/>",
        align: "center"
    },
    {
        name: "havalehName",
        title: "<spring:message code='Tozin.havalehName'/>",
        align: "center"
    },
    {
        name: "havalehFrom",
        title: "<spring:message code='Tozin.havalehFrom'/>",
        align: "center"
    },
    {
        name: "carNo1",
        title: "<spring:message code='Tozin.carNo1'/>",
        align: "center"
    },
    {
        name: "carNo3",
        title: "<spring:message code='Tozin.carNo3'/>",
        align: "center"
    },
    {
        name: "isFinal",
        title: "<spring:message code='Tozin.isFinal'/>",
        align: "center"
    },
    {
        name: "ctrlDescOut",
        title: "<spring:message code='Tozin.isFinal'/>",
        align: "center"
    },
    {
        name: "tznSharh2",
        title: "<spring:message code='Tozin.isFinal'/>",
        align: "center"
    }, {
        name: "strSharh2",
        title: "<spring:message code='Tozin.isFinal'/>",
        align: "center"
    }, {
        name: "tznSharh1",
        title: "<spring:message code='Tozin.isFinal'/>",
        align: "center"
    },

    {
        name: "havalehDate",
        title: "<spring:message code='Tozin.havalehDate'/>",
        align: "center"
    },


];
////////////////////////////////////////////////////////DS//////////////////////////////////////////////////////////////
rdTab.RestDataSources.RemittanceDetailDS = {
    fetchDataURL: "api/remittance-detail/spec-list",
    updateDataURL: "api/remittance-detail/update",
    fields: rdTab.Fields.RemittanceDetailFullFields
};
rdTab.RestDataSources.Remittance = {
    fetchDataURL: "api/remittance/spec-list",
    updateDataURL: "api/remittance/",
    fields: rdTab.Fields.RemittanceFull
};
////////////////////////////////////////////////////////DYNAMICFORMS////////////////////////////////////////////////////
rdTab.DynamicForms.Forms.Remittance = {
    ID: "remittanceDynamicForm" + rdTab.Vars.Prefix,
    items: rdTab.Fields.Remittance,
};
////////////////////////////////////////////////////////LISTGRIDS///////////////////////////////////////////////////////
rdTab.Grids.Remittance = {
    // ID: rdTab.Vars.Prefix + "remittance_detail_tab_list_grid",
    showFilterEditor: true,
    expansionFieldImageShowSelected: true,
    canExpandRecords: true,
    canExpandMultipleRecords: false,
    getExpansionComponent: function (record, rowNum, colNum) {
        return isc.VLayout.create({
            height: .3 * innerHeight,
            members: [
                isc.ToolStrip.create({
                    members: [isc.ToolStripButtonRemove.create({}),
                        isc.ToolStrip.create({
                            width: "100%",
                            align: "left",
                            border: '0px',
                            members: [
                                isc.ToolStripButtonRefresh.create({
                                    click() {
                                        rdTab.Grids.RemittanceDetailLG.obj.invalidateCache()
                                    }
                                })
                            ]
                        })
                    ]
                }),
                isc.ListGrid.create({
                    ...rdTab.Grids.RemittanceDetailLG,
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
    dataSource: rdTab.RestDataSources.Remittance,
    autoFetchData: true,

}
rdTab.Grids.RemittanceDetailLG = {
    fields: rdTab.Fields.RemittanceDetailFullFields,
    showFilterEditor: true,
    autoSaveEdits: false,
    allowAdvancedCriteria: true,
    // groupByField: "remittance.code",
    autoFetchData: false,
}
////////////////////////////////////////////////////////ToolStripButton/////////////////////////////////////////////////

////////////////////////////////////////////////////////COMPONENT HOLDERS///////////////////////////////////////////////
isc.VLayout.create({
    members: [
        isc.ToolStrip.create({
            members: [isc.ToolStripButtonRemove.create({}),
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        isc.ToolStripButtonRefresh.create({
                            click() {
                                rdTab.Grids.RemittanceDetailLG.obj.invalidateCache()
                            }
                        })
                    ]
                })
            ]
        }),
        rdTab.Grids.RemittanceDetailLG.obj = isc.ListGrid.create({
            ...rdTab.Grids.Remittance,
            dataSource: isc.MyRestDataSource.create(rdTab.Grids.Remittance.dataSource),
        })
    ]
})
console.debug("rdTab = ", rdTab);
