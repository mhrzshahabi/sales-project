<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

var sendDateSetConc;
var sendDateSetConcSave;
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
                width: "300",
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
                keyPressFilter: "[0-9.]",
                showTitle: false,
                startRow: false,
                width: "100"
            },
            {
                name: "unitCu",
                width: "300",
                showTitle: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "300",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: "295", align: "center"}
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
                keyPressFilter: "[0-9.]",
                showTitle: false,
                startRow: false,
                width: "100"
            },
            {
                name: "unitMo",
                width: "300",
                showTitle: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Unit,
                autoFetchData: false,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "300",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: "295", align: "center"}
                ]
            }
        ]
    })
var dynamicForm_fullArticleConc03 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
                    title: "<spring:message
                    code='shipment.plan'/>",
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
                    valueField: "id",width: "10%", align: "center"
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
                    width: "10%",
                    wrapTitle: false,
                    changed: function (form, item, value) {
                        sendDateSetConc = (value.getFullYear() + "/" + ("0" + (value.getMonth() + 1)).slice(-2) + "/" + ("0" + value.getDate()).slice(-2));
                        sendDateSetConcSave = value;
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
                    type: 'text', width: "10%", align: "center",changed: function (form, item, value) {
                       if(ListGrid_ContractConcItemShipment.getEditRow()==0){
                           valuesManagerArticle5_quality.setValue("fullArticle5",amountSet+"MT"+" "+"+/-"+value+" "+valuesManagerArticle2Conc.getItem("optional").getDisplayValue(valuesManagerArticle2Conc.getValue("optional"))+" "+"PER EACH CALENDER MONTH STARTING FROM"+" "+sendDateSetConc+" "+"TILL");
                        }
                }
                },
            ],saveEdits: function () {
                var ContractItemShipmentRecord = ListGrid_ContractConcItemShipment.getEditedRecord(ListGrid_ContractConcItemShipment.getEditRow());
                if(ListGrid_ContractConcItemShipment.getSelectedRecord() == null){
                        return;
                }else{
                    var dateSend= (ListGrid_ContractConcItemShipment.getSelectedRecord().sendDate);
                    ContractItemShipmentRecord.sendDate=moment(dateSend).format('L')
                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: "${contextPath}/api/contractShipment/",
                        httpMethod: "PUT",
                        data: JSON.stringify(ContractItemShipmentRecord),
                        callback: function (resp) {
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                    ListGrid_ContractConcItemShipment.invalidateCache();
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
                    if (index == 0) {
                                         isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                                actionURL: "${contextPath}/api/contractShipment/" + ContractShipmentId,
                                                httpMethod: "DELETE",
                                                callback: function (resp) {
                                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                                        ListGrid_ContractConcItemShipment.invalidateCache();
                                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                                    } else {
                                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                                    }
                                                }
                                            })
                                        )
                                    }
                    }
            })
        }
    });
var dynamicForm_fullArticleConc04 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
                validators: [
                {
                type:"required",
                validateOnChange: true }],
                type: 'long',
                numCols: 4,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Incoterms_InConc,
                displayField: "code",
                valueField: "id",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "code", width: "495", align: "center"}
                ],
                width: "500",
                title: "<strong class='cssDynamicForm'>SHIPMENT TYPE<strong>"
            } , {
                name: "portByPortSourceId",
                editorType: "SelectItem",
                required: true,
                validators: [
                {
                type:"required",
                validateOnChange: true }],
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
var dynamicForm_fullArticleConc05 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
})

var dynamicForm_fullArticleConc06 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
})

var dynamicForm_fullArticleConc07 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
})

var dynamicForm_fullArticleConc08 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"scroll",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
                keyPressFilter: "[0-9.]"
            },
            {
                name: "RC",
                showTitle: true,
                title:"What is the value of RC",
                startRow: true,
                width: "100",
                keyPressFilter: "[0-9.]",
                textAlign: "left"
            },
        ]
})
var dynamicForm_fullArticleConc09 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
                title: "<strong class='cssDynamicForm'>AVERAGE OF WORKING DAYS OF QUOTATIONAL PERIOD<strong>",
                changed: function (form, item, value) {
                }
            }
        ]
    })

var dynamicForm_fullArticleConc10 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
})

var dynamicForm_fullArticleConc11 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
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
                        {fieldName: "contractId", operator: "equals", value: 2},
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
                        {fieldName: "contractId", operator: "equals", value: 2},
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
            }
        ]
    });

var dynamicForm_fullArticleConc12 = isc.RichTextEditor.create({
            valuesManager: "valuesManagerfullArticle",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
})

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
            dynamicForm_fullArticleConc10,
            lableArticle11,
            dynamicForm_fullArticleConc11,
            lableArticle12,
            article12_qualityConc,
            dynamicForm_fullArticleConc12
        ]
    });


