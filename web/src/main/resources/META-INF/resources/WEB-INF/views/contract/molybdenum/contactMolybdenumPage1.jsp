<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>
    <% DateUtil dateUtil = new DateUtil();%>
 var contractIdEdit;
 var VLayout_contactMoOxMain;
 var methodUrl="POST";
 var sendDateSetMo;
 var lotList;
 var ListGrid_ContractItemShipment;
 var criteriaContractItemShipment;
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
    ValuesManager("valuesManagerfullArticleMo");

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

var RestDataSource_Incoterms_InMol = isc.MyRestDataSource.create({
fields:
    [
    {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
    {name: "code", title: "<spring:message code='goods.code'/> "},
    ],
    fetchDataURL: "${contextPath}/api/incoterms/spec-list"
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
        criteria: [{fieldName: "used", operator: "equals",value: 0 }]
    };
    var criteriaMo = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "material.descl", operator: "contains", value: "Mol"}]
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
                    validators: [
                    {
                    type:"required",
                    validateOnChange: true }],
                    width: 400
                },
                {
                    name: "dischargeId",
                    title: "<spring:message code='port.port'/>",
                    type: 'text',
                    required: true,
                    validators: [
                    {
                    type:"required",
                    validateOnChange: true }],
                    width: 400
                },
                {name: "discharge.port", title: "<spring:message code='port.port'/>", align: "center"},
                {
                    name: "address",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    required: true,
                    validators: [
                    {
                    type:"required",
                    validateOnChange: true }],
                    width: 400
                },
                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float',
                    required: true,
                    validators: [
                    {
                    type:"required",
                    validateOnChange: true }],
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

    var ViewLoader_createMoOx = isc.ViewLoader.create({
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
                    ViewLoader_createMoOx
                    ]
            });
    var ListGrid_contractMo = isc.ListGrid.create({
                        showFilterEditor: true,
                        width: "100%",
                        height: "100%",
                        dataSource: RestDataSource_Contract,
                        initialCriteria: criteriaMo,
                        autoFetchData: true,
                        fields:
                        [
                            {name: "id", primaryKey: true, canEdit: false, hidden: true},
                           {
                            name: "material.descl",showTitle:"false",
                            title: "Material",
                            hidden: false,
                            align: "center",hidden: true
                            },
                            {name: "contractNo",showTitle:"true",width: "10%", title: "<spring:message code='contact.no'/>", align: "center",canEdit: false}  ,
                            {name: "contractDate",showTitle:"true",width: "10%", title: "<spring:message code='contract.contractDate'/>", align: "center",canEdit: true}  ,
                            {name: "contact.nameFA",showTitle:"true",width: "85%", title: "<spring:message code='contact.name'/>", align: "center"}
                        ]
                        });

    <sec:authorize access="hasAuthority('C_CONTRACT')">
    var ToolStripButton_ContactMo_Add = isc.ToolStripButtonAdd.create({
                            icon: "[SKIN]/actions/add.png",
                            title: "<spring:message code='global.form.new'/>",
                            click: function () {
                                    methodMoHtpp="POST";
                                    Window_ContactMo.show();
                                    contactHeader.clearValues();
                                    valuesManagerfullArticleMo.setValue("");
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
                            }
                    });
    </sec:authorize>

var Window_ContactMo = isc.Window.create({
                title: "<spring:message code='salesContractMoButton.title'/>",
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

    <sec:authorize access="hasAuthority('U_CONTRACT')">
    var ToolStripButton_ContactMo_Edit = isc.ToolStripButtonEdit.create({
                            icon: "[SKIN]/actions/edit.png",
                            title: "<spring:message code='global.form.edit'/>",
                            click: function () {
                                var record = ListGrid_contractMo.getSelectedRecord();
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
                            methodMoHtpp="PUT";
                            contractIdEdit=record.id;
                            var criterialotList={_constructor:"AdvancedCriteria",operator:"or",criteria:[{fieldName:"contractId",operator:"equals",value:record.id},{fieldName: "used", operator: "equals",value: 0 }]};
                            criteriaContractItemShipment = {
                                        _constructor: "AdvancedCriteria",
                                        operator: "and",
                                        criteria: [{fieldName: "contractId", operator: "equals", value: record.id}]
                                    };
                                    var articleMo=record.contractNo+"?Mo";
                                    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                                actionURL: "${contextPath}/api/contract/readWord",
                                                httpMethod: "PUT",
                                                data: JSON.stringify(articleMo),
                                                callback: function (resp) {
                                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                                        var textMo = resp.httpResponseText;
                                                        var text2Mo = textMo.replaceAll('","', '","').replaceAll('&?','":"')
                                                        var textMainMo= JSON.parse(text2Mo.replaceAt(0,'{"').replaceAt(text2Mo.length-1,'}'));
                                                        setTimeout(function(){
                                                               // contactTabs.selectTab(0);
                                                                dynamicFormMoox_fullArticle01.setValue(textMainMo.Article01);
                                                                dynamicForm_fullArticle02MoOx.setValue(textMainMo.Article02);
                                                                dynamicForm_fullArticle03.setValue(textMainMo.Article03);
                                                                dynamicForm_fullArticle04.setValue(textMainMo.Article04);
                                                                dynamicForm_fullArticle05.setValue(textMainMo.Article05);
                                                                dynamicForm_fullArticle06.setValue(textMainMo.Article06);
                                                                dynamicForm_fullArticle07.setValue(textMainMo.Article07);
                                                                dynamicForm_fullArticle08.setValue(textMainMo.Article08);
                                                                dynamicForm_fullArticle09.setValue(textMainMo.Article09);
                                                                valuesManagerfullArticleMo.setValue("fullArticle10",textMainMo.Article10);
                                                                ListGrid_ContractItemShipment.fetchData(criteriaContractItemShipment);
                                                                lotList.fetchData(criterialotList);
                                                        },200)
                                                    }else{
                                                        isc.say(RpcResponse_o.data);
                                                }
                                                }
                                            }))
                                    var criteria1 = {
                                                    _constructor: "AdvancedCriteria",
                                                    operator: "and",
                                                    criteria: [{fieldName: "contract.id", operator: "equals", value: record.id}]
                                                };
                                    setTimeout(function () {
                                    RestDataSource_contractDetail_list.fetchData(criteria1,function (dsResponse, data, dsRequest) {
                                    //dynamicFormMaterial.setValue("materialId",record.materialId)
                                    contactHeader.setValue("createDate", record.contractDate)
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
                                    valuesManagerArticle4.setValue("mo_amount",record.mo_amount);
                                    valuesManagerArticle5.setValue("timeIssuance",record.timeIssuance);
                                    valuesManagerArticle5.setValue("prefixPayment",record.prefixPayment);
                                    valuesManagerArticle6.setValue("article6_number31",data[0].article6_number31);
                                    valuesManagerArticle6.setValue("incotermsId",record.incotermsId);
                                    valuesManagerArticle6.setValue("incotermsText",record.incotermsText);
                                    valuesManagerArticle6.setValue("article6_Containerized",data[0].article6_Containerized);
                                    valuesManagerArticle7.setValue("article7_number41",data[0].article7_number41);
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
                                    valuesManagerArticle8.setValue("delay",record.delay);
                                    valuesManagerArticle9.setValue("article9_number45",data[0].article9_number45);
                                    valuesManagerArticle10.setValue("article10_number61",data[0].article10_number61);
                                    })}, 300)
                                    pageMolibdenAll(1);
                            }
                            }});
    </sec:authorize>
    var ToolStripButton_ContactMO_Refresh = isc.ToolStripButtonRefresh.create({
                                title: "<spring:message code='global.form.refresh'/>",
                                click: function () {
                                       ListGrid_contractMo.invalidateCache(criteriaMo);
                                }
                            });

    var ToolStrip_Actions_ContactMO = isc.ToolStrip.create({
                        width: "100%",
                        height: "100%",
                        membersMargin: 5,
                        members: [

                            <sec:authorize access="hasAuthority('C_CONTRACT')">
                            ToolStripButton_ContactMo_Add,
                            </sec:authorize>

                            <sec:authorize access="hasAuthority('U_CONTRACT')">
                            ToolStripButton_ContactMo_Edit,
                            </sec:authorize>

                            isc.ToolStrip.create({
                            width: "100%",
                            align: "left",
                            border: '0px',
                            members: [
                                    ToolStripButton_ContactMO_Refresh,
                            ]
                            })
                        ]
                        });
                    var HLayout_Actions_ContactMo = isc.HLayout.create({
                         width: "100%",
                         members: [
                         ToolStrip_Actions_ContactMO
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


           isc.VLayout.create({
                        ID:"VLayout_MoOx_Grid",
                        width: "100%",
                        height: "100%",
                        members: [
                        HLayout_Actions_ContactMo,
                        ListGrid_contractMo
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
            align: "center",
            valign: "center",
            wrap: false,
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
function pageMolibdenAll(method){
    if(method==0){
        methodMoHtpp="POST";
        }else{
        methodMoHtpp="PUT";
        }
    //START PAGE ONE
    factoryLableHedear("LablePage", '<font><b>NATIONAL IRANIAN COPPER INDUSTRIES CO.<b></font>', "100%", "10", 4)
    factoryLable("lableNameContactMo", '<b><font size=4px>Molybdenum Oxide Contract-BAPCO/NICICO</font><b>', "100%", '2%', 2);
    factoryLable("lableArticle2Mo", '<b><font size=4px>ARTICLE 2 -QUANTITY :</font><b>', "100%", '2%', 20);
    factoryLableArticle("lableArticle1Mo", '<b><font size=4px>ARTICLE 1 - DEFINITIONS:</font><b>', "30", 5)
    factoryLableArticle("lableArticle3MO", '<b><font size=4px>Article 3 - QUANTITY</font><b>', "30", 5)
    factoryLableArticle("lableArticle6Mo", '<b><font size=4px>ARTICLE 6 - DELIVERY TERMS</font><b>', "30", 5)
    factoryLableArticle("lableArticle7Mo", '<b><font size=4px>ARTICLE 7 - PRICE</font><b>', '30', 5);
    factoryLableArticle("lableArticle8Mo", '<b><font size=4px>ARTICLE 8 - OUOTATIONAL PERIOD</font><b>', '30', 5);
    factoryLableArticle("lableArticle9Mo", '<b><font size=4px>ARTICLE 9 - PAYMENT</font><b>', '30', 5);
    factoryLableArticle("lableArticle10Mo", '<b><font size=4px>ARTICLE 10  - CURRENCY OPTION:</font><b>', '30', 5);
    var lable_article2_1 = isc.Label.create({
        wrap: false,
        padding: 5,
        contents: '<b><font size=2px>  OPTION WILL BE CONSIDERED FOR EACH SHIPMENT QUANTITY.</font><b>'
    })
    var DynamicForm_ContactHeader = isc.DynamicForm.create({
        valuesManager: "contactHeader",
        wrapItemTitles: false,
        width: "100%",
        height: "100%",
        titleWidth: "80",
        cellPadding: 2,
        numCols: 4,
        fields: [
            {name: "id", hidden: true},
            {name: "contractDate", hidden: true,},
            {
                name: "createDate",
                title: "<spring:message code='contact.date'/>",
                defaultValue: "<%=dateUtil.todayDate()%>",
                type: "date",
                format: 'DD-MM-YYYY',
                required: true,
                validators: [
                {
                type:"required",
                validateOnChange: true }],
                width: "90%",
                wrapTitle: false
            },
            {
                name: "contractNo",
                title: "<spring:message code='contact.no'/>",
                requiredMessage: "<spring:message code='validator.field.is.required'/>",
                required: true,
                validators: [
                {
                    type:"required",
                    validateOnChange: true
                }],
                readonly: true,
                width: "90%",
                wrapTitle: false
            }
        ]
    });
    var dynamicForm1Mo = isc.HLayout.create({align: "center", members: []});
    var dynamicForm2Mo = isc.HLayout.create({align: "center", members: []});
    var dynamicForm3Mo = isc.HLayout.create({align: "center", members: []});
    var dynamicForm4Mo = isc.HLayout.create({align: "center", members: []});
var DynamicForm_ContactCustomer = isc.DynamicForm.create({
        valuesManager: "contactHeader",
        width: "100%",
        height: "100%",
        numCols: 4,
        wrapItemTitles: false,
        fields: [
            {name: "id", canEdit: false, hidden: true},
            {
                name: "contactId",
                showHover: true,
                required: true,
                validators: [
                {
                type:"required",
                validateOnChange: true }],
                autoFetchData: false,
                title: "<spring:message code='contact.commercialRole.buyer'/>",
                width: "600",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                optionCriteria: RestDataSource_ContactBUYER_optionCriteria,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "600",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center", hidden: true}
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
                width:"600",
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                optionCriteria: RestDataSource_ContactAgentBuyer_optionCriteria,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "600",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center", hidden: true}
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
    dynamicForm1Mo.addMember("Contact_ContactBuyer",1);
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
    dynamicForm2Mo.addMember("Contact_ContactAgentBuyer",2);
    var DynamicForm_ContactSeller = isc.DynamicForm.create({
        valuesManager: "contactHeader",
        width: "100%",
        height: "100%",
        numCols: 4,
        wrapItemTitles: false,
        fields: [
            {name: "id", canEdit: false, hidden: true},
            {
                name: "contactBySellerId",
                numCols: 2,
                showHover: true,
                autoFetchData: false,
                title: "<spring:message code='contact.commercialRole.seller'/>",
                width: "600",
                required: true,
                validators: [
                {
                type:"required",
                validateOnChange: true }],
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                optionCriteria: RestDataSource_Contact_optionCriteria,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "600",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center", hidden:true }
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
                title: "<spring:message code='contact.commercialRole.agentSeller'/>",
                width: "600",
                required: false,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                optionCriteria: RestDataSource_ContactAgentSeller_optionCriteria,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "600",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "45%", align: "center"},
                    {name: "nameEN", width: "45%", align: "center"},
                    {name: "code", width: "10%", align: "center", hidden: true}
                ],
                changed: function (form, item, value) {
                    var address = "";
                    var name = "";
                    var phone = "";
                    var mobile = "";
                    if (item.getSelectedRecord().address != undefined) {
                        address = item.getSelectedRecord().address;
                        Contact_ContactAgentSellerMo.setValue("address_ContactAgentSeller", address);
                    }
                    if (item.getSelectedRecord().nameEN != undefined) {
                        name = item.getSelectedRecord().nameEN;
                        Contact_ContactAgentSellerMo.setValue("name_ContactAgentSeller", name);
                    }
                    if (item.getSelectedRecord().phone != undefined) {
                        phone = item.getSelectedRecord().phone;
                        Contact_ContactAgentSellerMo.setValue("phone_ContactAgentSeller", phone);
                    }
                    if (item.getSelectedRecord().mobile != undefined) {
                        mobile = item.getSelectedRecord().mobile;
                        Contact_ContactAgentSellerMo.setValue("mobile_ContactAgentSeller", mobile);
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
    dynamicForm3Mo.addMember("Contact_ContactSeller",3);
    isc.DynamicForm.create({
                                ID: "Contact_ContactAgentSellerMo",
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
     dynamicForm4Mo.addMember("Contact_ContactAgentSellerMo",4);

var DynamicForm_ContactMooxParameter_ValueNumber8=isc.DynamicForm.create({
        valuesManager: "valuesManagerMooXArticle1",
        height: "20",
        width: "100%",
        wrapItemTitles: true,
        numCols: 4,
        items: [
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
                    {name: "paramName", title: "<spring:message code='parameters.paramName'/>", width: "20%", align: "center"},
                    {name: "paramValue", title: "<spring:message code='parameters.paramValue'/>", width: "60%", align: "center"},
                    {
                    name: "categoryValue",
                    title: "<spring:message	code='parameters.paramValue.d'/>",
                    width: "15%",
                    type: "text",
                    required: true,
                    valueMap: {
                        "1": "Unit",
                        "2": "Time",
                        "3": "Financial",
                        "-2": "BANK REFERENCE"
                    }
                    }
                ],
                pickListCriteria: {
                    _constructor: 'AdvancedCriteria', operator: "and", criteria: [
                        {fieldName: "contractId", operator: "equals", value: 2}
                        ]
                },
                width: "1200",
                height: "30",
                title: "NAME",
                changed: function (form, item, value) {
                    DynamicForm_ContactMooxParameter_ValueNumber8.setValue("definitionsOne", item.getSelectedRecord().paramName + "=" + item.getSelectedRecord().paramValue);
                    dynamicFormMoox_fullArticle01.setValue(dynamicFormMoox_fullArticle01.getValue("fullArticle01")+"<br>"+"-"+DynamicForm_ContactMooxParameter_ValueNumber8.getValue("definitionsOne"))
                    DynamicForm_ContactMooxParameter_ValueNumber8.clearValue("definitionsOne");
                    }
            }
        ]
    })



    var VLayout_ContactParameter_ValueNumber8MO = isc.VLayout.create({
        width: "100%",
        members: [DynamicForm_ContactMooxParameter_ValueNumber8]
    })

    var dynamicFormMoox_fullArticle01 = isc.RichTextEditor.create({
        valuesManager: "valuesManagerfullArticleMo",
        ID:"dynamicFormMoox_fullArticle01ID",
        autoDraw:true,
        height:155,
        overflow:"auto",
        canDragResize:true,
        controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
        value:"",changed: function (form, item, value) {
                    if(value==undefined)
                      dynamicFormMoox_fullArticle01.setValue("")
                    else
                      dynamicFormMoox_fullArticle01.setValue(dynamicFormMoox_fullArticle01.getValue())
                    }
            })

    var article2Mo = isc.DynamicForm.create({
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
                keyPressFilter: "[0-9.]", ///article2_number10
                changed: function (form, item, value) {
                    article2Mo.setValue("amount_en", numberToEnglish(value))
                    },
                textAlign: "left"
            },
            {
                type: "text", styleName: "textToLable", width: "200",
                name: "amount_en", title: "", showTitle: false, disabled: "true"
            }, ///english,
            {
                name: "unitId", //article2_number12
                title: "",
                type: 'long',
                width: "250",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "id",
                pickListWidth: "250",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 245, align: "center"}
                ],changed: function (form, item, value) {
                }
            },
            {
                type: "text",
                width: "80",
                name: "molybdenumTolorance",
                title: "+/-",
                defaultValue: "",
                keyPressFilter: "[0-9.]", //article2_13
                changed: function (form, item, value) {
                    article2_1.setValue("article2_13_1",value);
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
                }
            },
            {
                type: "text",
                name: "plant", //article2_15
                width: "500",
                startRow: false,
                title: '<b><font size=2px>OPTION) PRODUCED IN</font><b>',
                changed: function (form, item, value) {
                        dynamicForm_fullArticle02MoOx.setValue(article2Mo.getValue("amount")+" "+"("+article2Mo.getValue("amount_en")+")"+" "+article2Mo.getItem("unitId").getDisplayValue(article2Mo.getValue("unitId"))+" "+article2Mo.getValue("molybdenumTolorance")+" "+"(IN" + article2Mo.getItem("optional").getDisplayValue(article2Mo.getValue("optional")) + " " + "'S OPTION) IN PRODUCED IN"+" "+article2Mo.getValue("plant")+" "+"THE TOLERENCE OF +/-%"+article2Mo.getValue("molybdenumTolorance")+" "+"IN"+" "+article2Mo.getItem("optional").getDisplayValue(article2Mo.getValue("optional"))+" "+"OPTION WILL BE CONSIDRED FOR EACH SHIPMENT QUANTITY.");
                }
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
                startRow: false, keyPressFilter: "[0-9.]",
                title: '<b><font size=2px>THE TOLERENCE OF +/-%</font><b>',
                textAlign: "left"
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

var dynamicForm_fullArticle02MoOx = isc.RichTextEditor.create({
        ID:"dynamicForm_fullArticle02MoOxID",
        valuesManager: "valuesManagerfullArticleMo",
        autoDraw:true,
        height:155,
        overflow:"scroll",
        canDragResize:true,
        controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
        value:""
    })
lotList = isc.ListGrid.create({
        showFilterEditor: true,
        width: "100%",
        height: "180",
        dataSource: RestDataSource_WarehouseLot,
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



var vlayoutBodyMo = isc.VLayout.create({
        width: "100%",
        height: "8%",
        styleName: "mol-page1-form",
        members: [
            isc.HLayout.create({align: "left", members: [DynamicForm_ContactHeader]}),
            isc.HLayout.create({height: "50", align: "left", members: [lableNameContactMo]}),
            isc.HLayout.create({align: "left", members: [DynamicForm_ContactCustomer]}),
            isc.HLayout.create({ID: "dynamicForm1And2Mo", align: "center", members: [dynamicForm1Mo, dynamicForm2Mo]}),
            isc.HLayout.create({align: "center", members: [DynamicForm_ContactSeller]}),
            isc.HLayout.create({ID: "dynamicForm3And4Mo", align: "center", members: [dynamicForm3Mo, dynamicForm4Mo]})
        ]
    });
var vlayoutArticle1Mo = isc.VLayout.create({
        width: "100%",
        height: "30%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({
                align: "left",
                members: [lableArticle1Mo]
            }),
            isc.HLayout.create({align: "left", members: [VLayout_ContactParameter_ValueNumber8MO]}),
            dynamicFormMoox_fullArticle01
        ]
    });
var vlayoutArticle2 = isc.VLayout.create({
        width: "100%",
        height: "30%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "center", members: [lableArticle2Mo]}),
            isc.HLayout.create({align: "left", members: [article2Mo]}),
            isc.HLayout.create({align: "left", members: [article2_1, lable_article2_1]}),
            dynamicForm_fullArticle02MoOx
        ]
    });
var vlayoutArticle3 = isc.VLayout.create({
        width: "100%",
        height: "30%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "5%", align: "left", members: [lableArticle3MO]}),
            isc.HLayout.create({height: "95%", width: "100%", align: "center", members: [lotList]})
        ]
    });
    isc.VLayout.create({
        ID: "VLayout_PageOne_ContractMo",
        width: "100%",
        height: "100%",
        backgroundColor: "#69fe8a",
        align: "center",
        overflow: "scroll",
        members: [
            isc.HStack.create({height: "10",width: "100%",align: "center",members: [LablePage]}),
            vlayoutBodyMo,
            vlayoutArticle1Mo,
            vlayoutArticle2,
            vlayoutArticle3
        ]
    });

    //END PAGE ONE

    //START PAGE TOW
    factoryLableArticle("lableArticle3Typicall", '<b><font size=4px>TYPICAL ANALYSIS: </font><b>', '5%', 1);
    factoryLableArticle("lableArticle4", '<b><font size=4px>ARTICLE 4 - PACKING</font><b>', '2%', 1);
    factoryLableArticle("lableArticle5", '<b><font size=4px>ARTICLE 5 - SHIPMENT</font><b>', "20", 1)


var dynamicForm_fullArticle03 = isc.RichTextEditor.create({
            ID:"dynamicForm_fullArticle03ID",
            valuesManager: "valuesManagerfullArticleMo",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
})

var dynamicForm_article3_1 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle3",
        height: "20",
        wrapItemTitles: false,
        items: [
            {
                name: "contactInspectionId", ///article3_number17_1
                showHover: true,
                autoFetchData: false,
                hint: "AHK",
                width: "400",
                showHintInField: true,
                showTitle: true,
                required: false,
                title: "Inspection : ",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contact,
                displayField: "nameFA",
                valueField: "id",
                pickListWidth: "400",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "nameFA", width: "50%", align: "center"},
                    {name: "nameEN", width: "50%", align: "center"},
                    {name: "code", align: "center", hidden: true}
                ],
                pickListCriteria:{_constructor:'AdvancedCriteria',operator:"and",criteria:[
                    {fieldName: "inspector", operator: "equals", value: 1}]
                    },
                changed: function (form, item, value) {
                }
            }
        ]
    })

    dynamicForm_article3_Typicall = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle3",
        height: "20",
        numCols: 10,
        wrapItemTitles: false,
        items: [
            {name: "title",disabled:"false",defaultValue:"Prefix",width:"80",title: "TITLE",startRow:true},       //title
            {name: "titleValue",disabled:"false",defaultValue:"Value",title: "",width:"100",keyPressFilter: "[0-9.]",showTitle: false,startRow:false},
            {name: "titleTolerance",disabled:"false",keyPressFilter: "[0-9.]",defaultValue:"Tolerance",title: "",width:"100",showTitle: false,startRow:false},
            {name: "titleUnit",disabled:"false",defaultValue:"Unit",title: "",width:"200",showTitle: false,startRow:false},
            {name: "PrefixMolybdenum",width:"80",title: "MO",defaultValue: "",startRow:true,disabled:true},       //molybdenum
            {name: "molybdenum",keyPressFilter: "[0-9.]",title: "",width:"100",showTitle: false,startRow:false,defaultValue: 64},
            {name: "toleranceMO",keyPressFilter: "[0-9.]",title: "",width:"100",showTitle: false,startRow:false,defaultValue: 4},
            {name: "typical_unitMO",title:"",width:"200",showTitle:false,startRow:false,editorType: "SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                pickListWidth: "200",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 195, align: "center"}]},
            {name: "PrefixCopper",width:"80",defaultValue: "<=",title: "CU",startRow:true},           //copper
            {name: "copper",keyPressFilter: "[0-9.]",title: "",width:"100",keyPressFilter: "[0-9.]",showTitle: false,startRow:false,defaultValue: 1.7},
            {name: "toleranceCU",keyPressFilter: "[0-9.]",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitCU",title:"",width:"200",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "200",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 195, align: "center"}]},
            {name: "PrefixC",width:"80",defaultValue: "<=", title: "C",startRow:true},            //C
            {name: "typical_c",title: "",width:"100", keyPressFilter: "[0-9.]",showTitle: false,startRow:false,defaultValue: 0.04},
            {name: "toleranceC",keyPressFilter: "[0-9.]",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitC",title:"",width:"200",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "200",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 195, align: "center"}]},
            {name: "PrefixS",width:"80",defaultValue: "<=",title: "S",startRow:true},                 //S
            {name: "typical_s",title: "",width:"100", keyPressFilter: "[0-9.]",showTitle: false,startRow:false,defaultValue: 0.12},
            {name: "toleranceS",keyPressFilter: "[0-9.]",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitS",title:"",width:"200",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "200",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 195, align: "center"}]},
            {name: "PrefixPb",width:"80",defaultValue: "<=", title: "Pb",startRow:true},               //Pb
            {name: "typical_pb",title: "",width:"100", keyPressFilter: "[0-9.]",showTitle: false,startRow:false,defaultValue: 0.12},
            {name: "tolerancePb",keyPressFilter: "[0-9.]",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitPb",title:"",width:"200",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "200",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 195, align: "center"}]},
            {name: "PrefixP",width:"80",defaultValue: "<=", title: "P",startRow:true},               //P
            {name: "typical_p",title: "",width:"100", keyPressFilter: "[0-9.]",showTitle: false,startRow:false,defaultValue: 0.04},
            {name: "toleranceP",keyPressFilter: "[0-9.]",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitP",title:"",width:"200",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "200",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 195, align: "center"}]},
            {name: "PrefixSi",width:"80", defaultValue: "<=",title: "Si",startRow:true},               //Si
            {name: "typical_Si",title: "",width:"100",keyPressFilter: "[0-9.]",showTitle: false,startRow:false,defaultValue: 1.1},
            {name: "toleranceSi",keyPressFilter: "[0-9.]",title: "",width:"100",showTitle: false,startRow:false},
            {name: "typical_unitSi",title:"",width:"200",showTitle:false,startRow:false,editorType:"SelectItem",optionDataSource: RestDataSource_Unit,
                displayField: "nameEN",
                valueField: "nameEN",
                autoFetchData: false,
                pickListWidth: "200",
                pickListHeight: "500",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "id", title: "id", canEdit: false, hidden: true},
                    {name: "nameEN", width: 195, align: "center"}]}
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
                showHintInField: true, keyPressFilter: "[0-9.]",
                startRow: false,
                title: '-Typical value: ',
                changed: function (form, item, value) {
                    dynamicForm_fullArticle03.setValue("");
                    dynamicForm_fullArticle03.setValue("\n"+dynamicForm_fullArticle03.getValue()+value+"MT"+"+/-"+valuesManagerArticle2.getValue("molybdenumTolorance")+"%"+" "+"AS A WHOLE AFTER CONTRACT SETTLEMENT WITH BELOW ANALYSIS AND SIZE DETERMINATION:")//TO DO 13
                    dynamicForm_fullArticle03.setValue(dynamicForm_fullArticle03.getValue()+"\n"+valuesManagerArticle3.getValue("contactInspectionId")+" "
                    +"ANALYSIS RESULTS FOR THE REMAINING QUANTITY ("+value+"MT +/-"+article2Mo.getValue("molybdenumTolorance")+"-IN "+article2_1.getItem("responsibleTelerons").getDisplayValue(article2_1.getValue("responsibleTelerons"))+" OPTION) WHICH WILL BE PERFORMED AT "+" "+valuesManagerArticle3.getValue("contactInspectionId")+", IS FINAL AND BINDING FOR SETTLEMENT PURPOSES.");
                }
            }
        ]
    })
    var dynamicForm_article4_1_number19 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle4",
        height: "100%",
        numCols: 6,
        wrapItemTitles: false,
        items: [
          {     name: "mo_amount", //amount_number19
                showTitle: true,
                width: "70",
                defaultValue: "220",
                keyPressFilter: "[0-9.]",
                textAlign: "left",
                showHintInField: true,
                startRow: false,
                title: 'MOLYBDENUM OXIDE VALUE: ',changed: function (form, item, value) {
                dynamicForm_fullArticle04.setValue("");
                dynamicForm_fullArticle04.setValue("IN STEEL DRUMS OF "+value+" LITERS, WITH LIDS SECURED BY RINGS ON PALLETS.");
                }
          }
        ]
    })

    var dynamicForm_fullArticle04 = isc.RichTextEditor.create({
                ID:"dynamicForm_fullArticle04ID",
                valuesManager: "valuesManagerfullArticleMo",
                autoDraw:true,
                height:155,
                overflow:"auto",
                canDragResize:true,
                controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
                value:""
    })
    var dynamicForm_article5_number21 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle5",
        height: "20",
        numCols: 14,
        wrapItemTitles: false,
        items: [
            {   name: "prefixPayment", //article5_number22
                showTitle: true,
                width: "100",
                defaultValue: "105%",
                showHintInField: true,
                startRow: false,
                title: 'PAY BEFORE EACH SHIPMENT ',
                changed: function (form, item, value) {
                }
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
        showFilterEditor: true,
        width: "100%",
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
                    align: "center"
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    type: "date",
                    required: false,
                    width: "10%",
                    wrapTitle: false,changed: function (form, item, value) {
                        sendDateSetMo = (value.getFullYear() + "/" + ("0" + (value.getMonth() + 1)).slice(-2) + "/" + ("0" + value.getDate()).slice(-2));
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
                    name: "tolorance", title: "<spring:message code='contractItemShipment.tolorance'/>", type: 'text', width: "10%", align: "center"
                },{
                    name: "incotermsShipmentId",
                    colSpan: 3,
                    titleColSpan: 1,
                    tabIndex: 6,
                    showTitle: true,
                    showHover: true,
                    showHintInField: true,
                    required: true,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }],
                    type: 'long',
                    numCols: 4,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Incoterms_InMol,
                    displayField: "code",
                    valueField: "id",
                    pickListWidth: "450",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "code", width: 440, align: "center"}
                    ],
                    width: "10%",
                    title: "<strong class='cssDynamicForm'>SHIPMENT TYPE<strong>"
                },
            ],saveEdits: function () {
            },removeData: function (data) {
            if(data.deleted){
                data.deleted = false;
                return;
              }
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
                                         data.deleted = true;
                                         ListGrid_ContractItemShipment.markSelectionRemoved();
                                    }
                    }
            })
        }
    });

    var vlayout_ContractItemShipment = isc.VLayout.create({align: "center", members: [ListGrid_ContractItemShipment]});
    var dynamicForm_fullArticle05 = isc.RichTextEditor.create({
            ID:"dynamicForm_fullArticle05ID",
            valuesManager: "valuesManagerfullArticleMo",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
    })

    var dynamicForm_article6_number32_33_34_35 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle6",
        height: "20",
        numCols: 12,
        wrapItemTitles: false,
        padding: 2,
        items: [
            {
                name: "incotermsId", //article6_number32
                colSpan: 3,
                titleColSpan: 1,
                width: "200",
                tabIndex: 6,
                showTitle: true,
                showHover: true,
                showHintInField: true,
                title:'FOB',
                hint: "FOB",
                required: true,
                validators: [
                {
                type:"required",
                validateOnChange: true }],
                title: "<spring:message code='incoterms.name'/>",
                type: 'long',
                numCols: 4,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Incoterms,
                displayField: "code",
                valueField: "id",
                pickListWidth: "200",
                pickListHeight: "200",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {name: "code", width: 195, align: "center"}
                ],
                changed: function (form, item, value) {
                }
            },{
                name: "incotermsText", //article6_number35
                width: "200",
                showTitle: true,
                title:'INCOTERMS',
                showHintInField: true,
                defaultValue: "(INCOTERMS 2010).",
                startRow: false
            }
        ]
    })


    var vlayoutArticle3_1 = isc.VLayout.create({
        width: "100%",
        height: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({align: "left", members: [dynamicForm_article3_1]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article3_3]}),
            isc.HLayout.create({height: "30", align: "left", members: [lableArticle3Typicall]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article3_Typicall]}),
            isc.HLayout.create({height: "30",width: "100%",align: "left", members: [dynamicForm_fullArticle03]})
        ]
    });
    var vlayoutArticle4 = isc.VLayout.create({
        width: "100%",
        height: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "left", members: [lableArticle4]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article4_1_number19]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_fullArticle04]})
        ]
    });
    var vlayoutArticle5 = isc.VLayout.create({
        width: "100%",
        height: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "left", members: [lableArticle5]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article5_number21]}),
            isc.HLayout.create({
                height: "30",
                align: "left",
                members: [dynamicForm_article5_number24_number25_number26]
            }),
            isc.HLayout.create({height: "30", align: "left", members: [vlayout_ContractItemShipment]}),
            dynamicForm_fullArticle05
        ]
    });
    var dynamicForm_fullArticle06 = isc.RichTextEditor.create({
            ID:"dynamicForm_fullArticle06ID",
            valuesManager: "valuesManagerfullArticleMo",
            autoDraw:true,
            height:155,
            overflow:"auto",
            canDragResize:true,
            controlGroups:["fontControls", "formatControls", "styleControls", "colorControls"],
            value:""
    })

    var vlayoutArticle6 = isc.VLayout.create({
        width: "100%",
        height: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "left", members: [lableArticle6Mo]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article6_number32_33_34_35]}),
            isc.HLayout.create({height: "80", align: "left", members: [dynamicForm_fullArticle06]})
        ]
    });

    var VLayout_PageTwo_ContractMol = isc.VLayout.create({
        width: "100%",
        height: "100%",
        align: "center",
        backgroundColor: "#c0110c",
        overflow: "scroll",
        members: [
            vlayoutArticle3_1,
            vlayoutArticle4,
            vlayoutArticle5,
            vlayoutArticle6
        ]
    });
    //END PAGE TWO

    //START PAGE THREE

     var dynamicForm_article7_discount = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle7",
        height: "20",
        numCols: 10,
        wrapItemTitles: false,
        items: [
            {name: "discountValueOne",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:7},       //discountValueOne
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueOne_1",defaultValue:"",title: "",width:"100",showTitle: false,startRow:false,showIf:"false"},
            {name: "discountPerfixOne",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false,showIf:"false"},
            {name: "discountUnitOne",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixOne_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueOne_2",defaultValue:0.70,title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueTwo",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:8},       //discountValueTwo
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueTwo_1",defaultValue:0.70,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixTwo",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitTwo",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixTwo_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueTwo_2",defaultValue:0.80,title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueThree",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:9},       //discountValueThree
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueThree_1",defaultValue:0.80,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixThree",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitThree",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixThree_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueThree_2",defaultValue:0.90,title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueFour",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:9.5},       //discountValueFour
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueFour_1",defaultValue:0.90,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixFour",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitFour",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixFour_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueFour_2",defaultValue:1.00,title: "",width:"100",showTitle: false,startRow:false},
             {name: "discountValueFive",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:10},       //discountValueFive
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueFive_1",defaultValue:1.00,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixFive",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitFive",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixFive_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueFive_2",defaultValue:1.10,title: "",width:"100",showTitle: false,startRow:false},
             {name: "discountValueSix",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:11},       //discountValueSix
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueSix_1",defaultValue:1.10,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixSix",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitSix",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixSix_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueSix_2",defaultValue:1.20,title: "",width:"100",showTitle: false,startRow:false},
               {name: "discountValueSeven",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:11.5},       //discountValueSeven
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueSeven_1",defaultValue:1.20,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixSeven",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitSeven",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixSeven_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueSeven_2",defaultValue:1.30,title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueEight",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:12},       //discountValueEight
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueEight_1",defaultValue:1.30,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixEight",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitEight",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixEight_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueEight_2",defaultValue:1.40,title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueNine",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:12.5},       //discountValueNine
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueNine_1",defaultValue:1.40,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixNine",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitNine",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixNine_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueNine_2",defaultValue:1.50,title: "",width:"100",showTitle: false,startRow:false},
                 {name: "discountValueTen",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:13},       //discountValueTen
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueTen_1",defaultValue:1.50,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixTen",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitTen",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixTen_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueTen_2",defaultValue:1.60,title: "",width:"100",showTitle: false,startRow:false},
                {name: "discountValueEleven",width:"80",showTitle: true,title: "*",startRow:true,defaultValue:13.5},       //discountValueEleven
            {name: "discountFor",width:"200",disabled:"false",defaultValue:"DISCOUNT FOR",title: "",showTitle: false,startRow:false},
            {name: "discountValueEleven_1",defaultValue:1.60,title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixEleven",defaultValue:"<",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountUnitEleven",defaultValue:"CU",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountPerfixEleven_1",defaultValue:"<=",title: "",width:"100",showTitle: false,startRow:false},
            {name: "discountValueEleven_2",defaultValue:1.70,title: "",width:"100",showTitle: false,startRow:false}
            ]
    });
    var dynamicForm_fullArticle07 = isc.RichTextEditor.create({
        ID:"dynamicForm_fullArticle07ID",
        valuesManager: "valuesManagerfullArticleMo",
        autoDraw: true,
        height: 155,
        overflow: "auto",
        canDragResize: true,
        controlGroups: ["fontControls", "formatControls", "styleControls", "colorControls"],
        value: ""
    })

    var vlayoutArticle7 = isc.VLayout.create({
        width: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "50", align: "left", members: [lableArticle7Mo]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article7_discount]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_fullArticle07]})
        ]
    });

    var dynamicForm_article8_3 = isc.DynamicForm.create({
        valuesManager: "valuesManagerArticle8",
        height: "20",
        numCols: 10,
        wrapItemTitles: false,
        padding: 5,
        items: [
            {
                name: "delay", //article8_number44
                width: "80",
                showTitle: true,
                startRow: false,
                title: 'MOAS'
            }
        ]
    })
    var dynamicForm_fullArticle08 = isc.RichTextEditor.create({
        ID:"dynamicForm_fullArticle08ID",
        valuesManager: "valuesManagerfullArticle",
        autoDraw: true,
        height: 155,
        overflow: "scroll",
        canDragResize: true,
        controlGroups: ["fontControls", "formatControls", "styleControls", "colorControls"],
        value: ""
    })

    var vlayoutArticle8 = isc.VLayout.create({
        width: "100%",
        height: "50",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "30", align: "left", members: [lableArticle8Mo]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_article8_3]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_fullArticle08]})
        ]
    });

    var dynamicForm_fullArticle09 = isc.RichTextEditor.create({
        ID:"dynamicForm_fullArticle09ID",
        valuesManager: "valuesManagerfullArticleMo",
        autoDraw: true,
        height: 155,
        overflow: "auto",
        canDragResize: true,
        controlGroups: ["fontControls", "formatControls", "styleControls", "colorControls"],
        value: ""
    })

    var vlayoutArticle9 = isc.VLayout.create({
        width: "100%",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({height: "10", align: "left", members: [lableArticle9Mo]}),
            isc.HLayout.create({height: "30", align: "left", members: [dynamicForm_fullArticle09]})
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
                name: "article10_number61",
                width: "150",
                showTitle: true,
                defaultValue: "",
                startRow: false,
                title: 'RATE'
            }
        ]
    });

    var dynamicForm_fullArticle10 = isc.RichTextEditor.create({
        ID:"dynamicForm_fullArticle10ID",
        valuesManager: "valuesManagerfullArticleMo",
        autoDraw: true,
        height: 155,
        overflow: "auto",
        canDragResize: true,
        controlGroups: ["fontControls", "formatControls", "styleControls", "colorControls"],
        value: ""
    })
    var vlayoutArticle10 = isc.VLayout.create({
        width: "100%",
        height: "50",
        styleName: "box-shaddow",
        members: [
            isc.HLayout.create({ height: "30",align: "left", members: [lableArticle10Mo] }),
            isc.HLayout.create({height: "30", align: "center", members: [isc.VLayout.create({align: "center", members: [dynamicForm_article10]})]}),
                isc.HLayout.create({ height: "30",align: "left", members: [dynamicForm_fullArticle10] })
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
                pane: VLayout_PageOne_ContractMo
            },
            {
                title: "page2", canClose: false,
                pane: VLayout_PageTwo_ContractMol
            },
            {
                title: "page3", canClose: false,
                pane: VLayout_PageThree_Contract
            }
        ]
    });


var IButton_Contact_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            ListGrid_ContractItemShipment.getAllEditRows().forEach(function (element) {
            if(ListGrid_ContractItemShipment.validateRow(element) != true){
                    ListGrid_ContractItemShipment.validateRow(element);
                    isc.warn("<spring:message code='main.contractShipment'/>");
                    return;
                    }
                 })
            var dataSaveAndUpdateContract={};
            var dataSaveAndUpdateContractDetail={};
            DynamicForm_ContactHeader.validate();
            DynamicForm_ContactCustomer.validate();
            contactHeader.validate();
            DynamicForm_ContactHeader.setValue("contractDate", contactHeader.getValues().createDate.toNormalDate("toUSShortDate"));

                    dataSaveAndUpdateContract.contractDate= contactHeader.getValue("contractDate");
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
                    dataSaveAndUpdateContract.incotermsId=valuesManagerArticle6.getValue("incotermsId");
                    dataSaveAndUpdateContract.portByPortSourceId="";
                    dataSaveAndUpdateContract.incotermsText=valuesManagerArticle6.getValue("incotermsText");
                    dataSaveAndUpdateContract.officeSource="";
                    dataSaveAndUpdateContract.priceCalPeriod="";
                    dataSaveAndUpdateContract.publishTime="";
                    dataSaveAndUpdateContract.reportTitle="";
                    dataSaveAndUpdateContract.delay=valuesManagerArticle8.getValue("delay");
                    dataSaveAndUpdateContract.prepaid="";
                    dataSaveAndUpdateContract.prepaidCurrency="";
                    dataSaveAndUpdateContract.payTime="";
                    dataSaveAndUpdateContract.pricePeriod="";
                    dataSaveAndUpdateContract.eventPayment="";
                    dataSaveAndUpdateContract.contentType="";
                    dataSaveAndUpdateContract.materialId=1;

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
                    dataSaveAndUpdateContractDetail.article3_number17="";
                    dataSaveAndUpdateContractDetail.article3_number17_7="";
                    dataSaveAndUpdateContractDetail.article3_number17_8="";
                    dataSaveAndUpdateContractDetail.article3_number17_9="";
                    dataSaveAndUpdateContractDetail.article3_number17_10="";
                    dataSaveAndUpdateContractDetail.article3_number17_11="";
                    dataSaveAndUpdateContractDetail.article3_number17_12="";
                    dataSaveAndUpdateContractDetail.article3_number17_2="";
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
                    dataSaveAndUpdateContractDetail.article3_number17_13="";
                    dataSaveAndUpdateContractDetail.article3_number17_4="";
                    dataSaveAndUpdateContractDetail.article3_number17_5="";
                    dataSaveAndUpdateContractDetail.article3_number17_6="";
                    dataSaveAndUpdateContractDetail.article4_number18=  "";
                    dataSaveAndUpdateContractDetail.amount_number19_2=  "";
                    dataSaveAndUpdateContractDetail.amount_number19_1=  "";
                    dataSaveAndUpdateContractDetail.shipment_number20=  "";
                    dataSaveAndUpdateContractDetail.article5_number21_6="";
                    dataSaveAndUpdateContractDetail.article6_number31=  "";
                    dataSaveAndUpdateContractDetail.article6_number31_1="";
                    dataSaveAndUpdateContractDetail.article6_number31_1="";
                    dataSaveAndUpdateContractDetail.article6_number32_1="";
                    dataSaveAndUpdateContractDetail.article6_number34="";
                    dataSaveAndUpdateContractDetail.article6_Containerized="";
                    dataSaveAndUpdateContractDetail.article6_Containerized_number36_1="";
                    dataSaveAndUpdateContractDetail.article6_Containerized_number33="";
                    dataSaveAndUpdateContractDetail.article6_Containerized_number37_1="";
                    dataSaveAndUpdateContractDetail.article6_Containerized_number37_2="";
                    dataSaveAndUpdateContractDetail.article6_Containerized_number33_1="";
                    dataSaveAndUpdateContractDetail.article6_Containerized_number37_3="";
                    dataSaveAndUpdateContractDetail.article6_Containerized_number32="";
                    dataSaveAndUpdateContractDetail.article6_Containerized_4="";
                    dataSaveAndUpdateContractDetail.article6_Containerized_5="";
                    dataSaveAndUpdateContractDetail.article7_number41=valuesManagerArticle7.getValue("article7_number41");
                    dataSaveAndUpdateContractDetail.article7_number3="";
                    dataSaveAndUpdateContractDetail.article7_number37="";
                    dataSaveAndUpdateContractDetail.article7_number3_1="";
                    dataSaveAndUpdateContractDetail.article7_number39_1="";
                    dataSaveAndUpdateContractDetail.article7_number40_2="";
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
                    dataSaveAndUpdateContractDetail.article8_3="";
                    dataSaveAndUpdateContractDetail.article8_value="";
                    dataSaveAndUpdateContractDetail.article8_number43="";
                    dataSaveAndUpdateContractDetail.article8_number44_1="";
                    dataSaveAndUpdateContractDetail.article9_number45=valuesManagerArticle9.getValue("article9_number45");
                    dataSaveAndUpdateContractDetail.article9_number22="";
                    dataSaveAndUpdateContractDetail.article9_Englishi_number22="";
                    dataSaveAndUpdateContractDetail.article9_number23="";
                    dataSaveAndUpdateContractDetail.article9_number48="";
                    dataSaveAndUpdateContractDetail.article9_number49_1="";
                    dataSaveAndUpdateContractDetail.article9_number51="";
                    dataSaveAndUpdateContractDetail.article9_number54="";
                    dataSaveAndUpdateContractDetail.article9_number54_1="";
                    dataSaveAndUpdateContractDetail.article9_number55="";
                    dataSaveAndUpdateContractDetail.article9_ImportantNote="";
                    dataSaveAndUpdateContractDetail.article10_number56="";
                    dataSaveAndUpdateContractDetail.article10_number57="";
                    dataSaveAndUpdateContractDetail.article10_number58="";
                    dataSaveAndUpdateContractDetail.article10_number59="";
                    dataSaveAndUpdateContractDetail.article10_number60="";
                    dataSaveAndUpdateContractDetail.article10_number61=valuesManagerArticle10.getValue("article10_number61");
                    dataSaveAndUpdateContract.contractDetails = dataSaveAndUpdateContractDetail;
                    dataSaveAndUpdateContract.contractShipments = saveListGrid_ContractItemShipment();

            var criteriaContractNoMoOx={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName: "materialId", operator: "equals", value: 1},
                                        {fieldName:"contractNo",operator:"equals",value:contactHeader.getValue("contractNo")}]};
            RestDataSource_Contract.fetchData(criteriaContractNoMoOx,function(dsResponse, data, dsRequest) {
            if(data[0]!=undefined){
                isc.warn("<spring:message code='main.contractsDuplicate'/>");
               }else{
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/contract",
                    httpMethod: "POST",
                    data: JSON.stringify(dataSaveAndUpdateContract),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                     Window_ContactMo.close();
                                     ListGrid_contractMo.invalidateCache();
                                     saveValueAllArticlesMoOx((JSON.parse(resp.data)).id);
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                }))}
            })
    }});

var contactFormButtonSaveLayout = isc.HStack.create({
        width: "100%",
        height: "3%",
        align: "center",
        membersMargin: 5,
        layoutMargin: 10,
        showShadow: true,
        members: [
            IButton_Contact_Save,
            isc.IButtonCancel.create({
                title: "<spring:message code='global.cancel'/>",
                width: 100,
                icon: "pieces/16/icon_delete.png",
                orientation: "vertical",
                click: function () {
                    Window_ContactMo.close();
                }
                })
        ]
    });


VLayout_contactMoOxMain=isc.VLayout.create({
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

     Window_ContactMo.addItems([VLayout_contactMoOxMain]);
     Window_ContactMo.show();
}
/////////////////////////// end function()

function saveListGrid_ContractItemShipment() {
        ListGrid_ContractItemShipment.selectAllRecords();
        var dataEditMol = [];
        ListGrid_ContractItemShipment.getAllEditRows().forEach(function (element) {
            dataEditMol.push(ListGrid_ContractItemShipment.getEditedRecord(element));
            if(dataEditMol.length>0){
                try {
                    dataEditMol[dataEditMol.length - 1].sendDate = (dataEditMol[dataEditMol.length - 1].sendDate.getFullYear() + "/" + ("0" + (dataEditMol[dataEditMol.length - 1].sendDate.getMonth() + 1)).slice(-2) + "/" + ("0" + dataEditMol[dataEditMol.length - 1].sendDate.getDate()).slice(-2));
                    }catch (err) {}
            }
            ListGrid_ContractItemShipment.deselectRecord(ListGrid_ContractItemShipment.getRecord(element));
        });
        ListGrid_ContractItemShipment.getSelectedRecords().forEach(function (element) {
            dataEditMol.push(JSON.parse(JSON.stringify(element)));
        });
        ListGrid_ContractItemShipment.deselectAllRecords();
        return dataEditMol;
};



function saveValuelotListForADD(contractID) {
        lotList.selectAllRecords();
        lotList.getAllEditRows().forEach(function (element) {
            var data_lotList = lotList.getEditedRecord(element);
            if(data_lotList.used==true){
                    data_lotList.contractId = contractID;
            }
            if(data_lotList.used==false){
                    data_lotList.contractId =null;
            }
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

    var dataALLArticleMO = {};
    function saveValueAllArticlesMoOx(contractID) {
        dataALLArticleMO.Article01 = nvlMo(dynamicFormMoox_fullArticle01ID.getValue());
        dataALLArticleMO.Article02 = nvlMo(dynamicForm_fullArticle02MoOxID.getValue());
        dataALLArticleMO.Article03 = nvlMo(dynamicForm_fullArticle03ID.getValue());
        dataALLArticleMO.Article04 = nvlMo(dynamicForm_fullArticle04ID.getValue());
        dataALLArticleMO.Article05 = nvlMo(dynamicForm_fullArticle05ID.getValue());
        dataALLArticleMO.Article06 = nvlMo(dynamicForm_fullArticle06ID.getValue());
        dataALLArticleMO.Article07 = nvlMo(dynamicForm_fullArticle07ID.getValue());
        dataALLArticleMO.Article08 = nvlMo(dynamicForm_fullArticle08ID.getValue());
        dataALLArticleMO.Article09 = nvlMo(dynamicForm_fullArticle09ID.getValue());
        dataALLArticleMO.Article10 = nvlMo(dynamicForm_fullArticle10ID.getValue());
        dataALLArticleMO.Article11 = "";
        dataALLArticleMO.Article12 = "";
        dataALLArticleMO.contractNo = "MO_OX"+contactHeader.getValue("contractNo");
        dataALLArticleMO.contractId = contractID;
        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
            actionURL: "${contextPath}/api/contract/writeWord",
            httpMethod: "POST",
            data: JSON.stringify(dataALLArticleMO),
            callback: function (resp) {
                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                    isc.say("<spring:message code='global.form.request.successful'/>.");
                    Window_ContactMo.close();
                } else
                    isc.say(RpcResponse_o.data);
            }
        }))
    }

    function nvlMo(articleIsNotNull){
        if(articleIsNotNull == undefined){
            return "";
        }else{
            return articleIsNotNull;
        }
    }