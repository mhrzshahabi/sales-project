<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    factoryLableHedear("LablePageConc", '<font><b>NATIONAL IRANIAN COPPER INDUSTRIES CO.<b></font>', "100%", "10", 5);
    factoryLable("lableNameContactConc", '<b><font size=4px>COPPER CONCENTRATE CONTRACT-GIAG/NICICO</font><b>', "100%", '2%', 1);
    factoryLableArticle("lableArticle1Conc", '<b><font size=4px>ARTICLE 1 - DEFINITIONS:</font><b>', "30", 5)
    factoryLableArticle("lableArticle2Conc", '<b><font size=4px>ARTICLE 2 -QUANTITY :</font><b>', "30",5);
    factoryLableArticle("lableArticleSelect", '<b><font size=4px>SELECT ITEMS</font><b>', "25",5);

    var dynamicForm1Conc = isc.HLayout.create({align: "center", members: []});
    var dynamicForm2Conc = isc.HLayout.create({align: "center", members: []});
    var dynamicForm3Conc = isc.HLayout.create({align: "center", members: []});
    var dynamicForm4Conc = isc.HLayout.create({align: "center", members: []});

    var dynamicForm_ContactConcHeader = isc.DynamicForm.create({
        valuesManager: "contactHeaderConc",
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
                type: "date",
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

    var Contact_ContactConcBuyer = isc.DynamicForm.create({
        valuesManager: "contactHeaderConcAgent",
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
    dynamicForm1Conc.addMember("Contact_ContactConcBuyer", 1);
    var Contact_ContactCadAgentBuyer = isc.DynamicForm.create({
        valuesManager: "contactHeaderConcAgent",
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
    dynamicForm2Conc.addMember("Contact_ContactCadAgentBuyer", 2);
    var Contact_ContactCadSeller = isc.DynamicForm.create({
        valuesManager: "contactHeaderConcAgent",
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
    dynamicForm3Conc.addMember("Contact_ContactCadSeller", 3);
    var Contact_ContactAgentSellerConc = isc.DynamicForm.create({
        valuesManager: "contactHeaderConcAgent",
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
    dynamicForm4Conc.addMember("Contact_ContactAgentSellerConc", 4);

    var dynamicForm_ContactConcCustomer = isc.DynamicForm.create({
        valuesManager: "contactHeaderConc",
        setMethod: 'POST',
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
                        Contact_ContactConcBuyer.setValue("address_ContactBuyer", address);
                    }
                    if (item.getSelectedRecord().nameEN != undefined) {
                        name = item.getSelectedRecord().nameEN;
                        Contact_ContactConcBuyer.setValue("name_ContactBuyer", name);
                    }
                    if (item.getSelectedRecord().phone != undefined) {
                        phone = item.getSelectedRecord().phone;
                        Contact_ContactConcBuyer.setValue("phone_ContactBuyer", phone);
                    }
                    if (item.getSelectedRecord().mobile != undefined) {
                        mobile = item.getSelectedRecord().mobile;
                        Contact_ContactConcBuyer.setValue("phone_ContactBuyer", phone);
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
    });

    var DynamicForm_ContactConcSeller = isc.DynamicForm.create({
        valuesManager: "contactHeaderConc",
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
                        Contact_ContactAgentSellerConc.setValue("address_ContactAgentSeller", address);
                    }
                    if (item.getSelectedRecord().nameEN != undefined) {
                        name = item.getSelectedRecord().nameEN;
                        Contact_ContactAgentSellerConc.setValue("name_ContactAgentSeller", name);
                    }
                    if (item.getSelectedRecord().phone != undefined) {
                        phone = item.getSelectedRecord().phone;
                        Contact_ContactAgentSellerConc.setValue("phone_ContactAgentSeller", phone);
                    }
                    if (item.getSelectedRecord().mobile != undefined) {
                        mobile = item.getSelectedRecord().mobile;
                        Contact_ContactAgentSellerConc.setValue("mobile_ContactAgentSeller", mobile);
                    }
                }
            }
        ]
    });

isc.DynamicForm.create({
        ID: "DynamicForm_ContactParameter_ValueNumber8Conc",
        valuesManager: "valuesManagerConcArticle1",
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
                        {fieldName: "contractId", operator: "equals", value: 2},
                        {fieldName: "categoryValue", operator: "equals", value: 1}]
                },
                width: "1200",
                height: "30",
                title: "NAME",
                changed: function (form, item, value) {
                    DynamicForm_ContactParameter_ValueNumber8Conc.setValue("definitionsOne", item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue);
                    dynamicForm_fullArticle01.setValue(dynamicForm_fullArticle01.getValue()+"\n"+"-"+DynamicForm_ContactParameter_ValueNumber8Conc.getValue("definitionsOne"))
                    DynamicForm_ContactParameter_ValueNumber8Conc.clearValue("definitionsOne");
                    }
            }
        ]
    })


var VLayout_ContactParameter_ValueNumber8Conc = isc.VLayout.create({
        width: "100%",
        height: "1",
        members: [DynamicForm_ContactParameter_ValueNumber8Conc]
    })




var dynamicForm_fullArticle01 =  isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:"",changed: function (form, item, value) {
                    if(value==undefined)
                      dynamicForm_fullArticle01.setValue("")
                    else
                      dynamicForm_fullArticle01.setValue(dynamicForm_fullArticle01.getValue())
                    }
            })


var vlayoutBodyConc = isc.VLayout.create({
        width: "100%",
        height: "5",
        styleName: "conc-page1-form",
        members: [
            isc.HLayout.create({align: "top", members: [dynamicForm_ContactConcHeader]}),
            isc.HLayout.create({height: "50", align: "left", members: [lableNameContactConc]}),
            isc.HLayout.create({height: "50", align: "left", members: [
                isc.DynamicForm.create({ID:"dynamicFormConc",items:[{type: "text",name:"materialId",
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
                    {name: "descl", title: "<spring:message code="material.descl"/>", width: "395", align: "center" }
                    ],
                    pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "descl", operator: "contains", value: "Conc"}]
                    },
                    }]})
            ]}),
            isc.HLayout.create({align: "top", members: [dynamicForm_ContactConcCustomer]}),
            isc.HLayout.create({ID: "dynamicForm1And2Conc", align: "center", members: [dynamicForm1Conc, dynamicForm2Conc]}),
            isc.HLayout.create({align: "center", members: [DynamicForm_ContactConcSeller]}),
            isc.HLayout.create({ID: "dynamicForm3And4Conc", align: "center", members: [dynamicForm3Conc, dynamicForm4Conc]})
        ]
    });

 var article2Conc = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle2Conc",
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
                        article2Conc.setValue("amount_en", numberToEnglish(value))
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
                ]
            },
            {
                type: "text",
                width: "80",
                name: "cathodesTolorance",
                title: "+/-",
                defaultValue: "",
                keyPressFilter: "[0-9.]", //article2_13
            },
            {
                type: "text",
                width: "100",
                name: "optional", //article2_14
                startRow: false,
                defaultValue: 0,
                title: '<b><font size=2px>(IN</font><b>',
                valueMap: {
                    "0": "",
                    "1": "SELLERS",
                    "2": "BUYER"
                },
                changed: function (form, item, value) {
                    dynamicForm_fullArticle02.setValue(dynamicForm_fullArticle02.getValue()+" "+"(IN"+" "+article2Conc.getItem("optional").getDisplayValue(value)+" "+"OPTION) DURING");
                    dynamicForm_fullArticle02.setValue(article2Conc.getValue("amount")+" "+article2Conc.getValue("amount_en")+" "+article2Conc.getItem("unitId").getDisplayValue(article2Conc.getValue("unitId"))+" "+"+/-"+article2Conc.getValue("cathodesTolorance")+"(IN"+article2Conc.getItem("optional").getDisplayValue(article2Conc.getValue("optional"))+" "+article2Conc.getValue("plant"));
                }
            },
            {
                type: "date",
                format: 'DD-MM-YYYY',
                name: "plant", //article2_15
                width: "500",
                startRow: false,
                title: '<b><font size=2px>OPTION) DURING</font><b>'
            }
        ]
    });
var dynamicForm_fullArticle02 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"scroll",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
})


isc.VLayout.create({
        ID: "VLayout_PageOne_ContractConc",
        width: "100%",
        height: "100%",
        align: "top",
        overflow: "scroll",
        members: [
            LablePageConc,
            vlayoutBodyConc,
            lableArticle1Conc,
            isc.HLayout.create({align: "left", members: [lableArticleSelect,VLayout_ContactParameter_ValueNumber8Conc]}),
            dynamicForm_fullArticle01,
            lableArticle2Conc,
            isc.HLayout.create({align: "left", members: [article2Conc]}),
            dynamicForm_fullArticle02
        ]
    });