<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    function ListGrid_Instruction_refresh() {
        ListGrid_Instruction.invalidateCache();
    }

    function ListGrid_Instruction_edit() {
        var record = ListGrid_Instruction.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/>"
                        })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
        }
        else {
            DynamicForm_Instruction.editRecord(record);
            DynamicForm_Instruction.setValue("disableDate", new Date(record.disableDate));
            DynamicForm_Instruction.setValue("runDate", new Date(record.runDate));
            Window_Instruction.show();
        }
    }

    function ListGrid_Instruction_remove() {
        var record = ListGrid_Instruction.getSelectedRecord();

        if (record == null || record.id == null) {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.not.selected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create(
                        {
                            title: "<spring:message code='global.ok'/>"
                        })],
                    buttonClick: function () {
                        this.hide();
                    }
                });
        }
        else {
            isc.Dialog.create(
                {
                    message: "<spring:message code='global.grid.record.remove.ask'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.grid.record.remove.ask.title'/>",
                    buttons: [
                        isc.IButtonSave.create(
                            {
                                title: "<spring:message code='global.yes'/>"
                            }),
                        isc.IButtonCancel.create(
                            {
                                title: "<spring:message code='global.no'/>"
                            })
                    ],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var InstructionId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/instruction/" + InstructionId,
                                    httpMethod: "DELETE",
                                    callback: function (RpcResponse_o) {
                                        if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                            ListGrid_Instruction_refresh();
                                            isc.say("<spring:message code='global.grid.record.remove.success'/>");
                                        }
                                        else {
                                            isc.say("<spring:message code='global.grid.record.remove.failed'/>");
                                        }
                                    }
                                }));
                        }
                    }
                });
        }
    }

    var Menu_ListGrid_Instruction = isc.Menu.create(
        {
            width: 150,
            data: [
                {
                    title: "<spring:message code='global.form.refresh'/>",
                    icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_Instruction_refresh();
                    }
                },
                <sec:authorize access="hasAuthority('C_INSTRUCTION')">
                {
                    title: "<spring:message code='global.form.new'/>",
                    icon: "pieces/16/icon_add.png",
                    click: function () {
                        DynamicForm_Instruction.clearValues();
                        Window_Instruction.show();
                    }
                },
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_INSTRUCTION')">
                {
                    title: "<spring:message code='global.form.edit'/>",
                    icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_Instruction_edit();
                    }
                },
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_INSTRUCTION')">
                {
                    title: "<spring:message code='global.form.remove'/>",
                    icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_Instruction_remove();
                    }
                }
                </sec:authorize>
            ]
        });

    var DynamicForm_Instruction = isc.DynamicForm.create(
        {
            width: 650,
            height: 100,
            titleWidth: "100",
            numCols: 2,
            fields: [
                {
                    name: "id",
                    hidden: true
                },
                {
                    type: "RowSpacerItem"
                },
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "titleInstruction",
                    title: "<spring:message code='instruction.titleInstruction'/>",
                    width: 400,
                    align: "center",
                    required: true, errorOrientation: "bottom",
                    length: "4000",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "disableDate",
                    title: "<spring:message code='instruction.disableDate'/>",
                    width: 400,
                    align: "center",
                    type: "date"
                },
                {
                    name: "runDate",
                    title: "<spring:message code='instruction.runDate'/>",
                    width: 400,
                    align: "center",
                    type: "date"
                },
                {
                    type: "RowSpacerItem"
                }]
        });

    var ToolStripButton_Instruction_Refresh = isc.ToolStripButtonRefresh.create(
        {
            title: "<spring:message code='global.form.refresh'/>",
            click: function () {
                ListGrid_Instruction_refresh();
            }
        });

    <sec:authorize access="hasAuthority('C_INSTRUCTION')">
    var ToolStripButton_Instruction_Add = isc.ToolStripButtonAdd.create(
        {
            title: "<spring:message code='global.form.new'/>",
            click: function () {
                DynamicForm_Instruction.clearValues();
                Window_Instruction.show();
            }
        });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_INSTRUCTION')">
    var ToolStripButton_Instruction_Edit = isc.ToolStripButtonEdit.create(
        {
            icon: "[SKIN]/actions/edit.png",
            title: "<spring:message code='global.form.edit'/>",
            click: function () {
                DynamicForm_Instruction.clearValues();
                ListGrid_Instruction_edit();
            }
        });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_INSTRUCTION')">
    var ToolStripButton_Instruction_Remove = isc.ToolStripButtonRemove.create(
        {
            icon: "[SKIN]/actions/remove.png",
            title: "<spring:message code='global.form.remove'/>",
            click: function () {
                ListGrid_Instruction_remove();
            }
        });
    </sec:authorize>

    var ToolStrip_Actions_Instruction = isc.ToolStrip.create(
        {
            width: "100%",
            members: [
                <sec:authorize access="hasAuthority('C_INSTRUCTION')">
                ToolStripButton_Instruction_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_INSTRUCTION')">
                ToolStripButton_Instruction_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_INSTRUCTION')">
                ToolStripButton_Instruction_Remove,
                </sec:authorize>

                isc.ToolStrip.create(
                    {
                        width: "100%",
                        align: "left",
                        border: '0px',
                        members: [
                            ToolStripButton_Instruction_Refresh,
                        ]
                    })

            ]
        });

    var HLayout_Instruction_Actions = isc.HLayout.create(
        {
            width: "100%",
            members: [
                ToolStrip_Actions_Instruction
            ]
        });

    var RestDataSource_Instruction = isc.MyRestDataSource.create(
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
                    name: "titleInstruction",
                    title: "<spring:message code='instruction.titleInstruction'/>",
                    width: 400
                },
                {
                    name: "disableDate",
                    title: "<spring:message code='instruction.disableDate'/>",
                    width: 400
                },
                {
                    name: "runDate",
                    title: "<spring:message code='instruction.runDate'/>",
                    width: 400
                }],
            fetchDataURL: "${contextPath}/api/instruction/spec-list"
        });


    var IButton_Instruction_Save = isc.IButtonSave.create(
        {
            top: 260,
            layoutMargin: 5,
            membersMargin: 5,
            width: 120,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {
                DynamicForm_Instruction.validate();
                if (DynamicForm_Instruction.hasErrors())
                    return;
                DynamicForm_Instruction.setValue("disableDate", DynamicForm_Instruction.getValue("disableDate").toNormalDate("toUSShortDate"));
                DynamicForm_Instruction.setValue("runDate", DynamicForm_Instruction.getValue("runDate").toNormalDate("toUSShortDate"));

                var data = DynamicForm_Instruction.getValues();
                var methodXXXX = "PUT";
                if (data.id == null) methodXXXX = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/instruction/",
                        httpMethod: methodXXXX,
                        data: JSON.stringify(data),
                        callback: function (RpcResponse_o) {
                            if (RpcResponse_o.httpResponseCode == 200 || RpcResponse_o.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_Instruction_refresh();
                                Window_Instruction.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        }
                    }));
            }
        });

    var InstructionCancelBtn = isc.IButtonCancel.create(
        {
            top: 260,
            layoutMargin: 5,
            membersMargin: 5,
            width: 120,
            title: "<spring:message code='global.cancel'/>",
            icon: "pieces/16/icon_delete.png",
            click: function () {
                Window_Instruction.close();
            }
        });

    var HLayout_Instruction_IButton = isc.HLayout.create(
        {
            width: 650,
            height: "100%",
            layoutMargin: 10,
            membersMargin: 5,
            textAlign: "center",
            align: "center",
            members: [
                IButton_Instruction_Save,
                InstructionCancelBtn
            ]
        });

        var VLayout_saveButton_instruction = isc.VLayout.create({
        width: 650,
        textAlign: "center",
        align: "center",
        members: [
        HLayout_Instruction_IButton
        ]
    });

    var Window_Instruction = isc.Window.create({
        title: "<spring:message code='instruction.title'/> ",
        width: 580,
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
                DynamicForm_Instruction,
                VLayout_saveButton_instruction
            ]
    });

    var ListGrid_Instruction = isc.ListGrid.create(
        {
            showFilterEditor: true,
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Instruction,
            contextMenu: Menu_ListGrid_Instruction,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "titleInstruction",
                    title: "<spring:message code='instruction.titleInstruction'/>",
                    width: "50%",
                    align: "center"
                },
                {
                    name: "disableDate",
                    title: "<spring:message code='instruction.disableDate'/>",
                    width: "20%",
                    align: "center"
                },
                {
                    name: "runDate",
                    title: "<spring:message code='instruction.runDate'/>",
                    width: "20%",
                    align: "center"
                }],
            autoFetchData: true
        });

    var HLayout_Instruction_Grid = isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                ListGrid_Instruction
            ]
        });

    var VLayout_Instruction_Body = isc.VLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                HLayout_Instruction_Actions, HLayout_Instruction_Grid
            ]
        });

    isc.ViewLoader.create(
        {
            ID: "InstructionAttachmentViewLoader",
            autoDraw: false,
            loadingMessage: ""
        });

    isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            border: "1px solid black",
            layoutTopMargin: 5,
            members: [
                isc.TabSet.create(

                    {
                        tabBarPosition: "top",
                        width: "100%",
                        tabs: [
                            {
                                title: "<spring:message code='instruction.title'/>",
                                pane: VLayout_Instruction_Body ,
                                name:"ttt",
                            },
                            {
                                title: "<spring:message code='global.Attachment'/>",
                                pane: InstructionAttachmentViewLoader,
                                name: "titleInstruction_ins",
                                tabSelected: function (form, item, value) {
                                    var record = ListGrid_Instruction.getSelectedRecord();

                                    if (record == null || record.id == null) {
                                        isc.Dialog.create(
                                            {
                                                message: "<spring:message code='global.grid.record.not.selected'/>",
                                                icon: "[SKIN]ask.png",
                                                title: "<spring:message code='global.message'/>",
                                                buttons: [isc.Button.create(
                                                    {
                                                        title: "<spring:message code='global.ok'/>"
                                                    })],
                                                buttonClick: function () {
                                                    this.hide();
                                                }
                                            });
                                        record.id = null;
                                    }
                                    var dccTableId = record.id;
                                    var dccTableName = "TBL_INSTRUCTION";
                                    var titleInstruction_tab = ListGrid_Instruction.getSelectedRecord().titleInstruction;
                                     this.setTabTitle("titleInstruction_ins" , titleInstruction_tab);
                                    InstructionAttachmentViewLoader.setViewURL("dcc/showForm/" + dccTableName + "/" + dccTableId)
                                }
                            }]
                    })
            ]
        });