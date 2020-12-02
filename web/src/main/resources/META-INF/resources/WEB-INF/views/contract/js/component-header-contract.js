var RestDataSource_Material = isc.MyRestDataSource.create({
    fields:
        [
            {name: "id", title: "id", primaryKey: true, hidden: true},
            {name: "code", title: "<spring:message code='goods.code'/> "},
            {name: "descEN"},
            {name: "unitId"},
            {name: "unit.nameEN"},
        ],
    fetchDataURL: "${contextPath}/api/material/spec-list"
})
var RestDataSource_Parameters = isc.MyRestDataSource.create(
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
                name: "paramName",
                title: "<spring:message code='parameters.paramName'/>",
                width: 200
            },
            {
                name: "paramValue",
                title: "<spring:message code='parameters.paramValue'/>",
                width: 200
            },
            {
                name: "contractId",
                title: "<spring:message code='parameters.paramValue'/>",
                width: 200
            },
            {
                name: "categoryValue",
                title: "<spring:message code='parameters.paramValue'/>",
                width: 200
            }],

        fetchDataURL: "${contextPath}/api/parameters/spec-list"
    });

var RestDataSource_Contact = isc.MyRestDataSource.create({
    fields: [
        {name: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "code", title: "<spring:message code='contact.code'/>"},
        {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
        {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
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
        {name: "ceoPassportNo"},
        {name: "ceo"},
        {name: "commercialRole"},
        {
            name: "status",
            title: "<spring:message code='contact.status'/>",
            valueMap: {"true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"}
        },
        {name: "tradeMark"},
        {name: "commercialRegistration"},
        {name: "branchName"},
        {name: "countryId", title: "<spring:message code='country.nameFa'/>", type: 'long'},
        {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>"},
        {name: "contactAccounts"}
    ],
    fetchDataURL: "${contextPath}/api/contact/spec-list"
});

var RestDataSource_ContactBUYER_optionCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "buyer", operator: "equals", value: true}]
};
var RestDataSource_ContactAgentBuyer_optionCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "agentBuyer", operator: "equals", value: true}]
};
var RestDataSource_ContactAgentSeller_optionCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "agentSeller", operator: "equals", value: true}]
};
var RestDataSource_Contact_optionCriteria = {
    _constructor: "AdvancedCriteria",
    operator: "and",
    criteria: [{fieldName: "seller", operator: "equals", value: true}]
};

isc.defineClass("headerContractPage", isc.VStack).addProperties({
    autoDraw: false,
    width: "100%",
    height: "100%",
    membersMargin: 10,
    border: "1px solid #ECECEB", borderRadius: '5px',
    shadowDepth: 10,
    showShadow: true,
    parametrDataSourceDefinitions: null,
    //backgroundColor: "#e6e370",
    initWidget: function () {
        this.Super("initWidget", arguments);
        let This = this;

        isc.DynamicForm.create({
            ID: "dynamicForm_ContactHeader",
            wrapItemTitles: false,
            Width: "100%",
            titleWidth: "80",
            cellPadding: 2,
            numCols: 6,
            fields: [
                {name: "id", hidden: true},
                {name: "contractDate", hidden: true,},
                {
                    name: "createDate",
                    title: "<spring:message code='contact.date'/>",
                    type: "date",
                    format: 'DD-MM-YYYY',
                    required: true,
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }],
                    width: "90%",
                    wrapTitle: false
                },
                {
                    name: "material",
                    editorType: "SelectItem",
                    type: 'SelectItem',
                    autoFetchData: false,
                    optionDataSource: RestDataSource_Material,
                    displayField: "descEN",
                    valueField: "id",
                    required: true,
                    title: "Material"
                },
                {
                    name: "contractNo",
                    title: "<spring:message code='contact.no'/>",
                    requiredMessage: "<spring:message code='validator.field.is.required'/>",
                    required: true,
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }],
                    textAlign: "left",
                    readonly: true,
                    width: "90%",
                    wrapTitle: false
                }
            ]
        });
        this.addMember(dynamicForm_ContactHeader, 0);
        ///****************************
        var dynamicForm_ContactBuyer = isc.DynamicForm.create({
            width: "100%",
            numCols: 4,
            wrapItemTitles: false,
            fields: [
                {name: "id", canEdit: false, hidden: true},
                {
                    name: "contactId",
                    showHover: true,
                    required: true,
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }],
                    autoFetchData: false,
                    title: "<spring:message code='contact.commercialRole.buyer'/>",
                    width: "600",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Contact,
                    optionCriteria: RestDataSource_ContactBUYER_optionCriteria,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "600",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", width: "45%", align: "center"},
                        {name: "nameEN", width: "45%", align: "center"},
                        {name: "code", width: "10%", align: "center", hidden: true}
                    ],
                    changed: function (form, item, value) {
                        var address = "";
                        var name = "";
                        var phone = "";
                        var mobile = "";
                        if (item.getSelectedRecord().address != undefined) {
                            address = item.getSelectedRecord().address;
                            Contact_ContactBuyer.setValue("address_ContactBuyer", address);
                        }
                        if (item.getSelectedRecord().nameEN != undefined) {
                            name = item.getSelectedRecord().nameEN;
                            Contact_ContactBuyer.setValue("name_ContactBuyer", name);
                        }
                        if (item.getSelectedRecord().phone != undefined) {
                            phone = item.getSelectedRecord().phone;
                            Contact_ContactBuyer.setValue("phone_ContactBuyer", phone);
                        }
                        if (item.getSelectedRecord().mobile != undefined) {
                            mobile = item.getSelectedRecord().mobile;
                            Contact_ContactBuyer.setValue("phone_ContactBuyer", phone);
                        }
                    }
                },
                {
                    name: "contactByBuyerAgentId",
                    showHover: true,
                    autoFetchData: false,
                    title: "<spring:message code='contact.commercialRole.agentBuyer'/>",
                    width: "600",
                    required: false,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Contact,
                    optionCriteria: RestDataSource_ContactAgentBuyer_optionCriteria,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "600",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", width: "45%", align: "center"},
                        {name: "nameEN", width: "45%", align: "center"},
                        {name: "code", width: "10%", align: "center", hidden: true}
                    ],
                    changed: function (form, item, value) {
                        var address = "";
                        var name = "";
                        var phone = "";
                        var mobile = "";
                        if (item.getSelectedRecord().address != undefined) {
                            address = item.getSelectedRecord().address;
                            Contact_ContactAgentBuyer.setValue("address_ContactAgentBuyer", address);
                        }
                        if (item.getSelectedRecord().nameEN != undefined) {
                            name = item.getSelectedRecord().nameEN;
                            Contact_ContactAgentBuyer.setValue("name_ContactAgentBuyer", name);
                        }
                        if (item.getSelectedRecord().phone != undefined) {
                            phone = item.getSelectedRecord().phone;
                            Contact_ContactAgentBuyer.setValue("phone_ContactAgentBuyer", phone);
                        }
                        if (item.getSelectedRecord().mobile != undefined) {
                            mobile = item.getSelectedRecord().mobile;
                            Contact_ContactAgentBuyer.setValue("mobile_ContactAgentBuyer", mobile);
                        }
                    }
                }
            ]
        })
        this.addMember(isc.HLayout.create({height: "30", members: [dynamicForm_ContactBuyer]}), 1);

////////////////////////////
        let Contact_ContactBuyer = isc.DynamicForm.create({
            width: "50%",
            disabled: "true",
            wrapItemTitles: true,
            items: [
                {
                    name: "name_ContactBuyer",
                    type: "text",
                    length: 250,
                    showTitle: true,
                    colSpan: 2,
                    width: "*",
                    title: "NAME"
                }
                , {
                    name: "phone_ContactBuyer",
                    type: "text",
                    length: 100,
                    showTitle: true,
                    colSpan: 2,
                    title: "Phone",
                    width: "*"
                }, {
                    name: "mobile_ContactBuyer",
                    type: "text",
                    length: 100,
                    showTitle: true,
                    colSpan: 2,
                    title: "Mobile",
                    width: "*"
                },
                {
                    name: "address_ContactBuyer",
                    type: "text",
                    length: 5000,
                    showTitle: true,
                    colSpan: 2,
                    title: "Address",
                    width: "*"
                }
            ]
        })
        let Contact_ContactAgentBuyer = isc.DynamicForm.create({
            width: "50%",
            disabled: "true",
            wrapItemTitles: true,
            items: [
                {
                    name: "name_ContactAgentBuyer",
                    type: "text",
                    length: 250,
                    showTitle: true,
                    colSpan: 2,
                    width: "*",
                    title: "NAME"
                }
                , {
                    name: "phone_ContactAgentBuyer",
                    type: "text",
                    length: 100,
                    showTitle: true,
                    colSpan: 2,
                    title: "Phone",
                    width: "*"
                }, {
                    name: "mobile_ContactAgentBuyer",
                    type: "text",
                    length: 100,
                    showTitle: true,
                    colSpan: 2,
                    title: "Mobile",
                    width: "*"
                },
                {
                    name: "address_ContactAgentBuyer",
                    type: "text",
                    length: 5000,
                    showTitle: true,
                    colSpan: 2,
                    title: "Address",
                    width: "*"
                }
            ]
        })
        this.addMember(isc.HLayout.create({
            width: "100%",
            members: [Contact_ContactBuyer, Contact_ContactAgentBuyer]
        }), 2);
/////////////
        var DynamicForm_ContactSeller = isc.DynamicForm.create({
            width: "100%",
            numCols: 4,
            fields: [
                {name: "id", canEdit: false, hidden: true},
                {
                    name: "contactBySellerId",
                    numCols: 2,
                    showHover: true,
                    autoFetchData: false,
                    title: "<spring:message code='contact.commercialRole.seller'/>",
                    width: "600",
                    required: true,
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }],
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Contact,
                    optionCriteria: RestDataSource_Contact_optionCriteria,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "600",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", width: "45%", align: "center"},
                        {name: "nameEN", width: "45%", align: "center"},
                        {name: "code", width: "10%", align: "center", hidden: true}
                    ],
                    changed: function (form, item, value) {
                        var address = "";
                        var name = "";
                        var phone = "";
                        var mobile = "";
                        if (item.getSelectedRecord().address != undefined) {
                            address = item.getSelectedRecord().address;
                            Contact_ContactSeller.setValue("address_ContactSeller", address);
                        }
                        if (item.getSelectedRecord().nameEN != undefined) {
                            name = item.getSelectedRecord().nameEN;
                            Contact_ContactSeller.setValue("name_ContactSeller", name);
                        }
                        if (item.getSelectedRecord().phone != undefined) {
                            phone = item.getSelectedRecord().phone;
                            Contact_ContactSeller.setValue("phone_ContactSeller", phone);
                        }
                        if (item.getSelectedRecord().mobile != undefined) {
                            mobile = item.getSelectedRecord().mobile;
                            Contact_ContactSeller.setValue("mobile_ContactSeller", mobile);
                        }
                    }
                },
                {
                    name: "contactBySellerAgentId",
                    numCols: 2,
                    showHover: true,
                    autoFetchData: false,
                    title: "<spring:message code='contact.commercialRole.agentSeller'/>",
                    width: "600",
                    required: false,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Contact,
                    optionCriteria: RestDataSource_ContactAgentSeller_optionCriteria,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "600",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", width: "45%", align: "center"},
                        {name: "nameEN", width: "45%", align: "center"},
                        {name: "code", width: "10%", align: "center", hidden: true}
                    ],
                    changed: function (form, item, value) {
                        var address = "";
                        var name = "";
                        var phone = "";
                        var mobile = "";
                        if (item.getSelectedRecord().address != undefined) {
                            address = item.getSelectedRecord().address;
                            Contact_ContactAgentSeller.setValue("address_ContactAgentSeller", address);
                        }
                        if (item.getSelectedRecord().nameEN != undefined) {
                            name = item.getSelectedRecord().nameEN;
                            Contact_ContactAgentSeller.setValue("name_ContactAgentSeller", name);
                        }
                        if (item.getSelectedRecord().phone != undefined) {
                            phone = item.getSelectedRecord().phone;
                            Contact_ContactAgentSeller.setValue("phone_ContactAgentSeller", phone);
                        }
                        if (item.getSelectedRecord().mobile != undefined) {
                            mobile = item.getSelectedRecord().mobile;
                            Contact_ContactAgentSeller.setValue("mobile_ContactAgentSeller", mobile);
                        }
                    }
                }
            ]
        });
        this.addMember(isc.HLayout.create({height: "30", align: "top", members: [DynamicForm_ContactSeller]}), 3);


        var Contact_ContactSeller = isc.DynamicForm.create({
            width: "50%",
            disabled: "true",
            wrapItemTitles: true,
            items: [
                {
                    name: "name_ContactSeller",
                    type: "text",
                    length: 250,
                    showTitle: true,
                    colSpan: 2,
                    width: "*",
                    title: "NAME"
                }
                , {
                    name: "phone_ContactSeller",
                    type: "text",
                    length: 100,
                    showTitle: true,
                    colSpan: 2,
                    title: "Phone",
                    width: "*"
                }, {
                    name: "mobile_ContactSeller",
                    type: "text",
                    length: 100,
                    showTitle: true,
                    colSpan: 2,
                    title: "Mobile",
                    width: "*"
                },
                {
                    name: "address_ContactSeller",
                    type: "text",
                    length: 5000,
                    showTitle: true,
                    colSpan: 2,
                    title: "Address",
                    width: "*"
                }
            ]
        })
        var Contact_ContactAgentSeller = isc.DynamicForm.create({
            width: "50%",
            disabled: "true",
            wrapItemTitles: true,
            items: [
                {
                    name: "name_ContactAgentSeller",
                    type: "text",
                    length: 250,
                    showTitle: true,
                    colSpan: 2,
                    width: "*",
                    title: "NAME"
                }
                , {
                    name: "phone_ContactAgentSeller",
                    type: "text",
                    length: 100,
                    showTitle: true,
                    colSpan: 2,
                    title: "Phone",
                    width: "*"
                }, {
                    name: "mobile_ContactAgentSeller",
                    type: "text",
                    length: 100,
                    showTitle: true,
                    colSpan: 2,
                    title: "Mobile",
                    width: "*"
                },
                {
                    name: "address_ContactAgentSeller",
                    type: "text",
                    length: 5000,
                    showTitle: true,
                    colSpan: 2,
                    title: "Address",
                    width: "*"
                }
            ]
        });
        this.addMember(isc.HLayout.create({
            width: "100%",
            members: [Contact_ContactSeller, Contact_ContactAgentSeller]
        }), 4);

        let buttonAddItem = isc.IButton.create({
            title: "Add Item Definitions",
            width: 150,
            icon: "[SKIN]/actions/add.png",
            iconOrientation: "right",
            click: "listGrid_ContractItemDefinitions.startEditingNew()"
        });

        isc.ListGrid.create({
            ID: "listGrid_ContractItemDefinitions",
            showFilterEditor: false,
            width: "100%",
            height: 180,
            overflow: "auto",
            modalEditing: true,
            canEdit: true,
            canRemoveRecords: true,
            autoFetchData: false,
            autoSaveEdits: true,
            dataSource: RestDataSource_Parameters,
            fields:
                [
                    {
                        name: "id",
                        title: "id",
                        primaryKey: true,
                        canEdit: false,
                        hidden: true
                    },
                    {
                        name: "categoryValue",
                        title: "<spring:message	code='parameters.paramValue.d'/>",
                        width: "15%",
                        type: "text",
                        required: true,
                        valueMap: {
                            "1": "Unit",
                            "2": "Time",
                            "3": "Financial",
                            "-2": "BANK REFERENCE"
                        }
                    },
                    {
                        name: "paramName",
                        title: "<spring:message code='parameters.paramName'/>",
                        width: "20%",
                        align: "center"
                    },
                    {
                        name: "paramValue",
                        title: "<spring:message code='parameters.paramValue.c'/>",
                        width: "50%",
                        align: "center"
                    }, {
                    name: "contractId",
                    title: "<spring:message	code='parameters.paramValue'/>",
                    width: "15%",
                    showIf: "false",
                    type: "select",
                    required: true,
                    valueMap: {"1": "MOLYBDENUM OXIDE", "3": "COPPER CONCENTRATES", "2": "COPPER CATHODES"}
                }
                ]
        })

        this.addMember(buttonAddItem, 5);
        this.addMember(listGrid_ContractItemDefinitions, 6);

        buttonAllHeaderSave = isc.IButtonSave.create({
            click: function () {
            }
        });
        buttonAllHeaderCancel = isc.IButtonCancel.create({
            title: "<spring:message code='global.form.save'/>",
            click: function () {
            }
        });

        this.addMember(isc.HLayout.create({
            align: "center",
            width: "100%",
            members: [buttonAllHeaderSave, isc.LayoutSpacer.create({width: 20}), buttonAllHeaderCancel]
        }), 7);

    }
});


isc.headerContractPage.create({})