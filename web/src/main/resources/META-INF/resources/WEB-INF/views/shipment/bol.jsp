<%@ page import="com.nicico.core.copper.config.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <% DateUtil dateUtil = new DateUtil();%>

    var RestDataSource_BolHeader = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "tblShipment.id", title: "id", canEdit: false},
                {name: "tblShipment.tblContract.contractNo", title: "contractNo", canEdit: false, hidden: true},
                {
                    name: "tblShipmentContract.id",
                    title: "<spring:message code='shipment.Bol.shipmentContract'/>",
                    type: 'text'
                },
                {
                    name: "tblPortByDischarge.id",
                    title: "<spring:message code='port.port'/>",
                    type: 'text',
                    canEdit: false
                },
                {
                    name: "tblPortByDischarge.port", title: "<spring:message
		code='shipment.Bol.tblPortByDischarge'/>", type: 'text', canEdit: false
                },
                {name: "tblSwitchPort.id", title: "<spring:message code='port.port'/>", type: 'text', canEdit: false},
                {
                    name: "tblSwitchPort.port",
                    title: "<spring:message code='shipment.Bol.tblSwitchPort'/>",
                    type: 'text',
                    canEdit: false
                },
                {name: "noContainer", title: "<spring:message code='shipment.Bol.noContainer'/>", type: 'text'},
                {name: "noBundle", title: "<spring:message code='shipment.Bol.noBundle'/>", type: 'text'},
                {name: "noPlate", title: "<spring:message code='shipment.Bol.noPlate'/>", type: 'text'},
                {name: "blNo", title: "<spring:message code='shipment.Bol.blNo'/>", type: 'text'},
                {name: "swBlNo", title: "<spring:message code='shipment.Bol.swBlNo'/>", type: 'text'},
                {name: "grossWeight", title: "<spring:message code='shipment.Bol.grossWeight'/>", type: 'text'},
                {name: "netWeight", title: "<spring:message code='shipment.Bol.netWeight'/>", type: 'text'},
                {name: "bolDate", title: "<spring:message code='shipment.Bol.bolDate'/>", type: 'text'},
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/bolHeader/list"
    });

    var RestDataSource_BolItem = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "tblBolHeader.id", title: "id", canEdit: false, hidden: true},
                {name: "containerType", title: "<spring:message code='shipment.Bol.containerType'/>", type: 'text'},
                {
                    name: "containerNo",
                    title: "<spring:message code='shipment.Bol.containerNo'/>"
                    ,
                    type: 'ineger',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "sealNo", title: "<spring:message code='shipment.Bol.sealNo'/>", type: 'text'},
                {name: "seal2No", title: "<spring:message code='shipment.Bol.seal2No'/>", type: 'text'},
                {
                    name: "noPalete",
                    title: "<spring:message code='shipment.Bol.noPalete'/>"
                    ,
                    type: 'ineger',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "noBundle",
                    title: "<spring:message code='shipment.Bol.noBundle'/>"
                    ,
                    type: 'ineger',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "grossWeight",
                    title: "<spring:message code='shipment.Bol.grossWeight'/>"
                    ,
                    type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "netWeight",
                    title: "<spring:message code='shipment.Bol.netWeight'/>"
                    ,
                    type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/bolItem/list"
    });

    var RestDataSource_Contact = isc.RestDataSource.create({
        fields: [
            {name: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='contact.code'/>"},
            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
            {name: "tradeMark"},
            {name: "ceoPassportNo"},
            {name: "ceo"},
            {name: "commercialRegistration"},
            {name: "branchName"},
            {name: "commertialRole"},
            {name: "phone", title: "<spring:message code='contact.phone'/>"},
            {name: "mobile", title: "<spring:message code='contact.mobile'/>"},
            {name: "fax", title: "<spring:message code='contact.fax'/>"},
            {name: "address", title: "<spring:message code='contact.address'/>"},
            {name: "webSite", title: "<spring:message code='contact.webSite'/>"},
            {name: "email", title: "<spring:message code='contact.email'/>"},
            {
                name: "type",
                title: "<spring:message code='contact.type'/>",
                valueMap: {
                    "true": "<spring:message code='contact.type.real'/>",
                    "false": "<spring:message code='contact.type.legal'/>"
                }
            },
            {name: "nationalCode", title: "<spring:message code='contact.nationalCode'/>"},
            {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
            {name: "bankAccount", title: "<spring:message code='contact.bankAccount'/>"},
            {name: "bankShaba", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "bankSwift", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "bankName", title: "<spring:message code='contact.bankName'/>"},
            <%--{name: "tblBank.id", title:"<spring:message code='global.country'/>", type:'long' , width: 400,editorType: "SelectItem"--%>
            <%--, optionDataSource:RestDataSource_Country ,displayField:"nameFa"--%>
            <%--, valueField:"id" ,pickListWidth:"300",pickListHeight:"500" ,pickListProperties: {showFilterEditor:true}--%>
            <%--,pickListFields:[{name:"nameFa",width:150,align:"center"},{name:"code",width:150,align:"center"}] --%>
            <%--},--%>
            {
                name: "status",
                title: "<spring:message code='contact.status'/>",
                valueMap: {"true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"}
            },
            {name: "contactAccounts"}
        ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/contact/list"
    });
    //---------------------------------------------------------------------------------
    var RestDataSource_ShipmentByBolHeader = isc.RestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {
                name: "tblContractItemShipment.id",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true
            },
            {name: "tblContact.id", type: 'long', hidden: true},
            {name: "tblContact.nameFA", title: "<spring:message code='contact.name'/>", type: 'text'},
            {name: "tblContract.id", type: 'long', hidden: true},
            {
                name: "tblContract.contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: 180
            },
            {
                name: "tblContract.contractDate",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: 180
            },
            {name: "tblMaterial.id", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "tblMaterial.descl", title: "<spring:message code='material.descl'/>", type: 'text'},
            {name: "tblMaterial.tblUnit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {
                name: "laycan", title: "<spring:message
		code='shipmentContract.laycanStart'/>", type: 'integer', width: "10%", align: "center",
            },
            {
                name: "shipmentType", title: "<spring:message
		code='shipment.shipmentType'/>", type: 'text', width: 400, valueMap: {"b": "bulk", "c": "container"}
            },
            {name: "loading", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {
                name: "tblPortByLoading.id", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%"
            },
            {
                name: "tblPortByLoading.port", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%"
            },
            {
                name: "tblPortByDischarge.id", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%"
            },
            {
                name: "tblPortByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%"
            },
            {
                name: "dischargeAddress",
                title: "<spring:message code='global.address'/>",
                type: 'text',
                required: true,
                width: "10%"
            },
            {
                name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%"
            },
            {name: "SWB", title: "<spring:message code='shipment.SWB'/>", type: 'text', required: true, width: "10%"},
            {
                name: "tblSwitchPort.port", title: "<spring:message
		code='port.switchPort'/>", type: 'text', required: true, width: "10%"
            },
            {
                name: "month",
                title: "<spring:message code='shipment.month'/>",
                type: 'text',
                required: true,
                width: "10%"
            },
            {
                name: "status", title: "<spring:message
		code='shipment.staus'/>", type: 'text', width: "10%", valueMap: {
                    "Load Ready": "<spring:message
		code='shipment.loadReady'/>", "Resource": "<spring:message code='shipment.resource'/>"
                }
            },
            {
                name: "createDate",
                title: "<spring:message code='shipment.createDate'/>",
                type: 'text',
                required: true,
                width: "10%"
            },
        ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/shipment/list"
    });

    var BolItemData = [];
    for (i = 0; i < 100; i++) {
        BolItemData.add({id: i});
    }

    var ClientDataSource_BolItem = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "tblBolHeader.id", title: "id", canEdit: false, hidden: true},
                {name: "containerType", title: "<spring:message code='shipment.Bol.containerType'/>", type: 'text'},
                {
                    name: "containerNo",
                    title: "<spring:message code='shipment.Bol.containerNo'/>"
                    ,
                    type: 'ineger',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "sealNo", title: "<spring:message code='shipment.Bol.sealNo'/>", type: 'text'},
                {name: "seal2No", title: "<spring:message code='shipment.Bol.seal2No'/>", type: 'text'},
                {
                    name: "noPalete",
                    title: "<spring:message code='shipment.Bol.noPalete'/>"
                    ,
                    type: 'ineger',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "noBundle",
                    title: "<spring:message code='shipment.Bol.noBundle'/>"
                    ,
                    type: 'ineger',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "grossWeight",
                    title: "<spring:message code='shipment.Bol.grossWeight'/>"
                    ,
                    type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "netWeight",
                    title: "<spring:message code='shipment.Bol.netWeight'/>"
                    ,
                    type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ],
        testData: BolItemData,
        clientOnly: true
    });

    /* ****************** */

    function pasteText(text) {
        var fieldNames = [];
        ListGrid_BolItemPaste.selectAllRecords();
        for (var col = 0; col < 13; col++) {
            fieldNames.add(ListGrid_BolItemPaste.getFieldName(col));
        }
        var settings = {
            fieldList: fieldNames,
            fieldSeparator: "\t",
            escapingMode: "double"
        };
        var dataSource = ListGrid_BolItemPaste.dataSource;
        var records = dataSource.recordsFromText(text, settings);
        ListGrid_BolItemPaste.applyRecordData(records);
    }


    function createPasteDialog() {
        var record = ListGrid_BolHeader.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
                buttonClick: function () {
                    hide();
                }
            });
            return;
        }
        var BolHeaderId = record.id;
        var PasteDialogBolItem_windows = isc.Window.create({
            title: "Import From Excle",
            autoSize: false,
            width: "100%",
            height: "70%",
            isModal: true,
            showModalMask: true,
            showMaximizeButton: true,
            canDragResize: true,
            autoCenter: true,
            closeClick: function () {
                this.Super("closeClick", arguments);
            },
            items: [
                isc.HLayout.create({
                    membersMargin: 3,
                    width: "100%",
                    alignLayout: "center",
                    members: [

                        isc.DynamicForm.create({
                            ID: "resultsForm",
                            numCols: 6,
                            width: 600,
                            height: 300,
                            autoFocus: true,
                            fields: [
                                {
                                    type: "text",
                                    name: "guidance",
                                    colSpan: 6,
                                    showTitle: false,
                                    editorType: "StaticTextItem",
                                    value: "Press Ctrl-V (\u2318V on Mac) or right click (Control-click on Mac) to paste values, then click \"Apply\"."
                                },
                                {
                                    type: "text",
                                    name: "textArea",
                                    canEdit: true,
                                    colSpan: 6,
                                    showTitle: false,
                                    height: "*",
                                    width: "*",
                                    editorType: "TextAreaItem"
                                },
                                {
                                    type: "text", name: "apply", editorType: "ButtonItem", title: "Apply",
                                    click: function (form) {
                                        pasteText(form.getValue("textArea"));
                                        ListGrid_BolItemPaste.saveAllEdits();
                                    }
                                }
                            ]


                        }) /* dynamic Form */
                        , ListGrid_BolItemPaste = isc.ListGrid.create({
                            dataSource: ClientDataSource_BolItem,
                            sortDirection: "descending",
                            width: "100%",
                            height: "90%",
                            canEdit: true,
                            autoFetchData: true,
                            canDragSelect: true,
                            canSelectCells: true,
                            autoSaveData: true,
                            fields: [
                                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                                {name: "tblBolHeader.id", title: "id", canEdit: false, hidden: true},
                                {
                                    name: "containerType",
                                    title: "<spring:message code='shipment.Bol.containerType'/>",
                                    type: 'text',
                                    align: "center"
                                },
                                {
                                    name: "containerNo",
                                    title: "<spring:message code='shipment.Bol.containerNo'/>",
                                    align: "center"
                                    ,
                                    type: 'ineger',
                                    validators: [{
                                        type: "isFloat",
                                        validateOnExit: true,
                                        stopOnError: true,
                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                    }]
                                },
                                {
                                    name: "sealNo",
                                    title: "<spring:message code='shipment.Bol.sealNo'/>",
                                    type: 'text',
                                    align: "center"
                                },
                                {
                                    name: "seal2No",
                                    title: "<spring:message code='shipment.Bol.seal2No'/>",
                                    type: 'text',
                                    align: "center"
                                },
                                {
                                    name: "noPalete",
                                    title: "<spring:message code='shipment.Bol.noPalete'/>",
                                    align: "center"
                                    ,
                                    type: 'ineger',
                                    validators: [{
                                        type: "isFloat",
                                        validateOnExit: true,
                                        stopOnError: true,
                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                    }]
                                },
                                {
                                    name: "noBundle",
                                    title: "<spring:message code='shipment.Bol.noBundle'/>",
                                    align: "center"
                                    ,
                                    type: 'ineger',
                                    validators: [{
                                        type: "isFloat",
                                        validateOnExit: true,
                                        stopOnError: true,
                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                    }]
                                },
                                {
                                    name: "grossWeight",
                                    title: "<spring:message code='shipment.Bol.grossWeight'/>",
                                    align: "center"
                                    ,
                                    type: 'float',
                                    validators: [{
                                        type: "isFloat",
                                        validateOnExit: true,
                                        stopOnError: true,
                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                    }]
                                },
                                {
                                    name: "netWeight",
                                    title: "<spring:message code='shipment.Bol.netWeight'/>",
                                    align: "center"
                                    ,
                                    type: 'float',
                                    validators: [{
                                        type: "isFloat",
                                        validateOnExit: true,
                                        stopOnError: true,
                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                    }]
                                },
                            ]
                        })

                    ]
                }),
                isc.ToolStripButton.create({
                    title: "<spring:message code='global.form.save'/>",
                    icon: "pieces/16/save.png",
                    click: function () {
                        resultsForm.validate();
                        if (resultsForm.hasErrors())
                            return;
                        var selected = ListGrid_BolItemPaste.getSelection();

                        resultsForm.setValue("selected", selected);

                        resultsForm.setValue("BolHeaderId", BolHeaderId);
                        var data = resultsForm.getValues();

                        isc.RPCManager.sendRequest({
                            actionURL: "rest/bolItem/addBolPaste",
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: false,
                            data: JSON.stringify(data),
                            serverOutputAsString: false,
//params: { data:data1},
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    isc.say("<spring:message code='global.form.request.successful'/>.");
                                    ListGrid_BolItem_refresh();
                                    PasteDialogBolItem_windows.close();
                                } else
                                    isc.say(RpcResponse_o.data);
                            }
                        });
                    }
                })

            ]
        });
        /* windows*/


    }

    /* ****************** */
    var ToolStripButton_BolItem_Paste = isc.ToolStripButton.create({
        icon: "[SKIN]/RichTextEditor/paste.png",
        title: "Paste Cells",
        click: function () {
            createPasteDialog();
        }
    });

    var ListGrid_ShipmentByBolHeader = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentByBolHeader,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "tblContractItemShipment.id", hidden: true, type: 'long', align: "center"},
            {
                name: "tblContractItemShipment.tblContractItem.tblContract.id",
                type: 'long',
                hidden: true,
                align: "center"
            },
            {name: "tblContact.id", type: 'long', hidden: true},
            {
                name: "tblContact.nameFA", title: "<spring:message
		code='contact.name'/>", type: 'text', width: "20%", align: "center", showHover: true
            },
            {name: "tblContract.id", type: 'long', hidden: true},
            {
                name: "tblContract.contractNo", title: "<spring:message
		code='contract.contractNo'/>", type: 'text', width: "10%", showHover: true, align: "center"
            },
            {
                name: "tblContract.contractDate", title: "<spring:message
		code='contract.contractDate'/>", type: 'text', width: "10%", showHover: true, align: "center"
            },
            {
                name: "tblMaterial.id", title: "<spring:message
		code='contact.name'/>", type: 'long', hidden: true, showHover: true, align: "center"
            },
            {
                name: "tblMaterial.descl", title: "<spring:message
		code='material.descl'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "tblMaterial.tblUnit.nameEN", title: "<spring:message
		code='unit.nameEN'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "amount", title: "<spring:message
		code='global.amount'/>", type: 'float', width: "10%", align: "center", showHover: true
            },
            {
                name: "shipmentType",
                title: "<spring:message
		code='shipment.shipmentType'/>",
                type: 'text',
                width: "10%",
                valueMap: {"b": "bulk", "c": "container"},
                showHover: true,
                align: "center"
            },
            {
                name: "noContainer", title: "<spring:message
		code='shipment.noContainer'/>", type: 'integer', width: "10%", align: "center", showHover: true
            },
            {
                name: "laycan", title: "<spring:message
		code='shipmentContract.laycanStart'/>", type: 'integer', width: "10%", align: "center", showHover: true
            },
            {
                name: "tblPortByLoading.port", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%", showHover: true, align: "center"
            },
            {
                name: "tblPortByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%", showHover: true, align: "center"
            },
            {
                name: "dischargeAddress", title: "<spring:message
		code='global.address'/>", type: 'text', required: true, width: "10%", showHover: true, align: "center"
            },
            {
                name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "month", title: "<spring:message
		code='shipment.month'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "SWB", title: "<spring:message
		code='shipment.SWB'/>", type: 'text', required: true, width: "10%", showHover: true, align: "center"
            },
            {
                name: "tblSwitchPort.port", title: "<spring:message
		code='port.switchPort'/>", type: 'text', required: true, width: "10%", showHover: true, align: "center"
            },
            {
                name: "status", title: "<spring:message
		code='shipment.staus'/>", type: 'text', width: "10%", align: "center", valueMap: {
                    "Load Ready": "<spring:message
		code='shipment.loadReady'/>", "Resource": "<spring:message code='shipment.resource'/>"
                }, showHover: true
            },
        ],
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            ListGrid_BolHeader.fetchData({"tblShipment.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_BolHeader.setData(data);
            });
        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt"
    });
    var HLayout_Grid_ShipmentByBolHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentByBolHeader
        ]
    });

    var VLayout_Body_ShipmentByBolHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_ShipmentByBolHeader
        ]
    });
    //---------------------------------------------------------------------------------
    var Menu_ListGrid_BolHeader = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_BolHeader_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_BolHeader.clearValues();
                    Window_BolHeader.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_BolHeader_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_BolHeader_remove();
                }
            }
        ]
    });

    var ValuesManager_BolHeader = isc.ValuesManager.create({});

    var DynamicForm_BolHeader = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        cellPadding: 2,
        numCols: 4,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "tblShipment.id", title: "id", canEdit: false, hidden: true},
                {
                    name: "tblShipmentContract.id",
                    title: "<spring:message code='shipment.Bol.shipmentContract'/>",
                    type: 'text'
                },
                {
                    name: "tblPortByDischarge.id",
                    title: "<spring:message code='shipment.Bol.tblPortByDischarge'/>",
                    type: 'text'
                },
                {name: "tblSwitchPort.id", title: "<spring:message code='shipment.Bol.tblSwitchPort'/>", type: 'text'},
                {
                    name: "noContainer",
                    title: "<spring:message code='shipment.Bol.noContainer'/>",
                    type: 'integer',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "noBundle",
                    title: "<spring:message code='shipment.Bol.noBundle'/>",
                    type: 'integer',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "noPlate",
                    title: "<spring:message code='shipment.Bol.noPlate'/>",
                    type: 'integer',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "blNo", title: "<spring:message code='shipment.Bol.blNo'/>", type: 'text'},
                {name: "swBlNo", title: "<spring:message code='shipment.Bol.swBlNo'/>", type: 'text'},
                {
                    name: "grossWeight",
                    title: "<spring:message code='shipment.Bol.grossWeight'/>",
                    type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "netWeight",
                    title: "<spring:message code='shipment.Bol.netWeight'/>",
                    type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },

                {
                    name: "bolDate",
                    title: "<spring:message code='shipment.Bol.inspectionDate'/>",
                    type: 'text',
                    hidden: true
                },
                {name: "bolDateDummy", title: "<spring:message code='shipment.Bol.inspectionDate'/>", type: 'date'},
            ]
    });
    var IButton_Shipment_Save_BolHeader = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {

            var d = DynamicForm_BolHeader.getValue("bolDateDummy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2));
            DynamicForm_BolHeader.setValue("bolDate", datestring);

            DynamicForm_BolHeader.validate();
            if (DynamicForm_BolHeader.hasErrors()) {
                return;
            }

            var record = ListGrid_ShipmentByBolHeader.getSelectedRecord();
            DynamicForm_BolHeader.setValue("tblShipment.id", record.id);

            var data = DynamicForm_BolHeader.getValues();

            isc.RPCManager.sendRequest({
                actionURL: "rest/bolHeader/add",
                httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
//params: { data:data1},
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.data == 'success') {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_BolHeader_refresh();
                        Window_BolHeader.close();
                    } else {
                        isc.say(RpcResponse_o.data);
                    }
                }
            });
        }
    });
    var Window_BolHeader = isc.Window.create({
        title: "<spring:message code='shipment.BolHeader'/>",
        width: "28%",
        height: "30%",
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        margin: '10px',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            DynamicForm_BolHeader,
            IButton_Shipment_Save_BolHeader
        ]
    });

    function ListGrid_BolHeader_refresh() {
        ListGrid_BolHeader.invalidateCache();
        var record = ListGrid_ShipmentByBolHeader.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        ListGrid_BolHeader.fetchData({"tblShipment.id": record.id}, function (dsResponse, data, dsRequest) {
            ListGrid_BolHeader.setData(data);
        });
    };

    function ListGrid_BolHeader_remove() {
        var record = ListGrid_BolHeader.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
                buttonClick: function () {
                    hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [isc.Button.create({
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {

                        var shipmentId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "rest/bolHeader/remove/" + shipmentId,
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
// data: shipmentId,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    ListGrid_BolHeader.invalidateCache();
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

    function ListGrid_BolHeader_edit() {

        var record = ListGrid_BolHeader.getSelectedRecord();

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
            DynamicForm_BolHeader.editRecord(record);
            DynamicForm_BolHeader.setValue("bolDateDummy", new Date(record.bolDate));
            Window_BolHeader.show();
        }
    };
    var ToolStripButton_BolHeader_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_BolHeader_refresh();
        }
    });
    var ToolStripButton_BolHeader_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {

            var record = ListGrid_ShipmentByBolHeader.getSelectedRecord();

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
                DynamicForm_BolHeader.clearValues();
                Window_BolHeader.show();
            }
        }
    });
    var ToolStripButton_BolHeader_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            var record = ListGrid_BolHeader.getSelectedRecord();
            if (record.tblShipment != null) {
                ListGrid_BolHeader_edit();
            }
        }
    });
    var ToolStripButton_BolHeader_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_BolHeader_remove();
        }
    });
    var ToolStripButton_BolHeader_Print = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/print.png",
        title: "<spring:message code='global.form.print'/>",
        click: function () {
            var record = ListGrid_BolHeader.getSelectedRecord();

        }
    });
    var ToolStrip_Actions_BolHeader = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_BolHeader_Refresh,
            ToolStripButton_BolHeader_Add,
            ToolStripButton_BolHeader_Edit,
            ToolStripButton_BolHeader_Remove,
            ToolStripButton_BolHeader_Print,
        ]
    });

    var HLayout_Actions_BolHeader = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_BolHeader
        ]
    });

    var ListGrid_BolHeader = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_BolHeader,
        contextMenu: Menu_ListGrid_BolHeader,
        autoFetchData: false,
        fields: [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "tblShipment.id", title: "id", canEdit: false},
            {name: "tblShipment.tblContract.contractNo", title: "contractNo", canEdit: false, hidden: true},
            {
                name: "tblShipmentContract.id", title: "<spring:message
		code='shipment.Bol.shipmentContract'/>", type: 'text', hidden: true
            },
            {
                name: "tblShipmentContract.nameFA", title: "<spring:message
		code='shipmentContract.owners'/>", align: "center", width: "10%"
            },
            {name: "tblPortByDischarge.id", title: "<spring:message code='port.port'/>", type: 'text', hidden: true},
            {
                name: "tblPortByDischarge.port", title: "<spring:message
		code='shipment.Bol.tblPortByDischarge'/>", type: 'text', canEdit: false, align: "center"
            },
            {
                name: "tblSwitchPort.id",
                title: "<spring:message code='port.port'/>",
                type: 'text',
                canEdit: false,
                hidden: true
            },
            {
                name: "tblSwitchPort.port", title: "<spring:message
		code='shipment.Bol.tblSwitchPort'/>", type: 'text', canEdit: false, align: "center"
            },
            {
                name: "noContainer",
                title: "<spring:message code='shipment.Bol.noContainer'/>",
                type: 'text',
                align: "center"
            },
            {name: "noBundle", title: "<spring:message code='shipment.Bol.noBundle'/>", type: 'text', align: "center"},
            {name: "noPlate", title: "<spring:message code='shipment.Bol.noPlate'/>", type: 'text', align: "center"},
            {name: "blNo", title: "<spring:message code='shipment.Bol.blNo'/>", type: 'text', align: "center"},
            {name: "bolDate", title: "<spring:message code='shipment.Bol.bolDate'/>", type: 'text'},
            {name: "swBlNo", title: "<spring:message code='shipment.Bol.swBlNo'/>", type: 'text', align: "center"},
            {
                name: "grossWeight",
                title: "<spring:message code='shipment.Bol.grossWeight'/>",
                type: 'text',
                align: "center"
            },
            {
                name: "netWeight",
                title: "<spring:message code='shipment.Bol.netWeight'/>",
                type: 'text',
                align: "center"
            },
        ],
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            ListGrid_BolItem.fetchData({"tblBolHeader.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_BolItem.setData(data);
            });
        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        dataPageSize: 50,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt"
    });
    var HLayout_Grid_BolHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_BolHeader
        ]
    });

    var VLayout_Body_BolHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_Actions_BolHeader, HLayout_Grid_BolHeader
            ]
    });


    //---------------------------------------------------------------------------------
    var Menu_ListGrid_BolItem = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_BolItem_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_BolItem.clearValues();
                    Window_BolItem.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_BolItem_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_BolItem_remove();
                }
            }
        ]
    });

    var ValuesManager_BolItem = isc.ValuesManager.create({});

    var DynamicForm_BolItem = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        cellPadding: 2,
        numCols: 4,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "tblBolHeader.id", title: "id", canEdit: false, hidden: true},
                {
                    name: "containerType", title: "<spring:message code='shipment.Bol.containerType'/>",
                    valueMap: {"20'DV": "20'DV", "40'DV": "40'DV"}
                },
                {
                    name: "containerNo",
                    title: "<spring:message code='shipment.Bol.containerNo'/>"
                    ,
                    type: 'ineger',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "sealNo", title: "<spring:message code='shipment.Bol.sealNo'/>", type: 'text'},
                {name: "seal2No", title: "<spring:message code='shipment.Bol.seal2No'/>", type: 'text'},
                {
                    name: "noPalete",
                    title: "<spring:message code='shipment.Bol.noPalete'/>"
                    ,
                    type: 'ineger',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "noBundle",
                    title: "<spring:message code='shipment.Bol.noBundle'/>"
                    ,
                    type: 'ineger',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "grossWeight",
                    title: "<spring:message code='shipment.Bol.grossWeight'/>"
                    ,
                    type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "netWeight",
                    title: "<spring:message code='shipment.Bol.netWeight'/>"
                    ,
                    type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ]
    });
    var IButton_Shipment_Save_BolItem = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_BolItem.validate();
            if (DynamicForm_BolItem.hasErrors()) {
                return;
            }

            var record = ListGrid_BolHeader.getSelectedRecord();
            DynamicForm_BolItem.setValue("tblBolHeader.id", record.id);

            var data = DynamicForm_BolItem.getValues();

            isc.RPCManager.sendRequest({
                actionURL: "rest/bolItem/add",
                httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
//params: { data:data1},
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.data == 'success') {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_BolItem_refresh();
                        Window_BolItem.close();
                    } else {
                        isc.say(RpcResponse_o.data);
                    }
                }
            });
        }
    });
    var Window_BolItem = isc.Window.create({
        title: "<spring:message code='shipment.BolItem'/>",
        width: "28%",
        height: "30%",
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        margin: '10px',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            DynamicForm_BolItem,
            IButton_Shipment_Save_BolItem
        ]
    });

    function ListGrid_BolItem_refresh() {
        ListGrid_BolItem.invalidateCache();
        var record = ListGrid_BolHeader.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        ListGrid_BolItem.fetchData({"tblBolHeader.id": record.id}, function (dsResponse, data, dsRequest) {
            ListGrid_BolItem.setData(data);
        });
    };

    function ListGrid_BolItem_remove() {
        var record = ListGrid_BolItem.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
                buttonClick: function () {
                    hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [isc.Button.create({
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {

                        var shipmentId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "rest/bolItem/remove/" + shipmentId,
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
// data: shipmentId,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    ListGrid_BolItem.invalidateCache();
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

    function ListGrid_BolItem_edit() {

        var record = ListGrid_BolItem.getSelectedRecord();

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
            DynamicForm_BolItem.editRecord(record);

            Window_BolItem.show();
        }
    };
    var ToolStripButton_BolItem_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_BolItem_refresh();
        }
    });
    var ToolStripButton_BolItem_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {

            var record = ListGrid_BolHeader.getSelectedRecord();

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
                DynamicForm_BolItem.clearValues();
                Window_BolItem.show();
            }
        }
    });
    var ToolStripButton_BolItem_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            var record = ListGrid_BolItem.getSelectedRecord();
            if (record.id != null) {
                ListGrid_BolItem_edit();
            }
        }
    });
    var ToolStripButton_BolItem_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_BolItem_remove();
        }
    });
    var ToolStripButton_BolItem_Print = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/print.png",
        title: "<spring:message code='global.form.print'/>",
        click: function () {
            var record = ListGrid_BolItem.getSelectedRecord();

        }
    });
    var ToolStrip_Actions_BolItem = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_BolItem_Refresh,
            ToolStripButton_BolItem_Add,
            ToolStripButton_BolItem_Edit,
            ToolStripButton_BolItem_Remove,
            ToolStripButton_BolItem_Paste,
            ToolStripButton_BolItem_Print,
        ]
    });

    var HLayout_Actions_BolItem = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_BolItem
        ]
    });

    var ListGrid_BolItem = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_BolItem,
        contextMenu: Menu_ListGrid_BolItem,
        autoFetchData: false,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "tblBolHeader.id", title: "id", canEdit: false, hidden: true},
            {name: "containerType", title: "<spring:message code='shipment.Bol.containerType'/>", type: 'text'},
            {
                name: "containerNo",
                title: "<spring:message code='shipment.Bol.containerNo'/>"
                ,
                type: 'ineger',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {name: "sealNo", title: "<spring:message code='shipment.Bol.sealNo'/>", type: 'text'},
            {name: "seal2No", title: "<spring:message code='shipment.Bol.seal2No'/>", type: 'text'},
            {
                name: "noPalete",
                title: "<spring:message code='shipment.Bol.noPalete'/>"
                ,
                type: 'ineger',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                name: "noBundle",
                title: "<spring:message code='shipment.Bol.noBundle'/>"
                ,
                type: 'ineger',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                name: "grossWeight",
                title: "<spring:message code='shipment.Bol.grossWeight'/>"
                ,
                type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                name: "netWeight",
                title: "<spring:message code='shipment.Bol.netWeight'/>"
                ,
                type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
        ],
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        dataPageSize: 50,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt"
    });
    var HLayout_Grid_BolItem = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_BolItem
        ]
    });

    var VLayout_Body_BolItem = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_Actions_BolItem, HLayout_Grid_BolItem
            ]
    });

    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    isc.SectionStack.create({
        ID: "BolHeader_Section_Stack",
        sections:
            [
                {
                    title: "<spring:message code='Shipment.title'/>",
                    items: VLayout_Body_ShipmentByBolHeader,
                    expanded: true
                }
                , {title: "<spring:message code='bol.title'/>", items: VLayout_Body_BolHeader, expanded: true}
                , {title: "<spring:message code='BolItem.title'/>", items: VLayout_Body_BolItem, expanded: true}
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });