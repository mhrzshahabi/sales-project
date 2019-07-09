<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

<spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

    var RestDataSource_Contract = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "contractNo", title: "<spring:message code='contract.contractNo'/>"},
                {name: "contractDate", title: "<spring:message code='contract.contractDate'/>"},
                {name: "contactId", title: "<spring:message code='contact.name'/> "},
                {name: "contact.nameFA", title: "<spring:message code='contact.name'/> "},
                {name: "incotermsId", title: "<spring:message code='incoterms.name'/>"},
                {name: "incoterms.code", title: "<spring:message code='incoterms.name'/>"},
                {name: "sideContractDate", ID: "sideContractDate"},
                {name: "refinaryCost", ID: "refinaryCost"},
                {name: "treatCost", ID: "treatCost"},
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        // ######@@@@###&&@@###
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
                "Access-Control-Allow-Origin": "${restApiUrl}"
            };
            return this.Super("transformRequest", arguments);
        },
        fetchDataURL: "${restApiUrl}/api/contract/spec-list"
    });

    var RestDataSource_Contact = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/> "},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/> "}
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        // ######@@@@###&&@@###
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
                "Access-Control-Allow-Origin": "${restApiUrl}"
            };
            return this.Super("transformRequest", arguments);
        },
        fetchDataURL: "${restApiUrl}/api/contact/spec-list"
    });

    var RestDataSource_Incoterms = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        // ######@@@@###&&@@###
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
                "Access-Control-Allow-Origin": "${restApiUrl}"
            };
            return this.Super("transformRequest", arguments);
        },
        fetchDataURL: "${restApiUrl}/api/incoterms/spec-list"
    });

    var RestDataSource_Material = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
                {name: "descl"},
                {name: "unitId"},
                {name: "unit.nameEN"},
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        // ######@@@@###&&@@###
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
                "Access-Control-Allow-Origin": "${restApiUrl}"
            };
            return this.Super("transformRequest", arguments);
        },
        fetchDataURL: "${restApiUrl}/api/material/spec-list"
    });

    var RestDataSource_Unit = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='unit.code'/> "},
                {name: "nameFA", title: "<spring:message code='unit.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='unit.nameEN'/> "},
                {name: "symbol", title: "<spring:message code='unit.symbol'/>"},
                {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        // ######@@@@###&&@@###
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
                "Access-Control-Allow-Origin": "${restApiUrl}"
            };
            return this.Super("transformRequest", arguments);
        },
        fetchDataURL: "${restApiUrl}/api/unit/spec-list"
    });

    function ListGrid_Contract_refresh() {
        ListGrid_Contract.invalidateCache();
    }

    function ListGrid_Contract_edit() {
        var record = ListGrid_Contract.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            DynamicForm_Contract.editRecord(record);
            DynamicForm_Contract.setValue("sideContractDateDumy", new Date(record.sideContractDate));
            DynamicForm_Contract.setValue("contractDateDumy", new Date(record.contractDate));
            DynamicForm_Contract.setValue("runEndDateDumy", (record.runEndtDate == null ? null : new Date(record.runEndtDate)));
            DynamicForm_Contract.setValue("runStartDateDumy", new Date(record.runStartDate));
                        if (record.material.descl === 'Copper Concentrate') {
                            DynamicForm_Contract.getItem("copper").show();
                            DynamicForm_Contract.getItem("copperTolorance").show();
                            DynamicForm_Contract.getItem("gold").show();
                            DynamicForm_Contract.getItem("goldTolorance").show();
                            DynamicForm_Contract.getItem("silver").show();
                            DynamicForm_Contract.getItem("silverTolorance").show();
                            DynamicForm_Contract.getItem("molybdenum").hide();
                            DynamicForm_Contract.getItem("molybdenumTolorance").hide();
                        } else if (record.material.descl === 'Molybdenum Oxide') {
                            DynamicForm_Contract.getItem("copper").hide();
                            DynamicForm_Contract.getItem("copperTolorance").hide();
                            DynamicForm_Contract.getItem("gold").hide();
                            DynamicForm_Contract.getItem("goldTolorance").hide();
                            DynamicForm_Contract.getItem("silver").hide();
                            DynamicForm_Contract.getItem("silverTolorance").hide();
                            DynamicForm_Contract.getItem("molybdenum").show();
                            DynamicForm_Contract.getItem("molybdenumTolorance").show();
                        } else {
                            DynamicForm_Contract.getItem("copper").hide();
                            DynamicForm_Contract.getItem("copperTolorance").hide();
                            DynamicForm_Contract.getItem("gold").hide();
                            DynamicForm_Contract.getItem("goldTolorance").hide();
                            DynamicForm_Contract.getItem("silver").hide();
                            DynamicForm_Contract.getItem("silverTolorance").hide();
                            DynamicForm_Contract.getItem("molybdenum").hide();
                            DynamicForm_Contract.getItem("molybdenumTolorance").hide();
                        }
            Window_Contract.animateShow()
        }
    }

    function ListGrid_Contract_remove() {

        var record = ListGrid_Contract.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${restApiUrl}/api/contract/" + record.id,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_Contract_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                }
                            })
                        );
                    }
                }
            });
        }
    }

    var Menu_ListGrid_Contract = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    DynamicForm_Contract.clearValues();
                    Window_Contract.animateShow();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>",
                icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Contract.clearValues();
                    Window_Contract.animateShow();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>",
                icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Contract_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>",
                icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Contract_remove();
                }
            },
            {
               title: "ارسال به Pdf", icon: "icon/pdf.png", click: function () {
                    "<spring:url value="/contract/print/pdf" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }, {
                title: "ارسال به Excel", icon: "icon/excel.png", click: function () {
                    "<spring:url value="/contract/print/excel" var="printUrl"/>"
                    window.open('${printUrl}');
             }
            }, {
                title: "ارسال به Html", icon: "icon/html.jpg", click: function () {
                    "<spring:url value="/contract/print/html" var="printUrl"/>"
                    window.open('${printUrl}');
                }
            }

        ]
    });

var RestDataSource_Contact_optionCriteria= {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "buyer", operator: "equals", value: true}]
  };
var DynamicForm_Contract = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        wrapTitle: false,
        requiredMessage: "<spring:message code='validator.field.is.required'/>.",
        numCols: 4,
        backgroundImage:"backgrounds/leaves.jpg",
        titleWidth: "120",
        titleAlign: "right",
        fields:
            [
                {name: "id", hidden: true,},
                {type: "Header", defaultValue: ""},
                {
                    name: "contractNo",
                    colSpan:1,
                    titleColSpan:1,
                    tabIndex:1,
                    showHover:true,
                    title: "<spring:message code='contract.contractNo'/>",
                    type: 'text',
                    required: true,
                    width: "100%"
                },
                {
                    name: "contractDateDumy",
                    colSpan:1,
                    titleColSpan:1,
                    tabIndex:2,
                    showHover:true,
                    title: "<spring:message code='contract.contractDate'/>",
                    type: 'date',
                    width: "100%"
                },
                {
                    name: "contactId",
                    colSpan:3,
                    titleColSpan:1,
                    tabIndex:3,
                    showHover:true,
                    autoFetchData:false,
                    title: "<spring:message code='contact.name'/>",
                    type: 'long',
                    width: "100%",
                    required: true,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Contact,
                    optionCriteria : RestDataSource_Contact_optionCriteria,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", width: "50%", align: "center"},
                        {name: "nameEN", width: "50%", align: "center"},
                        {name: "code", width: "10%", align: "center"}
                    ]
                },
                {
                    name: "sideContractNo",
                    colSpan: 1,
                    titleColSpan: 1,
                    tabIndex: 4,
                    showHover: true,
                    title: "<spring:message code='contract.sideContractNo'/>",
                    type: 'text',
                    required: false,
                    width: "100%"
                },
                {
                    name: "sideContractDateDumy",
                    colSpan: 1,
                    titleColSpan: 1,
                    tabIndex: 5,
                    showHover: true,
                    title: "<spring:message code='contract.sideContractDate'/>",
                    type: 'date',
                    required: false,
                    width: "100%"
                },
                {
                    type: "Header",
                    defaultValue: "------------------  ترم    ----------------------------------------------------------------"
                },
                {
                    name: "incotermsId",
                    colSpan: 3,
                    titleColSpan: 1,
                    tabIndex: 6,
                    showHover: true,
                    title: "<spring:message code='incoterms.name'/>",
                    type: 'long',
                    width: "100%", numCols: 4,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Incoterms,
                    displayField: "code",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "code", width: 440, align: "center"}
                    ]
                },
                {
                    type: "Header",
                    defaultValue: "------------------  محصول  --------------------------------------------------------------"
                },
                {
                    name: "materialId",
                    colSpan: 3,
                    titleColSpan: 1,
                    tabIndex: 7,
                    showHover: true,
                    title: "<spring:message code='contractItem.material'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Material,
                    displayField: "descl",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "descl", width: 440, align: "center"}
                    ],
                    changed(form, item, value) {
                        if (item.getSelectedRecord().descl === 'Copper Concentrate') {
                            form.getItem("copper").show();
                            form.getItem("copperTolorance").show();
                            form.getItem("gold").show();
                            form.getItem("goldTolorance").show();
                            form.getItem("silver").show();
                            form.getItem("silverTolorance").show();
                            form.getItem("molybdenum").hide();
                            form.getItem("molybdenumTolorance").hide();
                        } else if (item.getSelectedRecord().descl === 'Molybdenum Oxide') {
                            form.getItem("copper").hide();
                            form.getItem("copperTolorance").hide();
                            form.getItem("gold").hide();
                            form.getItem("goldTolorance").hide();
                            form.getItem("silver").hide();
                            form.getItem("silverTolorance").hide();
                            form.getItem("molybdenum").show();
                            form.getItem("molybdenumTolorance").show();
                        } else {
                            form.getItem("copper").hide();
                            form.getItem("copperTolorance").hide();
                            form.getItem("gold").hide();
                            form.getItem("goldTolorance").hide();
                            form.getItem("silver").hide();
                            form.getItem("silverTolorance").hide();
                            form.getItem("molybdenum").hide();
                            form.getItem("molybdenumTolorance").hide();
                        }
                    }
                },
                {
                    name: "amount",
                    title: "<spring:message code='contract.amount'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "unitId",
                    title: "<spring:message code='unit.nameFa'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Unit,
                    displayField: "code",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", width: 440, align: "center"}
                    ]
                },
                {
                    type: "Header",
                    defaultValue: "------------------  محتوی   --------------------------------------------------------------"
                },
                {
                    name: "copper",
                    title: "<spring:message code='contract.copper'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }],
                    hidden: true
                },
                {
                    name: "copperTolorance",
                    title: "<spring:message code='contract.copperTolorance'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }],
                    hidden: true
                },
                {
                    name: "gold",
                    title: "<spring:message code='contract.gold'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }],
                    hidden: true
                },
                {
                    name: "goldTolorance",
                    title: "<spring:message code='contract.goldTolorance'/>",
                    type: 'float',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }],
                    hidden: true
                },
                {
                    name: "silver",
                    title: "<spring:message code='contract.silver'/>",
                    type: 'float',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }],
                    hidden: true
                },
                {
                    name: "silverTolorance",
                    title: "<spring:message code='contract.silverTolorance'/>",
                    type: 'float',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }],
                    hidden: true
                },
                {
                    name: "molybdenum",
                    title: "<spring:message code='contract.molybdenum'/>",
                    type: 'float',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }],
                    hidden: true
                },
                {
                    name: "molybdenumTolorance",
                    title: "<spring:message code='contract.molybdenumTolorance'/>",
                    type: 'float',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }],
                    hidden: true
                },
                {type: "Header",defaultValue:"------------------  قیمت---------------------------------------------------------------"},
                {
                    name: "premium",
                    title: "<spring:message code='contract.premium'/>",
                    type: 'integer',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "discount",
                    title: "<spring:message code='contract.discount'/>",
                    type: 'integer',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "treatCost",
                    title: "<spring:message code='contract.TC'/>",
                    type: 'float',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "refinaryCost",
                    title: "<spring:message code='contract.RC'/>",
                    type: 'float',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "prepaid",
                    title: "<spring:message code='contract.prepaid'/>",
                    type: 'integer',
                    required: false,
                    width: "100%" ,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "prepaidCurrency",
                    title: "<spring:message code='contract.prepaidCurrency'/>",
                    type: 'text',
                    defaultValue: "DOLLAR", valueMap:{"EURO":"EURO", "DOLLAR":"DOLLAR"},
                    width: "100%"
                },
                {type: "Header",defaultValue:"------------------  زمان----------------------------------------------------------------"},
                {
                    name: "runStartDateDumy",
                    title: "<spring:message code='contract.runStartDate'/>",
                    type: 'date',
                    width: "100%"
                },
                {
                    name: "runEndDateDumy",
                    title: "<spring:message code='contract.runEndDate'/>",
                    type: 'date',
                    width: "100%"
                },
                {type: "Header",defaultValue:""}
            ]
    });

    var ToolStripButton_Contract_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Contract_refresh();
        }
    });

    var ToolStripButton_Contract_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Contract.clearValues();
            Window_Contract.animateShow();
        }
    });

    var ToolStripButton_Contract_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Contract_edit();
        }
    });

    var ToolStripButton_Contract_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Contract_remove();
        }
    });

    var ToolStrip_Actions_Contract = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Contract_Refresh,
                ToolStripButton_Contract_Add,
                ToolStripButton_Contract_Edit,
                ToolStripButton_Contract_Remove
            ]
    });

    var HLayout_Contract_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Contract
            ]
    });

    var IButton_Contract_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Contract.validate();
            if (DynamicForm_Contract.hasErrors())
                return;

            var d = DynamicForm_Contract.getValue("sideContractDateDumy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2));
            DynamicForm_Contract.setValue("sideContractDate", datestring);

            var d1 = DynamicForm_Contract.getValue("contractDateDumy");
            var datestring1 = (d1.getFullYear() + "/" + ("0" + (d1.getMonth() + 1)).slice(-2) + "/" + ("0" + d1.getDate()).slice(-2));
            DynamicForm_Contract.setValue("contractDate", datestring1);

            var drs = DynamicForm_Contract.getValue("runStartDateDumy");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Contract.setValue("runStartDate", datestringRs);

            var dre = DynamicForm_Contract.getValue("runEndDateDumy");
            if (!(dre == null || dre == 'undefiend')) {
                var datestringRe = (dre.getFullYear() + "/" + ("0" + (dre.getMonth() + 1)).slice(-2) + "/" + ("0" + dre.getDate()).slice(-2));
                DynamicForm_Contract.setValue("runEndtDate", datestringRe);
            }

            var data = DynamicForm_Contract.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest({
                actionURL: "${restApiUrl}/api/contract/",
                httpMethod: method,
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                showPrompt: true,
                serverOutputAsString: false,
                data: JSON.stringify(data),
                //params: { data:data1},
                callback: function (resp) {

                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_Contract_refresh();
                        Window_Contract.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });
    var Window_Contract = isc.Window.create({
        title: "<spring:message code='contract.title'/> ",
        width: 580,
        height: "*",
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                DynamicForm_Contract,
                isc.HLayout.create({
                    width: "100%", align: "center",  height: "20",
                    members:
                        [
                            IButton_Contract_Save,
                            isc.Label.create({
                                width: 15,
                            }),
                            isc.IButton.create({
                                ID: "contractEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Contract.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_Contract = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Contract,
        contextMenu: Menu_ListGrid_Contract,
        fields:
            [
                {name: "id", hidden: true,},
                {
                    name: "addendum",
                    title: "<spring:message code='contract.addendum'/>",
                    type: 'text',
                    required: true,
                    width: "5%",
                    align: "center"
                },
                {
                    name: "contractNo",
                    title: "<spring:message code='contract.contractNo'/>",
                    type: 'text',
                    width: "7%",
                    align: "center"
                },
                {
                    name: "contractDate",
                    title: "<spring:message code='contract.contractDate'/>",
                    type: 'text',
                    width: "7%",
                    align: "center"
                },
                {
                    name: "contact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    type: 'long',
                    width: "12%",
                    align: "center"
                },
                {
                    name: "incoterms.code",
                    title: "<spring:message code='incoterms.name'/>",
                    type: 'long',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "amount",
                    title: "<spring:message code='contract.amount'/>",
                    type: 'text',
                    width: "7%",
                    align: "center"
                },
                {
                    name: "prepaid",
                    title: "<spring:message code='contract.prepaid'/>",
                    type: 'integer',
                    required: true,
                    width: "100"
                }
            ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        sortFieldAscendingText: "مرتب سازی صعودی",
        sortFieldDescendingText: "مرتب سازی نزولی",
        configureSortText: "تنظیم مرتب سازی",
        autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
        autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
        filterUsingText: "فیلتر کردن",
        groupByText: "گروه بندی",
        freezeFieldText: "ثابت نگه داشتن",
        startsWithTitle: "tt",
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "contractId", operator: "equals", value: record.id}]
            };
            ListGrid_ContractShipment.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_ContractShipment.setData(data);
            });
        },
        dataArrived: function (startRow, endRow) {
        }

    });
    var HLayout_Contract_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Contract
        ]
    });

    var VLayout_Contract_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Contract_Actions, HLayout_Contract_Grid
        ]
    });
    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    var RestDataSource_Port = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        // ######@@@@###&&@@###
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
                "Access-Control-Allow-Origin": "${restApiUrl}"
            };
            return this.Super("transformRequest", arguments);
        },
        fetchDataURL: "${restApiUrl}/api/port/spec-list"
    });
    var RestDataSource_ContractShipment = isc.RestDataSource.create({
        fields:
            [
                {name: "id", hidden: true, primaryKey: true, canEdit: false,},
                {name: "contractItemId", type: "long", hidden: true},
                {
                    name: "shipmentRow",
                    title: "<spring:message code='contractItem.itemRow'/> ",
                    type: 'text',
                    required: true,
                    width: 400
                },
                {
                    name: "dischargeId",
                    title: "<spring:message code='port.port'/>",
                    type: 'text',
                    required: true,
                    width: 400
                },
                {name: "discharge.port", title: "<spring:message code='port.port'/>", align: "center"},
                {
                    name: "address",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    required: true,
                    width: 400
                },
                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float',
                    required: true,
                    width: 400
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    type: 'text',
                    width: 400,
                    format: 'DD-MM-YYYY HH:mm:ss'
                },
                {name: "duration", title: "<spring:message code='global.duration'/>", type: 'text', width: 400},
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        // ######@@@@###&&@@###
        transformRequest: function (dsRequest) {
            dsRequest.httpHeaders = {
                "Authorization": "Bearer " + "${cookie['access_token'].getValue()}",
                "Access-Control-Allow-Origin": "${restApiUrl}"
            };
            return this.Super("transformRequest", arguments);
        },
        fetchDataURL: "${restApiUrl}/api/contractShipment/spec-list"
    });

    /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    *************************************************************************************************************************/
    function ListGrid_ContractShipment_refresh() {
        ListGrid_ContractShipment.invalidateCache();
        var record = ListGrid_Contract.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "contract.id", operator: "equals", value: record.id}]
        };
        ListGrid_ContractShipment.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_ContractShipment.setData(data);
        }, {operationId: "00"});
    };

    function ListGrid_ContractShipment_edit() {
        var record = ListGrid_ContractShipment.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            DynamicForm_ContractShipment.editRecord(record);
            DynamicForm_ContractShipment.setValue("sendDateDummy", new Date(record.sendDate))
            Window_ContractShipment.animateShow();
        }
    };

    function ListGrid_ContractShipment_remove() {

        var record = ListGrid_ContractShipment.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var ContractShipmentId = record.id;
                        isc.RPCManager.sendRequest({
                            // ######@@@@###&&@@### pls correct callback
                            actionURL: "${restApiUrl}/api/contractShipment/" + ContractShipmentId,
                            httpMethod: "DELETE",
                            httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                            //     httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                // ######@@@@###&&@@###
                                //     if(RpcResponse_o.data == 'success')
                                if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                    ListGrid_ContractShipment_refresh();
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            }
                        });
                    }
                }
            });
        }
    };
    var Menu_ListGrid_ContractShipment = isc.Menu.create({
        width: 150,
        data:
            [
                {
                    title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                    click: function () {
                        DynamicForm_ContractShipment.clearValues();
                        Window_ContractShipment.animateShow();
                    }
                },
                {
                    title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                    click: function () {
                    }
                },
                {
                    title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_ContractShipment_edit();
                    }
                },
                {
                    title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_ContractShipment_remove();
                    }
                }
            ]
    });

    var DynamicForm_ContractShipment = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        // showErrorStyle:true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>.",
        numCols: 1,
        fields:
            [
                {name: "id", hidden: true, primaryKey: true, canEdit: false,},
                {name: "contractId", type: "long", hidden: true},
                {
                    name: "plan",
                    title: "<spring:message code='shipment.plan'/>",
                    type: 'text',
                    required: true,
                    width: 400,
                    valueMap: {"A": "plan A", "B": "plan B", "C": "plan C",}
                },
                {
                    name: "shipmentRow",
                    title: "<spring:message code='contractItem.itemRow'/>",
                    type: 'integer',
                    required: true,
                    width: 400,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "dischargeId",
                    title: "<spring:message code='port.port'/>",
                    type: 'long',
                    required: true,
                    width: 400,
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Port,
                    displayField: "port"
                    ,
                    valueField: "id",
                    pickListWidth: "300",
                    pickListheight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "port", width: 150, align: "center"}]
                },

                {
                    name: "address",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    required: false,
                    width: 400
                },

                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float',
                    required: true,
                    width: 400,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "sendDateDummy",
                    title: "<spring:message code='global.sendDate'/>",
                    type: 'date',
                    required: true,
                    width: 400,
                    format: 'DD-MM-YYYY HH:mm:ss'
                },
                {
                    name: "duration", title: "<spring:message code='global.duration'/>", type: 'integer', width: 400,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='contractItemShipment.tolorance'/>",
                    type: 'integer',
                    width: 400,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },
            ]
    });

    var ToolStripButton_ContractShipment_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ContractShipment_refresh();
        }
    });

    var ToolStripButton_ContractShipment_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_Contract.getSelectedRecord();

            if (record == null || record.id == null) {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function () {
                        this.hide();
                    }
                });
            } else {
                DynamicForm_ContractShipment.clearValues();
                DynamicForm_ContractShipment.setValue("contractId", record.id);
                Window_ContractShipment.animateShow();
            }
        }
    });

    var ToolStripButton_ContractShipment_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ContractShipment_edit();
        }
    });

    var ToolStripButton_ContractShipment_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ContractShipment_remove();
        }
    });

    var ToolStrip_Actions_ContractShipment = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_ContractShipment_Refresh,
                ToolStripButton_ContractShipment_Add,
                ToolStripButton_ContractShipment_Edit,
                ToolStripButton_ContractShipment_Remove
            ]
    });

    var HLayout_ContractShipment_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_ContractShipment
            ]
    });
    var IButton_ContractShipment_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_ContractShipment.validate();
            // if (DynamicForm_ContractShipment.hasErrors())
            // return;
            var d = DynamicForm_ContractShipment.getValue("sendDateDummy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
            DynamicForm_ContractShipment.setValue("sendDate", datestring)
            var data = DynamicForm_ContractShipment.getValues();
            // ######@@@@###&&@@###
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest({
                // ######@@@@###&&@@### pls correct callback
                actionURL: "${restApiUrl}/api/contractShipment/",
                httpMethod: methodXXXX,
                httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                //         httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
                //params: {    data:data1},
                callback: function (RpcResponse_o) {
                    // ######@@@@###&&@@###
                    //         if(RpcResponse_o.data == 'success')
                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_ContractShipment_refresh();
                        Window_ContractShipment.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });
    var Window_ContractShipment = isc.Window.create({
        title: "<spring:message code='Shipment.title'/> ",
        width: 580,
        hight: 500,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                DynamicForm_ContractShipment,
                isc.HLayout.create({
                    width: "100%", align: "center",  height: "20",
                    members:
                        [
                            IButton_ContractShipment_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                ID: "shipmentEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_ContractShipment.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_ContractShipment = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ContractShipment,
        contextMenu: Menu_ListGrid_ContractShipment,
        fields:
            [
                {name: "id", hidden: true,},
                {name: "contractId", type: "long", hidden: true},
                {
                    name: "plan",
                    title: "<spring:message code='shipment.plan'/>",
                    type: 'text',
                    width: 400,
                    valueMap: {"A": "plan A", "B": "plan B", "C": "plan C",},
                    align: "center"
                },
                {
                    name: "shipmentRow",
                    title: "<spring:message code='contractItem.itemRow'/> ",
                    type: 'text',
                    width: 100,
                    align: "center"
                },
                {name: "discharge.port", title: "<spring:message code='port.port'/>", width: 400, align: "center"},
                {
                    name: "address",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    required: true,
                    width: 200,
                    align: "center"
                },
                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float',
                    required: true,
                    width: 100,
                    align: "center"
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    type: 'text',
                    width: 150,
                    align: "center",
                    format: 'DD-MM-YYYY HH:mm:ss'
                },
                {
                    name: "duration",
                    title: "<spring:message code='global.duration'/>",
                    type: 'text',
                    width: 100,
                    align: "center"
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='contractItemShipment.tolorance'/>",
                    type: 'text',
                    width: 100,
                    align: "center"
                },
            ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: false,
        showFilterEditor: false,
        filterOnKeypress: true,
        sortFieldAscendingText: "مرتب سازی صعودی",
        sortFieldDescendingText: "مرتب سازی نزولی",
        configureSortText: "تنظیم مرتب سازی",
        autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
        autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
        filterUsingText: "فیلتر کردن",
        groupByText: "گروه بندی",
        freezeFieldText: "ثابت نگه داشتن",
        startsWithTitle: "tt"
    });
    var HLayout_ContractShipment_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                ListGrid_ContractShipment
            ]
    });

    var VLayout_ContractShipment_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_ContractShipment_Actions, HLayout_ContractShipment_Grid
            ]
    });
    /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
    isc.HLayout.create({
        width: "100%",
        height: "100%",
        border: "1px solid black",
        layoutTopMargin: 5,
        members: [
            isc.TabSet.create({
                tabBarPosition: "top",
                width: "100%",
                tabs:
                    [
                        {title: "<spring:message code='main.contractsTab'/>", pane: VLayout_Contract_Body}
                        , {title: "<spring:message code='Shipment.title'/>", pane: VLayout_ContractShipment_Body}
                    ]
            })
        ]
    });

