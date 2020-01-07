<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>



//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>

var RestDataSource_Incoterms_InCat = isc.MyRestDataSource.create({
        fields:
        [
        {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
        {name: "code", title: "<spring:message code='goods.code'/> "},
        ],
        fetchDataURL: "${contextPath}/api/incoterms/spec-list"
});

    var imanageNote = 0;
    var amountSet;
    var sendDateSet;
    factoryLableArticle("lableArticle3Cad", '<b><font size=4px>Article 3 -QUALITY</font><b>', "30", 5)
    factoryLableArticle("lableArticle4Cad", '<b><font size=4px>Article 4 -PACKING</font><b>', "30", 5)
    factoryLableArticle("lableArticle5Cad", '<b><font size=4px>Article 5 -SHIPMENT</font><b>', "30", 5)
    factoryLableArticle("lableArticle6Cad", '<b><font size=4px>ARTICLE 6 - DELIVERY TERMS</font><b>', "30", 5)
    factoryLableArticle("lableArticle7Cad", '<b><font size=4px>ARTICLE 7 – PRICE</font><b>', "30", 5)
    factoryLableArticle("lableArticle8Cad", '<b><font size=4px>ARTICLE 8 - QUOTATIONAL PERIOD</font><b>', "30", 5)
    factoryLableArticle("lableArticle9Cad", '<b><font size=4px>ARTICLE 9 – PAYMENT</font><b>', "30", 5)
    factoryLableArticle("lableArticle10Cad", '<b><font size=4px>ARTICLE 10 - CURRENCY CONVERSION</font><b>', "30", 5)
    factoryLableArticle("lableArticle11Cad", '<b><font size=4px>ARTICLE 11 - TITLE AND RISK OF LOSS</font><b>', "30", 5)
    factoryLableArticle("lableArticle12Cad", '<b><font size=4px>ARTICLE 12 – WEIGHTS AND QUALITY CONTROL</font><b>', "30", 5)

    var article3_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle3_quality",
        height: "20",
        width: "100%",
        membersMargin:5,  layoutMargin:10,
        wrapItemTitles: false,
        items: [
            {
                name: "plant",
                type: "text",
                showTitle: true,
                width: "500",
                wrap: false,
                title: "<strong class='cssDynamicForm'>PLANTS THAT MATERIALS ARE PRODUCED IN</strong>",changed: function (form, item, value) {
                        article3_quality.setValue("fullArticle3","NICICO ELECTROLYTIC COPPER CATHODES GRANDE A PRODUCED IN"+" "+value);
                }
            },{
                name: "fullArticle3",
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                title: "fullArticle3",
                width: "*"
            }

        ]
    })

var article4_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle4_quality",
        height: "20",
        width: "100%",
         membersMargin:5,  layoutMargin:10,
        wrapItemTitles: false,
        items: [
            {
                name: "article4_quality1",
                type: "text",
                showTitle: true,
                width: "500",
                wrap: false,
                title: "<strong class='cssDynamicForm'>BUNDELS TONNAGE IN MT FOR ELECTROLYTIC COPPER CATHODES</strong>",changed: function (form, item, value) {
                        article4_quality.setValue("fullArticle4","IN BUNDLES OF "+" "+value+" "+" METRIC TONS FOR ELECTROLYTIC COPPER CATHODES AND "+" "+article4_quality.getValue("article4_quality2")+" "+" METRIC TONS FOR(SXEW),EACH STARAPPED FOR SAFE OCEAN TRANSPORTATION");
                }
            }
            , {
                name: "article4_quality2",
                type: "text",
                showTitle: true,
                wrap: false,
                width: "500",
                title: "<strong class='cssDynamicForm'>BUNDELS TONNAGE IN MT FOR SXEW</strong>",changed: function (form, item, value) {
                        article4_quality.setValue("fullArticle4","IN BUNDLES OF "+" "+article4_quality.getValue("article4_quality1")+" "+" METRIC TONS FOR ELECTROLYTIC COPPER CATHODES AND "+" "+value+" "+" METRIC TONS FOR(SXEW),EACH STARAPPED FOR SAFE OCEAN TRANSPORTATION");
                }
            },{
                name: "fullArticle4",
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                title: "fullArticle4",
                width: "*"
            }
        ]
    })


var buttonAddItem=isc.IButton.create({
    title: "Add Item Shipment",
    width: 150,
    icon: "[SKIN]/actions/add.png",
    iconOrientation: "right",
    click: "ListGrid_ContractItemShipment.startEditingNew()"
})

ListGrid_ContractItemShipment = isc.ListGrid.create({
        width: "80%",
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
                       if(ListGrid_ContractItemShipment.getEditRow()==0){
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
                        sendDateSet = (value.getFullYear() + "/" + ("0" + (value.getMonth() + 1)).slice(-2) + "/" + ("0" + value.getDate()).slice(-2));
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
                       if(ListGrid_ContractItemShipment.getEditRow()==0){
                           valuesManagerArticle5_quality.setValue("fullArticle5",amountSet+"MT"+" "+"+/-"+value+" "+valuesManagerArticle2Cad.getItem("optional").getDisplayValue(valuesManagerArticle2Cad.getValue("optional"))+" "+"PER EACH CALENDER MONTH STARTING FROM"+" "+sendDateSet+" "+"TILL");
                        }
                }
                },
            ],saveEdits: function () {
                var ContractItemShipmentRecord = ListGrid_ContractItemShipment.getEditedRecord(ListGrid_ContractItemShipment.getEditRow());
                if(ListGrid_ContractItemShipment.getSelectedRecord() === null){
                        return;
                }else{
                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: "${contextPath}/api/contractShipment/",
                        httpMethod: "PUT",
                        data: JSON.stringify(ContractItemShipmentRecord),
                        callback: function (resp) {
                            if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_ContractItemShipment.setData([]);
                                ListGrid_ContractItemShipment.fetchData(criteriaContractItemShipment);
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
                            ListGrid_ContractItemShipment.invalidateCache();
                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                        } else {
                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                        }
                    }
                })
            );
        }

    });

var article5_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle5_quality",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle5",
                disabled: false,
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "",
                title: "fullArticle5",
                width: "*"
            }
        ]
    })
var article6_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6_quality",
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
                optionDataSource: RestDataSource_Incoterms_InCat,
                displayField: "code",
                valueField: "id",
                pickListWidth: "450",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "code", width: 440, align: "center"}
                ],
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
            ,{
                name: "fullArticle6",
                disabled: false,
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "THE MATERIAL SHALL BE DELIVERED BY SELLER TO BUYER ON FOB BANDAR ABBAS IRAN ON CONTAINERIZED BASIS(INCOTERMS 2010).THE BUYER SHALL PROVIDE THE ACTUAL FREIGHT COST IN EVERY SHIPMENT AS PER ARTICLE5;SHIPMENT,TO THE SELLER.SELLER MUST CONFRIM BUYER'S FREIGHT PRIOR EACH SHIPMENT.BUYER MUST PROVIDE SELLER ALL THE NEEDFULL DOCUMENTS ON SHIPPING LINE LETTER HEAD.",
                title: "fullArticle6",
                width: "*"
            }
        ]
    })

 var article7_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle7_quality",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "article7_quality1",
                type: "text",
                showTitle: true,
                defaultValue: "LME",
                width: "500",
                wrap: false,
                title: "<strong class='cssDynamicForm'>PRICE REFERENCE</strong>",changed: function (form, item, value) {
                        article7_quality.setValue("fullArticle7","THE PRICE PER METRIC TON OF THE MATERIAL SHALL BE THE OFFICIAL "+" "+value+" "+" CASH SETTLEMENT PRICE FOR COPPER GRADE 'A' IN USD AS PUBLISHED IN THE LONDOM METAL BULLETIN AVERAGED OVER THE QUOTATIONAL PERIOD I.E."+" "+value+" "+" FLAT FOB BANDAR ABBAS/IRAN BASIS.");
                }
            },{
                name: "fullArticle7",
                disabled: false,
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "THE PRICE PER METRIC TON OF THE MATERIAL SHALL BE THE OFFICIAL LME CASH SETTLEMENT PRICE FOR COPPER GRADE 'A' IN USD AS PUBLISHED IN THE LONDOM METAL BULLETIN AVERAGED OVER THE QUOTATIONAL PERIOD I.E.LME FLAT FOB BANDAR ABBAS/IRAN BASIS.",
                title: "fullArticle7",
                width: "*"
            }
        ]
    })
var article8_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle8_quality",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "article8_quality1", //10
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",
                wrap: false,
                title: "<strong class='cssDynamicForm'>AVERAGE OF WORKING DAYS OF QUOTATIONAL PERIOD<strong>",changed: function (form, item, value) {
                        article8_quality.setValue("fullArticle8","THE QUOTATIONAL PERIOD SHALL BE AVERAGE OF "+" "+value+" "+" WORKING DAYS FROM "+" "+article8_quality.getValue("article8_quality2")+" "+" LME WORKING DAYS PRIOR DATE OF BILL OF LADING TILL "+" "+article8_quality.getValue("article8_quality3")+" "+" LME WORKING DAYS AFTER BILL OF LADING DATA ON FOB BANDAR ABBAS/IRAN BASIS");
                }
            },{
                name: "article8_quality2",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",    //5
                wrap: false,
                title: "<strong class='cssDynamicForm'>NUMBER OF DAYS BEFORE BL</strong>",changed: function (form, item, value) {
                        article8_quality.setValue("fullArticle8","THE QUOTATIONAL PERIOD SHALL BE AVERAGE OF "+" "+article8_quality.getValue("article8_quality1")+" "+" WORKING DAYS FROM "+" "+value+" "+" LME WORKING DAYS PRIOR DATE OF BILL OF LADING TILL "+" "+article8_quality.getValue("article8_quality3")+" "+" LME WORKING DAYS AFTER BILL OF LADING DATA ON FOB BANDAR ABBAS/IRAN BASIS");
                }
            },{
                name: "article8_quality3",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",    //
                wrap: false,
                title: "<strong class='cssDynamicForm'>NUMBER OF DAYS AFTER BL</strong>",changed: function (form, item, value) {
                        article8_quality.setValue("fullArticle8","THE QUOTATIONAL PERIOD SHALL BE AVERAGE OF "+" "+article8_quality.getValue("article8_quality1")+" "+" WORKING DAYS FROM "+" "+article8_quality.getValue("article8_quality2")+" "+" LME WORKING DAYS PRIOR DATE OF BILL OF LADING TILL "+" "+value+" "+" LME WORKING DAYS AFTER BILL OF LADING DATA ON FOB BANDAR ABBAS/IRAN BASIS");
                }
            },{
                name: "fullArticle8",
                disabled: false,
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "THE QUOTATIONAL PERIOD SHALL BE AVERAGE OF 10(THE) WORKING DAYS FROM 5(FIVE) LME WORKING DAYS PRIOR DATE OF BILL OF LADING TILL 5 LME WORKING DAYS AFTER BILL OF LADING DATA ON FOB BANDAR ABBAS/IRAN BASIS",
                title: "fullArticle8",
                width: "*"
            }
        ]
    })
var article9_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle9_quality",
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
                title: "<strong class='cssDynamicForm'>PAYMENT METHOD</strong>"
            },{
                name: "article9_quality2",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",
                wrap: false,
                title: "<strong class='cssDynamicForm'>PAYMENT PERCENTAGE OF PROFORMA INVOICE PROVISIONAL<strong>"
            },{
                name: "fullArticle9",
                disabled: false,
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "PAYMENT SHALL BE DONE BY TELEGRAPHIC TRANSFER.BUYER SHALL PAY 100% OF PROFORMA INVOICE PROVISIONAL AMOUNT BEFORE EACH SHIPMENT,PROMPT NET CASH PAYABLE BY TELEGRAPHIC TRANSFER IN AED CURRENCY TO A BANK ACCOUNT WHICH IS NOMINATED BY SELLER AFTER LOADING THE CARGO INTO THE CONTAINERS LOCATED IN SELLER 'S CONTAINER 'S YARD AND PRIOR LOADING THE CONTRAINERS ON BOARD OF VESSEL.",
                title: "fullArticle9",
                width: "*"
            }
        ]
    })
var article10_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle10_quality",
        height: "20",
        width: "100%",
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
                title: "<strong class='cssDynamicForm'>PULL DOWN</strong>"
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
                        {fieldName: "contractId", operator: "equals", value: 3},
                        {fieldName:"categoryValue",operator:"equals",value:-2}]
                    },
                title: "<strong class='cssDynamicForm'>BANK REFERENCE</strong>"
             },{
                name: "article10_number58",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: true,
                title: "<strong class='cssDynamicForm'>PULL DOWN</strong>"
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
                        {fieldName: "contractId", operator: "equals", value: 3},
                        {fieldName:"categoryValue",operator:"equals",value:-2}]
                    },
                title: "<strong class='cssDynamicForm'>BANK REFERENCE</strong>"
            },{
                name: "article10_number60",
                width: "150",
                type:"date",
                showTitle: true,
                defaultValue: "",
                startRow: true,
                title: "<strong class='cssDynamicForm'>EXCHANGE RATE DATE</strong>"
            },{
                name: "article10_number61",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                title: "<strong class='cssDynamicForm'>RATE</strong>"
            },{
                name: "fullArticle10",
                disabled: false,
                type: "text",
                length: 5000,
                startRow: true,
                showTitle: false,
                colSpan: 10,
                defaultValue: "ALL THE RELATED INVOICES SHALL BE ISSUDE BASED ON USD BUT AGREED CURRENCY FOR PAYMENT PROCEDURE WILL BE ARD.THE VALUE OF ",
                title: "fullArticle10",
                width: "*"
            }
        ]
    });
var article11_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle11_quality",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle11",
                disabled: false,
                type: "text",
                length: 5000,
                startRow: true,
                showTitle: false,
                colSpan: 10,
                defaultValue: "TITLE:\nLEGAL TITLE OF THE MATERIAL SHALL PASS FROM SELLER TO BUYER OR ITS NOMINATED PARTY FOR EACH SHIPMENT AT EARLIEST MOMENT WHEN PROVISIONAL PAYMENT HAS BEEN RECEIVED.\n RISC: \n RISK OF LOSS SHALL PASS TO BUYER IN ACCORDANCE WITH FOB.(INCOMTERMS 2010).",
                title: "fullArticle11",
                width: "*"
            }
        ]
    })
var article12_quality = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle12_quality",
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
                title: "<strong class='cssDynamicForm'>SHARE OF INSPECTION COST<strong>"
            },{
                name: "fullArticle12",
                disabled: false,
                type: "text",
                defaultValue: "SELLER AND BUYER MUTUALLY APPOINT AN INTERNATIONAL INSPECTION COMPANY AT THE PORT OF LOADING FOR WEIGHING PROCEDURE AND THE COST SHALL BE SHARED MUTUALLY BETWEEN SELLER AND BUYER 50/50. BILL OF LADING SHALL BE ISSUED BASED ON WEIGHT WHICH IS REPORTED BY INTERNATIONAL INSPECTION COMPANY.BUYER CAN ALSO APPOINT ITS REPRESENTATIVE AT BANDAR ABBAS PORT FOR INSPECTION OF WEIGHING AT ITS OWN COST.",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                title: "fullArticle12",
                width: "*"
            }
        ]
    })

    isc.VStack.create({
        ID: "VLayout_PageTwo_Contract",
        width: "100%",
        height: "100%",
        align: "top",
        overflow: "scroll",
        members: [
            lableArticle3Cad,
            article3_quality,
            lableArticle4Cad,
            article4_quality,
            lableArticle5Cad,
            buttonAddItem,
            ListGrid_ContractItemShipment,
            article5_quality,
            lableArticle6Cad,
            article6_quality,
            lableArticle7Cad,
            article7_quality,
            lableArticle8Cad,
            article8_quality,
            lableArticle9Cad,
            article9_quality,
            lableArticle10Cad,
            article10_quality,
            lableArticle11Cad,
            article11_quality,
            lableArticle12Cad,
            article12_quality
        ]
    });


