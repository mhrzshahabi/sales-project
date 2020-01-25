//<script>
    <%@ page contentType="text/html;charset=UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    var RestDataSource_Contract_In_ContractPerson = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, hidden: true},
                {name: "contractNo", title: "<spring:message code='contract.contractNo'/>"}
            ],
        fetchDataURL: "${contextPath}/api/contract/spec-list"
    });

    var RestDataSource_Person_In_ContractPerson = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {
                name: "contact.nameFA", type: 'text', title: "<spring:message code='contact.nameFa'/>",
                sortNormalizer: function (recordObject) {
                    return recordObject.contact.nameFA;
                }
            },
            {
                name: "fullName",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                width: 400
            }
        ],

        fetchDataURL: "${contextPath}/api/person/spec-list"
    });

    var RestDataSource_ContractPerson = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {
                name: "contract.contractNo", title: "<spring:message code='contract.contractNo'/>", type: "text",
                sortNormalizer: function (recordObject) {
                    return recordObject.contract.contractNo;
                }
            },
            {
                name: "person.fullName", title: "<spring:message code='person.fullName'/>", type: "text",
                sortNormalizer: function (recordObject) {
                    return recordObject.person.fullName;
                }
            }
        ],
        fetchDataURL: "${contextPath}/api/contractPerson/spec-list"
    });

    var ListGrid_ContractPerson = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ContractPerson,
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true,
    });

    var HLayout_Grid_ContractPerson = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ContractPerson
        ]
    });

    var ToolStripButton_ContractPerson_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ContractPerson_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_CONTRACT_PERSON')">
    var ToolStripButton_ContractPerson_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            ListGrid_ContractPerson_add();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_CONTRACT_PERSON')">
    var ToolStripButton_ContractPerson_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ContractPerson_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_CONTRACT_PERSON')">
    var ToolStripButton_ContractPerson_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ContractPerson_remove();
        }
    });
    </sec:authorize>

    function ListGrid_ContractPerson_remove() {
        var record = ListGrid_ContractPerson.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>.",
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
                buttons: [isc.IButtonSave.create({title: "<spring:message code='global.yes'/>"}), isc.IButtonCancel.create({
                    title: "<spring:message	code='global.no'/>"
                })],
                buttonClick: function (button, index) {
                    this.hide();
                    if (index === 0) {
                        var contractPersonId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/contractPerson/" + contractPersonId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                        ListGrid_ContractPerson.invalidateCache();
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

    function ListGrid_Groups_edit() {
        var record = ListGrid_Groups.getSelectedRecord();

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
            DynamicForm_Groups.editRecord(record);
            Window_Groups.show();
        }
    }

    var DynamicForm_ContractPerson = isc.DynamicForm.create({
        width:"500",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "bottom",
        titleWidth: "300",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 2,
        fields: [
            {name: "id", hidden: true},
            {
                name: "contractId",
                title: "<spring:message code='contract.contractNo'/>",
                type: 'text',
                required: true,
                width: "370",
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Contract_In_ContractPerson,
                displayField: "contractNo",
                valueField: "id",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {
                        name: "contractNo",
                        width: "10%",
                        align: "center"
                    }
                ]
            },
            {
                name: "personId",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                width: "370",
                required: true,
                editorType: "SelectItem",
                optionDataSource: RestDataSource_Person_In_ContractPerson,
                displayField: "fullName",
                valueField: "id",
                pickListProperties: {showFilterEditor: true},
                pickListFields: [
                    {
                        name: "contact.nameFA",
                        width: "10%",
                        align: "center"
                    },
                    {
                        name: "fullName",
                        width: "10%",
                        align: "center"
                    }
                ]
            }
        ]
    });

    var ContractPersonCancelBtn = isc.IButtonCancel.create({
        width: 120,
        layoutMargin: 5,
        membersMargin: 5,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_ContractPerson.close();
        }
    });

    var IButton_ContractPerson_Save = isc.IButtonSave.create({
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_ContractPerson.validate();
            if (DynamicForm_ContractPerson.hasErrors()) {
                return;
            }

            var data = DynamicForm_ContractPerson.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/contractPerson",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_ContractPerson_refresh();
                            Window_ContractPerson.close();
                        } else {
                            isc.say(RpcResponse_o.data);
                        }
                    }
                })
            );
        }
    });

    var HLayout_ContractPerson_IButton = isc.HLayout.create({
        width: "100%",
        layoutMargin: 5,
        membersMargin: 5,
        members: [
            IButton_ContractPerson_Save,
            ContractPersonCancelBtn
        ]
    });

    var Window_ContractPerson = isc.Window.create({
        width:"200",
        title: "<spring:message code='contractPerson.title'/>",
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
        items: [
            DynamicForm_ContractPerson,
            HLayout_ContractPerson_IButton
        ]
    });

    var ToolStrip_Actions_ContractPerson = isc.ToolStrip.create({
        width: "100%",
        membersMargin: 5,
        members: [
            <sec:authorize access="hasAuthority('C_CONTRACT_PERSON')">
            ToolStripButton_ContractPerson_Add,
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_CONTRACT_PERSON')">
            ToolStripButton_ContractPerson_Edit,
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_CONTRACT_PERSON')">
            ToolStripButton_ContractPerson_Remove,
            </sec:authorize>

            isc.ToolStrip.create({
            width: "100%",
            align: "left",
            border: '0px',
            members: [
                    ToolStripButton_ContractPerson_Refresh,
            ]
            })

        ]
    });

    function ListGrid_ContractPerson_refresh() {
        ListGrid_ContractPerson.invalidateCache();
    }

    function ListGrid_ContractPerson_add() {
        DynamicForm_ContractPerson.clearValues();
        Window_ContractPerson.show();
    }

    function ListGrid_ContractPerson_edit() {
        var record = ListGrid_ContractPerson.getSelectedRecord();

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
            DynamicForm_ContractPerson.clearValues();
            DynamicForm_ContractPerson.editRecord(record);
            Window_ContractPerson.show();
        }
    }

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ToolStrip_Actions_ContractPerson, HLayout_Grid_ContractPerson
        ]
    });