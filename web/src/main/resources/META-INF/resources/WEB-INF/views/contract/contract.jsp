<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

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
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });

    var RestDataSource_Incoterms = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='goods.code'/> "},
            ],
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



var salesContractCADButtonMain = isc.IconButton.create({
        title: "<spring:message code='salesContractCADButton.title'/>",
        width: "25%",
        height: "100%",
        align: "center",
        margin:"35",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='main.contractsCadTab'/>", "<spring:url value="/contact/cadMain"/>")
            Window_SelectTypeContactMain.close();
        }
    });
 var salesContractConcButtonMain = isc.IconButton.create({
        title: "<spring:message code='salesContractConcButton.title'/>",
        width: "25%",
        height: "100%",
        align: "center",
        margin:"35",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
           createTab("<spring:message code='main.contractsConcTab'/>", "<spring:url value="/contact/concMain"/>")
           Window_SelectTypeContactMain.close();
        }
    });
  var salesContractMoButtonMain = isc.IconButton.create({
        title: "<spring:message code='salesContractMoButton.title'/>",
        width: "25%",
        height: "100%",
        align: "center",
        margin:"35",
        icon: "contract/salesContract.png",
        largeIcon: "contract/salesContract.png",
        orientation: "vertical",
        click: function () {
            createTab("<spring:message code='salesContractMoButton.title'/>", "<spring:url value="/contact/contactMolybdenum"/>")
            Window_SelectTypeContactMain.close();
        }
    });
   var Window_SelectTypeContactMain = isc.Window.create({
                            title: "<spring:message code='global.menu.contract.type.contract'/>",
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
                              isc.HLayout.create({autoCenter: true, members: [salesContractMoButtonMain,salesContractCADButtonMain,salesContractConcButtonMain]})
                            ]
                            });



    function ListGrid_Contract_refresh() {
        ListGrid_Contract.invalidateCache();
        companyName.setTitle('Contracts');
    }

    function ListGrid_Contract_edit() {
        var record = ListGrid_Contract.getSelectedRecord();

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
            DynamicForm_Contract.editRecord(record);
            DynamicForm_Contract.setValue("contractDate", (typeof record.contractDate == 'undefined' ?   new Date()  : new Date(record.contractDate)));
            DynamicForm_Contract.setValue("runEndDate", (record.runEndtDate == null ? null : new Date(record.runEndtDate)));
            DynamicForm_Contract.setValue("runStartDate", (typeof record.runStartDate == 'undefined' ?   new Date()  : new Date(record.runStartDate)));
            if (record.material.descl === 'Copper Concentrate') {
                DynamicForm_Contract.getItem("copper").show();
                DynamicForm_Contract.getItem("copperTolorance").show();
                DynamicForm_Contract.getItem("gold").show();
                DynamicForm_Contract.getItem("goldTolorance").show();
                DynamicForm_Contract.getItem("silver").show();
                DynamicForm_Contract.getItem("silverTolorance").show();
                DynamicForm_Contract.getItem("molybdenum").hide();
                DynamicForm_Contract.getItem("molybdenumTolorance").hide();
            } else if (record.material.descl === 'Molybdenum Oxide') {
                DynamicForm_Contract.getItem("copper").hide();
                DynamicForm_Contract.getItem("copperTolorance").hide();
                DynamicForm_Contract.getItem("gold").hide();
                DynamicForm_Contract.getItem("goldTolorance").hide();
                DynamicForm_Contract.getItem("silver").hide();
                DynamicForm_Contract.getItem("silverTolorance").hide();
                DynamicForm_Contract.getItem("molybdenum").show();
                DynamicForm_Contract.getItem("molybdenumTolorance").show();
            } else {
                DynamicForm_Contract.getItem("copper").hide();
                DynamicForm_Contract.getItem("copperTolorance").hide();
                DynamicForm_Contract.getItem("gold").hide();
                DynamicForm_Contract.getItem("goldTolorance").hide();
                DynamicForm_Contract.getItem("silver").hide();
                DynamicForm_Contract.getItem("silverTolorance").hide();
                DynamicForm_Contract.getItem("molybdenum").hide();
                DynamicForm_Contract.getItem("molybdenumTolorance").hide();
            }
            Window_Contract.animateShow();
        }
    }

    function ListGrid_Contract_remove() {

        var record = ListGrid_Contract.getSelectedRecord();

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
                    isc.Button.create({title: "<spring:message code='global.yes'/>"}),
                    isc.Button.create({title: "<spring:message code='global.no'/>"})
                ],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index === 0) {
                                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                                                            actionURL: "${contextPath}/api/contract/" + record.id,
                                                            httpMethod: "DELETE",
                                                            callback: function (resp) {
                                                                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                                                                    ListGrid_Contract_refresh();
                                                                    isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                                                } else {
                                                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                                                }
                                                            }
                                                        }))
                                    } else {
                                        isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                    }
                    }
            });
        }
    }

    var Menu_ListGrid_Contract = isc.Menu.create({
        showIf:"false",
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>",
                icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Contract_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>",
                icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Contract.clearValues();
                    Window_Contract.animateShow();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>",
                showIf: "false",
                icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Contract_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>",
                icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Contract_remove();
                }
            }
        ]
    });

    var RestDataSource_Contact_optionCriteria = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "seller", operator: "equals", value: true}]
    };
    var DynamicForm_Contract = isc.DynamicForm.create({
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
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 4,
       // backgroundImage: "backgrounds/leaves.jpg",
        titleWidth: "120",
        titleAlign: "right",
        fields:
            [
                {name: "id", hidden: true},
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
                    name: "contractDate",
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
                    autoFetchData: false,
                    title: "<spring:message code='contact.name'/>",
                    type: 'long',
                    width: "100%",
                    required: true,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Contact,
                    optionCriteria: RestDataSource_Contact_optionCriteria,
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
                    type: "Header",
                    defaultValue: "------------------  ترم    ----------------------------------------------------------------"
                },
                {
                    name: "incotermsId",
                    colSpan: 3,
                    titleColSpan: 1,
                    tabIndex: 6,
                    showHover: true,
                    required: true,
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
                    defaultValue: "------------------  محصول  --------------------------------------------------------------"
                },
                {
                    name: "materialId",
                    colSpan: 3,
                    titleColSpan: 1,
                    tabIndex: 7,
                    showHover: true,
                    required: true,
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
                    changed(form, item, value) {
                        if (item.getSelectedRecoParametersrd().descl === 'Copper Concentrate') {
                            form.getItem("copper").show();
                            form.getItem("copperTolorance").show();
                            form.getItem("gold").show();
                            form.getItem("goldTolorance").show();
                            form.getItem("silver").show();
                            form.getItem("silverTolorance").show();
                            form.getItem("molybdenum").hide();
                            form.getItem("molybdenumTolorance").hide();
                        } else if (item.getSelectedRecord().descl === 'Molybdenum Oxide') {
                            form.getItem("copper").hide();
                            form.getItem("copperTolorance").hide();
                            form.getItem("gold").hide();
                            form.getItem("goldTolorance").hide();
                            form.getItem("silver").hide();
                            form.getItem("silverTolorance").hide();
                            form.getItem("molybdenum").show();
                            form.getItem("molybdenumTolorance").show();
                        } else {
                            form.getItem("copper").hide();
                            form.getItem("copperTolorance").hide();
                            form.getItem("gold").hide();
                            form.getItem("goldTolorance").hide();
                            form.getItem("silver").hide();
                            form.getItem("silverTolorance").hide();
                            form.getItem("molybdenum").hide();
                            form.getItem("molybdenumTolorance").hide();
                        }
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
                    title: "<spring:message code='unit.nameFa'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Unit,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", width: 440, align: "center"}
                    ]
                },
                {
                    type: "Header",
                    defaultValue: "------------------  محتوی   --------------------------------------------------------------"
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
                    defaultValue: "------------------  قیمت---------------------------------------------------------------"
                },
                {
                    name: "premium",
                    title: "<spring:message code='contract.premium'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "discount",
                    title: "<spring:message code='contract.discount'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
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
                    keyPressFilter: "[0-9.]",
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
                    keyPressFilter: "[0-9.]",
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
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "prepaidCurrency",
                    title: "<spring:message code='contract.prepaidCurrency'/>",
                    type: 'text',
                    defaultValue: "USD", valueMap: dollar,
                    width: "100%"
                },
                {
                    type: "Header",
                    defaultValue: "------------------  زمان----------------------------------------------------------------"
                },
                {
                    name: "runStartDate",
                    title: "<spring:message code='contract.runStartDate'/>",
                    type: 'date',
                    width: "100%"
                },
                {
                    name: "runEndDate",
                    title: "<spring:message code='contract.runEndDate'/>",
                    type: 'date',
                    width: "100%"
                },
                {type: "Header", defaultValue: ""}
            ]
    });

    var ToolStripButton_Contract_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Contract_refresh();
        }
    });

    var ToolStripButton_Contract_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.menu.contract.management'/>",
        click: function () {
            Window_SelectTypeContactMain.animateShow();
        }
    });

    /*var ToolStripButton_Contract_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        showIf: "false",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Contract.clearValues();
            ListGrid_Contract_edit();
        }
    });*/

    var ToolStripButton_Contract_Print = isc.ToolStripButtonPrint.create({
        icon: "[SKIN]/actions/print.png",
        showIf: "true",
        title: "<spring:message code='global.form.print'/>",
        click: function () {
             var printSelectID=ListGrid_Contract.getSelectedRecord();
             if (printSelectID == null || printSelectID.id == null){
                isc.Dialog.create({
                                        message: "<spring:message code='global.grid.record.not.selected'/>",
                                        icon: "[SKIN]ask.png",
                                        title: "<spring:message code='global.message'/>",
                                        buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                                        buttonClick: function () {
                                            this.hide();
                                        }});
                }
             else{
                 "<spring:url value="/contract/print" var="printUrl"/>";
                 var recordIdPrint = ListGrid_Contract.getSelectedRecord();
                 window.open('${printUrl}'+"/"+recordIdPrint.id);
            }
        }
    });

    var ToolStripButton_Contract_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Contract_remove();
        }
    });

    var ToolStrip_Actions_Contract = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members:
            [
                ToolStripButton_Contract_Add,
                ToolStripButton_Contract_Remove,
                ToolStripButton_Contract_Print,
                isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Contract_Refresh,
                ]
                }),

            ]
    });

    var HLayout_Contract_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Contract
            ]
    });

    var IButton_Contract_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Contract.validate();
            if (DynamicForm_Contract.hasErrors())
                return;

            DynamicForm_Contract.setValue("contractDate",DynamicForm_Contract.getValue("contractDate").toNormalDate("toUSShortDate"));
            DynamicForm_Contract.setValue("runStartDate",DynamicForm_Contract.getValue("runStartDate").toNormalDate("toUSShortDate"));

            var dre = DynamicForm_Contract.getValue("runEndDate");
            if (!(dre == null || dre == 'undefiend')) {
                DynamicForm_Contract.setValue("runEndtDate", DynamicForm_Contract.setValue("runEndtDate").toNormalDate("toUSShortDate"));
            }

            if (dre < drs) {
                isc.warn("<spring:message code='contract.date.validation'/>", {title:"<spring:message code='dialog_WarnTitle'/>"});
                return;
            }

            var data = DynamicForm_Contract.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/contract/",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_Contract_refresh();
                            Window_Contract.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });
    var Window_Contract = isc.Window.create({
        title: "<spring:message code='contract.title'/> ",
        width: 580,
        // height: "*",
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                DynamicForm_Contract,
                isc.HLayout.create({
                    width: "100%", align: "center", height: "20",
                    members:
                        [
                            IButton_Contract_Save,
                            isc.Label.create({
                                width: 15,
                            }),
                            isc.IButtonCancel.create({
                                ID: "contractEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Contract.close();
                                }
                            })
                        ]
                })
            ]
    });

    // var recordNotFound = isc.Label.create({
    // height: 30,
    // padding: 10,
    // align: "center",
    // valign: "center",
    // wrap: false,
    // contents: "رکوردی یافت نشد"
    // });
    //
    // recordNotFound.hide();

    // function setCriteria_ListGrid_Contract(recordId) {
    //
    //     var criteria = {
    //     _constructor: "AdvancedCriteria",
    //     operator: "and",
    //     criteria: [{fieldName: "contractId", operator: "equals", value: recordId}]
    //     };
    //     ListGrid_ContractShipment.fetchData(criteria, function (dsResponse, data, dsRequest) {
    //     if (data.length === 0) {
    //         recordNotFound.show();
    //         ListGrid_ContractShipment.hide()
    //     } else {
    //         recordNotFound.hide();
    //         ListGrid_ContractShipment.setData(data);
    //         ListGrid_ContractShipment.show();
    //     }
    //     });
    // }

    // function getExpandedComponent_contract(record) {
    //     setCriteria_ListGrid_Contract(record.id)
    //     var hLayout_contract = isc.HLayout.create({
    //     align: "center", padding: 5,
    //     membersMargin: 20,
    //     members: [
    //         ToolStripButton_ContractShipment_Add
    //     ]
    //     });
    //
    //     var layout_ListGrid_contract = isc.VLayout.create({
    //         styleName: "expand-layout",
    //         padding: 5,
    //         membersMargin: 10,
    //         members: [ListGrid_ContractShipment, recordNotFound, hLayout_contract]
    //     });
    //
    //    return layout_ListGrid_contract;
    // }
    var contractAttachmentViewLoader = isc.ViewLoader.create({
    autoDraw: false,
    loadingMessage: ""
    });

    var hLayoutViewLoader = isc.HLayout.create({
    width:"100%",
    height: 200,
    align: "center",padding: 5,
    membersMargin: 20,
    members: [
        contractAttachmentViewLoader
    ]
    });
    hLayoutViewLoader.hide();


    var ListGrid_Contract = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Contract,
        contextMenu: Menu_ListGrid_Contract,
        styleName:'expandList',
        autoFetchData: true,
        alternateRecordStyles: true,
        canExpandRecords: true,
        canExpandMultipleRecords: false,
        wrapCells: false,
        showRollOver: false,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        autoFitExpandField: true,
        virtualScrolling: true,
        loadOnExpand: true,
        loaded: false,
        fields:
            [
                {name: "id", hidden: true},
                {
                    name: "material.descl",
                    title: "Type material",
                    hidden: false,
                    width: "5%",
                    align: "center",
                    sortNormalizer: function(recordObject)
                    {
                    return recordObject.material.descl;
                    }
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
                    type: 'datetime',
                    width: "7%",
                    align: "center"
                },
                {
                    name: "contact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    type: 'text',
                    width: "12%",
                    align: "center",
                    sortNormalizer: function(recordObject)
                    {
                    return recordObject.contact.nameFA;
                    }
                },
                {
                    name: "incoterms.code",
                    title: "<spring:message code='incoterms.name'/>",
                    width: "10%",
                    align: "center",
                    sortNormalizer: function(recordObject)
                    {
                    return recordObject.incoterms.code;
                    }
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
        // sortField: 0,
        // autoFetchData: true,
        // showFilterEditor: true,
        // filterOnKeypress: true,
        // recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        // updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
        //     var record = this.getSelectedRecord();
        //     companyName.setTitle(record.contractNo + ' ' + record.contact.nameFA);
        // }
        /*getCellCSSText: function (record, rowNum, colNum) {
                            if (record.material.descl.contains("Cat")) {
                                  return "font-weight:bold;background-color:#5ec4aa;";
                                }
                            if (record.material.descl.contains("Mol")) {
                                  return "font-weight:bold;background-color:#f0c85a;";
                                }
                            if (record.material.descl.contains("Mat")) {
                                  return "font-weight:bold;background-color:#c0110c;";
                                }
                            if (record.material.descl.contains("Conc")) {
                                  return "font-weight:bold;background-color:#6aa6de;";
                                }
                }*/
          getExpansionComponent: function (record) {
            //return getExpandedComponent_contract(record)
                    var dccTableId = record.id;
                    var dccTableName = "TBL_CONTRACT";
                    contractAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId);
                    hLayoutViewLoader.show();
                var layout = isc.VLayout.create({
                    styleName: "expand-layout",
                    padding: 5,
                    membersMargin: 10,
                    members: [
                        hLayoutViewLoader
                        ]
                });
                return layout;
            },
         rollOverCanvasProperties:{
                vertical:false, capSize:7,
                src:"other/cellOverRecticle.png"
            }
    });



    var HLayout_Contract_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Contract
        ]
    });
        var labelMO=isc.Label.create({
            height: 20,
            width: 100,
            padding: 2,
            margin: 3,
            backgroundColor: "#f0c85a",
            align: "center",
            contents: "MOLYBDENUM"
        })
        var labelCa=isc.Label.create({
            height: 20,
            width: 100,
            padding: 2,
            margin: 3,
            backgroundColor: "#5ec4aa",
            align: "center",
            contents: "CATHODS"
        })
        var labelCopperMatte=isc.Label.create({
            height: 20,
            width: 100,
            padding: 2,
            margin: 3,
            backgroundColor: "#c0110c",
            align: "center",
            contents: "Matte"
        })
        var labelConcentrate=isc.Label.create({
            height: 20,
            width: 100,
            padding: 2,
            margin: 3,
            backgroundColor: "#6aa6de",
            align: "center",
            contents: "Concentrate"
        })
    var VLayout_Contract_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",

        members: [
            HLayout_Contract_Actions,
            isc.HLayout.create({showIf:"false",height: "30", align: "left", members: [labelMO,labelCa,labelCopperMatte,labelConcentrate]})
            ,HLayout_Contract_Grid
        ]
    });

    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    var RestDataSource_Port = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "port", title: "<spring:message code='port.port'/>", width: 200},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>", width: 200}
            ],
        // ######@@@@###&&@@###
        fetchDataURL: "${contextPath}/api/port/spec-list"
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
                    format: 'DD-MM-YYYY'
                },
                {name: "duration", title: "<spring:message code='global.duration'/>", type: 'text', width: 400}
            ],
        fetchDataURL: "${contextPath}/api/contractShipment/spec-list"
    });

    /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    *************************************************************************************************************************/
    function ListGrid_ContractShipment_refresh() {
        ListGrid_ContractShipment.invalidateCache();
        var record = ListGrid_Contract.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "contract.id", operator: "equals", value: record.id}]
        };
        ListGrid_ContractShipment.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_ContractShipment.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_ContractShipment_edit() {
        var shipmentRecord = ListGrid_ContractShipment.getSelectedRecord();
        if (shipmentRecord == null || shipmentRecord.id == null) {
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
            DynamicForm_ContractShipment.clearValues();
            DynamicForm_ContractShipment.editRecord(shipmentRecord);

            var contractRecord = ListGrid_Contract.getSelectedRecord();
            DynamicForm_ContractShipment.setValue("contractId", contractRecord.id);
            DynamicForm_ContractShipment.setValue("contractDate", contractRecord.contractDate);
            DynamicForm_ContractShipment.setValue("sendDate", new Date(shipmentRecord.sendDate));
            Window_ContractShipment.animateShow();
        }
    }

    function ListGrid_ContractShipment_remove() {
        var record = ListGrid_ContractShipment.getSelectedRecord();
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
                buttons: [isc.Button.create({title: "<spring:message code='global.yes'/>"}), isc.Button.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index === 0) {
                        var ContractShipmentId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/contractShipment/" + ContractShipmentId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                        ListGrid_ContractShipment_refresh();
                                        isc.say("<spring:message code='global.grid.record.remove.success'/>");
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

    var Menu_ListGrid_ContractShipment = isc.Menu.create({
        width: 150,
        data:
            [
                {
                    title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_ContractShipment_refresh();
                    }
                },
                {
                    title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                    click: function () {
                        DynamicForm_ContractShipment.clearValues();
                        Window_ContractShipment.animateShow();
                    }
                },
                {
                    title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_ContractShipment_edit();
                    }
                },
                {
                    title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_ContractShipment_remove();
                    }
                }
            ]
    });

    var DynamicForm_ContractShipment = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        // showErrorStyle:true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 1,
        fields:
            [
                {name: "id", hidden: true, primaryKey: true, canEdit: false,},
                {name: "contractId", type: "long", hidden: true},
                {
                    name: "plan",
                    title: "<spring:message code='shipment.plan'/>",
                    type: 'text',
                    required: true,
                    width: 400,
                    valueMap: {"A": "plan A", "B": "plan B", "C": "plan C",}
                },
                {
                    name: "shipmentRow",
                    title: "<spring:message code='contractItem.itemRow'/>",
                    type: 'integer',
                    required: true,
                    width: 400,
                    keyPressFilter: "[0-9]",
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "dischargeId",
                    title: "<spring:message code='port.port'/>",
                    type: 'long',
                    required: true,
                    width: 400,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Port,
                    displayField: "port",
                    valueField: "id",
                    pickListWidth: "300",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [{name: "port", width: 400, align: "center"}]
                },

                {
                    name: "address",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    required: false,
                    width: 400
                },

                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float',
                    required: true,
                    width: 400,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    type: 'date',
                    required: true,
                    width: 400,
                    format: 'DD-MM-YYYY'
                },
                {
                    name: "duration",
                    title: "<spring:message code='global.duration'/>",
                    type: 'integer',
                    width: 400,
                    keyPressFilter: "[0-9]",
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='contractItemShipment.tolorance'/>",
                    type: 'integer',
                    width: 400,
                    validators: [{
                        type: "isInteger",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ]
    });

    <%--var ToolStripButton_ContractShipment_Refresh = isc.ToolStripButtonRefresh.create({--%>
        <%--icon: "[SKIN]/actions/refresh.png",--%>
        <%--title: "<spring:message code='global.form.refresh'/>",--%>
        <%--click: function () {--%>
            <%--ListGrid_ContractShipment_refresh();--%>
        <%--}--%>
    <%--});--%>

    <%--var ToolStripButton_ContractShipment_Add = isc.ToolStripButtonAddLarge.create({--%>
        <%--icon: "[SKIN]/actions/add.png",--%>
        <%--title: "<spring:message code='global.form.new'/>",--%>
        <%--click: function () {--%>
            <%--var record = ListGrid_Contract.getSelectedRecord();--%>
            <%--DynamicForm_ContractShipment.clearValues();--%>
            <%--DynamicForm_ContractShipment.setValue("contractId", record.id);--%>
            <%--DynamicForm_ContractShipment.setValue("contractDate", record.contractDate);--%>
            <%--Window_ContractShipment.animateShow();--%>
        <%--}--%>
    <%--});--%>

    <%--var ToolStripButton_ContractShipment_Edit = isc.ToolStripButtonEdit.create({--%>
        <%--icon: "[SKIN]/actions/edit.png",--%>
        <%--title: "<spring:message code='global.form.edit'/>",--%>
        <%--click: function () {--%>
            <%--ListGrid_ContractShipment_edit();--%>
        <%--}--%>
    <%--});--%>

    <%--var ToolStripButton_ContractShipment_Remove = isc.ToolStripButtonRemove.create({--%>
        <%--icon: "[SKIN]/actions/remove.png",--%>
        <%--title: "<spring:message code='global.form.remove'/>",--%>
        <%--click: function () {--%>
            <%--ListGrid_ContractShipment_remove();--%>
        <%--}--%>
    <%--});--%>

    // var ToolStrip_Actions_ContractShipment = isc.ToolStrip.create({
    //     width: "100%",
    //     members:
    //         [
    //             ToolStripButton_ContractShipment_Add,
    //             ToolStripButton_ContractShipment_Edit,
    //             ToolStripButton_ContractShipment_Remove,
    //             isc.ToolStrip.create({
    //             width: "100%",
    //             align: "left",
    //             border: '0px',
    //             members: [
    //                 ToolStripButton_ContractShipment_Refresh,
    //             ]
    //             })
    //
    //         ]
    // });

    // var HLayout_ContractShipment_Actions = isc.HLayout.create({
    //     width: "100%",
    //     members:
    //         [
    //             ToolStrip_Actions_ContractShipment
    //         ]
    // });
    var IButton_ContractShipment_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_ContractShipment.validate();
            if (DynamicForm_ContractShipment.hasErrors())
                return;

            DynamicForm_ContractShipment.setValue("sendDate", DynamicForm_ContractShipment.getValue("sendDate").toNormalDate("toUSShortDate"));

            var contractDate = DynamicForm_ContractShipment.getValue("contractDate").split("/");
            /*if (d < new Date(contractDate[0], contractDate[1] - 1, contractDate[2])) {
                isc.warn("<spring:message code='shipment.date.validation'/>", {title:"<spring:message code='dialog_WarnTitle'/>"});
                return;
            }
            */
            var data = DynamicForm_ContractShipment.getValues();
            var methodXXXX = "PUT";
            if (data.id == null) methodXXXX = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/contractShipment/",
                    httpMethod: methodXXXX,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_ContractShipment_refresh();
                            Window_ContractShipment.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });
    var Window_ContractShipment = isc.Window.create({
        title: "<spring:message code='Shipment.title'/> ",
        width: 580,
        // height: 500,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                DynamicForm_ContractShipment,
                isc.HLayout.create({
                    width: "100%", align: "center", height: "20",
                    members:
                        [
                            IButton_ContractShipment_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                ID: "shipmentEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_ContractShipment.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_ContractShipment = isc.ListGrid.create({
        width: "100%",
        height: 200,
        styleName: "listgrid-child",
        dataSource: RestDataSource_ContractShipment,
        contextMenu: Menu_ListGrid_ContractShipment,
        fields:
            [
                {name: "id", hidden: true,},
                {name: "contractId", type: "long", hidden: true},
                {
                    name: "plan",
                    title: "<spring:message code='shipment.plan'/>",
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
                {name: "discharge.port", title: "<spring:message code='port.port'/>", width: 400, align: "center"},
                {
                    name: "address",
                    title: "<spring:message code='global.address'/>",
                    type: 'text',
                    required: true,
                    width: "10%",
                    align: "center"
                },
                {
                    name: "amount",
                    title: "<spring:message code='global.amount'/>",
                    type: 'float',
                    required: true,
                    width: "10%",
                    align: "center"
                },
                {
                    name: "sendDate",
                    title: "<spring:message code='global.sendDate'/>",
                    type: 'datetime',
                    width: "10%",
                    align: "center",
                    format: 'DD-MM-YYYY'
                },
                {
                    name: "duration",
                    title: "<spring:message code='global.duration'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "tolorance",
                    title: "<spring:message code='contractItemShipment.tolorance'/>",
                    type: 'text',
                    width: "10%",
                    align: "center"
                },
                {
                name: "editIcon",
                width: 40,
                align: "center",
                showTitle: false
                },
                {
                name: "removeIcon",
                width: 40,
                align: "center",
                showTitle: false
                },
            ],
        sortField: 0,
        autoFetchData: false,
        showFilterEditor: false,
        filterOnKeypress: true,
        showRecordComponents: true,
        showRecordComponentsByCell: true,
        createRecordComponent: function (record, colNum) {
        var fieldName = this.getFieldName(colNum);
        if (fieldName == "editIcon") {
        var editImg = isc.ImgButton.create({
            showDown: false,
            showRollOver: false,
            layoutAlign: "center",
            src: "pieces/16/icon_edit.png",
            prompt: "ویرایش",
            height: 16,
            width: 16,
            grid: this,
            click: function () {
            ListGrid_ContractShipment.selectSingleRecord(record);
            ListGrid_ContractShipment_edit();
            }
            });
            return editImg;
        } else if (fieldName == "removeIcon") {
        var removeImg = isc.ImgButton.create({
            showDown: false,
            showRollOver: false,
            layoutAlign: "center",
            src: "pieces/16/icon_delete.png",
            prompt: "حذف",
            height: 16,
            width: 16,
            grid: this,
        click: function () {
          ListGrid_ContractShipment.selectSingleRecord(record);
          ListGrid_ContractShipment_remove();
        }
        });
        return removeImg;
        } else {
        return null;
        }
        },
    recordDoubleClick: function (viewer, record, recordNum, field, fieldNum, value, rawValue) {
    loadWindowFeatureList(record)
    }
    });


        function loadWindowFeatureList(record) {
            var dccTableId = record.id;
            var dccTableName = "TBL_CONTRACT";
            var window_view_url = isc.Window.create({
            title: "<spring:message code='global.Attachment'/>", pane: contractAttachmentViewLoader,
            width: "80%",
            height: "40%",
            autoCenter: true,
            isModal: true,
            showModalMask: true,
            align: "center",
            autoDraw: false,
            dismissOnEscape: true,
            closeClick: function () {
            this.Super("closeClick", arguments)
            },
            items:
            [
            isc.ViewLoader.create({
            autoDraw:true,
            viewURL: "dcc/showForm/" + dccTableName + "/" + dccTableId,
            loadingMessage:"<spring:message code='global.loadingMessage'/>"
            })
            ]
            });
            window_view_url.show();
        }
    var HLayout_ContractShipment_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
                ListGrid_ContractShipment
            ]
    });

    var VLayout_ContractShipment_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members:
            [
               // HLayout_ContractShipment_Actions,
                HLayout_ContractShipment_Grid
            ]
    });
    /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
    <%--isc.HLayout.create({--%>
        <%--width: "100%",--%>
        <%--height: "100%",--%>
        <%--border: "1px solid black",--%>
        <%--layoutTopMargin: 5,--%>
        <%--members: [--%>
            <%--isc.TabSet.create({--%>
                <%--tabBarPosition: "top",--%>
                <%--width: "100%",--%>
                <%--tabs:--%>
                    <%--[--%>
                        <%--{--%>
                            <%--ID: "companyName",--%>
                            <%--title: "<spring:message code='main.contractsTab'/>",--%>
                            <%--pane: VLayout_Contract_Body--%>
                        <%--},--%>
                        <%--{--%>
                            <%--title: "<spring:message code='Shipment.title'/>", pane: VLayout_ContractShipment_Body,--%>
                            <%--tabSelected: function (form, item, value) {--%>
                                <%--var record = ListGrid_Contract.getSelectedRecord();--%>
                                <%--if (record == null || record.id == null) {--%>
                                    <%--isc.Dialog.create({--%>
                                        <%--message: "<spring:message code='global.grid.record.not.selected'/>",--%>
                                        <%--icon: "[SKIN]ask.png",--%>
                                        <%--title: "<spring:message code='global.message'/>",--%>
                                        <%--buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],--%>
                                        <%--buttonClick: function () {--%>
                                            <%--this.hide();--%>
                                        <%--}--%>
                                    <%--});--%>
                                    <%--record.id = null;--%>
                                <%--}--%>
                                <%--var criteria = {--%>
                                    <%--_constructor: "AdvancedCriteria",--%>
                                    <%--operator: "and",--%>
                                    <%--criteria: [{fieldName: "contractId", operator: "equals", value: record.id}]--%>
                                <%--};--%>
                                <%--ListGrid_ContractShipment.fetchData(criteria, function (dsResponse, data, dsRequest) {--%>
                                    <%--ListGrid_ContractShipment.setData(data);--%>
                                <%--});--%>
                            <%--}--%>
                        <%--},--%>
                        <%--{--%>
                            <%--title: "<spring:message code='global.Attachment'/>", pane: contractAttachmentViewLoader,--%>
                            <%--tabSelected: function (form, item, value) {--%>
                                <%--var record = ListGrid_Contract.getSelectedRecord();--%>
                                <%--if (record == null || record.id == null) {--%>
                                    <%--isc.Dialog.create({--%>
                                        <%--message: "<spring:message code='global.grid.record.not.selected'/>",--%>
                                        <%--icon: "[SKIN]ask.png",--%>
                                        <%--title: "<spring:message code='global.message'/>",--%>
                                        <%--buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],--%>
                                        <%--buttonClick: function () {--%>
                                            <%--this.hide();--%>
                                        <%--}--%>
                                    <%--});--%>
                                    <%--record.id = null;--%>
                                <%--}--%>
                                <%--var dccTableId = record.id;--%>
                                <%--var dccTableName = "TBL_CONTRACT";--%>
                                <%--contractAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId)--%>
                            <%--}--%>
                        <%--}--%>
                    <%--]--%>
            <%--})--%>
        <%--]--%>
    <%--});--%>




        isc.SectionStack.create({
            sections: [{
            title: "<spring:message code='main.contractsTab'/>",
            items: VLayout_Contract_Body,
            showHeader: false,
            expanded: true
            },
            {
            title: "<spring:message code='Shipment.title'/>",
            items: VLayout_ContractShipment_Body,
            expanded: true,
            hidden: true
            },
            <%--{--%>
            <%--title: "<spring:message code='global.Attachment'/>",--%>
            <%--items: contractAttachmentViewLoader,--%>
            <%--expanded: true,--%>
            <%--hidden: true--%>
            <%--}--%>
            ],
            visibilityMode: "multiple",
            animateSections: true,
            height: "100%",
            width: "100%",
            overflow: "hidden"
        })