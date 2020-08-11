<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <% DateUtil dateUtil = new DateUtil();%>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    let contractId;

    let RestDataSource_Contact__SHIPMENT = isc.MyRestDataSource.create({
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

    let RestDataSource_LoadingPort = isc.MyRestDataSource.create({
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

    let RestDataSource_VesselInShipment = isc.MyRestDataSource.create({
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

    let RestDataSource_UnitInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "nameFA", title: "<spring:message code='unit.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='unit.nameEN'/>"},
            ],
        fetchDataURL: "${contextPath}/api/unit/spec-list"
    });

    let RestDataSource_ShipmentTypeInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentType", title: "<spring:message code='shipment.type'/>"},
            ],
        fetchDataURL: "${contextPath}/api/shipmentType/spec-list"
    });

    let RestDataSource_ShipmentMethodInShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentMethod", title: "<spring:message code='shipment.method'/>"},
            ],
        fetchDataURL: "${contextPath}/api/shipmentMethod/spec-list"
    });

    let RestDataSource_pickShipmentItem = isc.MyRestDataSource.create({
        fields:
            [
                {name: "cisId", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "contractNo", title: "<spring:message code='contract.contractNo'/> "},
                {name: "fullname", title: "<spring:message code='contact.name'/> "},
                {name: "quantity", title: "<spring:message code='global.quantity'/> "},
                {name: "sendDate", title: "<spring:message code='global.sendDate'/> "},
                {name: "contactID", title: "contactId"},
                {name: "contractID", title: "contractID"},
                {name: "materialDescp", title: "<spring:message code='material.descp'/>"},
                {name: "materialID", title: "materialId"},
                {name: "loadPortID", title: "<spring:message code='shipment.loading'/>"}
            ],
        fetchDataURL: "${contextPath}/api/shipment/pick-list"
    });

    let RestDataSource_Shipment__SHIPMENT = isc.MyRestDataSource.create({
        fields: [
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
                name: "contract.contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: 180
            },
            {
                name: "contractDate.date",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: 180
            },
            {name: "materialId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "material.descl", title: "<spring:message code='material.descl'/>", type: 'text'},
            {name: "material.descp", title: "<spring:message code='material.descp'/>", type: 'text'},
            {name: "material.unit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "noPalete", title: "<spring:message code='shipment.noPalete'/>", type: 'integer'},
            {name: "noBarrel", title: "<spring:message code='shipment.noBarrel'/>", type: 'integer'},
            {name: "gross", title: "<spring:message code='shipment.gross'/>"},
            {name: "net", title: "<spring:message code='shipment.net'/>"},
            {name: "moisture", title: "<spring:message code='shipment.moisture'/>"},
            {name: "vgm", title: "<spring:message code='shipment.vgm'/>"},
            {
                name: "laycan",
                title: "<spring:message code='shipmentContract.laycanStart'/>",
                type: 'integer',
                width: "10%",
                align: "center",
            },
            {
                name: "shipmentType",
                title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text',
                width: 400,
            },
            {
                name: "shipmentMethod",
                title: "<spring:message code='shipment.shipmentMethod'/>",
                type: 'text',
                width: 400,
            },
            {
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "10%",
                showHover: true,

            },
            {
                name: "loadingLetter",
                title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },
            {name: "loading", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "portByLoadingId", title: "<spring:message code='shipment.loading'/>", width: "10%"},
            {
                name: "portByLoading.port",
                title: "<spring:message code='shipment.loading'/>",
                width: "10%"
            },
            {
                name: "portByDischargeId",
                title: "<spring:message code='shipment.discharge'/>",
                width: "10%"
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                width: "10%"
            },
            {name: "dischargeAddress", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "description", title: "<spring:message code='shipment.description'/>", type: 'text', width: "10%"},
            {name: "swb", title: "<spring:message code='shipment.SWB'/>", type: 'text', width: "10%"},
            {name: "switchPort.port", title: "<spring:message code='port.switchPort'/>", type: 'text', width: "50%"},
            {name: "month", title: "<spring:message code='shipment.month'/>", type: 'text', width: "10%"},
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
                name: "createDate.date",
                title: "<spring:message code='shipment.createDate'/>",
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

            }
        ],
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });

    function check_Shipment_Print() {
        record = ListGrid_Shipment.getSelectedRecord();
        if (record == null) {
            isc.say("<spring:message code='global.grid.record.not.selected'/>");
        } else {
            "<spring:url value="/shipment/print/" var="printUrl"/>";
            window.open('${printUrl}' + record.id);
        }
    }

    let Menu_ListGrid_Shipment = isc.Menu.create({
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
                    check_Shipment_Print();
                }
            }

        ]
    });

    let dash = "\n";

    let DynamicForm_Shipment = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        titleWidth: "170",
        numCols: 4,
        fields: [
            {name: "id", hidden: true},
            {name: "contactId", hidden: true},
            {name: "contractId", hidden: true,},
            {name: "materialId", hidden: true,},
            {
                name: "contractShipmentId", ID: "abal", colSpan: 4,
                title: "<spring:message code='shipmentContract.list'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_pickShipmentItem,
                displayField: "contractNo",
                valueField: "cisId",
                pickListHeight: "500",
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "contractNo", width: "10%", align: "center"},
                    {
                        name: "fullname",
                        width: "10%",
                        align: "center"
                    },
                    {name: "quantity", width: "10%"},
                    {
                        name: "sendDate",
                        width: "10%",
                        align: "center"
                    }
                ],
                changed: function () {
                    let record = DynamicForm_Shipment.getItem("contractShipmentId").getSelectedRecord();
                    let d = new Date(record.sendDate);

                    DynamicForm_Shipment.setValue("material.descp", record.materialDescp);
                    DynamicForm_Shipment.setValue("contract.contact.nameFA", record.fullname);

                    DynamicForm_Shipment.setValue("amount", record.amount);
                    DynamicForm_Shipment1.setValue("dischargeAddress", record.address);
                    DynamicForm_Shipment.setValue("contactId", record.contactID);
                    DynamicForm_Shipment.setValue("materialId", record.materialID);
                    DynamicForm_Shipment.setValue("contractNo", record.contractNo);
                    DynamicForm_Shipment.setValue("month", d.getMonthName());
                    DynamicForm_Shipment2.setValue("status", "Load Ready");
                    DynamicForm_Shipment.setValue("contractId", record.contractID);
                    DynamicForm_Shipment.setValue("contractShipmentId", record.cisId);
                    DynamicForm_Shipment1.setValue("portByDischargeId", record.dischargeID);
                    DynamicForm_Shipment1.setValue("dischargeAddress", record.dischargeAddress);
                    if (record.code == 'FOB') {
                        DynamicForm_Shipment2.getItem("freight").setRequired(false);
                        DynamicForm_Shipment2.getItem("totalFreight").setRequired(false);
                    } else {
                        DynamicForm_Shipment2.getItem("freight").setRequired(true);
                        DynamicForm_Shipment2.getItem("totalFreight").setRequired(true);
                    }
                }
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
            {name: "createDateHidden", hidden: true,},
            {
                name: "month", colSpan: 4,
                title: "<spring:message code='shipment.month'/>", type: 'text', width: "100%"
                , valueMap: {
                    "January": "January",
                    "February": "February",
                    "March": "March",
                    "April": "April",
                    "May": "May",
                    "June": "June",
                    "July": "July",
                    "August": "August",
                    "September": "September",
                    "October": "October",
                    "November": "November",
                    "December": "December"
                }
            },
            {name: "contractDate", hidden: true,},
            {
                name: "createDate.date",
                title: "<spring:message code='shipment.bDate'/>",
                ID: "createDateId",
                icons: [{
                    src: "pieces/pcal.png",
                    click: function () {
                        displayDatePicker('createDateId', this, 'ymd', '/');
                    }
                }],
                defaultValue: "1399/01/01",
                required: true,
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
                name: "loadingLetter",
                colSpan: 4,
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
                name: "amount",
                title: "<spring:message code='global.amount'/>",
                type: 'float',
                required: true,
                width: "100%",
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
                name: "material.unit.nameEN",
                title: "<spring:message code='unit.title'/>",
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_UnitInShipment,
                displayField: "nameFA",
                valueField: "nameEN",
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
                name: "shipmentType",
                colSpan: 4,
                title: "<spring:message code='shipment.shipmentType'/>",
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_ShipmentTypeInShipment,
                pickListHeight: "500",
                required: true,
                validators: [{
                    type: "required",
                    validateOnChange: true
                }],
                changed: function (form, item, value) {
                    if (value.contains("فله")) {
                        if (DynamicForm_Shipment.getItem("material.descp").getValue() === "مس کاتد") {
                            form.getItem("gross").show();
                            form.getItem("net").show();
                            form.getItem("moisture").hide();
                            form.getItem("vgm").show();
                            form.getItem("noContainer").show();
                            form.getItem("noBarrel").hide();
                            form.getItem("noPalete").hide();
                        }
                        if (DynamicForm_Shipment.getItem("material.descp").getValue() === "مس کنسانتره") {
                            form.getItem("gross").show();
                            form.getItem("net").show();
                            form.getItem("moisture").show();
                            form.getItem("vgm").hide();
                            form.getItem("noContainer").hide();
                            form.getItem("noBarrel").hide();
                            form.getItem("noPalete").hide();
                        }
                        if (DynamicForm_Shipment.getItem("material.descp").getValue() === "اکسید مولیبدن") {
                            form.getItem("gross").hide();
                            form.getItem("net").hide();
                            form.getItem("moisture").hide();
                            form.getItem("vgm").hide();
                            form.getItem("noContainer").hide();
                            form.getItem("noBarrel").hide();
                            form.getItem("noPalete").hide();
                        }
                    } else if (value.contains("انتینری")) {
                        if (DynamicForm_Shipment.getItem("material.descp").getValue() === "مس کاتد") {
                            form.getItem("gross").show();
                            form.getItem("net").show();
                            form.getItem("moisture").hide();
                            form.getItem("vgm").show();
                            form.getItem("noContainer").show();
                            form.getItem("noBarrel").hide();
                            form.getItem("noPalete").hide();
                        }
                        if (DynamicForm_Shipment.getItem("material.descp").getValue() === "مس کنسانتره") {
                            form.getItem("gross").show();
                            form.getItem("net").show();
                            form.getItem("moisture").hide();
                            form.getItem("vgm").hide();
                            form.getItem("noContainer").show();
                            form.getItem("noBarrel").show();
                            form.getItem("noPalete").show();
                        }
                        if (DynamicForm_Shipment.getItem("material.descp").getValue() === "اکسید مولیبدن") {
                            form.getItem("gross").show();
                            form.getItem("net").show();
                            form.getItem("moisture").hide();
                            form.getItem("vgm").hide();
                            form.getItem("noContainer").show();
                            form.getItem("noBarrel").show();
                            form.getItem("noPalete").show();
                        }
                    } else if (value.contains("پالت")) {
                        form.getItem("gross").hide();
                        form.getItem("net").hide();
                        form.getItem("moisture").hide();
                        form.getItem("vgm").hide();
                        form.getItem("noContainer").hide();
                        form.getItem("noBarrel").hide();
                        form.getItem("noPalete").hide();
                    }
                }
            },
            {
                name: "shipmentMethod",
                colSpan: 4,
                title: "<spring:message code='shipment.shipmentMethod'/>",
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_ShipmentMethodInShipment,
                pickListHeight: "500",
                required: true,
                validators: [{
                    type: "required",
                    validateOnChange: true
                }]
            },
            {
                name: "gross",
                colSpan: 4,
                title: "<spring:message code='shipment.gross'/>",
                required: true,
                type: "float",
                width: "100%",
                validators: [{
                    type: "required",
                    validateOnChange: true
                }],
                hidden: true
            },
            {
                name: "net",
                colSpan: 4,
                title: "<spring:message code='shipment.net'/>",
                required: true,
                type: "float",
                width: "100%",
                validators: [{
                    type: "required",
                    validateOnChange: true
                }],
                hidden: true
            },
            {
                name: "moisture",
                colSpan: 4,
                title: "<spring:message code='shipment.moisture'/>",
                required: true,
                type: "float",
                width: "100%",
                validators: [{
                    type: "required",
                    validateOnChange: true
                }],
                hidden: true
            },
            {
                name: "vgm",
                colSpan: 4,
                title: "<spring:message code='shipment.vgm'/>",
                required: true,
                type: "float",
                width: "100%",
                validators: [{
                    type: "required",
                    validateOnChange: true
                }],
                hidden: true
            },
            {
                name: "noContainer",
                colSpan: 4,
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'integer',
                width: "100%",
                keyPressFilter: "[0-9.]",
                required: true,
                validators: [{
                    type: "isInteger",
                    validateOnChange: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                },
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                hidden: true
            },
            {
                name: "noBarrel", colSpan: 4,
                title: "<spring:message code='shipment.noBarrel'/>",
                type: 'integer',
                required: true,
                width: "100%",
                keyPressFilter: "[0-9.]",
                validators: [{
                    type: "isInteger",
                    validateOnChange: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                },
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                hidden: true
            },
            {
                name: "noPalete", colSpan: 4,
                title: "<spring:message code='shipment.noPalette'/>",
                type: 'integer',
                width: "100%",
                required: true,
                keyPressFilter: "[0-9.]",
                validators: [{
                    type: "isInteger",
                    validateOnChange: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                },
                    {
                        type: "required",
                        validateOnChange: true
                    }],
                hidden: true
            }
        ]
    });

    // Bill of Lading
    let DynamicForm_Shipment1 = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        titleWidth: "130",
        numCols: 4,
        fields: [
            {name: "id", hidden: true,},
            {type: "Header", defaultValue: ""},
            {name: "blDateHidden", hidden: true},
            {name: "swBlDateHidden", hidden: true},

            {
                name: "numberOfBLs", colSpan: 4,
                title: "<spring:message code='shipment.numberOfBLs'/>",
                type: 'integer',
                required: true,
                width: "100%",
                validators: [{
                    type: "isInteger",
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
                name: "blNumbers",
                colSpan: 4,
                title: "<spring:message code='shipment.blNumbers'/>",
                type: 'text',
                width: "100%",
                required: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]

            },
            {
                name: "blDate", colSpan: 4,
                title: "<spring:message code='shipment.blDate'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: 'date',
                required: true,
                width: "100%",
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            }, {
                name: "portByLoadingId",
                title: "<spring:message code='shipment.loading'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_LoadingPort,
                displayField: "port",
                valueField: "id",
                width: "100%",
                align: "center", colSpan: 4,
                startRow: true,
                required: true
            }
            ,
            {
                name: "portByDischargeId",
                title: "<spring:message code='shipment.discharge'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_LoadingPort,
                displayField: "port",
                valueField: "id", width: "100%", align: "center", startRow: true, colSpan: 4,
                required: true
            }, {
                name: "consignee", colSpan: 4,
                title: "<spring:message code='shipment.consignee'/>",
                type: 'text',
                required: true,
                width: "100%", startRow: true,
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
                align: "center",
                layoutAlign: "center",
                type: "Header",
                defaultValue: "<spring:message code='shipment.SW.Details'/>"
            },
            {
                name: "swb",
                colSpan: 4,
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text', width: "100%",
                defaultValue: "Yes",
                valueMap: {"Yes": "Yes", "No": "No"},
                changed: function (form, item, value) {
                    switch (value) {
                        case "Yes":
                            form.getItem("swBlDate").show();
                            form.getItem("switchPortId").show();
                            form.getItem("switchBl").show();
                            form.getItem("swBlDate").show();
                            break;
                        case "No":
                            form.getItem("swBlDate").hide();
                            form.getItem("switchPortId").hide();
                            form.getItem("switchBl").hide();
                            form.getItem("swBlDate").hide();
                            break;
                    }
                }
            }, {
                name: "switchPortId",
                title: "<spring:message code='port.switchPort'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_LoadingPort,
                displayField: "port",
                valueField: "id", width: "100%", align: "center",
                startRow: true, colSpan: 4,
            },
            {
                name: "switchBl",
                title: "<spring:message code='shipment.switchBl'/>",
                type: 'text',
                startRow: true, width: "100%", colSpan: 4

            },
            {
                name: "swBlDate",
                title: "<spring:message code='shipment.swBlDate'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: 'date',
                format: 'DD-MM-YYYY',
                required: true,
                width: "100%",
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            }
        ]
    });
    let RestDataSource_Contact_optionCriteria__SHIPMENT = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "transporter", operator: "equals", value: true}]
    };

    let DynamicForm_Shipment2 = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        titleWidth: "100",
        numCols: 6,
        fields: [
            {name: "id", hidden: true},
            {type: "Header", defaultValue: ""},
            {
                required: true,
                colSpan: 4,
                name: "contactByAgentId",
                title: "<spring:message code='shipment.agent'/>",
                type: 'long',
                width: 400,
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
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {
                name: "vesselId",
                colSpan: 4,
                title: "<spring:message code='vessel.name'/>",
                editorType: "SelectItem",
                required: true,
                optionDataSource: RestDataSource_VesselInShipment,
                type: 'long',
                width: 400,
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
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            {type: "Header", defaultValue: dash},
            {
                name: "freight", colSpan: 1,
                title: "<spring:message code='shipment.freight'/>",
                type: 'float',
                required: true,
                width: "100%",
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
                name: "freightCurrency", colSpan: 1,
                title: "<spring:message code='currency.title'/>",
                type: 'text',
                defaultValue: "USD",
                width: "100%",
            },
            {
                name: "totalFreight",
                colSpan: 1,
                title: "<spring:message code='shipment.totalFreight'/>",
                type: 'float',
                required: true,
                errorOrientation: "bottom",
                width: "100%",
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
                name: "preFreight", colSpan: 1,
                title: "<spring:message code='shipment.preFreight'/>",
                type: 'float',
                required: true,
                width: "100%",
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
                name: "preFreightCurrency", colSpan: 1,
                title: "<spring:message code='currency.title'/>",
                type: 'text',
                defaultValue: "USD",
                width: "100%"
            },
            {
                name: "postFreight",
                colSpan: 1,
                title: "<spring:message code='shipment.postFreight'/>",
                type: 'float',
                required: true,
                errorOrientation: "bottom",
                width: "100%",
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
                name: "postFreightCurrency",
                colSpan: 1,
                title: "<spring:message code='currency.title'/>",
                type: 'text',
                defaultValue: "USD",
                width: "100%"
            },
            {
                name: "dispatch", colSpan: 1,
                title: "<spring:message code='shipment.dispatch'/>",
                type: 'float',
                required: false,
                width: "100%",
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                name: "demurrage", colSpan: 1,
                title: "<spring:message code='shipment.demurrage'/>",
                type: 'float',
                required: false,
                width: "100%",
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                name: "detention",
                title: "<spring:message code='shipment.detention'/>",
                type: 'float',
                required: false,
                width: "100%",
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
        ]
    });

    let shipmentTabs = isc.TabSet.create({
        width: 900,
        height: "500",
        textAlign: "center",
        align: "center",
        layoutAlign: "center",
        showTabScroller: false,
        tabs: [
            {
                title: "<spring:message code='shipment.tab.shipment'/>", //spefication cargo
                pane: DynamicForm_Shipment
            },
            {
                title: "<spring:message code='shipment.tab.transport'/>", // bill of lading
                pane: DynamicForm_Shipment1
            },
            {
                title: "<spring:message code='shipment.tab.agent'/>",
                pane: DynamicForm_Shipment2
            }
        ]
    });

    let IButton_Shipment_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_Shipment.validate();
            if (DynamicForm_Shipment.hasErrors()) {
                shipmentTabs.selectTab(0);
                return;
            }
            DynamicForm_Shipment1.validate();
            if (DynamicForm_Shipment1.hasErrors()) {
                shipmentTabs.selectTab(1);
                return;
            }
            DynamicForm_Shipment2.validate();
            if (DynamicForm_Shipment2.hasErrors()) {
                shipmentTabs.selectTab(2);
                return;
            }
            DynamicForm_Shipment.setValue("numberOfBLs", DynamicForm_Shipment1.getValue("numberOfBLs"));
            DynamicForm_Shipment.setValue("blNumbers", DynamicForm_Shipment1.getValue("blNumbers"));
            DynamicForm_Shipment.setValue("blDate", DynamicForm_Shipment1.getValue("blDate"));
            DynamicForm_Shipment.setValue("swb", DynamicForm_Shipment1.getValue("swb"));
            DynamicForm_Shipment.setValue("switchPortId", DynamicForm_Shipment1.getValue("switchPortId"));
            DynamicForm_Shipment.setValue("switchBl", DynamicForm_Shipment1.getValue("switchBl"));
            DynamicForm_Shipment.setValue("swBlDate", DynamicForm_Shipment1.getValue("swBlDate"));
            DynamicForm_Shipment.setValue("portByLoadingId", DynamicForm_Shipment1.getValue("portByLoadingId"));
            DynamicForm_Shipment.setValue("portByDischargeId", DynamicForm_Shipment1.getValue("portByDischargeId"));
            DynamicForm_Shipment.setValue("consignee", DynamicForm_Shipment1.getValue("consignee"));
            DynamicForm_Shipment.setValue("contactByAgentId", DynamicForm_Shipment2.getValue("contactByAgentId"));
            DynamicForm_Shipment.setValue("Header", DynamicForm_Shipment2.getValue("Header"));
            DynamicForm_Shipment.setValue("vesselId", DynamicForm_Shipment2.getValue("vesselId"));
            DynamicForm_Shipment.setValue("freight", DynamicForm_Shipment2.getValue("freight"));
            DynamicForm_Shipment.setValue("totalFreight", DynamicForm_Shipment2.getValue("totalFreight"));
            DynamicForm_Shipment.setValue("freightCurrency", DynamicForm_Shipment2.getValue("freightCurrency"));

            DynamicForm_Shipment.setValue("preFreight", DynamicForm_Shipment2.getValue("preFreight"));
            DynamicForm_Shipment.setValue("postFreight", DynamicForm_Shipment2.getValue("postFreight"));

            DynamicForm_Shipment.setValue("dispatch", DynamicForm_Shipment2.getValue("dispatch"));
            DynamicForm_Shipment.setValue("demurrage", DynamicForm_Shipment2.getValue("demurrage"));
            DynamicForm_Shipment.setValue("detention", DynamicForm_Shipment2.getValue("detention"));
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


    let fillScreenWindow_letter = isc.Window.create({
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

    let ShipmentCancelBtn_Help_shipment = isc.ToolStripButtonPrint.create({
        icon: "[SKIN]/actions/help.png",
        title: "<spring:message code='global.form.help'/>",
        click: function () {
            fillScreenWindow_letter.show();
        }
    });

    let ShipmentCancelBtn = isc.IButtonCancel.create({
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


    let hLayout_saveButton = isc.HLayout.create({
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

    let VLayout_saveButton = isc.VLayout.create({
        width: 900,
        height: "100%",
        textAlign: "center",
        align: "center",
        members: [
            hLayout_saveButton

        ]
    });

    let Window_Shipment = isc.Window.create({
        title: "<spring:message code='Shipment.title'/>",
        width: 900,
        height: 600,
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
            shipmentTabs,
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
        DynamicForm_Shipment1.clearValues();
        DynamicForm_Shipment2.clearValues();
        abal.show();
        abal.fetchData();
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

            if (record.shipmentType.contains("فله")) {
                if (record.material.descl.contains("athod")) {
                    DynamicForm_Shipment.getItem("gross").show();
                    DynamicForm_Shipment.getItem("net").show();
                    DynamicForm_Shipment.getItem("moisture").hide();
                    DynamicForm_Shipment.getItem("vgm").show();
                    DynamicForm_Shipment.getItem("noContainer").show();
                    DynamicForm_Shipment.getItem("noBarrel").hide();
                    DynamicForm_Shipment.getItem("noPalete").hide();
                }
                if (record.material.descl.contains("onc")) {
                    DynamicForm_Shipment.getItem("gross").show();
                    DynamicForm_Shipment.getItem("net").show();
                    DynamicForm_Shipment.getItem("moisture").show();
                    DynamicForm_Shipment.getItem("vgm").hide();
                    DynamicForm_Shipment.getItem("noContainer").hide();
                    DynamicForm_Shipment.getItem("noBarrel").hide();
                    DynamicForm_Shipment.getItem("noPalete").hide();
                }
                if (record.material.descl.contains("olyb")) {
                    DynamicForm_Shipment.getItem("gross").hide();
                    DynamicForm_Shipment.getItem("net").hide();
                    DynamicForm_Shipment.getItem("moisture").hide();
                    DynamicForm_Shipment.getItem("vgm").hide();
                    DynamicForm_Shipment.getItem("noContainer").hide();
                    DynamicForm_Shipment.getItem("noBarrel").hide();
                    DynamicForm_Shipment.getItem("noPalete").hide();
                }
            } else if (record.shipmentType.contains("انتینری")) {
                if (record.material.descl.contains("athod")) {
                    DynamicForm_Shipment.getItem("gross").show();
                    DynamicForm_Shipment.getItem("net").show();
                    DynamicForm_Shipment.getItem("moisture").hide();
                    DynamicForm_Shipment.getItem("vgm").show();
                    DynamicForm_Shipment.getItem("noContainer").show();
                    DynamicForm_Shipment.getItem("noBarrel").hide();
                    DynamicForm_Shipment.getItem("noPalete").hide();
                }
                if (record.material.descl.contains("onc")) {
                    DynamicForm_Shipment.getItem("gross").show();
                    DynamicForm_Shipment.getItem("net").show();
                    DynamicForm_Shipment.getItem("moisture").hide();
                    DynamicForm_Shipment.getItem("vgm").hide();
                    DynamicForm_Shipment.getItem("noContainer").show();
                    DynamicForm_Shipment.getItem("noBarrel").show();
                    DynamicForm_Shipment.getItem("noPalete").show();
                }
                if (record.material.descl.contains("olyb")) {
                    DynamicForm_Shipment.getItem("gross").show();
                    DynamicForm_Shipment.getItem("net").show();
                    DynamicForm_Shipment.getItem("moisture").hide();
                    DynamicForm_Shipment.getItem("vgm").hide();
                    DynamicForm_Shipment.getItem("noContainer").show();
                    DynamicForm_Shipment.getItem("noBarrel").show();
                    DynamicForm_Shipment.getItem("noPalete").show();
                }
            } else if (record.shipmentType.contains("پالت")) {
                DynamicForm_Shipment.getItem("gross").hide();
                DynamicForm_Shipment.getItem("net").hide();
                DynamicForm_Shipment.getItem("moisture").hide();
                DynamicForm_Shipment.getItem("vgm").hide();
                DynamicForm_Shipment.getItem("noContainer").hide();
                DynamicForm_Shipment.getItem("noBarrel").hide();
                DynamicForm_Shipment.getItem("noPalete").hide();
            }


            DynamicForm_Shipment.clearValues();
            DynamicForm_Shipment1.clearValues();
            DynamicForm_Shipment2.clearValues();

            DynamicForm_Shipment.editRecord(record);
            DynamicForm_Shipment1.editRecord(record);
            DynamicForm_Shipment2.editRecord(record);
            DynamicForm_Shipment.setValue("createDate.date", record.createDate.date);
            DynamicForm_Shipment1.setValue("swBlDate", new Date(record.swBlDate));
            DynamicForm_Shipment1.setValue("blDate", new Date(record.blDate));
            abal.hide();
            Window_Shipment.animateShow();
        }
    }

    let ToolStripButton_Shipment_Refresh = isc.ToolStripButtonRefresh.create({
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

    let ToolStrip_Actions_Shipment = isc.ToolStrip.create({
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

    let HLayout_Actions_Shipment = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Shipment
        ]
    });

    let ShipmentAttachmentViewLoader = isc.ViewLoader.create({
        autoDraw: false,
        loadingMessage: ""
    });
    let hLayoutViewLoader = isc.HLayout.create({
        width: "100%",
        height: 180,
        align: "center", padding: 5,
        membersMargin: 20,
        members: [
            ShipmentAttachmentViewLoader
        ]
    });
    hLayoutViewLoader.hide();

    let ListGrid_Shipment = isc.ListGrid.create({
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
                name: "contract.contact.nameFA",
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
                name: "contract.contractNo",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                width: "10%",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.contract.contractNo
                }
            },
            {
                name: "contract.contractDate",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: "10%",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.contract.contractDate
                }
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
                name: "material.unit.nameEN",
                title: "<spring:message code='unit.nameEN'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.material.unit.nameEN
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
                name: "shipmentType",
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
            /*{
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "10%",
                showHover: true
            },*/
            {
                name: "loadingLetter",
                title: "<spring:message code='shipment.loadingLetter'/>",
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
            /*{
                name: "noContainer",
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },*/
            {
                name: "portByLoading.port",
                title: "<spring:message code='shipment.loading'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.portByLoading.port
                },
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }],
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.portByDischarge.port
                },
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
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
                name: "month",
                title: "<spring:message code='shipment.month'/>",
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
                name: "contactByAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.contactByAgent.nameFA
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
                showHover: true,
                sortNormalizer: function (recordObject) {
                    return recordObject.switchPort.port
                },
                validators: [
                    {
                        type: "required",
                        validateOnChange: true
                    }]
            },
            /*{
                name: "status",
                title: "<spring:message code='shipment.staus'/>",
                type: 'text',
                width: "10%",
                align: "center",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                },
                showHover: true
            }*/
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

    let HLayout_Grid_Shipment = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment
        ]
    });

    let VLayout_Body_Shipment = isc.VLayout.create({
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
