<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    factoryLableHedear("LablePageConc", '<font><b>NATIONAL IRANIAN COPPER INDUSTRIES CO.<b></font>', "100%", "10", 5);
    factoryLable("lableNameContactConc", '<b><font size=4px>COPPER CONCENTRATES CONTRACT</font><b>', "100%", '2%', 1);
    factoryLableArticle("lableArticle1Conc", '<b><font size=4px>ARTICLE 1 - DEFINITIONS:</font><b>', "30", 5)
    factoryLableArticle("lableArticle2Conc", '<b><font size=4px>ARTICLE 2 -QUANTITY :</font><b>', "30",5);
    factoryLableArticle("lableArticleSelect", '<b><font size=4px>SELECT ITEMS</font><b>', "25",5);


    var dynamicForm_ContactConcHeader = isc.DynamicForm.create({
        valuesManager: "contactHeaderConc",
        wrapItemTitles: false,
        width: "100%",
        height: "100%",
        titleWidth: "80",
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
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }],
                width: "90%",
                wrapTitle: false
            },
            {
                name: "contractNo",
                title: "<spring:message code='contact.no'/>",
                requiredMessage: "<spring:message code='validator.field.is.required'/>",
                required: true,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }],
                readonly: true,
                width: "90%",
                wrapTitle: false
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
                displayField: "paramName",
                valueField: "paramName",
                showTitle: false,
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "paramName", title: "<spring:message code='parameters.paramName'/>", width: "20%", align: "center"},
                   // {name: "paramType", title: "<spring:message code='parameters.paramType'/>", width: "20%", align: "center"},
                    {name: "paramValue", title: "<spring:message code='parameters.paramValue'/>", width: "60%", align: "center"},
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
                    }
                ],
                pickListCriteria: {
                    _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                        {fieldName: "contractId", operator: "equals", value: 3},
                        ]
                },
                width: "1200",
                height: "30",
                title: "NAME",
                changed: function (form, item, value) {
                    DynamicForm_ContactParameter_ValueNumber8Conc.setValue("definitionsOne", item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue);
                    dynamicForm_fullArticle01.setValue(dynamicForm_fullArticle01.getValue()+"<br>"+"-"+DynamicForm_ContactParameter_ValueNumber8Conc.getValue("definitionsOne"))
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
            isc.HLayout.create({align: "top", members: [isc.ContactConComponent.create({})]}),
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
                ],changed: function (form, item, value) {
                }
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
                    "1": "SELLER’S",
                    "2": "BUYER’S"
                },
                changed: function (form, item, value) {
                    dynamicForm_fullArticle02.setValue(dynamicForm_fullArticle02.getValue()+" "+"(IN"+" "+article2Conc.getItem("optional").getDisplayValue(value)+" "+"OPTION) DURING");
                    dynamicForm_fullArticle02.setValue(article2Conc.getValue("amount")+" "+article2Conc.getValue("amount_en")+" "+article2Conc.getItem("unitId").getDisplayValue(article2Conc.getValue("unitId"))+" "+"+/-"+article2Conc.getValue("cathodesTolorance")+"(IN"+article2Conc.getItem("optional").getDisplayValue(article2Conc.getValue("optional"))+" "+article2Conc.getValue("contractStart")+" "+article2Conc.getValue("contractEnd"));
                }
            },
            {
                name: "contractStart", //article2_15
                type: "date",
                width: "500",
                startRow: false,
                title: "<spring:message code='contract.contractStart'/>",
            },
            {
                name: "contractEnd",
                title: "<spring:message code='contract.contractEnd'/>",
                type: "date",
                width: "500",
                startRow: false
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