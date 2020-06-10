<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>

    factoryLableHedear("LablePageCad", '<font color="#ffffff"><b>NATIONAL IRANIAN COPPER INDUSTRIES CO.<b></font>', "100%", "10", 5);
    factoryLable("lableNameContactCad", '<b><font size=4px>COPPER CATHODES CONTRACT</font><b>', "100%", '2%', 1);
    factoryLableArticle("lableArticle1Cad", '<b><font size=4px>ARTICLE 1 - DEFINITIONS:</font><b>', "30", 5)
    factoryLableArticle("lableArticle2Cad", '<b><font size=4px>ARTICLE 2 -QUANTITY :</font><b>', "30",5);
    factoryLableArticle("lableArticleSelectConc", '<b><font size=4px>SELECT ITEMS</font><b>', "25",5);

    var dynamicForm_ContactCadHeader = isc.DynamicForm.create({
        valuesManager: "contactCadHeader",
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
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: "date",
                format: 'DD-MM-YYYY',
                required: true,
                validators: [
                {
                type:"required",
                validateOnChange: true }],
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
                textAlign: "left",
                readonly: true,
                width: "90%",
                wrapTitle: false
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
                        {fieldName: "contractId", operator: "equals", value: 2}
                        ]
                },
                width: "1200",
                height: "30",
                title: "NAME",
                changed: function (form, item, value) {
                    DynamicForm_ContactParameter_ValueNumber8Cad.setValue("definitionsOne", item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue);
                    dynamicFormCad_fullArticle01.setValue(dynamicFormCad_fullArticle01.getValue("fullArticle01")+"<br>"+"-"+DynamicForm_ContactParameter_ValueNumber8Cad.getValue("definitionsOne"))
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

var dynamicFormCad_fullArticle01 = isc.RichTextEditor.create({
        valuesManager: "valuesManagerfullArticle",
        autoDraw:true,
        height:155,
        overflow:"auto",
        canDragResize:true,
        controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
        value:"",changed: function (form, item, value) {
                    if(value==undefined)
                      dynamicFormCad_fullArticle01.setValue("")
                    else
                      dynamicFormCad_fullArticle01.setValue(dynamicFormCad_fullArticle01.getValue())
                    }
            })

var vlayoutBodyCad = isc.VLayout.create({
        width: "100%",
        height: "5",
        styleName: "cad-page1-form",
        members: [
            isc.HLayout.create({align: "top", members: [dynamicForm_ContactCadHeader]}),
            isc.HLayout.create({height: "50", align: "left", members: [lableNameContactCad]}),
            isc.HLayout.create({height: "50", align: "left", members: [isc.ContactCadComponent.create({})]})
        ]
    });

 var article2Cad = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle2Cad",
        height: "50%",
        numCols: 14,
        wrapItemTitles: false,
        items: [
            {
                name: "amount",
                type: "number",
                width: "80",
                defaultValue: "",
                title: "",
                showTitle: false,
                keyPressFilter: "[0-9.]", ///article2_number10
                changed: function (form, item, value) {
                    article2Cad.setValue("amount_en", numberToEnglish(value))
                    }
            },
            {
                name: "amount_en",
                title: "",
                type: "text", styleName: "textToLable", width: "200",
                showTitle: false, disabled: "true"
            },
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
                name: "optional", //article2_14
                type: "text",
                width: "250",
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
                    dynamicForm_fullArticle02Cad.setValue(article2Cad.getValue("amount")+" "+article2Cad.getValue("amount_en")+" "+article2Cad.getItem("unitId").getDisplayValue(article2Cad.getValue("unitId"))+" "+article2Cad.getValue("cathodesTolorance")+" "+article2Cad.getItem("optional").getDisplayValue(article2Cad.getValue("optional"))+" "+article2Cad.getValue("contractStart")+" "+article2Cad.getValue("contractEnd"));
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
var dynamicForm_fullArticle02Cad = isc.RichTextEditor.create({
        valuesManager: "valuesManagerfullArticle",
        autoDraw:true,
        height:155,
        overflow:"scroll",
        canDragResize:true,
        controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
        value:""
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
