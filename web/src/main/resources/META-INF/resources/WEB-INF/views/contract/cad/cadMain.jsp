<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    var RestDataSource_Contract = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "contractNo", title: "<spring:message code='contract.contractNo'/>"},
                {name: "contractDate", title: "<spring:message code='contract.contractDate'/>"},
                {name: "contactId", title: "<spring:message code='contact.name'/> "},
                {name: "contact.nameFA", title: "<spring:message code='contact.name'/> "},
                {name: "incotermsId", title: "<spring:message code='incoterms.name'/>"},
                {name: "incoterms.code", title: "<spring:message code='incoterms.name'/>"},
                {name: "amount", title: "<spring:message code='global.amount'/>"},
                {name: "material.descl", title: "materialId"}
            ],
        fetchDataURL: "${contextPath}/api/contract/spec-list"
    });
    var criteriaContractItemShipment;
    var methodHtpp="";
    var recordContractNo;
    var RestDataSource_contractDetail_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contractDetail/spec-list"
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

    var RestDataSource_contractAudit_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contract/audit/spec-list"
    });

    var RestDataSource_contractDetailAudit_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contractDetail/audit/spec-list"
    });

    var RestDataSource_contractShipmentAudit_list = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contractShipment/audit/list"
    });
    var RestDataSource_contractShipmentAudit_Speclist = isc.MyRestDataSource.create({
        fetchDataURL: "${contextPath}/api/contractShipment/audit/spec-list"
    });

    var criteriaCad = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "material.descl", operator: "contains", value: "Cath"}]
    };

    var ViewLoader_createCad = isc.ViewLoader.create({
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
                ViewLoader_createCad
            ]
    });

var Window_ContactCad = isc.Window.create({
        title: "<spring:message code='main.contractsCadTab'/>",
        width: "100%",
        height: "100%",
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        autoScroller: false,
        loadingMessage: "Loading Page..",
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            isc.ViewLoader.create({
                autoDraw: false,
                viewURL: "<spring:url value="/contact/cadPageBase" />",
                loadingMessage: "Loading Page.."
            })
        ]
    });

var ListGrid_Cad = isc.ListGrid.create({
        showFilterEditor: true,
        dataSource: RestDataSource_Contract,
        autoFetchData: true,
        initialCriteria: criteriaCad,
        fields:
            [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {
                    name: "material.descl",showTitle:"false",hidden: true,
                    title: "Material",
                    align: "center",canEdit: false
                },
                {
                    name: "contractNo",
                    title: "<spring:message code='contact.no'/>",
                    align: "center",
                    showTitle:"true",
                    canEdit: false
                },
                {
                    name: "contractDate",
                    title: "<spring:message code='contract.contractDate'/>",
                    align: "center",
                    showTitle:"true",
                    canEdit: false
                },
                {name: "contact.nameFA",showTitle:"true",title: "<spring:message code='contact.name'/>", align: "center"}
            ]
    });

    <sec:authorize access="hasAuthority('C_CONTRACT')">
    var ToolStripButton_ContactCad_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
        methodHtpp="POST";
        Window_ContactCad.show();
        setTimeout(function(){clearAdd()},250)


        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_CONTRACT')">
    var ToolStripButton_ContactCad_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            var textMain;
            var record = ListGrid_Cad.getSelectedRecord();
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
            methodHtpp="PUT";
            criteriaContractItemShipment={_constructor:"AdvancedCriteria"
                                            ,operator:"and",criteria:[{fieldName:"contractId",operator:"equals",value:record.id}]};
            Window_ContactCad.show();
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/contract/readWord",
                httpMethod: "PUT",
                data: (record.contractNo+ "_Cad_"+record.id),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        var text = resp.httpResponseText;
                        var text2 = text.replaceAll('","', '","').replaceAll('&?','":"');
                        textMain= JSON.parse(text2.replaceAt(0,'{"').replaceAt(text2.length-1,'}'));
                        setTimeout(function(){
                                contactCadTabs.selectTab(0);
                                dynamicFormCad_fullArticle01.setValue(nvlCad(textMain.Article01));
                                dynamicForm_fullArticle02Cad.setValue(nvlCad(textMain.Article02));
                                fullArticle3.setValue(nvlCad(textMain.Article03));
                                fullArticle4.setValue(nvlCad(textMain.Article04));
                                article5_quality.setValue(nvlCad(textMain.Article05));
                                fullArticle6.setValue(nvlCad(textMain.Article06));
                                fullArticle7.setValue(nvlCad(textMain.Article07));
                                fullArticle8.setValue(nvlCad(textMain.Article08));
                                fullArticle9.setValue(nvlCad(textMain.Article09));
                                fullArticle10.setValue(nvlCad(textMain.Article10));
                                article11_quality.setValue(nvlCad(textMain.Article11));
                                fullArticle12.setValue(nvlCad(textMain.Article12));
                                ListGrid_ContractItemShipment.fetchData(criteriaContractItemShipment);
                        },350)
                    }else{
                        isc.say(RpcResponse_o.data);
                }
                }
            }))
            var criteria1={_constructor:"AdvancedCriteria",operator:"and",criteria:[{fieldName:"contract.id",operator:"equals",value:record.id}]};
            setTimeout(function(){RestDataSource_contractDetail_list.fetchData(criteria1,function (dsResponse, data, dsRequest) {
                        contactCadHeader.setValue("createDate", record.contractDate)
                        contactCadHeader.setValue("contractNo", record.contractNo)
                        contactCadHeader.setValue("contactId", record.contactId)
                        contactCadHeader.setValue("contactByBuyerAgentId", record.contactByBuyerAgentId)
                        contactCadHeader.setValue("contactBySellerId", record.contactBySellerId)
                        contactCadHeader.setValue("contactBySellerAgentId", record.contactBySellerAgentId)
                        valuesManagerArticle2Cad.setValue("amount", record.amount);
                        valuesManagerArticle2Cad.setValue("amount_en", record.amount_en);
                        valuesManagerArticle2Cad.setValue("unitId", record.unitId);
                        valuesManagerArticle2Cad.setValue("molybdenumTolorance", record.molybdenumTolorance);
                        valuesManagerArticle2Cad.setValue("optional", record.optional);
                        valuesManagerArticle3_quality.setValue("plant", record.plant);
                        valuesManagerArticle4_quality.setValue("article4_quality1",record.mo_amount);
                        valuesManagerArticle4_quality.setValue("article4_quality2",record.copper);
                        valuesManagerArticle6_quality.setValue("incotermsId",record.incotermsId);
                        valuesManagerArticle6_quality.setValue("portByPortSourceId",record.portByPortSourceId);
                        valuesManagerArticle6_quality.setValue("incotermVersion",record.incotermVersion);
                                //*****************
                        contactCadHeaderCadAgent.setValue("name_ContactAgentSeller", data[0].name_ContactAgentSeller)
                        contactCadHeaderCadAgent.setValue("phone_ContactAgentSeller", data[0].phone_ContactAgentSeller)
                        contactCadHeaderCadAgent.setValue("mobile_ContactAgentSeller", data[0].mobile_ContactAgentSeller)
                        contactCadHeaderCadAgent.setValue("address_ContactAgentSeller", data[0].address_ContactAgentSeller)
                        contactCadHeaderCadAgent.setValue("address_ContactSeller", data[0].address_ContactSeller)
                        contactCadHeaderCadAgent.setValue("mobile_ContactSeller", data[0].mobile_ContactSeller)
                        contactCadHeaderCadAgent.setValue("phone_ContactSeller", data[0].phone_ContactSeller)
                        contactCadHeaderCadAgent.setValue("name_ContactSeller", data[0].name_ContactSeller)
                        contactCadHeaderCadAgent.setValue("name_ContactAgentBuyer", data[0].name_ContactAgentBuyer)
                        contactCadHeaderCadAgent.setValue("phone_ContactAgentBuyer", data[0].phone_ContactAgentBuyer)
                        contactCadHeaderCadAgent.setValue("mobile_ContactAgentBuyer", data[0].mobile_ContactAgentBuyer)
                        contactCadHeaderCadAgent.setValue("address_ContactAgentBuyer", data[0].address_ContactAgentBuyer)
                        contactCadHeaderCadAgent.setValue("name_ContactBuyer", data[0].name_ContactBuyer)
                        contactCadHeaderCadAgent.setValue("phone_ContactBuyer", data[0].phone_ContactBuyer)
                        contactCadHeaderCadAgent.setValue("mobile_ContactBuyer", data[0].mobile_ContactBuyer)
                        contactCadHeaderCadAgent.setValue("address_ContactBuyer", data[0].address_ContactBuyer)
                        valuesManagerArticle7_quality.setValue("article7_quality1",data[0].article7_number37);
                        valuesManagerArticle8_quality.setValue("article8_quality1",data[0].article8_number43);
                        valuesManagerArticle8_quality.setValue("article8_quality2",data[0].article8_number44_1);
                        valuesManagerArticle8_quality.setValue("article8_value",data[0].article8_value);
                        valuesManagerArticle10_quality.setValue("article10_number56",data[0].article10_number56);
                        valuesManagerArticle10_quality.setValue("article10_number57",data[0].article10_number57);
                        valuesManagerArticle10_quality.setValue("article10_number58",data[0].article10_number58);
                        valuesManagerArticle10_quality.setValue("article10_number59",data[0].article10_number59);
                        valuesManagerArticle10_quality.setValue("article10_number60",data[0].article10_number60);
                        valuesManagerArticle10_quality.setValue("article10_number61",data[0].article10_number61);


            })},300)
        }
    }});
    </sec:authorize>


function Contract_Cathod_remove() {
        var record = ListGrid_Cad.getSelectedRecord();
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
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.remove.ask'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                buttons: [
                    isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}),
                    isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index == 0) {
                        var ContractIDDelete = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/contract/" + ContractIDDelete,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_Cad.invalidateCache();
                                        deleteFromContractDetail(ContractIDDelete);
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                }
                            })
                        );
                    }
                }
            });
        }
    }

function deleteFromContractDetail(id){
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/contractDetail/deleteByContractId/" + id,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_Cad.invalidateCache();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                }
                            }))
}

function deleteFromContractShipment(id){
    isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/contractDetail/deleteByContractId/" + id,
                                httpMethod: "DELETE",
                                callback: function (resp) {
                                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                        ListGrid_Cad.invalidateCache();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                                }
                            }))
}


    var ToolStripButton_ContactCad_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Cad.invalidateCache(criteriaCad);
        }
    });

    var ToolStripButton_Contract_DraftList_Cad = isc.ToolStripButtonDraft.create({
        title: "<spring:message code='contract.draft'/>",
        click: function () {
             var recordContract = ListGrid_Cad.getSelectedRecord();
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
                   var  criteriaContractAudit_Cad = {
                            _constructor: "AdvancedCriteria",
                            operator: "and",
                            criteria: [{fieldName: "id.id", operator: "equals", value: recordContract.id}]
                        };
                   var ListGrid_ContractDraft_Cad = isc.ListGrid.create({
                                                        width: "100%",
                                                        height: "93%",
                                                        dataSource: RestDataSource_ContractAudit,
                                                        initialCriteria: criteriaContractAudit_Cad,
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
                var windowsCadDraft = isc.Window.create({
                            title: "<spring:message code='global.menu.contract.type.contract.DRAFT'/>" +" FOR CONTRACT NO : "+ ListGrid_Cad.getSelectedRecord().contractNo,
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
                                            ListGrid_ContractDraft_Cad,
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
                                                                var printSelectID = ListGrid_Cad.getSelectedRecord();
                                                                var printSelectIDdraft = ListGrid_ContractDraft_Cad.getSelectedRecord();
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
                                                                    var activeSelectID = ListGrid_Cad.getSelectedRecord();
                                                                    var activeSelectIDdraft = ListGrid_ContractDraft_Cad.getSelectedRecord();
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
                                                                        Window_ContactCad.show();
                                                                        methodHtpp="PUT";
                                                                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                                                            actionURL: "${contextPath}/api/contract/readWord",
                                                                            httpMethod: "PUT",
                                                                            data: (activeSelectID.contractNo + "_Cad_"+(activeSelectIDdraft.id).id+"_"+(activeSelectIDdraft.id).rev),
                                                                            callback: function (resp) {
                                                                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                                                                    contactCadTabs.selectTab(0);
                                                                                    var text = resp.httpResponseText;
                                                                                    var text2 = text.replaceAll('","', '","').replaceAll('&?', '":"')
                                                                                    textMain = JSON.parse(text2.replaceAt(0, '{"').replaceAt(text2.length - 1, '}'));
                                                                                    dynamicFormCad_fullArticle01.setValue(textMain.Article01);
                                                                                    dynamicForm_fullArticle02Cad.setValue(textMain.Article02);
                                                                                    fullArticle3.setValue(textMain.Article03);
                                                                                    fullArticle4.setValue(textMain.Article04);
                                                                                    article5_quality.setValue(textMain.Article05);
                                                                                    fullArticle6.setValue(textMain.Article06);
                                                                                    fullArticle7.setValue(textMain.Article07);
                                                                                    fullArticle8.setValue(textMain.Article08);
                                                                                    fullArticle9.setValue(textMain.Article09);
                                                                                    fullArticle10.setValue(textMain.Article10);
                                                                                    article11_quality.setValue(textMain.Article11);
                                                                                    fullArticle12.setValue(textMain.Article12);
                                                                                    var criteriaContractCadItemShipmentAudit = {
                                                                                            _constructor: "AdvancedCriteria",
                                                                                            operator: "and",
                                                                                            criteria: [{fieldName: "contractId", operator: "equals", value: activeSelectID.id},
                                                                                                       {fieldName: "id.rev", operator: "equals", value: ListGrid_ContractDraft_Cad.getSelectedRecord().id.rev}]
                                                                                            };
                                                                                    RestDataSource_contractShipmentAudit_Speclist.fetchData(criteriaContractCadItemShipmentAudit, function (dsResponse, data, dsRequest) {
                                                                                           ListGrid_ContractItemShipment.setData(data);
                                                                                    })

                                                                                }
                                                                                else {
                                                                                    isc.say(RpcResponse_o.data);
                                                                                }
                                                                            }
                                                                        }))
                                                                        var criteriaContractAudit_Cad = {
                                                                            _constructor: "AdvancedCriteria",
                                                                            operator: "and",
                                                                            criteria: [{fieldName: "id.id", operator: "equals", value: activeSelectID.id},
                                                                                       {fieldName: "id.rev", operator: "equals", value: ListGrid_ContractDraft_Cad.getSelectedRecord().id.rev}]
                                                                        };
                                                                        setTimeout(function () {
                                                                            RestDataSource_contractAudit_list.fetchData(criteriaContractAudit_Cad, function (dsResponse, data, dsRequest) {
                                                                                contactCadHeader.setValue("createDate", data[0].createDate)
                                                                                contactCadHeader.setValue("contractNo", data[0].contractNo)
                                                                                contactCadHeader.setValue("contactId", data[0].contactId)
                                                                                contactCadHeader.setValue("contactByBuyerAgentId", data[0].contactByBuyerAgentId)
                                                                                contactCadHeader.setValue("contactBySellerId", data[0].contactBySellerId)
                                                                                contactCadHeader.setValue("contactBySellerAgentId", data[0].contactBySellerAgentId)
                                                                                valuesManagerArticle2Cad.setValue("amount", data[0].amount);
                                                                                valuesManagerArticle2Cad.setValue("amount_en", data[0].amount_en);
                                                                                valuesManagerArticle2Cad.setValue("unitId", data[0].unitId);
                                                                                valuesManagerArticle2Cad.setValue("molybdenumTolorance", data[0].molybdenumTolorance);
                                                                                valuesManagerArticle2Cad.setValue("optional", data[0].optional);
                                                                                valuesManagerArticle3_quality.setValue("plant", data[0].plant);
                                                                                valuesManagerArticle4_quality.setValue("article4_quality1",data[0].article4_quality1);
                                                                                valuesManagerArticle4_quality.setValue("article4_quality2",data[0].article4_quality2);
                                                                                valuesManagerArticle6_quality.setValue("incotermsId",data[0].incotermsId);
                                                                                valuesManagerArticle6_quality.setValue("portByPortSourceId",data[0].portByPortSourceId);
                                                                                valuesManagerArticle6_quality.setValue("incotermsText",data[0].incotermsText);
                                                                            });
                                                                            var criteriaContractDetailAudit = {
                                                                            _constructor: "AdvancedCriteria",
                                                                            operator: "and",
                                                                            criteria: [{fieldName: "contract_id", operator: "equals", value: activeSelectID.id},
                                                                                       {fieldName: "id.rev", operator: "equals", value: ListGrid_ContractDraft_Cad.getSelectedRecord().id.rev}]
                                                                            };
                                                                            RestDataSource_contractDetailAudit_list.fetchData(criteriaContractDetailAudit, function (dsResponse, data, dsRequest) {
                                                                                contactCadHeaderCadAgent.setValue("name_ContactAgentSeller", data[0].name_ContactAgentSeller)
                                                                                contactCadHeaderCadAgent.setValue("phone_ContactAgentSeller", data[0].phone_ContactAgentSeller)
                                                                                contactCadHeaderCadAgent.setValue("mobile_ContactAgentSeller", data[0].mobile_ContactAgentSeller)
                                                                                contactCadHeaderCadAgent.setValue("address_ContactAgentSeller", data[0].address_ContactAgentSeller)
                                                                                contactCadHeaderCadAgent.setValue("address_ContactSeller", data[0].address_ContactSeller)
                                                                                contactCadHeaderCadAgent.setValue("mobile_ContactSeller", data[0].mobile_ContactSeller)
                                                                                contactCadHeaderCadAgent.setValue("phone_ContactSeller", data[0].phone_ContactSeller)
                                                                                contactCadHeaderCadAgent.setValue("name_ContactSeller", data[0].name_ContactSeller)
                                                                                contactCadHeaderCadAgent.setValue("name_ContactAgentBuyer", data[0].name_ContactAgentBuyer)
                                                                                contactCadHeaderCadAgent.setValue("phone_ContactAgentBuyer", data[0].phone_ContactAgentBuyer)
                                                                                contactCadHeaderCadAgent.setValue("mobile_ContactAgentBuyer", data[0].mobile_ContactAgentBuyer)
                                                                                contactCadHeaderCadAgent.setValue("address_ContactAgentBuyer", data[0].address_ContactAgentBuyer)
                                                                                contactCadHeaderCadAgent.setValue("name_ContactBuyer", data[0].name_ContactBuyer)
                                                                                contactCadHeaderCadAgent.setValue("phone_ContactBuyer", data[0].phone_ContactBuyer)
                                                                                contactCadHeaderCadAgent.setValue("mobile_ContactBuyer", data[0].mobile_ContactBuyer)
                                                                                contactCadHeaderCadAgent.setValue("address_ContactBuyer", data[0].address_ContactBuyer)
                                                                                valuesManagerArticle7_quality.setValue("article7_quality1",data[0].article7_quality1);
                                                                                valuesManagerArticle8_quality.setValue("article8_quality1",data[0].article8_quality1);
                                                                                valuesManagerArticle8_quality.setValue("article8_quality2",data[0].article8_quality2);
                                                                                valuesManagerArticle10_quality.setValue("article10_number56",data[0].article10_number56);
                                                                                valuesManagerArticle10_quality.setValue("article10_number57",data[0].article10_number57);
                                                                                valuesManagerArticle10_quality.setValue("article10_number58",data[0].article10_number58);
                                                                                valuesManagerArticle10_quality.setValue("article10_number59",data[0].article10_number59);
                                                                                valuesManagerArticle10_quality.setValue("article10_number60",data[0].article10_number60);
                                                                                valuesManagerArticle10_quality.setValue("article10_number61",data[0].article10_number61);
                                                                            })
                                                                        windowsCadDraft.close();
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

    var ToolStripButton_Contract_PrintCad = isc.ToolStripButtonPrint.create({
                                icon: "[SKIN]/actions/print.png",
                                showIf: "true",
                                title: "<spring:message code='global.form.print'/>",
                                click: function () {
                                    var printSelectCadID = ListGrid_Cad.getSelectedRecord();
                                    if (printSelectCadID == null || printSelectCadID.id == null) {
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
                                        var recordCadIdPrint = ListGrid_Cad.getSelectedRecord();
                                        window.open('${printUrl}' + "/" + recordCadIdPrint.id);
                                    }
                                }
                            })

     <sec:authorize access="hasAuthority('D_CONTRACT')">
        var ToolStripButton_ContractCad_Remove = isc.ToolStripButtonRemove.create({
            align: "left",
            border: '0px',
            icon: "[SKIN]/actions/remove.png",
            title: "<spring:message code='global.form.remove'/>",
            click: function () {
                ListGrid_ContractCad_remove();
            }
        });
     </sec:authorize>

    var ToolStrip_Actions_ContactCad = isc.ToolStrip.create({
            membersMargin: 5,
            members: [

                <sec:authorize access="hasAuthority('C_CONTRACT')">
                ToolStripButton_ContactCad_Add,
                </sec:authorize>



                <sec:authorize access="hasAuthority('U_CONTRACT')">
                ToolStripButton_ContactCad_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_CONTRACT')">
                ToolStripButton_ContractCad_Remove,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_CONTRACT')">
                ToolStripButton_Contract_PrintCad,
                </sec:authorize>

                isc.ToolStrip.create({
                    align: "left",
                    border: '0px',
                    members: [
                    ToolStripButton_Contract_DraftList_Cad
                    ]
                }),

                isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_ContactCad_Refresh,
                ]
                })

            ]
        });

isc.VStack.create({
        ID: "VLayout_ContractCad",
        width: "100%",
        height: "100%",
        members: [
            isc.HLayout.create({height: "4%",members: [ToolStrip_Actions_ContactCad]}),
            isc.HLayout.create({height: "96%",members: [ListGrid_Cad]})
        ]
    });

function clearAdd(){
        contactCadTabs.selectTab(0);
        contactCadHeader.clearValues();
        contactCadHeaderCadAgent.clearValues();
        valuesManagerCadArticle1.clearValues();
        valuesManagerArticle2Cad.clearValues();
        valuesManagerArticle3_quality.clearValues();
        valuesManagerArticle4_quality.clearValues();
        valuesManagerArticle6_quality.clearValues();
        valuesManagerArticle7_quality.clearValues();
        valuesManagerArticle8_quality.clearValues();
        valuesManagerArticle9_quality.clearValues();
        valuesManagerArticle10_quality.clearValues();
        valuesManagerArticle12_quality.clearValues();
        dynamicFormCad_fullArticle01.setValue("");
        dynamicForm_fullArticle02Cad.setValue("");
        fullArticle3.setValue("");
        fullArticle4.setValue("");
        article5_quality.setValue("");
        fullArticle6.setValue("");
        fullArticle7.setValue("");
        fullArticle8.setValue("");
        fullArticle9.setValue("");
        fullArticle10.setValue("");
        article11_quality.setValue("");
        fullArticle12.setValue("");
        ListGrid_ContractItemShipment.setData([]);

}


function ListGrid_ContractCad_remove() {
        var recordCad = ListGrid_Cad.getSelectedRecord();
        if (recordCad == null || recordCad.id == null) {
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
                            actionURL: "${contextPath}/api/contract/" + recordCad.id,
                            httpMethod: "DELETE",
                            callback: function (resp) {
                                if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                    ListGrid_Cad.invalidateCache();
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            }
                        }))
                    }
                }
            });
        }
    }

    function nvlCad(articleIsNotNull){
        if(articleIsNotNull == undefined){
            return "";
        }else{
            return articleIsNotNull;
        }
    }