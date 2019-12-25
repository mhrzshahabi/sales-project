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

var contactCadTabs = isc.TabSet.create({
        width: "100%",
        height: "97%",
        tabs: [
            {
                title: "page1", canClose: false,
                pane: isc.ViewLoader.create({
                    ID: "ViewLoaderpage1",
                    autoDraw: true,
                    viewURL: "<spring:url value="/contact/cadPage1"/>",
                    loadingMessage: "Loading Page.."
                })

            },
            {
                title: "page2", canClose: false,
                pane: isc.ViewLoader.create({
                    ID: "ViewLoaderpage2",
                    autoDraw: true,
                    viewURL: "<spring:url value="/contact/cadPage2"/>",
                    loadingMessage: "Loading Page.."
                })

            }
        ]
    });


    isc.IButton.create({
        ID: "IButton_ContactCad_Save",
        title: "save",
        icon: "[SKIN]/actions/add.png",
        iconOrientation: "right",
        click: function () {
            contactCadHeader.validate();
            dynamicFormCath.validate();
            //DynamicForm_ContactParameter_ValueNumber8.setValue("feild_all_defintitons_save", JSON.stringify(DynamicForm_ContactParameter_ValueNumber8.getValues()));
            var drs = contactCadHeader.getValues().createDateDumy;
            var contractTrueDate = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            contactCadHeader.setValue("contractDate", contractTrueDate);
            var dataSaveAndUpdateContractCad = {};
            dataSaveAndUpdateContractCad.contractDate = contactCadHeader.getValue("createDateDumy");
            dataSaveAndUpdateContractCad.contractNo = contactCadHeader.getValue("contractNo");
            dataSaveAndUpdateContractCad.contactId = contactCadHeader.getValue("contactId");
            dataSaveAndUpdateContractCad.contactByBuyerAgentId = contactCadHeader.getValue("contactByBuyerAgentId");
            dataSaveAndUpdateContractCad.contactBySellerId = contactCadHeader.getValue("contactBySellerId");
            dataSaveAndUpdateContractCad.contactBySellerAgentId = contactCadHeader.getValue("contactBySellerAgentId");
            dataSaveAndUpdateContractCad.amount = valuesManagerArticle2Cad.getValue("amount");
            dataSaveAndUpdateContractCad.amount_en = valuesManagerArticle2Cad.getValue("amount_en");
            dataSaveAndUpdateContractCad.unitId = valuesManagerArticle2Cad.getValue("unitId");
            dataSaveAndUpdateContractCad.molybdenumTolorance = valuesManagerArticle2Cad.getValue("cathodesTolorance");
            dataSaveAndUpdateContractCad.optional = valuesManagerArticle2Cad.getValue("optional");
            dataSaveAndUpdateContractCad.plant = valuesManagerArticle3_quality.getValue("plant");
            dataSaveAndUpdateContractCad.contactInspectionId = 0;
            dataSaveAndUpdateContractCad.molybdenum = 0;
            dataSaveAndUpdateContractCad.copper = valuesManagerArticle4_quality.getValue("article4_quality2");
            dataSaveAndUpdateContractCad.mo_amount = valuesManagerArticle4_quality.getValue("article4_quality1");
            dataSaveAndUpdateContractCad.timeIssuance = "any";
            dataSaveAndUpdateContractCad.prefixPayment = "any";
            dataSaveAndUpdateContractCad.invoiceType = "any";
            dataSaveAndUpdateContractCad.runStartDate = "";
            dataSaveAndUpdateContractCad.runTill = "";
            dataSaveAndUpdateContractCad.runEndtDate = "";
            dataSaveAndUpdateContractCad.incotermsId = 1952;
            dataSaveAndUpdateContractCad.portByPortSourceId = 2;
            dataSaveAndUpdateContractCad.incotermsText = valuesManagerArticle6_quality.getValue("incotermsText");
            dataSaveAndUpdateContractCad.officeSource = "TEHRAN";
            dataSaveAndUpdateContractCad.priceCalPeriod = "any";
            dataSaveAndUpdateContractCad.publishTime = "any";
            dataSaveAndUpdateContractCad.reportTitle = "any";
            dataSaveAndUpdateContractCad.delay = "any";
            dataSaveAndUpdateContractCad.prepaid = "";
            dataSaveAndUpdateContractCad.prepaidCurrency = "any";
            dataSaveAndUpdateContractCad.payTime = "any";
            dataSaveAndUpdateContractCad.pricePeriod = "any";
            dataSaveAndUpdateContractCad.eventPayment = "any";
            dataSaveAndUpdateContractCad.contentType = "any";
            dataSaveAndUpdateContractCad.materialId = dynamicFormCath.getValue("materialId");
////////
        var dataSaveAndUpdateContractCadDetail = {};
        dataSaveAndUpdateContractCadDetail.name_ContactAgentSeller = contactCadHeaderCadAgent.getValue("name_ContactAgentSeller")
        dataSaveAndUpdateContractCadDetail.phone_ContactAgentSeller = contactCadHeaderCadAgent.getValue("phone_ContactAgentSeller")
        dataSaveAndUpdateContractCadDetail.mobile_ContactAgentSeller = contactCadHeaderCadAgent.getValue("mobile_ContactAgentSeller")
        dataSaveAndUpdateContractCadDetail.address_ContactAgentSeller = contactCadHeaderCadAgent.getValue("address_ContactAgentSeller")
        dataSaveAndUpdateContractCadDetail.address_ContactSeller = contactCadHeaderCadAgent.getValue("address_ContactSeller")
        dataSaveAndUpdateContractCadDetail.mobile_ContactSeller = contactCadHeaderCadAgent.getValue("mobile_ContactSeller")
        dataSaveAndUpdateContractCadDetail.phone_ContactSeller = contactCadHeaderCadAgent.getValue("phone_ContactSeller")
        dataSaveAndUpdateContractCadDetail.name_ContactSeller = contactCadHeaderCadAgent.getValue("name_ContactSeller")
        dataSaveAndUpdateContractCadDetail.name_ContactAgentBuyer = contactCadHeaderCadAgent.getValue("name_ContactAgentBuyer")
        dataSaveAndUpdateContractCadDetail.phone_ContactAgentBuyer = contactCadHeaderCadAgent.getValue("phone_ContactAgentBuyer")
        dataSaveAndUpdateContractCadDetail.mobile_ContactAgentBuyer = contactCadHeaderCadAgent.getValue("mobile_ContactAgentBuyer")
        dataSaveAndUpdateContractCadDetail.address_ContactAgentBuyer = contactCadHeaderCadAgent.getValue("address_ContactAgentBuyer")
        dataSaveAndUpdateContractCadDetail.name_ContactBuyer = contactCadHeaderCadAgent.getValue("name_ContactBuyer")
        dataSaveAndUpdateContractCadDetail.phone_ContactBuyer = contactCadHeaderCadAgent.getValue("phone_ContactBuyer")
        dataSaveAndUpdateContractCadDetail.mobile_ContactBuyer = contactCadHeaderCadAgent.getValue("mobile_ContactBuyer")
        dataSaveAndUpdateContractCadDetail.address_ContactBuyer = contactCadHeaderCadAgent.getValue("address_ContactBuyer")
        dataSaveAndUpdateContractCadDetail.article2_13_1 = "";
        dataSaveAndUpdateContractCadDetail.responsibleTelerons = "";
        dataSaveAndUpdateContractCadDetail.article3_number17 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_7 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_8 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_9 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_10 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_11 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_12 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_2 = "";
        dataSaveAndUpdateContractCadDetail.PrefixMolybdenum = "";
        dataSaveAndUpdateContractCadDetail.toleranceMO = "";
        dataSaveAndUpdateContractCadDetail.typical_unitMO = "";
        dataSaveAndUpdateContractCadDetail.PrefixCopper = "";
        dataSaveAndUpdateContractCadDetail.toleranceCU = "";
        dataSaveAndUpdateContractCadDetail.typical_unitCU = "";
        dataSaveAndUpdateContractCadDetail.PrefixC = "";
        dataSaveAndUpdateContractCadDetail.typical_c = 0;
        dataSaveAndUpdateContractCadDetail.toleranceC = "";
        dataSaveAndUpdateContractCadDetail.typical_unitC = "";
        dataSaveAndUpdateContractCadDetail.PrefixS = "";
        dataSaveAndUpdateContractCadDetail.typical_s = 0;
        dataSaveAndUpdateContractCadDetail.toleranceS = "";
        dataSaveAndUpdateContractCadDetail.typical_unitS = "";
        dataSaveAndUpdateContractCadDetail.PrefixPb = "";
        dataSaveAndUpdateContractCadDetail.typical_pb = 0;
        dataSaveAndUpdateContractCadDetail.tolerancePb = "";
        dataSaveAndUpdateContractCadDetail.typical_unitPb = "";
        dataSaveAndUpdateContractCadDetail.PrefixP = "";
        dataSaveAndUpdateContractCadDetail.typical_p = 0;
        dataSaveAndUpdateContractCadDetail.toleranceP = "";
        dataSaveAndUpdateContractCadDetail.typical_unitP = "";
        dataSaveAndUpdateContractCadDetail.PrefixSi = "";
        dataSaveAndUpdateContractCadDetail.typical_Si = 0;
        dataSaveAndUpdateContractCadDetail.toleranceSi = "";
        dataSaveAndUpdateContractCadDetail.typical_unitSi = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_3 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_13 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_4 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_5 = "";
        dataSaveAndUpdateContractCadDetail.article3_number17_6 = "";
        dataSaveAndUpdateContractCadDetail.article4_number18 = "";
        dataSaveAndUpdateContractCadDetail.amount_number19_2 = "";
        dataSaveAndUpdateContractCadDetail.amount_number19_1 = "";
        dataSaveAndUpdateContractCadDetail.shipment_number20 = "";
        dataSaveAndUpdateContractCadDetail.article5_number21_6 = "";
        dataSaveAndUpdateContractCadDetail.article6_number31 = "";
        dataSaveAndUpdateContractCadDetail.article6_number31_1 = "";
        dataSaveAndUpdateContractCadDetail.article6_number32_1 = "";
        dataSaveAndUpdateContractCadDetail.article6_number34 = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized_number36_1 = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized_number33 = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized_number37_1 = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized_number37_2 = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized_number33_1 = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized_number37_3 = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized_number32 = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized_4 = "";
        dataSaveAndUpdateContractCadDetail.article6_Containerized_5 = "";
        dataSaveAndUpdateContractCadDetail.article7_number41 = "";
        dataSaveAndUpdateContractCadDetail.article7_number3 = "";
        dataSaveAndUpdateContractCadDetail.article7_number37 = "";
        dataSaveAndUpdateContractCadDetail.article7_number3_1 = "";
        dataSaveAndUpdateContractCadDetail.article7_number39_1 = "";
        dataSaveAndUpdateContractCadDetail.article7_number40_2 = "";
        dataSaveAndUpdateContractCadDetail.discountValueOne = 0;
        dataSaveAndUpdateContractCadDetail.discountFor = "";
        dataSaveAndUpdateContractCadDetail.discountValueOne_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixOne = "";
        dataSaveAndUpdateContractCadDetail.discountUnitOne = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixOne_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueOne_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueTwo = "";
        dataSaveAndUpdateContractCadDetail.discountValueTwo_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixTwo = "";
        dataSaveAndUpdateContractCadDetail.discountUnitTwo = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixTwo_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueTwo_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueThree = "";
        dataSaveAndUpdateContractCadDetail.discountFor = "";
        dataSaveAndUpdateContractCadDetail.discountValueThree_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixThree = "";
        dataSaveAndUpdateContractCadDetail.discountUnitThree = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixThree_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueThree_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueFour = "";
        dataSaveAndUpdateContractCadDetail.discountValueFour_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountUnitFour = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixFour_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueFour_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueFive = 0;
        dataSaveAndUpdateContractCadDetail.discountFor = "";
        dataSaveAndUpdateContractCadDetail.discountValueFive_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixFive = "";
        dataSaveAndUpdateContractCadDetail.discountUnitFive = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixFive_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueFive_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueSix = 0;
        dataSaveAndUpdateContractCadDetail.discountValueSix_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixSix = "";
        dataSaveAndUpdateContractCadDetail.discountUnitSix = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixSix_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueSix_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueSeven = "";
        dataSaveAndUpdateContractCadDetail.discountValueSeven_1 = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixSeven = "";
        dataSaveAndUpdateContractCadDetail.discountUnitSeven = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixSeven_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueSeven_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueEight = 0;
        dataSaveAndUpdateContractCadDetail.discountValueEight_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixEight = "";
        dataSaveAndUpdateContractCadDetail.discountUnitEight = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixEight_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueEight_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueNine = 0;
        dataSaveAndUpdateContractCadDetail.discountValueNine_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixNine = "";
        dataSaveAndUpdateContractCadDetail.discountUnitNine = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixNine_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueNine_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueTen = 0;
        dataSaveAndUpdateContractCadDetail.discountValueTen_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixTen = "";
        dataSaveAndUpdateContractCadDetail.discountUnitTen = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixTen_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueTen_2 = 0;
        dataSaveAndUpdateContractCadDetail.discountValueEleven = 0;
        dataSaveAndUpdateContractCadDetail.discountValueEleven_1 = 0;
        dataSaveAndUpdateContractCadDetail.discountPerfixEleven = "";
        dataSaveAndUpdateContractCadDetail.discountUnitEleven = "";
        dataSaveAndUpdateContractCadDetail.discountPerfixEleven_1 = "";
        dataSaveAndUpdateContractCadDetail.discountValueEleven_2 = 0;
        dataSaveAndUpdateContractCadDetail.article8_number42 = "";
        dataSaveAndUpdateContractCadDetail.article8_3 = "";
        dataSaveAndUpdateContractCadDetail.article8_value = "";
        dataSaveAndUpdateContractCadDetail.article8_number43 = valuesManagerArticle8_quality.getValue("article8_quality1");
        dataSaveAndUpdateContractCadDetail.article8_number44_1 = valuesManagerArticle8_quality.getValue("article8_quality2");
        dataSaveAndUpdateContractCadDetail.article9_number45 = "";
        dataSaveAndUpdateContractCadDetail.article9_number22 = "";
        dataSaveAndUpdateContractCadDetail.article9_Englishi_number22 = "";
        dataSaveAndUpdateContractCadDetail.article9_number23 = "";
        dataSaveAndUpdateContractCadDetail.article9_number48 = "";
        dataSaveAndUpdateContractCadDetail.article9_number49_1 = "";
        dataSaveAndUpdateContractCadDetail.article9_number51 = "";
        dataSaveAndUpdateContractCadDetail.article9_number54 = "";
        dataSaveAndUpdateContractCadDetail.article9_number54_1 = "";
        dataSaveAndUpdateContractCadDetail.article9_number55 = "";
        dataSaveAndUpdateContractCadDetail.article9_ImportantNote = "";
        dataSaveAndUpdateContractCadDetail.article10_number56 =valuesManagerArticle10_quality.getValue("article10_number56");
        dataSaveAndUpdateContractCadDetail.article10_number57 =valuesManagerArticle10_quality.getValue("article10_number57");
        dataSaveAndUpdateContractCadDetail.article10_number58 =valuesManagerArticle10_quality.getValue("article10_number58");
        dataSaveAndUpdateContractCadDetail.article10_number59 =valuesManagerArticle10_quality.getValue("article10_number59");
        dataSaveAndUpdateContractCadDetail.article10_number60 =valuesManagerArticle10_quality.getValue("article10_number60");
        dataSaveAndUpdateContractCadDetail.article10_number61 =valuesManagerArticle10_quality.getValue("article10_number61");
        recordContractNo=contactCadHeader.getValue("contractNo");
        var criteriaContractNoCad={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName: "material.descl", operator: "contains", value: "Cath"},{fieldName:"contractNo",operator:"equals",value:recordContractNo}]};
        RestDataSource_Contract.fetchData(criteriaContractNoCad,function(dsResponse, data, dsRequest) {
        if(data[0]!=undefined){
                isc.warn("<spring:message code='main.contractsDuplicate'/>");
               }else{
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contract",
                httpMethod: methodHtpp,
                data: JSON.stringify(dataSaveAndUpdateContractCad),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        Window_ContactCad.close();
                        ListGrid_Cad.invalidateCache();
                        saveCotractCadDetails(dataSaveAndUpdateContractCadDetail,(JSON.parse(resp.data)).id);
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }))
            }
            })
        }
    })
    var contactCadFormButtonSaveLayout = isc.HStack.create({
        width: "100%",
        height: "3%",
        align: "center",
        showEdges: true,
        backgroundColor: "#CCFFFF",
        membersMargin: 5,
        layoutMargin: 10,
        members: [
            IButton_ContactCad_Save
        ]
    });

var VLayout_contactCadMain = isc.VLayout.create({
        width: "100%",
        height: "100%",
        align: "center",
        overflow: "scroll",
        autoCenter: true,
        margin: 10,
        isModal: true,
        showModalMask: true,
        autoScroller: true,
        closeClick: function () {
            this.Super("closeClick", arguments);
        },
        members: [
            contactCadTabs,
            contactCadFormButtonSaveLayout
        ]
    })


function saveListGrid_ContractCadItemShipment(contractID) {
        ListGrid_ContractItemShipment.selectAllRecords();
        var data_ContractItemShipment = {};
        var ListGrid_ShipmentItems = [];

        ListGrid_ContractItemShipment.getSelectedRecords().forEach(function(element) {
            var dataEditMain=ListGrid_ContractItemShipment.getSelectedRecord(element)
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
        ListGrid_ContractItemShipment.getAllEditRows().forEach(function (element) {
            var dataEdit=ListGrid_ContractItemShipment.getEditedRecord(element);
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
        ListGrid_ContractItemShipment.deselectAllRecords();
};

    var dataALLArticle = {};
    function saveValueAllArticles(contractID) {

        if(valuesManagerfullArticle.getValue("fullArticle01")==undefined){
          dataALLArticle.Article01="";
        }else{
          dataALLArticle.Article01 = valuesManagerfullArticle.getValue("fullArticle01");
        }

        if(valuesManagerfullArticle.getValue("fullArticle02")==undefined){
          dataALLArticle.Article02="";
        }else{
          dataALLArticle.Article02 = valuesManagerfullArticle.getValue("fullArticle02");
        }

        if(article3_quality.getValue("fullArticle3")==undefined){
          dataALLArticle.Article03="";
        }else{
          dataALLArticle.Article03 = article3_quality.getValue("fullArticle3");
        }

        if(article4_quality.getValue("fullArticle4")==undefined){
          dataALLArticle.Article04="";
        }else{
          dataALLArticle.Article04 = article4_quality.getValue("fullArticle4");
        }

        if(article5_quality.getValue("fullArticle5")==undefined){
          dataALLArticle.Article05="";
        }else{
          dataALLArticle.Article05 = article5_quality.getValue("fullArticle5");
        }

        if(article6_quality.getValue("fullArticle6")==undefined){
          dataALLArticle.Article06="";
        }else{
          dataALLArticle.Article06 = article6_quality.getValue("fullArticle6");
        }

        if(article7_quality.getValue("fullArticle7")==undefined){
          dataALLArticle.Article07="";
        }else{
          dataALLArticle.Article07 = article7_quality.getValue("fullArticle7");
        }

        if(article8_quality.getValue("fullArticle8")==undefined){
          dataALLArticle.Article08="";
        }else{
          dataALLArticle.Article08 = article8_quality.getValue("fullArticle8");
        }

        if(article9_quality.getValue("fullArticle9")==undefined){
          dataALLArticle.Article09="";
        }else{
          dataALLArticle.Article09 = article9_quality.getValue("fullArticle9");
        }

        if(article10_quality.getValue("fullArticle10")==undefined){
          dataALLArticle.Article10="";
        }else{
          dataALLArticle.Article10 = article10_quality.getValue("fullArticle10");
        }

        if(article11_quality.getValue("fullArticle11")==undefined){
          dataALLArticle.Article11="";
        }else{
          dataALLArticle.Article11 = article11_quality.getValue("fullArticle11");
        }

        if(article12_quality.getValue("fullArticle12")==undefined){
          dataALLArticle.Article12="";
        }else{
          dataALLArticle.Article12 = article12_quality.getValue("fullArticle12");
        }
        dataALLArticle.contractNo = contactCadHeader.getValue("contractNo");
        dataALLArticle.contractId = contractID;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/contract/writeWord",
            httpMethod: "POST",
            data: JSON.stringify(dataALLArticle),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>.");
                } else
                    isc.say(RpcResponse_o.data);
            }
        }))
    }

function saveCotractCadDetails(data, contractID) {
        data.contract_id = contractID;
        var allData = data
        allData.string_Currency="null";
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/contractDetail",
            httpMethod: methodHtpp,
            data: JSON.stringify(allData),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    saveListGrid_ContractCadItemShipment(contractID);
                    saveValueAllArticles(contractID);
                } else
                    isc.say(RpcResponse_o.data);
            }
        }))
    }

function clearAdd(){
        contactCadTabs.selectTab(0);
        contactCadHeader.clearValues();
        contactCadHeaderCadAgent.clearValues();
        valuesManagerArticle1.clearValues();
        valuesManagerArticle2Cad.clearValues();
        valuesManagerCadArticle1.clearValues();
        dynamicForm_fullArticle02Cad.clearValues();
        valuesManagerArticle3_quality.clearValues();
        valuesManagerArticle4_quality.clearValues();
        valuesManagerArticle5_quality.clearValues();
        valuesManagerArticle6_quality.clearValues();
        valuesManagerArticle7_quality.clearValues();
        valuesManagerArticle8_quality.clearValues();
        valuesManagerArticle9_quality.clearValues();
        valuesManagerArticle10_quality.clearValues();
        valuesManagerArticle11_quality.clearValues();
        valuesManagerArticle12_quality.clearValues();
}