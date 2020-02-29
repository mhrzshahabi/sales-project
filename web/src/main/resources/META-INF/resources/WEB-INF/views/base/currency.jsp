<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Currency = isc.MyRestDataSource.create(
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
                    name: "code",
                    title: "<spring:message code='currency.code'/>",
                    width: 200
                },
                {
                    name: "symbol",
                    title: "<spring:message code='currency.symbol'/>",
                    width: 200
                },
                {
                    name: "nameEn",
                    title: "<spring:message code='currency.nameLatin'/>",
                    width: 200
                },
                {
                    name: "nameFa",
                    title: "<spring:message code='currency.nameFa'/>",
                    width: 200
                },],

            fetchDataURL: "${contextPath}/api/currency/spec-list"
        });

    function ListGrid_Currency_refresh() {
        ListGrid_Currency.invalidateCache();
    }

    function ListGrid_Currency_edit() {
        var record = ListGrid_Currency.getSelectedRecord();

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
            DynamicForm_Currency.editRecord(record);
            Window_Currency.show();
        }
    }


    function ListGrid_Currency_remove() {

        var record = ListGrid_Currency.getSelectedRecord();

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
                    buttons: [isc.IButtonSave.create(
                        {
                            title: "<spring:message code = 'global.yes'/> "

                        }), isc.IButtonCancel.create(
                        {
                            title: "<spring:message code='global.no'/>"
                        })],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var CurrencyId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/currency/" + record.id,
                                    httpMethod: "DELETE",
                                    callback: function (resp) {
                                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                            ListGrid_Currency_refresh();
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

    var Menu_ListGrid_Currency = isc.Menu.create(
        {
            width: 150,
            data: [
                {
                    title: "<spring:message code='global.form.refresh'/>",
                    icon: "pieces/16/refresh.png",
                    click: function () {
                        ListGrid_Currency_refresh();
                    }
                },
                <sec:authorize access="hasAuthority('C_CURRENCY')">
                {
                    title: "<spring:message code='global.form.new'/>",
                    icon: "pieces/16/icon_add.png",
                    click: function () {
                        DynamicForm_Currency.clearValues();
                        Window_Currency.show();
                    }
                },
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_CURRENCY')">
                {
                    title: "<spring:message code='global.form.edit'/>",
                    icon: "pieces/16/icon_edit.png",
                    click: function () {
                        ListGrid_Currency_edit();
                    }
                },
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_CURRENCY')">
                {
                    title: "<spring:message code='global.form.remove'/>",
                    icon: "pieces/16/icon_delete.png",
                    click: function () {
                        ListGrid_Currency_remove();
                    }
                }
                </sec:authorize>
            ]
        });

    var DynamicForm_Currency = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        titleWidth: "100",
        numCols: 2,
        fields:
            [
                {name: "id", hidden: true,},
                {type: "RowSpacerItem"},
                {
                    name: "code",
                    title: "<spring:message code='currency.code'/>",
                    width: 400,
                    colSpan: 1,
                    titleColSpan: 1,
                    required: true,
                    keyPressFilter: "[0-9]", length: "15", showIf: "false",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "nameFa",
                    title: "<spring:message code='currency.nameFa'/>",
                    width: 400,
                    colSpan: 1,
                    required: true,
                    titleColSpan: 1,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "nameEn",
                    title: "<spring:message code='currency.nameLatin'/>",
                    width: 400, keyPressFilter: "[a-z|A-Z|0-9.]",
                    colSpan: 1,
                    required: true,
                    wrapTitle: false,
                    titleColSpan: 1,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "symbol",
                    title: "<spring:message code='currency.symbol'/>",
                    width: 400,
                    colSpan: 1,
                    titleColSpan: 1
                },
                {
                    type: "RowSpacerItem"
                },
            ]
    });

    var ToolStripButton_Currency_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Currency_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_CURRENCY')">
    var ToolStripButton_Currency_Add = isc.ToolStripButtonAdd.create({
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Currency.clearValues();
            Window_Currency.show();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_CURRENCY')">
    var ToolStripButton_Currency_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Currency.clearValues();
            ListGrid_Currency_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_CURRENCY')">
    var ToolStripButton_Currency_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Currency_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_Currency = isc.ToolStrip.create({
        width: "100%",
        members:
            [
                <sec:authorize access="hasAuthority('C_CURRENCY')">
                ToolStripButton_Currency_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_CURRENCY')">
                ToolStripButton_Currency_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_CURRENCY')">
                ToolStripButton_Currency_Remove,
                </sec:authorize>

                isc.ToolStrip.create({
                    width: "100%",
                    align: "left",
                    border: '0px',
                    members: [
                        ToolStripButton_Currency_Refresh,
                    ]
                })

            ]
    });

    var HLayout_Currency_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Currency
            ]
    });

    var IButton_Currency_Save = isc.IButtonSave.create(
        {
            top: 260,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {
                DynamicForm_Currency.validate();
                if (DynamicForm_Currency.hasErrors())
                    return;

                var data = DynamicForm_Currency.getValues();
                var method = "PUT";
                if (data.id == null)
                    method = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/currency/",
                        httpMethod: method,
                        data: JSON.stringify(data),
                        callback: function (resp) {
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_Currency_refresh();
                                Window_Currency.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        }
                    }));
            }
        });

    var Window_Currency = isc.Window.create(
        {
            title: "<spring:message code='currency.title'/> ",
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
            items: [
                DynamicForm_Currency,
                isc.HLayout.create(
                    {
                   layoutMargin: 10,
                    membersMargin: 5,
                    align: "center",
                    width: "100%",
                        members: [
                            IButton_Currency_Save,
                            isc.Label.create(
                                {
                                    width: 5,
                                }),
                            isc.IButtonCancel.create(
                                {
                                    title: "<spring:message code='global.cancel'/>",
                                    width: 100,
                                    icon: "pieces/16/icon_delete.png",
                                    orientation: "vertical",
                                    click: function () {
                                        Window_Currency.close();
                                    }
                                })
                        ]
                    })
            ]
        });

    var ListGrid_Currency = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Currency,
            contextMenu: Menu_ListGrid_Currency,
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    hidden: true
                },
                {
                    name: "code",
                    title: "<spring:message code='currency.code'/>",
                    width: "10%",
                    align: "center", showIf: "false",
                },
                {
                    name: "symbol",
                    title: "<spring:message code='currency.symbol'/>",
                    width: "10%",
                    align: "center"
                },
                {
                    name: "nameEn",
                    title: "<spring:message code='currency.nameLatin'/>",
                    width: "10%",
                    align: "center"
                },
                {
                    name: "nameFa",
                    title: "<spring:message code='currency.nameFa'/>",
                    width: "10%",
                    align: "center"
                },],
            autoFetchData: true
        });

    var HLayout_Currency_Grid = isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                ListGrid_Currency
            ]
        });

    isc.VLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                HLayout_Currency_Actions, HLayout_Currency_Grid
            ]
        });