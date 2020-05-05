<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    function factoryLableHedear(id, contents, width, height, padding) {
        isc.Label.create({
            ID: id,
            width: width,
            height: height,
            styleName: "helloWorldText",
            padding: padding,
            //backgroundColor: "#84c1ed",
            align: "center",
            valign: "center",
            wrap: false,
            //showEdges: true,
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
                    ID: "ViewLoaderpageCad1",
                    autoDraw: true,
                    viewURL: "<spring:url value="/contact/cadPage1"/>",
                    loadingMessage: "Loading Page.."
                })

            },
            {
                title: "page2", canClose: false,
                pane: isc.ViewLoader.create({
                    ID: "ViewLoaderpageCad2",
                    autoDraw: true,
                    viewURL: "<spring:url value="/contact/cadPage2"/>",
                    loadingMessage: "Loading Page.."
                })

            }
        ]
    });


    var IButton_ContactCad_Save = isc.IButtonSave.create({
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        iconOrientation: "right",
        click: function () {
            ListGrid_ContractItemShipment.getAllEditRows().forEach(function (element) {
            if(ListGrid_ContractItemShipment.validateRow(element) != true){
                    ListGrid_ContractItemShipment.validateRow(element);
                    isc.warn("<spring:message code='main.contractShipment'/>");
                    return;
                    }
                 })
            var dataSaveAndUpdateContractCad = {};
            var dataSaveAndUpdateContractCadDetail = {};
            contactCadHeader.validate();
            valuesManagerArticle6_quality.validate();



            if (valuesManagerArticle6_quality.hasErrors()){
                contactCadTabs.selectTab(1);
                return;
            }
            if(methodHtpp == "PUT"){
               dataSaveAndUpdateContractCad.id=ListGrid_Cad.getSelectedRecord().id;
               var criteriaCadDetail = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{
                        fieldName: "contract.id",
                        operator: "equals",
                        value: ListGrid_Cad.getSelectedRecord().id
                    }]
                };
                RestDataSource_contractDetail_list.fetchData(criteriaCadDetail, function (dsResponse, data, dsRequest) {
                    dataSaveAndUpdateContractCadDetail.id = data[0].id;
                });
                ListGrid_Cad.invalidateCache();
            }
            recordContractNoCad=contactCadHeader.getValue("contractNo");
            var criteriaContractNoCad={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"materialId",operator:"equals",value:2},{fieldName:"contractNo",operator:"equals",value:recordContractNoCad}]};
            RestDataSource_Contract.fetchData(criteriaContractNoCad,function(dsResponse, data, dsRequest) {
                if(methodHtpp == "POST" && data[0]!=undefined){
                isc.warn("<spring:message code='main.contractsDuplicate'/>");
                }else{
                contactCadHeader.setValue("contractDate",contactCadHeader.getValues().createDate.toNormalDate("toUSShortDate"));
                dataSaveAndUpdateContractCad.contractDate = contactCadHeader.getValue("contractDate");
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
                dataSaveAndUpdateContractCad.incotermsId = valuesManagerArticle6_quality.getValue("incotermsId");
                dataSaveAndUpdateContractCad.portByPortSourceId = valuesManagerArticle6_quality.getValue("portByPortSourceId");
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
                //dataSaveAndUpdateContractCad.materialId = dynamicFormCath.getValue("materialId");
                dataSaveAndUpdateContractCad.materialId = 2;
        ////////
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
                dataSaveAndUpdateContractCad.contractDetails = dataSaveAndUpdateContractCadDetail;
                dataSaveAndUpdateContractCad.contractShipments = saveListGrid_ContractCadItemShipment();
                recordContractNo = contactCadHeader.getValue("contractNo");
                var criteriaContractNoCad={
                    _constructor:"AdvancedCriteria",
                    operator:"and",
                    criteria:[{fieldName: "materialId",
                    operator: "equals", value: 2},
                    {fieldName:"contractNo",operator:"equals",value:recordContractNo}]};
                    RestDataSource_Contract.fetchData(criteriaContractNoCad,function(dsResponse, data, dsRequest) {
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                        actionURL: "${contextPath}/api/contract",
                        httpMethod: methodHtpp,
                        data: JSON.stringify(dataSaveAndUpdateContractCad),
                        callback: function (resp) {
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                Window_ContactCad.close();
                                ListGrid_Cad.invalidateCache();
                                saveValueAllArticles((JSON.parse(resp.data)).id);
                            } else
                                isc.say(RpcResponse_o.data);
                        }
                    }))
                    })
                            }
                    })
        }
    })
    var contactCadFormButtonSaveLayout = isc.HStack.create({
        width: "100%",
        height: "3%",
        align: "center",
       // showEdges: true,
        //backgroundColor: "#CCFFFF",
        membersMargin: 5,
        layoutMargin: 10,
        members: [
            IButton_ContactCad_Save,
            isc.IButtonCancel.create({
                title: "<spring:message code='global.cancel'/>",
                width: 100,
                icon: "pieces/16/icon_delete.png",
                orientation: "vertical",
                click: function () {
                Window_ContactCad.close();
                }
                })
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

function saveListGrid_ContractCadItemShipment() {
        ListGrid_ContractItemShipment.selectAllRecords();
        var dataEdit = [];
        ListGrid_ContractItemShipment.getAllEditRows().forEach(function (element) {
            dataEdit.push(ListGrid_ContractItemShipment.getEditedRecord(element));
            ListGrid_ContractItemShipment.deselectRecord(ListGrid_ContractItemShipment.getRecord(element));
        });
        ListGrid_ContractItemShipment.getSelectedRecords().forEach(function (element) {
            dataEdit.push(JSON.parse(JSON.stringify(element)));
        });
        ListGrid_ContractItemShipment.deselectAllRecords();
        dataEdit[dataEdit.length - 1].sendDate = sendDateSet;
        return dataEdit;
    };

    var dataALLArticle = {};
    function saveValueAllArticles(contractID) {
        dataALLArticle.Article01 = nvlCad(dynamicFormCad_fullArticle01.getValue());
        dataALLArticle.Article02 = nvlCad(dynamicForm_fullArticle02Cad.getValue());
        dataALLArticle.Article03 = nvlCad(fullArticle3.getValue());
        dataALLArticle.Article04 = nvlCad(fullArticle4.getValue());
        dataALLArticle.Article05 = nvlCad(article5_quality.getValue());
        dataALLArticle.Article06 = nvlCad(fullArticle6.getValue());
        dataALLArticle.Article07 = nvlCad(fullArticle7.getValue());
        dataALLArticle.Article08 = nvlCad(fullArticle8.getValue());
        dataALLArticle.Article09 = nvlCad(fullArticle9.getValue());
        dataALLArticle.Article10 = nvlCad(fullArticle10.getValue());
        dataALLArticle.Article11 = nvlCad(article11_quality.getValue());
        dataALLArticle.Article12 = nvlCad(fullArticle12.getValue());
        dataALLArticle.contractNo = contactCadHeader.getValue("contractNo")+ "_Cad";
        dataALLArticle.contractId = contractID;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/contract/writeWord",
            httpMethod: "POST",
            data: JSON.stringify(dataALLArticle),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                } else
                    isc.say(RpcResponse_o.data);
            }
        }))
    }

function nvlCad(articleIsNotNull){
        if(articleIsNotNull == undefined){
            return "";
        }else{
            return articleIsNotNull;
        }
    }
