<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>

var sendDateSetConc;
    factoryLableArticle("lableArticle3", '<b><font size=4px>Article 3 -QUALITY</font><b>',"30", 5);
    factoryLableArticle("lableArticle3_1", '<b><font size=3px>Copper concentrates as per the following typical analysis:</font><b>',"30", 5)
    factoryLableArticle("lableArticle4", '<b><font size=4px>Article 4 -SHIPMENT</font><b>',"30", 5);
    factoryLableArticle("lableArticle5", '<b><font size=4px>Article 5 -Delivery Terms</font><b>',"30", 5);
    factoryLableArticle("lableArticle6", '<b><font size=4px>Article 6 -Insurance</font><b>',"30", 5);
    factoryLableArticle("lableArticle7", '<b><font size=4px>Article 7 -Risk of loss</font><b>',"30", 5);
    factoryLableArticle("lableArticle8", '<b><font size=4px>Article 8 -Price Terms</font><b>',"30", 5);
    factoryLableArticle("lableArticle9", '<b><font size=4px>Article 9 -Deductions</font><b>',"30", 5);
    factoryLableArticle("lableArticleNull", '<b><font size=4px></font><b>',"30", 5);
    factoryLableArticle("lableArticle10", '<b><font size=4px>ARTICLE 10 - QUOTATIONAL PERIOD</font><b>', "30", 5)
    factoryLableArticle("lableArticle11", '<b><font size=4px>ARTICLE 11 - Payment</font><b>', "30", 5)
    factoryLableArticle("lableArticle12", '<b><font size=4px>ARTICLE 12 - CURRENCY CONVERSION</font><b>', "30", 5)

var RestDataSource_Incoterms_InConc = isc.MyRestDataSource.create({
        fields:
        [
        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "code", title: "<spring:message code='goods.code'/> "},
        ],
        fetchDataURL: "${contextPath}/api/incoterms/spec-list"
});

var dynamicForm_article3Conc = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle3_conc",
        height: "20",
        numCols: 19,
        items: [
            {
                name: "title",
                type: "text",
                showTitle: false,
                disabled: true,
                startRow: true,
                width: "100",
                defaultValue: "TITLE"
            },
            {
                name: "value",
                type: "text",
                showTitle: false,
                disabled: true,
                startRow: false,
                width: "100",
                defaultValue: "VALUE"
            },
            {
                name: "unit",
                type: "text",
                showTitle: false,
                disabled: true,
                startRow: false,
                width: "200",
                defaultValue: "UNIT"
            },
            {
                name: "TitleCu",
                type: "text",
                showTitle: false,
                disabled: true,
                startRow: true,
                width: "100",
                defaultValue: "CU"
            },
            {
                name: "CU",
                keyPressFilter: "[0-9]",
                showTitle: false,
                startRow: false,
                width: "100",
            },
            {
                name: "unitCu",
                width: "200",
                showTitle: false,
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
                ]
            },
            {
                name: "TitleMo",
                type: "text",
                showTitle: false,
                disabled: true,
                startRow: true,
                width: "100",
                defaultValue: "MO"
            },
            {
                name: "MO",
                keyPressFilter: "[0-9]",
                showTitle: false,
                startRow: false,
                width: "100",
            },
            {
                name: "unitMo",
                width: "200",
                showTitle: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Unit,
                autoFetchData: false,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 440, align: "center"}
                ]
            }
        ]
    })
var dynamicForm_fullArticleConc03 = isc.DynamicForm.create({
            valuesManager: "valuesManagerfullArticle",
            height: "20",
            width: "100%",
            wrapItemTitles: false,
            items: [
                {
                    name: "fullArticle03",
                    disabled: false,
                    type: "text",
                    length: 5000,
                    startRow: true,
                    showTitle: false,
                    colSpan: 10,
                    defaultValue: "COPPER CONCENTRATES AS PER THE FOLLOWING TYPICAL ANALYSIS (HEREINAFTER CALLED “THE MATERIAL”) WITHOUT ANY FOREIGN MATERIAL AND AGGLOMERATION:",
                    title: "fullArticle03",
                    width: "*"
                }
            ]
        })
var buttonAddConcItem=isc.IButton.create({
    title: "Add Item Shipment",
    width: 150,
    icon: "[SKIN]/actions/add.png",
    iconOrientation: "right",
    click: "ListGrid_ContractConcItemShipment.startEditingNew()"
})

isc.ListGrid.create({
        ID:"ListGrid_ContractConcItemShipment",
        width: "79%",
        height: "200",
        modalEditing: true,
        canEdit: true,
        canRemoveRecords: true,
        autoFetchData: false,
        autoSaveEdits: false,
        dataSource: RestDataSource_ContractShipment,
        fields:
            [
                {name: "id", hidden: true,},
                {name: "tblContractItem.id", type: "long", hidden: true},
                {
                    name: "plan",
                    title: "<spring:message
                    code='shipment.plan'/>",
                    type: 'text',
                    width: 140,
                    valueMap: {"A": "plan A", "B": "plan B", "C": "plan C",},
                    align: "center"
                },
                {
                    name: "shipmentRow",
                    title: "<spring:message code='contractItem.itemRow'/> ",
                    type: 'text',
                    width: 35,
                    align: "center"
                },
                {
                    name: "dischargeId", title: "<spring:message code='port.port'/>", editorType: "SelectItem",
                    optionDataSource: RestDataSource_Port,
                    displayField: "port",
                    valueField: "id", width: 400, align: "center"
                },
                {
                    name: "address",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    width: 392,
                    align: "center"
                },
                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float',
                    width: 100,
                    align: "center",changed: function (form, item, value) {
                       if(ListGrid_ContractConcItemShipment.getEditRow()==0){
                           amountSet=value;
                           valuesManagerArticle5_quality.setValue("fullArticle5",value+"MT");
                        }
                }
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    type: "date",
                    required: false,
                    width: "200",
                    wrapTitle: false,changed: function (form, item, value) {
                        sendDateSetConc = (value.getFullYear() + "/" + ("0" + (value.getMonth() + 1)).slice(-2) + "/" + ("0" + value.getDate()).slice(-2));
                    }
                },
                {
                    name: "duration",
                    title: "<spring:message code='global.duration'/>",
                    type : 'text',
                    width: 100,
                    align: "center"
                },
                {
                name: "tolorance", title: "<spring:message code='contractItemShipment.tolorance'/>",
                    type: 'text', width: 80, align: "center",changed: function (form, item, value) {
                       if(ListGrid_ContractConcItemShipment.getEditRow()==0){
                           valuesManagerArticle5_quality.setValue("fullArticle5",amountSet+"MT"+" "+"+/-"+value+" "+valuesManagerArticle2Conc.getItem("optional").getDisplayValue(valuesManagerArticle2Conc.getValue("optional"))+" "+"PER EACH CALENDER MONTH STARTING FROM"+" "+sendDateSetConc+" "+"TILL");
                        }
                }
                },
            ],saveEdits: function () {
                var ContractItemShipmentRecord = ListGrid_ContractConcItemShipment.getEditedRecord(ListGrid_ContractConcItemShipment.getEditRow());
                if(ListGrid_ContractConcItemShipment.getSelectedRecord() === null){
                        return;
                }else{
                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: "${contextPath}/api/contractShipment/",
                        httpMethod: "PUT",
                        data: JSON.stringify(ContractItemShipmentRecord),
                        callback: function (resp) {
                            if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                    ListGrid_ContractConcItemShipment.setData([]);
                                    ListGrid_ContractConcItemShipment.fetchData(criteriaContractItemShipment);
                            } else
                                isc.say(RpcResponse_o.data);
                        }
                    }))
                }
        },removeData: function (data) {
            var ContractShipmentId = data.id;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/contractShipment/" + ContractShipmentId,
                    httpMethod: "DELETE",
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            ListGrid_ContractConcItemShipment.invalidateCache();
                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                        } else {
                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                        }
                    }
                })
            );
        }
    });
var dynamicForm_fullArticleConc04 = isc.DynamicForm.create({
            valuesManager: "valuesManagerfullArticle",
            height: "20",
            width: "100%",
            wrapItemTitles: false,
            items: [
                {
                    name: "fullArticle04",
                    disabled: false,
                    type: "text",
                    length: 5000,
                    startRow: true,
                    showTitle: false,
                    colSpan: 10,
                    defaultValue: "IN PARTIAL SHIPMENTS, WHERE SHIPPING SCHEDULE TO BE MUTUALLY AGREED BETWEEN BUYER AND SELLER BY LATEST 15TH, FEBRUARY. 2016.",
                    title: "fullArticle04",
                    width: "*"
                }
            ]
        })

var article5_ConcDeliveryTerms = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle5_DeliveryTermsConc",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "incotermsText",
                type: "text",
                showTitle: true,
                disabled: true,
                defaultValue: "INCOTERMS 2010",
                width: "500",
                wrap: false,
                title: "<strong class='cssDynamicForm'>CONTRACT INCOTERMS</strong>",changed: function (form, item, value) {
                   //article6_quality.setValue("fullArticle6",textTes);
                }
            }
            ,{
                name: "incotermsId", //article6_number32
                colSpan: 3,
                titleColSpan: 1,
                tabIndex: 6,
                showTitle: true,
                showHover: true,
                showHintInField: true,
                hint: "FOB",
                required: true,
                type: 'long',
                numCols: 4,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Incoterms_InConc,
                displayField: "code",
                valueField: "id",
                pickListWidth: "450",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "code", width: 440, align: "center"}
                ],pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "code", operator: "contains", value: "FOB"}
                       ]
                    },
                width: "500",
                title: "<strong class='cssDynamicForm'>SHIPMENT TYPE<strong>"
            } , {
                name: "portByPortSourceId",
                editorType: "SelectItem",
                required: true,
                optionDataSource: RestDataSource_Port,
                displayField: "port",
                valueField: "id",
                showTitle: true,
                startRow: false,
                showHintInField: true,
                width: "500",
                title: "<strong class='cssDynamicForm'>SOURCE PORT</strong>"
            }
        ]
    })
var dynamicForm_fullArticleConc05 = isc.DynamicForm.create({
            valuesManager: "valuesManagerfullArticle",
            height: "20",
            width: "100%",
            wrapItemTitles: false,
            items: [
                {
                    name: "fullArticle05",
                    disabled: false,
                    type: "text",
                    length: 5000,
                    startRow: true,
                    showTitle: false,
                    colSpan: 10,
                    defaultValue: "5.1. FOB BANDAR ABBAS STOWED AND TRIMMED, IRAN WITH BUYER’S OPTION FOR CIF DISCHARGE PORT, AS NOMINATED BY BUYER OR DAP DISCHARGE PORT, AS NOMINATED BY BUYER, TO BE MUTUALLY AGREED.\n"+
                    "\n"+
                    "IN CASE OF DELIVERY BASIS DAP / CIF DISCHARGE PORT, AS NOMINATED BY BUYER, THE APPLICABLE TERMS SHALL BE MUTUALLY AGREED BETWEEN THE PARTIES.\n",
                    title: "fullArticle05",
                    width: "*"
                }
            ]
        })
var dynamicForm_fullArticleConc06 = isc.DynamicForm.create({
        valuesManager: "valuesManagerfullArticle",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle06",
                disabled: false,
                type: "text",
                length: 6000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "•\tTHE INSURANCE SHALL PROVIDE FULL RISKS COVER IN ACCORDANCE WITH INSTITUTE CARGO CLAUSES A, INSTITUTE CARGO CLAUSES WAR AND INSTITUTE CARGO CLAUSES STRIKES  FROM THE TIME THE MATERIAL HAS BEEN LOADED ON BOARD OF THE CARRYING VESSEL AT LOAD PORT UNTIL ARRIVAL AT FINAL DESTINATION, WITH AN INSURANCE COMPANY OF GOOD REPUTE AND WHICH ENTITLES THE BUYER TO CLAIM DIRECTLY FROM THE INSURERS. \n"+
"•\tTHE COST OF INSURANCE SHALL BE PAID BY BUYER REGARDLESS OF ANY DELIVERY TERMS MENTIONED IN THIS CONTRACT.\n",
                title: "fullArticle06",
                width: "*"
            }
        ]
    })
var dynamicForm_fullArticleConc07 = isc.DynamicForm.create({
        valuesManager: "valuesManagerfullArticle",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle07",
                disabled: false,
                type: "text",
                length: 6000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "TITLE :\n"+
"THE TITLE TO AND OWNERSHIP OF THE MATERIAL SHALL PASS FROM SELLER TO BUYER FOR EACH SHIPMENT OF MATERIAL ONCE PROVISIONAL PAYMENT HAS BEEN MADE BY BUYER TO SELLER.\n"+
"\n"+
"RISK :\n"+
"RISK OF LOSS SHALL PASS TO BUYER IN ACCORDANCE WITH INCOTERMS 2010 .\n",
                title: "fullArticle07",
                width: "*"
            }
        ]
    })
var dynamicForm_fullArticleConc08 = isc.DynamicForm.create({
        valuesManager: "valuesManagerfullArticle",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle08",
                disabled: false,
                type: "text",
                length: 6000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "FULL FINAL COPPER CONTENT SUBJECT TO A DEDUCTION OF ONE UNIT SHALL BE PAID FOR AT THE GRADE ‘A’ OFFICIAL LME COPPER SETTLEMENT QUOTATIONS AS PUBLISHED IN THE LONDON METAL BULLETIN AVERAGED OVER THE QUOTATIONAL PERIOD.",
                title: "fullArticle08",
                width: "*"
            }
        ]
    })

var dynamicForm_article9Conc = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle9_conc",
        height: "20",
        wrapItemTitles: false,
        items: [
            {
                name: "TC",
                showTitle: true,
                title:"What is the value of TC",
                startRow: true,
                width: "100",
                keyPressFilter: "[0-9]"
            },
            {
                name: "RC",
                showTitle: true,
                title:"What is the value of RC",
                startRow: true,
                width: "100",
                keyPressFilter: "[0-9]"
            },
        ]
})
var dynamicForm_fullArticleConc09 = isc.DynamicForm.create({
        valuesManager: "valuesManagerfullArticle",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle09",
                disabled: false,
                type: "text",
                length: 6000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "TREATMENT CHARGE:\n"+
"US. DOLLARS 97.00 (NINETY SEVEN POINT ZERO ZERO) PER DMT FOB. ST BANDAR ABBAS, IRAN \n"+
"\n"+
"REFINING CHARGE:\n"+
"US.CENTS 9.70 (NINE POINT SEVEN ZERO) PER POUND OF PAYABLE COPPER FOB BANDAR ABBAS, IRAN\n",
                title: "fullArticle09",
                width: "*"
            }
        ]
    })

var article10_qualityConc = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle10_quality",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "article10_quality1", //10
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",
                wrap: false,
                title: "<strong class='cssDynamicForm'>AVERAGE OF WORKING DAYS OF QUOTATIONAL PERIOD<strong>",changed: function (form, item, value) {
                }
            },{
                name: "fullArticle10",
                disabled: false,
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "QUOTATIONAL FOR ALL PAYABLE METALS SHALL BE AS FOLLOWS :\n"+
"- QUOTATIONAL PERIOD FOR COPPER FOR THE YEAR OF 2016, SHALL BE FOURTH MONTH FOLLOWING THE MONTH OF ACTUAL SHIPMENT FROM THE PORT OF LOADING AS EVIDENCED BY BL DATE (MOAS+4).\n"+
"- QUOTATIONAL PERIOD FOR GOLD AND SILVER FOR THE YEAR OF 2016 SHALL BE SECOND MONTH FOLLOWING THE MONTH OF ACTUAL SHIPMENT FROM THE PORT OF LOADING AS EVIDENCED BY BL DATE (MOAS+2).\n",
                title: "fullArticle10",
                width: "*"
            }
        ]
    })

var dynamicForm_fullArticleConc11 = isc.DynamicForm.create({
        valuesManager: "valuesManagerfullArticle",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle11",
                disabled: false,
                type: "text",
                length: 6000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "NOTWITHSTANDING ANYTHING ELSE HEREIN, ALL PAYMENTS PURSUANT TO THIS CONTRACT, INCLUDING THIS ARTICLE 11, ARE SUBJECT TO CLAUSE 25 (GENERAL COMPLIANCE).",
                title: "fullArticle11",
                width: "*"
            }
        ]
    })

var article12_qualityConc = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle12_quality",
        height: "20",
        width: "100%",
        numCols: 10,
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article12_number56",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                title: "<strong class='cssDynamicForm'>PULL DOWN</strong>"
             },
             {
                name: "article12_number57",
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
                title: "<strong class='cssDynamicForm'>BANK REFERENCE</strong>"
             },{
                name: "article12_number58",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: true,
                title: "<strong class='cssDynamicForm'>PULL DOWN</strong>"
             },
             {
                name: "article12_number59",
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
                title: "<strong class='cssDynamicForm'>BANK REFERENCE</strong>"
            },{
                name: "article12_number60",
                width: "150",
                type:"date",
                showTitle: true,
                defaultValue: "",
                startRow: true,
                title: "<strong class='cssDynamicForm'>EXCHANGE RATE DATE</strong>"
            },{
                name: "article12_number61",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                title: "<strong class='cssDynamicForm'>RATE</strong>"
            },{
                name: "fullArticle12",
                disabled: false,
                type: "text",
                length: 5000,
                startRow: true,
                showTitle: false,
                colSpan: 10,
                defaultValue: "NOTE: ALL THE RELATED INVOICES SHALL BE ISSUED BASED ON USD AND PAID IN NON USD CURRENCY (WHICH SHALL BE STATED IN THE INVOICE ACCORDINGLY) AS FOLLOWS: \n"+
"-\tIN CASE OF EURO, THE VALUE OF EACH PAYMENT SHALL BE CONVERTED FROM USD INTO EURO THEREFORE THE APPLICABLE CONVERSION RATE WILL BE BASED ON ECB RATE AND UNKNOWN DATE OF WHICH WILL BE AGREED BY BUYER & SELLER’S FINANCIAL DEPARTMENT.\n"+
"-\tIF THE VALUE OF EACH PAYMENT SHALL BE CONVERTED FROM USD INTO AED THEREFORE THE APPLICABLE CONVERSION RATE AT THE PREVAILING AVAILABLE RATE SHALL BE 3.67.\n"+
"-\tPAYMENTS UNDER THIS CONTRACT WILL BE REMITTED TO OR FROM A BANK AND BANK ACCOUNT ACCEPTABLE TO BUYER AND TO BUYER’S BANK.\n",
                title: "fullArticle10",
                width: "*"
            }
        ]
    });
var VLayout_PageTwo_Contract=isc.VLayout.create({
        width: "100%",
        height: "100%",
        align: "top",
        overflow: "scroll",
        members: [
            lableArticle3,
            lableArticle3_1,
            dynamicForm_article3Conc,
            dynamicForm_fullArticleConc03,
            lableArticle4,
            buttonAddConcItem,
            ListGrid_ContractConcItemShipment,
            dynamicForm_fullArticleConc04,
            lableArticle5,
            article5_ConcDeliveryTerms,
            dynamicForm_fullArticleConc05,
            lableArticle6,
            dynamicForm_fullArticleConc06,
            lableArticle7,
            dynamicForm_fullArticleConc07,
            lableArticle8,
            dynamicForm_fullArticleConc08,
            lableArticle9,
            isc.HLayout.create({align: "left", members: [lableArticleNull,dynamicForm_article9Conc]}),
            dynamicForm_fullArticleConc09,
            lableArticle10,
            article10_qualityConc,
            lableArticle11,
            dynamicForm_fullArticleConc11,
            lableArticle12,
            article12_qualityConc
        ]
    });


