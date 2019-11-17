<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>
 var contractIdEdit;
 var Window_Contact;
 var VLayout_contactMain;
 var itemsDefinitionsCount = 0;
 var imanageNote = 0;
 var methodUrl="POST";
 var lotList;
 var ListGrid_ContractItemShipment;
 var criteriaContractItemShipment;
 var contractDetailID;
 var dynamicForm_article3_Typicall
 function ValuesManager(valueId) {
                isc.ValuesManager.create({
                ID: valueId
            })
    }

    ValuesManager("contactHeader");
    ValuesManager("contactHeaderAgent");
    ValuesManager("valuesManagerArticle1");
    ValuesManager("valuesManagerArticle2");
    ValuesManager("valuesManagerArticle3");
    ValuesManager("valuesManagerArticle4");
    ValuesManager("valuesManagerArticle5");
    ValuesManager("valuesManagerArticle6");
    ValuesManager("valuesManagerArticle7");
    ValuesManager("valuesManagerArticle8");
    ValuesManager("valuesManagerArticle9");
    ValuesManager("valuesManagerArticle10");

 var RestDataSource_Parameters = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "paramName", title: "<spring:message code='parameters.paramName'/>", width: 200},
                {name: "paramType", title: "<spring:message code='parameters.paramType'/>", width: 200},
                {name: "paramValue", title: "<spring:message code='parameters.paramValue'/>", width: 200},
                {name: "contractId", title: "<spring:message code='parameters.paramValue'/>", width: 200},
                {name: "categoryValue", title: "<spring:message code='parameters.paramValue'/>", width: 200}
            ],
        fetchDataURL: "${contextPath}/api/parameters/spec-list"
    });

    var RestDataSource_WarehouseLot = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "warehouseNo", title: "<spring:message code='dailyWarehouse.warehouseNo'/>", align: "center"},
                {name: "plant", title: "<spring:message code='dailyWarehouse.plant'/>", align: "center"},
                {name: "material.descl", title: "<spring:message code='goods.nameLatin'/> "},
                {name: "lotName", title: "<spring:message code='warehouseLot.lotName'/>", align: "center"},
                {name: "mo", title: "<spring:message code='warehouseLot.mo'/>", align: "center"},
                {name: "cu", title: "<spring:message code='warehouseLot.cu'/>", align: "center"},
                {name: "si", title: "<spring:message code='warehouseLot.si'/>", align: "center"},
                {name: "pb", title: "<spring:message code='warehouseLot.pb'/>", align: "center"},
                {name: "s", title: "<spring:message code='warehouseLot.s'/>", align: "center"},
                {name: "c", title: "<spring:message code='warehouseLot.c'/>", align: "center"},
                {name: "p", title: "<spring:message code='warehouseLot.p'/>", align: "center"},
                {name: "size1", title: "<spring:message code='warehouseLot.size1'/>", align: "center"},
                {name: "size1Value", title: "<spring:message code='warehouseLot.size1Value'/>", align: "center"},
                {name: "size2", title: "<spring:message code='warehouseLot.size2'/>", align: "center"},
                {name: "size2Value", title: "<spring:message code='warehouseLot.size2Value'/>", align: "center"},
                {name: "weightKg", title: "<spring:message code='warehouseLot.weightKg'/>", align: "center"},
                {name: "grossWeight", title: "<spring:message code='grossWeight.weightKg'/>", align: "center"},
                {name: "contractId", title: "contractId", align: "center"},
                {name: "used", type: "boolean", title: "used", canEdit: true, align: "center"}
            ],
        fetchDataURL: "${contextPath}/api/warehouseLot/spec-list"
    });

    var RestDataSource_Unit = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='unit.code'/> "},
                {name: "nameFA", title: "<spring:message code='unit.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='unit.nameEN'/> "},
                {name: "symbol", title: "<spring:message code='unit.symbol'/>"},
                {name: "decimalDigit", title: "<spring:message code='rate.decimalDigit'/>"}
            ],
        fetchDataURL: "${contextPath}/api/unit/spec-list"
    });

    var RestDataSource_Incoterms = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
            ],
        fetchDataURL: "${contextPath}/api/incoterms/spec-list"
    });
    var RestDataSource_Contact_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "seller", operator: "equals", value: true}]
    };
    var RestDataSource_ContactBUYER_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "buyer", operator: "equals", value: true}]
    };
    var RestDataSource_ContactAgentBuyer_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "agentBuyer", operator: "equals", value: true}]
    };
    var RestDataSource_ContactAgentSeller_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "agentSeller", operator: "equals", value: true}]
    };
    var RestDataSource_ShipmentContractUsed = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "used", operator: "notEqual", value: 1}]
    };
    var criteriaMo = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "materialId", operator: "equals", value: -32}]
    };

       var RestDataSource_ContractPenalty = isc.RestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "value", title: "<spring:message code='contractPenalty.value'/>", width: 200},
                {name: "tblContractItemFeature.tblFeature.nameFA", title: "<spring:message code='contractPenalty.feature'/>", width: 200 },
                {name: "operation", title: "<spring:message code='contractPenalty.operation'/>", width: 200},
                {name: "deduction", title: "<spring:message code='contractPenalty.deduction'/>", width: 200}
            ],
        fetchDataURL: "${contextPath}/api/contractPenalty/spec-list"
    });

    var RestDataSource_CountryPort = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "nameFa", title: "<spring:message code='country.nameFa'/>", width: 200},
                {name: "nameEn", title: "<spring:message code='country.nameEn'/>", width: 200},
                {name: "isActive", title: "<spring:message code='country.isActive'/>", width: 200}
            ],

        fetchDataURL: "${contextPath}/api/country/spec-list"
    });

    var RestDataSource_Contact = isc.MyRestDataSource.create({
        fields: [
            {name: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "code", title: "<spring:message code='contact.code'/>"},
            {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
            {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
            {name: "phone", title: "<spring:message code='contact.phone'/>"},
            {name: "mobile", title: "<spring:message code='contact.mobile'/>"},
            {name: "fax", title: "<spring:message code='contact.fax'/>"},
            {name: "address", title: "<spring:message code='contact.address'/>"},
            {name: "webSite", title: "<spring:message code='contact.webSite'/>"},
            {name: "email", title: "<spring:message code='contact.email'/>"},
            {
                name: "type",
                title: "<spring:message code='contact.type'/>",
                valueMap: {
                    "true": "<spring:message code='contact.type.real'/>",
                    "false": "<spring:message code='contact.type.legal'/>"
                }
            },
            {name: "nationalCode", title: "<spring:message code='contact.nationalCode'/>"},
            {name: "economicalCode", title: "<spring:message code='contact.economicalCode'/>"},
            {name: "bankAccount", title: "<spring:message code='contact.bankAccount'/>"},
            {name: "bankShaba", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "bankSwift", title: "<spring:message code='contact.bankShaba'/>"},
            {name: "ceoPassportNo"},
            {name: "ceo"},
            {name: "commercialRole"},
            {
                name: "status",
                title: "<spring:message code='contact.status'/>",
                valueMap: {"true": "<spring:message code='enabled'/>", "false": "<spring:message code='disabled'/>"}
            },
            {name: "tradeMark"},
            {name: "commercialRegistration"},
            {name: "branchName"},
            {name: "countryId", title: "<spring:message code='country.nameFa'/>", type: 'long'},
            {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>"},
            {name: "contactAccounts"}
        ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });
    var RestDataSource_Port = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "beam", title: "<spring:message code='port.port'/>", width: 200},
                {name: "loa", title: "<spring:message code='port.port'/>", width: 200},
                {name: "arrival", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],

        fetchDataURL: "${contextPath}/api/port/spec-list"
    });
    var RestDataSource_Currency_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/currency/spec-list"
    });
    var RestDataSource_ContractShipment = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", hidden: true, primaryKey: true, canEdit: false,},
                {name: "contractItemId", type: "long", hidden: true},
                {
                    name: "shipmentRow",
                    title: "<spring:message code='contractItem.itemRow'/> ",
                    type: 'text',
                    required: true,
                    width: 400
                },
                {
                    name: "dischargeId",
                    title: "<spring:message code='port.port'/>",
                    type: 'text',
                    required: true,
                    width: 400
                },
                {name: "discharge.port", title: "<spring:message code='port.port'/>", align: "center"},
                {
                    name: "address",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    required: true,
                    width: 400
                },
                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float',
                    required: true,
                    width: 400
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    type: 'text',
                    width: 400,
                },
                {name: "duration", title: "<spring:message code='global.duration'/>", type: 'text', width: 400},
            ],
        fetchDataURL: "${contextPath}/api/contractShipment/spec-list"
    });

    var restDataSource_ContractShipmentValid = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contractShipment/spec-list"
    })

    var RestDataSource_contractDetail_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contractDetail/spec-list"
    });

    var ViewLoader_createTozin = isc.ViewLoader.create({
                        width: "100%",
                        height: "100%",
                        autoDraw: false,
                        loadingMessage: " <spring:message code='global.loadingMessage'/>"
                });
    isc.Window.create({
                    title: "<spring:message code='dailyReport.DailyReportBandarAbbasTest'/> ",
                    width: "100%",
                    height: "100%",
                    autoCenter: true,
                    align: "center",
                    autoDraw: false,
                    dismissOnEscape: true,
                    closeClick: function () {
                    this.Super("closeClick", arguments)
                    },
                    items:
                    [
                    ViewLoader_createTozin
                    ]
            });



        isc.Label.create({ID:"Label_Contact_Type",padding: 20,width: "100%",height: "1%",styleName: "helloWorldText",contents:  'Please select the type of contract.'});
        isc.IButton.create({ID:"Button_MO_OX",width: "200",height: "30",title: "Molybdenum",icon: "icons/16/world.png",iconOrientation: "right",click:function () {
                contactHeader.clearValues();
                contactHeaderAgent.clearValues();
                valuesManagerArticle1.clearValues();
                valuesManagerArticle2.clearValues();
                valuesManagerArticle3.clearValues();
                valuesManagerArticle4.clearValues();
                valuesManagerArticle5.clearValues();
                valuesManagerArticle6.clearValues();
                valuesManagerArticle7.clearValues();
                valuesManagerArticle8.clearValues();
                valuesManagerArticle9.clearValues();
                valuesManagerArticle10.clearValues();
                pageMolibdenAll(0);
                lotList.fetchData(RestDataSource_ShipmentContractUsed);
                Window_SelectTypeContact.close();

        }})
        isc.HLayout.create({ID:"HLayout_button_TypeMoliden",align: "center",width: "30%",height: "20%",align: "center",members:[Button_MO_OX]});
        isc.HStack.create({ID:"HLayout_button_TypeMoliden3",layoutMargin:10,align: "center",width: "100%",height: "80%",align: "center",members:[HLayout_button_TypeMoliden]});
        isc.VLayout.create({ID:"button_VLayout",width: "100%",height: "100%",align: "center",members:[Label_Contact_Type,HLayout_button_TypeMoliden3]});

        var Window_SelectTypeContact = isc.Window.create({
                            title: "Type Contact",
                            width: "50%",
                            height: "20%",
                            autoCenter: true,
                            isModal: true,
                            showModalMask: true,
                            align: "center",
                            autoDraw: false,
                            closeClick: function () {
                            this.Super("closeClick", arguments)
                            },
                            items: [
                                button_VLayout
                            ]
                            });
                    var ToolStripButton_Contact_Add = isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/add.png",
                            title: "<spring:message code='global.form.new'/>",
                            click: function () {
                                Window_SelectTypeContact.animateShow();

                            }
                    });
                    var ToolStripButton_Contact_Edit = isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/edit.png",
                            title: "<spring:message code='global.form.edit'/>",
                            click: function () {
                                var record = ListGrid_Tozin.getSelectedRecord();
                                contractIdEdit=record.id;
                                alert(contractIdEdit)
                                if (record == null || record.id == null) {
                                    isc.Dialog.create({
                                        message: "<spring:message code='global.grid.record.not.selected'/>",
                                        icon: "[SKIN]ask.png",
                                        title: "<spring:message code='global.message'/>",
                                        buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                        buttonClick: function () {
                                            this.hide();
                                        }});
                            } else {
                            var criteria1={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"contract_id",operator:"equals",value:record.id}]};
                            var criterialotList={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"contractId",operator:"equals",value:record.id}]};
                                    criteriaContractItemShipment={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"contractId",operator:"equals",value:record.id}]};
                                    RestDataSource_contractDetail_list.fetchData(criteria1,function (dsResponse, data, dsRequest) {
                                    var feild_all_defintitons_save = JSON.parse(data[0].feild_all_defintitons_save)
                                    contractDetailID = data[0].id
                                    for (const [key, value] of Object.entries(feild_all_defintitons_save)) {
                                        valuesManagerArticle1.setValue(key,value);
                                        if(key != 'definitionsOne' && key != 'feild_all_defintitons_save'){
                                            itemsEditDefinitions(key,value,itemsDefinitionsCount)
                                          }
                                    }
                                    contactHeader.setValue("createDateDumy", record.contractDate)
                                    contactHeader.setValue("contractNo", record.contractNo)
                                    contactHeader.setValue("contactId", record.contactId)
                                    contactHeader.setValue("contactByBuyerAgentId", record.contactByBuyerAgentId)
                                    contactHeader.setValue("contactBySellerId", record.contactBySellerId)
                                    contactHeader.setValue("contactBySellerAgentId", record.contactBySellerAgentId)
                                    contactHeaderAgent.setValue("name_ContactAgentSeller", data[0].name_ContactAgentSeller)
                                    contactHeaderAgent.setValue("phone_ContactAgentSeller", data[0].phone_ContactAgentSeller)
                                    contactHeaderAgent.setValue("mobile_ContactAgentSeller", data[0].mobile_ContactAgentSeller)
                                    contactHeaderAgent.setValue("address_ContactAgentSeller", data[0].address_ContactAgentSeller)
                                    contactHeaderAgent.setValue("address_ContactSeller", data[0].address_ContactSeller)
                                    contactHeaderAgent.setValue("mobile_ContactSeller", data[0].mobile_ContactSeller)
                                    contactHeaderAgent.setValue("phone_ContactSeller", data[0].phone_ContactSeller)
                                    contactHeaderAgent.setValue("name_ContactSeller", data[0].name_ContactSeller)
                                    contactHeaderAgent.setValue("name_ContactAgentBuyer", data[0].name_ContactAgentBuyer)
                                    contactHeaderAgent.setValue("phone_ContactAgentBuyer", data[0].phone_ContactAgentBuyer)
                                    contactHeaderAgent.setValue("mobile_ContactAgentBuyer", data[0].mobile_ContactAgentBuyer)
                                    contactHeaderAgent.setValue("address_ContactAgentBuyer", data[0].address_ContactAgentBuyer)
                                    contactHeaderAgent.setValue("name_ContactBuyer", data[0].name_ContactBuyer)
                                    contactHeaderAgent.setValue("phone_ContactBuyer", data[0].phone_ContactBuyer)
                                    contactHeaderAgent.setValue("mobile_ContactBuyer", data[0].mobile_ContactBuyer)
                                    contactHeaderAgent.setValue("address_ContactBuyer", data[0].address_ContactBuyer)
                                    valuesManagerArticle2.setValue("amount", record.amount);
                                    valuesManagerArticle2.setValue("amount_en", record.amount_en);
                                    valuesManagerArticle2.setValue("unitId", record.unitId);
                                    valuesManagerArticle2.setValue("molybdenumTolorance", record.molybdenumTolorance);
                                    valuesManagerArticle2.setValue("optional", record.optional);
                                    valuesManagerArticle2.setValue("plant", record.plant);
                                    valuesManagerArticle2.setValue("article2_13_1", data[0].article2_13_1);
                                    valuesManagerArticle2.setValue("responsibleTelerons", data[0].responsibleTelerons);
                                    valuesManagerArticle3.setValue("contactInspectionId",record.contactInspectionId);
                                    valuesManagerArticle3.setValue("article3_number17",data[0].article3_number17);
                                    valuesManagerArticle3.setValue("article3_number17_7",data[0].article3_number17);
                                    valuesManagerArticle3.setValue("article3_number17_8",data[0].article3_number17);
                                    valuesManagerArticle3.setValue("article3_number17_9",data[0].article3_number17);
                                    valuesManagerArticle3.setValue("article3_number17_10",data[0].article3_number17);
                                    valuesManagerArticle3.setValue("article3_number17_11",data[0].article3_number17);
                                    valuesManagerArticle3.setValue("article3_number17_12",data[0].article3_number17);
                                    valuesManagerArticle3.setValue("article3_number17_2",data[0].article3_number17);
                                    valuesManagerArticle3.setValue("PrefixMolybdenum",data[0].PrefixMolybdenum);
                                    valuesManagerArticle3.setValue("molybdenum",record.molybdenum);
                                    valuesManagerArticle3.setValue("toleranceMO",data[0].toleranceMO);
                                    valuesManagerArticle3.setValue("typical_unitMO",data[0].typical_unitMO);
                                    valuesManagerArticle3.setValue("PrefixCopper",data[0].PrefixCopper);
                                    valuesManagerArticle3.setValue("copper",record.copper);
                                    valuesManagerArticle3.setValue("toleranceCU",data[0].toleranceCU);
                                    valuesManagerArticle3.setValue("typical_unitCU",data[0].typical_unitCU);
                                    valuesManagerArticle3.setValue("PrefixC",data[0].PrefixC);
                                    valuesManagerArticle3.setValue("typical_c",data[0].typical_c);
                                    valuesManagerArticle3.setValue("toleranceC",data[0].toleranceC);
                                    valuesManagerArticle3.setValue("typical_unitC",data[0].typical_unitC);
                                    valuesManagerArticle3.setValue("PrefixS",data[0].PrefixS);
                                    valuesManagerArticle3.setValue("typical_s",data[0].typical_s);
                                    valuesManagerArticle3.setValue("toleranceS",data[0].toleranceS);
                                    valuesManagerArticle3.setValue("typical_unitS",data[0].typical_unitS);
                                    valuesManagerArticle3.setValue("PrefixPb",data[0].PrefixPb);
                                    valuesManagerArticle3.setValue("typical_pb",data[0].typical_pb);
                                    valuesManagerArticle3.setValue("tolerancePb",data[0].tolerancePb);
                                    valuesManagerArticle3.setValue("typical_unitPb",data[0].typical_unitPb);
                                    valuesManagerArticle3.setValue("PrefixP",data[0].PrefixP);
                                    valuesManagerArticle3.setValue("typical_p",data[0].typical_p);
                                    valuesManagerArticle3.setValue("toleranceP",data[0].toleranceP);
                                    valuesManagerArticle3.setValue("typical_unitP",data[0].typical_unitP);
                                    valuesManagerArticle3.setValue("PrefixSi",data[0].PrefixSi);
                                    valuesManagerArticle3.setValue("typical_Si",data[0].typical_Si);
                                    valuesManagerArticle3.setValue("toleranceSi",data[0].toleranceSi);
                                    valuesManagerArticle3.setValue("typical_unitSi",data[0].typical_unitSi);
                                    valuesManagerArticle3.setValue("article3_number17_3",data[0].article3_number17_3);
                                    valuesManagerArticle3.setValue("article3_number17_13",data[0].article3_number17_13);
                                    valuesManagerArticle3.setValue("article3_number17_4",data[0].article3_number17_4);
                                    valuesManagerArticle3.setValue("article3_number17_5",data[0].article3_number17_5);
                                    valuesManagerArticle3.setValue("article3_number17_6",data[0].article3_number17_6);
                                    valuesManagerArticle4.setValue("article4_number18",data[0].article4_number18);
                                    valuesManagerArticle4.setValue("amount_number19_1",data[0].amount_number19_1);
                                    valuesManagerArticle4.setValue("mo_amount",record.mo_amount);
                                    valuesManagerArticle4.setValue("amount_number19_2",data[0].amount_number19_2);
                                    valuesManagerArticle5.setValue("shipment_number20",data[0].shipment_number20);
                                    valuesManagerArticle5.setValue("timeIssuance",record.timeIssuance);
                                    valuesManagerArticle5.setValue("prefixPayment",record.prefixPayment);
                                    valuesManagerArticle5.setValue("invoiceType",record.invoiceType);
                                    valuesManagerArticle5.setValue("article5_number21_6",data[0].article5_number21_6);
                                    valuesManagerArticle5.setValue("runStartDate",record.runStartDate);
                                    valuesManagerArticle5.setValue("runTill",record.runTill);
                                    valuesManagerArticle5.setValue("runEndtDate",record.runEndtDate);
                                    ///**article5_number26_1
                                    valuesManagerArticle6.setValue("article6_number31",data[0].article6_number31);
                                    valuesManagerArticle6.setValue("article6_number31_1",data[0].article6_number31_1);
                                    valuesManagerArticle6.setValue("incotermsId",record.incotermsId);
                                    valuesManagerArticle6.setValue("article6_number32_1",data[0].article6_number32_1);
                                    valuesManagerArticle6.setValue("portByPortSourceId",record.portByPortSourceId);
                                    valuesManagerArticle6.setValue("article6_number34",data[0].article6_number34);
                                    valuesManagerArticle6.setValue("incotermsText",record.incotermsText);
                                    valuesManagerArticle6.setValue("article6_Containerized",data[0].article6_Containerized);
                                    valuesManagerArticle6.setValue("officeSource",record.officeSource);
                                    valuesManagerArticle6.setValue("article6_Containerized_number36_1",data[0].article6_Containerized_number36_1);
                                    valuesManagerArticle6.setValue("article6_Containerized_number33",data[0].article6_Containerized_number33);
                                    valuesManagerArticle6.setValue("article6_Containerized_number37_1",data[0].article6_Containerized_number37_1);
                                    valuesManagerArticle6.setValue("article6_Containerized_number37_2",data[0].article6_Containerized_number37_2);
                                    valuesManagerArticle6.setValue("article6_Containerized_number33_1",data[0].article6_Containerized_number33_1);
                                    valuesManagerArticle6.setValue("article6_Containerized_number37_3",data[0].article6_Containerized_number37_3);
                                    valuesManagerArticle6.setValue("article6_Containerized_number32",data[0].article6_Containerized_number32);
                                    valuesManagerArticle6.setValue("article6_Containerized_4",data[0].article6_Containerized_4);
                                    valuesManagerArticle6.setValue("article6_Containerized_5",data[0].article6_Containerized_5);
                                    valuesManagerArticle7.setValue("article7_number41",data[0].article7_number41);
                                    valuesManagerArticle7.setValue("article7_number3",data[0].article7_number3);
                                    valuesManagerArticle7.setValue("article7_number37",data[0].article7_number37);
                                    valuesManagerArticle7.setValue("priceCalPeriod",record.priceCalPeriod);
                                    valuesManagerArticle7.setValue("article7_number3_1",data[0].article7_number3_1);
                                    valuesManagerArticle7.setValue("publishTime",record.publishTime);
                                    valuesManagerArticle7.setValue("article7_number39_1",data[0].article7_number39_1);
                                    valuesManagerArticle7.setValue("reportTitle",record.reportTitle);
                                    valuesManagerArticle7.setValue("article7_number40_2",data[0].article7_number40_2);
                                    valuesManagerArticle7.setValue("discountValueOne",data[0].discountValueOne);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueOne_1",data[0].discountValueOne_1);
                                    valuesManagerArticle7.setValue("discountPerfixOne",data[0].discountPerfixOne);
                                    valuesManagerArticle7.setValue("discountUnitOne",data[0].discountUnitOne);
                                    valuesManagerArticle7.setValue("discountPerfixOne_1",data[0].discountPerfixOne_1);
                                    valuesManagerArticle7.setValue("discountValueOne_2",data[0].discountValueOne_2);
                                    valuesManagerArticle7.setValue("discountValueTwo",data[0].discountValueTwo);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueTwo_1",data[0].discountValueTwo_1);
                                    valuesManagerArticle7.setValue("discountPerfixTwo",data[0].discountPerfixTwo);
                                    valuesManagerArticle7.setValue("discountUnitTwo",data[0].discountUnitTwo);
                                    valuesManagerArticle7.setValue("discountPerfixTwo_1",data[0].discountPerfixTwo_1);
                                    valuesManagerArticle7.setValue("discountValueTwo_2",data[0].discountValueTwo_2);
                                    valuesManagerArticle7.setValue("discountValueThree",data[0].discountValueThree);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueThree_1",data[0].discountValueThree_1);
                                    valuesManagerArticle7.setValue("discountPerfixThree",data[0].discountPerfixThree);
                                    valuesManagerArticle7.setValue("discountUnitThree",data[0].discountUnitThree);
                                    valuesManagerArticle7.setValue("discountPerfixThree_1",data[0].discountPerfixThree_1);
                                    valuesManagerArticle7.setValue("discountValueThree_2",data[0].discountValueThree_2);
                                    valuesManagerArticle7.setValue("discountValueFour",data[0].discountValueFour);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueFour_1",data[0].discountValueFour_1);
                                    valuesManagerArticle7.setValue("discountPerfixFour",data[0].discountPerfixFour);
                                    valuesManagerArticle7.setValue("discountUnitFour",data[0].discountUnitFour);
                                    valuesManagerArticle7.setValue("discountPerfixFour_1",data[0].discountPerfixFour_1);
                                    valuesManagerArticle7.setValue("discountValueFour_2",data[0].discountValueFour_2);
                                    valuesManagerArticle7.setValue("discountValueFive",data[0].discountValueFive);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueFive_1",data[0].discountValueFive_1);
                                    valuesManagerArticle7.setValue("discountPerfixFive",data[0].discountPerfixFive);
                                    valuesManagerArticle7.setValue("discountUnitFive",data[0].discountUnitFive);
                                    valuesManagerArticle7.setValue("discountPerfixFive_1",data[0].discountPerfixFive_1);
                                    valuesManagerArticle7.setValue("discountValueFive_2",data[0].discountValueFive_2);
                                    valuesManagerArticle7.setValue("discountValueSix",data[0].discountValueSix);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueSix_1",data[0].discountValueSix_1);
                                    valuesManagerArticle7.setValue("discountPerfixSix",data[0].discountPerfixSix);
                                    valuesManagerArticle7.setValue("discountUnitSix",data[0].discountUnitSix);
                                    valuesManagerArticle7.setValue("discountPerfixSix_1",data[0].discountPerfixSix_1);
                                    valuesManagerArticle7.setValue("discountValueSix_2",data[0].discountValueSix_2);
                                    valuesManagerArticle7.setValue("discountValueSeven",data[0].discountValueSeven);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueSeven_1",data[0].discountValueSeven_1);
                                    valuesManagerArticle7.setValue("discountPerfixSeven",data[0].discountPerfixSeven);
                                    valuesManagerArticle7.setValue("discountUnitSeven",data[0].discountUnitSeven);
                                    valuesManagerArticle7.setValue("discountPerfixSeven_1",data[0].discountPerfixSeven_1);
                                    valuesManagerArticle7.setValue("discountValueSeven_2",data[0].discountValueSeven_2);
                                    valuesManagerArticle7.setValue("discountValueEight",data[0].discountValueEight);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueEight_1",data[0].discountValueEight_1);
                                    valuesManagerArticle7.setValue("discountPerfixEight",data[0].discountPerfixEight);
                                    valuesManagerArticle7.setValue("discountUnitEight",data[0].discountUnitEight);
                                    valuesManagerArticle7.setValue("discountPerfixEight_1",data[0].discountPerfixEight_1);
                                    valuesManagerArticle7.setValue("discountValueEight_2",data[0].discountValueEight_2);
                                    valuesManagerArticle7.setValue("discountValueNine",data[0].discountValueNine);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueNine_1",data[0].discountValueNine_1);
                                    valuesManagerArticle7.setValue("discountPerfixNine",data[0].discountPerfixNine);
                                    valuesManagerArticle7.setValue("discountUnitNine",data[0].discountUnitNine);
                                    valuesManagerArticle7.setValue("discountPerfixNine_1",data[0].discountPerfixNine_1);
                                    valuesManagerArticle7.setValue("discountValueNine_2",data[0].discountValueNine_2);
                                    valuesManagerArticle7.setValue("discountValueTen",data[0].discountValueTen);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueTen_1",data[0].discountValueTen_1);
                                    valuesManagerArticle7.setValue("discountPerfixTen",data[0].discountPerfixTen);
                                    valuesManagerArticle7.setValue("discountUnitTen",data[0].discountUnitTen);
                                    valuesManagerArticle7.setValue("discountPerfixTen_1",data[0].discountPerfixTen_1);
                                    valuesManagerArticle7.setValue("discountValueTen_2",data[0].discountValueTen_2);
                                    valuesManagerArticle7.setValue("discountValueEleven",data[0].discountValueEleven);
                                    valuesManagerArticle7.setValue("discountFor",data[0].discountFor);
                                    valuesManagerArticle7.setValue("discountValueEleven_1",data[0].discountValueEleven_1);
                                    valuesManagerArticle7.setValue("discountPerfixEleven",data[0].discountPerfixEleven);
                                    valuesManagerArticle7.setValue("discountUnitEleven",data[0].discountUnitEleven);
                                    valuesManagerArticle7.setValue("discountPerfixEleven_1",data[0].discountPerfixEleven_1);
                                    valuesManagerArticle7.setValue("discountValueEleven_2",data[0].discountValueEleven_2);
                                    valuesManagerArticle8.setValue("article8_number42",data[0].article8_number42);
                                    valuesManagerArticle8.setValue("article8_3",data[0].article8_3);
                                    valuesManagerArticle8.setValue("article8_value",data[0].article8_value);
                                    valuesManagerArticle8.setValue("article8_number43",data[0].article8_number43);
                                    valuesManagerArticle8.setValue("delay",record.delay);
                                    valuesManagerArticle8.setValue("article8_number44_1",data[0].article8_number44_1);
                                    valuesManagerArticle9.setValue("article9_number45",data[0].article9_number45);
                                    valuesManagerArticle9.setValue("prepaid",record.prepaid);
                                    valuesManagerArticle9.setValue("article9_number22",data[0].article9_number22);
                                    valuesManagerArticle9.setValue("article9_Englishi_number22",data[0].article9_Englishi_number22);
                                    valuesManagerArticle9.setValue("article9_number23",data[0].article9_number23);
                                    valuesManagerArticle9.setValue("prepaidCurrency",record.prepaidCurrency);
                                    valuesManagerArticle9.setValue("article9_number48",data[0].article9_number48);
                                    valuesManagerArticle9.setValue("payTime",record.payTime);
                                    valuesManagerArticle9.setValue("article9_number49_1",data[0].article9_number49_1);
                                    valuesManagerArticle9.setValue("pricePeriod",record.pricePeriod);
                                    valuesManagerArticle9.setValue("article9_number51",data[0].article9_number51);
                                    valuesManagerArticle9.setValue("eventPayment",record.eventPayment);
                                    valuesManagerArticle9.setValue("contentType",record.contentType);
                                    valuesManagerArticle9.setValue("article9_number54",data[0].article9_number54);
                                    valuesManagerArticle9.setValue("article9_number54_1",data[0].article9_number54_1);
                                    valuesManagerArticle9.setValue("article9_number55",data[0].article9_number55);
                                    valuesManagerArticle9.setValue("article9_ImportantNote",data[0].article9_ImportantNote);
                                    valuesManagerArticle10.setValue("article10_number56",data[0].article10_number56);
                                    valuesManagerArticle10.setValue("article10_number57",data[0].article10_number57);
                                    valuesManagerArticle10.setValue("article10_number58",data[0].article10_number58);
                                    valuesManagerArticle10.setValue("article10_number59",data[0].article10_number59);
                                    valuesManagerArticle10.setValue("article10_number60",data[0].article10_number60);
                                    valuesManagerArticle10.setValue("article10_number61",data[0].article10_number61);
                                    })
                                pageMolibdenAll(1);
                                ListGrid_ContractItemShipment.fetchData(criteriaContractItemShipment);
                                lotList.fetchData(criterialotList);
                            }
                            }});

                    var ToolStripButton_Contact_Remove= isc.ToolStripButton.create({
                            icon: "[SKIN]/actions/remove.png",
                            title: "<spring:message code='global.form.remove'/>",
                            click: function () {
                                if (ListGrid_Tozin.getSelectedRecord() == null || ListGrid_Tozin.getSelectedRecord().id == null) {
                                    isc.Dialog.create({
                                        message: "<spring:message code='global.grid.record.not.selected'/>",
                                        icon: "[SKIN]ask.png",
                                        title: "<spring:message code='global.message'/>",
                                        buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                        buttonClick: function () {
                                            this.hide();
                                        }});
                                } else{
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
                                                    var idContractRemove = ListGrid_Tozin.getSelectedRecord().id;
                                                    var criteriaRemove={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"contract_id",operator:"equals",value:idContractRemove}]};
                                                    RestDataSource_contractDetail_list.fetchData(criteriaRemove,function (dsResponse, data, dsRequest) {
                                                    if(data==""){
                                                        alert("aaa");
                                                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                                                    actionURL: "${contextPath}/api/contract/" + idContractRemove,
                                                                    httpMethod: "DELETE",
                                                                    callback: function (resp) {
                                                                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                                                            isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                                                            ListGrid_Tozin.invalidateCache();
                                                                        } else {
                                                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                                                        }
                                                                      }
                                                                    }))
                                                    }else{
                                                     alert(data[0].id+"bbbbb")
                                                     var contractDetailIDRemove = data[0].id;
                                                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                                                    actionURL: "${contextPath}/api/contractDetail/" + contractDetailIDRemove,
                                                                    httpMethod: "DELETE",
                                                                    callback: function (resp) {
                                                                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                                                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                                                            actionURL: "${contextPath}/api/contract/" + idContractRemove,
                                                                            httpMethod: "DELETE",
                                                                            callback: function (resp) {
                                                                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                                                                    isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                                                                                    ListGrid_Tozin.invalidateCache();
                                                                                } else {
                                                                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                                                                }
                                                                              }
                                                                            })
                                                                        )
                                                                    } else {
                                                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                                                    }
                                                                    }
                                                                })
                                                             )}
                                                    })
                                                }
                                            }
                                        });
                                    }}
                            });
                    var ToolStrip_Actions_Contact = isc.ToolStrip.create({
                        width: "100%",
                        height: "100%",
                        members: [
                             ToolStripButton_Contact_Add,ToolStripButton_Contact_Edit,ToolStripButton_Contact_Remove
                        ]
                        });
                    var HLayout_Actions_Contact = isc.HLayout.create({
                         width: "100%",
                         members: [
                         ToolStrip_Actions_Contact
                        ]
                    });
             var RestDataSource_Contract = isc.MyRestDataSource.create({
             fields:
                [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "contractNo", title: "<spring:message code='contract.contractNo'/>"},
                {name: "contractDate", title: "<spring:message code='contract.contractDate'/>"},
                {name: "contactId", title: "<spring:message code='contact.name'/>"},
                {name: "contact.nameFA", title: "<spring:message code='contact.name'/>"},
                {name: "incotermsId", title: "<spring:message code='incoterms.name'/>"},
                {name: "incoterms.code", title: "<spring:message code='incoterms.name'/>"},
                {name: "amount", title: "<spring:message code='global.amount'/>"},
                {name: "sideContractDate", ID: "sideContractDate"},
                {name: "refinaryCost", ID: "refinaryCost"},
                {name: "treatCost", ID: "treatCost"},
                ],
                // ######@@@@###&&@@###
                fetchDataURL: "${contextPath}/api/contract/spec-list"
            });
            var ListGrid_Tozin = isc.ListGrid.create({
                        width: "100%",
                        height: "100%",
                        dataSource: RestDataSource_Contract,
                        initialCriteria: criteriaMo,
                        dataPageSize: 50,
                        showFilterEditor: true,
                        autoFetchData: true,
                        fields:
                        [
                            {name: "id", primaryKey: true, canEdit: false, hidden: true},
                            {name: "contractNo",width: "10%", title: "<spring:message code='contact.no'/>", align: "center",canEdit: false}  ,
                            {name: "contractDate",width: "10%", title: "<spring:message code='contract.contractDate'/>", align: "center",canEdit: true}  ,
                            {name: "contact.nameFA",width: "85%", title: "<spring:message code='contact.name'/>", align: "center"}
                        ]
                        });

           isc.VLayout.create({
                        ID:"VLayout_Tozin_Grid",
                        width: "100%",
                        height: "100%",
                        members: [
                        HLayout_Actions_Contact,
                        ListGrid_Tozin
                        ]
                        });

/////////////////////////////////////////////////



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
            icon: "icons/16/world.png",
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
function pageMolibdenAll(method){
    if(method==0){
        methodUrl="POST";
        }else{
        methodUrl="PUT";
        }
Window_Contact = isc.Window.create({
                title: "<spring:message code='contact.title'/>",
                width: "100%",
                height: "100%",
                autoCenter: true,
                isModal: true,
                showModalMask: true,
                align: "center",
                autoDraw: false,
                autoScroller:true,
                closeClick: function () {
                this.Super("closeClick", arguments);
                },
                items: [

                ]
                });
    //START PAGE ONE
    factoryLableHedear("LablePage", '<font color="#ffffff"><b>NATIONAL IRANIAN COPPER INDUSTRIES CO.<b></font>', "100%", "10", 4)
    factoryLable("lableNameContact", '<b><font size=4px>Molybdenum Oxide Contract-BAPCO/NICICO</font><b>', "100%", '2%', 2);
    factoryLable("lableArticle2", '<b><font size=4px>ARTICLE 2 -QUANTITY :</font><b>', "100%", '2%', 20);
    factoryLable("lableImportantNote", '<b><font size=2px>IMPORTANT Note :</font><b>', "100%", '4%', 20);
    factoryLableArticle("lableArticle1", '<b><font size=4px>ARTICLE 1 - DEFINITIONS:</font><b>', "30", 5)
    factoryLableArticle("lableArticle3", '<b><font size=4px>Article 3 -QUANTITY</font><b>', "30", 5)
    factoryLableArticle("lableArticle6", '<b><font size=4px>ARTICLE 6 -</font><b>', "30", 5)
    factoryLableArticle("lableArticle7", '<b><font size=4px>ARTICLE 7 -</font><b>', '30', 5);
    factoryLableArticle("lableArticle8", '<b><font size=4px>ARTICLE 8 -</font><b>', '30', 5);
    factoryLableArticle("lableArticle9", '<b><font size=4px>ARTICLE 9 -</font><b>', '30', 5);
    factoryLableArticle("lableArticle10", '<b><font size=4px>ARTICLE 10  - CURRENCY OPTION:</font><b>', '30', 5);
    factoryLableArticle("lableContainerized", '<b><font size=4px>CONTAINERIZED DELIVERY:</font><b>', "30", 5)
    var lable_article2_1 = isc.Label.create({
        wrap: false,
        padding: 5,
        contents: '<b><font size=2px>  OPTION WILL BE CONSIDERED FOR EACH SHIPMENT QUANTITY.</font><b>'
    })
    var DynamicForm_ContactHeader = isc.DynamicForm.create({
        valuesManager: "contactHeader",
        wrapItemTitles: false,
        setMethod: 'POST',
        width: "100%",
        height: "100%",
        align: "left",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "80",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        cellPadding: 2,
        numCols: 4,
        fields: [
            {name: "id", hidden: true},
            {name: "contractDate", hidden: true,},
            {
                name: "createDateDumy",
                title: "<spring:message code='contact.date'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: "date",
                format: 'DD-MM-YYYY',
                required: true,
                width: "90%",
                wrapTitle: false
            },
            {
                name: "contractNo",
                title: "<spring:message code='contact.no'/>",
                requiredMessage: "<spring:message code='validator.field.is.required'/>",
                required: true,
                readonly: true,
                width: "90%",
                wrapTitle: false
            }
        ]
    });
    var dynamicForm1 = isc.HLayout.create({align: "center", members: []});
    var dynamicForm2 = isc.HLayout.create({align: "center", members: []});
    var dynamicForm3 = isc.HLayout.create({align: "center", members: []});
    var dynamicForm4 = isc.HLayout.create({align: "center", members: []});
var DynamicForm_ContactCustomer = isc.DynamicForm.create({
        setMethod: 'POST',
        valuesManager: "contactHeader",
        width: "100%",
        height: "100%",
        numCols: 4,
        wrapItemTitles: false,
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        fields: [
            {name: "id", canEdit: false, hidden: true},
            {
                name: "contactId",
                showHover: true,
                required: true,
                autoFetchData: false,
                title: "<spring:message code='contact.name'/>",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                optionCriteria: RestDataSource_ContactBUYER_optionCriteria,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "700",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center"}
                ],
                changed: function (form, item, value) {
                    var address = "";
                    var name = "";
                    var phone = "";
                    var mobile = "";
                    if (item.getSelectedRecord().address != undefined) {
                        address = item.getSelectedRecord().address;
                        Contact_ContactBuyer.setValue("address_ContactBuyer", address);
                    }
                    if (item.getSelectedRecord().nameEN != undefined) {
                        name = item.getSelectedRecord().nameEN;
                        Contact_ContactBuyer.setValue("name_ContactBuyer", name);
                    }
                    if (item.getSelectedRecord().phone != undefined) {
                        phone = item.getSelectedRecord().phone;
                        Contact_ContactBuyer.setValue("phone_ContactBuyer", phone);
                    }
                    if (item.getSelectedRecord().mobile != undefined) {
                        mobile = item.getSelectedRecord().mobile;
                        Contact_ContactBuyer.setValue("phone_ContactBuyer", phone);
                    }
                }
            },
            {
                name: "contactByBuyerAgentId",
                showHover: true,
                autoFetchData: false,
                title: "<spring:message code='contact.commercialRole.agentBuyer'/>",
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                optionCriteria: RestDataSource_ContactAgentBuyer_optionCriteria,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "700",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center"}
                ],
                changed: function (form, item, value) {
                    var address = "";
                    var name = "";
                    var phone = "";
                    var mobile = "";
                    if (item.getSelectedRecord().address != undefined) {
                        address = item.getSelectedRecord().address;
                        Contact_ContactAgentBuyer.setValue("address_ContactAgentBuyer", address);
                    }
                    if (item.getSelectedRecord().nameEN != undefined) {
                        name = item.getSelectedRecord().nameEN;
                        Contact_ContactAgentBuyer.setValue("name_ContactAgentBuyer", name);
                    }
                    if (item.getSelectedRecord().phone != undefined) {
                        phone = item.getSelectedRecord().phone;
                        Contact_ContactAgentBuyer.setValue("phone_ContactAgentBuyer", phone);
                    }
                    if (item.getSelectedRecord().mobile != undefined) {
                        mobile = item.getSelectedRecord().mobile;
                        Contact_ContactAgentBuyer.setValue("mobile_ContactAgentBuyer", mobile);
                    }
                }
            }
        ]
    });
    isc.DynamicForm.create({
                                ID: "Contact_ContactBuyer",
                                valuesManager: "contactHeaderAgent",
                                height: "20",
                                width: "50%",
                                disabled: "true",
                                wrapItemTitles: true,
                                items: [
                                    {
                                        name: "name_ContactBuyer",
                                        type: "text",
                                        length: 250,
                                        showTitle: true,
                                        colSpan: 2,
                                        width: "*",
                                        title: "NAME"
                                    }
                                    , {
                                        name: "phone_ContactBuyer",
                                        type: "text",
                                        length: 100,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Phone",
                                        width: "*"
                                    }, {
                                        name: "mobile_ContactBuyer",
                                        type: "text",
                                        length: 100,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Mobile",
                                        width: "*"
                                    },
                                    {
                                        name: "address_ContactBuyer",
                                        type: "text",
                                        length: 5000,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Address",
                                        width: "*"
                                    }
                                ]
                            })
    dynamicForm1.addMember("Contact_ContactBuyer",1);
    isc.DynamicForm.create({
                                ID: "Contact_ContactAgentBuyer",
                                valuesManager: "contactHeaderAgent",
                                height: "20",
                                width: "50%",
                                disabled: "true",
                                wrapItemTitles: true,
                                items: [
                                    {
                                        name: "name_ContactAgentBuyer",
                                        type: "text",
                                        length: 250,
                                        showTitle: true,
                                        colSpan: 2,
                                        width: "*",
                                        title: "NAME"
                                    }
                                    , {
                                        name: "phone_ContactAgentBuyer",
                                        type: "text",
                                        length: 100,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Phone",
                                        width: "*"
                                    }, {
                                        name: "mobile_ContactAgentBuyer",
                                        type: "text",
                                        length: 100,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Mobile",
                                        width: "*"
                                    },
                                    {
                                        name: "address_ContactAgentBuyer",
                                        type: "text",
                                        length: 5000,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Address",
                                        width: "*"
                                    }
                                ]
                            })
    dynamicForm2.addMember("Contact_ContactAgentBuyer",2);
    var DynamicForm_ContactSeller = isc.DynamicForm.create({
        valuesManager: "contactHeader",
        width: "100%",
        height: "100%",
        numCols: 4,
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        wrapItemTitles: false,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        fields: [
            {name: "id", canEdit: false, hidden: true},
            {
                name: "contactBySellerId",
                numCols: 2,
                showHover: true,
                autoFetchData: false,
                title: "Seller",
                required: true,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                optionCriteria: RestDataSource_Contact_optionCriteria,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "700",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center"}
                ],
                changed: function (form, item, value) {
                    var address = "";
                    var name = "";
                    var phone = "";
                    var mobile = "";
                    if (item.getSelectedRecord().address != undefined) {
                        address = item.getSelectedRecord().address;
                        Contact_ContactSeller.setValue("address_ContactSeller", address);
                    }
                    if (item.getSelectedRecord().nameEN != undefined) {
                        name = item.getSelectedRecord().nameEN;
                        Contact_ContactSeller.setValue("name_ContactSeller", name);
                    }
                    if (item.getSelectedRecord().phone != undefined) {
                        phone = item.getSelectedRecord().phone;
                        Contact_ContactSeller.setValue("phone_ContactSeller", phone);
                    }
                    if (item.getSelectedRecord().mobile != undefined) {
                        mobile = item.getSelectedRecord().mobile;
                        Contact_ContactSeller.setValue("mobile_ContactSeller", mobile);
                    }
                }
            },
            {
                name: "contactBySellerAgentId",
                numCols: 2,
                showHover: true,
                autoFetchData: false,
                title: "Agent Seller",
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                optionCriteria: RestDataSource_ContactAgentSeller_optionCriteria,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "700",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center"}
                ],
                changed: function (form, item, value) {
                    var address = "";
                    var name = "";
                    var phone = "";
                    var mobile = "";
                    if (item.getSelectedRecord().address != undefined) {
                        address = item.getSelectedRecord().address;
                        Contact_ContactAgentSeller.setValue("address_ContactAgentSeller", address);
                    }
                    if (item.getSelectedRecord().nameEN != undefined) {
                        name = item.getSelectedRecord().nameEN;
                        Contact_ContactAgentSeller.setValue("name_ContactAgentSeller", name);
                    }
                    if (item.getSelectedRecord().phone != undefined) {
                        phone = item.getSelectedRecord().phone;
                        Contact_ContactAgentSeller.setValue("phone_ContactAgentSeller", phone);
                    }
                    if (item.getSelectedRecord().mobile != undefined) {
                        mobile = item.getSelectedRecord().mobile;
                        Contact_ContactAgentSeller.setValue("mobile_ContactAgentSeller", mobile);
                    }
                }
            }
        ]
    });

    isc.DynamicForm.create({
                                ID: "Contact_ContactSeller",
                                valuesManager: "contactHeaderAgent",
                                height: "20",
                                width: "50%",
                                disabled: "true",
                                wrapItemTitles: true,
                                items: [
                                    {
                                        name: "name_ContactSeller",
                                        type: "text",
                                        length: 250,
                                        showTitle: true,
                                        colSpan: 2,
                                        width: "*",
                                        title: "NAME"
                                    }
                                    , {
                                        name: "phone_ContactSeller",
                                        type: "text",
                                        length: 100,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Phone",
                                        width: "*"
                                    }, {
                                        name: "mobile_ContactSeller",
                                        type: "text",
                                        length: 100,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Mobile",
                                        width: "*"
                                    },
                                    {
                                        name: "address_ContactSeller",
                                        type: "text",
                                        length: 5000,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Address",
                                        width: "*"
                                    }
                                ]
                            })
    dynamicForm3.addMember("Contact_ContactSeller",3);
    isc.DynamicForm.create({
                                ID: "Contact_ContactAgentSeller",
                                valuesManager: "contactHeaderAgent",
                                height: "20",
                                width: "50%",
                                disabled: "true",
                                wrapItemTitles: true,
                                items: [
                                    {
                                        name: "name_ContactAgentSeller",
                                        type: "text",
                                        length: 250,
                                        showTitle: true,
                                        colSpan: 2,
                                        width: "*",
                                        title: "NAME"
                                    }
                                    , {
                                        name: "phone_ContactAgentSeller",
                                        type: "text",
                                        length: 100,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Phone",
                                        width: "*"
                                    }, {
                                        name: "mobile_ContactAgentSeller",
                                        type: "text",
                                        length: 100,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Mobile",
                                        width: "*"
                                    },
                                    {
                                        name: "address_ContactAgentSeller",
                                        type: "text",
                                        length: 5000,
                                        showTitle: true,
                                        colSpan: 2,
                                        title: "Address",
                                        width: "*"
                                    }
                                ]
                            })
     dynamicForm4.addMember("Contact_ContactAgentSeller",4);

isc.DynamicForm.create({
        ID:"DynamicForm_ContactParameter_ValueNumber8",
        valuesManager: "valuesManagerArticle1",
        height: "20",
        width: "100%",
        wrapItemTitles: true,
        items: [
            {name: "feild_all_defintitons_save", showIf: "false"},
            {
                name: "definitionsOne",
                length: 5000,
                startRow: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                displayField: "paramValue",
                valueField: "paramValue",
                showTitle: false,
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "paramName", width: "20%", align: "center"},
                    {name: "paramType", width: "20%", align: "center"},
                    {name: "paramValue", width: "60%", align: "center"}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                    {fieldName: "contractId", operator: "equals", value: 1},
                    {fieldName:"categoryValue",operator:"equals",value:1}]
                    },
                width: "1500",
                height: "30",
                title: "NAME",
                changed: function (form, item, value) {
                    DynamicForm_ContactParameter_ValueNumber8.setValue("definitionsOne", item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue)
                }
                },{
                    name:"button",
                    type: "button",
                    width: "10%",
                    height: "30",
                    title: "Remove",
                    startRow: false,
                    icon: "icons/16/message.png",
                    click: function(){DynamicForm_ContactParameter_ValueNumber8.removeField("definitionsOne");DynamicForm_ContactParameter_ValueNumber8.removeField("button")}
                    }
        ]
    })

    HLayout_button_ValueNumber8 = isc.HLayout.create({
        members: [
            isc.Label.create({
                styleName: "buttonHtml buttonHtml1",
                align: "center",
                valign: "center",
                wrap: false,
                contents: "Add",
                click: function(){itemsDefinitions('Add',itemsDefinitionsCount)}
            }),
            isc.Label.create({
                styleName: "buttonHtml buttonHtml3",
                align: "center",
                valign: "center",
                wrap: false,
                contents: "Remove",
                click: function(){itemsDefinitions('Remove',itemsDefinitionsCount)}
            })
        ]
    })


    var VLayout_ContactParameter_ValueNumber8 = isc.VLayout.create({
        width: "100%",
        members: [DynamicForm_ContactParameter_ValueNumber8, HLayout_button_ValueNumber8]
    })


    var article2 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle2",
        height: "50%",
        numCols: 14,
        wrapItemTitles: false,
        items: [
            {
                type: "number",
                width: "80",
                name: "amount",
                defaultValue: "",
                title: "",
                showTitle: false,
                keyPressFilter: "[0-9]", ///article2_number10
                changed: function (form, item, value) {
                    article2.setValue("amount_en", numberToEnglish(value))
                    }
            },
            {
                type: "text", styleName: "textToLable", width: "200",
                name: "amount_en", title: "", showTitle: false, disabled: "true"
            }, ///english,
            {
                name: "unitId", //article2_number12
                title: "",
                type: 'long',
                width: "150",
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
                ],changed: function (form, item, value) {
                    dynamicForm_article3_3.setValue("article3_number17_13",article2.getItem("unitId").getDisplayValue(value));
                }
            },
            {
                type: "text",
                width: "80",
                name: "molybdenumTolorance",
                title: "+/-",
                defaultValue: "10",
                keyPressFilter: "[0-9]", //article2_13
                changed: function (form, item, value) {
                    article2_1.setValue("article2_13_1", value);
                    dynamicForm_article3_3.setValue("article3_number17_4",value);
                    dynamicForm_article3.setValue("article3_number17_9", value);
                    dynamicForm_article5_number29_1.setValue("article5_number29_3", value);
                }
            },
            {
                type: "text",
                width: "100",
                name: "optional", //article2_14
                startRow: false,
                title: '<b><font size=2px>(IN</font><b>',
                valueMap: {
                    "1": "SELLERS",
                    "2": "BUYER"
                },
                changed: function (form, item, value) {
                    article2_1.setValue("responsibleTelerons", value);
                    dynamicForm_article3_3.setValue("article3_number17_5", "(" + article2.getItem("optional").getDisplayValue(value) + " " + "'S OPTION) IN PARTIAL SHIPMENT")
                }
            },
            {
                type: "text",
                name: "plant", //article2_15
                width: "500",
                startRow: false,
                title: '<b><font size=2px>OPTION) PRODUCED IN</font><b>'
            }
        ]
    });
    var article2_1 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle2",
        height: "100%",
        numCols: 6,
        wrapItemTitles: false,
        items: [
            {
                type: "text",
                name: "article2_13_1",
                width: "50",
                startRow: false, keyPressFilter: "[0-9]",
                title: '<b><font size=2px>THE TOLERENCE OF +/-%</font><b>'
            },
            {
                type: "text",
                width: "150",
                name: "responsibleTelerons",
                startRow: false,
                title: '<b><font size=2px>(IN</font><b>',
                valueMap: {
                    "1": "SELLERS",
                    "2": "BUYER"
                }
            }
        ]
    })
lotList = isc.ListGrid.create({
        width: "100%",
        height: "180",
        dataSource: RestDataSource_WarehouseLot,
        dataPageSize: 50,
        autoSaveEdits: false,
        autoFetchData: false,
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "contractId", title: "contractId",canEdit: false, hidden: true},
                {
                    name: "warehouseNo",
                    canEdit: false,
                    title: "<spring:message code='dailyWarehouse.warehouseNo'/>",
                    align: "center",hidden: true
                },
                {name: "plant", canEdit: false, title: "<spring:message code='dailyWarehouse.plant'/>", align: "center",hidden: true},
                {name: "material.descl", canEdit: false, title: "<spring:message code='goods.nameLatin'/> "},
                {
                    name: "lotName",
                    canEdit: false,
                    title: "<spring:message code='warehouseLot.lotName'/>",
                    align: "center"
                },
                {name: "mo", canEdit: false, title: "<spring:message code='warehouseLot.mo'/>", align: "center"},
                {name: "cu", canEdit: false, title: "<spring:message code='warehouseLot.cu'/>", align: "center"},
                {name: "si", canEdit: false, title: "<spring:message code='warehouseLot.si'/>", align: "center"},
                {name: "pb", canEdit: false, title: "<spring:message code='warehouseLot.pb'/>", align: "center"},
                {name: "s", canEdit: false, title: "<spring:message code='warehouseLot.s'/>", align: "center"},
                {name: "c", canEdit: false, title: "<spring:message code='warehouseLot.c'/>", align: "center"},
                {name: "p", canEdit: false, title: "<spring:message code='warehouseLot.p'/>", align: "center"},
                {name: "used", type: "boolean", title: "used", canEdit: true, align: "center"}
            ]
    });



var vlayoutBody = isc.VLayout.create({
        width: "100%",
        height: "8%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({align: "left", members: [DynamicForm_ContactHeader]}),
            isc.HLayout.create({height: "50", align: "left", members: [lableNameContact]}),
            isc.HLayout.create({align: "left", members: [DynamicForm_ContactCustomer]}),
            isc.HLayout.create({ID: "dynamicForm1And2", align: "center", members: [dynamicForm1, dynamicForm2]}),
            isc.HLayout.create({align: "center", members: [DynamicForm_ContactSeller]}),
            isc.HLayout.create({ID: "dynamicForm3And4", align: "center", members: [dynamicForm3, dynamicForm4]})
        ]
    });
var vlayoutArticle1 = isc.VLayout.create({
        width: "100%",
        height: "30%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({
                align: "left",
                members: [lableArticle1]
            }),
            isc.HLayout.create({align: "left", members: [VLayout_ContactParameter_ValueNumber8]})
        ]
    });
var vlayoutArticle2 = isc.VLayout.create({
        width: "100%",
        height: "30%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "center", members: [lableArticle2]}),
            isc.HLayout.create({align: "left", members: [article2]}),
            isc.HLayout.create({align: "left", members: [article2_1, lable_article2_1]})
        ]
    });
var vlayoutArticle3 = isc.VLayout.create({
        width: "100%",
        height: "30%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "5%", align: "left", members: [lableArticle3]}),
            isc.HLayout.create({height: "95%", width: "100%", align: "center", members: [lotList]})
        ]
    });
    isc.VLayout.create({
        ID: "VLayout_PageOne_Contract",
        width: "100%",
        height: "100%",
        align: "center",
        overflow: "scroll",
        members: [
            isc.HStack.create({height: "10",width: "100%",align: "center",members: [LablePage]}),
            vlayoutBody,
            vlayoutArticle1,
            vlayoutArticle2,
            vlayoutArticle3
        ]
    });

    //END PAGE ONE

    //START PAGE TOW
    factoryLableHedear("LablePageTwo", '<b>Page 2 of Molybdenum Oxide Contact - BAPCO/NICIO<b>', "100%", "2%", 20)
    factoryLableArticle("lableArticle3Typicall", '<b><font size=4px>TYPICAL ANALYSIS: </font><b>', '5%', 1);
    factoryLableArticle("lableArticle4", '<b><font size=4px>ARTICLE 4 - </font><b>', '2%', 1);
    factoryLableArticle("lableArticle5", '<b><font size=4px>ARTICLE 5 - </font><b>', "20", 1)

var dynamicForm_article3_1 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle3",
        height: "20",
        wrapItemTitles: false,
        items: [
            {
                name: "contactInspectionId", ///article3_number17_1
                showHover: true,
                autoFetchData: false,
                title: "",
                hint: "AHK",
                width: "150",
                showHintInField: true,
                showTitle: false,
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                displayField: "paramName",
                valueField: "paramName",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "paramName", width: "45%", align: "center"},
                    {name: "paramType", width: "45%", align: "center"},
                    {name: "paramValue", width: "10%", align: "center"}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                    {fieldName: "contractId", operator: "equals", value: 1},
                    {fieldName:"categoryValue",operator:"equals",value:3}]
                    },
                changed: function (form, item, value) {
                    dynamicForm_article3.setValue("article3_number17",value);
                    dynamicForm_article3.setValue("quantity_number17_11", value);
                }
            }
        ]
    })

    var dynamicForm_article3 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle3",
        height: "4%",
        numCols: 10,
        wrapItemTitles: false,
        items: [
            {
                type: "text",
                name: "article3_number17",
                showTitle: false,
                width: "150",
                startRow: false,
                title: ''
            }, {
                type: "text",
                name: "article3_number17_7",
                showTitle: false,
                width: "350",
                startRow: false,
                title: 'article3_number17_7'
            }, {
                type: "text",
                name: "article3_number17_8",
                showTitle: true,
                width: "50",
                startRow: false,
                keyPressFilter: "[0-9]",
                title: '('
            }, {
                type: "text",
                name: "article3_number17_9",
                showTitle: true,
                width: "50",
                startRow: false, keyPressFilter: "[0-9]",
                title: '+/-'
            }, {
                type: "text",
                name: "article3_number17_10",
                showTitle: false,
                width: "350",
                defaultValue: "IN SELLER 'S OPTION)WHICH WILL BE PERFORMED AT ",
                startRow: false,
                title: 'article3_number17_10'
            }, {
                type: "text",
                name: "article3_number17_11",
                showTitle: false,
                width: "50",
                startRow: false,
                title: 'quantity_number17_11'
            }, {
                type: "text",
                name: "article3_number17_12",
                showTitle: false,
                width: "350",
                startRow: false,
                defaultValue: "IS FINAL AND BINDING FOR SETTLEMENT PURPOSES.",
                title: 'quantity_number17_12'
            }
        ]
    })

    dynamicForm_article3.setValue("quantity_number17_7", "ANALYSIS RESULTS FOR THE REMAINING QUANTITY(");

    var dynamicForm_article3_2 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle3",
        height: "20",
        width: "50%",
        wrapItemTitles: true,
        items: [
            {
                name: "article3_number17_2",
                type: "text",
                length: 150,
                showTitle: false,
                colSpan: 2,
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                displayField: "paramValue",
                valueField: "paramName",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "paramName", width: "20%", align: "center"},
                    {name: "paramType", width: "20%", align: "center"},
                    {name: "paramValue", width: "60%", align: "center"}
                ],
                width: "*",
                title: "quantity_number17_2"
            }
        ]
    })
    dynamicForm_article3_2.setValue("quantity_number17_2", "'S ANALYSIS RESULTS AS PER ABOVE ASSYS WHICH IS BIENG PERFORMED AT AHK IS FINAL AND BINDING FOR SETTLEMENT PURPOSES.");
    dynamicForm_article3_Typicall = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle3",
        height: "20",
        numCols: 10,
        wrapItemTitles: false,
        items: [
            {name: "title",disabled:"false",defaultValue:"Prefix",width:"80",title: "TITLE",startRow:true},       //title
            {name: "titleValue",disabled:"false",defaultValue:"Value",title: "",width:"100",keyPressFilter: "[0-9]",showTitle: false,startRow:false},
            {name: "titleTolerance",disabled:"false",defaultValue:"Tolerance",title: "",width:"100",showTitle: false,startRow:false},
            {name: "titleUnit",disabled:"false",defaultValue:"Unit",title: "",width:"100",showTitle: false,startRow:false},
            {name: "PrefixMolybdenum",width:"80",title: "MO",defaultValue: "64(+-)4",startRow:true},       //molybdenum
            {name: "molybdenum",title: "",width:"100",showTitle: false,startRow:false},
            {name: "toleranceMO",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitMO",title:"",width:"100",showTitle:false,startRow:false,editorType: "SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 440, align: "center"}]},
            {name: "PrefixCopper",width:"80",defaultValue: "<=1.7",title: "CU",startRow:true},           //copper
            {name: "copper",title: "",width:"100",keyPressFilter: "[0-9]",showTitle: false,startRow:false},
            {name: "toleranceCU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitCU",title:"",width:"100",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 440, align: "center"}]},
            {name: "PrefixC",width:"80",defaultValue: "<=0.04", title: "C",startRow:true},            //C
            {name: "typical_c",title: "",width:"100", keyPressFilter: "[0-9]",showTitle: false,startRow:false},
            {name: "toleranceC",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitC",title:"",width:"100",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 440, align: "center"}]},
            {name: "PrefixS",width:"80",defaultValue: "<=0.12",title: "S",startRow:true},                 //S
            {name: "typical_s",title: "",width:"100", keyPressFilter: "[0-9]",showTitle: false,startRow:false},
            {name: "toleranceS",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitS",title:"",width:"100",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 440, align: "center"}]},
            {name: "PrefixPb",width:"80",defaultValue: "<=0.12", title: "Pb",startRow:true},               //Pb
            {name: "typical_pb",title: "",width:"100", keyPressFilter: "[0-9]",showTitle: false,startRow:false},
            {name: "tolerancePb",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitPb",title:"",width:"100",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 440, align: "center"}]},
            {name: "PrefixP",width:"80",defaultValue: "<=0.04", title: "P",startRow:true},               //P
            {name: "typical_p",title: "",width:"100", keyPressFilter: "[0-9]",showTitle: false,startRow:false},
            {name: "toleranceP",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitP",title:"",width:"100",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 440, align: "center"}]},
            {name: "PrefixSi",width:"80", defaultValue: "<=1.1",title: "Si",startRow:true},               //Si
            {name: "typical_Si",title: "",width:"100",keyPressFilter: "[0-9]",showTitle: false,startRow:false},
            {name: "toleranceSi",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitSi",title:"",width:"100",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 440, align: "center"}]}
        ]
    })
    var dynamicForm_article3_3 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle3",
        height: "50",
        numCols: 10,
        wrapItemTitles: false,
        items: [
            {
                type: "text",
                name: "article3_number17_3",
                showTitle: true,
                length: 100,
                width: "100",
                defaultValue: "210",
                showHintInField: true, keyPressFilter: "[0-9]",
                startRow: false,
                title: '- ',
                changed: function (form, item, value) {
                    dynamicForm_article3.setValue("article3_number17_8", value);
                    dynamicForm_article5_number29_1.setValue("article5_number29_2", value);
                }
            },{
                type: "text",
                name: "article3_number17_13",  ////to do new
                showTitle: false,
                length: 100,
                width: "100",
                showHintInField: true,
                startRow: false,
                title: '',
            }
                , {
                type: "text",
                name: "article3_number17_4",
                showTitle: true,
                length: 100,
                width: "100",
                defaultValue: "10",
                showHintInField: true,
                startRow: false,
                title: '+/-', keyPressFilter: "[0-9]",
                changed: function (form, item, value) {
                    dynamicForm_article3.setValue("article3_number17_9", value);
                    dynamicForm_article5_number29_1.setValue("article5_number29_3", value);
                }
            }, {
                type: "text",
                name: "article3_number17_5",
                showTitle: false,
                width: "500",
                wrap: false,
                startRow: false,
                title: 'quantity_number17_5'
            },{
                type: "selectItem",
                name: "article3_number17_6",
                showTitle: false,
                width: "100",
                defult: "TILL",
                showHintInField: true,
                startRow: false,
                title: 'quantity_number17_6',
                valueMap: {
                    "AFTER": "AFTER",
                    "TILL": "TILL",
                    "BEFORE": "BEFORE"
                },changed: function (form, item, value) {
                    dynamicForm_article5_number24_number25_number26.setValue("article5_number26", value);
                    dynamicForm_article5_number29_1.setValue("article5_number29_5", value);
                }
            },
              {
                name: "DateDumy",           // to do new
                title: "<spring:message code='contact.date'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: "date",
                format: 'DD-MM-YYYY',
                required: false,
                startRow: false,
                wrapTitle: false,
                showTitle: false
            },
        ]
    })
    var dynamicForm_article4_number18 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle4",
        height: "100%",
        wrapItemTitles: false,
        items: [
            {
                name: "article4_number18",
                showTitle: false,
                defaultValue: "PACKING",
                width: "100",
                startRow: false,
                title: ''
            }
        ]
    })
    var dynamicForm_article4_1_number19 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle4",
        height: "100%",
        numCols: 6,
        wrapItemTitles: false,
        items: [
            {
                name: "amount_number19_1",
                showTitle: false,
                width: "250",
                defaultValue: "IN STEEL DRUMS OF ",
                startRow: false,
                title: ''
            }, {
                name: "mo_amount", //amount_number19
                showTitle: false,
                width: "70",
                defaultValue: "220",
                keyPressFilter: "[0-9]",
                showHintInField: true,
                startRow: false,
                title: ''
            }, {
                name: "amount_number19_2",
                showTitle: false,
                width: "350",
                defaultValue: " LITERS,WITH LIDS SECURED BY RINGS ON PALLETS.",
                startRow: false,
                title: ''
            }
        ]
    })
    var dynamicForm_article5_number20 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle5",
        height: "20",
        wrapItemTitles: false,
        items: [
            {
                name: "shipment_number20",
                showTitle: false,
                defaultValue: "SHIPMENT",
                showHintInField: true,
                width: "100",
                startRow: false
            }
        ]
    })
    var dynamicForm_article5_number21 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle5",
        height: "20",
        numCols: 14,
        wrapItemTitles: false,
        items: [
            {
                name: "timeIssuance", //article5_number21
                showTitle: true,
                defaultValue: "AFTER RECEIPT",
                showHintInField: true,
                width: "150",
                startRow: false,
                title: 'SHIPMENT SHALL BE PERFORMED'
            }, {
                name: "prefixPayment", //article5_number22
                showTitle: true,
                width: "100",
                defaultValue: "105%",
                showHintInField: true,
                startRow: false,
                title: 'OF',
                changed: function (form, item, value) {
                    dynamicForm_article9_number46.setValue("article9_number22", value);
                    dynamicForm_article9_number46.setValue("article9_Englishi_number22", numberToEnglish(value) + " PERCENT");
                    dynamicForm_article9_number46_number47_number48_number49.setValue("article9_number22", value);
                    dynamicForm_article9_number46_number47_number48_number49.setValue("article9_Englishi_number22", value);
                }
            }, {
                name: "invoiceType", //article5_number23
                showTitle: true,
                width: "250",
                defaultValue: "PROFORMA/PROVISIONAL",
                showHintInField: true,
                startRow: false,
                title: 'OF VALUE AMOUNT OF ',
                changed: function (form, item, value) {
                    dynamicForm_article9_number46.setValue("article9_number23", value);
                    dynamicForm_article9_number46_number47_number48_number49.setValue("article9_number23", value);
                }
            }, {
                name: "article5_number21_6",
                showTitle: false,
                width: "150",
                defaultValue: " INVOICE PRIOR EACH",
                showHintInField: true,
                startRow: false
            }
        ]
    })
    var dynamicForm_article5_number24_number25_number26 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle5",
        height: "20",
        numCols: 12,
        wrapItemTitles: false,
        items: [
            {
                name: "runStartDate", //article5_number24_number25
                width: "250",
                title: 'SHIPMENT COMMENCING FROM ',
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: "date",
                format: 'DD-MM-YYYY',
                required: false,
                startRow: false,
                wrapTitle: false,
                showTitle: true
            },{
                name: "runTill", ///article5_number26
                showTitle: false,
                width: "170",
                defult: "TILL",
                showHintInField: true,
                startRow: false,
                valueMap: {
                    "AFTER": "AFTER",
                    "TILL": "TILL",
                    "BEFORE": "BEFORE"
                },
                title: ''
            },
              {
                name: "runEndtDate",
                title: "<spring:message code='contact.date'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: "date",
                format: 'DD-MM-YYYY',
                required: false,
                startRow: false,
                wrapTitle: false,
                showTitle: false
            },{
                name: "article5_number26_1",
                width: "200",
                showTitle: false,
                defaultValue: "AS PER FOLLOWING:",
                startRow: false,
            },
            {
                type: "button",
                width: 150,
                startRow: false,
                title: "Add Item Shipment",
                click: "ListGrid_ContractItemShipment.startEditingNew()"
            }
        ]
    })
    ///*//*** to do
ListGrid_ContractItemShipment = isc.ListGrid.create({
        width: "79%",
        height: "200",
        modalEditing: true,
        canEdit: true,
        canRemoveRecords: true,
        autoFetchData: false,
        autoSaveEdits: true,
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
                    align: "center"
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    defaultValue: "<%=dateUtil.todayDate()%>",
                    type: "date",
                    required: false,
                    width: "200",
                    wrapTitle: false,
                },
                {
                    name: "duration",
                    title: "<spring:message code='global.duration'/>",
                    type : 'text',
                    width: 100,
                    align: "center"
                },
                {
                    name: "tolorance", title: "<spring:message code='contractItemShipment.tolorance'/>", type: 'text', width: 80, align: "center"
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
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>.");
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
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            ListGrid_ContractItemShipment.invalidateCache();
                            isc.say("<spring:message code='global.grid.record.remove.success'/>.");
                        } else {
                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                        }
                    }
                })
            );
        }

    });
    var vlayout_ContractItemShipment = isc.VLayout.create({align: "center", members: [ListGrid_ContractItemShipment]});
    var dynamicForm_article5_Note2_number30 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticleNote5",
        height: "20",
        wrapItemTitles: false,
        numCols: 2,
        width: "100%",
        items: [
            {
                type: "Label",
                name: "article5_Note1_lable",
                width: "150",
                height: "25",
                showTitle: false,
                wrap: true,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                displayField: "paramValue",
                valueField: "paramName",
                showTitle: false,
                pickListWidth: "800",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "paramName", width: "25%", align: "center"},
                    {name: "paramType", width: "25%", align: "center"},
                    {name: "paramValue", width: "50%", align: "center"}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                    {fieldName: "contractId", operator: "equals", value: 1},
                    {fieldName:"categoryValue",operator:"equals",value:5}]
                    },
                changed: function (form, item, value) {
                    dynamicForm_article5_Note2_number30.setValue("article5_Note1_value", item.getSelectedRecord().paramValue);
                },
                startRow: false,
                title: ''
            },
            {
                name: "article5_Note1_value",
                type: "text",
                length: 3000,
                showTitle: false,
                startRow: true,
                wrap: false,
                width: "1500",
                height: "80",
                defaultValue: "MAXIMUM ONE WEEK AFTER CONTRACT SIGNATURE/STAMP BUYER IS OBLIGED TO INFORM SELLER OF ITS SHIPMENT SCHEDULE FOR THE REMAINING QUANTITY I.E",
                title: "article5_Note1",
            },
                {
                    name:"button",
                    type: "button",
                    width: "10%",
                    height: "30",
                    title: "Remove",
                    startRow: false,
                    icon: "icons/16/message.png",
                    click: function(){dynamicForm_article5_Note2_number30.removeFields(["article5_Note1_lable", "article5_Note1_value","button"])}
                    }
        ]
    })

    isc.HLayout.create({
        ID: "buttonNote", width: "100%", height: "100%", membersMargin: 20,
        members: [
            isc.Label.create({
                styleName: "buttonHtml buttonHtml1",
                align: "center",
                valign: "center",
                wrap: false,
                contents: "Add",
                click: function(){manageNote('Add',imanageNote)}
            }),
            isc.Label.create({
                styleName: "buttonHtml buttonHtml3",
                align: "center",
                valign: "center",
                wrap: false,
                contents: "Remove",
                click: function(){manageNote('Remove',imanageNote)}
            })
        ]
    })

    var hlayuotNote = isc.VLayout.create({
        height: "30",
        align: "left",
        members: [dynamicForm_article5_Note2_number30, buttonNote]
    })

    var dynamicForm_article6_number31 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6",
        height: "20",
        numCols: 4,
        width: "20%",
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article6_number31",
                width: "200",
                showTitle: false,
                showHintInField: true,
                defaultValue: "DELIVERY TERMS",
                startRow: false,
                title: ''
            }
        ]
    })
    var dynamicForm_article6_number32_33_34_35 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6",
        height: "20",
        numCols: 12,
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article6_number31_1",
                width: "470",
                showTitle: false,
                defaultValue: "THE MATERIAL SHALL BE DELIVERED BY SELLER TO BUYER ON",
                startRow: false,
                title: ''
            },
            {
                name: "incotermsId", //article6_number32
                colSpan: 3,
                titleColSpan: 1,
                width: "150",
                tabIndex: 6,
                showTitle: false,
                showHover: true,
                showHintInField: true,
                hint: "FOB",
                required: false,
                title: "<spring:message code='incoterms.name'/>",
                type: 'long',
                numCols: 4,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Incoterms,
                displayField: "code",
                valueField: "id",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "code", width: 440, align: "center"}
                ],
                changed: function (form, item, value) {
                    dynamicForm_article6_Containerized_3.setValue("article6_Containerized_number32", value);
                }
            },
            {
                name: "article6_number32_1",
                width: "100",
                showTitle: false,
                defaultValue: "STOWED",
                startRow: false,
                title: ''
            }, {
                name: "portByPortSourceId", ///article6_number33
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Port,
                displayField: "port",
                valueField: "id",
                align: "center",
                width: "200",
                showTitle: false,
                startRow: false,
                showHintInField: true,
                hint: "BANDAR ABBAS",
                title: '',
                changed: function (form, item, value) {
                    dynamicForm_article6_Containerized.setValue("article6_Containerized_number33", dynamicForm_article6_number32_33_34_35.getItem("portByPortSourceId").getDisplayValue(value));
                    dynamicForm_article6_Containerized_2.setValue("article6_Containerized_number33_1", value);
                }
            }, {
                name: "article6_number34",
                width: "100",
                showTitle: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_CountryPort,
                displayField: "nameEn",
                valueField: "nameEn",
                align: "center",
                showHintInField: true,
                hint: "IRAN",
                startRow: false,
                title: ''
            }, {
                name: "incotermsText", //article6_number35
                width: "250",
                showTitle: false,
                showHintInField: true,
                defaultValue: "(INCOTERMS 2010).",
                startRow: false,
                title: ''
            }
        ]
    })

    var dynamicForm_article6_Containerized = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6",
        height: "20",
        numCols: 12,
        width: "50%",
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article6_Containerized",
                type: "text",
                height: "50",
                length: 3000,
                defaultValue: "6.1.BUYER SGALL INTRODUCTE TO SELLER THE FULL PARTICULARS OF THE CONTAINER LINE NOMINATEDTED GIVIN FULL NAME REGISTERED ADDRESS TELEPHONE & FAX NUMBERS AND PERSONS IN CHARGE OF THEIR REPRESENTATIVES IN",
                showTitle: false,
                colSpan: 6,
                title: "article6_Containerized ",
                width: "*"
            },
            , {
                name: "officeSource", //article6_Containerized_number36
                width: "100",
                height: "50",
                showTitle: false,
                showHintInField: true,
                hint: "TEHRAN",
                startRow: false,
            }, {
                name: "article6_Containerized_number36_1",
                width: "250",
                height: "50",
                showTitle: false,
                defaultValue: "AS WELL AS AT THE PORT OF",
                startRow: false,
                title: ''
            }, {
                name: "article6_Containerized_number33",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Port,
                displayField: "port",
                valueField: "port",
                align: "center",
                width: "150",
                height: "50",
                showTitle: false,
                showHintInField: true,
                hint: "BANDAR ABBAS",
                startRow: false,
            }
        ]
    })
    var dynamicForm_article6_Containerized_1 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6",
        height: "20",
        numCols: 12,
        width: "50%",
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article6_Containerized_number37_1",
                type: "text",
                height: "50",
                length: 3000,
                defaultValue: "FOR FURTHER COORDINATIONS.LOCAL AGENTS AT THE LOADPORT SHALL BE ACCESSIBLE DURING FULL PERIOD OF LOAFOMG.IN ADDITION FOR EACH SHIPMENT.",
                showTitle: false,
                colSpan: 6,
                title: "article6_Containerized_number37_1",
                width: "*"
            }
        ]
    })
    var dynamicForm_article6_Containerized_2 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6",
        height: "20",
        numCols: 12,
        width: "50%",
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article6_Containerized_number37_2",
                type: "text",
                height: "50",
                length: 3000,
                defaultValue: "6.2.BUYER SHALL INTRODUCT TO SELLER THE NECESSARY ARRANGEMENTS FOR THE CONTAINERS TO BE PROVIDED AND POSITIONED AT THE EXPORT AREA INSIDE THE CONTAINER YARD OF",
                showTitle: false,
                colSpan: 6,
                title: "article6_Containerized_number37_2",
                width: "*"
            }, {
                name: "article6_Containerized_number33_1",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Port,
                displayField: "port",
                valueField: "id",
                align: "center",
                width: "150",
                height: "50",
                showTitle: false,
                showHintInField: true,
                hint: "BANDAR ABBAS",
                startRow: false,
            }
        ]
    })
    var dynamicForm_article6_Containerized_3 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6",
        height: "20",
        numCols: 12,
        width: "50%",
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article6_Containerized_number37_3",
                type: "text",
                height: "50",
                length: 3000,
                defaultValue: "6.3.HOWEVER,COST OF MOVING THE LOADED CONTAINERS FROM EXPORT AREA TO THE",
                showTitle: false,
                colSpan: 6,
                title: "article6_Containerized_number37_3",
                width: "*"
            },
            {
                name: "article6_Containerized_number32",
                colSpan: 3,
                titleColSpan: 1,
                width: "150",
                height: "50",
                tabIndex: 6,
                showTitle: false,
                showHover: true,
                showHintInField: true,
                hint: "FOB",
                required: false,
                title: "<spring:message code='incoterms.name'/>",
                type: 'long',
                numCols: 4,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Incoterms,
                displayField: "code",
                valueField: "id",
                pickListWidth: "500",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "code", width: 440, align: "center"}
                ]
            }
        ]
    })
    var dynamicForm_article6_Containerized_4 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6",
        height: "20",
        numCols: 12,
        width: "50%",
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article6_Containerized_4",
                type: "text",
                height: "50",
                length: 3000,
                defaultValue: "AFTER POSITIONING THE REQUIRED EMPTY CONTAINERS BUYER WILL INFORM IMMEDIATELY THE TYPE(20/40FT) AND NUMBER OF CONTAINERS RELEVANT SERIAL NUMBERS TO SELLER.",
                showTitle: false,
                colSpan: 6,
                title: "article6_Containerized_4",
                width: "*"
            }
        ]
    })
    var dynamicForm_article6_Containerized_5 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6",
        height: "20",
        numCols: 12,
        width: "50%",
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "article6_Containerized_5",
                type: "text",
                height: "50",
                length: 3000,
                defaultValue: "6.5.PRIOR TO STUFFING THE CARGO,NOMINATED INSPECTION COMPANY 'S REPRESENTATIVE IF APPOINTED,OTHER WISE SELLER 'S STAFF WILL CHECK THE CONTAINERS TO APPROVE THEIR FITNESS FOR ACCEPTING THE CARGO.",
                showTitle: false,
                colSpan: 6,
                title: "article6_Containerized_4",
                width: "*"
            }
        ]
    })
    var vlayoutArticle3_1 = isc.VLayout.create({
        width: "100%",
        height: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({align: "left", members: [dynamicForm_article3_1, dynamicForm_article3_2]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article3_3]}),
            isc.HLayout.create({height: "30", align: "left", members: [lableArticle3Typicall]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article3_Typicall]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article3]})
        ]
    });
    var vlayoutArticle4 = isc.VLayout.create({
        width: "100%",
        height: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "left", members: [lableArticle4, dynamicForm_article4_number18]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article4_1_number19]})
        ]
    });
    var vlayoutArticle5 = isc.VLayout.create({
        width: "100%",
        height: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "left", members: [lableArticle5, dynamicForm_article5_number20]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article5_number21]}),
            isc.HLayout.create({
                height: "30",
                align: "left",
                members: [dynamicForm_article5_number24_number25_number26]
            }),
            isc.HLayout.create({height: "30", align: "left", members: [vlayout_ContractItemShipment]}),
// isc.HLayout.create({height:"30",align: "left", members:[dynamicForm_article5_number28_number29]}),
            /* isc.HLayout.create({height:"30",align: "left", members:[dynamicForm_article5_number29_1]}),*/
            hlayuotNote
        ]
    });
    var vlayoutArticle6 = isc.VLayout.create({
        width: "100%",
        height: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "left", members: [lableArticle6, dynamicForm_article6_number31]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article6_number32_33_34_35]}),
            isc.HLayout.create({height: "50", align: "left", members: [lableContainerized]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article6_Containerized]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article6_Containerized_1]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article6_Containerized_2]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article6_Containerized_3]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article6_Containerized_4]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article6_Containerized_5]})
        ]
    });

    var VLayout_PageTwo_Contract = isc.VLayout.create({
        width: "100%",
        height: "100%",
        align: "center",
        overflow: "scroll",
// backgroundImage: "backgrounds/leaves.jpg",
        members: [
            LablePageTwo,
            vlayoutArticle3_1,
            vlayoutArticle4,
            vlayoutArticle5,
            vlayoutArticle6
        ]
    });
    //END PAGE TWO
    //START PAGE THREE
    var dynamicForm_article7_number41 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle7",
        height: "20",
        numCols: 2,
        wrapItemTitles: false,
        padding: 5,
        items: [
            {
                name: "article7_number41",
                width: "200",
                showTitle: false,
                showHintInField: true,
                hint: "PRICE",
                startRow: false,
                title: ''
            }
        ]
    })
    var dynamicForm_article7_number3_number37_number38 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle7",
        height: "20",
        numCols: 8,
        wrapItemTitles: false,
        padding: 3,
        items: [
            {
                name: "article7_number3",
                width: "200",
                showTitle: true,
                startRow: false,
                defaultValue: "MOLYBDENUM OXIDE",
                title: 'PRICE FOR',
                changed: function (form, item, value) {
                            dynamicForm_article7_number3.setValue("article7_number3_1", value);
                            dynamicForm_article8_3.setValue("article8_3", value);
}
            }, {
                name: "article7_number37",
                width: "250",
                showTitle: true,
                startRow: false,
                defaultValue: "PLATTS METALS WEEK",
                title: 'WILL BE BASED ON THE',
                changed: function (form, item, value) {
                    dynamicForm_article7_number39_number40.setValue("article7_number39_1", "OF " + value + "UNDER THE HEADING");
                }
            }, {
                name: "priceCalPeriod", //article7_number38
                width: "250",
                showTitle: false,
                startRow: false,
                defaultValue: "MONTHLY AVERAGE",
                title: 'WILL BE BASED ON THE'
            }, {
                name: "article7_number3_1",
                width: "250",
                showTitle: true,
                defaultValue: "MOLYBDENUM OXIDE",
                startRow: false,
                title: 'FOR'
            }
        ]
    })

    var dynamicForm_article7_number39_number40 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle7",
        height: "20",
        numCols: 8,
        wrapItemTitles: false,
        padding: 3,
        items: [
            {
                name: "publishTime", //article7_number39
                width: "200",
                showTitle: true,
                startRow: false,
                defaultValue: "MONTHLY REPORT",
                title: 'AS PUBLISHED IN '
            }, {
                name: "article7_number39_1",
                width: "350",
                showTitle: false,
                startRow: false,
                defaultValue: "OF PLATTS METALS WEEK THE HEADING ",
                title: 'article7_number39_1'
            }, {
                name: "reportTitle", //article7_number40
                width: "250",
                showTitle: false,
                startRow: false,
                defaultValue: "DEALER OXIDE MIDPOINT/MEAN",
                title: 'article7_number40'
            }, {
                name: "article7_number40_1",
                width: "150",
                showTitle: false,
                startRow: false,
                defaultValue: "PER POUND",
                title: 'article7_number40_1'
            }
        ]
    });
    var dynamicForm_article7_number40_2 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle7",
        height: "20",
        numCols: 2,
        width: "10%",
        wrapItemTitles: false,
        padding: 3,
        items: [
            {
                name: "article7_number40_2",
                width: "450",
                height: "40",
                showTitle: false,
                defaultValue: "OF MOLYBDENUM CONTENT WITH DISCOUNTS AS BELOW",
                startRow: false,
                title: ''
            }
        ]
    });
     var dynamicForm_article7_discount = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle7",
        height: "20",
        numCols: 10,
        wrapItemTitles: false,
        items: [
            {name: "discountValueOne",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueOne
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueOne_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixOne",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitOne",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixOne_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueOne_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueTwo",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueTwo
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueTwo_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixTwo",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitTwo",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixTwo_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueTwo_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueThree",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueThree
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueThree_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixThree",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitThree",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixThree_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueThree_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueFour",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueFour
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueFour_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixFour",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitFour",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixFour_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueFour_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
             {name: "discountValueFive",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueFive
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueFive_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixFive",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitFive",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixFive_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueFive_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
             {name: "discountValueSix",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueSix
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueSix_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixSix",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitSix",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixSix_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueSix_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
               {name: "discountValueSeven",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueSeven
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueSeven_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixSeven",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitSeven",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixSeven_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueSeven_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueEight",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueEight
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueEight_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixEight",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitEight",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixEight_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueEight_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueNine",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueNine
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueNine_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixNine",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitNine",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixNine_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueNine_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
                 {name: "discountValueTen",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueTen
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueTen_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixTen",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitTen",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixTen_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueTen_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueEleven",width:"80",showTitle: true,title: "*",startRow:true},       //discountValueEleven
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueEleven_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixEleven",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitEleven",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixEleven_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueEleven_2",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false}
            ]
    });
    var vlayoutArticle7 = isc.VLayout.create({
        width: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "left", members: [lableArticle7, dynamicForm_article7_number41]}),
            isc.HLayout.create({
                height: "30",
                align: "left",
                members: [dynamicForm_article7_number3_number37_number38]
            }),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article7_number39_number40]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article7_number40_2]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article7_discount]})
        ]
    });

    var dynamicForm_article8_number42 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle8",
        height: "20",
        numCols: 2,
        wrapItemTitles: false,
        padding: 5,
        items: [
            {
                name: "article8_number42",
                width: "200",
                showTitle: false,
                showHintInField: true,
                hint: "OUOTATIONAL PERIOD",
                startRow: false,
                title: ''
            }
        ]
    })
    var dynamicForm_article8_3 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle8",
        height: "20",
        numCols: 10,
        wrapItemTitles: false,
        padding: 5,
        items: [
            {
                name: "article8_3",
                width: "200",
                showTitle: true,
                startRow: false,
                title: 'QUOTATIONAL PERIOD FOR'
            }, {
                name: "article8_value",
                width: "450",
                defaultValue: "MONTH FOLLOWING MONTH OF ACTUAL SHIPMENT",
                showTitle: true,
                startRow: false,
                title: 'SHALL BE THE AVERAGE OF THE '
            },
            {
                name: "article8_number43",
                width: "80",
                showTitle: true,
                startRow: false,
                title: '('
            },
            {
                name: "delay", //article8_number44
                width: "80",
                showTitle: true,
                startRow: false,
                title: '+'
            }, {
                name: "article8_number44_1",
                width: "400",
                defaultValue: "FROM THE PORT OF LOADING AS EVIDENCED BY THE B/L DATE.",
                showTitle: true,
                startRow: false,
                title: ')'
            }
        ]
    })

    var vlayoutArticle8 = isc.VLayout.create({
        width: "100%",
        height: "50",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "30", align: "left", members: [lableArticle8, dynamicForm_article8_number42]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article8_3]})
        ]
    });

    var dynamicForm_article9_number45 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle9",
        height: "20",
        numCols: 2,
        wrapItemTitles: false,
        padding: 5,
        items: [
            {
                name: "article9_number45",
                width: "200",
                showTitle: false,
                showHintInField: true,
                hint: "PAYMENT",
                startRow: false,
                title: ''
            }
        ]
    })
    var dynamicForm_article9_number46_number47_number48_number49 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle9",
        height: "20",
        numCols: 8,
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "prepaid", //article9_number45_number46
                showTitle: true,
                title: '1.BUYER SHALL PAY',
                showHintInField: true,
                hint: "BEFORE EACH SHIPMENT",
                startRow: false
            },
            {
                name: "article9_number22",
                showTitle: false,
                showHintInField: true,
                hint: "105",
                title: 'article9_number22',
                startRow: false,
                changed: function (form, item, value) {
                    dynamicForm_article9_number46_number47_number48_number49.setValue("article9_Englishi_number22",numberToEnglish(value));
                }
            }, {
                name: "article9_Englishi_number22",
                disabled: "true",
                showTitle: false,
                title: 'article9_Englishi_number22',
                startRow: false
            }, {
                name: "article9_number23",
                showTitle: true,
                title: 'OF',
                startRow: false
            }, {
                name: "prepaidCurrency", //article9_number47
                showTitle: true,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Currency_list,
                displayField: "nameEn",
                valueField: "nameEn",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameEn", width: "45%", align: "center"},
                    {name: "nameFa", width: "45%", align: "center"}
                ],
                startRow: false,//TO DO currency
                title: 'INVOICE VALUE AMOUNT IN'
            }, {
                name: "article9_number48",
                showTitle: true,
                startRow: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Currency_list,
                autoFetchData: false,
                displayField: "nameEn",
                valueField: "nameEn",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameEn", width: "45%", align: "center"},
                    {name: "nameFa", width: "45%", align: "center"}
                ],
                title: 'OF'
            }, {
                name: "payTime", ///article9_number48 ///****article9_number49
                showTitle: false,
                showHintInField: true,
                startRow: false,        /// TO DO PAYMENT OPTION
                hint: 'PROMPT NET CASH PAYABLE BY',
                valueMap: {
                    "PROMPT": "PROMPT",
                    "DAMP": "DAMP"
                }
            }, {
                name: "article9_number49_1",
                showTitle: true,
                defaultValue: "IRREVOCABLE LETTER OF CREDIT AT SIGHT",
                startRow: false,
                title: 'OR UNDER AN'
            }
        ]
    })
    var dynamicForm_article9_number50_number51_number52 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle9",
        height: "20",
        numCols: 10,
        wrapItemTitles: false,
        padding: 5,
        items: [
            , {
                name: "pricePeriod", //article9_number50
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                showHintInField: true,
                title: 'TO A BANK WHICH IS NOMINATED BY SELLER PROFORMA/PROVISIONAL INVOICE AMOUNT CALCULATED BASED ON PROVISIONAL PRICE WHICH IS AVERAGE OF'
            }, {
                name: "article9_number51",
                width: "150",
                showTitle: true,
                defaultValue: "PRIOR",
                startRow: false,
                showHintInField: true,
                title: 'PRICE'
            }, {
                name: "eventPayment", //article9_number52
                width: "150",
                showTitle: false,
                defaultValue: "",
                hint: "DATE",
                startRow: false,
                showHintInField: true,
                title: ''
            }, {
                name: "contentType", ///article9_number52_1
                width: "150",
                showTitle: false,
                startRow: false,
                title: '',
                valueMap: {
                    "FINAL": "FINAL",
                    "TYPICAL": "TYPICAL"
                }
            }
        ]
    })
    var dynamicForm_article9_number54 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle9",
        height: "20",
        numCols: 10,
        wrapItemTitles: false,
        padding: 5,
        items: [
            {
                name: "article9_number54",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                hint: "PLATTS",
                showHintInField: true,
                title: 'ASSAY OUBLISHED BY'
            }, {
                name: "article9_number54_1",
                width: "600",
                showTitle: false,
                defaultValue: "EVERY FRIDAY UNDER HEADING OF WEEKLY AVERAGE MINUS THE APPLICABLE DISCOUNT.",
                startRow: false
            }
        ]
    });
    var dynamicForm_article9_number55 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle9",
        height: "20",
        width: "10%",
        numCols: 2,
        wrapItemTitles: false,
        padding: 5,
        items: [
            {
                name: "article9_number55",
                type: "text",
                height: "100",
                length: 3000,
                defaultValue: "",
                showTitle: false,
                startRow: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                displayField: "paramValue",
                valueField: "paramValue",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "paramName", width: "20%", align: "center"},
                    {name: "paramType", width: "20%", align: "center"},
                    {name: "paramValue", width: "60%", align: "center"}
                ],
                colSpan: 2,
                title: "article9_number55",
                width: "*"
            }
        ]
    })
    var dynamicForm_article9_ImportantNote = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle9",
        height: "20",
        width: "10%",
        numCols: 2,
        wrapItemTitles: false,
        padding: 5,
        items: [
            {
                name: "article9_ImportantNote",
                type: "text",
                height: "100",
                length: 3000,
                startRow: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Parameters,
                displayField: "paramValue",
                valueField: "paramValue",
                showTitle: false,
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "paramName", width: "20%", align: "center"},
                    {name: "paramType", width: "20%", align: "center"},
                    {name: "paramValue", width: "60%", align: "center"}
                ],
                colSpan: 2,
                title: "article9_ImportantNote",
                width: "*"
            }
        ]
    })

    var vlayoutArticle9 = isc.VLayout.create({
        width: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "30", align: "left", members: [lableArticle9, dynamicForm_article9_number45]}),
            isc.HLayout.create({
                height: "30",
                align: "left",
                members: [dynamicForm_article9_number46_number47_number48_number49]
            }),
            isc.HLayout.create({
                height: "30",
                align: "left",
                members: [dynamicForm_article9_number50_number51_number52]
            }),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article9_number54]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article9_number55]}),
            isc.HLayout.create({height: "30", align: "left", members: [lableImportantNote]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article9_ImportantNote]})
        ]
    });

    var dynamicForm_article10 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle10",
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


    var vlayoutArticle10 = isc.VLayout.create({
        width: "100%",
        height: "50",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({ height: "30",align: "left", members: [lableArticle10] }),
            isc.HLayout.create({height: "30", align: "center", members: [isc.VLayout.create({align: "center", members: [dynamicForm_article10]})]})
        ]
    });
    var VLayout_PageThree_Contract = isc.VLayout.create({
        width: "100%",
        height: "100%",
        align: "center",
        overflow: "scroll",
        members: [
            vlayoutArticle7,
            vlayoutArticle8,
            vlayoutArticle9,
            vlayoutArticle10
        ]
    });
    //END PAGE THREE
    //START PAGE Four
    //END PAGE Four
var contactTabs = isc.TabSet.create({
        width: "100%",
        height: "97%",
        tabs: [
            {
                title: "page1", canClose: false,
                pane: VLayout_PageOne_Contract
            },
            {
                title: "page2", canClose: false,
                pane: VLayout_PageTwo_Contract
            },
            {
                title: "page3", canClose: false,
                pane: VLayout_PageThree_Contract
            }
        ]
    });


var IButton_Contact_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_ContactHeader.validate();
            DynamicForm_ContactCustomer.validate();
            contactHeader.validate();
            DynamicForm_ContactParameter_ValueNumber8.setValue("feild_all_defintitons_save", JSON.stringify(DynamicForm_ContactParameter_ValueNumber8.getValues()));
            var drs = contactHeader.getValues().createDateDumy;
            var contractTrueDate = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_ContactHeader.setValue("contractDate", contractTrueDate);
            var dataSaveAndUpdateContract={};
                    dataSaveAndUpdateContract.contractDate= contactHeader.getValue("createDateDumy");
                    dataSaveAndUpdateContract.contractNo=contactHeader.getValue("contractNo");
                    dataSaveAndUpdateContract.contactId=contactHeader.getValue("contactId")
                    dataSaveAndUpdateContract.contactByBuyerAgentId=contactHeader.getValue("contactByBuyerAgentId")
                    dataSaveAndUpdateContract.contactBySellerId=contactHeader.getValue("contactBySellerId")
                    dataSaveAndUpdateContract.contactBySellerAgentId=contactHeader.getValue("contactBySellerAgentId")
                    dataSaveAndUpdateContract.amount=valuesManagerArticle2.getValue("amount");
                    dataSaveAndUpdateContract.amount_en=valuesManagerArticle2.getValue("amount_en");
                    dataSaveAndUpdateContract.unitId=valuesManagerArticle2.getValue("unitId");
                    dataSaveAndUpdateContract.molybdenumTolorance=valuesManagerArticle2.getValue("molybdenumTolorance");
                    dataSaveAndUpdateContract.optional=valuesManagerArticle2.getValue("optional");
                    dataSaveAndUpdateContract.plant=valuesManagerArticle2.getValue("plant");
                    dataSaveAndUpdateContract.contactInspectionId=valuesManagerArticle3.getValue("contactInspectionId");
                    dataSaveAndUpdateContract.molybdenum=valuesManagerArticle3.getValue("molybdenum");
                    dataSaveAndUpdateContract.copper=valuesManagerArticle3.getValue("copper");
                    dataSaveAndUpdateContract.mo_amount=valuesManagerArticle4.getValue("mo_amount");
                    dataSaveAndUpdateContract.timeIssuance=valuesManagerArticle5.getValue("timeIssuance");
                    dataSaveAndUpdateContract.prefixPayment=valuesManagerArticle5.getValue("prefixPayment");
                    dataSaveAndUpdateContract.invoiceType=valuesManagerArticle5.getValue("invoiceType");
                    dataSaveAndUpdateContract.runStartDate=valuesManagerArticle5.getValue("runStartDate");
                    dataSaveAndUpdateContract.runTill=valuesManagerArticle5.getValue("runTill");
                    dataSaveAndUpdateContract.runEndtDate=valuesManagerArticle5.getValue("runEndtDate");
                    dataSaveAndUpdateContract.incotermsId=valuesManagerArticle6.getValue("incotermsId");
                    dataSaveAndUpdateContract.portByPortSourceId=valuesManagerArticle6.getValue("portByPortSourceId");
                    dataSaveAndUpdateContract.incotermsText=valuesManagerArticle6.getValue("incotermsText");
                    dataSaveAndUpdateContract.officeSource=valuesManagerArticle6.getValue("officeSource");
                    dataSaveAndUpdateContract.priceCalPeriod=valuesManagerArticle7.getValue("priceCalPeriod");
                    dataSaveAndUpdateContract.publishTime=valuesManagerArticle7.getValue("publishTime");
                    dataSaveAndUpdateContract.reportTitle=valuesManagerArticle7.getValue("reportTitle");
                    dataSaveAndUpdateContract.delay=valuesManagerArticle8.getValue("delay");
                    dataSaveAndUpdateContract.prepaid=valuesManagerArticle9.getValue("prepaid");
                    dataSaveAndUpdateContract.prepaidCurrency=valuesManagerArticle9.getValue("prepaidCurrency");
                    dataSaveAndUpdateContract.payTime=valuesManagerArticle9.getValue("payTime");
                    dataSaveAndUpdateContract.pricePeriod=valuesManagerArticle9.getValue("pricePeriod");
                    dataSaveAndUpdateContract.eventPayment=valuesManagerArticle9.getValue("eventPayment");
                    dataSaveAndUpdateContract.contentType=valuesManagerArticle9.getValue("contentType");
                    dataSaveAndUpdateContract.materialId=-32;



            var dataSaveAndUpdateContractDetail={};
                    dataSaveAndUpdateContractDetail.name_ContactAgentSeller=contactHeaderAgent.getValue("name_ContactAgentSeller")
                    dataSaveAndUpdateContractDetail.phone_ContactAgentSeller=contactHeaderAgent.getValue("phone_ContactAgentSeller")
                    dataSaveAndUpdateContractDetail.mobile_ContactAgentSeller=contactHeaderAgent.getValue("mobile_ContactAgentSeller")
                    dataSaveAndUpdateContractDetail.address_ContactAgentSeller= contactHeaderAgent.getValue("address_ContactAgentSeller")
                    dataSaveAndUpdateContractDetail.address_ContactSeller=contactHeaderAgent.getValue("address_ContactSeller")
                    dataSaveAndUpdateContractDetail.mobile_ContactSeller= contactHeaderAgent.getValue("mobile_ContactSeller")
                    dataSaveAndUpdateContractDetail.phone_ContactSeller=contactHeaderAgent.getValue("phone_ContactSeller")
                    dataSaveAndUpdateContractDetail.name_ContactSeller=contactHeaderAgent.getValue("name_ContactSeller")
                    dataSaveAndUpdateContractDetail.name_ContactAgentBuyer=contactHeaderAgent.getValue("name_ContactAgentBuyer")
                    dataSaveAndUpdateContractDetail.phone_ContactAgentBuyer=contactHeaderAgent.getValue("phone_ContactAgentBuyer")
                    dataSaveAndUpdateContractDetail.mobile_ContactAgentBuyer=contactHeaderAgent.getValue("mobile_ContactAgentBuyer")
                    dataSaveAndUpdateContractDetail.address_ContactAgentBuyer=contactHeaderAgent.getValue("address_ContactAgentBuyer")
                    dataSaveAndUpdateContractDetail.name_ContactBuyer=contactHeaderAgent.getValue("name_ContactBuyer")
                    dataSaveAndUpdateContractDetail.phone_ContactBuyer=contactHeaderAgent.getValue("phone_ContactBuyer")
                    dataSaveAndUpdateContractDetail.mobile_ContactBuyer=contactHeaderAgent.getValue("mobile_ContactBuyer")
                    dataSaveAndUpdateContractDetail.address_ContactBuyer=contactHeaderAgent.getValue("address_ContactBuyer")
                    dataSaveAndUpdateContractDetail.article2_13_1=valuesManagerArticle2.getValue("article2_13_1");
                    dataSaveAndUpdateContractDetail.responsibleTelerons=valuesManagerArticle2.getValue("responsibleTelerons");
                    dataSaveAndUpdateContractDetail.article3_number17=valuesManagerArticle3.getValue("article3_number17");
                    dataSaveAndUpdateContractDetail.article3_number17_7=valuesManagerArticle3.getValue("article3_number17_7");
                    dataSaveAndUpdateContractDetail.article3_number17_8=valuesManagerArticle3.getValue("article3_number17_8");
                    dataSaveAndUpdateContractDetail.article3_number17_9=valuesManagerArticle3.getValue("article3_number17_9");
                    dataSaveAndUpdateContractDetail.article3_number17_10=valuesManagerArticle3.getValue("article3_number17_10");
                    dataSaveAndUpdateContractDetail.article3_number17_11=valuesManagerArticle3.getValue("article3_number17_11");
                    dataSaveAndUpdateContractDetail.article3_number17_12=valuesManagerArticle3.getValue("article3_number17_12");
                    dataSaveAndUpdateContractDetail.article3_number17_2=valuesManagerArticle3.getValue("article3_number17_2");
                    dataSaveAndUpdateContractDetail.PrefixMolybdenum=valuesManagerArticle3.getValue("PrefixMolybdenum");
                    dataSaveAndUpdateContractDetail.toleranceMO=valuesManagerArticle3.getValue("toleranceMO");
                    dataSaveAndUpdateContractDetail.typical_unitMO=valuesManagerArticle3.getValue("typical_unitMO");
                    dataSaveAndUpdateContractDetail.PrefixCopper=valuesManagerArticle3.getValue("PrefixCopper");
                    dataSaveAndUpdateContractDetail.toleranceCU=valuesManagerArticle3.getValue("toleranceCU");
                    dataSaveAndUpdateContractDetail.typical_unitCU=valuesManagerArticle3.getValue("typical_unitCU");
                    dataSaveAndUpdateContractDetail.PrefixC=valuesManagerArticle3.getValue("PrefixC");
                    dataSaveAndUpdateContractDetail.typical_c=valuesManagerArticle3.getValue("typical_c");
                    dataSaveAndUpdateContractDetail.toleranceC=valuesManagerArticle3.getValue("toleranceC");
                    dataSaveAndUpdateContractDetail.typical_unitC=valuesManagerArticle3.getValue("typical_unitC");
                    dataSaveAndUpdateContractDetail.PrefixS=valuesManagerArticle3.getValue("PrefixS");
                    dataSaveAndUpdateContractDetail.typical_s=valuesManagerArticle3.getValue("typical_s");
                    dataSaveAndUpdateContractDetail.toleranceS=valuesManagerArticle3.getValue("toleranceS");
                    dataSaveAndUpdateContractDetail.typical_unitS=valuesManagerArticle3.getValue("typical_unitS");
                    dataSaveAndUpdateContractDetail.PrefixPb=valuesManagerArticle3.getValue("PrefixPb");
                    dataSaveAndUpdateContractDetail.typical_pb=valuesManagerArticle3.getValue("typical_pb");
                    dataSaveAndUpdateContractDetail.tolerancePb=valuesManagerArticle3.getValue("tolerancePb");
                    dataSaveAndUpdateContractDetail.typical_unitPb=valuesManagerArticle3.getValue("typical_unitPb");
                    dataSaveAndUpdateContractDetail.PrefixP=valuesManagerArticle3.getValue("PrefixP");
                    dataSaveAndUpdateContractDetail.typical_p=valuesManagerArticle3.getValue("typical_p");
                    dataSaveAndUpdateContractDetail.toleranceP=valuesManagerArticle3.getValue("toleranceP");
                    dataSaveAndUpdateContractDetail.typical_unitP=valuesManagerArticle3.getValue("typical_unitP");
                    dataSaveAndUpdateContractDetail.PrefixSi=valuesManagerArticle3.getValue("PrefixSi");
                    dataSaveAndUpdateContractDetail.typical_Si=valuesManagerArticle3.getValue("typical_Si");
                    dataSaveAndUpdateContractDetail.toleranceSi=valuesManagerArticle3.getValue("toleranceSi");
                    dataSaveAndUpdateContractDetail.typical_unitSi=valuesManagerArticle3.getValue("typical_unitSi");
                    dataSaveAndUpdateContractDetail.article3_number17_3=valuesManagerArticle3.getValue("article3_number17_3");
                    dataSaveAndUpdateContractDetail.article3_number17_13=valuesManagerArticle3.getValue("article3_number17_13");
                    dataSaveAndUpdateContractDetail.article3_number17_4=valuesManagerArticle3.getValue("article3_number17_4");
                    dataSaveAndUpdateContractDetail.article3_number17_5=valuesManagerArticle3.getValue("article3_number17_5");
                    dataSaveAndUpdateContractDetail.article3_number17_6=valuesManagerArticle3.getValue("article3_number17_6");
                    dataSaveAndUpdateContractDetail.article4_number18=valuesManagerArticle4.getValue("article4_number18");
                    dataSaveAndUpdateContractDetail.amount_number19_2=valuesManagerArticle4.getValue("amount_number19_2");
                    dataSaveAndUpdateContractDetail.amount_number19_1=valuesManagerArticle4.getValue("amount_number19_1");
                    dataSaveAndUpdateContractDetail.shipment_number20=valuesManagerArticle5.getValue("shipment_number20");
                    dataSaveAndUpdateContractDetail.article5_number21_6=valuesManagerArticle5.getValue("article5_number21_6");
                    dataSaveAndUpdateContractDetail.article6_number31=valuesManagerArticle6.getValue("article6_number31");
                    dataSaveAndUpdateContractDetail.article6_number31_1=valuesManagerArticle6.getValue("article6_number31_1");
                    dataSaveAndUpdateContractDetail.article6_number32_1=valuesManagerArticle6.getValue("article6_number32_1");
                    dataSaveAndUpdateContractDetail.article6_number34=valuesManagerArticle6.getValue("article6_number34");
                    dataSaveAndUpdateContractDetail.article6_Containerized=valuesManagerArticle6.getValue("article6_Containerized");
                    dataSaveAndUpdateContractDetail.article6_Containerized_number36_1=valuesManagerArticle6.getValue("article6_Containerized_number36_1");
                    dataSaveAndUpdateContractDetail.article6_Containerized_number33=valuesManagerArticle6.getValue("article6_Containerized_number33");
                    dataSaveAndUpdateContractDetail.article6_Containerized_number37_1=valuesManagerArticle6.getValue("article6_Containerized_number37_1");
                    dataSaveAndUpdateContractDetail.article6_Containerized_number37_2=valuesManagerArticle6.getValue("article6_Containerized_number37_2");
                    dataSaveAndUpdateContractDetail.article6_Containerized_number33_1=valuesManagerArticle6.getValue("article6_Containerized_number33_1");
                    dataSaveAndUpdateContractDetail.article6_Containerized_number37_3=valuesManagerArticle6.getValue("article6_Containerized_number37_3");
                    dataSaveAndUpdateContractDetail.article6_Containerized_number32=valuesManagerArticle6.getValue("article6_Containerized_number32");
                    dataSaveAndUpdateContractDetail.article6_Containerized_4=valuesManagerArticle6.getValue("article6_Containerized_4");
                    dataSaveAndUpdateContractDetail.article6_Containerized_5=valuesManagerArticle6.getValue("article6_Containerized_5");
                    dataSaveAndUpdateContractDetail.article7_number41=valuesManagerArticle7.getValue("article7_number41");
                    dataSaveAndUpdateContractDetail.article7_number3=valuesManagerArticle7.getValue("article7_number3");
                    dataSaveAndUpdateContractDetail.article7_number37=valuesManagerArticle7.getValue("article7_number37");
                    dataSaveAndUpdateContractDetail.article7_number3_1=valuesManagerArticle7.getValue("article7_number3_1");
                    dataSaveAndUpdateContractDetail.article7_number39_1=valuesManagerArticle7.getValue("article7_number39_1");
                    dataSaveAndUpdateContractDetail.article7_number40_2=valuesManagerArticle7.getValue("article7_number40_2");
                    dataSaveAndUpdateContractDetail.discountValueOne=valuesManagerArticle7.getValue("discountValueOne");
                    dataSaveAndUpdateContractDetail.discountFor=valuesManagerArticle7.getValue("discountFor");
                    dataSaveAndUpdateContractDetail.discountValueOne_1=valuesManagerArticle7.getValue("discountValueOne_1");
                    dataSaveAndUpdateContractDetail.discountPerfixOne=valuesManagerArticle7.getValue("discountPerfixOne");
                    dataSaveAndUpdateContractDetail.discountUnitOne=valuesManagerArticle7.getValue("discountUnitOne");
                    dataSaveAndUpdateContractDetail.discountPerfixOne_1=valuesManagerArticle7.getValue("discountPerfixOne_1");
                    dataSaveAndUpdateContractDetail.discountValueOne_2=valuesManagerArticle7.getValue("discountValueOne_2");
                    dataSaveAndUpdateContractDetail.discountValueTwo=valuesManagerArticle7.getValue("discountValueTwo");
                    dataSaveAndUpdateContractDetail.discountValueTwo_1=valuesManagerArticle7.getValue("discountValueTwo_1");
                    dataSaveAndUpdateContractDetail.discountPerfixTwo=valuesManagerArticle7.getValue("discountPerfixTwo");
                    dataSaveAndUpdateContractDetail.discountUnitTwo=valuesManagerArticle7.getValue("discountUnitTwo");
                    dataSaveAndUpdateContractDetail.discountPerfixTwo_1=valuesManagerArticle7.getValue("discountPerfixTwo_1");
                    dataSaveAndUpdateContractDetail.discountValueTwo_2=valuesManagerArticle7.getValue("discountValueTwo_2");
                    dataSaveAndUpdateContractDetail.discountValueThree=valuesManagerArticle7.getValue("discountValueThree");
                    dataSaveAndUpdateContractDetail.discountFor=valuesManagerArticle7.getValue("discountFor");
                    dataSaveAndUpdateContractDetail.discountValueThree_1=valuesManagerArticle7.getValue("discountValueThree_1");
                    dataSaveAndUpdateContractDetail.discountPerfixThree=valuesManagerArticle7.getValue("discountPerfixThree");
                    dataSaveAndUpdateContractDetail.discountUnitThree=valuesManagerArticle7.getValue("discountUnitThree");
                    dataSaveAndUpdateContractDetail.discountPerfixThree_1=valuesManagerArticle7.getValue("discountPerfixThree_1");
                    dataSaveAndUpdateContractDetail.discountValueThree_2=valuesManagerArticle7.getValue("discountValueThree_2");
                    dataSaveAndUpdateContractDetail.discountValueFour=valuesManagerArticle7.getValue("discountValueFour");
                    dataSaveAndUpdateContractDetail.discountValueFour_1=valuesManagerArticle7.getValue("discountValueFour_1");
                    dataSaveAndUpdateContractDetail.discountUnitFour=valuesManagerArticle7.getValue("discountUnitFour");
                    dataSaveAndUpdateContractDetail.discountPerfixFour_1=valuesManagerArticle7.getValue("discountPerfixFour_1");
                    dataSaveAndUpdateContractDetail.discountValueFour_2=valuesManagerArticle7.getValue("discountValueFour_2");
                    dataSaveAndUpdateContractDetail.discountValueFive=valuesManagerArticle7.getValue("discountValueFive");
                    dataSaveAndUpdateContractDetail.discountFor=valuesManagerArticle7.getValue("discountFor");
                    dataSaveAndUpdateContractDetail.discountValueFive_1=valuesManagerArticle7.getValue("discountValueFive_1");
                    dataSaveAndUpdateContractDetail.discountPerfixFive=valuesManagerArticle7.getValue("discountPerfixFive");
                    dataSaveAndUpdateContractDetail.discountUnitFive=valuesManagerArticle7.getValue("discountUnitFive");
                    dataSaveAndUpdateContractDetail.discountPerfixFive_1=valuesManagerArticle7.getValue("discountPerfixFive_1");
                    dataSaveAndUpdateContractDetail.discountValueFive_2=valuesManagerArticle7.getValue("discountValueFive_2");
                    dataSaveAndUpdateContractDetail.discountValueSix=valuesManagerArticle7.getValue("discountValueSix");
                    dataSaveAndUpdateContractDetail.discountValueSix_1=valuesManagerArticle7.getValue("discountValueSix_1");
                    dataSaveAndUpdateContractDetail.discountPerfixSix=valuesManagerArticle7.getValue("discountPerfixSix");
                    dataSaveAndUpdateContractDetail.discountUnitSix=valuesManagerArticle7.getValue("discountUnitSix");
                    dataSaveAndUpdateContractDetail.discountPerfixSix_1=valuesManagerArticle7.getValue("discountPerfixSix_1");
                    dataSaveAndUpdateContractDetail.discountValueSix_2=valuesManagerArticle7.getValue("discountValueSix_2");
                    dataSaveAndUpdateContractDetail.discountValueSeven=valuesManagerArticle7.getValue("discountValueSeven");
                    dataSaveAndUpdateContractDetail.discountValueSeven_1=valuesManagerArticle7.getValue("discountValueSeven_1");
                    dataSaveAndUpdateContractDetail.discountPerfixSeven=valuesManagerArticle7.getValue("discountPerfixSeven");
                    dataSaveAndUpdateContractDetail.discountUnitSeven=valuesManagerArticle7.getValue("discountUnitSeven");
                    dataSaveAndUpdateContractDetail.discountPerfixSeven_1=valuesManagerArticle7.getValue("discountPerfixSeven_1");
                    dataSaveAndUpdateContractDetail.discountValueSeven_2=valuesManagerArticle7.getValue("discountValueSeven_2");
                    dataSaveAndUpdateContractDetail.discountValueEight=valuesManagerArticle7.getValue("discountValueEight");
                    dataSaveAndUpdateContractDetail.discountValueEight_1=valuesManagerArticle7.getValue("discountValueEight_1");
                    dataSaveAndUpdateContractDetail.discountPerfixEight=valuesManagerArticle7.getValue("discountPerfixEight");
                    dataSaveAndUpdateContractDetail.discountUnitEight=valuesManagerArticle7.getValue("discountUnitEight");
                    dataSaveAndUpdateContractDetail.discountPerfixEight_1=valuesManagerArticle7.getValue("discountPerfixEight_1");
                    dataSaveAndUpdateContractDetail.discountValueEight_2=valuesManagerArticle7.getValue("discountValueEight_2");
                    dataSaveAndUpdateContractDetail.discountValueNine=valuesManagerArticle7.getValue("discountValueNine");
                    dataSaveAndUpdateContractDetail.discountValueNine_1=valuesManagerArticle7.getValue("discountValueNine_1");
                    dataSaveAndUpdateContractDetail.discountPerfixNine=valuesManagerArticle7.getValue("discountPerfixNine");
                    dataSaveAndUpdateContractDetail.discountUnitNine=valuesManagerArticle7.getValue("discountUnitNine");
                    dataSaveAndUpdateContractDetail.discountPerfixNine_1=valuesManagerArticle7.getValue("discountPerfixNine_1");
                    dataSaveAndUpdateContractDetail.discountValueNine_2=valuesManagerArticle7.getValue("discountValueNine_2");
                    dataSaveAndUpdateContractDetail.discountValueTen=valuesManagerArticle7.getValue("discountValueTen");
                    dataSaveAndUpdateContractDetail.discountValueTen_1=valuesManagerArticle7.getValue("discountValueTen_1");
                    dataSaveAndUpdateContractDetail.discountPerfixTen=valuesManagerArticle7.getValue("discountPerfixTen");
                    dataSaveAndUpdateContractDetail.discountUnitTen=valuesManagerArticle7.getValue("discountUnitTen");
                    dataSaveAndUpdateContractDetail.discountPerfixTen_1=valuesManagerArticle7.getValue("discountPerfixTen_1");
                    dataSaveAndUpdateContractDetail.discountValueTen_2=valuesManagerArticle7.getValue("discountValueTen_2");
                    dataSaveAndUpdateContractDetail.discountValueEleven=valuesManagerArticle7.getValue("discountValueEleven");
                    dataSaveAndUpdateContractDetail.discountValueEleven_1=valuesManagerArticle7.getValue("discountValueEleven_1");
                    dataSaveAndUpdateContractDetail.discountPerfixEleven=valuesManagerArticle7.getValue("discountPerfixEleven");
                    dataSaveAndUpdateContractDetail.discountUnitEleven=valuesManagerArticle7.getValue("discountUnitEleven");
                    dataSaveAndUpdateContractDetail.discountPerfixEleven_1=valuesManagerArticle7.getValue("discountPerfixEleven_1");
                    dataSaveAndUpdateContractDetail.discountValueEleven_2=valuesManagerArticle7.getValue("discountValueEleven_2");
                    dataSaveAndUpdateContractDetail.article8_number42=valuesManagerArticle8.getValue("article8_number42");
                    dataSaveAndUpdateContractDetail.article8_3=valuesManagerArticle8.getValue("article8_3");
                    dataSaveAndUpdateContractDetail.article8_value=valuesManagerArticle8.getValue("article8_value");
                    dataSaveAndUpdateContractDetail.article8_number43=valuesManagerArticle8.getValue("article8_number43");
                    dataSaveAndUpdateContractDetail.article8_number44_1=valuesManagerArticle8.getValue("article8_number44_1");
                    dataSaveAndUpdateContractDetail.article9_number45=valuesManagerArticle9.getValue("article9_number45");
                    dataSaveAndUpdateContractDetail.article9_number22=valuesManagerArticle9.getValue("article9_number22");
                    dataSaveAndUpdateContractDetail.article9_Englishi_number22=valuesManagerArticle9.getValue("article9_Englishi_number22");
                    dataSaveAndUpdateContractDetail.article9_number23=valuesManagerArticle9.getValue("article9_number23");
                    dataSaveAndUpdateContractDetail.article9_number48=valuesManagerArticle9.getValue("article9_number48");
                    dataSaveAndUpdateContractDetail.article9_number49_1=valuesManagerArticle9.getValue("article9_number49_1");
                    dataSaveAndUpdateContractDetail.article9_number51=valuesManagerArticle9.getValue("article9_number51");
                    dataSaveAndUpdateContractDetail.article9_number54=valuesManagerArticle9.getValue("article9_number54");
                    dataSaveAndUpdateContractDetail.article9_number54_1=valuesManagerArticle9.getValue("article9_number54_1");
                    dataSaveAndUpdateContractDetail.article9_number55=valuesManagerArticle9.getValue("article9_number55");
                    dataSaveAndUpdateContractDetail.article9_ImportantNote=valuesManagerArticle9.getValue("article9_ImportantNote");
                    dataSaveAndUpdateContractDetail.article10_number56=valuesManagerArticle10.getValue("article10_number56");
                    dataSaveAndUpdateContractDetail.article10_number57=valuesManagerArticle10.getValue("article10_number57");
                    dataSaveAndUpdateContractDetail.article10_number58=valuesManagerArticle10.getValue("article10_number58");
                    dataSaveAndUpdateContractDetail.article10_number59=valuesManagerArticle10.getValue("article10_number59");
                    dataSaveAndUpdateContractDetail.article10_number60=valuesManagerArticle10.getValue("article10_number60");
                    dataSaveAndUpdateContractDetail.article10_number61=valuesManagerArticle10.getValue("article10_number61");
             console.log(dataSaveAndUpdateContract);
            if(methodUrl=="PUT"){
                        alert(contractIdEdit);
                        dataSaveAndUpdateContract.id=contractIdEdit;
                        dataSaveAndUpdateContractDetail.contractNo=contactHeader.getValue("contractNo");
            }
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contract",
                httpMethod: methodUrl,
                data: JSON.stringify(dataSaveAndUpdateContract),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                 saveCotractDetails(dataSaveAndUpdateContractDetail, (JSON.parse(resp.data)).id);
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }))
        }
    });

var contactFormButtonSaveLayout = isc.HStack.create({
        width: "100%",
        height: "3%",
        align: "center",
        showEdges: true,
        backgroundColor: "#CCFFFF",
        membersMargin: 5,
        layoutMargin: 10,
        members: [
            IButton_Contact_Save
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
            contactTabs,
            contactFormButtonSaveLayout
            ]
            })

    Window_Contact.addItems([VLayout_contactMain]);
    Window_Contact.show();

}
/////////////////////////// end function()


function manageNote(value, id) {
        if (value == 'Add') {
            dynamicForm_article5_Note2_number30.addFields([
                {
                    type: "Label",
                    name: "article5_Note1_lable" + id,
                    width: "150",
                    height: "40",
                    wrap: true,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Parameters,
                    displayField: "paramValue",
                    valueField: "paramName",
                    showTitle: false,
                    pickListWidth:"700",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "paramName", width: "25%", align: "center"},
                        {name: "paramType", width: "25%", align: "center"},
                        {name: "paramValue", width: "50%", align: "center"}
                    ],
                    pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "contractId", operator: "equals", value: 1},
                        {fieldName:"categoryValue",operator:"equals",value:5}]
                    },
                    changed: function (form, item, value) {
                        dynamicForm_article5_Note2_number30.setValue("article5_Note1_value" + id, item.getSelectedRecord().paramValue);
                    },
                },
                {
                    name: "article5_Note1_value" + id,
                    type: "text",
                    length: 3000,
                    showTitle: false,
                    wrap: false,
                    startRow: true,
                    width: "1500",
                    height: "80",
                    defaultValue: "MAXIMUM ONE WEEK AFTER CONTRACT SIGNATURE/STAMP BUYER IS OBLIGED TO INFORM SELLER OF ITS SHIPMENT SCHEDULE FOR THE REMAINING QUANTITY I.E",
                    title: "article5_Note1",
                },
                {
                    name:"button"+id,
                    type: "button",
                    width: "10%",
                    height: "30",
                    title: "Remove",
                    startRow: false,
                    icon: "icons/16/message.png",
                    click: function(){dynamicForm_article5_Note2_number30.removeFields(["article5_Note1_lable" + id, "article5_Note1_value" + id,"button"+id])}
                    }
            ]);
            i++;
        } else {
            --i;
            dynamicForm_article5_Note2_number30.removeFields(["article5_Note1_lable" + i, "article5_Note1_value" + i,"button"+i]);
        }
    }

function itemsDefinitions(value, id) {
        if (value == 'Add') {
            DynamicForm_ContactParameter_ValueNumber8.addFields([
                {
                    name: "valueNumber8" + id,
                    type: "text",
                    length: 5000,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Parameters,
                    displayField: "paramValue",
                    valueField: "paramValue",
                    showTitle: false,
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "paramName", width: "25%", align: "center"},
                        {name: "paramType", width: "25%", align: "center"},
                        {name: "paramValue", width: "50%", align: "center"}
                    ],
                    pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "contractId", operator: "equals", value: 1},
                        {fieldName:"categoryValue",operator:"equals",value:1}]
                    },
                    showTitle: false,
                    startRow: false,
                    width: "1500",
                    height: "30",
                    title: "NAME",
                    changed: function (form, item, value) {
                        DynamicForm_ContactParameter_ValueNumber8.setValue("valueNumber8" + id, (item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue))
                    }
                },{
                    name:"button"+id,
                    type: "button",
                    width: "10%",
                    height: "30",
                    title: "Remove",
                    startRow: false,
                    icon: "icons/16/message.png",
                    click: function(){DynamicForm_ContactParameter_ValueNumber8.removeField("valueNumber8" + id);DynamicForm_ContactParameter_ValueNumber8.removeField("button" + id)}
                    }
            ]);
            itemsDefinitionsCount++;
        } else {
            --itemsDefinitionsCount;
            DynamicForm_ContactParameter_ValueNumber8.removeField("valueNumber8" + itemsDefinitionsCount);
            DynamicForm_ContactParameter_ValueNumber8.removeField("button" +itemsDefinitionsCount);
        }
    }

function saveCotractDetails(data, contractID) {
        data.contract_id = contractID;
        var allData = Object.assign(data, valuesManagerArticle1.getValues())
        allData.string_Currency="null";
        if(methodUrl=="PUT"){
                allData.id=contractDetailID;
        }
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/contractDetail",
            httpMethod: methodUrl,
            data: JSON.stringify(allData),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    saveValuelotListForADD(contractID);
                    saveListGrid_ContractItemShipment(contractID);
                    saveContractCurrency(contractID);
                    Window_Contact.close();
                    ListGrid_Tozin.invalidateCache();
                    isc.say("<spring:message code='global.form.request.successful'/>.");
                } else
                    isc.say(RpcResponse_o.data);
            }
        }))
    }

function saveListGrid_ContractItemShipment(contractID) {
        ListGrid_ContractItemShipment.selectAllRecords();
        ListGrid_ContractItemShipment.getAllEditRows().forEach(function (element) {
            var data_ContractItemShipment = ListGrid_ContractItemShipment.getEditedRecord(element);
            data_ContractItemShipment.contractId = contractID;
            data_ContractItemShipment.dischargeId = 11022;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contractShipment/",
                httpMethod: "POST",
                data: JSON.stringify(data_ContractItemShipment),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }))
        })
};


function saveContractCurrency(contractID){
    var currencyData =valuesManagerArticle10.getValues();
    currencyData.contractId=contractID
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contractCurrency/",
                httpMethod: methodUrl,
                data: JSON.stringify(currencyData),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }))
    }

function saveValuelotListForADD(contractID) {
        lotList.selectAllRecords();
        lotList.getAllEditRows().forEach(function (element) {
            var data_lotList = lotList.getEditedRecord(element);
            alert(JSON.stringify(data_lotList));
            data_lotList.contractId = contractID;
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                actionURL: "${contextPath}/api/warehouseLot/",
                httpMethod: "PUT",
                data: JSON.stringify(data_lotList),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                    } else{
                        isc.say(RpcResponse_o.data);
                        }
                }
            }))
        })
    };
function itemsEditDefinitions(key,value,id) {
       DynamicForm_ContactParameter_ValueNumber8.addFields([
                {
                    name: key,
                    type: "text",
                    length: 5000,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Parameters,
                    defaultValue:value,
                    displayField: "paramValue",
                    valueField: "paramValue",
                    showTitle: false,
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "paramName", width: "25%", align: "center"},
                        {name: "paramType", width: "25%", align: "center"},
                        {name: "paramValue", width: "50%", align: "center"}
                    ],
                    pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                        {fieldName: "contractId", operator: "equals", value: 1},
                        {fieldName:"categoryValue",operator:"equals",value:1}]
                    },
                    showTitle: false,
                    startRow: false,
                    width: "1500",
                    height: "30",
                    title: "NAME",
                    changed: function (form, item, value) {
                        DynamicForm_ContactParameter_ValueNumber8.setValue(key, (item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue))
                    }
                },{
                    name:"button"+id,
                    type: "button",
                    width: "10%",
                    height: "30",
                    title: "Remove",
                    startRow: false,
                    icon: "icons/16/message.png",
                    click: function(){DynamicForm_ContactParameter_ValueNumber8.removeField("valueNumber8" + id);DynamicForm_ContactParameter_ValueNumber8.removeField("button" + id)}
                    }
            ]);
       itemsDefinitionsCount++;
    }
