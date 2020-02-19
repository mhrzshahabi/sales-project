<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <% DateUtil dateUtil = new DateUtil();%>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    var contractId;
    var RestDataSource_ContractPerson;
    var ListGrid_Person_EmailCC;

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
                {name: "email", title: "<spring:message code='contact.email'/>"},
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

    var RestDataSource_pickShipmentItem = isc.MyRestDataSource.create({
        fields:
            [
                {name: "cisId", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "contractNo", title: "<spring:message code='contract.contractNo'/> "},
                {name: "fullname", title: "<spring:message code='contact.name'/> "},
                {name: "amount", title: "<spring:message code='global.amount'/> "},
                {name: "address", title: "<spring:message code='global.address'/> "},
                {name: "plan", title: "<spring:message code='shipment.plan'/> "},
                {name: "sendDate", title: "<spring:message code='global.sendDate'/> "},
                {name: "duration", title: "<spring:message code='global.duration'/> "},
                {name: "contactID", title: "contactId"},
                {name: "contractID", title: "contractID"},
                {name: "materialID", title: "materialId"},
                {name: "dischargeID", title: "dischargeID"},
                {name: "dischargeAddress", title: "materialId"},
                {name: "code", title: "code"}
            ],
        fetchDataURL: "${contextPath}/api/shipment/pick-list"
    });

    var RestDataSource_Shipment__SHIPMENT = isc.MyRestDataSource.create({
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
                name: "contract.contractDate",
                title: "<spring:message code='contract.contractDate'/>",
                type: 'text',
                width: 180
            },
            {name: "materialId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "material.descl", title: "<spring:message code='material.descl'/>", type: 'text'},
            {name: "material.unit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "noPalete", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
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
                valueMap: {"bulk": "bulk", "container": "container"}
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
                    type:"required",
                    validateOnChange: true
                }]
            },
            {name: "createDate", title: "<spring:message code='shipment.createDate'/>", type: 'text', width: "10%"},
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
                title: "<spring:message code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            }
        ],
        fetchDataURL: "${contextPath}/api/shipment/spec-list"
    });

    var RestDataSource_Person_EmailCC = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contactId"},
            {name: "contact.nameFA"},
            {
                name: "fullName",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                required: true,
                width: 400,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },
            {name: "jobTitle", title: "<spring:message code='person.jobTitle'/>", type: 'text', width: 400},
            {
                name: "title", title: "<spring:message code='person.title'/>", type: 'text', width: 400, valueMap: {
                    "MR": "<spring:message code='global.MR'/>",
                    "MIS": "<spring:message code='global.MIS'/>", "MRS": "<spring:message code='global.MRS'/>",
                }
            },
            {name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true,
                validators: [{ type:"required", validateOnChange: true }], width: 400},
            {name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 400},
            {name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 400}
        ],
        fetchDataURL: "${contextPath}/api/person/spec-list"
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
                    DynamicForm_Shipment.clearValues();
                    DynamicForm_Shipment1.clearValues();
                    DynamicForm_Shipment2.clearValues();
                    abal.show();
                    abal.fetchData();
                    Window_Shipment.animateShow();
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

    var dash = "\n";

    var DynamicForm_Shipment = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        titleWidth: "105",
        numCols: 4,
        fields: [
            {name: "id", hidden: true,},
            {name: "contactId", hidden: true,},
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
                pickListWidth: 680,
                pickListHeight: "500",
                required: true,
                validators: [
                {
                type:"required",
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
                    {name: "amount", width: "10%", align: "center", errorOrientation: "bottom",}, {
                        name: "sendDate",
                        width: "10%",
                        align: "center"
                    },
                    {name: "plan", width: "10%", align: "center"}
                ],
                changed: function () {
                    var record = DynamicForm_Shipment.getItem("contractShipmentId").getSelectedRecord();
                    Shipment_contact_name.setContents(record.fullname);
                    var d = new Date(record.sendDate);
                    DynamicForm_Shipment.setValue("createDate", d);
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
            {name: "createDate", hidden: true,},
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
            {
                name: "createDate", colSpan: 4,
                title: "<spring:message code='shipment.createDate'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: 'date',
                format: 'DD-MM-YYYY',
                required: true,
                width: "100%",
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
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
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "amount", colSpan: 4,
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
                type:"required",
                validateOnChange: true
                }]
            },
            {
                name: "shipmentType", colSpan: 4, title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text', width: "100%", valueMap: {"bulk": "bulk", "container": "container"}, required: true,
                validators: [{ type:"required", validateOnChange: true }]
            },

            {
                name: "bookingCat",
                title: "<spring:message code='shipment.bookingCat'/>",
                type: 'text',
                width: "100%",
                colSpan: 4,
                showHover: true,
                hint: "<spring:message code='shipment.bookingMol.hint'/>",
                showHintInField: true,

            },

            {
                hint: "<spring:message code='shipment.bookingCat.hint'/>",
                showHintInField: true,
                name: "noContainer",
                colSpan: 4,
                title: "<spring:message code='shipment.noContainer'/>",
                type: 'integer',
                width: "100%",
                keyPressFilter: "[0-9.]",
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                hint: "<spring:message code='shipment.bookingCat.hint'/>",
                showHintInField: true,
                name: "noBundle", colSpan: 4,
                title: "<spring:message code='shipment.noBundle'/>",
                type: 'integer',
                required: false,
                width: "100%",
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                name: "noPalete", colSpan: 4,
                title: "<spring:message code='shipment.noPalette'/>",
                type: 'integer',
                required: false,
                width: "100%",
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                name: "noBarrel", colSpan: 4,
                title: "<spring:message code='shipment.noBarrel'/>",
                type: 'integer',
                required: false,
                width: "100%",
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "<spring:message code='global.form.correctType'/>"
                }]
            },
            {
                name: "status",
                colSpan: 4,
                title: "<spring:message code='shipment.staus'/>",
                type: 'text',
                width: "100%",
                valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                }
            }
        ]
    });

    // Bill of Lading
    var DynamicForm_Shipment1 = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment__SHIPMENT,
        titleWidth: "100",
        numCols: 4,
        fields: [
            {name: "id", hidden: true,},
            {type: "Header", defaultValue: ""},
            {name: "blDate", hidden: true},

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
                    type:"required",
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
                    type:"required",
                    validateOnChange: true
                }]

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
                            break;
                        case "No":
                            form.getItem("swBlDate").hide();
                            form.getItem("switchPortId").hide();
                            form.getItem("switchBl").hide();
                            break;
                    }
                }
            },
            {name: "swBlDate", hidden: true},


            {
                name: "switchBl",
                title: "<spring:message code='shipment.switchBl'/>",
                type: 'text',
                startRow: true , width: "100%" , colSpan: 4

            },
            {
                name: "portByLoadingId",
                title: "<spring:message code='shipment.loading'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_LoadingPort,
                displayField: "port",
                valueField: "id",
                width: "100%",
                align: "center", colSpan: 4,
                startRow: true
            },
            {
                name: "switchPortId",
                title: "<spring:message code='port.switchPort'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_LoadingPort,
                displayField: "port",
                valueField: "id", width: "100%", align: "center",
                startRow: true ,colSpan: 4,
            },
            {
                name: "portByDischargeId",
                title: "<spring:message code='shipment.discharge'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_LoadingPort,
                displayField: "port",
                valueField: "id", width: "100%", align: "center", startRow: true , colSpan: 4
            },
            {
                name: "consignee", colSpan: 4,
                title: "<spring:message code='shipment.consignee'/>",
                type: 'text',
                required: true,
                width: "100%", startRow: true,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "swBlDate",
                title: "<spring:message code='shipment.swBlDate'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: 'date',
                format: 'DD-MM-YYYY',
                required: true,
                width: 400 ,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },
                {
                name: "blDate", colSpan: 4,
                title: "<spring:message code='shipment.blDate'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: 'date',
                format: 'DD-MM-YYYY',
                required: true,
                width: "100%",
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },


        ]
    });
    var RestDataSource_Contact_optionCriteria__SHIPMENT = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "transporter", operator: "equals", value: true}]
    };

    var DynamicForm_Shipment2 = isc.DynamicForm.create({
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
                    type:"required",
                    validateOnChange: true
                }]
            },


            {
                required: true,
                name: "vesselName", colSpan: 4,
                title: "<spring:message code='shipment.vesselName'/>",
                type: 'text',
                width: 400
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
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "freightCurrency", colSpan: 1,
                title: "<spring:message code='currency.title'/>",
                type: 'text',
                defaultValue: "USD", valueMap: dollar,
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
                    type:"required",
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
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "preFreightCurrency", colSpan: 1,
                title: "<spring:message code='currency.title'/>",
                type: 'text',
                defaultValue: "USD",
                valueMap: dollar,
                width: "100%",
            },
            {
                name: "postFreight", colSpan: 1,
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
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "postFreightCurrency", colSpan: 1,
                title: "<spring:message code='currency.title'/>",
                type: 'text',
                defaultValue: "USD", valueMap: dollar,
                width: "100%",
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

    var shipmentTabs = isc.TabSet.create({
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

    var IButton_Shipment_Save = isc.IButtonSave.create({
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
            var drs = DynamicForm_Shipment.getValue("createDate");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Shipment.setValue("createDate", datestringRs);
            drs = DynamicForm_Shipment1.getValue("swBlDate");
            datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Shipment1.setValue("swBlDate", datestringRs);
            drs = DynamicForm_Shipment1.getValue("blDate");
            datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Shipment1.setValue("blDate", datestringRs);

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
            DynamicForm_Shipment.setValue("vesselName", DynamicForm_Shipment2.getValue("vesselName"));
            DynamicForm_Shipment.setValue("freight", DynamicForm_Shipment2.getValue("freight"));
            DynamicForm_Shipment.setValue("totalFreight", DynamicForm_Shipment2.getValue("totalFreight"));
            DynamicForm_Shipment.setValue("freightCurrency", DynamicForm_Shipment2.getValue("freightCurrency"));

            DynamicForm_Shipment.setValue("preFreight", DynamicForm_Shipment2.getValue("preFreight"));
            DynamicForm_Shipment.setValue("postFreight", DynamicForm_Shipment2.getValue("postFreight"));

            DynamicForm_Shipment.setValue("dispatch", DynamicForm_Shipment2.getValue("dispatch"));
            DynamicForm_Shipment.setValue("demurrage", DynamicForm_Shipment2.getValue("demurrage"));
            DynamicForm_Shipment.setValue("detention", DynamicForm_Shipment2.getValue("detention"));

            var dataShipment = Object.assign(DynamicForm_Shipment.getValues());
            var methodXXXX = "PUT";
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
                layoutMargin:5,
                membersMargin: 10,
                members: [
                    isc.HTMLPane.create({
                        ID:"myPane",
                        showEdges:true,
                        contentsURL:"/sales/help/LoadingLetter.html",
                        contentsType:"page"
                    })
                    ]
                })
        ]
    });

        var ShipmentCancelBtn_Help_shipment = isc.ToolStripButtonPrint.create({
        icon: "[SKIN]/actions/help.png",
        title: "<spring:message code='global.form.help'/>",
        click:function()
        {
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
            isc.Label.create({
                ID: "Shipment_contact_name",
                title: "<spring:message code='contact.name'/>. ",
                align: "center",
                width: "60%",
                height: 22
            }),
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
        var record = ListGrid_Shipment.getSelectedRecord();

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

    function ListGrid_Shipment_edit() {
        var record = ListGrid_Shipment.getSelectedRecord();

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
            DynamicForm_Shipment.editRecord(record);
            DynamicForm_Shipment1.editRecord(record);
            DynamicForm_Shipment2.editRecord(record);
            DynamicForm_Shipment.setValue("createDate", new Date(record.createDate));
            DynamicForm_Shipment1.setValue("swBlDate", new Date(record.swBlDate));
            DynamicForm_Shipment1.setValue("blDate", new Date(record.blDate));
            if (!(record.contract.contact.nameFA == null || record.contract.contact.nameFA == 'undefiend'))
                Shipment_contact_name.setContents(record.contract.contact.nameFA);
            abal.hide();
            Window_Shipment.animateShow();
        }
    }

    var ToolStripButton_Shipment_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Shipment_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_SHIPMENT')">
    var ToolStripButton_Shipment_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Shipment.clearValues();
            DynamicForm_Shipment1.clearValues();
            DynamicForm_Shipment2.clearValues();
            abal.show();
            abal.fetchData();
            Window_Shipment.animateShow();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_SHIPMENT')">
    var ToolStripButton_Shipment_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Shipment.clearValues();
            DynamicForm_Shipment1.clearValues();
            DynamicForm_Shipment2.clearValues();
            ListGrid_Shipment_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_SHIPMENT')">
    var ToolStripButton_Shipment_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Shipment_remove();
        }
    });
    </sec:authorize>

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
                showHover: true,
                required: true,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
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
                showHover: true,
                required: true,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
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
                title: "<spring:message code='shipment.loading'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "portByDischarge.port",
                title: "<spring:message code='shipment.discharge'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [
                {
                    type:"required",
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
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "createDate",
                title: "<spring:message code='global.createDate'/>",
                type: 'text',
                required: true,
                width: "10%",
                align: "center",
                showHover: true,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
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
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "contactByAgent.nameFA",
                title: "<spring:message code='shipment.agent'/>",
                type: 'text',
                width: "10%",
                align: "center",
                showHover: true
            },
            {
                name: "vesselName",
                title: "<spring:message code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
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
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
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
            }
        ],
        sortField: 0,
        filterOnKeypress: true,
        autoFetchData: true,
        showFilterEditor: true,
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
            var dccTableId = record.id;
            var dccTableName = "TBL_SHIPMENT";
            ShipmentAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId)
            hLayoutViewLoader.show();
            var layoutShipment = isc.VLayout.create({
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

    RestDataSource_ContractPerson = isc.MyRestDataSource.create({
        fields:
            [
                {name: "emailCC", title: "CC", primaryKey: true, canEdit: false, hidden: true}
            ],
        fetchDataURL: "${contextPath}/api/contractPerson/spec-list"
    });

    //************************************Email*********************************************
    var RestDataSource_ShipmentEmail = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
                {
                    name: "shipment.contact.nameEN",
                    title: "<spring:message code='contact.name'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "emailType",
                    title: "<spring:message code='shipment.emailType'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "emailSubject",
                    title: "<spring:message code='global.emailSubject'/>",
                    align: "center",
                    width: "10%"
                },
                {name: "emailTo", title: "<spring:message code='global.emailTo'/>", align: "center", width: "10%"},
                {name: "emailCC", title: "<spring:message code='global.emailCC'/>", align: "center", width: "10%"},
                {name: "emailBody", title: "<spring:message code='global.emailBody'/>", align: "center", width: "10%"},
                {
                    name: "emailRespond",
                    title: "<spring:message code='global.emailRespond'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "createUser",
                    title: "<spring:message code='global.createUser'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "createDate",
                    title: "<spring:message code='global.createDate'/>",
                    align: "center",
                    width: "10%"
                },
            ],
        fetchDataURL: "${contextPath}/api/shipmentEmail/spec-list"
    });

    var IButton_ShipmentEmail_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='shipment.email.createAndSend'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_ShipmentEmail.validate();
            if (DynamicForm_ShipmentEmail.hasErrors())
                return;

            var data = DynamicForm_ShipmentEmail.getValues();
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/shipmentEmail/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_ShipmentEmail_refresh();
                            Window_ShipmentEmail.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });

    function ListGrid_ShipmentEmail_refresh() {
        ListGrid_ShipmentEmail.invalidateCache();
        var record = ListGrid_Shipment.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
        };
        ListGrid_ShipmentEmail.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_ShipmentEmail.setData(data);
        });

    }

    function ListGrid_ShipmentEmail_edit() {
        var record = ListGrid_ShipmentEmail.getSelectedRecord();
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
            DynamicForm_ShipmentEmail.editRecord(record);
            Window_ShipmentEmail.show();
        }
    }

    var Menu_ListGrid_ShipmentEmail = isc.Menu.create({
        width: 150,
        data:
            [
                {
                    title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                    click: function () {
                        DynamicForm_ShipmentEmail.clearValues();
                        Window_ShipmentEmail.show();
                    }
                },
                {
                    title: "<spring:message code='shipment.email.saveRespond'/>", icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_ShipmentEmail_edit();
                    }
                }
            ]
    });

    ListGrid_Person_EmailCC = isc.ListGrid.create({
        width: "800",
        height: "400",
        dataSource: RestDataSource_Person_EmailCC,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {
                name: "contact.nameFA",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                width: 120,
                align: "center"
            },
            {
                name: "fullName",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                required: true,
                width: 150,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                name: "title", title: "<spring:message code='person.title'/>", type: 'text', width: 150,
                valueMap: {
                    "MR": "<spring:message code='global.MR'/>",
                    "MIS": "<spring:message code='global.MIS'/>",
                    "MRS": "<spring:message code='global.MRS'/>"
                }
            },
            {name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true,
                validators: [{ type:"required", validateOnChange: true }], width: 150},
            {name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 150},
            {name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 150}
        ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        selectionAppearance: "checkbox"
    });

    var Window_ShipmentEmailCC = isc.Window.create({
        title: "<spring:message code='person.title'/> ",
        width: "800",
        height: "700",
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
                isc.VLayout.create({
                    width: "100%",
                    height: "100%",
                    members:
                        [
                            ListGrid_Person_EmailCC,
                            isc.Button.create({
                                title: "<spring:message code='global.ok'/>",
                                click: function () {
                                    var selectedPerson = ListGrid_Person_EmailCC.getSelection();
                                    if (selectedPerson.length == 0) {
                                        Window_ShipmentEmailCC.close();
                                        return;
                                    }
                                    var persons = "";
                                    var oldPersons;
                                    var check = false;
                                    if (typeof (DynamicForm_ShipmentEmail.getValue("emailCC")) != 'undefined' && DynamicForm_ShipmentEmail.getValue("emailCC") != null) {
                                        persons = DynamicForm_ShipmentEmail.getValue("emailCC");
                                        oldPersons = persons.split(",");
                                        check = true;
                                    }
                                    for (i = 0; i < selectedPerson.length; i++) {
                                        notIn = true;
                                        if (check)
                                            for (j = 0; j < oldPersons.size(); j++)
                                                if (oldPersons[j] == selectedPerson[i].email)
                                                    notIn = false;
                                        if (notIn)
                                            persons = (persons == "" ? persons : persons + ",") + selectedPerson[i].email;
                                    }
                                    DynamicForm_ShipmentEmail.setValue("emailCC", persons);
                                    Window_ShipmentEmailCC.close();
                                }
                            })
                        ]
                })

            ]
    });

    var DynamicForm_ShipmentEmail = isc.DynamicForm.create(
        {
            width: "100%",
            height: "100%",
            titleWidth: "100",
            numCols: 1,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "shipmentId",
                    title: "<spring:message code='contact.name'/>",
                    align: "center",
                    hidden: true
                },
                {
                    name: "emailType",
                    title: "<spring:message code='shipment.emailType'/>",
                    align: "center",
                    width: "700"
                },
                {
                    name: "emailSubject",
                    title: "<spring:message code='global.emailSubject'/>",
                    align: "center",
                    width: "700"
                },
                {
                    name: "emailTo",
                    title: "<spring:message code='global.emailTo'/>",
                    type: 'text',
                    width: 700
                },
                {
                    name: "emailCC",
                    title: "<spring:message code='global.emailCC'/>",
                    width: 700,
                    type: "text",
                    icons: [
                        {
                            src: "icon/search.png",
                            click: function (form, item) {
                                Window_ShipmentEmailCC.show();

                            }
                        }]
                },
                {
                    name: "emailBody",
                    title: "<spring:message code='global.emailBody'/>",
                    align: "center",
                    width: "700",
                    type: "textArea",
                    height: 200
                },
                {
                    name: "emailRespond",
                    title: "<spring:message code='global.emailRespond'/>",
                    align: "center",
                    width: "700",
                    type: "textArea",
                    height: 200
                }]
        });

    var ToolStripButton_ShipmentEmail_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentEmail_refresh();
        }
    });

    var ToolStripButton_ShipmentEmail_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='shipment.email.createAndSend'/>",
        click: function () {
            var record = ListGrid_Shipment.getSelectedRecord();
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
                var contractNo = record.contract.contractNo;
                DynamicForm_ShipmentEmail.clearValues();
                DynamicForm_ShipmentEmail.setValue("shipmentId", record.id);
                DynamicForm_ShipmentEmail.setValue("emailType", record.status);
                DynamicForm_ShipmentEmail.setValue("emailSubject", "Cnt." + contractNo + "-" + record.month + "Quota-" + record.material.descl + "-NICICO/" + record.contract.contact.nameFA + "===" + record.status);
                DynamicForm_ShipmentEmail.setValue("emailBody", ",Dear Sir/Sirs \n According to our settled contract No." + contractNo
                    + ",please kindly note that " + record.amount + " " + record.material.unit.nameEN
                    + " " + record.material.descl + " for " + record.month + " quota is load ready at " + record.portByLoading.port
                    + "\n .Please kindly confirm enabling us to do the needful \n\n Best Regards \n Signature"
                );
                var criteria1 = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "contractId", operator: "equals", value: contractId}]
                };
                RestDataSource_ContractPerson.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                    DynamicForm_ShipmentEmail.setValue("emailCC", data[0].emailCC);
                });
                var criteria1 = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "id", operator: "equals", value: record.contract.contact.id}]
                };
                RestDataSource_Contact__SHIPMENT.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                    DynamicForm_ShipmentEmail.setValue("emailTo", data[0].email);
                });
                Window_ShipmentEmail.show();
            }
        }
    });

    var ToolStripButton_ShipmentEmail_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='shipment.email.saveRespond'/>",
        click: function () {
            ListGrid_ShipmentEmail_edit();
        }
    });

    var ToolStrip_Actions_ShipmentEmail = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_ShipmentEmail_Add,
                ToolStripButton_ShipmentEmail_Edit,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_ShipmentEmail_Refresh,
                    ]
                })
            ]
    });

    var HLayout_ShipmentEmail_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_ShipmentEmail
            ]
    });

    var Window_ShipmentEmail = isc.Window.create({
        title: "<spring:message code='global.email'/> ",
        width: "800",
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
                DynamicForm_ShipmentEmail, IButton_ShipmentEmail_Save
            ]
    });

    var ListGrid_ShipmentEmail = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentEmail,
        contextMenu: Menu_ListGrid_ShipmentEmail,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
                {
                    name: "shipment.contract.contact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "emailType",
                    title: "<spring:message code='shipment.emailType'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "emailSubject",
                    title: "<spring:message code='global.emailSubject'/>",
                    align: "center",
                    width: "10%"
                },
                {name: "emailTo", title: "<spring:message code='global.emailTo'/>", align: "center", width: "10%"},
                {name: "emailCC", title: "<spring:message code='global.emailCC'/>", align: "center", width: "10%"},
                {name: "emailBody", title: "<spring:message code='global.emailBody'/>", align: "center", width: "10%"},
                {
                    name: "emailRespond",
                    title: "<spring:message code='global.emailRespond'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "createUser",
                    title: "<spring:message code='global.createUser'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "createDate",
                    title: "<spring:message code='global.createDate'/>",
                    align: "center",
                    width: "10%"
                },
            ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true
    });

    var HLayout_ShipmentEmail_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentEmail
        ]
    });

    var VLayout_ShipmentEmail_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_ShipmentEmail_Actions, HLayout_ShipmentEmail_Grid
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
                    },
                        {
                            title: "<spring:message code='global.email'/>",
                            items: VLayout_ShipmentEmail_Body,
                            expanded: true,
                            hidden: true
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