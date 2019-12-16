<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

     var criteriaOther = {
        _constructor: "AdvancedCriteria",
        operator: "or",
        criteria: [{fieldName: "materialId", operator: "equals", value: 6952},{fieldName: "materialId", operator: "equals", value: -42}]
    };

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
                {name: "sideContractDate", ID: "sideContractDate"},
                {name: "refinaryCost", ID: "refinaryCost"},
                {name: "treatCost", ID: "treatCost"},
                {name: "material.descl", title: "materialId"}
            ],
        // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/contract/spec-list"
    });

    var RestDataSource_Contact = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/> "},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/> "},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/> "}
            ],
        // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });

    var RestDataSource_Incoterms = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
            ],
        // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/incoterms/spec-list"
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
        // ######@@@@###&&@@###
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
        // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/unit/spec-list"
    });

    var ToolStripButton_Contract_Refresh = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ContractOther_refresh();
        }
    });

    var ToolStripButton_Contract_Add = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_ContractOther.clearValues();
            windowOther.animateShow();
        }
    });

    var ToolStripButton_Contract_Edit = isc.ToolStripButton.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ContractOther_edit();
        }
    });


var ToolStrip_Actions_ContractOther = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                ToolStripButton_Contract_Refresh,
                ToolStripButton_Contract_Add,
                ToolStripButton_Contract_Edit
            ]
    });

var ListGrid_ContractOther = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Contract,
        initialCriteria: criteriaOther,
        fields:
            [
                {name: "id", hidden: true,},
                {
                    name: "addendum",
                    title: "<spring:message code='contract.addendum'/>",
                    type: 'text',
                    required: true,
                    width: "5%",
                    align: "center"
                },
                {
                    name: "contractNo",
                    title: "<spring:message code='contract.contractNo'/>",
                    type: 'text',
                    width: "7%",
                    align: "center"
                },
                {
                    name: "contractDate",
                    title: "<spring:message code='contract.contractDate'/>",
                    type: 'text',
                    width: "7%",
                    align: "center"
                },
                {
                    name: "contact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    type: 'long',
                    width: "12%",
                    align: "center"
                },
                {
                    name: "incoterms.code",
                    title: "<spring:message code='incoterms.name'/>",
                    type: 'long',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "amount",
                    title: "<spring:message code='contract.amount'/>",
                    type: 'text',
                    width: "7%",
                    align: "center"
                },
                {
                    name: "prepaid",
                    title: "<spring:message code='contract.prepaid'/>",
                    type: 'integer',
                    required: true,
                    width: "100"
                }
            ],
        sortField: 0,
        dataPageSize: 50,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
        sortFieldAscendingText: "مرتب سازی صعودی",
        sortFieldDescendingText: "مرتب سازی نزولی",
        configureSortText: "تنظیم مرتب سازی",
        autoFitAllText: "متناسب سازی ستون ها براساس محتوا",
        autoFitFieldText: "متناسب سازی ستون بر اساس محتوا",
        filterUsingText: "فیلتر کردن",
        groupByText: "گروه بندی",
        freezeFieldText: "ثابت نگه داشتن",
        startsWithTitle: "tt",
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "contractId", operator: "equals", value: record.id}]
            };
            ListGrid_ContractShipment.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_ContractShipment.setData(data);
            });
        },
        dataArrived: function (startRow, endRow) {
        }

    });

var DynamicForm_ContractOther = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        wrapTitle: false,
        requiredMessage: "<spring:message code='validator.field.is.required'/>.",
        numCols: 4,
        backgroundImage: "backgrounds/leaves.jpg",
        titleWidth: "120",
        titleAlign: "right",
        fields:
            [
                {name: "id", hidden: true,},
                {type: "Header", defaultValue: ""},
                {
                    name: "contractNo",
                    colSpan: 1,
                    titleColSpan: 1,
                    tabIndex: 1,
                    showHover: true,
                    title: "<spring:message code='contract.contractNo'/>",
                    type: 'text',
                    required: true,
                    width: "100%"
                },
                {
                    name: "contractDateDumy",
                    colSpan: 1,
                    titleColSpan: 1,
                    tabIndex: 2,
                    showHover: true,
                    title: "<spring:message code='contract.contractDate'/>",
                    type: 'date',
                    width: "100%"
                },
                {
                    name: "contactId",
                    colSpan: 3,
                    titleColSpan: 1,
                    tabIndex: 3,
                    showHover: true,
                    title: "<spring:message code='contact.name'/>",
                    type: 'long',
                    width: "100%",
                    required: true,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Contact,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", width: "50%", align: "center"},
                        {name: "nameEN", width: "50%", align: "center"},
                        {name: "code", width: "10%", align: "center"}
                    ]
                },
                {
                    name: "sideContractNo",
                    colSpan: 1,
                    titleColSpan: 1,
                    tabIndex: 4,
                    showHover: true,
                    title: "<spring:message code='contract.sideContractNo'/>",
                    type: 'text',
                    required: false,
                    width: "100%"
                },
                {
                    name: "sideContractDateDumy",
                    colSpan: 1,
                    titleColSpan: 1,
                    tabIndex: 5,
                    showHover: true,
                    title: "<spring:message code='contract.sideContractDate'/>",
                    type: 'date',
                    required: false,
                    width: "100%"
                },
                {
                    type: "Header",
                    defaultValue: "------------------<spring:message code="contractItem.material"/>----------------------------------------------------------------"
                },
                {
                    name: "incotermsId",
                    colSpan: 3,
                    titleColSpan: 1,
                    tabIndex: 6,
                    showHover: true,
                    title: "<spring:message code='incoterms.name'/>",
                    type: 'long',
                    width: "100%", numCols: 4,
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
                },
                {
                    type: "Header",
                    defaultValue: "------------------<spring:message code="contract.incoterms"/>--------------------------------------------------------------"
                },
                {
                    name: "materialId",
                    colSpan: 3,
                    titleColSpan: 1,
                    tabIndex: 7,
                    showHover: true,
                    title: "<spring:message code='contractItem.material'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Material,
                    displayField: "descl",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "descl", width: 440, align: "center"}
                    ],
                    pickListCriteria: {
                        _constructor: 'AdvancedCriteria', operator: "or", criteria: [
                            {fieldName: "id", operator: "equals", value:6952},
                            {fieldName: "id", operator: "equals", value:-42}
                            ]
                          }
                },
                {
                    name: "amount",
                    title: "<spring:message code='contract.amount'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "unitId",
                    title: "<spring:message code='unit.nameEN'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Unit,
                    displayField: "code",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameEN", width: 440, align: "center"}
                    ]
                },
                {
                    type: "Header",
                    defaultValue: "------------------<spring:message code="MaterialFeature.parameter"/>--------------------------------------------------------------"
                },
                {
                    name: "copper",
                    title: "<spring:message code='contract.copper'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    hidden: true
                },
                {
                    name: "copperTolorance",
                    title: "<spring:message code='contract.copperTolorance'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    hidden: true
                },
                {
                    name: "gold",
                    title: "<spring:message code='contract.gold'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    hidden: true
                },
                {
                    name: "goldTolorance",
                    title: "<spring:message code='contract.goldTolorance'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    hidden: true
                },
                {
                    name: "silver",
                    title: "<spring:message code='contract.silver'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    hidden: true
                },
                {
                    name: "silverTolorance",
                    title: "<spring:message code='contract.silverTolorance'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    hidden: true
                },
                {
                    name: "molybdenum",
                    title: "<spring:message code='contract.molybdenum'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    hidden: true
                },
                {
                    name: "molybdenumTolorance",
                    title: "<spring:message code='contract.molybdenumTolorance'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    hidden: true
                },
                {
                    type: "Header",
                    defaultValue: "------------------<spring:message code="contract.payment"/>---------------------------------------------------------------"
                },
                {
                    name: "premium",
                    title: "<spring:message code='contract.premium'/>",
                    type: 'integer',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "discount",
                    title: "<spring:message code='contract.discount'/>",
                    type: 'integer',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "treatCost",
                    title: "<spring:message code='contract.TC'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "refinaryCost",
                    title: "<spring:message code='contract.RC'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "prepaid",
                    title: "<spring:message code='contract.prepaid'/>",
                    type: 'integer',
                    required: false,
                    width: "100%",
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "prepaidCurrency",
                    title: "<spring:message code='contract.prepaidCurrency'/>",
                    type: 'text',
                    defaultValue: "DOLLAR", valueMap: {"EURO": "EURO", "DOLLAR": "DOLLAR"},
                    width: "100%"
                },
                {
                    type: "Header",
                    defaultValue: "------------------<spring:message code="contract.timeIssuance"/>----------------------------------------------------------------"
                },
                {
                    name: "runStartDateDumy",
                    title: "<spring:message code='contract.runStartDate'/>",
                    type: 'date',
                    width: "100%"
                },
                {
                    name: "runEndDateDumy",
                    title: "<spring:message code='contract.runEndDate'/>",
                    type: 'date',
                    width: "100%"
                },
                {type: "Header", defaultValue: ""}
            ]
    });

var IButton_ContactOther_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
                DynamicForm_ContractOther.validate();
            if (DynamicForm_ContractOther.hasErrors())
                return;
            var d = DynamicForm_ContractOther.getValue("sideContractDateDumy");
            var datestring = (d.getFullYear() + "/" + ("0" + (d.getMonth() + 1)).slice(-2) + "/" + ("0" + d.getDate()).slice(-2));
            DynamicForm_ContractOther.setValue("sideContractDate", datestring);

            var d1 = DynamicForm_ContractOther.getValue("contractDateDumy");
            var datestring1 = (d1.getFullYear() + "/" + ("0" + (d1.getMonth() + 1)).slice(-2) + "/" + ("0" + d1.getDate()).slice(-2));
            DynamicForm_ContractOther.setValue("contractDate", datestring1);

            var drs = DynamicForm_ContractOther.getValue("runStartDateDumy");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_ContractOther.setValue("runStartDate", datestringRs);

            var dre = DynamicForm_ContractOther.getValue("runEndDateDumy");
            if (!(dre == null || dre == 'undefiend')) {
                var datestringRe = (dre.getFullYear() + "/" + ("0" + (dre.getMonth() + 1)).slice(-2) + "/" + ("0" + dre.getDate()).slice(-2));
                DynamicForm_ContractOther.setValue("runEndtDate", datestringRe);
            }
            if (dre < drs) {
                isc.warn("aaaaaaaaa",{
                    title: 'هشدار'}
                    );
                return;
            }

            var dataSaveAndUpdateContractOther={};
                    dataSaveAndUpdateContractOther.contractDate= DynamicForm_ContractOther.getValue("contractDate");
                    dataSaveAndUpdateContractOther.contractNo=DynamicForm_ContractOther.getValue("contractNo");
                    dataSaveAndUpdateContractOther.contactId=DynamicForm_ContractOther.getValue("contactId")
                    dataSaveAndUpdateContractOther.contactByBuyerAgentId=null;
                    dataSaveAndUpdateContractOther.contactBySellerId=null;
                    dataSaveAndUpdateContractOther.contactBySellerAgentId=null;
                    dataSaveAndUpdateContractOther.amount=DynamicForm_ContractOther.getValue("amount");
                    dataSaveAndUpdateContractOther.amount_en="any";
                    dataSaveAndUpdateContractOther.unitId=DynamicForm_ContractOther.getValue("unitId");
                    dataSaveAndUpdateContractOther.molybdenumTolorance=DynamicForm_ContractOther.getValue("molybdenumTolorance");
                    dataSaveAndUpdateContractOther.optional=1;
                    dataSaveAndUpdateContractOther.plant="any";
                    dataSaveAndUpdateContractOther.contactInspectionId=0;
                    dataSaveAndUpdateContractOther.molybdenum=DynamicForm_ContractOther.getValue("molybdenum");
                    dataSaveAndUpdateContractOther.copper=DynamicForm_ContractOther.getValue("copper");
                    dataSaveAndUpdateContractOther.mo_amount=0;
                    dataSaveAndUpdateContractOther.timeIssuance="any";
                    dataSaveAndUpdateContractOther.prefixPayment="any";
                    dataSaveAndUpdateContractOther.invoiceType="any";
                    dataSaveAndUpdateContractOther.runStartDate=DynamicForm_ContractOther.getValue("runStartDateDumy");
                    dataSaveAndUpdateContractOther.runTill="any";
                    dataSaveAndUpdateContractOther.runEndtDate=DynamicForm_ContractOther.getValue("runEndDateDumy");
                    dataSaveAndUpdateContractOther.incotermsId=DynamicForm_ContractOther.getValue("incotermsId");
                    dataSaveAndUpdateContractOther.portByPortSourceId=null;
                    dataSaveAndUpdateContractOther.incotermsText="any";
                    dataSaveAndUpdateContractOther.officeSource="any";
                    dataSaveAndUpdateContractOther.priceCalPeriod="any";
                    dataSaveAndUpdateContractOther.publishTime="any";
                    dataSaveAndUpdateContractOther.reportTitle="any";
                    dataSaveAndUpdateContractOther.delay="any";
                    dataSaveAndUpdateContractOther.prepaid=DynamicForm_ContractOther.getValue("prepaid");
                    dataSaveAndUpdateContractOther.prepaidCurrency=DynamicForm_ContractOther.getValue("prepaidCurrency");
                    dataSaveAndUpdateContractOther.payTime="any";
                    dataSaveAndUpdateContractOther.pricePeriod="any";
                    dataSaveAndUpdateContractOther.eventPayment="any";
                    dataSaveAndUpdateContractOther.contentType="any";
                    dataSaveAndUpdateContractOther.premium=DynamicForm_ContractOther.getValue("premium");
                    dataSaveAndUpdateContractOther.treatCost=DynamicForm_ContractOther.getValue("treatCost");
                    dataSaveAndUpdateContractOther.discount=DynamicForm_ContractOther.getValue("discount");
                    dataSaveAndUpdateContractOther.refinaryCost=DynamicForm_ContractOther.getValue("refinaryCost");
                    dataSaveAndUpdateContractOther.materialId=DynamicForm_ContractOther.getValue("materialId");
            var data = ListGrid_ContractOther.getSelectedRecord();
            var method;
            if (data == null){
                method = "POST";
                alert("1");
                }else{
                method = "PUT";
                dataSaveAndUpdateContractOther.id=data.id;
            }
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                    actionURL: "${contextPath}/api/contract",
                    httpMethod: method,
                    data: JSON.stringify(dataSaveAndUpdateContractOther),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>.");
                            windowOther.close();
                            ListGrid_ContractOther.fetchData(criteriaOther);
                            ListGrid_ContractOther.invalidateCache();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });


var contactOtherFormButtonSaveLayout = isc.HStack.create({
        width: "100%",
        height: "2%",
        align: "center",
        showEdges: true,
        backgroundColor: "#CCFFFF",
        membersMargin: 5,
        layoutMargin: 5,
        members: [
            IButton_ContactOther_Save
        ]
    });

var windowOther = isc.Window.create({
                    title: "<spring:message code='salesContractOtherButton.title'/> ",
                    width: "80%",
                    height: "70%",
                    autoCenter: true,
                    align: "center",
                    autoDraw: false,
                    dismissOnEscape: true,
                    closeClick: function () {
                        this.Super("closeClick", arguments)
                    },
                    items:
                        [
                        DynamicForm_ContractOther,
                        contactOtherFormButtonSaveLayout
                        ]
                })

isc.VLayout.create({
        ID: "VLayout_Other",
        width: "100%",
        height: "100%",
        members: [
        ToolStrip_Actions_ContractOther,
        ListGrid_ContractOther
        ]
    });

function ListGrid_ContractOther_edit() {
        var record = ListGrid_ContractOther.getSelectedRecord();
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
            DynamicForm_ContractOther.setValue("sideContractDateDumy", new Date(record.sideContractDate));
            DynamicForm_ContractOther.setValue("contractDateDumy", new Date(record.contractDate));
            DynamicForm_ContractOther.setValue("runEndDateDumy", (record.runEndtDate == null ? null : new Date(record.runEndtDate)));
            DynamicForm_ContractOther.setValue("runStartDateDumy", new Date(record.runStartDate));
            DynamicForm_ContractOther.setValue("materialId", record.materialId);
            DynamicForm_ContractOther.setValue("prepaidCurrency", record.prepaidCurrency);
            DynamicForm_ContractOther.setValue("prepaid", record.prepaid);
            DynamicForm_ContractOther.setValue("incotermsId", record.incotermsId);
            DynamicForm_ContractOther.setValue("copper", record.copper);
            DynamicForm_ContractOther.setValue("molybdenum", record.molybdenum);
            DynamicForm_ContractOther.setValue("molybdenumTolorance", record.molybdenumTolorance);
            DynamicForm_ContractOther.setValue("unitId", record.unitId);
            DynamicForm_ContractOther.setValue("amount", record.amount);
            DynamicForm_ContractOther.setValue("contactId", record.contactId);
            DynamicForm_ContractOther.setValue("contractNo", record.contractNo);
            DynamicForm_ContractOther.setValue("premium", record.premium);
            DynamicForm_ContractOther.setValue("treatCost", record.treatCost);
            DynamicForm_ContractOther.setValue("discount", record.discount);
            DynamicForm_ContractOther.setValue("refinaryCost", record.refinaryCost);
            windowOther.show();
        }
    }

function ListGrid_ContractOther_refresh() {
        ListGrid_ContractOther.fetchData(criteriaOther);
        ListGrid_ContractOther.invalidateCache();
    }