<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--<script>--%>

    <% DateUtil dateUtil = new DateUtil();%>

    <spring:eval var="restApiUrl" expression="@environment.getProperty('nicico.rest-api.url')"/>

    var contractId;
    var RestDataSource_ContractPerson;
    var ListGrid_Person_EmailCC;

    var dollar = {};
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${restApiUrl}/api/currency/list",
            httpMethod: "GET",
            data: "",
            callback: function (RpcResponse_o) {
                if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                    var data = JSON.parse(RpcResponse_o.data);
                    for (x of data) {
                        dollar[x.nameEn] = x.nameEn;
                    }
                } //if rpc
            } // callback
        })
    );

    var RestDataSource_Contact = isc.MyRestDataSource.create({
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
                    name: "type", title: "<spring:message code='contact.type'/>", valueMap: {
                        "true": "<spring:message code='contact.type.real'/>",
                        "false": "<spring:message code='contact.type.legal'/>"
                    }
                },
                {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
                {
                    name: "status", title: "<spring:message code='contact.status'/>", valueMap: {
                        "true": "<spring:message
		code='enabled'/>", "false": "<spring:message code='disabled'/>"
                    }
                },
                {name: "contactAccounts"},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>"}
            ],
        fetchDataURL: "${restApiUrl}/api/contact/spec-list"
    });
    var RestDataSource_LoadingPort = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],
        fetchDataURL: "${restApiUrl}/api/port/spec-list1"
    });
    var RestDataSource_DischargePort = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],
        fetchDataURL: "${restApiUrl}/api/port/spec-list2"
    });
    var RestDataSource_SwitchPort = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],
        fetchDataURL: "${restApiUrl}/api/port/spec-list"
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
            ],
        fetchDataURL: "${restApiUrl}/api/shipment/pick-list"
    });

    var RestDataSource_Shipment = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", title: "<spring:message code='contact.name'/>", type: 'long', hidden: true},
            {name: "contactId", type: 'long', hidden: true},
            {name: "contact.nameFA", title: "<spring:message code='contact.name'/>", type: 'text'},
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
            {name: "material.tblUnit.nameEN", title: "<spring:message code='unit.nameEN'/>", type: 'text'},
            {name: "amount", title: "<spring:message code='global.amount'/>", type: 'float'},
            {name: "noContainer", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {name: "noPalete", title: "<spring:message code='shipment.noContainer'/>", type: 'integer'},
            {
                name: "laycan", title: "<spring:message
		code='shipmentContract.laycanStart'/>", type: 'integer', width: "10%", align: "center",
            },
            {
                name: "shipmentType", title: "<spring:message
		code='shipment.shipmentType'/>", type: 'text', width: 400, valueMap: {"b": "bulk", "c": "container"}
            },
            {name: "loading", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "portByLoadingId", title: "<spring:message code='shipment.loading'/>", type: 'text', width: "10%"},
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
            {name: "dischargeAddress", title: "<spring:message code='global.address'/>", type: 'text', width: "10%"},
            {name: "description", title: "<spring:message code='shipment.description'/>", type: 'text', width: "10%"},
            {name: "swb", title: "<spring:message code='shipment.SWB'/>", type: 'text', width: "10%"},
            {name: "switchPort.port", title: "<spring:message code='port.switchPort'/>", type: 'text', width: "10%"},
            {name: "month", title: "<spring:message code='shipment.month'/>", type: 'text', width: "10%"},
            {
                name: "status", title: "<spring:message
		code='shipment.staus'/>", type: 'text', width: "10%", valueMap: {
                    "Load Ready": "<spring:message
		code='shipment.loadReady'/>", "Resource": "<spring:message code='shipment.resource'/>"
                }
            },
            {name: "createDate", title: "<spring:message code='shipment.createDate'/>", type: 'text', width: "10%"},
        ],
        fetchDataURL: "${restApiUrl}/api/shipment/spec-list"
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
                width: 400
            },
            {name: "jobTitle", title: "<spring:message code='person.jobTitle'/>", type: 'text', width: 400},
            {
                name: "title", title: "<spring:message code='person.title'/>", type: 'text', width: 400, valueMap: {
                    "MR": "<spring:message
		code='global.MR'/>", "MIS": "<spring:message code='global.MIS'/>", "MRS": "<spring:message code='global.MRS'/>",
                }
            },
            {name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true, width: 400},
            {name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 400},
            {name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 400}
        ],
        fetchDataURL: "${restApiUrl}/api/person/spec-list"
    });
    var Menu_ListGrid_Shipment = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Shipment_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Shipment.clearValues();
                    abal.show();
                    abal.fetchData();
                    Window_Shipment.animateShow();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Shipment_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Shipment_remove();
                }
            }
        ]
    });
    var dash = "----------------------------------------------------------------";
    var DynamicForm_Shipment = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        dataSource: RestDataSource_Shipment,
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 6, backgroundImage: "backgrounds/leaves.jpg",

        fields: [
            {name: "id", hidden: true,},
            {name: "contactId", hidden: true,},
            {name: "contractId", hidden: true,},
            {name: "materialId", hidden: true,},
            {type: "Header", defaultValue: dash},
            {
                name: "contractShipmentId", ID: "abal", colSpan: 4,
                title: "<spring:message	code='contact.name'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem"
                ,
                optionDataSource: RestDataSource_pickShipmentItem,
                displayField: "contractNo"
                ,
                valueField: "cisId",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true}
                ,
                pickListFields: [{name: "contractNo", width: 50, align: "center"}, {
                    name: "fullname",
                    width: 200,
                    align: "center"
                },
                    {name: "amount", width: 150, align: "center"}, {
                        name: "sendDate",
                        width: 150,
                        align: "center"
                    }, {name: "plan", width: 150, align: "center"}]
                ,
                changed: function () {
                    var record = DynamicForm_Shipment.getItem("contractShipmentId").getSelectedRecord();
                    Shipment_contact_name.setContents(record.fullname);
                    var d = new Date(record.sendDate);
                    DynamicForm_Shipment.setValue("createDateDumy", d);
                    DynamicForm_Shipment.setValue("amount", record.amount);
                    DynamicForm_Shipment1.setValue("dischargeAddress", record.address);
// DynamicForm_Shipment.setValue("createDate",record.plan);
                    DynamicForm_Shipment.setValue("contactId", record.contactID);
                    DynamicForm_Shipment.setValue("materialId", record.materialID);
                    DynamicForm_Shipment.setValue("contractNo", record.contractNo);
                    DynamicForm_Shipment.setValue("month", d.getMonthName());
                    DynamicForm_Shipment2.setValue("status", "Load Ready");
                    DynamicForm_Shipment.setValue("contractId", record.contractID);
                    DynamicForm_Shipment.setValue("contractShipmentId", record.cisId);
                    DynamicForm_Shipment1.setValue("portByDischargeId", record.dischargeID);
                    DynamicForm_Shipment1.setValue("dischargeAddress", record.dischargeAddress);
// cisId,contractNo,fullname,amount,address,plan,sendDate,duration,contactID,materialID,contractID,dischargeID,dischargeAddress
                }
            },
            {type: "Header", defaultValue: dash},
            {name: "createDate", hidden: true,},
            {
                name: "month", colSpan: 2,
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
                name: "createDateDumy", colSpan: 1,
                title: "<spring:message		code='shipment.createDate'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: 'date',
                format: 'DD-MM-YYYY',
                required: true,
                width: "100%"
            },
            {type: "Header", defaultValue: dash},
            {
                name: "loadingLetter",
                colSpan: 2,
                title: "<spring:message		code='shipment.loadingLetter'/>",
                type: 'text',
                required: true,
                width: "100%"
            },
            {
                name: "amount", colSpan: 2,
                title: "<spring:message code='global.amount'/>",
                type: 'float',
                required: true,
                width: "100%",
                keyPressFilter: "[0-9.]",
                validators: [{
                    type: "isFloat",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
            {type: "Header", defaultValue: dash},
            {
                name: "shipmentType", colSpan: 2, title: "<spring:message		code='shipment.shipmentType'/>",
                type: 'text', width: "100%", valueMap: {"b": "bulk", "c": "container"}
            },
            {type: "Header", defaultValue: dash},
            {
                name: "noContainer",
                colSpan: 2,
                title: "<spring:message		code='shipment.noContainer'/>",
                type: 'integer',
                required: false,
                width: "100%",
                keyPressFilter: "[0-9.]",
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
            {
                name: "noBundle", colSpan: 2,
                title: "<spring:message code='shipment.noBundle'/>",
                type: 'integer',
                required: false,
                width: "100%",
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
            {
                name: "noPalete", colSpan: 2,
                title: "<spring:message code='shipment.noPalete'/>",
                type: 'integer',
                required: false,
                width: "100%",
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
            {
                name: "noBarrel", colSpan: 2,
                title: "<spring:message code='shipment.noBarrel'/>",
                type: 'integer',
                required: false,
                width: "100%",
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
            {type: "Header", defaultValue: dash},
            {
                name: "status",
                colSpan: 3,
                title: "<spring:message		code='shipment.staus'/>",
                type: 'text',
                width: "100%",
                valueMap: {
                    "Load Ready": "<spring:message		code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                }
            }
// createDate,month,loadingLetter,amount,shipmentType,noContainer,noBundle,noPalete,noBarrel,blNumbers,blDate,SWB,switchPortId,switchBl,swBlDate,portByLoadingId
// portByDischargeId,consignee,contactByAgentId,vesselName,freight,demurrage,dispatch,status
        ]
    });
    var DynamicForm_Shipment1 = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        dataSource: RestDataSource_Shipment,
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4, backgroundImage: "backgrounds/leaves.jpg",

        fields: [
            {name: "id", hidden: true,},
            {type: "Header", defaultValue: ""},
            {name: "blDate", hidden: true,},
            {
                name: "blDateDumy", colSpan: 1,
                title: "<spring:message		code='shipment.blDate'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: 'date',
                format: 'DD-MM-YYYY',
                required: true,
                width: "100%"
            },
            {
                name: "numberOfBLs", colSpan: 1,
                title: "<spring:message code='shipment.numberOfBLs'/>",
                type: 'integer',
                required: false,
                width: "100%",
                validators: [{
                    type: "isInteger",
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
            {
                name: "blNumbers", colSpan: 3,
                title: "<spring:message code='shipment.blNumbers'/>",
                type: 'text',
                width: "100%",
                align: "center",
            },
            {type: "Header", defaultValue: dash},
            {
                name: "swb", colSpan: 1, title: "<spring:message	code='shipment.SWB'/>",
                type: 'text', width: "100%", defaultValue: "Yes", valueMap: {"Yes": "Yes", "No": "No"}
            },
            {name: "swBlDate", hidden: true,},
            {
                name: "swBlDateDumy", colSpan: 1,
                title: "<spring:message
		code='shipment.swBlDate'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: 'date',
                format: 'DD-MM-YYYY',
                required: true,
                width: "100%"
            },
            {
                name: "switchPortId", colSpan: 3,
                title: "<spring:message
		code='port.switchPort'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_SwitchPort
                ,
                displayField: "port",
                valueField: "id",
                pickListWidth: "400",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true}
                ,
                    pickListFields: [{name: "port", align: "center"}, {name: "country.nameFa", align: "center"}]
            },
            {
                name: "switchBl", colSpan: 3,
                title: "<spring:message code='shipment.switchBl'/>",
                type: 'text',
                width: "100%",
                align: "center",
            },
            {type: "Header", defaultValue: dash},
            {
                name: "portByLoadingId", colSpan: 3,
                title: "<spring:message
		code='shipment.loading'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_LoadingPort
                ,
                displayField: "port",
                valueField: "id",
                pickListWidth: "400",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true}
                ,
                pickListFields: [{name: "port", align: "center"}, {name: "country.nameFa", align: "center"}]
            },
            {
                name: "portByDischargeId", colSpan: 3,
                title: "<spring:message
		code='shipment.discharge'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_DischargePort
                ,
                displayField: "port",
                valueField: "id",
                pickListWidth: "400",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true}
                ,
                pickListFields: [{name: "port", align: "center"}, {name: "country.nameFa", align: "center"}]
            },
            {type: "Header", defaultValue: dash},
            {
                name: "consignee", colSpan: 3,
                title: "<spring:message code='shipment.consignee'/>",
                type: 'text',
                required: true,
                width: "100%"
            },
        ]
    });
    var RestDataSource_Contact_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "transporter", operator: "equals", value: true}]
    };
    var DynamicForm_Shipment2 = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        dataSource: RestDataSource_Shipment,
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4, backgroundImage: "backgrounds/leaves.jpg",

        fields: [
            {name: "id", hidden: true,},
            {type: "Header", defaultValue: ""},
            {
                colSpan: 4,
                name: "contactByAgentId",
                title: "<spring:message
		code='shipment.agent'/>",
                type: 'long',
                width: "100%",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                optionCriteria: RestDataSource_Contact_optionCriteria,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                {name: "nameFA", align: "center"},
                {
                    name: "nameEN",
                    align: "center"
                },
                 {name: "country.nameFa", align: "center"}]
            },
            {type: "Header", defaultValue: dash},
            {
                name: "vesselName", colSpan: 4,
                title: "<spring:message code='shipment.vesselName'/>",
                type: 'text',
                required: true,
                width: "100%"
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
                    validateOnExit: true,
                    stopOnError: true,
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
            {
                name: "freightCurrency", colSpan: 1,
                title: "<spring:message code='currency.title'/>",
                type: 'text',
                defaultValue: "DOLLAR", valueMap: dollar,
                width: "100%",
            },
            {
                name: "totalFreight",
                colSpan: 1,
                title: "<spring:message		code='shipment.totalFreight'/>",
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
            {type: "Header", defaultValue: dash},
            {
                name: "preFreight", colSpan: 1,
                title: "<spring:message code='shipment.preFreight'/>",
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
                name: "preFreightCurrency", colSpan: 1,
                title: "<spring:message code='currency.title'/>",
                type: 'text',
                defaultValue: "DOLLAR", valueMap: dollar,
                width: "100%",
            },
            {
                name: "postFreight", colSpan: 1,
                title: "<spring:message code='shipment.postFreight'/>",
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
                name: "postFreightCurrency", colSpan: 1,
                title: "<spring:message code='currency.title'/>",
                type: 'text',
                defaultValue: "DOLLAR", valueMap: dollar,
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
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
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
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
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
                    errorMessage: "لطفا مقدار عددی وارد نمائید."
                }]
            },
        ]
    });
    var shipmentTabs = isc.TabSet.create({
        height: "500",
        width: "100%",
        showTabScroller: false,
        tabs: [
            {
                title: "<spring:message code='shipment.tab.shipment'/>",
                pane: DynamicForm_Shipment
            },
            {
                title: "<spring:message code='shipment.tab.transport'/>",
                pane: DynamicForm_Shipment1
            },
            {
                title: "<spring:message code='shipment.tab.agent'/>",
                pane: DynamicForm_Shipment2
            }
        ]
    });
    var IButton_Shipment_Save = isc.IButton.create({
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
            var drs = DynamicForm_Shipment.getValue("createDateDumy");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Shipment.setValue("createDate", datestringRs);
            drs = DynamicForm_Shipment1.getValue("swBlDateDumy");
            datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Shipment1.setValue("swBlDate", datestringRs);
            drs = DynamicForm_Shipment1.getValue("blDateDumy");
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
            DynamicForm_Shipment.setValue("dispatch", DynamicForm_Shipment2.getValue("dispatch"));
            DynamicForm_Shipment.setValue("demurrage", DynamicForm_Shipment2.getValue("demurrage"));
            DynamicForm_Shipment.setValue("detention", DynamicForm_Shipment2.getValue("detention"));


            var dataShipment = Object.assign(DynamicForm_Shipment.getValues());
// ######@@@@###&&@@###
            var methodXXXX = "PUT";
            if ((dataShipment.id == null) || (dataShipment.id == 'undefiend')) methodXXXX = "POST";
            isc.RPCManager.sendRequest({
// ######@@@@###&&@@### pls correct callback
                actionURL: "${restApiUrl}/api/shipment/",
                httpMethod: methodXXXX,
                httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(dataShipment),
                serverOutputAsString: false,
//params: { data:data1},
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_Shipment_refresh();
                        Window_Shipment.close();
                    } else {
                        isc.say(RpcResponse_o.data);
                    }
                }
            });
        }
    });

    var ShipmentCancelBtn = isc.IButton.create({
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

    var Window_Shipment = isc.Window.create({
        title: "<spring:message code='Shipment.title'/>. ",
        width: 640,
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
                contents: "<spring:message code='contact.name'/>. ",
                align: "center",
                width: "100%",
                height: 22
            }),
            shipmentTabs,
            isc.HLayout.create({
                width: "100%",
                height: "20",
                layoutMargin: 5,
                membersMargin: 5, align: "center", height: "20",
                members: [
                    IButton_Shipment_Save,
                    ShipmentCancelBtn
                ]
            }),

        ]
    });

    function ListGrid_Shipment_refresh() {
        ListGrid_Shipment.invalidateCache();
    };

    function ListGrid_Shipment_remove() {

        var record = ListGrid_Shipment.getSelectedRecord();

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
                buttons: [isc.Button.create({
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {

                        var shipmentId = record.id;
                        isc.RPCManager.sendRequest({
// ######@@@@###&&@@### pls correct callback
                            actionURL: "${restApiUrl}/api/shipment/" + shipmentId,
                            httpMethod: "DELETE",
                            httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
// httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
// data: shipmentId,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                    ListGrid_Shipment.invalidateCache();
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
            DynamicForm_Shipment.setValue("createDateDumy", new Date(record.createDate));
            DynamicForm_Shipment1.setValue("swBlDateDumy", new Date(record.swBlDate));
            DynamicForm_Shipment1.setValue("blDateDumy", new Date(record.blDate));
            if (!(record.contract.contact.nameFA == null || record.contract.contact.nameFA == 'undefiend'))
                Shipment_contact_name.setContents(record.contract.contact.nameFA);
            abal.hide();
            // abal.fetchData();
            Window_Shipment.animateShow();
        }
    };
    var ToolStripButton_Shipment_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Shipment_refresh();
        }
    });
    var ToolStripButton_Shipment_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Shipment.clearValues();
            abal.show();
            abal.fetchData();
            Window_Shipment.animateShow();
        }
    });
    var ToolStripButton_Shipment_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Shipment_edit();
        }
    });
    var ToolStripButton_Shipment_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Shipment_remove();
        }
    });
    var ToolStrip_Actions_Shipment = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_Shipment_Refresh,
            ToolStripButton_Shipment_Add,
            ToolStripButton_Shipment_Edit,
            ToolStripButton_Shipment_Remove
        ]
    });

    var HLayout_Actions_Shipment = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Shipment
        ]
    });

    var ListGrid_Shipment = isc.MyListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment,
        contextMenu: Menu_ListGrid_Shipment,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contract.contact.nameFA", title: "<spring:message
		code='contact.name'/>", type: 'text', width: "20%", align: "center", showHover: true
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.contractNo", title: "<spring:message
		code='contract.contractNo'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "contract.contractDate", title: "<spring:message
		code='contract.contractDate'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descl", title: "<spring:message
		code='material.descl'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "material.unit.nameEN", title: "<spring:message
		code='unit.nameEN'/>", type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "amount", title: "<spring:message
		code='global.amount'/>", type: 'float', width: "10%", align: "center", showHover: true
            },
            {
                name: "shipmentType", title: "<spring:message
		code='shipment.shipmentType'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "loadingLetter", title: "<spring:message
		code='shipment.loadingLetter'/>", type: 'text', width: "10%", showHover: true
            },
            {
                name: "noContainer", title: "<spring:message
		code='shipment.noContainer'/>", type: 'integer', width: "10%", align: "center", showHover: true
            },
            <%--{name: "laycan", title:"<spring:message code='shipmentContract.laycanStart'/>", type:'integer', width: "10%" , align: "center",showHover:true},--%>
            {
                name: "portByLoading.port", title: "<spring:message
		code='shipment.loading'/>", type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "portByDischarge.port", title: "<spring:message
		code='shipment.discharge'/>", type: 'text', required: true, width: "10%", showHover: true
            },
// {name: "dischargeAddress", title:"<spring:message
		code='global.address'/>", type:'text', required: true, width: "10%" ,showHover:true},
            {
                name: "description", title: "<spring:message
		code='shipment.description'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "contractShipment.sendDate", title: "<spring:message
		code='global.sendDate'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "createDate", title: "<spring:message
		code='global.createDate'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "month", title: "<spring:message
		code='shipment.month'/>", type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "contactByAgent.nameFA", title: "<spring:message
		code='shipment.agent'/>", type: 'text', width: "20%", align: "center", showHover: true
            },
            {
                name: "vesselName", title: "<spring:message
		code='shipment.vesselName'/>", type: 'text', required: true, width: "10%", showHover: true
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
                name: "switchPort.port", title: "<spring:message
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
            var record = this.getSelectedRecord();
            contractId = record.contractId;
            ListGrid_ShipmentEmail.fetchData({"shipment.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_ShipmentEmail.setData(data);
            }, {operationId: "00"});
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

    RestDataSource_ContractPerson = isc.RestDataSource.create({
        fields:
            [
                {name: "emailCC", title: "CC", primaryKey: true, canEdit: false, hidden: true}
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
        fetchDataURL: "${restApiUrl}/api/contractPerson/spec-list"
    });

    //************************************Email*********************************************
    var RestDataSource_ShipmentEmail = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
                {
                    name: "shipment.tblContact.nameEN",
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
        fetchDataURL: "${restApiUrl}/api/shipmentEmail/spec-list"
    });

    var IButton_ShipmentEmail_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='shipment.email.createAndSend'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_ShipmentEmail.validate();
            if (DynamicForm_ShipmentEmail.hasErrors())
                return;

            var data = DynamicForm_ShipmentEmail.getValues();
// ######@@@@###&&@@###
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest({
// ######@@@@###&&@@### pls correct callback
                actionURL: "${restApiUrl}/api/shipmentEmail/",
                httpMethod: methodXXXX,
                httpHeaders: {"Authorization": "Bearer " + "${cookie['access_token'].getValue()}"},
// httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
//params: { data:data1},
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_ShipmentEmail_refresh();
                        Window_ShipmentEmail.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            });
        }
    });

    function ListGrid_ShipmentEmail_refresh() {
        ListGrid_ShipmentEmail.invalidateCache();
        var record = ListGrid_Shipment.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        ListGrid_ShipmentEmail.fetchData({"shipment.id": record.id}, function (dsResponse, data, dsRequest) {
            ListGrid_ShipmentEmail.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_ShipmentEmail_edit() {

        var record = ListGrid_ShipmentEmail.getSelectedRecord()
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
    ListGrid_Person_EmailCC = isc.MyListGrid.create({
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
                width: 150
            },
            {
                name: "title", title: "<spring:message code='person.title'/>", type: 'text', width: 150, valueMap: {
                    "MR": "<spring:message
		code='global.MR'/>", "MIS": "<spring:message code='global.MIS'/>", "MRS": "<spring:message code='global.MRS'/>",
                }
            },
            {name: "email", title: "<spring:message code='person.email'/>", type: 'text', required: true, width: 150},
            {name: "email1", title: "<spring:message code='person.email1'/>", type: 'text', width: 150},
            {name: "email2", title: "<spring:message code='person.email2'/>", type: 'text', width: 150}
        ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt",
        selectionAppearance: "checkbox"
    });
    var Window_ShipmentEmailCC = isc.Window.create({
        title: "<spring:message code='person.title'/> ",
        width: "800",
        hight: "700",
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
                            ListGrid_Person_EmailCC
                            ,
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
    var DynamicForm_ShipmentEmail = isc.DynamicForm.create({
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
                {name: "shipmentId", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
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
                {name: "emailTo", title: "<spring:message code='global.emailTo'/>", type: 'text', width: 700},
                {
                    name: "emailCC", title: "<spring:message code='global.emailCC'/>", width: 700, type: "text"
                    , icons: [{
                        src: "icon/search.png",
                        click: function (form, item) {
                            Window_ShipmentEmailCC.show();

                        }
                    }]
                },
                {
                    name: "emailBody", title: "<spring:message
		code='global.emailBody'/>", align: "center", textAlign: "left", width: "700", type: "textArea", height: 200
                },
                {
                    name: "emailRespond", title: "<spring:message
		code='global.emailRespond'/>", align: "center", textAlign: "left", width: "700", type: "textArea", height: 200
                }
            ]
    });

    var ToolStripButton_ShipmentEmail_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentEmail_refresh();
        }
    });

    var ToolStripButton_ShipmentEmail_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='shipment.email.createAndSend'/>",
        click: function () {
            var record = ListGrid_Shipment.getSelectedRecord();
            var contractNo = record.contract.contractNo;
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
                DynamicForm_ShipmentEmail.clearValues();
                DynamicForm_ShipmentEmail.setValue("shipment.id", record.id);
                DynamicForm_ShipmentEmail.setValue("emailType", record.status);
                DynamicForm_ShipmentEmail.setValue("emailSubject", "Cnt." + contractNo + "-" + record.month + "Quota-" + record.tblMaterial.descl + "-NICICO/" + record.tblContact.nameFA + "===" + record.status);
                DynamicForm_ShipmentEmail.setValue("emailBody", ",Dear Sir/Sirs \n According to our settled contract No." + contractNo
                    + ",please kindly note that " + record.amount + " " + record.tblMaterial.tblUnit.nameEN
                    + " " + record.tblMaterial.descl + " for " + record.month + " quota is load ready at " + record.loading
                    + "\n .Please kindly confirm enabling us to do the needful \n\n Best Regards \n Signature"
                );
                RestDataSource_ContractPerson.fetchData({contractId: contractId}, function (dsResponse, data, dsRequest) {
                    DynamicForm_ShipmentEmail.setValue("emailCC", data[0].emailCC);
                });
                RestDataSource_Contact.fetchData({"id": record.tblContactId}, function (dsResponse, data, dsRequest) {
                    DynamicForm_ShipmentEmail.setValue("emailTo", data[0].email);
                });

                Window_ShipmentEmail.show();
            }
        }
    });

    var ToolStripButton_ShipmentEmail_Edit = isc.ToolStripButton.create({
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
                ToolStripButton_ShipmentEmail_Refresh,
                ToolStripButton_ShipmentEmail_Add,
                ToolStripButton_ShipmentEmail_Edit
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
        hight: "700",
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
    var ListGrid_ShipmentEmail = isc.MyListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentEmail,
        contextMenu: Menu_ListGrid_ShipmentEmail,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
                {
                    name: "shipment.tblContact.nameEN",
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
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        startsWithTitle: "tt",
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
// ListGrid_ShipmentEmail.fetchData({"shipment.id":record.id},function (dsResponse, data, dsRequest) {
// ListGrid_ShipmentEmai.setData(data);
// },{operationId:"00"});
        },
        dataArrived: function (startRow, endRow) {
        }

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

    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    isc.SectionStack.create({
        ID: "Shipment_Section_Stack",
        sections:
            [
                {title: "<spring:message code='Shipment.title'/>", items: VLayout_Body_Shipment, expanded: true}
                , {title: "<spring:message code='global.email'/>", items: VLayout_ShipmentEmail_Body, expanded: true}
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });
