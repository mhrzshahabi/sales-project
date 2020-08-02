//<%@ page contentType="text/html;charset=UTF-8" %>
//<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
//<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

const BlTab = {
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
                BlTab.Methods.Save(form.getValues(), url)
            }

            const id = BlTab.Vars.Prefix + "window_BL" + Math.random().toString().substr(2, 6)
            const win = isc.Window.create({
                ID: id,
                ...BlTab.Vars.DefaultWindowConfig,
                visibility: "hidden",
                members: [
                    isc.VLayout.create({
                        members: [
                            isc.HLayout.create({members: [form], height: "100%"}),
                            BlTab.Methods.HlayoutSaveOrExit(saveMethod, id,)
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
                            result[key] = BlTab.Methods.concatObjectsByKey(isBoolOperatorAnd, first[key], second[key]);
                        else console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                    } else
                        result[key] = second[key];
                }

                return result;
            }, {});
        },
        FetchSpecListData: function (usePageStrategy, props, responseCallBack) {

            BlTab.method.jsonRPCManagerRequest(props, (response) => {

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

                BlTab.method.fetchSpecListData(usePageStrategy, currentProps, (response2) => {

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
            for (let grid in BlTab.Grids) {
                try {
                    let iscGrid = window[BlTab.Grids[grid].ID];
                    if (typeof (iscGrid) === "object") {
                        iscGrid.invalidateCache();
                        // iscGrid.deselectAllRecords();
                    }
                } catch (e) {
                    console.log(e);
                }

            }
            for (let form in BlTab.DynamicForms.Forms) {
                let f = window[BlTab.DynamicForms.Forms[form]["ID"]];

                try {
                    f.clearValues();
                } catch (e) {
                    console.log(e);
                }
            }
            for (let windows in BlTab.Layouts.Window) {
                let w = window[BlTab.Layouts.Window[windows]["ID"]];

                try {
                    w.hide();
                } catch (e) {
                    console.log(e);
                }
            }
        },
        Required: function () {
            return !BlTab.Vars.debug
        },
        CrudDynamicForm: async function (props) {
            BlTab.Logs.add(['props:', props]);
            if (typeof (props) === "undefined") return;
            let url = BlTab.Vars.Url;
            let method = BlTab.Vars.Method;
            let httpHeaders = SalesConfigs.httpHeaders;
            let params = "";
            let data = "";
            let callBack = "";
            let defaultResponse = async function (response) {
                BlTab.Logs.add(["return status:", response]);
                if (response.status === 400 || response.status == 500) {
                    response.text().then(error => {
                        BlTab.Logs.add(["fetch error:", error]);
                        // MyRPCManager.handleError({httpResponseText: error});
                        isc.warn("مشکلی پیش آمد. مشکل جهت گزارش:\n" + JSON.stringify(error));
                    });
                    return;
                }

                if (response.status === 200 || response.status === 201) {
                    // await response.text()
                    BlTab.Dialog.Success();
                    BlTab.Grids.BillOfLanding.obj.invalidateCache();
                } else {
                    const error = await response.text();
                    BlTab.Logs.add(["fetch error:", error]);
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
            BlTab.Logs.add(['data to send rpc', data]);
            const response = await fetch(url, {
                method: method,
                headers: httpHeaders,

                body: data,
            })
            defaultResponse(response);
        },
        DynamicFormRefresh: (method = "POST", form) => {
            BlTab.Vars.Method = method;
            form = window[form.ID];
            form.clearValues();
        },
        NewForm: function (iscWindow, form) {
            const win = window[iscWindow.ID];
            BlTab.Methods.DynamicFormRefresh("POST", form);
            win.show();
        },
        Save: async function (data, url, callBack) {
            await BlTab.Methods.CrudDynamicForm({
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
                    BlTab.Vars.Method = "PUT";
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
                                // let urlD = BlTab.Vars.Url + "pattern/list";
                                // if (typeof (deleteUrl) === "string") urlD = deleteUrl;
                                BlTab.Methods.CrudDynamicForm({
                                    data: data,
                                    url: deleteUrl,
                                    method: "DELETE",
                                    params: params,
                                });
                            } else {

                            }

                            // BlTab.log.add(ids);

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
                                    BlTab.Methods.RefreshAll();
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
                        ID: BlTab.Vars.Prefix + "vـlayoutـmain",
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
                            ID: BlTab.Vars.Prefix + "toolـstripـmain",
                            width: "100%",
                            members:
                                [
                                    //    <sec:authorize access="hasAuthority('C_PARAMETERS')">
                                    isc.ToolStripButtonAdd.create({
                                        // ID: BlTab.Vars.Prefix + "toolـstripـbuttonـadd",
                                        ...BlTab.Layouts.ToolStripButtons.new,
                                    }),
                                    //  </sec:authorize>
                                    //   <sec:authorize access="hasAuthority('U_PARAMETERS')">
                                    isc.ToolStripButtonEdit.create({
                                        // ID: BlTab.Vars.Prefix + "toolـstripـbuttonـadd",
                                        ...BlTab.Layouts.ToolStripButtons.edit,
                                    }),

                                    ,
                                    //   </sec:authorize>
                                    //    <sec:authorize access="hasAuthority('D_PARAMETERS')">
                                    isc.ToolStripButtonRemove.create({
                                        ...BlTab.Layouts.ToolStripButtons.remove,
                                        // ID: BlTab.Vars.Prefix + "tool_stripـbuttonـremove",
                                    }),
                                    //    </sec:authorize>
                                    isc.ToolStrip.create({
                                        width: "100%",
                                        align: "left",
                                        border: '0px',
                                        members: [
                                            isc.ToolStripButtonRefresh.create({
                                                ...BlTab.Layouts.ToolStripButtons.refresh,
                                                // ID: BlTab.Vars.Prefix + "tool_strip_button_refresh",
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

            BlTab.log["errorResponse"] = response;
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
////////////////////////////////////////////////////////FIELDS//////////////////////////////////////////////////////////
BlTab.Fields.Vessel = _ => [
    {name: 'id',},
    {name: 'name',},
    {name: 'type',},
    {name: 'imo',},
    {name: 'yearOfBuild',},
    {name: 'length',},
    {name: 'beam',},
]
BlTab.Fields.Port = _ => [
    {name: 'id',},
    {name: 'country.nameEn',},
    {name: 'country.nameFa',},
    {name: 'countryId',},
    {name: 'port', width: "15%"},
    {name: 'loa',},
    {name: 'beam',},
    {name: 'arrival',},
]
BlTab.Fields.Contact = _ => [
    {name: 'id',},
    {name: 'nameFA',},
    {name: 'nameEN',},
    {name: 'phone',},
    {name: 'mobile',},
    {name: 'fax',},
    {name: 'address',},
    {name: 'webSite',},
    {name: 'email',},
    {name: 'type',},
    {name: 'nationalCode',},
    {name: 'economicalCode',},
    {name: 'bankAccount',},
    {name: 'bankShaba',},
    {name: 'bankSwift',},
    {name: 'bank',},
    {name: 'bankId',},
    {name: 'status',},
    {name: 'tradeMark',},
    {name: 'commercialRegistration',},
    {name: 'branchName',},
    {name: 'commercialRole',},
    {name: 'seller',},
    {name: 'buyer',},
    {name: 'transporter',},
    {name: 'shipper',},
    {name: 'inspector',},
    {name: 'insurancer',},
    {name: 'agentBuyer',},
    {name: 'agentSeller',},
    {name: 'ceo',},
    {name: 'ceoPassportNo',},
    {name: 'country',},
    {name: 'countryId',},
]
BlTab.Fields.TozinBase = function () {
    return [
        {
            name: "date",
            required: true,
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
            required: true,
            showHover: true,
            width: "10%",
            title: "<spring:message code='Tozin.tozinPlantId'/>"
        },
        {
            name: "driverName",
            required: true,

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
            required: true,

            title: "<spring:message code='Tozin.plak.container'/>",
            align: "center",
            showHover: true,
            width: "10%"
        },
        {
            name: "vazn",
            required: true,
            title: "<spring:message code='Tozin.vazn'/>",
            align: "center",
            showHover: true,
            width: "10%"
        },
        {
            name: "sourceId",
            type: "number",
            required: true,
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
            // valueMap: {
            //     2320: 'بندر شهيد رجايي، روبروي اسكله شانزده ،محوطه فلزات آلياژي شركت تايد واتر',
            //     1000: 'مجتمع مس سرچشمه',
            //     2340: 'بندر شهيد رجايي ، انبار كالا شماره 20',
            //     2555: 'اسكله شهيد رجائي ',
            // },
            title: "<spring:message code='Tozin.targetId'/>",
            align: "center",
        },
    ];
}
BlTab.Fields.TozinTable = function () {
    return [
        ...BlTab.Fields.TozinBase(),
        {
            name: 'isInView',
            title: "اطلاعات از لجستیک",
            defaultValue: false,
            valueMap: {true: "بله", false: "خیر"}
        },
        {name: 'haveCode', hidden: true},
        {name: 'cardId', hidden: true},
        {name: 'ctrlDescOut', title: "شرح"},
        {name: 'version', hidden: true},
    ];
}
BlTab.Fields.TozinLite = function () {
    return [
        ...BlTab.Fields.TozinBase(),
        {
            name: "containerNo1",
            title: "<spring:message code='Tozin.containerNo1'/>",
            align: "center", hidden: true,
        },
        {
            name: "containerNo3", hidden: true,
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
                            //  console.log(criteria)
                            ListGrid_Tozin_IN_ONWAYPRODUCT.setFilterEditorCriteria(criteria);
                            return this.Super("change", arguments)
                        },
                    }]
                })
            }
            // alwaysShowOperatorIcon:true,
        },
        {
            name: "havalehCode", hidden: true,
            title: "<spring:message code='Tozin.haveCode'/>",
            align: "center"
        },
    ];
}
BlTab.Fields.TozinFull = function () {
    return [
        ...BlTab.Fields.TozinLite(),
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
}
BlTab.Fields.RemittanceDetail = function () {
    return [
        {name: "id", hidden: true, type: "number"},
        {
            name: "remittanceId", hidden: true,
            // optionDataSource: isc.MyRestDataSource.create({
            //     fetchDataURL: 'api/remittance/spec-list',
            //     fields: BlTab.Fields.Remittance
            // }),
            // pickListProperties: {
            //     fields: BlTab.Fields.Remittance
            // },
            displayField: "code",
            valueField: "id",
        },
        {name: "depot.id", hidden: true, title: "دپو",},
        {
            name: "unitId",
            valueMap: SalesBaseParameters.getSavedUnitParameter().getValueMap('id', 'nameFA'),
            type: "number",
            title: "واحد",
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,
        },
        {
            name: "amount",
            title: "تعداد محصول",
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,


        },
        {
            name: "weight",
            title: "وزن",
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,


        },
        {
            name: "sourceTozin.tozinId",
            title: "توزین مبدا",
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,
            pickListFields: BlTab.Fields.TozinLite(),
            showHover: true,
            showHoverComponents: true,
        },
        {
            name: "destinationTozin.tozinId",
            title: "توزین مقصد",
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,
            showHover: true,
            showHoverComponents: true,
            pickListFields: BlTab.Fields.TozinLite()

        },
        {
            name: "securityPolompNo",
            title: "پلمپ حراست",
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,


        },
        {
            name: "railPolompNo",
            title: "پلمپ راه‌آهن",
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,


        },
        {
            name: "description",
            title: "توضیحات پکیج",
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,


        },
    ];
}
BlTab.Fields.RemittanceDetailFullFields = function () {
    return [
        // {
        //     name: "remittance.code", title: "شماره بیجک"
        //     , recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
        //         BlTab.Methods.RecordDoubleClick('api/remittance', BlTab.Fields.Remittance, "remittance",
        //             viewer, record, recordNum, field, fieldNum, value, rawValue)
        //     }
        // },
        // {
        //     name: "remittance.description",
        //     title: "توضیحات بیجک",
        //     recordDoubleClick() {
        //         BlTab.Methods.RecordDoubleClick("api/remittance", BlTab.Fields.Remittance, 'remittance', ...arguments)
        //     }
        //
        // },
        {
            name: "inventory.label",
            title: "سریال محصول",
            recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                BlTab.Methods.RecordDoubleClick('api/inventory', BlTab.Fields.Inventory(), "inventory",
                    viewer, record, recordNum, field, fieldNum, value, rawValue)
            }
        },
        {
            name: "inventory.materialItem.id",
            valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName"),
            type: "number",
            title: "محصول",
            hidden: true,
            recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                BlTab.Methods.RecordDoubleClick('api/inventory', BlTab.Fields.Inventory(), "inventory",
                    viewer, record, recordNum, field, fieldNum, value, rawValue)
            }
        },
        {
            name: "destinationTozin.sourceId",
            valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
            title: "مبدا",
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD, hidden: true,


        },
        {
            name: "destinationTozin.date",
            title: "تاریخ توزین مقصد",
            hidden: true,
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,


        },
        {
            name: "destinationTozin.targetId",
            valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
            title: "مقصد",
            hidden: true,
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD,


        },
        {
            name: "depot.name", showHover: true, title: "دپو", formatCellValue(value, record) {
                //  console.log('name: "depot.id", hidden: true, disabled: true,title:"دپو",formatCellValue()', arguments);
                // return this.Super('formatCellValue',arguments);
                const title = record.depot.store.warehouse.name + " - " + record.depot.store.name + " - " + record.depot.name;
                return title;
            },
            showHoverComponents: false,
            hidden: true,
            recordDoubleClick: BlTab.Methods.RecordDoubleClickRD
        },
        ...BlTab.Fields.RemittanceDetail(),

    ];
}
BlTab.Fields.Remittance = function () {
    return [
        {
            name: 'code', title: "شماره بیجک",
            recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                BlTab.Methods.RecordDoubleClick('api/remittance', BlTab.Fields.Remittance(), false,
                    viewer, record, recordNum, field, fieldNum, value, rawValue)
            },
            required: true,
        },
        {
            name: 'description', title: "شرح بیجک",
            recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                BlTab.Methods.RecordDoubleClick('api/remittance', BlTab.Fields.Remittance(), false,
                    viewer, record, recordNum, field, fieldNum, value, rawValue)
            },
        },
        {name: 'id', title: "شناسه", hidden: true},
    ];
}
BlTab.Fields.RemittanceFull = function () {
    return [
        ...BlTab.Fields.Remittance(),
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
            formatCellValue(value, record) {
                if (value) return value;
                return SalesBaseParameters.getSavedWarehouseParameter().find(w => {
                    return w.id == record.remittanceDetails[0].sourceTozin.sourceId;
                }).name;
            }
        },
        {
            ...BlTab.Fields.TozinBase().find(t => t.name === 'date'),
            name: "remittanceDetails.sourceTozin.date",
            title: "تاریخ توزین مبدا",

        },
        {
            ...BlTab.Fields.TozinBase().find(t => t.name === 'date'),
            name: "remittanceDetails.destinationTozin.date",
            title: "تاریخ توزین مقصد",


        },
        {
            name: "remittanceDetails.destinationTozin.targetId",
            valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
            title: "مقصد",
            hidden: true,
        },
        {
            name: "remittanceDetails.depot.name",
            // valueMap: SalesBaseParameters.getSavedWarehouseParameter().getValueMap("id", "name"),
            title: "دپو",
            showHover: true,
            formatCellValue(value, record) {
                // console.log('name: "depot.id", hidden: true, disabled: true,title:"دپو",formatCellValue()', arguments);
                // return this.Super('formatCellValue',arguments);
                try {
                    const title = record.remittanceDetails[0].depot.store.warehouse.name +
                        " - " + record.remittanceDetails[0].depot.store.name +
                        " - " + record.remittanceDetails[0].depot.name;
                    return title;
                } catch (e) {
                    console.error("depot name in remittance listgrid\n", e);
                    return value;
                }

            },
        },
    ];
}
BlTab.Fields.Inventory = function () {
    return [
        {
            name: 'materialItemId',
            valueMap: SalesBaseParameters.getSavedMaterialItemParameter().getValueMap("id", "gdsName"),
            title: 'محصول',
            disabled: true,

        },
        {name: 'label', title: 'سریال محصول'},
        {name: 'id', title: 'شناسه', hidden: true,},
    ];
}
BlTab.Fields.Depot = function () {
    return [
        {name: "store.warehouse.name", title: "انبار"},
        {name: "store.name", title: "سوله/محوطه"},
        {name: "name", title: "یارد"}
    ];
}
BlTab.Fields.BillOfLandingSwitch = function () {
    const contactOptionDataSource = _ => {
        return {
            autoFetchData: false,
            required: true,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "nameEN",
            pickListWidth: "500",
            pickListHeight: "300",
            optionDataSource: isc.MyRestDataSource.create({...BlTab.RestDataSources.Contact}),
            click: function () {
            },
            // optionCriteria: currencyInUnitCriteria,
            pickListProperties:
                {
                    showFilterEditor: true
                },
            pickListFields: [
                {
                    name: "nameFA",
                    align: "center"
                },
                {
                    name: "nameEN",
                    align: "center"
                },
            ],
        }
    }
    const portOptionDataSource = _ => {
        return {
            autoFetchData: false,
            required: true,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "port",
            pickListWidth: "700",
            pickListHeight: "300",
            optionDataSource: isc.MyRestDataSource.create({...BlTab.RestDataSources.Port}),
            click: function () {
            },
            // optionCriteria: currencyInUnitCriteria,
            pickListProperties:
                {
                    showHover: true,
                    autoFitWidth: true,
                    showFilterEditor: true
                },
            pickListFields: BlTab.Fields.Port(),
        }
    }
    return [
        {name: 'switchDocumentNo',},
        {name: 'switchShipperExporter', hidden: true, shouldSaveValue: false},
        {
            name: 'switchShipperExporterId',
            ...contactOptionDataSource(),

        },
        {name: 'switchNotifyParty', hidden: true, shouldSaveValue: false},
        {
            name: 'switchNotifyPartyId',
            ...contactOptionDataSource(),
        },
        {name: 'switchConsignee', hidden: true, shouldSaveValue: false},
        {
            name: 'switchConsigneeId',
            ...contactOptionDataSource(),
        },
        {name: 'switchPortOfLoading', hidden: true, shouldSaveValue: false},
        {name: 'switchPortOfLoadingId', ...portOptionDataSource()},
        {name: 'switchPortOfDischarge', hidden: true, shouldSaveValue: false},
        {name: 'switchPortOfDischargeId', ...portOptionDataSource()},
    ]
}
/*
BlTab.Fields.BillOfLandingSwitch = _ => [
    {name: 'switchDocumentNo',},
    {name: 'switchShipperExporter',},
    {name: 'switchShipperExporterId',},
    {name: 'switchNotifyParty',},
    {name: 'switchNotifyPartyId',},
    {name: 'switchConsignee',},
    {name: 'switchConsigneeId',},
    {name: 'switchPortOfLoading',},
    {name: 'switchPortOfLoadingId',},
    {name: 'switchPortOfDischarge',},
    {name: 'switchPortOfDischargeId',},
]

 */
BlTab.Fields.BillOfLandingWithoutSwitch = _ => [
    {name: 'id', hidden: true,},
    ...BlTab.Fields.BillOfLandingSwitch().map(b => {
        b.name = b.name.toString().substr(6).replace(/^./, function (char) {
            return char.toLowerCase();
        });
        return b
    }),
    {name: 'placeOfDelivery', required: true,},
    {name: 'oceanVessel', hidden: true, shouldSaveValue: false},
    {
        name: 'oceanVesselId', ...{
            required: true,
            autoFetchData: false,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "Name",
            pickListWidth: "700",
            pickListHeight: "300",
            optionDataSource: isc.MyRestDataSource.create({...BlTab.RestDataSources.Vessel}),
            click: function () {
            },
            // optionCriteria: currencyInUnitCriteria,
            pickListProperties:
                {
                    showHover: true,
                    autoFitWidth: true,
                    showFilterEditor: true
                },
            pickListFields: BlTab.Fields.Vessel(),
        }
    },
    {name: 'totalNet', required: true,},
    {name: 'totalGross',},
    {name: 'totalBundles',},
    {name: 'numberOfBlCopies', required: true,},
    {name: 'dateOfIssue', type: "date"},
    {name: 'placeOfIssue', required: true,},
    {
        name: 'description', colSpan: 6,
        editorType: "textArea",
    },
]
/*
BlTab.Fields.BillOfLandingSwitch = _ => [
    {name: 'switchDocumentNo',},
    {name: 'switchShipperExporter',},
    {name: 'switchShipperExporterId',},
    {name: 'switchNotifyParty',},
    {name: 'switchNotifyPartyId',},
    {name: 'switchConsignee',},
    {name: 'switchConsigneeId',},
    {name: 'switchPortOfLoading',},
    {name: 'switchPortOfLoadingId',},
    {name: 'switchPortOfDischarge',},
    {name: 'switchPortOfDischargeId',},
]

 */
BlTab.Fields.BillOfLanding = _ => [
    ...BlTab.Fields.BillOfLandingWithoutSwitch(),
    ...BlTab.Fields.BillOfLandingSwitch()
]
BlTab.Fields.ContainerToBillOfLanding = _ => [
    {name: 'id', hidden: true,},
    // {name: 'billOfLanding',hidden: true},
    {name: 'billOfLandingId', hidden: true},
    {name: 'containerType',},
    {name: 'containerNo',},
    {name: 'sealNo',},
    {name: 'quantity',},
    {name: 'quantityType',},
    {name: 'weight',},
    {name: 'unit', hidden: true,},
    {
        name: 'unitId',
        displayField: 'nameEN',
        valueField: "id",
        optionDataSource: isc.MyRestDataSource.create({
            fields:
                [
                    {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                    {name: "code", title: "<spring:message code='unit.code'/> "},
                    {name: "nameFA", title: "<spring:message code='unit.nameFa'/> "},
                    {name: "nameEN", title: "<spring:message code='unit.nameEN'/> "},
                    {name: "symbol", title: "<spring:message code='unit.symbol'/>"},
                    {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
                ],
            fetchDataURL: "api/unit/spec-list"
        }),
    },
]
BlTab.Fields.RemittanceToBillOfLanding = _ => [
    {name: 'id', hidden: true,},
    // {name: 'billOfLanding',hidden: true},
    {name: 'remittance.code',},
    {name: 'remittance.description',},
    {name: 'remittanceId',},
    {name: 'billOfLandingId',},
]
////////////////////////////////////////////////////////DATASOURCE//////////////////////////////////////////////////////
BlTab.RestDataSources.Vessel = {
    fields: BlTab.Fields.Vessel(),
    fetchDataURL: "api/vessel/spec-list"
}
BlTab.RestDataSources.Port = {
    fields: BlTab.Fields.Port(),
    fetchDataURL: "api/port/spec-list"
}
BlTab.RestDataSources.Contact = {
    fields: BlTab.Fields.Contact(),
    fetchDataURL: "api/contact/spec-list"
}
BlTab.RestDataSources.BillOfLanding = {
    fields: BlTab.Fields.BillOfLanding(),
    fetchDataURL: "api/bill-of-landing/spec-list"
}
BlTab.RestDataSources.RemittanceToBillOfLanding = {
    fields: BlTab.Fields.RemittanceToBillOfLanding(),
    fetchDataURL: "api/remittance-to-bill-of-landing/spec-list"
}
BlTab.RestDataSources.Remittance = {
    fetchDataURL: "api/remittance/spec-list?distinct=true&",
    updateDataURL: "api/remittance/",
    fields: BlTab.Fields.RemittanceFull()
};
////////////////////////////////////////////////////////GRIDS///////////////////////////////////////////////////////////
BlTab.Grids.RemittanceDetail = {
    fields: BlTab.Fields.RemittanceDetailFullFields(),
    showHoverComponents: true,
    getCellHoverComponent: function (record, rowNum, colNum) {
        // console.log('getCellHoverComponent', this, arguments)
        this.rowHoverComponent = isc.DetailViewer.create({
            dataSource: isc.MyRestDataSource.create({
                fields: BlTab.Fields.TozinFull(),
                fetchDataURL: 'api/tozin/spec-list'
            }),
            width: 250
        });

        this.rowHoverComponent.fetchData({
            criteria: {
                fieldName: "tozinId",
                operator: "equals",
                value: eval('record.' + this.getField(colNum).name)
            }
        }, null, {showPrompt: false});

        return this.rowHoverComponent;
    },
    showFilterEditor: false,
    autoSaveEdits: false,
    allowAdvancedCriteria: false,
    // groupByField: "remittance.code",
    autoFetchData: false,
}
BlTab.Grids.Remittance = {
    // ID: BlTab.Vars.Prefix + "remittance_detail_tab_list_grid",
    showFilterEditor: true,
    expansionFieldImageShowSelected: true,
    initialCriteria: {
        operator: "and",
        criteria: [
            {
                fieldName: "remittanceDetails.destinationTozin",
                operator: "isNull",
                // value: value
            }
        ]
    },
    canExpandRecords: true,
    canExpandMultipleRecords: false,

    getExpansionComponent: function (grecord, rowNum, colNum) {
        return isc.VLayout.create({
            height: .3 * innerHeight,
            members: [

                isc.ListGrid.create({
                    ...BlTab.Grids.RemittanceDetail,
                    data: grecord['remittanceDetails']
                })
            ]
        })
    },
    // canEdit: true,
    // editEvent: "doubleClick",
    // groupByField: "remittance.code",
    autoSaveEdits: false,
    // getCellCSSText(record, rowNum, colNum) {
    //     if (!BlTab.Grids.BillOfLanding.obj.getSelectedRecord().remittances || BlTab.Grids.BillOfLanding.obj.getSelectedRecord().remittances.length === 0) {
    //         return "font-weight:bold; color:#287fd6;";
    //     }
    //     return this.Super('getCellCSSText', arguments)
    // }

    allowAdvancedCriteria: true,
    // dataSource: BlTab.RestDataSources.Remittance,
    autoFetchData: true,


}
BlTab.Grids.BillOfLanding = {
    height: "100%",
    recordDoubleClick(viewer, record, recordNum, field, fieldNum, value, rawValue) {
        BlTab.Layouts.ToolStripButtons.NewBillOfLanding.click();
        BlTab.Vars.BillOfLanding.setValues(record);
        BlTab.Vars.Method = "PUT"
    },
    autoFitWidth: true,
    autoFetchData: true,
    dataSource: {...BlTab.RestDataSources.BillOfLanding},
    expansionFieldImageShowSelected: true,
    canExpandRecords: true,
    canExpandMultipleRecords: false,
    getExpansionComponent: function (record, rowNum, colNum) {
        // gridComponents
        const remittanceGrid = isc.ListGrid.create({
            ...BlTab.Grids.Remittance,
            showFilterEditor: false,
            gridComponents: [isc.ToolStrip.create({
                members: [
                    isc.ToolStripButtonAdd.create({
                        // title: 'add',
                        click() {
                            // dbg('new remittance', arguments)
                            let gridForSelectRemittance;
                            const win = isc.Window.create({
                                ...BlTab.Vars.DefaultWindowConfig,
                                height: .5 * innerHeight,
                                members: [
                                    isc.VLayout.create({
                                        height: "100%",
                                        members: [
                                            isc.ToolStrip.create(
                                                {
                                                    members: [isc.ToolStripButtonAdd.create({
                                                        click() {
                                                            BlTab.Vars.Method = "POST";
                                                            BlTab.Methods.Save(JSON.stringify(
                                                                gridForSelectRemittance.getSelectedRecords().map(r => {
                                                                    return {
                                                                        remittanceId: r.id,
                                                                        billOfLandingId: record.id,
                                                                    }
                                                                })
                                                            ), 'api/remittance-to-bill-of-landing');
                                                        }
                                                    })]
                                                }
                                            ),
                                            gridForSelectRemittance = isc.ListGrid.create({
                                                ...BlTab.Grids.Remittance,
                                                dataSource: isc.MyRestDataSource.create({...BlTab.RestDataSources.Remittance})
                                            })
                                        ]
                                    })
                                ]
                            })
                            win.show();
                        }
                    }),
                    isc.ToolStripButtonRemove.create({
                        click() {
                            const deleteList = {ids: remittanceGrid.getSelectedRecords().map(r => r.deleteId)}
                            fetch('api/remittance-to-bill-of-landing', {
                                headers: SalesConfigs.httpHeaders,
                                body: JSON.stringify(deleteList),
                                method: "DELETE"
                            })
                        }
                    }),
                ]
            }), "filterEditor", "header",
                "body", "summaryRow"],
            fields: BlTab.Fields.RemittanceFull(),
            // data: record.remittances.map(r => r.remittance)
        })
        BlTab.Grids.ContainerToBillOfLanding = isc.ListGrid.create({
            data: record.containers,
            gridComponents: [isc.ToolStrip.create({
                members: [
                    BlTab.Layouts.ToolStripButtons.NewContainerToBillOfLanding = isc.ToolStripButtonAdd.create({
                        click() {
                            // dbg('window create container info', arguments);
                            BlTab.Vars.Method = "POST";
                            const winId = BlTab.Vars.Prefix + "window_container" + Math.random().toString().substr(2, 4)
                            BlTab.Layouts.Window.ContainerToBillOfLanding = isc.Window.create({
                                ...BlTab.Vars.DefaultWindowConfig,
                                ID: winId,
                                members: [
                                    isc.VLayout.create({
                                        members: [
                                            BlTab.DynamicForms.Forms.ContainerToBillOfLanding = isc.DynamicForm.create({
                                                fields: BlTab.Fields.ContainerToBillOfLanding()
                                            }),
                                            BlTab.Methods.HlayoutSaveOrExit(function () {

                                                BlTab.Methods.Save({
                                                        ...BlTab.DynamicForms.Forms.ContainerToBillOfLanding.getValues(),
                                                        billOfLandingId: record.id
                                                    },
                                                    'api/container-to-bill-of-landing').then(
                                                    _ => BlTab.Layouts.Window.ContainerToBillOfLanding.destroy()
                                                )
                                            }, winId)
                                        ]
                                    })
                                ]
                            });
                            BlTab.Layouts.Window.ContainerToBillOfLanding.show()
                        }
                    }),
                    isc.ToolStripButtonEdit.create({
                        click() {
                            dbg('container edit')
                            BlTab.Layouts.ToolStripButtons.NewContainerToBillOfLanding.click();
                            BlTab.Vars.Method = "PUT";
                            BlTab.DynamicForms.Forms.ContainerToBillOfLanding.setValues(BlTab.Grids.ContainerToBillOfLanding.getSelectedRecord());
                        }
                    }),
                    isc.ToolStripButtonRemove.create({
                        click() {
                            BlTab.Methods.Delete(BlTab.Grids.ContainerToBillOfLanding,
                                SalesConfigs.Urls.completeUrl + '/api/container-to-bill-of-landing')
                        }
                    }),
                ]
            }), "filterEditor", "header",
                "body", "summaryRow"],
            fields: BlTab.Fields.ContainerToBillOfLanding()
        });
        // const a = new Date().getTime();
        // dbg('before fetch',a);
        fetch('api/remittance-to-bill-of-landing/spec-list?criteria=' + JSON.stringify({
            "fieldName": "billOfLandingId",
            "operator": "equals",
            "value": record.id
        }), {headers: SalesConfigs.httpHeaders}).then(
            r => r.json().then(j => {
                // dbg('after fetched',new Date().getTime() - a);
                remittanceGrid.setData(j.response.data.map(d => {
                    d.remittance.deleteId = d.id;
                    return d.remittance
                }));

            })
        )
        // dbg('after fetch',new Date().getTime() - a);
        return isc.TabSet.create({
            /*
            tabSelected(tabSet, tabNum, tabPane, ID, tab, name) {
                dbg(`BlTab.Layouts.ToolStripButtons.new.click = _ => {
isc.ValuesManager.create({
    ID: "vm"
});
isc.Window.create({
    ...BlTab.Vars.DefaultWindowConfig,
    members: [
        isc.TabSet.create`, arguments)
            },
             */
            height: .3 * innerHeight,
            width: "100%",
            tabs: [
                {
                    title: "Remittance",
                    pane: remittanceGrid
                },
                {
                    title: "Containers",
                    pane: BlTab.Grids.ContainerToBillOfLanding
                }
            ]
        })
    },
}
////////////////////////////////////////////////////////DYNAMICFORMS////////////////////////////////////////////////////
////////////////////////////////////////////////////////COMPONENTS//////////////////////////////////////////////////////
BlTab.Layouts.ToolStripButtons.NewBillOfLanding = {...BlTab.Layouts.ToolStripButtons.new}
BlTab.Layouts.ToolStripButtons.EditBillOfLanding = {...BlTab.Layouts.ToolStripButtons.edit}
BlTab.Layouts.ToolStripButtons.RefreshBillOfLanding = {
    ...BlTab.Layouts.ToolStripButtons.refresh, click() {
        BlTab.Grids.BillOfLanding.obj.invalidateCache()
    }
}
BlTab.Layouts.ToolStripButtons.RemoveBillOfLanding = {
    ...BlTab.Layouts.ToolStripButtons.remove,
    click() {
        BlTab.Methods.Delete(BlTab.Grids.BillOfLanding.obj, SalesConfigs.Urls.completeUrl + '/api/bill-of-landing/')
    }
}
BlTab.Layouts.ToolStripButtons.NewRemittanceBillOfLanding = {...BlTab.Layouts.ToolStripButtons.new}
BlTab.Layouts.ToolStripButtons.EditRemittanceBillOfLanding = {...BlTab.Layouts.ToolStripButtons.edit}
BlTab.Layouts.ToolStripButtons.EditContainerToBillOfLanding = {...BlTab.Layouts.ToolStripButtons.edit}
BlTab.Layouts.ToolStripButtons.new.click = _ => {
    console.debug('BlTab.Layouts.ToolStripButtons.new.click', BlTab.Layouts.ToolStripButtons.new)
    const win = BlTab.Methods.CreateWindowForForm(BlTab.Fields.BillOfLanding(), 'api/bill-of-landing')
    BlTab.Layouts.Window.BillOfLanding = win[0];
    BlTab.DynamicForms.Forms.BillOfLanding = win[1];

    /**
     [
     BlTab.Layouts.Window.BillOfLanding ,
     BlTab.DynamicForms.Forms.BillOfLanding
     ] = BlTab.Methods.CreateWindowForForm(BlTab.Fields.BillOfLanding(), 'api/bill-of-landing')


     */

    BlTab.Methods.NewForm(
        BlTab.Layouts.Window.BillOfLanding, BlTab.DynamicForms.Forms.BillOfLanding
    )
}
BlTab.Layouts.ToolStripButtons.NewBillOfLanding.click = _ => {
    BlTab.Vars.Method = "POST"
    BlTab.Vars.BillOfLanding = isc.ValuesManager.create({});
    BlTab.DynamicForms.Forms.BillOfLandingMain = isc.DynamicForm.create({
        numCols: 6,
        valuesManager: BlTab.Vars.BillOfLanding,
        fields: BlTab.Fields.BillOfLandingWithoutSwitch(),
    });
    const windID = BlTab.Vars.Prefix + "window_bill_of_landing" + Math.random().toString().substr(2, 4)
    isc.Window.create({
        ...BlTab.Vars.DefaultWindowConfig,
        ID: windID,
        members: [
            BlTab.Layouts.BillOfLandingFormTab = isc.TabSet.create({
                /*
                tabSelected(tabSet, tabNum, tabPane, ID, tab, name) {
                    dbg(`BlTab.Layouts.ToolStripButtons.new.click = _ => {
    isc.ValuesManager.create({
        ID: "vm"
    });
    isc.Window.create({
        ...BlTab.Vars.DefaultWindowConfig,
        members: [
            isc.TabSet.create`, arguments)
                },
                 */
                height: .3 * innerHeight,
                width: "100%",
                tabs: [
                    {
                        title: "Bill Of Landing",
                        pane: BlTab.DynamicForms.Forms.BillOfLandingMain
                    },
                    {
                        title: "Switch",
                        pane: isc.DynamicForm.create({
                            numCols: 6,
                            valuesManager: BlTab.Vars.BillOfLanding,
                            fields: BlTab.Fields.BillOfLandingSwitch()
                        })
                    }
                ]
            }),
            isc.HLayout.create({
                height: "5%",
                members: [
                    isc.Button.create({
                        top: 260,
                        title: "Fill Switch Data",
                        click: function () {


                            if (!BlTab.DynamicForms.Forms.BillOfLandingMain.validate()) return BlTab.Layouts.BillOfLandingFormTab.selectTab(0);
                            const fields = BlTab.Fields.BillOfLandingSwitch().filter(b => {
                                if (b.shouldSaveValue && b.shouldSaveValue === false) return false;
                                return true
                            }).map(b => b.name)

                            fields.forEach(b => {
                                if (BlTab.Vars.BillOfLanding.getValue(b)) {
                                    return
                                }

                                BlTab.Vars.BillOfLanding.setValue(b, BlTab.DynamicForms.Forms.BillOfLandingMain
                                    .getValue(b.toString().substr(6).replace(/^./, function (char) {
                                        return char.toLowerCase();
                                    })))
                            })

                        }
                    }),
                ],
            }),
            BlTab.Methods.HlayoutSaveOrExit(function () {
                if (!BlTab.Vars.BillOfLanding.validate()) {
                    if (BlTab.DynamicForms.Forms.BillOfLandingMain.hasErrors()) BlTab.Layouts.BillOfLandingFormTab.selectTab(0);
                    else BlTab.Layouts.BillOfLandingFormTab.selectTab(1);
                    return;
                }
                /*
                                            fetch('api/bill-of-landing', {
                                                headers: SalesConfigs.httpHeaders,
                                                method: "POST",
                                                body: JSON.stringify(BlTab.Vars.BillOfLanding.getValues())
                                            }).then(
                                                _ => _.json().then(j => dbg('BL Fetch saved data', j)).catch(err => dbg('BL Fetch saved ERROR data', err))
                                            )
                                            */
                BlTab.Methods.Save(BlTab.Vars.BillOfLanding.getValues(), 'api/bill-of-landing').then(function () {
                    dbg(`BlTab.Methods.Save(BlTab.Vars.BillOfLanding.getValues(), 
                        'api/bill-of-landing').then(function () {`, arguments)
                    window[windID].destroy();
                })
            }, windID)
        ]
    })

}
BlTab.Layouts.ToolStripButtons.EditBillOfLanding.click = _ => {
    BlTab.Grids.BillOfLanding.recordDoubleClick(BlTab.Grids.BillOfLanding, BlTab.Grids.BillOfLanding.getSelectedRecord())
}
BlTab.Layouts.ToolStripButtons.new.click = BlTab.Layouts.ToolStripButtons.NewBillOfLanding.click
BlTab.Layouts.ToolStripButtons.edit.click = BlTab.Layouts.ToolStripButtons.EditBillOfLanding.click
BlTab.Layouts.ToolStripButtons.remove.click = BlTab.Layouts.ToolStripButtons.RemoveBillOfLanding.click
BlTab.Layouts.ToolStripButtons.refresh.click = BlTab.Layouts.ToolStripButtons.RefreshBillOfLanding.click
BlTab.Layouts.ToolStrips.BillOfLanding = BlTab.Layouts.ToolStrips.CreateMainToolStrip();
BlTab.Layouts.Vlayouts.MainVLayOut = BlTab.Layouts.Vlayouts.CreateMainVlayOut([
    BlTab.Layouts.ToolStrips.BillOfLanding,
    BlTab.Grids.BillOfLanding.obj = isc.ListGrid.create({
        ...BlTab.Grids.BillOfLanding,
        dataSource: isc.MyRestDataSource.create({...BlTab.Grids.BillOfLanding.dataSource}),

    })
])
console.debug('BlTab', BlTab, dbg)
////////////////////////////////////////////////////////WINDOWS/////////////////////////////////////////////////////////
