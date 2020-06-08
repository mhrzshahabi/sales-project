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

////********************************************************************************************
isc.defineClass("ContactCadComponent", isc.VStack).addProperties({
    width: "100%",
    height: "100%",
    border: "0px solid blue",
    initWidget: function () {
        this.Super("initWidget", arguments);

        var dynamicForm_ContactCadCustomer = isc.DynamicForm.create({
            valuesManager: "contactCadHeader",
            width: "100%",
            height: "100%",
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
                            Contact_ContactCadBuyer.setValue("address_ContactBuyer", address);
                        }
                        if (item.getSelectedRecord().nameEN != undefined) {
                            name = item.getSelectedRecord().nameEN;
                            Contact_ContactCadBuyer.setValue("name_ContactBuyer", name);
                        }
                        if (item.getSelectedRecord().phone != undefined) {
                            phone = item.getSelectedRecord().phone;
                            Contact_ContactCadBuyer.setValue("phone_ContactBuyer", phone);
                        }
                        if (item.getSelectedRecord().mobile != undefined) {
                            mobile = item.getSelectedRecord().mobile;
                            Contact_ContactCadBuyer.setValue("phone_ContactBuyer", phone);
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
                            Contact_ContactCadAgentBuyer.setValue("address_ContactAgentBuyer", address);
                        }
                        if (item.getSelectedRecord().nameEN != undefined) {
                            name = item.getSelectedRecord().nameEN;
                            Contact_ContactCadAgentBuyer.setValue("name_ContactAgentBuyer", name);
                        }
                        if (item.getSelectedRecord().phone != undefined) {
                            phone = item.getSelectedRecord().phone;
                            Contact_ContactCadAgentBuyer.setValue("phone_ContactAgentBuyer", phone);
                        }
                        if (item.getSelectedRecord().mobile != undefined) {
                            mobile = item.getSelectedRecord().mobile;
                            Contact_ContactCadAgentBuyer.setValue("mobile_ContactAgentBuyer", mobile);
                        }
                    }
                }
            ]
        })
        this.addMember(isc.HLayout.create({height: "30", members: [dynamicForm_ContactCadCustomer]}), 0);

////////////////////////////
        let Contact_ContactCadBuyer = isc.DynamicForm.create({
            valuesManager: "contactCadHeaderCadAgent",
            height: "20",
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
        let Contact_ContactCadAgentBuyer = isc.DynamicForm.create({
            valuesManager: "contactCadHeaderCadAgent",
            height: "20",
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
            members: [Contact_ContactCadBuyer, Contact_ContactCadAgentBuyer]
        }), 1);
/////////////
        var DynamicForm_ContactSeller = isc.DynamicForm.create({
            valuesManager: "contactCadHeader",
            width: "100%",
            height: "100%",
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
                            Contact_ContactCadSeller.setValue("address_ContactSeller", address);
                        }
                        if (item.getSelectedRecord().nameEN != undefined) {
                            name = item.getSelectedRecord().nameEN;
                            Contact_ContactCadSeller.setValue("name_ContactSeller", name);
                        }
                        if (item.getSelectedRecord().phone != undefined) {
                            phone = item.getSelectedRecord().phone;
                            Contact_ContactCadSeller.setValue("phone_ContactSeller", phone);
                        }
                        if (item.getSelectedRecord().mobile != undefined) {
                            mobile = item.getSelectedRecord().mobile;
                            Contact_ContactCadSeller.setValue("mobile_ContactSeller", mobile);
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
                            Contact_ContactAgentSellerCad.setValue("address_ContactAgentSeller", address);
                        }
                        if (item.getSelectedRecord().nameEN != undefined) {
                            name = item.getSelectedRecord().nameEN;
                            Contact_ContactAgentSellerCad.setValue("name_ContactAgentSeller", name);
                        }
                        if (item.getSelectedRecord().phone != undefined) {
                            phone = item.getSelectedRecord().phone;
                            Contact_ContactAgentSellerCad.setValue("phone_ContactAgentSeller", phone);
                        }
                        if (item.getSelectedRecord().mobile != undefined) {
                            mobile = item.getSelectedRecord().mobile;
                            Contact_ContactAgentSellerCad.setValue("mobile_ContactAgentSeller", mobile);
                        }
                    }
                }
            ]
        });
        this.addMember(isc.HLayout.create({height: "30", align: "top", members: [DynamicForm_ContactSeller]}), 2);


        var Contact_ContactCadSeller = isc.DynamicForm.create({
            valuesManager: "contactCadHeaderCadAgent",
            height: "20",
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
        var Contact_ContactAgentSellerCad = isc.DynamicForm.create({
            valuesManager: "contactCadHeaderCadAgent",
            height: "20",
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
            members: [Contact_ContactCadSeller, Contact_ContactAgentSellerCad]
        }), 3);
    }
});