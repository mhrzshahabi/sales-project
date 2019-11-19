<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>

    var imanageNote = 0;


    factoryLableArticle("lableArticle3", '<b><font size=4px>Article 3 -QUALITY</font><b>', "30", 5)
    factoryLableArticle("lableArticle4", '<b><font size=4px>Article 4 -PACKING</font><b>', "30", 5)
    factoryLableArticle("lableArticle5", '<b><font size=4px>Article 5 -SHIPMENT</font><b>', "30", 5)

    var dynamicForm_article2_Note2_number30 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticleNote5",
        height: "20",
        wrapItemTitles: false,
        numCols: 2,
        width: "100%",
        items: [
            {
                type: "Label",
                name: "article2_Note1_lable",
                width: "150",
                height: "25",
                showTitle: false,
                wrap: true,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                displayField: "paramValue",
                valueField: "paramName",
                showTitle: false,
                pickListWidth: "800",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "paramName", width: "25%", align: "center"},
                    {name: "paramType", width: "25%", align: "center"},
                    {name: "paramValue", width: "50%", align: "center"}
                ],
                pickListCriteria: {
                    _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                        {fieldName: "contractId", operator: "equals", value: 1},
                        {fieldName: "categoryValue", operator: "equals", value: 5}]
                },
                changed: function (form, item, value) {
                    dynamicForm_article2_Note2_number30.setValue("article2_Note1_value", item.getSelectedRecord().paramValue);
                },
                startRow: false,
                title: ''
            },
            {
                name: "article2_Note1_value",
                type: "text",
                length: 3000,
                showTitle: false,
                startRow: true,
                wrap: false,
                width: "1500",
                height: "80",
                defaultValue: "MAXIMUM ONE WEEK AFTER CONTRACT SIGNATURE/STAMP BUYER IS OBLIGED TO INFORM SELLER OF ITS SHIPMENT SCHEDULE FOR THE REMAINING QUANTITY I.E",
                title: "article5_Note1",
            },
            {
                name: "button",
                type: "button",
                width: "10%",
                height: "30",
                title: "Remove",
                startRow: false,
                icon: "icons/16/message.png",
                click: function () {
                    dynamicForm_article2_Note2_number30.removeFields(["article2_Note1_lable", "article2_Note1_value", "button"])
                }
            }
        ]
    })
    var buttonNote = isc.HLayout.create({
        width: "100%", height: "100%", membersMargin: 20,
        members: [
            isc.Label.create({
                styleName: "buttonHtml buttonHtml1",
                align: "center",
                valign: "center",
                wrap: false,
                contents: "Add",
                click: function () {
                    manageNote('Add', imanageNote)
                }
            }),
            isc.Label.create({
                styleName: "buttonHtml buttonHtml3",
                align: "center",
                valign: "center",
                wrap: false,
                contents: "Remove",
                click: function () {
                    manageNote('Remove', imanageNote)
                }
            })
        ]
    })

    var hlayuotNote = isc.VLayout.create({
        height: "30",
        align: "left",
        members: [dynamicForm_article2_Note2_number30, buttonNote]
    })


    isc.VLayout.create({
        ID: "VLayout_PageTwo_Contract",
        width: "100%",
        height: "100%",
        align: "top",
        overflow: "scroll",
        members: [
            hlayuotNote,
            lableArticle3,
            lableArticle4,
            lableArticle5
        ]
    });


    function manageNote(value, id) {
        if (value == 'Add') {
            dynamicForm_article2_Note2_number30.addFields([
                {
                    type: "Label",
                    name: "article2_Note1_lable" + id,
                    width: "150",
                    height: "40",
                    wrap: true,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Parameters,
                    displayField: "paramValue",
                    valueField: "paramName",
                    showTitle: false,
                    pickListWidth: "700",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "paramName", width: "25%", align: "center"},
                        {name: "paramType", width: "25%", align: "center"},
                        {name: "paramValue", width: "50%", align: "center"}
                    ],
                    pickListCriteria: {
                        _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                            {fieldName: "contractId", operator: "equals", value: 1},
                            {fieldName: "categoryValue", operator: "equals", value: 5}]
                    },
                    changed: function (form, item, value) {
                        dynamicForm_article2_Note2_number30.setValue("article2_Note1_value" + id, item.getSelectedRecord().paramValue);
                    },
                },
                {
                    name: "article2_Note1_value" + id,
                    type: "text",
                    length: 3000,
                    showTitle: false,
                    wrap: false,
                    startRow: true,
                    width: "1500",
                    height: "80",
                    defaultValue: "MAXIMUM ONE WEEK AFTER CONTRACT SIGNATURE/STAMP BUYER IS OBLIGED TO INFORM SELLER OF ITS SHIPMENT SCHEDULE FOR THE REMAINING QUANTITY I.E",
                    title: "article2_Note1",
                },
                {
                    name: "button" + id,
                    type: "button",
                    width: "10%",
                    height: "30",
                    title: "Remove",
                    startRow: false,
                    icon: "icons/16/message.png",
                    click: function () {
                        dynamicForm_article2_Note2_number30.removeFields(["article2_Note1_lable" + id, "article2_Note1_value" + id, "button" + id])
                    }
                }
            ]);
            imanageNote++;
        } else {
            --imanageNote;
            dynamicForm_article2_Note2_number30.removeFields(["article2_Note1_lable" + i, "article2_Note1_value" + i, "button" + i]);
        }
    }