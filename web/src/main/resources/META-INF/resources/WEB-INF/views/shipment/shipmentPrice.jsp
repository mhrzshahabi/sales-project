<%@ page import="com.nicico.core.copper.config.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <% DateUtil dateUtil = new DateUtil();%>
    var shipmentHeaderIdByPrice;
    var RestDataSource_Shipment_HeaderByPrice = isc.RestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, align: "center", hidden: true},
            {name: "shipmentHeaderDate", title: "<spring:message code='shipmentHeader.date'/>", align: "center"},
            {name: "description", title: "<spring:message code='shipmentHeader.description'/>", align: "center"}

        ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/shipmentHeader/list"
    });
    var RestDataSource_Shipment_Price = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "tblShipment.id", title: "id", canEdit: false},
                {name: "tblShipment.tblContract.contractNo", title: "contractNo", canEdit: false, hidden: true},
                {name: "tblShipment.month", title: "month", canEdit: false, hidden: true},
                {name: "tblShipment.tblMaterial.tblUnit.nameEN", title: "unit", canEdit: false, hidden: true},
                {name: "tblShipment.loading", title: "loading", canEdit: false, hidden: true},
                {name: "tblShipment.discharge", title: "discharge", canEdit: false, hidden: true},
                {name: "tblShipment.tblMaterial.descl", title: "descl", canEdit: false, hidden: true},
                {name: "tblShipment.amount", title: "amount", canEdit: false, hidden: true},
                {
                    name: "capacity",
                    title: "<spring:message code='shipment.Price.capacity'/>",
                    type: 'long',
                    hidden: true
                },
                {name: "tblCountryByflag.id", type: 'long', hidden: true},
                {name: "tblShipmentInquiry.id", title: "<spring:message code='shipment.inquiry.id'/>", type: 'text'},
                {
                    name: "tblContactByCompany.nameEn",
                    title: "<spring:message code='shipment.Price.shipingCompany'/>",
                    type: 'text'
                },
                {
                    name: "laycanStart",
                    title: "<spring:message code='shipment.Price.laycanStart'/>",
                    type: 'long',
                    hidden: true
                },
                {name: "laycanEnd", title: "<spring:message code='shipment.Price.laycanEnd'/>", type: 'text'},
                {name: "loadingRate", title: "<spring:message code='shipment.Price.loadingRate'/>", type: 'text'},
                {name: "dischargeRate", title: "<spring:message code='shipment.Price.dischargeRate'/>", type: 'float'},
                {name: "demurrage", title: "<spring:message code='shipment.Price.demurrage'/>", type: 'integer'},
                {
                    name: "dispatch",
                    title: "<spring:message code='shipment.Price.dispatch'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "freight",
                    title: "<spring:message code='shipment.Price.freight'/>",
                    type: 'text',
                    required: true,
                    width: "10%"
                },
                {
                    name: "vesselName", title: "<spring:message
		code='shipment.Price.vessel'/>", type: 'text', required: true, width: "10%"
                },
                {
                    name: "yearOfBuilt", title: "<spring:message
		code='shipment.Price.yearOfBuilt'/>", type: 'text', required: true, width: "10%"
                },
                {name: "imo", title: "<spring:message code='shipment.Price.imo'/>", type: 'text', width: "10%"},
                {
                    name: "holds",
                    title: "<spring:message code='shipment.Price.holds'/>",
                    type: 'text',
                    required: true,
                    width: "10%"
                },
                {
                    name: "cranesNO", title: "<spring:message
		code='shipment.Price.cranesNo'/>", type: 'text', required: true, width: "10%"
                },
                {
                    name: "ETA",
                    title: "<spring:message code='shipment.Price.ETA'/>",
                    type: 'text',
                    required: true,
                    width: "10%"
                },
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/shipmentPrice/list"
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
    var RestDataSource_ShipmentInq = isc.RestDataSource.create({
        fields:
            [
                {
                    name: "id",
                    title: "<spring:message code='contact.code'/>",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {name: "tblShipment.id", title: "<spring:message code='contact.name'/>", align: "center", hidden: true},
                {
                    name: "tblShipment.tblContact.nameEN",
                    title: "<spring:message code='contact.name'/>",
                    align: "center",
                    width: "10%"
                },
                {
                    name: "tblShipment.shipmentType",
                    title: "<spring:message code='shipment.inquiry.type'/>",
                    align: "center",
                    width: "10%"
                    ,
                    valueMap:
                        {
                            "b": "<spring:message code='shipment.inquiry.bulk'/>",
                            "c": "<spring:message code='shipment.inquiry.container'/>"
                        }
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
        fetchDataURL: "rest/shipmentInquiry/list"
    });
    var RestDataSource_Country_Price = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
                {name: "nameEn", title: "<spring:message code='global.country'/> "}
            ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/country/list"
    });
    var RestDataSource_Contact = isc.RestDataSource.create({
        fields: [
            {name: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='contact.code'/>"},
            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"}
        ],
        dataFormat: "json",
        jsonPrefix: "",
        jsonSuffix: "",
        fetchDataURL: "rest/contact/list"
    });

    //---------------------------------------------------------- shipment Header--------------------------------------------------------------------------------------------
    function ListGrid_Shipment_HeaderByPrice_refresh() {
        ListGrid_Shipment_HeaderByPrice.invalidateCache();
        var record = ListGrid_Shipment_HeaderByPrice.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        ListGrid_Shipment_HeaderByPrice.fetchData({}, function (dsResponse, data, dsRequest) {
            ListGrid_Shipment_HeaderByPrice.setData(data);
        }, {operationId: "00"});
    }

    var ListGrid_Shipment_HeaderByPrice = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment_HeaderByPrice,

        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, align: "center", hidden: true},
            {name: "shipmentHeaderDate", title: "<spring:message code='shipmentHeader.date'/>", align: "center"},
            {name: "description", title: "<spring:message code='shipmentHeader.description'/>", align: "center"}
        ],
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();

            ListGrid_ShipmentByPrice.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_ShipmentByPrice.setData(data);
            }, {operationId: "00"});

            ListGrid_Shipment_Price.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_Shipment_Price.setData(data);
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
    var HLayout_Grid_Shipment_HeaderByPrice = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment_HeaderByPrice
        ]
    });

    var VLayout_Body_Shipment_HeaderByPrice = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [

            HLayout_Grid_Shipment_HeaderByPrice
        ]
    });

    /*********************************************************************************/
    var RestDataSource_ShipmentByPrice = isc.RestDataSource.create({
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

    var ListGrid_ShipmentByPrice = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentByPrice,
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
            var record = this.getSelectedRecord();
            ListGrid_Shipment_Price.fetchData({"tblShipment.id": record.id}, function (dsResponse, data, dsRequest) {
                ListGrid_Shipment_Price.setData(data);
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
    var HLayout_Grid_ShipmentByPrice = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentByPrice
        ]
    });

    var VLayout_Body_ShipmentByPrice = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Grid_ShipmentByPrice
        ]
    });
    /* ********************************************************************************/
    var Menu_ListGrid_Shipment_Price = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Shipment_Price_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Shipment_Price.clearValues();
                    Window_Shipment_Price.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Shipment_Price_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Shipment_Price_remove();
                }
            }
        ]
    });

    var ValuesManager_Shipment_Price = isc.ValuesManager.create({});
    var DynamicForm_Shipment_Price = isc.DynamicForm.create({
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
                {name: "tblShipment.id", hidden: true},
                {type: "RowSpacerItem"},
                {
                    name: "capacity", title: "<spring:message
		code='shipment.Price.capacity'/>", type: 'float', required: true, colSpan: 1, titleColSpan: 1,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },

                {
                    name: "tblShipmentInquiry.id",
                    title: "<spring:message
		code='shipment.inquiry.name'/>",
                    type: 'long',
                    editorType: "SelectItem",
                    colSpan: 1,
                    titleColSpan: 1
                    ,
                    optionDataSource: RestDataSource_ShipmentInq,
                    displayField: "tblShipment.tblContact.nameEN"
                    ,
                    valueField: "id",
                    pickListWidth: "450",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "tblShipment.tblContact.nameEN", width: 150, align: "center"}, {
                        name: "id",
                        width: 150,
                        align: "center"
                    }, {name: "tblShipment.shipmentType", width: 150, align: "center"}]
                },

                {
                    name: "tblContactByCompany.id",
                    title: "<spring:message
		code='shipment.Price.shipingCompany'/>",
                    type: 'long',
                    editorType: "SelectItem",
                    colSpan: 1,
                    titleColSpan: 1
                    ,
                    optionDataSource: RestDataSource_Contact,
                    displayField: "nameEN",
                    wrapTitle: false
                    ,
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
                    name: "tblCountryByflag.id", title: "<spring:message
		code='shipment.flag'/>", type: 'long', editorType: "SelectItem", colSpan: 1, titleColSpan: 1
                    , optionDataSource: RestDataSource_Country_Price, displayField: "nameEn"
                    , valueField: "id", pickListProperties: {showFilterEditor: true}
                    , pickListFields: [{name: "nameEn", width: 150, align: "center"}]
                },

                {
                    name: "laycanStartDummy", title: "<spring:message
		code='shipment.Price.laycanStart'/>", type: "date", wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "laycanEndDummy", title: "<spring:message
		code='shipment.Price.laycanEnd'/>", type: "date", wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "loadingRate", title: "<spring:message
		code='shipment.Price.loadingRate'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "dischargeRate", title: "<spring:message
		code='shipment.Price.dischargeRate'/>", type: 'float', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "demurrage",
                    title: "<spring:message code='shipment.Price.demurrage'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "dispatch",
                    title: "<spring:message code='shipment.Price.dispatch'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "freight",
                    title: "<spring:message code='shipment.Price.freight'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "vesselName", title: "<spring:message
		code='shipment.Price.vessel'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "yearOfBuilt", title: "<spring:message
		code='shipment.Price.yearOfBuilt'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "imo",
                    title: "<spring:message code='shipment.Price.imo'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "holds",
                    title: "<spring:message code='shipment.Price.holds'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "cranesNO",
                    title: "<spring:message code='shipment.Price.cranesNo'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "ETA",
                    title: "<spring:message code='shipment.Price.ETA'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
            ]
    });
    var DynamicForm_Shipment_Price_Container = isc.DynamicForm.create({
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
                {name: "tblShipment.id", hidden: true},
                {type: "RowSpacerItem"},
                {
                    name: "capacity", title: "<spring:message
		code='shipment.Price.capacity'/>", type: 'float', required: true, colSpan: 1, titleColSpan: 1,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "لطفا مقدار عددی وارد نمائید."
                    }]
                },

                {
                    name: "tblShipmentInquiry.id",
                    title: "<spring:message
		code='shipment.inquiry.name'/>",
                    type: 'long',
                    editorType: "SelectItem",
                    colSpan: 1,
                    titleColSpan: 1
                    ,
                    optionDataSource: RestDataSource_ShipmentInq,
                    displayField: "tblShipment.tblContact.nameEN"
                    ,
                    valueField: "id",
                    pickListWidth: "450",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "tblShipment.tblContact.nameEN", width: 150, align: "center"}, {
                        name: "id",
                        width: 150,
                        align: "center"
                    }, {name: "tblShipment.shipmentType", width: 150, align: "center"}]
                },

                {
                    name: "tblContactByCompany.id",
                    title: "<spring:message
		code='shipment.Price.shipingCompany'/>",
                    type: 'long',
                    editorType: "SelectItem"
                    ,
                    optionDataSource: RestDataSource_Contact,
                    displayField: "nameEN",
                    wrapTitle: false,
                    colSpan: 1,
                    titleColSpan: 1
                    ,
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
                    name: "laycanStartDummy", title: "<spring:message
		code='shipment.Price.laycanStart'/>", type: "date", wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "laycanEndDummy", title: "<spring:message
		code='shipment.Price.laycanEnd'/>", type: "date", wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "loadingRate", title: "<spring:message
		code='shipment.Price.loadingRate'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "dischargeRate", title: "<spring:message
		code='shipment.Price.dischargeRate'/>", type: 'float', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "demurrage",
                    title: "<spring:message code='shipment.Price.demurrage'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "dispatch",
                    title: "<spring:message code='shipment.Price.dispatch'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "freight",
                    title: "<spring:message code='shipment.Price.freight'/>",
                    type: 'text',
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    name: "vesselName", title: "<spring:message
		code='shipment.Price.vessel'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "imo", title: "<spring:message
		code='shipment.Price.imo'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "swbCost", title: "<spring:message
		code='shipment.Price.swbCost'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "vat", title: "<spring:message
		code='shipment.Price.vat'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "BL_FREE", title: "<spring:message
		code='shipment.Price.BL_FREE'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "THC", title: "<spring:message
		code='shipment.Price.THC'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                },
                {
                    name: "rate", title: "<spring:message
		code='shipment.Price.rate'/>", type: 'text', wrapTitle: false, colSpan: 1, titleColSpan: 1
                }
            ]
    });
    var IButton_Shipment_Save_Price = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {

            var d = DynamicForm_Shipment_Price.getValue("laycanStartDummy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
            DynamicForm_Shipment_Price.setValue("laycanStart", datestring)

            var d1 = DynamicForm_Shipment_Price.getValue("laycanEndDummy");
            var datestring1 = (d1.getFullYear() + "/" + ("0" + (d1.getMonth() + 1)).slice(-2) + "/" + ("0" + d1.getDate()).slice(-2))
            DynamicForm_Shipment_Price.setValue("laycanEnd", datestring1)

            ValuesManager_Shipment_Price.validate();
            DynamicForm_Shipment_Price.validate();
            if (DynamicForm_Shipment_Price.hasErrors()) {
                return;
            }


            var data = DynamicForm_Shipment_Price.getValues();
            alert(shipmentHeaderIdByPrice)
            DynamicForm_Shipment_Price.setValue("tblShipmentHeader.id", shipmentHeaderIdByPrice);
            isc.RPCManager.sendRequest({
                actionURL: "rest/shipmentPrice/add",
                httpMethod: "POST",
                useSimpleHttp: true,
                contentType: "application/json; charset=utf-8",
                showPrompt: false,
                data: JSON.stringify(data),
                serverOutputAsString: false,
// params: { data:data1},
                callback: function (RpcResponse_o) {
                    if (RpcResponse_o.data == 'success') {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_Shipment_Price_refresh();
                        Window_Shipment_Price.close();
                    } else {
                        isc.say(RpcResponse_o.data);
                    }
                }
            });
        }
    });
    var IButton_Shipment_Save_Price_container = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {

            var d = DynamicForm_Shipment_Price_Container.getValue("laycanStartDummy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2))
            DynamicForm_Shipment_Price_Container.setValue("laycanStart", datestring)

            var d1 = DynamicForm_Shipment_Price_Container.getValue("laycanEndDummy");
            var datestring1 = (d1.getFullYear() + "/" + ("0" + (d1.getMonth() + 1)).slice(-2) + "/" + ("0" + d1.getDate()).slice(-2))
            DynamicForm_Shipment_Price_Container.setValue("laycanEnd", datestring1)

            DynamicForm_Shipment_Price_Container.validate();
            if (DynamicForm_Shipment_Price_Container.hasErrors()) {
                return;
            }

            var record = ListGrid_ShipmentByPrice.getSelectedRecord();
            DynamicForm_Shipment_Price_Container.setValue("tblShipment.id", record.id)
            alert(DynamicForm_Shipment_Price_Container.getValue("tblCountryByflag.id"));
            var data = DynamicForm_Shipment_Price_Container.getValues();
            isc.RPCManager.sendRequest({
                actionURL: "rest/shipmentPrice/add",
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
                        ListGrid_Shipment_Price_refresh();
                        Window_Shipment_Price_continar.close();
                    } else {
                        isc.say(RpcResponse_o.data);
                    }
                }
            });
        }
    });
    var Window_Shipment_Price = isc.Window.create({
        title: "<spring:message code='shipment.Price'/>",
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
            DynamicForm_Shipment_Price,
            isc.HLayout.create({
                width: "100%",
                members:
                    [
                        IButton_Shipment_Save_Price,
                        isc.Label.create({
                            width: 5,
                        }),
                        isc.IButton.create({
                            ID: "Shipment_PriceExitIButton",
                            title: "<spring:message code='global.cancel'/>",
                            width: 100,
                            icon: "pieces/16/icon_delete.png",
                            orientation: "vertical",
                            click: function () {
                                Window_Shipment_Price.close();
                            }
                        })
                    ]
            })
        ]
    });
    var Window_Shipment_Price_continar = isc.Window.create({
        title: "<spring:message code='shipment.Price'/>",
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
            DynamicForm_Shipment_Price_Container,
            isc.HLayout.create({
                width: "100%",
                members:
                    [
                        IButton_Shipment_Save_Price_container,
                        isc.Label.create({
                            width: 5,
                        }),
                        isc.IButton.create({
                            ID: "shipment_Price_ContainerExitIButton",
                            title: "<spring:message code='global.cancel'/>",
                            width: 100,
                            icon: "pieces/16/icon_delete.png",
                            orientation: "vertical",
                            click: function () {
                                Window_Shipment_Price_continar.close();
                            }
                        })
                    ]
            })
        ]
    });

    function ListGrid_Shipment_Price_refresh() {
        ListGrid_Shipment_Price.invalidateCache();
        var record = ListGrid_Shipment_HeaderByPrice.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        ListGrid_Shipment_Price.fetchData({"tblShipmentHeader.id": record.id}, function (dsResponse, data, dsRequest) {
            ListGrid_Shipment_Price.setData(data);
        });
    };

    function ListGrid_Shipment_Price_remove() {

        var record = ListGrid_Shipment_Price.getSelectedRecord();

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
                            actionURL: "rest/shipmentPrice/remove/" + shipmentId,
                            httpMethod: "POST",
                            useSimpleHttp: true,
                            contentType: "application/json; charset=utf-8",
                            showPrompt: true,
// data: shipmentId,
                            serverOutputAsString: false,
                            callback: function (RpcResponse_o) {
                                if (RpcResponse_o.data == 'success') {
                                    ListGrid_Shipment_Price.invalidateCache();
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

    function ListGrid_Shipment_Price_edit() {

        var record = ListGrid_Shipment_Price.getSelectedRecord();
        ListGrid_ShipmentByPrice.selectAllRecords();
        var selectionShipment = ListGrid_ShipmentByPrice.getSelection();

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
        } else if (selectionShipment[0].id != null && selectionShipment[0].shipmentType == 'b') {
            DynamicForm_Shipment_Price.editRecord(record);
            DynamicForm_Shipment_Price.setValue("laycanStartDummy", new Date(record.laycanStart));
            DynamicForm_Shipment_Price.setValue("laycanEndDummy", new Date(record.laycanEnd));
            Window_Shipment_Price.show();
        } else if (selectionShipment[0].id != null && selectionShipment[0].shipmentType == 'c') {
            DynamicForm_Shipment_Price_Container.editRecord(record);
            DynamicForm_Shipment_Price_Container.setValue("laycanStartDummy", new Date(record.laycanStart));
            DynamicForm_Shipment_Price_Container.setValue("laycanEndDummy", new Date(record.laycanEnd));
            Window_Shipment_Price_continar.show();
        }
    };
    var ToolStripButton_Shipment_Price_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Shipment_Price_refresh();
        }
    });
    var ToolStripButton_Shipment_Price_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            ListGrid_ShipmentByPrice.selectAllRecords();
            var record = ListGrid_Shipment_HeaderByPrice.getSelectedRecord();
            var selectionShipment = ListGrid_ShipmentByPrice.getSelection();
            shipmentHeaderIdByPrice = record.id;
            if (selectionShipment == null || selectionShipment[0].id == null) {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function () {
                        this.hide();
                    }
                });
            } else if (selectionShipment[0].shipmentType != null && selectionShipment[0].shipmentType == 'b') {
                DynamicForm_Shipment_Price.clearValues();
                Window_Shipment_Price.show();
            } else if (selectionShipment[0].shipmentType != null && selectionShipment[0].shipmentType == 'c') {
                DynamicForm_Shipment_Price_Container.clearValues();
                Window_Shipment_Price_continar.show();
            }
        }
    });
    var ToolStripButton_Shipment_Price_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            var record = ListGrid_Shipment_Price.getSelectedRecord();
            ListGrid_ShipmentByPrice.selectAllRecords();
            var selectionShipment = ListGrid_ShipmentByPrice.getSelection();
            if (selectionShipment[0] != null && selectionShipment[0].shipmentType == 'b') {
                ListGrid_Shipment_Price_edit();
            } else if (selectionShipment[0] != null && selectionShipment[0].shipmentType == 'c') {
                ListGrid_Shipment_Price_edit();
            }
        }
    });
    var ToolStripButton_Shipment_Price_Remove = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Shipment_Price_remove();
        }
    });
    var ToolStripButton_Shipment_Price_Print = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/print.png",
        title: "<spring:message code='global.form.print'/>",
        click: function () {
            ListGrid_ShipmentByPrice.selectAllRecords();
            var record = ListGrid_ShipmentByPrice.getSelection();
            /* var record = ListGrid_Shipment_Price.getSelectedRecord();*/
            var loading = "";
            if (typeof (record[0].tblPortByLoading.port) != 'undefined')
                loading = record[0].tblPortByLoading.port;
            var discharge = "";
            if (typeof (record[0].tblPortByDischarge.port) != 'undefined')
                discharge = record[0].tblPortByDischarge.port;

            var headerTxt = "Ctr" + record[0].tblContract.contractNo.replaceAll("/", "") + "-" + record[0].month.replaceAll("/", "") + " Quota-Shipment of "
                + record[0].amount + " " + record[0].tblMaterial.tblUnit.nameEN
                + " 5 " + record[0].tblMaterial.descl + " -" + loading + " to" + discharge
                + " , Main Ports ==> " + record[0].amount + " " + record[0].tblMaterial.tblUnit.nameEN + " Nanjing Port"
            ;
            window.open("shipmentPrice/printDocx/" + record[0].id + "/" + headerTxt);

        }
    });
    var ToolStrip_Actions_Shipment_Price = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_Shipment_Price_Refresh,
            ToolStripButton_Shipment_Price_Add,
            ToolStripButton_Shipment_Price_Edit,
            ToolStripButton_Shipment_Price_Remove,
            ToolStripButton_Shipment_Price_Print,
        ]
    });

    var HLayout_Actions_Shipment_Price = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Shipment_Price
        ]
    });

    var ListGrid_Shipment_Price = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Shipment_Price,
        contextMenu: Menu_ListGrid_Shipment_Price,
        autoFetchData: false,
        fields: [
            {name: "id", hidden: true},
            {
                name: "laycanStart", title: "<spring:message
		code='shipment.Price.laycanStart'/>", type: 'text', width: "10%", align: "center"
            },
            {
                name: "laycanEnd", title: "<spring:message
		code='shipment.Price.laycanEnd'/>", type: 'text', width: "10%", align: "center"
            },
            {
                name: "demurrage", title: "<spring:message
		code='shipment.Price.demurrage'/>", type: 'text', width: "10%", align: "center"
            },
            {
                name: "dispatch", title: "<spring:message
		code='shipment.Price.dispatch'/>", type: 'text', width: "10%", align: "center"
            },
            {
                name: "freight", title: "<spring:message
		code='shipment.Price.freight'/>", type: 'text', required: true, width: "10%", align: "center"
            },
            {
                name: "dischargeRate", title: "<spring:message
		code='shipment.Price.dischargeRate'/>", type: 'float', width: "10%", align: "center"
            },
            {
                name: "loadingRate", title: "<spring:message
		code='shipment.Price.loadingRate'/>", type: 'text', width: "10%", align: "center"
            },
            {
                name: "hatch", title: "<spring:message
		code='shipment.Price.hatch'/>", type: 'text', required: true, width: "10%", align: "center"
            },
            {
                name: "holds", title: "<spring:message
		code='shipment.Price.holds'/>", type: 'text', required: true, width: "10%", align: "center"
            },
            {
                name: "cranesNO", title: "<spring:message
		code='shipment.Price.cranesNo'/>", type: 'float', required: true, width: "10%", align: "center"
            },
            {
                name: "capacity", title: "<spring:message
		code='shipment.Price.capacity'/>", type: 'float', required: true, width: "10%", align: "center"
            },
            {
                name: "yearOfBuilt", title: "<spring:message
		code='shipment.Price.yearOfBuilt'/>", type: 'text', required: true, width: "10%", align: "center"
            },
            {
                name: "imo",
                title: "<spring:message code='shipment.Price.imo'/>",
                type: 'text',
                width: "10%",
                align: "center"
            },
            {
                name: "vesselName", title: "<spring:message
		code='shipment.Price.vessel'/>", type: 'text', required: true, width: "10%", align: "center"
            },
            {
                name: "tblContactByCompany.nameEn", title: "<spring:message
		code='shipment.Price.shipingCompany'/>", type: 'text', required: true, width: "10%", align: "center"
            }
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
    var HLayout_Grid_Shipment_Price = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment_Price
        ]
    });

    var VLayout_Body_Shipment_Price = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                HLayout_Actions_Shipment_Price, HLayout_Grid_Shipment_Price
            ]
    });

    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    isc.SectionStack.create({
        ID: "Shipment_Price_Section_Stack",
        sections:
            [
                {
                    title: "<spring:message code='shipmentHeader.title'/>",
                    items: VLayout_Body_Shipment_HeaderByPrice,
                    expanded: true
                }
                , {
                title: "<spring:message code='Shipment.title'/>",
                items: VLayout_Body_ShipmentByPrice,
                expanded: true
            }
                , {
                title: "<spring:message code='evaluationResult.title'/>",
                items: VLayout_Body_Shipment_Price,
                expanded: true
            }
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });