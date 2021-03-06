<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Bank = isc.MyRestDataSource.create(
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
                    name: "bankCode",
                    title: "<spring:message code='bank.bankCode'/>",
                    width: 200
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='bank.nameFa'/>",
                    width: 200
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='bank.nameEn'/>",
                    width: 200
                },
                {
                    name: "address",
                    title: "<spring:message code='bank.address'/>",
                    width: 200
                },
                {
                    name: "coreBranch",
                    title: "<spring:message code='bank.coreBranch'/>",
                    width: 200
                },
                {
                    name: "country.name",
                    title: "<spring:message code='country'/>",
                    width: 200,
                    sortNormalizer: function (recordObject) {
                        return recordObject.country.name;
                    }
                }],
            fetchDataURL: "${contextPath}/api/bank/spec-list"
        });


    var RestDataSource_Country_IN_BANK = isc.MyRestDataSource.create(
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
                    name: "nameFA",
                    title: "<spring:message code='country.nameFa'/>",
                    width: 200
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='country.nameEn'/>",
                    width: 200
                },
                {
                    name: "isActive",
                    title: "<spring:message code='country.isActive'/>",
                    width: 200
                }],
            fetchDataURL: "${contextPath}/api/country/spec-list"
        });

    function ListGrid_Bank_refresh() {
        ListGrid_Bank.invalidateCache();
    }

    function ListGrid_Bank_edit() {
        var record = ListGrid_Bank.getSelectedRecord();

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
            DynamicForm_Bank.clearValues();
            DynamicForm_Bank.editRecord(record);
            Window_Bank.show();
        }
    }

    function ListGrid_Bank_remove() {
        var record = ListGrid_Bank.getSelectedRecord();

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
                        isc.Button.create(
                            {
                                title: "<spring:message code='global.yes'/>"
                            }),
                        isc.Button.create(
                            {
                                title: "<spring:message code='global.no'/>"
                            })
                    ],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var BankId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/bank/" + BankId,
                                    httpMethod: "DELETE",
                                    callback: function (resp) {
                                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                            ListGrid_Bank_refresh();
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

    var Menu_ListGrid_Bank = isc.Menu.create(
        {
            width: 150,
            data: [
                {
                    title: "<spring:message code='global.form.refresh'/>",
                    icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_Bank_refresh();
                    }
                },
                <sec:authorize access="hasAuthority('C_BANK')">
                {
                    title: "<spring:message code='global.form.new'/>",
                    icon: "pieces/16/icon_add.png",
                    click: function () {
                        DynamicForm_Bank.clearValues();
                        Window_Bank.show();
                    }
                },
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_BANK')">
                {
                    title: "<spring:message code='global.form.edit'/>",
                    icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_Bank_edit();
                    }
                },
                </sec:authorize>

                    <sec:authorize access="hasAuthority('D_BANK')">{
                    title: "<spring:message code='global.form.remove'/>",
                    icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_Bank_remove();
                    }
                }
                </sec:authorize>
            ]
        });

    var DynamicForm_Bank = isc.DynamicForm.create(
        {
            wrapItemTitles: false,
            width: 700,
            height: "100%",
            titleWidth: "100",
            numCols: 2,
            padding: 10,
            fields: [
                {
                    name: "id",
                    hidden: true
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='bank.nameFa'/>",
                    width: "100%",
                    colSpan: 1,
                    required: true, errorOrientation: "bottom",
                    titleColSpan: 1,
                    keyPressFilter: "^[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F|0-9 ]",
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='bank.nameEn'/>",
                    width: "100%",
                    colSpan: 1,
                    required: true, errorOrientation: "bottom",
                    titleColSpan: 1,
                    keyPressFilter: "^[U+0061-|0-9 ]",
                },
                {
                    name: "address",
                    title: "<spring:message code='bank.address'/>",
                    width: "100%",
                    colSpan: 1,
                    required: true, errorOrientation: "bottom",
                    titleColSpan: 1,
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },
                {
                    name: "coreBranch",
                    title: "<spring:message code='bank.coreBranch'/>",
                    width: "100%",
                    colSpan: 1,
                    required: true, errorOrientation: "bottom",
                    titleColSpan: 1,
                    valueMap:
                        {
                            "core": "<spring:message code='bank.coreBranch.centralOffice'/>",
                            "branch": "<spring:message code='bank.coreBranch.branch'/>"
                        },
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },
                {
                    name: "countryId",
                    title: "<spring:message code='country'/>",
                    type: 'long',
                    width: "100%",
                    required: true, errorOrientation: "bottom",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_Country_IN_BANK,
                    displayField: "name",
                    colSpan: 1,
                    titleColSpan: 1,
                    valueField: "id",
                    pickListWidth: 500,
                    pickListHeight: 300,
                    pickListProperties:
                        {
                            showFilterEditor: true
                        },
                    pickListFields: [
                        {
                            name: "id",
                            width: "10%",
                            align: "center",
                            colSpan: 1,
                            titleColSpan: 1,
                            hidden: true
                        },
                        {
                            name: "nameFA",
                            width: "10%",
                            align: "center",
                            colSpan: 1,
                            titleColSpan: 1
                        },
                        {
                            name: "nameEN",
                            width: "10%",
                            align: "center",
                            colSpan: 1,
                            titleColSpan: 1
                        }],
                    validators: [
                        {
                            type: "required",
                            validateOnChange: true
                        }]
                },
                {
                    type: "RowSpacerItem"
                }
            ]
        });

    var ToolStripButton_Bank_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Bank_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_BANK')">
    var ToolStripButton_Bank_Add = isc.ToolStripButtonAdd.create({
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Bank.clearValues();
            Window_Bank.show();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_BANK')">
    var ToolStripButton_Bank_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_Bank_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_BANK')">
    var ToolStripButton_Bank_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Bank_remove();
        }
    });
    </sec:authorize>

    var HLayout_Bank_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                isc.ToolStrip.create(
                    {
                        width: "100%",
                        members: [
                            <sec:authorize access="hasAuthority('C_BANK')">
                            ToolStripButton_Bank_Add,
                            </sec:authorize>

                            <sec:authorize access="hasAuthority('U_BANK')">
                            ToolStripButton_Bank_Edit,
                            </sec:authorize>

                            <sec:authorize access="hasAuthority('D_BANK')">
                            ToolStripButton_Bank_Remove,
                            </sec:authorize>

                            isc.ToolStrip.create(
                                {
                                    width: "100%",
                                    align: "left",
                                    border: '0px',
                                    members: [
                                        ToolStripButton_Bank_Refresh,
                                    ]
                                })

                        ]
                    })
            ]
    });

    var IButton_Bank_Save = isc.IButtonSave.create(
        {
            click: function () {
                DynamicForm_Bank.validate();
                if (DynamicForm_Bank.hasErrors())
                    return;

                var data = DynamicForm_Bank.getValues();
                var method = "PUT";
                if (data.id == null)
                    method = "POST";

                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/bank/",
                        httpMethod: method,
                        data: JSON.stringify(data),
                        callback: function (resp) {
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_Bank_refresh();
                                Window_Bank.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        }
                    }));
            }
        });

    var Window_Bank = isc.Window.create(
        {
            title: "<spring:message code='bank.title'/> ",
            width: 700,
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
                DynamicForm_Bank,
                isc.HLayout.create({
                    width: "100%",
                    height: "20",
                    layoutMargin: 5,
                    membersMargin: 5,
                    autoDraw: false,
                    isModal: true,
                    showModalMask: true,
                    align: nicico.CommonUtil.getAlignByLangReverse(),
                    members: [
                        IButton_Bank_Save,
                        isc.IButtonCancel.create({
                            click: function () {
                                Window_Bank.close();
                            }
                        })
                    ]
                })
            ]
        });

    var ListGrid_Bank = isc.ListGrid.create(
        {
            showFilterEditor: true,
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Bank,
            contextMenu: Menu_ListGrid_Bank,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "bankCode",
                    title: "<spring:message code='bank.bankCode'/>",
                    width: "10%",
                    align: "center", showIf: "false",
                },
                {
                    name: "nameFA",
                    title: "<spring:message code='bank.nameFa'/>",
                    width: "10%",
                    align: "center"
                },
                {
                    name: "nameEN",
                    title: "<spring:message code='bank.nameEn'/>",
                    width: "10%",
                    align: "center"
                },
                {
                    name: "coreBranch",
                    title: "<spring:message code='bank.coreBranch'/>",
                    width: "10%",
                    align: "center"
                },
                {
                    name: "country.name",
                    title: "<spring:message code='country'/>",
                    width: "10%",
                    align: "center"
                },
                {
                    name: "address",
                    title: "<spring:message code='bank.address'/>",
                    width: "20%",
                    align: "center"
                }],
            autoFetchData: true
        });

    var HLayout_Bank_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_Bank
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_Bank_Actions, HLayout_Bank_Grid
        ]
    });