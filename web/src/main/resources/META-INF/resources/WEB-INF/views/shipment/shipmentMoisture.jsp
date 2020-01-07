<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var MyRestDataSource_ShipmentMoistureHeader = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "id", canEdit: false},
                {name: "shipment.contract.contractNo", title: "contractNo", canEdit: false, hidden: true},
                {
                    name: "inspectionByContactId",
                    title: "<spring:message code='shipment.MoistureInspectionCompany'/>",
                    type: 'text'
                },
                {
                    name: "inspectionByContact.nameEn",
                    title: "<spring:message code='shipment.Moisture.inspectionCompany'/>",
                    type: 'text',
                    canEdit: false
                },
                {name: "description", title: "<spring:message code='shipment.Moisture.capacity'/>", type: 'text'},
                {name: "location", title: "<spring:message code='shipment.Moisture.location'/>", type: 'text'},
                {
                    name: "inspectionDate",
                    title: "<spring:message code='shipment.Moisture.inspectionDate'/>",
                    type: 'text'
                },
                {
                    name: "totalWetWeight",
                    title: "<spring:message code='shipment.Moisture.totalWetWeight'/>",
                    type: 'text'
                },
                {
                    name: "averageMoisturePercent",
                    title: "<spring:message code='shipment.Moisture.averageMoisturePercent'/>",
                    type: 'text'
                },
                {
                    name: "totalDryWeight",
                    title: "<spring:message code='shipment.Moisture.totalDryWeight'/>",
                    type: 'text'
                },
                {
                    name: "totalH2oWeight",
                    title: "<spring:message code='shipment.Moisture.totalH2oWeight'/>",
                    type: 'text'
                },
            ],

        fetchDataURL: "${contextPath}/api/shipmentMoistureHeader/spec-list"
    });

    var MyRestDataSource_ShipmentMoistureItem = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentMoistureHeaderId", title: "id", canEdit: false, hidden: true},
                {name: "lotNo", title: "<spring:message code='shipment.Moisture.lotNo'/>", type: 'text'},
                {
                    name: "wetWeight",
                    title: "<spring:message code='shipment.Moisture.wetWeight'/>"
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
                    name: "moisturePercent",
                    title: "<spring:message code='shipment.Moisture.moisturePercent'/>"
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
                    name: "dryWeight",
                    title: "<spring:message code='shipment.Moisture.dryWeight'/>"
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
                    name: "totalH2oWeight",
                    title: "<spring:message code='shipment.Moisture.totalH2oWeight'/>"
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

        fetchDataURL: "${contextPath}/api/shipmentMoistureItem/spec-list"
    });



    var MyRestDataSource_Contact_IN_SHIPMENT_MOISTURE = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='contact.code'/>"
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='contact.nameFa'/>"
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='contact.nameEn'/>"
                },
                {
                    name: "tradeMark"
                },
                {
                    name: "ceoPassportNo"
                },
                {
                    name: "ceo"
                },
                {
                    name: "commercialRegistration"
                },
                {
                    name: "branchName"
                },
                {
                    name: "commertialRole"
                },
                {
                    name: "phone",
                    title: "<spring:message code='contact.phone'/>"
                },
                {
                    name: "mobile",
                    title: "<spring:message code='contact.mobile'/>"
                },
                {
                    name: "fax",
                    title: "<spring:message code='contact.fax'/>"
                },
                {
                    name: "address",
                    title: "<spring:message code='contact.address'/>"
                },
                {
                    name: "webSite",
                    title: "<spring:message code='contact.webSite'/>"
                },
                {
                    name: "email",
                    title: "<spring:message code='contact.email'/>"
                },
                {
                    name: "type",
                    title: "<spring:message code='contact.type'/>",
                    valueMap:
                        {
                            "true": "<spring:message code='contact.type.real'/>",
                            "false": "<spring:message code='contact.type.legal'/>"
                        }
                },
                {
                    name: "nationalcode",
                    title: "<spring:message code='contact.nationalCode'/>"
                },
                {
                    name: "economicalCode",
                    title: "<spring:message code='contact.economicalCode'/>"
                },
                {
                    name: "bankAccount",
                    title: "<spring:message code='contact.bankAccount'/>"
                },
                {
                    name: "bankShaba",
                    title: "<spring:message code='contact.bankShaba'/>"
                },
                {
                    name: "bankSwift",
                    title: "<spring:message code='contact.bankShaba'/>"
                },
                {
                    name: "bankName",
                    title: "<spring:message code='contact.bankName'/>"
                },
                {
                    name: "status",
                    title: "<spring:message code='contact.status'/>",
                    valueMap:
                        {
                            "true": "<spring:message code='enabled'/>",
                            "false": "<spring:message code='disabled'/>"
                        }
                },
                {
                    name: "contactAccounts"
                }],

            fetchDataURL: "${contextPath}/api/contact/spec-list"
        });



    var MyRestDataSource_ShipmentByMoistureHeader = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "contractShipmentId",
                    title: "<spring:message code='contact.name'/>",
                    type: 'long',
                    hidden: true
                },
                {
                    name: "contactId",
                    type: 'long',
                    hidden: true
                },
                {
                    name: "contract.contact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    type: 'text'
                },
                {
                    name: "contractId",
                    type: 'long',
                    hidden: true
                },
                {
                    name: "contract.contractNo",
                    title: "<spring:message code='contract.contractNo'/>",
                    type: 'text',
                    width: 180
                },
                {
                    name: "contract.contractDate",
                    title: "<spring:message code='contract.contractDate'/>",
                    type: 'text',
                    width: 180
                },
                {
                    name: "materialId",
                    title: "<spring:message code='contact.name'/>",
                    type: 'long',
                    hidden: true
                },
                {
                    name: "material.descl",
                    title: "<spring:message code='material.descl'/>",
                    type: 'text'
                },
                {
                    name: "material.unit.nameEN",
                    title: "<spring:message code='unit.nameEN'/>",
                    type: 'text'
                },
                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float'
                },
                {
                    name: "noContainer",
                    title: "<spring:message code='shipment.noContainer'/>",
                    type: 'integer'
                },
                {
                    name: "noPalete",
                    title: "<spring:message code='shipment.noContainer'/>",
                    type: 'integer'
                },
                {
                    name: "laycan",
                    title: "<spring:message code='shipmentContract.laycanStart'/>",
                    type: 'integer',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "shipmentType",
                    title: "<spring:message code='shipment.shipmentType'/>",
                    type: 'text',
                    width: 400,
                    valueMap:
                        {
                            "bulk": "bulk",
                            "container": "container"
                        }
                },
                {
                    name: "loadingLetter",
                    title: "<spring:message code='shipment.loadingLetter'/>",
                    type: 'text',
                    width: "10%",
                    showHover: true
                },
                {
                    name: "loading",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "portByLoadingId",
                    title: "<spring:message code='shipment.loading'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "portByLoading.port",
                    title: "<spring:message code='shipment.loading'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "portByDischargeId",
                    title: "<spring:message code='shipment.discharge'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "portByDischarge.port",
                    title: "<spring:message code='shipment.discharge'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "dischargeAddress",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "description",
                    title: "<spring:message code='shipment.description'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "swb",
                    title: "<spring:message code='shipment.SWB'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "switchPort.port",
                    title: "<spring:message code='port.switchPort'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "month",
                    title: "<spring:message code='shipment.month'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "status",
                    title: "<spring:message code='shipment.staus'/>",
                    type: 'text',
                    width: "10%",
                    valueMap:
                        {
                            "Load Ready": "<spring:message code='shipment.loadReady'/>",
                            "Resource": "<spring:message code='shipment.resource'/>"
                        }
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
                    title: "<spring:message code='shipment.createDate'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "contactByAgent.nameFA",
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
                }],
            fetchDataURL: "${contextPath}/api/shipment/spec-list"
        });


    var ShipmentMoistureItemData = [];
    for (i = 0; i < 100; i++) {
        ShipmentMoistureItemData.add({id: i});
    }

    var ClientDataSource_ShipmentMoistureItem = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "shipmentMoistureHeaderId",
                    title: "id",
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "lotNo",
                    title: "<spring:message code='shipment.Moisture.lotNo'/>",
                    type: 'text'
                },
                {
                    name: "wetWeight",
                    title: "<spring:message code='shipment.Moisture.wetWeight'/>",
                    type: 'float',
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    name: "moisturePercent",
                    title: "<spring:message code='shipment.Moisture.moisturePercent'/>",
                    type: 'float',
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    name: "dryWeight",
                    title: "<spring:message code='shipment.Moisture.dryWeight'/>",
                    type: 'float',
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                },
                {
                    name: "totalH2oWeight",
                    title: "<spring:message code='shipment.Moisture.totalH2oWeight'/>",
                    type: 'float',
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        }]
                }, ],
            testData: ShipmentMoistureItemData,
            clientOnly: true
        });

    function pasteText(text) {
        var fieldNames = [];
        ListGrid_ShipmentMoistureItemPaste.selectAllRecords();
        for (var col = 0; col < 13; col++) {
            fieldNames.add(ListGrid_ShipmentMoistureItemPaste.getFieldName(col));
        }
        var settings = {
            fieldList: fieldNames,
            fieldSeparator: "\t",
            escapingMode: "double"
        };
        var dataSource = ListGrid_ShipmentMoistureItemPaste.dataSource;
        var records = dataSource.recordsFromText(text, settings);
        ListGrid_ShipmentMoistureItemPaste.applyRecordData(records);
    }


    function createPasteDialog()
    {
        var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();
        if (record == null || record.id == null)
        {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>.",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/>."
                        })],
                    buttonClick: function()
                    {
                        this.hide();
                    }
                });
            return;
        }
        var ShipmentMoistureHeaderId = record.id;

        var PasteDialogShipmentMoistureItem_windows = isc.Window.create(
            {
                title: "Import From Excle",
                autoSize: false,
                width: "100%",
                height: "70%",
                isModal: true,
                showModalMask: true,
                showMaximizeButton: true,
                canDragResize: true,
                autoCenter: true,
                closeClick: function()
                {
                    this.Super("closeClick", arguments);
                },
                items: [
                    isc.HLayout.create(
                        {
                            membersMargin: 3,
                            width: "100%",
                            height: "100%",
                            alignLayout: "center",
                            members: [

                                isc.DynamicForm.create(
                                    {
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
                                                value: "Press Ctrl-V or right click to paste values, then click \"Apply\"."
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
                                            }, ]


                                    }) /* dynamic Form */ , ListGrid_ShipmentMoistureItemPaste = isc.ListGrid.create(
                                    {
                                        dataSource: ClientDataSource_ShipmentMoistureItem,
                                        sortDirection: "descending",
                                        width: "100%",
                                        height: "90%",
                                        canEdit: true,
                                        autoFetchData: true,
                                        canDragSelect: true,
                                        canSelectCells: true,
                                        autoSaveData: true,
                                        fields: [
                                            {
                                                name: "id",
                                                title: "id",
                                                primaryKey: true,
                                                canEdit: false,
                                                hidden: true,
                                                align: "center"
                                            },
                                            {
                                                name: "shipmentMoistureHeaderId",
                                                title: "id",
                                                canEdit: false,
                                                hidden: true,
                                                align: "center"
                                            },
                                            {
                                                name: "lotNo",
                                                title: "<spring:message code='shipment.Moisture.lotNo'/>",
                                                type: 'integer',
                                                validators: [
                                                    {
                                                        type: "isInteger",
                                                        validateOnExit: true,
                                                        stopOnError: true,
                                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                                    }],
                                                align: "center"
                                            },
                                            {
                                                name: "wetWeight",
                                                title: "<spring:message code='shipment.Moisture.wetWeight'/>",
                                                type: 'float',
                                                validators: [
                                                    {
                                                        type: "isFloat",
                                                        validateOnExit: true,
                                                        stopOnError: true,
                                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                                    }],
                                                align: "center"
                                            },
                                            {
                                                name: "moisturePercent",
                                                title: "<spring:message code='shipment.Moisture.moisturePercent'/>",
                                                type: 'float',
                                                validators: [
                                                    {
                                                        type: "isFloat",
                                                        validateOnExit: true,
                                                        stopOnError: true,
                                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                                    }],
                                                align: "center"
                                            },
                                            {
                                                name: "dryWeight",
                                                title: "<spring:message code='shipment.Moisture.dryWeight'/>",
                                                type: 'float',
                                                validators: [
                                                    {
                                                        type: "isFloat",
                                                        validateOnExit: true,
                                                        stopOnError: true,
                                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                                    }],
                                                align: "center"
                                            },
                                            {
                                                name: "totalH2oWeight",
                                                title: "<spring:message code='shipment.Moisture.totalH2oWeight'/>",
                                                type: 'float',
                                                validators: [
                                                    {
                                                        type: "isFloat",
                                                        validateOnExit: true,
                                                        stopOnError: true,
                                                        errorMessage: "<spring:message code='global.form.correctType'/>"
                                                    }],
                                                align: "center"
                                            }, ]
                                    })

                            ]
                        }),
                    isc.HLayout.create(
                        {
                            membersMargin: 3,
                            width: "100%",
                            alignLayout: "center",
                            members: [
                                isc.Button.create(
                                    {
                                        title: "Apply",
                                        width: 300,
                                        click: function(form)
                                        {
                                            pasteText(resultsForm.getValue("textArea"));
                                            ListGrid_ShipmentMoistureItemPaste.saveAllEdits();
                                        }
                                    }),

                                isc.IButtonSave.create(
                                    {
                                        title: "<spring:message code='global.form.save'/>",
                                        prompt: "<spring:message code='shipment.Moisture.saveButton'/>",
                                        icon: "pieces/16/save.png",
                                        width: 300,
                                        click: function()
                                        {
                                            resultsForm.validate();
                                            if (resultsForm.hasErrors())
                                                return;
                                            var selected = ListGrid_ShipmentMoistureItemPaste.getSelection();

                                            resultsForm.setValue("selected", selected)

                                            resultsForm.setValue("ShipmentMoistureHeaderId", ShipmentMoistureHeaderId);
                                            var data = resultsForm.getValues();
                                            var methodXXXX = "PUT";
                                            if (data.id == null) methodXXXX = "POST";
                                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                                {
                                                    actionURL: "${contextPath}/api/shipmentMoistureItem/addMoisturePaste",
                                                    httpMethod: methodXXXX,
                                                    data: JSON.stringify(data),
                                                    callback: function(resp)
                                                    {
                                                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201)
                                                        {
                                                            isc.say("<spring:message code='global.form.request.successful'/>");
                                                            ListGrid_ShipmentMoistureItem_refresh();
                                                            PasteDialogShipmentMoistureItem_windows.close();
                                                        }
                                                        else
                                                            isc.say(RpcResponse_o.data);
                                                    }
                                                }));
                                        }
                                    }),
                            ]
                        })
                ]
            });
    }


    var ToolStripButton_ShipmentMoistureItem_Paste = isc.ToolStripButton.create({
        icon: "[SKIN]/RichTextEditor/paste.png",
        title: "Paste Cells",
        click: function () {
            createPasteDialog();
        }
    });


        var recordNotFound = isc.Label.create({
            height: 30,
            padding: 10,
            align: "center",
            valign: "center",
            wrap: false,
            contents: "رکوردی یافت نشد"
        });

        recordNotFound.hide();

        function setCriteria_ListGrid_InsperctionContract(recordId) {

            var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: recordId}]
            };

        ListGrid_ShipmentMoistureHeader.fetchData(criteria1, function (dsResponse, data, dsRequest) {
        if (data.length === 0) {
        recordNotFound.show();
        ListGrid_ShipmentMoistureHeader.hide()
        } else {
        recordNotFound.hide();
        ListGrid_ShipmentMoistureHeader.setData(data);
        ListGrid_ShipmentMoistureHeader.show();
        }
        }, {operationId: "00"});
        }

        function getExpandedComponent(record) {
        setCriteria_ListGrid_InsperctionContract(record.id)
        var hLayout = isc.HLayout.create({
        align: "center", padding: 5,
        membersMargin: 20,
        members: [
        ToolStripButton_ShipmentMoistureHeader_Add
        ]
        });

        var layout = isc.VLayout.create({
        padding: 5,
        membersMargin: 10,
        members: [ListGrid_ShipmentMoistureHeader, recordNotFound, hLayout]
        });

        return layout;
        }

    var ListGrid_ShipmentByMoistureHeader = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: MyRestDataSource_ShipmentByMoistureHeader,
        styleName: 'expandList',
        autoFetchData: true,
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
        fields: [
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
/*        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
            };
            ListGrid_ShipmentMoistureHeader.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_ShipmentMoistureHeader.setData(data);
                var recordH = ListGrid_ShipmentMoistureHeader.getRecord(0);

                if (ListGrid_ShipmentMoistureHeader.getRecord(0) != null)
                    criteria1 = {
                        _constructor: "AdvancedCriteria",
                        operator: "and",
                        criteria: [{fieldName: "shipmentMoistureHeader", operator: "equals", value: recordH.id}]
                    };
                else
                    criteria1 = {
                        _constructor: "AdvancedCriteria",
                        operator: "and",
                        criteria: [{fieldName: "shipmentMoistureHeader", operator: "equals", value: -999999999}]
                    };

                ListGrid_ShipmentMoistureItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                    ListGrid_ShipmentMoistureItem.setData(data);
                });
            });
        },*/
        getExpansionComponent: function (record) {
        return getExpandedComponent(record)
        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        dataPageSize: 50,
        showFilterEditor: true,
        filterOnKeypress: true
    });

    var HLayout_Grid_ShipmentByMoistureHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentByMoistureHeader
        ]
    });

    var VLayout_Body_ShipmentByMoistureHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_ShipmentByMoistureHeader
        ]
    });

    var criteria1Inspector = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "inspector", operator: "equals", value: true}]
    };

    var DynamicForm_ShipmentMoistureHeader = isc.DynamicForm.create({
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
                {name: "id", hidden: true},
                {name: "shipmentId", hidden: true},
                {type: "RowSpacerItem"},
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "id", canEdit: false, hidden: true},
                {
                    name: "inspectionByContactId",
                    title: "<spring:message code='shipment.MoistureInspectionCompany'/>",
                    type: 'long',
                    editorType: "SelectItem",
                    colSpan: 1,
                    titleColSpan: 1,
                    required: true
                    ,
                    optionDataSource: MyRestDataSource_Contact_IN_SHIPMENT_MOISTURE,
                    displayField: "nameEN",
                    wrapTitle: false,
                    optionCriteria: criteria1Inspector
                    ,
                    valueField: "id",
                    pickListWidth: "450",
                    pickListheight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "nameFA", width: 150, align: "center"}, {
                        name: "nameEN",
                        width: 150,
                        align: "center"
                    }, {name: "code", width: 150, align: "center"}]
                },
                {
                    name: "location",
                    title: "<spring:message code='shipment.Moisture.location'/>",
                    type: 'text',
                    wrapTitle: false,
                    required: true,
                    valueMap: {"source": "source", "destination": "destination"}
                },
                {
                    name: "inspectionDate",
                    title: "<spring:message code='shipment.Moisture.inspectionDate'/>",
                    type: 'text',
                    hidden: true
                },
                {
                    name: "inspectionDateDummy",
                    title: "<spring:message code='shipment.Moisture.inspectionDate'/>",
                    type: 'date',
                    wrapTitle: false,
                },
                {
                    name: "totalWetWeight",
                    title: "<spring:message code='shipment.Moisture.totalWetWeight'/>",
                    wrapTitle: false,
                    required: true
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
                    name: "averageMoisturePercent",
                    title: "<spring:message code='shipment.Moisture.averageMoisturePercent'/>",
                    wrapTitle: false
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
                    name: "totalDryWeight",
                    title: "<spring:message code='shipment.Moisture.totalDryWeight'/>",
                    wrapTitle: false,
                    required: true
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
                    name: "totalH2oWeight",
                    title: "<spring:message code='shipment.Moisture.totalH2oWeight'/>",
                    wrapTitle: false
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
                    name: "description",
                    title: "<spring:message code='shipment.Moisture.description'/>",
                    type: 'textArea',
                    width: "600",
                    colSpan: 4
                },
            ]
    });

    var IButton_Shipment_Save_MoistureHeader = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {

            var d = DynamicForm_ShipmentMoistureHeader.getValue("inspectionDateDummy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
            DynamicForm_ShipmentMoistureHeader.setValue("inspectionDate", datestring)

            DynamicForm_ShipmentMoistureHeader.validate();
            if (DynamicForm_ShipmentMoistureHeader.hasErrors()) {
                return;
            }

            var record = ListGrid_ShipmentByMoistureHeader.getSelectedRecord();
            DynamicForm_ShipmentMoistureHeader.setValue("shipmentId", record.id);

            var data = DynamicForm_ShipmentMoistureHeader.getValues();

            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";

            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/shipmentMoistureHeader/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_ShipmentMoistureHeader_refresh();
                            Window_ShipmentMoistureHeader.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );

        }
    });

    var Window_ShipmentMoistureHeader = isc.Window.create({
        title: "<spring:message code='shipment.MoistureHeader'/>",
        width: "50%",
        hight: "30%",
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
            DynamicForm_ShipmentMoistureHeader,
            isc.HLayout.create({
            width: "100%", align: "center", margin:30, height: "60",
            members:
                [
                IButton_Shipment_Save_MoistureHeader
                ]
            })
        ]
    });

    function ListGrid_ShipmentMoistureHeader_refresh() {
        ListGrid_ShipmentMoistureHeader.invalidateCache();
        var record = ListGrid_ShipmentByMoistureHeader.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
        };
        ListGrid_ShipmentMoistureHeader.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_ShipmentMoistureHeader.setData(data);
        });
    }

    function ListGrid_ShipmentMoistureHeader_remove() {
        var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}), isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index === 0) {

                        var shipmentId = record.id;

                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/shipmentMoistureHeader/" + shipmentId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                        ListGrid_ShipmentMoistureHeader_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
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

    function ListGrid_ShipmentMoistureHeader_edit() {
        var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();

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
        } else if (record.shipmentId != null) {
            DynamicForm_ShipmentMoistureHeader.editRecord(record);
            DynamicForm_ShipmentMoistureHeader.setValue("inspectionDateDummy", new Date(record.inspectionDate));
            Window_ShipmentMoistureHeader.show();
        }
    }

    var ToolStripButton_ShipmentMoistureHeader_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentMoistureHeader_refresh();
        }
    });

    var ToolStripButton_ShipmentMoistureHeader_Add = isc.ToolStripButtonAddLarge.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {

            var record = ListGrid_ShipmentByMoistureHeader.getSelectedRecord();

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
                DynamicForm_ShipmentMoistureHeader.clearValues();
                Window_ShipmentMoistureHeader.show();
            }
        }
    });

    var ToolStripButton_ShipmentMoistureHeader_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ShipmentMoistureHeader_edit();
        }
    });

    var ToolStripButton_ShipmentMoistureHeader_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ShipmentMoistureHeader_remove();
        }
    });

    var ToolStrip_Actions_ShipmentMoistureHeader = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members: [
            ToolStripButton_ShipmentMoistureHeader_Add,
            ToolStripButton_ShipmentMoistureHeader_Edit,
            ToolStripButton_ShipmentMoistureHeader_Remove,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_ShipmentMoistureHeader_Refresh,
                ]
            })

        ]
    });

    var HLayout_Actions_ShipmentMoistureHeader = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_ShipmentMoistureHeader
        ]
    });

    var ListGrid_ShipmentMoistureHeader = isc.ListGrid.create({
        width: "100%",
        height: 200,
        dataSource: MyRestDataSource_ShipmentMoistureHeader,
        autoFetchData: false,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "shipmentId", title: "id", canEdit: false, hidden: true},
            {name: "shipment.contract.contractNo", title: "contractNo", canEdit: false, hidden: true},
            {
                name: "inspectionByContactId",
                title: "<spring:message code='shipment.MoistureInspectionCompany'/>",
                type: 'text',
                hidden: true
            },
            {
                name: "inspectionByContact.nameEN",
                title: "<spring:message code='shipment.Moisture.inspectionCompany'/>",
                type: 'text',
                align: "center"
            },
            {
                name: "description",
                title: "<spring:message code='shipment.Moisture.description'/>",
                type: 'text',
                align: "center"
            },
            {
                name: "location",
                title: "<spring:message code='shipment.Moisture.location'/>",
                type: 'text',
                align: "center"
            },
            {
                name: "inspectionDate",
                title: "<spring:message code='shipment.Moisture.inspectionDate'/>",
                type: 'text',
                align: "center"
            },
            {
                name: "totalWetWeight",
                title: "<spring:message code='shipment.Moisture.totalWetWeight'/>",
                type: 'text',
                align: "center"
            },
            {
                name: "averageMoisturePercent",
                title: "<spring:message code='shipment.Moisture.averageMoisturePercent'/>",
                type: 'text',
                align: "center"
            },
            {
                name: "totalDryWeight",
                title: "<spring:message code='shipment.Moisture.totalDryWeight'/>",
                type: 'text',
                align: "center"
            },
            {
                name: "totalH2oWeight",
                title: "<spring:message code='shipment.Moisture.totalH2oWeight'/>",
                type: 'text',
                align: "center",
                wrapTitle: false
            },
            {
            name: "editIcon",
            width: 40,
            align: "center",
            showTitle: false
            },
            {
            name: "removeIcon",
            width: 40,
            align: "center",
            showTitle: false
            }
        ],
/*        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "shipmentMoistureHeader", operator: "equals", value: record.id}]
            };
            ListGrid_ShipmentMoistureItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_ShipmentMoistureItem.setData(data);
            });
        },*/
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        dataPageSize: 50,
        showFilterEditor: true,
        filterOnKeypress: true,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        createRecordComponent: function (record, colNum) {
        var fieldName = this.getFieldName(colNum);
        if (fieldName == "editIcon") {
        var editImg = isc.ImgButton.create({
        showDown: false,
        showRollOver: false,
        layoutAlign: "center",
        src: "pieces/16/icon_edit.png",
        prompt: "ویرایش",
        height: 16,
        width: 16,
        grid: this,
        click: function () {
        ListGrid_ShipmentMoistureHeader.selectSingleRecord(record);
        ListGrid_ShipmentMoistureHeader_edit();
        }
        });
        return editImg;
        } else if (fieldName == "removeIcon") {
        var removeImg = isc.ImgButton.create({
        showDown: false,
        showRollOver: false,
        layoutAlign: "center",
        src: "pieces/16/icon_delete.png",
        prompt: "حذف",
        height: 16,
        width: 16,
        grid: this,
        click: function () {
        ListGrid_ShipmentMoistureHeader.selectSingleRecord(record);
        ListGrid_ShipmentMoistureHeader_remove();
        }
        });
        return removeImg;
        } else {
        return null;
        }
        },
        recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
         loadWindowFeatureList(record)
        }
    });


        function loadWindowFeatureList(record) {
            var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentMoistureHeader", operator: "equals", value: record.id}]
            };
            ListGrid_ShipmentMoistureItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_ShipmentMoistureItem.setData(data);
            });

            var window_view_url = isc.Window.create({
            title: "<spring:message code='Shipment.titleMoistureItem'/>",
            width: "80%",
            height: "40%",
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
            HLayout_Actions_ShipmentMoistureItem, HLayout_Grid_ShipmentMoistureItem
            ]
            });

            window_view_url.show();
        }

    var HLayout_Grid_ShipmentMoistureHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentMoistureHeader
        ]
    });

    var VLayout_Body_ShipmentMoistureHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_Actions_ShipmentMoistureHeader, HLayout_Grid_ShipmentMoistureHeader
            ]
    });

    var DynamicForm_ShipmentMoistureItem = isc.DynamicForm.create({
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
                {name: "shipmentMoistureHeaderId", title: "id", canEdit: false, hidden: true},
                {
                    name: "lotNo",
                    title: "<spring:message code='shipment.Moisture.lotNo'/>",
                    type: 'text',
                    wrapTitle: false,
                    required: true
                },
                {
                    name: "wetWeight",
                    title: "<spring:message code='shipment.Moisture.wetWeight'/>",
                    wrapTitle: false,
                    required: true
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
                    name: "moisturePercent",
                    title: "<spring:message code='shipment.Moisture.moisturePercent'/>",
                    wrapTitle: false
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
                    name: "dryWeight",
                    title: "<spring:message code='shipment.Moisture.dryWeight'/>",
                    wrapTitle: false,
                    required: true
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
                    name: "totalH2oWeight",
                    title: "<spring:message code='shipment.Moisture.totalH2oWeight'/>",
                    wrapTitle: false
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

    var IButton_Shipment_Save_MoistureItem = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_ShipmentMoistureItem.validate();
            if (DynamicForm_ShipmentMoistureItem.hasErrors()) {
                return;
            }

            var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();
            DynamicForm_ShipmentMoistureItem.setValue("shipmentMoistureHeaderId", record.id);

            var data = DynamicForm_ShipmentMoistureItem.getValues();

            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";


            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/shipmentMoistureItem/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_ShipmentMoistureItem_refresh();
                            Window_ShipmentMoistureItem.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    var Window_ShipmentMoistureItem = isc.Window.create({
        title: "<spring:message code='shipment.MoistureItem'/>",
        width: "50%",
        //height: "30%",
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
            DynamicForm_ShipmentMoistureItem,
            isc.HLayout.create({
            width: "100%", align: "center", margin:30, height: "60",
            members:
            [
                IButton_Shipment_Save_MoistureItem
            ]
            })
        ]
    });

    function ListGrid_ShipmentMoistureItem_refresh() {
        ListGrid_ShipmentMoistureItem.invalidateCache();
        var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentMoistureHeaderId", operator: "equals", value: record.id}]
        };
        ListGrid_ShipmentMoistureItem.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_ShipmentMoistureItem.setData(data);
        });
    }

    function ListGrid_ShipmentMoistureItem_remove() {
        var selected = ListGrid_ShipmentMoistureItem.getSelection();
        if (selected == null || selected.length === 0) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
                buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>."})],
                buttonClick: function () {
                    this.hide();
                }
            });
            return;
        }
        var ids = "";
        for (var i = 0; i < selected.length; i++)
            ids += ',' + selected.get(i).id;
        isc.Dialog.create({
            message: "<spring:message code='global.grid.record.remove.ask'/>",
            icon: "[SKIN]ask.png",
            title: "<spring:message code='global.grid.record.remove.ask.title'/>",
            buttons: [
                isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}),
                isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})
            ],
            buttonClick: function (button, index) {
                this.hide();
                if (index === 0) {
                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                            actionURL: "${contextPath}/api/shipmentMoistureItem/list/" + ids,
                            httpMethod: "DELETE",
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                    ListGrid_ShipmentMoistureItem_refresh();
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>");
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

    function ListGrid_ShipmentMoistureItem_edit() {
        var record = ListGrid_ShipmentMoistureItem.getSelectedRecord();

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
            DynamicForm_ShipmentMoistureItem.editRecord(record);
            DynamicForm_ShipmentMoistureItem.setValue("inspectionDateDummy", new Date(record.inspectionDate));
            Window_ShipmentMoistureItem.show();
        }
    }
    var ToolStripButton_ShipmentMoistureItem_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentMoistureItem_refresh();
        }
    });

    var ToolStripButton_ShipmentMoistureItem_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_ShipmentMoistureHeader.getSelectedRecord();

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
                DynamicForm_ShipmentMoistureItem.clearValues();
                Window_ShipmentMoistureItem.show();
            }
        }
    });

    var ToolStripButton_ShipmentMoistureItem_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ShipmentMoistureItem_edit();
        }
    });

    var ToolStripButton_ShipmentMoistureItem_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ShipmentMoistureItem_remove();
        }
    });

    var ToolStrip_Actions_ShipmentMoistureItem = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members: [
            ToolStripButton_ShipmentMoistureItem_Add,
            ToolStripButton_ShipmentMoistureItem_Edit,
            ToolStripButton_ShipmentMoistureItem_Remove,
            ToolStripButton_ShipmentMoistureItem_Paste,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_ShipmentMoistureItem_Refresh,
                ]
            })

        ]
    });

    var HLayout_Actions_ShipmentMoistureItem = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_ShipmentMoistureItem
        ]
    });

    var ListGrid_ShipmentMoistureItem = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: MyRestDataSource_ShipmentMoistureItem,
        autoFetchData: false,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "shipmentMoistureHeaderId", title: "id", canEdit: false, hidden: true},
            {name: "lotNo", title: "<spring:message code='shipment.Moisture.lotNo'/>", type: 'text', align: "center"},
            {
                name: "wetWeight",
                title: "<spring:message code='shipment.Moisture.wetWeight'/>"
                ,
                type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }],
                align: "center"
            },
            {
                name: "moisturePercent",
                title: "<spring:message code='shipment.Moisture.moisturePercent'/>"
                ,
                type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }],
                align: "center"
            },
            {
                name: "dryWeight",
                title: "<spring:message code='shipment.Moisture.dryWeight'/>"
                ,
                type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }],
                align: "center"
            },
            {
                name: "totalH2oWeight",
                title: "<spring:message code='shipment.Moisture.totalH2oWeight'/>"
                ,
                type: 'float',
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }],
                align: "center"
            },
        ],
        sortField: 0,
        dataPageSize: 50,
        showFilterEditor: true,
        filterOnKeypress: true
    });
    var HLayout_Grid_ShipmentMoistureItem = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentMoistureItem
        ]
    });

    var VLayout_Body_ShipmentMoistureItem = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_Actions_ShipmentMoistureItem, HLayout_Grid_ShipmentMoistureItem
            ]
    });

    isc.SectionStack.create({
        ID: "ShipmentMoistureHeader_Section_Stack",
        sections:
            [
                {
                    title: "<spring:message code='Shipment.title'/>",
                    items: VLayout_Body_ShipmentByMoistureHeader,
                    expanded: true,
                    showHeader: false
                }
                , {
                title: "<spring:message code='Shipment.titleMoistureHeader'/>",
                items: VLayout_Body_ShipmentMoistureHeader,
                expanded: true,
                hidden: true
            }
                , {
                title: "<spring:message code='Shipment.titleMoistureItem'/>",
                items: VLayout_Body_ShipmentMoistureItem,
                expanded: true,
                hidden: true
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

    ListGrid_ShipmentByMoistureHeader.fetchData(criteria1, function (dsResponse, data, dsRequest) {
        ListGrid_ShipmentByMoistureHeader.setData(data);
    });