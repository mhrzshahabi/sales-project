<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

//<script>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

    var RestDataSource_Country = isc.MyRestDataSource.create(
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
                    title: "<spring:message code='country.code'/>",
                    width: 200,
                },
                {
                    name: "nameFa",
                    title: "<spring:message code='country.nameFa'/>",
                    width: 200
                },
                {
                    name: "nameEn",
                    title: "<spring:message code='country.nameEn'/>",
                    width: 200
                },],

            fetchDataURL: "${contextPath}/api/country/spec-list"
        });


    function ListGrid_Country_refresh() {
        ListGrid_Country.invalidateCache();
    }


    function ListGrid_Country_edit() {
        var record = ListGrid_Country.getSelectedRecord();

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
            DynamicForm_Country.editRecord(record);
            Window_Country.show();
        }
    }


    function ListGrid_Country_remove() {
        var record = ListGrid_Country.getSelectedRecord();
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
                            title: "<spring:message code = 'global.yes'/>"

                        }), isc.IButtonCancel.create(
                        {
                            title: "<spring:message code='global.no'/>"
                        })],
                    buttonClick: function (button, index) {
                        this.hide();
                        if (index == 0) {
                            var CountryId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/country/" + record.id,
                                    httpMethod: "DELETE",
                                    callback: function (resp) {
                                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                            ListGrid_Country_refresh();
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

    var Menu_ListGrid_Country = isc.Menu.create({
        width: 150,
        data: [
            {
                title: "<spring:message code='global.form.refresh'/>", icon: "pieces/16/refresh.png",
                click: function () {
                    ListGrid_Country_refresh();
                }
            },
            <sec:authorize access="hasAuthority('C_COUNTRY')">
            {
                title: "<spring:message code='global.form.new'/>", icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_Country.clearValues();
                    Window_Country.show();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_COUNTRY')">
            {
                title: "<spring:message code='global.form.edit'/>", icon: "pieces/16/icon_edit.png",
                click: function () {
                    ListGrid_Country_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_COUNTRY')">
            {
                title: "<spring:message code='global.form.remove'/>", icon: "pieces/16/icon_delete.png",
                click: function () {
                    ListGrid_Country_remove();
                }
            }
            </sec:authorize>
        ]
    });

    var DynamicForm_Country = isc.DynamicForm.create(
        {
            width: 650,
            height: "100%",
            titleWidth: "100",
            requiredMessage: "<spring:message code='validator.field.is.required'/>",
            numCols: 2,
            fields: [
                {
                    name: "id",
                    hidden: true,
                },
                {
                    type: "RowSpacerItem"
                },
                {
                    name: "code",
                    title: "<spring:message code='country.code'/>",
                    width: 500,
                    colSpan: 1,
                    required: true,
                    keyPressFilter: "[0-9]",
                    length: "15",
                    titleColSpan: 1,
                    hint: "<spring:message code='Material.digit'/>",
                    showHintInField: true, showIf: "false",
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    name: "nameFa",
                    title: "<spring:message code='country.nameFa'/>",
                    width: 500,
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
                    title: "<spring:message code='country.nameEn'/>",
                    width: 500,
                    colSpan: 1,
                    required: true,
                    keyPressFilter: "[a-z|A-Z|0-9.]",
                    titleColSpan: 1,
                    validators: [
                    {
                        type:"required",
                        validateOnChange: true
                    }]
                },
                {
                    type: "RowSpacerItem"
                },
            ]
        });

    var ToolStripButton_Country_Refresh = isc.ToolStripButtonRefresh.create({
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_Country_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_COUNTRY')">
    var ToolStripButton_Country_Add = isc.ToolStripButtonAdd.create({
        title: "<spring:message code='global.form.new'/>",
        click: function () {
            DynamicForm_Country.clearValues();
            Window_Country.show();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_COUNTRY')">
    var ToolStripButton_Country_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            DynamicForm_Country.clearValues();
            ListGrid_Country_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_COUNTRY')">
    var ToolStripButton_Country_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_Country_remove();
        }
    });
    </sec:authorize>

    var ToolStrip_Actions_Country = isc.ToolStrip.create(
        {
            width: "100%",
            members: [
                <sec:authorize access="hasAuthority('C_COUNTRY')">
                ToolStripButton_Country_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_COUNTRY')">
                ToolStripButton_Country_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_COUNTRY')">
                ToolStripButton_Country_Remove,
                </sec:authorize>

                isc.ToolStrip.create(
                    {
                        width: "100%",
                        align: "left",
                        border: '0px',
                        members: [
                            ToolStripButton_Country_Refresh,
                        ]
                    })

            ]
        });

    var HLayout_Country_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_Country
            ]
    });

    var IButton_Country_Save = isc.IButtonSave.create(
        {
            top: 260,
            layoutMargin: 5,
            membersMargin: 5,
            width: 120,
            title: "<spring:message code='global.form.save'/>",
            icon: "pieces/16/save.png",
            click: function () {
                DynamicForm_Country.validate();
                if (DynamicForm_Country.hasErrors())
                    return;
                var data = DynamicForm_Country.getValues();
                var method = "PUT";
                if (data.id == null)
                    method = "POST";
                isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                    {
                        actionURL: "${contextPath}/api/country/",
                        httpMethod: method,
                        data: JSON.stringify(data),
                        callback: function (resp) {
                            if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                isc.say("<spring:message code='global.form.request.successful'/>");
                                ListGrid_Country_refresh();
                                Window_Country.close();
                            }
                            else
                                isc.say(RpcResponse_o.data);
                        }
                    }));
            }
        });

    var CountryCancelBtn = isc.IButtonCancel.create({
        top: 260,
        layoutMargin: 5,
        membersMargin: 5,
        width: 120,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            Window_Country.close();
        }
    });

    var HLayout_Country_IButton = isc.HLayout.create({
        width: 650,
        height: "100%",
        layoutMargin: 10,
        membersMargin: 5,
        textAlign: "center",
        align: "center",
        members: [
            IButton_Country_Save,
            CountryCancelBtn
        ]
    });

    var VLayout_saveButton_country = isc.VLayout.create({
        width: 650,
        textAlign: "center",
        align: "center",
        members: [
            HLayout_Country_IButton
        ]
    });

    var Window_Country = isc.Window.create(
        {
            title: "<spring:message code='country.title'/> ",
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
                DynamicForm_Country,
                VLayout_saveButton_country
            ]
        });

    var ListGrid_Country = isc.ListGrid.create(
        {
            width: "100%",
            height: "100%",
            dataSource: RestDataSource_Country,
            contextMenu: Menu_ListGrid_Country,
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
                    title: "<spring:message code='country.code'/>",
                    width: "10%",
                    align: "center", showIf: "false",
                },
                {
                    name: "nameFa",
                    title: "<spring:message code='country.nameFa'/>",
                    width: "10%",
                    align: "center"
                },
                {
                    name: "nameEn",
                    title: "<spring:message code='country.nameEn'/>",
                    width: "10%",
                    align: "center"
                },],
            autoFetchData: true
        });

    var HLayout_Country_Grid = isc.HLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                ListGrid_Country
            ]
        });

    isc.VLayout.create(
        {
            width: "100%",
            height: "100%",
            members: [
                HLayout_Country_Actions, HLayout_Country_Grid
            ]
        });