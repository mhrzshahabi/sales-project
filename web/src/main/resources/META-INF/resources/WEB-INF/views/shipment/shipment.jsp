<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>


    function toEnglishDigits(str) {
        const persianNumbers = ["۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹", "۰"]
        const arabicNumbers = ["١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩", "٠"]
        const englishNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        return str.split("").map(c => englishNumbers[persianNumbers.indexOf(c)] ||
            englishNumbers[arabicNumbers.indexOf(c)] || c).join("")
    };

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    var contractId;

    var RestDataSource_Contact__SHIPMENT = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/>"},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
                {name: "commertialRole"},
                {name: "phone", title: "<spring:message code='contact.phone'/>"},
                {name: "mobile", title: "<spring:message code='contact.mobile'/>"},
                {
                    name: "type", title: "<spring:message code='contact.type'/>",
                    valueMap: {
                        "true": "<spring:message code='contact.type.real'/>",
                        "false": "<spring:message code='contact.type.legal'/>"
                    }
                },
                {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
                {
                    name: "status", title: "<spring:message code='contact.status'/>",
                    valueMap: {
                        "true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"
                    }
                },
                {name: "contactAccounts"},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>"},

                {name: "bookingCat", title: "<spring:message code='shipment.bookingCat'/>", align: "center"}


            ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });

    var RestDataSource_LoadingPort = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "beam", title: "<spring:message code='port.port'/>", width: 200},
                {name: "loa", title: "<spring:message code='port.port'/>", width: 200},
                {name: "arrival", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],

        fetchDataURL: "${contextPath}/api/port/spec-list"
    });

    var RestDataSource_Dcc = isc.MyRestDataSource.create({
        fields: [
            {name: "id", hidden: true, primaryKey: true, canEdit: false,},
            {
                name: "documentType",
                title: "<spring:message code='dcc.documentType'/>",
                type: 'text',
                required: true,
                width: 400
                ,
                valueMap: {
                    "letter": "<spring:message code='dcc.letter'/>",
                    "image": "<spring:message code='dcc.image'/>"
                },
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "description",
                title: "<spring:message code='global.description'/>",
                type: 'text',
                width: 400
            },
            {
                name: "fileName",
                title: "<spring:message code='global.fileName'/>",
                type: 'text',
                required: true,
                width: 400,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },
            {name: "fileNewName", title: "<spring:message code='global.fileNewName'/>", type: 'text', width: 400}
        ],
        fetchDataURL: "${contextPath}/api/dcc/spec-list"
    });

    var RestDataSource_VesselInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "name", title: "<spring:message code='vessel.name'/>"},
                {name: "type", title: "<spring:message code='vessel.type'/>"},
                {name: "imo", title: "<spring:message code='vessel.imo'/>"},
                {name: "yearOfBuild", title: "<spring:message code='vessel.year.of.build'/>"},
                {name: "length", title: "<spring:message code='vessel.length'/>"},
                {name: "beam", title: "<spring:message code='vessel.beam'/>"}
            ],

        fetchDataURL: "${contextPath}/api/vessel/spec-list"
    });

    var RestDataSource_UnitInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "nameFA", title: "<spring:message code='unit.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='unit.nameEN'/>"},
            ],
        fetchDataURL: "${contextPath}/api/unit/spec-list"
    });

    var RestDataSource_ShipmentTypeInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentType", title: "<spring:message code='shipment.type'/>"},
            ],
        fetchDataURL: "${contextPath}/api/shipmentType/spec-list"
    });

    var RestDataSource_ShipmentMethodInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentMethod", title: "<spring:message code='shipment.method'/>"},
            ],
        fetchDataURL: "${contextPath}/api/shipmentMethod/spec-list"
    });

    var RestDataSource_Port = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='billOfLanding.port.of.discharge'/>"},
            ],
        fetchDataURL: "${contextPath}/api/port/spec-list"
    });

    var RestDataSource_pickShipmentItem = isc.MyRestDataSource.create({
        fields:
            [
                {name: "cisId", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "quantity", title: "<spring:message code='global.quantity'/> "},
                {name: "sendDate", title: "<spring:message code='global.sendDate'/> "},
                {name: "contractId", title: "contractId"},
                {name: "loadPortId", title: "<spring:message code='shipment.loading'/>"},
            ],
        transformRequest: function (dsRequest) {

            dsRequest.params = {
                code: JSON.parse('${Enum_EContractDetailTypeCode}').ShipmentDetailCode,
                contractDetailValueKey: JSON.parse('${Enum_EContractDetailValueKey}').NotImportant
            };

            let contractId1 = DynamicForm_Shipment.getValue("contractId");
            if(contractId1)
                dsRequest.params.contractId = contractId1;

            this.Super("transformRequest", arguments);
        },
        fetchDataURL: "${contextPath}/api/g-contract/latest-version-of-data-response"
    });

    var RestDataSource_pickContractItem = isc.MyRestDataSource.create({
        fields:
            [{name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "no", title: "<spring:message code='contract.contractNo'/> "},

            ],
        fetchDataURL: "${contextPath}/api/g-contract/spec-list"
    });

    var RestDataSource_Shipment__SHIPMENT = isc.MyRestDataSource.create({
        fields: [
            {type: "Header", defaultValue: ""},
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contract.contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: 'text'
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.no",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: 180
            },
            {name: "materialId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "material.descl", title: "<spring:message code='material.descl'/>", type: 'text'},
            {name: "material.descp", title: "<spring:message code='material.descp'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "unitId", title: "<spring:message code='unit.title'/>"},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "noPallet", title: "<spring:message code='shipment.noPallet'/>", type: 'integer'},
            {name: "weightGW", title: "<spring:message code='shipment.gross'/>"},
            {name: "weightND", title: "<spring:message code='shipment.net'/>"},
            {name: "moisture", title: "<spring:message code='shipment.moisture'/>"},
            {name: "vgm", title: "<spring:message code='shipment.vgm'/>"},
            {
                name: "shipmentType.shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
            },
            {
                name: "shipmentMethod.shipmentMethod",
                title: "<spring:message code='shipment.shipmentMethod'/>",
                type: 'text',
            },
            {
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "10%",
                showHover: true,

            },
            {
                name: "automationLetterNo",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {name: "loading", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "description", title: "<spring:message code='shipment.description'/>", type: 'text', width: "10%"},
            {
                name: "status",
                title: "<spring:message code='shipment.staus'/>",
                type: 'text',
                width: "10%",
                valueMap: {
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
                showHover: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
                name: "automationLetterDate",
                title: "<spring:message code='shipment.bDate'/>",
                type: 'text',
                width: "10%"
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
                name: "vessel.name",
                title: "<spring:message code='vessel.name'/>",
                type: 'text',
            },
            {
                name: "shipmentTypeId",
                hidden : true
            }
        ],
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });

    var shipmentDccDynamicFormPrint = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        titleWidth: "100",
        numCols: 2,
        fields:
            [
                {
                    name: "dccId",
                    title: "<spring:message code='shipment.loading.pattern'/>",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Dcc,
                    displayField: "fileNewName",
                    autoFetchData: false,
                    valueField: "id",
                    width: 300,
                    wrapTitle: false,
                    required: true ,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    pickListProperties: {
                        showFilterEditor: true
                    },
                    pickListFields: [
                    {
                        name: "fileNewName",
                        title: "<spring:message code='global.fileNewName'/>",
                        showHover: true
                    }
                    ],
                     getPickListFilterCriteria  : function () {
                        let record = ListGrid_Shipment.getSelectedRecord();
                        let fileNewName = "ShipOrder_" +record.materialId+"_" +record.shipmentTypeId;
                        var criteria={"_constructor":"AdvancedCriteria","operator":"and",
                                                    "criteria":[{"fieldName":"fileNewName","operator":"startsWith","value":fileNewName}]}
                            return criteria;
                    },
                }
    ]
    });

    var IButton_Shipment_Dcc_Print = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.print'/>",
        icon: "[SKIN]/actions/print.png",
        click: function () {
             "<spring:url value="/shipment/print/" var="printUrl"/>";
             let fileNewName = shipmentDccDynamicFormPrint.getItem("dccId").getDisplayValue();
             let record = ListGrid_Shipment.getSelectedRecord();
            window.open('${printUrl}' + record.id + "/" + fileNewName);
        }
    });
    var CancelBtn_Shipment_Dcc = isc.IButtonCancel.create({
        icon: "pieces/16/icon_delete.png",
        title: "<spring:message code='global.form.close'/>",
        click: function () {
            shipmentDccWindow.close();
        }
    });

     var hLayout_shipment_dcc = isc.HLayout.create({
        layoutMargin: 10,
        membersMargin: 5,
        textAlign: "center",
        align: "center",
        members: [
            IButton_Shipment_Dcc_Print,
            CancelBtn_Shipment_Dcc
        ]
    });

     var vLayout_shipment_dcc = isc.VLayout.create({
        width: 300,
        textAlign: "center",
        align: "center",
        members: [
            shipmentDccDynamicFormPrint,
            hLayout_shipment_dcc
        ]
    });

    var shipmentDccWindow = isc.Window.create({
        title: "<spring:message code='shipment.loading.pattern'/> ",
        width: 500,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        canDragReposition: false,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                vLayout_shipment_dcc
            ]
    });
    function check_Shipment_Print() {
        let record = ListGrid_Shipment.getSelectedRecord();
        if (record == null) {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            shipmentDccWindow.show();
        }
    }

    var Menu_ListGrid_Shipment = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Shipment_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_SHIPMENT')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    ListGrid_Shipment_add();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_SHIPMENT')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Shipment_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_SHIPMENT')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Shipment_remove();
                }
            },
            </sec:authorize>
            {isSeparator: true},
            {
                title: "<spring:message code='global.form.print.word'/>",
                click: function () {
                    let record = ListGrid_Shipment.getSelectedRecord();
                    if (record.shipmentType.shipmentType == "پالت" || (record.materialId ==
                        ImportantIDs.material.COPPER_CONCENTRATES &&
                        record.shipmentType.shipmentType.contains("انتینر")) ||
                        (record.materialId == ImportantIDs.material.MOLYBDENUM_OXIDE &&
                            record.shipmentType.shipmentType.contains("فله"))) {
                        isc.say("<spring:message code='global.print.not.exist'/>");
                        return;
                    }
                    check_Shipment_Print();
                }
            }

        ]
    });

    function setBuyerName(buyerId) {
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contact/" + buyerId,
                httpMethod: "GET",
                callback: function (RpcResponse_o) {
                    DynamicForm_Shipment.setValue("contract.contact.nameFA", JSON.parse(RpcResponse_o.data).nameFA);
                }
            })
        );
    }

    var dash = "\n";

    var ShipmentDccViewLoader = isc.ViewLoader.create({
    autoDraw: false,
    loadingMessage: ""
    });

    var Window_Shipment_Dcc = isc.Window.create({
            title: "<spring:message code='shipment.loading.pattern'/>",
            width: "40%",
            height: "60%",
            autoCenter: true,
            align: "center",
            autoDraw: false,
            dismissOnEscape: true,
            closeClick: function () {
            this.Super("closeClick", arguments)
            },
            items:
            [
            ShipmentDccViewLoader
            ]
    });

    var DynamicForm_Shipment = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        titleWidth: "170",
        numCols: 4,
        fields: [
            {type: "header"},
            {name: "id", hidden: true},
            {name: "contactId", hidden: true},
            {name: "materialId", hidden: true,},
            {
                name: "contractId", ID: "abal", colSpan: 1,
                title: "<spring:message code='contract.contractNo'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_pickContractItem,
                optionCriteria: {operator: "and", criteria: [{fieldName: "parentId", operator: "isNull"}]},
                displayField: "no",
                valueField: "id",
                pickListHeight: "500",
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                pickListFields: [
                    {
                        name: "no",
                        width: "10%",
                        align: "center",
                        title: "<spring:message code='contract.contractNo'/>"
                    },
                ],
                changed: function (form, item, value) {
                    let record = DynamicForm_Shipment.getItem("contractId").getSelectedRecord();
                    let buyerId = record.contractContacts.filter(c => (c.commercialRole === 'Buyer'))[0].contactId;
                    setBuyerName(buyerId);
                    DynamicForm_Shipment.setValue("material.descp", record.material.descp);
                    DynamicForm_Shipment.setValue("contactId", buyerId);
                    DynamicForm_Shipment.setValue("materialId", record.materialId);
                }
            },
            {
                name: "contractShipmentId", ID: "shipment",
                title: "<spring:message code='shipmentContract.list'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_pickShipmentItem,
                displayField: "sendDate",
                valueField: "id",
                pickListHeight: "500",
                required: true,
                autoFetchData: false,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                pickListFields: [
                    {name: "loadPort.port", title: "<spring:message code='shipment.loading'/>"},
                    {name: "quantity"},
                    {name: "sendDate"},
                ],
                changed: function (form, item, value) {
                    let d = new Date(item.getSelectedRecord().sendDate);
                    DynamicForm_Shipment.setValue("sendDate", d);
                }
            },
            {
                name: "shipmentSendDate", ID: "shipmentSendDate",
                title: "<spring:message code='shipmentContract.list'/>",
                hidden: true,
                type: "staticText",
            },
            {
                name: "contract.contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: "staticText"
            },
            {
                name: "material.descp",
                title: "<spring:message code='material.title'/>",
                type: "staticText"
            },
            {
                name: "sendDate",
                type: "date",
                title: "<spring:message code='global.sendDate'/>",
            },
            {name: "contractDate", hidden: true,},
            {
                name: "automationLetterDate",
                title: "<spring:message code='shipment.bDate'/>",
                ID: "automationLetterDateId",
                icons: [{
                    src: "pieces/pcal.png",
                    click: function () {
                        displayDatePicker('automationLetterDateId', this, 'ymd', '/');
                    }
                }],
// defaultValue: "1399/01/01",
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
            },
            {
                name: "automationLetterNo",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                required: true,
                length: "100",
                width: "100%",
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "100%",
                required: true,
            },

            {
                name: "arrivalDateFrom",
                type: "date",
                title: "<spring:message code='shipment.arrivalDateFrom'/>",
            },
            {
                name: "arrivalDateTo",
                type: "date",
                title: "<spring:message code='shipment.arrivalDateTo'/>",
            },
            {
                name: "amount",
                title: "<spring:message code='global.amount'/>",
                type: 'float',
                required: true,
                width: "100%",
                length: 9,
                keyPressFilter: "[0-9.]",
                validators: [{
                    type: "isFloat",
                    validateOnChange: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                },
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
               name: "lastDeliveryLetterDate",
               type: "date",
               title: "<spring:message code='shipment.lastDeliveryLetterDate'/>",
            },
            {
                name: "unitId",
                title: "<spring:message code='unit.title'/>",
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_UnitInShipment,
                optionCriteria: RestDataSource_UNIT_optionCriteria,
                displayField: "nameFA",
                valueField: "id",
                pickListHeight: "500",
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {
                        name: "nameFA",
                        width: "10%",
                        align: "center"
                    },
                    {
                        name: "nameEN",
                        width: "10%",
                        align: "center"
                    }
                ],
            },
            {
                name: "noBLs",
                title: "<spring:message code='shipment.numberOfBLs'/>",
                type: 'long',
                required: true,
                width: "100%",
                keyPressFilter: "[0-9]",
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
                name: "shipmentTypeId",
                displayField: "shipmentType",
                valueField: "id",
                title: "<spring:message code='shipment.shipmentType'/>",
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_ShipmentTypeInShipment,
                pickListProperties: {showFilterEditor: true},

                pickListFields: [
                    {
                        name: "shipmentType",
                        width: "10%",
                        align: "center"
                    }],
                pickListHeight: "500",
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
            },
            {
                name: "shipmentMethodId",

                displayField: "shipmentMethod",
                valueField: "id",
                title: "<spring:message code='shipment.shipmentMethod'/>",
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_ShipmentMethodInShipment,
                pickListHeight: "500",
                required: true,
            },
            {
                name: "noPackages",
                title: "<spring:message code='shipment.noPackages'/>",
                width: "100%",
                type: "long",
                length: 10,
                keyPressFilter: "[0-9.]",
            },
            {
                name: "weightGW",
                length: 10,
                title: "<spring:message code='shipment.gross'/>",
                type: "float",
                width: "100%",
                keyPressFilter: "[0-9.]",
            },
            {
                name: "weightND",
                length: 10,
                keyPressFilter: "[0-9.]",
                title: "<spring:message code='shipment.net'/>",
                type: "float",
                width: "100%",
            },
            {
                name: "moisture",
                title: "<spring:message code='shipment.moisture'/>",
                type: "staticText",
                width: "100%",
            },
            {
                name: "vgm",
                title: "<spring:message code='shipment.vgm'/>",
                type: "float",
                width: "100%",
            },
            {
                name: "noContainer",
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'integer',
                width: "100%",
                keyPressFilter: "[0-9.]",
            },
            {
                name: "containerType",
                title: "<spring:message code='billOfLanding.container.type'/>",
                type: 'text',
                width: "100%",
            },
            {
                name: "noPallet",
                title: "<spring:message code='shipment.noPalette'/>",
                type: 'integer',
                width: "100%",
                length: 6,
                keyPressFilter: "[0-9.]",
            },
            {
                name: "contactAgentId",
                title: "<spring:message code='shipment.agent'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact__SHIPMENT,
                optionCriteria: RestDataSource_Contact_optionCriteria__SHIPMENT,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: 400,
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", align: "center"},
                    {
                        name: "nameEN",
                        align: "center"
                    },
                    {name: "country.nameFa", align: "center"}],
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
                name: "vesselId",
                title: "<spring:message code='vessel.name'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_VesselInShipment,
                type: 'long',
                width: "100%",
                displayField: "name",
                valueField: "id",
                pickListWidth: 400,
                pickListHeight: "500",
                pickListProperties: {
                    showFilterEditor: true
                },
                pickListFields: [
                    {
                        name: "name",
                    },
                    {
                        name: "type"
                    }],
            },
            {
                name: "dischargePortId",
                title: "<spring:message code='billOfLanding.port.of.discharge'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Port,
                type: 'long',
                displayField: "port",
                valueField: "id",
                width: "100%",
                pickListWidth: 400,
                pickListHeight: "500",
                pickListProperties: {
                    showFilterEditor: true
                },
                pickListFields: [
                    {
                        name: "port",
                    }],
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
            },
        ]
    });

    var RestDataSource_Contact_optionCriteria__SHIPMENT = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "transporter", operator: "equals", value: true}]
    };

    var RestDataSource_UNIT_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria:
            [{
                fieldName: 'categoryUnit',
                operator: 'equals',
                value: JSON.parse('${Enum_CategoryUnit}').Weight
            }],

    };

    var IButton_Shipment_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            let validate = DynamicForm_Shipment.validate();
            if (!validate)
                return false;
            let automationLetterDate = toEnglishDigits(DynamicForm_Shipment.getValue("automationLetterDate"));
            DynamicForm_Shipment.setValue("automationLetterDate",
                new Date(new persianDate(automationLetterDate.split("/").map(x => +x)).format('X') * 1000));
            let allDataShipment = DynamicForm_Shipment.getValues();
            let dataShipment = Object.assign(allDataShipment);
            let methodXXXX = "PUT";
            if ((dataShipment.id == null) || (dataShipment.id == 'undefiend')) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/shipment/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(dataShipment),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_Shipment_refresh();
                            Window_Shipment.close();
                        } else {
                            isc.say(RpcResponse_o.data);
                        }
                    }
                })
            );
        }
    });

    var fillScreenWindow_letter = isc.Window.create({
        placement: "fillScreen",
        autoDraw: false,
        title: "<spring:message code='global.form.help'/>",
        items: [
            isc.HLayout.create({
                width: "100%",
                layoutMargin: 5,
                membersMargin: 10,
                members: [
                    isc.HTMLPane.create({
                        ID: "myPane",
                        showEdges: true,
                        contentsURL: "/sales/help/LoadingLetter.html",
                        contentsType: "page"
                    })
                ]
            })
        ]
    });

    var ShipmentCancelBtn_Help_shipment = isc.ToolStripButtonPrint.create({
        icon: "[SKIN]/actions/help.png",
        title: "<spring:message code='global.form.help'/>",
        click: function () {
            fillScreenWindow_letter.show();
        }
    });

    var ShipmentCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_Shipment.close();
        }
    });

    var hLayout_saveButton = isc.HLayout.create({
        width: 900,
        height: "100%",
        layoutMargin: 10,
        membersMargin: 5,
        textAlign: "center",
        align: "center",
        members: [
            IButton_Shipment_Save,
            ShipmentCancelBtn
        ]
    });

    var VLayout_saveButton = isc.VLayout.create({
        width: 900,
        height: "100%",
        textAlign: "center",
        align: "center",
        members: [
            hLayout_saveButton

        ]
    });

    var Window_Shipment = isc.Window.create({
        title: "<spring:message code='Shipment.title'/>",
        width: 900,
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
            DynamicForm_Shipment,
            isc.HLayout.create({
                width: "100%",
                height: "10",
                autoCenter: true,
                layoutMargin: 3,
                membersMargin: 3,
                align: "center",
                members: [
                    isc.HStack.create({
                        autoCenter: true,
                        layoutAlign: "center",
                        members: [
                            VLayout_saveButton
                        ]
                    }),
                ]
            })
        ]
    });

    function ListGrid_Shipment_refresh() {
        ListGrid_Shipment.invalidateCache();
    }

    function ListGrid_Shipment_remove() {
        let record = ListGrid_Shipment.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
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
                    isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}),
                    isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var shipmentId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/shipment/" + shipmentId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                        ListGrid_Shipment.invalidateCache();
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

    function ListGrid_Shipment_add() {
        DynamicForm_Shipment.clearValues();
        abal.enable();
        abal.fetchData();
        shipment.enable();
        DynamicForm_Shipment.getItem("contractShipmentId").show();
        DynamicForm_Shipment.getItem("shipmentSendDate").hide();
        Window_Shipment.animateShow();
    }

    function ListGrid_Shipment_edit() {
        let record = ListGrid_Shipment.getSelectedRecord();
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
            DynamicForm_Shipment.clearValues();
//DynamicForm_Shipment.setValue("contractId", record.contractShipment.contractId);
//          DynamicForm_Shipment.getItem("contractShipmentId").setOptionDataSource(null);
            DynamicForm_Shipment.editRecord(record);
            DynamicForm_Shipment.setValue("contractId", record.contractShipment.contractId);
            //DynamicForm_Shipment.getItem("contractShipmentId").setValue(record.contractShipment.sendDate);
            DynamicForm_Shipment.setValue("automationLetterDate", new Date(parseInt(record.automationLetterDate)).toLocaleDateString('fa-IR'));
            DynamicForm_Shipment.setValue("arrivalDateTo", new Date(parseInt(ListGrid_Shipment.getSelectedRecord().arrivalDateTo)));
            DynamicForm_Shipment.setValue("arrivalDateFrom", new Date(parseInt(ListGrid_Shipment.getSelectedRecord().arrivalDateFrom)));
            DynamicForm_Shipment.setValue("sendDate", new Date(parseInt(ListGrid_Shipment.getSelectedRecord().sendDate)));
            DynamicForm_Shipment.setValue("lastDeliveryLetterDate", new Date(parseInt(ListGrid_Shipment.getSelectedRecord().lastDeliveryLetterDate)));
            setBuyerName(record.contactId);
            abal.disable();
            shipment.disable();
            Window_Shipment.animateShow();
            DynamicForm_Shipment.getItem("contractShipmentId").hide();
            DynamicForm_Shipment.getItem("shipmentSendDate").show();
            DynamicForm_Shipment.getItem("shipmentSendDate").setValue(ListGrid_Shipment.getSelectedRecord().contractShipment.sendDate);
         }
    }

    function ListGrid_Shipment_dcc() {
                ShipmentDccViewLoader.setViewURL("shipmentDcc/showForm/" );
                Window_Shipment_Dcc.animateShow();
    }

    var ToolStripButton_Shipment_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Shipment_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_SHIPMENT')">
    let ToolStripButton_Shipment_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            ListGrid_Shipment_add();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_SHIPMENT')">
    let ToolStripButton_Shipment_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Shipment_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_SHIPMENT')">
    let ToolStripButton_Shipment_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Shipment_remove();
        }
    });
    </sec:authorize>

    <%--<sec:authorize access="hasAuthority('D_SHIPMENT')">--%>
    let ToolStripButton_Shipment_dcc = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='shipment.loading.pattern.Attachment'/>",
        click: function () {
            ListGrid_Shipment_dcc();
        }
    });
    <%--</sec:authorize>--%>

    var ToolStrip_Actions_Shipment = isc.ToolStrip.create({
        width: "100%",
        members: [
            <sec:authorize access="hasAuthority('C_SHIPMENT')">
            ToolStripButton_Shipment_Add,
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_SHIPMENT')">
            ToolStripButton_Shipment_Edit,
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_SHIPMENT')">
            ToolStripButton_Shipment_Remove,
            </sec:authorize>

            ToolStripButton_Shipment_dcc,

            ShipmentCancelBtn_Help_shipment,

            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Shipment_Refresh,
                ]
            })
        ]
    });

    var HLayout_Actions_Shipment = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Shipment
        ]
    });

    var ShipmentAttachmentViewLoader = isc.ViewLoader.create({
        autoDraw: false,
        loadingMessage: ""
    });

    var hLayoutViewLoader = isc.HLayout.create({
        width: "100%",
        height: 180,
        align: "center", padding: 5,
        membersMargin: 20,
        members: [
            ShipmentAttachmentViewLoader
        ]
    });
    hLayoutViewLoader.hide();

    var ListGrid_Shipment = isc.ListGrid.create({
        showFilterEditor: true,
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        contextMenu: Menu_ListGrid_Shipment,
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
        autoFetchData: true,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.contract.contact.nameFA
                }
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contractShipment.contract.no",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: "10%",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.contract.contractNo
                }
            },
            {
                name: "automationLetterDate",
                title: "<spring:message code='shipment.bDate'/>",
                type: 'date',
                width: "10%",
                showHover: true,
                formatCellValue: (value) => {
                    return new persianDate(value).format('YYYY/MM/DD')
                },
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
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.material.descl
                }
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
                name: "shipmentType.shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
                width: "10%",
                showHover: true,
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
                name: "shipmentMethod.shipmentMethod",
                title: "<spring:message code='shipment.shipmentMethod'/>",
                type: 'text',
                width: "10%",
                showHover: true,
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
                name: "automationLetterNo",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true,
            },
            {
                name: "contractShipment.sendDate",
                title: "<spring:message code='global.sendDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                sortNormalizer: function (recordObject) {
                    return recordObject.contractShipment.sendDate
                }
            },
            {
                name: "createDate.date",
                title: "<spring:message code='global.createDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                formatCellValue: (value) => {
                    return new persianDate(value).format('YYYY/MM/DD')
                },
            },
            {
                name: "contactAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.contactAgent.nameFA
                }
            },
            {
                name: "vessel.name",
                title: "<spring:message code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                sortNormalizer: function (recordObject) {
                    return recordObject.vessel.name
                }
            },

        ],
        getExpansionComponent: function (record) {
            if (record == null || record.id == null) {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({
                        title: "<spring:message code='global.ok'/>"
                    })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
                record.id = null;
            }
            let dccTableId = record.id;
            let dccTableName = "TBL_SHIPMENT";
            ShipmentAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId);
            hLayoutViewLoader.show();
            let layoutShipment = isc.VLayout.create({
                styleName: "expand-layout",
                padding: 5,
                membersMargin: 10,
                members: [hLayoutViewLoader]
            });
            return layoutShipment;
        }
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
            HLayout_Actions_Shipment, HLayout_Grid_Shipment
        ]
    });

    isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            layoutTopMargin: 5,
            members: [
                isc.SectionStack.create({
                    sections: [{
                        title: "<spring:message code='Shipment.title'/>",
                        items: VLayout_Body_Shipment,
                        showHeader: false,
                        expanded: true
                    }
                    ],
                    visibilityMode: "multiple",
                    animateSections: true,
                    height: "100%",
                    width: "100%",
                    overflow: "hidden"
                })
            ]
        });

//</script>





