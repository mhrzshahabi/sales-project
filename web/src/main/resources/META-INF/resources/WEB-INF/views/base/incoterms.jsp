<%@ page contentType="text/html;charset=UTF-8" %><%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %><%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>//<script>    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />    var Menu_ListGrid_Incoterms = isc.Menu.create({        width: 150,        data: [            {                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",                click: function () {                    ListGrid_Incoterms_refresh();                }            },            <sec:authorize access="hasAuthority('C_INCOTERMS')">            {                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",                click: function () {                    DynamicForm_Incoterms.clearValues();                    Window_Incoterms.show();                }            },            </sec:authorize>            <sec:authorize access="hasAuthority('U_INCOTERMS')">            {                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",                click: function () {                    ListGrid_Incoterms_edit();                }            },            </sec:authorize>            <sec:authorize access="hasAuthority('D_INCOTERMS')">            {                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",                click: function () {                    ListGrid_Incoterms_remove();                }            }            </sec:authorize>        ]    });    var ValuesManager_Incoterms = isc.ValuesManager.create({});    var DynamicForm_Incoterms = isc.DynamicForm.create({        width: 650,        height: 100,        showMinimizeButton: false,        titleWidth: "100",        numCols: 2,        fields:            [                {name: "id", hidden: true, showIf: "false",},                {                    type: "RowSpacerItem"                },                {                    name: "code",                    title: "<spring:message code='contactAccount.ab'/>",                    type: 'text',                    required: true,                    wrapTitle: false, length: "100",                    width: 400,                    validators: [                    {                        type:"required",                        validateOnChange: true                    }]                },                {                    name: "works",                    title: "<spring:message code='incoterms.works'/>",                    type: 'checkbox',                    required: true,                    defaultValue: false,                    wrapTitle: false,                    width: 400,                    validators: [                    {                        type:"required",                        validateOnChange: true                    }]                },                {                    name: "carrier",                    title: "<spring:message code='incoterms.carrier'/>",                    type: 'checkbox',                    wrapTitle: false,                    defaultValue: false,                    width: 400,                },                {                    name: "alongSideShip",                    title: "<spring:message code='incoterms.alongSideShip'/>",                    type: 'checkbox',                    wrapTitle: false,                    defaultValue: false,                    width: 400                },                {                    name: "arrival",                    title: "<spring:message code='incoterms.arrival'/>",                    type: 'checkbox',                    wrapTitle: false,                    defaultValue: false,                    width: 400                },                {                    name: "onBoard",                    title: "<spring:message code='incoterms.onBoard'/>",                    type: 'checkbox',                    wrapTitle: false,                    defaultValue: false,                    width: 400                },                {                    name: "terminal",                    title: "<spring:message code='incoterms.terminal'/>",                    type: 'checkbox',                    wrapTitle: false,                    defaultValue: false,                    width: 400                },                {                    name: "destination",                    title: "<spring:message code='incoterms.destination'/>",                    type: 'checkbox',                    wrapTitle: false,                    defaultValue: false,                    width: 400                },                {                    name: "warehouse",                    title: "<spring:message code='incoterms.warehouse'/>",                    type: 'checkbox',                    wrapTitle: false,                    defaultValue: false,                    width: 400                },                {                    name: "expenses",                    title: "<spring:message code='incoterms.expenses'/>",                    width: 400,                    wrapTitle: false, required: true,                    valueMap: {                        "1": "<spring:message code='incoterms.works'/>",                        "2": "<spring:message code='incoterms.carrier'/>",                        "3": "<spring:message code='incoterms.alongSideShip'/>",                        "4": "<spring:message code='incoterms.onBoard'/>",                        "5": "<spring:message code='incoterms.arrival'/>",                        "6": "<spring:message code='incoterms.terminal'/>",                        "7": "<spring:message code='incoterms.destination'/>",                        "8": "<spring:message code='incoterms.warehouse'/>"                    },                    validators: [                    {                        type:"required",                        validateOnChange: true                    }]                },                {                    name: "namedPlace",                    title: "<spring:message code='incoterms.namedPlace'/>",                    width: 400,                    wrapTitle: false, required: true,                    valueMap: {                        "1": "<spring:message code='incoterms.works'/>",                        "2": "<spring:message code='incoterms.carrier'/>",                        "3": "<spring:message code='incoterms.alongSideShip'/>",                        "4": "<spring:message code='incoterms.onBoard'/>",                        "5": "<spring:message code='incoterms.arrival'/>",                        "6": "<spring:message code='incoterms.terminal'/>",                        "7": "<spring:message code='incoterms.destination'/>",                        "8": "<spring:message code='incoterms.warehouse'/>"                    },                    validators: [                    {                        type:"required",                        validateOnChange: true                    }]                },                {                    name: "namedPort",                    title: "<spring:message code='incoterms.namedPort'/>",                    width: 400,                    wrapTitle: false, required: true,                    valueMap: {                        "1": "<spring:message code='incoterms.works'/>",                        "2": "<spring:message code='incoterms.carrier'/>",                        "3": "<spring:message code='incoterms.alongSideShip'/>",                        "4": "<spring:message code='incoterms.onBoard'/>",                        "5": "<spring:message code='incoterms.arrival'/>",                        "6": "<spring:message code='incoterms.terminal'/>",                        "7": "<spring:message code='incoterms.destination'/>",                        "8": "<spring:message code='incoterms.warehouse'/>"                    },                    validators: [                    {                        type:"required",                        validateOnChange: true                    }]                },                {                    type: "RowSpacerItem"                },            ]    });    var IButton_Incoterms_Save = isc.IButtonSave.create({        top: 260,        title: "<spring:message code='global.form.save'/>",        icon: "pieces/16/save.png",        click: function () {            ValuesManager_Incoterms.validate();            DynamicForm_Incoterms.validate();            if (DynamicForm_Incoterms.hasErrors()) {                return;            }            var data = DynamicForm_Incoterms.getValues();            var methodXXXX = "PUT";            if (data.id == null) methodXXXX = "POST";            isc.RPCManager.sendRequest(                Object.assign(BaseRPCRequest, {                    actionURL: "${contextPath}/api/incoterms/",                    httpMethod: methodXXXX,                    data: JSON.stringify(data),                    callback: function (RpcResponse_o) {                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {                            isc.say("<spring:message code='global.form.request.successful'/>");                            ListGrid_Incoterms_refresh();                            Window_Incoterms.close();                        } else {                            isc.say(RpcResponse_o.data);                        }                    }                })            );        }    });    var IncotermsCancelBtn = isc.IButtonCancel.create({        top: 260,        layoutMargin: 5,        membersMargin: 5,        icon: "pieces/16/icon_delete.png",        width: 120,        title: "<spring:message code='global.cancel'/>",        click: function () {            Window_Incoterms.close();        }    });    var HLayout_Incoterms_IButton = isc.HLayout.create({        width: 650,        height: "100%",        layoutMargin: 10,        membersMargin: 5,        textAlign: "center",        align: "center",        members: [            IButton_Incoterms_Save,            IncotermsCancelBtn        ]    });    var VLayout_saveButton_incoterms = isc.VLayout.create({        width: 650,        textAlign: "center",        align: "center",        members: [        HLayout_Incoterms_IButton        ]    });    var Window_Incoterms = isc.Window.create({        title: "<spring:message code='incoterms.name'/> ",        width: 580,        autoSize: true,        autoCenter: true,        isModal: true,        showModalMask: true,        align: "center",        autoDraw: false,        dismissOnEscape: true,        margin: '10px',        closeClick: function () {            this.Super("closeClick", arguments)        },        items:            [                DynamicForm_Incoterms,                VLayout_saveButton_incoterms            ]    });    function ListGrid_Incoterms_refresh() {        ListGrid_Incoterms.invalidateCache();    }    function ListGrid_Incoterms_remove() {        var record = ListGrid_Incoterms.getSelectedRecord();        if (record == null || record.id == null) {            isc.Dialog.create({                message: "<spring:message code='global.grid.record.not.selected'/>",                icon: "[SKIN]ask.png",                title: "<spring:message code='global.message'/>.",                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],                buttonClick: function () {                    this.hide();                }            });        } else {            isc.Dialog.create({                message: "<spring:message code='global.grid.record.remove.ask'/>",                icon: "[SKIN]ask.png",                title: "<spring:message code='global.grid.record.remove.ask.title'/>",                buttons: [isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}), isc.IButtonCancel.create({                    title: "<spring:message	code='global.no'/>"                })],                buttonClick: function (button, index) {                    this.hide();                    if (index == 0) {                        var incotermsId = record.id;                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,                            {                                actionURL: "${contextPath}/api/incoterms/" + incotermsId,                                httpMethod: "DELETE",                                serverOutputAsString: false,                                callback: function (RpcResponse_o) {                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {                                        ListGrid_Incoterms.invalidateCache();                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");                                    } else {                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");                                    }                                }                            })                        );                    }                }            });        }    }    function ListGrid_Incoterms_edit() {        var record = ListGrid_Incoterms.getSelectedRecord();        if (record == null || record.id == null) {            isc.Dialog.create({                message: "<spring:message code='global.grid.record.not.selected'/>",                icon: "[SKIN]ask.png",                title: "<spring:message code='global.message'/>",                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],                buttonClick: function () {                    this.hide();                }            });        } else {            DynamicForm_Incoterms.editRecord(record);            Window_Incoterms.show();        }    }    var ToolStripButton_Incoterms_Refresh = isc.ToolStripButtonRefresh.create({        title: "<spring:message code='global.form.refresh'/>",        click: function () {            ListGrid_Incoterms_refresh();        }    });    <sec:authorize access="hasAuthority('C_INCOTERMS')">    var ToolStripButton_Incoterms_Add = isc.ToolStripButtonAdd.create({        title: "<spring:message code='global.form.new'/>",        click: function () {            DynamicForm_Incoterms.clearValues();            Window_Incoterms.show();        }    });    </sec:authorize>    <sec:authorize access="hasAuthority('U_INCOTERMS')">    var ToolStripButton_Incoterms_Edit = isc.ToolStripButtonEdit.create({        icon: "[SKIN]/actions/edit.png",        title: "<spring:message code='global.form.edit'/>",        click: function () {            DynamicForm_Incoterms.clearValues();            ListGrid_Incoterms_edit();        }    });    </sec:authorize>    <sec:authorize access="hasAuthority('D_INCOTERMS')">    var ToolStripButton_Incoterms_Remove = isc.ToolStripButtonRemove.create({        icon: "[SKIN]/actions/remove.png",        title: "<spring:message code='global.form.remove'/>",        click: function () {            ListGrid_Incoterms_remove();        }    });    </sec:authorize>    var ToolStrip_Actions_Incoterms_ = isc.ToolStrip.create({        width: "100%",        members:            [                <sec:authorize access="hasAuthority('C_INCOTERMS')">                ToolStripButton_Incoterms_Add,                </sec:authorize>                <sec:authorize access="hasAuthority('U_INCOTERMS')">                ToolStripButton_Incoterms_Edit,                </sec:authorize>                <sec:authorize access="hasAuthority('D_INCOTERMS')">                ToolStripButton_Incoterms_Remove,                </sec:authorize>                isc.ToolStrip.create({                    width: "100%",                    align: "left",                    border: '0px',                    members: [                        ToolStripButton_Incoterms_Refresh,                    ]                })            ]    });    var HLayout_Actions_Incoterms_ = isc.HLayout.create({        width: "100%",        members:            [                ToolStrip_Actions_Incoterms_            ]    });    var RestDataSource_Incoterms = isc.MyRestDataSource.create({        fields:            [                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},                {                    name: "code",                    title: "<spring:message code='incoterms.code'/>",                    type: 'text',                    required: true,                    width: 150,                    validators: [                    {                        type:"required",                        validateOnChange: true                    }]                },                {                    name: "works",                    title: "<spring:message code='incoterms.works'/>",                    type: 'text',                    required: true,                    width: 150,                    validators: [                    {                        type:"required",                        validateOnChange: true                    }]                },                {name: "carrier", title: "<spring:message code='incoterms.carrier'/>", type: 'checkbox', width: 150},                {                    name: "alongSideShip",                    title: "<spring:message code='incoterms.alongSideShip'/>",                    type: 'text',                    width: 150                },                {name: "arrival", title: "<spring:message code='incoterms.arrival'/>", type: 'checkbox', width: 150},                {name: "onBoard", title: "<spring:message code='incoterms.onBoard'/>", type: 'text', width: 150},                {name: "terminal", title: "<spring:message code='incoterms.terminal'/>", type: 'checkbox', width: 150},                {                    name: "destination",                    title: "<spring:message code='incoterms.destination'/>",                    type: 'text',                    width: 150                },                {                    name: "warehouse",                    title: "<spring:message code='incoterms.warehouse'/>",                    type: 'text',                    width: 150                },                {                    name: "expenses", title: "<spring:message code='incoterms.expenses'/>", valueMap: {                        "1": "<spring:message code='incoterms.works'/>",                        "2": "<spring:message code='incoterms.carrier'/>",                        "3": "<spring:message code='incoterms.alongSideShip'/>",                        "4": "<spring:message code='incoterms.onBoard'/>",                        "5": "<spring:message code='incoterms.arrival'/>",                        "6": "<spring:message code='incoterms.terminal'/>",                        "7": "<spring:message code='incoterms.destination'/>",                        "8": "<spring:message code='incoterms.warehouse'/>"                    }                },                {                    name: "namedPlace", title: "<spring:message code='incoterms.namedPlace'/>", valueMap: {                        "1": "<spring:message code='incoterms.works'/>",                        "2": "<spring:message code='incoterms.carrier'/>",                        "3": "<spring:message code='incoterms.alongSideShip'/>",                        "4": "<spring:message code='incoterms.onBoard'/>",                        "5": "<spring:message code='incoterms.arrival'/>",                        "6": "<spring:message code='incoterms.terminal'/>",                        "7": "<spring:message code='incoterms.destination'/>",                        "8": "<spring:message code='incoterms.warehouse'/>"                    }                },                {                    name: "namedPort", title: "<spring:message code='incoterms.namedPort'/>", valueMap: {                        "1": "<spring:message code='incoterms.works'/>",                        "2": "<spring:message code='incoterms.carrier'/>",                        "3": "<spring:message code='incoterms.alongSideShip'/>",                        "4": "<spring:message code='incoterms.onBoard'/>",                        "5": "<spring:message code='incoterms.arrival'/>",                        "6": "<spring:message code='incoterms.terminal'/>",                        "7": "<spring:message code='incoterms.destination'/>",                        "8": "<spring:message code='incoterms.warehouse'/>"                    }                },            ],        fetchDataURL: "${contextPath}/api/incoterms/spec-list"    });    var ListGrid_Incoterms = isc.ListGrid.create({        showFilterEditor: true,        width: "100%",        height: "100%",        dataSource: RestDataSource_Incoterms,        contextMenu: Menu_ListGrid_Incoterms,        numCols: 2,        fields:            [                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},                {                    name: "code",                    title: "<spring:message code='contactAccount.ab'/>",                    type: 'text',                    required: true,                    width: "100%",                    validators: [                    {                        type:"required",                        validateOnChange: true                    }]                },            ],        autoFetchData: true    });    var HLayout_Grid_Incoterms_ = isc.HLayout.create({        width: "100%",        height: "100%",        members:            [                ListGrid_Incoterms            ]    });    isc.VLayout.create({        width: "100%",        height: "100%",        members:            [                HLayout_Actions_Incoterms_, HLayout_Grid_Incoterms_            ]    });