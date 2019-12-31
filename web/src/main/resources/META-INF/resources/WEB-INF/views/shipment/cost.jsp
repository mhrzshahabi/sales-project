<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />
    var RestDataSource_Shipment_CostHeader = isc.MyRestDataSource.create(
        {
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "contractShipmentId",
                    hidden: true,
                    type: 'long'
                },
                {
                    name: "contactId",
                    type: 'long',
                    hidden: true
                },
                {
                    name: "contract.contact.nameFA"
                },
                {
                    name: "contractId",
                    type: 'long',
                    hidden: true
                },
                {
                    name: "contract.contractNo"
                },
                {
                    name: "contract.contractDate"
                },
                {
                    name: "materialId"
                },
                {
                    name: "material.descl"
                },
                {
                    name: "material.unit.nameEN"
                },
                {
                    name: "amount"
                },
                {
                    name: "shipmentType"
                },
                {
                    name: "loadingLetter"
                },
                {
                    name: "noContainer"
                },
                {
                    name: "portByLoading.port"
                },
                {
                    name: "portByDischarge.port"
                },
                {
                    name: "description"
                },
                {
                    name: "contractShipment.sendDate"
                },
                {
                    name: "createDate"
                },
                {
                    name: "month"
                },
                {
                    name: "contactByAgent.nameFA"
                },
                {
                    name: "vesselName"
                },
                {
                    name: "swb"
                },
                {
                    name: "switchPort.port"
                },
                {
                    name: "status"
                },],
            fetchDataURL: "${contextPath}/api/shipment/spec-list"
        });


    var Menu_ListGrid_Shipment_CostHeader = isc.Menu.create({
        width: 150,
        data: [

            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Shipment_CostHeader.invalidateCache();
                }
            }
        ]
    });
    var ToolStripButton_Shipment_CostHeader_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Shipment_CostHeader.invalidateCache();
            ListGrid_Cost.setData([]);
        }
    });
    var ToolStrip_Actions_Shipment_CostHeader = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members: [
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Shipment_CostHeader_Refresh
                ]
            })

        ]
    });

    var ListGrid_Shipment_CostHeader = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        contextMenu: Menu_ListGrid_Shipment_CostHeader,
        dataSource: RestDataSource_Shipment_CostHeader,
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {name: "contractShipmentId", hidden: true, type: 'long'},
            {name: "contactId", type: 'long', hidden: true},
            {
                name: "contract.contact.nameFA", title: "<spring:message code='contact.name'/>",
                type: 'text', width: "20%", align: "center", showHover: true
            },
            {name: "contractId", type: 'long', hidden: true},
            {
                name: "contract.contractNo", title: "<spring:message code='contract.contractNo'/>",
                type: 'text', width: "10%", showHover: true
            },
            {
                name: "contract.contractDate", title: "<spring:message code='contract.contractDate'/>",
                type: 'text', width: "10%", showHover: true
            },
            {
                name: "materialId",
                title: "<spring:message code='contact.name'/>",
                type: 'long',
                hidden: true,
                showHover: true
            },
            {
                name: "material.descl", title: "<spring:message code='material.descl'/>",
                type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "material.unit.nameEN", title: "<spring:message code='unit.nameEN'/>",
                type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "amount", title: "<spring:message code='global.amount'/>",
                type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "shipmentType", title: "<spring:message code='shipment.shipmentType'/>",
                type: 'text', width: "10%", showHover: true
            },
            {
                name: "loadingLetter", title: "<spring:message code='shipment.loadingLetter'/>",
                type: 'text', width: "10%", showHover: true
            },
            {
                name: "noContainer", title: "<spring:message code='shipment.noContainer'/>",
                type: 'text', width: "10%", align: "center", showHover: true
            },
            {
                name: "portByLoading.port", title: "<spring:message code='shipment.loading'/>",
                type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "portByDischarge.port", title: "<spring:message code='shipment.discharge'/>",
                type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "description", title: "<spring:message code='shipment.description'/>",
                type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "contractShipment.sendDate", title: "<spring:message code='global.sendDate'/>",
                type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "createDate", title: "<spring:message code='global.createDate'/>",
                type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "month", title: "<spring:message code='shipment.month'/>",
                type: 'text', required: true, width: "10%", align: "center", showHover: true
            },
            {
                name: "contactByAgent.nameFA", title: "<spring:message code='shipment.agent'/>",
                type: 'text', width: "20%", align: "center", showHover: true
            },
            {
                name: "vesselName", title: "<spring:message code='shipment.vesselName'/>",
                type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "swb",
                title: "<spring:message code='shipment.SWB'/>",
                type: 'text',
                required: true,
                width: "10%",
                showHover: true
            },
            {
                name: "switchPort.port", title: "<spring:message code='port.switchPort'/>"
                , type: 'text', required: true, width: "10%", showHover: true
            },
            {
                name: "status", title: "<spring:message code='shipment.staus'/>",
                type: 'text', width: "10%", align: "center", valueMap: {
                    "Load Ready": "<spring:message code='shipment.loadReady'/>",
                    "Resource": "<spring:message code='shipment.resource'/>"
                }, showHover: true
            },

        ],
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
            var criteria1 = {
                _constructor: "AdvancedCriteria",
                operator: "and",
                criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
            };
            ListGrid_Cost.fetchData(criteria1, function (dsResponse, data, dsRequest) {
                ListGrid_Cost.setData(data);
            });
        },
        dataArrived: function (startRow, endRow) {
        },
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true
    });
    var HLayout_Grid_Shipment_CostHeader = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Shipment_CostHeader
        ]
    });

    var VLayout_Body_Shipment_CostHeader = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_Shipment_CostHeader, HLayout_Grid_Shipment_CostHeader
        ]
    });

    var RestDataSource_ContactBySourceInspector = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/>"},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
                {name: "commertialRole"},
            ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });
    var RestDataSource_ContactByDestinationInspector = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/>"},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
                {name: "commertialRole"},
            ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });
    var RestDataSource_ContactByInsurance = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/>"},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
                {name: "commertialRole"},
                {name: "country.nameFa", title: "<spring:message code='country.nameFa'/>"}
            ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });

    var RestDataSource_Cost = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "shipmentId", title: "id", canEdit: false, hidden: true},
                {name: "sourceInspector.nameFA"},
                {name: "sourceInspectionCost"},
                {name: "sourceInspectionCurrency"},
                {name: "destinationInspector.nameFA"},
                {name: "destinationInspectionCost"},
                {name: "destinationInspectionCurrency"},
                {name: "otherCost"},
                {name: "otherCostCurrency"},
                {name: "sarcheshmehLabCost"},
                {name: "umpireCost"},
                {name: "umpireCostCurrency"},
                {name: "sourceGold"},
                {name: "destinationGold"},
                {name: "sourceSilver"},
                {name: "destinationSilver"},
                {name: "sourceCopper"},
                {name: "destinationCopper"},
                {name: "sourceMolybdenum"},
                {name: "destinationMolybdenum"},
                {name: "insurance.nameFA"},
                {name: "insuranceCost"},
                {name: "insuranceCostCurrency"},
                {name: "insuranceClause"},
                {name: "inventortRentCost"},
                {name: "postCost"},
                {name: "thcCost"},
                {name: "blFeeCost"},
                {name: "demandCost"},
                {name: "contractorCost"},
                {name: "counterCost"},
                {name: "disinfectionCost"},
                {name: "portCost"},
            ],
        fetchDataURL: "${contextPath}/api/cost/spec-list"
    });

    function ListGrid_Cost_refresh() {
        ListGrid_Cost.invalidateCache();
        var record = ListGrid_Shipment_CostHeader.getSelectedRecord();
        if (record == null || record.id == null)
            return;
        var criteria1 = {
            _constructor: "AdvancedCriteria",
            operator: "and",
            criteria: [{fieldName: "shipmentId", operator: "equals", value: record.id}]
        };
        ListGrid_Cost.fetchData(criteria1, function (dsResponse, data, dsRequest) {
            ListGrid_Cost.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_Cost_edit() {
        var record = ListGrid_Cost.getSelectedRecord();

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
            DynamicForm_Cost.editRecord(record);
            if (ListGrid_Shipment_CostHeader.getSelectedRecord().material.descl === 'Copper Concentrate') {
                DynamicForm_Cost.getItem("sourceCopper").show();
                DynamicForm_Cost.getItem("destinationCopper").show();
                DynamicForm_Cost.getItem("sourceGold").show();
                DynamicForm_Cost.getItem("destinationGold").show();
                DynamicForm_Cost.getItem("sourceSilver").show();
                DynamicForm_Cost.getItem("destinationSilver").show();
                DynamicForm_Cost.getItem("sourceMolybdenum").hide();
                DynamicForm_Cost.getItem("destinationMolybdenum").hide();
            } else if (ListGrid_Shipment_CostHeader.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
                DynamicForm_Cost.getItem("sourceCopper").hide();
                DynamicForm_Cost.getItem("destinationCopper").hide();
                DynamicForm_Cost.getItem("sourceGold").hide();
                DynamicForm_Cost.getItem("destinationGold").hide();
                DynamicForm_Cost.getItem("sourceSilver").hide();
                DynamicForm_Cost.getItem("destinationSilver").hide();
                DynamicForm_Cost.getItem("sourceMolybdenum").show();
                DynamicForm_Cost.getItem("destinationMolybdenum").show();
            } else {
                DynamicForm_Cost.getItem("sourceCopper").show();
                DynamicForm_Cost.getItem("destinationCopper").show();
                DynamicForm_Cost.getItem("sourceGold").hide();
                DynamicForm_Cost.getItem("destinationGold").hide();
                DynamicForm_Cost.getItem("sourceSilver").hide();
                DynamicForm_Cost.getItem("destinationSilver").hide();
                DynamicForm_Cost.getItem("sourceMolybdenum").hide();
                DynamicForm_Cost.getItem("destinationMolybdenum").hide();
            }
            Window_Cost.animateShow();
        }
    }

    function ListGrid_Cost_remove() {

        var record = ListGrid_Cost.getSelectedRecord();

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
                buttons: [isc.IButtonSave.create({
                    title: "<spring:message
		code='global.yes'/>"
                }), isc.IButtonCancel.create({title: "<spring:message code='global.no'/>"})],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index === 0) {
                        var CostId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                            actionURL: "${contextPath}/api/cost/" + record.id,
                            httpMethod: "DELETE",
                            callback: function (resp) {
                                if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                                    ListGrid_Cost_refresh();
                                    isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                } else {
                                    isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                }
                            }
                        }));
                    }
                }
            });
        }
    }

    var Menu_ListGrid_Cost = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Cost_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    var record = ListGrid_Shipment_CostHeader.getSelectedRecord();

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
                        DynamicForm_Cost.clearValues();
                        DynamicForm_Cost.setValue("shipmentId", record.id);
                        if (ListGrid_Shipment_CostHeader.getSelectedRecord().material.descl === 'Copper Concentrate') {
                            DynamicForm_Cost.getItem("sourceCopper").show();
                            DynamicForm_Cost.getItem("destinationCopper").show();
                            DynamicForm_Cost.getItem("sourceGold").show();
                            DynamicForm_Cost.getItem("destinationGold").show();
                            DynamicForm_Cost.getItem("sourceSilver").show();
                            DynamicForm_Cost.getItem("destinationSilver").show();
                            DynamicForm_Cost.getItem("sourceMolybdenum").hide();
                            DynamicForm_Cost.getItem("destinationMolybdenum").hide();
                        } else if (ListGrid_Shipment_CostHeader.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
                            DynamicForm_Cost.getItem("sourceCopper").hide();
                            DynamicForm_Cost.getItem("destinationCopper").hide();
                            DynamicForm_Cost.getItem("sourceGold").hide();
                            DynamicForm_Cost.getItem("destinationGold").hide();
                            DynamicForm_Cost.getItem("sourceSilver").hide();
                            DynamicForm_Cost.getItem("destinationSilver").hide();
                            DynamicForm_Cost.getItem("sourceMolybdenum").show();
                            DynamicForm_Cost.getItem("destinationMolybdenum").show();
                        } else {
                            DynamicForm_Cost.getItem("sourceCopper").show();
                            DynamicForm_Cost.getItem("destinationCopper").show();
                            DynamicForm_Cost.getItem("sourceGold").hide();
                            DynamicForm_Cost.getItem("destinationGold").hide();
                            DynamicForm_Cost.getItem("sourceSilver").hide();
                            DynamicForm_Cost.getItem("destinationSilver").hide();
                            DynamicForm_Cost.getItem("sourceMolybdenum").hide();
                            DynamicForm_Cost.getItem("destinationMolybdenum").hide();
                        }
                        Window_Cost.animateShow();
                    }
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Cost_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Cost_remove();
                }
            }
        ]
    });
    var RestDataSource_Contact_optionCriteria_inspector = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "inspector", operator: "equals", value: true}]
    };
    var RestDataSource_Contact_optionCriteria_insurancer = {
        _constructor: "AdvancedCriteria",
        operator: "and",
        criteria: [{fieldName: "insurancer", operator: "equals", value: true}]
    };

    var DynamicForm_Cost = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "120",
        titleAlign: "right",
        margin: 10,
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 6,
        //backgroundImage: "backgrounds/leaves.jpg",
        fields:
            [
                {name: "id", hidden: true,},
                {name: "shipmentId", hidden: true,},
       /*         {
                    type: "Header",
                    defaultValue: "بازرسی - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },*/
                {
                    name: "sourceInspectorId",
                    title: "<spring:message code='cost.sourceInspectorId'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_ContactBySourceInspector,
                    optionCriteria: RestDataSource_Contact_optionCriteria_inspector,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", align: "center"},
                        {name: "nameEN", align: "center"}
                    ]
                },
                {
                    name: "sourceInspectionCost",
                    title: "<spring:message		code='cost.sourceInspectionCost'/>",
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
                    name: "sourceInspectionCurrency",
                    title: "<spring:message		code='cost.sourceInspectionCurrency'/>",
                    type: 'text',
                    width: "100%",
                    defaultValue: "USD", valueMap: dollar
                },
                {
                    name: "destinationInspectorId",
                    title: "<spring:message		code='cost.destinationInspectorId'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_ContactByDestinationInspector,
                    optionCriteria: RestDataSource_Contact_optionCriteria_inspector,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [{name: "nameFA", align: "center"}, {
                        name: "nameEN",
                        align: "center"
                    }]
                },
                {
                    name: "destinationInspectionCost",
                    title: "<spring:message		code='cost.destinationInspectionCost'/>",
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
                    name: "destinationInspectionCurrency",
                    title: "<spring:message		code='cost.destinationInspectionCurrency'/>",
                    type: 'text',
                    width: "100%",
                    defaultValue: "USD", valueMap: dollar
                },
                {
                    name: "sarcheshmehLabCost",
                    title: "<spring:message		code='cost.sarcheshmehLabCost'/>",
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
                    name: "umpireCost",
                    title: "<spring:message code='cost.umpireCost'/>",
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
                    name: "umpireCostCurrency",
                    title: "<spring:message		code='cost.umpireCostCurrency'/>",
                    type: 'text',
                    width: "100%",
                    defaultValue: "USD",
                    valueMap: dollar
                },
           /*     {
                    type: "Header",
                    defaultValue: "محتوی - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },*/
                {
                    name: "sourceCopper",
                    title: "<spring:message		code='cost.sourceCopper'/>",
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
                    name: "sourceGold",
                    title: "<spring:message code='cost.sourceGold'/>",
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
                    name: "sourceSilver",
                    title: "<spring:message		code='cost.sourceSilver'/>",
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
                    name: "sourceMolybdenum",
                    title: "<spring:message		code='cost.sourceMolybdenum'/>",
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
                    name: "destinationCopper",
                    title: "<spring:message		code='cost.destinationCopper'/>",
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
                    name: "destinationGold",
                    title: "<spring:message		code='cost.destinationGold'/>",
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
                    name: "destinationSilver",
                    title: "<spring:message		code='cost.destinationSilver'/>",
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
                    name: "destinationMolybdenum",
                    title: "<spring:message		code='cost.destinationMolybdenum'/>",
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
  /*              {
                    type: "Header",
                    defaultValue: "بیمه - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },*/
                {
                    name: "insuranceId",
                    title: "<spring:message		code='cost.insuranceId'/>",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_ContactByInsurance,
                    optionCriteria: RestDataSource_Contact_optionCriteria_insurancer,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",
                    pickListProperties: {showFilterEditor: true}
                    ,
                    pickListFields: [{name: "nameFA", align: "center"}, {
                        name: "nameEN",
                        align: "center"
                    }, {name: "country.nameFa", align: "center"}]
                },
                {
                    name: "insuranceCost",
                    title: "<spring:message		code='cost.insuranceCost'/>",
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
                    name: "insuranceCostCurrency",
                    title: "<spring:message		code='cost.insuranceCostCurrency'/>",
                    type: 'text',
                    width: "100%",
                    defaultValue: "USD", valueMap: dollar
                },
                {
                    name: "insuranceClause",
                    title: "<spring:message		code='cost.insuranceClause'/>",
                    type: 'text',
                    width: "100%",
                    valueMap: {"A": "A", "B": "B", "C": "C"}
                },
      /*          {
                    type: "Header",
                    defaultValue: "سایر - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },*/
                {
                    name: "otherCost",
                    title: "<spring:message code='cost.otherCost'/>",
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
                    name: "otherCostCurrency", title: "<spring:message		code='cost.otherCostCurrency'/>",
                    type: 'text', width: "100%", defaultValue: "USD", valueMap: dollar
                },
                {
                    name: "inventortRentCost",
                    title: "<spring:message		code='cost.inventortRentCost'/>",
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
                    name: "postCost",
                    title: "<spring:message code='cost.postCost'/>",
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
                    name: "thcCost",
                    title: "<spring:message code='cost.thcCost'/>",
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
                    name: "blFeeCost",
                    title: "<spring:message code='cost.blFeeCost'/>",
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
                    name: "demandCost",
                    title: "<spring:message code='cost.demandCost'/>",
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
                    name: "demandCurrency", title: "<spring:message		code='cost.demandCurrency'/>",
                    type: 'text', width: "100%", defaultValue: "USD", valueMap: dollar
                },
                {
                    name: "contractorCost",
                    title: "<spring:message		code='cost.contractorCost'/>",
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
                    name: "counterCost",
                    title: "<spring:message code='cost.counterCost'/>",
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
                    name: "disinfectionCost",
                    title: "<spring:message		code='cost.disinfectionCost'/>",
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
                    name: "portCost",
                    title: "<spring:message code='cost.portCost'/>",
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
            ]
    });

    var ToolStripButton_Cost_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Cost_refresh();
        }
    });

    var ToolStripButton_Cost_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid_Shipment_CostHeader.getSelectedRecord();

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
                DynamicForm_Cost.clearValues();
                DynamicForm_Cost.setValue("shipmentId", record.id);
                if (ListGrid_Shipment_CostHeader.getSelectedRecord().material.descl === 'Copper Concentrate') {
                    DynamicForm_Cost.getItem("sourceCopper").show();
                    DynamicForm_Cost.getItem("destinationCopper").show();
                    DynamicForm_Cost.getItem("sourceGold").show();
                    DynamicForm_Cost.getItem("destinationGold").show();
                    DynamicForm_Cost.getItem("sourceSilver").show();
                    DynamicForm_Cost.getItem("destinationSilver").show();
                    DynamicForm_Cost.getItem("sourceMolybdenum").hide();
                    DynamicForm_Cost.getItem("destinationMolybdenum").hide();
                } else if (ListGrid_Shipment_CostHeader.getSelectedRecord().material.descl === 'Molybdenum Oxide') {
                    DynamicForm_Cost.getItem("sourceCopper").hide();
                    DynamicForm_Cost.getItem("destinationCopper").hide();
                    DynamicForm_Cost.getItem("sourceGold").hide();
                    DynamicForm_Cost.getItem("destinationGold").hide();
                    DynamicForm_Cost.getItem("sourceSilver").hide();
                    DynamicForm_Cost.getItem("destinationSilver").hide();
                    DynamicForm_Cost.getItem("sourceMolybdenum").show();
                    DynamicForm_Cost.getItem("destinationMolybdenum").show();
                } else {
                    DynamicForm_Cost.getItem("sourceCopper").show();
                    DynamicForm_Cost.getItem("destinationCopper").show();
                    DynamicForm_Cost.getItem("sourceGold").hide();
                    DynamicForm_Cost.getItem("destinationGold").hide();
                    DynamicForm_Cost.getItem("sourceSilver").hide();
                    DynamicForm_Cost.getItem("destinationSilver").hide();
                    DynamicForm_Cost.getItem("sourceMolybdenum").hide();
                    DynamicForm_Cost.getItem("destinationMolybdenum").hide();
                }
                Window_Cost.animateShow();
            }
        }
    });

    var ToolStripButton_Cost_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Cost.clearValues();
            ListGrid_Cost_edit();
        }
    });

    var ToolStripButton_Cost_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Cost_remove();
        }
    });

    var ToolStrip_Actions_Cost = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members:
            [
                ToolStripButton_Cost_Add,
                ToolStripButton_Cost_Edit,
                ToolStripButton_Cost_Remove,
                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_Cost_Refresh,
                    ]
                })

            ]
    });

    var HLayout_Cost_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Cost
            ]
    });

    var IButton_Cost_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Cost.validate();
            if (DynamicForm_Cost.hasErrors())
                return;
            var data = DynamicForm_Cost.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/cost/",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (resp) {
                        if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_Cost_refresh();
                            Window_Cost.close();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        }
    });
    var Window_Cost = isc.Window.create({
        title: "<spring:message code='cost.title'/> ",
        width: 870,
        height: 300,
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
                DynamicForm_Cost,
                isc.HLayout.create({
                    width: "100%", align: "center", margin:30, height: "60",
                    members:
                        [
                            IButton_Cost_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                ID: "costEditExitIButton",
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Cost.close();
                                }
                            })
                        ]
                })
            ]
    });
    var ListGrid_Cost = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_Cost,
        contextMenu: Menu_ListGrid_Cost,
        fields:
            [
                {name: "id", hidden: true,},
                {name: "shipmentId", hidden: true,},
                {
                    name: "sourceInspector.nameFA", title: "<spring:message code='cost.sourceInspectorId'/>",
                    type: 'text', width: "10%", align: "center", showHover: true
                },
                {
                    name: "sourceInspectionCost",
                    title: "<spring:message code='cost.sourceInspectionCost'/>",
                    type: 'text',
                    required: true,
                    width: "10%",
                    align: "center",
                    showHover: true
                },
                {
                    name: "sourceInspectionCurrency", title: "<spring:message code='cost.sourceInspectionCurrency'/>",
                    type: 'text', width: "10%", align: "center", showHover: true
                },
                {
                    name: "destinationInspector.nameFA", title: "<spring:message code='cost.destinationInspectorId'/>",
                    type: 'text', width: "10%", align: "center", showHover: true
                },
                {
                    name: "destinationInspectionCost", title: "<spring:message code='cost.destinationInspectionCost'/>",
                    type: 'text',
                    required: true,
                    width: "10%",
                    align: "center",
                    showHover: true
                },
                {
                    name: "destinationInspectionCurrency",
                    title: "<spring:message code='cost.destinationInspectionCurrency'/>",
                    type: 'text',
                    width: "10%",
                    align: "center",
                    showHover: true
                },
                {
                    name: "otherCost", title: "<spring:message code='cost.otherCost'/>",
                    type: 'text', required: true, width: "10%", align: "center", showHover: true
                },
                {
                    name: "otherCostCurrency", title: "<spring:message code='cost.otherCostCurrency'/>",
                    type: 'text', width: "10%", align: "center", showHover: true
                },
                {
                    name: "sarcheshmehLabCost", title: "<spring:message code='cost.sarcheshmehLabCost'/>",
                    type: 'text', required: true, width: "10%", align: "center", showHover: true
                },
                {
                    name: "umpireCost", title: "<spring:message code='cost.umpireCost'/>",
                    type: 'text', required: true, width: "10%", align: "center", showHover: true
                },
                {
                    name: "umpireCostCurrency",
                    title: "<spring:message code='cost.umpireCostCurrency'/>",
                    type: 'text',
                    width: "10%",
                    align: "center",
                    showHover: true
                },
                {
                    name: "sourceGold",
                    title: "<spring:message code='cost.sourceGold'/>",
                    type: 'text',
                    required: true,
                    width: "10%",
                    align: "center",
                    showHover: true
                }
            ],
        sortField: 0,
        autoFetchData: false,
        showFilterEditor: true,
        filterOnKeypress: true,
        recordClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
        updateDetails: function (viewer, record1, recordNum, field, fieldNum, value, rawValue) {
            var record = this.getSelectedRecord();
        },
        dataArrived: function (startRow, endRow) {
        }

    });
    var HLayout_Cost_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Cost
        ]
    });

    var VLayout_Cost_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Cost_Actions, HLayout_Cost_Grid
        ]
    });

    isc.SectionStack.create({
        ID: "Shipment_CostHeader_Section_Stack",
        sections:
            [
                {
                    title: "<spring:message code='Shipment.title'/>",
                    items: VLayout_Body_Shipment_CostHeader,
                    expanded: true
                }
                , {title: "<spring:message code='cost.title'/>", items: VLayout_Cost_Body, expanded: true}
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });
