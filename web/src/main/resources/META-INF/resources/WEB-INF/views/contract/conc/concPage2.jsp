<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

var buttonAddConcItem=isc.IButton.create({
    title: "Add Item Shipment",
    width: 150,
    icon: "[SKIN]/actions/add.png",
    iconOrientation: "right",
    click: "ListGrid_ContractConcItemShipment.startEditingNew()"
})

ListGrid_ContractConcItemShipment = isc.ListGrid.create({
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
                    name: "tblPort.port", title: "<spring:message code='port.port'/>", editorType: "SelectItem",
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
                           valuesManagerArticle5_quality.setValue("fullArticle5",amountSet+"MT"+" "+"+/-"+value+" "+valuesManagerArticle2Cad.getItem("optional").getDisplayValue(valuesManagerArticle2Cad.getValue("optional"))+" "+"PER EACH CALENDER MONTH STARTING FROM"+" "+sendDateSetConc+" "+"TILL");
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
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>.");
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
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            ListGrid_ContractConcItemShipment.invalidateCache();
                            isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                        } else {
                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                        }
                    }
                })
            );
        }
    });


















var article5_ConcDeliveryTerms = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle5_ConcDeliveryTerms",
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
                name: "incotermsId",
                type: "text",
                showTitle: true,
                disabled: true,
                defaultValue: "FOB", ///FOB
                wrap: false,
                width: "500",
                title: "<strong class='cssDynamicForm'>SHIPMENT TYPE<strong>"
            } , {
                name: "portByPortSourceId",
                type: "text",
                showTitle: true,
                disabled: true,
                defaultValue: "BANDAR ABBAS",  //BANDAR ABBAS
                wrap: false,
                width: "500",
                title: "<strong class='cssDynamicForm'>SOURCE PORT</strong>"
            },{
                name: "fullArticle5",
                disabled: false,
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "THE MATERIAL SHALL BE DELIVERED BY SELLER TO BUYER ON FOB BANDAR ABBAS IRAN ON CONTAINERIZED BASIS(INCOTERMS 2010).THE BUYER SHALL PROVIDE THE ACTUAL FREIGHT COST IN EVERY SHIPMENT AS PER ARTICLE5;SHIPMENT,TO THE SELLER.SELLER MUST CONFRIM BUYER'S FREIGHT PRIOR EACH SHIPMENT.BUYER MUST PROVIDE SELLER ALL THE NEEDFULL DOCUMENTS ON SHIPPING LINE LETTER HEAD.",
                title: "fullArticle5",
                width: "*"
            }
        ]
    })
var article6_Insurance = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6_Insurance",
        height: "20",
        width: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "fullArticle6",
                disabled: false,
                type: "text",
                length: 5000,
                showTitle: false,
                colSpan: 2,
                defaultValue: "THE MATERIAL SHALL BE DELIVERED BY SELLER TO BUYER ON FOB BANDAR ABBAS IRAN ON CONTAINERIZED BASIS(INCOTERMS 2010).THE BUYER SHALL PROVIDE THE ACTUAL FREIGHT COST IN EVERY SHIPMENT AS PER ARTICLE5;SHIPMENT,TO THE SELLER.SELLER MUST CONFRIM BUYER'S FREIGHT PRIOR EACH SHIPMENT.BUYER MUST PROVIDE SELLER ALL THE NEEDFULL DOCUMENTS ON SHIPPING LINE LETTER HEAD.",
                title: "fullArticle5",
                width: "*"
            }
        ]
    })



var VLayout_PageTwo_Contract=isc.VLayout.create({
        width: "100%",
        height: "100%",
        align: "top",
        overflow: "scroll",
        members: [
            lableArticle3,
            lableArticle3_1,
            lableArticle4,
            buttonAddConcItem,
            ListGrid_ContractConcItemShipment,
            lableArticle5,
            article5_ConcDeliveryTerms,
            lableArticle6
        ]
    });


