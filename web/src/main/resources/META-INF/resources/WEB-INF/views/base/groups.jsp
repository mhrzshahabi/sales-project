<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Person_GroupEmail = isc.MyRestDataSource.create(
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
                    name: "contactId"
                },
                {
                    name: "contactnameFA",
                    dataPath: "contact.nameFA"
                },
                {
                    name: "fullName",
                    title: "<spring:message code='person.fullName'/>",
                    type: 'text',
                    required: true,
                    width: 400
                },
                {
                    name: "jobTitle",
                    title: "<spring:message code='person.jobTitle'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "title",
                    title: "<spring:message code='person.title'/>",
                    type: 'text',
                    width: 400,
                    valueMap:
                        {
                            "MR": "<spring:message code='global.MR'/>",
                            "MIS": "<spring:message code='global.MIS'/>",
                            "MS": "<spring:message code='global.MRS'/>",
                        }
                },
                {
                    name: "email",
                    title: "<spring:message code='person.email'/>",
                    type: 'text',
                    required: true,
                    width: 400
                },
                {
                    name: "email1",
                    title: "<spring:message code='person.email1'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "email2",
                    title: "<spring:message code='person.email2'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "webAddress",
                    title: "<spring:message code='person.webAddress'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "phoneNo",
                    title: "<spring:message code='person.phoneNo'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "faxNo",
                    title: "<spring:message code='person.faxNo'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "mobileNo",
                    title: "<spring:message code='person.mobileNo'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "mobileNo1",
                    title: "<spring:message code='person.mobileNo1'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "mobileNo2",
                    title: "<spring:message code='person.mobileNo2'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "whatsApp",
                    title: "<spring:message code='person.whatsApp'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "weChat",
                    title: "<spring:message code='person.weChat'/>",
                    type: 'text',
                    width: 400
                },
                {
                    name: "address",
                    title: "<spring:message code='person.address'/>",
                    type: 'text',
                    width: 400
                },],

            fetchDataURL: "${contextPath}/api/person/spec-list"
        });


    var Menu_ListGrid_Groups = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Groups_refresh();
                }
            },
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Groups.clearValues();
                    Window_Groups.show();
                }
            },
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Groups_edit();
                }
            },
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Groups_remove();
                }
            }
        ]
    });

    var DynamicForm_Groups = isc.DynamicForm.create({
        width: 800,
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 2,

        fields: [
            {name: "id", hidden: true,},
            {type: "RowSpacerItem"},
            {
                name: "groupsName",
                title: "<spring:message code='groups.groupsName'/>",
                type: 'text',
                required: true,
                width: 400
            },
        ]
    });

    var IButton_Groups_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_Groups.validate();
            if (DynamicForm_Groups.hasErrors()) {
                return;
            }
            var data = DynamicForm_Groups.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/groups",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_Groups_refresh();
                            Window_Groups.close();
                        } else {
                            isc.say(RpcResponse_o.data);
                        }
                    }
                })
            );
        }
    });

    var GroupsCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_Groups.close();
        }
    });

    var HLayout_Groups_IButton = isc.HLayout.create({
        layoutMargin: 5,
        membersMargin: 5,
        width: "100%",
        members: [
            IButton_Groups_Save,
            GroupsCancelBtn
        ]
    });

    var Window_Groups = isc.Window.create({
        title: "<spring:message code='groups.title'/>",
        width: 800,
        // height: 500,
        autoSize: true,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        margin: '10px',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items: [
            DynamicForm_Groups,
            HLayout_Groups_IButton
        ]
    });

    function ListGrid_Groups_refresh() {
        ListGrid_Groups.invalidateCache();
    }

    function ListGrid_Groups_remove() {
        var record = ListGrid_Groups.getSelectedRecord();

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

                        var groupsId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/groups/" + groupsId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                        ListGrid_Groups.invalidateCache();
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

    var ToolStripButton_Groups_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Groups_refresh();
        }
    });

    var ToolStripButton_Groups_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Groups.clearValues();
            Window_Groups.show();
        }
    });

    var ToolStripButton_Groups_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Groups.clearValues();
            ListGrid_Groups_edit();
        }
    });


    var ToolStripButton_Groups_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Groups_remove();
        }
    });

    var ToolStrip_Actions_Groups = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_Groups_Add,
            ToolStripButton_Groups_Edit,
            ToolStripButton_Groups_Remove,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Groups_Refresh,
                ]
            })

        ]
    });

    var HLayout_Actions_Groups = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Groups
        ]
    });

    var RestDataSource_Groups = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {
                name: "groupsName",
                title: "<spring:message code='groups.groupsName'/>",
                type: 'text',
                required: true,
                width: 400
            },
        ],

        fetchDataURL: "${contextPath}/api/groups/spec-list"
    });

    var ListGrid_Groups = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Groups,
            contextMenu: Menu_ListGrid_Groups,
            canDragRecordsOut: true,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "groupsName",
                    title: "<spring:message code='groups.groupsName'/>",
                    type: 'text',
                    required: true,
                    width: 400
                }, ],
            sortField: 0,
            autoFetchData: true,
            showFilterEditor: true,
            filterOnKeypress: true,

            recordDoubleClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
            updateDetails: function(viewer, record1, recordNum, field, fieldNum, value, rawValue)
            {
                var record = this.getSelectedRecord();
                var criteria = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [
                        {
                            fieldName: "groupsId",
                            operator: "equals",
                            value: record.id
                        }]
                };
                ListGrid_GroupsPerson.fetchData(criteria, function(dsResponse, data, dsRequest)
                    {
                        ListGrid_GroupsPerson.setData(data);
                    },
                    {
                        operationId: "00"
                    });
            },
            dataArrived: function(startRow, endRow) {}
        });

    var HLayout_Grid_Groups = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Groups
        ]
    });

    var VLayout_Body_Groups = isc.VLayout.create({
        width: "25%",
        height: "100%",
        members: [
            HLayout_Actions_Groups, HLayout_Grid_Groups
        ]
    });


    var Menu_ListGrid_Person_GroupEmail = isc.Menu.create({
        width: 150,
        data:
            [
                {
                    title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_Person_GroupEmail_refresh();
                    }
                }
            ]
    });

    function ListGrid_Person_GroupEmail_refresh() {
        ListGrid_Person_GroupEmail.invalidateCache();
    }

    var ToolStripButton_Person_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Person_GroupEmail_refresh();
        }
    });

    var ToolStrip_Actions_Person = isc.ToolStrip.create({
        width: "100%",
        members: [
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_Person_Refresh
                ]
            })

        ]
    });

    var HLayout_Actions_Person = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_Person
        ]
    });

    var ListGrid_Person_GroupEmail = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Person_GroupEmail,
            contextMenu: Menu_ListGrid_Person_GroupEmail,
            canDragRecordsOut: true,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "contactnameFA",
                    dataPath: "contact.nameFA",
                    title: "<spring:message code='contact.name'/>",
                    type: 'long',
                    width: "10%",
                    align: "center"
                },
                {
                    name: "fullName",
                    title: "<spring:message code='person.fullName'/>",
                    type: 'text',
                    required: true,
                    width: "10%"
                },
                {
                    name: "jobTitle",
                    title: "<spring:message code='person.jobTitle'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "title",
                    title: "<spring:message code='person.title'/>",
                    type: 'text',
                    width: "10%",
                    valueMap:
                        {
                            "MR": "<spring:message code='global.MR'/>",
                            "MIS": "<spring:message code='global.MIS'/>",
                            "MS": "<spring:message code='global.MRS'/>",
                        }
                },
                {
                    name: "email",
                    title: "<spring:message code='person.email'/>",
                    type: 'text',
                    required: true,
                    width: "10%"
                },
                {
                    name: "email1",
                    title: "<spring:message code='person.email1'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "email2",
                    title: "<spring:message code='person.email2'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "phoneNo",
                    title: "<spring:message code='person.phoneNo'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "mobileNo",
                    title: "<spring:message code='person.mobileNo'/>",
                    type: 'text',
                    width: "10%"
                },
                {
                    name: "mobileNo1",
                    title: "<spring:message code='person.mobileNo1'/>",
                    type: 'text',
                    width: "10%"
                }],
            sortField: 0,
            autoFetchData: true,
            showFilterEditor: true,
            filterOnKeypress: true,
            recordDoubleClick: "this.updateDetails(viewer, record, recordNum, field, fieldNum, value, rawValue)",
            updateDetails: function(viewer, record1, recordNum, field, fieldNum, value, rawValue)
            {
                var record = this.getSelectedRecord();
                var criteria = {
                    _constructor: "AdvancedCriteria",
                    operator: "and",
                    criteria: [
                        {
                            fieldName: "personId",
                            operator: "equals",
                            value: record.id
                        }]
                };
                ListGrid_GroupsPerson.fetchData(criteria, function(dsResponse, data, dsRequest)
                    {
                        ListGrid_GroupsPerson.setData(data);
                    },
                    {
                        operationId: "00"
                    });
            },
            dataArrived: function(startRow, endRow) {}
        });


    var HLayout_Grid_Person = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Person_GroupEmail
        ]
    });

    var VLayout_Body_Person = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Actions_Person, HLayout_Grid_Person
        ]
    });

    var HLayout_2Vlayout_GroupsPerson = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            VLayout_Body_Groups, VLayout_Body_Person
        ]
    });

    var Menu_ListGrid_GroupsPerson = isc.Menu.create({
        width: 150,
        data:
            [
                {
                    title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_GroupsPerson_refresh();
                    }
                },
                {
                    title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                    click: function () {
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
                            DynamicForm_GroupsPerson.clearValues();
                            DynamicForm_GroupsPerson.setValue("groupsId", record.id);
                            Window_GroupsPerson.show();
                        }
                    }
                },
                {
                    title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_GroupsPerson_edit();
                    }
                },
                {
                    title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_GroupsPerson_remove();
                    }
                }
            ]
    });
    var DynamicForm_GroupsPerson = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100",
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true,},
                // {type: "RowSpacerItem"},
                {name: "groupsId", type: "long", hidden: true},
                // {type: "RowSpacerItem"},
                {
                    name: "personId",
                    title: "<spring:message code='person.fullName'/>",
                    type: 'long',
                    width: 400,
                    required: true,
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Person_GroupEmail,
                    displayField: "fullName",
                    valueField: "id",
                    pickListWidth: 500,
                    pickListHeight: 500,
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [{name: "id", width: 50, align: "center"}, {
                        name: "fullName",
                        width: 150,
                        align: "center"
                    }, {name: "contactnameFA", width: 150, align: "center", dataPath: "contact.nameFA"}, {
                        name: "email",
                        width: 150,
                        align: "center"
                    }]
                }
            ]
    });

    var IButton_GroupsPerson_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_GroupsPerson.validate();
            if (DynamicForm_GroupsPerson.hasErrors()) {
                return;
            }
            var data = DynamicForm_GroupsPerson.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/groupsPerson",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_GroupsPerson_refresh();
                            Window_GroupsPerson.close();
                        } else {
                            isc.say(RpcResponse_o.data);
                        }
                    }
                })
            );
        }
    });

    var GroupsPersonCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_GroupsPerson.close();
        }
    });

    var HLayout_GroupsPerson_IButton = isc.HLayout.create({
        layoutMargin: 5,
        membersMargin: 5,
        width: "100%",
        members: [
            IButton_GroupsPerson_Save,
            GroupsPersonCancelBtn
        ]
    });



    var GroupPersonHeaderForm = isc.DynamicForm.create({
        align: "center",
        width: 800,
        height: "100%",
        titleWidth: "100%",
        titleAlign: "right",
        numCols: 1,
        fields: [
            {name: "id", type: "hidden", title: ""},
            {
                name: "groupsName",
                type: "staticText",
                title: "<spring:message code='group.name'/>",
                wrapTitle: false,
                width: 400
            }
        ]
    });

    function setGroupPersonHeaderFormData(record) {
        GroupPersonHeaderForm.setValue("id", record.groups.id);
        GroupPersonHeaderForm.setValue("groupsName", record.groups.groupsName);
    };

    var GroupPersonHeaderVLayout = isc.VLayout.create({
        autoDraw: false,
        align: "center",
        width: 800,
        members: [
            GroupPersonHeaderForm,
            DynamicForm_GroupsPerson

        ]
    });




    var Window_GroupsPerson = isc.Window.create({
        title: "<spring:message code='groupsPerson.title'/>",
        width: 800,
        height: 300,
        autoSize: false,
        autoCenter: true,
        isModal: true,
        showModalMask: true,
        align: "center",
        autoDraw: false,
        dismissOnEscape: true,
        overflow: 'hidden',
        closeClick: function () {
            this.Super("closeClick", arguments)
        },
        items:
            [
                GroupPersonHeaderVLayout,
                HLayout_GroupsPerson_IButton
            ]
    });

    function ListGrid_GroupsPerson_refresh() {
        ListGrid_GroupsPerson.invalidateCache();
        ListGrid_GroupsPerson.fetchData(function (dsResponse, data, dsRequest) {
            ListGrid_GroupsPerson.setData(data);
        }, {operationId: "00"});
    }

    function ListGrid_GroupsPerson_remove() {
        var record = ListGrid_GroupsPerson.getSelectedRecord();
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
                        var groupsPersonId = record.id;
                        isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                                actionURL: "${contextPath}/api/groupsPerson/" + groupsPersonId,
                                httpMethod: "DELETE",
                                callback: function (RpcResponse_o) {
                                    if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                                        ListGrid_GroupsPerson.invalidateCache();
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

    function ListGrid_GroupsPerson_edit() {

        var record = ListGrid_GroupsPerson.getSelectedRecord();
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
            DynamicForm_GroupsPerson.editRecord(record);
            setGroupPersonHeaderFormData(record);
            Window_GroupsPerson.show();
        }
    }

    var ToolStripButton_GroupsPerson_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_GroupsPerson_refresh();
        }
    });

    var ToolStripButton_GroupsPerson_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            var record = ListGrid.getSelectedRecord();

            if (record == null || record.id == null) {
                isc.Dialog.create({
                    message: "<spring:message code='group.record.notSelected'/>",
                    icon: "[SKIN]ask.png",
                    title: "<spring:message code='global.message'/>",
                    buttons: [isc.Button.create({title: "<spring:message code='global.ok'/>"})],
                    buttonClick: function () {
                        this.hide();
                    }
                });
            } else {
                DynamicForm_GroupsPerson.clearValues();
                DynamicForm_GroupsPerson.setValue("groupsId", record.id);
                DynamicForm_GroupsPerson.setValue("groupsName", record.groupsName);
                GroupPersonHeaderForm.setValue("id", record.id);
                GroupPersonHeaderForm.setValue("groupsName", record.groupsName);

                Window_GroupsPerson.show();
            }
        }
    });

    var ToolStripButton_GroupsPerson_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_GroupsPerson.clearValues();
            ListGrid_GroupsPerson_edit();
        }
    });
    var ToolStripButton_GroupsPerson_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_GroupsPerson_remove();
        }
    });

    var ToolStrip_Actions_GroupsPerson = isc.ToolStrip.create({
        width: "100%",
        members: [
            ToolStripButton_GroupsPerson_Add,
            ToolStripButton_GroupsPerson_Edit,
            ToolStripButton_GroupsPerson_Remove,
            isc.ToolStrip.create({
                width: "100%",
                align: "left",
                border: '0px',
                members: [
                    ToolStripButton_GroupsPerson_Refresh,
                ]
            })

        ]
    });
    var HLayout_Actions_GroupsPerson = isc.HLayout.create({
        width: "100%",
        members: [
            ToolStrip_Actions_GroupsPerson
        ]
    });
    var RestDataSource_GroupsPerson = isc.MyRestDataSource.create({
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {
                name: "groupsId",
                title: "<spring:message code='groups.groupsName'/>",
                type: 'text',
                required: true,
                width: 400,
                hidden: true
            },
            {
                name: "groupsgroupsName", dataPath: "groups.groupsName",
                title: "<spring:message code='groups.groupsName'/>",
                type: 'text',
                required: true,
                width: 400
            },
            {
                name: "personid", dataPath: "person.id",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                required: true,
                width: 400,
                hidden: true
            },
            {
                name: "personfullName", dataPath: "person.fullName",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                required: true,
                width: 400
            },
            {
                name: "personjobTitle",
                title: "<spring:message code='person.jobTitle'/>",
                type: 'text',
                width: 150,
                dataPath: "person.jobTitle"
            },
            {
                name: "persontitle", dataPath: "person.title",
                title: "<spring:message code='person.title'/>",
                type: 'text',
                width: 150,
                valueMap: {
                    "MR": "<spring:message code='global.MR'/>",
                    "MIS": "<spring:message code='global.MIS'/>",
                    "MS": "<spring:message code='global.MRS'/>",
                }
            },
            {
                name: "personemail", dataPath: "person.email",
                title: "<spring:message code='person.email'/>",
                type: 'text',
                required: true,
                width: 150
            },
            {
                name: "personemail1",
                title: "<spring:message code='person.email1'/>",
                type: 'text',
                width: 150,
                dataPath: "person.email1"
            },
            {
                name: "personemail2",
                title: "<spring:message code='person.email2'/>",
                type: 'text',
                width: 150,
                dataPath: "person.email2"
            },
            {
                name: "personwebAddress", dataPath: "person.webAddress",
                title: "<spring:message code='person.webAddress'/>",
                type: 'text',
                width: 150
            },
            {
                name: "personphoneNo",
                title: "<spring:message code='person.phoneNo'/>",
                type: 'text',
                width: 150,
                dataPath: "person.phoneNo"
            },
            {
                name: "personfaxNo",
                title: "<spring:message code='person.faxNo'/>",
                type: 'text',
                width: 150,
                dataPath: "person.faxNo"
            },
            {
                name: "personmobileNo",
                title: "<spring:message code='person.mobileNo'/>",
                type: 'text',
                width: 150,
                dataPath: "person.mobileNo"
            },
            {
                name: "personmobileNo1",
                title: "<spring:message code='person.mobileNo1'/>",
                type: 'text',
                width: 150,
                dataPath: "person.mobileNo1"
            },
            {
                name: "personmobileNo2",
                title: "<spring:message code='person.mobileNo2'/>",
                type: 'text',
                width: 150,
                dataPath: "person.mobileNo2"
            },
            {
                name: "personwhatsApp",
                title: "<spring:message code='person.whatsApp'/>",
                type: 'text',
                width: 150,
                dataPath: "person.whatsApp"
            },
            {
                name: "personweChat",
                title: "<spring:message code='person.weChat'/>",
                type: 'text',
                width: 150,
                dataPath: "person.weChat"
            },
            {
                name: "personaddress",
                title: "<spring:message code='person.address'/>",
                type: 'text',
                width: 150,
                dataPath: "person.address"
            },
        ],

        fetchDataURL: "${contextPath}/api/groupsPerson/spec-list"
    });
    var ListGrid_GroupsPerson = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_GroupsPerson,
        contextMenu: Menu_ListGrid_GroupsPerson,
        canAcceptDroppedRecords: true,
        addDropValues: true,
        recordDrop: function (dropRecords, targetRecord, index, sourceWidget) {
            if (this === sourceWidget)
                return;
            if (dropRecords.length > 1)
                return;

            if (ListGrid_Groups.getSelectedRecord() == null || ListGrid_Groups.getSelectedRecord().id == null) {
                isc.say("<spring:message code='group.record.notSelected'/>");
                return;
            }
            if (ListGrid_Person_GroupEmail.getSelectedRecord() == null || ListGrid_Person_GroupEmail.getSelectedRecord().id == null) {
                isc.say("<spring:message code='contact.record.notSelected'/>");
                return;
            }

            DynamicForm_GroupsPerson.clearValues();
            DynamicForm_GroupsPerson.setValue("groupsId", ListGrid_Groups.getSelectedRecord().id);
            DynamicForm_GroupsPerson.setValue("personId", ListGrid_Person_GroupEmail.getSelectedRecord().id);
            var data = DynamicForm_GroupsPerson.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                    actionURL: "${contextPath}/api/groupsPerson",
                    httpMethod: method,
                    data: JSON.stringify(data),
                    callback: function (RpcResponse_o) {
                        if (RpcResponse_o.httpResponseCode === 200 || RpcResponse_o.httpResponseCode === 201) {
                            isc.say("<spring:message code='global.form.request.successful'/>");
                            ListGrid_GroupsPerson_refresh();
                        } else
                            isc.say(RpcResponse_o.data);
                    }
                })
            );
        },
        fields: [
            {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},
            {
                name: "groupsid", dataPath: "groups.id",
                title: "<spring:message code='groups.groupsName'/>",
                type: 'text',
                required: true,
                width: "10%",
                hidden: true
            },
            {
                name: "groupsgroupsName", dataPath: "groups.groupsName",
                title: "<spring:message code='groups.groupsName'/>",
                type: 'text',
                required: true,
                width: "10%"
            },
            {
                name: "personid", dataPath: "person.id",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                required: true,
                width: "10%",
                hidden: true
            },
            {
                name: "personfullName", dataPath: "person.fullName",
                title: "<spring:message code='person.fullName'/>",
                type: 'text',
                required: true,
                width: "10%"
            },
            {
                name: "personjobTitle",
                title: "<spring:message code='person.jobTitle'/>",
                type: 'text',
                width: 150,
                dataPath: "person.jobTitle"
            },
            {
                name: "persontitle", dataPath: "person.title",
                title: "<spring:message code='person.title'/>",
                type: 'text',
                width: "10%",
                valueMap: {
                    "MR": "<spring:message code='global.MR'/>",
                    "MIS": "<spring:message code='global.MIS'/>",
                    "MS": "<spring:message code='global.MRS'/>",
                }
            },
            {
                name: "personemail", dataPath: "person.email",
                title: "<spring:message code='person.email'/>",
                type: 'text',
                required: true,
                width: "10%"
            },
            {
                name: "personemail1",
                title: "<spring:message code='person.email1'/>",
                type: 'text',
                width: "10%",
                dataPath: "person.email1",
            },
            {
                name: "personemail2",
                title: "<spring:message code='person.email2'/>",
                type: 'text',
                width: "10%",
                dataPath: "person.email2",
            },
            {
                name: "personwebAddress", dataPath: "person.webAddress",
                title: "<spring:message code='person.webAddress'/>",
                type: 'text',
                width: "10%"
            },
            {
                name: "personmobileNo",
                title: "<spring:message code='person.mobileNo'/>",
                type: 'text',
                width: "10%",
                dataPath: "person.mobileNo"
            },
            {
                name: "personmobileNo1",
                title: "<spring:message code='person.mobileNo1'/>",
                type: 'text',
                width: "10%",
                dataPath: "person.mobileNo1"
            },
            {
                name: "personmobileNo2",
                title: "<spring:message code='person.mobileNo2'/>",
                type: 'text',
                width: "10%",
                dataPath: "person.mobileNo2"
            }
        ],
        sortField: 0,
        autoFetchData: true,
        showFilterEditor: true,
        filterOnKeypress: true
    });
    var HLayout_Grid_GroupsPerson = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_GroupsPerson
        ]
    });

    var VLayout_Body_GroupsPerson = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Actions_GroupsPerson, HLayout_Grid_GroupsPerson
        ]
    });

    isc.SectionStack.create({
        ID: "Groups_Section_Stack",
        sections:
            [
                {
                    title: "<spring:message code='groups.title'/>",
                    items: HLayout_2Vlayout_GroupsPerson,
                    expanded: true
                },
                {
                    title: "<spring:message code='groupsPerson.title'/>",
                    items: VLayout_Body_GroupsPerson,
                    expanded: true
                }
            ],
        visibilityMode: "multiple",
        animateSections: true,
        height: "100%",
        width: "100%",
        overflow: "hidden"
    });