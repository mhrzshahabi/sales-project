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
            // backgroundColor: "#84c1ed",
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

    var contactConcTabs = isc.TabSet.create({
        width: "100%",
        height: "97%",
        tabs: [
            {
                title: "page1", canClose: false,
                pane: isc.ViewLoader.create({
                    ID: "ViewLoaderpageConc1",
                    autoDraw: true,
                    viewURL: "<spring:url value="/contact/concPage1" />",
                    loadingMessage: "Loading Page1.."
                })
            },
            {
                title: "page2", canClose: false,
                pane: isc.ViewLoader.create({
                    ID: "ViewLoaderpageConc2",
                    autoDraw: true,
                    viewURL: "<spring:url value="/contact/concPage2" />",
                    loadingMessage: "Loading Page2..",
                    viewLoaded: function () {
                        flagEdit = 1;
                    }
                })
            }
        ]
    });

    var IButton_ContactConc_Save = isc.IButtonSave.create({
        title: "save",
        icon: "pieces/16/save.png",
        iconOrientation: "right",
        click: function () {
            var dataSaveAndUpdateContractConc = {};
            var dataSaveAndUpdateContractConcDetail = {};
            if (methodHtpp == "PUT") {
                dataSaveAndUpdateContractConc.id = ListGrid_Conc.getSelectedRecord().id;
                var criteriaConcDetail = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{
                        fieldName: "contract.id",
                        operator: "equals",
                        value: ListGrid_Conc.getSelectedRecord().id
                    }]
                };
                RestDataSource_contractDetail_list.fetchData(criteriaConcDetail, function (dsResponse, data, dsRequest) {
                    dataSaveAndUpdateContractConcDetail.id = data[0].id;
                });
                ListGrid_Conc.invalidateCache();
            }
            contactHeaderConc.validate();
            //dynamicFormConc.validate();
            valuesManagerArticle5_DeliveryTermsConc.validate();
            /* if (contactHeaderConc.hasErrors()|| dynamicFormConc.hasErrors()){
                 return;
             }*/
            if (valuesManagerArticle5_DeliveryTermsConc.hasErrors()) {
                contactConcTabs.selectTab(1);
                return;
            }
            contactHeaderConc.setValue("contractDate", contactHeaderConc.getValues().createDate.toNormalDate("toUSShortDate"));

            dataSaveAndUpdateContractConc.contractDate = contactHeaderConc.getValue("contractDate");
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
            dataSaveAndUpdateContractConc.incotermsId = valuesManagerArticle5_DeliveryTermsConc.getValue("incotermsId");
            dataSaveAndUpdateContractConc.portByPortSourceId = valuesManagerArticle5_DeliveryTermsConc.getValue("portByPortSourceId");
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
            //dataSaveAndUpdateContractConc.materialId = dynamicFormConc.getValue("materialId");
            dataSaveAndUpdateContractConc.materialId = 3;
            dataSaveAndUpdateContractConc.treatCost = valuesManagerArticle9_conc.getValue("TC");
            dataSaveAndUpdateContractConc.refinaryCost = valuesManagerArticle9_conc.getValue("RC");

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
            dataSaveAndUpdateContractConcDetail.article10_number56 = valuesManagerArticle12_quality.getValue("article12_number56");
            dataSaveAndUpdateContractConcDetail.article10_number57 = valuesManagerArticle12_quality.getValue("article12_number57");
            dataSaveAndUpdateContractConcDetail.article10_number58 = valuesManagerArticle12_quality.getValue("article12_number58");
            dataSaveAndUpdateContractConcDetail.article10_number59 = valuesManagerArticle12_quality.getValue("article12_number59");
            dataSaveAndUpdateContractConcDetail.article10_number60 = valuesManagerArticle12_quality.getValue("article12_number60");
            dataSaveAndUpdateContractConcDetail.article10_number61 = valuesManagerArticle12_quality.getValue("article12_number61");
            dataSaveAndUpdateContractConc.contractDetails = dataSaveAndUpdateContractConcDetail;
            dataSaveAndUpdateContractConc.contractShipments = saveListGrid_ContractConcItemShipment();
            console.log(dataSaveAndUpdateContractConc);
            recordContractNoConc = contactHeaderConc.getValue("contractNo");
            var criteriaContractNoConc = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "materialId", operator: "equals", value: 3}, {
                    fieldName: "contractNo",
                    operator: "equals",
                    value: recordContractNoConc
                }]
            };
            RestDataSource_Contract.fetchData(criteriaContractNoConc, function (dsResponse, data, dsRequest) {
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/contract",
                    httpMethod: methodHtpp,
                    data: JSON.stringify(dataSaveAndUpdateContractConc),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            Window_ContactConc.close();
                            ListGrid_Conc.invalidateCache();
                            saveValueAllArticlesConc((JSON.parse(resp.data)).id);
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                }))
            })
        }
    });

    var contactFormButtonSaveLayout = isc.HStack.create({
        width: "100%",
        height: "3%",
        align: "center",
        membersMargin: 5,
        layoutMargin: 10,
        members: [
            IButton_ContactConc_Save,
            isc.IButtonCancel.create({
                title: "<spring:message code='global.cancel'/>",
                width: 100,
                icon: "pieces/16/icon_delete.png",
                orientation: "vertical",
                click: function () {
                    Window_ContactConc.close();
                }
            })
        ]
    });

    VLayout_contactMain = isc.VLayout.create({
        width: "100%",
        height: "100%",
        align: "center",
        overflow: "scroll",
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        autoScroller: true,
        closeClick: function () {
            this.Super("closeClick", arguments);
        },
        members: [
            contactConcTabs,
            contactFormButtonSaveLayout
        ]
    });


    function saveListGrid_ContractConcItemShipment() {
        ListGrid_ContractConcItemShipment.selectAllRecords();
        var dataEdit = [];
        ListGrid_ContractConcItemShipment.getAllEditRows().forEach(function (element) {
            dataEdit.push(ListGrid_ContractConcItemShipment.getEditedRecord(element));
            ListGrid_ContractConcItemShipment.deselectRecord(ListGrid_ContractConcItemShipment.getRecord(element));
        });
        ListGrid_ContractConcItemShipment.getSelectedRecords().forEach(function (element) {
            dataEdit.push(JSON.parse(JSON.stringify(element)));
        });
        ListGrid_ContractConcItemShipment.deselectAllRecords();
        console.log(dataEdit);
        return dataEdit;
    };

    var dataALLArticleConc = {};

    function saveValueAllArticlesConc(contractID) {
        dataALLArticleConc.Article01 = nvlConc(dynamicForm_fullArticle01.getValue());
        dataALLArticleConc.Article02 = nvlConc(dynamicForm_fullArticle02.getValue());
        dataALLArticleConc.Article03 = nvlConc(dynamicForm_fullArticleConc03.getValue());
        dataALLArticleConc.Article04 = nvlConc(dynamicForm_fullArticleConc04.getValue());
        dataALLArticleConc.Article05 = nvlConc(dynamicForm_fullArticleConc05.getValue());
        dataALLArticleConc.Article06 = nvlConc(dynamicForm_fullArticleConc06.getValue());
        dataALLArticleConc.Article07 = nvlConc(dynamicForm_fullArticleConc07.getValue());
        dataALLArticleConc.Article08 = nvlConc(dynamicForm_fullArticleConc08.getValue());
        dataALLArticleConc.Article09 = nvlConc(dynamicForm_fullArticleConc09.getValue());
        dataALLArticleConc.Article10 = nvlConc(dynamicForm_fullArticleConc10.getValue());
        dataALLArticleConc.Article11 = nvlConc(dynamicForm_fullArticleConc11.getValue());
        dataALLArticleConc.Article12 = nvlConc(dynamicForm_fullArticleConc12.getValue());
        dataALLArticleConc.contractNo = contactHeaderConc.getValue("contractNo") + "_Conc";
        dataALLArticleConc.contractId = contractID;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/contract/writeWord",
            httpMethod: "POST",
            data: JSON.stringify(dataALLArticleConc),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>");
                } else
                    isc.say(RpcResponse_o.data);
            }
        }))
    }

    function nvlConc(articleIsNotNull) {
        if (articleIsNotNull == undefined) {
            return "";
        } else {
            return articleIsNotNull;
        }
    }


    function clearAdd() {
        contactConcTabs.selectTab(0);
        contactHeaderConc.clearValues();
        contactHeaderConcAgent.clearValues();
        dynamicForm_fullArticle01.setValue("");
        valuesManagerfullArticle.setValue("");
        valuesManagerConcArticle1.setValue("");
        dynamicForm_fullArticle02.setValue("");
        dynamicForm_fullArticleConc03.setValue("");
        dynamicForm_fullArticleConc04.setValue("");
        dynamicForm_fullArticleConc05.setValue("");
        dynamicForm_fullArticleConc06.setValue("");
        dynamicForm_fullArticleConc07.setValue("");
        dynamicForm_fullArticleConc08.setValue("");
        dynamicForm_fullArticleConc09.setValue("");
        dynamicForm_fullArticleConc10.setValue("");
        dynamicForm_fullArticleConc11.setValue("");
        dynamicForm_fullArticleConc12.setValue("");
        valuesManagerArticle5_DeliveryTermsConc.clearValues();
        dynamicForm_article9Conc.clearValues();
        article10_qualityConc.clearValues();
        valuesManagerArticle12_quality.clearValues();
        valuesManagerArticle2Conc.clearValues();
        valuesManagerArticle3_conc.clearValues();
        ListGrid_ContractConcItemShipment.setData([]);
    }