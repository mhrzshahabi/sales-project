<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

 <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var MyRestDataSource_ShipmentAssayHeader = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "id", canEdit: false},
                {name: "shipment.contract.contractNo", title: "contractNo", canEdit: false, hidden: true},
                {name: "inspectionByContactId",title: "<spring:message code='shipment.AssayInspectionCompany'/>",type: 'text'},
                {name: "inspectionByContact.nameEn", title: "<spring:message code='shipment.Assay.inspectionCompany'/>", type: 'text', canEdit: false},
                {name: "description", title: "<spring:message code='shipment.Assay.capacity'/>", type: 'text'},
                {name: "location", title: "<spring:message code='shipment.Assay.location'/>", type: 'text'},
                {name: "inspectionDate", title: "<spring:message code='shipment.Assay.inspectionDate'/>", type: 'text'},
                {name: "averageCuPercent",title: "<spring:message code='shipment.Assay.averageCuPercent'/>",type: 'text'},
                {name: "averageAuPercent",title: "<spring:message code='shipment.Assay.averageAuPercent'/>",type: 'text'},
                {name: "averageAgPercent",title: "<spring:message code='shipment.Assay.averageAgPercent'/>",type: 'text'},
                {name: "totalDryWeight", title: "<spring:message code='shipment.Assay.totalDryWeight'/>", type: 'text'},
            ],
        fetchDataURL: "${contextPath}/api/shipmentAssayHeader/spec-list"
    });
    var MyRestDataSource_ShipmentAssayItem = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentAssayHeaderId", title: "id", canEdit: false, hidden: true},
                {name: "lotNo", title: "<spring:message code='shipment.Assay.lotNo'/>", type: 'text'},
                {name: "cu",title: "<spring:message code='shipment.Assay.cu'/>",type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "ag",title: "<spring:message code='shipment.Assay.ag'/>",type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "au",title: "<spring:message code='shipment.Assay.au'/>",type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ],
        fetchDataURL: "${contextPath}/api/shipmentAssayItem/spec-list"
    });

    var MyRestDataSource_Contact = isc.MyRestDataSource.create({
        fields: [
            {name: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='contact.code'/>"},
            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
            {name: "tradeMark" },
            {name: "ceoPassportNo" },
            {name: "ceo" },
            {name: "commercialRegistration" },
            {name: "branchName" },
            {name: "commertialRole" },
            {name: "phone", title: "<spring:message code='contact.phone'/>"},
            {name: "mobile", title: "<spring:message code='contact.mobile'/>"},
            {name: "fax", title: "<spring:message code='contact.fax'/>"},
            {name: "address", title: "<spring:message code='contact.address'/>"},
            {name: "webSite", title: "<spring:message code='contact.webSite'/>"},
            {name: "email", title: "<spring:message code='contact.email'/>"},
            {
                name: "type",
                title: "<spring:message code='contact.type'/>",
                valueMap: {"true": "<spring:message code='contact.type.real'/>", "false": "<spring:message code='contact.type.legal'/>"}
            },
            {name: "nationalcode", title: "<spring:message code='contact.nationalCode'/>"},
            {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
            {name: "bankAccount", title: "<spring:message code='contact.bankAccount'/>"},
            {name: "bankShaba", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "bankSwift", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "bankName", title: "<spring:message code='contact.bankName'/>"},
            <%--{name: "bankId", title:"<spring:message code='global.country'/>", type:'long' , width: 400,editorType: "SelectItem"--%>
                <%--, optionDataSource:MyRestDataSource_Country ,displayField:"nameFa"--%>
                <%--, valueField:"id" ,pickListWidth:"300",pickListheight:"500" ,pickListProperties: {showFilterEditor:true}--%>
                <%--,pickListFields:[{name:"nameFa",width:150,align:"center"},{name:"code",width:150,align:"center"}] --%>
            <%--},--%>
            {
                name: "status",
                title: "<spring:message code='contact.status'/>",
                valueMap: {"true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"}
            },
            {name: "contactAccounts"}
        ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });
    //*******************************************************************************
    var MyRestDataSource_ShipmentByAssayHeader = isc.MyRestDataSource.create({
    fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "contactId", type: 'long', hidden: true},
            {name: "contract.contact.nameFA", title: "<spring:message code='contact.name'/>", type: 'text'},
            {name: "contractId", type: 'long', hidden: true},
            {name: "contract.contractNo",title: "<spring:message code='contract.contractNo'/>",type: 'text',width: 180 },
            {name: "contract.contractDate",title: "<spring:message code='contract.contractDate'/>",type: 'text',width: 180},
            {name: "materialId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "material.descl", title: "<spring:message code='material.descl'/>", type: 'text'},
            {name: "material.unit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "noPalete", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "laycan",title: "<spring:message code='shipmentContract.laycanStart'/>",type: 'integer',width: "10%",align: "center"},
            {name: "shipmentType",title: "<spring:message code='shipment.shipmentType'/>",type: 'text',width: 400,valueMap: {"bulk": "bulk", "container": "container"}},
            {name: "loadingLetter",title: "<spring:message code='shipment.loadingLetter'/>",type: 'text',width: "10%",showHover: true},
            {name: "loading", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "portByLoadingId", title: "<spring:message code='shipment.loading'/>", type: 'text', width: "10%"},
            {name: "portByLoading.port",title: "<spring:message code='shipment.loading'/>",type: 'text',width: "10%"},
            {name: "portByDischargeId",title: "<spring:message code='shipment.discharge'/>",type: 'text',width: "10%"},
            {name: "portByDischarge.port",title: "<spring:message code='shipment.discharge'/>",type: 'text',width: "10%"},
            {name: "dischargeAddress", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "description", title: "<spring:message code='shipment.description'/>", type: 'text', width: "10%"},
            {name: "swb", title: "<spring:message code='shipment.SWB'/>", type: 'text', width: "10%"},
            {name: "switchPort.port", title: "<spring:message code='port.switchPort'/>", type: 'text', width: "10%"},
            {name: "month", title: "<spring:message code='shipment.month'/>", type: 'text', width: "10%"},
            {name: "status",title: "<spring:message code='shipment.staus'/>",type: 'text',width: "10%",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                }
            },
            {name: "contractShipment.sendDate",title: "<spring:message code='global.sendDate'/>",type: 'text',required: true,width: "10%",align: "center",showHover: true},
            {name: "createDate", title: "<spring:message code='shipment.createDate'/>", type: 'text', width: "10%"},
            {name: "contactByAgent.nameFA",align: "center",showHover: true},
            {name: "vesselName",title: "<spring:message	code='shipment.vesselName'/>",type: 'text',required: true,width: "10%",showHover: true}
    ],
 // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });

    var ShipmentAssayItemData = [];
    for (i = 0; i < 100; i++) {
        ShipmentAssayItemData.add({id: i});
    }

    var ClientDataSource_ShipmentAssayItem = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentAssayHeaderId", title: "id", canEdit: false, hidden: true},
                {name: "lotNo", title: "<spring:message code='shipment.Assay.lotNo'/>", type: 'text'},
                {name: "cu",title: "<spring:message code='shipment.Assay.cu'/>",type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "ag",title: "<spring:message code='shipment.Assay.ag'/>",type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {name: "au",title: "<spring:message code='shipment.Assay.au'/>",type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ],
        testData: ShipmentAssayItemData,
        clientOnly: true
    });

    /* ****************** */

    function pasteText(text) {
        var fieldNames = [];
        ListGrid_ShipmentAssayItemPaste.selectAllRecords();
        for (var col = 0; col < 13; col++) {
            fieldNames.add(ListGrid_ShipmentAssayItemPaste.getFieldName(col));
        }
        var settings = {
            fieldList: fieldNames,
            fieldSeparator: "\t",
            escapingMode: "double"
        };
        var dataSource = ListGrid_ShipmentAssayItemPaste.dataSource;
        var records = dataSource.recordsFromText(text, settings);
        ListGrid_ShipmentAssayItemPaste.applyRecordData(records);
    }


    function createPasteDialog() {
        var record = ListGrid_ShipmentAssayHeader.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    hide();
                }
            });
            return;
        }
        var ShipmentAssayHeaderId = record.id;
        var PasteDialogShipmentAssayItem_windows = isc.Window.create({
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
                    height         :"100%",
                   alignLayout: "center",
                    members: [

                        isc.DynamicForm.create({
                            ID: "resultsForm",
                            numCols: 6,
                            width: "100%",
                            height: "90%",
                            autoFocus: true,
                            fields: [
                                {
                                    type: "text",
                                    name: "guidance",
                                    colSpan: 6,
                                    showTitle: false,
                                    editorType: "StaticTextItem",
                                    value: "Press Ctrl-V or right click to paste values, then click \"Apply\".",
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
                            ]


                        }) /* dynamic Form */
                        , ListGrid_ShipmentAssayItemPaste = isc.ListGrid.create({
                            dataSource: ClientDataSource_ShipmentAssayItem,
                            sortDirection: "descending",
                            width: "100%",
                            height: "90%",
                            canEdit: true,
                            autoFetchData: true,
                            canDragSelect: true,
                            canSelectCells: true,
                            autoSaveData: true,
                            fields: [
                                {name: "id",title: "id",primaryKey: true,canEdit: false,hidden: true,align: "center"},
                                {name: "shipmentAssayHeaderId",title: "id",canEdit: false,hidden: true,align: "center"},
                                {name: "lotNo", title:"<spring:message code='shipment.Moisture.lotNo'/>"
                                   , type:'integer', validators : [{type: "isInteger", validateOnExit : true, stopOnError : true, errorMessage: "<spring:message code='global.form.correctType'/>."}],align:"center" },
                                {name: "cu",title: "<spring:message code='shipment.Assay.cu'/>",type: 'float',
                                    validators: [{
                                        type: "isFloat",
                                        validateOnExit: true,
                                        stopOnError: true,
                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                    }]
                                },
                                {name: "ag",title: "<spring:message code='shipment.Assay.ag'/>",type: 'float',
                                    validators: [{
                                        type: "isFloat",
                                        validateOnExit: true,
                                        stopOnError: true,
                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                    }]
                                },
                                {name: "au",title: "<spring:message code='shipment.Assay.au'/>",type: 'float',
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
               isc.HLayout.create({
                    membersMargin  : 3,
                    width          :"100%",
                    alignLayout    :"center",
                    members        :
                    [
                         isc.Button.create({
                          title: "Apply", width : 300,
                            click: function (form) {
                                pasteText(resultsForm.getValue("textArea"));
                                ListGrid_ShipmentAssayItemPaste.saveAllEdits();
                            }
                        }),

                       isc.IButtonSave.create({
                            title: "<spring:message code='global.form.save'/>",
                            prompt: "<spring:message code='shipment.Moisture.saveButton'/>",
                            icon: "pieces/16/save.png",
                            width : 300,
                            click: function () {
                                resultsForm.validate();
                                if (resultsForm.hasErrors())
                                    return;
                                var selected = ListGrid_ShipmentAssayItemPaste.getSelection();

                                resultsForm.setValue("selected", selected);

                                resultsForm.setValue("ShipmentAssayHeaderId", ShipmentAssayHeaderId);
                                var data = resultsForm.getValues();
                                var methodXXXX="PUT";if (data.id==null) methodXXXX="POST";
                                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                                actionURL: "${contextPath}/api/shipmentAssayItem/addAssayPaste" ,
                                httpMethod: methodXXXX,
                                    data: JSON.stringify(data),
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                            isc.say("<spring:message code='global.form.request.successful'/>.");
                                            ListGrid_ShipmentAssayItem_refresh();
                                            PasteDialogShipmentAssayItem_windows.close();
                                        } else
                                            isc.say(RpcResponse_o.data);
                                    }
                                }));
                            }
                        })
                    ]
               })
            ]
        });
        /* windows*/


    }

    /* ****************** */
    var ToolStripButton_ShipmentAssayItem_Paste = isc.ToolStripButton.create({
        icon: "[SKIN]/RichTextEditor/paste.png",
        title: "Paste Cells",
        click: function () {
            createPasteDialog();
        }
    });

    var ListGrid_ShipmentByAssayHeader = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: MyRestDataSource_ShipmentByAssayHeader,
    fields:[
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contract.contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "contract.contractDate",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descl",
                title: "<spring:message code='material.descl'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "material.unit.nameEN",
                title: "<spring:message code='unit.nameEN'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "amount",
                title: "<spring:message code='global.amount'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "loadingLetter",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {
                name: "noContainer",
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            <%--{name: "laycan", title:"<spring:message code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",showHover:true},--%>
            {
                name: "portByLoading.port",
                title: "<spring:message	code='shipment.loading'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
// {name: "dischargeAddress", title:"<spring:message code='global.address'/>", type:'text', required: true, width: "10%" ,showHover:true},
            {
                name: "description",
                title: "<spring:message code='shipment.description'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "contractShipment.sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "createDate",
                title: "<spring:message code='global.createDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "month",
                title: "<spring:message code='shipment.month'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "contactByAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "20%",
                align: "center",
                showHover: true
            },
            {
                name: "vesselName",
                title: "<spring:message	code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "swb",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "switchPort.port",
                title: "<spring:message code='port.switchPort'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "status",
                title: "<spring:message	code='shipment.staus'/>",
                type: 'text',
                width: "10%",
                align: "center",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                },
                showHover: true
            }
    ],
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
                var criteria1 = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
                };
                ListGrid_ShipmentAssayHeader.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                    ListGrid_ShipmentAssayHeader.setData(data);
                    var recordH = ListGrid_ShipmentAssayHeader.getRecord(0);
                    if (ListGrid_ShipmentAssayHeader.getRecord(0) !=null )
                        criteria1 = {_constructor: "AdvancedCriteria",
                                operator: "and",
                                criteria: [{fieldName: "shipmentAssayHeader", operator: "equals", value: recordH.id}]  };
                    else
                        criteria1 = {_constructor: "AdvancedCriteria",
                                operator: "and",
                                criteria: [{fieldName: "shipmentAssayHeader", operator: "equals", value: -999999999 }]  };

                    ListGrid_ShipmentAssayItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                                ListGrid_ShipmentAssayItem.setData(data);
                            });
                });
        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt"
    });
    var HLayout_Grid_ShipmentByAssayHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentByAssayHeader
        ]
    });

    var VLayout_Body_ShipmentByAssayHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_ShipmentByAssayHeader
        ]
    });
    //*******************************************************************************
    var Menu_ListGrid_ShipmentAssayHeader = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_ShipmentAssayHeader_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_ShipmentAssayHeader.clearValues();
                    Window_ShipmentAssayHeader.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_ShipmentAssayHeader_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_ShipmentAssayHeader_remove();
                }
            }
        ]
    });

    var ValuesManager_ShipmentAssayHeader = isc.ValuesManager.create({});
    var criteria1Inspector = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "inspector", operator: "equals", value: true}]
    };

    var DynamicForm_ShipmentAssayHeader = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center", wrapTitle: false,
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
                {type: "RowSpacerItem"},
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "id", canEdit: false, hidden: true},
                {
                    name: "inspectionByContactId",
                    title: "<spring:message code='shipment.Assay.inspectionCompany'/>",
                    type: 'long',
                    editorType: "SelectItem",
                    colSpan: 1,
                    titleColSpan: 1,
                    required : true ,
                    optionDataSource: MyRestDataSource_Contact,
                    displayField: "nameEN",
                    wrapTitle: false,
                    optionCriteria: criteria1Inspector ,
                    valueField: "id",
                    pickListWidth: "450",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "nameFA", width: 150, align: "center"}, {
                        name: "nameEN",
                        width: 150,
                        align: "center"
                    }, {name: "code", width: 150, align: "center"}]
                },
                {
                    name: "location", title: "<spring:message code='shipment.Assay.location'/>", type: 'text',
                    valueMap: {"source": "source", "destination": "destination"},
                    required : true
                },
                {
                    name: "inspectionDate",
                    title: "<spring:message code='shipment.Assay.inspectionDate'/>",
                    type: 'text',
                    hidden: true
                },
                {
                    name: "inspectionDateDummy",
                    title: "<spring:message code='shipment.Assay.inspectionDate'/>",
                    type: 'date',
                    format: 'DD-MM-YYYY',
                    required: true,
                    width: "100%",colSpan:3,titleColSpan:1
                },
                {
                    name: "averageCuPercent",
                    title: "<spring:message code='shipment.Assay.averageCuPercent'/>",
                    type: 'float',
                    required : true ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "averageAuPercent",
                    title: "<spring:message code='shipment.Assay.averageAuPercent'/>",
                    type: 'float',
                    required : true ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "averageAgPercent",
                    title: "<spring:message code='shipment.Assay.averageAgPercent'/>",
                    type: 'float',
                    required : true ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "totalDryWeight",
                    title: "<spring:message code='shipment.Assay.totalDryWeight'/>",
                    type: 'float',
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "description", title: "<spring:message code='shipment.Assay.description'/>", type: 'textArea', width: "600", colSpan: 4
                },
            ]
    });
    var IButton_Shipment_Save_AssayHeader = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {

            var d = DynamicForm_ShipmentAssayHeader.getValue("inspectionDateDummy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2));
            DynamicForm_ShipmentAssayHeader.setValue("inspectionDate", datestring);

            DynamicForm_ShipmentAssayHeader.validate();
            if (DynamicForm_ShipmentAssayHeader.hasErrors()) {
                return;
            }

            var record = ListGrid_ShipmentByAssayHeader.getSelectedRecord();
            DynamicForm_ShipmentAssayHeader.setValue("shipmentId", record.id);

            var data = DynamicForm_ShipmentAssayHeader.getValues();

var methodXXXX="PUT";if (data.id==null) methodXXXX="POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
actionURL: "${contextPath}/api/shipmentAssayHeader/" ,
httpMethod: methodXXXX,
                data: JSON.stringify(data),
                callback: function (RpcResponse_o) {
   if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201){
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_ShipmentAssayHeader_refresh();
                        Window_ShipmentAssayHeader.close();
                    } else {
                        isc.say(RpcResponse_o.data);
                    }
                }
            }));
        }
    });
    var Window_ShipmentAssayHeader = isc.Window.create({
        title: "<spring:message code='shipment.AssayHeader'/>",
        width: "50%",
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
            DynamicForm_ShipmentAssayHeader,
            IButton_Shipment_Save_AssayHeader
        ]
    });

    function ListGrid_ShipmentAssayHeader_refresh() {
        ListGrid_ShipmentAssayHeader.invalidateCache();
        var record = ListGrid_ShipmentByAssayHeader.getSelectedRecord();
        if (record == null || record.id == null)
            return;
                var criteria1 = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
                };
                ListGrid_ShipmentAssayHeader.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                    ListGrid_ShipmentAssayHeader.setData(data);
                    var recordH = ListGrid_ShipmentAssayHeader.getRecord(0);
                    if (ListGrid_ShipmentAssayHeader.getRecord(0) !=null )
                        criteria1 = {_constructor: "AdvancedCriteria",
                                operator: "and",
                                criteria: [{fieldName: "shipmentAssayHeader", operator: "equals", value: recordH.id}]  };
                    else
                        criteria1 = {_constructor: "AdvancedCriteria",
                                operator: "and",
                                criteria: [{fieldName: "shipmentAssayHeader", operator: "equals", value: -999999999 }]  };

                    ListGrid_ShipmentAssayItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                                ListGrid_ShipmentAssayItem.setData(data);
                            });
                });
    }

    function ListGrid_ShipmentAssayHeader_remove() {
        var record = ListGrid_ShipmentAssayHeader.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
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
                    title: "<spring:message	code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var shipmentId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
actionURL: "${contextPath}/api/shipmentAssayHeader/" +  shipmentId,
httpMethod: "DELETE",
                            callback: function (RpcResponse_o) {
   if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                    ListGrid_ShipmentAssayHeader_refresh();
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            }
                        }));
                    }
                }
            });
        }
    }

    function ListGrid_ShipmentAssayHeader_edit() {

        var record = ListGrid_ShipmentAssayHeader.getSelectedRecord();

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
            DynamicForm_ShipmentAssayHeader.editRecord(record);
            DynamicForm_ShipmentAssayHeader.setValue("inspectionDateDummy", new Date(record.inspectionDate));
            Window_ShipmentAssayHeader.show();
        }
    }
    var ToolStripButton_ShipmentAssayHeader_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentAssayHeader_refresh();
        }
    });
    var ToolStripButton_ShipmentAssayHeader_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {

            var record = ListGrid_ShipmentByAssayHeader.getSelectedRecord();

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
                DynamicForm_ShipmentAssayHeader.clearValues();
                Window_ShipmentAssayHeader.show();
            }
        }
    });
    var ToolStripButton_ShipmentAssayHeader_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ShipmentAssayHeader_edit();
        }
    });
    var ToolStripButton_ShipmentAssayHeader_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ShipmentAssayHeader_remove();
        }
    });
    var ToolStripButton_ShipmentAssayHeader_Print = isc.ToolStripButtonPrint.create({
        icon: "[SKIN]/actions/print.png",
        title: "<spring:message code='global.form.print'/>",
        click: function () {
            var record = ListGrid_ShipmentAssayHeader.getSelectedRecord();

        }
    });
    var ToolStrip_Actions_ShipmentAssayHeader = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_ShipmentAssayHeader_Add,
            ToolStripButton_ShipmentAssayHeader_Edit,
            ToolStripButton_ShipmentAssayHeader_Remove,
            ToolStripButton_ShipmentAssayHeader_Print,
            isc.ToolStrip.create({
            width: "100%",
            align: "left",
            border: '0px',
            members: [
                ToolStripButton_ShipmentAssayHeader_Refresh,
            ]
            })

        ]
    });

    var HLayout_Actions_ShipmentAssayHeader = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_ShipmentAssayHeader
        ]
    });

    var ListGrid_ShipmentAssayHeader = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: MyRestDataSource_ShipmentAssayHeader,
        contextMenu: Menu_ListGrid_ShipmentAssayHeader,
        autoFetchData: false,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "shipmentId", title: "id", canEdit: false, hidden: true},
            {name: "shipment.contract.contractNo", title: "contractNo", canEdit: false, hidden: true},
            {name: "inspectionByContactId", title: "<spring:message code='shipment.Assay.inspectionCompany'/>", type: 'text', hidden: true},
            {name: "inspectionByContact.nameEN", title: "<spring:message code='shipment.Assay.inspectionCompany'/>", type: 'text', align: "center"},
            {name: "description",title: "<spring:message code='shipment.Assay.description'/>",type: 'text',align: "center"},
            {name: "location",title: "<spring:message code='shipment.Assay.location'/>",type: 'text',align: "center"},
            {name: "inspectionDate",title: "<spring:message code='shipment.Assay.inspectionDate'/>",type: 'text',align: "center"},
            {name: "averageCuPercent",title: "<spring:message code='shipment.Assay.averageCuPercent'/>",align: "center",type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {name: "averageAuPercent",title: "<spring:message code='shipment.Assay.averageAuPercent'/>",align: "center",type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {name: "averageAgPercent",title: "<spring:message code='shipment.Assay.averageAgPercent'/>",align: "center",type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {name: "totalDryWeight",title: "<spring:message code='shipment.Assay.totalDryWeight'/>",align: "center",type: 'float',
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
        var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "shipmentAssayHeader", operator: "equals", value: record.id}]
            };
            ListGrid_ShipmentAssayItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_ShipmentAssayItem.setData(data);
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
    var HLayout_Grid_ShipmentAssayHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentAssayHeader
        ]
    });

    var VLayout_Body_ShipmentAssayHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_Actions_ShipmentAssayHeader, HLayout_Grid_ShipmentAssayHeader
            ]
    });

    var Menu_ListGrid_ShipmentAssayItem = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_ShipmentAssayItem_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_ShipmentAssayItem.clearValues();
                    Window_ShipmentAssayItem.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_ShipmentAssayItem_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_ShipmentAssayItem_remove();
                }
            }
        ]
    });

    var ValuesManager_ShipmentAssayItem = isc.ValuesManager.create({});

    var DynamicForm_ShipmentAssayItem = isc.DynamicForm.create({
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
                {type: "RowSpacerItem"},
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentAssayHeaderId", title: "id", canEdit: false, hidden: true},
                {name: "lotNo", title: "<spring:message code='shipment.Assay.lotNo'/>",
                    type: 'integer',
                    required : true ,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "cu",
                    title: "<spring:message code='shipment.Assay.cu'/>",
                    type: 'float',
                    required : true ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "ag",
                    title: "<spring:message code='shipment.Assay.ag'/>",
                    type: 'float',
                    required : true ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "au",
                    title: "<spring:message code='shipment.Assay.au'/>",
                    type: 'float',
                    required : true ,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ]
    });
    var IButton_Shipment_Save_AssayItem = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_ShipmentAssayItem.validate();
            if (DynamicForm_ShipmentAssayItem.hasErrors()) {
                return;
            }

            var record = ListGrid_ShipmentAssayHeader.getSelectedRecord();
            DynamicForm_ShipmentAssayItem.setValue("shipmentAssayHeaderId", record.id);

            var data = DynamicForm_ShipmentAssayItem.getValues();
var methodXXXX="PUT";if (data.id==null) methodXXXX="POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
actionURL: "${contextPath}/api/shipmentAssayItem/" ,
httpMethod: methodXXXX,
                data: JSON.stringify(data),
                callback: function (RpcResponse_o) {
   if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_ShipmentAssayItem_refresh();
                        Window_ShipmentAssayItem.close();
                    } else {
                        isc.say(RpcResponse_o.data);
                    }
                }
            }));
        }
    });
    var Window_ShipmentAssayItem = isc.Window.create({
        title: "<spring:message code='shipment.AssayItem'/>",
        width: "50%",
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
            DynamicForm_ShipmentAssayItem,
            IButton_Shipment_Save_AssayItem
        ]
    });

    function ListGrid_ShipmentAssayItem_refresh() {
        ListGrid_ShipmentAssayItem.invalidateCache();
        var record = ListGrid_ShipmentAssayHeader.getSelectedRecord();
        if (record == null || record.id == null)
            return;
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "shipmentAssayHeader", operator: "equals", value: record.id}]
            };
            ListGrid_ShipmentAssayItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_ShipmentAssayItem.setData(data);
            });
    }

    function ListGrid_ShipmentAssayItem_remove() {
        var selected = ListGrid_ShipmentAssayItem.getSelection();
        if (selected == null || selected.length==0 ) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                buttonClick: function () {
                    this.hide();
                }
            });
            return;
            }
         var ids="";
         for (var i = 0; i < selected.length; i++)
            ids +=','+selected.get(i).id;
        isc.Dialog.create({
            message: "<spring:message code='global.grid.record.remove.ask'/>",
            icon: "[SKIN]ask.png",
            title: "<spring:message code='global.grid.record.remove.ask.title'/>",
            buttons: [
                isc.Button.create({ title: "<spring:message	code='global.yes'/>" }),
                isc.Button.create({title: "<spring:message code='global.no'/>"})
                ],
            buttonClick: function (button, index) {
                this.hide();
                if (index == 0) {
                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                        actionURL: "${contextPath}/api/shipmentAssayItem/list/"+ids ,
                        httpMethod: "DELETE",
                        callback: function (RpcResponse_o) {
                            if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                ListGrid_ShipmentAssayItem_refresh();
                                isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                            } else {
                                isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                            }
                        }
                    }));
                }
            }
        });
    }

    function ListGrid_ShipmentAssayItem_edit() {

        var record = ListGrid_ShipmentAssayItem.getSelectedRecord();

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
            DynamicForm_ShipmentAssayItem.editRecord(record);

            Window_ShipmentAssayItem.show();
        }
    }
    var ToolStripButton_ShipmentAssayItem_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentAssayItem_refresh();
        }
    });
    var ToolStripButton_ShipmentAssayItem_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {

            var record = ListGrid_ShipmentAssayHeader.getSelectedRecord();

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
                DynamicForm_ShipmentAssayItem.clearValues();
                Window_ShipmentAssayItem.show();
            }
        }
    });
    var ToolStripButton_ShipmentAssayItem_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            var record = ListGrid_ShipmentAssayItem.getSelectedRecord();
            if (record.id != null) {
                ListGrid_ShipmentAssayItem_edit();
            }
        }
    });
    var ToolStripButton_ShipmentAssayItem_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ShipmentAssayItem_remove();
        }
    });
    var ToolStripButton_ShipmentAssayItem_Print = isc.ToolStripButtonPrint.create({
        icon: "[SKIN]/actions/print.png",
        title: "<spring:message code='global.form.print'/>",
        click: function () {
            var record = ListGrid_ShipmentAssayItem.getSelectedRecord();

        }
    });
    var ToolStrip_Actions_ShipmentAssayItem = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members: [
            ToolStripButton_ShipmentAssayItem_Add,
            ToolStripButton_ShipmentAssayItem_Edit,
            ToolStripButton_ShipmentAssayItem_Remove,
            ToolStripButton_ShipmentAssayItem_Paste,
            ToolStripButton_ShipmentAssayItem_Print,
            isc.ToolStrip.create({
            width: "100%",
            align: "left",
            border: '0px',
            members: [
                ToolStripButton_ShipmentAssayItem_Refresh,
            ]
            })
        ]
    });

    var HLayout_Actions_ShipmentAssayItem = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_ShipmentAssayItem
        ]
    });

    var ListGrid_ShipmentAssayItem = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: MyRestDataSource_ShipmentAssayItem,
        contextMenu: Menu_ListGrid_ShipmentAssayItem,
        autoFetchData: false,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "shipmentAssayHeaderId", title: "id", canEdit: false, hidden: true},
            {name: "lotNo", title: "<spring:message code='shipment.Assay.lotNo'/>", type: 'text', align: "center"},
            {
                name: "cu",
                title: "<spring:message code='shipment.Assay.cu'/>"
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
                name: "ag",
                title: "<spring:message code='shipment.Assay.ag'/>"
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
                name: "au",
                title: "<spring:message code='shipment.Assay.au'/>"
                ,
                type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            }
        ],
        sortField: 0,
        dataPageSize: 50,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt"
    });
    var HLayout_Grid_ShipmentAssayItem = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentAssayItem
        ]
    });

    var VLayout_Body_ShipmentAssayItem = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_Actions_ShipmentAssayItem, HLayout_Grid_ShipmentAssayItem
            ]
    });

    isc.SectionStack.create({
        ID: "ShipmentAssayHeader_Section_Stack",
        sections:
            [
                {
                    title: "<spring:message code='Shipment.title'/>",
                    items: VLayout_Body_ShipmentByAssayHeader,
                    expanded: true
                }
                , {
                title: "<spring:message code='shipment.AssayHeader'/>",
                items: VLayout_Body_ShipmentAssayHeader,
                expanded: true
            }
                , {
                title: "<spring:message code='shipment.AssayItem'/>",
                items: VLayout_Body_ShipmentAssayItem,
                expanded: true
            }
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });
var criteria1 = {
	_constructor: "AdvancedCriteria",
	operator: "and",
	criteria: [{fieldName: "material.code", operator: "equals", value: "26030090"}]
};
ListGrid_ShipmentByAssayHeader.fetchData(criteria1, function (dsResponse, data, dsRequest) {
	ListGrid_ShipmentByAssayHeader.setData(data);
	});
