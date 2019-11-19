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
    factoryLableArticle("lableArticle6", '<b><font size=4px>ARTICLE 6 - DELIVERY TERMS</font><b>', "30", 5)
    factoryLableArticle("lableArticle7", '<b><font size=4px>ARTICLE 7 – PRICE</font><b>', "30", 5)
    factoryLableArticle("lableArticle8", '<b><font size=4px>ARTICLE 8 - QUOTATIONAL PERIOD</font><b>', "30", 5)
    factoryLableArticle("lableArticle9", '<b><font size=4px>ARTICLE 9 – PAYMENT</font><b>', "30", 5)
    factoryLableArticle("lableArticle10", '<b><font size=4px>ARTICLE 10 - CURRENCY CONVERSION</font><b>', "30", 5)
    factoryLableArticle("lableArticle11", '<b><font size=4px>ARTICLE 11 - TITLE AND RISK OF LOSS</font><b>', "30", 5)
    factoryLableArticle("lableArticle12", '<b><font size=4px>ARTICLE 12 – WEIGHTS AND QUALITY CONTROL</font><b>', "30", 5)
    factoryLableArticle("lableArticle13", '<b><font size=4px>ARTICLE 13 – INCOTERMS</font><b>', "30", 5)

    var article3_quality = isc.DynamicForm.create({
        valuesManager: "article3_quality",
        height: "20",
        width: "60%",
        wrapItemTitles: false,
        items: [
            {
                name: "article3_quality1",
                type: "text",
                showTitle: true,
                width: "500",
                wrap: false,
                title: "ONE-WRITE PLANTS THAT MATERIALS ARE PRODUCED IN "
            }
            , {
                name: "article3_quality2",
                type: "text",
                showTitle: true,
                wrap: false,
                width: "500",
                title: "TWO-WRITE PLANTS THAT MATERIALS ARE PRODUCED IN "
            }
        ]
    })

var article4_quality = isc.DynamicForm.create({
        valuesManager: "article4_quality",
        height: "20",
        width: "60%",
        wrapItemTitles: false,
        items: [
            {
                name: "article4_quality1",
                type: "text",
                showTitle: true,
                width: "500",
                wrap: false,
                title: "WRITE BUNDELS TONNAGE IN MT FOR ELECTROLYTIC COPPER CATHODES "
            }
            , {
                name: "article4_quality2",
                type: "text",
                showTitle: true,
                wrap: false,
                width: "500",
                title: "WRITE BUNDELS TONNAGE IN MT FOR SXEW  "
            }
        ]
    })
var article5_quality = isc.DynamicForm.create({
        valuesManager: "article5_quality",
        height: "20",
        width: "60%",
        wrapItemTitles: false,
        items: [
            {
                name: "article5_quality1",
                type: "text",
                showTitle: true,
                width: "500",
                wrap: false,
                title: "WRITE AMOUNT OF EACH SHIPMENT"
            }
            , {
                name: "optional",
                type: "text",
                showTitle: true,
                wrap: false,
                width: "500",
                valueMap: {
                    "1": "SELLERS",
                    "2": "BUYER"
                },
                title: "WRITE SHIPMENT OPTION"
            } , {
                name: "article5_quality2",
                type:"date",
                defaultValue: "<%=dateUtil.todayDate()%>",
                showTitle: true,
                wrap: false,
                width: "500",
                title: "WRITE START DATE OF SHIPMENT"
            },{
                name: "article5_quality2",
                type:"date",
                defaultValue: "<%=dateUtil.todayDate()%>",
                showTitle: true,
                wrap: false,
                width: "500",
                title: "WRITE END DATE OF SHIPMENT"
            }
        ]
    })

var article6_quality = isc.DynamicForm.create({
        valuesManager: "article6_quality",
        height: "20",
        width: "60%",
        disabled: "true",
        wrapItemTitles: false,
        items: [
            {
                name: "article6_quality1",
                type: "text",
                showTitle: true,
                defaultValue: "INCOTERMS 2010",
                width: "500",
                wrap: false,
                title: "WRITE CONTRACT INCOTERMS"
            }
            , {
                name: "article6_quality2",
                type: "text",
                showTitle: true,
                defaultValue: "FOB",
                wrap: false,
                width: "500",
                title: "WRITE SHIPMENT TYPE"
            } , {
                name: "article6_quality3",
                type: "text",
                showTitle: true,
                defaultValue: "BANDAR ABBAS",
                wrap: false,
                width: "500",
                title: "WRITE SOURCE PORT"
            }
        ]
    })

 var article7_quality = isc.DynamicForm.create({
        valuesManager: "article7_quality",
        height: "20",
        width: "60%",
        wrapItemTitles: false,
        items: [
            {
                name: "article7_quality1",
                type: "text",
                showTitle: true,
                defaultValue: "LME",
                width: "500",
                wrap: false,
                title: "WRITE PRICE REFERENCE"
            }
        ]
    })
var article8_quality = isc.DynamicForm.create({
        valuesManager: "article8_quality",
        height: "20",
        width: "60%",
        wrapItemTitles: false,
        items: [
            {
                name: "article8_quality1",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",
                wrap: false,
                title: "WRITE AVERAGE OF WORKING DAYS OF QUOTATIONAL PERIOD"
            },{
                name: "article8_quality2",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",
                wrap: false,
                title: "WRITE NUMBER OF DAYS BEFORE BL"
            },{
                name: "article8_quality3",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",
                wrap: false,
                title: "WRITE NUMBER OF DAYS AFTER BL"
            }
        ]
    })
var article9_quality = isc.DynamicForm.create({
        valuesManager: "article9_quality",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "article9_quality1",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",
                wrap: false,
                title: "WRITE PAYMENT METHOD"
            },{
                name: "article9_quality2",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",
                wrap: false,
                title: "WRITE PAYMENT PERCENTAGE OF PROFORMA INVOICE PROVISIONAL"
            }
        ]
    })
var article10_quality = isc.DynamicForm.create({
        valuesManager: "article10_quality",
        height: "20",
        numCols: 10,
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article10_number56",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                title: 'PULL DOWN'
             },
             {
                name: "article10_number57",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                displayField: "paramValue",
                valueField: "paramValue",
                pickListProperties: {showFilterEditor: true},
                pickListWidth: "700",
                pickListFields: [
                    {name: "paramName", width: "20%", align: "center"},
                    {name: "paramType", width: "20%", align: "center"},
                    {name: "paramValue", width: "60%", align: "center"}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "contractId", operator: "equals", value: 1},
                        {fieldName:"categoryValue",operator:"equals",value:-2}]
                    },
                title: 'BANK REFERENCE'
             },{
                name: "article10_number58",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: true,
                title: 'PULL DOWN'
             },
             {
                name: "article10_number59",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                autoFetchData: false,
                displayField: "paramValue",
                valueField: "paramValue",
                pickListProperties: {showFilterEditor: true},
                pickListWidth: "700",
                pickListFields: [
                    {name: "paramName", width: "20%", align: "center"},
                    {name: "paramType", width: "20%", align: "center"},
                    {name: "paramValue", width: "60%", align: "center"}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "contractId", operator: "equals", value: 1},
                        {fieldName:"categoryValue",operator:"equals",value:-2}]
                    },
                title: 'BANK REFERENCE'
            },{
                name: "article10_number60",
                width: "150",
                type:"date",
                showTitle: true,
                defaultValue: "",
                startRow: true,
                title: 'EXCHANGE RATE DATE'
            },{
                name: "article10_number61",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                title: 'RATE'
            }
        ]
    });

var article12_quality = isc.DynamicForm.create({
        valuesManager: "article12_quality",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "article12_quality1",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",
                wrap: false,
                title: "WRITE SHARE OF INSPECTION COST"
            }
        ]
    })

    isc.VLayout.create({
        ID: "VLayout_PageTwo_Contract",
        width: "100%",
        height: "100%",
        align: "top",
        overflow: "scroll",
        members: [
            lableArticle3,
            article3_quality,
            lableArticle4,
            article4_quality,
            lableArticle5,
            article5_quality,
            lableArticle6,
            article6_quality,
            lableArticle7,
            article7_quality,
            lableArticle8,
            article8_quality,
            lableArticle9,
            article9_quality,
            lableArticle10,
            article10_quality,
            lableArticle11,
            lableArticle12,
            article12_quality,
            lableArticle13
        ]
    });
