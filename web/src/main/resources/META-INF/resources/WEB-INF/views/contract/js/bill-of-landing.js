//<%@ page contentType="text/html;charset=UTF-8" %>
//<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
//<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
const BlTab = {
    Logs: [],
    Vars: {
        Debug: false,
        Prefix: "bill_of_landing_detail_tab" + Math.random().toString().substr(-6),
        Url: "",
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
            height: 0.51 * window.innerHeight,
            //autoSize: true,
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
        CrudDynamicForm: async function (props, callBack) {
            BlTab.Logs.add(['props:', props]);
            if (typeof (props) === "undefined") return;
            let url = BlTab.Vars.Url;
            let method = BlTab.Vars.Method;
            let httpHeaders = SalesConfigs.httpHeaders;
            let params = "";
            let data = "";
            let defaultResponse = async function (response) {
                if (response.status === 400 || response.status == 500) {
                    const error = await response.json()
                    BlTab.Logs.add(["fetch error:", error]);
                    // MyRPCManager.handleError({httpResponseText: error});
                    if (error.error) {
                        const er = error.error;
                        if (er && er.toString().toLowerCase().includes("Unique".toLowerCase())) {
                            return isc.warn("<spring:message code='billOfLanding.document.no.unique.error' />");
                        }
                        if (er && er.toString().toLowerCase().includes("_FK".toLowerCase())) {
                            return isc.warn("<spring:message code='exception.DataIntegrityViolation_FK' />:\n" + JSON.stringify(error));
                        }
                    }
                    return isc.warn(error.errors[0].message);
                }

                if (response.status === 200 || response.status === 201) {
                    // await response.text()
                    BlTab.Dialog.Success();
                    if (callBack) callBack();
                    // BlTab.Grids.BillOfLanding.obj.invalidateCache();
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
            }, callBack)
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
                        buttons: [isc.IButtonSave.create({title: '<spring:message code="global.ok"/>'})],
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
        Delete: function (grid, deleteUrl, callBack) {
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
                                }, callBack);
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
        RefreshContainerData: async function (mainGrid, id, listGrid) {
            let resp = await fetch("api/bill-of-landing/" + id, {
                headers: SalesConfigs.httpHeaders,
            });
            let respjson = await resp.json();
            listGrid.invalidateCache();
            listGrid.setData(respjson.containers);
            let localData = mainGrid.getData().localData;
            localData.filter(r => r.id == id)[0].containers = respjson.containers;
            mainGrid.getData(localData);
            listGrid.redraw();

        },
        HlayoutSaveOrExit: function (saveClickFunc, windowToClose, id = null) {
            windowToCloseIs = () => {
                const ev = eval(windowToClose);
                //console.log("ev is",ev);
                return ev;
            };
            let property = (
                {
                    layoutMargin: 0,
                    showEdges: false,
                    edgeImage: "",
                    width: "100%",
                    height: 1,
                    alignLayout: "bottom",
                    padding: 10,
                    membersMargin: 10,
                    members: [
                        // <sec:authorize access="hasAuthority('U_BILL_OF_LANDING') or hasAuthority('C_BILL_OF_LANDING')">
                        isc.IButtonSave.create({
                            click: () => {
                                saveClickFunc();
                            }
                        }),
                        // </sec:authorize>
                        isc.IButtonCancel.create({
                            width: 100,
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
                                    //    <sec:authorize access="hasAuthority('C_BILL_OF_LANDING')">
                                    isc.ToolStripButtonAdd.create({
                                        // ID: BlTab.Vars.Prefix + "toolـstripـbuttonـadd",
                                        ...BlTab.Layouts.ToolStripButtons.new,
                                    }),
                                    //  </sec:authorize>
                                    //   <sec:authorize access="hasAuthority('U_BILL_OF_LANDING')">
                                    isc.ToolStripButtonEdit.create({
                                        // ID: BlTab.Vars.Prefix + "toolـstripـbuttonـadd",
                                        ...BlTab.Layouts.ToolStripButtons.edit,
                                    }),

                                    ,
                                    //   </sec:authorize>
                                    //    <sec:authorize access="hasAuthority('D_BILL_OF_LANDING')">
                                    isc.ToolStripButtonRemove.create({
                                        ...BlTab.Layouts.ToolStripButtons.remove,
                                        // ID: BlTab.Vars.Prefix + "tool_stripـbuttonـremove",
                                    }),
                                    //    </sec:authorize>
                                    //    <sec:authorize access="hasAuthority('AT_BILL_OF_LADING')">
                                    isc.ToolStripButton.create({
                                        ...BlTab.Layouts.ToolStripButtons.fileUpload,
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
            fileUpload: {
                icon: "pieces/512/attachment.png",
                title: "<spring:message code='global.attach.file'/>",
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
BlTab.Fields.Shipment = _ => [
    {name: "id", primaryKey: true, canEdit: false, hidden: true},
    {
        name: "contractShipment.contract.no",
        hidden: true,
        title: "<spring:message code='contract.contractNo'/>"
    },
    {
        name: "material.descFA",
        title: "<spring:message code='material.descFA'/>"
    },
    {
        name: "material.descEN",
        title: "<spring:message code='material.descEN'/>"
    }
];
BlTab.Fields.Vessel = _ => [
    {
        name: 'id', title: "<spring:message code='global.id'/>",
    },
    {
        name: 'name',
        title: "<spring:message code='global.name'/>",
    },
    {name: 'type', title: "<spring:message code='global.type'/>",},
    {name: 'imo',},
    {name: 'yearOfBuild', hidden: true},
    {name: 'length', hidden: true},
    {name: 'beam', hidden: true},
]
BlTab.Fields.Port = _ => [
    {
        name: 'id',
        title: "<spring:message code='global.id'/>",
    },
    {
        name: 'country.nameEN',
        title: "<spring:message code='currency.name.en'/>",
    },
    {
        name: 'country.nameFA',
        title: "<spring:message code='currency.name.fa'/>",
    },
    {
        name: 'countryId',
        title: "<spring:message code='global.country'/>",
    },
    {
        name: 'port', width: "15%",
        title: "<spring:message code='port.port'/>",
    },
    {
        name: 'loa',
        title: "<spring:message code='port.loa'/>",
    },
    {
        name: 'beam',
        title: "<spring:message code='vessel.beam'/>",
    },
    {
        name: 'arrival', hidden: true,
        title: "<spring:message code='global.country'/>",
    },
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
BlTab.Methods.contactOptionDataSource = _ => {
    return {
        autoFetchData: false,
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
                title: "<spring:message code='currency.name.fa'/>",
                align: "center"
            },
            {
                name: "nameEN",
                title: "<spring:message code='currency.name.en'/>",
                align: "center"
            },
        ],
    }
}
BlTab.Methods.portOptionDataSource = _ => {
    return {
        autoFetchData: false,
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
BlTab.Methods.validateEqualsFields = _ => {
    if (_.shipperExporterId)
        if (_.shipperExporterId == _.consigneeId || _.shipperExporterId == _.notifyPartyId) {
            isc.warn("<spring:message code='billOfLanding.shipper.exporter.warn'/>");
            return false;
        }
    if (_.portOfDischargeId)
        if (_.portOfDischargeId == _.portOfLoadingId) {
            isc.warn("<spring:message code='billOfLanding.port.of.landing.equal.discharge.warn'/>");
            return false;
        }
    return true;
}
BlTab.Fields.BillOfLandingSwitch = function () {
    return [
        {
            name: 'documentNo',
            required: false,
            title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.document.no'/>  ",
            keyPressFilter: "[0-9/_a-zA-Z\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F-]",
            validateOnChange: true,
            validators: [
                {
                    type: "regexp",
                    expression: "^[0-9/_a-zA-Z\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F-]*$",
                    validateOnChange: true,
                }
            ]
        },
        {
            name: 'shipperExporterId',
            ...BlTab.Methods.contactOptionDataSource(),
            title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.shipper.exporter'/>",

        },
        {
            name: 'notifyPartyId',
            title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.notify.party'/>",
            ...BlTab.Methods.contactOptionDataSource(),
        },
        {
            name: 'consigneeId',
            ...BlTab.Methods.contactOptionDataSource(),
            title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.consignee'/>",
        },
        {
            name: 'portOfLoadingId', ...BlTab.Methods.portOptionDataSource(),
            title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.port.of.landing'/>",
        },
        {
            name: 'portOfDischargeId', ...BlTab.Methods.portOptionDataSource(),
            title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.port.of.discharge'/>",
        },
    ]
}
BlTab.Fields.BillOfLandingWithoutSwitch = _ => {
    const shipmentOptionDataSource = _ => {
        return {
            autoFetchData: false,
            required: true,
            editorType: "SelectItem",
            valueField: "id",
            // displayField: "contractShipment.contract.no",
            pickListWidth: "500",
            pickListHeight: "300",
            optionDataSource: isc.MyRestDataSource.create({
                fields: BlTab.Fields.Shipment(),
                fetchDataURL: "api/shipment/spec-list"
            }),
            optionCriteria: {
                operator: "and",
                criteria: [
                    {fieldName: "remainedBLs", operator: "greaterThan", value: 0}
                ]
            },
            // click: function () {
            // },
            // optionCriteria: currencyInUnitCriteria,
            pickListProperties:
                {
                    showFilterEditor: true
                },
            pickListFields: [
                {
                    name: "contractShipment.contract.no",
                    title: "<spring:message code='contact.code'/>"

                },
                {
                    name: "material.descEN",
                    title: "<spring:message code='material.descEN'/>"
                },
                {
                    name: "material.descFA",
                    title: "<spring:message code='material.descFA'/>"
                },
            ],
            changed(_form, _item, _value) {
                const shipment = _item.getSelectedRecord();
                // dbg(true, arguments)
                if (!shipment) return;
                if (shipment.shipmentTypeId && !_form.getValue('shipmentTypeId'))
                    _form.setValue('shipmentTypeId', shipment.shipmentTypeId)
                if (shipment.shipmentMethodId
                    // && !_form.getValue('shipmentMethodId')
                )
                    _form.setValue('shipmentMethodId', shipment.shipmentTypeId)
                if (shipment.vessel && !_form.getValue('oceanVesselId'))
                    _form.setValue('oceanVesselId', shipment.vessel.id)
                if (shipment.dischargePortId
                    // && !_form.getValue('portOfDischargeId')
                )
                    _form.setValue('portOfDischargeId', shipment.dischargePortId)
                if (shipment.dischargePort
                    // && !_form.getValue('placeOfDelivery')
                )
                    _form.setValue('placeOfDelivery', shipment.dischargePort.port)
                if (shipment.contractShipment
                    // && !_form.getValue('placeOfDelivery')
                )
                    _form.setValue('portOfLoadingId', shipment.contractShipment.loadPortId)

                if (shipment.contractShipment && shipment.contractShipment.contractId)
                    fetch('api/g-contract/' + shipment.contractShipment.contractId, {headers: SalesConfigs.httpHeaders})
                        .then(
                            response => {
                                if (!response.ok) return;
                                response.json().then(
                                    response => {
                                        // dbg(true,response)
                                        if (response.contractContacts) {
                                            const buyer = response.contractContacts.find(cc => cc.commercialRole.toLowerCase() === "Buyer".toLowerCase());
                                            const seller = response.contractContacts.find(cc => cc.commercialRole.toLowerCase() === "seller".toLowerCase());
                                            const agentBuyer = response.contractContacts.find(cc => cc.commercialRole.toLowerCase() === "AgentBuyer".toLowerCase());
                                            if (buyer
                                                // && !_form.getValue("shipperExporterId")
                                            )
                                                _form.setValue('shipperExporterId', seller.contactId)
                                            if (agentBuyer
                                                // && !_form.getValue("consigneeId")
                                            )
                                                _form.setValue('consigneeId', agentBuyer.contactId)
                                            if (seller
                                                // && !_form.getValue("notifyPartyId")
                                            )
                                                _form.setValue('notifyPartyId', buyer.contactId)
                                            if (BlTab.Vars.allReadyValidated)
                                                _form.validate();
                                        }
                                    }
                                )
                            }
                        )
            },
        }
    }
    const shipmentTypeOptionDataSource = _ => {
        return {
            autoFetchData: false,
            required: true,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "shipmentType",
            pickListWidth: "500",
            pickListHeight: "300",
            optionDataSource: isc.MyRestDataSource.create({
                fields: BlTab.Fields.Shipment(),
                fetchDataURL: "api/shipmentType/spec-list"
            }),
            click: function () {
            },
            // optionCriteria: currencyInUnitCriteria,
            pickListProperties:
                {
                    showFilterEditor: true
                },
            pickListFields: [
                {
                    name: "shipmentType",
                    align: "center"
                }
            ],
        }
    }
    const shipmentMethodOptionDataSource = _ => {
        return {
            autoFetchData: false,
            required: true,
            editorType: "SelectItem",
            valueField: "id",
            displayField: "shipmentMethod",
            pickListWidth: "500",
            pickListHeight: "300",
            optionDataSource: isc.MyRestDataSource.create({
                fields: BlTab.Fields.Shipment(),
                fetchDataURL: "api/shipmentMethod/spec-list"
            }),
            click: function () {
            },
            // optionCriteria: currencyInUnitCriteria,
            pickListProperties:
                {
                    showFilterEditor: true
                },
            pickListFields: [
                {
                    name: "shipmentMethod",
                    align: "center"
                }
            ],
        }
    }
    return [
        {name: 'id', hidden: true,},
        {
            name: 'documentNo',
            required: true,
            width: 100,
            title: "<spring:message code='billOfLanding.document.no'/>",
            keyPressFilter: "[0-9/_a-zA-Z\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F-]",
            validateOnChange: true,
            validators: [
                {
                    type: "regexp",
                    expression: "^[0-9/_a-zA-Z\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F-]*$",
                    validateOnChange: true,
                }
            ]
        },
        {
            name: 'shipmentId',
            type: 'long',
            ...shipmentOptionDataSource(),
            title: "<spring:message code='Shipment.title'/>",
            width: 130,
            formatCellValue: function (value, record, rowNum, colNum, grid) {
                if (record.shipment && record.shipment.vessel)
                    return "(" + moment(record.shipment.sendDate).format('YYYY/MM/DD') + ") " + record.shipment.contractShipment.contract.no;
                return value
            },
        },
        {
            name: 'shipperExporter',
            hidden: true,
            title: "<spring:message code='billOfLanding.shipper.exporter'/>",
        },
        {
            name: 'shipperExporterId',
            validateOnChange: true,
            type: 'long',
            width: 250,
            required: true,
            ...BlTab.Methods.contactOptionDataSource(),
            title: "<spring:message code='billOfLanding.shipper.exporter'/>",
        },
        {
            name: 'notifyParty', hidden: true,
            title: "<spring:message code='billOfLanding.notify.party'/>",
        },
        {
            name: 'notifyPartyId',
            validateOnChange: true,
            width: 250,
            required: true,
            type: 'long',
            title: "<spring:message code='billOfLanding.notify.party'/>",
            ...BlTab.Methods.contactOptionDataSource(),
        },
        {
            name: 'consignee', hidden: true,
            title: "<spring:message code='billOfLanding.consignee'/>",
        },
        {
            name: 'consigneeId',
            validateOnChange: true,
            type: 'long',
            width: 250,
            required: true,
            showIf: "false",
            ...BlTab.Methods.contactOptionDataSource(),
            title: "<spring:message code='billOfLanding.consignee'/>",
        },
        {
            name: 'portOfLoading', hidden: true,
            title: "<spring:message code='billOfLanding.port.of.landing'/>",

        },
        {
            name: 'portOfLoadingId',
            validateOnChange: true,
            type: 'long',
            width: 90,
            required: true,
            ...BlTab.Methods.portOptionDataSource(),
            title: "<spring:message code='billOfLanding.port.of.landing'/>",
        },
        {
            name: 'portOfDischarge', hidden: true,
            title: "<spring:message code='billOfLanding.port.of.discharge'/>",
        },
        {
            name: 'portOfDischargeId',
            validateOnChange: true,
            type: 'long',
            width: 90,
            required: true,
            ...BlTab.Methods.portOptionDataSource(),
            title: "<spring:message code='billOfLanding.port.of.discharge'/>",
        },
        {
            name: "shipmentTypeId",
            validateOnChange: true,
            type: 'long',
            width: 70,
            title: "<spring:message code='shipment.type'/>",
            ...shipmentTypeOptionDataSource(),
            formatCellValue: function (value, record, rowNum, colNum, grid) {
                if (record.shipmentType)
                    return record.shipmentType.shipmentType
                return value
            }

        },
        {
            name: "shipmentMethodId",
            type: 'long',
            width: 70,
            validateOnChange: true,
            ...shipmentMethodOptionDataSource(),
            title: "<spring:message code='shipment.method'/>",
            formatCellValue: function (value, record, rowNum, colNum, grid) {
                if (record.shipmentMethod)
                    return record.shipmentMethod.shipmentMethod
                return value
            }
        },
        {
            name: 'placeOfDelivery', required: true,
            type: 'text',
            width: 100,
            title: "<spring:message code='billOfLanding.place.of.delivery'/>",
            validateOnChange: true,
        },
        {
            name: 'oceanVessel', hidden: true, shouldSaveValue: false,
            title: "<spring:message code='billOfLanding.ocean.vessel'/>",
            validateOnChange: true,
        },
        {
            name: 'oceanVesselId',
            required: true,
            width: 110,
            autoFetchData: false,
            editorType: "SelectItem",
            type: 'long',
            valueField: "id",
            displayField: "name",
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
            validateOnChange: true,
            title: "<spring:message code='billOfLanding.ocean.vessel'/>",
        },
        {
            name: 'totalNet',
            type: 'long',
            width: 90,
            keyPressFilter: "[0-9]",
            title: "<spring:message code='billOfLanding.total.net.weight'/>",
            validateOnChange: true,
        },
        {
            name: 'totalGross',
            type: 'long',
            width: 90,
            keyPressFilter: "[0-9]",
            title: "<spring:message code='billOfLanding.total.gross.weight'/>",
            validateOnChange: true,
        },
        {
            name: 'totalBundles',
            type: 'long',
            width: 70,
            validateOnChange: true,
            keyPressFilter: "[0-9]",
            title: "<spring:message code='billOfLanding.total.bundles'/>",
        },
        {
            name: 'numberOfBlCopies', required: true,
            type: 'long',
            showIf: "false",
            width: 60,
            validateOnChange: true,
            title: "<spring:message code='billOfLanding.copies.of.bl'/>",
            keyPressFilter: "[0-9]",
        },
        {
            name: 'dateOfIssue', type: "date",
            width: 80,
            title: "<spring:message code='billOfLanding.date.of.issue'/>",
        },
        {
            name: 'placeOfIssue', required: true,
            type: 'text',
            width: 100,
            validateOnChange: true,
            title: "<spring:message code='billOfLanding.place.of.issue'/>",
        },
        {
            name: 'description',
            colSpan: 6,
            type: 'text',
            //width: 180,
            editorType: "textArea",
            title: "<spring:message code='global.description'/>",
        },

    ]
}
BlTab.Fields.BillOfLanding = _ => [
    ...BlTab.Fields.BillOfLandingWithoutSwitch(),
    {
        name: 'billOfLadingSwitch.documentNo',
        type: 'text',
        showIf: "true",
        width: 100,
        title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.document.no'/>",
    },
    {
        name: 'billOfLadingSwitch.shipperExporterId',
        type: 'long',
        width: 250,
        showIf: "false",
        ...BlTab.Methods.contactOptionDataSource(),
        title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.shipper.exporter'/>",

    },
    {
        name: 'billOfLadingSwitch.notifyPartyId',
        type: 'long',
        width: 250,
        showIf: "false",
        title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.notify.party'/>",
        ...BlTab.Methods.contactOptionDataSource(),
    },
    {
        name: 'billOfLadingSwitch.consigneeId',
        type: 'long',
        width: 250,
        showIf: "false",
        ...BlTab.Methods.contactOptionDataSource(),
        title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.consignee'/>",
    },
    {
        name: 'billOfLadingSwitch.portOfLoadingId', ...BlTab.Methods.portOptionDataSource(),
        type: 'long',
        width: 90,
        showIf: "false",
        title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.port.of.landing'/>",
    },
    {
        name: 'billOfLadingSwitch.portOfDischargeId', ...BlTab.Methods.portOptionDataSource(),
        type: 'long',
        width: 90,
        showIf: "false",
        title: "<spring:message code='billOfLanding.switch'/> - <spring:message code='billOfLanding.port.of.discharge'/>",
    },

]
BlTab.Fields.ContainerToBillOfLanding = _ => [
    {name: 'id', hidden: true,},
    // {name: 'billOfLanding',hidden: true},
    {name: 'billOfLandingId', required: true, hidden: true},
    {
        name: 'containerType', required: true,
        title: "<spring:message code='billOfLanding.container.type'/>",
    },
    {
        name: 'containerNo', required: true,
        title: "<spring:message code='billOfLanding.container.no'/>",
        summaryFunction: "count",

    },
    {
        name: 'sealNo', required: true,
        title: "<spring:message code='billOfLanding.seal.no'/>",
    },
    {
        name: 'quantity', required: true,
        type: "number",
        keyPressFilter: "[0-9]",
        title: "<spring:message code='global.quantity'/>",
        summaryFunction: "sum",
    },
    {
        required: true,
        name: 'quantityType',
        title: "<spring:message code='billOfLanding.quantity.type'/>",
    },
    {
        name: 'weight', required: false,
        type: "number",
        keyPressFilter: "[0-9]",
        title: "<spring:message code='Tozin.vazn'/>",
        summaryFunction: "sum",

    },
    {
        name: 'unit', hidden: true, required: true,
        title: "<spring:message code='global.unit'/>",
    },
    {
        name: 'unitId', required: true,
        displayField: 'nameEN',
        valueField: "id",
        title: "<spring:message code='global.unit'/>",
        type: "long",
        optionDataSource: isc.MyRestDataSource.create({
            fields:
                [
                    {name: "nameFA", title: "<spring:message code='unit.nameFa'/> "},
                    {name: "nameEN", title: "<spring:message code='unit.nameEN'/> "},
                    {name: "symbol", title: "<spring:message code='unit.symbol'/>"},
                ],
            fetchDataURL: "api/unit/spec-list"
        }),
        optionCriteria: {
            _constructor: "AdvancedCriteria", operator: "or",
            criteria: [{
                fieldName: "categoryUnit",
                operator: "equals",
                value: JSON.parse('${Enum_CategoryUnit}').Weight
            }]
        },
        pickListFields: [
            {name: "nameFA", title: "<spring:message code='unit.nameFa'/> "},
            {name: "nameEN", title: "<spring:message code='unit.nameEN'/> "},
        ],
    },
]
////////////////////////////////////////////////////////DATASOURCE//////////////////////////////////////////////////////
BlTab.RestDataSources.Vessel = {
    fields: BlTab.Fields.Vessel(),
    fetchDataURL: "api/vessel/spec-list"
}
BlTab.RestDataSources.shipment = {
    fields: BlTab.Fields.Shipment(),
    fetchDataURL: "api/shipment/spec-list"
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
    fields: BlTab.Fields.BillOfLanding().map(_ => {
        delete _.required;
        return _;
    }),
    fetchDataURL: "api/bill-of-landing/spec-list"
}
////////////////////////////////////////////////////////GRIDS///////////////////////////////////////////////////////////
BlTab.Vars.IButton_Container_Save = isc.IButtonSave.create({
    click: function () {
        if (!BlTab.DynamicForms.Forms.ContainerToBillOfLanding.validate()) return;
        BlTab.Methods.Save({
                ...BlTab.DynamicForms.Forms.ContainerToBillOfLanding.getValues(),
                billOfLandingId: BlTab.Grids.BillOfLanding.obj.getSelectedRecord().id
            },
            'api/container-to-bill-of-landing',
            _ => {
                BlTab.Layouts.Window.ContainerToBillOfLanding.close();
                BlTab.DynamicForms.Forms.ContainerToBillOfLanding.clearValues();
                BlTab.Grids.ContainerToBillOfLanding.invalidateCache();
                BlTab.Methods.RefreshContainerData(BlTab.Grids.BillOfLanding.obj, BlTab.Grids.BillOfLanding.obj.getSelectedRecord().id, BlTab.Grids.ContainerToBillOfLanding);
            }
        )
    }
});

BlTab.Vars.IButton_BillOfLading_Save = isc.IButtonSave.create({
    click: function () {
        if (!BlTab.DynamicForms.Forms.BillOfLandingMain.validate()) {
            BlTab.Layouts.BillOfLandingFormTab.selectTab(0);
            BlTab.Vars.allReadyValidated = true;
            return;
        }
        if (!BlTab.Methods.validateEqualsFields(BlTab.DynamicForms.Forms.BillOfLandingMain.getValues())) {
            BlTab.Layouts.BillOfLandingFormTab.selectTab(0);
            return;
        }
        if (!BlTab.Methods.validateEqualsFields(BlTab.DynamicForms.Forms.BillOfLandingSwitch.getValues())) {
            BlTab.Layouts.BillOfLandingFormTab.selectTab(1);
            return;
        }
        if (BlTab.DynamicForms.Forms.BillOfLandingSwitch.getValues() && Object.keys(BlTab.DynamicForms.Forms.BillOfLandingSwitch.getValues()).length != 0)
            BlTab.DynamicForms.Forms.BillOfLandingMain.setValue("billOfLadingSwitch", BlTab.DynamicForms.Forms.BillOfLandingSwitch.getValues());
        BlTab.Methods.Save({
                ...BlTab.DynamicForms.Forms.BillOfLandingMain.getValues()
            },
            'api/bill-of-landing',
            _ => {
                BlTab.Layouts.Window.BillOfLandingMain.close();
                BlTab.DynamicForms.Forms.BillOfLandingMain.clearValues();
                BlTab.Grids.BillOfLanding.obj.invalidateCache();
            }
        )
    }
});


BlTab.Layouts.Window.ContainerToBillOfLanding = isc.Window.create({
    title: "<spring:message code='shipment.inquiry.container'/>",
    autoSize: true,
    autoCenter: true,
    isModal: true,
    showModalMask: true,
    align: "center",
    autoDraw: false,
    dismissOnEscape: true,
    items: [
        BlTab.DynamicForms.Forms.ContainerToBillOfLanding = isc.DynamicForm.create({
            margin: 25,
            errorOrientation: "bottom",
            cellPadding: "12",
            wrapItemTitles: false,
            numCols: 4,
            itemChanged: function (_item, _newValue) {
            },
            fields: BlTab.Fields.ContainerToBillOfLanding(),
        }),

        isc.HLayout.create({
            height: "100%",
            layoutMargin: 10,
            membersMargin: 5,
            members: [
                BlTab.Vars.IButton_Container_Save,
                isc.IButtonCancel.create({
                    click: function () {
                        BlTab.Layouts.Window.ContainerToBillOfLanding.close();
                    }
                })]
        })
    ]
})

BlTab.Layouts.Window.BillOfLandingMain = isc.Window.create({
    title: "<spring:message code='billOfLanding'/>",
    autoSize: true,
    autoCenter: true,
    isModal: true,
    showModalMask: true,
    align: "center",
    autoDraw: false,
    dismissOnEscape: true,
    width: "75%",
    items: [
        BlTab.Layouts.BillOfLandingFormTab = isc.TabSet.create({
            autoDraw: true,
            showEdges: false,
            edgeMarginSize: 3,
            tabBarThickness: 100,
            tabBarPosition: nicico.CommonUtil.getAlignByLangReverse(),
            height: .55 * innerHeight,
            width: "100%",
            tabs: [
                {
                    title: "<spring:message code='billOfLanding.main'/>",
                    pane: BlTab.DynamicForms.Forms.BillOfLandingMain = isc.DynamicForm.create({
                        numCols: 6,
                        cellPadding: "10",
                        wrapItemTitles: false,
                        errorOrientation: "bottom",
                        overflow: "hidden",
                        margin: "20",
                        fields: BlTab.Fields.BillOfLandingWithoutSwitch().map(_ => {
                            delete _.width;
                            delete _.showIf;
                            if (_.name === 'description') {
                                _.width = 0.568 * innerWidth;
                            }
                            if (_.name === 'shipmentId') {
                                _.mapValueToDisplay =  function (value) {
                                    let record = this.getSelectedRecord();
                                    if (!record) return '';
                                    return "(" + moment(record.sendDate).format('YYYY/MM/DD') + ") " + record.contractShipment.contract.no;
                                }
                            }
                            return _;
                        }),
                    })
                },
                {
                    title: "<spring:message code='billOfLanding.switch'/>",
                    pane: BlTab.DynamicForms.Forms.BillOfLandingSwitch = isc.DynamicForm.create({
                        numCols: 6,
                        cellPadding: "11",
                        margin: "20",
                        wrapItemTitles: false,
                        fields: BlTab.Fields.BillOfLandingSwitch()
                    })
                }
            ]
        }),

        isc.HLayout.create({
            height: "100%",
            layoutMargin: 10,
            membersMargin: 5,
            members: [
                BlTab.Vars.IButton_BillOfLading_Save,
                isc.IButtonCancel.create({
                    click: function () {
                        BlTab.Layouts.Window.BillOfLandingMain.close();
                    }
                }),
            ]
        })
    ]
});

BlTab.Grids.BillOfLanding = {
    height: "100%",
    recordDoubleClick(viewer, record, recordNum, field, fieldNum, value, rawValue) {
        // <sec:authorize access="hasAuthority('U_BILL_OF_LANDING')">
        if (!record) return BlTab.Dialog.NotSelected();
        BlTab.Layouts.ToolStripButtons.new.click();
        BlTab.Vars.Method = "PUT";
        BlTab.Vars.allReadyValidated = false;
        BlTab.DynamicForms.Forms.BillOfLandingMain.clearValues();
        BlTab.DynamicForms.Forms.BillOfLandingMain.editRecord(record);
        BlTab.DynamicForms.Forms.BillOfLandingSwitch.clearValues();
        BlTab.DynamicForms.Forms.BillOfLandingSwitch.editRecord(record.billOfLadingSwitch);
        // </sec:authorize>
    },
    autoFitWidth: true,
    autoFetchData: true,
    showFilterEditor: true,
    dataSource: {...BlTab.RestDataSources.BillOfLanding},
    expansionFieldImageShowSelected: true,
    canExpandRecords: true,
    canExpandMultipleRecords: false,
    // <sec:authorize access="hasAuthority('R_CONTAINER_TO_BILL_OF_LANDING')">
    getExpansionComponent: function (record, rowNum, colNum) {
        // gridComponents
        BlTab.Grids.ContainerToBillOfLanding = isc.ListGrid.create({
            height: 300,
            data: record.containers,
            showGridSummary: true,
            doubleClick() {
                const selectedRecord = BlTab.Grids.ContainerToBillOfLanding.getSelectedRecord();
                if (!selectedRecord) return BlTab.Dialog.NotSelected();
                BlTab.Layouts.ToolStripButtons.NewContainerToBillOfLanding.click();
                BlTab.Vars.Method = "PUT";
                BlTab.DynamicForms.Forms.ContainerToBillOfLanding.clearValues();
                BlTab.DynamicForms.Forms.ContainerToBillOfLanding.editRecord(selectedRecord);
            },
            gridComponents: [isc.ToolStrip.create({
                members: [
                    // <sec:authorize access="hasAuthority('C_CONTAINER_TO_BILL_OF_LANDING')">
                    BlTab.Layouts.ToolStripButtons.NewContainerToBillOfLanding = isc.ToolStripButton.create({
                        click() {
                            BlTab.Vars.Method = "POST";
                            BlTab.DynamicForms.Forms.ContainerToBillOfLanding.clearValues();
                            BlTab.Layouts.Window.ContainerToBillOfLanding.show();
                        },
                        title: '<spring:message code="billOfLanding.container.add"/>',
                        icon: "[SKIN]/actions/plus.png",
                    }),
                    // </sec:authorize>
                    // <sec:authorize access="hasAuthority('U_CONTAINER_TO_BILL_OF_LANDING')">
                    isc.ToolStripButton.create({
                        click() {
                            const selectedRecord = BlTab.Grids.ContainerToBillOfLanding.getSelectedRecord();
                            if (!selectedRecord) return BlTab.Dialog.NotSelected();
                            BlTab.Layouts.ToolStripButtons.NewContainerToBillOfLanding.click();
                            BlTab.Vars.Method = "PUT";
                            BlTab.DynamicForms.Forms.ContainerToBillOfLanding.setValues(selectedRecord);
                        },
                        title: '<spring:message code="billOfLanding.container.edit"/>',
                        icon: "[SKIN]/actions/column_preferences.png",
                    }),
                    // </sec:authorize>
                    // <sec:authorize access="hasAuthority('D_CONTAINER_TO_BILL_OF_LANDING')">
                    isc.ToolStripButton.create({
                        click() {
                            //BlTab.Grids.BillOfLanding.obj.invalidateCache()
                            BlTab.Methods.Delete(BlTab.Grids.ContainerToBillOfLanding,
                                SalesConfigs.Urls.completeUrl + '/api/container-to-bill-of-landing',
                                _ => BlTab.Methods.RefreshContainerData(BlTab.Grids.BillOfLanding.obj, BlTab.Grids.BillOfLanding.obj.getSelectedRecord().id, BlTab.Grids.ContainerToBillOfLanding))
                        },
                        title: '<spring:message code="billOfLanding.container.remove"/>',
                        icon: "[SKIN]/headerIcons/trash_Over.png",
                    }),
                    // </sec:authorize>
                ]
            }), "filterEditor", "header",
                "body", "summaryRow"],
            fields: BlTab.Fields.ContainerToBillOfLanding()
        });
        return BlTab.Grids.ContainerToBillOfLanding;
    },
    // </sec:authorize>
    showHover: true,
    //rotateHeaderTitles: true,
    autoFitHeaderHeights: true,
    wrapHeaderTitles: true,
    canHover: true,

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
        BlTab.Methods.Delete(BlTab.Grids.BillOfLanding.obj, SalesConfigs.Urls.completeUrl + '/api/bill-of-landing/',
            _ => BlTab.Grids.BillOfLanding.obj.invalidateCache())
    }
}
BlTab.Layouts.ToolStripButtons.FileUpload = {
    ...BlTab.Layouts.ToolStripButtons.fileUpload,
    click() {
        let record = BlTab.Grids.BillOfLanding.obj.getSelectedRecord();
        if (record == null || record.id == null)
            BlTab.Dialog.NotSelected();

        nicico.FileUtil.show(null, '<spring:message code="global.attach.file"/> <spring:message code="entity.bill-of-landing"/>', record.id, null, "BillOfLanding", null);

    }
}
BlTab.Layouts.ToolStripButtons.EditContainerToBillOfLanding = {...BlTab.Layouts.ToolStripButtons.edit}
BlTab.Layouts.ToolStripButtons.EditBillOfLanding.click = _ => {
    BlTab.Grids.BillOfLanding.recordDoubleClick(BlTab.Grids.BillOfLanding, BlTab.Grids.BillOfLanding.obj.getSelectedRecord())
}
BlTab.Layouts.ToolStripButtons.new.click = _ => {
    BlTab.Vars.Method = "POST";
    BlTab.Vars.allReadyValidated = false;
    BlTab.DynamicForms.Forms.BillOfLandingMain.clearValues();
    BlTab.DynamicForms.Forms.BillOfLandingSwitch.clearValues();
    BlTab.Layouts.Window.BillOfLandingMain.show();
}
BlTab.Layouts.ToolStripButtons.edit.click = BlTab.Layouts.ToolStripButtons.EditBillOfLanding.click
BlTab.Layouts.ToolStripButtons.remove.click = BlTab.Layouts.ToolStripButtons.RemoveBillOfLanding.click
BlTab.Layouts.ToolStripButtons.fileUpload.click = BlTab.Layouts.ToolStripButtons.FileUpload.click
BlTab.Layouts.ToolStripButtons.refresh.click = BlTab.Layouts.ToolStripButtons.RefreshBillOfLanding.click
BlTab.Layouts.ToolStrips.BillOfLanding = BlTab.Layouts.ToolStrips.CreateMainToolStrip();
BlTab.Layouts.Vlayouts.MainVLayOut = BlTab.Layouts.Vlayouts.CreateMainVlayOut([
    BlTab.Layouts.ToolStrips.BillOfLanding,
    BlTab.Grids.BillOfLanding.obj = isc.ListGrid.create({
        ...BlTab.Grids.BillOfLanding,
        dataSource: isc.MyRestDataSource.create({...BlTab.Grids.BillOfLanding.dataSource}),
    })
])
////////////////////////////////////////////////////////WINDOWS/////////////////////////////////////////////////////////
