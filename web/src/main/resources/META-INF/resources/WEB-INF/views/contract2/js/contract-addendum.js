/*
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
 */
////////////////////////////////////////////////////////VARIABLES///////////////////////////////////////////////////////
contractTab.Vars = {
    Debug: false,
    Prefix: "contract_addendum_tab" + Math.random().toString().substr(-6),
    Url: SalesConfigs.Urls.remittanceRest,
    Urls: {},
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
}
contractTab.Window = {}
contractTab.Grids = {}
////////////////////////////////////////////////////////METHODS/////////////////////////////////////////////////////////
contractTab.Methods = {
    CreateWindowForForm: function (formItems, url, numCols = 6, extraOption = {win: {}, form: {}}) {
        const form = isc.DynamicForm.create({
            items: [...formItems],
            numCols: numCols,
            ...extraOption.form,
        })

        function saveMethod() {
            if (!form.validate()) return;
            contractTab.Methods.Save(form.getValues(), url)
        }

        const id = contractTab.Vars.Prefix + "window_BL" + Math.random().toString().substr(2, 6)
        const win = isc.Window.create({
            ID: id,
            ...contractTab.Vars.DefaultWindowConfig,
            visibility: "hidden",
            members: [
                isc.VLayout.create({
                    members: [
                        isc.HLayout.create({members: [form], height: "100%"}),
                        contractTab.Methods.HlayoutSaveOrExit(saveMethod, id,)
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
                        result[key] = contractTab.Methods.concatObjectsByKey(isBoolOperatorAnd, first[key], second[key]);
                    else console.log("concatation error; type of '" + key + "'[" + first[key].Class + "] not recogenized...");
                } else
                    result[key] = second[key];
            }

            return result;
        }, {});
    },
    FetchSpecListData: function (usePageStrategy, props, responseCallBack) {

        contractTab.method.jsonRPCManagerRequest(props, (response) => {

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

            contractTab.method.fetchSpecListData(usePageStrategy, currentProps, (response2) => {

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
        for (let grid in contractTab.Grids) {
            try {
                let iscGrid = window[contractTab.Grids[grid].ID];
                if (typeof (iscGrid) === "object") {
                    iscGrid.invalidateCache();
                    // iscGrid.deselectAllRecords();
                }
            } catch (e) {
                console.log(e);
            }

        }
        for (let form in contractTab.DynamicForms.Forms) {
            let f = window[contractTab.DynamicForms.Forms[form]["ID"]];

            try {
                f.clearValues();
            } catch (e) {
                console.log(e);
            }
        }
        for (let windows in contractTab.Layouts.Window) {
            let w = window[contractTab.Layouts.Window[windows]["ID"]];

            try {
                w.hide();
            } catch (e) {
                console.log(e);
            }
        }
    },
    Required: function () {
        return !contractTab.Vars.debug
    },
    CrudDynamicForm: async function (props) {
        contractTab.Logs.add(['props:', props]);
        if (typeof (props) === "undefined") return;
        let url = contractTab.Vars.Url;
        let method = contractTab.Vars.Method;
        let httpHeaders = SalesConfigs.httpHeaders;
        let params = "";
        let data = "";
        let callBack = "";
        let defaultResponse = async function (response) {
            contractTab.Logs.add(["return status:", response]);
            if (response.status === 400 || response.status == 500) {
                response.text().then(error => {
                    contractTab.Logs.add(["fetch error:", error]);
                    // MyRPCManager.handleError({httpResponseText: error});
                    isc.warn("مشکلی پیش آمد. مشکل جهت گزارش:\n" + JSON.stringify(error));
                });
                return;
            }

            if (response.status === 200 || response.status === 201) {
                // await response.text()
                contractTab.Dialog.Success();
                contractTab.Grids.BillOfLanding.obj.invalidateCache();
            } else {
                const error = await response.text();
                contractTab.Logs.add(["fetch error:", error]);
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
        contractTab.Logs.add(['data to send rpc', data]);
        const response = await fetch(url, {
            method: method,
            headers: httpHeaders,

            body: data,
        })
        defaultResponse(response);
    },
    DynamicFormRefresh: (method = "POST", form) => {
        contractTab.Vars.Method = method;
        form = window[form.ID];
        form.clearValues();
    },
    NewForm: function (iscWindow, form) {
        const win = window[iscWindow.ID];
        contractTab.Methods.DynamicFormRefresh("POST", form);
        win.show();
    },
    Save: async function (data, url, callBack) {
        await contractTab.Methods.CrudDynamicForm({
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
                contractTab.Vars.Method = "PUT";
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
                            // let urlD = contractTab.Vars.Url + "pattern/list";
                            // if (typeof (deleteUrl) === "string") urlD = deleteUrl;
                            contractTab.Methods.CrudDynamicForm({
                                data: data,
                                url: deleteUrl,
                                method: "DELETE",
                                params: params,
                            });
                        } else {

                        }

                        // contractTab.log.add(ids);

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
                                contractTab.Methods.RefreshAll();
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
contractTab.Methods.NewAddendum = function () {
    const contractRecord = contractTab.listGrid.main.getSelectedRecord()
    if (!contractRecord) return isc.warn("<spring:message code='global.grid.record.not.selected'/>")
    if (contractRecord.parentId) return isc.warn("<spring:message code='exception.not-editable'/>")
    // dbg('addendum Record', contractRecord)
    const ds = isc.MyRestDataSource.create({fetchDataURL: '${contextPath}/api/contact/spec-list'});
    const formFields = [
        {
            name: "no",
            required: true, //false
            // editorType: "StaticText",
            title: "<spring:message code='contract.form.no'/>",
            defaultValue: contractRecord['no'] + "-" + moment().dayOfYear().toString()
        },
        {
            name: "parentId",
            hidden: true, //false
            // editorType: "StaticText",
            defaultValue: contractRecord['id']
        },
        {
            name: "materialId",
            // width: "100%",
            optionDataSource: isc.MyRestDataSource.create({
                fields: [
                    {name: "id", title: "id", primaryKey: true, hidden: true},
                    {name: "code", title: "<spring:message code='goods.code'/> "},
                    {name: "descl"},
                    {name: "unitId"},
                    {name: "unit.nameEN"}
                ],
                fetchDataURL: "${contextPath}/api/material/spec-list"
            }),
            defaultValue: contractRecord["materialId"],
            autoFetchData: false,
            displayField: "descl",
            valueField: "id",
            required: true,
            disabled: true,
            title: "<spring:message code='material.title'/>",
        },
        {
            name: "contractTypeId",
            // width: "100%",
            editorType: "SelectItem",
            defaultValue: (_ => {
                if (!StorageUtil.get('addendumContractTypeId') || typeof (StorageUtil.get('addendumContractTypeId')) !== "number") return null;
                try {
                    return StorageUtil.get('addendumContractTypeId')
                } catch (e) {
                    dbg('addendumContractTypeId error', e)
                    return null
                }

            })(),
            optionDataSource: isc.MyRestDataSource.create({
                fields: [
                    {name: "id", title: "id", primaryKey: true, hidden: true},
                    {name: "code", title: "<spring:message code='goods.code'/> "},
                    {name: "titleFa"},
                    {name: "titleEn"},
                    {name: "description"}
                ],
                fetchDataURL: "${contextPath}/api/contract-type/spec-list"
            }),
            autoFetchData: false,
            displayField: "titleEn",
            valueField: "id",
            required: true,
            changed(form, item, value) {
                StorageUtil.save('addendumContractTypeId', value)
            },
            title: "<spring:message code='entity.contract-type'/>"
        },
        {
            name: "date",
            type: "date",
            required: true,
            title: "<spring:message code='global.date'/>"
        },
        {
            name: "affectFrom",
            title: "<spring:message code='contract.affect.from'/>",
            type: "date",
            // width: "100%",
            required: true,
        },
        {
            name: "affectUpTo",
            title: "<spring:message code='contract.affect.upto'/>",
            type: "date",
            // width: "10%",
            required: true,
        },

        {
            name: "buyerId", title: "<spring:message code='contact.commercialRole.buyer'/>", disabled: true,
            defaultValue: contractRecord['buyerId'],
            displayField: "nameEN",
            valueField: "id",
            optionDataSource: ds,
        },
        {
            name: "sellerId", title: "<spring:message code='contact.commercialRole.seller'/>", disabled: true,
            defaultValue: contractRecord['sellerId'],
            // displayField: "nameEN",
            // valueField: "id",
            // optionDataSource: ds,
            hidden: true

        },
        {
            name: "agentBuyerId",
            displayField: "nameEN",
            valueField: "id",
            title: "<spring:message code='contact.commercialRole.agentBuyer'/>",
            defaultValue: contractRecord['agentBuyerId'],
            optionDataSource: ds,
        },
        {
            name: "agentSellerId",
            displayField: "nameEN",
            valueField: "id",
            title: "<spring:message code='contact.commercialRole.agentSeller'/>",
            defaultValue: contractRecord['agentSellerId'],
            optionDataSource: ds,

        },
        {
            colSpan: 6,
            width: "100%",
            type: "TextArea",
            name: "description",
            title: "<spring:message code='global.description'/>"
        }
    ];
    const winId = contractTab.Vars.Prefix + Math.random().toString().substr(3, 5)
    contractTab.Window.Addendum = isc.Window.create(
        {
            ...contractTab.Vars.DefaultWindowConfig,
            ID: winId,
            height: 0.6 * innerHeight,
            members: [
                isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    members: [
                        isc.HLayout.create({
                            width: "100%",
                            height: "33%",
                            members: [
                                contractTab.dynamicForm.Addendum = isc.DynamicForm.create({
                                    width: "100%",
                                    numCols: 6,
                                    fields: formFields
                                })
                            ]
                        }),
                        isc.HLayout.create({
                            members: [
                                isc.VLayout.create({
                                    width: "40%",
                                    members: [
                                        contractTab.Grids.Addendum = isc.ListGrid.create({

                                            width: "100%",
                                            fields: [
                                                {
                                                    name: "id",
                                                    primaryKey: true,
                                                    hidden: true,
                                                    title: '<spring:message code="global.id"/>'
                                                },
                                                {
                                                    name: "titleFa",
                                                    title: '<spring:message code="global.title-fa"/>'
                                                },
                                                {
                                                    name: "titleEn",
                                                    title: '<spring:message code="global.title-en"/>'
                                                },
                                                {
                                                    type: 'long',
                                                    editorType: "SelectItem",
                                                    name: "contractDetailTypeTemplateId",
                                                    title: '<spring:message code="contract.form.detail-type-template"/>',
                                                    canEdit: true,
                                                    required: true,
                                                    valueField: "id",
                                                    displayField: "code",
                                                    pickListProperties: {showFilterEditor: true},
                                                    pickListFields: [
                                                        {name: "id", align: "center", hidden: true},
                                                        {name: "code", align: "center"},
                                                    ],
                                                    optionDataSource: contractTab.restDataSource.contractDetailTypeTemplate,
                                                    optionCriteria: {
                                                        fieldName: "contractDetailTypeId",
                                                        operator: "equals",
                                                        value: null
                                                    },
                                                    recordClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
                                                        this.optionCriteria.value = contractRecord.id;
                                                        return false;
                                                    }
                                                },
                                                {
                                                    name: "addIcon",
                                                    width: "5%",
                                                    type: "icon",
                                                    emptyCellValue: '<img src="static/img/pieces/16/icon_add.png">',
                                                    recordClick(viewer, _record, recordNum, field, fieldNum, value, rawValue) {
                                                        const t = contractRecord.contractDetails.find(cd => cd.contractDetailTypeId === _record.id);
                                                        const sectionStackSectionObj = {
                                                            expanded: false,
                                                            name: _record.id,
                                                            title: _record.titleEn,
                                                            contractDetailId: null,
                                                            controls: [isc.IButton.create({
                                                                width: 150,
                                                                icon: "[SKIN]/actions/view.png",
                                                                size: 32,
                                                                click: function () {

                                                                }
                                                            }), isc.IButton.create({
                                                                width: 150,
                                                                icon: "[SKIN]/actions/remove.png",
                                                                size: 32,
                                                                click: function () {
                                                                    contractTab.sectionStack.Addendum.removeSection(_record.id + "");
                                                                }
                                                            })],
                                                            items: []
                                                        };

                                                        const dynamicFormField = [];
                                                        _record.contractDetailTypeParams.filter(param => param.type !== "ListOfReference").forEach(param => {
                                                            const field = {
                                                                width: "100%",
                                                            };
                                                            field.name = param.key;
                                                            field.key = param.key;
                                                            field.title = param.name;
                                                            field.paramType = param.type;
                                                            field.reference = param.reference;
                                                            field.value = param.defaultValue;
                                                            field.required = param.required;

                                                            Object.assign(field, getFieldProperties(field.paramType, field.reference));

                                                            dynamicFormField.push(field);
                                                        });
                                                        const contractDetailDynamicForm = isc.DynamicForm.create({
                                                            visibility: "hidden",
                                                            width: "100%",
                                                            align: "center",
                                                            titleAlign: "right",
                                                            numCols: 8,
                                                            margin: 10,
                                                            canSubmit: true,
                                                            showErrorText: true,
                                                            showErrorStyle: true,
                                                            showInlineErrors: true,
                                                            errorOrientation: "bottom",
                                                            requiredMessage: '<spring:message code="validator.field.is.required"/>',
                                                            fields: BaseFormItems.concat(dynamicFormField, true)
                                                        });
                                                        sectionStackSectionObj.items.push(contractDetailDynamicForm);

                                                        _record.contractDetailTypeParams.filter(param => param.type === "ListOfReference").forEach(param => {
                                                            dbg('article is reference');
                                                            const contractDetailListGrid = isc.ListGrid.create({
                                                                width: "100%",
                                                                height: 300,
                                                                sortField: 1,
                                                                showRowNumbers: true,
                                                                canAutoFitFields: false,
                                                                allowAdvancedCriteria: true,
                                                                alternateRecordStyles: true,
                                                                selectionType: "single",
                                                                sortDirection: "ascending",
                                                                fields: getReferenceFields(param.reference),
                                                                canEdit: true,
                                                                editEvent: "doubleClick",
                                                                autoSaveEdits: false,
                                                                virtualScrolling: false,
                                                                showRecordComponents: true,
                                                                showRecordComponentsByCell: true,
                                                                recordComponentPoolingMode: "recycle",
                                                                listEndEditAction: "next",
                                                                canRemoveRecords: true,
                                                                reference: param.reference,
                                                                gridComponents: ["header", "body", isc.ToolStrip.create({
                                                                    width: "100%",
                                                                    height: 24,
                                                                    members: [
                                                                        isc.ToolStripButton.create({
                                                                            icon: "pieces/16/icon_add.png",
                                                                            title: "<spring:message code='global.add'/>",
                                                                            click: function () {
                                                                                contractDetailListGrid.startEditingNew();
                                                                            }
                                                                        }),
                                                                        isc.ToolStrip.create({
                                                                            width: "100%",
                                                                            height: 24,
                                                                            align: 'left',
                                                                            border: 0,
                                                                            members: [
                                                                                isc.ToolStripButton.create({
                                                                                    icon: "pieces/16/save.png",
                                                                                    title: "<spring:message code='global.form.save'/>",
                                                                                    click: function () {
                                                                                        contractDetailListGrid.saveAllEdits();
                                                                                    }
                                                                                })]
                                                                        })
                                                                    ]
                                                                })]
                                                            })
                                                            sectionStackSectionObj.items.push(contractDetailListGrid);
                                                            fetch('api/' + param['reference'] + '/spec-list?criteria=' +
                                                                JSON.stringify({
                                                                    fieldName: "id",
                                                                    // fieldName: "contractId",
                                                                    operator: "inSet",
                                                                    value: t.contractDetailValues
                                                                        .filter(cdv => cdv.reference)
                                                                        .map(cdv => Number(cdv.value)),
                                                                    // value: contractRecord['id']
                                                                },), {headers: SalesConfigs.httpHeaders}).then(
                                                                r => {
                                                                    dbg('list reference response', r)
                                                                    if (r.ok) {
                                                                        r.json().then(j => {
                                                                            dbg('list reference response', j)
                                                                            contractDetailListGrid.setData(j.response.data)
                                                                        })
                                                                    }
                                                                }
                                                            )
                                                        });
                                                        contractTab.sectionStack.Addendum.addSection(sectionStackSectionObj);
                                                        dbg('selected article', contractTab.Grids.Addendum.getSelectedRecord())
                                                        dbg('sectionStackSectionObj', contractDetailDynamicForm)
                                                        if (t) {
                                                            t.contractDetailValues.filter(cdv => !cdv.reference).forEach(cdv => {
                                                                // if (!cdv.reference)
                                                                contractDetailDynamicForm.setValue(cdv.key, cdv.value)
                                                            })
                                                        }
                                                        dbg('should have reference', t);
                                                    }
                                                }
                                            ],
                                            dataSource: contractTab.restDataSource.contractDetailType,
                                            initialCriteria: {
                                                operator: 'and',
                                                criteria: [{
                                                    fieldName: 'materialId',
                                                    operator: 'equals',
                                                    value: contractRecord.materialId
                                                }]
                                            },

                                            autoFetchData: true,
                                        })
                                    ]
                                }),
                                contractTab.sectionStack.Addendum = isc.SectionStack.create({width: "60%"})
                            ]
                        }),
                        isc.HLayout.create({
                            height: "8%",
                            members: [
                                contractTab.Methods.HlayoutSaveOrExit(
                                    contractTab.Methods.SaveAddendum, winId
                                )
                            ]
                        }),
                    ]
                })
            ]
        }
    )
}
contractTab.Methods.Validators = {
    async Addendum(data) {
        return true
        const contractShipments = data.contractDetails.filter(cd => {
                if (!cd.contractDetailValues) return false;
                return cd.contractDetailValues.find(cdv => (cdv.reference && cdv.reference.toLowerCase() === 'ContractShipment'.toLowerCase()))
            }
        )
        if (!contractShipments || contractShipments.length === 0) return true;
        const contract = contractTab.listGrid.main.getSelectedRecord();
        const parentContractShipments = contract.contractDetails.filter(
            cd => {
                if (!cd.contractDetailValues || cd.contractDetailValues.length === 0) return false;
                const shipments = cd.contractDetailValues.filter(cdv => {
                    if (cdv.reference && cdv.reference.toLowerCase() === 'ContractShipment'.toLowerCase()) return true;
                    return false;
                })
                if (shipments && shipments.length > 0) return true;
                return false;
            }
        )
        if (!parentContractShipments || parentContractShipments.length === 0) return true;
        const response = await fetch('api/shipment/spec-list?criteria=' + JSON.stringify({
            fieldName: 'contractShipmentId',
            operator: 'inSet',
            value: parentContractShipments.map(pcs => pcs.contractDetailValues.map(cdv => Number(cdv.value))).flat()
        }), {headers: SalesConfigs.httpHeaders})
        if (!response.ok) {
            const err = await response.json()
            isc.warn(JSON.stringify(err))
            console.error('addendum validation error: ', err)
            throw "addendum validation error"
        }
        const shipmentContractsWithShipment = (await response.json()).response.data.map(({contractShipment}) => contractShipment)
        const shipmentContractsWithShipmentId = shipmentContractsWithShipment.map(sws => Number(sws.id))
        const contractShipmentIds = contractShipments.map(cs => cs.contractDetailValues.map(cdv => Number(cdv.value))).flat()
        const removedId = shipmentContractsWithShipmentId.find(id => !contractShipmentIds.contains(id))
        if (removedId) {
            isc.warn("<spring:message code='shipment.was.sent'/>")
            return false
        }
        const chagedShipmentContract = shipmentContractsWithShipment.find(scws => {
                const cs = JSON.parse(contractShipments.map(cs => cs.contractDetailValues).flat().find(cs => {
                    return Number(cs.value) === scws.id;
                }).referenceJsonValue)
                // dbg('contractshipment: ', cs, 'original contractshipment: ', scws)
                const modifiedNotFound = Object.keys(cs).find(c => (typeof (cs[c]) !== 'object' && cs[c] !== scws[c]))
                // dbg('modifiedNotFound', modifiedNotFound);
                return modifiedNotFound;
            }
        )
        dbg('chagedShipmentContract', chagedShipmentContract)
        if (chagedShipmentContract) {
            isc.warn("<spring:message code='shipment.was.sent'/>")
            return false
        }
        dbg('shipments sent with this contract', shipmentContractsWithShipment)
        dbg('addendum data', data, parentContractShipments, contractShipments, contractShipmentIds)
        return true
    }
}
contractTab.Methods.SaveAddendum = async function () {
    const msg = isc.Dialog.create({
        message:"<spring:message code='global.please.wait'/>"
    })
    if (!contractTab.dynamicForm.Addendum.validate())
        return;
    let data = contractTab.dynamicForm.Addendum.getValues();

    contractTab.sectionStack.Addendum.expandSection(contractTab.sectionStack.Addendum.sections);

    data.contractDetails = [];
    contractTab.sectionStack.Addendum.sections.forEach(section => {
        let contractDetailObj = {
            contractDetailTypeId: section.name,
            id: section.contractDetailId,
            contractDetailValues: []
        };

        // dynamicForm
        section.items[0].fields.filter(x => x.isBaseItem == null).forEach(x => {
            contractDetailObj.contractDetailValues.push({
                id: x.contractDetailValueId,
                name: x.name,
                key: x.key,
                title: x.title,
                reference: x.reference,
                type: x.paramType,
                value: section.items[0].values[x.name],
                unitId: x.unitId,
                required: (x.required == null) ? false : x.required,
                contractDetailId: section.contractDetailId,
                estatus: x.estatus,
                editable: x.editable
            });
        });

        // listGrids
        section.items.slice(1, section.items.length).forEach(listGrid => {
            listGrid.saveAllEdits();
            let listGridData;
            if (listGrid.getData() instanceof Array) //create
                listGridData = listGrid.getData();
            else { //update
                listGridData = listGrid.getData().localData
            }
            listGridData.forEach(x => {
                Object.keys(x).forEach(listGridKey => {
                    if (listGridKey.startsWith("_"))
                        delete x[listGridKey];
                });
                contractDetailObj.contractDetailValues.push({
                    id: x.contractDetailValueId,
                    name: "Not Important",
                    title: "Not Important",
                    key: "NotImportant",
                    reference: listGrid.reference,
                    type: "ListOfReference",
                    value: x.id,
                    referenceJsonValue: JSON.stringify(x),
                    unitId: null,
                    required: false,
                    contractDetailId: section.contractDetailId,
                    estatus: x.estatus,
                    editable: x.editable
                });
            });
        });

        data.contractDetails.push(contractDetailObj);
    });
    const validated = await contractTab.Methods.Validators.Addendum(data)
    if (validated) isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
        actionURL: contractTab.variable.contractUrl,
        httpMethod: contractTab.Vars.Method,
        data: JSON.stringify(data),
        callback: function (resp) {
            if (resp.httpResponseCode === 201 || resp.httpResponseCode === 200) {
                contractTab.dialog.ok();
                contractTab.method.refresh(contractTab.listGrid.main);
                contractTab.Window.Addendum.destroy();
            } else
                contractTab.dialog.error(resp);
            msg.destroy()
        }
    }))
    else msg.destroy()
}
////////////////////////////////////////////////////////FIELDS//////////////////////////////////////////////////////////
contractTab.Fields = {
    Contract: _ => [
        {
            useInGrid: true,
            name: "no",
            // width: "100%",
            required: true, //false
            // editorType: "StaticText",
            title: "<spring:message code='contract.form.no'/>"
        },
        {
            useInGrid: true,
            name: "date",
            type: "date",
            formatCellValue: function (value, record, rowNum, colNum, grid) {
                return new Date(value);
            },
            // width: "100%",
            required: true,
            title: "<spring:message code='global.date'/>"
        },
        {
            name: "affectFrom",
            title: "<spring:message code='contract.affect.from'/>",
            type: "date",
            // width: "100%",
            required: true,
        },
        {
            name: "affectUpTo",
            title: "<spring:message code='contract.affect.upto'/>",
            type: "date",
            // width: "10%",
            required: true,
        },
        {
            useInGrid: true,
            name: "materialId",
            // width: "100%",
            editorType: "SelectItem",
            optionDataSource: isc.MyRestDataSource.create({
                fields: [
                    {name: "id", title: "id", primaryKey: true, hidden: true},
                    {name: "code", title: "<spring:message code='goods.code'/> "},
                    {name: "descl"},
                    {name: "unitId"},
                    {name: "unit.nameEN"}
                ],
                fetchDataURL: "${contextPath}/api/material/spec-list"
            }),
            autoFetchData: false,
            displayField: "descl",
            valueField: "id",
            required: true,
            title: "<spring:message code='material.title'/>",
            changed: function (form, item, value) {

                contractTab.listGrid.contractDetailType.setCriteria({
                    operator: 'and',
                    criteria: [{
                        fieldName: 'materialId',
                        operator: 'equals',
                        value: value
                    }]
                });
                contractTab.sectionStack.contract.getSectionNames().forEach(q => contractTab.sectionStack.contract.removeSection(q + ""));
            }
        },
        {
            useInGrid: true,
            name: "contractTypeId",
            // width: "100%",
            editorType: "SelectItem",
            optionDataSource: isc.MyRestDataSource.create({
                fields: [
                    {name: "id", title: "id", primaryKey: true, hidden: true},
                    {name: "code", title: "<spring:message code='goods.code'/> "},
                    {name: "titleFa"},
                    {name: "titleEn"},
                    {name: "description"}
                ],
                fetchDataURL: "${contextPath}/api/contract-type/spec-list"
            }),
            autoFetchData: false,
            displayField: "titleEn",
            valueField: "id",
            required: true,
            title: "<spring:message code='entity.contract-type'/>"
        },
        Object.assign({}, getContactByType("buyer"), {useInGrid: true, width: "100%"}),
        Object.assign({}, getContactByType("seller"), {useInGrid: true, width: "100%"}),
        Object.assign({}, getContactByType("agentBuyer"), {useInGrid: true, width: "100%"}),
        Object.assign({}, getContactByType("agentSeller"), {useInGrid: true, width: "100%"}),
        {
            colSpan: 8,
            // width: "100%",
            type: "TextArea",
            name: "description",
            title: "<spring:message code='global.description'/>"
        }
    ]
};
////////////////////////////////////////////////////////DATASOURCE//////////////////////////////////////////////////////
////////////////////////////////////////////////////////GRIDS///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////DYNAMICFORMS////////////////////////////////////////////////////
////////////////////////////////////////////////////////COMPONENTS//////////////////////////////////////////////////////
////////////////////////////////////////////////////////WINDOWS/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////MainContractRefactor////////////////////////////////////////////
contractTab.ToolStripButtons = {
    Addendum: isc.ToolStripButtonRefresh.create({
            title: "<spring:message code='contract.addendum'/>",
            click: contractTab.Methods.NewAddendum
        }
    )
};
contractTab.toolStrip.main.addMember(contractTab.ToolStripButtons.Addendum, 3)
contractTab.listGrid.main.getCellCSSText = function (record, rowNum, colNum) {
    if (record.parentId) {
        return "font-weight:bold; color:#287fd6;";
    }
    return this.Super('getCellCSSText', arguments)
}
contractTab.listGrid.main.redraw()