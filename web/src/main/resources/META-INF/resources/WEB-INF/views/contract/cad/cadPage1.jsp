<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>

    factoryLableHedear("LablePageCad", '<font color="#ffffff"><b>NATIONAL IRANIAN COPPER INDUSTRIES CO.<b></font>', "100%", "10", 5);
    factoryLable("lableNameContactCad", '<b><font size=4px>COPPER CATHODES CONTRACT-GIAG/NICICO</font><b>', "100%", '2%', 1);
    factoryLableArticle("lableArticle1Cad", '<b><font size=4px>ARTICLE 1 - DEFINITIONS:</font><b>', "30", 5)
    factoryLableArticle("lableArticle2Cad", '<b><font size=4px>ARTICLE 2 -QUANTITY :</font><b>', "30",5);
    factoryLableArticle("lableArticleSelectConc", '<b><font size=4px>SELECT ITEMS</font><b>', "25",5);

    var dynamicForm1Cad = isc.HLayout.create({align: "center", members: []});
    var dynamicForm2Cad = isc.HLayout.create({align: "center", members: []});
    var dynamicForm3Cad = isc.HLayout.create({align: "center", members: []});
    var dynamicForm4Cad = isc.HLayout.create({align: "center", members: []});

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
                name: "createDate",
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
    dynamicForm1Cad.addMember("Contact_ContactCadBuyer", 1);
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
    dynamicForm2Cad.addMember("Contact_ContactCadAgentBuyer", 2);
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
    dynamicForm3Cad.addMember("Contact_ContactCadSeller", 3);
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
    })
    dynamicForm4Cad.addMember("Contact_ContactAgentSellerCad", 4);

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
                title: "<spring:message code='contact.commercialRole.buyer'/>",
                width: "600",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "600",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center", hidden: true}
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
                width:"600",
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "600",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center", hidden: true}
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
                title: "<spring:message code='contact.commercialRole.seller'/>",
                width: "600",
                required: true,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "600",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center", hidden: true}
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
                title: "<spring:message code='contact.commercialRole.agentSeller'/>",
                width: "600",
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "600",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center", hidden: true}
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

var DynamicForm_ContactParameter_ValueNumber8Cad=isc.DynamicForm.create({
        valuesManager: "valuesManagerCadArticle1",
        height: "20",
        width: "100%",
        wrapItemTitles: true,
        numCols: 4,
        items: [
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
                    {name: "paramName", title: "<spring:message code='parameters.paramName'/>", width: "20%", align: "center"},
                    {name: "paramType", title: "<spring:message code='parameters.paramType'/>", width: "20%", align: "center"},
                    {name: "paramValue", title: "<spring:message code='parameters.paramValue'/>", width: "60%", align: "center"}
                ],
                pickListCriteria: {
                    _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                        {fieldName: "contractId", operator: "equals", value: 3},
                        {fieldName: "categoryValue", operator: "equals", value: 1}]
                },
                width: "1200",
                height: "30",
                title: "NAME",
                changed: function (form, item, value) {
                    DynamicForm_ContactParameter_ValueNumber8Cad.setValue("definitionsOne", item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue);
                    dynamicFormCad_fullArticle01.setValue("fullArticle01",dynamicFormCad_fullArticle01.getValue("fullArticle01")+"\n"+"-"+DynamicForm_ContactParameter_ValueNumber8Cad.getValue("definitionsOne"))
                    DynamicForm_ContactParameter_ValueNumber8Cad.clearValue("definitionsOne");
                    }
            }
        ]
    })


var VLayout_ContactParameter_ValueNumber8Cad = isc.VLayout.create({
        width: "100%",
        height: "1",
        members: [DynamicForm_ContactParameter_ValueNumber8Cad]
    })

var dynamicFormCad_fullArticle01 = isc.DynamicForm.create({
        valuesManager: "valuesManagerfullArticle",
        height: "50",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle01",
                disabled: false,
                type: "text",
                length: 6000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "",
                title: "fullArticle01",
                width: "*",changed: function (form, item, value) {
                    if(value==undefined)
                      dynamicFormCad_fullArticle01.setValue("fullArticle01","")
                    else
                      dynamicFormCad_fullArticle01.setValue("fullArticle01",value)
                    }
            }
        ]
    })

var vlayoutBodyCad = isc.VLayout.create({
        width: "100%",
        height: "5",
        styleName: "cad-page1-form",
        members: [
            isc.HLayout.create({align: "top", members: [dynamicForm_ContactCadHeader]}),
            isc.HLayout.create({height: "50", align: "left", members: [lableNameContactCad]}),
            isc.HLayout.create({height: "50", align: "left", members: [
                isc.DynamicForm.create({ID:"dynamicFormCath",items:[{type: "text",name:"materialId",
                    title: "PLEASE SELECT MATERIAL",align: "left",selectOnFocus: true,wrapTitle: false,required: true,
                    width: "400",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Material,
                    displayField: "descl",
                    valueField: "id",
                    pickListWidth: "400",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "descl", title: "<spring:message code="material.descl"/>", width: "395", align: "center"}
                    ],
                    pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "descl", operator: "contains", value: "Cath"}]
                    },
                    }]})
            ]}),
            isc.HLayout.create({align: "top", members: [dynamicForm_ContactCadCustomer]}),
            isc.HLayout.create({ID: "dynamicForm1And2Cad", align: "center", members: [dynamicForm1Cad, dynamicForm2Cad]}),
            isc.HLayout.create({align: "center", members: [DynamicForm_ContactSeller]}),
            isc.HLayout.create({ID: "dynamicForm3And4Cad", align: "center", members: [dynamicForm3Cad, dynamicForm4Cad]})
        ]
    });

 var article2Cad = isc.DynamicForm.create({
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
                keyPressFilter: "[0-9.]", ///article2_number10
                changed: function (form, item, value) {
                    article2Cad.setValue("amount_en", numberToEnglish(value))
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
                width: "250",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "250",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 245, align: "center"}
                ],changed: function (form, item, value) {
                }
            },
            {
                type: "text",
                width: "80",
                name: "cathodesTolorance",
                title: "+/-",
                defaultValue: "2",
                keyPressFilter: "[0-9.]", //article2_13
                changed: function (form, item, value) {
                }
            },
            {
                type: "text",
                width: "250",
                name: "optional", //article2_14
                startRow: false,
                title: '<b><font size=2px>(IN</font><b>',
                defaultValue: 0,
                valueMap: {
                    "0": "",
                    "1": "SELLERS OPTION",
                    "2": "BUYER OPTION"
                },
                changed: function (form, item, value) {
                    article5_quality.setValue("article5optional",value);
                    valuesManagerfullArticle.setValue("fullArticle02",article2Cad.getValue("amount")+" "+article2Cad.getValue("amount_en")+" "+article2Cad.getItem("unitId").getDisplayValue(article2Cad.getValue("unitId"))+" "+article2Cad.getValue("cathodesTolorance")+" "+article2Cad.getItem("optional").getDisplayValue(article2Cad.getValue("optional")));
                }
            }
        ]
    });
var dynamicForm_fullArticle02Cad = isc.DynamicForm.create({
        valuesManager: "valuesManagerfullArticle",
        height: "50",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle02",
                disabled: false,
                type: "text",
                length: 6000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "",
                title: "fullArticle02",
                width: "*"
            }
        ]
    })

isc.VLayout.create({
        ID: "VLayout_PageOne_ContractCathod",
        width: "100%",
        height: "100%",
        align: "top",
        overflow: "scroll",
        members: [
            LablePageCad,
            vlayoutBodyCad,
            lableArticle1Cad,
            isc.HLayout.create({align: "left", members: [lableArticleSelectConc,VLayout_ContactParameter_ValueNumber8Cad]}),
            dynamicFormCad_fullArticle01,
            lableArticle2Cad,
            isc.HLayout.create({align: "left", members: [article2Cad]}),
            dynamicForm_fullArticle02Cad
        ]
    });
