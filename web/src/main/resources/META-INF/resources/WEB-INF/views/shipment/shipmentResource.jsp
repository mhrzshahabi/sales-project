<%@ page import="com.nicico.core.copper.config.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <% DateUtil dateUtil = new DateUtil();%>

    var RestDataSource_Shipment_HeaderByRes = isc.RestDataSource.create({
        fields: [
            {name: "id", primaryKey: true, canEdit: false, hidden: true},

        ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/shipmentHeader/list"
    });
    var RestDataSource_ContactByShipmentResource = isc.RestDataSource.create({
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


    var RestDataSource_ShipmentByResource = isc.RestDataSource.create({
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
    var RestDataSource_Shipment_Add_Header = isc.RestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "fullname", title: "<spring:message code='contact.name'/>", type: 'text'},
            {name: "contractNo", title: "<spring:message code='contract.contractNo'/>", type: 'text', width: 180},
            {name: "descl", title: "<spring:message code='material.descl'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {
                name: "shipmentType", title: "<spring:message
		code='shipment.shipmentType'/>", type: 'text', width: 400, valueMap: {"b": "bulk", "c": "container"}
            },
            {
                name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%"
            },
            {name: "swb", title: "<spring:message code='shipment.SWB'/>", type: 'text', required: true, width: "10%"},
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
        ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/shipment/listAddHeader"
    });

    /*------------------------------------------------------Header--------------------------------------------------------*/
    function ListGrid_ShipmentHeaderByRes_refresh() {
        ListGrid_Shipment_HeaderByRes.invalidateCache();
        var record = ListGrid_Shipment_HeaderByRes.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        ListGrid_Shipment_HeaderByRes.fetchData({}, function (dsResponse, data, dsRequest) {
            ListGrid_Shipment_HeaderByRes.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_Shipment_HeaderByRes_edit() {
        var record = ListGrid_Shipment_HeaderByRes.getSelectedRecord();

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
            DynamicForm_ShipmentHeader_For_Edit.editRecord(record);
            DynamicForm_ShipmentHeader_For_Edit.setValue("shipmentHeaderDateDummy", new Date(record.shipmentHeaderDate));
            Window_ShipmentByAddHeader_For_Edit.show();
        }
    }

    function ListGrid_Shipment_HeaderByRes_remove() {

        var record = ListGrid_Shipment_HeaderByRes.getSelectedRecord()
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                        var shipmentHeaderId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "rest/shipmentHeader/remove/" + shipmentHeaderId,
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    ListGrid_ShipmentHeaderByRes_refresh();
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


    var ListGrid_Shipment_HeaderByRes = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment_HeaderByRes,
        <%--contextMenu: Menu_ListGrid_Shipment,--%>

        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, align: "center", hidden: true},
            {name: "shipmentHeaderDate", title: "<spring:message code='shipmentHeader.date'/>", align: "center"},
            {name: "description", title: "<spring:message code='shipmentHeader.description'/>", align: "center"}
        ],
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            ListGrid_Shipment.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_Shipment.setData(data);
            }, {operationId: "00"});

            var record = this.getSelectedRecord();
            ListGrid_ShipmentResource.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_ShipmentResource.setData(data);
            }, {operationId: "00"});
        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true
    });
    var HLayout_Grid_Shipment_HeaderByRes = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment_HeaderByRes
        ]
    });
    var ListGrid_ShipmentByAddHeader = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment_Add_Header,
        selectionAppearance: "checkbox",
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {
                name: "fullname",
                title: "<spring:message code='contact.name'/>",
                type: 'text',
                align: "center",
                width: 180
            },
            {
                name: "contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: 180,
                align: "center"
            },
            {
                name: "descl",
                title: "<spring:message code='material.descl'/>",
                type: 'text',
                align: "center",
                width: 180
            },
            {
                name: "amount",
                title: "<spring:message code='global.amount'/>",
                type: 'float',
                align: "center",
                width: 180
            },
            {
                name: "noContainer", title: "<spring:message
		code='shipment.noContainer'/>", type: 'integer', align: "center", width: 180
            },
            {
                name: "shipmentType", title: "<spring:message code='shipment.shipmentType'/>", type: 'text', width: 180
                , valueMap: {"b": "bulk", "c": "container"}, align: "center"
            },
            {
                name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: 180, align: "center"
            },
            {
                name: "swb",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                required: true,
                width: 180,
                align: "center"
            },
            {
                name: "month", title: "<spring:message
		code='shipment.month'/>", type: 'text', required: true, width: 180, align: "center"
            },
            {
                name: "status", title: "<spring:message code='shipment.staus'/>", type: 'text', width: 180
                , valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>", "Resource": "<spring:message
		code='shipment.resource'/>"
                }, align: "center"
            },

        ],
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            DynamicForm_ShipmentHeader.setValue("shipmentHeaderDateDummy", new Date(record1.createDate));
        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true
    })
    var HLayout_ShipmentByAddHeader_ListGrid = isc.HLayout.create({
        align: "center",
        width: "100%",
        height: 400,
        membersMargin: 1,
        showEdges: false,
        layoutMargin: 1,
        members:
            [
                ListGrid_ShipmentByAddHeader
            ]
    });
    var DynamicForm_ShipmentHeader = isc.DynamicForm.create({
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
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 1,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "shipmentHeaderDateDummy",
                    title: "<spring:message code='shipmentHeader.date'/>",
                    width: 480,
                    type: "date"
                },
                {
                    name: "description", title: "<spring:message
		code='shipmentHeader.description'/>", align: "center", width: "700", type: "textArea"
                }
            ]
    });
    var DynamicForm_ShipmentHeader_For_Edit = isc.DynamicForm.create({
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
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 1,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "shipmentHeaderDateDummy",
                    title: "<spring:message code='shipmentHeader.date'/>",
                    width: 480,
                    type: "date"
                },
                {
                    name: "description", title: "<spring:message
		code='shipmentHeader.description'/>", align: "center", width: "700", type: "textArea"
                }
            ]
    });

    var IButton_ShipmentByAddHeader_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            if (DynamicForm_ShipmentHeader.hasErrors())
                return;
            var descriptionHeader = "";
            var selection = ListGrid_ShipmentByAddHeader.getSelection();
            var shipmentIds = "";
            for (var i = 0; i < selection.length; i++) {
                shipmentIds += selection[i].id + ",";
                descriptionHeader += "\n" + "-" + "شماره قرارداد" + selection[i].contractNo + "\n"
            }
            var d = DynamicForm_ShipmentHeader.getValue("shipmentHeaderDateDummy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
            DynamicForm_ShipmentHeader.setValue("shipmentHeaderDate", datestring)

            DynamicForm_ShipmentHeader.setValue("description", descriptionHeader)
            var data = DynamicForm_ShipmentHeader.getValues();
            isc.RPCManager.sendRequest({
                actionURL: "rest/shipmentHeader/add/" + shipmentIds,
                httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.data == 'success') {
                        alert(1)
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_ShipmentHeaderByRes_refresh();
                        Window_ShipmentByAddHeader.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });

    var IButton_ShipmentByAddHeader_For_Edit_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            if (DynamicForm_ShipmentHeader_For_Edit.hasErrors())
                return;
            var d = DynamicForm_ShipmentHeader_For_Edit.getValue("shipmentHeaderDateDummy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
            DynamicForm_ShipmentHeader_For_Edit.setValue("shipmentHeaderDate", datestring)

            var data = DynamicForm_ShipmentHeader_For_Edit.getValues();
            var shipmentIds = "noId";
            isc.RPCManager.sendRequest({

                actionURL: "rest/shipmentHeader/add/" + shipmentIds,
                httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.data == 'success') {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_ShipmentHeaderByRes_refresh();
                        Window_ShipmentByAddHeader_For_Edit.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });

    var Window_ShipmentByAddHeader = isc.Window.create({
        title: "<spring:message code='shipmentHeader.title'/> ",
        width: "60%",
        height: "60%",
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
                HLayout_ShipmentByAddHeader_ListGrid,
                DynamicForm_ShipmentHeader,
                IButton_ShipmentByAddHeader_Save
            ]
    });
    var Window_ShipmentByAddHeader_For_Edit = isc.Window.create({
        title: "<spring:message code='shipmentHeader.title'/> ",
        width: "60%",
        height: "60%",
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
                DynamicForm_ShipmentHeader_For_Edit,
                IButton_ShipmentByAddHeader_For_Edit_Save
            ]
    });
    var ToolStripButton_Shipment_HeaderByRes_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            Window_ShipmentByAddHeader.show();
        }
    });
    var ToolStripButton_Shipment_HeaderByRes_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Shipment_HeaderByRes_edit();
        }
    });
    var ToolStripButton_Shipment_HeaderByRes_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Shipment_HeaderByRes_remove();
        }
    });
    var ToolStrip_Actions_Shipment_HeaderByRes = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Shipment_HeaderByRes_Add
                , ToolStripButton_Shipment_HeaderByRes_Edit
                , ToolStripButton_Shipment_HeaderByRes_Remove
            ]
    });
    var HLayout_Shipment_HeaderByRes_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Shipment_HeaderByRes
            ]
    });

    var VLayout_Body_Shipment_HeaderByRes = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [

            HLayout_Shipment_HeaderByRes_Actions,
            HLayout_Grid_Shipment_HeaderByRes
        ]
    });
    /*------------------------------------------------------Shipment--------------------------------------------------------------------------------------------------------------------------------------------------*/
    var ListGrid_Shipment = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentByResource,
        <%--contextMenu: Menu_ListGrid_Shipment,--%>
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "tblContractItemShipment.id", hidden: true, type: 'long'},
            {name: "tblContractItemShipment.tblContractItem.tblContract.id", type: 'long', hidden: true},
            {name: "tblContact.id", type: 'long', hidden: true},
            {
                name: "tblContact.nameFA", title: "<spring:message
		code='contact.name'/>", type: 'text', width: "20%", align: "center", showHover: true
            },
            {name: "tblContract.id", type: 'long', hidden: true},
            {
                name: "tblContract.contractNo", title: "<spring:message
		code='contract.contractNo'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "tblContract.contractDate", title: "<spring:message
		code='contract.contractDate'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "tblMaterial.id",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
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
                showHover: true
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
		code='shipment.loading'/>", type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "tblPortByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "dischargeAddress", title: "<spring:message
		code='global.address'/>", type: 'text', required: true, width: "10%", showHover: true
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
                name: "SWB",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "tblSwitchPort.port", title: "<spring:message
		code='port.switchPort'/>", type: 'text', required: true, width: "10%", showHover: true
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

        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true
    });
    var HLayout_Grid_Shipment = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment
        ]
    });

    var VLayout_Body_Shipment = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_Shipment
        ]
    });
    //-------------------------------------------Resource----------------------------------------------------------------------
    var RestDataSource_ShipmentResource = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "tblShipmentHeader.id",
                    title: "<spring:message code='shipment.name'/>",
                    align: "center",
                    hidden: true
                },
                {
                    name: "tblContact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "description",
                    title: "<spring:message code='shipment.description'/>",
                    align: "center",
                    width: "10%"
                }
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/shipmentResource/list"
    });

    <%--var IButton_ShipmentResource_Save = isc.IButton.create({--%>
    <%--top: 260,--%>
    <%--title:"<spring:message code='global.form.save'/>",--%>
    <%--icon: "pieces/16/save.png",--%>
    <%--click : function ()--%>
    <%--{--%>
    <%--/*ValuesManager_GoodsUnit.validate();*/--%>
    <%--DynamicForm_ShipmentResource.validate();--%>
    <%--if (DynamicForm_ShipmentResource.hasErrors())--%>
    <%--return;--%>

    <%--var data = DynamicForm_ShipmentResource.getValues();--%>
    <%--isc.RPCManager.sendRequest({--%>
    <%--actionURL: "rest/shipmentResource/add",--%>
    <%--httpMethod: "POST",--%>
    <%--useSimpleHttp: true,--%>
    <%--contentType: "application/json; charset=utf-8",--%>
    <%--showPrompt:false,--%>
    <%--data: JSON.stringify(data),--%>
    <%--serverOutputAsString: false,--%>
    <%--//params: {    data:data1},--%>
    <%--callback: function (RpcResponse_o)--%>
    <%--{--%>
    <%--if(RpcResponse_o.data == 'success')--%>
    <%--{--%>
    <%--isc.say("<spring:message code='global.form.request.successful'/>.");--%>
    <%--ListGrid_ShipmentResource_refresh();--%>
    <%--Window_ShipmentResource.close();--%>
    <%--}--%>
    <%--else--%>
    <%--isc.say(RpcResponse_o.data);--%>
    <%--}--%>
    <%--});--%>
    <%--}--%>
    <%--});--%>

    var IButton_ShipmentResource_Close = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_ShipmentResource.close();
        }
    });
    var IButton_ShipmentResource_Edit_Close = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_Edit_ShipmentResource.close();
        }
    });

    function ListGrid_ShipmentResource_refresh() {
        ListGrid_ShipmentResource.invalidateCache();
        var record = ListGrid_Shipment_HeaderByRes.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        ListGrid_ShipmentResource.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
            ListGrid_ShipmentResource.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_ShipmentResource_edit() {

        var record = ListGrid_ShipmentResource.getSelectedRecord()
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
            DynamicForm_Edit_ShipmentResource.editRecord(record);
            Window_Edit_ShipmentResource.show();
        }
    }

    function ListGrid_ShipmentResource_remove() {

        var record = ListGrid_ShipmentResource.getSelectedRecord()
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
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
                        var shipmentResourceId = record.id;
                        isc.RPCManager.sendRequest({
                            actionURL: "rest/shipmentResource/remove/" + shipmentResourceId,
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    ListGrid_ShipmentResource_refresh();
                                    ListGrid_ContactByShipmentResourceSelected.invalidateCache();
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
    var Menu_ListGrid_ShipmentResource = isc.Menu.create({
        width: 150,
        data:
            [
                {
                    title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                    click: function () {
                        DynamicForm_ShipmentResource.clearValues();
                        Window_ShipmentResource.show();
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
                        ListGrid_ShipmentResource_edit();
                    }
                },
                {
                    title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_ShipmentResource_remove();
                    }
                }
            ]
    });

    var DynamicForm_ShipmentResource = isc.DynamicForm.create({
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
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 1,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "tblShipment.id", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
                {
                    name: "description", title: "<spring:message
		code='shipment.description'/>", align: "center", width: "800", type: "textArea"
                }
            ]
    });
    var DynamicForm_Edit_ShipmentResource = isc.DynamicForm.create({
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
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 1,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "tblShipment.id", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
                {
                    name: "description", title: "<spring:message
		code='shipment.description'/>", align: "center", width: "800", type: "textArea"
                }
            ]
    });

    var ToolStripButton_ShipmentResource_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentResource_refresh();
        }
    });

    var ToolStripButton_ShipmentResource_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_Shipment_HeaderByRes.getSelectedRecord();

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
                DynamicForm_ShipmentResource.clearValues();
                DynamicForm_ShipmentResource.setValue("tblShipmentHeader.id", record.id);
                Window_ShipmentResource.show();
            }
        }
    });

    var ToolStripButton_ShipmentResource_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ShipmentResource_edit();
        }
    });


    var ToolStripButton_ShipmentResource_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ShipmentResource_remove();
        }
    });

    var ToolStrip_Actions_ShipmentResource = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_ShipmentResource_Refresh,
                ToolStripButton_ShipmentResource_Add,
                ToolStripButton_ShipmentResource_Edit,
                ToolStripButton_ShipmentResource_Remove
            ]
    });

    var HLayout_ShipmentResource_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_ShipmentResource
            ]
    });
    isc.Label.create({
        ID: "Label_UnSelected_Contact_ShipmentResource",
        contents: "<spring:message code='shipmentResource.customers.unselected'/>",
        align: "center",
        border: "1px blue solid",
        width: 300,
        height: 22
    });
    isc.Label.create({
        ID: "Label_Selected_Contact_ShipmentResource",
        contents: "<spring:message code='shipmentResource.customers.selected'/>",
        border: "1px blue solid",
        align: "center",
        width: 300,
        height: 22
    });

    var ListGrid_ContactByShipmentResource = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ContactByShipmentResource,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
        },
        fields: [
            {name: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='contact.code'/>", align: "center", width: 100},
            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>", align: "center", width: 200},
            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>", align: "center", hidden: true},
            {
                name: "tradeMark", title: "<spring:message
		code='contact.tradeMark'/>", type: 'text', width: 200, wrapTitle: false, align: "center"
            },
            {
                name: "commercialRegistration", title: "<spring:message
		code='contact.commercialRegistration'/>", type: 'text', width: 200, wrapTitle: false, align: "center"
            },
            {
                name: "branchName", title: "<spring:message
		code='contact.branchName'/>", type: 'text', width: 200, wrapTitle: false, align: "center"
            },
            {
                name: "commertialRole", title: "<spring:message
		code='contact.commertialRole'/>", type: 'text', width: 200, wrapTitle: false, align: "center"
            },
            {name: "phone", title: "<spring:message code='contact.phone'/>", align: "center", width: 200},
            {name: "mobile", title: "<spring:message code='contact.mobile'/>", align: "center", width: 200},
            {name: "fax", title: "<spring:message code='contact.fax'/>", align: "center", width: 200},
            {name: "address", title: "<spring:message code='contact.address'/>", align: "center", hidden: true},
            {name: "webSite", title: "<spring:message code='contact.webSite'/>", align: "center", hidden: true},
            {name: "email", title: "<spring:message code='contact.email'/>", align: "center", hidden: true},
            {name: "type", title: "<spring:message code='contact.type'/>", align: "center", width: 200},
            {name: "nationalCode", title: "<spring:message code='contact.nationalCode'/>", align: "center", width: 200},
            {
                name: "economicalCode",
                title: "<spring:message code='contact.economicalCode'/>",
                align: "center",
                width: 200
            },
            {name: "bankAccount", title: "<spring:message code='contact.bankAccount'/>", align: "center", width: 200},
            {name: "bankShaba", title: "<spring:message code='contact.bankShaba'/>", align: "center", width: 200},
            {
                name: "bankSwift",
                title: "<spring:message code='contactAccount.bankSwift'/>",
                align: "center",
                width: 200
            },
            {name: "bankName", title: "<spring:message code='contact.bankName'/>", align: "center", width: 200},
            {name: "status", title: "<spring:message code='contact.status'/>", align: "center", width: 200},
            {name: "contactAccounts", hidden: true}

        ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        canAcceptDroppedRecords: true,
        canDragRecordsOut: true,
        canDrag: true,
        dragDataAction: "move",
        selectionType: "single",

    });
    ListGrid_ContactByShipmentResource.fetchData({"shipper": 1}, function (dsResponse, data, dsRequest) {
        ListGrid_ContactByShipmentResource.setData(data);
    }, {operationId: "00"});
    <%------SELECTED-------------%>

    var ListGrid_ContactByShipmentResourceSelected = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentResource,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "tblContact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "description",
                    title: "<spring:message code='shipment.description'/>",
                    align: "center",
                    width: "10%"
                }
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        canAcceptDroppedRecords: true,
        canDragRecordsOut: true,
        canDrag: true,
        dragDataAction: "move",
        selectionType: "single",
        recordDrop: function (dropRecords, targetRecord, index, sourceWidget) {
            if (this === sourceWidget)
                return;

            if (dropRecords.length > 1)
                return;
            if (ListGrid_ContactByShipmentResource.getSelectedRecord() == null || ListGrid_ContactByShipmentResource.getSelectedRecord().id == null || ListGrid_ContactByShipmentResource.getSelectedRecord() == null || ListGrid_ContactByShipmentResource.getSelectedRecord().id == null) {
                isc.say("<spring:message code='global.grid.record.not.selected'/>");
                return;
            }

            var recordShipmentHeader = ListGrid_Shipment_HeaderByRes.getSelectedRecord();
            var recordContact = ListGrid_ContactByShipmentResource.getSelectedRecord();
            DynamicForm_ShipmentResource.setValue("tblContact.id", recordContact.id);
            DynamicForm_ShipmentResource.setValue("tblShipmentHeader.id", recordShipmentHeader.id);


            var data = DynamicForm_ShipmentResource.getValues();
            DynamicForm_ShipmentResource.setValue("description", DynamicForm_ShipmentResource.getValue("description"));
            isc.RPCManager.sendRequest({
                actionURL: "rest/shipmentResource/add",
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
                        ListGrid_ShipmentResource_refresh();
                        ListGrid_ContactByShipmentResourceSelected.invalidateCache();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });
    var HLayout_ShipmentResource_Contact_ListGrid = isc.HLayout.create({
        align: "center",
        width: "100%",
        height: 400,
        membersMargin: 1,
        showEdges: false,
        layoutMargin: 1,
        members:
            [
                ListGrid_ContactByShipmentResource, ListGrid_ContactByShipmentResourceSelected
            ]
    });

    var HLayout_ShipmentResource_Contact_Label = isc.HLayout.create({
        showEdges: false,
        width: "100%",
        height: 100,
        membersMargin: 250,
        layoutMargin: 20,
        members:
            [
                Label_UnSelected_Contact_ShipmentResource, Label_Selected_Contact_ShipmentResource
            ]
    });


    var Window_ShipmentResource = isc.Window.create({
        title: "<spring:message code='shipment.shipmentResource'/> ",
        width: "60%",
        height: "60%",
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
                HLayout_ShipmentResource_Contact_Label, HLayout_ShipmentResource_Contact_ListGrid, DynamicForm_ShipmentResource, IButton_ShipmentResource_Close
                <%--, IButton_ShipmentResource_Save--%>
            ]
    });
    var IButton_ShipmentResource_ForEdit_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_Edit_ShipmentResource.validate();
            if (DynamicForm_Edit_ShipmentResource.hasErrors())
                return;

            var data = DynamicForm_Edit_ShipmentResource.getValues();

            isc.RPCManager.sendRequest({
                actionURL: "rest/shipmentResource/add",
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
                        ListGrid_ShipmentResource_refresh();
                        Window_Edit_ShipmentResource.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });
    var Window_Edit_ShipmentResource = isc.Window.create({
        title: "<spring:message code='shipment.shipmentResource'/> ",
        width: "60%",
        height: "60%",
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
                DynamicForm_Edit_ShipmentResource,
                isc.HLayout.create({
                    width: "100%",
                    members:
                        [
                            IButton_ShipmentResource_ForEdit_Save,
                            isc.Label.create({width: 5,}),
                            IButton_ShipmentResource_Edit_Close
                        ]
                })

            ]
    });
    var ListGrid_ShipmentResource = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentResource,
        contextMenu: Menu_ListGrid_ShipmentResource,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "tblShipmentHeader.id",
                    title: "<spring:message code='contact.name'/>",
                    align: "center",
                    hidden: true
                },
                {
                    name: "tblContact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "description",
                    title: "<spring:message code='shipment.description'/>",
                    align: "center",
                    width: "10%"
                }
            ],
        sortField: 0,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
// ListGrid_ShipmentResource.fetchData({"tblShipment.id":record.id},function (dsResponse, data, dsRequest) {
// ListGrid_ShipmentEmai.setData(data);
// },{operationId:"00"});
        },
        dataArrived: function (startRow, endRow) {
        }

    });

    var HLayout_ShipmentResource_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentResource
        ]
    });

    var VLayout_ShipmentResource_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_ShipmentResource_Actions, HLayout_ShipmentResource_Grid
            ]
    });

    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    isc.SectionStack.create({
        ID: "Shipment_Section_Stack",
        sections:
            [
                {
                    title: "<spring:message code='shipmentHeader.title'/>",
                    items: VLayout_Body_Shipment_HeaderByRes,
                    expanded: true
                }
                , {title: "<spring:message code='Shipment.title'/>", items: VLayout_Body_Shipment, expanded: true}
                , {
                title: "<spring:message code='shipment.shipmentResource'/>",
                items: VLayout_ShipmentResource_Body,
                expanded: true
            }
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });
