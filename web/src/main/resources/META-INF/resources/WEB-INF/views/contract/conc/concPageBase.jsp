<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>


function factoryLableHedear(id, contents, width, height, padding) {
        isc.Label.create({
            ID: id,
            width: width,
            height: height,
            styleName: "helloWorldText",
            padding: padding,
            backgroundColor: "#84c1ed",
            align: "center",
            valign: "center",
            wrap: false,
            showEdges: true,
            showShadow: true,
            contents: contents
        });
    }

    function factoryLable(id, contents, width, height, padding) {
        isc.Label.create({
            ID: id,
            width: width,
            height: height,
            padding: padding,
            align: "left",
            valign: "left",
            wrap: false,
            contents: contents
        })
    }

    function factoryLableArticle(id, contents, height, padding) {
        isc.Label.create({
            ID: id,
            height: height,
            padding: padding,
            align: "left",
            valign: "left",
            wrap: false,
            contents: contents
        })
    }

var contactConcTabs = isc.TabSet.create({
        width: "100%",
        height: "97%",
        tabs: [
            {
                title: "page1", canClose: false,
                pane: isc.ViewLoader.create({
                                    ID: "ViewLoaderpage1",
                                    autoDraw:true,
                                    viewURL:"<spring:url value="/contact/concPage1" />",
                                    loadingMessage:"Loading Page1.."
                                    })
            },
            {
                title: "page2", canClose: false,
                pane: isc.ViewLoader.create({
                                    ID: "ViewLoaderpage2",
                                    autoDraw:true,
                                    viewURL:"<spring:url value="/contact/concPage2" />",
                                    loadingMessage:"Loading Page2.."
                                    })
            }
        ]
    });

var IButton_ContactConc_Save = isc.IButton.create({
    title: "save",
    icon: "pieces/16/save.png",
    iconOrientation: "right",
    click: function(){
            contactHeaderConc.validate();
            dynamicFormConc.validate();
            var drs = contactHeaderConc.getValues().createDateDumy;
            var contractTrueDate = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            contactHeaderConc.setValue("contractDate", contractTrueDate);
            var dataSaveAndUpdateContractConc = {};
            dataSaveAndUpdateContractConc.contractDate = contactHeaderConc.getValue("createDateDumy");
            dataSaveAndUpdateContractConc.contractNo = contactHeaderConc.getValue("contractNo");
            dataSaveAndUpdateContractConc.contactId = contactHeaderConc.getValue("contactId");
            dataSaveAndUpdateContractConc.contactByBuyerAgentId = contactHeaderConc.getValue("contactByBuyerAgentId");
            dataSaveAndUpdateContractConc.contactBySellerId = contactHeaderConc.getValue("contactBySellerId");
            dataSaveAndUpdateContractConc.contactBySellerAgentId = contactHeaderConc.getValue("contactBySellerAgentId");
            dataSaveAndUpdateContractConc.amount = valuesManagerArticle2Conc.getValue("amount");
            dataSaveAndUpdateContractConc.amount_en = valuesManagerArticle2Conc.getValue("amount_en");
            dataSaveAndUpdateContractConc.unitId = valuesManagerArticle2Conc.getValue("unitId");
            dataSaveAndUpdateContractConc.molybdenumTolorance = valuesManagerArticle2Conc.getValue("cathodesTolorance");
            dataSaveAndUpdateContractConc.optional = valuesManagerArticle2Conc.getValue("optional");
            dataSaveAndUpdateContractConc.plant = valuesManagerArticle2Conc.getValue("plant");
            dataSaveAndUpdateContractConc.contactInspectionId = 0;
            dataSaveAndUpdateContractConc.molybdenum = valuesManagerArticle3_conc.getValue("MO");
            dataSaveAndUpdateContractConc.copper = valuesManagerArticle3_conc.getValue("CU");
            dataSaveAndUpdateContractConc.mo_amount = 0;
            dataSaveAndUpdateContractConc.timeIssuance = valuesManagerArticle3_conc.getValue("unitCu");  ///unit1
            dataSaveAndUpdateContractConc.prefixPayment = valuesManagerArticle3_conc.getValue("unitMo"); ///unit2
            dataSaveAndUpdateContractConc.invoiceType = "any";
            dataSaveAndUpdateContractConc.runStartDate = "";
            dataSaveAndUpdateContractConc.runTill = "";
            dataSaveAndUpdateContractConc.runEndtDate = "";
            dataSaveAndUpdateContractConc.incotermsId = 1952;
            dataSaveAndUpdateContractConc.portByPortSourceId = 2;
            dataSaveAndUpdateContractConc.incotermsText = valuesManagerArticle5_DeliveryTermsConc.getValue("incotermsText");
            dataSaveAndUpdateContractConc.officeSource = "TEHRAN";
            dataSaveAndUpdateContractConc.priceCalPeriod = "any";
            dataSaveAndUpdateContractConc.publishTime = "any";
            dataSaveAndUpdateContractConc.reportTitle = "any";
            dataSaveAndUpdateContractConc.delay = "any";
            dataSaveAndUpdateContractConc.prepaid = "";
            dataSaveAndUpdateContractConc.prepaidCurrency = "any";
            dataSaveAndUpdateContractConc.payTime = "any";
            dataSaveAndUpdateContractConc.pricePeriod = "any";
            dataSaveAndUpdateContractConc.eventPayment = "any";
            dataSaveAndUpdateContractConc.contentType = "any";
            dataSaveAndUpdateContractConc.materialId = dynamicFormConc.getValue("materialId");
            dataSaveAndUpdateContractConc.treatCost = valuesManagerArticle9_conc.getValue("TC");
            dataSaveAndUpdateContractConc.refinaryCost = valuesManagerArticle9_conc.getValue("RC");

var dataSaveAndUpdateContractConcDetail = {};

        dataSaveAndUpdateContractConcDetail.name_ContactAgentSeller = contactHeaderConcAgent.getValue("name_ContactAgentSeller")
        dataSaveAndUpdateContractConcDetail.phone_ContactAgentSeller = contactHeaderConcAgent.getValue("phone_ContactAgentSeller")
        dataSaveAndUpdateContractConcDetail.mobile_ContactAgentSeller = contactHeaderConcAgent.getValue("mobile_ContactAgentSeller")
        dataSaveAndUpdateContractConcDetail.address_ContactAgentSeller = contactHeaderConcAgent.getValue("address_ContactAgentSeller")
        dataSaveAndUpdateContractConcDetail.address_ContactSeller = contactHeaderConcAgent.getValue("address_ContactSeller")
        dataSaveAndUpdateContractConcDetail.mobile_ContactSeller = contactHeaderConcAgent.getValue("mobile_ContactSeller")
        dataSaveAndUpdateContractConcDetail.phone_ContactSeller = contactHeaderConcAgent.getValue("phone_ContactSeller")
        dataSaveAndUpdateContractConcDetail.name_ContactSeller = contactHeaderConcAgent.getValue("name_ContactSeller")
        dataSaveAndUpdateContractConcDetail.name_ContactAgentBuyer = contactHeaderConcAgent.getValue("name_ContactAgentBuyer")
        dataSaveAndUpdateContractConcDetail.phone_ContactAgentBuyer = contactHeaderConcAgent.getValue("phone_ContactAgentBuyer")
        dataSaveAndUpdateContractConcDetail.mobile_ContactAgentBuyer = contactHeaderConcAgent.getValue("mobile_ContactAgentBuyer")
        dataSaveAndUpdateContractConcDetail.address_ContactAgentBuyer = contactHeaderConcAgent.getValue("address_ContactAgentBuyer")
        dataSaveAndUpdateContractConcDetail.name_ContactBuyer = contactHeaderConcAgent.getValue("name_ContactBuyer")
        dataSaveAndUpdateContractConcDetail.phone_ContactBuyer = contactHeaderConcAgent.getValue("phone_ContactBuyer")
        dataSaveAndUpdateContractConcDetail.mobile_ContactBuyer = contactHeaderConcAgent.getValue("mobile_ContactBuyer")
        dataSaveAndUpdateContractConcDetail.address_ContactBuyer = contactHeaderConcAgent.getValue("address_ContactBuyer")
        dataSaveAndUpdateContractConcDetail.article2_13_1 = "";
        dataSaveAndUpdateContractConcDetail.responsibleTelerons = "";
        dataSaveAndUpdateContractConcDetail.article3_number17 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_7 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_8 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_9 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_10 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_11 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_12 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_2 = "";
        dataSaveAndUpdateContractConcDetail.PrefixMolybdenum = "";
        dataSaveAndUpdateContractConcDetail.toleranceMO = "";
        dataSaveAndUpdateContractConcDetail.typical_unitMO = "";
        dataSaveAndUpdateContractConcDetail.PrefixCopper = "";
        dataSaveAndUpdateContractConcDetail.toleranceCU = "";
        dataSaveAndUpdateContractConcDetail.typical_unitCU = "";
        dataSaveAndUpdateContractConcDetail.PrefixC = "";
        dataSaveAndUpdateContractConcDetail.typical_c = 0;
        dataSaveAndUpdateContractConcDetail.toleranceC = "";
        dataSaveAndUpdateContractConcDetail.typical_unitC = "";
        dataSaveAndUpdateContractConcDetail.PrefixS = "";
        dataSaveAndUpdateContractConcDetail.typical_s = 0;
        dataSaveAndUpdateContractConcDetail.toleranceS = "";
        dataSaveAndUpdateContractConcDetail.typical_unitS = "";
        dataSaveAndUpdateContractConcDetail.PrefixPb = "";
        dataSaveAndUpdateContractConcDetail.typical_pb = 0;
        dataSaveAndUpdateContractConcDetail.tolerancePb = "";
        dataSaveAndUpdateContractConcDetail.typical_unitPb = "";
        dataSaveAndUpdateContractConcDetail.PrefixP = "";
        dataSaveAndUpdateContractConcDetail.typical_p = 0;
        dataSaveAndUpdateContractConcDetail.toleranceP = "";
        dataSaveAndUpdateContractConcDetail.typical_unitP = "";
        dataSaveAndUpdateContractConcDetail.PrefixSi = "";
        dataSaveAndUpdateContractConcDetail.typical_Si = 0;
        dataSaveAndUpdateContractConcDetail.toleranceSi = "";
        dataSaveAndUpdateContractConcDetail.typical_unitSi = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_3 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_13 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_4 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_5 = "";
        dataSaveAndUpdateContractConcDetail.article3_number17_6 = "";
        dataSaveAndUpdateContractConcDetail.article4_number18 = "";
        dataSaveAndUpdateContractConcDetail.amount_number19_2 = "";
        dataSaveAndUpdateContractConcDetail.amount_number19_1 = "";
        dataSaveAndUpdateContractConcDetail.shipment_number20 = "";
        dataSaveAndUpdateContractConcDetail.article5_number21_6 = "";
        dataSaveAndUpdateContractConcDetail.article6_number31 = "";
        dataSaveAndUpdateContractConcDetail.article6_number31_1 = "";
        dataSaveAndUpdateContractConcDetail.article6_number32_1 = "";
        dataSaveAndUpdateContractConcDetail.article6_number34 = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized_number36_1 = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized_number33 = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized_number37_1 = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized_number37_2 = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized_number33_1 = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized_number37_3 = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized_number32 = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized_4 = "";
        dataSaveAndUpdateContractConcDetail.article6_Containerized_5 = "";
        dataSaveAndUpdateContractConcDetail.article7_number41 = "";
        dataSaveAndUpdateContractConcDetail.article7_number3 = "";
        dataSaveAndUpdateContractConcDetail.article7_number37 = "";
        dataSaveAndUpdateContractConcDetail.article7_number3_1 = "";
        dataSaveAndUpdateContractConcDetail.article7_number39_1 = "";
        dataSaveAndUpdateContractConcDetail.article7_number40_2 = "";
        dataSaveAndUpdateContractConcDetail.discountValueOne = 0;
        dataSaveAndUpdateContractConcDetail.discountFor = "";
        dataSaveAndUpdateContractConcDetail.discountValueOne_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixOne = "";
        dataSaveAndUpdateContractConcDetail.discountUnitOne = valuesManagerArticle3_conc.getValue("unitCu");
        dataSaveAndUpdateContractConcDetail.discountPerfixOne_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueOne_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueTwo = "";
        dataSaveAndUpdateContractConcDetail.discountValueTwo_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixTwo = "";
        dataSaveAndUpdateContractConcDetail.discountUnitTwo = valuesManagerArticle3_conc.getValue("unitMo");
        dataSaveAndUpdateContractConcDetail.discountPerfixTwo_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueTwo_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueThree = "";
        dataSaveAndUpdateContractConcDetail.discountFor = "";
        dataSaveAndUpdateContractConcDetail.discountValueThree_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixThree = "";
        dataSaveAndUpdateContractConcDetail.discountUnitThree = "";
        dataSaveAndUpdateContractConcDetail.discountPerfixThree_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueThree_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueFour = "";
        dataSaveAndUpdateContractConcDetail.discountValueFour_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountUnitFour = "";
        dataSaveAndUpdateContractConcDetail.discountPerfixFour_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueFour_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueFive = 0;
        dataSaveAndUpdateContractConcDetail.discountFor = "";
        dataSaveAndUpdateContractConcDetail.discountValueFive_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixFive = "";
        dataSaveAndUpdateContractConcDetail.discountUnitFive = "";
        dataSaveAndUpdateContractConcDetail.discountPerfixFive_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueFive_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueSix = 0;
        dataSaveAndUpdateContractConcDetail.discountValueSix_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixSix = "";
        dataSaveAndUpdateContractConcDetail.discountUnitSix = "";
        dataSaveAndUpdateContractConcDetail.discountPerfixSix_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueSix_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueSeven = "";
        dataSaveAndUpdateContractConcDetail.discountValueSeven_1 = "";
        dataSaveAndUpdateContractConcDetail.discountPerfixSeven = "";
        dataSaveAndUpdateContractConcDetail.discountUnitSeven = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixSeven_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueSeven_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueEight = 0;
        dataSaveAndUpdateContractConcDetail.discountValueEight_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixEight = "";
        dataSaveAndUpdateContractConcDetail.discountUnitEight = "";
        dataSaveAndUpdateContractConcDetail.discountPerfixEight_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueEight_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueNine = 0;
        dataSaveAndUpdateContractConcDetail.discountValueNine_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixNine = "";
        dataSaveAndUpdateContractConcDetail.discountUnitNine = "";
        dataSaveAndUpdateContractConcDetail.discountPerfixNine_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueNine_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueTen = 0;
        dataSaveAndUpdateContractConcDetail.discountValueTen_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixTen = "";
        dataSaveAndUpdateContractConcDetail.discountUnitTen = "";
        dataSaveAndUpdateContractConcDetail.discountPerfixTen_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueTen_2 = 0;
        dataSaveAndUpdateContractConcDetail.discountValueEleven = 0;
        dataSaveAndUpdateContractConcDetail.discountValueEleven_1 = 0;
        dataSaveAndUpdateContractConcDetail.discountPerfixEleven = "";
        dataSaveAndUpdateContractConcDetail.discountUnitEleven = "";
        dataSaveAndUpdateContractConcDetail.discountPerfixEleven_1 = "";
        dataSaveAndUpdateContractConcDetail.discountValueEleven_2 = 0;
        dataSaveAndUpdateContractConcDetail.article8_number42 = "";
        dataSaveAndUpdateContractConcDetail.article8_3 = "";
        dataSaveAndUpdateContractConcDetail.article8_value = "";
        dataSaveAndUpdateContractConcDetail.article8_number43 = "";
        dataSaveAndUpdateContractConcDetail.article8_number44_1 = "";
        dataSaveAndUpdateContractConcDetail.article9_number45 = "";
        dataSaveAndUpdateContractConcDetail.article9_number22 = "";
        dataSaveAndUpdateContractConcDetail.article9_Englishi_number22 = "";
        dataSaveAndUpdateContractConcDetail.article9_number23 = "";
        dataSaveAndUpdateContractConcDetail.article9_number48 = "";
        dataSaveAndUpdateContractConcDetail.article9_number49_1 = "";
        dataSaveAndUpdateContractConcDetail.article9_number51 = "";
        dataSaveAndUpdateContractConcDetail.article9_number54 = "";
        dataSaveAndUpdateContractConcDetail.article9_number54_1 = "";
        dataSaveAndUpdateContractConcDetail.article9_number55 = "";
        dataSaveAndUpdateContractConcDetail.article9_ImportantNote = valuesManagerArticle10_quality.getValue("article10_quality1");
        dataSaveAndUpdateContractConcDetail.article10_number56 =valuesManagerArticle12_quality.getValue("article12_number56");
        dataSaveAndUpdateContractConcDetail.article10_number57 =valuesManagerArticle12_quality.getValue("article12_number57");
        dataSaveAndUpdateContractConcDetail.article10_number58 =valuesManagerArticle12_quality.getValue("article12_number58");
        dataSaveAndUpdateContractConcDetail.article10_number59 =valuesManagerArticle12_quality.getValue("article12_number59");
        dataSaveAndUpdateContractConcDetail.article10_number60 =valuesManagerArticle12_quality.getValue("article12_number60");
        dataSaveAndUpdateContractConcDetail.article10_number61 =valuesManagerArticle12_quality.getValue("article12_number61");
        recordContractNoConc=contactHeaderConc.getValue("contractNo");
        var criteriaContractNoConc={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"materialId",operator:"equals",value:-42},{fieldName:"contractNo",operator:"equals",value:recordContractNoConc}]};
        RestDataSource_Contract.fetchData(criteriaContractNoConc,function(dsResponse, data, dsRequest) {
        if(data[0]!=undefined){
                isc.warn("<spring:message code='main.contractsDuplicate'/>");
               }else{
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contract",
                httpMethod: "POST",
                data: JSON.stringify(dataSaveAndUpdateContractConc),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        Window_ContactConc.close();
                        ListGrid_Conc.invalidateCache();
                        saveCotractConcDetails(dataSaveAndUpdateContractConcDetail,(JSON.parse(resp.data)).id);
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }))
            }
            })
        }
})

var contactFormButtonSaveLayout = isc.HStack.create({
        width: "100%",
        height: "3%",
        align: "center",
        showEdges: true,
        backgroundColor: "#CCFFFF",
        membersMargin: 5,
        layoutMargin: 10,
        members: [
            IButton_ContactConc_Save
        ]
    });

VLayout_contactMain=isc.VLayout.create({
            width: "100%",
            height: "100%",
            align: "center",
            overflow: "scroll",
            autoCenter: true,
            isModal: true,
            showModalMask: true,
            autoScroller:true,
            closeClick: function () {
            this.Super("closeClick", arguments);
            },
            members: [
                contactConcTabs,
                contactFormButtonSaveLayout
            ]
            })

function saveCotractConcDetails(data, contractID) {
        data.contract_id = contractID;
        data.feild_all_defintitons_save = "";
        data.string_Currency="";
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/contractDetail",
            httpMethod: "POST",
            data: JSON.stringify(data),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    saveListGrid_ContractConcItemShipment(contractID);
                    saveValueAllArticlesConc(contractID);
                } else
                    isc.say(RpcResponse_o.data);
            }
        }))
    }

function saveListGrid_ContractConcItemShipment(contractID) {
        ListGrid_ContractConcItemShipment.selectAllRecords();
        ListGrid_ContractConcItemShipment.getSelectedRecords().forEach(function(element) {
            var dataEditMain=ListGrid_ContractConcItemShipment.getSelectedRecord(element)
            dataEditMain.contractId=contractID;
            dataEditMain.dischargeId = 11022;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contractShipment/",
                httpMethod: "POST",
                data: JSON.stringify(dataEditMain),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }))
            });
    ListGrid_ContractConcItemShipment.getAllEditRows().forEach(function (element) {
            var dataEdit=ListGrid_ContractConcItemShipment.getEditedRecord(element);
            dataEdit.contractId=contractID;
            dataEdit.dischargeId = 11022;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contractShipment/",
                httpMethod: "POST",
                data: JSON.stringify(dataEdit),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }))
        })
ListGrid_ContractConcItemShipment.deselectAllRecords();
};

var dataALLArticleConc = {};
    function saveValueAllArticlesConc(contractID) {
        dataALLArticleConc.Article01 = valuesManagerfullArticle.getValue("fullArticle01");
        dataALLArticleConc.Article02 = valuesManagerfullArticle.getValue("fullArticle02");
        dataALLArticleConc.Article03 = valuesManagerfullArticle.getValue("fullArticle03");
        dataALLArticleConc.Article04 = valuesManagerfullArticle.getValue("fullArticle04");
        dataALLArticleConc.Article05 = valuesManagerfullArticle.getValue("fullArticle05");
        dataALLArticleConc.Article06 = valuesManagerfullArticle.getValue("fullArticle06");
        dataALLArticleConc.Article07 = valuesManagerfullArticle.getValue("fullArticle07");
        dataALLArticleConc.Article08 = valuesManagerfullArticle.getValue("fullArticle08");
        dataALLArticleConc.Article09 = valuesManagerfullArticle.getValue("fullArticle09");
        dataALLArticleConc.Article10 = valuesManagerArticle10_quality.getValue("fullArticle10");
        dataALLArticleConc.Article11 = valuesManagerfullArticle.getValue("fullArticle11");
        dataALLArticleConc.Article12 = valuesManagerArticle12_quality.getValue("fullArticle12");
        dataALLArticleConc.contractNo = contactHeaderConc.getValue("contractNo")+"_Conc";
        dataALLArticleConc.contractId = contractID;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/contract/writeWord",
            httpMethod: "POST",
            data: JSON.stringify(dataALLArticleConc),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>.");
                } else
                    isc.say(RpcResponse_o.data);
            }
        }))
}



function clearAdd(){
        contactConcTabs.selectTab(0);
        contactHeaderConc.clearValues();
        contactHeaderConcAgent.clearValues();
        valuesManagerConcArticle1.clearValues();
        valuesManagerArticle2Conc.clearValues();
        valuesManagerfullArticle.clearValues();
}