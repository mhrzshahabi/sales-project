<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>

    var itemsDefinitionsCount = 0;
    var optionSet;
    factoryLableHedear("LablePage", '<font color="#ffffff"><b>NATIONAL IRANIAN COPPER INDUSTRIES CO.<b></font>', "100%", "10", 5);
    factoryLable("lableNameContact", '<b><font size=4px>COPPER CATHODES CONTRACT-GIAG/NICICO</font><b>', "100%", '2%', 1);
    factoryLableArticle("lableArticle1", '<b><font size=4px>ARTICLE 1 - DEFINITIONS:</font><b>', "30", 5)
    factoryLableArticle("lableArticle2", '<b><font size=4px>ARTICLE 2 -QUANTITY :</font><b>', "30",5);

    var dynamicForm1 = isc.HLayout.create({align: "center", members: []});
    var dynamicForm2 = isc.HLayout.create({align: "center", members: []});
    var dynamicForm3 = isc.HLayout.create({align: "center", members: []});
    var dynamicForm4 = isc.HLayout.create({align: "center", members: []});

    var dynamicForm_ContactCadHeader = isc.DynamicForm.create({
        valuesManager: "contactCadHeader",
        wrapItemTitles: false,
        setMethod: 'POST',
        width: "100%",
        height: "100%",
        align: "left",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "80",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        cellPadding: 2,
        numCols: 4,
        fields: [
            {name: "id", hidden: true},
            {name: "contractDate", hidden: true,},
            {
                name: "createDateDumy",
                title: "<spring:message code='contact.date'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: "date",
                format: 'DD-MM-YYYY',
                required: true,
                width: "90%",
                wrapTitle: false
            },
            {
                name: "contractNo",
                title: "<spring:message code='contact.no'/>",
                requiredMessage: "<spring:message code='validator.field.is.required'/>",
                required: true,
                readonly: true,
                width: "90%",
                wrapTitle: false
            }
        ]
    });

    var Contact_ContactCadBuyer = isc.DynamicForm.create({
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
    dynamicForm1.addMember("Contact_ContactCadBuyer", 1);
    var Contact_ContactCadAgentBuyer = isc.DynamicForm.create({
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
    dynamicForm2.addMember("Contact_ContactCadAgentBuyer", 2);
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
    dynamicForm3.addMember("Contact_ContactCadSeller", 3);
    var Contact_ContactAgentSeller = isc.DynamicForm.create({
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
    })
    dynamicForm4.addMember("Contact_ContactAgentSeller", 4);

    var dynamicForm_ContactCadCustomer = isc.DynamicForm.create({
        setMethod: 'POST',
        valuesManager: "contactCadHeader",
        width: "100%",
        height: "100%",
        numCols: 4,
        wrapItemTitles: false,
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        fields: [
            {name: "id", canEdit: false, hidden: true},
            {
                name: "contactId",
                showHover: true,
                required: true,
                autoFetchData: false,
                title: "<spring:message code='contact.name'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "700",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center"}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "buyer", operator: "equals", value: true}]
                    },
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
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "700",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center"}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "agentBuyer", operator: "equals", value: true}]
                    },
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
    });

    var DynamicForm_ContactSeller = isc.DynamicForm.create({
        valuesManager: "contactCadHeader",
        width: "100%",
        height: "100%",
        numCols: 4,
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        wrapItemTitles: false,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        fields: [
            {name: "id", canEdit: false, hidden: true},
            {
                name: "contactBySellerId",
                numCols: 2,
                showHover: true,
                autoFetchData: false,
                title: "Seller",
                required: true,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "700",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center"}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "seller", operator: "equals", value: true}]
                    },
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
                title: "Agent Seller",
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "700",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center"}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "agentSeller", operator: "equals", value: true}]
                    },
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

    isc.DynamicForm.create({
        ID: "DynamicForm_ContactParameter_ValueNumber8",
        valuesManager: "valuesManagerArticle1",
        height: "20",
        width: "100%",
        wrapItemTitles: true,
        items: [
            {name: "feild_all_defintitons_save", showIf: "false"},
            {
                name: "definitionsOne",
                length: 5000,
                startRow: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                displayField: "paramValue",
                valueField: "paramValue",
                showTitle: false,
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "paramName", width: "20%", align: "center"},
                    {name: "paramType", width: "20%", align: "center"},
                    {name: "paramValue", width: "60%", align: "center"}
                ],
                pickListCriteria: {
                    _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                        {fieldName: "contractId", operator: "equals", value: 1},
                        {fieldName: "categoryValue", operator: "equals", value: 1}]
                },
                width: "1500",
                height: "30",
                title: "NAME",
                changed: function (form, item, value) {
                    DynamicForm_ContactParameter_ValueNumber8.setValue("definitionsOne", item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue)
                }
            }, {
                name: "button",
                type: "button",
                width: "10%",
                height: "30",
                title: "Remove",
                startRow: false,
                icon: "[SKIN]/actions/remove.png",
                click: function () {
                    DynamicForm_ContactParameter_ValueNumber8.removeField("definitionsOne");
                    DynamicForm_ContactParameter_ValueNumber8.removeField("button")
                    var dataSaveValueNumber8=DynamicForm_ContactParameter_ValueNumber8.getValues();
                    delete dataSaveValueNumber8.feild_all_defintitons_save;
                    delete dataSaveValueNumber8["definitionsOne"]
                    DynamicForm_ContactParameter_ValueNumber8.setValue("feild_all_defintitons_save", JSON.stringify(dataSaveValueNumber8));
                    console.log(DynamicForm_ContactParameter_ValueNumber8.getValue("feild_all_defintitons_save"));
                }
            }
        ]
    })

    HLayout_button_ValueNumber8 = isc.HLayout.create({
        members: [
            isc.Label.create({
                styleName: "buttonHtml buttonHtml1",
                align: "center",
                valign: "center",
                wrap: false,
                contents: "Add",
                click: function () {
                    itemsDefinitions('Add', itemsDefinitionsCount)
                }
            }),
            isc.Label.create({
                styleName: "buttonHtml buttonHtml3",
                align: "center",
                valign: "center",
                wrap: false,
                contents: "Remove",
                click: function () {
                    //to do abouzar
                    itemsDefinitions('Remove', itemsDefinitionsCount)
                }
            })
        ]
    })

var VLayout_ContactParameter_ValueNumber8 = isc.VLayout.create({
        width: "100%",
        height: "1",
        members: [DynamicForm_ContactParameter_ValueNumber8,HLayout_button_ValueNumber8]
    })

var vlayoutBody = isc.VLayout.create({
        width: "100%",
        height: "5",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({align: "top", members: [dynamicForm_ContactCadHeader]}),
            isc.HLayout.create({height: "50", align: "left", members: [lableNameContact]}),
            isc.HLayout.create({align: "top", members: [dynamicForm_ContactCadCustomer]}),
            isc.HLayout.create({ID: "dynamicForm1And2", align: "center", members: [dynamicForm1, dynamicForm2]}),
            isc.HLayout.create({align: "center", members: [DynamicForm_ContactSeller]}),
            isc.HLayout.create({ID: "dynamicForm3And4", align: "center", members: [dynamicForm3, dynamicForm4]})
        ]
    });

 var article2 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle2Cad",
        height: "50%",
        numCols: 14,
        wrapItemTitles: false,
        items: [
            {
                type: "number",
                width: "80",
                name: "amount",
                defaultValue: "",
                title: "",
                showTitle: false,
                keyPressFilter: "[0-9]", ///article2_number10
                changed: function (form, item, value) {
                    article2.setValue("amount_en", numberToEnglish(value))
                    }
            },
            {
                type: "text", styleName: "textToLable", width: "200",
                name: "amount_en", title: "", showTitle: false, disabled: "true"
            }, ///english,
            {
                name: "unitId", //article2_number12
                title: "",
                type: 'long',
                width: "150",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 440, align: "center"}
                ],changed: function (form, item, value) {
                }
            },
            {
                type: "text",
                width: "80",
                name: "cathodesTolorance",
                title: "+/-",
                defaultValue: "2",
                keyPressFilter: "[0-9]", //article2_13
                changed: function (form, item, value) {
                }
            },
            {
                type: "text",
                width: "250",
                name: "optional", //article2_14
                startRow: false,
                title: '<b><font size=2px>(IN</font><b>',
                defaultValue: 1,
                valueMap: {
                    "1": "SELLERS OPTION",
                    "2": "BUYER OPTION"
                },
                changed: function (form, item, value) {
                    article5_quality.setValue("article5optional",value);
                }
            }
        ]
    });


isc.VLayout.create({
        ID: "VLayout_PageOne_Contract",
        width: "100%",
        height: "100%",
        align: "top",
        overflow: "scroll",
        members: [
            LablePage,
            vlayoutBody,
            lableArticle1,
            VLayout_ContactParameter_ValueNumber8,
            lableArticle2,
            isc.HLayout.create({align: "left", members: [article2]})
        ]
    });

function itemsDefinitions(value, id) {
        if (value == 'Add') {
            DynamicForm_ContactParameter_ValueNumber8.addFields([
                {
                    name: "valueNumber8" + id,
                    type: "text",
                    length: 5000,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Parameters,
                    displayField: "paramValue",
                    valueField: "paramValue",
                    showTitle: false,
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "paramName", width: "25%", align: "center"},
                        {name: "paramType", width: "25%", align: "center"},
                        {name: "paramValue", width: "50%", align: "center"}
                    ],
                    pickListCriteria: {
                        _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                            {fieldName: "contractId", operator: "equals", value: 1},
                            {fieldName: "categoryValue", operator: "equals", value: 1}]
                    },
                    showTitle: false,
                    startRow: false,
                    width: "1500",
                    height: "30",
                    title: "NAME",
                    changed: function (form, item, value) {
                        DynamicForm_ContactParameter_ValueNumber8.setValue("valueNumber8" + id, (item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue))
                    }
                }, {
                    name: "button" + id,
                    type: "button",
                    width: "10%",
                    height: "30",
                    title: "Remove",
                    startRow: false,
                    icon: "[SKIN]/actions/remove.png",
                    click: function () {
                        DynamicForm_ContactParameter_ValueNumber8.removeField("valueNumber8" + id);
                        DynamicForm_ContactParameter_ValueNumber8.removeField("button" + id)
                        var dataSaveValueNumber8=DynamicForm_ContactParameter_ValueNumber8.getValues();
                        delete dataSaveValueNumber8.feild_all_defintitons_save;
                        delete dataSaveValueNumber8["valueNumber8" + id]
                        DynamicForm_ContactParameter_ValueNumber8.setValue("feild_all_defintitons_save", JSON.stringify(dataSaveValueNumber8));
                    }
                }
            ]);
            itemsDefinitionsCount++;
        } else {
            --itemsDefinitionsCount;
            DynamicForm_ContactParameter_ValueNumber8.removeField("valueNumber8" + itemsDefinitionsCount);
            DynamicForm_ContactParameter_ValueNumber8.removeField("button" + itemsDefinitionsCount);
        }
    }