<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    //*******************************************************************************
    var RestDataSource_ProvisionalInvoice = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id",                title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "refNumber",         title: "<spring:message code='provisionalInvoice.refNumber'/>", width: 200},
                {name: "refDate",           title: "<spring:message code='provisionalInvoice.refDate'/>", width: 200},
                {name: "bolNumber",         title: "<spring:message code='provisionalInvoice.bolNumber'/>", width: 200},
                {name: "switched",          title: "<spring:message code='provisionalInvoice.switched'/>", width: 200},
                {name: "from",              title: "<spring:message code='shipment.loading'/>", width: 200},
                {name: "to",                title: "<spring:message code='shipment.discharge'/>", width: 200},
                {name: "netWet",            title: "<spring:message code='provisionalInvoice.netWet'/>", width: 200},
                {name: "priceBaseFrom",     title: "<spring:message code='provisionalInvoice.priceBaseFrom'/>", width: 200},
                {name: "priceBaseTO",       title: "<spring:message code='provisionalInvoice.priceBaseTO'/>", width: 200},
                {name: "LMEcopper",         title: "<spring:message code='provisionalInvoice.LMEcopper'/>", width: 200},
                {name: "LMEsilver",         title: "<spring:message code='provisionalInvoice.LMEsilver'/>", width: 200},
                {name: "LMEgold",           title: "<spring:message code='provisionalInvoice.LMEgold'/>", width: 200},
                {name: "totalNetWet",       title: "<spring:message code='provisionalInvoice.totalNetWet'/>", width: 200},
                {name: "totalNetDry",       title: "<spring:message code='provisionalInvoice.totalNetDry'/>", width: 200},
                {name: "totalMoisture",     title: "<spring:message code='provisionalInvoice.totalMoisture'/>", width: 200},
                {name: "tblShipmentid",     title: "",   width: 200 ,   dataPath:"tblShipment.id"   },
                {name: "tblContactid",      title: "",   width: 200,    dataPath:"tblContact.id"    },
                {name: "tblBolHeaderid",    title: "",   width: 200,    dataPath:"tblBolHeader.id"  },
                {name: "tblMaterialid",     title: "",   width: 200,    dataPath:"tblMaterial.id"   },
                {name: "tblContractid",     title: "",   width: 200,    dataPath:"tblContract.id"   },
            ],
        fetchDataURL: "rest/provisionalInvoiceRestController/list"
    });
    //*******************************************************************************
 var RestDataSource_BolHeader = isc.MyRestDataSource.create({
    fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            hidden: true
        },
        {
            name: "tblShipmentid", dataPath:"tblShipment.id"  ,
            title: "id",
            canEdit: false
        },
        {
            name: "tblShipmenttblContractcontractNo", dataPath:"tblShipment.tblContract.contractNo"  ,
            title: "contractNo",
            canEdit: false,
            hidden: true
        },
        {
            name: "tblShipmentContractid",  dataPath:"tblShipmentContract.id"  ,
            title: "<spring:message code='shipment.Bol.shipmentContract'/>",
            type: 'text'
        },
        {
            name: "tblPortByDischargeid",   dataPath:"tblPortByDischarge.id" ,
            title: "<spring:message code='port.port'/>",
            type: 'text',
            canEdit: false
        },
        {
            name: "tblPortByDischargeport",  dataPath:"tblPortByDischarge.port" ,
            title: "<spring:message  code = 'shipment.Bol.tblPortByDischarge' > ", type: 'text', canEdit: false

        },
        {
            name: "tblSwitchPortid",   dataPath:"tblSwitchPort.id" ,
            title: "<spring:message code='port.port'/>",
            type: 'text',
            canEdit: false
        },
        {
            name: "tblSwitchPortport",  dataPath:"tblSwitchPort.port" ,
            title: "<spring:message code='shipment.Bol.tblSwitchPort'/>",
            type: 'text',
            canEdit: false
        },
        {
            name: "noContainer",
            title: "<spring:message code='shipment.Bol.noContainer'/>",
            type: 'text'
        },
        {
            name: "noBundle",
            title: "<spring:message code='shipment.Bol.noBundle'/>",
            type: 'text'
        },
        {
            name: "noPlate",
            title: "<spring:message code='shipment.Bol.noPlate'/>",
            type: 'text'
        },
        {
            name: "blNo",
            title: "<spring:message code='shipment.Bol.blNo'/>",
            type: 'text'
        },
        {
            name: "swBlNo",
            title: "<spring:message code='shipment.Bol.swBlNo'/>",
            type: 'text'
        },
        {
            name: "grossWeight",
            title: "<spring:message code='shipment.Bol.grossWeight'/>",
            type: 'text'
        },
        {
            name: "netWeight",
            title: "<spring:message code='shipment.Bol.netWeight'/>",
            type: 'text'
        },
        {
            name: "bolDate",
            title: "<spring:message code='shipment.Bol.bolDate'/>",
            type: 'text'
        },
    ],
    fetchDataURL: "rest/bolHeader/bolHeaderList"
});

    //*******************************************************************************
var RestDataSource_Contract = isc.MyRestDataSource.create({
    fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            hidden: true
        },
        {
            name: "addendum",
            title: "<spring:message code='contract.addendum'/>"
        },
        {
            name: "contractNo",
            title: "<spring:message code='contract.contractNo'/>"
        },
        {
            name: "contractDate",
            title: "<spring:message code='contract.contractDate'/>"
        },
        {
            name: "tblContactid",  dataPath:"tblContact.id"  ,
            title: "<spring:message code='contact.name'/> "
        },
        {
            name: "tblContactnameFA", dataPath:"tblContact.nameFA"  ,
            title: "<spring:message code='contact.name'/> "
        },
        {
            name: "tblContactBySellerAgentid", dataPath:"tblContactBySellerAgent.id"  ,
            title: "<spring:message code='contact.name'/> "
        },
        {
            name: "tblContactBySellerAgentnameFA", dataPath:"tblContactBySellerAgent.nameFA"  ,
            title: "<spring:message code='contact.name'/> "
        },
        {
            name: "tblContactByBuyerAgentid", dataPath:"tblContactByBuyerAgent.id"  ,
            title: "<spring:message code='contact.name'/> "
        },
        {
            name: "tblContactByBuyerAgentnameFA", dataPath:"tblContactByBuyerAgent.nameFA"  ,
            title: "<spring:message code='contact.name'/> "
        },
        {
            name: "tblIncotermsid", dataPath:"tblIncoterms.id"  ,
            title: "<spring:message code='incoterms.name'/>"
        },
        {
            name: "tblIncotermscode",dataPath:"tblIncoterms.code"  ,
            title: "<spring:message code='incoterms.name'/>"
        },
        {
            name: "inspectionCostPercentSource",
            title: "<spring:message code='contract.inspectionCostPercentSource'/>"
        },
        {
            name: "inspectionCostPercentDest",
            title: "<spring:message code='contract.inspectionCostPercentDest'/>"
        },
        {
            name: "descl",
            title: "<spring:message code='contract.descl'/>"
        }
    ],
    fetchDataURL: "rest/contract/list"
});
    //*******************************************************************************

    //*******************************************************************************
 var RestDataSource_Material = isc.MyRestDataSource.create({
    fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            hidden: true
        },
        {
            name: "code",
            title: "<spring:message code='goods.code'/> "
        },
        {
            name: "descl" ,
        },
        {
            name: "tblUnitid" , dataPath:"tblUnit.id"  ,
        },
        {
            name: "tblUnitnameEN" , dataPath:"tblUnit.nameEN"  ,
        },
    ],
    fetchDataURL: "rest/material/materialList"
});

    //*******************************************************************************
function ThousandSeparate1(item) {
    var V = item;
    V = V.replace(/,/g, '');
    var R = new RegExp('(-?[0-9]+)([0-9]{3})');
    while (R.test(V)) {
        V = V.replace(R, '$1,$2');
    }
    return V;
}

    function ListGrid_ProvisionalInvoice_refresh() {
        ListGrid_ProvisionalInvoice.invalidateCache();
    }

    function ListGrid_ProvisionalInvoice_edit() {
        var record = ListGrid_ProvisionalInvoice.getSelectedRecord();

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
            DynamicForm_ProvisionalInvoice.editRecord(record);
            Window_ProvisionalInvoice.show();
        }
    }

  function ListGrid_ProvisionalInvoice_remove() {

    var record = ListGrid_ProvisionalInvoice.getSelectedRecord();

    if (record == null || record.id == null) {
        isc.Dialog.create({
            message: "<spring:message code='global.grid.record.not.selected'/>",
            icon: "[SKIN]ask.png",
            title: "<spring:message code='global.message'/>",
            buttons: [isc.Button.create({
                title: "<spring:message code='global.ok'/>"
            })],
            buttonClick: function() {
                this.hide();
            }
        });
    } else {
        isc.Dialog.create({
            message: "<spring:message code='global.grid.record.remove.ask'/>",
            icon: "[SKIN]ask.png",
            title: "<spring:message code='global.grid.record.remove.ask.title'/>",
            buttons: [isc.IButtonSave.create({
                title: "<spring:message
                code = 'global.yes' / > "
            }), isc.IButtonCancel.create({
                title: "<spring:message code='global.no'/>"
            })],
            buttonClick: function(button, index) {
                this.hide();
                if (index == 0) {
                    var ProvisionalInvoiceId = record.id;
                    isc.RPCManager.sendRequest({
                        actionURL: "rest/provisionalInvoiceRestController/remove/" + ProvisionalInvoiceId,
                        httpMethod: "POST",
                        useSimpleHttp: true,
                        contentType: "application/json; charset=utf-8",
                        showPrompt: true,
                        serverOutputAsString: false,
                        callback: function(RpcResponse_o) {
                            if (RpcResponse_o.data == 'success') {
                                ListGrid_ProvisionalInvoice_refresh();
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




    var Menu_ListGrid_ProvisionalInvoice = isc.Menu.create({
    width: 150,
    data: [{
            title: "<spring:message code='global.form.refresh'/>",
            icon: "pieces/16/refresh.png",
            click: function() {
                DynamicForm_ProvisionalInvoice.clearValues();
                Window_ProvisionalInvoice.show();
            }
        },
        {
            title: "<spring:message code='global.form.new'/>",
            icon: "pieces/16/icon_add.png",
            click: function() {}
        },
        {
            title: "<spring:message code='global.form.edit'/>",
            icon: "pieces/16/icon_edit.png",
            click: function() {
                ListGrid_ProvisionalInvoice_edit();
            }
        },
        {
            title: "<spring:message code='global.form.remove'/>",
            icon: "pieces/16/icon_delete.png",
            click: function() {
                ListGrid_ProvisionalInvoice_remove();
            }
        }
    ]
});



    var DynamicForm_ProvisionalInvoice = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100",
        wrapTitle: false,
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4,
        fields:
            [
                {name: "id", hidden: true},
                {
                    name: "tblContractid",   dataPath:"tblContract.id"  ,
                    title: "<spring:message code='contract.title'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Contract,
                    displayField: "contractNo",
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1
                    ,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields:
                        [
                            {
                                name: "contractNo",
                                title: "<spring:message code='contract.contractNo'/>",
                                width: 150,
                                align: "center"
                            },
                            {
                                name: "contractDate",
                                title: "<spring:message code='contract.contractDate'/>",
                                width: 150,
                                align: "center"
                            },
                            {
                                name: "tblContactnameFA", dataPath:"tblContact.nameFA"  ,
                                title: "<spring:message code='contact.name'/>",
                                width: 200,
                                align: "center"
                            }
                        ]
                },
                {
                    name: "tblMaterialid", dataPath:"tblMaterial.id",
    title: "<spring:message code='goods.nameFa'/>",

                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Material,
                    displayField: "descl",
                    autoFetchData: false,
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1
                    ,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields:
                        [
                            {
                                name: "descl",
                                title: "<spring:message code='material.descl'/>",
                                width: 200,
                                align: "center"
                            },
                            {
                                name: "descp",
                                title: "<spring:message code='material.descp'/>",
                                width: 200,
                                align: "center"
                            },
                            {name: "code", title: "<spring:message code='material.code'/>", width: 100, align: "center"}
                        ]
                    ,
                    getPickListFilterCriteria: function () {
                        var record = DynamicForm_ProvisionalInvoice.getItem("tblContract.id").getSelectedRecord();
                        return {contractId: record.id};
                    }
                },
                {
                    name: "tblShipmentid", dataPath:"tblShipment.id"  ,
                    title: "<spring:message code='Shipment.title'/>",

                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Shipment,
                    displayField: "amount",
                    autoFetchData: false,
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1
                    ,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields:
                        [
                            {
                                name: "tblContactnameFA",  dataPath:"tblContact.nameFA"  ,
                                title: "<spring:message code='contact.name'/>",
                                width: 200,
                                align: "center"
                            },
                            {
                                name: "shipmentType",
                                title: "<spring:message code='shipment.shipmentType'/>",
                                width: 100,
                                align: "center"
                            },
                            {
                                name: "dischargeAddress",
                                title: "<spring:message code='shipment.discharge'/>",
                                width: 100,
                                align: "center"
                            },
                            {
                                name: "amount",
                                title: "<spring:message code='global.amount'/>",
                                width: 100,
                                align: "center"
                            }
                        ]
                    ,
                    getPickListFilterCriteria: function () {
                        var recordCon = DynamicForm_ProvisionalInvoice.getItem("tblContract.id").getSelectedRecord();
                        var recordMat = DynamicForm_ProvisionalInvoice.getItem("tblMaterial.id").getSelectedRecord();
                        return {contractId: recordCon.id, materialId: recordMat.id};
                    }
                },
                {
                    name: "tblBolHeaderid", dataPath:"tblBolHeader.id"  ,
                    title: "<spring:message code='bol.title'/>",

                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_BolHeader,
                    displayField: "blNo",
                    autoFetchData: false,
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1
                    ,
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields:
                        [
                            {
                                name: "blNo",
                                title: "<spring:message code='shipment.Bol.blNo'/>",
                                width: 200,
                                align: "center"
                            },
                            {
                                name: "swBlNo",
                                title: "<spring:message code='shipment.Bol.swBlNo'/>",
                                width: 200,
                                align: "center"
                            },
                            {
                                name: "bolDate",
                                title: "<spring:message code='shipment.Bol.bolDate'/>",
                                width: 100,
                                align: "center"
                            }
                        ]
                    ,
                    getPickListFilterCriteria: function () {
                        var recordSh = DynamicForm_ProvisionalInvoice.getItem("tblShipment.id").getSelectedRecord();
                        return {shipmentId: recordSh.id};
                    }
                    ,
                    changed: function () {
                        var record = DynamicForm_ProvisionalInvoice.getItem("tblBolHeader.id").getSelectedRecord();
                        var totalNetDry = "";
                        totalNetDry = record.netWeight - record.grossWeight;
                        DynamicForm_ProvisionalInvoice.setValue("bolNumber", record.blNo);
                        DynamicForm_ProvisionalInvoice.setValue("switched", record.swBlNo);
                        DynamicForm_ProvisionalInvoice.setValue("from", record.tblSwitchPort.port);
                        DynamicForm_ProvisionalInvoice.setValue("to", record.tblPortByDischarge.port);
                        DynamicForm_ProvisionalInvoice.setValue("netWet", (record.netWeight));
                        DynamicForm_ProvisionalInvoice.setValue("totalNetWet", (record.netWeight));
                        DynamicForm_ProvisionalInvoice.setValue("totalNetDry", totalNetDry);
                        DynamicForm_ProvisionalInvoice.setValue("totalMoisture", (record.grossWeight));
                    }
                },
                {
                    name: "refNumber", title: "<spring:message code='provisionalInvoice.refNumber'/>", width: "100%", colSpan: 1, wrapTitle: false, titleColSpan: 1

                },
                {
                    name: "refDate", ID: "refDate", title: "<spring:message code='provisionalInvoice.refDate'/>", width: "100%", colSpan: 1, wrapTitle: false, titleColSpan: 1
                    , icons: [{
                        src: "pieces/pcal.png", click: function () {
                            displayDatePicker('refDate', this, 'ymd', '/');
                        }
                    }]

                    , blur: function () {
                        var value = DynamicForm_ProvisionalInvoice.getItem('refDate').getValue();
                        if (value != null && value.length != 10 && value != "") {
                            DynamicForm_ProvisionalInvoice.setValue('refDate', CorrectDate(value))
                        }
                    }
                },
                {
                    name: "bolNumber", title: "<spring:message
		code='provisionalInvoice.bolNumber'/>", width: "100%", colSpan: 1, wrapTitle: false, titleColSpan: 1
                },
                {
                    name: "switched", title: "<spring:message
		code='provisionalInvoice.switched'/>", width: "100%", colSpan: 1, wrapTitle: false, titleColSpan: 1
                },
                {
                    name: "from", title: "<spring:message
		code='shipment.loading'/>", width: "100%", colSpan: 1, wrapTitle: false, titleColSpan: 1
                },
                {
                    name: "to", title: "<spring:message
		code='shipment.discharge'/>", width: "100%", colSpan: 1, wrapTitle: false, titleColSpan: 1
                },
                {
                    name: "netWet", title: "<spring:message
		code='provisionalInvoice.netWet'/>", width: "100%", colSpan: 1, wrapTitle: false, titleColSpan: 1

                },
                {
                    name: "priceBaseFrom", title: "<spring:message
		code='provisionalInvoice.priceBaseFrom'/>", width: "100%", colSpan: 1, wrapTitle: false, titleColSpan: 1
                },
                {
                    name: "priceBaseTO", title: "<spring:message
		code='provisionalInvoice.priceBaseTO'/>", width: "100%", colSpan: 1, wrapTitle: false, titleColSpan: 1
                },
                {
                    name: "LMEcopper",
                    title: "<spring:message
		code='provisionalInvoice.LMEcopper'/>",
                    width: "100%",
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1,
                    required: true
                },
                {
                    name: "LMEsilver",
                    title: "<spring:message
		code='provisionalInvoice.LMEsilver'/>",
                    width: "100%",
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1,
                    required: true
                },
                {
                    name: "LMEgold",
                    title: "<spring:message
		code='provisionalInvoice.LMEgold'/>",
                    width: "100%",
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1,
                    required: true
                },
                {
                    name: "totalNetWet",
                    title: "<spring:message
		code='provisionalInvoice.totalNetWet'/>",
                    width: "100%",
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1,
                    required: true
                },
                {
                    name: "totalNetDry",
                    title: "<spring:message
		code='provisionalInvoice.totalNetDry'/>",
                    width: "100%",
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1,
                    required: true
                },
                {
                    name: "totalMoisture",
                    title: "<spring:message
		code='provisionalInvoice.totalMoisture'/>",
                    width: "100%",
                    colSpan: 1,
                    wrapTitle: false,
                    titleColSpan: 1,
                    required: true
                },
            ]
    });

    var ToolStripButton_ProvisionalInvoice_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ProvisionalInvoice_refresh();
        }
    });

    var ToolStripButton_ProvisionalInvoice_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_ProvisionalInvoice.clearValues();
            Window_ProvisionalInvoice.show();
        }
    });

    var ToolStripButton_ProvisionalInvoice_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ProvisionalInvoice_edit();
        }
    });

    var ToolStripButton_ProvisionalInvoice_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ProvisionalInvoice_remove();
        }
    });

    var ToolStrip_Actions_ProvisionalInvoice = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_ProvisionalInvoice_Refresh,
                ToolStripButton_ProvisionalInvoice_Add,
                ToolStripButton_ProvisionalInvoice_Edit,
                ToolStripButton_ProvisionalInvoice_Remove
            ]
    });

    var HLayout_ProvisionalInvoice_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_ProvisionalInvoice
            ]
    });



    var IButton_ProvisionalInvoice_Save = isc.IButtonSave.create({
    top: 260,
    title: "<spring:message code='global.form.save'/>",
    icon: "pieces/16/save.png",
    click: function() {
        DynamicForm_ProvisionalInvoice.validate();
        if (DynamicForm_ProvisionalInvoice.hasErrors())
            return;
        var shipment = DynamicForm_ProvisionalInvoice.getItem("tblShipment.id").getSelectedRecord();
        var contract = DynamicForm_ProvisionalInvoice.getItem("tblContract.id").getSelectedRecord();
        var material = DynamicForm_ProvisionalInvoice.getItem("tblMaterial.id").getSelectedRecord();
        var data = DynamicForm_ProvisionalInvoice.getValues();
        isc.RPCManager.sendRequest({
            actionURL: "rest/provisionalInvoiceRestController/add/" + shipment.id + "/" + contract.id + "/" + material.id,
            httpMethod: "POST",
            useSimpleHttp: true,
            contentType: "application/json; charset=utf-8",
            showPrompt: false,
            data: JSON.stringify(data),
            serverOutputAsString: false,
            //params: { data:data1},
            callback: function(RpcResponse_o) {
                if (RpcResponse_o.data == 'success') {
                    isc.say("<spring:message code='global.form.request.successful'/>.");
                    ListGrid_ProvisionalInvoice_refresh();
                    Window_ProvisionalInvoice.close();
                } else
                    isc.say(RpcResponse_o.data);
            }
        });
    }
});


    <%--var IButton_ProvisionalInvoice_Calcute = isc.IButtonSave.create({
        top: 260,
        title:"<spring:message code='global.form.calcute'/>",
        icon: "pieces/16/save.png",
        click : function ()
        {
            DynamicForm_ProvisionalInvoice.validate();
            if (DynamicForm_ProvisionalInvoice.hasErrors())
            return;
            var shipment = DynamicForm_ProvisionalInvoice.getItem("tblShipment.id").getSelectedRecord();
            var contract = DynamicForm_ProvisionalInvoice.getItem("tblContract.id").getSelectedRecord();
            var material = DynamicForm_ProvisionalInvoice.getItem("tblMaterial.id").getSelectedRecord();
            var data = DynamicForm_ProvisionalInvoice.getValues();
            isc.RPCManager.sendRequest({
            actionURL: "rest/provisionalInvoiceRestController/add/"+shipment.id + "/" + contract.id+"/"+material.id,
            httpMethod: "POST",
            useSimpleHttp: true,
            contentType: "application/json; charset=utf-8",
            showPrompt:false,
            data: JSON.stringify(data),
            serverOutputAsString: false,
            //params: { data:data1},
            callback: function (RpcResponse_o)
            {
                if(RpcResponse_o.data == 'success')
                {
                    isc.say("<spring:message code='global.form.request.successful'/>.");
                    ListGrid_ProvisionalInvoice_refresh();
                    Window_ProvisionalInvoice.close();
                }
                else
                  isc.say(RpcResponse_o.data);
            }
            });
        }
    });--%>

var Window_ProvisionalInvoice = isc.Window.create({
    title: "<spring:message code='provisionalInvoice.tilte'/> ",
    width: 780,
    height: 900,
    autoSize: true,
    autoCenter: true,
    isModal: true,
    showModalMask: true,
    align: "center",
    autoDraw: false,
    dismissOnEscape: true,
    closeClick: function() {
        this.Super("closeClick", arguments)
    },
    items: [
        DynamicForm_ProvisionalInvoice,
        isc.HLayout.create({
            width: "100%",
            members: [
                IButton_ProvisionalInvoice_Save,
                isc.Label.create({
                    width: 5,
                }),
                /* IButton_ProvisionalInvoice_Calcute,
                isc.Label.create({
                width: 5,
                }),*/
                isc.IButtonCancel.create({
                    ID: "provisionalInvoiceEditExitIButton",
                    title: "<spring:message code='global.cancel'/>",
                    width: 100,
                    icon: "pieces/16/icon_delete.png",
                    orientation: "vertical",
                    click: function() {
                        Window_ProvisionalInvoice.close();
                    }
                })
            ]
        })
    ]
});

    var ListGrid_ProvisionalInvoice = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ProvisionalInvoice,
        contextMenu: Menu_ListGrid_ProvisionalInvoice,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "provisionalInvoice", title: "<spring:message code='provisionalInvoice.tilte'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "refNumber", title: "<spring:message 	code='provisionalInvoice.refNumber'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "refDate", title: "<spring:message 		code='provisionalInvoice.refDate'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "bolNumber", title: "<spring:message code='provisionalInvoice.bolNumber'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "switched", title: "<spring:message 	code='provisionalInvoice.switched'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "from", title: "<spring:message code='shipment.loading'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "to", title: "<spring:message code='shipment.discharge'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "priceBaseFrom", title: "<spring:message 	code='provisionalInvoice.priceBaseFrom'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "priceBaseTO", title: "<spring:message code='provisionalInvoice.priceBaseTO'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "LMEcopper", title: "<spring:message code='provisionalInvoice.LMEcopper'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "LMEsilver", title: "<spring:message code='provisionalInvoice.LMEsilver'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "LMEgold", title: "<spring:message code='provisionalInvoice.LMEgold'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "totalNetWet", title: "<spring:message code='provisionalInvoice.totalNetWet'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "totalNetDry", title: "<spring:message code='provisionalInvoice.totalNetDry'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                },
                {
                    name: "totalMoisture", title: "<spring:message code='provisionalInvoice.totalMoisture'/>", width: "100%", colSpan: 1, titleColSpan: 1, align: "center"

                }
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        },
        dataArrived: function (startRow, endRow) {
        }

    });



var HLayout_ProvisionalInvoice_Grid = isc.HLayout.create({
    width: "100%",
    height: "100%",
    members: [
        ListGrid_ProvisionalInvoice
    ]
});

var VLayout_ProvisionalInvoice_Body = isc.VLayout.create({
    width: "100%",
    height: "100%",
    members: [
        HLayout_ProvisionalInvoice_Actions, HLayout_ProvisionalInvoice_Grid
    ]
});