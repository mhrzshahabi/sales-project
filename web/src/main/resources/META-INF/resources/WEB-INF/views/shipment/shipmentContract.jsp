//<script>

    <%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath"/>

    var RestDataSource_ShipmentContract_In_ShipmentContract = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", title: "id", primaryKey: true, canEdit: false, hidden: true},

                {
                    name: "no",
                    title: "<spring:message code='shipmentContract.no'/>",
                    align: "center",
                    width: "10%",

                },

                {
                    name: "capacity",
                    title: "<spring:message code='shipmentContract.capacity'/>",
                    align: "center",
                    width: "10%",
                    keyPressFilter: "[0-9.]",
                },

                {
                    name: "laycanStart",
                    title: "<spring:message code='shipmentContract.laycanStart'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "laycanEnd",
                    title: "<spring:message code='shipmentContract.laycanEnd'/>",
                    align: "center",
                    width: "10%",
                },

                {
                    name: "dischargeRate",
                    title: "<spring:message code='shipmentContract.dischargeRate'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "demurrage",
                    title: "<spring:message code='shipmentContract.demurrage'/>",
                    align: "center",
                    width: "10%",
                },

                {
                    name: "freight",
                    title: "<spring:message code='shipmentContract.freight'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "bale",
                    title: "<spring:message code='shipmentContract.bale'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "grain",
                    title: "<spring:message code='shipmentContract.grain'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "grossWeight",
                    title: "<spring:message code='shipmentContract.grossWeight'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "vesselName",
                    title: "<spring:message code='shipmentContract.vesselName'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "yearOfBuilt",
                    title: "<spring:message code='shipmentContract.yearOfBuilt'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "imoNo",
                    title: "<spring:message code='shipmentContract.imoNo'/>",
                    align: "center",
                    width: "10%",
                },

                {
                    name: "officialNo",
                    title: "<spring:message code='shipmentContract.officialNo'/>",
                    align: "center",
                    width: "10%",
                    type: "isInteger",

                },

                {
                    name: "loa",
                    title: "<spring:message code='shipmentContract.loa'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "beam",
                    title: "<spring:message code='shipmentContract.beam'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "cranes",
                    title: "<spring:message code='shipmentContract.cranes'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "holds",
                    title: "<spring:message code='shipmentContract.holds'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "hatch",
                    title: "<spring:message code='shipmentContract.hatch'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "classType",
                    title: "<spring:message code='shipmentContract.classType'/>",
                    align: "center",
                    width: "10%",
                },

                {
                    name: "createDate",
                    title: "<spring:message code='shipmentContract.shipmentContractDate'/>",
                    align: "center",
                    width: "10%",
                },

                {
                    name: "shipFlag",
                    title: "<spring:message code='shipment.flag'/>",
                    align: "center",
                    width: "10%",
                },


                {
                    name: "weighingMethodes",
                    title: "<spring:message code='shipmentContract.weighingMethodes'/>",
                    align: "center",
                    width: "10%",
                },

                {
                    name: "dispatch",
                    title: "<spring:message code='shipmentContract.dispatch'/>",
                    align: "center",
                    width: "10%",
                },

            ],
        fetchDataURL: "${contextPath}/api/shipmentContract/spec-list"
    });


    var IButton_ShipmentContract_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            DynamicForm_ShipmentContract.validate();
            if (DynamicForm_ShipmentContract.hasErrors())
                return;
            var data = DynamicForm_ShipmentContract.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest, {
                actionURL: "${contextPath}/api/shipmentContract",
                httpMethod: method,
                data: JSON.stringify(data),
                callback: function (resp) {

                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_ShipmentContract_refresh();
                        Window_ShipmentContract.hide();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));

        }

    });

    var IButton_ShipmentContract_Cancel = isc.IButtonCancel.create({
        top: 260,
        title: "<spring:message code='global.cancel'/>",
        icon: "pieces/16/icon_delete.png",
        click: function () {
            DynamicForm_ShipmentContract.clearValues();
            Window_ShipmentContract.close();
        }
    });


    function ListGrid_ShipmentContract_refresh() {
        ListGrid_ShipmentContract.invalidateCache();
    }


    function ListGrid_ShipmentContract_edit() {
        var record = ListGrid_ShipmentContract.getSelectedRecord();
        if (record == null || record.id == null) {
            isc.Dialog.create({
                message: "<spring:message code='global.grid.record.not.selected'/>",
                icon: "[SKIN]ask.png",
                title: "<spring:message code='global.message'/>",
                buttons: [isc.Button.create({
                    title: "<spring:message code='global.ok'/>"
                })],
                buttonClick: function () {
                    this.hide();
                }
            });
        } else {

            DynamicForm_ShipmentContract.editRecord(record);
            DynamicForm_ShipmentContract.setValue("createDate", new Date(record.createDate));
            Window_ShipmentContract.animateShow();
        }
    }


    function ListGrid_ShipmentContract_remove() {

        var record = ListGrid_ShipmentContract.getSelectedRecord();

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
                            var shipmentContractId = record.id;
                            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,
                                {
                                    actionURL: "${contextPath}/api/shipmentContract/" + shipmentContractId,
                                    httpMethod: "DELETE",
                                    callback: function (resp) {
                                        if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                                            ListGrid_ShipmentContract_refresh();
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


    var Menu_ListGrid_ShipmentContract_In_ShipmentContract = isc.Menu.create({
        width: 150,
        data: [{
            title: "<spring:message code='global.form.refresh'/>",
            icon: "pieces/16/refresh.png",
            click: function () {
                DynamicForm_ShipmentContract.clearValues();
                ListGrid_ShipmentContract.invalidateCache();
            }
        },
            <sec:authorize access="hasAuthority('C_SHIPMENT_CONTRACT')">
            {
                title: "<spring:message code='global.form.new'/>",
                icon: "pieces/16/icon_add.png",
                click: function () {
                    DynamicForm_ShipmentContract.clearValues();
                    Window_ShipmentContract.animateShow();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('U_SHIPMENT_CONTRACT')">
            {
                title: "<spring:message code='global.form.edit'/>",
                icon: "pieces/16/icon_edit.png",
                click: function () {
                    DynamicForm_ShipmentContract.clearValues();
                    ListGrid_ShipmentContract_edit();
                }
            },
            </sec:authorize>

            <sec:authorize access="hasAuthority('D_SHIPMENT_CONTRACT')">
            {
                title: "<spring:message code='global.form.remove'/>",
                icon: "pieces/16/icon_delete.png",
                click: function () {
                    DynamicForm_ShipmentContract.clearValues();
                    ListGrid_ShipmentContract_remove();
                }
            }
            </sec:authorize>
        ]
    });

    var dash = "\n";

    var DynamicForm_ShipmentContract = isc.DynamicForm.create({
        styleName: 'Shipment_style',
        width: "900px",
        height: "100%",
        wrapItemTitles: false,
        autoDraw: false,
        autoFocus: "true",
        titleWidth: "100",
        numCols: 7,
        membersMargin: '5px',
        fields: [{
            name: "id",
            title: "id",
            primaryKey: true,
            canEdit: false,
            hidden: true
        },
            {
                colSpan: 2,
                name: "createDate",
                title: "<spring:message code='shipmentContract.shipmentContractDate'/>",
                width: 430,
                type: "date",
                required: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },


            {
                colSpan: 2,
                name: "capacity",
                title: "<spring:message code='shipmentContract.capacity'/>", //ظرفیت
                align: "right",
                width: "200",
                required: true,
                length: "30",
                keyPressFilter: "[0-9]",
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },

            {
                colSpan: 2,
                name: "loadingRate",
                title: "<spring:message code='shipmentContract.loadingRate'/>", //نرخ بارگیری
                align: "right",
                width: "200",
                length: "30",
                keyPressFilter: "[0-9]"

            },
            {
                name: "dischargeRate",
                title: "<spring:message code='shipmentContract.dischargeRate'/>", //میزان تخلیه
                align: "right",
                colSpan: 2,
                width: "200",
                length: "30",
                keyPressFilter: "[0-9]"

            },
            {
                colSpan: 2,
                name: "demurrage",
                title: "<spring:message code='shipmentContract.demurrage'/>", //جریمه
                align: "right",
                width: "200",
                length: "30",
                keyPressFilter: "[0-9]"
            },
            {
                colSpan: 2,
                name: "freight",
                title: "<spring:message code='shipmentContract.freight'/>", //کرایه
                align: "right",
                width: "200",
                length: "30",
                keyPressFilter: "[0-9]"
            },
            {
                colSpan: 2,
                name: "bale",
                title: "<spring:message code='shipmentContract.bale'/>", //فضای موجود برای محموله های اندازه گیری شده
                align: "right",
                width: "200",
                length: "30",
                keyPressFilter: "[0-9]"

            },
            {
                colSpan: 2,
                name: "grain",
                title: "<spring:message code='shipmentContract.grain'/>", //حداکثر فضای موجود برای محمول
                align: "right",
                width: "200",
                length: "30",
                keyPressFilter: "[0-9]"
            },
            {
                colSpan: 2,
                name: "grossWeight",
                title: "<spring:message code='shipmentContract.grossWeight'/>", //وزن ناخالص/مرطوب
                align: "right",
                width: "200",
                length: "30",
                keyPressFilter: "[0-9]"
            },
            {
                colSpan: 2,
                name: "vesselName",
                title: "<spring:message code='shipmentContract.vesselName'/>", //نام کشتی
                align: "right",
                width: "200",
                length: "30", required: true,
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                colSpan: 2,
                name: "yearOfBuilt",
                title: "<spring:message code='shipmentContract.yearOfBuilt'/>", //سال ساخت
                align: "right",
                keyPressFilter: "[0-9]",
                width: "200",
                length: "4",
            },
            {
                colSpan: 2,
                name: "imoNo",
                title: "<spring:message code='shipmentContract.imoNo'/>", //(IMO)سازمان بین المللی دریایی
                align: "right",
                width: "200",
                length: "30",
            },
            {
                colSpan: 2,
                name: "officialNo",
                title: "<spring:message code='shipmentContract.officialNo'/>", //شماره رسمی
                align: "right",
                width: "200",
                required: true,
                length: "30",
                keyPressFilter: "[0-9]",
                type: "isInteger",
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },
            {
                colSpan: 2,
                name: "loa",
                title: "<spring:message code='shipmentContract.loa'/>", //(LOA)طول ماكزيمم كشتي
                align: "right",
                width: "200",
                length: "30",
                keyPressFilter: "[0-9]"
            },
            {
                colSpan: 2,
                name: "beam",
                title: "<spring:message code='shipmentContract.beam'/>", //(BEAM)عرض ماكزيمم عرش كشتي
                align: "right",
                width: "200",
                length: "4",
                keyPressFilter: "[0-9]"
            },
            {
                colSpan: 2,
                name: "cranes",
                title: "<spring:message code='shipmentContract.cranes'/>", //جرثقیل
                align: "right",
                width: "200",
                length: "30",
            },
            {
                colSpan: 2,
                name: "holds",
                title: "<spring:message code='shipmentContract.holds'/>", //نگه دارنده
                align: "right",
                width: "200",
                length: "30",
            },
            {
                colSpan: 2,
                name: "hatch",
                title: "<spring:message code='shipmentContract.hatch'/>", //انبار كشتي
                align: "right",
                width: "200",
                length: "30",
            },
            {
                colSpan: 2,
                name: "classType",
                title: "<spring:message code='shipmentContract.classType'/>", //نوع کلاس
                align: "right",
                width: "200",
                length: "30",
            },

            {
                align: "right",
                colSpan: 2,
                name: "shipFlag",
                title: "<spring:message code='shipmentContract.countryFlag'/>",
                type: 'text',
                width: "180",
                valueMap: {
                    "IRAN": "<spring:message code='shipment.flag.iran'/>" //بازرسي درافت كشتي
                }
            },
            {
                required: true,
                colSpan: 2,
                align: "right",
                name: "weighingMethodes",
                title: "<spring:message code='shipmentContract.weighingMethodes'/>", //روش توزين
                type: 'text',
                width: "180",
                valueMap: {
                    " draft survey ": "<spring:message code='shipmentContract.draftSurvey'/>" //بازرسي درافت كشتي
                    ,
                    " weighbridge ": "<spring:message code='shipmentContract.weighbridge'/>" //باسكول
                },
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },

            {
                name: "no",
                title: "<spring:message code='shipmentContract.no'/>", //شماره
                align: "right",
                colSpan: 2,
                width: "200",
                required: true,
                length: "30",
                validators: [{
                    type:"required",
                    validateOnChange: true
                }]
            },

            {
                type: "Header",
                defaultValue: dash
            },


        ]
    });

    var ToolStripButton_ShipmentContract_Refresh = isc.ToolStripButtonRefresh.create({
        icon: "[SKIN]/actions/refresh.png",
        title: "<spring:message code='global.form.refresh'/>",
        click: function () {
            ListGrid_ShipmentContract_refresh();
        }
    });

    <sec:authorize access="hasAuthority('C_SHIPMENT_CONTRACT')">
    var ToolStripButton_ShipmentContract_Add = isc.ToolStripButtonAdd.create({
        icon: "[SKIN]/actions/add.png",
        title: "<spring:message code='global.form.new'/>",
        click: function () {

            DynamicForm_ShipmentContract.clearValues();
            Window_ShipmentContract.animateShow();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('U_SHIPMENT_CONTRACT')">
    var ToolStripButton_ShipmentContract_Edit = isc.ToolStripButtonEdit.create({
        icon: "[SKIN]/actions/edit.png",
        title: "<spring:message code='global.form.edit'/>",
        click: function () {
            ListGrid_ShipmentContract_edit();
        }
    });
    </sec:authorize>

    <sec:authorize access="hasAuthority('D_SHIPMENT_CONTRACT')">
    var ToolStripButton_ShipmentContract_Remove = isc.ToolStripButtonRemove.create({
        icon: "[SKIN]/actions/remove.png",
        title: "<spring:message code='global.form.remove'/>",
        click: function () {
            ListGrid_ShipmentContract_remove();
        }
    });
    </sec:authorize>


    var ToolStrip_Actions_ShipmentContract = isc.ToolStrip.create(
        {
            width: "100%",
            membersMargin: 5,
            members: [
                <sec:authorize access="hasAuthority('C_SHIPMENT_CONTRACT')">
                ToolStripButton_ShipmentContract_Add,
                </sec:authorize>

                <sec:authorize access="hasAuthority('U_SHIPMENT_CONTRACT')">
                ToolStripButton_ShipmentContract_Edit,
                </sec:authorize>

                <sec:authorize access="hasAuthority('D_SHIPMENT_CONTRACT')">
                ToolStripButton_ShipmentContract_Remove,
                </sec:authorize>

                isc.ToolStrip.create(
                    {
                        width: "100%",
                        align: "left",
                        border: '0px',
                        members: [
                            ToolStripButton_ShipmentContract_Refresh,
                        ]
                    })

            ]
        });

    var HLayout_ShipmentContract_Actions = isc.HLayout.create({
        width: "100%",
        members:
            [
                ToolStrip_Actions_ShipmentContract
            ]
    });

    var Window_ShipmentContract = isc.Window.create({
        title: "<spring:message code='charter.title'/>",
        width: 900,
        height: "400",
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
            DynamicForm_ShipmentContract,
            isc.HLayout.create({
                align: "center",
                width: "100%",
                members:
                    [
                        IButton_ShipmentContract_Save,
                        isc.Label.create({width: 5,}),
                        IButton_ShipmentContract_Cancel
                    ]
            })
        ]
    });

    var ListGrid_ShipmentContract = isc.ListGrid.create({
        width: "100%",
        height: "100%",
        dataSource: RestDataSource_ShipmentContract_In_ShipmentContract,
        contextMenu: Menu_ListGrid_ShipmentContract_In_ShipmentContract,
        fields:
            [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true,
                    width: "10%",
                },
                {
                    name: "no",
                    title: "<spring:message code='shipmentContract.no'/>",
                    align: "center",
                    width: "10%",
                },
                {
                    name: "capacity",
                    title: "<spring:message code='shipmentContract.capacity'/>",
                    align: "center",
                    width: "10%"
                },

                {

                    name: "vesselName",
                    title: "<spring:message code='shipmentContract.vesselName'/>", //نام کشتی
                    align: "center",
                    width: "10%",

                },
            ],
        sortField: "id",
        autoFetchData: true
    });


    var HLayout_ShipmentContract_Grid = isc.HLayout.create({
        width: "100%",
        height: "100%",
        members: [
            ListGrid_ShipmentContract
        ]
    });

    isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
            HLayout_ShipmentContract_Actions, HLayout_ShipmentContract_Grid
        ]
    });
