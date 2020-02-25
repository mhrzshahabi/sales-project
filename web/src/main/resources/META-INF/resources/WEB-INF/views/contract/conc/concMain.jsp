<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>e
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    var criteriaContractConcItemShipment;
    var flagEdit = 0;



    var RestDataSource_contractDetail_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contractDetail/spec-list"
    });

    var RestDataSource_contractDetailAudit_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contractDetail/audit/spec-list"
    });

    var RestDataSource_contractAudit_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contract/audit/spec-list"
    });


    var RestDataSource_Material = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
                {name: "descl"},
                {name: "unitId"},
                {name: "unit.nameEN"},
            ],
        fetchDataURL: "${contextPath}/api/material/spec-list"
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

    function ValuesManager(valueId) {
        isc.ValuesManager.create({
            ID: valueId
        })
    }

    ValuesManager("contactHeaderConc");
    ValuesManager("contactHeaderConcAgent");
    ValuesManager("valuesManagerConcArticle1");
    ValuesManager("valuesManagerArticle2Conc");
    ValuesManager("valuesManagerArticle3_conc");
    ValuesManager("valuesManagerArticle12_quality");
    ValuesManager("valuesManagerArticle10_quality");
    ValuesManager("valuesManagerfullArticle");
    ValuesManager("valuesManagerArticle9_conc");
    ValuesManager("valuesManagerArticle5_DeliveryTermsConc");


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

    var RestDataSource_Parameters = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "paramName", title: "<spring:message code='parameters.paramName'/>", width: 200},
                //  {name: "paramType", title: "<spring:message code='parameters.paramType'/>", width: 200},
                {name: "paramValue", title: "<spring:message code='parameters.paramValue'/>", width: 200},
                {name: "contractId", title: "<spring:message code='parameters.paramValue'/>", width: 200},
                {name: "categoryValue", title: "<spring:message code='parameters.paramValue'/>", width: 200}
            ],
        fetchDataURL: "${contextPath}/api/parameters/spec-list"
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

    var criteriaConc = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "material.descl", operator: "contains", value: "Con"}]
    };

    var ViewLoader_createConc = isc.ViewLoader.create({
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
                ViewLoader_createConc
            ]
    });

    var Window_ContactConc = isc.Window.create({
        title: "<spring:message code='main.contractsConcTab'/>",
        width: "100%",
        height: "100%",
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        autoScroller: false,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            isc.ViewLoader.create({
                autoDraw: true,
                viewURL: "<spring:url value="/contact/concPageBase" />",
                loadingMessage: "Loading Page.."
            })
        ]
    });

    var ListGrid_Conc = isc.ListGrid.create({
        dataSource: RestDataSource_Contract,
        initialCriteria: criteriaConc,
        autoFetchData: true,
        fields:
            [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "material.descl", showTitle: "false",
                    title: "Type material",
                    align: "center", hidden: true
                },
                {
                    name: "contractNo",
                    showTitle: "true",
                    title: "<spring:message code='contact.no'/>",
                    align: "center",
                    canEdit: false
                },
                {
                    name: "contractDate",
                    title: "<spring:message code='contract.contractDate'/>",
                    showTitle: "true",
                    align: "center",
                    type: "datetime",
                    canEdit: false
                },
                {
                    name: "contact.nameFA",
                    showTitle: "true",
                    title: "<spring:message code='contact.name'/>",
                    align: "center"
                }
            ]
    });

    <sec:authorize access="hasAuthority('C_CONTRACT')">
    var ToolStripButton_ContactConc_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            methodHtpp="POST";
            Window_ContactConc.show();
            setTimeout(function () {
                clearAdd()
            }, 300)
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_CONTRACT')">
    var ToolStripButton_ContactConc_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            var textMain;
            var record = ListGrid_Conc.getSelectedRecord();
            if (record == null || record.id == null) {
                isc.Dialog.create({
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function () {
                        this.hide();
                    }
                });
            } else {
                methodHtpp="PUT";
                criteriaContractConcItemShipment = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "contractId", operator: "equals", value: record.id}]
                };
                Window_ContactConc.show();
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/contract/readWord",
                    httpMethod: "PUT",
                    data: (record.contractNo + "_Conc_"+record.id),
                    callback: function (resp) {
                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                            contactConcTabs.selectTab(0);
                            var text = resp.httpResponseText;
                            var text2 = text.replaceAll('","', '","').replaceAll('&?', '":"')
                            textMain = JSON.parse(text2.replaceAt(0, '{"').replaceAt(text2.length - 1, '}'));
                            dynamicForm_fullArticle01.setValue(textMain.Article01)
                            dynamicForm_fullArticle02.setValue(textMain.Article02)
                            dynamicForm_fullArticleConc03.setValue(textMain.Article03)
                            dynamicForm_fullArticleConc04.setValue(textMain.Article04)
                            dynamicForm_fullArticleConc05.setValue(textMain.Article05)
                            dynamicForm_fullArticleConc06.setValue(textMain.Article06)
                            dynamicForm_fullArticleConc07.setValue(textMain.Article07)
                            dynamicForm_fullArticleConc08.setValue(textMain.Article08)
                            dynamicForm_fullArticleConc09.setValue(textMain.Article09)
                            dynamicForm_fullArticleConc10.setValue(textMain.Article10)
                            dynamicForm_fullArticleConc11.setValue(textMain.Article11)
                            dynamicForm_fullArticleConc12.setValue(textMain.Article12)
                            ListGrid_ContractConcItemShipment.fetchData(criteriaContractConcItemShipment)
                        }
                        else {
                            isc.say(RpcResponse_o.data);
                        }
                    }
                }))
                var criteriaConc1 = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [{fieldName: "contract_id", operator: "equals", value: record.id}]
                };
                setTimeout(function () {
                    RestDataSource_contractDetail_list.fetchData(criteriaConc1, function (dsResponse, data, dsRequest) {
                        contactHeaderConc.setValue("createDate", record.contractDate)
                        contactHeaderConc.setValue("contractNo", record.contractNo)
                        contactHeaderConc.setValue("contactId", record.contactId)
                        dynamicFormConc.setValue("materialId", record.materialId)
                        contactHeaderConc.setValue("contactByBuyerAgentId", record.contactByBuyerAgentId) //***** to do
                        contactHeaderConc.setValue("contactBySellerId", record.contactBySellerId)
                        contactHeaderConc.setValue("contactBySellerAgentId", record.contactBySellerAgentId)
                        valuesManagerArticle2Conc.setValue("amount", record.amount);
                        valuesManagerArticle2Conc.setValue("amount_en", record.amount_en);
                        valuesManagerArticle2Conc.setValue("unitId", record.unitId);
                        valuesManagerArticle2Conc.setValue("cathodesTolorance", record.molybdenumTolorance);
                        valuesManagerArticle2Conc.setValue("optional", record.optional);
                        valuesManagerArticle2Conc.setValue("plant", record.plant);
                        valuesManagerArticle3_conc.setValue("CU", record.copper);
                        valuesManagerArticle3_conc.setValue("MO", record.molybdenum);
                        valuesManagerArticle3_conc.setValue("unitCu", record.timeIssuance);
                        valuesManagerArticle3_conc.setValue("unitMo", record.prefixPayment);
                        valuesManagerArticle9_conc.setValue("TC", record.treatCost);
                        valuesManagerArticle9_conc.setValue("RC", record.refinaryCost);
                        article5_ConcDeliveryTerms.setValue("incotermsId", record.incotermsId);
                        article5_ConcDeliveryTerms.setValue("portByPortSourceId", record.portByPortSourceId);
                        article5_ConcDeliveryTerms.setValue("incotermsText", record.incotermsText);
                        contactHeaderConcAgent.setValue("name_ContactAgentSeller", data[0].name_ContactAgentSeller)
                        contactHeaderConcAgent.setValue("phone_ContactAgentSeller", data[0].phone_ContactAgentSeller)
                        contactHeaderConcAgent.setValue("mobile_ContactAgentSeller", data[0].mobile_ContactAgentSeller)
                        contactHeaderConcAgent.setValue("address_ContactAgentSeller", data[0].address_ContactAgentSeller)
                        contactHeaderConcAgent.setValue("address_ContactSeller", data[0].address_ContactSeller)
                        contactHeaderConcAgent.setValue("mobile_ContactSeller", data[0].mobile_ContactSeller)
                        contactHeaderConcAgent.setValue("phone_ContactSeller", data[0].phone_ContactSeller)
                        contactHeaderConcAgent.setValue("name_ContactSeller", data[0].name_ContactSeller)
                        contactHeaderConcAgent.setValue("name_ContactAgentBuyer", data[0].name_ContactAgentBuyer)
                        contactHeaderConcAgent.setValue("phone_ContactAgentBuyer", data[0].phone_ContactAgentBuyer)
                        contactHeaderConcAgent.setValue("mobile_ContactAgentBuyer", data[0].mobile_ContactAgentBuyer)
                        contactHeaderConcAgent.setValue("address_ContactAgentBuyer", data[0].address_ContactAgentBuyer)
                        contactHeaderConcAgent.setValue("name_ContactBuyer", data[0].name_ContactBuyer)
                        contactHeaderConcAgent.setValue("phone_ContactBuyer", data[0].phone_ContactBuyer)
                        contactHeaderConcAgent.setValue("mobile_ContactBuyer", data[0].mobile_ContactBuyer)
                        contactHeaderConcAgent.setValue("address_ContactBuyer", data[0].address_ContactBuyer)
                        valuesManagerArticle12_quality.setValue("article12_number56", data[0].article10_number56)
                        valuesManagerArticle12_quality.setValue("article12_number57", data[0].article10_number57)
                        valuesManagerArticle12_quality.setValue("article12_number58", data[0].article10_number58)
                        valuesManagerArticle12_quality.setValue("article12_number59", data[0].article10_number59)
                        valuesManagerArticle12_quality.setValue("article12_number60", data[0].article10_number60)
                        valuesManagerArticle12_quality.setValue("article12_number61", data[0].article10_number61)
                        valuesManagerArticle10_quality.setValue("article10_quality1", data[0].article9_ImportantNote)
                    })
                }, 300)
            }
        }
    });
    </sec:authorize>


    var ToolStripButton_ContactConc_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Conc.invalidateCache(criteriaConc);
        }
    });

    var ToolStripButton_Contract_DraftList = isc.ToolStripButtonDraft.create({
        title: "Draft",
        click: function () {
             var recordContract = ListGrid_Conc.getSelectedRecord();
                 if (recordContract == null || recordContract.id == null) {
                                    isc.Dialog.create({
                                        message: "<spring:message code='global.grid.record.not.selected'/>",
                                        icon: "[SKIN]ask.png",
                                        title: "<spring:message code='global.message'/>",
                                        buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                        buttonClick: function () {
                                            this.hide();
                                        }});
                 } else {
                   var  criteriaContractAudit = {
                            _constructor: "AdvancedCriteria",
                            operator: "and",
                            criteria: [{fieldName: "id.id", operator: "equals", value: recordContract.id}]
                        };
                   var ListGrid_ContractDraft = isc.ListGrid.create({
                                                        width: "100%",
                                                        height: "93%",
                                                        dataSource: RestDataSource_ContractAudit,
                                                        initialCriteria: criteriaContractAudit,
                                                        showFilterEditor: true,
                                                        autoFetchData: true,
                                                        fields:
                                                            [
                                                                {name: "id.id",hidden: true},
                                                                {name: "id.rev",hidden: true},
                                                                {name: "revType",width: "10%",valueMap:{"0": "create","1": "update","2": "delete" }},
                                                                {name: "contractDate",width: "10%",format: "MMMM yyyy",type:"date"},
                                                                {name: "createdBy",width: "10%", title: "createdBy"},
                                                                {name: "createdDate",width: "10%", title: "createdDate"},
                                                                {name: "lastModifiedBy",width: "10%", title: "lastModifiedBy"},
                                                                {name: "lastModifiedDate",width: "10%", title: "lastModifiedDate"}
                                                            ]
                                                    })
                var windowsConcDraft = isc.Window.create({
                            title: "<spring:message code='global.menu.contract.type.contract.DRAFT'/>" +" FOR CONTRACT NO : "+ ListGrid_Conc.getSelectedRecord().contractNo,
                            width: "50%",
                            height: "52%",
                            autoCenter: true,
                            isModal: true,
                            showModalMask: true,
                            align: "center",
                            autoDraw: true,
                            closeClick: function () {
                                this.Super("closeClick", arguments)
                            },
                            items: [
                                 isc.VStack.create({
                                    autoCenter: true,
                                    members: [
                                            ListGrid_ContractDraft,
                                            isc.HStack.create({
                                                backgroundColor: "#fe9d2a",
                                                width: "100%",
                                                height: "7%",
                                                autoCenter: true,
                                                members: [
                                                        isc.Label.create({
                                                                    width: "47%",
                                                            }),
                                                        isc.ToolStripButtonPrint.create({
                                                            icon: "[SKIN]/actions/print.png",
                                                            margin:"5",
                                                            title: "<spring:message code='global.form.print'/>",
                                                            autoCenter: true,
                                                            click: function () {
                                                                var printSelectID = ListGrid_Conc.getSelectedRecord();
                                                                var printSelectIDdraft = ListGrid_ContractDraft.getSelectedRecord();
                                                                if (printSelectIDdraft == null || printSelectIDdraft.id == null) {
                                                                    isc.Dialog.create({
                                                                        message: "<spring:message code='global.grid.record.not.selected'/>",
                                                                        icon: "[SKIN]ask.png",
                                                                        title: "<spring:message code='global.message'/>",
                                                                        buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                                                        buttonClick: function () {
                                                                            this.hide();
                                                                        }
                                                                    });
                                                                }
                                                                else {
                                                                    "<spring:url value="/contract/print" var="printUrl"/>";
                                                                    var recordIdPrint = ListGrid_Contract.getSelectedRecord();
                                                                    window.open('${printUrl}' + "/" + printSelectID.id+ "/" +((printSelectIDdraft.id).rev));
                                                                }
                                                            }
                                                        }),
                                                        isc.ToolStripButtonPrint.create({
                                                            icon: "[SKIN]/actions/active.png",
                                                            margin:"5",
                                                            title: "Active",
                                                            autoCenter: true,
                                                            click: function () {
                                                                    var activeSelectID = ListGrid_Conc.getSelectedRecord();
                                                                    var activeSelectIDdraft = ListGrid_ContractDraft.getSelectedRecord();
                                                                    if (activeSelectID == null || activeSelectIDdraft == null) {
                                                                    isc.Dialog.create({
                                                                        message: "<spring:message code='global.grid.record.not.selected'/>",
                                                                        icon: "[SKIN]ask.png",
                                                                        title: "<spring:message code='global.message'/>",
                                                                        buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                                                        buttonClick: function () {
                                                                            this.hide();
                                                                        }
                                                                    })
                                                                } else {
                                                                        Window_ContactConc.show();
                                                                        methodHtpp="PUT";
                                                                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                                                            actionURL: "${contextPath}/api/contract/readWord",
                                                                            httpMethod: "PUT",
                                                                            data: (activeSelectID.contractNo + "_Conc_"+(activeSelectIDdraft.id).id+"_"+(activeSelectIDdraft.id).rev),
                                                                            callback: function (resp) {
                                                                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                                                                    contactConcTabs.selectTab(0);
                                                                                    var text = resp.httpResponseText;
                                                                                    var text2 = text.replaceAll('","', '","').replaceAll('&?', '":"')
                                                                                    textMain = JSON.parse(text2.replaceAt(0, '{"').replaceAt(text2.length - 1, '}'));
                                                                                    dynamicForm_fullArticle01.setValue(textMain.Article01)
                                                                                    dynamicForm_fullArticle02.setValue(textMain.Article02)
                                                                                    dynamicForm_fullArticleConc03.setValue(textMain.Article03)
                                                                                    dynamicForm_fullArticleConc04.setValue(textMain.Article04)
                                                                                    dynamicForm_fullArticleConc05.setValue(textMain.Article05)
                                                                                    dynamicForm_fullArticleConc06.setValue(textMain.Article06)
                                                                                    dynamicForm_fullArticleConc07.setValue(textMain.Article07)
                                                                                    dynamicForm_fullArticleConc08.setValue(textMain.Article08)
                                                                                    dynamicForm_fullArticleConc09.setValue(textMain.Article09)
                                                                                    dynamicForm_fullArticleConc10.setValue(textMain.Article10)
                                                                                    dynamicForm_fullArticleConc11.setValue(textMain.Article11)
                                                                                    dynamicForm_fullArticleConc12.setValue(textMain.Article12)
                                                                                    ListGrid_ContractConcItemShipment.fetchData(criteriaContractConcItemShipment)
                                                                                }
                                                                                else {
                                                                                    isc.say(RpcResponse_o.data);
                                                                                }
                                                                            }
                                                                        }))
                                                                        var criteriaContractAudit = {
                                                                            _constructor: "AdvancedCriteria",
                                                                            operator: "and",
                                                                            criteria: [{fieldName: "id.id", operator: "equals", value: activeSelectID.id},
                                                                                       {fieldName: "id.rev", operator: "equals", value: ListGrid_ContractDraft.getSelectedRecord().id.rev}]
                                                                        };
                                                                        setTimeout(function () {
                                                                            RestDataSource_contractAudit_list.fetchData(criteriaContractAudit, function (dsResponse, data, dsRequest) {
                                                                                contactHeaderConc.setValue("createDate", data[0].contractDate)
                                                                                contactHeaderConc.setValue("contractNo", data[0].contractNo)
                                                                                contactHeaderConc.setValue("contactId", data[0].contactId)
                                                                                dynamicFormConc.setValue("materialId", data[0].materialId)
                                                                                contactHeaderConc.setValue("contactByBuyerAgentId", data[0].contactByBuyerAgentId) //***** to do
                                                                                contactHeaderConc.setValue("contactBySellerId", data[0].contactBySellerId)
                                                                                contactHeaderConc.setValue("contactBySellerAgentId", data[0].contactBySellerAgentId)
                                                                                valuesManagerArticle2Conc.setValue("amount", data[0].amount);
                                                                                valuesManagerArticle2Conc.setValue("amount_en", data[0].amount_en);
                                                                                valuesManagerArticle2Conc.setValue("unitId", data[0].unitId);
                                                                                valuesManagerArticle2Conc.setValue("cathodesTolorance", data[0].molybdenumTolorance);
                                                                                valuesManagerArticle2Conc.setValue("optional", data[0].optional);
                                                                                valuesManagerArticle2Conc.setValue("plant", data[0].plant);
                                                                                valuesManagerArticle3_conc.setValue("CU", data[0].copper);
                                                                                valuesManagerArticle3_conc.setValue("MO", data[0].molybdenum);
                                                                                valuesManagerArticle3_conc.setValue("unitCu", data[0].timeIssuance);
                                                                                valuesManagerArticle3_conc.setValue("unitMo", data[0].prefixPayment);
                                                                                valuesManagerArticle9_conc.setValue("TC", data[0].treatCost);
                                                                                valuesManagerArticle9_conc.setValue("RC", data[0].refinaryCost);
                                                                                article5_ConcDeliveryTerms.setValue("incotermsId", data[0].incotermsId);
                                                                                article5_ConcDeliveryTerms.setValue("portByPortSourceId", data[0].portByPortSourceId);
                                                                                article5_ConcDeliveryTerms.setValue("incotermsText", data[0].incotermsText);
                                                                            });
                                                                            var criteriaContractDetailAudit = {
                                                                            _constructor: "AdvancedCriteria",
                                                                            operator: "and",
                                                                            criteria: [{fieldName: "contract_id", operator: "equals", value: activeSelectID.id},
                                                                                       {fieldName: "id.rev", operator: "equals", value: ListGrid_ContractDraft.getSelectedRecord().id.rev+1}]
                                                                            };
                                                                            RestDataSource_contractDetailAudit_list.fetchData(criteriaContractDetailAudit, function (dsResponse, data, dsRequest) {
                                                                                contactHeaderConcAgent.setValue("name_ContactAgentSeller", data[0].name_ContactAgentSeller)
                                                                                contactHeaderConcAgent.setValue("phone_ContactAgentSeller", data[0].phone_ContactAgentSeller)
                                                                                contactHeaderConcAgent.setValue("mobile_ContactAgentSeller", data[0].mobile_ContactAgentSeller)
                                                                                contactHeaderConcAgent.setValue("address_ContactAgentSeller", data[0].address_ContactAgentSeller)
                                                                                contactHeaderConcAgent.setValue("address_ContactSeller", data[0].address_ContactSeller)
                                                                                contactHeaderConcAgent.setValue("mobile_ContactSeller", data[0].mobile_ContactSeller)
                                                                                contactHeaderConcAgent.setValue("phone_ContactSeller", data[0].phone_ContactSeller)
                                                                                contactHeaderConcAgent.setValue("name_ContactSeller", data[0].name_ContactSeller)
                                                                                contactHeaderConcAgent.setValue("name_ContactAgentBuyer", data[0].name_ContactAgentBuyer)
                                                                                contactHeaderConcAgent.setValue("phone_ContactAgentBuyer", data[0].phone_ContactAgentBuyer)
                                                                                contactHeaderConcAgent.setValue("mobile_ContactAgentBuyer", data[0].mobile_ContactAgentBuyer)
                                                                                contactHeaderConcAgent.setValue("address_ContactAgentBuyer", data[0].address_ContactAgentBuyer)
                                                                                contactHeaderConcAgent.setValue("name_ContactBuyer", data[0].name_ContactBuyer)
                                                                                contactHeaderConcAgent.setValue("phone_ContactBuyer", data[0].phone_ContactBuyer)
                                                                                contactHeaderConcAgent.setValue("mobile_ContactBuyer", data[0].mobile_ContactBuyer)
                                                                                contactHeaderConcAgent.setValue("address_ContactBuyer", data[0].address_ContactBuyer)
                                                                                valuesManagerArticle12_quality.setValue("article12_number56", data[0].article10_number56)
                                                                                valuesManagerArticle12_quality.setValue("article12_number57", data[0].article10_number57)
                                                                                valuesManagerArticle12_quality.setValue("article12_number58", data[0].article10_number58)
                                                                                valuesManagerArticle12_quality.setValue("article12_number59", data[0].article10_number59)
                                                                                valuesManagerArticle12_quality.setValue("article12_number60", data[0].article10_number60)
                                                                                valuesManagerArticle12_quality.setValue("article12_number61", data[0].article10_number61)
                                                                                valuesManagerArticle10_quality.setValue("article10_quality1", data[0].article9_ImportantNote)
                                                                            })
                                                                        windowsConcDraft.close();
                                                                        }, 300)
                                                                        }
                                                                        }
                                                        })
                                                ]
                                            })
                                            ]
                                })
                            ]
                        })
             }
        }
    });

    var ToolStrip_Actions_ContactConc = isc.ToolStrip.create({
        membersMargin: 5,
        members: [
            <sec:authorize access="hasAuthority('C_CONTRACT')">
            ToolStripButton_ContactConc_Add,
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_CONTRACT')">
            ToolStripButton_ContactConc_Edit,
            </sec:authorize>

                 isc.ToolStrip.create({
                    align: "left",
                    border: '0px',
                    members: [
                    ToolStripButton_Contract_DraftList
                    ]
                }),

                isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_ContactConc_Refresh,
                ]
            })

        ]
    });



    isc.VStack.create({
        ID: "VLayout_ContractConc",
        width: "100%",
        height: "100%",
        members: [
            isc.HLayout.create({height: "4%", members: [ToolStrip_Actions_ContactConc]}),
            isc.HLayout.create({height: "96%", members: [ListGrid_Conc]})
        ]
    });

