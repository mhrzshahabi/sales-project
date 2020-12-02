//******************************************************* VARIABLES ****************************************************

var packingListTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();

packingListTab.variable.packingListUrl = "${contextPath}" + "/api/packing-list/";
packingListTab.variable.packingContainerUrl = "${contextPath}" + "/api/packing-container/";
packingListTab.variable.billOfLandingUrl = "${contextPath}" + "/api/bill-of-landing/";
packingListTab.variable.shipmentUrl = "${contextPath}" + "/api/shipment/";
/**@type {object.<string,Partial<ListGrid> | ListGrid>|any} packingListTab.Grids***/
packingListTab.Grids = {};
packingListTab.Forms = {};
/**@type {object.<string,Partial<isc.Window> | isc.Window>|any} packingListTab.Grids***/
packingListTab.Windows = {};

packingListTab.Fields= {
    /**@return {Array<isc.ListGridField|isc.FormItem>}**/
    packingContainer(){return [
        {name: "id", editorProperties:{validateOnExit:true,}, type:"number", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "containerNo", summaryFunction:"count", editorProperties:{validateOnExit:true,}, type:"text", showHover: true,
            title: "<spring:message code ='warehouseCad.containerNo'/>"},
        {name: "sealNo", editorProperties:{validateOnExit:true,}, type:"text", showHover: true, title: "<spring:message code ='billOfLanding.seal.no'/>"},
        {name: "ladingDate", editorProperties:{validateOnExit:true,}, type:"number", showHover: true,
            title: "<spring:message code ='global.date'/> <spring:message code ='vesselAssignment.title'/>"},
        {name: "packageCount", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number", showHover: true,
            title: "<spring:message code ='Tozin.tedad.packages'/>"},
        {
            name: "subpackageCount", type:"number",

            showHover: true,
            editorProperties:{validateOnExit:true,},
            title: "<spring:message code ='Tozin.tedad.packages'/>"
        },
        {name: "strapWeight", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float", showHover: true, title: "<spring:message code='packing-container.strapWeight'/>"},
        {name: "palletCount", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number", showHover: true, title: "<spring:message code='packing-container.palletCount'/>"},
        {name: "palletWeight", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float", showHover: true, title: "<spring:message code='packing-container.palletWeight'/>"},
        {name: "woodWeight", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float", showHover: true, title: "<spring:message code='packing-container.woodWeight'/>"},
        {name: "barrelWeight", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float", showHover: true, title: "<spring:message code='packing-container.barrelWeight'/>"},
        {name: "containerWeight", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number",required:true, showHover: true, title: "<spring:message code='packing-container.containerWeight'/>"},
        {name: "contentWeight", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number",required:true, showHover: true, title: "<spring:message code='packing-container.contentWeight'/>"},
        {name: "vgmWeight", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"number", showHover: true, title: "<spring:message code='packing-container.vgmWeight'/>"},
        {name: "netWeight", summaryFunction:"sum", editorProperties:{validateOnExit:true,}, type:"float",required:true, showHover: true, title: "<spring:message code='packing-container.netWeight'/>"},
        {name: "description", editorProperties:{validateOnExit:true,},type:"text", showHover: true, title: "<spring:message code='packing-container.description'/>"},
    ];}
};
packingListTab.Vars=  {
    Debug: false,
    Prefix: "packingList_detail_tab" + Math.random().toString().substr(-6),
    Url: SalesConfigs.Urls.packingListRest,
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
};
packingListTab.Methods= {
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
                        result[key] = packingListTab.Methods.concatObjectsByKey(isBoolOperatorAnd, first[key], second[key]);
                    else console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                } else
                    result[key] = second[key];
            }

            return result;
        }, {});
    },
    FetchSpecListData: function (usePageStrategy, props, responseCallBack) {

        packingListTab.method.jsonRPCManagerRequest(props, (response) => {

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

            packingListTab.method.fetchSpecListData(usePageStrategy, currentProps, (response2) => {

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
        for (let grid in packingListTab.Grids) {
            try {
                let iscGrid = window[packingListTab.Grids[grid].ID];
                if (typeof (iscGrid) === "object") {
                    iscGrid.invalidateCache();
                    // iscGrid.deselectAllRecords();
                }
            } catch (e) {
                console.log(e);
            }

        }
        for (let form in packingListTab.DynamicForms.Forms) {
            let f = window[packingListTab.DynamicForms.Forms[form]["ID"]];

            try {
                f.clearValues();
            } catch (e) {
                console.log(e);
            }
        }
        for (let windows in packingListTab.Layouts.Window) {
            let w = window[packingListTab.Layouts.Window[windows]["ID"]];

            try {
                w.hide();
            } catch (e) {
                console.log(e);
            }
        }
    },
    Required: function () {
        return !packingListTab.Vars.debug
    },
    CrudDynamicForm: function (props) {
        packingListTab.Logs.add(['props:', props]);
        if (typeof (props) === "undefined") return;
        let url = packingListTab.Vars.Url;
        let method = packingListTab.Vars.Method;
        let httpHeaders = SalesConfigs.httpHeaders;
        let params = "";
        let data = "";
        let callBack = "";
        let defaultResponse = function (response) {
            packingListTab.Logs.add(["return status:", response]);
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
                //     packingListTab.Logs.add(["fetch error:", error]);
                //     // MyRPCManager.handleError({httpResponseText: error});
                //     isc.warn("<spring:message code='Tozin.error.message '/>:\n" + JSON.stringify(error));
                // });
                return;
            }

            if (response.status === 200 || response.status === 201) response.text().then(resp => {
                packingListTab.Dialog.Success();
                packingListTab.Grids.packingList.obj.invalidateCache();
            });
            else {
                response.text().then(error => {
                    packingListTab.Logs.add(["fetch error:", error]);
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
        packingListTab.Logs.add(['data to send rpc', data]);
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
            packingListTab.Logs.add(["fetch finally: ", packingListTab.Vars.Method]);

            packingListTab.Methods.RefreshAll();
        });
    },
    DynamicFormRefresh: (method = "POST", form) => {
        packingListTab.Vars.Method = method;
        form = window[form.ID];
        form.clearValues();
    },
    NewForm: function (iscWindow, form) {
        const win = window[iscWindow.ID];
        packingListTab.Methods.DynamicFormRefresh("POST", form);
        win.show();
    },
    Save: function (data, url, callBack) {
        packingListTab.Methods.CrudDynamicForm({
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
                packingListTab.Vars.Method = "PUT";
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
                            // let urlD = packingListTab.Vars.Url + "pattern/list";
                            // if (typeof (deleteUrl) === "string") urlD = deleteUrl;
                            packingListTab.Methods.CrudDynamicForm({
                                data: data,
                                url: deleteUrl,
                                method: "DELETE",
                                params: params,
                            });
                        } else {

                        }

                        // packingListTab.log.add(ids);

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
                        click: () => {
                            saveClickFunc();
                        }
                    }),
                    isc.IButtonCancel.create({
                        click: function () {
                            try {
                                let wind = windowToCloseIs();
                                //console.log("windowToClose:",wind);
                                wind.closeClick();
                                packingListTab.Methods.RefreshAll();
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
};
/**@param{string} paste**/
packingListTab.Methods.PasteTextToPackingContainerGrid=function (paste){
    packingListTab.Grids.PasteFromExcelPackingContainer.setData([]);
    const _rows = paste.split("\n");
    const fields = _rows.reverse().pop().split("\t");
    paste = _rows.reverse().join("\n");
    const __recordsFromText = isc.DataSource.create({
        fields:packingListTab.Fields.packingContainer()
    }).recordsFromText(paste,{
        fieldList: packingListTab.Fields.packingContainer().map(/***@param {isc.ListGridField} field**/
        field=>field.name),
        fieldList: fields,
        fieldSeparator: "\t",
        escapingMode: "double"
    });
    dbg(__recordsFromText)
    const _fields = packingListTab.Fields.packingContainer().map(field=>{
        if (!fields.includes(field.name))field.hidden=true;
        return field;
    })
    packingListTab.Grids.PasteFromExcelPackingContainer.setFields(_fields);
    packingListTab.Grids.PasteFromExcelPackingContainer.setData(__recordsFromText);

    Array.from(Array(__recordsFromText.length)).forEach((_,__)=>{
        packingListTab.Grids.PasteFromExcelPackingContainer.validateRow(__);
    })
};
//***************************************************** RESTDATASOURCE *************************************************

packingListTab.restDataSource.packingListRest = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "bookingNo", type: 'text', showHover: true, title: "<spring:message code='packing-list.bookingNo'/>"},
        {
            name: "shipment.automationLetterDate",canFilter:false,
            title: "<spring:message code='shipment.bDate'/>",
            formatCellValue(value, record, rowNum, colNum) {
                return new persianDate(value).format('YYYYMMDD')},
        },
        {
            name: "shipment.automationLetterNo",
            title: "<spring:message code='shipment.loadingLetter'/>",
            type: 'text',
        },
        {name: "shipment.contractShipment.contract.no",title:"<spring:message code='contact.no'/>"},
        {name: "shipment.material.descFA",title:"<spring:message code='goods.title'/>"},
        {
            name: "description",
            type: 'text',
            showHover: true,
            title: "<spring:message code='packing-list.description'/>"
        },
    ],
    fetchDataURL: packingListTab.variable.packingListUrl + "spec-list"
});
packingListTab.restDataSource.packingContainer = isc.MyRestDataSource.create({
    fields: [
        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "containerNo", showHover: true, title: "<spring:message code ='packing-container.containerNo'/>"},
        {name: "sealNo", showHover: true, title: "<spring:message code ='packing-container.sealNo'/>"},
        {name: "ladingDate", showHover: true, title: "<spring:message code ='packing-container.ladingDate'/>"},
        {name: "packageCount", showHover: true, title: "<spring:message code ='packing-container.packageCount'/>"},
        {
            name: "subpackageCount",
            showHover: true,
            title: "<spring:message code ='packing-container.subpackageCount'/>"
        },
        {name: "strapWeight", showHover: true, title: "<spring:message code='packing-container.strapWeight'/>"},
        {name: "palletCount", showHover: true, title: "<spring:message code='packing-container.palletCount'/>"},
        {name: "palletWeight", showHover: true, title: "<spring:message code='packing-container.palletWeight'/>"},
        {name: "woodWeight", showHover: true, title: "<spring:message code='packing-container.woodWeight'/>"},
        {name: "barrelWeight", showHover: true, title: "<spring:message code='packing-container.barrelWeight'/>"},
        {name: "containerWeight", showHover: true, title: "<spring:message code='packing-container.containerWeight'/>"},
        {name: "contentWeight", showHover: true, title: "<spring:message code='packing-container.contentWeight'/>"},
        {name: "vgmWeight", showHover: true, title: "<spring:message code='packing-container.vgmWeight'/>"},
        {name: "netWeight", showHover: true, title: "<spring:message code='packing-container.netWeight'/>"},
        {name: "description", showHover: true, title: "<spring:message code='packing-container.description'/>"},
    ],
    fetchDataURL: packingListTab.variable.packingContainerUrl + "spec-list"
});
packingListTab.restDataSource.shipmentRest = isc.MyRestDataSource.create({
    fields: [
        {name: "id", primaryKey: true, hidden: true},
        {
            name: "automationLetterDate",canFilter:false,
            title: "<spring:message code='shipment.bDate'/>",
            formatCellValue(value, record, rowNum, colNum) {return new persianDate(value).format('YYYYMMDD')},
        },
        {
            name: "automationLetterNo",
            title: "<spring:message code='shipment.loadingLetter'/>",
            type: 'text',
        },
        {name: "contractShipment.contract.no"},
        {name: "material.descFA"}
    ],
    fetchDataURL: packingListTab.variable.shipmentUrl + "spec-list"
});

//***************************************************** MAINWINDOW *************************************************

packingListTab.dynamicForm.fields = BaseFormItems.concat([
    {
        name: "id",
        hidden: true
    },
    {
        name: "shipmentId",
        title: "<spring:message code='shipment.loadingLetter'/>",
        type: 'long',
        required: true,
        wrapTitle: false,
        editorType: "SelectItem",
        valueField: "id",
        displayField: "automationLetterNo",
        pickListWidth: 600,
        pickListHeight: 300,
        optionDataSource: packingListTab.restDataSource.shipmentRest,
        pickListProperties: {
            showFilterEditor: true
        },
        pickListFields: [
            {name: "id", primaryKey: true, hidden: true},
            {
                name: "automationLetterDate",canFilter:false,
                title: "<spring:message code='shipment.bDate'/>",
                formatCellValue(value, record, rowNum, colNum) { if(!value)return null;return new persianDate(value).format('YYYYMMDD')},
            },
            {
                name: "automationLetterNo",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
            },
            {name: "contractShipment.contract.no",title:"<spring:message code='contact.no'/>"},
            {name: "material.descFA",title:"<spring:message code='goods.title'/>"}
        ],
    },
    {
        name: "bookingNo",
        title: "<spring:message code='packing-list.bookingNo'/>",
        required: true,
        type: 'text',
        wrapTitle: false,
        validators: [
            {
                type: "required",
                validateOnChange: true
            }]
    },
    {
        name: "description",
        title: "<spring:message code='packing-list.description'/>",
        width: "100%",
        colSpan: 4,
        type: "textArea",
        wrapTitle: false
    }

]);
packingListTab.dynamicForm.packingList = isc.DynamicForm.create({
    align: "center",
    numCols: 4,
    height:"100%",
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: packingListTab.dynamicForm.fields
});

packingListTab.dynamicForm.packingContainerFields = BaseFormItems.concat([
    {
        name: "id",
        hidden: true
    },
    {
        name: "packingListId",
        required: true,
        hidden: true
    },
    {
        name: "containerNo",
        title: "<spring:message code='packing-container.containerNo'/>",
        required: true,
        hint:'<spring:message code="packing-container.write.ship.name.is.bulk"/>',
        wrapTitle: false
    },
    {
        name: "sealNo",
        title: "<spring:message code='packing-container.sealNo'/>",
        wrapTitle: false
    },
    {
        name: "ladingDate",
        title: "<spring:message code='packing-container.ladingDate'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "packageCount",
        title: "<spring:message code='packing-container.packageCount'/>",
        defaultValue:1,
        wrapTitle: false
    },
    {
        name: "subpackageCount",
        title: "<spring:message code='packing-container.subpackageCount'/>",
        wrapTitle: false
    },
    {
        name: "strapWeight",
        title: "<spring:message code='packing-container.strapWeight'/>",
        wrapTitle: false
    },
    {
        name: "palletCount",
        title: "<spring:message code='packing-container.palletCount'/>",
        wrapTitle: false
    },
    {
        name: "palletWeight",
        title: "<spring:message code='packing-container.palletWeight'/>",
        wrapTitle: false
    },
    {
        name: "woodWeight",
        title: "<spring:message code='packing-container.woodWeight'/>",
        wrapTitle: false
    },
    {
        name: "barrelWeight",
        title: "<spring:message code='packing-container.barrelWeight'/>",
        wrapTitle: false
    },
    {
        name: "containerWeight",
        title: "<spring:message code='packing-container.containerWeight'/>",
        wrapTitle: false
    },
    {
        name: "contentWeight",
        title: "<spring:message code='packing-container.contentWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "vgmWeight",
        title: "<spring:message code='packing-container.vgmWeight'/>",
        wrapTitle: false
    },
    {
        name: "netWeight",
        title: "<spring:message code='packing-container.netWeight'/>",
        required: true,
        wrapTitle: false
    },
    {
        name: "description",
        title: "<spring:message code='packing-container.description'/>",
        width: "100%",
        colSpan: 4,
        type: "textArea",
        wrapTitle: false
    }
]);
packingListTab.dynamicForm.packingContainer = isc.DynamicForm.create({
    align: "center",
    numCols: 4,
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    errorOrientation: "bottom",
    requiredMessage: '<spring:message code="validator.field.is.required"/>',
    fields: packingListTab.dynamicForm.packingContainerFields
});
/**@type {Partial<isc.ToolStripButton>} packingListTab.toolStrip.packingContainer*/
packingListTab.toolStrip.packingContainer = {
    visibility: "visible",
    icon: "[SKIN]/actions/configure.png",
    title: "<spring:message code='packing-container.add'/>",
    click: function () {

        packingListTab.window.packingContainer.justShowForm();
    }
};
packingListTab.hLayout.packingContainer = isc.HLayout.create({
    width: "100%",
    align: nicico.CommonUtil.getAlignByLang(),
    visibility:"hidden",
    members: [
        packingListTab.listGrid.packingContainerListGrid,
        isc.ToolStrip.create({
            members:[isc.ToolStripButtonAdd.create({...packingListTab.toolStrip.packingContainer}),]
        }),
    ]
});

packingListTab.window.packingList = new nicico.FormUtil();
packingListTab.window.packingList.init(null, '<spring:message code="packing-list.title"/>', isc.VLayout.create({
    width: "100%",
    height: "250",
    margin: 20,
    align: "center",
    members: [
        packingListTab.dynamicForm.packingList,
    ]
}), "650", "30%");

packingListTab.window.packingContainer = new nicico.FormUtil();
packingListTab.window.packingContainer.init(null, '<spring:message code="packing-container.title"/>', isc.VLayout.create({
    width: "100%",
    height: "250",
    margin: 20,
    align: "center",
    members: [
        packingListTab.dynamicForm.packingContainer,
    ]
}), "650", "30%");

packingListTab.window.packingList.populateData = function (bodyWidget) {

    return packingListTab.dynamicForm.packingList.getValues();
};
// packingListTab.window.packingList.validate = function (data) {
// };
packingListTab.window.packingList.okCallBack = function (data) {

    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

            actionURL: "${contextPath}/api/packing-list",
            httpMethod: packingListTab.variable.method,
            data: JSON.stringify(data),
            callback: function (resp) {

                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    packingListTab.method.refreshData();
                } else
                    isc.say(resp.data);
            }
        })
    );
};
packingListTab.window.packingList.cancelCallBack = function () {
    packingListTab.dynamicForm.packingList.clearValues();
};


packingListTab.window.packingContainer.populateData = function (bodyWidget) {

    let record = packingListTab.listGrid.main.getSelectedRecord();
    let data = packingListTab.dynamicForm.packingContainer.getValues();
    data.packingListId = record.id;
    return data;
};
// packingListTab.window.packingContainer.validate = function (data) {
// };
packingListTab.window.packingContainer.okCallBack = function (data) {

    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

            actionURL: "${contextPath}/api/packing-container",
            httpMethod: packingListTab.variable.method,
            data: JSON.stringify(data),
            callback: function (resp) {

                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                    packingListTab.method.refreshData();
                } else
                    isc.say(resp.data);
            }
        })
    );
};
packingListTab.window.packingContainer.cancelCallBack = function () {
    packingListTab.dynamicForm.packingContainer.clearValues();
};

packingListTab.method.refreshData = function () {
    packingListTab.listGrid.main.invalidateCache();
    packingListTab.listGrid.packingContainerListGrid.invalidateCache();
};

packingListTab.method.newForm = function () {

    packingListTab.variable.method = "POST";
    packingListTab.dynamicForm.packingList.clearValues();
    packingListTab.window.packingList.justShowForm();
};


//***************************************************** MAINLISTGRID *************************************************

packingListTab.listGrid.fields = BaseFormItems.concat([
    {
        name: "bookingNo",title: "<spring:message code='shipment.bookingCat'/>",
    },
    {
        name: "shipment.automationLetterDate",canFilter:false,
        title: "<spring:message code='shipment.bDate'/>",
        formatCellValue(value, record, rowNum, colNum) {              if(!value)return null;
             return new persianDate(value).format('YYYYMMDD')},
    },
    {
        name: "shipment.automationLetterNo",
        title: "<spring:message code='shipment.loadingLetter'/>",
        type: 'text',
    },
    {name: "shipment.contractShipment.contract.no",title:"<spring:message code='contact.no'/>"},
    {name: "shipment.material.descFA",title:"<spring:message code='goods.title'/>"},
    {name:"description",title:"<spring:message code='shipment.description'/>"}
]);

// Packing-List ListGrid
nicico.BasicFormUtil.createListGrid = function () {

    packingListTab.listGrid.main = isc.ListGrid.nicico.getDefault(packingListTab.listGrid.fields,
        packingListTab.restDataSource.packingListRest, null, {
            showFilterEditor: true,
            canAutoFitFields: true,
            width: "100%",
            height: "100%",
            autoFetchData: true,
            styleName: 'expandList',
            alternateRecordStyles: true,
            canExpandRecords: true,
            canExpandMultipleRecords: false,
            wrapCells: false,
            showRollOver: false,
            showRecordComponents: true,
            showRecordComponentsByCell: true,
            autoFitExpandField: true,
            virtualScrolling: true,
            loadOnExpand: true,
            loaded: false,
            sortField: 3,
            showGridSummary:true,
            showRowNumbers:true,

            getExpansionComponent: function (record) {

                let criteria1 = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "packingListId", operator: "equals", value: record.id}]
                };

                packingListTab.listGrid.packingContainerListGrid.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                    if (data.length === 0) {
                        packingListTab.hLayout.packingContainer.show();
                    } else {

                        packingListTab.listGrid.packingContainerListGrid.setData(data);
                        packingListTab.listGrid.packingContainerListGrid.setAutoFitMaxRecords(1);
                        packingListTab.hLayout.packingContainer.show();
                    }
                }, {operationId: "00"});

                packingListTab.vLayout.packingListMain = isc.VLayout.create({
                    styleName: "expand-layout",
                    padding: 5,
                    membersMargin: 10,
                    members: [
                        packingListTab.listGrid.packingContainerListGrid,
                        packingListTab.hLayout.packingContainer
                    ]
                });
                return packingListTab.vLayout.packingListMain;
            }
        }
    );
};

// Packing-Container ListGrid
packingListTab.listGrid.packingContainerListGrid = isc.ListGrid.create(
    {
        showFilterEditor: true,
        canAutoFitFields: true,
        width: "100%",
        styleName: "listgrid-child",
        height: 280,
        dataSource: packingListTab.restDataSource.packingContainer,
        autoFetchData: false,
        showRecordComponents: true,
        setAutoFitExtraRecords: true,
        showRecordComponentsByCell: true,
        showGridSummary:true,
        showRowNumbers:true,

        fields: [
            {
                name: "id",
                hidden: true,
                primaryKey: true
            },
            {
                name: "containerNo",
                width: "10%",
            },
            {
                name: "sealNo",
                width: "10%"
            },
            {
                name: "ladingDate",
                width: "10%"
            },
            {
                name: "packageCount",
                width: "10%",
            },
            {
                name: "strapWeight",
                width: "10%",
                hidden:true,
            },
            {
                name: "palletWeight",
                width: "10%",
                hidden:true,

            },
            {
                name: "strapWeight",
                width: "10%",
                hidden:true,

            },
            {
                name: "woodWeight",
                width: "10%",
                hidden:true,

            },
            {
                name: "barrelWeight",
                width: "10%",
                hidden:true,

            },
            {
                name: "woodWeight",
                width: "10%",
                hidden:true,

            }, {
                name: "containerWeight",
                width: "10%",
            },
            {
                name: "contentWeight",
                width: "10%",
            },
            {name: "description", showHover: true, title: "<spring:message code='packing-container.description'/>"},
            {
                name: "editIcon",
                width: "4%",
                align: "center",
                showTitle: false
            },
            {
                name: "removeIcon",
                width: "4%",
                align: "center",
                showTitle: false
            }
        ],
        createRecordComponent: function (record, colNum) {
            var fieldName = this.getFieldName(colNum);
            if (fieldName === "removeIcon") {
                let removeImg = isc.ImgButton.create({
                    showDown: false,
                    showRollOver: false,
                    layoutAlign: "center",
                    src: "pieces/16/icon_delete.png",
                    height: 16,
                    width: 16,
                    grid: this,
                    click: function () {

                        // let record = this.grid.getSelectedRecord();
                        if (record == null || record.id == null)
                            packingListTab.dialog.notSelected();
                        else if (record.editable === false)
                            packingListTab.dialog.notEditable();
                        else {

                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {

                                    actionURL: packingListTab.variable.packingContainerUrl + record.id,
                                    httpMethod: "DELETE",
                                    callback: function (resp) {

                                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                                            isc.say("<spring:message code='global.form.request.successful'/>");
                                            packingListTab.method.refreshData();
                                        } else
                                            isc.say(resp.data);
                                    }
                                })
                            );
                        }
                    }
                });
                return removeImg;
            } else if (fieldName === "editIcon") {
                let editImg = isc.ImgButton.create({
                    showDown: false,
                    showRollOver: false,
                    layoutAlign: "center",
                    src: "pieces/16/icon_edit.png",
                    height: 16,
                    width: 16,
                    grid: this,
                    click: function () {

                        // let record = this.grid.getSelectedRecord();
                        if (!record|| !record.id)
                            packingListTab.dialog.notSelected();
                        else if (record.editable === false)
                            packingListTab.dialog.notEditable();
                        else {
                            packingListTab.variable.method = 'PUT';
                            packingListTab.dynamicForm.packingContainer.clearValues();
                            packingListTab.dynamicForm.packingContainer.setValues(record);
                            packingListTab.window.packingContainer.justShowForm();
                            // isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                            //
                            //         actionURL: packingListTab.variable.packingContainerUrl,
                            //         httpMethod: "PUT",
                            //         data: JSON.stringify(record),
                            //         callback: function (resp) {
                            //
                            //             if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            //                 isc.say("<spring:message code='global.form.request.successful'/>");
                            //                 packingListTab.method.refreshData();
                            //             } else
                            //                 isc.say(resp.data);
                            //         }
                            //     })
                            // );
                        }
                    }
                });
                return editImg;
            }
            else {
                return null;
            }
        }
    });

nicico.BasicFormUtil.getDefaultBasicForm(packingListTab, "api/packing-list/");
// nicico.BasicFormUtil.showAllToolStripActions(packingListTab);
nicico.BasicFormUtil.removeExtraGridMenuActions(packingListTab);

packingListTab.sectionStack.mainSection = isc.SectionStack.create(
    {
        sections: [
            {
                title: "<spring:message code='packing-list.title'/>",
                items: packingListTab.vLayout.main,
                showHeader: false,
                expanded: true
            },
            {
                title: "<spring:message code='packing-container.title'/>",
                hidden: true,
                items: packingListTab.listGrid.packingContainerListGrid,
                expanded: false
            }],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });

/***@type {ToolStrip} packingListTab.toolStrip.main**/
packingListTab.toolStrip.main.addMember(isc.ToolStripButtonAdd.create(
    {
        title:"<spring:message code='packing-container.paste.excel'/>",
        icon: "[SKIN]/actions/excel.png",
        click(){
            if (!packingListTab.listGrid.main.getSelectedRecord())
                return isc.warn('<spring:message code="global.grid.record.not.selected"/>')
            packingListTab.Windows.PasteTextToPackingContainerGrid = isc.Window.create({
                ...packingListTab.Vars.defaultWindowConfig,
                members:[
                    packingListTab.Forms.PasteTextToPackingContainerGrid =  isc.DynamicForm.create({
                        numCols:1,
                        width:"100%",
                        height:"100%",
                        items:[{name:"textArea",  editorType: "TextAreaItem",required:true,showTitle:false,
                        height:"100%",
                        width:"100%",
                        },
                            {name:"btn",editorType:"ButtonItem",
                                width:150,
                                title:"<spring:message code='global.add'/>",
                                click(form, item) {
                                    if(!form.validate())return;
                                    const pasteData = form.getValue("textArea");
                                    packingListTab.Windows.PastedPackingContainer = isc.Window.create({
                                        ...packingListTab.Vars.defaultWindowConfig,
                                        members:[
                                            /**@property {ListGrid} ****/
                                            packingListTab.Grids.PasteFromExcelPackingContainer=  isc.ListGrid.create({
                                                width:"100%",
                                                height:"100%",
                                                canEdit:true,
                                                validateOnChange:true,
                                                validateOnExit:true,
                                                showRowNumbers:true,
                                                showGridSummary:true,

                                                fields:packingListTab.Fields.packingContainer(),
                                                gridComponents : ["filterEditor", "header",
                                                    "body", "summaryRow",isc.ToolStrip.create({

                                                        members:[
                                                            isc.ToolStripButtonAdd.create({
                                                                title:"<spring:message code='global.form.save'/>",
                                                                click(){
                                                                    const packingListId=packingListTab.listGrid.main.getSelectedRecord().id;
                                                                    const packingContainers=packingListTab.Grids.PasteFromExcelPackingContainer.getData();
                                                                    packingContainers.forEach(container=>container.packingListId=packingListId);
                                                                    fetch('api/packing-container/batch',{
                                                                        headers:SalesConfigs.httpHeaders,
                                                                        method:"POST",
                                                                        body:JSON.stringify(packingContainers)
                                                                    }).then(_response=>{
                                                                        _response.text().then(
                                                                            response=>{
                                                                                if(_response.ok){
                                                                                    isc.say(
                                                                                        "<spring:message code='global.form.request.successful'/>",
                                                                                        _=>packingListTab.Windows.PastedPackingContainer.destroy()
                                                                                    )
                                                                                    return ;
                                                                                }
                                                                                isc.warn('<spring:message code="exception.un-managed"/> ' +
                                                                                  response  )
                                                                            }
                                                                        )
                                                                    })
                                                                }
                                                            })],
                                                    })],
                                            })
                                        ]});
                                    packingListTab.Methods.PasteTextToPackingContainerGrid(pasteData);
                                    packingListTab.Windows.PasteTextToPackingContainerGrid.destroy();
                                }}],
                    })
                ]
            })
        }

    }),2)
