<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>



//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

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
                        fullArticle3.setValue("NICICO ELECTROLYTIC COPPER CATHODES GRANDE A PRODUCED IN"+" "+value);
                }
            }
        ]
    })
var fullArticle3 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerArticle3_quality",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
                        fullArticle4.setValue("IN BUNDLES OF "+" "+value+" "+" METRIC TONS FOR ELECTROLYTIC COPPER CATHODES AND "+" "+article4_quality.getValue("article4_quality2")+" "+" METRIC TONS FOR(SXEW),EACH STARAPPED FOR SAFE OCEAN TRANSPORTATION");
                }
            }
            , {
                name: "article4_quality2",
                type: "text",
                showTitle: true,
                wrap: false,
                width: "500",
                title: "<strong class='cssDynamicForm'>BUNDELS TONNAGE IN MT FOR SXEW</strong>",changed: function (form, item, value) {
                        fullArticle4.setValue("IN BUNDLES OF "+" "+article4_quality.getValue("article4_quality1")+" "+" METRIC TONS FOR ELECTROLYTIC COPPER CATHODES AND "+" "+value+" "+" METRIC TONS FOR(SXEW),EACH STARAPPED FOR SAFE OCEAN TRANSPORTATION");
                }
            }
        ]
    })
var fullArticle4 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
})

var buttonAddItem=isc.IButton.create({
    title: "Add Item Shipment",
    width: 150,
    icon: "[SKIN]/actions/add.png",
    iconOrientation: "right",
    click: "ListGrid_ContractItemShipment.startEditingNew()"
});

    ListGrid_ContractItemShipment = isc.ListGrid.create({
        width: "100%",
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
                    title: "<spring:message code='shipment.plan'/>",
                    type: 'text',
                    width: "10%",
                    valueMap: {"A": "plan A", "B": "plan B", "C": "plan C",},
                    align: "center"
                },
                {
                    name: "shipmentRow",
                    title: "<spring:message code='contractItem.itemRow'/> ",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "dischargeId", title: "<spring:message code='port.port'/>", editorType: "SelectItem",
                    optionDataSource: RestDataSource_Port,
                    displayField: "port",
                    valueField: "id", width: "10%", align: "center"
                },
                {
                    name: "address",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float',
                    width: "10%",
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
                    width: "10%",
                    wrapTitle: false,changed: function (form, item, value) {
                        sendDateSet = (value.getFullYear() + "/" + ("0" + (value.getMonth() + 1)).slice(-2) + "/" + ("0" + value.getDate()).slice(-2));
                    }
                },
                {
                    name: "duration",
                    title: "<spring:message code='global.duration'/>",
                    type : 'text',
                    width: "10%",
                    align: "center"
                },
                {
                name: "tolorance", title: "<spring:message code='contractItemShipment.tolorance'/>",
                    type: 'text',width: "10%", align: "center",changed: function (form, item, value) {
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
                     var dateSendCad= (ListGrid_ContractItemShipment.getSelectedRecord().sendDate);
                     ContractItemShipmentRecord.sendDate=moment(dateSendCad).format('L')
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
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index === 0) {
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
                    }
            })
        }
    });

var article5_quality = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
        ]
    });

var fullArticle6 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
                        fullArticle7.setValue("THE PRICE PER METRIC TON OF THE MATERIAL SHALL BE THE OFFICIAL "+" "+value+" "+" CASH SETTLEMENT PRICE FOR COPPER GRADE 'A' IN USD AS PUBLISHED IN THE LONDOM METAL BULLETIN AVERAGED OVER THE QUOTATIONAL PERIOD I.E."+" "+value+" "+" FLAT FOB BANDAR ABBAS/IRAN BASIS.");
                }
            }
        ]
    });

var fullArticle7 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
                        fullArticle8.setValue("THE QUOTATIONAL PERIOD SHALL BE AVERAGE OF "+" "+value+" "+" WORKING DAYS FROM "+" "+article8_quality.getValue("article8_quality2")+" "+" LME WORKING DAYS PRIOR DATE OF BILL OF LADING TILL "+" "+article8_quality.getValue("article8_quality3")+" "+" LME WORKING DAYS AFTER BILL OF LADING DATA ON FOB BANDAR ABBAS/IRAN BASIS");
                }
            },{
                name: "article8_quality2",
                type: "text",
                showTitle: true,
                defaultValue: "",
                width: "500",    //5
                wrap: false,
                title: "<strong class='cssDynamicForm'>NUMBER OF DAYS BEFORE BL</strong>",changed: function (form, item, value) {
                        fullArticle8.setValue("THE QUOTATIONAL PERIOD SHALL BE AVERAGE OF "+" "+article8_quality.getValue("article8_quality1")+" "+" WORKING DAYS FROM "+" "+value+" "+" LME WORKING DAYS PRIOR DATE OF BILL OF LADING TILL "+" "+article8_quality.getValue("article8_quality3")+" "+" LME WORKING DAYS AFTER BILL OF LADING DATA ON FOB BANDAR ABBAS/IRAN BASIS");
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
            }
        ]
    });

var fullArticle8 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"scroll",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
            }
        ]
    })

var fullArticle9 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
                width: "700",
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
                    {name: "paramName", title:"<spring:message code='parameters.paramName'/>", width: "20%", align: "center"},
                    {name: "paramType", title:"<spring:message code='parameters.paramType'/>", width: "20%", align: "center"},
                    {name: "paramValue", title:"<spring:message code='parameters.paramValue'/>", width: "60%", align: "center"}
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
                width: "700",
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
                    {name: "paramName", title:"<spring:message code='parameters.paramName'/>", width: "20%", align: "center"},
                    {name: "paramType", title:"<spring:message code='parameters.paramType'/>", width: "20%", align: "center"},
                    {name: "paramValue", title:"<spring:message code='parameters.paramValue'/>", width: "60%", align: "center"}
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
            }
        ]
    });

var fullArticle10 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
})

var article11_quality = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
            }
        ]
    })

var fullArticle12 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
            fullArticle3,
            lableArticle4Cad,
            article4_quality,
            fullArticle4,
            lableArticle5Cad,
            buttonAddItem,
            ListGrid_ContractItemShipment,
            article5_quality,
            lableArticle6Cad,
            article6_quality,
            fullArticle6,
            lableArticle7Cad,
            article7_quality,
            fullArticle7,
            lableArticle8Cad,
            article8_quality,
            fullArticle8,
            lableArticle9Cad,
            article9_quality,
            fullArticle9,
            lableArticle10Cad,
            article10_quality,
            fullArticle10,
            lableArticle11Cad,
            article11_quality,
            lableArticle12Cad,
            article12_quality,
            fullArticle12
        ]
    });


